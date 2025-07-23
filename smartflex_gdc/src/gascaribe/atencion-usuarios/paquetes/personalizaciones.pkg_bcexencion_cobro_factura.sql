CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcexencion_cobro_factura
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_bcexencion_cobro_factura</Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha>05-05-2025</Fecha>
    <Descripcion> 
        Paquete que contiene las consultas de negocio del proceso de exención
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
    Unidad      : fnuObtTotalExencionesVigentes
    Descripcion : Obtiene el total de exenciones vigentes del productos
    ******************************************************************/
    FUNCTION fnuObtTotalExencionesVigentes
    (
        inuProducto     IN servsusc.sesunuse%TYPE
    )
    RETURN NUMBER;
END pkg_bcexencion_cobro_factura;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcexencion_cobro_factura
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bcexencion_cobro_factura </Unidad>
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
    <Unidad> fnuObtTotalExencionesVigentes </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Obtiene el total de exenciones vigentes del productos
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuObtTotalExencionesVigentes
    (
        inuProducto     IN servsusc.sesunuse%TYPE
    )
    RETURN NUMBER
    IS
        --Constantes
        csbMtd_nombre               VARCHAR2(70) := csbPqt_nombre || 'fnuObtTotalExencionesVigentes';
        
        --Variables     
        nuTotal             NUMBER := 0;

        CURSOR cuTotalExencionesVigentes
        IS
        SELECT  COUNT('X')
        FROM    exencion_cobro_factura
        WHERE   producto = inuProducto
        AND     TRUNC(fecha_ini_vigencia) <= TRUNC(SYSDATE)
        AND     TRUNC(fecha_fin_vigencia) > TRUNC(SYSDATE);
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);

        IF (cuTotalExencionesVigentes%ISOPEN) THEN
           CLOSE cuTotalExencionesVigentes;
        END IF;

        OPEN cuTotalExencionesVigentes;
        FETCH cuTotalExencionesVigentes INTO nuTotal;
        CLOSE cuTotalExencionesVigentes;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);

        RETURN nuTotal;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            IF (cuTotalExencionesVigentes%ISOPEN) THEN
            CLOSE cuTotalExencionesVigentes;
            END IF;
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RETURN nuTotal;   
        WHEN OTHERS THEN
            IF (cuTotalExencionesVigentes%ISOPEN) THEN
                CLOSE cuTotalExencionesVigentes;
            END IF;
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RETURN nuTotal;   
    END fnuObtTotalExencionesVigentes;   
END pkg_bcexencion_cobro_factura;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pkg_bcexencion_cobro_factura'),'PERSONALIZACIONES'); 
END;
/