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
                        'LDC_REPORTESPROCESO'
                        ,'LDC_REPPLANOATECLIE'
                        ,'LDC_RPT_LDRVACN'
                        ,'LDC_UIFCDCRG'
                        ,'LDC_UIFGRCG'
                        ,'LDC_UIFMAREG'
                        ,'LDC_UILDCIDO'
                        ,'LDC_VAL_NOTAS_CICLO_5402'
                        ,'LDC_VAL_NOTAS_CICLO_5402V2'
                        ,'LDCCERTIFICATEACCOUNT'
                        ,'LDCPKGGENPRECUPONCOTIZA'
                        ,'LDCX_PKBINCAJASBRILLA'
                        ,'LDCX_PKCLIENTESBRILLA'
                        ,'LDCX_PKORDENESBRILLA'
                        ,'OPENSYSTEMS_ORDERS_'
                        ,'ORDSO_'
                        ,'PACKTEST'
                        ,'PGK_LDCAUTO1'
                        ,'PK_CARGAPLANTILLAS'
                        ,'PK_LDCLODPD'
                        ,'PKCARGUE_DEU_POLIANU'
                        ,'PKG_EMAILS'
                        ,'PKG_LDCCREASOLIVIORDP'
                        ,'PKG_LDCGRIDLDCAPLAC'
                        ,'PKGSERVICIOCLIENTE'
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