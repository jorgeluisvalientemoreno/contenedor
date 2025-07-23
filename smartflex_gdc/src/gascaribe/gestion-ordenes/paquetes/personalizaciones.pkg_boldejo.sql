CREATE OR REPLACE PACKAGE personalizaciones.pkg_boldejo is
    /******************************************************************************
      Propiedad intelectual de Efigas S.A. E.S.P.

      Unidad       :   pkg_boldejo
      Descripcion  :   Objeto para manejo de loquica del PB - LDEJO

      Historia de Modificaciones (DD-MM-YYYY)
      Fecha        Autor                        Modificacion
      ==========   ===================          ====================================
      11/12/2024   jpinedc - GlobalMVM          OSF-3726: Creación
    ******************************************************************************/

    FUNCTION fsbversion
    RETURN VARCHAR2;

    -- Ejecuta una orden
    PROCEDURE prcEjecutaOrden
    (
        inuOrden            or_order.order_id%TYPE, 
        inuTipoComentario   or_order_comment.comment_type_id%TYPE, 
        isbComentario       or_order_comment.order_comment%TYPE, 
        idtFechaInicio      DATE, 
        idtFechaFin         DATE
    );

END pkg_boldejo;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boldejo is

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
    Unidad      : prcEjecutaOrden
    Descripcion	: Cambia de estado la orden a ejecutada

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE prcEjecutaOrden
    (
        inuOrden            or_order.order_id%TYPE, 
        inuTipoComentario   or_order_comment.comment_type_id%TYPE, 
        isbComentario       or_order_comment.order_comment%TYPE, 
        idtFechaInicio      DATE, 
        idtFechaFin         DATE
    )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEjecutaOrden';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        pkg_bogestion_ordenes.prcEjecutarOrden ( inuOrden, inuTipoComentario, isbComentario );
        
        pkg_Or_Order.prAcEXEC_INITIAL_DATE( inuOrden, idtFechaInicio);
                
        pkg_Or_Order.prAcEXECUTION_FINAL_DATE( inuOrden, idtFechaFin);
        
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
    END prcEjecutaOrden;

END pkg_boldejo;
/

Prompt Otorgando permisos sobre personalizaciones.pkg_boldejo
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_boldejo'), 'PERSONALIZACIONES');
END;
/

