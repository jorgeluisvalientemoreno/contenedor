CREATE OR REPLACE PACKAGE personalizaciones.pkg_boPersecucion IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_boPersecucion</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>23-04-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios para la anulacion de ordenes de
        persecucion
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4169" Empresa="GDC">
               Creacion
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/
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
    Unidad      : prcAnulacionOrdenes
    Descripcion : Anula ordenes de persecucion para productos sin cartera 
                  vencida y cartera castigada igual a cero
    ******************************************************************/    
    PROCEDURE prcAnulacionOrdenes;    
 
END pkg_boPersecucion;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boPersecucion IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_boPersecucion</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>23-04-2025</Fecha>
    <Descripcion> 
        Paquete con los servicios para la anulacion de ordenes de
        persecucion
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
    sbMensaje   VARCHAR2(3000);
        
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
        <Unidad> prcAnulacionOrdenes </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 23-04-2025 </Fecha>
        <Descripcion> 
            Anula ordenes de persecucion para productos sin cartera 
            vencida y cartera castigada igual a cero
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4169" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    PROCEDURE prcAnulacionOrdenes
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(100) := csbPqt_nombre || 'prcAnulacionOrdenes';
        
        --Variables
        nuOK            NUMBER := 0;
        nuVlrDeuda      NUMBER(15,2) := 0;
        nuVlrCC         NUMBER;            
        tbOtPersecucion pkg_bcPersecucion.tyTbOtPersecucion;
            
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        --Obtiene ordenes de persecucion
        tbOtPersecucion := pkg_bcpersecucion.ftbObtOrdenesParaAnular;
        
        FOR rcReg IN 1..tbOtPersecucion.COUNT LOOP
                            
            nuOk := pkg_bcPagos.fnuObtCantPagosXFechaPago(tbOtPersecucion(rcReg).sesususc, tbOtPersecucion(rcReg).susp_persec_fegeot);
                           
            IF (nuOk > 0) THEN
                
                pkg_traza.trace('Contrato: '||tbOtPersecucion(rcReg).sesususc||
                                ' Producto: '||tbOtPersecucion(rcReg).susp_persec_producto||
                                ' Categoria: '||tbOtPersecucion(rcReg).sesucate||
                                ' Orden: '||tbOtPersecucion(rcReg).order_id||
                                ' Fecha Creacion Orden: '||tbOtPersecucion(rcReg).order_id
                                , cnuNvlTrc); 
                
                --Valida si tiene deuda vencida
                IF (tbOtPersecucion(rcReg).sesucate = 1) THEN
                    nuVlrDeuda := pkg_bogestion_financiacion.fnuObtDeudaVencidaProd(TO_NUMBER(tbOtPersecucion(rcReg).susp_persec_producto)); -- deuda vencida
                ELSE
                    nuVlrDeuda := pkg_bogestion_financiacion.fnuObtDeudaProd(tbOtPersecucion(rcReg).susp_persec_producto); -- Deuda Corriente (Vencida y No vencida)
                END IF;
                
                pkg_traza.trace('nuVlrDeuda: '||nuVlrDeuda, cnuNvlTrc); 
                
                IF (nuVlrDeuda = 0) THEN
                    --Valida si el producto tiene cartera castigada 
                    nuVlrCC := pkg_bogestion_financiacion.fnuobtvalorsaldocastigado(tbOtPersecucion(rcReg).susp_persec_producto);
                    
                    pkg_traza.trace('nuVlrCC: '||nuVlrCC, cnuNvlTrc);
                    
                    IF nuVlrCC = 0 THEN            
                        -- Anula la orden
                        api_anullorder(tbOtPersecucion(rcReg).order_id, 1277, 'ORDEN ANULADA MEDIANTE JOB DE ANULACION DE ORDENES DE PERSECUCION', nuError, sbMensaje);
                
                        pkg_traza.trace('nuError: '||nuError, cnuNvlTrc);
                        pkg_traza.trace('sbMensaje: '||sbMensaje, cnuNvlTrc);
                    END IF;              
                END IF;
            END IF;
        END LOOP;    
        
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
    END prcAnulacionOrdenes;
    
END pkg_boPersecucion;
/

BEGIN
    pkg_utilidades.praplicarpermisos(upper('pkg_boPersecucion'), 'PERSONALIZACIONES');
END;
/