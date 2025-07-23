CREATE OR REPLACE PACKAGE pkg_reglas_tram_exencion_cobro
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_reglas_tram_exencion_cobro</Unidad>
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
    Unidad      : prcReglaIniActividadEconomica
    Descripcion : Regla de inicialización de actividad economica
    ******************************************************************/   
    PROCEDURE prcReglaIniActividadEconomica;

    /*****************************************************************
    Unidad      : prcReglaValProcesoLiquidacion
    Descripcion : Regla para validar si el contrato se encuentra en proceso de liquidación
    ******************************************************************/   
    PROCEDURE prcReglaValProcesoLiquidacion;

    /*****************************************************************
    Unidad      : prcReglaValCategoria
    Descripcion : Regla para validar si categoría es valida para ejecutar el tramite
    ******************************************************************/   
    PROCEDURE prcReglaValCategoria;
END pkg_reglas_tram_exencion_cobro;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_tram_exencion_cobro
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_reglas_tram_exencion_cobro </Unidad>
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
    <Unidad> prcReglaIniActividadEconomica </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Regla de inicialización de actividad economica
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcReglaIniActividadEconomica
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcReglaIniActividadEconomica';     
        
        --Variables     
        sbInstanciaActual	VARCHAR2(4000); 
        sbInstanciaPadre	VARCHAR2(4000);
        nuContrato          NUMBER;
        sbContrato          VARCHAR(2000);
        sbActividadEconomica VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 

        ge_boinstancecontrol.getcurrentinstance(sbInstanciaActual);

        --Consultar el contrato de la instancia actual de trabajo
        IF (ge_boinstancecontrol.fblacckeyattributestack('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', sbContrato)) THEN
            prc_obtienevalorinstancia('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', sbContrato);
        ELSE
            IF ( mo_boregisterwithxml.fblisregisterxml) THEN
                ge_boinstancecontrol.getfathercurrentinstance(sbInstanciaPadre);

                prc_obtienevalorinstancia(sbInstanciaPadre, null, 'MO_PROCESS', 'SUBSCRIPTION_ID', sbContrato);
            END IF;
        END IF;

        nuContrato := to_number(sbContrato);

        -- Valida que se lea el contrato de la instancia
        IF (nvl(nuContrato,0) = 0) THEN
            sbActividadEconomica := 'Error: El contrato no puedo ser leido de la instancia '||nuContrato;
        ELSE
            -- Crea la actividad de notificacion
            sbActividadEconomica := pkg_boexencion_cobro_factura.fnuObtieneActividadEconomica(nuContrato);
        END IF;

        ge_boinstancecontrol.setentityattribute(sbActividadEconomica);

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
    END prcReglaIniActividadEconomica; 

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReglaValProcesoLiquidacion </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Regla para validar si el contrato se encuentra en proceso de liquidación
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcReglaValProcesoLiquidacion
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcReglaValProcesoLiquidacion';     
        
        --Variables     
        sbInstanciaActual	VARCHAR2(4000); 
        sbInstanciaPadre	VARCHAR2(4000);
        nuContrato          NUMBER;
        sbContrato          VARCHAR(2000);
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 

        ge_boinstancecontrol.getcurrentinstance(sbInstanciaActual);

        --Consultar el contrato de la instancia actual de trabajo
        IF (ge_boinstancecontrol.fblacckeyattributestack('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', sbContrato)) THEN
            prc_obtienevalorinstancia('WORK_INSTANCE', NULL, 'SUSCRIPC', 'SUSCCODI', sbContrato);
        ELSE
            IF ( mo_boregisterwithxml.fblisregisterxml) THEN
                ge_boinstancecontrol.getfathercurrentinstance(sbInstanciaPadre);

                prc_obtienevalorinstancia(sbInstanciaPadre, null, 'MO_PROCESS', 'SUBSCRIPTION_ID', sbContrato);
            END IF;
        END IF;

        nuContrato := to_number(sbContrato);

        pkg_boexencion_cobro_factura.prcValidaFacturacionEnProceso(nuContrato);
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
    END prcReglaValProcesoLiquidacion; 

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReglaValCategoria </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-05-2025 </Fecha>
    <Descripcion> 
        Regla para validar si categoría es valida para ejecutar el tramite
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-05-2025" Inc="OSF-4171" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcReglaValCategoria
    IS
        --Constantes
        csbMtd_nombre       VARCHAR2(70) := csbPqt_nombre || 'prcReglaValProcesoLiquidacion';     
        
        --Variables     
        sbInstanciaActual	VARCHAR2(4000); 
        sbInstanciaPadre	VARCHAR2(4000);
        nuProducto           NUMBER;
        sbProducto           VARCHAR(2000);
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 

        ge_boinstancecontrol.getcurrentinstance(sbInstanciaActual);

        IF (ge_boinstancecontrol.fblacckeyattributestack('WORK_INSTANCE', NULL, 'PR_PRODUCT', 'PRODUCT_ID', sbProducto)) THEN
            prc_obtienevalorinstancia('WORK_INSTANCE', NULL, 'PR_PRODUCT', 'PRODUCT_ID', sbProducto);
        ELSE
            IF ( mo_boregisterwithxml.fblisregisterxml) THEN
                ge_boinstancecontrol.getfathercurrentinstance(sbInstanciaPadre);

                prc_obtienevalorinstancia(sbInstanciaPadre, null, 'MO_PROCESS', 'PRODUCT_ID', sbProducto);
            END IF;
        END IF;

        nuProducto := to_number(sbProducto);

        pkg_boexencion_cobro_factura.prcValidaCategoriaPraducto(nuProducto);

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
    END prcReglaValCategoria; 
END pkg_reglas_tram_exencion_cobro;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('pkg_reglas_tram_exencion_cobro'),'OPEN'); 
END;
/