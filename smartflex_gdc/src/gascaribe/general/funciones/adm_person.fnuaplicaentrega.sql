CREATE OR REPLACE FUNCTION adm_person.fnuaplicaentrega (
    isbentrega IN VARCHAR2 -- Entrega
) RETURN NUMBER IS

/***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuAplicaEntrega
    Descripción:        Esta función se crea para poder validar entregas en sql

    Autor    : Sandra Muñoz
    Fecha    : 31-08-2016 cA100-9314

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificación
    -----------  -------------------    -------------------------------------
    06/03/2023      Paola Acosta        OSF-2180: Se agregan permisos para REXEREPORTES
    20-02-2024   Paola Acosta           OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON
                                        Se agrega clasificaci�n del parametro de la funci�n como IN
    31-08-2016   Sandra Muñoz          Creación
    ***********************************************************************************************/

BEGIN
    IF fblaplicaentrega(isbentrega) THEN
        RETURN 1;
    END IF;
    RETURN 0;
END fnuaplicaentrega;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUAPLICAENTREGA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.fnuaplicaentrega TO REXEREPORTES;
/
