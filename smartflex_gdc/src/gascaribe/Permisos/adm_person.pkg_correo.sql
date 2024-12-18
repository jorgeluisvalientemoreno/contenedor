Prompt Otorgando permisos sobre pkg_Correo
BEGIN
    pkg_utilidades.prAplicarPermisos( upper('pkg_Correo'), 'ADM_PERSON');
    
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON ADM_PERSON.pkg_Correo TO REXEINNOVA';
    
END;
/
