create or replace PACKAGE  adm_person.pkg_servicio IS
    CURSOR cuGetInfoServicio (inuIdServicio IN servicio.servcodi%type) IS
    SELECT servicio.*, servicio.rowid
    FROM servicio
    WHERE servicio.servcodi = inuIdServicio;

    CURSOR cuRegistroRIdLock
    (
        inuSERVCODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM servicio tb
        WHERE
        SERVCODI = inuSERVCODI
        FOR UPDATE NOWAIT;

    rgServicio  cuGetInfoServicio%rowtype;
    rgServicioNull  cuGetInfoServicio%rowtype;
    
    
    FUNCTION fsbVersion RETURN VARCHAR2;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 11-12-2024

        Modificaciones  :
        Autor       Fecha        Caso       Descripcion
        LJLB        11-12-2024   OSF-3741     Creacion
   ***************************************************************************/
   FUNCTION fsbObtDescripcion (inuServicio IN servicio.servcodi%type) RETURN servicio.servdesc%type;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbObtDescripcion
        Descripcion     : Retona la descripcion del id de servicio
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 11-12-2024

        Modificaciones  :
        Autor       Fecha        Caso       Descripcion
        LJLB        11-12-2024   OSF-3741     Creacion
   ***************************************************************************/

    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuSERVCODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuGetInfoServicio%ROWTYPE;
END pkg_servicio;
/
create or replace PACKAGE BODY  adm_person.pkg_servicio IS
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-4294';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-12-2024

    Modificaciones  :
    Autor       Fecha        Caso       Descripcion
    LJLB        09-12-2024   OSF-3741     Creacion
   ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
   BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN csbVersion;
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbVersion;
   FUNCTION fsbObtDescripcion (inuServicio IN servicio.servcodi%type) RETURN servicio.servdesc%type IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbObtDescripcion
        Descripcion     : Retona la descripcion del id de servicio
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 11-12-2024

        Modificaciones  :
        Autor       Fecha        Caso       Descripcion
        LJLB        11-12-2024   OSF-3741     Creacion
   ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbObtDescripcion';
     sbDescripcion  servicio.servdesc%type;

   BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuServicio => ' || inuServicio, pkg_traza.cnuNivelTrzDef);
        IF cuGetInfoServicio%ISOPEN THEN CLOSE cuGetInfoServicio; END IF;
        rgServicio := rgServicioNULL;
        OPEN cuGetInfoServicio(inuServicio);
        FETCH cuGetInfoServicio INTO rgServicio;
        CLOSE cuGetInfoServicio; 
        sbDescripcion := rgServicio.servdesc;
        pkg_traza.trace('sbDescripcion => ' || sbDescripcion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN sbDescripcion;
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
  END fsbObtDescripcion;


    FUNCTION frcObtRegistroRId(
        inuSERVCODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuGetInfoServicio%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuGetInfoServicio%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuSERVCODI);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuGetInfoServicio(inuSERVCODI);
            FETCH cuGetInfoServicio INTO rcRegistroRId;
            CLOSE cuGetInfoServicio;
        END IF;
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
END pkg_servicio;
/
PROMPT Otorgando permisos de ejecucion a PKG_SERVICIO
BEGIN
    pkg_utilidades.praplicarpermisos('PKG_SERVICIO', 'ADM_PERSON');
END;
/