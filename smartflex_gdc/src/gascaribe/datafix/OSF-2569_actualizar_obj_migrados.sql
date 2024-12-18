set serveroutput on;
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
    'LDC_PROGENERANOVELTYOFERTADOS',
    'LDC_PRUSUARIOS_SUSP_CART', 
    'LDC_PRVALEGAORDENPERSEC',
    'LDC_PRVALIDALECTURASUSP',
    'LDC_SUSPPORRPUSUVENC',
    'LDC_UIATENDEVSALDOFAVOR_PROC',
    'LDC_VALIDA_APTO_RP',
    'LDC_VALIDAIMPEDIMENTOS',
    'LDCCREAFLUJOSRPSUSADMARSOLSAC',
    'LDCCREATETRAMITERECONEXIONXML',
    'LDCI_CRE_CAR_AVA_OBR_VEN_CON', 
    'LDCPROCCREATRAMFLUJSACXML',
    'LDCPROCCREATRAMIFLUJOSPRPXML',
    'PRCOMENTARIOOTREGENERACION', 
    'PRSOLCUPPORWEB' );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
     dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
    'LDCI_REENVIO_MANUAL_FACTELECT', 
    'PROGUARDAASIGOTTECRE'
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