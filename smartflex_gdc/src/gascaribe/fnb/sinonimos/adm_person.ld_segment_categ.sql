PROMPT Crea sinonimo objeto dependiente LD_SEGMENT_CATEG
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_SEGMENT_CATEG FOR LD_SEGMENT_CATEG';
END;
/