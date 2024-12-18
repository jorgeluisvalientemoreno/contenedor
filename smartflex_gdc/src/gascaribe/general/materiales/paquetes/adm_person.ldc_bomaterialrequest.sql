CREATE OR REPLACE PACKAGE adm_person.LDC_BOMaterialRequest IS
--{
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	:       LDC_BOMaterialRequest
    Descripción	:   Contiene los métodos para que el Job de solicitud de venta
                    pueda modificar por única vez los registros de la tabla
                    ldci_transoma

    Autor	: Carlos Alberto Ramírez Herrera
    Fecha	: 10/11/2014

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
    -----------  -------------------    -------------------------------------

    ******************************************************************/

    --------------------------------------------------------------------
    -- Constantes
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Cursores
    --------------------------------------------------------------------
    -----------------------------------
    -- Metodos publicos del package
    -----------------------------------

    -- Obtiene la Version actual del Paquete
    FUNCTION fsbVersion  return varchar2;

    PROCEDURE ActivateTable
    (
        inuCodi in  ldci_transoma.trsmcodi%type
    );

    PROCEDURE CloseTable
    (
        inuCodi in  ldci_transoma.trsmcodi%type
    );
--}
END LDC_BOMaterialRequest;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOMaterialRequest AS

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	:       LDC_BOMaterialRequest
    Descripción	:   Contiene los métodos para que el Job de solicitud de venta
                    pueda modificar por única vez los registros de la tabla
                    ldci_transoma

    Autor	: Carlos Alberto Ramírez Herrera
    Fecha	: 10/11/2014

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
    -----------  -------------------    -------------------------------------

    ******************************************************************/

    -----------------------
    -- Constants
    -----------------------
    -- Constante con el SAO de la ultima version aplicada
    csbVERSION CONSTANT VARCHAR2(10) := 'OSF-2884';

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: fsbVersion
    Descripcion	:

    Parametros	:	Descripcion
    Retorno     :
    	csbVersion        Version del Paquete

    Autor	   :
    Fecha	   :

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    *****************************************************************/
    FUNCTION fsbVersion
    RETURN varchar2
    IS
        -- Variable para mensajes de Error
        sbErrMsg    ge_error_log.description%type;
    BEGIN
    --{
        pkErrors.Push('Module_BCBusinessObjectFunct.fsbVersion');

        pkErrors.Pop;
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN (csbVersion);
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
    --}
    END fsbVersion;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: ActivateTable
    Descripcion	: Activa la tabla ldci_transoma para que el job pueda modificar
                  los registros.

    Parametros	:	Descripcion

    Autor	   :   Carlos Alberto Ramírez Herrera
    Fecha	   :   10/11/2014

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    10/11/2014    carlosr.arqs
    Creación
    ******************************************************************/
    PROCEDURE ActivateTable
    (
        inuCodi in  ldci_transoma.trsmcodi%type
    )
    IS
    --{
        -- Variable para mensajes de Error
        sbErrMsg    ge_error_log.description%type;
    BEGIN

        pkErrors.Push('LDC_BOMaterialRequest.ActivateTable');

            UPDATE  ldci_transoma
            SET     TRSMPROG = 'WS_MOVIMIENTO_MATERIAL_T', trsmacti = 'N'
            WHERE   trsmcodi = inuCodi;

            commit;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
     --}
     END ActivateTable;

/*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: CloseTable
    Descripcion	: Cierra la tabla ldci_transoma definitivamente para que no pueda
                  ser modificada

    Parametros	:	Descripcion

    Autor	   :   Carlos Alberto Ramírez Herrera
    Fecha	   :   10/11/2014

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificación

    10/11/2014    carlosr.arqs
    Creación
    ******************************************************************/
    PROCEDURE CloseTable
    (
        inuCodi in  ldci_transoma.trsmcodi%type
    )
    IS
    --{
        -- Variable para mensajes de Error
        sbErrMsg    ge_error_log.description%type;
    BEGIN

        pkErrors.Push('LDC_BOMaterialRequest.ActivateTable');

            UPDATE  ldci_transoma
            SET     TRSMPROG = 'WS_MOVIMIENTO_MATERIAL', trsmacti = 'S'
            WHERE   trsmcodi = inuCodi;

            commit;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
     --}
     END CloseTable;

END LDC_BOMaterialRequest;
/
Prompt Otorgando permisos sobre ADM_PERSON.LDC_BOMaterialRequest
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_BOMaterialRequest'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on adm_person.LDC_BOMATERIALREQUEST to REXEOPEN;
/
