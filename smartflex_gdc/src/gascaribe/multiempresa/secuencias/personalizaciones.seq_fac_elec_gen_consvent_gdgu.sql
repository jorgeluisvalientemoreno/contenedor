DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1) into nuTab1
    from dba_objects
    where object_name = 'SEQ_FAC_ELEC_GEN_CONSVENT_GDGU';

    IF (nuTab1=0) THEN

        EXECUTE IMMEDIATE 'CREATE SEQUENCE PERSONALIZACIONES.SEQ_FAC_ELEC_GEN_CONSVENT_GDGU 
                            START WITH 1
                            INCREMENT BY 1
                            MINVALUE 1
                            MAXVALUE 9999999999
                            NOCYCLE NOCACHE';  	    
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
  GRANT SELECT ON PERSONALIZACIONES.SEQ_FAC_ELEC_GEN_CONSVENT_GDGU TO SYSTEM_OBJ_PRIVS_ROLE;
/
