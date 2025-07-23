column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Incia OSF-4150 !');

  MERGE INTO OPEN.LDC_PROCEDIMIENTO_OBJ A USING
 (SELECT
  12122 as TASK_TYPE_ID,
  NULL as CAUSAL_ID,
  'OAL_ACTUALIZASUBCATEGORIA' as PROCEDIMIENTO,
  'ACTUALIZA CATEGORIA Y SUBCATEGORIA' as DESCRIPCION,
  1 as ORDEN_EJEC,
  'S' as ACTIVO
  FROM DUAL) B
ON (A.TASK_TYPE_ID = B.TASK_TYPE_ID)
WHEN NOT MATCHED THEN 
INSERT (
  TASK_TYPE_ID, CAUSAL_ID, PROCEDIMIENTO, DESCRIPCION, ORDEN_EJEC, 
  ACTIVO)
VALUES (
  B.TASK_TYPE_ID, B.CAUSAL_ID, B.PROCEDIMIENTO, B.DESCRIPCION, B.ORDEN_EJEC, 
  B.ACTIVO)
WHEN MATCHED THEN
UPDATE SET 
  A.CAUSAL_ID = B.CAUSAL_ID,
  A.PROCEDIMIENTO = B.PROCEDIMIENTO,
  A.DESCRIPCION = B.DESCRIPCION,
  A.ORDEN_EJEC = B.ORDEN_EJEC,
  A.ACTIVO = B.ACTIVO;
dbms_output.put_line('Fin OSF-4150 !');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/