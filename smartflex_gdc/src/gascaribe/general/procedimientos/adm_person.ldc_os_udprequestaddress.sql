CREATE OR REPLACE PROCEDURE adm_person.ldc_os_udprequestaddress
(
    INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
    INUADDRESSID    IN  MO_PACKAGES.address_id%TYPE,
    ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
    OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
)
IS
/**********************************************************************
    Propiedad intelectual de PETI
    Nombre          LDC_OS_UDPREQUESTADDRESS

    Descripción     API que permite actualizar la dirección asociada a una solicitud.
                    Actualiza registros en mo_packages y en mo_address, segun el tipo
                    de solicitud permitido. Si la solicitud tiene asociada ordenes asociadas
                    tambien actualizara la dirección a dichas ordenes.

    Parametros	       Descripcion
    Entrada:
        inuPackageId: identificador de la solicitud a actualizar
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

    LDC_BOManageAddress.UpdAddressRequest
    (
        inuPackageid,
        inuAddressId,
        onuErrorCode,
        osbErrorMessage
    );

EXCEPTION
    when ex.CONTROLLED_ERROR then
    	Errors.getError(onuErrorCode, osbErrorMessage);
    when others then
    	Errors.setError;
    	Errors.getError(onuErrorCode, osbErrorMessage);

END LDC_OS_UDPREQUESTADDRESS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_OS_UDPREQUESTADDRESS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_OS_UDPREQUESTADDRESS', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_OS_UDPREQUESTADDRESS
GRANT EXECUTE ON ADM_PERSON.LDC_OS_UDPREQUESTADDRESS TO REXEREPORTES;
/
PROMPT OTORGA PERMISOS a REXEGISOSF sobre LDC_OS_UDPREQUESTADDRESS
GRANT EXECUTE ON ADM_PERSON.LDC_OS_UDPREQUESTADDRESS TO REXEGISOSF;
/
