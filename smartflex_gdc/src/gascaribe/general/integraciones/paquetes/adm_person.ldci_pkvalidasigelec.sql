CREATE OR REPLACE Package ADM_PERSON.LDCI_PKVALIDASIGELEC As



  Procedure provalidaorden(nutransac              In ldci_orden.transac_id%Type,
                           nuorder_id             In ldci_orden.order_id%Type,
                           nutask_type_id         In ldci_orden.task_type_id%Type,
                           nuorder_status_id      In ldci_orden.address_id%Type,
                           nuaddress_id           In ldci_orden.address_id%Type,
                           sbaddress              In ldci_orden.address%Type,
                           nugeogra_location_id   In ldci_orden.geogra_location_id%Type,
                           nuneighborthood        In ldci_orden.neighborthood%Type,
                           nuoper_sector_id       In ldci_orden.oper_sector_id%Type,
                           nuroute_id             In Out ldci_orden.route_id%Type,
                           nuconsecutive          In ldci_orden.consecutive%Type,
                           nupriority             In ldci_orden.priority%Type,
                           dtassigned_date        In ldci_orden.assigned_date%Type,
                           dtarrange_hour         In ldci_orden.arrange_hour%Type,
                           dtcreated_date         In ldci_orden.created_date%Type,
                           dtexec_estimate_date   In ldci_orden.exec_estimate_date%Type,
                           dtmax_date_to_legalize In ldci_orden.max_date_to_legalize%Type,
                           nuresult               Out Number);

  Procedure provalidaactividad(nuorder_id          In ldci_orden.order_id%Type,
                               nuorder_activity_id In ldci_actividadorden.order_activity_id%Type,
                               nuconsecutive       In ldci_actividadorden.consecutive%Type,
                               nuactivity_id       In ldci_actividadorden.activity_id%Type,
                               nuaddress_id        In ldci_actividadorden.address_id%Type,
                               sbaddress           In ldci_actividadorden.address%Type,
                               sbsubscriber_name   In ldci_actividadorden.subscriber_name%Type,
                               nuproduct_id        In ldci_actividadorden.product_id%Type,
                               sbservice_number    In ldci_actividadorden.service_number%Type,
                               sbmeter             In ldci_actividadorden.meter%Type,
                               nuproduct_status_id In ldci_actividadorden.product_status_id%Type,
                               nusubscription_id   In ldci_actividadorden.subscription_id%Type,
                               nucategory_id       In ldci_actividadorden.category_id%Type,
                               nusubcategory_id    In ldci_actividadorden.subcategory_id%Type,
                               nucons_cycle_id     In ldci_actividadorden.cons_cycle_id%Type,
                               nucons_period_id    In ldci_actividadorden.cons_period_id%Type,
                               nubill_cycle_id     In ldci_actividadorden.bill_cycle_id%Type,
                               nubill_period_id    In ldci_actividadorden.bill_period_id%Type,
                               nuparent_product_id In ldci_actividadorden.parent_product_id%Type,
                               sbparent_address_id In ldci_actividadorden.parent_address_id%Type,
                               sbparent_address    In ldci_actividadorden.parent_address%Type,
                               sbcausal            In ldci_actividadorden.causal%Type,
                               nucons_type_id      In ldci_actividadorden.cons_type_id%Type,
                               numeter_location    In ldci_actividadorden.meter_location%Type,
                               nudigit_quantity    In ldci_actividadorden.digit_quantity%Type,
                               nulimit             In ldci_actividadorden.limit%Type,
                               sbretry             In ldci_actividadorden.retry%Type,
                               nuaverage           In ldci_actividadorden.average%Type,
                               nulast_read         In ldci_actividadorden.last_read%Type,
                               dtlast_read_date    In ldci_actividadorden.last_read_date%Type,
                               nuobservation_a     In ldci_actividadorden.observation_a%Type,
                               nuobservation_b     In ldci_actividadorden.observation_b%Type,
                               nuobservation_c     In ldci_actividadorden.observation_c%Type,
                               nutransac           In ldci_orden.transac_id%Type,
                               nuresult            Out Number);

  Function fsbverificausucastigado(nuorder_id In ldci_orden.order_id%Type)
    Return Varchar;

  Function fblanularorden(nuorden In or_order.order_id%Type) Return Boolean;

 Procedure provalidaordenLect(nuorder_id             In ldci_orden.order_id%Type,
                           nutask_type_id         In ldci_orden.task_type_id%Type,
                           nuorder_status_id      In ldci_orden.address_id%Type,
                           nuaddress_id           In ldci_orden.address_id%Type,
                           sbaddress              In ldci_orden.address%Type,
                           nugeogra_location_id   In ldci_orden.geogra_location_id%Type,
                           nuneighborthood        In ldci_orden.neighborthood%Type,
                           nuoper_sector_id       In ldci_orden.oper_sector_id%Type,
                           nuroute_id             In Out ldci_orden.route_id%Type,
                           nuconsecutive          In ldci_orden.consecutive%Type,
                           nupriority             In ldci_orden.priority%Type,
                           dtassigned_date        In ldci_orden.assigned_date%Type,
                           dtarrange_hour         In ldci_orden.arrange_hour%Type,
                           dtcreated_date         In ldci_orden.created_date%Type,
                           dtexec_estimate_date   In ldci_orden.exec_estimate_date%Type,
                           dtmax_date_to_legalize In ldci_orden.max_date_to_legalize%Type,
                           nuresult               Out Number);


