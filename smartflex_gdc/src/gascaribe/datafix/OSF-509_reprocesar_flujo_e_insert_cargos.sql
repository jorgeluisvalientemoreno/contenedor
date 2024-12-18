DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
BEGIN
    -- Re-procesamos el flujo detenido solicitud 178087243
    Begin
        errors.Initialize;
        ut_trace.Init;
        ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
        ut_trace.SetLevel(0);
        ut_trace.Trace('INICIO');

        --se notifican las ventas que tienen todas sus órdenes legalizadas, para que continuen
        WF_BOAnswer_Receptor.AnswerReceptor(50824643, MO_BOCausal.fnuGetSuccess);--se pasa el codigo del flujo

        commit;

        dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);

    EXCEPTION
       when OTHERS then
            dbms_output.put_line('Error Flujo 50824643 : '||sqlerrm);
    End;
    
    -- Re-procesamos el flujo detenido solicitud 178087343
    Begin
        errors.Initialize;
        ut_trace.Init;
        ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
        ut_trace.SetLevel(0);
        ut_trace.Trace('INICIO');

        --se notifican las ventas que tienen todas sus órdenes legalizadas, para que continuen
        WF_BOAnswer_Receptor.AnswerReceptor(50826393, MO_BOCausal.fnuGetSuccess);--se pasa el codigo del flujo

        commit;

        dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);

    EXCEPTION
       when OTHERS then
            dbms_output.put_line('Error Flujo 50826393 : '||sqlerrm);
    End;

    -- Insertamos los cargos de la venta anulada 179600537
    Begin

        INSERT INTO OPEN.CARGOS VALUES (3010873219,52288937,137,53,'DB',98499,16726,'PP-179600537',7890945695,1,'A',0,'11/01/2022 03:26:02',20,null,98474,1,88034,1944);
        INSERT INTO OPEN.CARGOS VALUES (3010873219,52288937,674,53,'DB',98499,88034,'PP-179600537',7890945693,1,'A',0,'11/01/2022 03:26:02',20,null,98474,1,88034,2569);
        INSERT INTO OPEN.CARGOS VALUES (3010873219,52288937,19,53,'DB',98499,588524,'PP-179600537',7890945694,1,'A',0,'11/01/2022 03:26:02',20,null,98474,1,588524,2567);

        commit;
    EXCEPTION
       when OTHERS then
            rollback;
            dbms_output.put_line('Error insert: '||sqlerrm);
    End;        

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/