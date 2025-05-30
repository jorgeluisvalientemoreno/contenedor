DECLARE

  OnuPackage_id number;
  onuMotiveId   number;
  onuerror      number;
  OsbError      number;

begin
  -- Call the procedure

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);
  LDC_BO_GESTIONSUSPSEG.prGeneSuspSeguridad(6619296,
                                            58222,
                                            110,
                                            96,
                                            457,
                                            'documento pruebas',
                                            OnuPackage_id,
                                            onuMotiveId,
                                            onuerror,
                                            OsbError);

  dbms_output.put_line('OnuPackage_id:' || OnuPackage_id);
  dbms_output.put_line('onuMotiveId:' || onuMotiveId);
  dbms_output.put_line('onuerror:' || onuerror);
  dbms_output.put_line('OsbError:' || OsbError);

end;
