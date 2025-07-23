CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_GE_ITEMS_SERIADO IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_ge_items_seriado
      Autor       :   Jorge Valiente
      Fecha       :   01-02-2024
      Descripcion :   Paquete con los metodos CRUD para manejo de informacion
                      sobre la entidad las tablas ge_items_seriado
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  --recibe el identificacion del item y la serie del elemento de medicion.
  PROCEDURE prcRetirarUnidadOperativa(inuItems_id in number,
                                      idbSerie    in varchar2);
									  
   FUNCTION fnuObtItemSeriadoPorSerie(isbSerie in ge_items_seriado.serie%type) 
  RETURN ge_items_seriado.id_items_seriado%TYPE;

   FUNCTION fnuObtItems_Id(inuItemSeriado in ge_items_seriado.id_items_seriado%type)
   RETURN ge_items_seriado.items_id%TYPE;

   FUNCTION fsbObtSerie(inuItemSeriado in ge_items_seriado.id_items_seriado%type) 
   RETURN ge_items_seriado.serie%TYPE;
   
   FUNCTION fsbObtpropiedad(inuItemSeriado in ge_items_seriado.id_items_seriado%type) 
   RETURN ge_items_seriado.propiedad%TYPE;

END PKG_GE_ITEMS_SERIADO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_GE_ITEMS_SERIADO IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-3591';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Jorge Valiente
    Fecha           : 01-02-2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prcRetirarUnidadOperativa(inuItems_id in number,
                                      idbSerie    in varchar2) IS
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcRetirarUnidadOperativa
    Descripcion     : Retira la unidad operativa de un item seriado.
    Autor           : Jorge Valiente
    Fecha           : 01-02-2024
    
    Parametros de Entrada
    inuproduct_id     Codigo del producto
    
    Parametros de Salida
    isbrcProduct      Registro de la tabla Producto
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcRetirarUnidadOperativa';
    nuError    NUMBER; -- se almacena codigo de error
    sbError    VARCHAR2(2000); -- se almacena descripcion del error
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    update ge_items_seriado gis
       set gis.operating_unit_id = null
     where gis.items_id = inuItems_id
       and gis.serie = idbSerie;
  
    ut_trace.trace('Retira unidad operativa del item seriado: ' ||
                   idbSerie,
                   pkg_traza.cnuNivelTrzDef);
 
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END;

  FUNCTION fnuObtItemSeriadoPorSerie(isbSerie in ge_items_seriado.serie%type) 
  RETURN ge_items_seriado.id_items_seriado%TYPE
  IS
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtItemSeriadoPorSerie
    Descripcion     : Retorna Id de GE_ITEMS_SERIADO dada la serie del equipo.
    Autor           : Jhon Jairo Soto
    Fecha           : 20-11-2024
    
    Parametros de Entrada
    isbSerie       Numero de serie del equipo
    
    Parametros de Salida
    idSerie       Id del item seriado
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.fnuObtItemSeriadoPorSerie';
    nuError    NUMBER; -- se almacena codigo de error
    sbError    VARCHAR2(2000); -- se almacena descripcion del error
	idSerie	   GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
	
	CURSOR cuItemsSeriado IS
	SELECT ID_ITEMS_SERIADO
	FROM GE_ITEMS_SERIADO
	WHERE SERIE = isbSerie;
	
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
 
	OPEN cuItemsSeriado;
	FETCH cuItemsSeriado INTO idSerie;
	CLOSE cuItemsSeriado;

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN idSerie;

  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
   
  END fnuObtItemSeriadoPorSerie;


   FUNCTION fnuObtItems_Id(inuItemSeriado in ge_items_seriado.id_items_seriado%type)
   RETURN ge_items_seriado.items_id%TYPE
  IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtItems_Id
    Descripcion     : Retorna items_id de GE_ITEMS_SERIADO dado el ID de la tabla.
    Autor           : Jhon Jairo Soto
    Fecha           : 23-12-2024
    
    Parametros de Entrada
    inuItemSeriado       Numero Id 
    
    Parametros de Salida
    nuitems_id       campo items_id de la tabla
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion

    ***************************************************************************/
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.fnuObtItems_Id';
    nuError    NUMBER; -- se almacena codigo de error
    sbError    VARCHAR2(2000); -- se almacena descripcion del error
	nuItems_id	ge_items_seriado.items_id%TYPE;
	
	CURSOR cuItemsSeriado IS
	SELECT items_id
	FROM ge_items_seriado
	WHERE id_items_seriado = inuItemSeriado;
	
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
 
	OPEN cuItemsSeriado;
	FETCH cuItemsSeriado INTO nuItems_id;
	CLOSE cuItemsSeriado;

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN nuItems_id;

  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
   
  END fnuObtItems_Id;

   FUNCTION fsbObtSerie(inuItemSeriado in ge_items_seriado.id_items_seriado%type) 
   RETURN ge_items_seriado.serie%TYPE
  IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtSerie
    Descripcion     : Retorna serie de GE_ITEMS_SERIADO dado el ID de la tabla.
    Autor           : Jhon Jairo Soto
    Fecha           : 23-12-2024
    
    Parametros de Entrada
    inuItemSeriado       Numero Id 
    
    Parametros de Salida
    nuitems_id       campo items_id de la tabla
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
	jsoto		28/01/2025	OSF-3911 Creacion
    ***************************************************************************/
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.fsbObtSerie';
    nuError    NUMBER; -- se almacena codigo de error
    sbError    VARCHAR2(2000); -- se almacena descripcion del error
	sbSerie	ge_items_seriado.serie%TYPE;
	
	CURSOR cuItemsSeriado IS
	SELECT serie
	FROM ge_items_seriado
	WHERE id_items_seriado = inuItemSeriado;
	
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
 
	OPEN cuItemsSeriado;
	FETCH cuItemsSeriado INTO sbSerie;
	CLOSE cuItemsSeriado;

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN sbSerie;

  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
   
  END fsbObtSerie;


   FUNCTION fsbObtpropiedad(inuItemSeriado in ge_items_seriado.id_items_seriado%type) 
   RETURN ge_items_seriado.propiedad%TYPE
  IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtpropiedad
    Descripcion     : Retorna propiedad de GE_ITEMS_SERIADO dado el ID de la tabla.
    Autor           : Jhon Jairo Soto
    Fecha           : 23-12-2024
    
    Parametros de Entrada
    inuItemSeriado       Numero Id 
    
    Parametros de Salida
    sbPropiedad       campo items_id de la tabla
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
	jsoto		28/01/2025	OSF-3911 Creacion
    ***************************************************************************/
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.fsbObtpropiedad';
    nuError    NUMBER; -- se almacena codigo de error
    sbError    VARCHAR2(2000); -- se almacena descripcion del error
	sbPropiedad	ge_items_seriado.propiedad%TYPE;
	
	CURSOR cuItemsSeriado IS
	SELECT propiedad
	FROM ge_items_seriado
	WHERE id_items_seriado = inuItemSeriado;
	
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
 
	OPEN cuItemsSeriado;
	FETCH cuItemsSeriado INTO sbPropiedad;
	CLOSE cuItemsSeriado;

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN sbPropiedad;

  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
   
  END fsbObtpropiedad;

END PKG_GE_ITEMS_SERIADO;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_GE_ITEMS_SERIADO', 'ADM_PERSON');
END;
/
