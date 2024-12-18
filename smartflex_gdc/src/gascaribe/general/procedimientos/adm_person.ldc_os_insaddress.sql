CREATE OR REPLACE PROCEDURE      ADM_PERSON.LDC_OS_INSADDRESS
(
    isbaddress          in  ab_address.address%type,
    inugeograplocation  in  ab_address.geograp_location_id%type,
    inuneighborthood    in  ab_segments.neighborhood_id%type,
    isbisurban          in  ab_address.is_urban%type,
    isbshape            in  varchar2,
    onuaddressid        out ab_address.address_id%type,
    onufatheraddressid  out ab_address.father_address_id%type,
    onuerrorcode        out ge_error_log.error_log_id%type,
    osberrormessage     out ge_error_log.description%type
)
IS
/**********************************************************************
    Propiedad intelectual de PETI
    Nombre          LDC_OS_INSADDRESS

    Descripción     Es una adaptacion al API de creación de Dirección, solo que
                    retorna adicionalmente el ID de la dirección padre de la dirección.

    Parametros	       Descripcion
    Entrada:
        isbaddress:         Dirección a crear
        inugeograplocation  Numero de la ubicacion geogragfica
        inuneighborthood    Codigo del segmento
        isbisurban          flag si la dirección es urbana
        isbshape            campo geometrico (coordenadas)
    Salida:
        onuonuaddressid     Codigo de la nueva dirección
        onufatheraddressid  Codigo de la dirección padre
        onuErrorCode:       Codigo de error.
        osbErrorMessage:    Mensaje de error.

    Historia de Modificaciones
    Fecha             Autor             Modificación
  ============     ==========      =====================================
  06/09/2014        oparra          TEAM 659. Creación procedure
  23/10/2014        oparra          Correcion error reportado, para que solo
                                    retorne la direccion padre cuando se cree
                                    una nueva, de resto retorne null.
  14/05/2024        Paola Acosta    OSF-2674: Cambio de esquema ADM_PERSON                                      
***********************************************************************/

    sbverified          ab_address.verified%type := ge_boconstants.csbyes;

BEGIN

    -- Metodo actual de Smartflex que crea la direcciones
    LDC_BOMANAGEADDRESS.INSADDRESS
    (
        inugeograplocation,
        isbaddress,
        inuneighborthood,
        isbisurban,
        isbshape,
        sbverified,
        onuaddressid,
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

END LDC_OS_INSADDRESS;
/
PROMPT Otorgando permisos de ejecucion a LDC_OS_INSADDRESS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_OS_INSADDRESS', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_OS_INSADDRESS para reportes
GRANT EXECUTE ON adm_person.LDC_OS_INSADDRESS TO rexereportes;
/