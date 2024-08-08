PL/SQL Developer Test script 3.0
9
declare
 sesion number;
begin
  -- Call the procedure
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  ldc_uisolxml.process;
end;
0
7
MO_BOUNCOMPOSITIONCONSTANTS.CNUEVENT_PRE_EXPRESSION
NUBEFOREEXPRESSION
INUEXPRESSION
SBATTRIBUTE
ISBATTRIBUTE
ISBINSTANCE
ISBENTITY
