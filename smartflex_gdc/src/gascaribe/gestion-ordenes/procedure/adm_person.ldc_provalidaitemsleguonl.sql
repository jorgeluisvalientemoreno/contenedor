CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROVALIDAITEMSLEGUONL(nuorderid    in or_order.order_id%type,
                                                      nuresp       out number,
                                                      Onuerrorcode out number,
                                                      Osberrormsg  out varchar2) IS
  /*****************************************************************
     Propiedad intelectual de JM GESTIONINFORMATICA S.A.
     Unidad         : ldc_provalidaitemsleguonl
     Descripcion    : Procedimiento Personalizado para validar los items que deben
                      legalizar las unidades operativas que aplican para el nuevo esquema
                      de liquidacion.
     Autor          : John Jairo Jimenez Marimon
     Fecha          : 08-07-2016

     Historia de Modificaciones
     Fecha             Autor               Modificacion
     ==========        ==================  ======================================
     11/07/2017        SEBASTIAN TAPIAS    200-1261 Se restructura la forma de validar del procedimiento.
  ****************************************************************************/
  --Cursor para Obtener la actividad y el item de la orden.
  CURSOR cuorderitems(nucuorderitems or_order_items.order_id%TYPE) IS
    SELECT oa.activity_id actividad, oi.items_id item
      FROM or_order_items oi, or_order_activity oa
     WHERE oi.order_id = nucuorderitems
       AND oi.value >= 1
       AND oi.order_activity_id = oa.order_activity_id;

  rfcuorderitems cuorderitems%rowtype;

  rgorder   or_order%ROWTYPE;
  nureg     NUMBER(2);
  sbmensaje VARCHAR2(1000);
  sbnomunut or_operating_unit.name%TYPE;
  eerror EXCEPTION;
  nuunidop or_operating_unit.operating_unit_id%TYPE;
  nucontav NUMBER(10);
  activity NUMBER(20) := null;
  item     NUMBER(20) := null;
