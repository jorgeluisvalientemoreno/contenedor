column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  cursor cuSolicitudes is
        SELECT p2.package_id,
                p2.request_Date,
                p2.motive_status_id,
                p2.user_id,
                p2.comment_,
                p2.cust_care_reques_num,
                p2.package_type_id
        FROM OPEN.mo_packages p
        INNER JOIN OPEN.mo_packages p2 on p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
        WHERE p.package_id IN (11807426)
		AND p2.motive_status_id = 13
        ORDER BY  p2.package_id;

  CURSOR cuOrderActiv is
    select product_id PRODUCTO, oa.order_id ORDEN, oa.task_type_id, o.causal_id CAUSAL, gc.class_causal_id, o.order_status_id
    from open.or_order_activity oa 
    inner join open.or_order o ON  oa.order_id = o.order_id
    left join open.ge_causal gc ON o.causal_id = gc.causal_id
    where oa.package_id = 11807426--cnuPackage_id 
    and nvl(gc.class_causal_id,0) != 1 
    and o.order_status_id  in (12)
    and rownum= 1;

BEGIN
  dbms_output.put_line('Inicia datafix OSF-2630');

      --Recorrer ordenes del contrato de venta a constructora
  FOR rcOrderActiv in cuOrderActiv LOOP
      -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
      update pr_product
      set product_status_id = 16,  -- Retirado sin instalacion
      suspen_ord_act_id = null,
      retire_date = sysdate
      where product_id = rcOrderActiv.PRODUCTO;

      -- Estado de corte
      pktblservsusc.updsesuesco(rcOrderActiv.PRODUCTO, 110    -- Retiro para el tipo de producto 6121
                                  -- 110 -- Retirado sin instalacion. para el tipo de producto 7014
          ); 

      UPDATE servsusc
      SET    sesufere = sysdate
      WHERE  sesunuse = rcOrderActiv.PRODUCTO;

      -- componente del producto
      update pr_component
      set component_status_id = 18  -- Retirado sin instalacion
      where product_id = rcOrderActiv.PRODUCTO;

      update compsesu
      set cmssescm = 18,  --
      cmssfere = sysdate
      where cmsssesu = rcOrderActiv.PRODUCTO;
  END LOOP;

  COMMIT;
  dbms_output.put_line('Fin datafix OSF-2630');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/