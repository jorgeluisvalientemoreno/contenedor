CREATE OR REPLACE Package adm_person.ldc_prajusordesinacta Is

  /*****************************************************************
    Propiedad intelectual de GDC - Efigas.

    nombre paquete;          LDC_PRAJUSORDESINACTA
    Descripci?n:             Contiene todos los procedimientos que permiten
                             modificar ?rdenes legalizadas que a?n no tienen
                             acta
    Autor    :               Sandra Mu?oz
    Fecha    :               28-09-2015

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    14-06-2017   KCienfuegos.CA200833   Se modifican los metodos: <<proAgregaItem>>
                                                                  <<proModifItem>>
                                                                  <<proinicializaregistroenlog>>
                                                                  <<proterminaregistroenlog>>
    09-09-2016   KCienfuegos.CA200771 Se modifican los m?todos proAgregaItem y proModifItem
    12-02-2016   Sandra Mu?oz.          CA100-8710 Se modifica proMueveInventarioUnidOper
    28-09-2015   Sandra Mu?oz           Creaci?n
	17-04-2019   horbath                200-2391 llama a validaciones de LDC_PKGASIGNARCONT.PRPROCMIOAIOORD el procedimiento process
    18/06/2024   Adrianavg OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
    ******************************************************************/

  TYPE TYADJUSTEDITEM IS RECORD
    (   order_items_id     or_order_items.order_items_id%TYPE,
        ITEMS_ID          OR_ORDER_ITEMS.ITEMS_ID%TYPE,
        SERIAL_ITEMS_ID   OR_ORDER_ITEMS.SERIAL_ITEMS_ID%TYPE,
        LEGAL_ITEM_AMOUNT OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE
    );


  TYPE TYTBADJUSTEDITEMS   IS TABLE OF TYADJUSTEDITEM INDEX BY PLS_INTEGER;


  Procedure promodifitem;

  Procedure proagregaitem;

  Procedure getorderitems(id          In Number,
                          description In Varchar2,
                          rfquery     Out constants.tyrefcursor);

   PROCEDURE procGetPrecioCostOrden
    (
      inuOrdeBase   IN  OR_ORDER.ORDER_ID%TYPE,
      iTbItemAjustar IN  tytbadjusteditems,
      oTbItemsAjustado     out    DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS,
      onuOk  OUT NUMBER,
      osbError  OUT VARCHAR2
    );

