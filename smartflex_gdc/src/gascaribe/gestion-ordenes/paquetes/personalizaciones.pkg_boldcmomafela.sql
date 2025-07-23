create or replace package personalizaciones.pkg_boldcmomafela AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 20-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2;

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : procesa la informacion para PB LDCMOMAFELA

    Autor           : Jhon Jairo Soto
    Fecha           : 20-02-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

PROCEDURE prcObjeto  (
					  isbOrdenes  			IN VARCHAR2,
					  isbObservacion    	IN or_log_order_action.error_message%TYPE,
					  idtFechaMaxLegActu 	IN DATE
					  ) ;
  
  END pkg_boldcmomafela;
/
create or replace package body personalizaciones.pkg_boldcmomafela is

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3889';
  
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 20-02-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;


  
PROCEDURE prcObjeto  (
					  isbOrdenes  			IN VARCHAR2,
					  isbObservacion    	IN or_log_order_action.error_message%TYPE,
					  idtFechaMaxLegActu 	IN DATE
					  ) IS

    /*******************************************************************************
     Propiedad intelectual de Gases del Caribe.

     Nombre         :  prcObjeto
     Descripcion    :  
     Autor          :  Jhon Soto
     Fecha          :  20/02/2025
     Parametros         Descripcion
     ============    ===================


     Historia de Modificaciones
     Fecha             Autor                 Modificacion
     =========       =========          ====================
   /*******************************************************************************/

		nuOrden        	   or_order.order_id%TYPE;
		dtFechaMaxLegAntes DATE;
		nuEstado           NUMBER(2);
		sbMensaje          VARCHAR2(4000);
		nuValida           NUMBER;
		nuContador         NUMBER(8);
		nuTipoTrabajo      or_task_type.task_type_id%TYPE;
		csbMT_NAME  	   VARCHAR2(200) := csbSP_NAME || 'prcObjeto';
		
		sbProceso          VARCHAR2(200):= 'LDCMOMAFELA'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
		rcOrden			   pkg_or_order.styor_order;
		
		sbTiposTrabajo	   VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TIP_TRAB_PERM_LEGA_FEC_MAX');
		sbValidaTT		   VARCHAR2(2);
		sbObservacion	   VARCHAR2(4000);
		nuError			   NUMBER;
		sbError			   VARCHAR2(4000);


	    CURSOR cuOrdenes(sbDatosParametros VARCHAR2)
	    IS
		SELECT (regexp_substr(sbDatosParametros,
							'[^,]+',
							1,
							LEVEL)
							) AS orden_actu
		  FROM dual
		CONNECT BY regexp_substr(sbDatosParametros,
							  '[^,]+',
							  1,
							  LEVEL
							  ) IS NOT NULL;
		
 
		CURSOR cuValidaTT(nuTipoTrabajo IN or_task_type.task_type_id%TYPE)
		IS
		SELECT 'X' 
		FROM dual 
		WHERE nuTipoTrabajo IN 
							(SELECT (regexp_substr(sbTiposTrabajo,
												'[^,]+',
												1,
												LEVEL)
												) AS orden_actu
							  FROM dual
							CONNECT BY regexp_substr(sbTiposTrabajo,
												  '[^,]+',
												  1,
												  LEVEL
												  ) IS NOT NULL
							);


   BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

	nuContador           := 0;
	
	 FOR i IN cuOrdenes(isbordenes) LOOP
	  nuValida := 0;
	  nuOrden := i.orden_actu;
	  
		BEGIN
			rcOrden:= pkg_or_order.frcObtRegistroRId(nuOrden);
			
			IF rcOrden.order_id IS NULL THEN
			 RAISE NO_DATA_FOUND;
			END IF;
				
			dtFechaMaxLegAntes 	:= rcOrden.max_date_to_legalize;
			nuTipoTrabajo   	:= rcOrden.task_type_id;
			nuEstado	 		:= rcOrden.order_status_id;
				
			OPEN cuValidaTT(nuTipoTrabajo);
			FETCH cuValidaTT INTO sbValidaTT;
				IF cuValidaTT%NOTFOUND THEN
					CLOSE cuValidaTT;
					RAISE NO_DATA_FOUND;
				END IF;
			CLOSE cuValidaTT;
					
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			nuValida := 1;
			IF sbMensaje IS NULL THEN
			 sbMensaje := 'Error al procesar la orden : '||to_char(nuOrden)||' no existe o su tipo de trabajo no esta configurado para modificarle la fecha maxima de legalizacion. '||SQLERRM;
			ELSE
			 sbMensaje := sbMensaje||' - Error al procesar la orden : '||to_char(nuOrden)||' no existe o su tipo de trabajo no esta configurado para modificarle la fecha maxima de legalizacion. '||SQLERRM;
			END IF;
		END;

		IF nuEstado <> 5 THEN
			nuValida := 1;
			sbMensaje := 'El estado de la Orden es diferente a Asignada.';
		END IF;

		IF idtFechaMaxLegActu < SYSDATE THEN
			nuValida := 1;
			sbMensaje := 'La nueva fecha no puede ser menor que la fecha del sistema';
		END IF;

		-- Actualizamos la maxima fecha de legalizacion
		IF nuValida = 0 THEN
		 
			pkg_or_order.pracmax_date_to_legalize(nuOrden, idtFechaMaxLegActu);
			nuContador := nuContador + 1;
			sbObservacion := isbObservacion;
			sbObservacion:= 'MAX_DATE_TO_LEGALIZE -'|| sbObservacion;
				
		   -- Guardamos informacion en el log
			pkg_ldc_log_camb_fecha_max_leg.prInsertarRegistro(nuOrden,nuTipoTrabajo,dtFechaMaxLegAntes,idtFechaMaxLegActu,sbObservacion);
		   
		  END IF;
  
	 END LOOP;

	 
	 IF sbMensaje IS NULL THEN
	  sbMensaje := 'Proceso terminó ok. Se procesaron : '||to_char(nuContador)||' registros exitosos.';
	 ELSE
	  sbMensaje := sbMensaje||' - Se procesaron : '||to_char(nuContador)||' registros exitosos.';
	 END IF;
	 
	 pkg_estaproc.prActualizaEstaproc(sbProceso, ' Ok.', sbMensaje);
	  
	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	  pkg_estaproc.prActualizaEstaproc(sbProceso, ' con Error', sbMensaje);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	  pkg_estaproc.prActualizaEstaproc(sbProceso, ' con Error', sbMensaje);
      RAISE pkg_Error.Controlled_Error;
END prcObjeto;

END pkg_boldcmomafela;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre personalizaciones.pkg_boldcmomafela
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOLDCMOMAFELA', 'PERSONALIZACIONES'); 
END;
/
