  CREATE OR REPLACE PACKAGE "OPEN"."LD_BOVISIT" IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Ld_BoSecureManagement
  Descripcion    : Paquete BO con las funciones y/o procedimientos que contendrá el manejo de solicitud de visita
  Autor          : aacuña
  Fecha          : 24/09/2012 SAO 159429

  Metodos

  Nombre         :
  Parametros         Descripción
  ============   ===================
  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas
  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO234804';
  -----------------------
  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  aacuña SAO 159429
  Fecha          :  24/09/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidShopkeeperChane
  Descripcion    : Valida que si se selecciono canal de venta tendero, se haya seleccionado tendero.
  Autor          : aacuña SAO 159429
  Fecha          : 24/09/2012

  Parametros             Descripción
  ============        ===================
  inuChanel :          Fecha de registro
  inushopkeeperChanel: Identificador del canal de venta tendero referente.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE ValidShopkeeperChane(inushopkeeper       in ld_shopkeeper.shopkeeper_id%type,
                                 inushopkeeperChanel in mo_packages.refer_mode_id%type);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidatevisitFNB
  Descripcion    : Valida la solicitud de visita
  Autor          : aacuña SAO 159429
  Fecha          : 24/09/2012

  Parametros             Descripción
  ============        ===================
  inuIdentification:  Número del suscriptor.
  inusubcri:          Identificación del cliente

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  =========   =========             ====================
  24/07/2013  Jcarmona.SAO212942    Se modifica para que cuando el contrato no tenga cupo
                                    se eleve un mensaje de advertencia y no un error que
                                    impida la ejecución del trámite
  ******************************************************************/

  PROCEDURE ValidateVisitFnb(inususc   in suscripc.susccodi%type,
                             inusubcri in ge_subscriber.subscriber_id%type);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValidCrossSale
    Descripcion    : Valida que si se selecciono el canal de venta cruzada
                     ,se registre una solicitud de visita
    Autor          : aacuña SAO 159429
    Fecha          : 24/09/2012

    Parametros              Descripción
    ============        ===================
    inuChanel           Medio de referencia
  inuChanelCrossSale    Código de

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

    ******************************************************************/

  PROCEDURE ValidCrossSale(inuChanel          in mo_packages.refer_mode_id%type,
                           inuChanelCrossSale in ld_sales_visit.visit_sale_cru_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidItem
  Descripcion    : Valida que no se ingrese un dato como null, si se ingresa
                   un dato como null retornara el valor (1) Sino retornara (Cero)
  Autor          : AAcuna SAO 159429
  Fecha          : 12/04/2013

  Parametros              Descripción
  ============        ===================
  inuItem_id     : Numero del articulo a validar si es ingresado como null


  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  FUNCTION ValidItem(inuItem_id in ld_sales_visit.item_id%type)

   RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcgetinfAddress
  Descripcion    : Obtiene la información de la dirección en cuanto
                  a la ubicación Geografica y la dirección parseada
                  para ingresarla a MO_address desde el trámite de
                  Solicitud a comunidades
  Autor          : Kbaquero SAO 159429
  Fecha          : 22/05/2012

  Parametros              Descripción
  ============        ===================
  inuabaddress:       Identificador de la dirección
  onugeoloca:         Identificador de la ubiocación Geografica.
  osbparsedad:        Descripción de la dirección.


  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE ProcgetinfAddress(inuabaddress ab_address.address_id%type,
                              onugeoloca   out ab_address.geograp_location_id%type,
                              osbparsedad  out ab_address.address_parsed%type);

 /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidatevisitFNBxml
  Descripcion    : Valida la solicitud de visita por XML
  Autor          : aacuña SAO 159429
  Fecha          : 08/07/2013

  Parametros            Descripción
  ============        ===================
  inususc:            número de identificación.
  inusubcri:          Identificador del cliente

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE ValidatevisitFNBxml(inususc   in suscripc.susccodi%type,
                             inusubcri in ge_subscriber.subscriber_id%type);

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ValVisitFNBByVisitType
    Descripcion :  Valida si existen órdenes de visita para la financiación no
                   bancaria teniendo en cuenta el tipo de visita seleccionado

    Autor       :  Jorge Alejandro Carmona Duque
    Fecha       :  25-09-2013
    Parametros  :

        inuSubscId      Suscripción
        inuClientId     Cliente
        inuVisitType    Tipo de Visita

    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    25-09-2013  JCarmona.SAO217872  Creación
    ***************************************************************/
    PROCEDURE ValVisitFNBByVisitType
    (
        inuSubscId      in suscripc.susccodi%type,
        inuClientId     in ge_subscriber.subscriber_id%type,
        inuVisitType    in ld_sales_visit.visit_type_id%type
    );

    /**************************************************************
        Propiedad intelectual de Open International Systems (c).
        Unidad      :  fnuGetProductsPerType
        Descripcion :  Indica si un contrato tiene o no un determinado tipo
                       de producto en estado activo.
                       1 - Tiene productos
                       0 - No tiene Productos

        Autor       :  jhagudelo
        Fecha       :  17/10/2013
        Parametros  :  inuContractId     Identificador del Contrato
                       inuProductType    Identificador del Tipo de Producto

        Historia de Modificaciones
        Fecha        Autor              Modificacion
        =========    =========          ====================

    ***************************************************************/
    FUNCTION fnuGetProductsPerType
    (
        inuContractId  in  suscripc.susccodi%TYPE,
        inuProductType in  pr_product.product_type_id%TYPE
    )
    RETURN number;

END Ld_BoVisit;
/
CREATE OR REPLACE PACKAGE BODY "OPEN"."LD_BOVISIT" IS
  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  aacuña SAO 159429
  Fecha          :  24/09/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('Ld_BoVisit.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidShopkeeperChane
  Descripcion    : Valida que si se selecciono canal de venta tendero, se haya seleccionado tendero.
  Autor          : kbaquero SAO 159429
  Fecha          : 25/09/2012

  Parametros             Descripción
  ============        ===================
  inuChanel :          Fecha de registro
  inushopkeeper:       Identificador del tendero
  inushopkeeperChanel: Identificador del canal de venta tendero referente.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE ValidShopkeeperChane(inushopkeeper       in ld_shopkeeper.shopkeeper_id%type,
                                 inushopkeeperChanel in mo_packages.refer_mode_id%type) IS

    /*Declaracion de variables numericas*/
    inurefemode mo_packages.refer_mode_id%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BoVisit.ValidShopkeeperChane', 10);

    if ((DALD_PARAMETER.fblexist(LD_BOConstans.cnurefermode))) then
      inurefemode := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnurefermode);
      if ((nvl(inurefemode, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then

        if (inushopkeeperChanel = inurefemode) then

          if (inushopkeeper is null) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'No se ha seleccionado tendero referente');
          end if;

        end if;
      else
         ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro medio de referencia tendero se encuentra en blanco');
      end if;
    end if;

    ut_trace.Trace('FIN Ld_BoVisit.ValidShopkeeperChane', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidShopkeeperChane;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ValVisitNonBankFinan
    Descripcion :  Valida si existen órdenes de visita para la financiación no
                   bancaria

    Autor       :  Luis E. Fernández
    Fecha       :  28-08-2013
    Parametros  :

        inuSubsc    Suscripción
        inuClient   Cliente

    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    28-08-2013  lfernandez.SAO211753 Creación
    ***************************************************************/
    PROCEDURE ValVisitNonBankFinan
    (
        inuSubsc    in suscripc.susccodi%type,
        inuClient   in ge_subscriber.subscriber_id%type
    )
    IS
        ------------------------------------------------------------------------
        --  Constantes
        ------------------------------------------------------------------------
        cnuPT_NBF_XML   constant ps_package_type.package_type_id%type := 100245;
        ------------------------------------------------------------------------
        --  Variables
        ------------------------------------------------------------------------
        nuQuant         number;
        nuStateProduct  number := -1;
        nuProdType      ld_parameter.numeric_value%type;
        nuPTNonBankFi   ld_parameter.numeric_value%type;
        nuPackStatus    ld_parameter.numeric_value%type;
    BEGIN

        /*se obtiene el valor de la constante del tipo de servicio*/
        nuProdType := LD_BOConstans.cnuGasService;

        if ( nvl( nuProdType, LD_BOConstans.cnuCero ) <> LD_BOConstans.cnuCero ) then

          /*Verifica si el producto de GAS se encuentra activo*/
          nuStateProduct := CC_BCReglasClasifica.fnuGetProductsPerType(
                                                                    inuSubsc,
                                                                    nuprodType );
          if (nuStateProduct <> 1) then

            ge_boerrors.seterrorcodeargument(
                ld_boconstans.cnuGeneric_Error,
                'Este suscriptor no tiene tipo de producto de gas activo');

          end if;

        end if;

        /*Verifica si existe una solicitud activa para este cliente*/
        if ( not DALD_PARAMETER.fblexist( LD_BOConstans.cnupackagestype ) ) then
            return;
        END if;

        nuPTNonBankFi := DALD_PARAMETER.fnuGetNumeric_Value(
                                            LD_BOConstans.cnupackagestype );
        nuPackStatus   := LD_BOConstans.cnuStapack;

        if ( nvl( nuPTNonBankFi, LD_BOConstans.cnuCero ) <>
             LD_BOConstans.cnuCero
        AND  nvl( nuPackStatus, LD_BOConstans.cnuCero ) <>
             LD_BOConstans.cnuCero )
        then

            --  Consulta las financiaciones no bancarias
            Ld_BcVisit.ProcSoliAct( inuSubsc,
                                    nuPTNonBankFi,
                                    nuPackStatus,
                                    nuQuant );

            if ( nuQuant <> LD_BOConstans.cnuCero_Value ) then

                ge_boerrors.seterrorcodeargument(
                    ld_boconstans.cnuGeneric_Error,
                    'Este suscriptor tiene solicitudes en estado registrado' );

            end if;

            --  Consulta las financiaciones no bancarias por xml
            Ld_BcVisit.ProcSoliAct( inuSubsc,
                                    cnuPT_NBF_XML,
                                    nuPackStatus,
                                    nuQuant );

            if ( nuQuant <> LD_BOConstans.cnuCero_Value ) then
                ge_boerrors.seterrorcodeargument(
                    ld_boconstans.cnuGeneric_Error,
                    'Este suscriptor tiene solicitudes en estado registrado' );

            end if;

        end if;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ValVisitNonBankFinan;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ValCategory
    Descripcion :  Valida la categoría

    Autor       :  Luis E. Fernández
    Fecha       :  28-08-2013
    Parametros  :

        inuSubsc    Suscripción

    Historia de Modificaciones
    Fecha       Autor                   Modificación
    =========   =========               ====================
    17-09-2013  mmira.SAO217217         Se modifica para obtener la cadena de categorías
                                        a partir del parámetro.
    28-08-2013  lfernandez.SAO211753    Creación
    ***************************************************************/
    PROCEDURE ValCategory
    (
        inuSubsc    in suscripc.susccodi%type
    )
    IS
        nuQuant     number;
        sbCate      ld_parameter.value_chain%type;
        nuProdType  ld_parameter.numeric_value%type;
    BEGIN

        /*se obtiene el valor de la constante del tipo de servicio*/
        nuProdType := LD_BOConstans.cnuGasService;


        sbCate := DALD_PARAMETER.fsbGetValue_Chain( LD_BOConstans.csbCodCategoryVisit );

        ut_trace.trace('Categorías: '||sbCate, 5);

        if ( sbCate IS not null )
        then

            Ld_BcVisit.ProcValCate( inuSubsc, sbCate, nuProdType, nuQuant );

            if ( nuQuant = LD_BOConstans.cnuCero ) then

                ge_boerrors.seterrorcodeargument(
                    ld_boconstans.cnuGeneric_Error,
                    'Este suscriptor no tiene categoría Residencial');

            end if;

        end if;


    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ValCategory;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidatevisitFNB
  Descripcion    : Valida la solicitud de visita
  Autor          : aacuña SAO 159429
  Fecha          : 24/09/2012

  Parametros            Descripción
  ============        ===================
  inususc:            número de identificación.
  inusubcri:          Identificador del cliente

  Historia de Modificaciones
  Fecha       Autor                 Modificacion
  =========   =========             ====================
  28-08-2013  lfernandez.SAO211753  Se llama a ValVisitNonBankFinan para que
                                    valide si existe financiación no bancaria
                                    normal y por xml
  24/07/2013  Jcarmona.SAO212942    Se modifica para que cuando el contrato no tenga cupo
                                    se eleve un mensaje de advertencia y no un error que
                                    impida la ejecución del trámite
  ******************************************************************/

  PROCEDURE ValidateVisitFnb
  (
    inususc   in suscripc.susccodi%type,
    inusubcri in ge_subscriber.subscriber_id%type
  )
  IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    onuBrillaQuota    number;
    onuQuoteUsed      number;
    onuQuoteAvailable number;
  BEGIN
    ut_trace.Trace('INICIO Ld_BoVisit.ValidateVisitFnb', 10);

    -- Valida si tiene solicitudes de visita
    -- ValVisitNonBankFinan( inususc, inusubcri );

    /*Si el contrato tiene cupo*/
     ld_bononbankfinancing.AllocateTotalQuota(inususc, onuBrillaQuota);
     onuQuoteUsed          := ld_bononbankfinancing.fnuGetUsedQuote(inususc);
     onuQuoteAvailable     := onuBrillaQuota - onuQuoteUsed;

    If onuQuoteAvailable = 0 then
        ge_boerrors.seterrorcodeargument( LD_BOConstans.cnuGeneric_Error_TipoM,
                                          'Este contrato no tiene cupo' );
    end if;

    --  Valida la categoría
    ValCategory( inususc );

    ut_trace.Trace('INICIO Ld_BoVisit.ValidateVisitFnb', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidatevisitFNB;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidCrossSale
  Descripcion    : Valida que si se selecciono el canal de venta cruzada
                   ,se registre una solicitud de visita
  Autor          : Kbaquero SAO 159429
  Fecha          : 24/09/2012

  Parametros              Descripción
  ============        ===================
  inuChanel:          Identificador del canal de venta.
  inuSalePackage:     Identificador de la solicitud de venta.
  inuChanelCrossSale: Identificador  la solicitud de venta cruzada.


  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE ValidCrossSale(inuChanel          in mo_packages.refer_mode_id%type,
                           inuChanelCrossSale in ld_sales_visit.visit_sale_cru_id%type) IS

    /*Declaración de variable numericas*/
    inurefemodev mo_packages.refer_mode_id%type;
    inupackageid mo_packages.package_type_id%type;
    onucant      number;

  BEGIN
    ut_trace.Trace('INICIO Ld_BoVisit.ValidCrossSale', 10);

     inurefemodev := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnurefermodecr);

      if ((nvl(inurefemodev, LD_BOConstans.cnuCero) <>
         LD_BOConstans.cnuCero)) then

        if (inuChanel = inurefemodev) then

          if (inuChanelCrossSale is null) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'No se ha ingresado la solicitud de venta cruzada');

          else

            inupackageid := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnupackagestype);

            if ((nvl(inupackageid, LD_BOConstans.cnuCero) <>
               LD_BOConstans.cnuCero)) then

              Ld_BcVisit.Procpackatype( inuChanelCrossSale,onucant);

              if (onucant = 0) then
                ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                                 'La solicitud de visita ingresada en el campo venta vruzada no existe');
              end if;
            end if;
          end if;
        end if;

      else
         ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro medio de referencia venta cruzada se encuentra en blanco');
      end if;


    ut_trace.Trace('FIN Ld_BoVisit.ValidCrossSale', 10);
    --    null;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidCrossSale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidItem
  Descripcion    : Valida que no se ingrese un dato como null, si se ingresa
                   un dato como null retornara el valor (1) Sino retornara (Cero)
  Autor          : AAcuna SAO 159429
  Fecha          : 12/04/2013

  Parametros              Descripción
  ============        ===================
  inuItem_id     : Numero del articulo a validar si es ingresado como null


  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  FUNCTION ValidItem(inuItem_id in ld_sales_visit.item_id%type)

   RETURN number

   IS

    /*Declaración de variable numericas*/
    nuVal number;

  BEGIN
    ut_trace.Trace('INICIO Ld_BoVisit.ValidItem', 10);

    /*Si el valor enviado es null retornara 1, informado que en el tramite
    se debe enviar el mensaje de que no se puede ingresar valores null, por
    lo tanto se debe realizar la configuracion de las lineas de producto/tipo poliza en
    caso contrario retornara cero*/

    if (inuItem_id is null) then

      nuVal := 1;

    else

      nuVal := 0;

    end if;

    return nuVal;

    ut_trace.Trace('FIN Ld_BoVisit.ValidItem', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidItem;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcgetinfAddress
  Descripcion    : Obtiene la información de la dirección en cuanto
                  a la ubicación Geografica y la dirección parseada
                  para ingresarla a MO_address desde el trámite de
                  Solicitud a comunidades
  Autor          : Kbaquero SAO 159429
  Fecha          : 22/05/2012

  Parametros              Descripción
  ============        ===================
  inuabaddress:       Identificador de la dirección
  onugeoloca:         Identificador de la ubiocación Geografica.
  osbparsedad:        Descripción de la dirección.


  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE ProcgetinfAddress(inuabaddress ab_address.address_id%type,
                              onugeoloca   out ab_address.geograp_location_id%type,
                              osbparsedad  out ab_address.address_parsed%type) IS

  BEGIN
    ut_trace.Trace('INICIO Ld_BoVisit.ProcgetinfAddress', 10);

    if inuabaddress is not null then
      onugeoloca  := daab_address.fnuGetGeograp_Location_Id(inuabaddress,
                                                            null);
      osbparsedad := daab_address.fsbGetAddress_Parsed(inuabaddress, null);

    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'Se debe colocar una dirección Válida');

    end if;

    ut_trace.Trace('FIN Ld_BoVisit.ProcgetinfAddress', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcgetinfAddress;

 /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidatevisitFNB
  Descripcion    : Valida la solicitud de visita
  Autor          : aacuña SAO 159429
  Fecha          : 24/09/2012

  Parametros            Descripción
  ============        ===================
  inususc:            número de identificación.
  inusubcri:          Identificador del cliente

  Historia de Modificaciones
  Fecha       Autor                 Modificacion
  =========   =========             ====================
  28-08-2013  lfernandez.SAO211753  Se llama a ValVisitNonBankFinan para que
                                    valide si existe financiación no bancaria
                                    normal y por xml
  ******************************************************************/

  PROCEDURE ValidatevisitFNBxml
  (
    inususc   in suscripc.susccodi%type,
    inusubcri in ge_subscriber.subscriber_id%type
  )
  IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    onuBrillaQuota    number;
    onuQuoteUsed      number;
    onuQuoteAvailable number;

  BEGIN
    ut_trace.Trace('INICIO Ld_BoVisit.ValidatevisitFNBxml', 10);

    -- Valida si tiene solicitudes de visita
    -- ValVisitNonBankFinan( inususc, inusubcri );

    /*Si el contrato tiene cupo*/
    --Se comenta validaciones de cupo, pues esta logica es manejada desde SB.
     --ld_bononbankfinancing.AllocateTotalQuota(inususc, onuBrillaQuota);
     --onuQuoteUsed          := ld_bononbankfinancing.fnuGetUsedQuote(inususc);
     --onuQuoteAvailable     := onuBrillaQuota - onuQuoteUsed;

    /*If onuQuoteAvailable <= 0 then
        ge_boerrors.seterrorcodeargument( ld_boconstans.cnuGeneric_Error,
                                          'Este contrato no tiene cupo' );
    end if;*/

    --  Valida la categoría
    ValCategory( inususc );

    ut_trace.Trace('INICIO Ld_BoVisit.ValidatevisitFNBxml', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidatevisitFNBxml;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ValVisitFNBByVisitType
    Descripcion :  Valida si existen órdenes de visita para la financiación no
                   bancaria teniendo en cuenta el tipo de visita seleccionado

    Autor       :  Jorge Alejandro Carmona Duque
    Fecha       :  25-09-2013
    Parametros  :

        inuSubscId      Suscripción
        inuClientId     Cliente
        inuVisitType    Tipo de Visita

    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    25-09-2013  JCarmona.SAO217872  Creación
    ***************************************************************/
    PROCEDURE ValVisitFNBByVisitType
    (
        inuSubscId      in suscripc.susccodi%type,
        inuClientId     in ge_subscriber.subscriber_id%type,
        inuVisitType    in ld_sales_visit.visit_type_id%type
    )
    IS
        ------------------------------------------------------------------------
        --  Constantes
        ------------------------------------------------------------------------
        cnuPT_NBF_XML   constant ps_package_type.package_type_id%type := 100245;
        ------------------------------------------------------------------------
        --  Variables
        ------------------------------------------------------------------------
        nuQuant         number;
        nuStateProduct  number := -1;
        nuProdType      ld_parameter.numeric_value%type;
        nuPTNonBankFi   ld_parameter.numeric_value%type;
        nuPackStatus    ld_parameter.numeric_value%type;
    BEGIN
        ut_trace.trace('BEGIN LD_BOVISIT.ValVisitFNBByVisitType',1);

        /*se obtiene el valor de la constante del tipo de servicio*/
        nuProdType := LD_BOConstans.cnuGasService;

        if ( nvl( nuProdType, LD_BOConstans.cnuCero ) <> LD_BOConstans.cnuCero ) then

          /*Verifica si el producto de GAS se encuentra activo*/
          nuStateProduct := fnuGetProductsPerType(
                                                  inuSubscId,
                                                  nuprodType );
          if (nuStateProduct <> 1) then

            ge_boerrors.seterrorcodeargument(
                ld_boconstans.cnuGeneric_Error,
                'Este contrato no tiene producto de gas activo');

          end if;

        end if;

        /*Verifica si existe una solicitud activa para este cliente*/
        if ( not DALD_PARAMETER.fblexist( LD_BOConstans.cnupackagestype ) ) then
            return;
        END if;

        nuPTNonBankFi := DALD_PARAMETER.fnuGetNumeric_Value(
                                            LD_BOConstans.cnupackagestype );
        nuPackStatus   := LD_BOConstans.cnuStapack;

        if ( nvl( nuPTNonBankFi, LD_BOConstans.cnuCero ) <>
             LD_BOConstans.cnuCero
        AND  nvl( nuPackStatus, LD_BOConstans.cnuCero ) <>
             LD_BOConstans.cnuCero )
        then

            --  Consulta las financiaciones no bancarias
            nuQuant := Ld_BcVisit.fnuGetQuantityVisitFNB
            (
                inuSubscId,
                nuPTNonBankFi,
                nuPackStatus,
                inuVisitType
            );

            if ( nuQuant <> LD_BOConstans.cnuCero_Value ) then

                ge_boerrors.seterrorcodeargument(
                    ld_boconstans.cnuGeneric_Error,
                    'Este suscriptor tiene solicitudes de Visita FNB en estado Registrado para el tipo de visita ['||inuVisitType||']');

            end if;

            --  Consulta las financiaciones no bancarias por xml
            nuQuant := Ld_BcVisit.fnuGetQuantityVisitFNB
            (
                inuSubscId,
                cnuPT_NBF_XML,
                nuPackStatus,
                inuVisitType
            );

            if ( nuQuant <> LD_BOConstans.cnuCero_Value ) then
                ge_boerrors.seterrorcodeargument(
                    ld_boconstans.cnuGeneric_Error,
                    'Este suscriptor tiene solicitudes de Visita FNB en estado Registrado para el tipo de visita ['||inuVisitType||']');

            end if;

        end if;

        ut_trace.trace('BEGIN LD_BOVISIT.ValVisitFNBByVisitType',1);
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ValVisitFNBByVisitType;


    /**************************************************************
        Propiedad intelectual de Open International Systems (c).
        Unidad      :  fnuGetProductsPerType
        Descripcion :  Indica si un contrato tiene o no un determinado tipo
                       de producto en estado activo.
                       1 - Tiene productos
                       0 - No tiene Productos

        Autor       :  jhagudelo
        Fecha       :  17/10/2013
        Parametros  :  inuContractId     Identificador del Contrato
                       inuProductType    Identificador del Tipo de Producto

        Historia de Modificaciones
        Fecha        Autor              Modificacion
        =========    =========          ====================

    ***************************************************************/
    FUNCTION fnuGetProductsPerType
    (
        inuContractId  in  suscripc.susccodi%TYPE,
        inuProductType in  pr_product.product_type_id%TYPE
    )
    RETURN number
    IS
        nuQuantity      number;
        CURSOR cuResult IS
            SELECT  1 exist_produc
            FROM    suscripc b, pr_product a, ps_product_status c
            WHERE   b.susccodi = inuContractId
            AND     a.subscription_id = b.susccodi
            AND     a.product_type_id = inuProductType
            AND     a.product_status_id = c.product_status_id
            AND     c.is_active_product = ge_boconstants.csbYES
            AND     rownum =1;
    BEGIN

        /* Se valida si el CURSOR está abierto. Si es así, lo cierra */
        if( cuResult%ISOPEN )then
            close cuResult;
        END if;

        /* Abre CURSOR, guarda resultado en nuQuantity, cierra
           CURSOR y retorna */
        OPEN cuResult;
        fetch cuResult INTO nuQuantity;
        close cuResult;
        return nvl(nuQuantity, 0);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuGetProductsPerType;

END Ld_BoVisit;
/