End LDC_PRAJUSORDESINACTA;
/
CREATE OR REPLACE Package Body adm_person.LDC_PRAJUSORDESINACTA Is

  gsbpaquete Varchar2(4000) := 'LDC_PRAJUSORDESINACTA';
  csbpantmoditems Constant Varchar2(2000) := dald_parameter.fsbgetvalue_chain('PANTALLA_MODIF_ORD',
                                                                              0);
  csbpantadiitems Constant Varchar2(2000) := dald_parameter.fsbgetvalue_chain('PANTALLA_ADIC_ITEMS',
                                                                              0);

  csbEntrega833 CONSTANT VARCHAR2(200) := 'OSS_CON_KCM_200833_1';

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del Paquete: sbAplicaEntrega
  Descripci?n:        Indica si la entrega aplica para la gasera

  Autor : Sandra Mu?oz
  Fecha : 02-09-2015 Aranda 8495

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  14-06-2017   KCienfuegos.CA200833   Se modifican los metodos: <<proAgregaItem>>
                                                                <<proModifItem>>
                                                                <<proinicializaregistroenlog>>
                                                                <<proterminaregistroenlog>>
  09-09-2016    KCienfuegos.CA200771  Se modifican los m?todos proAgregaItem y proModifItem
  02-09-2015    Sandra Mu?oz          Creaci?n. Aranda 8732
  ******************************************************************/
  Function fsbaplicaentrega(isbentrega Varchar2) Return Varchar Is
    blgdo      Boolean := ldc_configuracionrq.aplicaparagdo(isbentrega);
    blefigas   Boolean := ldc_configuracionrq.aplicaparaefigas(isbentrega);
    blsurtigas Boolean := ldc_configuracionrq.aplicaparasurtigas(isbentrega);
    blgdc      Boolean := ldc_configuracionrq.aplicaparagdc(isbentrega);
    sbmetodo   Varchar2(4000) := 'fsbAplicaEntrega';
  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    ut_trace.trace('Valida si la entrega OSS_SMS_ARA_8495 aplica para la gasera',
                   10);
    If blgdo = True Or blefigas = True Or blsurtigas = True Or
       blgdc = True Then
      Return 'S';
    End If;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
    Return 'N';

  End;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proValidaInformacion
  Descripci?n:             Valida que la orden cumpla con los criterios
                           correctos y que se haya definido una cantidad para
                           modificaci?n

  Par?metros entrada
  * inuOrdenItemId         : Identificador del registro
  * inuOrderId             : Orden
  * inuCantidadCorregida   : Nueva cantidad

  Par?metros de salida
  * osbError               : Error del proceso

  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/

  Procedure provalidainformacion(inuordenitemid       ldc_log_items_modif_sin_acta.order_item_id%Type,
                                 inuitem              ge_items.items_id%Type,
                                 inuorderid           ldc_log_items_modif_sin_acta.orden_id%Type,
                                 inucantidadcorregida or_order_items.legal_item_amount%Type,
--                                 isbaccion            Varchar2,
                                 osberror             Out Varchar2) Is
    -- Variables de control
    nupaso Number; -- Progreso de ejecuci?n
    exerror Exception; -- Error controlado
    sbmetodo Varchar2(4000) := 'proValidaInformacion';

    -- Datos del programa
    rgorden                  or_order%Rowtype; -- Informaci?n de la orden
    nuclaselegalizacion      ge_causal.causal_type_id%Type; -- Tipo de causal. 1 es ?xito
    nuexiste                 Number; -- Indica si la orden procesada ya est? liquidada
    nucantidadlegactualmente or_order_items.legal_item_amount%Type; -- Cantidad legalizada en el momento
    nuclasificacionitem      ge_items.item_classif_id%Type; -- Clasificaci?n del ?tem
    nuesmaterial             Number; -- Indica si el ?tem a modificar es material
    cnuadjustment_activity Constant ge_items.items_id%Type := ge_boitemsconstants.cnuadjustmentactivity;

    sbDato VARCHAR2(1);
    --Se valida fechas de cierre
    CURSOR cuFechCierre (dtFechaLega DATE)IS
    SELECT 'X'
    FROM ldc_ciercome
    WHERE dtFechaLega BETWEEN CICOFEIN AND CICOFECH
     AND CICOANO = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
     AND CICOMES = TO_NUMBER(TO_CHAR(SYSDATE, 'MM'));

  Begin
    osberror := NULL;
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    nupaso := 10;
    ut_trace.trace('Verificar que la orden no sea de ajuste', 10);
    If (or_bcorder.fblorderhasactivity(inuorderid, cnuadjustment_activity)) Then
      osberror := 'La orden ' || inuorderid ||
                  ' es de ajuste, por tanto no se puede modificar';
      Raise exerror;
    End If;
    nupaso := 15;
    If nvl(inuordenitemid, 0) > 0 Then
      ut_trace.trace('Buscar el n?mero de la orden asociada al orderitemid ingresado por par?metro,
        s?lo lo hace para ?tems que ya estaban legalizados',10);
      Begin
        Select ooi.legal_item_amount
          Into nucantidadlegactualmente
          From or_order_items ooi
         Where ooi.order_items_id = inuordenitemid;
      Exception
        When no_data_found Then
          osberror := 'No se encontr? la orden asociada al registro ' ||inuordenitemid;
          Raise exerror;
        When Others Then
          osberror := 'No fue posible consultar la orden asociada al registro' ||inuordenitemid;
          Raise exerror;
      End;
      nupaso := 30;
      ut_trace.trace(' Verificar que no se est? legalizando la misma cantidad',10);
      nupaso := 40;
      If nucantidadlegactualmente = inucantidadcorregida Then
        osberror := 'La cantidad corregida es igual a la cantidad ya legalizada';
        Raise exerror;
      End If;
    End If;
    ut_trace.trace('Buscar los datos de la orden ' ||inuorderid, 10);
    nupaso := 50;
    Begin
      Select *
        Into rgorden
        From or_order oo
       Where oo.order_id = inuorderid;
    Exception
      When no_data_found Then
        osberror := 'No se encontr? una orden con el c?digo ' ||inuorderid;
        Raise exerror;
      When Others Then
        osberror := 'Error al intentar recuperar la informaci?n de la orden ' ||inuorderid || ' - ' || Sqlerrm;
        Raise exerror;
    End;
    ut_trace.trace('Verifica si est? legalizada', 10);
    nupaso := 60;
    If rgorden.order_status_id <>
       dald_parameter.fnugetnumeric_value('COD_ORDER_STATUS') Then
      osberror := 'La orden ' || inuorderid ||' no se encuentra legalizada';
      Raise exerror;
    End If;
    ut_trace.trace('Verifica si la fecha de legalizaci?n est? dentro del mes',10);
    nupaso := 70;
    Begin
      Select item_classif_id
        Into nuclasificacionitem
        From ge_items gi
       Where gi.items_id = inuitem;
    Exception
      When Others Then
        osberror := 'No fu? posible determinar si el ?tem ' || inuitem ||
                    ' es de actividad. ' || Sqlerrm;
        Raise exerror;
    End;
    nupaso := 80;
    Begin
      Select to_number(column_value)
        Into nuesmaterial
        From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASE_ITEMS_DE_MATERIAL',
                                                                                 Null),
                                                ','))
       Where to_number(column_value) = nuclasificacionitem;
    Exception
      When no_data_found Then
        nuesmaterial := Null;
      When too_many_rows Then
        nuesmaterial := 1;
      When Others Then
        osberror := 'No fu? posible determinar la clasificaci?n del ?tem ' ||inuitem;
    End;
    nupaso := 80;
    If nuesmaterial Is Not Null Then
     OPEN cuFechCierre(rgorden.legalization_date);
     FETCH cuFechCierre INTO sbdato;
     IF cuFechCierre%NOTFOUND THEN
         osberror := 'El ?tem ' || inuitem || ' es un material y la orden ' ||
                    inuorderid ||
                    ' no se encuentra legalizada en el mes actual.';
        Raise exerror;
     END IF;
     CLOSE cuFechCierre;

     /* If trunc(rgorden.legalization_date, 'mm') <> trunc(Sysdate, 'mm') Then
        osberror := 'El ?tem ' || inuitem || ' es un material y la orden ' ||
                    inuorderid ||
                    ' no se encuentra legalizada en el mes actual.';
        Raise exerror;
      End If;*/
    End If;
    ut_trace.trace('Verifica si tiene causal de legalizaci?n de ?xito',10);
    nupaso := 90;
    If rgorden.causal_id Is Not Null Then
      nupaso := 100;
      Begin
        Select class_causal_id
          Into nuclaselegalizacion
          From ge_causal
         Where causal_id = rgorden.causal_id;
      Exception
        When no_data_found Then
          osberror := 'La causal de legalizaci?n ' || rgorden.causal_id ||
                      ' de la la orden ' || inuorderid ||
                      ' no se encuentra registrada en el sistema por tanto' ||
                      ' no es posible determinar si se legaliz? con ?xito';
          Raise exerror;
      End;
    Else
      nupaso := 110;
      osberror := 'La causal de legalizaci?n de la la orden ' ||
                  inuorderid ||
                  ' est? vac?a por lo tanto no es posible determinar si se legaliz? con ?xito.';
      Raise exerror;
    End If;
    nupaso := 120;
    If nuclaselegalizacion = 2 Then
      osberror := 'La orden ' || inuorderid ||
                  ' no se legaliz? con ?xito.';
      Raise exerror;
    End If;
    nupaso := 130;
    ut_trace.trace('Verifica que no est? asociada a alguna acta de liquidaci?n',10);
    Begin
      Select Count(1)
        Into nuexiste
        From ct_order_certifica coc
       Where coc.order_id = rgorden.order_id;
    Exception
      When Others Then
        osberror := 'La orden ' || inuorderid ||
                    ' no se legaliz? con ?xito.';
        Raise exerror;
    End;
    nupaso := 140;
    If nuexiste > 0 Then
      osberror := 'La orden ' || inuorderid || ' est? asociada a acta.';
      Raise exerror;
    End If;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
  Exception
    When exerror Then
      osberror := osberror || ' (' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo || ')';
    When Others Then
      osberror := Sqlerrm || ' (' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo || ')';
  End;
  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proCantidadCorregida
  Descripci?n:              Construye la tabla pl/sql para la cantidad corregida

  Par?metros de entrada
  inuItemId                 : Item
  inuSerialItems_Id         : Serial
  inuCantidad               : Cantidad

  Par?metros de salida
  otbItemAReversar          : Tabla PL con el ?tem a reversar
  osbError                  : Mensaje de error

  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/

  Procedure procantidadcorregida(inuitemid         ldc_log_items_modif_sin_acta.item_id%Type,
                                 inuserialitems_id ldc_log_items_modif_sin_acta.serial_items_id%Type,
                                 inucantidad       ldc_log_items_modif_sin_acta.legal_item_amount%Type,
                                 otbitemareversar  Out or_bcadjustmentorder.tytbadjusteditems,
                                 osberror          Out Varchar2) Is

    -- Variables de entorno
    nupaso Number;
    exerror Exception;
    sbmetodo Varchar2(4000) := 'proCantidadCorregida';

    -- Informaci?n a reversar
    Cursor cuitem Is
      Select inuitemid, inuserialitems_id, inucantidad From dual;

  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    nupaso := 10;

    Open cuitem;

    ut_trace.trace('Identifica si hay ?tems a reversar', 10);
    nupaso := 20;
    Fetch cuitem Bulk Collect
      Into otbitemareversar;

    nupaso := 30;
    Close cuitem;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);

  Exception
    When exerror Then

      osberror := osberror || ' (' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo || ')';
    When Others Then
      osberror := Sqlerrm || ' (' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo || ')';
  End procantidadcorregida;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proCantidadAReversar
  Descripci?n:              Construye el registro donde se almacenan las cantidades a reversar
                            de la orden original

  Par?metros de entrada
  * inuOrderItemId          : Identificador del registro del ?tem dentro de la
                              orden

  Par?metros de salida
  * otbItemAReversar        : Tabla con el ?tem y la cantidad a reversar
  * onuItemMayorACero       : Indica si hab?an registros con cantidad legalizada
  * onuItem                 : C?digo del ?tem
  * osbError                : Mensaje de error


  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure procantidadareversar(inuorderitemid    In or_order_items.order_items_id%Type,
                                 otbitemareversar  Out or_bcadjustmentorder.tytbadjusteditems,
                                 onucantaoriginal  Out Number,
                                 onuitemmayoracero Out Number,
                                 onuitem           Out or_order_items.items_id%Type,
                                 osberror          Out Varchar2) Is

    -- Variables de entorno
    nupaso Number;
    exerror Exception;
    sbmetodo Varchar2(4000) := 'proCantidadAReversar';

    -- Informaci?n a reversar
    Cursor cuitem Is
      Select ooi.items_id, serial_items_id, -legal_item_amount
        From or_order_items ooi
       Where ooi.order_items_id = inuorderitemid
         And nvl(ooi.legal_item_amount, 0) <> 0;

    nucantlegalizada or_order_items.order_items_id%Type;

  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);

    nupaso := 10;

    Begin
      Select ooi.items_id, ooi.legal_item_amount
        Into onuitem, nucantlegalizada
        From or_order_items ooi
       Where ooi.order_items_id = inuorderitemid;
    Exception
      When no_data_found Then
        onuitemmayoracero := 0;
    End;

    nupaso := 20;

    If nucantlegalizada = 0 Then
      onuitemmayoracero := 0;
    Else
      onuitemmayoracero := 1;
    End If;

    nupaso := 30;

    If onuitem Is Not Null Then

      nupaso := 40;

      Open cuitem;

      ut_trace.trace('Identifica si hay ?tems a reversar', 10);

      nupaso := 50;
      If onuitemmayoracero > 0 Then
        nupaso := 60;

        Fetch cuitem Bulk Collect
          Into otbitemareversar;
      End If;

      nupaso := 70;
      Close cuitem;
      nupaso := 80;
    End If;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);

  Exception
    When exerror Then

      osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
    When Others Then
      osberror := nupaso || ' - ' || gsbpaquete || '.' || sbmetodo || '. ' ||
                  Sqlerrm;

  End procantidadareversar;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proMueveInventarioUnidOper
  Descripci?n:              Realiza los movimientos en inventario/activo

  Par?metros de entrada     inuOrderId : Orden
                            inuCantidad: Cantidad
  osbError                  : Mensaje de error


  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones


  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  12-02-2016   Sandra Mu?oz           CA 1008710
                                      Se elimina la secci?n donde se actualizaba
                                      el costo en LDC_ACT_IUOB y LDC_INV_IUOB
                                      ya que esta acci?n se realiza en el trigger
                                      LDCTRGBUDI_OR_OUIB
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure promueveinventariounidoper(inuorderid            In or_order.order_id%Type,
                                       inuitem               In or_order_items.items_id%Type,
                                       isbtipobodega         In Varchar2,
                                       inusaldooriginalunid  In ldc_act_ouib.balance%Type,
                                       inusaldooriginalcost  In ldc_act_ouib.total_costs%Type,
                                       inucantidadoriginalbg In Number,
                                       inucostooriginalbg    In Number,
                                       inuvalor              In or_order_items.total_price%Type,
                                       inuCantidad           in number,
                                       osberror              Out Varchar2) Is

    nuunidadoperativa or_order.operating_unit_id%Type;
    nupaso            Number; -- Paso ejecutado antes del error
    exerrorinterno Exception; -- Error de ejecuci?n del procedimiento
    exerror        Exception; -- Error de un procedimiento invocado
    sbmetodo            Varchar2(4000) := 'proMueveInventarioUnidOper';
    nutieneasignadoitem Number; -- Indica si una unidad operativa tiene asignado un ?tem
    nucantidadfinalbg   or_ope_uni_item_bala.balance%Type;
    --   nuCostoOriginal     or_ope_uni_item_bala.total_costs%TYPE;
    nunuevocosto ldc_act_ouib.total_costs%Type;
  Begin
    nupaso := 10;
    ut_trace.trace('Inicio LDC_PRAJUSORDESINACTA.proMueveInventarioUnidOper',
                   10);

    ut_trace.trace('
        inuOrderId                ' || inuorderid || '
        inuItem                   ' || inuitem || '
        isbTipoBodega             ' || isbtipobodega || '
        inuSaldoOriginalUnid      ' ||
                   inusaldooriginalunid || '
        inuSaldoOriginalCost      ' ||
                   inusaldooriginalcost || '
        inuCantidadOriginalBG     ' ||
                   inucantidadoriginalbg || '
        inuCostoOriginalBG        ' ||
                   inucostooriginalbg || '
        inuValor                  ' || inuvalor,
                   10);

    ut_trace.trace('Obteniendo la unidad operativa', 10);
    nupaso := 20;
    Begin
      nuunidadoperativa := daor_order.fnugetoperating_unit_id(inuorderid);
    Exception
      When Others Then
        osberror := 'Error ejecutando daor_order.fnugetoperating_unit_id(' ||
                    inuorderid || ') - ' || Sqlerrm;
        Raise exerror;
    End;
    ut_trace.trace('UNIDAD 544' || nuunidadoperativa, 10); --DSAL
    ut_trace.trace('ITEM 544' || inuitem, 10); --DSAL

    -- Se verifica si la unidad operativa tiene asignado el ?tem
    ut_trace.trace('Se verifica si la unidad operativa tiene asignado el ?tem',
                   10);
    Begin
      Select oouib.balance /*,
                                                                                                 oouib.total_costs*/
        Into nucantidadfinalbg /*,
                                                                                                 nuCostoOriginal*/
        From or_ope_uni_item_bala oouib
       Where oouib.items_id = inuitem
         And oouib.operating_unit_id = nuunidadoperativa;
    Exception
      When no_data_found Then
        ut_trace.trace('No se encontr? informaci?n del ?tem para la unidad operativa:
                                SELECT COUNT (1)
                                FROM   OR_ope_uni_item_bala oouib
                                WHERE  oouib.Items_Id = ' ||
                       inuitem || '
                                AND    oouibOperating_Unit_Id = ' ||
                       nuunidadoperativa || ')');
        osberror := 'No se encontr? parametrizado el ?tem ' || inuitem ||
                    ' para la unidad operativa ' || nuunidadoperativa;
        Raise exerror;
      When Others Then
        ut_trace.trace('No se encontr? informaci?n del ?tem para la unidad operativa:
                                SELECT COUNT (1)
                                FROM   OR_ope_uni_item_bala oouib
                                WHERE  oouib.Items_Id = ' ||
                       inuitem || '
                                AND    oouibOperating_Unit_Id = ' ||
                       nuunidadoperativa || ')');
        osberror := 'No fue posible determinar la cantidad asignada del ?tem a la unidad operativa ' ||
                    nuunidadoperativa;
        Raise exerror;
    End;
    --ut_trace.trace('No se encontr? informaci?n del ?tem para la unidad operativa:');
    ut_trace.trace('Se mueve el inventario de la unidad operativa');
    nupaso := 30;

    -- Actualiza el costo en la unidad operativa ya que la cantidad se
    -- actualiza en el api de creaci?n de orden de ajuste
    Begin

      /*   ut_trace.trace('UPDATE or_ope_uni_item_bala oouitb
                          SET    oouitb.total_costs = ' ||
                         nuCostoOriginal || ' - ' || inuValor || '
                          WHERE  oouitb.items_id = ' || inuItem || '
                          AND    oouitb.operating_unit_id = ' ||
                         nuUnidadOperativa || '; ',
                         10);
      */
      Update or_ope_uni_item_bala oouitb
         Set oouitb.total_costs = oouitb.total_costs - inuvalor, BALANCE = BALANCE - inuCantidad
       Where oouitb.items_id = inuitem
         And oouitb.operating_unit_id = nuunidadoperativa;


    Exception
      When Others Then

        osberror := ' valor['||inuvalor||']-'||sqlerrm;
        Raise exerror;
    End;

    -- CA100-8710. Sandra Mu?oz. Se elimina esta secci?n ya que esta actualizaci?n
    -- se est? realizando en el trigger LDCTRGBUDI_OR_OUIB
    --IF fsbAplicaEntrega('OSS_CON_SMS_1008710') = 'N' THEN

    ut_trace.trace('No aplica la entrega  OSS_CON_SMS_1008710', 10);
    -- No ejecuta esta parte

    -- Se actualiza el costo en el inventario o el activo
    -- Si es activo

    ut_trace.trace('isbTipoBodega ' || isbtipobodega, 10);

    ut_trace.trace('calcular nuNuevoCosto', 10);

    If inucantidadoriginalbg <> 0 Then
      -- (nuSaldoUO - (:OLD.balance - :NEW.balance)) * (:OLD.total_costs / :OLD.balance);

      ut_trace.trace('(' || inusaldooriginalunid || ' - (' ||
                     inucantidadoriginalbg || ' - ' || nucantidadfinalbg ||
                     '  )) *
                            (' || inucostooriginalbg ||
                     ' / ' || inucantidadoriginalbg || ')',
                     10);

      nunuevocosto := (inusaldooriginalunid -
                      (inucantidadoriginalbg - nucantidadfinalbg)) *
                      (inucostooriginalbg / inucantidadoriginalbg);

    Else
      -- nuSaldoCO - (:OLD.TOTAL_COSTS - :NEW.Total_Costs)
      ut_trace.trace(inusaldooriginalcost || '- (' || inuvalor || ' - ' ||
                     inucostooriginalbg || ');',
                     10);
      nunuevocosto := inusaldooriginalcost -
                      (inuvalor - inucostooriginalbg);

    End If;

    ut_trace.trace('nuNuevoCosto ' || nunuevocosto, 10);
/*
    If isbtipobodega = 'A' Then

      Begin

        Update ldc_act_ouib
           Set total_costs = nunuevocosto
         Where items_id = inuitem
           And operating_unit_id = nuunidadoperativa;

      Exception
        When Others Then
          Null;
      End;
      -- Inventario
    Elsif isbtipobodega = 'I' Then

      Begin
        Update ldc_inv_ouib
           Set total_costs = nunuevocosto
         Where items_id = inuitem
           And operating_unit_id = nuunidadoperativa;
      Exception
        When Others Then
          Null;
      End;
      --END IF;
    End If;*/

    ut_trace.trace('FIN LDC_PRAJUSORDESINACTA.proMueveInventarioUnidOper', 10);
  Exception
    When exerrorinterno Then
      osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
    When exerror Then
      Null;
    When Others Then
      osberror := Sqlerrm || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;

  End promueveinventariounidoper;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proCreaOrdenAjuste
  Descripci?n:              Crea una orden de ajuste

  Par?metros de entrada
  * inuOrderId       : Orden
  * itbItems         : Tabla con el ?tem y la cantidad para realizar el ajuste

  Par?metros de salida
  * onuOrderIdAjuste : Orden de ajuste que se usa como comod?n para realizar el ajuste
  * osbError         : Mensaje de rror

  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-09-2016   KCienfuegos.CA200-771  Se elimina la relaci?n entre orden base y orden de ajuste.
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure procreaordenajuste(inuorderid            In or_order.order_id%Type,
                               inuorderitemid        In or_order_items.order_items_id%Type Default Null,
                               inuserialitems_id     In or_order_items.serial_items_id%Type Default Null,
                               ionuitemid            In Out or_order_items.items_id%Type,
                               inucantidaddefinitiva In Number Default Null,
                               isbmovimiento         In Char, -- R-erversa, A-Ajusta
                               onuorderidajuste      Out or_order.order_id%Type,
                               osberror              Out Varchar2) Is

    nupaso Number;
    exerror           Exception;
    exerrorcontrolado Exception;
    sbmetodo            Varchar(4000) := 'proCreaOrdenAjuste';





    tbitems             tytbadjusteditems;
    nucostoitem         or_order_items.value%Type; -- Costo de los ?tems a reversar
    nucantidad          or_order_items.legal_item_amount%Type; -- Cantidad legalizada
    sbtipobodega        ldc_tt_tb.warehouse_type%Type; -- Tipo de bodega
    nusaldooriginalcost ldc_act_ouib.total_costs%Type; --Saldo en el activo antes de iniciar la transacci?n
    nusaldooriginalunid ldc_act_ouib.balance%Type; --Saldo en el activo antes de iniciar la transacci?n
    --    nuSaldoOriginalInventario ldc_inv_ouib.balance%TYPE; --Saldo en el activo antes de iniciar la transacci?n
    nucantidadoriginalbg Number;
    nucostooriginalbg    Number;

    Cursor cuitem Is
      Select inuorderitemid, ooi.items_id, serial_items_id, -legal_item_amount
        From or_order_items ooi
       Where ooi.order_items_id = inuorderitemid
         And nvl(ooi.legal_item_amount, 0) <> 0
         And isbmovimiento = 'R'
      Union
      --CURSOR cuItemAjustar IS
      Select inuorderitemid, ionuitemid, inuserialitems_id, inucantidaddefinitiva
        From dual
       Where isbmovimiento = 'A'
         And inucantidaddefinitiva > 0;
--    nucantidadoriginal Number; --dsal
  --  nucostooriginal    Number; --dsal

    sbEstadoCargos  VARCHAR2(2); -- se almacena si  la orden genero cargos
    nuTipoTrab      or_order.task_type_id%type; -- se almacena el tipo de trabajo de la orden
    nuConcepto      concepto.conccodi%type; -- se alamcena el concepto del tipo de trabajo

    sbFlagGencarg    VARCHAR2(2) := 'N';--se almacena si la orden genero o no cargos

    TbItemsAjustado   DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS;
    nuItemsAjus       ge_items.items_id%type;
    nuOk   NUMBER;
  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);

    nupaso := 10;

    ut_trace.trace('isbMovimiento ' || isbmovimiento || 'inuOrderItemId ' ||
                   inuorderitemid || 'inuCantidadDefinitiva ' ||
                   inucantidaddefinitiva || 'ionuItemId ' || ionuitemid,
                   10);

    If isbmovimiento = 'R' Then
      If inuorderitemid Is Null Then
        osberror := 'Debe indicar el c?digo inuOrderItemId reversar';
        Raise exerror;
      End If;

      -- Si no se va a reversar nada porque la orden estaba en cero no se genera orden de ajuste
      Begin
        Select ooi.items_id
          Into ionuitemid
          From or_order_items ooi
         Where ooi.order_items_id = inuorderitemid
           And nvl(ooi.legal_item_amount, 0) <> 0;
      Exception
        When no_data_found Then
          ut_trace.trace('No se genera ot de ajuste porque la orden estaba en cero',
                         10);
          Raise exerror;
      End;

    Else
      If inucantidaddefinitiva Is Null Then
        osberror := 'Debe indicar el valor de la cantidad definitiva';
      Else
        If inucantidaddefinitiva > 0 Then
          If ionuitemid Is Null Then
            osberror := 'Debe indicar el c?digo del ?tem';
            Raise exerror;
          End If;
        End If;
      End If;
    End If;

    -- Se construye el registro para realizar la orden
    Open cuitem;
    Fetch cuitem Bulk Collect
      Into tbitems;
    Close cuitem;
    nupaso := 20;

    Begin

      ut_trace.trace(

                     'SELECT oouib.balance,
                       oouib.total_costs
                INTO   nuCantidadOriginalBG,
                       nuCostoOriginalBG
                FROM   or_ope_uni_item_bala oouib
                WHERE  oouib.items_id = ' ||
                     ionuitemid || '
                AND    oouib.operating_unit_id = ' ||
                     daor_order.fnugetoperating_unit_id(inuorderid),
                     10);

      Select oouib.balance, oouib.total_costs
        Into nucantidadoriginalbg, nucostooriginalbg
        From or_ope_uni_item_bala oouib
       Where oouib.items_id = ionuitemid
         And oouib.operating_unit_id =
             daor_order.fnugetoperating_unit_id(inuorderid);

    Exception
      When Others Then

        ut_trace.trace('no pudo consultar', 10);
        nucantidadoriginalbg := 0;
        nucostooriginalbg    := 0;

    End;

    ut_trace.trace('
            nuCantidadOriginalBG ' ||
                   nucantidadoriginalbg || '
            nuCostoOriginalBG  ' || nucostooriginalbg,
                   10);

    -- Se saca copia de la existencia en inventario o activo para
    -- calcular el costo despu?s del movimiento de unidades

    Begin
      Select Distinct ltt.warehouse_type
        Into sbtipobodega
        From ge_items i, or_order o, or_order_items oi, ldc_tt_tb ltt
       Where oi.items_id = i.items_id
         And o.order_id = oi.order_id
         And ltt.task_type_id = o.task_type_id
         And o.order_id = inuorderid;
    Exception
      When Others Then
        Null;
    End;

    -- Si es activo
    If sbtipobodega = 'A' Then

      Begin
        Select lao.total_costs, lao.balance
          Into nusaldooriginalcost, nusaldooriginalunid
          From ldc_act_ouib lao
         Where items_id = ionuitemid
           And operating_unit_id =
               daor_order.fnugetoperating_unit_id(inuorderid);
      Exception
        When Others Then

          nusaldooriginalcost := Null;
          nusaldooriginalunid := Null;

      End;

      -- Si es inventario
    Elsif sbtipobodega = 'I' Then

      Begin

        Select lio.total_costs, lio.balance
          Into nusaldooriginalcost, nusaldooriginalunid
          From ldc_inv_ouib lio
         Where items_id = ionuitemid
           And operating_unit_id =
               daor_order.fnugetoperating_unit_id(inuorderid);
      Exception
        When Others Then

          nusaldooriginalcost := Null;
          nusaldooriginalunid := Null;

      End;
    End If;

   /*   sbEstadoCargos :=  DAOR_ORDER.FSBGETCHARGE_STATUS(inuorderid, null);  -- se consulta estado de genracion de orden
      nuTipoTrab := DAOR_ORDER.FNUGETTASK_TYPE_ID(inuorderid, null); -- se consulta tipo d etrabajo de la orden
      nuConcepto := DAOR_TASK_TYPE.FNUGETCONCEPT(nuTipoTrab, null);  -- se consulta el concepto configurado del tipo de trabajo

    -- se valida si la orden de trabajo genrro cargo al usuario
      IF sbEstadoCargos = '3'  THEN
          sbFlagGencarg := 'S';
      END IF;

     -- se valida si el tipo de trabajo tiene concepto configurado
      IF sbEstadoCargos <> '1' AND nuConcepto IS NOT NULL  THEN
         sbFlagGencarg := 'S';
      END IF;*/

    sbFlagGencarg := 'S';
    -- Si existen registros a modificar
    If (tbitems.count > 0) Then
      nupaso := 30;
      nuItemsAjus := tbitems(1).ITEMS_ID;

      -- Crear la OT
      ut_trace.trace('Se crea la orden de ajuste', 10);
      IF sbFlagGencarg = 'N' THEN
         /* or_boadjustmentorder.createorder(inuorderid,
                                           tbitems,
                                           onuorderidajuste);*/




          nupaso := 40;

          If onuorderidajuste Is Null Then
            ut_trace.trace(nupaso ||
                           ' - Ocurri? un error al ejecutar el procedimiento or_boAdjustmentOrder.createorder(' ||
                           inuorderid || ',||otbItemsAjustados ' || ',' ||
                           onuorderidajuste || ')',
                           10);
            osberror := 'No fue posible crear la orden de ajuste.';
            Raise exerror;
          End If;
      ELSE
         --se consulta precio y costo del item
          procGetPrecioCostOrden  ( inuorderid,
                                    tbitems,
                                    TbItemsAjustado,
                                    nuOk,
                                    osberror);

           onuorderidajuste :=  inuorderid;
          IF nuOk <> 0 THEN
             Raise exerror;
          END IF;
      END IF;
      -- Se obtiene la informaci?n del ?tem en variables
      If isbmovimiento = 'R' Then
        -- Si se reversa, se env?an las cantidades negativas para que
        -- en la resta del procedimiento que ajusta las existencias del
        -- funcione correctamente
        ut_trace.trace('Actualiza la bodega del contratista' ||
                       ionuitemid); --DSAL

        Begin
          Select ooi.items_id, -legal_item_amount, -ooi.value
            Into ionuitemid, nucantidad, nucostoitem
            From or_order_items ooi
           Where ooi.order_items_id = inuorderitemid
             And nvl(ooi.legal_item_amount, 0) <> 0;
        Exception
          When Others Then
            osberror := 'No se puedo obtener la informaci?n del ?tem a modificar';
            Raise exerror;
        End;

        ut_trace.trace('NUCANTIDAD' || nucantidad); --DSAL
      END IF;

       --se valida si la orden genero cargo para actualizar items
       IF sbFlagGencarg = 'S' THEN
            --se actualiza los items de la orden original
            FOR reg IN 1..TbItemsAjustado.COUNT LOOP
               Update or_order_items ooi
                   Set ooi.legal_item_amount = TbItemsAjustado(REG).legal_item_amount,
                       ooi.value             = TbItemsAjustado(REG).value,
                       ooi.total_price       = TbItemsAjustado(REG).total_price,
                       ooi.OUT_  = TbItemsAjustado(REG).OUT_,
                    --   ooi.ASSIGNED_ITEM_AMOUNT = TbItemsAjustado(REG).ASSIGNED_ITEM_AMOUNT,
                       ooi.SERIAL_ITEMS_ID  = TbItemsAjustado(REG).SERIAL_ITEMS_ID,
                       ooi.SERIE = TbItemsAjustado(REG).SERIE
                 Where /*ooi.order_id = inuorderid
                   And ooi.items_id = nuItemsAjus
                   AND */ORDER_ITEMS_ID =   TbItemsAjustado(REG).ORDER_ITEMS_ID;


                   --se valida si se produjo un cambio
                   IF sql%rowcount <> 1 THEN
                      osberror :='No se pudieron actualizar los valores de la orden '||inuorderid ||' para el items '||nuItemsAjus;
                      Raise exerror;
                   END IF;
              END LOOP;

        END IF;

      IF isbmovimiento = 'A' THEN

        -- Si se ajusta, se envian cantidades positivas para que al aplicar la resta en el
        -- procedimiento qeu ajusta la bodega del contratista disminuya el
        -- n?mero de elementos que est? sacando
        Select ooi.items_id, legal_item_amount, ooi.value
          Into ionuitemid, nucantidad, nucostoitem
          From or_order_items ooi
         Where ooi.order_id = onuorderidajuste
           And ooi.items_id = ionuitemid;

      End If;

      ut_trace.trace('

			 ionuItemId, ' || ionuitemid || ',
             nuCantidad, ' || nucantidad || ',
             nuCostoItem ' || nucostoitem,
                     10);

      nupaso := 49;

      -- Actualiza la bodega del contratista
      nupaso := 50;

      ut_trace.trace('Actualiza la bodega del contratista' || ionuitemid,
                     10); --DSAL

      If dage_item_classif.fsbgetquota(dage_items.fnugetitem_classif_id(ionuitemid)) =
         or_boconstants.csbsi Then
        --DSAL

        ut_trace.trace('Actualiza la bodega del contratista PORQUE EL ?TEM AS? LO INDICA',
                       10);

        ut_trace.trace(' proMueveInventarioUnidOper(inuOrderId            => ' ||
                       inuorderid || ',
                                           inuItem               => ' ||
                       ionuitemid || ',
                                           isbTipoBodega         => ' ||
                       sbtipobodega || ',
                                           inuSaldoOriginalUnid  => ' ||
                       nusaldooriginalunid || ',
                                           inuSaldoOriginalCost ' ||
                       nusaldooriginalcost || ',
                                           inuCantidadOriginalBG => ' ||
                       nucantidadoriginalbg || ',
                                           inuCostoOriginalBG    => ' ||
                       nucostooriginalbg || ',
                                           inuValor              => ' ||
                       nucostoitem || ',
                                           osbError              => ' ||
                       osberror || ');',
                       10);

        promueveinventariounidoper(inuorderid            => inuorderid,
                                   inuitem               => ionuitemid,
                                   isbtipobodega         => sbtipobodega,
                                   inusaldooriginalunid  => nusaldooriginalunid,
                                   inusaldooriginalcost  => nusaldooriginalcost,
                                   inucantidadoriginalbg => nucantidadoriginalbg,
                                   inucostooriginalbg    => nucostooriginalbg,
                                   inuvalor              => nucostoitem,
                                   inuCantidad           => nucantidad,
                                   osberror              => osberror);

        If osberror Is Not Null Then
          ut_trace.trace('Se present? un error al ejecutar el procedimiento ' ||
                         'proMueveInventarioUnidOper(inuOrderId  => ' ||
                         inuorderid || ',
                                       inuItem     => ' ||
                         ionuitemid || ',
                                       inuCantidad => ' || 0 || ',
                                       inuValor    => ' ||
                         nucostoitem || ',
                                       inuosbError => ' ||
                         osberror || isbmovimiento || ');',
                         10);
          Raise exerror;
        End If;
      End If; --IF DAGE_ITEM_CLASSIF.FSBGETQUOTA(nuClasificacionItem) = OR_BOCONSTANTS.CSBSI THEN DSAL
      nupaso := 50;

     --se valida si la orden de ajuste se creo o no
      IF sbFlagGencarg =  'N'  THEN
          or_bcadjustmentorder.deladjitemfromcert(inuorderid);

          ut_trace.trace('Marca como anulada la orden', 10);
          Begin
            Update or_order oo
               Set oo.order_status_id = dald_parameter.fnugetnumeric_value('COD_STATE_CANCEL_OT')
             Where oo.order_id = onuorderidajuste;

          Exception
            When Others Then
              osberror := 'Ocurri? un error al intentar marcar como anulada la orden ' ||
                          'de ajuste ' || onuorderidajuste ||
                          ' creada durante el proceso ' || Sqlerrm;
              Raise exerror;
          End;

          If Sql%Rowcount = 0 Then
            osberror := 'No se marc? como anulada la orden ' ||
                        onuorderidajuste || ' creada durante el proceso';
            Raise exerror;
          End If;

          If (fblaplicaentrega('OSS_CON_KCM_200771_1')) Then
            Begin
              Delete or_related_order ord
               Where ord.order_id = inuorderid
                 And ord.related_order_id = onuorderidajuste;
            Exception
              When Others Then
                osberror := 'Ocurrio un error al intentar eliminar la relaci?n entre la orden modificada ' ||
                            'y la de ajuste ' || Sqlerrm;
                Raise exerror;
            End;
          End If;
      END IF;

    End If;

    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);

  Exception
    when EX.CONTROLLED_ERROR then
      errors.geterror(nuOk,osberror);
    osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo || '.' || ')';
    When exerrorcontrolado Then
      osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo || '.' || ')';
    When exerror Then
      Null;
    When Others Then
      osberror := Sqlerrm || '( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
  End procreaordenajuste;

  /*************************
  ****************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proActualizaOrdenOriginal
  Descripci?n:              Actualiza la informaci?n calculada a partir de la
                            cantidad corregida indicada por el usuario

  Par?metros de entrada
  * inuOrderId              : Orden
  * inuOrdenRecalculo       : C?digo de la orden donde se legaliza la cantidad
                              correcta
  * inuOrOrderItemIdOrig    : C?digo del registro del ?tem en la orden original
  * inuItem                 : C?digo del ?tem

  Par?metros de salida
  * osbError                : Mensaje de error

  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones


  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure proactualizaordenoriginal(inuorderid           or_order.order_id%Type,
                                      inuordenrecalculo    or_order.order_id%Type,
                                      inuororderitemidorig or_order_items.order_items_id%Type,
                                      inuitem              or_order_items.items_id%Type,
                                      osberror             Out Varchar2) Is
    -- Variables de control
    nupaso Number; -- Progreso de ejecuci?n
    exerror        Exception; -- Error controlado
    exerrorinterno Exception;
    sbmetodo Varchar(4000) := 'proActualizaOrdenOriginal';

    rgor_order_items_recalculado or_order_items%Rowtype;
    rgor_order_recalculado       or_order%Rowtype;
    iorcorder                    daor_order.styor_order;

  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    nupaso := 10;
    Begin

      Select order_id,
             items_id,
             assigned_item_amount,
             legal_item_amount,
             Value,
             order_items_id,
             total_price,
             element_code,
             order_activity_id,
             element_id,
             reused,
             serial_items_id,
             serie,
             out_
        Into rgor_order_items_recalculado
        From or_order_items ooi
       Where ooi.order_id = inuordenrecalculo
         And ooi.items_id = inuitem;
    Exception
      When no_data_found Then

        rgor_order_items_recalculado.legal_item_amount := 0;
        rgor_order_items_recalculado.value             := 0;
        rgor_order_items_recalculado.total_price       := 0;

      When Others Then
        osberror := 'No fu? posible obtener la informaci?n de los ?tems asociados a la orden de ajuste comod?n' ||
                    ' - ' || inuordenrecalculo || ' - ' || inuitem ||
                    ' en la orden a modificar ' || inuorderid || ' - ' ||
                    Sqlerrm;
        Raise exerrorinterno;
    End;

    nupaso := 40;

    ut_trace.trace(' UPDATE Or_Order_Items ooi
            SET    ooi.legal_item_amount = ' ||
                   rgor_order_items_recalculado.legal_item_amount || ',
                   ooi.value             = ' ||
                   rgor_order_items_recalculado.value || ',
                   ooi.total_price       = ' ||
                   rgor_order_items_recalculado.total_price || '
            WHERE  ooi.order_id = ' || inuorderid || '
            AND    ooi.order_items_id = ' ||
                   inuororderitemidorig,
                   10);

    Begin
      Update or_order_items ooi
         Set ooi.legal_item_amount = rgor_order_items_recalculado.legal_item_amount,
             ooi.value             = rgor_order_items_recalculado.value,
             ooi.total_price       = rgor_order_items_recalculado.total_price
       Where ooi.order_id = inuorderid
         And ooi.order_items_id = inuororderitemidorig;

    Exception

      When Others Then
        osberror := 'No fu? posible actualizar la informaci?n de los ?tems asociados a la orden de ajuste comod?n' ||
                    ' - ' || inuordenrecalculo ||
                    ' en la orden a modificar ' || inuorderid || ' - ' ||
                    Sqlerrm;
        Raise exerrorinterno;
    End;

    If Sql%Rowcount = 0 Then

      ut_trace.trace('Valida si se actualiz? el registro', 10);
      nupaso   := 30;
      osberror := 'No se modificaron los ?tems en la orden ' || inuorderid ||
                  ' ?tem ' || inuororderitemidorig ||
                  ' con la informaci?n del a orden ' || inuordenrecalculo ||
                  ' item ' || inuitem ||
                  ' UPDATE Or_Order_Items ooi
            SET    ooi.legal_item_amount = ' ||
                  rgor_order_items_recalculado.legal_item_amount || ',
                   ooi.value             = ' ||
                  rgor_order_items_recalculado.value || ',
                   ooi.total_price       = ' ||
                  rgor_order_items_recalculado.total_price || '
            WHERE  ooi.order_id = ' || inuorderid || '
            AND    ooi.order_items_id = ' ||
                  inuororderitemidorig;
      Raise exerrorinterno;
    End If;

    ut_trace.trace('Agregar or_order_item', 10);
    nupaso := 40;

    ut_trace.trace('Obtiene el valor de la orden', 10);
    iorcorder.order_id := inuorderid;
    or_boordercost.getordercost(iorcorder => iorcorder);

    ut_trace.trace('Actualiza la informaci?n en la orden original', 10);
    nupaso := 80;
    Begin

      ut_trace.trace(' UPDATE or_order oo
                              SET    oo.order_value         = nvl(' ||
                     iorcorder.order_value ||
                     ', 0),
                                     oo.order_cost_average  = nvl(' ||
                     iorcorder.order_cost_average ||
                     ', 0),
                                     oo.order_cost_by_list  = nvl(' ||
                     iorcorder.order_cost_by_list ||
                     ', 0),
                                     oo.operative_aiu_value = nvl(' ||
                     iorcorder.operative_aiu_value ||
                     ', 0),
                                     oo.admin_aiu_value     = nvl(' ||
                     iorcorder.admin_aiu_value ||
                     ', 0)
                              WHERE  order_id = ' ||
                     inuorderid || ';',
                     10);

      Update or_order oo
         Set oo.order_value         = nvl(iorcorder.order_value, 0),
             oo.order_cost_average  = nvl(iorcorder.order_cost_average, 0),
             oo.order_cost_by_list  = nvl(iorcorder.order_cost_by_list, 0),
             oo.operative_aiu_value = nvl(iorcorder.operative_aiu_value, 0),
             oo.admin_aiu_value     = nvl(iorcorder.admin_aiu_value, 0)
       Where order_id = inuorderid;

    Exception
      When Others Then
        osberror := 'No fu? posible actualizar la informaci?n de las cantidades definitivas en la orden ' ||
                    inuorderid || ' - ' || Sqlerrm;
        Raise exerrorinterno;

    End;

    If Sql%Rowcount = 0 Then
      osberror := 'No se modific? la informaci?n en la orden ' ||
                  inuorderid;
      Raise exerrorinterno;
    End If;

    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);

  Exception
    When exerrorinterno Then
      osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
    When exerror Then
      Null;
    When Others Then
      osberror := Sqlerrm || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;

  End;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proCorregirOrden
  Descripci?n:              Obtiene toda la informaci?n referente a la tabla
                            or_order que debe ser almacenada en el log

  Par?metros de entrada
  inuOrderId                : Orden
  inuOrOrderItemId          : C?digo del registro dentro de la orden
  inuCantidad               : Cantidad a corregir
  onuCantidad_final         : Cantidad que en realidad se logr? legalizar

  Par?metros de salida
  onuValor_unit_final       : Valor unitario final
  onuValor_total_final      : Valor total final del ?tem corregido
  onuOrden_rev_anul         : C?digo de la orden de ajuste con la que se devolvieron
                              los ?tems originales
  onuOrder_item_id_rec      : C?digo del registro dentro de la orden de rec?lculo
  onuOrden_rec_anul         : C?digo de la ?rden donde se recalculan las cantidades
                              correctas
  osbError                  : Mensaje de error


  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones


  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure procorregirorden(inuorderid           or_order.order_id%Type,
                             inuororderitemid     or_order_items.order_items_id%Type,
                             inucantidad_final    ldc_log_items_modif_sin_acta.cantidad_final%Type,
                             onuvalor_unit_final  Out ldc_log_items_modif_sin_acta.costo_final%Type,
                             onuvalor_total_final Out ldc_log_items_modif_sin_acta.precio_final%Type,
                             onuorden_rev_anul    Out ldc_log_items_modif_sin_acta.orden_rev_anul%Type,
                             onuorder_item_id_rec Out ldc_log_items_modif_sin_acta.order_item_id_rec%Type,
                             onuorden_rec_anul    Out ldc_log_items_modif_sin_acta.orden_rec_anul%Type,
                             osberror             Out Varchar2) Is
    exerror        Exception; -- Error de un procedimiento que se llama
    exerrorinterno Exception; -- Error del proceso
    nupaso   Number; -- Paso en el que se presenta el error
    sbmetodo Varchar(4000) := 'proCorregirOrden';

    -- Variables del programa
--    tbitemareversar           or_bcadjustmentorder.tytbadjusteditems; -- Items para reversar
--    tbitemsarecalcular        or_bcadjustmentorder.tytbadjusteditems; -- Items para recalcular
--    nuitemmayoracero          Number; -- Indica si el ?tem originalmente est? en cero
    nuitems_id                or_order_items.items_id%Type;
    nuserialitemid            or_order_items.serial_items_id%Type;
    rgldclogitemsmodifsinacta ldc_log_items_modif_sin_acta%Rowtype;
--    nuunidadoperativa         or_order.operating_unit_id%Type;
--    nucantidadoriginal        or_order_items.legal_item_amount%Type; -- Cantidad original
  Begin
 osberror := NULL;
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    nupaso := 10;
    ut_trace.trace('Genera una orden de ajuste para el ?tem a modificar si tiene alguna
        cantidad legalizada originalmente y se crea la orden ficticia ',
                   10);
    -- para reversar esa cantidad
    nupaso := 50;
    procreaordenajuste(inuorderid       => inuorderid,
                       inuorderitemid   => inuororderitemid,
                       isbmovimiento    => 'R',
                       onuorderidajuste => rgldclogitemsmodifsinacta.orden_rev_anul,
                       ionuitemid       => nuitems_id,
                       osberror         => osberror);
    If osberror Is Not Null Then
      ut_trace.trace('Se presento un error al intentar crear la orden de ajuste para reversar lo inicialmente legalizado ' ||
                     'proCreaOrdenAjuste(inuOrderId       => ' ||
                     inuorderid || ',
                               inuOrderItemId   => ' ||
                     inuororderitemid || ',
                               isbMovimiento    => R,
                               onuOrderIdAjuste => ' ||
                     rgldclogitemsmodifsinacta.orden_rev_anul || ',
                               osbError         => ' ||
                     osberror,
                     10);
      Raise exerror;
    End If;
    onuorden_rev_anul := rgldclogitemsmodifsinacta.orden_rev_anul;
    ut_trace.trace('Prepara las cantiddes definitivas con la que quedar? la orden',10);
    nupaso := 60;
    If rgldclogitemsmodifsinacta.orden_rev_anul Is Not Null Then
      Begin
        Select ooi.items_id, ooi.serial_items_id
          Into nuitems_id, nuserialitemid
          From or_order_items ooi
         Where ooi.order_id = rgldclogitemsmodifsinacta.orden_rev_anul
           And ooi.items_id = nuitems_id; --dsal
      Exception
        When no_data_found Then
          ut_trace.trace('SELECT ooi.items_id,
                                           ooi.serial_items_id
                                    INTO   nuItems_Id,
                                           nuSerialItemId
                                    FROM   or_order_items ooi
                                    WHERE  ooi.order_id = ' ||
                         rgldclogitemsmodifsinacta.orden_rev_anul || '
                                    AND    ooi.items_id = ' ||
                         rgldclogitemsmodifsinacta.item_id || ';',
                         10);
          osberror := 'No se encontr? informaci?n para la orden de reversi?n ' ||
                      rgldclogitemsmodifsinacta.orden_rev_anul;
          Raise exerror;
      End;
    Else
      Begin
        Select ooi.items_id, ooi.serial_items_id
          Into nuitems_id, nuserialitemid
          From or_order_items ooi
         Where ooi.order_items_id = inuororderitemid;
      Exception
        When no_data_found Then
          osberror := 'No se encontr? informaci?n para el ?tem de la orden original ' ||
                      inuororderitemid;
          Raise exerror;
      End;
    End If;
    nupaso := 70;
    ut_trace.trace('Genera la orden de ajuste para legalizar las cantidades definitivas',
                   10);
    nupaso := 80;
    procreaordenajuste(inuorderid            => inuorderid,
                         inuorderitemid   => inuororderitemid,
                       inuserialitems_id     => nuserialitemid,
                       ionuitemid            => nuitems_id,
                       inucantidaddefinitiva => inucantidad_final,
                       isbmovimiento         => 'A',
                       onuorderidajuste      => rgldclogitemsmodifsinacta.orden_rec_anul,
                       osberror              => osberror);
    If osberror Is Not Null Then
      ut_trace.trace('Se present? un error al intentar generar la ' ||
                     'orden de ajuste comod?n por la cantidad corregida. ' ||
                     ' proCreaOrdenAjuste(inuOrderId            => ' ||
                     inuorderid || ',
                           inuSerialItems_Id     => ' ||
                     nuserialitemid || ',
                           inuItemId             => ' ||
                     nuitems_id || ',
                           inuCantidadDefinitiva => ' ||
                     inucantidad_final || ',
                           isbMovimiento         => A,
                           onuOrderIdAjuste      => ' ||
                     rgldclogitemsmodifsinacta.orden_rec_anul || ',
                           osbError              => ' ||
                     osberror || ');',
                     10);
    --  osberror := 'Se present? un error al intentar generar la orden de ajuste comod?n por la cantidad corregida. '||osberror;
      Raise exerror;
    End If;
    nupaso := 90;
    If rgldclogitemsmodifsinacta.orden_rec_anul Is Not Null Then
      Begin
        Select ooi.order_items_id, ooi.value, ooi.total_price
          Into onuorder_item_id_rec,
               onuvalor_unit_final,
               onuvalor_total_final
          From or_order_items ooi
         Where ooi.order_id = rgldclogitemsmodifsinacta.orden_rec_anul
           And ooi.items_id = nuitems_id;
      Exception
        When too_many_rows Then
          osberror := 'Se encontraron varios ?tems en la orden de ajuste de rec?lculo para la ot ' ||
                      rgldclogitemsmodifsinacta.orden_rec_anul ||
                      ' y el ?tem  ' || nuitems_id;
          Raise exerrorinterno;
        When no_data_found Then
          osberror := 'No Se encontraron ?tems en la orden de ajuste de rec?lculo para la ot ' ||
                      rgldclogitemsmodifsinacta.orden_rec_anul ||
                      ' y el ?tem  ' || nuitems_id;
          Raise exerrorinterno;
      End;
    Else
      onuvalor_unit_final  := 0;
      onuvalor_total_final := 0;
      onuorder_item_id_rec := Null;
      onuorden_rec_anul    := Null;
    End If;
    onuorden_rec_anul := rgldclogitemsmodifsinacta.orden_rec_anul;
    ut_trace.trace('Actualizar la informaci?n en la orden original', 10);
    nupaso := 100;
    proactualizaordenoriginal(inuorderid           => inuorderid,
                              inuordenrecalculo    => rgldclogitemsmodifsinacta.orden_rec_anul,
                              inuororderitemidorig => inuororderitemid,
                              inuitem              => nuitems_id,
                              osberror             => osberror);
    If osberror Is Not Null Then
      ut_trace.trace('Error al ejecutar proActualizaOrdenOriginal(inuOrderId           => ' ||
                     inuorderid || ',
                                  inuOrdenRecalculo    => ' ||
                     rgldclogitemsmodifsinacta.orden_rec_anul || ',
                                  inuOrOrderItemIdOrig => ' ||
                     inuororderitemid || ',
                                  inuItem              => ' ||
                     nuitems_id || ',
                                  osbError             => ' ||
                     osberror || ');',
                     10);
      Raise exerror;
    End If;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
  Exception
    When exerrorinterno Then
      osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
    When exerror Then
      osberror := osberror;
    When Others Then
      osberror := Sqlerrm || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;

  End;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proInicializaRegistroEnLog
  Descripci?n:              Obtiene la informaci?n de la orden original para
                            completar el registro en el log

  Par?metros de entrada
  inuOrden_Id               : C?digo de la orden
  inuORDER_ITEM_ID          : C?digo del registro dentro de la orden
  inuCantidad_Final         : Cantidad final
  isbObservacion            : Observaci?n de modificaci?n
  inuItem                   : C?digo del ?tem

  Par?metros de salida
  onuConsecutivo            : Consecutivo de la modificaci?n en la tabla log
  osbError                  : C?digo del error

  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  15-06-2017   KCienfuegos            CA200-833: Se actualizan las cantidades y costos en el log, posterior
                                      a la modificacion de los items
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure proinicializaregistroenlog(inuorden_id       or_order.order_id%Type,
                                       inuorder_item_id  or_order_items.order_items_id%Type,
                                       inucantidad_final ldc_log_items_modif_sin_acta.cantidad_final%Type,
                                       inuitem_id        ldc_log_items_modif_sin_acta.item_id%Type,
                                       isbobservacion    ldc_log_items_modif_sin_acta.observa_modif%Type,
                                       isbaccion         Varchar2,
                                       onuconsecutivo    Out ldc_log_items_modif_sin_acta.consecutivo%Type,
                                       osberror          Out Varchar2) Is

    exerror Exception; -- Excepci?n
    sbmetodo            Varchar2(4000) := 'proInicializaRegistroEnLog';
    nupackage_id        or_order_activity.package_id%Type; -- solicitud
    nuvalor_original    or_order_items.value%Type; -- valor original
    nuvalor_total_orig  or_order_items.total_price%Type; -- valor total original
    nuserial_items_id   or_order_items.serial_items_id%Type; -- serial del ?tem
    nulegal_item_amount ldc_log_items_modif_sin_acta.legal_item_amount%Type; -- cantidad legalizada originalmente
    nupaso              Number;
    nuUnidad            or_operating_unit.operating_unit_id%TYPE;
    nuCantBodPadre      or_ope_uni_item_bala.balance%TYPE;
    nuCostBodPadre      or_ope_uni_item_bala.total_costs%TYPE;
    nuCantBodInv        or_ope_uni_item_bala.balance%TYPE;
    nuCostBodInv        or_ope_uni_item_bala.total_costs%TYPE;
    nuCantBodAct        or_ope_uni_item_bala.balance%TYPE;
    nuCostBodAct        or_ope_uni_item_bala.total_costs%TYPE;

  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    ut_trace.trace('Completa informaci?n del log', 10);
    nupaso := 10;

    ut_trace.trace('N?mero de la solicitud', 10);
    Begin
      Select Max(ooa.package_id)
        Into nupackage_id
        From or_order_activity ooa
       Where ooa.order_id = inuorden_id;
    Exception
      When no_data_found Then
        Null;
      When too_many_rows Then
        osberror := 'Se encontraron varias solicitudes asociadas a la orden ' ||
                    inuorden_id;
      When Others Then
        osberror := 'Se present? un error no controlado al intentar obtener ' ||
                    'el c?digo de la solicitud asociada a la orden ' ||
                    inuorden_id;
    End;

    nupaso := 20;

    If osberror Is Not Null Then
      Raise exerror;
    End If;

    --or_ope_uni_item_bala
    --ldc_inv_ouib
    --ldc_act_ouib

    nupaso := 30;
    If isbaccion = 'MODIFICACION' Then

      ut_trace.trace('Valores originales', 10);
      Begin
        Select ooi.value,
               ooi.total_price,
               ooi.serial_items_id,
               ooi.legal_item_amount
          Into nuvalor_original,
               nuvalor_total_orig,
               nuserial_items_id,
               nulegal_item_amount
          From or_order_items ooi
         Where ooi.order_items_id = inuorder_item_id;

      Exception
        When no_data_found Then
          osberror := 'No se encontraron ?tems asociados al registro ' ||
                      inuorder_item_id;
        When too_many_rows Then
          osberror := 'Se encontraron varios registros ' ||
                      inuorder_item_id;
        When Others Then
          osberror := 'No fue posible consultar la informaci?n asociada al registro ' ||
                      inuorder_item_id;
      End;

      IF osberror IS NOT NULL THEN
        RAISE exerror;
      END IF;

      IF (dage_items.fnugetitem_classif_id(inuitem_id,0) IN (GE_BOItemsConstants.CNUCLASIFICACION_HERR,
                                                             GE_BOItemsConstants.CNUCLASIFICACION_MATER_INVE,
                                                             GE_BOItemsConstants.CNUCLASIFICACION_EQUIPO))THEN
        nuUnidad := daor_order.fnugetoperating_unit_id(inuorden_id,0);

        BEGIN
         SELECT bp.balance,
                bp.total_costs
           INTO nuCantBodPadre,
                nuCostBodPadre
           FROM or_ope_uni_item_bala bp
          WHERE bp.operating_unit_id = nuUnidad
            AND bp.items_id = inuitem_id;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega padre para el item '||
                        inuitem_id||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega padre del registro ' ||
                        inuorder_item_id;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

        BEGIN
         SELECT bi.balance,
                bi.total_costs
           INTO nuCantBodInv,
                nuCostBodInv
           FROM ldc_inv_ouib bi
          WHERE bi.operating_unit_id = nuUnidad
            AND bi.items_id = inuitem_id;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega inventario para el item '||
                        inuitem_id||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega inventario del registro ' ||
                        inuorder_item_id;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

        BEGIN
         SELECT ba.balance,
                ba.total_costs
           INTO nuCantBodAct,
                nuCostBodAct
           FROM ldc_act_ouib ba
          WHERE ba.operating_unit_id = nuUnidad
            AND ba.items_id = inuitem_id;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega de activos para el item '||
                        inuitem_id||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega de activos del registro ' ||
                        inuorder_item_id;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

      END IF;

    End If;

    ut_trace.trace('Se calcula el consecutivo', 10);
    nupaso         := 80;
    onuconsecutivo := seq_ldc_log_items_modif_sin.nextval;

    ut_trace.trace('Se modifica el log con los valores iniciales', 10);
    nupaso := 90;
    Insert Into ldc_log_items_modif_sin_acta llimosa
      (orden_id,
       package_id,
       order_item_id,
       item_id,
       legal_item_amount,
       costo_original,
       precio_original,
       cantidad_final,
       observa_modif,
       consecutivo,
       serial_items_id,
       prev_ouib_balance,
       prev_ouib_total_cost,
       prev_oi_balance,
       prev_oi_total_cost,
       prev_ao_balance,
       prev_ao_total_cost)
    Values
      (inuorden_id, --orden_id,
       nupackage_id, --package_id,
       inuorder_item_id, --order_item_id,
       inuitem_id, --item_id,
       nulegal_item_amount, --legal_item_amount,
       nuvalor_original, --valor_original,
       nuvalor_total_orig, --valor_total_orig,
       inucantidad_final, --cantidad_final,
       isbobservacion, --observa_modif,
       onuconsecutivo, --consecutivo,
       nuserial_items_id, --serial_items_id,
       nuCantBodPadre,
       nuCostBodPadre,
       nuCantBodInv,
       nuCostBodInv,
       nuCantBodAct,
       nuCostBodAct);
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);

  Exception
    When exerror Then
      osberror := osberror || '( ' || gsbpaquete || '.' || sbmetodo ||
                  nupaso || ')';
    When Others Then
      osberror := gsbpaquete || '.' || sbmetodo || nupaso || ' - ' ||
                  Sqlerrm;
  End proinicializaregistroenlog;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: getOrderItems
  Descripci?n:               Obtiene los ?tems asociados a la orden

  Par?metros de entrada
  * id          : C?digo del registro del ?tem dentro de la orden
  * description : Item y descripci?ni
  * rfQuery     : Cursor referenciado

  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/

  Procedure getorderitems(id          In Number,
                          description In Varchar2,
                          rfquery     Out constants.tyrefcursor) Is
    sbsqlorderitems Varchar2(2000) := '';
    sbinstance      ge_boinstancecontrol.stysbname;
    nuordenid       or_order.order_id%Type;
    sbmetodo        Varchar2(4000) := 'getOrderItems';
    nupaso          Number; -- Indica cual fue la ?ltima instrucci?n en ejecutarse
    sberror         Varchar(4000);
    sborden_id      Varchar(4000);
    cnunull_attribute Constant Number := 2126;

  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);

    nupaso := 10;

    ge_boinstancecontrol.getattributenewvalue('WORK_INSTANCE',
                                              Null,
                                              'OR_ORDER',
                                              'ORDER_ID',
                                              sborden_id);

    nuordenid := to_number(sborden_id);

    If (sborden_id Is Null) Then
      errors.seterror(cnunull_attribute, 'No llen? el campo orden');
      Raise ex.controlled_error;
    End If;

    If (nuordenid Is Null) Then
      nupaso := 40;
      ge_boerrors.seterrorcodeargument(2741,
                                       'Por favor ingrese un n?mero de orden ');
    End If;

    nupaso := 50;

    IF (fblaplicaentrega(csbEntrega833)) THEN

    sbsqlorderitems := '  SELECT ge_items.items_id id,
             ge_items.description DESCRIPTION
      FROM   ge_items,
           or_task_types_items,
           ge_measure_unit
      WHERE  or_task_types_items.task_type_id =
           daor_order.fnugettask_type_id(' ||
                       nuordenid || ', 0)
      AND    ge_items.items_id = or_task_types_items.items_id
      AND    ge_measure_unit.measure_unit_id = ge_items.measure_unit_id
      AND    ge_items.item_classif_id <> DALD_PARAMETER.fnuGetNumeric_Value(''CLASIF_ITEM_SERIAD'',0)
      ORDER  BY id DESC';

    ELSE
      sbsqlorderitems := '  SELECT ge_items.items_id id,
             ge_items.description DESCRIPTION
      FROM   ge_items,
           or_task_types_items,
           ge_measure_unit
      WHERE  or_task_types_items.task_type_id =
           daor_order.fnugettask_type_id(' ||
                       nuordenid || ', 0)
      AND    ge_items.items_id = or_task_types_items.items_id
      AND    ge_measure_unit.measure_unit_id = ge_items.measure_unit_id
      ORDER  BY id DESC';

    END IF;

    /*'and    ge_items.items_id not in (select ooi.items_id
    from   or_order_items ooi
    where  ooi.order_id = ' || nuOrdenId || ')'||*/

    nupaso := 60;

    Open rfquery For sbsqlorderitems;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);

  Exception
    When Others Then
      sberror := gsbpaquete || '.' || sbmetodo || nupaso || ' - ' ||
                 Sqlerrm;
  End;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proInicializaRegistroEnLog
  Descripci?n:              Ejecuta el proceso de la forma MIOSA
  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Par?metros de entrada
  * inuConsecutivo       : Consecutivo del log
  * inuCantidad_final    : Cantidad definitiva
  * inuValor_unit_final  : Valor nuevo calculado
  * inuValor_total_final : Valor total calculado
  * inuOrden_rev_anul    : Orden de ajuste para la reversi?n de las cantidades
                           iniciales
  * inuOrder_item_id_rec : C?digo del ?tem en la orden donde se recalcularon las
                           nuevas cantidades legalizadas
  * inuOrden_rec_anul    : C?digo de la orden de ajuste donde se calcularon las
                           cantidades nuevas legalizadas

  Par?metros de salida
  * osbError

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  15-06-2017   KCienfuegos            CA200-833: Se actualizan las cantidades y costos en el log, posterior
                                      a la modificacion de los items
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/
  Procedure proterminaregistroenlog(inuconsecutivo       ldc_log_items_modif_sin_acta.consecutivo%Type,
                                    inucantidad_final    ldc_log_items_modif_sin_acta.cantidad_final%Type,
                                    inuvalor_unit_final  ldc_log_items_modif_sin_acta.costo_final%Type,
                                    inuvalor_total_final ldc_log_items_modif_sin_acta.precio_final%Type,
                                    inuorden_rev_anul    ldc_log_items_modif_sin_acta.orden_rev_anul%Type,
                                    inuorder_item_id_rec ldc_log_items_modif_sin_acta.order_item_id_rec%Type,
                                    inuorden_rec_anul    ldc_log_items_modif_sin_acta.orden_rec_anul%Type,
                                    osberror             Out Varchar2) Is
    sbmetodo            Varchar2(4000) := 'proTerminaRegistroEnLog';
    nupaso              Number; -- Indica cual fue la ?ltima instrucci?n en ejecutarse
    nuOrden             or_order.order_id%TYPE;
    nuItem              ge_items.items_id%TYPE;
    nuUnidad            or_operating_unit.operating_unit_id%TYPE;
    nuCantBodPadre      or_ope_uni_item_bala.balance%TYPE;
    nuCostBodPadre      or_ope_uni_item_bala.total_costs%TYPE;
    nuCantBodInv        or_ope_uni_item_bala.balance%TYPE;
    nuCostBodInv        or_ope_uni_item_bala.total_costs%TYPE;
    nuCantBodAct        or_ope_uni_item_bala.balance%TYPE;
    nuCostBodAct        or_ope_uni_item_bala.total_costs%TYPE;
    exerror             EXCEPTION;

  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);

    nupaso := 10;

    BEGIN
      SELECT orden_id,
             item_id
        INTO nuOrden,
             nuItem
        FROM ldc_log_items_modif_sin_acta l
       WHERE l.consecutivo = inuconsecutivo;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    IF (dage_items.fnugetitem_classif_id(nuItem,0) IN (GE_BOItemsConstants.CNUCLASIFICACION_HERR,
                                                       GE_BOItemsConstants.CNUCLASIFICACION_MATER_INVE,
                                                       GE_BOItemsConstants.CNUCLASIFICACION_EQUIPO))THEN
      IF(daor_order.fblexist(nuOrden))THEN
         nuUnidad := daor_order.fnugetoperating_unit_id(nuOrden,0);
      END IF;

      BEGIN
         SELECT bp.balance,
                bp.total_costs
           INTO nuCantBodPadre,
                nuCostBodPadre
           FROM or_ope_uni_item_bala bp
          WHERE bp.operating_unit_id = nuUnidad
            AND bp.items_id = nuItem;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega padre para el item '||
                        nuItem||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega padre del registro ' ||
                        inuorder_item_id_rec;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

        BEGIN
         SELECT bi.balance,
                bi.total_costs
           INTO nuCantBodInv,
                nuCostBodInv
           FROM ldc_inv_ouib bi
          WHERE bi.operating_unit_id = nuUnidad
            AND bi.items_id = nuItem;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega inventario para el item '||
                        nuItem||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega inventario del registro ' ||
                        inuorder_item_id_rec;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

        BEGIN
         SELECT ba.balance,
                ba.total_costs
           INTO nuCantBodAct,
                nuCostBodAct
           FROM ldc_act_ouib ba
          WHERE ba.operating_unit_id = nuUnidad
            AND ba.items_id = nuItem;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega de activos para el item '||
                        nuItem||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega de activos del registro ' ||
                        inuorder_item_id_rec;
        END;
     END IF;

    Update ldc_log_items_modif_sin_acta l
       Set l.cantidad_final    = inucantidad_final,
           l.costo_final       = inuvalor_unit_final,
           l.precio_final      = inuvalor_total_final,
           l.orden_rev_anul    = inuorden_rev_anul,
           l.order_item_id_rec = inuorder_item_id_rec,
           l.orden_rec_anul    = inuorden_rec_anul,
           l.post_ouib_balance = nuCantBodPadre,
           l.post_ouib_total_cost = nuCostBodPadre,
           l.post_oi_balance   = nuCantBodInv,
           l.post_oi_total_cost= nuCostBodInv,
           l.post_ao_balance   = nuCantBodAct,
           l.post_ao_total_cost= nuCostBodAct,
           l.usu_modif         = User,
           l.fecha_modif       = Sysdate
     Where l.consecutivo = inuconsecutivo;

    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
  Exception
    When exerror Then
      null;
    When Others Then
      osberror := gsbpaquete || '.' || sbmetodo || ' - ' || nupaso ||
                  ' - No fue posible registrar el cambio en el log, consecutivo ' ||
                  inuconsecutivo || ' - ' || Sqlerrm;
  End;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proAdicionaItemALaOrden
  Descripci?n:               Adiciona un ?tem a una orden ya legalizada
  Autor : Sandra Mu?oz
  Fecha : 18-10-2015
  Par?metros de entrada:    inuOrderId: Orden
                            inuItem:    Item
  Par?metros de salida:     onuOrderItemId: C?digo del registro adicionado
                            osbError: Mensaje de error
  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  ******************************************************************/

  Procedure proadicionaitemalaorden(inuorderid     or_order_items.order_id%Type,
                                    inuitem        or_order_items.items_id%Type,
                                    onuorderitemid Out or_order_items.order_items_id%Type,
                                    osberror       Out Varchar2) Is

    exerror Exception; -- Error controlado
    nupaso                   Number; -- Paso ejecutado
    sbmetodo                 Varchar2(4000) := 'proAdicionaItemALaOrden';
    nuestadooriginalorden    or_order.order_status_id%Type; -- Estado de la orden
    nuitemsorigen            Number; -- Cantidad de ?tems legalizados originalmente
    nuitemsfinal             Number := 0; -- Cantidad de ?tems a los que se les reestablece su valor original
    nuaddressid              pr_product.address_id%Type; -- Direcci?n del producto
    nuerrorproc              Number; -- Error procedimiento
    sbvalidaconfparaunidoper ge_item_classif.quota%Type; -- Indica si el ?tem debe validar si est? asignado al unidad operativa
    nuorderid                or_order.order_id%Type; -- Orden
    nuunidadoperativa        or_order.operating_unit_id%Type; -- Unidad operativa de la orden
    nuclasificacionitem      ge_item_classif.item_classif_id%Type; -- Clasificaci?n del ?tem
    nutieneitemparametrizado Number; -- 1: Tiene parametrizaci?n de ?tem asociado a la unidad operativa, 0: No tiene parametriaci?n de ?tem asociado a la unidad operativa
    nuactivity_order         or_order_activity.order_activity_id%Type;
    nusecuencia              ldc_or_order_items_temp.sesion%TYPE;
    -- Guarda una foto de los ?tems ya legalizados en la orden
    Cursor cuitems(nucursecuencia NUMBER) Is
      Select order_id,
             items_id,
             assigned_item_amount,
             legal_item_amount,
             Value,
             order_items_id,
             total_price,
             element_code,
             order_activity_id,
             element_id,
             reused,
             serial_items_id,
             serie,
             out_
        From ldc_or_order_items_temp looit
       Where looit.order_id = inuorderid
         And looit.sesion   = nucursecuencia;
  Begin
    osberror := NULL;
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    ut_trace.trace('Saca copia de los ?tems de la orden legalizados hasta el momento
        ya que el procedimiento OS_ADDITEMSORDER los deja en cero',
                   10);
    nupaso := 10;
    nusecuencia := seq_ldc_or_order_items_temp.nextval;
    Begin
      Insert Into ldc_or_order_items_temp
        (order_id,
         items_id,
         assigned_item_amount,
         legal_item_amount,
         Value,
         order_items_id,
         total_price,
         element_code,
         order_activity_id,
         element_id,
         reused,
         serial_items_id,
         serie,
         out_,
         sesion)
        Select order_id,
               items_id,
               assigned_item_amount,
               legal_item_amount,
               Value,
               order_items_id,
               total_price,
               element_code,
               order_activity_id,
               element_id,
               reused,
               serial_items_id,
               serie,
               out_,
               nusecuencia-- userenv('sessionid')
          From or_order_items ooi
         Where ooi.order_id = inuorderid;
    Exception
      When Others Then
        osberror := 'No fu? posible sacar copia de los dem?s ?tems de la orden ' ||
                    'antes de iniciar el proceso.';
        Raise exerror;
    End;
    nuitemsorigen := SQL%ROWCOUNT;
    ut_trace.trace('Cambia instant?neamente el estado de la ?rden para poder agregar el ?tem',                 10);
    nupaso := 20;
    Begin
      Select order_status_id, oo.operating_unit_id
        Into nuestadooriginalorden, nuunidadoperativa
        From or_order oo
       Where oo.order_id = inuorderid;
    Exception
      When Others Then
        osberror := 'No fu? posible obtener el estado actual de la orden ' ||inuorderid;
        Raise exerror;
    End;
    ut_trace.trace('Deja la orden en estado asignado', 10);
    nupaso := 30;
    Begin
      Update or_order oo
         Set oo.order_status_id = 7 --dald_parameter.fnugetnumeric_value('ESTADO_ASIGNADO')
       Where oo.order_id = inuorderid;
    Exception
      When Others Then
        osberror := 'No fu? posible dejar la orden ' || inuorderid ||
                    'en estado ' ||
                    dald_parameter.fnugetnumeric_value('ESTADO_ASIGNADO') ||
                    ' moment?neamente para agregar el ?tem. ' || Sqlerrm;
        Raise exerror;
    End;
    If Sql%Rowcount = 0 Then
      osberror := 'No se actualiz? orden ' || inuorderid || 'a estado ' ||
                  dald_parameter.fnugetnumeric_value('ESTADO_ASIGNADO') ||
                  ' moment?neamente para agregar el ?tem';
      Raise exerror;
    End If;
    ut_trace.trace('Adiciona el ?tem a la orden', 10);
    nupaso              := 50;
    nuclasificacionitem := dage_items.fnugetitem_classif_id(inuitem);
    If (nuclasificacionitem = or_boconstants.cnuitems_class_to_activity) Then
      nupaso := 53;
      Select Distinct pp.address_id
        Into nuaddressid
        From or_order_activity ooa, pr_product pp
       Where ooa.order_id = inuorderid
         And ooa.product_id = pp.product_id
         And ooa.product_id Is Not Null;
      nuorderid := inuorderid;
        os_createorderactivities(inuactivity        => inuitem,
                                 inuparsedaddressid => nuaddressid,
                                 idtexecdate        => Sysdate,
                                 isbcomment         => 'Actividad agregado luego de la legalizaci?n',
                                 inureferencevalue  => or_boitemvalue.fnugetitemprice(inuitem,
                                                                                      nuunidadoperativa,
                                                                                      nuaddressid,
                                                                                      Null),
                                 ionuorderid        => nuorderid,
                                 onuerrorcode       => nuerrorproc,
                                 osberrormessage    => osberror);
       if osberror is not null then
        osberror := 'procedimiento : os_createorderactivities. '||osberror;
        Raise exerror;
       end if;
    Else
      nupaso := 57;
      -- Si el ?tem no requiere estar asociado a una unidad operativa
      -- se asigna moment?neamente para permitir adicionarlo
      If dage_item_classif.fsbgetquota(nuclasificacionitem) !=
         or_boconstants.csbsi Then
        -- Por calidad de datos puede que la parametrizaci?n ya exista, en
        -- este caso no se agrega y se deja un se?al para luego no
        -- borrar esa parametrizaci?n
        nuunidadoperativa := daor_order.fnugetoperating_unit_id(inuorder_id   => inuorderid,
                                                                inuraiseerror => osberror);
        If nuunidadoperativa Is Null Then

          osberror := 'No fue posible determinar la unidad operativa para la orden ' ||
                      inuorderid;
          Raise exerror;
        End If;
        If daor_ope_uni_item_bala.fblexist(inuitem, nuunidadoperativa) Then
          nutieneitemparametrizado := 1;
        Else
          nutieneitemparametrizado := 0;
          Begin
            Insert Into or_ope_uni_item_bala oouib
              (items_id,
               operating_unit_id,
               quota,
               balance,
               total_costs,
               occacional_quota,
               transit_in,
               transit_out)
            Values
              (inuitem, nuunidadoperativa, 0, 0, 0, 0, 0, 0);
          Exception
            When Others Then
              osberror := 'No fue posible asignar el ?tem ' || inuitem ||
                          ' a la unidad operativa ' || nuunidadoperativa ||
                          ' moment?neamente para realizar la adici?n del ?tem';
              Raise exerror;
          End;
          If Sql%Rowcount = 0 Then
            osberror := 'No se asign? el ?tem ' || inuitem ||
                        ' a la unidad operativa ' || nuunidadoperativa ||
                        ' moment?neamente para realizar la adici?n del ?tem';
            Raise exerror;
          End If;
        End If;
      End If;
      os_additemsorder(inuorderid         => inuorderid,
                       inuitemid          => inuitem,
                       inulegalitemamount => 0,
                       onuerrorcode       => nupaso,
                       osberrormessage    => osberror);
      If osberror Is Not Null Then
        osberror := 'procedimiento : os_additemsorder. '||osberror;
        Raise exerror;
      End If;
      -- Si el ?tem no estaba parametrizado se elimina
      If nutieneitemparametrizado = 0 Then
        Delete or_ope_uni_item_bala oouib
         Where oouib.items_id = inuitem
           And oouib.operating_unit_id = nuunidadoperativa;
        If Sql%Rowcount = 0 Then
          osberror := 'No se elimin? la parametrizaci?n del ?tem ' ||
                      inuitem ||
                      ' creada moment?neamente para la unidad operativa ' ||
                      nuunidadoperativa;
          Raise exerror;
        End If;
      End If;
    End If;
    ut_trace.trace('Regresa la orden a su estado original', 10);
    nupaso := 60;
    Begin
      Update or_order oo
         Set oo.order_status_id = nuestadooriginalorden
       Where oo.order_id = inuorderid;
    Exception
      When Others Then
        osberror := 'No fu? posible dejar la orden ' || inuorderid ||
                    'su estado original' || nuestadooriginalorden ||
                    Sqlerrm;
        Raise exerror;
    End;
    If Sql%Rowcount = 0 Then
      osberror := 'No se actualiz? la orden ' || inuorderid ||
                  'a su estado ' || nuestadooriginalorden;
      Raise exerror;
    End If;
    ut_trace.trace('Recupera la informaci?n modificada por el proceso OS_ADDITEMSORDER',
                   10);
    nupaso := 70;
    nuitemsfinal := 0;
    For rgitems In cuitems(nusecuencia) Loop
      Begin
        Select t.order_activity_id
          Into nuactivity_order
          From or_order_activity t
         Where t.order_id = rgitems.order_id;
      Exception
        When no_data_found Then
          nuactivity_order := rgitems.order_activity_id;
        When Others Then
          nuactivity_order := rgitems.order_activity_id;
      End;
      Begin
        Update or_order_items ooi
           Set ooi.assigned_item_amount = rgitems.assigned_item_amount,
               ooi.legal_item_amount    = rgitems.legal_item_amount,
               ooi.value                = rgitems.value,
               ooi.total_price          = rgitems.total_price,
               ooi.element_code         = rgitems.element_code,
               ooi.order_activity_id    = rgitems.order_activity_id,
               ooi.element_id           = rgitems.element_id,
               ooi.reused               = rgitems.reused,
               ooi.serial_items_id      = rgitems.serial_items_id,
               ooi.serie                = rgitems.serie,
               ooi.out_                 = rgitems.out_
         Where ooi.order_items_id = rgitems.order_items_id;
           IF SQL%NOTFOUND THEN
            BEGIN
             INSERT INTO or_order_items ooi(
                                             order_id
                                            ,items_id
                                            ,assigned_item_amount
                                            ,legal_item_amount
                                            ,value
                                            ,order_items_id
                                            ,total_price
                                            ,element_code
                                            ,order_activity_id
                                            ,element_id
                                            ,reused
                                            ,serial_items_id
                                            ,serie
                                            ,out_
                                            )
                                     VALUES(
                                            rgitems.order_id
                                           ,rgitems.items_id
                                           ,rgitems.assigned_item_amount
                                           ,rgitems.legal_item_amount
                                           ,rgitems.value
                                           ,rgitems.order_items_id
                                           ,rgitems.total_price
                                           ,rgitems.element_code
                                           ,rgitems.order_activity_id
                                           ,rgitems.element_id
                                           ,rgitems.reused
                                           ,rgitems.Serial_Items_Id
                                           ,rgitems.serie
                                           ,rgitems.out_
                                          );
              EXCEPTION
               WHEN dup_val_on_index THEN
                NULL;
              END;
           END IF;
      Exception
        When Others Then
          osberror := 'No fu? posible reestablecer la cantidad legalizada ' ||
                      'originalmente en la orden ' ||
                      rgitems.order_items_id || '. ' || Sqlerrm;
          Raise exerror;
      End;
      nuitemsfinal := nuitemsfinal + 1;
    End Loop;
    ut_trace.trace('Verifica que se hayan recuperado todos los registros modificados originalmente',
                   10);
    nupaso := 80;
    If nvl(nuitemsorigen,0) <> nvl(nuitemsfinal,0) Then
      osberror := 'No se reestableci? el valor de todos los ?tems. ';
      Raise exerror;
    End If;
