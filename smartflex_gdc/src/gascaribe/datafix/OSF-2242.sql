column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
   nuIdContrato    number := 8401;
   nuValorPagado   number;
   nuValorAnteri   number;
   cnuIdTipoActa   number := 1;
   nuCodigoError   number := 2701;
   
   cursor cuValorPagado is
   select sum(valor_liquidado)
    from open.ge_acta
    where id_contrato=nuIdContrato
      and id_tipo_acta=cnuIdTipoActa
      and estado='C';
begin
   dbms_output.put_line('Empieza Script ');

   dbms_output.put_line('Contrato: '||nuIdContrato);
   
   nuValorAnteri := dage_contrato.fnugetvalor_total_pagado(nuIdContrato, null);
   dbms_output.put_line('Valor anterior: '||nuValorAnteri);

   open cuValorPagado;
   fetch cuValorPagado into nuValorPagado;
   if cuValorPagado%found then 
      update ge_contrato
         set valor_total_pagado = nuValorPagado
       where id_contrato = nuIdContrato;

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
        nuIdContrato,
        null,
        null,
        nuCodigoError,
        'SE MODIFICA CONTRATO SEGUN CASO SOSF-2199');
        commit;
        
        dbms_output.put_line('Contrato actualizado correctamente');
        dbms_output.put_line('Nuevo valor: '||nuValorPagado);
   end if;
   close cuValorPagado;
   dbms_output.put_line('Termina Script ');
exception
  when others then
    rollback;
    dbms_output.put_line('Error: '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/