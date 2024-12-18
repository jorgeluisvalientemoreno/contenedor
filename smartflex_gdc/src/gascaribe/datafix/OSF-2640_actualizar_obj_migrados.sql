set serveroutput on;
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'LDC_INSACTCALLCENTER'
        );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRACION GASPLUS OSF'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'MIGRACION GASPLUS OSF'
     WHERE  NOMBRE in (
        'PROASIGNAORDENES',
        'PROCREATRAMITES',
        'PROCCREAINDMOVIDIFE',
        'PROACTUALIZADUPLICADOS',
        'PROCQUITAESPACIOSOSF',
        'NCPERIDEFE',
        'MODIFYRECUPERADO',
        'MODIFYCARGPECOTEMP',
        'MODIFYCARGPECO',
        'PREELEMMEDI');

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''OPEN'' (DEJAR EN OPEN) en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'OPEN'
     WHERE  NOMBRE in (
        'DEPURE_LDC_ORDER',
        'ACTUALIZARCARTERAPORCONCEPTO',
        'LDC_SENDEMAIL_V2',
        'PRAVANZASECUENCIAINSTANCI',
        'PRGETINFOCONTASOLIC',
        'GETINFORMACLIENSOLIC',
        'GETPACKAGES',
        'PROVALIDACONTRATISTARECAUDO',
        'FIACC_VALIDA',
        'OPT_ADM_USER',
        'LDC_EXPORT_REPORT_EXCEL',
        'LDC_ENVIAMAIL',
        'LDC_SENDEMAIL'
        );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;      
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''OPEN'' (OBSOLETOS) en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'OPEN'
     WHERE  NOMBRE in (
        'PROC_LEGALIZAOTEJECUTADAS',
        'LDC_PROCGENERAPROYECDIFERIDO2',
        'LDC_PROCGENERAPROYECDIFECAP',
        'LDC_PROCGENERAPROYECDIFE',
        'LDC_GEN_OT_INTERVE_VTA_EMPAQ',
        'LDC_GEN_OT_INTERVE_FNB',
        'LDC_PRCREAPLANTNOTI',
        'OS_EMERGENCY_ORDER'
        );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/