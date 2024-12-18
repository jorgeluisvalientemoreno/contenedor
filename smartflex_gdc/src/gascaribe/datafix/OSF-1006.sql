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
  and     mt.subscription_id in (
67232623,
67247379,
67249545,
67250231,
67251871,
67253112,
67257538,
67258853,
67263970,
67266929,
67267002,
67267004,
67268167,
67268173,
67268318,
67268621,
67271004,
67271963,
67271972,
67272417,
67272959,
67273464,
67273493,
67277948,
67278482,
672100679,
67283764,
67284953,
67287253,
67289637,
67290850,
67290896,
67290897,
67291065,
67291113,
67291418,
67291594,
67294424,
67294667,
67294675,
67294681,
67295657,
67297423,
67297757,
67298245,
67298593,
67301630,
67305930,
67306053,
67306404,
67313642,
67313742,
67314509,
67317588,
67319081,
67333867,
67334577,
67335273,
67336487,
67337462,
67337895,
67338126,
67340096,
67340545,
67340591,
67340603,
67341011,
67341276,
67341397,
67341828,
67342645,
67343266,
67343953,
67343970,
67343986,
67343997,
67346300,
67347042,
67348212,
67348456,
67348660,
67348664,
67349268,
67349304,
67349339,
67349447,
67349647,
67350347,
67350468,
67350543,
67350774,
67350779,
67350918,
67351770,
67353618,
67353982,
67354016,
67354088,
67354156,
67354161,
67354201,
67354307,
67354466,
67354645,
67355981,
67356203,
67356340,
67356551,
67356669,
67356858,
67357467,
67357484,
67357666,
67357770,
67357785,
67357839,
67357882,
67358008,
67358019,
67358030,
67358034,
67358368,
67358390,
67358447,
67358465,
67358484,
67358684,
67358708,
67358954,
67359256,
67359273,
67359288,
67359314,
67359323,
67359334,
67359373,
67359430,
67359433,
67359439,
67359452,
67359462,
67359463,
67359468,
67359471,
67359503,
67359512,
67360074,
67360199,
67360345,
67360355,
67360358,
67360369,
67360379,
67360469,
67361036,
67361044,
67361066,
67361140,
67361155,
67361159,
67361170,
67361177,
67361233,
67361255,
67361275,
67361398,
67361418,
67361424,
67361534,
67361546,
67361576,
67361668,
67361720,
67361727,
67361763,
67361778,
67361885,
67362042,
67362140,
67363251,
67363390,
67363533,
67363617,
67363733,
67363858,
67364303,
67364325,
67364340,
67364687,
67365719,
67366596,
67367423
  );

begin
  dbms_output.put_line('---- Inicio OSF-1006 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.OR_ORDER_ACTIVITY
    SET     OR_ORDER_ACTIVITY.PACKAGE_ID = NULL,
            OR_ORDER_ACTIVITY.MOTIVE_ID = NULL
    WHERE   ORDER_ID = reg.ORDER_ID;
    dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] PACKAGE_ID actual ['||reg.PACKAGE_ID||'] - MOTIVE_ID Actual [' ||reg.MOTIVE_ID||']');

    nuCommentType := 1277;

    isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] pertenecia a la solicitud ['||reg.PACKAGE_ID||'] y al motivo [' ||reg.MOTIVE_ID||'] - Se desvinculan por el Caso OSF-1006';

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

  dbms_output.put_line('---- Fin OSF-1006 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1006----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/