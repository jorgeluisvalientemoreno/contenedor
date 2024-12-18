CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUREALIZAVENTAWEB" (nuSuscriber   ge_subscriber.subscriber_id%type,
                                                  nuSuscription MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE)
  RETURN NUMBER IS
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : ldc_fnurealizaventaweb
  Descripcion : Funcion que retorna:
                (0) --> Si no existe solicitud con los mismos datos ingresados en el ultimo minuto
                (1) --> Si ya existe una solicitud
                        Si ocurre un error.
  Autor       : Sebastian Tapias.
  Fecha       : 29/09/2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  v_realizaventa NUMBER := 0; -- Variable de Retorno
  vExists        NUMBER := 0;
  CURSOR c_Solicitud IS
    SELECT COUNT(1) PACKAGE_ID
      FROM OPEN.MO_PACKAGES MP
     WHERE REQUEST_DATE > (SELECT (SYSDATE - 1 / (24 * 60)) FROM DUAL)
       AND (MP.SUBSCRIBER_ID, MP.SUBSCRIPTION_PEND_ID) in
           (SELECT MP1.SUBSCRIBER_ID, MP1.SUBSCRIPTION_PEND_ID
              FROM OPEN.MO_PACKAGES MP1
             WHERE MP1.SUBSCRIBER_ID = nuSuscriber
               AND MP1.SUBSCRIPTION_PEND_ID = nuSuscription)
       AND MP.PACKAGE_TYPE_ID =
           Open.Dald_parameter.fnuGetNumeric_Value('TIPO_SOL_VENTA_FNB');

BEGIN
  BEGIN
    -- ABRIR CURSOR
    OPEN c_Solicitud;
    FETCH c_Solicitud
      INTO vExists; -- ASIGNAR VARIABLE
    CLOSE c_Solicitud;
    -- CERRAR CURSOR
    /*Verificamos*/
    IF (vExists > 0) THEN
      v_realizaventa := 1;
    ELSE
      v_realizaventa := 0;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_realizaventa := 0;
  END;
  RETURN v_realizaventa; -- Retornamos la variable.
EXCEPTION
  WHEN OTHERS THEN
    /* En caso de un error inesperado mandaremos tambien 0*/
    RETURN 0;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUREALIZAVENTAWEB', 'ADM_PERSON');
END;
/
