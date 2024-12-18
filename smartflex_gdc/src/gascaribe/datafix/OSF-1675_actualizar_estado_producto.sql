column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuDATA is
    select distinct ooa.product_id          Producto,
                    oo.execution_final_date Fecha_Final_Ejecucion,
                    ooa.package_id          Solicitud,
                    mp.motive_status_id     Estado_Solicitud
      from open.or_order_activity ooa,
           open.or_order          oo,
           open.mo_packages       mp,
           open.pr_product        pp
     where ooa.order_id = oo.order_id
       and ooa.product_id = pp.product_id
       and ooa.product_id in (52707617, 52709074, 52709236, 52710302)
       and oo.task_type_id in (12152, 12150, 12153)
       and oo.order_status_id = 8
       and oo.causal_id = 9944
       and mp.package_id(+) = ooa.package_id
       and pp.product_status_id = 15;

  rfcuDATA cuDATA%rowtype;

begin

  for rfcuDATA in cuDATA loop
    
    PKG_GESTION_PRODUCTO.PRACTIVAPRODUCTO(rfcuDATA.Producto,
                                          rfcuDATA.Fecha_Final_Ejecucion,
                                          'S');
  
    dbms_output.put_line('Se actauliza producto ' || rfcuDATA.Producto ||
                         ' con nuevo estado de corte 1 - Conexion');
  
    commit;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/