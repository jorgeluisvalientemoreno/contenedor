set serveroutput on;
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
BEGIN
    dbms_output.put_line('Actualizar registro en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
    'LDC_RETORAFECHMORFECHA'
    ,'LDC_RETORNAAUI_NIVEL'
    ,'LDC_RETORNACONCIDECAJE'
    ,'LDC_RETORNACUPONCONCIDECAJE'
    ,'LDC_RETORNADIFEROSINIESTRO'
    ,'LDC_RETORNAFLAGASOUNIDPER'
    ,'LDC_RETORNAINTMOFI'
    ,'LDC_RETORNAMEEDADMORA'
    ,'LDC_RETORNAPROMED'
    ,'LDC_SBRETORNACODDANE'
    ,'LDC_SHOW_PAYMENT_ORDERS'
    ,'LDC_TECNICOS_CERTIFICADO'
    ,'LDC_TELE_PREFIJO'
    ,'LDC_TIPO_DE_TELEF'
    ,'LDC_VALIDAORDENINSTANCE'
    ,'LDC_VISUALCONDTER'
    ,'LD_FA_FNU_AREA_TYPE'
    ,'NUTRAEUTLLECTFACT'
    ,'OBTENERSALDORED'
    ,'SBDATEMAXUNO'
    ,'USU_NORMALIZADO_VIGENTE'
    ,'LDC_FRCGETFACTURABYPROG');
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