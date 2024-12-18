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
    'LDC_CALCULAEDADMORAPROD',
    'LDC_CANTASIGNADA',
    'LDC_CONSULTACERTVIGTEC',
    'LDC_CONSULTACERTVIGTECFE',
    'LDC_FINPROXCONS',
    'LDC_FNC_ESTADO_CORTE',
    'LDC_FNCRETORDENPADRE',
    'LDC_FNCRETORNAEDADCONSUL',
    'LDC_FNCRETORNAUNIDSOLICITUD',
    'LDC_FNU_CUENTAS_FECHA',
    'LDC_FNUESTADOPERIODO',
    'LDC_FNUGETCATHIST',
    'LDC_FNUGETCATHIST_C',
    'LDC_FNUGETINIQUOTA',
    'LDC_FNUGETULTIMOBLOQUEO');
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