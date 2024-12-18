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
                        'PKEXPREG'
                        ,'IC_BOCOMPLETSERVICEINT'
                        ,'LD_BOQUERYFNB'
                        ,'LDC_BCCOTIZACIONCOMERCIAL'
                        ,'LDC_BOARCHIVO'
                        ,'LDC_BOMANAGEADDRESS'
                        ,'PKLD_FA_REFERIDO'
                        ,'LDC_PKGENOTADIFE'
                        ,'FTP'
                        ,'LDC_BCPROYECTOCONSTRUCTORA'
                        ,'LDC_PKGENERATRAMITERP'
                        ,'LD_BOFUN_VALI_ENTI_CO_UN'
                        ,'LDC_PKGASIGNARCONT'
                        ,'LD_BOSEQUENCE'
                        ,'LD_BOUTILFLOW'
                        ,'LD_BOVAR_VALIDATE_CO_UN'
                        ,'LDC_REPORTESCONSULTA'
                        ,'LDC_EMAIL'
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