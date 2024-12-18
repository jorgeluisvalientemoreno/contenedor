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
                        'LDC_BSGESTIONREEXO'
                        ,'LDC_CT_BOORDERREVOKE'
                        ,'LDC_DETALLEFACT_GASCARIBEV2'
                        ,'LDC_DSCATEGORI'
                        ,'LDC_DSPLANDIFE'
                        ,'LDC_DSSERVICIO'
                        ,'LDC_FINANRECO'
                        ,'LDC_FORMPAGO_PARCIAL'
                        ,'LDC_FUNCIONES_PARA_ORMS'
                        ,'LDC_GENERA_XML_SERASO'
                        ,'LDC_IMPESTADOCUENTA'
                        ,'LDC_INFOREPCARFNB'
                        ,'LDC_ITEM_DESPLAZAMIENTO'
                        ,'LDC_MASSIVEBRLEGALIZA'
                        ,'LDC_MUES_ALEATORIA'
                        ,'LDC_OOP_PRUEBAS'
                        ,'LDC_PAYMENTFORMAT'
                    );
                    
                    
    --Campo comentario = BORRADO: Se borro el objeto de la BD     
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (    
                        'LDC_BSGESTIONTARIFAS'
                        ,'LDC_CARGUEINFOCONTRA'
                        ,'LDC_ELIMINAREXCLUSION'
                        ,'LDC_MATBLOQANILLO'
                        ,'LDC_PAKGENFORMCOTI'
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