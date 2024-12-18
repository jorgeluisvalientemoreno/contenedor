column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuCommentType   number;
  isbOrderComme   varchar2(4000);
  nuErrorCode     number;
  sbErrorMesse    varchar2(4000);

  -- Poblacion a la que aplica el Datafix
  CURSOR cuPoblacion IS
  select  oa.order_id,
          oa.status as Estado_Orden,
          oo.order_status_id as Estado_OT,
          oa.task_type_id as Tipo_trabajo,
          (select t.description from open.or_task_type t where t.task_type_id = oo.task_type_id) as Desc_Tipo_Trabajo,
          oo.legalization_date as Fecha_legalizacion,
          oa.package_id,
          oa.motive_id,
          mt.subscription_id as Contrato,
          gc.causal_id as Causal,
          gc.description as Descripcion_Causal,
          gc.CLASS_CAUSAL_ID,
          s.sesunuse,
          s.sesuesco,
          p.product_status_id
  from    open.or_order oo
          INNER JOIN open.or_order_activity oa ON (oo.order_id = oa.order_id)
          INNER JOIN open.ge_causal gc ON (oo.causal_id = gc.causal_id)
          INNER JOIN OPEN.MO_PACKAGES mp ON (oa.package_id = mp.package_id) 
          INNER JOIN open.mo_motive mt ON (mt.package_id = mp.package_id)
          INNER JOIN OPEN.SERVSUSC s ON (mt.product_id = s.sesunuse)
          INNER JOIN OPEN.pr_product p ON (p.product_id = s.sesunuse)
where     mp.package_type_id = 271   
  and     gc.CLASS_CAUSAL_ID = 1
  and     mt.subscription_id in (
                                  67253849, 67254600, 67294388, 67297426, 67299649, 
                                  67305616, 67334745, 67337736, 67340743, 67342150, 
                                  67343074, 67343619, 67344637, 67345874, 67349808, 
                                  67352121, 67356079, 67358450, 67362197
  )
  and s.sesuesco <> 1
  and p.product_status_id <> 1;

begin
  dbms_output.put_line('---- Inicio OSF-800 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.OR_ORDER_ACTIVITY
    SET     OR_ORDER_ACTIVITY.PACKAGE_ID = NULL,
            OR_ORDER_ACTIVITY.MOTIVE_ID = NULL
    WHERE   ORDER_ID = reg.ORDER_ID;
    dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] PACKAGE_ID actual ['||reg.PACKAGE_ID||'] - MOTIVE_ID Actual [' ||reg.MOTIVE_ID||']');

    nuCommentType := 1277;

    isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] pertenecia a la solicitud ['||reg.PACKAGE_ID||'] y al motivo [' ||reg.MOTIVE_ID||'] - Se desvinculan por el Caso OSF-800';

    -- Adiciona comentario en la orden
    OS_ADDORDERCOMMENT( inuOrderId       => reg.ORDER_ID,
                        inuCommentTypeId => nuCommentType,
                        isbComment       => isbOrderComme,
                        onuErrorCode     => nuErrorCode,
                        osbErrorMessage  => sbErrorMesse);
    IF (nuErrorCode <> 0) THEN
      dbms_output.put_line('No se logro crear el comentario de La orden ['||reg.ORDER_ID||']');
    END IF;
    dbms_output.put_line('[OR_ORDER_COMMENT] - ['||isbOrderComme||']');

  END LOOP;

  COMMIT;

  dbms_output.put_line('---- Fin OSF-800 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-800 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/