CREATE OR REPLACE PACKAGE adm_person.LD_BOQUERYFNB IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOQueryFNB
  Descripci?n    : -
  Autor          : -
  Fecha          : 13-08-2013

  Par?metros         Descripci?n
  ============   ===================

  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========    =========            ====================
  15/07/2024   PAcosta              OSF-2885: Cambio de esquema ADM_PERSON 
                                    Retiro marcacion esquema .open objetos de lógica
  23-08-2019   Cambio 72            Se modifica el metodo <<frfGetSaleFNBInfo>>
  23/07/2018    Sebastian Tapias    REQ.200-2004
                                    Se modifica el metodo <<getQuotaInfo>>
                                    Se modifica el metodo <<getExtraQuoteBySubs>>
  27/04/2017   KBaquero Caso 200-1075 se modifica el metodo <<getExtraQuoteById>>
  19-09-2015   KCienfuegos.ARA8021 Se modifica m?todo <<fsbInsuranceSale>>
  01-09-2015   KCienfuegos.ARA8021 Se crea m?todo <<fsbInsuranceSale>>
  20-01-2015   KCienfuegos.ARA5737 Se modifica m?todo <<frfGetSaleFNBInfo>>
  13-01-2015   KCienfuegos.RNP1224 Se crea m?todo <<fnugetInvoice>>
  06-01-2015   KCienfuegos.RNP2923 Se modifica <<fnuDatosLiq>>
  30-09-2014   KCienfuegos.RNP198  Se modifica <<getQuotaInfo>>
  04-12-2013   hjgomez.SAO225968   Se modifica <<fsbgetPolicy>>
  15-11-2013   hjgomez.SAO223412   Se modifica <frfGetSaleFNBInfo>
  04-09-2013   jaricapa.SAO214357  Se agregan ?ndices
  ******************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2;
  /* Subtipos */
  TYPE tyRefCursor IS REF CURSOR;
  /*Paquete con las funciones para las consultas del punto
  unico de atencion al cliente.*/
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbgetExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalacion.

  Autor          : eramos
  Fecha          : 08/10/2012

  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION ftbgetExtraQuoteBySubs(inuSubscription in suscripc.susccodi%type)
    return ld_extra_quota%rowtype;

  PROCEDURE getExtraQuoteBySubs(inuSubscription in suscripc.susccodi%type,
                                ocuExtraQuota   out constants.tyrefcursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getTransferQuota
  Descripcion    : Obtiene las transferencia de cupo de un contrato.

  Autor          : eramos
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getTransferQuota(inuSubscription  in suscripc.susccodi%type,
                             ocuTrasnferQuota out constants.tyrefcursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getTransferQuota
  Descripcion    : Obtiene las transferencia de cupo de un contrato.

  Autor          : eramos
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getTransferSubs(inuTransferQuota ld_quota_transfer.quota_transfer_id%type,
                            ocuTrasnferQuota out constants.tyrefcursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalaci?n.

  Autor          : AdoJim
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.
  ocuExtraQuota          Cursor con consulta de retorno.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getExtraQuoteById(inuExtraQuota in ld_extra_quota.extra_quota_id%type,
                              ocuExtraQuota out constants.tyrefcursor);

  FUNCTION fnugetCededValue(inusubscription in suscripc.susccodi%type)
    return number;

  FUNCTION fnugetReceivedValue(inusubscription in suscripc.susccodi%type)
    return number;

  FUNCTION fsbgetPolicy(inusubscription in suscripc.susccodi%type)
    return varchar2;

  PROCEDURE getQuotaInfo(inusubscription in suscripc.susccodi%type,
                         ocuQuotaInfo    out constants.tyrefcursor);
  /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnuDatosLiq
      Descripcion    : Indica los valores de liquidacion
      Autor          : Evelio Sanjuanelo
      Fecha          : 26/06/2013

      Parametros       Descripcion
      ============     ===================
    inupackage_id      paquete
    inuarticle         articulo
    inuopcion          1) ValCobComPro, --? COBRO COMISI?N A PROVEEDOR
                       2) ValComPagCon, --?  Valor de comisi?n pagada al contratista.
      Historia de Modificaciones
      Fecha                 Autor                   Modificacion
      =========             ===========             ====================
  ******************************************************************/

  FUNCTION fnuDatosLiq(inuOrderActivitySale in OR_order_activity.order_activity_id%type,
                       inuopcion            in number default 0)

   RETURN number;

  /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnuDatosEntr
      Descripcion    : Indica el diferido
      Autor          : Evelio Sanjuanelo
      Fecha          : 26/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id      paquete
      inuarticle         articulo
      inuopcion          0) comodin futuras consulta.
      Historia de Modificaciones
      Fecha                 Autor                   Modificacion
      =========             ===========             ====================
  ******************************************************************/

  FUNCTION fnuDatosEntr(inuOrderActivitySale in OR_order_activity.order_activity_id%type)

   RETURN number;

  /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnuDatosEntr
      Descripcion    : Indica el estado de la ot de entrega
      Autor          : Evelio Sanjuanelo
      Fecha          : 26/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id      paquete
      inuarticle         articulo
      inuopcion          0) comodin futuras consulta.
      Historia de Modificaciones
      Fecha                 Autor                   Modificacion
      =========             ===========             ====================
  ******************************************************************/

  FUNCTION fsbDatosEntr(inuOrderActivitySale in OR_order_activity.order_activity_id%type)

   RETURN varchar2;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetSaleFNBInfo
  Descripcion    : Obtiene la informacion de solicitud de venta

  Autor          : Daniel Valiente
  Fecha          : 19/10/2012

  Parametros              Descripcion
  ============         ===================
  inufindvalue:       Numero de la solicitud.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION frfGetSaleFNBInfo(inufindvalue in ld_non_ban_fi_item.NON_BA_FI_REQU_ID%type)
    RETURN tyRefCursor;

  FUNCTION FtrfPromissory(nuPackageId in ld_promissory.package_id%type,
                          --sbPromissoryType in ld_promissory.promissory_type%type),
                          sbPromissoryTypeDebtor   in ld_promissory.promissory_type%type,
                          sbPromissoryTypeCosigner in ld_promissory.promissory_type%type)
    RETURN constants.tyRefCursor;

  FUNCTION FtrfdATOSPromissory(nuPackageId              in ld_promissory.package_id%type,
                               sbPromissoryTypeDebtor   in ld_promissory.promissory_type%type,
                               sbPromissoryTypeCosigner in ld_promissory.promissory_type%type)

   RETURN constants.tyRefCursor;

  FUNCTION fnugetCededValToSubsc(inuSubscCeded  in suscripc.susccodi%type,
                                 inuQuotaTransf in ld_quota_transfer.quota_transfer_id%type)
    RETURN number;

  FUNCTION fsbGetDataCredResult(inuPackageId   in mo_packages.package_id%type,
                                idtRequestDate in ld_result_consult.consultation_date%type)
    RETURN varchar2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnugetInvoice
  Descripcion    : Obtiene la factura de la venta, para la orden de entrega.
  Autor          : KCienfuegos
  Fecha          : 13/01/2015

  Par?metros       Descripci?n
  ============     ===================
  inuOrder         C?digo de la orden.

  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========     ===========         ====================
  13-01-2015    KCienfuegos.RNP1224 Creaci?n.
  ******************************************************************/
  FUNCTION fnugetInvoice(inuOrderAct in OR_order_activity.Order_Activity_Id%type)
    RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbInsuranceSale
  Descripcion    : Valida si el contrato es v?lido para la venta de seguro.
  Autor          : KCienfuegos
  Fecha          : 01/09/2015

  Parametros       Descripcion
  ============     ===================
  inuSuscription   C?digo del contrato

  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========     ===========         ====================
  01-09-2015    KCienfuegos.RNP8021 Creaci?n.
  ******************************************************************/
  FUNCTION fsbInsuranceSale(inuSuscription in suscripc.susccodi%type)
    RETURN VARCHAR2;

