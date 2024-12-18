CREATE OR REPLACE PROCEDURE adm_person.ldc_pluvalinstvsi 
IS
    /**************************************************************************
    Autor       : Esantiago / Horbath
    Fecha       : 16-12-2020
    Ticket      : 374
    Descripcion : Plugin que se encarga de validar, si la orden que se está
                    legalizando actualmente este asociada a una solicitud de VSI y
                    No este asociado a una instancia.
    
    Valor de salida
    
    HISTORIA DE MODIFICACIONES
    FECHA           AUTOR               DESCRIPCION
    -----           -----               -----------------------
    16/04/2024      PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
    ***************************************************************************/

    nuorden                 or_order.order_id%TYPE;
    nuvalinstvsi 			NUMBER;
    osberrormessage         ge_error_log.DESCRIPTION%TYPE;   
    
    CURSOR cuvalinstvsi(nuorder NUMBER) IS
    SELECT 1
    FROM or_order_activity oa, 
         mo_packages P
    WHERE oa.package_id = P.package_id
    AND P.package_type_id = dald_parameter.fnugetnumeric_value('COD_PACKAGE_TYPE_ID_100101', NULL)
    AND oa.instance_id IS NULL
    AND oa.order_id = nuorder;
    
BEGIN
    -- con estas funciones se obtienen los datos de la orden que se intentan legalizar --
    ut_trace.TRACE('Inicio PLUGIN LDC_PLUVALINSTVSI',10);
    nuorden := or_bolegalizeorder.fnugetcurrentorder;-- se obtiene el id de la orden que se intenta legalizar

	IF fblaplicaentregaxcaso('0000374') THEN

		OPEN cuvalinstvsi(nuorden);
		 FETCH cuvalinstvsi INTO nuvalinstvsi;
		 CLOSE cuvalinstvsi;

		IF nuvalinstvsi = 1 THEN
			osberrormessage := 'Problemas de ejecutores favor reportar al administrador.';
			ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,osberrormessage);
			RAISE ex.controlled_error;

		END IF;
	END IF;
    ut_trace.TRACE('fin PLUGIN LDC_PLUVALINSTVSI',10);
    
EXCEPTION
    WHEN ex.controlled_error THEN
       RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ERRORS.seterror;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,osberrormessage);
        RAISE ex.controlled_error;
END ldc_pluvalinstvsi;
/
PROMPT Otorgando permisos de ejecucion a LDC_PLUVALINSTVSI
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PLUVALINSTVSI','ADM_PERSON');
END;
/