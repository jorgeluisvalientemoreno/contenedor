CREATE OR REPLACE FUNCTION ADM_PERSON.fnuObtPrimerActividad 
( 
    inuOrden     NUMBER
)
RETURN NUMBER
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtPrimerActividad 
    Descripcion     : Retorna la primera actividad asociada a la orden
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 28/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     28/10/2024  OSF-2204    Creacion
    ***************************************************************************/  

IS
    -- Nombre de este mtodo
    csbMETODO  VARCHAR2(30) := 'fnuObtPrimerActividad';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    nuError         NUMBER;
    sbError         VARCHAR2(4000);   
            
    nuPrimerActividad   NUMBER;
   
BEGIN

    pkg_Traza.Trace('Inicia ' ||csbMETODO, csbNivelTraza);    
    
    nuPrimerActividad := ldc_bcfinanceot.fnugetactivityid( inuOrden );

    pkg_Traza.Trace('Termina ' ||csbMETODO, csbNivelTraza); 
    
    RETURN nuPrimerActividad;   

EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RETURN nuPrimerActividad;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RETURN nuPrimerActividad;
END fnuObtPrimerActividad;
/
Prompt Otorgando permisos sobre ADM_PERSON.fnuObtPrimerActividad
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('fnuObtPrimerActividad'), 'ADM_PERSON');
END;
/