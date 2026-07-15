-- Created on 20/09/2022 by MARIA CARVAL
DECLARE
BEGIN
    pkerrors.traceon;
    pkgeneralservices.SetTraceDataOn;
    UT_Trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    ut_trace.Trace('INICIO');
    --Metodos
    CM_BOREGLECT.GENREADINGACTBYPERIOD;
    --dbms_output.put_line('Error Oracle');
    pkerrors.traceoff;
EXCEPTION
WHEN login_denied THEN
    dbms_output.put_line('Error  ' || substr(pkErrors.fsbGetErrorMessage,1,200));
WHEN others THEN
    dbms_output.put_line('Error Oracle ' ||  substr(sqlerrm,1,200) );
END;


