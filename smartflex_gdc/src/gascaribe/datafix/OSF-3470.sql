column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  --Se realiza cambio del periodo de facturación a -1 y se borrar la observación de pecofact por instrucciones Luis Javier Lopez, 
  --para que la facturación electronica recurrente vuelva a tomar el periodo que ya ha sido facturado previamente.
  update personalizaciones.lote_fact_electronica
     set periodo_facturacion = -1
   where periodo_facturacion=113635
     and tipo_documento=1;

  update ldc_pecofact
     set pcfaobse = null
   where pcfapefa=113635;
   commit;
exception
  when others then
    rollback;
    dbms_output.put_line('Error :'||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/