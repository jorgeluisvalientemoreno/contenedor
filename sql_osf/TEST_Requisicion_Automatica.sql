declare

  nuErrorCode    number;
  sbErrorMensaje varchar2(4000);

begin

  errors.initialize;
  ut_trace.init;
  ut_trace.Setoutput(ut_trace.cnuTrace_dbms_output);
  ut_trace.Setlevel(99);
  ut_trace.trace('Incio', 1);

  ge_boitemsrequest.CreateAutomaticRequest(1775);

  ut_trace.trace('Fin', 1);

  dbms_output.put_line('Codigo Error: ' || nuErrorCode);
  dbms_output.put_line('Mensaje Error: ' || sbErrorMensaje);
exception
  When others then
    errors.seterror;
    errors.geterror(nuerrorcode, sberrormensaje);
    dbms_output.put_line('Codigo Error: ' || nuErrorCode);
    dbms_output.put_line('Mensaje Error: ' || sbErrorMensaje);
    rollback;
end;
