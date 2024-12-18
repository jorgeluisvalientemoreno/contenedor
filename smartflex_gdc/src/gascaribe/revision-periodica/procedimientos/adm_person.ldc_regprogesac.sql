CREATE OR REPLACE procedure      adm_person.LDC_REGPROGESAC(inuContrato in  pr_product.subscription_id%TYPE,
										   inuTelefono in LDC_PROGEN_SAC_RP.TELEFONO_CONTACTO%TYPE)
   IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.
  Nombre del Servicio: LDC_REGPROGESAC
  Descripcion: procedimiento para realizar un registro en la tabla

    Autor    : HORBATH
    Caso     : 234
    Fecha    : 15/07/2020

    Historia de Modificaciones

   DD-MM-YYYY    <Autor>.              Modificacion
   -----------  -------------------    -------------------------------------
   24/04/2024    PACOSTA               OSF-2596: Se crea el objeto en el esquema adm_person 
   14/01/2021    DSALTARIN             650: SE AGREGA FECHA DE REGISTRO
    ******************************************************************/

  nuProducto number;
  valexiste number;
  numerror   NUMBER;
  sbmessage  VARCHAR2(2000);

	PRAGMA AUTONOMOUS_TRANSACTION;
  cursor cuProducto (NUCONTRATO NUMBER) is
        select product_id from pr_product
		where product_type_id=7014
		and  subscription_id=NUCONTRATO;

	cursor CUEXISTE(NUPRODUCTI_ID NUMBER) is
			select 1
			from LDC_PROGEN_SAC_RP
			where PRODUCT_ID= NUPRODUCTI_ID ;



BEGIN


	OPEN cuProducto(inuContrato);
	FETCH cuProducto INTO nuProducto;
	CLOSE cuProducto;

	OPEN CUEXISTE(nuProducto);
	FETCH CUEXISTE INTO valexiste;
	CLOSE CUEXISTE;

	IF nvl(valexiste,0) <> 1 AND fblaplicaentregaxcaso('0000234')  THEN

	INSERT INTO LDC_PROGEN_SAC_RP(PROGEN_SAC_RP, CONTRATO, PRODUCT_ID, TELEFONO_CONTACTO, ESTADO, FECHA_REGISTRO)
                      VALUES (SEQ_PROGEN_SAC_RP.nextval, inuContrato, nuProducto, inuTelefono, 'P', SYSDATE);

	commit;

	END IF;



EXCEPTION
    when others then
		errors.geterror(numerror, sbmessage);
		ut_trace.trace(numerror || ' - ' || sbmessage);
		Errors.setError;
END LDC_REGPROGESAC;
/
PROMPT Otorgando permisos de ejecucion a LDC_REGPROGESAC
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_REGPROGESAC', 'ADM_PERSON');
END;
/