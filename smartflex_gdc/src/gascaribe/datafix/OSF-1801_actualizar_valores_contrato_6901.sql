column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  --valor asignado= ordenes en estado 5,6,7
  cursor cuValorAsignado(Contrato number) is
    select sum(nvl(oo.estimated_cost,0)) valor_asignado
      from open.or_order oo
     where oo.defined_contract_id = Contrato
       and oo.order_status_id in (5, 6, 7);

  cursor CuContrato(Contrato number) is
    select gc.* from open. ge_contrato gc where gc.id_contrato = Contrato;

  rfCuContrato CuContrato%rowtype;

  nuValorAsignado    number;
  nuValorNoLiquidado number;
  nuValorLiquidado   number;

  nuContrato number;

begin

  nuContrato := 6901;
  open cuValorAsignado(nuContrato);
  fetch cuValorAsignado
    into nuValorAsignado;
  close cuValorAsignado;

  open CuContrato(nuContrato);
  fetch CuContrato
    into rfCuContrato;
  if CuContrato%found then
    dbms_output.put_line('Contrato: ' || rfCuContrato.id_contrato);
    dbms_output.put_line('               Valor Asignado Contrato (Anterior): ' ||
                         rfCuContrato.Valor_asignado ||
                         ' - Valor Asignado OT (Nuevo): ' ||
                         nuValorAsignado);
  
    begin
      update ge_contrato gc
         set gc.valor_asignado     = nuValorAsignado
       where gc.id_contrato = rfCuContrato.id_contrato;
      commit;
    exception
      when others then
        dbms_output.put_line('Error actualizando data del contrato ' ||
                             nuContrato || sqlerrm);
        rollback;
    end;
  end if;
  close CuContrato;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

