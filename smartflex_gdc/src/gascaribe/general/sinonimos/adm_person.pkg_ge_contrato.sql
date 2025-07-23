Prompt Creando sinonimos privados para sobre adm_person.pkg_ge_contrato
BEGIN
    -- OSF-4010
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ge_contrato'), upper('adm_person'));
 
END;
/
Prompt Creando sinonimos privado multiempresa.pkg_ge_Contrato sobre adm_person.pkg_ge_contrato
BEGIN
    -- OSF-4010
    EXECUTE IMMEDIATE ('create or replace synonym multiempresa.pkg_ge_Contrato for adm_person.pkg_ge_Contrato');
END;
/