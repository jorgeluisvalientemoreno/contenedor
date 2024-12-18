column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    cursor cudesgestionarOT is
      select distinct lol.order_id Orden
        from ldc_otlegalizar lol, or_order_activity ooa
       where lol.legalizado = 'N'
         and lol.order_id = ooa.order_id
         AND LOL.ORDER_ID = 232632687;

    rfcudesgestionarOT cudesgestionarOT%rowtype;

begin
  dbms_output.put_line('Inicia OSF-2560');

  ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrDesgestionarOT', 10);

    for rfcudesgestionarOT in cudesgestionarOT loop

      dbms_output.put_line('Orden a desgestionar [' || rfcudesgestionarOT.Orden || ']');


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
      
      delete from ldc_otitem t 
      where order_id = rfcudesgestionarOT.Orden;
      
      delete from ldc_otdatoactividad t
      where order_id = rfcudesgestionarOT.Orden;
      
      delete from LDC_DATOACTIVIDADOTADICIONAL t
      where order_id = rfcudesgestionarOT.Orden;

    end loop;

    commit;

    dbms_output.put_line('Termina OSF-2560');

EXCEPTION
    when ex.CONTROLLED_ERROR then
      DBMS_OUTPUT.PUT_LINE('Error controlado --> '||sqlerrm); 
      raise ex.CONTROLLED_ERROR;
    when others then
      DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm); 
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/