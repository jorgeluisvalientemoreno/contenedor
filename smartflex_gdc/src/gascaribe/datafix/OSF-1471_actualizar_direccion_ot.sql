column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuError NUMBER;
  sbError VARCHAR2(4000);

  CURSOR cuGetOrdenes IS
    select oo.order_id,
           pp.ADDRESS_ID DIRECCION_PRODUCTO,
           (select aa.address
              from open.ab_address aa
             where aa.address_id = pp.address_id) DIRECCION_PRODUCTO_DESC,
           oo.order_id ORDEN,
           oo.external_address_id DIRECCION_ORDEN,
           (select aa.address
              from open.ab_address aa
             where aa.address_id = oo.external_address_id) DIRECCION_ORDEN_DESC
      from open.or_order             oo,
           open.or_order_activity    ooa,
           open.OR_EXTERN_SYSTEMS_ID oes,
           open.pr_product           pp
     where ooa.package_id = 201953770
       and ooa.order_id = oo.order_id
       AND OOA.ORDER_ID = oes.Order_Id
       and ooa.product_id = pp.product_id
       AND OOA.ADDRESS_ID <> PP.ADDRESS_ID;

BEGIN
  FOR reg IN cuGetOrdenes LOOP
    update open.OR_EXTERN_SYSTEMS_ID
       set ADDRESS_ID = REG.DIRECCION_PRODUCTO
     where order_id = REG.order_id;
  
    update or_order_activity
       set ADDRESS_ID = REG.DIRECCION_PRODUCTO
     where order_id = REG.order_id;
  
    update or_order
       set external_address_id = REG.DIRECCION_PRODUCTO
     where order_id = REG.order_id;
    COMMIT;
  
    dbms_output.put_line('Orden [' || REG.order_id ||
                         '] Se actualiza direcion [' ||
                         REG.DIRECCION_ORDEN_DESC ||
                         '] a la direcion de producto [' ||
                         REG.DIRECCION_PRODUCTO_DESC || ']');
  
  END LOOP;

EXCEPTION
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