END LD_BOQueryFNB;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BOQUERYFNB IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOQueryFNB
  Descripci?n    : -
  Autor          : -
  Fecha          : 13-08-2013

  Par?metros         Descripci?n
  ============   ===================

  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========    =========            ====================
  23-08-2019   Cambio 72            Se modifica el metodo <<frfGetSaleFNBInfo>>
  23/07/2018    Sebastian Tapias    REQ.200-2004
                                    Se modifica el metodo <<getQuotaInfo>>
                                    Se modifica el metodo <<getExtraQuoteBySubs>>
  19-09-2015  KCienfuegos.ARA8021 Se modifica m?todo <<fsbInsuranceSale>>
  01-09-2015  KCienfuegos.ARA8021 Se crea m?todo <<fsbInsuranceSale>>
  20-01-2015  KCienfuegos.ARA5737 Se modifica m?todo <<frfGetSaleFNBInfo>>
  13-01-2015  KCienfuegos.RNP1224 Se crea m?todo <<fnugetInvoice>>
  06-01-2015  KCienfuegos.RNP2923 Se modifica <<fnuDatosLiq>>
  30-09-2014  KCienfuegos.RNP198  Se modifica <<getQuotaInfo>>
  03-06-2014  aesguerra.3709      Se crea <<fsbGetDataCredResult>>
  04-12-2013  hjgomez.SAO225968   Se modifica <<fsbgetPolicy>>
  15-11-2013  hjgomez.SAO223412   Se modifica <frfGetSaleFNBInfo>
  04-09-2013  jaricapa.SAO214357  Se agregan ?ndices
  ******************************************************************/

  --Obtiene los tipos de producto brilla, brilla promigas
  cnuProdTypeBrilla     constant servicio.servcodi%type := DALD_Parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBR);
  cnuProdTypeBrillaProm constant servicio.servcodi%type := DALD_Parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBRP);
  --  Obtiene las actividades de venta y entrega
  cnuSellAct  constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');
  cnuDelivAct constant ld_parameter.numeric_value%type := DALD_Parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB');
  -- constantes Sentencias Aecheverry
  csbAnull          Constant ld_item_work_order.state%type := 'AN';
  cnuRegisterStatus Constant OR_order_status.order_status_id%type := 0;
  cnuAssignStatus   Constant OR_order_status.order_status_id%type := 5;
  cnuCloseStatus    Constant OR_order_status.order_status_id%type := 8;
  cnuMotiveStatus   Constant ps_motive_status.motive_status_id%type := 13;
  type tytbProcPackages IS table of varchar2(1) index BY varchar2(20);

  csbVERSION constant varchar2(20) := '3709';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbgetExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalacion.

  Autor          : eramos
  Fecha          : 08/10/2012

  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION ftbgetExtraQuoteBySubs(inuSubscription in suscripc.susccodi%type)
    return ld_extra_quota%rowtype IS

    stypr_product   dapr_product.stypr_product;
    nuGASProduct    number;
    styab_address   daab_address.styAB_address;
    sbParentsGeoLoc varchar2(200);
    sbSelect        varchar2(500);
    sbFrom          varchar2(500);
    sbWhere         varchar2(500);
    SbSQL           varchar2(500);
    cuCursor        constants.tyrefcursor;
    styCursorOut    ld_extra_quota%rowtype;

  BEGIN

    nuGASProduct  := ld_bononbankfinancing.fnugetGasProduct(inuSubscription => inuSubscription);
    stypr_product := dapr_product.frcgetrecord(inuProduct_Id => nuGASProduct);
    styab_address := daab_address.frcGetRecord(inuAddress_Id => stypr_product.ADDRESS_ID);

    if styab_address.NEIGHBORTHOOD_ID is not null then
      ge_bogeogra_location.getgeograpparents(inuChildGeoLocId => styab_address.NEIGHBORTHOOD_ID,
                                             isbText          => sbParentsGeoLoc);
    elsif styab_address.GEOGRAP_LOCATION_ID is not null then
      ge_bogeogra_location.getgeograpparents(inuChildGeoLocId => styab_address.GEOGRAP_LOCATION_ID,
                                             isbText          => sbParentsGeoLoc);
    else
      sbParentsGeoLoc := ' nvl( l.geograp_location_id, l.geograp_location_id) ';
    end if;

    sbSelect := 'select line_id,subline_id ,supplier_id ,sale_chanel_id,value,initial_date,final_date ';
    sbFrom   := 'from ld_extra_quota l ';
    sbWhere  := 'where l.category_id= ' ||
                to_char(stypr_product.category_id) ||
                ' and l.subcategory_id= ' ||
                to_char(stypr_product.subcategory_id) ||
                ' and l.geograp_location_id in (' || sbParentsGeoLoc ||
                ' ) ';
    SbSQL    := sbSelect || sbFrom || sbWhere;

    OPEN cuCursor FOR sbSql;
    FETCH cuCursor
      INTO styCursorOut;
    CLOSE cuCursor;
    /*execute inmediate*/
    return styCursorOut;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ftbgetExtraQuoteBySubs;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalaci?n.

  Autor          : AdoJim
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.
  ocuExtraQuota          Cursor con consulta de retorno.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/07/2018        Sebastian Tapias    REQ.200-2004 Se agrega nueva logica de obtencion de cupo extra.
  15/11/2017     Ronald Colpas      caso 200-1512 se valida para validar cupo disponible contra el valor
                                      configurado en el parametro CUPO_DISPONIBLE_EXTRACUPO
  27/04/2017     Karem Baquero      caso 200-1075 se valida que el suscriptor cumpla con pol?tica brilla.
                                        para asignarle cupo Extra
  01/07/2014      KatCien             se modifica la consulta para incluir la fecha
                                      actual en el rango de fechas de la vigencia del
                                      del extra cupo. NC247
  ******************************************************************/
  PROCEDURE getExtraQuoteBySubs(inuSubscription in suscripc.susccodi%type,
                                ocuExtraQuota   out constants.tyrefcursor) is

    nuGASProduct    number;
    rcab_address    daab_address.styAB_address;
    sbParentsGeoLoc varchar2(1000) := 'null';
    sbSelect        varchar2(10000);
    sbFrom          varchar2(500);
    sbWhere         varchar2(500);
    SbSQL           varchar2(10000); --REQ.200-2004 se amplia 10000
    SbSQLUnion      varchar2(10000); --REQ.200-2004 Creacion
    rcServ          servsusc%rowtype;
    rcProduct       dapr_product.stypr_product;
    sbCategory      varchar2(50) := 'null';
    sbSubcategory   varchar2(50) := 'null';
    vnuTotal        number := 0;
    Sbaplica_quota  ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('APLICA_POLITICAS_QUOTA_FIACE');

    vnuDisp_Extra ld_parameter.value_chain%type := DALD_PARAMETER.fnuGetNumeric_Value('CUPO_DISPONIBLE_EXTRACUPO'); --caso 200-1512
    ----
    vosbidenttype      varchar2(5000);
    vosbidentification varchar2(5000);
    vonusubscriberid   number;
    vosbsubsname       varchar2(5000);
    vosbsubslastname   varchar2(5000);
    vosbaddress        varchar2(5000);
    vonuaddress_id     number;
    vonugeolocation    number;
    vosbfullphone      varchar2(5000);
    vosbcategory       varchar2(5000);
    vosbsubcategory    varchar2(5000);
    vonucategory       number;
    vonusubcategory    number;
    vonuredbalance     number;
    vonuassignedquote  number;
    vonuusedquote      number;

    -----
  BEGIN

    ut_trace.trace('Inicio LD_BOQueryFNB.LD_BOQueryFNB', 10);

    --REQ.200-2004 se habilita nuevamente la logica de validacion de politicas, excluida en el caso 2001512
    if LD_BOCONSTANS.csbokFlag = Sbaplica_quota then
      --200-1075 valida que el suscriptor tenga cupo asignado por cumplimiento de politica
      ld_bononbankfinancing.AllocateQuota(inuSubscription, vnuTotal);
    else
      ld_bononbankfinancing.getsubcriptiondata(inuSubscription,
                                               vosbidenttype,
                                               vosbidentification,
                                               vonusubscriberid,
                                               vosbsubsname,
                                               vosbsubslastname,
                                               vosbaddress,
                                               vonuaddress_id,
                                               vonugeolocation,
                                               vosbfullphone,
                                               vosbcategory,
                                               vosbsubcategory,
                                               vonucategory,
                                               vonusubcategory,
                                               vonuredbalance,
                                               vonuassignedquote,
                                               vonuusedquote,
                                               vnuTotal);
    end if;
    --200-1215 para que valide el cupo disponible contra lo configurado en CUPO_DISPONIBLE_EXTRACUPO
    --REQ.200-2004 se quita logica del caso 2001512
    /*if LD_BOCONSTANS.csbokFlag = Sbaplica_quota and
    vnuTotal < vnuDisp_Extra then*/
    if vnuTotal <= 0 then

      sbSelect := 'select l.extra_quota_id identificador,' ||
                  'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,' ||
                  'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,' ||
                  'supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(supplier_id,0) Proveedor,' ||
                  'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,' ||
                  'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,' ||
                  'value,' || 'initial_date,' || 'final_date,' ||
                  inuSubscription || '  parent_id  ';
      sbFrom   := 'from ld_extra_quota l ';
      sbWhere  := 'where (l.extra_quota_id = -1)';

      --|| 'and l.initial_date < sysdate ' || 'and l.final_date > sysdate ';

      SbSQL := sbSelect || sbFrom || sbWhere;

      ut_trace.trace(SbSQL, 10);

      OPEN ocuExtraQuota FOR sbSql;
      return;

    end if;
    --else

    nuGASProduct := ld_bononbankfinancing.fnugetGasProduct(inuSubscription => inuSubscription);

    if nuGASProduct is not null then
      rcServ    := pktblservsusc.frcGetRecord(nuGASProduct);
      rcProduct := dapr_product.frcGetRecord(nuGASProduct);

      sbCategory    := rcServ.Sesucate;
      sbSubcategory := rcServ.Sesusuca;

      rcab_address := daab_address.frcGetRecord(inuAddress_Id => rcProduct.ADDRESS_ID);
      ut_trace.trace('' || rcab_address.address_id, 10);
      if rcab_address.NEIGHBORTHOOD_ID is not null then
        ge_bogeogra_location.getgeograpparents(inuChildGeoLocId => rcab_address.NEIGHBORTHOOD_ID,
                                               isbText          => sbParentsGeoLoc);
      elsif rcab_address.GEOGRAP_LOCATION_ID is not null then
        ge_bogeogra_location.getgeograpparents(inuChildGeoLocId => rcab_address.GEOGRAP_LOCATION_ID,
                                               isbText          => sbParentsGeoLoc);
      else
        sbParentsGeoLoc := ' nvl( l.geograp_location_id, l.geograp_location_id) ';
      end if;

    end if;

    ---------------------
    --REQ.2002004 -->
    --OBS. Se aplica la siguiente logica.
    -- Si el cupo disponible es un peso(1), se habilita para que libere de extra cupo
    -- la siguiente formula cupo=((Cupo Asignado + Extra Cupo Disponible) - (Cupo Usado)).
    ---------------------
    ld_bononbankfinancing.getsubcriptiondata(inuSubscription,
                                             vosbidenttype,
                                             vosbidentification,
                                             vonusubscriberid,
                                             vosbsubsname,
                                             vosbsubslastname,
                                             vosbaddress,
                                             vonuaddress_id,
                                             vonugeolocation,
                                             vosbfullphone,
                                             vosbcategory,
                                             vosbsubcategory,
                                             vonucategory,
                                             vonusubcategory,
                                             vonuredbalance,
                                             vonuassignedquote,
                                             vonuusedquote,
                                             vnuTotal);
    --IF vnuTotal = 1 THEN
    sbSelect := 'select l.extra_quota_id identificador,' ||
                'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,' ||
                'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,' ||
                'supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(supplier_id,0) Proveedor,' ||
                'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,' ||
                'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,' ||
                'DECODE((DECODE((SIGN((((' || nvl(vonuassignedquote, 0) || ' +
                            (nvl(value, 0))) -
                            (' || vonuusedquote || ' +
                            DECODE(' || vnuTotal ||
                ', 1, 0, ' || vnuTotal || ')))))),
                      -1,
                      0,
                      (((' || nvl(vonuassignedquote, 0) ||
                ' + (nvl(value, 0))) -
                      (' || vonuusedquote || ' +
                      DECODE(' || vnuTotal || ', 1, 0, ' ||
                vnuTotal || ')))))),
              1,
              0,
              0,
              0,
              (((' || nvl(vonuassignedquote, 0) ||
                ' + (nvl(value, 0))) -
              (' || vonuusedquote || ' +
              DECODE(' || vnuTotal || ', 1, 0, ' || vnuTotal ||
                '))))) value,' || 'initial_date,' || 'final_date,' ||
                inuSubscription || '  parent_id  ';
    sbFrom   := 'from ld_extra_quota l ';
    --sbFrom   := 'from ld_extra_quota l, ld_extra_quota_fnb f ';
    /*sbWhere  := 'where l.extra_quota_id = f.extra_quota_id(+) and f.subscription_id(+) = ' || inuSubscription || ' and l.supplier_id is not null and (l.category_id is null or l.category_id= ' ||
    sbCategory || ')' ||
    'and (l.subcategory_id is null or l.subcategory_id = ' ||
    sbSubcategory || ')' ||
    'and (l.geograp_location_id is null or l.geograp_location_id in (' ||
    sbParentsGeoLoc || '))' ||
    'and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date) ';*/
    sbWhere := 'where l.supplier_id is not null and (l.category_id is null or l.category_id= ' ||
               sbCategory || ')' ||
               'and (l.subcategory_id is null or l.subcategory_id = ' ||
               sbSubcategory || ')' ||
               'and (l.geograp_location_id is null or l.geograp_location_id in (' ||
               sbParentsGeoLoc || '))' ||
               'and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date) ';
    --|| 'and l.initial_date < sysdate ' || 'and l.final_date > sysdate ';

    SbSQL := sbSelect || sbFrom || sbWhere;
    --> REQ.200-2004 se agregan proveedores adicionales.
    sbSelect := ' UNION select to_number(l.extra_quota_id || la.supplier_id) identificador,' ||
                'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,' ||
                'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,' ||
                'la.supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(la.supplier_id,0) Proveedor,' ||
                'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,' ||
                'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,' ||
                'DECODE((DECODE((SIGN((((' || nvl(vonuassignedquote, 0) || ' +
                            (nvl(value, 0))) -
                            (' || vonuusedquote || ' +
                            DECODE(' || vnuTotal ||
                ', 1, 0, ' || vnuTotal || ')))))),
                      -1,
                      0,
                      (((' || nvl(vonuassignedquote, 0) ||
                ' + (nvl(value, 0))) -
                      (' || vonuusedquote || ' +
                      DECODE(' || vnuTotal || ', 1, 0, ' ||
                vnuTotal || ')))))),
              1,
              0,
              0,
              0,
              (((' || nvl(vonuassignedquote, 0) ||
                ' + (nvl(value, 0))) -
              (' || vonuusedquote || ' +
              DECODE(' || vnuTotal || ', 1, 0, ' || vnuTotal ||
                '))))) value,' || 'initial_date,' || 'final_date,' ||
                inuSubscription || '  parent_id  ';
    sbFrom   := 'from ld_extra_quota l, ldc_extra_quota_supplier la ';
    --sbFrom   := 'from ld_extra_quota l, ldc_extra_quota_supplier la, ld_extra_quota_fnb f ';
    /*sbWhere  := 'where l.extra_quota_id = f.extra_quota_id(+) and f.subscription_id(+) = ' || inuSubscription || ' and l.extra_quota_id = la.extra_quota_id and l.supplier_id is null and (l.category_id is null or l.category_id = ' ||
    sbCategory || ')' ||
    'and (l.subcategory_id is null or l.subcategory_id = ' ||
    sbSubcategory || ')' ||
    'and (l.geograp_location_id is null or l.geograp_location_id in (' ||
    sbParentsGeoLoc || '))' ||
    'and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date) ';*/

    sbWhere := 'where l.extra_quota_id = la.extra_quota_id and l.supplier_id is null and (l.category_id is null or l.category_id = ' ||
               sbCategory || ')' ||
               'and (l.subcategory_id is null or l.subcategory_id = ' ||
               sbSubcategory || ')' ||
               'and (l.geograp_location_id is null or l.geograp_location_id in (' ||
               sbParentsGeoLoc || '))' ||
               'and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date) ';

    SbSQLUnion := sbSelect || sbFrom || sbWhere;

    SbSQL := SbSQL || SbSQLUnion;

    dbms_output.put_line(SbSQL);

    ut_trace.trace(SbSQL, 10);

    OPEN ocuExtraQuota FOR sbSql;
    return;

    /*ELSE
          --Si el cupo es mayor a un peso. Se obtiene el extra cupo normal.
          sbSelect := 'select l.extra_quota_id identificador,' ||
                  'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,' ||
                  'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,' ||
                  'supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(supplier_id,0) Proveedor,' ||
                  'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,' ||
                  'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,' ||
                  'nvl(value,0) - nvl(f.used_quota,0) value,' || 'initial_date,' || 'final_date,' ||
                  inuSubscription || '  parent_id  ';
      sbFrom   := 'from ld_extra_quota l, ld_extra_quota_fnb f ';
      sbWhere  := 'where l.extra_quota_id = f.extra_quota_id(+) and f.subscription_id(+) = ' || inuSubscription || ' and l.supplier_id is not null and (l.category_id is null or l.category_id= ' ||
                  sbCategory || ')' ||
                  'and (l.subcategory_id is null or l.subcategory_id = ' ||
                  sbSubcategory || ')' ||
                  'and (l.geograp_location_id is null or l.geograp_location_id in (' ||
                  sbParentsGeoLoc || '))' ||
                  'and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date) ';
      --|| 'and l.initial_date < sysdate ' || 'and l.final_date > sysdate ';

      SbSQL := sbSelect || sbFrom || sbWhere;
      --> REQ.200-2004 se agregan proveedores adicionales.
      sbSelect := ' UNION select to_number(l.extra_quota_id || la.supplier_id) identificador,' ||
                  'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,' ||
                  'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,' ||
                  'la.supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(la.supplier_id,0) Proveedor,' ||
                  'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,' ||
                  'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,' ||
                  'nvl(value,0) - nvl(f.used_quota,0) value,' || 'initial_date,' || 'final_date,' ||
                  inuSubscription || '  parent_id  ';
      sbFrom   := 'from ld_extra_quota l, ldc_extra_quota_supplier la, ld_extra_quota_fnb f ';
      sbWhere  := 'where l.extra_quota_id = f.extra_quota_id(+) and f.subscription_id(+) = ' || inuSubscription || ' and l.extra_quota_id = la.extra_quota_id and l.supplier_id is null and (l.category_id is null or l.category_id = ' ||
                  sbCategory || ')' ||
                  'and (l.subcategory_id is null or l.subcategory_id = ' ||
                  sbSubcategory || ')' ||
                  'and (l.geograp_location_id is null or l.geograp_location_id in (' ||
                  sbParentsGeoLoc || '))' ||
                  'and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date) ';

     SbSQLUnion := sbSelect || sbFrom || sbWhere;

     SbSQL := SbSQL || SbSQLUnion;

     dbms_output.put_line(SbSQL);

      ut_trace.trace(SbSQL, 10);

      OPEN ocuExtraQuota FOR sbSql;
      return;
    END IF;*/

    --end if;
    ut_trace.trace('Final LD_BOQueryFNB.LD_BOQueryFNB', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getExtraQuoteBySubs;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalaci?n.

  Autor          : AdoJim
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.
  ocuExtraQuota          Cursor con consulta de retorno.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getExtraQuoteById(inuExtraQuota in ld_extra_quota.extra_quota_id%type,
                              ocuExtraQuota out constants.tyrefcursor) is

    sbSelect varchar2(2000);
    sbFrom   varchar2(2000);
    sbWhere  varchar2(2000);
    SbSQL    varchar2(2000);

  BEGIN

    ut_trace.trace('init GetExtraCuotaByid', 15);

    --200-1075 valida que el suscriptor tenga cupo asignado por cumplimiento de politica
    -- ld_bononbankfinancing.AllocateQuota(inuSubscription, vnuTotal);

    sbSelect := 'select l.extra_quota_id identificador,' ||
                'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,' ||
                'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,' ||
                'supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(supplier_id,0) Proveedor,' ||
                'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,' ||
                'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,' ||
                'value,' || 'initial_date,' || 'final_date,' ||
                'null parent_id ';
    sbFrom   := 'from ld_extra_quota l ';
    sbWhere  := 'where l.extra_quota_id = :inuExtraQuo ' ||
                'and l.initial_date<sysdate ' ||
                'and l.final_date > sysdate ';

    SbSQL := sbSelect || sbFrom || sbWhere;

    OPEN ocuExtraQuota FOR sbSql
      using inuExtraQuota;
    ut_trace.trace('exit GetExtraCuotaByid:' || sbSql, 15);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getExtraQuoteById;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getTransferQuota
  Descripcion    : Obtiene las transferencia de cupo de un contrato.

  Autor          : eramos
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getTransferQuota(inuSubscription  in suscripc.susccodi%type,
                             ocuTrasnferQuota out constants.tyrefcursor) is

    sbQuery  varchar2(32000);
    sbSelect varchar2(3200);
    sbFrom   varchar2(3200);
    sbWhere  varchar2(3200);

  BEGIN

    /*El contrato en el campo ld_quota_transfer.origin_subscrip_id es aquel que recibe el cupo*/
    /*El contrato en el campo ld_quota_transfer.destiny_subscrip_id es aquel que cede el cupo*/

    sbSelect := 'select l.quota_transfer_id,' ||
                'decode( :parent_id , l.origin_subscrip_id,  ''Recibi?'',''Cedi?'') cedio,' ||
                'decode( :parent_id , l.origin_subscrip_id ,l.destiny_subscrip_id, l.origin_subscrip_id) contrato,' ||
                'l.trasnfer_value valor,' ||
                'LD_BOQueryFNB.fnugetCededValToSubsc(l.destiny_subscrip_id, l.quota_transfer_id) saldoCedido,' ||
                'l.final_date fecha,' || 'l.approved aprobado,' || '''' ||
                inuSubscription || ''' parent_id ';

    sbFrom  := 'from ld_quota_transfer l ';
    sbWhere := 'where (l.destiny_subscrip_id = :parent_id ' ||
               'or l.origin_subscrip_id = :parent_id ) ' ||
               'order by l.transfer_date desc ';

    sbQuery := sbSelect || sbFrom || sbWhere;

    OPEN ocuTrasnferQuota FOR sbQuery
      using inuSubscription, inuSubscription, inuSubscription, inuSubscription;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getTransferQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getTransferQuota
  Descripcion    : Obtiene las transferencia de cupo de un contrato.

  Autor          : eramos
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getTransferSubs(inuTransferQuota ld_quota_transfer.quota_transfer_id%type,
                            ocuTrasnferQuota out constants.tyrefcursor) is

    sbQuery  varchar2(32000);
    sbSelect varchar2(3200);
    sbFrom   varchar2(3200);
    sbWhere  varchar2(3200);

  BEGIN

    sbSelect := 'select l.quota_transfer_id,' ||
                'l.origin_subscrip_id||'' recibi? de ''||l.destiny_subscrip_id cedio,' ||
                'l.destiny_subscrip_id contrato,' ||
                'l.trasnfer_value valor,' ||
                'LD_BOQueryFNB.fnugetCededValToSubsc(l.destiny_subscrip_id, l.quota_transfer_id) saldoCedido,' ||
                'l.final_date fecha,' || 'l.approved aprobado,' ||
                'l.origin_subscrip_id parent_id ';
    sbFrom   := 'from ld_quota_transfer l ';
    sbWhere  := 'where l.quota_transfer_id = :nuTrans';

    sbQuery := sbSelect || sbFrom || sbWhere;

    OPEN ocuTrasnferQuota FOR sbQuery
      using inuTransferQuota;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getTransferSubs;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getTransferQuota
  Descripcion    : Obtiene la informacion de cupo de un contrato.

  Autor          : eramos
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/07/2018       Sebastian tapias    REQ.200-2004
                                      Se modifica si el cupo disponible es 0
                                      y cumple politicas, se manda 1.
  01-09-2015      KCienfuegos.ARA8021 Se agrega el llamado a fsbInsuranceSale para obtener
                                      el valor del nuevo campo de Venta de Seguros.
  30-09-2014      KCienfuegos.RNP198  Se agrega el campo de la segmentaci?n comercial.
  12/11/2016      Jorge Valiente      CASO 200-854: Pagare unico
  ******************************************************************/
  PROCEDURE getQuotaInfo(inusubscription in suscripc.susccodi%type,
                         ocuQuotaInfo    out constants.tyrefcursor) is

    sbQuery         varchar2(32000);
    sbSelect        varchar2(3200);
    sbFrom          varchar2(3200);
    nuAssignedQuote number := 0;
    nuUsedQuote     number := 0;
    nuAvalibleQuote number := 0;
    nuRedBalance    number := 0;
    sbBlock         varchar2(3200) := '''No''';
    tbBlock         dald_quota_block.tytbLD_quota_block;
    nuCededValue    number := 0;
    nuReceivedValue number := 0;
    sbPolicy        varchar2(32000) := '''Contrato no existe''';
    nuError         number;
    sbError         varchar2(32000);
    sbSegmComerc    varchar2(3200) := '''Ninguna''';
    nuSegmentId     ldc_segment_susc.segment_id%type;
    sbInsuranceSale varchar2(4000) := '''NO''';
    --CASO 200-854
    nupagare number := 0;
    ----------------------------
    vnuTotal number := 0; --REQ.200-2004 Agregada

    -----------------------
    -- CA 429 -->
    --Asignacion de parametro a variable de sistema.
    -----------------------
    acti_msj_bloqueo_cupo ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('ACTI_MSJ_BLOQUEO_CUPO');
    msj_bloqueo_cupo      ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('MSJ_BLOQUEO_CUPO');
    -----------------------
    -- CA 429 <--
    -----------------------

  BEGIN
    if pktblsuscripc.fblExist(inusubscription) then
      ld_bononbankfinancing.AllocateTotalQuota(inusubscription,
                                               nuAssignedQuote);
      nuUsedQuote := ld_bononbankfinancing.fnuGetUsedQuote(inuSubscription);
      if (nuAssignedQuote >= nuUsedQuote) then
        nuAvalibleQuote := nuAssignedQuote - nuUsedQuote;
      else
        nuAvalibleQuote := 0;
      END if;
      -----------------
      --REQ.2002004 -->
      --OBS.Se implementa la siguiente logica.
      --Si el cupo disponible es 0.
      --Se obtiene el cupo asignado por politicas.
      --Si las politicas asignan un cupo mayor a 0.
      --El cupo disponible es 1.
      -----------------
      IF nuAvalibleQuote = 0 THEN
        ld_bononbankfinancing.AllocateQuota(inuSubscription, vnuTotal);
        IF vnuTotal > 0 THEN
          nuAvalibleQuote := 1;
        END IF;
      END IF;
      -----------------
      --REQ.2002004 <--
      -----------------
      nuRedBalance    := LD_BONonBankFiRules.fnuAcquittedFinan(inuSubscription);
      nuCededValue    := ld_boqueryfnb.fnugetCededValue(inusubscription);
      nuReceivedValue := ld_boqueryfnb.fnugetReceivedValue(inusubscription);
      sbPolicy        := ld_boqueryfnb.fsbgetPolicy(inusubscription);

      --Aranda.8021
      sbInsuranceSale := fsbInsuranceSale(inusubscription);
      sbInsuranceSale := '''' || sbInsuranceSale || '''';

      /*Se obtiene c?digo de la segmentaci?n*/
      ldc_bccommercialsegmentfnb.proGetAcronNameSegmbySusc(inusubscription,
                                                           nuSegmentId,
                                                           sbSegmComerc);
      sbSegmComerc := '''' || sbSegmComerc || '''';
      BEGIN
        dald_quota_block.getRecords('ld_quota_block.subscription_id = ' ||
                                    nvl(inusubscription, 1.1) ||
                                    ' order by register_date desc ',
                                    tbBlock);
        -----------------------
        -- CA 429 -->
        --Se agrega logica para definir o no si mostra la informacion del cupo bloqueado
        --Parametro en Y: No muestra informacion
        --Parametro en N: Muestra la informacion de manera habitual.
        -----------------------
        --Se agrega nueva logica
        if acti_msj_bloqueo_cupo = ld_boconstans.fsbYesFlag then
          sbBlock := '''' || msj_bloqueo_cupo || '''';
        else
          if (tbBlock(tbBlock.first).block = ld_boconstans.fsbYesFlag) then
            sbBlock := '''S?''';
          else
            sbBlock := '''No''';
          end if;
        end if;
        --Se comenta logica actual
        /*if (tbBlock(tbBlock.first).block = ld_boconstans.fsbYesFlag) then
          sbBlock := '''S?''';
        else
          sbBlock := '''No''';
        end if;*/
        -----------------------
        -- CA 429 <--
        -----------------------
      exception
        when ex.CONTROLLED_ERROR then
          Errors.GetError(nuError, sbError);
          --dbms_output.put_line('950724 -- Error: '|| nuError || ' Mensaje: '|| sbError);
          if (1 = nuError) then
            --Se agrega nueva logica
            if acti_msj_bloqueo_cupo = ld_boconstans.fsbYesFlag then
              sbBlock := '''' || msj_bloqueo_cupo || '''';
            else
              sbBlock := '''No''';
            end if;
            --Se comenta mensaje anterior
            --sbBlock := '''No''';
          end if;
      END;

      --CASO 200-854.
      --COmentariado para ser aplicado sin la modificacion de este caso
      --/*
      begin
        --pagare unico
        select pagare_id
          into nupagare
          from ldc_pagunidat
         where suscription_id = inusubscription
           and estado =
               (select numeric_value
                  from ld_parameter
                 where parameter_id = 'COD_EST_EN_PRO_PAG_UNI')
           and rownum = 1;
      exception
        when others then
          nupagare := null;
      END;
      --*/

    end if;
    sbSelect := 'select ' || nvl(nuAssignedQuote, 0) || ' cupo_asignado,' ||
                nvl(nupagare, 0) || ' Pagare_Unico,' || nvl(nuUsedQuote, 0) ||
                ' cupo_usado,' || nvl(nuAvalibleQuote, 0) ||
                ' cupo_disponible,' || sbSegmComerc || ' segmentacion,' ||
                nvl(nuRedBalance, 0) || ' saldo_red,' || sbBlock ||
                ' cupo_bloqueado,' || nvl(nuCededValue, 0) ||
                ' cupo_cedido,' || nvl(nuReceivedValue, 0) ||
                ' cupo_recibido,' || sbPolicy || ' politicas_incumplidas,' ||
                sbInsuranceSale || ' venta_seguros,' ||
                nvl(inusubscription, 1.1) || ' parent_id ';
    ut_trace.trace('Cadena de seleccion: ' || chr(10) || sbSelect, 10);
    sbFrom := ' from DUAL WHERE ' || nvl(inusubscription, 1.1) || ' != 1.1';
    ut_trace.trace('Cadena de producto cartesiano: ' || chr(10) || sbFrom,
                   10);
    sbQuery := sbSelect || sbFrom;

    ut_trace.trace(sbQuery, 10);

    dbms_output.put_line(sbQuery);

    OPEN ocuQuotaInfo FOR sbQuery;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getQuotaInfo;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  fnugetCededValue
  Descripcion :  Calcula el cupo cedido de una suscripci?n.

                 - Para la suscripci?n se obtienen las suscripciones a las
                 cuales le ha trasladado cupo
                 - Para cada una de las suscripciones:
                   * Se obtiene el saldo de fnb (diferidos + saldo + ?rdenes )
                   * Se Obtiene el total de las ventas de los traslados menos
                     pagos
                   * Se obtiene el valor trasladado
                   * Se hace la resta entre total ventas menos total
                     trasladado, este ser?a el cupo usado por la suscripci?n
                   * Se aplica el saldo fnb al cupo usado por la suscripci?n
                   * Si sobra saldo empieza a aplicarlo a cada una de las
                     suscripciones que hicieron traslado, para conocer as? el
                     cupo usado

  Autor       :  Luis E. Fern?ndez
  Fecha       :  9-17-2013
  Parametros  :

      inusubscription     C?digo de la suscripci?n

  Historia de Modificaciones
  Fecha       Autor               Modificaci?n
  =========   =========           ====================
  9-17-2013   lfernandez.SAO203070 Se modifica para validar que el paquete no
                                  sea nulo
  9-17-2013   lfernandez.SAO203070 Se modifica para aplicar la l?gica de ir
                                  descontando el valor trasladado por las
                                  suscripciones
  26-12-2018  Daniel Valiente     Devolucion de Cupos (200-1667)
              Samuel Pacheco
  ***************************************************************/
  FUNCTION fnugetCededValue(inusubscription in suscripc.susccodi%type)
    return number IS
    ------------------------------------------------------------------------
    --  Tipos
    ------------------------------------------------------------------------
    tbProcPackages tytbProcPackages;
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    nuValue      number;
    nuIdx        binary_integer;
    nuIdxOrig    binary_integer;
    nuDefBalance diferido.difesape%type;
    nuAccBalance cuencobr.cucosacu%type;

    nuSaleRequest     mo_packages.package_id%type;
    nuNonLegOrders    ld_item_work_order.value%type;
    nuLegalOrders     ld_item_work_order.value%type;
    nuUsedQuota       ld_item_work_order.value%type;
    nuOriginUsedQuota ld_item_work_order.value%type;
    nuTransferQuota   ld_item_work_order.value%type;
    nuTotalSale       ld_item_work_order.value%type;

    nuOrigSubsc    ld_quota_transfer.origin_subscrip_id%type;
    nuDestSubsc    ld_quota_transfer.destiny_subscrip_id%type;
    tbSubscQuota   DALD_Quota_Transfer.tytbTrasnfer_Value;
    tbOrigTransfer DALD_Quota_transfer.tytbOrigin_Subscrip_Id;
    tbDestTransfer DALD_Quota_transfer.tytbLD_quota_transfer;

    ------------------------------------------------------------------------
    --  Cursores
    ------------------------------------------------------------------------
    CURSOR cuOrigTransfer(inuSubsc ld_quota_transfer.destiny_subscrip_id%type) IS
      SELECT distinct origin_subscrip_id
        FROM ld_quota_transfer
       WHERE destiny_subscrip_id = inuSubsc
         AND approved = LD_BOConstans.csbYesFlag;
    ------------------------------------------------------------------------
    CURSOR cuDestTransfer(inuSubsc ld_quota_transfer.origin_subscrip_id%type) IS
      SELECT t.*, t.rowid
        FROM ld_quota_transfer t
       WHERE t.origin_subscrip_id = inuSubsc
         AND t.approved = LD_BOConstans.fsbYesFlag
         AND t.trasnfer_value > 0
         AND exists (SELECT 1
                FROM ld_item_work_order l, OR_order_activity a
               WHERE a.order_activity_id = l.order_activity_id
                 AND a.package_id = t.package_id
                 AND l.state != 'AN')
       ORDER BY t.quota_transfer_id desc;
    ------------------------------------------------------------------------
    CURSOR cuDefBalance(inuSubsc diferido.difesusc%type) IS
      SELECT sum(difesape)
        FROM diferido, servsusc
       WHERE difenuse = sesunuse
         AND difesusc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm);
    ------------------------------------------------------------------------
    CURSOR cuAccBalance(inuSubsc servsusc.sesususc%type) IS
      SELECT sum(cucosacu)
        FROM cuencobr, servsusc
       WHERE cuconuse = sesunuse
         AND sesususc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm);
    ------------------------------------------------------------------------
    CURSOR cuLegalOrders(inuSubsc suscripc.susccodi%type) IS
      SELECT sum((l.value + nvl(l.iva, 0)) * l.amount) Value_Item
        FROM or_order           o,
             ld_item_work_order l,
             or_order_activity  a,
             mo_packages        p
       WHERE o.order_Status_Id in
             (cnuRegisterStatus, cnuAssignStatus, cnuCloseStatus)
         AND a.subscription_id = inuSubsc
         AND o.order_id = a.order_id
         AND a.order_activity_id = l.order_activity_id
         AND a.package_id = p.package_id
         AND p.motive_status_id = cnuMotiveStatus
         AND l.state <> csbAnull
         AND a.activity_id = cnuSellAct;
    ------------------------------------------------------------------------
    CURSOR cuTotalSaleValue(inuPackage mo_packages.package_id%type) IS
      SELECT SUM((w.value + nvl(w.iva, 0)) * w.amount) value
        FROM ld_item_work_order w, or_order_activity oa
       WHERE w.order_activity_id = oa.order_activity_id
         AND oa.package_id = inuPackage
         AND oa.activity_id = cnuSellAct
         AND w.state != 'AN';
    ------------------------------------------------------------------------
    --200-1667
    cont_Diferido number := 0;
    ------------------------------------------------------------------------
    CURSOR cuDefBalance2(inuSubsc diferido.difesusc%type) IS
      SELECT sum(difesape)
        FROM diferido, servsusc
       WHERE difenuse = sesunuse
         AND difesusc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm)
         and difecodi in
             (SELECT distinct l.difecodi
                FROM or_order           o,
                     ld_item_work_order l,
                     or_order_activity  a,
                     mo_packages        p
               WHERE a.subscription_id = inuSubsc
                 AND o.order_id = a.order_id
                 AND a.order_activity_id = l.order_activity_id
                 AND a.package_id = p.package_id
                 and a.package_id IN
                     (SELECT t.package_id
                        FROM ld_quota_transfer t
                       WHERE t.origin_subscrip_id = inuSubsc
                         AND T.DESTINY_SUBSCRIP_ID = inusubscription
                         AND t.approved = LD_BOConstans.fsbYesFlag
                         AND t.trasnfer_value > 0
                         AND exists
                       (SELECT 1
                                FROM ld_item_work_order l, OR_order_activity a
                               WHERE a.order_activity_id = l.order_activity_id
                                 AND a.package_id = t.package_id
                                 AND l.state != csbAnull))
                 and l.difecodi is not null);
    ------------------------------------------------------------------------
    CURSOR cuAccBalance2(inuSubsc servsusc.sesususc%type) IS
      SELECT sum(cucosacu)
        FROM cuencobr
       WHERE cucocodi in
             (SELECT cargcuco
                FROM cargos c
               WHERE c.cargcuco in
                     (SELECT cuencobr.cucocodi
                        FROM cuencobr, servsusc
                       WHERE cuconuse = sesunuse
                         AND sesususc = inuSubsc
                         AND sesuserv in
                             (cnuProdTypeBrilla, cnuProdTypeBrillaProm))
                 and cargdoso IN
                     (SELECT 'DF-' || l.difecodi
                        FROM or_order           o,
                             ld_item_work_order l,
                             or_order_activity  a,
                             mo_packages        p
                       WHERE a.subscription_id = inuSubsc
                         AND o.order_id = a.order_id
                         AND a.order_activity_id = l.order_activity_id
                         AND a.package_id = p.package_id
                         and a.package_id IN
                             (SELECT t.package_id
                                FROM ld_quota_transfer t
                               WHERE t.origin_subscrip_id = inuSubsc
                                 AND T.DESTINY_SUBSCRIP_ID = inusubscription
                                 AND t.approved = LD_BOConstans.fsbYesFlag
                                 AND t.trasnfer_value > 0
                                 AND exists
                               (SELECT 1
                                        FROM ld_item_work_order l,
                                             OR_order_activity  a
                                       WHERE a.order_activity_id =
                                             l.order_activity_id
                                         AND a.package_id = t.package_id
                                         AND l.state != csbAnull))
                         and l.difecodi is not null
                       GROUP BY l.difecodi));
    ------------------------------------------------------------------------
    --fin
  BEGIN

    ut_trace.trace('Inicia ld_boqueryfnb.fnugetCededValue contrato: ' ||
                   inusubscription,
                   2);

    --  Obtiene las suscripciones a las cuales le ha trasladado cupo
    open cuOrigTransfer(inusubscription);
    fetch cuOrigTransfer bulk collect
      into tbOrigTransfer;
    close cuOrigTransfer;

    nuIdx := tbOrigTransfer.First;

    while (nuIdx is not null) loop

      --  Asigna la suscripci?n que recibe el cupo
      nuOrigSubsc := tbOrigTransfer(nuIdx);

      --  Limpia variables
      nuDefBalance   := 0;
      nuAccBalance   := 0;
      nuNonLegOrders := 0;
      nuLegalOrders  := 0;

      --200-1667
      --validacion de refinanciacion de cupo
      cont_Diferido := 0;
      select COUNT(*)
        into cont_Diferido
        from DIFERIDO
       WHERE DIFEPROG = 'GCNED'
         AND DIFESUSC = nuOrigSubsc;

      if cont_Diferido > 0 then
        --continua el proceso que tenia
        --  Obtiene el saldo diferido de la suscripci?n
        open cuDefBalance(nuOrigSubsc);
        fetch cuDefBalance
          INTO nuDefBalance;
        close cuDefBalance;

        --  Obtiene el saldo corriente de la suscripci?n
        open cuAccBalance(nuOrigSubsc);
        fetch cuAccBalance
          INTO nuAccBalance;
        close cuAccBalance;

      else
        --nuevo proceso
        --  Obtiene el saldo diferido de la suscripci?n
        open cuDefBalance2(nuOrigSubsc);
        fetch cuDefBalance2
          INTO nuDefBalance;
        close cuDefBalance2;

        --  Obtiene el saldo corriente de la suscripci?n
        open cuAccBalance2(nuOrigSubsc);
        fetch cuAccBalance2
          INTO nuAccBalance;
        close cuAccBalance2;
      end if;

      --  Obtiene el saldo de los art?culos en ?rdenes legalizadas
      open cuLegalOrders(nuOrigSubsc);
      fetch cuLegalOrders
        INTO nuLegalOrders;
      close cuLegalOrders;

      --  Asigna el cupo utilizado
      nuUsedQuota := nvl(nuDefBalance, 0) + nvl(nuAccBalance, 0) +
                     nvl(nuLegalOrders, 0);
      UT_Trace.Trace('Total de los saldos de contrato ' || nuOrigSubsc || ': ' ||
                     nuUsedQuota,
                     3);

      --  Si la suscripci?n origen tiene cupo utilizado
      if (nuUsedQuota > 0) then

        --  Inicializa varibles
        nuTransferQuota   := 0;
        nuOriginUsedQuota := 0;
        tbProcPackages.delete;

        --  Obtiene las suscripciones que le trasladaron a la suscripci?n origen
        open cuDestTransfer(nuOrigSubsc);
        fetch cuDestTransfer bulk collect
          INTO tbDestTransfer;
        close cuDestTransfer;
        UT_Trace.Trace('Traslados realizados a la suscripci?n: ' ||
                       tbDestTransfer.count,
                       3);

        nuIdxOrig := tbDestTransfer.First;

        --  Recorre las solicitudes para conocer el valor de la venta y
        --  el valor trasladado, y asi saber el cupo usado de la suscripci?n
        while (nuIdxOrig is not null) loop

          --  Asigna la solicitud
          nuSaleRequest := tbDestTransfer(nuIdxOrig).package_id;

          --  Si no se ha consultado la solicitud
          if (nuSaleRequest IS not null AND
             not tbProcPackages.exists(nuSaleRequest)) then

            ut_trace.trace('Solicitud: ' || nuSaleRequest, 4);

            --  Inicializa valor
            nuTotalSale := 0;

            --  Asigna solicitud procesada
            tbProcPackages(nuSaleRequest) := null;

            --  Obtiene el valor de la venta de la solicitud
            open cuTotalSaleValue(nuSaleRequest);
            fetch cuTotalSaleValue
              INTO nuTotalSale;
            close cuTotalSaleValue;

            ut_trace.trace('Total Venta: ' || nuTotalSale, 5);
            ut_trace.trace('Cuota inicial: ' ||
                           DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                           5);

            --  Aumenta el cupo usado de la solicitud origen
            nuOriginUsedQuota := nuOriginUsedQuota + nuTotalSale -
                                 nvl(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                                     0);

            ut_trace.trace('Cupo usado venta: ' || nuOriginUsedQuota, 5);

          end if;

          --  Acumula el cupo trasladado

          ut_trace.trace('Cupo trasladado solicitud: ' || tbDestTransfer(nuIdxOrig)
                         .trasnfer_value,
                         7);

          nuTransferQuota := nuTransferQuota + tbDestTransfer(nuIdxOrig)
                            .trasnfer_value;

          ut_trace.trace('Acumulado traslados: ' || nuTransferQuota, 7);

          nuIdxOrig := tbDestTransfer.Next(nuIdxOrig);

        end loop;

        --  Asigna a la suscripci?n como cupo el valor de las ventas
        --  menos el cupo transferido
        tbSubscQuota(nuOrigSubsc) := nuOriginUsedQuota - nuTransferQuota;

        ut_trace.trace('Cupo propio:' || nuOrigSubsc || '[' ||
                       tbSubscQuota(nuOrigSubsc) || ']Deuda[' ||
                       nuUsedQuota,
                       4);

        --  Disminuye la cuota usada, aplic?ndola a la sucripci?n origen
        --  primero y luego a las suscripciones que le trasladaron cupo
        if (nuUsedQuota > tbSubscQuota(nuOrigSubsc)) then

          --  Disminuye la cuota usada
          nuUsedQuota := nuUsedQuota - tbSubscQuota(nuOrigSubsc);

        else

          nuUsedQuota := 0;

        END if;

        ut_trace.trace('Cupo a repartir entre quienes trasladaron: ' ||
                       nuUsedQuota,
                       4);

        UT_Trace.Trace('Luego de aplicado el cupo utilizado sobre el cupo de la suscripci?n: ' ||
                       nuUsedQuota,
                       3);

        nuIdxOrig := tbDestTransfer.First;

        --  Mientras haya cuota usada
        while (nuIdxOrig is not null AND nuUsedQuota > 0) loop

          ut_trace.trace('Quien cede: ' || tbDestTransfer(nuIdxOrig)
                         .destiny_subscrip_id,
                         4);

          --  Asigna la suscripci?n destino
          nuDestSubsc := tbDestTransfer(nuIdxOrig).destiny_subscrip_id;

          --  Si se le ha asignado valor
          if (tbSubscQuota.exists(nuDestSubsc)) then

            --  Si la cuota usada es mayor al valor trasladado
            if (nuUsedQuota > tbDestTransfer(nuIdxOrig).trasnfer_value) then

              --  Disminuye la cuota usada
              nuUsedQuota := nuUsedQuota - tbDestTransfer(nuIdxOrig)
                            .trasnfer_value;
              --  Aumenta el cupo usado de la suscripci?n
              tbSubscQuota(nuDestSubsc) := tbSubscQuota(nuDestSubsc) + tbDestTransfer(nuIdxOrig)
                                          .trasnfer_value;

            else

              --  Aumenta el cupo usado de la suscripci?n
              tbSubscQuota(nuDestSubsc) := tbSubscQuota(nuDestSubsc) +
                                           nuUsedQuota;
              --  Disminuye la cuota usada
              nuUsedQuota := 0;

            END if;

          else

            --  Si la cuota usada es mayor al valor trasladado
            if (nuUsedQuota > tbDestTransfer(nuIdxOrig).trasnfer_value) then

              --  Disminuye la cuota usada
              nuUsedQuota := nuUsedQuota - tbDestTransfer(nuIdxOrig)
                            .trasnfer_value;
              --  Asigna el cupo usado de la suscripci?n
              tbSubscQuota(nuDestSubsc) := tbDestTransfer(nuIdxOrig)
                                           .trasnfer_value;

            else

              --  Asigna el cupo usado de la suscripci?n
              tbSubscQuota(nuDestSubsc) := nuUsedQuota;
              --  Disminuye la cuota usada
              nuUsedQuota := 0;

            END if;

          end if;

          nuIdxOrig := tbDestTransfer.Next(nuIdxOrig);

        end loop;

      END if;

      nuIdx := tbOrigTransfer.Next(nuIdx);

    end loop;

    --  Si se consult? valor para la suscripci?n
    if (tbSubscQuota.exists(inusubscription)) then
      nuValue := tbSubscQuota(inusubscription);
    else
      nuValue := 0;
    END if;

    ut_trace.trace('Fin ld_boqueryfnb.fnugetCededValue ', 2);
    return nuValue;

  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when OTHERS then
      Errors.SetError;
      raise ex.CONTROLLED_ERROR;
  END fnugetCededValue;

  -- CUPO RECIBIDO
  FUNCTION fnugetReceivedValue(inusubscription in suscripc.susccodi%type)
    return number IS

    ------------------------------------------------------------------------
    --  Tipos
    ------------------------------------------------------------------------
    tbProcPackages tytbProcPackages;

    --type tytbPacksNoTransfer IS table of number index BY varchar2(20);
    tbPacksNoTransfer damo_packages.tytbPackage_id; --tytbPacksNoTransfer;

    ------------------------------------------------------------------------
    --  Variables --
    ------------------------------------------------------------------------
    nuDefBalance      diferido.difesape%type;
    nuAccBalance      cuencobr.cucosacu%type;
    nuLegalOrders     ld_item_work_order.value%type;
    nuUsedQuota       ld_item_work_order.value%type;
    nuTransfvalue     number;
    tbDestTransfer    DALD_Quota_transfer.tytbLD_quota_transfer;
    nuIdxOrig         binary_integer;
    nuOriginUsedQuota ld_item_work_order.value%type;
    nuTransferQuota   ld_item_work_order.value%type;
    nuTotalSale       ld_item_work_order.value%type;
    nuValue           number;
    nuSaleRequest     mo_packages.package_id%type;

    ------------------------------------------------------------------------
    CURSOR cuDestTransfer(inuSubsc ld_quota_transfer.origin_subscrip_id%type) IS
      SELECT t.*, t.rowid
        FROM ld_quota_transfer t
       WHERE t.origin_subscrip_id = inuSubsc
         AND t.approved = LD_BOConstans.fsbYesFlag
         AND t.trasnfer_value > 0
         AND exists (SELECT 1
                FROM ld_item_work_order l, OR_order_activity a
               WHERE a.order_activity_id = l.order_activity_id
                 AND a.package_id = t.package_id
                 AND l.state != 'AN')
       ORDER BY t.quota_transfer_id desc;
    ------------------------------------------------------------------------
    CURSOR cuSolWithoutTrans(inuSubsc ld_quota_transfer.origin_subscrip_id%type) IS
      SELECT unique a.package_id
        FROM OR_order_activity a, ld_item_work_order w
       WHERE a.subscription_id = inuSubsc
         AND w.ORDER_activity_id = a.ORDER_activity_id
         AND a.PACKAGE_id not in
             (SELECT t.package_id
                FROM ld_quota_transfer t
               WHERE t.origin_subscrip_id = inuSubsc
                 AND t.approved = LD_BOConstans.fsbYesFlag
                 AND t.trasnfer_value > 0
                 AND exists
               (SELECT 1
                        FROM ld_item_work_order l, OR_order_activity a
                       WHERE a.order_activity_id = l.order_activity_id
                         AND a.package_id = t.package_id
                         AND l.state != 'AN'))
         AND w.state != 'AN'
         AND w.difecodi IS not null;
    ------------------------------------------------------------------------
    CURSOR cuDefBalance(inuSubsc diferido.difesusc%type) IS
      SELECT sum(difesape)
        FROM diferido, servsusc
       WHERE difenuse = sesunuse
         AND difesusc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm);
    ------------------------------------------------------------------------
    CURSOR cuAccBalance(inuSubsc servsusc.sesususc%type) IS
      SELECT sum(cucosacu)
        FROM cuencobr, servsusc
       WHERE cuconuse = sesunuse
         AND sesususc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm);
    ------------------------------------------------------------------------
    CURSOR cuLegalOrders(inuSubsc suscripc.susccodi%type) IS
      SELECT sum((l.value + nvl(l.iva, 0)) * l.amount) Value_Item
        FROM or_order           o,
             ld_item_work_order l,
             or_order_activity  a,
             mo_packages        p
       WHERE o.order_Status_Id in
             (cnuRegisterStatus, cnuAssignStatus, cnuCloseStatus)
         AND a.subscription_id = inuSubsc
         AND o.order_id = a.order_id
         AND a.order_activity_id = l.order_activity_id
         AND a.package_id = p.package_id
         AND p.motive_status_id = cnuMotiveStatus
         AND l.state <> csbAnull
         AND a.activity_id = cnuSellAct;
    -------------------------------
    CURSOR cuTotalSaleValue(inuPackage mo_packages.package_id%type) IS
      SELECT SUM((w.value + nvl(w.iva, 0)) * w.amount) value
        FROM ld_item_work_order w, or_order_activity oa
       WHERE w.order_activity_id = oa.order_activity_id
         AND oa.package_id = inuPackage
         AND oa.activity_id = cnuSellAct
         AND w.state != 'AN';

  BEGIN
    ut_trace.trace('inicio ld_boqueryfnb.fnugetReceivedValue', 10);
    --  Limpia variables
    nuDefBalance      := 0;
    nuAccBalance      := 0;
    nuLegalOrders     := 0;
    nuOriginUsedQuota := 0;
    nuTransferQuota   := 0;

    --  Obtiene el saldo diferido de la suscripci?n
    open cuDefBalance(inusubscription);
    fetch cuDefBalance
      INTO nuDefBalance;
    close cuDefBalance;

    --  Obtiene el saldo corriente de la suscripci?n
    open cuAccBalance(inusubscription);
    fetch cuAccBalance
      INTO nuAccBalance;
    close cuAccBalance;

    --  Obtiene el saldo de los art?culos en ?rdenes legalizadas
    open cuLegalOrders(inusubscription);
    fetch cuLegalOrders
      INTO nuLegalOrders;
    close cuLegalOrders;

    --  Asigna la deuda
    nuUsedQuota := nvl(nuDefBalance, 0) + nvl(nuAccBalance, 0) +
                   nvl(nuLegalOrders, 0);

    UT_Trace.Trace('Total saldos del contrato (deuda) ' || inusubscription ||
                   ' : ' || nuUsedQuota,
                   3);

    if (nuUsedQuota > 0) then

      -- valor recibido
      -- Obtiene las suscripciones que le trasladaron a la suscripci?n origen
      open cuDestTransfer(inusubscription);
      fetch cuDestTransfer bulk collect
        INTO tbDestTransfer;
      close cuDestTransfer;

      UT_Trace.Trace('Traslados realizados a la suscripci?n: ' ||
                     tbDestTransfer.count,
                     3);

      --  Recorre las solicitudes para conocer el valor de la venta y
      --  el valor trasladado, y asi saber el cupo usado de la suscripci?n
      nuIdxOrig := tbDestTransfer.First;
      while (nuIdxOrig is not null) loop

        --  Inicializa valor
        nuTotalSale := 0;

        --  Asigna la solicitud
        nuSaleRequest := tbDestTransfer(nuIdxOrig).package_id;

        --  Si no se ha consultado la solicitud
        if (nuSaleRequest IS not null AND
           not tbProcPackages.exists(nuSaleRequest)) then

          tbProcPackages(nuSaleRequest) := null;
          --  Obtiene el valor de la venta de la solicitud
          open cuTotalSaleValue(nuSaleRequest);
          fetch cuTotalSaleValue
            INTO nuTotalSale;
          close cuTotalSaleValue;

          ut_trace.trace('Solicitud: ' || nuSaleRequest ||
                         ' Total Venta: ' || nuTotalSale,
                         5);

          --  Aumenta el cupo usado de la solicitud origen
          nuOriginUsedQuota := nuOriginUsedQuota + nuTotalSale -
                               nvl(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                                   0);
          ut_trace.trace('Cupo usado venta: ' || nuOriginUsedQuota, 5);
        END if;

        nuTransferQuota := nuTransferQuota + tbDestTransfer(nuIdxOrig)
                          .trasnfer_value;
        ut_trace.trace('Cupo trasladado: ' || nuTransferQuota, 5);
        nuIdxOrig := tbDestTransfer.Next(nuIdxOrig);
      END loop;

      -- SOLICITUDES SIN TRASLADO
      nuIdxOrig := null;
      open cuSolWithoutTrans(inusubscription);
      fetch cuSolWithoutTrans bulk collect
        INTO tbPacksNoTransfer;
      close cuSolWithoutTrans;

      nuIdxOrig := tbPacksNoTransfer.First;
      while (nuIdxOrig is not null) loop

        nuSaleRequest := tbPacksNoTransfer(nuIdxOrig);
        --  Obtiene el valor de la venta de la solicitud
        open cuTotalSaleValue(nuSaleRequest);
        fetch cuTotalSaleValue
          INTO nuTotalSale;
        close cuTotalSaleValue;

        --  Aumenta el cupo usado de la solicitud origen
        nuOriginUsedQuota := nuOriginUsedQuota + nuTotalSale -
                             nvl(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                                 0);
        ut_trace.trace('Solicitud[' || nuSaleRequest || ']Total Venta[' ||
                       nuTotalSale || ']Cupo usado venta: ' ||
                       nuOriginUsedQuota,
                       5);

        nuIdxOrig := tbPacksNoTransfer.next(nuIdxOrig);
      END loop;

      if (nuTransferQuota > 0) then
        -- cupo usado propio original
        nuOriginUsedQuota := nuOriginUsedQuota - nuTransferQuota;

        ut_trace.trace('Cupo Usado Original=' || nuOriginUsedQuota, 15);

        -- si lo que debo es mayor que el cupo original, entonces,
        -- ese excedente es lo que debo a quienes me trasladaron
        if (nuUsedQuota > nuOriginUsedQuota) then
          nuValue := nuUsedQuota - nuOriginUsedQuota;
        else
          nuValue := 0;
        END if;

      else
        -- si no hay traslados no hay se debe nadie de traslado
        nuValue := 0;
      END if;

    else
      -- si no hay deuda no debe nada a quienes le trasladaron
      nuValue := 0;
    END if;

    ut_trace.trace('Fin ld_boqueryfnb.fnugetReceivedValue', 10);
    return nvl(nuValue, 0);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnugetReceivedValue;

  FUNCTION fsbgetPolicy(inusubscription in suscripc.susccodi%type)
    return varchar2 is
    tbQuotaHistoric dald_quota_historic.tytbLD_quota_historic;
    tbPolicy        dald_policy_historic.tytbLD_policy_historic;
    sbPolicys       varchar2(32000) := null;
    nuIndex         number;
    nuError         number;
    sbError         varchar2(32000);
    nuCont          number;

  BEGIN
    ut_trace.trace('INICIO fsbgetPolicy ', 10);
    dald_quota_historic.getRecords(' subscription_id = ' ||
                                   inusubscription ||
                                   ' order by ld_quota_historic.register_date desc',
                                   tbQuotaHistoric);
    BEGIN

      Dald_Policy_Historic.getRecords('  ld_policy_historic.quota_historic_id = ' || tbQuotaHistoric(1)
                                      .quota_historic_id,
                                      tbPolicy);
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
        sbPolicys := '''No existen pol?ticas para evaluar''';
    END;

    if tbQuotaHistoric.count > 0 then

      if (tbPolicy.count > 0) then

        nuCont  := 0;
        nuIndex := tbPolicy.first;

        while nuIndex is not null loop

          if (tbPolicy(nuIndex).result = 'N') then
            if (sbPolicys IS not null) then
              sbPolicys := sbPolicys || '||chr(13)||chr(10)||';
            END if;
            sbPolicys := sbPolicys || '''' || tbPolicy(nuIndex)
                        .quota_assign_policy_id || ' - ' ||
                         dald_quota_assign_policy.fsbGetDescription(tbPolicy(nuIndex)
                                                                    .quota_assign_policy_id) || '''';

          else
            nuCont := nuCont + 1;
          END if;

          nuIndex := tbPolicy.next(nuIndex);
        end loop;
      END if;
    end if;

    if (nuCont = tbPolicy.count) then
      sbPolicys := '''Cumple todas las pol?ticas''';
    END if;

    ut_trace.trace('FIN fsbgetPolicy ', 10);

    return sbPolicys;

  EXCEPTION
    when ex.CONTROLLED_ERROR then

      Errors.GetError(nuError, sbError);
      if (1 = nuError) then

        return '''Cumple todas las pol?ticas''';
      else
        raise ex.CONTROLLED_ERROR;
      end if;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fsbgetPolicy;
  /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnuDatosLiq
      Descripcion    : Indica los valores de liquidacion
      Autor          : Evelio Sanjuanelo
      Fecha          : 26/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id      paquete
      inuarticle         articulo
      inuopcion          1) ValCobComPro, --? COBRO COMISI?N A PROVEEDOR
                         2) ValComPagCon, --?  Valor de comisi?n pagada al contratista.
      Historia de Modificaciones
      Fecha                 Autor                   Modificacion
      =========             ===========             ====================
      06-01-2015      KCienfuegos.RNP2923       Se modifica para que cuando la UT del usuario conectada
                                                sea proveedor/contratista, permita ver el valor solo si
                                                corresponde a la UT conectada.
  ******************************************************************/

  FUNCTION fnuDatosLiq(inuOrderActivitySale in OR_order_activity.order_activity_id%type,
                       inuopcion            in number default 0)

   RETURN number

   IS
    nuvalor         number := 0;
    nuOperUnitConn  or_operating_unit.operating_unit_id%type;
    nuOperUnitOrd   or_operating_unit.operating_unit_id%type;
    nuClassSuppl    or_oper_unit_classif.oper_unit_classif_id%type;
    nuClassContract or_operating_unit.oper_unit_classif_id%type;
    nuOperClassif   or_oper_unit_classif.oper_unit_classif_id%type;
    nuContractId    or_operating_unit.contractor_id%type;
    nuContractConn  or_operating_unit.contractor_id%type;

    --Obtiene la unidad operativa del usuario conectado
    CURSOR cuGetunitBySeller IS
      SELECT organizat_area_id
        FROM cc_orga_area_seller
       WHERE person_id = GE_BOPersonal.fnuGetPersonId
         AND IS_current = 'Y'
         AND rownum = 1;

    CURSOR cuOperUnit IS
      SELECT o.operating_unit_id
        FROM or_order o, or_order_activity oa
       WHERE oa.order_id = o.order_id
         AND oa.order_activity_id = inuOrderActivitySale;

    CURSOR cuOperUnitSupp IS
      select o.operating_unit_id
        from or_order_activity o, ld_item_work_order l
       where o.origin_activity_id = inuOrderActivitySale
         and activity_id =
             dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
         and o.order_activity_id = l.order_activity_id
         and rownum = 1;
  BEGIN

    nuClassSuppl    := DALD_PARAMETER.fnuGetNumeric_Value('SUPPLIER_FNB', 0);
    nuClassContract := DALD_PARAMETER.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB',
                                                          0);

    --Obtiene la unidad operativa del usario conectado
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperUnitConn;
    close cuGetunitBySeller;

    --Obtiene la clasificaci?n de la UT del usuario conectado
    nuOperClassif := daor_operating_unit.fnugetoper_unit_classif_id(nuOperUnitConn,
                                                                    0);

    --Obtiene el contratista de la UT del usuario conectado
    nuContractConn := daor_operating_unit.fnugetcontractor_id(nuOperUnitConn,
                                                              0);

    ut_trace.Trace('INICIO Ld_BcNonBankFinancing.fnuDatosEntr', 10);
    select t.value_paid
      into nuvalor
      from ld_liquidation_seller l, ld_detail_liqui_seller t
     where l.liquidation_seller_id = t.liquidation_seller_id
       and l.status = decode(inuopcion, 1, 'P', 'V')
       and (t.base_order_id, t.article_id) in
           (select o.order_id, l.article_id
              from or_order_activity o, ld_item_work_order l
             where o.origin_activity_id = inuOrderActivitySale
               and activity_id =
                   dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
               and o.order_activity_id = l.order_activity_id
               and rownum = 1);

    if nuOperClassif not in (nuClassSuppl, nuClassContract) then

      Return nvl(nuvalor, 0);

    else
      if inuopcion = 1 then
        /*Si se va a obtener el valor del proveedor*/
        OPEN cuOperUnitSupp;
        FETCH cuOperUnitSupp
          into nuOperUnitOrd;
        CLOSE cuOperUnitSupp;

      else
        /*Si se va a obtener el valor del contratista de venta*/
        OPEN cuOperUnit;
        FETCH cuOperUnit
          into nuOperUnitOrd;
        CLOSE cuOperUnit;

      end if;

      nuContractId := daor_operating_unit.fnugetcontractor_id(nuOperUnitOrd,
                                                              0);

      if nvl(nuContractId, -1) <> nuContractConn then
        Return - 1;
      else
        Return nvl(nuvalor, 0);
      end if;

    end if;

    Return nvl(nuvalor, 0);

    ut_trace.Trace('FIN Ld_BcNonBankFinancing.fnuDatosEntr', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
    when no_data_found then
      return 0;
    when others then
      return 0;
  END fnuDatosLiq;

  /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnuDatosEntr
      Descripcion    : Indica el diferido
      Autor          : Evelio Sanjuanelo
      Fecha          : 26/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id      paquete
      inuarticle         articulo
      inuopcion          0) comodin futuras consulta.
      Historia de Modificaciones
      Fecha                 Autor                   Modificacion
      =========             ===========             ====================
  ******************************************************************/

  FUNCTION fnuDatosEntr(inuOrderActivitySale in OR_order_activity.order_activity_id%type)

   RETURN number

   IS
    nuvalor number;

    nuResult number := null;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcNonBankFinancing.fnuDatosEntr', 10);

    select distinct l.difecodi
      INTO nuvalor
      from or_order_activity o, ld_item_work_order l
     where o.origin_activity_id = inuOrderActivitySale
       and activity_id =
           dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
       and o.order_activity_id = l.order_activity_id
       and daor_order.fnugetorder_status_id(o.order_id, 0) = 8
       and dage_causal.fnuGetClass_Causal_Id(daor_order.fnugetcausal_id(o.order_id,
                                                                        0),
                                             0) = 1
       and l.difecodi is not null;

    if nuValor IS not null then
      if pktbldiferido.fblexist(nuValor) then
        nuResult := nuValor;
      END if;
    END if;

    ut_trace.Trace('FIN Ld_BcNonBankFinancing.fnuDatosEntr', 10);

    return nuResult;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return null;
    when no_data_found then
      return null;
    when others then
      return null;
  END fnuDatosEntr;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbDatosEntr
  Descripcion    : Indica el estado de la ot de entrega
  Autor          : Evelio Sanjuanelo
  Fecha          : 26/06/2013

  Parametros       Descripcion
  ============     ===================
  inupackage_id      paquete
  inuarticle         articulo
  inuopcion          0) comodin futuras consulta.
  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========     ===========         ====================
  04-09-2013    mmira.SAO214290     Se elimina condici?n de cantidad de legalizaci?n, ya que solo
                                    aplica para el estado Entregado.
  03-09-2013    mmira.SAO213451     Se modifica para referenciar correctamente el estado
                                    "Aprobaci?n" (PA en lugar de AP).
                                    Se modifica para retornar estado Entregado si la orden fue legalizada
                                    con cantidad mayor que cero.
                                    Se elimina el par?metro inuopcion porque no est? siendo usado.
  ******************************************************************/

  FUNCTION fsbDatosEntr(inuOrderActivitySale in OR_order_activity.order_activity_id%type)
    RETURN VARCHAR2 IS

    sbStatusArticle varchar2(100);
    CURSOR cuGetState IS
      SELECT decode(o.status, 'F', 'Entregado', 'Registrado') estado
        FROM or_order_activity o, ld_item_work_order l
      /*+ LD_BOQueryFNB.fsbDatosEntr */
       WHERE o.origin_activity_id = inuOrderActivitySale
         AND o.activity_id =
             dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
         AND o.order_activity_id = l.order_activity_id
         AND rownum = 1;

  BEGIN

    ut_trace.Trace('INICIO LD_BOQueryFNB.fsbDatosEntr', 10);

    sbStatusArticle := 'Registrado';

    for rc in cuGetState loop
      sbStatusArticle := rc.estado;
    END loop;

    ut_trace.Trace('FIN LD_BOQueryFNB.fsbDatosEntr', 10);

    return nvl(sbStatusArticle, 'Registrado');

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 'Error ' || sqlerrm;
    when no_data_found then
      return 'Error ' || sqlerrm;
    when others then
      return 'Error ' || sqlerrm;
  END fsbDatosEntr;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : frfGetSaleFNBInfo
  Descripcion    : Obtiene la informacion de solicitud de venta

  Autor          : Daniel Valiente
  Fecha          : 19/10/2012

  Parametros              Descripcion
  ============         ===================
  inufindvalue:       Numero de la solicitud.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23-08-2019      Cambio 75           Se modifica formula para obtener el valor total.
  20-01-2015      KCienfuegos.ARA5737 Se modifica para obtener la fecha de entrega del objeto de venta.
  15-11-2013      hjgomez.SAO223412   Se modifica el valor de la venta multiplicando el iva por la cantidad
  04-09-2013      jaricapa.SAO214357  Se agregan ?ndices
  ******************************************************************/
  FUNCTION frfGetSaleFNBInfo(inufindvalue in ld_non_ban_fi_item.NON_BA_FI_REQU_ID%type)
    RETURN tyRefCursor IS
    rfQuery             tyRefCursor;
    nuFlagApproved      number;
    sbFlagApproved      varchar2(20) := 'S?';
    sbResultConsultDesc ld_consult_codes.description%type;
    sbResultConsultId   ld_consult_codes.consult_codes_id%type;
    nuOperatingUnit     or_operating_unit.operating_unit_id%type;
    rcOperatingUnit     daor_operating_unit.styOR_operating_unit;
    nuOperClassif       or_oper_unit_classif.oper_unit_classif_id%type;
    nuClassSuppl        or_oper_unit_classif.oper_unit_classif_id%type;
    nuClassContract     or_operating_unit.oper_unit_classif_id%type;

    CURSOR cuGetunitBySeller IS
      SELECT organizat_area_id
        FROM cc_orga_area_seller
       WHERE person_id = GE_BOPersonal.fnuGetPersonId
         AND IS_current = 'Y'
         AND rownum = 1;

  BEGIN
    SELECT count(1)
      INTO nuFlagApproved
      FROM ld_approve_sales_order
     WHERE PACKAGE_id = inufindvalue
       AND approved = 'P';

    nuClassSuppl    := DALD_PARAMETER.fnuGetNumeric_Value('SUPPLIER_FNB');
    nuClassContract := DALD_PARAMETER.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB');

    --Obtiene la unidad operativa conectada
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperatingUnit;
    close cuGetunitBySeller;

    --Obtiene la clasificaci?n de la UT
    nuOperClassif := daor_operating_unit.fnugetoper_unit_classif_id(nuOperatingUnit);

    if nuFlagApproved = 0 then
      sbFlagApproved := 'No';
    END if;

    open rfQuery for
      SELECT
      /*+ use_nl(i)
            use_nl(r)
            use_nl(m)
            use_nl(a)
            index(MO_PACKAGES PK_MO_PACKAGES)
            index(LD_NON_BA_FI_REQU PK_LD_NON_BA_FI_REQU)
            index(LD_NON_BAN_FI_ITEM IX_LD_NON_BAN_FI_ITEM02)
            index(LD_ARTICLE PK_LD_ARTICLE)
            index(LD_NON_BAN_FI_ITEM IX_LD_NON_BAN_FI_ITEM02)
            leading(i,r,m,a)
      */
      --inicia pesta?a de datos b?sicos
       m.package_id solicitud, -- ? C?digo de la solicitud ok
       nvl(r.digital_prom_note_cons, r.manual_prom_note_cons) nuPagare, --codigo sol cr?dito --ok
       m.request_date fregistro, --?  Fecha de registro de la solicitud ok
       m.attention_date fatencion, -- ? Fecha de Atenci?n de la solicitud ok
       r.sale_date fventa, -- Fecha real de la venta --ok
       (select dd.deliver_date
          from ldc_fnb_deliver_date dd
         where dd.package_id = r.non_ba_fi_requ_id) dtDeliverDate, --Fecha de Entrega del objeto de Venta
       m.motive_status_id || ' - ' ||
       daps_motive_status.fsbgetdescription(m.motive_status_id, 0) estadosol, -- ? Estado de la solicitud ok
       daor_operating_unit.fnugetcontractor_id(m.operating_unit_id, 0) ||
       ' - ' || dage_contratista.fsbgetnombre_contratista(daor_operating_unit.fnugetcontractor_id(m.operating_unit_id,
                                                                                                  0),
                                                          0) contratista, --? Contratista vendedor --ok
       m.person_id || ' - ' || dage_person.fsbgetname_(m.person_id, 0) vendedor, -- ?  Vendedor ok
       m.Reception_Type_Id || ' - ' ||
       dage_reception_type.fsbGetDescription(m.Reception_Type_Id, 0) canal, -- ?  Canal de venta ok
       m.operating_unit_id || ' - ' ||
       daor_operating_unit.fsbGetName(m.operating_unit_id, 0) sucursal, --? Sucursal de la venta ok
       r.credit_quota cupoDisponible, -- ?  Cupo de disponible ok
       m.comment_ sbObservaciones, --?  Observaciones:  ok
       (select sum(i1.unit_value * i1.amount) + sum(nvl(vat, 0) * i1.amount)
          FROM ld_non_ban_fi_item i1
         WHERE i1.non_ba_fi_requ_id = i.non_ba_fi_requ_id) valorventa, --?  Valor de la venta ok
       nvl(r.payment, 0) InitQuota, -- Valor de la cuota inicial --ok
       sbFlagApproved flag_approval, --en proceso de aprobaci?n
       fsbGetDataCredResult(m.package_id, m.request_date) result_consult, -- Consulta de la solicitud en datacredito
       --Acaba pesta?a de datos b?sicos
       -------------------------------------------------------
       --------------------------------------------------------
       --inicia pesta?a de datos detalle
       a.article_id || ' - ' || a.description narticulo, --?  Art?culo vendido OK
       a.supplier_id || ' - ' ||
       dage_contratista.fsbGetNombre_Contratista(a.supplier_id, 0) nproveedor, --? Proveedor OK
       decode(ov.state,
              'PA',
              'Aprobaci?n',
              'EP',
              'En Proceso A/D',
              'AN',
              'Anulado',
              LD_BOQueryFNB.fsbDatosEntr(ov.order_activity_id)) EstEnt, --ESTADO DE LA ENTREGA OK
       daab_address.fsbGetAddress_Parsed(M.ADDRESS_ID, 0) direccion, --?  Direcci?n de entrega del art?culo OK
       NVL(ov.amount, 0) cantidad, --? Cantidad de art?culos vendidos OK
       NVL(ov.value, 0) valor, --?  Valor unitario del art?culo OK
       nvl(ov.iva, 0) iva, -- IVA ok
       -- Cambio 72, se modifica formula para calcular el ValTot, puesto que esta teniendo en cuenta el iva de manera unitaria y no x la cantidad
       --(NVL(ov.amount, 0) * NVL(ov.value, 0)) + nvl(ov.iva, 0) ValTot, --?  Valor total de los art?culos ok
       NVL(ov.amount, 0) * (NVL(ov.value, 0) + nvl(ov.iva, 0)) ValTot,
       nvl(a.warranty, 0) diasgarantia, --?  meses de garant?a del art?culo ok
       add_months(r.sale_date, nvl(a.warranty, 0)) fingarantia, --? Fecha final de garant?a ok
       nvl(ld_bcnonbankfinancing.fnuGetPorcInteres(pktblplandife.fnuGetPlditain(i.finan_plan_id,
                                                                                0)),
           0) tasainteres, --tasa interes ok
       i.quotas_number ncuotas, --? Numero de cuotas financiaci?n ok
       nvl(LD_BOQueryFNB.fnuDatosEntr(ov.order_activity_id), 0) nudife, --nudiferido
       decode(LD_BOQueryFNB.fnuDatosEntr(ov.order_activity_id),
              null,
              0,
              pktbldiferido.fnugetdifevatd(LD_BOQueryFNB.fnuDatosEntr(ov.order_activity_id),
                                           0)) valdife, --? Valor diferido ok*/
       a.concept_id || ' - ' ||
       pktblconcepto.fsbgetconcdesc(a.concept_id, 0) sbconcepto, --Concepto con el cual se carg? la deuda ok
       LD_BOQueryFNB.fnuDatosLiq(ov.order_activity_id, 2) ValComPagCon, --?  Valor de comisi?n pagada al contratista.
       LD_BOQueryFNB.fnuDatosLiq(ov.order_activity_id, 1) ValCobComPro, --? COBRO COMISI?N A PROVEEDOR
       LD_BOQUERYFNB.fnugetInvoice(ov.order_activity_id) Invoice,
       decode(r.delivery_point, 'Y', 'Si', 'No') EntrPunto,
       decode(r.trasfer_quota, 'Y', 'Si', 'No') TrasPunto,
       r.first_bill_id PrmPago,
       r.second_bill_id SegPago,
       (SELECT f.factfege FROM factura f WHERE f.factcodi = r.first_bill_id) dtPrmPago,
       (SELECT f.factfege FROM factura f WHERE f.factcodi = r.second_bill_id) dtSegPago,
       decode(r.digital_prom_note_cons, null, 'Impreso', 'Digital') TipoPagare
      --Acaba pesta?a de datos detalle
        FROM ld_non_ban_fi_item i,
             ld_non_ba_fi_requ  r,
             mo_packages        m,
             ld_article         a,
             OR_order_activity  oa,
             ld_item_work_order ov
      /*+ Ubicaci?n: LD_BOQueryFNB.frfGetSaleFNBInfo */
       WHERE i.non_ba_fi_requ_id = inufindvalue
         AND i.non_ba_fi_requ_id = r.non_ba_fi_requ_id
         AND m.package_id = r.non_ba_fi_requ_id
         AND a.article_id = i.article_id
         AND oa.motive_id(+) = i.non_ban_fi_item_id
         AND ov.order_activity_id = oa.order_activity_id
         AND oa.activity_id = ld_boconstans.cnuACTIVITY_TYPE_FNB;
    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfGetSaleFNBInfo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FtrfPromissory
  Descripcion    : Retorna los datos del deudor o codeudor.

  Autor          : Jorge Valiente
  Fecha          : 01/11/2012

  Parametros       Descripcion
  ============     ===================

  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  ******************************************************************/

  FUNCTION FtrfPromissory(nuPackageId in ld_promissory.package_id%type,
                          --sbPromissoryType in ld_promissory.promissory_type%type)
                          sbPromissoryTypeDebtor   in ld_promissory.promissory_type%type,
                          sbPromissoryTypeCosigner in ld_promissory.promissory_type%type)

   RETURN constants.tyRefCursor IS

    trfPromissory constants.tyRefCursor;
    nuDiasPagare  number;

  BEGIN

    ut_trace.trace('Inicio LD_BOQueryFNB.FtrfPromissory', 10);

    ut_trace.trace('Se obtiene par?metro DAYS_AVAILABLE_PAGARE', 10);

    nuDiasPagare := nvl(DALD_PARAMETER.FNUGETNUMERIC_VALUE('DAYS_AVAILABLE_PAGARE',
                                                           0),
                        0);

    ut_trace.trace('Valor de DAYS_AVAILABLE_PAGARE: ' || nuDiasPagare, 10);

    open trfPromissory for
      select promissory_id,
             holder_bill,
             debtorname || ' ' || last_name debtorname,
             identification,
             DAge_geogra_location.fsbGetDescription(forwardingplace) forwardingplace,
             forwardingdate,
             decode(gender, 'F', 'Femenino', 'Masculino') gender,
             dage_civil_state.fsbGetDescription(civil_state_id) civil_state_id,
             birthdaydate,
             dage_school_degree.fsbGetDescription(school_degree_) school_degree_,
             daab_address.fsbGetAddress(p.address_id, 0) address_id,
             (select ge_geogra_location.description
                from ab_address, ge_geogra_location
               where ab_address.address_id = p.address_id
                 and ab_address.neighborthood_id =
                     ge_geogra_location.geograp_location_id) neighborthood_id,
             (select ge_geogra_location.description
                from ab_address, ge_geogra_location
               where ab_address.address_id = p.address_id
                 and ab_address.geograp_location_id =
                     ge_geogra_location.geograp_location_id) city,
             (select ge_geogra_location.description
                from ge_geogra_location
               where geograp_location_id in
                     (select ge_geogra_location.geo_loca_father_id
                        from ab_address, ge_geogra_location
                       where ab_address.address_id = p.address_id
                         and ab_address.geograp_location_id =
                             ge_geogra_location.geograp_location_id)) department,
             propertyphone_id,
             dependentsnumber,
             DAGE_HOUSE_TYPE.fsbGetDescription(housingtype) housingtype,
             housingmonth,
             decode(holderrelation,
                    1,
                    'C?nyuge',
                    2,
                    'Hijo',
                    3,
                    'Padre/Madre',
                    4,
                    'Familiar',
                    5,
                    'Arrendatario',
                    6,
                    'Amigo',
                    'Otro') holderrelation,
             (select description
                from ge_profession
               where profession_id = to_number(occupation)) occupation,
             companyname,
             (select address
                from ab_address
               where ab_address.address_id = p.companyaddress_id) companyaddress_id,
             phone1_id,
             phone2_id,
             movilphone_id,
             oldlabor,
             activity,
             monthlyincome,
             expensesincome,
             commerreference,
             phonecommrefe,
             movilphocommrefe,
             daab_address.fsbGetAddress(addresscommrefe, 0) addresscommrefe,
             familiarreference,
             phonefamirefe,
             movilphofamirefe,
             daab_address.fsbGetAddress(addressfamirefe, 0) addressfamirefe,
             personalreference,
             phonepersrefe,
             movilphopersrefe,
             daab_address.fsbGetAddress(addresspersrefe, 0) addresspersrefe,
             email,
             package_id,
             promissory_type,
             (select digital_prom_note_cons
                from ld_non_ba_fi_requ t
               where non_ba_fi_requ_id = nuPackageId) digital_prom_note_cons,
             (select trunc(request_date)
                from mo_packages
               where package_id = nuPackageId) request_date,
             (select trunc(request_date) + 0
                from mo_packages
               where package_id = nuPackageId) effective_date,
             (select person_id
                from mo_packages
               where package_id = nuPackageId) person_id,
             (select payment
                from ld_non_ba_fi_requ
               where non_ba_fi_requ_id = nuPackageId) payment,
             (select subscriber_name || ' ' || subs_last_name
                from ge_subscriber
               where subscriber_id in
                     (select mo_packages.subscriber_id
                        from mo_packages
                       where mo_packages.package_id = nuPackageId)) subscriber_name,
             contract_type_id || ' - ' ||
             DECODE(contract_type_id,
                    1,
                    'Indefinido',
                    2,
                    'Temporal',
                    3,
                    'Fijo',
                    4,
                    'Otro') contract_type_id,
             (select catedesc from categori where catecodi = category_id) categoria,
             (select sucadesc
                from subcateg
               where sucacate = category_id
                 and sucacodi = subcategory_id) subcategoria,
             (select description
                from ge_identifica_type
               where ge_identifica_type.ident_type_id = p.ident_type_id) ident_type_id
        from ld_promissory p
       where p.package_id = nuPackageId
         and p.promissory_type = sbPromissoryTypeDebtor;

    ut_trace.trace('Fin LD_BOQueryFNB.FtrfPromissory', 10);

    RETURN trfPromissory;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FtrfPromissory;

  --datos de la venta
  FUNCTION FtrfdATOSPromissory(nuPackageId              in ld_promissory.package_id%type,
                               sbPromissoryTypeDebtor   in ld_promissory.promissory_type%type,
                               sbPromissoryTypeCosigner in ld_promissory.promissory_type%type)

   RETURN constants.tyRefCursor IS

    trfPromissory constants.tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LD_BOQueryFNB.FtrfdATOSPromissory', 10);

    open trfPromissory for
      select expensesincome, -- gasto mensual
             contract_type_id || '-' ||
             DECODE(contract_type_id,
                    1,
                    'Indefinido',
                    2,
                    'Temporal',
                    3,
                    'Fijo',
                    4,
                    'Otro') contract_type_id, --identificador del tipo de contrato
             holder_bill, --titular de la factura (y/n)
             promissory_type
        from ld_promissory
       where package_id = nuPackageId
         and promissory_type = sbPromissoryTypeDebtor
      UNION
      select expensesincome, -- gasto mensual
             contract_type_id || '-' ||
             DECODE(contract_type_id,
                    1,
                    'Indefinido',
                    2,
                    'Temporal',
                    3,
                    'Fijo',
                    4,
                    'Otro') contract_type_id, --identificador del tipo de contrato
             holder_bill, --titular de la factura (y/n)
             promissory_type
        from ld_promissory
       where package_id = nuPackageId
         and promissory_type = sbPromissoryTypeCosigner;

    ut_trace.trace('Fin LD_BOQueryFNB.FtrfdATOSPromissory', 10);

    RETURN trfPromissory;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FtrfdATOSPromissory;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  fnugetCededValToSubsc
  Descripcion :  Obtiene el valor de cupo que una suscripci?n le cedi? a otra

  Autor       :  Luis E. Fern?ndez
  Fecha       :  21-12-2013
  Parametros  :

      inuSubscCeded       Susbcripci?n que cede
      inuSubscReceiv      Suscripci?n que recibe

  Historia de Modificaciones
  Fecha       Autor               Modificaci?n
  =========   =========           ====================
  21-12-2013  lfernandez.SAOLD_BOQUERYFNBx Creaci?n
  ***************************************************************/
  FUNCTION fnugetCededValToSubsc(inuSubscCeded  in suscripc.susccodi%type,
                                 inuQuotaTransf in ld_quota_transfer.quota_transfer_id%type)
    return number IS
    ------------------------------------------------------------------------
    --  Tipos
    ------------------------------------------------------------------------
    type tytbProcPackages IS table of varchar2(1) index BY varchar2(20);
    tbProcPackages tytbProcPackages;
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    nuValue      number := 0;
    nuIdx        binary_integer;
    nuIdxOrig    binary_integer;
    nuDefBalance diferido.difesape%type;
    nuAccBalance cuencobr.cucosacu%type;

    nuSaleRequest     mo_packages.package_id%type;
    nuNonLegOrders    ld_item_work_order.value%type;
    nuLegalOrders     ld_item_work_order.value%type;
    nuUsedQuota       ld_item_work_order.value%type;
    nuOriginUsedQuota ld_item_work_order.value%type;
    nuTransferQuota   ld_item_work_order.value%type;
    nuTotalSale       ld_item_work_order.value%type;

    nuOrigSubsc    ld_quota_transfer.origin_subscrip_id%type;
    nuDestSubsc    ld_quota_transfer.destiny_subscrip_id%type;
    tbSubscQuota   DALD_Quota_Transfer.tytbTrasnfer_Value;
    tbOrigTransfer DALD_Quota_transfer.tytbOrigin_Subscrip_Id;
    tbDestTransfer DALD_Quota_transfer.tytbLD_quota_transfer;
    -- constantes Sentencias Aecheverry
    csbAnull          Constant ld_item_work_order.state%type := 'AN';
    cnuRegisterStatus Constant OR_order_status.order_status_id%type := 0;
    cnuAssignStatus   Constant OR_order_status.order_status_id%type := 5;
    cnuCloseStatus    Constant OR_order_status.order_status_id%type := 8;
    cnuMotiveStatus   Constant ps_motive_status.motive_status_id%type := 13;

    tbPacksNoTransfer damo_packages.tytbPackage_id;

    ------------------------------------------------------------------------
    --  Cursores
    ------------------------------------------------------------------------
    CURSOR cuOrigTransfer(inuSubsc ld_quota_transfer.destiny_subscrip_id%type) IS
      SELECT distinct origin_subscrip_id
        FROM ld_quota_transfer
       WHERE destiny_subscrip_id = inuSubsc
         AND approved = LD_BOConstans.csbYesFlag;
    ------------------------------------------------------------------------
    CURSOR cuDestTransfer(inuSubsc ld_quota_transfer.origin_subscrip_id%type) IS
      SELECT t.*, t.rowid
        FROM ld_quota_transfer t
       WHERE t.origin_subscrip_id = inuSubsc
         AND t.approved = LD_BOConstans.fsbYesFlag
         AND t.trasnfer_value > 0
         AND exists (SELECT 1
                FROM ld_item_work_order l, OR_order_activity a
               WHERE a.order_activity_id = l.order_activity_id
                 AND a.package_id = t.package_id
                 AND l.state != 'AN')
       ORDER BY t.quota_transfer_id desc;
    ------------------------------------------------------------------------
    CURSOR cuDefBalance(inuSubsc diferido.difesusc%type) IS
      SELECT sum(difesape)
        FROM diferido, servsusc
       WHERE difenuse = sesunuse
         AND difesusc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm);
    ------------------------------------------------------------------------
    CURSOR cuAccBalance(inuSubsc servsusc.sesususc%type) IS
      SELECT sum(cucosacu)
        FROM cuencobr, servsusc
       WHERE cuconuse = sesunuse
         AND sesususc = inuSubsc
         AND sesuserv in (cnuProdTypeBrilla, cnuProdTypeBrillaProm);
    ------------------------------------------------------------------------
    CURSOR cuLegalOrders(inuSubsc suscripc.susccodi%type) IS
      SELECT sum((l.value + nvl(l.iva, 0)) * l.amount) Value_Item
        FROM or_order           o,
             ld_item_work_order l,
             or_order_activity  a,
             mo_packages        p
       WHERE o.order_Status_Id in
             (cnuRegisterStatus, cnuAssignStatus, cnuCloseStatus)
         AND a.subscription_id = inuSubsc
         AND o.order_id = a.order_id
         AND a.order_activity_id = l.order_activity_id
         AND a.package_id = p.package_id
         AND p.motive_status_id = cnuMotiveStatus
         AND l.state <> csbAnull
         AND a.activity_id = cnuSellAct;
    ------------------------------------------------------------------------
    CURSOR cuTotalSaleValue(inuPackage mo_packages.package_id%type) IS
      SELECT SUM((w.value + nvl(w.iva, 0)) * w.amount) value
        FROM ld_item_work_order w, or_order_activity oa
       WHERE w.order_activity_id = oa.order_activity_id
         AND oa.package_id = inuPackage
         AND oa.activity_id = cnuSellAct
         AND w.state != 'AN';
    ------------------------------------------------------------------------
    CURSOR cuSolWithoutTrans(inuSubsc ld_quota_transfer.origin_subscrip_id%type) IS
      SELECT unique a.package_id
        FROM OR_order_activity a, ld_item_work_order w
       WHERE a.subscription_id = inuSubsc
         AND w.ORDER_activity_id = a.ORDER_activity_id
         AND a.PACKAGE_id not in
             (SELECT t.package_id
                FROM ld_quota_transfer t
               WHERE t.origin_subscrip_id = inuSubsc
                 AND t.approved = LD_BOConstans.fsbYesFlag
                 AND t.trasnfer_value > 0
                 AND exists
               (SELECT 1
                        FROM ld_item_work_order l, OR_order_activity a
                       WHERE a.order_activity_id = l.order_activity_id
                         AND a.package_id = t.package_id
                         AND l.state != 'AN'))
         AND w.state != 'AN'
         AND w.difecodi IS not null;

  BEGIN
    ut_trace.trace('Consultando contrato: ' || inuSubscCeded, 2);

    --  Obtiene las suscripciones a las cuales le ha trasladado cupo
    open cuOrigTransfer(inuSubscCeded);
    fetch cuOrigTransfer bulk collect
      into tbOrigTransfer;
    close cuOrigTransfer;

    nuIdx := tbOrigTransfer.First;

    while (nuIdx is not null) loop

      --  Asigna la suscripci?n que recibe el cupo
      nuOrigSubsc := tbOrigTransfer(nuIdx);

      --  Limpia variables
      nuDefBalance   := 0;
      nuAccBalance   := 0;
      nuNonLegOrders := 0;
      nuLegalOrders  := 0;

      --  Obtiene el saldo diferido de la suscripci?n
      open cuDefBalance(nuOrigSubsc);
      fetch cuDefBalance
        INTO nuDefBalance;
      close cuDefBalance;

      --  Obtiene el saldo corriente de la suscripci?n
      open cuAccBalance(nuOrigSubsc);
      fetch cuAccBalance
        INTO nuAccBalance;
      close cuAccBalance;

      --  Obtiene el saldo de los art?culos en ?rdenes legalizadas
      open cuLegalOrders(nuOrigSubsc);
      fetch cuLegalOrders
        INTO nuLegalOrders;
      close cuLegalOrders;

      --  Asigna el cupo utilizado
      nuUsedQuota := nvl(nuDefBalance, 0) + nvl(nuAccBalance, 0) +
                     nvl(nuLegalOrders, 0);
      UT_Trace.Trace('Total de los saldos de contrato ' || nuOrigSubsc || ': ' ||
                     nuUsedQuota,
                     3);

      --  Si la suscripci?n origen tiene cupo utilizado
      if (nuUsedQuota > 0) then

        --  Inicializa varibles
        nuTransferQuota   := 0;
        nuOriginUsedQuota := 0;
        tbProcPackages.delete;

        --  Obtiene las suscripciones que le trasladaron a la suscripci?n origen
        open cuDestTransfer(nuOrigSubsc);
        fetch cuDestTransfer bulk collect
          INTO tbDestTransfer;
        close cuDestTransfer;
        UT_Trace.Trace('Traslados realizados a la suscripci?n: ' ||
                       tbDestTransfer.count,
                       3);

        nuIdxOrig := tbDestTransfer.First;

        --  Recorre las solicitudes para conocer el valor de la venta y
        --  el valor trasladado, y asi saber el cupo usado de la suscripci?n
        while (nuIdxOrig is not null) loop

          --  Asigna la solicitud
          nuSaleRequest := tbDestTransfer(nuIdxOrig).package_id;

          --  Si no se ha consultado la solicitud
          if (nuSaleRequest IS not null AND
             not tbProcPackages.exists(nuSaleRequest)) then

            ut_trace.trace('Solicitud: ' || nuSaleRequest, 4);

            --  Inicializa valor
            nuTotalSale := 0;

            --  Asigna solicitud procesada
            tbProcPackages(nuSaleRequest) := null;

            --  Obtiene el valor de la venta de la solicitud
            open cuTotalSaleValue(nuSaleRequest);
            fetch cuTotalSaleValue
              INTO nuTotalSale;
            close cuTotalSaleValue;

            ut_trace.trace('Total Venta: ' || nuTotalSale, 5);
            ut_trace.trace('Cuota inicial: ' ||
                           DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                           5);

            --  Aumenta el cupo usado de la solicitud origen
            nuOriginUsedQuota := nuOriginUsedQuota + nuTotalSale -
                                 nvl(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                                     0);

            ut_trace.trace('Cupo usado venta: ' || nuOriginUsedQuota, 5);

          end if;

          --  Acumula el cupo trasladado

          ut_trace.trace('Cupo trasladado solicitud: ' || tbDestTransfer(nuIdxOrig)
                         .trasnfer_value,
                         7);

          nuTransferQuota := nuTransferQuota + tbDestTransfer(nuIdxOrig)
                            .trasnfer_value;

          ut_trace.trace('Acumulado traslados: ' || nuTransferQuota, 7);

          nuIdxOrig := tbDestTransfer.Next(nuIdxOrig);

        end loop;

        nuIdxOrig := null;
        open cuSolWithoutTrans(nuOrigSubsc);
        fetch cuSolWithoutTrans bulk collect
          INTO tbPacksNoTransfer;
        close cuSolWithoutTrans;

        nuIdxOrig := tbPacksNoTransfer.First;
        while (nuIdxOrig is not null) loop

          nuSaleRequest := tbPacksNoTransfer(nuIdxOrig);
          --  Obtiene el valor de la venta de la solicitud
          open cuTotalSaleValue(nuSaleRequest);
          fetch cuTotalSaleValue
            INTO nuTotalSale;
          close cuTotalSaleValue;

          --  Aumenta el cupo usado de la solicitud origen
          nuOriginUsedQuota := nuOriginUsedQuota + nuTotalSale -
                               nvl(DALD_Non_Ba_Fi_Requ.fnuGetPayment(nuSaleRequest),
                                   0);
          ut_trace.trace('Solicitud[' || nuSaleRequest || ']Total Venta[' ||
                         nuTotalSale || ']Cupo usado venta: ' ||
                         nuOriginUsedQuota,
                         5);

          nuIdxOrig := tbPacksNoTransfer.next(nuIdxOrig);
        END loop;

        --  Asigna a la suscripci?n como cupo el valor de las ventas
        --  menos el cupo transferido
        tbSubscQuota(nuOrigSubsc) := nuOriginUsedQuota - nuTransferQuota;

        ut_trace.trace('Cupo propio ' || nuOrigSubsc || ': ' ||
                       tbSubscQuota(nuOrigSubsc),
                       4);
        ut_trace.trace('Deuda ' || nuOrigSubsc || ': ' || nuUsedQuota, 4);

        --  Disminuye la cuota usada, aplic?ndola a la sucripci?n origen
        --  primero y luego a las suscripciones que le trasladaron cupo
        if (nuUsedQuota > tbSubscQuota(nuOrigSubsc)) then

          --  Disminuye la cuota usada
          nuUsedQuota := nuUsedQuota - tbSubscQuota(nuOrigSubsc);

        else

          nuUsedQuota := 0;

        END if;

        ut_trace.trace('Deuda a repartir entre quienes trasladaron: ' ||
                       nuUsedQuota,
                       4);

        UT_Trace.Trace('Luego de aplicado el cupo utilizado sobre el cupo de la suscripci?n: ' ||
                       nuUsedQuota,
                       3);

        nuIdxOrig := tbDestTransfer.First;

        --  Mientras haya cuota usada
        while (nuIdxOrig is not null AND nuUsedQuota > 0) loop

          ut_trace.trace('Quien cede: ' || tbDestTransfer(nuIdxOrig)
                         .destiny_subscrip_id,
                         4);

          --  Asigna la suscripci?n destino
          nuDestSubsc := tbDestTransfer(nuIdxOrig).destiny_subscrip_id;

          --  Si la cuota usada es mayor al valor trasladado
          if (nuUsedQuota > tbDestTransfer(nuIdxOrig).trasnfer_value) then

            --  Disminuye la cuota usada
            nuUsedQuota := nuUsedQuota - tbDestTransfer(nuIdxOrig)
                          .trasnfer_value;

            --  Si la suscripci?n que cede es la misma enviada y el
            --  c?digo de la trabsferencia es el mismo al enviado
            if (inuSubscCeded = nuDestSubsc AND inuQuotaTransf = tbDestTransfer(nuIdxOrig)
               .quota_transfer_id) then
              --  Devuelve el valor cedido
              return tbDestTransfer(nuIdxOrig).trasnfer_value;
            end if;

          else

            if (inuQuotaTransf = tbDestTransfer(nuIdxOrig)
               .quota_transfer_id) then
              --  Devuelve el valor cedido como el saldo de la cuota
              return nuUsedQuota;
            end if;

            --  Disminuye la cuota usada
            nuUsedQuota := 0;
          END if;

          nuIdxOrig := tbDestTransfer.Next(nuIdxOrig);

        end loop;

      END if;

      nuIdx := tbOrigTransfer.Next(nuIdx);

    end loop;

    return nuValue;
  EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when OTHERS then
      Errors.SetError;
      raise ex.CONTROLLED_ERROR;
  END fnugetCededValToSubsc;

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              fsbGetDataCredResult

    Autor        Andr?s Felipe Esguerra Restrepo

    Fecha               03-06-2014

    Descripci?n         Obtiene el registro de datacr?dito con el cual se valid? que se pod?a
                        realizar la venta

    ***Parametros***
    Nombre        Descripci?n
    inuPackageId        ID de la solicitud
    idtRequestDate      Fecha de registro de la solicitud

    ***Historia de Modificaciones***
    Fecha Modificaci?n        Autor
    03-06-2014            aesguerra.3709
    Creaci?n
  ***********************************************************************/
  FUNCTION fsbGetDataCredResult(inuPackageId   in mo_packages.package_id%type,
                                idtRequestDate in ld_result_consult.consultation_date%type)
    RETURN varchar2 IS

    sbReturn varchar2(2000);

    CURSOR cuResultByPack(inuPackId in mo_packages.package_id%type) IS
      SELECT cc.consult_codes_id || ' - ' || cc.description
        FROM ld_result_consult rc, ld_consult_codes cc
       WHERE cc.consult_codes_id = rc.consult_codes_id
         AND rc.package_id = inuPackId;

    CURSOR cuResultByDate(inuPackId  in mo_packages.package_id%type,
                          idtReqDate in ld_result_consult.consultation_date%type) IS
      SELECT *
        FROM (SELECT cc.consult_codes_id || ' - ' || cc.description
                FROM ld_result_consult rc,
                     ld_consult_codes  cc,
                     ld_promissory     pr,
                     ld_document_type  dt
               WHERE cc.consult_codes_id = rc.consult_codes_id
                 AND rc.ident_type_id = dt.doc_type_datacred
                 AND pr.ident_type_id = dt.ident_type_id
                 AND rc.identification = pr.identification
                 AND pr.promissory_type = 'D'
                 AND pr.package_id = inuPackId
                 AND rc.consultation_date < idtReqDate
               ORDER BY rc.consultation_date desc)
       WHERE rownum = 1;

  BEGIN
    if cuResultByPack%isopen then
      close cuResultByPack;
    END if;

    open cuResultByPack(inuPackageId);
    fetch cuResultByPack
      INTO sbReturn;
    close cuResultByPack;

    if sbReturn IS null then
      if cuResultByDate%isopen then
        close cuResultByDate;
      END if;

      open cuResultByDate(inuPackageId, idtRequestDate);
      fetch cuResultByDate
        INTO sbReturn;
      close cuResultByDate;
    END if;

    return sbReturn;

  END fsbGetDataCredResult;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnugetInvoice
  Descripcion    : Obtiene la factura de la venta, para la orden de entrega.
  Autor          : KCienfuegos
  Fecha          : 13/01/2015

  Parametros       Descripcion
  ============     ===================
  inuOrder         C?digo de la orden.

  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========     ===========         ====================
  13-01-2015    KCienfuegos.RNP1224 Creaci?n.
  ******************************************************************/
  FUNCTION fnugetInvoice(inuOrderAct in OR_order_activity.Order_Activity_Id%type)
    RETURN VARCHAR2 IS

    sbInvoice ldc_invoice_fnb_sales.invoice%type;
    inuOrder  or_order.order_id%type;

    CURSOR cuGetDelOrder IS
      SELECT oa.order_id
        FROM or_order_activity oa
       WHERE oa.origin_activity_id = inuOrderAct
         AND oa.task_type_id =
             dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB');

    CURSOR cuGetInvoice IS
      SELECT inv.invoice
        FROM ldc_invoice_fnb_sales inv
      /*+ LD_BOQueryFNB.fnugetInvoice */
       WHERE inv.order_id = inuOrder;

  BEGIN

    ut_trace.Trace('INICIO LD_BOQueryFNB.fnugetInvoice', 10);

    /* Se obtiene la orden de entrega */
    open cuGetDelOrder;
    fetch cuGetDelOrder
      into inuOrder;
    close cuGetDelOrder;

    /* Se obtiene n?mero de factura*/
    open cuGetInvoice;
    fetch cuGetInvoice
      into sbInvoice;
    close cuGetInvoice;

    ut_trace.Trace('FIN LD_BOQueryFNB.fnugetInvoice', 10);

    return nvl(sbInvoice, 'N/A');

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 'Error ' || sqlerrm;
    when no_data_found then
      return 'Error ' || sqlerrm;
    when others then
      return 'Error ' || sqlerrm;
  END fnugetInvoice;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbInsuranceSale
  Descripcion    : Valida si el contrato es v?lido para la venta de seguro.
  Autor          : KCienfuegos
  Fecha          : 01/09/2015

  Parametros       Descripcion
  ============     ===================
  inuSuscription   C?digo del contrato

  Historia de Modificaciones
  Fecha         Autor               Modificaci?n
  =========     ===========         ====================
  19-09-2015    KCienfuegos.ARA8021 Se agrega el estado D-En Deuda, al cursor.
  01-09-2015    KCienfuegos.ARA8021 Creaci?n.
  ******************************************************************/
  FUNCTION fsbInsuranceSale(inuSuscription in suscripc.susccodi%type)
    RETURN VARCHAR2 IS

    sbInsuranceSale varchar2(2);
    nuCount         number := 0;

    CURSOR cuValidateInsuranceSale IS
      SELECT COUNT(1)
        FROM SERVSUSC G
       WHERE SESUSUSC = inuSuscription
         AND SESUESFN IN
             (pkBillConst.csbEST_AL_DIA, pkBillConst.csbEST_EN_DEUDA)
         AND SESUESCO =
             DALD_PARAMETER.fnuGetNumeric_Value('ESTA_CORT_PROD_CONEXION')
         AND SESUSERV = DALD_PARAMETER.fnuGetNumeric_Value('COD_SERV_GAS')
         AND NOT EXISTS
       (SELECT 1
                FROM SERVSUSC S
               WHERE S.SESUSUSC = G.SESUSUSC
                 AND SESUSERV =
                     DALD_PARAMETER.fnuGetNumeric_Value('COD_PRODUCT_TYPE'));

  BEGIN

    ut_trace.Trace('INICIO LD_BOQueryFNB.fsbInsuranceSale', 10);

    /* Se valida si aplica para venta de seguros */
    open cuValidateInsuranceSale;
    fetch cuValidateInsuranceSale
      into nuCount;
    close cuValidateInsuranceSale;

    if nuCount > 0 then
      sbInsuranceSale := 'SI';
    else
      sbInsuranceSale := 'NO';
    end if;

    ut_trace.Trace('FIN LD_BOQueryFNB.fsbInsuranceSale', 10);

    return nvl(sbInsuranceSale, 'N/A');

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 'Error ' || sqlerrm;
    when no_data_found then
      return 'Error ' || sqlerrm;
    when others then
      return 'Error ' || sqlerrm;
  END fsbInsuranceSale;

END LD_BOQueryFNB;
/
PROMPT Otorgando permisos de ejecucion a LD_BOQUERYFNB
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOQUERYFNB', 'ADM_PERSON');
END;
/