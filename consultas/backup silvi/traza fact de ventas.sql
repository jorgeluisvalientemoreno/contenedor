--set SERVEROUTPUT ON;
DECLARE
   sesion  number;
begin
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
   pkg_UtilFacturacionElecGen.prCrearProcMasivoVenta;
end;
/
