column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuerror NUMBER;
  sberror VARCHAR2(4000);

  cursor cuContratos is
    select gc.*
      from open.ge_contrato gc
     where gc.id_contrato in
           (6801, 6901, 9401, 9421, 9441, 9501, 10461, 10524)
       and gc.id_tipo_contrato = 932
       and gc.status = 'AB';

  rfContratos cuContratos%rowtype;

  CURSOR cuValorAsignado(inuContrato number) IS
    SELECT SUM(nvl(oo.estimated_cost, 0)) VALOR_ASIGNADO
      from open.or_order oo
     where oo.order_status_id in (5, 6, 7)
       and oo.defined_contract_id = inuContrato;

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

  nuValorAsignado        open.ge_contrato.valor_asignado%type;
  nuValor_No_Liquidado   open.ge_contrato.valor_no_liquidado%type;
  nuValor_Liquidado      open.ge_contrato.valor_liquidado%type;
  nuValorTotalPagado6801 open.ge_contrato.valor_total_pagado%type;

begin

  dbms_output.put_line('Inicia OSF-3491');

  BEGIN
  
    dbms_output.put_line('CONTRATO|VALOR_ASIGNADO_ACTUAL|VALOR_ASIGNADO_REAL|VALOR_NO_LIQUIDADO_ACTUAL|VALOR_NO_LIQUIDADO_REAL|VALOR_LIQUIDADO_ACTUAL|VALOR_LIQUIDADO_REAL');
  
    for rfContratos in cuContratos loop
    
      begin
      
        open cuValorAsignado(rfContratos.id_contrato);
        fetch cuValorAsignado
          into nuValorAsignado;
        close cuValorAsignado;
      
        --/*
        update ge_contrato
           set valor_asignado = nvl(nuValorAsignado, 0)
         where id_contrato = rfContratos.id_contrato
           and id_tipo_contrato = rfContratos.id_tipo_contrato
           and status = 'AB';
        
        commit;
        --*/
      
        open cuValor_No_Liquidado(rfContratos.id_contrato);
        fetch cuValor_No_Liquidado
          into nuValor_No_Liquidado;
        close cuValor_No_Liquidado;
      
        --/*
        update ge_contrato
           set Valor_No_Liquidado = nvl(nuValor_No_Liquidado, 0)
         where id_contrato = rfContratos.id_contrato
           and id_tipo_contrato = rfContratos.id_tipo_contrato
           and status = 'AB';
        
        commit;
        --*/
      
        open cuValor_Liquidado(rfContratos.id_contrato);
        fetch cuValor_Liquidado
          into nuValor_Liquidado;
        close cuValor_Liquidado;
      
        --/*
        update ge_contrato
           set Valor_Liquidado = nvl(nuValor_Liquidado, 0)
         where id_contrato = rfContratos.id_contrato
           and id_tipo_contrato = rfContratos.id_tipo_contrato
           and status = 'AB';
        
        commit;
        --*/
      
        dbms_output.put_line(rfContratos.id_contrato || '|' ||
                             rfContratos.valor_asignado || '|' ||
                             nvl(nuValorAsignado, 0) || '|' ||
                             rfContratos.valor_no_liquidado || '|' ||
                             nvl(nuValor_No_Liquidado, 0) || '|' ||
                             rfContratos.valor_liquidado || '|' ||
                             nvl(nuValor_Liquidado, 0));
      
        if rfContratos.id_contrato = 6801 then
          nuValorTotalPagado6801 := rfContratos.valor_total_pagado;
        end if;
      
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          DBMS_OUTPUT.PUT_LINE('Error actualizando el contrato [' ||
                               rfContratos.id_contrato || '] --> ' ||
                               sqlerrm);
      END;
    
    end loop;
  
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
  END;

  dbms_output.put_line('Termina OSF-3491');

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/