CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCONSULTAOTESDOC" 
  return constants_per.tyRefCursor IS
  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : LDC_FNCONSULTAOTESDOC
  Descripcion    : Funci?n para consultar las ?rdenes por estado de documentos.
  Autor          : Sebastian Tapias
  Fecha          : 30/07/2017

  Fecha             Autor                Modificacion
  =========       =========             ====================
  26/10/2020	  OLSOFTWARE			Se elimina la parte relacionada con el campo contratista y se
										modifica la consulta para tener en cuenta el campo de la unidad operativa.
  ******************************************************************/
  --Variables Usadas Durante el Proceso
  cnuNULL_ATTRIBUTE constant number := 2126;
  sbOPERATING_UNIT_ID   ge_boInstanceControl.stysbValue;
  sbSTATUS_DOCU         ge_boInstanceControl.stysbValue;
  sbEXEC_INITIAL_DATE   ge_boInstanceControl.stysbValue;
  sbLEGALIZATION_DATE   ge_boInstanceControl.stysbValue;
  sbTASK_TYPE_ID        ge_boInstanceControl.stysbValue;
  sbAPPOINTMENT_CONFIRM ge_boInstanceControl.stysbValue;
  rfCursor              constants_per.tyRefCursor;
  sbQuery               varchar2(32767);

