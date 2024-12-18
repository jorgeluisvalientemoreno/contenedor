CREATE OR REPLACE PACKAGE adm_person.pkg_GeneraPaqueteN1
IS
/*******************************************************************************
    Fuente Propiedad Intelectual de Gases del Caribe y Efigas
    Autor       :   Lubin Pineda - MVM
    Fecha       :   23-07-2024
    Descripcion :   Paquete para la generación de paquetes de acceso a datos
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     23-07-2024  OSF-3005    Creacion
    jpinedc     11-10-2024  OSF-3466    * Se crea método sobrecargado el cual
                                          calcula el nombre del paquete
                                        * Se crea cursor público sobre la tabla
                                        * Se modifica la generación de programas
                                          inserción y actualización de registro
    jpinedc     25-10-2024  OSF-3530    * Se quita la creación de los métodos
                                          -- ftbObtRowIdsxCond
                                          -- ftbObtRegistrosxCond
                                          -- prBorRegistroxCond
                                        * Se colocan comentarios a los métodos 
*******************************************************************************/

    PROCEDURE prcGenerar
    (
        isbTabla            VARCHAR2, 
        isbEsquemaTabla     VARCHAR2,
        isbAutor            VARCHAR2    DEFAULT USER,        
        isbCaso             VARCHAR2    default 'OSF-XXXX',
        isbColsPseudoPK     VARCHAR2    default NULL,  -- Lista de columnas de pseudo PK para tabla sin ind unique
        isbRutaPaqueteN1    VARCHAR2    default '/smartfiles/tmp',
        isbEsquemaPaqueteN1 VARCHAR2    default 'adm_person',
        iblGenGetxColumna   BOOLEAN     default TRUE,
        iblGenUpdxColumna   BOOLEAN     default TRUE
    );    
       

