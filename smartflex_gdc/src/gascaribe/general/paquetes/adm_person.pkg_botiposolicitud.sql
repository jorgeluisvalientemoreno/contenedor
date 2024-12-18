CREATE or REPLACE PACKAGE ADM_PERSON.pkg_botiposolicitud IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_botiposolicitud
      Autor       :   Luis Felipe Valencia Hurtado
      Fecha       :   08-11-2024
      Descripcion :   Paquete de servicio de tipo de solicitud

      Modificaciones  :
      Autor               Fecha           Caso        Descripcion
      felipe.valencia     08-11-2024      OSF-3586    Creacion
  *******************************************************************************/

    -- Actualiza método de ánalisis de variación de consumo
    FUNCTION fsbObtParametroTipoSolicitud
    ( 
        inuTipoParametro      IN NUMBER,
        inuAttributoId        IN NUMBER,
        iblValida             IN BOOLEAN
        
    ) RETURN VARCHAR2;
END pkg_botiposolicitud;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_botiposolicitud
IS
    -- Constantes para el control de la traza
    csbSP_NAME           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;

    csbVersion 	VARCHAR2(15) := 'OSF-3586';

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 08/11/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     08/11/2024  OSF-83586    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtParametroTipoSolicitud 
    Descripcion     : obtiene el parametro por tipo de solicitud
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 11-09-2024 
    Modificaciones  :
    Autor               Fecha         Caso          Descripcion
    felipe.valencia     12-11-2024    OSF-3586      Creacion
    ***************************************************************************/   
    FUNCTION fsbObtParametroTipoSolicitud
    ( 
        inuTipoParametro      IN NUMBER,
        inuAttributoId        IN NUMBER,
        iblValida             IN BOOLEAN
        
    ) RETURN VARCHAR2
	  IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'fsbObtParametroTipoSolicitud';
        sbvalor     VARCHAR2(1000) := NULL;
	  BEGIN    
      pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
      pkg_traza.trace('inuTipoParametro    <= '||inuTipoParametro, csbNivelTraza); 
      pkg_traza.trace('inuAttributoId       <= '||inuAttributoId, csbNivelTraza);      
      
      sbvalor := ps_bopacktypeparam.fsbgetpacktypeparam(inuTipoParametro,inuAttributoId,iblValida);

      RETURN sbvalor;
              
      pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbvalor;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbvalor;
    END fsbObtParametroTipoSolicitud;

END pkg_botiposolicitud;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOTIPOSOLICITUD', 'ADM_PERSON');
END;
/