SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
    
    --ADM_PERSON: Se migro el objeto al esquema ADM_PERSON      
    UPDATE  master_personalizaciones 
    SET comentario = 'ADM_PERSON'
    WHERE  nombre IN (
                        'LDC_PK_ORCUO'
                        ,'LDC_PK_PRODUCT_VALIDATE'
                        ,'LDC_PKCC_SCM'
                        ,'LDC_PKCONDICIONVISUALIZACION'
                        ,'LDC_PKCOTICOMERCONS'
                        ,'LDC_PKDUPLIFACT'
                        ,'LDC_PKGAPUSSOTECO'                  
                    );    
                    
    --Campo comentario = OPEN: Se quedan en el esquema de OPEN (Obsoletos)     
    UPDATE  master_personalizaciones 
    SET comentario = 'OPEN'
    WHERE  nombre IN (
                        'LDC_PAYMENTFORMATTICKET'
                        ,'LDC_PKDATAFACTNOREG'
                        ,'LDC_PKDATAFACTREG'
                        ,'LDC_PKGESTIONORDENES'
                    );    
                    
    --Campo comentario = BORRADO: Se borro el objeto de la BD     
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN (                    
                        'LDC_PKCAMPANAFNB'
                        ,'LDC_PKCARGALDRVOLU'
                        ,'LDC_PKCARTARISEGU'
                        ,'LDC_PKCM_LECTESP8'
                        ,'LDC_PKCM_LECTESP9'
                        ,'LDC_PKCOMBSOL'
                        ,'LDC_PKG_LDCMOSACA'                        
                        ,'LDC_PKGENECUPOTOTVENCO'
                        ,'LDC_PKGENERANOTAS'
                        ,'LDC_PKGESTIONSIANTT'
                        ,'LDC_PKGESTIONTATTPR'
                        ,'LDC_PKGGECOPRFASIMU'
                        ,'LDC_PKG_PROCVALDATOLEGOT' 
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