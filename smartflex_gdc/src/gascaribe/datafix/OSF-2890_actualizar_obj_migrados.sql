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
                        'LDC_PKGGECOPRFAV2'
                        ,'LDC_PKGGECOPRFAV3'
                        ,'LDC_PKGGECOPRFAV4'
                        ,'LDC_PKGGENORDADMOVILES'
                        ,'LDC_PKGLIQUIDANOREGULADOS'
                        ,'LDC_PKGMIGRAATRIBUINSTANCIA'
                        ,'LDC_PKGOSFFACTURE2'
                        ,'LDC_PKGRENORMOV'
                        ,'LDC_PKGREVERDIFERIDO'
                        ,'LDC_PKITEMSSERIADOS'
                        ,'LDC_PKLDCCAIPA'
                        ,'LDC_PKLDCCO'
                        ,'LDC_PKLDCRPACERP'
                        ,'LDC_PKLDRBDTV'
                        ,'LDC_PKLDRERLE'
                        ,'LDC_PKMETROSCUBICOS'
                        ,'LDC_PKORMUSUARIOSSINFACTURA'
                        ,'LDC_PKTARIFATRANSITORIA'
                        ,'LDC_PKTRASFNB_3'
                        ,'LDC_PKTRDIFSUBACTE'
                        ,'LDC_PKUTILORM'
                        ,'LDC_REMARCAPRODUCTO'
                        ,'LDC_REPLEYFACTURACION'
                        ,'LDC_REPLEYSEGAUD'
                        ,'LDC_REPORTE_LEY'
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