CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_log_camb_fecha_max_leg IS
    SUBTYPE sbtSistema IS sistema%ROWTYPE;
     FUNCTION fsbVersion RETURN VARCHAR2;
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : jsoto
        Fecha           : 21-02-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        jsoto      21-02-2025   OSF-3889    Creacion
      ***************************************************************************/
	  

    PROCEDURE prInsertarRegistro(inuOrden 		or_order.order_id%TYPE,
								 inutipotrab 	or_order.task_type_id%TYPE,
								 idtfechamaxlegantes 	or_order.max_date_to_legalize%TYPE,
								 idtfechamaxlegactu		or_order.max_date_to_legalize%TYPE,
								 isbobservacion			VARCHAR2
								 );
	 /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prInsertarRegistro
        Descripcion     : Inserta un registro en la tabla ldc_log_camb_fecha_max_leg
        Autor           : jsoto
        Fecha           : 21-02-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        jsoto      21-02-2025   OSF-3889    Creacion
      ***************************************************************************/
END pkg_ldc_log_camb_fecha_max_leg;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_log_camb_fecha_max_leg IS
 -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3889';

    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.'; 
    cnuNVLTRC      CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 
    nuError     NUMBER; 
    sbError     VARCHAR2(4000);
    FUNCTION fsbVersion RETURN VARCHAR2 IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : jsoto
        Fecha           : 22-11-2024

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        jsoto      21/02/2025   OSF-3889    Creacion
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
    
    PROCEDURE prInsertarRegistro(inuOrden 		or_order.order_id%TYPE,
								 inutipotrab 	or_order.task_type_id%TYPE,
								 idtfechamaxlegantes 	or_order.max_date_to_legalize%TYPE,
								 idtfechamaxlegactu		or_order.max_date_to_legalize%TYPE,
								 isbobservacion			VARCHAR2
								 ) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prInsertarRegistro
        Descripcion     : Retona informacion del sistema
        Autor           : jsoto
        Fecha           : 21-02-2025

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        jsoto      21-02-2025   OSF-3889    Creacion
     ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarRegistro';

    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        		
		-- Guardamos informacion en el log
		INSERT INTO ldc_log_camb_fecha_max_leg VALUES(inuOrden,NULL,inutipotrab,idtfechamaxlegantes,idtfechamaxlegactu,SYSDATE,PKG_SESSION.GETUSER,isbobservacion);

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	
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
    END prInsertarRegistro;
	
END pkg_ldc_log_camb_fecha_max_leg;
/
PROMPT Otorgando permisos de ejecucion a pkg_ldc_log_camb_fecha_max_leg
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_LDC_LOG_CAMB_FECHA_MAX_LEG','ADM_PERSON');
END;
/