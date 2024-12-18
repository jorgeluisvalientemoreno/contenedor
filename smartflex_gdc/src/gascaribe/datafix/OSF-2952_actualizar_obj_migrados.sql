SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
                        
    --Campo comentario MIGRADO ADM_PERSON: Se migro el objeto al esquema ADM_PERSON   
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (    
                        'LDC_PGENERATEBILLPREP'
                        ,'LDC_PKDATAFIXUPDEDDOCU'
                        ,'LDC_PKDATOSVISTAMATERIALIZADA'
                        ,'LD_BOOSSPOLICY'
                        ,'LD_BOREADINGORDERDATA'
                        ,'LDC_BCFORMATO_COTI_COM'
                        ,'LD_BOOSSCOMMENT'
                        ,'LDC_BO_SUBSCRIBERXID'
                        ,'LDC_BOFWCERTFREVPERIOD'
                        ,'LDC_BOPACKAGE'
                        ,'LDC_BOPICONSTRUCTORA'
                        ,'LDC_BOPICOTIZACOMERCIAL'
                        ,'LDC_BOSUBSCRIPTION'
                        ,'LDC_BOUBIGEOGRAFICA'
                        ,'LDC_PKLDCCO'
                        ,'PGK_LDCAUTO1'
                        ,'PKG_LDCGRIDLDCAPLAC'
                        ,'LDC_PKMETROSCUBICOS'
                        ,'LDCCERTIFICATEACCOUNT'
                        ,'LDC_PKTARIFATRANSITORIA'
                        ,'GDO_REPORTECONSUMOS'
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