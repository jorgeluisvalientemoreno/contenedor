CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_finan_cond AS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_ldc_finan_cond</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>13-05-2025</Fecha>
    <Descripcion> 
        Paquete de primer nivel pkg_ldc_finan_cond
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
    CURSOR cuCondFinan (inuIdActividad   IN ge_items.items_id%TYPE,
                        isbLocacion      IN VARCHAR2,
                        inuIdCategoria   IN NUMBER,
                        inuIdSucategoria IN NUMBER,
                        inuValorOrden    IN or_order.order_value%TYPE)    
    IS
    SELECT *
    FROM ldc_finan_cond
    WHERE reco_activity = inuIdActividad
    AND geo_location_id IN (SELECT (regexp_substr(isbLocacion,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL)) AS vlrColumna
                            FROM dual
                            CONNECT BY regexp_substr(isbLocacion,
                                                     '[^,]+',
                                                     1,
                                                     LEVEL) IS NOT NULL        
                            )
    AND category_id = inuIdCategoria
    AND subcategory_id = inuIdSucategoria
    AND inuValorOrden BETWEEN nvl(min_value, 0) AND nvl(max_value, 999999999);

    -----------------------------------
    -- Metodos
    ----------------------------------- 
   
    -- Obtiene condiciones de financiacion
    FUNCTION frcObtCondFinanciacion(inuIdActividad   IN ge_items.items_id%TYPE,
                                    isbLocacion      IN VARCHAR2,
                                    inuIdCategoria   IN NUMBER,
                                    inuIdSucategoria IN NUMBER,
                                    inuValorOrden    IN or_order.order_value%TYPE)
    RETURN cuCondFinan%ROWTYPE;
 
END pkg_ldc_finan_cond;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_finan_cond AS
    
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
        <Unidad> frcObtCondFinanciacion </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Obtiene condiciones de finanaciacion
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION frcObtCondFinanciacion(inuIdActividad   IN ge_items.items_id%TYPE,
                                    isbLocacion      IN VARCHAR2,
                                    inuIdCategoria   IN NUMBER,
                                    inuIdSucategoria IN NUMBER,
                                    inuValorOrden    IN or_order.order_value%TYPE)
    RETURN cuCondFinan%ROWTYPE
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre||'frcObtCondFinanciacion';
        orcCondFinan cuCondFinan%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        OPEN cuCondFinan(inuIdActividad,
                         isbLocacion,
                         inuIdCategoria,
                         inuIdSucategoria,
                         inuValorOrden);
        FETCH cuCondFinan INTO orcCondFinan;
        CLOSE cuCondFinan;
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
        
        RETURN orcCondFinan;        
     
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
    END frcObtCondFinanciacion;                               
 
END pkg_ldc_finan_cond;
/
BEGIN
    -- OSF-4336
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ldc_finan_cond'), UPPER('adm_person'));
END;
/
