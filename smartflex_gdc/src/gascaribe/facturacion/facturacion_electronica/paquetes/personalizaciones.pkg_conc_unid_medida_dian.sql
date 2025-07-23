CREATE OR REPLACE PACKAGE personalizaciones.pkg_conc_unid_medida_dian IS
  CURSOR cuUnidadMedida IS
  SELECT concepto_id,
	     unidad_medida,
	     requiere_tarifa
  FROM conc_unid_medida_dian;
  
  TYPE tytRcUnidadMedConc IS RECORD ( nuConcepto        NUMBER(5),
									  sbUnidadMed       VARCHAR2(20),
									  sbRequiereTarifa  VARCHAR2(1));

  TYPE tytbUnidadMedConc IS TABLE OF tytRcUnidadMedConc INDEX BY BINARY_INTEGER;
  
  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 03-02-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       03-02-2025   OSF-1916    Creacion
  ***************************************************************************/ 
   
  FUNCTION ftblCargarUnidadxConcepto RETURN tytbUnidadMedConc;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftblCargarUnidadxConcepto
    Descripcion     : Retona tabla pl con informacion de unidades de medida por concepto
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 03-02-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       03-02-2025   OSF-1916    Creacion
  ***************************************************************************/ 
  
END pkg_conc_unid_medida_dian;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_conc_unid_medida_dian IS
  -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-3707';
   nuError  NUMBER;
   sbError  VARCHAR2(4000);

   FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 03-02-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       03-02-2025   OSF-1916    Creacion
  ***************************************************************************/ 
     csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME||'.fsbVersion';
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    RETURN csbVersion;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
  END fsbVersion;
  
  FUNCTION ftblCargarUnidadxConcepto RETURN tytbUnidadMedConc IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftblCargarUnidadxConcepto
    Descripcion     : Retona tabla pl con informacion de unidades de medida por concepto
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 03-02-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       03-02-2025   OSF-1916    Creacion
  ***************************************************************************/ 
    csbMetodo        CONSTANT VARCHAR2(150) := csbSP_NAME||'.ftblCargarUnidadxConcepto';
    tbUnidadMedConc           tytbUnidadMedConc;
  BEGIN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
      --se carga tabla temporal de unidad de medida por concepto
      FOR rc IN cuUnidadMedida LOOP
          tbUnidadMedConc(rc.concepto_id).sbUnidadMed := rc.unidad_medida;
          tbUnidadMedConc(rc.concepto_id).sbRequiereTarifa := rc.requiere_tarifa;
          tbUnidadMedConc(rc.concepto_id).nuConcepto := rc.concepto_id;
      END LOOP;
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      RETURN tbUnidadMedConc;
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
  END ftblCargarUnidadxConcepto;
END pkg_conc_unid_medida_dian;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_CONC_UNID_MEDIDA_DIAN','PERSONALIZACIONES');
END;
/