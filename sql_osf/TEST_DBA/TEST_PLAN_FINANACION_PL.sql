declare

  inuorderid      number := 391214253;
  inupackageid    number := 236619516;
  onufinanplanid  number;
  onuquotasnumber number;
begin

  DBMS_OUTPUT.ENABLE(10000000);
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

  dbms_output.put_line('inuorderid: ' || inuorderid);
  dbms_output.put_line('inupackageid: ' || inupackageid);

  ldc_bcfinanceot.getfinancondbyprod(inuorderid,
                                     inupackageid,
                                     onufinanplanid,
                                     onuquotasnumber);

  dbms_output.put_line('onufinanplanid: ' || onufinanplanid);
  dbms_output.put_line('onuquotasnumber :' || onuquotasnumber);

end;
/
