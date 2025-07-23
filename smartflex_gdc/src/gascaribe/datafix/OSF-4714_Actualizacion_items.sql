column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  dbms_output.put_line('Inicia OSF-4714 !');

  UPDATE ge_items_seriado 
  SET operating_unit_id = 1773  
  WHERE serie IN ('K-123799-24',
  'K-124365-24',
  'K-124429-24',
  'K-124700-24',
  'K-122732-24',
  'K-126342-24',
  'K-122861-24',
  'K-123485-24',
  'K-123862-24',
  'K-125868-24'
  );

  dbms_output.put_line('Inicio Actualizando intentos a 0');
  UPDATE ldci_intemmit 
  SET  mmitinte = 0
  WHERE mmitcodi = 105464;
  dbms_output.put_line('FIn Actualizando intentos a 0');

  dbms_output.put_line('Fin OSF-4714 !');
  COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/