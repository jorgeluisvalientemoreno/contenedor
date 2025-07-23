CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_GestionPagos IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Fuente      :   pkg_GestionPagos
    Autor       :   Lubin Pineda - MVM
    Fecha       :   07/11/2024
    Descripcion :   Paquete para la gestion de pagos
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/11/2024  OSF-3280 Creacion
    jpinedc     10/02/2025  OSF-3893 Creacion GdC
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna el tipo de referencia y el XML para pagos por cupón
    PROCEDURE prcTipoRefXMLPagoCupon
    (
        inuCupon            IN  NUMBER, 
        onuTipoReferencia   OUT NUMBER, 
        osbXMLReferencia    OUT CLOB
    );

    -- Retorna el XML para los pagos
    PROCEDURE prcXMLPago
    ( 
        inuBanco                IN  NUMBER , 
        inuSucursal             IN  NUMBER , 
        isbFechaPago            IN  VARCHAR2,  
        inuValorPago            IN  NUMBER,
        osbXMLPago              OUT CLOB,
        inuConciliacion         IN  NUMBER   DEFAULT NULL, 
        isbTransaccion          IN  VARCHAR2 DEFAULT NULL,
        isbFormaPago            IN  VARCHAR2 DEFAULT 'EF',
        inuClaseDocumento       IN  NUMBER   DEFAULT NULL,
        isbDocumento            IN  VARCHAR2 DEFAULT NULL,
        isbEntExpDocumento      IN  VARCHAR2 DEFAULT NULL,
        isbNumeroAutorizacion   IN  VARCHAR2 DEFAULT NULL,
        inuNumeroMeses          IN  NUMBER   DEFAULT NULL,
        isbNumeroCuenta         IN  VARCHAR2 DEFAULT NULL,
        isbPrograma             IN  VARCHAR2 DEFAULT 'OS_PAYMENT', 
        isbTerminal             IN  VARCHAR2 DEFAULT 'desconocida'
    );
    
    -- Realiza el pago de un cupón    
    PROCEDURE prcPagoCupon
    (
        inuCupon        IN  NUMBER , 
        inuBanco        IN  NUMBER , 
        inuSucursal     IN  NUMBER , 
        isbFechaPago    IN  VARCHAR2,  
        inuValorPago    IN  NUMBER,
        osbXMLCupones   OUT CLOB, 
        onuError        OUT NUMBER, 
        osbError        OUT VARCHAR2,
        inuConciliacion IN  NUMBER DEFAULT NULL,
        isbFormaPago    IN  VARCHAR2 DEFAULT 'EF',
        isbTerminal     IN  VARCHAR2 DEFAULT USERENV('TERMINAL')              
    );  

