column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  --valor asignado= ordenes en estado 5,6,7
  cursor cuValorAsignado(Contrato number) is
    select sum(nvl(oo.estimated_cost, 0)) valor_asignado
      from open.or_order oo
     where oo.defined_contract_id = Contrato
       and oo.order_status_id in (5, 6, 7);

  cursor CuContrato is
    select gc.*
      from open. ge_contrato gc
     where gc.status = 'AB'
       and gc.id_contratista in (2791, 25, 4809, 19, 2790, 2049)
       and gc.id_contrato in (6801, 6901, 9401, 9421, 9441, 9501);

  rfCuContrato CuContrato%rowtype;

  nuValorAsignado    number;
  nuValorNoLiquidado number;
  nuValorLiquidado   number;

  nuContrato number;

begin

  for rfCuContrato in CuContrato loop
  
    open cuValorAsignado(rfCuContrato.id_contrato);
    fetch cuValorAsignado
      into nuValorAsignado;
    close cuValorAsignado;
  
    dbms_output.put_line('***************************************');
    dbms_output.put_line('Contrato: ' || rfCuContrato.id_contrato ||
                         ' - Contratista: ' || rfCuContrato.id_contratista);
    dbms_output.put_line('Valor Asignado Contrato (Anterior): ' ||
                         rfCuContrato.Valor_asignado ||
                         ' - Valor Asignado OT (Nuevo): ' ||
                         nuValorAsignado);
  
    begin
      update ge_contrato gc
         set gc.valor_asignado = nuValorAsignado
       where gc.id_contrato = rfCuContrato.id_contrato;
      commit;
      dbms_output.put_line('Valor asignado fue actualizado Ok.' ||
                           nuContrato);
    
    exception
      when others then
        dbms_output.put_line('Error actualizando data del contrato ' ||
                             nuContrato);
        rollback;
    end;
  
  end loop;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/