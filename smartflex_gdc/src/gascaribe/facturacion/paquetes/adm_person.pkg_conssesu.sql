CREATE OR REPLACE PACKAGE adm_person.pkg_conssesu IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Autor : PACOSTA
    Descr : Paquete de manejo de datos para la tabla pkg_conssesu
    Tabla : pkg_conssesu
    Caso  : OSF-3881
    Fecha : 22/01/2025 09:08:11
    ***************************************************************************/
    
    --Tipos globales del paquete
    TYPE tyTbRowid  IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tyCosssesu IS TABLE OF conssesu.cosssesu%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosstcon IS TABLE OF conssesu.cosstcon%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosspefa IS TABLE OF conssesu.cosspefa%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosscoca IS TABLE OF conssesu.cosscoca%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossnvec IS TABLE OF conssesu.cossnvec%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosselme IS TABLE OF conssesu.cosselme%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossmecc IS TABLE OF conssesu.cossmecc%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossflli IS TABLE OF conssesu.cossflli%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosspfcr IS TABLE OF conssesu.cosspfcr%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossdico IS TABLE OF conssesu.cossdico%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossidre IS TABLE OF conssesu.cossidre%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosscmss IS TABLE OF conssesu.cosscmss%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossfere IS TABLE OF conssesu.cossfere%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosscavc IS TABLE OF conssesu.cosscavc%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossfufa IS TABLE OF conssesu.cossfufa%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossfunc IS TABLE OF conssesu.cossfunc%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosspecs IS TABLE OF conssesu.cosspecs%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCosscons IS TABLE OF conssesu.cosscons%TYPE INDEX BY BINARY_INTEGER;
    TYPE tyCossfcco IS TABLE OF conssesu.cossfcco%TYPE INDEX BY BINARY_INTEGER;
    
    TYPE tytbconssesu IS RECORD (
        cosssesu tyCosssesu,
        cosstcon tyCosstcon,
        cosspefa tyCosspefa,
        cosscoca tyCosscoca,
        cossnvec tyCossnvec,
        cosselme tyCosselme,
        cossmecc tyCossmecc,
        cossflli tyCossflli,
        cosspfcr tyCosspfcr,
        cossdico tyCossdico,
        cossidre tyCossidre,
        cosscmss tyCosscmss,
        cossfere tyCossfere,
        cosscavc tyCosscavc,
        cossfufa tyCossfufa,
        cossfunc tyCossfunc,
        cosspecs tyCosspecs,
        cosscons tyCosscons,
        cossfcco tyCossfcco
    );
    
    --Metodos del paquete
    --Retorna version del paquete
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    --Inserta un registro en la tabla mediante rc
    PROCEDURE insRegistro (
        ircrecord IN conssesu%rowtype
    );
    
    --Inserta varios registros en la tabla mediante rc
    PROCEDURE insRegistros (
        irctbrecord IN OUT NOCOPY tytbconssesu
    );
    
    --Inserta registro en la tabla por columnas 
    PROCEDURE insRegistroPorCadaColumna (
        inuCosssesu IN conssesu.cosssesu%TYPE,
        inuCosstcon IN conssesu.cosstcon%TYPE,
        inuCosspefa IN conssesu.cosspefa%TYPE,
        inuCosscoca IN conssesu.cosscoca%TYPE,
        inuCossnvec IN conssesu.cossnvec%TYPE,
        inuCosselme IN conssesu.cosselme%TYPE,
        inuCossmecc IN conssesu.cossmecc%TYPE,
        isbCossflli IN conssesu.cossflli%TYPE,
        inuCosspfcr IN conssesu.cosspfcr%TYPE,
        inuCossdico IN conssesu.cossdico%TYPE,
        inuCossidre IN conssesu.cossidre%TYPE,
        inuCosscmss IN conssesu.cosscmss%TYPE,
        idtCossfere IN conssesu.cossfere%TYPE,
        inuCosscavc IN conssesu.cosscavc%TYPE,
        isbCossfufa IN conssesu.cossfufa%TYPE,
        isbCossfunc IN conssesu.cossfunc%TYPE,
        inuCosspecs IN conssesu.cosspecs%TYPE,
        inuCossfcco IN conssesu.cossfcco%TYPE
    );
    
     --Inserta registros en la tabla por columnas
    PROCEDURE insRegistrosPorCadaColumna (
        inuCosssesu IN OUT NOCOPY tyCosssesu,
        inuCosstcon IN OUT NOCOPY tyCosstcon,
        inuCosspefa IN OUT NOCOPY tyCosspefa,
        inuCosscoca IN OUT NOCOPY tyCosscoca,
        inuCossnvec IN OUT NOCOPY tyCossnvec,
        inuCosselme IN OUT NOCOPY tyCosselme,
        inuCossmecc IN OUT NOCOPY tyCossmecc,
        isbCossflli IN OUT NOCOPY tyCossflli,
        inuCosspfcr IN OUT NOCOPY tyCosspfcr,
        inuCossdico IN OUT NOCOPY tyCossdico,
        inuCossidre IN OUT NOCOPY tyCossidre,
        inuCosscmss IN OUT NOCOPY tyCosscmss,
        idtCossfere IN OUT NOCOPY tyCossfere,
        inuCosscavc IN OUT NOCOPY tyCosscavc,
        isbCossfufa IN OUT NOCOPY tyCossfufa,
        isbCossfunc IN OUT NOCOPY tyCossfunc,
        inuCosspecs IN OUT NOCOPY tyCosspecs,
        inuCossfcco IN OUT NOCOPY tyCossfcco
    );    
    
    --Actualiza los registros cosspecs, cosspefa, cosscoca y cosselme para FMACO
    PROCEDURE prcActRegistroFmaco(inuRowIdConssesu IN VARCHAR2,
                                  inuCosspecs      IN conssesu.cosspecs%TYPE,
                                  inuCosspefa      IN conssesu.cosspefa%TYPE,
                                  inuCosscoca      IN conssesu.cosscoca%TYPE,
                                  inuCosselme      IN conssesu.cosselme%TYPE
    );
