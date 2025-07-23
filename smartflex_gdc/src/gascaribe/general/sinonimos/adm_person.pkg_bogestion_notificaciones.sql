PROMPT Crea sinonimo objeto PKG_BOGESTION_NOTIFICACIONES
BEGIN
    -- OSF-3612
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_bogestion_notificaciones'), UPPER('adm_person'));
END;
/