/*     jjjm Se dejan los item en la tabla temporal en caso de reversar.
    ut_trace.trace('Borrar los registros temporales de la tabla', 10);
    nupaso := 90;
    Begin
      Delete ldc_or_order_items_temp looit
       Where looit.order_id = inuorderid
         And looit.sesion = userenv('sessionid');
    Exception
      When Others Then
        osberror := 'No fue posible borrar los registros de la tabla temporal ' ||
                    'ldc_or_order_items_temp asociados a la orden ' ||
                    inuorderid || ' sesion ' || userenv('sessionid') ||
                    Sqlerrm;
        Raise exerror;
    End;*/
    ut_trace.trace('Obtiene el c?digo del registro insertado', 10);
    nupaso := 100;
    Begin
      Select Max(ooi.order_items_id)
        Into onuorderitemid
        From or_order_items ooi
       Where ooi.order_id = inuorderid
         And ooi.items_id = inuitem;
    Exception
      When Others Then
        osberror := 'No fu? posible obtener el c?digo del registro insertado en la orden ' ||
                    inuorderid || ' para el ?tem ' || inuitem;
        Raise exerror;
    End;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
  Exception
    When exerror Then
      osberror := osberror;
    When Others Then
      osberror := nupaso || ' - ' || osberror || '(' || gsbpaquete || '.' ||
                  sbmetodo || ')';
  End;
  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: Process
  Descripci?n:               Ejecuta el proceso de la forma MIOSA
  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones


  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  17-04-2019   horbath                200-2391 llama a validaciones en LDC_PKGASIGNARCONT.PRPROCMIOAIOORD
  ******************************************************************/
  Procedure process(inuorden_id       in out ge_boinstancecontrol.stynuindex,
                    inuorder_item_id  In Out ge_boinstancecontrol.stynuindex,
                    inucantidad_final ge_boinstancecontrol.stysbvalue,
                    isbobserva_modif  ge_boinstancecontrol.stysbvalue,
                    inuitem_id        ge_boinstancecontrol.stysbvalue,
                    isbaccion         Varchar2,
                    osberror          Out Varchar2) Is

    -- Variables de la forma
    nuindex ge_boinstancecontrol.stynuindex;
    -- Variables del procedimiento
    --        sbError                     VARCHAR2(4000); -- Error
    sbmetodo                    Varchar2(4000) := 'Process';
    nucantidad_final_definitiva ldc_log_items_modif_sin_acta.cantidad_final%Type;
    nuvalor_unit_final          ldc_log_items_modif_sin_acta.costo_final%Type;
    nuorden_rev_anul            ldc_log_items_modif_sin_acta.orden_rev_anul%Type;
    nuorder_item_id_rec         ldc_log_items_modif_sin_acta.order_item_id_rec%Type;
    nuorden_rec_anul            ldc_log_items_modif_sin_acta.orden_rec_anul%Type;
    nuvalor_total_final         ldc_log_items_modif_sin_acta.precio_final%Type;
    nuconsecutivo               ldc_log_items_modif_sin_acta.consecutivo%Type;
    nupaso                      Number; -- Lugar donde se produce el error
    sbinstance                  Varchar2(4000);
    exerror        Exception;
    exerrorinterno Exception;


    sbClasifItem         VARCHAR2(4000) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CLASITEMAEXCLUIR', NULL); --200-2391
    valorantes           number;
    valordespues         number;
    serr varchar2(4000);
    nerr number;
	sbModule  varchar2(4000);
  Begin
      -- 200-2391 se calcula valor antes de cambio
    SELECT SUM(nvl(it.value,0))
           INTO Valorantes
           FROM open.or_order_items it,open.ge_items id,OR_ORDER ORD
           WHERE ord.order_id=inuorden_id
                 AND ord.order_id = it.order_id
               --  And ord.order_status_id = 8
                 AND id.item_classif_id not in  (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(sbClasifItem, ',') ))
                 AND it.items_id = id.items_id;
    osberror := NULL;
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    ut_trace.trace('Valida la informaci?n ingresada por par?metro en la forma',10);
    nupaso := 90;
    provalidainformacion(inuordenitemid       => inuorder_item_id,
                         inuitem              => inuitem_id,
                         inuorderid           => inuorden_id,
                         inucantidadcorregida => inucantidad_final,
--                         isbaccion            => isbaccion,
                         osberror             => osberror);
    If osberror Is Not Null Then
      osberror := 'procedimiento : LDC_PRAJUSORDESINACTA.provalidainformacion. '||osberror;
      Raise exerror;
    End If;


    If isbaccion = 'AGREGAR' Then
      ut_trace.trace('Agrega el ?tem a la orden si ?ste no se hab?a legalizado antes', 10);
      nupaso := 100;
       DBMS_APPLICATION_INFO.SET_MODULE(
    module_name => 'LDCAIOSA',
    action_name => 'LDCAIOSA');

      proadicionaitemalaorden(inuorderid     => inuorden_id,
                              inuitem        => inuitem_id,
                              onuorderitemid => inuorder_item_id,
                              osberror       => osberror);

      If osberror Is Not Null Then
        osberror := 'procedimiento : LDC_PRAJUSORDESINACTA.proadicionaitemalaorden. '||osberror;
        Raise exerror;
      End If;
    End If;
    ut_trace.trace('Almacena la informaci?n en el log', 10);
    nupaso := 110;
    proinicializaregistroenlog(inuorden_id       => inuorden_id,
                               inuorder_item_id  => inuorder_item_id,
                               inucantidad_final => inucantidad_final,
                               inuitem_id        => inuitem_id,
                               isbobservacion    => isbobserva_modif,
                               isbaccion         => isbaccion,
                               onuconsecutivo    => nuconsecutivo,
                               osberror          => osberror);
    If osberror Is Not Null Then
      osberror := 'procedimiento : LDC_PRAJUSORDESINACTA.proinicializaregistroenlog. '||osberror;
      Raise exerror;
    End If;
    ut_trace.trace('Reversa y ajusta las cantidades correctas', 10);
    nupaso := 130;
    procorregirorden(inuorderid           => inuorden_id,
                     inuororderitemid     => inuorder_item_id,
                     inucantidad_final    => inucantidad_final,
                     onuvalor_unit_final  => nuvalor_unit_final,
                     onuvalor_total_final => nuvalor_total_final,
                     onuorden_rev_anul    => nuorden_rev_anul,
                     onuorder_item_id_rec => nuorder_item_id_rec,
                     onuorden_rec_anul    => nuorden_rec_anul,
                     osberror             => osberror);
    IF osberror Is Not Null Then
      osberror := 'procedimiento : LDC_PRAJUSORDESINACTA.procorregirorden. '||osberror;
      RAISE exerror;
    END IF;
    ut_trace.trace('Completa el registro de log', 10);
    nupaso := 150;
    proterminaregistroenlog(inuconsecutivo       => nuconsecutivo,
                            inucantidad_final    => inucantidad_final,
                            inuvalor_unit_final  => nuvalor_unit_final,
                            inuvalor_total_final => nuvalor_total_final,
                            inuorden_rev_anul    => nuorden_rev_anul,
                            inuorder_item_id_rec => nuorder_item_id_rec,
                            inuorden_rec_anul    => nuorden_rec_anul,
                            osberror             => osberror);

    If osberror Is Not Null Then
      osberror := 'procedimiento : LDC_PRAJUSORDESINACTA.proterminaregistroenlog. '||osberror;
      Raise exerror;
    End If;

 -- 200-2391 se calcula valor legalizado despues de cambio
    SELECT SUM(nvl(it.value,0))
           INTO Valordespues
           FROM open.or_order_items it,open.ge_items id,OR_ORDER ORD
           WHERE ord.order_id=inuorden_id
                 AND ord.order_id = it.order_id
               --  And ord.order_status_id = 8
                 AND id.item_classif_id not in  (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(sbClasifItem, ',') ))
                 AND it.items_id = id.items_id;
    -- llama a procedimiento para validar y hacer ajustes segun 200-2391
    LDC_PKGASIGNARCONT.PRPROCMIOAIOORD(inuorden_id ,valorantes,valordespues,nerr,serr);
    if nerr=0 then -- no hubo error
       null;
    else           -- hubo error
       osberror:=serr;
       raise exerror;
    end if;

