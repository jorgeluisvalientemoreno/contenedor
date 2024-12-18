column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

cursor cuOrdenes is
  select 343592561 Orden, '03/11/2024 02:35:09 PM' FechaCreacionSolicitud, '03/11/2024 02:35:10 PM' FechaCreacionOrden from dual union all
  select 343592675 Orden, '03/11/2024 03:40:26 PM' FechaCreacionSolicitud, '03/11/2024 03:40:27 PM' FechaCreacionOrden from dual union all
  select 343592708 Orden, '03/11/2024 04:04:34 PM' FechaCreacionSolicitud, '03/11/2024 04:04:34 PM' FechaCreacionOrden from dual union all
  select 343592889 Orden, '03/11/2024 05:02:36 PM' FechaCreacionSolicitud, '03/11/2024 05:02:37 PM' FechaCreacionOrden from dual union all
  select 343592966 Orden, '03/11/2024 05:32:14 PM' FechaCreacionSolicitud, '03/11/2024 05:32:14 PM' FechaCreacionOrden from dual union all
  select 343593043 Orden, '03/11/2024 06:00:51 PM' FechaCreacionSolicitud, '03/11/2024 06:00:52 PM' FechaCreacionOrden from dual union all
  select 343591548 Orden, '03/11/2024 07:30:19 AM' FechaCreacionSolicitud, '03/11/2024 07:30:20 AM' FechaCreacionOrden from dual union all
  select 343593193 Orden, '03/11/2024 07:55:32 PM' FechaCreacionSolicitud, '03/11/2024 07:55:32 PM' FechaCreacionOrden from dual union all
  select 343593208 Orden, '03/11/2024 08:18:52 PM' FechaCreacionSolicitud, '03/11/2024 08:18:52 PM' FechaCreacionOrden from dual union all
  select 343591585 Orden, '03/11/2024 08:33:14 AM' FechaCreacionSolicitud, '03/11/2024 08:33:14 AM' FechaCreacionOrden from dual union all
  select 343591609 Orden, '03/11/2024 09:00:50 AM' FechaCreacionSolicitud, '03/11/2024 09:00:50 AM' FechaCreacionOrden from dual union all
  select 343593238 Orden, '03/11/2024 09:11:37 PM' FechaCreacionSolicitud, '03/11/2024 09:11:37 PM' FechaCreacionOrden from dual union all
  select 343591620 Orden, '03/11/2024 09:12:50 AM' FechaCreacionSolicitud, '03/11/2024 09:12:50 AM' FechaCreacionOrden from dual union all
  select 343591667 Orden, '03/11/2024 09:29:49 AM' FechaCreacionSolicitud, '03/11/2024 09:29:50 AM' FechaCreacionOrden from dual union all
  select 343591746 Orden, '03/11/2024 09:45:52 AM' FechaCreacionSolicitud, '03/11/2024 09:45:52 AM' FechaCreacionOrden from dual union all
  select 343591836 Orden, '03/11/2024 10:11:37 AM' FechaCreacionSolicitud, '03/11/2024 10:11:37 AM' FechaCreacionOrden from dual union all
  select 343591913 Orden, '03/11/2024 10:23:59 AM' FechaCreacionSolicitud, '03/11/2024 10:24:00 AM' FechaCreacionOrden from dual union all
  select 343591992 Orden, '03/11/2024 10:54:54 AM' FechaCreacionSolicitud, '03/11/2024 10:54:54 AM' FechaCreacionOrden from dual union all
  select 343592074 Orden, '03/11/2024 11:31:47 AM' FechaCreacionSolicitud, '03/11/2024 11:31:47 AM' FechaCreacionOrden from dual union all
  select 343592076 Orden, '03/11/2024 11:34:02 AM' FechaCreacionSolicitud, '03/11/2024 11:34:02 AM' FechaCreacionOrden from dual union all
  select 343592280 Orden, '03/11/2024 12:20:09 AM' FechaCreacionSolicitud, '03/11/2024 12:20:09 AM' FechaCreacionOrden from dual union all
  select 343592293 Orden, '03/11/2024 12:22:05 AM' FechaCreacionSolicitud, '03/11/2024 12:22:06 AM' FechaCreacionOrden from dual union all
  select 343592378 Orden, '03/11/2024 12:44:07 AM' FechaCreacionSolicitud, '03/11/2024 12:44:07 AM' FechaCreacionOrden from dual union all
  select 343592391 Orden, '03/11/2024 12:49:31 AM' FechaCreacionSolicitud, '03/11/2024 12:49:31 AM' FechaCreacionOrden from dual union all
  select 343592510 Orden, '03/11/2024 01:45:20 PM' FechaCreacionSolicitud, '03/11/2024 01:45:20 PM' FechaCreacionOrden from dual union all
  select 343678709 Orden, '04/11/2024 02:27:06 PM' FechaCreacionSolicitud, '04/11/2024 02:27:06 PM' FechaCreacionOrden from dual union all
  select 343678796 Orden, '04/11/2024 03:23:07 PM' FechaCreacionSolicitud, '04/11/2024 03:23:07 PM' FechaCreacionOrden from dual union all
  select 343666133 Orden, '04/11/2024 04:26:50 AM' FechaCreacionSolicitud, '04/11/2024 04:26:50 AM' FechaCreacionOrden from dual union all
  select 343677651 Orden, '04/11/2024 05:20:40 AM' FechaCreacionSolicitud, '04/11/2024 05:20:40 AM' FechaCreacionOrden from dual union all
  select 343679097 Orden, '04/11/2024 05:30:01 PM' FechaCreacionSolicitud, '04/11/2024 05:30:01 PM' FechaCreacionOrden from dual union all
  select 343679098 Orden, '04/11/2024 05:30:02 PM' FechaCreacionSolicitud, '04/11/2024 05:30:02 PM' FechaCreacionOrden from dual union all
  select 343679105 Orden, '04/11/2024 05:31:25 PM' FechaCreacionSolicitud, '04/11/2024 05:31:26 PM' FechaCreacionOrden from dual union all
  select 343679178 Orden, '04/11/2024 06:07:24 PM' FechaCreacionSolicitud, '04/11/2024 06:07:24 PM' FechaCreacionOrden from dual union all
  select 343757138 Orden, '04/11/2024 06:38:39 PM' FechaCreacionSolicitud, '04/11/2024 06:38:40 PM' FechaCreacionOrden from dual union all
  select 343764728 Orden, '04/11/2024 07:18:53 PM' FechaCreacionSolicitud, '04/11/2024 07:18:54 PM' FechaCreacionOrden from dual union all
  select 343677669 Orden, '04/11/2024 07:33:28 AM' FechaCreacionSolicitud, '04/11/2024 07:33:28 AM' FechaCreacionOrden from dual union all
  select 343764750 Orden, '04/11/2024 08:28:25 PM' FechaCreacionSolicitud, '04/11/2024 08:28:25 PM' FechaCreacionOrden from dual union all
  select 343677702 Orden, '04/11/2024 08:49:33 AM' FechaCreacionSolicitud, '04/11/2024 08:49:33 AM' FechaCreacionOrden from dual union all
  select 343677711 Orden, '04/11/2024 08:59:59 AM' FechaCreacionSolicitud, '04/11/2024 09:00:00 AM' FechaCreacionOrden from dual union all
  select 343677719 Orden, '04/11/2024 09:05:53 AM' FechaCreacionSolicitud, '04/11/2024 09:05:53 AM' FechaCreacionOrden from dual union all
  select 343677723 Orden, '04/11/2024 09:09:02 AM' FechaCreacionSolicitud, '04/11/2024 09:09:02 AM' FechaCreacionOrden from dual union all
  select 343677779 Orden, '04/11/2024 09:29:02 AM' FechaCreacionSolicitud, '04/11/2024 09:29:02 AM' FechaCreacionOrden from dual union all
  select 343677828 Orden, '04/11/2024 09:33:50 AM' FechaCreacionSolicitud, '04/11/2024 09:33:50 AM' FechaCreacionOrden from dual union all
  select 343677844 Orden, '04/11/2024 09:35:39 AM' FechaCreacionSolicitud, '04/11/2024 09:35:39 AM' FechaCreacionOrden from dual union all
  select 343677924 Orden, '04/11/2024 10:02:46 AM' FechaCreacionSolicitud, '04/11/2024 10:02:46 AM' FechaCreacionOrden from dual union all
  select 343677942 Orden, '04/11/2024 10:09:47 AM' FechaCreacionSolicitud, '04/11/2024 10:09:47 AM' FechaCreacionOrden from dual union all
  select 343677975 Orden, '04/11/2024 10:21:27 AM' FechaCreacionSolicitud, '04/11/2024 10:21:27 AM' FechaCreacionOrden from dual union all
  select 343677989 Orden, '04/11/2024 10:27:24 AM' FechaCreacionSolicitud, '04/11/2024 10:27:24 AM' FechaCreacionOrden from dual union all
  select 343678100 Orden, '04/11/2024 10:49:30 AM' FechaCreacionSolicitud, '04/11/2024 10:49:30 AM' FechaCreacionOrden from dual union all
  select 343764779 Orden, '04/11/2024 10:50:24 PM' FechaCreacionSolicitud, '04/11/2024 10:50:24 PM' FechaCreacionOrden from dual union all
  select 343678173 Orden, '04/11/2024 11:12:43 AM' FechaCreacionSolicitud, '04/11/2024 11:12:43 AM' FechaCreacionOrden from dual union all
  select 343678244 Orden, '04/11/2024 11:32:04 AM' FechaCreacionSolicitud, '04/11/2024 11:32:04 AM' FechaCreacionOrden from dual union all
  select 343678326 Orden, '04/11/2024 11:56:45 AM' FechaCreacionSolicitud, '04/11/2024 11:56:45 AM' FechaCreacionOrden from dual union all
  select 343678433 Orden, '04/11/2024 12:47:51 AM' FechaCreacionSolicitud, '04/11/2024 12:47:51 AM' FechaCreacionOrden from dual union all
  select 343764951 Orden, '04/11/2024 12:48:53 PM' FechaCreacionSolicitud, '04/11/2024 12:48:53 PM' FechaCreacionOrden from dual union all
  select 343678462 Orden, '04/11/2024 12:54:06 AM' FechaCreacionSolicitud, '04/11/2024 12:54:06 AM' FechaCreacionOrden from dual union all
  select 343678534 Orden, '04/11/2024 01:02:03 PM' FechaCreacionSolicitud, '04/11/2024 01:02:03 PM' FechaCreacionOrden from dual union all
  select 343678657 Orden, '04/11/2024 01:48:14 PM' FechaCreacionSolicitud, '04/11/2024 01:48:14 PM' FechaCreacionOrden from dual union all
  select 343804575 Orden, '05/11/2024 03:46:36 PM' FechaCreacionSolicitud, '05/11/2024 03:46:36 PM' FechaCreacionOrden from dual union all
  select 343806510 Orden, '05/11/2024 04:59:58 PM' FechaCreacionSolicitud, '05/11/2024 04:59:58 PM' FechaCreacionOrden from dual union all
  select 343792139 Orden, '05/11/2024 05:52:50 AM' FechaCreacionSolicitud, '05/11/2024 05:52:50 AM' FechaCreacionOrden from dual union all
  select 343792156 Orden, '05/11/2024 06:36:14 AM' FechaCreacionSolicitud, '05/11/2024 06:36:14 AM' FechaCreacionOrden from dual union all
  select 343792167 Orden, '05/11/2024 06:42:57 AM' FechaCreacionSolicitud, '05/11/2024 06:42:57 AM' FechaCreacionOrden from dual union all
  select 343792227 Orden, '05/11/2024 07:11:49 AM' FechaCreacionSolicitud, '05/11/2024 07:11:50 AM' FechaCreacionOrden from dual union all
  select 343792256 Orden, '05/11/2024 07:30:41 AM' FechaCreacionSolicitud, '05/11/2024 07:30:41 AM' FechaCreacionOrden from dual union all
  select 343792261 Orden, '05/11/2024 07:33:32 AM' FechaCreacionSolicitud, '05/11/2024 07:33:32 AM' FechaCreacionOrden from dual union all
  select 343792314 Orden, '05/11/2024 07:47:11 AM' FechaCreacionSolicitud, '05/11/2024 07:47:11 AM' FechaCreacionOrden from dual union all
  select 343792348 Orden, '05/11/2024 07:53:07 AM' FechaCreacionSolicitud, '05/11/2024 07:53:07 AM' FechaCreacionOrden from dual union all
  select 343792355 Orden, '05/11/2024 07:55:56 AM' FechaCreacionSolicitud, '05/11/2024 07:55:56 AM' FechaCreacionOrden from dual union all
  select 343792361 Orden, '05/11/2024 07:57:26 AM' FechaCreacionSolicitud, '05/11/2024 07:57:26 AM' FechaCreacionOrden from dual union all
  select 343792388 Orden, '05/11/2024 08:03:11 AM' FechaCreacionSolicitud, '05/11/2024 08:03:11 AM' FechaCreacionOrden from dual union all
  select 343792474 Orden, '05/11/2024 08:14:27 AM' FechaCreacionSolicitud, '05/11/2024 08:14:27 AM' FechaCreacionOrden from dual union all
  select 343792877 Orden, '05/11/2024 08:22:38 AM' FechaCreacionSolicitud, '05/11/2024 08:22:38 AM' FechaCreacionOrden from dual union all
  select 343793045 Orden, '05/11/2024 08:24:07 AM' FechaCreacionSolicitud, '05/11/2024 08:24:07 AM' FechaCreacionOrden from dual union all
  select 343793099 Orden, '05/11/2024 08:29:41 AM' FechaCreacionSolicitud, '05/11/2024 08:29:41 AM' FechaCreacionOrden from dual union all
  select 343794622 Orden, '05/11/2024 09:56:07 AM' FechaCreacionSolicitud, '05/11/2024 09:56:07 AM' FechaCreacionOrden from dual union all
  select 343794640 Orden, '05/11/2024 09:57:11 AM' FechaCreacionSolicitud, '05/11/2024 09:57:11 AM' FechaCreacionOrden from dual union all
  select 343807873 Orden, '05/11/2024 10:03:39 PM' FechaCreacionSolicitud, '05/11/2024 10:03:39 PM' FechaCreacionOrden from dual union all
  select 343801288 Orden, '05/11/2024 12:08:27 AM' FechaCreacionSolicitud, '05/11/2024 12:08:27 AM' FechaCreacionOrden from dual union all
  select 343765944 Orden, '05/11/2024 01:33:09 AM' FechaCreacionSolicitud, '05/11/2024 01:33:09 AM' FechaCreacionOrden from dual;

  rfOrdenes cuOrdenes%rowtype;

  cursor cuDataOrden(inuOrden number) is
  select mp.package_id, mp.request_date, oo.created_date from open.Or_Order_Activity ooa, open.or_order oo, open.mo_packages mp where ooa.package_id = mp.package_id and ooa.order_id=oo.order_id and ooa.order_id=inuOrden; 
  
  rfDataOrden cuDataOrden%rowtype;

