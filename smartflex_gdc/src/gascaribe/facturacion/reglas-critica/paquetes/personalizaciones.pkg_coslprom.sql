CREATE OR REPLACE PACKAGE personalizaciones.PKG_coslprom
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   PKG_coslprom
    Descripción :   Paquete de primer nivel, para la tabla COSLPROM
    Autor       :   jcatuchemvm
    Fecha       :   29/01/2024
    WO          :   OSF-889
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    29/01/2024    jcatuchemvm   OSF-2231: Creación del paquete 
***************************************************************************/
                
    --------------------------------------------
    -- Variables
    --------------------------------------------

    -- Cursor para accesar COSLPROM
    CURSOR cuCOSLPROM
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    )
    IS
        SELECT  *
        FROM    COSLPROM
        WHERE   CONTRATO = inuCONTRATO
        AND     PRODUCTO = inuPRODUCTO
        AND     FECHA = idtFECHA;
        
    subtype styCOSLPROM  is  COSLPROM%rowtype;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    -- Insertar un registro
    PROCEDURE InsertaRegistro
    (
        ircRecord in COSLPROM%rowtype
    );

    
    -- Indica si el registro existe
    FUNCTION fblExiste
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE,
        inuCACHE IN NUMBER DEFAULT 1
    )
    RETURN BOOLEAN;
    
    

