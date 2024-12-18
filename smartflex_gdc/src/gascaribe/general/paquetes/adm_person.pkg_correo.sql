CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_Correo AS
/*******************************************************************************
    Package:        pkg_Correo
    Descripción:    Paquete con procedimientos para el envio de correos
    Fecha:          20/02/2024 

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    20/02/2024      jpinedc             OSF-2490 : Creación
    20/02/2024      jpinedc             OSF-2490 : Ajustes validación técnica
    19/04/2024      jpinedc             OSF-2614 : Se guardan datos del correo en
                                        ESTAPROC similar a como lo hace ldc_sendemail
    19/04/2024      jpinedc             OSF-2614 : Se guardan datos del correo en
                                        ESTAPROC similar a como lo hace ldc_sendemail                                        
    29/05/2024      jpinedc             OSF-2765 : * Se agrega parametro a prcEnviaCorreo
                                        * Se crea prcEnviaCorreo sin isbRemitente
                                        * Se crea fblCorreoValido
    24/06/2024      jpinedc             OSF-2875 : Se pasa a ADM_PERSON    
*******************************************************************************/

    -- Retorna la constante con la ultimo caso que lo modificó
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Envia correo simple por medio de servidor de correo
	PROCEDURE prcEnviaCorreo
    (
        isbRemitente        VARCHAR2,
        isbDestinatarios    VARCHAR2,
        isbAsunto           VARCHAR2,
        isbMensaje          VARCHAR2,
        isbDestinatariosCC  VARCHAR2 DEFAULT NULL,
        isbDestinatariosBCC VARCHAR2 DEFAULT NULL,
        isbArchivos         VARCHAR2 DEFAULT NULL,
        inuPrioridad        NUMBER   DEFAULT NULL,
        isbDescRemitente    VARCHAR2 DEFAULT NULL,
        iblElevaErrores     BOOLEAN DEFAULT FALSE
    );
    
    -- Envia correo simple por medio de servidor de correo remitente defult
	PROCEDURE prcEnviaCorreo
    (
        isbDestinatarios    VARCHAR2,
        isbAsunto           VARCHAR2,
        isbMensaje          VARCHAR2,
        isbDestinatariosCC  VARCHAR2 DEFAULT NULL,
        isbDestinatariosBCC VARCHAR2 DEFAULT NULL,
        isbArchivos         VARCHAR2 DEFAULT NULL,
        inuPrioridad        NUMBER   DEFAULT NULL,
        isbDescRemitente    VARCHAR2 DEFAULT NULL,
        iblElevaErrores     BOOLEAN DEFAULT FALSE
    );    
    
    -- Retorna verdadero si isbCorreo es un correo valido
    FUNCTION fblCorreoValido( isbCorreo VARCHAR2) RETURN BOOLEAN;    
    
