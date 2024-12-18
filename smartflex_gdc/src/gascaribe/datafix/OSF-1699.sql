column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  UPDATE GE_ITEMS_SERIADO
    SET OPERATING_UNIT_ID=1933
    WHERE SERIE='TA-2081111008-22';

  UPDATE LDCI_INTEMMIT
     SET MMITINTE=0
    WHERE MMITCODI=95165;

    COMMIT;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/