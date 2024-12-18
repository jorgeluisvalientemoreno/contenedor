set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2779   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
       'DALD_ADITIONAL_FNB_INFO',
        'DALD_CREDIT_QUOTA',
        'DALD_EFFECTIVE_STATE',
        'DALD_EXTRA_QUOTA_FNB',
        'DALD_MANUAL_QUOTA',
        'DALD_MAX_RECOVERY',
        'DALD_NON_BAN_FI_ITEM',
        'DALD_POLICY_BY_CRED_QUOT',
        'DALD_POLICY_HISTORIC',
        'DALD_POLICY_TYPE',
        'DALD_POS_SETTINGS',
        'DALD_PRICE_LIST_DETA',
        'DALD_PRODUCT_LINE',
        'DALD_QUOTA_ASSIGN_POLICY',
        'DALD_RETURN_ITEM',
        'DALD_RETURN_ITEM_DETAIL',
        'DALD_SUBSIDY_DETAIL',
        'DALD_VALIDITY_POLICY_TYPE',
        'DALDC_ATECLIREPO',
        'DALDC_COTIZACION_CONSTRUCT',
        'DALDC_EQUIVA_LOCALIDAD',
        'DALDC_ORDEN_LODPD',
        'DALDC_PROD_COMERC_SECTOR',
        'DALDC_REQCLOSE_CONTRACT',
        'DALDC_SEGMENT_SUSC',
        'DALD_DIS_EXP_BUDGET'
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