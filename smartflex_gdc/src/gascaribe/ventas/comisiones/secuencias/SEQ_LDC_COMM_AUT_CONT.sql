DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1) into nuTab1
    from dba_objects
    where object_name = 'SEQ_LDC_COMM_AUT_CONT';

    IF (nuTab1=0) THEN

        execute immediate 'CREATE SEQUENCE SEQ_LDC_COMM_AUT_CONT
                         INCREMENT BY 1
                         START WITH 1
                         MAXVALUE 999999999999999
                         NOCYCLE';
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/