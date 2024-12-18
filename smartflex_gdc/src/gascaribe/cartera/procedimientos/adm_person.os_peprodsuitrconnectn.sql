CREATE OR REPLACE PROCEDURE adm_person.OS_PEProdSuitRconnectn
(
    inuProductId    in  pr_product.product_id%type,
    osbFlag         out varchar2,
    onuErrorCode    out ge_error_log.error_log_id%type,
    osbErrorMsg     out ge_error_log.description%type
)
IS
/*
    Propiedad intelectual de Open International Systems. (c).

    Procedimiento   :  OS_PEProdSuitRconnectn
    Descripción     :  API para Validación de Aptitud para
                       Reconexión

    Parámetros
    ---------------------------------------------------------
    inuProductId       Identificador del producto

    Retorno
    ---------------------------------------------------------
    osbFlag         : 'S'->Producto Válido para reconexión
                      'N'->Producto No válido para reconexión

    onuErrorCode    : 0 - Terminó con éxito.
                      <> 0 - Código de error.

    osbErrorMsg     : '-'- Terminó con éxito.
                      <> '-' - Mensaje de error.
    ----------------------------------------------------------
    Autor	    :  Luz Trujillo García
    Fecha   	:  04-11-2014
    ----------------------------------------------------------
    Historia de Modificaciones
    Fecha	        IDEntrega               Modificacion
    14/05/2024      Paola Acosta            OSF-2674: Cambio de esquema ADM_PERSON 
    04-11-2014      LTrujilloSAO288775      Creación.   
    
*/

BEGIN
    UT_Trace.Trace('OS_PEProdSuitRconnectn INICIO Producto: ['||inuProductId||']', 5);

    /* Invoca proceso */
    PE_BSValProdSuitRconnectn.ValInfo
    (
        inuProductId,
        osbFlag,
        onuErrorCode,
        osbErrorMsg
    );

    UT_Trace.Trace('OS_PEProdSuitRconnectn FIN Flag: ['||osbFlag||']', 5);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        Errors.GetError(onuErrorCode, osbErrorMsg);
    when OTHERS then
        Errors.SetError;
        Errors.GetError(onuErrorCode, osbErrorMsg);
END OS_PEProdSuitRconnectn;
/
PROMPT Otorgando permisos de ejecucion a OS_PEPRODSUITRCONNECTN
BEGIN
    pkg_utilidades.praplicarpermisos('OS_PEPRODSUITRCONNECTN', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre OS_PEPRODSUITRCONNECTN para reportes
GRANT EXECUTE ON adm_person.OS_PEPRODSUITRCONNECTN TO rexereportes;
/