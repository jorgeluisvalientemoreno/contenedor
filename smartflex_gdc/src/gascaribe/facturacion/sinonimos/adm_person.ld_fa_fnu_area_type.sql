PROMPT Crea sinonimo a la funciOn ld_fa_fnu_area_type
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ld_fa_fnu_area_type FOR ADM_PERSON.ld_fa_fnu_area_type';
END;
/