DECLARE
    nuTab1 number := 0;
    nuseq   number;

BEGIN

    select count(1) into nuTab1
    from sa_tab
    where aplica_executable = 'LDCIMINCON'
    and tab_name = 'MENU_OBJECT_500000000002616'
    and process_name = 'LDCLCTOICL';
    
    IF (nuTab1=0) THEN
        nuseq := ge_bosequence.fnugetnextvalsequence('SA_TAB','SEQ_SA_TAB');
        INSERT INTO SA_TAB
        (TAB_ID, TAB_NAME, PROCESS_NAME, APLICA_EXECUTABLE, PARENT_TAB, TYPE, SEQUENCE, ADDITIONAL_ATTRIBUTES, CONDITION)
        VALUES (nuseq,'MENU_OBJECT_500000000002616','LDCLCTOICL','LDCIMINCON',null,null,12,null,null);
        dbms_output.put_line('Insert del tab LDCLCTOICL');
    END IF;
    
    commit;
    
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;
/