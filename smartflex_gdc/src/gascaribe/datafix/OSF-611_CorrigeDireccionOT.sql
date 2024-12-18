column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuError NUMBER;
  sbError  VARCHAR2(4000);
  
  CURSOR cuGetOrdenes IS
  select  pr_product.ADDRESS_ID, or_order.order_id
  from open.or_order, 
       open.or_order_activity,
       open.pr_product 
  where or_order_activity.order_id = or_order.order_id
   and or_order_activity.product_id = pr_product.product_id
   and or_order_activity.activity_id in (4000031,4000980)
   and or_order.created_date >= to_date('13/05/2022 04:25:11','dd/mm/yyyy hh24:mi:ss')
   and or_order.external_address_id is null;
   
BEGIN
  FOR reg IN cuGetOrdenes LOOP
    update open.OR_EXTERN_SYSTEMS_ID set ADDRESS_ID = REG.ADDRESS_ID
    where order_id = REG.order_id;
    
    update or_order_activity set ADDRESS_ID = REG.ADDRESS_ID
    where order_id = REG.order_id;
    
    update or_order set external_address_id = REG.ADDRESS_ID
    where order_id = REG.order_id;
    COMMIT;
  END LOOP;
  
EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuError, sbError);
    DBMS_OUTPUT.PUT_LINE('ERROR OTHERS '||sbError);
    rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/