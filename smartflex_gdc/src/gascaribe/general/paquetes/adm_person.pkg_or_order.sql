CREATE OR REPLACE PACKAGE adm_person.pkg_or_order IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa 	: pkg_or_order
    Autor       : Carlos Gonzalez - Horbath
    Fecha       : 03-01-2024
    Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.OR_ORDER

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   03-01-2024  OSF-2155 Creacion
*******************************************************************************/

    CURSOR CURECORD 
    (
        INUORDER_ID IN OR_ORDER.ORDER_ID%TYPE
    )
    IS
        SELECT OR_ORDER.*,OR_ORDER.ROWID
        FROM OR_ORDER
        WHERE  ORDER_ID = INUORDER_ID;

    SUBTYPE STYOR_ORDER  IS  CURECORD%ROWTYPE;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prc_ActualizaCausalOrden
    Descripcion     : Actualizar la causal de una orden
    *******************************************************************************/    
    PROCEDURE prc_ActualizaCausalOrden
    (
        inuOrden    IN  or_order.order_id%type,
        inuCausal 	IN  or_order.causal_id%type,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    );

    PROCEDURE prcActualizaDireccionOrden
    (
        inuOrden    	IN  or_order.order_id%type,
        isbDireccion 	IN  or_order.external_address_id%type,
        onuError    	OUT NUMBER,
        osbError    	OUT VARCHAR2
    );
    
    --procedimiento que se encarga de actualizar sector operativo de la orden
    PROCEDURE prcActualizaSectorOperativo(inuOrden           IN or_order.order_id%type,
                                          inuSectorOperativo IN or_order.operating_sector_id%type,
                                          onuError           OUT NUMBER,
                                          osbError           OUT VARCHAR2
                                          );

    --procedimiento que se encarga de actualizar estado de la orden
    PROCEDURE prcActualizaEstado(inuOrden  IN or_order.order_id%type,
                                 inuEstado IN or_order.order_status_id%type,
                                 onuError  OUT NUMBER,
                                 osbError  OUT VARCHAR2
                                 );

    --pprocedimiento que se encarga de actualizar estado anterior de la orden
    PROCEDURE prcActualizaEstadoAnterior(inuOrden  IN or_order.order_id%type,
                                         inuEstado IN or_order.prev_order_status_id%type,
                                         onuError  OUT NUMBER,
                                         osbError  OUT VARCHAR2
                                         );

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prcActualizaRecord
    Descripcion     : Actualizar la orden con un record
    ***************************************************************************/
    PROCEDURE prcActualizaRecord(ircOrOrder IN  styOR_order);

    -- Actualiza una orden de novedad    
    PROCEDURE prActOrdenNovedad( inuOrder NUMBER, ircOrden or_order%ROWTYPE);
	
