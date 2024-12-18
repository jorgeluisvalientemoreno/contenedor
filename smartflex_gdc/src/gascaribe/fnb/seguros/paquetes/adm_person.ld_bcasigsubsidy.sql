CREATE OR REPLACE PACKAGE adm_person.LD_BCAsigSubsidy AS
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	: LD_BCAsigSubsidy
    Descripcion : Lógica para Subsidios Asignados
    Autor	: bhernandez
    Fecha	: 17-10-2013

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripción
    =========== ===================     =============================
    19/06/2024  PAcosta                 OSF-2845: Cambio de esquema ADM_PERSON  
    17-10-2013  bhernandezSAO219589     Creación
    ******************************************************************/

    FUNCTION fsbVersion  return VARCHAR2;

    FUNCTION fblIsAnullablePack
    (
        inuPackageId    IN  mo_packages.package_id%type
    )return boolean;

END LD_BCAsigSubsidy;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BCAsigSubsidy AS

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	: LD_BCAsigSubsidy
    Descripcion : Lógica para Subsidios Asignados
    Autor	: bhernandez
    Fecha	: 17-10-2013

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripción
    =========== ===================     =============================
    17-10-2013  bhernandezSAO219589  Creación
    ******************************************************************/
    --------------------------------------------
    -- Tipos
    --------------------------------------------

    --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion          CONSTANT VARCHAR2(250)  := 'SAO219589';
    --------------------------------------------
    -- Parámetros
    --------------------------------------------

    --------------------------------------------
    -- Variables del proceso
    --------------------------------------------
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: fsbVersion
    Descripción	:

    Parámetros          Descripción
    ==============      =============================

    Autor	: Brian Antonio Hernandez
    Fecha	: 16-09-2013

    Historia de Modificaciones
    Fecha	        IDEntrega           Modificación
    ============    ================    =============================
    01-10-2013     bhernandez219589 Creación
    ******************************************************************/
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbVersion;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	:  fblIsAnullablePack
    Descripción	:  Valida si una solicitud posee subsidios asignados, si no tiene
                    es posible realizar la anulación, de lo contrario no se debe permitir anular
                    la solicitud

    Parámetros          Descripción
    ==============      =============================
    inuPackageId        Identificador de la Solicitud

    Autor	: Brian Antonio Hernandez
    Fecha	: 17-10-2013

    Historia de Modificaciones
    Fecha	        IDEntrega           Modificación
    ============    ================    =============================
    17-10-2013     bhernandezSAO219589  Creación
    ******************************************************************/
    FUNCTION fblIsAnullablePack
    (
        inuPackageId    IN  mo_packages.package_id%type
    )
    return boolean IS
       CURSOR cuCursor IS
           SELECT /*+ ordered
                      index(mp PK_MO_PACKAGES)
                      index(sub IX_LD_ASIG_SUBS_01)*/
                count('x')
            FROM mo_packages mp, ld_asig_subsidy  sub /*+ LD_BCAsigSubsidy.fblIsAnullablePack*/
            WHERE mp.package_id = inuPackageid
            AND mp.tag_name in ('P_VENTA_DE_GAS_POR_FORMULARIO_271', 'P_LBC_VENTA_COTIZADA_100229')
            AND sub.package_id = mp.package_id
            AND sub.state_subsidy in ( 1, 2 ,3 );

       nuCount   NUMBER;
    BEGIN

        ut_trace.trace('Inicio LD_BCAsigSubsidy.fblIsAnullablePack ['||inuPackageId||']',1);

        OPEN cuCursor;
        FETCH  cuCursor INTO nuCount;
        CLOSE  cuCursor;

        if(nuCount = 0) then
            return TRUE;
        END if;

        ut_trace.trace('Inicio LD_BCAsigSubsidy.fblIsAnullablePack ['||nuCount||']',1);
        return false;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblIsAnullablePack;

END LD_BCAsigSubsidy;
/
PROMPT Otorgando permisos de ejecucion a LD_BCASIGSUBSIDY
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCASIGSUBSIDY', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BCASIGSUBSIDY para reportes
GRANT EXECUTE ON adm_person.LD_BCASIGSUBSIDY TO rexereportes;
/
