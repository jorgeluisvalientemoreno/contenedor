CREATE OR REPLACE PACKAGE pkg_reglas_flujo_exen_cobro
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_reglas_flujo_exen_cobro</Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha>05-05-2025</Fecha>
    <Descripcion> 
        Paquete para gestion de reglas del flujo de exención de cobro
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
    Unidad      : prcReglaGeneraOrdenNoRegulados
    Descripcion : Regla que valida si genera la orden para usuarios no regulados
    ******************************************************************/
    PROCEDURE prcReglaGeneraOrdenNoRegulados;

    /*****************************************************************
    Unidad      : prcReglaGeneraOrdenRegulados
    Descripcion : Regla que valida si genera la orden para usuarios regulados
    ******************************************************************/
    PROCEDURE prcReglaGeneraOrdenRegulados;
    
END pkg_reglas_flujo_exen_cobro;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_flujo_exen_cobro
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_reglas_flujo_exen_cobro </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 05-05-2025 </Fecha>
    <Descripcion> 
        Paquete para gestion de reglas del flujo de exención de cobro
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
    <Unidad> prcReglaGeneraOrdenNoRegulados </Unidad>
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
    PROCEDURE prcReglaGeneraOrdenNoRegulados
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcReglaGeneraOrdenNoRegulados';     
        
        --Variables     
        nuSolicitud         NUMBER;       
        nuCategoria         NUMBER;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);

        nuSolicitud := or_boinstance.fnugetfathextsysidfrominstance;

        nuCategoria := mo_bopackages.fnugetcategoryid(nuSolicitud);

        IF ( pkg_boexencion_cobro_factura.fblGeneraOrdenNoRegulados(nuCategoria) ) THEN
            pkg_bogestion_instancias.prcfijarexito;
        ELSE
            pkg_bogestion_instancias.prcfijarnoexito;
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
    END prcReglaGeneraOrdenNoRegulados; 
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReglaGeneraOrdenRegulados </Unidad>
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
    PROCEDURE prcReglaGeneraOrdenRegulados
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcReglaGeneraOrdenRegulados';     
        
        --Variables     
        nuSolicitud         NUMBER;       
        nuCategoria         NUMBER;
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);

        nuSolicitud := or_boinstance.fnugetfathextsysidfrominstance;

        nuCategoria := mo_bopackages.fnugetcategoryid(nuSolicitud);

        IF ( pkg_boexencion_cobro_factura.fblGeneraOrdenRegulados(nuCategoria) ) THEN
            pkg_bogestion_instancias.prcfijarexito;
        ELSE
            pkg_bogestion_instancias.prcfijarnoexito;
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
    END prcReglaGeneraOrdenRegulados; 
END pkg_reglas_flujo_exen_cobro;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pkg_reglas_flujo_exen_cobro'),'OPEN'); 
END;
/