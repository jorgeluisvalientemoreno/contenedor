CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCDIRECCIONES IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcordenes
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-10-2023
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					direcciones
    Modificaciones  :
    Autor       Fecha       Caso     	Descripcion
	jerazomvm	14/05/2025	OSF-4466	Se crea la función fnuObtZonaOperativa
	jerazomvm	08-11-2023	OSF-1831	1. Se crea el cursor cuGetRecord
										2. Se crea el tipo tabla tytbDirecciones y tipo record tyrfDirecciones
										3. Se crea las funciones:
											- frcgetRecord
											- fnuGetSegmento_id
											- fsbGetIsMain
    jsoto       09-10-2023  OSF-1740 	Creacion
*******************************************************************************/

	CURSOR cuGetRecord(inuDireccionId IN ab_address.address_id%TYPE ) 
	IS
		SELECT AB_ADDRESS.*,
			   AB_ADDRESS.ROWID
		FROM AB_ADDRESS
		WHERE ADDRESS_ID = inuDireccionId;
		
	SUBTYPE styDirecciones IS cuGetRecord%ROWTYPE;
	
	TYPE tytbDirecciones IS TABLE OF styDirecciones INDEX BY BINARY_INTEGER;
	TYPE tyrfDirecciones IS REF CURSOR RETURN styDirecciones;	

-- Retorna verdadero si la direccion existe
FUNCTION fblExiste
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN BOOLEAN;

FUNCTION fnuGetPredio
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN ab_address.estate_number%TYPE;


 FUNCTION fnuGetDepartamento
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN ab_address.geograp_location_id%TYPE;
  

FUNCTION fnuGetLocalidad
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN ab_address.geograp_location_id%TYPE;


FUNCTION fnuGetBarrio
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN ab_address.neighborthood_id%TYPE;


FUNCTION fsbGetDireccion
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN ab_address.address%TYPE;


FUNCTION fsbGetDireccionParseada
(
  inuDireccionId ab_address.address_id%TYPE
)
  RETURN ab_address.address_parsed%TYPE;



FUNCTION fsbGetDescripcionUbicaGeo
(
  inuUbicacionGeografica ge_geogra_location.geograp_location_id%TYPE
)
  RETURN ge_geogra_location.description%TYPE;


FUNCTION fnuGetUbicaGeoPadre
(
  inuUbicacionGeografica ge_geogra_location.GEOGRAP_LOCATION_ID%TYPE
)
  RETURN ge_geogra_location.geo_loca_father_id%TYPE;
  
	-- Retorna un registro de tipo styDirecciones 
	FUNCTION frcgetRecord
	(
		inuDireccionId	IN	ab_address.address_id%TYPE 
	)
	RETURN styDirecciones;
	
	-- Obtiene el segmento de la dirección
	FUNCTION fnuGetSegmento_id
	(
		inuDireccionId IN ab_address.address_id%TYPE
	)
	RETURN ab_address.segment_id%TYPE;
	
	-- Obtiene si la dirección es principal
	FUNCTION fsbGetIsMain
	(
		inuDireccionId IN ab_address.address_id%TYPE
	)
	RETURN ab_address.is_main%TYPE;

  -- Servicio para obtener la categoria configurada en un segmento
  FUNCTION fnuObtCategoriaSegmento(inuSegmento NUMBER) RETURN NUMBER;

  -- Servicio para obtener la Subcategoria configurada en un segmento
  FUNCTION fnuObtSubCategoriaSegmento(inuSegmento NUMBER) RETURN NUMBER;
  
	-- Obtiene zona operativa de una dirección   
	FUNCTION fnuObtZonaOperativa(inuDireccion IN ab_address.address_id%TYPE)
	RETURN NUMBER;

END PKG_BCDIRECCIONES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCDIRECCIONES IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-1740';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'pkg_bcdirecciones.';
    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
	-- Cursor
	rcdata 		cuGetRecord%ROWTYPE;


