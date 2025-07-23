column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cudesgestionarOT is
    select 353123918 orden from dual;

  rfcudesgestionarOT cudesgestionarOT%rowtype;

begin

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