declare
    nuerror ge_error_log.error_log_id%TYPE;
    sberror ge_error_log.description%TYPE;
begin
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    ut_trace.Trace('INICIO');
    nuerror := pkConstante.EXITO;
    LDC_BOASIGAUTO.PRASIGNACION
    (
        null
    );
    dbms_output.put_line('Finalizo sin error');
    dbms_output.put_line('Mensaje '||sberror);
exception
    when others then
        pkerrors.geterrorvar(nuerror,sberror);
        dbms_output.put_line('Error Exception '||sberror);
end;
