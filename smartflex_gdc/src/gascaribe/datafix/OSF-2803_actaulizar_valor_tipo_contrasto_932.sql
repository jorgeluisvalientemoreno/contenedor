column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuerror NUMBER;
  sberror VARCHAR2(4000);

  CURSOR cuValorAsignado IS
    SELECT SUM(nvl(oo.estimated_cost, 0)) VALOR_ASIGNADO
      from open.or_order oo
     where oo.order_status_id in (5, 6, 7)
       and oo.defined_contract_id = 6901;

  CURSOR cuValor_No_Liquidado IS
    SELECT sum(nvl(estimated_cost, 0)) VALOR_NO_LIQUIDADO
      FROM open.or_order o
     inner join open.ge_causal gc
        on gc.causal_id = o.causal_id
       and class_causal_id = 1
     WHERE o.order_status_id = 8
       AND o.defined_contract_id = 6901
       AND o.IS_PENDING_LIQ is not null;

  CURSOR cuValor_Liquidado IS
    SELECT sum(nvl(gda.valor_total, 0)) VALOR_LIQUIDADO
      FROM open.ge_detalle_acta gda, open.ge_acta ga
     WHERE ga.id_contrato = 6901
       and ga.id_tipo_acta = 1
       and gda.id_acta = ga.id_acta
       AND gda.affect_contract_val = 'Y';

  nuValorAsignado      open.ge_contrato.valor_asignado%type;
  nuValor_No_Liquidado open.ge_contrato.valor_no_liquidado%type;
  nuValor_Liquidado    open.ge_contrato.valor_liquidado%type;

  cursor cuContratos is
    select gc.*
      from open.ge_contrato gc
     where gc.id_contrato = 6901
       and gc.status = 'AB';

  rfContratos cuContratos%rowtype;

begin

  dbms_output.put_line('Inicia OSF-2803');

  BEGIN
  
    dbms_output.put_line('CONTRATO|VALOR_ASIGNADO_ANTERIOR|VALOR_ASIGNADO_NUEVO|VALOR_NO_LIQUIDADO_ANTERIOR|VALOR_NO_LIQUIDADO_NUEVO|VALOR_LIQUIDADO_ANTERIOR|VALOR_LIQUIDADO_NUEVO');
  
    open cuValorAsignado;
    fetch cuValorAsignado
      into nuValorAsignado;
    close cuValorAsignado;
  
    open cuValor_No_Liquidado;
    fetch cuValor_No_Liquidado
      into nuValor_No_Liquidado;
    close cuValor_No_Liquidado;
  
    open cuValor_Liquidado;
    fetch cuValor_Liquidado
      into nuValor_Liquidado;
    close cuValor_Liquidado;
  
    open cuContratos;
    fetch cuContratos
      into rfContratos;
    close cuContratos;
  
    --/*
    update ge_contrato
       set valor_asignado     = nuValorAsignado,
           Valor_No_Liquidado = nuValor_No_Liquidado,
           Valor_Liquidado    = nuValor_Liquidado
     where id_contrato = rfContratos.id_contrato
       and id_tipo_contrato = rfContratos.id_tipo_contrato
       and status = 'AB';
    
    commit;
    --*/
  
    dbms_output.put_line(rfContratos.id_contrato || '|' ||
                         rfContratos.valor_asignado || '|' ||
                         nuValorAsignado || '|' ||
                         rfContratos.valor_no_liquidado || '|' ||
                         nuValor_No_Liquidado || '|' ||
                         rfContratos.valor_liquidado || '|' ||
                         nuValor_Liquidado);
  
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
  END;

  dbms_output.put_line('Termina OSF-2803');

end;
/




select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/