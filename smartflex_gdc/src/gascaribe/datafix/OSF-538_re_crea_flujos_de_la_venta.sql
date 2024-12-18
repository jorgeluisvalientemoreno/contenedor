column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Declare

Begin
  -- Solicitud 27291492
  insert into open.wf_instance_trans (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GEOMETRY, GROUP_ID, EXPRESSION, EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, STATUS)
  values (355507739, 215773106, 215773107, null, 0, 'FLAG_VALIDATE == 0', 0, 'Se cumpli? la Fecha de Espera', 1, 'Y', 1);

  insert into open.wf_instance_trans (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GEOMETRY, GROUP_ID, EXPRESSION, EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, STATUS)
  values (355507738, 215773107, 215773104, '572220822220', 0, 'CAUSAL == EXITO', 0, 'Instalaci?n', 1, 'Y', 1);
  -- Solicitud 27291280
  insert into open.wf_instance_trans (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GEOMETRY, GROUP_ID, EXPRESSION, EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, STATUS)
  values (355531739, 215770617, 215770618, null, 0, 'FLAG_VALIDATE == 0', 0, 'Se cumpli? la Fecha de Espera', 1, 'Y', 1);

  insert into open.wf_instance_trans (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GEOMETRY, GROUP_ID, EXPRESSION, EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, STATUS)
  values (355531738, 215770618, 215770615, '572220822220', 0, 'CAUSAL == EXITO', 0, 'Instalaci?n', 1, 'Y', 1);
  --
  commit;
  --
Exception
  When others then
    rollback;
    dbms_output.put_line('Error : ' || sqlerrm);
End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/