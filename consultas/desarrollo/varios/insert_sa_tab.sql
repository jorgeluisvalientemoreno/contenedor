DECLARE
    nuTab1 number := 0;
    nuTab2 number := 0;
    nuseq   number;

BEGIN

    IF (nuTab1=0) THEN
        nuseq := ge_bosequence.fnugetnextvalsequence('SA_TAB','SEQ_SA_TAB');
       dbms_output.put_line('Insert del tab P_REGISTRO_DE_INCIDENTE_308');
       INSERT INTO SA_TAB
        (TAB_ID, TAB_NAME, PROCESS_NAME, APLICA_EXECUTABLE, PARENT_TAB, TYPE, SEQUENCE, ADDITIONAL_ATTRIBUTES, CONDITION)
        VALUES (nuseq,'PRODUCT','P_REGISTRO_DE_INCIDENTE_308','CNCRM',Null,Null,0,Null,null);
    ELSE
        dbms_output.put_line('Existe el tab P_REGISTRO_DE_INCIDENTE_308');
    END IF;

    -----------------------------------------------------------------------------------------------------

   -- commit;

END;

/