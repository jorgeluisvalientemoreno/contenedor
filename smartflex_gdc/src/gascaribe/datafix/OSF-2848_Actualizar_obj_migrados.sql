set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2848   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN


    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'LDC_ACTUAPERICOSE',
        'LDC_APTEMPERATURAS',
        'LDC_BCCHANGEQUOTAVALUE',
        'LDC_BCDELETECHARGEDUPL',
        'LDC_BCDELETECHARGES',
        'LDC_BCPKASEM',
        'LDC_BO_GESTUNITPER'
   );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT; 
    --
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'LD_BOEXECUTEDRELMARKET',
        'LD_BOOSSCOMMENT',
        'LD_BOOSSPOLICY',
        'LD_BOREADINGORDERDATA',
        'LD_REPORT_GENERATION_2',
        'LD_REPORT_GENERATION_4',
        'LD_REPORT_GENERATION_8',
        'LDC_ACTA2_PRU',
        'LDC_ACTPRODRP',
        'LDC_ANULAITEMMATERIAL',
        'LDC_BCACTACONSTRUCTORAS',
        'LDC_BCEJECUTAR_FUNCION',
        'LDC_BCFORMATO_COTI_COM',
        'LDC_BCREGEREVIPERI_TMP',
        'LDC_BO_SUBSCRIBERXID',
        'LDC_BOACTA',
        'LDC_BOACTUALIZAVARIABLES',
        'LDC_BOARCHIVOFTP'   );

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
  
PROMPT **** Termina actualizar registro entidad master_personalizaciones**** 
PROMPT =========================================

set timing off
set serveroutput off
/