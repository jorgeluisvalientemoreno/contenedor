CREATE OR REPLACE PACKAGE      LD_BOSUBSIDY IS
    /***********************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LD_BOSUBSIDY
    Descripcion    :
    Autor          :
    Fecha          :

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    =========       =================   ================================================
    07-11-2024      Felipe Valencia     OSF-3546: Se modifica el uso del DALD_ubication.getRecord
                                        por DALD_ubication.LockByPkForUpdate y DALD_subsidy.getRecord por
                                        DALD_subsidy.LockByPkForUpdate
    23-05-2017      Sebastian Tapias    Caso 200-1282 || Se modifica el proceso:
                                        -- proFactCCAplicaSub
    17-10-2015      Sandra Mu?oz        ARA8652. Se modifican los procedimientos:
	                                    * proFactCCAplicaSub
										* ApplyRetroSubsidy
    15/01/2015      juancr              se modifica los metodos <Reversesubsidy><AnnulSubsidy>
    22/11/2014      Oscar Restrepo.TEAM3424 se modifica procedimiento <Reversesubsidy>
    27-08-205       Sandra Mu?oz        Ara8190.
                                        * Se crean los procedimientos:
                                          proTrasladaDifACorriente
                                          proConceptoSubsidiado
                                          proDifACteVenta
                                          proFinanciaCtaCobroVenta
                                          proNDSubsidio
                                        * Se modifica el procedimiento
                                          Reversesubsidy
    25/03/2014      JRealpe SAO236359   se modifica procedimiento <ProcAssigSubByForm>
                                        Se instancia producto y plan de facturacion
    24/01/2014      htoroSAO230795      Se modifica el metodo <Reversesubsidy>
    22/01/2014      htoroSAO230487      Se adiciona el metodo <AnnulSubsidy>
                                        Se modifica el metodo <Reversesubsidy>
    18/01/2014      eurbano.SAO229889   Se modifica el metodo <Reversesubsidy>
    18-Ene-2014     AEcheverrySAO229887  se modifica <<ProcGenlettertopotential>>
    09/01/2013}4    AEcheverrySAO228431 se adicionan los metodos <<ValidateSubsidyProm>>
                                        y <<setValidateSubsidy>>
    17-12-2013      jrobayo.SAO227491   Se modifica el metodo <<Fnugetmaxsubvalue>>
    13-12-2013      hjgomez.SAO227259   Se modifica <<ApplyRetrosubsidy>>
    10-12-2013      hjgomez.SAO226584   Se modifica <<ApplyRetrosubsidy>>
    09-12-2013      hjgomez.SAO226584   Se cambia la causal por la del parametro cnufacturation_note_subsidy
    05-12-2013      hjgomez.SAO226138   Se modifica <<ProcGenlettertopotential>>
    27-11-2013      hjgomez.SAO225106   Se modifica <<Reversesubsidy>>
    19-11-2013      anietoSAO223767     1 - Nuevo procedimiento <<GetSubSidy>>
    13-11-2013      anietoSAO222835     1 - Se agrega la validacion del convenido para la
                                            lectura de archivo plano.
                                            <<FblInsSubsidy>>.
    *************************************************************************************/

    globalnupackage_id  mo_packages.package_id%TYPE;
    globalubication     ld_ubication.ubication_id%TYPE;
    globallocation      Ge_Geogra_Location.Geograp_Location_Id%TYPE;
    globalcategory      Subcateg.Sucacate%TYPE;
    globalsubcategory   Subcateg.Sucacodi%TYPE;
    globalretrosubvalue ld_subsidy.authorize_value%TYPE;
    globalsubsidy       ld_subsidy.subsidy_id%TYPE;
    globalclSubsidy     CLOB;
    globalsbTemplate    ed_confexme.coempadi%TYPE;
    globalclient        ge_subscriber.subscriber_id%TYPE;
    globalsesion        NUMBER;
    globalrecordcollect ld_asig_subsidy.record_collect%TYPE;
    sboldsubdesc        ld_subsidy.description%TYPE;
    globalasigsub       VARCHAR(1);
    globaltransfersub   VARCHAR(1);
    globaladdressId     ab_address.address_id%TYPE;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LD_BOSUBSIDY
    Descripcion    : Objeto de negocio que tiene los Metodos el manejo
                     de subsidios del producto GAS

    Autor          : Jonathan Alberto Consuegra Lara
    Fecha          : 17/09/2012

    Historia de Modificaciones
    Fecha             Autor                 Metodos
    =========         =========             ===================
    28/10/2013       jrobayo.SAO221447      Se modifica el metodo <Assignsubsidy>
    15/10/2013       jrobayo.SAO219969      Se modifica el metodo <Fnugetmaxsubvalue>
    10/09/2013       mmeusburgger.SAO212354 Se modifican los metodos
                                               - <<Generatebilldata>>
    06/09/2013       hvera.SAO216556        Se modifica el metodo <FblInsSubsidy>
    04/09/2013       hvera.SAO214139        Se crea el metodo <validateConcepts>
                                            Se modifican los metodos <Movesubsidy, fblTransferSubsidy>

    29/08/2013        hvera.SAO213589       Se modifica el metodo <RegistraConceptosRem>

    27/08/2013        hvera.SAO215029       Se modifica el metodo <DeliveryDocumentation>

    17/09/2012        jconsuegra.SAO156577  Creacion
    ******************************************************************/

    -----------------------
    --------------------------------------------------------------------
    -- Variables
    /*Variables de paquete para updatesubsidystate*/
    nuGlobalRecordCollect ld_asig_subsidy.record_collect%TYPE;
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
      Descripcion    : Retorna el SAO con que se realizo la Ultima entrega
      Autor          : jonathan alberto consuegra lara
      Fecha          : 22/09/2012

      Parametros       Descripcion
      ============     ===================
      inuDeal_Id       identificador del convenio

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
      22/09/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetAmount
      Descripcion    : Retorna la cantidad de carracteres existentes en la cadena.

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripcion
      ============           ===================
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/

    FUNCTION FsbGetAmount(isbLine      IN VARCHAR2,
                          isbDelimiter IN VARCHAR2) RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetArray
      Descripcion    : Retorna los datos en un de la linea
                       del archivo en un vector de cadena

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripcion
      ============           ===================
      inuAmount              Cantidad de caracteres
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/

    FUNCTION FsbGetArray(inuAmount    IN NUMBER,
                         isbLine      IN VARCHAR2,
                         isbDelimiter IN VARCHAR2) RETURN ld_boconstans.tbarray;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetString
      Descripcion    : Retorna la cadena de una linea de registro
                       del archivo plano.

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripcion
      ============           ===================
      inuAmount              Cantidad de caracteres
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/

    FUNCTION FsbGetString(inuPosition  IN NUMBER,
                          isbLine      IN VARCHAR2,
                          isbDelimiter IN VARCHAR2) RETURN VARCHAR2;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : INSERT_UPDATE_DEAL
      Descripcion    : Registra y actualiza los datos de un convenio
      Autor          : jonathan alberto consuegra lara
      Fecha          : 17/09/2012

      Parametros       Descripcion
      ============     ===================
      inuDEAL_Id       identificador del convenio

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
      17/09/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Insert_Update_Deal;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnupercentageconcvalue
     Descripcion    : Obtiene el valor porcentual de la tarifa de
                      un concepto
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

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     11/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnupercentageconcvalue(inuconc      concepto.conccodi%TYPE,
                                    inuserv      servicio.servcodi%TYPE,
                                    inucate      categori.catecodi%TYPE,
                                    inusubcate   subcateg.sucacodi%TYPE,
                                    inuubication ge_geogra_location.geograp_location_id%TYPE,
                                    idtfecha     regltari.retafein%TYPE,
                                    inupercen    NUMBER) RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FblInsSubsidy
      Descripcion    : Inserta subidio de un bloque de datos  de
                       un archivo plano

      Autor          : Jorge Valiente
      Fecha          : 12/10/2012

      Parametros             Descripcion
      ============           ===================
      isbSubcidio            Cadena de subsidio
      isbPopulation          Cadena de la Poblacion a aplicar subcidio
      isbConceptsSubsidize   Cadena de conceptos de subsidio
      isbCollectionStops     Cadena de topes de cobre

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FblInsSubsidy(inuCodigoSubsidio        IN ld_subsidy.subsidy_id%TYPE,
                           isbSubcidio              IN VARCHAR2,
                           isbPopulation            IN VARCHAR2,
                           isbconceptssubsidizeline IN VARCHAR2,
                           isbcollectionstopsline   IN VARCHAR2,
                           osbErrorMessage          OUT VARCHAR2)
        RETURN ld_subsidy.subsidy_id%TYPE;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Fnutotdealdistribute
      Descripcion    : Obtiene el total distribuido de un convenio
                       en la parametrizacion de subsidios. Para ello
                       se suma el total de todos los
                       conceptos subsidiados para el convenio mas
                       el total de todos los valores autorizados
                       del convenio.


      Autor          : jonathan alberto consuegra lara
      Fecha          : 18/10/2012

      Parametros             Descripcion
      ============           ===================
      isbSubcidio            Cadena de subsidio
      isbPopulation          Cadena de la Poblacion a aplicar subcidio
      isbConceptsSubsidize   Cadena de conceptos de subsidio
      isbCollectionStops     Cadena de topes de cobre

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
      18/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnutotdealdistribute(inudeal  ld_deal.deal_id%TYPE,
                                  inuserv  servicio.servcodi%TYPE,
                                  idtfecha regltari.retafein%TYPE) RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procconsultdeal
      Descripcion    : Obtiene los convenios parametrizados a partir
                       de una serie de filtros.

      Autor          : jonathan alberto consuegra lara
      Fecha          : 23/10/2012

      Parametros             Descripcion
      ============           ===================
      inuDeal                Codigo del convenio
      idtinicialdate         Fecha de inicio de vigencia del convenio
      idtfinaldate           Fecha de fin de vigencia del convenio
      inudealvalue           Valor del convenio
      inuSponsor             Ente que otorga el dinero
      Orfdeal                Cursor referenciado de convenio

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
      23/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procconsultdeal(inuDeal        ld_deal.deal_id%TYPE,
                              idtinicialdate ld_deal.initial_date%TYPE,
                              idtfinaldate   ld_deal.final_date%TYPE,
                              inudealvalue   ld_deal.total_value%TYPE,
                              inuSponsor     ld_deal.sponsor_id%TYPE,
                              Orfdeal        OUT pkConstante.tyRefCursor);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procconsultsubsidy
      Descripcion    : Obtiene los subsidios parametrizados a partir
                       de una serie de filtros.

      Autor          : jonathan alberto consuegra lara
      Fecha          : 26/10/2012

      Parametros             Descripcion
      ============           ===================
      inuDeal                Codigo del convenio
      inuSubsidy             Codigo del subsidio
      idtinicialdate         Fecha de inicio de vigencia del subsidio
      idtfinaldate           Fecha de fin de vigencia del subsidio
      inuconcep              Concepto de aplicacion
      inuubication           Ubicacion a la cual aplica el subsidio
      inucategori            categoria a la cual aplica el subsidio
      inusubcategori         Subcategoria a la cual aplica el subsidio
      Orfsubsidy             Cursor referenciado de subsidios

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
      26/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procconsultsubsidy(inuDeal        ld_deal.deal_id%TYPE,
                                 inuSubsidy     ld_subsidy.subsidy_id%TYPE,
                                 idtinicialdate ld_subsidy.initial_date%TYPE,
                                 idtfinaldate   ld_subsidy.final_date%TYPE,
                                 idtinicharge   ld_subsidy.star_collect_date%TYPE,
                                 inuconcep      ld_subsidy.conccodi%TYPE,
                                 inuubication   ld_ubication.geogra_location_id%TYPE,
                                 inucategori    ld_ubication.sucacate%TYPE,
                                 inusubcategori ld_ubication.sucacodi%TYPE,
                                 Orfsubsidy     OUT pkConstante.tyRefCursor);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : ProcAssignsubsidy
       Descripcion    : Se encarga de asignar subsidios en sus distintas
                        modalidades
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ProcAssignsubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Assignsubsidy
       Descripcion    : Se encarga de asignar subsidios en sus distintas
                        modalidades
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inuSuscripc      Contrato
       inuPromotion     Promocion
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria
       isbTipSubsi      identificador del tipo de subsidio

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Assignsubsidy(inuSuscriber  ge_subscriber.subscriber_id%TYPE,
                            inuPromotion  cc_promotion.promotion_id%TYPE,
                            inuubication  ge_geogra_location.geograp_location_id%TYPE,
                            inucategory   subcateg.sucacate%TYPE,
                            inusubcateg   subcateg.sucacodi%TYPE,
                            isbTipSubsi   ld_asig_subsidy.type_subsidy%TYPE,
                            inupackage_id mo_packages.package_id%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetmaxsubvalue
       Descripcion    : Obtiene el valor maximo a subsidiar para un cliente
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inupromotion     identificador de la promocion
       inuSubscriber    identificador del cliente
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria
       inuoption        opcion a ejecutar de la regla

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetmaxsubvalue(inupromotion  CC_PROMOTION.Promotion_Id%TYPE,
                               inuSubscriber GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                               inuubication  GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE,
                               inucategory   SUBCATEG.Sucacate%TYPE,
                               inusubcateg   SUBCATEG.Sucacodi%TYPE,
                               Inuoption     NUMBER) RETURN NUMBER;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Movesubsidy
       Descripcion    : Realiza el traslado de subsidios
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inuSuscripc      Contrato
       inuOriginSu      identificador del subsidio origen
       inuOriginDe      identificador del subsidio origen
       inuSubValue      Valor del subsidio

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Movesubsidy(inuasig_subsidy_id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                          inuCurrent         IN NUMBER,
                          inuTotal           IN NUMBER,
                          onuErrorCode       OUT NUMBER,
                          osbErrorMessage    OUT VARCHAR2);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetconcvalue
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
       Fecha            Autor                 Metodos
       =========        =========             ====================
       09/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetconcvalue(inuconc      concepto.conccodi%TYPE,
                             inuserv      servicio.servcodi%TYPE,
                             inucate      categori.catecodi%TYPE,
                             inusubcate   subcateg.sucacodi%TYPE,
                             inuubication ge_geogra_location.geograp_location_id%TYPE,
                             idtfecha     ta_vigetaco.vitcfein%TYPE) RETURN NUMBER;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : FsbConverttobin
       Descripcion    : Transforma un valor numerico en binario
       Autor          : jonathan alberto consuegra lara
       Fecha          : 10/10/2012

       Parametros       Descripcion
       ============     ===================
       inuDeal_Id       identificador del convenio

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       10/10/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION FsbConverttobin(inuValnum IN NUMBER) RETURN VARCHAR2;

    /************************************************************************
    Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetsububication
     Descripcion    : Obtiene la ubicacion geografica a subsidiar
     Autor          : jonathan alberto consuegra lara
     Fecha          : 10/10/2012

     Parametros       Descripcion
     ============     ===================
     inusub           identificador del subsidio
     inuloca          ubicacion geografica
     inucate          categoria
     inusubcate       subcategoria

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     10/10/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetsububication(inusub     ld_subsidy.subsidy_id%TYPE,
                                inuloca    ld_ubication.geogra_location_id%TYPE,
                                inucate    categori.catecodi%TYPE,
                                inusubcate subcateg.sucacodi%TYPE) RETURN NUMBER;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetphonesclient
       Descripcion    : Obtiene los telefonos de un cliente
       Autor          : jonathan alberto consuegra lara
       Fecha          : 22/12/2012

       Parametros       Descripcion
       ============     ===================
       inusubscriber    identificador del cliente

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       22/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetphonesclient(inusubscriber ge_subscriber.subscriber_id%TYPE)
        RETURN VARCHAR2;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : finDaysAble
       Descripcion    : Obtiene la cantidad de dias habiles entre un rando de fechas.
       Autor          : Adolfo Jimenez
       Fecha          : 26/11/2012

       Parametros       Descripcion
       ============     ===================
       inucountry      Pais/Localidad
       idtIni          Fecha inicial
       idtFin          Fecha final

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       26/11/2012       ajimenez.SAO156577    Creacion
    /*************************************************************************/
    FUNCTION fnuGetDaysAble(inucountry IN ge_calendar.country_id%TYPE,
                            idtIni     IN DATE,
                            idtFin     IN DATE) RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fblTransferSubsidy
      Descripcion    : trasladod de subsidio por medio de archivo plano.

      Autor          : Jorge Valiente
      Fecha          : 12/10/2012

      Parametros                  Descripcion
      ============           ===================
      isbLineFile            Linea de archivo plano con el subsidio a trasladar
      osbErrorMessage        Mensaje de inconsistencias

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/
    FUNCTION fblTransferSubsidy(isbLineFile     IN VARCHAR2,
                                osbErrorMessage OUT VARCHAR2) RETURN BOOLEAN;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : DeliveryDocumentation
       Descripcion    : Realiza la validacion de la entrega de documentacion
                        a las ventas con o sin subsidios
       Autor          : Jorge Luis Valiente Moreno
       Fecha          : 05/12/2012

       Parametros                Descripcion
       ============              ===================
       inuasig_subsidy_id        Codigo de subsdio asignado
       inuCurrent                valor numerico
       inuTotal                  valor numerico
       onuErrorCode              valor numerico
       osbErrorMessage           valor numerico

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
    /*************************************************************************/
    PROCEDURE DeliveryDocumentation(inuasig_subsidy_id IN VARCHAR2,
                                    inuCurrent         IN NUMBER,
                                    inuTotal           IN NUMBER,
                                    onuErrorCode       OUT NUMBER,
                                    osbErrorMessage    OUT VARCHAR2);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procbalancesub
       Descripcion    : Balancea los valores de entrega totoal y disponible
                        de un subsidio
       Autor          : jonathan alberto consuegra lara
       Fecha          : 18/12/2012

       Parametros       Descripcion
       ============     ===================
       inusubsidy       Identificador del subsidio
       ircubication     Registro de la ubicacion subsidiada
       inusubvalue      Valor del subsidio
       inuoption        Opcion de funcionalidad. 1: entrega de subsidio
                        2: reversion de subsidios

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       18/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procbalancesub(inusubsidy   ld_subsidy.subsidy_id%TYPE,
                             ircubication dald_ubication.styld_ubication,
                             inusubvalue  ld_subsidy.authorize_value%TYPE,
                             inuoption    NUMBER);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procassigsubinbilling
       Descripcion    : Crear los cargos credito para la asignacion de
                        subsidios de un contrato.
       Autor          : jonathan alberto consuegra lara
       Fecha          : 18/12/2012

       Parametros       Descripcion
       ============     ===================
       inususcripc      Identificador del contrato

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       18/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procassigsubinbilling(inuasig_sub_id ld_asig_subsidy.asig_subsidy_id%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Applysubsidy
       Descripcion    : Se encarga de aplicar los subsidios en sus distintas
                        modalidades
       Autor          : jonathan alberto consuegra lara
       Fecha          : 19/12/2012

       Parametros          Descripcion
       ============        ===================
       ircld_asig_subsidy  registro de tipo ld_asig_subsidy

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       19/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Applysubsidy(ircld_asig_subsidy dald_asig_subsidy.styld_asig_subsidy);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procinssalewithoutsubsidy
       Descripcion    : Se encarga de registrar ventas sin subsidio
       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/12/2012

       Parametros          Descripcion
       ============        ===================
       nupackage_id        identificador de la solicitud de venta

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       20/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procinssalewithoutsubsidy(inupackage_id mo_packages.package_id%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : proccreatedocorder
       Descripcion    : Se encarga crear las ordenes de solicitud de
                        documentos para las ventas
       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/12/2012

       Parametros          Descripcion
       ============        ===================
       inupackage_id       identificador de la solicitud de venta
       inuoption           crear la orden para una actividad especifica.
                           Si es 1, toma la actividad para una venta
                           no subsidiada. Si es 2, toma la actividad
                           para una venta subsidiada
       onuorderid          orden de trabajo creada


       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       20/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE proccreatedocorder(inupackage_id mo_packages.package_id%TYPE,
                                 inuoption     NUMBER,
                                 onuorderid    OUT OR_order.order_id%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procinssubsidyconcept
       Descripcion    : Se encarga de registrar los conceptos subsidiados
                        durante la venta
       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/12/2012

       Parametros          Descripcion
       ============        ===================
       nupackage_id        identificador de la solicitud de venta

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       20/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procinssubsidyconcept(inupackage_id mo_packages.package_id%TYPE,
                                    inuubication  ld_ubication.ubication_id%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetsomeoneubication
       Descripcion    : Determina si a un cliente le corresponde alguno de los
                        subsidios parametrizados
       Autor          : jonathan alberto consuegra lara
       Fecha          : 22/12/2012

       Parametros       Descripcion
       ============     ===================
       inusub           identificador del subsidio
       inuloca          ubicacion geografica
       inucate          categoria
       inusubcate       subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       22/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetsomeoneubication(inusub     ld_subsidy.subsidy_id%TYPE,
                                    inuloca    ld_ubication.geogra_location_id%TYPE,
                                    inucate    categori.catecodi%TYPE,
                                    inusubcate subcateg.sucacodi%TYPE)
        RETURN ld_ubication.ubication_id%TYPE;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetsomeoneubication
       Descripcion    : Determina si a un cliente le corresponde alguno de los
                        subsidios parametrizados
       Autor          : jonathan alberto consuegra lara
       Fecha          : 22/12/2012

       Parametros       Descripcion
       ============     ===================
       inupackage_id    identificador de la solicitud
       inuCurrent       registro actual
       inuTotal         total de registros a procesar
       onuErrorCode     error en el proceso
       osbErrorMessage  mensaje de error en el proceso

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       22/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procassigretrosub(inupackage_id   IN mo_packages.package_id%TYPE,
                                inuCurrent      IN NUMBER,
                                inuTotal        IN NUMBER,
                                onuErrorCode    OUT NUMBER,
                                osbErrorMessage OUT VARCHAR2);

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
     Fecha            Autor                 Metodos
     =========        =========             ====================
     21/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    --Function FrfGenlettertopotential return Constants.tyRefCursor;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Updatesubsidytocollect
     Descripcion    : Actualiza los subsidios en estado generado
                      que tengan documentacion completa a estado
                      por cobrar

     Autor          : jonathan alberto consuegra lara
     Fecha          : 23/12/2012

     Parametros       Descripcion
     ============     ===================
     Orfuserpotencial cursor con los usuarios potenciales

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     23/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Updatesubsidytocollect;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Reversesubsidy
     Descripcion    : Reversa los subsidios asignados.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 17/12/2012

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Identificador del registro de la asignacion de subsidio
     InuActReg            Registro actual
     inuTotalReg          Total de registros a procesar
     onuErrorCode         Codigo de error
     osbErrorMessage      Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     17/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Reversesubsidy(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                             InuActReg          IN NUMBER,
                             inuTotalReg        IN NUMBER,
                             onuErrorCode       OUT NUMBER,
                             osbErrorMessage    OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Penalize
     Descripcion    : Multa a los contratistas que tienen ordenes
                      de documentacion pendientes por legalizar

     Autor          : Jonathan alberto consuegra
     Fecha          : 23/12/2012

     Parametros           Descripcion
     ============         ===================


     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     23/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Penalize;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FBLAssigRetrosubByArchive
     Descripcion    : Aplica el subsidio retroactivo al contrato

     Autor          : Jorge Luis Valiente
     Fecha          : 04/01/2013

     Parametros           Descripcion
     ============         ===================
     isbLineFile          Linea de archivo plano
     osbErrorMessage      Mensaje del posible error de salida

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
    ******************************************************************/
    FUNCTION FBLAssigRetrosubByArchive(isbLineFile     IN VARCHAR2,
                                       inuCurrent      IN NUMBER,
                                       inuTotal        IN NUMBER,
                                       osbErrorMessage OUT VARCHAR2) RETURN BOOLEAN;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Removeretrosubsidy
     Descripcion    : Reversa los subsidios retroactivos asignados
                      si transcurren n cantidad de dias y no se ha
                      legalizado como exitosa la orden de entrega
                      de documentacion.

     Autor          : Jonathan alberto consuegra
     Fecha          : 11/01/2013

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Id de registro de la asignacion de subsidio
     onuErrorCode         Codigo de error
     osbErrorMessage      Mensaje de rrror

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     11/01/2013       jconsuegra.SAO156577     Creacion
    ******************************************************************/
    PROCEDURE Removeretrosubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : updatesubsidystate
     Descripcion    : Proceso que cambia de estados a los subsidios.

     Autor          : Evens Herard Gorut
     Fecha          : 10/01/2013

     Parametros          Descripcion
     ============        ===================
     InuAsig_Subsidy_Id  Identificador de asignacion de subsidios
     InuActReg           Registro actual
     InuTotalReg         Total de registros a procesar
     OnuErrorCode        Codigo de error
     OsbErrorMessage     Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     10/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    PROCEDURE updatesubsidystate(InuAsig_Subsidy_Id ld_asig_subsidy.asig_subsidy_id%TYPE,
                                 InuActReg          NUMBER,
                                 inuTotalReg        NUMBER,
                                 onuErrorCode       OUT NUMBER,
                                 osbErrorMessage    OUT VARCHAR2);
    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : fnuservgasuserconnect
       Descripcion    : Determina si a un contrato le fue instalado el
                        servicio GAS. Si la funcion retorna 0 significa que
                        no le fue instalado. Si la funcion retorna 1,
                        significa que si le fue instalado.

       Autor          : jonathan alberto consuegra lara
       Fecha          : 14/01/2013

       Parametros       Descripcion
       ============     ===================
       inususcodi       identificador del contrato

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       14/01/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION fnuservgasuserconnect(inususcodi suscripc.susccodi%TYPE) RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FblDistrRemainSubsidy
      Descripcion    : Inserta la Distribucion del remanente de un
                       subsidio.

      Autor          : Jorge Valiente
      Fecha          : 14/01/2013

      Parametros                  Descripcion
      ============           ===================
      inuAsigSubsidyId       Cadena de subsidio
      inuUbicationId         Poblacion del subsidio
      inuDeliveryTotal       porcion distribuida del remanente
      inustate_delivery      Estado del remanente del subsidio
      onuErrorCode           Codigo de Error
      osbErrorMessage        Descripcion del Error

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FblDistrRemainSubsidy(inuSubsidyId        IN ld_Subsidy.Subsidy_Id%TYPE,
                                   inValueDistributing IN LD_SUB_REMAIN_DELIV.delivery_total%TYPE,
                                   inustate_delivery   IN LD_SUB_REMAIN_DELIV.state_delivery%TYPE,
                                   onuErrorCode        OUT NUMBER,
                                   osbErrorMessage     OUT VARCHAR2) RETURN BOOLEAN;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Reversesubsidywitoutdoc
     Descripcion    : Reversa los subsidios asignados de forma
                      retroactiva si no se legaliza la orden
                      de entrega de documentacion como exitosa
                      o no se legaliza.

     Autor          : Jonathan Alberto Consuegra
     Fecha          : 15/01/2013

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Identificador de registro de la asignacion
                          de subsidio
     inuRever_cause       Causa de reversion
     onuErrorCode         numero de Error
     osbErrorMessage      Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     15/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Reverseretrosubwithoutdoc;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fdtgetInstallDate
     Descripcion    : Funcion para obtener la fecha de instalacion del producto gas del contrato.

     Autor          : Evens Herard Gorut
     Fecha          : 11/01/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     11/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fdtgetInstallDate(inususcodi    suscripc.susccodi%TYPE,
                               inuRaiseError IN NUMBER DEFAULT 1) RETURN DATE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbVerifiMaxRec
     Descripcion    : Funcion para verificar que el tope definido para
                      una ubicacion dentro de un periodo, para determinar
                      si ha agotadoo no para el periodo actual.

     Autor          : Evens Herard Gorut
     Fecha          : 15/01/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     15/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fsbVerifiMaxRec(inuAsig_Subsidy_Id ld_asig_subsidy.asig_subsidy_id%TYPE)
        RETURN VARCHAR2;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FsbVerifiUbiSub
     Descripcion    : Funcion para verificar que la sumatoria de los
                      subsidios de una Poblacion por A?o y mes, que no
                      superen el tope definido.

     Autor          : Evens Herard Gorut
     Fecha          : 14/01/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     14/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FsbVerifiUbiSub(inuAsig_Subsidy_Id ld_asig_subsidy.asig_subsidy_id%TYPE)
        RETURN VARCHAR2;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnuGetNuSub
     Descripcion    : Obtiene el numero o la sumatoria de los valores
                      de los subsidios asignados a una Poblacion
                      determinada.

     Autor          : Evens Herard Gorut
     Fecha          : 23/01/2013

     Parametros         Descripcion
     ============       ===================
     inuAsig_Subsidy_Id Identificador del subsidio asignado
     inuSubsidy         Identificador del subsidio
     inuUbication       Identificador de la Poblacion
     inuCase            Opcion a implementar
     inuRaiseError      Controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     23/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fnuGetNuSub(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                         inuSubsidy         IN ld_subsidy.subsidy_id%TYPE,
                         inuUbication       IN ld_ubication.ubication_id%TYPE,
                         inuCase            IN NUMBER,
                         inuRaiseError      IN NUMBER DEFAULT 1)
        RETURN ld_subsidy.authorize_value%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnuGetTop
     Descripcion    : Funcion que verifica los topes de un subsidio

     Autor          : Evens Herard Gorut
     Fecha          : 23/01/2013

     Parametros         Descripcion
     ============       ===================
     inuUbication       Identificador de la Poblacion
     inuYear            A?o del tope de cobro evaluado
     inuMonth           Mes del tope de cobro evaluado
     inuCase            Opcion a implementar
     inuRaiseError      Controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     23/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fnuGetTop(inuUbication  IN ld_ubication.ubication_id%TYPE,
                       inuYear       IN ld_max_recovery.year%TYPE,
                       inuMonth      IN ld_max_recovery.month%TYPE,
                       inuCase       IN NUMBER,
                       inuRaiseError IN NUMBER DEFAULT 1)
        RETURN ld_max_recovery.recovery_value%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnusetdataandgettemplate
     Descripcion    : Coloca los valores en memoria para el proceso
                      de extraccion y mezcla y retorna el
                      nombre del report viewer que contiene la
                      plantilla en donde se visualizaron los datos

     Autor          : jonathan alberto consuegra lara
     Fecha          : 25/01/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     25/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnusetdataandgettemplate(inucoempadi ed_confexme.coemcodi%TYPE)
        RETURN ed_confexme.coempadi%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnusetdatainmemory
     Descripcion    : Coloca los valores en memoria para el proceso
                      de extraccion y mezcla y devuelve el clob
                      resultante.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 29/01/2013

     Parametros       Descripcion
     ============     ===================
     inucoempadi      Codigo del formato de FCED

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     29/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnusetdatainmemory(inucoempadi ed_confexme.coemcodi%TYPE) RETURN CLOB;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fsbgettemplate
     Descripcion    : Obtiene la plantilla a mezclar con un
                      reporte hecho en report viewer.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 29/01/2013

     Parametros       Descripcion
     ============     ===================
     inucoempadi      Codigo del formato de FCED

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     29/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fsbgettemplate(inucoempadi ed_confexme.coemcodi%TYPE)
        RETURN ed_confexme.coempadi%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Callapplication
     Descripcion    : Se encarga de llamar a un aplicativo
                      hecho en el framework.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 29/01/2013

     Parametros        Descripcion
     ============      ===================
     isbExecutableName Nombre del aplicativo a instanciar

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     29/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Callapplication(isbExecutableName IN sa_executable.name%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fsbgetdescsubsidyconcept
     Descripcion    : Se encarga de obtener las descripciones de
                      los conceptos a subsidiar para una Poblacion
                      determinada.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 01/02/2013

     Parametros        Descripcion
     ============      ===================
     inuUbication      Identificador de la Poblacion

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     01/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fsbgetdescsubsidyconcept(inuUbication IN ld_subsidy_detail.subsidy_detail_id%TYPE)
        RETURN VARCHAR2;

    PROCEDURE ProcGenlettertopotential;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : procgetallsubsidy
     Descripcion    : Obtiene la Descripcion de todos los
                      subsidios que le apliquen a un cliente
                      y el valor total con la sumatoria
                      de todos ellos a partir de la ubicacion
                      geografica, la categoria y subcategoria
                      del mismo.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 06/02/2013

     Parametros       Descripcion
     ============     ===================
     inusub           Identificador del subsidio
     inuloca          Identificador de la ubicacion geografica
     inucate          Identificador de la categoria
     inusubcate       Identificador de la subcategoria
     osbsubsidydesc   Descripciones de los subsidios
     onuTotalvalue    Sumatoria de los valores de los subsidios

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     06/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE procgetallsubsidy(inusub         ld_subsidy.subsidy_id%TYPE,
                                inuloca        ld_ubication.geogra_location_id%TYPE,
                                inucate        categori.catecodi%TYPE,
                                inusubcate     subcateg.sucacodi%TYPE,
                                osbsubsidydesc OUT VARCHAR2,
                                onuTotalvalue  OUT ld_subsidy.authorize_value%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fclgetglobalclob
     Descripcion    : Obtiene el contenido de los clobs obtenidos
                      durante un proceso de extraccion y mezcla

     Autor          : jonathan alberto consuegra lara
     Fecha          : 07/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     07/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fclgetglobalclob RETURN CLOB;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcExportToPDFFromMem
     Descripcion    :

     Autor          : jonathan alberto consuegra lara
     Fecha          : 07/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     07/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcExportToPDFFromMem(isbsource   VARCHAR2,
                                     isbfilename VARCHAR2,
                                     iclclob     ld_temp_clob_fact.docudocu%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procloadtemplateandclob
     Descripcion    : Obtien la plantilla y el clob
                      de los archivos PDF a generar

     Autor          : jonathan alberto consuegra lara
     Fecha          : 08/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     08/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procloadtemplateandclob(inucoempadi ed_confexme.coemcodi%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Insertbillclob
     Descripcion    : Se encarga de almacenar en la entidad
                      ld_temp_clob_fact los CLOB de las facturas
                      asociadas a una serie de solicitudes de
                      venta subsidiada

     Autor          : jonathan alberto consuegra lara
     Fecha          : 18/02/2013

     Parametros       Descripcion
     ============     ===================
     inumo_packages   Identificador de la solicitud
     inuCurrent       Registro actual
     inuTotal         Total de registros a procesar
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     18/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Insertbillclob(inumo_packages  IN mo_packages.package_id%TYPE,
                             inuCurrent      IN NUMBER,
                             inuTotal        IN NUMBER,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Generatebilldata
     Descripcion    : Acumula la estructura de las facturas
                      de venta almacenadas en la entidad
                      ld_temp_clob_fact para una sesion de usuario
                      determinada

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/02/2013

     Parametros       Descripcion
     ============     ===================
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     19/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Generatebilldata(onuErrorCode    OUT NUMBER,
                               osbErrorMessage OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcExportBillDuplicateToPDF
     Descripcion    : Genera los archivos PDF de los duplicados de
                      factura

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     19/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcExportBillDuplicateToPDF(isbsource   VARCHAR2,
                                           isbfilename VARCHAR2,
                                           iclclob     CLOB);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : SetEventPrint
     Descripcion    : Setea un ejecutable en memoria

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     19/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE SetEventPrint(inunuExecutableId sa_executable.executable_id%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnudebtconcept
     Descripcion    : Obtiene el saldo (deuda corriente + deuda diferida)
                      de un concepto de un contrato (suscripc)

     Autor          : jonathan alberto consuegra lara
     Fecha          : 21/02/2013

     Parametros       Descripcion
     ============     ===================
     inususcripc      identificador del contrato
     inuconcept       identificador del concepto

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     21/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnudebtconcept(inususcripc IN suscripc.susccodi%TYPE,
                            inuconcept  IN concepto.conccodi%TYPE)
        RETURN cargos.cargvalo%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procpresentdeferreconcept
     Descripcion    : Obtiene la deuda corriente y diferida
                      de un concepto de un contrato (suscripc)

     Autor          : jonathan alberto consuegra lara
     Fecha          : 21/02/2013

     Parametros       Descripcion
     ============     ===================
     inususcripc      identificador del contrato
     inuconcept       identificador del concepto
     onupresentvalue  Saldo corriente del concepto
     onudeferredvalue Saldo diferente del concepto

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     21/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procpresentdeferreconcept(inususcripc      IN suscripc.susccodi%TYPE,
                                        inuconcept       IN concepto.conccodi%TYPE,
                                        onupresentvalue  OUT cuencobr.cucosacu%TYPE,
                                        onudeferredvalue OUT cuencobr.cucosacu%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcRemainingApplies
     Descripcion    : Aplica los remanentes generados por LDREM.

     Autor          : Jorge Luis Valiente Moreno
     Fecha          : 21/02/2013

     Parametros       Descripcion
     ============     ===================
     inuconcept       Concepto de aplicacion del subsidio

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
    ******************************************************************/
    PROCEDURE ProcRemainingApplies(onuerror OUT NUMBER,
                                   osberror OUT VARCHAR2);
    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnudebtpresentcuencobr
     Descripcion    : Determina la cuenta de cobro de la deuda
                      corriente de un cliente

     Autor          : jonathan alberto consuegra lara
     Fecha          : 22/02/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     22/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnudebtpresentcuencobr(inususcripc IN suscripc.susccodi%TYPE)
        RETURN cuencobr.cucocodi%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuReturnConcept
     Descripcion    : Obtiene el concepto del subsidio creado

     Autor          : Jorge Valiente
     Fecha          : 24/02/2013

     Parametros       Descripcion
     ============     ===================
     inusubsidy_id    codigo del subsidio para obtener el concepto

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
    ******************************************************************/
    FUNCTION FnuReturnConcept(inusubsidy_id IN ld_subsidy.subsidy_id%TYPE)
        RETURN ld_subsidy.conccodi%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FsbGetProcTypeRemSu
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
     Fecha            Autor                 Metodos
     =========        =========             ====================
     22/02/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FsbGetProcTypeRemSu(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                                 inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                                 inuSession    IN ld_sub_remain_deliv.sesion%TYPE,
                                 inuRaiseError IN NUMBER DEFAULT 1)
        RETURN ld_subsidy.description%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuGetContSubRemSt
     Descripcion    : Obtiene el numero total de los
                      subsidios remanentes por estado.

     Autor          : Evens Herard Gorut
     Fecha          : 22/02/2013

     Parametros       Descripcion
     ============     ===================
     inuSubsidy_id    subsidio
     inuUbication_id  Ubicacion
     inuSession       session de oracle
     inuStateVeri     Estado a consultar
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     22/02/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FnuGetContSubRemSt(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                                inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                                inuStateVeri  VARCHAR2,
                                inuRaiseError IN NUMBER DEFAULT 1) RETURN NUMBER;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuGetValAsigByState
     Descripcion    : Obtiene el valor remanente asignado a los
                      clientes que ya han recibido un subsidio
                      determinado.

     Autor          : Evens Herard Gorut
     Fecha          : 22/02/2013

     Parametros       Descripcion
     ============     ===================
     inuSubsidy_id    subsidio
     inuUbication_id  Ubicacion
     inuSession       session de oracle
     inuStateVeri
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     22/02/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FnuGetValAsigByState(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                                  inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                                  inuStateVeri  VARCHAR2,
                                  inuRaiseError IN NUMBER DEFAULT 1) RETURN NUMBER;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuGetSumSubRemSt
     Descripcion    : Obtiene el valor total de los
                      subsidios remanentes distribuidos por estado.

     Autor          : Evens Herard Gorut
     Fecha          : 23/01/2013

     Parametros       Descripcion
     ============     ===================
     inuSubsidy_id    subsidio
     inuUbication_id  Ubicacion
     inuSession       session de oracle
     inuStateVeri     Estado a Verificar
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     23/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FnuGetSumSubRemSt(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                               inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                               inuStateVeri  VARCHAR2,
                               inuRaiseError IN NUMBER DEFAULT 1)
        RETURN ld_sub_remain_deliv.delivery_total%TYPE;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Proccommercialsegmenpromo
       Descripcion    : Se encarga de realizar la segmentacion comercial de
                        una promocion de tipo subsidio

       Autor          : jonathan alberto consuegra lara
       Fecha          : 13/03/2013

       Parametros       Descripcion
       ============     ===================
       inusubsidyid     identificador del subsidio
       inupromoid       identificador de la promocion
       inuubication     identificador de la Poblacion a subsidiar
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Metodos
       =========        =========             ====================
       13/03/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Proccommercialsegmenpromo(inusubsidyid ld_subsidy.subsidy_id%TYPE,
                                        inupromoid   cc_promotion.promotion_id%TYPE,
                                        inuubication ld_ubication.geogra_location_id%TYPE,
                                        inucategory  ld_ubication.sucacate%TYPE,
                                        inusubcateg  ld_ubication.sucacodi%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetglobalsesion
     Descripcion    : Obtiene la sesion de usuario

     Autor          : jonathan alberto consuegra lara
     Fecha          : 14/03/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     14/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetglobalsesion RETURN NUMBER;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetsalevalue
     Descripcion    : Obtiene el valor de una solicitud de venta

     Autor          : jonathan alberto consuegra lara
     Fecha          : 18/03/2013

     Parametros       Descripcion
     ============     ===================
     inupackages_id   Identificador de la solicitud de venta
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     18/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetsalevalue(inupackages_id IN mo_packages.package_id%TYPE,
                             inuRaiseError  IN NUMBER DEFAULT 1)
        RETURN cuencobr.cucovafa%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procenabledseg
     Descripcion    : Inhabilita las segmentaciones comerciales
                      asociadas a un subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013

     Parametros       Descripcion
     ============     ===================
     inusubsidy       Identificador del subsidio

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procenabledseg(inusubsidy IN ld_subsidy.subsidy_id%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbObCadSep
     Descripcion    : Obtiene la cadena que se encuentra a partir
                      del numero de ocurrencia de un delimitador

     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013

     Parametros       Descripcion
     ============     ===================
     isbCad           Cadena
     isbDel           Delimitador
     inuIn            numero de ocurrencia del delimitador

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbObCadSep(isbCad IN VARCHAR2,
                         isbDel IN VARCHAR2,
                         inuIn  IN NUMBER) RETURN VARCHAR2 DETERMINISTIC;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procdeletepromdetails
     Descripcion    : Elimina los detalles de una promocion

     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013

     Parametros       Descripcion
     ============     ===================
     inupromo         Identificador de la promocion

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procdeletepromdetails(inupromo IN cc_promotion.promotion_id%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbgetremainstatusdesc
     Descripcion    : Obtiene la Descripcion del estado del remanente de
                      un subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 11/04/2013

     Parametros       Descripcion
     ============     ===================
     isbstatus        Estado del remanente de un subsidio

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     11/04/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbgetremainstatusdesc(isbstatus IN VARCHAR2) RETURN VARCHAR2;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fblGasProductInstalled
     Descripcion    : Determina si el producto GAS de un contrato ha
                      sido instalado. Si el servicio retorna TRUE
                      entonces el producto esta instaladado. En caso
                      de retornar FALSE esta pendiente por instalar.


     Autor          : jonathan alberto consuegra lara
     Fecha          : 08/05/2013

     Parametros       Descripcion
     ============     ===================
     inuSubscription  Identificador del contrato

     Historia de Modificaciones
     Fecha            Autor                 Metodos
     =========        =========             ====================
     08/05/2013       jconsuegra.DAA156577  Creacion
    ******************************************************************/
    FUNCTION fnuGasProductInstalled(inuSubscription suscripc.susccodi%TYPE)
        RETURN NUMBER;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnugetsuscbypackages
     Descripcion    : Determina la suscripcion asociada a una solicitud
                      de instalacion.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 28/05/2013

     Parametros       Descripcion
     ============     ===================
     inupackages      Identificador de la solicitud

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     28/05/2013       jconsuegra.DAA156577  Creacion
    ******************************************************************/
    FUNCTION fnugetsuscbypackages(inupackages mo_packages.package_id%TYPE)
        RETURN mo_motive.subscription_id%TYPE;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcAssigSubByForm
      Descripcion    : Registra los subsidios a partir de las promociones
                       de tipo subsidios ingresadas en la venta por
                       formulario

      Autor          : jonathan alberto consuegra lara
      Fecha          : 29/05/2013

      Parametros       Descripcion
      ============     ===================
      inupackages_id   identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      29/05/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcAssigSubByForm(inupackages_id mo_packages.package_id%TYPE);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcgenLetters
      Descripcion    : Genera las cartas para los usuarios potenciales
                       a partir de los CLOBs almacenados en la tabla
                       ld_temp_clob_fact

      Autor          : jonathan alberto consuegra lara
      Fecha          : 01/06/2013

      Parametros       Descripcion
      ============     ===================
      inusession       identificador de la sesion de usuario

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      01/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcgenLetters(inusession  IN NUMBER,
                             isbsource   IN VARCHAR2,
                             isbfilename IN VARCHAR2);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procgetdatesforpackages
      Descripcion    : Obtiene la ubicacion geografica, la categoria y
                       la subcategoria de una solicitud de venta
                       de gas

      Autor          : jonathan alberto consuegra lara
      Fecha          : 01/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta
      onuubication     identificador de la ubicacion geografica
      onucategori      identificador de la categoria
      onusubcategori   identificador de la subcategoria

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      01/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procgetdatesforpackages(inupackage_id  IN mo_packages.package_id%TYPE,
                                      onuubication   OUT ge_geogra_location.geograp_location_id%TYPE,
                                      onucategori    OUT categori.catecodi%TYPE,
                                      onusubcategori OUT subcateg.sucacodi%TYPE);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbActiveSubsidy
      Descripcion    : Determina si un subsidio se encuentra vigente

      Autor          : jonathan alberto consuegra lara
      Fecha          : 02/06/2013

      Parametros       Descripcion
      ============     ===================
      inusubsidy_id    identificador del subsidio

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      02/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION FsbActiveSubsidy(inusubsidy_id IN ld_subsidy.subsidy_id%TYPE)
        RETURN VARCHAR2;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcExportToPDFFromMem
     Descripcion    : Procesa el CLOB para la carta de asignacion
                      retroactiva de subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 07/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     07/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcExportToPDFFromMem(isbsource   VARCHAR2,
                                     isbfilename VARCHAR2);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : GetOriginAccount
      Descripcion    : Se encarga de obtener la cuenta de cobro origen de
                       un diferido

      Autor          : jonathan alberto consuegra lara
      Fecha          : 04/06/2013

      Parametros          Descripcion
      ============        ===================
      inuDeferred         Identificador del diferido
      inuProduct          Identificador del producto(servicio suscrito)
      ionuAccountStatus   Identificador de la factura
      ionuAccount         Identificador de la cuenta de cobro

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      04/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE GetOriginAccount(inuDeferred       IN diferido.difecodi%TYPE,
                               inuProduct        IN servsusc.sesunuse%TYPE,
                               ionuAccountStatus IN OUT factura.factcodi%TYPE,
                               ionuAccount       IN OUT cuencobr.cucocodi%TYPE);

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del procedimiento: proFactCCAplicaSub
    Descripcion:              Busca la factura y cuenta de cobro donde se creo
                              el cargo de signo DB del traslado de diferido

    Parametros de entrada:    * inuSuscriptor: Suscriptor al que se le realiza
                                               el proceso (contrato).

    Parametros de salida:     * onuCuenCobr :  Nro de cuenta de cobro donde se
                                               encuentra el cargo de signo DB
                                               correspondiente al cargo por
                                               conexion
                              * onuFactura:    Numero de factura donde se
                                               encuentra la cuenta de cobro
                                               obtenida en el parametro ?Nro de
                                               cuenta de cobro?

    Autor : Sandra Mu?oz
    Fecha : 19/08/2015. ARA8178

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    23-05-2017   Sebastian Tapias       200-1282 || Se modifica el query que obtiene
                                        la factura y la  cuenta de cobro
                                        Para restringir que solo obtenga un valor
                                        y que sea de la fecha mas reciente.
	17-10-2015   Sandra Mu?oz           ARA8652 - Se agrega el parametro de entrada al
	                                    procedimiento inuConcASubsidiar
    19/08/2015   Sandra Mu?oz           Creacion
    ******************************************************************/
    PROCEDURE proFactCCAplicaSub(inuSuscriptor     suscripc.susccodi%TYPE,
                                 inuConcASubsidiar concepto.conccodi%TYPE,
                                 onuCuenCobr       OUT cuencobr.cucocodi%TYPE,
                                 onuFactura        OUT cuencobr.cucofact%TYPE,
                                 osbError          OUT NUMBER);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ApplyRetrosubsidy
      Descripcion    : Se encarga de aplicar los subsidios asignados en
                       forma retroactiva

      Autor          : jonathan alberto consuegra lara
      Fecha          : 04/06/2013

      Parametros          Descripcion
      ============        ===================
      inuasigsubid        Identificador de asignacion de subsidios

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      04/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ApplyRetrosubsidy(inuasigsubid ld_asig_subsidy.asig_subsidy_id%TYPE,
                                onuError     OUT NUMBER,
                                osbError     OUT VARCHAR2);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetretroubication
       Descripcion    : Obtiene la poblacion subsidiada a partir de la cual
                        se ubicaran los conceptos a subsidiar

       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/06/2013

       Parametros       Descripcion
       ============     ===================
       inupackages_id   identificador de la solicitud,
       inususcripc      identificador de la suscripcion,
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetretroubication(inupackages_id mo_packages.package_id%TYPE,
                                  inususcripc    suscripc.susccodi%TYPE,
                                  inuubication   GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE,
                                  inucategory    SUBCATEG.Sucacate%TYPE,
                                  inusubcateg    SUBCATEG.Sucacodi%TYPE)
        RETURN ld_ubication.ubication_id%TYPE;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : confirmtempubication
       Descripcion    : Guarda y borra datos en la tabla temporal de
                        ubicaciones

       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/06/2013

       Parametros       Descripcion
       ============     ===================
       inuubication     identificador de la ubicacion geografica
       inusesion        identificador de la sesion de usuario
       inuoption        opcion

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE confirmtempubication(iubication_id IN ld_ubication.ubication_id%TYPE,
                                   inusesion     IN NUMBER,
                                   inuoption     IN NUMBER);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetothersububication
       Descripcion    : Obtiene la ubicacion geografica a subsidiar
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inusub           identificador del subsidio
       inuloca          ubicacion geografica
       inucate          categoria
       inusubcate       subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetothersububication(inusub     ld_subsidy.subsidy_id%TYPE,
                                     inuloca    ld_ubication.geogra_location_id%TYPE,
                                     inucate    categori.catecodi%TYPE,
                                     inusubcate subcateg.sucacodi%TYPE,
                                     inusesion  NUMBER) RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : RegisterReversesubsidy
      Descripcion    : Registra el movimiento correspondiente a la
                       reversion de un subsidio.

      Autor          : Jonathan Consuegra
      Fecha          : 16/12/2012

      Parametros           Descripcion
      ============         ===================
      inuAsig_Subsidy_Id   Parametro de entrada: Id de registro de la
                           asignacion de subsidio
      inucausal            Causal de reversion

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      17/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE RegisterReversesubsidy(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                                     inucausal          IN ld_causal.causal_id%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : RegistraConceptosRem
     Descripcion    : Registra los conceptos utilizados por el
                      remanente de subsidio.

     Autor          : Jorge Valiente
     Fecha          : 09/06/2013

     Parametros           Descripcion
     ============         ===================
     concepto_rem_id      CODIDGO DEL CONCEPTO UTILIZADO EN REMANETE DE SUBSIDIO
     ubication_id         CODIGO DE LA UBICACION GEOGRAFICA
     asig_value           VALOR ASIGNADO AL CONCEPTO DEL REMANENTE DE SUBSIDIO
     sesion               CODIGO SESION DEL FUNCIONARIO
     OSBErrorMessage      Mensaje Error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
    ******************************************************************/
    PROCEDURE RegistraConceptosRem(INUconcepto_rem_id IN LD_CONCEPTO_REM.concepto_rem_id%TYPE,
                                   INUubication_id    IN LD_CONCEPTO_REM.ubication_id %TYPE,
                                   INUasig_value      IN LD_CONCEPTO_REM.asig_value %TYPE,
                                   INUsesion          IN LD_CONCEPTO_REM.sesion %TYPE,
                                   ONUErrorCode       OUT NUMBER,
                                   OSBErrorMessage    OUT VARCHAR2);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnugetcategorybypackages
      Descripcion    : Obtiene la categoria de una solicitud de venta
                       de gas

      Autor          : jonathan alberto consuegra lara
      Fecha          : 11/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      11/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fnugetcategorybypackages(inupackage_id IN mo_packages.package_id%TYPE)
        RETURN categori.catecodi%TYPE;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnugetsubcategbypackages
      Descripcion    : Obtiene la subcategoria de una solicitud de
                       venta de gas

      Autor          : jonathan alberto consuegra lara
      Fecha          : 11/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      11/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fnugetsubcategbypackages(inupackage_id IN mo_packages.package_id%TYPE)
        RETURN subcateg.sucacodi%TYPE;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fsbgetConstbyConcept
      Descripcion    : Obtiene el valor de la constante
                       pkBillConst.csbEJECUTA_SOLICITUD

      Autor          : jonathan alberto consuegra lara
      Fecha          : 14/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      14/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbgetConstbyConcept RETURN VARCHAR2;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetindividualsubvalue
       Descripcion    : Obtiene el valor individual de un subsidio
                        para un cliente

       Autor          : jonathan alberto consuegra lara
       Fecha          : 15/06/2013

       Parametros       Descripcion
       ============     ===================
       inupackages_id   identificador de la solicitud,
       inuubication     identificador de la poblacion
       onuerror         codigo de error
       osberrmen        mensaje de error presentado

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       15/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetindividualsubvalue(inupackages_id IN mo_packages.package_id%TYPE,
                                      inuubication   IN ld_ubication.ubication_id%TYPE,
                                      inucate        IN categori.catecodi%TYPE,
                                      inusubcate     IN subcateg.sucacodi%TYPE,
                                      inulocalidad   IN ge_geogra_location.geograp_location_id%TYPE,
                                      onuerror       OUT NUMBER,
                                      osberrmen      OUT VARCHAR2) RETURN NUMBER;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : ApplySubInCurrentDebt
       Descripcion    : Aplica el subsidio remanente a la deuda corriente
                        de los conceptos a subsidiar que esten en comun
                        a los conceptos asociados al plan comercial de
                        la solicitud

       Autor          : jonathan alberto consuegra lara
       Fecha          : 17/06/2013

       Parametros       Descripcion
       ============     ===================


       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       17/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ApplySubInCurrentDebt(ionusubvalue      IN OUT ld_subsidy.authorize_value%TYPE,
                                    inususcripc       IN suscripc.susccodi%TYPE,
                                    inucommercialplan IN mo_motive.commercial_plan_id%TYPE,
                                    inuubication      IN ld_ubication.ubication_id%TYPE,
                                    inutotalremain    IN ld_subsidy.authorize_value%TYPE,
                                    inusesion         IN NUMBER,
                                    inupackage_id     IN mo_packages.package_id%TYPE,
                                    inunuse           IN servsusc.sesunuse%TYPE,
                                    onuerror          OUT NUMBER,
                                    osberrmen         OUT VARCHAR2);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : ApplySubIndeferredDebt
       Descripcion    : Aplica el subsidio remanente a la deuda diferida
                        de los conceptos a subsidiar que esten en comun
                        a los conceptos asociados al plan comercial de
                        la solicitud

       Autor          : jonathan alberto consuegra lara
       Fecha          : 18/06/2013

       Parametros       Descripcion
       ============     ===================


       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       18/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ApplySubIndeferredDebt(ionusubvalue      IN OUT ld_subsidy.authorize_value%TYPE,
                                     inususcripc       IN suscripc.susccodi%TYPE,
                                     inucommercialplan IN mo_motive.commercial_plan_id%TYPE,
                                     inuubication      IN ld_ubication.ubication_id%TYPE,
                                     inutotalremain    IN ld_subsidy.authorize_value%TYPE,
                                     inusesion         IN NUMBER,
                                     inupackage_id     IN mo_packages.package_id%TYPE,
                                     inunuse           IN servsusc.sesunuse%TYPE,
                                     onuerror          OUT NUMBER,
                                     osberrmen         OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetremainsesion
     Descripcion    : Obtiene la sesion de usuario que se usa en el
                      proceso de remanente

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/06/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetremainsesion RETURN NUMBER;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fsbgetestadotecnico
     Descripcion    : Obtiene el estado tecnico de un servicio
                      suscrito

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/06/2013

     Parametros       Descripcion
     ============     ===================
     inunuse          Servicio suscrito

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fsbgetestadotecnico(inunuse servsusc.sesunuse%TYPE)
        RETURN servsusc.sesuesfn%TYPE;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetreverseestate
     Descripcion    : Obtiene el estado reversado de un subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/06/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetreverseestate RETURN ld_subsidy_states.subsidy_states_id%TYPE;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deleteremainsub
       Descripcion    : Borra las simulaciones o distribuciones de la tabla
                        ld_sub_remain_deliv

       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       isbremaintype    tipo de distribucion: S:simulacion, D:distribucion
       inusesion        identificador de la sesion de usuario

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deleteremainsub(isbremaintype IN ld_sub_remain_deliv.state_delivery%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deleteremainconcepts
       Descripcion    : Borra los conceptos de la tabla LD_CONCEPTO_REM


       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       inusesion        identificador de la sesion de usuario

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deleteremainconcepts(inusesion IN NUMBER);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deletetemp_clob_fact
       Descripcion    : Borra los registros de la tabla temp_clob_fact
                        asociados a una sesion de usuario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       inusesion        identificador de la sesion de usuario

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deletetemp_clob_fact(inusesion IN NUMBER);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : fnugetliqbaseconc
       Descripcion    : Obtiene el valor con el cual se esta liquidando un
                        concepto durante el proceso de venta por formulario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 24/06/2013

       Parametros       Descripcion
       ============     ===================
       ircProduct       registro, fila, del producto
       ircBillingPeriod registro, fila, del periodo de facturacion
       inuConcept       identificador del concepto
       inuConsPeriod    identificador del periodo de consumo
       inuPackage_Id    identificador de la solicitud de venta

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       24/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION fnugetliqbaseconc(ircProduct       IN servsusc%ROWTYPE,
                               ircBillingPeriod IN perifact%ROWTYPE,
                               inuConcept       IN concepto.conccodi%TYPE,
                               inuConsPeriod    IN pericose.pecscons%TYPE,
                               inuPackage_Id    IN mo_packages.package_id%TYPE)
        RETURN cargos.cargvalo%TYPE;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deleteremainsimulation
       Descripcion    : Borra los registros de la tabla ld_sub_remain_deliv
                        asociados a una sesion de usuario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       inusesion        identificador de la sesion de usuario
       isbstate         identificador de estado simulacion de remanente

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deleteremainsimulation(inusesion IN NUMBER,
                                     isbstate  IN ld_sub_remain_deliv.state_delivery%TYPE);

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : fnugetremainsub
       Descripcion    : Obtiene el valor remanente de un subsidio

       Autor          : jonathan alberto consuegra lara
       Fecha          : 27/06/2013

       Parametros       Descripcion
       ============     ===================
       inusubsidy       identificador del subsidio

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       27/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION fnugetremainsub(inusubsidy IN ld_subsidy.subsidy_id%TYPE)
        RETURN ld_subsidy.authorize_value%TYPE;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   RegisterPromo
    Descripcion :   Permite crear una promocion para subsidios con un concepto
    asociado.

    Autor       :   ofajardo
    Fecha       :   17-09-2012 10:50:09
    Parametros  :
        isbDescription:     Descripcion que se registara a la promocion.
        inuPromTypeId:      Tipo de Promocion a registrar.
        inuPriorityId:      Prioridad de la promocion.
        inuProdTypeId:      Tipo de Producto al que aplicara la promocion.
        idtInitOfferDate:   Fecha de inicio de oferta de la promocion.
        idtFinalOfferDate:  Fecha de fin de oferta de la promocion.
        inuConceptId:       Identificador del concepto que se le quiere asociar
                            al detalle de la promocion.
        onuPromId:          Identificador de la promocion generada.

    Historia de Modificaciones
    Fecha     IDEntrega               Modificacion
    ==========  ======================= ========================================
    AEcheverry Copia del paquete de producto Creacion.
    ***************************************************************************/
    PROCEDURE RegisterPromo(isbDescription    IN cc_promotion.description%TYPE,
                            inuPromTypeId     IN cc_promotion.prom_type_id%TYPE,
                            inuPriorityId     IN cc_promotion.priority_id%TYPE,
                            inuProdTypeId     IN cc_promotion.product_type_id%TYPE,
                            idtInitOfferDate  IN cc_promotion.init_offer_date%TYPE,
                            idtFinalOfferDate IN cc_promotion.final_offer_date%TYPE,
                            inuConceptId      IN concepto.conccodi%TYPE,
                            onuPromId         OUT NOCOPY cc_promotion.promotion_id%TYPE);

    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : GetSubSidy
    Descripcion    : Accede a la tabla de subsidios para extraer un subsidio
    *******************************************************************************/
    PROCEDURE GetSubSidy(isbDescription IN ld_subsidy.description%TYPE,
                         inuDealId      IN ld_subsidy.deal_id%TYPE,
                         idtInitialDate IN ld_subsidy.initial_date%TYPE,
                         idtFinalDate   IN ld_subsidy.final_date%TYPE,
                         idtStartDate   IN ld_subsidy.star_collect_date%TYPE,
                         inuConceptId   IN ld_subsidy.conccodi%TYPE,
                         ocuSubsidy     OUT pkConstante.tyRefCursor);

    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : ValidateSubsidyProm
    Descripcion    : Realiza las validaciones de los subsidios a asignar
    *******************************************************************************/
    PROCEDURE ValidateSubsidyProm(inuSubscriberId IN suscripc.suscclie%TYPE,
                                  inuproductId    IN pr_product.product_id%TYPE,
                                  inuMotiveId     IN mo_motive.motive_id%TYPE,
                                  inuAddressId    IN ab_address.address_id%TYPE,
                                  inuCategory     IN servsusc.sesucate%TYPE,
                                  inuSubcateg     IN servsusc.sesusuca%TYPE);
    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : setValidateSubsidy
    Descripcion    : Indica si se deben realizar las validaciones en el calculo del valor del subsidio
                       (utilizado en la simulacion de liquidacion de la venta de gas por formulario)
    *******************************************************************************/
    PROCEDURE setValidateSubsidy(iblValue IN BOOLEAN DEFAULT TRUE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : AnnulSubsidy
     Descripcion    : Reversa los subsidios asignados por anulacion de venta
    ******************************************************************/
    PROCEDURE AnnulSubsidy(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                           InuActReg          IN NUMBER,
                           inuTotalReg        IN NUMBER,
                           onuErrorCode       OUT NUMBER,
                           osbErrorMessage    OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de PETI

     Unidad         : fnuGetValsubsidioCartas
     Descripcion    : Permite obtener el valor del subsicio para generar
                      las cartas a usuarios potenciales
     Autor          : Alexandra Gordillo - Optima
     Fecha          : 26-08-14
    ******************************************************************/
    FUNCTION fnuGetValsubsidioCartas(inusub     IN ld_subsidy.subsidy_id%TYPE,
                                     inuloca    IN ld_ubication.geogra_location_id%TYPE,
                                     inucate    IN categori.catecodi%TYPE,
                                     inusubcate IN subcateg.sucacodi%TYPE)
        RETURN NUMBER;

END LD_BOSUBSIDY;
/
CREATE OR REPLACE PACKAGE BODY      LD_BOSUBSIDY IS
    /***********************************************************************************
        Propiedad intelectual de Open International Systems (c).

        Unidad         : LD_BOSUBSIDY
        Descripcion    : Objeto de negocio que tiene los metodos el manejo
                         de subsidios del producto GAS

        Autor          : Jonathan Alberto Consuegra Lara
        Fecha          : 17/09/2012

        Historia de Modificaciones
        Fecha           Autor               Modificacion
        =========       =================   ================================================
        07-11-2024      Felipe Valencia     OSF-3546: Se modifica el uso del DALD_ubication.getRecord
                                            por DALD_ubication.LockByPkForUpdate y DALD_subsidy.getRecord por
                                            DALD_subsidy.LockByPkForUpdate
        23-05-2017      Sebastian Tapias    Caso 200-1282 || Se modifica el proceso:
                                            -- proFactCCAplicaSub
		17-10-2015      Sandra Mu?oz        ARA8652. Se modifican los procedimientos:
	                                        * proFactCCAplicaSub
										    * ApplyRetroSubsidy
        15/01/2015      juancr              se modifica los metodos <Reversesubsidy><AnnulSubsidy>
        22/11/2014      Oscar Restrepo.TEAM3424 se modifica procedimiento <Reversesubsidy>
        27-08-205       Sandra Mu?oz        Ara8190.
                                            * Se crean los procedimientos:
                                              proTrasladaDifACorriente
                                              proConceptoSubsidiado
                                              proDifACteVenta
                                              proFinanciaCtaCobroVenta
                                              proNDSubsidio
                                            * Se modifica el procedimiento
                                              Reversesubsidy
        25/03/2014      JRealpe SAO236359   se modifica procedimiento <ProcAssigSubByForm>
                                            Se instancia producto y plan de facturacion
        28/02/2014      AEcheverry.SAOXXXX  Se modifica el metodo <Fnugetindividualsubvalue>
        24/01/2014      htoroSAO230795      Se modifica el metodo <Reversesubsidy>
        22/01/2014      htoroSAO230487      Se adiciona el metodo <AnnulSubsidy>
                                            Se modifica el metodo <Reversesubsidy>
        18/01/2014      eurbano.SAO229889   Se modifica el metodo <Reversesubsidy>
        18-Ene-2014     AEcheverrySAO229887  se modifica <<ProcGenlettertopotential>>
        09/01/2013}4    AEcheverrySAO228431 se adicionan los metodos <<ValidateSubsidyProm>>
                                            y <<setValidateSubsidy>>
        17-12-2013      jrobayo.SAO227371   Se modifican los metodos para omitir la sesion
                                            <<FnuGetContSubRemSt>>
                                            <<FnuGetValAsigByState>>
                                            <<FnuGetSumSubRemSt>>
        17-12-2013      jrobayo.SAO227491   Se modifica el metodo <<Fnugetmaxsubvalue>>
        13-12-2013      hjgomez.SAO227259   Se modifica <<ApplyRetrosubsidy>>
        11-12-2013      sgomez.SAO227083    Se corrige error de ortografia en varios
                                            mensajes de validacion de traslado de
                                            subsidios.
                                            Se modifica proceso de traslado de subsidio
                                            (individual y masivo) para corregir errores
                                            varios.
        10-12-2013      hjgomez.SAO226584   Se modifica <<ApplyRetrosubsidy>>
        09-12-2013      sgomez.SAO226500    Se adiciona validacion en liquidacion de venta
                                            de gas, en caso de que un subsidio a aplicar
                                            sobrepase el valor restante en una ubicacion,
                                            categoria y subcategoria.
        09-12-2013      hjgomez.SAO226584   Se cambia la causal por la del parametro cnufacturation_note_subsidy
        05-12-2013      sgomez.SAO226167    Se modifica mensaje de excepcion desplegado en el
                                            proceso de Duplicado de factura de venta, cuando
                                            la factura no se ha impreso previamente.
        05-12-2013      hjgomez.SAO226138   Se modifica <<ProcGenlettertopotential>>
        27-11-2013      hjgomez.SAO225106   Se modifica <<Reversesubsidy>>
        19-11-2013      anietoSAO223767     1 - Nuevo procedimiento <<GetSubSidy>>
        13-11-2013      anietoSAO222835     1 - Se agrega la validacion del convenido para la
                                                lectura de archivo plano.
                                            2 - Se agregan las validaciones correspondientes
                                                a la categoria.

                                                <<FblInsSubsidy>>
        17/09/2012        jconsuegra.SAO156577  Creacion
    *************************************************************************************/
    -----------------------
    -- Constants
    -----------------------
    -- Constante con el SAO de la ultima version aplicada
    csbVERSION CONSTANT VARCHAR2(10) := 'OSF-3546';

    csbValidateDealID      VARCHAR2(50) := 'El convenio no existe. ';
    csbRequiredAttribute   VARCHAR2(50) := 'Valor Obligatorio. ';
    csbCateSucate          VARCHAR2(80) := 'La subcategoria no corresponde a la categoria residencial. ';
    csbCategoriValid       VARCHAR2(50) := 'Categoria erronea. Debe ser Residencial. ';
    csbNullDescription     VARCHAR2(80) := 'La descripcion no puede ser nula';
    cnuCategoriResidential NUMBER := 1;
    gblValDataSubsidy      BOOLEAN := TRUE;
    gbProductId            pr_product.product_id%TYPE := NULL;
    /*Tipo Record para datos del saldo de un concepto */
    TYPE rcSubDate IS RECORD(
        subscriber_id ge_subscriber.subscriber_id%TYPE,
        address_id    ab_address.address_id%TYPE,
        ubication     ab_address.geograp_location_id%TYPE,
        category      ab_premise.category_%TYPE,
        subcategory   ab_premise.subcategory_%TYPE);

    rfSusc rcSubDate;

    TYPE rcdebtconcept IS RECORD(
        conceptid     concepto.conccodi%TYPE,
        conceptdesc   concepto.concdesc%TYPE,
        billedvalue   factura.factvaap%TYPE,
        presentvalue  cuencobr.cucosacu%TYPE,
        deferredvalue cuencobr.cucosacu%TYPE);

    tbdebtconcept rcdebtconcept;

    globalclRetroSubsidy CLOB;
    nuubiasigsub         ld_ubication.ubication_id%TYPE;
    globalerrorcode      NUMBER;
    globalerrormens      VARCHAR2(3000);
    globalsuscripc       suscripc.susccodi%TYPE;
    nuswsalebyform       NUMBER := NULL;

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
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        pkErrors.Push('ld_bosubsidy.fsbVersion');
        pkErrors.Pop;
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN(csbVersion);
    END fsbVersion;

    PROCEDURE LegAllactivities(inuOrderId        IN NUMBER,
                               inuCausalId       IN NUMBER,
                               inuPersonId       IN NUMBER,
                               idtExeInitialDate IN DATE,
                               idtExeFinalDate   IN DATE,
                               isbComment        IN VARCHAR2,
                               idtChangeDate     IN OR_order_stat_change.stat_chg_date%TYPE,
                               onuErrorCode      OUT ge_error_log.error_log_id%TYPE,
                               osbErrorMessage   OUT ge_error_log.description%TYPE) IS

        nuOrderCommentId OR_order_comment.order_comment_id%TYPE;

    BEGIN

        IF (isbComment IS NOT NULL) THEN
            OR_BOOrderComment.InsertOrUpdateComment(inuOrderId,
                                                    1,
                                                    isbComment,
                                                    'Y',
                                                    nuOrderCommentId);

        END IF;

        os_legalizeorderallactivities(inuOrderId,
                                      inuCausalId,
                                      inuPersonId,
                                      idtExeInitialDate,
                                      idtExeFinalDate,
                                      NULL, --'Legalizacion por la aplicacion LDCDE',
                                      NULL, --new parameter add for open
                                      onuErrorCode,
                                      osbErrorMessage);
        IF (onuErrorCode <> 0) THEN
            gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);
        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END LegAllactivities;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetAmount
      Descripcion    : Retorna la cantidad de carracteres existentes en la cadena.

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripcion
      ============           ===================
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
    ******************************************************************/

    FUNCTION FsbGetAmount(isbLine      IN VARCHAR2,
                          isbDelimiter IN VARCHAR2) RETURN NUMBER IS

        sbLine VARCHAR2(4000);

    BEGIN

        sbLine := isbLine;

        UT_Trace.Trace('Inicio LD_BOsubsidy.FsbGetAmount', pkg_traza.cnuNivelTrzDef);

        RETURN REGEXP_COUNT(sbLine, '.*?\' || isbDelimiter);

        UT_Trace.Trace('Fin LD_BOsubsidy.FsbGetAmount', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RETURN(-1);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RETURN(-1);
            RAISE pkg_error.CONTROLLED_ERROR;
    END FsbGetAmount;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetArray
      Descripcion    : Retorna los datos en un de la linea
                       del archivo en un vector de cadena

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripcion
      ============           ===================
      inuAmount              Cantidad de caracteres
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
    ******************************************************************/

    FUNCTION FsbGetArray(inuAmount    IN NUMBER,
                         isbLine      IN VARCHAR2,
                         isbDelimiter IN VARCHAR2) RETURN ld_boconstans.tbarray IS

        sbLine      VARCHAR2(4000);
        nuAmount    NUMBER;
        sbDelimiter VARCHAR2(1);
        arString    ld_boconstans.tbarray;
    BEGIN

        sbLine      := isbLine;
        nuAmount    := inuAmount;
        sbDelimiter := isbDelimiter;

        UT_Trace.Trace('Inicio LD_BOsubsidy.FsbGetArray', pkg_traza.cnuNivelTrzDef);

        FOR i IN 1 .. nuAmount LOOP
            arString(i) := regexp_substr(sbLine, '.*?\' || sbDelimiter, 1, i);
            arString(i) := REPLACE(arString(i), sbDelimiter, NULL);
            IF arString(i) = ' ' THEN
                arString(i) := NULL;
            END IF;
        END LOOP;

        RETURN(arString);

        UT_Trace.Trace('Fin LD_BOsubsidy.FsbGetArray', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END FsbGetArray;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetString
      Descripcion    : Retorna la cadena de una linea de registro
                       del archivo plano.

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripcion
      ============           ===================
      inuAmount              Cantidad de caracteres
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FsbGetString(inuPosition  IN NUMBER,
                          isbLine      IN VARCHAR2,
                          isbDelimiter IN VARCHAR2) RETURN VARCHAR2 IS

        sbLine      VARCHAR2(4000);
        nuPosition  NUMBER;
        sbDelimiter VARCHAR2(1);
    BEGIN

        sbLine      := isbLine;
        nuPosition  := inuPosition;
        sbDelimiter := isbDelimiter;

        UT_Trace.Trace('Inicio LD_BOsubsidy.FsbGetString', pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('
		sbLine  ' || sbLine || '
        nuPosition ' || nuPosition || '
        sbDelimiter ' || sbDelimiter,
                       1);

        RETURN regexp_substr(sbLine,
                             '[^' || sbDelimiter || ']+',
                             1,
                             nuPosition);

        UT_Trace.Trace('Fin LD_BOsubsidy.FsbGetString', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            UT_Trace.Trace(SQLERRM, pkg_traza.cnuNivelTrzDef);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            UT_Trace.Trace(SQLERRM, pkg_traza.cnuNivelTrzDef);
            RAISE pkg_error.CONTROLLED_ERROR;
    END FsbGetString;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : INSERT_UPDATE_DEAL
      Descripcion    : Registra y actualiza los datos de un convenio
      Autor          : jonathan alberto consuegra lara
      Fecha          : 17/09/2012

      Parametros       Descripcion
      ============     ===================
      inuDeal_Id       identificador del convenio

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      17/09/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Insert_Update_Deal IS
        --
        cnuNull_Attribute CONSTANT NUMBER := 2126;

        nuDeal_Id      ge_boInstanceControl.stysbValue;
        sbDescription  ge_boInstanceControl.stysbValue;
        dtInitial_Date ge_boInstanceControl.stysbValue;
        dtFinal_Date   ge_boInstanceControl.stysbValue;
        nuTotalvalue   ge_boInstanceControl.stysbValue;
        nuSponsor_Id   ge_boInstanceControl.stysbValue;
        sbDisable_Deal ge_boInstanceControl.stysbValue;
        dtDisable_Date ge_boInstanceControl.stysbValue;
        --
        rcdeal          dald_deal.styLD_deal;
        nutotdistribute ld_deal.total_value%TYPE;
        nudealinsubsidy NUMBER;
        dtminstardate   DATE;
        dtmaxenddate    DATE;
        --
        blexist BOOLEAN;
    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.Insert_Update_Deal', pkg_traza.cnuNivelTrzDef);

        /*obtener los valores ingresados en la aplicacion PB LDDEA*/
        nuDeal_Id      := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'DEAL_ID');
        sbDescription  := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'DESCRIPTION');
        dtInitial_Date := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'INITIAL_DATE');
        dtFinal_Date   := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'FINAL_DATE');
        nuTotalvalue   := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'TOTAL_VALUE');
        nuSponsor_Id   := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'SPONSOR_ID');
        sbDisable_Deal := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'DISABLE_DEAL');
        dtDisable_Date := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'DISABLE_DATE');
        ------------------------------------------------
        IF (nuDeal_Id IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Identificador del convenio');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
        --
        IF (sbDescription IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Descripcion del convenio');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
        --
        IF (dtInitial_Date IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Fecha de inicio del convenio');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
        --
        IF (dtFinal_Date IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE,
                            'Fecha de finalizacion del convenio');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
        --
        IF (nuTotalvalue IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE,
                            'Valor total del convenio del convenio');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
        --
        IF (nuSponsor_Id IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Ente que otorga los fondos');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
        --

        /*Consultar si el convenio ya existe*/
        blexist := DALD_deal.fblExist(nuDeal_Id);

        IF blexist THEN
            /*Obtener los datos del convenio*/
            DALD_deal.getRecord(nuDeal_Id, rcdeal);
            --
            /*Determinar si un convenio ya se encuentra inactivo*/
            IF nvl(rcdeal.disable_deal, Ld_Boconstans.csbNo_Action) =
               Ld_Boconstans.csbAction_Ok AND rcdeal.disable_date IS NOT NULL THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'El convenio no se puede modificar porque se encuentra inactivo');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            --
            /*Validar que no se pueda actualizar el convenio si ha caducado si vigencia*/
            IF SYSDATE > rcdeal.final_date THEN
                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'No se puede actualizar los datos del convenio porque ha caducado su vigencia');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            --
            IF (sbDisable_Deal = Ld_Boconstans.csbAction_Ok AND
               dtDisable_Date IS NULL) THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'La fecha para registrar el convenio como inactivo no puede ser nula');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            --
            IF ((sbDisable_Deal IS NULL OR
               sbDisable_Deal <> Ld_Boconstans.csbAction_Ok) AND
               dtDisable_Date IS NOT NULL) THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'El valor para inactivar un convenio deber ser ' ||
                                Ld_Boconstans.csbAction_Ok);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            --
            IF ((nvl(sbDisable_Deal, Ld_Boconstans.csbNo_Action) =
               Ld_Boconstans.csbAction_Ok) AND
               (dtDisable_Date NOT BETWEEN rcdeal.initial_date AND
               rcdeal.final_date)) THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'La fecha de inactivacion del convenio debe estar entre ' ||
                                dtInitial_Date || ' y ' || dtFinal_Date);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            --

            /*Verificar si el convenio se encuentra asociado a por lo menos un subsidio*/
            nudealinsubsidy := Ld_BcSubsidy.Fnuquantitydealinsunsidy(nuDeal_Id);

            IF nudealinsubsidy > 0 THEN

                /*Obtener la fecha minima de inicio de vigencia de un subsidio asociado al convenio*/
                dtminstardate := Ld_BcSubsidy.Fdtminsubstardate(nuDeal_Id);

                /*Validar que la nueva fecha de inicio de vigencia del convenio no supere la minima fecha
                de inicio de vigencia de un subsidio asociado al convenio*/
                IF dtInitial_Date > dtminstardate THEN
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    'La fecha de inicio de vigencia no puede superar la minima fecha, ' ||
                                    dtminstardate ||
                                    ', de inicio de vigencia de un subsidio asociado al convenio');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

                /*Obtener la fecha maxima de fin de vigencia de un subsidio asociado al convenio*/
                dtmaxenddate := Ld_BcSubsidy.Fdtmaxsubenddate(nuDeal_Id);

                /*Validar que la nueva fecha de fin de vigencia del convenio no sea menor a la maxima fecha
                de fin de vigencia de un subsidio asociado al convenio*/
                IF dtFinal_Date < dtmaxenddate THEN
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    'La fecha de fin de vigencia no puede ser menor a la maxima fecha, ' ||
                                    dtmaxenddate ||
                                    ', de fin de vigencia de un subsidio asociado al convenio');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

            END IF;
            --

            /*Obtener la suma del total de todos los conceptos subsidiados para el convenio mas el total de todos los valores autorizados del convenio*/
            nutotdistribute := LD_BOSUBSIDY.Fnutotdealdistribute(nuDeal_Id,
                                                                 LD_BOConstans.cnuGasService,
                                                                 SYSDATE);

            /*Validar que la suma del total de todos los conceptos subsidiados para el convenio mas el total de todos los valores autorizados del convenio
            no superen el valor del convenio*/
            IF nuTotalvalue < nutotdistribute THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'La sumatoria de los porcentajes subsidiados de los conceptos y los valores autorizados superan el valor del convenio');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            --

            rcdeal.deal_id      := nuDeal_Id;
            rcdeal.description  := sbDescription;
            rcdeal.initial_date := dtInitial_Date;
            rcdeal.final_date   := dtFinal_Date;
            rcdeal.total_value  := nuTotalvalue;
            rcdeal.sponsor_id   := nuSponsor_Id;
            rcdeal.disable_deal := sbDisable_Deal;
            rcdeal.disable_date := dtDisable_Date;

            /*Actualizar convenio*/
            DALD_deal.updRecord(rcdeal, 0);

        ELSE

            /*Validar que la fecha final no sea menor que la inicial*/
            IF dtFinal_Date < dtInitial_Date THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'La fecha final del convenio no puede ser menor a la inicial');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Validar que el valor del convenio sea mayor a cero*/
            IF nuTotalvalue <= ld_boconstans.cnuCero_Value THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'El valor del convenio debe ser mayor a ' ||
                                                 ld_boconstans.cnuCero_Value);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Validar ingreso de caracter que determina si un convenio sera inactivo*/
            IF ((sbDisable_Deal IS NULL OR
               sbDisable_Deal <> Ld_Boconstans.csbAction_Ok) AND
               dtDisable_Date IS NOT NULL) THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'El valor para inactivar un convenio deber ser ' ||
                                Ld_Boconstans.csbAction_Ok);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Validar ingreso de fecha de inactivacion*/
            IF (sbDisable_Deal = Ld_Boconstans.csbAction_Ok AND
               dtDisable_Date IS NULL) THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'La fecha para registrar el convenio como inactivo no puede ser nula');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Validar que fecha de inactivacion esta comprendida entre el rango de vigencia del convenio*/
            IF ((nvl(sbDisable_Deal, Ld_Boconstans.csbNo_Action) =
               Ld_Boconstans.csbAction_Ok) AND
               (dtDisable_Date NOT BETWEEN dtInitial_Date AND dtFinal_Date)) THEN

                Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                'La fecha de inactivacion del convenio debe estar entre ' ||
                                dtInitial_Date || ' y ' || dtFinal_Date);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            rcdeal.deal_id      := nuDeal_Id;
            rcdeal.description  := sbDescription;
            rcdeal.initial_date := dtInitial_Date;
            rcdeal.final_date   := dtFinal_Date;
            rcdeal.total_value  := nuTotalvalue;
            rcdeal.sponsor_id   := nuSponsor_Id;
            rcdeal.disable_deal := nvl(sbDisable_Deal,
                                       Ld_Boconstans.csbNo_Action);
            rcdeal.disable_date := dtDisable_Date;

            /*insertar convenio*/
            DALD_deal.insRecord(rcdeal);
        END IF;

        COMMIT;

        UT_Trace.Trace('Fin Ld_Bosubsidy.Insert_Update_Deal', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : FnugetmaxsubsVal
       Descripcion    : Obtiene el valor maximo a subsidiar para un cliente

       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inupromotion     identificador de la promocion
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria
       inuoption        opcion a ejecutar de la regla

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       04/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION FnugetmaxsubsVal(inupromotion    CC_PROMOTION.Promotion_Id%TYPE,
                              inuubication    GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE,
                              inucategory     SUBCATEG.Sucacate%TYPE,
                              inusubcateg     SUBCATEG.Sucacodi%TYPE,
                              inuoption       NUMBER,
                              idtRegisterDate IN DATE DEFAULT SYSDATE)
        RETURN NUMBER IS

        nuindividualsubsidyvalue ld_subsidy.authorize_value%TYPE;
        rcsubsidy                dald_subsidy.styLD_subsidy;
        nusubsidy                ld_subsidy.subsidy_id%TYPE;
        nuubication              ld_ubication.ubication_id%TYPE;
        nupromtype               cc_promotion.prom_type_id%TYPE;
        --
        nucategori SUBCATEG.Sucacate%TYPE;
        nusubcateg SUBCATEG.Sucacodi%TYPE;
        nulocation GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE;

    BEGIN

        nuindividualsubsidyvalue := 0;
        UT_Trace.Trace('Inicio Ld_BoSubsidy.FnugetmaxsubsVal', pkg_traza.cnuNivelTrzDef);

        /*Validar que la promocion sea tipo 3: subsidios*/
        nupromtype := Dacc_Promotion.fnuGetProm_Type_Id(inupromotion);

        IF nupromtype <> ld_boconstans.cnuPromotionType THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El tipo de promocion no es subsidiada');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*En esta ocasion el metodo sera invocado desde las validaciones de la venta*/
        IF inuoption = ld_boconstans.cnuonenumber THEN
            /*Validar ingreso de la ubicacion geografica*/
            IF inuubication IS NULL THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'El codigo de la ubicacion geografica no puede ser nulo');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Validar ingreso de la categoria*/
            IF inucategory IS NULL THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'El codigo de la categoria no puede ser nulo');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Validar ingreso de la subcategoria*/
            IF inusubcateg IS NULL THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'El codigo de la subcategoria no puede ser nulo');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Obtener la ubicacion geografica*/
            nulocation := inuubication;
            /*Obtener categoria y subcategoria del predio*/
            nucategori := inucategory;
            nusubcateg := inusubcateg;

        END IF;

        /*Instrucciones para obtener el valor individual de un subsidio*/
        /*Obtener el subsidio asociado a una promocion*/
        nusubsidy := ld_bcsubsidy.Fnugetpromsubsidy(inupromotion, NULL);
        /*Obtener datos del subsidio*/
        DALD_subsidy.LockByPkForUpdate(nusubsidy, rcsubsidy);
        /*Se obtiene valor individual del subsidio teniendo la el id de la ubicacion*/
        IF inuoption = ld_boconstans.cnuthreenumber THEN
            /*Obtener valor individual de subsidio*/
            nuindividualsubsidyvalue := Ld_bcsubsidy.fnutotalvalconc(inuubication);

            /*Si la parametrizacion del subsidio es por cantidad*/
            IF nuindividualsubsidyvalue IS NULL THEN
                nuindividualsubsidyvalue := Ld_bcsubsidy.Fnutotsubpercentage(ld_boconstans.cnuGasService,
                                                                             nvl(idtRegisterDate,
                                                                                 SYSDATE),
                                                                             inuubication);
            END IF;
            UT_Trace.Trace('Fin Ld_BoSubsidy.FnugetmaxsubsVal=' ||
                           nuindividualsubsidyvalue,
                           10);
            RETURN(nuindividualsubsidyvalue);
        END IF;

        IF nuubiasigsub IS NOT NULL THEN
            /*Obtener ubicacion retroactiva*/
            nuubication := nuubiasigsub;
        ELSE
            /*Obtener el codigo de la ubicacion geografica*/
            nuubication := Ld_bosubsidy.Fnugetsububication(nusubsidy,
                                                           nulocation,
                                                           nucategori,
                                                           nusubcateg);
            /*Obtener ubicacion retroactiva*/
            nuubiasigsub := nuubication;
        END IF;

        /*Si la parametrizacion del subsidio es por valor*/
        --IF rcsubsidy.authorize_value IS NOT NULL THEN
        /*Obtener valor individual de subsidio*/
        nuindividualsubsidyvalue := Ld_bcsubsidy.fnutotalvalconc(nuubication);
        --END IF;

        /*Si la parametrizacion del subsidio es por cantidad*/
        IF rcsubsidy.authorize_quantity IS NOT NULL THEN
            nuindividualsubsidyvalue := Ld_bcsubsidy.Fnutotsubpercentage(ld_boconstans.cnuGasService,
                                                                         nvl(idtRegisterDate,
                                                                             SYSDATE),
                                                                         nuubication);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.FnugetmaxsubsVal=' ||
                       nuindividualsubsidyvalue,
                       10);
        RETURN(nuindividualsubsidyvalue);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END FnugetmaxsubsVal;
    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Fnupercentageconcvalue
      Descripcion    : Obtiene el valor porcentual de la tarifa de
                       un concepto
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

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      19/09/2013       AEcheverrySAO217314    Se modifica para calcular el porcentaje
                                              correcto del valor del subsidio.
      11/10/2012       jconsuegra.SAO156577   Creacion
    ******************************************************************/
    FUNCTION Fnupercentageconcvalue(inuconc      concepto.conccodi%TYPE,
                                    inuserv      servicio.servcodi%TYPE,
                                    inucate      categori.catecodi%TYPE,
                                    inusubcate   subcateg.sucacodi%TYPE,
                                    inuubication ge_geogra_location.geograp_location_id%TYPE,
                                    idtfecha     regltari.retafein%TYPE,
                                    inupercen    NUMBER) RETURN NUMBER IS

        nuconvalue regltari.retavaba%TYPE;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnupercentageconcvalue', pkg_traza.cnuNivelTrzDef);

        /*Obtener el valor de la tarifa de un concepto*/
        nuconvalue := Ld_BoSubsidy.Fnugetconcvalue(inuconc,
                                                   inuserv,
                                                   inucate,
                                                   inusubcate,
                                                   inuubication,
                                                   idtfecha);

        /*Obtener valor porcentual de la tarifa de un concepto*/
        IF inupercen > 0 AND inupercen <= 100 THEN
            nuconvalue := nuconvalue - ((nuconvalue * (100 - inupercen)) / 100);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnupercentageconcvalue=' ||
                       nuconvalue,
                       10);

        RETURN(nuconvalue);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnupercentageconcvalue;

    /**********************************************************************
      Propiedad intelectual de OPEN International Systems
      Nombre              Fnupctconcvalue

      Autor           Andres Felipe Esguerra Restrepo

      Fecha               09-ene-2014

      Descripcion         Obtiene el valor para un concepto en una venta cotizada

      ***Parametros***
      Nombre              Descripcion
      inuconc             Concepto
      inuPackId           ID de la solicitud
      inuPercen           Porcentaje subsidiado

      ***Historia de Modificaciones***
      Fecha Modificacion              Autor
      .                           .
    ***********************************************************************/
    FUNCTION Fnupctconcvalue(inuconc   concepto.conccodi%TYPE,
                             inuPackId mo_packages.package_id%TYPE,
                             inupercen NUMBER) RETURN NUMBER IS

        nuconvalue regltari.retavaba%TYPE;

        CURSOR cuQuotationValue(nuPackageId IN cc_quotation.package_id%TYPE,
                                nuConceptId IN ge_items.concept%TYPE) IS
            SELECT SUM(qi.unit_value - qi.unit_discount_value) total_concepto
            FROM   cc_quotation      q,
                   cc_quotation_item qi,
                   ge_items          i
            WHERE  q.quotation_id = qi.quotation_id
            AND    qi.items_id = i.items_id
            AND    q.package_id = nuPackageId
            AND    i.concept = nuConceptId;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnupctconcvalue', 1);

        IF cuQuotationValue%ISOPEN THEN
            CLOSE cuQuotationValue;
        END IF;

        OPEN cuQuotationValue(inuPackId, inuconc);
        FETCH cuQuotationValue
            INTO nuConValue;
        CLOSE cuQuotationValue;

        IF nuConValue IS NOT NULL THEN
            /*Obtener valor porcentual de la tarifa de un concepto*/
            IF inupercen > 0 AND inupercen <= 100 THEN
                nuconvalue := nuconvalue -
                              ((nuconvalue * (100 - inupercen)) / 100);
            END IF;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnupctconcvalue = ' || nuconvalue, 1);

        RETURN(nuconvalue);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnupctconcvalue;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FblInsSubsidy
      Descripcion    : Inserta subidio de un bloque de datos  de
                       un archivo plano

      Autor          : Jorge Valiente
      Fecha          : 12/10/2012

      Parametros             Descripcion
      ============           ================================================
      inuCodigoSubsidio      Codigo del subsidio
      isbSubcidio            Cadena de subsidio
      isbPopulation          Cadena de la Poblacion a aplicar subcidio
      isbConceptsSubsidize   Cadena de conceptos de subsidio
      isbCollectionStops     Cadena de topes de cobre

      Historia de Modificaciones
      Fecha            Autor           Modificacion
      ============  =================  =======================================
      13/11/2013    anietoSAO222835    Se agrega la validacion para el atributo
                                       deal_id que contiene el convenio.
      06/09/2013    hvera.SAO216556    Se modifica para recibir el codigo del
                                       subsidio con el que se va registrar la
                                       configuracion.
    **************************************************************************/
    FUNCTION FblInsSubsidy(inuCodigoSubsidio        IN ld_subsidy.subsidy_id%TYPE,
                           isbSubcidio              IN VARCHAR2,
                           isbPopulation            IN VARCHAR2,
                           isbconceptssubsidizeline IN VARCHAR2,
                           isbcollectionstopsline   IN VARCHAR2,
                           osbErrorMessage          OUT VARCHAR2)
        RETURN ld_subsidy.subsidy_id%TYPE IS

        sbConceptsSubsidize VARCHAR2(1000);
        sbcollectionstops   VARCHAR2(1000);
        nuAmount            NUMBER;
        nuAmountSubString   NUMBER;
        nuErrorCode         NUMBER;

        nuSubsidyId       LD_SUBSIDY.SUBSIDY_ID%TYPE;
        nuUbicationId     LD_UBICATION.UBICATION_ID%TYPE;
        nuSubsidyDetailId LD_SUBSIDY_DETAIL.SUBSIDY_DETAIL_ID%TYPE;
        nuMaxRecoveryId   LD_MAX_RECOVERY.MAX_RECOVERY_ID%TYPE;
        arString          LD_BOCONSTANS.TBARRAY;
        stysubsidy        DALD_SUBSIDY.STYLD_SUBSIDY;
        styubication      DALD_UBICATION.STYLD_UBICATION;
        stysubsidydetail  DALD_SUBSIDY_DETAIL.STYLD_SUBSIDY_DETAIL;
        stymaxrecovery    DALD_MAX_RECOVERY.STYLD_MAX_RECOVERY;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.FblInsSubsidy', pkg_traza.cnuNivelTrzDef);

        osbErrorMessage := NULL;
        nuSubsidyId     := inuCodigoSubsidio;
        nuAmount        := ld_bosubsidy.FsbGetAmount(isbSubcidio,
                                                     ld_boconstans.csbPipe);

        IF nuAmount <> -1 OR nuAmount <> 0 THEN
            arString := ld_bosubsidy.FsbGetArray(nuAmount,
                                                 isbSubcidio,
                                                 ld_boconstans.csbPipe);

            IF (nuSubsidyId IS NULL) THEN
                nuSubsidyId           := LD_BOSequence.FnuSeqSubsidy;
                stysubsidy.subsidy_id := nuSubsidyId;

                IF arString(2) IS NOT NULL THEN
                    stysubsidy.description := arString(2);
                ELSE
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    csbNullDescription || ' [' ||
                                    stysubsidy.deal_id || '] ');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

                stysubsidy.deal_id           := to_number(arString(3));
                stysubsidy.initial_date      := to_date(arString(4),
                                                        'DD/MM/YYYY');
                stysubsidy.final_date        := to_date(arString(5),
                                                        'DD/MM/YYYY');
                stysubsidy.star_collect_date := to_date(arString(6),
                                                        'DD/MM/YYYY');

                IF arString.exists(7) THEN
                    IF arString(7) IS NOT NULL THEN
                        IF pktblconcepto.fblexist(arString(7)) THEN
                            stysubsidy.conccodi := to_number(arString(7));
                        ELSE
                            Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                            'El concepto ingresado no existe [' ||
                                            arString(7) || '] ');
                            RAISE pkg_error.CONTROLLED_ERROR;
                        END IF;
                    ELSE
                        Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                        'El concepto no puede ser nulo');
                        RAISE pkg_error.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    'Formato incorrecto');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

                stysubsidy.validity_year_means := to_number(arString(8));
                stysubsidy.authorize_quantity  := to_number(arString(9));
                stysubsidy.authorize_value     := to_number(arString(10));
                stysubsidy.remainder_status    := NULL;
                stysubsidy.total_deliver       := NULL;
                stysubsidy.total_available     := NULL;

                IF arString.exists(11) THEN
                    IF arString(11) IS NOT NULL THEN
                        IF dald_subsidy.fblExist(arString(11)) THEN
                            stysubsidy.origin_subsidy := to_number(arString(11));
                        ELSE
                            Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                            'El subsidio origen no existe');
                            RAISE pkg_error.CONTROLLED_ERROR;
                        END IF;
                    END IF;
                ELSE
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    'Formato incorrecto, falta el separador para el subsidio origen');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

                -- Validacion del convenio. Debe de existir en la tabla referenciado
                IF (stysubsidy.deal_id IS NOT NULL) THEN
                    IF (dald_deal.fblExist(stysubsidy.deal_id) != TRUE) THEN
                        Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                        csbValidateDealID || ' [' ||
                                        stysubsidy.deal_id || '] ');
                        RAISE pkg_error.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    csbRequiredAttribute || ' [Convenio] ');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

                dald_subsidy.insRecord(stysubsidy);

            END IF;

        END IF;

        IF isbPopulation IS NOT NULL THEN
            nuAmount := ld_bosubsidy.FsbGetAmount(isbPopulation,
                                                  ld_boconstans.csbPipe);
            IF nuAmount <> -1 OR nuAmount <> 0 THEN
                arString := ld_bosubsidy.FsbGetArray(nuAmount,
                                                     isbPopulation,
                                                     ld_boconstans.csbPipe);

                nuUbicationId                   := LD_BOSequence.FnuSeqUbication;
                styubication.ubication_id       := nuUbicationId;
                styubication.subsidy_id         := nuSubsidyId;
                styubication.geogra_location_id := to_number(arString(2));
                styubication.sucacate           := to_number(arString(3));
                styubication.sucacodi           := to_number(arString(4));
                styubication.authorize_quantity := to_number(arString(5));
                styubication.authorize_value    := to_number(arString(6));
                styubication.total_deliver      := NULL;
                styubication.total_available    := NULL;

                -- Solo deben de se ser la categoria Residencial(1)
                IF (styubication.sucacate = cnuCategoriResidential) THEN
                    IF (styubication.sucacodi IS NOT NULL) THEN
                        -- Valida que la combinacion categoria y subcategoria sea valida
                        IF (dasubcateg.fblexist(styubication.sucacate,
                                                styubication.sucacodi) != TRUE) THEN
                            Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                            csbCateSucate);
                            RAISE pkg_error.CONTROLLED_ERROR;
                        END IF;
                    ELSE
                        Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                        csbRequiredAttribute ||
                                        ' [subcategoria] ');
                        RAISE pkg_error.CONTROLLED_ERROR;
                    END IF;

                ELSE
                    Errors.SetError(LD_BOCONSTANS.cnuGeneric_Error,
                                    csbCategoriValid);
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;

                dald_ubication.insRecord(styubication);
            END IF;
        END IF;

        IF isbConceptsSubsidizeLine IS NOT NULL THEN
            nuAmount := ld_bosubsidy.FsbGetAmount(isbConceptsSubsidizeLine,
                                                  ld_boconstans.csbGuion) + 1;
            FOR j IN 1 .. nuAmount LOOP
                sbConceptsSubsidize := ld_bosubsidy.FsbGetString(j,
                                                                 isbConceptsSubsidizeLine,
                                                                 ld_boconstans.csbGuion);
                nuAmountSubString   := ld_bosubsidy.FsbGetAmount(sbConceptsSubsidize,
                                                                 ld_boconstans.csbPipe) + 1;
                arString            := ld_bosubsidy.FsbGetArray(nuAmountSubString,
                                                                sbConceptsSubsidize,
                                                                ld_boconstans.csbPipe);

                nuSubsidyDetailId                   := LD_BOSequence.FnuSeqSubsidyDetail;
                stysubsidydetail.subsidy_detail_id  := nuSubsidyDetailId;
                stysubsidydetail.conccodi           := to_number(arString(2));
                stysubsidydetail.subsidy_percentage := to_number(arString(3));
                stysubsidydetail.subsidy_value      := to_number(arString(4));
                stysubsidydetail.ubication_id       := nuUbicationId;

                dald_subsidy_detail.insRecord(stysubsidydetail);

            END LOOP;
        END IF;

        IF isbcollectionstopsline IS NOT NULL THEN
            nuAmount := ld_bosubsidy.FsbGetAmount(isbcollectionstopsline,
                                                  ld_boconstans.csbGuion) + 1;
            FOR j IN 1 .. nuAmount LOOP
                sbcollectionstops := ld_bosubsidy.FsbGetString(j,
                                                               isbcollectionstopsline,
                                                               ld_boconstans.csbGuion);
                nuAmountSubString := ld_bosubsidy.FsbGetAmount(sbcollectionstops,
                                                               ld_boconstans.csbPipe) + 1;
                arString          := ld_bosubsidy.FsbGetArray(nuAmountSubString,
                                                              sbcollectionstops,
                                                              ld_boconstans.csbPipe);

                nuMaxRecoveryId                   := LD_BOSequence.FnuSeqSeqMaxRecovery;
                stymaxrecovery.max_recovery_id    := nuMaxRecoveryId;
                stymaxrecovery.year               := to_number(arString(2));
                stymaxrecovery.month              := to_number(arString(3));
                stymaxrecovery.total_sub_recovery := to_number(arString(4));
                stymaxrecovery.recovery_value     := to_number(arString(5));
                stymaxrecovery.ubication_id       := nuUbicationId;

                dald_max_recovery.insRecord(stymaxrecovery);
            END LOOP;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.FblInsSubsidy=' || nuSubsidyId, pkg_traza.cnuNivelTrzDef);
        RETURN(nuSubsidyId);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            errors.GetError(nuErrorCode, osbErrorMessage);
            RETURN(NULL);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            errors.GetError(nuErrorCode, osbErrorMessage);
            RETURN(NULL);
            RAISE pkg_error.CONTROLLED_ERROR;
    END FblInsSubsidy;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Fnutotdealdistribute
      Descripcion    : Obtiene el total distribuido de un convenio
                       en la parametrizacion de subsidios. Para ello
                       se suma el total de todos los
                       conceptos subsidiados para el convenio mas
                       el total de todos los valores autorizados
                       del convenio.


      Autor          : jonathan alberto consuegra lara
      Fecha          : 18/10/2012

      Parametros             Descripcion
      ============           ===================
      isbSubcidio            Cadena de subsidio
      isbPopulation          Cadena de la Poblacion a aplicar subcidio
      isbConceptsSubsidize   Cadena de conceptos de subsidio
      isbCollectionStops     Cadena de topes de cobre

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      18/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnutotdealdistribute(inudeal  ld_deal.deal_id%TYPE,
                                  inuserv  servicio.servcodi%TYPE,
                                  idtfecha regltari.retafein%TYPE) RETURN NUMBER IS

        nutotvalue   ld_deal.total_value%TYPE;
        nutotsumval  ld_subsidy.authorize_value%TYPE;
        nutotsumconc ld_subsidy.authorize_value%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnutotdealdistribute', pkg_traza.cnuNivelTrzDef);

        /*Obtener la sumatoria de valores de todos los conceptos subsidiados por porcentaje asociados a los
        distintos subsidios de un convenio no supere el valor del convenio*/
        nutotsumconc := Ld_bcsubsidy.Fnuvaluepercentagexdeal(inuserv,
                                                             idtfecha,
                                                             inudeal);

        /*Obtener la sumatoria de valores autorizados de los subsidios asociados a un convenio*/
        nutotsumval := Ld_bcsubsidy.fnutotauthorize_value(inudeal);

        nutotvalue := nvl(nutotsumconc, ld_boconstans.cnuCero_Value) +
                      nvl(nutotsumval, ld_boconstans.cnuCero_Value);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnutotdealdistribute=' || nutotvalue,
                       10);

        RETURN(nutotvalue);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnutotdealdistribute;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procconsultdeal
      Descripcion    : Obtiene los convenios parametrizados a partir
                       de una serie de filtros.

      Autor          : jonathan alberto consuegra lara
      Fecha          : 23/10/2012

      Parametros             Descripcion
      ============           ===================
      inuDeal                Codigo del convenio
      idtinicialdate         Fecha de inicio de vigencia del convenio
      idtfinaldate           Fecha de fin de vigencia del convenio
      inudealvalue           Valor del convenio
      inuSponsor             Ente que otorga el dinero
      Orfdeal                Cursor referenciado de convenio

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      23/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procconsultdeal(inuDeal        ld_deal.deal_id%TYPE,
                              idtinicialdate ld_deal.initial_date%TYPE,
                              idtfinaldate   ld_deal.final_date%TYPE,
                              inudealvalue   ld_deal.total_value%TYPE,
                              inuSponsor     ld_deal.sponsor_id%TYPE,
                              Orfdeal        OUT pkConstante.tyRefCursor) IS

        sbquery       VARCHAR2(1000);
        sbquerydetail VARCHAR2(1000);

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procconsultdeal', pkg_traza.cnuNivelTrzDef);

        IF idtinicialdate IS NOT NULL AND idtfinaldate IS NOT NULL THEN

            IF idtfinaldate < idtinicialdate THEN

                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'La fecha final no puede ser menor a la inicial');
                RAISE pkg_error.CONTROLLED_ERROR;

            END IF;

        END IF;

        sbquery := 'SELECT l.deal_id, l.deal_id||' || chr(39) || ' - ' ||
                   chr(39) ||
                   '||l.description deal, l.initial_date, l.final_date, l.total_value, l.sponsor_id||' ||
                   chr(39) || ' - ' || chr(39) ||
                   '||dald_sponsor.fsbGetDescription(l.sponsor_id, null) sponsor,
                       l.disable_deal, l.disable_date
                FROM   ld_deal l';

        IF inuDeal IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.deal_id = ' || inuDeal;
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.deal_id = ' ||
                                 inuDeal;
            END IF;
        END IF;

        IF idtinicialdate IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.initial_date >= ' || chr(39) ||
                                 idtinicialdate || chr(39);
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.initial_date >= ' ||
                                 chr(39) || idtinicialdate || chr(39);
            END IF;
        END IF;

        IF idtfinaldate IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.final_date <= ' || chr(39) ||
                                 idtfinaldate || chr(39);
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.final_date <= ' ||
                                 chr(39) || idtfinaldate || chr(39);
            END IF;
        END IF;

        IF inudealvalue IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.total_value = ' || inudealvalue;
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.total_value = ' ||
                                 inudealvalue;
            END IF;
        END IF;

        IF inuSponsor IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.sponsor_id = ' || inuSponsor;
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.sponsor_id = ' ||
                                 inuSponsor;
            END IF;
        END IF;

        sbquerydetail := sbquerydetail || ' order by l.deal_id';

        sbquery := sbquery || sbquerydetail;

        OPEN Orfdeal FOR sbquery;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procconsultdeal', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procconsultdeal;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procconsultsubsidy
      Descripcion    : Obtiene los subsidios parametrizados a partir
                       de una serie de filtros.

      Autor          : jonathan alberto consuegra lara
      Fecha          : 26/10/2012

      Parametros             Descripcion
      ============           ===================
      inuDeal                Codigo del convenio
      inuSubsidy             Codigo del subsidio
      idtinicialdate         Fecha de inicio de vigencia del subsidio
      idtfinaldate           Fecha de fin de vigencia del subsidio
      inuconcep              Concepto de aplicacion
      inuubication           Ubicacion a la cual aplica el subsidio
      inucategori            categoria a la cual aplica el subsidio
      inusubcategori         Subcategoria a la cual aplica el subsidio
      Orfsubsidy             Cursor referenciado de subsidios

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      26/10/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procconsultsubsidy(inuDeal        ld_deal.deal_id%TYPE,
                                 inuSubsidy     ld_subsidy.subsidy_id%TYPE,
                                 idtinicialdate ld_subsidy.initial_date%TYPE,
                                 idtfinaldate   ld_subsidy.final_date%TYPE,
                                 idtinicharge   ld_subsidy.star_collect_date%TYPE,
                                 inuconcep      ld_subsidy.conccodi%TYPE,
                                 inuubication   ld_ubication.geogra_location_id%TYPE,
                                 inucategori    ld_ubication.sucacate%TYPE,
                                 inusubcategori ld_ubication.sucacodi%TYPE,
                                 Orfsubsidy     OUT pkConstante.tyRefCursor) IS

        sbquery       VARCHAR2(4000);
        sbquerydetail VARCHAR2(8000);

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procconsultsubsidy', pkg_traza.cnuNivelTrzDef);

        IF idtinicialdate IS NOT NULL AND idtfinaldate IS NOT NULL THEN

            IF idtfinaldate < idtinicialdate THEN

                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'La fecha final no puede ser menor a la inicial');
                RAISE pkg_error.CONTROLLED_ERROR;

            END IF;

        END IF;

        sbquery := 'SELECT l.subsidy_id, l.subsidy_id||' || chr(39) || ' - ' ||
                   chr(39) || '||l.description subsidy,
                       l.deal_id, l.deal_id||' || chr(39) ||
                   ' - ' || chr(39) || '||dald_deal.fsbGetDescription(l.deal_id, null) deal,
                       l.initial_date,        l.final_date,      l.star_collect_date,
                       l.conccodi||' || chr(39) || ' - ' ||
                   chr(39) || '||pktblconcepto.fsbGetConcdesc(l.conccodi, null) concepto,
                       l.validity_year_means, l.authorize_quantity, l.authorize_value,
                       (case
                         when l.remainder_status is not null then
                          l.remainder_status||' || chr(39) ||
                   ' - ' || chr(39) || '||ld_bosubsidy.fsbgetremainstatusdesc(l.remainder_status)
                         else
                          null
                       end) remainder_status,
                       Ld_BcSubsidy.Fnugetsubasig(l.subsidy_id) Ventas_realizadas,     l.total_deliver,
                       l.total_available,
                       l.promotion_id||' || chr(39) || ' - ' ||
                   chr(39) || '||dacc_promotion.fsbGetDescription(l.promotion_id, null) promocion,
                       (case
                         when l.origin_subsidy is not null then
                          l.origin_subsidy||' || chr(39) ||
                   ' - ' || chr(39) ||
                   '||dald_subsidy.fsbGetDescription(l.origin_subsidy, null)
                         else
                          null
                       end) sub_ori,
                       Decode(Ld_Bosubsidy.FsbActiveSubsidy(l.subsidy_id), ' ||
                   chr(39) || 'Y' || chr(39) || ', ' || chr(39) || 'SI' ||
                   chr(39) || ', ' || chr(39) || 'NO' || chr(39) ||
                   ') Activo
               FROM    ld_subsidy l';

        IF inuubication IS NOT NULL OR inucategori IS NOT NULL OR
           inusubcategori IS NOT NULL THEN
            sbquerydetail := ' , ld_ubication ub WHERE l.subsidy_id = ub.subsidy_id';
            --
            IF inuubication IS NOT NULL THEN
                sbquerydetail := sbquerydetail ||
                                 ' AND ub.geogra_location_id = decode(' ||
                                 inuubication ||
                                 ', -1, ub.geogra_location_id, ' ||
                                 inuubication || ')';
            END IF;
            --
            IF inucategori IS NOT NULL THEN
                sbquerydetail := sbquerydetail || ' AND ub.sucacate = decode(' ||
                                 inucategori || ', -1, ub.sucacate, ' ||
                                 inucategori || ')';
            END IF;
            --
            IF inusubcategori IS NOT NULL THEN
                sbquerydetail := sbquerydetail || ' AND ub.sucacodi = decode(' ||
                                 inusubcategori || ', -1, ub.sucacodi, ' ||
                                 inusubcategori || ')';
            END IF;
        END IF;

        IF inuDeal IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.deal_id = decode(' || inuDeal ||
                                 ', -1, l.deal_id, ' || inuDeal || ')';
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.deal_id = decode(' ||
                                 inuDeal || ', -1, l.deal_id, ' || inuDeal || ')';
            END IF;
        END IF;
        --
        IF inuSubsidy IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.subsidy_id = decode(' || inuSubsidy ||
                                 ', -1, l.subsidy_id, ' || inuSubsidy || ')';
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.subsidy_id = decode(' ||
                                 inuSubsidy || ', -1, l.subsidy_id, ' ||
                                 inuSubsidy || ')';
            END IF;
        END IF;
        --
        IF idtinicialdate IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.initial_date >= ' || chr(39) ||
                                 idtinicialdate || chr(39);
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.initial_date >= ' ||
                                 chr(39) || idtinicialdate || chr(39);
            END IF;
        END IF;
        --
        IF idtfinaldate IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.final_date <= ' || chr(39) ||
                                 idtfinaldate || chr(39);
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.final_date <= ' ||
                                 chr(39) || idtfinaldate || chr(39);
            END IF;
        END IF;
        --
        --idtinicharge
        IF idtinicharge IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.star_collect_date >= ' || chr(39) ||
                                 idtinicharge || chr(39);
            ELSE
                sbquerydetail := sbquerydetail ||
                                 ' AND l.star_collect_date >= ' || chr(39) ||
                                 idtinicharge || chr(39);
            END IF;
        END IF;
        --
        IF inuconcep IS NOT NULL THEN
            IF sbquerydetail IS NULL THEN
                sbquerydetail := ' WHERE l.conccodi = ' || inuconcep;
            ELSE
                sbquerydetail := sbquerydetail || ' AND l.conccodi = ' ||
                                 inuconcep;
            END IF;
        END IF;
        --
        sbquerydetail := sbquerydetail || ' order by l.subsidy_id';

        sbquery := sbquery || sbquerydetail;
        UT_Trace.Trace('sbquery = ' || sbquery, pkg_traza.cnuNivelTrzDef);
        OPEN Orfsubsidy FOR sbquery;
        --

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procconsultsubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procconsultsubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : ProcAssignsubsidy
       Descripcion    : Se encarga de asignar subsidios en sus distintas
                        modalidades
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inuSuscripc      Contrato
       inuPromotion     Promocion
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria
       isbTipSubsi      identificador del tipo de subsidio

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ProcAssignsubsidy IS
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.ProcAssignsubsidy', pkg_traza.cnuNivelTrzDef);

        --Obtener datos de la instancia

        --llamar al procedimiento encargado de asignar subsidios
        /*Ld_Bosubsidy.Assignsubsidy(inuSuscriber,
        inuPromotion,
        inuubication,
        inucategory,
        inusubcateg,
        isbTipSubsi
        ); */
        NULL;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ProcAssignsubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcAssignsubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Assignsubsidy
       Descripcion    : Se encarga de asignar subsidios en sus distintas
                        modalidades
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inuSuscripc      Contrato
       inuPromotion     Promocion
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria
       isbTipSubsi      identificador del tipo de subsidio

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       28/10/2013       jrobayo.SAO221447     Se elimina la asignacion de orden
                                              de entrega de documentos.
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Assignsubsidy(inuSuscriber  ge_subscriber.subscriber_id%TYPE,
                            inuPromotion  cc_promotion.promotion_id%TYPE,
                            inuubication  ge_geogra_location.geograp_location_id%TYPE,
                            inucategory   subcateg.sucacate%TYPE,
                            inusubcateg   subcateg.sucacodi%TYPE,
                            isbTipSubsi   ld_asig_subsidy.type_subsidy%TYPE,
                            inupackage_id mo_packages.package_id%TYPE) IS

        nusubsidyvalue ld_asig_subsidy.subsidy_value%TYPE;
        nupromtype     cc_promotion.prom_type_id%TYPE;
        nusubsidy      ld_subsidy.subsidy_id%TYPE;
        nuassigsubsidy ld_asig_subsidy.asig_subsidy_id%TYPE;
        nuassigrecord  DALD_asig_subsidy.styLD_asig_subsidy;
        rcubication    dald_ubication.styld_ubication;
        rcsubsidy      dald_subsidy.styld_subsidy;
        nuaddress_id   GE_SUBSCRIBER.address_id%TYPE;
        nucategori     SUBCATEG.Sucacate%TYPE;
        nusubcateg     SUBCATEG.Sucacodi%TYPE;
        nulocation     GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE;
        nuubication    ld_ubication.ubication_id%TYPE;
        --Parametros para la generacion de la orden
        nuorderid or_order.order_id%TYPE;
        --Asignacion retroactiva
        nusesunuse       servsusc.sesunuse%TYPE;
        nususcripc       servsusc.sesususc%TYPE;
        nusalewithoutsub ld_sales_withoutsubsidy.sales_withoutsubsidy_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Assignsubsidy', pkg_traza.cnuNivelTrzDef);

        /*Validar ingreso de la promocion*/
        IF inupromotion IS NULL THEN
            globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
            globalerrormens := 'El codigo de la promocion no puede ser nulo';
            ge_boerrors.seterrorcodeargument(globalerrorcode, globalerrormens);
        END IF;

        /*Validar que la promocion sea tipo 3: subsidios*/
        nupromtype := Dacc_Promotion.fnuGetProm_Type_Id(inupromotion, NULL);

        IF nvl(nupromtype, ld_boconstans.cnuallrows) <>
           ld_boconstans.cnuPromotionType THEN
            globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
            globalerrormens := 'El tipo de promocion no es subsidiada';
            ge_boerrors.seterrorcodeargument(globalerrorcode, globalerrormens);
        END IF;

        /*Obtener el subsidio asociado a una promocion*/
        nusubsidy := ld_bcsubsidy.Fnugetpromsubsidy(inupromotion, NULL);

        /*Si la asignacion es retroactiva*/
        IF isbTipSubsi = ld_boconstans.csbretroactivesale THEN
            nulocation := inuubication;
            nucategori := inucategory;
            nusubcateg := inusubcateg;
        END IF;

        /*Si la asignacion es por venta por formulario*/
        IF isbTipSubsi = ld_boconstans.csbGASSale THEN

            /*Obtener id de la direccion de la solicitud*/
            nuaddress_id := Damo_Packages.Fnugetaddress_Id(inupackage_id, NULL);

            /*Obtener la localidad, la categoria y la subcategoria de la solicitud*/
            Procgetdatesforpackages(inupackage_id,
                                    nulocation,
                                    nucategori,
                                    nusubcateg);

            /*Validar localidad*/
            IF nulocation IS NULL THEN
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'No se puede asignar subsidio el subsidio ' ||
                                   nusubsidy || '
                            porque la localidad de la direccion asociada a la solicitud ' ||
                                   inupackage_id || '
                            es nula';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            END IF;

            /*Validar categoria*/
            IF nucategori IS NULL THEN
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'No se puede asignar subsidio el subsidio ' ||
                                   nusubsidy || '
                            porque la categoria de la direccion asociada a la solicitud ' ||
                                   inupackage_id || '
                            es nula';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            END IF;

            /*Validar subcategoria*/
            IF nusubcateg IS NULL THEN
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'No se puede asignar subsidio el subsidio ' ||
                                   nusubsidy || '
                            porque la subcategoria de la direccion asociada a la solicitud ' ||
                                   inupackage_id || '
                            es nula';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            END IF;

            /*Obtener el codigo de la ubicacion geografica a subsidiar*/
            nuubication := Ld_bosubsidy.Fnugetsububication(nusubsidy,
                                                           nulocation,
                                                           nucategori,
                                                           nusubcateg);

            IF nuubication IS NULL THEN
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'No se puede asignar subsidio a la solicitud: ' ||
                                   inupackage_id || ', por la promocion ' ||
                                   inupromotion ||
                                   ' porque no se encontro una poblacion configurada a partir de los datos
                            del predio registrado durante la venta';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            ELSE

                nuubiasigsub := nuubication;
                /*Obtener datos de la poblacion*/
                DALD_ubication.LockByPkForUpdate(nuubication, rcubication);
            END IF;

            /*Setear la variable que indique el valor del subsidio se
            hara para el proceso de venta por formulario*/
            nuswsalebyform := nvl(nuswsalebyform, ld_boconstans.cnuonenumber);
            /*Obtener el valor individual del subsidio*/
            nusubsidyvalue := Fnugetindividualsubvalue(inupackage_id,
                                                       nuubication,
                                                       nucategori,
                                                       nusubcateg,
                                                       nulocation,
                                                       globalerrorcode,
                                                       globalerrormens);

            /*Validar que el valor del subsidio cuando es nulo. Si asi es porque
            se capturo alguna excepcion en la funcion Fnugetindividualsubvalue*/
            IF nusubsidyvalue IS NULL THEN
                IF (globalerrorcode IS NOT NULL) THEN
                    ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                     globalerrormens);
                ELSE
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     'El valor del Subsidio no puede ser nulo');
                END IF;
            END IF;

            /*Validar cuando el valor del subsidio es cero. Cuando es asi no se hace
            nada para que el flujo de venta no se detenga*/
            IF nusubsidyvalue = ld_boconstans.cnuCero_Value THEN
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'No se puede asignar el subsidio porque el valor del subsidio para la promocion  ' ||
                                   inuPromotion || ' es cero';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            END IF;

            /*Validar que el valor del subsidio sea mayor a cero*/
            /*Validar que se tengan recursos para asignar el subsidio*/
            /*Si el subsidio esta parametrizado por valor autorizado*/
            IF rcubication.authorize_value IS NOT NULL THEN
                IF nusubsidyvalue >
                   nvl(rcubication.total_available, rcubication.authorize_value) THEN
                    globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                    globalerrormens := 'El valor a subsidiar supera la cantidad disponible para la poblacion';
                    ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                     globalerrormens);
                END IF;
            END IF;

            /*Si el subsidio esta parametrizado por cantidad autorizado*/
            IF rcubication.authorize_quantity IS NOT NULL THEN
                IF rcubication.authorize_quantity = rcubication.total_deliver THEN
                    globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                    globalerrormens := 'La cantidad de subsidios parametrizada para la poblacion ya fue asignada';
                    ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                     globalerrormens);
                END IF;
            END IF;

            /*Generar orden de entrega de documentos*/
            Ld_bosubsidy.proccreatedocorder(inupackage_id,
                                            ld_boconstans.cnutwonumber,
                                            nuorderid);

            /*Obtener el numero de registro para la entidad en donde se almacenan los subsidios asignados*/
            nuassigsubsidy := LD_BOSequence.fnuSeqAssigsub;

            /*Registrar asignacion del subsidio*/
            nuassigrecord.asig_subsidy_id := nuassigsubsidy;
            nuassigrecord.susccodi        := fnugetsuscbypackages(inupackage_id);
            nuassigrecord.subsidy_id      := nusubsidy;
            nuassigrecord.promotion_id    := inupromotion;
            nuassigrecord.subsidy_value   := nusubsidyvalue;
            nuassigrecord.order_id        := nuorderid; --orden de entrega de los documentos
            nuassigrecord.delivery_doc    := ld_boconstans.csbNOFlag; --documentos entregados en su totalidad
            nuassigrecord.state_subsidy   := ld_boconstans.cnuinitial_sub_estate; --estado del subsidio, 1:generado
            nuassigrecord.type_subsidy    := isbTipSubsi; --entregado por venta
            nuassigrecord.package_id      := inupackage_id; --solicitud de venta
            nuassigrecord.insert_date     := SYSDATE;
            nuassigrecord.receivable_date := NULL; --fecha en estado cobro
            nuassigrecord.collect_date    := NULL; --fecha en estado cobrado
            nuassigrecord.pay_date        := NULL; --fecha en estado pagado
            nuassigrecord.record_collect  := NULL; --acta de cobro
            nuassigrecord.ubication_id    := nuubication; --Poblacion a subdidiar

            Dald_Asig_Subsidy.insRecord(nuassigrecord);

            /*Actualizar los valores de la ubicacion geografica y el encabezado del subsidio*/
            Procbalancesub(nusubsidy,
                           rcubication,
                           nusubsidyvalue,
                           ld_boconstans.cnuonenumber);

        END IF;
        /*Si el subsidio es de forma retroactiva*/
        IF isbTipSubsi = ld_boconstans.csbretroactivesale THEN
            /*Obtener datos del subsidio*/
            DALD_subsidy.LockByPkForUpdate(nusubsidy, rcsubsidy);
            /*Validar que el subsidio se encuentre vigente*/
            IF rcsubsidy.final_date < SYSDATE THEN
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'No se puede asignar el subsidio ' ||
                                   nusubsidy ||
                                   ' porque este no se encuentra vigente';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            END IF;

            IF globalsuscripc IS NULL THEN
                /*Obtener la suscripcion de la solicitud*/
                nususcripc := Ld_BoSubsidy.fnugetsuscbypackages(inupackage_id);
            ELSE
                /*Obtener la suscripcion del archivo plano de retroactivo*/
                nususcripc := globalsuscripc;
            END IF;

            /*Obtener el servicio suscrito de GAS de la suscripcion*/
            nusesunuse := Ld_bcsubsidy.Fnugetsesunuse(inupackage_id, NULL);
            IF nusesunuse IS NOT NULL THEN
                /*Obtener el valor individual del subsidio*/
                nusubsidyvalue := Fnugetindividualsubvalue(inupackage_id,
                                                           nuubiasigsub,
                                                           nucategori,
                                                           nusubcateg,
                                                           nulocation,
                                                           globalerrorcode,
                                                           globalerrormens);

                /*Validar que el valor del subsidio cuando es nulo. Si asi es porque
                se capturo alguna excepcion en la funcion Fnugetindividualsubvalue*/
                IF nusubsidyvalue IS NULL THEN
                    IF (globalerrorcode IS NOT NULL) THEN
                        ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                         globalerrormens);
                    ELSE
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                         'El valor del Subsidio no puede ser nulo');
                    END IF;
                END IF;

                /*Validar cuando el valor del subsidio es cero. Cuando es asi no se hace
                nada para que el flujo de venta no se detenga*/
                IF nusubsidyvalue = ld_boconstans.cnuCero_Value THEN
                    globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                    globalerrormens := 'No se puede asignar el subsidio porque el valor del subsidio para la promocion  ' ||
                                       inuPromotion || ' es cero';
                    ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                     globalerrormens);
                END IF;

                /*NOTA: la variable nuubiasigsub se le asigna valor en la funcion Ld_Bosubsidy.Fnugetmaxsubvalue*/
                /*Obtener datos de la poblacion*/
                DALD_ubication.LockByPkForUpdate(nuubiasigsub, rcubication);

                /*Validar que se tengan recursos para asignar el subsidio*/
                /*Si el subsidio esta parametrizado por valor autorizado*/
                IF rcubication.authorize_value IS NOT NULL THEN
                    IF nusubsidyvalue >
                       nvl(rcubication.total_available,
                           rcubication.authorize_value) THEN
                        globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                        globalerrormens := 'El valor a subsidiar supera la cantidad disponible para la poblacion';
                        ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                         globalerrormens);
                    END IF;
                END IF;

                /*Si el subsidio esta parametrizado por cantidad autorizada*/
                IF rcubication.authorize_quantity IS NOT NULL THEN
                    IF rcubication.authorize_quantity =
                       rcubication.total_deliver THEN
                        globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                        globalerrormens := 'La cantidad de subsidios parametrizada para la poblacion ya fue asignada';
                        ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                         globalerrormens);
                    END IF;
                END IF;

                /*Cambiar de estado el registro de venta normal a inactivo*/
                /*Obtener el id de registro de la solicitud de venta no subsidiada*/
                nusalewithoutsub := Ld_bcsubsidy.Fnugetidsalewithoutsub(inupackage_id,
                                                                        NULL);

                IF nusalewithoutsub IS NOT NULL THEN
                    Dald_Sales_Withoutsubsidy.updState(nusalewithoutsub,
                                                       ld_boconstans.csbinactive);
                END IF;
                /*Fin cambiar estado el registro de venta normal a inactivo*/

                /*Generar orden de entrega de documentos*/ ---------------------------------------------------
                Ld_bosubsidy.proccreatedocorder(inupackage_id,
                                                ld_boconstans.cnutwonumber,
                                                nuorderid);

                -----------------------------------------------------------------------------------------------

                /*Obtener el numero de registro para la entidad en donde se almacenan los subsidios asignados*/
                nuassigsubsidy := LD_BOSequence.fnuSeqAssigsub;

                /*Registrar asignacion del subsidio*/
                nuassigrecord.asig_subsidy_id := nuassigsubsidy;
                nuassigrecord.susccodi        := Ld_BoSubsidy.fnugetsuscbypackages(inupackage_id);
                nuassigrecord.subsidy_id      := nusubsidy;
                nuassigrecord.promotion_id    := inupromotion;
                nuassigrecord.subsidy_value   := nusubsidyvalue;
                nuassigrecord.order_id        := nuorderid;
                nuassigrecord.delivery_doc    := ld_boconstans.csbNOFlag; --documentos entregados en su totalidad
                nuassigrecord.state_subsidy   := ld_boconstans.cnuinitial_sub_estate; --estado del subsidio, 1:generado
                nuassigrecord.type_subsidy    := isbTipSubsi; --entregado por retroactivo
                nuassigrecord.package_id      := inupackage_id; --solicitud de venta
                nuassigrecord.insert_date     := SYSDATE;
                nuassigrecord.receivable_date := NULL; --fecha en estado cobro
                nuassigrecord.collect_date    := NULL; --fecha en estado cobrado
                nuassigrecord.pay_date        := NULL; --fecha en estado pagado
                nuassigrecord.record_collect  := NULL; --acta de cobro
                nuassigrecord.ubication_id    := nuubiasigsub; --Poblacion a subdidiar

                Dald_Asig_Subsidy.insRecord(nuassigrecord);

                /*Actualizar los valores de la ubicacion geografica y el encabezado del subsidio*/
                Procbalancesub(nusubsidy,
                               rcubication,
                               nusubsidyvalue,
                               ld_boconstans.cnuonenumber);

                /*Insertar los conceptos subsidiados*/
                --Ld_bosubsidy.Procinssubsidyconcept(inupackage_id, nuubication);

                /*Setear el valor del subsidio a otorgar para usarlo en el proceso de mezcla*/
                globalretrosubvalue := NULL;
                globalretrosubvalue := nusubsidyvalue;
            ELSE
                globalerrorcode := Ld_Boconstans.cnuGeneric_Error;
                globalerrormens := 'El cliente no posee un servicio suscrito de gas asociado';
                ge_boerrors.seterrorcodeargument(globalerrorcode,
                                                 globalerrormens);
            END IF;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Assignsubsidy', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Assignsubsidy;

    /************************************************************************
    Propiedad intelectual de Open International Systems (c).

     Unidad         : fnugetUbication
     Descripcion    : Obtiene la ubicacion geografica a subsidiar
     Autor          : Jorge Alejandro Carmona Duque
     Fecha          : 04/10/2013

     Parametros         Descripcion
     ============       ===================
     inusub             identificador del subsidio
     isbParentLocation  Lista de ubicaciones geograficas padres
     inucate            categoria
     inusubcate         subcategoria

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     04/10/2013       JCarmona.SAO218787    Creacion
    /*************************************************************************/
    FUNCTION fnugetUbication(inusub            ld_subsidy.subsidy_id%TYPE,
                             isbParentLocation VARCHAR2,
                             inucate           categori.catecodi%TYPE,
                             inusubcate        subcateg.sucacodi%TYPE)
        RETURN NUMBER IS
        cuGetUbication constants.tyRefcursor;

        sbSQL VARCHAR2(4000) := 'select ld_ubication.ubication_id
                                from ld_ubication LEFT JOIN ge_geogra_location
                                on ge_geogra_location.geograp_location_id = ld_ubication.geogra_location_id
                                where ld_ubication.subsidy_id = :inusub
                                and (SUCACATE = :inuCategori
                                        or SUCACATE is null)
                                and (SUCACODI = :inuSubcategori
                                    or SUCACODI is null )
                                and (geogra_location_id in (' ||
                                isbParentLocation || ')
                                    or geogra_location_id is null)
                                order by SUCACATE asc  nulls last, SUCACODI asc nulls last,
                                ge_geogra_location.geog_loca_area_type desc nulls last';

        nuubication ld_ubication.ubication_id%TYPE;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnugetUbication', pkg_traza.cnuNivelTrzDef);

        OPEN cuGetUbication FOR sbSQL
            USING inusub, inucate, inusubcate;

        FETCH cuGetUbication
            INTO nuubication;
        CLOSE cuGetUbication;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fnugetUbication: ' || nuubication, pkg_traza.cnuNivelTrzDef);
        RETURN nuubication;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnugetUbication;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetmaxsubvalue
       Descripcion    : Obtiene el valor maximo a subsidiar para un cliente
                        Este servicio siempre devolvera negativo para que se
                        cree el cargo credito durante el proceso de venta
                        por formulario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inupromotion     identificador de la promocion
       inuSubscriber    identificador del cliente
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria
       inuoption        opcion a ejecutar de la regla

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
      09-12-2013        sgomez.SAO226500      Se adiciona validacion en liquidacion de venta
                                              de gas, en caso de que un subsidio a aplicar
                                              sobrepase el valor restante en una ubicacion,
                                              categoria y subcategoria.
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetmaxsubvalue(inupromotion  CC_PROMOTION.Promotion_Id%TYPE,
                               inuSubscriber GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                               inuubication  GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE,
                               inucategory   SUBCATEG.Sucacate%TYPE,
                               inusubcateg   SUBCATEG.Sucacodi%TYPE,
                               inuoption     NUMBER) RETURN NUMBER IS

        nuindividualsubsidyvalue ld_subsidy.authorize_value%TYPE;
        rcsubsidy                dald_subsidy.styLD_subsidy;
        nusubsidy                ld_subsidy.subsidy_id%TYPE;
        nuubication              ld_ubication.ubication_id%TYPE;
        nupromtype               cc_promotion.prom_type_id%TYPE;
        --
        nuaddress_id      GE_SUBSCRIBER.address_id%TYPE;
        nucategori        SUBCATEG.Sucacate%TYPE;
        nusubcateg        SUBCATEG.Sucacodi%TYPE;
        nulocation        GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE;
        rcMotive          damo_motive.styMO_motive;
        nupackages_id     mo_packages.package_id%TYPE;
        nuAddressTemp     mo_packages.address_id%TYPE;
        sbCurrinstance    VARCHAR2(200);
        sbFatherInstance  VARCHAR2(200);
        rcAddress         daab_address.styAb_address;
        nuNeighborthoodId ab_address.neighborthood_id%TYPE;
        sbParentLocation  VARCHAR2(4000);

        -- Subsidio por ubicacion
        rcUbication ld_ubication%ROWTYPE;
        -- Fecha solicitud venta
        dtRequestDate mo_packages.request_date%TYPE;
        --Variable de validacion
        nuCode NUMBER;

        nuerrorcode ge_error_log.error_log_id%TYPE;
        sbErrorMSG  VARCHAR2(2000);

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetmaxsubvalue, inupromotion[' ||
                       inupromotion || ']inuSubscriber[' || inuSubscriber ||
                       ']inuubication[' || inuubication || ']inucategory[' ||
                       inucategory,
                       10);

        nuindividualsubsidyvalue := 0;

        /*Validar que la promocion sea tipo 3: subsidios*/
        nupromtype := Dacc_Promotion.fnuGetProm_Type_Id(inupromotion);

        IF nupromtype <> ld_boconstans.cnuPromotionType THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El tipo de promocion no es subsidiada');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar ingreso de la ubicacion geografica, categoria y subcategoria*/
        IF inuubication IS NULL OR inucategory IS NULL OR inusubcateg IS NULL THEN
            /*Obtener el registo de mo_motive asociado a la solicitud de venta*/
            pkInstanceDataMgr.GetRecordMotive(rcMotive);
            IF rcMotive.package_id IS NOT NULL THEN
                nupackages_id := rcMotive.package_id;
                /*Validar que se encuentre direccion asociada a la solicitud*/
                nuaddress_id := damo_packages.fnugetaddress_id(nupackages_id,
                                                               NULL);
                IF nuaddress_id IS NOT NULL THEN
                    Ld_Bosubsidy.Procgetdatesforpackages(nupackages_id,
                                                         nulocation,
                                                         nucategori,
                                                         nusubcateg);
                    IF nulocation IS NULL THEN
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                         'No se encontro ubicacion geografica asociada a la solicitud de venta: ' ||
                                                         nupackages_id);
                        RAISE pkg_error.CONTROLLED_ERROR;
                    END IF;

                    IF nucategori IS NULL THEN
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                         'No se encontro categoria asociada a la solicitud de venta: ' ||
                                                         nupackages_id);
                        RAISE pkg_error.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     'No se encontro direccion asociada a la solicitud de venta: ' ||
                                                     nupackages_id);
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;
            ELSE
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No se encontro la solicitud de venta');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

        ELSE
            /*Obtener la ubicacion geografica*/
            nulocation := inuubication;
            /*Obtener categoria y subcategoria del predio*/
            nucategori := inucategory;
            nusubcateg := inusubcateg;
            /*Obtener el registo de mo_motive asociado a la solicitud de venta*/
            pkInstanceDataMgr.GetRecordMotive(rcMotive);
            IF rcMotive.package_id IS NOT NULL THEN
                nupackages_id := rcMotive.package_id;
            END IF;
        END IF;

        /*Instrucciones para obtener el valor individual de un subsidio*/
        /*Obtener el subsidio asociado a una promocion*/
        nusubsidy := ld_bcsubsidy.Fnugetpromsubsidy(inupromotion, NULL);
        /*Validar que el subsidio exista*/
        IF NOT dald_subsidy.fblExist(nusubsidy) THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El subsidio ' || nusubsidy ||
                                             ' no existe');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Obtener datos del subsidio*/
        DALD_subsidy.LockByPkForUpdate(nusubsidy, rcsubsidy);
        /* Se obtienen los datos de la solicitud*/
        nuAddressTemp := damo_packages.fnugetaddress_id(nupackages_id);
        UT_Trace.Trace('rcPackages:' || nuAddressTemp, 1);

        IF (nuAddressTemp IS NULL) THEN
            -- para la simulacion se debe obtener de la informacion en memoria
            IF ge_boinstancecontrol.fblisinitinstancecontrol THEN
                GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrinstance);
                UT_Trace.Trace('Instance1 address: ' || sbCurrinstance, pkg_traza.cnuNivelTrzDef);
                ge_boinstancecontrol.getfatherinstance(sbCurrinstance,
                                                       sbFatherInstance);
                UT_Trace.Trace('father instance1: ' || sbFatherInstance, pkg_traza.cnuNivelTrzDef);
                ge_boinstancecontrol.getattributenewvalue(sbFatherInstance,
                                                          NULL,
                                                          'MO_PROCESS',
                                                          'ADDRESS_MAIN_MOTIVE',
                                                          nuAddressTemp);
            END IF;
        END IF;

        /* Se obtienen los datos de la direccion */
        rcAddress := daab_address.frcgetrcdata(nuAddressTemp);
        UT_Trace.Trace('rcAddress:' || rcAddress.neighborthood_id, 1);
        nuNeighborthoodId := rcAddress.neighborthood_id;

        /* Se valida que la direccion tenga asociado un barrio */
        IF (nuNeighborthoodId IS NULL OR
           nuNeighborthoodId = LD_BOConstans.cnuallrows) THEN
            UT_Trace.Trace('La direccion No Tiene barrio asociado', 1);
            /*Obtener el codigo de la ubicacion geografica*/
            nuubication := Fnugetsububication(nusubsidy,
                                              nulocation,
                                              nucategori,
                                              nusubcateg);
        ELSE
            UT_Trace.Trace('La direccion Si Tiene barrio asociado', 1);
            /* Se obtienen todos las localidades padre del barrio */
            ge_bogeogra_location.GetGeograpParents(nuNeighborthoodId,
                                                   sbParentLocation);
            /*Obtener el codigo de la ubicacion geografica*/
            nuubication := fnugetUbication(nusubsidy,
                                           sbParentLocation,
                                           nucategori,
                                           nusubcateg);
        END IF;

        /*Validar que la poblacion exista*/
        IF NOT dald_ubication.fblExist(nuubication) THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'La poblacion ' || nuubication ||
                                             ' no existe');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        IF nuubication IS NULL THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se encontro ubicacion para determinar el valor de la promocion');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        IF nupackages_id IS NOT NULL THEN
            nuindividualsubsidyvalue := Fnugetindividualsubvalue(nupackages_id,
                                                                 nuubication,
                                                                 nucategori,
                                                                 nusubcateg,
                                                                 nulocation,
                                                                 globalerrorcode,
                                                                 globalerrormens);

            --santiman_start
            IF (nvl(nuindividualsubsidyvalue, 0) > 0) THEN

                UT_Trace.Trace('nuindividualsubsidyvalue  = ',
                               to_char(nuindividualsubsidyvalue),
                               10);

                dtRequestDate := trunc(DAMO_Packages.fdtGetRequest_Date(nupackages_id));

                UT_Trace.Trace('inupromotion  = ', to_char(inupromotion), pkg_traza.cnuNivelTrzDef);
                UT_Trace.Trace('dtRequestDate = ',
                               to_char(dtRequestDate, 'DD-MM-YYYY'),
                               10);
                UT_Trace.Trace('nuAddressTemp = ', to_char(nuAddressTemp), pkg_traza.cnuNivelTrzDef);
                UT_Trace.Trace('inucategory   = ', to_char(inucategory), pkg_traza.cnuNivelTrzDef);
                UT_Trace.Trace('inusubcateg   = ', to_char(inusubcateg), pkg_traza.cnuNivelTrzDef);

                -- Obtiene subsidio para ubicacion geografica/categoria/subcategoria
                rcUbication := Ld_BcSubsidy.frcAvlbleSubsidyByLoc(inupromotion,
                                                                  dtRequestDate,
                                                                  nuAddressTemp,
                                                                  inucategory,
                                                                  inusubcateg);

                UT_Trace.Trace('ubication_id       = ',
                               to_char(rcUbication.ubication_id),
                               10);
                UT_Trace.Trace('authorize_value    = ',
                               to_char(rcUbication.authorize_value),
                               10);
                UT_Trace.Trace('total_available    = ',
                               to_char(rcUbication.total_available),
                               10);
                UT_Trace.Trace('authorize_value    = ',
                               to_char(rcUbication.authorize_value),
                               10);
                UT_Trace.Trace('authorize_quantity = ',
                               to_char(rcUbication.authorize_quantity),
                               10);
                UT_Trace.Trace('total_deliver      = ',
                               to_char(rcUbication.total_deliver),
                               10);

                nuCode := ld_bcsubsidy.FnuGetPackAsig(nupackages_id,
                                                      rcUbication.ubication_id);

                UT_Trace.Trace('nuCode             = ' || nuCode);

                IF (nuCode = 0) THEN
                    /* Subsidio por VALOR */
                    IF (rcUbication.authorize_value IS NOT NULL) THEN
                        -- Valida si subsidio a otorgar sobrepasa valor disponible para ubicacion geo
                        IF (nuindividualsubsidyvalue >
                           nvl(rcUbication.total_available,
                                rcubication.authorize_value)) THEN
                            GE_BOErrors.SetErrorCodeArgument(LD_BOConstans.cnuGeneric_Error,
                                                             'El valor a otorgar del subsidio ($' ||
                                                             to_char(nuindividualsubsidyvalue) || ')' ||
                                                             ' es mayor que el valor disponible para la poblacion ($' ||
                                                             to_char(nvl(rcUbication.total_available,
                                                                         rcubication.authorize_value)) || ')');
                            RAISE pkg_error.CONTROLLED_ERROR;
                        END IF;
                    END IF;

                    /* Subsidio por CANTIDAD */
                    IF (rcUbication.authorize_quantity IS NOT NULL) THEN
                        IF (rcUbication.authorize_quantity =
                           rcUbication.total_deliver) THEN
                            GE_BOErrors.SetErrorCodeArgument(LD_BOConstans.cnuGeneric_Error,
                                                             'La cantidad de subsidios (' ||
                                                             to_char(rcUbication.authorize_quantity) || ')' ||
                                                             ' para la poblacion, ya fue otorgada en su totalidad');
                            RAISE pkg_error.CONTROLLED_ERROR;
                        END IF;
                    END IF;
                END IF;
            END IF;

        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetmaxsubvalue', pkg_traza.cnuNivelTrzDef);
        IF nuindividualsubsidyvalue > ld_boconstans.cnuCero_Value THEN
            --Se multiplica por -1 para que genere un cargo credito por el valor del subsidio
            nuindividualsubsidyvalue := (nuindividualsubsidyvalue * -1);
        END IF;

        RETURN(nuindividualsubsidyvalue);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            -- si se debe validar se genera error
            IF (gblValDataSubsidy) THEN
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                errors.geterror(nuerrorcode, sbErrorMSG);
                UT_Trace.Trace('Error Liquidando tarifa=' || sbErrorMSG, 15);
                RETURN 0;
            END IF;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetmaxsubvalue;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : validateConcepts
       Descripcion    : Realiza el traslado de subsidios
       Autor          : jonathan alberto consuegra lara
       Fecha          : 04/09/2013

       Parametros                Descripcion
       ============              ===================
       inuUbicatiBeginId         Codigo de la ubicacion origen
       inuUbicatiDestinyId       Codigo de la ubicacion destino

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       04/09/2013       hvera.SAO214139       Creacion.
    /*************************************************************************/
    PROCEDURE validateConcepts(inuUbicatiBeginId   IN ld_ubication.ubication_id%TYPE,
                               inuUbicatiDestinyId IN ld_ubication.ubication_id%TYPE) IS

        orfDetailBegin   pkConstante.tyRefCursor;
        orfDetailDestiny pkConstante.tyRefCursor;

        tbDetailBegin   dald_subsidy_detail.tytbLD_subsidy_detail;
        tbDetailDestiny dald_subsidy_detail.tytbLD_subsidy_detail;

        nuIndexBegin  NUMBER;
        nuIndexDetiny NUMBER;

        nuConceptBegin   ld_subsidy_detail.conccodi%TYPE;
        nuConceptDestiny ld_subsidy_detail.conccodi%TYPE;

        nuValConcBegin   ld_subsidy_detail.subsidy_value%TYPE;
        nuValConcDestiny ld_subsidy_detail.subsidy_value%TYPE;

        blFlag BOOLEAN;
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.validateConcepts', 5);
        UT_Trace.Trace('inuUbicatiBeginId ' || inuUbicatiBeginId ||
                       ' inuUbicatiDestinyId ' || inuUbicatiDestinyId,
                       5);

        Ld_BcSubsidy.Procgetubiconc(inuUbicatiBeginId, orfDetailBegin);

        FETCH orfDetailBegin BULK COLLECT
            INTO tbDetailBegin;
        CLOSE orfDetailBegin;

        Ld_BcSubsidy.Procgetubiconc(inuUbicatiDestinyId, orfDetailDestiny);

        FETCH orfDetailDestiny BULK COLLECT
            INTO tbDetailDestiny;
        CLOSE orfDetailDestiny;

        --Se recorre la coleccion de conceptos del subsidio origen para validar si
        --estan contendidos en el subsidio destino y que tengan el mismo valor

        nuIndexBegin := tbDetailBegin.first;
        WHILE (nuIndexBegin IS NOT NULL) LOOP
            nuConceptBegin := tbDetailBegin(nuIndexBegin).conccodi;
            nuValConcBegin := tbDetailBegin(nuIndexBegin).subsidy_value;
            UT_Trace.Trace('Begin nuConceptBegin ' || nuConceptBegin ||
                           ' nuValConcBegin ' || nuValConcBegin,
                           5);

            blFlag := FALSE;

            nuIndexDetiny := tbDetailDestiny.first;
            WHILE (nuIndexDetiny IS NOT NULL) LOOP

                nuConceptDestiny := tbDetailDestiny(nuIndexDetiny).conccodi;
                nuValConcDestiny := tbDetailDestiny(nuIndexDetiny).subsidy_value;
                UT_Trace.Trace('Destiny nuConceptDestiny ' || nuConceptDestiny ||
                               ' nuValConcDestiny ' || nuValConcDestiny,
                               5);

                IF (nuConceptBegin = nuConceptDestiny AND
                   nuValConcBegin = nuValConcDestiny) THEN
                    blFlag := TRUE;
                    EXIT;
                END IF;
                nuIndexDetiny := tbDetailDestiny.next(nuIndexDetiny);
            END LOOP;

            IF (NOT blFlag) THEN
                GE_BOErrors.SetErrorCodeArgument(ld_boconstans.cnuGeneric_Error,
                                                 'La parametrizacion de conceptos del subsidio origen y del destino no son correspondientes');
            END IF;
            nuIndexBegin := tbDetailBegin.next(nuIndexBegin);
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.validateConcepts', 5);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END validateConcepts;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Movesubsidy
       Descripcion    : Realiza el traslado de subsidios
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros                Descripcion
       ============              ===================
       inuasig_subsidy_id        Codigo de subsdio asignado
       inuCurrent                valor numerico
       inuTotal                  valor numerico
       onuErrorCode              valor numerico
       osbErrorMessage           valor numerico

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       11-12-2013       sgomez.SAO227083      Se modifica insercion en el historico
                                              para adicionar nuevo campo "Valor
                                              Transferido".
                                              Se modifica validacion de valor a
                                              asignar, para habilitar el caso en
                                              el que, el subsidio a trasladar es
                                              IGUAL al subsidio restante.
                                              Se adiciona actualizacion en motivo por
                                              promocion (mo_mot_promotion) para
                                              asignar la nueva promocion (subsidio)
                                              luego de traslado.
                                              Se modifica actualizacion de subsidio
                                              otorgado (ld_asig_subsidy) para
                                              asignar ID de promocion del nuevo
                                              subsidio (destino).
       04/09/2013       hvera.SAO214139       Se modifica para validar que el grupo de conceptos del
                                              subsidio origen este contenido dentro del grupo de
                                              conceptos del subsidio destino.
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Movesubsidy(inuasig_subsidy_id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                          inuCurrent         IN NUMBER,
                          inuTotal           IN NUMBER,
                          onuErrorCode       OUT NUMBER,
                          osbErrorMessage    OUT VARCHAR2) IS

        nuSusccdoi          ld_asig_subsidy.susccodi%TYPE;
        nuSubsidyBegin_ID   ge_boInstanceControl.stysbValue;
        nuSubsidyDestiny_ID ge_boInstanceControl.stysbValue;

        nuubication ld_ubication.ubication_id%TYPE;

        rcAsigSubsidy Dald_Asig_Subsidy.styLD_Asig_Subsidy;

        rcSubsidyBegin     dald_subsidy.styLD_subsidy;
        rcSubsidyDestiny   dald_subsidy.styLD_subsidy;
        rcUbicationBegin   dald_ubication.styLD_ubication;
        rcUbicationDestiny dald_ubication.styLD_ubication;

        nuubitotal_deliver   ld_ubication.total_deliver%TYPE;
        nuubitotal_available ld_ubication.total_available%TYPE;
        nusubtotal_deliver   ld_subsidy.total_deliver%TYPE;
        nusubtotal_available ld_subsidy.total_available%TYPE;

        rcmovesub dald_move_sub.styLD_move_sub;
        --
        nusubbeginstate     ld_asig_subsidy.state_subsidy%TYPE;
        sbtransfer          ld_subsidy_states.activate%TYPE;
        nupackage_id        mo_packages.package_id%TYPE;
        nulocation          ge_geogra_location.geograp_location_id%TYPE;
        nucategori          categori.catecodi%TYPE;
        nusubcategory       subcateg.sucacodi%TYPE;
        nuconceptsubbegin   ld_subsidy.Conccodi%TYPE;
        nuconceptsubdestiny ld_subsidy.Conccodi%TYPE;
        nuSubsidyBegin      ld_subsidy.subsidy_id%TYPE;

        /* ID de promocion por motivo */
        nuIDMotPromo mo_mot_promotion.mot_promotion_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Movesubsidy inuasig_subsidy_id ' ||
                       inuasig_subsidy_id,
                       10);
        UT_Trace.Trace('inuCurrent ' || inuCurrent || ' inuTotal ' || inuTotal,
                       10);

        nuSubsidyBegin_ID   := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                                     'SUBSIDY_ID');
        nuSubsidyDestiny_ID := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                                     'SUBSIDY_ID');

        /*Registro de asignacion de subsidio*/
        Dald_Asig_Subsidy.getRecord(inuasig_subsidy_id, rcAsigSubsidy);
        nuSusccdoi := rcAsigSubsidy.susccodi;

        /*Validar suscriptor*/
        IF nuSusccdoi IS NULL THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El codigo del suscriptor no debe ser nulo';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        /*Validar que el flag de traslado del origen este activo*/
        nusubbeginstate := rcAsigSubsidy.state_subsidy;
        sbtransfer      := dald_subsidy_states.fsbGetActivate(nusubbeginstate);
        nupackage_id    := rcAsigSubsidy.Package_Id;

        IF nvl(sbtransfer, 'X') <> 'Y' THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El flag del estado del subsidio origen no se encuentra activo';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        IF SYSDATE > dald_subsidy.fdtGetFinal_Date(nuSubsidyDestiny_Id) THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El subsidio destino no se encuentra vigente';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        IF nuSubsidyBegin_Id = nuSubsidyDestiny_Id THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El codigo del subsidio origen es igual al codigo del subsidio destino';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        /*Validar que el subsidio de origen digitado en la busqueda sea el
        mismo que posee el usuario*/

        nuSubsidyBegin := rcAsigSubsidy.Subsidy_Id;

        IF nuSubsidyBegin <> nuSubsidyBegin_ID THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El codigo del subsidio origen no corresponde al que el usuario tiene asignado';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        /*Validar que el concepto de aplicacion del subsidio origen y destino sean los mismos*/
        nuconceptsubbegin := dald_subsidy.fnuGetConccodi(nuSubsidyBegin_Id);
        UT_Trace.Trace('Concepto del subsidio origen ' || nuconceptsubbegin,
                       10);

        nuconceptsubdestiny := dald_subsidy.fnuGetConccodi(nuSubsidyDestiny_Id);
        UT_Trace.Trace('Concepto del subsidio destino ' || nuconceptsubdestiny,
                       10);

        IF nvl(nuconceptsubbegin, -1) <> nvl(nuconceptsubdestiny, -2) THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El concepto de aplicacion del subsidio origen es diferente al concepto de aplicacion del subsidio destino';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        /*Obtener la ubicacion geografica, categoria y subcategoria de la solicitud de venta*/
        Procgetdatesforpackages(nupackage_id,
                                nulocation,
                                nucategori,
                                nusubcategory);
        UT_Trace.Trace('Datos de la venta nulocation: ' || nulocation ||
                       ' nucategori: ' || nucategori || ' nusubcategory: ' ||
                       nusubcategory,
                       10);

        /*Ubicacion donde se realizara el traslado del subsidio*/
        nuubication := Fnugetsububication(nuSubsidyDestiny_ID,
                                          nulocation,
                                          nucategori,
                                          nusubcategory);

        IF nuubication IS NULL THEN
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'No existe Poblacion valida para el traslado del subsidio';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        validateConcepts(rcAsigSubsidy.Ubication_Id, nuubication);
        /*Registro de subsidio origen*/
        DALD_subsidy.LockByPkForUpdate(nuSubsidyBegin_ID, rcSubsidyBegin);
        /*Registro de ubicacion origen*/
        DALD_ubication.LockByPkForUpdate(rcAsigSubsidy.Ubication_Id, rcUbicationBegin);
        /*Registro de subsidio destino*/
        DALD_subsidy.LockByPkForUpdate(nuSubsidyDestiny_ID, rcSubsidyDestiny);
        /*Registro de ubicacion destino*/
        DALD_ubication.LockByPkForUpdate(nuubication, rcUbicationDestiny);
        /*Subsidio y Ubicacion destino*/
        IF rcSubsidyDestiny.authorize_value IS NOT NULL AND
           rcUbicationDestiny.authorize_value IS NOT NULL THEN
            IF rcAsigSubsidy.subsidy_value <=
               (rcUbicationDestiny.authorize_value -
               nvl(rcUbicationDestiny.total_deliver,
                    ld_boconstans.cnuCero_Value)) THEN

                /*Actualizar ubicacion Destino*/
                --total entregado
                nuubitotal_deliver := nvl(rcUbicationDestiny.total_deliver,
                                          ld_boconstans.cnuCero_Value) +
                                      rcAsigSubsidy.subsidy_value;
                --total disponible
                IF NVL(rcUbicationDestiny.total_available, 0) = 0 THEN
                    nuubitotal_available := nvl(rcUbicationDestiny.authorize_value,
                                                ld_boconstans.cnuCero_Value) -
                                            rcAsigSubsidy.subsidy_value;
                ELSE
                    nuubitotal_available := nvl(rcUbicationDestiny.total_available,
                                                ld_boconstans.cnuCero_Value) -
                                            rcAsigSubsidy.subsidy_value;
                END IF;

                Dald_Ubication.updTotal_Deliver(nuubication,
                                                nuubitotal_deliver);
                Dald_Ubication.updtotal_available(nuubication,
                                                  nuubitotal_available);

                /*Actualizar encabezado del subsidio Destino*/
                --total entregado
                nusubtotal_deliver := nvl(rcSubsidyDestiny.total_deliver,
                                          ld_boconstans.cnuCero_Value) +
                                      rcAsigSubsidy.subsidy_value;

                --total disponible
                IF NVL(rcSubsidyDestiny.total_available, 0) = 0 THEN
                    nusubtotal_available := nvl(rcSubsidyDestiny.authorize_value,
                                                ld_boconstans.cnuCero_Value) -
                                            rcAsigSubsidy.subsidy_value;
                ELSE
                    nusubtotal_available := nvl(rcSubsidyDestiny.total_available,
                                                ld_boconstans.cnuCero_Value) -
                                            rcAsigSubsidy.subsidy_value;
                END IF;

                Dald_Subsidy.updTotal_Deliver(nuSubsidyDestiny_ID,
                                              nusubtotal_deliver);
                Dald_Subsidy.updTotal_Available(nuSubsidyDestiny_ID,
                                                nusubtotal_available);

                /*Subsidio y Ubicacion origen*/
                /*Actualizar ubicacion Origen*/
                --total entregado
                nuubitotal_deliver := nvl(rcUbicationBegin.total_deliver,
                                          ld_boconstans.cnuCero_Value) -
                                      rcAsigSubsidy.subsidy_value;

                --total disponible
                nuubitotal_available := nvl(rcUbicationBegin.total_available,
                                            ld_boconstans.cnuCero_Value) +
                                        rcAsigSubsidy.subsidy_value;

                Dald_Ubication.updTotal_Deliver(rcAsigSubsidy.Ubication_id,
                                                nuubitotal_deliver);
                Dald_Ubication.updtotal_available(rcAsigSubsidy.Ubication_id,
                                                  nuubitotal_available);

                /*Actualizar encabezado del subsidio Origen*/
                --total entregado
                nusubtotal_deliver := nvl(rcSubsidyBegin.total_deliver,
                                          ld_boconstans.cnuCero_Value) -
                                      rcAsigSubsidy.subsidy_value;
                --total disponible
                nusubtotal_available := nvl(rcSubsidyBegin.total_available,
                                            ld_boconstans.cnuCero_Value) +
                                        rcAsigSubsidy.subsidy_value;

                /*Se setea esta varibale para que no valide que el
                subsidio origen tenga que estar vigente*/
                globaltransfersub := 'S';

                Dald_Subsidy.updTotal_Deliver(nuSubsidyBegin_ID,
                                              nusubtotal_deliver);
                Dald_Subsidy.updTotal_Available(nuSubsidyBegin_ID,
                                                nusubtotal_available);
                /*fin Subsidio y Ubicacion origen*/
                /*Cambio de subsidio de asignacion*/
                dald_asig_subsidy.updSubsidy_Id(inuasig_subsidy_id,
                                                nuSubsidyDestiny_ID);

                /*Cambio de ubicacion de asignacion*/
                dald_asig_subsidy.updUbication_Id(inuasig_subsidy_id,
                                                  nuubication);
                /*fin Cambio de subsidio de asignacion*/

                /* Se actualiza ID de promocion */
                DALD_asig_subsidy.updPromotion_Id(inuasig_subsidy_id,
                                                  rcSubsidyDestiny.promotion_id);

            ELSE
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'El valor a trasladar del subsidio es mayor a valor disponible en la poblacion del subsidio destino';
                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
            END IF;
        ELSE

            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'El valor autorizado de la poblacion o del subsidio es nulo';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);

        END IF;
        /*fin Subsidio y Ubicacion destino*/

        rcmovesub.move_sub_id       := ld_bosequence.fnuSeqMoveSub;
        rcmovesub.susccodi          := nuSusccdoi;
        rcmovesub.source_sub        := nuSubsidyBegin_ID;
        rcmovesub.target_sub        := nuSubsidyDestiny_ID;
        rcmovesub.move_date         := SYSDATE;
        rcmovesub.user_id           := GE_BOPersonal.fnuGetPersonId;
        rcmovesub.terminal          := userenv('TERMINAL');
        rcmovesub.transferred_value := rcAsigSubsidy.subsidy_value;

        dald_move_sub.insRecord(rcmovesub);

        /* Se actualiza motivo por promocion */
        nuIDMotPromo := Ld_BcSubsidy.fnuMotPromotionByPack(rcAsigSubsidy.package_id,
                                                           rcAsigSubsidy.promotion_id);
        IF (nuIDMotPromo IS NOT NULL) THEN
            DAMO_Mot_Promotion.UpdPromotion_Id(nuIDMotPromo,
                                               rcSubsidyDestiny.promotion_id);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Movesubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            Errors.GetError(onuErrorCode, osbErrorMessage);
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.SetError;
            Errors.GetError(onuErrorCode, osbErrorMessage);
    END Movesubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetconcvalue
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
     04/08/2014       agordillo             NC 1008,1010,1011
                                          Se obtiene el producto, para parsarlo como parametro a la funcion
                                          de obtener la tarifa, dado que en el momento que se estaba ejecutando,
                                          llegaba null generando el siguiente error:
                                          "No se encontro servicio suscrito en memoria"
                                          se agrega la el llamado a la funcion
                                           gbProductId := Ld_bcsubsidy.Fnugetsesunuse(globalnupackage_id, null)

    ******************************************************************/
    FUNCTION Fnugetconcvalue(inuconc      concepto.conccodi%TYPE,
                             inuserv      servicio.servcodi%TYPE,
                             inucate      categori.catecodi%TYPE,
                             inusubcate   subcateg.sucacodi%TYPE,
                             inuubication ge_geogra_location.geograp_location_id%TYPE,
                             idtfecha     ta_vigetaco.vitcfein%TYPE) RETURN NUMBER IS

        nuCodTarifa     ta_tariconc.tacocons%TYPE;
        nuCodVigencia   ta_vigetaco.vitccons%TYPE;
        nuValorTarifa   ta_vigetaco.vitcvalo%TYPE;
        nuValorAplicado ta_vigetaco.vitcvalo%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetconcvalue', pkg_traza.cnuNivelTrzDef);

        /*Instanciar categoria*/
        ta_bocriteriosbusqueda.EstCriterioMemoria(ta_bocriteriosbusqueda.fsbCategori,
                                                  nvl(inucate,
                                                      ld_boconstans.cnuallrows));

        /*Instanciar subcategoria*/
        ta_bocriteriosbusqueda.EstCriterioMemoria(ta_bocriteriosbusqueda.fsbSubcateg,
                                                  nvl(inusubcate,
                                                      ld_boconstans.cnuallrows));

        /*Instanciar ubicacion geografica*/
        ta_bocriteriosbusqueda.EstCriterioMemoria(ta_bocriteriosbusqueda.fsbLocalida,
                                                  nvl(inuubication,
                                                      ld_boconstans.cnuallrows));

        /*  04/08/2014 agordillo NC 1008,1010,1011
            Se obtiene el producto, para parsarlo como parametro a la funcion
            de obtener la tarifa
        */

        gbProductId := Ld_bcsubsidy.Fnugetsesunuse(globalnupackage_id, NULL);

        UT_Trace.Trace('inuproducto = ' || gbProductId, pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('idtfechaperiodoini = ' || idtfecha, pkg_traza.cnuNivelTrzDef);

        /*Obtener tarifa del concepto*/
        ta_botarifas.liqtarifavalor(inuservicio        => inuserv,
                                    inuconcepto        => inuconc,
                                    inuproducto        => gbProductId,
                                    inucontrato        => NULL,
                                    idtfechaperiodoini => idtfecha,
                                    idtfechaperiodofin => idtfecha,
                                    idtfechavigtarifas => idtfecha,
                                    idtfechaliqini     => NULL,
                                    idtfechaliqfin     => NULL,
                                    inufot             => Ld_Boconstans.cnuonenumber,
                                    inuunidades        => Ld_Boconstans.cnuonenumber,
                                    ibopermpers        => FALSE,
                                    onucodtarifa       => nucodtarifa,
                                    onucodvigencia     => nucodvigencia,
                                    onuvalortarifa     => nuvalortarifa,
                                    onuvaloraplicado   => nuvaloraplicado);

        UT_Trace.Trace('nuvalortarifa = ' || nuvalortarifa, pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetconcvalue', pkg_traza.cnuNivelTrzDef);

        RETURN(nuvalortarifa);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetconcvalue;
    --
    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : FsbConverttobin
       Descripcion    : Transforma un valor numerico en binario
       Autor          : jonathan alberto consuegra lara
       Fecha          : 10/10/2012

       Parametros       Descripcion
       ============     ===================
       inuDeal_Id       identificador del convenio

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       10/10/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION FsbConverttobin(inuValnum IN NUMBER) RETURN VARCHAR2 IS
        /* DECLARACion DE VARIABLES */
        nuCopiNume NUMBER;
        nuResi     NUMBER;
        sbBina     VARCHAR2(100);

    BEGIN
        IF inuValnum <= 0 THEN
            RETURN '0';
        END IF;
        sbBina     := '';
        nuCopiNume := inuValnum;
        WHILE (nuCopiNume > 0) LOOP
            nuResi     := MOD(nuCopiNume, 2);
            nuCopiNume := trunc(nuCopiNume / 2);
            sbBina     := to_char(nuResi) || sbBina;
        END LOOP;
        RETURN sbBina;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbConverttobin;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetsububication
       Descripcion    : Obtiene la ubicacion geografica a subsidiar
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inusub           identificador del subsidio
       inuloca          ubicacion geografica
       inucate          categoria
       inusubcate       subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetsububication(inusub     ld_subsidy.subsidy_id%TYPE,
                                inuloca    ld_ubication.geogra_location_id%TYPE,
                                inucate    categori.catecodi%TYPE,
                                inusubcate subcateg.sucacodi%TYPE) RETURN NUMBER IS

        CURSOR cuubication(inulocation    VARCHAR2,
                           inuCategori    VARCHAR2,
                           inuSubcategori VARCHAR2) IS
            SELECT l.ubication_id
            FROM   ld_ubication l
            WHERE  l.subsidy_id = inusub
            AND    Nvl(l.geogra_location_id, LD_BOConstans.cnuallrows) =
                   Decode(inulocation,
                           '1',
                           inuloca,
                           LD_BOConstans.cnuallrows /*l.geogra_location_id*/)
            AND    Nvl(l.sucacate, LD_BOConstans.cnuallrows) =
                   Decode(inuCategori,
                           '1',
                           inucate,
                           LD_BOConstans.cnuallrows /*l.sucacate*/)
            AND    Nvl(l.sucacodi, LD_BOConstans.cnuallrows) =
                   Decode(inuSubcategori,
                           '1',
                           inusubcate,
                           LD_BOConstans.cnuallrows /*l.sucacate*/);

        --nuCont      number;
        nuValPar    NUMBER;
        nuubication ld_ubication.ubication_id%TYPE;
        sbContBina  VARCHAR2(100);
        csbfirstcombination  CONSTANT VARCHAR2(3) := '111';
        csbsecondcombination CONSTANT VARCHAR2(3) := '110';
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetsububication', pkg_traza.cnuNivelTrzDef);

        nuValPar := LD_BOConstans.cnuCero_Value;

        --nuCont := LD_BOConstans.cnubinarythreenumber;

        sbContBina := csbfirstcombination;

        WHILE (nuValPar = LD_BOConstans.cnuCero_Value) LOOP

            OPEN cuubication(Substr(sbContBina,
                                    LD_BOConstans.cnuonenumber,
                                    LD_BOConstans.cnuonenumber),
                             Substr(sbContBina,
                                    LD_BOConstans.cnutwonumber,
                                    LD_BOConstans.cnuonenumber),
                             Substr(sbContBina,
                                    LD_BOConstans.cnuthreenumber,
                                    LD_BOConstans.cnuonenumber));

            FETCH cuubication
                INTO nuubication;

            IF cuubication%NOTFOUND THEN
                IF sbContBina = csbsecondcombination THEN
                    nuValPar := LD_BOConstans.cnuonenumber;
                ELSE
                    sbContBina := csbsecondcombination;
                END IF;
            ELSE
                nuValPar := LD_BOConstans.cnuonenumber;
            END IF;

            CLOSE cuubication;
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetsububication', pkg_traza.cnuNivelTrzDef);

        RETURN(nuubication);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetsububication;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetphonesclient
       Descripcion    : Obtiene los telefonos de un cliente
       Autor          : jonathan alberto consuegra lara
       Fecha          : 22/12/2012

       Parametros       Descripcion
       ============     ===================
       inusubscriber    identificador del cliente

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       22/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetphonesclient(inusubscriber ge_subscriber.subscriber_id%TYPE)
        RETURN VARCHAR2 IS

        rfphones           pkConstante.tyRefCursor;
        rfsubscriberphones dage_subs_phone.styGE_subs_phone;
        sbphones           VARCHAR2(1000);
        --nuphones           number;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetphonesclient', pkg_traza.cnuNivelTrzDef);

        Ld_bcsubsidy.Procsubscribephones(inusubscriber, rfphones);

        LOOP
            FETCH rfphones
                INTO rfsubscriberphones;
            EXIT WHEN rfphones%NOTFOUND;
            IF sbphones IS NULL THEN
                sbphones := rfsubscriberphones.phone;
            ELSE
                sbphones := sbphones || ', ' || rfsubscriberphones.phone;
            END IF;
        END LOOP;

        RETURN(sbphones);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetphonesclient', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END;
    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : finDaysAble
       Descripcion    : Obtiene la cantidad de dias habiles entre un rando de fechas.
       Autor          : Adolfo Jimenez
       Fecha          : 26/11/2012

       Parametros       Descripcion
       ============     ===================
       inucountry      Pais/Localidad
       idtIni          Fecha inicial
       idtFin          Fecha final

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       26/11/2012       ajimenez.SAO156577    Creacion
    /*************************************************************************/
    FUNCTION fnuGetDaysAble(inucountry IN ge_calendar.country_id%TYPE,
                            idtIni     IN DATE,
                            idtFin     IN DATE) RETURN NUMBER IS

        CURSOR cuDaysAble(nucountry_id IN ge_calendar.country_id%TYPE) IS
            SELECT COUNT(1) days
            FROM   ge_calendar
            WHERE  trunc(ge_calendar.date_) >= trunc(idtIni)
            AND    trunc(ge_calendar.date_) <= trunc(idtFin)
            AND    ge_calendar.day_type_id = ld_boconstans.cnuonenumber
            AND    ge_calendar.country_id =
                   nvl(nucountry_id, ld_boconstans.cnucolombiancountryid);

        rgcudaysable cudaysable%ROWTYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnuGetDaysAble', pkg_traza.cnuNivelTrzDef);

        OPEN cuDaysAble(inucountry);
        FETCH cuDaysAble
            INTO rgcudaysable;
        IF rgcudaysable.days = ld_boconstans.cnuCero_Value AND
           inucountry <> ld_boconstans.cnucolombiancountryid THEN
            CLOSE cuDaysAble;
            OPEN cuDaysAble(ld_boconstans.cnucolombiancountryid);
            FETCH cuDaysAble
                INTO rgcudaysable;
            CLOSE cuDaysAble;
        END IF;
        IF cudaysable%ISOPEN THEN
            CLOSE cuDaysAble;
        END IF;

        RETURN(rgcudaysable.days);

        UT_Trace.Trace('Fin Ld_BoSubsidy.fnuGetDaysAble', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnuGetDaysAble;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fblTransferSubsidy
      Descripcion    : trasladod de subsidio por medio de archivo plano.

      Autor          : Jorge Valiente
      Fecha          : 12/10/2012

      Parametros                  Descripcion
      ============           ===================
      isbLineFile            Linea de archivo plano con el subsidio a trasladar
      osbErrorMessage        Mensaje de inconsistencias

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      11-12-2013       sgomez.SAO227083      Se modifica insercion en el historico
                                             para adicionar nuevo campo "Valor
                                             Transferido".
                                             Se modifica validacion de valor a
                                             asignar, para habilitar el caso en
                                             el que, el subsidio a trasladar es
                                             IGUAL al subsidio restante.
                                             Se adiciona actualizacion en motivo por
                                             promocion (mo_mot_promotion) para
                                             asignar la nueva promocion (subsidio)
                                             luego de traslado.
                                             Se modifica actualizacion de subsidio
                                             otorgado (ld_asig_subsidy) para
                                             asignar ID de promocion del nuevo
                                             subsidio (destino).
      04/09/2013       hvera.SAO214139       Se modifica para validar que el grupo de conceptos del
                                              subsidio origen este contenido dentro del grupo de
                                              conceptos del subsidio destino.
    ******************************************************************/
    FUNCTION fblTransferSubsidy(isbLineFile     IN VARCHAR2,
                                osbErrorMessage OUT VARCHAR2) RETURN BOOLEAN IS

        CURSOR cuAsigSubsidy(nuSusccodi   suscripc.susccodi%TYPE,
                             nuSubsidy_Id ld_asig_subsidy.subsidy_id%TYPE) IS
            SELECT *
            FROM   ld_asig_subsidy asisub
            WHERE  asisub.susccodi = nuSusccodi
            AND    asisub.subsidy_id = nuSubsidy_Id;

        arString ld_boconstans.tbarray;

        nuSusccdoi          LD_ASIG_SUBSIDY.SUSCCODI%TYPE;
        nuSubsidyBegin_Id   LD_SUBSIDY.SUBSIDY_ID%TYPE;
        nuSubsidyDestiny_Id LD_SUBSIDY.SUBSIDY_ID%TYPE;
        nuAmount            NUMBER;
        nuControlStep       NUMBER;
        nuubication         ld_ubication.ubication_id%TYPE;

        rcAsigSubsidy Dald_Asig_Subsidy.styLD_Asig_Subsidy;

        rcSubsidyBegin     dald_subsidy.styLD_subsidy;
        rcSubsidyDestiny   dald_subsidy.styLD_subsidy;
        rcUbicationBegin   dald_ubication.styLD_ubication;
        rcUbicationDestiny dald_ubication.styLD_ubication;

        nuubitotal_deliver   ld_ubication.total_deliver%TYPE;
        nuubitotal_available ld_ubication.total_available%TYPE;
        nusubtotal_deliver   ld_subsidy.total_deliver%TYPE;
        nusubtotal_available ld_subsidy.total_available%TYPE;

        rcmovesub           dald_move_sub.styLD_move_sub;
        nuErrorCode         NUMBER;
        nucont              NUMBER;
        nusubbeginstate     ld_asig_subsidy.state_subsidy%TYPE;
        sbtransfer          ld_subsidy_states.activate%TYPE;
        nupackage_id        mo_packages.package_id%TYPE;
        nulocation          ge_geogra_location.geograp_location_id%TYPE;
        nucategori          categori.catecodi%TYPE;
        nusubcategory       subcateg.sucacodi%TYPE;
        nuconceptsubbegin   ld_subsidy.Conccodi%TYPE;
        nuconceptsubdestiny ld_subsidy.Conccodi%TYPE;
        nuasigsub           ld_subsidy.subsidy_id%TYPE;

        /* ID de promocion por motivo */
        nuIDMotPromo mo_mot_promotion.mot_promotion_id%TYPE;

    BEGIN

        nuControlStep := ld_boconstans.cnuCero_Value;

        osbErrorMessage := NULL;

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fblTransferSubsidy', pkg_traza.cnuNivelTrzDef);

        nuAmount := ld_bosubsidy.FsbGetAmount(isbLineFile,
                                              ld_boconstans.csbPipe);

        IF nvl(nuAmount, 0) = 0 THEN
            osbErrorMessage := 'Los datos no estan separados por PIPES';
            RETURN(FALSE);
        END IF;

        IF nvl(nuAmount, 0) <> 3 THEN
            osbErrorMessage := 'Los datos deben estar separados por 3 PIPES';
            RETURN(FALSE);
        END IF;

        IF nuAmount <> -1 OR nuAmount <> 0 THEN

            arString := ld_bosubsidy.FsbGetArray(nuAmount,
                                                 isbLineFile,
                                                 ld_boconstans.csbPipe);

            nuSusccdoi          := to_number(arString(1));
            nuSubsidyBegin_Id   := to_number(arString(2));
            nuSubsidyDestiny_Id := to_number(arString(3));

            /*Validar suscriptor*/
            IF nuSusccdoi IS NULL THEN
                osbErrorMessage := 'El codigo del suscriptor no debe ser nulo';
                RETURN(FALSE);
            ELSE
                IF NOT pktblsuscripc.fblexist(nuSusccdoi) THEN
                    osbErrorMessage := 'El codigo del suscriptor no valido';
                    RETURN(FALSE);
                END IF;
            END IF;

            /*Validar subsidio origen*/
            IF nuSubsidyBegin_Id IS NULL THEN
                osbErrorMessage := 'El codigo del subsidio origen no debe ser nulo';
                RETURN(FALSE);
            ELSE
                IF NOT dald_subsidy.fblexist(nuSubsidyBegin_Id) THEN
                    osbErrorMessage := 'El codigo del subsidio origen no es valido';
                    RETURN(FALSE);
                END IF;

                /*Validar subsidio destino*/
                IF nuSubsidyDestiny_Id IS NULL THEN
                    osbErrorMessage := 'El codigo del subsidio destino no debe ser nulo';
                    RETURN(FALSE);
                ELSE
                    IF NOT dald_subsidy.fblexist(nuSubsidyDestiny_Id) THEN
                        osbErrorMessage := 'El codigo del subsidio destino no es valido';
                        RETURN(FALSE);
                    END IF;
                END IF;

                IF nuSubsidyBegin_Id = nuSubsidyDestiny_Id THEN
                    osbErrorMessage := 'El codigo del subsidio origen es igual al codigo del subsidio destino';
                    RETURN(FALSE);
                END IF;

                /*Validar que el subsidio de origen digitado en la busqueda sea el
                mismo que posee el usuario*/

                nuasigsub := ld_bcsubsidy.Fnugetasigsubbysusc(nuSubsidyBegin_Id,
                                                              nuSusccdoi);

                IF nuasigsub = 0 THEN
                    osbErrorMessage := 'El codigo del subsidio origen no esta asignado al suscriptor ' ||
                                       nuSusccdoi;
                    RETURN(FALSE);
                END IF;

                /*Validar que el flag de traslado del origen este activo*/
                FOR rgcuAsigSubsidy IN cuAsigSubsidy(nuSusccdoi,
                                                     nuSubsidyBegin_Id) LOOP
                    nusubbeginstate := dald_asig_subsidy.fnuGetState_Subsidy(rgcuAsigSubsidy.Asig_Subsidy_Id);
                    sbtransfer      := dald_subsidy_states.fsbGetActivate(nusubbeginstate);
                    nupackage_id    := rgcuAsigSubsidy.Package_Id;
                    nucont          := nvl(nucont, 0) + 1;

                    IF nvl(sbtransfer, 'X') <> 'Y' THEN
                        osbErrorMessage := 'El flag del estado del subsidio origen no se encuentra activo';
                        RETURN(FALSE);
                    END IF;
                END LOOP;
            END IF;

            /*Validar que el suscriptor poseea un subsidio con el codigo del subsidio origen*/
            IF nvl(nucont, 0) = 0 THEN
                osbErrorMessage := 'El suscriptor ' || nuSusccdoi ||
                                   ' no posee un subsidio ' ||
                                   nuSubsidyBegin_Id;
                RETURN(FALSE);
            END IF;

            /*Validar subsidio destino*/
            IF nuSubsidyDestiny_Id IS NULL THEN
                osbErrorMessage := 'El codigo del subsidio destino no debe ser nulo';
                RETURN(FALSE);
            ELSE
                IF NOT dald_subsidy.fblexist(nuSubsidyDestiny_Id) THEN
                    osbErrorMessage := 'El codigo del subsidio destino no es valido';
                    RETURN(FALSE);
                END IF;

                IF SYSDATE > dald_subsidy.fdtGetFinal_Date(nuSubsidyDestiny_Id) THEN
                    osbErrorMessage := 'El subsidio destino no se encuentra vigente';
                    RETURN(FALSE);
                END IF;
            END IF;

            /*Validar que el concepto de aplicacion del subsidio origen y destino sean los mismos*/
            nuconceptsubbegin   := dald_subsidy.fnuGetConccodi(nuSubsidyBegin_Id);
            nuconceptsubdestiny := dald_subsidy.fnuGetConccodi(nuSubsidyDestiny_Id);

            IF nvl(nuconceptsubbegin, -1) <> nvl(nuconceptsubdestiny, -2) THEN
                osbErrorMessage := 'El concepto de aplicacion del subsidio origen es diferente
                            al concepto de aplicacion del subsidio destino';
                RETURN(FALSE);
            END IF;

            /*Obtener la ubicacion geografica, categoria y subcategoria de la solicitud de venta*/
            Procgetdatesforpackages(nupackage_id,
                                    nulocation,
                                    nucategori,
                                    nusubcategory);

            /*Ubicacion donde se realizara el traslado del subsidio*/
            nuubication := Fnugetsububication(nuSubsidyDestiny_ID,
                                              nulocation,
                                              nucategori,
                                              nusubcategory);

            IF nuubication IS NULL THEN
                osbErrorMessage := 'No existe Poblacion valida para el traslado del subsidio';
                RETURN(FALSE);
            END IF;

            FOR tempcuAsigSubsidy IN cuAsigSubsidy(nuSusccdoi,
                                                   nuSubsidyBegin_Id) LOOP

                /*codigo de traslado de subsidio*/
                /*Registro de asignacion de subsidio*/
                Dald_Asig_Subsidy.getRecord(tempcuAsigSubsidy.Asig_Subsidy_Id,
                                            rcAsigSubsidy);
                validateConcepts(rcAsigSubsidy.Ubication_Id, nuubication);
                /*Registro de subsidio origen*/
                DALD_subsidy.LockByPkForUpdate(nuSubsidyBegin_ID, rcSubsidyBegin);
                /*Registro de ubicacion origen*/
                DALD_ubication.LockByPkForUpdate(rcAsigSubsidy.Ubication_Id,
                                         rcUbicationBegin);
                /*Registro de subsidio destino*/
                DALD_subsidy.LockByPkForUpdate(nuSubsidyDestiny_ID, rcSubsidyDestiny);
                /*Registro de ubicacion destino*/
                DALD_ubication.LockByPkForUpdate(nuubication, rcUbicationDestiny);

                /*Subsidio y Ubicacion destino*/
                IF rcSubsidyDestiny.authorize_value IS NOT NULL AND
                   rcUbicationDestiny.authorize_value IS NOT NULL THEN

                    IF rcAsigSubsidy.subsidy_value <=
                       (rcUbicationDestiny.authorize_value -
                       nvl(rcUbicationDestiny.total_deliver,
                            ld_boconstans.cnuCero_Value)) THEN

                        /*Actualizar ubicacion Destino*/
                        --total entregado
                        nuubitotal_deliver := nvl(rcUbicationDestiny.total_deliver,
                                                  ld_boconstans.cnuCero_Value) +
                                              rcAsigSubsidy.subsidy_value;

                        --total disponible
                        IF NVL(rcUbicationDestiny.total_available, 0) = 0 THEN
                            nuubitotal_available := nvl(rcUbicationDestiny.authorize_value,
                                                        ld_boconstans.cnuCero_Value) -
                                                    rcAsigSubsidy.subsidy_value;
                        ELSE
                            nuubitotal_available := nvl(rcUbicationDestiny.total_available,
                                                        ld_boconstans.cnuCero_Value) -
                                                    rcAsigSubsidy.subsidy_value;
                        END IF;

                        Dald_Ubication.updTotal_Deliver(nuubication,
                                                        nuubitotal_deliver);
                        Dald_Ubication.updtotal_available(nuubication,
                                                          nuubitotal_available);

                        /*Actualizar encabezado del subsidio Destino*/
                        --total entregado
                        nusubtotal_deliver := nvl(rcSubsidyDestiny.total_deliver,
                                                  ld_boconstans.cnuCero_Value) +
                                              rcAsigSubsidy.subsidy_value;

                        --total disponible
                        IF NVL(rcSubsidyDestiny.total_available, 0) = 0 THEN
                            nusubtotal_available := nvl(rcSubsidyDestiny.authorize_value,
                                                        ld_boconstans.cnuCero_Value) -
                                                    rcAsigSubsidy.subsidy_value;
                        ELSE
                            nusubtotal_available := nvl(rcSubsidyDestiny.total_available,
                                                        ld_boconstans.cnuCero_Value) -
                                                    rcAsigSubsidy.subsidy_value;
                        END IF;

                        Dald_Subsidy.updTotal_Deliver(nuSubsidyDestiny_ID,
                                                      nusubtotal_deliver);
                        Dald_Subsidy.updTotal_Available(nuSubsidyDestiny_ID,
                                                        nusubtotal_available);

                        /*Subsidio y Ubicacion origen*/
                        /*Actualizar ubicacion Origen*/
                        --total entregado
                        IF nvl(rcUbicationBegin.total_deliver,
                               ld_boconstans.cnuCero_Value) = 0 THEN
                            nuubitotal_deliver := 0;
                        ELSE
                            nuubitotal_deliver := nvl(rcUbicationBegin.total_deliver,
                                                      ld_boconstans.cnuCero_Value) -
                                                  rcAsigSubsidy.subsidy_value;
                        END IF;

                        --total disponible
                        IF nvl(rcUbicationBegin.total_available,
                               ld_boconstans.cnuCero_Value) = 0 THEN
                            nuubitotal_available := rcUbicationBegin.total_available;
                        ELSE
                            nuubitotal_available := nvl(rcUbicationBegin.total_available,
                                                        ld_boconstans.cnuCero_Value) +
                                                    rcAsigSubsidy.subsidy_value;

                        END IF;

                        Dald_Ubication.updTotal_Deliver(rcAsigSubsidy.Ubication_id,
                                                        nuubitotal_deliver);
                        Dald_Ubication.updtotal_available(rcAsigSubsidy.Ubication_id,
                                                          nuubitotal_available);

                        /*Actualizar encabezado del subsidio Origen*/
                        --total entregado
                        IF nvl(rcSubsidyBegin.total_deliver,
                               ld_boconstans.cnuCero_Value) = 0 THEN
                            nusubtotal_deliver := 0;
                        ELSE
                            nusubtotal_deliver := nvl(rcSubsidyBegin.total_deliver,
                                                      ld_boconstans.cnuCero_Value) -
                                                  rcAsigSubsidy.subsidy_value;
                        END IF;

                        --total disponible
                        IF nvl(rcSubsidyBegin.total_available,
                               ld_boconstans.cnuCero_Value) = 0 THEN
                            nusubtotal_available := rcSubsidyBegin.total_available;
                        ELSE
                            nusubtotal_available := nvl(rcSubsidyBegin.total_available,
                                                        ld_boconstans.cnuCero_Value) +
                                                    rcAsigSubsidy.subsidy_value;
                        END IF;

                        Dald_Subsidy.updTotal_Deliver(nuSubsidyBegin_ID,
                                                      nusubtotal_deliver);
                        Dald_Subsidy.updTotal_Available(nuSubsidyBegin_ID,
                                                        nusubtotal_available);
                        /*fin Subsidio y Ubicacion origen*/

                        /*Cambio de subsidio de asignacion*/
                        dald_asig_subsidy.updSubsidy_Id(tempcuAsigSubsidy.Asig_Subsidy_Id,
                                                        nuSubsidyDestiny_ID);
                        /*Cambio de ubicacion de asignacion*/
                        dald_asig_subsidy.updUbication_Id(tempcuAsigSubsidy.Asig_Subsidy_Id,
                                                          nuubication);
                        /*fin Cambio de subsidio de asignacion*/

                        /* Se actualiza ID de promocion */
                        DALD_asig_subsidy.updPromotion_Id(tempcuAsigSubsidy.Asig_Subsidy_Id,
                                                          rcSubsidyDestiny.promotion_id);

                    ELSE
                        osbErrorMessage := 'El valor a trasladar del subsidio es mayor a valor disponible en la poblacion del subsidio destino';
                        RETURN(FALSE);
                    END IF;
                ELSE
                    IF rcSubsidyDestiny.authorize_value IS NULL THEN
                        osbErrorMessage := 'El valor autorizado del subsidio destino no esta definido';
                        RETURN(FALSE);
                    END IF;
                    IF rcUbicationDestiny.authorize_value IS NULL THEN
                        osbErrorMessage := 'El valor autorizado de la ubicacion destino no esta definido';
                        RETURN(FALSE);
                    END IF;
                END IF;
                /*fin Subsidio y Ubicacion destino*/

                rcmovesub.move_sub_id       := ld_bosequence.fnuSeqMoveSub;
                rcmovesub.susccodi          := nuSusccdoi;
                rcmovesub.source_sub        := nuSubsidyBegin_ID;
                rcmovesub.target_sub        := nuSubsidyDestiny_ID;
                rcmovesub.move_date         := SYSDATE;
                rcmovesub.user_id           := GE_BOPersonal.fnuGetPersonId;
                rcmovesub.terminal          := userenv('TERMINAL');
                rcmovesub.transferred_value := rcAsigSubsidy.subsidy_value;

                dald_move_sub.insRecord(rcmovesub);
                nuControlStep := 1;

                /* Se actualiza motivo por promocion */
                nuIDMotPromo := Ld_BcSubsidy.fnuMotPromotionByPack(tempcuAsigSubsidy.package_id,
                                                                   tempcuAsigSubsidy.promotion_id);
                IF (nuIDMotPromo IS NOT NULL) THEN
                    DAMO_Mot_Promotion.UpdPromotion_Id(nuIDMotPromo,
                                                       rcSubsidyDestiny.promotion_id);
                END IF;

            END LOOP;

            IF nuControlStep = 0 THEN
                osbErrorMessage := 'El contrato con el subsidio origen no tiene datos';
                RETURN(FALSE);
            END IF;

        ELSE
            osbErrorMessage := 'La linea del archivo es invalida';
            RETURN(FALSE);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fblTransferSubsidy', pkg_traza.cnuNivelTrzDef);
        osbErrorMessage := 'El constrato [' || nuSusccdoi ||
                           '] del subsidio origen [' || nuSubsidyBegin_Id ||
                           '] fue transferido al subsidio destino [' ||
                           nuSubsidyDestiny_Id || ']';
        RETURN(TRUE);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            errors.GetError(nuErrorCode, osbErrorMessage);
            RETURN(FALSE);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            errors.GetError(nuErrorCode, osbErrorMessage);
            RETURN(FALSE);
            RAISE pkg_error.CONTROLLED_ERROR;
    END fblTransferSubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : DeliveryDocumentation
       Descripcion    : Realiza la validacion de la entrega de documentacion
                        a las ventas con o sin subsidios
       Autor          : Jorge Luis Valiente Moreno
       Fecha          : 05/12/2012

       Parametros                Descripcion
       ============              ===================
       inuasig_subsidy_id        Codigo de subsdio asignado
       inuCurrent                valor numerico
       inuTotal                  valor numerico
       onuErrorCode              valor numerico
       osbErrorMessage           valor numerico

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       27-08-2013       hvera.SAO215029       Se elimina uso de la constante
                                              LD_BOConstans.CnuStateOrder que representa
                                              el parametro NUM_ORDER_STATE
       06-Sep-2014      Jorge Valiente        NC1112: Se coloco comentario al proceso de generacion de
                                                      multa a las ordenes procesadas por la forma LDCDE
                                                      ya que en conversacion con el funcionario Hernan Henao
                                                      manifiesta que las gaseras no deben aplicar multa
                                                      en esta forma
    /*************************************************************************/
    PROCEDURE DeliveryDocumentation(inuasig_subsidy_id IN VARCHAR2,
                                    inuCurrent         IN NUMBER,
                                    inuTotal           IN NUMBER,
                                    onuErrorCode       OUT NUMBER,
                                    osbErrorMessage    OUT VARCHAR2) IS

        ---parametros para valores quemados
        CURSOR cuAsigSubsidy IS
            SELECT *
            FROM   ld_asig_subsidy
            WHERE  asig_subsidy_id =
                   to_number(FsbGetString(1, inuasig_subsidy_id, '-'));

        ---parametros para valores quemados
        CURSOR cuSalesWithoutsubsidy IS
            SELECT *
            FROM   Ld_sales_withoutsubsidy
            WHERE  Sales_Withoutsubsidy_Id =
                   to_number(FsbGetString(1, inuasig_subsidy_id, '-'));

        CURSOR cuOrder(nuorder_id or_order.order_id%TYPE) IS
            SELECT * FROM or_order WHERE order_id = nuorder_id;

        CURSOR cuOrderActivity(nuorder_id   or_order.order_id%TYPE,
                               nuactivityid or_order_activity.activity_id%TYPE) IS
            SELECT DISTINCT order_activity_id,
                            comment_
            FROM   or_order_activity
            WHERE  order_id = nuorder_id
            AND    activity_id = nuactivityid;

        CURSOR lengthorder_activity IS
            SELECT a.DATA_LENGTH
            FROM   all_tab_columns a
            WHERE  a.TABLE_NAME = 'OR_ORDER_ACTIVITY'
            AND    a.COLUMN_NAME = 'COMMENT_';

        nuCAUSAL_ID ge_boInstanceControl.stysbValue;
        sbComment   ge_boInstanceControl.stysbValue;

        AsigSubsidy         cuAsigSubsidy%ROWTYPE;
        SalesWithoutsubsidy cuSalesWithoutsubsidy%ROWTYPE;
        OrderAsig           cuOrder%ROWTYPE;
        OrderActivity       cuOrderActivity%ROWTYPE;
        nuParameter         ld_parameter.numeric_value%TYPE;
        --sbParameter         ld_parameter.value_chain%type;

        nuError NUMBER;
        sbError VARCHAR2(4000);

        rcRelatedOrder daor_related_order.styOR_related_order;

        nuItems              ge_items.items_id%TYPE;
        nuMotive             mo_motive.motive_id%TYPE;
        nuAddress            mo_packages.address_id%TYPE;
        nuSubscriberId       mo_packages.Subscriber_Id%TYPE;
        nuSubscriptionPendId mo_packages.Subscription_Pend_Id%TYPE;
        rcMotive             damo_motive.styMO_motive;
        nuOrderId            or_order.order_id%TYPE;
        nuOrderActivityId    or_order_activity.order_activity_id%TYPE;

        nuOperatingUnitId or_order.operating_unit_id%TYPE;
        nuContractorID    or_operating_unit.contractor_id%TYPE;
        nuOrderId_Out     or_order.order_id%TYPE;
        sbtypesale        ld_asig_subsidy.type_subsidy%TYPE;
        nulengthcomment   NUMBER;
        --
        sbSuccessCausal ld_parameter.value_chain%TYPE;
        sbFailedCausal  ld_parameter.value_chain%TYPE;
        --
        nuasigsub   ld_asig_subsidy.asig_subsidy_id%TYPE;
        rcubication dald_ubication.styld_ubication;

    BEGIN

	    ut_trace.trace ('

		inuasig_subsidy_id '||inuasig_subsidy_id ||'
        inuCurrent      '|| inuCurrent           ||'
        inuTotal        '|| inuTotal


		);




        UT_Trace.Trace('Inicio Ld_BoSubsidy.DeliveryDocumentation', pkg_traza.cnuNivelTrzDef);
        nuCAUSAL_ID := ge_boInstanceControl.fsbGetFieldValue('LD_CAUSAL',
                                                             'CAUSAL_ID');
        sbComment   := ge_boInstanceControl.fsbGetFieldValue('LD_REP_INCO_SUB',
                                                             'INCONSISTENCY');
        /*Validar que se haya ingresado la causal*/
        IF nuCAUSAL_ID IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'La causal de legalizacion no puede ser nula');
        END IF;

        /*Validar que el parametro de causales de exito este configurado*/
        IF ld_boconstans.csbCAU_COM_DOC_SUB IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro CAU_COM_DOC_SUB no esta diligenciado');
        END IF;

        /*Validar que el parametro de causales de exito este configurado*/
        IF ld_boconstans.csbCAU_NON_COM_DOC_SUB IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro CAU_NON_COM_DOC_SUB no esta diligenciado');
        END IF;

        /*Obtener la longitud del campo comentario de la tabla or_order_activity*/
        BEGIN
            FOR rglengthorder_activity IN lengthorder_activity LOOP
                nulengthcomment := rglengthorder_activity.data_length;
            END LOOP;
        EXCEPTION
            WHEN OTHERS THEN
                nulengthcomment := 2000;
        END;

        IF (length(sbComment) + length('Legalizada por la aplicacion LDCDE []')) >
           nulengthcomment THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'La longitud del comentario de las ordenes a generar es muy extenso');
        END IF;

        IF ld_boconstans.csbapackagedocok IS NULL OR
           nvl(ld_boconstans.csbapackagedocok, 'X') <> 'S' THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'La constante csbapackagedocok del paquete Ld_Boconstans no se encuentra debidamente diligenciada');
        END IF;

        IF Ld_boconstans.cnupenalize_activity IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro PENALIZE_ACTIVITY no se ha diligenciado');
        END IF;
        IF ld_boconstans.cnuTransitionSub IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro TRANSITION_SUBSIDY no se ha diligenciado');
        END IF;
        IF Ld_boconstans.cnudocactivity IS NULL THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El parametro NORMAL_SALE_DOC_ACTIVITY no se ha diligenciado');
        END IF;

        /*Obtener el valor de los parametros de causales de exito y fallo*/
        sbSuccessCausal := ld_boconstans.csbCAU_COM_DOC_SUB;
        sbFailedCausal  := ld_boconstans.csbCAU_NON_COM_DOC_SUB;

        /*Validar que la causal que se ingreso es de exito o de fallo*/
        IF REGEXP_INSTR(sbSuccessCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') =
           ld_boconstans.cnuCero_Value AND
           REGEXP_INSTR(sbFailedCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') =
           ld_boconstans.cnuCero_Value THEN

            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'La causal de legalizacion ' ||
                                             nuCAUSAL_ID ||
                                             ' no se encuentra configurada ni como causal de exito ni de fallo');

        END IF;

        IF nuCAUSAL_ID IS NOT NULL THEN
            ---Causal de Cumplimiento de Documentacion
            IF REGEXP_INSTR(sbSuccessCausal,
                            '(\W|^)' || nuCAUSAL_ID || '(\W|$)') >
               ld_boconstans.cnuCero_Value THEN
                UT_Trace.Trace('CAUSAL DE EXITO: ' || nuCAUSAL_ID, pkg_traza.cnuNivelTrzDef);
                ---Cursor para subsidio asignados
                OPEN cuAsigSubsidy;
                FETCH cuAsigSubsidy
                    INTO AsigSubsidy;
                ---parametros para valores quemados
                IF cuAsigSubsidy%FOUND AND
                   FsbGetString(2, inuasig_subsidy_id, '-') = 'S' THEN
				   UT_Trace.Trace('IF cuAsigSubsidy%FOUND AND', pkg_traza.cnuNivelTrzDef);
                    nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,
                                                                      NULL);
                    IF nuParameter IS NOT NULL THEN
						UT_Trace.Trace('IF nuParameter IS NOT NULL THEN', pkg_traza.cnuNivelTrzDef);
                        OPEN cuOrder(AsigSubsidy.Order_Id);
						UT_Trace.Trace('OPEN cuOrder('||AsigSubsidy.Order_Id||');', pkg_traza.cnuNivelTrzDef);
                        FETCH cuOrder
                            INTO OrderAsig;
                        IF cuOrder%FOUND THEN
							UT_Trace.Trace(' IF cuOrder%FOUND THEN', pkg_traza.cnuNivelTrzDef);
                            IF OrderAsig.Order_Status_Id = nuParameter THEN

							    UT_Trace.Trace(' IF '||OrderAsig.Order_Status_Id||' = '||nuParameter ||' THEN ', pkg_traza.cnuNivelTrzDef);

                                IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'La orden [' ||
                                                       OrderAsig.Order_Id ||
                                                       '] fue legalizada con Causal Diferente';
                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                     osbErrorMessage);
                                ELSE
                                    /*Obtener el tipo de asignacion de subsidio*/

									UT_Trace.Trace(' sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(FsbGetString(1,'
                                                                                       , pkg_traza.cnuNivelTrzDef);

                                    sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(FsbGetString(1,
                                                                                                    inuasig_subsidy_id,
                                                                                                    '-'),
                                                                                       NULL);

                                    IF sbtypesale = ld_boconstans.csbretroactivesale THEN

									   UT_Trace.Trace('ApplyRetrosubsidy(FsbGetString(1,
                                                                       '||inuasig_subsidy_id||',
                                                                       -),
                                                          onuErrorCode,
                                                          osbErrorMessage);', pkg_traza.cnuNivelTrzDef);

                                        ApplyRetrosubsidy(FsbGetString(1,
                                                                       inuasig_subsidy_id,
                                                                       '-'),
                                                          onuErrorCode,
                                                          osbErrorMessage);
                                    END IF;

                                    IF onuErrorCode IS NOT NULL AND
                                       osbErrorMessage IS NOT NULL THEN
                                        ROLLBACK;
                                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                         osbErrorMessage);
                                    END IF;

									 UT_Trace.Trace('dald_asig_subsidy.updDelivery_Doc('||AsigSubsidy.Asig_Subsidy_Id||',
                                                                      '||ld_boconstans.csbapackagedocok||');', pkg_traza.cnuNivelTrzDef);

                                    dald_asig_subsidy.updDelivery_Doc(AsigSubsidy.Asig_Subsidy_Id,
                                                                      ld_boconstans.csbapackagedocok);
                                    COMMIT;
                                END IF;
                            ELSE
							    UT_Trace.Trace('antes de IF OrderAsig.Order_Status_Id <> nuParameter THEN', 10) 	;
								UT_Trace.Trace('OrderAsig.Order_Status_Id '||OrderAsig.Order_Status_Id ||' - '||' nuParameter ' ||nuParameter, 10) 	;

                                IF OrderAsig.Order_Status_Id <> nuParameter THEN
								    ut_trace.trace ( ' LegAllactivities('||OrderAsig.Order_Id||',
                                                     '||nuCAUSAL_ID||',
                                                     '||ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id))||',
                                                     '||SYSDATE||',
                                                     '||SYSDATE||',
                                                     Legalizacion por la aplicacion LDCDE,
                                                     NULL, --new parameter add for open
                                                     nuError,
                                                     sbError);', pkg_traza.cnuNivelTrzDef);

                                    LegAllactivities(OrderAsig.Order_Id,
                                                     nuCAUSAL_ID,
                                                     ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                                     SYSDATE,
                                                     SYSDATE,
                                                     'Legalizacion por la aplicacion LDCDE',
                                                     NULL, --new parameter add for open
                                                     nuError,
                                                     sbError);

                                    IF nuError = ld_boconstans.cnuCero_Value THEN
                                        /*Obtener el tipo de asignacion de subsidio*/
                                        sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(FsbGetString(1,
                                                                                                        inuasig_subsidy_id,
                                                                                                        '-'),
                                                                                           NULL);

                                        /*Generar movimientos: bajar deuda diferida, generar nota y
                                        cargo credito para un subsidio retroactivo*/
                                        IF sbtypesale =
                                           ld_boconstans.csbretroactivesale THEN
                                            ApplyRetrosubsidy(FsbGetString(1,
                                                                           inuasig_subsidy_id,
                                                                           '-'),
                                                              onuErrorCode,
                                                              osbErrorMessage);
                                        END IF;

                                        IF onuErrorCode IS NOT NULL AND
                                           osbErrorMessage IS NOT NULL THEN
                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                             osbErrorMessage);
                                            ROLLBACK;
                                        END IF;

                                        dald_asig_subsidy.updDelivery_Doc(AsigSubsidy.Asig_Subsidy_Id,
                                                                          ld_boconstans.csbapackagedocok);
                                        COMMIT;
                                    ELSE
                                        onuErrorCode    := nuError;
                                        osbErrorMessage := sbError;
                                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                         osbErrorMessage);
                                    END IF;
                                END IF;
                            END IF;
                        ELSE
                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                            osbErrorMessage := 'Inconvenientes con la orden [' ||
                                               AsigSubsidy.Order_Id || ']';
                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                             osbErrorMessage);
                        END IF;
                        CLOSE cuOrder;
                    ELSE
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                         osbErrorMessage);
                    END IF;
                ELSE
                    -----/*
                    OPEN cuSalesWithoutsubsidy;
                    FETCH cuSalesWithoutsubsidy
                        INTO SalesWithoutsubsidy;
                    ---parametros para valores quemados
                    IF cuSalesWithoutsubsidy%FOUND AND
                       FsbGetString(2, inuasig_subsidy_id, '-') = 'V' THEN
                        nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,
                                                                          NULL);
                        IF nuParameter IS NOT NULL THEN
                            OPEN cuOrder(SalesWithoutsubsidy.Order_Id);
                            FETCH cuOrder
                                INTO OrderAsig;
                            IF cuOrder%FOUND THEN
                                IF OrderAsig.Order_Status_Id = nuParameter THEN
                                    IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                        osbErrorMessage := 'La orden [' ||
                                                           OrderAsig.Order_Id ||
                                                           '] fue legalizada con Causal Diferente';
                                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                         osbErrorMessage);
                                    ELSE
                                        dald_sales_withoutsubsidy.updDelivery_Doc(SalesWithoutsubsidy.Sales_Withoutsubsidy_Id,
                                                                                  ld_boconstans.csbapackagedocok);
                                        COMMIT;
                                    END IF;
                                ELSE
                                    IF OrderAsig.Order_Status_Id <> nuParameter THEN
                                        LegAllactivities(OrderAsig.Order_Id,
                                                         nuCAUSAL_ID,
                                                         ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                                         SYSDATE,
                                                         SYSDATE,
                                                         'Legalizacion por la aplicacion LDCDE',
                                                         NULL, --new parameter add for open
                                                         nuError,
                                                         sbError);
                                        IF nuError =
                                           ld_boconstans.cnuCero_Value THEN
                                            dald_sales_withoutsubsidy.updDelivery_Doc(SalesWithoutsubsidy.Sales_Withoutsubsidy_Id,
                                                                                      ld_boconstans.csbapackagedocok);
                                            COMMIT;
                                        ELSE
                                            onuErrorCode    := nuError;
                                            osbErrorMessage := sbError;
                                            ROLLBACK;
                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                             osbErrorMessage);
                                        END IF;
                                    END IF;
                                END IF;
                            ELSE
                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                   AsigSubsidy.Order_Id || ']';
                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                 osbErrorMessage);
                                --close cuOrder;
                            END IF;
                            CLOSE cuOrder;
                        ELSE
                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                            osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                             osbErrorMessage);
                        END IF;
                    ELSE
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error al procesar la validacion de documentos para el subsidio asignado [' ||
                                           inuasig_subsidy_id || ']';
                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                         osbErrorMessage);
                        --close cuSalesWithoutsubsidy;
                    END IF;

					ut_trace.trace ('antes de CLOSE cuSalesWithoutsubsidy;');

                    CLOSE cuSalesWithoutsubsidy;

					ut_trace.trace ('despues de CLOSE cuSalesWithoutsubsidy;');
                    ------*/
                END IF;

				ut_trace.trace ('antes de CLOSE cuAsigSubsidy',0);

                CLOSE cuAsigSubsidy;

            ELSE

                ---Causal de incumplimiento de entrega de documentacion
                IF REGEXP_INSTR(sbFailedCausal,
                                '(\W|^)' || nuCAUSAL_ID || '(\W|$)') >
                   ld_boconstans.cnuCero_Value THEN
                    UT_Trace.Trace('CAUSAL DE FALLO: ' || nuCAUSAL_ID, pkg_traza.cnuNivelTrzDef);
                    ---Ventas Subsidiadas
                    OPEN cuAsigSubsidy;
                    FETCH cuAsigSubsidy
                        INTO AsigSubsidy;
                    ---parametros para valores quemados
                    IF cuAsigSubsidy%FOUND AND
                       FsbGetString(2, inuasig_subsidy_id, '-') = 'S' THEN
                        --asignacion retroactiva
                        IF AsigSubsidy.Type_Subsidy = 'R' THEN
                            nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,
                                                                              NULL);
                            IF nuParameter IS NOT NULL THEN
                                OPEN cuOrder(AsigSubsidy.Order_Id);
                                FETCH cuOrder
                                    INTO OrderAsig;
                                UT_Trace.Trace('La orden: ' ||
                                               AsigSubsidy.Order_Id ||
                                               '  Se encuentra en estado: ' ||
                                               OrderAsig.Order_Status_Id ||
                                               ' | nuParameter:' ||
                                               nuParameter,
                                               10);
                                IF cuOrder%FOUND THEN
                                    IF OrderAsig.Order_Status_Id = nuParameter THEN
                                        IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                            osbErrorMessage := 'La orden [' ||
                                                               OrderAsig.Order_Id ||
                                                               '] fue legalizada con Causal Diferente a Causal de Fallo';
                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                             osbErrorMessage);
                                        ELSE
                                            IF OrderAsig.Causal_Id =
                                               nuCAUSAL_ID THEN
                                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                osbErrorMessage := 'La orden [' ||
                                                                   OrderAsig.Order_Id ||
                                                                   '] ya fue legalizada con Causal Fallo';
                                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                 osbErrorMessage);
                                            END IF;
                                        END IF;
                                    ELSE
                                        IF OrderAsig.Order_Status_Id <>
                                           nuParameter THEN
                                            LegAllactivities(OrderAsig.Order_Id,
                                                             nuCAUSAL_ID,
                                                             ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                                             SYSDATE,
                                                             SYSDATE,
                                                             'Legalizacion por la aplicacion LDCDE',
                                                             NULL, --new parameter add for open
                                                             nuError,
                                                             sbError);
                                            IF nuError <>
                                               ld_boconstans.cnuCero_Value THEN
                                                onuErrorCode    := nuError;
                                                osbErrorMessage := sbError;
                                                ROLLBACK;
                                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                 osbErrorMessage);
                                            ELSE

                                                /*Obtener el codigo de asignacion del subsidio*/
                                                nuasigsub := FsbGetString(1,
                                                                          inuasig_subsidy_id,
                                                                          '-');

                                                /*Validad que el codigo exista*/
                                                IF NOT
                                                    dald_asig_subsidy.fblExist(nuasigsub) THEN
                                                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                    osbErrorMessage := 'El codigo de asignacion de subsidio ' ||
                                                                       nuasigsub ||
                                                                       ' no existe';
                                                    ROLLBACK;
                                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                     osbErrorMessage);
                                                END IF;
                                                UT_Trace.Trace('ACTUALIZA EL ESTADO A: ' ||
                                                               ld_boconstans.cnuSubreverstate,
                                                               10);
                                                /*Se actualiza el estado del subsidio a reversado*/
                                                dald_asig_subsidy.updState_Subsidy(nuasigsub,
                                                                                   ld_boconstans.cnuSubreverstate);

                                                /*Obtener datos de la poblacion*/
                                                DALD_ubication.LockByPkForUpdate(dald_asig_subsidy.fnuGetUbication_Id(nuasigsub,
                                                                                                              NULL),
                                                                         rcubication);

                                                /*Reversar el valor del subsidio de la poblacion y del subsidio*/
                                                Procbalancesub(dald_asig_subsidy.fnuGetSubsidy_Id(nuasigsub,
                                                                                                  NULL),
                                                               rcubication,
                                                               dald_asig_subsidy.fnuGetSubsidy_Value(nuasigsub,
                                                                                                     NULL),
                                                               ld_boconstans.cnutwonumber);

                                                COMMIT;

                                            END IF;
                                        END IF;
                                    END IF;
                                ELSE
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                       AsigSubsidy.Order_Id || ']';
                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                     osbErrorMessage);
                                    --close cuOrder;
                                END IF;
                                CLOSE cuOrder;
                            ELSE
                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                 osbErrorMessage);
                            END IF;
                        ELSE
                            --Legalizacion como incumplida de una venta subsidida realizada por el formulario de venta
                            IF AsigSubsidy.Type_Subsidy = 'V' THEN

                                nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,
                                                                                  NULL);
                                IF nuParameter IS NOT NULL THEN
                                    OPEN cuOrder(AsigSubsidy.Order_Id);
                                    FETCH cuOrder
                                        INTO OrderAsig;
                                    IF cuOrder%FOUND THEN
                                        IF OrderAsig.Order_Status_Id =
                                           nuParameter THEN
                                            IF OrderAsig.Causal_Id <>
                                               nuCAUSAL_ID THEN
                                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                osbErrorMessage := 'La orden [' ||
                                                                   OrderAsig.Order_Id ||
                                                                   '] fue legalizada con Causal Diferente a Causal de Fallo';
                                            ELSE
                                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                osbErrorMessage := 'La orden [' ||
                                                                   OrderAsig.Order_Id ||
                                                                   '] ya fue legalizada con Causal No Exitoso';
                                            END IF;
                                        ELSE

                                            IF OrderAsig.Order_Status_Id <>
                                               nuParameter THEN
                                                LegAllactivities(OrderAsig.Order_Id,
                                                                 nuCAUSAL_ID,
                                                                 ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                                                 SYSDATE,
                                                                 SYSDATE,
                                                                 'Legalizacion por la aplicacion LDCDE',
                                                                 NULL, --new parameter add for open
                                                                 nuError,
                                                                 sbError);
                                                IF nuError <>
                                                   ld_boconstans.cnuCero_Value THEN
                                                    onuErrorCode    := nuError;
                                                    osbErrorMessage := sbError;
                                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                     osbErrorMessage);
                                                    ROLLBACK;
                                                ELSE

                                                    OPEN cuOrderActivity(OrderAsig.Order_Id,
                                                                         Ld_boconstans.cnudocactivity);
                                                    FETCH cuOrderActivity
                                                        INTO OrderActivity;
                                                    IF cuOrderActivity%FOUND THEN
                                                        daor_order_activity.updComment_(orderactivity.order_activity_id,
                                                                                        orderactivity.comment_ ||
                                                                                        chr(10) ||
                                                                                        'Legalizada por la aplicacion LDCDE [' ||
                                                                                        sbComment || ']');

                                                        ---/* Generar una orden para venta subsidiada
                                                        nuItems              := Ld_boconstans.cnudocactivity;
                                                        nuMotive             := mo_bopackages.fnuGetInitialMotive(AsigSubsidy.Package_Id);
                                                        nuAddress            := mo_bopackages.fnuFindAddressId(AsigSubsidy.Package_Id);
                                                        nuSubscriberId       := mo_bopackages.fnuGetSubscriberId(AsigSubsidy.Package_Id);
                                                        nuSubscriptionPendId := mo_bopackages.fnuGetSuscriptionByPack(AsigSubsidy.Package_Id);
                                                        damo_motive.getRecord(nuMotive,
                                                                              rcMotive);

                                                        /*Creacion de orden de la nueva orden de control de documentacion*/
                                                        or_boorderactivities.CreateActivity(nuItems,
                                                                                            AsigSubsidy.Package_Id,
                                                                                            nuMotive,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            nuAddress,
                                                                                            NULL,
                                                                                            nuSubscriberId,
                                                                                            nuSubscriptionPendId,
                                                                                            rcMotive.product_id,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            'Orden de venta no subsidiada por medio de LDCDE',
                                                                                            NULL,
                                                                                            NULL,
                                                                                            nuOrderId,
                                                                                            nuorderactivityid,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL,
                                                                                            NULL);

                                                        ---Fin Generar una orden para venta subsidiada*/

                                                        --/*Asignacion de unidad operativa a la orden de venta subsidiada
                                                        IF nuOrderId =
                                                           ld_boconstans.cnuCero_Value THEN
                                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                            osbErrorMessage := 'No se genero orden';
                                                            ROLLBACK;
                                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                             osbErrorMessage);
                                                        ELSE
                                                            /*or_boprocessorder.ProcessOrder(nuorderid,
                                                            null,
                                                            damo_packages.fnuGetPos_Oper_Unit_Id(AsigSubsidy.Package_Id),
                                                            null,
                                                            FALSE,
                                                            NULL,
                                                            NULL);*/

                                                            --Fin Asignacion de unidad operativa a la orden de venta subsidiada*/
                                                            IF nuerror <>
                                                               ld_boconstans.cnuCero_Value THEN
                                                                onuErrorCode    := nuError;
                                                                osbErrorMessage := sbError;
                                                                ROLLBACK;
                                                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                                 osbErrorMessage);
                                                            ELSE
                                                                ---/* Relaciona orden legalizada con orden generada
                                                                rcRelatedOrder.order_id           := OrderAsig.Order_Id;
                                                                rcRelatedOrder.related_order_id   := nuOrderId;
                                                                rcRelatedOrder.rela_order_type_id := or_bofworderrelated.FNUGETRELATEDORDERTYPE;
                                                                daor_related_order.insRecord(rcRelatedOrder);
                                                                ---Fin Relaciona orden legalizada con orden generada*/

                                                                --INICIO NC 1112
                                                                --Este codigo estaba ubicado al final de la generacion de la multa
                                                                --se ubico despues de relacionar la orden generada con la orden lelgalizada
                                                                --para mantener el orden en el registro de asignacion de subsidio

                                                                --/*Obtener el codigo de asignacion del subsidio*
                                                                nuasigsub := FsbGetString(1,
                                                                                          inuasig_subsidy_id,
                                                                                          '-');

                                                                --/*Validad que el codigo exista*
                                                                IF NOT
                                                                    dald_asig_subsidy.fblExist(nuasigsub) THEN
                                                                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                    osbErrorMessage := 'El codigo de asignacion de subsidio ' ||
                                                                                       nuasigsub ||
                                                                                       ' no existe';
                                                                    ROLLBACK;
                                                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                                     osbErrorMessage);
                                                                END IF;

                                                                /*Actualizacion de la orden en el registro de asignacion de subsidios*/
                                                                dald_asig_subsidy.updOrder_Id(nuasigsub,
                                                                                              nuOrderId);

                                                                COMMIT;
                                                                --FIN NC1112*/

                                                                --INICIO NC1112
                                                                --codigo comentariado para que no genere la multa solicitado por la NC
                                                                /* Generacion de Multa
                                                                nuOperatingUnitId := daor_order.fnuGetOperating_Unit_Id(OrderAsig.Order_Id,
                                                                                                                        null
                                                                                                                       );

                                                                --/*Validar unidad operativa*
                                                                if nuOperatingUnitId is null then
                                                                  onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                  osbErrorMessage := 'No se puede crear la multa porque no se encontro unidad operativa para la orden '||nuOrderId;
                                                                  rollback;
                                                                  ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                                end if;

                                                                nuContractorID    := daor_operating_unit.fnuGetContractor_Id(nuOperatingUnitId,
                                                                                                                             null
                                                                                                                            );

                                                                --/*Validar contratista*
                                                                if nuContractorID is null then
                                                                  onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                  osbErrorMessage := 'No se puede crear la multa porque no se encontro contratista para la orden '||nuOrderId;
                                                                  rollback;
                                                                  ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                                end if;

                                                                ct_bonovelty.createnovelty(inucontractor => nuContractorID,
                                                                                           inuoperunit   => nuOperatingUnitId,
                                                                                           inuitem       => ld_boconstans.cnupenalize_activity,
                                                                                           inutecunit    => null,
                                                                                           inuorderid    => OrderAsig.Order_Id,
                                                                                           inuvalue      => null,
                                                                                           inuamount     => null,
                                                                                           inuuserid     => null,
                                                                                           inucommentype => null,
                                                                                           isbcomment    => null,
                                                                                           onuorder      => nuOrderId_Out,
                                                                                           inureltype    => ld_boconstans.cnuTransitionSub,
                                                                                           iboisautom    => False);

                                                                ---Fin Generacion de Multa*

                                                                if nvl(nuOrderId_Out, 0) <= 0 then
                                                                  onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                                  osbErrorMessage := 'Error al generar la orden de Multa';
                                                                  rollback;
                                                                  ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                                else

                                                                  --/*Obtener el codigo de asignacion del subsidio*
                                                                  nuasigsub :=  FsbGetString(1, inuasig_subsidy_id, '-');

                                                                  --/*Validad que el codigo exista*
                                                                  if not dald_asig_subsidy.fblExist(nuasigsub) then
                                                                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                    osbErrorMessage := 'El codigo de asignacion de subsidio '||nuasigsub||' no existe';
                                                                    rollback;
                                                                    ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                                  end if;


                                                                  --/*Actualizacion de la orden en el registro de asignacion de subsidios*
                                                                  dald_asig_subsidy.updOrder_Id(nuasigsub, nuOrderId);

                                                                  Commit;

                                                                end if;
                                                                --FIN NC1112*/

                                                            END IF;
                                                        END IF;
                                                    ELSE
                                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                        osbErrorMessage := 'La Actividad [' ||
                                                                           Ld_boconstans.cnudocactivity ||
                                                                           '] no esta asociada a la orden [' ||
                                                                           OrderAsig.Order_Id ||
                                                                           '] no esta asociada a la orden ';
                                                        ROLLBACK;
                                                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                         osbErrorMessage);
                                                    END IF;
                                                    CLOSE cuOrderActivity;
                                                END IF; ---
                                            END IF;
                                        END IF;
                                    ELSE
                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                        osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                           AsigSubsidy.Order_Id || ']';
                                        --close cuOrder;
                                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                         osbErrorMessage);
                                    END IF;
                                    CLOSE cuOrder;
                                ELSE
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                     osbErrorMessage);
                                END IF;
                            END IF;
                        END IF;
                    ELSE
                        -----/*
                        OPEN cuSalesWithoutsubsidy;
                        FETCH cuSalesWithoutsubsidy
                            INTO SalesWithoutsubsidy;

                        IF cuSalesWithoutsubsidy%FOUND AND
                           FsbGetString(2, inuasig_subsidy_id, '-') = 'V' THEN
                            nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,
                                                                              NULL);
                            IF nuParameter IS NOT NULL THEN
                                OPEN cuOrder(SalesWithoutsubsidy.Order_Id);
                                FETCH cuOrder
                                    INTO OrderAsig;
                                IF cuOrder%FOUND THEN
                                    IF OrderAsig.Order_Status_Id = nuParameter THEN
                                        IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                            osbErrorMessage := 'La orden [' ||
                                                               OrderAsig.Order_Id ||
                                                               '] fue legalizada con Causal Diferente';
                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                             osbErrorMessage);
                                        ELSE
                                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                            osbErrorMessage := 'La orden [' ||
                                                               OrderAsig.Order_Id ||
                                                               '] ya fue legalizada con Causal No Exitoso';
                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                             osbErrorMessage);
                                        END IF;
                                    ELSE
                                        IF OrderAsig.Order_Status_Id <>
                                           nuParameter THEN
                                            LegAllactivities(OrderAsig.Order_Id,
                                                             nuCAUSAL_ID,
                                                             ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                                             SYSDATE,
                                                             SYSDATE,
                                                             'Legalizacion por la aplicacion LDCDE',
                                                             NULL, --new parameter add for open
                                                             nuError,
                                                             sbError);
                                            IF nuError <>
                                               ld_boconstans.cnuCero_Value THEN
                                                onuErrorCode    := nuError;
                                                osbErrorMessage := sbError;
                                                ROLLBACK;
                                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                 osbErrorMessage);
                                            ELSE
                                                OPEN cuOrderActivity(OrderAsig.Order_Id,
                                                                     Ld_boconstans.cnudocactivity);
                                                FETCH cuOrderActivity
                                                    INTO OrderActivity;
                                                IF cuOrderActivity%FOUND THEN
                                                    daor_order_activity.updComment_(orderactivity.order_activity_id,
                                                                                    orderactivity.comment_ ||
                                                                                    chr(10) ||
                                                                                    'Legalizada por la aplicacion LDCDE [' ||
                                                                                    sbComment || ']');

                                                    UT_Trace.Trace('despues de cuOrderActivity',
                                                                   10);

                                                    ---/* Generar una orden para venta NO subsidiada
                                                    nuItems              := Ld_boconstans.cnudocactivity;
                                                    nuMotive             := mo_bopackages.fnuGetInitialMotive(SalesWithoutsubsidy.Package_Id);
                                                    nuAddress            := mo_bopackages.fnuFindAddressId(SalesWithoutsubsidy.Package_Id);
                                                    nuSubscriberId       := mo_bopackages.fnuGetSubscriberId(SalesWithoutsubsidy.Package_Id);
                                                    nuSubscriptionPendId := mo_bopackages.fnuGetSuscriptionByPack(SalesWithoutsubsidy.Package_Id);
                                                    damo_motive.getRecord(nuMotive,
                                                                          rcMotive);

                                                    /*Creacion de orden de venta NO subsidiada*/
                                                    or_boorderactivities.CreateActivity(nuItems,
                                                                                        SalesWithoutsubsidy.Package_Id,
                                                                                        nuMotive,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        nuAddress,
                                                                                        NULL,
                                                                                        nuSubscriberId,
                                                                                        nuSubscriptionPendId,
                                                                                        rcMotive.product_id,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        'Orden de venta no subsidiada por medio de LDCDE',
                                                                                        NULL,
                                                                                        NULL,
                                                                                        nuOrderId,
                                                                                        nuorderactivityid,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL,
                                                                                        NULL);

                                                    ---Fin Generar una orden para venta subsidiada*/

                                                    --/*Asignacion de unidad operativa a la orden de venta subsidiada
                                                    IF nuOrderId =
                                                       ld_boconstans.cnuCero_Value THEN
                                                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                        osbErrorMessage := 'No se genero orden';
                                                        ROLLBACK;
                                                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                         osbErrorMessage);
                                                    ELSE

                                                        --Fin Asignacion de unidad operativa a la orden de venta subsidiada*/
                                                        IF nuerror <>
                                                           ld_boconstans.cnuCero_Value THEN
                                                            onuErrorCode    := nuError;
                                                            osbErrorMessage := sbError;
                                                            ROLLBACK;
                                                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                             osbErrorMessage);
                                                        ELSE
                                                            ---/* Relaciona orden legalizada con orden generada
                                                            rcRelatedOrder.order_id           := SalesWithoutsubsidy.Order_Id;
                                                            rcRelatedOrder.related_order_id   := nuOrderId;
                                                            rcRelatedOrder.rela_order_type_id := or_bofworderrelated.FNUGETRELATEDORDERTYPE;
                                                            daor_related_order.insRecord(rcRelatedOrder);
                                                            ---Fin Relaciona orden legalizada con orden generada*/

                                                            --INICIO NC112
                                                            --Este codigo estaba ubicado al final de la generacion de la multa
                                                            --se ubico despues de relacionar la orden generada con la orden lelgalizada
                                                            --para mantener el orden en el registro de asignacion de subsidio

                                                            --/*Obtener el codigo de asignacion del subsidio*
                                                            nuasigsub := FsbGetString(1,
                                                                                      inuasig_subsidy_id,
                                                                                      '-');

                                                            --/*Validad que el codigo exista*
                                                            IF NOT
                                                                daLd_sales_withoutsubsidy.fblExist(nuasigsub) THEN
                                                                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                osbErrorMessage := 'El codigo ' ||
                                                                                   nuasigsub ||
                                                                                   ' no existe en la tabla Ld_sales_withoutsubsidy';
                                                                ROLLBACK;
                                                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                                 osbErrorMessage);
                                                            END IF;

                                                            --/*Actualizacion de la orden en el registro de venta no subsidiada*
                                                            daLd_sales_withoutsubsidy.updOrder_Id(inuasig_subsidy_id,
                                                                                                  nuOrderId);

                                                            COMMIT;

                                                            --FIN NC1112*/

                                                            /* Generacion de Multa
                                                            nuOperatingUnitId := daor_order.fnuGetOperating_Unit_Id(SalesWithoutsubsidy.Order_Id,
                                                                                                                    null
                                                                                                                   );

                                                            --/*Validar unidad operativa*
                                                            if nuOperatingUnitId is null then
                                                              onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                              osbErrorMessage := 'No se puede crear la multa porque no se encontro unidad operativa para la orden '||nuOrderId;
                                                              rollback;
                                                              ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                            end if;

                                                            nuContractorID    := daor_operating_unit.fnuGetContractor_Id(nuOperatingUnitId,
                                                                                                                         null
                                                                                                                        );

                                                            --/*Validar contratista*
                                                            if nuContractorID is null then
                                                              onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                              osbErrorMessage := 'No se puede crear la multa porque no se encontro contratista para la orden '||nuOrderId;
                                                              rollback;
                                                              ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                            end if;

                                                            ct_bonovelty.createnovelty(inucontractor => nuContractorID,
                                                                                       inuoperunit   => nuOperatingUnitId,
                                                                                       inuitem       => ld_boconstans.cnupenalize_activity,
                                                                                       inutecunit    => null,
                                                                                       inuorderid    => SalesWithoutsubsidy.Order_Id,
                                                                                       inuvalue      => null,
                                                                                       inuamount     => null,
                                                                                       inuuserid     => null,
                                                                                       inucommentype => null,
                                                                                       isbcomment    => null,
                                                                                       onuorder      => nuOrderId_Out,
                                                                                       inureltype    => ld_boconstans.cnuTransitionSub,
                                                                                       iboisautom    => False);

                                                            ---Fin Generacion de Multa*

                                                            if nvl(nuOrderId_Out, 0) <= 0 then
                                                              onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                              osbErrorMessage := 'Error al generar la orden de Multa';
                                                              rollback;
                                                              ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                            else

                                                              --/*Obtener el codigo de asignacion del subsidio*
                                                              nuasigsub :=  FsbGetString(1, inuasig_subsidy_id, '-');

                                                              --/*Validad que el codigo exista*
                                                              if not daLd_sales_withoutsubsidy.fblExist(nuasigsub) then
                                                                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                                                                osbErrorMessage := 'El codigo '||nuasigsub||' no existe en la tabla Ld_sales_withoutsubsidy';
                                                                rollback;
                                                                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
                                                              end if;

                                                              --/*Actualizacion de la orden en el registro de venta no subsidiada*
                                                              daLd_sales_withoutsubsidy.updOrder_Id(inuasig_subsidy_id, nuOrderId);

                                                              commit;

                                                            end if;
                                                            --*/
                                                        END IF;
                                                    END IF;
                                                ELSE
                                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                                    osbErrorMessage := 'La Actividad [' ||
                                                                       Ld_boconstans.cnudocactivity ||
                                                                       '] no esta asociada a la orden [' ||
                                                                       OrderAsig.Order_Id ||
                                                                       '] no esta asociada a la orden ';
                                                    ROLLBACK;
                                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                                     osbErrorMessage);
                                                END IF;
                                                CLOSE cuOrderActivity;
                                            END IF; ---
                                        END IF;
                                    END IF;
                                ELSE
                                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                    osbErrorMessage := 'Inconvenientes con la orden [' ||
                                                       SalesWithoutsubsidy.Order_Id || ']';
                                    --close cuOrder;
                                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                     osbErrorMessage);
                                END IF;
                                CLOSE cuOrder;
                            ELSE
                                onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                                osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
                                ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                                 osbErrorMessage);
                            END IF;
                        ELSE
                            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                            osbErrorMessage := 'Error al procesar la validacion de documentos para el subsidio asignado [' ||
                                               inuasig_subsidy_id || ']';
                            ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                             osbErrorMessage);
                        END IF;
                        CLOSE cuSalesWithoutsubsidy;
                        ------*/
                    END IF;
                    CLOSE cuAsigSubsidy;
                    -------*/
                ELSE
                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'Causal de legalizacion invalida';
                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);
                END IF;
            END IF;
        ELSE
            onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Causal de legalizacion invalida';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.DeliveryDocumentation', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
			ut_trace.trace ('termina con error controlado '||SQLERRM);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
						ut_trace.trace ('termina con error no controlado '||SQLERRM);
            ROLLBACK;
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END DeliveryDocumentation;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procbalancesub
       Descripcion    : Balancea los valores de entrega totoal y disponible
                        de un subsidio
       Autor          : jonathan alberto consuegra lara
       Fecha          : 18/12/2012

       Parametros       Descripcion
       ============     ===================
       inusubsidy       Identificador del subsidio
       ircubication     Registro de la ubicacion subsidiada
       inusubvalue      Valor del subsidio
       inuoption        Opcion de funcionalidad. 1: entrega de subsidio
                        2: reversion de subsidios

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       18/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procbalancesub(inusubsidy   ld_subsidy.subsidy_id%TYPE,
                             ircubication dald_ubication.styld_ubication,
                             inusubvalue  ld_subsidy.authorize_value%TYPE,
                             inuoption    NUMBER) IS

        nuubitotal_deliver   ld_ubication.total_deliver%TYPE;
        nuubitotal_available ld_ubication.total_available%TYPE;
        rcsubsidy            dald_subsidy.styld_subsidy;
        nusubtotal_deliver   ld_subsidy.total_deliver%TYPE;
        nusubtotal_available ld_subsidy.total_available%TYPE;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procbalancesub', pkg_traza.cnuNivelTrzDef);

        IF inuoption = ld_boconstans.cnuonenumber THEN

            /*Actualizar los valores de la ubicacion geografica y el encabezado del subsidio*/

            /*Si el subsidio esta parametrizado por valor*/
            IF ircubication.authorize_value IS NOT NULL THEN
                /*Actualizar ubicacion*/
                --total entregado
                nuubitotal_deliver := nvl(ircubication.total_deliver,
                                          ld_boconstans.cnuCero_Value) +
                                      inusubvalue;

                --total disponible
                IF nvl(ircubication.total_available,
                       ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nuubitotal_available := nvl(ircubication.authorize_value,
                                                ld_boconstans.cnuCero_Value) -
                                            inusubvalue;
                ELSE
                    nuubitotal_available := nvl(ircubication.total_available,
                                                ld_boconstans.cnuCero_Value) -
                                            inusubvalue;
                END IF;

                Dald_Ubication.updTotal_Deliver(ircubication.ubication_id,
                                                nuubitotal_deliver);

                Dald_Ubication.updtotal_available(ircubication.ubication_id,
                                                  nuubitotal_available);

                /*Obtener datos del subsidio*/
                DALD_subsidy.LockByPkForUpdate(inusubsidy, rcsubsidy);

                /*Actualizar encabezado del subsidio*/
                /*total entregado*/
                nusubtotal_deliver := nvl(rcsubsidy.total_deliver,
                                          ld_boconstans.cnuCero_Value) +
                                      inusubvalue;

                /*total disponible*/
                IF nvl(rcsubsidy.total_available, ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nusubtotal_available := nvl(rcsubsidy.authorize_value,
                                                ld_boconstans.cnuCero_Value) -
                                            inusubvalue;
                ELSE
                    nusubtotal_available := nvl(rcsubsidy.total_available,
                                                ld_boconstans.cnuCero_Value) -
                                            inusubvalue;
                END IF;

                Dald_Subsidy.updTotal_Deliver(inusubsidy, nusubtotal_deliver);

                Dald_Subsidy.updTotal_Available(inusubsidy,
                                                nusubtotal_available);
            END IF;

            /*Si el subsidio esta parametrizado por cantidad*/
            IF ircubication.authorize_quantity IS NOT NULL THEN
                /*Actualizar ubicacion*/
                /*total entregado*/
                nuubitotal_deliver := nvl(ircubication.total_deliver,
                                          ld_boconstans.cnuCero_Value) +
                                      ld_boconstans.cnuonenumber;

                /*total disponible*/
                IF nvl(ircubication.total_available,
                       ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nuubitotal_available := nvl(ircubication.authorize_quantity,
                                                ld_boconstans.cnuCero_Value) -
                                            ld_boconstans.cnuonenumber;
                ELSE
                    nuubitotal_available := nvl(ircubication.total_available,
                                                ld_boconstans.cnuCero_Value) -
                                            ld_boconstans.cnuonenumber;
                END IF;

                Dald_Ubication.updTotal_Deliver(ircubication.ubication_id,
                                                nuubitotal_deliver);

                Dald_Ubication.updtotal_available(ircubication.ubication_id,
                                                  nuubitotal_available);

                /*Obtener datos del subsidio*/
                DALD_subsidy.LockByPkForUpdate(inusubsidy, rcsubsidy);

                /*Actualizar encabezado del subsidio*/
                /*total entregado*7
                nusubtotal_deliver := nvl(rcsubsidy.total_deliver,
                                          ld_boconstans.cnuCero_Value) +
                                      ld_boconstans.cnuonenumber;

                /*total disponible*/
                IF nvl(rcsubsidy.total_available, ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nusubtotal_available := nvl(rcsubsidy.authorize_quantity,
                                                ld_boconstans.cnuCero_Value) -
                                            ld_boconstans.cnuonenumber;
                ELSE
                    nusubtotal_available := nvl(rcsubsidy.total_available,
                                                ld_boconstans.cnuCero_Value) -
                                            ld_boconstans.cnuonenumber;
                END IF;

                Dald_Subsidy.updTotal_Deliver(inusubsidy, nusubtotal_deliver);

                Dald_Subsidy.updTotal_Available(inusubsidy,
                                                nusubtotal_available);

            END IF;

        END IF;

        /*Reversar cantidades del subsidio*/
        IF inuoption = ld_boconstans.cnutwonumber THEN

            /*Actualizar los valores de la ubicacion geografica y el encabezado del subsidio*/

            /*Si el subsidio esta parametrizado por valor*/
            IF ircubication.authorize_value IS NOT NULL THEN
                /*Actualizar ubicacion*/
                /*total entregado*/
                nuubitotal_deliver := nvl(ircubication.total_deliver,
                                          ld_boconstans.cnuCero_Value) -
                                      inusubvalue;

                /*total disponible*/
                IF nvl(ircubication.total_available,
                       ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nuubitotal_available := nvl(ircubication.authorize_value,
                                                ld_boconstans.cnuCero_Value) +
                                            inusubvalue;
                ELSE
                    nuubitotal_available := nvl(ircubication.total_available,
                                                ld_boconstans.cnuCero_Value) +
                                            inusubvalue;
                END IF;

                Dald_Ubication.updTotal_Deliver(ircubication.ubication_id,
                                                nuubitotal_deliver);

                Dald_Ubication.updtotal_available(ircubication.ubication_id,
                                                  nuubitotal_available);

                /*Obtener datos del subsidio*/
                DALD_subsidy.LockByPkForUpdate(inusubsidy, rcsubsidy);

                /*Actualizar encabezado del subsidio*/
                /*total entregado*/
                nusubtotal_deliver := nvl(rcsubsidy.total_deliver,
                                          ld_boconstans.cnuCero_Value) -
                                      inusubvalue;

                /*total disponible*/
                IF nvl(rcsubsidy.total_available, ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nusubtotal_available := nvl(rcsubsidy.authorize_value,
                                                ld_boconstans.cnuCero_Value) +
                                            inusubvalue;
                ELSE
                    nusubtotal_available := nvl(rcsubsidy.total_available,
                                                ld_boconstans.cnuCero_Value) +
                                            inusubvalue;
                END IF;

                Dald_Subsidy.updTotal_Deliver(inusubsidy, nusubtotal_deliver);

                Dald_Subsidy.updTotal_Available(inusubsidy,
                                                nusubtotal_available);
            END IF;

            /*Si el subsidio esta parametrizado por cantidad*/
            IF ircubication.authorize_quantity IS NOT NULL THEN
                /*Actualizar ubicacion*/
                /*total entregado*/
                nuubitotal_deliver := nvl(ircubication.total_deliver,
                                          ld_boconstans.cnuCero_Value) -
                                      ld_boconstans.cnuonenumber;

                /*total disponible*/
                IF nvl(ircubication.total_available,
                       ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nuubitotal_available := nvl(ircubication.authorize_quantity,
                                                ld_boconstans.cnuCero_Value) +
                                            ld_boconstans.cnuonenumber;
                ELSE
                    nuubitotal_available := nvl(ircubication.total_available,
                                                ld_boconstans.cnuCero_Value) +
                                            ld_boconstans.cnuonenumber;
                END IF;

                Dald_Ubication.updTotal_Deliver(ircubication.ubication_id,
                                                nuubitotal_deliver);

                Dald_Ubication.updtotal_available(ircubication.ubication_id,
                                                  nuubitotal_available);

                /*Obtener datos del subsidio*/
                DALD_subsidy.LockByPkForUpdate(inusubsidy, rcsubsidy);

                /*Actualizar encabezado del subsidio*/
                /*total entregado*/
                nusubtotal_deliver := nvl(rcsubsidy.total_deliver,
                                          ld_boconstans.cnuCero_Value) -
                                      ld_boconstans.cnuonenumber;

                /*total disponible*/
                IF nvl(rcsubsidy.total_available, ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    nusubtotal_available := nvl(rcsubsidy.authorize_quantity,
                                                ld_boconstans.cnuCero_Value) +
                                            ld_boconstans.cnuonenumber;
                ELSE
                    nusubtotal_available := nvl(rcsubsidy.total_available,
                                                ld_boconstans.cnuCero_Value) +
                                            ld_boconstans.cnuonenumber;
                END IF;

                Dald_Subsidy.updTotal_Deliver(inusubsidy, nusubtotal_deliver);

                Dald_Subsidy.updTotal_Available(inusubsidy,
                                                nusubtotal_available);

            END IF;

        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procbalancesub', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procbalancesub;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procassigsubinbilling
       Descripcion    : Crear los cargos credito para la asignacion de un
                        subsidio retroactivo de un contrato.
       Autor          : jonathan alberto consuegra lara
       Fecha          : 18/12/2012

       Parametros       Descripcion
       ============     ===================
       inuasig_sub_id   Identificador del subsidio asignado

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       18/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procassigsubinbilling(inuasig_sub_id ld_asig_subsidy.asig_subsidy_id%TYPE) IS

        rcld_asig_subsidy dald_asig_subsidy.styld_asig_subsidy;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procassigsubinbilling', pkg_traza.cnuNivelTrzDef);
        /*Obtener los datos de todo el registro del subsidio asignado*/
        Dald_Asig_Subsidy.getRecord(inuasig_sub_id, rcld_asig_subsidy);
        Ld_bosubsidy.Applysubsidy(rcld_asig_subsidy);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procassigsubinbilling', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procassigsubinbilling;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Applysubsidy
       Descripcion    : Se encarga de aplicar los subsidios en sus distintas
                        modalidades
       Autor          : jonathan alberto consuegra lara
       Fecha          : 19/12/2012

       Parametros          Descripcion
       ============        ===================
       ircld_asig_subsidy  registro de tipo ld_asig_subsidy

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       19/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Applysubsidy(ircld_asig_subsidy dald_asig_subsidy.styld_asig_subsidy) IS

        nusesunuse      servsusc.sesunuse%TYPE;
        rfconcept       pkConstante.tyRefCursor;
        rfconceptdebt   ld_subsidy_detail%ROWTYPE;
        nudebtconc      cargos.cargvalo%TYPE;
        nutotdebtconc   cargos.cargvalo%TYPE;
        nusubsidyvalue  ld_subsidy.authorize_value%TYPE;
        nuappconc       ld_subsidy.conccodi%TYPE;
        nucause         cargos.cargcaca%TYPE;
        nuchargevalue   cargos.cargvalo%TYPE;
        nuorder         or_order.order_id%TYPE;
        nucauslegaorder or_order.Causal_Id%TYPE;
        nuswgencharge   NUMBER;
        nusalewithsub   NUMBER;
        nuappsubconcept ld_subsidy.conccodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Applysubsidy', pkg_traza.cnuNivelTrzDef);

        /*Obtener el servicio suscrito de GAS de la suscripcion*/
        nusesunuse := ld_bcsubsidy.fnugetsesunuse(ircld_asig_subsidy.package_id,
                                                  NULL);
        /*Obtener la causa del cargo*/
        nucause := ld_boconstans.cnusubchargecause;
        /*Obtener el concepto de aplicacion del subsidio*/
        nuappconc := dald_subsidy.fnuGetConccodi(ircld_asig_subsidy.subsidy_id);
        /*si el subsidio es retroactivo*/
        IF ircld_asig_subsidy.type_subsidy = ld_boconstans.csbretroactivesale THEN
            /*Obtener los conceptos que pueden ser subsidiados*/
            IF nusesunuse IS NOT NULL THEN
                /*Si la venta fue subsidiada entonces se ubica la deuda a patir
                del concepto de aplicacion del subsidio sino a partir
                de los conceptos que pueden ser subsidiados*/
                nusalewithsub := Ld_bcsubsidy.Fnugetsalwithsubasig(ircld_asig_subsidy.package_id);
                IF nusalewithsub > ld_boconstans.cnuCero_Value THEN
                    /*Obtener el concepto de aplicacion del subsidio*/
                    nuappsubconcept := Dald_Subsidy.fnuGetConccodi(ircld_asig_subsidy.subsidy_id,
                                                                   NULL);
                    /*Consultar si el usuario tiene deuda del concepto de aplicacion del subsidio*/
                    nudebtconc    := Ld_bosubsidy.Fnudebtconcept(fnugetsuscbypackages(ircld_asig_subsidy.package_id),
                                                                 nuappsubconcept);
                    nutotdebtconc := nudebtconc;
                ELSE
                    /*Obtener los conceptos que pueden ser subsidiados */
                    Ld_bcsubsidy.procgetubiconc(ircld_asig_subsidy.ubication_id,
                                                rfconcept);

                    LOOP
                        FETCH rfconcept
                            INTO rfconceptdebt;
                        EXIT WHEN rfconcept%NOTFOUND;
                        /*Consultar si el usuario tiene deuda del concepto de aplicacion del subsidio*/
                        nudebtconc := Ld_bosubsidy.Fnudebtconcept(fnugetsuscbypackages(ircld_asig_subsidy.package_id),
                                                                  rfconceptdebt.conccodi);

                        IF nvl(nudebtconc, 0) > ld_boconstans.cnuCero_Value THEN
                            /*Cliente posee deuda del concepto*/
                            nutotdebtconc := nvl(nutotdebtconc,
                                                 ld_boconstans.cnuCero_Value) +
                                             nvl(nudebtconc,
                                                 ld_boconstans.cnuCero_Value);

                        END IF;
                    END LOOP;
                END IF;

                /*Obtener el valor individual del subsidio*/
                nusubsidyvalue := Ld_Bosubsidy.FnugetmaxsubsVal(ircld_asig_subsidy.promotion_id,
                                                                ircld_asig_subsidy.ubication_id,
                                                                NULL,
                                                                NULL,
                                                                ld_boconstans.cnuthreenumber,
                                                                damo_packages.fdtgetrequest_date(ircld_asig_subsidy.package_id,
                                                                                                 0));

                /*Obtener orden*/
                nuorder := dald_asig_subsidy.fnuGetOrder_Id(ircld_asig_subsidy.asig_subsidy_id,
                                                            NULL);
                /*Obtener causal de legalizacion*/
                nucauslegaorder := daor_order.fnuGetCausal_Id(nuorder);
                /*Limpiar variable*/
                nuswgencharge := 0;
                /*Determinar si la orden se legalizo como incumplida*/
                IF nvl(nucauslegaorder, ld_boconstans.cnuallrows) =
                   or_boconstants.cnuFailCausal THEN
                    /*Si ingresa aca no se debe generar cargo credito*/
                    nuswgencharge := 1;
                END IF;

                /*Cliente no posee deuda por los conceptos a subsidiar*/
                IF nvl(nutotdebtconc, ld_boconstans.cnuCero_Value) =
                   ld_boconstans.cnuCero_Value THEN
                    /*Consultar si se aplica saldo a favor*/
                    IF ld_boconstans.csbapplybalance =
                       ld_boconstans.csbafirmation THEN
                        IF nuswgencharge = ld_boconstans.cnuCero_Value THEN
                            /*Aplicar saldo a favor por el total del valor del subsidio*/
                            pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
                            pkChargeMgr.GenerateCharge(nusesunuse,
                                                       ld_boconstans.cnuallrows,
                                                       nuappconc,
                                                       nucause,
                                                       nusubsidyvalue,
                                                       'CR',
                                                       'PP-' ||
                                                       ircld_asig_subsidy.package_id,
                                                       'A',
                                                       ld_boconstans.cnuCero_Value,
                                                       NULL,
                                                       NULL,
                                                       NULL,
                                                       FALSE,
                                                       SYSDATE);
                        END IF;
                    END IF;
                END IF;

                /*Cliente posee deuda por los conceptos a subsidiar*/
                IF nvl(nutotdebtconc, ld_boconstans.cnuCero_Value) >
                   ld_boconstans.cnuCero_Value THEN

                    /*si la deuda es mayor o igual al subsidio, se aplica todo el subsidio*/
                    IF nvl(nutotdebtconc, ld_boconstans.cnuCero_Value) >=
                       nvl(nusubsidyvalue, ld_boconstans.cnuCero_Value) THEN
                        NULL;
                    ELSE
                        /*si la deuda es menor al valor del subsidio sera: valor de la deuda*/
                        nusubsidyvalue := nvl(nutotdebtconc,
                                              ld_boconstans.cnuCero_Value);
                    END IF;

                    /*Consultar si se aplica saldo a favor*/
                    IF ld_boconstans.csbapplybalance =
                       ld_boconstans.csbafirmation THEN

                        IF nuswgencharge = ld_boconstans.cnuCero_Value THEN
                            /*Aplicar saldo a favor por el total del valor del subsidio que esta en nusubsidyvalue*/
                            pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);

                            pkChargeMgr.GenerateCharge(nusesunuse,
                                                       ld_boconstans.cnuallrows,
                                                       nuappconc,
                                                       nucause,
                                                       nusubsidyvalue,
                                                       'CR',
                                                       'PP-' ||
                                                       ircld_asig_subsidy.package_id,
                                                       'A',
                                                       ld_boconstans.cnuCero_Value,
                                                       NULL,
                                                       NULL,
                                                       NULL,
                                                       FALSE,
                                                       SYSDATE);
                        END IF;
                    ELSE
                        /*Crear cargo credito por el valor que esta en nusubsidyvalue*/
                        /*Nota: los cargos creditos por los subsidios asignados se crearan
                          al momento de la persona entregar los documentos requeridos
                          por medio del llamado al metodo  de este paquete
                        */
                        IF nuswgencharge = ld_boconstans.cnuCero_Value THEN
                            pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
                            pkChargeMgr.GenerateCharge(nusesunuse,
                                                       ld_boconstans.cnuallrows,
                                                       nuappconc,
                                                       nucause,
                                                       nusubsidyvalue,
                                                       'CR',
                                                       'PP-' ||
                                                       ircld_asig_subsidy.package_id,
                                                       'A',
                                                       ld_boconstans.cnuCero_Value,
                                                       NULL,
                                                       NULL,
                                                       NULL,
                                                       FALSE,
                                                       SYSDATE);
                        END IF;
                    END IF;
                END IF;

            ELSE
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'El cliente no posee un servicio suscrito de gas asociado');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
        END IF;

        /*si el subsidio es a nivel de venta*/
        IF ircld_asig_subsidy.type_subsidy = ld_boconstans.csbGASSale THEN
            IF nusesunuse IS NOT NULL THEN
                /*Valor del cargo*/
                nuchargevalue := ircld_asig_subsidy.subsidy_value;
                /*Crear cargo credito con el monto del subsidio*/
                pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
                pkChargeMgr.GenerateCharge(nusesunuse,
                                           ld_boconstans.cnuallrows,
                                           nuappconc,
                                           nucause,
                                           nuchargevalue,
                                           'CR',
                                           'PP-' ||
                                           ircld_asig_subsidy.package_id,
                                           'A',
                                           ld_boconstans.cnuCero_Value,
                                           NULL,
                                           NULL,
                                           NULL,
                                           FALSE,
                                           SYSDATE);
            END IF;
        END IF;
        UT_Trace.Trace('Fin Ld_BoSubsidy.Applysubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Applysubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procinssalewithoutsubsidy
       Descripcion    : Se encarga de registrar ventas sin subsidio
       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/12/2012

       Parametros          Descripcion
       ============        ===================
       nupackage_id        identificador de la solicitud de venta

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procinssalewithoutsubsidy(inupackage_id mo_packages.package_id%TYPE) IS

        nusalerecord DALd_sales_withoutsubsidy.styLd_sales_withoutsubsidy;
        nuid         Ld_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%TYPE;
        --nuerror      number;
        --sbmessage    varchar2(2000);
        nuorderid OR_order.order_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procinssalewithoutsubsidy', pkg_traza.cnuNivelTrzDef);

        /*Obtener el numero de registro para la entidad en donde se almacenan las ventas no subsidiadas*/
        nuid := LD_BOSequence.Fnuseqsaleswithoutsub;

        /*Crear la orden de trabajo por medio de la cual se solicitaran los documentos*/
        Ld_bosubsidy.proccreatedocorder(inupackage_id,
                                        ld_boconstans.cnuonenumber,
                                        nuorderid);

        /*Registrar venta sin subsidio*/
        nusalerecord.sales_withoutsubsidy_id := nuid;
        nusalerecord.package_id              := inupackage_id;
        nusalerecord.order_id                := nuorderid;
        nusalerecord.delivery_doc            := ld_boconstans.csbNOFlag;
        nusalerecord.state                   := ld_boconstans.csBAproba;
        nusalerecord.insert_date             := SYSDATE;
        nusalerecord.user_id                 := SA_BOUser.fnuGetUserId;
        nusalerecord.sesion                  := userenv('SESSIONID');
        nusalerecord.terminal                := userenv('TERMINAL');

        DALd_sales_withoutsubsidy.insRecord(nusalerecord);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procinssalewithoutsubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procinssalewithoutsubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : proccreatedocorder
       Descripcion    : Se encarga crear las ordenes de solicitud de
                        documentos para las ventas
       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/12/2012

       Parametros          Descripcion
       ============        ===================
       inupackage_id       identificador de la solicitud de venta
       inuoption           crear la orden para una actividad especifica.
                           Si es 1, toma la actividad para una venta
                           no subsidiada. Si es 2, toma la actividad
                           para una venta subsidiada
       onuorderid          orden de trabajo creada


       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE proccreatedocorder(inupackage_id mo_packages.package_id%TYPE,
                                 inuoption     NUMBER,
                                 onuorderid    OUT OR_order.order_id%TYPE) IS

        nuActivity        ge_items.items_id%TYPE;
        sbcomment         OR_order_activity.comment_%TYPE;
        nuMotive          mo_motive.motive_id%TYPE;
        nuaddress_id      ge_Subscriber.Address_Id%TYPE;
        nuorderactivityid OR_order_Activity.order_activity_id%TYPE;
        nunuse            servsusc.sesunuse%TYPE;
        nususc            suscripc.susccodi%TYPE;
        nuclien           ge_subscriber.subscriber_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.proccreatedocorder', pkg_traza.cnuNivelTrzDef);

        /*Si la orden es para una venta no subsidiada*/
        IF inuoption = ld_boconstans.cnuonenumber THEN
            nuActivity := LD_BOConstans.cnudocactivity_normalsales;
            sbcomment  := 'Solicitud de documentos - venta no subsidiada';
        END IF;

        /*Si la orden es para una venta subsidiada*/
        IF inuoption = ld_boconstans.cnutwonumber THEN
            sbcomment  := 'Solicitud de documentos - venta subsidiada';
            nuActivity := Ld_boconstans.cnudocactivity;
        END IF;

        /*Obtener el motivo de la solicitud*/
        nuMotive := ld_bcsubsidy.Fnugetmotive(inupackage_id, NULL);

        /*Id de la direccion de la ejecucion de la orden*/
        nuaddress_id := Damo_Packages.Fnugetaddress_Id(inupackage_id, NULL);

        nunuse := ld_bcsubsidy.Fnugetsesunuse(inupackage_id, NULL);

        nususc := Ld_BoSubsidy.fnugetsuscbypackages(inupackage_id);

        nuclien := pktblsuscripc.fnugetsuscclie(Ld_BoSubsidy.fnugetsuscbypackages(inupackage_id),
                                                NULL);

        /*Creacion de la orden de solicitud de documentos*/
        or_boorderactivities.CreateActivity(nuActivity,
                                            inupackage_id,
                                            nuMotive,
                                            NULL,
                                            NULL,
                                            nuaddress_id,
                                            NULL,
                                            nuclien,
                                            nususc,
                                            nunuse,
                                            NULL,
                                            NULL,
                                            NULL,
                                            ld_boconstans.cnuproordocuments,
                                            sbcomment,
                                            FALSE,
                                            NULL,
                                            onuorderid,
                                            nuorderactivityid,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            'NO',
                                            NULL,
                                            NULL);

        UT_Trace.Trace('Fin Ld_BoSubsidy.proccreatedocorder', pkg_traza.cnuNivelTrzDef);

    END proccreatedocorder;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procinssubsidyconcept
       Descripcion    : Se encarga de registrar los conceptos subsidiados
                        durante la venta
       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/12/2012

       Parametros          Descripcion
       ============        ===================
       nupackage_id        identificador de la solicitud de venta

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procinssubsidyconcept(inupackage_id mo_packages.package_id%TYPE,
                                    inuubication  ld_ubication.ubication_id%TYPE) IS

        nuconceptrecord DALd_subsidy_concept.styLd_subsidy_concept;
        nuid            Ld_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%TYPE;
        rfconcepto      pkConstante.tyRefCursor;
        rfconceptsub    Dald_Subsidy_Detail.styLD_subsidy_detail;
        nuconcvalue     ta_vigetaco.vitcvalo%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procinssubsidyconcept', pkg_traza.cnuNivelTrzDef);

        /*Obtener los conceptos a ser subsidiados*/
        Ld_bcsubsidy.Procgetubiconc(inuubication, rfconcepto);

        LOOP
            FETCH rfconcepto
                INTO rfconceptsub;
            EXIT WHEN rfconcepto%NOTFOUND;

            /*Obtener el valor de un concepto*/
            IF rfconceptsub.subsidy_value IS NOT NULL THEN
                nuconcvalue := rfconceptsub.subsidy_value;
            END IF;

            IF rfconceptsub.subsidy_percentage IS NOT NULL THEN
                nuconcvalue := Ld_bosubsidy.Fnupercentageconcvalue(rfconceptsub.conccodi,
                                                                   ld_boconstans.cnuGasService,
                                                                   dald_ubication.fnuGetSucacate(inuubication,
                                                                                                 NULL),
                                                                   dald_ubication.fnuGetSucacodi(inuubication,
                                                                                                 NULL),
                                                                   dald_ubication.fnuGetGeogra_Location_Id(inuubication,
                                                                                                           NULL),
                                                                   nvl(damo_packages.fdtgetrequest_date(inupackage_id,
                                                                                                        0),
                                                                       SYSDATE),
                                                                   rfconceptsub.subsidy_percentage);
            END IF;

            /*Obtener el numero de registro para la entidad en donde se almacenan los
            conceptos subsidiados*/
            nuid := LD_BOSequence.Fnuseqsubidyconcept;

            /*Registrar conceptos a subsidiar*/
            nuconceptrecord.subsidy_concept_id := nuid;
            nuconceptrecord.package_id         := inupackage_id;
            nuconceptrecord.conccodi           := rfconceptsub.conccodi;
            nuconceptrecord.subsidy_value      := nuconcvalue;
            nuconceptrecord.user_id            := SA_BOUser.fnuGetUserId;
            nuconceptrecord.sesion             := userenv('SESSIONID');
            nuconceptrecord.terminal           := userenv('TERMINAL');
            nuconceptrecord.subsidy_id         := dald_ubication.fnuGetSubsidy_Id(inuubication,
                                                                                  NULL);

            DALd_subsidy_concept.insRecord(nuconceptrecord);

        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procinssubsidyconcept', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procinssubsidyconcept;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetsomeoneubication
       Descripcion    : Determina si a un cliente le corresponde alguno de los
                        subsidios parametrizados
       Autor          : jonathan alberto consuegra lara
       Fecha          : 22/12/2012

       Parametros       Descripcion
       ============     ===================
       inusub           identificador del subsidio
       inuloca          ubicacion geografica
       inucate          categoria
       inusubcate       subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       22/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetsomeoneubication(inusub     ld_subsidy.subsidy_id%TYPE,
                                    inuloca    ld_ubication.geogra_location_id%TYPE,
                                    inucate    categori.catecodi%TYPE,
                                    inusubcate subcateg.sucacodi%TYPE)
        RETURN ld_ubication.ubication_id%TYPE IS

        nuubication    ld_ubication.ubication_id%TYPE;
        rfsubsidies    pkConstante.tyRefCursor;
        rfallsubsidies dald_subsidy.styLD_subsidy;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetsomeoneubication', pkg_traza.cnuNivelTrzDef);

        IF inusub IS NULL THEN

            /*Obtener los subsidios parametrizados*/
            Ld_bcsubsidy.Procgetsubsidies(rfsubsidies);

            LOOP
                FETCH rfsubsidies
                    INTO rfallsubsidies;
                EXIT WHEN rfsubsidies%NOTFOUND;
                /*Obtener el codigo de la ubicacion geografica a subsidiar*/
                nuubication := Ld_bosubsidy.Fnugetsububication(rfallsubsidies.subsidy_id,
                                                               inuloca,
                                                               inucate,
                                                               inusubcate);

                IF nuubication IS NOT NULL THEN
                    EXIT;
                END IF;

            END LOOP;

        ELSE

            /*Obtener el codigo de la ubicacion geografica a subsidiar*/
            nuubication := Ld_bosubsidy.Fnugetsububication(inusub,
                                                           inuloca,
                                                           inucate,
                                                           inusubcate);
        END IF;

        RETURN(nuubication);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetsomeoneubication', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetsomeoneubication;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Procassigretrosub
       Descripcion    : Determina si a un cliente le corresponde alguno de los
                        subsidios parametrizados
       Autor          : jonathan alberto consuegra lara
       Fecha          : 22/12/2012

       Parametros       Descripcion
       ============     ===================
       inupackage_id    identificador de la solicitud
       inuCurrent       registro actual
       inuTotal         total de registros a procesar
       onuErrorCode     error en el proceso
       osbErrorMessage  mensaje de error en el proceso

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       22/12/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Procassigretrosub(inupackage_id   IN mo_packages.package_id%TYPE,
                                inuCurrent      IN NUMBER,
                                inuTotal        IN NUMBER,
                                onuErrorCode    OUT NUMBER,
                                osbErrorMessage OUT VARCHAR2) IS

        nuaddress_id    GE_SUBSCRIBER.address_id%TYPE;
        nucategori      SUBCATEG.Sucacate%TYPE;
        nusubcateg      SUBCATEG.Sucacodi%TYPE;
        nulocation      GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE;
        nuestate_number ab_address.estate_number%TYPE;
        nuSubsidy       ld_subsidy.subsidy_id%TYPE;
        nupromotion     cc_promotion.promotion_id%TYPE;
        nuubication_id  ld_ubication.ubication_id%TYPE;
        nusubscriber    ge_subscriber.subscriber_id%TYPE;
        oclFileContent  CLOB;
        --nuUbication     ld_ubication.ubication_id%type;
        nusegment     ab_segments.segments_id%TYPE;
        numotive      mo_motive.motive_id%TYPE;
        nuSusCripc    suscripc.susccodi%TYPE;
        nuuserwithsub NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procassigretrosub', pkg_traza.cnuNivelTrzDef);

        globalnupackage_id := inupackage_id;

        /*setear variable*/
        nuuserwithsub := ld_boconstans.cnuCero_Value;

        /*Obtener el subsidio a asignar de la instancia*/
        nuSubsidy := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY',
                                                           'SUBSIDY_ID');

        /*Obtener id de la direccion del cliente registrada durante la venta*/
        nuaddress_id := damo_packages.fnugetaddress_id(inupackage_id, NULL);

        /*Obtener cliente*/
        nusubscriber := damo_packages.fnuGetSubscriber_Id(inupackage_id, NULL);

        IF nuaddress_id IS NULL THEN
            onuErrorCode    := ld_boconstans.cnuCero_Value;
            osbErrorMessage := 'La direccion registrada en la solicitud = ' ||
                               inupackage_id || ' es nula';
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        ELSE

            /*Obtener la ubicacion geografica del cliente*/
            nulocation := Daab_Address.fnuGetGeograp_Location_Id(nuaddress_id,
                                                                 NULL);

            /*Obtener codigo del predio del cliente*/
            nuestate_number := Daab_Address.fnuGetEstate_Number(nuaddress_id,
                                                                NULL);

            /*Obtener categoria y subcategoria del predio del cliente*/
            nucategori := daab_premise.fnuGetCategory_(nuestate_number, NULL);

            nusubcateg := daab_premise.fnuGetSubcategory_(nuestate_number, NULL);

            /*Validar segunda instancia si la categoria es nula*/
            IF nucategori IS NULL OR nusubcateg IS NULL THEN

                /*Obtener el segment_id de la direccion*/
                nusegment := daab_address.fnuGetSegment_Id(nuaddress_id, NULL);

                /*Obtener categoria y subcategoria de la direccion*/
                nucategori := daab_segments.fnuGetCategory_(nusegment, NULL);

                nusubcateg := daab_segments.fnuGetSubcategory_(nusegment, NULL);

            END IF;

            /*Validar ubicacion geografica*/
            IF nulocation IS NULL THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La ubicacion geografica es nula';
                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
            ELSE
                IF NOT dage_geogra_location.fblexist(nulocation) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La ubicacion geografica no existe';
                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);
                END IF;
            END IF;

            /*Validar categoria*/
            IF nucategori IS NULL THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La categoria no debe ser nula';
                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
            ELSE
                IF NOT dacategori.fblexist(nucategori) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La categoria no existe';
                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);
                END IF;
            END IF;

            /*Validar subcategoria*/
            IF nusubcateg IS NULL THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La subcategoria no debe ser nula';
                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
            ELSE
                IF NOT dasubcateg.fblexist(nucategori, nusubcateg) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La subcategoria no existe';
                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);
                END IF;
            END IF;

            /*Obtener el codigo del motivo de la solicitud*/
            numotive := Ld_BcSubsidy.Fnugetmotive(inupackage_id, NULL);

            /*Obtener la suscripcion de la solicitud*/
            nuSusCripc := damo_motive.fnuGetSubscription_Id(numotive, NULL);

            /*Validar suscripcion*/
            IF nuSusCripc IS NULL THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La solicitud ' || inupackage_id ||
                                   ' no cuenta con un contrato';
                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
            ELSE
                /*Validar si el contrato existe*/
                IF NOT pktblsuscripc.fblexist(nuSusCripc) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'El contrato no existe';
                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);
                END IF;
            END IF;

            IF nuSubsidy IS NULL THEN

                /*Obtener la ubicacion del cliente*/
                nuubication_id := Fnugetretroubication(inupackage_id,
                                                       nuSusCripc,
                                                       nulocation,
                                                       nucategori,
                                                       nusubcateg);

                IF nuubication_id IS NOT NULL THEN
                    nupromotion := dald_subsidy.fnuGetPromotion_Id(dald_ubication.fnuGetSubsidy_Id(nuubication_id,
                                                                                                   NULL),
                                                                   NULL);
                END IF;

                BEGIN

                    IF nuubication_id IS NULL THEN
                        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'AL CLIENTE ' || nusubscriber ||
                                           ' NO LE CORRESPONDE NINGUN SUBSIDIO';

                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                         osbErrorMessage);
                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'AL CLIENTE ' || nusubscriber ||
                                           ' NO LE CORRESPONDE NINGUN SUBSIDIO';
                        ROLLBACK;
                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                         osbErrorMessage);
                END;

            ELSE

                /*El subsidio ingreso por parametro*/

                /*Obtener la promocion del subsidio*/
                nupromotion := dald_subsidy.fnuGetPromotion_Id(nuSubsidy, NULL);

                /*Validar si el subsidio a otorgar le corresponde a la persona*/
                nuubication_id := Fnugetsomeoneubication(nuSubsidy,
                                                         nulocation,
                                                         nucategori,
                                                         nusubcateg);

                BEGIN

                    IF nuubication_id IS NULL THEN
                        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'EL SUBSIDIO: ' || nuSubsidy ||
                                           ', NO LE CORRESPONDE AL CLIENTE ' ||
                                           nusubscriber;
                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                         osbErrorMessage);
                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'EL SUBSIDIO: ' || nuSubsidy ||
                                           ', NO LE CORRESPONDE AL CLIENTE ' ||
                                           nusubscriber;
                        ROLLBACK;
                        ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                         osbErrorMessage);
                END;

            END IF;

            BEGIN

                nuuserwithsub := Ld_Bcsubsidy.Fnuuserwithsubsamedeal(dald_subsidy.fnuGetDeal_Id(ld_bcsubsidy.Fnugetpromsubsidy(nupromotion,
                                                                                                                               NULL),
                                                                                                NULL),
                                                                     nuSusCripc);

                IF nuuserwithsub > ld_boconstans.cnucero_value THEN

                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'EL CLIENTE ' || nusubscriber ||
                                       ' YA POSEE UN SUBSIDIO ASOCIADO AL CONVENIO ' ||
                                       dald_subsidy.fnuGetDeal_Id(ld_bcsubsidy.Fnugetpromsubsidy(nupromotion,
                                                                                                 NULL),
                                                                  NULL) ||
                                       ' - ' ||
                                       dald_deal.fsbGetDescription(dald_subsidy.fnuGetDeal_Id(ld_bcsubsidy.Fnugetpromsubsidy(nupromotion,
                                                                                                                             NULL),
                                                                                              NULL),
                                                                   NULL);
                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);

                ELSE

                    IF onuErrorCode IS NULL AND osbErrorMessage IS NULL THEN

                        /*Setear variables*/
                        globalsuscripc := NULL;

                        /*Obtener la suscripcion que viene por el archivo*/
                        globalsuscripc := nuSusCripc;

                        nuubiasigsub := NULL;

                        /*Obtener la ubicacion del subsidio a asignar*/
                        nuubiasigsub := nuubication_id;

                        /*Asignar subsidios retroactivos*/
                        Ld_Bosubsidy.Assignsubsidy(nusubscriber,
                                                   nupromotion,
                                                   nulocation,
                                                   nucategori,
                                                   nusubcateg,
                                                   ld_boconstans.csbretroactivesale,
                                                   inupackage_id);
                    END IF;

                END IF;
            EXCEPTION
                WHEN OTHERS THEN

                    onuErrorCode := ld_boconstans.cnuGeneric_Error;

                    IF globalerrormens IS NOT NULL THEN
                        osbErrorMessage := globalerrormens;
                    ELSE
                        osbErrorMessage := 'ERROR AL MOMENTO DE ASIGNARLE UN SUBSIDIO RETROACTIVO AL CLIENTE  ' ||
                                           nusubscriber || ', ' ||
                                           DBMS_UTILITY.FORMAT_ERROR_STACK ||
                                           ' - ' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                    END IF;

                    ROLLBACK;

                    ge_boerrors.seterrorcodeargument(onuErrorCode,
                                                     osbErrorMessage);
            END;

            /*Validar que no ocurrio ningun error en la asignacion*/
            IF globalerrorcode IS NOT NULL AND globalerrormens IS NOT NULL THEN
                onuErrorCode    := globalerrorcode;
                osbErrorMessage := globalerrormens;
                ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
            END IF;

            /*Limpiar variable que acumula los clobs*/
            IF inuCurrent = ld_boconstans.cnuonenumber THEN
                UT_Trace.Trace('blanquea globalclRetroSubsidy', pkg_traza.cnuNivelTrzDef);
                globalclRetroSubsidy := NULL;
            END IF;

            /*Confirmar las transacciones*/
            IF onuErrorCode IS NULL AND osbErrorMessage IS NULL THEN

                COMMIT;

                /*               Inicio de proceso de extraccion y mezcla                 */

                /*Colocar en memoria el codigo de la solicitud procesada*/
                globalnupackage_id := inupackage_id;

                /*Capturar la ubicacion geografica del subsidio a otorgar*/
                globalubication := nuubication_id;

                /*Capturar la ubicacion geografica del cliente*/
                globallocation := nulocation;

                /*Capturar la categoria del cliente*/
                globalcategory := nucategori;

                /*Capturar la subcategoria del cliente*/
                globalsubcategory := nusubcateg;

                UT_Trace.Trace('globalretrosubvalue = ' || globalretrosubvalue,
                               10);

                UT_Trace.Trace('antes de Fnusetdatainmemory', pkg_traza.cnuNivelTrzDef);
                oclFileContent := Ld_Bosubsidy.Fnusetdatainmemory(ld_boconstans.cnuExtract_Retroactive);
                UT_Trace.Trace('despues de Fnusetdatainmemory', pkg_traza.cnuNivelTrzDef);

                /*Acumular los clobs de los usuarios a generar carta de asignacion retroactiva*/
                IF globalclRetroSubsidy IS NULL THEN
                    globalclRetroSubsidy := oclFileContent;
                ELSIF (oclFileContent IS NULL) THEN
                    UT_Trace.Trace('CLOB VACIO # =' || inuCurrent, 15);
                ELSE
                    dbms_lob.append(globalclRetroSubsidy, oclFileContent);
                END IF;

            END IF;

            UT_Trace.Trace('antes de registro final', pkg_traza.cnuNivelTrzDef);

            IF inuCurrent = inuTotal AND globalclRetroSubsidy IS NOT NULL THEN
                UT_Trace.Trace('ingreso ultimo if', pkg_traza.cnuNivelTrzDef);

                /*Captura el contenido de todos los clob*/
                globalclSubsidy := globalclRetroSubsidy;

                /*Obtener la plantilla*/
                globalsbTemplate := Ld_Bosubsidy.Fsbgettemplate(ld_boconstans.cnuExtract_Retroactive);

                /*Llamar a la forma que se encarga de ejecutar el proceso de extraccion y mezcla*/
                Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbRetro_letter_application);
            END IF;
        END IF;

        <<error>>

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procassigretrosub', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN

            ROLLBACK;

            onuErrorCode := ld_boconstans.cnuGeneric_Error;

            IF globalerrormens IS NOT NULL THEN
                globalerrormens := osbErrorMessage;
            ELSE
                osbErrorMessage := 'ERROR AL MOMENTO DE ASIGNARLE UN SUBSIDIO RETROACTIVO AL CLIENTE  ' ||
                                   nusubscriber || ', ' ||
                                   DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                                   DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            END IF;
        WHEN OTHERS THEN

            ROLLBACK;

            onuErrorCode := ld_boconstans.cnuGeneric_Error;

            IF globalerrormens IS NOT NULL THEN
                globalerrormens := osbErrorMessage;
            ELSE
                osbErrorMessage := 'ERROR AL MOMENTO DE ASIGNARLE UN SUBSIDIO RETROACTIVO AL CLIENTE  ' ||
                                   nusubscriber || ', ' ||
                                   DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                                   DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            END IF;
    END Procassigretrosub;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Updatesubsidytocollect
     Descripcion    : Actualiza los subsidios en estado generado
                      que tengan documentacion completa a estado
                      por cobrar

     Autor          : jonathan alberto consuegra lara
     Fecha          : 23/12/2012

     Parametros       Descripcion
     ============     ===================
     Orfuserpotencial cursor con los usuarios potenciales

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     23/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Updatesubsidytocollect IS

        CURSOR cuAsigSubsidy(inuorderstatus   IN or_order.order_status_id%TYPE,
                             inutask_type_id  IN or_order.task_type_id%TYPE,
                             inudelivery_doc  IN ld_asig_subsidy.delivery_doc%TYPE,
                             inuinitial_value IN Ld_Subsidy_States.Subsidy_States_Id%TYPE) IS

            SELECT l.*
            FROM   ld_asig_subsidy l,
                   or_order        o
            WHERE  l.state_subsidy = inuinitial_value
            AND    l.delivery_doc = inudelivery_doc
            AND    o.Causal_Id IN
                   (SELECT o.causal_id
                     FROM   or_task_type_causal o
                     WHERE  REGEXP_INSTR(ld_boconstans.csbCAU_COM_DOC_SUB,
                                         '(\W|^)' || o.causal_id || '(\W|$)') >
                            ld_boconstans.cnuCero_Value
                     AND    o.task_type_id =
                            Ld_Boconstans.cnuCAU_TAS_TYP_DOC_SUB)
            AND    o.order_status_id = inuorderstatus
                  --
            AND    l.order_id = o.order_id;

        rcAsigSubsidy   cuAsigSubsidy%ROWTYPE;
        nuorderstatus   or_order.order_status_id%TYPE;
        nutask_type_id  or_order.task_type_id%TYPE;
        nudelivery_doc  ld_asig_subsidy.delivery_doc%TYPE;
        nuinitial_value Ld_Subsidy_States.Subsidy_States_Id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_bosubsidy.Updatesubsidytocollect');

        /*Obtener el estado 8 de una orden: atendida o legalizada*/
        nuorderstatus := Dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus);
        /*Obtener el tipo de trabajo de las ordenes de subsidios*/
        nutask_type_id := Ld_Boconstans.cnuCAU_TAS_TYP_DOC_SUB;
        /*Estado documentos no entregados*/
        nudelivery_doc := Ld_Boconstans.csbapackagedocok;
        /*Obtener valor inicial del subsidio*/
        nuinitial_value := ld_boconstans.cnuinitial_sub_estate;
        /*Actualizar estado de un subsidio a estado POR COBRAR*/
        FOR rcAsigSubsidy IN cuAsigSubsidy(nuorderstatus,
                                           nutask_type_id,
                                           nudelivery_doc,
                                           nuinitial_value) LOOP

            DALD_ASIG_SUBSIDY.updState_Subsidy(inuasig_subsidy_Id => rcAsigSubsidy.Asig_Subsidy_Id,
                                               inuState_Subsidy$  => ld_boconstans.cnureceivablestate);

            /*Actualizar la fecha en que el subsidio tomo estado POR COBRAR*/
            Dald_Asig_Subsidy.updReceivable_Date(rcAsigSubsidy.Asig_Subsidy_Id,
                                                 SYSDATE);

        END LOOP;

        COMMIT;

        UT_Trace.Trace('Fin Ld_bosubsidy.Updatesubsidytocollect');

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Updatesubsidytocollect;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   RegisterPromo
    Descripcion :   Permite crear una promocion para subsidios con un concepto
    asociado.

    Autor       :   ofajardo
    Fecha       :   17-09-2012 10:50:09
    Parametros  :
        isbDescription:     Descripcion que se registara a la promocion.
        inuPromTypeId:      Tipo de Promocion a registrar.
        inuPriorityId:      Prioridad de la promocion.
        inuProdTypeId:      Tipo de Producto al que aplicara la promocion.
        idtInitOfferDate:   Fecha de inicio de oferta de la promocion.
        idtFinalOfferDate:  Fecha de fin de oferta de la promocion.
        inuConceptId:       Identificador del concepto que se le quiere asociar
                            al detalle de la promocion.
        onuPromId:          Identificador de la promocion generada.

    Historia de Modificaciones
    Fecha     IDEntrega               Modificacion
    ==========  ======================= ========================================
    AEcheverry Copia del paquete de producto Creacion.
    ***************************************************************************/
    PROCEDURE RegisterPromo(isbDescription    IN cc_promotion.description%TYPE,
                            inuPromTypeId     IN cc_promotion.prom_type_id%TYPE,
                            inuPriorityId     IN cc_promotion.priority_id%TYPE,
                            inuProdTypeId     IN cc_promotion.product_type_id%TYPE,
                            idtInitOfferDate  IN cc_promotion.init_offer_date%TYPE,
                            idtFinalOfferDate IN cc_promotion.final_offer_date%TYPE,
                            inuConceptId      IN concepto.conccodi%TYPE,
                            onuPromId         OUT NOCOPY cc_promotion.promotion_id%TYPE) IS
        cnuGeneric_Error CONSTANT ge_message.message_id%TYPE := 2741;
        /* Promocion de tipo monetaria*/
        cnuPromTypeCash CONSTANT cc_promotion.prom_type_id%TYPE := CC_BOUIPromotion.cnuPROMTYPECAHS;
        /* Promocion de tipo obsequio*/
        cnuPromTypeItem CONSTANT cc_promotion.prom_type_id%TYPE := CC_BOUIPromotion.cnuPROMTYPEITEM;
        /* Constante Metodo de Aplicacion */
        cnuApplyMethod CONSTANT cc_prom_detail.apply_method%TYPE := CC_BOUIPromotion.cnuCodiApplyMethod;
        /* Constante Nivel de Aplicacion Solicitud */
        cnuSolApplyLevel CONSTANT cc_prom_detail.apply_level%TYPE := CC_BOUIPromotion.cnuCodiApplyLevelSol;
        /* Constante Nivel de Rollback Producto */
        csbProdRollLevel CONSTANT cc_prom_detail.rollback_level%TYPE := CC_BOUIPromotion.csbCodiRollLevelProd;

        /* Nombre de la entidad cc_promotion */
        csbCC_PROMOTION CONSTANT VARCHAR2(20) := 'CC_PROMOTION';
        /* Nombre de la secuencia para la entidad cc_promotion */
        csbSEQ_CC_PROMOTION CONSTANT VARCHAR2(30) := 'SEQ_CC_PROMOTION_182693';
        /* Nombre de la entidad cc_prom_detail */
        csbCC_PROM_DETAIL CONSTANT VARCHAR2(20) := 'CC_PROM_DETAIL';
        /* Nombre de la secuencia para la entidad cc_prom_detail */
        csbSEQ_CC_PROM_DETAIL CONSTANT VARCHAR2(30) := 'SEQ_CC_PROM_DETAIL_182814';

        /* Tipo de configuracion asociada a los conceptos de solicitud */
        cnuFunctionality CONSTANT gr_config_expression.configura_type_id%TYPE := 93;
        /* Descripcion de la regla asociada al subsidio */
        csbDescription CONSTANT gr_config_expression.description%TYPE := 'Asigna el valor del subsidio.';
        /* Tipo de objeto a generar */
        csbObjectType CONSTANT gr_config_expression.object_type%TYPE := 'PF';
        /* Constante Etapa de Ejecucion de Solicitud */
        csbExeStage CONSTANT concepto.concflde%TYPE := pkBillConst.csbEJECUTA_SOLICITUD;
        /* Expresion de la regla a insertar en gr_config_expression*/
        csbExpression gr_config_expression.expression%TYPE := 'SubsidyInitData(promotion_id,subscriber_id,location_id,category,subcategory);' ||
                                                              'nuSubsidyValue = LD_BOSubsidy.FnuGetMaxSubValue(promotion_id,subscriber_id,location_id,category,subcategory,2)';

        /* Identificador de la regla creada para la promocion */
        nuExpressionId gr_config_expression.config_expression_id%TYPE;
        /* Registro de la promocion */
        rcPromotion dacc_promotion.styCC_promotion;
        /* Registro del detalle de la promocion */
        rcPromDetail dacc_prom_detail.styCC_prom_detail;
        /* Etapa de Ejecucion de Solicitud */
        sbExeStage concepto.concflde%TYPE;
        /* Orden de Generacion del concepto */
        nuGenOrder concepto.concorli%TYPE;
    BEGIN
        UT_Trace.Trace('BEGIN LD_BOSubsidy.RegisterPromo', pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('Description[' || isbDescription || ']', pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('PromTypeId[' || inuPromTypeId || ']', pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('PriorityId[' || inuPriorityId || ']', pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('ProductTypeId[' || inuProdTypeId || ']', pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('OffInitDate[' || idtInitOfferDate || ']', pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('OffEndDate[' || idtFinalOfferDate || ']', pkg_traza.cnuNivelTrzDef);

        /* Validaciones Iniciales */
        /* Valida que el tipo de promocion sea de tipo monetario */
        IF (inuPromTypeId = cnuPromTypeCash OR inuPromTypeId = cnuPromTypeItem) THEN
            Errors.SetError(cnuGeneric_Error,
                            'El tipo de promocion ingresado no es correcto.');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /* Valida que la fecha de fin sea mayor que la fecha de inicio */
        IF (idtFinalOfferDate < idtInitOfferDate) THEN
            Errors.SetError(cnuGeneric_Error,
                            'La fecha de inicio de la oferta de la promocion debe ser menor que la fecha de fin de la oferta de la promocion.');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /* Obtiene la etapa de ejecucion del concepto */
        sbExeStage := pktblconcepto.fsbGetConcflde(inuConceptId);
        /*Valida que la etapa sea de Solicitud 'S' */
        IF (sbExeStage <> csbExeStage) THEN
            Errors.SetError(cnuGeneric_Error,
                            'La etapa de ejecucion del concepto no es correcta.');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        UT_Trace.Trace('Construye el registro de la promocion.', pkg_traza.cnuNivelTrzDef);
        /* Construye el registro de la promocion.*/
        rcPromotion.promotion_id     := GE_BOSequence.fnuGetNextValSequence(csbCC_PROMOTION,
                                                                            csbSEQ_CC_PROMOTION); /* Obligatorio*/
        rcPromotion.description      := isbDescription; /* Obligatorio*/
        rcPromotion.prom_type_id     := inuPromTypeId; /* Obligatorio*/
        rcPromotion.product_type_id  := inuProdTypeId; /* Obligatorio*/
        rcPromotion.init_offer_date  := idtInitOfferDate; /* Obligatorio*/
        rcPromotion.final_offer_date := idtFinalOfferDate; /* Obligatorio*/
        rcPromotion.priority_id      := inuPriorityId; /* Obligatorio*/
        rcPromotion.init_apply_date  := idtInitOfferDate; /* Obligatorio*/
        rcPromotion.final_apply_date := idtFinalOfferDate; /* Obligatorio*/

        dacc_promotion.InsRecord(rcPromotion);

        UT_Trace.Trace('Registrara la Regla de Liquidacion del Concepto para la Promocion',
                       10);
        /*Registra la regla asociada al concepto*/
        GR_BOInterface_Body.GenerateRule(isbExpression    => csbExpression,
                                         inuFunctionality => cnuFunctionality,
                                         isbDescription   => csbDescription,
                                         inuExpressionID  => NULL,
                                         onuExpressionID  => nuExpressionId,
                                         isbObjectType    => csbObjectType);

        GR_BOInterface_Body.MakeExpression(nuExpressionId);

        nuGenOrder := pktblconcepto.fnuGetConcorli(inuConceptId);

        UT_Trace.Trace('Registrara el detalle de la promocion, regla a asociar[' ||
                       nuExpressionId || ']',
                       10);
        /* Registro del detalle de la promocion*/
        rcPromDetail.prom_detail_id       := GE_BOSequence.fnuGetNextValSequence(csbCC_PROM_DETAIL,
                                                                                 csbSEQ_CC_PROM_DETAIL); /* Obligatorio*/
        rcPromDetail.promotion_id         := rcPromotion.promotion_id; /* Obligatorio*/
        rcPromDetail.concept_id           := inuConceptId; /* Obligatorio*/
        rcPromDetail.generation_order     := nuGenOrder; /* Obligatorio*/
        rcPromDetail.config_expression_id := nuExpressionId; /* Obligatorio*/
        rcPromDetail.function_name        := dagr_config_expression.fsbGetObject_Name(nuExpressionId); /* Obligatorio*/
        rcPromDetail.apply_level          := cnuSolApplyLevel; /* Obligatorio*/
        rcPromDetail.concept_class        := sbExeStage; /* Obligatorio*/
        rcPromDetail.rollback_level       := csbProdRollLevel; /* Obligatorio*/
        rcPromDetail.apply_method         := cnuApplyMethod; /* Obligatorio*/

        dacc_prom_detail.insRecord(rcPromDetail);

        onuPromId := rcPromotion.promotion_id;

        UT_Trace.Trace('PromotionId[' || onuPromId || ']', pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('END LD_BOSubsidy.RegisterPromo', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END RegisterPromo;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : proTrasladaDifACorriente
    Descripcion    : Traslada un diferido a corriente, es copia del procedimiento
                     TraslateDefer, la cual transifere un solo diferido y
                     este se modifica para que traslade todos los diferidos de una
                     financiacion
    Autor          : Sandra Mu?oz

    Parametros               Descripcion
    ============         ===================
    inuFinanciacion      Diferido

    Historia de Modificaciones
    Fecha         Autor             Modificacion
    =========   =================== ==========
    27-08-2015  Sandra Mu?oz        Creacion. Aranda8190
    ******************************************************************/
    PROCEDURE proTrasladaDifACorriente(inuFinanciacion diferido.difecofi%TYPE,
                                       onuCuentaCobro  OUT cuencobr.cucocodi%TYPE) IS
        /* Variables de Error */
        nuError   NUMBER;
        sbMessage VARCHAR2(2000);

        -- Diferidos asociados a la financiacion de la venta
        CURSOR cuDifeVenta IS

            SELECT difecodi FROM diferido WHERE difecofi = inuFinanciacion;

    BEGIN
        UT_Trace.Trace('INICIO: Ld_BoSecureManagement.TraslateDefer', pkg_traza.cnuNivelTrzDef);

        /* Se realiza el traslado de Diferido a Corriente */
        pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);

        CC_BODefToCurTransfer.GlobalInitialize;

        -- Cancelar los diferidos de la venta
        FOR rgDifeVenta IN cuDifeVenta LOOP

            CC_BODefToCurTransfer.AddDeferToCollect(rgDifeVenta.difecodi);

        END LOOP;

        CC_BODefToCurTransfer.TransferDebt('LDRSS',
                                           nuError,
                                           sbMessage,
                                           FALSE,
                                           0,
                                           SYSDATE);

        IF (nuError <> ge_boconstants.cnuSUCCESS) THEN
            gw_boerrors.checkerror(nuError, sbMessage);
        END IF;

        CC_BODefToCurTransfer.GlobalInitialize;

        SELECT MAX(cucocodi)
        INTO   onuCuentaCobro
        FROM   cuencobr cc,
               diferido d
        WHERE  cc.cuconuse = d.difenuse
        AND    d.difecofi = inuFinanciacion;

        UT_Trace.Trace('FIN: Ld_BoSecureManagement.TraslateDefer', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END proTrasladaDifACorriente;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del procedimiento: proConceptoSubsidiado

    Descripcion:          Obtiene el codigo del concepto subsidiado para una
                          solicitud de venta

    Parametros entrada:   inuConcSubsidio      : Concepto del subsidio
                          inuPackage_Id        : Solicitud
                          inuSubsidioAplicado  : Subsidio aplicado

    Parametros de salida: osbError             : Mensaje de error
                          nuConceptoSubsidiado : Codigo del concepto subsidiado

    Autor : Sandra Mu?oz.
    Fecha : ARA8190

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    27-08-2015   Sandra Mu?oz           Creacion. Aranda8190
    ******************************************************************/

    PROCEDURE proConceptoSubsidiado(inuConcSubsidio      IN concepto.conccodi%TYPE,
                                    inuPackage_Id        IN mo_packages.package_id%TYPE,
                                    inuSubsidioAplicado  IN ld_subsidy.subsidy_id%TYPE,
                                    osbError             OUT VARCHAR2,
                                    nuConceptoSubsidiado IN OUT concepto.conccodi%TYPE) IS
        nuContrato servsusc.sesususc%TYPE;
        exError EXCEPTION;
    BEGIN
        SELECT lsd.conccodi,
               ss.sesususc
        INTO   nuConceptoSubsidiado,
               nuContrato
        FROM   ld_subsidy        ls,
               ld_ubication      lu,
               ld_subsidy_detail lsd,
               pr_product        pp,
               ab_address        aa,
               mo_motive         mm,
               servsusc          SS
        WHERE  ls.subsidy_id = inuSubsidioAplicado
        AND    ls.conccodi = inuConcSubsidio
        AND    ls.subsidy_id = lu.subsidy_id
        AND    lu.ubication_id = lsd.ubication_id
        AND    lu.geogra_location_id = aa.geograp_location_id
        AND    aa.address_id = pp.address_id
        AND    pp.product_id = mm.product_id
        AND    mm.package_id = inuPackage_id
        AND    pp.product_id = ss.Sesunuse
        AND    ss.Sesucate = lu.sucacate
        AND    ss.Sesusuca = lu.sucacodi;

    EXCEPTION
        WHEN OTHERS THEN
            osbError := 'ld_boSubsidy.proConceptoSubsidiado - ' || SQLERRM ||
                        'Error al buscar el codigo del concepto a subsidiar para la atencion: ' ||
                        inuPackage_id || ' subsidio: ' || inuSubsidioAplicado ||
                        ' concepto subsidio ' || inuConcSubsidio;

    END proConceptoSubsidiado;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del procedimiento: proDifACteVenta

    Descripcion:          Lleva al corriente los diferidos de una financiacion

    Parametros entrada:   inuCuCoSubidio       : Cuenta de cobro de la financiacion
                                                 que se va a llevar a corriente
                          inuConcSubsidio      : Concepto de subsidio que identifica
                                                 la cuenta de cobro de venta
                          inuPackage_Id        : Solicitud de venta
                          inuSubsidioAplicado  : Codigo del subisido que se aplico

    Parametros de salida: onuFinanciacionVenta : Devuelve el codigo de la financiacion
                                                 de la venta
                          onuCuentaCobro       : Cuenta de cobro en la que se
                                                 generan los cargos del diferido
                                                 que se lleva a corriente
                          osbError             : Mensaje de error del procedimiento

    Autor : Sandra Mu?oz.
    Fecha : ARA8190

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    27-08-2015   Sandra Mu?oz           Creacion. Aranda8190
    ******************************************************************/

    PROCEDURE proDifACteVenta(inuCuCoSubidio       IN cuencobr.cucocodi%TYPE,
                              inuConcSubsidio      IN concepto.conccodi%TYPE,
                              inuPackage_Id        IN mo_packages.package_id%TYPE,
                              inuSubsidioAplicado  IN ld_subsidy.subsidy_id%TYPE,
                              onuFinanciacionVenta OUT diferido.difecofi%TYPE,
                              onuCuentaCobro       OUT cuencobr.cucocodi%TYPE,
                              onuCuotasPendientes  OUT diferido.difenucu%TYPE,
                              onuPlanDiferido      OUT diferido.difepldi%TYPE,
                              onuMetCalculo        OUT diferido.difemeca%TYPE,
                              osbError             OUT VARCHAR2) IS

        nuFinanciacion       diferido.difecofi%TYPE; -- Financiacion de la venta
        nuErrorCancDife      NUMBER; -- Codigo del error al cancelar el diferido de la venta
        sbErrorCancDife      VARCHAR2(4000); -- Descripcion al cancelar el diferido de la venta
        nuNuevaCC            cuencobr.cucocodi%TYPE; -- Nueva cuenta de cobro
        nuConceptoSubsidiado concepto.conccodi%TYPE; -- Concepto subsidiado
        nuNota               NOTAS.NOTANUME%TYPE; -- Consecutivo nota
        nuCausaCargo         ld_parameter.numeric_value%TYPE; -- Causa cargo anulacion
        nuError              NUMBER; -- Error
        nuCuotas             diferido.difenucu%TYPE; -- Numero de cuotas de la financiacion de la venta
        nuCuotasFacturadas   diferido.difecupa%TYPE; -- Numero de cuotas

        exError EXCEPTION; -- Excepcion controlada

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.proDifACteVenta', pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('Obtener el codigo del concepto subsidiado', pkg_traza.cnuNivelTrzDef);

        -- Obtener el codigo del concepto subsidiado (para GDO es el 19-Cargo por
        -- conexion) utilizando el modelo de subsidios, el cual con el convenio
        -- que se aplico y la localidad se pueden obtener el concepto sobre el
        -- cual aplica
        proConceptoSubsidiado(inuConcSubsidio,
                              inuPackage_Id,
                              inuSubsidioAplicado,
                              osbError,
                              nuConceptoSubsidiado);

        -- Financiacion de la venta
        UT_Trace.Trace('Financiacion de la venta', pkg_traza.cnuNivelTrzDef);
        nuError := 10;
        BEGIN
            SELECT D.Difecofi,
                   MAX(difenucu),
                   MAX(difecupa),
                   MAX(difepldi),
                   MAX(difemeca)
            INTO   onuFinanciacionVenta,
                   nuCuotas,
                   nuCuotasFacturadas,
                   onuPlanDiferido,
                   onuMetCalculo
            FROM   diferido D,
                   cargos   C
            WHERE  cargdoso = 'FD-' || to_char(difecodi)
            AND    cargnuse = difenuse
            AND    cargcuco = inuCuCoSubidio
            AND    c.cargconc = nuConceptoSubsidiado
            GROUP  BY D.Difecofi;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Error al obtener el codigo de la financiacion: ' ||
                            SQLERRM;
                RAISE exError;
        END;

        nuError := 20;

        UT_Trace.Trace('Calcula cuotas del nuevo diferido', pkg_traza.cnuNivelTrzDef);

        onuCuotasPendientes := nuCuotas - nuCuotasFacturadas;

        IF onuCuotasPendientes = 0 THEN
            onuCuotasPendientes := nuCuotas;
        END IF;

        nuError := 30;

        UT_Trace.Trace('Llama al procedimiento proTrasladaDifACorriente', pkg_traza.cnuNivelTrzDef);
        proTrasladaDifACorriente(inuFinanciacion => onuFinanciacionVenta,
                                 onuCuentaCobro  => onuCuentaCobro);

        UT_Trace.Trace('Fin Ld_BoSubsidy.proDifACteVenta', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN exError THEN
            osbError := 'ld_boSubsidy.proDifACteVenta - ' || nuError || ' - ' ||
                        osbError;

    END proDifACteVenta;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del procedimiento: proFinanciaCtaCobroVenta

    Descripcion:          Financia una cuenta de cobro

    Parametros entrada:   inuCuenCobr        => Cuenta de cobro a financiar
                          inuNroFinanciacion => Numero de financiacion de donde
                                                se tomara la informacion para el
                                                nuevo diferido

    Parametros de salida: osbError           => Error del proceso

    Autor : Sandra Mu?oz.
    Fecha : ARA8190

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    27-08-2015   Sandra Mu?oz           Creacion. Aranda8190
    ******************************************************************/
    PROCEDURE proFinanciaCtaCobroVenta(inuCuenCobr        cuencobr.cucocodi%TYPE,
                                       inuNroFinanciacion diferido.difecofi%TYPE,
                                       inuCuotasNuevoDif  diferido.difenucu%TYPE,
                                       inuPlanNuevoDif    diferido.difepldi%TYPE,
                                       inuMetCalNuevoDif  diferido.difemeca%TYPE,
                                       osbError           OUT VARCHAR2) IS
        nuFactura             cuencobr.cucofact%TYPE; -- Factura de la cuenta de cobro a financiar
        nuCuotas              diferido.difenucu%TYPE; -- Numero de cuotas del diferido
        nuCuotasFacturas      diferido.difecupa%TYPE; -- Numero de cuotas pagadas del diferido
        nuCuotasNuevoDiferido diferido.difenucu%TYPE; -- Numero de cuotas del diferido a crear
        nuPlanDiferido        diferido.difepldi%TYPE; -- Plan de diferido
        nuMetodoCalculo       diferido.difemeca%TYPE; -- Metodo de calculo
        nuPaso                NUMBER; -- Paso ejecutado
        exError EXCEPTION; -- Error controlado

        -- Variables de salida del procedimiento de financiacion
        NUACUMCUOTA         NUMBER;
        NUSALDO             NUMBER;
        NUTOTALACUMCAPITAL  NUMBER;
        NUTOTALACUMCUOTEXTR NUMBER;
        NUTOTALACUMINTERES  NUMBER;
        SBREQUIEREVISADO    VARCHAR2(4000);
        NUDIFECOFI          NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.proFinanciaCtaCobroVenta', pkg_traza.cnuNivelTrzDef);

        nuPaso := 10;

        -- Factura de la cuenta de cobro
        UT_Trace.Trace('Factura de la cuenta de cobro', pkg_traza.cnuNivelTrzDef);
        BEGIN
            SELECT cucofact
            INTO   nuFactura
            FROM   cuencobr
            WHERE  cucocodi = inuCuenCobr;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Error al obtener la factura a la que pertenece la cuenta de cobro ' ||
                            inuCuenCobr;
                UT_Trace.Trace(osbError, pkg_traza.cnuNivelTrzDef);
                RAISE exError;
        END;

        nuPaso := 20;

        nuPaso := 50;

        -- Financia la cuenta de cobro de la venta

        UT_Trace.Trace('antes de LDC_VALIDALEGCERTNUEVAS.FinanciarConceptosFactura',
                       10);

        LDC_VALIDALEGCERTNUEVAS.FinanciarConceptosFactura(INUNUMPRODSFINANC    => 1,
                                                          INUFACTURA           => nuFactura,
                                                          INUPLANID            => inuPlanNuevoDif, -- Plan de financiacion
                                                          INUMETODO            => inuMetCalNuevoDif, -- Metodo de diferido
                                                          INUDIFENUCU          => inuCuotasNuevoDif, -- Numero de cuotas
                                                          ISBDOCUSOPO          => '-', -- Preguntar
                                                          ISBDIFEPROG          => 'LDRSS',
                                                          ONUACUMCUOTA         => NUACUMCUOTA,
                                                          ONUSALDO             => NUSALDO,
                                                          ONUTOTALACUMCAPITAL  => NUTOTALACUMCAPITAL,
                                                          ONUTOTALACUMCUOTEXTR => NUTOTALACUMCUOTEXTR,
                                                          ONUTOTALACUMINTERES  => NUTOTALACUMINTERES,
                                                          OSBREQUIEREVISADO    => SBREQUIEREVISADO,
                                                          ONUDIFECOFI          => NUDIFECOFI);

        nuPaso := 60;

        --    COMMIT;

        UT_Trace.Trace('despues de LDC_VALIDALEGCERTNUEVAS.FinanciarConceptosFactura',
                       10);

        UT_Trace.Trace('Fin Ld_BoSubsidy.proFinanciaCtaCobroVenta', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN OTHERS THEN
            osbError := 'Error Ld_BoSubsidy.proFinanciaCtaCobroVenta. ' ||
                        SQLERRM || '- Paso ' || nuPaso;

    END;

    /*TEAM NC 3424*/
    PROCEDURE RegisterNote(nuServSusc    IN servsusc.sesunuse%TYPE,
                           nucuencobr    IN cuencobr.cucocodi%TYPE,
                           nuConcept     IN concepto.conccodi%TYPE,
                           nuNoteCuase   IN ld_parameter.numeric_value%TYPE,
                           sbDescription IN VARCHAR2,
                           nuValue       ld_item_work_order.value%TYPE) IS

        nuSubsc servsusc.sesususc%TYPE;
        nuNote  notas.notanume%TYPE;

    BEGIN
        UT_Trace.Trace('Inicia LD_BOSUBSIDY.REVERSESUBSIDY.RegisterNote', 5);

        pkErrors.SetApplication('LDRSS');

        nuSubsc := pktblservsusc.fnugetsesususc(nuServSusc);

        --  Crea la nota por el pago inicial
        pkBillingNoteMgr.CreateBillingNote(nuServSusc,
                                           nucuencobr,
                                           GE_BOConstants.fnuGetDocTypeDebNote,
                                           SYSDATE,
                                           sbDescription,
                                           pkBillConst.csbTOKEN_NOTA_DEBITO,
                                           nuNote);

        UT_Trace.Trace('Termino pkBillingNoteMgr.CreateBillingNote', 5);

        -- Crear Detalle Nota Credito
        FA_BOBillingNotes.DetailRegister

        (nuNote,
         nuServSusc,
         nuSubsc,
         nucuencobr,
         nuConcept,
         nuNoteCuase,
         nuValue,
         NULL,
         pkBillConst.csbTOKEN_NOTA_DEBITO || nuNote,
         pkBillConst.DEBITO,
         pkConstante.SI,
         NULL,
         pkConstante.SI);

        UT_Trace.Trace('Termina LD_boflowFNBPack.CreateDelivOrderCharg.RegisterNote',
                       5);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END RegisterNote;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del procedimiento: proNDSubsidio

    Descripcion:          Crea una nota debito. Se extrae este codigo del cuerpo
                          del procedimiento reverseSubsidy

    Parametros entrada:   nuPackage:       Solicitud
                          nuSuscripc:      Contrato
                          nuSesunuse:      Producto
                          nuAppconc:       Concepto a la que se le generara el cargo
                          nuctacob:        Cuenta de cobro en la que se generara el cargo
                          nuFactCause:     Causa Cargo
                          nuchargevalue:   Valor cargo

    Parametros de salida: osbErrorMessage: Mensaje de error

    Autor : Sandra Mu?oz.
    Fecha : ARA8190

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    01-09-2015   Sandra Mu?oz           ARA8190. No se hace uso del procedmiento
                                        RegisterNote porque deja la cuenta de
                                        cobro con saldo a pesar que la suma de
                                        los cargos da 0. Se genera el cargo con
                                        tipo de generacion A para que pueda
                                        pasar a contabilidad
    27-08-2015   Sandra Mu?oz           Creacion. Aranda8190
    ******************************************************************/
    PROCEDURE proNDSubsidio(nuPackage       IN OUT ld_asig_subsidy.package_id%TYPE,
                            nuSuscripc      IN OUT ld_asig_subsidy.susccodi%TYPE,
                            nuSesunuse      IN OUT suscripc.susccodi%TYPE,
                            nuAppconc       IN OUT cargos.cargconc%TYPE,
                            nuctacob        IN OUT cuencobr.cucocodi%TYPE,
                            nuFactCause     IN OUT causcarg.cacacodi%TYPE,
                            nuchargevalue   IN OUT cargos.cargvalo%TYPE,
                            osbErrorMessage OUT VARCHAR2) IS
    BEGIN

        UT_Trace.Trace('Inicio ld_boSubsidy.proNDSubsidio', 5);

        pkerrors.setapplication('LDRSS');

        --NC 1107 SE ADICIONO CODIGO DE CREAR CARGO DEBITO ENVIADO PO LA ING. SANDRA BLANCO.
        /* Crear cargo debito*/
        UT_Trace.Trace('nusesunuse ' || nusesunuse, 5);
        UT_Trace.Trace('nuctacob ' || nuctacob, 5);
        UT_Trace.Trace('nuappconc ' || nuappconc, 5);
        UT_Trace.Trace('nuFactCause ' || nuFactCause, 5);
        UT_Trace.Trace('nuchargevalue ' || nuchargevalue, 5);
        UT_Trace.Trace('pkBillConst.DEBITO ' || pkBillConst.DEBITO, 5);
        UT_Trace.Trace('pkBillConst.csbTOKEN_SOLICITUD - nuPackage ' ||
                       pkBillConst.csbTOKEN_SOLICITUD || '-' || nuPackage,
                       5);

        pkChargeMgr.GenerateCharge(nusesunuse,
                                   nuctacob,
                                   nuappconc,
                                   nuFactCause,
                                   nuchargevalue, --valor del cargo
                                   pkBillConst.DEBITO,
                                   pkBillConst.csbTOKEN_SOLICITUD || '-' ||
                                   nuPackage,
                                   'A',
                                   ld_boconstans.cnuCero_Value,
                                   NULL,
                                   NULL,
                                   NULL,
                                   FALSE,
                                   SYSDATE);

        UPDATE cargos c
        SET    c.cargtipr = 'A'
        WHERE  c.cargcuco = nuctacob
        AND    c.cargdoso = pkBillConst.csbTOKEN_SOLICITUD || '-' || nuPackage;

        /*
         COMENTARIADO POR LA NC 1107 PRO FALTA DE MANEJO DE VALOR CON DECIMALES
         CON EL SERVICIO DE OPEN
         pkChargeMgr.GenerateCharge
         (
             nusesunuse,
                         nuctacob,
             nuappconc,
             nuFactCause,
             pkBillConst.DEBITO,
             pkBillConst.csbTOKEN_SOLICITUD || '-' || nuPackage,
             nuCodDoc,
             sysdate,
             nuchargevalue,
             null
        ) ;
        --*/

        -- Actualiza cartera
        pkUpdAccoReceiv.UpdAccoRec(pkBillConst.cnuSUMA_CARGO,
                                   nuctacob,
                                   nuSuscripc,
                                   nusesunuse,
                                   nuappconc,
                                   pkBillConst.DEBITO,
                                   nuchargevalue);

        IF osbErrorMessage IS NOT NULL THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'ld_boSubsidy.proNDSubsidio - ' ||
                                             osbErrorMessage);
        END IF;

        UT_Trace.Trace('Fin ld_boSubsidy.proNDSubsidio', 5);

    END proNDSubsidio;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Reversesubsidy
     Descripcion    : Reversa los subsidios asignados.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 17/12/2012

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Identificador del registro de la asignacion de subsidio
     InuActReg            Registro actual
     inuTotalReg          Total de registros a procesar
     onuErrorCode         Codigo de error
     osbErrorMessage      Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     15/01/2015       juancr                se modifica para setear de nuevo la aplicacion LDRSS
                                            antes de llamar al metodo <LD_BOSUBSIDY.Procbalancesub>
                                            ya que la que se encuentra instanciada en ese momento
                                            es CUSTOMER y se necesita identificar al momento de
                                            actualizar el registro en ld_subsidy la aplicacion LDRSS
                                            para no realizar validacion sobre las vigencias en el
                                            trigger TRGBIDURLD_SUBSIDYVALIDATE.
     22/11/2014   oscar Restrepo.TEAM3424 Modificacion Para que se cree cargcodo de nota y la nota correspondiente
                                              al momentos de crear los cargos de reversion de subsidios (programa 800),
                                              para esto se cambia el llamado de pkChargeMgr.GenerateCharge
                                              por RegisterNote (Se adiciona el metodo).
    27-08-2015       Sandra Mu?oz          ARA8190
                                            * Se traslada el codigo del procedimiento
                                              de creacion de la nota debito del
                                              subsidio al procedimiento proNDSubsidio
                                            * Antes de realizar el paso a diferido
                                              del cobro del subsidio que deje de
                                              cobrar, se debe realizar un paso de
                                              diferido a corriente de toda la
                                              financiacion de la venta (Instalacion
                                              interna, cargo por conexion, etc),
                                              es decir, cancelar ese diferido. Luego
                                              desde corriente pasar a diferido toda
                                              el valor de la venta que esta en
                                              corriente mas el valor del subsidio
                                              que estoy cobrando.
     04/08/2014       Jorge Valiente        NC 1107 SE ADICIONO CODIGO DE CREAR CARGO DEBITO ENVIADO
                                            POR LA ING. SANDRA BLANCO. PARA EL MANEJO DE NUMEROS DECIMALES
                                            YA QUE EL SERVICIO ORIGINAL DE OPEN NO LO MANEJA.
     24/01/2014       htoroSAO230795        Se modifica para que el cargo de reversion
                                            no sea generado por medio de una nota
                                            de facturacion
     22/01/2014       htoroSAO230487        Se adiciona control de errores individual
                                            por cada procesamiento
                                            Se reversan los cambios asociados a la
                                            creacion de nueva factura para registrar
                                            la reversion
     22-01-2014       eurbano.SAO230391     Se modifica para crear la factura
                                            individualmente.
     18-01-2014       eurbano.SAO229889     Se modifica para que el cargo debito
                                            generado por la reversion del subsidio
                                            no quede como una nota sino en una
                                            cuenta de cobro nueva asociada al
                                            periodo de facturacion actual.
     06-12-2013       AEcheverrySAO226259   Se modifica para que  el documento de soporte (diferido.difenudo)
                                              no sea mayor de 10 caracteres
     27-11-2013       hjgomez.SAO225106     Se eleva error si la cuenta de cobro es nula
     17/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Reversesubsidy(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                             InuActReg          IN NUMBER,
                             inuTotalReg        IN NUMBER,
                             onuErrorCode       OUT NUMBER,
                             osbErrorMessage    OUT VARCHAR2) IS

        --cnuNULL_ATTRIBUTE constant number := 2126;
        sbCAUSAL_ID ge_boInstanceControl.stysbValue;
        boCausal    BOOLEAN := FALSE;
        /*Declaracion de variables*/
        nuSubsidy        ld_asig_subsidy.subsidy_id%TYPE;
        nuSubsidyState   ld_asig_subsidy.state_subsidy%TYPE;
        nuValSubsidyAsig ld_asig_subsidy.subsidy_value%TYPE;
        nuUbication      ld_asig_subsidy.ubication_id%TYPE;
        nuPackage        ld_asig_subsidy.package_id%TYPE;
        nuSuscripc       ld_asig_subsidy.susccodi%TYPE;
        nuSesunuse       suscripc.susccodi%TYPE;
        nuAppconc        cargos.cargconc%TYPE;
        rcUbication      dald_ubication.styld_ubication;
        /*Variables de salida en la generacion de diferidos*/
        nuGeo        ge_geogra_location.geograp_location_id%TYPE;
        sbAdd        ab_address.address%TYPE;
        rcMopackage  damo_packages.styMO_packages;
        nuPackageDif mo_packages.package_id%TYPE;
        nuCoupon     cupon.cuponume%TYPE;
        nuError      NUMBER := 0;
        sbMessage    VARCHAR2(2000);
        /*Variable tipo registro*/
        styCcSales_Financ_Cond DACC_SALES_FINANC_COND.styCC_sales_financ_cond;
        nuswfinanciacion       NUMBER;
        sbtypesub              ld_asig_subsidy.type_subsidy%TYPE;
        nuctacob               cuencobr.cucocodi%TYPE;
        nuCodDoc               cargos.cargcodo%TYPE;
        nuDocTypeId            ge_document_type.document_type_id%TYPE;
        nufactura              cuencobr.cucofact%TYPE;
        nuFactCause            causcarg.cacacodi%TYPE;
        nuchargevalue          cargos.cargvalo%TYPE;
        sbdeliverdoc           ld_asig_subsidy.delivery_doc%TYPE;

        nuGracePeriod  cc_grace_period.grace_period_id%TYPE;
        nuMinGraceDays cc_grace_period.min_grace_days%TYPE;

        -- Ara8190
        nuFinanciacionVenta  diferido.difecofi%TYPE; -- Numero de financiacion de la venta
        nuNuevaCuentaCobro   cuencobr.cucocodi%TYPE; -- Cuenta de cobro a donde se envia el diferido
        nuCuotasPendDifVenta diferido.difenucu%TYPE; -- Numero de cuotas pendientes del diferido de venta
        nuPlanDifVenta       diferido.difepldi%TYPE; -- Plan de diferido del diferido de venta
        nuMetCalDifVenta     diferido.difemeca%TYPE; -- Metodo de calculo del diferido de venta

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.reversesubsidy', pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('

        inuAsig_Subsidy_Id ' || inuAsig_Subsidy_Id || '
        InuActReg    ' || InuActReg ||
                       '
        inuTotalReg  ' || inuTotalReg ||

                       ')',
                       10);
        sbCAUSAL_ID := ge_boInstanceControl.fsbGetFieldValue('LD_CAUSAL',
                                                             'CAUSAL_ID');

        IF (sbCAUSAL_ID IS NULL) THEN
            boCausal := TRUE;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El campo causal de reversion, no debe ser nulo.');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Obtener datos del registro seleccionado desde la grilla, verificar y reversar el subsidio.*/
        nuSubsidyState   := DAld_asig_subsidy.fnuGetState_Subsidy(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuValSubsidyAsig := Dald_Asig_Subsidy.fnuGetSubsidy_Value(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuSubsidy        := Dald_Asig_Subsidy.fnuGetSubsidy_Id(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuUbication      := Dald_Asig_Subsidy.fnuGetUbication_Id(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuSuscripc       := Dald_Asig_Subsidy.fnuGetSusccodi(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuPackage        := Dald_Asig_Subsidy.fnuGetPackage_Id(inuasig_subsidy_Id => inuAsig_Subsidy_Id);

        UT_Trace.Trace('Estado Subsidio ' || nuSubsidyState, 5);
        UT_Trace.Trace('Valor Subsidio Asignado ' || nuValSubsidyAsig, 5);
        UT_Trace.Trace('Subsidio ' || nuSubsidy, 5);
        UT_Trace.Trace('Ubicacion ' || nuUbication, 5);
        UT_Trace.Trace('Contrato ' || nuSuscripc, 5);

        /*Determinar si la asignacion del subsidio fue para venta por formulario o
        por retroactivo*/
        sbtypesub := dald_asig_subsidy.fsbGetType_Subsidy(inuAsig_Subsidy_Id,
                                                          NULL);
        UT_Trace.Trace('Tipo de Subsidio ' || sbtypesub, 5);

        sbdeliverdoc := dald_asig_subsidy.fsbGetDelivery_Doc(inuAsig_Subsidy_Id,
                                                             NULL);

        /*Si el tipo de subsidio fue por retroactivo y la
        documentacion esta entregada no se lleva a cabo el
        proceso de reversion*/
        IF sbtypesub = ld_boconstans.csbretroactivesale AND
           sbdeliverdoc = ld_boconstans.csbapackagedocok THEN

            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se puede reversar el proceso para un subsidio retroactivo que cuenta con la documentacion entregada');

        END IF;

        /*Si el tipo de subsidio fue por venta por formulario*/
        IF sbtypesub = ld_boconstans.csbGASSale THEN

            /*Obtener el Servicio Suscrito del Beneficiario*/
            nuSesunuse := ld_bcsubsidy.Fnugetsesunuse(nuPackage, NULL);

            IF (nuSesunuse IS NULL) THEN
                osbErrorMessage := 'Error reversando subsidio. El usuario [ ' ||
                                   nuSuscripc ||
                                   ' ] no tiene servicio suscrito activo';

                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 osbErrorMessage);
            END IF;

            /*Obtener el concepto*/
            nuAppconc := dald_subsidy.fnuGetConccodi(inuSUBSIDY_Id => nuSubsidy);

            IF (nuAppconc IS NULL) THEN
                osbErrorMessage := 'Error obteniendo el concepto de aplicacion del subsidio ' ||
                                   nuSubsidy;

                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 osbErrorMessage);

            END IF;

            /*Obtener la cta de cobro donde se financio el cargo credito
            por el concepto de aplicacion del subsidio que se
            genero durante la venta por formulacirio*/

            nuctacob := Ld_Bcsubsidy.Fnugetctacobbysub(nuSesunuse,
                                                       nuAppconc,
                                                       NULL);
            IF (nuctacob IS NULL) THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No existen cuentas de cobro asociadas al concepto: ' ||
                                                 nuAppconc);
            END IF;

            nuswfinanciacion := 0;

            /*Definir si la venta tuvo financiacion*/
            BEGIN
                /*Conocer las condiciones de financiacion*/
                dacc_sales_financ_cond.getRecord(nuPackage,
                                                 styCcSales_Financ_Cond);
            EXCEPTION
                WHEN OTHERS THEN
                    nuswfinanciacion := 1;
            END;

            IF (nuctacob IS NOT NULL) THEN

                /*Obtener el codigo del tipo de documento*/
                nuDocTypeId := DALD_PARAMETER.fnuGetNumeric_Value('DOC_DEBIT_TYPE_ID');

                IF nuDocTypeId IS NULL THEN
                    osbErrorMessage := 'Error obteniendo el tipo de documento';
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     osbErrorMessage);
                END IF;

                /*Obtener el codigo de Causal nota de facturacion*/
                nuFactCause := LD_BOConstans.cnusubchargecause;

                IF nuFactCause IS NULL THEN
                    osbErrorMessage := 'Error obteniendo la causa del cargo';
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     osbErrorMessage);
                END IF;

                /*El valor del cargo sera el valor del subsidio*/
                nuchargevalue := dald_asig_subsidy.fnuGetSubsidy_Value(inuAsig_Subsidy_Id,
                                                                       NULL);

                /*Obtener la factura de la cuenta de cobro*/
                nufactura := pktblcuencobr.fnuGetCUCOFACT(nuctacob, NULL);

                IF (nufactura IS NULL) THEN
                    osbErrorMessage := 'No se encontro factura asociada a la cuenta de cobro ' ||
                                       nufactura;
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     osbErrorMessage);
                END IF;

                nuCodDoc := pkGeneralServices.fnugetnextsequenceval('SQ_CARGOS_CARGCODO');

                /*Obtener datos de la solicitud de venta*/
                damo_packages.getRecord(nuPackage, rcMopackage);

                /*Obtener la ubicacion geografica de la direccion*/
                nuGeo := daab_address.fnuGetGeograp_Location_Id(damo_packages.fnugetaddress_id(nuPackage,
                                                                                               NULL),
                                                                NULL);

                /*Obtener direccion completa de la solicitud de venta. Ejemplo: KR 5 # 88 - 10*/
                sbAdd := daab_address.fsbGetAddress(damo_packages.fnugetaddress_id(nuPackage,
                                                                                   NULL),
                                                    NULL);

                -- se obtiene el periodo de gracia
                nuGracePeriod := pktblPLANDIFE.fnugetpldipegr(styCcSales_Financ_Cond.financing_plan_id);

                IF (nuGracePeriod IS NOT NULL) THEN
                    -- se obtienen los dias de gracia
                    nuMinGraceDays := daCC_GRACE_PERIOD.fnugetmin_grace_days(nuGracePeriod);
                END IF;

                /*Si tuvo financiacion se crea el diferido*/
                IF nuswfinanciacion = 0 THEN
                    -- ARA8190. Antes de realizar el paso a diferido del cobro
                    -- del subsidio que deje de cobrar, se debe realizar un paso de
                    -- diferido a corriente de toda la financiacion de la venta
                    -- (Instalacion interna, cargo por conexion, etc), es decir,
                    -- cancelar ese diferido. Luego desde corriente pasar a
                    -- diferido toda el valor de la venta que esta en Corriente
                    -- mas el valor del subsidio que estoy cobrando.

                    UT_Trace.Trace('Se llam el procedimiento proDifACteVenta

                     proDifACteVenta(inucucosubidio      => ' ||
                                   nuCtaCob || ',
                                    inuconcsubsidio      => ' ||
                                   nuAppConc || ',
                                    inupackage_id        => ' ||
                                   nuPackage || ',
                                    inusubsidioaplicado  => ' ||
                                   nuSubsidy || ',
                                    onuFinanciacionVenta => ' ||
                                   nuFinanciacionVenta || ',
                                    onuCuentaCobro       => ' ||
                                   nuNuevaCuentaCobro || ',
                                    onuCuotasPendientes  => ' ||
                                   nuCuotasPendDifVenta || ',
                                    onuPlanDiferido      => ' ||
                                   nuPlanDifVenta || ',
                                    onuMetCalculo        => ' ||
                                   nuMetCalDifVenta || ',
                                    osberror             => ' ||
                                   osbErrorMessage || ');
                    ',
                                   10);

                    proDifACteVenta(inucucosubidio       => nuCtaCob,
                                    inuconcsubsidio      => nuAppConc,
                                    inupackage_id        => nuPackage,
                                    inusubsidioaplicado  => nuSubsidy,
                                    onuFinanciacionVenta => nuFinanciacionVenta,
                                    onuCuentaCobro       => nuNuevaCuentaCobro,
                                    onuCuotasPendientes  => nuCuotasPendDifVenta,
                                    onuPlanDiferido      => nuPlanDifVenta,
                                    onuMetCalculo        => nuMetCalDifVenta,
                                    osberror             => osbErrorMessage);

                    IF osbErrorMessage IS NOT NULL THEN
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                         osbErrorMessage);
                    END IF;

                    UT_Trace.Trace('Se llama al procedimiento proNDSubsidio


                    proNDSubsidio(nuPackage,              ' ||
                                   nuPackage || ',
                                  nuSuscripc,             ' ||
                                   nuSuscripc || ',
                                  nuSesunuse,             ' ||
                                   nuSesunuse || ',
                                  nuAppconc,              ' ||
                                   nuAppconc || ',
                                  nuNuevaCuentaCobro,     ' ||
                                   nuNuevaCuentaCobro || ',
                                  nuFactCause,            ' ||
                                   nuFactCause || ',
                                  nuchargevalue,          ' ||
                                   nuchargevalue || ',
                                  osbErrorMessage);       ' ||
                                   osbErrorMessage || ');





                    ',
                                   10);

                    /* proNDSubsidio(nuPackage,
                    nuSuscripc,
                    nuSesunuse,
                    nuAppconc,
                    nuNuevaCuentaCobro,
                    nuFactCause,
                    nuchargevalue,
                    osbErrorMessage);*/

                    /*
                    TEAM NC 3424 : Cuando se crean cargos de Reversion de subsidios en OSF con el programa 800,
                    no se esta comportando como nota, razon por la cual en el cargcodo no deja un consecutivo valido,
                    se debe realizar la modificacion del programa que genera estos cargos*/
                    RegisterNote(nusesunuse,
                                 nuNuevaCuentaCobro,
                                 nuappconc,
                                 nuFactCause,
                                 'Nota Reversion Subsidios pkBillConst.csbTOKEN_SOLICITUD[' ||
                                 nuPackage || ']',
                                 nuchargevalue);

                    UT_Trace.Trace('Se llama al procedimiento proFinanciaCtaCobroVenta',
                                   10);

                    proFinanciaCtaCobroVenta(inuCuenCobr        => nuNuevaCuentaCobro,
                                             inuNroFinanciacion => nuFinanciacionVenta,
                                             inuCuotasNuevoDif  => nuCuotasPendDifVenta,
                                             inuPlanNuevoDif    => nuPlanDifVenta,
                                             inuMetCalNuevoDif  => nuMetCalDifVenta,
                                             osbError           => osbErrorMessage);

                    IF osbErrorMessage IS NOT NULL THEN
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                         osbErrorMessage);
                    END IF;

                    UT_Trace.Trace('Despues de proFinanciaCtaCobroVenta', pkg_traza.cnuNivelTrzDef);

                ELSE

                    -- ARA8190. Se crea la nota debito para el subsidio en la
                    -- cuenta de cobro original si no se financio la venta

                    /*Crear nota debito*/

                    /* proNDSubsidio(nuPackage,
                    nuSuscripc,
                    nuSesunuse,
                    nuAppconc,
                    nuctacob,
                    nuFactCause,
                    nuchargevalue,
                    osbErrorMessage);*/

                    /*
                    TEAM NC 3424 : Cuando se crean cargos de Reversion de subsidios en OSF con el programa 800,
                    no se esta comportando como nota, razon por la cual en el cargcodo no deja un consecutivo valido,
                    se debe realizar la modificacion del programa que genera estos cargos*/
                    RegisterNote(nusesunuse,
                                 nuNuevaCuentaCobro,
                                 nuappconc,
                                 nuFactCause,
                                 'Nota Reversion Subsidios pkBillConst.csbTOKEN_SOLICITUD[' ||
                                 nuPackage || ']',
                                 nuchargevalue);

                    gw_boerrors.checkerror(nuerror, sbmessage);

                END IF; /*FINALIZA EL TEMA DE CREAR DIFERIDO*/
            END IF; /*FIN SI TIENE CUENTA DE COBRO*/
        END IF;

        /*Obtener la variable de registro de la ubicacion geografica.*/
        /*Obtener datos de la poblacion*/
        DALD_ubication.LockByPkForUpdate(nuUbication, rcUbication);

        /*Setear la variable que me indicara en el trigger trgaiduld_subsidyvalidate
         si se debe hacer la validacion de sumatoria de valores por los
         conceptos parametrizados por porcentaje
        */
        globalasigsub := 'S';

        --15012015 JuanCR [ARA 5917]: se adicionna el proceso LDRSS para que sea instaciado
        pkerrors.setapplication('LDRSS');

        /*Reversar los valores del subsidio*/
        LD_BOSUBSIDY.Procbalancesub(nuSubsidy,
                                    rcUbication,
                                    nuValSubsidyAsig,
                                    ld_boconstans.cnutwonumber);

        /*Se devuelve al subsidio el valor que se le habia quitado y
        se registra el movimiento de reversion*/
        RegisterReversesubsidy(inuAsig_Subsidy_Id, sbCAUSAL_ID);

        <<error>>
        NULL;

        UT_Trace.Trace('Fin Ld_BoSubsidy.reversesubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            IF boCausal THEN
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                errors.getError(onuErrorCode, osbErrorMessage);
            END IF;
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.setError;
            IF boCausal THEN
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                errors.getError(onuErrorCode, osbErrorMessage);
            END IF;
    END Reversesubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Penalize
     Descripcion    : Multa a los contratistas que tienen ordenes
                      de documentacion pendientes por legalizar

     Autor          : Jonathan alberto consuegra
     Fecha          : 23/12/2012

     Parametros           Descripcion
     ============         ===================


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     23/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Penalize IS

        CURSOR cuPenalty IS
            SELECT o.created_date,
                   o.order_id orden,
                   'S' id
            FROM   or_order o
            WHERE  EXISTS (SELECT 1
                    FROM   ld_asig_subsidy l
                    WHERE  l.delivery_doc = ld_boconstans.csbNOFlag
                    AND    l.order_id = o.order_id)
            AND    o.legalization_date IS NULL

            UNION
            SELECT b.created_date,
                   b.order_id orden,
                   'N' id
            FROM   or_order b
            WHERE  EXISTS (SELECT 1
                    FROM   ld_sales_withoutsubsidy a
                    WHERE  a.delivery_doc = ld_boconstans.csbNOFlag
                    AND    a.order_id = b.order_id)
            AND    b.legalization_date IS NULL;

        rgcupenalty       cuPenalty%ROWTYPE;
        nuDays            NUMBER;
        nuOrderId         or_order.order_id%TYPE;
        nuOperatingUnitId or_order.operating_unit_id%TYPE;
        nuContractorID    or_operating_unit.contractor_id%TYPE;
        nuOrderId_Out     or_order.order_id%TYPE;
        nusw              NUMBER := ld_boconstans.cnuCero_Value;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Penalize', pkg_traza.cnuNivelTrzDef);

        /*Validar constante ld_boconstans.csbNOFlag*/
        IF ld_boconstans.csbNOFlag IS NULL THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'La constante csbNOFlag del paquete ld_boconstans es nula');
            RAISE pkg_error.CONTROLLED_ERROR;
        ELSIF ld_boconstans.csbNOFlag <> 'N' THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'La constante csbNOFlag del paquete ld_boconstans posee un valor diferente a N');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar contenido de la constante ld_boconstans.cnuUbication_to_penalize*/
        IF ld_boconstans.cnuUbication_to_penalize IS NULL THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'El valor del parametro UBICATION_TO_PENALIZE es nulo');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar constante ld_boconstans.csbNOFlag*/
        IF ld_boconstans.csbokFlag IS NULL THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'La constante csbokFlag del paquete ld_boconstans es nula');
            RAISE pkg_error.CONTROLLED_ERROR;
        ELSIF ld_boconstans.csbokFlag <> 'S' THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'La constante csbokFlag del paquete ld_boconstans posee un valor diferente a S');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar contenido de la constante ld_boconstans.cnudaystofine*/
        IF ld_boconstans.cnudaystofine IS NULL THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'El valor del parametro DAYS_TO_FINE es nulo');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar contenido de la constante ld_boconstans.cnuDays_penalize_sale_no_sub*/
        IF ld_boconstans.cnuDays_penalize_sale_no_sub IS NULL THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'El valor del parametro DAYS_PENALIZE_SALE_NO_SUBSIDY es nulo');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar contenido de la constante ld_boconstans.cnupenalize_activity*/
        IF ld_boconstans.cnupenalize_activity IS NULL THEN
            Errors.SetError(ld_boconstans.cnuGeneric_Error,
                            'El valor del parametro PENALIZE_ACTIVITY es nulo');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        OPEN cuPenalty;
        LOOP
            FETCH cuPenalty
                INTO rgcupenalty;
            EXIT WHEN cuPenalty%NOTFOUND;

            nuDays := ld_bosubsidy.fnuGetDaysAble(inucountry => ld_boconstans.cnuUbication_to_penalize,
                                                  idtIni     => rgcupenalty.created_date,
                                                  idtFin     => SYSDATE);

            nusw := ld_boconstans.cnuCero_Value;

            IF rgcupenalty.id = ld_boconstans.csbokFlag THEN
                IF nuDays >= ld_boconstans.cnudaystofine THEN
                    nusw := ld_boconstans.cnuonenumber;
                END IF;
            END IF;

            IF rgcupenalty.id = ld_boconstans.csbNOFlag THEN
                IF nuDays >= ld_boconstans.cnuDays_penalize_sale_no_sub THEN
                    nusw := ld_boconstans.cnuonenumber;
                END IF;
            END IF;

            IF nusw = ld_boconstans.cnuonenumber THEN

                nuOperatingUnitId := NULL;
                nuContractorID    := NULL;
                nuOrderId         := rgcupenalty.orden;

                IF nuOrderId IS NULL THEN
                    GOTO datos;
                END IF;

                nuOperatingUnitId := daor_order.fnuGetOperating_Unit_Id(nuOrderId,
                                                                        NULL);
                IF nuOperatingUnitId IS NULL THEN
                    GOTO datos;
                END IF;

                nuContractorID := daor_operating_unit.fnuGetContractor_Id(nuOperatingUnitId,
                                                                          NULL);

                IF nuContractorID IS NULL THEN
                    GOTO datos;
                END IF;

                ct_bonovelty.createnovelty(inucontractor => nuContractorID,
                                           inuoperunit   => nuOperatingUnitId,
                                           inuitem       => ld_boconstans.cnupenalize_activity,
                                           inutecunit    => NULL,
                                           inuorderid    => nuOrderId,
                                           inuvalue      => NULL,
                                           inuamount     => NULL,
                                           inuuserid     => NULL,
                                           inucommentype => NULL,
                                           isbcomment    => NULL,
                                           onuorder      => nuOrderId_Out);

            END IF;
            <<datos>>

            NULL;
        END LOOP;

        CLOSE cuPenalty;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Penalize', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Penalize;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FBLAssigRetrosubByArchive
     Descripcion    : Aplica el subsidio retroactivo al contrato

     Autor          : Jorge Luis Valiente
     Fecha          : 04/01/2013

     Parametros           Descripcion
     ============         ===================
     isbLineFile          Linea de archivo plano
     inuCurrent           Posicion del registro en el archivo plano
     inuTotal             Total de registro definidos en el archivo plano
     osbErrorMessage      Mensaje del posible error de salida

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
    ******************************************************************/
    FUNCTION FBLAssigRetrosubByArchive(isbLineFile     IN VARCHAR2,
                                       inuCurrent      IN NUMBER,
                                       inuTotal        IN NUMBER,
                                       osbErrorMessage OUT VARCHAR2) RETURN BOOLEAN IS

        --nuErrorCode number;

        nupackage_id   mo_packages.package_id%TYPE;
        onuErrorCode   NUMBER;
        arString       ld_boconstans.tbarray;
        nuAmount       NUMBER;
        nuSusCripc     suscripc.susccodi%TYPE;
        nucategori     SUBCATEG.Sucacate%TYPE;
        nusubcateg     SUBCATEG.Sucacodi%TYPE;
        nulocation     GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE;
        nuSubsidy      ld_subsidy.subsidy_id%TYPE;
        nupromotion    cc_promotion.promotion_id%TYPE;
        nuubication_id ld_ubication.ubication_id%TYPE;
        nusubscriber   ge_subscriber.subscriber_id%TYPE;
        nuCodCateg     SUBCATEG.Sucacate%TYPE;
        nuCodSubCat    SUBCATEG.Sucacodi%TYPE;
        nuCodLocation  GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE;

        oclFileContent CLOB;
        nuuserwithsub  NUMBER;
        nuvalidate     NUMBER;
        nuswerror      NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.FBLAssigRetrosubByArchive', pkg_traza.cnuNivelTrzDef);

        nuswerror := ld_boconstans.cnuCero_Value;
        nuAmount  := ld_bosubsidy.FsbGetAmount(isbLineFile,
                                               ld_boconstans.csbPipe);

        IF nuAmount <> -1 OR nuAmount <> 0 THEN
            arString := ld_bosubsidy.FsbGetArray(nuAmount,
                                                 isbLineFile,
                                                 ld_boconstans.csbPipe);

            /*Obtener el subsidio a asignar*/
            nuSubsidy := to_number(arString(1));
            /*Obtener el contrato*/
            nuSusCripc := to_number(arString(2));
            /*Obtener la ubicacion geografica del contrato*/
            nulocation := to_number(arString(3));
            /*Obtener categoria del contrato*/
            nucategori := to_number(arString(4));
            /*Obtener subcategoria del contrato*/
            nusubcateg := to_number(arString(5));
            /*Obtener la solicitud de venta*/
            nupackage_id := to_number(arString(6));
            /*setear variable*/
            nuuserwithsub := ld_boconstans.cnuCero_Value;
            /*Validar subsidio*/
            IF nvl(nuSubsidy, 0) = 0 THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'El codigo del subsidio no debe ser nulo';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
                --
            ELSE
                /*Validar que el subsidio exista*/
                IF NOT dald_subsidy.fblExist(nuSubsidy) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'El codigo del subsidio no existe';
                    ROLLBACK;
                    --
                    nuswerror := ld_boconstans.cnuonenumber;

                    IF inuCurrent = inuTotal THEN
                        UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                        GOTO fin;
                    ELSE
                        GOTO salto;
                    END IF;
                    --return(false);
                END IF;
            END IF;

            /*Validar suscripcion*/
            IF nvl(nuSusCripc, 0) = 0 THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'El contrato no debe ser nulo';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            ELSE
                /*Validar si el contrato existe*/
                IF NOT pktblsuscripc.fblexist(nuSusCripc) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'El contrato no existe';
                    ROLLBACK;
                    --
                    nuswerror := ld_boconstans.cnuonenumber;

                    IF inuCurrent = inuTotal THEN
                        UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                        GOTO fin;
                    ELSE
                        GOTO salto;
                    END IF;
                    --return(false);
                END IF;
            END IF;

            /*Validar ubicacion geografica*/
            IF nvl(nulocation, 0) = 0 THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La ubicacion geografica del contrato no debe ser nulo';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            ELSE
                IF NOT dage_geogra_location.fblexist(nulocation) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La ubicacion geografica no existe';
                    ROLLBACK;
                    --
                    nuswerror := ld_boconstans.cnuonenumber;

                    IF inuCurrent = inuTotal THEN
                        UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                        GOTO fin;
                    ELSE
                        GOTO salto;
                    END IF;
                    --return(false);
                END IF;
            END IF;

            /*Validar categoria*/
            IF nvl(nucategori, 0) = 0 THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La categoria no debe ser nulo';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            ELSE
                IF NOT dacategori.fblexist(nucategori) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La categoria no existe';
                    ROLLBACK;
                    --
                    nuswerror := ld_boconstans.cnuonenumber;

                    IF inuCurrent = inuTotal THEN
                        UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                        GOTO fin;
                    ELSE
                        GOTO salto;
                    END IF;
                    --return(false);
                END IF;
            END IF;

            /*Validar subcategoria*/
            IF nvl(nusubcateg, 0) = 0 THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La subcategoria del contrato no debe ser nulo';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            ELSE
                IF NOT dasubcateg.fblexist(nucategori, nusubcateg) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La subcategoria no existe';
                    ROLLBACK;
                    --
                    nuswerror := ld_boconstans.cnuonenumber;

                    IF inuCurrent = inuTotal THEN
                        UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                        GOTO fin;
                    ELSE
                        GOTO salto;
                    END IF;
                    --return(false);
                END IF;
            END IF;

            /*Validar la solicitud de venta*/
            IF nvl(nupackage_id, 0) = 0 THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La solicitud de venta no debe ser nula';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            ELSE
                IF NOT damo_packages.fblexist(nupackage_id) THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'La solicitud no existe';
                    ROLLBACK;
                    --
                    nuswerror := ld_boconstans.cnuonenumber;

                    IF inuCurrent = inuTotal THEN
                        UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                        GOTO fin;
                    ELSE
                        GOTO salto;
                    END IF;
                    --return(false);
                END IF;
            END IF;

            /*Validar que la solicitud esta asociada al suscriptor*/
            nuvalidate := ld_bcsubsidy.Fnupackagesbyuser(nupackage_id,
                                                         nuSusCripc);

            IF nuvalidate = ld_boconstans.cnuCero_Value THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La solicitud no esta asociada al suscriptor';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            END IF;

            /*Validar si el subsidio a otorgar le corresponde a la persona*/
            nuubication_id := Ld_Bosubsidy.Fnugetsomeoneubication(nuSubsidy,
                                                                  nulocation,
                                                                  nucategori,
                                                                  nusubcateg);

            nuCodCateg    := Ld_Bosubsidy.fnugetcategorybypackages(nupackage_id);
            nuCodSubCat   := Ld_Bosubsidy.fnugetsubcategbypackages(nupackage_id);
            nuCodLocation := Daab_Address.fnuGetGeograp_Location_Id(damo_packages.fnugetaddress_id(nupackage_id));

            IF nuCodLocation != nulocation THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La ubicacion geografica ingresada en el archivo, no es igual a la ubicacion geografica de la solicitud';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            END IF;

            IF nuCodCateg != nucategori THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La categoria ingresada en el archivo, no es igual a la categoria de la solicitud';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            END IF;

            IF nuCodSubCat != nusubcateg THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La subcategoria ingresada en el archivo, no es igual a la subcategoria de la solicitud';
                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            END IF;

            IF nuubication_id IS NOT NULL THEN

                /*Obtener la promocion del subsidio*/
                nupromotion := dald_subsidy.fnuGetPromotion_Id(nuSubsidy, NULL);

                /*Obtener cliente*/
                nusubscriber := pktblsuscripc.fnugetsuscclie(nuSusCripc);

                BEGIN

                    nuuserwithsub := Ld_Bcsubsidy.Fnuuserwithsubsamedeal(dald_subsidy.fnuGetDeal_Id(nuSubsidy,
                                                                                                    NULL),
                                                                         nuSusCripc);

                    IF nuuserwithsub > ld_boconstans.cnucero_value THEN

                        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'El cliente ' || nusubscriber ||
                                           ' ya posee un subsidio asociado al convenio: ' ||
                                           dald_subsidy.fnuGetDeal_Id(ld_bcsubsidy.Fnugetpromsubsidy(nupromotion,
                                                                                                     NULL),
                                                                      NULL) ||
                                           ' - ' ||
                                           dald_deal.fsbGetDescription(dald_subsidy.fnuGetDeal_Id(ld_bcsubsidy.Fnugetpromsubsidy(nupromotion,
                                                                                                                                 NULL),
                                                                                                  NULL),
                                                                       NULL);

                        ROLLBACK;
                        --
                        nuswerror := ld_boconstans.cnuonenumber;

                        IF inuCurrent = inuTotal THEN
                            UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                            GOTO fin;
                        ELSE
                            GOTO salto;
                        END IF;
                        --return(false);

                    ELSE

                        /*Setear variables*/
                        globalsuscripc := NULL;

                        nuubiasigsub := NULL;

                        /*Obtener la suscripcion que viene por el archivo*/
                        globalsuscripc := nuSusCripc;

                        /*Obtener la ubicacion del subsidio a asignar*/
                        nuubiasigsub := nuubication_id;

                        /*Asignar subsidios retroactivos*/
                        Ld_Bosubsidy.Assignsubsidy(nusubscriber,
                                                   nupromotion,
                                                   nulocation,
                                                   nucategori,
                                                   nusubcateg,
                                                   ld_boconstans.csbretroactivesale,
                                                   nupackage_id);

                        IF globalerrormens IS NOT NULL THEN
                            osbErrorMessage := globalerrormens;
                            ROLLBACK;
                            --
                            nuswerror := ld_boconstans.cnuonenumber;

                            IF inuCurrent = inuTotal THEN
                                UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                                GOTO fin;
                            ELSE
                                GOTO salto;
                            END IF;
                            --return(false);
                        ELSE

                            COMMIT;

                            /*Limpiar variable que acumula los clobs*/
                            IF inuCurrent = ld_boconstans.cnuonenumber THEN
                                UT_Trace.Trace('blanquea globalclRetroSubsidy',
                                               10);
                                globalclRetroSubsidy := NULL;
                            END IF;

                            /*Colocar en memoria el codigo de la solicitud procesada*/
                            globalnupackage_id := nupackage_id;

                            /*Capturar la ubicacion geografica del subsidio a otorgar*/
                            globalubication := nuubication_id;

                            /*Capturar la ubicacion geografica del cliente*/
                            globallocation := nulocation;

                            /*Capturar la categoria del cliente*/
                            globalcategory := nucategori;

                            /*Capturar la subcategoria del cliente*/
                            globalsubcategory := nusubcateg;

                            UT_Trace.Trace('globalretrosubvalue = ' ||
                                           globalretrosubvalue,
                                           10);

                            UT_Trace.Trace('antes de Fnusetdatainmemory', pkg_traza.cnuNivelTrzDef);

                            oclFileContent := Ld_Bosubsidy.Fnusetdatainmemory(ld_boconstans.cnuExtract_Retroactive);

                            UT_Trace.Trace('despues de Fnusetdatainmemory', pkg_traza.cnuNivelTrzDef);

                            /*Acumular los clobs de los usuarios a generar carta de asignacion retroactiva*/
                            IF globalclRetroSubsidy IS NULL THEN
                                globalclRetroSubsidy := oclFileContent;
                            ELSIF (oclFileContent IS NULL) THEN
                                UT_Trace.Trace('CLOB VACIO # =' || inuCurrent,
                                               15);
                            ELSE
                                dbms_lob.append(globalclRetroSubsidy,
                                                oclFileContent);
                            END IF;

                            osbErrorMessage := 'El subsidio retroactivo aplicado al contrato [' ||
                                               nuSusCripc ||
                                               '] fue realizado de forma exitosa';

                            IF inuCurrent = inuTotal THEN
                                GOTO fin;
                            ELSE
                                GOTO salto;
                            END IF;

                        END IF;
                    END IF;
                EXCEPTION
                    WHEN OTHERS THEN
                        errors.GetError(onuErrorCode, osbErrorMessage);
                        ROLLBACK;
                        RETURN(FALSE);
                END;
            ELSE
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'El subsidio: ' || nuSubsidy ||
                                   ', no le corresponde al cliente: ' ||
                                   nusubscriber;

                ROLLBACK;
                --
                nuswerror := ld_boconstans.cnuonenumber;

                IF inuCurrent = inuTotal THEN
                    UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                    GOTO fin;
                ELSE
                    GOTO salto;
                END IF;
                --return(false);
            END IF;

        ELSE
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'La linea del archivo tiene errores.';
            ROLLBACK;
            --
            nuswerror := ld_boconstans.cnuonenumber;

            IF inuCurrent = inuTotal THEN
                UT_Trace.Trace('etiqueta fin', pkg_traza.cnuNivelTrzDef);
                GOTO fin;
            ELSE
                GOTO salto;
            END IF;
            --return(false);
        END IF;

        UT_Trace.Trace('inuCurrent = ' || inuCurrent, 15);

        UT_Trace.Trace('inuTotal = ' || inuTotal, 15);

        nuswerror := ld_boconstans.cnuonenumber;

        <<fin>>
        UT_Trace.Trace('antes de ultimo if', 15);
        UT_Trace.Trace('1 inuCurrent = ' || inuCurrent || ' - inuTotal = ' ||
                       inuTotal,
                       10);
        /*valida cuan sea el ultimo registro del atrchivo plano*/
        IF inuCurrent = inuTotal AND globalclRetroSubsidy IS NOT NULL THEN
            UT_Trace.Trace('ingreso ultimo if', pkg_traza.cnuNivelTrzDef);

            /*Captura el contenido de todos los clob*/
            globalclSubsidy := globalclRetroSubsidy;

            UT_Trace.Trace('AEP_READCLOB RETRO =' ||
                           ut_lob.getvarchar2(globalclSubsidy),
                           15);

            /*Obtener la plantilla*/
            ld_bosubsidy.globalsbTemplate := Ld_Bosubsidy.Fsbgettemplate(ld_boconstans.cnuExtract_Retroactive);

            UT_Trace.Trace('FBLAssigRetrosubByArchive ld_bosubsidy.globalsbTemplate = ' ||
                           ld_bosubsidy.globalsbTemplate,
                           10);
            /*Llamar a la forma que se encarga de ejecutar el proceso de extraccion y mezcla*/
            Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbRetro_letter_application);

        END IF;

        <<salto>>

        IF nuswerror = 0 THEN
            UT_Trace.Trace('Fin Ld_BoSubsidy.FBLAssigRetrosubByArchive', pkg_traza.cnuNivelTrzDef);
            RETURN(TRUE);
        ELSE
            UT_Trace.Trace('Fin Ld_BoSubsidy.FBLAssigRetrosubByArchive', pkg_traza.cnuNivelTrzDef);
            RETURN(FALSE);
        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            --onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'SE PRESENTO UN ERROR AL MOMENTO DE ASIGNAR UN SUBSIDIO RETROACTIVO AL CLIENTE  ' ||
                               nusubscriber;
            RETURN(FALSE);
        WHEN OTHERS THEN
            ROLLBACK;
            --onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'SE PRESENTO UN ERROR AL MOMENTO DE ASIGNAR UN SUBSIDIO RETROACTIVO AL CLIENTE  ' ||
                               nusubscriber;
            RETURN(FALSE);
    END FBLAssigRetrosubByArchive;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Removeretrosubsidy
     Descripcion    : Reversa los subsidios retroactivos asignados
                      si transcurren n cantidad de dias y no se ha
                      legalizado como exitosa la orden de entrega
                      de documentacion.

     Autor          : Jonathan alberto consuegra
     Fecha          : 11/01/2013

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Id de registro de la asignacion de subsidio
     onuErrorCode         Codigo de error
     osbErrorMessage      Mensaje de rrror

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     11/01/2013       jconsuegra.SAO156577     Creacion
    ******************************************************************/
    PROCEDURE Removeretrosubsidy IS

        CURSOR cuRetrowitoutdoc IS
            SELECT a.*,
                   daor_order.fdtGetCreated_Date(a.order_id, NULL) Created_Date
            FROM   ld_asig_subsidy a
            WHERE  a.delivery_doc = ld_boconstans.csbNOFlag
            AND    a.type_subsidy = ld_boconstans.csbretroactivesale
            AND    daor_order.fdtGetLegalization_Date(a.order_id, NULL) IS NULL
            AND    daor_order.fnuGetOrder_Status_Id(a.order_id, NULL) <>
                   or_boconstants.cnuORDER_STAT_CLOSED;

        rgcuRetrowitoutdoc cuRetrowitoutdoc%ROWTYPE;
        nuDays             NUMBER;
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Removeretrosubsidy', pkg_traza.cnuNivelTrzDef);

        /*Reversar el subsidios retroactivos por no entrega de documentacion*/
        OPEN cuRetrowitoutdoc;
        LOOP
            FETCH cuRetrowitoutdoc
                INTO rgcuRetrowitoutdoc;
            EXIT WHEN cuRetrowitoutdoc%NOTFOUND;

            nuDays := ld_bosubsidy.fnuGetDaysAble(inucountry => ld_boconstans.cnucolombiancountryid,
                                                  idtIni     => rgcuRetrowitoutdoc.created_date,
                                                  idtFin     => SYSDATE);

            IF nuDays >= ld_boconstans.cnudaystofine THEN

                NULL;

            END IF;

        END LOOP;

        CLOSE cuRetrowitoutdoc;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Removeretrosubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            NULL;
        WHEN OTHERS THEN
            NULL;
    END Removeretrosubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : updatesubsidystate
     Descripcion    : Proceso que cambia de estados a los subsidios.

     Autor          : Evens Herard Gorut
     Fecha          : 10/01/2013

     Parametros          Descripcion
     ============        ===================
     InuAsig_Subsidy_Id  Identificador de asignacion de subsidios
     InuActReg           Registro actual
     InuTotalReg         Total de registros a procesar
     OnuErrorCode        Codigo de error
     OsbErrorMessage     Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     10/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    PROCEDURE updatesubsidystate(InuAsig_Subsidy_Id ld_asig_subsidy.asig_subsidy_id%TYPE,
                                 InuActReg          NUMBER,
                                 InuTotalReg        NUMBER,
                                 OnuErrorCode       OUT NUMBER,
                                 OsbErrorMessage    OUT VARCHAR2) IS

        /*Variables de instancia*/
        sbsubcurrentstate ge_boInstanceControl.stysbValue;
        sbnewstate        ge_boInstanceControl.stysbValue;
        nuRecordCollect   ge_boInstanceControl.stysbValue;
        dtPayDate         DATE;
        nuPayEntiTy       ge_boInstanceControl.stysbValue;
        sbPayPlace        ge_boInstanceControl.stysbValue;
        nuNumTransfer     ge_boInstanceControl.stysbValue;
        --
        nuUbication    ld_asig_subsidy.ubication_id%TYPE;
        sbGeograLoc    ge_geogra_location.description%TYPE;
        sbVerifiUbiSub VARCHAR2(2);
        nuGet_Rec_Coll ld_asig_subsidy.record_collect%TYPE;
        --
        sbAllValues  VARCHAR2(2000);
        nuPosPipe    VARCHAR2(60);
        nuValTotSub  NUMBER;
        nuMaxVeriTop NUMBER;
        --
        /*Variable de auditoria*/
        nuSeqCha_Sta_Sub_Audi ld_Cha_Sta_Sub_Audi.Cha_Sta_Sub_Audi_Id%TYPE;
        /*Variables tipo registro*/
        RcStyCha_sta_sub_audi Dald_cha_sta_sub_audi.styLD_cha_sta_sub_audi;
        RcStyAsig_Subsidy     Dald_Asig_Subsidy.styLD_asig_subsidy;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.updatesubsidystate', pkg_traza.cnuNivelTrzDef);

        /*Obtener valores de las variables de la instancia*/
        sbsubcurrentstate := ge_boInstanceControl.fsbGetFieldValue('LD_SUBSIDY_STATES',
                                                                   'SUBSIDY_STATES_ID');
        sbnewstate        := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY',
                                                                   'STATE_SUBSIDY');
        nuRecordCollect   := ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY',
                                                                   'RECORD_COLLECT');
        dtPayDate         := ut_convert.fnuChartoDate(ge_boInstanceControl.fsbGetFieldValue('LD_ASIG_SUBSIDY',
                                                                                            'INSERT_DATE'));
        nuPayEntiTy       := ut_convert.fnuChartoNumber(ge_boInstanceControl.fsbGetFieldValue('LD_CHA_STA_SUB_AUDI',
                                                                                              'PAY_ENTITY'));
        sbPayPlace        := ge_boInstanceControl.fsbGetFieldValue('LD_CHA_STA_SUB_AUDI',
                                                                   'PAY_PLACE');
        nuNumTransfer     := ut_convert.fnuChartoNumber(ge_boInstanceControl.fsbGetFieldValue('LD_CHA_STA_SUB_AUDI',
                                                                                              'TRANSFER_NUMBER'));

        /*Validar campos generales requeridos para el proceso de cambio de estado*/
        IF (sbsubcurrentstate IS NULL) THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El campo Estado actual es requerido y no debe ser nulo');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        IF (sbnewstate IS NULL) THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El campo Estado a asignar es requerido y no debe ser nulo');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        IF (sbsubcurrentstate = sbnewstate) THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El campo Estado actual y Estado a asignar no deben ser iguales');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Validar que no se pueda hacer el proceso si los estados no son consecutivos*/
        IF ((sbnewstate - sbsubcurrentstate) <> 1) THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'Los campos estado actual y estado a asignar no se encuentran debidamente diligenciados');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        sbAllValues := ld_bosubsidy.fsbVerifiMaxRec(InuAsig_Subsidy_Id => InuAsig_Subsidy_Id);

        nuPosPipe := instr(sbAllValues, '|');

        /*Obtener la sumatoria de los registros que se han pasado a estado COBRADO
        (ya sea por Valor o por Cantidad segun configuracion del subsidio)*/
        nuValTotSub := to_number(substr(sbAllValues, 1, nuPosPipe - 1));
        /*Obtener el Valor Tope del subsidio para la Ubicacion que se esta procesando*/
        nuMaxVeriTop := to_number(substr(sbAllValues, nuPosPipe + 1));
        /*Obtener la descripcion de la Ubicacion geografica del subsidio*/
        nuUbication := dald_asig_subsidy.fnuGetUbication_Id(inuasig_subsidy_Id => InuAsig_Subsidy_Id);
        sbGeograLoc := dage_geogra_location.fsbGetDescription(dald_ubication.fnuGetGeogra_Location_Id(nuUbication,
                                                                                                      NULL),
                                                              NULL);

        /*Dependiendo del caso pasar a estado (POR COBRAR a COBRADO) o de estado
        (COBRADO a PAGADO), se realizan validaciones y el proceso respectivo*/
        /*Inicia Caso de uso No.1. Pasar de estado POR COBRAR a estado COBRADO*/
        IF (sbnewstate = ld_boconstans.cnucollectstate) THEN
            /*Validar si existe tope o no para el periodo actual*/
            IF (nuMaxVeriTop != ld_boconstans.cnuCero_Value) THEN
                /*Validar que no se haya alcanzado ya, el tope del subsidio para el periodo actual.
                Si no se ha alcanzado se inicia el proceso. Esta validacion solo es necesaria cuando
                cuando se va a pasar de esatdo POR COBRAR a COBRADO*/
                IF (nuValTotSub < nuMaxVeriTop) THEN
                    /*Verificar que la sumatoria de los subsidios de una poblacion no superen el tope definido*/
                    sbVerifiUbiSub := ld_bosubsidy.fsbVerifiUbiSub(InuAsig_Subsidy_Id);
                    IF (sbVerifiUbiSub = ld_boconstans.csbYesFlag) THEN
                        /*Generar el consecutivo automatico del acta de cobro, la primera vez que se entra
                        al metodo y lo guardo en la variable globalrecordcollect*/
                        IF (ld_bosubsidy.globalrecordcollect IS NULL) THEN
                            nuRecordCollect                  := ld_bosequence.FnuSeq_Ld_Record_Collect;
                            ld_bosubsidy.globalrecordcollect := nuRecordCollect;
                        ELSE
                            nuRecordCollect := ld_bosubsidy.globalrecordcollect;
                        END IF;

                        /*Actualizar el estado del subsidio asignado en LD_ASIG_SUBSIDY*/
                        RcStyAsig_Subsidy.state_subsidy  := sbnewstate;
                        RcStyAsig_Subsidy.collect_date   := SYSDATE;
                        RcStyAsig_Subsidy.record_collect := nuRecordCollect;

                        Dald_Asig_Subsidy.updState_Subsidy(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                           inuState_Subsidy$  => RcStyAsig_Subsidy.state_subsidy);
                        Dald_Asig_Subsidy.updCollect_Date(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                          idtCollect_Date$   => RcStyAsig_Subsidy.collect_date);
                        Dald_Asig_Subsidy.updRecord_Collect(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                            inuRecord_Collect$ => RcStyAsig_Subsidy.record_collect);

                    ELSE
                        /*Mensaje de error*/
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error cambiando de estado el subsidio' ||
                                           InuAsig_Subsidy_Id ||
                                           ' de la lista. La sumatoria de los subsidios de la poblacion ' ||
                                           sbGeograLoc ||
                                           ' supera el tope definido para el periodo actual';
                        ROLLBACK;
                    END IF;

                ELSE
                    /*Mensaje de error*/
                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'Error cambiando de estado el subsidio. Se ha alcanzado el tope de cobro mensual del subsidio, ' ||
                                       'para la ubicacion ' || sbGeograLoc ||
                                       ' en el periodo actual';
                END IF;

            ELSE
                /*Si no existe tope definido se hace lo siguiente*/

                /*Inicia Caso de uso No.1. Pasar de estado POR COBRAR a estado COBRADO*/
                IF (sbnewstate = ld_boconstans.cnucollectstate) THEN

                    /*Generar el consecutivo automatico del acta de cobro, la primera vez que se entra
                    al metodo y lo guardo en la variable globalrecordcollect*/
                    IF (ld_bosubsidy.globalrecordcollect IS NULL) THEN
                        nuRecordCollect                  := ld_bosequence.FnuSeq_Ld_Record_Collect;
                        ld_bosubsidy.globalrecordcollect := nuRecordCollect;
                    ELSE
                        nuRecordCollect := ld_bosubsidy.globalrecordcollect;
                    END IF;

                    /*Actualizar el estado del subsidio asignado en LD_ASIG_SUBSIDY*/
                    RcStyAsig_Subsidy.state_subsidy  := sbnewstate;
                    RcStyAsig_Subsidy.collect_date   := SYSDATE;
                    RcStyAsig_Subsidy.record_collect := nuRecordCollect;

                    Dald_Asig_Subsidy.updState_Subsidy(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                       inuState_Subsidy$  => RcStyAsig_Subsidy.state_subsidy);
                    Dald_Asig_Subsidy.updCollect_Date(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                      idtCollect_Date$   => RcStyAsig_Subsidy.collect_date);
                    Dald_Asig_Subsidy.updRecord_Collect(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                        inuRecord_Collect$ => RcStyAsig_Subsidy.record_collect);

                END IF;

            END IF; /*Fin de si existe o no tope definido*/
            /*Fin de Caso de uso No.1.*/

            /*Inicia Caso de uso No.2. Pasar de estado COBRADO a estado PAGADO*/
        ELSIF (sbnewstate = ld_boconstans.cnuSubpaystate) THEN
            /*Verificar el acta de cobro. Este campo solo debe ser ingresado cuando nunewstate = PAGADO*/
            /*Verificar la fecha de pago de subsidio.  Este campo solo debe ser llenado cuando nunewstate = PAGADO*/
            /*Verificar la Entidad que registro el pago cuando la variable nunewstate = PAGADO.*/
            /*Verificar el Numero de la transaccion cuando la variable nunewstate = PAGADO*/
            IF ((nuRecordCollect IS NULL) OR (dtPayDate IS NULL) OR
               (nuPayEntiTy IS NULL) OR (nuNumTransfer IS NULL)) THEN
                /*Mensaje de error*/
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'Existen Campo(s) en nulo y que son necesarios para procesar y pasara a estado PAGADO. Verifique los siguientes campos: "No. de acta de cobro", ' ||
                                                 ' "Fecha pago subsidio" ,"Entidad que registro el pago" y "Numero de transaccion.');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;

            /*Verificar que la fecha de pago ingresada no sea mayor a la fecha actual.*/
            dtPayDate := trunc(dtPayDate);
            IF (dtPayDate > trunc(SYSDATE)) THEN
                /*Mensaje de error*/
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'El campo "Fecha de pago", no puede ser mayor a la fecha actual. Verifique');
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                /*Verificar que el acta de cobro ingresada exista (nuRecordCollect) y este asociada al registro que se esta procesando*/
                nuGet_Rec_Coll := dald_asig_subsidy.fnuGetRecord_Collect(inuASIG_SUBSIDY_Id => InuAsig_Subsidy_Id);

                IF (nuGet_Rec_Coll = nuRecordCollect) THEN

                    /*Actualizar el estado del subsidio en LD_ASIG_SUBSIDY*/
                    RcStyAsig_Subsidy.state_subsidy := sbnewstate;
                    /*Actualizar la fecha de pago del subsidio en LD_ASIG_SUBSIDY*/
                    RcStyAsig_Subsidy.pay_date := SYSDATE;
                    /*Actualizar el Numero de transaccion del subsidio en LD_ASIG_SUBSIDY*/
                    RcStyAsig_Subsidy.Transfer_Number := nuNumTransfer;
                    /*Actualizar la entidad que realizo el pago en LD_ASIG_SUBSIDY*/
                    RcStyAsig_Subsidy.Pay_Entity := nuPayEntiTy;
                    /*Actualizar la entidad que realizo el pago en LD_ASIG_SUBSIDY*/
                    RcStyAsig_Subsidy.Pay_Place := sbPayPlace;

                    Dald_Asig_Subsidy.updState_Subsidy(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                       inuState_Subsidy$  => RcStyAsig_Subsidy.state_subsidy);
                    Dald_Asig_Subsidy.updPay_Date(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                  idtPay_Date$       => RcStyAsig_Subsidy.pay_date);

                    Dald_Asig_Subsidy.updTransfer_Number(inuasig_subsidy_Id  => InuAsig_Subsidy_Id,
                                                         inuTransfer_Number$ => RcStyAsig_Subsidy.Transfer_Number);
                    Dald_Asig_Subsidy.updPay_Entity(inuasig_subsidy_Id => InuAsig_Subsidy_Id,
                                                    inuPay_Entity$     => RcStyAsig_Subsidy.Pay_Entity);
                    Dald_Asig_Subsidy.updPay_Place(InuAsig_Subsidy_Id => InuAsig_Subsidy_Id,
                                                   isbPay_Place$      => RcStyAsig_Subsidy.Pay_Place);

                ELSE
                    /*Mensaje de error*/
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                     'El acta de cobro ingresada, no corresponde al acta asociada al registro de entrega de subsidio. Verifique.');
                    RAISE pkg_error.CONTROLLED_ERROR;
                END IF;
            END IF;
        END IF;

        IF (onuErrorCode IS NULL) THEN
            /*Obtener secuencia de la entidad LD_CHA_STA_SUB_AUDI*/
            nuSeqCha_Sta_Sub_Audi := ld_bosequence.FnuSeq_Cha_Sta_Sub_Audi;

            /*Registrar el movimiento en la etidad de Auditoria LD_CHA_STA_SUB_AUDI*/
            RcStyCha_sta_sub_audi.cha_sta_sub_audi_id := nuSeqCha_Sta_Sub_Audi;
            RcStyCha_sta_sub_audi.asig_subsidy_id     := InuAsig_Subsidy_Id;
            RcStyCha_sta_sub_audi.last_state          := to_number(sbsubcurrentstate);
            RcStyCha_sta_sub_audi.new_state           := to_number(sbnewstate);
            RcStyCha_sta_sub_audi.register_date       := SYSDATE;
            RcStyCha_sta_sub_audi.con_user            := SA_BOUser.fnuGetUserId;
            RcStyCha_sta_sub_audi.terminal            := userenv('TERMINAL');
            RcStyCha_sta_sub_audi.Transfer_Number     := nuNumTransfer;
            RcStyCha_sta_sub_audi.Pay_Entity          := nuPayEntiTy;
            RcStyCha_sta_sub_audi.Pay_Place           := sbPayPlace;

            DALD_Cha_sta_sub_audi.insRecord(RcStyCha_sta_sub_audi);

            /*Hacer commit si todo OK*/
            COMMIT;

            IF InuActReg = InuTotalReg AND nuRecordCollect IS NOT NULL AND
               sbsubcurrentstate = ld_boconstans.cnureceivablestate THEN
                /*Llamar al metodo que genera el acta de cobro*/
                Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbGen_Record_Collect);
            END IF;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.updatesubsidystate', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END updatesubsidystate;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : fnuservgasuserconnect
       Descripcion    : Determina si a un contrato le fue instalado el
                        servicio GAS. Si la funcion retorna 0 significa que
                        no le fue instalado. Si la funcion retorna 1,
                        significa que si le fue instalado.

       Autor          : jonathan alberto consuegra lara
       Fecha          : 14/01/2013

       Parametros       Descripcion
       ============     ===================
       inususcodi       identificador del contrato

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       14/01/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION fnuservgasuserconnect(inususcodi suscripc.susccodi%TYPE) RETURN NUMBER IS
        dtconnectdate servsusc.sesufein%TYPE;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnuservgasuserconnect', pkg_traza.cnuNivelTrzDef);

        dtconnectdate := ld_bosubsidy.fdtgetInstallDate(inususcodi, NULL);

        IF dtconnectdate IS NOT NULL THEN
            RETURN(1);
        ELSE
            RETURN(0);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fnuservgasuserconnect', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnuservgasuserconnect;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FblDistrRemainSubsidy
      Descripcion    : Inserta la Distribucion del remanente de un
                       subsidio.

      Autor          : Jorge Valiente
      Fecha          : 14/01/2013

      Parametros                  Descripcion
      ============           ===================
      inuAsigSubsidyId       Cadena de subsidio
      inuUbicationId         Poblacion del subsidio
      inuDeliveryTotal       porcion distribuida del remanente
      inustate_delivery      Estado del remanente del subsidio
      onuErrorCode           Codigo de Error
      osbErrorMessage        Descripcion del Error

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FblDistrRemainSubsidy(inuSubsidyId        IN ld_Subsidy.Subsidy_Id%TYPE,
                                   inValueDistributing IN LD_SUB_REMAIN_DELIV.delivery_total%TYPE,
                                   inustate_delivery   IN LD_SUB_REMAIN_DELIV.state_delivery%TYPE,
                                   onuErrorCode        OUT NUMBER,
                                   osbErrorMessage     OUT VARCHAR2) RETURN BOOLEAN IS

        /*Declaracion de variables*/
        rcLD_SUB_REMAIN_DELIV daLD_SUB_REMAIN_DELIV.styLD_sub_remain_deliv;

        nuSesuNuse servsusc.sesunuse%TYPE;

        nuDeliveryTotal LD_SUB_REMAIN_DELIV.delivery_total%TYPE;

        blReturn         BOOLEAN := FALSE;
        nuPackagesStatus ld_parameter.numeric_value%TYPE;
        nucont           NUMBER := 0;

        CURSOR cuSuscBySub(inuSubId      IN ld_subsidy.subsidy_id%TYPE,
                           inuPackStatus IN mo_packages.motive_status_id%TYPE) IS
            SELECT a.*
            FROM   Ld_Asig_Subsidy a,
                   mo_packages     m
            WHERE  a.package_id = m.package_id
            AND    a.Subsidy_Id = inuSubId
            AND    m.motive_status_id = inuPackStatus
            AND    a.State_Subsidy <> ld_boconstans.cnuSubreverstate
            AND    a.Type_Subsidy <> 'RE'
            AND    EXISTS (SELECT 1
                    FROM   ld_subsidy_detail d
                    WHERE  d.ubication_id = a.ubication_id);

        SUBTYPE stySuscBySub IS cuSuscBySub%ROWTYPE;

        TYPE tytbSuscBySub IS TABLE OF stySuscBySub INDEX BY BINARY_INTEGER;

        tbSuscBySub tytbSuscBySub;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.FblDistrRemainSubsidy', 1);

        ld_bosubsidy.globaltransfersub := 'Y';

        /*Obtener el valor del parametro de solicitud atendida*/
        nuPackagesStatus := Dald_parameter.fnuGetNumeric_Value('SERVERD_SALE_PACKAGE');

        IF nuPackagesStatus IS NULL THEN
            onuErrorCode    := -1;
            osbErrorMessage := 'El valor del parametro SERVERD_SALE_PACKAGE no se encuentra diligenciado';
            RETURN(FALSE);
        END IF;

        /*Obtener la session actual*/
        LD_BOSUBSIDY.globalsesion := userenv('SESSIONID');

        /*Funcion para obtener los contratos asociados a los subsidios entregados
        para un subsidio especifico (inuSubsidyId) y que cuya atencion de venta
        este atendida*/

        IF cuSuscBySub%ISOPEN THEN
            CLOSE cuSuscBySub;
        END IF;

        OPEN cuSuscBySub(inuSubsidyId, nuPackagesStatus);
        FETCH cuSuscBySub BULK COLLECT
            INTO tbSuscBySub;
        CLOSE cuSuscBySub;

        /*validar que existan clientes*/
        IF (tbSuscBySub.count > ld_boconstans.cnuCero_Value) THEN
            /*Calcular valor a distribur por cada beneficiario*/
            nuDeliveryTotal := inValueDistributing / tbSuscBySub.count;

            FOR n IN tbSuscBySub.first .. tbSuscBySub.last LOOP

                nuSesuNuse := ld_bcsubsidy.Fnugetsesunuse(dald_asig_subsidy.fnuGetPackage_Id(tbSuscBySub(n)
                                                                                             .Asig_Subsidy_Id,
                                                                                             0),
                                                          0);

                /*validar que el suscriptor no tenga servicio gas*/
                IF nuSesuNuse IS NOT NULL THEN

                    /*Secuencia de la tabla*/
                    rcLD_SUB_REMAIN_DELIV.sub_remain_deliv_id := ld_bosequence.Fnuseqld_sub_remain_deliv;

                    /*identificador del subsidio*/
                    rcLD_SUB_REMAIN_DELIV.subsidy_id := inuSubsidyId;

                    /*identificador del numero del contrato al cual se le trasladara el subsidio otorgado*/
                    rcLD_SUB_REMAIN_DELIV.susccodi := tbSuscBySub(n).susccodi;

                    /*codigo del servicio suscrito subsidiado*/
                    rcLD_SUB_REMAIN_DELIV.sesunuse := nuSesuNuse;

                    /*porcion asignada mediante distribucion del remanente del subsidio*/
                    rcLD_SUB_REMAIN_DELIV.delivery_total := nuDeliveryTotal;

                    /*estado de distribucion. si es s: simulacion. si es d: distribuido*/
                    rcLD_SUB_REMAIN_DELIV.state_delivery := inustate_delivery;

                    /*codigo del usuario que realizo la distribucion*/
                    rcLD_SUB_REMAIN_DELIV.user_id := GE_BOPersonal.fnuGetPersonId;

                    /*terminal de donde se realizo la distribucion*/
                    rcLD_SUB_REMAIN_DELIV.terminal := userenv('TERMINAL');

                    /*Codigo de Ubicacion de la poblacion*/
                    rcLD_SUB_REMAIN_DELIV.ubication_id := tbSuscBySub(n)
                                                          .Ubication_Id;

                    /*Session de Oracle*/
                    rcLD_SUB_REMAIN_DELIV.sesion := LD_BOSUBSIDY.globalsesion;

                    rcLD_SUB_REMAIN_DELIV.asig_value := 0;

                    rcLD_SUB_REMAIN_DELIV.asig_subsidy_id := tbSuscBySub(n)
                                                             .Asig_Subsidy_Id;

                    /*Valor total a subsidiar. Este es el valor que se coloca en la primera
                    grilla del aplicativo LDREM*/
                    rcLD_SUB_REMAIN_DELIV.remain_value := inValueDistributing;

                    daLD_SUB_REMAIN_DELIV.insRecord(rcLD_SUB_REMAIN_DELIV);

                    blReturn := TRUE;

                END IF;

            END LOOP;

            IF blReturn THEN

                /*Actualizar estado del remanente*/
                IF inustate_delivery = 'S' THEN
                    dald_subsidy.updRemainder_Status(inuSubsidyId, 'SI');
                ELSIF inustate_delivery = 'D' THEN
                    dald_subsidy.updRemainder_Status(inuSubsidyId, 'DI');
                END IF;

            ELSE
                onuErrorCode    := -1;
                osbErrorMessage := 'No se encontraron usuarios para aplicar remanente para el subsidio ' ||
                                   inuSubsidyId;
            END IF;

        ELSE
            onuErrorCode    := -1;
            osbErrorMessage := 'No se encontraron usuarios para aplicar remanente para el subsidio ' ||
                               inuSubsidyId;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.FblDistrRemainSubsidy', 1);

        RETURN(blReturn);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            errors.GetError(onuErrorCode, osbErrorMessage);
            RETURN(FALSE);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            errors.GetError(onuErrorCode, osbErrorMessage);
            RETURN(FALSE);
            RAISE pkg_error.CONTROLLED_ERROR;
    END FblDistrRemainSubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Reversesubsidywitoutdoc
     Descripcion    : Reversa los subsidios asignados de forma
                      retroactiva si no se legalizo la orden
                      de entrega de documentacion como exitosa
                      o no se legalizo.

     Autor          : Jonathan Alberto Consuegra
     Fecha          : 15/01/2013

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Identificador de registro de la asignacion
                          de subsidio
     inuRever_cause       Causa de reversion
     onuErrorCode         Numero de Error
     osbErrorMessage      Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     15/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Reverseretrosubwithoutdoc IS

        CURSOR cuRetrowithoutdoc IS
            SELECT l.*
            FROM   ld_asig_subsidy l
            WHERE  l.type_subsidy = ld_boconstans.csbretroactivesale
            AND    l.delivery_doc = ld_boconstans.csbNOFlag
            AND    l.state_subsidy <> ld_boconstans.cnuSubreverstate
            AND    EXISTS
             (SELECT 1
                    FROM   or_order o
                    WHERE  o.order_id = l.order_id
                    AND    o.legalization_date IS NULL
                    AND    o.order_status_id <>
                           ld_boconstans.cnulegalizeorderstatus);

        /*Declaracion de variables*/
        rcUbication dald_ubication.styld_ubication;
        nucausal    ld_causal.causal_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Reverseretrosubwithoutdoc', pkg_traza.cnuNivelTrzDef);

        nucausal := Dald_parameter.fnuGetNumeric_Value('REVER_RETRO_SUBSIDY_CAUSE');

        IF nucausal IS NULL THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'La causal de reversion no debe ser nula');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Setear la variable que me indicara en el trigger trgaiduld_subsidyvalidate
         si se debe hacer la validacion de sumatoria de valores por los
         conceptos parametrizados por porcentaje
        */
        ld_bosubsidy.globalasigsub := 'S';

        FOR vrgRetrowithoutdoc IN cuRetrowithoutdoc LOOP

            /*Obtener datos de la poblacion*/
            DALD_ubication.LockByPkForUpdate(vrgRetrowithoutdoc.ubication_id,
                                     rcUbication);

            /*Reversar los valores del subsidio*/
            LD_BOSUBSIDY.Procbalancesub(vrgRetrowithoutdoc.subsidy_id,
                                        rcUbication,
                                        vrgRetrowithoutdoc.subsidy_value,
                                        ld_boconstans.cnutwonumber);

            /*Se devuelve al subsidio el valor que se le habia quitado y
            se registra el movimiento de reversion*/
            Ld_Bosubsidy.RegisterReversesubsidy(vrgRetrowithoutdoc.asig_subsidy_id,
                                                ld_boconstans.cnurever_retro_sub_cause);

        END LOOP;

        /*Confirmar las transacciones*/
        COMMIT;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Reverseretrosubwithoutdoc', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Reverseretrosubwithoutdoc;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fdtgetInstallDate
     Descripcion    : Funcion para obtener la fecha d einstalacion
                      del producto gas del contrato.

     Autor          : Evens Herard Gorut
     Fecha          : 11/01/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     11/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fdtgetInstallDate(inususcodi    suscripc.susccodi%TYPE,
                               inuRaiseError IN NUMBER DEFAULT 1) RETURN DATE IS

        /*Variables*/
        --nuOrder       or_order.order_id%type;
        dtInstallDate servsusc.sesufein%TYPE;
        nunuse        servsusc.sesunuse%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BcSubsidy.fdtgetInstallDate', pkg_traza.cnuNivelTrzDef);

        /*Obtener el numero del servicio a partir del contrato*/
        nunuse := Ld_bcsubsidy.Fnugetactivesesunuse(inususcodi, NULL);

        IF nunuse IS NOT NULL THEN
            /*Obtener la fecha registrada de instalacion del servicio GAS para el contrato*/
            dtInstallDate := pktblservsusc.fdtGetInstallationDate(nunuse, NULL);

        END IF;

        RETURN dtInstallDate;

        UT_Trace.Trace('Fin Ld_BcSubsidy.fdtgetInstallDate', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END fdtgetInstallDate;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbVerifiMaxRec
     Descripcion    : Funcion para verificar que el tope definido para
                      una ubicacion dentro de un periodo, para determinar
                      si ha agotadoo no para el periodo actual.

     Autor          : Evens Herard Gorut
     Fecha          : 15/01/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     15/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fsbVerifiMaxRec(inuAsig_Subsidy_Id ld_asig_subsidy.asig_subsidy_id%TYPE)
        RETURN VARCHAR2 IS

        /*Variables*/
        nuSubsidy   ld_subsidy.subsidy_id%TYPE;
        nuUbication ld_asig_subsidy.ubication_id%TYPE;
        --
        nuSumSubsidy ld_asig_subsidy.subsidy_value%TYPE;
        nuValMaxReco ld_max_recovery.recovery_value%TYPE;
        --
        nuContSubsidy NUMBER;
        nuNumMaxReco  ld_max_recovery.total_sub_recovery%TYPE;
        --
        nuYear  ld_max_recovery.year%TYPE;
        nuMonth ld_max_recovery.month%TYPE;
        --
        nuOption NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fsbVerifiMaxRec', pkg_traza.cnuNivelTrzDef);

        /*Obtener A?o y mes actual*/
        SELECT to_char(SYSDATE, 'YYYY') INTO nuYear FROM dual;

        SELECT to_char(SYSDATE, 'MM') INTO nuMonth FROM dual;

        /*Obtener los Parametros para el query*/
        nuSubsidy := dald_asig_subsidy.fnuGetSubsidy_Id(inuasig_subsidy_Id => InuAsig_Subsidy_Id);

        nuUbication := dald_asig_subsidy.fnuGetUbication_Id(inuasig_subsidy_Id => InuAsig_Subsidy_Id);

        /*Si el subsidio esta parametrizado por cantidad*/
        IF dald_subsidy.fnuGetAuthorize_Quantity(nuSubsidy, NULL) IS NOT NULL THEN
            /*La Opcion toma valor = 1*/
            nuOption := ld_boconstans.cnuonenumber;

            nuContSubsidy := ld_bosubsidy.fnuGetNuSub(inuAsig_Subsidy_Id,
                                                      nuSubsidy,
                                                      nuUbication,
                                                      nuOption);
            /*Si no hay tope definido toma valor = 0*/
            nuNumMaxReco := ld_bosubsidy.fnuGetTop(nuUbication,
                                                   nuYear,
                                                   nuMonth,
                                                   nuOption);

            UT_Trace.Trace('Fin Ld_BoSubsidy.fsbVerifiMaxRec', pkg_traza.cnuNivelTrzDef);

            RETURN nuContSubsidy || '|' || nuNumMaxReco;

        END IF;

        /*Si el subsidio esta parametrizado por valor autorizado*/
        IF dald_subsidy.fnuGetAuthorize_Value(nuSubsidy, NULL) IS NOT NULL THEN

            /*La Opcion toma valor = 2*/
            nuOption := ld_boconstans.cnutwonumber;

            nuSumSubsidy := ld_bosubsidy.fnuGetNuSub(inuAsig_Subsidy_Id,
                                                     nuSubsidy,
                                                     nuUbication,
                                                     nuOption);

            /*Si no hay tope definido toma valor = 0*/
            nuValMaxReco := ld_bosubsidy.fnuGetTop(nuUbication,
                                                   nuYear,
                                                   nuMonth,
                                                   nuOption);

            UT_Trace.Trace('Fin Ld_BoSubsidy.fsbVerifiMaxRec', pkg_traza.cnuNivelTrzDef);

            RETURN nuSumSubsidy || '|' || nuValMaxReco;

        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbVerifiMaxRec;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbVerifiUbiSub
     Descripcion    : Funcion para Verificar que la sumatoria de los
                      subsidios de una poblacion por a?o y mes, que no
                      superen el tope definido.

     Autor          : Evens Herard Gorut
     Fecha          : 14/01/2013

     Parametros         Descripcion
     ============       ===================
     inuAsig_Subsidy_Id Identificador del subsidio asignado

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     14/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fsbVerifiUbiSub(inuAsig_Subsidy_Id ld_asig_subsidy.asig_subsidy_id%TYPE)
        RETURN VARCHAR2 IS

        nuUbication ld_asig_subsidy.ubication_id%TYPE;
        nuYear      ld_max_recovery.year%TYPE;
        nuMonth     ld_max_recovery.month%TYPE;

        /*Variable de tipo tabla para insert a temporal*/
        Rcsty_max_recovery Dald_tmp_max_recovery.styLD_tmp_max_recovery;

        /*Variable de retorno de datos de ld_max_recovery*/
        tb_max_recovery Dald_max_recovery.tytbLD_max_recovery;

        /*variable de retorno de consulta para verificar datos en ld_tmp_max_recovery*/
        tb_tmp_max_recovery Dald_tmp_max_recovery.tytbLD_tmp_max_recovery;

        /*Variable para la secuencia*/
        nuSeq_tmp_max_rec ld_tmp_max_recovery.tmp_max_recovery_id%TYPE;
        nuSubsidy         ld_subsidy.subsidy_id%TYPE;

        /*indices*/
        nuIndex  NUMBER;
        nuIndex1 NUMBER;

        /*Variables caso por valor*/
        nuActSubsidyValue  ld_asig_subsidy.subsidy_value%TYPE;
        nuActRecoveryValue ld_max_recovery.recovery_value%TYPE;

        /*Variables caso por cantidad*/
        --nuActTotalSubReco number;
        nuActTotalMaxReco NUMBER;

        /*Variable id temporal*/
        nuIdTmp_max_recovery ld_tmp_max_recovery.tmp_max_recovery_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fsbVerifiUbiSub', pkg_traza.cnuNivelTrzDef);

        /*Obtener la Ubicacion del subsidio asignado*/
        nuUbication := dald_asig_subsidy.fnuGetUbication_Id(inuasig_subsidy_Id => InuAsig_Subsidy_Id);

        /*Obtener A?o y mes actual*/
        SELECT to_number(to_char(SYSDATE, 'YYYY')) INTO nuYear FROM dual;

        SELECT to_number(to_char(SYSDATE, 'MM')) INTO nuMonth FROM dual;
        BEGIN
            /*Verifico si existe el registro copia en ld_tmp_max_recovery para el periodo actual*/
            Dald_tmp_max_recovery.getRecords(' ld_tmp_max_recovery.ubication_id = ' ||
                                             nuUbication ||
                                             ' And ld_tmp_max_recovery.year     = ' ||
                                             nuYear ||
                                             ' And ld_tmp_max_recovery.month    = ' ||
                                             nuMonth,
                                             tb_tmp_max_recovery);

            nuIndex1 := tb_tmp_max_recovery.first;

            nuIdTmp_max_recovery := tb_tmp_max_recovery(nuIndex1)
                                    .tmp_max_recovery_id;

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN

                /*Obtener los datos del registro de ld_max_recovery y copiarlos en ld_tmp_max_recovery
                para el mes actual y a?o actual*/
                Dald_max_recovery.getRecords(' ld_max_recovery.ubication_id = ' ||
                                             nuUbication ||
                                             ' And ld_max_recovery.year     = ' ||
                                             nuYear ||
                                             ' And ld_max_recovery.month    = ' ||
                                             nuMonth,
                                             tb_max_recovery);

                nuIndex := tb_max_recovery.first;

                /*Obtener la secuencia de la entidad temporal para adicionar un nuevo registro*/
                nuSeq_tmp_max_rec := ld_bosequence.FnuSeqtmp_max_recovery;

                /*Tomar el registro e insertarlo en la tabla temporal*/
                Rcsty_max_recovery.tmp_max_recovery_id := nuSeq_tmp_max_rec;
                Rcsty_max_recovery.ubication_id        := nuUbication;
                Rcsty_max_recovery.year                := nuYear;
                Rcsty_max_recovery.month               := nuMonth;
                Rcsty_max_recovery.recovery_value      := tb_max_recovery(nuIndex)
                                                          .recovery_value;
                Rcsty_max_recovery.total_sub_recovery  := tb_max_recovery(nuIndex)
                                                          .total_sub_recovery;

                DAld_tmp_max_recovery.insRecord(Rcsty_max_recovery);

                /*Obtengo el registro insertado y los guardo en una variable del tipo tabla Temporal*/
                Dald_tmp_max_recovery.getRecords(' ld_tmp_max_recovery.ubication_id = ' ||
                                                 nuUbication ||
                                                 ' And ld_tmp_max_recovery.year     = ' ||
                                                 nuYear ||
                                                 ' And ld_tmp_max_recovery.month    = ' ||
                                                 nuMonth,
                                                 tb_tmp_max_recovery);

                nuIndex1 := tb_tmp_max_recovery.first;

                nuIdTmp_max_recovery := nuSeq_tmp_max_rec;

        END;

        /*Verificar el Tope del subsidio por Ubicacion, por a?o y mes*/

        /*Obtener el subsidio*/
        nuSubsidy := dald_asig_subsidy.fnuGetSubsidy_Id(inuasig_subsidy_Id => InuAsig_Subsidy_Id);

        /*Verificar si el subsidio esta parametrizado por valor autorizado.*/
        IF dald_subsidy.fnuGetAuthorize_Value(nuSubsidy, NULL) IS NOT NULL THEN

            /*Obtener el valor del subsidio entregado*/
            nuActSubsidyValue := Dald_Asig_Subsidy.fnuGetSubsidy_Value(InuAsig_Subsidy_Id,
                                                                       NULL);

            /*Obtener el valor del Tope en su estado actual del campo recovery_value de la tabla
            temporal para la ubicacion en el periodo actual*/
            nuActRecoveryValue := tb_tmp_max_recovery(nuIndex).recovery_value;

            /*Verifico los valores y permito o niego el cambio de estado*/
            IF (nuActRecoveryValue >= nuActSubsidyValue) THEN

                nuActRecoveryValue := nuActRecoveryValue - nuActSubsidyValue;

                /*Actualizo los valores de la temporal*/
                Dald_tmp_max_recovery.updRecovery_Value(inuTMP_MAX_RECOVERY_Id => nuIdTmp_max_recovery,
                                                        inuRecovery_Value$     => nuActRecoveryValue);

                UT_Trace.Trace('Fin Ld_BoSubsidy.fsbVerifiUbiSub', pkg_traza.cnuNivelTrzDef);

                RETURN ld_boconstans.csbYesFlag;

            ELSE

                UT_Trace.Trace('Fin Ld_BoSubsidy.fsbVerifiUbiSub', pkg_traza.cnuNivelTrzDef);

                RETURN ld_boconstans.csbNOFlag;

            END IF;
        END IF;

        /*Verificar si el subsidio esta parametrizado por cantidad*/
        IF dald_subsidy.fnuGetAuthorize_Quantity(nuSubsidy, NULL) IS NOT NULL THEN

            /*Obtener el numero de subsidios actuales que se pueden autorizar, del campo total_sub_recovery
            de la tabla temporal para la ubicacion en el periodo actual*/
            nuActTotalMaxReco := tb_tmp_max_recovery(nuIndex).total_sub_recovery;

            /*Verifico los valores y permito o niego el cambio de estado*/
            IF (nuActTotalMaxReco > ld_boconstans.cnuonenumber) THEN

                nuActTotalMaxReco := nuActTotalMaxReco -
                                     ld_boconstans.cnuonenumber;

                /*Actualizo los valores de la temporal*/
                Dald_tmp_max_recovery.updTotal_Sub_Recovery(inuTMP_MAX_RECOVERY_Id => tb_tmp_max_recovery(nuIndex1)
                                                                                      .tmp_max_recovery_id,
                                                            inuTotal_Sub_Recovery$ => nuActTotalMaxReco);

                UT_Trace.Trace('Fin Ld_BoSubsidy.fsbVerifiUbiSub', pkg_traza.cnuNivelTrzDef);

                RETURN ld_boconstans.csbYesFlag;

            ELSE

                UT_Trace.Trace('Fin Ld_BoSubsidy.fsbVerifiUbiSub', pkg_traza.cnuNivelTrzDef);

                RETURN ld_boconstans.csbNOFlag;

            END IF;
        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbVerifiUbiSub;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnuGetNuSub
     Descripcion    : Obtiene el numero o la sumatoria de los valores
                      de los subsidios asignados a una poblacion
                      determinada.

     Autor          : Evens Herard Gorut
     Fecha          : 23/01/2013

     Parametros         Descripcion
     ============       ===================
     inuAsig_Subsidy_Id Identificador del subsidio asignado
     inuSubsidy         Identificador del subsidio
     inuUbication       Identificador de la poblacion
     inuCase            Opcion a implementar
     inuRaiseError      Controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     23/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fnuGetNuSub(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                         inuSubsidy         IN ld_subsidy.subsidy_id%TYPE,
                         inuUbication       IN ld_ubication.ubication_id%TYPE,
                         inuCase            IN NUMBER,
                         inuRaiseError      IN NUMBER DEFAULT 1)
        RETURN ld_subsidy.authorize_value%TYPE IS

        /*variables para el caso de valor*/
        nuSumSubsidy ld_asig_subsidy.subsidy_value%TYPE;

        /*variables para el caso de cantidad*/
        nuContSubsidy NUMBER;

        /*Variable de salida*/
        nuVarOut ld_subsidy.authorize_value%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnuGetNuSub', pkg_traza.cnuNivelTrzDef);

        /*Opcion 1 cuando es parametrizado por cantidad*/
        IF (InuCase = ld_boconstans.cnuonenumber) THEN
            nuContSubsidy := ld_bcsubsidy.fnuGetContSub(inuSubsidy   => InuSubsidy,
                                                        inuUbication => InuUbication);
            nuVarOut      := nuContSubsidy;
        END IF;

        /*Opcion 2 cuando es parametrizado por valor*/
        IF (Inucase = ld_boconstans.cnutwonumber) THEN
            nuSumSubsidy := ld_bcsubsidy.fnuGetSumSub(inuSubsidy   => InuSubsidy,
                                                      inuUbication => InuUbication);
            nuVarOut     := nuSumSubsidy;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fnuGetNuSub', pkg_traza.cnuNivelTrzDef);

        RETURN nuVarOut;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END fnuGetNuSub;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnuGetTop
     Descripcion    : Funcion que verifica los topes de un subsidio

     Autor          : Evens Herard Gorut
     Fecha          : 23/01/2013

     Parametros         Descripcion
     ============       ===================
     inuUbication       Identificador de la poblacion
     inuYear            A?o del tope de cobro evaluado
     inuMonth           Mes del tope de cobro evaluado
     inuCase            Opcion a implementar
     inuRaiseError      Controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     23/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION fnuGetTop(inuUbication  IN ld_ubication.ubication_id%TYPE,
                       inuYear       IN ld_max_recovery.year%TYPE,
                       inuMonth      IN ld_max_recovery.month%TYPE,
                       inuCase       IN NUMBER,
                       inuRaiseError IN NUMBER DEFAULT 1)
        RETURN ld_max_recovery.recovery_value%TYPE IS

        /*Variable para el caso por valor*/
        nuValMaxReco ld_max_recovery.recovery_value%TYPE;

        /*Variable para el caso por cantidad*/
        nuNumMaxReco ld_max_recovery.total_sub_recovery%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnuGetTop', pkg_traza.cnuNivelTrzDef);

        /*Opcion 1 cuando es parametrizado por cantidad*/
        IF (InuCase = ld_boconstans.cnuonenumber) THEN

            nuNumMaxReco := nvl(ld_bcsubsidy.fnuGetNuMaxRec(inuUbication  => InuUbication,
                                                            inuYear       => InuYear,
                                                            inuMonth      => InuMonth,
                                                            InuRaiseError => NULL),
                                0);

            UT_Trace.Trace('Fin Ld_BoSubsidy.fnuGetTop', pkg_traza.cnuNivelTrzDef);

            RETURN nuNumMaxReco;

        END IF;

        /*Opcion 2 cuando es parametrizado por valor*/
        IF (Inucase = ld_boconstans.cnutwonumber) THEN

            nuValMaxReco := nvl(ld_bcsubsidy.fnuGetValMaxRec(inuUbication  => InuUbication,
                                                             inuYear       => InuYear,
                                                             inuMonth      => InuMonth,
                                                             InuRaiseError => NULL),
                                0);

            UT_Trace.Trace('Fin Ld_BoSubsidy.fnuGetTop', pkg_traza.cnuNivelTrzDef);

            RETURN nuValMaxReco;

        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END fnuGetTop;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnusetdataandgettemplate
     Descripcion    : Coloca los valores en memoria para el proceso
                      de extraccion y mezcla y retorna el
                      nombre del report viewer que contiene la
                      plantilla en donde se visualizaran los datos

     Autor          : jonathan alberto consuegra lara
     Fecha          : 25/01/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     25/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnusetdataandgettemplate(inucoempadi ed_confexme.coemcodi%TYPE)
        RETURN ed_confexme.coempadi%TYPE IS

        rcTemplate     pktblED_ConfExme.cuEd_Confexme%ROWTYPE;
        nuFormatId     ed_formato.formcodi%TYPE;
        oclFileContent CLOB;
        sbTemplate     ed_confexme.coempadi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnusetdataandgettemplate', pkg_traza.cnuNivelTrzDef);

        pkBCED_Confexme.ObtieneRegistro(inucoempadi, rcTemplate);

        /* Obtiene el formato*/
        nuFormatId := pkBOInsertMgr.GetCodeFormato(rcTemplate.coempada);

        /*Ejecuta proceso de extraccion de datos para el formato*/
        pkBODataExtractor.ExecuteRules(nuFormatId, oclFileContent);

        /*Captura el contenido del clob*/
        globalclSubsidy := oclFileContent;

        /*Obtiene el template*/
        sbTemplate := rcTemplate.coempadi;

        /*Se asigna la plantilla obtenida a una variable global del proceso*/
        globalsbTemplate := sbTemplate;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnusetdataandgettemplate', pkg_traza.cnuNivelTrzDef);

        RETURN(sbTemplate);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnusetdataandgettemplate;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnusetdatainmemory
     Descripcion    : Coloca los valores en memoria para el proceso
                      de extraccion y mezcla y devuelve el clob
                      resultante.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 29/01/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     29/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnusetdatainmemory(inucoempadi ed_confexme.coemcodi%TYPE) RETURN CLOB IS

        rcTemplate    pktblED_ConfExme.cuEd_Confexme%ROWTYPE;
        nuFormatId    ed_formato.formcodi%TYPE;
        clFileContent CLOB;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnusetdatainmemory', pkg_traza.cnuNivelTrzDef);

        pkBCED_Confexme.ObtieneRegistro(inucoempadi, rcTemplate);

        /* Obtiene el formato*/
        nuFormatId := pkBOInsertMgr.GetCodeFormato(rcTemplate.coempada);

        /*Ejecuta proceso de extraccion de datos para el formato*/
        pkBODataExtractor.ExecuteRules(nuFormatId, clFileContent);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnusetdatainmemory', pkg_traza.cnuNivelTrzDef);

        RETURN(clFileContent);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnusetdatainmemory;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugettemplate
     Descripcion    : Obtiene la plantilla a mezclar con un
                      reporte hecho en report viewer.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 29/01/2013

     Parametros       Descripcion
     ============     ===================
     inucoempadi      Codigo del formato de FCED

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     29/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fsbgettemplate(inucoempadi ed_confexme.coemcodi%TYPE)
        RETURN ed_confexme.coempadi%TYPE IS

        rcTemplate pktblED_ConfExme.cuEd_Confexme%ROWTYPE;
        sbTemplate ed_confexme.coempadi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fsbgettemplate', pkg_traza.cnuNivelTrzDef);

        pkBCED_Confexme.ObtieneRegistro(inucoempadi, rcTemplate);

        /*Obtiene el template*/
        sbTemplate := rcTemplate.coempadi;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fsbgettemplate', pkg_traza.cnuNivelTrzDef);

        RETURN(sbTemplate);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fsbgettemplate;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Callapplication
     Descripcion    : Se encarga de llamar a un aplicativo
                      hecho en el framework.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 29/01/2013

     Parametros        Descripcion
     ============      ===================
     isbExecutableName Nombre del aplicativo a instanciar

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     29/01/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Callapplication(isbExecutableName IN sa_executable.name%TYPE) IS

        nuExecutableName sa_executable.executable_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Callapplication', pkg_traza.cnuNivelTrzDef);

        nuExecutableName := sa_boexecutable.fnuGetExecutableIdbyName(isbExecutableName,
                                                                     FALSE);

        IF nuExecutableName IS NOT NULL THEN
            GE_BOIOpenExecutable.SetOnEvent(nuExecutableName, 'POST_REGISTER');
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Callapplication', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Callapplication;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fsbgetdescsubsidyconcept
     Descripcion    : Se encarga de obtener las descripciones de
                      los conceptos a subsidiar para una poblacion
                      determinada.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 01/02/2013

     Parametros        Descripcion
     ============      ===================
     inuUbication      Identificador de la poblacion

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     01/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fsbgetdescsubsidyconcept(inuUbication IN ld_subsidy_detail.subsidy_detail_id%TYPE)
        RETURN VARCHAR2 IS

        sbconcetpdesc VARCHAR2(3000);
        rfconcept     pkConstante.tyRefCursor;
        rfconceptdebt dald_subsidy_detail.styLD_subsidy_detail;
        blexists      BOOLEAN;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fsbgetdescsubsidyconcept', pkg_traza.cnuNivelTrzDef);

        Ld_bcsubsidy.procgetubiconc(inuUbication, rfconcept);

        LOOP
            FETCH rfconcept
                INTO rfconceptdebt;
            EXIT WHEN rfconcept%NOTFOUND;

            blexists := pktblconcepto.fblExist(rfconceptdebt.conccodi);

            /*Consultar si el concepto existe*/
            IF blexists THEN
                /*Obtener la Descripcion*/
                IF sbconcetpdesc IS NULL THEN
                    sbconcetpdesc := pktblconcepto.fsbGetConcdesc(rfconceptdebt.conccodi);
                ELSE
                    sbconcetpdesc := sbconcetpdesc || ', ' ||
                                     pktblconcepto.fsbGetConcdesc(rfconceptdebt.conccodi);
                END IF;
            END IF;

        END LOOP;

        RETURN sbconcetpdesc;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fsbgetdescsubsidyconcept', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fsbgetdescsubsidyconcept;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcGenlettertopotential
     Descripcion    :

     Autor          : jonathan alberto consuegra lara
     Fecha          : 21/12/2012

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     18-Ene-2014      AEcheverrySAO229887   Se modifica la forma de filtrar la informacion
                                              para mejorar el rendimiento
     05-12-2013       hjgomez.SAO226138     Se obtiene solo el id del suscriptor
     21/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcGenlettertopotential IS

        rfPopulation Constants.tyRefCursor;

        clFileContent CLOB;
        --
        nudeal_id       ge_boInstanceControl.stysbValue;
        nusubsidy_id    ge_boInstanceControl.stysbValue;
        nuubication     ge_boInstanceControl.stysbValue;
        nucategoria     ge_boInstanceControl.stysbValue;
        nusubcategoria  ge_boInstanceControl.stysbValue;
        nuValidate      NUMBER;
        nucont          NUMBER;
        nucontpotential NUMBER;
        --
        rctempclob Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuindex    ld_temp_clob_fact.temp_clob_fact_id%TYPE;

        CURSOR cuValidDeal(inuDealId      IN ld_subsidy.deal_id%TYPE,
                           inuSubsidyId   IN ld_subsidy.subsidy_id%TYPE,
                           inuGeogLoca    IN ld_ubication.geogra_location_id%TYPE,
                           inuCategory    IN ld_ubication.sucacate%TYPE,
                           inuSubCategory IN ld_ubication.sucacodi%TYPE) IS
            SELECT /*+  index(s IDX_LD_SUBSIDY01) index(u UDK_UBICATION01) */
             1
            FROM   ld_subsidy   s,
                   ld_ubication u
            WHERE  s.deal_id = inuDealId
            AND    s.subsidy_id = nvl(inuSubsidyId, s.subsidy_id)
            AND    u.subsidy_id = s.subsidy_id
            AND    u.ubication_id =
                   Ld_bosubsidy.Fnugetsububication(s.subsidy_id,
                                                    inuGeogLoca,
                                                    inuCategory,
                                                    inuSubCategory)
            AND    rownum = 1;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ProcGenlettertopotential', pkg_traza.cnuNivelTrzDef);

        /*Obtener datos de la instancia*/
        nudeal_id      := ge_boInstanceControl.fsbGetFieldValue('LD_DEAL',
                                                                'DEAL_ID');
        nusubsidy_id   := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                                'SUBSIDY_ID');
        nuubication    := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                                'GEOGRA_LOCATION_ID');
        nucategoria    := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                                'SUCACATE');
        nusubcategoria := ge_boInstanceControl.fsbGetFieldValue('LD_UBICATION',
                                                                'SUCACODI');

        /*Obtener la plantilla*/
        globalsbTemplate := Ld_Bosubsidy.Fsbgettemplate(ld_boconstans.cnuExtract_Potential);
        IF globalsbTemplate IS NULL THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se encontro la plantilla para el proceso de extraccion y mezcla');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Capturar la sesion de usuario*/
        IF globalsesion IS NULL THEN
            globalsesion := userenv('SESSIONID');
        END IF;

        /*Capturar el subsidio ingresado desde el aplicativo LDGLS*/
        Ld_bosubsidy.globalsubsidy := nusubsidy_id;
        /*Obtener el cursor con los usuarios potenciales*/
        rfPopulation := Ld_Bcsubsidy.FrfGenlettertopotential(nuubication,
                                                             nucategoria,
                                                             nusubcategoria);
        /*Recorrer el cursor con los usuarios potenciales*/
        LOOP
            FETCH rfPopulation
                INTO rfSusc;

            EXIT WHEN rfPopulation%NOTFOUND;

            nuValidate := NULL;

            OPEN cuValidDeal(nudeal_id,
                             nusubsidy_id,
                             rfSusc.Ubication,
                             rfSusc.category,
                             rfSusc.Subcategory);
            FETCH cuValidDeal
                INTO nuValidate;
            CLOSE cuValidDeal;

            IF (nuValidate = 1) THEN

                /*Contador de registros procesados*/
                nucontpotential := nvl(nucontpotential, 0) + 1;

                /*Colocar en memoria al cliente*/
                globalclient := rfSusc.subscriber_id;
                /*Colocar en memoria la ubicacion geografica del cliente*/
                globallocation := rfSusc.ubication;
                /*Colocar en memoria la categoria del cliente*/
                globalcategory := rfSusc.category;
                /*Colocar en memoria la subcategoria del cliente*/
                globalsubcategory := rfSusc.subcategory;

                globaladdressId := rfSusc.address_id;
                /*Inicio de proceso de extraccion y mezcla*/
                clFileContent := Ld_Bosubsidy.Fnusetdatainmemory(ld_boconstans.cnuExtract_Potential);

                IF clFileContent IS NOT NULL THEN
                    /*Guardar los CLOBs en la tabla temporal de CLOBs*/
                    rctempclob := NULL;
                    nuindex    := LD_BOSequence.Fnuseqld_temp_clob_fact;
                    /*Insertar el clob en la entidad ld_temp_clob_fact*/
                    rctempclob.temp_clob_fact_id := nuindex;
                    rctempclob.sesion            := globalsesion;
                    rctempclob.docudocu          := clFileContent;
                    /*Insertar registro en entidad ld_temp_clob_fact*/
                    Dald_Temp_Clob_Fact.insRecord(rctempclob);
                    nucont := nvl(nucont, 0) + 1;
                END IF;
            END IF;
        END LOOP;
        UT_Trace.Trace('fin loop');

        /*Determinar si el cursor arrojo resultados*/
        IF nvl(nucontpotential, 0) = 0 THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se encontro ningun cliente potencial a partir de los patrones de busqueda ingresados');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Si hay CLOBs que procesar entonces se llama al aplicativo .net*/
        IF nucont IS NOT NULL THEN
            IF Ld_Boconstans.csbPotential_letter_app IS NULL THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'Debe configurar el valor de la constante que contiene
                                        el nombre del aplicativo encargado de generar las cartas a potenciales');
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
            /*confirmar transaccion y guardar los clobs en la tabla temporal*/
            COMMIT;
            /*Llamar a la forma que se encarga de ejecutar el proceso de extraccion y mezcla*/
            Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbPotential_letter_app);
        ELSE
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se generaron cartas para los usuarios potenciales');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ProcGenlettertopotential', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcGenlettertopotential;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : procgetallsubsidy
     Descripcion    : Obtiene la Descripcion de todos los
                      subsidios que le apliquen a un cliente
                      y el valor total con la sumatoria
                      de todos ellos a partir de la ubicacion
                      geografica, la categoria y subcategoria
                      del mismo.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 06/02/2013

     Parametros       Descripcion
     ============     ===================
     inusub           Identificador del subsidio
     inuloca          Identificador de la ubicacion geografica
     inucate          Identificador de la categoria
     inusubcate       Identificador de la subcategoria
     osbsubsidydesc   Descripciones de los subsidios
     onuTotalvalue    Sumatoria de los valores de los subsidios

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     06/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE procgetallsubsidy(inusub         ld_subsidy.subsidy_id%TYPE,
                                inuloca        ld_ubication.geogra_location_id%TYPE,
                                inucate        categori.catecodi%TYPE,
                                inusubcate     subcateg.sucacodi%TYPE,
                                osbsubsidydesc OUT VARCHAR2,
                                onuTotalvalue  OUT ld_subsidy.authorize_value%TYPE) IS

        nuubication    ld_ubication.ubication_id%TYPE;
        rfsubsidies    pkConstante.tyRefCursor;
        rfallsubsidies dald_subsidy.styLD_subsidy;
        nuPromotion    ld_subsidy.promotion_id%TYPE;
        nusubsidyvalue ld_subsidy.authorize_value%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.procgetallsubsidy', pkg_traza.cnuNivelTrzDef);

        IF inusub IS NULL THEN
            /*Obtener los subsidios parametrizados*/
            Ld_bcsubsidy.Procgetsubsidies(rfsubsidies);

            LOOP
                FETCH rfsubsidies
                    INTO rfallsubsidies;
                EXIT WHEN rfsubsidies%NOTFOUND;
                /*Obtener el codigo de la ubicacion geografica a subsidiar*/
                nuubication := Ld_bosubsidy.Fnugetsububication(rfallsubsidies.subsidy_id,
                                                               inuloca,
                                                               inucate,
                                                               inusubcate);

                IF nuubication IS NOT NULL THEN
                    /*Limpiar la promocion*/
                    /*Obtener la promocion*/
                    nuPromotion := Dald_Subsidy.fnuGetPromotion_Id(rfallsubsidies.subsidy_id,
                                                                   NULL);
                    /*Limpiar el valor del subsidio*/
                    /*Obtener el valor individual del subsidio*/
                    nusubsidyvalue := Ld_Bosubsidy.FnugetmaxsubsVal(nuPromotion,
                                                                    nuubication,
                                                                    NULL,
                                                                    NULL,
                                                                    ld_boconstans.cnuthreenumber);

                    onuTotalvalue := nvl(onuTotalvalue,
                                         ld_boconstans.cnuCero_Value) +
                                     nvl(nusubsidyvalue,
                                         ld_boconstans.cnuCero_Value);

                    IF nusubsidyvalue IS NOT NULL THEN
                        IF osbsubsidydesc IS NULL THEN
                            osbsubsidydesc := upper(Dald_Subsidy.fsbGetDescription(Dald_Ubication.fnuGetSubsidy_Id(nuubication,
                                                                                                                   NULL),
                                                                                   NULL));
                        ELSE
                            osbsubsidydesc := osbsubsidydesc || ', ' ||
                                              upper(Dald_Subsidy.fsbGetDescription(Dald_Ubication.fnuGetSubsidy_Id(nuubication,
                                                                                                                   NULL),
                                                                                   NULL));
                        END IF;
                    END IF;
                END IF;

            END LOOP;
        ELSE

            /*Obtener el codigo de la ubicacion geografica a subsidiar*/
            nuubication := Ld_bosubsidy.Fnugetsububication(inusub,
                                                           inuloca,
                                                           inucate,
                                                           inusubcate);

            IF nuubication IS NOT NULL THEN
                /*Limpiar la promocion*/
                /*Obtener la promocion*/
                nuPromotion := Dald_Subsidy.fnuGetPromotion_Id(inusub, NULL);
                /*Limpiar el valor del subsidio*/
                /*Obtener el valor individual del subsidio*/
                nusubsidyvalue := Ld_Bosubsidy.FnugetmaxsubsVal(nuPromotion,
                                                                nuubication,
                                                                NULL,
                                                                NULL,
                                                                ld_boconstans.cnuthreenumber);

                onuTotalvalue := nvl(nusubsidyvalue,
                                     ld_boconstans.cnuCero_Value);

                osbsubsidydesc := upper(Dald_Subsidy.fsbGetDescription(Dald_Ubication.fnuGetSubsidy_Id(nuubication,
                                                                                                       NULL),
                                                                       NULL));
            END IF;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.procgetallsubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END procgetallsubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fclgetglobalclob
     Descripcion    : Obtiene el contenido de los clobs obtenidos
                      durante un proceso de extraccion y mezcla

     Autor          : jonathan alberto consuegra lara
     Fecha          : 07/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     07/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fclgetglobalclob RETURN CLOB IS

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fclgetglobalclob', pkg_traza.cnuNivelTrzDef);

        RETURN globalclSubsidy;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fclgetglobalclob', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fclgetglobalclob;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcExportToPDFFromMem
     Descripcion    :

     Autor          : jonathan alberto consuegra lara
     Fecha          : 07/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     07/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcExportToPDFFromMem(isbsource   IN VARCHAR2,
                                     isbfilename IN VARCHAR2,
                                     iclclob     IN ld_temp_clob_fact.docudocu%TYPE) IS
        clclob CLOB;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ProcExportToPDFFromMem', pkg_traza.cnuNivelTrzDef);

        clclob := iclclob;
        UT_Trace.Trace('ProcExportToPDFFromMem -> Template =' ||
                       ld_bosubsidy.globalsbTemplate,
                       15);
        UT_Trace.Trace('AEP_READCLOB RETRO =' || ut_lob.getvarchar2(clclob),
                       15);

        IF ld_bosubsidy.globalsbTemplate IS NOT NULL THEN
            UT_Trace.Trace('clob y template no nulo', pkg_traza.cnuNivelTrzDef);
            id_bogeneralprinting.SetIsDataFromFile(FALSE);
            -- Instancia la plantilla
            pkBOED_DocumentMem.SetTemplate(ld_bosubsidy.globalsbTemplate);
            UT_Trace.Trace('AEP_READCLOB EXPORT =' ||
                           ut_lob.getvarchar2(clclob),
                           15);
            -- Instancia los datos almacenados en un clob
            pkBOED_DocumentMem.Set_PrintDoc(clclob);
            UT_Trace.Trace('ProcExportToPDFFromMem -> despues de colocar CLOB en memoria',
                           15);
            -- Instancia informacion basica para extraccion y mezcla a partir de un archivo XML
            pkBOED_DocumentMem.SetBasicDataExMe(isbsource, isbfilename);
            UT_Trace.Trace('ProcExportToPDFFromMem -> despues pkBOED_DocumentMem.SetBasicDataExMe',
                           15);

        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ProcExportToPDFFromMem', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcExportToPDFFromMem;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procloadtemplateandclob
     Descripcion    : Obtien la plantilla y el clob
                      de los archivos PDF a generar

     Autor          : jonathan alberto consuegra lara
     Fecha          : 08/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     08/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procloadtemplateandclob(inucoempadi ed_confexme.coemcodi%TYPE) IS

        rcTemplate    pktblED_ConfExme.cuEd_Confexme%ROWTYPE;
        nuFormatId    ed_formato.formcodi%TYPE;
        clFileContent CLOB;
        sbTemplate    ed_confexme.coempadi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procloadtemplateandclob', pkg_traza.cnuNivelTrzDef);

        pkBCED_Confexme.ObtieneRegistro(inucoempadi, rcTemplate);
        /* Obtiene el formato*/
        nuFormatId := pkBOInsertMgr.GetCodeFormato(rcTemplate.coempada);
        /*Ejecuta proceso de extraccion de datos para el formato*/
        pkBODataExtractor.ExecuteRules(nuFormatId, clFileContent);
        /*Captura el contenido del clob*/
        globalclSubsidy := clFileContent;
        /*Obtiene el template*/
        sbTemplate := rcTemplate.coempadi;
        /*Captura el template*/
        globalsbTemplate := sbTemplate;
        UT_Trace.Trace('Fin Ld_BoSubsidy.Procloadtemplateandclob', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procloadtemplateandclob;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Insertbillclob
     Descripcion    : Se encarga de almacenar en la entidad
                      ld_temp_clob_fact los CLOB de las facturas
                      asociadas a una serie de solicitudes de
                      venta subsidiada

     Autor          : jonathan alberto consuegra lara
     Fecha          : 18/02/2013

     Parametros       Descripcion
     ============     ===================
     inumo_packages   Identificador de la solicitud
     inuCurrent       Registro actual
     inuTotal         Total de registros a procesar
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     18/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Insertbillclob(inumo_packages  IN mo_packages.package_id%TYPE,
                             inuCurrent      IN NUMBER,
                             inuTotal        IN NUMBER,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2) IS

        rctempclob     Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuExecutableId sa_executable.executable_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Insertbillclob', pkg_traza.cnuNivelTrzDef);

        rctempclob := NULL;

        /*Insertar el clob en la entidad ld_temp_clob_fact*/
        rctempclob.temp_clob_fact_id := LD_BOSequence.Fnuseqld_temp_clob_fact;
        rctempclob.template_id       := NULL;

        /*Capturar la sesion de usuario*/
        IF globalsesion IS NULL THEN
            globalsesion := userenv('SESSIONID');
        END IF;

        rctempclob.sesion     := globalsesion;
        rctempclob.package_id := inumo_packages;

        /*Insertar registro en entidad ld_temp_clob_fact*/
        Dald_Temp_Clob_Fact.insRecord(rctempclob);
        Generatebilldata(onuErrorCode, osbErrorMessage);

        IF onuErrorCode IS NOT NULL AND osbErrorMessage IS NOT NULL THEN
            ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
        END IF;

        IF inuCurrent = inuTotal THEN
            COMMIT;

            /*Obtener ejecutable del .net*/
            nuExecutableId := sa_boexecutable.fnuGetExecutableIdbyName(Ld_Boconstans.csbGen_Sale_Duplicate,
                                                                       FALSE);

            /*Setear componente .net*/
            Ld_Bosubsidy.SetEventPrint(nuExecutableId);

            /*Realizar el llamado a la aplicacion que se encarga de generar los duplicados de factura*/
            Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbGen_Sale_Duplicate);

        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Insertbillclob', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            errors.geterror(onuErrorCode, osbErrorMessage);
            ROLLBACK;
        WHEN OTHERS THEN
            Errors.setError;
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Error insertando la solicitud: ' ||
                               inumo_packages ||
                               ', en la entidad ld_temp_clob_fact';
            ROLLBACK;
    END Insertbillclob;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Generatebilldata
     Descripcion    : Acumula la estructura de las facturas
                      de venta almacenadas en la entidad
                      ld_temp_clob_fact para una sesion de usuario
                      determinada

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/02/2013

     Parametros       Descripcion
     ============     ===================
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
      19-12-2013      lfernandez.SAO227664  Si no existe registro en ed_document
                                            para la factura llama al metodo que
                                            genera el clob ProcessSaleBill
      05-12-2013      sgomez.SAO226167      Se modifica mensaje de excepcion
                                            desplegado cuando la factura no se ha
                                            impreso previamente.

     10/09/2013       mmeusburgger.SAO212354 se modifica para realizar
                                             UPDATE en la tabla <<ld_temp_clob_fact>>
                                             para la generacion del duplicado
     19/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Generatebilldata(onuErrorCode    OUT NUMBER,
                               osbErrorMessage OUT VARCHAR2) IS

        CURSOR cuTemp_Clob(inusession NUMBER) IS
            SELECT l.package_id,
                   l.temp_clob_fact_id
            FROM   ld_temp_clob_fact l
            WHERE  l.sesion = inusession
            AND    l.package_id IS NOT NULL;

        nuConjEquiConfeTipoImpr parametr.pamecodi%TYPE;
        nuPackType              mo_packages.package_type_id%TYPE;
        nuConfexme              ed_confexme.coemcodi%TYPE;
        rcExtMixConf            ed_confexme%ROWTYPE;
        nuFormatCode            ed_formato.formcodi%TYPE;
        nuFactura               cuencobr.cucofact%TYPE;
        nubilldocument          ld_parameter.parameter_id%TYPE;
        clfactclob              CLOB;
        rctempclob              Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuindex                 NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Generatebilldata', pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('ld_bosubsidy.globalsesion = ' ||
                       ld_bosubsidy.globalsesion,
                       10);

        /*Obtener el valor del Parametro = FA_EQUIV_TIP_SOL_CONF_EX_ME*/
        nuConjEquiConfeTipoImpr := daparametr.fnugetpamenume('FA_EQUIV_TIP_SOL_CONF_EX_ME');

        FOR rcTemp_Clob IN cuTemp_Clob(ld_bosubsidy.globalsesion) LOOP

            UT_Trace.Trace('dentro del loop ', pkg_traza.cnuNivelTrzDef);
            /*Obtener tipo de solicitud*/
            nuPackType := damo_packages.fnugetpackage_type_id(rcTemp_Clob.Package_Id,
                                                              NULL);

            UT_Trace.Trace('solicitud = ' || rcTemp_Clob.Package_Id, pkg_traza.cnuNivelTrzDef);

            /*Obtener template*/
            IF (rcExtMixConf.coempadi IS NULL) THEN

                UT_Trace.Trace('nuConjEquiConfeTipoImpr = ' ||
                               nuConjEquiConfeTipoImpr || ' - nuPackType = ' ||
                               nuPackType,
                               10);

                IF (GE_BOEquivalencValues.fblExistEquivTarget(nuConjEquiConfeTipoImpr,
                                                              nuPackType)) THEN

                    /* obtiene el id del confexme a traves de las equivalencias */
                    nuConfexme := GE_BOEquivalencValues.fsbGetTargetValue(nuConjEquiConfeTipoImpr,
                                                                          nuPackType);
                    UT_Trace.Trace('nuConfexme = ' || nuConfexme, pkg_traza.cnuNivelTrzDef);

                    /*Obtiene nombre de plantilla*/
                    rcExtMixConf := pktblED_ConfExme.frcGetRecord(nuConfexme);

                    globalsbTemplate := rcExtMixConf.coempadi;
                    UT_Trace.Trace('rcExtMixConf.coempadi = ' ||
                                   rcExtMixConf.coempadi,
                                   10);

                    IF (rcExtMixConf.coempadi IS NULL) THEN

                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error al buscar el template para realizar la mezcla a partir del identificador: ' ||
                                           nuConfexme ||
                                           ', de la tabla ED_ConfExme';
                        GOTO error;

                    END IF;

                    --  Obtiene el ID del formato a partir del identificador
                    nuFormatCode := pkBOInsertMgr.GetCodeFormato(rcExtMixConf.coempada);

                ELSE

                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'Error al buscar el template para realizar la mezcla';
                    GOTO error;

                END IF;

            END IF;

            /*Obtener la factura asociada a la solicitud*/
            nuFactura := mo_bopackagepayment.fnuGetAccountByPackage(rcTemp_Clob.Package_Id);

            IF nuFactura IS NOT NULL THEN

                /*Obtener el tipo de documento de la factura*/
                nubilldocument := pktblfactura.fnuGetFACTCONS(nuFactura, NULL);

                /*Obtener el clob asociado a la factura*/
                clfactclob := pkBCEd_document.GetDocument(nuFactura,
                                                          nubilldocument);

                --  Si no encontro informacion
                IF (ut_lob.blLobCLOB_IsNULL(clfactclob)) THEN

                    -- Instancia la entidad base solicitud Y padre
                    pkBODataExtractor.InstanceBaseFatherEntity('MO_PACKAGES',
                                                               rcTemp_Clob.Package_Id,
                                                               'FACTURA',
                                                               nuFactura);

                    --  Genera los datos de la factura
                    pkBOPrintingProcess.ProcessSaleBill(nuFormatCode,
                                                        nuFactura,
                                                        pkConstante.SI,
                                                        clfactclob); --out
                END IF;

                rctempclob := NULL;

                nuindex := LD_BOSequence.Fnuseqld_temp_clob_fact;
                /*Insertar el clob en la entidad ld_temp_clob_fact*/
                rctempclob.temp_clob_fact_id := rcTemp_Clob.temp_clob_fact_id;
                rctempclob.sesion            := globalsesion;
                rctempclob.docudocu          := clfactclob;
                /*Insertar registro en entidad ld_temp_clob_fact*/
                Dald_Temp_Clob_Fact.updRecord(rctempclob);

            ELSE

                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La solicitud: ' || rcTemp_Clob.Package_Id ||
                                   ' no posee una factura asociada';
                GOTO error;
            END IF;

            /*Fin obtener CLOB de la solicitud procesada*/
            <<error>>
            NULL;
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Generatebilldata', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Generatebilldata;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcExportBillDuplicateToPDF
     Descripcion    : Genera los archivos PDF de los duplicados de
                      factura

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcExportBillDuplicateToPDF(isbsource   VARCHAR2,
                                           isbfilename VARCHAR2,
                                           iclclob     CLOB) IS

        clclob CLOB;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ProcExportBillDuplicateToPDF', pkg_traza.cnuNivelTrzDef);
        IF ld_bosubsidy.globalsbTemplate IS NOT NULL THEN
            id_bogeneralprinting.SetIsDataFromFile(FALSE);
            UT_Trace.Trace('Template =' || ld_bosubsidy.globalsbTemplate, 15);
            /* Almancena en memoria la plantilla para extraccion y mezcla */
            pkBOED_DocumentMem.SetTemplate(ld_bosubsidy.globalsbTemplate);

        END IF;

        clclob := iclclob;

        IF clclob IS NOT NULL THEN
            /* Almancena en memoria el archivo para el proceso de extraccion y mezcla */
            pkBOED_DocumentMem.Set_PrintDoc(clclob);
            -- Instancia informacion basica para extraccion y mezcla a partir de un archivo XML
            pkBOED_DocumentMem.SetBasicDataExMe(isbsource, isbfilename);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ProcExportBillDuplicateToPDF', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcExportBillDuplicateToPDF;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : SetEventPrint
     Descripcion    : Setea un ejecutable en memoria

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE SetEventPrint(inunuExecutableId sa_executable.executable_id%TYPE) IS

        nuPosInstance  NUMBER;
        nuExecutableId sa_executable.executable_id%TYPE := inunuExecutableId;
        sbEvent        VARCHAR2(100) := 'POST_REGISTER';

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.SetEventPrint', pkg_traza.cnuNivelTrzDef);

        UT_Trace.Trace('SetEventPrint: Event[' || sbEvent || '] Exec[' ||
                       nuExecutableId || ']',
                       15);

        /*  Si no esta inicializada la instancia  */
        IF (NOT GE_BOInstanceControl.fblIsInitInstanceControl) THEN
            GE_BOInstanceControl.InitInstanceManager;
        END IF;

        /*  Si no existe la WORK_INSTANCE */
        IF (NOT GE_BOInstanceControl.fblAcckeyInstanceStack('WORK_INSTANCE',
                                                            nuPosInstance)) THEN
            GE_BOInstanceControl.CreateInstance('WORK_INSTANCE', NULL);
        END IF;

        GE_BOInstanceControl.AddAttribute('WORK_INSTANCE',
                                          NULL,
                                          'IOPENEXECUTABLE',
                                          sbEvent,
                                          nuExecutableId);

        UT_Trace.Trace('Fin Ld_BoSubsidy.SetEventPrint', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END SetEventPrint;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnudebtconcept
     Descripcion    : Obtiene el saldo (deuda corriente + deuda diferida)
                      de un concepto de un contrato (suscripc)

     Autor          : jonathan alberto consuegra lara
     Fecha          : 21/02/2013

     Parametros       Descripcion
     ============     ===================
     inususcripc      identificador del contrato
     inuconcept       identificador del concepto

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     21/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnudebtconcept(inususcripc IN suscripc.susccodi%TYPE,
                            inuconcept  IN concepto.conccodi%TYPE)
        RETURN cargos.cargvalo%TYPE IS

        rfcursor      pkConstante.tyRefCursor;
        nudebtconcept cargos.cargvalo%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnudebtconcept', pkg_traza.cnuNivelTrzDef);
        rfcursor      := Ld_Bcsubsidy.Frfdebtconcept(inususcripc);
        nudebtconcept := LD_BOConstans.cnuCero_Value;

        LOOP
            FETCH rfcursor
                INTO tbdebtconcept;
            EXIT WHEN rfcursor%NOTFOUND;
            IF tbdebtconcept.conceptid = inuconcept THEN
                nudebtconcept := nvl(tbdebtconcept.presentvalue,
                                     LD_BOConstans.cnuCero_Value) +
                                 nvl(tbdebtconcept.deferredvalue,
                                     LD_BOConstans.cnuCero_Value);
                EXIT;
            END IF;
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnudebtconcept', pkg_traza.cnuNivelTrzDef);
        RETURN(nudebtconcept);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnudebtconcept;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procpresentdeferreconcept
     Descripcion    : Obtiene la deuda corriente y diferida
                      de un concepto de un contrato (suscripc)

     Autor          : jonathan alberto consuegra lara
     Fecha          : 21/02/2013

     Parametros       Descripcion
     ============     ===================
     inususcripc      identificador del contrato
     inuconcept       identificador del concepto
     onupresentvalue  Saldo corriente del concepto
     onudeferredvalue Saldo diferente del concepto

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     21/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procpresentdeferreconcept(inususcripc      IN suscripc.susccodi%TYPE,
                                        inuconcept       IN concepto.conccodi%TYPE,
                                        onupresentvalue  OUT cuencobr.cucosacu%TYPE,
                                        onudeferredvalue OUT cuencobr.cucosacu%TYPE) IS

        rfcursor pkConstante.tyRefCursor;
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procpresentdeferreconcept', pkg_traza.cnuNivelTrzDef);
        rfcursor := Ld_Bcsubsidy.Frfdebtconcept(inususcripc);

        LOOP
            FETCH rfcursor
                INTO tbdebtconcept;
            EXIT WHEN rfcursor%NOTFOUND;
            IF tbdebtconcept.conceptid = inuconcept THEN
                onupresentvalue  := tbdebtconcept.presentvalue;
                onudeferredvalue := tbdebtconcept.deferredvalue;
                EXIT;
            END IF;
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procpresentdeferreconcept', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procpresentdeferreconcept;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcRemainingApplies
     Descripcion    : Aplica los remanentes generados por LDREM.

     Autor          : Jorge Luis Valiente Moreno
     Fecha          : 21/02/2013

     Parametros       Descripcion
     ============     ===================
     inuconcept       Concepto de aplicacion del subsidio

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
    ******************************************************************/
    PROCEDURE ProcRemainingApplies(onuerror OUT NUMBER,
                                   osberror OUT VARCHAR2) IS

        CURSOR cuLD_SUB_REMAIN_DELIV IS
            SELECT * FROM LD_SUB_REMAIN_DELIV WHERE STATE_DELIVERY = 'D';

        TYPE tytbSubs IS TABLE OF ld_subsidy.subsidy_id%TYPE INDEX BY BINARY_INTEGER;

        tbSubs    tytbSubs;
        SubsIndex NUMBER;

        nuremainvalue    ld_subsidy.total_deliver%TYPE;
        nuerrorcode      NUMBER;
        sberrormessage   VARCHAR2(3000);
        nupackage_id     mo_packages.package_id%TYPE;
        nucommercialplan mo_motive.commercial_plan_id%TYPE;
        nucontador       NUMBER := ld_boconstans.cnuCero_Value;
        nusesion         NUMBER;
        nuappconc        ld_subsidy.conccodi%TYPE;
        nucause          cargos.cargcaca%TYPE;
        rcubication      dald_ubication.styld_ubication;
        nuassigrecord    DALD_asig_subsidy.styLD_asig_subsidy;
        nuassigsubsidy   ld_asig_subsidy.asig_subsidy_id%TYPE;
        nuusers          NUMBER;
        error_exception EXCEPTION;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ProcRemainingApplies', 1);

        ld_bosubsidy.globaltransfersub := 'Y';

        FOR cuLDSUBREMAINDELIV IN cuLD_SUB_REMAIN_DELIV LOOP

            /*Validar que el subsidio no este cerrado*/
            IF nvl(dald_subsidy.fsbGetRemainder_Status(cuLDSUBREMAINDELIV.SUBSIDY_ID,
                                                       NULL),
                   'XX') = 'CE' THEN
                GOTO salto;
            END IF;

            nucommercialplan := NULL;
            /*Porcion del remanente para un cliente*/
            nuremainvalue := cuLDSUBREMAINDELIV.Delivery_Total;
            /*Solicitud de venta*/
            nupackage_id := dald_asig_subsidy.fnuGetPackage_Id(cuLDSUBREMAINDELIV.Asig_Subsidy_Id,
                                                               NULL);

            IF nupackage_id IS NULL THEN
                GOTO salto;
            END IF;

            /*Obtener el plan comercial asociado a la solicitud*/
            nucommercialplan := damo_motive.fnuGetCommercial_Plan_Id(Ld_Bcsubsidy.Fnugetmotive(nupackage_id,
                                                                                               NULL),
                                                                     NULL);

            IF nucommercialplan IS NULL THEN
                GOTO salto;
            END IF;
            UT_Trace.Trace('Remanente antes de aplicar a cartera corriente ' ||
                           nuremainvalue,
                           10);
            /*******************INICIO SALDO CORRIENTE********************/
            ApplySubInCurrentDebt(nuremainvalue,
                                  cuLDSUBREMAINDELIV.Susccodi,
                                  nucommercialplan,
                                  cuLDSUBREMAINDELIV.Ubication_Id,
                                  cuLDSUBREMAINDELIV.Remain_Value,
                                  nusesion,
                                  nupackage_id,
                                  cuLDSUBREMAINDELIV.Sesunuse,
                                  nuerrorcode,
                                  sberrormessage);

            IF nuerrorcode IS NOT NULL AND sberrormessage IS NOT NULL THEN
                GOTO salto;
            END IF;
            /*******************FIN SALDO CORRIENTE**********************/
            UT_Trace.Trace('Remanente antes de aplicar a diferidos ' ||
                           nuremainvalue,
                           10);
            /*****************INICIO SALDO DIFERIDO*****************/
            /*Si queda valor por repartir se distribuye lo que quede*/
            IF nuremainvalue > ld_boconstans.cnuCero_Value THEN
                ApplySubIndeferredDebt(nuremainvalue,
                                       cuLDSUBREMAINDELIV.Susccodi,
                                       nucommercialplan,
                                       cuLDSUBREMAINDELIV.Ubication_Id,
                                       cuLDSUBREMAINDELIV.Remain_Value,
                                       nusesion,
                                       nupackage_id,
                                       cuLDSUBREMAINDELIV.Sesunuse,
                                       nuerrorcode,
                                       sberrormessage);
            END IF;

            IF nuerrorcode IS NOT NULL AND sberrormessage IS NOT NULL THEN
                GOTO salto;
            END IF;
            /*******************FIN SALDO DIFERIDO********************/

            /*****************INICIO SALDO A FAVOR*****************/
            /*Si queda valor por repartir de la deuda corriente y de la
            deuda diferida*/

            UT_Trace.Trace('antes de saldo a favor ' || nuremainvalue, pkg_traza.cnuNivelTrzDef);
            IF nuremainvalue > ld_boconstans.cnuCero_Value THEN
                /*Se aplica saldo a favor por el valor restante si es el caso*/
                IF ld_boconstans.csbapplybalance = ld_boconstans.csbafirmation THEN

                    UT_Trace.Trace('Se creara saldo a favor', pkg_traza.cnuNivelTrzDef);
                    /*Obtener el concepto de aplicacion del subsidio*/
                    nuappconc := dald_subsidy.fnuGetConccodi(cuLDSUBREMAINDELIV.Subsidy_id,
                                                             NULL);

                    IF nuappconc IS NULL THEN
                        ROLLBACK;
                        nuerrorcode    := ld_boconstans.cnuGeneric_Error;
                        sberrormessage := 'No existe concepto de aplicacion configurado al subsidio ' ||
                                          dald_ubication.fnuGetSubsidy_Id(cuLDSUBREMAINDELIV.UBICATION_ID,
                                                                          NULL);
                        GOTO salto;
                    END IF;

                    /*Obtener la causa para el cargo*/
                    nucause := ld_boconstans.cnusubchargecause;

                    IF nucause IS NULL THEN
                        ROLLBACK;
                        nuerrorcode    := ld_boconstans.cnuGeneric_Error;
                        sberrormessage := 'No existe causa de cargo configurada en el parametro CHARGE_SUBSIDY_CAUSE';
                        GOTO salto;
                    END IF;

                    /*Aplicar saldo a favor*/
                    pkerrors.setapplication(ld_boconstans.csbRemain_Sub_App);

                    UT_Trace.Trace('Se genera cargo para saldo a favor por valor de ' ||
                                   nuremainvalue,
                                   10);

                    pkChargeMgr.GenerateCharge(cuLDSUBREMAINDELIV.Sesunuse,
                                               ld_boconstans.cnuallrows,
                                               nuappconc,
                                               nucause,
                                               nuremainvalue,
                                               'CR',
                                               'PP-' || nupackage_id,
                                               'A',
                                               ld_boconstans.cnuCero_Value,
                                               NULL,
                                               NULL,
                                               NULL,
                                               FALSE,
                                               SYSDATE);

                    /*Si se aplica saldo a favor el restante queda en cero. Es decir, se repartio
                    todo el remanente*/
                    nuremainvalue := 0;
                END IF;
            END IF;

            UT_Trace.Trace('restante despues de saldo a favor ' ||
                           nuremainvalue,
                           10);

            IF nuremainvalue = ld_boconstans.cnuCero_Value THEN
                /*Si el salgo es cero es que se repartio todo*/
                nuremainvalue := cuLDSUBREMAINDELIV.Delivery_Total;
            ELSE
                nuremainvalue := cuLDSUBREMAINDELIV.Delivery_Total -
                                 nuremainvalue;
            END IF;

            UT_Trace.Trace('Valor asignado ' || nuremainvalue, pkg_traza.cnuNivelTrzDef);

            IF nuremainvalue > ld_boconstans.cnuCero_Value THEN

                /*Obtener datos de la poblacion*/
                DALD_ubication.LockByPkForUpdate(cuLDSUBREMAINDELIV.Ubication_Id,
                                         rcubication);

                /*Balanceo de subsidio*/
                ld_bosubsidy.Procbalancesub(cuLDSUBREMAINDELIV.Subsidy_Id,
                                            rcubication,
                                            nuremainvalue,
                                            ld_boconstans.cnuonenumber);

                /*Generar registro en LD_ASIG_SUBSIDY*/
                /*Obtener el numero de registro para la entidad en donde se almacenan los subsidios asignados*/
                nuassigsubsidy := LD_BOSequence.fnuSeqAssigsub;
                /*Registrar asignacion del subsidio*/
                nuassigrecord.asig_subsidy_id := nuassigsubsidy;
                nuassigrecord.susccodi        := cuLDSUBREMAINDELIV.Susccodi;
                nuassigrecord.subsidy_id      := cuLDSUBREMAINDELIV.Subsidy_Id;
                nuassigrecord.promotion_id    := dald_subsidy.fnuGetPromotion_Id(cuLDSUBREMAINDELIV.Subsidy_Id);
                nuassigrecord.subsidy_value   := nuremainvalue;

                /*orden de entrega de los documentos*/
                nuassigrecord.order_id := DALD_ASIG_SUBSIDY.fnuGetOrder_Id(cuLDSUBREMAINDELIV.Asig_Subsidy_Id);
                /*documentos entregados en su totalidad*/
                nuassigrecord.delivery_doc := DALD_ASIG_SUBSIDY.fsbGetDelivery_Doc(cuLDSUBREMAINDELIV.Asig_Subsidy_Id);
                /*estado del subsidio, 2: por cobrar*/
                nuassigrecord.state_subsidy := LD_BOCONSTANS.cnureceivablestate;
                /*Entregado por venta*/
                nuassigrecord.type_subsidy := 'RE';
                /*Solicitud de venta*/
                nuassigrecord.package_id  := nupackage_id;
                nuassigrecord.insert_date := SYSDATE;
                /*Fecha en estado cobro*/
                nuassigrecord.receivable_date := SYSDATE;
                /*fecha en estado cobrado*/
                nuassigrecord.collect_date := NULL;
                /*fecha en estado pagado*/
                nuassigrecord.pay_date := NULL;
                /*acta de cobro*/
                nuassigrecord.record_collect := NULL;
                /*Poblacion a subdidiar*/
                nuassigrecord.ubication_id := cuLDSUBREMAINDELIV.Ubication_Id;
                Dald_Asig_Subsidy.insRecord(nuassigrecord);

                nucontador := nucontador + ld_boconstans.cnuonenumber;

            END IF;

            /*Actualizar Valor Distribuido*/
            daLD_SUB_REMAIN_DELIV.updDelivery_Total(cuLDSUBREMAINDELIV.Sub_Remain_Deliv_Id,
                                                    nuremainvalue);

            dald_sub_remain_deliv.updState_Delivery(cuLDSUBREMAINDELIV.SUB_REMAIN_DELIV_ID,
                                                    'P');

            tbSubs(cuLDSUBREMAINDELIV.Subsidy_Id) := cuLDSUBREMAINDELIV.Subsidy_Id;

            <<salto>>
            NULL;
        END LOOP;

        IF nucontador > ld_boconstans.cnuCero THEN
            nuerrorcode    := ld_boconstans.cnuCero;
            sberrormessage := 'Se aplico el remanente del subsidio a ' ||
                              nucontador || ' usuarios';
            onuerror       := nuerrorcode;
            osberror       := sberrormessage;

            IF tbSubs.count > 0 THEN
                SubsIndex := tbSubs.first;
                WHILE SubsIndex IS NOT NULL LOOP
                    dald_subsidy.updRemainder_Status(SubsIndex, 'AP');
                    SubsIndex := tbSubs.next(SubsIndex);
                END LOOP;
            END IF;

        ELSE
            nuerrorcode    := ld_boconstans.cnuCero;
            sberrormessage := 'Se aplico el remanente del subsidio a ' ||
                              nucontador || ' usuarios';
            onuerror       := nuerrorcode;
            osberror       := sberrormessage;
            ROLLBACK;
        END IF;

        <<error>>
        NULL;

        IF nuerrorcode <> ld_boconstans.cnuCero THEN
            RAISE error_exception;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ProcRemainingApplies', 1);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN error_exception THEN
            onuerror := nuerrorcode;
            osberror := sberrormessage;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcRemainingApplies;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnudebtpresentcuencobr
     Descripcion    : Determina la cuenta de cobro de la deuda
                      corriente de un cliente

     Autor          : jonathan alberto consuegra lara
     Fecha          : 22/02/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     22/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnudebtpresentcuencobr(inususcripc IN suscripc.susccodi%TYPE)
        RETURN cuencobr.cucocodi%TYPE IS

        CURSOR cuCuencobr(inucontract suscripc.susccodi%TYPE) IS
            SELECT /*+
                                                                                                                                                                                                    ORDERED
                                                                                                                                                                                                    use_nl    (servsusc cuencobr)
                                                                                                                                                                                                    index_rs  (servsusc IX_SERVSUSC12)
                                                                                                                                                                                                    index_rs  (cuencobr IX_CUENCOBR09 )
                                                                                                                                                                                                    */
             c.cucocodi,
             c.cucofeve,
             c.cucofepa
            FROM   servsusc s,
                   cuencobr c
            WHERE  s.sesuserv = Ld_Boconstans.cnuGasService
            AND    s.sesususc = inucontract
            AND    c.cuconuse = s.sesunuse
            AND    c.cucosacu > Ld_Boconstans.cnuCero_Value
            ORDER  BY c.cucofeve DESC;

        nucuencobr cuencobr.cucocodi%TYPE;
        rcCuencobr cuCuencobr%ROWTYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnudebtpresentcuencobr', pkg_traza.cnuNivelTrzDef);

        OPEN cuCuencobr(inususcripc);
        FETCH cuCuencobr
            INTO rcCuencobr;
        CLOSE cuCuencobr;

        IF rcCuencobr.Cucofepa IS NOT NULL THEN
            nucuencobr := rcCuencobr.Cucocodi;
        END IF;

        IF nucuencobr IS NULL THEN
            IF rcCuencobr.Cucofepa IS NULL AND SYSDATE <= rcCuencobr.Cucofeve THEN

                nucuencobr := rcCuencobr.Cucocodi;

            END IF;
        END IF;

        RETURN(nucuencobr);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnudebtpresentcuencobr', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnudebtpresentcuencobr;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuReturnConcept
     Descripcion    : Obtiene el concepto del subsidio creado

     Autor          : Jorge Valiente
     Fecha          : 24/02/2013

     Parametros       Descripcion
     ============     ===================
     inusubsidy_id    codigo del subsidio para obtener el concepto

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
    ******************************************************************/
    FUNCTION FnuReturnConcept(inusubsidy_id IN ld_subsidy.subsidy_id%TYPE)
        RETURN ld_subsidy.conccodi%TYPE IS

        nuconccodi ld_subsidy.conccodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.FnuReturnConcept', pkg_traza.cnuNivelTrzDef);

        nuconccodi := dald_subsidy.fnuGetConccodi(inusubsidy_id, NULL);
        IF nuconccodi IS NULL THEN
            nuconccodi := 0;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.FnuReturnConcept', pkg_traza.cnuNivelTrzDef);

        RETURN(nuconccodi);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            --raise pkg_error.CONTROLLED_ERROR;
            RETURN(0);
        WHEN OTHERS THEN
            Errors.setError;
            --raise pkg_error.CONTROLLED_ERROR;
            RETURN(0);
    END FnuReturnConcept;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FsbGetProcTypeRemSu
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
    FUNCTION FsbGetProcTypeRemSu(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                                 inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                                 inuSession    IN ld_sub_remain_deliv.sesion%TYPE,
                                 inuRaiseError IN NUMBER DEFAULT 1)
        RETURN ld_subsidy.description%TYPE IS

        sbDescription ld_subsidy.description%TYPE;

    BEGIN

        UT_Trace.Trace('Inicia Ld_BoSubsidy.FsbGetProcTypeRemSu', pkg_traza.cnuNivelTrzDef);

        sbDescription := Ld_BcSubsidy.FsbGetProcTypeRemSub(inuSubsidy_id,
                                                           inuUbication,
                                                           inuSession,
                                                           NULL);

        UT_Trace.Trace('Fin Ld_BoSubsidy.FsbGetProcTypeRemSu', pkg_traza.cnuNivelTrzDef);

        IF (sbDescription = ld_boconstans.csbRemainder_Distribute) THEN
            sbDescription := sbDescription || ' - DISTRIBUIR';
            RETURN sbDescription;
        ELSE
            sbDescription := sbDescription || ' - SIMULAR';
            RETURN sbDescription;
        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END FsbGetProcTypeRemSu;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuGetContSubRemSt
     Descripcion    : Obtiene el numero total de los
                      subsidios remanentes por estado.

     Autor          : Evens Herard Gorut
     Fecha          : 22/02/2013

     Parametros       Descripcion
     ============     ===================
     inuSubsidy_id    subsidio
     inuUbication_id  Ubicacion
     inuSession       session de oracle
     inuStateVeri     Estado a consultar
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                            como filtro en los reportes de remanentes.
     22/02/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FnuGetContSubRemSt(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                                inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                                inuStateVeri  VARCHAR2,
                                inuRaiseError IN NUMBER DEFAULT 1) RETURN NUMBER IS
        nuContSubRem NUMBER;
    BEGIN
        UT_Trace.Trace('Inicia Ld_BoSubsidy.FnuGetContSubRemSt', pkg_traza.cnuNivelTrzDef);
        IF inuStateVeri = 'A' THEN
            nuContSubRem := ld_bcsubsidy.FnuGetContSubRemAn(inuSubsidy_id,
                                                            inuUbication,
                                                            NULL);
        END IF;

        IF inuStateVeri = 'D' THEN
            nuContSubRem := ld_bcsubsidy.FnuGetContSubRemDi(inuSubsidy_id,
                                                            inuUbication,
                                                            NULL);
        END IF;

        IF inuStateVeri = 'P' THEN

            nuContSubRem := ld_bcsubsidy.FnuGetContSubRemPr(inuSubsidy_id,
                                                            inuUbication,
                                                            NULL);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.FnuGetContSubRemSt', pkg_traza.cnuNivelTrzDef);

        RETURN nuContSubRem;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END FnuGetContSubRemSt;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuGetSumSubRemSt
     Descripcion    : Obtiene el valor total de los
                      subsidios remanentes distribuidos por estado.

     Autor          : Evens Herard Gorut
     Fecha          : 23/01/2013

     Parametros       Descripcion
     ============     ===================
     inuSubsidy_id    subsidio
     inuUbication_id  Ubicacion
     inuSession       session de oracle
     inuStateVeri     Estado a Verificar
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                            como filtro en los reportes de remanentes.
     23/01/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FnuGetSumSubRemSt(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                               inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                               inuStateVeri  VARCHAR2,
                               inuRaiseError IN NUMBER DEFAULT 1)
        RETURN ld_sub_remain_deliv.delivery_total%TYPE IS

        nuValSumSubRem ld_sub_remain_deliv.delivery_total%TYPE;

    BEGIN

        UT_Trace.Trace('Inicia Ld_BcSubsidy.FnuGetSumSubRemSt', pkg_traza.cnuNivelTrzDef);

        IF inuStateVeri = 'A' THEN
            nuValSumSubRem := ld_bcsubsidy.FnuGetSumSubRemAn(inuSubsidy_id,
                                                             inuUbication,
                                                             NULL);

        END IF;

        IF inuStateVeri = 'D' THEN
            nuValSumSubRem := ld_bcsubsidy.FnuGetSumSubRemDi(inuSubsidy_id,
                                                             inuUbication,
                                                             NULL);

        END IF;

        IF inuStateVeri = 'P' THEN
            nuValSumSubRem := ld_bcsubsidy.FnuGetSumSubRemPr(inuSubsidy_id,
                                                             inuUbication,
                                                             NULL);
        END IF;

        UT_Trace.Trace('Fin Ld_BcSubsidy.FnuGetSumSubRemSt', pkg_traza.cnuNivelTrzDef);

        RETURN nuValSumSubRem;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END FnuGetSumSubRemSt;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FnuGetValAsigByState
     Descripcion    : Obtiene el valor remanente asignado a los
                      clientes que ya han recibido un subsidio
                      determinado.

     Autor          : Evens Herard Gorut
     Fecha          : 22/02/2013

     Parametros       Descripcion
     ============     ===================
     inuSubsidy_id    subsidio
     inuUbication_id  Ubicacion
     inuSession       session de oracle
     inuStateVeri
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     17/12/2013       jrobayo.SAO22227371   Se modifica para omitir el id de la sesion
                                            como filtro en los reportes de remanentes.
     22/02/2013       eherard.SAO156577     Creacion
    ******************************************************************/
    FUNCTION FnuGetValAsigByState(inuSubsidy_id IN ld_subsidy.subsidy_id%TYPE,
                                  inuUbication  IN ld_sub_remain_deliv.ubication_id%TYPE,
                                  inuStateVeri  VARCHAR2,
                                  inuRaiseError IN NUMBER DEFAULT 1) RETURN NUMBER IS

        nuNuse         NUMBER;
        nuValDisSingle NUMBER;
        nuValAsigBySt  NUMBER;

    BEGIN

        UT_Trace.Trace('Inicia Ld_BoSubsidy.FnuGetValAsigByState', pkg_traza.cnuNivelTrzDef);

        IF (inuStateVeri = 'A') THEN

            /*Cantidad servicios suscritos asignados de los registros en estado distribuido*/
            nuNuse := nvl(ld_bosubsidy.FnuGetContSubRemSt(inuSubsidy_id,
                                                          inuUbication,
                                                          'A',
                                                          NULL),
                          0);

            /*Valor distribuido entre los registros en estado distribuido*/
            nuValDisSingle := nvl(ld_bosubsidy.FnuGetSumSubRemSt(inuSubsidy_id,
                                                                 inuUbication,
                                                                 'A',
                                                                 NULL),
                                  0);
            nuValAsigBySt  := nuNuse * nuValDisSingle;
        END IF;

        IF (inuStateVeri = 'D') THEN
            /*Cantidad servicios suscritos asignados de los registros en estado distribuido*/
            nuNuse := nvl(ld_bosubsidy.FnuGetContSubRemSt(inuSubsidy_id,
                                                          inuUbication,
                                                          'D',
                                                          NULL),
                          0);

            /*Valor distribuido entre los registros en estado distribuido*/
            nuValDisSingle := nvl(ld_bosubsidy.FnuGetSumSubRemSt(inuSubsidy_id,
                                                                 inuUbication,
                                                                 'D',
                                                                 NULL),
                                  0);
            nuValAsigBySt  := nuNuse * nuValDisSingle;
        END IF;

        IF (inuStateVeri = 'P') THEN

            /*Cantidad servicios suscritos asignados de los registros en estado distribuido*/
            nuNuse := nvl(ld_bosubsidy.FnuGetContSubRemSt(inuSubsidy_id,
                                                          inuUbication,
                                                          'P',
                                                          NULL),
                          0);

            /*Valor distribuido entre los registros en estado distribuido*/
            nuValDisSingle := nvl(ld_bosubsidy.FnuGetSumSubRemSt(inuSubsidy_id,
                                                                 inuUbication,
                                                                 'P',
                                                                 NULL),
                                  0);
            nuValAsigBySt  := nuNuse * nuValDisSingle;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.FnuGetValAsigByState', pkg_traza.cnuNivelTrzDef);

        RETURN nuValAsigBySt;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF inuRaiseError = 1 THEN
                Errors.setError;
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END FnuGetValAsigByState;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Proc ialsegmenpromo
       Descripcion    : Se encarga de realizar la segmentacion comercial de
                        una promocion de tipo subsidio

       Autor          : jonathan alberto consuegra lara
       Fecha          : 13/03/2013

       Parametros       Descripcion
       ============     ===================
       inusubsidyid     identificador del subsidio
       inupromoid       identificador de la promocion
       inuubication     identificador de la poblacion a subsidiar
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       13/03/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE Proccommercialsegmenpromo(inusubsidyid ld_subsidy.subsidy_id%TYPE,
                                        inupromoid   cc_promotion.promotion_id%TYPE,
                                        inuubication ld_ubication.geogra_location_id%TYPE,
                                        inucategory  ld_ubication.sucacate%TYPE,
                                        inusubcateg  ld_ubication.sucacodi%TYPE) IS

        nuErrorCode    NUMBER;
        sbErrorMessage VARCHAR2(4000);
        iclXml         CLOB;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Proccommercialsegmenpromo', pkg_traza.cnuNivelTrzDef);

        iclXml := '<Segmentation xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <Id />
              <Description>SEGMENTO SUBSIDIO ' || inusubsidyid ||
                  '</Description>
              <IsModified>true</IsModified>
              <DemographicFeatures />
              <GeographicFeatures>
                     <GeographicCriterion>
                             <Id />
                             <RowIndex>0</RowIndex>
                             <State>New</State>
                             <GeographLocation>
                                     <Key>' || inuubication ||
                  '</Key>
                                     <Text>Ubicacion subsidiada</Text>
                             </GeographLocation>
                             <InitialNumber />
                             <FinalNumber />
                             <Category>' || inucategory ||
                  '</Category>
                             <Subcategory>' || inusubcateg ||
                  '</Subcategory>
                     </GeographicCriterion>
              </GeographicFeatures>
              <FinancialFeatures />
              <CommercialFeatures />
              <CommercialPlanOffers />
              <FinancialPlanOffers />
              <PromotionOffers>
                     <PromotionOffer>
                             <Id />
                             <Promo>
                                     <Key>' || inupromoid ||
                  '</Key>
                                     <Text>Promocion ' ||
                  inupromoid || '</Text>
                             </Promo>
                             <OfferClass>1</OfferClass>
                             <RowIndex>0</RowIndex>
                             <State>New</State>
                     </PromotionOffer>
              </PromotionOffers>
              <DemogFeatsToDelete />
              <GeograpFeatsToDelete />
              <FinanFeatsToDelete />
              <CommerFeatsToDelete />
              <CommerPlanOfferToDelete />
              <FinanPlanOfferToDelete />
              <PromoOfferToDelete />
      </Segmentation>';

        os_setcommercialsegment(iclXml, nuErrorCode, sbErrorMessage);

        UT_Trace.Trace('Fin Ld_BoSubsidy.Proccommercialsegmenpromo', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Proccommercialsegmenpromo;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetglobalsesion
     Descripcion    : Obtiene la sesion de usuario

     Autor          : jonathan alberto consuegra lara
     Fecha          : 14/03/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     14/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetglobalsesion RETURN NUMBER IS

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetglobalsesion', pkg_traza.cnuNivelTrzDef);

        /*Capturar la sesion de usuario*/
        IF globalsesion IS NULL THEN
            globalsesion := userenv('SESSIONID');
        END IF;

        RETURN globalsesion;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetglobalsesion', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetglobalsesion;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetsalevalue
     Descripcion    : Obtiene el valor de una solicitud de venta

     Autor          : jonathan alberto consuegra lara
     Fecha          : 18/03/2013

     Parametros       Descripcion
     ============     ===================
     inupackages_id   Identificador de la solicitud de venta
     inuRaiseError    controlador de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     18/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetsalevalue(inupackages_id IN mo_packages.package_id%TYPE,
                             inuRaiseError  IN NUMBER DEFAULT 1)
        RETURN cuencobr.cucovafa%TYPE IS

        rcCuencobr    cuencobr%ROWTYPE;
        nusesunuse    servsusc.sesunuse%TYPE;
        nuInstallBill factura.factcodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetsalevalue', pkg_traza.cnuNivelTrzDef);

        /*Se obtiene la factura de venta generada*/
        nuInstallBill := mo_bopackagepayment.fnuGetAccountByPackage(inupackages_id);

        /*Obtener el producto GAS, servicio suscrito, del contrato
        asociado a la solicitud*/
        nusesunuse := Ld_Bcsubsidy.Fnugetsesunuse(inupackages_id, NULL);

        IF (nusesunuse IS NOT NULL) THEN
            /*Se valida que la venta haya generado factura*/
            IF (nuInstallBill IS NOT NULL) THEN
                rcCuencobr := pkBCCuencobr.frcGetAccByProdBill(nuInstallBill,
                                                               nusesunuse);
            END IF;
        END IF;

        RETURN rcCuencobr.cucovafa;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetsalevalue', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END Fnugetsalevalue;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procenabledseg
     Descripcion    : Inhabilita las segmentaciones comerciales
                      asociadas a un subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013

     Parametros       Descripcion
     ============     ===================
     inusubsidy       Identificador del subsidio

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procenabledseg(inusubsidy IN ld_subsidy.subsidy_id%TYPE) IS

        CURSOR subsidysegment IS

            SELECT c.commercial_segm_id
            FROM   cc_commercial_segm c
            WHERE  Ld_bosubsidy.fsbobcadsep(c.name,
                                            ' ',
                                            REGEXP_COUNT(c.name, ' ', 1, 'i') + 1) =
                   to_char(inusubsidy);

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procenabledseg', pkg_traza.cnuNivelTrzDef);

        FOR rgsubsidysegment IN subsidysegment LOOP
            dacc_commercial_segm.updActive(rgsubsidysegment.commercial_segm_id,
                                           'N');
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procenabledseg', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procenabledseg;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbObCadSep
     Descripcion    : Obtiene la cadena que se encuentra a partir
                      del numero de ocurrencia de un delimitador

     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013

     Parametros       Descripcion
     ============     ===================
     isbCad           Cadena
     isbDel           Delimitador
     inuIn            Numero de ocurrencia del delimitador

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbObCadSep(isbCad IN VARCHAR2,
                         isbDel IN VARCHAR2,
                         inuIn  IN NUMBER) RETURN VARCHAR2 DETERMINISTIC IS

        sbCad VARCHAR2(500);

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fsbObCadSep', pkg_traza.cnuNivelTrzDef);

        sbCad := RTRIM(REGEXP_SUBSTR(IsbCad || IsbDel,
                                     '.*?\' || IsbDel,
                                     1,
                                     InuIn),
                       IsbDel);

        RETURN sbCad;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fsbObCadSep', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbObCadSep;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Procdeletepromdetails
     Descripcion    : Elimina los detalles de una promocion

     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013

     Parametros       Descripcion
     ============     ===================
     inupromo         Identificador de la promocion

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procdeletepromdetails(inupromo IN cc_promotion.promotion_id%TYPE) IS
        CURSOR promodetails IS
            SELECT c.prom_detail_id
            FROM   CC_PROM_DETAIL c
            WHERE  c.promotion_id = inupromo;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Procdeletepromdetails', pkg_traza.cnuNivelTrzDef);

        FOR rgpromodetails IN promodetails LOOP

            daCC_PROM_DETAIL.delRecord(rgpromodetails.prom_detail_id);

        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Procdeletepromdetails', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procdeletepromdetails;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fsbgetremainstatusdesc
     Descripcion    : Obtiene la Descripcion del estado del remanente de
                      un subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 11/04/2013

     Parametros       Descripcion
     ============     ===================
     isbstatus        Estado del remanente de un subsidio

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     11/04/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbgetremainstatusdesc(isbstatus IN VARCHAR2) RETURN VARCHAR2 IS
        sbstatusdesc VARCHAR2(100);

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fsbgetremainstatusdesc', pkg_traza.cnuNivelTrzDef);

        IF isbstatus = 'AB' THEN
            sbstatusdesc := 'Abierto';
        END IF;

        IF isbstatus = 'DI' THEN
            sbstatusdesc := 'Distribuido';
        END IF;

        IF isbstatus = 'AP' THEN
            sbstatusdesc := 'Aplicado';
        END IF;

        IF isbstatus = 'CE' THEN
            sbstatusdesc := 'Cerrado';
        END IF;

        IF isbstatus = 'SI' THEN
            sbstatusdesc := 'Simulacion';
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fsbgetremainstatusdesc', pkg_traza.cnuNivelTrzDef);

        RETURN(sbstatusdesc);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbgetremainstatusdesc;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnuGasProductInstalled
     Descripcion    : Determina si el producto GAS de un contrato ha
                      sido instalado. Si el servicio retorna 1
                      entonces el producto esta instaladado. En caso
                      de retornar 0 esta pendiente por instalar.


     Autor          : jonathan alberto consuegra lara
     Fecha          : 08/05/2013

     Parametros       Descripcion
     ============     ===================
     inuSubscription  Identificador del contrato

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     08/05/2013       jconsuegra.DAA156577  Creacion
    ******************************************************************/
    FUNCTION fnuGasProductInstalled(inuSubscription suscripc.susccodi%TYPE)
        RETURN NUMBER IS

        nuGasProduct     pr_product.product_id%TYPE;
        nuTechnicalState pr_product.product_status_id%TYPE;
        nuNoinstalled    ld_parameter.numeric_value%TYPE;
        nuanswer         NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnuGasProductInstalled', pkg_traza.cnuNivelTrzDef);

        nuanswer := ld_boconstans.cnuonenumber;
        /*Obtiene el identificador del producto GAS*/
        nuGasProduct := ld_bcsubsidy.Fnugetsesunuse(inuSubscription, NULL);
        /*Obtener estado tecnico del producto*/
        nuTechnicalState := dapr_product.fnugetproduct_status_id(nuGasProduct,
                                                                 NULL);
        /*Obtener el identificador del estado del producto-> pendiente por instalacion*/
        nuNoinstalled := Dald_parameter.fnuGetNumeric_Value('NO_INSTALL_STATUS');

        IF NuTechnicalState = nuNoinstalled THEN
            nuanswer := ld_boconstans.cnuCero_Value;
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fnuGasProductInstalled', pkg_traza.cnuNivelTrzDef);

        RETURN(nuanswer);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnuGasProductInstalled;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : fnugetsuscbypackages
     Descripcion    : Determina la suscripcion asociada a una solicitud
                      de instalacion.

     Autor          : jonathan alberto consuegra lara
     Fecha          : 28/05/2013

     Parametros       Descripcion
     ============     ===================
     inupackages      Identificador de la solicitud

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     28/05/2013       jconsuegra.DAA156577  Creacion
    ******************************************************************/
    FUNCTION fnugetsuscbypackages(inupackages mo_packages.package_id%TYPE)
        RETURN mo_motive.subscription_id%TYPE IS

        CURSOR cumo_motive(inumotype mo_motive.motive_type_id%TYPE) IS
            SELECT v.subscription_id
            FROM   mo_packages m,
                   mo_motive   v
            WHERE  m.package_id = v.package_id
            AND    v.package_id = inupackages
            AND    v.motive_type_id = inumotype;

        nususcripc       mo_motive.subscription_id%TYPE;
        nuinstall_motive ld_parameter.numeric_value%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnugetsuscbypackages', pkg_traza.cnuNivelTrzDef);
        /*Obtener el identificador del motivo de instalacion de producto*/
        nuinstall_motive := Dald_parameter.fnuGetNumeric_Value('INSTALATION_MOTIVE');

        FOR rgcumo_motive IN cumo_motive(nuinstall_motive) LOOP
            nususcripc := rgcumo_motive.subscription_id;
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.fnugetsuscbypackages', pkg_traza.cnuNivelTrzDef);

        RETURN(nususcripc);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnugetsuscbypackages;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcAssigSubByForm
      Descripcion    : Registra los subsidios a partir de las promociones
                       de tipo subsidios ingresadas en la venta por
                       formulario

      Autor          : jonathan alberto consuegra lara
      Fecha          : 29/05/2013

      Parametros       Descripcion
      ============     ===================
      inupackages_id   identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      29/05/2013       jconsuegra.SAO156577  Creacion
      25/03/2014       JRealpe SAO236359  se modifica <ProcAssigSubByForm>
                       Se instancia producto y plan de facturacion
    ******************************************************************/
    PROCEDURE ProcAssigSubByForm(inupackages_id mo_packages.package_id%TYPE) IS

        CURSOR cuPromo IS
            SELECT mo_mot_promotion.promotion_id,
                   mo_motive.subscription_id
            FROM   mo_motive,
                   mo_mot_promotion,
                   cc_promotion
            WHERE  mo_motive.PACKAGE_id = inupackages_id
            AND    mo_motive.motive_type_id =
                   (SELECT l.numeric_value
                     FROM   ld_parameter l
                     WHERE  l.parameter_id = 'INSTALATION_MOTIVE')
            AND    mo_mot_promotion.motive_id = mo_motive.motive_id
            AND    mo_mot_promotion.promotion_id = cc_promotion.promotion_id
            AND    cc_promotion.prom_type_id =
                   (SELECT l.numeric_value
                     FROM   ld_parameter l
                     WHERE  l.parameter_id = 'SUB_PROM_TYPE')
            AND    mo_mot_promotion.active = 'Y';

        --Cursor que retorna el codigo de producto y plan de facturacion
        CURSOR cu_instanciadatos_(pkg_ NUMBER) IS
            SELECT p.sesunuse,
                   p.sesuplfa
            FROM   mo_motive m,
                   servsusc  p
            WHERE  PACKAGE_id = pkg_
            AND    p.sesunuse = m.product_id;

        --
        nuprod   NUMBER;
        planfact NUMBER;

        nurows     NUMBER;
        nupromtype cc_promotion.prom_type_id%TYPE;
        nusubpromo NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.ProcAssigSubByForm', pkg_traza.cnuNivelTrzDef);
        nurows         := ld_boconstans.cnuCero_Value;
        nusubpromo     := ld_boconstans.cnuCero_Value;
        nuswsalebyform := ld_boconstans.cnutwonumber;

        --{
        -- recupera codigo de prodcuto y plan de facturacion
        OPEN cu_instanciadatos_(inupackages_id);
        FETCH cu_instanciadatos_
            INTO nuprod,
                 planfact;
        CLOSE cu_instanciadatos_;

        -- instancia numero de producto
        ta_bocriteriosbusqueda.EstCriterioMemoria(TA_BCCriteriosbusqueda.fsbPRODUCTO,
                                                  nuprod);
        -- Instancia numero plan de facturacion
        ta_bocriteriosbusqueda.EstCriterioMemoria(TA_BCCriteriosbusqueda.fsbPLANFACT,
                                                  planfact);
        --}

        FOR rgcuPromo IN cuPromo LOOP

            /*Asignar subsidio por la promocion registrada durante la venta*/
            Assignsubsidy(rgcuPromo.Subscription_Id,
                          rgcuPromo.Promotion_Id,
                          NULL,
                          NULL,
                          NULL,
                          ld_boconstans.csbGASSale,
                          inupackages_id);

            nurows := nurows + ld_boconstans.cnuonenumber;
            /*Determinar si al menos una de las promociones es subsidiada*/
            nupromtype := Dacc_Promotion.fnuGetProm_Type_Id(rgcuPromo.Promotion_Id,
                                                            NULL);

            IF nvl(nupromtype, ld_boconstans.cnuallrows) =
               ld_boconstans.cnuPromotionType THEN
                nusubpromo := nusubpromo + ld_boconstans.cnuonenumber;
            END IF;
        END LOOP;

        nuswsalebyform := NULL;

        /*Si no se registraron promociones o ninguna de ellas fue subsidiada
        se guarda la solicitud para que este pendiente por entrega de documentacion*/
        IF ((nurows = ld_boconstans.cnuCero_Value) OR
           (nusubpromo = ld_boconstans.cnuCero_Value)) THEN
            BEGIN
                Ld_BoSubsidy.Procinssalewithoutsubsidy(inupackages_id);
            EXCEPTION
                WHEN OTHERS THEN
                    UT_Trace.Trace('ERROR CONTROLADO JC', 1);
                    /*Se captura la excepcion para que no detenga el flujo*/
                    NULL;
            END;
        END IF;

        UT_Trace.Trace('Fin Ld_Bosubsidy.ProcAssigSubByForm', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcAssigSubByForm;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcgenLetters
      Descripcion    : Genera las cartas para los usuarios potenciales
                       a partir de los CLOBs almacenados en la tabla
                       ld_temp_clob_fact

      Autor          : jonathan alberto consuegra lara
      Fecha          : 01/06/2013

      Parametros       Descripcion
      ============     ===================
      inusession       identificador de la sesion de usuario

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      01/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcgenLetters(inusession  IN NUMBER,
                             isbsource   IN VARCHAR2,
                             isbfilename IN VARCHAR2) IS

        CURSOR cuClobs(inusesi NUMBER) IS
            SELECT l.docudocu
            FROM   ld_temp_clob_fact l
            WHERE  l.sesion = inusesi
            AND    l.docudocu IS NOT NULL;

        --clletter ld_temp_clob_fact.docudocu%type;

    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.ProcgenLetters', pkg_traza.cnuNivelTrzDef);

        FOR rgcuClobs IN cuClobs(inusession) LOOP
            ProcExportToPDFFromMem(isbsource, isbfilename, rgcuClobs.Docudocu);
        END LOOP;

        UT_Trace.Trace('Fin Ld_Bosubsidy.ProcgenLetters', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcgenLetters;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procgetdatesforpackages
      Descripcion    : Obtiene la ubicacion geografica, la categoria y
                       la subcategoria de una solicitud de venta
                       de gas

      Autor          : jonathan alberto consuegra lara
      Fecha          : 01/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta
      onuubication     identificador de la ubicacion geografica
      onucategori      identificador de la categoria
      onusubcategori   identificador de la subcategoria

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      01/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE Procgetdatesforpackages(inupackage_id  IN mo_packages.package_id%TYPE,
                                      onuubication   OUT ge_geogra_location.geograp_location_id%TYPE,
                                      onucategori    OUT categori.catecodi%TYPE,
                                      onusubcategori OUT subcateg.sucacodi%TYPE) IS

        nuaddress_id    ab_address.address_id%TYPE;
        nuestate_number ab_Address.Estate_Number%TYPE;
        nusegment       ab_address.Segment_Id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.Procgetdatesforpackages', pkg_traza.cnuNivelTrzDef);

        /*Obtener id de la direccion de la solicitud*/
        nuaddress_id := Damo_Packages.Fnugetaddress_Id(inupackage_id, NULL);
        /*Obtener la ubicacion geografica*/
        onuubication := Daab_Address.fnuGetGeograp_Location_Id(nuaddress_id,
                                                               NULL);
        /*Obtener codigo del predio*/
        nuestate_number := Daab_Address.fnuGetEstate_Number(nuaddress_id, NULL);
        /*Obtener categoria y subcategoria del predio*/
        onucategori    := daab_premise.fnuGetCategory_(nuestate_number, NULL);
        onusubcategori := daab_premise.fnuGetSubcategory_(nuestate_number, NULL);

        IF onucategori IS NULL OR onusubcategori IS NULL THEN
            /*Obtener el segment_id de la direccion*/
            nusegment := daab_address.fnuGetSegment_Id(nuaddress_id, NULL);
            IF onucategori IS NULL THEN
                /*Obtener categoria de la direccion*/
                onucategori := daab_segments.fnuGetCategory_(nusegment, NULL);
            END IF;

            IF onusubcategori IS NULL THEN
                /*Obtener subcategoria de la direccion*/
                onusubcategori := daab_segments.fnuGetSubcategory_(nusegment,
                                                                   NULL);
            END IF;
        END IF;

        UT_Trace.Trace('Fin Ld_Bosubsidy.Procgetdatesforpackages', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Procgetdatesforpackages;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbActiveSubsidy
      Descripcion    : Determina si un subsidio se encuentra vigente.
                       Si la funcion retorna

      Autor          : jonathan alberto consuegra lara
      Fecha          : 02/06/2013

      Parametros       Descripcion
      ============     ===================
      inusubsidy_id    identificador del subsidio

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      02/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION FsbActiveSubsidy(inusubsidy_id IN ld_subsidy.subsidy_id%TYPE)
        RETURN VARCHAR2 IS

        dtfinalsubdate ld_subsidy.final_date%TYPE;
        sbanswer       VARCHAR2(1);
    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.FsbActiveSubsidy', pkg_traza.cnuNivelTrzDef);
        /*Obtener la fecha final del subsidio*/
        dtfinalsubdate := dald_subsidy.fdtGetFinal_Date(inusubsidy_id, NULL);

        IF SYSDATE > dtfinalsubdate THEN
            sbanswer := 'N';
        ELSE
            sbanswer := 'Y';
        END IF;

        RETURN(sbanswer);

        UT_Trace.Trace('Fin Ld_Bosubsidy.FsbActiveSubsidy', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END FsbActiveSubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcExportToPDFFromMem
     Descripcion    : Procesa el CLOB para la carta de asignacion
                      retroactiva de subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 07/02/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     07/02/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE ProcExportToPDFFromMem(isbsource   VARCHAR2,
                                     isbfilename VARCHAR2 --,
                                     --isbtemplate ed_confexme.coempadi%type
                                     ) IS
        clclob CLOB;
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ProcExportToPDFFromMem', pkg_traza.cnuNivelTrzDef);
        clclob := Ld_BoSubsidy.Fclgetglobalclob;
        UT_Trace.Trace('ProcExportToPDFFromMem -> globalsbTemplate' ||
                       ld_bosubsidy.globalsbTemplate,
                       10);

        IF clclob IS NOT NULL AND ld_bosubsidy.globalsbTemplate IS NOT NULL THEN
            UT_Trace.Trace('clob y template no nulo', pkg_traza.cnuNivelTrzDef);
            id_bogeneralprinting.SetIsDataFromFile(FALSE);
            UT_Trace.Trace('Template =' || ld_bosubsidy.globalsbTemplate, 15);
            -- Instancia la plantilla
            pkBOED_DocumentMem.SetTemplate(ld_bosubsidy.globalsbTemplate);
            -- Instancia los datos almacenados en un clob
            pkBOED_DocumentMem.Set_PrintDoc(clclob);
            -- Instancia informacion basica para extraccion y mezcla a partir de un archivo XML
            pkBOED_DocumentMem.SetBasicDataExMe(isbsource, isbfilename);
        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ProcExportToPDFFromMem', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ProcExportToPDFFromMem;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : GetOriginAccount
      Descripcion    : Se encarga de obtener la cuenta de cobro origen de
                       un diferido

      Autor          : jonathan alberto consuegra lara
      Fecha          : 04/06/2013

      Parametros          Descripcion
      ============        ===================
      inuDeferred         Identificador del diferido
      inuProduct          Identificador del producto(servicio suscrito)
      ionuAccountStatus   Identificador de la factura
      ionuAccount         Identificador de la cuenta de cobro

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      04/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE GetOriginAccount(inuDeferred       IN diferido.difecodi%TYPE,
                               inuProduct        IN servsusc.sesunuse%TYPE,
                               ionuAccountStatus IN OUT factura.factcodi%TYPE,
                               ionuAccount       IN OUT cuencobr.cucocodi%TYPE) IS

        ------------------------------------------------------------------------
        --  Variables
        ------------------------------------------------------------------------
        -- Tipo de producto
        nuProductType servicio.servcodi%TYPE;
        -- Causa de cargo para paso a diferido
        nuChargeCause    causcarg.cacacodi%TYPE;
        sbTokenFinancing VARCHAR2(100);
        ------------------------------------------------------------------------
        --  Cursores
        ------------------------------------------------------------------------
        CURSOR cuCargosOrigen(isbToken VARCHAR2,
                              inuCausa causcarg.cacacodi%TYPE) IS
            SELECT /*+ index( cargos IX_CARGOS010 ) */
             cargcuco
            FROM   cargos /*+ pkTransDefToCurrDebtMgr.GetOriginAccount */
            WHERE  cargdoso = isbToken
            AND    cargcaca = inuCausa
            AND    cargnuse + 0 = inuProduct;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.GetOriginAccount', pkg_traza.cnuNivelTrzDef);

        sbTokenFinancing := pkBillConst.csbTOKEN_FINANCIACION ||
                            to_char(inuDeferred);
        --  Obtiene el tipo de producto
        nuProductType := pktblservsusc.fnuGetService(inuProduct);
        -- Obtiene causa de cargo para paso a diferido (43)
        nuChargeCause := fa_bochargecauses.fnuDeferredChCause(nuProductType);

        FOR rcCharge IN cuCargosOrigen(sbTokenFinancing, nuChargeCause) LOOP
            -- Actualiza la cuenta y el estado de cuenta solo si encuentra datos
            ionuAccount       := rcCharge.cargcuco;
            ionuAccountStatus := pkTblCuencobr.fnuGetAccountStatus(ionuAccount);
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.GetOriginAccount', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END GetOriginAccount;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del procedimiento: proFactCCAplicaSub
    Descripcion:              Busca la factura y cuenta de cobro donde se creo
                              el cargo de signo DB del traslado de diferido

    Parametros de entrada:    * inuSuscriptor: Suscriptor al que se le realiza
                                               el proceso (contrato).

    Parametros de salida:     * onuCuenCobr :  Nro de cuenta de cobro donde se
                                               encuentra el cargo de signo DB
                                               correspondiente al cargo por
                                               conexion
                              * onuFactura:    Numero de factura donde se
                                               encuentra la cuenta de cobro
                                               obtenida en el parametro ?Nro de
                                               cuenta de cobro?

    Autor : Sandra Mu?oz
    Fecha : 19/08/2015. ARA8178

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    23-05-2017   Sebastian Tapias       200-1282 || Se modifica el query que obtiene
                                        la factura y la  cuenta de cobro
                                        Para restringir que solo obtenga un valor
                                        y que sea de la fecha mas reciente.
	17-10-2015   Sandra Mu?oz           ARA8652 - Se agrega el parametro de
	                                    entrada inuConcASubsidiar para
										reemplazar la variable nuConcCargoXConex
										la cual no se usara mas en el proceso
    19/08/2015   Sandra Mu?oz           Creacion
    ******************************************************************/
    PROCEDURE proFactCCAplicaSub(inuSuscriptor     suscripc.susccodi%TYPE,
                                 inuConcASubsidiar concepto.conccodi%TYPE, -- ARA8652. Se agrega el parametro
                                 onuCuenCobr       OUT cuencobr.cucocodi%TYPE,
                                 onuFactura        OUT cuencobr.cucofact%TYPE,
                                 osbError          OUT NUMBER) IS

        sbPaso VARCHAR2(4000); -- Paso ejecutado
		-- Ara8652. Se borra la variable nuConcCargoXConex
        --nuConcCargoXConex     ld_parameter.numeric_value%TYPE; -- Codigo del concepto de cargo por conexion
        nuCausCarCancDiferido ld_parameter.numeric_value%TYPE; -- Causa cargo para cancelacion del diferido

    BEGIN

        sbPaso := '10 - Inicio ld_BoSubsidy.proFactCCAplicaSub';
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

        -- Obteniendo parametro COD_CONCEP_CARG_CONEX

        sbPaso := '20 - Buscando el parametro COD_CONCEP_CARG_CONEX...';
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

		-- ARA8652. No se hace uso del parametro COD_CONCEP_CARG_CONEX ya
        --        nuConcCargoXConex := DALD_PARAMETER.fnuGetNumeric_Value('COD_CONCEP_CARG_CONEX');

        sbPaso := '30 - ... inuConcASubsidiar: ' || inuConcASubsidiar;
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

        -- ARA8652. Se usa el parametro de entrada  inuConcASubsidiar en lugar
		-- de la variable nuConcCargoXConex
        IF inuConcASubsidiar IS NULL THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        -- Obteniendo parametro CAUSCAR_CANC_DIFERIDO

        sbPaso := '40 - Buscando el parametro CAUSCAR_CANC_DIFERIDO...';
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

        nuCausCarCancDiferido := DALD_PARAMETER.fnuGetNumeric_Value('CAUSCAR_CANC_DIFERIDO');

        sbPaso := '50 - ... CAUSCAR_CANC_DIFERIDO: ' || nuCausCarCancDiferido;
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

        IF nuCausCarCancDiferido IS NULL THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        -- Buscar la factura y la  cuenta de cobro donde se creo el cargo DB
        -- del translado del diferido

        sbPaso := '60 - Buscando la cuenta de cobro y factura del cargo DB para el concepto: ' ||
                  inuConcASubsidiar || ' suscriptor: ' || inuSuscriptor ||
                  ' causa cargo: ' || nuCausCarCancDiferido || '...';
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

        /*SELECT factcodi,
               cucocodi
        INTO   onuFactura,
               onuCuenCobr
        FROM   factura  f,
               cargos   c,
               cuencobr cc
        WHERE  f.factcodi = cc.cucofact
        AND    cc.cucocodi = c.cargcuco
        AND    c.cargconc = inuConcASubsidiar -- ARA8652. Ya no se usa la variable nuConcCargoXConex
        AND    f.factsusc = inuSuscriptor
        AND    c.cargsign = 'DB'
        AND    c.cargcaca = nuCausCarCancDiferido;*/
       /* JM || SEBTAP || 23-05-2017 || CA 200-1282
        Se cambia el query anterior, para restringir que solo obtenga un solo registro
        Y que este corresponda a la fecha mas reciente*/
        SELECT factcodi,
               cucocodi
        INTO onuFactura,
             onuCuenCobr
        FROM (SELECT factcodi,
                     cucocodi
          FROM open.factura f,
               open.cargos c,
               open.cuencobr cc
           WHERE f.factcodi = cc.cucofact
           AND cc.cucocodi = c.cargcuco
           AND c.cargconc = inuConcASubsidiar
           AND f.factsusc = inuSuscriptor
           AND c.cargsign = 'DB'
           AND c.cargcaca = nuCausCarCancDiferido
           ORDER BY f.factfege desc)
        WHERE ROWNUM <= 1;


        sbPaso := '70 - ... Cuenta de cobro: ' || onuCuenCobr || ' factura: ' ||
                  onuFactura;
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

        sbPaso := '80 - Fin ld_BoSubsidy.proFactCCAplicaSub';
        UT_Trace.Trace(sbPaso, pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            osbError := SQLERRM || ' - ' || sbPaso;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            osbError := SQLERRM || ' - ' || sbPaso;
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;

    END;
    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ApplyRetrosubsidy
      Descripcion    : Se encarga de aplicar los subsidios asignados en
                       forma retroactiva

      Autor          : jonathan alberto consuegra lara
      Fecha          : 04/06/2013

      Parametros          Descripcion
      ============        ===================
      inuasigsubid        Identificador de asignacion de subsidios

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
	  17-10-2015       Sandra Mu?oz          ARA8652.
	                                         * Se hace uso del cursor conceptos que
	                                         obtiene los conceptos a los que se
											 les puede aplicar subsidio segun la ubiacion
											 y este concepto se envia al procedimiento
											 proFactCCAplicaSub la cual se encarga de encontrar
											 la cuenta de cobro donde se realizo la venta
											 * Se disminuye la observacion enviada al
											 procidimiento fa_bobillingnotes.createbillingnote
											 porque se desborda la columna notaobs al
											 momento de la insersion en la tabla notas.
      13-12-2013       hjgomez.SAO227259     Se cambia el parametro para que genera saldo a favor
      10-12-2013       hjgomez.SAO226584     Se crea una nueva cuenta de cobro para el subsidio
      04/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ApplyRetrosubsidy(inuasigsubid ld_asig_subsidy.asig_subsidy_id%TYPE,
                                onuError     OUT NUMBER,
                                osbError     OUT VARCHAR2) IS

        CURSOR conceptos(inucommercialplan mo_motive.commercial_plan_id%TYPE,
                         inuubication      IN ld_ubication.ubication_id%TYPE) IS
            SELECT l.conccodi
            FROM   ld_subsidy_detail l
            WHERE  l.ubication_id = inuubication;

        CURSOR diferidos(inususcodi IN suscripc.susccodi%TYPE,
                         inunuse    IN servsusc.sesunuse%TYPE,
                         inuconc    IN diferido.difeconc%TYPE) IS

            SELECT d.difecodi
            FROM   diferido d
            WHERE  d.difesape > 0
            AND    d.difesusc = inususcodi
            AND    d.difenuse = inunuse
            AND    d.difeconc = inuconc;

        nuubication     ld_ubication.ubication_id%TYPE;
        nucont          NUMBER := 0;
        nusesunuse      servsusc.sesunuse%TYPE;
        nuappconc       ld_subsidy.conccodi%TYPE;
        nucause         cargos.cargcaca%TYPE;
        nupackages_id   mo_packages.package_id%TYPE;
        nususcrip       suscripc.susccodi%TYPE;
        nucondeuda      diferido.difesape%TYPE;
        nutotdeuda      diferido.difesape%TYPE;
        nusubsidyvalue  ld_subsidy.authorize_value%TYPE;
        nuAccountStatus factura.factcodi%TYPE;
        nuAccount       cuencobr.cucocodi%TYPE;
        nudifecodi      diferido.difecodi%TYPE;
        nuDocTypeId     NUMBER;
        orcnota         notas%ROWTYPE;
        nuNoteFactCause cargos.cargcaca%TYPE;
        nusubsidy       ld_subsidy.subsidy_id%TYPE;
        rcubication     dald_ubication.styld_ubication;
        nutransfervalue diferido.difesape%TYPE;
        nuchargevalue   cargos.cargvalo%TYPE;
        nuBill          factura.factcodi%TYPE;
        rcProduct       servsusc%ROWTYPE;
        rcSusc          suscripc%ROWTYPE;
        --
        nucommercialplan mo_motive.commercial_plan_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ApplyRetrosubsidy', pkg_traza.cnuNivelTrzDef);

        /*Obtener la ubicacion de la asignacion del subsidio*/
        nuubication := dald_asig_subsidy.fnuGetUbication_Id(inuasigsubid, NULL);

        IF nuubication IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se encontro ubicacion para el codigo de asignacion: ' ||
                        inuasigsubid;
            GOTO error;
        END IF;

        /*Obtener la suscripcion*/
        nususcrip := dald_asig_subsidy.fnuGetSusccodi(inuasigsubid, NULL);

        IF nususcrip IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se encontro suscripcion para el codigo de asignacion: ' ||
                        inuasigsubid;

            GOTO error;
        END IF;

        /*Determinar si el suscriptor tiene servicio suscrito activo*/
        nusesunuse := ld_bcsubsidy.Fnugetsesunuse(dald_asig_subsidy.fnuGetPackage_Id(inuasigsubid,
                                                                                     NULL));

        IF nusesunuse IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se encontro servicio suscrito activo para el contrato ' ||
                        nususcrip;
            GOTO error;
        END IF;

        /*Obtener el concepto de aplicacion del subsidio*/
        nuappconc := dald_subsidy.fnuGetConccodi(dald_asig_subsidy.fnuGetSubsidy_Id(inuasigsubid,
                                                                                    NULL),
                                                 NULL);

        IF nuappconc IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'El subsidio ' ||
                        dald_subsidy.fnuGetSubsidy_Id(inuasigsubid, NULL) || '
                    no tiene asociado un concepto de aplicacion';
            GOTO error;
        END IF;

        /*Obtener la causa del cargo*/
        nucause := ld_boconstans.cnufacturation_note_subsidy;

        IF nucause IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se realizo el proceso porque no se encuentra configurada la causa del cargo credito';
            GOTO error;
        END IF;

        /*Obtener la solicitud subsidiada*/
        nupackages_id := dald_asig_subsidy.fnuGetPackage_Id(inuasigsubid, NULL);

        IF nupackages_id IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se encontro solicitud de venta para el codigo de asignacion: ' ||
                        inuasigsubid;
            GOTO error;
        END IF;

        /*Obtener el valor del subsidio*/
        nusubsidyvalue := dald_asig_subsidy.fnuGetSubsidy_Value(inuasigsubid,
                                                                NULL);

        IF nvl(nusubsidyvalue, 0) <= 0 THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'El valor del subsidio debe ser mayor a cero';
            GOTO error;
        END IF;

        nusubsidy := dald_asig_subsidy.fnuGetSubsidy_Id(inuasigsubid, NULL);

        IF nusubsidy IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se encontro subsidio para el codigo de asignacion: ' ||
                        inuasigsubid;
            GOTO error;
        END IF;

        /*Obtener plan comercial de la solicitud*/
        nucommercialplan := damo_motive.fnuGetCommercial_Plan_Id(Ld_Bcsubsidy.Fnugetmotive(nupackages_id,
                                                                                           NULL),
                                                                 NULL);

        /*Validar que el plan comercial de la solicitud no sea nulo*/
        IF nucommercialplan IS NULL THEN
            onuError := ld_boconstans.cnuGeneric_Error;
            osbError := 'No se encontro plan comercial asociado a la solicitud ' ||
                        nupackages_id;
            GOTO error;
        END IF;

        /*Obtener el identificador de los conceptos a subsidiar*/
        FOR rgconceptos IN conceptos(nucommercialplan, nuubication) LOOP

            nucont := nvl(nucont, 0) + 1;
            /*Obtener la deuda diferida de los conceptos a subsidiar*/
            nucondeuda := Ld_Bcsubsidy.Fnugetdifesapebyconc(nususcrip,
                                                            nusesunuse,
                                                            rgconceptos.conccodi,
                                                            NULL);
            nutotdeuda := nvl(nutotdeuda, 0) + nvl(nucondeuda, 0);

        END LOOP;

        /*Validar que si no hay conceptos a subsidiar se determine si se otorga
        saldo a favor*/
        IF ((nvl(nucont, 0) = 0) OR (nvl(nucont, 0) > 0 AND nutotdeuda = 0)) THEN
            /*Consultar si se aplica saldo a favor*/
            IF ld_boconstans.csbapplybalance = ld_boconstans.csbafirmation THEN
                /*Crear cargo credito con el monto del subsidio*/
                pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
                --Genero factura
                -- Obtiene el numero de la factura
                pkAccountStatusMgr.GetNewAccoStatusNum(nuBill);
                -- Crea una nueva FACTURA
                rcSusc := pktblsuscripc.frcgetrecord(nususcrip);
                pkAccountStatusMgr.AddNewRecord(nuBill,
                                                pkGeneralServices.fnuIDProceso,
                                                rcSusc,
                                                GE_BOconstants.fnuGetDocTypeCons);
                rcProduct := pktblservsusc.frcgetrecord(nusesunuse);
                -- Obtiene el numero de la cuenta de cobro
                pkAccountMgr.GetNewAccountNum(nuAccount);

                -- Crea una nueva cuenta de cobro
                pkAccountMgr.AddNewRecord(nuBill, nuAccount, rcProduct);

                UT_Trace.Trace('Genera Cargos. Factura: ' || nuBill ||
                               ' - Cuenta Cobro: ' || nuAccount,
                               10);
                pkChargeMgr.GenerateCharge(nusesunuse,
                                           nuAccount,
                                           nuappconc,
                                           nucause,
                                           nusubsidyvalue, --valor del cargo
                                           'CR',
                                           'PP-' || nupackages_id,
                                           'A',
                                           ld_boconstans.cnuCero_Value,
                                           NULL,
                                           NULL,
                                           NULL,
                                           FALSE,
                                           SYSDATE);
                /*pkActCart.UpdPortfolio(
                  nuAccount,
                  nucause,
                  nusesunuse
                );   */

            ELSE
                UT_Trace.Trace('Se anula el subsidio retroactivo porque el cliente no cuenta con deuda diferida por los conceptos a subsidiar ',
                               10);
                /*Se anula el subsidio retroactivo porque el cliente no cuenta con
                deuda diferida por los conceptos a subsidiar y el flag de asignacion
                de salgo a favor no permite ese movimiento
                Obtener los datos de la poblacion*/
                DALD_ubication.LockByPkForUpdate(nuubication, rcubication);

                /*Retornar la porcion de subsidio a la poblacion y el encabezado*/
                Procbalancesub(nusubsidy,
                               rcubication,
                               nusubsidyvalue,
                               ld_boconstans.cnutwonumber);

                /*Pasar a estado anulado el subsidio*/
                dald_asig_subsidy.updState_Subsidy(inuasigsubid,
                                                   ld_boconstans.cnuSubreverstate);
            END IF;

        ELSE
            UT_Trace.Trace('Deuda diferida de los conceptos a subsidiar es mayor a cero',
                           10);
            /*Si la deuda diferida de los conceptos a subsidiar es mayor a cero*/
            IF nvl(nutotdeuda, 0) > 0 THEN
                /*Limpiar tabla PL en donde se adicionan los diferidos*/
                CC_BODefToCurTransfer.GlobalInitialize;
                /*Bajar la deuda al corriente de los conceptos a subsidiar*/
                FOR rgconceptos IN conceptos(nucommercialplan, nuubication) LOOP
                    FOR rgdiferidos IN diferidos(nususcrip,
                                                 nusesunuse,
                                                 rgconceptos.conccodi) LOOP
                        IF nudifecodi IS NULL THEN
                            nudifecodi := rgdiferidos.difecodi;
                        END IF;
                        cc_bodeftocurtransfer.AddDeferToCollect(rgdiferidos.difecodi);
                    END LOOP;
                END LOOP;
                --------
                /*Determinar el valor a transferir.
                  Si el valor del subsidio es mayor a la deuda diferida se traslada el valor
                  de la deuda sino el valor del subsidio
                */
                IF nvl(nutotdeuda, 0) > 0 THEN
                    IF nvl(nusubsidyvalue, 0) > nvl(nutotdeuda, 0) THEN
                        nutransfervalue := nutotdeuda;
                    ELSE
                        nutransfervalue := nusubsidyvalue;
                    END IF;

                    cc_bodeftocurtransfer.TransferDebt('LDCDE',
                                                       onuError,
                                                       osbError,
                                                       FALSE,
                                                       nutransfervalue,
                                                       SYSDATE);
                END IF;
                /*Fin bajar la deuda al corriente de los conceptos a subsidiar
                Obtener la cuenta de cobro para el cargo credito*/
                GetOriginAccount(nudifecodi,
                                 nusesunuse,
                                 nuAccountStatus,
                                 nuAccount);

                IF nuAccount IS NULL THEN
                    onuError := ld_boconstans.cnuGeneric_Error;
                    osbError := 'Error obteniendo la cuenta de cobro para crear la nota y cargo credito';
                    ROLLBACK;
                    GOTO error;
                END IF;

                IF nuAccountStatus IS NULL THEN
                    onuError := ld_boconstans.cnuGeneric_Error;
                    osbError := 'Error obteniendo la factura para crear la nota y cargo credito';
                    ROLLBACK;
                    GOTO error;
                END IF;

                /*Codigo del tipo de documento*/
                nuDocTypeId := DALD_PARAMETER.fnuGetNumeric_Value('DOC_CREDIT_TYPE_ID');

                IF nuDocTypeId IS NULL THEN
                    onuError := ld_boconstans.cnuGeneric_Error;
                    osbError := 'Error obteniendo el tipo de documento de la nota';
                    GOTO error;
                END IF;
                pkerrors.setapplication('LDCDE');
                -- ARA8178 - Se hace el llamado al procedimiento
                -- LD_BOSubsidy.proFactCCAplicaSub, de esta manera se recupera
                -- la cuenta de cobro y la factura donde se aplico el subsidio
                -- y alli se crea el cargo CR con el codigo ya existente:
                /*
                                --Genero factura
                                -- Obtiene el numero de la factura
                                pkAccountStatusMgr.GetNewAccoStatusNum(nuBill);
                                -- Crea una nueva FACTURA
                                rcSusc := pktblsuscripc.frcgetrecord(nususcrip);
                                pkAccountStatusMgr.AddNewRecord(nuBill,
                                                                pkGeneralServices.fnuIDProceso,
                                                                rcSusc,
                                                                GE_BOconstants.fnuGetDocTypeCons);
                                rcProduct := pktblservsusc.frcgetrecord(nusesunuse);
                                -- Obtiene el numero de la cuenta de cobro
                                pkAccountMgr.GetNewAccountNum(nuAccount);


                -- Crea una nueva cuenta de cobro
                                pkAccountMgr.AddNewRecord(nuBill, nuAccount, rcProduct);*/

                -- ARA8652. Se hace uso del cursor que obtiene todos los conceptos subsidiados segun la ubicacion
                -- y por cada uno se obtiene la factura donde se realizo la venta y se crea la
                -- el cargo DB
                FOR rgconceptos IN conceptos(nucommercialplan, nuubication) LOOP
                    -- ara8652. Se envia el codigo del concepto al que se le quiere aplicar el subsidio
                    proFactCCAplicaSub(inuSuscriptor     => nususcrip,
                                       inuConcASubsidiar => rgconceptos.conccodi,
                                       onuCuenCobr       => nuAccount,
                                       onuFactura        => nuBill,
                                       osbError          => osbError);

                    IF osbError IS NOT NULL THEN
                        RAISE pkg_error.CONTROLLED_ERROR;
                    END IF;



                -- Fin ARA8178

                /*Generar el cargo credito*/

                UT_Trace.Trace('Se crea Nota Credito en la cuenta: ' ||
                               nuAccountStatus || ' - Factura: ' || nuBill,
                               10);
          /*
                DECLARE
				   nuDummy NUMBER;
				BEGIN
					PKBILLINGNOTEMGR.GETNEWNOTENUMBER(nudummy)   ;

                UT_Trace.Trace('ORCNOTA.NOTANUME := '|| nudummy, pkg_traza.cnuNivelTrzDef);


								UT_Trace.Trace('ORCNOTA.NOTASUSC := '||nususcrip ||'
								ORCNOTA.NOTAFACT := '||nuBill ||'
								ORCNOTA.NOTATINO := '||nuDocTypeId ||'
								ORCNOTA.NOTAFECO := SYSDATE
								ORCNOTA.NOTAFECR := SYSDATE
								ORCNOTA.NOTAPROG :=  ||
                               PKGENERALSERVICES.FNUIDPROCESO '||'
								ORCNOTA.NOTAUSUA := ' ||
                               SA_BOSYSTEM.GETSYSTEMUSERID || '
								ORCNOTA.NOTATERM := ' ||
                               PKGENERALSERVICES.FSBGETTERMINAL ||'
								ORCNOTA.NOTACONS := '||nudummy||'
								ORCNOTA.NOTANUFI := ' || NULL || '
								ORCNOTA.NOTAPREF := ' || NULL || '
								ORCNOTA.NOTACONF := ' || NULL || '
								ORCNOTA.NOTAIDPR := ' || NULL || '
								ORCNOTA.NOTACOAE := ' || NULL || '
								ORCNOTA.NOTAFEEC := ' || NULL || '
								ORCNOTA.NOTAOBSE := ' || 'Se creo la NC. Cuenta de cobro ' ||'
								ORCNOTA.NOTADOCU := ' || nuAccount ||'
								ORCNOTA.NOTADOSO := ' ||'NC-RETRO' || nudummy ,
                               10);
							   END;
            */
                /*Generar nota credito*/

				-- ARA8652. Se disminuye la observacion enviada al procidimiento
				-- fa_bobillingnotes.createbillingnote porque se desborda la columna
				-- notaobs al momento de la insersion en la tabla notas.
                fa_bobillingnotes.createbillingnote(nususcrip,
                                                    nuBill, --factura
                                                    nuDocTypeId,
                                                    SYSDATE,
                                                    'Se creo la NC. Cuenta de cobro ' ||
                                                    nuAccount,
                                                    'NC-RETR',
                                                    'C',
                                                    NULL,
                                                    orcnota);



                /*Obtener el codigo de Causal nota de facturacion*/
                nuNoteFactCause := LD_BOConstans.cnufacturation_note_subsidy;

                IF nuNoteFactCause IS NULL THEN
                    onuError := ld_boconstans.cnuGeneric_Error;
                    osbError := 'Error obteniendo la causa del cargo';
                    ROLLBACK;
                    GOTO error;
                END IF;

                /*Determinar el valor del cargo.
                  Si el valor del subsidio es menor a la deuda diferida entonces el valor del cargo
                  es el valor del subsidio.
                  Si el valor del subsidio es mayor a la deuda diferida entonces el valor del cargo
                  es dependera si se acepta saldo a favor. Si se acepta saldo a favor el valor del cargo
                  sera el valor del subsidio sino sera el valor de la deuda.
                */
                IF nvl(nusubsidyvalue, 0) > nvl(nutotdeuda, 0) THEN
                    /*Consultar si se aplica saldo a favor*/
                    IF ld_boconstans.csbapplybalance =
                       ld_boconstans.csbafirmation THEN
                        nuchargevalue := nusubsidyvalue;
                    ELSE
                        nuchargevalue := nutotdeuda;
                    END IF;
                ELSE
                    nuchargevalue := nusubsidyvalue;
                END IF;

                /*Crear Detalle Nota Credito*/
                FA_BOBillingNotes.DetailRegister(orcnota.notanume,
                                                 nusesunuse,
                                                 orcnota.notasusc,
                                                 nuAccount,
                                                 nuappconc,
                                                 nuNoteFactCause,
                                                 nuchargevalue, --valor del cargo
                                                 NULL,
                                                 'NC-' || nupackages_id,
                                                 'CR',
                                                 'N',
                                                 NULL,
                                                 'S',
                                                 NULL);
				-- ARA8652. Se cierra el ciclo que recorre los conceptos a subsidiar
                END LOOP;
            END IF;
        END IF;

        <<error>>
        NULL;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ApplyRetrosubsidy', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ApplyRetrosubsidy;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetretroubication
       Descripcion    : Obtiene la poblacion subsidiada a partir de la cual
                        se ubicaran los conceptos a subsidiar

       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/06/2013

       Parametros       Descripcion
       ============     ===================
       inupackages_id   identificador de la solicitud,
       inususcripc      identificador de la suscripcion,
       inuubication     identificador de la ubicacion geografica
       inucategory      identificador de la categoria
       inusubcateg      identificador de la subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       29/10/2013       jrobayo.SAO214447     Se modifica la consulta del CURSOR para obtener
                                              subsidios que no se encuentren vencidos
       05/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetretroubication(inupackages_id mo_packages.package_id%TYPE,
                                  inususcripc    suscripc.susccodi%TYPE,
                                  inuubication   GE_GEOGRA_LOCATION.Geograp_Location_Id%TYPE,
                                  inucategory    SUBCATEG.Sucacate%TYPE,
                                  inusubcateg    SUBCATEG.Sucacodi%TYPE)
        RETURN ld_ubication.ubication_id%TYPE IS

        CURSOR cusubsidy IS
            SELECT l.subsidy_id
            FROM   ld_subsidy l
            WHERE  l.initial_date < SYSDATE
            AND    l.final_date > SYSDATE;

        nuubication      ld_ubication.ubication_id%TYPE;
        nurows           NUMBER;
        nuexistasigsub   NUMBER;
        nucommonconcepts NUMBER;
        nusw             NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetretroubication', pkg_traza.cnuNivelTrzDef);

        nurows         := ld_boconstans.cnuCero_Value;
        nusw           := ld_boconstans.cnuCero_Value;
        nuexistasigsub := ld_boconstans.cnuCero_Value;
        /*Obtener la sesion actual*/
        globalsesion := ut_session.getsessionid;

        FOR rgcusubsidy IN cusubsidy LOOP
            SELECT COUNT(1)
            INTO   nurows
            FROM   ld_temp_ubication l
            WHERE  l.sesion = globalsesion;

            IF nurows = 0 THEN
                /*Obtener el codigo de la ubicacion geografica*/
                nuubication := Ld_bosubsidy.Fnugetsububication(rgcusubsidy.subsidy_id,
                                                               inuubication,
                                                               inucategory,
                                                               inusubcateg);
            ELSE
                /*Obtener el codigo de la ubicacion geografica*/
                nuubication := Ld_bosubsidy.Fnugetothersububication(rgcusubsidy.subsidy_id,
                                                                    inuubication,
                                                                    inucategory,
                                                                    inusubcateg,
                                                                    globalsesion);
            END IF;

            IF nuubication IS NOT NULL THEN
                nuexistasigsub := ld_bcsubsidy.fnususcwithsubsidy(nuubication,
                                                                  inususcripc);
                /*No tiene el subsidio asignado*/
                IF nuexistasigsub = ld_boconstans.cnuCero_Value THEN
                    /* Validan si existen conceptos par esa ubicacion */
                    nucommonconcepts := ld_bcsubsidy.fnucommonconcepts(NULL,
                                                                       NULL,
                                                                       nuubication);

                    IF nucommonconcepts > ld_boconstans.cnuCero_Value THEN
                        nusw := ld_boconstans.cnuonenumber;
                        EXIT;
                    ELSE
                        GOTO error;
                    END IF;
                ELSE
                    /*tiene el subsidio asignado*/
                    NULL;
                END IF;

                <<error>>

                confirmtempubication(nuubication,
                                     globalsesion,
                                     ld_boconstans.cnuonenumber);
            END IF;
        END LOOP;

        confirmtempubication(nuubication,
                             globalsesion,
                             ld_boconstans.cnutwonumber);
        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetretroubication', pkg_traza.cnuNivelTrzDef);

        IF nusw > ld_boconstans.cnuCero_Value THEN
            RETURN(nuubication);
        ELSE
            RETURN(NULL);
        END IF;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetretroubication;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : confirmtempubication
       Descripcion    : Guarda y borra datos en la tabla temporal de
                        ubicaciones

       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/06/2013

       Parametros       Descripcion
       ============     ===================
       inuubication     identificador de la ubicacion geografica
       inusesion        identificador de la sesion de usuario
       inuoption        opcion

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE confirmtempubication(iubication_id IN ld_ubication.ubication_id%TYPE,
                                   inusesion     IN NUMBER,
                                   inuoption     IN NUMBER) IS

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.confirmtempubication', pkg_traza.cnuNivelTrzDef);

        IF inuoption = ld_boconstans.cnuonenumber THEN
            INSERT INTO ld_temp_ubication
                (ubication_id,
                 sesion)
            VALUES
                (iubication_id,
                 inusesion);
        END IF;

        IF inuoption = ld_boconstans.cnutwonumber THEN
            DELETE FROM ld_temp_ubication l WHERE l.sesion = inusesion;
        END IF;

        COMMIT;

        UT_Trace.Trace('Fin Ld_BoSubsidy.confirmtempubication', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END confirmtempubication;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetothersububication
       Descripcion    : Obtiene la ubicacion geografica a subsidiar
       Autor          : jonathan alberto consuegra lara
       Fecha          : 05/11/2012

       Parametros       Descripcion
       ============     ===================
       inusub           identificador del subsidio
       inuloca          ubicacion geografica
       inucate          categoria
       inusubcate       subcategoria

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       05/11/2012       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetothersububication(inusub     ld_subsidy.subsidy_id%TYPE,
                                     inuloca    ld_ubication.geogra_location_id%TYPE,
                                     inucate    categori.catecodi%TYPE,
                                     inusubcate subcateg.sucacodi%TYPE,
                                     inusesion  NUMBER) RETURN NUMBER IS

        CURSOR cuubication(inulocation    ld_ubication.geogra_location_id%TYPE,
                           inuCategori    ld_ubication.sucacate%TYPE,
                           inuSubcategori ld_ubication.sucacodi%TYPE) IS
            SELECT l.ubication_id
            FROM   ld_ubication l
            WHERE  l.subsidy_id = inusub
            AND    Nvl(l.geogra_location_id, LD_BOConstans.cnuallrows) =
                   Decode(inulocation,
                           '1',
                           inuloca,
                           LD_BOConstans.cnuallrows /*l.geogra_location_id*/)
            AND    Nvl(l.sucacate, LD_BOConstans.cnuallrows) =
                   Decode(inuCategori,
                           '1',
                           inucate,
                           LD_BOConstans.cnuallrows /*l.sucacate*/)
            AND    Nvl(l.sucacodi, LD_BOConstans.cnuallrows) =
                   Decode(inuSubcategori,
                           '1',
                           inusubcate,
                           LD_BOConstans.cnuallrows /*l.sucacate*/)

            AND    l.ubication_id NOT IN
                   (SELECT a.ubication_id
                     FROM   ld_temp_ubication a
                     WHERE  a.sesion = inusesion);

        nuValPar    NUMBER;
        nuubication ld_ubication.ubication_id%TYPE;
        sbContBina  VARCHAR2(100);
        csbfirstcombination  CONSTANT VARCHAR2(3) := '111';
        csbsecondcombination CONSTANT VARCHAR2(3) := '110';
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetothersububication', pkg_traza.cnuNivelTrzDef);

        nuValPar   := LD_BOConstans.cnuCero_Value;
        sbContBina := csbfirstcombination;

        WHILE (nuValPar = LD_BOConstans.cnuCero_Value) LOOP
            OPEN cuubication(Substr(sbContBina,
                                    LD_BOConstans.cnuonenumber,
                                    LD_BOConstans.cnuonenumber),
                             Substr(sbContBina,
                                    LD_BOConstans.cnutwonumber,
                                    LD_BOConstans.cnuonenumber),
                             Substr(sbContBina,
                                    LD_BOConstans.cnuthreenumber,
                                    LD_BOConstans.cnuonenumber));

            FETCH cuubication
                INTO nuubication;

            IF cuubication%NOTFOUND THEN
                IF sbContBina = csbsecondcombination THEN
                    nuValPar := LD_BOConstans.cnuonenumber;
                ELSE
                    sbContBina := csbsecondcombination;
                END IF;
            ELSE
                nuValPar := LD_BOConstans.cnuonenumber;
            END IF;

            CLOSE cuubication;
        END LOOP;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetothersububication', pkg_traza.cnuNivelTrzDef);

        RETURN(nuubication);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetothersububication;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : RegisterReversesubsidy
     Descripcion    : Registra el movimiento correspondiente a la
                      reversion de un subsidio.

     Autor          : Jonathan Consuegra
     Fecha          : 16/12/2012

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Parametro de entrada: Id de registro de la asignacion de subsidio
     inucausal            Causal de reversion

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     17/12/2012       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    PROCEDURE RegisterReversesubsidy(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                                     inucausal          IN ld_causal.causal_id%TYPE) IS

        --cnuNULL_ATTRIBUTE constant number := 2126;
        nureverstate ld_subsidy_states.subsidy_states_id%TYPE;
        rcrever      dald_rev_sub_audit.styLD_rev_sub_audit;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.RegisterReversesubsidy', pkg_traza.cnuNivelTrzDef);

        /*Obtener el estado reversado de un subsidio*/
        nureverstate := ld_boconstans.cnuSubreverstate;
        /*Cambiar el estado actual de la asignacion de subsidio a (Reversado)*/
        DALD_asig_subsidy.updState_Subsidy(inuAsig_Subsidy_Id, nureverstate);
        /*Registro los detalles de la trasferencia en la entidad LdRev_sub_audit*/
        /*Obtener la secuencia a insertar en LdRev_sub_audit*/
        rcrever.rev_sub_audit_id := ld_bosequence.FnuSeqRev_sub_audit;
        rcrever.asig_subsidy_id  := inuAsig_Subsidy_Id;
        rcrever.causal_id        := inucausal;
        rcrever.rev_sub_reg_date := SYSDATE;
        rcrever.rev_con_user     := SA_BOUser.fnuGetUserId;
        rcrever.rev_terminal     := userenv('TERMINAL');
        DALD_Rev_sub_audit.insRecord(rcrever);

        UT_Trace.Trace('Fin Ld_BoSubsidy.RegisterReversesubsidy', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END RegisterReversesubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : RegistraConceptosRem
     Descripcion    : Registra los conceptos utilizados por el
                      remanente de subsidio.

     Autor          : Jorge Valiente
     Fecha          : 09/06/2013

     Parametros           Descripcion
     ============         ===================
     concepto_rem_id      CODIDGO DEL CONCEPTO UTILIZADO EN REMANETE DE SUBSIDIO
     ubication_id         CODIGO DE LA UBICACION GEOGRAFICA
     asig_value           VALOR ASIGNADO AL CONCEPTO DEL REMANENTE DE SUBSIDIO
     sesion               CODIGO SESION DEL FUNCIONARIO
     OSBErrorMessage      Mensaje Error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     29/08/2013       hvera.SAO213589       Se modifican los mensajes de error, de manera que
                                            sean funcionales y entendibles por un usuario.
    ******************************************************************/
    PROCEDURE RegistraConceptosRem(INUconcepto_rem_id IN LD_CONCEPTO_REM.concepto_rem_id %TYPE,
                                   INUubication_id    IN LD_CONCEPTO_REM.ubication_id %TYPE,
                                   INUasig_value      IN LD_CONCEPTO_REM.asig_value %TYPE,
                                   INUsesion          IN LD_CONCEPTO_REM.sesion %TYPE,
                                   ONUErrorCode       OUT NUMBER,
                                   OSBErrorMessage    OUT VARCHAR2) IS

        --PRAGMA AUTONOMOUS_TRANSACTION;

        Validate_Data EXCEPTION;
        nuconceptos  NUMBER;
        nuerror      NUMBER;
        sberror      VARCHAR2(2000);
        nusesion     NUMBER;
        nurows       NUMBER;
        nusimulation NUMBER;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.RegistraConceptosRem', pkg_traza.cnuNivelTrzDef);

        /*Validar que el subsidio no este cerrado*/
        IF nvl(dald_subsidy.fsbGetRemainder_Status(dald_ubication.fnuGetSubsidy_Id(INUubication_id,
                                                                                   NULL),
                                                   NULL),
               'XX') = 'CE' THEN
            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'El subsidio ' ||
                       dald_ubication.fnuGetSubsidy_Id(INUubication_id, NULL) ||
                       ' se encuentra en estado cerrado';
            RAISE Validate_Data;
        END IF;

        /*Validar que la variable de sesion posee datos. Sino posee valor
        es que se esta haciendo el proceso en un momento diferente a la
        distribucion*/
        nusesion := ld_bosubsidy.Fnugetremainsesion;
        UT_Trace.Trace('nusesion = ' || nusesion, pkg_traza.cnuNivelTrzDef);
        IF nusesion IS NULL THEN
            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'Antes de aplicar debe realizar el proceso de simulacion y distribucion';
            RAISE Validate_Data;
        END IF;
        -----------------------------------------------------------------
        --Limpiar la tabla de los conceptos registrados para la misma sesion
        --deleteremainconcepts(nusesion);
        -----------------------------------------------------------------
        UT_Trace.Trace('1 nusimulation = ' || nusimulation, pkg_traza.cnuNivelTrzDef);

        /*Validar que existan registros en estado S: simulacion
        en la tabla LD_SUB_REMAIN_DELIV para una poblacion y sesion determinadas*/
        /*nusimulation := Ld_BcSubsidy.Fnurowsinsimulation(nusesion, INUubication_id );

        IF nusimulation = ld_boconstans.cnuCero_Value THEN
          nuerror := ld_boconstans.cnuGeneric_Error;
          sberror := 'No existen registros en simulacion para procesar. Sesion ['||nusesion||']';
          Raise Validate_Data;
        END IF;*/

        UT_Trace.Trace('2 nusimulation = ' || nusimulation, pkg_traza.cnuNivelTrzDef);
        ------------------------------------------------------------------------------
        UT_Trace.Trace('1 nurows = ' || nurows, pkg_traza.cnuNivelTrzDef);

        /*Validar que existan registros en estado D: distribuir
        en la tabla LD_SUB_REMAIN_DELIV para una poblacion y sesion determinadas*/
        nurows := Ld_Bcsubsidy.Fnurowstoapplyremain(nusesion, INUubication_id);
        UT_Trace.Trace('2 nurows = ' || nurows, pkg_traza.cnuNivelTrzDef);

        IF nurows = ld_boconstans.cnuCero_Value THEN
            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'No existen registros en distribucion para procesar. Sesion [' ||
                       nusesion || ']';
            RAISE Validate_Data;
        END IF;
        -----------------------------------------------------------------

        UT_Trace.Trace('1 nuconceptos = ' || nurows, pkg_traza.cnuNivelTrzDef);

        /*Validar que existan conceptos a subsidiar asociados a  la poblacion*/
        nuconceptos := Ld_Bcsubsidy.Fnudetailconceptsbyubi(INUubication_id);

        IF nuconceptos = ld_boconstans.cnuCero_Value THEN
            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'No existen conceptos configurados para la poblacion ' ||
                       INUubication_id;
            RAISE Validate_Data;
        END IF;

        UT_Trace.Trace('2 nuconceptos = ' || nurows, pkg_traza.cnuNivelTrzDef);
        --------------------------------------------------------------------------------------
        UT_Trace.Trace('INUconcepto_rem_id = ' || INUconcepto_rem_id, pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('INUubication_id = ' || INUubication_id, pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('INUasig_value = ' || INUasig_value, pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('nusesion = ' || nusesion, pkg_traza.cnuNivelTrzDef);
        UT_Trace.Trace('sysdate = ' || SYSDATE, pkg_traza.cnuNivelTrzDef);
        --------------------------------------------------------------------------------------

        IF nvl(INUasig_value, 0) = 0 THEN

            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'El valor del concepto ' || INUconcepto_rem_id ||
                       ' debe ser mayor a cero';
            RAISE Validate_Data;
        END IF;

        IF INUconcepto_rem_id IS NULL THEN
            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'El concepto a ingresar es nulo';
            RAISE Validate_Data;
        END IF;

        IF INUubication_id IS NULL THEN
            nuerror := ld_boconstans.cnuGeneric_Error;
            sberror := 'No se permite ingresar el concepto ' ||
                       INUconcepto_rem_id || ' porque la poblacion es nula';
            RAISE Validate_Data;
        END IF;

        --------------------------------------------------------------------------------------

        /*Se realiza el insert de forma manual dado que el paquete de primer nivel
        falla cuando se ejecuta la primera vez, si se intenta mas de una vez
        el proceso este se realiza bien*/
        INSERT INTO LD_CONCEPTO_REM
            (concepto_rem_id,
             ubication_id,
             asig_value,
             sesion,
             create_date)
        VALUES
            (INUconcepto_rem_id,
             INUubication_id,
             INUasig_value,
             nusesion,
             SYSDATE);

        --COMMIT;

        ONUErrorCode := 0;

        UT_Trace.Trace('Fin Ld_BoSubsidy.RegistraConceptosRem', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN Validate_Data THEN
            ONUErrorCode    := nuerror;
            osbErrorMessage := sberror;
        WHEN OTHERS THEN
            ROLLBACK;
            ONUErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Inconvenientes al regsitrar el concepto ' ||
                               INUconcepto_rem_id ||
                               ' en la tabla LD_CONCEPTO_REM contacte con el administrador ' ||
                               SQLCODE || ' - ' || SQLERRM;
    END RegistraConceptosRem;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnugetcategorybypackages
      Descripcion    : Obtiene la categoria de una solicitud de venta
                       de gas

      Autor          : jonathan alberto consuegra lara
      Fecha          : 11/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      11/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fnugetcategorybypackages(inupackage_id IN mo_packages.package_id%TYPE)
        RETURN categori.catecodi%TYPE IS

        nuaddress_id    ab_address.address_id%TYPE;
        nuestate_number ab_Address.Estate_Number%TYPE;
        nusegment       ab_address.Segment_Id%TYPE;
        nucategori      categori.catecodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.fnugetcategorybypackages', pkg_traza.cnuNivelTrzDef);

        /*Obtener id de la direccion de la solicitud*/
        nuaddress_id := Damo_Packages.Fnugetaddress_Id(inupackage_id, NULL);
        /*Obtener codigo del predio*/
        nuestate_number := Daab_Address.fnuGetEstate_Number(nuaddress_id, NULL);
        /*Obtener categoria y subcategoria del predio*/
        nucategori := daab_premise.fnuGetCategory_(nuestate_number, NULL);

        IF nucategori IS NULL THEN
            /*Obtener el segment_id de la direccion*/
            nusegment := daab_address.fnuGetSegment_Id(nuaddress_id, NULL);
            /*Obtener categoria de la direccion*/
            nucategori := daab_segments.fnuGetCategory_(nusegment, NULL);
        END IF;

        UT_Trace.Trace('Fin Ld_Bosubsidy.fnugetcategorybypackages', pkg_traza.cnuNivelTrzDef);
        RETURN(nucategori);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnugetcategorybypackages;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnugetsubcategbypackages
      Descripcion    : Obtiene la subcategoria de una solicitud de
                       venta de gas

      Autor          : jonathan alberto consuegra lara
      Fecha          : 11/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      11/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fnugetsubcategbypackages(inupackage_id IN mo_packages.package_id%TYPE)
        RETURN subcateg.sucacodi%TYPE IS

        nuaddress_id    ab_address.address_id%TYPE;
        nuestate_number ab_Address.Estate_Number%TYPE;
        nusegment       ab_address.Segment_Id%TYPE;
        nusubcateg      subcateg.sucacodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.fnugetsubcategbypackages', pkg_traza.cnuNivelTrzDef);

        /*Obtener id de la direccion de la solicitud*/
        nuaddress_id := Damo_Packages.Fnugetaddress_Id(inupackage_id, NULL);
        /*Obtener codigo del predio*/
        nuestate_number := Daab_Address.fnuGetEstate_Number(nuaddress_id, NULL);
        /*Obtener subcategoria del predio*/
        nusubcateg := daab_premise.fnuGetSubcategory_(nuestate_number, NULL);

        IF nusubcateg IS NULL THEN
            /*Obtener el segment_id de la direccion*/
            nusegment := daab_address.fnuGetSegment_Id(nuaddress_id, NULL);
            /*Obtener subcategoria de la direccion*/
            nusubcateg := daab_segments.fnuGetSubcategory_(nusegment, NULL);
        END IF;

        RETURN(nusubcateg);

        UT_Trace.Trace('Fin Ld_Bosubsidy.fnugetsubcategbypackages', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnugetsubcategbypackages;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fsbgetConstbyConcept
      Descripcion    : Obtiene el valor de la constante
                       pkBillConst.csbEJECUTA_SOLICITUD

      Autor          : jonathan alberto consuegra lara
      Fecha          : 14/06/2013

      Parametros       Descripcion
      ============     ===================
      inupackage_id    identificador de la solicitud de venta

      Historia de Modificaciones
      Fecha            Autor                 Modificacion
      =========        =========             ====================
      14/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION fsbgetConstbyConcept RETURN VARCHAR2 IS

        sbanswer VARCHAR2(1);

    BEGIN

        UT_Trace.Trace('Inicio Ld_Bosubsidy.fsbgetConstbyConcept', pkg_traza.cnuNivelTrzDef);

        sbanswer := pkBillConst.csbEJECUTA_SOLICITUD;

        RETURN(sbanswer);

        UT_Trace.Trace('Fin Ld_Bosubsidy.fsbgetConstbyConcept', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbgetConstbyConcept;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : Fnugetindividualsubvalue
       Descripcion    : Obtiene el valor individual de un subsidio
                        para un cliente

       Autor          : jonathan alberto consuegra lara
       Fecha          : 15/06/2013

       Parametros       Descripcion
       ============     ===================
       inupackages_id   identificador de la solicitud,
       inuubication     identificador de la poblacion
       onuerror         codigo de error
       osberrmen        mensaje de error presentado

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
      20/09/2013       AEcheverrySAO
      15/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION Fnugetindividualsubvalue(inupackages_id IN mo_packages.package_id%TYPE,
                                      inuubication   IN ld_ubication.ubication_id%TYPE,
                                      inucate        IN categori.catecodi%TYPE,
                                      inusubcate     IN subcateg.sucacodi%TYPE,
                                      inulocalidad   IN ge_geogra_location.geograp_location_id%TYPE,
                                      onuerror       OUT NUMBER,
                                      osberrmen      OUT VARCHAR2) RETURN NUMBER IS

        nuCommercialplan mo_motive.commercial_plan_id%TYPE;
        cnuVentaCotizada NUMBER := 100229;

        CURSOR cuCommercialPlan IS
            SELECT commercial_plan_id
            FROM   mo_motive
            WHERE  PACKAGE_id = inupackages_id;

        CURSOR cuconceptosForm IS
            SELECT /*+ index(c IX_CARGOS03) */
             l.conccodi,
             l.subsidy_percentage,
             l.subsidy_value
            FROM   CONCSOPL          c,
                   ld_subsidy_detail l
            WHERE  c.cosoconc = l.conccodi
            AND    c.cosoplsu = nuCommercialplan
            AND    c.cososerv = ld_boconstans.cnuGasService
            AND    c.cosoacti = ld_boconstans.csbokFlag
            AND    l.ubication_id = inuubication;

        CURSOR cuconceptos IS
            SELECT /*+ index(c IX_CARGOS03) */
             l.conccodi,
             l.subsidy_percentage,
             l.subsidy_value
            FROM   ld_subsidy_detail l
            WHERE  l.ubication_id = inuubication;

        nuindividualsubsidyvalue ld_subsidy.authorize_value%TYPE;
        nuconcepvalue            ld_subsidy_detail.subsidy_value%TYPE;
        nuliqconcepvalue         ld_subsidy_detail.subsidy_value%TYPE;
        -- Producto
        rcProduct servsusc%ROWTYPE;
        -- Periodo de consumo
        nuConsPeriod pericose.pecscons%TYPE;
        -- Periodo de facturacion
        rcCurrentBillPeriod perifact%ROWTYPE;
        -- Concepto
        nuConcept concepto.conccodi%TYPE;
        --Id de la solicitud en proceso
        nuPackageID    mo_packages.package_id%TYPE;
        sbCurrinstance VARCHAR2(200);
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetindividualsubvalue=' ||
                       inupackages_id,
                       10);
        OPEN cuCommercialPlan;
        FETCH cuCommercialPlan
            INTO nuCommercialplan;
        CLOSE cuCommercialPlan;

        IF (damo_packages.fnugetpackage_type_id(inupackages_id) <>
           cnuVentaCotizada) THEN

            IF (nuCommercialplan IS NULL) THEN
                -- Obtiene el producto de la instancia

                nuCommercialplan := dapr_product.fnugetcommercial_plan_id(mo_bopackages.fnugetproduct(inupackages_id));
            END IF;

            /*Obtener el valor individual de los conceptos en comun*/
            FOR rgconceptos IN cuconceptosForm LOOP
                /*Se verifica si la varible seteada en la venta por formulario se encuentra
                 con valor 1. De ser asi se obtiene el valor por concepto a partir de una
                 regla de liquidacion de conceptos
                */
                IF nuswsalebyform = ld_boconstans.cnuonenumber THEN

                    ---------------Obtener datos de la instancia------------------------

                    -- Obtiene el producto de la instancia
                    pkInstanceDataMgr.GetCG_ProductRecord(rcProduct);
                    -- Obtiene el periodo de consumo de la instancia
                    pkInstanceDataMgr.GetCG_ConsumPeriod(nuConsPeriod);
                    -- Obtiene el periodo de facturacion de la instancia
                    pkInstanceDataMgr.GetCG_BillPeriodRecord(rcCurrentBillPeriod);
                    -- Obtiene el concepto de la instancia
                    pkInstanceDataMgr.GetCG_Concept(nuConcept);
                    --Obtiene la solicitud de la instancia
                    pkinstancedatamgr.GetCG_Package(nuPackageID);

                    /*Asigna el PACKAGE Id con el que llega parametro si el de la
                    instancia es nulo*/
                    nuPackageID := nvl(nuPackageID, inupackages_id);
                    ----------------------------------------------------------------------
                    --Obtener el valor de liquidacion del concepto
                    nuliqconcepvalue := Ld_BoSubsidy.fnugetliqbaseconc(rcProduct,
                                                                       rcCurrentBillPeriod,
                                                                       rgconceptos.conccodi,
                                                                       nuConsPeriod,
                                                                       nuPackageID);

                    --Obtener el valor configurado para el concepto en la tabla ld_asig_subsidy
                    /*Si el concepto fue parametrizado por valor*/
                    IF (rgconceptos.subsidy_value IS NOT NULL) AND
                       (nuliqconcepvalue > 0) THEN
                        UT_Trace.Trace('Valor rgconceptos.subsidy_value' ||
                                       rgconceptos.subsidy_value,
                                       15);
                        nuconcepvalue := rgconceptos.subsidy_value;
                    END IF;

                    /*Si el concepto fue parametrizado por porcentaje*/
                    IF rgconceptos.subsidy_percentage IS NOT NULL THEN
                        nuconcepvalue := Fnupercentageconcvalue(rgconceptos.conccodi,
                                                                ld_boconstans.cnuGasService,
                                                                inucate,
                                                                inusubcate,
                                                                inulocalidad,
                                                                nvl(damo_packages.fdtgetrequest_date(nuPackageID,
                                                                                                     0),
                                                                    SYSDATE),
                                                                rgconceptos.subsidy_percentage);

                    END IF;

                    --Se vaida que el valor parametrizado no sea mayor al liquidado
                    IF nvl(nuconcepvalue, 0) > nvl(nuliqconcepvalue, 0) THEN
                        /*Se verifica si no se puede aplicar saldo a favor entonces
                        el valor del concepto es el valor liquidado*/
                        IF nvl(ld_boconstans.csbapplybalance, 'X') <>
                           nvl(ld_boconstans.csbafirmation, 'Z') THEN
                            nuconcepvalue := nuliqconcepvalue;
                        END IF;
                    END IF;

                ELSE

                    /*Si el concepto fue parametrizado por valor*/
                    IF rgconceptos.subsidy_value IS NOT NULL THEN
                        nuconcepvalue := rgconceptos.subsidy_value;
                    END IF;

                    /*Si el concepto fue parametrizado por porcentaje*/
                    IF rgconceptos.subsidy_percentage IS NOT NULL THEN
                        nuconcepvalue := Fnupercentageconcvalue(rgconceptos.conccodi,
                                                                ld_boconstans.cnuGasService,
                                                                inucate,
                                                                inusubcate,
                                                                inulocalidad,
                                                                nvl(damo_packages.fdtgetrequest_date(nvl(nuPackageID,
                                                                                                         inupackages_id),
                                                                                                     0),
                                                                    SYSDATE),
                                                                rgconceptos.subsidy_percentage);

                    END IF;
                END IF;

                nuindividualsubsidyvalue := nvl(nuindividualsubsidyvalue, 0) +
                                            nuconcepvalue;

            --Falta validar que pasa cuando el valor a subsidiar es mayor que el valor de una regla
            --de liquidacion que obtiene el valor del concepto
            END LOOP;
        ELSE

            /*Obtener el valor individual de los conceptos en comun*/
            FOR rgconceptos IN cuconceptos LOOP
                /*Se verifica si la varible seteada en la venta por formulario se encuentra
                 con valor 1. De ser asi se obtiene el valor por concepto a partir de una
                 regla de liquidacion de conceptos
                */
                IF nuswsalebyform = ld_boconstans.cnuonenumber THEN

                    ---------------Obtener datos de la instancia------------------------

                    -- Obtiene el producto de la instancia
                    pkInstanceDataMgr.GetCG_ProductRecord(rcProduct);
                    -- Obtiene el periodo de consumo de la instancia
                    pkInstanceDataMgr.GetCG_ConsumPeriod(nuConsPeriod);
                    -- Obtiene el periodo de facturacion de la instancia
                    pkInstanceDataMgr.GetCG_BillPeriodRecord(rcCurrentBillPeriod);
                    -- Obtiene el concepto de la instancia
                    pkInstanceDataMgr.GetCG_Concept(nuConcept);
                    --Obtiene la solicitud de la instancia
                    pkinstancedatamgr.GetCG_Package(nuPackageID);

                    nuPackageID := nvl(nuPackageID, inupackages_id);
                    ----------------------------------------------------------------------
                    --Obtener el valor de liquidacion del concepto
                    nuliqconcepvalue := Ld_BoSubsidy.fnugetliqbaseconc(rcProduct,
                                                                       rcCurrentBillPeriod,
                                                                       rgconceptos.conccodi,
                                                                       nuConsPeriod,
                                                                       nuPackageID);

                    --Obtener el valor configurado para el concepto en la tabla ld_asig_subsidy
                    /*Si el concepto fue parametrizado por valor*/
                    IF (rgconceptos.subsidy_value IS NOT NULL) AND
                       (nuliqconcepvalue > 0) THEN
                        UT_Trace.Trace('Valor rgconceptos.subsidy_value' ||
                                       rgconceptos.subsidy_value,
                                       15);
                        nuconcepvalue := rgconceptos.subsidy_value;
                    END IF;

                    /*Si el concepto fue parametrizado por porcentaje*/
                    IF rgconceptos.subsidy_percentage IS NOT NULL THEN
                        nuconcepvalue := Fnupercentageconcvalue(rgconceptos.conccodi,
                                                                ld_boconstans.cnuGasService,
                                                                inucate,
                                                                inusubcate,
                                                                inulocalidad,
                                                                nvl(damo_packages.fdtgetrequest_date(nuPackageID,
                                                                                                     0),
                                                                    SYSDATE),
                                                                rgconceptos.subsidy_percentage);

                    END IF;

                    --Se vaida que el valor parametrizado no sea mayor al liquidado
                    IF nvl(nuconcepvalue, 0) > nvl(nuliqconcepvalue, 0) THEN
                        /*Se verifica si no se puede aplicar saldo a favor entonces
                        el valor del concepto es el valor liquidado*/
                        IF nvl(ld_boconstans.csbapplybalance, 'X') <>
                           nvl(ld_boconstans.csbafirmation, 'Z') THEN
                            nuconcepvalue := nuliqconcepvalue;
                        END IF;
                    END IF;

                ELSE

                    /*Si el concepto fue parametrizado por valor*/
                    IF rgconceptos.subsidy_value IS NOT NULL THEN
                        nuconcepvalue := rgconceptos.subsidy_value;
                    END IF;

                    /*Si el concepto fue parametrizado por porcentaje*/
                    IF rgconceptos.subsidy_percentage IS NOT NULL THEN

                        nuConcepValue := Fnupctconcvalue(rgConceptos.Conccodi,
                                                         inupackages_id,
                                                         rgConceptos.Subsidy_percentage);

                        IF nuConcepValue IS NULL THEN

                            nuconcepvalue := Fnupercentageconcvalue(rgconceptos.conccodi,
                                                                    ld_boconstans.cnuGasService,
                                                                    inucate,
                                                                    inusubcate,
                                                                    inulocalidad,
                                                                    nvl(damo_packages.fdtgetrequest_date(nvl(nuPackageID,
                                                                                                             inupackages_id),
                                                                                                         0),
                                                                        SYSDATE),
                                                                    rgconceptos.subsidy_percentage);
                        END IF;

                    END IF;
                END IF;

                nuindividualsubsidyvalue := nvl(nuindividualsubsidyvalue, 0) +
                                            nuconcepvalue;

            --Falta validar que pasa cuando el valor a subsidiar es mayor que el valor de una regla
            --de liquidacion que obtiene el valor del concepto
            END LOOP;

        END IF;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetindividualsubvalue=' ||
                       nuindividualsubsidyvalue,
                       10);
        RETURN(nuindividualsubsidyvalue);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetindividualsubvalue;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : ApplySubInCurrentDebt
       Descripcion    : Aplica el subsidio remanente a la deuda corriente
                        de los conceptos a subsidiar que esten en comun
                        a los conceptos asociados al plan comercial de
                        la solicitud

       Autor          : jonathan alberto consuegra lara
       Fecha          : 17/06/2013

       Parametros       Descripcion
       ============     ===================


       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       17/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ApplySubInCurrentDebt(ionusubvalue      IN OUT ld_subsidy.authorize_value%TYPE,
                                    inususcripc       IN suscripc.susccodi%TYPE,
                                    inucommercialplan IN mo_motive.commercial_plan_id%TYPE,
                                    inuubication      IN ld_ubication.ubication_id%TYPE,
                                    inutotalremain    IN ld_subsidy.authorize_value%TYPE,
                                    inusesion         IN NUMBER,
                                    inupackage_id     IN mo_packages.package_id%TYPE,
                                    inunuse           IN servsusc.sesunuse%TYPE,
                                    onuerror          OUT NUMBER,
                                    osberrmen         OUT VARCHAR2) IS
        CURSOR cuAccount IS
            SELECT c.cucocodi,
                   c.cucofact
            FROM   cuencobr c
            WHERE  c.cuconuse = inunuse
            AND    c.cucosacu > ld_boconstans.cnuCero_Value
            ORDER  BY c.cucofeve;

        --------------------------------------------------------------
        TYPE Concepto IS RECORD(
            concepto     NUMBER(4),
            concsubvalue NUMBER(13, 2),
            saldoconc    cargos.cargvalo%TYPE,
            cucocodi     cuencobr.cucocodi%TYPE,
            cucofact     cuencobr.cucofact%TYPE);

        TYPE Conceptos IS TABLE OF Concepto INDEX BY BINARY_INTEGER;

        tConceptos Conceptos;
        --------------------------------------------------------------

        nucurrentdebt   NUMBER;
        tbSaldoConc     pkBalanceConceptMgr.tytbSaldoConc;
        nuconcindex     NUMBER;
        nuporcion       ld_subsidy.authorize_value%TYPE;
        nuDocTypeId     ge_document_type.document_type_id%TYPE;
        orcnota         notas%ROWTYPE;
        nucargvalue     cargos.cargvalo%TYPE;
        nuNoteFactCause causcarg.cacacodi%TYPE;
        nuappconc       ld_subsidy.conccodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ApplySubInCurrentDebt', 1);

        nuconcindex := ld_boconstans.cnuonenumber;

        nuporcion := ionusubvalue;

        /*Determinar si la persona tiene deuda corriente pendiente*/
        nucurrentdebt := ld_bcsubsidy.Fnuaccountwithdebt(inususcripc, NULL);
        IF nvl(nucurrentdebt, ld_boconstans.cnuCero_Value) >
           ld_boconstans.cnuCero_Value THEN

            /*Aplicar porcion del subsidio al saldo corriente de los conceptos comunes
            entre aquellos parametrizados en el subsidio y el plan comercial de la solicitud*/
            UT_Trace.Trace('Hay deuda corriente', 3);
            /*Cuentas de cobro con saldo*/
            FOR rcAccount IN cuAccount LOOP
                UT_Trace.Trace('Recorriendo cuentas con saldo: cucocodi ' ||
                               rcAccount.cucocodi,
                               5);
                BEGIN
                    pkBalanceConceptMgr.GetBalanceByConc(rcAccount.cucocodi,
                                                         tbSaldoConc);
                EXCEPTION
                    WHEN OTHERS THEN
                        onuerror  := ld_boconstans.cnuGeneric_Error;
                        osberrmen := 'Error obteniendo los saldos de los conceptos de la cuenta de cobro ' ||
                                     rcAccount.cucocodi;
                        GOTO error;
                END;

                /*Conceptos a subsidiar*/
                FOR rcconcepts IN (SELECT l.conccodi
                                   FROM   ld_subsidy_detail l
                                   WHERE  l.ubication_id = inuubication) LOOP

                    UT_Trace.Trace('Recorriendo conceptos subsidiados: Concepto ' ||
                                   rcConcepts.conccodi,
                                   10);

                    IF tbSaldoConc.exists(rcconcepts.conccodi) THEN

                        UT_Trace.Trace('Concepto con saldo ' ||
                                       rcConcepts.conccodi,
                                       10);

                        /*Llena tabla PL con los datos de los conceptos a subsidiar*/
                        tConceptos(nuconcindex).concepto := rcconcepts.conccodi;
                        tConceptos(nuconcindex).concsubvalue := ionusubvalue;
                        tConceptos(nuconcindex).saldoconc := tbSaldoConc(rcconcepts.conccodi)
                                                             .nusaldo;
                        tConceptos(nuconcindex).cucofact := rcAccount.cucofact;
                        tConceptos(nuconcindex).cucocodi := rcAccount.cucocodi;

                        /*Aumentar el valor del indice del objeto tipo tabla*/
                        nuconcindex := nuconcindex + ld_boconstans.cnuonenumber;

                    END IF;

                END LOOP;
            END LOOP;

            /*Recorrido de la tabla PL. Si el count de esa tabla es mayor a cero
            cerar la nota credito y por cada concepto un cargo credito*/
            IF tConceptos.count > ld_boconstans.cnuCero_Value THEN
                UT_Trace.Trace('Hay conceptos a subsidiar', 3);
                /*Codigo del tipo de documento*/
                nuDocTypeId := DALD_PARAMETER.fnuGetNumeric_Value('DOC_CREDIT_TYPE_ID');
                IF nuDocTypeId IS NULL THEN
                    onuerror  := ld_boconstans.cnuGeneric_Error;
                    osberrmen := 'No existe tipo de documento configurado en el parametro DOC_CREDIT_TYPE_ID';
                    GOTO error;
                END IF;

                /*Crear nota credito*/
                pkerrors.setapplication(ld_boconstans.csbRemain_Sub_App);
                UT_Trace.Trace('Se creara nota credito en factura ' || tConceptos(tConceptos.first)
                               .cucofact,
                               3);
                fa_bobillingnotes.createbillingnote(inususcripc,
                                                    tConceptos(tConceptos.first)
                                                    .cucofact, --factura
                                                    nuDocTypeId,
                                                    SYSDATE,
                                                    'Se creo la nota credito',
                                                    'NC-REM',
                                                    'C',
                                                    NULL,
                                                    orcnota);

                /*Obtener el concepto de aplicacion del subsidio*/
                nuappconc := dald_subsidy.fnuGetConccodi(dald_ubication.fnuGetSubsidy_Id(inuubication,
                                                                                         NULL),
                                                         NULL);

                IF Nuappconc IS NULL THEN
                    onuerror  := ld_boconstans.cnuGeneric_Error;
                    osberrmen := 'El subsidio ' ||
                                 dald_ubication.fnuGetSubsidy_Id(inuubication,
                                                                 NULL) || '
                            no tiene asociado un concepto de aplicacion';
                    GOTO error;
                END IF;

                FOR i IN tConceptos.FIRST .. tConceptos.LAST LOOP
                    IF tConceptos.EXISTS(i) THEN

                        UT_Trace.Trace('Procesando concepto: ' || tConceptos(i)
                                       .concepto,
                                       4);

                        /*Obtener el porcentaje que representa el valor a distribuir por un concepto
                        del valor total a distribuir*/
                        --nupercentage := ( (tConceptos(i).concsubvalue * 100) / (inutotalremain) );
                        /*Obtener cuanto representa del valor a distribuir el porcentaje obtenido*/
                        --nuvaluetoapply := ( (nuporcion * nupercentage)/(100) );
                        /*Obtener el valor del cargo*/ -----------------------------------
                        IF ionusubvalue <= tConceptos(i).saldoconc THEN
                            UT_Trace.Trace('Valor a subsidiar ' ||
                                           ionusubvalue ||
                                           ' menor o igual al saldo del concepto: ' || tConceptos(i)
                                           .saldoconc,
                                           5);
                            nucargvalue := ionusubvalue;
                        ELSE
                            /*Si es mayor el valor a subsidiar. Aplicar porcion
                            de saldo e ir llevando lo que queda del remamente*/
                            UT_Trace.Trace('Valor a subsidiar ' ||
                                           ionusubvalue ||
                                           ' mayor al saldo del concepto: ' || tConceptos(i)
                                           .saldoconc,
                                           5);
                            nucargvalue := tConceptos(i).saldoconc;
                        END IF;
                        ----------------------------------------------------------------------
                        /*Obtener el codigo de Causal nota de facturacion*/
                        nuNoteFactCause := LD_BOConstans.cnufacturation_note_subsidy;

                        IF nuNoteFactCause IS NULL THEN
                            ROLLBACK;
                            onuerror  := ld_boconstans.cnuGeneric_Error;
                            osberrmen := 'No existe causa de cargo configurada en el parametro FACTURATION_NOTE_SUBSIDY';
                            GOTO error;
                        END IF;

                        UT_Trace.Trace('Detalle Nota: Producto: ' || inunuse ||
                                       ' valor: ' || nucargvalue ||
                                       ' cuenta: ' || tConceptos(i).cucocodi,
                                       10);

                        /*Crear cargo credito por concepto*/
                        FA_BOBillingNotes.DetailRegister(orcnota.notanume,
                                                         inunuse,
                                                         orcnota.notasusc,
                                                         tConceptos(i).cucocodi,
                                                         nuappconc, --tConceptos(i).concepto,
                                                         nuNoteFactCause,
                                                         nucargvalue, --valor del cargo
                                                         NULL,
                                                         'NC-' || inupackage_id,
                                                         'CR',
                                                         'N',
                                                         NULL,
                                                         'Y',
                                                         NULL);

                        /*Si el valor del cargo es igual a lo que se iba a distribuir para el
                        concepto el valor a distribuir para el concepto es cero*/
                        IF nucargvalue = ionusubvalue THEN
                            ionusubvalue := ld_boconstans.cnuCero_Value;
                            EXIT;
                        END IF;

                        ionusubvalue := ionusubvalue - nucargvalue;

                    END IF;
                END LOOP;
            END IF;
        ELSE

            osberrmen := 'El suscriptor ' || inususcripc ||
                         ' no posee deuda corriente';
        END IF;
        <<error>>
        NULL;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ApplySubInCurrentDebt', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ApplySubInCurrentDebt;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : ApplySubIndeferredDebt
       Descripcion    : Aplica el subsidio remanente a la deuda diferida
                        de los conceptos a subsidiar que esten en comun
                        a los conceptos asociados al plan comercial de
                        la solicitud

       Autor          : jonathan alberto consuegra lara
       Fecha          : 18/06/2013

       Parametros       Descripcion
       ============     ===================


       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       18/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE ApplySubIndeferredDebt(ionusubvalue      IN OUT ld_subsidy.authorize_value%TYPE,
                                     inususcripc       IN suscripc.susccodi%TYPE,
                                     inucommercialplan IN mo_motive.commercial_plan_id%TYPE,
                                     inuubication      IN ld_ubication.ubication_id%TYPE,
                                     inutotalremain    IN ld_subsidy.authorize_value%TYPE,
                                     inusesion         IN NUMBER,
                                     inupackage_id     IN mo_packages.package_id%TYPE,
                                     inunuse           IN servsusc.sesunuse%TYPE,
                                     onuerror          OUT NUMBER,
                                     osberrmen         OUT VARCHAR2) IS
        CURSOR cuConceptos IS
            SELECT l.conccodi
            FROM   ld_subsidy_detail l
            WHERE  l.ubication_id = inuubication
            ORDER  BY l.conccodi;

        CURSOR cuDeferredDebt(inuconcepto diferido.difeconc%TYPE) IS
            SELECT nvl(d.difesape, 0) difesape,
                   d.difecodi,
                   d.difeconc
            FROM   diferido d
            WHERE  d.difeconc = inuconcepto
            AND    d.difesape > ld_boconstans.cnuCero_Value
            AND    d.difesusc = inususcripc
            AND    d.difenuse = inunuse
            ORDER  BY d.difefein,
                      d.difeconc;

        nucommonconcepts NUMBER;
        nudifedeuda      diferido.difesape%TYPE;
        nudifecodi       diferido.difecodi%TYPE;
        nutransfervalue  diferido.difesape%TYPE;
        nucont           NUMBER;
        nuconc           diferido.difeconc%TYPE;
        nupercentage     NUMBER;
        nuvaluetoapply   ld_subsidy.authorize_value%TYPE;
        nuconcsubvalue   ld_concepto_rem.asig_value%TYPE;
        nuporcion        ld_subsidy.authorize_value%TYPE;
        nuAccountStatus  factura.factcodi%TYPE;
        nuAccount        cuencobr.cucocodi%TYPE;
        nuDocTypeId      ge_document_type.document_type_id%TYPE;
        orcnota          notas%ROWTYPE;
        nuNoteFactCause  causcarg.cacacodi%TYPE;
        nuappconc        ld_subsidy.conccodi%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.ApplySubIndeferredDebt', 1);

        nucont    := ld_boconstans.cnuonenumber;
        nuporcion := ionusubvalue;

        UT_Trace.Trace('Saldo restante ' || ionusubvalue, 3);
        /*Obtener el concepto de aplicacion del subsidio*/
        nuappconc := dald_subsidy.fnuGetConccodi(dald_ubication.fnuGetSubsidy_Id(inuubication,
                                                                                 NULL),
                                                 NULL);

        /*Validar obtencion de la cuenta de cobro y la factura*/
        IF nuappconc IS NULL THEN
            onuError  := ld_boconstans.cnuGeneric_Error;
            osberrmen := 'El subsidio ' ||
                         dald_ubication.fnuGetSubsidy_Id(inuubication, NULL) ||
                         ' no posee concepto de aplicacion configurado';
            GOTO error;
        END IF;

        /*Determinar si existe conceptos a subsidiar para la poblacion */
        nucommonconcepts := Ld_BcSubsidy.Fnucommonconcepts(NULL,
                                                           NULL,
                                                           inuubication);
        UT_Trace.Trace('Cantidad de conceptos a subsidiar ' ||
                       nucommonconcepts,
                       3);
        IF nucommonconcepts > ld_boconstans.cnuCero_Value THEN

            /*Determinar si la persona tiene deuda diferida pendiente
            por los conceptos a subsidiar*/
            nucont := Ld_BcSubsidy.FnuDeferredDebt(inususcripc,
                                                   NULL,
                                                   inuubication,
                                                   inunuse,
                                                   NULL);

            UT_Trace.Trace('nucont ' || nucont, 3);

            IF nucont = ld_boconstans.cnuCero_Value THEN
                GOTO error;
            END IF;

            FOR rcConceptos IN cuConceptos LOOP

                /*Limpiar tabla PL en donde se adicionan los diferidos*/
                CC_BODefToCurTransfer.GlobalInitialize;

                nudifedeuda := NULL;
                nudifecodi  := NULL;
                nuconc      := NULL;

                FOR rcDeferredDebt IN cuDeferredDebt(rcConceptos.Conccodi) LOOP

                    IF nudifecodi IS NULL THEN
                        nudifecodi := rcDeferredDebt.difecodi;
                    END IF;

                    IF nuconc IS NULL THEN
                        nuconc := rcConceptos.Conccodi;
                    END IF;

                    /*Acumular el valor de la deuda diferida de un concepto*/
                    nudifedeuda := nvl(nudifedeuda, 0) +
                                   nvl(rcDeferredDebt.difesape, 0);
                    cc_bodeftocurtransfer.AddDeferToCollect(rcDeferredDebt.difecodi);
                END LOOP;
                UT_Trace.Trace('Deuda para los conceptos subsidiados ' ||
                               nudifedeuda,
                               3);
                IF nvl(nudifedeuda, ld_boconstans.cnuCero_Value) >
                   ld_boconstans.cnuCero_Value THEN
                    /*Obtener el valor a subsidiar para un concepto. Este valor es digitado desde la forma LDREM
                    nuconcsubvalue := Ld_bcsubsidy.Fnugetsubconcremvalue(nuconc,
                                                                         inuubication,
                                                                         inusesion,
                                                                         NULL);

                    /*Obtener el porcentaje que representa el valor a distribuir por un concepto
                      del valor total a distribuir*/
                    --nupercentage := ( (nuconcsubvalue * 100) / (inutotalremain) );
                    /*Obtener cuanto representa del valor a distribuir del porcentaje obtenido*/
                    --nuvaluetoapply := ( (nuporcion * nupercentage)/(100) );

                    /*Determinar el valor a transferir.
                    Si el valor del subsidio es mayor a la deuda diferida se traslada el valor
                    de la deuda sino se traslada el valor del subsidio*/
                    IF nvl(ionusubvalue, 0) > nvl(nudifedeuda, 0) THEN
                        UT_Trace.Trace('Valor a distribuir mayor al valor de la deuda',
                                       10);
                        nutransfervalue := nudifedeuda;
                    ELSE
                        UT_Trace.Trace('Valor a distribuir menor o igual al valor de la deuda',
                                       10);
                        nutransfervalue := ionusubvalue;
                    END IF;

                    UT_Trace.Trace('Valor del subsidio ' || nutransfervalue,
                                   11);
                    ------------------------------------------------------------------------------
                    cc_bodeftocurtransfer.TransferDebt(ld_boconstans.csbRemain_Sub_App,
                                                       onuerror,
                                                       osberrmen,
                                                       FALSE,
                                                       nutransfervalue,
                                                       SYSDATE);

                    /*Validar que no haya ocurrido ningun error en el proceso*/
                    IF onuerror <> 0 AND osberrmen IS NOT NULL THEN
                        GOTO error;
                    END IF;
                    ------------------------------------------------------------------------------
                    /*Obtener la cuenta de cobro para el cargo credito*/
                    GetOriginAccount(nudifecodi,
                                     inunuse,
                                     nuAccountStatus,
                                     nuAccount);
                    -------------------------------------------------------------------------------
                    /*Validar obtencion de la cuenta de cobro y la factura*/
                    IF nuAccount IS NULL THEN
                        onuError  := ld_boconstans.cnuGeneric_Error;
                        osberrmen := 'Error obteniendo la cuenta de cobro para crear la nota y cargo credito';
                        ROLLBACK;
                        GOTO error;
                    END IF;

                    IF nuAccountStatus IS NULL THEN
                        onuError  := ld_boconstans.cnuGeneric_Error;
                        osberrmen := 'Error obteniendo la factura para crear la nota y cargo credito';
                        ROLLBACK;
                        GOTO error;
                    END IF;
                    -------------------------------------------------------------------------------
                    /*Codigo del tipo de documento*/
                    nuDocTypeId := DALD_PARAMETER.fnuGetNumeric_Value('DOC_CREDIT_TYPE_ID');

                    IF nuDocTypeId IS NULL THEN
                        onuError  := ld_boconstans.cnuGeneric_Error;
                        osberrmen := 'Error obteniendo el tipo de documento de la nota';
                        ROLLBACK;
                        GOTO error;
                    END IF;

                    pkerrors.setapplication(ld_boconstans.csbRemain_Sub_App);

                    UT_Trace.Trace('Se creara nota credito para la factura ' ||
                                   nuAccountStatus,
                                   5);
                    /*Generar nota credito*/
                    fa_bobillingnotes.createbillingnote(inususcripc,
                                                        nuAccountStatus, --factura
                                                        nuDocTypeId,
                                                        SYSDATE,
                                                        'Se creo la nota credito. Cuenta de cobro ' ||
                                                        nuAccount,
                                                        'NC-REM',
                                                        'C',
                                                        NULL,
                                                        orcnota);

                    /*Obtener el codigo de Causal nota de facturacion*/
                    nuNoteFactCause := LD_BOConstans.cnufacturation_note_subsidy;

                    IF nuNoteFactCause IS NULL THEN
                        onuError  := ld_boconstans.cnuGeneric_Error;
                        osberrmen := 'Error obteniendo la causa del cargo';
                        ROLLBACK;
                        GOTO error;
                    END IF;

                    /*Crear Detalle Nota Credito*/

                    UT_Trace.Trace('Creacion de detalle nota credito', pkg_traza.cnuNivelTrzDef);
                    FA_BOBillingNotes.DetailRegister(orcnota.notanume,
                                                     inunuse,
                                                     orcnota.notasusc,
                                                     nuAccount,
                                                     nuappconc,
                                                     nuNoteFactCause,
                                                     nutransfervalue, --valor del cargo
                                                     NULL,
                                                     'NC-' || inupackage_id,
                                                     'CR',
                                                     'N',
                                                     NULL,
                                                     'Y',
                                                     NULL);

                    /*Disminuir disponible de remanente*/
                    ionusubvalue := nvl(ionusubvalue, 0) - nutransfervalue;
                    UT_Trace.Trace('Restante para subsidiar: ' || ionusubvalue,
                                   5);
                ELSE
                    NULL;
                END IF;
            END LOOP;

        ELSE

            onuerror  := ld_boconstans.cnuGeneric_Error;
            osberrmen := 'No existen conceptos a subsidiar que sean comunes al plan comercial de la solicitud';

        END IF;

        <<error>>
        NULL;

        UT_Trace.Trace('Fin Ld_BoSubsidy.ApplySubIndeferredDebt', 1);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ApplySubIndeferredDebt;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetremainsesion
     Descripcion    : Obtiene la sesion de usuario que se usa en el
                      proceso de remanente

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/06/2013

     Parametros       Descripcion
     ============     ===================

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetremainsesion RETURN NUMBER IS

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetremainsesion', pkg_traza.cnuNivelTrzDef);

        RETURN ld_bosubsidy.globalsesion;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetremainsesion', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetremainsesion;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fsbgetestadotecnico
     Descripcion    : Obtiene el estado tecnico de un servicio
                      suscrito

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/06/2013

     Parametros       Descripcion
     ============     ===================
     inunuse          Servicio suscrito

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fsbgetestadotecnico(inunuse servsusc.sesunuse%TYPE)
        RETURN servsusc.sesuesfn%TYPE IS
        sbestadotecnico servsusc.sesuesfn%TYPE;
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fsbgetestadotecnico', pkg_traza.cnuNivelTrzDef);

        BEGIN
            sbestadotecnico := PKTBLSERVSUSC.FSBGETSESUESFN(inunuse);
        EXCEPTION
            WHEN OTHERS THEN
                sbestadotecnico := NULL;
        END;

        RETURN sbestadotecnico;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fsbgetestadotecnico', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fsbgetestadotecnico;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : Fnugetreverseestate
     Descripcion    : Obtiene el estado reversado de un subsidio

     Autor          : jonathan alberto consuegra lara
     Fecha          : 19/06/2013

     Parametros       Descripcion
     ============     ===================


     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     19/06/2013       jconsuegra.SAO156577  Creacion
    ******************************************************************/
    FUNCTION Fnugetreverseestate RETURN ld_subsidy_states.subsidy_states_id%TYPE IS

        nureverseestate ld_subsidy_states.subsidy_states_id%TYPE;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.Fnugetreverseestate', pkg_traza.cnuNivelTrzDef);

        BEGIN
            nureverseestate := ld_boconstans.cnuSubreverstate;
        EXCEPTION
            WHEN OTHERS THEN
                nureverseestate := NULL;
        END;

        RETURN nureverseestate;

        UT_Trace.Trace('Fin Ld_BoSubsidy.Fnugetreverseestate', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END Fnugetreverseestate;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deleteremainsub
       Descripcion    : Borra las simulaciones o distribuciones de la tabla
                        ld_sub_remain_deliv

       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       isbremaintype    tipo de distribucion: S:simulacion, D:distribucion
       inusesion        identificador de la sesion de usuario

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deleteremainsub(isbremaintype IN ld_sub_remain_deliv.state_delivery%TYPE) IS

        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.deleteremainsub', pkg_traza.cnuNivelTrzDef);

        ld_bosubsidy.globaltransfersub := 'Y';

        DELETE FROM ld_sub_remain_deliv l
        WHERE  l.state_delivery = isbremaintype;

        COMMIT;

        UT_Trace.Trace('Fin Ld_BoSubsidy.deleteremainsub', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END deleteremainsub;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deleteremainconcepts
       Descripcion    : Borra los conceptos de la tabla LD_CONCEPTO_REM


       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       inusesion        identificador de la sesion de usuario

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deleteremainconcepts(inusesion IN NUMBER) IS

        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.deleteremainconcepts', pkg_traza.cnuNivelTrzDef);

        DELETE FROM LD_CONCEPTO_REM l WHERE l.sesion = inusesion;

        COMMIT;
        UT_Trace.Trace('Fin Ld_BoSubsidy.deleteremainconcepts', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END deleteremainconcepts;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deletetemp_clob_fact
       Descripcion    : Borra los registros de la tabla temp_clob_fact
                        asociados a una sesion de usuario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       inusesion        identificador de la sesion de usuario

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deletetemp_clob_fact(inusesion IN NUMBER) IS

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.deletetemp_clob_fact', pkg_traza.cnuNivelTrzDef);

        DELETE FROM ld_temp_clob_fact l WHERE l.sesion = inusesion;

        COMMIT;

        UT_Trace.Trace('Fin Ld_BoSubsidy.deletetemp_clob_fact', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END deletetemp_clob_fact;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : fnugetliqbaseconc
       Descripcion    : Obtiene el valor con el cual se esta liquidando un
                        concepto durante el proceso de venta por formulario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 24/06/2013

       Parametros       Descripcion
       ============     ===================
       ircProduct       registro, fila, del producto
       ircBillingPeriod registro, fila, del periodo de facturacion
       inuConcept       identificador del concepto
       inuConsPeriod    identificador del periodo de consumo
       inuPackage_Id    identificador de la solicitud de venta

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       24/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION fnugetliqbaseconc(ircProduct       IN servsusc%ROWTYPE,
                               ircBillingPeriod IN perifact%ROWTYPE,
                               inuConcept       IN concepto.conccodi%TYPE,
                               inuConsPeriod    IN pericose.pecscons%TYPE,
                               inuPackage_Id    IN mo_packages.package_id%TYPE)
        RETURN cargos.cargvalo%TYPE IS

        -- Valor total liquidado de los conceptos base
        nuTotalValue cargos.cargvalo%TYPE;
        -- Tabla de conceptos base de liquidacion
        tbConcepts pkBCConcbali.tyCoblConc;
        -- Indica para recorrer tabla de conceptos
        nuIdx BINARY_INTEGER;
        -- Valor del cargo encontrado
        nuChargeValue cargos.cargvalo%TYPE;
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnugetliqbaseconc', pkg_traza.cnuNivelTrzDef);

        --Setear variable nuTotalValue
        nuTotalValue := ld_boconstans.cnuCero_Value;
        --Limpiar objeto
        tbConcepts.DELETE;
        tbConcepts(1) := inuConcept;
        nuIdx := tbConcepts.FIRST;

        IF (nuIdx IS NULL) THEN
            RETURN nuTotalValue;
        END IF;

        LOOP

            EXIT WHEN nuIdx IS NULL;

            pkBORatingMemoryMgr.GetChargeValue(ircProduct.sesunuse,
                                               ircBillingPeriod.pefacodi,
                                               inuConsPeriod,
                                               tbConcepts(nuIdx),
                                               nuChargeValue);

            UT_Trace.Trace('Memoria: Concepto [' || tbConcepts(nuIdx) ||
                           '] Valor [' || nuChargeValue || ']',
                           3);
            -- Obtiene el valor liquidado del concepto
            nuTotalValue := nuTotalValue + nvl(nuChargeValue, 0);
            nuIdx        := tbConcepts.NEXT(nuIdx);

        END LOOP;

        RETURN nuTotalValue;
        UT_Trace.Trace('Fin Ld_BoSubsidy.fnugetliqbaseconc', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN OTHERS THEN
            RETURN nuTotalValue;
    END fnugetliqbaseconc;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : deleteremainsimulation
       Descripcion    : Borra los registros de la tabla ld_sub_remain_deliv
                        en estado simulacion asociados a una sesion de usuario

       Autor          : jonathan alberto consuegra lara
       Fecha          : 20/06/2013

       Parametros       Descripcion
       ============     ===================
       inusesion        identificador de la sesion de usuario
       isbstate         identificador de estado simulacion de remanente

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       20/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    PROCEDURE deleteremainsimulation(inusesion IN NUMBER,
                                     isbstate  IN ld_sub_remain_deliv.state_delivery%TYPE) IS

        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.deleteremainsimulation', pkg_traza.cnuNivelTrzDef);

        DELETE FROM ld_sub_remain_deliv l
        WHERE  l.sesion = inusesion
        AND    l.state_delivery = isbstate;

        COMMIT;

        UT_Trace.Trace('Fin Ld_BoSubsidy.deleteremainsimulation', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END deleteremainsimulation;

    /************************************************************************
      Propiedad intelectual de Open International Systems (c).

       Unidad         : fnugetremainsub
       Descripcion    : Obtiene el valor remanente de un subsidio

       Autor          : jonathan alberto consuegra lara
       Fecha          : 27/06/2013

       Parametros       Descripcion
       ============     ===================
       inusubsidy       identificador del subsidio

       Historia de Modificaciones
       Fecha            Autor                 Modificacion
       =========        =========             ====================
       27/06/2013       jconsuegra.SAO156577  Creacion
    /*************************************************************************/
    FUNCTION fnugetremainsub(inusubsidy IN ld_subsidy.subsidy_id%TYPE)
        RETURN ld_subsidy.authorize_value%TYPE IS
        nuremainsub ld_subsidy.authorize_value%TYPE;
    BEGIN
        UT_Trace.Trace('Inicio Ld_BoSubsidy.fnugetremainsub', pkg_traza.cnuNivelTrzDef);

        nuremainsub := nvl(dald_subsidy.fnuGetTotal_Available(inusubsidy, NULL),
                           dald_subsidy.fnuGetAuthorize_Value(inusubsidy, NULL));

        RETURN(nuremainsub);
        UT_Trace.Trace('Fin Ld_BoSubsidy.fnugetremainsub', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnugetremainsub;

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
      19/11/2013    anietoSAO223767    1 - Creacion. Extraccion de un registro de
                                           la tabla ld_subsidy.
    *******************************************************************************/
    PROCEDURE GetSubSidy(isbDescription IN ld_subsidy.description%TYPE,
                         inuDealId      IN ld_subsidy.deal_id%TYPE,
                         idtInitialDate IN ld_subsidy.initial_date%TYPE,
                         idtFinalDate   IN ld_subsidy.final_date%TYPE,
                         idtStartDate   IN ld_subsidy.star_collect_date%TYPE,
                         inuConceptId   IN ld_subsidy.conccodi%TYPE,
                         ocuSubsidy     OUT pkConstante.tyRefCursor) IS
    BEGIN
        UT_Trace.Trace('Inicio LD_BOSUBSIDY.GetSubSidy', 2);

        UT_Trace.Trace('isbDescription [' || isbDescription || ']', 4);
        UT_Trace.Trace('inuDealId [' || inuDealId || ']', 4);
        UT_Trace.Trace('idtInitialDate [' || idtInitialDate || ']', 4);
        UT_Trace.Trace('idtFinalDate [' || idtFinalDate || ']', 4);
        UT_Trace.Trace('idtStartDate [' || idtStartDate || ']', 4);
        UT_Trace.Trace('inuConceptId [' || inuConceptId || ']', 4);

        ld_bcsubsidy.GetSubSidy(isbDescription,
                                inuDealId,
                                idtInitialDate,
                                idtFinalDate,
                                idtStartDate,
                                inuConceptId,
                                ocuSubsidy);

        UT_Trace.Trace('fin LD_BOSUBSIDY.GetSubSidy', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END GetSubSidy;

    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : ValidateSubsidyProm
    Descripcion    : Realiza las validaciones de los subsidios a asignar
    Autor          : Albeyro Echevery Pineda
    Fecha          : 09/Ene/2014

    Parametros             Descripcion
    ============           ======================================================
    inuSubscriberId         Cliente
    inuproductId            Producto
    inuMotiveId             motivo
    inuAddressId            Direccion
    inuCategory             Categoria
    inuSubcateg             Subcategoria

    Historia de Modificaciones
    Fecha            Autor           Modificacion
    ============  =================  ============================================
    09/01/2013}4    AEcheverrySAO228431    <<Creacion>>
    *******************************************************************************/
    PROCEDURE ValidateSubsidyProm(inuSubscriberId IN suscripc.suscclie%TYPE,
                                  inuproductId    IN pr_product.product_id%TYPE,
                                  inuMotiveId     IN mo_motive.motive_id%TYPE,
                                  inuAddressId    IN ab_address.address_id%TYPE,
                                  inuCategory     IN servsusc.sesucate%TYPE,
                                  inuSubcateg     IN servsusc.sesusuca%TYPE) IS
        nuPromotionId cc_promotion.promotion_id%TYPE;
        nuLocationId  ge_geogra_location.geograp_location_id%TYPE;
        tbMoPromos    DAMO_Mot_Promotion.tytbMO_mot_promotion;
        nuMoPromoIdx  BINARY_INTEGER;
        nuCategory    servsusc.sesucate%TYPE;
        nuSubcateg    servsusc.sesusuca%TYPE;
        nuSubValue    NUMBER;
    BEGIN
        UT_Trace.Trace('Inicio LD_BOSUBSIDY.ValidateSubsidyProm=' ||
                       inuproductId,
                       10);
        gblValDataSubsidy := TRUE;
        gbProductId       := inuproductId;
        pkInstanceDataMgr.setrecordmotive(damo_motive.frcgetrecord(inuMotiveId));
        -- Se instancia lo que se necesita
        pkInstanceDataMgr.setcg_productrecord(pktblservsusc.frcgetrecord(inuproductId));
        FA_BCChargesGeration.SetProdData(pktblservsusc.frcgetrecord(inuproductId));
        pkinstancedatamgR.setcg_package(DAMO_MOTIVE.fnugetpackage_id(inuMotiveId));
        pkInstanceDataMgr.SetTG_Package(DAMO_MOTIVE.fnugetpackage_id(inuMotiveId));

        nuLocationId   := daab_address.fnuGetGeograp_Location_Id(inuAddressId);
        nuswsalebyform := 1;
        -- se obtienen las promociones del motivo
        MO_BCMotPromotion.GetPromotionsByMotive(inuMotiveId, tbMoPromos);
        nuMoPromoIdx := tbMoPromos.FIRST;
        LOOP
            EXIT WHEN(nuMoPromoIdx IS NULL);
            nuPromotionId := tbMoPromos(nuMoPromoIdx).promotion_id;
            -- solo si la promocion es de tipo subsidio
            IF (dacc_promotion.fnugetprom_type_id(nuPromotionId) =
               ld_boconstans.cnuPromotionType) THEN

                nuSubValue := LD_BOSubsidy.FnuGetMaxSubValue(nuPromotionId,
                                                             inuSubscriberId,
                                                             nuLocationId,
                                                             inuCategory,
                                                             inuSubcateg,
                                                             2);

            END IF;

            nuMoPromoIdx := tbMoPromos.NEXT(nuMoPromoIdx);
        END LOOP;

        tbMoPromos.delete;
        nuswsalebyform := NULL;
        UT_Trace.Trace('fin LD_BOSUBSIDY.ValidateSubsidyProm', pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            gbProductId := NULL;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            gbProductId := NULL;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ValidateSubsidyProm;

    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad         : setValidateSubsidy
    Descripcion    : Indica si se deben realizar las validaciones en el calculo del valor del subsidio
                       (utilizado en la simulacion de liquidacion de la venta de gas por formulario)
    Autor          : Albeyro Echevery Pineda
    Fecha          : 09/Ene/2014

    Parametros             Descripcion
    ============           ======================================================
    iblValue            Indica si se debe (true) o no (false) realizar las validaciones

    Historia de Modificaciones
    Fecha            Autor           Modificacion
    ============  =================  ============================================
    09/01/2013}4    AEcheverrySAO228431    <<Creacion>>
    *******************************************************************************/
    PROCEDURE setValidateSubsidy(iblValue IN BOOLEAN DEFAULT TRUE) IS
    BEGIN
        gblValDataSubsidy := iblValue;
        -- si se debe validar se coloca null
        IF (iblValue) THEN
            gbProductId := NULL;
        END IF;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END setValidateSubsidy;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : AnnulSubsidy
     Descripcion    : Reversa los subsidios asignados por anulacion de venta

     Autor          : Hector Andres Toro Rodriguez
     Fecha          : 22/01/2014

     Parametros           Descripcion
     ============         ===================
     inuAsig_Subsidy_Id   Identificador del registro de la asignacion de subsidio
     InuActReg            Registro actual
     inuTotalReg          Total de registros a procesar
     onuErrorCode         Codigo de error
     osbErrorMessage      Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     15/01/2015       juancr                se modifica para setear  la aplicacion LDANS
                                            ya que se necesita identificar al momento de
                                            actualizar el registro en ld_subsidy la aplicacion LDANS
                                            para no realizar validacion sobre las vigencias en el
                                            trigger TRGBIDURLD_SUBSIDYVALIDATE.
     22/01/2014       htoroSAO230487        Creacion
    ******************************************************************/
    PROCEDURE AnnulSubsidy(inuAsig_Subsidy_Id IN ld_asig_subsidy.asig_subsidy_id%TYPE,
                           InuActReg          IN NUMBER,
                           inuTotalReg        IN NUMBER,
                           onuErrorCode       OUT NUMBER,
                           osbErrorMessage    OUT VARCHAR2) IS

        --cnuNULL_ATTRIBUTE constant number := 2126;
        sbCAUSAL_ID ge_boInstanceControl.stysbValue;
        boCausal    BOOLEAN := FALSE;
        /*Declaracion de variables*/
        nuSubsidy        ld_asig_subsidy.subsidy_id%TYPE;
        nuValSubsidyAsig ld_asig_subsidy.subsidy_value%TYPE;
        nuUbication      ld_asig_subsidy.ubication_id%TYPE;
        rcUbication      dald_ubication.styld_ubication;
        /*Variable tipo registro*/
        sbtypesub    ld_asig_subsidy.type_subsidy%TYPE;
        sbdeliverdoc ld_asig_subsidy.delivery_doc%TYPE;
    BEGIN

        UT_Trace.Trace('Inicio Ld_BoSubsidy.AnnulSubsidy', pkg_traza.cnuNivelTrzDef);

        --15012015 JuanCR [ARA 5917]: se adicionna el proceso LDRSS para que sea instaciado
        pkerrors.setapplication('LDANS');

        sbCAUSAL_ID := ge_boInstanceControl.fsbGetFieldValue('LD_CAUSAL',
                                                             'CAUSAL_ID');

        IF (sbCAUSAL_ID IS NULL) THEN
            boCausal := TRUE;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'El campo causal de reversion, no debe ser nulo.');
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        /*Obtener datos del registro seleccionado desde la grilla, verificar y reversar el subsidio.*/
        nuValSubsidyAsig := Dald_Asig_Subsidy.fnuGetSubsidy_Value(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuSubsidy        := Dald_Asig_Subsidy.fnuGetSubsidy_Id(inuasig_subsidy_Id => inuAsig_Subsidy_Id);
        nuUbication      := Dald_Asig_Subsidy.fnuGetUbication_Id(inuasig_subsidy_Id => inuAsig_Subsidy_Id);

        /*Determinar si la asignacion del subsidio fue para venta por formulario o
        por retroactivo*/
        sbtypesub := dald_asig_subsidy.fsbGetType_Subsidy(inuAsig_Subsidy_Id,
                                                          NULL);

        sbdeliverdoc := dald_asig_subsidy.fsbGetDelivery_Doc(inuAsig_Subsidy_Id,
                                                             NULL);

        /*Si el tipo de subsidio fue por retroactivo y la
        documentacion esta entregada no se lleva a cabo el
        proceso de reversion*/
        IF sbtypesub = ld_boconstans.csbretroactivesale AND
           sbdeliverdoc = ld_boconstans.csbapackagedocok THEN

            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se puede reversar el proceso para un subsidio retroactivo que cuenta con la documentacion entregada');

        END IF;

        /*Obtener la variable de registro de la ubicacion geografica.*/
        /*Obtener datos de la poblacion*/
        DALD_ubication.LockByPkForUpdate(nuUbication, rcUbication);

        /*Setear la variable que me indicara en el trigger trgaiduld_subsidyvalidate
         si se debe hacer la validacion de sumatoria de valores por los
         conceptos parametrizados por porcentaje
        */
        globalasigsub := 'S';

        /*Reversar los valores del subsidio*/
        LD_BOSUBSIDY.Procbalancesub(nuSubsidy,
                                    rcUbication,
                                    nuValSubsidyAsig,
                                    ld_boconstans.cnutwonumber);

        /*Se devuelve al subsidio el valor que se le habia quitado y
        se registra el movimiento de reversion*/
        RegisterReversesubsidy(inuAsig_Subsidy_Id, sbCAUSAL_ID);

        <<error>>
        NULL;

        UT_Trace.Trace('Fin Ld_BoSubsidy.AnnulSubsidy', pkg_traza.cnuNivelTrzDef);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            IF boCausal THEN
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                errors.getError(onuErrorCode, osbErrorMessage);
            END IF;
        WHEN OTHERS THEN
            ROLLBACK;
            Errors.setError;
            IF boCausal THEN
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE
                errors.getError(onuErrorCode, osbErrorMessage);
            END IF;
    END AnnulSubsidy;

    /*****************************************************************
     Propiedad intelectual de PETI

     Unidad         : fnuGetValsubsidioCartas
     Descripcion    : Permite obtener el valor del subsicio para generar
                      las cartas a usuarios potenciales
     Parametros     : Subsidio, Localidad,Categoria ,Subcategoria de la direccion potencial
     Autor          : Alexandra Gordillo - Optima
     Fecha          : 26-08-14
    ******************************************************************/
    FUNCTION fnuGetValsubsidioCartas(inusub     IN ld_subsidy.subsidy_id%TYPE,
                                     inuloca    IN ld_ubication.geogra_location_id%TYPE,
                                     inucate    IN categori.catecodi%TYPE,
                                     inusubcate IN subcateg.sucacodi%TYPE)
        RETURN NUMBER IS

        nuValorSubsidio          NUMBER;
        rfsubsidies              pkConstante.tyRefCursor;
        rfallsubsidies           dald_subsidy.styLD_subsidy;
        nuubication              ld_ubication.ubication_id%TYPE;
        nuPromotion              ld_subsidy.promotion_id%TYPE;
        nusubsidyvalue           ld_subsidy.authorize_value%TYPE;
        onuTotalvalue            ld_subsidy.authorize_value%TYPE;
        osbsubsidydesc           VARCHAR2(100);
        nuindividualsubsidyvalue NUMBER;
        inuubication             NUMBER;

        nuValParametro NUMBER;

    BEGIN

        UT_Trace.Trace('Inicia Ld_BcSubsidy.fnuGetValsubsidioCartas', 1);

        -- Si no se ingresa subsidio en la forma LDGLS
        IF inusub IS NULL THEN
            --Obtener los subsidios parametrizados
            Ld_bcsubsidy.Procgetsubsidies(rfsubsidies);

            LOOP
                FETCH rfsubsidies
                    INTO rfallsubsidies;
                EXIT WHEN rfsubsidies%NOTFOUND;
                --Obtener el codigo de la ubicacion geografica a subsidiar
                nuubication := Ld_bosubsidy.Fnugetsububication(rfallsubsidies.subsidy_id,
                                                               inuloca,
                                                               inucate,
                                                               inusubcate);
                IF nuubication IS NOT NULL THEN
                    --Limpiar la promocion
                    --Obtener la promocion
                    nuPromotion := Dald_Subsidy.fnuGetPromotion_Id(rfallsubsidies.subsidy_id,
                                                                   NULL);
                    --Limpiar el valor del subsidio
                    --Obtener el valor individual del subsidio
                    nusubsidyvalue := Ld_Bosubsidy.FnugetmaxsubsVal(nuPromotion,
                                                                    nuubication,
                                                                    NULL,
                                                                    NULL,
                                                                    ld_boconstans.cnuthreenumber);

                    onuTotalvalue := nvl(onuTotalvalue,
                                         ld_boconstans.cnuCero_Value) +
                                     nvl(nusubsidyvalue,
                                         ld_boconstans.cnuCero_Value);

                    IF nusubsidyvalue IS NOT NULL THEN
                        IF osbsubsidydesc IS NULL THEN
                            osbsubsidydesc := upper(Dald_Subsidy.fsbGetDescription(Dald_Ubication.fnuGetSubsidy_Id(nuubication,
                                                                                                                   NULL),
                                                                                   NULL));
                        ELSE
                            osbsubsidydesc := osbsubsidydesc || ', ' ||
                                              upper(Dald_Subsidy.fsbGetDescription(Dald_Ubication.fnuGetSubsidy_Id(nuubication,
                                                                                                                   NULL),
                                                                                   NULL));
                        END IF;
                    END IF;
                END IF;
            END LOOP;
        ELSE

            --Obtener el codigo de la ubicacion geografica a subsidiar con el subsidio
            UT_Trace.Trace('subsidio ' || inusub || ' localida ' || inuloca ||
                           ' categoria ' || inucate || ' subcategoria ' ||
                           inusubcate,
                           1);
            nuubication := Ld_bosubsidy.Fnugetsububication(inusub,
                                                           inuloca,
                                                           inucate,
                                                           inusubcate);

            UT_Trace.Trace('Ubicacion ' || nuubication, 1);

            IF nuubication IS NOT NULL THEN

                -- Obtener valor individual de subsidio

                nuindividualsubsidyvalue := Ld_bcsubsidy.fnutotalvalconc(nuubication);
                UT_Trace.Trace('Subsidio por valor ' ||
                               nuindividualsubsidyvalue,
                               1);

                onuTotalvalue := nuindividualsubsidyvalue;

                IF nuindividualsubsidyvalue IS NULL THEN
                    -- es por porcentaje obtener del parametro

                    IF (inusubcate) IS NOT NULL THEN

                        IF (inusubcate = 1) THEN
                            nuValParametro := DALD_PARAMETER.fnuGetNumeric_Value('VAL_SUB_CARTA_ESTRATO_1',
                                                                                 NULL);
                        END IF;

                        IF (inusubcate = 2) THEN
                            nuValParametro := DALD_PARAMETER.fnuGetNumeric_Value('VAL_SUB_CARTA_ESTRATO_2',
                                                                                 NULL);
                        END IF;

                        IF (inusubcate = 3) THEN
                            nuValParametro := DALD_PARAMETER.fnuGetNumeric_Value('VAL_SUB_CARTA_ESTRATO_3',
                                                                                 NULL);
                        END IF;

                        IF (nuValParametro IS NULL) THEN
                            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                             'No se encuentra valor para el parametro VAL_SUB_CARTA_ESTRATO_' ||
                                                             inusubcate);

                        ELSE
                            onuTotalvalue := nuValParametro;
                        END IF;

                        UT_Trace.Trace('Subsidio por porcentaje ' ||
                                       onuTotalvalue,
                                       1);

                    END IF;
                END IF;

                onuTotalvalue := nvl(onuTotalvalue, ld_boconstans.cnuCero_Value);

            END IF;
            -- ut_trace.trace ('No se obtuvo la ubicacion ',1);
        END IF;

        UT_Trace.Trace('Fin Ld_BcSubsidy.fnuGetValsubsidioCartas', 1);

        RETURN onuTotalvalue;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fnuGetValsubsidioCartas;

END LD_BOSUBSIDY;
/
GRANT EXECUTE on LD_BOSUBSIDY to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LD_BOSUBSIDY to REXEOPEN;
GRANT EXECUTE on LD_BOSUBSIDY to RSELSYS;
GRANT DEBUG on LD_BOSUBSIDY to INNOVACIONBI;
/