--    Commit;
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
  Exception
    When exerrorinterno Then
      osberror := osberror || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
    When exerror Then
     osberror := osberror;
    When Others Then
      osberror := Sqlerrm || ' ( ' || nupaso || ' - ' || gsbpaquete || '.' ||
                  sbmetodo;
  End;

  Procedure provalidadatosobligatorios(isbaccion         In Varchar2,
                                       onuorder_item_id  Out Number,
                                       onucantidad_final Out Number,
                                       osbobserva_modif  Out Varchar2,
                                       onuitem_id        Out Number,
                                       onuorden_id       Out Number,
                                       osberror          Out Varchar2) Is

--    cnunull_attribute Constant Number := 2126;
    sborden_id       ge_boinstancecontrol.stynuindex;
    sborder_items_id ge_boinstancecontrol.stynuindex;
    sbcantidad_final ge_boinstancecontrol.stysbvalue;
    sbobserva_modif  ge_boinstancecontrol.stysbvalue;
    sbitem_id        ge_boinstancecontrol.stysbvalue;
    sbmetodo         Varchar2(4000) := 'proValidaDatosObligatorios';
    sberror          Varchar2(4000);
    nupaso           Number;
    exerror Exception;
  Begin
    sberror := NULL;
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    nupaso := 10;
    ut_trace.trace('Evaluando si la engrega esta aplicada', 10);
    If fsbaplicaentrega('OSS_SMS_ARA_8732') = 'N' Then
      sberror := 'Esta funcionalidad no se encuentra habilitada en esta ' ||
                 'empresa, si la requiere solicite al administrador que habilite ' ||
                 'la entrega OSS_SMS_ARA_8732';
      Raise exerror;
      ut_trace.trace('la entrega no aplica', 10);
    End If;
    nupaso := 20;
    ut_trace.trace('leyendo el valor del campo order_id desde la forma', 10);
    ge_boinstancecontrol.getattributenewvalue('WORK_INSTANCE',
                                              Null,
                                              'OR_ORDER',
                                              'ORDER_ID',
                                              sborden_id);

    nupaso := 40;
    ut_trace.trace('Leyendo la cantidad final desde la forma', 10);
    sbcantidad_final := ge_boinstancecontrol.fsbgetfieldvalue('LDC_LOG_ITEMS_MODIF_SIN_ACTA',
                                                              'CANTIDAD_FINAL');

    nupaso := 55;
    If isbaccion = 'AGREGAR' Then
      ut_trace.trace('Leyendo el c?digo del ?tem desde la forma', 10);
      sbitem_id  := ge_boinstancecontrol.fsbgetfieldvalue('LDC_LOG_ITEMS_MODIF_SIN_ACTA',
                                                          'ITEM_ID');
      onuitem_id := to_number(sbitem_id);
    Else
      ut_trace.trace('leyendo el valor del campo order_id desde la forma ORCAO');
      ge_boinstancecontrol.getattributenewvalue('WORK_INSTANCE',
                                                Null,
                                                'OR_ORDER_ITEMS',
                                                'ORDER_ITEMS_ID',
                                                sborder_items_id);
      Begin
        Select ooi.items_id
          Into onuitem_id
          From or_order_items ooi
         Where ooi.order_items_id = sborder_items_id;
      Exception
        When Others Then
          sberror := 'No fu? posible obtener el ?tem asociado al registro seleccionado. ';
          Raise exerror;
      End;
    End If;
    nupaso := 50;
    ut_trace.trace('Leyendo la observaci?n de modificaci?n desde la forma',10);
    sbobserva_modif := ge_boinstancecontrol.fsbgetfieldvalue('LDC_LOG_ITEMS_MODIF_SIN_ACTA',
                                                             'OBSERVA_MODIF');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    nupaso := 50;
    ut_trace.trace('Verificando si se ingres? la orden en la forma', 10);
    If (sborden_id Is Null) Then
      sberror := 'No se obtuvo en n?mero de orden';
      Raise exerror;
    End If;

    nupaso := 60;
    If isbaccion = 'AGREGAR' Then
      ut_trace.trace('Verificando si se ingres? el ?tem desde la forma',
                     10);
      If sbitem_id Is Null Then
        sberror := '?tem a modificar';
        Raise exerror;
      End If;
    End If;
    --
    nupaso := 70;
    ut_trace.trace('Verificando si de ingres? la cantidad corregida', 10);
    If (sbcantidad_final Is Null) Then
      sberror := 'Por favor indique la cantidad corregida';
      Raise exerror;
    End If;
    nupaso := 80;
    ut_trace.trace('Verificando si se ingres? la observaci?n de modificaci?n',
                   10);
    If (sbobserva_modif Is Null) Then
      sberror := 'Por favor indique observaci?n de la modificaci?n';
      Raise exerror;
    End If;
    ut_trace.trace('Obteniendo la informaci?n de la forma para convertirlos
    par?metros para usar en los procedimientos.',10);
    onuorder_item_id  := to_number(sborder_items_id);
    onucantidad_final := to_number(sbcantidad_final);
    osbobserva_modif  := sbobserva_modif;
    onuorden_id       := to_number(sborden_id);
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
    osberror := sberror;
  Exception
    When exerror Then
     osberror := to_char(nupaso)||' '||sberror;
    When Others Then
      osberror := nupaso || ' - ' || osberror || '(' || gsbpaquete || '.' ||
                  sbmetodo || ')'||' '||SQLERRM;
  End provalidadatosobligatorios;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: Process
  Descripci?n:               Ejecuta el proceso de la forma MIOSA
  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones


  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  14-06-2017   KCienfuegos.CA200-833  Se impide la modificacion de items seriados
  09-09-2016   KCienfuegos.CA200-771  Se setea el m?dulo
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  10-10-2016   Jorge Valiente         CASO 200-699: No permitir modificar ITEM COTIZADO configurado en el
                                                    parametro COD_ITEMCOTI_LDCRIAIC
  ******************************************************************/
  Procedure promodifitem Is
    nuorder_item_id  ge_boinstancecontrol.stynuindex;
    nucantidad_final ge_boinstancecontrol.stysbvalue;
    sbobserva_modif  ge_boinstancecontrol.stysbvalue;
    nuitem_id        ge_boinstancecontrol.stysbvalue;
    nuorden_id       ge_boinstancecontrol.stysbvalue;
    sbmetodo         Varchar2(4000) := 'proModifItem';
    nuClasificacion  ge_items.item_classif_id%TYPE;
    sbmodulooriginal Varchar2(2000);
    sberror          Varchar2(4000);

	sbInstance       Varchar2(4000);
    nupaso           Number;
    exerror Exception;
    nuitemsorigen number;
    --Inicio CASO 200-699
    --cursor para validar si el item a legalizar es un ITEM COTIZADO
    sborder_items_id ge_boinstancecontrol.stynuindex;
    onuitem_id       Number;
    nusecuencia      ldc_or_order_items_temp.sesion%TYPE;
    nucontaitmsot   NUMBER;
    Cursor cuvalidaitemcotizado(initemcotizado Number) Is
      Select Count(1) cantidad
        From dual
       Where initemcotizado In
             (Select to_number(column_value)
                From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                                                         Null),

                                                        ',')));

    rfcuvalidaitemcotizado cuvalidaitemcotizado%Rowtype;

    nuCoderror NUMBER;
    --Fin CASO 200-699
  Begin
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo, 10);
    sbmodulooriginal := ut_session.getmodule;
    If (fblaplicaentrega('OSS_CON_KCM_200771_1')) Then
      ut_session.setmodule(csbpantmoditems, csbpantmoditems, 'N');
    End If;
    ---CASO 200-699
	--GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);


    ge_boinstancecontrol.getattributenewvalue('WORK_INSTANCE',
                                              Null,
                                              'OR_ORDER_ITEMS',
                                              'ORDER_ITEMS_ID',
                                              sborder_items_id);
    Begin
      Select ooi.items_id
        Into onuitem_id
        From or_order_items ooi
       Where ooi.order_items_id = sborder_items_id;
    Exception
      When Others Then
        onuitem_id := 0;
    End;
    IF (fblaplicaentrega(csbEntrega833)) THEN
      IF(dage_items.fblexist(onuitem_id))THEN
        nuClasificacion :=  dage_items.fnugetitem_classif_id(onuitem_id, 0);
        IF(nuClasificacion = GE_BOItemsConstants.CNUCLASIFICACION_EQUIPO)THEN
           sberror := 'No se permite modificar Items Seriados';
           RAISE exerror;
        END IF;
      END IF;
    END IF;
    Open cuvalidaitemcotizado(onuitem_id);
    Fetch cuvalidaitemcotizado
      Into rfcuvalidaitemcotizado;
    Close cuvalidaitemcotizado;
    If rfcuvalidaitemcotizado.cantidad = 1 And
       fblaplicaentrega('OSS_CON_JLV_200699_3') Then
      sberror := 'Al Item Cotizado NO se le permite modificar desde la forma LDCMIOSA';
      Raise exerror;
    Else
      ---CASO 200-699
      provalidadatosobligatorios(isbaccion         => 'MODIFICACION',
                                 onuorder_item_id  => nuorder_item_id,
                                 onucantidad_final => nucantidad_final,
                                 osbobserva_modif  => sbobserva_modif,
                                 onuitem_id        => nuitem_id,
                                 onuorden_id       => nuorden_id,
                                 osberror          => sberror);
      If sberror Is Not Null Then
        Raise exerror;
      End If;
      nupaso := 90;
          -- Guardamos una copia de los items
    nusecuencia := seq_ldc_or_order_items_temp.nextval;
    Begin
      Insert Into ldc_or_order_items_temp
        (order_id,
         items_id,
         assigned_item_amount,
         legal_item_amount,
         Value,
         order_items_id,
         total_price,
         element_code,
         order_activity_id,
         element_id,
         reused,
         serial_items_id,
         serie,
         out_,
         sesion)
        Select order_id,
               items_id,
               assigned_item_amount,
               legal_item_amount,
               Value,
               order_items_id,
               total_price,
               element_code,
               order_activity_id,
               element_id,
               reused,
               serial_items_id,
               serie,
               out_,
               nusecuencia-- userenv('sessionid')
          From or_order_items ooi
         Where ooi.order_id = nuorden_id;
    Exception
      When Others Then
        sberror := 'No fu? posible sacar copia de los dem?s ?tems de la orden ' ||
                    'antes de iniciar el proceso.';
        Raise exerror;
    End;
    nuitemsorigen := SQL%ROWCOUNT;
      ut_trace.trace('Procesando la informacion '|| nuorden_id, 10);
      process(inuorden_id       => nuorden_id,
              inuorder_item_id  => nuorder_item_id,
              inucantidad_final => nucantidad_final,
              isbobserva_modif  => sbobserva_modif,
              inuitem_id        => nuitem_id,
              isbaccion         => 'MODIFICACION',
              osberror          => sberror);
      If sberror Is Not Null Then
        Raise exerror;
      End If;
      --CASO 200-699
    End If; --final de validacion de item cotizado
    --CASO 200-699
    nucontaitmsot := 0;
    SELECT COUNT(1) INTO nucontaitmsot
      FROM open.or_order_items it
     WHERE it.order_id = nuorden_id;
     IF nvl(nucontaitmsot,0) <> nvl(nuitemsorigen,0) THEN
      sberror := 'No se reestableci? el valor de todos los ?tems. ';
      Raise exerror;
     END IF;
    ut_session.setmodule(sbmodulooriginal, sbmodulooriginal, 'N');
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
    if sberror is null then
     commit;
    end if;
  Exception
    When exerror Then

      ut_session.setmodule(sbmodulooriginal, sbmodulooriginal, 'N');
      If sberror Is Null Then
        sberror := sberror || gsbpaquete || '.' || sbmetodo || ' - ' ||
                   nupaso || nuorden_id;
      End If;
      ERRORS.SETERROR(Ld_Boconstans.cnuGeneric_Error,
                                sberror);
       Rollback;
              RAISE EX.CONTROLLED_ERROR;
     -- ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sberror);
