CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOGESTION_INSTANCIAS IS
/*******************************************************************************
    Fuente Propiedad Intelectual de Gases del Caribe
    PKG_BOGESTION_INSTANCIAS
    Autor       :   Paola Acosta
    Fecha       :   20-11-2024
    Descripcion :   Paquete con los metodos que apuntan al paquete de OPEN OR_BOINSTANCE
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    13/02/2024  fvalencia   OSF-3984    Se agregan los procedimientos prcCreaInstancia y
                                        prcAdicionarAtributo
    04/12/2024  PAcosta     OSF-3612    Migración de la bd de EFG a GDC por ajustes de información de 
                                        la entidad HOMOLOGACION_SERVICIOS - GDC 
    pacosta     20-11-2024  OSF-3150    Creacion
    
*******************************************************************************/
    
    ---------------------------------------------------------
    --                   Constantes                        --                                 
    csbWorkInstance CONSTANT VARCHAR2(20) := 'WORK_INSTANCE';
    ---------------------------------------------------------

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion
    RETURN VARCHAR2;
    
    --Establece EXITO en Instancia 
    PROCEDURE prcFijarExito;

    --Establece NO EXITO en Instancia 
    PROCEDURE prcFijarNoExito;
    
    --Homologación al servicio de creación de instancia
    PROCEDURE prcCreaInstancia
    (
        isbInstancia     IN    VARCHAR2
    );

    --Homologación al servicio que agrega atributo a la instancia
    PROCEDURE prcAdicionarAtributo
    (
        isbInstancia    IN  VARCHAR2,
        isbGrupo        IN  VARCHAR2,
        isbEntidad      IN  VARCHAR2,
        isbAtributo     IN  VARCHAR2,
        isbValor        IN  VARCHAR2,
        iblActualiza    IN  BOOLEAN DEFAULT FALSE
    );
END PKG_BOGESTION_INSTANCIAS;
/
create or replace PACKAGE BODY ADM_PERSON.PKG_BOGESTION_INSTANCIAS IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-3984';
    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(35)       := $$PLSQL_UNIT;       
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    
     --Variables generales     
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Paola Acosta
    Fecha           : 20-11-2024
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    pacosta   20-11-2024  OSF-3150 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcFijarExito
    Descripcion     : apunta a paquete.metodo OR_BOINSTANCE.SETSUCCESSININSTANCE. Establece EXITO en Instancia  
    Autor           : Paola Acosta
    Fecha           : 20-11-2024
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    pacosta   20-11-2024  OSF-3150 Creacion
    ***************************************************************************/
    PROCEDURE prcFijarExito 
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prcFijarExito';

    BEGIN

        pkg_traza.trace(csbMT_NAME,csbNivelTraza, csbInicio);
             
        or_boinstance.setsuccessininstance;
        
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbFin);              

    EXCEPTION
        WHEN pkg_error.controlled_error  THEN
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);           
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);             
    END prcFijarExito;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcFijarNoExito
    Descripcion     : apunta a paquete.metodo OR_BOINSTANCE.SETSUCCESSININSTANCE. Establece NO EXITO en Instancia  
    Autor           : Paola Acosta
    Fecha           : 20-11-2024
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    pacosta   20-11-2024  OSF-3150 Creacion
    ***************************************************************************/
    PROCEDURE prcFijarNoExito 
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prcFijarNoExito';

    BEGIN

        pkg_traza.trace(csbMT_NAME,csbNivelTraza, csbInicio);
             
        or_boinstance.setun_successininstance;
        
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbFin);              

    EXCEPTION
        WHEN pkg_error.controlled_error  THEN
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);           
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);             
    END prcFijarNoExito;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcCreaInstancia
    Descripcion     : Homologación al servicio de creación de instancia
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 13-02-2025
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    fvalencia   13-02-2025  OSF-3984 Creacion
    ***************************************************************************/
    PROCEDURE prcCreaInstancia
    (
        isbInstancia     IN    VARCHAR2
    )
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prcCreaInstancia';

    BEGIN
        pkg_traza.trace(csbMT_NAME,csbNivelTraza, csbInicio);
             
        ge_boinstancecontrol.createinstance(isbInstancia);
        
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error  THEN
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);           
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);             
    END prcCreaInstancia;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcAdicionarAtributo
    Descripcion     : Homologación al servicio que agrega atributo a la instancia
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 13-02-2025
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    fvalencia   13-02-2025  OSF-3984 Creacion
    ***************************************************************************/
    PROCEDURE prcAdicionarAtributo
    (
        isbInstancia    IN  VARCHAR2,
        isbGrupo        IN  VARCHAR2,
        isbEntidad      IN  VARCHAR2,
        isbAtributo     IN  VARCHAR2,
        isbValor        IN  VARCHAR2,
        iblActualiza    IN  BOOLEAN DEFAULT FALSE
    )
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prcAdicionarAtributo';

    BEGIN
        pkg_traza.trace(csbMT_NAME,csbNivelTraza, csbInicio);
             
        ge_boinstancecontrol.addattribute
        (
            isbInstancia,
            isbGrupo,
            isbEntidad,
            isbAtributo,
            isbValor,
            iblActualiza
        );
        
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error  THEN
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);           
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror);        
            pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
            pkg_traza.TRACE(csbMT_NAME, csbNivelTraza, csbFin_Erc);             
    END prcAdicionarAtributo;

END PKG_BOGESTION_INSTANCIAS;
/
begin
    pkg_utilidades.prAplicarPermisos('PKG_BOGESTION_INSTANCIAS','ADM_PERSON');
end;
/