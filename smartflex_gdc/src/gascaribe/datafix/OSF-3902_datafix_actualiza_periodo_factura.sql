column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update factura set factpefa =  114913 where factcodi = 2145216886;
  update cuencobr set cucofeve = to_date('31/12/2024 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
  where cucofact = 2145216886;

  update cargos set cargpefa = 114913, cargpeco = 114868, cargfecr = to_date('14/01/2025 17:15:45', 'dd/mm/yyyy hh24:mi:ss')
  where cargcuco = 3076447158;

  update lote_fact_electronica set periodo_facturacion = -1
  where periodo_facturacion = 114913;

  delete from ldc_pecofact
  where PCFAPEFA = 114913;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/