CREATE OR REPLACE PACKAGE LDC_PKVALORESRECLAMO is

  /**************************************************************************
      Autor       : F Castro
      Fecha       : 2017-03-31
      Descripcion : Funcionalidad para Valores en Reclamo

      Parametros Entrada
        nuano A?o
        numes Mes

      Valor de salida
        sbmen  mensaje
        error  codigo del error

     HISTORIA DE MODIFICACIONES
       FECHA        AUTOR   DESCRIPCION

  ***************************************************************************/

  /*CURSOR cuInsurDebtExpValue(inuNuse in diferido.difenuse%type, inuCuenta cuencobr.cucocodi%type) IS
             SELECT sum(cargvalo)valor
               FROM cargos
              WHERE cargconc IN
                    (SELECT TO_NUMBER(COLUMN_VALUE)
                       FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(nuInsuranceConcept || '|' ||
                                                               DALD_PARAMETER.fsbGetValue_Chain('CONCEPTOS_MORA_FNB',0),'|')))
                AND cargsign = sbDBSign
                AND cargnuse = inuNuse
                AND cargcuco = inuCuenta;


  LD_BONONBANKFINANCING.getblockUnblocQuoteData
                */

  ------------------
  -- Constantes
  ------------------
  csbYes             constant varchar2(1) := 'Y';
  csbNo              constant varchar2(1) := 'N';
  cnuValorTopeAjuste constant number := 1;
  -- Error en la configuracion normal de cuotas
  cnuERROR_CUOTA constant number(6) := 10381;
  /*INICIO proceso del periodo de gracia para los diferidos registrados en la tabla de reclamos*/
  nuGracePeriod number := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_RECLAMOS'));

  -----------------------
  -- Variables
  -----------------------
  nuConfiguracion number;

  nuSuscripcion suscripc.susccodi%type; -- := 617177;
  nuServsusc    servsusc.sesunuse%type; -- := 617177;
  nuServicio    servsusc.sesuserv%type;
  nuConcepto    cargos.cargconc%type; -- := 30;
  nuCausal      cargos.cargcaca%type; -- := 2;
  nuValor       cargos.cargvalo%type; -- := 999;
  nuSigno       cargos.cargsign%type;
  nuPlanFina    diferido.difepldi%type; -- := 38;
  nuCuentas     diferido.difenucu%type; --:= 12;
  sbObserv      notas.notaobse%type; -- := 'PRUEBA NOTA';
  nuTipo        number;
  nucuentacobro number;

  -- Variables para hallar configuracion
  nuDepartamento ge_geogra_location.geo_loca_father_id%type;
  nuLocalidad    ge_geogra_location.geograp_location_id%type;
  nuCategoria    servsusc.sesucate%type;
  nuSubCategoria servsusc.sesusuca%type;
  nuMercado      fa_locamere.lomrmeco%type;

  /* sbProgram     varchar2(100)*/

  nuPrograma cargos.cargprog%type := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PROCESO_EJECUTADO')); --20; -- 2014 es programa de ajustes
  nunotacons notas.notacons%type := to_number(dald_parameter.fnuGetNumeric_Value('COD_TIPO_DOCU_NOTA_SOLIRECLAMO')); --70; -- tipo documento para ND
  nuDepa     cuencobr.cucodepa%type;
  nuLoca     cuencobr.cucoloca%type;

  FUNCTION GetDatosContrato(inucontrato in servsusc.sesususc%type)
    return pkConstante.tyRefCursor;

  FUNCTION GetDatosCuentas(inucontrato in servsusc.sesususc%type)
    return pkConstante.tyRefCursor;

  FUNCTION GetDatosCargos(inucuenta in cargos.cargcuco%type)
    return pkConstante.tyRefCursor;

  FUNCTION fnuGetIssuscrip(inufact in factura.factcodi%type) return number;

  FUNCTION FnuValidatePackage(inuPackage mo_packages.package_id%type)

   RETURN NUMBER;
  FUNCTION Fnuconsperigracdif(inudife diferido.difecodi%type)

   RETURN NUMBER;

  Function GetCursorVlrReclamo return pkConstante.tyRefCursor;

  Procedure prApplyVlrReclamo(InCodiRecl      number,
                              InuActReg       number,
                              InuTotalReg     number,
                              OnuErrorCode    out number,
                              OsbErrorMessage out varchar2);

  PROCEDURE Generate(onuErrorCode out number, osbErrorMessage out varchar2);

  PROCEDURE GenProcess;

  PROCEDURE ProcessSubsServices;

  PROCEDURE AddCharge

  (inuConcepto in cargos.cargconc%type,
   isbSigno    in cargos.cargsign%type,
   isbDocSop   in cargos.cargdoso%type,
   inuCausal   in cargos.cargcaca%type,
   inuVlrCargo in cargos.cargvalo%type,
   inuConsDocu in cargos.cargcodo%type,
   isbTipoProc in cargos.cargtipr%type);

  PROCEDURE GenerateCharge(inuConcepto in cargos.cargconc%type,
                           isbSigno    in cargos.cargsign%type,
                           isbDocSop   in cargos.cargdoso%type,
                           inuCausal   in cargos.cargcaca%type,
                           inuVlrCargo in cargos.cargvalo%type,
                           inuConsDocu in cargos.cargcodo%type,
                           isbTipoProc in cargos.cargtipr%type);

  PROCEDURE ProcessCharges;

  PROCEDURE UpdateAccoRec;

  PROCEDURE ProcessGeneratedAcco;

  PROCEDURE AsignaNumeracionFiscal;

  PROCEDURE GenerateAccount;

  PROCEDURE GenerateAccountStatus;

  PROCEDURE UpdateCharges;

  PROCEDURE AdjustAccount;

  PROCEDURE UpdAccoBillValues;

  FUNCTION fnuGetAccountNumber RETURN number;

  FUNCTION fnuGetAccountStNumber RETURN number;

  PROCEDURE AddAccount;

  PROCEDURE AddAccountStatus;

  FUNCTION ValInputData(osbError out varchar2) return number;

  PROCEDURE ValSubsService(inuServsusc in servsusc.sesunuse%type);

  PROCEDURE ValSubscriber(inuSuscripcion in suscripc.susccodi%type);

  PROCEDURE ValSupportDoc(isbDocumento in cargos.cargdoso%type);

  PROCEDURE ValSubsNServ(inuSubscription in suscripc.susccodi%type,
                         inuServNum      in servsusc.sesunuse%type);

  FUNCTION ValConcepto(inuConcepto concepto.conccodi%type) return number;

  FUNCTION ValCausal(inuCausal causcarg.cacacodi%type) return number;

  FUNCTION ValPlanFina(inuPlan plandife.PLDICODI%type) return number;

  FUNCTION fboGetIsNumber(isbValor varchar2) return boolean;

  FUNCTION ValContProdServ(inuSubscription in suscripc.susccodi%type,
                           inuServNum      in servsusc.sesunuse%type,
                           inuserv         in servsusc.sesuserv%type)
    return number;

  PROCEDURE ValGenerationDate(idtFechaGene in date);
  FUNCTION fnuGetAdjustValue RETURN number;

  PROCEDURE CalcAdjustValue(inuFactor      in timoempr.tmemfaaj%type,
                            inuValorCta    in cuencobr.cucovato%type,
                            onuValorAjuste out cargos.cargvalo%type,
                            osbSignoAjuste out cargos.cargsign%type);

  PROCEDURE GetOverChargePercent(inuPlandife         in plandife.pldicodi%type,
                                 onuPercenOverCharge out number);

  PROCEDURE ValInterestConcept(inuConc in concepto.conccodi%type);

  PROCEDURE GenerateBillingNote;

  FUNCTION ProcSoliAct(inuproduc in pr_product.subscription_id%type)
    RETURN NUMBER;
  PROCEDURE PROCinsertdetCargtram(INUCATRCUCO IN cargtram.catrcuco%type,
                                  INUCATRNUSE IN cargtram.catrnuse %type,
                                  INUCATRCONC IN cargtram.catrconc %type,
                                  INUCATRCACA IN cargtram.catrcaca %type,
                                  ISBCATRSIGN IN cargtram.catrsign %type,
                                  INUCATRPEFA IN cargtram.catrpefa %type,
                                  INUCATRVALO IN cargtram.catrvalo %type,
                                  ISBCATRDOSO IN cargtram.catrdoso %type,
                                  INUCATRCODO IN cargtram.catrcodo %type,
                                  INUCATRUSUA IN cargtram.catrusua %type,
                                  ISBCATRTIPR IN cargtram.catrtipr %type,
                                  INUCATRUNID IN cargtram.catrunid %type,
                                  IDTCATRFECR IN cargtram.catrfecr %type,
                                  INUCATRVARE IN cargtram.catrvare %type,
                                  INUCATRCOLL IN cargtram.catrcoll %type,
                                  INUCATRUNRE IN cargtram.catrunre %type,
                                  INUCATRMOTI IN cargtram.catrmoti %type,
                                  INUCATRVBLR IN cargtram.catrvblr %type,
                                  INUCATRVABL IN cargtram.catrvabl %type);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENOTSREC
  Descripcion    : Objeto para la generacion de la ordenes de solicitud de reclamos, dependiendo de la
                   causal registrada en la solicitud
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE PROCGENOTSREC(inuPackage in mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCREGPERIGRACIAREC
  Descripcion    : Objeto para registro del periodo de gracia en la solicitud de reclamos
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE PROCREGPERIGRACIAREC(inuPackage in mo_packages.package_id%type);
  PROCEDURE PROCDISMICARTSOLIREC /*(inuPackage in mo_packages.package_id%type)*/
  ;
  PROCEDURE PROCFINAPERIGRACIAREC(inuPackage in mo_packages.package_id%type);

  FUNCTION FNUGETSOLVALREC(inPackage ldc_reclamos.package_id_recu%TYPE)
    RETURN NUMBER;
  FUNCTION FNUGETVALABOCC(inCcobro cuencobr.cucocodi%TYPE) RETURN NUMBER;
  FUNCTION FNUGETCUCOSACU(inCcobro cuencobr.cucocodi%TYPE) RETURN NUMBER;
  FUNCTION FNUGETVALTOTRECCC(inCcobro   cuencobr.cucocodi%TYPE,
                             inuPackage in mo_packages.package_id%type)
    RETURN NUMBER;
  FUNCTION FNVEXCLUYECONCEPTO(inConcepto CONCEPTO.CONCCODI%TYPE)
    RETURN VARCHAR2;
  FUNCTION FNVCONCEPTOOBLIGATORIO(inConcepto CONCEPTO.CONCCODI%TYPE)
    RETURN VARCHAR2;
  PROCEDURE PROCSOLANULREC(INUPACK         in mo_packages.package_id%type,
                           ONUERRORCODE    out number,
                           OSBERRORMESSAGE out varchar2);

  PROCEDURE Procinidatsolianulrela(inupack         in mo_packages.package_id%type,
                                   osbobs          out mo_packages.comment_%type,
                                   OCONTRACT       OUT MO_MOTIVE.SUBSCRIPTION_ID%type,
                                   onuErrorCode    out number,
                                   osbErrorMessage out varchar2);

  PROCEDURE ProActualizaReceptionType(inuPackage   in mo_packages.package_id%type,
                                      inuReception in mo_packages.reception_type_id%type);
  /*Consulta la interaccion dada uina solicitud*/
  PROCEDURE Progetsolintera(inuPackage     in mo_packages.package_id%type,
                            inuinteraccion out mo_packages.package_id%type);
  /*Actualiza una interaccion dada una solicitud*/
  PROCEDURE ProActualizainteraccion(inuPackage in mo_packages.package_id%type,
                                    inuinterac in mo_packages.package_id%type);

  FUNCTION FNVEXCLUYECAUSAL(inConcepto CAUSCARG.CACACODI%TYPE)
    RETURN VARCHAR2;

  /*Caso 2001648 Valor en reclamo consulta las solicitudes a las que se le pueden interponer un recurso*/
  FUNCTION GetDatosSolictud(inucontrato  in servsusc.sesususc%type,
                            inuSuscriber in mo_packages.subscriber_id%type)
    return pkConstante.tyRefCursor;

  /*Caso 2001648 Valor en reclamo consulta las solicitudes a las que se le pueden interponer un recurso de apelacion*/
  FUNCTION GetDatosSolictudApela(inucontrato  in servsusc.sesususc%type,
                                 inuSuscriber in mo_packages.subscriber_id%type)
    return pkConstante.tyRefCursor;

  /*Caso 2001648 Valor en reclamo consulta los cargos no reclamados para la solicitud seleccionada*/
  FUNCTION GetCargosNoValre(inuPackage in mo_packages.package_id%type)
    return pkConstante.tyRefCursor;

  /*Caso 2001648 Valor en reclamo consulta las respuestas inmediatas de un tramite*/
  FUNCTION GetAnswer(inuPackage_type in mo_packages.package_type_id%type)
    return pkConstante.tyRefCursor;

  /*Caso 2001648 Valor en reclamo eliminar datos de ldc_reclamos*/
  procedure proDelreclamos(inuPackage_id in mo_packages.package_id%type);

  /*Caso 2001648 Actualiza el valor del dato adjunto*/
  procedure proUpdFile(inuPackage_id in mo_packages.package_id%type,
                       inuObject_id  in cc_file.object_id%type);

  procedure proDelFile;

  ---
  Function GetCursorReclamo(inuPackageId in mo_packages.package_id%type)
    return pkConstante.tyRefCursor;

  /*Caso 2001648 Valida concepto subsidio en la lista CONCEPTOS_SUBSI_VALREC*/
  FUNCTION FNUGETVALCONCSUBS(inuConc concepto.conccodi%TYPE) RETURN NUMBER;

  /*Caso 2001648 Obtiene los medio de recpecion*/
  FUNCTION GetReceptiontype return pkConstante.tyRefCursor;

  /*Caso 2001648 Obtiene numero de interaccion*/
  FUNCTION GetInteraccion(inuSusc in suscripc.susccodi%type) return number;

  --CASO 275
  Function GETRECLAMO(nuContrato  SUSCRIPC.SUSCCODI%type,
                      nuSolicitud mo_packages.package_id%type)
    return pkConstante.tyRefCursor;

  Procedure prApplyValorReclamo(InuTipo         number,
                                InuSolicitud    mo_packages.package_id%type,
                                IsbComentario   varchar2,
                                Inureclamosid   number,
                                Inuvalorreclamo number,
                                OnuErrorCode    out NUMBER,
                                OsbErrorMessage out VARCHAR2);
  --FIN CASO 275

end LDC_PKVALORESRECLAMO;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKVALORESRECLAMO is
  /**************************************************************************
      Autor       : F Castro
      Fecha       : 2017-03-31
      Descripcion : Funcionalidad para Valores en Reclamo

      Parametros Entrada
        nuano A?o
        numes Mes

      Valor de salida
        sbmen  mensaje
        error  codigo del error

     HISTORIA DE MODIFICACIONES
       FECHA        AUTOR   DESCRIPCION

  ***************************************************************************/
  ------------------
  -- Tipos de Datos
  ------------------
  --dtfecha date := to_date('30/01/2017', 'dd/mm/yyyy');
  -- Tabla de Estados de cuenta
  TYPE tytbCargfact IS TABLE OF cuencobr.cucofact%type INDEX BY binary_integer;
  tbCargfact tytbCargfact;

  -- Tabla de cuentas de cobro
  TYPE tytbCargcuco IS TABLE OF cargos.cargcuco%type INDEX BY binary_integer;
  tbCargcuco tytbCargcuco;

  -- Tabla de fechas contables
  TYPE tytbCargfeco IS TABLE OF pkbccargos.stycargfeco INDEX BY binary_integer;
  tbCargfeco tytbCargfeco;

  -- Tabla de fechas de creacion del cargo
  TYPE tytbCargfecr IS TABLE OF pkbccargos.stycargfeco INDEX BY binary_integer;
  tbCargdate tytbCargfecr;

  -- Tabla de documentos de soporte
  TYPE tytbCargdoso IS TABLE OF cargos.cargdoso%type INDEX BY binary_integer;
  tbCargdoso tytbCargdoso;

  -- Tabla de documentos de soporte
  TYPE tytbCargtipr IS TABLE OF cargos.cargtipr%type INDEX BY binary_integer;
  tbCargtipr tytbCargtipr;

  -- Tabla de rowids de los cargos
  TYPE tytbRowid IS TABLE OF rowid INDEX BY binary_integer;
  tbRowid tytbRowid;

  --------------------------------
  -- Movimientos de Pagos       --
  --------------------------------
  TYPE tyrcCargos IS RECORD(
    sbRowid  rowid,
    cargconc cargos.cargconc%type,
    cargcaca cargos.cargcaca%type,
    cargsign cargos.cargsign%type,
    cargdoso cargos.cargdoso%type,
    cargvalo cargos.cargvalo%type,
    cargfecr cargos.cargfecr%type,
    cargnuse cargos.cargnuse%type,
    cargpeco cargos.cargpeco%type);

  TYPE tytbCargos IS TABLE OF tyrcCargos INDEX BY BINARY_INTEGER;

  TYPE tyrcMaxPericosePorConcepto IS RECORD(
    rcPeriodoConsumo pericose%rowtype,
    dtFechaUltLiq    feullico.felifeul%type,
    sbTipoCobro      concepto.concticc%type);

  TYPE tytbMaxPericoseConcepto IS TABLE OF tyrcMaxPericosePorConcepto INDEX BY BINARY_INTEGER;

  ------------------
  -- Constantes
  ------------------
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  --csbVersion CONSTANT VARCHAR2(250) := 'SAO258199';

  -- Nombre del programa ejecutor Generate Invoice
  csbPROGRAMA constant varchar2(5) := 'FINAN';

  -- Maximo numero de registros Hash para Parametros o cadenas
  --cnuHASH_MAX_RECORDS constant number := 100000;

  -- Constante de error de no Aplicacion para el API OS_generateInvoice
  --cnuERRORNOAPLI number := 500;

  cnuNivelTrace constant number(2) := 5;
  -----------------------
  -- Variables
  -----------------------
  sbErrMsg varchar2(2000); -- Mensajes de Error

  grcEstadoCta factura%rowtype; -- Global de la factura generada

  -- Concepto de ajuste
  nuConcAjuste concepto.conccodi%type;
  -- Concepto de pago
  --nuConcPago concepto.conccodi%type;
  -- Verifica si se genero la cuenta
  boCuentaGenerada boolean;
  -- Verifica si se genero estado de cuenta
  boAccountStGenerado boolean;
  -- Record del periodo de facturacion current
  rcPerifactCurr perifact%rowtype;
  -- Record de la suscripcion current
  rcSuscCurr suscripc%rowtype;
  -- Record del servicio suscrito current
  rcSeSuCurr servsusc%rowtype;
  -- Numero del estado de cuenta current
  nuEstadoCuenta factura.factcodi%type;
  -- Numero de la cuenta de cobro current
  nuCuenta cuencobr.cucocodi%type;
  -- Numero del Diferido Creado
  nuDiferido diferido.difecodi%type;
  -- Numero de la Nota Creada
  nuNota notas.notanume%type;
  -- Fecha de generacion de las cuentas
  dtFechaGene date;
  -- Programa
  sbApplication varchar2(10);
  -- Fecha contable del periodo contable current
  dtFechaContable date;

  dtFechaCurrent date;
  sbTerminal     factura.factterm%type;

  -- Saldo pendiente de la factura
  nuSaldoFac pkbcfactura.styfactspfa;

  -- Valores facturados cuenta por servicio
  nuVlrFactCta    cuencobr.cucovafa%type;
  nuVlrIvaFactCta cuencobr.cucoimfa%type;

  -- Valores facturados de la factura
  nuVlrFactFac    pkbcfactura.styfactvafa;
  nuVlrIvaFactFac pkbcfactura.styfactivfa;

  --gnuCouponPayment pagos.pagocupo%type; -- Cupon de Pago

  -- Variables de valores de cartera actualizados despues de realizar
  -- una actualizacion
  nuCart_ValorCta cuencobr.cucovato%type; -- Valor cuenta
  nuCart_AbonoCta cuencobr.cucovaab%type; -- Abonos cuenta
  nuCart_SaldoCta cuencobr.cucosacu%type; -- Saldo cuenta

  -- Tipo de documento
  gnuTipoDocumento ge_document_type.document_type_id%type;

  nugNumServ servsusc.sesunuse%type; -- Numero servicio
  --dtgProceso  diferido.difefein%type; -- Fecha proceso
  --nugPorcMora plandife.pldiprmo%type;
  /*  nugCiclo    ciclo.ciclcodi%type; -- Codigo Ciclo Facturacion
  nugAno      perifact.pefaano%type; -- Ano periodo current
  nugMes      perifact.pefames%type; -- Mes periodo current
  nugPeriodo  perifact.pefacodi%type; -- Periodo current*/
  --nugTasaInte diferido.difetain%type; -- Codigo Tasa Interes
  cnuBadOverChargePercent constant number(6) := 120782;

  --sbgUser     varchar2(50); -- Nombre usuario
  --sbgTerminal varchar2(50); -- Terminal
  --gnuPersonId ge_person.person_id%type; -- Id de la persona
  nuIdxDife number; -- Indice de tabla de diferidos

  --tbgDeferred      mo_tytbdeferred;
  tbgExtraPayments mo_tytbextrapayments;
  --tbgCharges       mo_tytbCharges;
  --tbgQuotaSimulate mo_tytbQuotaSimulate;
  tbExtraPayment cc_bcfinancing.tytbExtraPayment;
  -- nugSubscription  suscripc.susccodi%type;

  --nugFinanCode diferido.difecofi%type;

  --nugMetodo        diferido.difemeca%type; -- Metodo Cuota
  --nugPlan          diferido.difepldi%type; -- Plan del Diferido
  --nugFactor        diferido.difefagr%type; -- Factor Gradiente
  --nugSpread        diferido.difespre%type; -- valor del Spread
  --nugPorcInteres   diferido.difeinte%type; -- Interes Efectivo
  --nugPorIntNominal diferido.difeinte%type; -- Interes Nominal
  nugNumCuotaExt cuotextr.cuexnume%type; -- Numero de Cuota extras
  nuIdxExtr      number; -- Indice de tabla Cuotras Extras
  nugVlrFinIva   diferido.difevatd%type;

  -- Acumuladores de cuotas extras por numero de cuota
  type tytbAcumExtraPay IS table of number index BY binary_integer;
  tbgAcumExtraPay tytbAcumExtraPay;

  nugVlrFinTotal diferido.difevatd%type; -- Valor total financiacion aplicado el porcentaje a financiar
  nugTotCuotaExt cuotextr.cuexvalo%type; -- Total de Cuota extras
  --nugAcumCuota   number; -- Acumulador Cuota
  --sbTipoDiferido varchar2(1) := 'D'; -- OJO Crear parametro o utilizar
  nucauspasodif cargos.cargcaca%type := dald_parameter.fnuGetNumeric_Value('CODI_CAUS_PASO_DIFE');

  --********************************************************************************************
  --------------------------------------------------------------------------------------------------------------

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCREGPERIGRACIAREC
  Descripcion    : Objeto para obtener el contrato de una factura
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 27/11/2017

  Parametros         Descripcion
  ============  ===================
  inufact:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  FUNCTION fnuGetIssuscrip(inufact in factura.factcodi%type) return number is

    nuResult number;
    nuRes    number;

  BEGIN
    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.fnuGetIssuscrip  ', 10);

    begin
      select factsusc into nuResult from factura where factcodi = inufact;
    exception
      when others then
        nuResult := 0;
    end;

    return(nuResult);
    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.fnuGetIssuscrip  ', 10);

  EXCEPTION
    when others then
      nuResult := 0;
      return(nuResult);
  END fnuGetIssuscrip;

  --------------------------------------------------------------------------------------------------------------
  FUNCTION GetDatosContrato(inucontrato in servsusc.sesususc%type)
    return pkConstante.tyRefCursor is

    rfcursor     pkConstante.tyRefCursor;
    nuperson_id  ge_person.person_id%type;
    sbperson_nom ge_person.name_%type;
    sbArea       varchar2(110);

    cursor cuPerson(nuperson ge_person.person_id%type) is
      select name_ from ge_person gp where gp.person_id = nuperson;

    cursor cuArea(nuperson ge_person.person_id%type) is
      SELECT a.organizat_area_id || ' - ' || b.name_
        FROM cc_orga_area_seller a, GE_ORGANIZAT_AREA b
       WHERE a.person_id = nuperson
         AND IS_current = 'Y'
         and a.organizat_area_id = b.organizat_area_id
         AND rownum = 1;

    cursor cuDatos is
      select it.ident_type_id || ' ' || it.description tipo_doc,
             gs.identification documento,
             gs.subscriber_id customer,
             gs.subscriber_name || ' ' || gs.subs_last_name nombre,
             ad.address_id direccion,
             gl.geograp_location_id localidad
        from servsusc           ss,
             suscripc           s,
             pr_product         p,
             ge_subscriber      gs,
             GE_IDENTIFICA_TYPE it,
             ab_address         ad,
             ge_geogra_location gl
       where sesususc = susccodi
         and suscclie = subscriber_id
         and sesunuse = product_id
         and gs.ident_type_id = it.ident_type_id
         and p.address_id = ad.address_id
         and ad.geograp_location_id = gl.geograp_location_id
         and susccodi = inucontrato
         and rownum = 1;

    rgDatos cuDatos%rowtype;

  BEGIN
    select OPEN.GE_BOPersonal.fnuGetPersonId into nuperson_id from dual;

    open cuPerson(nuperson_id);
    fetch cuPerson
      into sbperson_nom;
    if cuPerson%notfound then
      sbperson_nom := null;
    end if;
    close cuPerson;

    open cuArea(nuperson_id);
    fetch cuArea
      into sbArea;
    if cuArea%notfound then
      sbArea := null;
    end if;
    close cuArea;

    open cuDatos;
    fetch cuDatos
      into rgDatos;
    if cuDatos%notfound then
      rgDatos := null;
    end if;
    close cuDatos;

    OPEN rfcursor FOR
      SELECT sbperson_nom      funcionario,
             sbArea            punto_atencion,
             rgDatos.Tipo_Doc  tipo_documento,
             rgdatos.documento nro_documento,
             rgdatos.customer  Cliente,
             rgdatos.nombre    nombre,
             rgdatos.direccion direccion,
             rgdatos.localidad localidad
        from dual;
    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosContrato;

  --------------------------------------------------------------------------------------------------------------
  /**************************************************************************
   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
   01/06/2020   HORBATH   CASO 275: Modificacion de ALIAS de los 2 primeros campos
   02/06/2020   HORBATH   CASO 275: Modiicacion de consulta para validar que lso cargos a reclamo
                                    no esten ya registrados en la entidad LD_RECLAMO mediante el
                                    parametro CONC_APLI_RECL
  ***************************************************************************/
  FUNCTION GetDatosCuentas(inucontrato in servsusc.sesususc%type)
    return pkConstante.tyRefCursor is

    rfcursor pkConstante.tyRefCursor;

  BEGIN
    OPEN rfcursor FOR
      SELECT factcodi ESTADO_DE_CUENTA, --factura, CASO275
             cucocodi CUENTA_DE_COBRO, --cuenta, CASO275
             cuconuse producto,
             servdesc tipo_producto,
             pefaano  ano,
             pefames  mes,
             cucosacu saldo
        from factura f, cuencobr cc, perifact pf, servicio s, servsusc
       where factpefa = pefacodi
         and cucofact = factcodi
         and cuconuse = sesunuse
         and servcodi IN
                     (select to_number(column_value)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONC_APLI_RECL',
                                                                                                 NULL),
                                                                ',')))
         and sesuserv = servcodi
         and sesususc = inucontrato
            --and cucosacu > 0
            --and cc.cucocodi in
         and (select count(cargconc)
                from cargos
               where cargcuco = cc.cucocodi
                 and cargnuse = sesunuse
                 and cargconc not IN
                     (select l.reconcep
                        from ldc_reclamos l
                       where l.reestado = 'EP'
                         and l.reproduct = cc.cuconuse
                         and l.cucocodi = cc.cucocodi)) > 0
                         --and l.revaloreca = cargvalo)) > 0
       order by pefafege desc;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosCuentas;

  --------------------------------------------------------------------------------------------------------------
  /**************************************************************************
   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
   02/06/2020   HORBATH   CASO 275: Adicion de nuevo campo Tipo_Producto
   02/06/2020   HORBATH   CASO 275: Modiicacion de consulta para validar que lso cargos a reclamo
                                    no esten ya registrados en la entidad LD_RECLAMO mediante el
                                    parametro CONC_APLI_RECL
  ***************************************************************************/
  FUNCTION GetDatosCargos(inucuenta in cargos.cargcuco%type)
    return pkConstante.tyRefCursor is

    rfcursor pkConstante.tyRefCursor;

  BEGIN
    --06.09.18
    --se le agrego la descripcion a la causal
    --CASO 275 Se adiciono a la consulta el tipo producto
    OPEN rfcursor FOR
      SELECT cargnuse producto,
             cargconc || ' - ' || concdesc concepto,
             cargsign signo,
             cargvalo vlr_facturado,
             0 vlr_reclamado,
             pefaano ano,
             pefames mes,
             cucosacu saldo,
             factcodi factura,
             cargcaca || ' - ' || ca.cacadesc Causal, --06.09.18
             cargdoso documento,
             cargcodo consecutivo,
             cucovato vlr_total,
             pf.pefafege fecha_generacion,
             cargunid unidades,
             (select (select ss.servdesc
                        from SERVICIO ss
                       where ss.servcodi = s.sesuserv)
                from servsusc s
               where s.sesunuse = cargnuse) Tipo_Producto,
             cc.cucocodi cuenta_cobro
        from cargos,
             concepto,
             cuencobr cc,
             perifact pf,
             factura  f,
             CAUSCARG CA
       where cargcuco = inucuenta
         and factpefa = pefacodi
         and cucofact = factcodi
         and cargcuco = cucocodi
         and cargconc = conccodi
         and ca.cacacodi = cargcaca --06.09.18
            --  and cucosacu > 0
            /*and cc.cucocodi in
            (select l.cucocodi
               from ldc_reclamos l
              where l.reestado = 'EP'
                and l.reproduct = cc.cuconuse)*/
         and cargconc not IN
             (select l.reconcep
                from ldc_reclamos l
               where l.reestado = 'EP'
                 and l.reproduct = cc.cuconuse
                 and l.cucocodi = cc.cucocodi)
                 --and l.revaloreca = cargvalo)
       order by pefafege desc;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosCargos;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuValidatePackage
  Descripcion    : Busca solicitudes
  Autor          : Kbaquero
  Fecha          : 27/11/2017 Caso 200-506

  Parametros         Descripcion
  ============   ===================


  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================

  ******************************************************************/

  FUNCTION FnuValidatePackage(inuPackage mo_packages.package_id%type)

   RETURN NUMBER

   IS

    nuResult      boolean;
    nuResultd     number;
    rcMopackage   damo_packages.styMO_packages;
    cnuMotPackage ld_parameter.numeric_value%type; --  Parametro del numero de estado del paquete

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.FnuValidatePackage', 10);

    if (dald_parameter.fblexist(LD_BOConstans.cnuMotPackage)) then

      cnuMotPackage := 13;

      if ((nvl(cnuMotPackage, LD_BOConstans.cnuCero) <>
         LD_BOConstans.cnuCero)) then

        nuResult := damo_packages.fblExist(inuPackage);

        if (nuResult = true) then
          damo_packages.getRecord(inuPackage, rcMopackage);
          if ((rcMopackage.package_type_id in (100335, 100337, 100338)) and
             (rcMopackage.motive_status_id = cnuMotPackage)) then

            nuResultd := 1;

          else

            nuResultd := 0;

          end if;

        else

          nuResultd := 0;

        end if;

        Return(nuResultd);
      end if;

    end if;

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.FnuValidatePackage', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FnuValidatePackage;
  --------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------
  /*FUNCTION GetDatossolirecl(inupack in ldc_reclamos.package_id%type)
    return pkConstante.tyRefCursor is

    rfcursor pkConstante.tyRefCursor;

  BEGIN
    OPEN rfcursor FOR
      SELECT cargnuse producto,
             cargconc || ' - ' || concdesc concepto,
             cargsign signo,
             cargvalo vlr_facturado,
             0 vlr_reclamado,
             pefaano ano,
             pefames mes,
             cucosacu saldo,
             factcodi factura,
             cargcaca Causal,
             cargdoso documento,
             cargcodo consecutivo,
             cucovato vlr_total,
             pf.pefafege fecha_generacion
        from cargos, concepto, cuencobr cc, perifact pf, factura f
       where cargcuco = inucuenta
         and factpefa = pefacodi
         and cucofact = factcodi
         and cargcuco = cucocodi
         and cargconc = conccodi
         and cucosacu > 0
       order by cargcuco, cargconc;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosCargos;*/
  --------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnuconsperigracdif
    Descripcion    : Retorna si el consecutivo del perido de gracia por diferido

    Autor          : Kbaquero- JM Gestion informatica
    Fecha          : 04/01/2018 caso 200-506

    Parametros         Descripci?n
    ============   ===================
    inudife      :N?mero del diferido

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================

  ******************************************************************/

  FUNCTION Fnuconsperigracdif(inudife diferido.difecodi%type)

   RETURN NUMBER

   IS

    nuValue number;
    --    nuGracePeriod number;

  BEGIN
    ut_trace.Trace('INICIO: Ldc_PkValoresReclamo.Fnuconsperigracdif', 10);

    /*proceso del periodo de gracia*/
    --  nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

    select MAX(f.grace_peri_defe_id)
      into nuValue
      from cc_grace_peri_defe f
     where f.deferred_id = inudife
       and f.grace_period_id = nuGracePeriod --1021355
    /*and f.end_date > sysdate*/
    ;

    Return(nuValue);

    ut_trace.Trace('FIN: Ldc_PkValoresReclamo.Fnuconsperigracdif', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END Fnuconsperigracdif;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetCursorVlrReclamo
    Descripcion    : Retorna si el consecutivo del perido de gracia por diferido

    Autor          :
    Fecha          : 30/06/2017 caso 200-506

    Parametros         Descripci?n
    ============   ===================
    inudife      :N?mero del diferido

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================
    13/07/2018     Daniel Valiente          Se valido los metodos de Consulta Caso 200-1648
    26/02/2019     Ronald Colpas C200-1648  Se modifica consulta para que se consulte las solicitudes
                                            con valor en reclamo


  ******************************************************************/
  Function GetCursorVlrReclamo return pkConstante.tyRefCursor is

    rfcursor     pkConstante.tyRefCursor;
    nuContrato   ge_boInstanceControl.stysbValue;
    nuSolicitud  ge_boInstanceControl.stysbValue;
    nuIteracion  ge_boInstanceControl.stysbValue;
    nuSolicitud1 ge_boInstanceControl.stysbValue;
    nuSolicitud2 ge_boInstanceControl.stysbValue;
    nuSolicitud3 ge_boInstanceControl.stysbValue;
    nuValidate   number;

    cursor cuValfact(nuSusc servsusc.sesususc%type) is
      select count(1)
        from cargos
       where cargcuco = -1
         and cargnuse in
             (select sesunuse from servsusc where sesususc = nuSusc)
         and cargprog = 5;

  begin

    ut_trace.trace('Inicio Ldc_PkValoresReclamo.GetCursorVlrReclamo', 10);

    /*obtener los valores ingresados en la aplicacion PB */
    nuContrato  := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC',
                                                         'SUSCCODI');
    nuSolicitud := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'PACKAGE_ID');
    nuIteracion := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'CUST_CARE_REQUES_NUM');

    /*if (nuContrato is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'Contrato no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;*/

    /*Se valida el ingreso de los datos*/
    if (nuSolicitud is null and nuContrato is null and nuIteracion is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'Debe ingresar al menos un Criterio de Busqueda');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuSolicitud is not null) then
      nuValidate := LDC_PKVALORESRECLAMO.FnuValidatePackage(nuSolicitud);

      if (nuValidate <> 0) then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'La solicitud ingresada se encuentra es estado registrado, Favor Validar');

      end if;

      nuContrato := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                          'PACKAGE_ID',
                                                          'SUBSCRIPTION_ID',
                                                          nuSolicitud);

      /*else
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'La solicitud no debe ser nula');
      raise ex.CONTROLLED_ERROR;*/
    end if;

    --Caso 200-1648
    if nuContrato is null then

      if (nuSolicitud is null) then
        nuSolicitud := ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES',
                                                             'CUST_CARE_REQUES_NUM',
                                                             'PACKAGE_ID',
                                                             nuIteracion);

      end if;

      nuContrato := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                          'PACKAGE_ID',
                                                          'SUBSCRIPTION_ID',
                                                          nuSolicitud);
    end if;

    --Valida que usuario no este en periodo de facturacion.
    open cuValfact(nuContrato);
    fetch cuValfact
      into nuValidate;
    close cuValfact;

    if nuValidate > 0 then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El contrato: ' || nuContrato ||
                      ', se encuentra en periodo de facturacion');
      raise ex.CONTROLLED_ERROR;
    end if;

    --Caso 200-1648
    OPEN rfcursor FOR
      select solicitud,
             cuenta,
             factura,
             contrato,
             causal,
             tipo_solicitud,
             fecha_registro,
             punto_atencion,
             funcionario,
             --tipo_producto,
             sum(valor_fact) valor_fact,
             --DANVAL 30.04.19 Se modifico la consulta para aplicar negativos a los valores aplicados en la formas
             /*sum(decode(signo,
             'DB',
             -valor_reclamo,
             'SA',
             -valor_reclamo,
             'AP',
             -valor_reclamo,
             'TS',
             -valor_reclamo,
             valor_reclamo)) valor_reclamo*/
             sum(decode(signo,
                        'CR',
                        -valor_reclamo,
                        'AS',
                        -valor_reclamo,
                        'PA',
                        -valor_reclamo,
                        'NS',
                        -valor_reclamo,
                        'ST',
                        -valor_reclamo,
                        valor_reclamo)) valor_reclamo
        from (select reclamos_id,
                     ss.sesususc contrato,
                     p.package_id solicitud,
                     (select causal_id || '-' || description
                        from cc_causal
                       where causal_id =
                             damo_motive.fnugetcausal_id(mo_bopackages.fnuGetInitialMotive(p.package_id))) causal,
                     (select pt.description
                        from ps_package_type pt
                       where pt.package_type_id = p.package_type_id) tipo_solicitud,
                     p.request_date fecha_registro,
                     (SELECT b.name_
                        FROM cc_orga_area_seller a, GE_ORGANIZAT_AREA b
                       WHERE a.person_id = p.person_id
                         AND IS_current = 'Y'
                         and a.organizat_area_id = b.organizat_area_id
                         AND rownum = 1) punto_atencion,
                     (select gp.name_
                        from open.ge_person GP
                       where gp.person_id = p.person_id) funcionario,
                     (select servdesc from servicio where servcodi = sesuserv) tipo_producto,
                     r.factcodi factura,
                     r.cucocodi cuenta,
                     r.reconcep concepto,
                     r.resbsig signo,
                     r.revaltotal valor_fact,
                     r.revaloreca valor_reclamo
                from LDC_RECLAMOS R, SERVSUSC SS, MO_PACKAGES p
               where r.package_id = p.package_id
                 and r.reproduct = ss.sesunuse
                 and r.package_id = decode(NVL(nuSolicitud, -1),
                                           -1,
                                           r.package_id,
                                           nuSolicitud)
                 and ss.sesususc =
                     decode(NVL(nuContrato, -1), -1, ss.sesususc, nuContrato)
                 and p.cust_care_reques_num =
                     decode(NVL(nuIteracion, -1),
                            -1,
                            p.cust_care_reques_num,
                            nuIteracion)
                 and r.reestado = 'EP'
                 and p.motive_status_id = 14)
       group by solicitud,
                cuenta,
                factura,
                contrato,
                causal,
                tipo_solicitud,
                fecha_registro,
                punto_atencion,
                funcionario;
    --tipo_producto;
    ut_trace.trace('Fin Ldc_PkValoresReclamo.GetCursorVlrReclamo', 10);

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end GetCursorVlrReclamo;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : prApplyVlrReclamo

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================
    13/07/2018     Daniel Valiente          Se a?adio el comentaio a la Solicitud Caso 200-1648
    26/02/2019     Ronald Colpas C200-1648  Se modifica servicio para que decargue el valor en reclamo
                                            por cuenta de cobro
  ******************************************************************/
  Procedure prApplyVlrReclamo(InCodiRecl      number,
                              InuActReg       number,
                              InuTotalReg     number,
                              OnuErrorCode    out number,
                              OsbErrorMessage out varchar2) is

    sbApliVlrRec ge_boInstanceControl.stysbValue;
    sbNoApliVRec ge_boInstanceControl.stysbValue;
    --Caso 200-1648
    sbComentario ge_boInstanceControl.stysbValue;
    --
    sbcommit       VARCHAR2(1) := 'N';
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuSolicitud    ge_boInstanceControl.stysbValue;
    nuSolicitud1   ge_boInstanceControl.stysbValue;
    nuSolicitud2   ge_boInstanceControl.stysbValue;
    nuSolicitud3   ge_boInstanceControl.stysbValue;

    -- nuGracePeriod ld_parameter.numeric_value%type;
    --vdate         date;
    vinidate   date;
    nuperigrac number;
    nuDife     diferido.difecodi%type;

    sbenre   diferido.difeenre%type;
    nuconc   diferido.difeconc%type;
    nusaldo  diferido.difesape%type := 0;
    sbestrec varchar2(10);

    nuperson number;

    blabono     boolean := FALSE;
    blsavepoint boolean := FALSE;
    blprocesind boolean := FALSE;

    sbprograma varchar2(20) := 'NOTESREG';

    nuCausNCVr NUMBER;
    sbObseNCVr VARCHAR2(1000);
    /* cnuFLOW_ACTION      constant number := 8285;
    cnuFLOW_ACTIONrec   constant number := 8291;
    cnuFLOW_ACTIONape   constant number := 8299;
    cnuFLOW_ACTIONOT    constant number := 8284;
    cnuFLOW_ACTIONrecOT constant number := 8292;
    cnuFLOW_ACTIONapeOT constant number := 8298;
    nuacc   number;
    nuaccOT number;*/

    cursor cuReclamo is
      select ss.sesususc, r.*
        from LDC_RECLAMOS r, SERVSUSC ss
       where r.reproduct = ss.sesunuse
         and r.package_id = InCodiRecl
         and r.reestado = 'EP';

    rg cuReclamo%rowtype;

    cursor cudife(nudiferido diferido.difecodi%type) is
      select difeconc, difeenre, difesape
        from diferido
       where difecodi = nudiferido;

  begin

    ut_trace.trace('Inicio Ldc_PkValoresReclamo.prApplyVlrReclamo', 10);

    /*--Caso200-1648 Se omite porque no es necesario realizar seleccion en el proceso
    \*obtener los valores ingresados en la aplicacion PB *\
    sbApliVlrRec := ge_boInstanceControl.fsbGetFieldValue('SERVSUSC',
                                                          'SESUDETE');
    sbNoApliVRec := ge_boInstanceControl.fsbGetFieldValue('SERVSUSC',
                                                          'SESULIMP');*/

    nuSolicitud := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'PACKAGE_ID');
    --Caso 200-1648
    sbComentario := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                          'COMMENT_');
    --
    /* sbApliVlrRec  := 'S';
    sbNoApliVRec :=  'N';
    nuSolicitud:=15669700;*/

    /*--Caso200-1648 Se omite porque no es necesario realizar seleccion en el proceso
    if nvl(sbApliVlrRec, 'N') = 'N' and nvl(sbNoApliVRec, 'N') = 'N' then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Debe seleccionar una de las dos opciones (Aplicar o No Aplicar Valor en Reclamo)');
    end if;

    if nvl(sbApliVlrRec, 'N') in ('Y', 'S') and
       nvl(sbNoApliVRec, 'N') in ('Y', 'S') then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Debe seleccionar una de las dos opciones (Aplicar o No Aplicar Valor en Reclamo)');
    end if;*/

    ---
    --Caso 200-1648
    /*begin
      select distinct package_id \*, cnuFLOW_ACTION, cnuFLOW_ACTIONOT*\
        into nuSolicitud1 \*, nuacc , nuaccOT*\
        from OPEN.ldc_reclamos t
       where package_id = nuSolicitud;
    exception
      when others then
        begin
          select distinct package_id_recu \*, cnuFLOW_ACTIONrec ,cnuFLOW_ACTIONrecOT*\
            into nuSolicitud2 \*, nuacc , nuaccOT*\
            from OPEN.ldc_reclamos t
           where package_id_recu = nuSolicitud;
        exception
          when others then
            begin
              select distinct package_id_recusubs \*, cnuFLOW_ACTIONape, cnuFLOW_ACTIONapeOT*\
                into nuSolicitud3 \*, nuacc , nuaccOT*\
                from OPEN.ldc_reclamos t
               where package_id_recusubs = nuSolicitud;
            exception
              when others then
                nuSolicitud3 := -1;
            end;
        end;
    end;*/

    nuCausNCVr := dald_parameter.fnuGetNumeric_Value('COD_CAUS_NC_VLR_REC');
    sbObseNCVr := DALD_PARAMETER.fsbGetValue_Chain('OBSE_NC_VLR_RECLAMO');

    sbApliVlrRec := 'N';

    for rg in cuReclamo loop

      -- si corresponde a un diferido lo saca del periodo de gracia y actualiza difeenre
      if substr(rg.redocsop, 1, 3) = 'DF-' then
        nuDife := substr(rg.redocsop, 4);
        open cudife(nudife);
        fetch cudife
          into nuconc, sbenre, nusaldo;
        if cudife%notfound then
          sbenre  := 'N';
          nusaldo := 0;
        end if;
        close cudife;
        -- SI ESTA EN PERIODO DE GRACIA LO SACA
        if sbenre in ('S', 'Y') then
          nuperigrac := Ldc_PkValoresReclamo.Fnuconsperigracdif(nudife);

          vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac);

          LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(nudife,
                                                      nuperigrac,
                                                      nuGracePeriod,
                                                      vinidate);
          pktbldiferido.upddifeenre(nudife, 'N');
          -- LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC(rg.package_id);
        end if;
      end if;

      update cuencobr
         set cucovare = cucovare + decode(rg.resbsig,
                                          'DB',
                                          -rg.revaloreca,
                                          'SA',
                                          -rg.revaloreca,
                                          'AP',
                                          -rg.revaloreca,
                                          'TS',
                                          -rg.revaloreca,
                                          rg.revaloreca)
       where cucocodi = rg.cucocodi;
      sbcommit := 'S';

      -- si es a favor del usuario genera NC en la misma CC
      if sbApliVlrRec in ('S', 'Y') then
        nuSuscripcion := rg.sesususc;
        nuServsusc    := rg.reproduct;
        nuConcepto    := rg.reconcep;
        nuCausal      := nuCausNCVr;
        sbObserv      := sbObseNCVr;
        if rg.resbsig in ('DB', 'SA', 'AP', 'TS') then
          nuSigno := 'CR';
        else
          nuSigno := 'DB';
        end if;
        nuValor       := rg.revaloreca;
        nuTipo        := 2; -- nota no diferible
        nucuentacobro := rg.cucocodi;
        -- Genera movimientos
        Generate(nuErrorCode, sbErrorMessage);
        if nuErrorCode != 0 then
          sbcommit := 'N';
        else

          -- si es a favor del usuario y es diferido lo pasa a pm y lo cancela
          -- genera cargo, cuenta, factura, movimiento del diferido y coloca difesape en cero
          if nusaldo > 0 then
            nuErrorCode := 0;
            -- se asignan variables de paquete para los movimientos
            nuSuscripcion := rg.sesususc;
            nuServsusc    := rg.reproduct;
            nuConcepto    := nuconc;
            nuCausal      := nuCausNCVr;
            sbObserv      := sbObseNCVr;
            nuDiferido    := nudife;

            -- Traslada diferido a pmes
            pkTransDefToCurrDebt.Transferdebt(nuServsusc,
                                              nuDiferido,
                                              nusaldo,
                                              sbprograma, -- input
                                              nuestadocuenta,
                                              nucuenta,
                                              nuerrorcode,
                                              sberrormessage, -- output
                                              blabono,
                                              blsavepoint,
                                              blprocesind); -- input

            if nuerrorcode = 0 then
              -- asigna a variable global el numero de la cc generada para la NC y el valor
              nucuentacobro := nucuenta;
              nuValor       := nusaldo;

              -- Genera movimientos
              Generate(nuErrorCode, sbErrorMessage);
              if nuErrorCode != 0 then
                sbcommit := 'N';
              else
                sbcommit := 'S';

              end if;
            else
              sbcommit := 'N';
            end if;
          else

            sbcommit := 'S';

          end if;
        end if;
      end if;

    /*  LD_BOFlowFNBPack.procValidateFlowMove(nuaccOT,
                                                                                                                                                                                                  nuSolicitud, -- rg.package_id,
                                                                                                                                                                                                  onuerrorcode,
                                                                                                                                                                                                  osberrormessage);

                                                                                                                                                            LD_BOFlowFNBPack.procValidateFlowMove(nuacc,
                                                                                                                                                                                                  nuSolicitud, -- rg.package_id,
                                                                                                                                                                                                  onuerrorcode,
                                                                                                                                                                                                  osberrormessage);*/
    end loop;

    if sbcommit = 'S' then
      if sbApliVlrRec in ('S', 'Y') then
        sbestrec := 'FU';
      else
        sbestrec := 'FE';
      end if;

      update ldc_reclamos
         set reestado = sbestrec
       where package_id = InCodiRecl;

      --Caso 200-1648
      --Actualizacion Observacion en la solictud y la orden
      if sbComentario is not null then

        sbComentario := 'Observacion(LDCAVR): ' || sbComentario ||
                        ' [Reclamo: ' || InCodiRecl || ']';
        --Actuakizamos comentario de la solicitud
        update mo_packages
           set comment_ = comment_ || ' . ' || sbComentario
         where package_id = InCodiRecl;

        select GE_BOPersonal.fnuGetPersonId into nuperson from dual;
        --Insertamos comentario a la orden
        for rt in (select order_id
                     from or_order_activity
                    where package_id = InCodiRecl) loop
          INSERT /*+ APPEND */
          INTO OR_ORDER_COMMENT
            (ORDER_COMMENT_ID,
             ORDER_COMMENT,
             ORDER_ID,
             COMMENT_TYPE_ID,
             REGISTER_DATE,
             LEGALIZE_COMMENT,
             PERSON_ID)
          VALUES
            (SEQ_OR_ORDER_COMMENT.NEXTVAL,
             sbComentario,
             rt.order_id,
             1277,
             sysdate,
             'Y',
             nuPerson);
        end loop;

      end if;
      --

      /*   LD_BOFlowFNBPack.procValidateFlowMove(nuacc,
      nuSolicitud, -- rg.package_id,
      onuerrorcode,
      osberrormessage);*/

      --commit;
    else
      ge_boerrors.seterrorcodeargument(nuErrorCode, sbErrorMessage);

      rollback;
    end if;

    ut_trace.trace('Fin Ldc_PkValoresReclamo.prApplyVlrReclamo', 10);

    ---

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end prApplyVlrReclamo;

  --********************************************************************************************
  PROCEDURE Generate
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generate
    Descripcion    : Procedimiento que genera todo el proceso para cada producto leido
                     en el archivo plano
    Autor          : F.Castro
    Fecha          : 02/04/2016 ERS 200-206

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  (onuErrorCode out number, osbErrorMessage out varchar2) IS

    nures       number;
    sbError     varchar2(2000);
    onuSaldoFac cargos.cargvalo%type;

    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */

    /*
        Procedure  :  ClearMemory
      Descripcion  :  Limpia memoria cache
                        Clear Memory
    */

    PROCEDURE ClearMemory IS

    BEGIN
      --{
      pkErrors.Push('pkGenerateInvoice.ClearMemory');

      -- Limpia la memoria cache que usa el package

      pktblParafact.ClearMemory;
      pktblSistema.ClearMemory;
      pktblConsecut.ClearMemory;
      pktblCuencobr.ClearMemory;
      pktblFactura.ClearMemory;
      pktblSuscripc.ClearMemory;
      pktblServsusc.ClearMemory;
      pktblConcepto.ClearMemory;
      pktblParametr.ClearMemory;
      pktblMensaje.ClearMemory;
      pktblPerifact.ClearMemory;

      pkErrors.Pop;
      --}
    END ClearMemory;

    /* -------------------------------------------------------------- */

    /*
        Procedure  :  Initialize
        Descripcion  :  Inicializa variables del package
                        Initialize
    */

    PROCEDURE Initialize IS
    BEGIN
      --{
      pkErrors.Push('pkGenerateInvoice.Initialize');

      -- Fija la Aplicacion en una variable global del paquete
      sbApplication := csbPROGRAMA;
      pkErrors.SetApplication(sbApplication);

      -- Fecha de Generacion de la Cuenta
      dtFechaGene := sysdate;

      dtFechaCurrent := sysdate;
      sbTerminal     := pkGeneralServices.fsbGetTerminal;

      -- Asigna el Cupon de Pago
      -----  gnuCouponPayment := inuCouponPayment;

      -- Fecha Contable
      dtFechaContable := pkGeneralServices.fdtGetSystemDate;

      -- Clase de Documento que entra como parametro
      gnuTipoDocumento := 70; -- tipo de documento de Notas Debito

      -- Inicializa Codigos de Documentos
      nuEstadoCuenta := NULL;
      nuCuenta       := NULL;

      -- Inicializa Saldo Pendiente de la Factura
      nuSaldoFac := NULL;

      -- Valores Facturados en la Cuenta de Cobro
      nuVlrFactCta    := 0;
      nuVlrIvaFactCta := 0;

      -- Valores facturados en el Estado de Cuenta
      nuVlrFactFac    := 0;
      nuVlrIvaFactFac := 0;

      -- Inicializa tabla de memoria de parametros
      pkBillFuncParameters.InitMemTable;

      -- Habilita manejo de cache para parametros
      pkGrlParamExtendedMgr.SetCacheOn;

      -- Inicializa parametros de salida
      nuSaldoFac := NULL;

      -- Por defecto no se ha generado Estado de Cuenta ni Cuenta de Cobro

      boAccountStGenerado := FALSE;
      boCuentaGenerada    := FALSE;

      -- Inicializa variables de Error
      pkErrors.GetErrorVar(onuErrorCode,
                           osbErrorMessage,
                           pkConstante.INITIALIZE);

      -- Obtiene el record de la suscripcion
      rcSuscCurr := pktblSuscripc.frcGetRecord(nuSuscripcion);

      -- Obtiene record de periodo de facturacion current
      rcPeriFactCurr := pkBillingPeriodMgr.frcGetAccCurrentPeriod(rcSuscCurr.susccicl);

      pkErrors.Pop;
      --}
    END Initialize;

    /* ***************************************************************** */

  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.Generate');

    -- Savepoint del proceso principal
    savepoint svGenerate;

    -- Inicializa variables
    Initialize;

    -- Limpia memoria
    ClearMemory;

    /*sbProgram       :=  'LDC_ANDM';*/

    -- Valida los parametros necesarios para el proceso
    ---------------------------------------------------------- GetParameters;

    -- Valida los datos de entrada
    nuRes := ValInputData(sbError);

    -- Ejecuta el proceso de generacion de Factura
    GenProcess;

    -- Asigna saldo de la Factura
    onuSaldoFac := nuSaldoFac;

    -- COMMIT;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
      --   PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENERATE: ' || SQLERRM);
      -- Error de Aplicacion
      pkErrors.Pop;
      pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
      rollback to savepoint svGenerate;

    when others then
      --  PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENERATE: ' || SQLERRM);
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
      rollback to savepoint svGenerate;
      --}
  END Generate;

  --********************************************************************************************

  PROCEDURE GenProcess

   IS

  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.GenProcess');

    -- Inicializa las tablas de memoria en el actualiza cartera,
    -- destruye el cache
    pkUpdAccoReceiv.ClearMemTables;

    -- Por defecto, no se ha generado estado de cuenta
    boAccountStGenerado := FALSE;

    -- Elimina tabla de hash para que sea borrada por cada suscripcion
    pkExtendedHash.SetInitVar(TRUE);

    -- Procesa los servicios suscritos
    ProcessSubsServices;

    -- Aqui se realiza la numeracion fiscal
    if (boAccountStGenerado) then
      AsignaNumeracionFiscal;
    END if;

    pkErrors.Pop;
  EXCEPTION
    when LOGIN_DENIED then
      --    PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENPROCESS: ' || SQLERRM);
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      --   PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENPROCESS: ' || SQLERRM);
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      --  PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENPROCESS: ' || SQLERRM);
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END GenProcess;

  --*****************************************************************************************

  PROCEDURE ProcessSubsServices is

    nuRegs   number;
    sbindice varchar2(14);

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ProcessSubsServices');

    -- Busca informacion del servicio suscrito
    rcSeSuCurr := pktblServsusc.frcGetRecord(nuServsusc);

    nuDepa := nvl(pkBCSubscription.fnuGetContractState(rcSuscCurr.susccodi),
                  pkConstante.NULLNUM);
    nuLoca := nvl(pkBCSubscription.fnuGetContractTown(rcSuscCurr.susccodi),
                  pkConstante.NULLNUM);

    -- Liquida el impuesto de cargos a la -1
    -------------- pkBOLiquidateTax.LiqTaxValue(rcSeSuCurr,rcPeriFactCurr,isbDocumento);

    if nuTipo = 1 then
      -- nota diferible en cc nueva
      -- Genera Estado de cuenta y Cuenta
      if (not (boAccountStGenerado)) then
        GenerateAccountStatus;
      end if;

      -- Genera cuenta si no se ha generado antes
      if (not (boCuentaGenerada)) then
        GenerateAccount;
      end if;

      -- Agrega cargo CR
      AddCharge(nuConcepto,
                'CR', -- sbSignCanc,
                '-', -- docsoporte  DF-1234567
                nucauspasodif, -- Causal para el Cargo CR;
                nuValor,
                0, -- CARGCODO ;
                pkBillConst.AUTOMATICO -- TIPOPROC
                );

      -- Se crea la Nota DB
      GenerateBillingNote;

      -- Genera Diferido
      ---GenerateDeferred('ND-' || nuNota);

      -- Actualiza el cargdoso del cargo credito con el numero del diferido
      update cargos
         set cargdoso = 'FD-' || nuDiferido
       where cargcuco = nuCuenta
         and cargconc = nuconcepto
         and cargsign = 'CR';

    else
      -- crea nota no diferible en cuenta de cobro existente
      -- Se crea la Nota
      nucuenta := nucuentacobro;
      GenerateBillingNote;
    end if;

    -- Procesa los cargos del servicio suscrito
    ProcessCharges; --  (isbDocumento, iblAllCharges);

    -- Verifica si se genero nueva cuenta

    if (boCuentaGenerada) then
      --{
      -- Actualiza cartera
      UpdateAccoRec;

      -- Procesa la cuenta generada
      ProcessGeneratedAcco;
      --}
    end if;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END ProcessSubsServices;

  --********************************************************************************************

  PROCEDURE AddCharge

  (inuConcepto in cargos.cargconc%type,
   isbSigno    in cargos.cargsign%type,
   isbDocSop   in cargos.cargdoso%type,
   inuCausal   in cargos.cargcaca%type,
   inuVlrCargo in cargos.cargvalo%type,
   inuConsDocu in cargos.cargcodo%type,
   isbTipoProc in cargos.cargtipr%type)

   IS
  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.AddCharge');

    -- Adiciona el Cargo
    GenerateCharge(inuConcepto,
                   isbSigno,
                   isbDocSop,
                   inuCausal,
                   inuVlrCargo,
                   inuConsDocu,
                   isbTipoProc);

    -- Actualiza cartera
    pkUpdAccoReceiv.UpdAccoRec(pkBillConst.cnuSUMA_CARGO,
                               nuCuenta,
                               rcSuscCurr.susccodi,
                               rcSeSuCurr.sesunuse,
                               inuConcepto,
                               isbSigno,
                               abs(inuVlrCargo),
                               pkBillConst.cnuNO_UPDATE_DB);

    UpdateAccoRec;

    -- Actualiza el acumulado de los valores facturados

    if (isbSigno = pkBillConst.DEBITO) then
      --{

      -- Cargo debito
      nuVlrFactCta := nuVlrFactCta + abs(inuVlrCargo);
      nuVlrFactFac := nuVlrFactFac + abs(inuVlrCargo);

      --}
    else
      --{
      -- Cargo credito
      nuVlrFactCta := nuVlrFactCta - abs(inuVlrCargo);
      nuVlrFactFac := nuVlrFactFac - abs(inuVlrCargo);
      --}
    end if;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END AddCharge;

  --********************************************************************************************

  PROCEDURE GenerateCharge(inuConcepto in cargos.cargconc%type,
                           isbSigno    in cargos.cargsign%type,
                           isbDocSop   in cargos.cargdoso%type,
                           inuCausal   in cargos.cargcaca%type,
                           inuVlrCargo in cargos.cargvalo%type,
                           inuConsDocu in cargos.cargcodo%type,
                           isbTipoProc in cargos.cargtipr%type) IS

    -- Record del cargo
    rcCargo cargos%rowtype;

    ------------------------------------------------------------------------
    -- Procedimientos Encapsulados
    ------------------------------------------------------------------------

    PROCEDURE FillRecord IS

      rcCargoNull cargos%rowtype;

    BEGIN
      --{

      pkErrors.Push('pkGenerateInvoice.GenChrg.FillRecord');

      rcCargo := rcCargoNull;

      rcCargo.cargcuco := nuCuenta;
      rcCargo.cargnuse := rcSeSuCurr.sesunuse;
      rcCargo.cargpefa := rcPerifactCurr.pefacodi;
      rcCargo.cargconc := inuConcepto;
      rcCargo.cargcaca := inuCausal;
      rcCargo.cargsign := isbSigno;
      rcCargo.cargvalo := inuVlrCargo;
      rcCargo.cargdoso := isbDocSop; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
      rcCargo.cargtipr := isbTipoProc; -- pkBillConst.AUTOMATICO;
      rcCargo.cargfecr := dtFechaCurrent;
      rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
      rcCargo.cargunid := null;
      rcCargo.cargcoll := null;
      rcCargo.cargprog := nuPrograma; -- 2014 = AJUSTES DE FACTURACION --   ge_bcProcesos.frcprograma(sbApplication).proccons;
      rcCargo.cargusua := sa_bosystem.getSystemUserID;

      pkErrors.Pop;

    EXCEPTION
      when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
        pkErrors.Pop;
        raise LOGIN_DENIED;

      when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
        --}
    END FillRecord;

    ------------------------------------------------------------------------

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.GenerateCharge');

    -- Prepara record del Cargo
    FillRecord;

    -- Adiciona el Cargo
    pktblCargos.InsRecord(rcCargo);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END GenerateCharge;

  --********************************************************************************************

  PROCEDURE ProcessCharges
  /*(
      isbDocumento  in   cargos.cargdoso%type,
      iblAllCharges   in   boolean
    )*/
   IS
    -- Tabla de cargos a liquidar
    tbCargos              tytbCargos;
    rcCargos              tyrcCargos;
    tbMaxPericoseConcepto tytbMaxPericoseConcepto;

    nuIdxCargos number;

    -- Registro del servicio
    rcServicio servicio%rowtype;

    -- Fecha de retiro del producto
    dtFechRetProd servsusc.sesufere%type;

    -- Definicion del cursor para la seleccion de todos los cargos de
    -- la cuenta generada
    CURSOR cuAllCargos(inuNumServ servsusc.sesunuse%type) IS
      SELECT --+ index (cargos ix_carg_nuse_cuco_conc) -- pkGenerateInvoice.ProcessCharges
       rowid,
       cargconc,
       cargcaca,
       cargsign,
       cargdoso,
       cargvalo,
       cargfecr,
       cargnuse,
       cargpeco
        FROM cargos
       WHERE cargcuco + 0 = nuCuenta
         AND cargnuse = inuNumServ;

    -- Indice arreglos de cargos procesados
    nuIdx number;

    -----------------------------------------------------------------------
    -- PROCEDIMIENTOS ENCAPSULADOS
    -----------------------------------------------------------------------
    PROCEDURE CleanChargeArrays IS
    BEGIN
      --{

      pkErrors.Push('pkGenerateInvoice.CleanChargeArrays');

      tbCargfact.DELETE;
      tbCargcuco.DELETE;
      tbCargfeco.DELETE;
      tbCargdate.DELETE;
      tbCargtipr.DELETE;
      tbRowid.DELETE;
      tbCargos.DELETE;
      tbMaxPericoseConcepto.DELETE;

      pkErrors.Pop;

      --}
    END CleanChargeArrays;

    -- Procedimiento para inicialiar datos del proceso.
    PROCEDURE Initialize IS
    BEGIN
      -- Obtiene el tipo de producto que se esta liquidando para
      -- realizar obtencion del periodo de consumo de acuerdo
      -- al tipo de cobro (anticipado o vencido)
      rcServicio := pktblservicio.frcGetRecord(rcSeSuCurr.sesuserv);

      -- Se obtiene fecha de retiro del producto
      dtFechRetProd := pktblServsusc.fdtGetRetireDate(rcSeSuCurr.sesunuse);
    END Initialize;

    PROCEDURE CalcularFechaUltLiqConcepto(inuConcepto concepto.conccodi%type,
                                          inuCargPeco cargos.cargpeco%type) IS
      -- Fecha ultima liquidacion
      dtFechaUltLiq feullico.felifeul%type := null;

      -- Tipo de cobro generado por el concepto
      sbTipoCobro concepto.concticc%type;

      -- Datos del proceso
      nuPeriodoConsumoActual pericose.pecscons%type;

      rcPeriodoConsumoActual pericose%rowtype;

      rcPeriodoConsumoCargo pericose%rowtype;
    BEGIN
      if tbMaxPericoseConcepto.EXISTS(inuConcepto) then
        -- Si el periodo de consumo del cargo es nulo, se respeta el
        -- que se exite en la coleccion.
        if inuCargPeco IS null then
          return;
        END if;

        sbTipoCobro            := tbMaxPericoseConcepto(inuConcepto)
                                  .sbTipoCobro;
        rcPeriodoConsumoActual := tbMaxPericoseConcepto(inuConcepto)
                                  .rcPeriodoConsumo;
      else
        -- Se obtiene el tipo de cobro del concepto
        sbTipoCobro := pktblConcepto.fsbObtTipoCobro(inuConcepto);

        -- Obtiene el periodo de consumo current
        pkBCPericose.GetCacheConsPerByBillPer(rcSeSuCurr.sesucico,
                                              rcPerifactCurr.pefacodi,
                                              nuPeriodoConsumoActual,
                                              rcservicio.servtico, -- Tipo Cobro del Servicio (Anticipado/Vencido)
                                              sbTipoCobro -- Tipo Cobro del Concepto (Consumo/Abono)
                                              );

        -- Se obtiene el registro del periodo de consumo
        rcPeriodoConsumoActual := pktblPericose.frcGetRecord(nuPeriodoConsumoActual);
      END if;

      -- Si periodo de consumo del cargo no es nulo, se debe comparar contra el
      -- actual. Debe quedar seteado como periodo actual el mas viejo.
      if inuCargPeco IS not null then
        rcPeriodoConsumoCargo := pktblPericose.frcGetRecord(inuCargPeco);

        -- Evaluar que perido de consumo es mayor, si el actual o del de cargo
        -- Se debe actualizar feullico con el mayor.
        -- Se evalua el tipo de cobro del concepto
        IF sbTipoCobro = 'C' THEN
          -- Concepto de tipo Consumo
          -- Si la fecha de consumo final del periodo del cargo es mayor a la
          -- del periodo actual, se cambia el periodo de consumo actual por
          -- el del cargo.
          IF (rcPeriodoConsumoCargo.pecsfecf >
             rcPeriodoConsumoActual.pecsfecf) THEN
            rcPeriodoConsumoActual := rcPeriodoConsumoCargo;
          END if;
        ELSE
          -- Concepto de tipo Consumo
          -- Si la fecha de cargo basico final del periodo del cargo es mayor a la
          -- del periodo actual, se cambia el periodo de consumo actual por
          -- el del cargo.
          IF (rcPeriodoConsumoCargo.pecsfeaf >
             rcPeriodoConsumoActual.pecsfeaf) THEN
            rcPeriodoConsumoActual := rcPeriodoConsumoCargo;
          END if;
        end if;
      END if;

      -- Se actualiza o inserta los datos a la coleccion en memoria.
      tbMaxPericoseConcepto(inuConcepto).rcPeriodoConsumo := rcPeriodoConsumoActual;
      tbMaxPericoseConcepto(inuConcepto).sbTipoCobro := sbTipoCobro;

      -- Se debe verificar la fecha final del periodo actual, con la fecha
      -- de retiro del producto. Si la fecha de retiro es menor, se debe
      -- actualizar feullico con esta.

      -- Se evalua el tipo de cobro del concepto
      IF sbTipoCobro = 'C' THEN
        -- Concepto de tipo Consumo
        -- Si el producto se retiro en el periodo se establece esta
        -- fecha como la fecha de ultima liquidacion
        IF (dtFechRetProd < rcPeriodoConsumoActual.pecsfecf) THEN
          tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := dtFechRetProd;
        ELSE
          -- de lo contrario se establece la fecha final del periodo
          tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := rcPeriodoConsumoActual.pecsfecf;
        end if;
      ELSE
        -- Concepto de tipo Abono
        -- Si el producto se retiro en el periodo se establece esta fecha
        -- como la fecha de ultima liquidacion
        IF dtFechRetProd < rcPeriodoConsumoActual.pecsfeaf THEN
          tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := dtFechRetProd;
        ELSE
          -- de lo contrario se establece la fecha final del periodo
          tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := rcPeriodoConsumoActual.pecsfeaf;
        end if;
      end if;

    EXCEPTION
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;

      when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
        --}
    END CalcularFechaUltLiqConcepto;

    PROCEDURE ActFechaUltFactConceptos IS
      nuConcepto concepto.conccodi%type;
      -- Registro Fecha ultima liquidacion
      rcFeullico feullico%rowtype;
    BEGIN
      ut_trace.trace('Actualizando ultima fecha facturacion conceptos.', 5);

      nuConcepto := tbMaxPericoseConcepto.first;

      loop
        EXIT WHEN(nuConcepto IS NULL);

        ut_trace.trace('[Concepto] = ' || nuConcepto ||
                       ' - [Fecha Ult Fact] = ' || tbMaxPericoseConcepto(nuConcepto)
                       .dtFechaUltLiq,
                       5);

        -- Arma registro fecha ultima Facturacion
        rcFeullico.felisesu := rcSeSuCurr.sesunuse;
        rcFeullico.feliconc := nuConcepto;
        rcFeullico.felifeul := tbMaxPericoseConcepto(nuConcepto)
                               .dtFechaUltLiq;

        -- Evalua si existe registro de fecha de ultima liquidacion
        if (pktblFeullico.fblExist(rcSeSuCurr.sesunuse, nuConcepto)) THEN
          -- Se actualiza registro
          pktblFeullico.UpRecord(rcFeullico);
        else
          -- Se inserta registro por ser la primera vez que se actualiza
          -- fecha de ultima liquidacion
          pktblFeullico.InsRecord(rcFeullico);
        end if;

        nuConcepto := tbMaxPericoseConcepto.NEXT(nuConcepto);
      END loop;
    END ActFechaUltFactConceptos;
    -----------------------------------------------------------------------
  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.ProcessCharges');

    -- Inicializa flag
    --boCuentaGenerada := FALSE;
    -- Inicializa valor facturado de la cuenta en cero
    nuVlrFactCta := 0;
    -- Inicializa valor impuesto facturado de la cuenta en cero
    nuVlrIvaFactCta := 0;

    nuIdx := 1;

    -- Limpia tablas de cargos
    CleanChargeArrays;

    -- Inicializa variables del proceso.
    Initialize;

    -- Verifica si se deben procesar todos los cargos o solo los asociados a
    -- al documento de soporte.
    --  if iblAllCharges then
    ut_trace.trace('Procesando todos los cargos asociados al producto: ' ||
                   rcSeSuCurr.sesunuse,
                   5);
    OPEN cuAllCargos(rcSeSuCurr.sesunuse);
    FETCH cuAllCargos bulk collect
      INTO tbCargos;
    CLOSE cuAllCargos;
    /* else
        ut_trace.trace('Procesando los cargos asociados al documento: '||
        isbDocumento ||' y al producto '|| rcSeSuCurr.sesunuse, 5);
        OPEN cuCargos(rcSeSuCurr.sesunuse, isbDocumento);
        FETCH cuCargos bulk collect INTO tbCargos;
        CLOSE cuCargos;
    END if;*/

    if (tbCargos.count > 0) then
      -- Valida que el producto pertenezca al contrato
      ValSubsNServ(rcSuscCurr.susccodi, rcSeSuCurr.sesunuse);
    END if;

    ut_trace.trace('Periodo de facturacion actual: ' ||
                   rcPerifactCurr.pefacodi,
                   5);

    -- Recorrer tabla de cargos.
    nuIdxCargos := tbCargos.first;

    loop
      EXIT WHEN(nuIdxCargos IS NULL);
      rcCargos := tbCargos(nuIdxCargos);

      ut_trace.trace('Procesando cargo: [Concepto]=' || rcCargos.cargconc ||
                     ' - [Valor] = ' || rcCargos.cargvalo,
                     5);

      -- Genera Estado de cuenta cuando se trata del primer servicio suscrito
      /*if ( not (boAccountStGenerado)) then
          GenerateAccountStatus;
      end if;

      -- Genera cuenta si no se ha generado antes
      if ( not (boCuentaGenerada)) then
         GenerateAccount;
      end if;*/

      -- Actualiza Cartera
      pkUpdAccoReceiv.UpdAccoRec(pkBillConst.cnuSUMA_CARGO,
                                 nuCuenta,
                                 pktblservsusc.fnuGetSuscription(rcCargos.cargnuse), --  rcCargos.cargsusc,
                                 rcCargos.cargnuse,
                                 rcCargos.cargconc,
                                 rcCargos.cargsign,
                                 rcCargos.cargvalo,
                                 pkBillConst.cnuNO_UPDATE_DB);

      -- Almacena informacion del cargo procesado
      tbCargfact(nuIdx) := nuEstadoCuenta;
      tbCargcuco(nuIdx) := nuCuenta;
      tbCargfeco(nuIdx) := dtFechaContable;
      tbCargtipr(nuIdx) := pkBillConst.AUTOMATICO;

      /*Se asigna la fecha de generacion de la factura a la
      fecha de creacion del cargo*/
      ut_trace.trace('rcCargos.cargfecr' || rcCargos.cargfecr, 5);
      ut_trace.trace('grcEstadoCta.factfege ' || grcEstadoCta.factfege, 5);

      IF (rcCargos.cargfecr > grcEstadoCta.factfege) THEN

        tbCargdate(nuIdx) := grcEstadoCta.factfege;

        ut_trace.trace('Actualizo fecha con la fecha de generacion de factura ' ||
                       grcEstadoCta.factfege,
                       5);

      else
        tbCargdate(nuIdx) := rcCargos.cargfecr;

      END IF;

      tbRowid(nuIdx) := rcCargos.sbrowid;

      nuIdx := nuIdx + 1;

      CalcularFechaUltLiqConcepto(rcCargos.cargconc, rcCargos.cargpeco);

      nuIdxCargos := tbCargos.NEXT(nuIdxCargos);
    END loop;

    -- Actualiza los Cargos
    if (nuIdx > 1) then
      -- Actualiza el Cargo current
      UpdateCharges;

      -- Actualiza fecha de ultima facturacion del concepto.
      ActFechaUltFactConceptos;
    end if;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      /*IF (cuCargos%isOpen) THEN
         CLOSE cuCargos;
      END IF;*/
      IF (cuAllCargos%isOpen) THEN
        CLOSE cuAllCargos;
      END IF;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      /* IF (cuCargos%isOpen) THEN
         CLOSE cuCargos;
      END IF;*/
      IF (cuAllCargos%isOpen) THEN
        CLOSE cuAllCargos;
      END IF;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      /*IF (cuCargos%isOpen) THEN
         CLOSE cuCargos;
      END IF;*/
      IF (cuAllCargos%isOpen) THEN
        CLOSE cuAllCargos;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END ProcessCharges;

  --********************************************************************************************

  PROCEDURE UpdateAccoRec IS
  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.UpdateAccoRec');

    -- Actualiza la cartera
    pkUpdAccoReceiv.UpdateData;

    -- Obtiene valores de la cuenta de cobro
    pkUpdAccoReceiv.GetAccountData(nuCuenta,
                                   nuCart_ValorCta,
                                   nuCart_AbonoCta,
                                   nuCart_SaldoCta);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END UpdateAccoRec;

  --********************************************************************************************

  PROCEDURE ProcessGeneratedAcco IS

    sbSignoAjuste cargos.cargsign%type; -- Signo del ajuste

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ProcessGeneratedAcco');

    -- Genera Ajuste de la cuenta
    AdjustAccount;

    -- Genera posible saldo a favor
    pkAccountMgr.GenPositiveBal(nuCuenta);

    -- Aplica saldo a favor
    pkAccountMgr.ApplyPositiveBalServ(rcSeSuCurr.sesunuse,
                                      nuCuenta,
                                      pkBillConst.POST_FACTURACION, --pkBillConst.MANUAL,
                                      dtFechaGene);

    -- Actualiza acumulados de facturacion por cuenta
    UpdAccoBillValues;

    -- Obtiene saldo pendiente de la factura
    nuSaldoFac := pkBCAccountStatus.fnuGetBalance(nuEstadoCuenta);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END ProcessGeneratedAcco;

  --********************************************************************************************
  PROCEDURE AsignaNumeracionFiscal IS

    ------------------------------------------------------------------------
    -- Variables
    ------------------------------------------------------------------------

    -- Tipo de comprobante
    nuTipoComprobante tipocomp.ticocodi%type;

  BEGIN

    pkErrors.Push('pkGenerateInvoice.AsignaNumeracionFiscal');

    -- Se asigna el tipo de documento
    grcEstadoCta.factcons := gnuTipoDocumento;

    -- Se obtiene el numero fiscal
    pkConsecutiveMgr.GetFiscalNumber(pkConsecutiveMgr.gcsbTOKENFACTURA,
                                     grcEstadoCta.factcodi,
                                     null,
                                     grcEstadoCta.factcons,
                                     rcSuscCurr.suscclie,
                                     rcSuscCurr.suscsist,
                                     grcEstadoCta.factnufi,
                                     grcEstadoCta.factpref,
                                     grcEstadoCta.factconf,
                                     nuTipoComprobante);

    -- Se actualiza la factura
    pktblFactura.UpFiscalNumber(grcEstadoCta.factcodi,
                                grcEstadoCta.factnufi,
                                grcEstadoCta.factcons,
                                grcEstadoCta.factconf,
                                grcEstadoCta.factpref);

    -- Se limpia el registro global de factura
    grcEstadoCta := null;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise LOGIN_DENIED;
    when OTHERS then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;
  END AsignaNumeracionFiscal;
  --********************************************************************************************

  --********************************************************************************************

  FUNCTION ValInputData(osbError out varchar2) return number IS
  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ValInputData');

    -- Valida la suscripcion
    ValSubscriber(nuSuscripcion);

    -- Valida el servicio suscrito
    ValSubsService(nuServsusc);

    -- Valida que el producto pertenezca al contrato
    ValSubsNServ(nuSuscripcion, nuServsusc);

    -- Valida la fecha de generacion
    ValGenerationDate(dtFechaGene);

    return(1);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END ValInputData;

  --********************************************************************************************

  PROCEDURE ValSubsService(inuServsusc in servsusc.sesunuse%type) IS

    ----------------------------------------------------------------------------
    -- VerifyProdProcessSecurity -- Valida estados del corte Producto
    ----------------------------------------------------------------------------
    PROCEDURE VerifyProdProcessSecurity(inuSesu servsusc.sesunuse%type) IS
      sbProc procrest.prreproc%type;
    BEGIN

      pkErrors.Push('pkAccountMgr.VerifyProdProcessSecurity');

      sbProc := pkErrors.fsbGetApplication;

      -- Se valida si el producto tiene restriccion de pago por corte
      pkBOProcessSecurity.ValidateProductSecurity(inuSesu, sbProc);
      pkErrors.Pop;

    EXCEPTION
      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

      when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    END VerifyProdProcessSecurity;

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ValSubsService');

    -- Realiza la validacion basica del servicio suscrito
    pkServNumberMgr.ValBasicData(inuServsusc);

    VerifyProdProcessSecurity(inuServsusc);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END ValSubsService;
  --********************************************************************************************

  PROCEDURE ValSubscriber(inuSuscripcion in suscripc.susccodi%type) IS

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ValSubscriber');

    -- Realiza la validacion basica de la suscripcion
    pkSubscriberMgr.ValBasicData(inuSuscripcion);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END ValSubscriber;

  --********************************************************************************************

  PROCEDURE ValSupportDoc(isbDocumento in cargos.cargdoso%type) IS

    -- Error en el documento soporte
    cnuERROR_DOCSOP constant number := 11517;

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ValSupportDoc');

    if (isbDocumento is null) then

      pkErrors.SetErrorCode(pkConstante.csbDIVISION,
                            pkConstante.csbMOD_BIL,
                            cnuERROR_DOCSOP);

      raise LOGIN_DENIED;

    end if;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END ValSupportDoc;

  --********************************************************************************************
  PROCEDURE ValSubsNServ(inuSubscription in suscripc.susccodi%type,
                         inuServNum      in servsusc.sesunuse%type) IS

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ValSubsNServ');

    pkServNumberMgr.ValSubscription(inuSubscription, inuServNum);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END ValSubsNServ;
  --********************************************************************************************

  FUNCTION ValContProdServ(inuSubscription in suscripc.susccodi%type,
                           inuServNum      in servsusc.sesunuse%type,
                           inuserv         in servsusc.sesuserv%type)
    return number is

    sbExiste varchar2(1);
    nuRes    number(1);

    cursor cuservsusc is
      select 'x'
        from servsusc
       where sesususc = inuSubscription
         and sesunuse = inuServNum
         and sesuserv = inuserv;

  BEGIN

    if inuSubscription < 1 or inuServNum < 1 or inuserv < 1 then
      nuRes := 1;
    else
      open cuservsusc;
      fetch cuservsusc
        into sbExiste;
      if cuservsusc%notfound then
        nuRes := 1;
      else
        nuRes := 0;
      end if;
      close cuservsusc;
    end if;

    return(nures);

  EXCEPTION
    when others then
      return - 1;
  END ValContProdServ;

  --********************************************************************************************

  FUNCTION ValConcepto(inuConcepto concepto.conccodi%type) return number is

    sbExiste varchar2(1);
    nuRes    number(1);

    cursor cuConcepto is
      select 'x' from concepto where conccodi = inuConcepto;

  BEGIN
    if inuConcepto < 1 then
      nuRes := 1;
    else
      open cuConcepto;
      fetch cuConcepto
        into sbExiste;
      if cuConcepto%notfound then
        nuRes := 1;
      else
        nuRes := 0;
      end if;
      close cuConcepto;
    end if;

    return(nures);

  EXCEPTION
    when others then
      return - 1;
  END ValConcepto;

  --********************************************************************************************

  FUNCTION ValCausal(inuCausal causcarg.cacacodi%type) return number is

    sbExiste varchar2(1);
    nuRes    number(1);

    cursor cuCausal is
      select 'x' from causcarg where cacacodi = inuCausal;

  BEGIN
    if inuCausal < 1 then
      nuRes := 1;
    else
      open cuCausal;
      fetch cuCausal
        into sbExiste;
      if cuCausal%notfound then
        nuRes := 1;
      else
        nuRes := 0;
      end if;
      close cuCausal;
    end if;

    return(nures);

  EXCEPTION
    when others then
      return - 1;
  END ValCausal;

  --********************************************************************************************

  FUNCTION ValPlanFina(inuPlan plandife.PLDICODI%type) return number is

    sbExiste varchar2(1);
    nuRes    number(1);

    cursor cuPlan is
      select 'x' from plandife where PLDICODI = inuPlan;

  BEGIN
    if inuPlan < 1 then
      nuRes := 1;
    else
      open cuPlan;
      fetch cuPlan
        into sbExiste;
      if cuPlan%notfound then
        nuRes := 1;
      else
        nuRes := 0;
      end if;
      close cuPlan;
    end if;

    return(nures);

  EXCEPTION
    when others then
      return - 1;
  END ValPlanFina;
  --********************************************************************************************

  FUNCTION fboGetIsNumber(isbValor varchar2) return boolean is

    blResult boolean := TRUE;
    nuRes    number;

  BEGIN
    begin
      nuRes := to_number(isbValor);
    exception
      when others then
        blResult := FALSE;
    end;

    return(blResult);

  EXCEPTION
    when others then
      return(FALSE);
  END fboGetIsNumber;

  --********************************************************************************************

  PROCEDURE ValGenerationDate(idtFechaGene in date) IS

    -- Fecha fuera de rango de fechas de movimientos del periodo de
    -- facturacion current
    cnuDATE_OUT_OF_RANGE constant number := 10116;

  BEGIN

    pkErrors.Push('pkGenerateInvoice.ValGenerationDate');

    pkGeneralServices.ValDateY2K(idtFechaGene);

    -- Valida que la fecha de generacion de cuentas se encuentre entre las
    -- fechas de movimientos del periodo
    if (trunc(idtFechaGene) < trunc(rcPerifactCurr.pefafimo) or
       trunc(idtFechaGene) > trunc(rcPerifactCurr.pefaffmo)) then
      pkErrors.SetErrorCode(pkConstante.csbDIVISION,
                            pkConstante.csbMOD_BIL,
                            cnuDATE_OUT_OF_RANGE);
      raise LOGIN_DENIED;
    end if;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;
    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
  END ValGenerationDate;

  --********************************************************************************************

  PROCEDURE GenerateAccount IS

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.GenerateAccount');

    -- Define cuenta para el servicio suscrito
    nuCuenta := fnuGetAccountNumber;

    AddAccount;

    -- Se pudo generar la cuenta
    boCuentaGenerada := TRUE;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      boCuentaGenerada := FALSE;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      boCuentaGenerada := FALSE;
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      boCuentaGenerada := FALSE;
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END GenerateAccount;

  --********************************************************************************************

  PROCEDURE GenerateAccountStatus IS

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.GenerateAccountStatus');

    -- Define estado de cuenta para la suscripcion
    nuEstadoCuenta := fnuGetAccountStNumber;

    -- Adiciona el registro del nuevo estado de cuenta
    AddAccountStatus;

    -- Genero estado de cuenta
    boAccountStGenerado := TRUE;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      boAccountStGenerado := FALSE;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      boAccountStGenerado := FALSE;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      boAccountStGenerado := FALSE;
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END GenerateAccountStatus;

  --********************************************************************************************

  PROCEDURE UpdateCharges IS

    -- Colecciones temporales para almacenar la informacion de los cargos que se
    -- estan actualizando
    tbCargnuse pktblCargos.tyCargnuse;
    tbCargconc pktblCargos.tyCargconc;
    tbCargvalo pktblCargos.tyCargvalo;
    tbCargvabl pktblCargos.tyCargvabl;
    tbCargsign pktblCargos.tyCargsign;
    tbCargcaca pktblCargos.tyCargcaca;
    tbCargdoso pktblCargos.tyCargdoso;
    tbCargfecr pktblCargos.tyCargfecr;

    tbCargnuseNull pktblCargos.tyCargnuse;
    tbCargconcNull pktblCargos.tyCargconc;
    tbCargvaloNull pktblCargos.tyCargvalo;
    tbCargvablNull pktblCargos.tyCargvabl;
    tbCargsignNull pktblCargos.tyCargsign;
    tbCargcacaNull pktblCargos.tyCargcaca;
    tbCargdosoNull pktblCargos.tyCargdoso;
    tbCargfecrNull pktblCargos.tyCargfecr;

    PROCEDURE ClearArrays IS
    BEGIN
      --{

      tbCargnuse := tbCargnuseNull;
      tbCargconc := tbCargconcNull;
      tbCargvalo := tbCargvaloNull;
      tbCargvabl := tbCargvablNull;
      tbCargcaca := tbCargcacaNull;
      tbCargsign := tbCargsignNull;
      tbCargdoso := tbCargdosoNull;
      tbCargfecr := tbCargfecrNull;

      tbCargnuse.DELETE;
      tbCargconc.DELETE;
      tbCargvalo.DELETE;
      tbCargvabl.DELETE;
      tbCargcaca.DELETE;
      tbCargsign.DELETE;
      tbCargdoso.DELETE;
      tbCargfecr.DELETE;

      --}
    END ClearArrays;

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.UpdateCharges');

    -- Limpia colecciones temporales
    ClearArrays;

    -- Realiza la actualizacion del cargo
    FORALL nuIndex in tbCargfact.FIRST .. tbCargfact.LAST
      UPDATE cargos
         SET --cargfact = tbCargfact (nuIndex),
             cargcuco = tbCargcuco(nuIndex),
             cargfecr = tbCargdate(nuIndex),
             --cargfeco = tbCargfeco (nuIndex),
             cargtipr = tbCargtipr(nuIndex)
       WHERE rowid = tbRowid(nuIndex)
      RETURNING cargnuse, cargconc, cargvalo, cargvabl, cargsign, cargcaca, cargdoso, cargfecr BULK COLLECT INTO tbcargnuse, tbCargconc, tbCargvalo, tbcargvabl, tbCargsign, tbCargcaca, tbCargdoso, tbcargfecr;

    -- Acumula valores facturados

    for nuIdx in tbCargvalo.FIRST .. tbCargvalo.LAST loop
      --{
      -- Evalua si se trata de una cuota de capital de diferido o
      -- una cuota extra para no acumularla como valor facturado
      -- Se evalua ademas que la causa de cargo de los cargos no sea la obtenida
      -- del parametro de causa de cargo por traslado de diferido.
      if (substr(tbCargdoso(nuIdx), 1, 3) = pkBillConst.csbTOKEN_DIFERIDO or
         substr(tbCargdoso(nuIdx), 1, 3) =
         pkBillConst.csbTOKEN_CUOTA_EXTRA or
         FA_BOChargeCauses.fboIsDefTransChCause(tbCargcaca(nuIdx))) then
        goto PROXIMO;
      end if;

      -- Acumula valores facturados
      if (tbCargsign(nuIdx) = pkBillConst.DEBITO) then
        --{
        -- Se acumula el valor facturado de la cuenta de cobro y la factura
        nuVlrFactCta := nuVlrFactCta + tbCargvalo(nuIdx);
        nuVlrFactFac := nuVlrFactFac + tbCargvalo(nuIdx);

        -- Se obtiene la informacion del concepto para determinar si se trata
        -- de un concepto de impuesto
        if (pkConceptMgr.fblIsTaxesConcept(tbCargconc(nuIdx))) then
          --{
          -- Se acumula el valor del IVA facturado para la cuenta de cobro
          nuVlrIvaFactCta := nuVlrIvaFactCta + tbCargvalo(nuIdx);

          -- Se acumula el valor del IVA facturado para la factura
          nuVlrIvaFactFac := nuVlrIvaFactFac + tbCargvalo(nuIdx);
          --}
        else
          -- Se acumula el valor del IVA facturado para la cuenta de cobro
          nuVlrIvaFactCta := nuVlrIvaFactCta +
                             FA_BOIVAModeMgr.fnuGetValueIVA(tbCargnuse(nuIdx),
                                                            tbCargconc(nuIdx),
                                                            nvl(tbCargvabl(nuIdx),
                                                                tbCargvalo(nuIdx)),
                                                            tbCargfecr(nuIdx));

          -- Se acumula el valor del IVA facturado para la factura
          nuVlrIvaFactFac := nuVlrIvaFactFac +
                             FA_BOIVAModeMgr.fnuGetValueIVA(tbCargnuse(nuIdx),
                                                            tbCargconc(nuIdx),
                                                            nvl(tbCargvabl(nuIdx),
                                                                tbCargvalo(nuIdx)),
                                                            tbCargfecr(nuIdx));
        end if;
        --}
      else
        --{
        -- Se acumula el valor facturado de la cuenta de cobro y la factura
        nuVlrFactCta := nuVlrFactCta - tbCargvalo(nuIdx);
        nuVlrFactFac := nuVlrFactFac - tbCargvalo(nuIdx);

        -- Se obtiene la informacion del concepto para determinar si se trata
        -- de un concepto de impuesto
        if (pkConceptMgr.fblIsTaxesConcept(tbCargconc(nuIdx))) then
          --{
          -- Se acumula el valor del IVA facturado para la cuenta de cobro
          nuVlrIvaFactCta := nuVlrIvaFactCta - tbCargvalo(nuIdx);

          -- Se acumula el valor del IVA facturado para la factura
          nuVlrIvaFactFac := nuVlrIvaFactFac - tbCargvalo(nuIdx);
        else
          -- Se acumula el valor del IVA facturado para la cuenta de cobro
          nuVlrIvaFactCta := nuVlrIvaFactCta -
                             FA_BOIVAModeMgr.fnuGetValueIVA(tbCargnuse(nuIdx),
                                                            tbCargconc(nuIdx),
                                                            nvl(tbCargvabl(nuIdx),
                                                                tbCargvalo(nuIdx)),
                                                            tbCargfecr(nuIdx));

          -- Se acumula el valor del IVA facturado para la factura
          nuVlrIvaFactFac := nuVlrIvaFactFac -
                             FA_BOIVAModeMgr.fnuGetValueIVA(tbCargnuse(nuIdx),
                                                            tbCargconc(nuIdx),
                                                            nvl(tbCargvabl(nuIdx),
                                                                tbCargvalo(nuIdx)),
                                                            tbCargfecr(nuIdx));
          --}
        end if;
        --}
      end if;

      <<PROXIMO>>
      null;
      --}
    end loop;

    -- Limpia colecciones temporales
    ClearArrays;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END UpdateCharges;

  --********************************************************************************************

  PROCEDURE AdjustAccount IS

    nuValorCta    cuencobr.cucovato%type; -- Valor total cuenta
    nuVlrAjustes  number; -- Suma ajustes previos Cta
    sbSignoAjuste cargos.cargsign%type; -- Signo ajuste
    nuVlrAjuste   cargos.cargvalo%type; -- Valor ajuste
    sbSignCanc    cargos.cargsign%type; -- Signo de cancelacion ajuste

    -- Evaluacion si se deben o no ajustar las cuentas de acuerdo a la
    -- configuracion realizada en los parametros de facturacion
    boAjustarCuentas boolean;
    -- Factor de ajuste de cuenta
    nuFactorAjusteCta timoempr.tmemfaaj%type;

    -----------------------------------------------------------------------
    -- Procedimientos Encapsulados
    -----------------------------------------------------------------------
    -- --------------------------------------------------------------------
    --   Evalua si el valor necesita o no ajuste
    -- --------------------------------------------------------------------
    FUNCTION fblNeedAdjust(inuValorCta in cuencobr.cucovato%type)
      RETURN boolean IS

      nuValor       cuencobr.cucovato%type; -- Valor absoluto cuenta
      nuVlrAAjustar cuencobr.cucovato%type; -- Valor a ajustar

    BEGIN
      --{
      pkErrors.Push('pkGenerateInvoice.fblNeedAdjust');

      nuValor := inuValorCta;

      -- Valida el valor de la cuenta

      if (nuValor = 0.00 or nuValor is null) then
        pkErrors.Pop;
        return(FALSE);
      end if;

      -- Obtiene residuo del valor de la cuenta vs el factor de ajuste
      nuVlrAAjustar := mod(abs(nuValor), nuFactorAjusteCta);

      -- En caso de que no haya valor desajustado, retorna

      if (nuVlrAAjustar = 0.00) then
        pkErrors.Pop;
        return(FALSE);
      end if;

      pkErrors.Pop;
      return(TRUE);

    EXCEPTION
      when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

      when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

      when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
        --}
    END fblNeedAdjust;
    -- --------------------------------------------------------------------
    --  Adiciona cargo de ajuste
    -- --------------------------------------------------------------------
    PROCEDURE AddCharge(inuVlrCargo in cargos.cargvalo%type,
                        isbSigno    in cargos.cargsign%type,
                        isbDocSop   in cargos.cargdoso%type) IS
    BEGIN
      --{

      pkErrors.Push('pkGenerateInvoice.AddCharge');

      -- Adiciona el Cargo
      GenerateCharge(nuConcAjuste,
                     isbSigno,
                     isbDocSop,
                     FA_BOChargeCauses.fnuGenericChCause(pkConstante.NULLNUM), -- causal original en pkGenInvoice
                     abs(inuVlrCargo),
                     0, -- consdocu (cargcodo)
                     pkBillConst.AUTOMATICO -- tipoproc
                     );

      -- Actualiza cartera
      pkUpdAccoReceiv.UpdAccoRec(pkBillConst.cnuSUMA_CARGO,
                                 nuCuenta,
                                 rcSuscCurr.susccodi,
                                 rcSeSuCurr.sesunuse,
                                 nuConcAjuste,
                                 isbSigno,
                                 abs(inuVlrCargo),
                                 pkBillConst.cnuNO_UPDATE_DB);

      UpdateAccoRec;

      -- Actualiza el acumulado de los valores facturados

      if (isbSigno = pkBillConst.DEBITO) then
        --{

        -- Cargo debito
        nuVlrFactCta := nuVlrFactCta + abs(inuVlrCargo);
        nuVlrFactFac := nuVlrFactFac + abs(inuVlrCargo);

        --}
      else
        --{
        -- Cargo credito
        nuVlrFactCta := nuVlrFactCta - abs(inuVlrCargo);
        nuVlrFactFac := nuVlrFactFac - abs(inuVlrCargo);
        --}
      end if;

      pkErrors.Pop;

    EXCEPTION
      when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

      when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

      when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
        --}
    END AddCharge;

    ------------------------------------------------------------------------

  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.AdjustAccount');

    -- Obtiene validacion ajuste a la cuenta
    FA_BOPoliticaRedondeo.ObtienePoliticaAjuste(rcSeSuCurr.sesususc,
                                                boAjustarCuentas,
                                                nuFactorAjusteCta);

    -- Evalua si se debe realizar ajuste, de acuerdo a los parametros

    if (not boAjustarCuentas) then
      pkErrors.Pop;
      return;
    end if;

    -- Obtiene el valor de la cuenta actualizado
    nuValorCta := nuCart_ValorCta;

    -- Evalua si necesita ajuste

    if (not fblNeedAdjust(nuValorCta)) then
      pkErrors.Pop;
      return;
    end if;

    -- Obtiene el valor de los ajustes realizados a la cuenta
    nuVlrAjustes := fnuGetAdjustValue;

    -- Evalua si debe cancelar ajustes previos

    if (nuVlrAjustes != 0.00) then
      --{
      -- Obtiene signo de cancelacion de cargo ajuste
      sbSignCanc := pkChargeMgr.fsbGetCancelSign(nuVlrAjustes);

      -- Crea cargo de cancelacion
      AddCharge(nuVlrAjustes, sbSignCanc, pkBillConst.csbDOC_CANC_AJUSTE);
      --}
    end if;

    -- Obtiene el valor de la cuenta actualizado
    nuValorCta := nuCart_ValorCta;

    -- Calcula el valor y signo del nuevo ajuste
    CalcAdjustValue(nuFactorAjusteCta,
                    nuValorCta,
                    nuVlrAjuste,
                    sbSignoAjuste);

    -- Evalua si se debe adicionar cargo

    if (nuVlrAjuste = 0.00) then
      pkErrors.Pop;
      return;
    end if;

    -- Crea cargo con el nuevo ajuste
    AddCharge(nuVlrAjuste, sbSignoAjuste, pkBillConst.csbDOC_AJUSTE);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END AdjustAccount;

  --********************************************************************************************

  FUNCTION fnuGetAccountNumber RETURN number IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- Numero de cuenta
    nuCta cuencobr.cucocodi%type;

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.fnuGetAccountNumber');

    -- Obtiene el numero de la cuenta del consecutivo
    pkAccountMgr.GetNewAccountNum(nuCta);

    pkErrors.Pop;

    -- Cerramos el bloque autonomo
    pkgeneralservices.CommitTransaction;

    return(nuCta);

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END fnuGetAccountNumber;

  --********************************************************************************************

  FUNCTION fnuGetAccountStNumber RETURN number IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    nuEstadoCta factura.factcodi%type; -- Numero estado de cuenta

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.fnuGetAccountStNumber');

    -- Obtiene el numero del estado de cuenta del consecutivo
    pkAccountStatusMgr.GetNewAccoStatusNum(nuEstadoCta);

    pkErrors.Pop;

    -- Cerramos el bloque autonomo
    pkgeneralservices.CommitTransaction;

    return(nuEstadoCta);

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END fnuGetAccountStNumber;

  --********************************************************************************************

  PROCEDURE AddAccount IS

    rcCuenta cuencobr%rowtype; -- Record de cuenta de cobro

    ----------------------------------------------------------------------
    -- METODOS ENCAPSULADOS
    ----------------------------------------------------------------------

    PROCEDURE FillRecord IS

      rcCuenCobrNull cuencobr%rowtype; -- Record Nulo Cuenta
    BEGIN
      --{

      pkErrors.Push('pkGenerateInvoice.AddAccount.FillRecord');

      rcCuenta := rcCuenCobrNull;

      -- Se prepara el registro de la Cuenta de Cobro
      -- Ya se tiene current la cuenta de cobro
      rcCuenta.cucocodi := nuCuenta;
      rcCuenta.cucogrim := 99;
      rcCuenta.cucovaap := pkBillConst.CERO;
      rcCuenta.cucovare := pkBillConst.CERO;
      rcCuenta.cucodepa := nuDepa;
      rcCuenta.cucoloca := nuLoca;
      rcCuenta.cucocate := rcSeSuCurr.sesucate;
      rcCuenta.cucosuca := rcSeSuCurr.sesusuca;
      rcCuenta.cucoplsu := rcSeSuCurr.sesuplfa;
      rcCuenta.cucovato := pkBillConst.CERO;
      rcCuenta.cucovaab := pkBillConst.CERO;
      rcCuenta.cucovafa := pkBillConst.CERO;
      rcCuenta.cucoimfa := pkBillConst.CERO;
      rcCuenta.cucofepa := null;
      rcCuenta.cucosacu := pkBillConst.CERO;
      rcCuenta.cucovrap := pkBillConst.CERO;
      rcCuenta.cuconuse := rcSeSuCurr.sesunuse;
      rcCuenta.cucofact := nuEstadoCuenta;
      rcCuenta.cucofaag := nuEstadoCuenta;
      rcCuenta.cucofeve := pkSubsDateLineMgr.fdtGetDateLine(rcSeSuCurr.sesususc,
                                                            rcPerifactCurr.pefaano,
                                                            rcPerifactCurr.pefames,
                                                            rcPerifactCurr.pefafepa);

      -- Se obtiene la direccion de instalacion del producto
      rcCuenta.cucodiin := pr_bcproduct.fnuGetAddressId(rcSeSuCurr.sesunuse);
      rcCuenta.cucosist := rcSeSuCurr.sesusist;

      pkErrors.Pop;

    EXCEPTION
      when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

      when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

      --}
    END FillRecord;

    ----------------------------------------------------------------------

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.AddAccount');

    -- Se prepara el registro de la Cuenta de Cobro
    FillRecord;

    -- Se adiciona el registro a la tabla Cuencobr
    pktblCuencobr.InsRecord(rcCuenta);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END AddAccount;

  --********************************************************************************************

  PROCEDURE AddAccountStatus IS

    rcEstadoCta factura%rowtype := NULL; -- Record de Estado de cuenta

    ----------------------------------------------------------------------
    -- METODOS ENCAPSULADOS
    ----------------------------------------------------------------------

    PROCEDURE FillNewRecord IS

      rcEstadoCtaNull factura%rowtype := NULL; -- Record Nulo Estado Cuenta

    BEGIN
      --{
      pkErrors.Push('pkGenerateInvoice.AddAccountStatus.FillNewRecord');

      rcEstadoCta := rcEstadoCtaNull;

      -- Se prepara el registro del Estado de Cuenta
      -- Estado de cuenta current
      rcEstadoCta.factcodi := nuEstadoCuenta;

      -- Suscripcion current
      rcEstadoCta.factsusc := rcSuscCurr.susccodi;
      rcEstadoCta.factvaap := pkBillConst.CERO;
      rcEstadoCta.factpefa := rcPerifactCurr.pefacodi;

      -- Dejar current sysdate en esta variable
      rcEstadoCta.factfege := dtFechaGene;
      rcEstadoCta.factterm := sbTerminal;
      rcEstadoCta.factusua := sa_bosystem.getSystemUserID;

      --  Asigna el valor del campo departamento y localidad
      rcEstadoCta.factdepa := nuDepa;
      rcEstadoCta.factloca := nuLoca;
      -- Se obtiene la direccion de cobro
      rcEstadoCta.factdico := rcSuscCurr.susciddi;

      rcEstadoCta.factprog := nuPrograma;

      -- La numeracion fiscal pasa a ser asignada despues de aceptar
      -- y ser creada la factura y todo su proceso
      pkErrors.Pop;

    EXCEPTION
      when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
        pkErrors.Pop;
        raise LOGIN_DENIED;

      when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
        --}
    END FillNewRecord;

    ----------------------------------------------------------------------

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.AddAccountStatus');

    -- Se prepara el registro del Estado de cuenta
    FillNewRecord;

    -- guarda informacion de la factura generada
    grcEstadoCta := rcEstadoCta;

    -- Se adiciona el registro a la tabla Factura
    pktblFactura.InsRecord(rcEstadoCta);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END AddAccountStatus;

  --********************************************************************************************
  FUNCTION fnuGetAdjustValue RETURN number IS

    nuVlrAjustes number; -- Valor de los ajustes

    -- Documento de soporte para ajuste de cuenta
    csbAJUSTE constant varchar2(15) := 'AJUSTE';

    -- Documento de soporte para cancelacion de ajuste de cuenta
    csbCANCAJUSTE constant varchar2(15) := 'CANC.AJUSTE';

    -- Cursor para sumar los ajuste de la cuenta
    CURSOR cuAjuste(nuCuenta   cargos.cargcuco%type,
                    nuConcepto cargos.cargconc%type) IS
      SELECT nvl(sum(decode(upper(cargsign),
                            pkBillConst.DEBITO,
                            cargvalo,
                            pkBillConst.CREDITO,
                            -cargvalo,
                            0)),
                 0)
        FROM cargos
       WHERE cargcuco = nuCuenta
         AND cargconc = nuConcepto
         AND cargdoso || '' in (csbAJUSTE, csbCANCAJUSTE);

  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.fnuGetAdjustValue');

    -- Obtiene el valor de los ajustes de la cuenta
    open cuAjuste(nuCuenta, nuConcAjuste);

    fetch cuAjuste
      into nuVlrAjustes;
    close cuAjuste;

    pkErrors.Pop;
    return(nuVlrAjustes);

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END fnuGetAdjustValue;

  --********************************************************************************************

  PROCEDURE CalcAdjustValue(inuFactor      in timoempr.tmemfaaj%type,
                            inuValorCta    in cuencobr.cucovato%type,
                            onuValorAjuste out cargos.cargvalo%type,
                            osbSignoAjuste out cargos.cargsign%type) IS

    nuValor       cuencobr.cucovato%type; -- Valor absoluto cuenta
    nuVlrAAjustar number; -- Valor que se va a ajustar

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.CalcAdjustValue');

    onuValorAjuste := pkBillConst.CERO;
    osbSignoAjuste := null;
    nuValor        := inuValorCta;

    -- Valida el valor de la cuenta

    if (nuValor = 0.00 or nuValor is null) then
      pkErrors.Pop;
      return;
    end if;

    -- Evalua si el valor de la cuenta es negativo

    if (nuValor < 0.00) then
      nuValor := abs(nuValor);
    end if;

    -- Obtiene residuo del valor de la cuenta vs el factor de ajuste
    nuVlrAAjustar := mod(nuValor, inuFactor);

    -- En caso de que no haya valor desajustado, retorna

    if (nuVlrAAjustar = 0.00) then
      pkErrors.Pop;
      return;
    end if;

    -- Evalua si el ajuste es por encima o por debajo, comparando contra
    -- la mitad del factor de ajuste

    if ((inuFactor - nuVlrAAjustar) > (inuFactor / 2)) then
      onuValorAjuste := nuVlrAAjustar;
      osbSignoAjuste := pkBillConst.CREDITO;
    else
      onuValorAjuste := inuFactor - nuVlrAAjustar;
      osbSignoAjuste := pkBillConst.DEBITO;
    end if;

    -- Verifica si el Valor Total de la Cuenta es Negativo
    -- para invertir el Signo del cargo de Ajuste

    if (inuValorCta < 0.00) then
      --{
      if (osbSignoAjuste = pkBillConst.DEBITO) then
        osbSignoAjuste := pkBillConst.CREDITO;
      else
        osbSignoAjuste := pkBillConst.DEBITO;
      end if;
      --}
    end if;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END CalcAdjustValue;

  --********************************************************************************************

  PROCEDURE UpdAccoBillValues IS

  BEGIN
    --{

    pkErrors.Push('pkGenerateBill.UpdAccoBillValues');

    pktblCuencobr.UpBilledValues(nuCuenta, nuVlrFactCta, nuVlrIvaFactCta);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END UpdAccoBillValues;

  --********************************************************************************************
  PROCEDURE GetOverChargePercent(inuPlandife         in plandife.pldicodi%type,
                                 onuPercenOverCharge out number) IS
  BEGIN
    onuPercenOverCharge := pktblPlandife.fnuPercOverCharge(inuPlandife,
                                                           pkConstante.NOCACHE);
    onuPercenOverCharge := nvl(onuPercenOverCharge, 0);

    if onuPercenOverCharge not between 0 AND 100 then
      -- El porcentaje de mora configurado en el plan de financiacion (%s1) no es correcto
      errors.setError(cnuBadOverChargePercent, inuPlandife);
      raise ex.controlled_error;
    END if;
  EXCEPTION
    WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;
  --*******************************************************************************************
  PROCEDURE ValInterestConcept(inuConc in concepto.conccodi%type) IS

  BEGIN
    --{

    ut_trace.trace('cc_bofinancing.ValInterestConcept', cnuNivelTrace + 1);

    -- Valida si el codigo del concepto es nulo

    pkConceptMgr.ValidateNull(inuConc);

    -- Valida si el concepto existe en BD

    pktblConcepto.AccKey(inuConc);

  EXCEPTION
    WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValInterestConcept;

  --*******************************************************************************************
  PROCEDURE GetExtraPayTotal(inuExtraPayNumber in number,
                             onuExtraPayValue  out number) IS
    nuIndex number;
  BEGIN
    ut_trace.trace('cc_bofinancing.GetExtraPayTotal (' ||
                   inuExtraPayNumber || ')',
                   cnuNivelTrace);

    onuExtraPayValue := 0;

    if (nvl(tbExtraPayment.count, 0) = 0) then
      return;
    END if;

    nuIndex := tbExtraPayment.FIRST;

    loop
      exit when nuIndex is null;

      if (tbExtraPayment(nuIndex).ExtraPayNumber = inuExtraPayNumber) then
        onuExtraPayValue := onuExtraPayValue + tbExtraPayment(nuIndex)
                           .extraPayValue;
      END IF;

      nuIndex := tbExtraPayment.next(nuIndex);
    END loop;

  EXCEPTION
    WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;
  --*******************************************************************************************
  PROCEDURE FillAditionalInstalments(inuValorDife  in diferido.difevatd%type,
                                     isbSigno      in diferido.difesign%type,
                                     ichIVA        in char,
                                     iblLastRecord in boolean) IS

    -- Variables Locales

    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */

    /* -------------------------------------------------------------- */

    /*
    Procedure       :       LoadInstalments
    Descripcion     :       Carga Cuotas
          Load Instalments
      */

    PROCEDURE LoadInstalments IS

      nuIndex    number;
      nuVlrCuota cuotextr.cuexvalo%type;
      rcCuotExtr cuotextr%rowtype;

      rcExtraPayments mo_tyobExtraPayments;

      nuQuotaNumber number;

      nuTotCuotaNumber number;

      nuSigno number;

      nuAcumCuotExtr cuotextr.cuexvalo%type;

    BEGIN
      --{
      UT_Trace.Trace('Inicio: [CC_BOFinancing.FillAditionalInstalments.LoadInstalments]',
                     cnuNivelTrace + 3);

      /* Se establece el signo de la cuota */
      nuSigno := pkBillConst.cnuSUMA_CARGO;

      if (isbSigno = pkBillConst.CREDITO) then
        nuSigno := pkBillConst.cnuRESTA_CARGO;
      end if;

      nugTotCuotaExt := nvl(nugTotCuotaExt, pkBillConst.CERO);
      nugNumCuotaExt := nvl(nugNumCuotaExt, pkBillConst.CERO);

      -- Valida si hay Valor a distribuir
      if (nugTotCuotaExt = pkBillConst.CERO) then
        --{
        UT_Trace.Trace('No hay cuotas extras a distribuir para el producto ' ||
                       to_char(nugNumServ),
                       cnuNivelTrace + 4);
        return;
        --}
      end if;

      -- Guarda como numero de diferido la posicion del diferido
      -- en el arreglo de memoria
      rcCuotExtr.cuexdife := nuIdxDife;
      rcCuotExtr.cuexcobr := pkConstante.NO;

      /* Se procesan las cuotas extra */
      nuIndex := tbExtraPayment.first;

      while (nuIndex is not null) loop
        --{
        nuQuotaNumber := tbExtraPayment(nuIndex).ExtraPayNumber;

        /* Se verifica que el valor total a financiar no sea igual al valor
        a financiar del IVA */
        if (nugVlrFinTotal = nugVlrFinIva) then
          --{
          /* Error: Error en la configuracion de la cuota normal del
          diferido */
          pkErrors.SetErrorCode(pkConstante.csbDIVISION,
                                pkConstante.csbMOD_BIL,
                                cnuERROR_CUOTA);

          raise LOGIN_DENIED;
          --}
        end if;

        /* Calcula el valor proporcional de cuota extra */
        nuVlrCuota := tbExtraPayment(nuIndex).ExtraPayValue;
        nuVlrCuota := nuVlrCuota * inuValorDife /
                      (nugVlrFinTotal - nugVlrFinIva);

        /* Se aplica la politica de redondeo sobre el valor de la cuota
        extra calculado */
        FA_BOPoliticaRedondeo.AplicaPolitica(nugNumServ, nuVlrCuota);

        rcCuotExtr.cuexvalo := nuVlrCuota;

        -- Actualiza acumuladores por numero de cuota.
        if tbgAcumExtraPay.exists(nuQuotaNumber) then
          tbgAcumExtraPay(nuQuotaNumber) := tbgAcumExtraPay(nuQuotaNumber) +
                                            nuSigno * rcCuotExtr.cuexvalo;
        else
          tbgAcumExtraPay(nuQuotaNumber) := nuSigno * rcCuotExtr.cuexvalo;
        end if;

        rcCuotExtr.cuexnume := tbExtraPayment(nuIndex).ExtraPayNumber;

        -- Si se trata de la ultima cuota extra del ultimo diferido
        -- Ajusta el valor en caso de que haya diferencia
        -- respecto del acumulado.
        nuAcumCuotExtr := tbgAcumExtraPay(nuQuotaNumber);

        if iblLastRecord then
          GetExtraPayTotal(nuQuotaNumber, nuTotCuotaNumber);

          if (nuAcumCuotExtr <> nuTotCuotaNumber) and
             (abs(nuAcumCuotExtr - nuTotCuotaNumber) < cnuValorTopeAjuste) then
            ut_trace.trace('Ajuste de la cuota extra #' || nuQuotaNumber,
                           cnuNivelTrace);
            nuVlrCuota := rcCuotExtr.cuexvalo +
                          (nuTotCuotaNumber - nuAcumCuotExtr);
            ut_trace.trace('Valor Cuota extra=' || rcCuotExtr.cuexvalo ||
                           '+ (' || nuTotCuotaNumber || '-' ||
                           nuAcumCuotExtr || ') =>' || nuVlrCuota,
                           cnuNivelTrace);
            rcCuotExtr.cuexvalo := nuVlrCuota;
          end if;
        END if;

        UT_Trace.Trace('Numero cuota extra -> [' || to_char(nuQuotaNumber) || ']',
                       cnuNivelTrace + 4);
        UT_Trace.Trace('Valor cuota extra  -> [' ||
                       to_char(rcCuotExtr.cuexvalo) || ']',
                       cnuNivelTrace + 4);

        -- Carga las cuotas Cuotas extras para calculos por Diferido
        pkAditionalPaymentMgr.AddRecord(rcCuotExtr);

        -- Guarda las cuotas Cuotas extras proporcionales en memoria
        rcExtraPayments := mo_tyobExtraPayments(rcCuotExtr.cuexdife, -- "CUEXDIFE"
                                                rcCuotExtr.cuexnume, -- "CUEXNUME"
                                                rcCuotExtr.cuexvalo, -- "CUEXVALO"
                                                rcCuotExtr.cuexcobr, -- "CUEXCOBR"
                                                null -- "CUEXCODO"
                                                );

        tbgExtraPayments.extend;
        nuIdxExtr := tbgExtraPayments.count;
        tbgExtraPayments(nuIdxExtr) := rcExtraPayments;

        nuIndex := tbExtraPayment.next(nuIndex);
        --}
      end loop;

      UT_Trace.Trace('Fin: [CC_BOFinancing.FillAditionalInstalments.LoadInstalments]',
                     cnuNivelTrace + 3);

    EXCEPTION

      when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;

      when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
        --}
    END LoadInstalments;

    /* -------------------------------------------------------------- */

  BEGIN
    --{
    UT_Trace.Trace('Inicio: [CC_BOFinancing.FillAditionalInstalments]',
                   cnuNivelTrace + 2);

    /* Limpia memoria de Cuotas Extras */
    pkAditionalPaymentMgr.ClearMemory;

    /* Si el diferido es de IVA, no se procesa */
    if (ichIVA = pkConstante.SI) then
      return;
    end if;

    /* Calcula el valor de cada cuota extra para el diferido de manera
    proporcional */
    LoadInstalments;

    UT_Trace.Trace('Fin: [CC_BOFinancing.FillAditionalInstalments]',
                   cnuNivelTrace + 2);

  EXCEPTION

    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.SetError;
      raise ex.CONTROLLED_ERROR;
      --}
  END FillAditionalInstalments;

  --*******************************************************************************************
  PROCEDURE GenerateBillingNote IS

    nunotanume notas.notanume%type;
    sbToken    VARCHAR2(10);

  BEGIN

    pkErrors.Push('pkGenerateInvoice.GenerateBillNote');

    -- determina signo
    if nuSigno = 'DB' then
      sbToken := pkBillConst.csbTOKEN_NOTA_DEBITO;
    else
      sbToken := pkBillConst.csbTOKEN_NOTA_CREDITO;
    end if;

    FA_BOBillingNotes.SetUpdateDataBaseFlag;
    pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
    pkBillingNoteMgr.CreateBillingNote(nuServsusc,
                                       nuCuenta, -- CC Nro
                                       nunotacons, -- 70
                                       UT_Date.fdtSysdate,
                                       sbObserv,
                                       sbToken,
                                       nunotanume -- salida
                                       );

    --  Se Aplica la nota
    FA_BOBillingNotes.DetailRegister(nunotanume, -- tbBillNote(to_char(rcAccount.cucofact)),
                                     nuServsusc,
                                     nuSuscripcion,
                                     nuCuenta, -- rcAccount.cucocodi,
                                     nuConcepto,
                                     nuCausal,
                                     nuValor,
                                     null, --valor base
                                     sbToken || nunotanume, --documento soporte
                                     nuSigno, --signo
                                     pkConstante.SI, --ajusta cuenta
                                     null, --documento nota
                                     pkconstante.SI, --saldo a favor
                                     FALSE); --registra en aprobacion

    -- Se asigna numero de nota a variable de paquete
    nuNota := nunotanume;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
  END GenerateBillingNote;

  --****************************************************************************************

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del cualquier tipo de
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

  FUNCTION ProcSoliAct(inuproduc in pr_product.subscription_id%type)
    RETURN NUMBER is

    inuEstapack number;
    onucant     number;

  BEGIN
    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.ProcSoliAct', 10);

    inuEstapack := LD_BOConstans.cnuStapack;
    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(*)
      INTO onucant
      FROM mo_packages P, mo_motive M
     WHERE P.package_id = M.package_id
       AND m.subscription_id = inuproduc
       AND p.motive_status_id = inuEstapack --
       AND p.package_type_id = 100335 /*inuMotype*/
    ;
    RETURN onucant;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.ProcSoliAct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSoliAct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCinsertdetCargtram
  Descripcion    : Objeto para la insercci?n de los registros en la tabla de Cargtram
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 26/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  26/07/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE PROCinsertdetCargtram(INUCATRCUCO IN cargtram.catrcuco%type,
                                  INUCATRNUSE IN cargtram.catrnuse %type,
                                  INUCATRCONC IN cargtram.catrconc %type,
                                  INUCATRCACA IN cargtram.catrcaca %type,
                                  ISBCATRSIGN IN cargtram.catrsign %type,
                                  INUCATRPEFA IN cargtram.catrpefa %type,
                                  INUCATRVALO IN cargtram.catrvalo %type,
                                  ISBCATRDOSO IN cargtram.catrdoso %type,
                                  INUCATRCODO IN cargtram.catrcodo %type,
                                  INUCATRUSUA IN cargtram.catrusua %type,
                                  ISBCATRTIPR IN cargtram.catrtipr %type,
                                  INUCATRUNID IN cargtram.catrunid %type,
                                  IDTCATRFECR IN cargtram.catrfecr %type,
                                  INUCATRVARE IN cargtram.catrvare %type,
                                  INUCATRCOLL IN cargtram.catrcoll %type,
                                  INUCATRUNRE IN cargtram.catrunre %type,
                                  INUCATRMOTI IN cargtram.catrmoti %type,
                                  INUCATRVBLR IN cargtram.catrvblr %type,
                                  INUCATRVABL IN cargtram.catrvabl %type) IS

    nuseq     number;
    NUPROGRAM NUMBER;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCinsertdetCargtram', 10);

    select SQCARGTRAM.nextval into nuseq from dual;
    NUPROGRAM := DALD_PARAMETER.fnuGetNumeric_Value('COD_PROG_CARGTRAM_SOL_RECLAMOS');

    /*INSERT A LA TABLA DE CARGTRAM*/
    insert into cargtram
      (CATRCONS,
       CATRCUCO,
       CATRNUSE,
       CATRCONC,
       CATRCACA,
       CATRSIGN,
       CATRPEFA,
       CATRVALO,
       CATRDOSO,
       CATRCODO,
       CATRUSUA,
       CATRTIPR,
       CATRUNID,
       CATRFECR,
       CATRPROG,
       CATRVARE,
       CATRCOLL,
       CATRUNRE,
       CATRMOTI,
       CATRVBLR,
       CATRVABL)
    values
      (nuseq,
       INUCATRCUCO,
       INUCATRNUSE,
       INUCATRCONC,
       INUCATRCACA,
       ISBCATRSIGN,
       INUCATRPEFA,
       INUCATRVALO,
       ISBCATRDOSO,
       INUCATRCODO,
       INUCATRUSUA,
       ISBCATRTIPR,
       INUCATRUNID,
       IDTCATRFECR,
       NUPROGRAM,
       INUCATRVARE,
       INUCATRCOLL,
       INUCATRUNRE,
       INUCATRMOTI,
       INUCATRVBLR,
       INUCATRVABL);

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCinsertdetCargtram', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCinsertdetCargtram;

  --------------------------------------------------------------------------------------------------------------

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCREGPERIGRACIAREC
  Descripcion    : Objeto para registro del periodo de gracia en la solicitud de reclamos
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  25/02/2019  Rcolpas  C200-1648   Se modifica producto en mo_motive para que este quede en null
                                   ya que la solictud es anivel de contrato, el tipo de producto
                                   se coloca generico
                                   Se omite validacion de periodo de gracia en los diferidos
  ******************************************************************/

  PROCEDURE PROCREGPERIGRACIAREC(inuPackage in mo_packages.package_id%type) IS

    rcMoPackage damo_packages.styMO_packages;
    nuMotive    number;

    nuGracePeriod  ld_parameter.numeric_value%type;
    nutiemperigrac ld_parameter.numeric_value%type;
    nutiemperigra  float;
    vdate          date;

    nudifepldi  diferido.difepldi%type;
    nucumaxpldi plandife.pldicuma%type;
    nucuminpldi plandife.pldicumi%type;
    sbcuent     varchar2(2);
    nudife      number;
    nuUser      number;
    nuperson    number;
    nuvalcuco   number := 0;

    cursor culdreclamos is
      select * from ldc_reclamos l where l.package_id = inuPackage;

    CURSOR Cucargos(nuproduct in pr_product.product_id%type,
                    nucuco    in cargos.cargcuco%type,
                    nuconcep  in cargos.cargconc%type,
                    sbsign    in cargos.cargsign%type,
                    sbcadoso  in cargos.cargdoso%type,
                    nucarcodi in cargos.cargcodo%type,
                    nuvalcarg in cargos.cargvalo%type,
                    nucargcau in cargos.cargcaca%type) is
      select c.*
        from cargos c
       where cargnuse = nuproduct --709808
         and cargcuco = nucuco
         and cargconc = nuconcep
         and cargsign = sbsign
         and cargdoso = sbcadoso
         and cargcodo = nucarcodi
         and cargvalo = nuvalcarg
         and cargcaca = nucargcau; --40888037

    ---CASO 275_5
    --Cambio por solicitud del funcional Liliana Cabarcas e Ismael Uribe
    Cursor cuvalorreclamo is
      select l.cucocodi
        from ldc_reclamos l
       where l.package_id = inuPackage
       group by l.cucocodi; 
    
    rgreclvalorReclamo cuvalorreclamo%rowtype;   
    -------------------------------------------------------------------------
         

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCGENOTSREC  ', 10);

    damo_packages.getRecord(inupackage, rcMopackage);

    nuMotive := mo_bopackages.fnuGetInitialMotive(inupackage);

    select GE_BOPersonal.fnuGetPersonId into nuperson from dual;

    nuUser := dage_person.fnugetuser_id(nuperson);

    /* ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_ValMess,
    nuUser);*/

    /*Caso 200-1648 Realizamos update a product_id y product_type_id en mo_motive*/
    update mo_motive
       set product_id      = null,
           product_type_id = dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN')
     where package_id = inuPackage;

    for rgrecl in culdreclamos loop

      for rgcarg in Cucargos(rgrecl.reproduct,
                             rgrecl.cucocodi,
                             rgrecl.reconcep,
                             rgrecl.resbsig,
                             rgrecl.redocsop,
                             rgrecl.recodosop,
                             rgrecl.valorcargo,
                             rgrecl.recaucar) loop

        /*Inicio insert en la tabla cargtram*/
        PROCinsertdetCargtram(rgrecl.cucocodi, --INUCATRCUCO IN cargtram.catrcuco%type,
                              rgrecl.reproduct, --INUCATRNUSE IN cargtram.catrnuse %type,
                              rgcarg.cargconc, --  INUCATRCONC IN cargtram.catrconc %type,
                              rgcarg.cargcaca, --  INUCATRCACA IN cargtram.catrcaca %type,
                              rgcarg.cargsign, --ISBCATRSIGN IN cargtram.catrsign %type,
                              rgcarg.cargpefa, -- INUCATRPEFA IN cargtram.catrpefa %type,
                              rgcarg.cargvalo, --INUCATRVALO IN cargtram.catrvalo %type,
                              rgcarg.cargdoso, --ISBCATRDOSO IN cargtram.catrdoso %type,
                              rgcarg.cargcodo, --INUCATRCODO IN cargtram.catrcodo %type,
                              nuUser, --INUCATRUSUA IN cargtram.catrusua %type,
                              rgcarg.cargtipr, --ISBCATRTIPR IN cargtram.catrtipr %type,
                              rgcarg.cargunid, -- INUCATRUNID IN cargtram.catrunid %type,
                              rgcarg.cargfecr, -- IDTCATRFECR IN cargtram.catrfecr %type,
                              rgrecl.revaloreca, --INUCATRVARE IN cargtram.catrvare %type,
                              rgcarg.CARgCOLL, --INUCATRCOLL IN cargtram.catrcoll %type,
                              0, --rgcarg.--  INUCATRUNRE IN cargtram.catrunre %type,
                              nuMotive, -- INUCATRMOTI IN cargtram.catrmoti %type,
                              null, --  INUCATRVBLR IN cargtram.catrvblr %type,
                              rgrecl.revaloreca); -- INUCATRVABL IN cargtram.catrvabl %type);

        /*FIN insert en la tabla cargtram*/

        /*INICIO proceso del periodo de gracia para los diferidos registrados en la tabla de reclamos*/
        nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_RECLAMOS')); --to_number(dage_parameter.fsbgetvalue('PERI_GRACIA_RECL_DIF'));

        if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>
           LD_BOConstans.cnuCero)) then
          sbcuent := substr(rgcarg.cargdoso, 1, 2);

          if sbcuent = 'DF' then

            nudife := substr(rgcarg.cargdoso, 4, length(rgcarg.cargdoso));

            /*--C200-1648 Se omite para que no valide tiempo de periodo de gracia
            nudifepldi := pktbldiferido.fnuGetDifepldi(nudife);

            \*Valores m?ximos y minimos del plan de diferidos*\
            nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
            nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);*/
            /*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*/
            nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);

            /*--C200-1648 Se omite para que no valide tiempo de periodo de gracia
            nutiemperigra  := nutiemperigrac / 30;

            \*Condicional para que el tiempo de gracia se encuentre dentro del plan de diferidos*\
            if nucumaxpldi >= nutiemperigra and
               nutiemperigra >= nucuminpldi then*/

            /*Fecha de incio de la vigencia*/
            vdate := sysdate + nutiemperigrac - 1;

            /*Se congela el diferido, esto est? en comentario por lo del diferido*/
            /*  CC_BOGrace_Peri_Defe.RegGracePeriodByProd(rgrecl.reproduct,
            nuGracePeriod,
            sysdate,
            vdate);*/

            LDC_PKCRMTRAMISEGBRI.PROCREGISPERIGRACXDIFE(nudife,
                                                        nuGracePeriod,
                                                        sysdate,
                                                        vdate);

            pktbldiferido.upddifeenre(nudife, 'Y');

            /*--C200-1648 Se omite para que no valide tiempo de periodo de gracia
            else
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_ValMess,
                                               'El n?mero de d?as se encuentra fuera del rango del plan diferido');
            end if;*/

            -- else

            /*
            \*Se actualiza el valor en reclamo*\
            update cuencobr c
               set c.cucovare = nuvalcuco
             where c.cucocodi = rgrecl.cucocodi;*/

          end if;
        end if;
      end loop;

      /*nuvalcuco := LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC(rgrecl.cucocodi,
                                                          inuPackage);

      \*Se actualiza el valor en reclamo*\
      update cuencobr c
         set c.cucovare = nvl(c.cucovare,0) + nuvalcuco
       where c.cucocodi = rgrecl.cucocodi;*/

    end loop;

    --CASO 275_5
    for rgreclvalorReclamo in cuvalorreclamo loop
      nuvalcuco := LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC(rgreclvalorReclamo.cucocodi,
                                                          inuPackage);

      /*Se actualiza el valor en reclamo*/
      update cuencobr c
         set c.cucovare = nvl(c.cucovare,0) + nuvalcuco
       where c.cucocodi = rgreclvalorReclamo.cucocodi;      
    end loop;
    ------------------------------------------------------------------

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCREGPERIGRACIAREC  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCREGPERIGRACIAREC;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENOTSREC
  Descripcion    : Objeto para la generacion de la ordenes de solicitud de reclamos, dependiendo de la
                   causal registrada en la solicitud de reclamos
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE PROCGENOTSREC(inuPackage in mo_packages.package_id%type) IS

    nuOrderId         number;
    nuOrderActivityId number;
    nuOrdervis        number;
    rcMoPackage       damo_packages.styMO_packages;
    nuMotive          number;
    product_id        number;
    suscription_id    suscripc.susccodi%type;
    nucausal_id       number;
    nupacktype        number(15);
    nuprodtypeid      number(4);
    nuUnitOper        number;
    rcOrder           daor_order.styor_order;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCGENOTSREC  ', 10);

    /*Se obtienmeel record de la solicitud*/
    damo_packages.getRecord(inupackage, rcMopackage);
    /*id. del motivo de la solicitud*/
    nuMotive := mo_bopackages.fnuGetInitialMotive(inupackage);
    /*tipo de paquete */
    nupacktype := damo_packages.fnugetpackage_type_id(inupackage);
    /*codigo del producto*/
    product_id := mo_bomotive.fnugetproductid(nuMotive);
    /*tipo de producto del producto*/
    nuprodtypeid := dapr_product.fnugetproduct_type_id(product_id);
    /*Contrato del motivo*/
    suscription_id := mo_bomotive.fnugetsubscription(nuMotive);
    /*Se obtiene la causal con la que se registr? en la solicitud*/
    nucausal_id := damo_motive.fnugetcausal_id(nuMotive);
    /*Unidad operativa del area que gestiona*/
    nuUnitOper := damo_packages.fnugetmanagement_area_id(inupackage);

    /* Se crea la orden de visita tecnica */
    nuOrderId         := null;
    nuOrderActivityId := null;

    PS_BOPackage_Activities.getactivitybyformdata(nucausal_id,
                                                  nupacktype,
                                                  nuprodtypeid,
                                                  nuOrdervis);

    if nuOrdervis is not null then

      or_boorderactivities.CreateActivity(nuOrdervis,
                                          inuPackage,
                                          nuMotive,
                                          null,
                                          null,
                                          rcMoPackage.Address_id,
                                          null,
                                          null,
                                          suscription_id,
                                          product_id,
                                          null,
                                          null,
                                          null,
                                          null,
                                          'Orden de Solicitud de Reclamos',
                                          null,
                                          null,
                                          nuOrderId,
                                          nuOrderActivityId,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null);

      /*Se asigna la orden a la unidad operativa asociada al tipo de poliza*/
      rcOrder := Daor_Order.Frcgetrecord(nuOrderId);

      OR_boProcessOrder.updBasicData(rcOrder,
                                     rcOrder.operating_sector_id,
                                     null);

      or_boprocessorder.assign(rcOrder, nuUnitOper, sysdate, false, TRUE);

      if nuUnitOper is null then

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'La unidad operativa [' ||
                                         nuUnitOper ||
                                         '] no permite asignar la orden [' ||
                                         nuOrderId || '].');

      end if;

    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'NO existe actividad para la causal ingresada en la solicitud' ||
                                       nucausal_id);
    end if;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCGENOTSREC  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCGENOTSREC;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCDISMICARTSOLIREC
  Descripcion    : Objeto para DISMINUCI?N DE LA CARTERA DE RECLAMOS  en la solicitud de reclamos
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE PROCDISMICARTSOLIREC IS

    rcMoPackage damo_packages.styMO_packages;
    --onuerrorcode    number;
    --osberrormessage varchar2(2000);

    NUdias number;
    --cnuFLOW_ACTION constant number := 8285;
    numedias   number;
    NUESTAREG  number;
    NuestaAten number;

    Cursor cumopackage(nuestado in number) is
      select m.cust_care_reques_num, m.package_id
        from ldc_reclamos l, mo_packages m
       where l.package_id = m.package_id
         and m.motive_status_id = nuestado
      /*  and m.package_id =15664667*/
      ;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCDISMICARTSOLIREC  ',
                   10);

    NUdias := DALD_PARAMETER.fnuGetNumeric_Value('NUMERO_DIASH_ESPERA');
    --NUESTAREG  := DALD_PARAMETER.fnuGetNumeric_Value('FNB_ESTADOSOL_REG');
    NuestaAten := DALD_PARAMETER.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO');

    for rgmopack in cumopackage(NuestaAten) loop

      damo_packages.getRecord(rgmopack.cust_care_reques_num, rcMopackage);

      if rcMopackage.motive_status_id = NuestaAten /*14*/
       then

        numedias := ROUND(OPEN.pkHolidayMgr.Fnugetnumofdaynonholiday((NVL(rcMopackage.attention_date,
                                                                          SYSDATE)),
                                                                     SYSDATE));
        -- numedias := sysdate - rcMopackage.attention_date;

        if numedias >= NUdias then

          LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC(rgmopack.package_id);

          update ldc_reclamos
             set reestado = 'FE'
           where package_id = rgmopack.package_id;

          /* LD_BOFlowFNBPack.procValidateFlowMove(cnuFLOW_ACTION,
          rgmopack.package_id,
          onuerrorcode,
          osberrormessage);*/
        end if;

      end if;
    end loop;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCDISMICARTSOLIREC  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCDISMICARTSOLIREC;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCFINAPERIGRACIAREC
  Descripcion    : Objeto para LA FINALIZACION del periodo de gracia en la solicitud de reclamos
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  19/07/2017  KBaquero C200-506    Creacion
  22/02/2019  RColpas  C200-1648  Se omite validacion de periodo de gracia en los diferidos
  ******************************************************************/

  PROCEDURE PROCFINAPERIGRACIAREC(inuPackage in mo_packages.package_id%type) IS

    rcMoPackage    damo_packages.styMO_packages;
    nuGracePeriod  ld_parameter.numeric_value%type;
    nutiemperigrac ld_parameter.numeric_value%type;
    nutiemperigra  float;
    --vdate          date;
    vinidate date;

    nudifepldi  diferido.difepldi%type;
    nucumaxpldi plandife.pldicuma%type;
    nucuminpldi plandife.pldicumi%type;
    sbcuent     varchar2(2);
    nudife      number;
    nuperigrac  number;

    cursor culdreclamos is
      select * from ldc_reclamos l where l.package_id = inuPackage;

    CURSOR Cucargos(nuproduct in pr_product.product_id%type,
                    nucuco    in cargos.cargcuco%type,
                    nuconcep  in cargos.cargconc%type,
                    sbsign    in cargos.cargsign%type) is
      select c.*
        from cargos c
       where cargnuse = nuproduct --709808
         and cargcuco = nucuco
         and cargconc = nuconcep
         and cargsign = sbsign; --4088803

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC  ',
                   10);

    damo_packages.getRecord(inupackage, rcMopackage);

    for rgfinrec in culdreclamos loop

      for rgcarg in Cucargos(rgfinrec.reproduct,
                             rgfinrec.cucocodi,
                             rgfinrec.reconcep,
                             rgfinrec.resbsig) loop

        /*INICIO proceso del periodo de gracia para los diferidos registrados en la tabla de reclamos*/
        --nuGracePeriod := to_number(dage_parameter.fsbgetvalue('PERI_GRACIA_RECL_DIF'));
        nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_RECLAMOS'));

        if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>
           LD_BOConstans.cnuCero)) then

          sbcuent := substr(rgcarg.cargdoso, 1, 2);

          if sbcuent = 'DF' then

            nudife := to_number(substr(rgcarg.cargdoso,
                                       4,
                                       length(rgcarg.cargdoso)));

            nudifepldi := pktbldiferido.fnuGetDifepldi(nudife);

            /*--C200-1648 Se omite validacion de periodo de gracia en los diferidos
            \*Valores m?ximos y minimos del plan de diferidos*\
            nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
            nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);

            \*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*\
            nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);
            nutiemperigra  := nutiemperigrac / 30;

            \*Condicional para que el tiempo de gracia se encuentre dentro del plan de diferidos*\
            if nucumaxpldi >= nutiemperigra and
               nutiemperigra >= nucuminpldi then*/

            /*Se obtiene le consecutivo de periodo de gracia*/
            nuperigrac := LDC_PKVALORESRECURSOSREPO.Fnuconsperigracdif(nudife);

            /*Fecha de incio de la vigencia*/
            vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac);
            -- vdate    := dacc_grace_peri_defe.fdtgetend_date(nuperigrac);

            /*Se cancela el periodo de gracia del diferido */
            /*   CC_BOGRACE_PERI_DEFE.CANCELGRACEPERIODBYPRO(rgfinrec.reproduct,
            nuGracePeriod,
            vinidate,
            sysdate+1
            vdate);*/

            LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(nudife,
                                                        nuperigrac,
                                                        nuGracePeriod,
                                                        vinidate);

            pktbldiferido.upddifeenre(nudife, 'N');

            /*
            else
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_ValMess,
                                               'El n?mero de d?as se encuentra fuera del rango del plan diferido');
            end if;*/

          else

            /*Se actualiza el valor en reclamo*/
            update cuencobr c
               set c.cucovare = LD_BOConstans.cnuCero
             where c.cucocodi = rgfinrec.cucocodi;

          end if;
        end if;

      end loop;

    end loop;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCFINAPERIGRACIAREC;

  FUNCTION FNUGETSOLVALREC(inPackage ldc_reclamos.package_id_recu%TYPE)
    RETURN NUMBER IS
    /**************************************************************************************
    Funcion     : FNUGETSOLVALREC
    Descripcion : Funcion que retorna una solicitud.
                  En caso de error mandara (-1)

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    sbPackage NUMBER := null; -- Variable de Retorno
  BEGIN
    ut_trace.trace('FNUGETSOLVALREC: Inicia funcion', 1);
    BEGIN
      ut_trace.trace('FNUGETSOLVALREC: Consulta Solicitud', 1);
      SELECT DISTINCT PACKAGE_ID
        INTO sbPackage
        FROM ldc_reclamos
       WHERE PACKAGE_ID_RECU = inPackage;
      ut_trace.trace('FNUGETSOLVALREC: Solicutd obtenida [' || sbPackage || ']',
                     1);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ut_trace.trace('FNUGETSOLVALREC: No se obtuvieron datos', 1);
        sbPackage := -1;
        ut_trace.trace('FNUGETSOLVALREC: sbPackage [' || sbPackage || ']',
                       1);
    END;
    ut_trace.trace('FNUGETSOLVALREC: Se retorna variable', 1);
    RETURN sbPackage;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 1;
  END FNUGETSOLVALREC;

  FUNCTION FNUGETVALABOCC(inCcobro cuencobr.cucocodi%TYPE) RETURN NUMBER IS
    /**************************************************************************************
    Funcion     : FNUGETVALABOCC
    Descripcion : Retorna el valor de un abono segun cuenta de cobro.
                  En caso de error mandara (-1)

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    sbVabono NUMBER := null; -- Variable de Retorno
  BEGIN
    ut_trace.trace('FNUGETVALABOCC: Inicia funcion', 1);
    BEGIN
      ut_trace.trace('FNUGETVALABOCC: Consulta Solicitud', 1);
      SELECT CUCOVAAB
        INTO sbVabono
        FROM cuencobr
       WHERE CUCOCODI = inCcobro;
      ut_trace.trace('FNUGETVALABOCC: Valor Abono [' || sbVabono || ']', 1);
      IF (sbVabono is null) THEN
        sbVabono := 0;
      END IF;
      ut_trace.trace('FNUGETVALABOCC: Valor Abono [' || sbVabono || ']', 1);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ut_trace.trace('FNUGETVALABOCC: No se obtuvieron datos', 1);
        sbVabono := -1;
        ut_trace.trace('FNUGETVALABOCC: sbVabono [' || sbVabono || ']', 1);
    END;
    ut_trace.trace('FNUGETVALABOCC: Se retorna variable', 1);
    RETURN sbVabono;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 1;
  END FNUGETVALABOCC;

  FUNCTION FNUGETVALTOTRECCC(inCcobro   cuencobr.cucocodi%TYPE,
                             inuPackage in mo_packages.package_id%type)
    RETURN NUMBER IS
    /**************************************************************************************
    Funcion     : FNUGETVALABOCC
    Descripcion : Retorna el valor total del reclamo de una cuenta de cobro.
                  En caso de error mandara (0)

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    26-02-2019          RColpas            C200-1648 Se modifica servicio para que ademas de consultar
                                           por cuenta de cobre los valores reclamado se consulte por la solicitud.

    ***************************************************************************************/
    sbVabono NUMBER := null; -- Variable de Retorno
  BEGIN
    ut_trace.trace('FNUGETVALTOTRECCC: Inicia funcion', 1);
    BEGIN
      ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC: Consulta cuenta de cobro',
                     1);
      SELECT sum((l.revaloreca * decode(l.resbsig,
                                        'CR',
                                        -1,
                                        'AS',
                                        -1,
                                        'PA',
                                        -1,
                                        'NS',
                                        -1,
                                        'ST',
                                        -1,
                                        1))) --SUM(l.revaloreca)
        INTO sbVabono
        FROM ldc_reclamos l
       WHERE package_id = inuPackage --Mod.25.02.2019
         and CUCOCODI = inCcobro
         and l.reestado = 'EP';
      ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC: Valor total del reclamo x cuenta de cobro [' ||
                     sbVabono || ']',
                     1);
      IF (sbVabono is null) THEN
        sbVabono := 0;
      END IF;
      ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC: Valor Abono [' ||
                     sbVabono || ']',
                     1);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC: No se obtuvieron datos',
                       1);
        sbVabono := 0;
        ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC: sbVabono [' ||
                       sbVabono || ']',
                       1);
    END;
    ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETVALTOTRECCC: Se retorna variable',
                   1);
    RETURN sbVabono;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 1;
  END FNUGETVALTOTRECCC;

  FUNCTION FNUGETCUCOSACU(inCcobro cuencobr.cucocodi%TYPE) RETURN NUMBER IS
    /**************************************************************************************
    Funcion     : FNUGETCUCOSACU
    Descripcion : Retorna el saldo de la CC.
                  En caso de error mandara (-1)

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    sbSaldocc NUMBER := null; -- Variable de Retorno
  BEGIN
    ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETCUCOSACU: Inicia funcion',
                   1);
    BEGIN
      ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETCUCOSACU: Consulta cuenta de cobro',
                     1);
      SELECT CUCOSACU
        INTO sbSaldocc
        FROM cuencobr
       WHERE CUCOCODI = inCcobro;
      ut_trace.trace('LDC_PKVALORESRECLAMOFNUGETCUCOSACU: Saldo Cc [' ||
                     sbSaldocc || ']',
                     1);
      IF (sbSaldocc is null) THEN
        sbSaldocc := 0;
      END IF;
      ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETCUCOSACU: Saldo Cc [' ||
                     sbSaldocc || ']',
                     1);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETCUCOSACU: No se obtuvieron datos',
                       1);
        sbSaldocc := 0;
        ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETCUCOSACU: sbSaldocc [' ||
                       sbSaldocc || ']',
                       1);
    END;
    ut_trace.trace('LDC_PKVALORESRECLAMO.FNUGETCUCOSACU: Se retorna variable',
                   1);
    RETURN sbSaldocc;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 1;
  END FNUGETCUCOSACU;

  FUNCTION FNVEXCLUYECONCEPTO(inConcepto CONCEPTO.CONCCODI%TYPE)
    RETURN VARCHAR2 IS
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : LDC_FNVEXCLUYECONCEPTO
    Descripcion : Funcion que retorna:
                  S: Tener en cuenta el concepto
                  N: No Tener en cuenta el concepto
    Autor       : Sebastian Tapias
    Fecha       : 22-09-2017

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    nuReturn  VARCHAR2(1) := null;
    nuExiConc NUMBER := 0;
    nuExists  NUMBER := 0;
    CURSOR cuExisConc(inConco CONCEPTO.CONCCODI%TYPE) IS
      SELECT COUNT(1) FROM CONCEPTO C WHERE C.CONCCODI = inConco;
    CURSOR cuConcepto(inConco CONCEPTO.CONCCODI%TYPE) IS
      SELECT COUNT(1)
        FROM CONCEPTO C
       WHERE C.CONCCODI = inConco
         AND C.CONCCODI IN
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CPTO_EXL_RECLAMO',
                                                                                         NULL),
                                                        ',')));
  BEGIN
    BEGIN
      OPEN cuExisConc(inConcepto);
      FETCH cuExisConc
        INTO nuExiConc;
      CLOSE cuExisConc;
      IF (nuExiConc > 0) THEN
        OPEN cuConcepto(inConcepto);
        FETCH cuConcepto
          INTO nuExists;
        CLOSE cuConcepto;
        IF (nuExists > 0) THEN
          nuReturn := 'N';
        ELSE
          nuReturn := 'S';
        END IF;
      ELSE
        nuReturn := 'N';
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        nuReturn := 'N';
    END;
    RETURN nuReturn;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END FNVEXCLUYECONCEPTO;

  FUNCTION FNVCONCEPTOOBLIGATORIO(inConcepto CONCEPTO.CONCCODI%TYPE)
    RETURN VARCHAR2 IS
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : FNVCONCEPTOOBLIGATORIO
    Descripcion : Funcion que retorna:
                  S: Tener en cuenta el concepto
                  N: No Tener en cuenta el concepto
    Autor       : Sebastian Tapias
    Fecha       : 13-10-2017

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    nuReturn  VARCHAR2(1) := null;
    nuExiConc NUMBER := 0;
    nuExists  NUMBER := 0;
    CURSOR cuExisConc(inConco CONCEPTO.CONCCODI%TYPE) IS
      SELECT COUNT(1) FROM CONCEPTO C WHERE C.CONCCODI = inConco;
    CURSOR cuConcepto(inConco CONCEPTO.CONCCODI%TYPE) IS
      SELECT COUNT(1)
        FROM CONCEPTO C
       WHERE C.CONCCODI = inConco
         AND C.CONCCODI IN
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CPTO_OBLIG_RECLAMO',
                                                                                         NULL),
                                                        ',')));
  BEGIN
    BEGIN
      OPEN cuExisConc(inConcepto);
      FETCH cuExisConc
        INTO nuExiConc;
      CLOSE cuExisConc;
      IF (nuExiConc > 0) THEN
        OPEN cuConcepto(inConcepto);
        FETCH cuConcepto
          INTO nuExists;
        CLOSE cuConcepto;
        IF (nuExists > 0) THEN
          nuReturn := 'S';
        ELSE
          nuReturn := 'N';
        END IF;
      ELSE
        nuReturn := 'N';
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        nuReturn := 'N';
    END;
    RETURN nuReturn;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END FNVCONCEPTOOBLIGATORIO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCSOLANULREC
  Descripcion    : Objeto para la anulaci?n de la solicitud
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 19/07/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  25/11/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE PROCSOLANULREC(INUPACK         in mo_packages.package_id%type,
                           ONUERRORCODE    out number,
                           OSBERRORMESSAGE out varchar2) IS

    Cursor cumopackage is
      select l.solicitud_origen
        from LDC_ANULRECLAMOS l
       where l.anulreclamos_id = INUPACK;

    cursor cuorder(INUPACKg in mo_packages.package_id%type) is
      select oa.order_id
        from or_order_activity oa
       where oa.package_id = INUPACKg;

    nusoliorigen number;
    --NUESTAREG    number := DALD_PARAMETER.fnuGetNumeric_Value('FNB_ESTADOSOL_REG');
    rcMoPackage damo_packages.styMO_packages;
    nuPlanId    wf_instance.instance_id%Type;
    nuCausal    LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('CAUSAL_ANULA_SOLI_RECLAMOS',
                                                                                      NULL);
    --nuorderec    number;
    nuResult boolean;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCSOLANULREC  ', 10);

    open cumopackage;
    fetch cumopackage
      into nusoliorigen;
    if cumopackage%notfound then
      nusoliorigen := null;

    end if;
    close cumopackage;

    nuResult := damo_packages.fblExist(nusoliorigen);

    if (nuResult = true) then
      damo_packages.getRecord(nusoliorigen, rcMopackage);
      if ((rcMopackage.package_type_id in (100335, 100337, 100338))) then

        damo_packages.getRecord(nusoliorigen, rcMopackage);

        LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC(rcMopackage.package_id);

        begin
          -- se realiza la transicion de estados de la solicitud
          MO_BOANNULMENT.PACKAGEINTTRANSITION(rcMopackage.package_id,
                                              GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
          -- Se obtiene el plan de wf
          nuPlanId := wf_boinstance.fnugetplanid(rcMopackage.package_id, 17);
          -- anula el plan de wf
          mo_boannulment.annulwfplan(nuPlanId);
        exception
          when others then

            DAMO_PACKAGES.UPDMOTIVE_STATUS_ID(rcMopackage.package_id, 32);

            update open.mo_motive
               set motive_status_id = 5
             where package_id = rcMopackage.package_id;

        end;

        for rgot in cuorder(nusoliorigen) loop

          -- Anula la orden de suspension
          Or_BOAnullOrder.AnullOrderWithOutVal(rgot.order_id, sysdate);

          -- Actualiza la causal escogida
          daor_order.updCausal_Id(rgot.order_id, nuCausal);

        end loop;

      else
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'La solicitud ingresada no pertenece al proceso de reclamos');

      end if;
    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'La solicitud ingresada no existe');
    end if;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCSOLANULREC  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      onuErrorCode := -1;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCSOLANULREC;

  PROCEDURE Procinidatsolianulrela(inupack         in mo_packages.package_id%type,
                                   osbobs          out mo_packages.comment_%type,
                                   OCONTRACT       OUT MO_MOTIVE.SUBSCRIPTION_ID%type,
                                   onuErrorCode    out number,
                                   osbErrorMessage out varchar2) IS

    -- rcMoPackage     damo_packages.styMO_packages;
  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.PROCSOLANULREC  ', 10);

    --   damo_packages.getRecord(inupack, rcMopackage);

    osbobs := damo_packages.Fsbgetcomment_(inupack);

    SELECT O.SUBSCRIPTION_ID
      INTO OCONTRACT
      FROM mo_packages m, MO_MOTIVE O
     WHERE m.package_id = inupack
       AND M.PACKAGE_ID = O.PACKAGE_ID;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.PROCSOLANULREC  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end Procinidatsolianulrela;

  PROCEDURE ProActualizaReceptionType(inuPackage   in mo_packages.package_id%type,
                                      inuReception in mo_packages.reception_type_id%type) IS
  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.ProActualizaReceptionType  ',
                   10);

    UPDATE mo_packages m
       SET m.reception_type_id = inuReception
     WHERE m.package_id = inuPackage;
    COMMIT;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.ProActualizaReceptionType  ',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ROLLBACK;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    when others then
      ROLLBACK;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end ProActualizaReceptionType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCSOLANULREC
  Descripcion    : Objeto para extraer el numero de la interaccion dada
                   una solicitud

  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 10/07/2018

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  10/07/2018  KBaquero C200-1648    Creacion
  ******************************************************************/

  PROCEDURE Progetsolintera(inuPackage     in mo_packages.package_id%type,
                            inuinteraccion out mo_packages.package_id%type) IS
  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.Progetsolintera  ', 10);

    select m.cust_care_reques_num
      into inuinteraccion
      from mo_packages m
     where m.package_id = inuPackage;

    /*    UPDATE mo_packages m
       SET m.reception_type_id = inuReception
     WHERE m.package_id = inuPackage;
    COMMIT;*/

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.Progetsolintera  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ROLLBACK;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    when others then
      ROLLBACK;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end Progetsolintera;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCSOLANULREC
  Descripcion    : Actualiza la interaccion de una solicitud especifica
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          :  10/07/2018

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  25/11/2017  KBaquero C200-506    Creacion
  ******************************************************************/

  PROCEDURE ProActualizainteraccion(inuPackage in mo_packages.package_id%type,
                                    inuinterac in mo_packages.package_id%type) IS
  BEGIN

    ut_trace.Trace('INICIO LDC_PKVALORESRECLAMO.ProActualizainteraccion  ',
                   10);

    UPDATE mo_packages m
       SET m.cust_care_reques_num = inuinterac
     WHERE m.package_id = inuPackage;
    COMMIT;

    ut_trace.Trace('FIN LDC_PKVALORESRECLAMO.ProActualizainteraccion  ',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ROLLBACK;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    when others then
      ROLLBACK;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end ProActualizainteraccion;

  FUNCTION FNVEXCLUYECAUSAL(inConcepto CAUSCARG.CACACODI%TYPE)
    RETURN VARCHAR2 IS
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : FNVEXCLUYECAUSAL
    Descripcion : Funcion que retorna:
                  S: Tener en cuenta la causal
                  N: No Tener en cuenta la causal
    Autor       : Daniel Valiente
    Fecha       : 06-09-2018

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    nuReturn  VARCHAR2(1) := null;
    nuExiConc NUMBER := 0;
    nuExists  NUMBER := 0;
    CURSOR cuExisConc(inConco CAUSCARG.CACACODI%TYPE) IS
      SELECT COUNT(1) FROM CAUSCARG C WHERE C.CACACODI = inConco;
    CURSOR cuConcepto(inConco CAUSCARG.CACACODI%TYPE) IS
      SELECT COUNT(1)
        FROM CAUSCARG C
       WHERE C.CACACODI = inConco
         AND C.CACACODI IN
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUSAL_EXL_RECLAMO',
                                                                                         NULL),
                                                        ',')));
  BEGIN
    BEGIN
      OPEN cuExisConc(inConcepto);
      FETCH cuExisConc
        INTO nuExiConc;
      CLOSE cuExisConc;
      IF (nuExiConc > 0) THEN
        OPEN cuConcepto(inConcepto);
        FETCH cuConcepto
          INTO nuExists;
        CLOSE cuConcepto;
        IF (nuExists > 0) THEN
          nuReturn := 'N';
        ELSE
          nuReturn := 'S';
        END IF;
      ELSE
        nuReturn := 'N';
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        nuReturn := 'N';
    END;
    RETURN nuReturn;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END FNVEXCLUYECAUSAL;

  FUNCTION GetDatosSolictud(inucontrato  in servsusc.sesususc%type,
                            inuSuscriber in mo_packages.subscriber_id%type)
    return pkConstante.tyRefCursor is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : GetDatosSolictud
    Descripcion : Retorna en un curso las solictudes a las cuales se lepueden interponer recursos
                  de reposiscion de igual manera se excluten las solicitudes de
                  tipo (545, 50, 52, 100337) y aquellas solicitudes que ya se le hayan interpuesto recursos
    Autor       : Ronald Colpas
    Fecha       : 22-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    rfcursor pkConstante.tyRefCursor;

  BEGIN
    OPEN rfcursor FOR
      select distinct p.package_id      Solicitud,
                      t.package_type_id Tipo_tramite,
                      t.description     Desc_Tipo_Tramite,
                      p.request_date    Fecha_Registro
        from mo_packages p, mo_motive m, ps_package_type t
       where (m.subscription_id = inucontrato or
             p.subscriber_id = inuSuscriber)
         and m.package_id = p.package_id
         and p.package_type_id not in
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TRAMITE_EXL_RECURSOS',
                                                                                         NULL),
                                                        ',')))
         and p.motive_status_id = 14
         and p.package_type_id = t.package_type_id
            --excluir solictudes que se le hayan registrado recursos
         and not exists
       (select 1
                from ldc_reclamos l
               where l.package_id_recu = p.package_id)
       order by p.package_id desc;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosSolictud;

  FUNCTION GetDatosSolictudApela(inucontrato  in servsusc.sesususc%type,
                                 inuSuscriber in mo_packages.subscriber_id%type)
    return pkConstante.tyRefCursor is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : GetDatosSolictud
    Descripcion : Retorna en un curso las solictudes a las cuales se lepueden interponer recursos
                  de reposiscion en subsidio de apelacion de igual manera se excluten las solicitudes de
                  tipo (545, 50, 52, 100338) y aquellas solicitudes que ya se le hayan interpuesto recursos
    Autor       : Ronald Colpas
    Fecha       : 22-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    rfcursor pkConstante.tyRefCursor;

  BEGIN
    OPEN rfcursor FOR
      select distinct p.package_id      Solicitud,
                      t.package_type_id Tipo_tramite,
                      t.description     Desc_Tipo_Tramite,
                      p.request_date    Fecha_Registro
        from mo_packages p, mo_motive m, ps_package_type t
       where (m.subscription_id = inucontrato or
             p.subscriber_id = inuSuscriber)
         and m.package_id = p.package_id
         and p.package_type_id in
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('TRAMITE_EXL_RECURSOS',
                                                                                         NULL),
                                                        ',')))
         and p.motive_status_id = 14
         and p.package_type_id = t.package_type_id
            --excluir solictudes que se le hayan registrado recursos
         and not exists
       (select 1
                from ldc_reclamos l
               where l.package_id_recu = p.package_id)
       order by p.package_id desc;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetDatosSolictudApela;

  FUNCTION GetCargosNoValre(inuPackage in mo_packages.package_id%type)
    return pkConstante.tyRefCursor is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : GetCargosNoValre
    Descripcion : Retorna los cargos que no han sido reclamdos en la solictud seleccionada
    Autor       : Ronald Colpas
    Fecha       : 27-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    rfcursor pkConstante.tyRefCursor;

  BEGIN
    OPEN rfcursor FOR
      SELECT cucocodi,
             cargnuse,
             cargconc || ' - ' || concdesc concepto,
             cargsign signo,
             cargvalo vlr_facturado,
             cargcaca || ' - ' || ca.cacadesc Causal,
             cargdoso documento,
             cargcodo consecutivo,
             0 vlr_reclamado,
             factcodi factura,
             pefaano ano,
             pefames mes,
             cucosacu saldo,
             pf.pefafege fecha_generacion,
             cucovato vlr_total,
             cargunid unidades
        from cargos,
             concepto,
             cuencobr cc,
             perifact pf,
             factura  f,
             CAUSCARG CA
       where cargcuco in (select distinct cucocodi
                            from ldc_reclamos
                           where package_id = inuPackage)
         and factpefa = pefacodi
         and cucofact = factcodi
         and cargcuco = cucocodi
         and cargconc = conccodi
         and ca.cacacodi = cargcaca
         and not exists (select l.cucocodi
                from ldc_reclamos l
               where l.package_id = inuPackage
                 and l.cucocodi = cc.cucocodi
                 and l.reconcep = cargconc
                 and l.resbsig = cargsign
                 and l.redocsop = cargdoso
                 and l.recodosop = cargcodo
                 and l.valorcargo = cargvalo
                 and l.recaucar = cargcaca)
       order by pefafege desc;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetCargosNoValre;

  FUNCTION GetAnswer(inuPackage_type in mo_packages.package_type_id%type)
    return pkConstante.tyRefCursor is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : GetCargosNoValre
    Descripcion : Retorna las respuestas que son inmediatas para el tramite
    Autor       : Ronald Colpas
    Fecha       : 27-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    rfcursor pkConstante.tyRefCursor;

  BEGIN
    OPEN rfcursor FOR
      select A.ANSWER_ID, A.DESCRIPTION
        from CC_ANSWER A
       where A.REQUEST_TYPE_ID = inuPackage_type
         and A.IS_IMMEDIATE_ATTENT = 'Y'
       order by A.ANSWER_ID;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetAnswer;

  procedure proDelreclamos(inuPackage_id in mo_packages.package_id%type) is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : proDelreclamos
    Descripcion : Procedimiento usado cuando la respuesta es inmediata para que elimine lo
                  registrado en LDC_RECLAMOS
    Autor       : Ronald Colpas
    Fecha       : 28-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/

  begin
    delete from ldc_reclamos where package_id = inuPackage_id;
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end proDelreclamos;

  procedure proUpdFile(inuPackage_id in mo_packages.package_id%type,
                       inuObject_id  in cc_file.object_id%type) is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : proUpdFile
    Descripcion : Procedimiento que actualiza en cc_file el identificador de la solictud
    Autor       : Ronald Colpas
    Fecha       : 28-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/

  begin

    update cc_file
       set object_id = inuPackage_id, object_level = 'REQUEST'
     where object_id = inuObject_id
       and object_level = 'RECLAMO';

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end proUpdFile;

  procedure proDelFile is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : proDelFile
    Descripcion : Procedimiento que elimina en cc_file el identificador de RECLAMO
    Autor       : Ronald Colpas
    Fecha       : 28-02-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/

  begin

    delete from cc_file
     where object_id = 999999999
       and object_level = 'RECLAMO';
    commit;
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end proDelFile;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : GetCursorReclamo
  Descripcion : Funcion para listar el Historial de los Reclamos
  Autor       : Daniel Valiente
  Fecha       : 30-04-2019

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  Function GetCursorReclamo(inuPackageId in mo_packages.package_id%type)
    return pkConstante.tyRefCursor is

    rfcursor pkConstante.tyRefCursor;

  begin

    OPEN rfcursor FOR
      select m.package_id      solicitud,
             l.reclamos_id     reclamo,
             l.factcodi,
             cucocodi,
             date_gencodi,
             reconcep,
             resbsig,
             renucausal,
             redocsop,
             recaucar,
             valorcargo,
             remes,
             reano,
             revaltotal,
             resalpen,
             revaloreca,
             l.subscription_id,
             recarguni
        from ldc_reclamos l, mo_packages m, ge_subscriber g
       where m.package_id = l.package_id
         and l.package_id in (inuPackageId)
         and g.subscriber_id = m.subscriber_id;

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end GetCursorReclamo;

  FUNCTION FNUGETVALCONCSUBS(inuConc concepto.conccodi%TYPE) RETURN NUMBER IS
    /**************************************************************************************
    Funcion     : FNUGETVALCONCSUBS
    Descripcion : Valida si el concepto esta configurado en la lista del
                  parametro CONCEPTOS_SUBSI_VALREC

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    nuOk NUMBER := null; -- Variable de Retorno
  BEGIN
    ut_trace.trace('FNUGETVALCONCSUBS: Inicia funcion', 1);
    ut_trace.trace('FNUGETVALCONCSUBS: Consulta Concepto', 1);
    SELECT COUNT(1)
      into nuOk
      FROM CONCEPTO C
     WHERE C.CONCCODI = inuConc
       AND C.CONCCODI IN
           (select nvl(to_number(column_value), 0)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTOS_SUBSI_VALREC',
                                                                                       NULL),
                                                      ',')));
    IF (nuOk is null or nuOk = 0) THEN
      nuOk := -1;
    ELSE
      nuOk := 1;
    END IF;
    ut_trace.trace('FNUGETVALCONCSUBS: Se retorna: ' || nuOk, 1);
    RETURN nuOk;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 1;
  END FNUGETVALCONCSUBS;

  FUNCTION GetReceptiontype return pkConstante.tyRefCursor is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : GetReceptiontyoe
    Descripcion : Retorna los medios de recpecion de acuerdo con la undidad operativa del funcional que esta conectado
    Autor       : Ronald Colpas
    Fecha       : 14-05-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/
    rfcursor pkConstante.tyRefCursor;

  BEGIN
    --Obtengo unidad operativa del funcional

    OPEN rfcursor FOR
      SELECT distinct r.RECEPTION_TYPE_ID id, r.description
        FROM ge_reception_type    r,
             or_ope_uni_rece_type o,
             or_operating_unit    u
       WHERE r.RECEPTION_TYPE_ID <>
             GE_BOPARAMETER.fnuGet('EXTERN_RECEPTION')
         and r.reception_type_id = o.reception_type_id
         and o.operating_unit_id = u.operating_unit_id
         and u.operating_unit_id in
             (SELECT organizat_area_id
                FROM cc_orga_area_seller
               WHERE person_id = GE_BOPersonal.fnuGetPersonId
                 AND IS_current = 'Y')
       order by r.RECEPTION_TYPE_ID;

    return rfcursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetReceptiontype;

  FUNCTION GetInteraccion(inuSusc in suscripc.susccodi%type) return number is
    /**************************************************************************************
    Propiedad Intelectual de SINCECOMP (C).

    Funcion     : GetReceptiontyoe
    Descripcion : Retorna el numero de interaccion para los valores en reclamos y recursos
                  si no se obtiene retorna -1
    Autor       : Ronald Colpas
    Fecha       : 14-05-2019

    Historia de Modificaciones

      Fecha               Autor                Modificacion
    =========           =========          ====================
    ***************************************************************************************/

    nuInter Number;
    nuClie  suscripc.suscclie%type;

  BEGIN
    --Obtengo unidad operativa del funcional
    ut_trace.trace('GetInteraccion: Inicia funcion', 1);

    ut_trace.trace('GetInteraccion: Obtiene codigo del cliente', 1);
    nuClie := pktblsuscripc.FNUGETSUSCCLIE(inuSusc);
    ut_trace.trace('GetInteraccion: Codigo del cliente: ' || nuClie, 1);

    ut_trace.trace('GetInteraccion: Obtiene numero de interaccion', 1);
    nuInter := cc_bopetitionmgr.fnugetpetitionid(inusubscriberid => nuClie);
    ut_trace.trace('GetInteraccion: Numero de interaccion: ' || nuInter, 1);

    if nuInter is null or nuInter in (-1, 0) then
      return - 1;
    end if;
    return nuInter;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
      RETURN - 1;
    When others then
      RETURN - 1;
  END GetInteraccion;

  --CASO 275
  /*****************************************************************
    Unidad         : GETRECLAMO
    Descripcion    : Retorna los reclamos realizados

    Autor          :
    Fecha          : 16/06/2020

    Parametros         Descripci?n
    ============   ===================

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================
  ******************************************************************/
  Function GETRECLAMO(nuContrato  SUSCRIPC.SUSCCODI%type,
                      nuSolicitud mo_packages.package_id%type)
    return pkConstante.tyRefCursor is

    rfcursor     pkConstante.tyRefCursor;
    nuIteracion  ge_boInstanceControl.stysbValue;
    nuSolicitud1 ge_boInstanceControl.stysbValue;
    nuSolicitud2 ge_boInstanceControl.stysbValue;
    nuSolicitud3 ge_boInstanceControl.stysbValue;
    nuValidate   number;

    cursor cuValfact(nuSusc servsusc.sesususc%type) is
      select count(1)
        from cargos
       where cargcuco = -1
         and cargnuse in
             (select sesunuse from servsusc where sesususc = nuSusc)
         and cargprog = 5;

    sbQueryFinal varchar2(3900);
    sbQuery      varchar2(3900);
    sbQuery1     varchar2(3900);
    sbContrato   varchar2(500);
    sbSolicitud  varchar2(500);

  begin

    ut_trace.trace('Inicio Ldc_PkValoresReclamo.GETRECLAMO', 10);

    --Valida que usuario no este en periodo de facturacion.
    open cuValfact(nuContrato);
    fetch cuValfact
      into nuValidate;
    close cuValfact;

    if nuValidate > 0 then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El contrato: ' || nuContrato ||
                      ', se encuentra en periodo de facturacion');
      raise ex.CONTROLLED_ERROR;
    end if;

    --if nuSolicitud is null then
    if nuContrato is null then
      sbQuery := 'select solicitud,
                 cuenta,
                 factura,
                 cargos,
                 contrato,
                 causal,
                 tipo_solicitud,
                 fecha_registro,
                 punto_atencion,
                 funcionario,
                 sum(valor_fact) valor_fact,
                 sum(decode(signo,
                            ''CR'',
                            -valor_reclamo,
                            ''AS'',
                            -valor_reclamo,
                            ''PA'',
                            -valor_reclamo,
                            ''NS'',
                            -valor_reclamo,
                            ''ST'',
                            -valor_reclamo,
                            valor_reclamo)) valor_reclamo,
                 reclamosid
            from (select reclamos_id,
                         ss.sesususc contrato,
                         p.package_id solicitud,
                         (select causal_id || ''-'' || description
                            from cc_causal
                           where causal_id =
                                 damo_motive.fnugetcausal_id(mo_bopackages.fnuGetInitialMotive(p.package_id))) causal,
                         (select pt.description
                            from ps_package_type pt
                           where pt.package_type_id = p.package_type_id) tipo_solicitud,
                         p.request_date fecha_registro,
                         (SELECT b.name_
                            FROM cc_orga_area_seller a, GE_ORGANIZAT_AREA b
                           WHERE a.person_id = p.person_id
                             AND IS_current = ''Y''
                             and a.organizat_area_id = b.organizat_area_id
                             AND rownum = 1) punto_atencion,
                         (select gp.name_
                            from open.ge_person GP
                           where gp.person_id = p.person_id) funcionario,
                         (select servdesc from servicio where servcodi = sesuserv) tipo_producto,
                         r.factcodi factura,
                         r.cucocodi cuenta,
                         r.reconcep concepto,
                         r.resbsig signo,
                         r.revaltotal valor_fact,
                         nvl((select (la.vroriginal - la.vraplicado) from  ldc_avr la where la.reclamosid = r.reclamos_id),r.revaloreca) valor_reclamo,
                         (select c.conccodi || '' - '' || c.concdesc from concepto c where c.conccodi = r.reconcep and rownum = 1) cargos,
                         r.reclamos_id reclamosid
                    from LDC_RECLAMOS R, SERVSUSC SS, MO_PACKAGES p
                   where r.package_id = p.package_id
                     and r.reproduct = ss.sesunuse
                     and r.reestado = ''EP''
                     and p.motive_status_id = 14';
    else
      sbQuery := 'select solicitud,
                 cuenta,
                 factura,
                 cargos,
                 contrato,
                 causal,
                 tipo_solicitud,
                 fecha_registro,
                 punto_atencion,
                 funcionario,
                 sum(valor_fact) valor_fact,
                 sum(decode(signo,
                            ''CR'',
                            -valor_reclamo,
                            ''AS'',
                            -valor_reclamo,
                            ''PA'',
                            -valor_reclamo,
                            ''NS'',
                            -valor_reclamo,
                            ''ST'',
                            -valor_reclamo,
                            valor_reclamo)) valor_reclamo,
                 reclamosid
            from (select reclamos_id,
                         ss.sesususc contrato,
                         p.package_id solicitud,
                         (select causal_id || ''-'' || description
                            from cc_causal
                           where causal_id =
                                 damo_motive.fnugetcausal_id(mo_bopackages.fnuGetInitialMotive(p.package_id))) causal,
                         (select pt.description
                            from ps_package_type pt
                           where pt.package_type_id = p.package_type_id) tipo_solicitud,
                         p.request_date fecha_registro,
                         (SELECT b.name_
                            FROM cc_orga_area_seller a, GE_ORGANIZAT_AREA b
                           WHERE a.person_id = p.person_id
                             AND IS_current = ''Y''
                             and a.organizat_area_id = b.organizat_area_id
                             AND rownum = 1) punto_atencion,
                         (select gp.name_
                            from open.ge_person GP
                           where gp.person_id = p.person_id) funcionario,
                         (select servdesc from servicio where servcodi = sesuserv) tipo_producto,
                         r.factcodi factura,
                         r.cucocodi cuenta,
                         r.reconcep concepto,
                         r.resbsig signo,
                         r.revaltotal valor_fact,
                         nvl((select (la.vroriginal - la.vraplicado) from  ldc_avr la where la.reclamosid = r.reclamos_id),r.revaloreca) valor_reclamo,
                         0 cargos,
                         0 reclamosid
                    from LDC_RECLAMOS R, SERVSUSC SS, MO_PACKAGES p
                   where r.package_id = p.package_id
                     and r.reproduct = ss.sesunuse
                     and r.reestado = ''EP''
                     and p.motive_status_id = 14';
    end if;

    if nuContrato is not null then
      sbContrato := ' and ss.sesususc = ' || nuContrato;
    end if;

    if nuSolicitud is not null then
      sbSolicitud := ' and r.package_id = ' || nuSolicitud;
    end if;

    --ut_trace.trace('nuContrato ['|| nuContrato ||']', 1);
    --ut_trace.trace('nuSolicitud ['|| nuSolicitud ||']', 1);

    --if nuSolicitud is null then
    if nuContrato is null then
      sbQuery1 := ') group by solicitud,
                              cuenta,
                              factura,
                              cargos,
                              contrato,
                              causal,
                              tipo_solicitud,
                              fecha_registro,
                              punto_atencion,
                              funcionario,
                              reclamosid';
    else
      sbQuery1 := ') group by solicitud,
                              cuenta,
                              factura,
                              cargos,
                              contrato,
                              causal,
                              tipo_solicitud,
                              fecha_registro,
                              punto_atencion,
                              funcionario,
                              reclamosid';
    end if;

    sbQueryFinal := sbQuery || CHR(10) || sbContrato || CHR(10) ||
                    sbSolicitud || CHR(10) || sbQuery1;

    ut_trace.trace('sbQueryFinal [' || sbQueryFinal || ']', 1);

    --Caso 200-1648
    OPEN rfcursor FOR sbQueryFinal;
    /*select solicitud,
          cuenta,
          factura,
          cargos,
          contrato,
          causal,
          tipo_solicitud,
          fecha_registro,
          punto_atencion,
          funcionario,
          --tipo_producto,
          sum(valor_fact) valor_fact,
          --DANVAL 30.04.19 Se modifico la consulta para aplicar negativos a los valores aplicados en la formas
          \*sum(decode(signo,
          'DB',
          -valor_reclamo,
          'SA',
          -valor_reclamo,
          'AP',
          -valor_reclamo,
          'TS',
          -valor_reclamo,
          valor_reclamo)) valor_reclamo*\
          sum(decode(signo,
                     'CR',
                     -valor_reclamo,
                     'AS',
                     -valor_reclamo,
                     'PA',
                     -valor_reclamo,
                     'NS',
                     -valor_reclamo,
                     'ST',
                     -valor_reclamo,
                     valor_reclamo)) valor_reclamo
     from (select reclamos_id,
                  ss.sesususc contrato,
                  p.package_id solicitud,
                  (select causal_id || '-' || description
                     from cc_causal
                    where causal_id =
                          damo_motive.fnugetcausal_id(mo_bopackages.fnuGetInitialMotive(p.package_id))) causal,
                  (select pt.description
                     from ps_package_type pt
                    where pt.package_type_id = p.package_type_id) tipo_solicitud,
                  p.request_date fecha_registro,
                  (SELECT b.name_
                     FROM cc_orga_area_seller a, GE_ORGANIZAT_AREA b
                    WHERE a.person_id = p.person_id
                      AND IS_current = 'Y'
                      and a.organizat_area_id = b.organizat_area_id
                      AND rownum = 1) punto_atencion,
                  (select gp.name_
                     from open.ge_person GP
                    where gp.person_id = p.person_id) funcionario,
                  (select servdesc from servicio where servcodi = sesuserv) tipo_producto,
                  r.factcodi factura,
                  r.cucocodi cuenta,
                  r.reconcep concepto,
                  r.resbsig signo,
                  r.revaltotal valor_fact,
                  r.revaloreca valor_reclamo,
                  r.reconcep cargos
             from LDC_RECLAMOS R, SERVSUSC SS, MO_PACKAGES p
            where r.package_id = p.package_id
              and r.reproduct = ss.sesunuse
                 \*and r.package_id = decode(NVL(nuSolicitud, -1),
                 -1,
                 r.package_id,
                 nuSolicitud)*\
              and ss.sesususc =
                  decode(NVL(nuContrato, -1), -1, ss.sesususc, nuContrato)
                 \*and p.cust_care_reques_num =
                 decode(NVL(nuIteracion, -1),
                        -1,
                        p.cust_care_reques_num,
                        nuIteracion)*\
              and r.reestado = 'EP'
              and p.motive_status_id = 14)
    group by solicitud,
             cuenta,
             factura,
             cargos,
             contrato,
             causal,
             tipo_solicitud,
             fecha_registro,
             punto_atencion,
             funcionario;*/
    --tipo_producto;
    ut_trace.trace('Fin Ldc_PkValoresReclamo.GETRECLAMO', 10);

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end GETRECLAMO;

  /*****************************************************************
    Unidad         : prApplyValorReclamo
    Descripcion    : Retorna los reclamos realizados

    Autor          :
    Fecha          : 16/06/2020

    Parametros         Descripci?n
    ============   ===================
    nuTipo         1 - Aplica valor por reclamo relacionado a un cargo por contrato
    nuTipo         2 - Aplica Todo el valor por reclamo relacionado a una solicitud

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================
  ******************************************************************/
  Procedure prApplyValorReclamo(InuTipo         number,
                                InuSolicitud    mo_packages.package_id%type,
                                IsbComentario   varchar2,
                                Inureclamosid   number,
                                Inuvalorreclamo number,
                                OnuErrorCode    out NUMBER,
                                OsbErrorMessage out VARCHAR2) is

    sbApliVlrRec ge_boInstanceControl.stysbValue;
    sbNoApliVRec ge_boInstanceControl.stysbValue;

    sbComentarioFinal OR_ORDER_COMMENT.ORDER_COMMENT%type;
    sbcommit          VARCHAR2(1) := 'N';

    nuSolicitud1 mo_packages.package_id%type;
    nuSolicitud2 ge_boInstanceControl.stysbValue;
    nuSolicitud3 ge_boInstanceControl.stysbValue;

    -- nuGracePeriod ld_parameter.numeric_value%type;
    --vdate         date;
    vinidate   date;
    nuperigrac number;
    nuDife     diferido.difecodi%type;

    sbenre   diferido.difeenre%type;
    nuconc   diferido.difeconc%type;
    nusaldo  diferido.difesape%type := 0;
    sbestrec varchar2(10);

    nuperson number;

    blabono     boolean := FALSE;
    blsavepoint boolean := FALSE;
    blprocesind boolean := FALSE;

    sbprograma varchar2(20) := 'NOTESREG';

    nuCausNCVr NUMBER;
    sbObseNCVr VARCHAR2(1000);

    cursor cuReclamo is
      select r.*
        from LDC_RECLAMOS r
       where r.package_id = nvl(InuSolicitud, 0)
         and r.reestado = 'EP';

    rg cuReclamo%rowtype;

    cursor cudife(nudiferido diferido.difecodi%type) is
      select difeconc, difeenre, difesape
        from diferido
       where difecodi = nudiferido;

    cursor cuReclamoCargo is
      select r.*
        from LDC_RECLAMOS r
       where r.reclamos_id = Inureclamosid
         and r.reestado = 'EP';

    rgCargos cuReclamoCargo%rowtype;

    cursor cuavrreclamoid is
      select LA.* from LDC_AVR LA where LA.RECLAMOSID = Inureclamosid;

    rgcuavrreclamoid cuavrreclamoid%rowtype;

    cursor cuavrsolicitud(reclamosid number) is
      select LA.* from LDC_AVR LA where LA.RECLAMOSID = reclamosid;

    rgcuavrsolicitud cuavrsolicitud%rowtype;

    nurevaloreca    number := 0;
    nurevalfaltante number := 0;

    nucantidad number := 0;

  begin

    ut_trace.trace('InuTipo: ' ||InuTipo, 10);
    ut_trace.trace('InuSolicitud: ' ||InuSolicitud, 10);
    ut_trace.trace('IsbComentario: ' ||IsbComentario, 10);
    ut_trace.trace('Inureclamosid: ' ||Inureclamosid, 10);
    ut_trace.trace('Inuvalorreclamo: '||Inuvalorreclamo, 10);

    --Apilca el valor del reclamo por cargo por contrato
    if InuTipo = 1 then

      ut_trace.trace('Antes de cuReclamoCargo', 10);
      for rgCargos in cuReclamoCargo loop
      ut_trace.trace('Despues de cuReclamoCargo', 10);

        nuSolicitud1 := rgCargos.Package_Id;

        ut_trace.trace('Antes de cuavrreclamoid', 10);
        open cuavrreclamoid;
        fetch cuavrreclamoid
          into rgcuavrreclamoid;
        if cuavrreclamoid%found then
          ut_trace.trace('1', 10);
          if rgcuavrreclamoid.reclamosid is null then
            ut_trace.trace('2', 10);
            insert into ldc_avr
              (solicitudreclamo,
               reclamosid,
               vroriginal,
               vraplicado,
               vrutlimo)
            values
              (rgCargos.package_id,
               rgCargos.reclamos_id,
               rgCargos.revaloreca,
               Inuvalorreclamo,
               Inuvalorreclamo);
          else
            ut_trace.trace('3', 10);
            update ldc_avr
               set vraplicado = vraplicado + Inuvalorreclamo,
                   vrutlimo   = Inuvalorreclamo
             where solicitudreclamo = rgCargos.package_id
               and reclamosid = Inureclamosid;
          end if;
        else
          ut_trace.trace('4', 10);
          insert into ldc_avr
            (solicitudreclamo,
             reclamosid,
             vroriginal,
             vraplicado,
             vrutlimo)
          values
            (rgCargos.package_id,
             rgCargos.reclamos_id,
             rgCargos.revaloreca,
             Inuvalorreclamo,
             Inuvalorreclamo);

          if substr(rgCargos.redocsop, 1, 3) = 'DF-' then
            nuDife := substr(rgCargos.redocsop, 4);
            open cudife(nudife);
            fetch cudife
              into nuconc, sbenre, nusaldo;
            if cudife%notfound then
              sbenre  := 'N';
              nusaldo := 0;
            end if;
            close cudife;
            -- SI ESTA EN PERIODO DE GRACIA LO SACA
            if sbenre in ('S', 'Y') then
              nuperigrac := Ldc_PkValoresReclamo.Fnuconsperigracdif(nudife);

              vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac);

              LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(nudife,
                                                          nuperigrac,
                                                          nuGracePeriod,
                                                          vinidate);
              pktbldiferido.upddifeenre(nudife, 'N');
              -- LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC(rg.package_id);
            end if;
          end if;

        end if;
        close cuavrreclamoid;
        ut_trace.trace('Despues de cuavrreclamoid', 10);

        update cuencobr
           set cucovare = cucovare + decode(rgCargos.resbsig,
                                            'DB',
                                            -Inuvalorreclamo,
                                            'SA',
                                            -Inuvalorreclamo,
                                            'AP',
                                            -Inuvalorreclamo,
                                            'TS',
                                            -Inuvalorreclamo,
                                            Inuvalorreclamo)
         where cucocodi = rgCargos.cucocodi;
         ut_trace.trace('Actualizar CUENCOBR', 10);

        sbcommit := 'S';

      end loop;

      --sbcommit := 'N';

      if sbcommit = 'S' then
        --
        commit;

        begin
          select nvl(ldc_avr.vroriginal, 0),
                 nvl(ldc_avr.solicitudreclamo, 0)
            into nucantidad, nuSolicitud1
            from ldc_avr
           where ldc_avr.vroriginal = ldc_avr.vraplicado
             and reclamosid = Inureclamosid;

          if nucantidad > 0 then

            update ldc_reclamos
               set reestado = 'FE'
             where package_id = nuSolicitud1
               and reclamos_id = Inureclamosid;

            --Caso 200-1648
            --Actualizacion Observacion en la solictud y la orden
            if IsbComentario is not null then

              sbComentarioFinal := 'Observacion(LDCAVR): ' || IsbComentario ||
                                   ' [Reclamo: ' || nuSolicitud1 || ']';
              --Actuakizamos comentario de la solicitud
              update mo_packages
                 set comment_ = comment_ || ' . ' || IsbComentario
               where package_id = nuSolicitud1;

              select GE_BOPersonal.fnuGetPersonId into nuperson from dual;
              --Insertamos comentario a la orden
              for rt in (select order_id
                           from or_order_activity
                          where package_id = nuSolicitud1) loop
                INSERT /*+ APPEND */
                INTO OR_ORDER_COMMENT
                  (ORDER_COMMENT_ID,
                   ORDER_COMMENT,
                   ORDER_ID,
                   COMMENT_TYPE_ID,
                   REGISTER_DATE,
                   LEGALIZE_COMMENT,
                   PERSON_ID)
                VALUES
                  (SEQ_OR_ORDER_COMMENT.NEXTVAL,
                   sbComentarioFinal,
                   rt.order_id,
                   1277,
                   sysdate,
                   'Y',
                   nuPerson);
              end loop;
            end if;

            commit;
          end if;

        exception
          when others then
            nucantidad := 0;
        end;

      else
        OnuErrorCode    := -1;
        OsbErrorMessage := 'No aplico valor reclamo [' || Inuvalorreclamo || ']';
        rollback;
      end if;

    end if;

    --Apilca todo el valor del reclamo por solicitud
    if InuTipo = 2 then

      for rg in cuReclamo loop

        BEGIN
          select nvl(LA.VRORIGINAL, 0),
                 nvl(LA.VRORIGINAL - la.vraplicado, 0)
            into nurevaloreca, nurevalfaltante
            from LDC_AVR LA
           where LA.RECLAMOSID = rg.reclamos_id;
        exception
          when others then
            nurevaloreca := 0;
        END;

        if nurevaloreca = 0 then
          insert into ldc_avr
            (solicitudreclamo,
             reclamosid,
             vroriginal,
             vraplicado,
             vrutlimo)
          values
            (rg.package_id,
             rg.reclamos_id,
             rg.revaloreca,
             rg.revaloreca,
             rg.revaloreca);

          if substr(rg.redocsop, 1, 3) = 'DF-' then
            nuDife := substr(rg.redocsop, 4);
            open cudife(nudife);
            fetch cudife
              into nuconc, sbenre, nusaldo;
            if cudife%notfound then
              sbenre  := 'N';
              nusaldo := 0;
            end if;
            close cudife;
            -- SI ESTA EN PERIODO DE GRACIA LO SACA
            if sbenre in ('S', 'Y') then
              nuperigrac := Ldc_PkValoresReclamo.Fnuconsperigracdif(nudife);

              vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac);

              LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(nudife,
                                                          nuperigrac,
                                                          nuGracePeriod,
                                                          vinidate);
              pktbldiferido.upddifeenre(nudife, 'N');
              -- LDC_PKVALORESRECLAMO.PROCFINAPERIGRACIAREC(rg.package_id);
            end if;
          end if;

          nurevaloreca := rg.revaloreca;

        else
          update ldc_avr
             set vraplicado = rg.revaloreca, vrutlimo = rg.revaloreca
           where solicitudreclamo = rg.package_id
             and reclamosid = rg.reclamos_id;

          nurevaloreca := nurevalfaltante;

        end if;

        update cuencobr
           set cucovare = cucovare + decode(rg.resbsig,
                                            'DB',
                                            -nurevaloreca,
                                            'SA',
                                            -nurevaloreca,
                                            'AP',
                                            -nurevaloreca,
                                            'TS',
                                            -nurevaloreca,
                                            nurevaloreca)
         where cucocodi = rg.cucocodi;

        sbcommit := 'S';

      end loop;

      if sbcommit = 'S' then

        update ldc_reclamos
           set reestado = 'FE'
         where package_id = InuSolicitud;

        --Caso 200-1648
        --Actualizacion Observacion en la solictud y la orden
        if IsbComentario is not null then

          sbComentarioFinal := 'Observacion(LDCAVR): ' || IsbComentario ||
                               ' [Reclamo: ' || InuSolicitud || ']';
          --Actuakizamos comentario de la solicitud
          update mo_packages
             set comment_ = comment_ || ' . ' || IsbComentario
           where package_id = InuSolicitud;

          select GE_BOPersonal.fnuGetPersonId into nuperson from dual;
          --Insertamos comentario a la orden
          for rt in (select order_id
                       from or_order_activity
                      where package_id = InuSolicitud) loop
            INSERT /*+ APPEND */
            INTO OR_ORDER_COMMENT
              (ORDER_COMMENT_ID,
               ORDER_COMMENT,
               ORDER_ID,
               COMMENT_TYPE_ID,
               REGISTER_DATE,
               LEGALIZE_COMMENT,
               PERSON_ID)
            VALUES
              (SEQ_OR_ORDER_COMMENT.NEXTVAL,
               sbComentarioFinal,
               rt.order_id,
               1277,
               sysdate,
               'Y',
               nuPerson);
          end loop;
        end if;

        commit;
      else
        OnuErrorCode    := -1;
        OsbErrorMessage := 'No aplico valor reclamo [' || Inuvalorreclamo || ']';
        rollback;
      end if;

    end if;

    ut_trace.trace('Fin Ldc_PkValoresReclamo.prApplyValorReclamo', 10);

    ---

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end prApplyValorReclamo;

--FIN CASO 275

end LDC_PKVALORESRECLAMO;
/
