create or replace PROCEDURE    adm_person.api_anularorden( inuOrderId        IN NUMBER,
                                                           inuTipoComentario IN NUMBER,
                                                           isbComentario     IN VARCHAR2,
                                                           onuErrorCode      OUT NUMBER,
                                                           osbErrorMessage   OUT VARCHAR2) IS
  /*****************************************************************
      Procedimiento   :   api_anularorden
      Descripcion     :   Proceso que se encarga de llamar al api de anulacion de orden de open
    
      Parametros de Entrada
        InuOrderId            codigo de la Orden
        inuTipoComentario     Tipo de comentario
        isbComentario         Comentario de la anulacion
    
      Parametros de Salida
        OnuErrorCode          codigo de error
        OsbErrorMessage       mensaje de error
    
    
      Historia de Modificaciones
      Fecha       	Autor              Modificacion
      =========   	=========       ====================
	  21-09-2023	jerazomvm		OSF-1600:
									1. Se crea el cursor cuValiOrdenAnul en el 
									   procedimiento prValidaInfo, que valida
									   si el estado de la orden es anulable.
									2. En el procedimiento prValidaInfo, se crea la
									   validación si la orden se encuentra en un estado
									   anulable (12).
									3. Se agrega las columnas [task_type_id y description]
									   en el cursor cuValidaTitrAnul del procedimiento
									   prValidaInfo.
      13-09-2023  	LJLB            OSF-1586 Creacion
  ******************************************************************/
  
	PROCEDURE prValidaInfo IS
    
		sbDatos  			VARCHAR2(1);
		sbEstadoAnul		VARCHAR2(1);
		nuTaskTypeId		or_task_type.task_type_id%type;
		sbDescription		or_task_type.description%type;
		nuEstadoOrden		or_order.order_status_id%type;
		sbDescripEstaOrd	or_order_status.description%type;
    
		--valida tipo de trabajo sea anulable
		CURSOR cuValidaTitrAnul IS
		SELECT ott.task_type_id, 
			   description
		FROM or_order, or_task_type ott
		WHERE or_order.order_id   = inuOrderId
		AND or_order.task_type_id = ott.task_type_id
		AND is_anull 			  = 'N';
      
		--valida si la orden esta asociada a una solicitud abierta
		CURSOR cuValidaOrdeSoli IS
		SELECT 'X'
		FROM or_order_activity, mo_packages
		WHERE or_order_activity.order_id = inuOrderId
		AND or_order_activity.package_id =  mo_packages.package_id
		AND mo_packages.motive_status_id NOT IN (SELECT ps_motive_status.motive_status_id
												 FROM ps_motive_status
												 WHERE moti_status_type_id  = 2
												 AND is_final_status 		= 'Y'
												);
		
		-- Valida si el estado de la orden es anulable
		CURSOR cuValiOrdenAnul (inuEstadoInicial IN or_transition.initial_status_id%type) IS
		SELECT 'X' 
		FROM or_transition
		WHERE initial_status_id = inuEstadoInicial
		AND final_status_id 	= 12;
      
	BEGIN
	
		UT_TRACE.TRACE('Inicio API_ANULARORDEN.prValidaInfo', 15);
	
		IF cuValidaTitrAnul%ISOPEN THEN
			CLOSE cuValidaTitrAnul;
		END IF;
     
		OPEN cuValidaTitrAnul;
		FETCH cuValidaTitrAnul INTO nuTaskTypeId, sbDescription;
		CLOSE cuValidaTitrAnul;
     
		IF nuTaskTypeId IS NOT NULL THEN
			onuErrorCode 	:= -1;
			osbErrorMessage := 'El tipo de trabajo [' || nuTaskTypeId || ' - ' || sbDescription || '] de la orden [' || inuOrderId || '] no esta configurado como anulable.';
		ELSE
			sbDatos := NULL;
			
			IF cuValidaOrdeSoli%ISOPEN THEN
				CLOSE cuValidaOrdeSoli;
			END IF;
        
			OPEN cuValidaOrdeSoli;
			FETCH cuValidaOrdeSoli INTO sbDatos;
			CLOSE cuValidaOrdeSoli;
        
			IF sbDatos IS NOT NULL THEN
				onuErrorCode 	:= -1;
				osbErrorMessage := 'La Orden ['||inuOrderId||'] esta asociada a una solicitud abierta.';
			END IF;
		END IF;
		
		nuEstadoOrden := ldc_bcConsGenerales.fsbValorColumna('or_order', 'order_status_id', 'order_id', inuOrderId);
		
		IF cuValiOrdenAnul%ISOPEN THEN
			CLOSE cuValiOrdenAnul;
		END IF;
     
		OPEN cuValiOrdenAnul(nuEstadoOrden);
		FETCH cuValiOrdenAnul INTO sbEstadoAnul;
		CLOSE cuValiOrdenAnul;
		
		IF sbEstadoAnul is null THEN
			-- obtiene la descripcion del estado de la orden
			sbDescripEstaOrd := ldc_bcConsGenerales.fsbValorColumna('or_order_status', 'description', 'order_status_id', nuEstadoOrden);
			
			onuErrorCode 	:= -1;
			osbErrorMessage := 'El estado de la orden [' || inuOrderId || '] es [' || nuEstadoOrden || ' - ' || sbDescripEstaOrd || '] y no es anulable.';
			
		END IF;
		
		UT_TRACE.TRACE('Fin API_ANULARORDEN.prValidaInfo', 15);
		
	END prValidaInfo;
  
BEGIN

	UT_TRACE.TRACE('Inicio API_ANULARORDEN inuOrderId: ' 		|| inuOrderId 		 || CHR(10) ||
										  'inuTipoComentario: ' || inuTipoComentario || CHR(10) ||
										  'isbComentario: ' 	|| isbComentario, 10);
	
	PKG_ERROR.prInicializaError(onuErrorCode, osbErrorMessage);
	  
	prValidaInfo;
	  
	IF onuErrorCode <> 0 THEN
		pkg_error.setErrorMessage(isbMsgErrr => osbErrorMessage);
	END IF;
	  
	or_boanullorder.anullorderwithoutval(inuOrderId, sysdate);

	if InuTipoComentario is not null then
		API_ADDORDERCOMMENT(inuOrderId,
							inuTipoComentario,
							isbComentario,
							onuErrorCode,
							osbErrorMessage);
	end if;
	
	UT_TRACE.TRACE('Fin API_ANULARORDEN onuErrorCode: '    || onuErrorCode	|| CHR(10) ||
									   'osbErrorMessage: ' || osbErrorMessage, 10);

EXCEPTION
  WHEN OTHERS THEN
    PKG_ERROR.setError;
    PKG_ERROR.getError(onuErrorCode, osbErrorMessage);
    UT_TRACE.TRACE('Fin  OTHERS API_ANULARORDEN ['||osbErrorMessage||']', 10);
END;
/
PROMPT Otorgando permisos de ejecución a API_REGISTRANOTAYDETALLE
BEGIN
  pkg_utilidades.prAplicarPermisos('API_ANULARORDEN', 'ADM_PERSON'); 
END;
/