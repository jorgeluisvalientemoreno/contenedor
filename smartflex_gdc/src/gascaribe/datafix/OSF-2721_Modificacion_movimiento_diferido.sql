column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update movidife set modivacu =384324 where modidife = 1990 and modisusc = 1504681 and modicuap = 0;

  Insert into MOVIDIFE
   (MODIDIFE, MODISUSC, MODISIGN, MODIFECH, MODIFECA, 
    MODICUAP, MODIVACU, MODIDOSO, MODICACA, MODIUSUA, 
    MODITERM, MODIPROG, MODINUSE, MODIDIIN, MODIPOIN, 
    MODIVAIN)
 Values
   (1990, 1504681, 'CR', TO_DATE('8/02/2015 10:12:42 pm', 'DD/MM/YYYY HH:MI:SS AM'), TO_DATE('8/02/2015 10:12:42 pm', 'DD/MM/YYYY HH:MI:SS AM'), 
    45, 5377, 'Ca1990', 46, 'LUIGAR', 
    'NO TERMINAL', 'CASCA', 1504681, 0, 0, 
    0);
    
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/