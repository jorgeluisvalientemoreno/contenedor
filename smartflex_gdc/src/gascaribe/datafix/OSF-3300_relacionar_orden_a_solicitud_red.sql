column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuSolicitudesRed is
    select mp.package_id Solicitud, mp.request_date fecha_inicial
      from open.mo_packages mp
     where mp.package_type_id = 100207
       and mp.request_date >= '12/09/2023'
       and (select count(1)
              from open.Or_Order_Activity ooac
             where ooac.package_id = mp.package_id) = 0
     group by mp.package_id, mp.request_date
     order by mp.request_date asc;

  rfSolicitudesRed cuSolicitudesRed%rowtype;

  cursor cuOrdenRed(dtfecha_inicial date, dtfecha_final date) is
    select ooa.order_id orden, ooa.register_date fecha_creacion
      from open.or_order_activity ooa
     where ooa.register_date between dtfecha_inicial and dtfecha_final
       and ooa.activity_id in (4294457, -- GESTIONAR DATOS Y DOCUMENTOS DE EXTENSION DE RED COMERCIAL
                               4295106, -- GESTIONAR DATOS Y DOCUMENTOS SOLICITUD DE RED INDUSTRIAL
                               4000614 -- GESTIONAR DATOS Y DOCUMENTOS DE EXTENSION DE RED RESIDENCIAL
                               )
       and ooa.package_id is null
       and ooa.status = 'F';

  rfOrdenRed cuOrdenRed%rowtype;

  nuMinutos number;

begin

  for rfSolicitudesRed in cuSolicitudesRed loop

    for nuMinutos in 1 .. 120 loop

      if cuOrdenRed%isopen then
        close cuOrdenRed;
      end if;

      open cuOrdenRed(rfSolicitudesRed.fecha_inicial,
                      (rfSolicitudesRed.fecha_inicial + nuMinutos / 1440));
      fetch cuOrdenRed
        into rfOrdenRed;
      if cuOrdenRed%found then

        begin

          update open.Or_Order_Activity ooa
             set ooa.package_id = rfSolicitudesRed.Solicitud
           where ooa.order_id = rfOrdenRed.orden;
          commit;
          --/*
          dbms_output.put_line('Se relaciona Solicitud de Red: ' ||
                               rfSolicitudesRed.Solicitud ||
                               ' con la orden: ' || rfOrdenRed.orden);
          --*/
          exit;

        exception
          when others then
            rollback;
            dbms_output.put_line('No se relaciona Solicitud de Red: ' ||
                                 rfSolicitudesRed.Solicitud ||
                                 ' con la orden: ' || rfOrdenRed.orden ||
                                 ' - Error: ' || sqlerrm);

        end;

      end if;
      close cuOrdenRed;
    end loop;
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/