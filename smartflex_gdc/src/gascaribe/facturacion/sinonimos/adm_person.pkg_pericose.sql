Prompt Creando sinonimos privados 
BEGIN
    -- OSF-3970
    pkg_Utilidades.prCrearSinonimos(upper('pkg_pericose'), upper('adm_person'));
END;
/