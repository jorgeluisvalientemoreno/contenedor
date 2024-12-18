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
                        'LDC_BOGESTIONTARIFAS'
                        ,'LDC_BOPRINTFOFACTCUSTMGR'
                        ,'LDC_DSCC_COMMERCIAL_PLAN'
                        ,'LDC_DSEQUIVA_LOCALIDAD'
                        ,'LDC_DSESTACORT'
                        ,'LDC_DSGE_RECEPTION_TYPE'
                        ,'LDC_DSGE_TIPO_UNIDAD'
                        ,'LDC_PKAJUSTASUSPCONE'
                        ,'LDC_PKG_CAMFEC'
                        ,'LDC_PKGACTUALIZALISCOST'
                        ,'LDC_PKGCAMVAC'
                        ,'LDC_PKGENAJUSMASI'
                        ,'LDC_PKGENEORADI'
                        ,'LDC_PKGENLECTESP'
                        ,'LDC_PKGINFOGESMOV'
                        ,'LDC_PKPAGOSCONSIG'
                        ,'LDC_PKUICARGAPERIODOS'
                        ,'LDC_PKVENTAGAS'
                        ,'LDC_UIAPPROVEDREQUESTS'
                        ,'LDC_UILDCPBLEORD'
                        ,'LDC_UILDRPC'
                        ,'PKACUCARTOT'
                        ,'PKLDCPS'                     
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