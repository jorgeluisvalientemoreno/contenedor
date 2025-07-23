column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
   nuIdReporte NUMBER;
   onuError    NUMBER; 
   osbError  VARCHAR2(4000);
    
   cursor cuDatos is
   SELECT factura_elect_general.codigo_lote lote, notas.notanume,notas.notafecr, facturas_emitidas.*
   FROM open.notas, OPEN.factura_elect_general, open.facturas_emitidas
   WHERE facturas_emitidas.tipo_documento in (1,2) 
     AND facturas_emitidas.documento = (notafact)
     AND factura_elect_general.codigo_lote IN (5682, 5678, 5684)
     AND factura_elect_general.tipo_documento = 3 
     AND factura_elect_general.documento  = (notanume)
     AND NOT EXISTS ( SELECT 1 
                      FROM open.facturas_emitidas fm 
                      WHERE fm.CODIGO_LOTE =factura_elect_general.codigo_lote 
                         AND fm.tipo_documento = factura_elect_general.tipo_documento 
                         AND fm.documento = factura_elect_general.documento );
  nuLote NUMBER;
BEGIN
 
   nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
    dbms_output.put_line('Lote creado : '||nuLote);
  Insert into lote_fact_electronica
     SELECT  nulote codigo_lote ,
             periodo_facturacion ,
             anio ,
             mes ,
             ciclo ,
             49 cantidad_registro ,
             cantidad_hilos ,
             hilos_procesado ,
             hilos_fallido ,
             intentos ,
             flag_terminado ,
            sysdate fecha_inicio ,
            sysdate fecha_fin ,
            NULL fecha_inicio_proc ,
            NULL fecha_fin_proc,
            tipo_documento
    FROM personalizaciones.lote_fact_electronica        
    WHERE codigo_lote = 5682 ;
    
  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');
  FOR reg IN cuDatos LOOP
      onuError := 0;
      DELETE FROM facturas_emitidas
      WHERE codigo_lote = reg.codigo_lote AND tipo_documento = reg.tipo_documento AND documento = reg.documento  ;
      PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( reg.notanume,
                                                      reg.lote,
                                                       'A',
                                                       3,
                                                       nuIdReporte,
                                                       onuError,
                                                       osbError );
       IF onuError = 0 THEN         
          INSERT INTO facturas_emitidas(codigo_lote ,tipo_documento ,documento ,factura_electronica,fecha_emision)
           VALUES (reg.codigo_lote ,reg.tipo_documento ,reg.documento ,reg.factura_electronica,reg.fecha_emision);
           
           UPDATE lote_fact_electronica SET cantidad_registro = cantidad_registro  - 1
           WHERE codigo_lote = reg.lote;
           
           UPDATE factura_elect_general SET codigo_lote = nuLote
           WHERE factura_elect_general.codigo_lote = reg.lote 
             AND tipo_documento = 3 
             AND documento = reg.notanume;
            dbms_output.put_line('Se proceso nota '||reg.notanume );
       ELSE
          dbms_output.put_line('Error en  proceso nota '||reg.notanume|| osbError);
          ROLLBACK;      
          EXIT;
       END IF;
  END LOOP;
  commit;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR NO CONTROLADO '||SQLERRM);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/