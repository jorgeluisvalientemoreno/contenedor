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
        'LDCPROCGENORDENAPOYO',
        'LDC_PRCONUNOPSUP',
        'LDC_PRSETSUBSIDIOS',
        'LDC_PROCGENPROYEMADCARETA',
        'PRGUARDATMPCAUSAL',
        'PORUPDATESTATUSDOCORD',
        'LDCINSLDCLOGERRORRSUI',
        'LDC_PROCREVNOVEDADESNUEESLIQ',
        'LDC_PROCCONTDOCUVENT',
        'LDC_PROCONFMAXMINITEMS',
        'LDCPROINSPRODRED');

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'LDCPLAUPTCOMENORDE',
        'LDC_LLENASESUCIER_H1_TEMP',
        'LDC_CREAR_ORDEN',
        'LDC_VALIDAFECHAEJECUCION',
        'LDC_PROCCAMBTT12457A10450',
        'LDC_PRREVCONSCRIT',
        'LDC_PRVALDATCAMBCLIENT',
        'LDC_PRVALFECHVENCFACTU',
        'PRACTCAUSCARGOSREVDIF1',
        'PRACTCAUSCARGOSREVDIF2',
        'PRGENERANORTASPRONTOPAGO',
        'LDC_PRREGISTERPRODUCT',
        'LDC_PRDATADEUDORCODEUDORPU',
        'LDC_LOGAUDICLIEN597'
        );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''OPEN'' (DEJAR EN OPEN) en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'OPEN'
     WHERE  NOMBRE in (
        'LDC_DBA_PRC_CLS_ERROR_LOG'
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