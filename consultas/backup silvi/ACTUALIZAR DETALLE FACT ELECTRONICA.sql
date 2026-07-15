DECLARE
   onuError      NUMBER;
   osbError      VARCHAR2(4000);
   sesion  number;
   nuIdReporte   NUMBER;
begin
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                            'Job de facturacion electronica recurrente');
  PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( 2132265479,
                                                   602,
                                                   'I', --A para update 
                                                   2,
                                                   nuIdReporte,
                                                   onuError,
                                                   osbError );
DBMS_OUTPUT.PUT_LINE(' osbError '||osbError);
commit;
end;
