column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  --Se eliminan los jobs
  dbms_scheduler.drop_job(job_name => 'LDC_JOBRETIROTARTRANS');
  dbms_scheduler.drop_job(job_name => 'GENERA_DESCUENTO_DE_TARIFA');
  dbms_scheduler.drop_job(job_name => 'GEN_NOTAS_USU_TARIFA_TRANSIT');
  --se inactiva entrega
  UPDATE  ldc_versionaplica 
      SET aplica = 'N'
  WHERE codigo_entrega in (1910, 1871, 1868, 1867, 1863, 1862,1861);
  --se borra condicion del sa_tab de fidf                      
  UPDATE sa_tab SET CONDITION = null
  WHERE process_name = 'FIDF';
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/