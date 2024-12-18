create or replace PACKAGE LD_BCSecureManagement IS
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BcSecureManagement
    Descripcion    : Paquete BC para el llamado de los procedimientos de busqueda validacion
                   y consulta de la gestion de seguros
    Autor          : aacu?a
    Fecha          : 14/08/2012 SAO 147879

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha            Autor          Modificacion
    ==========  =================   ====================
    24/10/2016  Kbaquero [CA 200-492] se adiciona <<FNUCUOTASPAGADASBS>>
    10-07-2015  mgarcia.SAO334174  Se modifica el metodo <<GetDepart>>
    24-02-2015  Llozada [NC 4038]  Se modifica el metodo <<FnuGetFessPaid>>
    22-01-2015  Llozada [NC 4038]  Se modifica el metodo <<FnuGetFessPaid>>
    03-12-2014  llarrarte.RQ1719    Se crea <fnuGetCollectiveNumber>
    20-10-2014  llarrarte.RQ1719    Se modifica <getPolByCollecAndProdLine>
                                    Se adiciona <fnuGetIdByPolicyNumber>
                                                <fnuGetBilledQuotas>
                                                <fnugetPendQuotas>
                                                <fblHasPendSales>
    08-10-2014  llarrarte.RQ2172    Se adicionan <cuLastPayAccountDate>
                                                 <cuPendBalance>
                                                 <frfGetPoliciesByAge>
                                                 <fnuGetExqPolciesBySuscripc>
                                                 <getPolByCollecAndProdLine>
                                                 <fnuGetCurrentBillByProduct>
                                                 <fnuGetPenDeferrQuot>
                                                 <GetPoliciesWithNoRenew>

    26-09-2014  llarrarte.RQ1719    Se adicionan <fnuGetCurrentPeriodBySuscripc>
                                                 <frfgetDeferredByFinan>
                                                 <fnuGetRenewPolicyByProduct>
    16-09-2014  llarrarte.RQ1178    Se adicionan <fnuGetPoliciesForTypeByCard>
                                                 <fnuGetPoliciesByCard>
                                                 <fnuGetPolciesByProductLine>
    28/08/2014  KCienfuegos.NC1177  Se crea el metodo <<GetSuscripPolicy>>
    04/08/2014  KCienfuegos.RNP550  Se crea el metodo <<GetNewPolicyType>>
    04/08/2014  KCienfuegos.RNP550  Se crea el metodo <<fblSamePolicyType>>
    04/08/2014  KCienfuegos.RNP550  Se crea el metodo <<fblPolicyTypeHasCateg>>
    24/07/2014  JCarmona.4218       Se modifican los metodos <<GetAddress>> y
                                    <<GetAddressBySusc>>
    27/06/2014  aesguerra.4029    Se crea el metodo <<fblHasDefDebt>>
    05-03-2014  hjgomez.SAO234798   Se modifica <<ProcPolicyBySysdate>>
    29-01-2014  AEcheverrySAO231292 Se modifican lo servicios
                                        <<GetAddressCancelByFile>>,
                                        <<GetAddressFromSinister>>, <<GetAddress>>
                                        <<GetAddressBySusc>> y <<ProcValProd>>
    19-12-2013  jrobayo.SAO228348   Se adiciona el metodo: <FnuGetFessPaid>
    27-11-2013  hjgomez.SAO224982   Se modifica <GetSecureInitialValue>
    22-11-2013  hjgomez.SAO224511   Se modifica <GetSecureInitialValue>
    07/09/2013  mmeusburgger.SAO214427 Se modifica el metodo:
                                         - <<fnuGetPolicyTypeByConf>>
                                         - <<SearchServPolicyState>>
    03/09/2013  jcarrillo.SAO214516     1 - Se adiciona el metodo
                                        >CreacionGetValuesPolicyByProd>
    06-09-2013  mmeusburgger.SAO214427  1 - Se adicionan los metodos
                                         <GetValidityPolicy><SearchServPolicyState>
                                         <ValidatePoliCancel>
    06/09/2013  jrobayo.SAO214422   1 - Se modiica el metodo:
                                        <GetSubscriberById>
    06/09/2013  mmira.SAO214195         1 - Se modifica <GetAddress> y <GetAddressBySusc>
    05/09/2013  mmeusburgger.SAO216329 1 - Se modifica <<GetSubscriberById>>
    04/09/2013  jcarrillo.SAO214549 1 - Se modifica el metodo:
                                        <GetPackageByPolSale>
    02/09/2013  jcarrillo.SAO211267 1 - Se adiciona el metodo:
                                        <GetOrderByActSubscrib>
                                        <GetOperatingUnit>
    31/08/2013  jcarrillo.SAO216037 1 - Se adiciona el metodo: <GetPolicysByVality>
    30/08/2013  jcarrillo.SAO213276 1 - Se modifica el metodo: <FnuGetValProd>
    27-08-2013  jcastro.SAO214742   1 - Se modifican los metodos:
                                        <ProcValidateClifin><ProcPolicyBySysdate>
                                        <GetValuePolicyType><GetPolicyType>
                                        <GetSecureInitialVal><GetpolitypeSecureInitialVal>
                                        <fdtfechendtypoli><GetSecureInitialValtipo>
    27-08-2013  jcarrillo.SAO214742 1 - Se adiciona el metodo:
                                        <GetValidityPolicyType><fdtfechendtypoli>
    ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas

  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  CURSOR cuLastPayAccountDate(inProductId in servsusc.sesunuse%type) is
    SELECT cucofeve
      FROM (SELECT cucofeve
              FROM cuencobr
             WHERE cuconuse = inProductId
               and cucosacu > 0
             ORDER BY cucofeve desc)
     WHERE rownum = 1;

  CURSOR cuPendBalance(inuProdutId in servsusc.sesunuse%type) IS
    SELECT nvl(sum(cucosacu), 0)
      FROM cuencobr
     WHERE cuconuse = inuProdutId
       AND cucosacu > 0;
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------
  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripcion
  Retorno        :
  csbVersion        Version del Paquete

  Autor          : aacu?a SAO 147879
  Fecha          : 20/09/2012

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetRenewPolicyByProduct
   Descripcion    : Obtiene la ultima poliza asociada al producto que se renovo
   Autor          : llarrarte
   Fecha          : 26-09-2014

   Parametros         Descripcion
   ============   ===================
   inuProductId   Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   26-09-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION fnuGetRenewPolicyByProduct(inuProductId in servsusc.sesunuse%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetCurrentPeriodBySuscripc
   Descripcion    : Obtiene el periodo de facturacion actual asociado a
                    una suscripcion
   Autor          : llarrarte
   Fecha          : 26-09-2014

   Parametros         Descripcion
   ============   ===================
   inuCardNumber: Numero de cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   26-09-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION fnuGetCurrentPeriodBySuscripc(inuSuscripc in suscripc.susccodi%type)
    return perifact.pefacodi%type;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : frfgetDeferredByFinan
   Descripcion    : Obtiene los diferidos asociados a una financiacion
   Autor          : llarrarte
   Fecha          : 26-09-2014

   Parametros         Descripcion
   ============   ===================
   inuCardNumber: Numero de cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   26-09-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION frfgetDeferredByFinan(inuFinanId in cc_financing_request.financing_id%type)
    return constants.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPoliciesByCard
   Descripcion    : Obtiene la cantidad de polizas activas
                    asociadas a una cedula
   Autor          : llarrarte
   Fecha          : 16-09-2014

   Parametros         Descripcion
   ============   ===================
   inuCardNumber: Numero de cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   16-09-2014  llarrarte.RQ1178    Creacion
  ******************************************************************/
  FUNCTION fnuGetPoliciesByCard(inuCardNumber in ld_policy.identification_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPoliciesForTypeByCard
   Descripcion    : Obtiene la cantidad de polizas activas de determinado tipo
                    asociadas a una cedula
   Autor          : llarrarte
   Fecha          : 16-09-2014


   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   16-09-2014  llarrarte.RQ1178           Creacion
  ******************************************************************/

  FUNCTION fnuGetPoliciesForTypeByCard(inuPolicyType in ld_policy_type.policy_type_id%type,
                                       inuCardNumber in ld_policy.identification_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPolciesByProductLine
   Descripcion    : Obtiene la cantidad de polizas activas correspondientes a una
                    linea de producto asociadas a una cedula
   Autor          : llarrarte
   Fecha          : 16-09-2014


   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   16-09-2014  llarrarte.RQ1178    Creacion
  ******************************************************************/
  FUNCTION fnuGetPolciesByProductLine(inuProductLine in ld_product_line.product_line_id%type,
                                      isbCardnumber  in ld_policy.identification_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchPolicy
  Descripcion    : Se genera un cursor referenciado con la informacion de la poliza.
  Autor          : AAcu?a
  Fecha          : 14/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc       Numero del contrato
  Orfsuscribypolicy  Cursor referenciado con los datos de la poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchPolicy(inuSuscripc       in suscripc.susccodi%type,
                             Orfsuscribypolicy out pkConstante.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchPolicyId
  Descripcion    : Busca las poliza dependiendo el codigo de la poliza
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
     inuPoli       Codigo de la poliza
  Orfsuscribypolicy  Cursor referenciado con los datos de la poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchPolicyId(inuPoli           in ld_policy.policy_id%type,
                               Orfsuscribypolicy out pkConstante.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPoly
  Descripcion    : Retorna la cantidad de cedula permitidas por tipo de poliza
                 teniendo en cuenta que el tipo de poliza se debe encontrar vigente
                 dependiendo la fecha de vigencia.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolyType:     Codigo del tipo de poliza
  onuCantId:     Cantidad de cedula por tipo de poliza que se encuentren vigentes.

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPoly(inuPolyType in ld_policy_type.policy_type_id%type,
                        onuCantId   out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValCantPoly
  Descripcion    : Retorna la cantidad de polizas por asegurado,dependiendo de la cedula
                 del asegurado y el contrato
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
      inuId:     Numero de identificacion
  inuSuscripc:     Suscripcion
  inuPolicyType:   Tipo de Poliza
   isbState:     Estado de la poliza
  onuCantId:     Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValCantPoly(inuId         in ge_subscriber.identification%type,
                            inuSuscripc   in suscripc.susccodi%type,
                            inuPolicyType in ld_policy.policy_type_id%type,
                            isbState      in ld_parameter.value_chain%type,
                            onuCantId     out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolyActi
  Descripcion    : Retorna 1 si la cedula tiene una poliza activa en otro contrato
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentase:     Numero de identificacion
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolyActi(inuIdentase in ld_policy.identification_id%type,
                            inuSuscripc in suscripc.susccodi%type,
                            isbState    in ld_parameter.value_chain%type,
                            onuValue    out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolyCont
  Descripcion    : Retorna la cantidad de polizas por suscritor
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolyCont(inuSuscripc in suscripc.susccodi%type,
                            isbState    in ld_parameter.value_chain%type,
                            onuValue    out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValBornDate
  Descripcion    : Valida que el suscritor no pase del parametro de la edad maxima y minima para tomar el seguro.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuValue:        Valor de retorno, edad del suscritor

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValBornDate(inuSuscripc in suscripc.susccodi%type,
                            onuValue    out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValidateClifin
  Descripcion    : Obtiene el valor de cuota de financiacion por suscritor.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValidateClifin(inuSuscripc in suscripc.susccodi%type,
                               onuValue    out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchDataProduct
  Descripcion    : Busca la informacion del contrato y producto
  Autor          : kBaquero
  Fecha          : 23/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuGas_Service:   Parametro del numero de servicio
  inuState:         Parametro del estado de la poliza
  otbAccountcharge: Objeto tipo tabla con los suscritores

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchDataProduct(inuGas_Service   in ld_parameter.value_chain%type,
                                  inuState         in ld_parameter.value_chain%type,
                                  otbAccountcharge out pktblservsusc.tySesunuse);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProduct
  Descripcion    : Busca los servicio suscrito cuya poliza tengan igual o mayor numero de
                 periodos vencidos
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuGas_Service:   Parametro del numero de servicio
  inuState:         Parametro del estado de la poliza
  otbAccountcharge: Objeto tipo tabla con los suscritores

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProduct(inuGas_Service   in ld_parameter.value_chain%type,
                              inuState         in ld_parameter.value_chain%type,
                              otbAccountcharge out pktblservsusc.tySesunuse);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchCharge
  Descripcion    : Verifica el numero de cuentas de cobro por facturacion que se debe por ese
                 servicio de seguro y que las cuentas de cobro esten vencidas.
  Autor          : AAcu?a
  Fecha          : 14/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuServSusc:     Numero de servicio de suscripcion
  inuFactProg:     Parametro del programa de FGCC
  onuCuenCobr:     Valor de retorno,con las cuentas de cobros vencidas por servicio suscrito

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchCharge(inuServSusc in servsusc.sesunuse%type,
                             inuFactProg in ld_parameter.value_chain%type,
                             onuCuenCobr out number);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchPolicyState
  Descripcion    :  Busca todas las polizas en estado ?"Activa" o "Inactiva" dependiendo de
                 la fecha de crecion
  Autor          : kbaquero
  Fecha          : 23/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuState:        Estado de la poliza
  orfPolicy:       Cursor con las polizas que tengan estado activo e inactivo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchPolicyState(inuState  in ld_parameter.value_chain%type,
                                  orfPolicy out pkConstante.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchServPolicyState
  Descripcion    : Dependiendo el servicio busca todas las polizas en estado ?"Activa" o "Inactiva"
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuServSusc:     Servicio suscrito
  inuState:        Estado de la poliza
  orfPolicy:       Cursor con las polizas que tengan estado activo e inactivo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchServPolicyState(inuServSusc in servsusc.sesunuse%type,
                                      inuState    in ld_parameter.value_chain%type,
                                      orfPolicy   out pkConstante.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearDeferred
  Descripcion    : Selecciona los diferidos de un producto que tengan saldo registrado
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuServSusc:     Numero del servicio suscrito
  orfDife:         Cursor con los diferidos que tengan saldo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearDeferred(inuServSusc in servsusc.sesunuse%type,
                             orfDife     out pkConstante.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProd
  Descripcion    : Retorna la categoria y subcategoria a partir de que el contrato tenga un producto de gas activo y ademas que
                 la categoria y subcategoria sea de tipo residencial o comercial.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros          Descripcion
  ============     ==================
  inuSusc:         Numero de suscripcion
  inuGas_Service:  Parametro del servicio de gas
  isbCate :        Parametro de las categorias permitidas
  onuCate:         Parametro de la categoria permitida
  onuSubcate:      Valor de retorno del estado del producto

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValProd(inuSusc        in suscripc.susccodi%type,
                        isbCate        in ld_parameter.value_chain%type,
                        inuGas_Service in ld_parameter.numeric_value%type,
                        onuCategori    out categori.catecodi%type,
                        onuSubcate     out subcateg.sucacodi%type);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del mismo tipo de
  Autor          : kbaquero
  Fecha          : 26/09/2012 SAO 159429

  Parametros         Descripcion
  ============   ===================
  inuSusc:       Numero del suscritoR
  inuMotype:     Codigo del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliAct(inuSusc     in servsusc.sesususc%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Procpackatype
  Descripcion    : Selecciona el tipo de paquete de una solicitud dependiendo del
                 suscriptor
  Autor          : kbaquero
  Fecha          : 27/09/2012 SAO 159429

  Parametros         Descripcion
  ============   ===================
  inupacktype:         Codigo Tipo de paquete
  inuChanelCrossSale:   Codigo de la venta que se ingresa
  onucant:             Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE Procpackatype(inupacktype        in pr_product.product_type_id%type,
                          inuChanelCrossSale in ld_sales_visit.visit_sale_cru_id%type,
                          onucant            out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcDataPolicy
  Descripcion    : Se obtiene datos de la poliza para el tramite de cancelacion.
  Autor          : kbaquero
  Fecha          : 04/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPoli:         Numero de la poliza
  osbname:         Nombre del asegurado
  onuidenti:       Numero de identificacion del asegurado
  onucontr:        Aseguradora
  onuprodli:       Linea de Producto

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcDataPoli(inuPoli     in ld_policy.policy_id%type,
                         onupolitype Out ld_policy.policy_type_id%type,
                         onuValuep   Out ld_policy.value_policy%type,
                         onuPayFeed  Out diferido.difecupa%type,
                         onuNumDife  Out ld_policy.deferred_policy_id%type,
                         oNucontra   Out ld_policy.contratist_code%type,
                         ONuproline  Out ld_policy.product_line_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolyActiSusc
  Descripcion    : Obtiene si un suscriptor tiene una poliza activa
  Autor          : aacu?a
  Fecha          : 01/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolyActiSusc(inuSuscripc in suscripc.susccodi%type,
                                isbState    in ld_parameter.value_chain%type,
                                onuValue    out number);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcDateBirthSubs
  Descripcion    : Obtiene la fecha de nacimiento del dueno del contrato
  Autor          : AAcu?a
  Fecha          : 05/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuDate:         Fecha de nacimiento

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcDateBirthSubs(inuSuscripc in suscripc.susccodi%type,
                              onuDate     out date);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcDataPolicy
  Descripcion    : Se obtiene datos de la poliza para el tramite de cancelacion.
  Autor          : kbaquero
  Fecha          : 04/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPoli:         Numero de la poliza
  osbname:         Nombre del asegurado
  onuidenti:       Numero de identificacion del asegurado
  onucontr:        Aseguradora
  onuprodli:       Linea de Producto

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcDataPolicy(inuPoli   in ld_policy.policy_id%type,
                           osbname   Out ld_policy.name_insured%type,
                           onuidenti Out ld_policy.identification_id%type,
                           onucontr  Out ld_policy.contratist_code%type,
                           onuprodli Out ld_policy.product_line_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPackageByPolCan
  Descripcion    : Obtiene el numero del paquete a partir de la poliza
  Autor          : AAcuna
  Fecha          : 10/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:      Numero de la poliza
  onuValue:       Numero de paquete


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPackageByPolCan(inuPolicy in ld_policy.policy_id%type,
                               onuValue  out ld_secure_cancella.secure_cancella_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcPolicyBySysdate
  Descripcion    : Busca todas las polizas en estado ?"Activa" o "Inactiva" dependiendo
                 de la fecha final de vigencia
  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  isbState          Estado de polizas activas
  orfPolicy:       Cursor con las polizas que tengan estado activo y dependiendo la fecha final de vigencia

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcPolicyBySysdate(isbState  in ld_parameter.value_chain%type,
                                orfPolicy out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcProductOrder
  Descripcion    : Retorna el identificador del producto a partir de una orden

  Autor          : Kbaquero
  Fecha          : 07/11/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuorder:       Identificador de la orden
  onuproduct:     Identificador del producto
  onupack         Numero de la orden
  onuactiCP       Actividad de la orden

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcProductOrder(inuorder   in or_order.order_id%type,
                             onuproduct out or_order_activity.product_id%type,
                             onupack    out or_order_activity.package_id%type,
                             onuactiCP  out or_order_activity.activity_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPolicyType
  Descripcion    : Retorna 1 si la fecha del sistema se encuentra entre el rango
                 de fechas de inicio y fin

  Autor          : AAcuna
  Fecha          : 12/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicyType:  Numero del tipo de poliza
  onuValue:       Valor


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPolicyType(inuPolicyType in ld_policy_type.policy_type_id%type,
                          onuValue      out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddress
  Descripcion    : Obtiene la direccion parseada de ab_address
  Autor          : AAcuna
  Fecha          : 16/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:      Numero del suscritor
  onuValue:         Direccion


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetAddress(inuSuscripc in suscripc.susccodi%type,
                       onuValue    out ab_address.address%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValAddressBySusc
  Descripcion    : Valida que la direccion del contrato exista
  Autor          : AAcuna
  Fecha          : 17/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:      Numero del suscritor
  onuValue:         Valor de retorno


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValAddressBySusc(inuSuscripc in suscripc.susccodi%type,
                                 onuValue    out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPackageSale
  Descripcion    : Retorna el numero del paquete a partir del numero de la poliza de venta

  Autor          : AAcuna
  Fecha          : 12/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPackage      Numero de solicitud de venta
  inuPolicy:      Numero de la poliza
  onuPackage:     Paquete


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPackageSale(inuPackage in mo_packages.package_id%type,
                           inuPolicy  in ld_policy.policy_id%type,
                           onuPackage out mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetProductPolicy
  Descripcion    : Retorna el numero del paquete a partir del numero de la poliza de venta

  Autor          : AAcuna
  Fecha          : 12/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Numero de la poliza
  onuProduct:      Numero del producto


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetProductPolicy(inuPolicy  in ld_policy.policy_id%type,
                             onuProduct out servsusc.sesunuse%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetDefferedByPol
  Descripcion    : Retorna el numero del diferido

  Autor          : AAcuna
  Fecha          : 26/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuProductId:    Identificador del Producto
  onuDeffered:     Numero del diferido


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  17/10/2013      JCarmona.SAO220105  Se modifica la sentencia para que busque por
                                      el identificador del producto y no de la poliza.
  31/10/2013      Jhagudelo.SAO222017 Se modifica la sentencia para que busque por
                                      el id de la poliza.
  ******************************************************************/

  PROCEDURE GetDefferedByPol(inuProductId in ld_policy.product_id%type,
                             inuPolicy    in ld_policy.policy_number%type,
                             onuDeffered  out diferido.difecodi%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberById
  Descripcion    : Obtiene el subscriber a partir de la cedula
  Autor          : AAcuna
  Fecha          : 03/10/2012 SAO 147879

  Parametros               Descripcion
  ============        ===================
  isbIdentification:    Numero de identificacion
  onuSubscriber:        Codigo del subscriber

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetSubscriberById(isbIdentification in ge_subscriber.identification%type,
                              onuSubscriber     out ge_subscriber.subscriber_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPackageByPolSale
  Descripcion    : Obtiene el numero del paquete de la venta a partir de la poliza
  Autor          : AAcuna
  Fecha          : 31/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:      Numero de la poliza
  onuPackage:       Numero de paquete


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPackageByPolSale(inuPolicy  in ld_policy.policy_id%type,
                                onuPackage out ld_secure_sale.secure_sale_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetServsPolicy
  Descripcion    : Retorna el numero de la poliza de  un servicio suscrito

  Autor          : kbaquero
  Fecha          : 31/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuservs:       Identificador del servicio suscrito
  onupoli:        Identificador Poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetServsPolicy(inuservs in servsusc.sesunuse%type,
                           inustate in ld_policy.policy_id%type,
                           onupoli  out ld_policy.policy_id%type);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPolicyCanBySusc
  Descripcion    : Retorna un dato mayor a cero si tiene una poliza asociada y en estado activa
                 sino retorna cero

  Autor          : AAcuna
  Fecha          : 02/11/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSusc:       Identificador del suscritor
  onuCant:       Cantidad de polizas asociadas

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPolicyCanBySusc(inuSusc  in suscripc.susccodi%type,
                               isbState in ld_parameter.value_chain%type,
                               onuCant  out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValuePolicyType
  Descripcion    : Obtiene el valor del tipo de poliza
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:       Numero de suscripcion
  onuValue:          Valor del tipo de poliza
  onuCoverage_Month  Meses de cobertura

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  PROCEDURE GetValuePolicyType(inutPolicyType    in ld_policy_type.policy_type_id%type,
                               idtRequestDate    in mo_packages.request_date%type,
                               onuValue          out ld_validity_policy_type.policy_value%type,
                               onuCoverage_Month out ld_validity_policy_type.coverage_month%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicyType
  Descripcion    : Obtiene la vigencia para el tipo de poliza
  ******************************************************************/
  PROCEDURE GetValidityPolicyType(inutPolicyType    in ld_policy_type.policy_type_id%type,
                                  idtRequestDate    in mo_packages.request_date%type,
                                  onuValidityPolTyp out ld_validity_policy_type.validity_policy_type_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetStateProdSal
  Descripcion    : Retorna (1) Si el estado del tipo de producto gas asociado al contrato
                 es igual al los estados configurados para los productos de venta de seguros,
                 en caso contrario retorna cero(0).
  Autor          : AAcu?a
  Fecha          : 10/05/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc    : Numero del contrato
  isbStateProd   : Estado del producto de venta de seguros
  nuStateProdG   : Estado del tipo de producto gas

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  10/05/2013     AAcuna     Creacion
  ******************************************************************/

  FUNCTION GetStateProdSal(inuSuscripc  in suscripc.susccodi%type,
                           isbStateProd in ld_parameter.value_chain%type,
                           nuStateProdG in ld_parameter.numeric_value%type)

   RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSecureInitialValue
  Descripcion    : Generacion de factura dependiendo si tiene un lanzamiento valido
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSusc:         Numero de suscripcion
  inuGas_Serv:     Parametro del servicio
  onuSesuCateg:    Categoria del servicio suscrito
  onuSesuSucat:    Subcategoria del servicio suscrito
  onuSesuEstco:    Estado de corte
  onuPrProduct:    Producto
  onuGeo_Loca:     Codigo de la ubicacion geografica

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetSecureInitialValue(inuSusc      in suscripc.susccodi%type,
                                  inuGas_Serv  in servicio.servcodi%type,
                                  onuSesuCateg out servsusc.sesucate%type,
                                  onuSesuSucat out servsusc.sesusuca%type,
                                  onuSesuEstco out servsusc.sesuesco%type,
                                  onuPrProduct out pr_product.product_status_id%type,
                                  onuGeo_Loca  out ge_geogra_location.geograp_location_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSecureInitialVal
  Descripcion    : Generacion de valor de la factura dependiendo del estado del producto,
                 categoria,subcategoria y estado de corte
  Autor          : AAcu?a
  Fecha          : 17/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSesuCateg:    Categoria del servicio suscrito
  inuSesuSucat:    Subcategoria del servicio suscrito
  inuSesuEstco:    Estado de corte
  inuPrProduct:    Producto
  inuGeo_Loca:     Codigo de la ubicacion geografica
  onuValue:        Valor con el resultado del cupon

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetSecureInitialVal(inuSesuCateg in servsusc.sesucate%type,
                                inuSesuSucat in servsusc.sesusuca%type,
                                inuSesuEstco in servsusc.sesuesco%type,
                                inuPrProduct in pr_product.product_status_id%type,
                                inuGeo_Loca  in ge_geogra_location.geograp_location_id%type,
                                onupremValue out ld_validity_policy_type.share_value%type,
                                onuValue     out ld_validity_policy_type.policy_value%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetContractorId
  Descripcion    : Obtiene el contratista de la persona conectada.
  Autor          : AAcu?a
  Fecha          : 07/05/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  07/05/2013     AAcuna     Creacion
  ******************************************************************/

  FUNCTION GetContractorId

   RETURN or_operating_unit.Contractor_Id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddressBySusc
  Descripcion    : Obtiene la direccion de contrato del suscritor
  Autor          : AAcuna
  Fecha          : 06/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:      Numero del suscritor
  onuValue:         Direccion
  onuGeo:           Ubicacion geografica


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetAddressBySusc(inuSuscripc in suscripc.susccodi%type,
                             onuValue    out ab_address.address_id%type,
                             onuGeo      out ge_geogra_location.geograp_location_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberBySusc
  Descripcion    : Obtiene el subscriber a partir del contrato
  Autor          : AAcuna
  Fecha          : 03/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetSubscriberBySusc(inuSuscripc in suscripc.susccodi%type,
                                onuValue    out ge_subscriber.subscriber_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuCuenCobr
  Descripcion    : Obtiene la ultima cuenta de cobro de un diferido
  Autor          : AAcuna
  Fecha          : 18/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inudifecodi      Identificador del diferido
  inuRaiseError    Controlador de error

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuCuenCobr(inudifecodi   in diferido.difecodi%type,
                       inuProductId  in cargos.cargnuse%type,
                       inuRaiseError in number default 1)

   RETURN cargos.cargcuco%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuDateInsured
  Descripcion    : Retorna la fecha de nacimiento del asegurado
  Autor          : AAcuna
  Fecha          : 12/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuDateInsured(inuPolicy ld_policy.policy_id%type)

   RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuDateFirstPol
  Descripcion    : Retorna la fecha en la que compro la primera poliza
  Autor          : AAcuna
  Fecha          : 12/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuDateFirstPol(inuIdentification ld_policy.identification_id%type,
                           inuProductLine    ld_policy.product_line_id%type)

   RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuValueRetPol
  Descripcion    : Retorna el valor de todas las polizas que fueron vendidas al momento en que la
                 edad del asegurado ya no lo  cobijaba
  Autor          : AAcuna
  Fecha          : 13/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentification: Numero de identificacion
  inuProductLine:    Linea de producto doble cupon
  inuDifDate:        Diferencia de edad


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuValueRetPol(inuIdentification ld_policy.identification_id%type,
                          inuProductLine    ld_policy.product_line_id%type,
                          inuDifDate        number)

   RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad : frfGetPoliTransferDebt
  Descripcion    : Retorna el valor de las polizas que fueron adquiridadas despues de la edad maxima para
                 coger un seguro
  Autor          : AAcuna
  Fecha          : 13/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentification:      Numero de identificacion
  inuProductLine:         Linea de producto doble cupon
  inuDifDate:             Diferencia de edad
  isbState:               Estado de la poliza cuando se encuentra activa

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION frfGetPoliTransferDebt(inuIdentification ld_policy.identification_id%type,
                                  inuProductLine    ld_policy.product_line_id%type,
                                  inuDifDate        number,
                                  isbState          in ld_parameter.value_chain%type)

   RETURN constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuValRetPol
  Descripcion    : Retorna el valor de las polizas que fueron adquiridadas despues de la edad maxima para
                 coger un seguro
  Autor          : AAcuna
  Fecha          : 13/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentification:      Numero de identificacion
  inuProductLine:         Linea de producto doble cupon
  inuDifDate:             Diferencia de edad

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuValRetPol(inuIdentification ld_policy.identification_id%type,
                        inuProductLine    ld_policy.product_line_id%type,
                        inuDifDate        number)

   RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuLiqType
  Descripcion    : Retorna el tipo de liquidacion dependiendo la causa de cancelacion
  Autor          : AAcuna
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuCancelCausa:      Causa de cancelacion
  inuProductLine:         Linea de producto doble cupon

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuLiqType(inuCancelCausa ld_cancel_causal.cancel_causal_id%type)

   RETURN ld_cancel_causal.liquidation_type_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad : frfGetOperating
  Descripcion : Retorna la unidad operativa que pertenece el tipo de poliza

  Autor : AAcuna
  Fecha : 27/03/2013

  Parametros       Descripcion
  ============  ===================
  inuPolicyType:  Tipo de poliza

  Historia de Modificaciones
  Fecha Autor Modificacion
  ========= ========= ====================

  ******************************************************************/
  FUNCTION frfGetOperating(inuPolicyType in ld_policy_type.policy_type_id%type)

   RETURN constants.tyrefcursor;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetPolbyRen
  Descripcion    : Retorna la primera de las polizas a partir de la solicitud
  de no renovacion
  Autor          : AAcuna
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripci?n
  ============   ===================
  inuPackage:     Solicutd de no renovacion


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuGetPolbyRen(inuPackage in mo_packages.package_id%type)
    RETURN ld_policy.policy_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetValProd
  Descripcion    : Retorna la cantidad de lineas de producto que tiene configurada
                 el contratista.
  de no renovacion
  Autor          : Kbaquero
  Fecha          : 16/05/2013 SAO 147879

  Parametros            Descripcion
  ============         ===================
  inuProductLine:      Lineas de producto
  inucontract:         Id. Contratista

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuGetValProd(isbProductLine in ps_pack_type_param.value%type,
                         inucontract    in ld_prod_line_ge_cont.contratistas_id%type)
    RETURN ld_prod_line_ge_cont.product_line_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetldPolicy
  Descripcion    : Retorna 1 si la fecha del sistema es igual o mayor a la fecha
                 final de la polza

  Autor          : Kbaquero
  Fecha          : 07/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Numero de la  poliza
  onuValue:         Valor


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetldPolicy(inuPolicy in ld_policy.policy_id%type,
                        onuValue  out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetpolitypeSecureInitialVal
  Descripcion    : Obtiene el tipo de poliza dependiende del valor y
                 las condiciones del cliente, para registrar la venta
  Autor          : Kbaquero
  Fecha          : 22/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSesuCateg:    Categoria del servicio suscrito
  inuSesuSucat:    Subcategoria del servicio suscrito
  inuSesuEstco:    Estado de corte
  inuPrProduct:    Producto
  inuGeo_Loca:     Codigo de la ubicacion geografica
  onuValue:        Valor con el resultado del cupon
  onupolitype:     Id. Tipo de poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  PROCEDURE GetpolitypeSecureInitialVal(inuSesuCateg   in servsusc.sesucate%type,
                                        inuSesuSucat   in servsusc.sesusuca%type,
                                        inuSesuEstco   in servsusc.sesuesco%type,
                                        inuPrProductST in pr_product.product_status_id%type,
                                        isbLocations   in varchar2,
                                        onupremValue   out ld_validity_policy_type.share_value%type,
                                        onuvalue       out ld_validity_policy_type.policy_value%type,
                                        onupolitype    out ld_policy_type.policy_type_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Fnunextldpolicy
  Descripcion    : Retorna el siguiente nuemero de la secuencia de
                 polizas
  Autor          : Kbaquero
  Fecha          : 22/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION Fnunextldpolicy

   RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fdtfechendtypoli
  Descripcion    : Retorna la fecha final con la que se creara las
                 polizas
  Autor          : Kbaquero
  Fecha          : 22/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inucovefech    Fecha de cobertura


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  FUNCTION fdtfechendtypoli(inuCoveFech    in ld_validity_policy_type.coverage_month%type,
                            idtInitialDate in ld_validity_policy_type.initial_date%type)
    RETURN date;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad : frfGetOperatingnorenew
  Descripcion : Retorna la unidad operativa que pertenece los tipos de poliza
                que se encuentran bajo la poliza
  Autor : Kbaquero
  Fecha : 26/06/2013

  Parametros       Descripcion
  ============  ===================
  inuPack:      Identificador del paquete

  Historia de Modificaciones
  Fecha Autor Modificacion
  ========= ========= ====================

  ******************************************************************/
  FUNCTION frfGetOperatingnorenew(inuPack in ld_policy_type.policy_type_id%type)

   RETURN constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Getcaussecure
  Descripcion    : Buscar la causal asociada a la solicitud de venta

  Autor          : Kbaquero
  Fecha          : 27/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Numero de la  poliza
  onuValue:         Valor


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE Getcaussecure(inuPack  in ld_secure_sale.secure_sale_id %type,
                          nucaus   in ld_secure_sale.causal_id%type,
                          onuvalue out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolycontrac
  Descripcion    : Retorna el tipo de poliza dependiendo del tipo
                 de poliza que envia la aseguradora en el archivo
                 plano.
  Autor          : Kbaquero
  Fecha          : 01/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolyType:     Codigo del tipo de poliza aseguradora
  onutipoli:      Codigo del tipo de poliza LDc.

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolycontrac(inuPolyType in ld_policy_type.contratist_code%type,
                               inuaseg     in ld_policy_type.contratista_id%type,
                               onutipoli   out ld_policy_type.policy_type_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetServsPolicyByStat
  Descripcion    : Retorna el numero de la poliza de  un servicio suscrito del estado consultado

  Autor          : sblanco
  Fecha          : 02/01/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuservs:       Identificador del servicio suscrito
  isbPolicyStatus Estados de la poliza
  onupoli:        Identificador Poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  PROCEDURE GetServsPolicyByStat(inuservs        in servsusc.sesunuse%type,
                                 isbPolicyStatus in varchar2,
                                 onupoli         out ld_policy.policy_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliActpoli
  Descripcion    : Valida que no exista solicitud activa del mismo tipo de
  Autor          : kbaquero
  Fecha          : 26/09/2012 SAO 159429

  Parametros         Descripcion
  ============   ===================
  inuSusc:       Numero del suscritoR
  inuMotype:     Codigo del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliActpoli(inuMotype   in pr_product.product_type_id%type,
                            inuEstapack in mo_packages.motive_status_id%type,
                            inupoli     in ld_policy.policy_id%type,
                            onucant     out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProdparam
  Descripcion    : Valida
  Autor          : AAcu?a
  Fecha          : 09/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Suscripcion
  inuprotype:
  isbState:     Estado de la poliza
  onuCantId:     Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValProdparam(inuSuscripc in suscripc.susccodi%type,
                             inuprotype  in pr_product.product_type_id%type,
                             isbState    in ld_parameter.value_chain%type,
                             onuCantId   out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidateProdEstacort
  Descripcion    : Valida que el contrato tenga gas en los estado
                   de corte permitido
  ******************************************************************/
  PROCEDURE ValidateProdEstacort(inuSuscripc in suscripc.susccodi%type,
                                 inuprotype  in pr_product.product_type_id%type,
                                 isbState    in ld_parameter.value_chain%type,
                                 onuCantId   out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProdparam
  Descripcion    : Valida
  Autor          : AAcu?a
  Fecha          : 09/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Suscripcion
  inuprotype:
  isbState:     Estado de la poliza
  onuCantId:     Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION fnuGetPolicyTypeByConf(isbproduct_line_id     in ld_parameter.value_chain%type,
                                  inucutting_state_id    in ld_launch.cutting_state_id%type,
                                  inuproduct_state       in ld_launch.product_state%type,
                                  inucategory_id         in ld_launch.category_id%type,
                                  inusubcategory_id      in ld_launch.subcategory_id%type,
                                  inugeograp_location_id in ld_launch.geograp_location_id %type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSecureInitialValtipo
  Descripcion    : Generacion de valor de la factura dependiendo del tipo de poliza encontrado
                 con la configuracion del lanzamiento
  Autor          : AAcu?a
  Fecha          : 17/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSesuCateg:    Categoria del servicio suscrito
  inuSesuSucat:    Subcategoria del servicio suscrito
  inuSesuEstco:    Estado de corte
  inuPrProduct:    Producto
  inuGeo_Loca:     Codigo de la ubicacion geografica
  onuValue:        Valor con el resultado del cupon

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  PROCEDURE GetSecureInitialValtipo(inutypoli    in ld_policy_type.policy_type_id%type,
                                    onupremValue out ld_validity_policy_type.share_value%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPolicysByVality
  Descripcion    : Obtienen las polizas dado una Vigencia
  ******************************************************************/
  PROCEDURE GetPolicysByVality(inuValPoliType in ld_validity_policy_type.validity_policy_type_id%type,
                               otbPolicys     out dald_policy.tytbLD_POLICY);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetOrderByActSubscrib
  Descripcion    : Obtienen la orden no finalizada dada la actividad  y el cliente
  ******************************************************************/
  PROCEDURE GetOrderByActSubscrib(inuSubscriber in ge_subscriber.subscriber_id%type,
                                  inuActVisit   in or_order_activity.activity_id%type,
                                  orcActOrder   out daor_order_activity.styOR_order_activity);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetOperatingUnit
  Descripcion    : Obtienen la unidad operativa dada el contratista
  ******************************************************************/
  PROCEDURE GetOperatingUnit(inuContrator in ge_contratista.id_contratista%type,
                             orcUnit      out daor_operating_unit.styor_operating_unit);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicy
  Descripcion    : Obtiene poliza activa para un tipo de poliza y subscripcion
  ******************************************************************/
  PROCEDURE GetValidityPolicy(inuSubscription   in suscripc.susccodi%type,
                              inuPolicyType     in ld_policy.policy_type_id%type,
                              idtDate           in ld_policy.dt_in_policy%type,
                              orfValidityPolicy out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicy
  Descripcion    : Obtiene polizas en estado activa y renovada
                   para un tipo de poliza y subscripcion
  ******************************************************************/
  PROCEDURE SearchServPolicyState(inuSubscription in suscripc.susccodi%type,
                                  inuPolicyType   in ld_policy.policy_type_id%type,
                                  orfPolicyState  out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicy
  Descripcion    : Obtiene polizas en estado activa y renovada
                   para un tipo de poliza y subscripcion
  ******************************************************************/
  FUNCTION ValidatePoliCancel(inuPolicyId in ld_policy.policy_id%type,
                              sbCausals   in ld_parameter.value_chain%type

                              ) return boolean;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValuesPolicyByProd
  Descripcion    : Obtiene el valor de todas las polizas del producto que
                   se encuentren en los estados activas y renovadas
  ******************************************************************/
  PROCEDURE GetValuesPolicyByProd(inuProduct     in ld_policy.product_id%type,
                                  onuTotalValues out number,
                                  onuTotalFees   out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetPackageCancel
  Descripcion    : Indica si la poliza registrada tiene una solicitud de cancelacion
                   en estado registrado
  de no renovacion
  Autor          : jrobayo
  Fecha          : 07/09/2013 SAO 147879

  Parametros         Descripci?n
  ============   ===================
  inuPolicy:     Poliza a verificar

  Historia de Modificaciones
  Fecha            Autor       Modificaci?n
  =========      =========  ====================
  ********************************************************************/

  FUNCTION fblGetPackageCancel(inuPolicy in ld_policy.policy_id%type)
    return boolean;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberId
  Descripcion    : Obtienen el id de un suscriptor dada su identificacion
  Autor          : jrobayo
  Fecha          : 24/10/2013

  Parametros         Descripcion
  ============   ===================
  isbIdentification    Identificacion del cliente
  orcIdSubscId         Id de cliente

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  24/10/2013  jrobayo.SAO221262 1 - Creacion
  ******************************************************************/

  PROCEDURE GetSubscriberId(isbIdentification in ge_subscriber.identification%type,
                            orcIdSubscId      out ge_subscriber.subscriber_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddressFromSinister
  Descripcion    : Obtiene la direccion parseada y la ubicacion
                   geografica de ab_address para el reporte de siniestros
  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 24/10/2013

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:        Numero del suscritor
  inuProductTypeId:   Tipo de Producto Registrado
  onuAddress:         Direccion Parseada
  onuParserAddress:   Identificador de la direccion
  onuGeo:             Ubicacion Geografica


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  24-10-2013      JCarmona.SAO221126      Creacion.
  ******************************************************************/

  PROCEDURE GetAddressFromSinister(inuSuscripc      in suscripc.susccodi%type,
                                   inuProductTypeId in mo_motive.product_type_id%type,
                                   onuAddress       out mo_address.address%type,
                                   onuParserAddress out mo_address.parser_address_id%type,
                                   onuGeograpLoc    out mo_address.geograp_location_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetLocalDepart
  Descripcion    : Retorna 1 si la localidad pertenece al departamento

  Autor          : jhagudelo
  Fecha          : 28/10/2013 SAO 221435

  Parametros         Descripcion
  ============   ===================
  inuLocalid:    Localidad
  inuDepart:     Departamento


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  ******************************************************************/
  FUNCTION GetLocalDepart(inuLocalid in ge_geogra_location.geograp_location_id%type,
                          inuDepart  in ge_geogra_location.geo_loca_father_id%type)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetDepart
  Descripcion    : Obtiene el departamento

  Autor          : jhagudelo
  Fecha          : 28/10/2013 SAO 221435

  Parametros         Descripcion
  ============   ===================
  inuDepart:     Departamento


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  ******************************************************************/
  FUNCTION GetDepart(inuDepart in ge_geogra_location.geo_loca_father_id%type)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProdLoc
  Descripcion    : Valida
  Autor          : jhagudelo
  Fecha          : 28/10/2013 SAO 221435

  Parametros         Descripcion
  ============   ===================
  inuProduct:    Suscripcion del producto


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  FUNCTION ProcValProdLoc(inuSuscrip in pr_product.subscription_id%type)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddressCancelByFile
  Descripcion    : Obtiene la direccion parseada y la ubicacion
                   geografica de ab_address para la cancelacion de seguros por
                   archivo plano
  Autor          : Jhonny Agudelo Oviedo
  Fecha          : 29/10/2013

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:        Numero del suscritor
  inuProductTypeId:   Tipo de Producto Registrado
  onuAddress:         Direccion Parseada
  onuParserAddress:   Identificador de la direccion
  onuGeo:             Ubicacion Geografica


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  29-10-2013      Jhagudelo.SAO221680     Creacion.
  ******************************************************************/

  PROCEDURE GetAddressCancelByFile(inuSuscripc  in suscripc.susccodi%type,
                                   onuValue     out ab_address.address_id%type,
                                   onuGeo       out ge_geogra_location.geograp_location_id%type,
                                   onAddrParsed out mo_address.address%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSolicNoRenewall
  Descripcion    : Identifica si una poliza tiene solicitudes de
                   no renovacion con orden en estado cerrado
  Autor          : Jhonny Agudelo Oviedo
  Fecha          : 31/10/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Id de la poliza


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  31-10-2013      Jhagudelo.SAO222017     Creacion.
  ******************************************************************/

  FUNCTION GetSolicNoRenewall(inuPolicy in ld_policy.policy_id%type)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSuscPol
  Descripcion    : Obtiene el contrato al cual se encuentra
                   asociado la poliza
  Autor          : Jhonny Agudelo Oviedo
  Fecha          : 01/11/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Id de la poliza


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  01-11-2013      Jhagudelo.SAO222017     Creacion.
  ******************************************************************/

  PROCEDURE GetSuscPol(inuPolicy in ld_policy.policy_id%type,
                       onuSusc   out suscripc.susccodi%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetSecureSale
  Descripcion    : Obtiene la solicitud de venta de seguros dado el id de la poliza
  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 27/11/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  27/11/2013  JCarmona.SAO224868  1 - Creacion
  ******************************************************************/

  FUNCTION fnuGetSecureSale(inuPolicyId in ld_secure_sale.policy_number%type)
    return dald_secure_sale.styLD_secure_sale;

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetFessInvoiced
  Descripcion    : Obtiene el numero de cuotas facturadas del diferido
                   asociado a una poliza de seguros.
  Autor          : FCastro
  Fecha          : 13/07/2017

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  13/07/2013  FCastro.200-1058    1 - Creacion
  ******************************************************************/

  FUNCTION FnuGetFessInvoiced(inuPolicy in ld_policy.policy_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetFessPaid
  Descripcion    : Obtiene el numero de cuotas pagadas del diferido
                   asociado a una poliza de seguros.
  Autor          : John Wilmer Robayo Sanchez
  Fecha          : 19/12/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  19/12/2013  jrobayo.SAO228348  1 - Creacion
  ******************************************************************/

  FUNCTION FnuGetFessPaid(inuPolicy in ld_policy.policy_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetAllFeesPaid
  Descripcion    : Obtiene el numero de cuotas pagadas del diferido
                   asociado a una poliza de seguros y del diferido o diferidos
                   historicos de la misma poliza cuando ha habido traslado de productos
  Autor          : FCastro
  Fecha          : 13/07/2017

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  13/07/2013  FCastro.200-1058    1 - Creacion
  ******************************************************************/


  FUNCTION FnuGetAllFeesPaid (inuPolicy in ld_policy.policy_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FNUCUOTASPAGADASBS
  Descripcion    : Obtiene el numero de cuotas pagadas del diferido
                   asociado a una poliza de seguros.
  Autor          : Karem Baquero Martinez
  Fecha          : 24/10/2016

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  24/10/2016  Kbaquero               1 - Creacion
  ******************************************************************/

  FUNCTION FNUCUOTASPAGADASBS(inuPolicy in ld_policy.policy_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValuePolicyType
  Descripcion    : Obtiene el valor de la poliza para la vigencia
                   correspondiente al tipo de poliza
  Autor          : John Wilmer Robayo Sanchez
  Fecha          : 20-12-2013

  Parametros         Descripcion
  ============   ===================
  inutPolicyType:     Tipo de Poliza
  onuValue:           Vigencia para el tipo de poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  20-12-2013  jrobayo.SAO228441    1 - Creacion
  ******************************************************************/

  PROCEDURE GetValuePolicyType(inuPolicyType in ld_policy_type.policy_type_id%type,
                               onuValue      out number);

  FUNCTION fblHasDefDebt(inuProductId in servsusc.sesunuse%type)
    RETURN boolean;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fblPolicyTypeHasCateg
  Descripcion    : Valida si el tipo de poliza tiene configurado categoria y subcategoria.

  Autor          : Katherine Cienfuegos
  Fecha          : 04/08/2014

  Parametros       Descripcion
  ============     ===================

  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  04/08/2014       kcienfuegos.RNP550    Creacion
  ******************************************************************/
  FUNCTION fblPolicyTypeHasCateg(inutPolicyType in ld_policy_type.policy_type_id%type)
    RETURN boolean;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fblSamePolicyType
  Descripcion    : Valida si a partir de la categoria y subcategoria del cliente
                   se puede aplicar el mismo tipo de poliza.
  Autor          : KCienfuegos
  Fecha          : 04/08/2014

  Parametros         Descripcion
  ============   ===================
  inuPolycType:     Tipo de Poliza
  inuCategory:      Categoria del usuario
  inuSubcategory:   Subcategoria del usuario

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  04/08/2014  kcienfuegos.RNP550  Creacion
  ******************************************************************/
  FUNCTION fblSamePolicyType(inuPolycType   in ld_policy_type.policy_type_id%type,
                             inuCategory    in ld_policy_type.category_id%type,
                             inuSubcategory in ld_policy_type.subcategory_id%type)
    RETURN boolean;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : GetNewPolicyType
  Descripcion    : Obtiene un nuevo tipo de poliza de acuerdo a la categoria y
                   subcategoria del predio asociado al contrato del due?o de la poliza
  Autor          : kcienfuegos
  Fecha          : 04/08/2014

  Parametros         Descripcion
  ============   ===================
  inuProductLine:     Linea de producto
  inuContratista:     Contratista
  inuCategory:        Categoria del usuario
  inuSubcategory:     Subcategoria del usuario
  onuNewPoliTyp:      Nuevo tipo de poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  04/08/2014  kcienfuegos.RNP550  Creacion
  ******************************************************************/
  PROCEDURE GetNewPolicyType(inuProductLine in ld_policy_type.product_line_id%type,
                             inuContratista in ld_policy_type.contratista_id%type,
                             inuCategory    in ld_policy_type.category_id%type,
                             inuSubcategory in ld_policy_type.subcategory_id%type,
                             onuNewPoliTyp  out ld_policy_type.policy_type_id%type);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : GetSuscripPolicy
  Descripcion    : Retorna el contrato sobre el cual la cedula tiene una poliza activa.
  Autor          : Katherine Cienfuegos
  Fecha          : 28/08/2014

  Parametros         Descripcion
  ============   ===================
  inuIdentase:     Numero de identificacion
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuSuscripc:     Contrato

  Historia de Modificaciones
  Fecha            Autor           Modificacion
  =========      =========         ====================
  28/08/2014  KCienfuegos.NC1177   Creacion
  ******************************************************************/
  PROCEDURE GetSuscripPolicy(inuIdentase in ld_policy.identification_id%type,
                             inuSuscripc in suscripc.susccodi%type,
                             isbState    in ld_parameter.value_chain%type,
                             onuSuscripc out suscripc.susccodi%type);

  FUNCTION frfGetPoliciesByAge(inuAge in number) return constants.tyrefcursor;

  FUNCTION fnuGetExqPolciesBySuscripc(isbCardNumber in ge_subscriber.identification%type)
    return number;

  PROCEDURE getPolByCollecAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor);

  FUNCTION fnuGetCurrentBillByProduct(inuProductId in servsusc.sesunuse%type)
    return factura.factcodi%type;

  FUNCTION fnuGetPenDeferrQuot(inuProductId in servsusc.sesunuse%type)
    return number;
  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPenDeferrQuot
   Descripcion    : Obtiene la cantidad de cuotas pendientes del diferido
                    asociado al producto
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros          Descripcion
   ============        ===================
   inuProductId        Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   08-10-2014  llarrarte.RQ2172    Creacion
   28-10-2020	Miguel Ballesteros	Modificacion en el cursor fnuGetPenDeferrQuot para que 
									los diferidos de planes que estén configurados en la 
									tabla LDC_CONFIG_CONTINGENC no sean tenidos en cuenta 
									CASO 539.
   12/10/2021     horbarth         CA 867 se coloca valdiacion para que no se tenga en cuenta diferidos con saldo    
  ******************************************************************/


  PROCEDURE GetPoliciesWithNoRenew(isbState  in ld_parameter.value_chain%type,
                                   orfPolicy out constants.tyRefCursor);

  FUNCTION fnuGetIdByPolicyNumber(inuPolicyNumber in ld_policy.policy_number%type)
    return ld_policy.policy_id%type;

  FUNCTION fnuGetBilledQuotas(inuProductId in servsusc.sesunuse%type)
    return number;

  FUNCTION fnuGetPendQuotas(inuProductId in servsusc.sesunuse%type)
    return number;

  FUNCTION fblHasPendSales(inuProductId in servsusc.sesunuse%type)
    return boolean;

  FUNCTION fnuGetCollectiveNumber(nuPolicynumber in ld_policy.policy_number%type)
    return number;

  /*****************************************************************
   Unidad         : fnuGetCueCobrPol
   Descripcion    : Verifica si el producto asociado a una p?liza contiene cargo a la -1
   Autor          : AAcuna
   Fecha          : 11-02-2016

   Parametros          Descripcion
   ============        ===================
   inuProductId        Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   11-02-2016  AAcuna.RQ100-8096   Creaci?n
  ******************************************************************/
  FUNCTION fnuGetCueCobrPol(inuProductId in servsusc.sesunuse%type)
    return NUMBER;

END LD_BCSecureManagement;
/
create or replace PACKAGE BODY LD_BCSecureManagement IS

  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION     CONSTANT VARCHAR2(20) := 'RQ2172';
  cnuCODSTATEACT CONSTANT ld_policy.state_policy%type := 1;
  cnuCODSTATEREN CONSTANT ld_policy.state_policy%type := 5;

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripcion
  Retorno        :
  csbVersion        Version del Paquete

  Autor          : AAcu?a
  Fecha          : 20/09/2012 SAO 147879

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  *****************************************************************/
  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('Ld_BcSecureManagement.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchPolicy
  Descripcion    : Se genera un cursor referenciado con la informacion de la poliza.
  Autor          : AAcu?a
  Fecha          : 14/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc       Numero del contrato
  Orfsuscribypolicy  Cursor referenciado con los datos de la poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchPolicy(inuSuscripc       in suscripc.susccodi%type,
                             Orfsuscribypolicy out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchPolicy', 10);

    OPEN Orfsuscribypolicy FOR

      SELECT /*+ index(p IDX_LD_POLICY_05) index(pt pk_ld_policy_type)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            index(lp PK_LD_PRODUCT_LINE) index(p IDX_LD_POLICY_06) index(ge PK_GE_SUBSCRIBER)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            USE_NL(pt p) USE_NL(ge p) USE_NL(lp p) */
       p.policy_id Poliza,
       p.suscription_id Contrato,
       p.contratist_code || ' - ' || gec.descripcion "Aseguradora",
       lp.product_line_id || ' - ' || lp.description "Linea de producto",
       ge.identification "Identificacion del asegurado",
       ge.subscriber_name || ' - ' || ge.subs_last_name "Nombre del asegurado",
       pt.policy_type_id || ' - ' || pt.description "Tipo de poliza",
       p.deferred_policy_id Diferido,
       decode(p.state_policy,
              1,
              'Activo',
              2,
              'Cancelacion por solicitud',
              3,
              'Cancelacion por archivo plano',
              4,
              'Cancelacion por job',
              5,
              'Renovada') "Estado de la poliza",
       p.share_policy "Numero de coutas",
       d.difecupa "Coutas facturadas",
       p.value_policy "Valor de la poliza",
       p.prem_policy "Valor de la prima",
       dage_geogra_location.fsbgetdescription(p.geograp_location_id, null) "Ubicacion Geografica",
       p.dt_in_policy "Fecha inicial de vigencia",
       p.dt_en_policy "Fecha final de vigencia"
        FROM ld_policy       p,
             ld_policy_type  pt,
             ge_subscriber   ge,
             ld_product_line lp,
             ge_contratista  gec,
             diferido        d
       WHERE ge.identification = p.identification_id
         AND pt.policy_type_id = p.policy_type_id
         AND p.product_line_id = lp.product_line_id
         AND gec.id_contratista = p.contratist_code
         AND d.difecodi = p.deferred_policy_id
         AND p.suscription_id = inuSuscripc
       ORDER BY p.policy_id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchPolicy', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchPolicyId
  Descripcion    : Busca las poliza dependiendo el codigo de la poliza
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
     inuPoli       Codigo de la poliza
  Orfsuscribypolicy  Cursor referenciado con los datos de la poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchPolicyId(inuPoli           in ld_policy.policy_id%type,
                               Orfsuscribypolicy out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchPolicyId', 10);

    OPEN Orfsuscribypolicy FOR
      SELECT /* +index(p IDX_LD_POLICY_05) index(pt pk_ld_policy_type) index(lp PK_LD_PRODUCT_LINE) index(p IDX_LD_POLICY_06) index(ge PK_GE_SUBSCRIBER) USE_NL(pt p) USE_NL(ge p) USE_NL(lp p) */
       p.policy_id Poliza,
       p.suscription_id Contrato,
       p.contratist_code || ' - ' || gec.descripcion "Aseguradora",
       lp.product_line_id || ' - ' || lp.description "Linea de producto",
       ge.identification "Identificacion del asegurado",
       ge.subscriber_name || ' - ' || ge.subs_last_name "Nombre del asegurado",
       p.dt_insured_policy "Fecha de nacimiento",
       pt.policy_type_id || ' - ' || pt.description "Tipo de poliza",
       p.deferred_policy_id Diferido,
       decode(p.state_policy,
              1,
              'Activo',
              2,
              'Anulada',
              3,
              'Expirada',
              5,
              'Anulada por cartera') "Estado de la poliza",
       p.share_policy "Numero de coutas",
       d.difecupa "Coutas facturadas",
       p.value_policy "Valor de la poliza",
       p.prem_policy "Valor de la prima",
       dage_geogra_location.fsbgetdescription(p.geograp_location_id, null) "Ubicacion Geografica",
       p.dt_in_policy "Fecha inicial de vigencia",
       p.dt_en_policy "Fecha final de vigencia"
        FROM ld_policy       p,
             ld_policy_type  pt,
             ge_subscriber   ge,
             ld_product_line lp,
             ge_contratista  gec,
             diferido        d
       WHERE ge.identification = p.identification_id
         AND pt.policy_type_id = p.policy_type_id
         AND p.product_line_id = lp.product_line_id
         AND gec.id_contratista = p.contratist_code
         AND d.difecodi = p.deferred_policy_id
         AND p.policy_id = inuPoli;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchPolicyId', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchPolicyId;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPoly
  Descripcion    : Retorna la cantidad de cedula permitidas por tipo de poliza
                 teniendo en cuenta que el tipo de poliza se debe encontrar vigente
                 dependiendo la fecha de vigencia.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolyType:     Codigo del tipo de poliza
  onuCantId:     Cantidad de cedula por tipo de poliza que se encuentren vigentes.

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPoly(inuPolyType in ld_policy_type.policy_type_id%type,
                        onuCantId   out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValPoly', 10);

    SELECT /*+ index (pt pk_ld_policy_type) */
     pt.ammount_cedula
      INTO onuCantId
      FROM ld_policy_type pt
     WHERE pt.policy_type_id = inuPolyType;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValPoly', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuCantId := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValCantPoly
  Descripcion    : Retorna la cantidad de polizas por asegurado,dependiendo de la cedula
                 del asegurado y el contrato
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
      inuId:     Numero de identificacion
  inuSuscripc:     Suscripcion
  inuPolicyType:   id. tipo Poliza
   isbState:     Estado de la poliza
  onuCantId:     Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValCantPoly(inuId         in ge_subscriber.identification%type,
                            inuSuscripc   in suscripc.susccodi%type,
                            inuPolicyType in ld_policy.policy_type_id%type,
                            isbState      in ld_parameter.value_chain%type,
                            onuCantId     out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValCantPoly', 10);

    SELECT /*+ index (p PK_LD_POLICY) index(p IDX_LD_POLICY_05) */
     count(*)
      INTO onuCantId
      FROM ld_policy p
     WHERE instr(isbState, lpad(p.state_policy, 4, '0')) > 0
       AND p.policy_type_id = inuPolicyType
       AND p.identification_id = inuId;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValCantPoly', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuCantId := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValCantPoly;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolyActi
  Descripcion    : Retorna 1 si la cedula tiene una poliza activa en otro contrato
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentase:     Numero de identificacion
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolyActi(inuIdentase in ld_policy.identification_id%type,
                            inuSuscripc in suscripc.susccodi%type,
                            isbState    in ld_parameter.value_chain%type,
                            onuValue    out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValPolyActi', 10);

    SELECT /*+ index (p PK_LD_POLICY) index (p IDX_LD_POLICY_06)*/
     count(*)
      INTO onuValue
      FROM ld_policy p
     WHERE p.Identification_Id = inuIdentase
       AND p.Suscription_Id <> inuSuscripc
       AND regexp_instr(lpad(p.state_policy, 4, '0'), isbState) > 0;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValPolyActi', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValPolyActi;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolyCont
  Descripcion    : Retorna la cantidad de polizas por suscritor
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolyCont(inuSuscripc in suscripc.susccodi%type,
                            isbState    in ld_parameter.value_chain%type,
                            onuValue    out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValPolyCont', 10);

    SELECT /*+ index (p PK_LD_POLICY) index (p IDX_LD_POLICY_05)*/
     count(*)
      INTO onuValue
      FROM ld_policy p
     WHERE p.suscription_id = inuSuscripc
       AND regexp_instr(lpad(p.state_policy, 4, '0'), isbState) > 0;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValPolyCont', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuValue := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValBornDate
  Descripcion    : Valida que el suscritor no pase del parametro de la edad maxima y minima para tomar el seguro.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuValue:        Valor de retorno, edad del suscritor

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValBornDate(inuSuscripc in suscripc.susccodi%type,
                            onuValue    out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValBornDate', 10);

    SELECT /*+ index (s PK_SUSCRIPC)*/
     to_char(SYSDATE, 'yyyy') - to_char(grd.date_birth, 'yyyy')
      INTO onuValue
      FROM suscripc s, ge_subscriber ge, ge_subs_general_data grd
     WHERE s.susccodi = inuSuscripc
       AND s.suscclie = ge.subscriber_id
       AND ge.subscriber_id = grd.subscriber_id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValBornDate', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValBornDate;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValidateClifin
  Descripcion    : Obtiene el valor de cuota de financiacion por suscritor.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  ******************************************************************/
  PROCEDURE ProcValidateClifin(inuSuscripc in suscripc.susccodi%type,
                               onuValue    out number) IS
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValidateClifin', 10);

    SELECT /*+ index (p IDX_LD_POLICY_05)
                                                       index (lvpt PK_LD_VALIDITY_POLICY_TYPE)*/
     SUM(lvpt.share_value)
      INTO onuValue
      FROM /*+ Ld_BcSecureManagement.ProcValidateClifin */
           ld_validity_policy_type lvpt,
           ld_policy               p
     WHERE lvpt.policy_type_id = p.policy_type_id
       AND lvpt.validity_policy_type_id = p.validity_policy_type_id
       AND p.suscription_id = inuSuscripc;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValidateClifin', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValidateClifin;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchDataProduct
  Descripcion    : Busca la informacion del contrato y producto
  Autor          : kBaquero
  Fecha          : 23/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuGas_Service:   Parametro del numero de servicio
  inuState:         Parametro del estado de la poliza
  otbAccountcharge: Objeto tipo tabla con los suscritores

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchDataProduct(inuGas_Service   in ld_parameter.value_chain%type,
                                  inuState         in ld_parameter.value_chain%type,
                                  otbAccountcharge out pktblservsusc.tySesunuse)

   IS

    orfAccountcharge pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchProduct', 10);

    OPEN orfAccountcharge FOR
      SELECT /*+ INDEX (P IDX_LD_POLICY_09) USE_NL(s su) USE_NL(s p) USE_NL(su p)*/
       sesunuse, susccodi
        FROM servsusc s, suscripc su, ld_policy p
       WHERE s.sesuserv = inuGas_Service
         AND p.state_policy IN (inuState)
         AND s.sesususc = su.susccodi
         --AND s.sesususc = any(480430,15903,1203168)--(1000219,1100915,1203168)
         AND s.sesunuse = p.product_id
         AND s.sesususc = p.suscription_id;

    FETCH orfAccountcharge BULK COLLECT
      INTO otbAccountcharge;
    CLOSE orfAccountcharge;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchProduct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchDataProduct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProduct
  Descripcion    : Busca los servicio suscrito cuya poliza tengan igual o mayor numero de
                 periodos vencidos
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuGas_Service:   Parametro del numero de servicio
  inuState:         Parametro del estado de la poliza
  otbAccountcharge: Objeto tipo tabla con los suscritores

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProduct(inuGas_Service   in ld_parameter.value_chain%type,
                              inuState         in ld_parameter.value_chain%type,
                              otbAccountcharge out pktblservsusc.tySesunuse)

   IS

    orfAccountcharge pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchProduct', 10);

    OPEN orfAccountcharge FOR
      SELECT /*+ INDEX (P IDX_LD_POLICY_09) USE_NL(s su) USE_NL(s p) USE_NL(su p)*/
       sesunuse
        FROM servsusc s, suscripc su, ld_policy p
       WHERE s.sesuserv = inuGas_Service
         AND regexp_instr(lpad(p.state_policy, 4, '0'), inuState) > 0 --p.state_policy IN (inuState)
         AND s.sesususc = su.susccodi
        -- AND s.sesususc = any(480430,15903,1203168)
         AND s.sesunuse = p.product_id
         AND s.sesususc = p.suscription_id;

    FETCH orfAccountcharge BULK COLLECT
      INTO otbAccountcharge;
    CLOSE orfAccountcharge;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchProduct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchProduct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchCharge
  Descripcion    : Verifica el numero de cuentas de cobro por facturacion que se debe por ese
                 servicio de seguro y que las cuentas de cobro esten vencidas.
  Autor          : AAcu?a
  Fecha          : 14/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuServSusc:     Numero de servicio de suscripcion
  inuFactProg:     Parametro del programa de FGCC
  onuCuenCobr:     Valor de retorno,con las cuentas de cobros vencidas por servicio suscrito

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchCharge(inuServSusc in servsusc.sesunuse%type,
                             inuFactProg in ld_parameter.value_chain%type,
                             onuCuenCobr out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchCharge', 10);

    SELECT /*+ INDEX (cuencobr IX_CUENCOBR03) USE_NL(cuencobr factura) USE_NL(factura perifact)*/
     NVL(count(*), 0)
      INTO onuCuenCobr
      FROM cuencobr, perifact, factura
     WHERE cuconuse = inuServSusc
       AND factprog = inuFactProg
       AND cucofact = factcodi
       AND factpefa = pefacodi
       AND nvl(cucosacu, 0) > 0
       AND trunc(pefafepa) < trunc(sysdate);

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchCharge', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchCharge;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchServPolicyState
  Descripcion    : Dependiendo el servicio busca todas las polizas en estado ?"Activa" o "Inactiva"
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuServSusc:     Servicio suscrito
  inuState:        Estado de la poliza
  orfPolicy:       Cursor con las polizas que tengan estado activo e inactivo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchServPolicyState(inuServSusc in servsusc.sesunuse%type,
                                      inuState    in ld_parameter.value_chain%type,
                                      orfPolicy   out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchServPolicyState',
                   10);

    OPEN orfPolicy FOR

      SELECT /*+ index(idx_ld_policy_09)*/
       *
        FROM ld_policy p
       WHERE p.suscription_id = inuServSusc
         AND p.state_policy in (inuState);

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchServPolicyState',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchServPolicyState;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchPolicyState
  Descripcion    :  Busca todas las polizas en estado ?"Activa" o "Inactiva" dependiendo de
                 la fecha de crecion
  Autor          : kbaquero
  Fecha          : 23/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuState:        Estado de la poliza
  orfPolicy:       Cursor con las polizas que tengan estado activo e inactivo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchPolicyState(inuState  in ld_parameter.value_chain%type,
                                  orfPolicy out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchPolicyState',
                   10);

    OPEN orfPolicy FOR

      SELECT /*+ INDEX (ld_policy IDX_LD_POLICY_09) */
       *
        FROM ld_policy
       WHERE CONTRATIST_CODE IS NOT NULL
         AND STATE_POLICY In (inuState)
         AND DT_IN_POLICY > sysdate - 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchPolicyState', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchPolicyState;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcPolicyBySysdate
  Descripcion    : Busca todas las polizas en estado ?"Activa" o "Inactiva" dependiendo
                 de la fecha final de vigencia
  Autor          : AAcuna
  Fecha          : 11/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  isbState          Estado de polizas activas
  orfPolicy:       Cursor con las polizas que tengan estado activo y dependiendo la fecha final de vigencia

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  05-03-2014  hjgomez.SAO234798   Se valida que no esten en proceso de cancelacion de poliza
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy>
  ******************************************************************/
  PROCEDURE ProcPolicyBySysdate(isbState  in ld_parameter.value_chain%type,
                                orfPolicy out constants.tyRefCursor) IS
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcPolicyBySysdate', 10);

    OPEN orfPolicy FOR
      SELECT /*+ index(ld_policy pk_ld_policy) index(ld_policy idx_ld_policy_10) */
       policy_id,
       state_policy,
       launch_policy,
       contratist_code,
       product_line_id,
       dt_in_policy,
       dt_en_policy,
       value_policy,
       prem_policy,
       name_insured,
       suscription_id,
       product_id,
       identification_id,
       period_policy,
       year_policy,
       month_policy,
       deferred_policy_id,
       dtcreate_policy,
       share_policy,
       dtret_policy,
       valueacr_policy,
       report_policy,
       dt_report_policy,
       dt_insured_policy,
       per_report_policy,
       policy_type_id,
       id_report_policy,
       cancel_causal_id,
       fees_to_return,
       comments,
       policy_exq,
       number_acta,
       geograp_location_id,
       validity_policy_type_id
        FROM ld_policy ldpolicy
       WHERE dt_en_policy <= trunc(sysdate)
         AND regexp_instr(lpad(state_policy, 4, '0'), isbState) > 0
         AND policy_id not in
             (SELECT /*+ index(ld_secure_cancella PK_LD_SECURE_CANCELLA)
                                                                                                                                                                           index(mo_packages PK_MO_PACKAGES) */
               policy_id
                FROM ld_secure_cancella, mo_packages
               WHERE ld_secure_cancella.secure_cancella_id =
                     mo_packages.package_id
                 AND mo_packages.motive_status_id = 13);

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcPolicyBySysdate', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcPolicyBySysdate;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearDeferred
  Descripcion    : Selecciona los diferidos de un producto que tengan saldo registrado
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuServSusc:     Numero del servicio suscrito
  orfDife:         Cursor con los diferidos que tengan saldo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearDeferred(inuServSusc in servsusc.sesunuse%type,
                             orfDife     out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearDeferred', 10);

    OPEN orfDife FOR
      SELECT /*+ index(ix_dife_nuse)*/
       difeconc, sum(difesape) difesape
        FROM diferido
       WHERE difenuse = inuServSusc
         AND nvl(difesape, 0) > 0
       GROUP BY difeconc;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearDeferred;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProd
  Descripcion    : Retorna la categoria y subcategoria a partir de que el contrato tenga un producto de gas activo y ademas que
                 la categoria y subcategoria sea de tipo residencial o comercial.
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros          Descripcion
  ============     ==================
  inuSusc:         Numero de suscripcion
  inuGas_Service:  Parametro del servicio de gas
  isbCate :        Parametro de las categorias permitidas
  onuCate:         Parametro de la categoria permitida
  onuSubcate:      Valor de retorno del estado del producto

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  29-01-2014      AEcheverrySAO231292 se modifica sentencia para mejorar el rendimiento
  ******************************************************************/
  PROCEDURE ProcValProd(inuSusc        in suscripc.susccodi%type,
                        isbCate        in ld_parameter.value_chain%type,
                        inuGas_Service in ld_parameter.numeric_value%type,
                        onuCategori    out categori.catecodi%type,
                        onuSubcate     out subcateg.sucacodi%type) IS
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValProd', 10);

    SELECT /*+ index(a IDX_PR_PRODUCT_010) index(s PK_SERVSUSC) */
     s.sesucate, s.sesusuca
      INTO onuCategori, onuSubcate
      FROM pr_product a, servsusc s, ps_product_status c
     WHERE a.subscription_id = inuSusc
       AND a.product_type_id = inuGas_Service
       AND s.sesunuse = a.product_id
       AND c.product_status_id = a.product_status_id
       AND sesufein = (SELECT MAX(sesufein)
                         FROM servsusc sesu
                        WHERE sesu.sesususc = inuSusc
                          AND sesu.sesucate = s.sesucate
                          and sesu.sesuserv = inuGas_Service)
       AND regexp_instr(lpad(s.sesucate, 3, '0'), isbCate) > 0
       AND c.is_active_product = ld_boconstans.csbYesFlag
       AND ROWNUM = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValProd', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuCategori := 0;
      onuSubcate  := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValProd;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del mismo tipo de
  Autor          : kbaquero
  Fecha          : 26/09/2012 SAO 159429

  Parametros         Descripcion
  ============   ===================
  inuSusc:       Numero del suscritoR
  inuMotype:     Codigo del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliAct(inuSusc     in servsusc.sesususc%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number) is

  BEGIN
    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);
    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(1)
      INTO onucant
      FROM mo_packages P, mo_motive M
     WHERE P.package_id = M.package_id
       AND p.subscriber_id = inuSusc
       AND p.motive_status_id = inuEstapack
       AND p.package_type_id = inuMotype;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onucant := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSoliAct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Procpackatype
  Descripcion    : Selecciona el tipo de paquete de una solicitud dependiendo del
                 suscriptor
  Autor          : kbaquero
  Fecha          : 27/09/2012 SAO 159429

  Parametros         Descripcion
  ============   ===================
  inupacktype:         Codigo Tipo de paquete
  inuChanelCrossSale:   Codigo de la venta que se ingresa
  onucant:             Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE Procpackatype(inupacktype        in pr_product.product_type_id%type,
                          inuChanelCrossSale in ld_sales_visit.visit_sale_cru_id%type,
                          onucant            out number) is

  BEGIN

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);

    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(package_type_id)
      INTO onucant
      FROM mo_packages M
     WHERE M.PACKAGE_ID = inuChanelCrossSale
       AND m.package_type_id = inupacktype;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onucant := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END Procpackatype;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcDataPoli
  Descripcion    : Se obtiene datos de la poliza para el tramite de no renovacion.
  Autor          : kbaquero
  Fecha          : 28/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPoli:         Numero de la poliza
  onupolitype:     Codigo del tipo de poliza
  onuValuep   :    Valor de la poliza
  onuPayFeed  :    Cutoas pagadas
  onuNumDife  :    Numero del diferido
  oNucontra:       Numero del contrato
  ONuproline:      Numero de linea de producto

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcDataPoli(inuPoli     in ld_policy.policy_id%type,
                         onupolitype Out ld_policy.policy_type_id%type,
                         onuValuep   Out ld_policy.value_policy%type,
                         onuPayFeed  Out diferido.difecupa%type,
                         onuNumDife  Out ld_policy.deferred_policy_id%type,
                         oNucontra   Out ld_policy.contratist_code%type,
                         ONuproline  Out ld_policy.product_line_id%type) is

  BEGIN
    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcDataPoli', 10);

    BEGIN
      SELECT /*+ Index(diferido IX_DIFERIDO02) USE_NL(diferido ld_policy)  */
       l.policy_type_id,
       l.value_policy,
       d.difecupa,
       l.deferred_policy_id,
       l.contratist_code,
       l.product_line_id
        INTO onupolitype,
             onuValuep,
             onuPayFeed,
             onuNumDife,
             oNucontra,
             ONuproline
        FROM diferido d, ld_policy l
       WHERE L.POLICY_ID = INUPOLI
         AND L.SUSCRIPTION_ID = D.DIFESUSC
         AND L.DEFERRED_POLICY_ID = D.DIFECODI;
    EXCEPTION
      when others then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'Este suscriptor No tiene diferido Asociado a la poliza, Favor Verificar');
    end;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcDataPoli', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcDataPoli;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolyActiSusc
  Descripcion    : Obtiene si un suscriptor tiene una poliza activa
  Autor          : aacu?a
  Fecha          : 01/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolyActiSusc(inuSuscripc in suscripc.susccodi%type,
                                isbState    in ld_parameter.value_chain%type,
                                onuValue    out number)

   IS

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValPolyActiSusc', 10);

    SELECT /*+ index(p IDX_LD_POLICY_05)*/
     count(*)
      INTO onuValue
      FROM ld_policy p
     WHERE p.Suscription_Id = inuSuscripc
       AND regexp_instr(lpad(p.state_policy, 4, '0'), isbState) > 0;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValPolyActiSusc', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValPolyActiSusc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcDateBirthSubs
  Descripcion    : Obtiene la fecha de nacimiento del dueno del contrato
  Autor          : AAcu?a
  Fecha          : 05/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuDate:         Fecha de nacimiento


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcDateBirthSubs(inuSuscripc in suscripc.susccodi%type,
                              onuDate     out date)

   IS

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcDateBirthSubs', 10);

    SELECT /*+ index(s pk_suscripc) use_nl(s ges) use_nl(ges ges) */
    DISTINCT ged.date_birth
      INTO onuDate
      FROM ge_subs_general_data ged, ge_subscriber ges, suscripc s
     WHERE date_birth is not null
       AND s.suscclie = ges.subscriber_id
       AND ged.subscriber_id = ges.subscriber_id
       AND s.susccodi = inuSuscripc;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcDateBirthSubs', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcDateBirthSubs;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcDataPolicy
  Descripcion    : Se obtiene datos de la poliza para el tramite de cancelacion.
  Autor          : kbaquero
  Fecha          : 04/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPoli:         Numero de la poliza
  osbname:         Nombre del asegurado
  onuidenti:       Numero de identificacion del asegurado
  onucontr:        Aseguradora
  onuprodli:       Linea de Producto

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcDataPolicy(inuPoli   in ld_policy.policy_id%type,
                           osbname   Out ld_policy.name_insured%type,
                           onuidenti Out ld_policy.identification_id%type,
                           onucontr  Out ld_policy.contratist_code%type,
                           onuprodli Out ld_policy.product_line_id%type) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcDataPolicy', 10);

    SELECT /*+ Index(ld_policy IDX_LD_POLICY_02)  */
     l.name_insured,
     l.product_line_id,
     l.identification_id,
     l.contratist_code
      INTO osbname, onuprodli, onuidenti, onucontr
      FROM ld_policy l
     WHERE l.policy_id = inuPoli;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcDataPolicy', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcDataPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValAddressBySusc
  Descripcion    : Valida que la direccion del contrato exista
  Autor          : AAcuna
  Fecha          : 17/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:      Numero del suscritor
  onuValue:         Valor de retorno


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValAddressBySusc(inuSuscripc in suscripc.susccodi%type,
                                 onuValue    out number) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValAddressBySusc', 10);

    SELECT /*+ Index(ld_policy IDX_LD_POLICY_02)  */
     count(ad.address_id)
      INTO onuValue
      FROM suscripc           s,
           ge_subscriber      ge,
           ab_address         ad,
           ge_geogra_location geo
     WHERE s.suscclie = ge.subscriber_id
       AND ge.address_id = ad.address_id
       AND ad.geograp_location_id = geo.geograp_location_id
       AND s.susccodi = inuSuscripc;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValAddressBySusc', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValAddressBySusc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcProductOrder
  Descripcion    : Retorna el identificador del producto a partir de una orden

  Autor          : Kbaquero
  Fecha          : 07/11/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuorder:       Identificador de la orden
  onuproduct:     Identificador del producto
  onupack         Numero de la orden
  onuactiCP       Actividad de la orden

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcProductOrder(inuorder   in or_order.order_id%type,
                             onuproduct out or_order_activity.product_id%type,
                             onupack    out or_order_activity.package_id%type,
                             onuactiCP  out or_order_activity.activity_id%type) is

  begin

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcProductOrder', 10);

    select /*+ index(o PK_OR_ORDER) use_nl(o a)  */
     a.product_id, a.package_id, a.activity_id
      into onuproduct, onupack, onuactiCP
      from or_order o, or_order_activity a
     where o.order_id = inuorder
       and o.order_id = a.order_id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcProductOrder', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END ProcProductOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddressBySusc
  Descripcion    : Obtiene la direccion de contrato del suscritor
  Autor          : AAcuna
  Fecha          : 06/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:      Numero del suscritor
  onuValue:         Direccion
  onuGeo:           Ubicacion geografica


  Historia de Modificaciones
  Fecha            Autor              Modificacion
  =========      =========            ====================
  24-07-2014      JCarmona.4218       Se modifica para que no tengan en cuenta
                                      el estado del producto asociado al contrato.
  29-01-2014      AEcheverrySAO231292 se modifica sentencia para mejorar el rendimiento
  06-09-2013      mmira.SAO214195     Se elimina la condicion del estado final.
  ******************************************************************/
  PROCEDURE GetAddressBySusc(inuSuscripc in suscripc.susccodi%type,
                             onuValue    out ab_address.address_id%type,
                             onuGeo      out ge_geogra_location.geograp_location_id%type) is

    nuGasService servicio.servcodi%type;

    CURSOR cuGetAddress IS
      SELECT a.address_id, d.geograp_location_id
        FROM servsusc s, pr_product a, ps_product_status c, ab_address d
       WHERE s.sesususc = inuSuscripc
         AND s.sesuserv = nuGasService
            -- AND (s.sesufere is null OR s.sesufere > sysdate)      /* Aranda 4218 */
         AND a.product_id = s.sesunuse
         AND c.product_status_id = a.product_status_id
            -- AND c.is_active_product = 'Y'                         /* Aranda 4218 */
         AND d.address_id = a.address_id
         and rownum = 1;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetAddressBySusc', 10);

    nuGasService := ld_boconstans.cnuGasService;

    onuValue := null;
    onuGeo   := null;

    open cuGetAddress;
    fetch cuGetAddress
      INTO onuValue, onuGeo;
    close cuGetAddress;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetAddressBySusc', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetAddressBySusc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberBySusc
  Descripcion    : Obtiene el subscriber a partir del contrato
  Autor          : AAcuna
  Fecha          : 03/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Numero de suscripcion
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetSubscriberBySusc(inuSuscripc in suscripc.susccodi%type,
                                onuValue    out ge_subscriber.subscriber_id%type)

   IS

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSubscriberBySusc', 10);

    SELECT /*+ index(pk_suscripc) use_nl(suscripc ges)*/
     suscclie
      INTO onuValue
      FROM suscripc, ge_subscriber ge
     WHERE ge.subscriber_id = suscclie
       AND susccodi = inuSuscripc;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSubscriberBySusc', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuValue := null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSubscriberBySusc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberById
  Descripcion    : Obtiene el subscriber a partir de la cedula
  Autor          : AAcuna
  Fecha          : 03/10/2012 SAO 147879

  Parametros               Descripcion
  ============        ===================
  isbIdentification:    Numero de identificacion
  onuSubscriber:        Codigo del subscriber

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  06-09-2013    jrobayo.SAO214422       Se modifica para crear un suscriptor
                                        en caso que este no exista.

  05-09-2013    mmeusburgger.SAO216329  Se modifica para levantar error en caso
                                        de no obtener Datos del subscriptor
  ******************************************************************/
  PROCEDURE GetSubscriberById(isbIdentification in ge_subscriber.identification%type,
                              onuSubscriber     out ge_subscriber.subscriber_id%type)

   IS

    CURSOR cuSubscriberById IS
      SELECT /*+ index(pk_ge_subscriber)*/
       subscriber_id
        FROM ge_subscriber ge
       WHERE ge.identification = isbIdentification
         AND ROWNUM = 1;

    PROCEDURE CloseCursor IS
    BEGIN
      IF (cuSubscriberById%ISOPEN) THEN
        CLOSE cuSubscriberById;
      END IF;
    END CloseCursor;

  BEGIN
    UT_Trace.Trace(' BEGIN LD_BCSECUREMANAGEMENT.GetSubscriberById[' ||
                   isbIdentification || ']',
                   10);

    CloseCursor;

    /*Verifica la existencia del cliente segun los datos ingresados*/
    OPEN cuSubscriberById;
    FETCH cuSubscriberById
      INTO onuSubscriber;
    CloseCursor;

    ut_trace.trace('END LD_BCSECUREMANAGEMENT.GetSubscriberById', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      CloseCursor;
      raise ex.CONTROLLED_ERROR;
    when others then
      CloseCursor;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSubscriberById;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValuePolicyType
  Descripcion    : Obtiene el valor del tipo de poliza
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inutPolicyType:     Tipo de Poliza
  idtRequestDate:     Fechad e Registro
  onuValue:           Valor del tipo de poliza
  onuCoverage_Month:  Meses de cobertura

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  27-08-2013  jcarrillo.SAO214742 1 - Se adiciona el parametro <idtRequestDate>
                                  2 - Se consula el tipo de poliza vigente
                                  3 - Se modifica para permitir el retorno de nulos
                                      y validar que existan vigencias.
  ******************************************************************/
  PROCEDURE GetValuePolicyType(inutPolicyType    in ld_policy_type.policy_type_id%type,
                               idtRequestDate    in mo_packages.request_date%type,
                               onuValue          out ld_validity_policy_type.policy_value%type,
                               onuCoverage_Month out ld_validity_policy_type.coverage_month%type) IS
    CURSOR cuValuePolicyType IS
      SELECT /*+ index (lvpt IX_LD_VALIDITY_POLICY_TYPE_01) */
       share_value, coverage_month
        FROM /*+ Ld_BcSecureManagement.GetValuePolicyType */
             ld_validity_policy_type lvpt
       WHERE policy_type_id = inutPolicyType
         AND idtRequestDate between initial_date and final_date;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetValuePolicyType', 10);

    open cuValuePolicyType;
    fetch cuValuePolicyType
      INTO onuValue, onuCoverage_Month;
    close cuValuePolicyType;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetValuePolicyType', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuValuePolicyType%isopen) then
        close cuValuePolicyType;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuValuePolicyType%isopen) then
        close cuValuePolicyType;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetValuePolicyType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicyType
  Descripcion    : Obtiene la vigencia para el tipo de poliza
  Autor          : jcarrillo
  Fecha          : 27-08-2013

  Parametros         Descripcion
  ============   ===================
  inutPolicyType:     Tipo de Poliza
  idtRequestDate:     Fechad e Registro
  onuValidityPolTyp:  Vigencia para el tipo de poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  27-08-2013  jcarrillo.SAO214742 1 - Creacion
  ******************************************************************/
  PROCEDURE GetValidityPolicyType(inutPolicyType    in ld_policy_type.policy_type_id%type,
                                  idtRequestDate    in mo_packages.request_date%type,
                                  onuValidityPolTyp out ld_validity_policy_type.validity_policy_type_id%type) IS
    CURSOR cuGetValPolType IS
      SELECT /*+ index (lvpt IX_LD_VALIDITY_POLICY_TYPE_01) */
       lvpt.validity_policy_type_id
        FROM /*+ Ld_BcSecureManagement.GetValidityPolicyType */
             ld_validity_policy_type lvpt
       WHERE policy_type_id = inutPolicyType
         AND idtRequestDate between initial_date and final_date;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetValidityPolicyType',
                   10);

    open cuGetValPolType;
    fetch cuGetValPolType
      into onuValidityPolTyp;
    close cuGetValPolType;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetValidityPolicyType', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetValPolType%isopen) then
        close cuGetValPolType;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetValPolType%isopen) then
        close cuGetValPolType;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetValidityPolicyType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddress
  Descripcion    : Obtiene la direccion parseada de ab_address
  Autor          : AAcuna
  Fecha          : 16/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:      Numero del suscritor
  onuValue:         Direccion


  Historia de Modificaciones
  Fecha            Autor              Modificacion
  =========      =========            ====================
  24-07-2014      JCarmona.4218       Se modifica para que no tengan en cuenta
                                      el estado del producto asociado al contrato.
  29-01-2014      AEcheverrySAO231292 se modifica sentencia para mejorar el rendimiento
  06-09-2013      mmira.SAO214195     Se elimina la condicion del estado final.
  ******************************************************************/
  PROCEDURE GetAddress(inuSuscripc in suscripc.susccodi%type,
                       onuValue    out ab_address.address%type) is

    nuGasService servicio.servcodi%type;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetAddress', 10);

    nuGasService := ld_boconstans.cnuGasService;

    SELECT daab_address.fsbgetaddress_parsed(a.address_id)
      INTO onuValue
      FROM servsusc s, pr_product a, ps_product_status c
     WHERE s.sesususc = inuSuscripc
       AND s.sesuserv = nuGasService
          -- AND (s.sesufere is null OR s.sesufere > sysdate)      /* Aranda 4218 */
       AND a.product_id = s.sesunuse
       AND c.product_status_id = a.product_status_id
          -- AND c.is_active_product = 'Y'                         /* Aranda 4218 */
       and rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetAddress', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuValue := null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetAddress;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPackageByPolCan
  Descripcion    : Obtiene el numero del paquete de cancelacion a partir de la poliza
  Autor          : AAcuna
  Fecha          : 10/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:      Numero de la poliza
  onuValue:       Numero de paquete


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPackageByPolCan(inuPolicy in ld_policy.policy_id%type,
                               onuValue  out ld_secure_cancella.secure_cancella_id%type) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPackageByPolCan', 10);

    SELECT /*+ Index(ld IDX_LD_SECURE_CANCELLA_02)  */
     ld.secure_cancella_id
      INTO onuValue
      FROM ld_secure_cancella ld
     WHERE ld.policy_id = inuPolicy;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPackageByPolCan', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPackageByPolCan;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPackageByPolSale
  Descripcion    : Obtiene el numero del paquete de la venta a partir de la poliza
  Autor          : AAcuna
  Fecha          : 31/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:      Numero de la poliza
  onuPackage:     Numero de paquete


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  04/09/2013  jcarrillo.SAO214549 1 - Se modifica para poder retornar solicitud nula
  ******************************************************************/
  PROCEDURE GetPackageByPolSale(inuPolicy  in ld_policy.policy_id%type,
                                onuPackage out ld_secure_sale.secure_sale_id%type) IS
    CURSOR cuPackageByPolSale IS
      SELECT /*+ Index(ld UX_LD_SECURE_SALE)  */
       ld.secure_sale_id
        FROM /*+ Ld_BcSecureManagement.GetPackageByPolSale */
             ld_secure_sale ld
       WHERE ld.policy_number = inuPolicy;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPackageByPolSale', 10);

    open cuPackageByPolSale;
    fetch cuPackageByPolSale
      INTO onuPackage;
    close cuPackageByPolSale;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPackageByPolSale', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPackageByPolSale%isopen) then
        close cuPackageByPolSale;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPackageByPolSale%isopen) then
        close cuPackageByPolSale;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPackageByPolSale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPolicyType
  Descripcion    : Retorna 1 si la fecha del sistema se encuentra entre el rango
                 de fechas de inicio y fin

  Autor          : AAcuna
  Fecha          : 12/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicyType:  Numero del tipo de poliza
  onuValue:       Valor


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  ******************************************************************/
  PROCEDURE GetPolicyType(inuPolicyType in ld_policy_type.policy_type_id%type,
                          onuValue      out number) IS
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPolicyType', 10);

    SELECT /*+ index (lvpt IX_LD_VALIDITY_POLICY_TYPE_01) */
     count(policy_type_id)
      INTO onuValue
      FROM /*+  Ld_BcSecureManagement.GetPolicyType */
           ld_validity_policy_type lvpt
     WHERE sysdate between initial_date AND final_date
       AND policy_type_id = inuPolicyType;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPolicyType', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPolicyType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPackageSale
  Descripcion    : Retorna el numero del paquete a partir del numero de la poliza de venta

  Autor          : AAcuna
  Fecha          : 12/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPackage      Numero de solicitud de venta
  inuPolicy:      Numero de la poliza
  onuPackage:     Paquete


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPackageSale(inuPackage in mo_packages.package_id%type,
                           inuPolicy  in ld_policy.policy_id%type,
                           onuPackage out mo_packages.package_id%type) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPackageSale', 10);

    SELECT /*+ Index(ld IDX_LD_SECURE_CANCELLA_02)  */
     l.secure_sale_id
      INTO onuPackage
      FROM ld_secure_sale l, mo_packages m
     WHERE l.policy_number = inuPolicy
       AND l.secure_sale_id <> inuPackage
       AND m.package_id = l.secure_sale_id
       AND m.package_type_id in (100236, 100261);

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPackageSale', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPackageSale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetProductPolicy
  Descripcion    : Retorna el numero del paquete a partir del numero de la poliza de venta

  Autor          : AAcuna
  Fecha          : 12/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Numero de la poliza
  onuProduct:      Numero del producto


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetProductPolicy(inuPolicy  in ld_policy.policy_id%type,
                             onuProduct out servsusc.sesunuse%type) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetProductPolicy', 10);

    SELECT /*+ Index(l pk_ld_policy) Index(p pk_pr_product) use_nl(pr_product ges) */
     l.product_id
      INTO onuProduct
      FROM ld_policy l, pr_product p
     WHERE l.policy_id = inuPolicy
       AND p.product_id = l.product_id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetProductPolicy', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetProductPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetDefferedByPol
  Descripcion    : Retorna el numero del diferido

  Autor          : AAcuna
  Fecha          : 26/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuProductId:    Identificador del Producto
  onuDeffered:     Numero del diferido


  Historia de Modificaciones
  Fecha            Autor              Modificacion
  =========      =========            ====================
  12/11/2014      llarrarte.RQ1146    Se modifica para que no se presente error al obtener varios resultados
  01/11/2013      jrobayo.SAO222260   Se modifica la sentencia para filtrar por numero
                                      de documento.
  31/10/2013      Jhagudelo.SAO222017 Se modifica la sentencia para que busque por
                                      el id de la poliza.
  17/10/2013      JCarmona.SAO220105  Se modifica la sentencia para que busque por
                                      el identificador del producto y no de la poliza.
  ******************************************************************/

  PROCEDURE GetDefferedByPol(inuProductId in ld_policy.product_id%type,
                             inuPolicy    in ld_policy.policy_number%type,
                             onuDeffered  out diferido.difecodi%type) IS

    sbHashPol varchar2(200);
    CURSOR cuDeferred(inuProductId in diferido.difenuse%type,
                      sbHashPol    in diferido.difenudo%type) IS
      SELECT /*+ index(diferido IX_DIFE_NUSE) */
       difecodi
        FROM diferido
       WHERE difenuse = inuProductId
         AND difenudo = sbHashPol
       ORDER BY difefein desc;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetDefferedByPol[' ||
                   inuProductId || ']',
                   10);
    ut_trace.Trace('inuPolicy[' || inuPolicy || ']', 10);

    sbHashPol := DBMS_UTILITY.GET_HASH_VALUE('' || inuPolicy, 2, 9999999);

    open cuDeferred(inuProductId, sbHashPol);
    fetch cuDeferred
      INTO onuDeffered;
    close cuDeferred;
    ut_trace.trace('onuDeffered ' || onuDeffered, 1);

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetDefferedByPol', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDefferedByPol;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetServsPolicy
  Descripcion    : Retorna el numero de la poliza de  un servicio suscrito

  Autor          : kbaquero
  Fecha          : 31/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuservs:       Identificador del servicio suscrito
  onupoli:        Identificador Poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetServsPolicy(inuservs in servsusc.sesunuse%type,
                           inustate in ld_policy.policy_id%type,
                           onupoli  out ld_policy.policy_id%type) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetServsPolicy', 10);

    SELECT /*+ Index(l IDX_LD_POLICY_03) */
     l.policy_id
      INTO onupoli
      FROM ld_policy l, pr_product p
     WHERE p.product_id = inuservs
       and l.state_policy = inustate
       AND p.product_id = l.product_id
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetServsPolicy', 10);
  EXCEPTION
    when no_data_found then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe poliza para el producto [' ||
                                       inuservs || '] en el estado [' ||
                                       inustate || '].');
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GetServsPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPolicyCanBySusc
  Descripcion    : Retorna un dato mayor a cero si tiene una poliza asociada y en estado activa
                 sino retorna cero

  Autor          : AAcuna
  Fecha          : 02/11/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSusc:       Identificador del suscritor
  isbState       Estado de la poliza
  onuCant:       Cantidad de polizas asociadas

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetPolicyCanBySusc(inuSusc  in suscripc.susccodi%type,
                               isbState in ld_parameter.value_chain%type,
                               onuCant  out number) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPolicyCanBySusc', 10);

    SELECT /*+ Index(l IDX_LD_POLICY_03) index(l IDX_LD_POLICY_05)*/
     count(l.policy_id)
      INTO onuCant
      FROM ld_policy l
     WHERE l.suscription_id = inuSusc
       AND regexp_instr(lpad(l.state_policy, 4, '0'), isbState) > 0;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPolicyCanBySusc', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GetPolicyCanBySusc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSecureInitialValue
  Descripcion    : Generacion de factura dependiendo si tiene un lanzamiento valido
  Autor          : AAcu?a
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSusc:         Numero de suscripcion
  inuGas_Serv:     Parametro del servicio
  onuSesuCateg:    Categoria del servicio suscrito
  onuSesuSucat:    Subcategoria del servicio suscrito
  onuSesuEstco:    Estado de corte
  onuPrProduct:    Producto
  onuGeo_Loca:     Codigo de la ubicacion geografica

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  02-12-2013      aesguerra.SAO225522 Se agrega obtencion de Barrio
  27-11-2013     hjgomez.SAO224982    Se devuelve el product_status
  22-11-2013     hjgomez.SAO224511    Se devuelve el product_id en vez del product_status_id
  ******************************************************************/

  PROCEDURE GetSecureInitialValue(inuSusc      in suscripc.susccodi%type,
                                  inuGas_Serv  in servicio.servcodi%type,
                                  onuSesuCateg out servsusc.sesucate%type,
                                  onuSesuSucat out servsusc.sesusuca%type,
                                  onuSesuEstco out servsusc.sesuesco%type,
                                  onuPrProduct out pr_product.product_status_id%type,
                                  onuGeo_Loca  out ge_geogra_location.geograp_location_id%type)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSecureInitialValue',
                   10);

    SELECT distinct s.sesucate,
                    s.sesusuca,
                    s.sesuesco,
                    pr.product_status_id,
                    decode(nvl(ad.neighborthood_id, -1),
                           -1,
                           ad.geograp_location_id,
                           ad.neighborthood_id)
      INTO onusesucateg,
           onusesusucat,
           onusesuestco,
           onuprproduct,
           onugeo_loca
      FROM servsusc s, pr_product pr, ab_address ad
     WHERE s.sesususc = inuSusc
       AND s.sesuserv = inuGas_Serv
       AND pr.product_id = s.sesunuse
       AND ad.address_id = pr.address_id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSecureInitialValue', 10);

  EXCEPTION

    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onusesucateg := 0;
      onusesusucat := 0;
      onusesuestco := 0;
      onuprproduct := 0;
      onugeo_loca  := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSecureInitialValue;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSecureInitialVal
  Descripcion    : Generacion de valor de la factura dependiendo del estado del producto,
                 categoria,subcategoria y estado de corte
  Autor          : AAcu?a
  Fecha          : 17/09/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSesuCateg:    Categoria del servicio suscrito
  inuSesuSucat:    Subcategoria del servicio suscrito
  inuSesuEstco:    Estado de corte
  inuPrProduct:    Producto
  inuGeo_Loca:     Codigo de la ubicacion geografica
  onuValue:        Valor con el resultado del cupon

  Fecha            Autor          Modificacion
  ==========  =================== =======================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  ******************************************************************/
  PROCEDURE GetSecureInitialVal(inuSesuCateg in servsusc.sesucate%type,
                                inuSesuSucat in servsusc.sesusuca%type,
                                inuSesuEstco in servsusc.sesuesco%type,
                                inuPrProduct in pr_product.product_status_id%type,
                                inuGeo_Loca  in ge_geogra_location.geograp_location_id%type,
                                onupremValue out ld_validity_policy_type.share_value%type,
                                onuvalue     out ld_validity_policy_type.policy_value%type) IS
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSecureInitialVal', 10);

    SELECT /*+
                                                        INDEX(l IDX_LD_LAUNCH_05)
                                                        INDEX(lpt IX_LD_VALIDITY_POLICY_TYPE_01 )
                                                        USE_NL(l lvpt)
                                                    */
     lvpt.share_value, lvpt.policy_value
      INTO onupremValue, onuvalue
      FROM /* Ld_BcSecureManagement.GetSecureInitialVal */
           ld_validity_policy_type lvpt,
           ld_launch               l
     WHERE l.product_state = inuprproduct
       AND l.cutting_state_id = inusesuestco
       AND l.geograp_location_id = inugeo_loca
       AND l.category_id = inusesucateg
       AND l.subcategory_id = inusesusucat
       AND sysdate between lvpt.initial_date AND lvpt.final_date
       AND lvpt.policy_type_id = l.policy_type_id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSecureInitialVal', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuvalue     := 0;
      onupremValue := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSecureInitialVal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetContractorId
  Descripcion    : Obtiene el contratista de la persona conectada.
  Autor          : AAcu?a
  Fecha          : 07/05/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  07/05/2013     AAcuna     Creacion
  ******************************************************************/

  FUNCTION GetContractorId

   RETURN or_operating_unit.Contractor_Id%type

   IS

    nuContractor_Id or_operating_unit.Contractor_Id%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetContractorId', 10);

    nuContractor_Id := daor_operating_unit.fnugetcontractor_id(ld_bcnonbankfinancing.fnuGetUnitBySeller,
                                                               0);

    RETURN nuContractor_Id;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetContractorId', 10);

  EXCEPTION

    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GetContractorId;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetStateProdSal
  Descripcion    : Retorna (1) Si el estado del tipo de producto gas asociado al contrato
                 es igual al los estados configurados para los productos de venta de seguros,
                 en caso contrario retorna cero(0).
  Autor          : AAcu?a
  Fecha          : 10/05/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc    : Numero del contrato
  isbStateProd   : Estado del producto de venta de seguros
  nuStateProdG   : Estado del tipo de producto gas

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  10/05/2013     AAcuna     Creacion
  ******************************************************************/

  FUNCTION GetStateProdSal(inuSuscripc  in suscripc.susccodi%type,
                           isbStateProd in ld_parameter.value_chain%type,
                           nuStateProdG in ld_parameter.numeric_value%type)

   RETURN number

   IS

    nuStateBySale number;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetStateProdSal', 10);

    SELECT /*+ index(s ix_servsusc12) use_nl(s p)*/
     count(1)
      INTO nuStateBySale
      from servsusc s, pr_product p
     where s.sesususc = inuSuscripc
       and s.sesuserv = nuStateProdG
       and s.sesunuse = p.product_id
       and regexp_instr(lpad(p.product_status_id, 4, '0'), isbStateProd) > 0;

    RETURN nuStateBySale;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetStateProdSal', 10);

  EXCEPTION

    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GetStateProdSal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuCuenCobr
  Descripcion    : Obtiene la ultima cuenta de cobro de un diferido
  Autor          : AAcuna
  Fecha          : 18/10/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inudifecodi      Identificador del diferido
  inuRaiseError    Controlador de error

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  08-oct-2013     aecheverry  Se adiciona el campo product_id par mejorar el rendimiento
  ******************************************************************/

  FUNCTION FnuCuenCobr(inudifecodi   in diferido.difecodi%type,
                       inuProductId  in cargos.cargnuse%type,
                       inuRaiseError in number default 1)

   RETURN cargos.cargcuco%type

   IS

    nuCuencobr cargos.cargcuco%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuCuenCobr', 10);

    SELECT /*+ idnex(c  IX_CARGOS04 ) */
     cargcuco
      INTO nuCuencobr
      FROM (SELECT c.cargcuco
              FROM cargos c
             WHERE c.cargnuse = inuProductId
               AND REGEXP_INSTR(c.cargdoso,
                                '(\W|^)' || inudifecodi || '(\W|$)') > 0
             ORDER BY c.cargfecr DESC)
     WHERE rownum = ld_boconstans.cnuonenumber;

    return nuCuencobr;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuCuenCobr', 10);

  EXCEPTION
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;

  END FnuCuenCobr;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuDateInsured
  Descripcion    : Retorna la fecha de nacimiento del asegurado
  Autor          : AAcuna
  Fecha          : 12/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuDateInsured(inuPolicy ld_policy.policy_id%type)

   RETURN NUMBER

   IS

    nuDateInsured number;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuDateInsured', 10);

    SELECT /*+ index (PK_LD_POLICY)*/
     to_char(SYSDATE, 'yyyy') - to_char(dt_insured_policy, 'yyyy')
      INTO nuDateInsured
      FROM ld_policy
     WHERE policy_id = inuPolicy;

    return nuDateInsured;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuDateInsured', 10);

  EXCEPTION
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;
  END FnuDateInsured;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuDateFirstPol
  Descripcion    : Retorna la fecha en la que compro la primera poliza
  Autor          : AAcuna
  Fecha          : 12/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuDateFirstPol(inuIdentification ld_policy.identification_id%type,
                           inuProductLine    ld_policy.product_line_id%type)

   RETURN NUMBER

   IS

    nuDateInsured number;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuDateFirstPol', 10);

    SELECT /*+ index (PK_LD_POLICY)*/
     to_char(min(dtcreate_policy), 'yyyy') -
     to_char(min(p.dt_insured_policy), 'yyyy')
      INTO nuDateInsured
      FROM ld_policy p
     WHERE p.identification_id = inuIdentification
       AND p.product_line_id = inuProductLine;

    return nuDateInsured;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuDateFirstPol', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return 0;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;
  END FnuDateFirstPol;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuValueRetPol
  Descripcion    : Retorna el valor de todas las polizas que fueron vendidas al momento en que la
                 edad del asegurado ya no lo  cobijaba
  Autor          : AAcuna
  Fecha          : 13/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentification: Numero de identificacion
  inuProductLine:    Linea de producto doble cupon
  inuDifDate:        Diferencia de edad

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuValueRetPol(inuIdentification ld_policy.identification_id%type,
                          inuProductLine    ld_policy.product_line_id%type,
                          inuDifDate        number)

   RETURN NUMBER

   IS

    nuValueReturn number;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuValueRetPol', 10);

    SELECT /*+ index (PK_LD_POLICY)*/
     SUM(ad.prem_policy)
      INTO nuValueReturn
      FROM ld_policy ad
     WHERE ad.identification_id = inuIdentification
       AND ad.product_line_id = inuProductLine
       AND ad.dtcreate_policy >
           (SELECT MIN(add_months(l.dtcreate_policy, inuDifDate * 12))
              FROM ld_policy l
             WHERE l.identification_id = ad.identification_id);

    return nuValueReturn;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuValueRetPol', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return 0;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END FnuValueRetPol;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuValRetPol
  Descripcion    : Retorna el valor de las polizas que fueron adquiridadas despues de la edad maxima para
                 coger un seguro
  Autor          : AAcuna
  Fecha          : 13/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentification:      Numero de identificacion
  inuProductLine:         Linea de producto doble cupon
  inuDifDate:             Diferencia de edad


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuValRetPol(inuIdentification ld_policy.identification_id%type,
                        inuProductLine    ld_policy.product_line_id%type,
                        inuDifDate        number)

   RETURN NUMBER

   IS

    nuValueReturn number;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuValueRetPol', 10);

    SELECT /*+ index (PK_LD_POLICY)*/
     SUM(ad.prem_policy)
      INTO nuValueReturn
      FROM ld_policy ad
     WHERE identification_id = inuIdentification
       AND ad.dtcreate_policy >=
           (SELECT MIN(add_months(l.dtcreate_policy, inuDifDate * 12))
              FROM ld_policy l
             WHERE l.identification_id = ad.identification_id)
       AND ad.product_line_id = inuProductLine;

    return nuValueReturn;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuValueRetPol', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return 0;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END FnuValRetPol;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuLiqType
  Descripcion    : Retorna el tipo de liquidacion dependiendo la causa de cancelacion
  Autor          : AAcuna
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuCancelCausa:  Causa de cancelacion
  inuProductLine:  Linea de producto doble cupon


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FnuLiqType(inuCancelCausa ld_cancel_causal.cancel_causal_id%type)

   RETURN ld_cancel_causal.liquidation_type_id%type

   IS

    nuTypeLiq ld_cancel_causal.liquidation_type_id%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuLiqType', 10);

    SELECT /*+ index (PK_LD_POLICY)*/
     l.liquidation_type_id
      INTO nuTypeLiq
      FROM ld_cancel_causal l, ld_liquidation_type lp
     WHERE l.liquidation_type_id = lp.liquidation_type_id
       AND l.cancel_causal_id = inuCancelCausa;

    return nuTypeLiq;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuLiqType', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return 0;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END FnuLiqType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad : frfGetPoliTransferDebt
  Descripcion    : Retorna el valor de las polizas que fueron adquiridadas despues de la edad maxima para
                 coger un seguro
  Autor          : AAcuna
  Fecha          : 13/12/2012 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuIdentification:      Numero de identificacion
  inuProductLine:         Linea de producto doble cupon
  inuDifDate:             Diferencia de edad
  isbState:               Estado de la poliza cuando se encuentra activa

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION frfGetPoliTransferDebt(inuIdentification ld_policy.identification_id%type,
                                  inuProductLine    ld_policy.product_line_id%type,
                                  inuDifDate        number,
                                  isbState          in ld_parameter.value_chain%type)

   RETURN constants.tyrefcursor

   IS

    rfGetPoliTransfer constants.tyrefcursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.frfGetPoliTransferDebt',
                   10);

    OPEN rfGetPoliTransfer FOR
      SELECT /*+ index (PK_LD_POLICY)*/
       ad.policy_id, ad.share_policy, ad.prem_policy
        FROM ld_policy ad, diferido d
       WHERE identification_id = inuIdentification
         AND d.difecodi = ad.deferred_policy_id
         AND d.difesape > 0
         AND regexp_instr(lpad(ad.state_policy, 4, '0'), isbState) > 0
         AND ad.dtcreate_policy >=
             (SELECT MIN(add_months(l.dtcreate_policy, inuDifDate * 12))
                FROM ld_policy l
               WHERE l.identification_id = ad.identification_id)
         AND ad.product_line_id = inuProductLine;

    ut_trace.Trace('FIN Ld_BcSecureManagement.frfGetPoliTransferDebt', 10);

    RETURN rfGetPoliTransfer;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetPoliTransferDebt;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad : frfGetOperating
  Descripcion : Retorna la unidad operativa que pertenece el tipo de poliza

  Autor : AAcuna
  Fecha : 27/03/2013

  Parametros       Descripcion
  ============  ===================
  inuPolicyType:  Tipo de poliza

  Historia de Modificaciones
  Fecha Autor Modificacion
  ========= ========= ====================
  ******************************************************************/
  FUNCTION frfGetOperating(inuPolicyType in ld_policy_type.policy_type_id%type)
    RETURN constants.tyrefcursor IS
    rfOperating_Unit constants.tyrefcursor;
    cnuDispatchClass constant number := ge_boparameter.fnuget('OR_DISPATCH_UNITCLAS');
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.frfGetOperating', 10);

    OPEN rfOperating_Unit FOR
      SELECT /*+
                                                                          leading(p)
                                                                          use_nl(p ge)
                                                                          use_nl(ge o)
                                                                          index(p PK_LD_POLICY_TYPE)
                                                                          index(gr PK_GE_CONTRATISTA)
                                                                          index(o PK_OR_OPERATING_UNIT)
                                                                      */
       o.*
        FROM /*+ Ld_BcSecureManagement.frfGetOperating */ ld_policy_type    p,
             ge_contratista    ge,
             or_operating_unit o
       WHERE p.policy_type_id = inuPolicyType
         AND ge.id_contratista = p.contratista_id
         AND o.oper_unit_classif_id <> cnuDispatchClass
         AND o.contractor_id = ge.id_contratista;

    ut_trace.Trace('FIN Ld_BcSecureManagement.frfGetOperating', 10);

    RETURN rfOperating_Unit;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetOperating;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetPolbyRen
  Descripcion    : Retorna la primera de las polizas a partir de la solicitud
  de no renovacion
  Autor          : AAcuna
  Fecha          : 29/08/2012 SAO 147879

  Parametros         Descripci?n
  ============   ===================
  inuPackage:     Solicutd de no renovacion


  Historia de Modificaciones
  Fecha            Autor       Modificaci?n
  =========      =========  ====================
  ********************************************************************/

  FUNCTION FnuGetPolbyRen(inuPackage in mo_packages.package_id%type)

   RETURN ld_policy.policy_id%type

   IS

    nuPolicy ld_policy.policy_id%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuGetPolbyRen', 10);

    SELECT /*+ index (PK_LD_POLICY)*/
     ad.policy_id
      INTO nuPolicy
      FROM ld_policy ad, ld_renewall_securp lp
     WHERE lp.package_id = inuPackage
       AND ad.dtcreate_policy >=
           (SELECT MIN(l.dtcreate_policy)
              FROM ld_policy l
             WHERE ad.policy_id = l.policy_id);

    return nuPolicy;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuGetPolbyRen', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return 0;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END FnuGetPolbyRen;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetValProd
  Descripcion    : Retorna la cantidad de lineas de producto que tiene configurada
                 el contratista.
  de no renovacion
  Autor          : Kbaquero
  Fecha          : 16/05/2013 SAO 147879

  Parametros            Descripcion
  ============         ===================
  inuProductLine:      Id. Linea de producto
  inucontract:         Id. Contratista

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  30/08/2013  jcarrillo.SAO213276 1 - Se modifica para poder utilizar varias
                                      lineas de productos
                                  2 - Se modifica para retornar el id de la linea
                                      de producto
  ******************************************************************/
  FUNCTION FnuGetValProd(isbProductLine in ps_pack_type_param.value%type,
                         inucontract    in ld_prod_line_ge_cont.contratistas_id%type)
    RETURN ld_prod_line_ge_cont.product_line_id%type IS
    nuProductLineId number;

    CURSOR cuGetProductLines IS
      SELECT l.product_line_id
        FROM ld_prod_line_ge_cont l
       WHERE instr(',' || isbProductLine || ',',
                   ',' || l.product_line_id || ',') > 0
         AND l.contratistas_id = inucontract;
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.FnuGetValProd', 10);

    open cuGetProductLines;
    fetch cuGetProductLines
      INTO nuProductLineId;
    close cuGetProductLines;

    ut_trace.Trace('FIN Ld_BcSecureManagement.FnuGetValProd', 10);

    return nuProductLineId;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuGetValProd;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetldPolicy
  Descripcion    : Retorna 1 si la fecha del sistema es igual o mayor a la fecha
                 final de la polza

  Autor          : Kbaquero
  Fecha          : 07/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Numero de la  poliza
  onuValue:         Valor


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetldPolicy(inuPolicy in ld_policy.policy_id%type,
                        onuValue  out number) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetldPolicy', 10);

    SELECT /*+ index (lpt pk_ld_policy_type) */
     count(policy_type_id)
      INTO onuValue
      FROM ld_policy
     WHERE trunc(sysdate) >= dt_en_policy
       AND policy_id = inuPolicy;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetldPolicy', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetldPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetpolitypeSecureInitialVal
  Descripcion    : Obtiene el tipo de poliza dependiende del valor y
                 las condiciones del cliente, para registrar la venta
  Autor          : Kbaquero
  Fecha          : 22/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSesuCateg:    Categoria del servicio suscrito
  inuSesuSucat:    Subcategoria del servicio suscrito
  inuSesuEstco:    Estado de corte
  inuPrProduct:    Producto
  inuGeo_Loca:     Codigo de la ubicacion geografica
  onuValue:        Valor con el resultado del cupon
  onupolitype:     Id. Tipo de poliza

  Fecha            Autor          Modificacion
  ==========  =================== =======================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  ******************************************************************/
  PROCEDURE GetpolitypeSecureInitialVal(inuSesuCateg   in servsusc.sesucate%type,
                                        inuSesuSucat   in servsusc.sesusuca%type,
                                        inuSesuEstco   in servsusc.sesuesco%type,
                                        inuPrProductST in pr_product.product_status_id%type,
                                        isbLocations   in varchar2,
                                        onupremValue   out ld_validity_policy_type.share_value%type,
                                        onuvalue       out ld_validity_policy_type.policy_value%type,
                                        onupolitype    out ld_policy_type.policy_type_id%type) IS
    cuGetPolicy constants.tyRefcursor;
    sbSQL       varchar2(4000);
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetpolitypeSecureInitialVal',
                   10);
    ut_trace.Trace('inuSesuCateg[' || inuSesuCateg || ']inuSesuSucat[' ||
                   inuSesuSucat || ']inuSesuEstco[' || inuSesuEstco ||
                   ']inuPrProductST[' || inuPrProductST,
                   10);
    ut_trace.Trace('isbLocations=' || isbLocations, 10);

    sbSQL := 'SELECT /*+
                            INDEX(l IDX_LD_LAUNCH_05)
                            INDEX(lvpt IX_LD_VALIDITY_POLICY_TYPE_01 )
                            USE_NL(l lvpt)
                        */
                       lvpt.share_value, lvpt.policy_value, l.policy_type_id
                FROM   ld_validity_policy_type lvpt, ld_launch l left join ge_geogra_location
                    on ge_geogra_location.geograp_location_id = l.geograp_location_id
                WHERE  l.product_state = :inuPrProductST
                AND    l.cutting_state_id = :inusesuestco
                AND    (l.geograp_location_id in (' ||
             nvl(isbLocations, '-1') || ')
                        OR  l.geograp_location_id IS null)
                AND    (l.category_id = :inusesucateg OR l.category_id IS null)
                AND    (l.subcategory_id = :inusesusucat OR l.subcategory_id IS null)
                AND    sysdate between lvpt.initial_date AND lvpt.final_date
                AND    lvpt.policy_type_id = l.policy_type_id
                order by l.category_id asc  nulls last,
                        l.subcategory_id asc nulls last,
                        ge_geogra_location.geog_loca_area_type desc nulls last';

    open cuGetPolicy for sbSQL
      using inuPrProductST, inusesuestco, inusesucateg, inusesusucat;
    Fetch cuGetPolicy
      INTO onupremValue, onuvalue, onupolitype;
    close cuGetPolicy;

    onupremValue := nvl(onupremValue, 0);
    onuvalue     := nvl(onuvalue, 0);

    -- ld_bosubsidy.fnugetUbication
    ut_trace.Trace('FIN Ld_BcSecureManagement.GetpolitypeSecureInitialVal',
                   10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetpolitypeSecureInitialVal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Fnunextldpolicy
  Descripcion    : Retorna el siguiente nuemero de la secuencia de
                 polizas
  Autor          : Kbaquero
  Fecha          : 22/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION Fnunextldpolicy

   RETURN number

   IS

    onupolicy ld_policy.policy_id%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.Fnunextldpolicy', 10);

    select seq_ld_policy.nextval INTO onupolicy from dual;

    return onupolicy;

    ut_trace.Trace('FIN Ld_BcSecureManagement.Fnunextldpolicy', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return 0;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END Fnunextldpolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fdtfechendtypoli
  Descripcion    : Retorna la fecha final con la que se creara las
                 polizas
  Autor          : Kbaquero
  Fecha          : 22/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inucovefech    Fecha de cobertura


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  27-08-2013  jcarrillo.SAO214742 1 - Se modifica para ingresar la fecha a la
                                      cual se le realiza la suma de los meses
  ******************************************************************/
  FUNCTION fdtfechendtypoli(inuCoveFech    in ld_validity_policy_type.coverage_month%type,
                            idtInitialDate in ld_validity_policy_type.initial_date%type)
    RETURN date IS
    odtpolicy ld_validity_policy_type.final_date%type;
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.fdtfechendtypoli', 10);

    SELECT add_months(idtInitialDate, inucovefech) - 0.00001
      Into odtpolicy
      from dual;

    ut_trace.Trace('FIN Ld_BcSecureManagement.fdtfechendtypoli', 10);
    return odtpolicy;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      return sysdate;
    when others then
      Errors.setError;
      return sysdate;
      raise ex.CONTROLLED_ERROR;
  END fdtfechendtypoli;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad : frfGetOperatingnorenew
  Descripcion : Retorna la unidad operativa que pertenece los tipos de poliza
                que se encuentran bajo la poliza
  Autor : Kbaquero
  Fecha : 26/06/2013

  Parametros       Descripcion
  ============  ===================
  inuPack:      Identificador del paquete

  Historia de Modificaciones
  Fecha Autor Modificacion
  ========= ========= ====================

  ******************************************************************/
  FUNCTION frfGetOperatingnorenew(inuPack in ld_policy_type.policy_type_id%type)

   RETURN constants.tyrefcursor

   IS

    rfOperating_Unit constants.tyrefcursor;
    cnuDispatchClass constant number := ge_boparameter.fnuget('OR_DISPATCH_UNITCLAS');

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.frfGetOperatingnorenew',
                   10);

    OPEN rfOperating_Unit FOR
      SELECT distinct o.operating_unit_id
        FROM ld_policy_type     p,
             ge_contratista     ge,
             or_operating_unit  o,
             ld_renewall_securp l
       WHERE p.contratista_id = ge.id_contratista
         AND ge.id_contratista = o.contractor_id
         AND l.policy_type_id = p.policy_type_id
         AND o.oper_unit_classif_id <> cnuDispatchClass
         AND l.package_id = inuPack;

    RETURN rfOperating_Unit;

    ut_trace.Trace('FIN Ld_BcSecureManagement.frfGetOperatingnorenew', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetOperatingnorenew;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Getcaussecure
  Descripcion    : Buscar la causal asociada a la solicitud de venta

  Autor          : Kbaquero
  Fecha          : 27/06/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Numero de la  poliza
  onuValue:         Valor


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE Getcaussecure(inuPack  in ld_secure_sale.secure_sale_id%type,
                          nucaus   in ld_secure_sale.causal_id%type,
                          onuvalue out number) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.Getcaussecure', 10);

    select count(*)
      into onuvalue
      from ld_secure_sale l
     where l.secure_sale_id = inuPack --18116
       and ((causal_id = nucaus) or (causal_id is null));

    ut_trace.Trace('FIN Ld_BcSecureManagement.Getcaussecure', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END Getcaussecure;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValPolycontrac
  Descripcion    : Retorna el tipo de poliza dependiendo del tipo
                 de poliza que envia la aseguradora en el archivo
                 plano.
  Autor          : Kbaquero
  Fecha          : 01/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuPolyType:     Codigo del tipo de poliza aseguradora
  onutipoli:      Codigo del tipo de poliza LDc.

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValPolycontrac(inuPolyType in ld_policy_type.contratist_code%type,
                               inuaseg     in ld_policy_type.contratista_id%type,
                               onutipoli   out ld_policy_type.policy_type_id%type)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValPolycontrac', 10);

    SELECT /*+ index (pt pk_ld_policy_type) */
     pt.policy_type_id
      INTO onutipoli
      FROM ld_policy_type pt
     WHERE pt.contratist_code = inuPolyType --3
       AND pt.contratista_id = inuaseg
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValPolycontrac', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onutipoli := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetServsPolicyByStat
  Descripcion    : Retorna el numero de la poliza de  un servicio suscrito del estado consultado

  Autor          : sblanco
  Fecha          : 02/01/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuservs:       Identificador del servicio suscrito
  isbPolicyStatus Estados de la poliza
  onupoli:        Identificador Poliza

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  PROCEDURE GetServsPolicyByStat(inuservs        in servsusc.sesunuse%type,
                                 isbPolicyStatus in varchar2,
                                 onupoli         out ld_policy.policy_id%type) IS

    CURSOR cuPolizasByStatus IS
      SELECT /*+ Index(l IDX_LD_POLICY_03) */
       l.policy_id
        FROM ld_policy l, pr_product p
       WHERE p.product_id = inuservs
         AND p.product_id = l.product_id
         AND INSTR(isbPolicyStatus, ',' || l.state_policy || ',') > 0;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetServsPolicyByStat', 10);

    FOR rc IN cuPolizasByStatus LOOP
      onupoli := rc.policy_id;
    END LOOP;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetServsPolicyByStat', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GetServsPolicyByStat;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliActpoli
  Descripcion    : Valida que no exista solicitud activa del mismo tipo de
  Autor          : kbaquero
  Fecha          : 26/09/2012 SAO 159429

  Parametros         Descripcion
  ============   ===================
  inuSusc:       Numero del suscritoR
  inuMotype:     Codigo del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliActpoli(inuMotype   in pr_product.product_type_id%type,
                            inuEstapack in mo_packages.motive_status_id%type,
                            inupoli     in ld_policy.policy_id%type,
                            onucant     out number) is

  BEGIN
    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);
    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(*)
      INTO onucant
      FROM mo_packages P, mo_motive M, ld_renewall_securp l
     WHERE P.package_id = M.package_id
       AND l.package_id = p.package_id
       AND p.motive_status_id = inuEstapack
       AND p.package_type_id = inuMotype
       and l.policy_id = inupoli;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearDeferred', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onucant := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSoliActpoli;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProdparam
  Descripcion    : Valida
  Autor          : AAcu?a
  Fecha          : 09/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:     Suscripcion
  inuprotype:
  isbState:     Estado de la poliza
  onuCantId:     Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValProdparam(inuSuscripc in suscripc.susccodi%type,
                             inuprotype  in pr_product.product_type_id%type,
                             isbState    in ld_parameter.value_chain%type,
                             onuCantId   out number)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValProdparam', 10);

    SELECT /*+ index (p PK_LD_POLICY) index(p IDX_LD_POLICY_05) */
     count(*)
      INTO onuCantId
      FROM pr_product p
     WHERE p.subscription_id = inuSuscripc --12919
       AND p.product_type_id = inuprotype --7014
       AND regexp_instr(lpad(p.product_status_id, 4, '0'), isbState) > 0
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValProdparam', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuCantId := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValProdparam;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ValidateProdEstacort
  Descripcion    : Valida que el contrato tenga gas en los estado
                   de corte permitido
  Autor          : jcarrillo
  Fecha          : 03/09/2013

  Parametros               Descripcion
  ============         ===================
  inuSubscriptionId:     Identificador del contrato

  Historia de Modificaciones
  Fecha         Autor             Modificacion
  =========   =================== ==========
  03/09/2013  jcarrillo.SAO214416 1 - Creacion
  ******************************************************************/
  PROCEDURE ValidateProdEstacort(inuSuscripc in suscripc.susccodi%type,
                                 inuprotype  in pr_product.product_type_id%type,
                                 isbState    in ld_parameter.value_chain%type,
                                 onuCantId   out number) IS
    csbPIPE varchar2(10) := ge_boconstants.csbPIPE;

    CURSOR cuValProdEstacort IS
      SELECT /*+ index (p PK_LD_POLICY) index(p IDX_LD_POLICY_05) */
       count(*)
        FROM Servsusc
       WHERE Servsusc.sesususc = inuSuscripc
         AND Servsusc.sesuserv = inuprotype
         AND instr(csbPIPE || isbState || csbPIPE,
                   csbPIPE || Servsusc.sesuesco || csbPIPE) > 0
         AND rownum = 1;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcValProdparam', 10);

    open cuValProdEstacort;
    fetch cuValProdEstacort
      INTO onuCantId;
    close cuValProdEstacort;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcValProdparam', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuValProdEstacort%isopen) then
        close cuValProdEstacort;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuValProdEstacort%isopen) then
        close cuValProdEstacort;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidateProdEstacort;

  /************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetPolicyTypeByConf
  Descripcion    : Obtiene tipos de poliza por configuracion
  Autor          : jonathan alberto consuegra lara
  Fecha          : 10/10/2012

  Parametros       Descripcion
  ============     ===================
  inuDeal_Id       identificador del convenio

  Historia de Modificaciones
  Fecha     Autor         Modificacion
  =========   =========       ====================
  29/10/2013    aesguerra.SAO211554   Se actualiza consulta para incluir
                                    barrios
  07/09/2013    mmeusburgger.SAO214427  Se modifica tipo dato para la
                      linea de producto
  10/10/2012    jconsuegra        Creacion
  /*************************************************************************/

  FUNCTION fnuGetPolicyTypeByConf(isbproduct_line_id     in ld_parameter.value_chain%type,
                                  inucutting_state_id    in ld_launch.cutting_state_id%type,
                                  inuproduct_state       in ld_launch.product_state%type,
                                  inucategory_id         in ld_launch.category_id%type,
                                  inusubcategory_id      in ld_launch.subcategory_id%type,
                                  inugeograp_location_id in ld_launch.geograp_location_id %type)
    return number IS

    VNUTIPOPOLIZA      number := 0;
    cuPolicyTypeByConf constants.tyRefCursor;
    sbLocation         varchar2(300);
    sbproduct_line_id  ld_parameter.value_chain%type;
    sbSQL              varchar2(4000);

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.fnuGetPolicyTypeByConf',
                   10);

    ge_bogeogra_location.getgeograpparents(inugeograp_location_id,
                                           sbLocation);

    ut_trace.trace('Ubicacion Geografica: ' || sbLocation, 10);

    sbproduct_line_id := replace(isbproduct_line_id, '|', ',');

    sbSQL := 'SELECT ld.policy_type_id' ||
             ' FROM ld_launch ld, ge_geogra_location ge' ||
             ' WHERE ld.geograp_location_id = ge.geograp_location_id(+)' ||
             ' AND ld.product_line_id in ( ' || sbproduct_line_id || ' )' ||
             ' AND ld.cutting_state_id = :inuSesuEsco' ||
             ' AND ld.Product_State = :inuProdState' ||
             ' AND (ld.category_id = :inuCateId or ld.category_id is null OR ld.category_id = -1)' ||
             ' AND (ld.subcategory_id = :inuSucaId or ld.subcategory_id is null OR ld.subcategory_id = -1)' ||
             ' and (ld.geograp_location_id in ( ' || sbLocation ||
             ' ) or ld.geograp_location_id is null)' ||
             ' ORDER BY ld.category_id asc nulls last,' ||
             ' ld.subcategory_id asc nulls last,' ||
             ' ge.geog_loca_area_type desc nulls last';

    IF cuPolicyTypeByConf%ISOPEN THEN
      CLOSE cuPolicyTypeByConf;
    END IF;

    OPEN cuPolicyTypeByConf for sbSQL
      using inucutting_state_id, inuproduct_state, inucategory_id, inusubcategory_id;

    FETCH cuPolicyTypeByConf
      INTO VNUTIPOPOLIZA;

    IF cuPolicyTypeByConf%notfound THEN
      VNUTIPOPOLIZA := 0;
    END IF;

    CLOSE cuPolicyTypeByConf;

    ut_trace.Trace('FIN Ld_BcSecureManagement.fnuGetPolicyTypeByConf', 10);

    return VNUTIPOPOLIZA;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPolicyTypeByConf;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSecureInitialValtipo
  Descripcion    : Generacion de valor de la factura dependiendo del tipo de poliza encontrado
                 con la configuracion del lanzamiento
  Autor          : AAcu?a
  Fecha          : 17/07/2013 SAO 147879

  Parametros         Descripcion
  ============   ===================
  inuSesuCateg:    Categoria del servicio suscrito
  inuSesuSucat:    Subcategoria del servicio suscrito
  inuSesuEstco:    Estado de corte
  inuPrProduct:    Producto
  inuGeo_Loca:     Codigo de la ubicacion geografica
  onuValue:        Valor con el resultado del cupon


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  27-08-2013  jcastro.SAO214742   1 - Se impacta por modificar la entidad
                                      <ld_policy> y creacion de la entidad
                                      <ld_validity_policy_type>
  ******************************************************************/
  PROCEDURE GetSecureInitialValtipo(inutypoli    in ld_policy_type.policy_type_id%type,
                                    onupremValue out ld_validity_policy_type.share_value%type) IS
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSecureInitialValtipo',
                   10);

    SELECT /*+
                                                        INDEX(lvpt IX_LD_VALIDITY_POLICY_TYPE_01 )
                                                    */
     lvpt.share_value
      INTO onupremValue
      FROM /*+ Ld_BcSecureManagement.GetSecureInitialValtipo */
           ld_validity_policy_type lvpt
     WHERE sysdate between lvpt.initial_date AND lvpt.final_date
       AND lvpt.policy_type_id = inutypoli
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSecureInitialValtipo', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onupremValue := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSecureInitialValtipo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetPolicysByVality
  Descripcion    : Obtienen las polizas dado una Vigencia
  Autor          : JCarrillo
  Fecha          : 31/08/2013

  Parametros         Descripcion
  ============   ===================
  inuValPoliType  Vigencia de Tipo de Poliza
  otbPolicys      Polizas asociadas a la viegncia.

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  31/08/2013  jcarrillo.SAO216037 1 - Creacion
  ******************************************************************/
  PROCEDURE GetPolicysByVality(inuValPoliType in ld_validity_policy_type.validity_policy_type_id%type,
                               otbPolicys     out dald_policy.tytbLD_POLICY) IS
    CURSOR cuGetPolicys IS
      SELECT LD_POLICY.*, LD_POLICY.rowid
        FROM LD_POLICY
       WHERE LD_POLICY.validity_policy_type_id = inuValPoliType;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPolicysByVality', 10);

    open cuGetPolicys;
    fetch cuGetPolicys bulk collect
      INTO otbPolicys;
    close cuGetPolicys;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPolicysByVality', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetPolicys%isopen) then
        close cuGetPolicys;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetPolicys%isopen) then
        close cuGetPolicys;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPolicysByVality;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetOrderByActSubscrib
  Descripcion    : Obtienen la orden no finalizada dada la actividad  y el cliente
  Autor          : JCarrillo
  Fecha          : 02/09/2013

  Parametros         Descripcion
  ============   ===================
  inuSubscriber  Cliente
  inuActVisit    Actividad de Visita
  orcActOrder    Actividad de Orden del Tipo Visita

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  31/08/2013  jcarrillo.SAO211267 1 - Creacion
  ******************************************************************/
  PROCEDURE GetOrderByActSubscrib(inuSubscriber in ge_subscriber.subscriber_id%type,
                                  inuActVisit   in or_order_activity.activity_id%type,
                                  orcActOrder   out nocopy daor_order_activity.styOR_order_activity) IS
    CURSOR cuGetActOrders IS
      SELECT or_order_activity.*, or_order_activity.rowid
        FROM /*+ Ld_BcSecureManagement.GetOrderByActSubscrib */
             or_order_activity,
             or_order
       WHERE or_order_activity.activity_id = inuActVisit
         AND or_order_activity.subscriber_id = inuSubscriber
         AND or_order.order_id = or_order_activity.order_id
         AND or_order.order_status_id !=
             or_boconstants.cnuORDER_STAT_CLOSED;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetOrderByActSubscrib',
                   10);

    open cuGetActOrders;
    fetch cuGetActOrders
      INTO orcActOrder;
    close cuGetActOrders;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetOrderByActSubscrib', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetActOrders%isopen) then
        close cuGetActOrders;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetActOrders%isopen) then
        close cuGetActOrders;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetOrderByActSubscrib;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetOperatingUnit
  Descripcion    : Obtienen la unidad operativa dada el contratista
  Autor          : JCarrillo
  Fecha          : 02/09/2013

  Parametros         Descripcion
  ============   ===================
  inuContrator    Contratrista
  orcUnit         Unidad Operativa

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  31/08/2013  jcarrillo.SAO211267 1 - Creacion
  ******************************************************************/
  PROCEDURE GetOperatingUnit(inuContrator in ge_contratista.id_contratista%type,
                             orcUnit      out nocopy daor_operating_unit.styor_operating_unit) IS
    CURSOR cuGetOperatingUnit IS
      SELECT or_operating_unit.*, or_operating_unit.rowid
        FROM /*+ Ld_BcSecureManagement.GetOperatingUnit */
             or_operating_unit
       WHERE or_operating_unit.contractor_id = inuContrator;
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetOperatingUnit', 10);

    open cuGetOperatingUnit;
    fetch cuGetOperatingUnit
      INTO orcUnit;
    close cuGetOperatingUnit;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetOperatingUnit', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetOperatingUnit%isopen) then
        close cuGetOperatingUnit;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetOperatingUnit%isopen) then
        close cuGetOperatingUnit;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetOperatingUnit;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicy
  Descripcion    : Obtiene poliza activa para un tipo de poliza y subscripcion
  Autor          : Mahicol Meusburgger A
  Fecha          : 06/09/2013

  Parametros         Descripcion
  ============   ===================
  inuContrator    Contratrista
  orcUnit         Unidad Operativa

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  06-09-2013  mmeusburgger.SAO214427 Creacion
  ******************************************************************/
  PROCEDURE GetValidityPolicy(inuSubscription   in suscripc.susccodi%type,
                              inuPolicyType     in ld_policy.policy_type_id%type,
                              idtDate           in ld_policy.dt_in_policy%type,
                              orfValidityPolicy out constants.tyRefCursor) IS

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetValidityPolicyType',
                   10);

    if (orfValidityPolicy%isopen) then
      close orfValidityPolicy;
    end if;

    OPEN orfValidityPolicy for
      SELECT /*+ index (ld_policy PK_LD_POLICY) */
       LD_POLICY.*, LD_POLICY.rowid
        FROM /*+ Ld_BcSecureManagement.GetValidityPolicy SAO214427 */
             ld_policy
       WHERE ld_policy.suscription_id = inuSubscription
         AND ld_policy.policy_type_id = inuPolicyType
         AND ld_policy.state_policy = cnuCODSTATEACT
         AND idtDate between ld_policy.dt_in_policy and
             ld_policy.dt_en_policy;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetValidityPolicyType', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (orfValidityPolicy%isopen) then
        close orfValidityPolicy;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (orfValidityPolicy%isopen) then
        close orfValidityPolicy;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetValidityPolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicy
  Descripcion    : Obtiene polizas en estado activa y renovada
                   para un tipo de poliza y subscripcion
  Autor          : Mahicol Meusburgger A
  Fecha          : 06/09/2013

  Parametros         Descripcion
  ============   ===================
  inuContrator    Contratrista
  orcUnit         Unidad Operativa

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  07/09/2013  mmeusburgger.SAO214427 Se modifica la consulta.
  06-09-2013  mmeusburgger.SAO214427 Creacion
  ******************************************************************/
  PROCEDURE SearchServPolicyState(inuSubscription in suscripc.susccodi%type,
                                  inuPolicyType   in ld_policy.policy_type_id%type,
                                  orfPolicyState  out constants.tyRefCursor) IS
  BEGIN
    if (orfPolicyState%isopen) then
      close orfPolicyState;
    end if;

    OPEN orfPolicyState FOR
      SELECT /*+ index (ld_policy PK_LD_POLICY) */
       ld_policy.policy_id
        FROM /*+ Ld_BcSecureManagement.SearchServPolicyState SAO214427*/
             ld_policy
       WHERE ld_policy.suscription_id = inuSubscription
         AND ld_policy.policy_type_id = inuPolicyType
         AND ld_policy.state_policy NOT IN (cnuCODSTATEACT, cnuCODSTATEREN);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (orfPolicyState%isopen) then
        close orfPolicyState;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (orfPolicyState%isopen) then
        close orfPolicyState;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END SearchServPolicyState;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValidityPolicy
  Descripcion    : Obtiene polizas en estado activa y renovada
                   para un tipo de poliza y subscripcion
  Autor          : Mahicol Meusburgger A
  Fecha          : 06/09/2013

  Parametros         Descripcion
  ============   ===================
  inuContrator    Contratrista
  orcUnit         Unidad Operativa

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  06-09-2013  mmeusburgger.SAO214427 Creacion
  ******************************************************************/
  FUNCTION ValidatePoliCancel(inuPolicyId in ld_policy.policy_id%type,
                              sbCausals   in ld_parameter.value_chain%type)
    return boolean IS
    CURSOR cuPolicyCancel IS
      SELECT count(ld_secure_cancella.policy_id)
        FROM /*+ Ld_BcSecureManagement.ValidatePoliCancel SAO214427*/
             ld_secure_cancella
       WHERE ld_secure_cancella.policy_id = inuPolicyId
         AND instr('|' || sbCausals || '|',
                   '|' || ld_secure_cancella.cancel_causal_id || '|') > 0
         AND rownum = 1;

    nuPolicyCancel ld_secure_cancella.secure_cancella_id%type;

  BEGIN

    open cuPolicyCancel;
    fetch cuPolicyCancel
      INTO nuPolicyCancel;
    close cuPolicyCancel;

    if (nuPolicyCancel > 0) then
      return TRUE;
    else
      return FALSE;
    END if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicyCancel%isopen) then
        close cuPolicyCancel;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicyCancel%isopen) then
        close cuPolicyCancel;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidatePoliCancel;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValuesPolicyByProd
  Descripcion    : Obtiene el valor de todas las polizas del producto que
                   se encuentren en los estados activas y renovadas
  Autor          : jcarrillo
  Fecha          : 06/09/2013

  Parametros               Descripcion
  ============         ===================
  ircPolicy           Registro de la Poliza
  ircSecCancell       Registro de ld_secure_cancella
  onuValue            Valor a devolver

  Historia de Modificaciones
  Fecha         Autor             Modificacion
  =========   =================== ==========
  03/09/2013  jcarrillo.SAO214516 1 - Creacion
  ******************************************************************/
  PROCEDURE GetValuesPolicyByProd(inuProduct     in ld_policy.product_id%type,
                                  onuTotalValues out number,
                                  onuTotalFees   out number) IS
    csbPIPE varchar2(10) := ge_boconstants.csbPIPE;

    CURSOR cuValuesPolicyByProd IS
      SELECT sum(ld_policy.value_policy) total_value,
             sum(ld_policy.share_policy) total_fees
        FROM /*+ Ld_BCSecureManagement.GetValuesPolicyByProd */ ld_policy
       WHERE ld_policy.product_id = inuProduct
         AND ld_policy.state_policy IN (cnuCODSTATEACT, cnuCODSTATEREN);
  BEGIN
    open cuValuesPolicyByProd;
    fetch cuValuesPolicyByProd
      INTO onuTotalValues, onuTotalFees;
    close cuValuesPolicyByProd;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuValuesPolicyByProd%isOpen) then
        close cuValuesPolicyByProd;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuValuesPolicyByProd%isOpen) then
        close cuValuesPolicyByProd;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetValuesPolicyByProd;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetPackageCancel
  Descripcion    : Indica si la poliza registrada tiene una solicitud de cancelacion
                   en estado registrado
  de no renovacion
  Autor          : jrobayo
  Fecha          : 07/09/2013 SAO 147879

  Parametros         Descripci?n
  ============   ===================
  inuPolicy:     Poliza a verificar

  Historia de Modificaciones
  Fecha            Autor       Modificaci?n
  =========      =========  ====================
  ********************************************************************/

  FUNCTION fblGetPackageCancel(inuPolicy in ld_policy.policy_id%type)
    return boolean IS
    CURSOR cbPackages IS
      SELECT count(*) /*+index (PK_LD_SECURE_CANCELLA) +index(IDX_MO_PACKAGES_026)*/
        FROM ld_secure_cancella lsCanc, mo_packages mPack
       WHERE mPack.package_id = lsCanc.secure_cancella_id
         AND lsCanc.policy_id = inuPolicy
         AND mPack.motive_status_id in (13);

    nuCantPack mo_packages.package_id%type;

  BEGIN
    open cbPackages;
    fetch cbPackages
      INTO nuCantPack;
    close cbPackages;

    if (nuCantPack > 0) then
      return TRUE;
    else
      return FALSE;
    END if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cbPackages%isopen) then
        close cbPackages;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cbPackages%isopen) then
        close cbPackages;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblGetPackageCancel;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberId
  Descripcion    : Obtienen el id de un suscriptor dada su identificacion
  Autor          : jrobayo
  Fecha          : 24/10/2013

  Parametros         Descripcion
  ============   ===================
  isbIdentification    Identificacion del cliente
  orcIdSubscId         Id de cliente

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  24/10/2013  jrobayo.SAO221262 1 - Creacion
  12/05/2016  socoro. CA 100-12855  Nodificaci?n del cursor para mejorar desempe?o
  ******************************************************************/

  PROCEDURE GetSubscriberId(isbIdentification in ge_subscriber.identification%type,
                            orcIdSubscId      out ge_subscriber.subscriber_id%type)

   IS
    CURSOR cuGetSubscriberId IS
  SELECT /*+ FIRST_ROW */
       gs.subscriber_id
        FROM ge_subscriber gs
       WHERE gs.identification like isbIdentification;
    --CA 100-12855
      /*SELECT \*+ index (gs PK_GE_SUBSCRIBER)*\
       gs.subscriber_id
        FROM ge_subscriber gs
       WHERE gs.identification like isbIdentification;*/

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSubscriberId', 10);

    open cuGetSubscriberId;
    fetch cuGetSubscriberId
      INTO orcIdSubscId;
    close cuGetSubscriberId;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSubscriberId', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetSubscriberId%isopen) then
        close cuGetSubscriberId;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetSubscriberId%isopen) then
        close cuGetSubscriberId;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSubscriberId;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddressFromSinister
  Descripcion    : Obtiene la direccion parseada y la ubicacion
                   geografica de ab_address para el reporte de siniestros
  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 24/10/2013

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:        Numero del suscritor
  inuProductTypeId:   Tipo de Producto Registrado
  onuAddress:         Direccion Parseada
  onuParserAddress:   Identificador de la direccion
  onuGeo:             Ubicacion Geografica


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  29-01-2014      AEcheverrySAO231292 se modifica sentencia para mejorar el rendimiento
  24-10-2013      JCarmona.SAO221126      Creacion.
  ******************************************************************/
  PROCEDURE GetAddressFromSinister(inuSuscripc      in suscripc.susccodi%type,
                                   inuProductTypeId in mo_motive.product_type_id%type,
                                   onuAddress       out mo_address.address%type,
                                   onuParserAddress out mo_address.parser_address_id%type,
                                   onuGeograpLoc    out mo_address.geograp_location_id%type) IS

    nuGasService servicio.servcodi%type;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetAddressFromSinister',
                   10);

    nuGasService := ld_boconstans.cnuGasService;

    SELECT /*+ index(a IDX_PR_PRODUCT_010) index(s PK_SERVSUSC) */
     a.address_id,
     daab_address.fsbgetaddress_parsed(a.address_id),
     daab_address.fnugetgeograp_location_id(a.address_id)
      INTO onuParserAddress, onuAddress, onuGeograpLoc
      FROM pr_product a, servsusc s, ps_product_status c
     WHERE a.subscription_id = inuSuscripc
       AND a.product_type_id in (nuGasService, inuProductTypeId)
       AND s.sesususc = a.subscription_id
       AND s.sesunuse = a.product_id
       AND (s.sesufere is null OR s.sesufere > sysdate)
       AND c.product_status_id = a.product_status_id
       AND c.is_active_product = 'Y'
       and rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetAddressFromSinister', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato no posee producto GAS ni producto ' ||
                                       pktblservicio.fsbgetdescription(inuProductTypeId) ||
                                       ' en estado Activo');
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetAddressFromSinister;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetLocalDepart
  Descripcion    : Retorna 1 si la localidad pertenece al departamento

  Autor          : jhagudelo
  Fecha          : 28/10/2013 SAO 221435

  Parametros         Descripcion
  ============   ===================
  inuLocalid:    Localidad
  inuDepart:     Departamento


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  ******************************************************************/
  FUNCTION GetLocalDepart(inuLocalid in ge_geogra_location.geograp_location_id%type,
                          inuDepart  in ge_geogra_location.geo_loca_father_id%type)
    RETURN NUMBER IS
    onuValue NUMBER;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetLocalDepart', 10);

    SELECT count(geograp_location_id)
      INTO onuValue
      FROM ge_geogra_location ggl
     WHERE ggl.geograp_location_id = inuLocalid
       AND ggl.geo_loca_father_id = inuDepart;

    return onuValue;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetLocalDepart', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetLocalDepart;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetDepart
  Descripcion    : Obtiene el departamento

  Autor          : jhagudelo
  Fecha          : 28/10/2013 SAO 221435

  Parametros         Descripcion
  ============   ===================
  inuDepart:     Departamento


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  10/07/2015  mgarcia.SAO334174   Se modifica la consulta agregando el filtro
                                  por el campo geog_loca_area_type
  ==========  =================== =======================
  ******************************************************************/
  FUNCTION GetDepart(inuDepart in ge_geogra_location.geo_loca_father_id%type)
    RETURN NUMBER IS
    onuValueDep NUMBER;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetLocalDepart', 10);

    SELECT ggl.geograp_location_id
      INTO onuValueDep
      FROM ge_geogra_location ggl
     WHERE ggl.geograp_location_id = inuDepart
       AND ggl.geog_loca_area_type = 2;

    return onuValueDep;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetLocalDepart', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDepart;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValProdLoc
  Descripcion    : Valida
  Autor          : jhagudelo
  Fecha          : 28/10/2013 SAO 221435

  Parametros         Descripcion
  ============   ===================
  inuProduct:    Suscripcion del producto


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
  FUNCTION ProcValProdLoc(inuSuscrip in pr_product.subscription_id%type)
    RETURN NUMBER IS
    onuValueDep  NUMBER;
    nuGasService number;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetLocalDepart', 10);

    nuGasService := ld_boconstans.cnuGasService;

    SELECT a.geograp_location_id
      INTO onuValueDep
      FROM pr_product p, ab_address a
     WHERE p.subscription_id = inuSuscrip
       AND p.product_type_id = nuGasService
       AND p.address_id = a.address_id
       AND rownum = 1;

    return onuValueDep;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetLocalDepart', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValProdLoc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetAddressCancelByFile
  Descripcion    : Obtiene la direccion parseada y la ubicacion
                   geografica de ab_address para la cancelacion de seguros por
                   archivo plano
  Autor          : Jhonny Agudelo Oviedo
  Fecha          : 29/10/2013

  Parametros         Descripcion
  ============   ===================
  inuSuscripc:        Numero del suscritor
  inuProductTypeId:   Tipo de Producto Registrado
  onuAddress:         Direccion Parseada
  onuParserAddress:   Identificador de la direccion
  onuGeo:             Ubicacion Geografica


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  29-01-2014      AEcheverrySAO231292 se modifica sentencia para mejorar el rendimiento
  29-10-2013      Jhagudelo.SAO221680     Creacion.
  ******************************************************************/
  PROCEDURE GetAddressCancelByFile(inuSuscripc  in suscripc.susccodi%type,
                                   onuValue     out ab_address.address_id%type,
                                   onuGeo       out ge_geogra_location.geograp_location_id%type,
                                   onAddrParsed out mo_address.address%type) is

    nuGasService servicio.servcodi%type;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetAddressCancelByFile',
                   10);

    nuGasService := ld_boconstans.cnuGasService;

    SELECT /*+ index(a IDX_PR_PRODUCT_010) index(s PK_SERVSUSC) */
     a.address_id,
     daab_address.fnugetgeograp_location_id(a.address_id),
     daab_address.fsbgetaddress_parsed(a.address_id)
      INTO onuValue, onuGeo, onAddrParsed
      FROM pr_product a, servsusc s, ps_product_status c
     WHERE a.subscription_id = inuSuscripc
       AND a.product_type_id = nuGasService
       AND s.sesususc = a.subscription_id
       AND s.sesunuse = a.product_id
       AND (s.sesufere is null OR s.sesufere > sysdate)
       AND c.product_status_id = a.product_status_id
       AND c.is_active_product = 'Y'
       and rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetAddressCancelByFile', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       '  No se encontro ninguna direccion asociada al contrato ' ||
                                       inuSuscripc);
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetAddressCancelByFile;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSolicNoRenewall
  Descripcion    : Identifica si una poliza tiene solicitudes de
                   no renovacion con orden en estado cerrado
  Autor          : Jhonny Agudelo Oviedo
  Fecha          : 31/10/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Id de la poliza


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  31-10-2013      Jhagudelo.SAO222017     Creacion.
  ******************************************************************/

  FUNCTION GetSolicNoRenewall(inuPolicy in ld_policy.policy_id%type)
    RETURN NUMBER IS
    onuExistNoRen NUMBER;
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.ObtSolicNoRenewall', 10);

    SELECT count(*)
      INTO onuExistNoRen
      FROM ld_renewall_securp, or_order, OR_ORDER_ACTIVITY, ge_causal
     WHERE ld_renewall_securp.policy_id = inuPolicy
       AND OR_ORDER_ACTIVITY.package_id = ld_renewall_securp.package_id
       AND OR_ORDER_ACTIVITY.order_id = or_order.order_id
       AND or_order.order_status_id = 8
       AND or_order.causal_id = ge_causal.causal_id
       AND ge_causal.class_causal_id = 2
       AND rownum = 1;

    return onuExistNoRen;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ObtSolicNoRenewall', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSolicNoRenewall;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSuscPol
  Descripcion    : Obtiene el contrato al cual se encuentra
                   asociado la poliza
  Autor          : Jhonny Agudelo Oviedo
  Fecha          : 01/11/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicy:       Id de la poliza


  Historia de Modificaciones
  Fecha            Autor                  Modificacion
  =========       =========               ====================
  01-11-2013      Jhagudelo.SAO222017     Creacion.
  ******************************************************************/

  PROCEDURE GetSuscPol(inuPolicy in ld_policy.policy_id%type,
                       onuSusc   out suscripc.susccodi%type) IS
  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSuscPol', 10);

    SELECT SUSCRIPC.susccodi
      INTO onuSusc
      FROM ld_policy, pr_product, SUSCRIPC
     WHERE pr_product.product_id = ld_policy.product_id
       AND ld_policy.policy_id = inuPolicy
       AND pr_product.subscription_id = suscripc.susccodi
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSuscPol', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       '  No se encontro ningun contrato asociado a la poliza ' ||
                                       inuPolicy);
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSuscPol;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGetSecureSale
  Descripcion    : Obtiene el registro de venta de seguros dado el id de la poliza
  Autor          : Jorge Alejandro Carmona Duque
  Fecha          : 27/11/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  27/11/2013  JCarmona.SAO224868  1 - Creacion
  ******************************************************************/

  FUNCTION fnuGetSecureSale(inuPolicyId in ld_secure_sale.policy_number%type)
    return dald_secure_sale.styLD_secure_sale IS
    CURSOR cuGetSecureSale(nuPolicyId in ld_secure_sale.policy_number%type) IS
      SELECT /*+ index (gs UX_LD_SECURE_SALE)*/
       ss.*, ss.rowid
        FROM ld_secure_sale ss
       WHERE ss.policy_number = nuPolicyId;

    orcSecureSale dald_secure_sale.styLD_secure_sale;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.fnuGetSecureSale[' ||
                   inuPolicyId || ']',
                   10);

    open cuGetSecureSale(inuPolicyId);
    fetch cuGetSecureSale
      INTO orcSecureSale;
    close cuGetSecureSale;

    ut_trace.Trace('FIN Ld_BcSecureManagement.fnuGetSecureSale', 10);

    return orcSecureSale;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetSecureSale%isopen) then
        close cuGetSecureSale;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetSecureSale%isopen) then
        close cuGetSecureSale;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetSecureSale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetFessInvoiced
  Descripcion    : Obtiene el numero de cuotas facturadas del diferido
                   asociado a una poliza de seguros.
  Autor          : FCastro
  Fecha          : 13/07/2017

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  13/07/2013  FCastro.200-1058    1 - Creacion
  ******************************************************************/

  FUNCTION FnuGetFessInvoiced(inuPolicy in ld_policy.policy_id%type)
    return number is

    nuFeesInvoiced    number;
    nuDiferido    ld_policy.deferred_policy_id%type;
    nuValorCuota  ld_policy.prem_policy%type;
    sbCargdoso    cargos.cargdoso%type;
    nuNumCuotas   ld_policy.share_policy%type;
    nuCuenta      cuencobr.cucocodi%type;
    nuSaldoCuenta cuencobr.cucosacu%type;
    nuCuotasPend  ld_policy.fees_to_return%type;
    nuCausalCargo cargos.cargcaca%type := DALD_PARAMETER.fnuGetNumeric_Value('FNB_CAUSAL_CARGO');

    --21-01-2015 Llozada [NC 4038]: Cuentas de cobro asociadas al diferido que NO han sido pagadas
    Cursor cuCuentasCobro(sbDife       cargos.cargdoso%type,
                          nuValorCuota ld_policy.prem_policy%type) IS
      /*select sum(cuotas_pagadas)
        from (select cucocodi,
                     cucovato,
                     CEIL(cucovato / nuValorCuota) cuotas_pagadas
                from cargos, cuencobr
               where cargdoso = sbDife
                 and cargcuco = cucocodi
                 and cargcaca = nuCausalCargo
                 and nvl(cucosacu,0) > 0
                 and cucovato > 0
                 and CEIL(cucovato / nuValorCuota) > 0);*/
         select COUNT(1) from
           (Select distinct(cargcuco)
             from cargos
            where cargdoso = sbDife
              and cargcaca = 51
              and cargprog=5
              and cargvalo=nuValorCuota
              and cargsign='DB');

    --21-01-2015 Llozada [NC 4038]: Se trae el diferido de la poliza
    CURSOR cuPoliza IS
      Select deferred_policy_id, prem_policy, share_policy
        from ld_policy
       where policy_id = inuPolicy;

    /*21-01-2015 Llozada [NC 4038]: Se comenta porque se debe calcular el valor de las
    cuotas pagadas*/
    /*CURSOR cuGetFess is
    SELECT d.difecupa
    from diferido d, ld_policy l
    where l.deferred_policy_id=d.difecodi
    and l.policy_id= inuPolicy;*/

  BEGIN

    ut_trace.trace('Inicio ld_bcsecuremanagement.FnuGetFessInvoiced', 10);

    open cuPoliza;
    fetch cuPoliza
      into nuDiferido, nuValorCuota, nuNumCuotas;
    close cuPoliza;

    if nuDiferido is not null then
      sbCargdoso := 'DF-' || nuDiferido;

      open cuCuentasCobro(sbCargdoso, nuValorCuota);
      fetch cuCuentasCobro
        into nuFeesInvoiced;
      close cuCuentasCobro;

      if nuFeesInvoiced is not null then
        return nuFeesInvoiced;
      end if;
    end if;

    /*21-01-2015 Llozada [NC 4038]: Se comenta porque se debe calcular el valor de las
    cuotas pagadas*/
    /*open  cuGetFess;
    fetch cuGetFess INTO nuFeesInvoiced;
    close cuGetFess; */

    return 0;

    ut_trace.trace('Inicio ld_bcsecuremanagement.FnuGetFessInvoiced', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuGetFessInvoiced;

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetFessPaid
  Descripcion    : Obtiene el numero de cuotas pagadas del diferido
                   asociado a una poliza de seguros.
  Autor          : John Wilmer Robayo Sanchez
  Fecha          : 19/12/2013

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  18-03-2015  Llozada [NC 4038]  Se toman solo las cuentas de los cargos con causal FNB_CAUSAL_CARGO
  24-02-2015  Llozada [NC 4038]  Se toman solo las cuentas con el cucovato mayor a CERO
  22-01-2015  llozada [NC 4038]  Se modifica la logica para calcular el valor de las cuotas pagadas
  19/12/2013  jrobayo.SAO228348  1 - Creacion
  ******************************************************************/

  FUNCTION FnuGetFessPaid(inuPolicy in ld_policy.policy_id%type)
    return number is

    nuFeesPaid    number;
    nuDiferido    ld_policy.deferred_policy_id%type;
    nuValorCuota  ld_policy.prem_policy%type;
    sbCargdoso    cargos.cargdoso%type;
    nuNumCuotas   ld_policy.share_policy%type;
    nuCuenta      cuencobr.cucocodi%type;
    nuSaldoCuenta cuencobr.cucosacu%type;
    nuCuotasPend  ld_policy.fees_to_return%type;
    nuCausalCargo cargos.cargcaca%type := DALD_PARAMETER.fnuGetNumeric_Value('FNB_CAUSAL_CARGO');

    --21-01-2015 Llozada [NC 4038]: Cuentas de cobro asociadas al diferido que NO han sido pagadas
    Cursor cuCuentasCobro(sbDife       cargos.cargdoso%type,
                          nuValorCuota ld_policy.prem_policy%type) IS
      select sum(cuotas_pagadas)
        from (select cucocodi,
                     cucovato,
                     CEIL(cucovato / nuValorCuota) cuotas_pagadas
                from cargos, cuencobr
               where cargdoso = sbDife
                 and cargcuco = cucocodi
                 and cargcaca = nuCausalCargo
                 and (cucosacu = 0 OR cucosacu is null)
                 and cucovato > 0
                 and CEIL(cucovato / nuValorCuota) > 0);

    --21-01-2015 Llozada [NC 4038]: Se trae el diferido de la poliza
    CURSOR cuPoliza IS
      Select deferred_policy_id, prem_policy, share_policy
        from ld_policy
       where policy_id = inuPolicy;

    /*21-01-2015 Llozada [NC 4038]: Se comenta porque se debe calcular el valor de las
    cuotas pagadas*/
    /*CURSOR cuGetFess is
    SELECT d.difecupa
    from diferido d, ld_policy l
    where l.deferred_policy_id=d.difecodi
    and l.policy_id= inuPolicy;*/

  BEGIN

    ut_trace.trace('Inicio ld_bcsecuremanagement.FnuGetFessPaid', 10);

    open cuPoliza;
    fetch cuPoliza
      into nuDiferido, nuValorCuota, nuNumCuotas;
    close cuPoliza;

    if nuDiferido is not null then
      sbCargdoso := 'DF-' || nuDiferido;

      open cuCuentasCobro(sbCargdoso, nuValorCuota);
      fetch cuCuentasCobro
        into nuCuotasPend;
      close cuCuentasCobro;

    if nuCuotasPend is not null then
        return nuCuotasPend;
      end if;
    end if;

    /*21-01-2015 Llozada [NC 4038]: Se comenta porque se debe calcular el valor de las
    cuotas pagadas*/
    /*open  cuGetFess;
    fetch cuGetFess INTO nuFeesPaid;
    close cuGetFess; */

    return 0;

    ut_trace.trace('Inicio ld_bcsecuremanagement.FnuGetFessPaid', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuGetFessPaid;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetAllFeesPaid
  Descripcion    : Obtiene el numero de cuotas pagadas del diferido
                   asociado a una poliza de seguros y del diferido o diferidos
                   historicos de la misma poliza cuando ha habido traslado de productos
  Autor          : FCastro
  Fecha          : 13/07/2017

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  13/07/2013  FCastro.200-1058    1 - Creacion
  ******************************************************************/


  FUNCTION FnuGetAllFeesPaid (inuPolicy in ld_policy.policy_id%type)
    return number is

    nuFeesPaid    number;
    nuDiferido    ld_policy.deferred_policy_id%type;
    nuValorCuota  ld_policy.prem_policy%type;
    sbCargdoso    cargos.cargdoso%type;
    nuNumCuotas   ld_policy.share_policy%type;
    nuCuenta      cuencobr.cucocodi%type;
    nuSaldoCuenta cuencobr.cucosacu%type;
    nuCuotasPend  ld_policy.fees_to_return%type;
    nuCausalCargo cargos.cargcaca%type := DALD_PARAMETER.fnuGetNumeric_Value('FNB_CAUSAL_CARGO');

    --21-01-2015 Llozada [NC 4038]: Cuentas de cobro asociadas al diferido que NO han sido pagadas
    Cursor cuCuentasCobro(sbDife       cargos.cargdoso%type,
                          nuValorCuota ld_policy.prem_policy%type) IS
      select sum(cuotas_pagadas)
        from (select cucocodi,
                     cucovato,
                     CEIL(cucovato / nuValorCuota) cuotas_pagadas
                from cargos, cuencobr
               where cargdoso = sbDife
                 and cargcuco = cucocodi
                 and cargcaca = nuCausalCargo
                 and (cucosacu = 0 OR cucosacu is null)
                 and cucovato > 0
                 and CEIL(cucovato / nuValorCuota) > 0);

    --21-01-2015 Llozada [NC 4038]: Se trae el diferido de la poliza
    CURSOR cuPoliza IS
      Select deferred_policy_id, prem_policy, share_policy
        from ld_policy
       where policy_id = inuPolicy;

    CURSOR cuPolizaTrasl is
      select p.deferred_policy_id, nvl(p.paid_fees,0) paid_fees
        from LDC_POLICY_TRASL p
       where p.policy_id = inuPolicy;

    /*21-01-2015 Llozada [NC 4038]: Se comenta porque se debe calcular el valor de las
    cuotas pagadas*/
    /*CURSOR cuGetFess is
    SELECT d.difecupa
    from diferido d, ld_policy l
    where l.deferred_policy_id=d.difecodi
    and l.policy_id= inuPolicy;*/

  BEGIN

    ut_trace.trace('Inicio ld_bcsecuremanagement.FnuGetFessPaid', 10);

    open cuPoliza;
    fetch cuPoliza
      into nuDiferido, nuValorCuota, nuNumCuotas;
    close cuPoliza;

    if nuDiferido is not null then
      sbCargdoso := 'DF-' || nuDiferido;

      open cuCuentasCobro(sbCargdoso, nuValorCuota);
      fetch cuCuentasCobro
        into nuCuotasPend;
      close cuCuentasCobro;

      -- valida si la poliza existe en la tabla de polizas trasladadas y halla
      -- el numero de cuotas pagadas
      nuFeesPaid := 0;
      for rg in cuPolizaTrasl loop
        if rg.deferred_policy_id != nuDiferido then
          nuFeesPaid := nuFeesPaid + nvl(rg.paid_fees,0);
        end if;
      end loop;

      /*open cuPolizaTrasl;
      fetch cuPolizaTrasl into nuFeesPaid;
      if cuPolizaTrasl%notfound then
        nuFeesPaid := 0;
      end if;
      close cuPolizaTrasl;*/

      nuCuotasPend := nvl(nuCuotasPend,0) + nvl(nuFeesPaid,0);

      if nuCuotasPend is not null then
        return nuCuotasPend;
      end if;
    end if;

    /*21-01-2015 Llozada [NC 4038]: Se comenta porque se debe calcular el valor de las
    cuotas pagadas*/
    /*open  cuGetFess;
    fetch cuGetFess INTO nuFeesPaid;
    close cuGetFess; */

    return 0;

    ut_trace.trace('Inicio ld_bcsecuremanagement.FnuGetFessPaid', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuGetAllFeesPaid;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FNUCUOTASPAGADASBS
  Descripcion    : Obtiene el numero de cuotas pagadas del diferido
                   asociado a una poliza de seguros.
  Autor          : Karem Baquero Martinez
  Fecha          : 24/10/2016

  Parametros         Descripcion
  ============   ===================
  inuPolicyId    Identificacion de la poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================   ======================================
  24/10/2016  Kbaquero               1 - Creacion
  ******************************************************************/

  FUNCTION FNUCUOTASPAGADASBS(inuPolicy in ld_policy.policy_id%type)
    return number is

    nuFeesPaid    number;
    nuDiferido    ld_policy.deferred_policy_id%type;
    nuValorCuota  ld_policy.prem_policy%type;
    sbCargdoso    cargos.cargdoso%type;
    nuNumCuotas   ld_policy.share_policy%type;
    nuCuenta      cuencobr.cucocodi%type;
    nuSaldoCuenta cuencobr.cucosacu%type;
    nuCuotasPend  ld_policy.fees_to_return%type;
    nuCausalCargo cargos.cargcaca%type := DALD_PARAMETER.fnuGetNumeric_Value('FNB_CAUSAL_CARGO');

    --21-01-2015 Llozada [NC 4038]: Cuentas de cobro asociadas al diferido que NO han sido pagadas
    /*--24/10/2016 Kbaquero [caso 200491]: se cambia el count por el sum deboido a que en el momento en que
     sea mas de una cuota pagada en el misma cuenta de cobro no la cuenta*/
    Cursor cuCuentasCobro(sbDife       cargos.cargdoso%type,
                          nuValorCuota ld_policy.prem_policy%type) IS
      select COUNT(cuotas_pagadas)
        from (select cucocodi,
                     cucovato,
                     CEIL(cucovato / nuValorCuota) cuotas_pagadas
                from cargos, cuencobr
               where cargdoso = sbDife
                 and cargcuco = cucocodi
                 and cargcaca = nuCausalCargo
                 and (cucosacu = 0 OR cucosacu is null)
                 and cucovato > 0
                 and CEIL(cucovato / nuValorCuota) > 0);

    --21-01-2015 Llozada [NC 4038]: Se trae el diferido de la poliza
    CURSOR cuPoliza IS
      Select deferred_policy_id, prem_policy, share_policy
        from ld_policy
       where policy_id = inuPolicy;


  BEGIN

    ut_trace.trace('Inicio ld_bcsecuremanagement.FNUCUOTASPAGADASBS', 10);

    open cuPoliza;
    fetch cuPoliza
      into nuDiferido, nuValorCuota, nuNumCuotas;
    close cuPoliza;

    if nuDiferido is not null then
      sbCargdoso := 'DF-' || nuDiferido;

      open cuCuentasCobro(sbCargdoso, nuValorCuota);
      fetch cuCuentasCobro
        into nuCuotasPend;
      close cuCuentasCobro;

      if nuCuotasPend is not null then
        return nuCuotasPend;
      end if;
    end if;


    return 0;

    ut_trace.trace('Inicio ld_bcsecuremanagement.FNUCUOTASPAGADASBS', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FNUCUOTASPAGADASBS;





  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetValuePolicyType
  Descripcion    : Obtiene el valor de la poliza para la vigencia
                   correspondiente al tipo de poliza
  Autor          : John Wilmer Robayo Sanchez
  Fecha          : 20-12-2013

  Parametros         Descripcion
  ============   ===================
  inutPolicyType:     Tipo de Poliza
  onuValue:           Vigencia para el tipo de poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  20-12-2013  jrobayo.SAO228441    1 - Creacion
  ******************************************************************/

  PROCEDURE GetValuePolicyType(inuPolicyType in ld_policy_type.policy_type_id%type,
                               onuValue      out number) IS
    CURSOR cuPolValue is
      SELECT /*+ index (lvpt IX_LD_VALIDITY_POLICY_TYPE) */
       policy_value
        FROM ld_validity_policy_type lvpt
       WHERE sysdate between initial_date AND final_date
         AND policy_type_id = inuPolicyType;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetValuePolicyType', 10);

    open cuPolValue;
    fetch cuPolValue
      INTO onuValue;
    close cuPolValue;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetValuePolicyType', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetValuePolicyType;

  /**********************************************************************
   Propiedad intelectual de OPEN International Systems
   Nombre              fblHasDefDebt

   Autor       Andres Felipe Esguerra Restrepo

   Fecha               27-06-2014

   Descripcion         Calcula si un producto tiene deuda diferida

   ***Parametros***
   Nombre        Descripcion
   inuProductId    ID del producto

   ***Historia de Modificaciones***
   Fecha Modificacion        Autor

   27-06-2014            aesguerra.4029
   Creacion
  ***********************************************************************/
  FUNCTION fblHasDefDebt(inuProductId in servsusc.sesunuse%type)
    RETURN boolean IS

    blReturn boolean;
    nuDebt   number;

    CURSOR cuDefDebt(inuProdId servsusc.sesunuse%type) IS
      SELECT sum(difesape) FROM diferido where difenuse = inuProdId;

  BEGIN

    ut_trace.trace('Inicio LD_BCSecureManagement.fblHasDefDebt', 1);

    if cuDefDebt%isopen then
      close cuDefDebt;
    end if;

    open cuDefDebt(inuProductId);
    fetch cuDefDebt
      into nuDebt;
    close cuDefDebt;

    nuDebt := nvl(nuDebt, 0);

    if nuDebt > 0 then
      blReturn := true;
    else
      blReturn := false;
    end if;

    ut_trace.trace('Fin LD_BCSecureManagement.fblHasDefDebt', 1);

    RETURN blReturn;

  END fblHasDefDebt;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fblPolicyTypeHasCateg
  Descripcion    : Valida si el tipo de poliza tiene configurado categoria y subcategoria.

  Autor          : Katherine Cienfuegos
  Fecha          : 04/08/2014

  Parametros       Descripcion
  ============     ===================

  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  04/08/2014       KCienfuegos.RNP550    Creacion
  ******************************************************************/
  FUNCTION fblPolicyTypeHasCateg(inutPolicyType in ld_policy_type.policy_type_id%type)
    RETURN boolean IS

    blResult boolean;
    nuCount  number;

    CURSOR cuPolicyType(inuPoliType servsusc.sesunuse%type) IS
      select count(1)
        from ld_policy_type p
       where p.policy_type_id = inuPoliType
         and category_id is not null
         and subcategory_id is not null;

  BEGIN

    ut_trace.trace('Inicio LD_BCSecureManagement.fblPolicyTypeHasCateg', 1);

    if cuPolicyType%isopen then
      close cuPolicyType;
    end if;

    open cuPolicyType(inutPolicyType);
    fetch cuPolicyType
      into nuCount;
    close cuPolicyType;

    if nvl(nuCount, 0) > 0 then
      blResult := true;
    else
      blResult := false;
    end if;

    ut_trace.trace('Fin LD_BCSecureManagement.fblPolicyTypeHasCateg', 1);

    RETURN blResult;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicyType%isopen) then
        close cuPolicyType;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicyType%isopen) then
        close cuPolicyType;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblPolicyTypeHasCateg;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fblSamePolicyType
   Descripcion    : Valida si a partir de la categoria y subcategoria del cliente
                    se puede aplicar el mismo tipo de poliza.
   Autor          : KCienfuegos
   Fecha          : 04/08/2014

   Parametros         Descripcion
   ============   ===================
   inuPolycType:     Tipo de Poliza
   inuCategory:      Categoria del usuario
   inuSubcategory:   Subcategoria del usuario

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   04/08/2014  KCienfuegos.RNP550  Creacion
  ******************************************************************/
  FUNCTION fblSamePolicyType(inuPolycType   in ld_policy_type.policy_type_id%type,
                             inuCategory    in ld_policy_type.category_id%type,
                             inuSubcategory in ld_policy_type.subcategory_id%type)
    RETURN boolean IS
    nuCount  number;
    blResult boolean;

    CURSOR cuGetPolicy IS
      select count(1)
        from ld_policy_type pt
       where pt.policy_type_id = inuPolycType
         and decode(pt.category_id, -1, inuCategory, pt.category_id) =
             inuCategory
         and decode(pt.subcategory_id,
                    -1,
                    inuSubcategory,
                    pt.subcategory_id) = inuSubcategory;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.fblSamePolicyType', 10);

    open cuGetPolicy;
    fetch cuGetPolicy
      into nuCount;
    close cuGetPolicy;

    if nuCount > 0 then
      blResult := TRUE;
    else
      blResult := FALSE;
    end if;

    return blResult;

    ut_trace.Trace('FIN Ld_BcSecureManagement.fblSamePolicyType', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetPolicy%isopen) then
        close cuGetPolicy;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetPolicy%isopen) then
        close cuGetPolicy;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblSamePolicyType;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : GetNewPolicyType
  Descripcion    : Obtiene un nuevo tipo de poliza de acuerdo a la categoria y
                   subcategoria del predio asociado al contrato del due?o de la poliza
  Autor          : kcienfuegos
  Fecha          : 04/08/2014

  Parametros         Descripcion
  ============   ===================
  inuProductLine:     Linea de producto
  inuContratista:     Contratista
  inuCategory:        Categoria del usuario
  inuSubcategory:     Subcategoria del usuario
  onuNewPoliTyp:      Nuevo tipo de poliza

  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  04/08/2014  KCienfuegos.RNP550  Creacion
  ******************************************************************/
  PROCEDURE GetNewPolicyType(inuProductLine in ld_policy_type.product_line_id%type,
                             inuContratista in ld_policy_type.contratista_id%type,
                             inuCategory    in ld_policy_type.category_id%type,
                             inuSubcategory in ld_policy_type.subcategory_id%type,
                             onuNewPoliTyp  out ld_policy_type.policy_type_id%type) IS
    cursor cuGetNewPolicyType IS
      select policy_type_id
        from ld_policy_type pt
       where decode(pt.category_id, -1, inuCategory, pt.category_id) =
             inuCategory
         and decode(pt.subcategory_id,
                    -1,
                    inuSubcategory,
                    pt.subcategory_id) = inuSubcategory
         and pt.product_line_id = inuProductline
         and pt.contratista_id = inuContratista
         and pt.category_id is not null
         and pt.subcategory_id is not null
       order by pt.category_id desc;

  BEGIN
    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetNewPolicyType', 10);

    open cuGetNewPolicyType;
    fetch cuGetNewPolicyType
      into onuNewPoliTyp;
    close cuGetNewPolicyType;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetNewPolicyType', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuGetNewPolicyType%isopen) then
        close cuGetNewPolicyType;
      end if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuGetNewPolicyType%isopen) then
        close cuGetNewPolicyType;
      end if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetNewPolicyType;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : GetSuscripPolicy
  Descripcion    : Retorna el contrato sobre el cual la cedula tiene una poliza activa.
  Autor          : Katherine Cienfuegos
  Fecha          : 28/08/2014

  Parametros         Descripcion
  ============   ===================
  inuIdentase:     Numero de identificacion
  inuSuscripc:     Numero de suscripcion
  isbState:        Parametro del estado de poliza permitido
  onuSuscripc:     Contrato de retorno

  Historia de Modificaciones
  Fecha            Autor           Modificacion
  =========      =========         ====================
  28/08/2014  KCienfuegos.NC1177   Creacion
  ******************************************************************/

  PROCEDURE GetSuscripPolicy(inuIdentase in ld_policy.identification_id%type,
                             inuSuscripc in suscripc.susccodi%type,
                             isbState    in ld_parameter.value_chain%type,
                             onuSuscripc out suscripc.susccodi%type)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetSuscripPolicy', 10);

    SELECT /*+ index (p PK_LD_POLICY) index (p IDX_LD_POLICY_06)*/
     p.Suscription_Id
      INTO onuSuscripc
      FROM ld_policy p
     WHERE p.Identification_Id = inuIdentase
       AND p.Suscription_Id <> inuSuscripc
       AND regexp_instr(lpad(p.state_policy, 4, '0'), isbState) > 0
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetSuscripPolicy', 10);

  EXCEPTION
    When no_data_found then
      onuSuscripc := -1;
      raise ex.CONTROLLED_ERROR;
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSuscripPolicy;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPoliciesForTypeByCard
   Descripcion    : Obtiene la cantidad de polizas activas de determinado tipo
                    asociadas a una cedula
   Autor          : llarrarte
   Fecha          : 16-09-2014

   Parametros         Descripcion
   ============   ===================
   inuPolicyType: Tipo de Poliza
   inuCardNumber: Numero de cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   16-09-2014  llarrarte.RQ1178    Creacion
  ******************************************************************/

  FUNCTION fnuGetPoliciesForTypeByCard(inuPolicyType in ld_policy_type.policy_type_id%type,
                                       inuCardNumber in ld_policy.identification_id%type)
    return number IS
    CURSOR cuPolicies(inuCardNumber in ld_policy.identification_id%type,
                      inuPolicyType in ld_policy_type.policy_type_id%type) IS
      SELECT count('x')
        FROM ld_policy
       WHERE policy_type_id = inuPolicyType
         AND state_policy = 1
         AND identification_id = inuCardNumber;

    nuTotal number;

  BEGIN

    if (cuPolicies%isopen) then
      close cuPolicies;
    END if;

    open cuPolicies(inuCardNumber, inuPolicyType);
    fetch cuPolicies
      INTO nuTotal;
    return nuTotal;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicies%isopen) then
        close cuPolicies;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicies%isopen) then
        close cuPolicies;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPoliciesForTypeByCard;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPoliciesByCard
   Descripcion    : Obtiene la cantidad de polizas activas
                    asociadas a una cedula
   Autor          : llarrarte
   Fecha          : 16-09-2014

   Parametros         Descripcion
   ============   ===================
   inuCardNumber: Numero de cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   16-09-2014  llarrarte.RQ1178    Creacion
  ******************************************************************/
  FUNCTION fnuGetPoliciesByCard(inuCardNumber in ld_policy.identification_id%type)
    return number IS
    CURSOR cuPolicies(inuCardNumber in ld_policy.identification_id%type) IS
      SELECT /*+ index (ld_policy IDX_LD_POLICY_06)*/
       count('x')
        FROM ld_policy
       WHERE identification_id = inuCardNumber
         AND state_policy = 1;

    nuTotal number;

  BEGIN
    if (cuPolicies%isopen) then
      close cuPolicies;
    END if;

    open cuPolicies(inuCardNumber);
    fetch cuPolicies
      INTO nuTotal;
    return nuTotal;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicies%isopen) then
        close cuPolicies;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicies%isopen) then
        close cuPolicies;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPoliciesByCard;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPolciesByProductLine
   Descripcion    : Obtiene la cantidad de polizas activas correspondientes a una
                    linea de producto asociadas a una cedula
   Autor          : llarrarte
   Fecha          : 16-09-2014

   Parametros         Descripcion
   ============   ===================
   inuProductLine linea del producto
   isbCardnumber  numero de la cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   16-09-2014  llarrarte.RQ1178    Creacion
  ******************************************************************/
  FUNCTION fnuGetPolciesByProductLine(inuProductLine in ld_product_line.product_line_id%type,
                                      isbCardnumber  in ld_policy.identification_id%type)
    return number IS
    CURSOR cuPolicies(inuProductLine in ld_product_line.product_line_id%type,
                      isbCardnumber  in ld_policy.identification_id%type) IS
      SELECT count('x')
        FROM ld_policy, ld_policy_type
       WHERE ld_policy.policy_type_id = ld_policy_type.policy_type_id
         AND ld_policy_type.product_line_id = inuProductLine
         AND ld_policy.identification_id = isbCardnumber
         AND ld_policy.state_policy = 1;

    nuTotal number;
  BEGIN

    if (cuPolicies%isopen) then
      close cuPolicies;
    END if;

    open cuPolicies(inuProductLine, isbCardnumber);
    fetch cuPolicies
      INTO nuTotal;
    return nuTotal;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicies%isopen) then
        close cuPolicies;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicies%isopen) then
        close cuPolicies;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPolciesByProductLine;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetCurrentPeriodBySuscripc
   Descripcion    : Obtiene el periodo de facturacion actual asociado a la
                    suscripcion
   Autor          : llarrarte
   Fecha          : 26-09-2014

   Parametros         Descripcion
   ============   ===================
   inuSuscripc    Numero del contrato

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   26-09-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION fnuGetCurrentPeriodBySuscripc(inuSuscripc in suscripc.susccodi%type)
    return perifact.pefacodi%type IS
    rfPeriod constants.tyrefcursor;
    nuPeriod perifact.pefacodi%type;
  BEGIN

    open rfPeriod for
      SELECT pefacodi
        FROM perifact, suscripc
       WHERE susccicl = pefacicl
         AND pefaactu = ld_boconstans.csbokFlag
         AND susccodi = inuSuscripc;

    fetch rfPeriod
      INTO nuPeriod;

    return nuPeriod;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetCurrentPeriodBySuscripc;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : frfgetDeferredByFinan
   Descripcion    : Obtiene los diferidos asociados a una financiacion
   Autor          : llarrarte
   Fecha          : 26-09-2014

   Parametros         Descripcion
   ============   ===================
   inuFinanId     Numero de la financiacion

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   26-09-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION frfgetDeferredByFinan(inuFinanId in cc_financing_request.financing_id%type)
    return constants.tyrefcursor IS
    rfCursor constants.tyrefCursor;
  BEGIN
    open rfCursor for
      SELECT difecodi FROM diferido WHERE difecofi = inuFinanId;

    return rfCursor;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfgetDeferredByFinan;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetRenewPolicyByProduct
   Descripcion    : Obtiene la ultima poliza asociada al producto que se renovo
   Autor          : llarrarte
   Fecha          : 26-09-2014

   Parametros         Descripcion
   ============   ===================
   inuProductId   Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   26-09-2014  llarrarte.RQ1719           Creacion
  ******************************************************************/
  FUNCTION fnuGetRenewPolicyByProduct(inuProductId in servsusc.sesunuse%type)
    return number IS
    CURSOR cuPolicy(inuProductId in servsusc.sesunuse%type) IS
      SELECT policy_number
        FROM (SELECT *
                FROM ld_policy
               WHERE product_id = inuProductId
                 AND state_policy =
                     DALD_PARAMETER.fsbGetValue_Chain(LD_BOConstans.cnuCodStateRenew)
               ORDER BY dtcreate_policy desc)
       where rownum = 1;

    nuPolicyNumber ld_policy.policy_number%type;

  BEGIN

    if (cuPolicy%isopen) then
      close cuPolicy;
    END if;

    open cupolicy(inuProductId);
    fetch cupolicy
      INTO nuPolicyNumber;

    return nuPolicyNumber;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicy%isopen) then
        close cuPolicy;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicy%isopen) then
        close cuPolicy;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetRenewPolicyByProduct;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetCollectiveNumber
   Descripcion    : Obtiene el colectivo de la poliza activa asociada a un policynumber
   Autor          : llarrarte
   Fecha          : 03-12-2014

   Parametros          Descripcion
   ============        ===================
   nuPolicynumber      Numero de la poliza

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   03-12-2014  llarrarte.RQ1719           Creacion
  ******************************************************************/
  FUNCTION fnuGetCollectiveNumber(nuPolicynumber in ld_policy.policy_number%type)
    return number IS
    CURSOR cuPolicy(nuPolicynumber in ld_policy.policy_number%type) IS
      SELECT collective_number
        FROM (SELECT *
                FROM ld_policy
               WHERE policy_number = nuPolicynumber
                 AND state_policy =
                     DALD_PARAMETER.fsbGetValue_Chain(LD_BOConstans.cnuCodStateRenew)
               ORDER BY dtcreate_policy desc)
       where rownum = 1;

    nuCollectiveNumber ld_policy.collective_number%type;

  BEGIN

    if (cuPolicy%isopen) then
      close cuPolicy;
    END if;

    open cupolicy(nuPolicynumber);
    fetch cupolicy
      INTO nuCollectiveNumber;

    return nuPolicyNumber;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPolicy%isopen) then
        close cuPolicy;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPolicy%isopen) then
        close cuPolicy;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetCollectiveNumber;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : frfGetPoliciesByAge
   Descripcion    : Obtiene CURSOR referenciado con las polizas a cancelar por edad:
                    Corresponden a las polizas cuyos asegurados esten a un mes
                    de cumplir tantos a?os como los indicados en el parametro
                    de entrada inuAge
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros         Descripcion
   ============   ===================
   inuAge         Edad maxima de cobertura para polizas de vida

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   08-10-2014  llarrarte.RQ2172    Creacion
  ******************************************************************/
  FUNCTION frfGetPoliciesByAge(inuAge in number) return constants.tyrefcursor IS
    rfPolicies constants.tyrefcursor;
  BEGIN
    open rfPolicies for
      SELECT /*+ index (ld_policy IDX_LD_POLICY_09)*/
       LD_POLICY.*, LD_POLICY.rowid
        FROM ld_policy
       WHERE policy_exq = 'N'
         AND MONTHS_BETWEEN(TO_DATE(to_char(trunc(sysdate), 'MM-DD-YYYY'),
                                    'MM-DD-YYYY'),
                            TO_DATE(to_char(trunc(dt_insured_policy),
                                            'MM-DD-YYYY'),
                                    'MM-DD-YYYY')) >= (inuAge * 12) - 1
         AND state_policy = 1;
    return rfPolicies;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfGetPoliciesByAge;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetExqPolciesBySuscripc
   Descripcion    : Obtiene la cantidad de polizas exequiales asociadas a una
                    cedula
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros         Descripcion
   ============   ===================
   isbCardNumber  Numero de cedula

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   08-10-2014  llarrarte.RQ2172    Creacion
  ******************************************************************/
  FUNCTION fnuGetExqPolciesBySuscripc(isbCardNumber in ge_subscriber.identification%type)
    return number IS
    nuTotal number;

    CURSOR cuPolicies IS
      SELECT /*+index (ld_policy IDX_LD_POLICY_06)*/
       count('x')
        FROM ld_policy
       WHERE identification_id = isbCardNumber
         AND policy_exq = 'S'
         AND state_policy = 1;
  BEGIN
    open cuPolicies;
    fetch cuPolicies
      INTO nuTotal;
    close cuPolicies;
    return nuTotal;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetExqPolciesBySuscripc;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : getPolByCollecAndProdLine
   Descripcion    : Obtiene las polizas a renovar a partir del mes correpondiente
                    al colectivo (3y 4 digitos)
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros          Descripcion
   ============        ===================
   inuMonth            Mes que se va a renovar
   inuProductLine      Identificador de la linea de producto
   orfPolicies         CURSOR con las polizas que cumplen las condiciones

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   20-10-2014  llarrarte.RQ1719    Se modifica para que obtenga toda la poblacion cuando no se ingresa linea de producto
   08-10-2014  llarrarte.RQ2172    Creacion
  ******************************************************************/
  PROCEDURE getPolByCollecAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor) IS
  BEGIN
    open orfPolicies for
      SELECT /*+ use_nl (ld_policy diferido)
                                                                          index (ld_policy IDX_LD_POLICY_02)
                                                                          index (ld_diferido IX_DIFE_NUSE)*/
       policy_id,
       state_policy,
       launch_policy,
       contratist_code,
       product_line_id,
       dt_in_policy,
       dt_en_policy,
       value_policy,
       prem_policy,
       name_insured,
       suscription_id,
       product_id,
       identification_id,
       period_policy,
       year_policy,
       month_policy,
       deferred_policy_id,
       dtcreate_policy,
       share_policy,
       dtret_policy,
       valueacr_policy,
       report_policy,
       dt_report_policy,
       dt_insured_policy,
       per_report_policy,
       policy_type_id,
       id_report_policy,
       cancel_causal_id,
       fees_to_return,
       comments,
       policy_exq,
       number_acta,
       geograp_location_id,
       validity_policy_type_id,
       policy_number
        FROM ld_policy
       where substr(collective_number, 3, 4) = inuMonth
         AND product_line_id = nvl(inuProductLine, product_line_id)
         AND state_policy = 1
         AND policy_id not in
             (SELECT /*+ index(ld_secure_cancella PK_LD_SECURE_CANCELLA)
                                                                                                                                                                       index(mo_packages PK_MO_PACKAGES)
                                                                                                                                                                       use_nl(ld_secure_cancella mo_packages) */
               policy_id
                FROM ld_secure_cancella, mo_packages
               WHERE ld_secure_cancella.secure_cancella_id =
                     mo_packages.package_id
                 AND mo_packages.motive_status_id = 13);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getPolByCollecAndProdLine;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetCurrentBillByProduct
   Descripcion    : Obtiene el identificador de la factura actual asociada al
                    producto
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros          Descripcion
   ============        ===================
   inuProductId        Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   08-10-2014  llarrarte.RQ2172    Creacion
  ******************************************************************/
  FUNCTION fnuGetCurrentBillByProduct(inuProductId in servsusc.sesunuse%type)
    return factura.factcodi%type IS
    CURSOR cuFact(inuProductId in servsusc.sesunuse%type) IS
      SELECT /*+ use_nl (factura cuencobr)
                                                               use_nl (factura perifact)
                                                               index (factura PK_FACTURA)
                                                               index (cuencbr IX_CUENCOBR03)
                                                               index (perifact IX_PEFA_ACTU) */
       factcodi
        FROM factura, cuencobr, perifact
       WHERE factcodi = cucofact
         AND pefacodi = factpefa
         AND cuconuse = inuProductId
         AND pefaactu = 'S'
         and not exists (select *
                from cargos
               where cargcuco = cucocodi
                 and cargdoso like 'PP%');

    nuFact factura.factcodi%type;
  BEGIN

    open cuFact(inuProductId);
    fetch cuFact
      into nuFact;
    close cuFact;

    if nuFact is not null then
      return nuFact;
    end if;

    return null;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuFact%isopen) then
        close cuFact;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuFact%isopen) then
        close cuFact;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetCurrentBillByProduct;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPenDeferrQuot
   Descripcion    : Obtiene la cantidad de cuotas pendientes del diferido
                    asociado al producto
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros          Descripcion
   ============        ===================
   inuProductId        Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   08-10-2014  llarrarte.RQ2172    Creacion
   28-10-2020	Miguel Ballesteros	Modificacion en el cursor fnuGetPenDeferrQuot para que 
									los diferidos de planes que estén configurados en la 
									tabla LDC_CONFIG_CONTINGENC no sean tenidos en cuenta 
									CASO 539.
   12/10/2021     horbarth         CA 867 se coloca valdiacion para que no se tenga en cuenta diferidos con saldo    
  ******************************************************************/
  
  FUNCTION fnuGetPenDeferrQuot(inuProductId in servsusc.sesunuse%type)
    return number IS
    
    --INICIO CA 867
    sbaplica867 VARCHAR2(1) := 'N';
    --FIN CA 867   
    
    CURSOR cuPendQuot(inuProductId in servsusc.sesunuse%type) IS
      --SELECT /*+ index (diferido IX_DIFE_NUSE) */
      /* nvl(max(difenucu - difecupa), 0)
        FROM diferido
       WHERE difenuse = inuProductId
         AND difenucu - difecupa < difenucu
         AND difenucu - difecupa <> 0;*/
		 
	SELECT /*+ index (diferido IX_DIFE_NUSE) */
       nvl(max(difenucu - difecupa), 0)
        FROM diferido
       WHERE difenuse = inuProductId
         AND difenucu - difecupa < difenucu
         AND difenucu - difecupa <> 0
		 And Difepldi Not In (Select PLFICOCO From Open.LDC_CONFIG_CONTINGENC  
                              Union
                              Select PLFICONT From Open.LDC_CONFIG_CONTINGENC)  -- CASO 539
   --inicio ca 867
    and ((difesape > 0 and sbaplica867 = 'S')
            OR sbaplica867 = 'N');
    --fin ca 867


    nuPendQuot number;
  BEGIN
    --INICIO CA 867
    IF FBLAPLICAENTREGAXCASO('0000867') THEN
      sbaplica867 := 'S';
    END IF;
    --FIN CA 867
    open cuPendQuot(inuProductId);
    fetch cuPendQuot
      INTO nuPendQuot;
    close cuPendQuot;

    return nuPendQuot;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPendQuot%isopen) then
        close cuPendQuot;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPendQuot%isopen) then
        close cuPendQuot;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPenDeferrQuot;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : GetPoliciesWithNoRenew
   Descripcion    : Obtiene polizas en el estado ingresado que tengan
                    registrada una solicitud de no renovacion
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros          Descripcion
   ============        ===================
   isbState            Estado de las polizas
   orfPolicy           CURSOR con las polizas que cumplen las condiciones

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   08-10-2014  llarrarte.RQ2172    Creacion
  ******************************************************************/
  PROCEDURE GetPoliciesWithNoRenew(isbState  in ld_parameter.value_chain%type,
                                   orfPolicy out constants.tyRefCursor) IS
  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.GetPoliciesWithNoRenew',
                   10);

    OPEN orfPolicy FOR
      SELECT /*+
                                                                              use_nl(ld_policy ld_renewall_securp)
                                                                              use_nl(or_order OR_ORDER_ACTIVITY)
                                                                              use_nl(or_order ge_causal)
                                                                              use_nl(or_order ld_renewall_securp)
                                                                              index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_06)
                                                                          */
       ld_policy.policy_id,
       state_policy,
       launch_policy,
       contratist_code,
       ld_policy.product_line_id,
       dt_in_policy,
       dt_en_policy,
       ld_policy.value_policy,
       prem_policy,
       name_insured,
       suscription_id,
       ld_policy.product_id,
       identification_id,
       period_policy,
       year_policy,
       month_policy,
       deferred_policy_id,
       dtcreate_policy,
       share_policy,
       dtret_policy,
       valueacr_policy,
       report_policy,
       dt_report_policy,
       dt_insured_policy,
       per_report_policy,
       ld_policy.policy_type_id,
       id_report_policy,
       ld_policy.cancel_causal_id,
       fees_to_return,
       comments,
       policy_exq,
       number_acta,
       ld_policy.geograp_location_id,
       validity_policy_type_id
        FROM ld_renewall_securp,
             or_order,
             OR_ORDER_ACTIVITY,
             ge_causal,
             ld_policy
       WHERE ld_renewall_securp.policy_id = ld_policy.policy_id
         AND regexp_instr(lpad(state_policy, 4, '0'), isbState) > 0
         AND OR_ORDER_ACTIVITY.package_id = ld_renewall_securp.package_id
         AND OR_ORDER_ACTIVITY.order_id = or_order.order_id
         AND or_order.order_status_id = 8
         AND or_order.causal_id = ge_causal.causal_id
         AND ge_causal.class_causal_id = 2;

    ut_trace.Trace('FIN Ld_BcSecureManagement.GetPoliciesWithNoRenew', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPoliciesWithNoRenew;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetIdByPolicyNumber
   Descripcion    : Obtiene un identificador asociado al numero de la poliza
   Autor          : llarrarte
   Fecha          : 08-10-2014

   Parametros          Descripcion
   ============        ===================
   inuPolicyNumber     Numero de la poliza


   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   30-10-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION fnuGetIdByPolicyNumber(inuPolicyNumber in ld_policy.policy_number%type)
    return ld_policy.policy_id%type IS

    CURSOR cuPolicyId(inuPolicyNumber in ld_policy.policy_number%type) IS
      SELECT nvl(policy_id, 0)
        FROM ld_policy
       WHERE policy_number = inuPolicyNumber
       ORDER BY dtcreate_policy desc;

    nuPolicyId ld_policy.policy_id%type;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.fnuGetIdByPolicyNumber',
                   10);

    open cuPolicyId(inuPolicyNumber);
    fetch cuPolicyId
      INTO nuPolicyId;

    if (cuPolicyId%notfound) then
      nuPolicyId := 0;
    END if;

    close cuPolicyId;

    ut_trace.Trace('FIN Ld_BcSecureManagement.fnuGetIdByPolicyNumber', 10);

    return nuPolicyId;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetIdByPolicyNumber;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetBilledQuotas
   Descripcion    : Obtiene la cantidad de cuotas facturadas del ultimo
                    diferido asociado al producto
   Autor          : llarrarte
   Fecha          : 04-11-2014

   Parametros          Descripcion
   ============        ===================
   inuProductId        Numero del producto


   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   04-11-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION fnuGetBilledQuotas(inuProductId in servsusc.sesunuse%type)
    return number IS
    nuBilledQuotas number;

    CURSOR cuLastQuota(inuProductId in servsusc.sesunuse%type) IS
      SELECT difecupa
        FROM (SELECT /*+ index (diferido IX_DIFE_NUSE)*/
               difecupa
                FROM diferido
               WHERE difenuse = inuProductId
               ORDER BY difefein desc)
       WHERE rownum = 1;

  BEGIN
    ut_trace.trace('INICIO LD_BCSecureManagement.fnuGetBilledQuotas', 1);

    open cuLastQuota(inuProductId);
    fetch cuLastQuota
      INTO nuBilledQuotas;
    close cuLastQuota;

    ut_trace.trace('FIN LD_BCSecureManagement.fnuGetBilledQuotas', 1);
    return nuBilledQuotas;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuLastQuota%isopen) then
        close cuLastQuota;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuLastQuota%isopen) then
        close cuLastQuota;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetBilledQuotas;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fnuGetPendQuotas
   Descripcion    : Obtiene la cantidad de cuotas pendientes del ultimo
                    diferido asociado al producto
   Autor          : llarrarte
   Fecha          : 11/11/2014

   Parametros          Descripcion
   ============        ===================
   inuProductId        Numero del producto


   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   11-11-2014  llarrarte.RQ1719    Creacion
   02/07/2020   olsoftware Cambio 450       se modifica la consulta para que no tenga en cuenta los planes configurados en la tabla LDC_CONFIG_CONTINGENC
  ******************************************************************/
  FUNCTION fnuGetPendQuotas(inuProductId in servsusc.sesunuse%type)
    return number IS
    nuBilledQuotas number;

    CURSOR cuLastQuota(inuProductId in servsusc.sesunuse%type) IS
      SELECT pendVal
        FROM (SELECT /*+ index (diferido IX_DIFE_NUSE)*/
               difenucu - difecupa pendVal
                FROM diferido
               WHERE difenuse = inuProductId
               and (select count(1) from LDC_CONFIG_CONTINGENC where (PLFICOCO = DIFEPLDI or PLFICONT = DIFEPLDI)) = 0
               ORDER BY difefein desc)
       WHERE rownum = 1;

  BEGIN
    ut_trace.trace('INICIO LD_BCSecureManagement.fnuGetPendQuotas', 1);

    open cuLastQuota(inuProductId);
    fetch cuLastQuota
      INTO nuBilledQuotas;
    close cuLastQuota;

    ut_trace.trace('FIN LD_BCSecureManagement.fnuGetPendQuotas', 1);
    return nuBilledQuotas;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuLastQuota%isopen) then
        close cuLastQuota;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuLastQuota%isopen) then
        close cuLastQuota;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPendQuotas;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fblHasPendSales
   Descripcion    : Valida si un producto tiene asociadas solicitudes de venta
                    de seguros sin atender
   Autor          : llarrarte
   Fecha          : 11/11/2014

   Parametros          Descripcion
   ============        ===================
   inuProductId        Numero del producto


   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   11-11-2014  llarrarte.RQ1719    Creacion
  ******************************************************************/
  FUNCTION fblHasPendSales(inuProductId in servsusc.sesunuse%type)
    return boolean IS
    CURSOR cuPendSales(inuProductId in servsusc.sesunuse%type) IS
      SELECT /*+ use_nl (ld_secure_sale mo_packages)
                                                                  use_nl (mo_packages mo_motive)
                                                                  index (mo_motive idx_mo_motive13)
                                                                  index (mo_packages pk_mo_packages)
                                                                  index (ld_secure_sale pk_ld_secure_sale) */
       count('x')
        FROM ld_secure_sale, mo_packages, mo_motive
       WHERE ld_secure_sale.secure_sale_id = mo_packages.package_id
         AND mo_motive.package_id = mo_packages.package_id
         AND mo_motive.product_id = inuProductId
         AND PACKAGE_type_id in (100236, 100261)
         AND mo_packages.motive_status_id = 13;

    nuTotalSales  number;
    blHasPenSales boolean := false;

  BEGIN

    ut_trace.trace('Inicio LD_BCSecureManagement.fblHasPendSales', 1);

    open cuPendSales(inuProductId);
    fetch cuPendSales
      INTO nuTotalSales;
    close cuPendSales;

    ut_trace.trace('nuTotalSales ' || nuTotalSales, 1);

    if (nuTotalSales > 0) then
      blHasPenSales := TRUE;
    END if;

    ut_trace.trace('Fin LD_BCSecureManagement.fblHasPendSales', 1);
    return blHasPenSales;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (cuPendSales%isopen) then
        close cuPendSales;
      END if;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (cuPendSales%isopen) then
        close cuPendSales;
      END if;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblHasPendSales;

  /*****************************************************************
   Unidad         : fnuGetCueCobrPol
   Descripcion    : Verifica si el producto asociado a una p?liza contiene cargo a la -1
   Autor          : AAcuna
   Fecha          : 11-02-2016

   Parametros          Descripcion
   ============        ===================
   inuProductId        Identificador del producto

   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   11-02-2016  AAcuna.RQ100-8096   Creaci?n
  ******************************************************************/
  FUNCTION fnuGetCueCobrPol(inuProductId in servsusc.sesunuse%type)
    return NUMBER IS

    nuCargo NUMBER(5) DEFAULT 0;

  BEGIN

    SELECT nvl(count(c.cargnuse), 0)
      into nuCargo
      FROM cargos c
     WHERE c.cargnuse = inuProductId
       AND c.cargcuco = -1;

    return nuCargo;

  EXCEPTION
    WHEN OTHERS THEN
      nuCargo := 0;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetCueCobrPol;

END LD_BCSecureManagement;
/