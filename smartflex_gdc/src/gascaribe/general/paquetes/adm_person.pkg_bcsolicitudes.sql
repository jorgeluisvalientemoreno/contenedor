CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCSOLICITUDES IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcordenes
    Autor       :   Jhon Soto - Horbath
    Fecha       :   06-10-2023
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					solicitudes
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
	jsoto         11-10-2023  OSF-1770 Ajuste tipo de dato retornado por fnuGetSolicitudDelMotivo
	                                 Cambio de manejo de trazas por pkg_traza.
	jsoto		      23-10-2023	OSF-1773 Se agregan funciones
	jpinedc		    26-09-2024	OSF-3368 Se crea fnuObtieneOrdenEnComentario
  dsaltarin     02-10-2024  OSF-3407 Se crea fnuGetPrimeraOT
*******************************************************************************/

CURSOR cuRecord( inuPackage_Id IN mo_packages.package_id%TYPE ) IS
SELECT mo_packages.*,mo_packages.rowid
FROM mo_packages
WHERE package_Id = inuPackage_Id;

SUBTYPE stySolicitudes IS cuRecord%ROWTYPE;
	   
TYPE tytbSolicitudes  IS TABLE OF stySolicitudes  INDEX BY BINARY_INTEGER;



-- Retorna verdadero si la solicitud existe
FUNCTION fblExiste
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN BOOLEAN;

FUNCTION fdtGetFechaAtencion
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.attention_date%TYPE;
  
FUNCTION fdtGetFechaRegistro
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.request_date%TYPE;

FUNCTION fnuGetDireccion
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.address_id%TYPE;

FUNCTION fnuGetEstado
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.motive_status_id%TYPE;


 FUNCTION fnuGetUnidadOperativa
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.operating_unit_id%TYPE;

FUNCTION fnuGetTipoSolicitud
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.package_type_id%TYPE;

FUNCTION fnuGetPuntoVenta
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.pos_oper_unit_id%TYPE;


FUNCTION fnuGetCliente
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.subscriber_id%TYPE;


FUNCTION fnuGetContrato
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_motive.subscription_id%TYPE;


FUNCTION fnuGetProducto
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_motive.product_id%TYPE;


FUNCTION fnuGetSolicitudDelMotivo
(
  inuMotivoId mo_motive.motive_id%TYPE
)
  RETURN mo_packages.package_id%TYPE;


FUNCTION fnuGetSolicitudAnulacion
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.package_id%TYPE;
  

FUNCTION fsbGetComentario
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.comment_%TYPE;  


FUNCTION fnuGetMedioRecepcion
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.reception_type_id%TYPE;  


FUNCTION fnuGetContacto
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.contact_id%TYPE;  


FUNCTION fnuGetPersona
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.person_id%TYPE;  


FUNCTION fnuGetInteraccion
(
  inuSolicitudId mo_packages.package_id%TYPE
)
  RETURN mo_packages.cust_care_reques_num%TYPE;  


FUNCTION fnuGetSuscripcion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.subscription_pend_id%TYPE;


FUNCTION fnuGetDocumento
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.document_key%TYPE;
      
      
FUNCTION frcGetRecord 
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN stySolicitudes;

    -- Obtiene la orden en el comentario de la solicitud
    FUNCTION fnuObtieneOrdenEnComentario 
    (
        inuSolicitud mo_packages.package_id%TYPE 
    )
      RETURN or_order.order_id%TYPE;


    -- Obtiene la primera orden de la solicitud
    FUNCTION fnuGetPrimeraOT 
    (
        inuSolicitud mo_packages.package_id%TYPE 
    )
      RETURN or_order.order_id%TYPE;

  -- Servicio para obtener la Categoria del motivo
  FUNCTION fnuObtCategoriaDeMotivo(inuMotivo NUMBER) RETURN NUMBER;

  -- Servicio para obtener la SubCategoria del motivo
  FUNCTION fnuObtSubCategoriaDeMotivo(inuMotivo NUMBER) RETURN NUMBER;

  -- Servicio para retornar el motivo con relación al código de la solicitud.
  FUNCTION fnuObtenerMotivoDeSolicitud(inuSolicitud NUMBER) RETURN NUMBER;

  -- Servicio para retornar el producto del motivo
  FUNCTION fnuObtProductoDeMotivo(inuMotivo NUMBER) RETURN NUMBER;

