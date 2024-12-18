CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_ldci_logpaymentreg IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.pkg_ldci_logpaymentreg
    Descripción    : Paquete de primer nivel para gestión de log para registro de pagos
    Autor          : jcatuche
    Fecha          : 13/08/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	13-08-2024      jcatuche            OSF-3122: Creación
******************************************************************/
    PROCEDURE prInsertaLogPago
    (
        inuRefType      in number,
        isbXmlReference in clob,
        isbXmlPayment   in clob,
        inuErrorCode    in number,
        isbErrorMessage in varchar2,
        onulogid          out number       
    );
    
    PROCEDURE prActualizaLogPago
    (
        inulogid          in number, 
        inuErrorCode    in number,
        isbErrorMessage in varchar2    
    );

END pkg_ldci_logpaymentreg;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_ldci_logpaymentreg IS
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de función
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado

    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertaLogPago
    Descripción     : Inserta registro de log

    Autor           : jcatuche
    Fecha           : 13-08-2024

    Parametros de Entrada
        inuRefType      Tipo de referencia
        isbXmlReference Xml referencia
        isbXmlPayment   Xml pago
        inuErrorCode    Codigo de error
        isbErrorMessage Mensaje de error

    Parametros de Salida
        ologid          Identificador del registro
    Modificaciones  :
    =========================================================
    Fecha       Autor       Caso        Descripción
    13-08-2024  jcatuche    OSF-2467    Creación
  ***************************************************************************/
    PROCEDURE prInsertaLogPago
    (
        inuRefType      in number,
        isbXmlReference in clob,
        isbXmlPayment   in clob,
        inuErrorCode    in number,
        isbErrorMessage in varchar2,
        onulogid        out number        
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        csbMT_NAME  CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaLogPago';
        nuLogId     ldci_logpaymentreg.logid%type;
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        nuLogId := ldci_seqlogpaymentreg.nextval;
        
        INSERT INTO ldci_logpaymentreg
        (
            logid, 
            inureftype, 
            isbxmlreference, 
            isbxmlpayment, 
            reg_date, 
            error_code, 
            error_message
        )
        VALUES
        (
            nuLogId, 
            inuRefType, 
            isbXmlReference, 
            isbXmlPayment, 
            sysdate, 
            inuErrorCode, 
            isbErrorMessage
        );
      
        COMMIT;
        
        onulogid := nuLogId;

        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaLogPago;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaLogPago
    Descripción     : Actualiza registro de log

    Autor           : jcatuche
    Fecha           : 13-08-2024

    Parametros de Entrada
        ilogid          Identificador del registro
        inuErrorCode    Codigo de error
        isbErrorMessage Mensaje de error

    Parametros de Salida
        
    Modificaciones  :
    =========================================================
    Fecha       Autor       Caso        Descripción
    13-08-2024  jcatuche    OSF-2467    Creación
    ***************************************************************************/
    PROCEDURE prActualizaLogPago
    (
        inulogid          in number, 
        inuErrorCode    in number,
        isbErrorMessage in varchar2    
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        csbMT_NAME  CONSTANT VARCHAR2(100) := csbSP_NAME||'prActualizaLogPago';
        
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        UPDATE ldci_logpaymentreg
        SET error_code = inuErrorCode,
        error_message = isbErrorMessage
        WHERE logid = inulogid;
        
        COMMIT;
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prActualizaLogPago;

END pkg_ldci_logpaymentreg;
/
begin
    pkg_utilidades.prAplicarPermisos('PKG_LDCI_LOGPAYMENTREG','ADM_PERSON');
end;
/