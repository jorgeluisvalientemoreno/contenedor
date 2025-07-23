create or replace PACKAGE   ADM_PERSON.pkg_BOUtilidades IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_BOUtilidades
    Autor       :   Lubin Pineda - MVM
    Fecha       :   08/10/2024
    Descripcion :   Paquete con utilidades
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
*******************************************************************************/
   FUNCTION fsbVersion RETURN VARCHAR2;
    -- Genera un archivo comprimido con extensión zip y borra el original si se indica
    PROCEDURE prcGeneraArchivoZip (isbRuta IN VARCHAR2, isbArchivo IN VARCHAR2, iblBorrarArchOriginal BOOLEAN DEFAULT FALSE);

    -- Retorna la ruta del directorio Oracle
    FUNCTION fsbRutaDirectorioOracle( isbDirectorio VARCHAR2) RETURN VARCHAR2;
    
    PROCEDURE prAdicionAtributos(isbAtributo   IN ge_boutilities.stystatementattribute,
                                 isbAlias      IN ge_boutilities.stystatementattribute,
                                 IosbConsulta  IN OUT ge_boutilities.stystatementattribute);
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prAdicionAtributos
    Descripcion     : proceso para adicionar atributos a una consulta

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 03-01-2025

    Parametros de Entrada
       isbAtributo      atributo
       isbAlias         alias
    Parametros de Salida
       IosbConsulta     consulta 
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       03-01-2025   OSF-3741    Creacion
 ***************************************************************************/
END pkg_BOUtilidades;
/
create or replace PACKAGE BODY  ADM_PERSON.pkg_BOUtilidades IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3741';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError             NUMBER;
    sbError             VARCHAR2(4000);


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Lubin Pineda - MVM
    Fecha           : 08/10/2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcGeneraArchZip
    Descripcion     : Wrapper sobre la clase java LDC_UTILZIP
    Autor           : Lubin Pineda - MVM
    Fecha           : 08/10/2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
    ***************************************************************************/
    PROCEDURE prcGeneraArchZip (isbRutaYArchivo IN VARCHAR2, osbRutaYArchivo IN VARCHAR2)
    AS LANGUAGE JAVA
    NAME 'LDC_UTILZIP.compressFile(java.lang.String,java.lang.String)' ;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcGeneraArchivoZip
    Descripcion     : Crea un archivo comprimido de tipo zip y borra el
                      archivo original si se requiere
    Autor           : Lubin Pineda - MVM
    Fecha           : 08/10/2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
    ***************************************************************************/
    PROCEDURE prcGeneraArchivoZip (isbRuta IN VARCHAR2, isbArchivo IN VARCHAR2, iblBorrarArchOriginal BOOLEAN DEFAULT FALSE)
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcGeneraArchivoZip';        
        sbNombreArchivoSinExt     VARCHAR2(200);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('isbRuta|' ||isbRuta,  csbNivelTraza);

        pkg_traza.trace('isbArchivo|' ||isbArchivo,  csbNivelTraza);

        sbNombreArchivoSinExt     := pkg_gestionArchivos.fsbNombreArchivoSinExt(isbArchivo);

        pkg_traza.trace('sbNombreArchivoSinExt|' ||sbNombreArchivoSinExt,  csbNivelTraza);

        prcGeneraArchZip( isbRuta || '/' || isbArchivo, isbRuta || '/' || sbNombreArchivoSinExt || '.zip' );

        IF iblBorrarArchOriginal THEN
            pkg_gestionArchivos.prcBorrarArchivo_SMF( isbRuta, isbArchivo );
        END IF;

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
    END prcGeneraArchivoZip;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbRutaDirectorioOracle
    Descripcion     : Retorna la ruta del directorio Oracle
    Autor           : Lubin Pineda - MVM
    Fecha           : 08/10/2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     08/10/2024  OSF-3162 Creacion
    ***************************************************************************/
    FUNCTION fsbRutaDirectorioOracle( isbDirectorio VARCHAR2) RETURN VARCHAR2
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbRutaDirectorioOracle';       
        sbRutaDirectorioOracle     VARCHAR2(2000);

        CURSOR cuRutaDirectorio
        IS
        SELECT directory_path
        FROM dba_directories d
        WHERE d.directory_name = isbDirectorio;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        OPEN cuRutaDirectorio;
        FETCH cuRutaDirectorio INTO  sbRutaDirectorioOracle;
        CLOSE cuRutaDirectorio;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbRutaDirectorioOracle;

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
    END fsbRutaDirectorioOracle;
    
   PROCEDURE prAdicionAtributos(isbAtributo   IN ge_boutilities.stystatementattribute,
                                 isbAlias      IN ge_boutilities.stystatementattribute,
                                 IosbConsulta  IN OUT ge_boutilities.stystatementattribute) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prAdicionAtributos
    Descripcion     : proceso para adicionar atributos a una consulta

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 03-01-2025

    Parametros de Entrada
       isbAtributo      atributo
       isbAlias         alias
    Parametros de Salida
       IosbConsulta     consulta 
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       03-01-2025   OSF-3741    Creacion
 ***************************************************************************/
    csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || '.prAdicionAtributos';
       
  BEGIN
     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
     pkg_traza.trace('isbAtributo => ' || isbAtributo, csbNivelTraza );
     pkg_traza.trace('isbAlias => ' || isbAlias, csbNivelTraza );
     ge_boutilities.addattribute(isbAtributo, isbAlias, IosbConsulta);
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
    END prAdicionAtributos;
END pkg_boutilidades;
/
Prompt Otorgando permisos sobre adm_person.pkg_BOUtilidades
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_BOUtilidades'), UPPER('adm_person'));
END;
/

