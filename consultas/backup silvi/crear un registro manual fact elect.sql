Insert into lote_fact_electronica
select SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL CODIGO_LOTE ,
112793 PERIODO_FACTURACION ,
2024 ANIO ,
7 MES ,
5502 CICLO ,
 1 CANTIDAD_REGISTRO ,
4 CANTIDAD_HILOS ,
4 HILOS_PROCESADO ,
0 HILOS_FALLIDO ,
0 INTENTOS ,
'N' FLAG_TERMINADO ,
SYSDATE FECHA_INICIO ,
SYSDATE FECHA_FIN ,
null FECHA_INICIO_PROC ,
null FECHA_FIN_PROC,
1 TIPO_DOCUMENTO
from DUAL;

DECLARE
   onuError        NUMBER;
   osbError        VARCHAR2(4000);
   sesion  number;
   nuIdReporte     NUMBER;
   nuLote       NUMBER:=2;
   nuTipoDocumento   NUMBER:=1;
  
  cursor cuFacturas is
   select factcodi
   from  factura
   where factcodi in (2136717763);
begin
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  
  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');
  DBMS_OUTPUT.PUT_LINE('factura|error');
  for reg in cuFacturas loop
    onuError :=0 ;
    osbError :='';
    PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( reg.factcodi,
                             nuLote,
                             'I',
                             nuTipoDocumento,
                             nuIdReporte,
                             'GDCA',
                             'N',
                             onuError,
                             osbError );
  DBMS_OUTPUT.PUT_LINE(reg.factcodi||'|'||osbError);
  if onuError = 0 then
    commit;
  else
    rollback;
  end if;
  end loop;
end;
