PROMPT Crea sinonimo objeto PKG_GE_NOTIFICATION
BEGIN
    -- OSF-3612
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_ge_notification'), UPPER('adm_person'));
END;
/
