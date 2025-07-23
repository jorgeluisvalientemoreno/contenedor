CREATE OR REPLACE PACKAGE adm_person.pkg_ge_unit_cost_ite_lis AS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_ge_unit_cost_ite_lis</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>13-05-2025</Fecha>
    <Descripcion> 
        Paquete de primer nivel pkg_ge_unit_cost_ite_lis
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC">
               Creación
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/
    
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------

    -----------------------------------
    -- Cursores
    -----------------------------------   
    
    --Obtiene condiciones financiacion 
    CURSOR cuCostoItem (inuIdActividad IN ge_items.items_id%TYPE)
    IS
    SELECT nvl(sales_value,0)
    FROM ge_unit_cost_ite_lis 
    WHERE items_id = inuIdActividad;

    -----------------------------------
    -- Metodos
    ----------------------------------- 
   
    --Obtiene el valor de la orden por item NC 378
    FUNCTION fnuObtCostoItem(inuIdActividad IN ge_items.items_id%TYPE)
    RETURN NUMBER;
 
END pkg_ge_unit_cost_ite_lis;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ge_unit_cost_ite_lis AS
    
    --------------------------------------------
    -- Constantes 
    --------------------------------------------  
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$PLSQL_UNIT||'.';
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_erc;  
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);    
    
    -----------------------------------
    -- Metodos
    -----------------------------------    
        
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fnuObtCostoItem </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Obtiene el valor de la orden por item NC 378
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fnuObtCostoItem(inuIdActividad IN ge_items.items_id%TYPE)
    RETURN NUMBER
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtCostoItem';
        nuPrecioVenta NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        OPEN cuCostoItem(inuIdActividad);
        FETCH cuCostoItem INTO nuPrecioVenta;
        CLOSE cuCostoItem;
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
        
        RETURN nuPrecioVenta;        
     
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_erc);
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, cnuNvlTrc );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_err);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, cnuNvlTrc );
            RAISE pkg_error.Controlled_Error;
    END fnuObtCostoItem;                               
 
END pkg_ge_unit_cost_ite_lis;
/
BEGIN
    -- OSF-4336
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ge_unit_cost_ite_lis'), UPPER('adm_person'));
END;
/
