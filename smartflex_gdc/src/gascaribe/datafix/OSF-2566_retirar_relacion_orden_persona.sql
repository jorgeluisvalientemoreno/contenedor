column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  orderActivityId number := null;
  onuErrorCode    number;
  osbErrorMessage varchar2(4000);

BEGIN

  delete from OPEN.OR_ORDER_PERSON a
   where a.order_id in (320533633,
                        320540497,
                        320540504,
                        320540507,
                        320583803,
                        320969770,
                        320982023,
                        321063292,
                        321063750,
                        321233974,
                        321234455,
                        321237867,
                        321237869,
                        321242197,
                        321286903,
                        321287569,
                        321287570,
                        321430904,
                        321431812,
                        321446519,
                        321446527,
                        321478152,
                        321478183,
                        321481205,
                        321536018,
                        321536053,
                        321536083,
                        321590285,
                        321605733,
                        321607265,
                        321621449,
                        320540396,
                        320540397,
                        320854020,
                        321185675,
                        321234331,
                        321430922,
                        320868850,
                        321279632,
                        321280580,
                        320869224,
                        321432083,
                        321229818,
                        321232083,
                        321229405,
                        321062688);

  commit;
  dbms_output.put_line('Retirar relacion de orden con persona en OR_ORDER_PERSON.');

exception
  when others then
    dbms_output.put_line('Error: ' || sqlerrm);
    rollback;
  
END;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

