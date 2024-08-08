declare
  cursor cuOrden is
    select oo.*
      from open.or_order_activity ooa, open.or_order oo
     where oo.order_id = ooa.order_id
       and oo.task_type_id = 12149
       and oo.order_status_id in (5)
       and ooa.package_id = 195263154;
  rfcuOrden       cuOrden%rowtype;
  contador        number;
  onuerrorcode    number;
  osberrormessage varchar2(4000);
begin
  contador := 1;
  for rfcuOrden in cuOrden loop
    BEGIN
      DBMS_SCHEDULER.CREATE_JOB(job_name   => 'BLOQUEO_ORDEN_' || contador,
                                job_type   => 'PLSQL_BLOCK',
                                job_action => 'DECLARE
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);
BEGIN
  errors.Initialize;
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);
  ut_trace.Trace(''INICIO'');
  os_lockorder(inuorderid      => '|| rfcuOrden.order_id ||',
               inucommenttype  => 1296,
               isbcomment      => ''Bloqueo Orden'',
               idtchangedate   => sysdate,
               onuerrorcode    => nuErrorCode,
               osberrormessage => sbErrorMessage);
  if nuErrorCode = 0 then
    commit;
  else
    rollback;
  end if;
  dbms_output.put_line(''SALIDA onuErrorCode: '' || nuErrorCode);
  dbms_output.put_line(''SALIDA osbErrorMess: '' || sbErrorMessage);
EXCEPTION
  when ex.CONTROLLED_ERROR then
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line(''ERROR CONTROLLED '');
    dbms_output.put_line(''error onuErrorCode: '' || nuErrorCode);
    dbms_output.put_line(''error osbErrorMess: '' || sbErrorMessage);
    when OTHERS then Errors.setError;
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line(''ERROR OTHERS '');
    dbms_output.put_line(''error onuErrorCode: '' || nuErrorCode);
    dbms_output.put_line(''error osbErrorMess: '' || sbErrorMessage);
END;',
                                start_date => sysdate,
                                auto_drop  => TRUE,
                                enabled    => TRUE,
                                comments   => 'Job Bloqueo Orden ' ||
                                              rfcuOrden.order_id);
      dbms_output.put_line('Job BLOQUEO_ORDEN_' || contador || ' - Orden: ' ||rfcuOrden.order_id);
    exception
      when others then
        dbms_output.put_line('Error: ' || sqlerrm);
    END;
    contador := contador + 1;
  end loop;
end;
