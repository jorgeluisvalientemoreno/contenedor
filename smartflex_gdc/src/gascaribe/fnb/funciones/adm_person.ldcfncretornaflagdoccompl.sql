CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDCFNCRETORNAFLAGDOCCOMPL" (nupasolicitud NUMBER) RETURN NUMBER IS
/************************************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  ldcfncretornaflagdoccompl
    Descripcion :  Retorna flag de documentacion completa
	Ticket		: 200-2180
    Autor       : Elkin Alvarez
    Fecha       : 22-11-2018

**********************************************************************************************/
sbflag             mo_motive.custom_decision_flag%TYPE;
sbactivavalidacion ld_parameter.value_chain%TYPE;
sbmensaje          VARCHAR2(10000);
eexception         EXCEPTION;
BEGIN
 -- Obtenemos valor del parametro para ver si aplica para la gasera
 sbactivavalidacion := dald_parameter.fsbGetValue_Chain('PARAM_VALOR_APLICA',NULL);
 IF sbactivavalidacion IS NULL THEN
  sbmensaje := 'Debe definir valor para el parametro : PARAM_VALOR_APLICA en la forma LDPAR.';
  RAISE eexception;
 END IF;
 -- Validamos con parametro si la solucion aplica para la empresa
 IF TRIM(sbactivavalidacion) = 'S' THEN
  -- Obtenemos valor del campo documentaci?n completa
  BEGIN
   SELECT nvl(m.custom_decision_flag,'N') INTO sbflag
     FROM mo_motive m
    WHERE m.package_id = nupasolicitud;
  EXCEPTION
   WHEN no_data_found THEN
    sbmensaje := 'La solicitud : '||to_char(nupasolicitud)||' no tiene motivo asociado.';
    RAISE eexception;
  END;
  IF sbflag = 'N' THEN
   RETURN 1;
  ELSE
   RETURN 0;
  END IF;
 ELSE
  RETURN 0;
 END IF;
EXCEPTION
 WHEN eexception THEN
  raise_application_error(-20000,sbmensaje);
 WHEN OTHERS THEN
  sbmensaje := SQLERRM;
  raise_application_error(-20001,sbmensaje);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCFNCRETORNAFLAGDOCCOMPL', 'ADM_PERSON');
END;
/