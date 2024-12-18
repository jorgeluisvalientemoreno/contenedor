column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

  --Activar Suspension
  begin
    update open.pr_prod_suspension pps
       set pps.inactive_date = null, pps.active = 'Y'
     where pps.product_id = 14505304
       and pps.prod_suspension_id = 2763004
       and pps.suspension_type_id = 105;
    commit;
    dbms_output.put_line('Se activo la suspension para el producto 14505304 con tipo de suspension 105');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se activo la suspension para el producto 14505304 con tipo de suspension 105 - Error: ' ||
                           sqlerrm);
  end;

  --Actualizar ultima actividad de suspension que registro tipode suspension 105
  begin
    update open.pr_product pp
       set pp.suspen_ord_act_id = 270391568, pp.product_status_id = 2
     where pp.product_id = 14505304
       and pp.product_type_id = 7014;
    commit;
    dbms_output.put_line('Se actualiza para el producto 14505304 la ultima actividad de suspension');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualiza para el producto 14505304 la ultima actividad de suspension - Error: ' ||
                           sqlerrm);
  end;

  --Componentes del producto cambia de estado 
  begin
    update open.pr_component pc
       set pc.component_status_id = 8
     where pc.product_id = 14505304
       and pc.component_id in (2769404, 2769405);
    commit;
    dbms_output.put_line('Se actualiza para el producto 14505304 el estado del componente de 5 a 8');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualiza para el producto 14505304 la suspension del componente - Error: ' ||
                           sqlerrm);
  end;

  --Activar Suspension de los componentes del producto
  begin
    update open.pr_comp_suspension pcs
       set pcs.inactive_date = null, pcs.active = 'Y'
     where pcs.component_id in (2769404, 2769405)
       and pcs.comp_suspension_id in (5401119, 5401120);
    commit;
    dbms_output.put_line('Se actualiza para el producto 14505304 la suspension de los componentes');
  exception
    when others then
      rollback;
      dbms_output.put_line('No se actualiza para el producto 14505304 la suspension de los componentes - Error: ' ||
                           sqlerrm);
  end;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/