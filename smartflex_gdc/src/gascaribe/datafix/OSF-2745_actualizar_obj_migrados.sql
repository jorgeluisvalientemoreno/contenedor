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
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'DALDC_IMCOSEEL'
                        ,'DALDC_IPLI_IO'
                        ,'DALDC_ITEM_OBJ'
                        ,'DALDC_ITEMS_CONEXIONES'
                        ,'DALDC_LDC_ACTI_UNID_BLOQ'
                        ,'DALDC_LDC_SCORHIST'
                        ,'DALDC_LV_LEY_1581'
                        ,'DALDC_MACOMCTT'
                        ,'DALDC_PKGMANTGRUPLOCA'
                        ,'DALDC_PKGMANTGRUPO'
                        ,'DALDC_PLANTEMP'
                        ,'DALDC_PROGRAMAS_VIVIENDA'
                        ,'DALDC_PROMO_FNB'
                        ,'DALDC_PROVEED_INSTAL_FNB'
                        ,'DALDC_RECLAMOS'
                        ,'DALDC_REGIASOBANC'
                        ,'DALDC_RESOGURE'
                        ,'DALDC_RESPUESTA_CAUSAL'
                        ,'DALDC_RETROACTIVE'
                        ,'DALDC_TASKACTCOSTPROM'         
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