column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  CURSOR cuDirecciones
  (
    idDireccion IN ab_address.address_id%TYPE
  )
  IS
  SELECT  * 
  FROM    ab_address 
  WHERE address_id = idDireccion;

  rcDirecciones ab_address%ROWTYPE;

  CURSOR cuCliente
  IS
  SELECT  * 
  FROM    ge_subscriber 
  WHERE subscriber_id IN (SELECT suscclie FROM suscripc WHERE susccodi IN (67214737));

  rcCliente ge_subscriber%ROWTYPE;
begin

  dbms_output.put_line('ACtualizando nombre cliente');

  OPEN cuCliente;
  FETCH  cuCliente INTO rcCliente;
  CLOSE cuCliente;

  dbms_output.put_line('Número de caracteres cliente: '||length(rcCliente.subscriber_name));

  UPDATE  ge_subscriber
  SET subscriber_name = 'RESTAURANTE HOTEL CASINO LOS RANCHOS S.A.S'
  WHERE subscriber_id in (select suscclie from suscripc where susccodi in (67214737));

  OPEN cuCliente;
  FETCH  cuCliente INTO rcCliente;
  CLOSE cuCliente;
  commit;

  dbms_output.put_line('Despues Número de caracteres cliente: '||length(rcCliente.subscriber_name));
exception
  when others then
    rollback;
    execute immediate 'alter trigger TRGBIDURAB_ADDRESS enable';
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/