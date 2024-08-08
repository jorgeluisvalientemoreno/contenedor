DECLARE
  CURSOR cuOrdeLega IS
  SELECT o.defined_contract_id contrato, sum(nvl(estimated_cost,0)) costo
  FROM or_order o
  WHERE o.order_status_id = 8
   AND dage_causal.fnugetclass_causal_id(o.causal_id,NULL) = 1
   AND o.defined_contract_id in (6861,6901,5541,5542,5543,6801)
  -- AND o.defined_contract_id is not null
   AND o.IS_PENDING_LIQ is not null
    and o.task_type_id <> 10044
    group by o.defined_contract_id;

  CURSOR cuOrdeAsig IS
  SELECT o.defined_contract_id contrato, sum(nvl(estimated_cost,0)) costo
  FROM or_order o
  WHERE o.order_status_id IN ( 5,6,7)
    AND o.defined_contract_id in (6861,6901,5541,5542,5543,6801)
  -- AND o.defined_contract_id is not null
   and o.task_type_id <> 10044
   group by o.defined_contract_id;
   
BEGIN
 --actualizar contrato
   DBMS_OUTPUT.PUT_LINE('TIPO|CONTRATO|COSTO');
   FOR reg IN cuOrdeLega LOOP
    DBMS_OUTPUT.PUT_LINE('LEGALIZACION|'||REG.CONTRATO||'|'||REG.COSTO);
    UPDATE ge_contrato set VALOR_NO_LIQUIDADO = REG.coSTO WHERE ID_CONTRATO = REG.contrato;
    COMMIT;
   END LOOP;

   FOR reg IN cuOrdeAsig LOOP
  DBMS_OUTPUT.PUT_LINE('ASIGNACION|'||REG.CONTRATO||'|'||REG.COSTO);
  UPDATE ge_contrato set VALOR_ASIGNADO = REG.coSTO WHERE ID_CONTRATO = REG.contrato;
  commit;
   END LOOP;
END;
/