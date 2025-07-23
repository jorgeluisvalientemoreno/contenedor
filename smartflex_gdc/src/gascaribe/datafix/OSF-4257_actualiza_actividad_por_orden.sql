column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  CURSOR cuDATA IS
    with ot as
     (select /*+ index(oo)*/
       oo.order_id, ooa.order_item_id, oo.created_date, oo.task_type_id
        from open.or_order oo, open.Or_Order_Activity ooa
       where ooa.order_id = oo.order_id
         and oo.task_type_id = 10005
         and not exists (select ooi1.order_id /*+ index(ooi1)*/
                from OPEN.OR_ORDER_ITEMS ooi1
               where ooi1.order_id = oo.order_id))
    select /*+ index(ooi)*/
     ot.order_id      OT_REAL,
     ot.task_type_id  TT,
     ot.created_date  FECHA_CREACION_OT_REAL,
     ooi.order_id     OT_IMCOMPLETA,
     ot.order_item_id ORDER_ITEMS_ID
      from open.or_ordeR_items ooi, ot
     where ot.order_item_id = ooi.order_items_id
       and ot.order_id <> ooi.order_id
     order by ot.created_date;

  rfcuDATA cuDATA%ROWTYPE;

BEGIN

  FOR rfcuDATA in cuDATA LOOP
  
    BEGIN
      update OR_ORDER_ITEMS ooi
         set ooi.order_id = rfcuDATA.OT_REAL
       where ooi.order_items_id = rfcuDATA.ORDER_ITEMS_ID;
      
      commit;    
      dbms_output.put_line('Orden ' || rfcuDATA.OT_REAL ||
                           ' reemplazara la orden ' ||
                           rfcuDATA.OT_IMCOMPLETA ||
                           ' en OR_ORDER_ITEMS con el Codigo : ' ||
                           rfcuDATA.ORDER_ITEMS_ID);
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error con la orden ' || rfcuDATA.OT_REAL ||
                             ' al reemplazara ' || rfcuDATA.OT_IMCOMPLETA ||
                             ' en OR_ORDER_ITEMS con el Codigo : ' ||
                             rfcuDATA.ORDER_ITEMS_ID || ' - ' || sqlerrm);
    END;
  
  END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/