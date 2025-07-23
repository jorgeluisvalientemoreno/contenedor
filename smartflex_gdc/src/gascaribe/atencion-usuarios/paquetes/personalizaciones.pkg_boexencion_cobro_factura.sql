CREATE OR REPLACE PACKAGE personalizaciones.pkg_boexencion_cobro_factura
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_boexencion_cobro_factura</Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha>05-05-2025</Fecha>
    <Descripcion> 
        Paquete que contiene la logica de negocio del proceso de exención
        de cobro de factura
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="05-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*****************************************************************
    Unidad      : fsbVersion
    Descripcion : Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
    /*****************************************************************
    Unidad      : fblGeneraOrdenNoRegulados
    Descripcion : Regla que valida si genera la orden para usuarios no regulados
    ******************************************************************/
    FUNCTION fblGeneraOrdenNoRegulados
    (
        inuCategoria    IN categori.catecodi%TYPE
    )
    RETURN BOOLEAN;
    
    /*****************************************************************
    Unidad      : fblGeneraOrdenRegulados
    Descripcion : Regla que valida si genera la orden para usuarios regulados
    ******************************************************************/
    FUNCTION fblGeneraOrdenRegulados
    (
        inuCategoria    IN categori.catecodi%TYPE
    )
    RETURN BOOLEAN;

    /*****************************************************************
    Unidad      : fsbObtieneActividadEconomica
    Descripcion : Obtiene Actividad Economica
    ******************************************************************/
    FUNCTION fnuObtieneActividadEconomica
    (
        inuContrato     IN servsusc.sesususc%TYPE
    )
    RETURN ge_economic_activity.economic_activity_id%TYPE;

    /*****************************************************************
    Unidad      : prcValidaFacturacionEnProceso
    Descripcion : Valida si el contrato se encuentra en proceso de facturación
    ******************************************************************/
    PROCEDURE prcValidaFacturacionEnProceso
    (
        inuContrato     IN servsusc.sesususc%TYPE
    );

    /*****************************************************************
    Unidad      : prcValidaCategoriaPraducto
    Descripcion : Valida si el producto tiene categoria correcta para ejecutar el tramite
    ******************************************************************/
    PROCEDURE prcValidaCategoriaPraducto
    (
        inuProducto     IN servsusc.sesunuse%TYPE
    );
