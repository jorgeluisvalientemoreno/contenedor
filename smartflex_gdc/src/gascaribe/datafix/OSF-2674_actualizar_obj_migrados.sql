SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
    
    --Campo comentario = MIGRADO ADM_PERSON: Se migro el objeto al esquema ADM_PERSON     
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'LDC_CAMBIOESTADO'
                        ,'LDC_CANCEL_ORDER'
                        ,'LDC_OS_INSADDRESS'
                        ,'LDC_OS_REASSINGORDER'
                        ,'LDC_OS_REGISTERNEWCHARGE'
                        ,'LDC_PRREGISTERNEWCHARGE'
                        ,'LDCPROCCREAREGISTROTRAMTAB'
                        ,'OS_GETQUOTABRILLA'
                        ,'OS_PEPRODSUITRCONNECTN'
                        ,'PROVAPATAPA' 
                        ,'LDC_DISTSALDFAVOCLIECAST'
                     );   
    
    --Campo comentario = BORRADO: Se borro el objeto de la BD                
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'AJUSTARORDENPAGOANULADO'
                        ,'LDC_AJUSTARORDENPAGOANULADO'
                        ,'LDC_CUPOBRILLA'                        
                        ,'LDC_LEGALIZAACTIAPOYOCONFIG'
                        ,'LDC_PLUGINBORRAMARCA101'
                        ,'LDC_PROCESSLDRPLAM'
                        ,'LDC_PROCVALDESMONTE'
                        ,'LDC_REGISTER_DATOS_ACTUALIZAR'
                        ,'LDCFTABLE_PROCESAR'
                        ,'LDCPROCVALLEGREPPRPTXML'
                        ,'PRGENERATEVISITAIDENCERTBYCAT'
                        ,'PROCESSLDGAVBR'
                        ,'PROINFOADICIONALCONTRATO'
                        ,'PRTEMPORALCHARGE'                                 
                    );
                
    --Campo comentario = NO USAR: Ejecutable en desuso                
    UPDATE  master_personalizaciones 
    SET comentario = 'NO USAR'
    WHERE  nombre IN (
                        'LDGAVBR' 
                        ,'LDC_FTABLE'
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