--      pkerrors.seterrormessage(sberror);
--      Raise;
    When Others Then
      ERRORS.getERROR(nuCoderror,
                                sberror);


      ut_session.setmodule(sbmodulooriginal, sbmodulooriginal, 'N');
      sberror :=sberror ||'-'|| gsbpaquete || '.' || sbmetodo || ' - ' || nupaso || ' - ' ||
                 nuorden_id || Sqlerrm;
      ERRORS.SETERROR(Ld_Boconstans.cnuGeneric_Error,
                                sberror);
       Rollback;
              RAISE EX.CONTROLLED_ERROR;
      --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sberror);
--      pkerrors.seterrormessage(nupaso || ' - ' || Sqlerrm);
--      Raise ex.controlled_error;
  End promodifitem;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del procedimiento: proAgregaItem
  Descripci?n:               Ejecuta el proceso de la forma MIOSA
  Autor : Sandra Mu?oz
  Fecha : 09-10-2015

  Historia de Modificaciones


  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  14-06-2017   KCienfuegos.CA200-833  Se impide la adicion de items seriados
  09-09-2016   KCienfuegos.CA200-771  Se setea el m?dulo
  09-10-2015   Sandra Mu?oz           Creaci?n. Aranda 8732
  10-10-2016   Jorge Valiente         CASO 200-699: No permitir ingresar ITEM COTIZADO configurado en el
                                                    parametro COD_ITEMCOTI_LDCRIAIC
  ******************************************************************/
  Procedure proagregaitem Is
    nuorder_item_id  ge_boinstancecontrol.stynuindex;
    nucantidad_final ge_boinstancecontrol.stysbvalue;
    sbobserva_modif  ge_boinstancecontrol.stysbvalue;
    nuitem_id        ge_boinstancecontrol.stysbvalue;
    nuorden_id       ge_boinstancecontrol.stysbvalue;
    sbmetodo         Varchar2(4000) := 'proAgregaItem';
    nuClasificacion  ge_items.item_classif_id%TYPE;
    sbmodulooriginal Varchar2(2000);
    sberror          Varchar2(4000);
    nupaso           Number;
    exerror Exception;
    nucontatemp number;
    nucontaitem NUMBER;
    --Inicio CASO 200-699
    --cursor para validar si el item a legalizar es un ITEM COTIZADO
    sbitem_id  ge_boinstancecontrol.stysbvalue;
    onuitem_id Number;
    Cursor cuvalidaitemcotizado(initemcotizado Number) Is
      Select Count(1) cantidad
        From dual
       Where initemcotizado In
             (Select to_number(column_value)
                From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',Null),',')));
    rfcuvalidaitemcotizado cuvalidaitemcotizado%Rowtype;
    --Fin CASO 200-699

    --Inicio caso 298
    csbEntrega298  VARCHAR2(200) := 'OSS_OL_0000298_GDC_1';
    sborden_id       ge_boinstancecontrol.stynuindex;
    nuCont   number;
    CURSOR cuValidaitems IS
    SELECT count(1)
    FROM OPEN.OR_ORDER_ITEMS
    WHERE ORDER_ID = sborden_id
    AND   ITEMS_ID = onuitem_id;
    --Fin caso 298

  Begin
    sberror := NULL;
    ut_trace.trace('Inicio ' || gsbpaquete || '.' || sbmetodo ||' Orden ' || nuorden_id, 10);
    sbmodulooriginal := ut_session.getmodule;
    If (fblaplicaentrega('OSS_CON_KCM_200771_1')) Then
      ut_session.setmodule(csbpantadiitems, csbpantadiitems, 'N');
    End If;
    ---CASO 200-699
    sbitem_id  := ge_boinstancecontrol.fsbgetfieldvalue('LDC_LOG_ITEMS_MODIF_SIN_ACTA','ITEM_ID');
    onuitem_id := to_number(sbitem_id);

    -- INICIO CASO 298
    IF (fblaplicaentrega(csbEntrega298)) THEN
      ge_boinstancecontrol.getattributenewvalue('WORK_INSTANCE',Null,'OR_ORDER','ORDER_ID',sborden_id);
      Open cuValidaitems;
      Fetch cuValidaitems Into nuCont;
      Close cuValidaitems;


      IF nuCont > 0 THEN
        sberror := 'El items '||onuitem_id||' ya esta registrado para la orden '||sborden_id||'';
        RAISE exerror;
      END IF;
    END IF;
    --FIN CASO 298

    IF (fblaplicaentrega(csbEntrega833)) THEN
      IF(dage_items.fblexist(onuitem_id))THEN
        nuClasificacion :=  dage_items.fnugetitem_classif_id(onuitem_id, 0);
        IF(nuClasificacion = ge_boitemsconstants.cnuclasificacion_equipo)THEN
           sberror := 'No se permite ingresar Items Seriados';
           RAISE exerror;
        END IF;
      END IF;
    END IF;
    Open cuvalidaitemcotizado(onuitem_id);
    Fetch cuvalidaitemcotizado
      Into rfcuvalidaitemcotizado;
    Close cuvalidaitemcotizado;
    If rfcuvalidaitemcotizado.cantidad = 1 And
       fblaplicaentrega('OSS_CON_JLV_200699_3') Then
      sberror := 'Al Item Cotizado NO se le permite ingresar desde la forma LDCAIOSA';
      Raise exerror;
    Else
      ---CASO 200-699
      provalidadatosobligatorios(isbaccion         => 'AGREGAR',
                                 onuorder_item_id  => nuorder_item_id,
                                 onucantidad_final => nucantidad_final,
                                 osbobserva_modif  => sbobserva_modif,
                                 onuitem_id        => nuitem_id,
                                 onuorden_id       => nuorden_id,
                                 osberror          => sberror);
      If sberror Is Not Null Then
        sberror := 'procedimiento : LDC_PRAJUSORDESINACTA.provalidadatosobligatorios. '||sberror;
        Raise exerror;
      End If;
      nupaso := 90;
      ut_trace.trace('Procesando la informacion '||nuorden_id, 10);
      process(inuorden_id       => nuorden_id,
              inuorder_item_id  => nuorder_item_id,
              inucantidad_final => nucantidad_final,
              isbobserva_modif  => sbobserva_modif,
              inuitem_id        => nuitem_id,
              isbaccion         => 'AGREGAR',
              osberror          => sberror);
      If sberror Is Not Null Then
        sberror := 'procedimiento : LDC_PRAJUSORDESINACTA.process. '||sberror;
        Raise exerror;
      End If;
      --CASO 200-699
    End If; --final de validacion de item cotizado
    --CASO 200-699
    ut_session.setmodule(sbmodulooriginal, sbmodulooriginal, 'N');
    ut_trace.trace('Termina ' || gsbpaquete || '.' || sbmetodo, 10);
    IF sberror IS NULL THEN
      COMMIT;
    END IF;
  Exception
    When exerror Then
      Rollback;
      ut_session.setmodule(sbmodulooriginal, sbmodulooriginal, 'N');
      If sberror Is Null Then
        sberror := sberror || gsbpaquete || '.' || sbmetodo || ' - ' ||
                   nupaso || nuorden_id;
      End If;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sberror);
      --pkerrors.seterrormessage(sberror);
      --Raise;
    When Others Then
      Rollback;
      ut_session.setmodule(sbmodulooriginal, sbmodulooriginal, 'N');
      sberror := gsbpaquete || '.' || sbmetodo || ' - ' || nupaso || ' - ' ||
                 nuorden_id || Sqlerrm;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sberror);
