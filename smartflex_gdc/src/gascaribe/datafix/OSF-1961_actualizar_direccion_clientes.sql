column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  gsbMensaje VARCHAR2(200) := 'DATAFIX Actulizar Direccion clientes';

  cursor cuDireccionCliente is
    select gs.subscriber_id Cliente,
           gs.address_id    CodigoDireccion,
           s.susccodi       Contrato,
           pp.address_id    DireccionProducto
      from open.ge_subscriber gs
      left join open.suscripc s
        on s.suscclie = gs.subscriber_id
      left join open.pr_product pp
        on pp.subscription_id = s.susccodi
     where (select count(1)
              from open.ab_address aa
             where aa.address_id = gs.address_id) = 0
       and gs.address_id is not null
     order by contrato desc;

  rfcuDireccionCliente cuDireccionCliente%rowtype;

BEGIN

  dbms_output.put_line('Inico ' || gsbMensaje);

  for rfcuDireccionCliente in cuDireccionCliente loop
  
    if rfcuDireccionCliente.Contrato is null then
      update open.ge_subscriber gs
         set gs.address_id = null
       where gs.subscriber_id = rfcuDireccionCliente.Cliente
         and gs.address_id = rfcuDireccionCliente.CodigoDireccion;
      COMMIT;
      --rollback;
      dbms_output.put_line('Actualizar direccion[' ||
                           rfcuDireccionCliente.CodigoDireccion ||
                           '] del cliente: ' ||
                           rfcuDireccionCliente.Cliente || ' por null');
    else
      update open.ge_subscriber gs
         set gs.address_id = rfcuDireccionCliente.DireccionProducto
       where gs.subscriber_id = rfcuDireccionCliente.Cliente
         and gs.address_id = rfcuDireccionCliente.CodigoDireccion;
      COMMIT;
      --rollback;
      dbms_output.put_line('Actualizar direccion[' ||
                           rfcuDireccionCliente.CodigoDireccion ||
                           '] del cliente: ' ||
                           rfcuDireccionCliente.Cliente ||
                           ' por la direccion[' ||
                           rfcuDireccionCliente.DireccionProducto ||
                           '] del producto asociado al contrato: ' ||
                           rfcuDireccionCliente.Contrato);
    
    end if;
  
  end loop;

  dbms_output.put_line('Fin ' || gsbMensaje);

exception
  when others then
    dbms_output.put_line('Error al actualizar direccion del contrato 66668230 - ' ||
                         sqlerrm);
    rollback;
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        