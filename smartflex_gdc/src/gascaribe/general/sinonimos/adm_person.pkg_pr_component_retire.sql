Prompt Creando sinonimos privados para sobre adm_person.pkg_pr_component_retire
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('pkg_pr_component_retire'), 'ADM_PERSON');
END;
/