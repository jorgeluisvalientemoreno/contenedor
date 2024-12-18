column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
-- Actualizo saldo a favor del contrato
  update open.suscripc s
     set s.suscsafa = 0
 where s.susccodi = 67251203;
 
-- Actualizo saldo a favor del producto
Update  open.servsusc v
   set v.sesusafa = 0
 where v.sesunuse = 52392202;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/