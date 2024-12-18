CREATE OR REPLACE PROCEDURE adm_person.ldc_os_addresschange
(
    inuoldaddressid         in  ab_address.address_id%type,
    isbnewaddress           in  ab_address.address%type,
    inunewgeolocationid     in  ab_address.geograp_location_id%type,
    inunewneighborhoodid    in  ab_address.neighborthood_id%type,
    inuconsecutive          in  ab_premise.consecutive%type,
    onunewaddressid         out ab_address.address_id%type,
    onufatheraddressid      out ab_address.father_address_id%type,
    onuerrorcode            out number,
    osberrormessage         out varchar2
)
IS
/**********************************************************************
    Propiedad intelectual de PETI
    Nombre          LDC_OS_AddressChange

    Descripción     Es una adaptacion al API de creación de Dirección, solo que
                    retorna adicionalmente el ID de la dirección padre de la dirección.

    Parametros	       Descripcion
    Entrada:
        inuoldaddressid         ID de la direccion actual
        isbnewaddress           Dirección nueva
        inunewgeolocationid     Numero de la ubicacion geogragfica
        inunewneighborhoodid    Codigo del segmento
        inuconsecutive          Codigo del predio
    Salida:
        onunewaddressid         Codigo de la nueva dirección
        onufatheraddressid      Codigo de la dirección padre, esta se retorna
                                cuando la direccion nueva no existe.
        onuErrorCode:           Codigo de error.
        osbErrorMessage:        Mensaje de error.

    Historia de Modificaciones
    Fecha             Autor             Modificación
  ============     ==========      =====================================
  06/09/2014        oparra          TEAM 659. Creación procedure
  15/05/2024       Adrianavg       OSF-2673: Se migra del esquema OPEN al esquema ADM_PERSON
***********************************************************************/

    nuFatherAddressId   ab_address.father_address_id%type;

BEGIN

    -- Metodo actual de Smartflex que actualiza la direcciones
    LDC_BOMANAGEADDRESS.ADDRESSCHANGE
    (
        inuoldaddressid,
        isbnewaddress,
        inunewgeolocationid,
        inunewneighborhoodid,
        inuconsecutive,
        onunewaddressid,
        onufatheraddressid,
        onuerrorcode,
        osberrormessage
    );

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);

END LDC_OS_ADDRESSCHANGE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_OS_ADDRESSCHANGE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_OS_ADDRESSCHANGE', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_OS_ADDRESSCHANGE
GRANT EXECUTE ON ADM_PERSON.LDC_OS_ADDRESSCHANGE TO REXEREPORTES;
/
PROMPT OTORGA PERMISOS a REXEGISOSF sobre LDC_OS_ADDRESSCHANGE
GRANT EXECUTE ON ADM_PERSON.LDC_OS_ADDRESSCHANGE TO REXEGISOSF;
/