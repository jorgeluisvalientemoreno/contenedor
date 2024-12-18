set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Mayo 2024 
    JIRA:           OSF-2746   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
       'DALDC_TEMPLOCFACO',
        'DALDC_TIPO_CONSTRUCCION',
        'DALDC_TIPO_TRAB_PLAN_CCIAL',
        'DALDC_TIPOINFO',
        'DALDC_TITRACOP',
        'DALDC_TT_ACT',
        'DALDC_TT_CAUSAL_WARR',
        'DALDC_TT_TB',
        'DALDC_TTP_TTS',
        'DALDC_USERCLOSE_CONTRACT',
        'DALDC_VALIDACION_ACTIVIDADES',
        'DALDC_VALIDATE_RP',
        'DALDC_VARIATTR',
        'DALDC_VARICERT',
        'DALDC_VARIFACOLO',
        'DALDCI_CTAIFRS',
        'DALDCI_NOVDETA',
        'DALDCI_NOVXTITRAB',
        'DALDCI_TIPOINTERFAZ',
        'DALDCI_TRANSOMA'
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
  
PROMPT **** Termina actualizar registro entidad master_personalizaciones**** 
PROMPT =========================================

set timing off
set serveroutput off
/