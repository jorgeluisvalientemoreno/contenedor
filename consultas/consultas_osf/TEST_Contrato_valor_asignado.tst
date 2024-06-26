PL/SQL Developer Test script 3.0
21
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  ibldocommit boolean := sys.diutil.int_to_bool(:ibldocommit);
  ibllocktoday boolean := sys.diutil.int_to_bool(:ibllocktoday);
begin

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);  

  -- Call the procedure
  or_bofwlockorder.lockorder(inuorderid => :inuorderid,
                             inucommenttypeid => :inucommenttypeid,
                             isbcomment => :isbcomment,
                             ibldocommit => ibldocommit,
                             ibllocktoday => ibllocktoday,                             
                             idtchangedate => :idtchangedate);
                             
                             rollback;
end;
6
inuorderid
1
234466208
4
inucommenttypeid
1
1269
3
isbcomment
1
GENERAL
5
ibldocommit
0
3
ibllocktoday
0
3
idtchangedate
1
29/09/2023
12
0
