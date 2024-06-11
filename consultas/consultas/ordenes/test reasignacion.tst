PL/SQL Developer Test script 3.0
14
declare
 sesion number;
begin
  -- Call the procedure
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  ld_boreassignorders.reassign(inuorderid => :inuorderid,
                               inudesoperunit => :inudesoperunit);
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);                               
end;
2
inuorderid
1
﻿107162980
4
inudesoperunit
1
2834
4
0
