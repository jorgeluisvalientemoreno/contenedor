set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Mayo 2024 
    JIRA:           OSF-2675   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'LDC_PRMARCAPRODUCTOLOG',
        'LDC_PROCREAREGASIUNIOPREVPER',
        'LDC_PROACTUALIZAESTAPROG',
        'LDC_PROINSERTAESTAPROG',
        'LDC_PRGENERECOCMRP');

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO- FRAMEWORK OPEN'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO - FRAMEWORK OPEN'
     WHERE  NOMBRE in (
        'LDC_LDRREPDIRCOBRO' );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'GETCOSIGNERINFO',
        'ACTUALIZA_PROCEJEC',
        'PROGRAMA_LDC_LDRREPDIRCOBRO',
        'LDC_PARAMEJECUTAPROCNOVE',
        'LDC_PRLEGALIZAOTFNB',
        'LDCI_PROATTENDESOLICFINAN',
        'PRORECTECUNIDADDIG1',
        'LDC_PRRETURNAGENCY',
        'LDC_REPORTE_SUI',
        'PE_SAVE_ECOACTCONTRACT',
        'LDC_PROCSUBSCONTRIB',
        'PRC_MTTO_NOTFLOG',
        'LDC_PROVALIPCOMERPERIANO',
        'PROVAPATAPAGENERAL',
        'PROGUARDADESASIGOTTEC',
        'PRORECTECUNIDADDIG',
        'PRORETPERIFACT',
        'LDCI_PRTRAMARECAUDO',
        'PROCCONSESTADOSCUENTACONTRATOS',
        'LDC_DETAL_DIRCOBRO',
        'LDC_ENCAB_DIRCOBRO', 
        'LDCI_ATEND_SOLICI_FINAN_MOVIL',
        'LDC_REPORTESUI_TMP',
        'LDC_OSF_SUBS_CONTR',
        'LDC_PER_COMERCIAL',
        'LDC_PER_COMERCIAL_AUD',
        'LDC_PER_COMERCIAL_TRG01',
        'LDC_PER_COMERCIAL_TRG02',
        'LDCFNU_VENANOACTUAL',
        'LDCFNU_VENANODIREC');

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
  
PROMPT **** Termina actualizar registro entidad master_personalizaciones**** 
PROMPT =========================================

set timing off
set serveroutput off
/