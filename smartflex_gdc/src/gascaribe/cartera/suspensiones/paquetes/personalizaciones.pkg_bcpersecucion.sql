CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcPersecucion IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_bcPersecucion</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>23-04-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios de consulta para la anulacion de ordenes
        de persecucion.
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4169" Empresa="GDC">
               Creacion
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/
 
    --------------------------------------------
    -- Cursores
    --------------------------------------------    
    --Consulta datos de suspension del producto 
    CURSOR cuOtPersecucion(isbTipoTrabajo IN ld_parameter.value_chain%TYPE) 
    IS
    SELECT  /*+ 
                use_nl(o, a, s)
                index(o idx_or_order_012)
                index(a idx_or_order_activity_05)
                index(s pk_servsusc)
            */
            a.product_id susp_persec_producto, 
            o.created_date susp_persec_fegeot,
            o.order_id order_id, 
            s.sesususc sesususc, 
            s.sesucate sesucate
    FROM    
            or_order o, 
            or_order_activity a, 
            servsusc s
    WHERE   o.task_type_id IN (SELECT TO_NUMBER(regexp_substr(isbTipoTrabajo, '[^,]+', 1, LEVEL)) AS task_type_id
                                FROM dual
                                CONNECT BY regexp_substr(isbTipoTrabajo, '[^,]+', 1, LEVEL) IS NOT NULL)
    AND     o.order_status_id = 0
    AND     o.order_id = a.order_id
    AND     a.product_id = s.sesunuse;
        
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------
    TYPE tyTbOtPersecucion IS TABLE OF cuOtPersecucion%ROWTYPE INDEX BY BINARY_INTEGER;   
    
    -----------------------------------
    -- Metodos
    -----------------------------------    
    /*****************************************************************
    Unidad      : fsbVersion
    Descripcion : Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion 
    RETURN VARCHAR2;                                  
    
    /*****************************************************************
    Unidad      : ftbObtOrdenesParaAnular
    Descripcion : Retorna informacion de los productos con ordenes de persecucion
    ******************************************************************/    
    FUNCTION ftbObtOrdenesParaAnular
    RETURN tyTbOtPersecucion;  
 
END pkg_bcPersecucion;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcPersecucion IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_bcPersecucion</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>23-04-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios de consulta para la anulacion de ordenes
        de persecucion.
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4169" Empresa="GDC">
               Creacion
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion      CONSTANT VARCHAR2(10)  := 'OSF-4169';
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$plsql_unit || '.';
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbfin_erc;  
    
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
    <Autor> Paola.Acosta </Autor>
    <Fecha> 23-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Version del paquete" Tipo="VARCHAR2">
        Version del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4169" Empresa="GDC"> 
               Creacion
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> ftbObtOrdenesParaAnular </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 23-04-2025 </Fecha>
        <Descripcion> 
            Retorna informacion de los productos con ordenes de persecucion
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4169" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION ftbObtOrdenesParaAnular
    RETURN tyTbOtPersecucion
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'ftbObtOrdenesParaAnular';
        sbTipoTrabajo CONSTANT ld_parameter.value_chain%TYPE := pkg_bcLd_parameter.fsbObtieneValorCadena('TIPOS_TRABAJO_PERSECUCION');
        
        --Variables
        otbOtPersecucion tyTbOtPersecucion;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        OPEN cuOtPersecucion(sbTipoTrabajo);
        FETCH cuOtPersecucion BULK COLLECT INTO otbOtPersecucion;
        CLOSE cuOtPersecucion;
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
        RETURN otbOtPersecucion;
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
    END ftbObtOrdenesParaAnular;
    
END pkg_bcPersecucion;
/

BEGIN
    pkg_utilidades.praplicarpermisos(upper('pkg_bcPersecucion'), 'PERSONALIZACIONES');
END;
/