END pkg_Correo;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_Correo AS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef; 
    
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-2875';    
    
    /*******************************************************************************
    Método:         fsbVersion
    Descripción:    Funcion que retorna la csbVersion, la cual indica el último
                    caso que modificó el paquete. Se actualiza cada que se ajusta
                    algún Método del paquete

    Autor:          Lubin Pineda
    Fecha:          20/02/2024

    Entrada         Descripción
    NA

    Salida          Descripción
    csbVersion      Ultima version del paquete

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    20/02/2024      jpinedc             OSF-2341 : Creación
    *******************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;    


    /*******************************************************************************
    Método:         prcEnviaCorreo
    Descripción:    Envia correo con o sin archivos por medio de servidor de correo. 

    Fecha:          20/02/2024

    Entrada             Descripción
    isRemitente         Remitente del correo
    isbDestinatarios    Destinatarios del correo
    isbAsunto           Asunto del correo
    isbMensaje          Mensaje del correo

    Retorno          Descripción


    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    20/02/2024      jpinedc             OSF-2341 : Creación
    19/04/2024      jpinedc             OSF-XXXX : Se insertan datos del mensaje 
                                        en ESTAPROC
    *******************************************************************************/
	PROCEDURE prcEnviaCorreo
    (
        isbRemitente        VARCHAR2,
        isbDestinatarios    VARCHAR2,
        isbAsunto           VARCHAR2,
        isbMensaje          VARCHAR2,
        isbDestinatariosCC  VARCHAR2 DEFAULT NULL,
        isbDestinatariosBCC VARCHAR2 DEFAULT NULL,
        isbArchivos         VARCHAR2 DEFAULT NULL,
        inuPrioridad        NUMBER   DEFAULT NULL,
        isbDescRemitente    VARCHAR2 DEFAULT NULL,
        iblElevaErrores     BOOLEAN DEFAULT FALSE        
    )
	IS
        csbMetodo1        CONSTANT VARCHAR2(105) := csbSP_NAME || 'prcEnviaCorreo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbProceso       varchar2(100) := csbMetodo1||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nuCantReg       NUMBER := 1;
        sbAsunto        VARCHAR2(4000);
        sbInstanciaBD   VARCHAR2(40);
        sbLogError      VARCHAR2(32000);                
    BEGIN
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

        sbInstanciaBD := ldc_boConsGenerales.fsbGetDatabaseDesc;

        IF (LENGTH(sbInstanciaBD)) > 0 THEN
            sbInstanciaBD := 'BD ' || sbInstanciaBD || ': ';
        END IF;

        sbAsunto := sbInstanciaBD || isbAsunto;        
                
        pkg_boGestionCorreo.prcEnviaCorreo
        (
            isbRemitente,
            isbDestinatarios, 
            sbAsunto, 
            isbMensaje,
            isbDestinatariosCC,
            isbDestinatariosBCC,
            isbArchivos,
            inuPrioridad,
            isbDescRemitente
        );
        
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError( nuError, sbError);
            pkg_EstaProc.prInsertaEstaproc ( sbProceso, nuCantReg );
            sbLogError  := isbDestinatarios || chr(10) || '***' || chr(10) || sbAsunto || chr(10) || '***' || chr(10) || isbMensaje || chr(10) || '***' || chr(10) || sbError;
            sbLogError  :=  SUBSTR(sbLogError,1,4000);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbLogError  );
            IF iblElevaErrores THEN
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError( nuError, sbError);
            pkg_EstaProc.prInsertaEstaproc ( sbProceso, nuCantReg );
            sbLogError  := isbDestinatarios || chr(10) || '***' || chr(10) || sbAsunto || chr(10) || '***' || chr(10) || isbMensaje || chr(10) || '***' || chr(10) || sbError;
            sbLogError  :=  SUBSTR(sbLogError,1,4000);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbLogError  );
            IF iblElevaErrores THEN
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;            
    END prcEnviaCorreo; 
    

    /*******************************************************************************
    Método:         prcEnviaCorreo
    Descripción:    Envia correo con o sin archivos por medio de servidor de correo
                    con remitente por defecto

    Fecha:          29/05/2024

    Entrada             Descripción
    isbDestinatarios    Destinatarios del correo
    isbAsunto           Asunto del correo
    isbMensaje          Mensaje del correo

    Retorno          Descripción


    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    29/05/2024      jpinedc             OSF-2765 : Creación
    *******************************************************************************/
	PROCEDURE prcEnviaCorreo
    (
        isbDestinatarios    VARCHAR2,
        isbAsunto           VARCHAR2,
        isbMensaje          VARCHAR2,
        isbDestinatariosCC  VARCHAR2 DEFAULT NULL,
        isbDestinatariosBCC VARCHAR2 DEFAULT NULL,
        isbArchivos         VARCHAR2 DEFAULT NULL,
        inuPrioridad        NUMBER   DEFAULT NULL,
        isbDescRemitente    VARCHAR2 DEFAULT NULL,
        iblElevaErrores     BOOLEAN DEFAULT FALSE        
    )
	IS
        csbMetodo1        CONSTANT VARCHAR2(105) := csbSP_NAME || 'prcEnviaCorreo2';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbProceso       varchar2(100) := csbMetodo1||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nuCantReg       NUMBER := 1;
        sbLogError      VARCHAR2(32000); 
        
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
                  
    BEGIN
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_Correo.prcEnviaCorreo
        (
            sbRemitente,
            isbDestinatarios, 
            isbAsunto, 
            isbMensaje,
            isbDestinatariosCC,
            isbDestinatariosBCC,
            isbArchivos,
            inuPrioridad,
            isbDescRemitente,
            iblElevaErrores
        );
        
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError( nuError, sbError);
            pkg_EstaProc.prInsertaEstaproc ( sbProceso, nuCantReg );
            sbLogError  := isbDestinatarios || chr(10) || '***' || chr(10) || isbAsunto || chr(10) || '***' || chr(10) || isbMensaje || chr(10) || '***' || chr(10) || sbError;
            sbLogError  :=  SUBSTR(sbLogError,1,4000);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbLogError  );
            IF iblElevaErrores THEN
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError( nuError, sbError);
            pkg_EstaProc.prInsertaEstaproc ( sbProceso, nuCantReg );
            sbLogError  := isbDestinatarios || chr(10) || '***' || chr(10) || isbAsunto || chr(10) || '***' || chr(10) || isbMensaje || chr(10) || '***' || chr(10) || sbError;
            sbLogError  :=  SUBSTR(sbLogError,1,4000);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbLogError  );
            IF iblElevaErrores THEN
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;            
    END prcEnviaCorreo;        

    -- Retorna verdadero si isbCorreo es un correo valido
    FUNCTION fblCorreoValido( isbCorreo VARCHAR2) RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblCorreoValido';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    
        blCorreoValido  BOOLEAN := FALSE;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    
        blCorreoValido := pkg_bogestioncorreo.fblCorreoValido(isbCorreo);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        RETURN blCorreoValido;
        
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
    END fblCorreoValido;

END pkg_Correo;
/

