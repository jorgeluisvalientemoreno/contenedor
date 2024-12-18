column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
  nuErrorCode      NUMBER;
  sbErrorMessage   VARCHAR2(4000);
  nuEjecucionFlujo NUMBER := 0;
BEGIN
    -- Empujar Flujo solicitud de devolución 211816843
    BEGIN
    dbms_output.put_line('Ejecucion de instancia del flujo de Anulacion');
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');
  
    WF_BOAnswer_Receptor.AnswerReceptor(-1747962895,-- Código de la instancia del flujo
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
  ---------------------
    -- Empujar Flujo solicitud de devolución 211816828
    BEGIN
      dbms_output.put_line('Ejecucion de instancia del flujo de Anulacion');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');

      WF_BOAnswer_Receptor.AnswerReceptor(-1747962895,-- Código de la instancia del flujo
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
  ---------------------

  END;

  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/