End LDCI_PKVALIDASIGELEC;
/
CREATE OR REPLACE Package Body ADM_PERSON.LDCI_PKVALIDASIGELEC As

  Function fsbaplicaentrega(isbentrega Varchar2) Return Varchar2 Is
    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del Objeto: fsbAplicaEntrega
    Descripcion:       Indica si la entrega aplica para la gasera
    Autor:             Pedro Castro Mora
    Fecha:             03-12-2015

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    ------------------------------
    15-01-2017    F.Castro              PC_200-988 Se agrega provalidaordenLect para habilitar
                                        la funcionalidad que tenia PBPIO en el nuevo esquema de
                                        envio al sistema movil de ordenes de lectura a traves de
                                        LDCI_PKGESTNOTIORDEN
    ******************************************************************/
    blgdo      Boolean := ldc_configuracionrq.aplicaparagdo(isbentrega);
    blefigas   Boolean := ldc_configuracionrq.aplicaparaefigas(isbentrega);
    blsurtigas Boolean := ldc_configuracionrq.aplicaparasurtigas(isbentrega);
    blgdc      Boolean := ldc_configuracionrq.aplicaparagdc(isbentrega);

  Begin

    If blgdo = True Or blefigas = True Or blsurtigas = True Or blgdc = True Then
      Return 'S';
    End If;

    Return 'N';

  End;

  Function fsbverificausucastigado(nuorder_id In ldci_orden.order_id%Type)
    Return Varchar Is
    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del Objeto: fsbVerificausucastigado
    Descripcion:       Verifica a partir de una orden si un producto se
                       encuentra o no en estado castigado
    Autor:             Pedro Castro Mora
    Fecha:             03-12-2015

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    ------------------------------
    ******************************************************************/

    punished_status_product Number := 0;
    is_anulable             Number := 0;

  Begin

    If fsbaplicaentrega('ENTREGACASTIGADOS') = 'N' Then
      Return 'N';
    End If;

    -- SE VERIFICA SI EL PERIODO DE CONSUMO ESTA CONFIGURADO PARA ANULAR ORDENES GENERADAS POR CRITICAS
    Select nvl(Count(1), 0)
      Into is_anulable
      From pericose, conf_pericons
     Where pecscons = periodo_consumo
       And pecscico =
           (Select sesucico
              From or_order_activity oa, or_order o, servsusc s, pericose p
             Where o.order_id = oa.order_id
               And o.order_id = nuorder_id
               And s.sesunuse = oa.product_id
               And rownum = 1)
       And trunc(Sysdate) Between trunc(pecsfeci) And trunc(pecsfecf)
       And anul_ord_cast = 'Y';

    If is_anulable > 0 Then

      Select /*+ RULE */
       Count(1)
        Into punished_status_product
        From or_order_activity oa, or_order o, servsusc s
       Where o.task_type_id In
             (Select column_value
                From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TITR_ORDEN_LECTUR'),
                                                        ','))) -- Tipo de trabajo 12617
         And o.order_status_id In
             (or_boconstants.cnuorder_stat_registered,
              or_boconstants.cnuorder_stat_assigned)
         And o.order_id = oa.order_id
         And o.order_id = nuorder_id
         And s.sesunuse = oa.product_id
         And s.sesuesfn = pkbillconst.csbest_castigado;

      If punished_status_product > 0 Then
        Return 'S';
      Else
        Return 'N';
      End If;

    End If;

  Exception
    When Others Then
      Return 'N';
  End;

  Procedure provalidaorden(nutransac              In ldci_orden.transac_id%Type,
                           nuorder_id             In ldci_orden.order_id%Type,
                           nutask_type_id         In ldci_orden.task_type_id%Type,
                           nuorder_status_id      In ldci_orden.address_id%Type,
                           nuaddress_id           In ldci_orden.address_id%Type,
                           sbaddress              In ldci_orden.address%Type,
                           nugeogra_location_id   In ldci_orden.geogra_location_id%Type,
                           nuneighborthood        In ldci_orden.neighborthood%Type,
                           nuoper_sector_id       In ldci_orden.oper_sector_id%Type,
                           nuroute_id             In Out ldci_orden.route_id%Type,
                           nuconsecutive          In ldci_orden.consecutive%Type,
                           nupriority             In ldci_orden.priority%Type,
                           dtassigned_date        In ldci_orden.assigned_date%Type,
                           dtarrange_hour         In ldci_orden.arrange_hour%Type,
                           dtcreated_date         In ldci_orden.created_date%Type,
                           dtexec_estimate_date   In ldci_orden.exec_estimate_date%Type,
                           dtmax_date_to_legalize In ldci_orden.max_date_to_legalize%Type,
                           nuresult               Out Number) As
    onuerrorcode Number := 0;
    osberrormsg  Varchar2(2000);
    onumesacodi  ldci_mesaproc.mesacodi%Type;

    nuorden ldci_orden.order_id%Type;

  Begin
    nuresult := 0;
    /*
      VALIDAR LA ORDEN
    */
    If nuorder_id Is Null Then
      onuerrorcode := -1;
      /*osberrormsg  := 'El numero de la orden esta nula. ';
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nuaddress_id Is Null Then
      onuerrorcode := -1;
      /*osberrormsg  := 'El identificador de la direccion esta nulo, correspondiente a la orden: ' ||
                      nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nuroute_id Is Null Then
      nuroute_id := 1;
      /*Onuerrorcode := -1;
      Osberrormsg:= 'El identificador de la ruta esta nula, correspondiente a la orden: ' || Nuorder_Id;
      LDCI_PKMESAWS.proCreaMensProc(nuTransac, Osberrormsg, 'E', CURRENT_DATE, onuMESACODI,  Onuerrorcode ,Osberrormsg);*/
    End If;

    If nuneighborthood Is Null Then
      onuerrorcode := -1;
      /*osberrormsg  := 'El identificador del barrio esta nulo, correspondiente a la orden: ' ||
                      nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If onuerrorcode != 0 Then
      /*nuresult := 1;*/ nuresult := 0;  -- para que de todas maneras inserte en LDCI_ORDENMOVILES
    Else
      nuresult := 0;
    End If;


  -- Se pasa la validacion a provalidaordenlect
  /*If fblanularorden(nuorden => nuorder_id) Then
      or_boanullorder.anullorderwithoutval(nuorder_id);
      nuresult := 1;
   End If;*/


  Exception
    When Others Then
      nuresult := 0;
      /*ldci_pkmesaws.procreamensproc(nutransac,
                                    'ERROR: ' || Sqlerrm || '. ' ||
                                    dbms_utility.format_error_backtrace,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
  End provalidaorden;

  Procedure provalidaactividad(nuorder_id          In ldci_orden.order_id%Type,
                               nuorder_activity_id In ldci_actividadorden.order_activity_id%Type,
                               nuconsecutive       In ldci_actividadorden.consecutive%Type,
                               nuactivity_id       In ldci_actividadorden.activity_id%Type,
                               nuaddress_id        In ldci_actividadorden.address_id%Type,
                               sbaddress           In ldci_actividadorden.address%Type,
                               sbsubscriber_name   In ldci_actividadorden.subscriber_name%Type,
                               nuproduct_id        In ldci_actividadorden.product_id%Type,
                               sbservice_number    In ldci_actividadorden.service_number%Type,
                               sbmeter             In ldci_actividadorden.meter%Type,
                               nuproduct_status_id In ldci_actividadorden.product_status_id%Type,
                               nusubscription_id   In ldci_actividadorden.subscription_id%Type,
                               nucategory_id       In ldci_actividadorden.category_id%Type,
                               nusubcategory_id    In ldci_actividadorden.subcategory_id%Type,
                               nucons_cycle_id     In ldci_actividadorden.cons_cycle_id%Type,
                               nucons_period_id    In ldci_actividadorden.cons_period_id%Type,
                               nubill_cycle_id     In ldci_actividadorden.bill_cycle_id%Type,
                               nubill_period_id    In ldci_actividadorden.bill_period_id%Type,
                               nuparent_product_id In ldci_actividadorden.parent_product_id%Type,
                               sbparent_address_id In ldci_actividadorden.parent_address_id%Type,
                               sbparent_address    In ldci_actividadorden.parent_address%Type,
                               sbcausal            In ldci_actividadorden.causal%Type,
                               nucons_type_id      In ldci_actividadorden.cons_type_id%Type,
                               numeter_location    In ldci_actividadorden.meter_location%Type,
                               nudigit_quantity    In ldci_actividadorden.digit_quantity%Type,
                               nulimit             In ldci_actividadorden.limit%Type,
                               sbretry             In ldci_actividadorden.retry%Type,
                               nuaverage           In ldci_actividadorden.average%Type,
                               nulast_read         In ldci_actividadorden.last_read%Type,
                               dtlast_read_date    In ldci_actividadorden.last_read_date%Type,
                               nuobservation_a     In ldci_actividadorden.observation_a%Type,
                               nuobservation_b     In ldci_actividadorden.observation_b%Type,
                               nuobservation_c     In ldci_actividadorden.observation_c%Type,
                               nutransac           In ldci_orden.transac_id%Type,
                               nuresult            Out Number) As
    onuerrorcode Number := 0;
    osberrormsg  Varchar2(2000);
    onumesacodi  ldci_mesaproc.mesacodi%Type;

  Begin
    /*

      Medidor
      Id ciclo de consumo Nucons_Cycle_Id
      Digitos de medidor Nudigit_Quantity
      Consumo promedio Nuaverage
      Lectura anterior Nulast_Read
      Fecha de ultima lectura Dtlast_Read_Date
      Id periodo de facturacion Nucons_Period_Id
      Mes de facturacion
      A?o de facturacion
    */

    /*
    VALIDAR CAMPOS REQUERIDOS
    */

    If nuorder_activity_id Is Null Then
      /*Nuorder_Activity_Id := 1;*/
      onuerrorcode := -1;
      /*osberrormsg  := 'El numero de la actividad orden esta nula. ';
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If sbmeter Is Null Then
      /*Sbmeter := '123';*/
      onuerrorcode := -1;
      /*osberrormsg  := 'El numero del medidor esta nulo, correspondiente a la orden ' ||  nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nucons_cycle_id Is Null Then
      onuerrorcode := -1;
      /*osberrormsg  := 'El identificador del ciclo de consumo esta nulo, correspondiente a la orden ' ||
                      nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nudigit_quantity Is Null Then
      onuerrorcode := -1;
      /*osberrormsg  := 'La cantidad de digitos del medidor esta nulo, correspondiente a la orden ' ||
                      nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nuaverage Is Null Then
      /*Nuaverage := 1.5;*/
      --Onuerrorcode := -1;
      onuerrorcode := 0;
      /*osberrormsg  := 'El consumo promedio esta nulo, correspondiente a la orden ' ||  nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'I',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nulast_read Is Null Then
      /*Nulast_Read := 20;*/
      onuerrorcode := -1;
      /*osberrormsg  := 'El valor de la ultima lectura esta nula, correspondiente a la orden ' ||  nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If nucons_period_id Is Null Then
      onuerrorcode := -1;
      /*osberrormsg  := 'Identificador del periodo de facturacion esta nulo, correspondiente a la orden ' ||  nuorder_id;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    osberrormsg,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
    End If;

    If onuerrorcode != 0 Then
      /*nuresult := 1;*/ nuresult := 0;  -- para que de todas maneras inserte en LDCI_ORDENMOVILES
    Else
      nuresult := 0;
    End If;

  Exception
    When Others Then
     nuresult := 0;
      /*nuresult := 1;
      ldci_pkmesaws.procreamensproc(nutransac,
                                    'ERROR: ' || Sqlerrm || '. ' ||
                                    dbms_utility.format_error_backtrace,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
  End provalidaactividad;

  Function fblanularorden(nuorden In or_order.order_id%Type) Return Boolean Is
    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas

    Nombre del Objeto: fblAnularOrden
    Descripcion:       Verifica a partir del estado de corte del producto asociado a la orden,
                       si esta debe anularse.
    Autor:             Ludycom S.A.
    Fecha:             27-07-2016

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    ------------------------------
    ******************************************************************/

    nutipo_trab_anul        Number := 0;
    nuestado_corte_anulable Number := 0;
    rcservsusc              servsusc%Rowtype;

    Cursor cuobtieneproducto Is
      Select s.*
        From or_order_activity oa, or_order o, servsusc s
       Where o.order_id = oa.order_id
         And o.order_id = nuorden
         And s.sesunuse = oa.product_id
         And rownum = 1;

  Begin

    If Not fblaplicaentrega('BSS_FAC_CBB_200109_1') Then
      Return False;
    End If;

    Open cuobtieneproducto;
    Fetch cuobtieneproducto
      Into rcservsusc;
    Close cuobtieneproducto;

    Select Count(1)
      Into nuestado_corte_anulable
      From pericose, conf_pericons
     Where pecscons = periodo_consumo
       And pecscico = (rcservsusc.sesucico)
       And trunc(Sysdate) Between trunc(pecsfeci) And trunc(pecsfecf)
       And estado_corte = rcservsusc.sesuesco
       And anul_ord_cast = 'Y';

    If nuestado_corte_anulable > 0 Then

      Select /*+ RULE */
       Count(1)
        Into nutipo_trab_anul
        From or_order o
       Where o.task_type_id In
             (Select column_value
                From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TITR_ORDEN_LECTUR'),
                                                        ',')))
         And o.order_status_id In
             (or_boconstants.cnuorder_stat_registered,
              or_boconstants.cnuorder_stat_assigned)
         And o.order_id = nuorden;

      If nutipo_trab_anul > 0 Then
        Return True;
      Else
        Return False;
      End If;

    Else
      Return False;

    End If;

  Exception
    When Others Then
      Raise;
  End;

