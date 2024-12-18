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
                        'DLRMTUS'                                            
                        ,'GDO_MATRIZTRANSDETERIO'
                        ,'IC_BOLISIMPROVREV'
                        ,'IC_BSLISIMPROVREV'
                        ,'PKLD_BLOCKED_QUERY'
                        ,'PKLD_CREDIT_BUREAU_QUERY'
                        ,'PKLD_FA_BCAPPLICAPARAM'
                        ,'PKLD_FA_BCGENERALPARAMETERS'
                        ,'PKLD_FA_BCMADESCPRPA'
                        ,'PKLD_FA_BCODETADEPP'
                        ,'PKLD_FA_BCQUERYPDD'
                        ,'PKLD_FA_BCQUERYREFERIDO'
                        ,'PKLD_FA_BCREGISTERSUBSCRIBE'
                        ,'PKLD_FA_BOSUSCRIBEREFER'
                        ,'PKLD_FA_BSDISCOUNTAPPL2'
                        ,'PKLD_FA_BSDISCOUNTAPPLNO'
                        ,'PKLICENSEINFO'
                        ,'PKMO_PACKAGE'
                        ,'PKPARAGENERAL'
                        ,'RQCFG_100236_'
                        ,'RQTY_100238_'
                        ,'RQTY_100266_'
                        ,'UT_EAN_CARDIF3'
                        ,'UT_EAN_CARDIF4'
                        ,'UT_EAN_CARDIF5'  
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