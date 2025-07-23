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
      dbms_output.put_line('Ejecucion de instancia 267913380 del flujo de Venta de Gas por Formulario 183442782');
      errors.Initialize;
      ut_trace.Init;
      ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
      ut_trace.SetLevel(0);
      ut_trace.Trace('INICIO');
    
      
      ---Retirar Instancia de orden anulada
      update open.Or_Order_Activity ooa
        set ooa.instance_id = null
      where ooa.package_id = 183442782
        and ooa.order_id = 253495740;
      
      commit;
      dbms_output.put_line('Retirar Instancia de orden 253495740 anulada.');

      
      WF_BOAnswer_Receptor.AnswerReceptor(267913380, -- Código de la instancia del flujo
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

