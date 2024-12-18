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
          (select description from open.or_task_type where task_type_id = oo.task_type_id) as Desc_Tipo_Trabajo,
          oo.legalization_date as Fecha_legalizacion,
          oa.package_id,
          oa.motive_id,
          mt.subscription_id as Contrato,
          gc.causal_id as Causal,
          gc.description as Descripcion_Causal,
          gc.CLASS_CAUSAL_ID
  from    open.or_order oo,
          open.or_order_activity oa,
          open.ge_causal gc,
          OPEN.MO_PACKAGES mp,
          open.mo_motive mt
  where   oo.order_id = oa.order_id
  and     oo.causal_id = gc.causal_id
  and     mp.package_id = mt.package_id
  and     oa.package_id = mp.package_id
  and     mp.package_type_id = 271   
  and     gc.CLASS_CAUSAL_ID = 1
  and     mt.subscription_id in (67350492,67364077);

begin
  dbms_output.put_line('---- Inicio OSF-957 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.OR_ORDER_ACTIVITY
    SET     OR_ORDER_ACTIVITY.PACKAGE_ID = NULL,
            OR_ORDER_ACTIVITY.MOTIVE_ID = NULL
    WHERE   ORDER_ID = reg.ORDER_ID;
    dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] PACKAGE_ID actual ['||reg.PACKAGE_ID||'] - MOTIVE_ID Actual [' ||reg.MOTIVE_ID||']');

    nuCommentType := 1277;

    isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] pertenecia a la solicitud ['||reg.PACKAGE_ID||'] y al motivo [' ||reg.MOTIVE_ID||'] - Se desvinculan por el Caso OSF-957';

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

  dbms_output.put_line('---- Fin OSF-957 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-957----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/