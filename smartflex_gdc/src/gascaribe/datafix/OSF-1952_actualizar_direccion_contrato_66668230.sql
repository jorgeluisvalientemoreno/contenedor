column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  gsbMensaje VARCHAR2(200) := 'DATAFIX Actulizar Direccion cliente';

  cursor cuDireccionContrato is
    select a1.address_id    direccion_prodcuto,
           a2.address_id    direccion_cliente,
           a3.susccodi      contrato,
           a2.subscriber_id cliente
      from open.pr_product    a,
           open.ab_address    a1,
           open.ge_subscriber a2,
           open.suscripc      a3
     where a.subscription_id = 66668230
       and a.address_id = a1.address_id
       and a.subscription_id = a3.susccodi
       and a2.subscriber_id = a3.suscclie
       and rownum = 1;

  rfcuDireccionContrato cuDireccionContrato%rowtype;

BEGIN

  dbms_output.put_line('Inico ' || gsbMensaje);

  open cuDireccionContrato;
  fetch cuDireccionContrato
    into rfcuDireccionContrato;
  close cuDireccionContrato;

  update open.ge_subscriber gs
     set gs.address_id = rfcuDireccionContrato.direccion_prodcuto
   where gs.subscriber_id = rfcuDireccionContrato.cliente
     and gs.address_id = rfcuDireccionContrato.direccion_cliente;

  COMMIT;

  dbms_output.put_line('Actualizar direccion del suscripctor: ' ||
                       rfcuDireccionContrato.direccion_cliente ||
                       ' por direccion del producto: ' ||
                       rfcuDireccionContrato.direccion_prodcuto ||
                       ' asociado al contrato: ' ||
                       rfcuDireccionContrato.contrato);

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

        