END;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_conssesu IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC y EFG">
    <Unidad>pkg_conssesu</Unidad>
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
    csbPqt_nombre    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
    csbversion       CONSTANT VARCHAR2(10) := 'OSF-3881';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;   
    csbInicio        CONSTANT VARCHAR2(35) := pkg_traza.fsbInicio; 
    csbFin           CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err       CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc       CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    
    -- Variables globales
    nuError		NUMBER;  		
	sbMensaje   VARCHAR2(1000);
    
    -- Metodos del paquete
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : fsbVersion
    Descripcion    : Retorna version del paquete
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    
    ******************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN     
        RETURN csbversion;
    END fsbVersion;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : insRegistroPorCadaColumna
    Descripcion    : Inserta registro en la tabla por columnas 
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    
    ******************************************************************/
    PROCEDURE insRegistroPorCadaColumna (
        inuCosssesu IN conssesu.cosssesu%TYPE,
        inuCosstcon IN conssesu.cosstcon%TYPE,
        inuCosspefa IN conssesu.cosspefa%TYPE,
        inuCosscoca IN conssesu.cosscoca%TYPE,
        inuCossnvec IN conssesu.cossnvec%TYPE,
        inuCosselme IN conssesu.cosselme%TYPE,
        inuCossmecc IN conssesu.cossmecc%TYPE,
        isbCossflli IN conssesu.cossflli%TYPE,
        inuCosspfcr IN conssesu.cosspfcr%TYPE,
        inuCossdico IN conssesu.cossdico%TYPE,
        inuCossidre IN conssesu.cossidre%TYPE,
        inuCosscmss IN conssesu.cosscmss%TYPE,
        idtCossfere IN conssesu.cossfere%TYPE,
        inuCosscavc IN conssesu.cosscavc%TYPE,
        isbCossfufa IN conssesu.cossfufa%TYPE,
        isbCossfunc IN conssesu.cossfunc%TYPE,
        inuCosspecs IN conssesu.cosspecs%TYPE,
        inuCossfcco IN conssesu.cossfcco%TYPE
    ) IS
        csbMtd_nombre  VARCHAR2(70) := csbPqt_nombre || 'insRegistroPorCadaColumna';
        
        rcrecord conssesu%rowtype;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        rcrecord.cosssesu := inuCosssesu;
        rcrecord.cosstcon := inuCosstcon;
        rcrecord.cosspefa := inuCosspefa;
        rcrecord.cosscoca := inuCosscoca;
        rcrecord.cossnvec := inuCossnvec;
        rcrecord.cosselme := inuCosselme;
        rcrecord.cossmecc := inuCossmecc;
        rcrecord.cossflli := isbCossflli;
        rcrecord.cosspfcr := inuCosspfcr;
        rcrecord.cossdico := inuCossdico;
        rcrecord.cossidre := inuCossidre;
        rcrecord.cosscmss := inuCosscmss;
        rcrecord.cossfere := idtCossfere;
        rcrecord.cosscavc := inuCosscavc;
        rcrecord.cossfufa := isbCossfufa;
        rcrecord.cossfunc := isbCossfunc;
        rcrecord.cosspecs := inuCosspecs;
        rcrecord.cossfcco := inuCossfcco;
        insRegistro(rcrecord);
       
       pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END insRegistroPorCadaColumna;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : insRegistrosPorCadaColumna
    Descripcion    : nserta registros en la tabla por columnas
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    
    ******************************************************************/
    PROCEDURE insRegistrosPorCadaColumna (
        inuCosssesu IN OUT NOCOPY tyCosssesu,
        inuCosstcon IN OUT NOCOPY tyCosstcon,
        inuCosspefa IN OUT NOCOPY tyCosspefa,
        inuCosscoca IN OUT NOCOPY tyCosscoca,
        inuCossnvec IN OUT NOCOPY tyCossnvec,
        inuCosselme IN OUT NOCOPY tyCosselme,
        inuCossmecc IN OUT NOCOPY tyCossmecc,
        isbCossflli IN OUT NOCOPY tyCossflli,
        inuCosspfcr IN OUT NOCOPY tyCosspfcr,
        inuCossdico IN OUT NOCOPY tyCossdico,
        inuCossidre IN OUT NOCOPY tyCossidre,
        inuCosscmss IN OUT NOCOPY tyCosscmss,
        idtCossfere IN OUT NOCOPY tyCossfere,
        inuCosscavc IN OUT NOCOPY tyCosscavc,
        isbCossfufa IN OUT NOCOPY tyCossfufa,
        isbCossfunc IN OUT NOCOPY tyCossfunc,
        inuCosspecs IN OUT NOCOPY tyCosspecs,
        inuCossfcco IN OUT NOCOPY tyCossfcco
    ) IS
        csbMtd_nombre  VARCHAR2(70) := csbPqt_nombre || 'insRegistrosPorCadaColumna';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        FORALL indx IN inuCosssesu.first..inuCosssesu.last
            INSERT INTO conssesu (
                cosssesu,
                cosstcon,
                cosspefa,
                cosscoca,
                cossnvec,
                cosselme,
                cossmecc,
                cossflli,
                cosspfcr,
                cossdico,
                cossidre,
                cosscmss,
                cossfere,
                cosscavc,
                cossfufa,
                cossfunc,
                cosspecs,
                cossfcco
            ) VALUES (
                inuCosssesu(indx),
                inuCosstcon(indx),
                inuCosspefa(indx),
                inuCosscoca(indx),
                inuCossnvec(indx),
                inuCosselme(indx),
                inuCossmecc(indx),
                isbCossflli(indx),
                inuCosspfcr(indx),
                inuCossdico(indx),
                inuCossidre(indx),
                inuCosscmss(indx),
                idtCossfere(indx),
                inuCosscavc(indx),
                isbCossfufa(indx),
                isbCossfunc(indx),
                inuCosspecs(indx),
                inuCossfcco(indx)
            );

        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END insRegistrosPorCadaColumna;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : insRegistro
    Descripcion    : Inserta un registro en la tabla mediante rc
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    
    ******************************************************************/
    PROCEDURE insRegistro (
        ircrecord IN conssesu%rowtype
    ) IS
        csbMtd_nombre  VARCHAR2(70) := csbPqt_nombre || 'insRegistro';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        INSERT INTO conssesu (
            cosssesu,
            cosstcon,
            cosspefa,
            cosscoca,
            cossnvec,
            cosselme,
            cossmecc,
            cossflli,
            cosspfcr,
            cossdico,
            cossidre,
            cosscmss,
            cossfere,
            cosscavc,
            cossfufa,
            cossfunc,
            cosspecs,
            cosscons,
            cossfcco
        ) VALUES (
            ircrecord.cosssesu,
            ircrecord.cosstcon,
            ircrecord.cosspefa,
            ircrecord.cosscoca,
            ircrecord.cossnvec,
            ircrecord.cosselme,
            ircrecord.cossmecc,
            ircrecord.cossflli,
            ircrecord.cosspfcr,
            ircrecord.cossdico,
            ircrecord.cossidre,
            ircrecord.cosscmss,
            ircrecord.cossfere,
            ircrecord.cosscavc,
            ircrecord.cossfufa,
            ircrecord.cossfunc,
            ircrecord.cosspecs,
            ircrecord.cosscons,
            ircrecord.cossfcco
        );

        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END insRegistro;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : insRegistros
    Descripcion    : Inserta varios registros en la tabla mediante rc
    
    Autor          : Paola Acosta
    Fecha          : 22/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    
    ******************************************************************/
    PROCEDURE insRegistros (
        irctbrecord IN OUT NOCOPY tytbconssesu
    ) IS
        csbMtd_nombre  VARCHAR2(70) := csbPqt_nombre || 'insRegistros';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
        FORALL indx IN irctbrecord.cosssesu.first..irctbrecord.cosssesu.last
            INSERT INTO conssesu (
                cosssesu,
                cosstcon,
                cosspefa,
                cosscoca,
                cossnvec,
                cosselme,
                cossmecc,
                cossflli,
                cosspfcr,
                cossdico,
                cossidre,
                cosscmss,
                cossfere,
                cosscavc,
                cossfufa,
                cossfunc,
                cosspecs,
                cosscons,
                cossfcco
            ) VALUES (
                irctbrecord.cosssesu(indx),
                irctbrecord.cosstcon(indx),
                irctbrecord.cosspefa(indx),
                irctbrecord.cosscoca(indx),
                irctbrecord.cossnvec(indx),
                irctbrecord.cosselme(indx),
                irctbrecord.cossmecc(indx),
                irctbrecord.cossflli(indx),
                irctbrecord.cosspfcr(indx),
                irctbrecord.cossdico(indx),
                irctbrecord.cossidre(indx),
                irctbrecord.cosscmss(indx),
                irctbrecord.cossfere(indx),
                irctbrecord.cosscavc(indx),
                irctbrecord.cossfufa(indx),
                irctbrecord.cossfunc(indx),
                irctbrecord.cosspecs(indx),
                irctbrecord.cosscons(indx),
                irctbrecord.cossfcco(indx)
            );

        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END insRegistros;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).
    
    Unidad         : prcActRegistroFmaco
    Descripcion    : Actualiza los registros cosspecs, cosspefa, cosscoca y cosselme
                     para FMACO
                     
    Autor          : Paola Acosta
    Fecha          : 27/01/2025
    
    Parametros       Descripcion
    ============     ===================
    
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    
    ******************************************************************/
    PROCEDURE prcActRegistroFmaco(inuRowIdConssesu IN VARCHAR2,
                                  inuCosspecs      IN conssesu.cosspecs%TYPE,
                                  inuCosspefa      IN conssesu.cosspefa%TYPE,
                                  inuCosscoca      IN conssesu.cosscoca%TYPE,
                                  inuCosselme      IN conssesu.cosselme%TYPE
    ) IS
        csbMtd_nombre  VARCHAR2(70) := csbPqt_nombre || 'prcActRegistroFmaco';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio);
        
            UPDATE conssesu
            SET cosspecs = nvl(inuCosspecs, cosspecs),
                cosspefa = nvl(inuCosspefa, cosspefa),
                cosscoca = nvl(inuCosscoca, cosscoca),
                cosselme = nvl(inuCosselme, cosselme)
            WHERE ROWID = inuRowIdConssesu;        
      
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc);
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.controlled_error;
    END prcActRegistroFmaco;

END pkg_conssesu;
/

BEGIN
    -- OSF-3881
    pkg_utilidades.praplicarpermisos(upper('pkg_conssesu'), upper('adm_person'));
END;
/