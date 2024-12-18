column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  gsbMensaje VARCHAR2(200) := 'DATAFIX Actulizar Contrato, producto y direccion de ordenes en OSF generadas en GIS';

  nuError NUMBER;
  sbError VARCHAR2(4000);

  CURSOR cuGetDATA IS
    Select 297292469 orden, 67323008 contrato, 52488642 producto
      from dual
    union all
    Select 303983262 orden, 67187854 contrato, 52294241 producto
      from dual
    union all
    Select 303983263 orden, 67246452 contrato, 52384109 producto from dual;

  rfcuGetDATA cuGetDATA%rowtype;

  CURSOR cuGetProducto(inuProducto number) IS
    select a.*, rowid
      from open.pr_product a
     where a.product_id = inuProducto;

  rfcuGetProducto cuGetProducto%rowtype;

BEGIN

  dbms_output.put_line('Inico ' || gsbMensaje);

  for rfcuGetDATA in cuGetDATA loop
  
    begin
      open cuGetProducto(rfcuGetDATA.producto);
      fetch cuGetProducto
        into rfcuGetProducto;
      close cuGetProducto;
    
      update open.OR_EXTERN_SYSTEMS_ID
         set ADDRESS_ID = rfcuGetProducto.address_id
       where order_id = rfcuGetDATA.orden;
    
      update or_order_activity
         set ADDRESS_ID      = rfcuGetProducto.address_id,
             subscription_id = rfcuGetDATA.contrato,
             product_id      = rfcuGetDATA.producto
       where order_id = rfcuGetDATA.orden;
    
      update or_order
         set external_address_id = rfcuGetProducto.address_id
       where order_id = rfcuGetDATA.orden;
      COMMIT;
      --rollback;
    
      dbms_output.put_line('Actualizar direccion[' ||
                           rfcuGetProducto.address_id || '] - Producto[' ||
                           rfcuGetDATA.producto || '] - Contrato [' ||
                           rfcuGetDATA.contrato || '] de la Orden: ' ||
                           rfcuGetDATA.orden);
    exception
      WHEN OTHERS THEN
        ERRORS.SETERROR;
        ERRORS.GETERROR(nuError, sbError);
        dbms_output.put_line('Error al actualizar la orden ' ||
                             rfcuGetDATA.orden || ' - ' || sqlerrm ||
                             ' - ' || sbError);
        rollback;
    end;
  end loop;

  dbms_output.put_line('Fin ' || gsbMensaje);
exception
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuError, sbError);
    DBMS_OUTPUT.PUT_LINE('ERROR OTHERS ' || sbError);
    rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/