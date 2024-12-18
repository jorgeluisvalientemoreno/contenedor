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
                        'LD_BOFILEBLOCKED'
                        ,'LD_SERVICES_PERSON'
                        ,'LDC_BCGESTIONREEXO'
                        ,'LDC_BCGESTIONREEXO2'
                        ,'LDC_BCORDENCONCILACION'
                        ,'LDC_BOGESTIONREEXO'
                        ,'LDC_BOGESTIONREEXO2'
                        ,'LDC_BOLDCGCAUC'
                        ,'LDC_BOORDENCONCILACION'
                        ,'LDC_BOREVOKEORDER'
                        ,'LDC_BSGESTIONREEXO'
                        ,'LDC_DSCM_VAVAFACO'
                        ,'LDC_GENCOMIASESORVTA'
                        ,'LDC_OR_BOORDER'
                        ,'LDC_PKDIRECO'
                        ,'LDC_PKGESTIONORDENES'
                        ,'LDC_PKINITLDRERLE'
                        ,'LDC_PKLDRERLE'
                        ,'LDC_PKRECNOSIN'
                        ,'LDC_PKREPORTEFIFAP'
                        ,'LDCPKFLCJ'                       
                        ,'PKG_MAIL_BASE'                        
                        ,'PKLD_FA_BSDISCOUNTAPPL'
                        ,'PKLD_FA_BSDISCOUNTAPPL2'
                        ,'PKLD_FA_BSDISCOUNTAPPLNO'
                        ,'PKLD_FA_DETAREFE'
                        ,'CEDR'
                        ,'FPMFE'
                        ,'LDC_PBLDCRVPCON'
                        ,'LDCFLCJ'
                        ,'LDCGCAUC'
                        ,'LDCGREEX'
                        ,'LDCRCB'
                        ,'LDRDRC'
                        ,'LDURNS'
                        ,'LD_FA_DETAREFE'
                        ,'LDC_REPEINGR'
                    );
                    
                    
    --Campo comentario = BORRADO: Se borro el objeto de la BD     
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (    
                        'LDC_PKFLUNOTATECLI'
                        ,'LDC_PKGOTSSINCOBSINGAR'
                        ,'PE_BOGENCONTRACTOBLIG'
                        ,'PE_BOVALPRODSUITRCONNECTN'
                        ,'PE_BSGENCONTRACTOBLIG'
                        ,'PKGRABALOGSEGPRO'
                        ,'PE_BSVALPRODSUITRCONNECTN'
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