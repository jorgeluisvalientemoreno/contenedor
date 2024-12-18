column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE	
	nuSolicitud  	mo_packages.package_id%TYPE := 188714892;
	sbFormatoFecha	VARCHAR2(40) := 'DD/MM/YYYY HH24:MI:SS';
	dtFechaFin		DATE := TO_DATE( '31/12/2022 23:59:59', sbFormatoFecha );
begin
  update OPEN.CC_QUOTATION
     set CC_QUOTATION.end_date = dtFechaFin 
   where CC_QUOTATION.package_id = nuSolicitud;

  update open.ldc_cotizacion_comercial
     set ldc_cotizacion_comercial.fecha_vigencia = dtFechaFin
   where ldc_cotizacion_comercial.sol_cotizacion = nuSolicitud;

  commit;
  dbms_output.put_line('Se pudo actualiza fecha de vencimiento a ' || TO_CHAR( dtFechaFin, sbFormatoFecha ) || ' en la cotizacion ' || nuSolicitud);

exception
  when others then
    dbms_output.put_line('ERROR actualizando fecha de vencimiento en la cotizacion ' || nuSolicitud || '[' || sqlerrm || ']');
    rollback;      
end;
/
  

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/