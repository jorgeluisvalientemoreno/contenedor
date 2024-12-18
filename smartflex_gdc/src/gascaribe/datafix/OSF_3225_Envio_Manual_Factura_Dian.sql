column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
   onuError      NUMBER;
   osbError      VARCHAR2(4000);
   nuIdReporte   	NUMBER;
   nuCodLote NUMBER;
begin
  nuCodLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.nextval ;
  INSERT INTO lote_fact_electronica
  select nuCodLote CODIGO_LOTE ,
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
        sysdate FECHA_INICIO ,
        sysdate FECHA_FIN ,
        null FECHA_INICIO_PROC ,
        null FECHA_FIN_PROC,
        TIPO_DOCUMENTO
    from lote_fact_electronica
    where codigo_lote = 350;
  
  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');
  
  
  PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( 2138096962,
                                                  nuCodLote,
                                                   'I',
                                                   1,
                                                   nuIdReporte,
                                                   onuError,
                                                   osbError );
  IF onuError = 0 THEN
     COMMIT;
  ELSE 
     DBMS_OUTPUT.PUT_LINE(' osbError '||osbError);
    ROLLBACK;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    pkg_error.seterror;
    pkg_error.geterror(onuError, osbError); 
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE(' osbError '||osbError);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