END pkg_boexencion_cobro_factura;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boexencion_cobro_factura
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_boexencion_cobro_factura </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 05-05-2025 </Fecha>
    <Descripcion> 
        Paquete que contiene la logica de negocio del proceso de exención
        de cobro de factura
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="05-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-4171';
    csbPqt_nombre       CONSTANT VARCHAR2(100):= $$plsql_unit||'.';
    cnuNvlTrc           CONSTANT NUMBER       := pkg_traza.cnuniveltrzdef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin              CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err          CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc          CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
	sbMensaje   VARCHAR2(1000);
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 05-05-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="05-05-2025" Inc="OSF-4171" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
  
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblGeneraOrdenNoRegulados </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Regla que valida si genera la orden para usuarios no regulados
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fblGeneraOrdenNoRegulados
    (
        inuCategoria    IN categori.catecodi%TYPE
    )
    RETURN BOOLEAN
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'fblGeneraOrdenNoRegulados';
        
        --Variables     
        blGeneraOrden       BOOLEAN := FALSE;
        sbParametro     parametros.codigo%TYPE := 'CATE_ORDEN_EXENCION_NO_REGULADOS';
        sbSeparador     VARCHAR2(10) := ',';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
                     
        IF pkg_parametros.fnuValidaSiExisteCadena(sbParametro,sbSeparador,to_char(inuCategoria)) > 0 THEN
            blGeneraOrden := TRUE;                                   
        END IF;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
        RETURN blGeneraOrden;          
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RETURN blGeneraOrden;   
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RETURN blGeneraOrden;   
    END fblGeneraOrdenNoRegulados;         
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblGeneraOrdenRegulados </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Regla que valida si genera la orden para usuarios regulados
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fblGeneraOrdenRegulados
    (
        inuCategoria    IN categori.catecodi%TYPE
    )
    RETURN BOOLEAN
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'fblGeneraOrdenRegulados';
        
        --Variables     
        blGeneraOrden       BOOLEAN := FALSE;
        sbParametro     parametros.codigo%TYPE := 'CATE_ORDEN_EXENCION_REGULADOS';
        sbSeparador     VARCHAR2(10) := ',';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
                     
        IF pkg_parametros.fnuValidaSiExisteCadena(sbParametro,sbSeparador,to_char(inuCategoria)) > 0 THEN
            blGeneraOrden := TRUE;                                   
        END IF;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
        RETURN blGeneraOrden;          
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RETURN blGeneraOrden;   
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RETURN blGeneraOrden;   
    END fblGeneraOrdenRegulados;   

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtieneActividadEconomica </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Obtiene Actividad Economica
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuObtieneActividadEconomica
    (
        inuContrato     IN servsusc.sesususc%TYPE
    )
    RETURN ge_economic_activity.economic_activity_id%TYPE
    IS
        --Constantes
        csbMtd_nombre               VARCHAR2(70) := csbPqt_nombre || 'fnuObtieneActividadEconomica';
        
        --Variables     
        nuActividadEconomica        ge_economic_activity.economic_activity_id%TYPE;

        nuCodigoCliente             suscripc.suscclie%TYPE;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);

        IF (nvl(inuContrato,0) = 0) THEN
            Pkg_Error.SetErrorMessage( Pkg_Error.CNUGENERIC_MESSAGE, 'Error: El codigo del contrato no puede ser nulo '||inuContrato); 
        END IF;

        -- Trae la actividad economica del contrato
        nuActividadEconomica := pkg_bccontrato.fnuActividadEconomicaContrato(inuContrato);

        -- Si el contrato no tiene actividad economica la busca en el cliente
        IF nuActividadEconomica IS NULL THEN

            -- Obtiene el id del cliente
            nuCodigoCliente :=  pkg_bccontrato.fnuIdCliente(inuContrato);

            nuActividadEconomica := pkg_bccliente.fnuActividadEconomicaCliente(nuCodigoCliente);

            pkg_traza.trace ('Contrato: '||inuContrato||', Actividad Economica del cliente: '||nuActividadEconomica);
        ELSE
            pkg_traza.trace ('Contrato: '||inuContrato||', Actividad Economica del contrato: '||nuActividadEconomica);
        END IF;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);

        RETURN nuActividadEconomica;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RETURN nuActividadEconomica;   
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RETURN nuActividadEconomica;   
    END fnuObtieneActividadEconomica;   

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcValidaFacturacionEnProceso </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Valida si el contrato se encuentra en proceso de facturación
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcValidaFacturacionEnProceso
    (
        inuContrato     IN servsusc.sesususc%TYPE
    )
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcValidaFacturacionEnProceso';     
        
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 

        IF (nvl(pkg_bccontrato.fnuCodigoProcFacturacion(inuContrato),0) > 0) THEN
            Pkg_Error.SetErrorMessage(isbMsgErrr =>'Al menos uno de los productos del contrato se encuentra en proceso de facturación');
        END IF;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prcValidaFacturacionEnProceso; 

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcValidaCategoriaPraducto </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Valida si el producto tiene categoria correcta para ejecutar el tramite
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcValidaCategoriaPraducto
    (
        inuProducto     IN servsusc.sesunuse%TYPE
    )
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcValidaCategoriaPraducto';     
        nuCategoria         servsusc.sesucate%TYPE;
        sbParaNoRegulados   parametros.codigo%TYPE := 'CATE_ORDEN_EXENCION_NO_REGULADOS';
        sbParaRegulados     parametros.codigo%TYPE := 'CATE_ORDEN_EXENCION_REGULADOS';
        sbSeparador     VARCHAR2(10) := ',';
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 

        nuCategoria := pkg_bcproducto.fnuCategoria(inuProducto);

        IF pkg_parametros.fnuValidaSiExisteCadena(sbParaNoRegulados,sbSeparador,to_char(nuCategoria)) = 0 AND
            pkg_parametros.fnuValidaSiExisteCadena(sbParaRegulados,sbSeparador,to_char(nuCategoria)) = 0
        THEN
            Pkg_Error.SetErrorMessage(isbMsgErrr =>'No es posible registrar la solicitud ya que el producto no tiene una categoría valida');
        END IF;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prcValidaCategoriaPraducto; 
END pkg_boexencion_cobro_factura;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pkg_boexencion_cobro_factura'),'PERSONALIZACIONES'); 
END;
/