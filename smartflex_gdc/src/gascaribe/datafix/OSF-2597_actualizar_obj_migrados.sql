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
    'LDC_PROGENNOVOFERTSENSEVAESCA',
    'LDC_PROGOAVC',    
    'LDC_PRVALMETROSHIJA',    
    'LDC_PRVISITAFALLLIDA',
    'LDC_VAINSLDSENDAUTHORI',
    'LDC_VALIDA_DATO_ADI_MED_ADIC',
    'LDC_VALIDA_FECHA_ASIGNACION',
    'LDC_VALIDA_ORASAR',
    'LDC_VALIDCHECKITEMS',
    'LDC_VALPERC_ORDCARGOCONEC',
    'LDCDESENDNOTIFI',
    'LDCPLCONSREDEXTPOLSA',
    'LDCPROCDELETMARCAUSERCERTIFI',
    'PR_UPDATE_DATA_INSURED');

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
     'LDC_PROGRAMORDTOUNLOCK',
     'LDC_PROGORDTOUNLOCKTRABVAR',
     'LDC_UNLOCKORDERS',
     'LDC_PRVALPORDVENT',
     'LDC_PBORDVENT',
     'PROCESSLIQCONTRADMIN',    
     'PROCGENERAASIGNACION1'
    );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;

    dbms_output.put_line('Actualizar registro COMENTARIO = ''OPEN'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'OPEN'
     WHERE  NOMBRE in (
     'LDC_PRSETUBGECLIENTE'
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