column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
   onuError      NUMBER;
   osbError      VARCHAR2(4000);
   sesion  number;
   nuIdReporte   	NUMBER;
   nuLote  number;
begin
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  
  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
    dbms_output.put_line('Lote creado : '||nuLote);
  Insert into lote_fact_electronica
     select  nuLote CODIGO_LOTE ,
             PERIODO_FACTURACION ,
             ANIO ,
             MES ,
             CICLO ,
             1 CANTIDAD_REGISTRO ,
             CANTIDAD_HILOS ,
             HILOS_PROCESADO ,
             HILOS_FALLIDO ,
             INTENTOS ,
             FLAG_TERMINADO ,
            SYSDATE FECHA_INICIO ,
            SYSDATE FECHA_FIN ,
            null FECHA_INICIO_PROC ,
            null FECHA_FIN_PROC,
            TIPO_DOCUMENTO
    from PERSONALIZACIONES.lote_fact_electronica        
    where CODIGO_LOTE = 4484 ;
        
  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');
  PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( 2142640489,
                                                  nuLote,
                                                   'I',
                                                   1,
                                                   nuIdReporte,
                                                   onuError,
                                                   osbError );
    DBMS_OUTPUT.PUT_LINE(' osbError '||osbError);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/