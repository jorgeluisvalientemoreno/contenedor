column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuerror NUMBER;
  sberror VARCHAR2(4000);

  CURSOR cuContratoValorTotalPagado is
    select gc.*
      from open.ge_contrato gc
     where gc.id_contrato in (9303, 9321, 9324)
       and gc.status = 'AB';

  rfcuContratoValorTotalPagado cuContratoValorTotalPagado%rowtype;

  CURSOR cuValorTotalPagado(inuContrato number) IS
    select sum(valor_liquidado) VALOR_TOTAL_PAGADO
      from open.ge_acta gc
     where gc.id_contrato = inuContrato
       and gc.id_tipo_acta = 1
       and gc.estado = 'C';

  CURSOR cuContratoValorLiquidado is
    select gc.*
      from open.ge_contrato gc
     where gc.id_contrato in (9321)
       and gc.status = 'AB';

  rfContratoValorLiquidado cuContratoValorLiquidado%rowtype;

  CURSOR cuValor_No_Liquidado(inuContrato number) IS
    SELECT sum(nvl(estimated_cost, 0)) VALOR_NO_LIQUIDADO
      FROM open.or_order o
     inner join open.ge_causal gc
        on gc.causal_id = o.causal_id
       and class_causal_id = 1
     WHERE o.order_status_id = 8
       AND o.defined_contract_id = inuContrato
       AND o.IS_PENDING_LIQ is not null;

  CURSOR cuValor_Liquidado(inuContrato number) IS
    SELECT sum(nvl(gda.valor_total, 0)) VALOR_LIQUIDADO
      FROM open.ge_detalle_acta gda, open.ge_acta ga
     WHERE ga.id_contrato = inuContrato
       and ga.id_tipo_acta = 1
       and gda.id_acta = ga.id_acta
       AND gda.affect_contract_val = 'Y';

  nuvalor_total_pagado open.ge_contrato.valor_total_pagado%type;
  nuValorAsignado      open.ge_contrato.valor_asignado%type;
  nuValor_No_Liquidado open.ge_contrato.valor_no_liquidado%type;
  nuValor_Liquidado    open.ge_contrato.valor_liquidado%type;

  nuCodigoError number := 2701;

begin

  dbms_output.put_line('CONTRATO|VALOR_TOTAL_PAGADO_ANTERIOR|VALOR_TOTAL_PAGADO_NUEVO');
  for rfContratoValorTotalPagado in cuContratoValorTotalPagado loop
  
    open cuValorTotalPAgado(rfContratoValorTotalPagado.id_contrato);
    fetch cuValorTotalPAgado
      into nuvalor_total_pagado;
    close cuValorTotalPAgado;
  
    --/*
    begin
      update ge_contrato
         set valor_total_pagado = nuvalor_total_pagado
       where id_contrato = rfContratoValorTotalPagado.id_contrato
         and id_tipo_contrato = rfContratoValorTotalPagado.id_tipo_contrato;
    
      insert into open.ct_process_log
        (process_log_id,
         log_date,
         contract_id,
         period_id,
         break_date,
         error_code,
         error_message)
      values
        (seq_ct_process_log_109639.nextval,
         sysdate,
         rfContratoValorTotalPagado.id_contrato,
         null,
         null,
         nuCodigoError,
         'VALOR_TOTAL_PAGADO_ANTERIOR[' ||
         rfContratoValorTotalPagado.valor_total_pagado ||
         '] - VALOR_TOTAL_PAGADO_NUEVO[' || nuvalor_total_pagado || '] - CASO OSF-3185');
    
      commit;
    
      --*/
      dbms_output.put_line(rfContratoValorTotalPagado.id_contrato || '|' ||
                           rfContratoValorTotalPagado.valor_total_pagado || '|' ||
                           nuvalor_total_pagado);
      --/*    
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Contrato ' ||
                             rfContratoValorTotalPagado.id_contrato ||
                             'Error no controlado --> ' || sqlerrm);
    END;
    --*/
  
  END LOOP;

  dbms_output.put_line('CONTRATO|VALOR_NO_LIQUIDADO_ANTERIOR|VALOR_NO_LIQUIDADO_NUEVO|VALOR_LIQUIDADO_ANTERIOR|VALOR_LIQUIDADO_NUEVO');
  for rfContratoValorLiquidado in cuContratoValorLiquidado loop
    open cuValor_No_Liquidado(rfContratoValorLiquidado.id_contrato);
    fetch cuValor_No_Liquidado
      into nuValor_No_Liquidado;
    close cuValor_No_Liquidado;
  
    open cuValor_Liquidado(rfContratoValorLiquidado.id_contrato);
    fetch cuValor_Liquidado
      into nuValor_Liquidado;
    close cuValor_Liquidado;
  
    --/*
    BEGIN
      update ge_contrato
         set Valor_No_Liquidado = nuValor_No_Liquidado,
             Valor_Liquidado    = nuValor_Liquidado
       where id_contrato = rfContratoValorLiquidado.id_contrato
         and id_tipo_contrato = rfContratoValorLiquidado.id_tipo_contrato;
    
      insert into open.ct_process_log
        (process_log_id,
         log_date,
         contract_id,
         period_id,
         break_date,
         error_code,
         error_message)
      values
        (seq_ct_process_log_109639.nextval,
         sysdate,
         rfContratoValorLiquidado.id_contrato,
         null,
         null,
         nuCodigoError,
         'VALOR_NO_LIQUIDADO_ANTERIOR[' ||
         rfContratoValorLiquidado.valor_no_liquidado ||
         '] - VALOR_NO_LIQUIDADO_NUEVO[' || nuValor_No_Liquidado ||
         '] - VALOR_LIQUIDADO_ANTERIOR[' ||
         rfContratoValorLiquidado.valor_liquidado ||
         '] - VALOR_LIQUIDADO_NUEVO[' || nuValor_Liquidado || '] - CASO OSF-3185');
    
      commit;
    
      --*/
      dbms_output.put_line(rfContratoValorLiquidado.id_contrato || '|' ||
                           rfContratoValorLiquidado.valor_no_liquidado || '|' ||
                           nuValor_No_Liquidado || '|' ||
                           rfContratoValorLiquidado.valor_liquidado || '|' ||
                           nuValor_Liquidado);
      --/*
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Contrato ' ||
                             rfContratoValorLiquidado.id_contrato ||
                             'Error no controlado --> ' || sqlerrm);
    END;
    --*/
  
  END LOOP;

end;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/