---------------------------------------------------------------
Procedure provalidaordenLect(nuorder_id             In ldci_orden.order_id%Type,
                           nutask_type_id         In ldci_orden.task_type_id%Type,
                           nuorder_status_id      In ldci_orden.address_id%Type,
                           nuaddress_id           In ldci_orden.address_id%Type,
                           sbaddress              In ldci_orden.address%Type,
                           nugeogra_location_id   In ldci_orden.geogra_location_id%Type,
                           nuneighborthood        In ldci_orden.neighborthood%Type,
                           nuoper_sector_id       In ldci_orden.oper_sector_id%Type,
                           nuroute_id             In Out ldci_orden.route_id%Type,
                           nuconsecutive          In ldci_orden.consecutive%Type,
                           nupriority             In ldci_orden.priority%Type,
                           dtassigned_date        In ldci_orden.assigned_date%Type,
                           dtarrange_hour         In ldci_orden.arrange_hour%Type,
                           dtcreated_date         In ldci_orden.created_date%Type,
                           dtexec_estimate_date   In ldci_orden.exec_estimate_date%Type,
                           dtmax_date_to_legalize In ldci_orden.max_date_to_legalize%Type,
                           nuresult               Out Number) As

    onuerrorcode Number := 0;
    osberrormsg  Varchar2(2000);
    nuTransac       number    :=0;
    isbParametros   VARCHAR2(2000);

    onumesacodi  ldci_mesaproc.mesacodi%Type;


     TYPE refRegistros is REF CURSOR ;
      Resultado Number(18) := -1;
      Msj Varchar2(200) := '';
      Recregistros Refregistros;
      reg LDCI_ACTIVIDADORDEN%Rowtype;


      Nuorder_Activity_Id Ldci_Actividadorden.Order_Activity_Id%Type;
      Nuconsecutive_Ac       Ldci_Actividadorden.Consecutive%Type;
      Nuactivity_Id       Ldci_Actividadorden.Activity_Id%Type;
      Nuaddress_Id_Ac        Ldci_Actividadorden.Address_Id%Type;
      Sbaddress_Ac           Ldci_Actividadorden.Address%Type;
      Sbsubscriber_Name   Ldci_Actividadorden.Subscriber_Name%Type;
      Nuproduct_Id        Ldci_Actividadorden.Product_Id%Type;
      Sbservice_Number    Ldci_Actividadorden.Service_Number%Type;
      Sbmeter             Ldci_Actividadorden.Meter%Type;
      Nuproduct_Status_Id Ldci_Actividadorden.Product_Status_Id%Type;
      Nusubscription_Id   Ldci_Actividadorden.Subscription_Id%Type;
      Nucategory_Id       Ldci_Actividadorden.Category_Id%Type;
      Nusubcategory_Id    Ldci_Actividadorden.Subcategory_Id%Type;
      Nucons_Cycle_Id     Ldci_Actividadorden.Cons_Cycle_Id%Type;
      Nucons_Period_Id    Ldci_Actividadorden.Cons_Period_Id%Type;
      Nubill_Cycle_Id     Ldci_Actividadorden.Bill_Cycle_Id%Type;
      Nubill_Period_Id    Ldci_Actividadorden.Bill_Period_Id%Type;
      Nuparent_Product_Id Ldci_Actividadorden.Parent_Product_Id%Type;
      Sbparent_Address_Id Ldci_Actividadorden.Parent_Address_Id%Type;
      Sbparent_Address    Ldci_Actividadorden.Parent_Address%Type;
      Sbcausal            Ldci_Actividadorden.Causal%Type;
      Nucons_Type_Id      Ldci_Actividadorden.Cons_Type_Id%Type;
      Numeter_Location    Ldci_Actividadorden.Meter_Location%Type;
      Nudigit_Quantity    Ldci_Actividadorden.Digit_Quantity%Type;
      Nulimit             Ldci_Actividadorden.Limit%Type;
      Sbretry             Ldci_Actividadorden.Retry%Type;
      Nuaverage           Ldci_Actividadorden.Average%Type;
      Nulast_Read         Ldci_Actividadorden.Last_Read%Type;
      Dtlast_Read_Date    Ldci_Actividadorden.Last_Read_Date%Type;
      Nuobservation_A     Ldci_Actividadorden.Observation_A%Type;
      Nuobservation_B     Ldci_Actividadorden.Observation_B%Type;
      NUObservation_C     Ldci_Actividadorden.Observation_C%TYPE;

      nuValActividad      number(1);
      nuMesacodi LDCI_MESAPROC.MESACODI%TYPE;
      cantAtcs            number;

  Begin
   /* CREAR TRANSACCION SI ES LA PRIMERA ORDEN DE LECTURA EN ESTA EJECUCION*/
  /*if nvl(LDCI_PKGESTNOTIORDEN.sbCrTransSigelec,'S') = 'S' then
    LDCI_PKGESTNOTIORDEN.sbCrTransSigelec := 'N';
    isbParametros := '<Parametros>
                        <parametro>
                            <nombre>OperatingUnitId</nombre>
                            <valor>' || '-1' || '</valor>
                        </parametro>
                        <parametro>
                            <nombre>GeograLocationId</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>ConsCycleId</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>operatingsectorid</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>RouteId</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>initialdate</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>finaldata</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>tasktypeid</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                        <parametro>
                            <nombre>OrderStatusId</nombre>
                            <valor>' || '-1' ||'</valor>
                        </parametro>
                    </Parametros>
                    ';

    LDCI_PKMESAWS.proCreaEstaProc('WS_ENVIO_ORDENES',
																									isbParametros,
																									CURRENT_DATE,
																									'P',
																									sys_context('USERENV', 'CURRENT_USER'),
																									null,
																									null,
																									nuTransac,
																									Onuerrorcode,
																									Osberrormsg);
    if Onuerrorcode != 0 then
      \* NO CREO EL PROCESO *\
       GI_BOERRORS.SETERRORCODEARGUMENT(2741, Osberrormsg);   -- ver como se maneja
       raise ex.CONTROLLED_ERROR;
    end if;
    LDCI_PKGESTNOTIORDEN.nuTransac := nuTransac;
  end if;*/

  nuResult := 0;

  IF LDCI_PKGESTNOTIORDEN.sbFgValOrdLec = 'S' then
    LDCI_PKVALIDASIGELEC.PROVALIDAORDEN(/*LDCI_PKGESTNOTIORDEN.nuTransac*/0, Nuorder_Id, Nutask_Type_Id, Nuorder_Status_Id, Nuaddress_Id,
                                        Sbaddress, Nugeogra_Location_Id, Nuneighborthood, Nuoper_Sector_Id, Nuroute_Id,
                                        Nuconsecutive, Nupriority, Dtassigned_Date, Dtarrange_Hour, Dtcreated_Date,
                                        Dtexec_Estimate_Date, dtMax_Date_To_Legalize,Onuerrorcode);
    IF Onuerrorcode = 0 THEN
      /* CARGAR ACTIVIDADES DE LA ORDEN */
      OS_GETORDERACTIVITIES(Nuorder_Id, Recregistros, Onuerrorcode, Msj);

       --evaluar el resultado antes de recorrer el cursor
      If Onuerrorcode = 0 Then
         Loop
         Fetch  Recregistros  Into Nuorder_Activity_Id, Nuconsecutive_Ac, Nuactivity_Id, Nuaddress_Id_Ac, Sbaddress_Ac,
                                  Sbsubscriber_Name, Nuproduct_Id, Sbservice_Number, Sbmeter, Nuproduct_Status_Id, Nusubscription_Id,
                                  Nucategory_Id, Nusubcategory_Id, Nucons_Cycle_Id, Nucons_Period_Id, Nubill_Cycle_Id, Nubill_Period_Id,
                                  Nuparent_Product_Id, Sbparent_Address_Id, Sbparent_Address, Sbcausal, Nucons_Type_Id, Numeter_Location,
                                  Nudigit_Quantity, Nulimit, Sbretry, Nuaverage, Nulast_Read, Dtlast_Read_Date,
                                  NUObservation_A, NUObservation_B, NUObservation_C;
          EXIT WHEN Recregistros%notfound;
          cantAtcs := cantAtcs + 1;

          LDCI_PKVALIDASIGELEC.PROVALIDAACTIVIDAD(Nuorder_Id,
										                              Nuorder_Activity_Id,
																									Nuconsecutive_Ac,
																									Nuactivity_Id,
																									Nuaddress_Id_Ac,
																									Sbaddress_Ac,
																									Sbsubscriber_Name,
																									Nuproduct_Id,
																						      Sbservice_Number,
																						      Sbmeter,
																						      Nuproduct_Status_Id,
																					        Nusubscription_Id,
																						      Nucategory_Id,
																			            Nusubcategory_Id,
																		              Nucons_Cycle_Id,
																		              Nucons_Period_Id,
																			            Nubill_Cycle_Id,
																		              Nubill_Period_Id,
																		              Nuparent_Product_Id,
																			            Sbparent_Address_Id,
																		              Sbparent_Address,
																		              Sbcausal,
																		              Nucons_Type_Id,
																		              Numeter_Location,
																			            Nudigit_Quantity,
																		              Nulimit,
																	                Sbretry,
																		              Nuaverage,
																	                Nulast_Read,
																				          Dtlast_Read_Date,
																                  Nuobservation_A,
																	                Nuobservation_B,
																			            NUObservation_C,
																			            /*LDCI_PKGESTNOTIORDEN.nuTransac*/0,
																	                Onuerrorcode );


          if Onuerrorcode != 0 THEN -- val con errores
             nuresult := 1 ;
             exit;
          end if;
       End Loop;
     else
     /*CREAR MENSAJE DE ERROR*/
      /*LDCI_PKMESAWS.proCreaMensProc(nuTransac, Msj, 'E', CURRENT_DATE, nuMesacodi,  Onuerrorcode ,Msj);
      nuResult := 1;*/
      null;
     end if;
     Close Recregistros;
   else
     nuResult := 1;
   end if;
 end if;


  IF nuresult = 0 then
     -- si el parametro de validar exclusion de ordenes es S se anula la orden si el producto esta dentro de los estados configurados
     IF LDCI_PKGESTNOTIORDEN.sbFgValExcLec = 'S' then
        If fblanularorden(nuorden => nuorder_id) Then
           or_boanullorder.anullorderwithoutval(nuorder_id);
           nuresult := 1;
        End If;
     END IF;
  END IF;

  Exception
    When Others Then
      nuresult := 0;
      /*ldci_pkmesaws.procreamensproc(nutransac,
                                    'ERROR: ' || Sqlerrm || '. ' ||
                                    dbms_utility.format_error_backtrace,
                                    'E',
                                    current_date,
                                    onumesacodi,
                                    onuerrorcode,
                                    osberrormsg);*/
  End provalidaordenLect;

End LDCI_PKVALIDASIGELEC;
/

PROMPT Asignación de permisos para el método
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKVALIDASIGELEC', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKVALIDASIGELEC to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKVALIDASIGELEC to INTEGRADESA;
/
