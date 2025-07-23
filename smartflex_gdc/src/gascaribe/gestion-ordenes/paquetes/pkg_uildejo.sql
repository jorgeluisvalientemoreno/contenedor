CREATE OR REPLACE PACKAGE pkg_uildejo is
    /******************************************************************************
      Propiedad intelectual de Efigas S.A. E.S.P.

      Unidad       :   pkg_uildejo
      Descripcion  :   Objeto para manejo de loquica del PB - LDEJO

      Historia de Modificaciones (DD-MM-YYYY)
      Fecha        Autor                        Modificacion
      ==========   ===================          ====================================
      11/12/2024   jpinedc - GlobalMVM          OSF-3726: Creación
    ******************************************************************************/

    FUNCTION fsbversion
    RETURN VARCHAR2;

    -- Ejecuta una orden
    PROCEDURE prcObjeto;

    -- Establece en la instancia el valor para la fecha inicial en LDEJO
    PROCEDURE prcReglaInicializaFechaInicio;

    -- Establece en la instancia el valor para la fecha final en LDEJO
    PROCEDURE prcReglaInicializaFechaFin;

END pkg_uildejo;
/

CREATE OR REPLACE PACKAGE BODY pkg_uildejo is

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    csbversion  CONSTANT VARCHAR2( 250 ) := 'OSF-3726';

    sbErrMsg	ge_error_log.description%type;

    FUNCTION fsbversion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN ( csbversion );
    END fsbversion;


    /****************************************************************************
    Unidad      : prcObjeto
    Descripcion	: Cambia de estado la orden a ejecutada

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE prcObjeto
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObjeto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        -- Tipo de Comentario de la orden
        sbComment_type_id   GE_BOINSTANCECONTROL.STYSBVALUE;
        nuTipoComentario    or_order_comment.comment_type_id%TYPE;

        -- Comentario de la Orden
        sbComentario     GE_BOINSTANCECONTROL.STYSBVALUE;

        -- Fehca Inicio de Ejecución de la orden
        sbStartDate         GE_BOINSTANCECONTROL.STYSBVALUE;
        dtFechaInicio         or_order.exec_initial_date%type;

        -- Fecha Fin de Ejecución de Orden
        sbEndDAte           GE_BOINSTANCECONTROL.STYSBVALUE;
        dtFechaFin           or_order.execution_final_date%type;

        -- Identificador de la orden
        sbOrder_id          GE_BOINSTANCECONTROL.STYSBVALUE;
        nuOrden             OR_ORDER.ORDER_ID%TYPE;

        nuIndex             GE_BOINSTANCECONTROL.STYNUINDEX;

        cNunull_Attribute CONSTANT NUMBER := 2126;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        -- ------------------------------------------------------------------ --
        -- Obtiene los datos ingresados por el usuario de la instancia.       --
        -- ------------------------------------------------------------------ --
        sbComment_type_id   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER_COMMENT', 'COMMENT_TYPE_ID' );
        sbComentario     := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER_COMMENT', 'ORDER_COMMENT' );
        sbStartDate         := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'EXEC_INITIAL_DATE' );
        sbEndDAte           := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'EXECUTION_FINAL_DATE' );

        -- Convertir fecha de entrada en tipo date
        dtFechaInicio     := to_date(sbStartDate, 'DD/MM/YYYY HH24:MI:SS');
        dtFechaFin       := to_date(sbEndDAte, 'DD/MM/YYYY HH24:MI:SS');
        
        -- Valida que la fecha de inicio de ejecución no sea mayo a la fecha final
        if ( dtFechaInicio >  dtFechaFin ) then
            pkg_error.setErrorMessage(  isbMsgErrr => 'Fecha de inicio de ejecución no puede ser mayor a la fecha final.' );
        end if;

        -- Valida que la fecha fin de ejecución no sea mayor a la fecha actual
        if ( sysdate <  dtFechaFin ) then
            pkg_error.setErrorMessage(  isbMsgErrr => 'Fecha fin de ejecución no puede ser mayor a la fecha actual.' );
        end if;

        -- Valida si el tipo de comentario es nulo
        if ( sbComment_type_id is null ) then
            pkg_error.setErrorMessage( cNunull_Attribute, 'Tipo' );
        end if;

        nuTipoComentario := ut_convert.fnuchartonumber( sbComment_type_id );
        
        if (
                GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK
                (
                    GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                    NULL,
                    'OR_ORDER',
                    'ORDER_ID',
                    nuIndex
                )
            )
        then
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
            (
                GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                NULL,
                'OR_ORDER',
                'ORDER_ID',
                sbOrder_id
            );
            nuOrden := ut_convert.fnuchartonumber( sbOrder_id );
        else
            pkg_error.setErrorMessage( cNunull_Attribute, 'Código de Orden' );
        end if;

        pkg_boldejo.prcEjecutaOrden( nuOrden, nuTipoComentario, sbComentario, dtFechaInicio, dtFechaFin );

        COMMIT;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
         
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcObjeto;

    /****************************************************************************
    Unidad      : prcReglaInicializaFechaInicio
    Descripcion	: Inicializa la fecha inicio de ejecución de la orden

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE prcReglaInicializaFechaInicio
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcReglaInicializaFechaInicio';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        -- Identificador de la orden
        sbOrder_id          GE_BOINSTANCECONTROL.STYSBVALUE;
        nuOrden          OR_ORDER.ORDER_ID%TYPE;

        sbInstancia          GE_BOINSTANCECONTROL.STYSBNAME;

        -- fecha de asiganación de la orden
        dtFechaAsignacion       or_order.assigned_date%type;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
        (
            GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
            NULL,
            'OR_ORDER',
            'ORDER_ID',
            sbOrder_id
        );
        
        nuOrden := ut_convert.fnuchartonumber( sbOrder_id );
        
        dtFechaAsignacion := pkg_BCOrdenes.fdtObtieneFechaAsigna(nuOrden);

        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);
        GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia, NULL, 'OR_ORDER', 'EXEC_INITIAL_DATE', dtFechaAsignacion,TRUE);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcReglaInicializaFechaInicio;

    /****************************************************************************
    Unidad      : prcReglaInicializaFechaFin
    Descripcion	: Inicializa la fecha fin de ejecución de la orden

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE prcReglaInicializaFechaFin
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcReglaInicializaFechaFin';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        -- fecha de asiganación de la orden
        dtFechaActual          or_order.assigned_date%type;

        sbInstancia          GE_BOINSTANCECONTROL.STYSBNAME;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        dtFechaActual := sysdate;

        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);
        GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia, NULL, 'OR_ORDER', 'EXECUTION_FINAL_DATE', dtFechaActual,TRUE);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
         
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prcReglaInicializaFechaFin;

END pkg_uildejo;
/

Prompt Otorgando permisos sobre pkg_uildejo
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_uildejo'), 'OPEN');
END;
/

