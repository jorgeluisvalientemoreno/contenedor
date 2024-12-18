CREATE OR REPLACE PACKAGE adm_person.pkg_bcordenes IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcordenes
    Autor       :   Carlos Gonzalez - Horbath
    Fecha       :   02-08-2023
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
                    tablas OPEN.OR_ORDER, OPEN.ORDER_ACTIVITY y OPEN.GE_CAUSAL
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    jsoto       20/09/2023  OSF-1603 Se agregan funciones fnuObtenerOTInstanciaLegal, fblObtenerEsNovedad, fnuObtenerPersona

    epenao      10/10/2023  OSF-1734 + Creación de la función fnuObtieneOrdenDeActividad
                                     la cual recibe el id de una actividad y retorna el 
                                     código de la orden para esta actividad. 

                                     + Ajuste del uso de traza para que se cambie el uso de 
                                     ut_trace por el paquete personalizado pkg_traza. 
                                     
                                     + Cambio del nivel de la traza usando una constante local 
                                     por el llamado a la constante de nivel de traza en el paquete pkg_traza. 

                                     + Cambio de los mensajes de inicio y final de método usando 
                                     el envío de mensaje con las constantes definidas en cada caso en el 
                                     paquete pkg_traza. 
                   
  jsoto         10/11/2023  OSF-1911 Se cambia cursor para obtener el max id de actividad
  fvalencia     24/05/2024  OSF-2747: Se actualiza versión el paquete para desbloquear requerimientos         
  Adrianavg     05/06/2024  OSF-2772: Se adiciona método fnuobtienedireccion    
  Dsaltarin     27/11/2024  OSF-3679: Se corrige método fnuobtienedireccion    
  jeerazomvm	09/12/2024	OSF-3725: Se crea la función fsbObtValorDatoAdicional
*******************************************************************************/

    CURSOR cuRecord(inuOrden IN or_order.order_id%TYPE) IS
      SELECT or_order.*, or_order.rowid
        FROM or_order
       WHERE order_id = inuOrden;

    SUBTYPE styOrden  IS cuRecord%ROWTYPE;
    	   
    TYPE tytbOrden IS TABLE OF styOrden INDEX BY BINARY_INTEGER;

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    -- Retorna la causal de la orden
    FUNCTION fnuObtieneCausal
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.causal_id%TYPE;

    -- Retorna la unidad operativa de la orden
    FUNCTION fnuObtieneUnidadOperativa
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.operating_unit_id%TYPE;

    -- Retorna el tipo de trabajo de la orden
    FUNCTION fnuObtieneTipoTrabajo
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.task_type_id%TYPE;

    -- Retorna el estado de la orden
    FUNCTION fnuObtieneEstado
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.order_status_id%TYPE;

    -- Retorna la fecha de creacion de la orden
    FUNCTION fdtObtieneFechaCreacion
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.created_date%TYPE;

    -- Retorna la fecha de asignacion de la orden
    FUNCTION fdtObtieneFechaAsigna
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.assigned_date%TYPE;

    -- Retorna la fecha de legalizacion de la orden
    FUNCTION fdtObtieneFechaLegaliza
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.legalization_date%TYPE;

    -- Retorna la fecha de ejecucion inicial de la orden
    FUNCTION fdtObtieneFechaEjecuIni
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.exec_initial_date%TYPE;

    -- Retorna la fecha de ejecucion final de la orden
    FUNCTION fdtObtieneFechaEjecuFin
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.execution_final_date%TYPE;

    -- Retorna el contrato de contratista asociado a la orden
    FUNCTION fnuObtieneContratoContratista
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.defined_contract_id%TYPE;

    -- Retorna el sector operativo de la orden
    FUNCTION fnuObtieneSectorOperativo
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.operating_sector_id%TYPE;

    -- Retorna la localidad de la orden
    FUNCTION fnuObtieneLocalidad
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.geograp_location_id%TYPE;

    -- Retorna si la orden esta pendiente de liquidar
    FUNCTION fsbObtienePendLiquidar
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.is_pending_liq%TYPE;

    -- Retorna la clase causal de la causal
    FUNCTION fnuObtieneClaseCausal
    (
        inuCausal     IN     ge_causal.causal_id%TYPE
    )
    RETURN ge_causal.class_causal_id%TYPE;

    -- Retorna la solicitud asociada a la orden
    FUNCTION fnuObtieneSolicitud
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.package_id%TYPE;

    -- Retorna el producto asociado a la orden
    FUNCTION fnuObtieneProducto
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.product_id%TYPE;

    -- Retorna el contrato asociado a la orden
    FUNCTION fnuObtieneContrato
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.subscription_id%TYPE;

    -- Retorna el id de la ultima actividad de la orden
    FUNCTION fnuObtieneUltActividad
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.order_activity_id%TYPE;
    
    -- Retorna el item de una actividad
    FUNCTION fnuObtieneItemActividad
    (
        inuActividadOrden     IN     or_order_activity.order_activity_id%TYPE
    )
    RETURN or_order_activity.activity_id%TYPE;
    
    -- Retorna el comentario de legalizacion de la orden
    FUNCTION fsbObtieneComenLega
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_comment.order_comment%TYPE;
    
    -- Retorna el tipo de comentario del comentario de legalizacion de la orden
    FUNCTION fnuObtieneTipoComenLega
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_comment.comment_type_id%TYPE;

   -- Retorna el Id de la orden que se encuentre gestionando el usuario en els sistema
    FUNCTION fnuObtenerOTInstanciaLegal
     RETURN or_order.order_id%TYPE;

   -- Retorna si la orden corresponde a una novedad
    FUNCTION fblObtenerEsNovedad
    (
         inuOrden or_order.order_id%TYPE
    )
     RETURN VARCHAR2;

   -- Retorna Id de la persona relacionada en la orden de trabajo
    FUNCTION fnuObtenerPersona
    (
         inuOrden or_order.order_id%TYPE
    )
     RETURN ge_person.person_id%TYPE;


    -- Retorna id de orden para la actividad enviada. 
    FUNCTION fnuObtieneOrdenDeActividad 
    (
       inuActividadOrden   in   or_order_activity.order_activity_id%TYPE 
    )
    RETURN or_order.order_id%TYPE;     

    --retorna el registro de la unidad operativa
    FUNCTION frcgetRecord(inuOrden IN or_order.order_id%TYPE)
      RETURN styOrden;

    --Retorna identificador de la direccion externa de la orden de trabajo
    FUNCTION  fnuObtieneDireccion
        (
            inuOrden     IN     or_order.order_id%TYPE
        )
        RETURN or_order.external_address_id%TYPE;
		
	-- Retorna el valor adicional de la orden, grupo de atributos y variable
    FUNCTION fsbObtValorDatoAdicional(inuOrden			IN or_order.order_id%TYPE,
									  inuGrupoAtributo	IN ge_attributes_set.attribute_set_id%TYPE,
									  isbNombreAtributo	IN ge_attributes.name_attribute%TYPE
									  )
    RETURN or_requ_data_value.value_1%TYPE;
        
