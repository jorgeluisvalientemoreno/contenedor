SET SERVEROUTPUT ON;
declare
  onuError   NUMBER;
  osbError   VARCHAR2(4000);
begin
  pkg_UtilFacturacionElecGen.prCrearProcMasivo;
 DBMS_OUTPUT.PUT_line(osbError);
exception
  when others then
     pkg_error.seterror;
     pkg_error.geterror(onuError, osbError);
      DBMS_OUTPUT.PUT_line(' osbError '||osbError);
end;
/

--JOB_FACTURACION_ELECGEN