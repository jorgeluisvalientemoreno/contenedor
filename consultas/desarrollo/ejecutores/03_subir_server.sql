DECLARE
    nuexit number;
    sboutput varchar2(32764);
BEGIN
    --ge_bosystemprocessmonitor.startserver(nuexit,sboutput);
    --GE_BOPROCESS_SERVER.Startserver(nuexit,sboutput);
    GE_BOPROCESS_SERVER.SETSERVERUP();
    dbms_output.put_Line(sboutput);
END;
/