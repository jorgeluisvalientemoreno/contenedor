CREATE OR REPLACE PROCEDURE adm_person.ldc_certificate_rp (inuProduct_id    pr_certificate.product_id%type,
                                                inuContrato_id   ldc_certificados_oia.id_contrato%type,
                                                idtFechaRevision pr_certificate.register_date%type)
IS

/***************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

   PROCEDIMIENTO : LDCI_PROUPDOBSTATUSCERTOIAWS
   AUTOR : 
   FECHA : 
   DESCRIPCION : 

     Parametros de Entrada

     Parametros de Salida

   Historia de Modificaciones
   Autor       Fecha        Descripcion.

  Horbath		27/12/2020	caso806: Se modifica la logica para que permita calcular la próxima fecha de RP si aplica el vacio interno.	
   ***************************************************************************/

    nuSeq           number;
    nuMesesNoti     number := dald_parameter.fnuGetNumeric_Value('LDC_MESES_RP');
    nuMesesCert     number := dald_parameter.fnuGetNumeric_Value('LDC_MESES_VALIDEZ_CERT');
    nuDiasMin       number := dald_parameter.fnuGetNumeric_Value('LDC_DIAS_MINIMO_RP');
    dtFechaFinRP    date;
    dtFechaMaxNoti  date;
    dtFechaMinNoti  date;
    dtFechaSusp     date;
    nuCont          number(4) := 0;
    nuContrato      ldc_certificados_oia.id_contrato%type;
    nuExiste        number(1);
	sbValApliVacio  LDC_PLAZOS_CERT.VACIOINTERNO%type;-- caso:806
	sbAplicaVacio	varchar2(1) := DALDC_PARAREPE.FSBGETPARAVAST('ACT_FECHA_VACIO_INTERNO',null);-- caso:806	

    CURSOR cuExiste(nuProducto LDC_PLAZOS_CERT.id_producto%type)
    IS
        SELECT 1
        FROM LDC_PLAZOS_CERT
        WHERE id_producto = nuProducto;

	CURSOR cuValApliVacio(nuProducto LDC_PLAZOS_CERT.id_producto%type) -- caso:806
    IS
        select nvl(VACIOINTERNO, 'N') 
		from LDC_PLAZOS_CERT 
		where ID_PRODUCTO=nuProducto;

BEGIN

    nuContrato := inuContrato_id;

    IF inuContrato_id IS NULL THEN
        nuContrato := pktblservsusc.fnugetsesususc(inuProduct_id);
    END IF;
	--INicio caso: 806
	OPEN cuValApliVacio(inuProduct_id);
    FETCH cuValApliVacio INTO sbValApliVacio;
    CLOSE cuValApliVacio;

	IF sbValApliVacio= 'S' and sbAplicaVacio = 'S'  THEN

		nuMesesCert := DALDC_PARAREPE.FNUGETPAREVANU('MESES_ACT_VACIO_INTERNO',null);

	END IF;
	--Fin caso: 806


    if idtFechaRevision is NOT null then

        /*Ubica la fecha de registro del certificado N meses adelante
        para empezar a devolverse y calcular la fecha minima
        y maxima en que se debe notificar al usuario
        que debe presentar el certificado de revision*/
        dtFechaFinRP := ADD_MONTHS(idtFechaRevision,nuMesesCert);

        /*A la fecha final de la revision se le restan nuMesesNoti para ubicarnos
        en los N meses atras en los que se notifica al usuario que pronto le vencera
        el certificado de revision.
        */
        --dtFechaMaxNoti := TRUNC(ADD_MONTHS(dtFechaFinRP,-1 * nuMesesNoti));
        dtFechaMinNoti := LAST_DAY(ADD_MONTHS(dtFechaFinRP,-1 * nuMesesNoti));

        --Busca el dia habil en caso de que el ultimo dia sea festivo
        --y/o fin de semana
        WHILE NOT pkHolidayMgr.fboIsNonHoliday(dtFechaMinNoti - nuCont) LOOP
          --dbms_output.put_Line('nuCont:'||nuCont);
          nuCont := nuCont + 1;
        END LOOP;

        --Ultimo dia habil del mes
        dtFechaMinNoti := dtFechaMinNoti - nuCont;

        --Ultimo dia del mes
        dtFechaMaxNoti := LAST_DAY(dtFechaFinRP);

        nuCont := 0;

        --Busca el dia habil en caso de que el ultimo dia sea festivo
        --y/o fin de semana
        WHILE NOT pkHolidayMgr.fboIsNonHoliday(dtFechaMaxNoti - nuCont) LOOP
          --dbms_output.put_Line('nuCont:'||nuCont);
          nuCont := nuCont + 1;
        END LOOP;

        --Ultimo dia habil del mes
        dtFechaMaxNoti := dtFechaMaxNoti - nuCont;

        --Fecha para notificar la suspension
        dtFechaSusp := dtFechaMaxNoti - nuDiasMin;
    else
        dtFechaMaxNoti := null;
        dtFechaSusp := null;
        dtFechaMinNoti := null;
    end if;

    OPEN cuExiste(inuProduct_id);
    FETCH cuExiste INTO nuExiste;
    CLOSE cuExiste;

    IF nuExiste = 1 AND idtFechaRevision IS NOT NULL THEN -- Team: 3312, 3326 - Se a?ade condicion que valida que la fecha no sea nula
        UPDATE LDC_PLAZOS_CERT                            -- para que no se actualicen las fechas con NULL
        SET    PLAZO_MIN_REVISION = dtFechaMinNoti,
               PLAZO_MIN_SUSPENSION = dtFechaSusp,
               PLAZO_MAXIMO = dtFechaMaxNoti
        WHERE  ID_PRODUCTO = inuProduct_id;

    ELSIF nuExiste is null then
        --Inserta los datos del producto y del contrato para los plazos de revision periodica
        INSERT INTO LDC_PLAZOS_CERT
                    (PLAZOS_CERT_ID,
                     ID_CONTRATO,
                     ID_PRODUCTO,
                     PLAZO_MIN_REVISION,
                     PLAZO_MIN_SUSPENSION,
                     PLAZO_MAXIMO)
             VALUES (LDC_SEQ_PLAZOS_CERT.nextval,
                     nuContrato,
                     inuProduct_id,
                     dtFechaMinNoti,
                     dtFechaSusp,
                     dtFechaMaxNoti);
    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END ldc_certificate_rp;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_CERTIFICATE_RP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CERTIFICATE_RP', 'ADM_PERSON'); 
END;
/
