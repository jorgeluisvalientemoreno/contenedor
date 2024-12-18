column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cudesgestionarOT is
    select 293158221 orden from dual union all
    select 293158222 orden from dual union all
    select 293158223 orden from dual union all
    select 293158224 orden from dual union all
    select 293158225 orden from dual union all
    select 293158226 orden from dual union all
    select 293158227 orden from dual union all
    select 293158228 orden from dual union all
    select 293158229 orden from dual union all
    select 293158230 orden from dual union all
    select 293158239 orden from dual union all
    select 293158240 orden from dual union all
    select 293158241 orden from dual union all
    select 293158243 orden from dual union all
    select 293158244 orden from dual union all
    select 293158245 orden from dual union all
    select 293158246 orden from dual union all
    select 293158247 orden from dual union all
    select 293158248 orden from dual union all
    select 293158249 orden from dual union all
    select 293158261 orden from dual union all
    select 293158262 orden from dual union all
    select 293158263 orden from dual union all
    select 293158264 orden from dual union all
    select 293158265 orden from dual union all
    select 293158266 orden from dual union all
    select 293158267 orden from dual union all
    select 293158268 orden from dual union all
    select 293158270 orden from dual union all
    select 293158271 orden from dual union all
    select 293158277 orden from dual union all
    select 293158278 orden from dual union all
    select 293158279 orden from dual union all
    select 293158280 orden from dual union all
    select 293158281 orden from dual union all
    select 293158282 orden from dual union all
    select 293158283 orden from dual union all
    select 293158284 orden from dual union all
    select 293158285 orden from dual union all
    select 293158286 orden from dual union all
    select 293158291 orden from dual union all
    select 293158292 orden from dual union all
    select 293158293 orden from dual union all
    select 293158294 orden from dual ;

  rfcudesgestionarOT cudesgestionarOT%rowtype;

begin

  dbms_output.put_line('Inicio LDC_PKGESTIONORDENES.PrDesgestionarOT');

  for rfcudesgestionarOT in cudesgestionarOT loop
  
    begin
      delete from ldc_otlegalizar t
       where order_id = rfcudesgestionarOT.Orden;
    
      delete from ldc_otadicional t
       where order_id = rfcudesgestionarOT.Orden;
    
      delete from ldc_otdalegalizar t
       where order_id = rfcudesgestionarOT.Orden;
    
      delete from ldc_otadicionalda t
       where order_id = rfcudesgestionarOT.Orden;
    
      delete from LDC_ANEXOLEGALIZA t
       where order_id = rfcudesgestionarOT.Orden;
    
      delete from ldc_otitem t where order_id = rfcudesgestionarOT.Orden;
    
      delete from ldc_otdatoactividad t
       where order_id = rfcudesgestionarOT.Orden;
    
      delete from LDC_DATOACTIVIDADOTADICIONAL t
       where order_id = rfcudesgestionarOT.Orden;
       
      commit;
    
      dbms_output.put_line('Orden ' || rfcudesgestionarOT.Orden ||
                           ' eliminada de LEGO');
    
    exception
      when others then
        DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
        rollback;
    end;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/