column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  orderActivityId number := null;
  onuErrorCode    number;
  osbErrorMessage varchar2(4000);

BEGIN

  errors.Initialize;
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(0);
  ut_trace.Trace('INICIO');

  begin
  
    update open.Or_Order_Activity ooa
       set ooa.instance_id = null
     where ooa.order_id = 300884962;
    commit;
    dbms_output.put_line('Instacia de orden 300884962 colocada en NULL.');
  
    WF_BOAnswer_Receptor.AnswerReceptor(1899894289, -- Código de la instancia del flujo
                                        MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo  
    commit;
    dbms_output.put_line('Ejecucion de flujo desde la instacia 1899894289.');
  
  exception
    when others then
      dbms_output.put_line('Error: ' || sqlerrm);
      rollback;
    
  end;

  begin
  
    update open.Or_Order_Activity ooa
       set ooa.instance_id = null
     where ooa.order_id = 300716784;
    commit;
    dbms_output.put_line('Instacia de orden 300716784 colocada en NULL.');
  
    WF_BOAnswer_Receptor.AnswerReceptor(1900321601, -- Código de la instancia del flujo
                                        MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
    commit;
    dbms_output.put_line('Ejecucion de flujo desde la instacia 1900321601.');
  
  exception
    when others then
      dbms_output.put_line('Error: ' || sqlerrm);
      rollback;    
  end;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    Errors.getError(onuErrorCode, osbErrorMessage);
    dbms_output.put_line('ERROR CONTROLLED ');
    dbms_output.put_line('error onuErrorCode: ' || onuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || osbErrorMessage);
    rollback;
  when OTHERS then
    Errors.setError;
    Errors.getError(onuErrorCode, osbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || onuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || osbErrorMessage);
    rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

