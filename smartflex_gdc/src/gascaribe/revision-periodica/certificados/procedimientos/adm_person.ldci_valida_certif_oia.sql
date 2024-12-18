CREATE OR REPLACE PROCEDURE      ADM_PERSON.LDCI_VALIDA_CERTIF_OIA IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_VALIDA_CERTIF_OIA
   Descripcion : Procedimiento que valida que exista un certificado en estado APROBADO en la tabla
                 LDC_CERTIFICADOS_OIA
   Autor       : Sebastian Tapias
   Fecha       : 19-12-2017

   Historia de Modificaciones
   Fecha               Autor                Modificacion
   --------------------------------------------------------------------------------------------------
   16/04/2018          SEBTAP.REQ.2001572   Se comenta logica anterior, se crean cursores, variables
                                            Se crea nueva logica con modificaciones adicionales
                                            Requeridas por el Ing Eduardo Aguera.
   13/06/2018          Eduardo Ag?era       Se cambia l?gica ya que no estaba permitiendo validar cuando
                                            una orden tiene m?s de una inspecci?n relacionada.
   06/08/2018			Josh Brito			    Validación de aplica entrega en los siguientes puntos: Si aplica,
                                 						Se realizara la búsqueda de las causales en la tabla ldc_conf_causal_tipres_cert
                                 						según sea el resultado de inspección.
                                 						Si NO aplica, La validación de las causales según el resultado de inspección será
                                 						realizara como se encuentra actualmente. Con la diferencia que el cursor que
                                 						valida el parámetro, recibirá el código de la causal de la orden y no el resultado de inspección.
                                 						Se modifico el cursor [cu_Certicados] para organizar por fecha de aprobación descendente
                                 						para que en caso que haya más de un registro se tome el ultimo aprobado
   24/04/2024           PACOSTA             OSF-2596: Se retita el llamado al esquema OPEN (open.)                                   
                                            Se crea el objeto en el esquema adm_person                                                         
  ************************************************************************************************************/
  eexeptionerror       EXCEPTION;
  nuorden              or_order.order_id%TYPE;
  sbmensa              VARCHAR2(1000);
  nuCertifOrden        Number;
  nuCertifOrdenFallo   Number;
  nucausalorden        or_order.causal_id%TYPE;
  nuResultIsnpec       ldc_certificados_oia.resultado_inspeccion%TYPE;
  sbParameter          ld_parameter.parameter_id%TYPE := NULL;
  sbStatusCertificado  ldc_certificados_oia.status_certificado%TYPE := NULL;
  nuClassCuasal        ge_causal.class_causal_id%TYPE;
  -- Variable para almacenar el resultado del cursor.
  nuExistParameter     NUMBER := 0;
  nuTab1               number := 0;
  v_query              VARCHAR2(15000);

  -- Cursor obtener clasificacion de la causal
  CURSOR cu_Causal(inucausal NUMBER) IS
    SELECT g.class_causal_id
      FROM ge_causal g
     WHERE g.causal_id = inucausal;

  -- Cursor datos generales LDC_CERTIFICADOS_OIA.
  CURSOR cu_Certicados(inuorden NUMBER) IS
    SELECT certificados_oia_id,
           resultado_inspeccion,
           status_certificado
    FROM(SELECT l.certificados_oia_id,
           l.resultado_inspeccion,
           l.status_certificado
      FROM LDC_CERTIFICADOS_OIA L
     WHERE L.ORDER_ID = inuorden
       AND L.STATUS_CERTIFICADO = dald_parameter.fsbgetvalue_chain('STATUS_CERTIF_OIA')
       ORDER BY L.FECHA_APROBACION DESC)
       WHERE ROWNUM = 1;

  -- Cursor para validar existencia de valores en parametros separados por coma
  CURSOR cu_Parameter(inuvalor    NUMBER,
                      sbParameter ld_parameter.parameter_id%TYPE) IS
    SELECT COUNT(1) CANTIDAD
      FROM DUAL
     WHERE inuvalor IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(sbParameter,
                                                                                       NULL),
                                                      ',')));

