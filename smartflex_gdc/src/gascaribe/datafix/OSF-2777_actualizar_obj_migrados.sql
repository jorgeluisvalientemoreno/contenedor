SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
    
    --Campo comentario = BORRADO: Se borro el objeto de la BD                
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'DALDC_LOTES_ORDENES'
                        ,'DALDC_METRAJE_PISO'
                        ,'DALDC_METRAJE_TIPO_UNID_PRED'
                        ,'DALDC_ORDENES_DOCU'
                        ,'DALDC_PERILOGC'
                        ,'DALDC_PISO_PROYECTO'
                        ,'DALDC_PKG_OR_ITEM'
                        ,'DALDC_PREMISE_WARRANTY'
                        ,'DALDC_SUSP_PERSECUCION'
                        ,'DALDC_TEMP_BILL_ACUM'
                        ,'DALDC_TIPO_UNID_PRED_PROY'
                        ,'DALDC_TIPO_VIVIENDA_CONT'
                        ,'DALDC_TIPOCAUSALCARDIF'
                        ,'DALDC_TIPOS_TRABAJO_COT'
                        ,'DALDC_TIPOTRAB_COTI_COM'
                        ,'DALDC_TORRES_PROYECTO'
                        ,'DALDC_UNIDAD_PREDIAL'
                        ,'DALDC_UO_BYTIPOINC'
                        ,'DALDC_UO_TRASLADO_PAGO'
                        ,'DALDC_VAL_FIJOS_UNID_PRED'
                        ,'DALDC_VALOR_ADICIONAL_PROY'
                        ,'DALDC_VENTA_EMPAQUETADA'
                        ,'DALDC_VENTA_ESTUFA'
                        ,'DAPE_ECO_ACT_CONTRACT'
                        ,'DALD_APPROVE_SALES_ORDER'     
                    );                                               
                    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/