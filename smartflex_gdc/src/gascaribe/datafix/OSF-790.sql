column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    --<< Cantidad Legalizada, Valor 
    nuNewValue   NUMBER := 0;
    -->>

    cursor cuPoblacion
    IS
    select  oi.*
    from    open.or_order_items oi,
            open.ge_items gi
    where   gi.ITEMS_ID = oi.ITEMS_ID
    and     oi.order_id in (271315234, 271315298)
    and     gi.ITEM_CLASSIF_ID <> 2;
    
begin
  dbms_output.put_line('---- Inicio OSF-790 ----');

  for reg in cuPoblacion
  loop
    update  OPEN.OR_ORDER_ITEMS
    set     LEGAL_ITEM_AMOUNT = nuNewValue,
            VALUE = nuNewValue
    WHERE   OR_ORDER_ITEMS.ORDER_ID = reg.ORDER_ID
    AND     OR_ORDER_ITEMS.items_id = reg.items_id;
    
    dbms_output.put_line('Actualizando [OR_ORDER_ITEMS] orden ['||reg.ORDER_ID||'] --> LEGAL_ITEM_AMOUNT Actual ['||reg.LEGAL_ITEM_AMOUNT||'] Nuevo ['||nuNewValue||'] --> VALUE Actual ['||reg.VALUE||'] Nuevo ['||nuNewValue||']');
  end loop;

  COMMIT;
  dbms_output.put_line('---- Fin OSF-790 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-790 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/