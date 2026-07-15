DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
BEGIN
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');

    --se notifican las ventas que tienen todas sus �rdenes legalizadas, para que continuen
    --no idea cual es la diferencia pero el segundo lo usamos para empujar una interacción que estaba detenida 
    --en "espera de solicitudes hijas", ya que con el primero no avanzaba.
    WF_BOAnswer_Receptor.AnswerReceptor(1130931168, MO_BOCausal.fnuGetSuccess);--se pasa el codigo del flujo
    WF_BOAnswer_Receptor.Answerreceptorbyqueue(-1617274713,MO_BOCausal.fnuGetSuccess);
    

    commit;

    dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);


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