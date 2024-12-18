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
                        'DALDC_ACTBLOQ'
                        ,'DALDC_ANALISIS_DE_CONSUMO'
                        ,'DALD_NOTIFICATION'
                        ,'DALD_PROD_LINE_GE_CONT'
                        ,'DALD_REL_MAR_GEO_LOC'
                        ,'DALD_REL_MARK_BUDGET'
                        ,'DALD_REL_MARKET_RATE'
                        ,'DALD_RESOL_CONS_UNIT'
                        ,'DALD_SEGMEN_SUPPLIER'
                        ,'DALD_SEGMENT_CATEG'
                        ,'DALD_SHOPKEEPER'
                        ,'DALD_SUPPLI_MODIFICA_DATE'
                        ,'DALD_ZON_ASSIG_VALID'
                        ,'DALDC_BUDGET'
                        ,'DALDC_BUDGETBYPROVIDER'
                        ,'DALD_POLICY_STATE'
                        ,'DALD_RENEWALL_SECURP'
                        ,'DALD_REP_INCO_SUB'
                        ,'DALDC_ARCHASOBANC'
                        ,'DALDC_ATRIASOBANC'
                        ,'DALDC_IMCOSEEL'
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