--      pkerrors.seterrormessage(nupaso || ' - ' || Sqlerrm);
--      Raise ex.controlled_error;
  End proagregaitem;

  PROCEDURE procGetPrecioCostOrden
    (
        inuOrdeBase   IN  OR_ORDER.ORDER_ID%TYPE,
        iTbItemAjustar IN tytbadjusteditems,
        oTbItemsAjustado     out    DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS,
        onuOk  OUT NUMBER,
        osbError  OUT VARCHAR2
    )
    IS
        regOrdenbase           DAOR_ORDER.STYOR_ORDER;
        regTipoTrab           DAOR_TASK_TYPE.STYOR_TASK_TYPE;
        NUORDERACTIVITY      OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;


        NUSELECTEDACTIVITY   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
        RCSELECTEDACTIVITY   DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
        nuDireOrden     OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
        nuProducto          OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;

        NUORDERITEMSINDEX    PLS_INTEGER;
        NUOPERAIUORDER       OR_ORDER.OPERATIVE_AIU_VALUE%TYPE := 0;
        NUOPERAIUVALUE       OR_ORDER.OPERATIVE_AIU_VALUE%TYPE := 0;
        NUADMINAIUORDER      OR_ORDER.ADMIN_AIU_VALUE%TYPE := 0;


        CNUINVALID_ACT              CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 5544;
        CNUADJUSTMENT_ACTIVITY      CONSTANT GE_ITEMS.ITEMS_ID%TYPE := GE_BOITEMSCONSTANTS.CNUADJUSTMENTACTIVITY;

        BLGENERATEAIU        BOOLEAN;


        NUVALORNOLIQUIDADO   ge_contrato.VALOR_NO_LIQUIDADO%TYPE := 0;
		sbClasifItem         VARCHAR2(4000) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CLASITEMAEXCLUIR', NULL); --200-2391
		nuIsmate NUMBER;

        PROCEDURE proValidaDatos
        IS
            NUINDEX PLS_INTEGER;
        BEGIN

            DAGE_ITEMS.ACCKEY(CNUADJUSTMENT_ACTIVITY);
            IF DAGE_ITEMS.FNUGETITEM_CLASSIF_ID(CNUADJUSTMENT_ACTIVITY) <> OR_BOORDERACTIVITIES.CNUACTIVITYTYPE THEN
                UT_TRACE.TRACE('Fin procGetPrecioCostOrden No Creo �rden', 6);
                ERRORS.SETERROR(CNUINVALID_ACT,
                                CNUADJUSTMENT_ACTIVITY);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            IF (OR_BCORDER.FBLORDERHASACTIVITY(inuOrdeBase,
                                               CNUADJUSTMENT_ACTIVITY)) THEN
                ERRORS.SETERROR(8342);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            IF (iTbItemAjustar.COUNT = 0) THEN
                ERRORS.SETERROR(8502);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            NUINDEX := iTbItemAjustar.FIRST;
            LOOP
                EXIT WHEN NUINDEX IS NULL;
                IF (iTbItemAjustar(NUINDEX).LEGAL_ITEM_AMOUNT = 0) THEN
                    ERRORS.SETERROR(8502);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;

                NUINDEX := iTbItemAjustar.NEXT(NUINDEX);
            END LOOP;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END proValidaDatos;

        PROCEDURE proGetActividadBase
        IS
            TBORIORDERITEMS      OR_BCORDERITEMS.TYTBORDERITEMS;
            RCORIORDERITEM       DAOR_ORDER_ITEMS.STYOR_ORDER_ITEMS;
            NUINDEX              VARCHAR2(32);
        BEGIN
            OR_BCORDERITEMS.GETORDERITEMBYORDER(inuOrdeBase,
                                                TBORIORDERITEMS);

            NUINDEX := TBORIORDERITEMS.FIRST;

            WHILE NUINDEX IS NOT NULL LOOP
                UT_TRACE.TRACE('tbItemsOrden('||NUINDEX||').nuOrderItemsId; '||TBORIORDERITEMS(NUINDEX).NUORDERITEMSID, 17);
                RCORIORDERITEM := DAOR_ORDER_ITEMS.FRCGETRECORD(TBORIORDERITEMS(NUINDEX).NUORDERITEMSID);

                IF (NVL(RCORIORDERITEM.LEGAL_ITEM_AMOUNT,
                        0) > 0) THEN
                    IF (DAGE_ITEMS.FNUGETITEM_CLASSIF_ID(RCORIORDERITEM.ITEMS_ID) = OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ACTIVITY) THEN
                        IF (RCORIORDERITEM.ORDER_ACTIVITY_ID IS NULL) THEN
                            RCORIORDERITEM.ORDER_ACTIVITY_ID := OR_BCGENORDINSPECC.FNUOBTORDERACTIVITYID(inuOrdeBase,
                                                                                                         RCORIORDERITEM.ORDER_ITEMS_ID);
                        END IF;

                        NUSELECTEDACTIVITY := RCORIORDERITEM.ORDER_ACTIVITY_ID;
                        IF (nuDireOrden IS NULL) THEN
                            nuDireOrden := DAOR_ORDER_ACTIVITY.FNUGETADDRESS_ID(RCORIORDERITEM.ORDER_ACTIVITY_ID,
                                                                                     0);
                        END IF;
                        IF (nuProducto IS NULL) THEN
                            nuProducto := DAOR_ORDER_ACTIVITY.FNUGETPRODUCT_ID(RCORIORDERITEM.ORDER_ACTIVITY_ID,
                                                                                0);
                        END IF;
                    END IF;
                END IF;

                NUINDEX := TBORIORDERITEMS.NEXT(NUINDEX);
            END LOOP;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END proGetActividadBase;

        PROCEDURE proProcItemsOrden
        IS
            NUINDEX              PLS_INTEGER;

            NUERRORCODE          GE_ERROR_LOG.MESSAGE_ID%TYPE;
            SBERRORMESSAGE       GE_ERROR_LOG.DESCRIPTION%TYPE;

            NUINSERTINDEX        BINARY_INTEGER := 0;
            NULEGALITEMAMOUNT    OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;
            NUSERIALITEMSID      OR_ORDER_ITEMS.SERIAL_ITEMS_ID%TYPE;

            NUITEMSID            OR_ORDER_ITEMS.ITEMS_ID%TYPE;


            nuContratista          GE_CONTRATO.ID_CONTRATISTA%TYPE;

            nuContrato            GE_CONTRATO.ID_CONTRATO%TYPE;
            nuSolicitud             OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE;
            regCotizacion         DACC_QUOTATION.STYCC_QUOTATION;

            PROCEDURE proProcInventario
            IS
                NUMOVID           OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;
                NUSERIALITEMSID   OR_ORDER_ITEMS.SERIAL_ITEMS_ID%TYPE;
                NULEGALITEMAMOUNT OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;
                NUITEMSID         GE_ITEMS.ITEMS_ID%TYPE;
            BEGIN

                OR_BOITEMS.INSERTINTEMTAB(GE_BOITEMSCONSTANTS.FNUGETADJUSTORDERMOVCAUSE);

                NULEGALITEMAMOUNT := iTbItemAjustar(NUINDEX).LEGAL_ITEM_AMOUNT;
             /*   OR_BOOPEUNIITEMBALA.UPDBALANCE(iTbItemAjustar(NUINDEX).ITEMS_ID,
                                               regOrdenbase.OPERATING_UNIT_ID,
                                               NULEGALITEMAMOUNT);*/

                NUSERIALITEMSID := iTbItemAjustar(NUINDEX).SERIAL_ITEMS_ID;
                IF (NUSERIALITEMSID IS NOT NULL) THEN
                    NUMOVID := OR_BOITEMSMOVE.FNUGETBALAMOVEID;

                    IF (NUMOVID  IS NOT NULL) THEN
                        DAOR_UNI_ITEM_BALA_MOV.UPDID_ITEMS_SERIADO(NUMOVID,
                                                                   NUSERIALITEMSID);
                    END IF;

                    IF (NULEGALITEMAMOUNT < 0) THEN
                        DAGE_ITEMS_SERIADO.UPDID_ITEMS_ESTADO_INV(NUSERIALITEMSID,
                                                                  GE_BOITEMSCONSTANTS.CNUSTATUS_DISPONIBLE);

                        NUITEMSID := DAGE_ITEMS_SERIADO.FNUGETITEMS_ID(NUSERIALITEMSID);
                        IF_BOPREVMAINTENANCE.UPDATESERIALITEM(NUSERIALITEMSID,
                                                              NUITEMSID);
                    END IF;
                END IF;
            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    RAISE EX.CONTROLLED_ERROR;
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    RAISE EX.CONTROLLED_ERROR;
            END proProcInventario;

            PROCEDURE proGetLiquiItems
            IS
                NULIQMETHOD          PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE;
                NUBALANCE            OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE;
                NUBALANCEPRICE       OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE;
                NUTOTALVALUEITEM     OR_ORDER_ITEMS.VALUE%TYPE;
                SBCOSTMETHOD         GE_ITEM_CLASSIF.COST_METHOD%TYPE;
                SBQUANTITYCONTROL    GE_ITEM_CLASSIF.QUANTITY_CONTROL%TYPE;
                NUCOSTCOTIZEDVALITEM NUMBER;
                NUAIUPERCENT         NUMBER;
                NUADMINAIUVALUE      NUMBER;
            BEGIN

                OR_BOITEMVALUE.GETLIQMETHOD(regOrdenbase.ORDER_ID, nuSolicitud, NULIQMETHOD);
                OR_BOITEMVALUE.GTBADJUSTDATE  :=  NVL(regOrdenbase.LEGALIZATION_DATE, regOrdenbase.ASSIGNED_DATE);

                OR_BOITEMVALUE.GETITEMVALUEANDCOSTMETHOD
                (
                    oTbItemsAjustado(NUINSERTINDEX).ITEMS_ID,
                    NULEGALITEMAMOUNT,
                    regOrdenbase.OPERATING_UNIT_ID,
                    OR_BOITEMVALUE.GTBADJUSTDATE,
                    GE_BOCONSTANTS.CSBYES,
                    NUBALANCE,
                    NUBALANCEPRICE,
                    NUTOTALVALUEITEM,
                    SBCOSTMETHOD,
                    SBQUANTITYCONTROL,
                    GE_BOCONSTANTS.CSBNO,
                    regOrdenbase.ORDER_ID,
                    nuContratista,
                    nuContrato
                );

                oTbItemsAjustado(NUINSERTINDEX).VALUE := NVL(NUTOTALVALUEITEM, 0);
                NUCOSTCOTIZEDVALITEM := NULL;


                NUOPERAIUVALUE := OR_BOITEMVALUE.FNUGETOPERATIVEAIU
                                                 (
                                                     regOrdenbase.ORDER_ID,
                                                     NVL(NUTOTALVALUEITEM, 0),
                                                     oTbItemsAjustado(NUINSERTINDEX).ITEMS_ID,
                                                     regOrdenbase.OPERATING_UNIT_ID
                                                 );
                UT_TRACE.TRACE('Costo Operativo del Item ='||NUOPERAIUVALUE,15);


                IF oTbItemsAjustado(NUINSERTINDEX).OUT_ = GE_BOCONSTANTS.CSBYES THEN
                    NUOPERAIUORDER := NUOPERAIUORDER + NVL(NUOPERAIUVALUE, 0);
                END IF;

                IF  regCotizacion.QUOTATION_ID IS NOT NULL
                    AND
                       NULIQMETHOD IN
                        (
                            OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE,
                            OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE
                        )
                THEN

                  OR_BOORDERITEMS.SETITEMVALUEBYQUOTATION
                    (
                        regCotizacion,
                        oTbItemsAjustado(NUINSERTINDEX).ITEMS_ID,
                        regOrdenbase.TASK_TYPE_ID,
                        NVL(oTbItemsAjustado(NUINSERTINDEX).LEGAL_ITEM_AMOUNT,0),
                        NULIQMETHOD,
                        regOrdenbase.EXEC_INITIAL_DATE,
                        NUCOSTCOTIZEDVALITEM,
                        NUAIUPERCENT
                    );
                    NUAIUPERCENT := NVL(NUAIUPERCENT,0);

                    IF NULIQMETHOD = OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE THEN
                        NUADMINAIUVALUE := NUCOSTCOTIZEDVALITEM * NUAIUPERCENT / 100;
                    ELSE
                        NUADMINAIUVALUE := 0;
                    END IF;
                    UT_TRACE.TRACE('Establece el precio del item dada la cotizacion.nuCostCotizedValItem = '||NUCOSTCOTIZEDVALITEM,15);

                END IF;


                IF NUCOSTCOTIZEDVALITEM IS NOT NULL THEN
                    UT_TRACE.TRACE('El item es cotizado.',15);

                    oTbItemsAjustado(NUINSERTINDEX).VALUE := oTbItemsAjustado(NUINSERTINDEX).VALUE + NVL(NUOPERAIUVALUE, 0);
                    oTbItemsAjustado(NUINSERTINDEX).TOTAL_PRICE := NUCOSTCOTIZEDVALITEM + NUADMINAIUVALUE;
                    IF   oTbItemsAjustado(NUINSERTINDEX).OUT_ = GE_BOCONSTANTS.CSBYES
                         AND NULIQMETHOD = OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE
                         AND BLGENERATEAIU
                    THEN
                        NUADMINAIUORDER := NVL(NUADMINAIUORDER, 0) + NVL(NUADMINAIUVALUE, 0);
                    END IF;
                ELSE
                    UT_TRACE.TRACE('El item no esta cotizado',15);
                    IF NULIQMETHOD = OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE THEN
                        NUADMINAIUVALUE := OR_BOITEMVALUE.FNUGETADMINAIU
                                                                (
                                                                   oTbItemsAjustado(NUINSERTINDEX).VALUE,
                                                                   NUOPERAIUVALUE
                                                                );

                        IF  oTbItemsAjustado(NUINSERTINDEX).OUT_ = GE_BOCONSTANTS.CSBYES
                            AND BLGENERATEAIU
                        THEN
                            NUADMINAIUORDER := NVL(NUADMINAIUORDER, 0) + NVL(NUADMINAIUVALUE, 0);
                        END IF;

                        oTbItemsAjustado(NUINSERTINDEX).VALUE := oTbItemsAjustado(NUINSERTINDEX).VALUE + NVL(NUOPERAIUVALUE, 0);
                        oTbItemsAjustado(NUINSERTINDEX).TOTAL_PRICE := NVL(NUADMINAIUVALUE, 0) + NVL(oTbItemsAjustado(NUINSERTINDEX).VALUE, 0);
                    ELSIF NULIQMETHOD = OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE THEN
                        oTbItemsAjustado(NUINSERTINDEX).VALUE := oTbItemsAjustado(NUINSERTINDEX).VALUE + NVL(NUOPERAIUVALUE, 0);
                        oTbItemsAjustado(NUINSERTINDEX).TOTAL_PRICE := OR_BOITEMVALUE.FNUGETITEMPRICE
                                                                (
                                                                    oTbItemsAjustado(NUINSERTINDEX).ITEMS_ID,
                                                                    regOrdenbase.OPERATING_UNIT_ID,
                                                                    regOrdenbase.EXTERNAL_ADDRESS_ID,
                                                                    regOrdenbase.TASK_TYPE_ID
                                                                );
                    ELSIF NULIQMETHOD = OR_BOCONSTANTS.CNUMETODO_FIXED_PRICE THEN
                        oTbItemsAjustado(NUINSERTINDEX).VALUE := oTbItemsAjustado(NUINSERTINDEX).VALUE + NVL(NUOPERAIUVALUE, 0);
                        oTbItemsAjustado(NUINSERTINDEX).TOTAL_PRICE := 0;
                    ELSE
                        oTbItemsAjustado(NUINSERTINDEX).VALUE := oTbItemsAjustado(NUINSERTINDEX).VALUE + NVL(NUOPERAIUVALUE, 0);
                        oTbItemsAjustado(NUINSERTINDEX).TOTAL_PRICE := 0;
                    END IF;
                END IF;

                OR_BOITEMVALUE.GTBADJUSTDATE := NULL;

            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    oTbItemsAjustado(NUINSERTINDEX).VALUE := 0;
                    oTbItemsAjustado(NUINSERTINDEX).TOTAL_PRICE := 0;
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    RAISE EX.CONTROLLED_ERROR;
            END proGetLiquiItems;
        BEGIN

            CT_BOCONTRACT.GETCONTRACTTOLIQORDER(inuOrdeBase, nuContratista, nuContrato);

            OPEN    OR_BCORDERACTIVITIES.CUGETACTIVITYPACKAGE(regOrdenbase.ORDER_ID);
            FETCH   OR_BCORDERACTIVITIES.CUGETACTIVITYPACKAGE INTO nuSolicitud;
            CLOSE   OR_BCORDERACTIVITIES.CUGETACTIVITYPACKAGE;

            IF(nuSolicitud IS NOT NULL) THEN
                regCotizacion := CC_BCQUOTATION.FRCGETVALIDQUOTBYPACK(nuSolicitud);
            END IF;

            NUINDEX := iTbItemAjustar.FIRST;
            LOOP
                EXIT WHEN NUINDEX IS NULL;

                NUINSERTINDEX := NUINSERTINDEX + 1;
                oTbItemsAjustado(NUINSERTINDEX).ORDER_ITEMS_ID := iTbItemAjustar(NUINDEX).ORDER_ITEMS_ID;
                NUITEMSID := iTbItemAjustar(NUINDEX).ITEMS_ID;
                oTbItemsAjustado(NUINSERTINDEX).ITEMS_ID := NUITEMSID;
                NULEGALITEMAMOUNT := iTbItemAjustar(NUINDEX).LEGAL_ITEM_AMOUNT;

                IF (NULEGALITEMAMOUNT > 0) THEN
                    oTbItemsAjustado(NUINSERTINDEX).OUT_ := GE_BOCONSTANTS.CSBYES;
                    proGetLiquiItems;
                ELSE

                    NULEGALITEMAMOUNT := -1 * NULEGALITEMAMOUNT;
                    oTbItemsAjustado(NUINSERTINDEX).OUT_ := GE_BOCONSTANTS.CSBNO;
                    proGetLiquiItems;
                END IF;

                proProcInventario;

                oTbItemsAjustado(NUINSERTINDEX).ASSIGNED_ITEM_AMOUNT := NULEGALITEMAMOUNT;
                oTbItemsAjustado(NUINSERTINDEX).LEGAL_ITEM_AMOUNT := NULEGALITEMAMOUNT;

                NUSERIALITEMSID := iTbItemAjustar(NUINDEX).SERIAL_ITEMS_ID;
                oTbItemsAjustado(NUINSERTINDEX).SERIAL_ITEMS_ID := NUSERIALITEMSID;
                IF (NUSERIALITEMSID IS NOT NULL) THEN
                    oTbItemsAjustado(NUINSERTINDEX).SERIE := DAGE_ITEMS_SERIADO.FSBGETSERIE(NUSERIALITEMSID);
                END IF;

                NUINDEX := iTbItemAjustar.NEXT(NUINDEX);
            END LOOP;

            DAOR_ORDER.UPDOPERATIVE_AIU_VALUE(inuOrdeBase, NUOPERAIUORDER);
            DAOR_ORDER.UPDADMIN_AIU_VALUE(inuOrdeBase, NUADMINAIUORDER);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                ERRORS.GETERROR(NUERRORCODE,
                                SBERRORMESSAGE);


                ERRORS.SETERROR(8662,
                                inuOrdeBase||'|'||SBERRORMESSAGE);
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END proProcItemsOrden;


  BEGIN

  UT_TRACE.TRACE('Inicio procGetPrecioCostOrden Orden Base: ' || inuOrdeBase, 6);

        proValidaDatos; -- se validan datos de los ajustes

        regOrdenbase := DAOR_ORDER.FRCGETRECORD(inuOrdeBase);
        regTipoTrab := DAOR_TASK_TYPE.FRCGETRECORD(regOrdenbase.TASK_TYPE_ID);

        BLGENERATEAIU := OR_BOCONCEPTVALUE.FBOCONCEPTWITHADMAIU( regTipoTrab.CONCEPT );

        proProcItemsOrden; --se procesan items ajsutar

        proGetActividadBase; -- se obtiene actividad base

        UT_TRACE.TRACE('Actividad Base: '||NUSELECTEDACTIVITY, 7);

        IF (NUSELECTEDACTIVITY IS NOT NULL) THEN
            DAOR_ORDER_ACTIVITY.GETRECORD(NUSELECTEDACTIVITY,
                                          RCSELECTEDACTIVITY);
        END IF;
		UT_TRACE.TRACE('Items ajustado: '||oTbItemsAjustado.count, 7);
        NUORDERITEMSINDEX := oTbItemsAjustado.FIRST;
        LOOP
            EXIT WHEN NUORDERITEMSINDEX IS NULL;
			--2391 se consulta si la clasifiacion del items es deferente a 3,21,8
			SELECT COUNT(1) INTO nuIsMate
			FROM ge_items id
			WHERE id.items_id = oTbItemsAjustado(NUORDERITEMSINDEX).ITEMS_ID
			 AND 	id.item_classif_id not in  ( SELECT to_number(COLUMN_VALUE)
			                                      FROM TABLE(ldc_boutilities.splitstrings(sbClasifItem, ',') ));

			UT_TRACE.TRACE('material: '||nuIsMate, 7);
			IF nuIsMate > 0 THEN
				IF (oTbItemsAjustado(NUORDERITEMSINDEX).OUT_ = GE_BOCONSTANTS.CSBNO) THEN
					NUVALORNOLIQUIDADO :=  NUVALORNOLIQUIDADO - oTbItemsAjustado(NUORDERITEMSINDEX).VALUE;
				ELSE
					NUVALORNOLIQUIDADO :=  NUVALORNOLIQUIDADO + oTbItemsAjustado(NUORDERITEMSINDEX).VALUE;
				END IF;
			END IF;
			UT_TRACE.TRACE(' items : '||oTbItemsAjustado(NUORDERITEMSINDEX).ITEMS_ID, 7);
            NUORDERITEMSINDEX := oTbItemsAjustado.NEXT(NUORDERITEMSINDEX);
			UT_TRACE.TRACE(' items : '||NUORDERITEMSINDEX, 7);
        END LOOP;
	UT_TRACE.TRACE(' contrato : '||regOrdenbase.DEFINED_CONTRACT_ID, 7);
       UT_TRACE.TRACE(' valor no liquidado : '|| NVL(NUVALORNOLIQUIDADO,0), 7);
        IF (regOrdenbase.DEFINED_CONTRACT_ID IS NOT NULL AND NVL(NUVALORNOLIQUIDADO,0) <> 0 ) THEN
			UT_TRACE.TRACE(' valor no liquidado : '|| DAGE_CONTRATO.FNUGETVALOR_NO_LIQUIDADO(regOrdenbase.DEFINED_CONTRACT_ID), 7);
            NUVALORNOLIQUIDADO := NUVALORNOLIQUIDADO + NVL(DAGE_CONTRATO.FNUGETVALOR_NO_LIQUIDADO(regOrdenbase.DEFINED_CONTRACT_ID),0);
			UT_TRACE.TRACE(' actualizar valor no liquidado : '||NUVALORNOLIQUIDADO, 7);
            DAGE_CONTRATO.UPDVALOR_NO_LIQUIDADO(regOrdenbase.DEFINED_CONTRACT_ID,NUVALORNOLIQUIDADO);
			UT_TRACE.TRACE(' salio de actualizar valor no liquidado : '||NUVALORNOLIQUIDADO, 7);
        END IF;
        onuOk := 0;
     UT_TRACE.TRACE('Fin procGetPrecioCostOrden Orden Base: ' || inuOrdeBase, 6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             eRRORS.GETERROR(ONUOK, OSBERROR);
			 UT_TRACE.TRACE('Fin procGetPrecioCostOrden error: ' || OSBERROR, 6);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            onuOk := -1;
			 UT_TRACE.TRACE('Fin procGetPrecioCostOrden error: ' || sqlerrm, 6);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
   END procGetPrecioCostOrden;
End LDC_PRAJUSORDESINACTA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PRAJUSORDESINACTA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRAJUSORDESINACTA', 'ADM_PERSON'); 
END;
/  
