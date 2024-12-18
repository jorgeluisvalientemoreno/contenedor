DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1) into nuTab1
    from dba_objects
    where object_name = 'SEQ_CONF_UO_USU_ESPECIALES';

    IF (nuTab1=0) THEN

        execute immediate 'CREATE SEQUENCE SEQ_CONF_UO_USU_ESPECIALES
                         INCREMENT BY 1
                         START WITH 1
                         MAXVALUE 999999999999999
                         NOCYCLE
                         NOCACHE';
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/