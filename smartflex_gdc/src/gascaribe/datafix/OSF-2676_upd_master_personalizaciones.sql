SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
DECLARE

    cursor updMP 
    IS
    select nombre
    from master_personalizaciones    
    WHERE comentario = 'CIERRE';
    
BEGIN
    dbms_output.put_line('Actualizacion registros en master_personalizaciones');
    
    dbms_output.put_line('Campo comentario = ''CIERRE COMERCIAL'' objetos indicados en notas del caso');  
    UPDATE master_personalizaciones
    SET
        comentario = 'CIERRE COMERCIAL'
    WHERE
        nombre IN ( 'LDC_PRCIERDIFEH9', 'LDC_PRCIERDIFEH8', 'LDC_PRCIERDIFEH7', 'LDC_PRCIERDIFEH5', 'LDC_PRCIERDIFEH6',
                    'LDC_PRCIERDIFEH3', 'LDC_PRCIERDIFEH4', 'LDC_PRCIERDIFEH2', 'LDC_PRCIERDIFEH10', 'LDC_PRCIERDIFEH1',
                    'LDC_PRACTUALIZASESUCIER', 'LDC_RECREA_DIFE_CIERRE', 'LDC_PROCCARTLINEA_H12', 'LDC_PROCCARTLINEA_H11', 'LDC_PROCCARTLINEA_H10',
                    'LDC_PROCCARTLINEA_H9', 'LDC_PROCCARTLINEA_H8', 'LDC_PROCCARTLINEA_H7', 'LDC_PROCCARTLINEA_H6', 'LDC_PROCCARTLINEA_H5',
                    'LDC_PROCCARTLINEA_H4', 'LDC_PROCCARTLINEA_H3', 'LDC_PROCCARTLINEA_H2', 'LDC_PROCCARTLINEA_H1', 'LDC_PROGENCIERFACT_GDC',
                    'LDC_PROGENCIERRE_GDC', 'LDC_PROCARTLINRES', 'LDC_PROCIERREDIARUSUAFACTVENC', 'LDC_PROCRECUCARTCONCDIARIA_PRO', 'LDC_PROCRESUMENSESUCIEROTRO',
                    'LDC_LLENASESUCIER_H12', 'LDC_PROCCALCAMORDIFCORR', 'LDC_PROCCALCAMORDIFNOCORR', 'LDC_PROCGENERAPROYECDIFERIDO', 'LDCGESCOBPREJUMEARCH',
                    'LDCEJEDIFCLPL', 'LDC_CONSULTAPERCIER', 'LDCMOSACACASTI', 'LDC_LLENADIFERIDO_H8', 'LDC_LLENADIFERIDO_H9',
                    'LDC_LLENADIFERIDO_H6', 'LDC_LLENADIFERIDO_H7', 'LDC_LLENADIFERIDO_H5', 'LDC_LLENADIFERIDO_H4', 'LDC_LLENADIFERIDO_H3',
                    'LDC_LLENADIFERIDO_H2', 'LDC_LLENADIFERIDO_H10', 'LDC_LLENADIFERIDO_H1', 'LDC_CARTCASTIGADA_CIERRE_GDC', 'LDC_PROCGENPROYEMADCAR',
                    'LDC_PROCCARTCONCCIERRE_DB_GDC', 'LDC_PROCCARTCONCCIERRE_DB_OT', 'LDC_PROCCARTCONCCIERRE_DBOTGDC', 'LDC_PROCRECUCARTCONCDIARIA',
                    'LDCUSUADIFCARTLICUENCOB',
                    'LDC_PROREGCALCAMORTMESAMES', 'LDC_PROCREGERRORPROC', 'LDC_PROCCARGDATDIFERIDO', 'LDC_PROCACTUDATSESU', 'LDC_CIER_PRORECUPAPERIODOCONT',
                    'LDC_PRORETORNAFECHAVALCIERR' );
                    
    dbms_output.put_line('Campo comentario = ''CIERRE COMERCIAL'' objetos con comentario ''CIERRE'':');
    FOR rec in updMP loop
        dbms_output.put_line(rec.nombre);
    end loop;    
    
    UPDATE master_personalizaciones
    SET comentario = 'CIERRE COMERCIAL'
    WHERE comentario = 'CIERRE';
                        
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registros en master_personalizaciones, '||sqlerrm);
END;
/
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/