declare

  --valor asignado= ordenes en estado 5,6,7
  cursor cuValorAsignado(Contrato number) is
    select sum(oo.estimated_cost) valor_asignado
      from open.or_order oo
     where oo.defined_contract_id = Contrato
       and oo.order_status_id in (5, 6, 7);
  /*select (select sum(oo.estimated_cost) valor_asignado_OT
          from open.or_order oo
         where oo.defined_contract_id = 6901
           and oo.order_status_id in (5, 6, 7)),
       (select gc.valor_asignado
          from open. ge_contrato gc
         where gc.id_contrato = 6901) valor_asignado_Contrato
  from dual;*/

  --valor no liquidado = ordenes legalizadas sin acta
  cursor cuValorNoLiquidado(Contrato number) is
    SELECT sum(nvl(estimated_cost, 0)) VALOR_NO_LIQUIDADO
      FROM open.or_order o
     inner join open.ge_causal gc
        on gc.causal_id = o.causal_id
       and class_causal_id = 1
     WHERE o.order_status_id = 8
       AND o.defined_contract_id = Contrato
       AND o.IS_PENDING_LIQ is not null;
  /*select (select sum(oo.estimated_cost) valor_no_liquidado_OT
          from open.or_order oo
         where oo.defined_contract_id = 6901
           and oo.order_status_id in (8)
           and (select count(1)
                  from open.ct_order_certifica coc
                 where coc.order_id = oo.order_id) = 0),
       (select gc.valor_no_liquidado
          from open. ge_contrato gc
         where gc.id_contrato = 6901) valor_no_liquidado_Contrato
  from dual;*/

  --valor liquidado =  ordenes legalizadas en acta sin importar estado del acta
  cursor cuValorLiquidado(Contrato number) is
    SELECT sum(nvl(gda.valor_total, 0)) VALOR_LIQUIDADO
      FROM open.ge_detalle_acta gda, open.ge_acta ga
     WHERE ga.id_contrato = Contrato
       and ga.id_tipo_acta = 1
       and gda.id_acta = ga.id_acta
       AND gda.affect_contract_val = 'Y';
  /*select (select sum(oo.estimated_cost) valor_liquidado_OT
          from open.or_order oo
         where oo.defined_contract_id = 6901
           and oo.order_status_id in (8)
           and (select count(1)
                  from open.ct_order_certifica coc
                 where coc.order_id = oo.order_id) = 1),
       (select gc.valor_liquidado
          from open. ge_contrato gc
         where gc.id_contrato = 6901) valor_liquidado_Contrato
  from dual;*/

  cursor CuContrato(Contrato number) is
    select gc.* from open. ge_contrato gc where gc.id_contrato = Contrato;

  rfCuContrato CuContrato%rowtype;

  nuValorAsignado    number;
  nuValorNoLiquidado number;
  nuValorLiquidado   number;

  nuContrato number;

begin

  nuContrato := 10524

;
  open cuValorAsignado(nuContrato);
  fetch cuValorAsignado
    into nuValorAsignado;
  close cuValorAsignado;

  open cuValorNoLiquidado(nuContrato);
  fetch cuValorNoLiquidado
    into nuValorNoLiquidado;
  close cuValorNoLiquidado;

  open cuValorLiquidado(nuContrato);
  fetch cuValorLiquidado
    into nuValorLiquidado;
  close cuValorLiquidado;

  open CuContrato(nuContrato);
  fetch CuContrato
    into rfCuContrato;

    dbms_output.put_line('Contrato|Valor Asignado Contrato (Actual)|Valor Asignado OT (Real)|Valor No Liquidado Contrato (Actual)|Valor No Liquidado OT (Real)|Valor Liquidado Contrato (Actual)|Valor Liquidado OT (Real)');

  if CuContrato%found then
    dbms_output.put_line(rfCuContrato.id_contrato||'|'||rfCuContrato.Valor_asignado||'|'||nuValorAsignado||'|'||rfCuContrato.Valor_No_Liquidado||'|'||nuValorNoLiquidado||'|'||rfCuContrato.Valor_Liquidado||'|'||nuValorLiquidado);
  
    /*begin
      update open.ge_contrato gc
         set gc.valor_asignado     = nuValorAsignado,
             gc.valor_no_liquidado = nuValorNoLiquidado,
             gc.valor_liquidado    = nuValorLiquidado
       where gc.id_contrato = rfCuContrato.id_contrato;
      commit;
    exception
      when others then
        dbms_output.put_line('Error actualizando data del contrato ' ||
                             nuContrato);
        rollback;
    end;*/
  end if;
  close CuContrato;

  /*nuValorAsignado    := 0;
  nuValorNoLiquidado := 0;
  nuValorLiquidado   := 0;
  nuContrato         := 0;
  
  nuContrato := 6801;
  open cuValorAsignado(nuContrato);
  fetch cuValorAsignado
    into nuValorAsignado;
  close cuValorAsignado;
  
  open cuValorNoLiquidado(nuContrato);
  fetch cuValorNoLiquidado
    into nuValorNoLiquidado;
  close cuValorNoLiquidado;
  
  open cuValorLiquidado(nuContrato);
  fetch cuValorLiquidado
    into nuValorLiquidado;
  close cuValorLiquidado;
  
  open CuContrato(nuContrato);
  fetch CuContrato
    into rfCuContrato;
  if CuContrato%found then
    dbms_output.put_line('Contrato: ' || rfCuContrato.id_contrato);
    dbms_output.put_line('               Valor Asignado Contrato (Anterior): ' ||
                         rfCuContrato.Valor_asignado ||
                         ' - Valor Asignado OT (Nuevo): ' ||
                         nuValorAsignado);
    dbms_output.put_line('               Valor No Liquidado Contrato (Anterior): ' ||
                         rfCuContrato.Valor_No_Liquidado ||
                         ' - Valor No Liquidado OT (Nuevo): ' ||
                         nuValorNoLiquidado);
    dbms_output.put_line('               Valor Liquidado Contrato (Anterior): ' ||
                         rfCuContrato.Valor_Liquidado ||
                         ' - Valor Liquidado OT (Nuevo): ' ||
                         nuValorLiquidado);
  
    begin
      update ge_contrato gc
         set gc.valor_asignado     = nuValorAsignado,
             gc.valor_no_liquidado = nuValorNoLiquidado,
             gc.valor_liquidado    = nuValorLiquidado
       where gc.id_contrato = rfCuContrato.id_contrato;
      commit;
    exception
      when others then
        dbms_output.put_line('Error actualizando data del contrato ' ||
                             nuContrato);
        rollback;
    end;
  end if;
  close CuContrato;*/

end;
