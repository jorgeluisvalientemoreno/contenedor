create or replace procedure adm_person.api_ajustarcuenta
(
    inuOperacion      IN    number,                       --Operación a realizar
    inuCuenta         IN    cuencobr.cucocodi%type,       --Cuenta de cobro
    inuContrato       IN    suscripc.susccodi%type,       --Contrato
    inuProducto       IN    servsusc.sesunuse%type,       --Producto
    inuConcepto       IN    concepto.conccodi%type,       --Concepto
    isbSigno          IN    cargos.cargsign%type,         --Signo
    inuValorNota      IN    cargos.cargvalo%type,         --valor del ajuste
    inuFlagBD         IN    number default 1,             --flag para actualizar cuentas
    isbGeneraSaFavor  IN    varchar2 default 'S',      --indica si genera o no saldo favor
    isbAplicaSaFavor  IN    varchar2 default 'N',      --Indica si aplica o no saldo a favor    
    onuErrorCode      OUT   ge_message.message_id%type,   --Código del mensaje de error
    osbErrorMessage   OUT   ge_error_log.description%type --Mensaje de error
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : api_ajustarcuenta
    Descripcion     : Api encargado de realizar el ajuste de la cuenta de
                      cobro enviada, una vez realizado el ajuste.
                      Se valida la variable isbGeneraSaFavor si su valor es
                      S se genera el saldo a favor. 
                      Si el valor de la variable isbAplicaSaFavor es S
                      aplica el saldo a favor. 
    Autor           : Edilay Peña Osorio - MVM
    Fecha           : 13/10/2023

    Parametros de Entrada
          Nombre               Tipo                         Descripción
      ===================    =========                      =============================
         inuOperacion         NUMBER                        Operación a realizar
         inuCuenta            cuencobr.cucocodi%type        Cuenta de cobro
         inuContrato          suscripc.susccodi%type        Contrato
         inuProducto          servsusc.sesunuse%type        Producto
         inuConcepto          concepto.conccodi%type        Concepto
         isbSigno             cargos.cargsign%type          Signo
         inuValorNota         cargos.cargvalo%type          valor del ajuste
         inuFlagBD            number default 1              flag para actualizar cuentas
         isbGeneraSaFavor     varchar2(1) default 'S'       indica si genera o no saldo favor
         isbAplicaSaFavor     varchar2(1) default 'N'       Indica si aplica o no saldo a favor    

    Parametros de Salida        
      Nombre                  Tipo                          Descripción
      ===================    =========                      =============================    
        onuErrorCode         ge_message.message_id%type     Codigo de error.
        osbErrorMessage      ge_error_log.description%type  Mensaje de error.

    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    epenao    13/10/2023       OSF-1607: Creación
***************************************************************************/
    
    --Variable para gestión de traza
    csbMetodo      CONSTANT VARCHAR2(50) := $$PLSQL_UNIT;--Constante nombre método

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi,pkg_traza.csbINICIO);    
    
    -- Ajusta la Cuenta
    pkupdaccoreceiv.updaccorec (inuOperacion,
                                inucuenta,
                                inuContrato,
                                inuProducto,
                                inuConcepto,
                                isbSigno,
                                inuValorNota,
                                inuFlagBD
                                );

    --Genera saldo a favor
    if (isbGeneraSaFavor = constants_per.CSBSI) then
        pkAccountMgr.GenPositiveBal( inucuenta, inuConcepto );
        pkg_traza.trace('Saldo a favor generado',pkg_traza.cnuNivelTrzApi);
        
        --Si se generó el saldo a favor ok se valida si se debe aplicar. 
        if (isbAplicaSaFavor = constants_per.CSBSI) then        
            pkAccountMgr.ApplyPositiveBalServ(inuProducto);
            pkg_traza.trace('Saldo a favor aplicado',pkg_traza.cnuNivelTrzApi);
        end if;   
    end if;

 

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);        
        pkg_traza.trace('Error:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzApi);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
        pkg_Error.SETERROR;
        pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
        pkg_traza.trace('Error:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzApi);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN_ERR);
END api_ajustarcuenta;
/

PROMPT Asignación de permisos para el método
begin
  pkg_utilidades.prAplicarPermisos('API_AJUSTARCUENTA', 'ADM_PERSON');
end;
/