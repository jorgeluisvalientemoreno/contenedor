PL/SQL Developer Test script 3.0
66
-- Created on 29/09/2023 by JORGE VALIENTE 
declare
  -- Local variables here
  cursor cuOrdenes is
    select oo.*, rowid
      from open.or_order oo
     where oo.task_type_id in (12150) --(12149, 12150, 12151, 12152, 12153, 10495)
       and oo.order_status_id in (5)
       and oo.operating_unit_id = 3624;

  rfcuOrdenes cuOrdenes%rowtype;

  nuCosto_Estimado number;
  nuValor_asignado number;
  contrato         number;

begin

  select sum(o.estimated_cost), o.defined_contract_id
    into nuCosto_Estimado, contrato
    from open.or_order o
   where o.task_type_id in (12150) --(12149, 12150, 12151, 12152, 12153, 10495)
     and o.order_status_id in (5)
     and o.operating_unit_id = 3624
   group by o.defined_contract_id;

  select gc.valor_asignado
    into nuValor_asignado
    from open. ge_contrato gc
   where gc.id_contrato = contrato;

  dbms_output.put_line('*********************************************************');
  dbms_output.put_line('Costo estimado Total[' || nuCosto_Estimado ||
                       '] - Valor asignado Contrato[' || contrato || ']: ' ||
                       nuValor_asignado);
  dbms_output.put_line('*********************************************************');

  for rfcuOrdenes in cuOrdenes loop
    begin
      or_bofwlockorder.lockorder(inuorderid       => rfcuOrdenes.Order_id,
                                 inucommenttypeid => 1269,
                                 isbcomment       => 'GENERAL',
                                 ibldocommit      => null,
                                 ibllocktoday     => null,
                                 idtchangedate    => sysdate);
    
    exception
      when others then
        dbms_output.put_line(sqlerrm);
    end;
  end loop;

  select gc.valor_asignado
    into nuValor_asignado
    from open. ge_contrato gc
   where gc.id_contrato = contrato;

  dbms_output.put_line('*********************************************************');
  dbms_output.put_line('Costo estimado Total[' || nuCosto_Estimado ||
                       '] - Valor asignado Contrato[' || contrato || ']: ' ||
                       nuValor_asignado);
  dbms_output.put_line('*********************************************************');

  rollback;

end;
0
0
