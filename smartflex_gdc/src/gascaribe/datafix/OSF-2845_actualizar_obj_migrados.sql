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
                        'DALDCI_TRSOITEM'
                        ,'DAPE_TASK_TYPE_TAX'
                        ,'EXPRESAR_EN_LETRAS'
                        ,'LD_BCAPPROVE_SALES_ORDER'
                        ,'LD_BCASIGSUBSIDY'
                        ,'LD_BCEXECCONUNISEGDEG'
                        ,'LD_BCEXECUTEDRELMARKET'
                        ,'LD_BCFNBWARRANTY'
                        ,'LD_BCGASSUBSCRIPTION'
                        ,'LD_BCLEGALIZESALE'
                        ,'LD_PK_ACTLISTPRECOFER'
                        ,'LD_UNIT_OPER_INDUS'
                        ,'LDC_AB_BOADDRESSCHANGE'
                        ,'LDC_AB_BOPARSER'
                        ,'LDC_BCIMPRDOCU'
                        ,'LDC_BCREVOKEOTS'
                        ,'LDC_BCSALESCOMMISSION_NEL'
                        ,'LDC_BOCONSTANS'
                        ,'LDC_BODIFERIDOSPASOPREPAGO'
                        ,'PKLD_FA_AUDIACE'
                        ,'PKLD_FA_BCHISTOCADE'
                        ,'LDC_PKG_CHANGSTATESOLICI'                        
                        ,'PKLD_FA_BCLOGPROCDESCPP'
                        ,'LDC_BCCOMMERCIALSEGMENTFNB' 
                    );                             
                    
    UPDATE  master_personalizaciones 
    SET comentario = 'OPEN'
    WHERE  nombre = 'LDC_PKINFOAUDITORIA';                    
                    
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