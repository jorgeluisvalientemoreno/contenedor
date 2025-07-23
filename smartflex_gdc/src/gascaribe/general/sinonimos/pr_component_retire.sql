Prompt Creando sinonimos privados para sobre OPEN.Pr_Component_Retire
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('Pr_Component_Retire'), 'OPEN');
END;
/