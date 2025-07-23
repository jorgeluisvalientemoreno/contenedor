CREATE OR REPLACE TRIGGER multiempresa.trg_val_emp_func_contr
BEFORE INSERT OR UPDATE ON NOTAS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN 
( 
    NEW.NOTATINO IN ( 'C','D' ) AND -- Crédito , Débito
    NEW.NOTAPROG NOT IN (700,2016) -- FINAN , GCNED
    AND NEW.NOTASUSC IS NOT NULL AND NVL(OLD.NOTASUSC,-1) <> NEW.NOTASUSC 
) 
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_val_emp_func_contr
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   28/03/2025
    Descripcion :   Trigger para validar que la empresa el funcionario y del
                    contrato sean la misma
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     28/03/2025  OSF-4032    Creacion
*******************************************************************************/
    csbMetodo               CONSTANT VARCHAR2(70) :=  'trg_val_emp_func_contr';
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    nuSolicitud             mo_packages.package_id%TYPE;
    
    nuFuncionario           ge_person.person_id%TYPE;
    
    nuUsuario               sa_user.user_id%TYPE;
    
    nuContrato              notas.notasusc%TYPE;
    
    sbEmpresaFuncionario    empresa.codigo%TYPE;

    sbEmpresaContrato       empresa.codigo%TYPE;
                    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    nuSolicitud := PKG_BOINSTANCIA.fnuObtenerIdSolInstancia;
    
    pkg_traza.trace('nuSolicitud|'|| nuSolicitud, csbNivelTraza );
    
    IF nuSolicitud IS NOT NULL THEN

        pkg_traza.trace('La nota SI se está creando desde un flujo de solicitud', csbNivelTraza );
        
        nuFuncionario   := pkg_bcsolicitudes.fnuGetPersona( nuSolicitud );
        
        nuUsuario       :=  pkg_bcpersonal.fnuObtieneUsuario( nuFuncionario );
                
    ELSE    
        pkg_traza.trace('La nota NO se está creando desde un flujo de solicitud', csbNivelTraza );
        
        nuUsuario       := :NEW.NOTAUSUA;
        
        nuFuncionario   := pkg_bcpersonal.fnuObtFuncionarioUsuario(nuUsuario); 
                   
    END IF;    

    pkg_traza.trace('nuFuncionario|'|| nuFuncionario, csbNivelTraza );

    pkg_traza.trace('nuUsuario|'|| nuUsuario, csbNivelTraza );
        
    IF nuUsuario IS NOT NULL THEN
            
        IF pkg_parametros.fnuValidaSiExisteCadena('USUARIO_EXCL_VAL_EMP_FUNC_CONTR', ',', nuUsuario  ) = 0 THEN
        
            sbEmpresaFuncionario    := pkg_boconsultaempresa.fsbObtEmpresaUsuario( nuFuncionario );

            nuContrato              := :NEW.NOTASUSC;
            
            sbEmpresaContrato       := pkg_boconsultaempresa.fsbObtEmpresaContrato( nuContrato);
            
            IF ( sbEmpresaFuncionario IS NOT NULL AND sbEmpresaContrato IS NOT NULL ) THEN
                IF sbEmpresaFuncionario <> sbEmpresaContrato  THEN
                    pkg_error.setErrorMessage( isbMsgErrr => 'La empresa del funcionario[' || sbEmpresaFuncionario || '] es diferente a la empresa del contrato[' || sbEmpresaContrato || ']'  );
                END IF;
            ELSE

                IF sbEmpresaFuncionario IS NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => 'El funcionario[' || nuFuncionario || '] no está asociado a ninguna empresa'  );
                END IF;

                IF sbEmpresaContrato IS NULL THEN
                    pkg_error.setErrorMessage( isbMsgErrr => 'El contrato[' || nuContrato || '] no está asociado a ninguna empresa'  );
                END IF;
                
            END IF;
        
        ELSE
            pkg_traza.trace('El usuario[' || nuUsuario  ||']Id Funcionario[' || nuFuncionario || '] está excluido de la validación', csbNivelTraza );
        END IF;
    
    ELSE
        pkg_error.setErrorMessage( isbMsgErrr => 'No se pudo obtener el usuario que registra la nota'  );
    END IF;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
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
