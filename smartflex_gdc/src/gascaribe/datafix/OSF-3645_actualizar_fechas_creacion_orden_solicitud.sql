column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

cursor cuOrdenes is
  select 343592280 Orden, '03/11/2024 12:20:09 PM' FechaCreacionSolicitud,'03/11/2024 12:20:09 PM' FechaCreacionOrden from dual union all
  select 343592293 Orden, '03/11/2024 12:22:05 PM' FechaCreacionSolicitud,'03/11/2024 12:22:06 PM' FechaCreacionOrden from dual union all
  select 343592378 Orden, '03/11/2024 12:44:07 PM' FechaCreacionSolicitud,'03/11/2024 12:44:07 PM' FechaCreacionOrden from dual union all
  select 343592391 Orden, '03/11/2024 12:49:31 PM' FechaCreacionSolicitud,'03/11/2024 12:49:31 PM' FechaCreacionOrden from dual union all
  select 343678433 Orden, '04/11/2024 12:47:51 PM' FechaCreacionSolicitud,'04/11/2024 12:47:51 PM' FechaCreacionOrden from dual union all
  select 343764951 Orden, '05/11/2024 12:48:53 AM' FechaCreacionSolicitud,'05/11/2024 12:48:53 AM' FechaCreacionOrden from dual union all
  select 343678462 Orden, '04/11/2024 12:54:06 PM' FechaCreacionSolicitud,'04/11/2024 12:54:06 PM' FechaCreacionOrden from dual union all
  select 343801288 Orden, '05/11/2024 12:08:27 PM' FechaCreacionSolicitud,'05/11/2024 12:08:27 PM' FechaCreacionOrden from dual ;

  rfOrdenes cuOrdenes%rowtype;

  cursor cuDataOrden(inuOrden number) is
  select mp.package_id, mp.request_date, oo.created_date from open.Or_Order_Activity ooa, open.or_order oo, open.mo_packages mp where ooa.package_id = mp.package_id and ooa.order_id=oo.order_id and ooa.order_id=inuOrden; 
  
  rfDataOrden cuDataOrden%rowtype;

begin

  for rfOrdenes in cuOrdenes loop
    
    for rfDataOrden in cuDataOrden(rfOrdenes.orden) loop
      
      begin
      
        update open.or_order oo set oo.created_date = to_date(rfOrdenes.FechaCreacionOrden,'DD/MM/YYYY HH:MI:SS PM') where oo.order_id=rfOrdenes.orden; 
        update open.mo_packages mp set mp.request_date = to_date(rfOrdenes.FechaCreacionSolicitud,'DD/MM/YYYY HH:MI:SS PM') where mp.package_id =rfDataOrden.package_id; 

        commit;

        dbms_output.put_line('------Fechas actualizadas Ok.-------------------------------------------------------------------------------------');
        dbms_output.put_line('Orden: ' || rfOrdenes.orden ||' - fecha creacion orden Inicial: '|| rfDataOrden.created_date ||' - Nueva fecha creacion orden: '|| to_date(rfOrdenes.FechaCreacionOrden,'DD/MM/YYYY HH:MI:SS PM'));
        dbms_output.put_line('Solicitud: ' || rfDataOrden.package_id || ' - fecha creacion Solicitud Inicial: ' || rfDataOrden.request_date || ' - Nueva fecha creacion Solicitud: ' || to_date(rfOrdenes.FechaCreacionSolicitud,'DD/MM/YYYY HH:MI:SS PM'));
        
      exception
        when others then
          rollback;
          dbms_output.put_line('Error: ' || sqlerrm);
      end;
      
    end loop;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/