END pkg_GestionPagos;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_GestionPagos IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3893';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    cnuTIPO_REF_CUPON   CONSTANT NUMBER(1) := 1;
    
    csbENCABEZADO_XML   CONSTANT VARCHAR2(50) := '<?xml version="1.0" encoding="utf-8" ?>' || CHR(13);

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/11/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/11/2024  OSF-3280 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcTipoRefXMLPagoCupon 
    Descripcion     : Retorna el tipo de referencia y el XML para pagos con 
                      OS_PAYMENT
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/11/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/11/2024  OSF-3280 Creacion
    ***************************************************************************/                     
    PROCEDURE prcTipoRefXMLPagoCupon
    (
        inuCupon            IN  NUMBER, 
        onuTipoReferencia   OUT NUMBER, 
        osbXMLReferencia    OUT CLOB
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcTipoRefXMLPagoCupon';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        onuTipoReferencia := cnuTIPO_REF_CUPON;
        
        osbXMLReferencia := NULL;
        osbXMLReferencia := osbXMLReferencia || csbENCABEZADO_XML;
        osbXMLReferencia := osbXMLReferencia || '<Pago_Cupon>' || chr(13);
        osbXMLReferencia := osbXMLReferencia || '	<Cupon>'|| inuCupon ||'</Cupon>'|| chr(13);
        osbXMLReferencia := osbXMLReferencia || '</Pago_Cupon>'|| chr(13);
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                   
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcTipoRefXMLPagoCupon;

    FUNCTION fsbElementoXML( isbTagXML VARCHAR2, isbValor VARCHAR2)
    RETURN VARCHAR2
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbElementoXML';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        sbElementoXML   VARCHAR2(32000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        IF isbValor IS NULL THEN
            sbElementoXML := '<' || isbTagXML || '/' || '>';
        ELSE
            sbElementoXML := '<' || isbTagXML || '>' || isbValor || '</' || isbTagXML || '>' ;        
        END IF;

        sbElementoXML := sbElementoXML || CHR(13);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

        pkg_traza.trace('sbElementoXML[' ||sbElementoXML || ']', csbNivelTraza ); 
                        
        RETURN sbElementoXML;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbElementoXML;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbElementoXML;   
    END fsbElementoXML;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcXMLPago 
    Descripcion     : Retorna el XML para pagos con OS_PAYMENT
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/11/2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07/11/2024  OSF-3280    Creacion
    ***************************************************************************/                     
    PROCEDURE prcXMLPago
    ( 
        inuBanco                IN  NUMBER , 
        inuSucursal             IN  NUMBER , 
        isbFechaPago            IN  VARCHAR2,  
        inuValorPago            IN  NUMBER,
        osbXMLPago              OUT CLOB,
        inuConciliacion          IN  NUMBER   DEFAULT NULL, 
        isbTransaccion          IN  VARCHAR2 DEFAULT NULL,
        isbFormaPago            IN  VARCHAR2 DEFAULT 'EF',
        inuClaseDocumento       IN  NUMBER   DEFAULT NULL,
        isbDocumento            IN  VARCHAR2 DEFAULT NULL,
        isbEntExpDocumento      IN  VARCHAR2 DEFAULT NULL,
        isbNumeroAutorizacion   IN  VARCHAR2 DEFAULT NULL,
        inuNumeroMeses          IN  NUMBER   DEFAULT NULL,
        isbNumeroCuenta         IN  VARCHAR2 DEFAULT NULL,
        isbPrograma             IN  VARCHAR2 DEFAULT 'OS_PAYMENT', 
        isbTerminal             IN  VARCHAR2 DEFAULT 'desconocida'
    )
    IS
        -- Nombre de este método
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcXMLPago';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
                
        osbXMLPago := NULL;
        
        osbXMLPago := osbXMLPago || csbENCABEZADO_XML ;
        
        osbXMLPago := osbXMLPago || '<Informacion_Pago>' || CHR(13);
        osbXMLPago := osbXMLPago || '    <Conciliacion>' || CHR(13);
        
        osbXMLPago := osbXMLPago || fsbElementoXML( 'Cod_Conciliacion', inuConciliacion );
                      
        osbXMLPago := osbXMLPago || fsbElementoXML( 'Entidad_Conciliacion', inuBanco );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Fecha_Conciliacion', isbFechaPago );
                
        osbXMLPago := osbXMLPago || '    </Conciliacion>' || CHR(13);

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Entidad_Recaudo', inuBanco );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Punto_Pago', inuSucursal );
        
        osbXMLPago := osbXMLPago || fsbElementoXML( 'Valor_Pagado', inuValorPago );                        
        
        osbXMLPago := osbXMLPago || fsbElementoXML( 'Fecha_Pago', isbFechaPago );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'No_Transaccion', isbTransaccion );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Forma_Pago', isbFormaPago );
                
        osbXMLPago := osbXMLPago || fsbElementoXML( 'Clase_Documento', inuClaseDocumento );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'No_Documento', isbDocumento );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Ent_Exp_Documento', isbEntExpDocumento );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'No_Autorizacion', isbNumeroAutorizacion );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'No_Meses', inuNumeroMeses );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'No_Cuenta', isbNumeroCuenta );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Programa', isbPrograma );

        osbXMLPago := osbXMLPago || fsbElementoXML( 'Terminal', isbTerminal );
                                                      
        osbXMLPago := osbXMLPago || '</Informacion_Pago>'|| CHR(13);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcXMLPago;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcPagoCupon 
    Descripcion     : Realiza el pago de un cupón  
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/11/2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07/11/2024  OSF-3280    Creacion
    ***************************************************************************/    
    PROCEDURE prcPagoCupon
    (
        inuCupon        IN  NUMBER , 
        inuBanco        IN  NUMBER , 
        inuSucursal     IN  NUMBER , 
        isbFechaPago    IN  VARCHAR2,  
        inuValorPago    IN  NUMBER,
        osbXMLCupones   OUT CLOB, 
        onuError        OUT NUMBER, 
        osbError        OUT VARCHAR2,
        inuConciliacion IN  NUMBER DEFAULT NULL,
        isbFormaPago    IN  VARCHAR2 DEFAULT 'EF',
        isbTerminal     IN  VARCHAR2 DEFAULT USERENV('TERMINAL')              
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcPagoCupon';
        nuTipoReferencia    NUMBER(1);
        sbXMLReferencia     CLOB;
        sbXMLPago           CLOB;
        sbXMLCupones        CLOB;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        prcTipoRefXMLPagoCupon( inuCupon , nuTipoReferencia, sbXMLReferencia );

        pkg_traza.trace('sbXMLReferencia[' || sbXMLReferencia || ']', csbNivelTraza);
        
        prcXMLPago
        ( 
            inuBanco        => inuBanco, 
            inuSucursal     => inuSucursal, 
            isbFechaPago    => isbFechaPago, 
            inuValorPago    => inuValorPago,
            inuConciliacion => inuConciliacion,
            isbFormaPago    => isbFormaPago,
            isbTerminal     => isbTerminal,
            osbXMLPago      => sbXMLPago 
        );

        pkg_traza.trace('sbXMLPago[' || sbXMLPago || ']', csbNivelTraza);
       
        api_paymentsregister( nuTipoReferencia, sbXMLReferencia, sbXMLPago, sbXMLCupones, onuError, osbError);
                 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuError,osbError);        
            pkg_traza.trace('osbError => ' || osbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onuError, osbError);
            pkg_traza.trace('osbError => ' || osbError, csbNivelTraza );
    END prcPagoCupon;    
       
END pkg_GestionPagos;
/

Prompt Otorgando permisos sobre ADM_PERSON.pkg_GestionPagos
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_GestionPagos'), 'ADM_PERSON');
END;
/