END pkg_or_order;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_order IS
	
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
    
    -- Identificador del ultimo caso que hizo cambios
    csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2632';

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Carlos Gonzalez - Horbath
    Fecha       	: 03-01-2024

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   03-01-2024  OSF-2155 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion 
    RETURN VARCHAR2 
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prc_ActualizaCausalOrden
    Descripcion     : Actualizar la causal de una orden

    Autor       	:   Carlos Gonzalez - Horbath
    Fecha       	:   03-01-2024

    Parametros de Entrada
      inuOrden        Identificador de la orden
      inuCausal       Identificador de la causal
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   03-01-2024  OSF-2155 Creacion
    ***************************************************************************/
    PROCEDURE prc_ActualizaCausalOrden
    (
        inuOrden    IN  or_order.order_id%type,
        inuCausal 	IN  or_order.causal_id%type,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    ) 
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prc_ActualizaCausalOrden';
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuCausal => ' || inuCausal, pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
        SET causal_id = inuCausal
        WHERE order_id = inuOrden;

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prc_ActualizaCausalOrden;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prc_ActualizaDireccionOrden
    Descripcion     : Actualizar la dirección de la orden

    Autor       	:   Luis Felipe Valencia Hurtado
    Fecha       	:   12-0-32024

    Parametros de Entrada
      inuOrden        	Identificador de la orden
      isbDireccion 		Identificador de la Direccion
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error

    Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creación
    ***************************************************************************/
    PROCEDURE prcActualizaDireccionOrden
    (
        inuOrden    	IN  or_order.order_id%type,
        isbDireccion 	IN  or_order.external_address_id%type,
        onuError    	OUT NUMBER,
        osbError    	OUT VARCHAR2
    ) 
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcActualizaDireccionOrden';
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('isbDireccion => ' || isbDireccion, pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);   
                
        UPDATE or_order SET external_address_id = isbDireccion WHERE order_id = inuOrden;
        
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaDireccionOrden;
    
    /**************************************************************************
    Autor       : Jorge Valiente
    Fecha       : 13/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaSectorOperativo
    Descripcion : procedimiento que se encarga de actualizar sector operativo de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaSectorOperativo(inuOrden           IN or_order.order_id%type,
                        inuSectorOperativo IN or_order.operating_sector_id%type,
                        onuError           OUT NUMBER,
                        osbError           OUT VARCHAR2
                        ) 
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaSectorOperativo';
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Sector Operativo: ' || inuSectorOperativo, pkg_traza.cnuNivelTrzDef);
        
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
        SET OPERATING_SECTOR_ID = inuSectorOperativo
        WHERE order_id = inuOrden;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaSectorOperativo;
    
    /**************************************************************************
    Autor       : Jorge Valiente / Horbath
    Fecha       : 26/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaEstado
    Descripcion : procedimiento que se encarga de actualizar sector operativo de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaEstado(inuOrden  IN or_order.order_id%type,
                  inuEstado IN or_order.order_status_id%type,
                  onuError  OUT NUMBER,
                  osbError  OUT VARCHAR2
                  ) 
    IS 
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaEstado';
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        pkg_traza.trace('Estado: ' || inuEstado, pkg_traza.cnuNivelTrzDef);
        
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
        SET order_status_id = inuEstado
        WHERE order_id = inuOrden;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaEstado;
    
    /**************************************************************************
    Autor       : Jorge Valiente / Horbath
    Fecha       : 26/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaEstadoAnterior
    Descripcion : pprocedimiento que se encarga de actualizar estado anterior de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaEstadoAnterior(inuOrden  IN or_order.order_id%type,
                      inuEstado IN or_order.prev_order_status_id%type,
                      onuError  OUT NUMBER,
                      osbError  OUT VARCHAR2
                      ) 
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaEstadoAnterior';
    
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Estado: ' || inuEstado, pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
            SET prev_order_status_id = inuEstado
        WHERE order_id = inuOrden;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaEstadoAnterior;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prcActualizaRecord
    Descripcion     : Actualizar la orden con un record

    Autor       	:   Jhon Eduar Erazo Guachavez
    Fecha       	:   24-04-2024

    Parametros de Entrada
    inuOrden        	Identificador de la orden
    isbDireccion 		Identificador de la Direccion
    Parametros de Salida

    Modificaciones  :
    Autor       	Fecha       Caso     	Descripcion
    jerazomvm  		24-04-2024  OSF-2556 	Creación
    ***************************************************************************/
    PROCEDURE prcActualizaRecord(ircOrOrder IN  styOR_order) 
    IS
    
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcActualizaRecord';
        
        nuError			NUMBER;  
        nuOrderId		or_order.order_id%type;	
        sbmensaje		VARCHAR2(1000);  
    
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF ircOrOrder.ROWID IS NOT NULL THEN
          UPDATE OR_ORDER
          SET	PRIOR_ORDER_ID 			= ircOrOrder.PRIOR_ORDER_ID,
            NUMERATOR_ID 			= ircOrOrder.NUMERATOR_ID,
            SEQUENCE 				= ircOrOrder.SEQUENCE,
            PRIORITY 				= ircOrOrder.PRIORITY,
            EXTERNAL_ADDRESS_ID		= ircOrOrder.EXTERNAL_ADDRESS_ID,
            CREATED_DATE 			= ircOrOrder.CREATED_DATE,
            EXEC_INITIAL_DATE 		= ircOrOrder.EXEC_INITIAL_DATE,
            EXECUTION_FINAL_DATE 	= ircOrOrder.EXECUTION_FINAL_DATE,
            EXEC_ESTIMATE_DATE 		= ircOrOrder.EXEC_ESTIMATE_DATE,
            ARRANGED_HOUR 			= ircOrOrder.ARRANGED_HOUR,
            LEGALIZATION_DATE 		= ircOrOrder.LEGALIZATION_DATE,
            REPROGRAM_LAST_DATE 	= ircOrOrder.REPROGRAM_LAST_DATE,
            ASSIGNED_DATE 			= ircOrOrder.ASSIGNED_DATE,
            ASSIGNED_WITH 			= ircOrOrder.ASSIGNED_WITH,
            MAX_DATE_TO_LEGALIZE 	= ircOrOrder.MAX_DATE_TO_LEGALIZE,
            ORDER_VALUE 			= ircOrOrder.ORDER_VALUE,
            PRINTING_TIME_NUMBER 	= ircOrOrder.PRINTING_TIME_NUMBER,
            LEGALIZE_TRY_TIMES 		= ircOrOrder.LEGALIZE_TRY_TIMES,
            OPERATING_UNIT_ID 		= ircOrOrder.OPERATING_UNIT_ID,
            ORDER_STATUS_ID			= ircOrOrder.ORDER_STATUS_ID,
            TASK_TYPE_ID 			= ircOrOrder.TASK_TYPE_ID,
            OPERATING_SECTOR_ID 	= ircOrOrder.OPERATING_SECTOR_ID,
            CAUSAL_ID 				= ircOrOrder.CAUSAL_ID,
            ADMINIST_DISTRIB_ID 	= ircOrOrder.ADMINIST_DISTRIB_ID,
            ORDER_CLASSIF_ID 		= ircOrOrder.ORDER_CLASSIF_ID,
            GEOGRAP_LOCATION_ID 	= ircOrOrder.GEOGRAP_LOCATION_ID,
            IS_COUNTERMAND 			= ircOrOrder.IS_COUNTERMAND,
            REAL_TASK_TYPE_ID 		= ircOrOrder.REAL_TASK_TYPE_ID,
            SAVED_DATA_VALUES 		= ircOrOrder.SAVED_DATA_VALUES,
            FOR_AUTOMATIC_LEGA 		= ircOrOrder.FOR_AUTOMATIC_LEGA,
            ORDER_COST_AVERAGE 		= ircOrOrder.ORDER_COST_AVERAGE,
            ORDER_COST_BY_LIST 		= ircOrOrder.ORDER_COST_BY_LIST,
            OPERATIVE_AIU_VALUE 	= ircOrOrder.OPERATIVE_AIU_VALUE,
            ADMIN_AIU_VALUE 		= ircOrOrder.ADMIN_AIU_VALUE,
            CHARGE_STATUS 			= ircOrOrder.CHARGE_STATUS,
            PREV_ORDER_STATUS_ID 	= ircOrOrder.PREV_ORDER_STATUS_ID,
            PROGRAMING_CLASS_ID 	= ircOrOrder.PROGRAMING_CLASS_ID,
            PREVIOUS_WORK 			= ircOrOrder.PREVIOUS_WORK,
            APPOINTMENT_CONFIRM 	= ircOrOrder.APPOINTMENT_CONFIRM,
            X 						= ircOrOrder.X,
            Y 						= ircOrOrder.Y,
            STAGE_ID 				= ircOrOrder.STAGE_ID,
            LEGAL_IN_PROJECT 		= ircOrOrder.LEGAL_IN_PROJECT,
            OFFERED 				= ircOrOrder.OFFERED,
            ASSO_UNIT_ID 			= ircOrOrder.ASSO_UNIT_ID,
            SUBSCRIBER_ID 			= ircOrOrder.SUBSCRIBER_ID,
            ADM_PENDING 			= ircOrOrder.ADM_PENDING,
            SHAPE 					= ircOrOrder.SHAPE,
            ROUTE_ID 				= ircOrOrder.ROUTE_ID,
            CONSECUTIVE 			= ircOrOrder.CONSECUTIVE,
            DEFINED_CONTRACT_ID 	= ircOrOrder.DEFINED_CONTRACT_ID,
            IS_PENDING_LIQ 			= ircOrOrder.IS_PENDING_LIQ,
            SCHED_ITINERARY_ID 		= ircOrOrder.SCHED_ITINERARY_ID,
            ESTIMATED_COST 			= ircOrOrder.ESTIMATED_COST
          WHERE ROWID = ircOrOrder.ROWID
          RETURNING ORDER_ID
          INTO nuOrderId;
        ELSE
          UPDATE OR_ORDER
          SET PRIOR_ORDER_ID 			= ircOrOrder.PRIOR_ORDER_ID,
            NUMERATOR_ID 			= ircOrOrder.NUMERATOR_ID,
            SEQUENCE 				= ircOrOrder.SEQUENCE,
            PRIORITY 				= ircOrOrder.PRIORITY,
            EXTERNAL_ADDRESS_ID 	= ircOrOrder.EXTERNAL_ADDRESS_ID,
            CREATED_DATE 			= ircOrOrder.CREATED_DATE,
            EXEC_INITIAL_DATE 		= ircOrOrder.EXEC_INITIAL_DATE,
            EXECUTION_FINAL_DATE	= ircOrOrder.EXECUTION_FINAL_DATE,
            EXEC_ESTIMATE_DATE 		= ircOrOrder.EXEC_ESTIMATE_DATE,
            ARRANGED_HOUR 			= ircOrOrder.ARRANGED_HOUR,
            LEGALIZATION_DATE 		= ircOrOrder.LEGALIZATION_DATE,
            REPROGRAM_LAST_DATE 	= ircOrOrder.REPROGRAM_LAST_DATE,
            ASSIGNED_DATE 			= ircOrOrder.ASSIGNED_DATE,
            ASSIGNED_WITH 			= ircOrOrder.ASSIGNED_WITH,
            MAX_DATE_TO_LEGALIZE 	= ircOrOrder.MAX_DATE_TO_LEGALIZE,
            ORDER_VALUE 			= ircOrOrder.ORDER_VALUE,
            PRINTING_TIME_NUMBER 	= ircOrOrder.PRINTING_TIME_NUMBER,
            LEGALIZE_TRY_TIMES 		= ircOrOrder.LEGALIZE_TRY_TIMES,
            OPERATING_UNIT_ID 		= ircOrOrder.OPERATING_UNIT_ID,
            ORDER_STATUS_ID 		= ircOrOrder.ORDER_STATUS_ID,
            TASK_TYPE_ID 			= ircOrOrder.TASK_TYPE_ID,
            OPERATING_SECTOR_ID 	= ircOrOrder.OPERATING_SECTOR_ID,
            CAUSAL_ID 				= ircOrOrder.CAUSAL_ID,
            ADMINIST_DISTRIB_ID 	= ircOrOrder.ADMINIST_DISTRIB_ID,
            ORDER_CLASSIF_ID 		= ircOrOrder.ORDER_CLASSIF_ID,
            GEOGRAP_LOCATION_ID 	= ircOrOrder.GEOGRAP_LOCATION_ID,
            IS_COUNTERMAND 			= ircOrOrder.IS_COUNTERMAND,
            REAL_TASK_TYPE_ID 		= ircOrOrder.REAL_TASK_TYPE_ID,
            SAVED_DATA_VALUES 		= ircOrOrder.SAVED_DATA_VALUES,
            FOR_AUTOMATIC_LEGA 		= ircOrOrder.FOR_AUTOMATIC_LEGA,
            ORDER_COST_AVERAGE 		= ircOrOrder.ORDER_COST_AVERAGE,
            ORDER_COST_BY_LIST 		= ircOrOrder.ORDER_COST_BY_LIST,
            OPERATIVE_AIU_VALUE 	= ircOrOrder.OPERATIVE_AIU_VALUE,
            ADMIN_AIU_VALUE 		= ircOrOrder.ADMIN_AIU_VALUE,
            CHARGE_STATUS 			= ircOrOrder.CHARGE_STATUS,
            PREV_ORDER_STATUS_ID 	= ircOrOrder.PREV_ORDER_STATUS_ID,
            PROGRAMING_CLASS_ID 	= ircOrOrder.PROGRAMING_CLASS_ID,
            PREVIOUS_WORK 			= ircOrOrder.PREVIOUS_WORK,
            APPOINTMENT_CONFIRM 	= ircOrOrder.APPOINTMENT_CONFIRM,
            X 						= ircOrOrder.X,
            Y 						= ircOrOrder.Y,
            STAGE_ID 				= ircOrOrder.STAGE_ID,
            LEGAL_IN_PROJECT 		= ircOrOrder.LEGAL_IN_PROJECT,
            OFFERED 				= ircOrOrder.OFFERED,
            ASSO_UNIT_ID 			= ircOrOrder.ASSO_UNIT_ID,
            SUBSCRIBER_ID 			= ircOrOrder.SUBSCRIBER_ID,
            ADM_PENDING 			= ircOrOrder.ADM_PENDING,
            SHAPE 					= ircOrOrder.SHAPE,
            ROUTE_ID 				= ircOrOrder.ROUTE_ID,
            CONSECUTIVE 			= ircOrOrder.CONSECUTIVE,
            DEFINED_CONTRACT_ID 	= ircOrOrder.DEFINED_CONTRACT_ID,
            IS_PENDING_LIQ 			= ircOrOrder.IS_PENDING_LIQ,
            SCHED_ITINERARY_ID 		= ircOrOrder.SCHED_ITINERARY_ID,
            ESTIMATED_COST 			= ircOrOrder.ESTIMATED_COST
          WHERE ORDER_ID = ircOrOrder.ORDER_ID
          RETURNING ORDER_ID
          INTO nuOrderId;
        END IF;
        
        IF nuOrderId IS NULL THEN
          RAISE NO_DATA_FOUND;
        END IF;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Pkg_Error.SetErrorMessage(1,' El registro Ordenes De Trabajo ['|| ircOrOrder.ORDER_ID ||'] no existe, o no está autorizado para acceder los datos.');
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
    END prcActualizaRecord;

    /***************************************************************************
    Programa        : prActOrdenNovedad
    Descripcion     : Actualiza la orden de novedad
    Autor       	:   Lubin Pineda
    Fecha       	:   15-07-2024

    Parametros de Entrada
    inuOrden        	Identificador de la orden
    ircOrden 		    Registro con la información a actualizar
    Parametros de Salida

    Modificaciones  :
    Autor       	Fecha       Caso     	Descripcion
    jpinedc  		15-07-2024  OSF-2204 	Creación
    ***************************************************************************/        
    PROCEDURE prActOrdenNovedad( inuOrder NUMBER, ircOrden or_order%ROWTYPE)
    IS    
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActOrdenNovedad';
        
        nuError			    NUMBER;  
        sbmensaje		    VARCHAR2(1000);  

    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                        
        UPDATE OR_ORDER
        SET defined_contract_id     = ircOrden.defined_contract_id,
            legalization_date       = ircOrden.legalization_date,
            exec_initial_date       = ircOrden.exec_initial_date,
            execution_final_date    = ircOrden.execution_final_date,
            exec_estimate_date      = ircOrden.exec_estimate_date,
            is_pending_liq          = NULL            
        WHERE 
            order_id = inuOrder;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
    END prActOrdenNovedad;

END pkg_or_order;
/

BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_OR_ORDER', 'ADM_PERSON');
END;
/

