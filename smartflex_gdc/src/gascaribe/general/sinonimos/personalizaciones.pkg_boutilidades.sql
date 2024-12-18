Prompt Creando sinonimos privados para personalizaciones sobre adm_person.pkg_boUtilidades
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM personalizaciones.pkg_boUtilidades FOR ADM_PERSON.pkg_boUtilidades';
END;
/
