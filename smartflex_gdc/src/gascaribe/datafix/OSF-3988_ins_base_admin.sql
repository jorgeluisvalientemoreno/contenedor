DECLARE

    -- OSF-3988    
    csbMetodo        CONSTANT VARCHAR2(70) := 'OSF-3988_ins_base_admin';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    nuError         NUMBER;
    sbError         VARCHAR2(4000); 
    
    CURSOR cuGe_Base_Administra
    IS
    SELECT ba.ID_BASE_ADMINISTRA BASE_ADMINISTRATIVA, 'GDCA' Empresa
    FROM GE_BASE_ADMINISTRA ba
    WHERE ba.ID_BASE_ADMINISTRA <> 25
    UNION ALL
    SELECT 25 BASE_ADMINISTRATIVA, 'GDGU' Empresa
    FROM DUAL
    ORDER BY 1;
                    
BEGIN

    FOR rgBaseAdmin in cuGe_Base_Administra LOOP
            
        IF NOT pkg_base_admin.fblExiste( rgBaseAdmin.base_administrativa ) THEN
                                        
            pkg_Base_Admin.prcInsRegistro
            (
                inuBaseAdministrativa =>  rgBaseAdmin.base_administrativa ,
                isbEmpresa  =>  rgBaseAdmin.empresa
            );

            dbms_output.put_line('INFO:[Ok - Base_Admin.base_administrativa=' || rgBaseAdmin.base_administrativa || ']' );
            
        ELSE
        
            dbms_output.put_line('INFO:[Ya existe Base_Admin.base_administrativa=' || rgBaseAdmin.base_administrativa || ']' );
                        
        END IF;
                
    END LOOP;
    
    COMMIT;
    
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
END;
/