Prompt Creando sinonimos privados para sobre ADM_PERSON.pkg_BCValida_tt_local
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('pkg_BCValida_tt_local'), 'ADM_PERSON');
END;
/