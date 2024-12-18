column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuClientes is
    select s.susccodi       Contrato,
           gs.subscriber_id cliente,
           s.susciddi       contrato_direccion,
           gs.address_id    cliente_direccion
      from OPEN.SUSCRIPC s, open.ge_subscriber gs
     where s.suscclie = gs.subscriber_id
       and gs.address_id is not null
       and not exists (select 1
              from OPEN.AB_ADDRESS aa
             where aa.address_id = gs.address_id);

  rfClientes cuClientes%rowtype;

begin

  for rfClientes in cuClientes loop
  
    begin
      update OPEN.GE_SUBSCRIBER gs
         set gs.address_id = rfClientes.contrato_direccion
       where gs.subscriber_id = rfClientes.cliente;
    
      commit;
    
      dbms_output.put_line('El Contrato ' || rfClientes.Contrato ||
                           ' actualiza el Codigo de la Direccion del cliente [' ||
                           rfClientes.cliente_direccion ||
                           '] por el Codigo de la Direccion del Contrato [' ||
                           rfClientes.contrato_direccion || ']');
    
    exception
      when others then
        dbms_output.put_line('Error - ' || sqlerrm);
    end;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/