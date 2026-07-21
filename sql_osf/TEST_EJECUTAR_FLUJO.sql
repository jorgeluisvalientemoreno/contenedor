begin
  DECLARE
    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    nuEjecucionFlujo NUMBER := 0;
  BEGIN
  
    BEGIN
    
      dbms_output.put_line('Ejecucion de instancia -1639031695 del flujo de Interaccion 223940694');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');

      --Forma 1
      WF_BOAnswer_Receptor.AnswerReceptor(-1589402095, -- Código de la instancia del flujo
                                          MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    
      
      --Forma 2
      /*WF_BOAnswer_Receptor.Answerreceptorbyqueue(-1639031695, -- Código de la instancia del flujo
                                                 MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo*/
      COMMIT;
    
      dbms_output.put_line('SALIDA onuErrorCode: ' || nuErrorCode);
      dbms_output.put_line('SALIDA osbErrorMess: ' || sbErrorMessage);
    
    EXCEPTION
      when ex.CONTROLLED_ERROR then
        nuEjecucionFlujo := 1;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
        dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
      when OTHERS then
        nuEjecucionFlujo := 1;
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
        dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    END;
  
  END;
end;
