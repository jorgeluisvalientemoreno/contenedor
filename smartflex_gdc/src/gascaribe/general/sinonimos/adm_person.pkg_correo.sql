Prompt Creando sinonimos privados para pkg_Correo
BEGIN
    pkg_utilidades.prCrearSinonimos('PKG_CORREO', 'ADM_PERSON');
    
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM INNOVACION.PKG_CORREO FOR ADM_PERSON.PKG_CORREO';

END;
/