BEGIN
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Inicia funcion', 1);
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Asignacion de variables', 1);
  -- Se obtienen datos de la forma
  sbOPERATING_UNIT_ID   := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                 'OPERATING_UNIT_ID');
  sbSTATUS_DOCU         := ge_boInstanceControl.fsbGetFieldValue('LDC_DOCUORDER',
                                                                 'STATUS_DOCU');
  sbEXEC_INITIAL_DATE   := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                 'EXEC_INITIAL_DATE');
  sbLEGALIZATION_DATE   := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                 'LEGALIZATION_DATE');
  sbTASK_TYPE_ID        := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                 'TASK_TYPE_ID');
  sbAPPOINTMENT_CONFIRM := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                 'APPOINTMENT_CONFIRM');

  ut_trace.trace('LDC_FNCONSULTAOTESDOC : sbOPERATING_UNIT_ID (' ||
                 sbOPERATING_UNIT_ID || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : sbSTATUS_DOCU (' ||
                 sbSTATUS_DOCU || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : sbEXEC_INITIAL_DATE (' ||
                 sbEXEC_INITIAL_DATE || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : sbLEGALIZATION_DATE (' ||
                 sbLEGALIZATION_DATE || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : sbTASK_TYPE_ID (' ||
                 sbTASK_TYPE_ID || ')',
                 1);
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : sbAPPOINTMENT_CONFIRM (' ||
                 sbAPPOINTMENT_CONFIRM || ')',
                 1);
  ------------------------------------------------
  -- Required Attributes
  ------------------------------------------------
  --Se validan campo nulos
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Validacion de campos nulos', 1);

    -- CASO 522 ---
    if (sbOPERATING_UNIT_ID is null) then
        ut_trace.trace('LDC_FNCONSULTAOTESDOC : Unidad Operativa nula', 1);
        Errors.SetError(cnuNULL_ATTRIBUTE, 'Unidad Operativa Nula');
        raise ex.CONTROLLED_ERROR;
    end if;
    -- fin CASO 522 ---

  if (sbSTATUS_DOCU is null) then
    ut_trace.trace('LDC_FNCONSULTAOTESDOC : Estado de documento nulo', 1);
    Errors.SetError(cnuNULL_ATTRIBUTE, 'Estado Orden (Actual)');
    raise ex.CONTROLLED_ERROR;
  end if;

  ------------------------------------------------
  -- User code
  ------------------------------------------------
  --Se construye el select principal
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Construccion del select', 1);


  sbQuery := 'SELECT OO.ORDER_ID NO_ORDEN,
       (SELECT GE.GEO_LOCA_FATHER_ID || '' - '' ||
               (SELECT GG.DESCRIPTION
                  FROM GE_GEOGRA_LOCATION GG
                 WHERE GG.GEOGRAP_LOCATION_ID = GE.GEO_LOCA_FATHER_ID)
          FROM DUAL) DEPARTAMENTO,
       (SELECT GE.GEOGRAP_LOCATION_ID || '' - '' ||
               (SELECT GG.DESCRIPTION
                  FROM GE_GEOGRA_LOCATION GG
                 WHERE GG.GEOGRAP_LOCATION_ID = GE.GEOGRAP_LOCATION_ID)
          FROM DUAL) LOCALIDAD,
       (SELECT GE.ID_CONTRATISTA || '' - '' || GE.NOMBRE_CONTRATISTA
          FROM GE_CONTRATISTA GE
         WHERE GE.ID_CONTRATISTA IN (SELECT ORO.CONTRACTOR_ID
          FROM OPEN.OR_OPERATING_UNIT ORO
         WHERE ORO.OPERATING_UNIT_ID = OO.OPERATING_UNIT_ID)) CONTRATISTA,
        (SELECT ORO.OPERATING_UNIT_ID || '' - '' || ORO.NAME
          FROM OPEN.OR_OPERATING_UNIT ORO
         WHERE ORO.OPERATING_UNIT_ID = OO.OPERATING_UNIT_ID) UNIDAD_OPERATIVA,
       (SELECT OO.TASK_TYPE_ID || '' - '' ||
               (SELECT OTT.DESCRIPTION
                  FROM OR_TASK_TYPE OTT
                 WHERE OTT.TASK_TYPE_ID = OO.TASK_TYPE_ID)
          FROM DUAL) TIPO_TRABAJO,
       LT.CANT_DOCU CANT_DOCUMENTOS,
       LD.LEGALIZATION_DATE LEGALIZACION_DATE,
       (SELECT TRUNC(sysdate) -
               TRUNC(LD.LEGALIZATION_DATE)
          FROM dual) No_DIAS_LEGALIZACION,
       LD.RECEPTION_DATE RECEPTION_DATE,
       (SELECT TRUNC(sysdate) -
               TRUNC(LD.RECEPTION_DATE)
          FROM dual) No_DIAS_RECEPCION
  FROM LDC_DOCUORDER       LD,
       OR_ORDER            OO,
       LDC_TITRDOCU        LT,
       AB_ADDRESS          AB,
       OR_ORDER_ACTIVITY   OOA,
       GE_GEOGRA_LOCATION  GE
 WHERE LD.ORDER_ID = OO.ORDER_ID
   AND LT.TASK_TYPE_ID = OO.TASK_TYPE_ID
   AND OO.ORDER_ID = OOA.ORDER_ID
   AND OOA.ADDRESS_ID = AB.ADDRESS_ID
   AND AB.GEOGRAP_LOCATION_ID = GE.GEOGRAP_LOCATION_ID
   AND LD.STATUS_DOCU = to_char(''' || sbSTATUS_DOCU || ''')
   AND OO.OPERATING_UNIT_ID = Decode(to_number(''' ||
               sbOPERATING_UNIT_ID ||
               '''), -1, OO.OPERATING_UNIT_ID, to_number(''' ||
               sbOPERATING_UNIT_ID || '''))';

    -- fin modificacion caso 522 --

  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Se validan campos a agregar', 1);

  --Fecha Inicial
  if (sbEXEC_INITIAL_DATE is not null) then
    ut_trace.trace('LDC_FNCONSULTAOTESDOC : Se agrega fecha inicial', 1);
    --Si es estado CO se busca por fecha de legalizacion, si es EP se busca por fecha de recepcion
    IF (TO_CHAR(sbSTATUS_DOCU) = 'CO') THEN
      sbQuery := sbQuery || ' AND TRUNC(LD.LEGALIZATION_DATE) >=
       to_date(''' || sbEXEC_INITIAL_DATE || ''')';
    ELSIF (TO_CHAR(sbSTATUS_DOCU) = 'EP') THEN
      sbQuery := sbQuery || ' AND TRUNC(LD.RECEPTION_DATE) >=
       to_date(''' || sbEXEC_INITIAL_DATE || ''')';
    END IF;
  end if;
  --Fecha Final
  if (sbLEGALIZATION_DATE is not null) then
    --Si es estado CO se busca por fecha de legalizacion, si es EP se busca por fecha de recepcion
    IF (TO_CHAR(sbSTATUS_DOCU) = 'CO') THEN
      sbQuery := sbQuery || ' AND TRUNC(LD.LEGALIZATION_DATE) <=
       to_date(''' || sbLEGALIZATION_DATE || ''')';
    ELSIF (TO_CHAR(sbSTATUS_DOCU) = 'EP') THEN
      sbQuery := sbQuery || ' AND TRUNC(LD.RECEPTION_DATE) <=
       to_date(''' || sbLEGALIZATION_DATE || ''')';
    END IF;
  end if;
  --Tipo de Trabajo
  if (sbTASK_TYPE_ID is not null) then
    ut_trace.trace('LDC_FNCONSULTAOTESDOC : Se agrega tipo de trabajo', 1);
    sbQuery := sbQuery || ' AND OO.TASK_TYPE_ID = Decode(to_number(''' ||
               sbTASK_TYPE_ID ||
               '''), -1, OO.TASK_TYPE_ID, to_number(''' ||
               sbTASK_TYPE_ID || '''))';
  end if;
  IF (TO_CHAR(sbSTATUS_DOCU) = 'CO') THEN
    sbQuery := sbQuery || ' ORDER BY LD.LEGALIZATION_DATE';
  ELSIF (TO_CHAR(sbSTATUS_DOCU) = 'EP') THEN
    sbQuery := sbQuery || ' ORDER BY LD.RECEPTION_DATE';
  END IF;

  ut_trace.trace('Ejecuci?n LDC_FNCONSULTAOTESDOC sbQuery Final => ' ||
                 sbQuery,
                 11);
  --Ejecutamos el Select haciendo uso de un cursor
  OPEN rfCursor FOR sbQuery;

  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Finaliza Funcion', 1);
  -- Retornamos el Cursor
  return rfCursor;
  ut_trace.trace('LDC_FNCONSULTAOTESDOC : Se retorna cursor', 1);
EXCEPTION
  when no_data_found then
    ut_trace.trace('LDC_FNCONSULTAOTESDOC : No existen datos', 1);
    if rfCursor%isopen then
      close rfCursor;
    end if;
    raise ex.CONTROLLED_ERROR;
  when ex.CONTROLLED_ERROR then
    ut_trace.trace('LDC_FNCONSULTAOTESDOC : Error controlado', 1);
    raise;

END LDC_FNCONSULTAOTESDOC;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCONSULTAOTESDOC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FNCONSULTAOTESDOC TO REPORTES;
/