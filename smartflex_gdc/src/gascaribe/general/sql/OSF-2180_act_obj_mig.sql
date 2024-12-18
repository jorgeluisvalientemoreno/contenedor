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
    'FDTFECHA',
    'FNCVALICERTTECNASIGNACIRE',
    'FNCVALIDACERTTECNASIGNACI',
    'FNUAPLICAENTREGA',
    'FNUCUOTAINICIALCOM',
    'FNUEXISTE_MEDIDOR_ROLLOUT',
    'FNUGETTTOTRECONE',
    'FNU_LDC_GETSALDCONC',
    'FNUSUBS935',
    'FNUTIPOSUSPROLLOUT',
    'FNUVALIDAACTIVIDADROLUNIDAD',
    'FNUVALPROPERSCA',
    'FSBEDADCARTDIFERIDOS',
    'FSBGETMTSTUBERIAHIJAS',
    'FSFUNCIONVALLDCISOMA',
    'FSFUNCIONVALLDCISOMA');
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