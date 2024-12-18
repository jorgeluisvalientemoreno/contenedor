column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    nuEjecucionFlujo NUMBER := 0;
  BEGIN
  
    ---1
    BEGIN
      dbms_output.put_line('Ejecucion de instancia -1771366066 del flujo de VENTA DE SERVICIOS DE INGENIERIA 208897353');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');
    
      WF_BOAnswer_Receptor.AnswerReceptor(-1771366066, -- Código de la instancia del flujo
                                          MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    
      commit;
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
  
    ---2
    BEGIN
      dbms_output.put_line('Ejecucion de instancia -1756330967 del flujo de VENTA DE SERVICIOS DE INGENIERIA 210779468');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');
    
      WF_BOAnswer_Receptor.AnswerReceptor(-1756330967, -- Código de la instancia del flujo
                                          MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    
      commit;
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
  
    ---3
    BEGIN
      dbms_output.put_line('Ejecucion de instancia -1755308920 del flujo de VENTA DE SERVICIOS DE INGENIERIA 210901367');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');
    
      WF_BOAnswer_Receptor.AnswerReceptor(-1755308920, -- Código de la instancia del flujo
                                          MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    
      commit;
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
  
    ---4
    BEGIN
      dbms_output.put_line('Ejecucion de instancia -1753631836 del flujo de VENTA DE SERVICIOS DE INGENIERIA 211155546');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');
    
      WF_BOAnswer_Receptor.AnswerReceptor(-1753631836, -- Código de la instancia del flujo
                                          MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    
      commit;
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
  
    ---5
    BEGIN
      dbms_output.put_line('Ejecucion de instancia -1748117520 del flujo de VENTA DE SERVICIOS DE INGENIERIA 211792883');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');
    
      WF_BOAnswer_Receptor.AnswerReceptor(-1748117520, -- Código de la instancia del flujo
                                          MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    
      commit;
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
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

