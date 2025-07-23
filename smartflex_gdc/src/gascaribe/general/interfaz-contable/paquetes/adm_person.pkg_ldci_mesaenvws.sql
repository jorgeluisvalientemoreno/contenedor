CREATE OR REPLACE PACKAGE adm_person.pkg_ldci_mesaenvws IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldci_mesaenvws
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   21/01/2025
    Descripcion :   Paquete de acceso a datos de la tabla ldci_mesaenvws
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
*******************************************************************************/


    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene un nuevo identificador a partir de la secuencia LDCi_SEQMESAWS
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER;
    
    -- Inserta un registo y retorna el identificador
    PROCEDURE prInsRegistro
    (
        idtMESAFECH	        IN  DATE	    DEFAULT SYSDATE,
        iclMESAXMLENV	    IN  CLOB	    DEFAULT NULL,
        inuMESAESTADO	    IN  NUMBER	    DEFAULT -1,
        inuMESAINTENTOS	    IN  NUMBER	    DEFAULT 0,
        isbMESADEFI	        IN  VARCHAR2	DEFAULT NULL,
        isbMESAHTTPERROR	IN  VARCHAR2    DEFAULT NULL,
        isbMESATRACEERROR	IN  VARCHAR2    DEFAULT NULL,
        iclMESASOAPERROR	IN  CLOB	    DEFAULT NULL,
        inuMESAISSOAPERROR	IN  NUMBER	    DEFAULT NULL,
        inuMESAISHTTPERROR	IN  NUMBER	    DEFAULT NULL,
        iclMESAXMLPAYLOAD	IN  CLOB	    DEFAULT NULL,
        idtMESAFECHAINI	    IN  DATE	    DEFAULT SYSDATE,
        idtMESAFECHAFIN	    IN  DATE	    DEFAULT NULL,
        inuMESAPROC	        IN  NUMBER	    DEFAULT NULL,
        inuMESATAMLOT	    IN  NUMBER	    DEFAULT NULL,
        inuMESALOTACT	    IN  NUMBER	    DEFAULT NULL,
        onuMESACODI	        OUT NUMBER	        
    );

    -- Actualiza datos de un registro en ldci_mesaenvws    
    PROCEDURE prActRegistro
    (
        inuCodi         IN LDCI_mesaenvws.mesacodi%type,
        isbXmlEnv       IN LDCI_mesaenvws.mesaxmlenv%type,
        isbWebService   IN LDCI_mesaenvws.MESADEFI%type,
        isbHttpError    IN LDCI_mesaenvws.mesahttperror%type,
        isbSoapPayload  IN LDCI_mesaenvws.MESAXMLPAYLOAD%type,
        isbSoapError    IN LDCI_mesaenvws.mesasoaperror%type,
        isbTraceError   IN LDCI_mesaenvws.mesatraceerror%type,
        iblHttpError    IN BOOLEAN,
        iblSoapError    IN BOOLEAN,
        idtFechaFin     IN LDCI_mesaenvws.mesafechafin%type
    );
    
    -- Actualiza MesaProc en un registro en ldci_mesaenvws      
    PROCEDURE prActMesaProc
    (
        inuCodi         IN LDCI_mesaenvws.mesacodi%type,
        inuProcCodi     IN LDCI_mesaenvws.mesaproc%type
    );      