begin

  for rfOrdenes in cuOrdenes loop
    
    for rfDataOrden in cuDataOrden(rfOrdenes.orden) loop
      
      begin
      
        update open.or_order oo set oo.created_date = to_date(rfOrdenes.FechaCreacionOrden,'DD/MM/YYYY HH:MI:SS AM') where oo.order_id=rfOrdenes.orden; 
        update open.mo_packages mp set mp.request_date = to_date(rfOrdenes.FechaCreacionSolicitud,'DD/MM/YYYY HH:MI:SS AM') where mp.package_id =rfDataOrden.package_id; 

        commit;

        dbms_output.put_line('------Fechas actualizadas Ok.-------------------------------------------------------------------------------------');
        dbms_output.put_line('Orden: ' || rfOrdenes.orden ||' - fecha creacion orden Inicial: '|| rfDataOrden.created_date ||' - Nueva fecha creacion orden: '|| to_date(rfOrdenes.FechaCreacionOrden,'DD/MM/YYYY HH:MI:SS AM'));
        dbms_output.put_line('Solicitud: ' || rfDataOrden.package_id || ' - fecha creacion Solicitud Inicial: ' || rfDataOrden.request_date || ' - Nueva fecha creacion Solicitud: ' || to_date(rfOrdenes.FechaCreacionSolicitud,'DD/MM/YYYY HH:MI:SS AM'));
        
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