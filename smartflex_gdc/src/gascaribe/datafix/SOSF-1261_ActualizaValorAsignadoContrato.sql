column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuvalorasignado is
    SELECT SUM(Valor_orden) Valor_Total_Asignado_ordenes
        FROM (select oo.order_id,
              (nvl(oo.estimated_cost, 0)) Valor_orden
            from open.or_order_Activity ooa,
              open.or_order          oo
            where ooa.order_id = oo.order_id
            and oo.order_status_id in (5, 6, 7)
            and oo.defined_contract_id = 9241);       

   nuvalor_asignado ge_contrato.valor_asignado%type;

BEGIN

  open cuvalorasignado;
  fetch cuvalorasignado into nuvalor_asignado;
  close cuvalorasignado;

  update open.ge_contrato co set valor_asignado =  nvl(nuvalor_asignado,0) WHERE co.id_contrato = 9241;

  Commit;
  dbms_output.put_line('Actualizacion valor asignado del contrato 9241 a su nuevo valor de ' || nvl(nuvalor_asignado,0));


exception
  when others then
  rollback;
  dbms_output.put_line('No pudo actualizar valor asignado del contrato 9241 - ' || SQLERRM);

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/