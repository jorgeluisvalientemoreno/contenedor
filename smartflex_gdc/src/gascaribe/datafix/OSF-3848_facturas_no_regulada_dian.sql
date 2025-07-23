column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  UPDATE procejec SET prejprog = '_'||prejprog
  WHERE prejcope IN ( 114913, 114914)
  AND PREJPROG in ('FGCC','FGDP');
 
  update open.ldc_pecofact set PCFAOBSE= null
  where PCFAPEFA  IN ( 114913, 114914);

  update lote_fact_electronica set PERIODO_FACTURACION = -1
  where periodo_facturacion IN ( 114913, 114914);

  commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/