BEGIN
  --Obtener el ID de la orden.
  nuorden := or_bolegalizeorder.fnuGetCurrentOrder;

  --Obtener la causal.
  nucausalorden := or_boorder.fnugetordercausal(nuorden);

  -------------------
  --REQ.2001572 -->
  --Observacion. Se comenta logica anterior y se implementa una nueva(con validaciones adicionales).
  -------------------
  /* BEGIN
    SELECT COUNT(1)
      INTO nuCertifOrden
      FROM LDC_CERTIFICADOS_OIA L
     WHERE L.ORDER_ID = nuorden
       AND L.STATUS_CERTIFICADO =
           dald_parameter.fsbgetvalue_chain('STATUS_CERTIF_OIA'); \*ESTADO A*\
    IF nuCertifOrden = 0 THEN
      sbmensa := 'Proceso termino con errores, la orden de trabajo [' ||
                 to_char(nuorden) ||
                 '] NO TIENE un certificado en estado APROBADO';
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                       sbmensa);
      RAISE ex.controlled_error;
    END IF;
  EXCEPTION
    WHEN ex.controlled_error THEN
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con errores, Se presento un error validando el certificado';
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                       sbmensa);
  END;*/

  --Obtenemos datos de la causal.
  OPEN cu_Causal(nucausalorden);
  FETCH cu_Causal INTO nuClassCuasal;
  IF cu_Causal%NOTFOUND THEN
    nuClassCuasal := NULL;
  END IF;
  CLOSE cu_Causal;

  --Si la causal de la orden es de fallo validamos que no tenga un informe de inspecci?n asociado
  IF nuClassCuasal = Dald_parameter.fnuGetNumeric_Value('COD_CAUSAL_FALLO_OIA') THEN

    --Si la causal es de fallo no debe existir un informe de inspeccion relacionado a la orden
    SELECT COUNT(1) INTO nuCertifOrdenFallo
    FROM LDC_CERTIFICADOS_OIA L
    WHERE L.ORDER_ID = nuorden;

    IF nvl(nuCertifOrdenFallo,0) > 0 THEN
      sbmensa := 'Proceso termino con errores, la orden [' ||
                 to_char(nuorden) ||
                 '] tiene informes de inspeccion relacionados. NO se puede legalizar con causal de fallo';
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, sbmensa);
      RAISE ex.controlled_error;
    end if;

  ElsIf nuClassCuasal = Dald_parameter.fnuGetNumeric_Value('COD_CAUSAL_EXITO_OIA') THEN

    --Obtenemos datos del informe de inspecci?n aprobado relacionado con la orden
    OPEN cu_Certicados(nuorden);
    FETCH cu_Certicados INTO nuCertifOrden, nuResultIsnpec, sbStatusCertificado;
    IF cu_Certicados%NOTFOUND THEN
      nuCertifOrden       := NULL;
      nuResultIsnpec      := NULL;
      sbStatusCertificado := NULL;
    END IF;
    CLOSE cu_Certicados;

    --Verificamos si para la orden a legalizar existe un certificado en estado APROBADO
    IF nuCertifOrden is null then
      sbmensa := 'Proceso termino con errores, la orden de trabajo [' || to_char(nuorden) ||
                 '] NO TIENE un certificado en estado APROBADO';
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, sbmensa);
      RAISE ex.controlled_error;
    END IF;

    IF fblAplicaEntrega('OSS_RPS_JGBA_2001997_2') THEN
        select count(1) into nuTab1
          from dba_objects
          where object_name = upper('ldc_conf_causal_tipres_cert');
        IF (nuTab1>0) THEN
          v_query := upper('SELECT COUNT(*)'
                    ||'FROM ldc_conf_causal_tipres_cert '
                    ||'WHERE RESULTADO_INSPECCCION = ' || nuResultIsnpec ||
                    ' AND CAUSAL_ORD = '|| nucausalorden );
          EXECUTE IMMEDIATE v_query into nuExistParameter;
        END IF;

    ELSE
        --Verificamos si la causal con la que se intenta legalizar, concuerda con el resultado de inspeccion.
        IF nuResultIsnpec = 1 THEN
          sbParameter := 'COD_CAUSAL_RESULTADO_INSPEC_1';
        ELSIF nuResultIsnpec = 2 THEN
          sbParameter := 'COD_CAUSAL_RESULTADO_INSPEC_2';
        ELSIF nuResultIsnpec = 3 THEN
          sbParameter := 'COD_CAUSAL_RESULTADO_INSPEC_3';
        ELSIF nuResultIsnpec = 4 THEN
          sbParameter := 'COD_CAUSAL_RESULTADO_INSPEC_4';
        END IF;

        OPEN cu_Parameter(nucausalorden, sbParameter);
        FETCH cu_Parameter INTO nuExistParameter;
        IF cu_Parameter%NOTFOUND THEN
          nuExistParameter := 0;
        END IF;
        CLOSE cu_Parameter;

    END IF;
    IF nuExistParameter = 0 THEN
      sbmensa := 'Proceso termino con errores, la causal [' ||
                 to_char(nucausalorden) ||
                 '] NO concuerda con el resultado de inspeccion [' ||
                 to_char(nuResultIsnpec) || ']';
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                       sbmensa);
      RAISE ex.controlled_error;
    END IF;
  END IF;

EXCEPTION
  WHEN ex.controlled_error THEN
    RAISE;
  WHEN OTHERS THEN
    sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                     sbmensa);
    errors.seterror;
END;
/
PROMPT Otorgando permisos de ejecucion a LDCI_VALIDA_CERTIF_OIA
BEGIN
    pkg_utilidades.praplicarpermisos('LDCI_VALIDA_CERTIF_OIA', 'ADM_PERSON');
END;
/