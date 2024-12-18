column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  execute immediate 'GRANT EXECUTE ON LDCI_PKIVR TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKBSSFACCTTO TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKCRMCONTRATOS TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKCRMFINBRILLA TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKBSSRECA TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKBSSCARBRILLA TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKBSSPORTALWEB TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKBSSFACTCONS TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKCRMSOLICITUD TO REXEINNOVA';
  execute immediate 'GRANT EXECUTE ON LDCI_PKFACTKIOSCO_GDC TO REXEINNOVA';
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/