END pkg_bcordenes;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcordenes IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-3725';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    Dsaltarin   07-11-2024  OSF-3679: Se corrige método fnuobtienedireccion        
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneCausal 
    Descripcion     : Retorna la causal de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneCausal
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.causal_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneCausal';
        
        CURSOR cuCausal(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  causal_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuCausal    or_order.causal_id%TYPE;
        
        PROCEDURE CierraCursorCausal
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorCausal';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuCausal%ISOPEN) THEN
                CLOSE cuCausal;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorCausal;
        
    BEGIN
    
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorCausal;
    
        OPEN cuCausal(inuOrden);
        FETCH cuCausal INTO nuCausal;
        CLOSE cuCausal;

        pkg_traza.trace('nuCausal: ' || nuCausal, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuCausal;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorCausal;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuCausal;
    END fnuObtieneCausal;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneUnidadOperativa 
    Descripcion     : Retorna la unidad operativa de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneUnidadOperativa
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.operating_unit_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneUnidadOperativa';
        
        CURSOR cuUnidadOperativa(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  operating_unit_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuUnidadOperativa    or_order.operating_unit_id%TYPE;
        
        PROCEDURE CierraCursorUnidadOper
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorUnidadOper';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuUnidadOperativa%ISOPEN) THEN
                CLOSE cuUnidadOperativa;
            END IF;        

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorUnidadOper;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorUnidadOper;
    
        OPEN cuUnidadOperativa(inuOrden);
        FETCH cuUnidadOperativa INTO nuUnidadOperativa;
        CLOSE cuUnidadOperativa;

        pkg_traza.trace('nuUnidadOperativa: ' || nuUnidadOperativa, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuUnidadOperativa;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorUnidadOper;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuUnidadOperativa;
    END fnuObtieneUnidadOperativa;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneTipoTrabajo
    Descripcion     : Retorna el tipo de trabajo de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneTipoTrabajo
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.task_type_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneTipoTrabajo';
        
        CURSOR cuTipoTrabajo(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  task_type_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuTipoTrabajo    or_order.task_type_id%TYPE;
        
        PROCEDURE CierraCursorTipoTrabajo
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorTipoTrabajo';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuTipoTrabajo%ISOPEN) THEN
                CLOSE cuTipoTrabajo;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorTipoTrabajo;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorTipoTrabajo;
    
        OPEN cuTipoTrabajo(inuOrden);
        FETCH cuTipoTrabajo INTO nuTipoTrabajo;
        CLOSE cuTipoTrabajo;

        pkg_traza.trace('nuTipoTrabajo: ' || nuTipoTrabajo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuTipoTrabajo;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorTipoTrabajo;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);            
            RETURN nuTipoTrabajo;
    END fnuObtieneTipoTrabajo;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneEstado
    Descripcion     : Retorna el estado de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneEstado
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.order_status_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneEstado';
        
        CURSOR cuEstado(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  order_status_id
            FROM    or_order
            WHERE   order_id = inuOrden;
        
        nuEstado    or_order.order_status_id%TYPE;
        
        PROCEDURE CierraCursorEstado
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorEstado';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuEstado%ISOPEN) THEN
                CLOSE cuEstado;
            END IF;

            pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorEstado;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorEstado;
    
        OPEN cuEstado(inuOrden);
        FETCH cuEstado INTO nuEstado;
        CLOSE cuEstado;
        
        pkg_traza.trace('nuEstado: ' || nuEstado, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuEstado;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorEstado;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuEstado;
    END fnuObtieneEstado;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtObtieneFechaCreacion
    Descripcion     : Retorna la fecha de creacion de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fdtObtieneFechaCreacion
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.created_date%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtObtieneFechaCreacion';
        
        CURSOR cuFechaCreacion(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  created_date
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        dtFechaCreacion    or_order.created_date%TYPE;
        
        PROCEDURE CierraCursorFechaCrea
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorFechaCrea';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuFechaCreacion%ISOPEN) THEN
                CLOSE cuFechaCreacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorFechaCrea;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorFechaCrea;
    
        OPEN cuFechaCreacion(inuOrden);
        FETCH cuFechaCreacion INTO dtFechaCreacion;
        CLOSE cuFechaCreacion;
        
        pkg_traza.trace('dtFechaCreacion: ' || dtFechaCreacion, pkg_traza.cnuNivelTrzDef);        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN dtFechaCreacion;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorFechaCrea;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN dtFechaCreacion;
    END fdtObtieneFechaCreacion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtObtieneFechaAsigna
    Descripcion     : Retorna la fecha de asignacion de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fdtObtieneFechaAsigna
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.assigned_date%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtObtieneFechaAsigna';
        
        CURSOR cuFechaAsignacion(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  assigned_date
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        dtFechaAsignacion    or_order.assigned_date%TYPE;
        
        PROCEDURE CierraCursorFechaAsig
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorFechaAsig';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuFechaAsignacion%ISOPEN) THEN
                CLOSE cuFechaAsignacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorFechaAsig;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorFechaAsig;
    
        OPEN cuFechaAsignacion(inuOrden);
        FETCH cuFechaAsignacion INTO dtFechaAsignacion;
        CLOSE cuFechaAsignacion;
        
        pkg_traza.trace('dtFechaAsignacion: ' || dtFechaAsignacion, pkg_traza.cnuNivelTrzDef);        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN dtFechaAsignacion;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorFechaAsig;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN dtFechaAsignacion;
    END fdtObtieneFechaAsigna;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtObtieneFechaLegaliza
    Descripcion     : Retorna la fecha de legalizacion de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fdtObtieneFechaLegaliza
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.legalization_date%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtObtieneFechaLegaliza';
        
        CURSOR cuFechaLegalizacion(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  legalization_date
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        dtFechaLegaliza    or_order.legalization_date%TYPE;
        
        PROCEDURE CierraCursorFechaLega
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorFechaLega';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuFechaLegalizacion%ISOPEN) THEN
                CLOSE cuFechaLegalizacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorFechaLega;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorFechaLega;
    
        OPEN cuFechaLegalizacion(inuOrden);
        FETCH cuFechaLegalizacion INTO dtFechaLegaliza;
        CLOSE cuFechaLegalizacion;
        
        pkg_traza.trace('dtFechaLegaliza: ' || dtFechaLegaliza, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN dtFechaLegaliza;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorFechaLega;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN dtFechaLegaliza;
    END fdtObtieneFechaLegaliza;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtObtieneFechaEjecuIni
    Descripcion     : Retorna la fecha de ejecucion inicial de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fdtObtieneFechaEjecuIni
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.exec_initial_date%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtObtieneFechaEjecuIni';
        
        CURSOR cuFechaEjecuIni(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  exec_initial_date
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        dtFechaEjecuIni    or_order.exec_initial_date%TYPE;
        
        PROCEDURE CierraCursorFechaEjecuIni
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorFechaEjecuIni';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuFechaEjecuIni%ISOPEN) THEN
                CLOSE cuFechaEjecuIni;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorFechaEjecuIni;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorFechaEjecuIni;
    
        OPEN cuFechaEjecuIni(inuOrden);
        FETCH cuFechaEjecuIni INTO dtFechaEjecuIni;
        CLOSE cuFechaEjecuIni;

        pkg_traza.trace('dtFechaEjecuIni: ' || dtFechaEjecuIni, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN dtFechaEjecuIni;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorFechaEjecuIni;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN dtFechaEjecuIni;
    END fdtObtieneFechaEjecuIni;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtObtieneFechaEjecuFin
    Descripcion     : Retorna la fecha de ejecucion final de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fdtObtieneFechaEjecuFin
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.execution_final_date%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fdtObtieneFechaEjecuFin';
        
        CURSOR cuFechaEjecuFin(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  execution_final_date
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        dtFechaEjecuFin    or_order.execution_final_date%TYPE;
        
        PROCEDURE CierraCursorFechaEjecuFin
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorFechaEjecuFin';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuFechaEjecuFin%ISOPEN) THEN
                CLOSE cuFechaEjecuFin;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorFechaEjecuFin;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorFechaEjecuFin;
    
        OPEN cuFechaEjecuFin(inuOrden);
        FETCH cuFechaEjecuFin INTO dtFechaEjecuFin;
        CLOSE cuFechaEjecuFin;

        pkg_traza.trace('dtFechaEjecuFin: ' || dtFechaEjecuFin, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN dtFechaEjecuFin;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorFechaEjecuFin;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN dtFechaEjecuFin;
    END fdtObtieneFechaEjecuFin;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneContratoContratista
    Descripcion     : Retorna el contrato de contratista asociado a la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneContratoContratista
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.defined_contract_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneContratoContratista';
        
        CURSOR cuContratoContra(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  defined_contract_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuContrato    or_order.defined_contract_id%TYPE;
        
        PROCEDURE CierraCursorContra
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorContra';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuContratoContra%ISOPEN) THEN
                CLOSE cuContratoContra;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorContra;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorContra;
    
        OPEN cuContratoContra(inuOrden);
        FETCH cuContratoContra INTO nuContrato;
        CLOSE cuContratoContra;

        pkg_traza.trace('nuContrato: ' || nuContrato, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuContrato;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorContra;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuContrato;
    END fnuObtieneContratoContratista;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneSectorOperativo
    Descripcion     : Retorna el sector operativo de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneSectorOperativo
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.operating_sector_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneSectorOperativo';
        
        CURSOR cuSectorOperativo(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  operating_sector_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuSectorOperativo    or_order.operating_sector_id%TYPE;
        
        PROCEDURE CierraCursorSectorOper
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorSectorOper';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuSectorOperativo%ISOPEN) THEN
                CLOSE cuSectorOperativo;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorSectorOper;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorSectorOper;
    
        OPEN cuSectorOperativo(inuOrden);
        FETCH cuSectorOperativo INTO nuSectorOperativo;
        CLOSE cuSectorOperativo;

        pkg_traza.trace('nuSectorOperativo: ' || nuSectorOperativo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuSectorOperativo;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorSectorOper;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuSectorOperativo;
    END fnuObtieneSectorOperativo;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneLocalidad
    Descripcion     : Retorna la localidad de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneLocalidad
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.geograp_location_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneLocalidad';
        
        CURSOR cuLocalidad(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  geograp_location_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuLocalidad    or_order.geograp_location_id%TYPE;
        
        PROCEDURE CierraCursorLocalidad
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorLocalidad';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuLocalidad%ISOPEN) THEN
                CLOSE cuLocalidad;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorLocalidad;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorLocalidad;
    
        OPEN cuLocalidad(inuOrden);
        FETCH cuLocalidad INTO nuLocalidad;
        CLOSE cuLocalidad;

        pkg_traza.trace('nuLocalidad: ' || nuLocalidad, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuLocalidad;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorLocalidad;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuLocalidad;
    END fnuObtieneLocalidad;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneLocalidad
    Descripcion     : Retorna si la orden esta pendiente de liquidar
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fsbObtienePendLiquidar
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.is_pending_liq%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbObtienePendLiquidar';
        
        CURSOR cuPendienteLiq(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  is_pending_liq
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        sbPendienteLiq    or_order.is_pending_liq%TYPE;
        
        PROCEDURE CierraCursorPendienteLiq
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorPendienteLiq';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuPendienteLiq%ISOPEN) THEN
                CLOSE cuPendienteLiq;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorPendienteLiq;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorPendienteLiq;
    
        OPEN cuPendienteLiq(inuOrden);
        FETCH cuPendienteLiq INTO sbPendienteLiq;
        CLOSE cuPendienteLiq;

        pkg_traza.trace('sbPendienteLiq: ' || sbPendienteLiq, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN sbPendienteLiq;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorPendienteLiq;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN sbPendienteLiq;
    END fsbObtienePendLiquidar;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneClaseCausal
    Descripcion     : Retorna la clase causal de la causal
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneClaseCausal
    (
        inuCausal     IN     ge_causal.causal_id%TYPE
    )
    RETURN ge_causal.class_causal_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneClaseCausal';
        
        CURSOR cuClaseCausal(inuCausal IN ge_causal.causal_id%TYPE) IS
            SELECT  class_causal_id
            FROM     ge_causal
            WHERE     causal_id = inuCausal;
        
        nuClaseCausal    ge_causal.class_causal_id%TYPE;
        
        PROCEDURE CierraCursorClaseCausal
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorClaseCausal';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuClaseCausal%ISOPEN) THEN
                CLOSE cuClaseCausal;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorClaseCausal;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuCausal: ' || inuCausal, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorClaseCausal;
    
        OPEN cuClaseCausal(inuCausal);
        FETCH cuClaseCausal INTO nuClaseCausal;
        CLOSE cuClaseCausal;

        pkg_traza.trace('nuClaseCausal: ' || nuClaseCausal, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuClaseCausal;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorClaseCausal;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuClaseCausal;
    END fnuObtieneClaseCausal;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneSolicitud
    Descripcion     : Retorna la solicitud asociada a la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneSolicitud
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.package_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneSolicitud';
        
        CURSOR cuSolicitud(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  package_id
            FROM     or_order_activity
            WHERE     order_id = inuOrden
            AND     package_id IS NOT NULL;
        
        nuSolicitud    or_order_activity.package_id%TYPE;
        
        PROCEDURE CierraCursorSolicitud
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorSolicitud';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuSolicitud%ISOPEN) THEN
                CLOSE cuSolicitud;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorSolicitud;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorSolicitud;
    
        OPEN cuSolicitud(inuOrden);
        FETCH cuSolicitud INTO nuSolicitud;
        CLOSE cuSolicitud;

        pkg_traza.trace('nuSolicitud: ' || nuSolicitud, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuSolicitud;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorSolicitud;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuSolicitud;
    END fnuObtieneSolicitud;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneSolicitud
    Descripcion     : Retorna la solicitud asociada a la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneProducto
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.product_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneProducto';
        
        CURSOR cuProducto(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  product_id
            FROM     or_order_activity
            WHERE     order_id = inuOrden
            AND     product_id IS NOT NULL;
        
        nuProducto    or_order_activity.product_id%TYPE;
        
        PROCEDURE CierraCursorProducto
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorProducto';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuProducto%ISOPEN) THEN
                CLOSE cuProducto;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorProducto;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorProducto;
    
        OPEN cuProducto(inuOrden);
        FETCH cuProducto INTO nuProducto;
        CLOSE cuProducto;

        pkg_traza.trace('nuProducto: ' || nuProducto, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuProducto;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorProducto;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuProducto;
    END fnuObtieneProducto;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneContrato
    Descripcion     : Retorna el contrato asociado a la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneContrato
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.subscription_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneContrato';
        
        CURSOR cuContrato(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  subscription_id
            FROM     or_order_activity
            WHERE     order_id = inuOrden
            AND     subscription_id IS NOT NULL;
        
        nuContrato    or_order_activity.subscription_id%TYPE;
        
        PROCEDURE CierraCursorContrato
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorContrato';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuContrato%ISOPEN) THEN
                CLOSE cuContrato;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorContrato;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorContrato;
    
        OPEN cuContrato(inuOrden);
        FETCH cuContrato INTO nuContrato;
        CLOSE cuContrato;

        pkg_traza.trace('nuContrato: ' || nuContrato, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuContrato;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorContrato;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuContrato;
    END fnuObtieneContrato;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneUltActividad
    Descripcion     : Retorna el id de la ultima actividad de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
  jsoto   10/11/2023  OSF-1911 Se cambia consulta del cursor cuUltActividad
              para obtener el ultimo id de actividad.
    ***************************************************************************/
    FUNCTION fnuObtieneUltActividad
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_activity.order_activity_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneUltActividad';
        
    CURSOR cuUltActividad(inuOrden IN or_order.order_id%TYPE) IS
            SELECT    order_activity_id
            FROM      (SELECT    order_activity_id
                        FROM    or_order_activity
                        WHERE     order_id = inuOrden
                        ORDER BY register_date DESC NULLS LAST, ORDER_ACTIVITY_ID DESC)
            WHERE ROWNUM = 1;
            

        nuUltActividad    or_order_activity.order_activity_id%TYPE;
        
        PROCEDURE CierraCursorUltActividad
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorUltActividad';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuUltActividad%ISOPEN) THEN
                CLOSE cuUltActividad;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorUltActividad;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorUltActividad;
    
        OPEN cuUltActividad(inuOrden);
        FETCH cuUltActividad INTO nuUltActividad;
        CLOSE cuUltActividad;

        pkg_traza.trace('nuUltActividad: ' || nuUltActividad, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuUltActividad;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorUltActividad;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuUltActividad;
    END fnuObtieneUltActividad;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneItemActividad
    Descripcion     : Retorna el item de una actividad
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneItemActividad
    (
        inuActividadOrden     IN     or_order_activity.order_activity_id%TYPE
    )
    RETURN or_order_activity.activity_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneItemActividad';
        
        CURSOR cuActividad(inuActividadOrden IN or_order_activity.order_activity_id%TYPE) IS
            SELECT  activity_id
            FROM     or_order_activity
            WHERE     order_activity_id = inuActividadOrden;
        
        nuActividad    or_order_activity.activity_id%TYPE;
        
        PROCEDURE CierraCursorActividad
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorActividad';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuActividad%ISOPEN) THEN
                CLOSE cuActividad;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorActividad;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuActividadOrden: ' || inuActividadOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorActividad;
    
        OPEN cuActividad(inuActividadOrden);
        FETCH cuActividad INTO nuActividad;
        CLOSE cuActividad;

        pkg_traza.trace('nuActividad: ' || nuActividad, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuActividad;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorActividad;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuActividad;
    END fnuObtieneItemActividad;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtieneComenLega
    Descripcion     : Retorna el comentario de legalizacion de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fsbObtieneComenLega
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_comment.order_comment%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneItemActividad';
        
        CURSOR cuComentaLega(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  order_comment
            FROM     or_order_comment
            WHERE     order_id = inuOrden
            AND     legalize_comment = 'Y';
        
        sbComentLega    or_order_comment.order_comment%TYPE;
        
        PROCEDURE CierraCursorComenLega
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorComenLega';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuComentaLega%ISOPEN) THEN
                CLOSE cuComentaLega;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorComenLega;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorComenLega;
    
        OPEN cuComentaLega(inuOrden);
        FETCH cuComentaLega INTO sbComentLega;
        CLOSE cuComentaLega;

        pkg_traza.trace('sbComentLega: ' || sbComentLega, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN sbComentLega;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorComenLega;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN sbComentLega;
    END fsbObtieneComenLega;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneTipoComenLega
    Descripcion     : Retorna el tipo de comentario del comentario de legalizacion de la orden
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 02-08-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   02-08-2023  OSF-1236 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneTipoComenLega
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order_comment.comment_type_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneTipoComenLega';
        
        CURSOR cuTipoComentaLega(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  comment_type_id
            FROM     or_order_comment
            WHERE     order_id = inuOrden
            AND     legalize_comment = 'Y';
        
        nuTipoComentLega    or_order_comment.comment_type_id%TYPE;
        
        PROCEDURE CierraCursorTipoComenLega
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorTipoComenLega';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuTipoComentaLega%ISOPEN) THEN
                CLOSE cuTipoComentaLega;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorTipoComenLega;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorTipoComenLega;
    
        OPEN cuTipoComentaLega(inuOrden);
        FETCH cuTipoComentaLega INTO nuTipoComentLega;
        CLOSE cuTipoComentaLega;

        pkg_traza.trace('nuTipoComentLega: ' || nuTipoComentLega, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuTipoComentLega;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorTipoComenLega;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuTipoComentLega;
    END fnuObtieneTipoComenLega;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtenerOTInstanciaLegal
    Descripcion     : Retorna el id de la orden que se esta gestionando en el sistema
    Autor           : Jhon Soto - Horbath
    Fecha           : 20-09-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   20-09-2023  OSF-1603 Creacion
    ***************************************************************************/
    FUNCTION fnuObtenerOTInstanciaLegal
     RETURN or_order.order_id%TYPE IS

     -- Nombre de este método
     csbMT_NAME  VARCHAR2(105) := csbSP_NAME||'.fnuObtenerOTInstanciaLegal';
     
     nuOrderId or_order.order_id%TYPE;
     
     BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

     RETURN nuOrderId;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuOrderId;
     END fnuObtenerOTInstanciaLegal;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblObtenerEsNovedad
    Descripcion     : Retorna si la orden corresponde a una novedad
    Autor           : Jhon Soto - Horbath
    Fecha           : 20-09-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   20-09-2023  OSF-1603 Creacion
    ***************************************************************************/
     FUNCTION fblObtenerEsNovedad
    (
         inuOrden or_order.order_id%TYPE
    )
     RETURN VARCHAR2 IS

     -- Nombre de este método
     csbMT_NAME  VARCHAR2(105) := csbSP_NAME||'.fblObtenerEsNovedad';
     fsbEsNovedad varchar2(2);

     BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace(' inuOrden: '||inuOrden,pkg_traza.cnuNivelTrzDef);

        fsbEsNovedad:= Ct_Bonovelty.fsbisnoveltyorder(inuOrden);
        
        pkg_traza.trace(' inuOrden: '||inuOrden||' Es Novedad: '||fsbEsNovedad,pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME , pkg_traza.cnuNivelTrzDef);

     RETURN fsbEsNovedad;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN fsbEsNovedad;
     END fblObtenerEsNovedad;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtenerPersona
    Descripcion     : Retorna Id de la persona relacionada en la orden de trabajo
    Autor           : Jhon Soto - Horbath
    Fecha           : 20-09-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   20-09-2023  OSF-1603 Creacion
    ***************************************************************************/
    FUNCTION fnuObtenerPersona
    (
         inuOrden or_order.order_id%TYPE
    )
     RETURN ge_person.person_id%TYPE IS


        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtenerPersona';
        
        CURSOR cuUnidadOper(inuOrden IN or_order.order_id%TYPE) IS
            SELECT  operating_unit_id
            FROM     or_order
            WHERE     order_id = inuOrden;
        
        nuUnidadOper    or_order.operating_unit_id%TYPE;
        nuPersonaId     ge_person.person_id%TYPE;
        
        PROCEDURE CierraCursorcuUnidadOper
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorcuUnidadOper';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuUnidadOper%ISOPEN) THEN
                CLOSE cuUnidadOper;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorcuUnidadOper;
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        CierraCursorcuUnidadOper;
    
        OPEN cuUnidadOper(inuOrden);
        FETCH cuUnidadOper INTO nuUnidadOper;
        CLOSE cuUnidadOper;

        nuPersonaId := daor_order_person.fnugetperson_id(nuUnidadOper, inuOrden, 0);
        pkg_traza.trace('nuUnidadOper: ' || nuUnidadOper ||' nuPersonaId: '||nuPersonaId, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuPersonaId;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorcuUnidadOper;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuPersonaId;
    END fnuObtenerPersona;

    FUNCTION fnuObtieneOrdenDeActividad 
    (
       inuActividadOrden   in   or_order_activity.order_activity_id%TYPE 
    )
    RETURN or_order.order_id%TYPE
    IS
        
     /***************************************************************************
     Propiedad Intelectual de Gases del Caribe
      Programa        : fnuObtieneOrdenDeActividad
      Descripcion     : Función que retorna el id de la orden para la actividad 
                        enviada como parámetro. 
      Autor           : Edilay Peña Osorio - MVM
      Fecha           : 10/10/2023
 
      Parametros de Entrada
      Nombre                  Tipo                                     Descripción
      ===================    =========                                 =============================
      inuActividadOrden      or_order_activity.order_activity_id%TYPE  Código de la actividad con la cual 
                                                                       se usca el id de la orden. 
      Retorno
      Nombre                  Tipo                                     Descripción
      ===================    =========                                 =============================      
      onuOrden               or_order.order_id%TYPE                    ID de la orden retornar por la función. 
 
      Modificaciones  :
      =========================================================
      Autor       Fecha           Descripción
      epenao    10/10/2023        OSF-1734: Creación
     ***************************************************************************/
                           
              
        csbMT_NAME  CONSTANT VARCHAR2(100) := csbSP_NAME||'.fnuObtieneOrdenDeActividad';
        
        cursor cuOrdenId is
          SELECT order_id
            FROM or_order_activity
           WHERE order_activity_id = inuActividadOrden;

        onuOrden  or_order.order_id%TYPE := null; --variable a retornar.
        PROCEDURE CierracuOrdenId
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierracuOrdenId';
        BEGIN
        
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
            IF (cuOrdenId%ISOPEN) THEN
                CLOSE cuOrdenId;
            END IF;
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
        END CierracuOrdenId;
    BEGIN 
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);    

        open cuOrdenId;
            fetch cuOrdenId into onuOrden;
        close cuOrdenId;        
        
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return onuOrden;    
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierracuOrdenId;            
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN onuOrden;        
    END fnuObtieneOrdenDeActividad;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord 
    Descripcion     : retorna el registro de la unidad operativa
    Autor           : Jorge Valiente
    Fecha           : 12-03-2024
    Caso            : OSF-2411
      
    Parametros de entrada
    inuOrden  Id de la orden a consultar en la tabla OR_ORDER
      
    Parametros de salida
    styUnidadOperativa   Registro de la Orden
      
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
    FUNCTION frcgetRecord(inuOrden IN or_order.order_id%TYPE)
      RETURN styOrden IS
    
      csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.frcgetRecord';
    
      rcDatos      cuRecord%ROWTYPE;
      cuRegNulo    cuRecord%ROWTYPE;
      onuCodError  NUMBER;
      osbMensError VARCHAR2(2000);
    
    BEGIN
    
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbINICIO);
      pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
    
      IF cuRecord%ISOPEN THEN
        CLOSE cuRecord;
      END IF;
    
      OPEN cuRecord(inuOrden);
      FETCH cuRecord
        INTO rcDatos;
    
      IF cuRecord%NOTFOUND THEN
        CLOSE cuRecord;
        rcDatos := cuRegNulo;
      END IF;
      CLOSE cuRecord;
    
      pkg_traza.trace('rcDatos.Order_Id: ', pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN);
    
      RETURN(rcDatos);
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        pkg_error.setError;
        pkg_traza.trace('Registro no Existe: ' || onuCodError || ':' ||
                        osbMensError || csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.controlled_error;
      WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError, osbMensError);
        pkg_traza.trace('Registro no Existe: ' || onuCodError || ':' ||
                        osbMensError || csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
    END;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneDireccion 
    Descripcion     : retorna el Identificador de la direccion externa de la orden de trabajo
    Autor           : Adriana Vargas
    Fecha           : 05/06/2024
    Caso            : OSF-2772
      
    Parametros de entrada
    inuOrden              Id de la orden a consultar en la tabla OR_ORDER
      
    Parametros de salida
    external_address_id   Identificador de la direccion externa de la orden de trabajo
      
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
  Dsaltarin     27/11/2024  OSF-3679: Se corrige la declaración de la variable nuDireccion
                                      Si la dirección de or_order es nula se toma la de or_order_activity       
    ***************************************************************************/
    FUNCTION  fnuObtieneDireccion
    (
        inuOrden     IN     or_order.order_id%TYPE
    )
    RETURN or_order.external_address_id%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtieneDireccion';

        CURSOR cuDireccion(inuOrden IN or_order.order_id%TYPE) IS
        SELECT  external_address_id
        FROM    or_order
        WHERE   order_id = inuOrden;

        CURSOR cuDireccionActividad(inuOrden IN or_order.order_id%TYPE) IS
        SELECT  address_id
        FROM    or_order_activity
        WHERE   order_id = inuOrden;

        nuDireccion    or_order.external_address_id%TYPE;

        PROCEDURE CierraCursoDatoAdicioOrden
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursoDatoAdicioOrden';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

            IF (cuDireccion%ISOPEN) THEN
                CLOSE cuDireccion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursoDatoAdicioOrden;

    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);

        CierraCursoDatoAdicioOrden;

        OPEN cuDireccion(inuOrden);
        FETCH cuDireccion INTO nuDireccion;
        CLOSE cuDireccion;

        IF nuDireccion IS NULL THEN

            IF (cuDireccionActividad%ISOPEN) THEN
                CLOSE cuDireccionActividad;
            END IF;
            OPEN cuDireccionActividad(inuOrden);
            FETCH cuDireccionActividad INTO nuDireccion;
            CLOSE cuDireccionActividad;
        END IF;

        pkg_traza.trace('nuDireccion: ' || nuDireccion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuDireccion;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursoDatoAdicioOrden;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuDireccion;
    END fnuObtieneDireccion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtValorDatoAdicional 
    Descripcion     : Retorna el valor adicional de la orden, grupo de atributos y variable
    Autor           : Jhon Erazo
    Fecha           : 09/12/2024
    Caso            : OSF-3725
      
    Parametros de entrada
		inuOrden              	Id de la orden
		inuGrupoAtributo	  	Id del grupo de atributos
		isbNombreAtributo		Nombre del atributo
      
    Parametros de salida
		sbValorAtributo   	Valor del dato adicional
      
    Modificaciones  :
    Autor       Fecha       Caso     	Descripcion
	jeerazomvm	09/12/2024  OSF-3725	Creacion   
    ***************************************************************************/
    FUNCTION fsbObtValorDatoAdicional(inuOrden			IN or_order.order_id%TYPE,
									  inuGrupoAtributo	IN ge_attributes_set.attribute_set_id%TYPE,
									  isbNombreAtributo	IN ge_attributes.name_attribute%TYPE
									  )
    RETURN or_requ_data_value.value_1%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbObtValorDatoAdicional';
		
		sbValorAtributo     or_requ_data_value.value_1%TYPE;
		rcDataOrden         or_requ_data_value%ROWTYPE;

        CURSOR cuDatoAdicionalOrden
		IS
			SELECT  *
			FROM    or_requ_data_value
			WHERE   order_id 			= inuOrden
			AND     attribute_set_id 	= inuGrupoAtributo;

        nuDireccion    or_order.external_address_id%TYPE;

        PROCEDURE CierraCursoDatoAdicioOrden
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursoDatoAdicioOrden';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

            IF (cuDatoAdicionalOrden%ISOPEN) THEN
                CLOSE cuDatoAdicionalOrden;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursoDatoAdicioOrden;

    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		
        pkg_traza.trace('inuOrden: ' 			|| inuOrden 		|| chr(10) ||
						'inuGrupoAtributo: ' 	|| inuGrupoAtributo || chr(10) ||
						'isbNombreAtributo: ' 	|| isbNombreAtributo, pkg_traza.cnuNivelTrzDef);

        CierraCursoDatoAdicioOrden;

        OPEN cuDatoAdicionalOrden;
        FETCH cuDatoAdicionalOrden INTO rcDataOrden;
        CLOSE cuDatoAdicionalOrden;

        CASE
			WHEN rcDataOrden.name_1 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_1;
			WHEN rcDataOrden.name_2 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_2;
			WHEN rcDataOrden.name_3 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_3;
			WHEN rcDataOrden.name_4 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_4;
			WHEN rcDataOrden.name_5 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_5;
			WHEN rcDataOrden.name_6 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_6;
		    WHEN rcDataOrden.name_7 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_7;
			WHEN rcDataOrden.name_8 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_8;
			WHEN rcDataOrden.name_9 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_9;
			WHEN rcDataOrden.name_10 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_10;
			WHEN rcDataOrden.name_11 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_11;
			WHEN rcDataOrden.name_12 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_12;
			WHEN rcDataOrden.name_13 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_13;
			WHEN rcDataOrden.name_14 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_14;
			WHEN rcDataOrden.name_15 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_15;
		    WHEN rcDataOrden.name_16 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_16;
			WHEN rcDataOrden.name_17 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_17;
			WHEN rcDataOrden.name_18 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_18;
			WHEN rcDataOrden.name_19 = isbNombreAtributo THEN
				sbValorAtributo := rcDataOrden.value_19;
		ELSE
			sbValorAtributo := rcDataOrden.value_20;
		END CASE;

        pkg_traza.trace('sbValorAtributo: ' || sbValorAtributo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN sbValorAtributo;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursoDatoAdicioOrden;
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN sbValorAtributo;
    END fsbObtValorDatoAdicional;
    
END pkg_bcordenes;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcordenes
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCORDENES', 'ADM_PERSON');
END;
/