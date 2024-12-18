create or replace PROCEDURE adm_person.ldc_validaimpedimentos IS
	/**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDC_VALIDAIMPEDIMENTOS
    Descripcion :  Regla del atributo de validacion de los tramites de reconexion

    Autor       : Carlos Gonzalez
    Fecha       : 23-08-2022
    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
	19-04-2024	 Adrianavg		        OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
    **************************************************************************/
	nuPackageTypeId 	ps_package_type.package_type_id%TYPE;
	nuContrato 			suscripc.susccodi%TYPE;
    nuProducto 			servsusc.sesunuse%TYPE;
	sbInstancia 		VARCHAR2(200);
	v_out 				NUMBER := 1;
	sbMensajeError 		VARCHAR2(200);
BEGIN
	ut_trace.trace('INICIO LDC_VALIDAIMPEDIMENTOS', 10);

	GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'MO_PROCESS','PACKAGE_TYPE_ID', nuPackageTypeId);

	--Si el tipo de solicitud no esta instanciado en WORK_INSTANCE, se asume que es tipo de solicitud 300-Reconexion Por Pago
	nuPackageTypeId := NVL(nuPackageTypeId, 300);

	IF (nuPackageTypeId = 300) THEN
		sbInstancia := 'MOTY_RECONEXION-2';
	END IF;

	ut_trace.trace('nuPackageTypeId: '||nuPackageTypeId, 10);

	IF (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', v_out) = GE_BOCONSTANTS.GETTRUE) THEN

		GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', nuContrato);

		IF (CC_BORESTRICTION.FBLEXISTRESTBYPACKTYPE(nuContrato, NULL, NULL, nuPackageTypeId)) THEN
			sbMensajeError := 'El contrato tiene impedimentos para ejecutar este tramite.';
            ut_trace.trace('LDC_VALIDAIMPEDIMENTOS-->'||sbMensajeError, 10);
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbMensajeError);
            RAISE ex.controlled_error;
		END IF;
	ELSE

		IF (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstancia, NULL, 'MO_MOTIVE', 'PRODUCT_ID', v_out) = GE_BOCONSTANTS.GETTRUE) THEN

			GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia, NULL, 'MO_MOTIVE', 'PRODUCT_ID', nuProducto);

            nuContrato := pktblservsusc.fnugetsesususc(nuProducto);

			IF (CC_BORESTRICTION.FBLEXISTRESTBYPACKTYPE(nuContrato, NULL, NULL, nuPackageTypeId)) THEN
				sbMensajeError := 'El contrato tiene impedimentos para ejecutar este tramite.';
				ut_trace.trace('LDC_VALIDAIMPEDIMENTOS-->'||sbMensajeError, 10);
				ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbMensajeError);
				RAISE ex.controlled_error;
			END IF;
		END IF;
	END IF;

	ut_trace.trace('FIN LDC_VALIDAIMPEDIMENTOS', 10);

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
		ut_trace.trace('ex.CONTROLLED_ERROR LDC_VALIDAIMPEDIMENTOS', 10);
		RAISE;
	WHEN OTHERS THEN
		ut_trace.trace('OTHERS LDC_VALIDAIMPEDIMENTOS', 10);
		Errors.setError;
		RAISE ex.CONTROLLED_ERROR;
END LDC_VALIDAIMPEDIMENTOS;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_VALIDAIMPEDIMENTOS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDAIMPEDIMENTOS', 'ADM_PERSON'); 
END;
/