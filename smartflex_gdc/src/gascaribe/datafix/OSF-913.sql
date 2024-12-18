column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-913');
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
    and     mt.subscription_id in (67315628,
  67324531,
  67335459,
  67336509,
  67352150,
  67353829,
  67353889,
  67353892,
  67353901,
  67353920,
  67353925,
  67354004,
  67354047,
  67354086,
  67354087,
  67354096,
  67354097,
  67354101,
  67354129,
  67354184,
  67354233,
  67354245,
  67354256,
  67354274,
  67354322,
  67354325,
  67354331,
  67354333,
  67354358,
  67354469,
  67354545,
  67354552,
  67354561,
  67354584,
  67354666,
  67355097,
  67355177,
  67355211,
  67355252,
  67357239,
  67357311,
  67358681,
  67358854,
  67358915,
  67358942,
  67358945,
  67360757,
  67361884,
  67362682,
  67362698,
  67362742,
  67362750,
  67362767,
  67362780,
  67362781,
  67362794,
  67363469,
  67363647,
  67363822,
  67364061
  );

begin
  dbms_output.put_line('---- Inicio OSF-913 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.OR_ORDER_ACTIVITY
    SET     OR_ORDER_ACTIVITY.PACKAGE_ID = NULL,
            OR_ORDER_ACTIVITY.MOTIVE_ID = NULL
    WHERE   ORDER_ID = reg.ORDER_ID;
    dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] PACKAGE_ID actual ['||reg.PACKAGE_ID||'] - MOTIVE_ID Actual [' ||reg.MOTIVE_ID||']');

    nuCommentType := 1277;

    isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] pertenecia a la solicitud ['||reg.PACKAGE_ID||'] y al motivo [' ||reg.MOTIVE_ID||'] - Se desvinculan por el Caso OSF-913';

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

  dbms_output.put_line('---- Fin OSF-913 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-913----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/