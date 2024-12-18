Prompt Otorgando permisos sobre pkg_BOGestionCorreo
BEGIN
    pkg_utilidades.prAplicarPermisos( upper('pkg_BOGestionCorreo'), 'ADM_PERSON');

    EXECUTE IMMEDIATE 'GRANT EXECUTE ON ADM_PERSON.pkg_BOGestionCorreo TO ROLE_DESARROLLOOSF';
    
END;
/
