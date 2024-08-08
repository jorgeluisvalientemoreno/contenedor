-- Created on 29/09/2023 by JORGE VALIENTE 
declare
  -- Local variables here
  cursor cuOrdenes is
    select oo.*
      from open.or_order oo, open.Or_Order_Activity ooa
     where oo.order_id = ooa.order_id
       and ooa.package_id = 200271871
       and oo.order_status_id = 11;

  rfcuOrdenes cuOrdenes%rowtype;

  nuCosto_Estimado number;
  nuValor_asignado number;
  contrato         number;

  nuONUERRORCODE    number;
  sbOSBERRORMESSAGE varchar2(4000);
	
begin

  select sum(oo.estimated_cost), oo.defined_contract_id
    into nuCosto_Estimado, contrato
    from open.or_order oo, open.Or_Order_Activity ooa
   where oo.order_id = ooa.order_id
     and ooa.package_id = 200271871
     and oo.order_status_id = 11
   group by oo.defined_contract_id;

  if contrato is null then
    contrato := 6801;
  end if;

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
      OS_UNLOCKORDER(INUORDERID      => rfcuOrdenes.Order_id,
                     INUCOMMENTTYPE  => 1296,
                     INUCOMMENT      => 'GENERAL',
                     IDTCHANGEDATE   => sysdate,
                     ONUERRORCODE    => nuONUERRORCODE,
                     OSBERRORMESSAGE => sbOSBERRORMESSAGE);
    
      if nuONUERRORCODE = 0 then
        commit;
        dbms_output.put_line('Orden ' || rfcuOrdenes.Order_id ||
                             ' desbloqueda');
      else
        rollback;
        dbms_output.put_line('Error orden ' || rfcuOrdenes.Order_id ||
                             ' -  ' || sbOSBERRORMESSAGE);
      end if;
    exception
      when others then
        rollback;
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

end;
