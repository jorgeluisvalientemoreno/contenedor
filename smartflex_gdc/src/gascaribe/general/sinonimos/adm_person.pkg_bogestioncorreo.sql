Prompt Creando sinonimos privados para pkg_bogestioncorreo
BEGIN
    pkg_utilidades.prCrearSinonimos( 'PKG_BOGESTIONCORREO', 'ADM_PERSON');
    
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM INNOVACION.PKG_BOGESTIONCORREO FOR ADM_PERSON.PKG_BOGESTIONCORREO';
    
END;
/