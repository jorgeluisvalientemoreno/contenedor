create or replace PROCEDURE ADM_PERSON.LDC_ATIENDESOLICITUD IS

    /**************************************************************************
        Autor       : Ernesto Santiago / Horbath
        Fecha       : 22/10/2020
        Ticket      : 537
        Descripcion : Plugin que  que se encargara de validar si la orden actual, estÃ¡ asociada a una solicitud de â100330 - VerificaciÃ³n SAC RPâ,
						de ser correcta esta validaciÃ³n se atenderÃ¡ esta solicitud .

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

    nuOrden                 or_order.order_id%type;
    nuSolicitud             mo_packages.package_id%type;
	nuStatus                mo_packages.motive_status_id%type;
	osbErrorMessage         GE_ERROR_LOG.DESCRIPTION%TYPE;
	onuErrorCode          	ge_error_log.error_log_id%type;


     --- en este cursor se obtiene el los campos solicitud y estado de la solicitud asociada a la orden actual
    cursor cuObtsol(NUORDEN NUMBER) is
			select mp.package_id, mp.motive_status_id
			from or_order_activity a, mo_packages mp
			where a.package_id = mp.package_id
			and a.order_id=NUORDEN
			and mp.package_type_id in (select to_number(column_value)
									   from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TIPOS_SOL_ATEN_PLUG',NULL),',')));

BEGIN

    IF fblaplicaentregaxcaso('0000537') THEN

		ut_trace.trace('Inicio PLUGIN LDC_ATIENDESOLICITUD',10);
		nuOrden := or_bolegalizeorder.fnuGetCurrentOrder; -- se obtiene el id de la orden que se intenta legalizar



		OPEN cuObtsol(nuOrden);
		FETCH cuObtsol INTO nuSolicitud,nuStatus;
		CLOSE cuObtsol;


		IF nuSolicitud IS NOT NULL AND nuStatus =13 THEN

			cf_boactions.attendrequest(nuSolicitud);
			ut_trace.trace('PLUGIN LDC_ATIENDESOLICITUD: Se atiende solicitud',10);

		END IF;

	END IF;


    ut_trace.trace('fin PLUGIN LDC_ATIENDESOLICITUD',10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
       RAISE Ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osbErrorMessage);
        RAISE ex.controlled_error;
END LDC_ATIENDESOLICITUD;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ATIENDESOLICITUD', 'ADM_PERSON');
END;
/
