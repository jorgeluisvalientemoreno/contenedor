CREATE OR REPLACE PROCEDURE adm_person.ldc_os_udporderaddress
(
    INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
    INUADDRESSID    IN  OR_ORDER.external_address_id%TYPE,
    ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
    OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
)
IS
/**********************************************************************
    Propiedad intelectual de PETI
    Nombre          LDC_OS_UDPORDERADDRESS

    Descripción     API que permite actualizar la dirección asociada a una orden
                    de trabajo. Actualiza registros en Or_order y en or_order_activity.

    Parametros	       Descripcion
    Entrada:
        inuOrderid:   identificador de la orden a actualizar
        inuAddressId: identificador de la dirección nueva
    Salida:
        onuErrorCode:    Codigo de error.
        osbErrorMessage: Mensaje de error.

    Historia de Modificaciones
    Fecha             Autor             Modificación
  ============     ==========      =====================================
  04/09/2014        oparra          TEAM 60. Creación procedure
  15/05/2024        Adrianavg       OSF-2673: Se migra del esquema OPEN al esquema ADM_PERSON
***********************************************************************/

BEGIN

    LDC_BOManageAddress.UpdAddressOrder
    (
        inuOrderId,
        inuAddressId,
        'A',      -- process API
        onuErrorCode,
        osbErrorMessage
    );

EXCEPTION
    when ex.CONTROLLED_ERROR then
    	Errors.getError(onuErrorCode, osbErrorMessage);
    when others then
    	Errors.setError;
    	Errors.getError(onuErrorCode, osbErrorMessage);

END LDC_OS_UDPORDERADDRESS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_OS_UDPORDERADDRESS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_OS_UDPORDERADDRESS', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_OS_UDPORDERADDRESS
GRANT EXECUTE ON ADM_PERSON.LDC_OS_UDPORDERADDRESS TO REXEREPORTES;
/
PROMPT OTORGA PERMISOS a REXEGISOSF sobre LDC_OS_UDPORDERADDRESS
GRANT EXECUTE ON ADM_PERSON.LDC_OS_UDPORDERADDRESS TO REXEGISOSF;
/

