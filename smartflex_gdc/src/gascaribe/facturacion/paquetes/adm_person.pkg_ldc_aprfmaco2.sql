CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_aprfmaco2 AS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Autor : PACOSTA
    Descr : Paquete de manejo de datos para la tabla ldc_aprfmaco2
    Tabla : ldc_aprfmaco2
    Caso  : OSF-3881
    Fecha : 22/01/2025 09:08:11
    ***************************************************************************/
    
    --Tipos globales del paquete
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF ldc_aprfmaco2%ROWTYPE INDEX BY BINARY_INTEGER;
    
    --Cursores globales del paquete
    CURSOR cuLdc_aprfmaco2 
    IS 
    SELECT * 
    FROM ldc_aprfmaco2;
    
    CURSOR cuRegistroRId 
    (
        inuApr_id    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ldc_aprfmaco2 tb
        WHERE
        apr_id = inuApr_id;
     
    CURSOR cuRegistroRIdLock
    (
        inuApr_id    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ldc_aprfmaco2 tb
        WHERE
        apr_id = inuApr_id
        FOR UPDATE NOWAIT;
    
    --Metodos del paquete 
    
    --Retorna version del paquete
    FUNCTION fsbversion RETURN VARCHAR2;
    
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuApr_id    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuApr_id    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepcion si el registro NO existe
    PROCEDURE prcValExiste(
        inuApr_id    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prcInsRegistro( ircRegistro cuLdc_aprfmaco2%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prcBorRegistro(
        inuApr_id    NUMBER
    ); 
 
    -- Obtiene el valor de la columna APR_COSSESU
    FUNCTION fnuObtApr_cossesu(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.apr_cossesu%TYPE;
 
    -- Obtiene el valor de la columna APRCOSSPECS
    FUNCTION fnuObtAprcosspecs(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspecs%TYPE;
 
    -- Obtiene el valor de la columna APRCOSSPECSANT
    FUNCTION fnuObtAprcosspecsant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspecsant%TYPE;
 
    -- Obtiene el valor de la columna APRCOSSPEFA
    FUNCTION fnuObtAprcosspefa(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspefa%TYPE;
 
    -- Obtiene el valor de la columna APRCOSSPEFANT
    FUNCTION fnuObtAprcosspefant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspefant%TYPE;
 
    -- Obtiene el valor de la columna APRCOSSELME
    FUNCTION fnuObtAprcosselme(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosselme%TYPE;
 
    -- Obtiene el valor de la columna APRCOSSELMEANT
    FUNCTION fnuObtAprcosselmeant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosselmeant%TYPE;
 
    -- Obtiene el valor de la columna APRCOCA_NEW
    FUNCTION fnuObtAprcoca_new(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoca_new%TYPE;
 
    -- Obtiene el valor de la columna APRCOCA_ANT
    FUNCTION fnuObtAprcoca_ant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoca_ant%TYPE;
 
    -- Obtiene el valor de la columna APRESTADO
    FUNCTION fsbObtAprestado(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprestado%TYPE;
 
    -- Obtiene el valor de la columna APR_COSSROWID
    FUNCTION fsbObtApr_cossrowid(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.apr_cossrowid%TYPE;
 
    -- Obtiene el valor de la columna APRUSUSOLIC
    FUNCTION fsbObtAprususolic(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprususolic%TYPE;
 
    -- Obtiene el valor de la columna APRUSUAPROV
    FUNCTION fsbObtAprusuaprov(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprusuaprov%TYPE;
 
    -- Obtiene el valor de la columna APRFECHA_SOL
    FUNCTION fdtObtAprfecha_sol(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprfecha_sol%TYPE;
 
    -- Obtiene el valor de la columna APRFECHA_APR
    FUNCTION fdtObtAprfecha_apr(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprfecha_apr%TYPE;
 
    -- Obtiene el valor de la columna APRFECREG
    FUNCTION fdtObtAPrfecreg(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprfecreg%TYPE;
 
    -- Obtiene el valor de la columna NUSESION
    FUNCTION fnuObtNusesion(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.nusesion%TYPE;
 
    -- Obtiene el valor de la columna APRCOMENT_REG
    FUNCTION fsbObtAprcoment_reg(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoment_reg%TYPE;
 
    -- Obtiene el valor de la columna APRCOMENT_APR
    FUNCTION fsbObtAprcoment_apr(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoment_apr%TYPE;
 
    -- Actualiza el valor de la columna APR_COSSESU
    PROCEDURE prcActApr_cossesu(
        inuApr_id    NUMBER,
        inuApr_cossesu    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOSSPECS
    PROCEDURE prcActAprcosspecs(
        inuApr_id    NUMBER,
        inuAprcosspecs    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOSSPECSANT
    PROCEDURE prcActAprcosspecsant(
        inuApr_id    NUMBER,
        inuAprcosspecsant    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOSSPEFA
    PROCEDURE prcActAprcosspefa(
        inuApr_id    NUMBER,
        inuAprcosspefa    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOSSPEFANT
    PROCEDURE prcActAprcosspefant(
        inuApr_id    NUMBER,
        inuAprcosspefant    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOSSELME
    PROCEDURE prcActAprcosselme(
        inuApr_id    NUMBER,
        inuAprcosselme    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOSSELMEANT
    PROCEDURE prcActAprcosselmeant(
        inuApr_id    NUMBER,
        inuAprcosselmeant    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOCA_NEW
    PROCEDURE prcActAprcoca_new(
        inuApr_id    NUMBER,
        inuAprcoca_new    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOCA_ANT
    PROCEDURE prcActAprcoca_ant(
        inuApr_id    NUMBER,
        inuAprcoca_ant    NUMBER
    );
 
    -- Actualiza el valor de la columna APRESTADO
    PROCEDURE prcActAprestado(
        inuApr_id    NUMBER,
        isbAprestado    VARCHAR2
    );
 
    -- Actualiza el valor de la columna APR_COSSROWID
    PROCEDURE prcActApr_cossrowid(
        inuApr_id    NUMBER,
        isbApr_cossrowid    VARCHAR2
    );
 
    -- Actualiza el valor de la columna APRUSUSOLIC
    PROCEDURE prcActAprususolic(
        inuApr_id    NUMBER,
        isbAprususolic    VARCHAR2
    );
 
    -- Actualiza el valor de la columna APRUSUAPROV
    PROCEDURE prcActAprusuaprov(
        inuApr_id    NUMBER,
        isbAprusuaprov    VARCHAR2
    );
 
    -- Actualiza el valor de la columna APRFECHA_SOL
    PROCEDURE prcActAprfecha_sol(
        inuApr_id    NUMBER,
        idtAprfecha_sol    DATE
    );
 
    -- Actualiza el valor de la columna APRFECHA_APR
    PROCEDURE prcActAprfecha_apr(
        inuApr_id    NUMBER,
        idtAprfecha_apr    DATE
    );
 
    -- Actualiza el valor de la columna APRFECREG
    PROCEDURE prcActAprfecreg(
        inuApr_id    NUMBER,
        idtAprfecreg    DATE
    );
 
    -- Actualiza el valor de la columna NUSESION
    PROCEDURE prcActNusesion(
        inuApr_id    NUMBER,
        inuNusesion    NUMBER
    );
 
    -- Actualiza el valor de la columna APRCOMENT_REG
    PROCEDURE prcActAprcoment_reg(
        inuApr_id    NUMBER,
        isbAprcoment_reg    VARCHAR2
    );
 
    -- Actualiza el valor de la columna APRCOMENT_APR
    PROCEDURE prcActAprcoment_apr(
        inuApr_id    NUMBER,
        isbAprcoment_apr    VARCHAR2
    );
 
END pkg_ldc_aprfmaco2;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_aprfmaco2 AS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC y EFG">
    <Unidad>pkg_ldc_aprfmaco2</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>22-01-2025</Fecha>
    <Descripcion> 
        Paquete de manejo de datos para la tabla ldc_aprfmaco2
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="22-01-2025" Inc="OSF-3881" Empresa="GDC">
               Creación
           </Modificacion>                          
     </Historial>
     </Package>
    ******************************************************************/
    -- Constantes globales del paquete
    csbversion       CONSTANT VARCHAR2(10) := 'OSF-3881';  
    csbPqt_nombre    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';         
    
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.cnuniveltrzdef;
    csbInicio        CONSTANT VARCHAR2(35) := pkg_traza.fsbInicio; 
    csbFin           CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err       CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc       CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    
    -- Metodos del paquete     
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbversion
    Descripcion    : Retorna version del paquete
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbversion RETURN VARCHAR2 IS
    BEGIN   
        RETURN csbversion;
    END fsbversion;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : frcObtRegistroRId
    Descripcion    : Obtiene registro y RowId
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION frcObtRegistroRId(
        inuApr_id    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuApr_id);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuApr_id);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroRId;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END frcObtRegistroRId;
   
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fblExiste
    Descripcion    : Retorna verdadero si el registro existe
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fblExiste(
        inuApr_id    NUMBER
    ) RETURN BOOLEAN IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroRId := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroRId.APR_ID IS NOT NULL;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fblExiste;
     
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcValExiste
    Descripcion    : Eleva error si el registro no existe
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcValExiste(
        inuApr_id    NUMBER
    ) IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        IF NOT fblExiste(inuApr_id) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuApr_id||'] en la tabla[LDC_APRFMACO2]');
        END IF;
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcValExiste;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcInsRegistro
    Descripcion    : Inserta un registro
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion     
    ******************************************************************/
    PROCEDURE prcInsRegistro( ircRegistro cuLdc_aprfmaco2%ROWTYPE) IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        
        
        INSERT INTO ldc_aprfmaco2(
            apr_id,apr_cossesu,aprcosspecs,aprcosspecsant,aprcosspefa,aprcosspefant,aprcosselme,aprcosselmeant,aprcoca_new,aprcoca_ant,aprestado,apr_cossrowid,aprususolic,aprusuaprov,aprfecha_sol,aprfecha_apr,aprfecreg,nusesion,aprcoment_reg,aprcoment_apr
        )
        VALUES (
            seq_ldc_aprfmaco.NEXTVAL,ircRegistro.apr_cossesu,ircRegistro.aprcosspecs,ircRegistro.aprcosspecsant,ircRegistro.aprcosspefa,ircRegistro.aprcosspefant,ircRegistro.aprcosselme,ircRegistro.aprcosselmeant,ircRegistro.aprcoca_new,ircRegistro.aprcoca_ant,ircRegistro.aprestado,ircRegistro.apr_cossrowid,ircRegistro.aprususolic,ircRegistro.aprusuaprov,ircRegistro.aprfecha_sol,ircRegistro.aprfecha_apr,ircRegistro.aprfecreg,ircRegistro.nusesion,ircRegistro.aprcoment_reg,ircRegistro.aprcoment_apr
        );
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcInsRegistro;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcBorRegistro
    Descripcion    : Borra un registro
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcBorRegistro(
        inuApr_id    NUMBER
    ) IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
            DELETE ldc_aprfmaco2
            WHERE  apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcBorRegistro;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtApr_cossesu
    Descripcion    : Obtiene el valor de la columna APR_COSSESU
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtApr_cossesu(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.apr_cossesu%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtApr_cossesu';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.apr_cossesu;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtApr_cossesu;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcosspecs
    Descripcion    : Obtiene el valor de la columna APRCOSSPECS
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcosspecs(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspecs%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcosspecs';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcosspecs;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcosspecs;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcosspecsant
    Descripcion    : Obtiene el valor de la columna APRCOSSPECSANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcosspecsant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspecsant%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcosspecsant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcosspecsant;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcosspecsant;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcosspefa
    Descripcion    : Obtiene el valor de la columna APRCOSSPEFA
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcosspefa(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspefa%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcosspefa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcosspefa;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcosspefa;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcosspefant
    Descripcion    : Obtiene el valor de la columna APRCOSSPEFANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcosspefant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosspefant%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcosspefant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcosspefant;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcosspefant;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcosselme
    Descripcion    : Obtiene el valor de la columna APRCOSSELME
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcosselme(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosselme%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcosselme';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcosselme;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcosselme;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcosselmeant
    Descripcion    : Obtiene el valor de la columna APRCOSSELMEANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcosselmeant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcosselmeant%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcosselmeant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcosselmeant;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcosselmeant;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcoca_new
    Descripcion    : Obtiene el valor de la columna APRCOCA_NEW
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcoca_new(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoca_new%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcoca_new';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcoca_new;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcoca_new;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtAprcoca_ant
    Descripcion    : Obtiene el valor de la columna APRCOCA_ANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtAprcoca_ant(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoca_ant%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtAprcoca_ant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcoca_ant;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtAprcoca_ant;
  
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbObtAprestado
    Descripcion    : Obtiene el valor de la columna APRESTADO
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbObtAprestado(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprestado%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtAprestado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprestado;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fsbObtAprestado;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbObtApr_cossrowid
    Descripcion    : Obtiene el valor de la columna APR_COSSROWID
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbObtApr_cossrowid(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.apr_cossrowid%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtApr_cossrowid';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.apr_cossrowid;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fsbObtApr_cossrowid;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbObtAprususolic
    Descripcion    : Obtiene el valor de la columna APRUSUSOLIC
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbObtAprususolic(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprususolic%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtAprususolic';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprususolic;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fsbObtAprususolic;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbObtAprusuaprov
    Descripcion    : Obtiene el valor de la columna APRUSUAPROV
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbObtAprusuaprov(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprusuaprov%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtAprusuaprov';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprusuaprov;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fsbObtAprusuaprov;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fdtObtAprfecha_sol
    Descripcion    : Obtiene el valor de la columna APRFECHA_SOL
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fdtObtAprfecha_sol(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprfecha_sol%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtAprfecha_sol';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprfecha_sol;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fdtObtAprfecha_sol;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fdtObtAprfecha_apr
    Descripcion    : Obtiene el valor de la columna APRFECHA_APR
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fdtObtAprfecha_apr(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprfecha_apr%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtAprfecha_apr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprfecha_apr;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fdtObtAprfecha_apr;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fdtObtAPrfecreg
    Descripcion    : Obtiene el valor de la columna APRFECREG
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/    
    FUNCTION fdtObtAPrfecreg(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprfecreg%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtAPrfecreg';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprfecreg;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fdtObtAPrfecreg;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fnuObtNusesion
    Descripcion    : Obtiene el valor de la columna NUSESION
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fnuObtNusesion(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.nusesion%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtNusesion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.nusesion;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fnuObtNusesion;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbObtAprcoment_reg
    Descripcion    : Obtiene el valor de la columna APRCOMENT_REG
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbObtAprcoment_reg(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoment_reg%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtAprcoment_reg';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcoment_reg;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fsbObtAprcoment_reg;

    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbObtAprcoment_apr
    Descripcion    : Obtiene el valor de la columna APRCOMENT_APR
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    FUNCTION fsbObtAprcoment_apr(
        inuApr_id    NUMBER
        ) RETURN ldc_aprfmaco2.aprcoment_apr%TYPE
        IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtAprcoment_apr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuApr_id);
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        RETURN rcRegistroAct.aprcoment_apr;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END fsbObtAprcoment_apr;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActApr_cossesu
    Descripcion    : Actualiza el valor de la columna APR_COSSESU
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActApr_cossesu(
        inuApr_id    NUMBER,
        inuApr_cossesu    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActApr_cossesu';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET apr_cossesu=inuApr_cossesu
        WHERE apr_id = inuApr_id;
     
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActApr_cossesu;
  
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcosspecs
    Descripcion    : Actualiza el valor de la columna APRCOSSPECS
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcosspecs(
        inuApr_id    NUMBER,
        inuAprcosspecs    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcosspecs';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcosspecs=inuAprcosspecs
        WHERE apr_id = inuApr_id;
   
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcosspecs;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcosspecsant
    Descripcion    : Actualiza el valor de la columna APRCOSSPECSANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcosspecsant(
        inuApr_id    NUMBER,
        inuAprcosspecsant    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcosspecsant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
       
        UPDATE ldc_aprfmaco2
        SET aprcosspecsant=inuAprcosspecsant
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcosspecsant;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcosspefa
    Descripcion    : Actualiza el valor de la columna APRCOSSPEFA
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcosspefa(
        inuApr_id    NUMBER,
        inuAprcosspefa    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcosspefa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcosspefa=inuAprcosspefa
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcosspefa;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcosspefant
    Descripcion    : Actualiza el valor de la columna APRCOSSPEFANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcosspefant(
        inuApr_id    NUMBER,
        inuAprcosspefant    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcosspefant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcosspefant=inuAprcosspefant
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcosspefant;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcosselme
    Descripcion    : Actualiza el valor de la columna APRCOSSELME
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcosselme(
        inuApr_id    NUMBER,
        inuAprcosselme    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcosselme';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcosselme=inuAprcosselme
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcosselme;
  
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcosselmeant
    Descripcion    : Actualiza el valor de la columna APRCOSSELMEANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcosselmeant(
        inuApr_id    NUMBER,
        inuAprcosselmeant    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcosselmeant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
       
        UPDATE ldc_aprfmaco2
        SET aprcosselmeant=inuAprcosselmeant
        WHERE apr_id = inuApr_id;
     
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcosselmeant;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcoca_new
    Descripcion    : Actualiza el valor de la columna APRCOCA_NEW
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcoca_new(
        inuApr_id    NUMBER,
        inuAprcoca_new    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcoca_new';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcoca_new=inuAprcoca_new
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcoca_new;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcoca_ant
    Descripcion    : Actualiza el valor de la columna APRCOCA_ANT
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcoca_ant(
        inuApr_id    NUMBER,
        inuAprcoca_ant    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcoca_ant';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcoca_ant=inuAprcoca_ant
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcoca_ant;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprestado
    Descripcion    : Actualiza el valor de la columna APRESTADO
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprestado(
        inuApr_id    NUMBER,
        isbAprestado    VARCHAR2
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprestado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprestado=isbAprestado
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprestado;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActApr_cossrowid
    Descripcion    : Actualiza el valor de la columna APR_COSSROWID
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActApr_cossrowid(
        inuApr_id    NUMBER,
        isbApr_cossrowid    VARCHAR2
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActApr_cossrowid';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET apr_cossrowid=isbApr_cossrowid
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActApr_cossrowid;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprususolic
    Descripcion    : Actualiza el valor de la columna APRUSUSOLIC
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprususolic(
        inuApr_id    NUMBER,
        isbAprususolic    VARCHAR2
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprususolic';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprususolic=isbAprususolic
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprususolic;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprusuaprov
    Descripcion    : Actualiza el valor de la columna APRUSUAPROV
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprusuaprov(
        inuApr_id    NUMBER,
        isbAprusuaprov    VARCHAR2
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprusuaprov';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprusuaprov=isbAprusuaprov
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprusuaprov;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprfecha_sol
    Descripcion    : Actualiza el valor de la columna APRFECHA_SOL
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprfecha_sol(
        inuApr_id    NUMBER,
        idtAprfecha_sol    DATE
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprfecha_sol';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprfecha_sol=idtAprfecha_sol
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprfecha_sol;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprfecha_apr
    Descripcion    : Actualiza el valor de la columna APRFECHA_APR
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprfecha_apr(
        inuApr_id    NUMBER,
        idtAprfecha_apr    DATE
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprfecha_apr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprfecha_apr=idtAprfecha_apr
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprfecha_apr;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprfecreg
    Descripcion    : Actualiza el valor de la columna APRFECREG
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprfecreg(
        inuApr_id    NUMBER,
        idtAprfecreg    DATE
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprfecreg';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
       
        UPDATE ldc_aprfmaco2
        SET aprfecreg=idtAprfecreg
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprfecreg;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActNusesion
    Descripcion    : Actualiza el valor de la columna NUSESION
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActNusesion(
        inuApr_id    NUMBER,
        inuNusesion    NUMBER
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActNusesion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET nusesion=inuNusesion
        WHERE apr_id = inuApr_id;
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActNusesion;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcoment_reg
    Descripcion    : Actualiza el valor de la columna APRCOMENT_REG
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcoment_reg(
        inuApr_id    NUMBER,
        isbAprcoment_reg    VARCHAR2
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcoment_reg';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcoment_reg=isbAprcoment_reg
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcoment_reg;
 
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActAprcoment_apr
    Descripcion    : Actualiza el valor de la columna APRCOMENT_APR
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22-01-2025       PAcosta               OSF-3881: Creacion 
    ******************************************************************/
    PROCEDURE prcActAprcoment_apr(
        inuApr_id    NUMBER,
        isbAprcoment_apr    VARCHAR2
    )
    IS
        csbMtd_nombre        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActAprcoment_apr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        UPDATE ldc_aprfmaco2
        SET aprcoment_apr=isbAprcoment_apr
        WHERE apr_id = inuApr_id;
       
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActAprcoment_apr;
 
END pkg_ldc_aprfmaco2;
/
BEGIN
    -- OSF-3881
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ldc_aprfmaco2'), UPPER('adm_person'));
END;
/