FUNCTION fblExiste
(
   inuDireccionId ab_address.address_id%TYPE
) 
   RETURN BOOLEAN IS

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExiste 
    Descripcion     : Consulta la existencia de la direccion con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la direccion a consultar en la tabla AB_ADDRESS
	
	Parametros de salida
	Retorna True si la direccion existe
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/
	
    
   csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fblExiste';

   nuExiste NUMBER;   
   onuCodError NUMBER;
   osbMensError VARCHAR2(2000);

   
   CURSOR cuDireccion IS
   SELECT COUNT(*)
   FROM ab_address
   WHERE address_id = inuDireccionId;
   
   BEGIN
       pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);

       IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO nuExiste;
	   CLOSE cuDireccion;

       pkg_traza.trace('nuExiste: ' || nuExiste, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   IF nuExiste >0 THEN
		  RETURN TRUE;
	   END IF;   

	   RETURN FALSE;   
           
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN FALSE;
    END fblExiste;

    FUNCTION fnuGetPredio
	(
	  inuDireccionId ab_address.address_id%TYPE
	)
	  RETURN ab_address.estate_number%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPredio 
    Descripcion     : Consulta el predio con el identificador de direccion ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la Direccion a consultar en la tabla AB_ADDRESS
	
	Parametros de salida
	onuPredio       Id del predio
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetPredio';
	
   onuPredio ab_address.estate_number%TYPE;
   onuCodError NUMBER;
   osbMensError VARCHAR2(2000);
	
    CURSOR cuDireccion IS
    SELECT to_number(estate_number)
    FROM ab_address
    WHERE address_id = inuDireccionId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
	   
	   IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO onuPredio;
	   CLOSE cuDireccion;

       pkg_traza.trace('onuPredio: ' || onuPredio, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuPredio;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuPredio;
	END fnuGetPredio;

    FUNCTION fnuGetDepartamento
	(
	  inuDireccionId ab_address.address_id%TYPE
	)
	  RETURN ab_address.geograp_location_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetDepartamento 
    Descripcion     : Consulta el departamento de la dirección con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la direccion a consultar en la tabla AB_ADDRESS
	
	Parametros de salida
	onuDepartamento Id del identificador de la ubicacion geográfica de tipo departamento
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetDepartamento';
	
	onuDepartamento ab_address.geograp_location_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);

	
    CURSOR cuDireccion IS
    SELECT  geo_loca_father_id
    FROM    ab_address, ge_geogra_location
    WHERE   ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
    AND     ab_address.address_id = inuDireccionId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
	   
	   IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO onuDepartamento;
	   CLOSE cuDireccion;

       pkg_traza.trace('onuDepartamento: ' || onuDepartamento, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuDepartamento;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuDepartamento;
	END fnuGetDepartamento;

    FUNCTION fnuGetLocalidad
	(
	  inuDireccionId ab_address.address_id%TYPE
	)
	  RETURN ab_address.geograp_location_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetLocalidad 
    Descripcion     : Consulta la localidad de la direccion con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la direccion a consultar en la tabla AB_ADDRESS
	
	Parametros de salida
	onuLocalidad    ID de la localidad de la direccion
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetLocalidad';
	
    onuLocalidad ab_address.geograp_location_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuDireccion IS
    SELECT  geograp_location_id
    FROM 	ab_address
    WHERE   address_id = inuDireccionId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
	   
	   IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO onuLocalidad;
	   CLOSE cuDireccion;

       pkg_traza.trace('onuLocalidad: ' || onuLocalidad, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuLocalidad;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuLocalidad;
	END fnuGetLocalidad;


    FUNCTION fnuGetBarrio
	(
	  inuDireccionId ab_address.address_id%TYPE
	)
	  RETURN ab_address.neighborthood_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetBarrio 
    Descripcion     : Consulta el barrio de la direccion con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la direccion a consultar en la tabla AB_ADDRESS
	
	Parametros de salida
	onuBarrio    ID del barrio de la direccion
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetBarrio';
	
	onuBarrio ab_address.neighborthood_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuDireccion IS
    SELECT  neighborthood_id
    FROM 	ab_address
    WHERE   address_id = inuDireccionId;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
	   
	   IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO onuBarrio;
	   CLOSE cuDireccion;

       pkg_traza.trace('onuBarrio: ' || onuBarrio, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuBarrio;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuBarrio;
	END fnuGetBarrio;


    FUNCTION fsbGetDireccion
	(
	  inuDireccionId ab_address.address_id%TYPE
	)
	  RETURN ab_address.address%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetDireccion 
    Descripcion     : Consulta la dirección con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la dirección a consultar en la tabla AB_ADDRESS
	
	Parametros de salida
	osbDireccion    texto de Dirección del Id de la direccion
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbGetDireccion';
	
	osbDireccion ab_address.address%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuDireccion IS
    SELECT  address
    FROM 	ab_address
    WHERE   address_id = inuDireccionId;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
	   
	   IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO osbDireccion;
	   CLOSE cuDireccion;

       pkg_traza.trace('osbDireccion: ' || osbDireccion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbDireccion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbDireccion;
	END fsbGetDireccion;

    FUNCTION fsbGetDireccionParseada
	(
	  inuDireccionId ab_address.address_id%TYPE
	)
	  RETURN ab_address.address_parsed%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetDireccionParseada 
    Descripcion     : Consulta la dirección parseada con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuDireccionId	Id de la dirección a consultar en la tabla ab_address
	
	Parametros de salida
	osbDireccionParseada    Direccion parseada correspondiente al ID de la dirección
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbGetDireccionParseada';
	
	osbDireccionParseada ab_address.address_parsed%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuDireccion IS
    SELECT  address_parsed
    FROM 	ab_address
    WHERE   address_id = inuDireccionId;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
	   
	   IF cuDireccion%ISOPEN THEN 
	      CLOSE cuDireccion;
	   END IF;
		
	   OPEN cuDireccion;
	   FETCH cuDireccion INTO osbDireccionParseada;
	   CLOSE cuDireccion;

       pkg_traza.trace('osbDireccionParseada: ' || osbDireccionParseada, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbDireccionParseada;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbDireccionParseada;
	END fsbGetDireccionParseada;


    FUNCTION fsbGetDescripcionUbicaGeo
	(
	  inuUbicacionGeografica ge_geogra_location.geograp_location_id%TYPE
	)
	  RETURN ge_geogra_location.description%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetDescripcionUbicaGeo 
    Descripcion     : Consulta la descripcion de la ubicacion geografica con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuUbicacionGeografica	Id de la ubicacion a consultar en la tabla GE_GEOGRA_LOCATION
	
	Parametros de salida
	osbDescripcion    Descripcion de la ubicacion ngeografica ingresada
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbGetDescripcionUbicaGeo';
	
	osbDescripcion ge_geogra_location.description%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuUbicacionGeo IS
    SELECT description
    FROM   ge_geogra_location
    WHERE  geograp_location_id = inuUbicacionGeografica;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUbicacionGeografica: ' || inuUbicacionGeografica, cnuNVLTRC);
	   
	   IF cuUbicacionGeo%ISOPEN THEN 
	      CLOSE cuUbicacionGeo;
	   END IF;
		
	   OPEN cuUbicacionGeo;
	   FETCH cuUbicacionGeo INTO osbDescripcion;
	   CLOSE cuUbicacionGeo;

       pkg_traza.trace('osbDescripcion: ' || osbDescripcion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbDescripcion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbDescripcion;
	END fsbGetDescripcionUbicaGeo;


    FUNCTION fnuGetUbicaGeoPadre
	(
	  inuUbicacionGeografica ge_geogra_location.GEOGRAP_LOCATION_ID%TYPE
	)
	  RETURN ge_geogra_location.geo_loca_father_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetUbicaGeoPadre 
    Descripcion     : Consulta el ID de la ubicacion geografica padre de la ingresada por parametro
    Autor           : Jhon Soto - Horbath
    Fecha           : 09-10-2023
	
	Parametros de entrada
	inuUbicacionGeografica	Id de la ubicacion geografica a consultar en la tabla ge_geogra_location
	
	Parametros de salida
	onuUbicacionGeograficaPadre    ID de la ubicacion geografica padre
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       09-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetUbicaGeoPadre';
	
	onuUbicacionGeograficaPadre ge_geogra_location.geo_loca_father_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuUbicacionGeo IS
    SELECT  geo_loca_father_id
    FROM 	ge_geogra_location
    WHERE   geograp_location_id = inuUbicacionGeografica;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUbicacionGeografica: ' || inuUbicacionGeografica, cnuNVLTRC);
	   
	   IF cuUbicacionGeo%ISOPEN THEN 
	      CLOSE cuUbicacionGeo;
	   END IF;
		
	   OPEN cuUbicacionGeo;
	   FETCH cuUbicacionGeo INTO onuUbicacionGeograficaPadre;
	   CLOSE cuUbicacionGeo;

       pkg_traza.trace('onuUbicacionGeograficaPadre: ' || onuUbicacionGeograficaPadre, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuUbicacionGeograficaPadre;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuUbicacionGeograficaPadre;
	END fnuGetUbicaGeoPadre;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord 
    Descripcion     : Retorna un registro de tipo styDirecciones
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 08-11-2023 
	
	Parametros de entrada:
		inuDireccionId 		Identificador de la dirección
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   08-11-2023  OSF-1831    Creacion
    ***************************************************************************/  
	FUNCTION frcgetRecord
	(
		inuDireccionId	IN	ab_address.address_id%TYPE 
	)
	RETURN styDirecciones
	IS
        csbMT_NAME		VARCHAR2(70) := csbSP_NAME || 'frcgetRecord';
		rcerror 		styDirecciones;
		rcrecordnull	cuGetRecord%ROWTYPE;
		
		PROCEDURE pCierracuRecord
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierracuRecord';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        
        
            IF cuGetRecord%ISOPEN THEN  
                CLOSE cuGetRecord;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierracuRecord; 
		
	BEGIN	

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
		
		rcerror.address_id := inuDireccionId;
		
		pCierracuRecord;
		
		OPEN cuGetRecord(inuDireccionId);
        FETCH cuGetRecord INTO rcdata;
		
		IF cuGetRecord%NOTFOUND  THEN
			CLOSE cuGetRecord;
			rcdata := rcrecordnull;
			RAISE NO_DATA_FOUND;
		END IF;
		
		CLOSE cuGetRecord;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN rcdata;
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			pkg_error.SetErrorMessage(1,
									  'Dirección: [' || inuDireccionId || ']'
									  );
	END frcgetRecord;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSegmento_id 
    Descripcion     : Retorna el segmento de la dirección
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 08-11-2023 
	
	Parametros de entrada:
		inuDireccionId 		Identificador de la dirección
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   08-11-2023  OSF-1831    Creacion
    ***************************************************************************/                     
    FUNCTION fnuGetSegmento_id
	(
		inuDireccionId IN ab_address.address_id%TYPE
	)
	RETURN ab_address.segment_id%TYPE
    IS

        -- Nombre del metodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuGetSegmento_id';
        
        CURSOR cuSegmento
        IS
        SELECT  segment_id
        FROM ab_address 
        WHERE address_id = inuDireccionId;
        
        nusegmentoId    ab_address.segment_id%TYPE;
        
        PROCEDURE pCierraCuSegmento
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuSegmento';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        
        
            IF cuSegmento%ISOPEN THEN  
                CLOSE cuSegmento;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuSegmento;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
        
        pCierraCuSegmento;
    
        OPEN cuSegmento;
        FETCH cuSegmento INTO nusegmentoId;
        CLOSE cuSegmento;
		
		pkg_traza.trace('nusegmentoId: ' || nusegmentoId, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nusegmentoId;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierraCuSegmento;
            RETURN nusegmentoId;                 
    END fnuGetSegmento_id; 

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetIsMain 
    Descripcion     : Obtiene si la dirección es principal
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 08-11-2023 
	
	Parametros de entrada:
		inuDireccionId 		Identificador de la dirección
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   08-11-2023  OSF-1831    Creacion
    ***************************************************************************/                     
	FUNCTION fsbGetIsMain
	(
		inuDireccionId IN ab_address.address_id%TYPE
	)
	RETURN ab_address.is_main%TYPE
    IS

        -- Nombre del metodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbGetIsMain';
        
        CURSOR cuIsMain
        IS
        SELECT  is_main
        FROM ab_address 
        WHERE address_id = inuDireccionId;
        
        sbIsMain    ab_address.is_main%TYPE;
        
        PROCEDURE pCierraCuIsMain
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.pCierraCuIsMain';        
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, csbInicio);        
        
            IF cuIsMain%ISOPEN THEN  
                CLOSE cuIsMain;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, cnuNVLTRC, pkg_traza.csbFIN);

        END pCierraCuIsMain;             
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuDireccionId: ' || inuDireccionId, cnuNVLTRC);
        
        pCierraCuIsMain;
    
        OPEN cuIsMain;
        FETCH cuIsMain INTO sbIsMain;
        CLOSE cuIsMain;
		
		pkg_traza.trace('sbIsMain: ' || sbIsMain, cnuNVLTRC);
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN sbIsMain;
        
    EXCEPTION
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.SetError;
            pCierraCuIsMain;
            RETURN sbIsMain;                 
    END fsbGetIsMain; 

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCategoriaSegmento
    Descripcion     : Servicio para obtener la categoria configurada en un segmento
    Caso            : OSF-3541 
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuSegmento       Codigo inuSegmento
        
      Salida
        nuCategoria       Codigo Categoria
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  FUNCTION fnuObtCategoriaSegmento(inuSegmento NUMBER) RETURN NUMBER IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtCategoriaSegmento';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    CURSOR cuCategoria is
      select se.category_
        from ab_segments se
       where se.segments_id = inuSegmento;
  
    --variables para obtener data de FLAG de visita de campo
    nuCategoria VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    open cuCategoria;
    fetch cuCategoria
      into nuCategoria;
    close cuCategoria;
  
    pkg_traza.trace('Categoria: ' || nuCategoria, cnuNVLTRC);
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
  
    return(nuCategoria);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END fnuObtCategoriaSegmento;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtSubCategoriaSegmento
    Descripcion     : Servicio para obtener la Subcategoria configurada en un segmento
    Caso            : OSF-3541 
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuSegmento       Codigo Segmento
        
      Salida
        nuSubCategoria    Codigo SubCategoria
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  FUNCTION fnuObtSubCategoriaSegmento(inuSegmento NUMBER) RETURN NUMBER IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtSubCategoriaSegmento';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    CURSOR cuSubCategoria is
      select se.subcategory_
        from ab_segments se
       where se.segments_id = inuSegmento;
  
    --variables para obtener data de FLAG de visita de campo
    nuSubCategoria VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    open cuSubCategoria;
    fetch cuSubCategoria
      into nuSubCategoria;
    close cuSubCategoria;
  
    pkg_traza.trace('SubCategoria: ' || nuSubCategoria, cnuNVLTRC);
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
  
    return(nuSubCategoria);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END fnuObtSubCategoriaSegmento;
  
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtZonaOperativa
    Descripcion     : Obtiene zona operativa de una dirección
    Caso            : OSF-3541
    Autor           : Jhon Erazo
    Fecha           : 14/05/2025
    
    Parametros
		Entrada
			inuDireccion 	Identificador de la dirección
		
		Salida
			nuZonaOperativa		Zona operativa de la dirección
    
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    jerazomvm	14/05/2025	OSF-4480   OSF-4480: Creación
    ***************************************************************************/    
    FUNCTION fnuObtZonaOperativa(inuDireccion IN ab_address.address_id%TYPE) 
	RETURN NUMBER 
	IS
    
        csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtZonaOperativa';
		
        nuErrorCode 	NUMBER; -- se almacena codigo de error
		nuZonaOperativa	or_route_zone.operating_zone_id%TYPE;
        sbMensError 	VARCHAR2(2000); -- se almacena descripcion del error
        
        CURSOR cuZonaOperativa 
		IS
			SELECT ro.operating_zone_id
            FROM ab_address    ab,
                 ab_segments   seg,
                 or_route_zone ro
            WHERE ab.address_id = inuDireccion
            AND seg.segments_id	= ab.segment_id
            AND ro.route_id		= seg.route_id;
    
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuDireccion: ' || inuDireccion, cnuNVLTRC);
        
        IF (cuZonaOperativa%ISOPEN) THEN
			CLOSE cuZonaOperativa;
		END IF;
		
		OPEN cuZonaOperativa;
        FETCH cuZonaOperativa INTO nuZonaOperativa;
        CLOSE cuZonaOperativa;
        
        pkg_traza.trace('nuZonaOperativa: ' || nuZonaOperativa, cnuNVLTRC);
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuZonaOperativa;
    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
              pkg_Error.getError(nuErrorCode, sbMensError);
              pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
              pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
              RAISE pkg_Error.Controlled_Error;
        
        WHEN OTHERS THEN
              pkg_Error.setError;
              pkg_Error.getError(nuErrorCode, sbMensError);
              pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
              pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
              RAISE pkg_Error.Controlled_Error;
    
    END fnuObtZonaOperativa;

END PKG_BCDIRECCIONES;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcdirecciones
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCDIRECCIONES', 'ADM_PERSON');
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre el paquete PKG_BCDIRECCIONES
GRANT EXECUTE ON ADM_PERSON.PKG_BCDIRECCIONES TO REXEREPORTES;
/