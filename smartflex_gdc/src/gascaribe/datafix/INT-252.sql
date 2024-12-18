column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DELETE FROM OPEN.LDCI_INFGESTOTMOV WHERE MENSAJE_ID IN (3142224,
3142225,
3142226,
3159094,
3166846,
3166847,
3189391,
3192216,
3192217,
3192218,
3192219,
3192220,
3251047,
3251048,
3251049,
3251050,
3251430);
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/