END PKG_coslprom;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.PKG_coslprom
IS    
    -------------------------
    --  PRIVATE VARIABLES
    -------------------------
    -- Constantes para el control de la traza
    csbPaquete          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre del paquete    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este paquete. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado


    -- Record Tabla COSLPROM
    rcCOSLPROM cuCOSLPROM%ROWTYPE;
    
    -- Record nulo de la Tabla COSLPROM
    rcRecordNull COSLPROM%ROWTYPE;
    
    nuError             NUMBER;
    sbError             VARCHAR2(2000);
        
    -------------------------
    --   PRIVATE METHODS   
    -------------------------
    FUNCTION fsbMensajeError
    ( 
        inuMENSAJE IN Ge_Message.Message_Id%TYPE,
        isbPk      IN Ge_Message.Description%TYPE := NULL
    )
    RETURN VARCHAR2;
    
    PROCEDURE Cargar
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    );
        
    PROCEDURE CargarRegistro
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    );
        
    FUNCTION fblEnMemoria
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    )
    RETURN BOOLEAN;

    -----------------
    -- CONSTANTES
    -----------------
    CACHE                      CONSTANT NUMBER := 1;   -- Buscar en Cache
    
    -------------------------
    --  PRIVATE CONSTANTS
    -------------------------
    cnuRECORD_NO_EXISTE        CONSTANT NUMBER := 1; -- Reg. no esta en BD
    cnuRECORD_YA_EXISTE        CONSTANT NUMBER := 2; -- Reg. ya esta en BD    
    -- Texto adicionar para mensaje de error
    csbTABLA_PK                CONSTANT VARCHAR2(200):= '(Tabla COSLPROM) ( PK [';
    csb_TABLA                  CONSTANT VARCHAR2(200):= '(Tabla COSLPROM)';

    FUNCTION fsbMensajeError
    ( 
        inuMENSAJE IN Ge_Message.Message_Id%TYPE,
        isbPk      IN Ge_Message.Description%TYPE := NULL
    )
    RETURN VARCHAR2
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fsbMensajeError';
        sbMensaje VARCHAR2( 32000 );
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuMENSAJE <= '||inuMENSAJE, csbNivelTraza);
        pkg_traza.trace('isbPk      <= '||isbPk, csbNivelTraza);
        
        sbMensaje := ldc_bcconsgenerales.fsbValorColumna('Ge_Message','description','message_id',to_char(inuMENSAJE));
        IF isbPk IS NULL THEN
            sbMensaje := REPLACE( sbMensaje, '%s1', csb_TABLA );
        ELSE
            sbMensaje := REPLACE( sbMensaje, '%s1', csbTABLA_PK||isbPk||'] )' );
        END IF;
        
        pkg_traza.trace('return => '||sbMensaje, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN sbMensaje;        
    END fsbMensajeError;
    -- Carga
    PROCEDURE Cargar
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    )
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'Cargar';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCONTRATO    <= '||inuCONTRATO, csbNivelTraza);
        pkg_traza.trace('inuPRODUCTO    <= '||inuPRODUCTO, csbNivelTraza);
        pkg_traza.trace('idtFECHA       <= '||idtFECHA, csbNivelTraza);
        
        CargarRegistro
        (
            inuCONTRATO,inuPRODUCTO,idtFECHA
        );
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcCOSLPROM.CONTRATO IS NULL ) THEN
            RAISE NO_DATA_FOUND;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            Pkg_Error.setErrorMessage( cnuRECORD_NO_EXISTE, fsbMensajeError(cnuRECORD_NO_EXISTE) );
    END Cargar;
    
    -- Carga    
    PROCEDURE CargarRegistro
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    )
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'CargarRegistro';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCONTRATO    <= '||inuCONTRATO, csbNivelTraza);
        pkg_traza.trace('inuPRODUCTO    <= '||inuPRODUCTO, csbNivelTraza);
        pkg_traza.trace('idtFECHA       <= '||idtFECHA, csbNivelTraza);
        
        IF ( cuCOSLPROM%ISOPEN ) THEN
            CLOSE cuCOSLPROM;
        END IF;
        -- Accesa COSLPROM de la BD
        OPEN cuCOSLPROM
        (
            inuCONTRATO,
            inuPRODUCTO,
            idtFECHA
        );
        FETCH cuCOSLPROM INTO rcCOSLPROM;
        IF ( cuCOSLPROM%NOTFOUND ) then
            rcCOSLPROM := rcRecordNull;
        END IF;
        CLOSE cuCOSLPROM;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    END CargarRegistro;    
    
    -- Indica si está en memoria  
    FUNCTION fblEnMemoria
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE
    )
    RETURN BOOLEAN
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fblEnMemoria';
        blExiste    boolean;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCONTRATO    <= '||inuCONTRATO, csbNivelTraza);
        pkg_traza.trace('inuPRODUCTO    <= '||inuPRODUCTO, csbNivelTraza);
        pkg_traza.trace('idtFECHA       <= '||idtFECHA, csbNivelTraza);
        
        IF ( rcCOSLPROM.CONTRATO = inuCONTRATO AND rcCOSLPROM.PRODUCTO = inuPRODUCTO AND rcCOSLPROM.FECHA = idtFECHA) THEN
            blExiste := TRUE;
        ELSE
            blExiste := FALSE;
        END IF;
        
        pkg_traza.trace('return => '||CASE WHEN blExiste THEN 'True' ELSE 'False' END, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN( blExiste );        
    END fblEnMemoria;
    
    
    -- Inserta un registro
    PROCEDURE InsertaRegistro
    (
        ircRecord in COSLPROM%ROWTYPE
    )
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'InsertaRegistro';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);    
        pkg_traza.trace('ircRecord.CONTRATO    <= '||ircRecord.CONTRATO, csbNivelTraza);
        pkg_traza.trace('ircRecord.PRODUCTO    <= '||ircRecord.PRODUCTO, csbNivelTraza);
        pkg_traza.trace('ircRecord.PERIODO     <= '||ircRecord.PERIODO, csbNivelTraza);
        pkg_traza.trace('ircRecord.PERICONS    <= '||ircRecord.PERICONS, csbNivelTraza);
        pkg_traza.trace('ircRecord.REGLA       <= '||ircRecord.REGLA, csbNivelTraza);
        pkg_traza.trace('ircRecord.OBSERVACION <= '||ircRecord.OBSERVACION, csbNivelTraza);
        pkg_traza.trace('ircRecord.FECHA       <= '||ircRecord.FECHA, csbNivelTraza);
        
        INSERT INTO COSLPROM
        (
            CONTRATO,
            PRODUCTO,
            PERIODO,
            PERICONS,
            REGLA,
            OBSERVACION, 
            FECHA,
            USUARIO
        ) 
        VALUES 
        (
            ircRecord.CONTRATO,
            ircRecord.PRODUCTO,
            ircRecord.PERIODO,
            ircRecord.PERICONS,
            ircRecord.REGLA,
            ircRecord.OBSERVACION,
            NVL(ircRecord.FECHA,SYSDATE),
            PKG_SESSION.GETUSER
        );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            Pkg_Error.setErrorMessage( cnuRECORD_YA_EXISTE, fsbMensajeError(cnuRECORD_YA_EXISTE) );
    END InsertaRegistro;
    
    -- Valida si el registro existe
    FUNCTION fblExiste
    (
        inuCONTRATO IN COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN COSLPROM.FECHA%TYPE,
        inuCACHE    IN NUMBER DEFAULT 1
    )
    RETURN BOOLEAN
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fblExiste';
        blExiste    boolean;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio); 
        pkg_traza.trace('inuCONTRATO    <= '||inuCONTRATO, csbNivelTraza);
        pkg_traza.trace('inuPRODUCTO    <= '||inuPRODUCTO, csbNivelTraza);
        pkg_traza.trace('idtFECHA       <= '||idtFECHA, csbNivelTraza);
        pkg_traza.trace('INUCACHE       <= '||INUCACHE, csbNivelTraza);   
        --Valida si debe buscar primero en memoria Caché
        IF (inuCACHE = CACHE AND fblEnMemoria( inuCONTRATO, inuPRODUCTO, idtFECHA ) ) THEN
                blExiste := TRUE;
        END IF;
        CargarRegistro
        (
            inuCONTRATO,inuPRODUCTO,idtFECHA
        );
            
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcCOSLPROM.CONTRATO IS NULL ) THEN
            blExiste := FALSE;
        ELSE
            blExiste := TRUE;
        END IF;
        
        pkg_traza.trace('return => '||CASE WHEN blExiste THEN 'True' ELSE 'False' END, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN( blExiste );
        
    END fblExiste;
    
    
       
END PKG_coslprom;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.PKG_coslprom
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_COSLPROM','PERSONALIZACIONES');
END;
/
