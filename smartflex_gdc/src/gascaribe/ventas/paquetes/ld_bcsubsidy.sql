CREATE OR REPLACE PACKAGE      LD_BCSUBSIDY is
  /**********************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Ld_BcSubsidy
  Descripcion    : Realizar las consultas necesarias para el proceso
                   de subsidios
  Autor          : Jonathan Alberto Consuegra Lara
  Fecha          : 22/09/2012

  Historia de Modificaciones
  Fecha             Autor                 Modificacion
  =========       ====================   ===========================================
  22-03-2024      pacosta                OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                            Frfgetsubsidytocollect
                                            FrfGenlettertopotential
                                            FnuGetSubscriberCate
                                            FnuGetSubscriberSubCate
                                            Frfconsalewithoutsub
                                            Frfcontsubwitoutdoc
                                            Frfconsalewithsub
                                            Frfconcollectsubsidy
                                            frfbillsalessubsidy
                                            FnuGetSubscriberUbi
                                            Procgetsububication
                                            Procgetubication
                                            FsbGetTecStatus
                                            Fnugetnumasigserv
                                            FnuGetPackAsig
                                            proProcesaArchivoPlano
                                            fnutotdeliversub
                                            fnutotdealavailable
                                            fnutotauthorize_value
                                            fnudealubisub
                                            fnudealconcsub
                                            fnutotalvaluedetail
                                            fnuexiststotaldetail
                                            fnutotalvalconc
                                            fnuexistsquantitydetail
                                            Fnutotsubpercentage
                                            Fnuvaluepercentagexdeal
                                            Fnutotquantityrecover
                                            Fnutottorecover
                                            Fnuquantitydealinsunsidy
                                            Fdtminsubstardate
                                            Fdtmaxsubenddate
                                            Procgetdeal
                                            Procgetdealsubsidy
                                            Procgetsubsidy
                                            Procgetubiconc
                                            Procgetconc
                                            Procgetubirecovery
                                            Procgetrecovery
                                            Frfconsultsubtomove
                                            Fnugetpromsubsidy
                                            Fnugetsubasig
                                            Fnugetmotive
                                            Fnugetpackageaddress
                                            Procsubscribephones
                                            Fnuexistsubasig
                                            Fnugetlastdateasigsub
                                            Procgetmaxdaterecovery
                                            Fnugetubiasig
                                            Fnugetsesunuse
                                            Frfdebtconcept
                                            Fnubilluser
                                            Procsubswithdocok
                                            Fnugetidsalewithoutsub
                                            Procgetsubsidies
                                            FnuTotalSubsidyByState
                                            FnuTotalSales
                                            FnuTotalSalesByState
                                            Frfsubrem
                                            Frfconcrem
                                            Fnuuserwithsubsidy
                                            ProcgetubiconcforPI
                                            Fnugetsubtotaldelivery
                                            FNuAmountAsigSubsidy
                                            Fnugetintallationorder
                                            FnuGetContSub
                                            FnuGetSumSub
                                            Fnugetnumaxrec
                                            FnuGetValMaxRec
                                            fsbgetsystlocation
                                            Fsbgetenterprise
                                            Fnugetenterprisephone
                                            Fnugetuserisconnect
                                            FrcGetSuscAsigSubsidy
                                            Fnuuserwithsubsamedeal
                                            Fnugetsalwithsubasig
                                            Fnugetsubsidypackage
                                            FnuGetDeliveryTotal
                                            FnuGetSumSubRem
                                            FnuGetContSubRem
                                            FnuGetValDisByServ
                                            FsbGetProcTypeRemSub
                                            FnuGetContSubRemAn
                                            FnuGetContSubRemDi
                                            FnuGetContSubRemPr
                                            FnuGetSumSubRemAn
                                            FnuGetSumSubRemDi
                                            FnuGetSumSubRemPr
                                            fnutotquantitysubbydeal
                                            fcltempclob
                                            Fcldupbillclob
                                            Fsbgetsucadesc
                                            Fnugetsomesuscripc
                                            Fnugetdifesapebyconc
                                            Fnugetctacobbysub
                                            Fnugetasigsubbysusc
                                            Fnugetactivesesunuse
                                            Fnuexistactivesubasig
                                            Fnugetubiactiveasig
                                            Fnugetsubincollectbydate
                                            Fnugetsubinpaybydate
                                            fnugettotquantitybysub
                                            Fnususcwithsubsidy
                                            Fnucommonconcepts
                                            Fnuaccountwithdebt
                                            FnuDeferredDebt
                                            Fnugetsubconcremvalue
                                            Fnuconcremainsub
                                            Fnuuserstoapplysubremain
                                            Fnupackagesbyuser
                                            Fnudetailconceptsbyubi
                                            Fnusubbyubimeet
                                            Fnurowstoapplyremain
                                            Fnurowsinsimulation
                                            fnuValTotalDeal
                                            fnuGetPackAsso
                                            GetSubSidy
                                            frcAvlbleSubsidyByLoc
                                            fnuMotPromotionByPack
                                            FnuGetCountRem
                                            FnuGetSumRem
                                            fnutotquantidetail
                                            Fnugetsubinpaystates
                                            FnuGetPackageSalesContract
                                            Fnugettaricodi
                                            fsbgetfinancingplan
                                            fsbgetinstalationtype
                                            fnugetsalequotes
                                            fnugetinitialquote
                                            fsbgetcommercialplan
  26-02-2014       mgutierrSAO234187      Se eliminan los hints de la sentencia
                                           de Frfcontsubwitoutdoc
  17-12-2013      jrobayo.SAO227371      1. Se crean los metodos
                                            <<FnuGetSumRem>>
                                            <<FnuGetCountRem>>
                                           2. Se modifican los metodos para omitir la
                                              validacion por sesion
                                            <<FnuGetContSubRemAn>>
                                            <<FnuGetContSubRemDi>>
                                            <<FnuGetContSubRemPr>>
                                            <<FnuGetSumSubRemAn>>
                                            <<FnuGetSumSubRemDi>>
                                            <<FnuGetSumSubRemPr>>
  17-12-2013      jrobayo.SAO227491      Se adiciona el metodo <FnuGetPackAsig>
  13-12-2013      jrobayo.SAO227371      Se modifican los metodos
                                            <FnuGetSumSubRem>
                                            <FnuGetContSubRem>
                                            <Fnugetnumasigserv>
  11-12-2013      sgomez.SAO227083       Se adiciona metodo <fnuMotPromotionByPack>
                                         para obtencion de ID de promocion por motivo,
                                         asociado a una solicitud de venta.
  06-12-2013      sgomez.SAO226500       Se adiciona metodo <frcAvlbleSubsidyByLoc>
                                         para obtencion de subsidio disponible en
                                         una ubicacion geografica, categoria y
                                         subcategoria.
  06-12-2013      hjgomez.SAO226118       Se modifica <<Frfconsalewithoutsub>>
  05-12-2013      hjgomez.SAO226138       Se modifica <<FrfGenlettertopotential>>
  26-11-2013      hjgomez.SAO224918       Se modifica <<Frfconcollectsubsidy>>
  19-11-2013      anietoSAO223767         1 - Nuevo procedimiento <<GetSubSidy>>
  20/11/2013      jrobayo.SAO223999       Se modifica el metodo <Frfconsalewithsub>
  28/10/2013      jrobayo.SAO221447       Se modifica el metodo <Frfconsalewithoutsub>
  29/08/2013      hvera.SAO213586         Se modifica el metodo <Frfconsalewithoutsub>
  29/08/2013      hvera.SAO212349         Se modifica el metodo <frfbillsalessubsidy>
  28/08/2013      hvera.SAO213582         Se modifica la funcion <Frfconsultsubtomove>
  27/08/2013      hvera.SAO214461         Se modifica la funcion <Frfconsalewithsub>
  22/09/2012      jconsuegra.SAO156577    Creacion
  **********************************************************************************/

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada

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
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbVersion
    Descripcion    : Retorna el SAO con que se realizo la ultima entrega
    Autor          : jonathan alberto consuegra lara
    Fecha          : 22/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDeal_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  FUNCTION fsbVersion RETURN varchar2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotdeliversub
    Descripcion    : Obtiene el total entregado de los subsidios
                     asociados a un convenio cuya valor valor
                     autorizado sea mayor a cero
    Autor          : jonathan alberto consuegra lara
    Fecha          : 22/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotdeliversub(inuDEAL_Id in LD_deal.DEAL_Id%type) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotdealavailable
    Descripcion    : Obtiene el valor disponible de un convenio
    Autor          : jonathan alberto consuegra lara
    Fecha          : 22/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotdealavailable(inuDEAL_Id in LD_deal.DEAL_Id%type)
    return number;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotauthorize_value
    Descripcion    : Obtiene el total autorizado de los subsidios
                     asociados a un convenio
    Autor          : jonathan alberto consuegra lara
    Fecha          : 24/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    24/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotauthorize_value(inuDEAL_Id in LD_deal.DEAL_Id%type)
    return number;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnudealubisub
    Descripcion    : Determina si existe poblaciones subsidiadas
                     por un subsidios de un convenio determinado
                     y cuya cantidad autorizada se encuentre
                     parametrizada.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 24/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    24/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnudealubisub(inuDEAL_Id in LD_deal.DEAL_Id%type) return number;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnudealconcsub
    Descripcion    : Determina si existen conceptos subsidiados
                     por subsidios asociados a un convenio
                     determinado y cuya cantidad autorizada se
                     encuentre parametrizada.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 24/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    24/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnudealconcsub(inuDEAL_Id in LD_deal.DEAL_Id%type) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotalvaluedetail
    Descripcion    : Obtiene la sumatoria de los valores autorizados
                     de los detalles de un subsidios.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 26/09/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotalvaluedetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuexiststotaldetail
    Descripcion    : Obtiene la existencia de los valores autorizados
                     de los detalles de un subsidios.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 26/09/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnuexiststotaldetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotalvalconc
    Descripcion    : Obtiene la sumatoria de los valores subsidiados
                     para los conceptos parametrizados para una
                     poblacion.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/10/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    03/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotalvalconc(inuUbi in Ld_Ubication.Ubication_Id%type)
    return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuexistsquantitydetail
    Descripcion    : Obtiene la existencia de las cantidades
                     autorizadas de las poblaciones de un subsidios.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 04/09/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    04/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnuexistsquantitydetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fnutotquantidetail
   Descripcion    : Obtiene la sumatoria de las cantidades
                    autorizadas en el detalle de un subsidio.
   Autor          : jonathan alberto consuegra lara
   Fecha          : 04/09/2012

   Parametros       Descripcion
   ============     ===================
   inuSub           identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   04/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotquantidetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number;
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnu_gettaricodi
   Descripcion    : Obtiene el codigo tarifario de la tarifa de
                    un concepto.
   Autor          : jonathan alberto consuegra lara
   Fecha          : 10/10/2012

   Parametros       Descripcion
   ============     ===================
   inuconc          identificador del concepto
   inuserv          identificador del servicio
   inucate          categoria
   inusubcate       subcategoria - estrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   10/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugettaricodi(inuconc    concepto.conccodi%type,
                          inuserv    servicio.servcodi%type,
                          inucate    categori.catecodi%type,
                          inusubcate subcateg.sucacodi%type) return number;

  /* \*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnu_getconcvalue
   Descripcion    : Obtiene el valor de la tarifa de un concepto
   Autor          : jonathan alberto consuegra lara
   Fecha          : 09/10/2012

   Parametros       Descripcion
   ============     ===================
   inuconc          identificador del concepto
   inuserv          identificador del servicio
   inucate          categoria
   inusubcate       subcategoria - estrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   09/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************\
  Function Fnugetconcvalue (inuconc      concepto.conccodi%type,
                            inuserv      servicio.servcodi%type,
                            inucate      categori.catecodi%type,
                            inusubcate   subcateg.sucacodi%type,
                            inuubication ge_geogra_location.geograp_location_id%type,
                            idtfecha     ta_vigetaco.vitcfein%type) return number;*/

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnutotsubpercentage
   Descripcion    : Obtiene la sumatoria de los valores
                    porcentuales de los conceptos subsidiados
                    por ubicacion geografica asociados a un
                    subsidio.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 11/10/2012

   Parametros       Descripcion
   ============     ===================
   inuconc          identificador del concepto
   inuserv          identificador del servicio
   inucate          categoria
   inusubcate       subcategoria - estrato
   idtfecha         fecha de vigencia de la tarifa
   inupercen        porcentaje a subsidiar para un concepto
   inuubi_id        identificador de la poblacion a subsidiar

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   11/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnutotsubpercentage(inuserv   servicio.servcodi%type,
                               idtfecha  regltari.retafein%type,
                               inuubi_id ld_ubication.ubication_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuvaluepercentagexdeal
   Descripcion    : Obtiene la sumatoria de los valores
                    porcentuales de los conceptos subsidiados
                    asociados a un convenio.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 12/10/2012

   Parametros       Descripcion
   ============     ===================
   inuserv          identificador del servicio
   idtfecha         fecha de vigencia de la tarifa
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   12/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuvaluepercentagexdeal(inuserv       servicio.servcodi%type,
                                   idtfecha      regltari.retafein%type,
                                   inuDeal       ld_subsidy.deal_id%type,
                                   inuRaiseError in number default 1)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnutotquantityrecover
   Descripcion    : Obtiene la sumatoria de los topes a cobrar
                    para una poblacion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/10/2012

   Parametros       Descripcion
   ============     ===================
   inuubi_id        identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnutotquantityrecover(inuubi_id ld_ubication.ubication_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnutottorecover
   Descripcion    : Obtiene la sumatoria de los valores a cobrar
                    para una poblacion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/10/2012

   Parametros       Descripcion
   ============     ===================
   inuubi_id        identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnutottorecover(inuubi_id ld_ubication.ubication_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuquantitydealinsunsidy
   Descripcion    : Obtiene la cantidad de subsidios que se
                    encuentran asociados a un convenio determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuquantitydealinsunsidy(inuDeal ld_subsidy.deal_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fdtminsubstardate
   Descripcion    : Obtiene la minima fecha de inicio de vigencia
                    de los subsidios asociados a un convenio
                    determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fdtminsubstardate(inuDeal ld_subsidy.deal_id%type) return date;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fdtmaxsubenddate
   Descripcion    : Obtiene la maxima fecha de fin de vigencia
                    de los subsidios asociados a un convenio
                    determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fdtmaxsubenddate(inuDeal ld_subsidy.deal_id%type) return date;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetdeal
   Descripcion    : Obtiene los datos de un convenio para
                    visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 23/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetdeal(inuDeal ld_deal.deal_id%type,
                        Orfdeal out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetdealsubsidy
   Descripcion    : Obtiene los subsidios asociados a un convenio
                    para visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 23/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetdealsubsidy(inuDeal    ld_deal.deal_id%type,
                               Orfsubsidy out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetsubsidy
   Descripcion    : Obtiene la informacion de un subsidio determinado
                    para visualizarlo en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetsubsidy(inuSubsidy ld_subsidy.subsidy_id%type,
                           Orfsubsidy out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetsububication
   Descripcion    : Obtiene las poblaciones beneficiadas por un
                    subsidio determinado para visualizarlas en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetsububication(inuSubsidy   ld_ubication.subsidy_id%type,
                                Orfubication out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetubication
   Descripcion    : Obtiene la informacion de una poblacion
                    subsidiada en particular, visualizarla en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetubication(inuUbication ld_ubication.ubication_id%type,
                             Orfubication out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetubiconc
   Descripcion    : Obtiene la informacion de los conceptos
                    subsidiados para una poblacion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetubiconc(inuUbication ld_ubication.ubication_id%type,
                           Orfconcepto  out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetconc
   Descripcion    : Obtiene la informacion de un concepto
                    subsidiado para una poblacion, para
                    visualizarlo en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetconc(inuConcid   ld_subsidy_detail.subsidy_detail_id%type,
                        Orfconcepto out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetubirecovery
   Descripcion    : Obtiene la informacion de los topes de cobro
                    asociados a una poblacion subsidiada, para
                    visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetubirecovery(inuUbi      ld_max_recovery.ubication_id%type,
                               Orfrecovery out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetrecovery
   Descripcion    : Obtiene la informacion de un tope de cobro
                    asociado a una poblacion subsidiada, para
                    visualizarlo en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetrecovery(inurecovery ld_max_recovery.ubication_id%type,
                            Orfrecovery out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconsalewithoutsub
   Descripcion    : consulta las ventas sin subsidios.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================
   inuGeLocation    ubicacion geografica
   inuCategori      categoria
   inuSubcacodi     subcategoria
   idtInitialDate   fecha inicial de solicitud de venta
   idtFinalDate     fecha final de solicitud de venta
   inuAddressId     direccion
   inuPackid        solicitud de venta
   inuSubid         subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfconsalewithoutsub return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconsultsubtomove
   Descripcion    : consulta los subsidios para ser trasladados.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfconsultsubtomove return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubasig
   Descripcion    : obtiene el subsidio de una promocion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inupromo         promocion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetpromsubsidy(inupromo cc_promotion.promotion_id%type,
                             inuRaiseError  in number default 1
                            ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubasig
   Descripcion    : obtener la cantidad repartida de un subsidio.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inusub           identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubasig(inusub ld_subsidy.subsidy_id%type) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetmotive
   Descripcion    : Obtiene el motivo asociado a una solicitud.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/11/2012

   Parametros       Descripcion
   ============     ===================
   inumo_packages   identificador de la solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   19/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetmotive(inumo_packages mo_packages.package_id%type,
                        inuRaiseError  in number default 1)
    return mo_motive.motive_id%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetpackageaddress
   Descripcion    : Obtiene el identificador de la ubicacion
                    geografica asociada a la direccion de una
                    solicitud

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/11/2012

   Parametros       Descripcion
   ============     ===================
   inumo_packages   identificador de la solicitud
   inumo_motive     motivo asociado a una solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   19/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetpackageaddress(inumo_packages mo_packages.package_id%type,
                                inumo_motive   mo_motive.motive_id%type,
                                inuRaiseError  in number default 1)
    return mo_address.address_id%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procsubscribephones
   Descripcion    : Obtiene los telefonos asociados a un suscriptor

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubscriber    identificador del cliente
   Orfphones        cursor referenciado con los telefonos del
                    cliente

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   19/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procsubscribephones(inusubscriber ge_subscriber.subscriber_id%type,
                                Orfphones     out constants_per.tyrefcursor);
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuexistsubasig
   Descripcion    : Consulta si se han realizado ventas a partir
                    de un subsidio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 28/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   28/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuexistsubasig(inusubsidy ld_subsidy.subsidy_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetlastdateasigsub
   Descripcion    : Obtiene la fecha del ultimo subsidio asignado
                    asociado a un codigo en particular

   Autor          : jonathan alberto consuegra lara
   Fecha          : 29/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   29/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetlastdateasigsub(inusubsidy    ld_subsidy.subsidy_id%type,
                                 inuRaiseError in number default 1)
    return ld_asig_subsidy.insert_date%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetmaxdaterecovery
   Descripcion    : Obtiene el maximo periodo parametrizado para un
                    tope de cobro de un subsidio

   Autor          : jonathan alberto consuegra lara
   Fecha          : 29/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   29/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetmaxdaterecovery(inusubsidy ld_subsidy.subsidy_id%type,
                                   onuyear    out ld_max_recovery.year%type,
                                   onumonth   out ld_max_recovery.month%type);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubinpaystates
   Descripcion    : Determina si existen subsidios en estado
                    POR COBRAR, COBRADO o PAGADO.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 30/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   30/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubinpaystates(inusubsidy ld_subsidy.subsidy_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetubiasig
   Descripcion    : Determina si existen subsidios asignados a una
                    ubicacion determinada

   Autor          : jonathan alberto consuegra lara
   Fecha          : 30/11/2012

   Parametros       Descripcion
   ============     ===================
   inuubication     identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   30/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetubiasig(inuubication ld_ubication.ubication_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfcontsubwitoutdoc
   Descripcion    : consulta los subsidios sin docuemntacion entregada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfcontsubwitoutdoc return constants_per.tyrefcursor;


  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsesunuse
   Descripcion    : Obtiene el el servicio suscrito de GAS asocaido
                    a una solicitud de venta

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/12/2012

   Parametros       Descripcion
   ============     ===================
   nususcripc       identificador de la suscripcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsesunuse(inupackages   in mo_packages.package_id%type,--inususcripc   in servsusc.sesususc%type,
                          inuRaiseError in number default 1
                         ) return pr_product.product_id%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfdebtconcept
   Descripcion    : Obtiene un cursor referenciado con la deuda
                    corriente y diferida de un contrato (suscripc)

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/11/2012

   Parametros       Descripcion
   ============     ===================
   inususcripc      identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfdebtconcept(inususcripc in  suscripc.susccodi%type
                         ) return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconsalewithsub
   Descripcion    : consulta las asignaciones de subsidios.

   Autor          : Evens Herard Gorut
   Fecha          : 16/12/2012

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   16/12/2012       eherard.SAO156577     Creacion
  ******************************************************************/
  Function Frfconsalewithsub return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnubilluser
   Descripcion    : Determina si un cliente ha sido facturado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/12/2012

   Parametros       Descripcion
   ============     ===================
   inunuse          identificador del producto(servicio suscrito)
   inuRaiseError    controla error no_data_found


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnubilluser(inunuse       servsusc.sesunuse%type,
                       inuRaiseError in number default 1) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procsubswithdocok
   Descripcion    : Obtiene los subsidios de un suscriptor
                    con documentacion entregada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/12/2012

   Parametros       Descripcion
   ============     ===================
   inususccodi      identificador del contrato
   Orfsubsidies     cursor referenciado con los subsidios con
                    documentacion entregada de un suscriptor.

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procsubswithdocok(inususccodi  suscripc.susccodi%type,
                              Orfsubsidies out constants_per.tyrefcursor);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetidsalewithoutsub
   Descripcion    : Obtiene el id de una venta no subsidiada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/12/2012

   Parametros       Descripcion
   ============     ===================
   inupackageid     identificador de la solicitud de venta

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   21/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetidsalewithoutsub(inupackageid  mo_packages.package_id%type,
                                  inuRaiseError in number default 1)
    return ld_sales_withoutsubsidy.sales_withoutsubsidy_id%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetsubsidies
   Descripcion    : Obtiene los subsidios parametrizados

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/12/2012

   Parametros       Descripcion
   ============     ===================
   inupackageid     identificador de la solicitud de venta

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   21/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetsubsidies(Orfsubsidies out constants_per.tyrefcursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuTotalSubsidyByState
  Descripcion    : Retorna en un cursor referenciado las trasnferencias asociadas al
                   contrato(recibido o cedido).

  Autor          : Evens Herard Gorut.
  Fecha          : 24/10/2012

  Parametros             Descripcion
  ============           ===================
  inuSubsidy             Identificador del subsidio
  inustatecheked         Estado del subsidio asignado


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuTotalSubsidyByState(inuSubsidy     in ld_asig_subsidy.subsidy_id%type,
                                  inustatecheked in ld_asig_subsidy.state_subsidy%type)
    return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuTotalSales
    Descripcion    : Cantidad de solicitudes de subsidio de venta

    Autor          : Evens Herard Gorut.
    Fecha          : 20/12/2012

    Parametros             Descripcion
    ============           ===================
    inuSubsidy             Identificador del subsidio


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuTotalSales(inuSubsidy in ld_asig_subsidy.subsidy_id%type)
    return number;

/**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              fnugetTotalSalesByStateBySubsidy

    Autor                Andres Felipe Esguerra Restrepo

    Fecha               11-dic-2013

    Descripcion         Obtiene la cantidad de ventas con subsidio que se
                        encuentren en determinado estado para un tipo de
                        subsidio

    ***Parametros***
    Nombre                Descripcion
    inuSubsidy          ID del subsidio
    inuPackState        Estado de la venta de gas

    ***Historia de Modificaciones***
    Fecha Modificacion                Autor
    .                                .
***********************************************************************/

    FUNCTION fnugetTotalSalesByStateBySub(inuSubsidy in ld_asig_subsidy.subsidy_id%type,
                                            inuPackState in mo_packages.motive_status_id%type) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuTotalSalesByState
    Descripcion    : Cantidad de solicitudes de subsidio de venta por estados
                     En ejecucion, Ejecutada y Anulada

    Autor          : Evens Herard Gorut.
    Fecha          : 20/12/2012

    Parametros             Descripcion
    ============           ===================
    inuOrderState          Estado de la orden


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuTotalSalesByState(inuOrderState in or_order.order_status_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procsubrem
   Descripcion    : Obtiene los subsidios vencidos con remanente.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 24/12/2012

   Parametros       Descripcion
   ============     ===================
   Orfsubsidies     Subsidios remanentes

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   24/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfsubrem return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procconcrem
   Descripcion    : Obtiene los conceptos a subsidiar por remanente.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 24/12/2012

   Parametros       Descripcion
   ============     ===================
   inusub           Identificador del subsidio
   Orfconcsub       Conceptos a subsidiar

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   24/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfconcrem(inuubi ld_ubication.ubication_id%type
                     ) return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuuserwithsubsidy
   Descripcion    : Determina si un usuario tiene asignado un
                    subsidio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 03/01/2013

   Parametros       Descripcion
   ============     ===================
   inusub           Identificador del subsidio
   Orfconcsub       Conceptos a subsidiar

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   03/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuuserwithsubsidy(inusub     ld_subsidy.subsidy_id%type,
                              inususc    suscripc.susccodi%type,
                              inupackage mo_packages.package_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ProcgetubiconcforPI
   Descripcion    : Obtiene la informacion de los conceptos
                    subsidiados para una poblacion, para
                    visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure ProcgetubiconcforPI(inuUbication ld_ubication.ubication_id%type,
                                Orfconcepto  out constants_per.tyrefcursor);


  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetPackageSalesContract
   Descripcion    : Obtener el PACKAGE_ID asociado al contrato con
                    una venta

   Autor          : Jorge valiente
   Fecha          : 09/01/2013

   Parametros       Descripcion
   ============     ===================
   inususccodi      condigo del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  Function FnuGetPackageSalesContract(inususccodi suscripc.susccodi%type)
    return mo_packages.package_id%type;


  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubtotaldelivery
   Descripcion    : Obtiene el total asignado de un subsidio

   Autor          : jonathan alberto consuegra lara
   Fecha          : 11/01/2013

   Parametros       Descripcion
   ============     ===================
   inususccodi      condigo del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   11/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubtotaldelivery(inusubsidy ld_subsidy.subsidy_id%type
                                 ) return ld_subsidy.total_deliver%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FNuGetAmountAsigSubsidy
   Descripcion    : Obtiene el total clientes subsidiados sin
                    conexion o instalacion del servicio de Gas en
                    una poblacion

   Autor          : Jorge luis Valiente Moreno
   Fecha          : 14/01/2013

   Parametros       Descripcion
   ============     ===================
   inuAsigSubsidyId       Cadena de subsidio
   inuUbicationId         Poblacion del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  Function FNuAmountAsigSubsidy(inuAsigSubsidyId in ld_asig_subsidy.Asig_Subsidy_Id%type,
                                inuUbicationId   in ld_asig_subsidy.ubication_id%type)
    return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetintallationorder
   Descripcion    : Obtiene el numero de la orden de instalacion
                    del producto GAS.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 22/01/2013

   Parametros       Descripcion
   ============     ===================
   inususcodi       identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetintallationorder(inususcodi  suscripc.susccodi%type,
                                  inuRaiseError in number default 1
                                 ) return  or_order.order_id%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : frfconcollectsubsidy
   Descripcion    : Consulta subsidios asignados para hacer cambio
                    de estados.

   Autor          : Evens Herard Gorut
   Fecha          : 09/01/2013

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   09/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function Frfconcollectsubsidy return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetcontsub
   Descripcion    : Obtiene el numero de subsidios que se han pasado
                    a estado COBRADO en el periodo actual
                    para una ubicacion determinada.

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inususcodi       identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetcontsub(inusubsidy    in ld_subsidy.subsidy_id%type,
                         inuubication  in ld_ubication.ubication_id%type,
                         inuraiseError in number default 1
                        ) return  number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSub
   Descripcion    : Obtiene la sumatoria de los subsidios que se
                    han pasado a estado COBRADO en el periodo actual
                    para esa ubicacion.

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio
   inuubication     identificador de la poblacion
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsumsub(inusubsidy    in ld_subsidy.subsidy_id%type,
                        inuubication  in ld_ubication.ubication_id%type,
                        inuraiseError in number default 1
                       ) return ld_subsidy.authorize_value%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetnumaxrec
   Descripcion    : Obtener el numero de tope de subsidios para la
                    ubicacion que se esta procesando en el periodo
                    actual

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuUbication     Identificador de la poblacion
   inuYear          A?o
   inuMonth         Mes
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function Fnugetnumaxrec(inuubication       in ld_ubication.ubication_id%type,
                          inuyear            in ld_max_recovery.year%type,
                          inumonth           in ld_max_recovery.month%type,
                          inuraiseerror      in number default 1
                         ) return ld_max_recovery.total_sub_recovery%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetValMaxRec
   Descripcion    : Funcion que Obtiene el Valor Tope del subsidio
                    para la Ubicacion que se esta procesando, en el
                    periodo actual.

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuUbication     Identificador de la poblacion
   inuYear          A?o
   inuMonth         Mes
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetValMaxRec(inuUbication       in ld_ubication.ubication_id%type,
                           inuYear            in ld_max_recovery.year%type,
                           inuMonth           in ld_max_recovery.month%type,
                           inuRaiseError      in number default 1
                          ) return ld_max_recovery.recovery_value%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fsbgetsystlocation
   Descripcion    : Obtiene la ciudad asociada a un codigo de sistema
                    especifico.

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 30/01/2013

   Parametros       Descripcion
   ============     ===================
   inusyscodi       Identificador del sistema
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   30/01/2013       jconsuegra.SAO156577     Creacion
  ******************************************************************/
  Function fsbgetsystlocation(inusyscodi    in sistema.sistcodi%type,
                              inuRaiseError in number default 1
                             ) return sistema.sistciud%type;

   /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : frfbillsalessubsidy
   Descripcion    : Consulta subsidios entregados para generacion de
                    duplicados de facturas de venta.

   Autor          : Evens Herard Gorut
   Fecha          : 30/01/2013

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   30/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
   Function frfbillsalessubsidy return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fsbgetenterprise
   Descripcion    : Obtiene el nombre de la empresa del sistema.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 01/02/2013

   Parametros       Descripcion
   ============     ===================
   inusyscodi       Identificador del sistema
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   01/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fsbgetenterprise(inusyscodi in sistema.sistcodi%type,
                            inuRaiseError in number default 1
                           ) return varchar2;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetenterprisephone
   Descripcion    : Obtiene los telefonos de la empresa del sistema.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 01/02/2013

   Parametros       Descripcion
   ============     ===================
   inusyscodi       Identificador del sistema
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   01/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetenterprisephone(inusyscodi in sistema.sistcodi%type,
                                 inuRaiseError in number default 1
                                ) return sistema.sisttele%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfgetsubsidytocollect
   Descripcion    : Obtiene los subsidios asociados a un acta de
                    cobro determinada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 07/02/2013

   Parametros       Descripcion
   ============     ===================
   inurecordcollect Identificador del acta de cobro

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   07/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfgetsubsidytocollect(inurecordcollect in sistema.sistcodi%type
                                 ) return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FrfGenlettertopotential
   Descripcion    : Obtiene los usuarios potenciales a
                    notificarle de los subsidios ofertados

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/12/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   21/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FrfGenlettertopotential
  (
   inuGeoLoca   in  ld_ubication.geogra_location_id%type,
   inuCategory  in  ld_ubication.sucacate%type,
   inuSubcateog in  ld_ubication.sucacodi%type
  ) return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetuserisconnect
   Descripcion    : Determina si un usuario posee servicio GAS y
                    el servicio ha sido conectado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/02/2013

   Parametros       Descripcion
   ============     ===================
   inususccodi      Identificador del contrato
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   13/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetuserisconnect(inususccodi   in suscripc.susccodi%type,
                               inuRaiseError in number default 1
                              ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FcrGetSuscAsigSubsidy
   Descripcion    : Obtiene los contratos subsidiados que no tienen
                    conexion o instalacion del servicio de Gas para una
                    poblacion espesifica una poblacion

   Autor          : Evens Herard Gorut
   Fecha          : 07/02/2013

   Parametros             Descripcion
   ============           ===================
   inuAsigSubsidyId       Codigo de subsidio entregado
   inuUbicationId         Ubicacion del subsidio
   inupackagesstatus      Estado de la solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  Function FrcGetSuscAsigSubsidy(inuSubsidyId     in ld_asig_subsidy.Asig_Subsidy_Id%type,
                                 inupackagesstatus in mo_packages.motive_status_id%type
                                ) return  DaLd_Asig_Subsidy.tyRefCursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuuserwithsubsamedeal
   Descripcion    : Determina si un usuario tiene asignado al menos
                    un subsidio asociado a un convenio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/02/2013

   Parametros       Descripcion
   ============     ===================
   inudeal          Identificador del convenio
   inususc          Identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuuserwithsubsamedeal(inudeal    ld_deal.deal_id%type,
                                  inususc    suscripc.susccodi%type
                                 ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsalwithsubasig
   Descripcion    : Determina si una solicitud ha sido subsidiada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/02/2013

   Paramatros       Descripcion
   ============     ===================
   inupackage_id    identificador de la solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   21/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsalwithsubasig(inupackage_id mo_packages.package_id%type
                               ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubsidypackage
   Descripcion    : Obtiene la solicitud de venta de subsidio asociada
                    a un cliente.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 22/02/2013

   Paramatros       Descripcion
   ============     ===================
   inususccodi      identificador del contrato
   inusubsidy       identificador del subsidio
   inuubication     identificador de la poblacion subsidiada
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubsidypackage(inususccodi  in suscripc.susccodi%type,
                                inusubsidy   in ld_subsidy.subsidy_id%type,
                                inuubication in ld_ubication.ubication_id%type,
                                inuRaiseError in number default 1
                               ) return mo_packages.package_id%type;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetdeliverytotal
     Descripcion    : Funcion que retorna el Delivery Total de un subsidio
                      entregado y un contrato espesifico
     Autor          : Evens Herard Gorut
     Fecha          : 13/02/2012

     Parametros        Descripcion
     ============     ===================
     inusubsidy       Identificador del subsidio
     inususccodi      Identificador del Contrato
     inuSession       Identidficador de la session


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     13/02/2012       eherard.SAO156577     Creacion
  /*************************************************************************/
  Function FnuGetDeliveryTotal(inuSubsidyId     in ld_asig_subsidy.Asig_Subsidy_Id%type,
                               inuSusccodi      in ld_asig_subsidy.susccodi%type,
                               inuUbication     in ld_asig_subsidy.ubication_id%type,
                               inuRaiseError    in number default 1
                              ) return  ld_sub_remain_deliv.delivery_total%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRem
   Descripcion    : Funcion que Obtiene el Valor total de los
                    subsidios remanentes distribuidos

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   13/12/2013       jrobayo.SAO227371     1- Se modifica para la consulta de valores sin
                                             tener en cuenta la sesion de Oracle.
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRem(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                           inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                           inuRaiseError      in number default 1
                          ) return ld_sub_remain_deliv.delivery_total%type;

    /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRem
   Descripcion    : Funcion que Obtiene el Valor total de los
                    subsidios remanentes distribuidos

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   13/12/2013       jrobayo.SAO227371     Se modifica para la consulta de valores sin
                                          tener en cuenta la sesion de Oracle.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRem(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                            inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                            inuRaiseError      in number default 1
                           ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetValDisByServ
   Descripcion    : Obtiene el valor distribuido del remannete del subsidio,
                    para cada servicio.


   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   13/12/2013       jrobayo.SAO223371     Se modifica para no tener en cuenta la
                                          sesion de Oracle.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetValDisByServ(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return ld_sub_remain_deliv.delivery_total%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FsbGetProcTypeRemSub
   Descripcion    : Obtiene la descripcion del tipo de proceso que se ejecuto :
                    (SI = SIMULACION o DI = DISTRIBUCION).


   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FsbGetProcTypeRemSub(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                                inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                                inuSession         in ld_sub_remain_deliv.sesion%type,
                                inuRaiseError      in number default 1
                               ) return ld_subsidy.description%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRemAn
   Descripcion    : Obtiene el numero total de los
                    subsidios remanentes distribuidos en estado
                    Anulado

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRemAn(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRemDi
   Descripcion    : Obtiene el numero total de los
                    subsidios remanentes distribuidos en estado
                    Distribuido

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRemDi(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRemPr
   Descripcion    : Obtiener el numero total de los
                    subsidios remanentes distribuidos en estado
                    Procesado

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRemPr(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRemAn
   Descripcion    : Obtiene el valor total de los
                    subsidios remanentes distribuidos por estado
                    Anulado
   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRemAn(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                             inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                             inuRaiseError      in number default 1
                            ) return ld_sub_remain_deliv.delivery_total%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRemDi
   Descripcion    : Obtiene el valor total de los
                    subsidios remanentes distribuidos por estado
                    Distribuido
   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRemDi(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                             inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                             inuRaiseError      in number default 1
                            ) return ld_sub_remain_deliv.delivery_total%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRemPr
   Descripcion    : Obtiene el valor total de los subsidios
                    remanentes distribuidos por estado
                    procesado
   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRemPr(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                             inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                             inuRaiseError      in number default 1
                            ) return ld_sub_remain_deliv.delivery_total%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnutotquantitysubbydeal
    Descripcion    : Obtiene la cantidad de subsidios asociados a un
                     convenio, que fueron parametrizados por
                     cantidad autorizada

    Autor          : jonathan alberto consuegra lara
    Fecha          : 06/03/2013

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    06/03/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotquantitysubbydeal(inuDEAL_Id in LD_deal.DEAL_Id%type
                                  ) return number;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fcltempclob
    Descripcion    : Obtiene un clob de la entidad ld_temp_clob_fact

    Autor          : jonathan alberto consuegra lara
    Fecha          : 12/03/2013

    Parametros       Descripcion
    ============     ===================
    inuid            identificador de registro
    inuRaiseError    controlador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    12/03/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fcltempclob(inuid in ld_temp_clob_fact.temp_clob_fact_id%type,
                       inuRaiseError  in number default 1
                      )return clob;

    /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fcldupbillclob
   Descripcion    : Obtiene los clobs asociados a una
                    sesion de usuario registrados en la
                    entidad ld_temp_clob_fact

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/03/2013

   Parametros       Descripcion
   ============     ===================
   inusesion        sesion de usuario

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/03/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fcldupbillclob(inusesion ld_temp_clob_fact.sesion%type
                         ) return constants_per.tyrefcursor;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FsbGetTecStatus
   Descripcion    : Obtiene el estado tecnico y descripcion
                    para un servicio suscrito especifico

   Autor          : Evens Herard Gorut
   Fecha          : 14/03/2013

   Parametros       Descripcion
   ============     ===================
   inunuse          identificador del numero de servicio suscrito
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   14/03/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  Function FsbGetTecStatus (inuNuse            in servsusc.sesunuse%type,
                            inuRaiseError      in number default 1
                           ) return varchar2;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSubscriberUbi
   Descripcion    : Obtiene la ubicacion geografica de un cliente

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 04/04/2013

   Parametros       Descripcion
   ============     ===================
   inuclient        identificador del cliente
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   04/04/2013       Jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSubscriberUbi (inuclient      in ge_subscriber.subscriber_id%type,
                                inuRaiseError  in number default 1
                               ) return ge_geogra_location.geograp_location_id%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSubscriberCate
   Descripcion    : Obtiene la categoria de un cliente

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 04/04/2013

   Parametros       Descripcion
   ============     ===================
   inuclient        identificador del cliente
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   04/04/2013       Jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSubscriberCate (inuclient      in ge_subscriber.subscriber_id%type,
                                 inuRaiseError  in number default 1
                                ) return categori.catecodi%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSubscriberSubCate
   Descripcion    : Obtiene la subcategoria de un cliente

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 04/04/2013

   Parametros       Descripcion
   ============     ===================
   inuclient        identificador del cliente
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   04/04/2013       Jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSubscriberSubCate (inuclient      in ge_subscriber.subscriber_id%type,
                                    inuRaiseError  in number default 1
                                   ) return categori.catecodi%type;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetlegalizeorderbysubsidy
   Descripcion    : obtener la cantidad de ordenes legalizadas
                    asociadas a un subsidio.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 08/05/2013

   Parametros       Descripcion
   ============     ===================
   inusub           identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   08/05/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetlegalizeorderbysubsidy(inusub ld_subsidy.subsidy_id%type
                                       ) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fsbgetsucadesc
    Descripcion    : Obtiene la descripcion de una subcategoria y
                    en caso de no encontrarla retorna null

    Autor          : jonathan alberto consuegra lara
    Fecha          : 29/05/2013

    Parametros       Descripcion
    ============     ===================
    inucate          identificador de la categoria
    inusuca          identificador de la subcategoria

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    29/05/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fsbgetsucadesc(inucate       in categori.catecodi%type,
                          inusuca       in subcateg.sucacodi%type,
                          inuRaiseError in number default 1
                         ) return subcateg.sucadesc%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : Fnugetsomesuscripc
    Descripcion    : Determina si un cliente tiene amarrado un contrato
  ******************************************************************/
  Function Fnugetsomesuscripc(inuclient     IN suscripc.suscclie%TYPE,
                              inuRaiseError IN NUMBER DEFAULT 1
                             ) RETURN NUMBER;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : Fnugetnumasigserv
    Descripcion    : Determina la cantidad de usuarios a los cuales
                     se les asigno un subsidio por poblacion
  ******************************************************************/
  Function Fnugetnumasigserv(inuubication in ld_ubication.ubication_id%TYPE ) RETURN NUMBER;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : Fnugetdifesapebyconc
    Descripcion    : Determina la cantidad de usuarios a los cuales
                     se les asigno un subsidio por poblacion
  ******************************************************************/
  Function Fnugetdifesapebyconc(inususcodi    IN suscripc.susccodi%TYPE,
                                inunuse       IN servsusc.sesunuse%TYPE,
                                inuconc       IN diferido.difeconc%TYPE,
                                inuRaiseError IN NUMBER DEFAULT 1
                               ) RETURN diferido.difesape%TYPE;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : Fnugetctacobbysub
    Descripcion    : Obtiene la cuenta de cobro asociada al cargo
                     credito por el concepto de aplicacion del
                     subsidio
  ******************************************************************/
  Function Fnugetctacobbysub(inunuse       IN servsusc.sesunuse%TYPE,
                             inuconc       IN concepto.conccodi%TYPE,
                             inuRaiseError IN NUMBER DEFAULT 1
                            ) RETURN diferido.difesape%TYPE;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : Fnugetasigsubbysusc
    Descripcion    : Determina si un suscriptor posee asociado un
                     subsidio
  ******************************************************************/
  Function Fnugetasigsubbysusc(inusubdisy    IN ld_subsidy.subsidy_id%TYPE,
                               inususc       IN suscripc.susccodi%TYPE
                              ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnugetactivesesunuse
   Descripcion    : Obtiene el el servicio suscrito activo de GAS
                    de una suscripcion
  ******************************************************************/
  Function Fnugetactivesesunuse(inususcripc   IN servsusc.sesususc%TYPE,
                                inuRaiseError IN NUMBER DEFAULT 1
                               ) RETURN servsusc.sesunuse%TYPE;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnuexistactivesubasig
   Descripcion    : Consulta si existen ventas subsidiadas en estado
                    diferente a reversado.
  ******************************************************************/
  Function Fnuexistactivesubasig(inusubsidy ld_subsidy.subsidy_id%TYPE ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnugetubiactiveasig
   Descripcion    : Determina si existen subsidios asignados a una
                    ubicacion determinada y que no se encuentren
                    en estado inactivo
  ******************************************************************/
  Function Fnugetubiactiveasig(inuubication ld_ubication.ubication_id%TYPE ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnugetsubincollectbydate
   Descripcion    : Determina si existen subsidios asignados en
                    estado cobrado para un a?o y mes
                    determinado
  ******************************************************************/
  Function Fnugetsubincollectbydate(inuubication IN ld_ubication.ubication_id%TYPE,
                                    inuano       IN NUMBER,
                                    inumes       IN NUMBER
                                   ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnugetsubinpaybydate
   Descripcion    : Determina si existen subsidios asignados en
                    estado pagado para un a?o y mes
                    determinado
  ******************************************************************/
  Function Fnugetsubinpaybydate(inuubication IN ld_ubication.ubication_id%TYPE,
                                inuano       IN NUMBER,
                                inumes       IN NUMBER
                               ) RETURN NUMBER;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : fnugettotquantitybysub
    Descripcion    : Obtiene el total de la sumatoria de los
                     conceptos parametrizados para los
                     subsidios de un convenio parametrizado
                     por cantidad
  ******************************************************************/
  Function fnugettotquantitybysub(inuDEAL_Id IN LD_DEAL.DEAL_ID%TYPE,
                                  inuRaiseError IN NUMBER DEFAULT 1
                                 ) RETURN NUMBER;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : fsbgetfinancingplan
    Descripcion    : Obtiene el plan de financiacion de una
                     solicitud
  ******************************************************************/
  Function fsbgetfinancingplan(inupackage_id in mo_packages.package_id%TYPE ) RETURN VARCHAR2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : fsbgetinstalationtype
    Descripcion    : Obtiene el tipo de instalacion de una
                     solicitud
  ******************************************************************/
  Function fsbgetinstalationtype(inupackage_id in mo_packages.package_id%TYPE
                                ) RETURN VARCHAR2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : fnugetsalequotes
    Descripcion    : Obtiene el numero de cuotas de una
                     solicitud
  ******************************************************************/
  Function fnugetsalequotes(inupackage_id in mo_packages.package_id%TYPE
                           ) RETURN cc_sales_financ_cond.quotas_number%TYPE;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : fnugetinitialquote
    Descripcion    : Obtiene el valor inicial de la cuota de una
                     solicitud
  ******************************************************************/
  Function fnugetinitialquote(inupackage_id in mo_packages.package_id%TYPE
                             ) RETURN cc_sales_financ_cond.quotas_number%TYPE;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : fsbgetcommercialplan
    Descripcion    : Obtiene el plan comercial de una
                     solicitud
  ******************************************************************/
  Function fsbgetcommercialplan(inupackage_id in mo_packages.package_id%TYPE) RETURN VARCHAR2;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnususcwithsubsidy
   Descripcion    : Determina si un usuario tiene asignado un
                    subsidio determinado
  ******************************************************************/
  Function Fnususcwithsubsidy(inuubi     ld_ubication.ubication_id%TYPE,
                              inususc    suscripc.susccodi%TYPE
                             ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnucommonconcepts
   Descripcion    : Determina si existen conceptos en comun entre
                    el plan comercial de la solicitud y una poblacion
  ******************************************************************/
  Function Fnucommonconcepts(inucommercialplan  mo_motive.commercial_plan_id%TYPE,
                             inuservice         servsusc.sesuserv%TYPE,
                             inuubication       ld_ubication.ubication_id%TYPE
                            ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnuaccountwithdebt
   Descripcion    : Determina si existen cuentas de cobro que
                    tengan saldo pendiente
  ******************************************************************/
  Function Fnuaccountwithdebt(inususcripc   IN suscripc.susccodi%TYPE,
                              inuRaiseError IN NUMBER DEFAULT 1
                             ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : FnuDeferredDebt
   Descripcion    : Determina si un contrato posee deuda diferida
                    para los conceptos asociados a una poblacion
                    subsidiada y un plan comercial
                    determinado.
  ******************************************************************/
  Function FnuDeferredDebt(inususcripc       IN suscripc.susccodi%TYPE,
                           inucommercialplan IN mo_motive.commercial_plan_id%TYPE,
                           inuubication      IN ld_ubication.ubication_id%TYPE,
                           inunuse           IN servsusc.sesunuse%TYPE,
                           inuRaiseError     IN NUMBER DEFAULT 1
                          ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnugetsubconcremvalue
   Descripcion    : Determina el valor a subsidiar para un concepto
                    digitado desde la forma LDREM (Asignacion
                    remanente de subsidios).
  ******************************************************************/
  Function Fnugetsubconcremvalue(inuconcepto     IN diferido.difeconc%TYPE,
                                 inuubication    IN ld_ubication.ubication_id%TYPE,
                                 inusesion       IN NUMBER,
                                 inuRaiseError   IN NUMBER DEFAULT 1
                                ) RETURN ld_concepto_rem.asig_value%TYPE;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnuconcremainsub
   Descripcion    : Determina si se almacenaron conceptos
                    a subsidiar en la entidad LD_CONCEPTO_REM.
  ******************************************************************/
  Function Fnuconcremainsub(inusesion IN NUMBER) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnuuserstoapplysubremain
   Descripcion    : Determina si existen usuarios a los
                    cuales se les aplicara el remanente
                    de un subsidio
  ******************************************************************/
  Function Fnuuserstoapplysubremain(inusesion    IN NUMBER,
                                    inusubsidy   IN ld_subsidy.subsidy_id%TYPE,
                                    inuubication IN ld_ubication.ubication_id%TYPE
                                   ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnupackagesbyuser
   Descripcion    : Determina si una solicitud esta asociada a un
                    suscriptor
  ******************************************************************/
  Function Fnupackagesbyuser(inupackages in mo_packages.package_id%type,
                             inususcripc in suscripc.susccodi%TYPE)
                             RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnudetailconceptsbyubi
   Descripcion    : Determina si existen conceptos configurados
                    para una poblacion determinada
  ******************************************************************/
  Function Fnudetailconceptsbyubi(inuubication ld_ubication.ubication_id%TYPE ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnusubbyubimeet
   Descripcion    : Determina si existen subsidios asociados a
                    una poblacion cuya solicitud este atendida
  ******************************************************************/
  Function Fnusubbyubimeet(inuSubsidyId      IN ld_subsidy.subsidy_id%TYPE,
                           inupackagesstatus IN mo_packages.motive_status_id%TYPE
                          ) RETURN NUMBER;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnurowstoapplyremain
   Descripcion    : Determina si existen registros en estado
                    distribuir para una sesion y poblacion
                    determinada
  ******************************************************************/
  Function Fnurowstoapplyremain(inusesion    IN NUMBER,
                                inuubication IN ld_ubication.ubication_id%TYPE
                               ) RETURN NUMBER;

   /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : Fnurowsinsimulation
   Descripcion    : Determina si existen registros en estado
                    simulacion para una sesion y poblacion
                    determinada
   ******************************************************************/
   Function Fnurowsinsimulation(inusesion IN NUMBER, inuubication IN ld_ubication.ubication_id%TYPE ) RETURN NUMBER;

   /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : fnuValTotalDeal
   Descripcion    : Valida si la sumatoria de los subsidios supera el valor
                    total del convenio.
   ******************************************************************/
   Function fnuValTotalDeal( inuubi_id ld_ubication.ubication_id%TYPE ) return number;

   /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : GetPackAsso
   Descripcion    : Obtiene los valores del lote agrupador para la venta de gas.
   ******************************************************************/
   FUNCTION fnuGetPackAsso(inuPackage IN mo_packages.package_id%TYPE) RETURN NUMBER;


   /****************************************************************************
   Propiedad intelectual de Open International Systems (c).
   Unidad         : GetSubSidy
   Descripcion    : Accede a la tabla de subsidios para extraer un subsidio
   *******************************************************************************/
   PROCEDURE GetSubSidy(isbDescription IN  ld_subsidy.description%TYPE,
                        inuDealId      IN  ld_subsidy.deal_id%TYPE,
                        idtInitialDate IN  ld_subsidy.initial_date%TYPE,
                        idtFinalDate   IN  ld_subsidy.final_date%TYPE,
                        idtStartDate   IN  ld_subsidy.star_collect_date%TYPE,
                        inuConceptId   IN  ld_subsidy.conccodi%TYPE,
                        ocuSubsidy     OUT constants_per.tyrefcursor);

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  frcAvlbleSubsidyByLoc
    Descripcion :  Obtiene el subsidio disponible por ubicacion geografica,
                   categoria y subcategoria.

    Autor       :  Santiago Gomez Rico
    Fecha       :  06-12-2013
    Parametros  :  inuPromo         Promocion.
                   idtReqDate       Fecha solicitud venta (TRUNCADA).
                   inuAddress       Direccion.
                   inuCateg         Categoria
                   inuSubCateg      Subcategoria.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    06-12-2013   sgomez.SAO226500   Creacion.
    ***************************************************************/

    FUNCTION frcAvlbleSubsidyByLoc
    (
        inuPromo    in  ld_subsidy.promotion_id%type,
        idtReqDate  in  ld_subsidy.initial_date%type,
        inuAddress  in  ab_address.address_id%type,
        inuCateg    in  ld_ubication.sucacate%type,
        inuSubCateg in  ld_ubication.sucacodi%type
    )
        return ld_ubication%rowtype;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuMotPromotionByPack
    Descripcion :  Obtiene el ID de promocion por motivo asociado a la solicitud.

    Autor       :  Santiago Gomez Rico
    Fecha       :  11-12-2013
    Parametros  :  inuPackage       Solicitud de venta.
                   inuPromo         Promocion.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    11-12-2013   sgomez.SAO227083   Creacion.
    ***************************************************************/
    FUNCTION fnuMotPromotionByPack
    (
        inuPackage  in  mo_motive.package_id%type,
        inuPromo    in  mo_mot_promotion.promotion_id%type
    )
        return mo_mot_promotion.mot_promotion_id%type;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FnuGetPackAsig
    Descripcion :  Verifica si existen subsidios asignados para la misma
                   solicitud de venta.

    Autor       :  John Wilmer Robayo
    Fecha       :  17-12-2013
    Parametros  :  inuPackage       Solicitud de venta.
                   inuUbication     Promocion.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    11-12-2013   jrobayo.SAO227491   Creacion.
    ***************************************************************/

    FUNCTION FnuGetPackAsig (inuPackage in mo_packages.package_id%type,
                             inuUbication in ld_ubication.ubication_id%type)
                             return number;
    /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetCountRem
   Descripcion    : Obtiener el numero total de los subsidios remanentes
                    segun su estado de distribucion.

   Autor          : John Wilmer Robayo
   Fecha          : 18/12/2013

   Parametros       Descripcion
   ============     ===================
   inuState         Estado del remanente (D:Distribuido, P:Procesado)
   inuSubsidy       Id del Subsidio
   inuUbication     Ubicacion
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   17/12/2013       jrobayo.SAO227371     Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
  ******************************************************************/

    FUNCTION FnuGetCountRem(inuState in ld_sub_remain_deliv.state_delivery%type,
                            inuSubsidy in ld_sub_remain_deliv.subsidy_id%type,
                            inuUbication in ld_sub_remain_deliv.ubication_id%type)
                            return number;

    /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumRem
   Descripcion    : Obtiener la suma del valor entregado de los
                    subsidios remanentes segun su estado de distribucion.

   Autor          : John Wilmer Robayo
   Fecha          : 18/12/2013

   Parametros       Descripcion
   ============     ===================
   inuState         Estado del remanente (D:Distribuido, P:Procesado)
   inuSubsidy       Id del Subsidio
   inuUbication     Ubicacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   18/12/2013       jrobayo.SAO227371     Creacion
  ******************************************************************/

    FUNCTION FnuGetSumRem(inuState in ld_sub_remain_deliv.state_delivery%type,
                            inuSubsidy in ld_sub_remain_deliv.subsidy_id%type,
                            inuUbication in ld_sub_remain_deliv.ubication_id%type)
                            return number;
    /**********************************************************************
     Propiedad intelectual de OPEN International Systems
     Nombre              persistSimulation

     Autor                Andres Felipe Esguerra Restrepo

     Fecha               18-dic-2013

     Descripcion         Se encarga de marcar como distribuidos los
                         registros simulados en LDREM

     ***Historia de Modificaciones***
     Fecha Modificacion                Autor
     .                                .
    ***********************************************************************/
    PROCEDURE persistSimulation;



END Ld_BcSubsidy;
/
CREATE OR REPLACE PACKAGE BODY      LD_BCSUBSIDY is
  /********************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BcSubsidy
    Descripcion    : Realizar las consultas necesarias para el proceso
                     de subsidios
    Autor          : Jonathan Alberto Consuegra Lara
    Fecha          : 22/09/2012

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========       ====================   =======================================
    22-03-2024      pacosta                OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                            Frfgetsubsidytocollect
                                            FrfGenlettertopotential
                                            FnuGetSubscriberCate
                                            FnuGetSubscriberSubCate
                                            Frfconsalewithoutsub
                                            Frfcontsubwitoutdoc
                                            Frfconsalewithsub
                                            Frfconcollectsubsidy
                                            frfbillsalessubsidy
                                            FnuGetSubscriberUbi
                                            Procgetsububication
                                            Procgetubication
                                            FsbGetTecStatus
                                            Fnugetnumasigserv
                                            FnuGetPackAsig
                                            proProcesaArchivoPlano
                                            fnutotdeliversub
                                            fnutotdealavailable
                                            fnutotauthorize_value
                                            fnudealubisub
                                            fnudealconcsub
                                            fnutotalvaluedetail
                                            fnuexiststotaldetail
                                            fnutotalvalconc
                                            fnuexistsquantitydetail
                                            Fnutotsubpercentage
                                            Fnuvaluepercentagexdeal
                                            Fnutotquantityrecover
                                            Fnutottorecover
                                            Fnuquantitydealinsunsidy
                                            Fdtminsubstardate
                                            Fdtmaxsubenddate
                                            Procgetdeal
                                            Procgetdealsubsidy
                                            Procgetsubsidy
                                            Procgetubiconc
                                            Procgetconc
                                            Procgetubirecovery
                                            Procgetrecovery
                                            Frfconsultsubtomove
                                            Fnugetpromsubsidy
                                            Fnugetsubasig
                                            Fnugetmotive
                                            Fnugetpackageaddress
                                            Procsubscribephones
                                            Fnuexistsubasig
                                            Fnugetlastdateasigsub
                                            Procgetmaxdaterecovery
                                            Fnugetubiasig
                                            Fnugetsesunuse
                                            Frfdebtconcept
                                            Fnubilluser
                                            Procsubswithdocok
                                            Fnugetidsalewithoutsub
                                            Procgetsubsidies
                                            FnuTotalSubsidyByState
                                            FnuTotalSales
                                            FnuTotalSalesByState
                                            Frfsubrem
                                            Frfconcrem
                                            Fnuuserwithsubsidy
                                            ProcgetubiconcforPI
                                            Fnugetsubtotaldelivery
                                            FNuAmountAsigSubsidy
                                            Fnugetintallationorder
                                            FnuGetContSub
                                            FnuGetSumSub
                                            Fnugetnumaxrec
                                            FnuGetValMaxRec
                                            fsbgetsystlocation
                                            Fsbgetenterprise
                                            Fnugetenterprisephone
                                            Fnugetuserisconnect
                                            FrcGetSuscAsigSubsidy
                                            Fnuuserwithsubsamedeal
                                            Fnugetsalwithsubasig
                                            Fnugetsubsidypackage
                                            FnuGetDeliveryTotal
                                            FnuGetSumSubRem
                                            FnuGetContSubRem
                                            FnuGetValDisByServ
                                            FsbGetProcTypeRemSub
                                            FnuGetContSubRemAn
                                            FnuGetContSubRemDi
                                            FnuGetContSubRemPr
                                            FnuGetSumSubRemAn
                                            FnuGetSumSubRemDi
                                            FnuGetSumSubRemPr
                                            fnutotquantitysubbydeal
                                            fcltempclob
                                            Fcldupbillclob
                                            Fsbgetsucadesc
                                            Fnugetsomesuscripc
                                            Fnugetdifesapebyconc
                                            Fnugetctacobbysub
                                            Fnugetasigsubbysusc
                                            Fnugetactivesesunuse
                                            Fnuexistactivesubasig
                                            Fnugetubiactiveasig
                                            Fnugetsubincollectbydate
                                            Fnugetsubinpaybydate
                                            fnugettotquantitybysub
                                            Fnususcwithsubsidy
                                            Fnucommonconcepts
                                            Fnuaccountwithdebt
                                            FnuDeferredDebt
                                            Fnugetsubconcremvalue
                                            Fnuconcremainsub
                                            Fnuuserstoapplysubremain
                                            Fnupackagesbyuser
                                            Fnudetailconceptsbyubi
                                            Fnusubbyubimeet
                                            Fnurowstoapplyremain
                                            Fnurowsinsimulation
                                            fnuValTotalDeal
                                            fnuGetPackAsso
                                            GetSubSidy
                                            frcAvlbleSubsidyByLoc
                                            fnuMotPromotionByPack
                                            FnuGetCountRem
                                            FnuGetSumRem
                                            fnutotquantidetail
                                            Fnugetsubinpaystates
                                            FnuGetPackageSalesContract
                                            Fnugettaricodi
                                            fsbgetfinancingplan
                                            fsbgetinstalationtype
                                            fnugetsalequotes
                                            fnugetinitialquote
                                            fsbgetcommercialplan
    26-02-2014      mgutierrSAO234187      Se eliminan los hints de la sentencia
                                           de Frfcontsubwitoutdoc
    18-Ene-2013      AEcheverry.SAO229887   Se modifica FrfGenlettertopotential
    22-12-2013      JCarmona.SAO228583      Se modifica <<FrfGenlettertopotential>>
    17-12-2013      jrobayo.SAO227371      1. Se crean los metodos
                                            <<FnuGetSumRem>>
                                            <<FnuGetCountRem>>
                                           2. Se modifican los metodos para omitir la
                                              validacion por sesion
                                            <<FnuGetContSubRemAn>>
                                            <<FnuGetContSubRemDi>>
                                            <<FnuGetContSubRemPr>>
                                            <<FnuGetSumSubRemAn>>
                                            <<FnuGetSumSubRemDi>>
                                            <<FnuGetSumSubRemPr>>
    17-12-2013      jrobayo.SAO227491      Se adiciona el metodo <FnuGetPackAsig>
    13-12-2013      jrobayo.SAO227371      Se modifican los metodos
                                            <FnuGetSumSubRem>
                                            <FnuGetContSubRem>
                                            <Fnugetnumasigserv>
    11-12-2013       sgomez.SAO227083       Se adiciona metodo <fnuMotPromotionByPack>
                                           para obtencion de ID de promocion por motivo,
                                           asociado a una solicitud de venta.
    06-12-2013      sgomez.SAO226500       Se adiciona metodo <frcAvlbleSubsidyByLoc>
                                           para obtencion de subsidio disponible en
                                           una ubicacion geografica, categoria y
                                           subcategoria.
    06-12-2013      hjgomez.SAO226118       Se modifica <<Frfconsalewithoutsub>>
    05-12-2013      hjgomez.SAO226138       Se modifica <<FrfGenlettertopotential>>
    26-11-2013      hjgomez.SAO224918       Se modifica <<Frfconcollectsubsidy>>
    19-11-2013      anietoSAO223767         1 - Nuevo procedimiento <<GetSubSidy>>
    22/09/2012      jconsuegra.SAO156577    Creacion
  ********************************************************************************/
  -- Constantes para el control de la traza
  csbSP_NAME                 CONSTANT VARCHAR2(100)       := $$PLSQL_UNIT||'.';
  cnuNVLTRC                  CONSTANT NUMBER              := pkg_traza.cnuNivelTrzDef;
  csbInicio   	             CONSTANT VARCHAR2(35) 	      := pkg_traza.csbINICIO;
  csbFin         	         CONSTANT VARCHAR2(35) 	      := pkg_traza.csbFIN;
    
  -- Constante global objeto
  gcnuerrorcode              CONSTANT NUMBER              := pkg_error.CNUGENERIC_MESSAGE;

  -- Constante versionamiento objeto
  csbVERSION                 CONSTANT VARCHAR2(10)        := 'OSF-2380';

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbVersion
    Descripcion    : Retorna caso ticket que se realizó la última entrega
    Fecha          : 

    Parametros       Descripcion
    ============     ===================
    

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    04/04/2024       pacosta               Eliminar llamados al objeto pkErrors
   
  ******************************************************************/
  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN  
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotdeliversub
    Descripcion    : Obtiene el total entregado de los subsidios
                     asociados a un convenio cuya valor
                     autorizado sea mayor a cero
    Autor          : jonathan alberto consuegra lara
    Fecha          : 22/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    22/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
    Function fnutotdeliversub(inuDEAL_Id in LD_deal.DEAL_Id%type) return number is
        nutotal_deliver ld_subsidy.total_deliver%type := ld_boconstans.cnuCero_Value;

        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotdeliversub';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    Begin

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        SELECT SUM(nvl(l.total_deliver, ld_boconstans.cnuCero_Value)) total_entregado
        Into nutotal_deliver
        FROM ld_subsidy l
        WHERE l.deal_id = inuDEAL_Id
        AND l.authorize_value is not null;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        Return(nutotal_deliver);

    Exception
        When pkg_error.CONTROLLED_ERROR then
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);    
        raise pkg_error.controlled_error;
    When others then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
    End fnutotdeliversub;
  
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotdealavailable
    Descripcion    : Obtiene el valor disponible de un convenio
    Autor          : jonathan alberto consuegra lara
    Fecha          : 22/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplicab pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    22/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotdealavailable(inuDEAL_Id in LD_deal.DEAL_Id%type)
    return number is
    nutotal_available ld_subsidy.total_available%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotdealavailable';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.total_available, ld_boconstans.cnuCero_Value)) total_disponible
      Into nutotal_available
      FROM ld_subsidy l
     WHERE l.deal_id = inuDEAL_Id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nutotal_available);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnutotdealavailable;
  
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotauthorize_value
    Descripcion    : Obtiene el total autorizado de los subsidios
                     asociados a un convenio
    Autor          : jonathan alberto consuegra lara
    Fecha          : 24/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    24/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotauthorize_value(inuDEAL_Id in LD_deal.DEAL_Id%type)
    return number is
    nutoauthorize_value ld_subsidy.authorize_value%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotauthorize_value';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.authorize_value, ld_boconstans.cnuCero_Value)) total_autorizado
      Into nutoauthorize_value
      FROM ld_subsidy l
     WHERE l.deal_id = inuDEAL_Id
       AND l.authorize_value is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nutoauthorize_value);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnutotauthorize_value;
  
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnudealubisub
    Descripcion    : Determina si existe poblaciones subsidiadas
                     por un subsidios de un convenio determinado
                     y cuya cantidad autorizada se encuentre
                     parametrizada.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 24/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    24/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnudealubisub(inuDEAL_Id in LD_deal.DEAL_Id%type) return number is
    nurows number(4) := Ld_Boconstans.cnuCero;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnudealubisub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT /*+ USE_NL(l su) */
     count(1) nurows
      INTO nurows
      FROM ld_ubication l, ld_subsidy su
     WHERE su.deal_id = inuDEAL_Id
       AND l.authorize_quantity is not null
       AND su.authorize_quantity is not null
       AND l.subsidy_id = su.subsidy_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnudealubisub;
  
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnudealconcsub
    Descripcion    : Determina si existen conceptos subsidiados
                     por subsidios asociados a un convenio
                     determinado y cuya cantidad autorizada se
                     encuentre parametrizada.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 24/09/2012

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    24/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnudealconcsub(inuDEAL_Id in LD_deal.DEAL_Id%type) return number is
    nurows number(4);

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnudealconcsub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT /*+ USE_NL(l su de) */
     count(1) nurows
      INTO nurows
      FROM ld_ubication l, ld_subsidy su, ld_subsidy_detail de
     WHERE su.deal_id = inuDEAL_Id
       AND l.authorize_quantity is not null
       AND su.authorize_quantity is not null
       AND l.subsidy_id = su.subsidy_id
       AND de.ubication_id = l.ubication_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnudealconcsub;
  
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotalvaluedetail
    Descripcion    : Obtiene la sumatoria de los valores autorizados
                     de los detalles de un subsidios.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 26/09/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    26/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotalvaluedetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number is
    nuTotal ld_ubication.authorize_quantity%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotalvaluedetail';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.authorize_value, ld_boconstans.cnuCero_Value)) total
      INTO nuTotal
      FROM ld_ubication l
     WHERE l.authorize_quantity is null
       AND l.authorize_value is not null
       AND l.subsidy_id = inuSub;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuTotal);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnutotalvaluedetail;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuexiststotaldetail
    Descripcion    : Obtiene la existencia de los valores autorizados
                     de los detalles de un subsidios.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 26/09/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    26/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnuexiststotaldetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number is
    nuCount number(4) := Ld_Boconstans.cnuCero;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuexiststotaldetail';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nuCount
      FROM ld_ubication l
     WHERE l.authorize_quantity is null
       AND l.authorize_value is not null
       AND l.subsidy_id = inuSub;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuCount);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnuexiststotaldetail;
  
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnutotalvalconc
    Descripcion    : Obtiene la sumatoria de los valores subsidiados
                     para los conceptos parametrizados para una
                     poblacion.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/10/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    03/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotalvalconc(inuUbi in Ld_Ubication.Ubication_Id%type)
    return number is

    nutotal ld_subsidy_detail.subsidy_value%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotalvalconc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(NVL(l.subsidy_value, ld_boconstans.cnuCero_Value)) total
      INTO nutotal
      FROM ld_subsidy_detail l
     WHERE l.ubication_id = inuUbi
       AND l.subsidy_percentage is null
       AND l.subsidy_value is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nutotal);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnutotalvalconc;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuexistsquantitydetail
    Descripcion    : Obtiene la existencia de las cantidades
                     autorizadas de las poblaciones de un subsidios.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 04/09/2012

    Parametros       Descripcion
    ============     ===================
    inuSub          identificador del subsidio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    04/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnuexistsquantitydetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number is
    nuCount number(4) := Ld_Boconstans.cnuCero;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuexistsquantitydetail';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nuCount
      FROM ld_ubication l
     WHERE l.authorize_quantity is not null
       AND l.authorize_value is null
       AND l.subsidy_id = inuSub;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuCount);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnuexistsquantitydetail;
  --
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fnutotquantidetail
   Descripcion    : Obtiene la sumatoria de las cantidades
                    autorizadas en el detalle de un subsidio.
   Autor          : jonathan alberto consuegra lara
   Fecha          : 04/09/2012

   Parametros       Descripcion
   ============     ===================
   inuSub           identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   04/09/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotquantidetail(inuSub in Ld_Subsidy.Subsidy_Id%type)
    return number is
    nuTotal ld_ubication.authorize_quantity%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotquantidetail';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.authorize_quantity, ld_boconstans.cnuCero_Value)) total
      INTO nuTotal
      FROM ld_ubication l
     WHERE l.authorize_quantity is not null
       AND l.authorize_value is null
       AND l.subsidy_id = inuSub;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuTotal);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnutotquantidetail;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnu_gettaricodi
   Descripcion    : Obtiene el codigo tarifario de la tarifa de
                    un concepto.
   Autor          : jonathan alberto consuegra lara
   Fecha          : 10/10/2012

   Parametros       Descripcion
   ============     ===================
   inuconc          identificador del concepto
   inuserv          identificador del servicio
   inucate          categoria
   inusubcate       subcategoria - estrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   10/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugettaricodi(inuconc    concepto.conccodi%type,
                          inuserv    servicio.servcodi%type,
                          inucate    categori.catecodi%type,
                          inusubcate subcateg.sucacodi%type) return number is

    Cursor cuTaricodi(inuService     number,
                      inuCategori    number,
                      inuSubcategori number,
                      inuConcepto    number) is
      SELECT t.tacocodi
        FROM tariconc t
       WHERE t.tacoserv =
             Decode(inuService, '1', inuserv, LD_BOConstans.cnuallrows)
         AND t.tacocate =
             Decode(inuCategori, '1', inucate, LD_BOConstans.cnuallrows)
         AND t.tacosuca = Decode(inuSubcategori,
                                 '1',
                                 inusubcate,
                                 LD_BOConstans.cnuallrows)
         AND t.tacoconc =
             Decode(inuConcepto, '1', inuconc, LD_BOConstans.cnuallrows);

    nuCont     number;
    nuValPar   number;
    nutaricodi tariconc.tacocodi%type;
    sbContBina Varchar2(100);
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugettaricodi';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nuValPar := LD_BOConstans.cnuCero_Value;

    nuCont := LD_BOConstans.cnubinaryfournumber;

    While (nuValPar = LD_BOConstans.cnuCero_Value) And
          nuCont >= LD_BOConstans.cnuCero_Value Loop

      sbContBina := Lpad(Ld_bosubsidy.fsbConverttobin(nuCont),
                         LD_BOConstans.cnufournumber,
                         to_char(LD_BOConstans.cnuCero_Value));

      Open cuTaricodi(Substr(sbContBina,
                             LD_BOConstans.cnuonenumber,
                             LD_BOConstans.cnuonenumber),
                      Substr(sbContBina,
                             LD_BOConstans.cnutwonumber,
                             LD_BOConstans.cnuonenumber),
                      Substr(sbContBina,
                             LD_BOConstans.cnuthreenumber,
                             LD_BOConstans.cnuonenumber),
                      Substr(sbContBina,
                             LD_BOConstans.cnufournumber,
                             LD_BOConstans.cnuonenumber));

      Fetch cuTaricodi
        Into nutaricodi;

      If cuTaricodi%Notfound Then
        nuCont := nuCont - LD_BOConstans.cnuonenumber;
      Else
        nuCont   := nuCont - LD_BOConstans.cnuonenumber;
        nuValPar := LD_BOConstans.cnuonenumber;
      End If;

      Close cuTaricodi;
    End Loop;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(nutaricodi);
    
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugettaricodi;
 
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnutotsubpercentage
    Descripcion    : Obtiene la sumatoria de los valores
                     porcentuales de los conceptos subsidiados
                     por ubicacion geografica asociados a un
                     subsidio.
    Autor          : jonathan alberto consuegra lara
    Fecha          : 11/10/2012

    Parametros       Descripcion
    ============     ===================
    inuserv          identificador del servicio
    idtfecha         fecha de vigencia de la tarifa
    inuubi_id        identificador de la poblacion a subsidiar

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnica
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    11/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnutotsubpercentage(inuserv   servicio.servcodi%type,
                               idtfecha  regltari.retafein%type,
                               inuubi_id ld_ubication.ubication_id%type)
    return number is

    nutotsubporcen ld_subsidy.authorize_value%type := ld_boconstans.cnuCero_Value;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnutotsubpercentage';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT /*+ USE_NL(l u) */
     Sum(Nvl(Ld_BoSubsidy.fnupercentageconcvalue(l.conccodi,
                                                 inuserv,
                                                 u.sucacate,
                                                 u.sucacodi,
                                                 u.geogra_location_id,
                                                 idtfecha,
                                                 l.subsidy_percentage),
             ld_boconstans.cnuCero_Value))

      INTO nutotsubporcen
      FROM ld_subsidy_detail l, ld_ubication u
     WHERE l.ubication_id = inuubi_id
       AND l.ubication_id = u.ubication_id
       AND l.subsidy_percentage is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    
    return(nutotsubporcen);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnutotsubpercentage;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnuvaluepercentagexdeal
    Descripcion    : Obtiene la sumatoria de los valores
                     porcentuales de los conceptos subsidiados
                     asociados a un convenio.

    Autor          : jonathan alberto consuegra lara
    Fecha          : 12/10/2012

    Parametros       Descripcion
    ============     ===================
    inuserv          identificador del servicio
    idtfecha         fecha de vigencia de la tarifa
    inuDeal          identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    12/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuvaluepercentagexdeal(inuserv       servicio.servcodi%type,
                                   idtfecha      regltari.retafein%type,
                                   inuDeal       ld_subsidy.deal_id%type,
                                   inuRaiseError in number default 1)
    return number is

    nutotsubporcen ld_subsidy.authorize_value%type := ld_boconstans.cnuCero_Value;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuvaluepercentagexdeal';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT /*+ USE_NL(copy ub) */
     SUM(copy.val * ub.authorize_quantity) tot
      INTO nutotsubporcen
      FROM (SELECT /*+ USE_NL(l s a) */
             s.ubication_id,
             SUM(Nvl(Ld_BoSubsidy.fnupercentageconcvalue(a.conccodi,
                                                         inuserv,
                                                         s.sucacate,
                                                         s.sucacodi,
                                                         s.geogra_location_id,
                                                         idtfecha,
                                                         a.subsidy_percentage),
                     ld_boconstans.cnuCero_Value)) val

              FROM ld_subsidy l, ld_ubication s, ld_subsidy_detail a
             WHERE l.deal_id = inuDeal
               AND l.authorize_quantity is not null
               AND l.subsidy_id = s.subsidy_id
               AND s.ubication_id = a.ubication_id
             GROUP BY s.ubication_id) copy,
           ld_ubication ub
     WHERE copy.ubication_id = ub.ubication_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(nutotsubporcen);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;        
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnuvaluepercentagexdeal;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnutotquantityrecover
   Descripcion    : Obtiene la sumatoria de los topes a cobrar
                    para una poblacion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/10/2012

   Parametros       Descripcion
   ============     ===================
   inuubi_id        identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnutotquantityrecover(inuubi_id ld_ubication.ubication_id%type)
    return number is
    nutotquantity ld_max_recovery.total_sub_recovery%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnutotquantityrecover';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.total_sub_recovery, LD_BOConstans.cnuCero_Value)) tot
      INTO nutotquantity
      FROM ld_max_recovery l
     WHERE l.ubication_id = inuubi_id
       AND l.total_sub_recovery is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(nutotquantity);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnutotquantityrecover;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnutottorecover
   Descripcion    : Obtiene la sumatoria de los valores a cobrar
                    para una poblacion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/10/2012

   Parametros       Descripcion
   ============     ===================
   inuubi_id        identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnutottorecover(inuubi_id ld_ubication.ubication_id%type)
    return number is
    nutotvalue ld_max_recovery.recovery_value%type := ld_boconstans.cnuCero_Value;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnutottorecover';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.recovery_value, LD_BOConstans.cnuCero_Value)) tot
      INTO nutotvalue
      FROM ld_max_recovery l
     WHERE l.ubication_id = inuubi_id
       AND l.recovery_value is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(nutotvalue);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnutottorecover;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuquantitydealinsunsidy
   Descripcion    : Obtiene la cantidad de subsidios que se
                    encuentran asociados a un convenio determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuquantitydealinsunsidy(inuDeal ld_subsidy.deal_id%type)
    return number is
    nutot number := Ld_Boconstans.cnuCero;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuquantitydealinsunsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT COUNT(1) INTO nutot FROM ld_subsidy l WHERE l.deal_id = inuDeal;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(nutot);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End;

  --
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fdtminsubstardate
   Descripcion    : Obtiene la minima fecha de inicio de vigencia
                    de los subsidios asociados a un convenio
                    determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fdtminsubstardate(inuDeal ld_subsidy.deal_id%type) return date is
    dtmindate date;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fdtminsubstardate';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT MIN(l.initial_date)
      INTO dtmindate
      FROM ld_subsidy l
     WHERE l.deal_id = inuDeal;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(dtmindate);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End;
  
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fdtmaxsubenddate
   Descripcion    : Obtiene la maxima fecha de fin de vigencia
                    de los subsidios asociados a un convenio
                    determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fdtmaxsubenddate(inuDeal ld_subsidy.deal_id%type) return date is
    dtmaxdate date;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fdtmaxsubenddate';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT MAX(l.final_date)
      INTO dtmaxdate
      FROM ld_subsidy l
     WHERE l.deal_id = inuDeal;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return(dtmaxdate);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetdeal
   Descripcion    : Obtiene los datos de un convenio para
                    visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 23/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetdeal(inuDeal ld_deal.deal_id%type,
                        Orfdeal out constants_per.tyrefcursor) is
                        
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetdeal';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfdeal FOR
      SELECT l.deal_id,
             l.deal_id||' - '||l.description deal,
             l.initial_date,
             l.final_date,
             l.total_value,
             l.sponsor_id||' - '||dald_sponsor.fsbGetDescription(l.sponsor_id, null) sponsor,
             l.disable_deal,
             l.disable_date
        FROM ld_deal l
       WHERE l.deal_id = inuDeal;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetdeal;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetdealsubsidy
   Descripcion    : Obtiene los subsidios asociados a un convenio
                    para visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 23/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetdealsubsidy(inuDeal    ld_deal.deal_id%type,
                               Orfsubsidy out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetdealsubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfsubsidy FOR
      SELECT l.subsidy_id,
             l.subsidy_id||' - '||l.description subsidy,
             l.deal_id,
             l.deal_id||' - '||dald_deal.fsbGetDescription(l.deal_id, null) deal,
             l.initial_date,
             l.final_date,
             l.star_collect_date,
             l.conccodi||' - '||pktblconcepto.fsbGetConcdesc(l.conccodi, null) concepto,
             l.validity_year_means,
             l.authorize_quantity,
             l.authorize_value,
             (case
               when l.remainder_status is not null then
                l.remainder_status||' - '||ld_bosubsidy.fsbgetremainstatusdesc(l.remainder_status)
               else
                null
             end) remainder_status,
             Ld_BcSubsidy.Fnugetsubasig(l.subsidy_id) Ventas_realizadas,
             l.total_deliver,
             l.total_available,
             l.promotion_id||' - '||dacc_promotion.fsbGetDescription(l.promotion_id, null) promocion,
             (case
               when l.origin_subsidy is not null then
                l.origin_subsidy||' - '||dald_subsidy.fsbGetDescription(l.origin_subsidy, null)
               else
                null
             end) sub_ori,
             Decode(Ld_Bosubsidy.FsbActiveSubsidy(l.subsidy_id), 'Y', 'SI', 'NO') Activo
        FROM ld_subsidy l
       WHERE l.deal_id = inuDeal
       ORDER BY l.subsidy_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetdealsubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetsubsidy
   Descripcion    : Obtiene la informacion de un subsidio determinado
                    para visualizarlo en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetsubsidy(inuSubsidy ld_subsidy.subsidy_id%type,
                           Orfsubsidy out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetsubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfsubsidy FOR
      SELECT l.subsidy_id,
             l.subsidy_id||' - '||l.description subsidy,
             l.deal_id,
             l.deal_id||' - '||dald_deal.fsbGetDescription(l.deal_id, null) deal,
             l.initial_date,
             l.final_date,
             l.star_collect_date,
             l.conccodi||' - '||pktblconcepto.fsbGetConcdesc(l.conccodi, null) concepto,
             l.validity_year_means,
             l.authorize_quantity,
             l.authorize_value,
             (case
               when l.remainder_status is not null then
                l.remainder_status||' - '||ld_bosubsidy.fsbgetremainstatusdesc(l.remainder_status)
               else
                null
             end) remainder_status,
             Ld_BcSubsidy.Fnugetsubasig(l.subsidy_id) Ventas_realizadas,
             l.total_deliver,
             l.total_available,
             l.promotion_id||' - '||dacc_promotion.fsbGetDescription(l.promotion_id, null) promocion,
             (case
               when l.origin_subsidy is not null then
                l.origin_subsidy||' - '||dald_subsidy.fsbGetDescription(l.origin_subsidy, null)
               else
                null
             end) sub_ori,
             Decode(Ld_Bosubsidy.FsbActiveSubsidy(l.subsidy_id), 'Y', 'SI', 'NO') Activo
        FROM ld_subsidy l
       WHERE l.subsidy_id = inuSubsidy;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetsubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetsububication
   Descripcion    : Obtiene las poblaciones beneficiadas por un
                    subsidio determinado para visualizarlas en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetsububication(inuSubsidy   ld_ubication.subsidy_id%type,
                                Orfubication out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetsububication';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfubication FOR
        SELECT l.ubication_id,
             l.subsidy_id,
             l.geogra_location_id||' - '||pkg_bcdirecciones.fsbgetdescripcionubicageo(l.geogra_location_id) geogra_location,
             (case
               when l.sucacate is not null then
                l.sucacate||' - '||dacategori.fsbgetcatedesc(l.sucacate)
               else
                to_char(l.sucacate)
             end) category,
             (case
               when l.sucacodi is not null then
                l.sucacodi||' - '||dasubcateg.fsbgetsucadesc(l.sucacate, l.sucacodi)
               else
                to_char(l.sucacodi)
             end) subcategory,
             l.authorize_quantity,
             l.authorize_value,
             l.total_deliver,
             l.total_available
        FROM ld_ubication l
       WHERE l.subsidy_id = inuSubsidy
       ORDER BY l.ubication_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetsububication;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetubication
   Descripcion    : Obtiene la informacion de una poblacion
                    subsidiada en particular, visualizarla en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetubication(inuUbication ld_ubication.ubication_id%type,
                             Orfubication out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetubication';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfubication FOR
      SELECT l.ubication_id,
             l.subsidy_id,
             l.geogra_location_id||' - '||pkg_bcdirecciones.fsbgetdescripcionubicageo(l.geogra_location_id) geogra_location,
             (case
               when l.sucacate is not null then
                l.sucacate||' - '||dacategori.fsbgetcatedesc(l.sucacate)
               else
                to_char(l.sucacate)
             end) category,
             (case
               when l.sucacodi is not null then
                l.sucacodi||' - '||dasubcateg.fsbgetsucadesc(l.sucacate, l.sucacodi)
               else
                to_char(l.sucacodi)
             end) subcategory,
             l.authorize_quantity,
             l.authorize_value,
             l.total_deliver,
             l.total_available
        FROM ld_ubication l
       WHERE l.ubication_id = inuUbication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetubication;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetubiconc
   Descripcion    : Obtiene la informacion de los conceptos
                    subsidiados para una poblacion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetubiconc(inuUbication ld_ubication.ubication_id%type,
                           Orfconcepto  out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetubiconc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfconcepto FOR
      SELECT l.*, rowid
        FROM ld_subsidy_detail l
       WHERE l.ubication_id = inuUbication
       ORDER BY l.subsidy_detail_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetubiconc;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetconc
   Descripcion    : Obtiene la informacion de un concepto
                    subsidiado para una poblacion, para
                    visualizarlo en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetconc(inuConcid   ld_subsidy_detail.subsidy_detail_id%type,
                        Orfconcepto out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetconc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfconcepto FOR
      SELECT l.subsidy_detail_id,
             l.conccodi||' - '||pktblconcepto.fsbGetConcdesc(l.conccodi, null) concepto,
             l.subsidy_percentage,
             l.subsidy_value,
             l.ubication_id
        FROM ld_subsidy_detail l
       WHERE l.subsidy_detail_id = inuConcid;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetconc;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetubirecovery
   Descripcion    : Obtiene la informacion de los topes de cobro
                    asociados a una poblacion subsidiada, para
                    visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetubirecovery(inuUbi      ld_max_recovery.ubication_id%type,
                               Orfrecovery out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetubirecovery';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfrecovery FOR
      SELECT l.max_recovery_id,
             l.year,
             l.month,
             l.total_sub_recovery,
             l.recovery_value,
             l.ubication_id
        FROM ld_max_recovery l
       WHERE l.ubication_id = inuUbi
       ORDER BY l.max_recovery_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetubirecovery;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetrecovery
   Descripcion    : Obtiene la informacion de un tope de cobro
                    asociado a una poblacion subsidiada, para
                    visualizarlo en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetrecovery(inurecovery ld_max_recovery.ubication_id%type,
                            Orfrecovery out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetrecovery';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfrecovery FOR
      SELECT l.max_recovery_id,
             l.year,
             l.month,
             l.total_sub_recovery,
             l.recovery_value,
             l.ubication_id
        FROM ld_max_recovery l
       WHERE l.max_recovery_id = inurecovery;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetrecovery;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconsalewithoutsub
   Descripcion    : consulta las ventas sin subsidios.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================
   inuGeLocation    ubicacion geografica
   inuCategori      categoria
   inuSubcacodi     subcategoria
   idtInitialDate   fecha inicial de solicitud de venta
   idtFinalDate     fecha final de solicitud de venta
   inuAddressId     direccion
   inuPackid        solicitud de venta
   inuSubid         subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                          Cambio DAAB_ADDRESS.FSBGETADDRESS_PARSED por PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio DAGE_SUBSCRIBER.FNUGETIDENT_TYPE_ID por PKG_BCCLIENTE.FNUTIPOIDENTIFICACION
                                          Cambio DAGE_SUBSCRIBER.FSBGETIDENTIFICATION por PKG_BCCLIENTE.FSBIDENTIFICACION
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME por PKG_BCCLIENTE.FSBAPELLIDOS
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME por PKG_BCCLIENTE.FSBNOMBRES
                                          Cambio DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   06-12-2013       hjgomez.SAO226118     Se valida que el concepto aplique al subsidio
   28/10/2013       jrobayo.SAO221447     1- Se modifica para retornar id y la descripcion
                                             del tipo de documento del cliente.
                                          2- Se modifica la consulta para mostrar la informacion
                                             del USER_ID quien registra la solicitud.
                                          3- Se modifica la consulta para traer el nombre del
                                             asesor registrado en la solicitud de venta.
                                          4- Se modifica para consultar las ventas de gas
                                             en estado registrado y atendido.
                                          5- Se modifica para filtrar los resultados de la consulta
                                             con relacion a las poblaciones parametrizadas para
                                             aplicar el descuento por subsidio.
   29/08/2013       hvera.SAO213586       Se retorna la identificacion del cliente en
                                          lugar de retornar el codigo del mismo.
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfconsalewithoutsub return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

    nuPackage_id     ge_boInstanceControl.stysbValue;
    nuGeLocation     ge_boInstanceControl.stysbValue;
    nuCategori       ge_boInstanceControl.stysbValue;
    nuSubcacodi      ge_boInstanceControl.stysbValue;
    nuAddressId      ge_boInstanceControl.stysbValue;
    dtInitialDate    ld_deal.initial_date%type;
    dtFinalDate      ld_deal.final_date%type;
    nuSubid          ge_boInstanceControl.stysbValue;
    nuinstall_motive ld_parameter.numeric_value%type; 
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfconsalewithoutsub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*obtener los valores ingresados en la aplicacion PB LDRDS*/
    nuPackage_id  := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY','PACKAGE_ID');
    nuGeLocation  := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','GEOGRA_LOCATION_ID');
    nuCategori    := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','SUCACATE');
    nuSubcacodi   := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','SUCACODI');
    nuAddressId   := ge_boInstanceControl.fsbGetFieldValue('MO_ADDRESS','PARSER_ADDRESS_ID');
    dtInitialDate := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_DEAL','INITIAL_DATE'));
    dtFinalDate   := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_DEAL', 'FINAL_DATE') );
    nuSubid       := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','SUBSIDY_ID');

    /*Obtener el identificador del motivo de instalacion de producto*/
    nuinstall_motive := pkg_bcld_parameter.fnuobtienevalornumerico('INSTALATION_MOTIVE');


    
    if dtFinalDate < dtInitialDate  then
      sbError := 'La fecha final de registro de la venta no puede ser menor a la fecha inicial de registro de la venta';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);                     
      Raise pkg_error.controlled_error;
    end if;

    OPEN rfcursor FOR
      SELECT
            /*+ leading(m)
                index(m IDX_MO_PACKAGES_015)
                index(a IDX_MO_MOTIVE_02)
                index(cargos IX_CARGOS04)
                index(ld_subsidy_detail UDK_SUBDET01)
                index(l PK_LD_UBICATION)
                index(ld_subsidy PK_LD_SUBSIDY)
            */
             unique (m.package_id) "Numero de solicitud",
             a.subscription_id "Numero de contrato",
             m.DOCUMENT_KEY "Numero de formulario de venta",
             pkg_bccliente.fnutipoidentificacion(m.SUBSCRIBER_ID) ||
             ' - ' || dage_identifica_type.fsbgetdescription(pkg_bccliente.fnutipoidentificacion(m.SUBSCRIBER_ID),
                                                             null) "Tipo identificacion cliente",
             --
             pkg_bccliente.fsbidentificacion(m.SUBSCRIBER_ID) "Identificacion del cliente",
             --
             pkg_bccliente.fsbnombres(m.SUBSCRIBER_ID) || '  ' ||
             pkg_bccliente.fsbapellidos(m.SUBSCRIBER_ID) "Nombre y apellidos del cliente",
             --
             (case
               when Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) is null then
                null
               else
                Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) || ' - ' ||
                dacategori.fsbgetcatedesc(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id))
             end) "Uso del servicio",
             --
             (case
               when Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) is null or
                    Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id) is null then
                null
               else
                Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id) || ' - ' ||
                Ld_BcSubsidy.Fsbgetsucadesc(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                                            Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),
                                            null)
             end) Estrato,
             --
             (case
               when pkg_bcdirecciones.fnugetlocalidad(m.address_id) is null then
                null
               else
                pkg_bcdirecciones.fnugetlocalidad(m.address_id) || ' - ' ||
                pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetlocalidad(m.address_id))
             end) "Ubicacion geografica",
             --
             pkg_bcdirecciones.fsbgetdireccionparseada(m.address_id) "Direccion de instalacion",
             --
             ld_bosubsidy.fnugetphonesclient(m.SUBSCRIBER_ID) "Telefonos de contacto",
             --
             m.user_id "Usuario que registra la venta",
             --
             m.request_date "Fecha de registro de la venta",
             --
             dage_person.fsbGetName_(m.person_id,null) "Asesor comercial",
             --
             ld_bcsubsidy.fsbgetcommercialplan(m.package_id) "Plan comercial",
             --
             daps_motive_status.fsbGetDescription(m.motive_status_id, null) "Estado de la solicitud"
             --
        FROM mo_packages m, mo_motive a, cargos, ld_subsidy_detail, ld_ubication l, ld_subsidy
       WHERE --Rango de fecha de registro de la solicitud
             m.request_date >= dtInitialDate
         AND m.request_date < dtFinalDate
         AND m.tag_name in (Ld_Boconstans.csbresidentialsale, Ld_Boconstans.csbquotesale)
         -- solicitud de venta
         AND m.package_id = nvl(nuPackage_id,m.package_id)
         -- Estados de solicitud validos para aplicar el subsidio retroactivo
         AND m.motive_status_id in(13,14)
         AND a.package_id = m.package_id
         AND a.motive_type_id = nuinstall_motive
         AND cargos.cargnuse = a.product_id
         AND ld_subsidy_detail.conccodi = cargos.cargconc
         AND l.ubication_id = ld_subsidy_detail.ubication_id
         -- ubicacion geografica
         AND nvl(pkg_bcdirecciones.fnugetlocalidad(m.address_id), ld_boconstans.cnuonenumber) =
             nvl(nuGeLocation, nvl(pkg_bcdirecciones.fnugetlocalidad(m.address_id), ld_boconstans.cnuonenumber))
         --uso (categoria)
         AND nvl(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                 ld_boconstans.cnuonenumber) =
             nvl(nuCategori,nvl(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                        ld_boconstans.cnuonenumber))
         -- estrato (subcategoria)
         AND nvl(Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),ld_boconstans.cnuonenumber) =
             nvl(nuSubcacodi,nvl(Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),ld_boconstans.cnuonenumber))
         -- Direccion
         AND nvl(m.address_id, ld_boconstans.cnuonenumber) =
             nvl(nuAddressId, nvl(m.address_id, ld_boconstans.cnuonenumber))
         -- Subsidio
         AND l.subsidy_id = nvl(nuSubid,l.subsidy_id)
         AND ld_subsidy.subsidy_id = l.subsidy_id
         -- se valida que no tenga subsidios asignados
         AND Ld_Bcsubsidy.Fnuuserwithsubsamedeal(ld_subsidy.deal_id, a.subscription_id) =0
         -- Ubicacion geografica, Categoria y subcategoria se encuentren en las poblaciones a las cuales aplica el subsidio
         AND l.geogra_location_id = pkg_bcdirecciones.fnugetlocalidad(m.address_id)
         AND l.sucacate = Ld_Bosubsidy.fnugetcategorybypackages(m.package_id)
         AND l.sucacodi = Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id);

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfcursor);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfconsalewithoutsub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconsultsubtomove
   Descripcion    : consulta los subsidios para ser trasladados.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio GE_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.SETERRORMESSAGE
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   28/08/2013       hvera.SAO213582       Se modifica para no permitir el traslado
                                          de subsidios en estado reversado y pagado
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfconsultsubtomove return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

    nuSusccdoi          ge_boInstanceControl.stysbValue;
    nuSubsidyBegin_ID   ge_boInstanceControl.stysbValue;
    dtInitial_Date      ld_subsidy.initial_date%type;
    dtFinal_Date        ld_subsidy.final_date%type;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfconsultsubtomove';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*obtener los valores ingresados en la aplicacion PB LDDEA*/    
    nuSusccdoi          := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY','SUSCCODI');
    nuSubsidyBegin_ID   := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','SUBSIDY_ID');
    dtInitial_Date      := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','INITIAL_DATE'));
    dtFinal_Date        := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','FINAL_DATE') );

    --  Si se ingresa una fecha y la otra no
    if ( dtInitial_Date IS null AND dtFinal_Date IS not null ) OR
       ( dtInitial_Date IS not null AND dtFinal_Date IS null )
    then

        pkg_error.seterrormessage( LD_BOCONSTANS.cnuGENERIC_ERROR,
            'Debe ingresar ambas fechas de la solicitud de venta' );

    end if;

    --  Si no se ingreso contrato y no se ingresaron las fechas
    if ( nuSusccdoi IS null AND dtInitial_Date IS null ) then

        pkg_error.seterrormessage( LD_BOCONSTANS.cnuGENERIC_ERROR,
            'Debe ingresar o el contrato o las fechas de la solicitud de venta' );

    end if;

    pkg_traza.trace( 'Comparando: '||dtInitial_Date||' - '||dtFinal_Date, 3 );
    if dtInitial_Date > dtFinal_Date then     
      sbError := 'La fecha final de la solicitud de venta no puede ser menor a la fecha inicial de la solicitud de venta';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);                     
      Raise pkg_error.controlled_error;
    end if;

    if ( nuSusccdoi is null ) then

      open rfcursor
      for select  /*+ leading( ld_asig_subsidy )
                      index( suscripc PK_SUSCRIPC )
                      index( ge_subscriber PK_GE_SUBSCRIBER ) */
                  a.asig_subsidy_id "Codigo de asignacion",
                  a.susccodi Contrato,
                  c.subscriber_Name || ' ' || c.subs_Last_Name Nombre,
                  a.subsidy_value "Vlr. Subsidio"
          FROM    ld_asig_subsidy a, suscripc s, ge_subscriber c
          WHERE   a.susccodi = s.susccodi
          AND     s.suscclie = c.subscriber_id
          AND     a.subsidy_id = nuSubsidyBegin_ID
          AND     a.state_subsidy not in (Ld_Boconstans.cnuSubreverstate, Ld_Boconstans.cnuSubpaystate)
          AND     trunc(a.insert_date) between dtinitial_date AND dtfinal_date;

    else

      open rfcursor
      for select  /*+ leading( ld_asig_subsidy )
                      index( ld_asig_subsidy UDX_LD_ASIG_SUBS01 )
                      index( suscripc PK_SUSCRIPC )
                      index( ge_subscriber PK_GE_SUBSCRIBER ) */
                  a.asig_subsidy_id "Codigo de asignacion",
                  a.susccodi Contrato,
                  c.subscriber_Name || ' ' || c.subs_Last_Name Nombre,
                  a.subsidy_value "Vlr. Subsidio"
          FROM    ld_asig_subsidy a, suscripc s, ge_subscriber c
          WHERE   a.susccodi = s.susccodi
          AND     s.suscclie = c.subscriber_id
          AND     a.susccodi = nuSusccdoi
          AND     a.subsidy_id = nuSubsidyBegin_ID
          AND     a.state_subsidy not in (Ld_Boconstans.cnuSubreverstate, Ld_Boconstans.cnuSubpaystate)
          AND     trunc(a.insert_date) between
                  nvl( dtinitial_date, trunc(a.insert_date) )
                  AND nvl( dtfinal_date, trunc(a.insert_date) );

    end if;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfcursor);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfconsultsubtomove;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubasig
   Descripcion    : obtiene el subsidio de una promocion.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================
   inupromo         promocion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetpromsubsidy(inupromo cc_promotion.promotion_id%type,
                             inuRaiseError  in number default 1
                            ) return number is

    nusubsidy ld_subsidy.subsidy_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetpromsubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT l.subsidy_id
      INTO nusubsidy
      FROM ld_subsidy l
     WHERE l.promotion_id = inupromo;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nusubsidy);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetpromsubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubasig
   Descripcion    : obtener la cantidad repartida de un subsidio.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================
   inusub           identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubasig(inusub ld_subsidy.subsidy_id%type) return number is
    nucont number := Ld_Boconstans.cnuCero;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubasig';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nucont
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusub;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nucont);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetsubasig;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetmotive
   Descripcion    : Obtiene el motivo asociado a una solicitud.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/11/2012

   Parametros       Descripcion
   ============     ===================
   inumo_packages   identificador de la solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetmotive(inumo_packages mo_packages.package_id%type,
                        inuRaiseError  in number default 1)
    return mo_motive.motive_id%type is
    numotive mo_motive.motive_id%type;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetmotive';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT motive_id
      INTO numotive
      FROM mo_motive m
     WHERE m.package_id = inumo_packages
     AND   m.motive_type_id = (Select l.numeric_value from ld_parameter l where l.parameter_id = 'INSTALATION_MOTIVE');

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(numotive);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetmotive;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetpackageaddress
   Descripcion    : Obtiene el identificador de la ubicacion
                    geografica asociada a la direccion de una
                    solicitud

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/11/2012

   Parametros       Descripcion
   ============     ===================
   inumo_packages   identificador de la solicitud
   inumo_motive     motivo asociado a una solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetpackageaddress(inumo_packages mo_packages.package_id%type,
                                inumo_motive   mo_motive.motive_id%type,
                                inuRaiseError  in number default 1)
    return mo_address.address_id%type is
    numo_address mo_address.address_id%type;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetpackageaddress';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT m.address_id
      INTO numo_address
      FROM mo_address m
     WHERE m.package_id = inumo_packages
       AND m.motive_id = inumo_motive;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(numo_address);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetpackageaddress;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procsubscribephones
   Descripcion    : Obtiene los telefonos asociados a un suscriptor

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubscriber    identificador del cliente
   Orfphones        cursor referenciado con los telefonos del
                    cliente

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procsubscribephones(inusubscriber ge_subscriber.subscriber_id%type,
                                Orfphones     out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procsubscribephones';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfphones FOR
      SELECT g.*, rowid
        FROM GE_SUBS_PHONE g
       WHERE g.subscriber_id = inusubscriber;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procsubscribephones;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuexistsubasig
   Descripcion    : Consulta si se han realizado ventas a partir
                    de un subsidio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 28/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   28/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuexistsubasig(inusubsidy ld_subsidy.subsidy_id%type)
    return number is

    nurows number := Ld_Boconstans.cnuCero;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuexistsubasig';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nurows
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusubsidy;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnuexistsubasig;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetlastdateasigsub
   Descripcion    : Obtiene la fecha del ultimo subsidio asignado
                    asociado a un codigo en particular

   Autor          : jonathan alberto consuegra lara
   Fecha          : 29/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   29/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetlastdateasigsub(inusubsidy    ld_subsidy.subsidy_id%type,
                                 inuRaiseError in number default 1)
    return ld_asig_subsidy.insert_date%type is

    dtlastdate ld_asig_subsidy.insert_date%type;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetlastdateasigsub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT max(l.insert_date) insert_date
      INTO dtlastdate
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusubsidy;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(dtlastdate);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetlastdateasigsub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetmaxdaterecovery
   Descripcion    : Obtiene el maximo periodo parametrizado para un
                    tope de cobro de un subsidio

   Autor          : jonathan alberto consuegra lara
   Fecha          : 29/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   29/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetmaxdaterecovery(inusubsidy ld_subsidy.subsidy_id%type,
                                   onuyear    out ld_max_recovery.year%type,
                                   onumonth   out ld_max_recovery.month%type) is

    CURSOR cuperiodos is
      SELECT l.*
        FROM ld_max_recovery l
       WHERE EXISTS (SELECT 1
                FROM ld_ubication a
               WHERE a.ubication_id = l.ubication_id
                 AND a.subsidy_id = inusubsidy)
       ORDER BY l.year desc, l.month desc;

    rccuperiodos cuperiodos%rowtype;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetmaxdaterecovery';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN cuperiodos;
    FETCH cuperiodos
      INTO rccuperiodos;
    CLOSE cuperiodos;

    onuyear := rccuperiodos.year;

    onumonth := rccuperiodos.month;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetmaxdaterecovery;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubinpaystates
   Descripcion    : Determina si existen subsidios en estado
                    POR COBRAR, COBRADO o PAGADO.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 30/11/2012

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   30/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubinpaystates(inusubsidy ld_subsidy.subsidy_id%type)
    return number is

    nurows number := Ld_Boconstans.cnuCero;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubinpaystates';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nurows
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusubsidy
       AND InStr(ld_boconstans.csbsubpaystates,
                 lpad(l.state_subsidy,
                      ld_boconstans.cnutwonumber,
                      ld_boconstans.cnuCero)) > ld_boconstans.cnuCero;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetsubinpaystates;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetubiasig
   Descripcion    : Determina si existen subsidios asignados a una
                    ubicacion determinada

   Autor          : jonathan alberto consuegra lara
   Fecha          : 30/11/2012

   Parametros       Descripcion
   ============     ===================
   inuubication     identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   30/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetubiasig(inuubication ld_ubication.ubication_id%type)
    return number is
    nurows number := Ld_Boconstans.cnuCero;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetubiasig';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nurows
      FROM ld_asig_subsidy l
     WHERE l.ubication_id = inuubication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);
  Exception
    When pkg_error.controlled_error then
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetubiasig;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfcontsubwitoutdoc
   Descripcion    : consulta los subsidios sin docuemntacion entregada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 05/11/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                          Cambio DAAB_ADDRESS.FSBGETADDRESS_PARSED por PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                          Cambio DAMO_PACKAGES.FNUGETPOS_OPER_UNIT_ID por PKG_BCSOLICITUDES.FNUGETPUNTOVENTA
                                          Cambio DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID por PKG_BCUNIDADOPERATIVA.FNUGETCONTRATISTA
                                          Cambio DAOR_OPERATING_UNIT.FSBGETNAME por PKG_BCUNIDADOPERATIVA.FSBGETNOMBRE
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio GE_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.SETERRORMESSAGE
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26-02-2014       mgutierrSAO234187     Se eliminan los hints de la sentencia
   10/10/2013       jrobayo.SAO219616     Se realiza cambio para cargar el id del contratista.
   26/09/2013       jrobayo.SAO217696     Se realizan cambios solicitados en el SAO.
   26/09/2013       jrobayo.SAO217474     Se realizan modificaciones adicionales para consultar en
                                          el PB LDCDE por numero de contrato y por Numero de Lote
   24/09/2013       jrobayo.SAO217474     Se modifica la consulta para visualizar unicamente
                                          las solicitudes de venta subsidiadas
   05/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfcontsubwitoutdoc return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

    nuContractorId      ge_boInstanceControl.stysbValue;
    nuGePerson          ge_boInstanceControl.stysbValue;
    nuDeal              ge_boInstanceControl.stysbValue;
    nuSubsidy           ge_boInstanceControl.stysbValue;
    nuDocumentKey       ge_boInstanceControl.stysbValue;
    dtInitialDate       ld_subsidy.initial_date%type;
    dtFinalDate         ld_subsidy.final_date%type;
    nuSuscCodi          ge_boInstanceControl.stysbValue;
    nuPackageAsso       ge_boInstanceControl.stysbValue;

    cursor cuMaxDate is
      select trunc(max(Insert_date)) from ld_asig_subsidy;

    cursor cuMinDate is
      select trunc(min(Insert_date)) from ld_asig_subsidy;

    nuGasService     number;
    nuPackagesStatus mo_packages.motive_status_id%type;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfcontsubwitoutdoc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);  

    /*obtener los valores ingresados en la aplicacion PB LDCDE*/
    nuContractorId     := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                 'POS_OPER_UNIT_ID');
    nuGePerson          := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                 'PERSON_ID');
    nuDeal              := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                                 'DEAL_ID');
    nuSubsidy           := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                                 'SUBSIDY_ID');
    nuPackageAsso       := ge_boinstancecontrol.fsbgetfieldvalue('MO_PACKAGES',
                                                                   'CUST_CARE_REQUES_NUM');
    nuDocumentKey       := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                 'DOCUMENT_KEY');
    dtInitialDate       := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                                                           'INITIAL_DATE'
                                                                                          )
                                                    );

    dtFinalDate         := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                                                           'FINAL_DATE'
                                                                                          )
                                                    );

    nuSuscCodi          := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC',
                                                                 'SUSCCODI');

    if dtInitialDate > dtFinalDate then
      sbError := 'La fecha final de registro de la venta no puede ser menor a la fecha inicial de registro de la venta';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);               
      Raise pkg_error.controlled_error;
    end if;


    if dtInitialDate is null then
      open cuMinDate;
      fetch cuMinDate
        into dtInitialDate;
      if cuMinDate%notfound then
        dtInitialDate := to_date('01/01/1900', 'dd/mm/yyyy');
      end if;
      close cuMinDate;
    end if;

    if dtFinalDate is null then
      open cuMaxDate;
      fetch cuMaxDate
        into dtFinalDate;
      if cuMaxDate%notfound then
        dtFinalDate := trunc(sysdate);
      end if;
      close cuMaxDate;
    end if;

    nuGasService := ld_boconstans.cnuGasService;

    if nuGasService is null then
      pkg_error.seterrormessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe el parametro de servicio de gas');
      raise pkg_error.controlled_error;
    end if;

    /*Obtener el valor del parametro de solicitud atendida*/
    nuPackagesStatus := pkg_bcld_parameter.fnuobtienevalornumerico('SERVERD_SALE_PACKAGE');

    pkg_traza.trace('nuContractorId '||nuContractorId||' nuGePerson '||nuGePerson||' nuDeal '||nuDeal, 10);
    pkg_traza.trace('nuSubsidy '||nuSubsidy||' nuPackageAsso '||nuPackageAsso||' nuDocumentKey '||nuDocumentKey, 10);
    pkg_traza.trace('dtInitialDate '||dtInitialDate||' dtFinalDate '||dtFinalDate||' nuSuscCodi '||nuSuscCodi, 10);
    pkg_traza.trace('nuGasService '||nuGasService||' nuPackagesStatus '||nuPackagesStatus, 10);

    open rfcursor for
      SELECT  /* Ld_BcSubsidy.Frfcontsubwitoutdoc */
      distinct
                      ld_asig_subsidy.asig_subsidy_id || '-S' "Codigo asignado",
                      --
                      fnuGetPackAsso(mo_packages.package_id) "Lote de registro de venta",
                      --
                      ld_asig_subsidy.SuscCodi "Numero de contrato",
                      --
                      mo_packages.document_key "Numero de formulario de venta",
                      --
                      dage_identifica_type.fsbGetDescription(ge_subscriber.ident_type_id,
                                                             null
                                                            ) "Tipo de identificacion cliente",
                      --
                      ge_subscriber.identification "Identificacion del cliente",
                      --
                     (ge_subscriber.subscriber_name || ' ' ||
                      ge_subscriber.subs_last_name) "Nombres y apellidos cliente",
                      --
                      (case
                        when Ld_Bosubsidy.fnugetcategorybypackages(mo_packages.package_id) is null then
                          null
                        else
                          Ld_Bosubsidy.fnugetcategorybypackages(mo_packages.package_id) || ' - ' ||
                          dacategori.fsbgetcatedesc(Ld_Bosubsidy.fnugetcategorybypackages(mo_packages.package_id)
                                                   )
                      end) "Uso del servicio",
                      --
                      (case
                         when Ld_Bosubsidy.fnugetcategorybypackages(mo_packages.package_id) is null or
                              Ld_Bosubsidy.fnugetsubcategbypackages(mo_packages.package_id) is null then
                           null
                         else
                          Ld_Bosubsidy.fnugetsubcategbypackages(mo_packages.package_id) || ' - ' ||
                          dasubcateg.fsbgetsucadesc(Ld_Bosubsidy.fnugetcategorybypackages(mo_packages.package_id),
                                                    Ld_Bosubsidy.fnugetsubcategbypackages(mo_packages.package_id)
                                                   )
                      end) Estrato,
                      --
                      (case
                         when pkg_bcdirecciones.fnugetlocalidad(mo_packages.address_id) is null then
                           null
                         else
                           pkg_bcdirecciones.fnugetlocalidad(mo_packages.address_id)  || ' - ' ||
                           pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetlocalidad(mo_packages.address_id))
                      end) "Ubicacion geografica",
                      --
                      pkg_bcdirecciones.fsbgetdireccionparseada(mo_packages.address_id) "Direccion de instalacion",
                      --
                      ld_bosubsidy.fnugetphonesclient(ge_subscriber.SUBSCRIBER_ID) "Telefono de contacto",
                      --
                      damo_packages.fsbGetUser_Id(mo_packages.package_id,null) "Usuario que registra la venta",
                      --
                      mo_packages.request_date "Fecha de registro de la venta",
                      --
                      --Se realiza la modificacion para consultar el id + descripcion del contratista
                      dage_contratista.fnuGetId_Contratista(
                      pkg_bcunidadoperativa.fnugetcontratista(mo_packages.pos_oper_unit_id),null)|| ' - '
                      ||dage_contratista.fsbGetNombre_Contratista(
                      pkg_bcunidadoperativa.fnugetcontratista(mo_packages.pos_oper_unit_id),null) Contratista,
                      --
                      pkg_bcunidadoperativa.fsbgetnombre(pkg_bcsolicitudes.fnugetpuntoventa(mo_packages.package_id)) "Punto de venta",
                      --
                      dage_person.fsbGetName_(mo_packages.person_id) Vendedor,
                      --
                      ld_bcsubsidy.fsbgetfinancingplan(mo_packages.package_id) "Plan de financiacion",
                      --
                      ld_bcsubsidy.fsbgetcommercialplan(mo_packages.package_id) "Plan comercial",
                      --
                      ld_bcsubsidy.fsbgetinstalationtype(mo_packages.package_id) "Tipo de instalacion",
                      --
                      ld_bcsubsidy.fnugetsalequotes(mo_packages.package_id) "Numero de cuotas",
                      --
                      ld_asig_subsidy.promotion_id||' - '||dacc_promotion.fsbGetDescription(ld_asig_subsidy.promotion_id) Promocion,
                      --
                      ld_asig_subsidy.subsidy_id||' - '||dald_subsidy.fsbGetDescription(ld_asig_subsidy.subsidy_id) Subsidio,
                      --
                      damo_gas_sale_data.fnuGetTotal_Value(mo_packages.package_id,
                                                           null) "Valor de instalacion",
                      --
                      LD_BOSUBSIDY.Fnugetsalevalue(mo_packages.package_id, null) "Total a pagar por el cliente",
                      --
                      ld_bcsubsidy.fnugetinitialquote(mo_packages.package_id) "Valor de cuota inicial",
                      --
                      ld_asig_subsidy.order_id "Orden control de documentacion"
                      --
        from ld_asig_subsidy, ld_subsidy, mo_packages, ge_subscriber,or_operating_unit
       where ld_asig_subsidy.delivery_doc = ld_boconstans.csbNOFlag

         and ld_asig_subsidy.SuscCodi   = NVL(nuSuscCodi, ld_asig_subsidy.SuscCodi)
         and ld_asig_subsidy.Subsidy_id = NVL(nuSubsidy,ld_asig_subsidy.Subsidy_id)


         and ld_subsidy.deal_id = NVL(nuDeal, ld_subsidy.deal_id)

         AND DECODE(nuPackageAsso, NULL, ld_boconstans.cnuallrows, fnuGetPackAsso(mo_packages.package_id)) = NVL(nuPackageAsso,ld_boconstans.cnuallrows)

         and NVL(mo_packages.document_key, ld_boconstans.cnuallrows) = NVL(nuDocumentKey, NVL(mo_packages.document_key, ld_boconstans.cnuallrows))
         AND mo_packages.pos_oper_unit_id = or_operating_unit.operating_unit_id
         and mo_packages.person_id = NVL(nuGePerson, mo_packages.person_id)
         AND decode(nuContractorId,null, nvl(OR_operating_unit.contractor_id,ld_boconstans.cnuallrows), OR_operating_unit.contractor_id) = nvl(nuContractorId,nvl(OR_operating_unit.contractor_id,ld_boconstans.cnuallrows))
         --
         and mo_packages.subscriber_id   = ge_subscriber.subscriber_id
         and ld_asig_subsidy.subsidy_id  = ld_subsidy.subsidy_id
         and mo_packages.package_id      = ld_asig_subsidy.package_id
         --
         and ld_asig_subsidy.state_subsidy <> ld_boconstans.cnuSubreverstate
         --Validar fechas
         and trunc(mo_packages.request_date) >= trunc(dtInitialDate)
         and trunc(mo_packages.request_date) <  trunc(dtFinalDate + 1);

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfcursor);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfcontsubwitoutdoc;


  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsesunuse
   Descripcion    : Obtiene el el servicio suscrito de GAS asociado
                    a una solicitud de venta

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/12/2012

   Parametros       Descripcion
   ============     ===================
   nususcripc       identificador de la suscripcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsesunuse(inupackages   in mo_packages.package_id%type,--inususcripc   in servsusc.sesususc%type,
                          inuRaiseError in number default 1
                         ) return pr_product.product_id%type is

    nuproduct           pr_product.product_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsesunuse';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Begin
      nuproduct := Mo_bopackages.fnuFindProductId(inupackages);
    Exception
      When others then
        nuproduct := null;
        Return(nuproduct);
    End;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuproduct);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetsesunuse;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfdebtconcept
   Descripcion    : Obtiene un cursor referenciado con la deuda
                    corriente y diferida de un contrato (suscripc)

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/11/2012

   Parametros       Descripcion
   ============     ===================
   inususcripc      identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/11/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfdebtconcept(inususcripc in  suscripc.susccodi%type
                         ) return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfdebtconcept';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Fa_boconceptbalance.getsubsposbaldetail(inususcripc,
                                            rfcursor
                                           );

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfcursor);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfdebtconcept;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconsalewithsub
   Descripcion    : consulta las asignaciones de subsidios.

   Autor          : Evens Herard Gorut
   Fecha          : 16/12/2012

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                          Cambio DAAB_ADDRESS.FSBGETADDRESS_PARSED por PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio DAGE_SUBSCRIBER.FNUGETIDENT_TYPE_ID por PKG_BCCLIENTE.FNUTIPOIDENTIFICACION
                                          Cambio DAGE_SUBSCRIBER.FNUGETSUBSCRIBER_TYPE_ID por PKG_BCCLIENTE.FNUTIPOCLIENTE
                                          Cambio DAGE_SUBSCRIBER.FSBGETIDENTIFICATION por PKG_BCCLIENTE.FSBIDENTIFICACION
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME por PKG_BCCLIENTE.FSBAPELLIDOS
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME por PKG_BCCLIENTE.FSBNOMBRES
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   20/11/2013       jrobayo.SAO223999     Se modifica para traer de forma correcta el tipo de identificacion
                                          y el numero de identificacion del suscriptor.
   27/08/2013       hvera.SAO214461       Se modifica para no cargar los subsidios
                                          que ya se han pagado.

   16/12/2012       eherard.SAO156577     Creacion
  ******************************************************************/
  Function Frfconsalewithsub return constants_per.tyrefcursor is

    rfcursor constants_per.tyrefcursor;

    nuPackage_id  ge_boInstanceControl.stysbValue;
    nuGeLocation  ge_boInstanceControl.stysbValue;
    nuCategori    ge_boInstanceControl.stysbValue;
    nuSubcacodi   ge_boInstanceControl.stysbValue;
    nuSuscripc    ge_boInstanceControl.stysbValue;
    dtInitialDate LD_DEAL.INITIAL_DATE%type;
    dtFinalDate   LD_DEAL.INITIAL_DATE%type;
    nuSubid_id    ge_boInstanceControl.stysbValue;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfconsalewithsub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*obtener los valores ingresados en la aplicacion PB LDRSS Reversion de subsidios*/
    --
    nuPackage_id  := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY',
                                                           'PACKAGE_ID');
    --
    nuGeLocation  := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                           'GEOGRA_LOCATION_ID');
    --
    nuCategori    := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                           'SUCACATE');
    --
    nuSubcacodi   := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                           'SUCACODI');
    --
    nuSuscripc    := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY',
                                                           'SUSCCODI');
    --
    dtInitialDate := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                           'INITIAL_DATE'));
    --
    dtFinalDate   := ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                           'FINAL_DATE'));
    --
    nuSubid_id    := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                           'SUBSIDY_ID');

    if dtInitialDate > dtFinalDate then      
      sbError := 'La fecha final de aplicacion del subsidio no puede ser menor a la fecha inicial de aplicacion del subsidio';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);
      Raise pkg_error.controlled_error;
    end if;


    OPEN rfcursor FOR
      SELECT asig_subsidy_id "No. de Asignacion",
             --
             ld_bosubsidy.fnugetsuscbypackages(m.package_id) "Numero de contrato",
             --
             m.DOCUMENT_KEY "Numero de formulario de venta",
             --
             m.package_id "Numero de solicitud",
             --
             Pkg_Bccliente.Fnutipocliente(m.SUBSCRIBER_ID) ||
             ' - ' || dage_identifica_type.fsbgetdescription(
                pkg_bccliente.fnutipoidentificacion(m.SUBSCRIBER_ID), null) "Tipo identificacion cliente",
             --
             pkg_bccliente.fsbidentificacion(m.SUBSCRIBER_ID) "Identificacion del cliente",
             --
             pkg_bccliente.fsbnombres(m.SUBSCRIBER_ID) || '  ' ||
             pkg_bccliente.fsbapellidos(m.SUBSCRIBER_ID) "Nombre y apellidos del cliente",
             --
             (case
                when Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) is null then
                  null
                else
                  Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) || ' - ' ||
                  dacategori.fsbgetcatedesc(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id)
                                           )
             end) "Uso del servicio",
             --
             (case
               when Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) is null or
                    Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id) is null then
                 null
               else
                Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id) || ' - ' ||
                dasubcateg.fsbgetsucadesc(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                                          Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id)
                                         )
             end) Estrato,
             --
             (case
               when pkg_bcdirecciones.fnugetlocalidad(m.address_id) is null then
                 null
               else
                 pkg_bcdirecciones.fnugetlocalidad(m.address_id)  || ' - ' ||
                 pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetlocalidad(m.address_id))
             end) "Ubicacion geografica",
             --
             pkg_bcdirecciones.fsbgetdireccionparseada(m.address_id) "Direccion de instalacion"
             --

        FROM Ld_Asig_Subsidy s, mo_packages m
       WHERE m.package_id = s.package_id
            /*Contrato*/
         AND s.susccodi = nvl(nuSuscripc, s.susccodi)
            /*Solicitud de venta*/
         AND s.package_id = nvl(nuPackage_id, s.package_id)
            /*Subsidio*/
         AND s.subsidy_id = nvl(nuSubid_id, s.subsidy_id)
            /*Ubicacion geografica*/
         AND nvl(pkg_bcdirecciones.fnugetlocalidad(m.address_id),
                 ld_boconstans.cnuonenumber
                ) = nvl(nuGeLocation,
                        nvl(pkg_bcdirecciones.fnugetlocalidad(m.address_id),
                               ld_boconstans.cnuonenumber))
         /*Uso (categoria)*/
         AND nvl(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id), ld_boconstans.cnuonenumber)
                = nvl(nuCategori,nvl(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                               ld_boconstans.cnuonenumber))
         /*Estrato (subcategoria)*/
         AND nvl(Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),
                 ld_boconstans.cnuonenumber
                ) = nvl(nuSubcacodi, nvl(Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),
                               ld_boconstans.cnuonenumber ))
         /*Rango de fecha de registro de la asignacion del subsidio a ld_asig_subsidy*/
         AND trunc(s.insert_date) >= dtInitialDate
         AND trunc(s.insert_date) <  dtFinalDate + 1
         AND s.state_subsidy not in (Ld_Boconstans.cnuSubreverstate, Ld_Boconstans.cnuSubpaystate)
       ORDER BY asig_subsidy_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfcursor);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfconsalewithsub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnubilluser
   Descripcion    : Determina si un cliente ha sido facturado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/12/2012

   Parametros       Descripcion
   ============     ===================
   inunuse          identificador del producto(servicio suscrito)
   inuRaiseError    controla error no_data_found


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnubilluser(inunuse       servsusc.sesunuse%type,
                       inuRaiseError in number default 1) return number is
    nurow number;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnubilluser';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1) INTO nurow FROM cuencobr c WHERE c.cuconuse = inunuse;

    Return(nurow);

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnubilluser;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procsubswithdocok
   Descripcion    : Obtiene los subsidios de un suscriptor
                    con documentacion entregada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/12/2012

   Parametros       Descripcion
   ============     ===================
   inususccodi      identificador del contrato
   Orfsubsidies     cursor referenciado con los subsidios con
                    documentacion entregada de un suscriptor.

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procsubswithdocok(inususccodi  suscripc.susccodi%type,
                              Orfsubsidies out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procsubswithdocok';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfsubsidies FOR
      SELECT l.*, rowid
        FROM ld_asig_subsidy l
       WHERE l.susccodi = inususccodi
         AND nvl(l.delivery_doc, ld_boconstans.csbNOFlag) =
             ld_boconstans.csbapackagedocok;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procsubswithdocok;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetidsalewithoutsub
   Descripcion    : Obtiene el id de una venta no subsidiada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/12/2012

   Parametros       Descripcion
   ============     ===================
   inupackageid     identificador de la solicitud de venta

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   21/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetidsalewithoutsub(inupackageid  mo_packages.package_id%type,
                                  inuRaiseError in number default 1)
    return ld_sales_withoutsubsidy.sales_withoutsubsidy_id%type is

    nuid ld_sales_withoutsubsidy.sales_withoutsubsidy_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetidsalewithoutsub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT l.sales_withoutsubsidy_id
      INTO nuid
      FROM ld_sales_withoutsubsidy l
     WHERE l.package_id = inupackageid;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuid);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetidsalewithoutsub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Procgetsubsidies
   Descripcion    : Obtiene los subsidios parametrizados

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/12/2012

   Parametros       Descripcion
   ============     ===================
   inupackageid     identificador de la solicitud de venta

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
                                          
   21/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure Procgetsubsidies(Orfsubsidies out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Procgetsubsidies';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfsubsidies FOR
      SELECT l.*, rowid FROM ld_subsidy l ORDER BY l.subsidy_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Procgetsubsidies;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuTotalSubsidyByState
  Descripcion    : Retorna en un cursor referenciado las trasnferencias asociadas al
                   contrato(recibido o cedido).

  Autor          : Evens Herard Gorut.
  Fecha          : 24/10/2012

  Parametros             Descripcion
  ============           ===================
  inuSubsidy             Identificador del subsidio
  inustatecheked         Estado del subsidio asignado


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                         Se aplican pautas técnicas
                                         Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                         Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
  ******************************************************************/
  FUNCTION FnuTotalSubsidyByState(inuSubsidy     in ld_asig_subsidy.subsidy_id%type,
                                  inustatecheked in ld_asig_subsidy.state_subsidy%type)
    return number is

    nucantidad number := 0;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuTotalSubsidyByState';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
    
    SELECT count(sy.subsidy_id)
      INTO nucantidad
      FROM ld_subsidy sy, ld_asig_subsidy ass
     WHERE sy.subsidy_id = inuSubsidy
       AND sy.subsidy_id = ass.subsidy_id
       AND ass.state_subsidy = inustatecheked;
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nucantidad);

  EXCEPTION
    when pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END FnuTotalSubsidyByState;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuTotalSales
    Descripcion    : Cantidad de solicitudes de subsidio de venta

    Autor          : Evens Herard Gorut.
    Fecha          : 20/12/2012

    Parametros             Descripcion
    ============           ===================
    inuSubsidy             Identificador del subsidio


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    26/03/2024       pacosta              OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
  ******************************************************************/
 FUNCTION FnuTotalSales(inuSubsidy in ld_asig_subsidy.subsidy_id%type)
    return number is

    nucantidad number := 0;

    CURSOR cuSubsidy(inuSubsidyId in ld_asig_subsidy.subsidy_id%type) IS
    SELECT count(1)
    FROM ld_asig_subsidy s, mo_packages m
    WHERE s.package_id = m.package_id
    AND s.subsidy_id = inuSubsidyId
    AND s.STATE_SUBSIDY != 5
    AND m.motive_status_id in (13,14);
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuTotalSales';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
    if cuSubsidy%isopen then
        close cuSubsidy;
    END if;

    open cuSubsidy(inuSubsidy);
        fetch cuSubsidy INTO nuCantidad;
    close cuSubsidy;
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    
    Return(nucantidad);

  EXCEPTION
    when pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END FnuTotalSales;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetTotalSalesByStateBySub 
    Descripcion    : 

    Autor          : 
    Fecha          : 

    Parametros                      Descripcion
    ============                    ===================               


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    26/03/2024       pacosta              OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas                                          
  ******************************************************************/
  FUNCTION fnugetTotalSalesByStateBySub(inuSubsidy in ld_asig_subsidy.subsidy_id%type,
                                            inuPackState in mo_packages.motive_status_id%type) return number IS

        nuCantidad number := 0;

        CURSOR cuSubsidyByState(inuSubsidyId in ld_asig_subsidy.subsidy_id%type,
                            inuPackStateId in mo_packages.motive_status_id%type) IS
        SELECT count(1)
        FROM ld_asig_subsidy s, mo_packages m
        WHERE s.package_id = m.package_id
        AND s.subsidy_id = inuSubsidyId
        AND m.motive_status_id = inuPackStateId
        AND s.state_subsidy != 5;
        
        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnugetTotalSalesByStateBySub';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        if cuSubsidyByState%isopen then
            close cuSubsidyByState;
        END if;

        open cuSubsidyByState(inuSubsidy,inuPackState);
            fetch cuSubsidyByState INTO nuCantidad;
        close cuSubsidyByState;
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        Return(nucantidad);
    EXCEPTION
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
    END fnugetTotalSalesByStateBySub;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuTotalSalesByState
    Descripcion    : Cantidad de solicitudes de subsidio de venta por estados
                     En ejecucion, Ejecutada y Anulada

    Autor          : Evens Herard Gorut.
    Fecha          : 20/12/2012

    Parametros             Descripcion
    ============           ===================
    inuOrderState          Estado de la orden


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    26/03/2024       pacosta              OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
  ******************************************************************/
  FUNCTION FnuTotalSalesByState(inuOrderState in or_order.order_status_id%type)
    return number is

    nucantidad number := 0;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuTotalSalesByState';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
    
    SELECT /*+ USE_NL(ord ass) */
     count(ord.order_id)
      INTO nucantidad
      FROM or_order ord, ld_asig_subsidy ass
     WHERE ord.order_id = ass.order_id
       AND ord.order_status_id = inuOrderState;
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nucantidad);

  EXCEPTION
    when pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END FnuTotalSalesByState;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfsubrem
   Descripcion    : Obtiene los subsidios vencidos con remanente.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 24/12/2012

   Parametros       Descripcion
   ============     ===================
   Orfsubsidies     Subsidios remanentes

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   24/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfsubrem return constants_per.tyrefcursor is

    rfsubsidies      constants_per.tyrefcursor;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfsubrem';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    ld_bosubsidy.globaltransfersub := 'Y';

    OPEN rfsubsidies FOR
      SELECT l.subsidy_id subsidio,
             l.description descripcion,
             l.deal_id convenio,
             dald_deal.fsbGetDescription(l.deal_id) deal_descripcion,
             l.REMAINDER_STATUS estado_remanente,
             nvl(l.total_available, l.authorize_value)-(
                 select nvl(sum(delivery_total),0)
                 FROM ld_sub_remain_deliv r
                 WHERE r.subsidy_id = l.subsidy_id
                 AND state_delivery = 'D') remanente,
             l.authorize_value autorizado
        FROM ld_subsidy l
       WHERE l.final_date < sysdate
         AND l.authorize_value is not null
         AND nvl(l.total_available, l.authorize_value) > ld_boconstans.cnuCero_Value
         AND l.REMAINDER_STATUS not in ('CE','DI');

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfsubsidies);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfsubrem;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfconcrem
   Descripcion    : Obtiene los conceptos a subsidiar por remanente.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 24/12/2012

   Parametros       Descripcion
   ============     ===================
   inusub           Identificador del subsidio
   Orfconcsub       Conceptos a subsidiar

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   24/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Frfconcrem(inuubi ld_ubication.ubication_id%type
                     ) return constants_per.tyrefcursor is

    rfconcsub constants_per.tyrefcursor;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfconcrem';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN rfconcsub FOR
      SELECT l.conccodi concepto,
             pktblconcepto.fsbGetConcdesc(l.conccodi, null) descripcion
        FROM ld_subsidy_detail l
       WHERE l.ubication_id = inuubi
       ORDER BY l.conccodi;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfconcsub);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfconcrem;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuuserwithsubsidy
   Descripcion    : Determina si un usuario tiene asignado un
                    subsidio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 03/01/2013

   Parametros       Descripcion
   ============     ===================
   inusub           Identificador del subsidio
   Orfconcsub       Conceptos a subsidiar

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   03/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuuserwithsubsidy(inusub     ld_subsidy.subsidy_id%type,
                              inususc    suscripc.susccodi%type,
                              inupackage mo_packages.package_id%type)
    return number is

    nuanswer number := 0;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuuserwithsubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nuanswer
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusub
       AND l.susccodi = inususc
       AND l.package_id = inupackage;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuanswer);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnuuserwithsubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ProcgetubiconcforPI
   Descripcion    : Obtiene la informacion de los conceptos
                    subsidiados para una poblacion, para
                    visualizarlos en un PI.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 26/10/2012

   Parametros       Descripcion
   ============     ===================
   inuDeal          identificador del convenio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   26/10/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Procedure ProcgetubiconcforPI(inuUbication ld_ubication.ubication_id%type,
                                Orfconcepto  out constants_per.tyrefcursor) is
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'ProcgetubiconcforPI';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN Orfconcepto FOR
      SELECT l.subsidy_detail_id,
             l.conccodi||' - '||pktblconcepto.fsbGetConcdesc(l.conccodi, null) concepto,
             l.subsidy_percentage,
             l.subsidy_value,
             l.ubication_id
        FROM ld_subsidy_detail l
       WHERE l.ubication_id = inuUbication
       ORDER BY l.subsidy_detail_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End ProcgetubiconcforPI;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetPackageSalesContract
   Descripcion    : Obtener el PACKAGE_ID asociado al contrato con
                    una venta

   Autor          : Jorge valiente
   Fecha          : 09/01/2013

   Parametros       Descripcion
   ============     ===================
   inususccodi      condigo del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
  ******************************************************************/
  Function FnuGetPackageSalesContract(inususccodi suscripc.susccodi%type)
    return mo_packages.package_id%type is

    cursor cuPackages is
      select distinct package_id
        from mo_packages
       WHERE tag_name in
             (Ld_Boconstans.csbresidentialsale, Ld_Boconstans.csbquotesale)
         and subscriber_id =
             (select suscclie from suscripc where susccodi = inususccodi);

    nupackage_id mo_packages.package_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetPackageSalesContract';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nupackage_id := null;

    open cuPackages;
    fetch cuPackages
      into nupackage_id;
    if cuPackages%notfound then
      nupackage_id := null;
    end if;
    close cuPackages;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nupackage_id);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      Return(nupackage_id);
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      Return(nupackage_id);
  End FnuGetPackageSalesContract;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubtotaldelivery
   Descripcion    : Obtiene el total asignado de un subsidio

   Autor          : jonathan alberto consuegra lara
   Fecha          : 11/01/2013

   Parametros       Descripcion
   ============     ===================
   inususccodi      condigo del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   11/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubtotaldelivery(inusubsidy ld_subsidy.subsidy_id%type)
    return ld_subsidy.total_deliver%type is

    nutotdelivery ld_subsidy.total_deliver%type := 0;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubtotaldelivery';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT SUM(nvl(l.subsidy_value, ld_boconstans.cnuCero_Value))
    INTO   nutotdelivery
    FROM   ld_asig_subsidy l
    WHERE  l.subsidy_id = inusubsidy
    AND    l.state_subsidy <> ld_boconstans.cnuSubreverstate;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nutotdelivery);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetsubtotaldelivery;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FNuGetAmountAsigSubsidy
   Descripcion    : Obtiene el total clientes subsidiados sin
                    conexion o instalacion del servicio de Gas en
                    una poblacion

   Autor          : Jorge luis Valiente Moreno
   Fecha          : 14/01/2013

   Parametros       Descripcion
   ============     ===================
   inuAsigSubsidyId       Cadena de subsidio
   inuUbicationId         Poblacion del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
  ******************************************************************/
  Function FNuAmountAsigSubsidy(inuAsigSubsidyId in ld_asig_subsidy.Asig_Subsidy_Id%type,
                                inuUbicationId   in ld_asig_subsidy.ubication_id%type)
    return number is

    cursor cuAmountAsigSubsidy is
      select Count(Susccodi) Amount
        from Ld_Asig_Subsidy
       where exists (select 1
                     from servsusc a
                     where a.sesususc = Ld_Asig_Subsidy.susccodi
                     and a.sesuserv   = ld_boconstans.cnuGasService
                    )
       and Ld_Asig_Subsidy.Subsidy_Id   = inuAsigSubsidyId
       and ld_asig_subsidy.ubication_id = inuUbicationId
       and Susccodi <> -1;

    nuAmountAsigSubsidy number := 0;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FNuAmountAsigSubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    open cuAmountAsigSubsidy;
    fetch cuAmountAsigSubsidy
      into nuAmountAsigSubsidy;
    close cuAmountAsigSubsidy;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuAmountAsigSubsidy);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      Return(nuAmountAsigSubsidy);
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      Return(nuAmountAsigSubsidy);
  End FNuAmountAsigSubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetintallationorder
   Descripcion    : Obtiene el numero de la orden de instalacion
                    del producto GAS.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 22/01/2013

   Parametros       Descripcion
   ============     ===================
   inususcodi       identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio OR_BOCONSTANTS.CNUORDER_STAT_CLOSED por PKG_GESTIONORDENES.CNUORDENCERRADA
                                          Cambio PKTBLSUSCRIPC.FNUGETSUSCCLIE por PKG_BCCONTRATO.FNUIDCLIENTE
   22/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetintallationorder(inususcodi  suscripc.susccodi%type,
                                  inuRaiseError in number default 1
                                 ) return  or_order.order_id%type is

    nuOrder or_order.order_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetintallationorder';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Verificar la orden legalizada del tipo de actividad de Instalacion de Servicio de GAS*/
    SELECT /*+ USE_NL(oa o) */ oa.order_id
    INTO   nuOrder
    FROM   or_order_activity oa, or_order o
    WHERE  oa.Task_Type_Id    = ld_boconstans.cnuorderlegalizetasktype
    AND    oa.activity_id     = ld_boconstans.cnuorderlegalizeactivity
    AND    oa.subscription_id = inususcodi
    AND    oa.subscriber_id   = pkg_bccontrato.fnuidcliente(inususcodi)
    AND    o.legalization_date  is not null
    AND    o.order_id         = oa.order_id
    AND    o.subscriber_id    = oa.subscriber_id
    AND    o.order_status_id  = pkg_gestionordenes.cnuordencerrada;
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    
    Return nuOrder;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetintallationorder;

   /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : proProcesaArchivoPlano
   Descripcion    : proceso quellena tabla temporal LDC_INFOCISU

   Autor          : Elkin alvarez/horbath
   Fecha          : 24/08/2018

   Parametros       Descripcion
   ============     ===================
    isbNombreArch     nombre del archivo plano

    onuOk             salida 0 sin error -1 con error
    osbMensaje        mensaje de errro
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DALD_PARAMETER.FSBGETVALUE_CHAIN por PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UTL_FILE.FCLOSE por PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF
                                          Cambio UTL_FILE.FILE_TYPE por PKG_GESTIONARCHIVOS.STYARCHIVO
                                          Cambio UTL_FILE.FOPEN	por PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF
                                          Cambio UTL_FILE.GET_LINE por PKG_GESTIONARCHIVOS.FSBOBTENERLINEA_SMF  
   24/08/2018       ELAL                  TICKET 200-2068 Creacion
  ******************************************************************/
    PROCEDURE proProcesaArchivoPlano(isbNombreArch  IN VARCHAR2,
                                     onuOk          OUT NUMBER,
                                     osbMensaje     OUT VARCHAR2) IS
    
        vfile                  pkg_gestionarchivos.styarchivo;
        cadena                 VARCHAR2(10000);
        nulineaarch    NUMBER:=0;
        sbruradirectorio VARCHAR2(400) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_RUTAARCPLA');
        CURSOR cuPathDire IS
        SELECT di.path
        FROM open.ge_directory di
        WHERE di.ALIAS = 'XML_DIR';
        
        sbCadenaAux VARCHAR2(4000);
        
        nuContrato NUMBER;
        nuProducto NUMBER;
        nuSubsidio NUMBER;
        nuSolicitud NUMBER;
        
        nuTamAnio NUMBER;
        nuIndex  NUMBER;
        
        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'proProcesaArchivoPlano';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
  
        DELETE FROM LDC_INFOCISU;
        COMMIT;

        BEGIN
            vfile            := pkg_gestionarchivos.ftabrirarchivo_smf(sbruradirectorio,isbNombreArch,'R');--TICKET 2002068 ELAL -- se abre archivo plano
        EXCEPTION
            WHEN OTHERS THEN        
                sbError := 'Error al tratar de leer el archivo ['||isbNombreArch||'] en la ruta ['||sbruradirectorio||'] por favor valide que exista o tenga los permisos adecuados';
                nuError := gcnuerrorcode;
                pkg_error.seterror;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
                pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
                raise pkg_error.controlled_error;
        END;
        --TICKET 2002068 ELAL -- se recorre archivo por linea
        LOOP
            cadena := NULL;
            sbCadenaAux := '';
            nuContrato := NULL;
            nuProducto := NULL;
            nuSubsidio  := NULL;
            nuSolicitud  := NULL;
            BEGIN
                -- osbMensaje := 'PASO ACA1';
                cadena:= pkg_gestionarchivos.fsbobtenerlinea_smf(vfile);
                --osbMensaje := 'PASO ACA';
            EXCEPTION
                WHEN no_data_found THEN
                    EXIT;
            END;
        
            cadena := replace(replace(cadena, chr(10),''),chr(13),'');
            nuTamAnio := length(cadena);
            nuIndex := instr(cadena,',');
            sbCadenaAux := substr(cadena,nuIndex+1, nuTamAnio);
            
            nuContrato :=  TO_NUMBER(substr(cadena, 1, nuIndex - 1 ));
            
            nuIndex := instr(sbCadenaAux,',');
            nuProducto := TO_NUMBER(substr(sbCadenaAux, 1, nuIndex - 1 ));
            
            sbCadenaAux := substr(sbCadenaAux,nuIndex+1, nuTamAnio);
            
            nuIndex := instr(sbCadenaAux,',');
            nuSubsidio := TO_NUMBER(substr(sbCadenaAux, 1, nuIndex - 1 ));
            
            sbCadenaAux := substr(sbCadenaAux,nuIndex+1, length(sbCadenaAux));
            
            nuSolicitud := TO_NUMBER(sbCadenaAux);
        
            BEGIN
                INSERT INTO LDC_INFOCISU
                  (
                    INCICONT,
                    INCIPROD,
                    INCISUBS,
                    INCISOLI
                  )
                  VALUES
                  (
                   nuContrato,
                   nuProducto,
                   nuSubsidio,
                   nuSolicitud
                  );
                   nulineaarch := nulineaarch + 1;
            EXCEPTION
                WHEN OTHERS THEN
                    onuOk := -1;
                    osbMensaje := osbMensaje||'Error a insertar registro '||sqlerrm;
            END;        
        END LOOP;
        -- Fin de archivo
        pkg_gestionarchivos.prccerrararchivo_smf(vfile);

        COMMIT;

        IF onuOk is null or nulineaarch > 0 THEN
            onuOk := 0;
        END IF;
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
            raise pkg_error.controlled_error;
        WHEN OTHERS THEN
            ROLLBACK;
            onuOk := -1;
            osbMensaje := 'Error no controlado en proProcesaArchivoPlano '||osbMensaje||'-'||sqlerrm; 
            pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || osbMensaje, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    END proProcesaArchivoPlano;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : frfconcollectsubsidy
   Descripcion    : Consulta subsidios asignados para hacer cambio
                    de estados.

   Autor          : Evens Herard Gorut
   Fecha          : 09/01/2013

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME por PKG_BCCLIENTE.FSBAPELLIDOS
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME por PKG_BCCLIENTE.FSBNOMBRES
                                          Cambio DAMO_PACKAGES.FNUGETADDRESS_ID por PKG_BCSOLICITUDES.FNUGETDIRECCION
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio PKTBLSUSCRIPC.FNUGETSUSCCLIE por PKG_BCCONTRATO.FNUIDCLIENTE
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23-08-2018       ELAL                  ticket 200-2068 se agrega proceso para llenar archivo plano
                                          nuevos filtros de consultas en el proceso
   08-09-2014       oparra.Team462        visualizar el estado de la solicitud de venta y
                                          el estado del producto, con el fin de poder cambiar
                                          el subsidio asociado
   26-11-2013       hjgomez.SAO224918     Se muestra el convenio
   09/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function Frfconcollectsubsidy return constants_per.tyrefcursor is

    rfcursor           constants_per.tyrefcursor;
    nuSubsidy_Id       ge_boInstanceControl.stysbValue;
    nusubcurrentstate  ge_boInstanceControl.stysbValue;
    nunewstate         ge_boInstanceControl.stysbValue;
    nuRecordCollect    ge_boInstanceControl.stysbValue;

    --TICKET 2002068 ELAL --se agregan nuevos campos para filtros del PB
    sbConvenio         ge_boInstanceControl.stysbValue;
    sbFechaIniReg      ge_boInstanceControl.stysbValue;
    sbFechaFinReg      ge_boInstanceControl.stysbValue;
    sbFechaIniInst     ge_boInstanceControl.stysbValue;
    sbFechaFinInst     ge_boInstanceControl.stysbValue;
    sbContrato         ge_boInstanceControl.stysbValue;
    sbNombreArch        ge_boInstanceControl.stysbValue;
     --TICKET 2002068 ELAL -- se crean variables para almacenar fechas
    dtFechInireg     DATE;
    dtFechFinreg     DATE;
    dtFechIniInst     DATE;
    dtFechFinInst     DATE;
    onuok         NUMBER;
    sbMensaje     VARCHAR2(4000);
     --TICKET 2002068 ELAL -- se valida si existe datos ne el archivo plano
    CURSOR cuExistedatos IS
    SELECT COUNT(*)
    FROM LDC_INFOCISU;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfconcollectsubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*obtener los valores ingresados en la aplicacion PB LDRSS Reversion de subsidios*/
    nuSubsidy_Id        :=  ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY','SUBSIDY_ID');

    nusubcurrentstate   :=  ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY_STATES','SUBSIDY_STATES_ID');

    nunewstate          :=  ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY', 'STATE_SUBSIDY');

    nuRecordCollect     := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY', 'RECORD_COLLECT');

    --TICKET 2002068 ELAL --obtener los valores ingresados en la aplicacion PB
    sbConvenio         := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','DEAL_ID');
    sbFechaIniReg      := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','INITIAL_DATE');
    sbFechaFinReg      := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','FINAL_DATE');
    sbFechaIniInst     := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER','EXEC_INITIAL_DATE');
    sbFechaFinInst     := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER','EXECUTION_FINAL_DATE');
    sbContrato         := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC','SUSCCODI');
    sbNombreArch       := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER_COMMENT','ORDER_COMMENT');

    if (nusubcurrentstate is null) then      
      sbError := 'El estado actual no puede ser nulo';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);
      raise pkg_error.controlled_error;
    end if;
    --TICKET 2002068 ELAL -- se valida que si la fecha inicial no es nula hayan registrado la fecha final
    if (sbFechaIniReg is not null and sbFechaFinReg is null ) then      
      sbError := 'Fecha inicial de  Registro de venta no es nula, por favor diligencia la Fecha Final de registro de venta';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);
      raise pkg_error.controlled_error;
    end if;

    if (sbFechaIniInst is not null and sbFechaFinInst is null ) then
      sbError := 'Fecha inicial de  Instalacion no es nula, por favor diligencia la Fecha Final de Instalacion';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);      
      raise pkg_error.controlled_error;
    end if;

    --TICKET 2002068 ELAL -- se valida que si la fecha final  no es nula hayan registrado la fecha inicial
    if (sbFechaIniReg is  null and sbFechaFinReg is not null ) then 
      sbError := 'Fecha final de  Registro de venta no es nula, por favor diligencia la Fecha inicial de registro de venta';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);
      raise pkg_error.controlled_error;
    end if;

    if (sbFechaIniInst is null and sbFechaFinInst is not null ) then     
      sbError := 'Fecha final de  Instalacion no es nula, por favor diligencia la Fecha inicial de Instalacion';
      nuError := gcnuerrorcode;
      pkg_error.seterror;
      pkg_Error.getError(nuError,sbError);
      raise pkg_error.controlled_error;
    end if;
    --TICKET 2002068 ELAL --se le da formato a las fechas
    IF sbFechaIniReg IS NOT NULL THEN
       dtFechInireg := to_date(TO_CHAR(to_date(sbFechaIniReg,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
       dtFechFinreg := to_date(TO_CHAR(to_date(sbFechaFinReg,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');

       IF dtFechInireg > dtFechFinreg THEN            
           sbError := 'Fecha final de  Registro de venta no  puede ser menor a la fecha inicial';
           nuError := gcnuerrorcode;
           pkg_error.seterror;
           pkg_Error.getError(nuError,sbError);
           raise pkg_error.controlled_error;
       END IF;
    END IF;

    IF sbFechaIniInst IS NOT NULL THEN
       dtFechIniInst := to_date(TO_CHAR(to_date(sbFechaIniInst,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
       dtFechFinInst := to_date(TO_CHAR(to_date(sbFechaFinInst,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');
       IF dtFechIniInst > dtFechFinInst THEN            
           sbError := 'Fecha final de instalacion no  puede ser menor a la fecha inicial';
           nuError := gcnuerrorcode;
           pkg_error.seterror;
           pkg_Error.getError(nuError,sbError);
           raise pkg_error.controlled_error;
       END IF;
    END IF;

    IF sbNombreArch IS NOT NULL THEN
      --TICKET 2002068 ELAL --  se procesa archivo plano
      proProcesaArchivoPlano(sbNombreArch, onuok, sbMensaje );
      IF onuok <> 0 THEN        
        sbError := sbMensaje;
        nuError := gcnuerrorcode;
        pkg_error.seterror;
        pkg_Error.getError(nuError,sbError);
        raise pkg_error.controlled_error;
      END IF;
    END IF;

    --TICKET 2002068 ELAL -- se carga si existen datos
    OPEN cuExistedatos;
    FETCH cuExistedatos INTO onuok;
    CLOSE cuExistedatos;

    -- valida si el estado es igual a 3-COBRADO
    if nunewstate = ld_boconstans.cnucollectstate then

      IF onuok > 0 THEN

           OPEN rfcursor FOR
           SELECT "Codigo de asignacion",
                   SUBSIDIO,
                   "Ubicacion geografica",
                   "Uso del servicio",
                   ESTRATO,
                   CONTRATO,
                   NOMBRE,
                   "Estado Solicitud Venta",
                   "Estado Producto",
                   "Valor subsidio",
                   "No. Acta de cobro",
                   Fecha_instalacion "Fecha de instalacion",
                   "Convenio"
            FROM (
                  SELECT ss.asig_subsidy_id "Codigo de asignacion",
                      --Subsidio
                      ss.subsidy_id ||' - '|| ld_subsidy.description Subsidio,
                      --
                      --Ubicacion geografica
                      (case
                       when pkg_bcdirecciones.fnugetlocalidad(pkg_bcsolicitudes.fnugetdireccion(ss.package_id)) is null then
                         null
                       else
                         pkg_bcdirecciones.fnugetlocalidad(pkg_bcsolicitudes.fnugetdireccion(ss.package_id))  || ' - ' ||
                         pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetlocalidad(pkg_bcsolicitudes.fnugetdireccion(ss.package_id)))
                      end) "Ubicacion geografica",
                      --
                      --Categoria
                      (case
                        when Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id) is null then
                          null
                        else
                          Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id) || ' - ' ||
                          dacategori.fsbgetcatedesc(Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id)
                                                   )
                      end) "Uso del servicio",
                      --
                      --Subcategoria
                      (case
                        when Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id) is null or
                             Ld_Bosubsidy.fnugetsubcategbypackages(ss.package_id) is null then
                          null
                        else
                         Ld_Bosubsidy.fnugetsubcategbypackages(ss.package_id) || ' - ' ||
                         dasubcateg.fsbgetsucadesc(Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id),
                                                   Ld_Bosubsidy.fnugetsubcategbypackages(ss.package_id)
                                                  )
                      end) Estrato,
                     --
                      --
                      --Contrato
                      ss.susccodi Contrato,
                      --
                      --Nombre
                      (
                      pkg_bccliente.fsbnombres(pkg_bccontrato.fnuidcliente(ss.susccodi)) ||'  '||
                      pkg_bccliente.fsbapellidos(pkg_bccontrato.fnuidcliente(ss.susccodi))
                      )Nombre,
                     -- TEAM 462
                     -- Estado de la Venta
                      (select m.description
                       from mo_packages p, ps_motive_status m
                       where p.motive_status_id = m.motive_status_id
                       and p.package_id = ss.package_id) "Estado Solicitud Venta",

                     -- Estado del proudcto
                     (select ps.description
                      from pr_product pr, ps_product_status ps
                      where pr.product_status_id = ps.product_status_id
                      and pr.product_id = se.sesunuse) "Estado Producto",

                     --Valor del subsidio
                     ss.subsidy_value "Valor subsidio",

                     --Acta de cobro
                     ss.record_collect "No. Acta de cobro",

                     --Fecha de instalacion
                     ld_bosubsidy.fdtgetInstallDate(ss.susccodi,
                                                    null
                                                   ) Fecha_instalacion,
                     --Convenio
                     ld_deal.deal_id || ' - ' || ld_deal.description "Convenio",
                     (SELECT  p.REQUEST_DATE
                       FROM mo_packages p
                       WHERE p.package_id = ss.package_id ) fecha_registro

                FROM ld_asig_subsidy ss, servsusc se, ld_subsidy, ld_deal, LDC_INFOCISU ipl
                WHERE ss.susccodi      = se.sesususc
                AND   ld_subsidy.subsidy_id = ss.subsidy_id
                AND   ld_subsidy.deal_id =  ld_deal.deal_id
                AND   se.sesuserv      = ld_boconstans.cnuGasService
                  --TICKET 2002068 ELAL-- filtros de archivo plano
                AND   ipl.INCICONT  = ss.susccodi
                AND   ipl.INCIPROD  = se.sesunuse
                AND   ipl.INCISUBS  = ss.subsidy_id
                AND  ipl.INCISOLI  = ss.package_id
                --Subsidio
                AND   ss.subsidy_id    = nvl(nuSubsidy_id, ss.subsidy_id)
                --Estado del subsidio
                AND   ss.state_subsidy = nusubcurrentstate
                --Servicio suscrito
                AND   se.sesunuse = ld_bcsubsidy.Fnugetsesunuse(ss.package_id, null)
                --TICKET 2002068 ELAL-- Se agregan nuevos filtros
                AND   ld_subsidy.deal_id = nvl(sbConvenio, ld_subsidy.deal_id)
                AND   ss.susccodi  = NVL(sbContrato, ss.susccodi))
          WHERE fecha_registro BETWEEN nvl(dtFechInireg, fecha_registro) AND nvl(dtFechFinreg, fecha_registro)
             AND nvl(Fecha_instalacion,sysdate) BETWEEN nvl(dtFechIniInst, nvl(Fecha_instalacion,sysdate)) AND nvl(dtFechFinInst, nvl(Fecha_instalacion,sysdate));
      ELSE

          OPEN rfcursor FOR
          SELECT "Codigo de asignacion",
                   SUBSIDIO,
                   "Ubicacion geografica",
                   "Uso del servicio",
                   ESTRATO,
                   CONTRATO,
                   NOMBRE,
                   "Estado Solicitud Venta",
                   "Estado Producto",
                   "Valor subsidio",
                   "No. Acta de cobro",
                   Fecha_instalacion "Fecha de instalacion",
                   "Convenio"
            FROM (
                  SELECT ss.asig_subsidy_id "Codigo de asignacion",
                  --Subsidio
                  ss.subsidy_id ||' - '|| ld_subsidy.description Subsidio,
                  --
                  --Ubicacion geografica
                  (case
                   when pkg_bcdirecciones.fnugetlocalidad(pkg_bcsolicitudes.fnugetdireccion(ss.package_id)) is null then
                     null
                   else
                     pkg_bcdirecciones.fnugetlocalidad(pkg_bcsolicitudes.fnugetdireccion(ss.package_id))  || ' - ' ||
                     pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetlocalidad(pkg_bcsolicitudes.fnugetdireccion(ss.package_id)))
                  end) "Ubicacion geografica",
                  --
                  --Categoria
                  (case
                    when Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id) is null then
                      null
                    else
                      Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id) || ' - ' ||
                      dacategori.fsbgetcatedesc(Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id)
                                               )
                  end) "Uso del servicio",
                  --
                  --Subcategoria
                  (case
                    when Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id) is null or
                         Ld_Bosubsidy.fnugetsubcategbypackages(ss.package_id) is null then
                      null
                    else
                     Ld_Bosubsidy.fnugetsubcategbypackages(ss.package_id) || ' - ' ||
                     dasubcateg.fsbgetsucadesc(Ld_Bosubsidy.fnugetcategorybypackages(ss.package_id),
                                               Ld_Bosubsidy.fnugetsubcategbypackages(ss.package_id)
                                              )
                  end) Estrato,
                 --
                  --
                  --Contrato
                  ss.susccodi Contrato,
                  --
                  --Nombre
                  (
                  pkg_bccliente.fsbnombres(pkg_bccontrato.fnuidcliente(ss.susccodi)) ||'  '||
                  pkg_bccliente.fsbapellidos(pkg_bccontrato.fnuidcliente(ss.susccodi))
                  )Nombre,
                 -- TEAM 462
                 -- Estado de la Venta
                  (select m.description
                   from mo_packages p, ps_motive_status m
                   where p.motive_status_id = m.motive_status_id
                   and p.package_id = ss.package_id) "Estado Solicitud Venta",

                 -- Estado del proudcto
                 (select ps.description
                  from pr_product pr, ps_product_status ps
                  where pr.product_status_id = ps.product_status_id
                  and pr.product_id = se.sesunuse) "Estado Producto",

                 --Valor del subsidio
                 ss.subsidy_value "Valor subsidio",

                 --Acta de cobro
                 ss.record_collect "No. Acta de cobro",

                 --Fecha de instalacion
                 ld_bosubsidy.fdtgetInstallDate(ss.susccodi,
                                                null
                                               ) Fecha_instalacion,
                 --Convenio
                 ld_deal.deal_id || ' - ' || ld_deal.description "Convenio" ,
                 (SELECT  p.REQUEST_DATE
                   FROM mo_packages p
                   WHERE p.package_id = ss.package_id ) fecha_registro
            FROM ld_asig_subsidy ss, servsusc se, ld_subsidy, ld_deal
            WHERE ss.susccodi      = se.sesususc
            AND   ld_subsidy.subsidy_id = ss.subsidy_id
            AND   ld_subsidy.deal_id =  ld_deal.deal_id
            AND   se.sesuserv      = ld_boconstans.cnuGasService
            --Subsidio
            AND   ss.subsidy_id    = nvl(nuSubsidy_id, ss.subsidy_id)
            --Estado del subsidio
            AND   ss.state_subsidy = nusubcurrentstate
            --Servicio suscrito
            AND   se.sesunuse = ld_bcsubsidy.Fnugetsesunuse(ss.package_id, null)
            --TICKET 2002068 ELAL-- Se agregan nuevos filtros
            AND   ld_subsidy.deal_id = nvl(sbConvenio, ld_subsidy.deal_id)
            AND   ss.susccodi  = NVL(sbContrato, ss.susccodi))
        WHERE fecha_registro BETWEEN nvl(dtFechInireg, fecha_registro) AND nvl(dtFechFinreg, fecha_registro)
         AND nvl(Fecha_instalacion,sysdate) BETWEEN nvl(dtFechIniInst, nvl(Fecha_instalacion,sysdate)) AND nvl(dtFechFinInst, nvl(Fecha_instalacion,sysdate));

      END IF;
   end if;

   -- Valida si el estado es igual a 4-PAGADO
   if nunewstate = ld_boconstans.cnuSubpaystate then

    IF onuok > 0 THEN
        OPEN rfcursor FOR
         SELECT "Codigo de asignacion",
                 SUBSIDIO,
                 "Ubicacion geografica",
                 Categoria,
                 Subcategoria,
                 CONTRATO,
                 NOMBRE,
                 "Estado Solicitud Venta",
                 "Estado Producto",
                 "Valor subsidio",
                 "No. Acta de cobro",
                 Fecha_instalacion "Fecha de instalacion",
                 "Convenio"
          FROM (
               SELECT ss.asig_subsidy_id "Codigo de asignacion",
                  --Subsidio
                  ss.subsidy_id ||' - '|| ld_subsidy.description Subsidio,
                  --
                  --Ubicacion geografica
                  (case
                     when dald_ubication.fnuGetGeogra_Location_Id(ss.ubication_id, null) is not null then
                      dald_ubication.fnuGetGeogra_Location_Id(ss.ubication_id, null)||'-'||
                      pkg_bcdirecciones.fsbgetdescripcionubicageo(dald_ubication.fnuGetGeogra_Location_Id(ss.ubication_id,
                                                                                                     null
                                                                                                    ))
                     else
                      null
                   end
                  ) "Ubicacion geografica",
                  --
                  --Categoria
                  (case
                     when dald_ubication.fnuGetSucacate(ss.ubication_id, null) is not null then
                      dald_ubication.fnuGetSucacate(ss.ubication_id, null)||'-'||
                      dacategori.fsbgetcatedesc(dald_ubication.fnuGetSucacate(ss.ubication_id, null)
                                               )
                     else
                      null
                   end
                  ) Categoria,
                  --
                  --Subcategoria
                  (case
                     when dald_ubication.fnuGetSucacodi(ss.ubication_id, null) is not null then
                      dald_ubication.fnuGetSucacodi(ss.ubication_id, null)||'-'||
                      dasubcateg.fsbgetsucadesc(dald_ubication.fnuGetSucacate(ss.ubication_id, null),
                                                dald_ubication.fnuGetSucacodi(ss.ubication_id, null)
                                               )
                     else
                      null
                   end
                  ) Subcategoria,
                  --
                  --Contrato
                  ss.susccodi Contrato,
                  --
                  --Nombre
                  (
                  pkg_bccliente.fsbnombres(pkg_bccontrato.fnuidcliente(ss.susccodi)) ||'  '||
                  pkg_bccliente.fsbapellidos(pkg_bccontrato.fnuidcliente(ss.susccodi))
                  )Nombre,
                  -- TEAM 462
                 -- Estado de la Venta
                  (select m.description
                   from mo_packages p, ps_motive_status m
                   where p.motive_status_id = m.motive_status_id
                   and p.package_id = ss.package_id) "Estado Solicitud Venta",

                 -- Estado del proudcto
                 (select ps.description
                  from pr_product pr, ps_product_status ps
                  where pr.product_status_id = ps.product_status_id
                  and pr.product_id = se.sesunuse) "Estado Producto",

                 --Valor del subsidio
                 ss.subsidy_value "Valor subsidio",

                 --Acta de cobro
                 ss.record_collect "No. Acta de cobro",

                 --Fecha de instalacion
                 ld_bosubsidy.fdtgetInstallDate(ss.susccodi,
                                                null
                                               ) Fecha_instalacion,

                 --Convenio
                 ld_deal.deal_id || ' - ' || ld_deal.description "Convenio",
                (SELECT  p.REQUEST_DATE
                 FROM mo_packages p
                 WHERE p.package_id = ss.package_id ) fecha_registro
            FROM ld_asig_subsidy ss, servsusc se, ld_subsidy, ld_deal, LDC_INFOCISU ipl
            WHERE ss.susccodi      = se.sesususc
            AND   ld_subsidy.subsidy_id = ss.subsidy_id
            AND   ld_subsidy.deal_id =  ld_deal.deal_id
            AND   se.sesuserv      = ld_boconstans.cnuGasService
             --TICKET 2002068 ELAL-- filtros de archivo plano
            AND   ipl.INCICONT  = ss.susccodi
            AND   ipl.INCIPROD  = se.sesunuse
            AND   ipl.INCISUBS  = ss.subsidy_id
            AND  ipl.INCISOLI  = ss.package_id
            --Subsidio
            AND   ss.subsidy_id    = nvl(nuSubsidy_id, ss.subsidy_id)
            --Estado del subsidio
            AND   ss.state_subsidy = nusubcurrentstate
            --Servicio suscrito
            AND   se.sesunuse = Ld_bcsubsidy.Fnugetsesunuse(ss.package_id, null)
            --Acta de cobro
            AND   ss.record_collect = nvl(nuRecordCollect, ss.record_collect)
             --TICKET 2002068 ELAL-- Se agregan nuevos filtros
            AND   ld_subsidy.deal_id = nvl(sbConvenio, ld_subsidy.deal_id)
            AND   ss.susccodi  = NVL(sbContrato, ss.susccodi))
          WHERE fecha_registro BETWEEN nvl(dtFechInireg, fecha_registro) AND nvl(dtFechFinreg, fecha_registro)
           AND nvl(Fecha_instalacion,sysdate) BETWEEN nvl(dtFechIniInst, nvl(Fecha_instalacion,sysdate)) AND nvl(dtFechFinInst, nvl(Fecha_instalacion,sysdate));

    ELSE

         OPEN rfcursor FOR
         SELECT "Codigo de asignacion",
                 SUBSIDIO,
                 "Ubicacion geografica",
                  Categoria,
                 Subcategoria,
                 CONTRATO,
                 NOMBRE,
                 "Estado Solicitud Venta",
                 "Estado Producto",
                 "Valor subsidio",
                 "No. Acta de cobro",
                 Fecha_instalacion "Fecha de instalacion",
                 "Convenio"
          FROM (
               SELECT ss.asig_subsidy_id "Codigo de asignacion",
                  --Subsidio
                  ss.subsidy_id ||' - '|| ld_subsidy.description Subsidio,
                  --
                  --Ubicacion geografica
                  (case
                     when dald_ubication.fnuGetGeogra_Location_Id(ss.ubication_id, null) is not null then
                      dald_ubication.fnuGetGeogra_Location_Id(ss.ubication_id, null)||'-'||
                      pkg_bcdirecciones.fsbgetdescripcionubicageo(dald_ubication.fnuGetGeogra_Location_Id(ss.ubication_id,
                                                                                                     null
                                                                                                    ))
                     else
                      null
                   end
                  ) "Ubicacion geografica",
                  --
                  --Categoria
                  (case
                     when dald_ubication.fnuGetSucacate(ss.ubication_id, null) is not null then
                      dald_ubication.fnuGetSucacate(ss.ubication_id, null)||'-'||
                      dacategori.fsbgetcatedesc(dald_ubication.fnuGetSucacate(ss.ubication_id, null)
                                               )
                     else
                      null
                   end
                  ) Categoria,
                  --
                  --Subcategoria
                  (case
                     when dald_ubication.fnuGetSucacodi(ss.ubication_id, null) is not null then
                      dald_ubication.fnuGetSucacodi(ss.ubication_id, null)||'-'||
                      dasubcateg.fsbgetsucadesc(dald_ubication.fnuGetSucacate(ss.ubication_id, null),
                                                dald_ubication.fnuGetSucacodi(ss.ubication_id, null)
                                               )
                     else
                      null
                   end
                  ) Subcategoria,
                  --
                  --Contrato
                  ss.susccodi Contrato,
                  --
                  --Nombre
                  (
                  pkg_bccliente.fsbnombres(pkg_bccontrato.fnuidcliente(ss.susccodi)) ||'  '||
                  pkg_bccliente.fsbapellidos(pkg_bccontrato.fnuidcliente(ss.susccodi))
                  )Nombre,
                  -- TEAM 462
                 -- Estado de la Venta
                  (select m.description
                   from mo_packages p, ps_motive_status m
                   where p.motive_status_id = m.motive_status_id
                   and p.package_id = ss.package_id) "Estado Solicitud Venta",

                 -- Estado del proudcto
                 (select ps.description
                  from pr_product pr, ps_product_status ps
                  where pr.product_status_id = ps.product_status_id
                  and pr.product_id = se.sesunuse) "Estado Producto",

                 --Valor del subsidio
                 ss.subsidy_value "Valor subsidio",

                 --Acta de cobro
                 ss.record_collect "No. Acta de cobro",

                 --Fecha de instalacion
                 ld_bosubsidy.fdtgetInstallDate(ss.susccodi,
                                                null
                                               ) Fecha_instalacion,

                 --Convenio
                 ld_deal.deal_id || ' - ' || ld_deal.description "Convenio",
               (SELECT  p.REQUEST_DATE
                 FROM mo_packages p
                 WHERE p.package_id = ss.package_id ) fecha_registro
            FROM ld_asig_subsidy ss, servsusc se, ld_subsidy, ld_deal
            WHERE ss.susccodi      = se.sesususc
            AND   ld_subsidy.subsidy_id = ss.subsidy_id
            AND   ld_subsidy.deal_id =  ld_deal.deal_id
            AND   se.sesuserv      = ld_boconstans.cnuGasService
            --Subsidio
            AND   ss.subsidy_id    = nvl(nuSubsidy_id, ss.subsidy_id)
            --Estado del subsidio
            AND   ss.state_subsidy = nusubcurrentstate
            --Servicio suscrito
            AND   se.sesunuse = Ld_bcsubsidy.Fnugetsesunuse(ss.package_id, null)
            --Acta de cobro
            AND   ss.record_collect = nvl(nuRecordCollect, ss.record_collect)
             --TICKET 2002068 ELAL-- Se agregan nuevos filtros
            AND   ld_subsidy.deal_id = nvl(sbConvenio, ld_subsidy.deal_id)
            AND   ss.susccodi  = NVL(sbContrato, ss.susccodi))
          WHERE fecha_registro BETWEEN nvl(dtFechInireg, fecha_registro) AND nvl(dtFechFinreg, fecha_registro)
           AND nvl(Fecha_instalacion,sysdate) BETWEEN nvl(dtFechIniInst, nvl(Fecha_instalacion,sysdate)) AND nvl(dtFechFinInst, nvl(Fecha_instalacion,sysdate));
    END IF;
   end if;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return rfcursor;

  exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  end frfconcollectsubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fnuGetContSub
   Descripcion    : Funcion que verifica las cantidades usadas de un
                    subsidio

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSub(inusubsidy         in ld_subsidy.subsidy_id%type,
                         inuubication       in ld_ubication.ubication_id%type,
                         inuraiseError      in number default 1
                        ) return number is

    nuContSubsidy   number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetContSub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el numero de subsidios que se han pasado a estado COBRADO en el periodo actual para esa ubicacion*/
    SELECT count(1)
    INTO   nuContSubsidy
    FROM   ld_asig_subsidy s
    WHERE  s.subsidy_id    = InuSubsidy
    AND    s.ubication_id  = InuUbication
    AND    s.state_subsidy = ld_boconstans.cnucollectstate
    AND    trunc(s.collect_date)  > trunc(sysdate, 'mm')
    AND    trunc (s.collect_date) < trunc(last_day(sysdate));

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuContSubsidy;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);    
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End fnuGetContSub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSub
   Descripcion    : Obtiene la sumatoria de los subsidios que se
                    han pasado a estado COBRADO en el periodo actual
                    para esa ubicacion.

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio
   inuubication     identificador de la poblacion
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23/01/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSumSub (inuSubsidy         in ld_subsidy.subsidy_id%type,
                         inuUbication       in ld_ubication.ubication_id%type,
                         inuRaiseError      in number default 1
                        ) return ld_subsidy.authorize_value%type is

    nusumsubsidy   ld_asig_subsidy.subsidy_value%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSumSub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener la sumatoria de los subsidios que se han pasado a estado COBRADO en el periodo actual para esa ubicacion*/
    SELECT nvl(sum(nvl(s.subsidy_value, ld_boconstans.cnuCero_Value)),
               ld_boconstans.cnuCero_Value
              )
    INTO   nusumsubsidy
    FROM   ld_asig_subsidy s
    WHERE  s.subsidy_id    = inuSubsidy
    AND    s.ubication_id  = inuUbication
    AND    s.state_subsidy = ld_boconstans.cnucollectstate
    AND    trunc(s.collect_date)  > trunc(sysdate, 'mm')
    AND    trunc (s.collect_date) < trunc(last_day(sysdate));


    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nusumsubsidy;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End fnuGetSumSub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetnumaxrec
   Descripcion    : Obtener el numero de tope de subsidios para la
                    ubicacion que se esta procesando en el periodo
                    actual

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuUbication     Identificador de la poblacion
   inuYear          A?o
   inuMonth         Mes
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function Fnugetnumaxrec(inuubication       in ld_ubication.ubication_id%type,
                          inuyear            in ld_max_recovery.year%type,
                          inumonth           in ld_max_recovery.month%type,
                          inuraiseerror      in number default 1
                         ) return ld_max_recovery.total_sub_recovery%type is

    nuNumMaxReco  ld_max_recovery.total_sub_recovery%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetnumaxrec';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el numero de tope de subsidios para la ubicacion que se esta procesando,
     en el periodo actual*/
     SELECT  nvl(m.total_sub_recovery, ld_boconstans.cnuCero_Value)
     INTO    nuNumMaxReco
     FROM    ld_max_recovery m
     WHERE   m.ubication_id = inuUbication
     AND     m.year         = inuYear
     AND     m.month        = inuMonth;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuNumMaxReco;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END Fnugetnumaxrec;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetValMaxRec
   Descripcion    : Funcion que Obtiene el Valor Tope del subsidio
                    para la Ubicacion que se esta procesando, en el
                    periodo actual.

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuUbication     Identificador de la poblacion
   inuYear          A?o
   inuMonth         Mes
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetValMaxRec(inuUbication       in ld_ubication.ubication_id%type,
                           inuYear            in ld_max_recovery.year%type,
                           inuMonth           in ld_max_recovery.month%type,
                           inuRaiseError      in number default 1
                          ) return ld_max_recovery.recovery_value%type is

    nuValMaxReco  ld_max_recovery.recovery_value%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetValMaxRec';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el valor tope del subsidio para la Ubicacion que se esta procesando,
    en el periodo actual*/
    SELECT  nvl(m.recovery_value, ld_boconstans.cnuCero_Value)
    INTO    nuValMaxReco
    FROM    ld_max_recovery m
    WHERE   m.ubication_id = inuUbication
    AND     m.year         = inuYear
    AND     m.month        = inuMonth;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuValMaxReco;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetValMaxRec;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fsbgetsystlocation
   Descripcion    : Obtiene la ciudad asociada a un codigo de sistema
                    especifico.

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 30/01/2013

   Parametros       Descripcion
   ============     ===================
   inusyscodi       Identificador del sistema
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   30/01/2013       jconsuegra            SAO156577 Creacion
  ******************************************************************/
  Function fsbgetsystlocation(inusyscodi    in sistema.sistcodi%type,
                              inuRaiseError in number default 1
                             ) return sistema.sistciud%type is

    sblocation  sistema.sistciud%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fsbgetsystlocation';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT  s.sistciud
    INTO    sblocation
    FROM    sistema s
    WHERE   s.sistcodi = inusyscodi;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return sblocation;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);   
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End fsbgetsystlocation;
/*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : frfbillsalessubsidy
   Descripcion    : Consulta subsidios entregados para generacion de
                    duplicados de facturas de venta.

   Autor          : Evens Herard Gorut
   Fecha          : 30/01/2013

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio DAGE_SUBSCRIBER.FSBGETIDENTIFICATION por PKG_BCCLIENTE.FSBIDENTIFICACION
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME por PKG_BCCLIENTE.FSBAPELLIDOS
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME por PKG_BCCLIENTE.FSBNOMBRES
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio PKTBLSUSCRIPC.FNUGETSUSCCLIE por PKG_BCCONTRATO.FNUIDCLIENTE
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   29/08/2013       hvera.SAO212349       Se corrige error que dejaba el
                                          codigo de los formularios de venta
                                          como numero negativo.
   30/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
   Function frfbillsalessubsidy return constants_per.tyrefcursor is

      rfcursor constants_per.tyrefcursor;

      nuSubsidy_Id         ge_boInstanceControl.stysbValue;
      nuPackage_Id         ge_boInstanceControl.stysbValue;
      nuRecordCollect      ge_boInstanceControl.stysbValue;
      nuGeLocation         ge_boInstanceControl.stysbValue;
      dtInitialDate        mo_packages.request_date%type;
      dtFinalDate          mo_packages.request_date%type;
      nuDeal_Id            ge_boInstanceControl.stysbValue;
      nuSubcacodi          ge_boInstanceControl.stysbValue;
      nuCategori           ge_boInstanceControl.stysbValue;
      
      csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'frfbillsalessubsidy';        
      nuError              NUMBER;
      sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

     /*obtener los valores ingresados en la aplicacion PB LDRSS Reversion de subsidios*/
      nuSubsidy_Id        :=  ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','SUBSIDY_ID');
      nuPackage_Id        :=  ge_boInstanceControl.fsbGetFieldValue('LD_SALES_WITHOUTSUBSIDY','PACKAGE_ID');
      nuRecordCollect     :=  ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY','RECORD_COLLECT');
      nuGeLocation        :=  ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','GEOGRA_LOCATION_ID');
      dtInitialDate       :=  ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','STAR_COLLECT_DATE'));
      dtFinalDate         :=  ut_date.fdtdatewithformat(ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY','FINAL_DATE'));
      nuDeal_Id           :=  ge_boInstanceControl.fsbGetFieldValue('LD_DEAL','DEAL_ID');
      nuCategori          :=  ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','SUCACATE');
      nuSubcacodi         :=  ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION','SUCACODI');

      if dtInitialDate > dtFinalDate then        
        sbError := 'La fecha final de la solicitud de venta no puede ser menor a la fecha inicial de la solicitud de venta';                     
        nuError := gcnuerrorcode;
        pkg_error.seterror;
        pkg_Error.getError(nuError,sbError);
        Raise pkg_error.controlled_error;
      end if;

       OPEN rfcursor FOR
        SELECT
        /*No. de solicitud*/
        ss.package_id  "Numero de Solicitud",
        --
        /*Contrato*/
        ss.susccodi "Numero de Contrato",
        --
        /*Nro de formulario de venta*/
        damo_packages.fsbGetDocument_Key(ss.package_id, null) "Numero Formulario de Venta",
        --
        /*Convenio*/
        dald_subsidy.fnuGetDeal_Id(ss.subsidy_id, null) "Codigo del convenio",
        --
        /*Descripcion del convenio*/
        dald_deal.fsbGetDescription(dald_subsidy.fnuGetDeal_Id(ss.subsidy_id, null),
                                    null
                                   ) "Descripcion del convenio",
        --
        /*Subsidio*/
        ss.subsidy_id "Codigo del Subsidio",
        --
        /*Descripcion del subsidio*/
        dald_subsidy.fsbGetDescription(ss.subsidy_id, null) "Descripcion Subsidio",
        --
        /*Cliente*/
        pkg_bccliente.fsbidentificacion(pkg_bccontrato.fnuidcliente(ss.susccodi)) "Numero Identificacion Cliente",
        --
        /*Nombres y apellidos del cliente*/
        pkg_bccliente.fsbnombres(pkg_bccontrato.fnuidcliente(ss.susccodi)) ||'  '|| pkg_bccliente.fsbapellidos(pkg_bccontrato.fnuidcliente(ss.susccodi)) "Nombres y apellidos cliente",
        --
        /*Ubicacion geografica*/
        (case
           when pkg_bcdirecciones.fnugetlocalidad(m.address_id) is not null then
                pkg_bcdirecciones.fnugetlocalidad(m.address_id)||'-'||
                pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetlocalidad(m.address_id))
           else
            null
          end
         ) "Ubicacion geografica",
         --
         /*Categoria*/
         (case
             when Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) is not null then
              Ld_Bosubsidy.fnugetcategorybypackages(m.package_id)||'-'||
              dacategori.fsbgetcatedesc(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id)
                                       )
             else
              null
           end
         ) "Uso del Servicio",
         --
         /*Subcategoria*/
         (case
           when Ld_Bosubsidy.fnugetcategorybypackages(m.package_id) is not null or
                Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id) is not null then

                Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id)||'-'||
                dasubcateg.fsbgetsucadesc(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                                          Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id)
                                         )
           else
            null
         end
        ) "Estrato"
        --
        FROM ld_asig_subsidy ss, servsusc se, mo_packages m, ld_subsidy s
        WHERE ss.susccodi = se.sesususc
        AND   se.sesuserv = ld_boconstans.cnuGasService
        AND   se.sesunuse = nvl(Ld_bcsubsidy.Fnugetsesunuse(m.package_id, null),
                                se.sesunuse
                               )
        AND m.package_id = ss.package_id
        AND s.subsidy_id = ss.subsidy_id
        /*Subsidio*/
        AND ss.subsidy_id = nvl(nuSubsidy_id, ss.subsidy_id)
        /*Solicitud de venta*/
        AND ss.package_id = nvl(nuPackage_id, ss.package_id)
        /*Acta de Cobro*/
        AND nvl(ss.record_collect, 1.1) = nvl(nuRecordCollect, nvl(ss.record_collect, 1.1))
        /*Ubicacion geografica*/
        AND nvl(pkg_bcdirecciones.fnugetlocalidad(m.address_id),
                ld_boconstans.cnuonenumber
               ) = decode(nuGeLocation,
                          null,
                          nvl(pkg_bcdirecciones.fnugetlocalidad(m.address_id),
                              ld_boconstans.cnuonenumber
                             ),
                          nuGeLocation)
        /*Uso (categoria)*/
        AND nvl(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                ld_boconstans.cnuonenumber
               ) = decode(nuCategori,
                          null,
                          nvl(Ld_Bosubsidy.fnugetcategorybypackages(m.package_id),
                              ld_boconstans.cnuonenumber
                             ),
                          nuCategori)
        /*Estrato (subcategoria)*/
        AND nvl(Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),
                ld_boconstans.cnuonenumber
               ) = decode(nuSubcacodi,
                          null,
                          nvl(Ld_Bosubsidy.fnugetsubcategbypackages(m.package_id),
                              ld_boconstans.cnuonenumber
                             ),
                          nuSubcacodi
                         )
        /*Convenio*/
        AND s.deal_id = nvl(nuDeal_Id, s.deal_id)
        /*Rango de fecha de registro de la solicitud*/
        AND trunc(m.request_date) >= dtInitialDate
        AND trunc(m.request_date) <  dtFinalDate + 1;

      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

      return rfcursor;

     Exception
      When pkg_error.controlled_error then
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
        raise pkg_error.controlled_error;
      When others then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      END frfbillsalessubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fsbgetenterprise
   Descripcion    : Obtiene el nombre de la empresa del sistema.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 01/02/2013

   Parametros       Descripcion
   ============     ===================
   inusyscodi       Identificador del sistema
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   01/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fsbgetenterprise(inusyscodi in sistema.sistcodi%type,
                            inuRaiseError in number default 1
                           ) return varchar2 is

    sbenterprise sistema.sistempr%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fsbgetenterprise';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT sistempr
    INTO   sbenterprise
    FROM   sistema s
    WHERE  s.sistcodi = inusyscodi;

    return sbenterprise;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fsbgetenterprise;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetenterprisephone
   Descripcion    : Obtiene los telefonos de la empresa del sistema.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 01/02/2013

   Parametros       Descripcion
   ============     ===================
   inusyscodi       Identificador del sistema
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   01/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetenterprisephone(inusyscodi in sistema.sistcodi%type,
                                 inuRaiseError in number default 1
                                ) return sistema.sisttele%type is

    nuphone sistema.sisttele%type;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetenterprisephone';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT sisttele
    INTO   nuphone
    FROM   sistema s
    WHERE  s.sistcodi = inusyscodi;

    return nuphone;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);    
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetenterprisephone;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Frfgetsubsidytocollect
   Descripcion    : Obtiene los subsidios asociados a un acta de
                    cobro determinada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 07/02/2013

   Parametros       Descripcion
   ============     ===================
   inurecordcollect Identificador del acta de cobro

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION por PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME por PKG_BCCLIENTE.FSBAPELLIDOS
                                          Cambio DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME por PKG_BCCLIENTE.FSBNOMBRES
                                          Cambio DALD_PARAMETER.FSBGETVALUE_CHAIN por PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
                                          Cambio DAMO_PACKAGES.FNUGETSUBSCRIBER_ID por PKG_BCSOLICITUDES.FNUGETCLIENTE
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
                                          Cambio LDC_BOUTILITIES.SPLITSTRINGS por REGEXP_SUBSTR
   07/02/2013       jconsuegra.SAO156577  Creacion
   07/08/2014       jsoto                 Se crea parametro para ingresar los estados
                                          de los subsisdios que no deben salir en acta
  ******************************************************************/
  Function Frfgetsubsidytocollect(inurecordcollect in sistema.sistcodi%type
                                 ) return constants_per.tyrefcursor is

    rfSubsidy    constants_per.tyrefcursor;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Frfgetsubsidytocollect';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN rfSubsidy FOR
      SELECT l.record_collect acta_cobro,
       l.subsidy_id,
       Dald_Sponsor.fsbGetDescription(Dald_Deal.fnuGetSponsor_Id(Dald_Subsidy.fnuGetDeal_Id(l.subsidy_id, null),
                                                                 null
                                                                )
                                      ,
                                      null
                                     ) Ente,
       l.asig_subsidy_id,
       pkg_bcdirecciones.fsbgetdescripcionubicageo(Dald_Ubication.fnuGetGeogra_Location_Id(l.ubication_id, null)) Ubicacion,
       l.susccodi,
       (
         pkg_bccliente.fsbnombres(pkg_bcsolicitudes.fnugetcliente(l.package_id))||' '||
         pkg_bccliente.fsbapellidos(pkg_bcsolicitudes.fnugetcliente(l.package_id))
       ) Cliente,
       (case
          when damo_motive.fnuGetCategory_Id(Ld_Bcsubsidy.Fnugetmotive(l.package_id,
                                                                       null
                                                                      ),
                                             null
                                            ) is null then
            null
          else
            Dasubcateg.fsbgetsucadesc(damo_motive.fnuGetCategory_Id(Ld_Bcsubsidy.Fnugetmotive(l.package_id,
                                                                                               null
                                                                                              ),
                                                                     null
                                                                    ),
                                       damo_motive.fnuGetSubcategory_Id(Ld_Bcsubsidy.Fnugetmotive(l.package_id,
                                                                                                  null
                                                                                                 ),
                                                                        null
                                                                       )
                                      )

         end
       ) Estrato,
       l.subsidy_value
      FROM     ld_asig_subsidy l
      WHERE    l.record_collect = inurecordcollect
      AND      L.STATE_SUBSIDY not in 
        (select to_number(regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('EST_NO_ACTA_SUBSIDIO'), '[^,]+', 1, level)) AS column_value
            from dual
            connect by
        regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('EST_NO_ACTA_SUBSIDIO'), '[^,]+', 1, LEVEL) IS NOT NULL)-- Estado Reversado
      ORDER BY l.asig_subsidy_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    
    return rfSubsidy;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Frfgetsubsidytocollect;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FrfGenlettertopotential
   Descripcion    : Obtiene los usuarios potenciales a
                    notificarle de los subsidios ofertados

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/12/2012

   Parametros       Descripcion
   ============     ===================

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
                                          Se eimina linea dbms_output.put_Line('QUERY: '||sbquery); 
   23-08-2014       agordillo             Se cambia la clausula NOT IN por NOT EXISTS en la consulta dinamida
                                          sbquery se agrega la condicion en el where para relacionar las tablas
                                          dado que se quita el NOT IN
   18-Ene-2014      AEcheverry.SAO229887  Se modifica sentencia para incluir los
                                          criterios de categoria, subcategoria y  ubicacion geografica
   22-12-2013       JCarmona.SAO228583    Se modifica para que obtenga todos los clientes
                                          potenciales sin importar si tienen o no contrato
                                          asociado
   05-12-2013       hjgomez.SAO226138     Se modifica para hacer un outer join con los
                                          suscriptores
   21/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FrfGenlettertopotential
  (
   inuGeoLoca   in  ld_ubication.geogra_location_id%type,
   inuCategory  in  ld_ubication.sucacate%type,
   inuSubcateog in  ld_ubication.sucacodi%type
  )
   return constants_per.tyrefcursor is


    rfuserpotencial constants_per.tyrefcursor;
    sbGeogLocaCond  varchar2(1000);
    sbSubcateCond   varchar2(1000);
    sbquery         varchar2(9000);
    nuparam         number := 0;
    nuGasService    number := ld_boconstans.cnuGasService;
  
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FrfGenlettertopotential';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    sbGeogLocaCond := ' ';
    if(inuGeoLoca IS not null) then
        sbGeogLocaCond :=  ' AND a.geograp_location_id = :inuGeoLoca ';
        nuparam := 1;
    END if;

    sbSubcateCond := ' AND ap.subcategory_ IS not null ';
    if(inuSubcateog is not null) then
        sbSubcateCond := ' AND ap.subcategory_ = :subcategory ';
        nuparam := nuparam+1;
    END if;

    sbquery := 'SELECT
            unique s.subscriber_id,  a.address_id,
            a.geograp_location_id Ubication,
            ap.category_ Category,
            ap.subcategory_ Subcategory
        FROM ab_premise ap, ab_address a  , ge_subscriber s
     WHERE ap.category_ = :nucategori '||
         sbSubcateCond||
         ' AND a.estate_number = ap.premise_id '||
         sbGeogLocaCond||
         ' AND not exists
            (select parser_address_id
            FROM mo_packages p, mo_address m
            WHERE p.package_type_id in (271,323,100229,329)
            AND m.package_id=p.package_id
            AND a.address_id = parser_address_id) '||
        ' AND not exists
            (select  address_id
                    FROM pr_product WHERE product_type_id = :productType
                    and a.address_id = address_id ) '||
        ' AND a.address_id = s.address_id (+)' ;



    pkg_traza.trace('QUERY: '||sbquery, 10);
    
    -- para rendimiento
    if(nuparam =2) then
        OPEN rfuserpotencial FOR sbquery using 1, inuSubcateog,inuGeoLoca, nuGasService;
    elsif(nuparam =1) then
        OPEN rfuserpotencial FOR sbquery using 1, nvl(inuSubcateog,inuGeoLoca), nuGasService;
    else
        OPEN rfuserpotencial FOR sbquery using 1, nuGasService;
    END if;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    Return(rfuserpotencial);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End FrfGenlettertopotential;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetuserisconnect
   Descripcion    : Determina si un usuario posee servicio GAS y
                    el servicio ha sido conectado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/02/2013

   Parametros       Descripcion
   ============     ===================
   inususccodi      Identificador del contrato
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKTBLSERVSUSC.FDTGETSESUFEIN por PKG_BCPRODUCTO.FDTFECHAINSTALACION
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetuserisconnect(inususccodi   in suscripc.susccodi%type,
                               inuRaiseError in number default 1
                              ) return number is

    nunuse      servsusc.sesunuse%type;
    dtitialfate servsusc.sesufein%type;
    nuanswer    number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetuserisconnect';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nuanswer := ld_boconstans.cnuCero_Value;

    nunuse := Ld_Bcsubsidy.Fnugetactivesesunuse(inususccodi,
                                                null
                                               );

    if nunuse is not null then

      dtitialfate := pkg_bcproducto.fdtfechainstalacion(nunuse);

      if dtitialfate is not null then

        nuanswer := ld_boconstans.cnuonenumber;

        return (nuanswer);

      else

        return (nuanswer);

      end if;

    else

      return (nuanswer);

    end if;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetuserisconnect;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FcrGetSuscAsigSubsidy
   Descripcion    : Obtiene los contratos subsidiados que no tienen
                    conexion o instalacion del servicio de Gas para una
                    poblacion espesifica una poblacion

   Autor          : Evens Herard Gorut
   Fecha          : 07/02/2013

   Parametros             Descripcion
   ============           ===================
   inuAsigSubsidyId       Codigo de subsidio entregado
   inuUbicationId         Ubicacion del subsidio
   inupackagesstatus      Estado de la solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
  ******************************************************************/
  Function FrcGetSuscAsigSubsidy(inuSubsidyId      in ld_asig_subsidy.Asig_Subsidy_Id%type,
                                 inupackagesstatus in mo_packages.motive_status_id%type
                                ) return  DaLd_Asig_Subsidy.tyRefCursor is

    rfSuscAsigSubsidy DaLd_Asig_Subsidy.tyRefCursor;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FrcGetSuscAsigSubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

     /*Cursor para obtener los contratos asociados a los subsidios entregados
      para un subsidio especifico (inuSubsidyId), para una ubicacion (inuUbicationId)
      y que no tienen el servicio de Gas instalado*/
      Open rfSuscAsigSubsidy for
        SELECT a.Asig_Subsidy_Id,a.Susccodi
        FROM Ld_Asig_Subsidy a, mo_packages m
        WHERE a.package_id = m.package_id
        AND a.Subsidy_Id   = inuSubsidyId
        AND m.motive_status_id = inupackagesstatus
        AND a.State_Subsidy <> ld_boconstans.cnuSubreverstate
        AND a.Type_Subsidy  <> 'RE';

    return rfSuscAsigSubsidy;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End FrcGetSuscAsigSubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuuserwithsubsamedeal
   Descripcion    : Determina si un usuario tiene asignado al menos
                    un subsidio asociado a un convenio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/02/2013

   Parametros       Descripcion
   ============     ===================
   inudeal          Identificador del convenio
   inususc          Identificador del contrato

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuuserwithsubsamedeal(inudeal IN ld_deal.deal_id%type,
                                  inususc IN suscripc.susccodi%type
                                 ) return number is

    nuanswer number := ld_boconstans.cnuCero_Value;
    
    CURSOR cuCantSubAsig(inudealcu IN ld_deal.deal_id%type,
                         inususccu IN suscripc.susccodi%type) IS
    SELECT count(1)    
    FROM   ld_subsidy l
    WHERE  l.deal_id = inudealcu
    AND   EXISTS (SELECT 1
                  FROM   ld_asig_subsidy a
                  WHERE  a.subsidy_id = l.subsidy_id
                  AND    a.susccodi   = inususccu
                  ANd    a.state_subsidy <> ld_boconstans.cnuSubreverstate
                 );

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuuserwithsubsamedeal';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
    
    OPEN cuCantSubAsig(inudeal,inususc);
    FETCH cuCantSubAsig INTO nuanswer;
    CLOSE cuCantSubAsig;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuanswer);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnuuserwithsubsamedeal;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsalwithsubasig
   Descripcion    : Determina si una solicitud ha sido subsidiada.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 21/02/2013

   Paramatros       Descripcion
   ============     ===================
   inupackage_id    identificador de la solicitud

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   21/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsalwithsubasig(inupackage_id mo_packages.package_id%type
                               ) return number is

    nucont number := Ld_Boconstans.cnuCero;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsalwithsubasig';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nucont
      FROM ld_asig_subsidy l
     WHERE l.package_id = inupackage_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nucont);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetsalwithsubasig;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubsidypackage
   Descripcion    : Obtiene la solicitud de venta de subsidio asociada
                    a un cliente.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 22/02/2013

   Paramatros       Descripcion
   ============     ===================
   inususccodi      identificador del contrato
   inusubsidy       identificador del subsidio
   inuubication     identificador de la poblacion subsidiada
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   22/02/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubsidypackage(inususccodi  in suscripc.susccodi%type,
                                inusubsidy   in ld_subsidy.subsidy_id%type,
                                inuubication in ld_ubication.ubication_id%type,
                                inuRaiseError in number default 1
                               ) return mo_packages.package_id%type is

    nupackage_id mo_packages.package_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubsidypackage';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT distinct l.package_id
      INTO nupackage_id
      FROM ld_asig_subsidy l
     WHERE l.susccodi     = inususccodi
       AND l.subsidy_id   = inusubsidy
       AND l.ubication_id = inuubication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nupackage_id);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetsubsidypackage;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).

     Unidad         : fnugetdeliverytotal
     Descripcion    : Funcion que retorna el Delivery Total de un subsidio
                      entregado y un contrato espesifico
     Autor          : Evens Herard Gorut
     Fecha          : 13/02/2012

     Parametros        Descripcion
     ============     ===================
     inusubsidy       Identificador del subsidio
     inususccodi      Identificador del Contrato
     inuSession       Identidficador de la session


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                            Se aplican pautas técnicas 
                                            Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                            Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                            Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
     13/02/2012       eherard.SAO156577     Creacion
  /*************************************************************************/
  Function FnuGetDeliveryTotal(inuSubsidyId     in ld_asig_subsidy.Asig_Subsidy_Id%type,
                               inuSusccodi      in ld_asig_subsidy.susccodi%type,
                               inuUbication     in ld_asig_subsidy.ubication_id%type,
                               inuRaiseError    in number default 1
                              ) return  ld_sub_remain_deliv.delivery_total%type is

    nuDelveryTotal ld_sub_remain_deliv.delivery_total%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetDeliveryTotal';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT nvl(r.delivery_total,0)
    INTO nuDelveryTotal
    FROM ld_sub_remain_deliv r
    WHERE r.subsidy_id = inuSubsidyId
    AND r.Susccodi = inuSusccodi
    AND r.ubication_id = inuUbication;

    return nuDelveryTotal;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

   Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End FnuGetDeliveryTotal;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRem
   Descripcion    : Funcion que Obtiene el Valor total de los
                    subsidios remanentes distribuidos

   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/12/2013       jrobayo.SAO227371     1- Se modifica para la consulta de valores sin
                                             tener en cuenta la sesion de Oracle.
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRem(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                           inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                           inuRaiseError      in number default 1
                          ) return ld_sub_remain_deliv.delivery_total%type is

    nuValSumSubRem  ld_sub_remain_deliv.delivery_total%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSumSubRem';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener la suma de los subsidios (Delivery_total) de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     y que pertenecen a un subsidio especifico*/
    SELECT  nvl(sum(r.delivery_total),0)
    INTO    nuValSumSubRem
    FROM    ld_sub_remain_deliv r
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuValSumSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);   
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetSumSubRem;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRem
   Descripcion    : Funcion que Obtiene el Valor total de los
                    subsidios remanentes distribuidos

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/12/2013       jrobayo.SAO227371     1- Se modifica para la consulta de valores sin
                                             tener en cuenta la sesion de Oracle.
                                          2- Se elimina la condicion que filtraba los resultados de la consulta por
                                          el valor del parametro para subsidios reversados.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRem(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                            inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                            inuRaiseError      in number default 1
                           ) return number is

    nuContSubRem  number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetContSubRem';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el numero total de los subsidios de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     y que pertenecen a un subsidio especifico*/
    SELECT  count(1)
    INTO    nuContSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    AND     r.asig_subsidy_id = l.asig_subsidy_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuContSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetContSubRem;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetValDisByServ
   Descripcion    : Obtiene el valor distribuido del remannete del subsidio,
                    para cada servicio.


   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/12/2013       jrobayo.SAO223371     Se modifica para no tener en cuenta la
                                          sesion de Oracle.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetValDisByServ(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                              ) return ld_sub_remain_deliv.delivery_total%type is

    nuValDisByServ  ld_sub_remain_deliv.delivery_total%type;
    nuServDist      ld_sub_remain_deliv.delivery_total%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetValDisByServ';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el valor distribuido del remannete del subsidio, para cada servicio*/
    SELECT  nvl(r.delivery_total,0)
    INTO    nuValDisByServ
    FROM    ld_sub_remain_deliv r
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    AND     rownum = 1;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return  nuValDisByServ;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetValDisByServ;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FsbGetProcTypeRemSub
   Descripcion    : Obtiene la descripcion del tipo de proceso que se ejecuto :
                    (SI = SIMULACION o DI = DISTRIBUCION).


   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FsbGetProcTypeRemSub(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                                inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                                inuSession         in ld_sub_remain_deliv.sesion%type,
                                inuRaiseError      in number default 1
                               ) return ld_subsidy.description%type is

    sbDescription  ld_subsidy.description%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FsbGetProcTypeRemSub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtiene la descripcion del tipo de proceso que se ejecuto :
    (SI = SIMULACION o DI = DISTRIBUCION).*/
    SELECT  r.state_delivery
    INTO    sbDescription
    FROM    ld_sub_remain_deliv r
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    AND     r.sesion = inuSession
    AND     rownum = 1;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return  sbDescription;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FsbGetProcTypeRemSub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRemAn
   Descripcion    : Obtiene el numero total de los
                    subsidios remanentes distribuidos en estado
                    Anulado

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRemAn(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return number is

    nuContSubRem  number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetContSubRemAn';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el numero total de los subsidios de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     que pertenecen a un subsidio especifico y cuyo estado de los registros
     en ld_Asig_subsidy = (REVERSADO o ANULADO)*/
    SELECT  count(1)
    INTO    nuContSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    AND     r.susccodi = l.susccodi
    AND     r.subsidy_id  = l.subsidy_id
    AND     r.ubication_id = l.ubication_id
    AND     l.state_subsidy = ld_boconstans.cnuSubreverstate;--Constante de Estado Anulado

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuContSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetContSubRemAn;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRemDi
   Descripcion    : Obtiene el numero total de los
                    subsidios remanentes distribuidos en estado
                    Distribuido

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRemDi(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return number is

    nuContSubRem  number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetContSubRemDi';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el numero total de los subsidios de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     que pertenecen a un subsidio especifico y cuyo estado de los registros
     en ld_Asig_subsidy != (REVERSADO) y no exista C.C. para el nuse*/
    SELECT  count(1)
    INTO    nuContSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    AND     r.susccodi = l.susccodi
    --
    AND     r.subsidy_id  = l.subsidy_id
    AND     r.ubication_id = l.ubication_id
    AND     l.state_subsidy != ld_boconstans.cnuSubreverstate --Constante de Estado Anulado
    AND     0 = Ld_BcSubsidy.Fnubilluser(Ld_BcSubsidy.Fnugetsesunuse (l.package_id, null),
                                           null
                                        );
    --
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuContSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetContSubRemDi;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetContSubRemPr
   Descripcion    : Obtiener el numero total de los
                    subsidios remanentes distribuidos en estado
                    Procesado

   Autor          : Evens Herard Gorut
   Fecha          : 22/02/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
   22/02/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetContSubRemPr(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                              inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                              inuRaiseError      in number default 1
                             ) return number is

    nuContSubRem  number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetContSubRemPr';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el numero total de los subsidios de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     que pertenecen a un subsidio especifico y cuyo estado de los registros
     en ld_Asig_subsidy != (REVERSADO) y que exista C.C. para el nuse*/
    SELECT  count(1)
    INTO    nuContSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    AND     r.susccodi = l.susccodi
    AND     r.subsidy_id  = l.subsidy_id
    AND     r.ubication_id = l.ubication_id
    AND     l.state_subsidy != ld_boconstans.cnuSubreverstate --Constante de Estado Anulado
    AND     0 != Ld_BcSubsidy.Fnubilluser (Ld_BcSubsidy.Fnugetsesunuse (l.package_id, null),
                                             null
                                          );

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuContSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetContSubRemPr;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRemAn
   Descripcion    : Obtiene el valor total de los
                    subsidios remanentes distribuidos por estado
                    Anulado
   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRemAn(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                             inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                             inuRaiseError      in number default 1
                            ) return ld_sub_remain_deliv.delivery_total%type is

    nuValSumSubRem  ld_sub_remain_deliv.delivery_total%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSumSubRemAn';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener la suma de los subsidios (Delivery_total) de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     que pertenecen a un subsidio especifico y cuyo estado de los registros
     en ld_Asig_subsidy = (REVERSADO o ANULADO)*/
    SELECT  nvl(sum(r.delivery_total),0)
    INTO    nuValSumSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    --
    AND     r.susccodi = l.susccodi
    AND     r.subsidy_id  = l.subsidy_id
    AND     r.ubication_id = l.ubication_id
    AND     l.state_subsidy = ld_boconstans.cnuSubreverstate;--Constante de Estado Anulado
    --
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuValSumSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetSumSubRemAn;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRemDi
   Descripcion    : Obtiene el valor total de los
                    subsidios remanentes distribuidos por estado
                    Distribuido
   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRemDi(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                             inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                             inuRaiseError      in number default 1
                            ) return ld_sub_remain_deliv.delivery_total%type is

    nuValSumSubRem  ld_sub_remain_deliv.delivery_total%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSumSubRemDi';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener la suma de los subsidios (Delivery_total) de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     que pertenecen a un subsidio especifico y cuyo estado de los registros
     en ld_Asig_subsidy != (REVERSADO) y no exista C.C. para el nuse*/
    SELECT  nvl(sum(r.delivery_total),0)
    INTO    nuValSumSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    --
    AND     r.susccodi = l.susccodi
    AND     r.subsidy_id  = l.subsidy_id
    AND     r.ubication_id = l.ubication_id
    AND     l.state_subsidy != ld_boconstans.cnuSubreverstate --Constante de Estado Anulado
    AND     0 = Ld_BcSubsidy.Fnubilluser(Ld_BcSubsidy.Fnugetsesunuse (l.package_id, null),
                                           null
                                         );
    --
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuValSumSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetSumSubRemDi;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumSubRemPr
   Descripcion    : Obtiene el valor total de los subsidios
                    remanentes distribuidos por estado
                    procesado
   Autor          : Evens Herard Gorut
   Fecha          : 23/01/2013

   Parametros       Descripcion
   ============     ===================
   inuSubsidy_id    subsidio
   inuUbication_id  Ubicacion
   inuSession       session de oracle
   inuRaiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                          como filtro en los reportes de remanentes.
   23/01/2013       eherard.SAO156577     Creacion
  ******************************************************************/
  Function FnuGetSumSubRemPr(inuSubsidy_id      in ld_subsidy.subsidy_id%type,
                             inuUbication       in ld_sub_remain_deliv.ubication_id%type,
                             inuRaiseError      in number default 1
                            ) return ld_sub_remain_deliv.delivery_total%type is

    nuValSumSubRem  ld_sub_remain_deliv.delivery_total%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSumSubRemPr';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener la suma de los subsidios (Delivery_total) de la tabla LD_SUB_REMAIN_DELIV
     asociados a la session de oracle actual (Variable de paquete de ld_bosubsidy),
     que pertenecen a un subsidio especifico y cuyo estado de los registros
     en ld_Asig_subsidy != (REVERSADO) y que exista C.C. para el nuse*/
    SELECT  nvl(sum(r.delivery_total),0)
    INTO    nuValSumSubRem
    FROM    ld_sub_remain_deliv r, ld_asig_subsidy l
    WHERE   r.subsidy_id = inuSubsidy_id
    AND     r.ubication_id = inuUbication
    --
    AND     r.susccodi = l.susccodi
    AND     r.subsidy_id  = l.subsidy_id
    AND     r.ubication_id = l.ubication_id
    AND     l.state_subsidy != ld_boconstans.cnuSubreverstate --constante de estado anulado
    AND     0 != Ld_BcSubsidy.Fnubilluser(Ld_BcSubsidy.Fnugetsesunuse (l.package_id, null),
                                            null
                                         );
    --
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuValSumSubRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);    
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  END FnuGetSumSubRemPr;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnutotquantitysubbydeal
    Descripcion    : Obtiene la cantidad de subsidios asociados a un
                     convenio, que fueron parametrizados por
                     cantidad autorizada

    Autor          : jonathan alberto consuegra lara
    Fecha          : 06/03/2013

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    06/03/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnutotquantitysubbydeal(inuDEAL_Id in LD_deal.DEAL_Id%type
                                  ) return number is

    nurows ld_subsidy.total_deliver%type := ld_boconstans.cnuCero_Value;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnutotquantitysubbydeal';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      Into nurows
      FROM ld_subsidy l
     WHERE l.deal_id = inuDEAL_Id
       AND l.authorize_quantity is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End fnutotquantitysubbydeal;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fcltempclob
    Descripcion    : Obtiene un clob de la entidad ld_temp_clob_fact

    Autor          : jonathan alberto consuegra lara
    Fecha          : 12/03/2013

    Parametros       Descripcion
    ============     ===================
    inuid            identificador de registro
    inuRaiseError    controlador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas  
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    12/03/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fcltempclob(inuid          in ld_temp_clob_fact.temp_clob_fact_id%type,
                       inuRaiseError  in number default 1
                      )return clob is

    clclob clob;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fcltempclob';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT l.docudocu
    INTO   clclob
    FROM   ld_temp_clob_fact l
    WHERE  l.temp_clob_fact_id = inuid;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(clclob);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End fcltempclob;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fcldupbillclob
   Descripcion    : Obtiene los clobs asociados a una
                    sesion de usuario registrados en la
                    entidad ld_temp_clob_fact

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/03/2013

   Parametros       Descripcion
   ============     ===================
   inusesion        sesion de usuario

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/03/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fcldupbillclob(inusesion ld_temp_clob_fact.sesion%type
                         ) return constants_per.tyrefcursor is

    rfclobs constants_per.tyrefcursor;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fcldupbillclob';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    OPEN rfclobs FOR
      SELECT l.docudocu
      FROM   ld_temp_clob_fact l
      WHERE  l.sesion = inusesion
      AND    l.docudocu is not null;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(rfclobs);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fcldupbillclob;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FsbGetTecStatus
   Descripcion    : Obtiene el estado tecnico y descripcion
                    para un servicio suscrito especifico

   Autor          : Evens Herard Gorut
   Fecha          : 14/03/2013

   Parametros       Descripcion
   ============     ===================
   inunuse          identificador del numero de servicio suscrito
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR         
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/03/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  Function FsbGetTecStatus (inuNuse            in servsusc.sesunuse%type,
                            inuRaiseError      in number default 1
                           ) return varchar2 is

   /*Declaracion de variables*/
    nuTecStatus     pr_product.product_status_id%type;
    sbDescTecStatus ps_product_status.description%type;
    sbTecStatus     varchar2(100);

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FsbGetTecStatus';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    /*Obtener el estado tecnico de PR_PRODUCT para el servicio Gas par aun nuse especifico*/
    Select pr.product_status_id, ps.description
    into   nuTecStatus, sbDescTecStatus
    From   Pr_product pr, Ps_Product_Status ps
    Where  pr.product_id = inuNuse
    and    pr.product_type_id = ld_boconstans.cnuGasService
    and    pr.product_status_id = ps.product_status_id
    and    ps.prod_status_type_id = pkg_bcld_parameter.fnuobtienevalornumerico('PROD_STATUS_TYPE');

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    sbTecStatus := nuTecStatus||'-'||sbDescTecStatus;

    Return sbTecStatus;

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End FsbGetTecStatus;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSubscriberUbi
   Descripcion    : Obtiene la ubicacion geografica de un cliente

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 04/04/2013

   Parametros       Descripcion
   ============     ===================
   inuclient        identificador del cliente
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                          Cambio DAGE_SUBSCRIBER.FNUGETADDRESS_ID por PKG_BCCLIENTE.FNUDIRECCION
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   04/04/2013       Jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSubscriberUbi (inuclient      in ge_subscriber.subscriber_id%type,
                                inuRaiseError  in number default 1
                               ) return ge_geogra_location.geograp_location_id%type is

   /*Declaracion de variables*/
   nuUbication ge_geogra_location.geograp_location_id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSubscriberUbi';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nuUbication := pkg_bcdirecciones.fnugetlocalidad(pkg_bccliente.fnudireccion(inuclient));

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuUbication;

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End FnuGetSubscriberUbi;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSubscriberCate
   Descripcion    : Obtiene la categoria de un cliente

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 04/04/2013

   Parametros       Descripcion
   ============     ===================
   inuclient        identificador del cliente
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio DAAB_ADDRESS.FNUGETESTATE_NUMBER por PKG_BCDIRECCIONES.FNUGETPREDIO
                                          Cambio DAGE_SUBSCRIBER.FNUGETADDRESS_ID por PKG_BCCLIENTE.FNUDIRECCION
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   04/04/2013       Jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSubscriberCate (inuclient      in ge_subscriber.subscriber_id%type,
                                 inuRaiseError  in number default 1
                                ) return categori.catecodi%type is

   /*Declaracion de variables*/
   nuCategory categori.catecodi%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSubscriberCate';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nuCategory := Daab_premise.fnuGetCategory_(pkg_bcdirecciones.fnugetpredio(pkg_bccliente.fnudireccion(inuclient)),NULL);

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuCategory;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End FnuGetSubscriberCate;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSubscriberSubCate
   Descripcion    : Obtiene la subcategoria de un cliente

   Autor          : Jonathan Alberto Consuegra
   Fecha          : 04/04/2013

   Parametros       Descripcion
   ============     ===================
   inuclient        identificador del cliente
   inuraiseError    controlador de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   22/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio DAAB_ADDRESS.FNUGETESTATE_NUMBER por PKG_BCDIRECCIONES.FNUGETPREDIO
                                          Cambio DAGE_SUBSCRIBER.FNUGETADDRESS_ID por PKG_BCCLIENTE.FNUDIRECCION
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   04/04/2013       Jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuGetSubscriberSubCate (inuclient      in ge_subscriber.subscriber_id%type,
                                    inuRaiseError  in number default 1
                                   ) return categori.catecodi%type is

   /*Declaracion de variables*/
   nuSubCategory subcateg.sucacodi%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSubscriberSubCate';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nuSubCategory := Daab_premise.fnuGetSubcategory_(pkg_bcdirecciones.fnugetpredio(pkg_bccliente.fnudireccion(inuclient)),NULL);

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nuSubCategory;

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End FnuGetSubscriberSubCate;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetlegalizeorderbysubsidy
   Descripcion    : obtener la cantidad de ordenes legalizadas
                    asociadas a un subsidio.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 08/05/2013

   Parametros       Descripcion
   ============     ===================
   inusub           identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio DAOR_ORDER.FNUGETORDER_STATUS_ID por PKG_BCORDENES.FNUOBTIENEESTADO
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   08/05/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetlegalizeorderbysubsidy(inusub ld_subsidy.subsidy_id%type
                                       ) return number is

    nucont number := Ld_Boconstans.cnuCero;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetlegalizeorderbysubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nucont
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusub
     AND   pkg_bcordenes.fnuobtieneestado(l.order_id) = ld_boconstans.cnulegalizeorderstatus;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nucont);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetlegalizeorderbysubsidy;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fsbgetsucadesc
    Descripcion    : Obtiene la descripcion de una subcategoria y
                    en caso de no encontrarla retorna null

    Autor          : jonathan alberto consuegra lara
    Fecha          : 29/05/2013

    Parametros       Descripcion
    ============     ===================
    inucate          identificador de la categoria
    inusuca          identificador de la subcategoria

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas 
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    29/05/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fsbgetsucadesc(inucate       in categori.catecodi%type,
                          inusuca       in subcateg.sucacodi%type,
                          inuRaiseError in number default 1
                         ) return subcateg.sucadesc%type is

    sbsucadesc subcateg.sucadesc%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fsbgetsucadesc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT s.sucadesc
      INTO sbsucadesc
      FROM subcateg s
     WHERE s.sucacate = inucate
     AND   s.sucacodi = inusuca;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return sbsucadesc;

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fsbgetsucadesc;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetsomesuscripc
    Descripcion    : Determina si un cliente tiene amarrado un contrato

    Autor          : jonathan alberto consuegra lara
    Fecha          : 01/06/2013

    Parametros       Descripcion
    ============     ===================
    inuclient        identificador del cliente
    inuRaiseError    controlador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas  
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    01/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsomesuscripc(inuclient     in suscripc.suscclie%type,
                              inuRaiseError in number default 1
                             ) return number is

    nurows number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsomesuscripc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
    INTO   nurows
    FROM   suscripc s
    WHERE  s.suscclie = inuclient;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nurows;

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetsomesuscripc;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetnumasigserv
    Descripcion    : Determina la cantidad de usuarios a los cuales
                     se les asigno un subsidio por poblacion

    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/06/2013

    Parametros       Descripcion
    ============     ===================
    inuubication     identificador de la poblacion

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas  
                                           Cambio DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR  
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    13/12/2013       jrobayo.SAO227371     Se agrega condicion para excluir los subsdios que
                                           fueron reversados.
    03/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetnumasigserv(inuubication in ld_ubication.ubication_id%type
                            ) return number is

    nurows number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetnumasigserv';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
    INTO   nurows
    FROM   ld_asig_subsidy l
    WHERE  l.ubication_id = inuubication
    AND l.state_subsidy <> pkg_bcld_parameter.fnuobtienevalornumerico('SUB_REVERSED_STATE');

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return nurows;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetnumasigserv;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetdifesapebyconc
    Descripcion    : Determina la cantidad de usuarios a los cuales
                     se les asigno un subsidio por poblacion

    Autor          : jonathan alberto consuegra lara
    Fecha          : 03/06/2013

    Parametros       Descripcion
    ============     ===================
    inuubication     identificador de la poblacion

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas 
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    03/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetdifesapebyconc(inususcodi    in suscripc.susccodi%type,
                                inunuse       in servsusc.sesunuse%type,
                                inuconc       in diferido.difeconc%Type,
                                inuRaiseError in number default 1
                               ) return diferido.difesape%type is

    nudifesape diferido.difesape%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetdifesapebyconc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT Nvl(SUM(nvl(d.difesape, 0)), 0) difesape
    INTO   nudifesape
    FROM   diferido d
    WHERE  d.difesape > 0
    AND    d.difesusc = inususcodi
    AND    d.difenuse = inunuse
    AND    d.difeconc = inuconc;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return (nudifesape);

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetdifesapebyconc;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetctacobbysub
    Descripcion    : Obtiene la cuenta de cobro asociada al cargo
                     credito por el concepto de aplicacion del
                     subsidio

    Autor          : jonathan alberto consuegra lara
    Fecha          : 06/06/2013

    Parametros       Descripcion
    ============     ===================
    inunuse          identificador del servicio suscrito
    inuconc          identificador del concepto

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas    
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    27-11-2013       hjgomez.SAO225106     Se retorna la ultima cuenta de cobro por fecha
    06/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetctacobbysub(inunuse       in servsusc.sesunuse%type,
                             inuconc       in concepto.conccodi%Type,
                             inuRaiseError in number default 1
                            ) return diferido.difesape%type is

    nuctacbo cuencobr.cucocodi%type;
    tbnuCtacbo pktblcargos.tyCargcuco;
    nuIdx                   binary_integer;
    CURSOR cuCuentaCobro IS
        SELECT c.cargcuco
        FROM   cargos c
        WHERE  c.cargnuse = inunuse
        AND    c.cargconc = inuconc
        ORDER BY cargfecr desc;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetctacobbysub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    open cuCuentaCobro;
        fetch cuCuentaCobro bulk collect INTO tbnuCtacbo;
    close cuCuentaCobro;
    pkg_traza.trace('Cuentas encontradas: '||tbnuCtacbo.count, 10);
    if (tbnuCtacbo.count > 0) then
        nuIdx := tbnuCtacbo.first;

        nuctacbo := tbnuCtacbo(nuIdx);
        pkg_traza.trace('Fin Ld_BcSubsidy.Fnugetctacobbysub. Cuenta Cobro: '||nuctacbo, 10);
        Return (nuctacbo);
    else
        pkg_traza.trace('Fin Ld_BcSubsidy.Fnugetctacobbysub. Cuenta Cobro NULA: ', 10);
        Return null;
    end if;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
       pkg_Error.getError(nuerror, sbError);
       pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
       pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
       raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetctacobbysub;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnugetasigsubbysusc
    Descripcion    : Determina si un suscriptor posee asociado un
                     subsidio

    Autor          : jonathan alberto consuegra lara
    Fecha          : 06/06/2013

    Parametros       Descripcion
    ============     ===================
    inusubdisy       identificador del subsidio
    inususc          identificador del suscriptor

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas    
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    06/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetasigsubbysusc(inusubdisy    in ld_subsidy.subsidy_id%type,
                               inususc       in suscripc.susccodi%Type
                              ) return number is

    nurows number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetasigsubbysusc';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nurows
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id = inusubdisy
       AND l.susccodi   = inususc;


    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return (nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetasigsubbysusc;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetactivesesunuse
   Descripcion    : Obtiene el el servicio suscrito activo de GAS
                    de una suscripcion

   Autor          : jonathan alberto consuegra lara
   Fecha          : 14/12/2012

   Parametros       Descripcion
   ============     ===================
   nususcripc       identificador de la suscripcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   14/12/2012       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetactivesesunuse(inususcripc   in servsusc.sesususc%type,
                                inuRaiseError in number default 1
                               ) return servsusc.sesunuse%type is

    nusesunuse servsusc.sesunuse%type;
    cnuInactiveService constant number := 96;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetactivesesunuse';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT s.sesunuse
    INTO   nusesunuse
    FROM   suscripc b, pr_product a, servsusc s, ps_product_status c
    WHERE  b.susccodi = a.subscription_id
    AND    a.subscription_id   = inususcripc
    AND    a.product_type_id   = ld_boconstans.cnuGasService
    AND    b.susccodi          = s.sesususc
    AND    s.sesunuse          = a.product_id
    AND    s.sesususc          = a.subscription_id
    AND    s.sesuserv          = a.product_type_id --
    AND    (s.sesufere is null OR s.sesufere > sysdate)
    AND    a.product_status_id = c.product_status_id --
    AND    c.is_active_product = 'Y' and c.is_final_status = 'Y'
    AND    s.sesuesco <>  cnuInactiveService
    And    rownum = 1;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nusesunuse);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetactivesesunuse;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuexistactivesubasig
   Descripcion    : Consulta si existen ventas subsidiadas en estado
                    diferente a reversado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/06/2013

   Parametros       Descripcion
   ============     ===================
   inusubsidy       identificador del subsidio

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuexistactivesubasig(inusubsidy ld_subsidy.subsidy_id%type
                                ) return number is

    nurows number := Ld_Boconstans.cnuCero;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuexistactivesubasig';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nurows
      FROM ld_asig_subsidy l
     WHERE l.subsidy_id    =  inusubsidy
     AND   l.state_subsidy <> ld_boconstans.cnuSubreverstate;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnuexistactivesubasig;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetubiactiveasig
   Descripcion    : Determina si existen subsidios asignados a una
                    ubicacion determinada y que no se encuentren
                    en estado inactivo

   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/06/2013

   Parametros       Descripcion
   ============     ===================
   inuubication     identificador de la ubicacion geografica

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetubiactiveasig(inuubication ld_ubication.ubication_id%type
                              ) return number is

    nurows number := Ld_Boconstans.cnuCero;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetubiactiveasig';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nurows
      FROM ld_asig_subsidy l
     WHERE l.ubication_id  =  inuubication
     AND   l.state_subsidy <> ld_boconstans.cnuSubreverstate;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);
  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetubiactiveasig;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubincollectbydate
   Descripcion    : Determina si existen subsidios asignados en
                    estado cobrado para un a?o y mes
                    determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/06/2013

   Parametros       Descripcion
   ============     ===================
   inuubication     identificador de la ubicacion geografica
   inuano           a?o
   inumes           mes

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubincollectbydate(inuubication in ld_ubication.ubication_id%type,
                                    inuano       in number,
                                    inumes       in number
                                   ) return number is

    nurows number := Ld_Boconstans.cnuCero;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubincollectbydate';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   ld_asig_subsidy l
    Where  l.collect_date is not null
    And    l.ubication_id                  = inuubication
    And    to_char(l.collect_date, 'YYYY') = inuano
    And    to_char(l.collect_date, 'MM')   = inumes
    And    l.state_subsidy                 = ld_boconstans.cnucollectstate;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetsubincollectbydate;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubinpaybydate
   Descripcion    : Determina si existen subsidios asignados en
                    estado pagado para un a?o y mes
                    determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 13/06/2013

   Parametros       Descripcion
   ============     ===================
   inuubication     identificador de la ubicacion geografica
   inuano           a?o
   inumes           mes

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   13/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubinpaybydate(inuubication in ld_ubication.ubication_id%type,
                                inuano       in number,
                                inumes       in number
                               ) return number is
                               
    nurows number := Ld_Boconstans.cnuCero;                            

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubinpaybydate';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);

  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   ld_asig_subsidy l
    Where  l.pay_date is not null
    And    l.ubication_id              = inuubication
    And    to_char(l.pay_date, 'YYYY') = inuano
    And    to_char(l.pay_date, 'MM')   = inumes
    And    l.state_subsidy             = ld_boconstans.cnuSubpaystate;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnugetsubinpaybydate;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugettotquantitybysub
    Descripcion    : Obtiene el total de la sumatoria de los
                     conceptos parametrizados para los
                     subsidios de un convenio parametrizado
                     por cantidad

    Autor          : jonathan alberto consuegra lara
    Fecha          : 14/06/2013

    Parametros       Descripcion
    ============     ===================
    inuDEAL_Id       identificador del convenio
    inuRaiseError    manejador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas    
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    14/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnugettotquantitybysub(inuDEAL_Id in LD_deal.DEAL_Id%type,
                                  inuRaiseError in number default 1
                                 ) return number is

    nutotal ld_subsidy.total_deliver%type := ld_boconstans.cnuCero_Value;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnugettotquantitybysub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select Sum( Nvl(Sum(l.subsidy_value), 0) * Nvl((dald_ubication.fnuGetAuthorize_Quantity(l.ubication_id, null)), 0) ) total
    Into   nutotal
    From   ld_subsidy_detail l
    Where  exists (Select 1
                   From   ld_ubication b
                   Where  exists (Select 1
                                  From   ld_subsidy a
                                  Where  a.deal_id = inuDEAL_Id
                                  And    a.subsidy_id = b.subsidy_id
                                  And    a.authorize_quantity is not null
                                )

                   And    b.ubication_id = l.ubication_id
                  )
    Group by l.ubication_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nutotal);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End fnugettotquantitybysub;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbgetfinancingplan
    Descripcion    : Obtiene el plan de financiacion de una
                     solicitud

    Autor          : jonathan alberto consuegra lara
    Fecha          : 14/06/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud
    inuRaiseError    manejador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    14/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fsbgetfinancingplan(inupackage_id in mo_packages.package_id%type
                              ) return varchar2 is

    sbfinancialplan varchar2(1000);

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fsbgetfinancingplan';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select financing_plan_id||' - '||p.pldidesc
    Into   sbfinancialplan
    From   cc_sales_financ_cond c, PLANDIFE p
    Where  c.package_id         = inupackage_id
    And    c.financing_plan_id  = p.pldicodi;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(sbfinancialplan);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      return null;
  End fsbgetfinancingplan;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbgetinstalationtype
    Descripcion    : Obtiene el tipo de instalacion de una
                     solicitud

    Autor          : jonathan alberto consuegra lara
    Fecha          : 14/06/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas  
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    14/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fsbgetinstalationtype(inupackage_id in mo_packages.package_id%type
                                ) return varchar2 is

    sbinstalationtype varchar2(1000);
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fsbgetinstalationtype';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);

  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select decode(install_type, 1, '1-A la vIsta', 2, '2-Empotrado', null) install_type
    Into   sbinstalationtype
    From   mo_gas_sale_data m
    Where  m.package_id = inupackage_id;
   
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(sbinstalationtype);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);      
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      return null;
  End fsbgetinstalationtype;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetsalequotes
    Descripcion    : Obtiene el numero de cuotas de una
                     solicitud

    Autor          : jonathan alberto consuegra lara
    Fecha          : 14/06/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas  
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    14/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnugetsalequotes(inupackage_id in mo_packages.package_id%type
                           ) return cc_sales_financ_cond.quotas_number%type is

    nuquotes cc_sales_financ_cond.quotas_number%type;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnugetsalequotes';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select quotas_number
    Into   nuquotes
    From   cc_sales_financ_cond c
    Where  c.package_id = inupackage_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuquotes);

  Exception
    When pkg_error.controlled_error then
          pkg_Error.getError(nuerror, sbError);
          pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
          pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      return null;
  End fnugetsalequotes;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetinitialquote
    Descripcion    : Obtiene el valor inicial de la cuota de una
                     solicitud

    Autor          : jonathan alberto consuegra lara
    Fecha          : 14/06/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud
    inuRaiseError    manejador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas 
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    14/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fnugetinitialquote(inupackage_id in mo_packages.package_id%type
                             ) return cc_sales_financ_cond.quotas_number%type is

    nuinitialquote cc_sales_financ_cond.quotas_number%type;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnugetinitialquote';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select m.initial_payment
    Into   nuinitialquote
    From   mo_gas_sale_data m
    Where  m.package_id = inupackage_id;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuinitialquote);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);  
      return null;
  End fnugetinitialquote;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbgetcommercialplan
    Descripcion    : Obtiene el plan comercial de una
                     solicitud

    Autor          : jonathan alberto consuegra lara
    Fecha          : 14/06/2013

    Parametros       Descripcion
    ============     ===================
    inupackage_id    identificador de la solicitud

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas    
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    14/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function fsbgetcommercialplan(inupackage_id in mo_packages.package_id%type
                               ) return varchar2 is

    sbcommercialplan varchar2(1000);
    nucommercialplan mo_motive.Commercial_Plan_Id%type;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fsbgetcommercialplan';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    nucommercialplan := damo_motive.fnuGetCommercial_Plan_Id(ld_bcsubsidy.Fnugetmotive(inupackage_id, null),
                                                             null
                                                            );

    if nucommercialplan is not null then
      sbcommercialplan :=  nucommercialplan||'-'||dacc_commercial_plan.fsbGetDescription(nucommercialplan, null);
    else
      return (null);
    end if;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(sbcommercialplan);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      return null;
  End fsbgetcommercialplan;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnususcwithsubsidy
   Descripcion    : Determina si un usuario tiene asignado un
                    subsidio determinado

   Autor          : jonathan alberto consuegra lara
   Fecha          : 15/06/2013

   Parametros       Descripcion
   ============     ===================
   inuubi           Identificador de la poblacion
   inususc          Identificador de la suscripcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   15/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnususcwithsubsidy(inuubi     ld_ubication.ubication_id%type,
                              inususc    suscripc.susccodi%type
                             ) return number is

    nuanswer number := 0;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnususcwithsubsidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);

  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
      INTO nuanswer
      FROM ld_asig_subsidy l
     WHERE l.ubication_id  = inuubi
       AND l.susccodi      = inususc;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuanswer);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnususcwithsubsidy;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnucommonconcepts
   Descripcion    : Determina si existen conceptos en comun entre
                    el plan comercial de la solicitud y una poblacion

   Autor          : jonathan alberto consuegra lara
   Fecha          : 15/06/2013

   Parametros        Descripcion
   ============      ===================
   inucommercialplan Identificador del plan comercial
   inuservice        Identificador del servicio
   inuubication      Identificador de la poblacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   15/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnucommonconcepts(inucommercialplan  mo_motive.commercial_plan_id%type,
                             inuservice         servsusc.sesuserv%type,
                             inuubication       ld_ubication.ubication_id%type
                            ) return number is

    nuanswer number := 0;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnucommonconcepts';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
    INTO   nuanswer
    FROM   ld_subsidy_detail l
    WHERE l.ubication_id = inuubication;


    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuanswer);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnucommonconcepts;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuaccountwithdebt
   Descripcion    : Determina si existen cuentas de cobro que
                    tengan saldo pendiente

   Autor          : jonathan alberto consuegra lara
   Fecha          : 17/06/2013

   Parametros        Descripcion
   ============      ===================
   inususcripc       Identificador del suscriptor
   inuRaiseError     Manejador de excepcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas    
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   17/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuaccountwithdebt(inususcripc   in suscripc.susccodi%type,
                              inuRaiseError in number default 1
                             ) return number is

    nuanswer number := 0;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuaccountwithdebt';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
    INTO   nuanswer
    FROM   cuencobr c, factura f
    WHERE  c.cucofact = f.factcodi
    AND    f.factsusc = inususcripc
    AND    c.cucosacu > ld_boconstans.cnuCero_Value;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuanswer);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnuaccountwithdebt;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuDeferredDebt
   Descripcion    : Determina si un contrato posee deuda diferida
                    para los conceptos asociados a una poblacion
                    subsidiada y un plan comercial
                    determinado.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/06/2013

   Parametros        Descripcion
   ============      ===================
   inususcripc       Identificador del suscriptor
   inucommercialplan Plan comercial
   inuubication      Poblacion subsidiada
   inunuse           Servicio suscrito (Producto)
   inuRaiseError     Manejador de excepcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function FnuDeferredDebt(inususcripc       in suscripc.susccodi%type,
                           inucommercialplan in mo_motive.commercial_plan_id%type,
                           inuubication      in ld_ubication.ubication_id%type,
                           inunuse           in servsusc.sesunuse%Type,
                           inuRaiseError     in number default 1
                          ) return number is

    nuanswer number := 0;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuDeferredDebt';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
    INTO   nuanswer
    FROM   ld_subsidy_detail l, diferido d
    --
    WHERE   d.difeconc     = l.conccodi
    AND    l.ubication_id = inuubication
    AND    d.difesape     > ld_boconstans.cnuCero_Value
    ANd    d.difesusc     = inususcripc
    AND    d.difenuse     = inunuse;
    --

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuanswer);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End FnuDeferredDebt;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnugetsubconcremvalue
   Descripcion    : Determina el valor a subsidiar para un concepto
                    digitado desde la forma LDREM (Asignacion
                    remanente de subsidios).

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/06/2013

   Parametros        Descripcion
   ============      ===================
   inuconcepto       Identificador del concepto
   inuubication      Poblacion subsidiada
   inusesion         Sesion de usuario
   inuRaiseError     Manejador de excepcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnugetsubconcremvalue(inuconcepto     in diferido.difeconc%type,
                                 inuubication    in ld_ubication.ubication_id%type,
                                 inusesion       in number,
                                 inuRaiseError   in number default 1
                                ) return ld_concepto_rem.asig_value%type is

    nuvalue ld_concepto_rem.asig_value%type;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnugetsubconcremvalue';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT a.asig_value
    INTO   nuvalue
    FROM   (SELECT l.asig_value
            FROM   ld_concepto_rem l
            WHERE  l.concepto_rem_id = inuconcepto
            AND    l.ubication_id    = inuubication
            AND    l.sesion          = inusesion
            ORDER BY l.create_date
           ) a
    WHERE rownum = ld_boconstans.cnuonenumber;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuvalue);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      raise pkg_error.controlled_error;
    When others then
      if inuRaiseError = 1 then
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;
      else
        pkg_error.seterror;
        pkg_Error.getError(nuerror, sbError);
        pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        return null;
      end if;
  End Fnugetsubconcremvalue;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuconcremainsub
   Descripcion    : Determina si se almacenaron conceptos
                    a subsidiar en la entidad LD_CONCEPTO_REM.

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/06/2013

   Parametros        Descripcion
   ============      ===================
   inusesion         Sesion de usuario

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuconcremainsub(inusesion in number
                           ) return number is
    nurows number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuconcremainsub';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    SELECT count(1)
    INTO   nurows
    FROM   LD_CONCEPTO_REM l
    WHERE  l.sesion = inusesion;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnuconcremainsub;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnuuserstoapplysubremain
   Descripcion    : Determina si existen usuarios a los
                    cuales se les aplicara el remanente
                    de un subsidio

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/06/2013

   Parametros        Descripcion
   ============      ===================
   inusesion         Sesion de usuario

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnuuserstoapplysubremain(inusesion    in number,
                                    inusubsidy   in ld_subsidy.subsidy_id%type,
                                    inuubication in ld_ubication.ubication_id%type
                                   ) return number is
    nurows number;

    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnuuserstoapplysubremain';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   LD_SUB_REMAIN_DELIV
    Where  sesion         = inusesion
    And    SUBSIDY_ID     = inusubsidy
    And    UBICATION_ID   = inuubication
    And    STATE_DELIVERY = 'D';

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnuuserstoapplysubremain;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnupackagesbyuser
   Descripcion    : Determina si una solicitud esta asociada a un
                    suscriptor

   Autor          : jonathan alberto consuegra lara
   Fecha          : 18/06/2013

   Parametros        Descripcion
   ============      ===================
   inupackages       Solicitud de venta
   inususcripc       Suscripcion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnupackagesbyuser(inupackages in mo_packages.package_id%type,
                             inususcripc in suscripc.susccodi%type
                            ) return number is
    nurows number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnupackagesbyuser';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
    
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   mo_motive m
    Where  m.package_id      = inupackages
    And    m.subscription_id = inususcripc;


    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnupackagesbyuser;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnudetailconceptsbyubi
   Descripcion    : Determina si existen conceptos configurados
                    para una poblacion determinada

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/06/2013

   Parametros        Descripcion
   ============      ===================
   inuubication      identificador de la poblacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnudetailconceptsbyubi(inuubication ld_ubication.ubication_id%type
                                 ) return number is
    nurows number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnudetailconceptsbyubi';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   ld_subsidy_detail l
    Where  l.ubication_id = inuubication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnudetailconceptsbyubi;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnusubbyubimeet
   Descripcion    : Determina si existen subsidios asociados a
                    una poblacion cuya solicitud este atendida

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/06/2013

   Parametros        Descripcion
   ============      ===================
   inuSubsidyId      Identificador del subsidio
   inuUbicationId    Identificador de la poblacion
   inupackagesstatus Estado solicitud atendida

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR.
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnusubbyubimeet(inuSubsidyId      in ld_subsidy.subsidy_id%type,
                           inupackagesstatus in mo_packages.motive_status_id%type
                          ) return number is
    nuRows number := 0;

    CURSOR cuCountSubsidies(inuSubId in ld_subsidy.subsidy_id%type,
                            inuPackStatus in mo_packages.motive_status_id%type) IS
    SELECT count(1)
    FROM /*+Ld_BcSubsidy.Fnusubbyubimeet*/Ld_Asig_Subsidy a, mo_packages m
    WHERE a.package_id = m.package_id
    AND a.Subsidy_Id = inuSubId
    AND m.motive_status_id = inuPackStatus
    AND a.State_Subsidy <> ld_boconstans.cnuSubreverstate
    AND a.Type_Subsidy != 'RE';
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnusubbyubimeet';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    if cuCountSubsidies%isopen then
        close cuCountSubsidies;
    END if;

    open cuCountSubsidies(1,2);
        fetch cuCountSubsidies INTO nuRows;
    close cuCountSubsidies;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nuRows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnusubbyubimeet;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnurowstoapplyremain
   Descripcion    : Determina si existen registros en estado
                    distribuir para una sesion y poblacion
                    determinada

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/06/2013

   Parametros        Descripcion
   ============      ===================
   inusesion         Sesion de usuario
   inuubication      Identificador de la poblacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas   
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnurowstoapplyremain(inusesion    in number,
                                inuubication in ld_ubication.ubication_id%type
                               ) return number is
    nurows number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnurowstoapplyremain';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);

  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   LD_SUB_REMAIN_DELIV l
    Where  l.sesion         = inusesion
    And    l.UBICATION_ID   = inuubication
    And    l.state_delivery = 'D';

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnurowstoapplyremain;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Fnurowsinsimulation
   Descripcion    : Determina si existen registros en estado
                    simulacion para una sesion y poblacion
                    determinada

   Autor          : jonathan alberto consuegra lara
   Fecha          : 19/06/2013

   Parametros        Descripcion
   ============      ===================
   inusesion         Sesion de usuario
   inuubication      Identificador de la poblacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   19/06/2013       jconsuegra.SAO156577  Creacion
  ******************************************************************/
  Function Fnurowsinsimulation(inusesion    in number,
                               inuubication in ld_ubication.ubication_id%type
                              ) return number is
    nurows number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'Fnurowsinsimulation';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

    Select count(1)
    Into   nurows
    From   LD_SUB_REMAIN_DELIV l
    Where  l.sesion         = inusesion
    And    l.UBICATION_ID   = inuubication
    And    l.state_delivery = 'S';

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Return(nurows);

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  End Fnurowsinsimulation;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuValTotalDeal
    Descripcion    : Valida si la sumatoria de los subsidios supera el valor
                     total del convenio.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 12/09/2013

    Parametros       Descripcion
    ============     ===================
    inuubi_id        identificador de la ubicacion geografica

    Historia de Modificaciones
    Fecha            Autor                  Modificacion
    =========        =========              ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas 
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                           Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    12/09/2013       JCarmona              SAO213591 Creacion
    ******************************************************************/
    Function fnuValTotalDeal
    (
        inuubi_id ld_ubication.ubication_id%type
    )
    return number
    IS
        --nutotquantity           ld_max_recovery.total_sub_recovery%type := ld_boconstans.cnuCero_Value;
        nuIdx                   number;
        nuIdx2                  number;
        nuvaltot                ld_subsidy_detail.subsidy_value%type;
        nuSumTotalPoblacion     number;
        nuSumTotalConvenio      number;
        nuDealId                ld_deal.deal_id%type;
        nuTotalValue            ld_deal.total_value%type;
        nuValConcXCant          number;

        CURSOR cuDeal
        (
            nuUbicationId   ld_subsidy_detail.ubication_id%type
        )
        IS
            SELECT  d.deal_id, d.total_value
            FROM    ld_deal d,
                    ld_subsidy s,
                    ld_ubication u,
                    ld_subsidy_detail sd
            WHERE   u.ubication_id = nuUbicationId
            AND     u.subsidy_id = s.subsidy_id
            AND     s.deal_id = d.deal_id
            AND     rownum = 1;

        CURSOR cuSubsidy
        (
            nuDealId   ld_deal.deal_id%type
        )
        IS
            SELECT  *
            FROM    ld_subsidy s
            WHERE   s.deal_id = nuDealId;

        CURSOR cuUbication
        (
            nuSubsidyId   ld_subsidy.subsidy_id%type
        )
        IS
            SELECT  *
            FROM    ld_ubication u
            WHERE   u.subsidy_id = nuSubsidyId;

        type tblSubsidy IS table of ld_subsidy%rowtype;
        type tblUbication IS table of ld_ubication%rowtype;

        tbSubsidy tblSubsidy;
        tbUbication tblUbication;
        
        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuValTotalDeal';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_traza.trace('inuubi_id ['||inuubi_id||']', 1);

        -- Se obtiene el convenio
        open cuDeal(inuubi_id);
            fetch cuDeal INTO nuDealId, nuTotalValue;
        close cuDeal;

        pkg_traza.trace('nuDealId: '||nuDealId, 1);

        -- Se obtienen los subsidios del convenio
        open cuSubsidy(nuDealId);
            fetch cuSubsidy bulk collect INTO tbSubsidy;
        close cuSubsidy;

        nuSumTotalConvenio := 0;
        -- Se recorren los subsidios
        nuIdx := tbSubsidy.first;
        while nuIdx IS not null loop
            pkg_traza.trace('Subsidio: '||tbSubsidy(nuIdx).subsidy_id, 2);

            -- Se obtienen las poblaciones de cada subsidio
            open cuUbication(tbSubsidy(nuIdx).subsidy_id);
                fetch cuUbication bulk collect INTO tbUbication;
            close cuUbication;

            nuSumTotalPoblacion := 0;
            -- Se recorren los subsidios
            nuIdx2 := tbUbication.first;
            while nuIdx2 IS not null loop
                pkg_traza.trace('Ubicacion: '||tbUbication(nuIdx2).ubication_id||' - '||tbUbication(nuIdx2).authorize_quantity, 3);
                -- Se obtiene la sumatoria de valores autorizados para los conceptos de la poblacion
                nuvaltot := NVL(ld_bcsubsidy.fnutotalvalconc(tbUbication(nuIdx2).ubication_id), ld_boconstans.cnuCero_Value);
                pkg_traza.trace('Sumatoria de los conceptos: '||nuvaltot, 3);
                nuValConcXCant := nuvaltot * NVL(tbUbication(nuIdx2).authorize_quantity, ld_boconstans.cnuCero_Value);
                pkg_traza.trace('Sumatoria Por poblacion: '||nuValConcXCant, 3);

                nuSumTotalPoblacion := nuSumTotalPoblacion + nuValConcXCant;

                nuIdx2 := tbUbication.next(nuIdx2);
            END loop;

            nuSumTotalConvenio := nuSumTotalConvenio + nuSumTotalPoblacion;

            nuIdx := tbSubsidy.next(nuIdx);
        END loop;

        pkg_traza.trace('Sumatoria de todas las poblaciones: '||nuSumTotalConvenio, 2);
        pkg_traza.trace('Valor Total del Convenio: '||nuTotalValue, 2);

        -- Se valida que la sumatoria los subsidios no supere el valor total del convenio
        if nuSumTotalConvenio <= nuTotalValue then
            pkg_traza.trace('Fin Ld_BcSubsidy.fnuValTotalDeal['||ld_boconstans.cnuonenumber||']', 1);
            return ld_boconstans.cnuonenumber;
        else
            pkg_traza.trace('Fin Ld_BcSubsidy.fnuValTotalDeal['||ld_boconstans.cnuCero||']', 1);
            return ld_boconstans.cnuCero;
        END if;
    
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    
    Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
    End fnuValTotalDeal;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuGetPackAsso
    Descripcion    : Obtiene los valores del lote agrupador para la venta de gas.

    Autor          : John Wilmer Robayo Sanchez
    Fecha          : 12/09/2013

    Parametros       Descripcion
    ============     ===================
    inuPackage       Numero de solicitud

    Historia de Modificaciones
    Fecha            Autor                  Modificacion
    =========        =========              ====================
    26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                           Se aplican pautas técnicas  
                                           Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                           Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
    29-oct-2013 AecheverrySAO221516     se modifica para obtener la solicitud
                                        de lote asociada al paquete y no la primera que encuentre
    26/09/2013  jrobayo.SAO217696       Creacion
    ******************************************************************/
    FUNCTION fnuGetPackAsso
    (
        inuPackage in mo_packages.package_id%type
    ) return number

    IS
        cnuPackTypeLote ps_package_type.package_type_id%type := 284;

        CURSOR cbPackAsso
        IS
        SELECT  /*+ index(a FK_MO_PACKAGE_MO_PACKAGE01) */
            a.package_id_asso PACKAGE_ID
        FROM  mo_packages_asso a, mo_packages p
            WHERE  a.package_id = inuPackage
            AND p.package_id = a.package_id_asso
            AND p.package_type_id = cnuPackTypeLote;

        nuPackAsso mo_packages_asso.package_id_asso%type;
        
        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuGetPackAsso';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
        open cbPackAsso;
        fetch cbPackAsso INTO nuPackAsso;
        close cbPackAsso;
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        return nuPackAsso;
    EXCEPTION
            when pkg_error.controlled_error then
                if(cbPackAsso%isopen) then
                    close cbPackAsso;
                end if;
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
                pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
                raise pkg_error.controlled_error;
            when others then
                if(cbPackAsso%isopen)then
                    close cbPackAsso;
                END if;
                pkg_error.seterror;
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
                pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
                raise pkg_error.controlled_error;
    END fnuGetPackAsso;

    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : GetSubSidy
    Descripcion    : Accede a la tabla de subsidios para extraer un subsidio
    Autor          : Angelo Nieto Triana(anieto)
    Fecha          : 19/11/2013

    Parametros             Descripcion
    ============           ======================================================
    isbDescription         Descripcion del subsidio
    inuDealId              identificador del convenio
    idtInitialDate         Inicio de la vigencia del subsidio.
    idtFinalDate           Fin de la vigencia del subsidio.
    idtStatDate            Fecha a partir de la cual se podra iniciar el cobro de
                           un subsidio determinado
    inuConceptId           Concepto con el cual se crearan los cargos credito del
                           subsidio otorgado
    ocuSubsidy             registro del subsidio.
    Historia de Modificaciones
    Fecha            Autor           Modificacion
    ============  =================  ============================================
    26/03/2024       pacosta              OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio PKCONSTANTE.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
    19/11/2013    anietoSAO223767    1 - Creacion. Extraccion de un registro de
                                         la tabla ld_subsidy.
  *******************************************************************************/
  PROCEDURE GetSubSidy(isbDescription IN  ld_subsidy.description%TYPE,
                       inuDealId      IN  ld_subsidy.deal_id%TYPE,
                       idtInitialDate IN  ld_subsidy.initial_date%TYPE,
                       idtFinalDate   IN  ld_subsidy.final_date%TYPE,
                       idtStartDate   IN  ld_subsidy.star_collect_date%TYPE,
                       inuConceptId   IN  ld_subsidy.conccodi%TYPE,
                       ocuSubsidy     OUT constants_per.tyrefcursor)
  IS
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'GetSubSidy';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  Begin

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

      OPEN  ocuSubsidy FOR
      SELECT
      *
      /*+ Ld_BcSubsidy.GetSubSidy SAO223767 */
      FROM ld_subsidy ls
      WHERE
          ls.description       = isbDescription
      AND ls.deal_id           = inuDealId
      AND ls.initial_date      = idtInitialDate
      AND ls.final_date        = idtFinalDate
      AND ls.star_collect_date = idtStartDate
      AND ls.conccodi          = inuConceptId
      ORDER BY ls.initial_date;
    
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END GetSubSidy;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  frcAvlbleSubsidyByLoc
    Descripcion :  Obtiene el subsidio disponible por ubicacion geografica,
                   categoria y subcategoria.

    Autor       :  Santiago Gomez Rico
    Fecha       :  06-12-2013
    Parametros  :  inuPromo         Promocion.
                   idtReqDate       Fecha solicitud venta (TRUNCADA).
                   inuAddress       Direccion.
                   inuCateg         Categoria
                   inuSubCateg      Subcategoria.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    26/03/2024       pacosta              OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    06-12-2013       sgomez               SAO226500 Creacion.
    ***************************************************************/
    FUNCTION frcAvlbleSubsidyByLoc
    (
        inuPromo    in  ld_subsidy.promotion_id%type,
        idtReqDate  in  ld_subsidy.initial_date%type,
        inuAddress  in  ab_address.address_id%type,
        inuCateg    in  ld_ubication.sucacate%type,
        inuSubCateg in  ld_ubication.sucacodi%type
    )
        return ld_ubication%rowtype
    IS

        ------------------------------------------------------------------------
        -- Registros
        ------------------------------------------------------------------------

        -- Subsidio por ubicacion
        rcUbication ld_ubication%rowtype;

        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        CURSOR cuAvlbleSub
        (
            inuPromo    in  ld_subsidy.promotion_id%type,
            idtReqDate  in  ld_subsidy.initial_date%type,
            inuAddress  in  ab_address.address_id%type,
            inuCateg    in  ld_ubication.sucacate%type,
            inuSubCateg in  ld_ubication.sucacodi%type
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl(ld_subsidy ld_ubication)
                        index(ld_subsidy UX_LD_SUBSIDY02)
                        index(ab_address PK_AB_ADDRESS)
                        index_rs_asc(ld_ubication UDK_UBICATION01)
                    */
                    ld_ubication.ubication_id,
                    ld_ubication.authorize_value,
                    ld_ubication.total_available,
                    ld_ubication.authorize_value,
                    ld_ubication.authorize_quantity,
                    ld_ubication.total_deliver
            FROM    ld_subsidy,
                    ab_address,
                    ld_ubication /*+ Ld_BcSubsidy.frcAvlbleSubsidyByLoc */
            WHERE   ld_subsidy.promotion_id        = inuPromo
            AND     ld_subsidy.initial_date       <= idtReqDate
            AND     ld_subsidy.final_date         >= idtReqDate
            AND     ab_address.address_id          = inuAddress
            AND     ld_ubication.subsidy_id        = ld_subsidy.subsidy_id
            AND     ab_address.geograp_location_id = ld_ubication.geogra_location_id
            AND     ld_ubication.sucacate          = inuCateg
            AND     ld_ubication.sucacodi          = inuSubCateg;
            
            csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'frcAvlbleSubsidyByLoc';        
            nuError              NUMBER;
            sbError              VARCHAR2 (4000);

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_traza.trace('inuPromo ['||to_char(inuPromo)||']', 10);

        open cuAvlbleSub(inuPromo, idtReqDate, inuAddress, inuCateg, inuSubCateg);
        fetch cuAvlbleSub
        into  rcUbication.ubication_id,
              rcUbication.authorize_value,
              rcUbication.total_available,
              rcUbication.authorize_value,
              rcUbication.authorize_quantity,
              rcUbication.total_deliver;
        close cuAvlbleSub;

        pkg_traza.trace('rcUbication.ubication_id ['||to_char(rcUbication.ubication_id)||']', 10);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        return rcUbication;

    EXCEPTION
        when pkg_error.controlled_error then
            if(cuAvlbleSub%isopen) then
                close cuAvlbleSub;
            end if;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
            raise pkg_error.controlled_error;
        when OTHERS then
            if(cuAvlbleSub%isopen) then
                close cuAvlbleSub;
            end if;
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;
    END frcAvlbleSubsidyByLoc;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuMotPromotionByPack
    Descripcion :  Obtiene el ID de promocion por motivo asociado a la solicitud.

    Autor       :  Santiago Gomez Rico
    Fecha       :  11-12-2013
    Parametros  :  inuPackage       Solicitud de venta.
                   inuPromo         Promocion.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    26/03/2024       pacosta              OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas  
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    11-12-2013   sgomez.SAO227083   Creacion.
    ***************************************************************/
    FUNCTION fnuMotPromotionByPack
    (
        inuPackage  in  mo_motive.package_id%type,
        inuPromo    in  mo_mot_promotion.promotion_id%type
    )
        return mo_mot_promotion.mot_promotion_id%type
    IS

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        /* ID de promocion por motivo */
        nuIDMotPromo    mo_mot_promotion.mot_promotion_id%type;

        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        CURSOR cuMotPromo
        (
            inuPackage  in  mo_motive.package_id%type,
            inuPromo    in  mo_mot_promotion.promotion_id%type
        )
        IS
            SELECT  /*+
                        ordered
                        use_nl(mo_motive mo_mot_promotion)
                        index_rs_asc(mo_motive IDX_MO_MOTIVE_02)
                        index_rs_asc(mo_mot_promotion IDX_MO_MOT_PROMOTION01)
                    */
                    mo_mot_promotion.mot_promotion_id
            FROM    mo_motive,
                    mo_mot_promotion /*+ Ld_BcSubsidy.fnuMotPromotionByPack */
            WHERE   mo_motive.package_id = inuPackage
            AND     mo_motive.motive_id = mo_mot_promotion.motive_id
            AND     mo_mot_promotion.promotion_id = inuPromo;
            
            csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'fnuMotPromotionByPack';        
            nuError              NUMBER;
            sbError              VARCHAR2 (4000);

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        open  cuMotPromo(inuPackage, inuPromo);
        fetch cuMotPromo into nuIDMotPromo;
        close cuMotPromo;

        pkg_traza.trace('nuIDMotPromo ['||to_char(nuIDMotPromo)||']', 10);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        
        return nuIDMotPromo;

    EXCEPTION
        when pkg_error.controlled_error then
            if(cuMotPromo%isopen) then
                close cuMotPromo;
            end if;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
            raise pkg_error.controlled_error;
        when OTHERS then
            if(cuMotPromo%isopen) then
                close cuMotPromo;
            end if;
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;
    END fnuMotPromotionByPack;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FnuGetPackAsig
    Descripcion :  Verifica si existen subsidios asignados para la misma
                   solicitud de venta.

    Autor       :  John Wilmer Robayo
    Fecha       :  17-12-2013
    Parametros  :  inuPackage       Solicitud de venta.
                   inuUbication     Promocion.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    26/03/2024       pacosta        OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                    Se aplican pautas técnicas 
                                    Cambio DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                    Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
    11-12-2013   jrobayo.SAO227491   Creacion.
    ***************************************************************/

    FUNCTION FnuGetPackAsig (inuPackage in mo_packages.package_id%type,
                             inuUbication in ld_ubication.ubication_id%type)
                             return number IS
        nuCode number;
        
        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetPackAsig';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        SELECT
        decode(inuPackage,l.package_id,1,0)
        INTO nuCode
        FROM ld_asig_subsidy l
        WHERE l.ubication_id= inuUbication
        AND l.package_id = inuPackage
        AND state_subsidy <> pkg_bcld_parameter.fnuobtienevalornumerico('SUB_REVERSED_STATE');

         pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        return (nuCode);

    EXCEPTION
        When pkg_error.controlled_error then
          pkg_Error.getError(nuerror, sbError);
          pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
          pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);            
        WHEN others THEN
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            return (0);
    END FnuGetPackAsig;

    /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetCountRem
   Descripcion    : Obtiener el numero total de los subsidios remanentes
                    segun su estado de distribucion.

   Autor          : John Wilmer Robayo
   Fecha          : 18/12/2013

   Parametros       Descripcion
   ============     ===================
   inuState         Estado del remanente (D:Distribuido, P:Procesado)
   inuSubsidy       Id del Subsidio
   inuUbication     Ubicacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/12/2013       jrobayo.SAO227371     Creacion
  ******************************************************************/

    FUNCTION FnuGetCountRem(inuState in ld_sub_remain_deliv.state_delivery%type,
                            inuSubsidy in ld_sub_remain_deliv.subsidy_id%type,
                            inuUbication in ld_sub_remain_deliv.ubication_id%type)
                            return number IS

    nuCantRem number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetCountRem';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);

    BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        SELECT nvl(count(1),0)
        INTO  nuCantRem
        FROM ld_sub_remain_deliv
        WHERE state_delivery = inuState
        AND subsidy_id = inuSubsidy
        AND ubication_id = inuUbication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return nuCantRem;

  Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END FnuGetCountRem;

    /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : FnuGetSumRem
   Descripcion    : Obtiener la suma del valor entregado de los
                    subsidios remanentes segun su estado de distribucion

   Autor          : John Wilmer Robayo
   Fecha          : 18/12/2013

   Parametros       Descripcion
   ============     ===================
   inuState         Estado del remanente (D:Distribuido, P:Procesado)
   inuSubsidy       Id del Subsidio
   inuUbication     Ubicacion

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/03/2024       pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Cambio EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
   18/12/2013       jrobayo.SAO227371     Creacion
  ******************************************************************/
    FUNCTION FnuGetSumRem(inuState in ld_sub_remain_deliv.state_delivery%type,
                            inuSubsidy in ld_sub_remain_deliv.subsidy_id%type,
                            inuUbication in ld_sub_remain_deliv.ubication_id%type)
                            return number IS

    nuSumRem number;
    
    csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'FnuGetSumRem';        
    nuError              NUMBER;
    sbError              VARCHAR2 (4000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        SELECT nvl(sum(delivery_total),0)
        INTO  nuSumRem
        FROM ld_sub_remain_deliv
        WHERE state_delivery = inuState
        AND subsidy_id = inuSubsidy
        AND ubication_id = inuUbication;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    return nuSumRem;

    Exception
    When pkg_error.controlled_error then
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
      raise pkg_error.controlled_error;
    When others then
      pkg_error.seterror;
      pkg_Error.getError(nuerror, sbError);
      pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
    END FnuGetSumRem;

    /**********************************************************************
     Propiedad intelectual de OPEN International Systems
     Nombre              persistSimulation

     Autor                Andres Felipe Esguerra Restrepo

     Fecha               18-dic-2013

     Descripcion         Se encarga de marcar como distribuidos los
                         registros simulados en LDREM

     ***Historia de Modificaciones***
   Fecha            Autor                 Modificacion
   =========        =========             ====================
     26/03/2024     pacosta               OSF-2380 Implementar Gestion de Archivos GDC - Parte 7
                                          Se aplican pautas técnicas 
                                          Cambio USERENV('SESSIONID') por PKG_SESSION.FNUGETSESION
                                          Cambio UT_TRACE.TRACE por PKG_TRAZA.TRACE
     .                                .
    ***********************************************************************/
    PROCEDURE persistSimulation IS

        csbmt_name           CONSTANT VARCHAR2(100) := csbSP_NAME || 'persistSimulation';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        UPDATE ld_subsidy
        SET REMAINDER_STATUS = 'DI'
        WHERE subsidy_id in (
            SELECT subsidy_id
            FROM ld_sub_remain_deliv
            WHERE STATE_DELIVERY = 'S'
            AND sesion = pkg_session.fnugetsesion);

        UPDATE ld_sub_remain_deliv
        SET STATE_DELIVERY = 'D'
        WHERE STATE_DELIVERY = 'S'
        AND sesion = pkg_session.fnugetsesion;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    Exception
        When pkg_error.controlled_error then
          pkg_Error.getError(nuerror, sbError);
          pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, cnuNVLTRC);             
          pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);  
          raise pkg_error.controlled_error;
        When others then
          pkg_error.seterror;
          pkg_Error.getError(nuerror, sbError);
          pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError, cnuNVLTRC);
          pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
          raise pkg_error.controlled_error;
    END persistSimulation;

END Ld_BcSubsidy;
/
