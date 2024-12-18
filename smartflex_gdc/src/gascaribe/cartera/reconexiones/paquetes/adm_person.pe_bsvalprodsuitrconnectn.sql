CREATE OR REPLACE PACKAGE adm_person.PE_BSValProdSuitRconnectn AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Paquete	    :   PE_BSValProdSuitRconnectn
    Descripción	:   Servicio de negocio para consultar la información del producto.

    Autor	    :   Luz Trujillo García
    Fecha   	:   04-11-2014

    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    11/07/2024              PAcosta         OSF-2893: Cambio de esquema ADM_PERSON  

    04-11-2014  LTrujilloSAO288775
    Creación.
*/

    ----------------------------------------------------------------------------
    -- Métodos
    ----------------------------------------------------------------------------

    /*  Obtiene versión actual del paquete */
    FUNCTION fsbVersion
    RETURN varchar2;

    /* Valida si el producto es apto para reconexión */
    PROCEDURE ValInfo
    (
        inuProductId    in  pr_product.product_id%type,
        osbFlag         out varchar2,
        onuErrorCode    out ge_error_log.error_log_id%type,
        osbErrorMsg     out ge_error_log.description%type
    );

END PE_BSValProdSuitRconnectn;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PE_BSValProdSuitRconnectn AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Paquete	    :   PE_BSGetClientInfo
    Descripción	:   Variables, Procedimientos y Funciones del paquete
                    PE_BSValProdSuitRconnectn.

    Autor	    :   Luz Trujillo García
    Fecha   	:   04-11-2014

    Historia de Modificaciones
    Fecha	    IDEntrega
    04-11-2014  LTrujilloSAO288775
    Creación


*/

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------

    /* Versión paquete */
    csbVersion  constant varchar2(250) := 'SAO288775';

    ----------------------------------------------------------------------------
    -- Métodos
    ----------------------------------------------------------------------------

    /*
        Propiedad intelectual de Open International Systems. (c).

        Función 	:   fsbVersion
        Descripcion	:   Obtiene SAO que identifica versión asociada a última
                        entrega del paquete.

        Retorno     :
            csbVersion      Versión de paquete.

        Autor	    :   Luz Trujillo García
        Fecha   	:   04-11-2014

        Historia de Modificaciones
        Fecha	    IDEntrega
        04-11-2014  LTrujilloSAO288775
        Creación.
    */

    FUNCTION fsbVersion
        return varchar2
    IS
    BEGIN

    	UT_Trace.Trace('PE_BSValProdSuitRconnectn.fsbVersion INICIO', 2);
    	UT_Trace.Trace('PE_BSValProdSuitRconnectn.fsbVersion FIN', 2);

        return csbVersion;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END fsbVersion;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento :   ValInfo
        Descripción   :   Valida si el producto es apto para reconexión
        --------------------------------------------------------------------
        Parámetros    :
        inuProductId       Identificador del producto
        --------------------------------------------------------------------
        Retorno      :
        osbFlag      : 'S'->Producto Válido para reconexión
                      'N'->Producto No válido para reconexión

        onuErrorCode    : 0 - Terminó con éxito.
                      <> 0 - Código de error.

        osbErrorMsg     : '-'- Terminó con éxito.
                      <> '-' - Mensaje de error.

        --------------------------------------------------------------------
        Autor	    :  Luz Trujillo García
        Fecha   	:  04-11-2014
        --------------------------------------------------------------------
        Historia de Modificaciones
        Fecha	    IDEntrega
        04-11-2014  LTrujilloSAO288775
        Creación.
        */

    PROCEDURE ValInfo
    (
        inuProductId    in  pr_product.product_id%type,
        osbFlag         out varchar2,
        onuErrorCode    out ge_error_log.error_log_id%type,
        osbErrorMsg     out ge_error_log.description%type
    )
    IS

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* Producto */
        nuProductId pr_product.product_id%type;

        ------------------------------------------------------------------------
        -- Métodos
        ------------------------------------------------------------------------

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento :   Initialize
            Descripción   :   Inicializa mensaje de error.

            Autor       :   Luz Trujillo G
            Fecha       :   04-11-2015

            Historia de Modificaciones
            Fecha       IDEntrega

            04-11-2015  LTrujilloSAO288775
            Creación.
        */

        PROCEDURE Initialize
        IS
        BEGIN

        	UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo.Initialize INICIO', 2);

        	/* Inicializa variables de error */
        	Errors.Initialize;
        	onuErrorCode := GE_BOConstants.OK;
        	osbErrorMsg  := GE_BOConstants.csbNULLSB;

        	UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo.Initialize FIN', 2);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise;
            when OTHERS then
                Errors.SetError;
                raise ex.CONTROLLED_ERROR;
        END Initialize;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento :   ClearMemory
            Descripción	  :   Limpia memoria caché.

            Autor       :   Luz Trujillo G
            Fecha       :   04-11-2015

            Historia de Modificaciones
            Fecha       IDEntrega

            04-11-2015  LTrujilloSAO288775
            Creación.
        */

        PROCEDURE ClearMemory
        IS
        BEGIN

            UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo.ClearMemory INICIO', 2);

        	/* Limpia memoria caché */
            DAPR_Product.ClearMemory;
            pktblServsusc.ClearMemory;

            UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo.ClearMemory FIN', 2);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise;
            when OTHERS then
                Errors.SetError;
                raise ex.CONTROLLED_ERROR;
        END ClearMemory;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento :   ValInputData
            Descripción   :   Valida parámetros de entrada.

            Parámetros    :


            Retorno     :

            Autor       :   Luz Trujillo G
            Fecha       :   04-11-2015

            Historia de Modificaciones
            Fecha       IDEntrega

            04-11-2015  LTrujilloSAO288775
            Creación.
        */

        PROCEDURE ValInputData
        (
           inuProductId    in  pr_product.product_id%type
        )
        IS
        BEGIN

            UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo.ValInputData INICIO', 2);

            /* Validaque el producto exista */
            pktblservsusc.acckey(inuProductId);

            UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo.ValInputData FIN', 2);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise;
            when OTHERS then
                Errors.SetError;
                raise ex.CONTROLLED_ERROR;
        END ValInputData;

    BEGIN

        UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo INICIO', 2);

        /* Inicializa variables de error */
        Initialize;

        /* Limpia memoria caché */
        ClearMemory;

        /* Valida parámetros de entrada */
        ValInputData(inuProductId);

        /* Invoca proceso */
        PE_BOValProdSuitRconnectn.ValInfo
        (
            inuProductId,
            osbFlag,
            onuErrorCode,
            osbErrorMsg
        );

        UT_Trace.Trace('PE_BSValProdSuitRconnectn.ValInfo FIN', 2);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            Errors.GetError(onuErrorCode, osbErrorMsg);
        when OTHERS then
            Errors.SetError;
            Errors.GetError(onuErrorCode, osbErrorMsg);
    END ValInfo;

END PE_BSValProdSuitRconnectn;
/
PROMPT Otorgando permisos de ejecucion a PE_BSVALPRODSUITRCONNECTN
BEGIN
    pkg_utilidades.praplicarpermisos('PE_BSVALPRODSUITRCONNECTN', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre PE_BSVALPRODSUITRCONNECTN para reportes
GRANT EXECUTE ON adm_person.PE_BSVALPRODSUITRCONNECTN TO rexereportes;
/