END pkg_GeneraPaqueteN1;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_GeneraPaqueteN1
IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    gsbAutor                VARCHAR2(200);
    gsbTabla                VARCHAR2(30);
    gsbEsquemaTabla         VARCHAR2(30);
    gsbColsPseudoPK         VARCHAR2(4000);
    gsbNombrePaquete        VARCHAR2(30);
    gsbCaso                 VARCHAR2(100);
    gsbRutaPaqueteN1        VARCHAR2(4000);
    gsbEsquemaPaqueteN1     VARCHAR2(30);
    gblGenGetxColumna       BOOLEAN;
    gblGenUpdxColumna       BOOLEAN;
    
    gsbListaArgConTipoPK           VARCHAR2(32000);
    gsbListaArgSinTipoPK           VARCHAR2(32000);  

    gsbListaColsConTipoPK           VARCHAR2(32000);
    gsbListaColsSinTipoPK           VARCHAR2(32000);

    gsbListaColsConTipo             VARCHAR2(32000);    
    gsbListaColsSinTipo             VARCHAR2(32000);
    
    gflArchivo                      pkg_gestionArchivos.styArchivo;
    gsbArchivo                      VARCHAR2(4000);
    gbTablaPK                       VARCHAR2(30);
    gsbColsIndUnico                 VARCHAR2(4000);

    CURSOR cuCOLS
    IS
    SELECT CL.COLUMN_NAME, CL.DATA_TYPE
    FROM DBA_TAB_COLUMNS CL
    WHERE CL.table_name = UPPER(gsbTabla)
    AND CL.owner = UPPER( gsbEsquemaTabla )
    ORDER BY COLUMN_ID;
    
    TYPE tytbCols IS TABLE OF cuCOLS%ROWTYPE INDEX BY BINARY_INTEGER;
    
    gtbCols    tytbCols;

    CURSOR cuPK
    IS    
        SELECT constraint_name
        FROM dba_constraints CO
        WHERE table_name = UPPER(gsbTabla)
        AND owner =  UPPER( gsbEsquemaTabla )
        AND CONSTRAINT_TYPE = 'P';

    CURSOR cuColsIndUnico
    IS
    WITH ind_unico AS (
            SELECT id.table_owner,id.table_name,  id.index_name
            FROM dba_indexes id
            WHERE id.table_owner =  UPPER( gsbEsquemaTabla )
            AND id.table_name = UPPER(gsbTabla)
            AND id.UNIQUENESS = 'UNIQUE'
            AND id.INDEX_TYPE = 'NORMAL'
        )
        SELECT ic.index_name, LISTAGG ( ic.column_name, ',') WITHIN GROUP ( ORDER BY COLUMN_POSITION ) AS COLUMNAS
        FROM ind_unico,dba_ind_columns ic
        WHERE ic.index_owner =  ind_unico.table_owner
        AND ic.table_name = ind_unico.table_name
        AND ic.index_name = ind_unico.index_name
        GROUP BY ic.index_name   
        ;
                    
    CURSOR cuCOLS_PK
    IS
    SELECT CL.COLUMN_NAME, CL.DATA_TYPE
    FROM DBA_CONS_COLUMNS CC,
    DBA_TAB_COLUMNS CL
    WHERE CC.table_name = UPPER(gsbTabla)
    AND CC.owner = UPPER( gsbEsquemaTabla )
    AND CL.owner = CC.owner
    AND CL.table_name = CC.table_name
    AND CL.column_name = cc.column_name
    AND CC.constraint_name =
    (
        SELECT constraint_name
        FROM dba_constraints CO
        WHERE table_name = CC.table_name
        AND owner = CC.owner
        AND CONSTRAINT_TYPE = 'P'
    )
    ORDER BY POSITION;
    
    TYPE tytbCOLS_PK IS TABLE OF cuCOLS_PK%ROWTYPE INDEX BY BINARY_INTEGER;
    
    gtbCOLS_PK   tytbCOLS_PK;

    CURSOR cuCOLS_PSEUDO_PK( isbColsPseudoPK VARCHAR2 )
    IS
    SELECT CL.COLUMN_NAME, CL.DATA_TYPE
    FROM DBA_TAB_COLUMNS CL
    WHERE CL.table_name = UPPER(gsbTabla)
    AND CL.owner = UPPER( gsbEsquemaTabla )
    AND CL.COLUMN_NAME IN 
    ( 
        SELECT regexp_substr(isbColsPseudoPK,'[^,]+', 1,LEVEL)
        FROM dual
        CONNECT BY regexp_substr(isbColsPseudoPK, '[^,]+', 1, LEVEL) IS NOT NULL    
    )
    ORDER BY COLUMN_ID;

    CURSOR cuCOLS_NO_PK
    IS
    SELECT  CL.COLUMN_NAME, CL.DATA_TYPE
    FROM DBA_TAB_COLUMNS CL
    WHERE CL.owner = UPPER( gsbEsquemaTabla )
    AND CL.table_name = UPPER(gsbTabla)
    AND CL.COLUMN_NAME NOT IN
    (            
        SELECT CC2.COLUMN_NAME
        FROM DBA_CONS_COLUMNS CC2
        WHERE CC2.table_name = UPPER(CL.table_name)
        AND CC2.owner = UPPER( CL.owner )
        AND CC2.constraint_name =
        (
            SELECT constraint_name
            FROM dba_constraints CO
            WHERE table_name = CC2.table_name
            AND owner = CC2.owner
            AND CONSTRAINT_TYPE = 'P'
        )
    )
    ORDER BY COLUMN_ID;
    
    TYPE tytbCOLS_NO_PK IS TABLE OF cuCOLS_NO_PK%ROWTYPE INDEX BY BINARY_INTEGER;

    gtbCOLS_NO_PK   tytbCOLS_NO_PK;
    
    CURSOR cuCOLS_NO_PSEUDO_PK( isbColsPseudoPk VARCHAR2)
    IS
    SELECT  CL.COLUMN_NAME, CL.DATA_TYPE
    FROM DBA_TAB_COLUMNS CL
    WHERE CL.owner = UPPER( gsbEsquemaTabla )
    AND CL.table_name = UPPER(gsbTabla)
    AND CL.COLUMN_NAME NOT IN
    (            
        SELECT regexp_substr(isbColsPseudoPK,'[^,]+', 1,LEVEL)
        FROM dual
        CONNECT BY regexp_substr(isbColsPseudoPK, '[^,]+', 1, LEVEL) IS NOT NULL    
    )
    ORDER BY COLUMN_ID;
    
    FUNCTION fsbTablaPK
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbTablaPK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbTablaPK       VARCHAR2(4000);        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuPK;
        FETCH cuPK INTO sbTablaPK;
        CLOSE cuPK;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        RETURN sbTablaPK;
                          
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
    END fsbTablaPK;
        
    FUNCTION fsbColsIndUnico
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbColsIndUnico';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbColsIndUnico  VARCHAR2(4000);
        rcColsIndUnico  cuColsIndUnico%ROWTYPE;
                
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuColsIndUnico;
        FETCH cuColsIndUnico INTO rcColsIndUnico;
        CLOSE cuColsIndUnico;
        
        sbColsIndUnico := rcColsIndUnico.columnas;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        RETURN sbColsIndUnico;
                          
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
    END fsbColsIndUnico;    
    
    PROCEDURE prcInicializacion
    (
        isbTabla            VARCHAR2, 
        isbEsquemaTabla     VARCHAR2,     
        isbNombrePaquete    VARCHAR2,
        isbAutor            VARCHAR2 DEFAULT USER,        
        isbCaso             VARCHAR2    default 'OSF-XXXX',
        isbColsPseudoPK     VARCHAR2    default NULL,               
        isbRutaPaqueteN1    VARCHAR2    default '/smartfiles/tmp',
        isbEsquemaPaqueteN1 VARCHAR2    default 'adm_person',
        iblGenGetxColumna   BOOLEAN     default TRUE,
        iblGenUpdxColumna   BOOLEAN     default TRUE
    )
    IS
    BEGIN

        gsbAutor            := isbAutor             ;
        gsbTabla            := isbTabla            ; 
        gsbEsquemaTabla     := isbEsquemaTabla     ;
        gsbColsPseudoPK     := isbColsPseudoPK     ;
        gsbNombrePaquete    := SUBSTR(isbNombrePaquete,1,30);
        gsbCaso             := isbCaso             ;
        gsbRutaPaqueteN1    := isbRutaPaqueteN1    ;
        gsbEsquemaPaqueteN1 := isbEsquemaPaqueteN1 ;
        gblGenGetxColumna   := iblGenGetxColumna   ;
        gblGenUpdxColumna   := iblGenUpdxColumna   ;
        gsbArchivo          := LOWER(gsbEsquemaPaqueteN1) || '.' || LOWER(gsbNombrePaquete) || '.sql';
        
        gtbCols.DELETE;
        gtbCols_PK.DELETE;
        gtbCOLS_NO_PK.DELETE;
        gbTablaPK           := NULL;
        gsbColsIndUnico     := NULL;
            
    END prcInicializacion;
    
    PROCEDURE prcCargatbCOLS
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargatbCOLS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuCOLS;
        FETCH cuCOLS BULK COLLECT INTO gtbCols;
        CLOSE cuCOLS;
        
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
    END prcCargatbCOLS;    
        
    PROCEDURE prcCargatbCOLS_PK
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargatbCOLS_PK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuCOLS_PK;
        FETCH cuCOLS_PK BULK COLLECT INTO gtbCOLS_PK;
        CLOSE cuCOLS_PK;
        
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
    END prcCargatbCOLS_PK;
    
    PROCEDURE prcCargatbCOLS_NO_PK
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargatbCOLS_NO_PK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuCOLS_NO_PK;
        FETCH cuCOLS_NO_PK BULK COLLECT INTO gtbCOLS_NO_PK;
        CLOSE cuCOLS_NO_PK;
        
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
    END prcCargatbCOLS_NO_PK;    
    
    FUNCTION fsbIdentaLinea( isbLinea VARCHAR2, inuCantTabs NUMBER DEFAULT 1)
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbIdentaLinea';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);      
        sbIdentaLinea   VARCHAR2(32000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        sbIdentaLinea := LPAD( ' ', inuCantTabs*4,' ' ) || isbLinea || CHR(13);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN sbIdentaLinea;
        
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
    END fsbIdentaLinea;
    
    FUNCTION fsbPrefijoxTipoDato(isbTipoDato VARCHAR2) RETURN VARCHAR2 IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbPrefijoxTipoDato';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbPrefijoFunc   VARCHAR2(10);    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        sbPrefijoFunc :=    CASE isbTipoDato 
                                WHEN 'NUMBER' THEN
                                    'nu'
                                WHEN 'VARCHAR2' THEN
                                    'sb'        
                                WHEN 'DATE' THEN
                                    'dt'
                                ELSE
                                    'xx'
                            END;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN sbPrefijoFunc;
            
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
    END fsbPrefijoxTipoDato;
    
    
    FUNCTION fsbValReempNulo ( isbTipoDato VARCHAR2) RETURN VARCHAR2 IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbValReempNulo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
        sbValReempNulo  VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        sbValReempNulo :=    CASE isbTipoDato 
                                WHEN 'NUMBER' THEN
                                    '-1'
                                WHEN 'VARCHAR2' THEN
                                    '''' || '-' || ''''       
                                WHEN 'DATE' THEN
                                    'TO_DATE(' || '''' || '01/01/1900' || '''' || ',' || '''' || 'dd/mm/yyyy' || '''' || ')'
                                ELSE
                                    '''' || '-' || '''' 
                            END;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                                    
        RETURN sbValReempNulo;
            
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
    END fsbValReempNulo;
    
    FUNCTION fsbFormNombProg( isbNombreProg VARCHAR2) 
    RETURN VARCHAR
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbFormNombProg';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
        sbFormNombProg VARCHAR2(60);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
              
        sbFormNombProg := SUBSTR(isbNombreProg,1,30);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        RETURN sbFormNombProg;
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
    END fsbFormNombProg;

    PROCEDURE prcCargListasCols
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargListasCols';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        gsbListaColsConTipo   := NULL;
        gsbListaColsSinTipo    := NULL;
        
        FOR indtb IN 1..gtbCols.COUNT LOOP
            IF indtb < gtbCols.COUNT THEN
                gsbListaColsConTipo:= gsbListaColsConTipo || gtbCols(indtb).COLUMN_NAME || '    ' ||  gtbCols(indtb).DATA_TYPE || ',';
                gsbListaColsSinTipo:= gsbListaColsSinTipo || gtbCols(indtb).COLUMN_NAME ||  ',';
            ELSE
                gsbListaColsConTipo:= gsbListaColsConTipo || gtbCols(indtb).COLUMN_NAME || '    ' ||  gtbCols(indtb).DATA_TYPE;
                gsbListaColsSinTipo:= gsbListaColsSinTipo || gtbCols(indtb).COLUMN_NAME;
            END IF;            
        END LOOP;
        
            
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
    END prcCargListasCols;    
    
    PROCEDURE prcCargListasArgColsPK
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargListasArgColsPK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        gsbListaColsConTipoPK   := NULL;
        gsbListaColsSinTipoPK   := NULL;
        gsbListaArgConTipoPK    := NULL;
        gsbListaArgSinTipoPK    := NULL;
        
        FOR indtb IN 1..gtbCOLS_PK.COUNT LOOP
            IF indtb < gtbCOLS_PK.COUNT THEN
                gsbListaColsConTipoPK:= gsbListaColsConTipoPK || gtbCOLS_PK(indtb).COLUMN_NAME || '    ' ||  gtbCOLS_PK(indtb).DATA_TYPE || ',';
                gsbListaColsSinTipoPK:= gsbListaColsSinTipoPK || gtbCOLS_PK(indtb).COLUMN_NAME ||  ',';
                gsbListaArgConTipoPK := gsbListaArgConTipoPK || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END || gtbCOLS_PK(indtb).COLUMN_NAME || '    ' ||  gtbCOLS_PK(indtb).DATA_TYPE || ',';
                gsbListaArgSinTipoPK := gsbListaArgSinTipoPK || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END || gtbCOLS_PK(indtb).COLUMN_NAME|| ',';
            ELSE
                gsbListaColsConTipoPK:= gsbListaColsConTipoPK || gtbCOLS_PK(indtb).COLUMN_NAME || '    ' ||  gtbCOLS_PK(indtb).DATA_TYPE;
                gsbListaColsSinTipoPK:= gsbListaColsSinTipoPK || gtbCOLS_PK(indtb).COLUMN_NAME ;
                gsbListaArgConTipoPK := gsbListaArgConTipoPK || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END || gtbCOLS_PK(indtb).COLUMN_NAME || '    ' ||  gtbCOLS_PK(indtb).DATA_TYPE ;
                gsbListaArgSinTipoPK := gsbListaArgSinTipoPK || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END || gtbCOLS_PK(indtb).COLUMN_NAME;
            END IF;            
        END LOOP;
        
            
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
    END prcCargListasArgColsPK;     
    
    FUNCTION  fsbEncabezado
    RETURN VARCHAR2
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbEncabezado';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        sbEncabezado        VARCHAR2(32000);      
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        sbEncabezado := sbEncabezado || fsbIdentaLinea( RPAD('/',76,'*' ) );

        sbEncabezado := sbEncabezado || fsbIdentaLinea(  'Propiedad Intelectual de Gases del Caribe y Efigas', 2 );
        sbEncabezado := sbEncabezado || fsbIdentaLinea(  'Autor : ' || gsbAutor, 2 );
        sbEncabezado := sbEncabezado || fsbIdentaLinea(  'Descr : ' || 'Paquete manejo datos Generado con pkg_GeneraPaqueteN1', 2 );
        sbEncabezado := sbEncabezado || fsbIdentaLinea(  'Tabla : ' || gsbTabla, 2 );
        sbEncabezado := sbEncabezado || fsbIdentaLinea(  'Caso  : ' || gsbCaso , 2 );
        sbEncabezado := sbEncabezado || fsbIdentaLinea(  'Fecha : ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS') , 2 );
        
        sbEncabezado := sbEncabezado || fsbIdentaLinea( LPAD('/',76,'*' ) );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
        
        RETURN sbEncabezado;
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
    END fsbEncabezado;
    
    PROCEDURE prcCreaEspecificacion
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCreaEspecificacion';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        sbEspecificacion    VARCHAR2(32000);      
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'CREATE OR REPLACE PACKAGE ' || gsbEsquemaPaqueteN1 || '.' || gsbNombrePaquete || ' AS',0 );

        sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;' );        

        sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'TYPE tytbRegistros IS TABLE OF ' || gsbTabla || '%ROWTYPE INDEX BY BINARY_INTEGER;' );
        
        sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'CURSOR cu' || gsbTabla || ' IS SELECT * FROM ' || gsbTabla || ';' );

        sbEspecificacion := sbEspecificacion || fsbEncabezado;
        
        IF gtbCOLS_PK.COUNT > 0 THEN
        
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea('CURSOR cuRegistroRId');         
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '(' );                                
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK,2);                    
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ')' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'IS' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'SELECT tb.*, tb.Rowid',2 );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'FROM ' || gsbTabla || ' tb',2 );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'WHERE' ,2 );
            
            FOR indtb IN 1..gtbCOLS_PK.COUNT LOOP
                IF indtb < gtbCOLS_PK.COUNT THEN
                    sbEspecificacion := sbEspecificacion ||  fsbIdentaLinea(  gtbCOLS_PK(indtb).COLUMN_NAME || ' = ' || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END  || gtbCOLS_PK(indtb).COLUMN_NAME || ' AND',2 );
                ELSE
                    sbEspecificacion := sbEspecificacion ||  fsbIdentaLinea(  gtbCOLS_PK(indtb).COLUMN_NAME || ' = ' || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END  || gtbCOLS_PK(indtb).COLUMN_NAME || ';',2);
                END IF;            
            END LOOP; 

            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ');
                    
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea('CURSOR cuRegistroRIdLock');         
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '(' );                                
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK,2);                    
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ')' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'IS' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'SELECT tb.*, tb.Rowid',2 );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'FROM ' || gsbTabla || ' tb',2 );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'WHERE' ,2 );
            
            FOR indtb IN 1..gtbCOLS_PK.COUNT LOOP
                IF indtb < gtbCOLS_PK.COUNT THEN
                    sbEspecificacion := sbEspecificacion ||  fsbIdentaLinea(  gtbCOLS_PK(indtb).COLUMN_NAME || ' = ' || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END  || gtbCOLS_PK(indtb).COLUMN_NAME || ' AND',2 );
                ELSE
                    sbEspecificacion := sbEspecificacion ||  fsbIdentaLinea(  gtbCOLS_PK(indtb).COLUMN_NAME || ' = ' || CASE gtbCOLS_PK(indtb).DATA_TYPE WHEN 'NUMBER' THEN 'inu' WHEN 'VARCHAR2' THEN 'isb'  END  || gtbCOLS_PK(indtb).COLUMN_NAME,2);
                END IF;            
            END LOOP;            

            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'FOR UPDATE NOWAIT;' ,2 );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ');        
                                        
            -- frcObtRegistroRId
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Obtiene el registro y el rowid' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'FUNCTION frcObtRegistroRId(');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK || ', iblBloquea BOOLEAN DEFAULT FALSE', 2 );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ') RETURN cuRegistroRId%ROWTYPE;');                  
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);
            
            -- fblExiste        
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Retorna verdadero si existe el registro' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'FUNCTION fblExiste(');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK, 2 );        
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ') RETURN BOOLEAN;');                  
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);

            -- prValExiste
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Levanta excepción si el registro NO existe' );                    
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'PROCEDURE prValExiste(');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK, 2 );        
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ');');                  
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);    
                                
            -- insRegistro
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Inserta un registro' );                                        
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'PROCEDURE prinsRegistro( ircRegistro cu'|| gsbTabla ||'%ROWTYPE);');                                          
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);
                    

            -- borRegistro
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Borra un registro' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'PROCEDURE prBorRegistro(');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK,2);
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ');');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);

            -- borRegistroxRowId
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Borra un registro por RowId' );
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'PROCEDURE prBorRegistroxRowId(');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'iRowId ROWID',2);
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ');');
            sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);

            IF gblGenGetxColumna THEN
                -- fxxGetXColumna  
                FOR indtb IN 1..gtbCOLS_NO_PK.COUNT LOOP
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Obtiene el valor de la columna ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME );                            
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'FUNCTION ' || fsbFormNombProg( 'f' || fsbPrefijoxTipoDato(  gtbCOLS_NO_PK(indtb).DATA_TYPE ) || 'Obt' || gtbCOLS_NO_PK(indtb).COLUMN_NAME ) || '(');
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK, 2);
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ') RETURN ' || gsbTabla || '.' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '%TYPE;', 2);
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);
                END LOOP;
            END IF;

            IF gblGenUpdxColumna THEN            
                -- prAcXColumna  
                FOR indtb IN 1..gtbCOLS_NO_PK.COUNT LOOP
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Actualiza el valor de la columna ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME );                           
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'PROCEDURE ' || fsbFormNombProg( 'prAc' || gtbCOLS_NO_PK(indtb).COLUMN_NAME ) || '(');
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( gsbListaArgConTipoPK || ',', 2);
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '    ' || gtbCOLS_NO_PK(indtb).DATA_TYPE, 2);
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ');');
                    sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);                            
                END LOOP;                                      
            
                -- actRegistro
                sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '-- Actualiza las columnas del registro cuyo valor sera diferente al anterior');
                sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'PROCEDURE prActRegistro( ircRegistro cu' || gsbTabla || '%ROWTYPE);');                                        
                sbEspecificacion := sbEspecificacion || fsbIdentaLinea( ' ',0);
            END IF;
            
        END IF;       

        sbEspecificacion := sbEspecificacion || fsbIdentaLinea( 'END ' || gsbNombrePaquete || ';', 0 );
        sbEspecificacion := sbEspecificacion || fsbIdentaLinea( '/',0 );
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbEspecificacion, TRUE );
                
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
    END prcCreaEspecificacion;
    
    FUNCTION fsbVariablesMetodo( isbNombreMetodo VARCHAR2, inuNivel NUMBER) RETURN VARCHAR2
    IS
        sbVariablesMetodo VARCHAR2(4000);
    BEGIN
        sbVariablesMetodo := sbVariablesMetodo || fsbIdentaLinea('csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME' || '||' || '''' || isbNombreMetodo || '''' || ';', inuNivel );
        sbVariablesMetodo := sbVariablesMetodo || fsbIdentaLinea('nuError         NUMBER;',inuNivel );
        sbVariablesMetodo := sbVariablesMetodo || fsbIdentaLinea('sbError         VARCHAR2(4000);',inuNivel ); 
        RETURN sbVariablesMetodo;
    END fsbVariablesMetodo;    
    
    FUNCTION fsbInicioMetodo( inuNivel NUMBER) RETURN VARCHAR2
    IS
        sbInicioMetodo VARCHAR2(4000);
    BEGIN
        sbInicioMetodo := fsbIdentaLinea(  'pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);', inuNivel );
        RETURN sbInicioMetodo;
    END fsbInicioMetodo;
        
    FUNCTION fsbFinMetodo( inuNivel NUMBER) RETURN VARCHAR2
    IS
        sbFinMetodo VARCHAR2(4000);
    BEGIN
        sbFinMetodo := fsbIdentaLinea(  'pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);', inuNivel );
        RETURN sbFinMetodo;
    END fsbFinMetodo;    

    FUNCTION fsbExcepcionesMetodo( inuNivel NUMBER, iblElevaError BOOLEAN DEFAULT TRUE) RETURN VARCHAR2
    IS
        sbExcepcionesMetodo VARCHAR2(4000);
    BEGIN
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  'EXCEPTION', inuNivel );
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '    WHEN pkg_error.Controlled_Error THEN', inuNivel );
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);', inuNivel );
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_Error.getError(nuError,sbError);', inuNivel );        
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_traza.trace('|| '''' || 'sbError => ' || '''' || '||' || 'sbError, csbNivelTraza );', inuNivel );
        IF iblElevaError THEN        
            sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        RAISE pkg_error.Controlled_Error;', inuNivel );
        END IF;
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '    WHEN OTHERS THEN', inuNivel );
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);', inuNivel );         
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_error.setError;', inuNivel );
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_Error.getError(nuError,sbError);', inuNivel );
        sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        pkg_traza.trace('|| '''' || 'sbError => ' || '''' || '||' || 'sbError, csbNivelTraza );', inuNivel );
        IF iblElevaError THEN
            sbExcepcionesMetodo := sbExcepcionesMetodo || fsbIdentaLinea(  '        RAISE pkg_error.Controlled_Error;', inuNivel );
        END IF;
        RETURN sbExcepcionesMetodo;
    END fsbExcepcionesMetodo;

    PROCEDURE prcCreaCuerpo
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCreaCuerpo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
        sbCuerpo        VARCHAR2(32000);
        sbNombProg      VARCHAR2(30);
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        sbCuerpo := sbCuerpo || fsbIdentaLinea( 'CREATE OR REPLACE PACKAGE BODY ' || gsbEsquemaPaqueteN1 ||'.' || gsbNombrePaquete || ' AS',0);

        sbCuerpo := sbCuerpo || fsbIdentaLinea( 'csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT' || '||' || '''' || '.'|| '''' || ';',1);
        sbCuerpo := sbCuerpo || fsbIdentaLinea( 'csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;',1 );
                            
        IF gtbCOLS_PK.COUNT > 0 THEN
        
        
            pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );                
            sbCuerpo := NULL;
                                                     
            -- frcObtRegistroRId
            sbNombProg  := 'frcObtRegistroRId';   
            sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Obtiene registro y RowId');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'FUNCTION ' || sbNombProg ||'(');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaArgConTipoPK || ', iblBloquea BOOLEAN DEFAULT FALSE', 2 );
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ') RETURN cuRegistroRId%ROWTYPE IS');
            sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroRId   cuRegistroRId%ROWTYPE;',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
            sbCuerpo := sbCuerpo || fsbInicioMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF iblBloquea THEN',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'OPEN cuRegistroRIdLock('|| gsbListaArgSinTipoPK || ');',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'FETCH cuRegistroRIdLock INTO rcRegistroRId;',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'CLOSE cuRegistroRIdLock;',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'ELSE',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'OPEN cuRegistroRId('|| gsbListaArgSinTipoPK || ');',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'FETCH cuRegistroRId INTO rcRegistroRId;',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'CLOSE cuRegistroRId;',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;',2);
            sbCuerpo := sbCuerpo || fsbFinMetodo(2);                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'RETURN rcRegistroRId;' ,2 );
            sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END '|| sbNombProg || ';');        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0 );        

            -- fblExiste
            sbNombProg  := 'fblExiste';
            sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Retorna verdadero si el registro existe');                      
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'FUNCTION '|| sbNombProg ||'('); 
            sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaArgConTipoPK, 2 );
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ') RETURN BOOLEAN IS');
            sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                             
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroRId  cuRegistroRId%ROWTYPE;',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
            sbCuerpo := sbCuerpo || fsbInicioMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroRId := frcObtRegistroRId(' || gsbListaArgSinTipoPK || ');',2);
            sbCuerpo := sbCuerpo || fsbFINMetodo(2);                            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'RETURN rcRegistroRId.' || gtbCOLS_PK(1).COLUMN_NAME || ' IS NOT NULL;',2 );
            sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg || ';');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0 );

            -- prValExiste
            sbNombProg  := 'prValExiste';
            sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Eleva error si el registro no existe');                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE ' || sbNombProg || '(');                
            sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaArgConTipoPK, 2 );              
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ') IS'); 
            sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                                         
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
            sbCuerpo := sbCuerpo || fsbInicioMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF NOT fblExiste(' || gsbListaArgSinTipoPK || ') THEN', 2 );
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'pkg_error.setErrorMessage( isbMsgErrr =>'|| '''' || 'No existe el registro [' || '''' || '||'|| REPLACE( gsbListaArgSinTipoPK, ',','||' || '''' || ',' || '''' || '||') || '||' || '''' || '] en la tabla[' || gsbTabla || ']' || '''' || ');' , 3 );            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;', 2 );
            sbCuerpo := sbCuerpo || fsbFinMetodo(2);
            sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg || ';');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0 );
                      
            -- prInsRegistro
            sbNombProg  := 'prInsRegistro';
            sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Inserta un registro');                            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE ' || sbNombProg || '( ircRegistro cu' || gsbTabla || '%ROWTYPE) IS');
            sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                                                    
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
            sbCuerpo := sbCuerpo || fsbInicioMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'INSERT INTO ' || gsbTabla || '(',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaColsSinTipo, 3 );            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ')',2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'VALUES (',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'ircRegistro.' || REPLACE( gsbListaColsSinTipo, ',' , ',ircRegistro.'), 3 );            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ');',2);
            sbCuerpo := sbCuerpo || fsbFinMetodo(2);
            sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg ||';');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);
                           
            -- prBorRegistro
            sbNombProg  := 'prBorRegistro';
            sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Borra un registro');                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE ' || sbNombProg || '(');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaArgConTipoPK,2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ') IS');
            sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct cuRegistroRId%ROWTYPE;', 2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
            sbCuerpo := sbCuerpo || fsbInicioMetodo(2);                                                                
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct := frcObtRegistroRId(' || gsbListaArgSinTipoPK || ', TRUE);',2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF rcRegistroAct.RowId IS NOT NULL THEN',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'DELETE ' || gsbTabla ,3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'WHERE ',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'ROWID = ' ||  'rcRegistroAct.RowId' || ';',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;',2);
            sbCuerpo := sbCuerpo || fsbFinMetodo(2); 
            sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                       
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg || ';',1);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);

            -- borRegistroxRowId
            sbNombProg  := 'prBorRegistroxRowId';
            sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Borra un registro por RowId');                        
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE '|| sbNombProg || '(');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'iRowId ROWID',2);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ') IS');
            sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);          
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
            sbCuerpo := sbCuerpo || fsbInicioMetodo(2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF iRowId IS NOT NULL THEN',2);            
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'DELETE ' || gsbTabla,3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'WHERE RowId = iRowId;',3);
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;',2);
            sbCuerpo := sbCuerpo || fsbFinMetodo(2);
            sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                                    
            sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END '||sbNombProg || ';');
            sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);

            pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );
                        
            sbCuerpo := NULL;
            
            IF gblGenGetxColumna THEN            
                -- fxxGetXColumna  
                FOR indtb IN 1..gtbCOLS_NO_PK.COUNT LOOP                    
                    sbNombProg := fsbFormNombProg('f' || fsbPrefijoxTipoDato(  gtbCOLS_NO_PK(indtb).DATA_TYPE ) || 'Obt' || gtbCOLS_NO_PK(indtb).COLUMN_NAME);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Obtiene el valor de la columna ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME ); 
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'FUNCTION ' || sbNombProg  || '(');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaArgConTipoPK, 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ') RETURN ' || gsbTabla || '.' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '%TYPE', 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IS', 2);
                    sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                     
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct cuRegistroRId%ROWTYPE;', 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
                    sbCuerpo := sbCuerpo || fsbInicioMetodo(2);                                                                        
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct := frcObtRegistroRId(' || gsbListaArgSinTipoPK || ');',2);
                    sbCuerpo := sbCuerpo || fsbFinMetodo(2);                                
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'RETURN rcRegistroAct.' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || ';',2);
                    sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                    
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg || ';');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);                            
                    pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );
                    sbCuerpo := NULL;  
                END LOOP;
            END IF;
                      
            IF gblGenUpdxColumna THEN            
                -- prAcXColumna  
                FOR indtb IN 1..gtbCOLS_NO_PK.COUNT LOOP
                    sbNombProg := fsbFormNombProg( 'prAc' || gtbCOLS_NO_PK(indtb).COLUMN_NAME );
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Actualiza el valor de la columna ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME );                    
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE ' || sbNombProg || '(');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( gsbListaArgConTipoPK || ',', 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '    ' || gtbCOLS_NO_PK(indtb).DATA_TYPE, 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ')');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IS');
                    sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                    
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct cuRegistroRId%ROWTYPE;', 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
                    sbCuerpo := sbCuerpo || fsbInicioMetodo(2);                                                                        
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct := frcObtRegistroRId(' || gsbListaArgSinTipoPK || ',TRUE);',2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF NVL(' || 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || ',' || fsbValReempNulo( gtbCOLS_NO_PK(indtb).DATA_TYPE ) || ') <> NVL(' || 'rcRegistroAct.' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || ',' || fsbValReempNulo( gtbCOLS_NO_PK(indtb).DATA_TYPE )  || ') THEN', 2);                            
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'UPDATE ' || gsbTabla, 3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'SET ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '=' || 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME , 3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'WHERE Rowid = rcRegistroAct.RowId;' , 3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;' , 2);
                    sbCuerpo := sbCuerpo || fsbFinMetodo(2);
                    sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                                        
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg || ';');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);                            
                    pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );
                    sbCuerpo := NULL;     
                END LOOP;
                                          
                -- prcUpdXColumnaByRowId  
                FOR indtb IN 1..gtbCOLS_NO_PK.COUNT LOOP 
                    sbNombProg :=  fsbFormNombProg('prAc' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '_RId');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Actualiza por RowId el valor de la columna ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME );                                              
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE ' ||  sbNombProg || '(');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'iRowId ROWID,' , 2);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '_O    ' || gtbCOLS_NO_PK(indtb).DATA_TYPE || ',',2 );
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '_N    ' || gtbCOLS_NO_PK(indtb).DATA_TYPE,2 );
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ')');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IS');
                    sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                    
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
                    sbCuerpo := sbCuerpo || fsbInicioMetodo(2);                    
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF NVL(' || 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '_O' || ',' || fsbValReempNulo( gtbCOLS_NO_PK(indtb).DATA_TYPE ) || ') <> NVL(' || 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '_N' || ',' || fsbValReempNulo( gtbCOLS_NO_PK(indtb).DATA_TYPE )  || ') THEN', 2);                            
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'UPDATE ' || gsbTabla, 3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'SET ' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '=' || 'i' || fsbPrefijoxTipoDato(gtbCOLS_NO_PK(indtb).DATA_TYPE) || gtbCOLS_NO_PK(indtb).COLUMN_NAME || '_N' , 3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'WHERE Rowid = iRowId;' , 3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;' , 2);
                    sbCuerpo := sbCuerpo || fsbFinMetodo(2);
                    sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                                        
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || sbNombProg || ';');
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);                            
                    pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );
                    sbCuerpo := NULL;                
                END LOOP;                            
            
                -- prActRegistro
                sbNombProg := 'prActRegistro';
                sbCuerpo := sbCuerpo || fsbIdentaLinea( '-- Actualiza las columnas con valor diferente al anterior' );                                 
                sbCuerpo := sbCuerpo || fsbIdentaLinea( 'PROCEDURE '|| sbNombProg || '( ircRegistro cu' || gsbTabla || '%ROWTYPE) IS');
                sbCuerpo := sbCuerpo || fsbVariablesMetodo(sbNombProg,2);                
                sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct cuRegistroRId%ROWTYPE;', 2);
                sbCuerpo := sbCuerpo || fsbIdentaLinea( 'BEGIN');
                sbCuerpo := sbCuerpo || fsbInicioMetodo(2);                                                                    
                sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct := frcObtRegistroRId(' || 'ircRegistro.' || REPLACE( gsbListaColsSinTipoPK, ',', ',ircRegistro.') || ',TRUE);',2);            
                IF gtbCOLS_NO_PK.COUNT > 0 THEN
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'IF rcRegistroAct.RowId IS NOT NULL THEN',2);
                END IF;
                FOR indtb IN 1..gtbCOLS_NO_PK.COUNT loop
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( fsbFormNombProg( 'prAc' || gtbCOLS_NO_PK(indtb).COLUMN_NAME ||'_RId') || '(',3);            
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct.RowId' || ',',4);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'rcRegistroAct.' || gtbCOLS_NO_PK(indtb).COLUMN_NAME || ',',4);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'ircRegistro.' || gtbCOLS_NO_PK(indtb).COLUMN_NAME ,4);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ');',3);
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);
                    pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );
                    sbCuerpo := NULL;                      
                END LOOP;
                IF gtbCOLS_NO_PK.COUNT > 0 THEN
                    sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END IF;',2);
                END IF;
                sbCuerpo := sbCuerpo || fsbFinMetodo(2);
                sbCuerpo := sbCuerpo || fsbExcepcionesMetodo(2);                                
                sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END '|| sbNombProg || ';',1);
                sbCuerpo := sbCuerpo || fsbIdentaLinea( ' ',0);              
            END IF;                         
                                
        END IF;
        
        sbCuerpo := sbCuerpo || fsbIdentaLinea( 'END ' || gsbNombrePaquete || ';', 0 );
        sbCuerpo := sbCuerpo || fsbIdentaLinea( '/',0 );
        
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbCuerpo, TRUE );
        
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
    END prcCreaCuerpo; 
    
    PROCEDURE prcCreaPermisos
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCreaPermisos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbPermisos      VARCHAR2(2000);     
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

        sbPermisos := sbPermisos || fsbIdentaLinea( 'BEGIN', 0 ); 

        sbPermisos := sbPermisos || fsbIdentaLinea( '-- ' || gsbCaso  );
        sbPermisos := sbPermisos || fsbIdentaLinea( 'pkg_Utilidades.prAplicarPermisos( UPPER(' || '''' || gsbNombrePaquete || '''' || '), UPPER(' || '''' || gsbEsquemaPaqueteN1 || '''' || '));' );                       
        sbPermisos := sbPermisos || fsbIdentaLinea( 'END;', 0 );
        sbPermisos := sbPermisos || fsbIdentaLinea( '/',0 );
        
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivo, sbPermisos, TRUE );       

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
    END prcCreaPermisos; 
    
    PROCEDURE prcCreaSinonimos
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCreaSinonimos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbSinonimos     VARCHAR2(2000); 
        flArchivoSin   pkg_gestionArchivos.styArchivo;    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

        flArchivoSin := pkg_gestionArchivos.ftAbrirArchivo_SMF( gsbRutaPaqueteN1, 'SIN' || LOWER(gsbEsquemaPaqueteN1) || '.' || LOWER(gsbNombrePaquete) || '.sql' , 'w'); 
        
        sbSinonimos := sbSinonimos || fsbIdentaLinea( 'BEGIN', 0 ); 
        sbSinonimos := sbSinonimos || fsbIdentaLinea( '-- ' || gsbCaso  );
        sbSinonimos := sbSinonimos || fsbIdentaLinea( 'pkg_Utilidades.prCrearSinonimos( UPPER(' || '''' || gsbNombrePaquete || '''' || '), UPPER(' || '''' || gsbEsquemaPaqueteN1 || '''' || '));' );                       
        sbSinonimos := sbSinonimos || fsbIdentaLinea( 'END;', 0 );
        sbSinonimos := sbSinonimos || fsbIdentaLinea( '/',0 );
        
        pkg_gestionArchivos.prcEscribirLinea_SMF( flArchivoSin, sbSinonimos, TRUE );       
        pkg_gestionArchivos.prcCerrarArchivo_SMF( flArchivoSin ); 

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
    END prcCreaSinonimos;    
    
    PROCEDURE prcGenerarConPK 
    ( 
        isbTabla            VARCHAR2, 
        isbEsquemaTabla     VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcGenerarConPK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                               
        gflArchivo := pkg_gestionArchivos.ftAbrirArchivo_SMF( gsbRutaPaqueteN1, gsbArchivo, 'W' );
        
        prcCargatbCOLS;
        
        prcCargatbCOLS_PK;

        prcCargatbCOLS_NO_PK;

        prcCargListasCols;
                                
        prcCargListasArgColsPK;
                
        prcCreaEspecificacion;

        prcCreaCuerpo;
        
        prcCreaPermisos;
        
        pkg_gestionArchivos.prcCerrarArchivo_SMF( gflArchivo );
        
        prcCreaSinonimos;
        
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
    END prcGenerarConPK;
    
    PROCEDURE prcCargatbCOLS_PSEUDO_PK( isbColsPseudoPK VARCHAR2) 
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargatbCOLS_PSEUDO_PK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuCOLS_PSEUDO_PK( isbColsPseudoPK );
        FETCH cuCOLS_PSEUDO_PK BULK COLLECT INTO gtbCOLS_PK;
        CLOSE cuCOLS_PSEUDO_PK;
        
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
    END prcCargatbCOLS_PSEUDO_PK;

    PROCEDURE prcCargatbCOLS_NO_PSEUDO_PK( isbColsPseudoPK VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCargatbCOLS_NO_PSEUDO_PK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuCOLS_NO_PSEUDO_PK(isbColsPseudoPK);
        FETCH cuCOLS_NO_PSEUDO_PK BULK COLLECT INTO gtbCOLS_NO_PK;
        CLOSE cuCOLS_NO_PSEUDO_PK;
        
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
    END prcCargatbCOLS_NO_PSEUDO_PK;
    
    PROCEDURE prcGenerarPseudoPK 
    ( 
        isbTabla            VARCHAR2, 
        isbEsquemaTabla     VARCHAR2,
        isbColsPseudoPK     VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcGenerarConPK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                               
        gflArchivo := pkg_gestionArchivos.ftAbrirArchivo_SMF( gsbRutaPaqueteN1, gsbArchivo, 'W' );
        
        prcCargatbCOLS;
        
        prcCargatbCOLS_PSEUDO_PK( isbColsPseudoPK );

        prcCargatbCOLS_NO_PSEUDO_PK( isbColsPseudoPK );

        prcCargListasCols;
                                
        prcCargListasArgColsPK;
                
        prcCreaEspecificacion;

        prcCreaCuerpo;

        prcCreaPermisos;
        
        pkg_gestionArchivos.prcCerrarArchivo_SMF( gflArchivo );

        prcCreaSinonimos;
                
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
    END prcGenerarPseudoPK;
    
    PROCEDURE prcGenerar
    (
        isbTabla            VARCHAR2, 
        isbEsquemaTabla     VARCHAR2,
        isbNombrePaquete    VARCHAR2,
        isbAutor            VARCHAR2    DEFAULT USER,        
        isbCaso             VARCHAR2    default 'OSF-XXXX',
        isbColsPseudoPK     VARCHAR2    default NULL,  -- Lista de columnas de pseudo PK para tabla sin ind unique
        isbRutaPaqueteN1    VARCHAR2    default '/smartfiles/tmp',
        isbEsquemaPaqueteN1 VARCHAR2    default 'adm_person',
        iblGenGetxColumna   BOOLEAN     default TRUE,
        iblGenUpdxColumna   BOOLEAN     default TRUE
    )
    IS
    BEGIN
    
        prcInicializacion
        (
            isbTabla            => isbTabla, 
            isbEsquemaTabla     => isbEsquemaTabla,     
            isbNombrePaquete    => isbNombrePaquete,
            isbAutor            => isbAutor,            
            isbCaso             => isbCaso,
            isbColsPseudoPK     => isbColsPseudoPK,                
            isbRutaPaqueteN1    => isbRutaPaqueteN1,
            isbEsquemaPaqueteN1 => isbEsquemaPaqueteN1,
            iblGenGetxColumna   => iblGenGetxColumna,
            iblGenUpdxColumna   => iblGenUpdxColumna
        );    

        IF gsbTabla IS NULL  OR gsbEsquemaTabla IS NULL
        THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'Debe ejecutarse pkg_GeneraPaqueteN1.prcInicializacion' ) ;
        END IF;

        gbTablaPK := fsbTablaPK;
        
        IF gbTablaPK IS NOT NULL THEN
        
            prcGenerarConPK 
            ( 
                isbTabla            => gsbTabla, 
                isbEsquemaTabla     => gsbEsquemaTabla
            );
        
        ELSE
        
            IF gsbColsPseudoPK IS NOT NULL THEN

                prcGenerarPseudoPK 
                ( 
                    isbTabla            => gsbTabla, 
                    isbEsquemaTabla     => gsbEsquemaTabla,
                    isbColsPseudoPK     => gsbColsPseudoPK
                );
                            
            ELSE
            
                gsbColsIndUnico := fsbColsIndUnico;
            
                IF gsbColsIndUnico IS NOT NULL THEN

                    prcGenerarPseudoPK 
                    ( 
                        isbTabla            => gsbTabla, 
                        isbEsquemaTabla     => gsbEsquemaTabla,
                        isbColsPseudoPK     => gsbColsIndUnico
                    );
                    
                ELSE           
                    pkg_error.setErrorMessage( isbMsgErrr => 'La tabla [' ||gsbEsquemaTabla||'.'||gsbTabla|| '] no tiene índices únicos. Debe ejecutarse pkg_GeneraPaqueteN1.prcInicializacion(isbTabla,isbEsquemaTabla,isbColsPseudoPK) donde isbColsPseudoPK contendrá la lista de columnas de la pseudo PK' ) ;
                END IF;
                
            END IF;

        END IF;
    
    END prcGenerar;

    PROCEDURE prcGenerar
    (
        isbTabla            VARCHAR2, 
        isbEsquemaTabla     VARCHAR2,
        isbAutor            VARCHAR2    DEFAULT USER,        
        isbCaso             VARCHAR2    default 'OSF-XXXX',
        isbColsPseudoPK     VARCHAR2    default NULL,  -- Lista de columnas de pseudo PK para tabla sin ind unique
        isbRutaPaqueteN1    VARCHAR2    default '/smartfiles/tmp',
        isbEsquemaPaqueteN1 VARCHAR2    default 'adm_person',
        iblGenGetxColumna   BOOLEAN     default TRUE,
        iblGenUpdxColumna   BOOLEAN     default TRUE
    )
    IS
    BEGIN
    
        prcGenerar
        (
            isbTabla            => isbTabla,
            isbEsquemaTabla     => isbEsquemaTabla,
            isbNombrePaquete    => 'pkg_' || isbTabla,
            isbAutor            => isbAutor,     
            isbCaso             => isbCaso,
            isbColsPseudoPK     => isbColsPseudoPK,
            isbEsquemaPaqueteN1 => isbEsquemaPaqueteN1,
            iblGenGetxColumna   => iblGenGetxColumna,
            iblGenUpdxColumna   => iblGenUpdxColumna
        );
            
    END prcGenerar;
     
END pkg_GeneraPaqueteN1;
/

Prompt Otorgando permisos sobre ADM_PERSON.pkg_GeneraPaqueteN1
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_GeneraPaqueteN1'), 'ADM_PERSON');
END;
/

