column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuactas is
    select ga.*
      from open.ge_acta ga
     where ga.id_acta in (182670, 182671, 182672);

  rfcuactas cuactas%rowtype;
begin

  for rfcuactas in cuactas loop
    dbms_output.put_line('Acta ' || rfcuactas.id_acta ||
                         ', actualiza fecha de pago ' ||
                         rfcuactas.extern_pay_date ||
                         ' a la nueva fecha de pago ' ||
                         (rfcuactas.extern_pay_date - 1));
  
    UPDATE open.ge_acta b
       SET b.extern_pay_date =
           (rfcuactas.extern_pay_date - 1)
     WHERE b.id_acta = rfcuactas.id_acta;
  
    commit;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/