END pkg_ldci_mesaenvws;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldci_mesaenvws IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3879';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 21/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    -- Obtiene un nuevo identificador a partir de la secuencia LDCi_SEQMESAWS                     
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtNuevoIdentificador';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuNuevoIdentificador    NUMBER;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        nuNuevoIdentificador    := LDCi_SeqMesAWS.NextVal;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuNuevoIdentificador; 
                               
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuNuevoIdentificador;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuNuevoIdentificador;
    END fnuObtNuevoIdentificador;

    -- Inserta un registo y retorna el identificador
    PROCEDURE prInsRegistro
    (
        idtMESAFECH	        IN  DATE	    DEFAULT SYSDATE,
        iclMESAXMLENV	    IN  CLOB	    DEFAULT NULL,
        inuMESAESTADO	    IN  NUMBER	    DEFAULT -1,
        inuMESAINTENTOS	    IN  NUMBER	    DEFAULT 0,
        isbMESADEFI	        IN  VARCHAR2	DEFAULT NULL,
        isbMESAHTTPERROR	IN  VARCHAR2    DEFAULT NULL,
        isbMESATRACEERROR	IN  VARCHAR2    DEFAULT NULL,
        iclMESASOAPERROR	IN  CLOB	    DEFAULT NULL,
        inuMESAISSOAPERROR	IN  NUMBER	    DEFAULT NULL,
        inuMESAISHTTPERROR	IN  NUMBER	    DEFAULT NULL,
        iclMESAXMLPAYLOAD	IN  CLOB	    DEFAULT NULL,
        idtMESAFECHAINI	    IN  DATE	    DEFAULT SYSDATE,
        idtMESAFECHAFIN	    IN  DATE	    DEFAULT NULL,
        inuMESAPROC	        IN  NUMBER	    DEFAULT NULL,
        inuMESATAMLOT	    IN  NUMBER	    DEFAULT NULL,
        inuMESALOTACT	    IN  NUMBER	    DEFAULT NULL,
        onuMESACODI	        OUT NUMBER	        
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        onuMESACODI :=  fnuObtNuevoIdentificador;
        
        INSERT INTO ldci_mesaenvws
        (
            MESACODI,
            MESAFECH,
            MESAXMLENV,
            MESAESTADO,
            MESAINTENTOS,
            MESADEFI,
            MESAHTTPERROR,
            MESATRACEERROR,
            MESASOAPERROR,
            MESAISSOAPERROR,
            MESAISHTTPERROR,
            MESAXMLPAYLOAD,
            MESAFECHAINI,
            MESAFECHAFIN,
            MESAPROC,
            MESATAMLOT,
            MESALOTACT        
        )
        VALUES
        (
            onuMESACODI             ,
            idtMESAFECH	            ,
            iclMESAXMLENV	        ,
            inuMESAESTADO	        ,
            inuMESAINTENTOS	        ,
            isbMESADEFI	            ,
            isbMESAHTTPERROR	    ,
            isbMESATRACEERROR	    ,
            iclMESASOAPERROR	    ,
            inuMESAISSOAPERROR	    ,
            inuMESAISHTTPERROR	    ,
            iclMESAXMLPAYLOAD	    ,
            idtMESAFECHAINI	        ,
            idtMESAFECHAFIN	        ,
            inuMESAPROC	            ,
            inuMESATAMLOT	        ,
            inuMESALOTACT	                    
        );
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| sbError, null, null);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| sbError, null, null);
    END prInsRegistro;

    -- Actualiza datos de un registro en ldci_mesaenvws
    PROCEDURE prActRegistro
    (
        inuCodi         IN LDCI_mesaenvws.mesacodi%type,
        isbXmlEnv       IN LDCI_mesaenvws.mesaxmlenv%type,
        isbWebService   IN LDCI_mesaenvws.MESADEFI%type,
        isbHttpError    IN LDCI_mesaenvws.mesahttperror%type,
        isbSoapPayload  IN LDCI_mesaenvws.MESAXMLPAYLOAD%type,
        isbSoapError    IN LDCI_mesaenvws.mesasoaperror%type,
        isbTraceError   IN LDCI_mesaenvws.mesatraceerror%type,
        iblHttpError    IN BOOLEAN,
        iblSoapError    IN BOOLEAN,
        idtFechaFin     IN LDCI_mesaenvws.mesafechafin%type
    ) AS

        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                
        nuReportHttpError NUMBER;
        nuReportSoapError NUMBER;
        nuEstado          NUMBER:=1;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF iblHttpError THEN
            nuReportHttpError:=1;
            nuEstado:=-1;
        ELSE
            nuReportHttpError:=0;
        END IF;

        IF iblSoapError THEN
            nuReportSoapError:=1;
            nuEstado:=-1;
        ELSE
            nuReportSoapError:=0;
        END IF;

        UPDATE LDCI_mesaenvws 
        SET 
        mesaXmlEnv      =   isbXmlEnv,
        mesaHttpError   =   isbHttpError,
        mesaSoapError   =   isbSoapError ,
        mesaTraceError  =   isbTraceError,
        mesaIsHttpError =   nuReportHttpError,
        mesaIsSoapError =   nuReportSoapError,
        mesaFechaFin    =   idtFechaFin,
        mesaxmlpayload  =   isbSoapPayload,
        mesaintentos    =   mesaintentos+1,
        mesaestado      =   nuEstado
        WHERE  mesacodi=inuCodi;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| sbError, null, null);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| sbError, null, null);
    END prActRegistro;

    -- Actualiza MesaProc en un registro en ldci_mesaenvws      
    PROCEDURE prActMesaProc
    (
        inuCodi         IN LDCI_mesaenvws.mesacodi%type,
        inuProcCodi     IN LDCI_mesaenvws.mesaproc%type
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActMesaProc';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        UPDATE LDCI_MESAENVWS 
        SET 
        MESAPROC = inuProcCodi 
        WHERE MESACODI=inuCodi;
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| sbError, null, null);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| sbError, null, null);
    END prActMesaProc;
    
END pkg_ldci_mesaenvws;
/

Prompt Otorgando permisos sobre adm_person.pkg_ldci_mesaenvws
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldci_mesaenvws'), 'ADM_PERSON');
END;
/

