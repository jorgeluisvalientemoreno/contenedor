CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCONSULTAORANPU" 
  return constants_per.tyRefCursor IS
  /*****************************************************************

  Unidad         : LDC_PRACTUALIZAORANPU
  Descripcion    : Funcion para Consultar las ordenes de anulaci?n de pagare ?nico
  Autor          : Roberto Parra
  Fecha          : 26/02/2018

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                 Modificacion
  =========       =========              ====================
  ******************************************************************/
  --Variables Usadas Durante el Proceso
  sbORDER_ID             ge_boInstanceControl.stysbValue;
  sbSUSCCODI             ge_boInstanceControl.stysbValue;
  sbPACKAGE_ID           ge_boInstanceControl.stysbValue;
  sbCREATED_DATE         ge_boInstanceControl.stysbValue;
  sbEXECUTION_FINAL_DATE ge_boInstanceControl.stysbValue;
  sbQuery                varchar2(32767);
  rfCursor               constants_per.tyRefCursor;
BEGIN

  ------------------------------------------------
  -- Required Attributes
  ------------------------------------------------

  ut_trace.trace('LDC_FNCONSULTAORANPU : Inicia funcion', 1);
  ut_trace.trace('LDC_FNCONSULTAORANPU : Asignacion de variables', 1);
  -- Se obtienen datos de la forma
  sbORDER_ID             := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                  'ORDER_ID');
  sbSUSCCODI             := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC',
                                                                  'SUSCCODI');
  sbPACKAGE_ID           := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                  'PACKAGE_ID');
  sbCREATED_DATE         := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                  'CREATED_DATE');
  sbEXECUTION_FINAL_DATE := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                  'EXECUTION_FINAL_DATE');

  ut_trace.trace('LDC_FNCONSULTAORANPU : sbORDER_ID (' || sbORDER_ID || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAORANPU : sbSUSCCODI (' || sbSUSCCODI || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAORANPU : sbPACKAGE_ID (' || sbPACKAGE_ID || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAORANPU : sbCREATED_DATE (' ||
                 sbCREATED_DATE || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAORANPU : sbEXECUTION_FINAL_DATE (' ||
                 sbEXECUTION_FINAL_DATE || ')',
                 1);

  ------------------------------------------------
  -- User code
  ------------------------------------------------
  --Se construye el select principal
  ut_trace.trace('LDC_FNCONSULTAORANPU : Construccion del select', 1);

  sbQuery := 'select
o.order_id ORDEN,
DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME(PKTBLSUSCRIPC.FNUGETSUSCCLIE(nvl(oa.subscription_id,-1))) Nombre,
oa.package_id SOLICITUD,
oa.subscription_id CONTRATO,
o.created_date FECHA_DE_CREACION,
o.assigned_date FECHA_DE_ASIGNACION,
DAMO_PACKAGES.FSBGETCOMMENT_(OA.PACKAGE_ID) OBSERVACION
  from or_order o,or_order_activity oa
 where o.order_id in
       (select order_id
          from or_order_activity oa
         where oa.package_id in
               (select m.package_id
                  from mo_packages m
                 where m.package_type_id = Open.Dald_parameter.fnuGetNumeric_Value(''TIPO_SOLC_ANUPAGA_UNIC'')))
and o.order_id=oa.order_id
and o.order_status_id=Open.Dald_parameter.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'')';

  ut_trace.trace('LDC_FNCONSULTAORANPU : Se validan campos a agregar', 1);
  --Orden
  if (sbORDER_ID is not null) then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la orden', 1);
    sbQuery := sbQuery || ' and o.order_id= Decode(to_number(''' ||
               sbORDER_ID || '''), -1, o.order_id, to_number(''' ||
               sbORDER_ID || '''))';
  end if;
  --Contrato
  if (sbSUSCCODI is not null) then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega el contrato', 1);
    sbQuery := sbQuery || ' and oa.subscription_id= Decode(to_number(''' ||
               sbSUSCCODI || '''), -1, oa.subscription_id, to_number(''' ||
               sbSUSCCODI || '''))';
  end if;
  --solicitud
  if (sbPACKAGE_ID is not null) then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la solicitud', 1);
    sbQuery := sbQuery || ' and oa.package_id= Decode(to_number(''' ||
               sbPACKAGE_ID || '''), -1, oa.package_id, to_number(''' ||
               sbPACKAGE_ID || '''))';
  end if;
  --Fecha inicial
  if (sbCREATED_DATE is not null) then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la Fecha inicial', 1);
    sbQuery := sbQuery || ' AND TRUNC(o.created_date) >=
      TRUNC( to_date(''' || sbCREATED_DATE || '''))';
  end if;
  --Fecha Final
  if (sbEXECUTION_FINAL_DATE is not null) then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la Fecha inicial', 1);
    sbQuery := sbQuery || ' AND TRUNC(o.created_date) <=
      TRUNC( to_date(''' || sbEXECUTION_FINAL_DATE || '''))';

  end if;
  ut_trace.trace('Ejecucion LDC_FNCONSULTAORANPU sbQuery Final => ' ||
                 sbQuery,
                 11);
  --Ejecutamos el Select haciendo uso de un cursor
  OPEN rfCursor FOR sbQuery;

  ut_trace.trace('LDC_FNCONSULTAORANPU : Finaliza Funcion', 1);
  -- Retornamos el Cursor
  return rfCursor;
  ut_trace.trace('LDC_FNCONSULTAORANPU : Se retorna cursor', 1);
EXCEPTION
  when no_data_found then
    ut_trace.trace('LDC_FNCONSULTAORANPU : No existen datos', 1);
    if rfCursor%isopen then
      close rfCursor;
    end if;
    raise ex.CONTROLLED_ERROR;
  when ex.CONTROLLED_ERROR then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Error controlado', 1);
    raise;

  when OTHERS then
    ut_trace.trace('LDC_FNCONSULTAORANPU : Error desconocido', 1);
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_FNCONSULTAORANPU;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCONSULTAORANPU', 'ADM_PERSON');
END;
/