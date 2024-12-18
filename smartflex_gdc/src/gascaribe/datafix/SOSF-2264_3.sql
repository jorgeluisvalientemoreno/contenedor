column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

    cursor cuDatos is
    select d.package_id,
       i.instance_id
    from open.wf_data_external d
    inner join open.wf_instance i on i.plan_id=d.plan_id and i.unit_type_id=100221 and status_id=4
    where d.package_id in (209996065,209996060,209996057,209996062,209996061,209996066,209996064,209996063,
                          209996067,209996059,209996034,209996035,209996030,209996038,209996032,209996033,209996031,209996036,209996037) ;

BEGIN
    dbms_output.put_line('Solicitud|Error');

    UPDATE OPEN.CC_SALES_FINANC_COND
    SET INTEREST_PERCENT=37.56,
    VALUE_TO_FINANCE=695084,
    INITIAL_PAYMENT=125000,
    AVERAGE_QUOTE_VALUE=29513
    WHERE PACKAGE_ID IN (209996065,209996060,209996057,209996062,209996061,209996066,209996064,209996063,
                          209996067,209996059,209996034,209996035,209996030,209996038,209996032,209996033,209996031,209996036,209996037);

    commit;

    for reg in cuDatos loop
      begin
        errors.Initialize;
        ut_trace.Init;
        ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
        ut_trace.SetLevel(0);
        ut_trace.Trace('INICIO');

        --se notifican las ventas que tienen todas sus ordenes legalizadas, para que continuen
        WF_BOAnswer_Receptor.AnswerReceptor(reg.instance_id, MO_BOCausal.fnuGetSuccess);

        commit;
        dbms_output.put_line(reg.package_id  ||'|'|| 'ok');
     Exception
       When others then
         Errors.setError;
         Errors.getError(nuErrorCode, sbErrorMessage);
         dbms_output.put_line(reg.package_id  ||'|'|| 'fail');
      End;
    end loop;

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

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/