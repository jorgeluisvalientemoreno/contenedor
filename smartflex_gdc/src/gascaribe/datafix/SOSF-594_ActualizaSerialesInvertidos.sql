column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
 --  Actualiza serial en la tabla ELEMMEDI para los 2 elementos de medición
 --  Se actualiza elemento de medicion 2484886 con serial temporal para realizar el cambio por ser indice único
 update open.ELEMMEDI e
   set e.elmecodi = 'S-2198812-21-INV'
 WHERE e.elmeidem = 2484886;
 commit;
-- elemento de Medicion 2484877 tiene serial S-2198812-21 y el correcto es: S-2198821-21
 update open.ELEMMEDI e
   set e.elmecodi = 'S-2198821-21'
 WHERE e.elmeidem = 2484877;
 commit;
-- elemento de Medicion 2484886 tiene serial S-2198821-21-INV y el correcto es: S-2198812-21
 update open.ELEMMEDI e
   set e.elmecodi = 'S-2198812-21'
 WHERE e.elmeidem = 2484886;
 commit;
--Actualiza el serial en la tabla de elementos de medición por servicio suscrito
-- actualizo para el elemento de medición 2484886 que corresponde al producto 51589901 y contrato 66723979 el serial S-2198812-21
 update open.ELMESESU s
   set s.emsscoem = 'S-2198812-21'
 where s.emsselme = 2484886;
 commit;
-- actualizo para el elemento de medición 2484877 que corresponde al producto 50154857 y contrato 48105304 el serial S-2198821-21
 update open.ELMESESU s
   set s.emsscoem = 'S-2198821-21'
 where s.emsselme = 2484877;
  commit;
 -- actualizo serie en ge-items-seriado para el item seriado : 2482655 con valor temporal
 update open.ge_items_seriado s
   set s.serie = 'S-2198821-21-INV'
 where s.id_items_seriado = 2482655;
 commit;
-- actualizo serie en ge-items-seriado para el item seriado : 2482664
 update open.ge_items_seriado s
   set s.serie = 'S-2198812-21'
 where s.id_items_seriado = 2482664;
 commit;
-- actualizo serie en ge-items-seriado para el item seriado : 2482655 
 update open.ge_items_seriado s
   set s.serie = 'S-2198821-21'
 where s.id_items_seriado = 2482655;
 commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/