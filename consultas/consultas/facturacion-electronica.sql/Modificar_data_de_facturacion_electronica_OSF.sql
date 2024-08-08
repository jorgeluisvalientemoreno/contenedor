--Eliminar  registro primero de factura_elect_general
delete from  factura_elect_general where codigo_lote = 4647 and documento = 2136290980;


-- Cambiar consecutivo de factura , COLOCARLE FACTURA, Codigo de lote y tipo de documento
set SERVEROUTPUT ON;
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
  PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( 2136290980,
                                                  4647,
                                                   'I',
                                                   1,
                                                   nuIdReporte,
                                                   onuError,
                                                   osbError );
DBMS_OUTPUT.PUT_LINE(' osbError '||osbError);
commit;
end;

--Consultar la secuencia y el valor ingresar en el update de codigo de lote 
select personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.nextval from dual 


--Insert y update  
insert into lote_fact_electronica
select personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.nextval CODIGO_LOTE ,
PERIODO_FACTURACION ,
ANIO ,
MES ,
CICLO ,
1 CANTIDAD_REGISTRO ,
CANTIDAD_HILOS ,
HILOS_PROCESADO ,
HILOS_FALLIDO ,
INTENTOS ,
'S' FLAG_TERMINADO ,
FECHA_INICIO ,
FECHA_FIN ,
null FECHA_INICIO_PROC ,
null FECHA_FIN_PROC, 
tipo_documento 
from lote_fact_electronica
where codigo_lote = 4647;

update factura_elect_general set codigo_lote = 4747
where codigo_lote = 4647 and documento = 2136290980;


--Consultar fechas de ejecución del job de osf 
SELECT *
FROM dba_scheduler_jobs
WHERE  JOB_NAME  IN ('JOB_FACTURACION_ELECGEN','JOB_NOTAS_FACTELECGEN','JOB_VENTAS_ELECGEN');

