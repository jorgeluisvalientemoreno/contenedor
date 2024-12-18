column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cupoblacion is
    with base as
     (select p.package_id
        from open.mo_packages p
       where p.package_type_id = 323
         and p.user_id = 'INNOVACION'
         AND p.motive_status_id != 32),
    base2 as
     (select base.package_id, m.motive_id, m.product_id, m.product_type_id
        from base
       inner join open.mo_motive m
          on m.package_id = base.package_id
         and product_type_id = 7014),
    base3 as
     (select base2.*,
             o.order_id,
             o.legalization_date,
             a.instance_id,
             p.product_status_id,
             s.sesuesco
        from base2
       inner join open.or_order_activity a
          on a.package_id = base2.package_id
         and a.motive_id = base2.motive_id
         and a.task_type_id = 12150
         and a.activity_id in (4295271, 100002510)
         and status = 'F'
       inner join open.or_order o
          on o.order_id = a.order_id
         and o.task_type_id = 12150
         and o.order_status_id = 8
         and o.causal_id = 9944
         and o.legalization_Date >= '09/08/2023'
       inner join open.pr_product p
          on p.product_id = a.product_id
         and p.product_status_id = 1
       inner join open.servsusc s
          on s.sesunuse = a.product_id
         and s.sesuesco = 96)
    select *
      from base3
     where not exists (select null
              from open.or_order_activity a
             where a.task_type_id = 12150
               and a.motive_id = base3.motive_id
               and a.status = 'R');

  rfcupoblacion cupoblacion%rowtype;

  nuIntentoProducto number := 0;

  cursor cuComponente(inuServicio number) is
    select a.cmssidco, a.cmssescm
      from open.compsesu a
     where a.cmsssesu = inuServicio;

  rfcuComponente cuComponente%rowtype;

begin

  --Actiualziaicon del tipo de suspension a 2 en los componentes de suspension definidos a una lista de productos suspendidos.
  for rfcupoblacion in cupoblacion loop
  
    begin
      update open.servsusc s
        set s.sesuesco = 1
      where s.sesunuse = rfcupoblacion.product_id;
    
      dbms_output.put_line('Actualizacion del estado ' ||
                           rfcupoblacion.sesuesco ||
                           ' a 1 del estdo de corte asociado al Producto: ' ||
                           rfcupoblacion.PRODUCT_ID || ' - Ok.');
    
      commit;
      --rollback;
    
    exception
      when others then
        rollback;
        dbms_output.put_line('No se permitio actualizacion del estado ' ||
                             rfcupoblacion.sesuesco ||
                             ' a 1 del estdo de corte asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID);
    end;
  
    for rfcuComponente in cuComponente(rfcupoblacion.product_id) loop
      begin
        update open.compsesu pc
          set pc.cmssescm = 5
        where pc.cmsssesu = rfcupoblacion.product_id;
        dbms_output.put_line('Actualizacion del estado ' ||
                             rfcuComponente.cmssescm ||
                             ' a 5 del componente en compsesu [' ||
                             rfcuComponente.CMSSIDCO ||
                             '] asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID || ' - Ok.');
        commit;
        --rollback;
      
      exception
        when others then
          rollback;
          dbms_output.put_line('No se permitio actualizacion del estado ' ||
                               rfcuComponente.cmssescm ||
                               ' a 5 del componente en compsesu [' ||
                               rfcuComponente.CMSSIDCO ||
                               '] asociado al Producto: ' ||
                               rfcupoblacion.PRODUCT_ID);
      end;
    end loop;
  
  end loop;

end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/