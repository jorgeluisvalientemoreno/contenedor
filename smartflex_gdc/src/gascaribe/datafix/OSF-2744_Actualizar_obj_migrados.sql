set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Mayo 2024 
    JIRA:           OSF-2744   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in ('DALDC_FECH_ESTAD_DEU_PROD' );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
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
        'DALDC_IMCOMAEL'
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