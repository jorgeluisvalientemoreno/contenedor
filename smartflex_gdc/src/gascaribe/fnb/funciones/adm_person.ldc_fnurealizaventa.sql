CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUREALIZAVENTA" (v_solicitud_id mo_packages.package_id%TYPE)
  RETURN NUMBER IS
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : ldc_fnurealizaventa
  Descripcion : Funcion que retorna:
                (1) --> Si la solicitud ingresada es igual a la minima obtenida en el cursor
                (0) --> Si la solicitud ingresada es diferente a la minima obtenida en el cursor.
                        Si no se Obtienen resultados.
                        Si ocurre un error.
  Autor       : Sebastian Tapias.
  Fecha       : 12-06-2017

  ***Variables de Entrada***

  v_solicitud_id -- Ingresa el codigo de la solicitud a consultar.

  ***Variables de Salida***

  v_realizaventa -- Variable de retorno

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  v_realizaventa  NUMBER := 0; -- Variable de Retorno
  vt_solicitud_id mo_packages.package_id%TYPE; -- Varibale temporal para almacenar el resultado de la consulta.
  /*Cursor para obtner la solicitud*/
  CURSOR c_Solicitud IS
    SELECT MIN(PACKAGE_ID) PACKAGE_ID
      FROM MO_PACKAGES
     WHERE REQUEST_DATE =
           (SELECT REQUEST_DATE
              FROM MO_PACKAGES
             WHERE PACKAGE_ID = v_solicitud_id)
       AND (SUBSCRIBER_ID, SUBSCRIPTION_PEND_ID)in
           (SELECT SUBSCRIBER_ID, SUBSCRIPTION_PEND_ID
              FROM MO_PACKAGES
             WHERE PACKAGE_ID = v_solicitud_id)
       AND PACKAGE_TYPE_ID = Dald_parameter.fnuGetNumeric_Value('TIPO_SOL_VENTA_FNB');
       rfc_Solicitud c_Solicitud%rowtype; -- Variable Tipo cursor para obtener los resultados

BEGIN
  BEGIN
    -- ABRIR CURSOR
    OPEN c_Solicitud;
    FETCH c_Solicitud INTO rfc_Solicitud; -- ASIGNAR VARIABLE
    CLOSE c_Solicitud;
    -- CERRAR CURSOR
     vt_solicitud_id := rfc_Solicitud.PACKAGE_ID;
    /*Comparamos la solicitud obtenida con la ingresada a la funcion.*/
    dbms_output.put_line('Comparando Solicitudes...');
    IF vt_solicitud_id <> v_solicitud_id THEN
      dbms_output.put_line('Solicitudes Diferentes');
      v_realizaventa := 0; -- Si son diferentes mando 0
    ELSE
      dbms_output.put_line('Solicitudes Iguales');
      v_realizaventa := 1; -- Si son iguales mando 1
      -- Si son iguales dejo seguir el LOOP en caso de que exista otra.
    END IF;
    /* En caso de que no se generen registros nos aseguramos de mandar 0 */
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_realizaventa := 0;
  END;
  dbms_output.put_line('RETURN: ' || v_realizaventa);
  RETURN v_realizaventa; -- Retornamos la variable.
EXCEPTION
  WHEN OTHERS THEN
    /* En caso de un error inesperado mandaremos tambien 0*/
    RETURN 0;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUREALIZAVENTA', 'ADM_PERSON');
END;
/