BEGIN
  Ut_Trace.TRACE('ldc_provalidaitemsleguonl: Inicia servicio', 1);
  /*Si la unidad está configurada en la forma LCDUNOPRL
  se debe ir al paso 2 sino se debe ir al paso 3*/
  Ut_Trace.TRACE('ldc_provalidaitemsleguonl: Paso 1 - Verificacion de la unidad',
                 1);
  nureg := 0;
  BEGIN
    SELECT ot.*
      INTO rgorder
      FROM open.or_order ot, open.ldc_const_unoprl uol
     WHERE ot.order_id = nuorderid
       AND ot.operating_unit_id = uol.unidad_operativa;
    nureg := 2;
  EXCEPTION
    WHEN no_data_found THEN
      nureg := 3;
    WHEN OTHERS THEN
      sbmensaje := SQLERRM;
      RAISE eerror;
  END;
  /*Se valida que unidad, actividad e ítem esten configurado en la forma LDCCUAI.
  Si lo está, permite legalizar sino debe lanzar mensaje de error.*/
  IF nureg = 2 THEN
    Ut_Trace.TRACE('ldc_provalidaitemsleguonl: Paso 2 - Verificacion de la unidad, actividad e item',
                   1);
    nuunidop := rgorder.operating_unit_id;
    IF nuunidop IS NOT NULL THEN
      FOR rfcuorderitems IN cuorderitems(nuorderid) LOOP
        -- Validamos la configuracion (Unidad - Actividad - Item) en la la forma LDCCUAI
        nucontav := 0;
        SELECT COUNT(1)
          INTO nucontav
          FROM ldc_item_uo_lr l
         WHERE l.unidad_operativa = nuunidop
           AND l.actividad = rfcuorderitems.actividad
           AND l.item = rfcuorderitems.item;
        IF nucontav >= 1 THEN
          nuresp       := 1;
          Onuerrorcode := 0;
          Osberrormsg  := NULL;
        ELSE
          --Si no existe configuracion, se valida configuracion para la unidad -1
          IF nucontav = 0 THEN
            Ut_Trace.TRACE('ldc_provalidaitemsleguonl: la configuracion no existe se cambiara unidad a -1',
                           1);
            nuunidop := -1;
            nucontav := NULL;
            SELECT COUNT(1)
              INTO nucontav
              FROM ldc_item_uo_lr l
             WHERE l.unidad_operativa = nuunidop
               AND l.actividad = rfcuorderitems.actividad
               AND l.item = rfcuorderitems.item;
            IF nucontav >= 1 THEN
              nuresp       := 1;
              Onuerrorcode := 0;
              Osberrormsg  := NULL;
            ELSE
              --Si no existe configuracion obtengo el nombre de unidad operativa
              IF nucontav = 0 THEN
                sbnomunut := NULL;
                BEGIN
                  SELECT uoc.name
                    INTO sbnomunut
                    FROM or_operating_unit uoc
                   WHERE uoc.operating_unit_id = rgorder.operating_unit_id;
                EXCEPTION
                  WHEN no_data_found THEN
                    sbnomunut := '---------';
                END;
                sbmensaje := 'No existe la configuracion de la actividad : ' ||
                             to_char(rfcuorderitems.actividad) ||
                             ' Item : ' || to_char(rfcuorderitems.item) ||
                             ' para la unidad de trabajo : ' ||
                             to_char(rgorder.operating_unit_id) || ' - ' ||
                             sbnomunut;
                RAISE eerror;
              END IF;
            END IF;
          END IF;
        END IF;
      END LOOP;
    END IF;
  END IF;
  /*Si la combinación unidad operativa -1 y actividad que se intenta legalizar está configurado
  se debe ir al paso 4, en caso contrario debe permitir legalizar la orden.*/
  IF nureg = 3 THEN
    Ut_Trace.TRACE('ldc_provalidaitemsleguonl: Paso 3 - Verificacion de la unidad -1 y actividad',
                   1);
    nuunidop := -1;
    IF nuunidop IS NOT NULL THEN
      FOR i IN cuorderitems(nuorderid) LOOP
        nucontav := 0;
        SELECT COUNT(1)
          INTO nucontav
          FROM ldc_item_uo_lr l
         WHERE l.unidad_operativa = nuunidop
           AND l.actividad = i.actividad;
        IF nucontav >= 1 THEN
          nureg := 4;
        END IF;
        IF nucontav = 0 THEN
          nuresp       := 1;
          Onuerrorcode := 0;
          Osberrormsg  := NULL;
        END IF;
      END LOOP;
    END IF;
  END IF;
  /*Si la combinación unidad operativa -1 y actividad e ítem que se intenta legalizar está configurado en la forma
  debe permitir legalizar la orden, sino debe lanzar mensaje de error.*/
  IF nureg = 4 THEN
    Ut_Trace.TRACE('ldc_provalidaitemsleguonl: Paso 4 - Verificacion de la unidad -1, actividad e item',
                   1);
    nuunidop := -1;
    IF nuunidop IS NOT NULL THEN
      FOR i IN cuorderitems(nuorderid) LOOP
        nucontav := 0;
        SELECT COUNT(1)
          INTO nucontav
          FROM ldc_item_uo_lr l
         WHERE l.unidad_operativa = nuunidop
           AND l.actividad = i.actividad
           AND l.item = i.item;
        IF nucontav >= 1 THEN
          nuresp       := 1;
          Onuerrorcode := 0;
          Osberrormsg  := NULL;
        ELSE
          IF nucontav = 0 THEN
            sbnomunut := NULL;
            BEGIN
              SELECT uoc.name
                INTO sbnomunut
                FROM or_operating_unit uoc
               WHERE uoc.operating_unit_id = rgorder.operating_unit_id;
            EXCEPTION
              WHEN no_data_found THEN
                sbnomunut := '---------';
            END;
            sbmensaje := 'No existe la configuracion de la actividad : ' ||
                         to_char(i.actividad) || ' Item : ' ||
                         to_char(i.item) || ' para la unidad de trabajo : ' ||
                         to_char(rgorder.operating_unit_id) || ' - ' ||
                         sbnomunut;
            RAISE eerror;
          END IF;
        END IF;
      END LOOP;
    END IF;
  END IF;
EXCEPTION
  WHEN eerror THEN
    nuresp       := 0;
    Onuerrorcode := -1;
    Osberrormsg  := sbmensaje;
  WHEN OTHERS THEN
    nuresp       := 0;
    Onuerrorcode := -1;
    IF sbmensaje IS NULL THEN
      sbmensaje := SQLERRM;
    END IF;
    Osberrormsg := sbmensaje;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROVALIDAITEMSLEGUONL', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_PROVALIDAITEMSLEGUONL TO REXEREPORTES;
/
