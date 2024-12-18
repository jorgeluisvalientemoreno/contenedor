Prompt Otorgando permisos sobre pkg_Correo
BEGIN
    pkg_utilidades.prAplicarPermisos( upper('pkg_Correo'), 'PERSONALIZACIONES');
END;
/