END PKG_BCSOLICITUDES;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCSOLICITUDES IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'pkg_bcsolicitudes.';
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3368';

    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

    CSBTOKEN_LEGA_ORDEN CONSTANT VARCHAR2(35) :='LEGALIZACION ORDEN\[';

FUNCTION fblExiste
(
   inuSolicitudId mo_packages.package_id%TYPE
) 
   RETURN BOOLEAN IS

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExiste 
    Descripcion     : Consulta la existencia de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	Retorna True si la solicitud existe
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/
	
    
   csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fblExiste';

   nuExiste NUMBER;   
   onuCodError NUMBER;
   osbMensError VARCHAR2(2000);

   
   CURSOR cuSolicitud IS
   SELECT COUNT(*)
   FROM mo_packages
   WHERE package_id = inuSolicitudId;
   
   BEGIN

       pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);

       IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO nuExiste;
	   CLOSE cuSolicitud;

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

    FUNCTION fdtGetFechaAtencion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.attention_date%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtGetFechaAtencion 
    Descripcion     : Consulta la fecha de atención de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	odtFechaAtencion Fecha de atención
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtGetFechaAtencion';
	
	odtFechaAtencion mo_packages.attention_date%TYPE;
   onuCodError NUMBER;
   osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT attention_date
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO odtFechaAtencion;
	   CLOSE cuSolicitud;

       pkg_traza.trace('odtFechaAtencion: ' || odtFechaAtencion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN odtFechaAtencion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN odtFechaAtencion;
	END fdtGetFechaAtencion;

    FUNCTION fdtGetFechaRegistro
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.request_date%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtGetFechaRegistro 
    Descripcion     : Consulta la fecha de registro de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	odtFechaRegistro Fecha de Registro
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtGetFechaRegistro';
	
	odtFechaRegistro mo_packages.request_date%TYPE;
   onuCodError NUMBER;
   osbMensError VARCHAR2(2000);

	
    CURSOR cuSolicitud IS
    SELECT request_date
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO odtFecharegistro;
	   CLOSE cuSolicitud;

       pkg_traza.trace('odtFecharegistro: ' || odtFecharegistro, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN odtFecharegistro;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN odtFecharegistro;
	END fdtGetFechaRegistro;

    FUNCTION fnuGetDireccion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.address_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetDireccion 
    Descripcion     : Consulta la direccion de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuDireccionId    ID de la dirección de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetDireccion';
	
    onuDireccionId mo_packages.address_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT address_id
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuDireccionId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuDireccionId: ' || onuDireccionId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuDireccionId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuDireccionId;
	END fnuGetDireccion;


    FUNCTION fnuGetEstado
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.motive_status_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetEstado 
    Descripcion     : Consulta el estado de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuEstadoSolicitudId    ID del estado de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetEstado';
	
	onuEstadoSolicitudId mo_packages.motive_status_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT motive_status_id
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuEstadoSolicitudId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuEstadoSolicitudId: ' || onuEstadoSolicitudId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuEstadoSolicitudId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuEstadoSolicitudId;
	END fnuGetEstado;


    FUNCTION fnuGetUnidadOperativa
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.operating_unit_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetUnidadOperativa 
    Descripcion     : Consulta la unidad operativa de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuUnidadOperativaId    ID de la unidad operativa de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetUnidadOperativa';
	
	onuUnidadOperativaId mo_packages.operating_unit_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT operating_unit_id
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuUnidadOperativaId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuUnidadOperativaId: ' || onuUnidadOperativaId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuUnidadOperativaId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuUnidadOperativaId;
	END fnuGetUnidadOperativa;

    FUNCTION fnuGetTipoSolicitud
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.package_type_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetTipoSolicitud 
    Descripcion     : Consulta el tipo de solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuTipoSolicitudId    ID de la unidad operativa de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetTipoSolicitud';
	
	onuTipoSolicitudId mo_packages.package_type_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT package_type_id
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuTipoSolicitudId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuTipoSolicitudId: ' || onuTipoSolicitudId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuTipoSolicitudId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuTipoSolicitudId;
	END fnuGetTipoSolicitud;


    FUNCTION fnuGetPuntoVenta
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.pos_oper_unit_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPuntoVenta 
    Descripcion     : Consulta el punto de venta de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuPuntoVentaId    ID del punto de venta de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetPuntoVenta';
	
	onuPuntoVentaId mo_packages.pos_oper_unit_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT pos_oper_unit_id
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuPuntoVentaId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuPuntoVentaId: ' || onuPuntoVentaId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuPuntoVentaId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuPuntoVentaId;
	END fnuGetPuntoVenta;


    FUNCTION fnuGetCliente
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.subscriber_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetCliente 
    Descripcion     : Consulta el cliente de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuClienteId    ID del cliente de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetCliente';
	
	onuClienteId mo_packages.subscriber_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
    SELECT subscriber_id
    FROM mo_packages
    WHERE package_id = inuSolicitudId;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuClienteId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuClienteId: ' || onuClienteId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuClienteId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuClienteId;
	END fnuGetCliente;


    FUNCTION fnuGetContrato
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_motive.subscription_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetContrato 
    Descripcion     : Consulta el contrato de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuContratoId    ID del contrato de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetContrato';
	
	onuContratoId mo_motive.subscription_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT subscription_id
	FROM   mo_motive
    WHERE  package_id = inuSolicitudId
	AND    subscription_id IS NOT NULL;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuContratoId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuContratoId: ' || onuContratoId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuContratoId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuContratoId;
	END fnuGetContrato;


    FUNCTION fnuGetProducto
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_motive.product_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetProducto 
    Descripcion     : Consulta el producto de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuProductoId    ID del producto de la solicitud
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetProducto';
	
	onuProductoId mo_motive.product_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT product_id
	FROM   mo_motive
    WHERE  package_id = inuSolicitudId
	AND    product_id IS NOT NULL;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuProductoId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuProductoId: ' || onuProductoId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuProductoId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuProductoId;
	END fnuGetProducto;

    FUNCTION fnuGetSolicitudDelMotivo
	(
	  inuMotivoId mo_motive.motive_id%TYPE
	)
	  RETURN mo_packages.package_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSolicitudDelMotivo 
    Descripcion     : Consulta el motivo de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuMotivoId	Id del motivo a consultar en la tabla MO_MOTIVE
	
	Parametros de salida
	onuSolicitudId    ID de la solicitud del motivo
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetSolicitudDelMotivo';
	
	onuSolicitudId mo_packages.package_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);

	
    CURSOR cuMotivo IS
	SELECT package_id
	FROM   mo_motive
	WHERE  motive_id = inuMotivoId;

    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuMotivoId: ' || inuMotivoId, cnuNVLTRC);
	   
	   IF cuMotivo%ISOPEN THEN 
	      CLOSE cuMotivo;
	   END IF;
		
	   OPEN cuMotivo;
	   FETCH cuMotivo INTO onuSolicitudId;
	   CLOSE cuMotivo;

       pkg_traza.trace('onuSolicitudId: ' || onuSolicitudId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuSolicitudId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuSolicitudId;
	END fnuGetSolicitudDelMotivo;

    FUNCTION fnuGetSolicitudAnulacion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.package_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSolicitudAnulacion 
    Descripcion     : Consulta el Id de la solicitud de anulación de la solicitud con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 06-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuSolicitudAnulId    ID de la solicitud de anulación
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       06-10-2023  OSF-1704 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetSolicitudAnulacion';
	
	onuSolicitudAnulId mo_packages.package_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT package_id
	FROM   mo_pack_annul_detail
	WHERE  annul_package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuSolicitudAnulId;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuSolicitudAnulId: ' || onuSolicitudAnulId, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuSolicitudAnulId;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuSolicitudAnulId;
	END fnuGetSolicitudAnulacion;


    FUNCTION fsbGetComentario
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.comment_%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetComentario 
    Descripcion     : Consulta el comentario de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	osbcomentario    Comentario de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbGetComentario';
	
	osbComentario mo_packages.comment_%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT comment_
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO osbComentario;
	   CLOSE cuSolicitud;

       pkg_traza.trace('osbComentario: ' || osbComentario, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbComentario;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbComentario;
	END fsbGetComentario;

   FUNCTION fnuGetMedioRecepcion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.reception_type_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetMedioRecepcion 
    Descripcion     : Consulta el medio de recepcion de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuTipoRecepcion    Medio de recepcion de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetMedioRecepcion';
	
	onuTipoRecepcion mo_packages.reception_type_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT reception_type_id
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuTipoRecepcion;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuTipoRecepcion: ' || onuTipoRecepcion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuTipoRecepcion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuTipoRecepcion;
	END fnuGetMedioRecepcion;


  FUNCTION fnuGetContacto
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.contact_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetContacto 
    Descripcion     : Consulta contacto de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuContacto    Contacto de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetContacto';
	
	onuContacto mo_packages.contact_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT contact_id
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuContacto;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuContacto: ' || onuContacto, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuContacto;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuContacto;
	END fnuGetContacto;

    FUNCTION fnuGetPersona
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.person_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPersona 
    Descripcion     : Consulta Persona de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuPersona    Persona de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetPersona';
	
	onuPersona mo_packages.person_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT person_id
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuPersona;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuPersona: ' || onuPersona, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuPersona;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuPersona;
	END fnuGetPersona;

    FUNCTION fnuGetInteraccion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.cust_care_reques_num%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetInteraccion 
    Descripcion     : Consulta Interaccion de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuInteraccion    Interaccion de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetInteraccion';
	
	onuInteraccion mo_packages.cust_care_reques_num%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT cust_care_reques_num
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuInteraccion;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuInteraccion: ' || onuInteraccion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuInteraccion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuInteraccion;
	END fnuGetInteraccion;


    FUNCTION fnuGetSuscripcion
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.subscription_pend_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSuscripcion 
    Descripcion     : Consulta Suscripcion de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuSuscripcion    Suscripcion de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetSuscripcion';
	
	onuSuscripcion mo_packages.subscription_pend_id%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT subscription_pend_id
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuSuscripcion;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuSuscripcion: ' || onuSuscripcion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuSuscripcion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuSuscripcion;
	END fnuGetSuscripcion;

    FUNCTION fnuGetDocumento
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN mo_packages.document_key%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetDocumento 
    Descripcion     : Consulta Documento (Document_key) de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	onuDocumento    Documento Asociado de la solicitud.
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetDocumento';
	
	onuDocumento mo_packages.document_key%TYPE;
    onuCodError NUMBER;
    osbMensError VARCHAR2(2000);
	
    CURSOR cuSolicitud IS
	SELECT document_key
	FROM   mo_packages
	WHERE  package_id = inuSolicitudId;
    
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuSolicitud%ISOPEN THEN 
	      CLOSE cuSolicitud;
	   END IF;
		
	   OPEN cuSolicitud;
	   FETCH cuSolicitud INTO onuDocumento;
	   CLOSE cuSolicitud;

       pkg_traza.trace('onuDocumento: ' || onuDocumento, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuDocumento;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuDocumento;
	END fnuGetDocumento;


    FUNCTION frcGetRecord 
	(
	  inuSolicitudId mo_packages.package_id%TYPE
	)
	  RETURN stySolicitudes
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord 
    Descripcion     : retorna el registro de la solicitud
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuSolicitudId	Id de la solicitud a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	stySolicitudes   Registro de la solicitud ingresada
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

      csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.frcgetRecord';

      rcDatos 		cuRecord%ROWTYPE;
      cuRegNulo 		cuRecord%ROWTYPE;
      onuCodError 	NUMBER;
      osbMensError 	VARCHAR2(2000);
	
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
	   
	   IF cuRecord%ISOPEN THEN 
	      CLOSE cuRecord;
	   END IF;
		
	   OPEN cuRecord(inuSolicitudId);
	   FETCH cuRecord INTO rcDatos;
	   
	    IF cuRecord%NOTFOUND THEN
			CLOSE cuRecord;
			rcDatos := cuRegNulo;
		END IF;
	   CLOSE cuRecord;

       pkg_traza.trace('rcDatos.package_id: ' || rcDatos.package_id, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN (rcDatos);
	   
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          pkg_error.setError;
          pkg_traza.trace('Registro no Existe: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
          pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERC); 
          return cuRegNulo;
        WHEN OTHERS THEN
          pkg_error.setError;
          pkg_error.getError(onuCodError,osbMensError);
          pkg_traza.trace('Registro no Existe: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
          pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
          return cuRegNulo;
	END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneOrdenEnComentario 
    Descripcion     : Obtiene la orden en el comentario de la solicitud
    
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 25-09-2024 
    
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     25-09-2024  OSF-3368    Creacion
    ***************************************************************************/ 
    FUNCTION fnuObtieneOrdenEnComentario 
    (
        inuSolicitud mo_packages.package_id%TYPE 
    )
    RETURN or_order.order_id%TYPE
    IS
        csbMetodo               CONSTANT VARCHAR2(70) :=  csbSP_NAME || 'fnuObtieneOrdenEnComentario';
        nuError                 NUMBER;
        sbError                 VARCHAR2(4000);
        sbComeSolicitud         mo_packages.comment_%TYPE;                  
        nuOrdEnComentario       or_order.order_id%TYPE;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
        
        pkg_traza.trace('inuSolicitud|' ||inuSolicitud , cnuNVLTRC );
        
        sbComeSolicitud := pkg_bcSolicitudes.fsbGetComentario( inuSolicitud );

        nuOrdEnComentario := REGEXP_SUBSTR( REGEXP_SUBSTR(sbComeSolicitud, CSBTOKEN_LEGA_ORDEN || '\d+\]'),'\d+');
               
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuOrdEnComentario;  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuOrdEnComentario;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuOrdEnComentario;
    END fnuObtieneOrdenEnComentario;
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPrimeraOT 
    Descripcion     : Obtiene la primera orden de la solicitud
    
    Autor           : dsaltarin
    Fecha           : 02-10-2024 
    
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    dsaltarin   02-10-2024  OSF-3407    Creacion
    ***************************************************************************/ 
    
    FUNCTION fnuGetPrimeraOT 
    (
        inuSolicitud mo_packages.package_id%TYPE 
    )
    RETURN or_order.order_id%TYPE
    IS
        csbMetodo               CONSTANT VARCHAR2(70) :=  csbSP_NAME || 'fnuObtieneOrdenEnComentario';
        nuError                 NUMBER;
        sbError                 VARCHAR2(4000);
        nuOrden                 or_order.order_id%TYPE;
        
        cursor cuOrdenes is
        select order_id
          from (
                  select  o.order_id,
                          o.created_date
                    from  or_order_activity a
              inner join  or_order o on o.order_id = a.order_id
              where a.package_id = inuSolicitud
                order by o.created_Date asc, o.order_id asc)
        where rownum=1;



        
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
        
        pkg_traza.trace('inuSolicitud|' ||inuSolicitud , cnuNVLTRC );
        
        IF cuOrdenes%ISOPEN THEN
          CLOSE cuOrdenes;
        END IF;
        OPEN cuOrdenes;
        FETCH cuOrdenes INTO nuOrden;
        CLOSE cuOrdenes;
               
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
        
        RETURN nuOrden;  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuOrden;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RETURN nuOrden;
    END fnuGetPrimeraOT;   
        -- Obtiene la primera orden de la solicitud

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCategoriaDeMotivo
    Descripcion     : Servicio para obtener la categoria del motivo
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuMotivo        Codigo Motivo
        
      Salida
        nuCategoria      Codigo Categoria
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  FUNCTION fnuObtCategoriaDeMotivo(inuMotivo NUMBER) RETURN NUMBER IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtCategoriaDeMotivo';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    CURSOR cuCategoria is
      select mm.category_id
        from mo_motive mm
       where mm.motive_id = inuMotivo;
  
    --variables del codigo de Categoria
    nuCategoria NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Motivo: ' || inuMotivo, cnuNVLTRC);
  
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
    
  END fnuObtCategoriaDeMotivo;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtSubCategoriaDeMotivo
    Descripcion     : Servicio para obtener la SubCategoria del motivo
    Caso            : OSF-3541    
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuMotivo        Codigo Motivo
        
      Salida
        nuSubCategoria   Codigo SubCategoria
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  FUNCTION fnuObtSubCategoriaDeMotivo(inuMotivo NUMBER) RETURN NUMBER IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtSubCategoriaDeMotivo';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    CURSOR cuSubCategoria is
      select mm.subcategory_id
        from mo_motive mm
       where mm.motive_id = inuMotivo;
  
    --variables del codigo de SubCategoria
    nuSubCategoria NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Motivo: ' || inuMotivo, cnuNVLTRC);
  
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
    
  END fnuObtSubCategoriaDeMotivo;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtenerMotivoDeSolicitud
    Descripcion     : Servicio para retornar el código el motivo con relación al código de la solicitud.
    Caso            : OSF-3541    
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuSolicitud        Codigo Solicitud
        
      Salida
        nuMotivo            Codigo motivo
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  FUNCTION fnuObtenerMotivoDeSolicitud(inuSolicitud NUMBER) RETURN NUMBER IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtenerMotivoDeSolicitud';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    CURSOR cuMotivo is
      select mm.motive_id
        from mo_motive mm
       where mm.package_id = inuSolicitud;
  
    --variables del codigo de SubCategoria
    nuMotivo NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, cnuNVLTRC);
  
    open cuMotivo;
    fetch cuMotivo
      into nuMotivo;
    close cuMotivo;
  
    pkg_traza.trace('Motivo: ' || nuMotivo, cnuNVLTRC);
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
  
    return(nuMotivo);
  
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
    
  END fnuObtenerMotivoDeSolicitud;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtProductoDeMotivo
    Descripcion     : Servicio para retornar el producto del motivo.
    Caso            : OSF-3541    
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuMotivo        Codigo Motivo
        
      Salida
        nuProducto       Codigo Producto
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  FUNCTION fnuObtProductoDeMotivo(inuMotivo NUMBER) RETURN NUMBER IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtProductoDeMotivo';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    CURSOR cuProducto is
      select mm.product_id
        from mo_motive mm
       where mm.motive_id = inuMotivo;
  
    --variables del codigo de SubCategoria
    nuProducto NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Motivo: ' || inuMotivo, cnuNVLTRC);
  
    open cuProducto;
    fetch cuProducto
      into nuProducto;
    close cuProducto;
  
    pkg_traza.trace('Producto: ' || nuProducto, cnuNVLTRC);
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
  
    return(nuProducto);
  
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
    
  END fnuObtProductoDeMotivo;   

END PKG_BCSOLICITUDES;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcsolicitudes
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCSOLICITUDES', 'ADM_PERSON');
END;
/

