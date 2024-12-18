set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2813   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
       'DALD_BINE_FINA_ENT',
        'DALD_CATALOG',
        'DALD_CAUS_REV_SUB',
        'DALD_CAUSAL',
        'DALD_CAUSAL_TYPE',
        'DALD_CO_UN_TASK_TYPE',
        'DALD_CONCEPTO_REM',
        'DALD_CREG_RESOLUTION',
        'DALD_DETAIL_NOTIFICATION',
        'DALD_DIS_EXP_BUDGET',
        'DALD_DOCUMENT_TYPE',
        'DALD_EQUIVALENCE_LINE',
        'DALD_FINAN_PLAN_FNB',
        'DALD_FNB_WARRANTY',
        'DALD_HIST_ITEM_WO_OR',
        'DALD_INDEX_IPP_IPC',
        'DALD_LAUNCH',
        'DALD_LINE',
        'DALD_LIQUIDATION_TYPE',
        'DALD_MAR_EXP_BUDGET',
        'DALDC_CA_BONO_LIQUIDARECA',
        'DALDC_CA_LIQUIDAEDAD',
        'DALDC_CA_LIQUIDARECA',
        'DALDC_CA_OPERUNITXRANGOREC',
        'DALDC_CA_RANGPERSCAST',
        'DALDC_CAPILOCAFACO',
        'DALDC_CCXCATEG',
        'DALDC_CMMITEMSXTT',
        'DALDC_COLL_MGMT_PRO_FIN',
        'DALDC_COMI_TARIFA',
        'DALDC_COMISION_PLAN',
        'DALDC_CONDIT_COMMERC_SEGM',
        'DALDC_CONSTRUCTION_SERVICE',
        'DALDC_CONTRA_ICA_GEOGRA',
        'DALDC_ESTACION_REGULA',
        'DALDC_FINAN_COND',
        'DALDC_IMCOELLO',
        'DALDC_IMCOELMA',
        'DALDC_IMCOMAEL',
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
        'DALDCI_TRANSOMA'     );

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