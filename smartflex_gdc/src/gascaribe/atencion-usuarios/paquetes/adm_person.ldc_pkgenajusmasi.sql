CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKGENAJUSMASI AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ldc_pkGenAjusMasi
  Descripcion    : Paquete para el PB LDCANDM el cual procesa un archivo plano para generacion
                   masiva de Notas Debito.
                   El proceso lee el archivo plano y genera las notas, Cargos credito para matar
                   las nota, Cuentas de cobro, facturas y diferidos
  Autor          : F.Castro
  Fecha          : 02/04/2016 ERS 200-206

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor         Modificacion
  =========     =========     ====================
  26/12/2016    F.Castro      PC 200-588. Si el concepto tiene Iva se crea la nota y diferido
                              para el concepto de Iva. Ademas los errores se guardaran en una
                              tabla de Log para consultarse por Orm, y adicionalmente, se validara
                              el tope maximo para diferidos por perfil de usuario
										
  20/03/2024	JSOTO		  OSF-2387 Ajustes en todo el paquete para reemplazar algunos objetos de producto
							  por objetos personalizados para disminuir el impacto en la migracion a 8.0
								se reemplaza uso de	pktblservsusc.fnugetservice	por	pkg_bcproducto.fnutipoproducto
								se reemplaza uso de	fa_bobillingnotes.detailregister	por	api_registranotaydetalle
								se reemplaza uso de	ut_date.fdtsysdate	por	ldc_boconsgenerales.fdtgetsysdate
								se reemplaza uso de	pkbillingnotemgr.createbillingnote	por	api_registranotaydetalle
								se reemplaza uso de	ex.controlled_error	por	pkg_error.controlled_error
								se reemplaza uso de	pkutlfilemgr.get_line	por	pkg_gestionarchivos.fsbobtenerlinea_smf
								se reemplaza uso de	pkutlfilemgr.fopen	por	pkg_gestionarchivos.ftabrirarchivo_smf
								se reemplaza uso de	errors.geterror	por	pkg_error.geterror
								se reemplaza uso de	pktblservsusc.fnugetsuscription	por	pkg_bcproducto.fnucontrato
								se reemplaza uso de	ge_bopersonal.fnugetpersonid	por	pkg_bopersonal.fnugetpersonaid
								se reemplaza uso de	errors.seterror	por	pkg_error.seterror
								se reemplaza uso de	pkutlfilemgr.fclose	por	pkg_gestionarchivos.prccerrararchivo_smf
								se reemplaza uso de	utl_file.file_type	por	pkg_gestionarchivos.styarchivo
								se reemplaza uso de	ldc_boutilities.splitstrings	por	regexp_substr
								se reemplaza uso de	pr_bcproduct.fnugetaddressid	por	pkg_bcproducto.fnuiddireccinstalacion
								se reemplaza uso de	ut_trace.trace	por	pkg_traza.trace
								se reemplaza uso de	pkgeneralservices.fdtgetsystemdate	por	ldc_boconsgenerales.fdtgetsysdate
								se reemplaza uso de	sa_bouser.fnugetuserid	por	pkg_session.getuserid
								se reemplaza uso de	pkerrors.setapplication	por	pkg_error.setapplication
								se reemplaza uso de	pktblservsusc.fdtgetretiredate	por	pkg_bcproducto.fdtfecharetiro
								Se ajusta el manejo de errores y trazas de acuerdo a las pautas tecnicas de desarrollo
  25/06/2024    PAcosta         OSF-2878: Cambio de esquema ADM_PERSON 
                                Se borran las variable tbgDeferred      mo_tytbdeferred;
                                                       tbgCharges       mo_tytbCharges;
                                                       tbgQuotaSimulate mo_tytbQuotaSimulate;   
                                teniendo en cuenta que no se usan y estan generando errores en la compilación para la migración de esquema
                                PLS-00904: insufficient privilege to access object ADM_PERSON.MO_TYTBDEFERRED
                                PLS-00904: insufficient privilege to access object ADM_PERSON.MO_TYTBCHARGES
                                PLS-00904: insufficient privilege to access object ADM_PERSON.MO_TYTBQUOTASIMULATE                             
  ******************************************************************/

  ------------------
  -- Constantes
  ------------------
  csbYes             constant varchar2(1) := 'Y';
  csbNo              constant varchar2(1) := 'N';
  cnuValorTopeAjuste constant number := 1;
  -- Error en la configuracion normal de cuotas
  cnuERROR_CUOTA constant number(6) := 10381;

  -----------------------
  -- Variables
  -----------------------

  nuSuscripcion suscripc.susccodi%type; 
  nuServsusc    servsusc.sesunuse%type; 
  nuServicio    servsusc.sesuserv%type;
  nuConcepto    cargos.cargconc%type; 
  nuCausal      cargos.cargcaca%type; 
  nuValor       cargos.cargvalo%type; 
  nuPlanFina    diferido.difepldi%type; 
  nuCuentas     diferido.difenucu%type; 
  sbObserv      notas.notaobse%type; 
  nuCodFinanc diferido.difecofi%type;

  nuPrograma cargos.cargprog%type := 2014; -- programa de ajustes
  nunotacons notas.notacons%type := 70; -- tipo documento para ND
  nuDepa     cuencobr.cucodepa%type;
  nuLoca     cuencobr.cucoloca%type;

  -----------------------
  -- Elementos Packages
  -----------------------
  PROCEDURE ldcandm;

  PROCEDURE ReadTextFile;

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

  PROCEDURE GetExtraPayTotal(inuExtraPayNumber in number,
                             onuExtraPayValue  out number);

  PROCEDURE FillAditionalInstalments(inuValorDife  in diferido.difevatd%type,
                                     isbSigno      in diferido.difesign%type,
                                     ichIVA        in char,
                                     iblLastRecord in boolean);

  PROCEDURE GenerateDeferred(isbdifedoso diferido.difenudo%type);

  PROCEDURE CreateDeferred(inuFinanceCode    in diferido.difecofi%type,
                           inuSubscriptionId in diferido.difesusc%type,
                           inuConc           in concepto.conccodi%type,
                           inuValor          in diferido.difevatd%type,
                           inuNumCuotas      in diferido.difenucu%type,
                           isbDocumento      in diferido.difenudo%type,
                           isbPrograma       in diferido.difeprog%type,
                           inuPorIntNominal  in diferido.difeinte%type,
                           ichIVA            in varchar2 default csbNO,

                           inuPorcInteres        in diferido.difeinte%type default NULL,
                           inuTasaInte           in diferido.difepldi%type default NULL,
                           inuSpread             in diferido.difespre%type default NULL,
                           inuConcInteres        in diferido.difecoin%type default NULL,
                           isbFunciona           in funciona.funccodi%type default NULL,
                           isbSrcConceptInterest in varchar2 default csbNO,
                           iblLastRecord         in boolean default FALSE,
                           isbSimulate           in varchar2 default pkConstante.SI --  Simular? (S|N)
                           );

  procedure pro_grabalog_ldcandm;

END ldc_pkGenAjusMasi;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKGENAJUSMASI AS
 /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ldc_pkGenAjusMasi
  Descripcion    : Paquete para el PB LDCANDM el cual procesa un archivo plano para generacion
                   masiva de Notas Debito.
                   El proceso lee el archivo plano y genera las notas, Cargos credito para matar
                   las nota, Cuentas de cobro, facturas y diferidos
  Autor          : F.Castro
  Fecha          : 02/04/2016 ERS 200-206

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  26/12/2017    R.Colpas                PC 200-1625. Se modifica PROCESSSUBSSERVICES, para que los cargos que se generen
                                        se creen con el dato tipo proceso CARGOS.CARGTIPR = "P"
  26/12/2016    F.Castro                PC 200-588. Si el concepto tiene Iva se crea la nota y diferido
                                        para el concepto de Iva. Ademas los errores se guardaran en una
                                        tabla de Log para consultarse por Orm, y adicionalmente, se validara
                                        el tope maximo para diferidos por perfil de usuario
										

  ******************************************************************/

	csbSP_NAME  CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';

    ------------------
    -- Tipos de Datos
    ------------------

    -- Tabla de Estados de cuenta
    TYPE tytbCargfact IS TABLE OF cuencobr.cucofact%type INDEX BY binary_integer;
    tbCargfact	tytbCargfact;

    -- Tabla de cuentas de cobro
    TYPE tytbCargcuco IS TABLE OF cargos.cargcuco%type INDEX BY binary_integer;
    tbCargcuco	tytbCargcuco;

    -- Tabla de fechas contables
    TYPE tytbCargfeco IS TABLE OF pkbccargos.stycargfeco INDEX BY binary_integer;
    tbCargfeco	tytbCargfeco;

    -- Tabla de fechas de creaci?n del cargo
    TYPE tytbCargfecr IS TABLE OF pkbccargos.stycargfeco INDEX BY binary_integer;
    tbCargdate	tytbCargfecr;

    -- Tabla de documentos de soporte
    TYPE tytbCargdoso IS TABLE OF cargos.cargdoso%type INDEX BY binary_integer;
    tbCargdoso	tytbCargdoso;

    -- Tabla de documentos de soporte
    TYPE tytbCargtipr IS TABLE OF cargos.cargtipr%type INDEX BY binary_integer;
    tbCargtipr	tytbCargtipr;

    -- Tabla de rowids de los cargos
    TYPE tytbRowid IS TABLE OF rowid INDEX BY binary_integer;
    tbRowid	tytbRowid;

    --------------------------------
    -- Movimientos de Pagos       --
    --------------------------------
    TYPE tyrcCargos IS RECORD
    (
       sbRowid      rowid,
       cargconc     cargos.cargconc%type,
       cargcaca     cargos.cargcaca%type,
       cargsign     cargos.cargsign%type,
	     cargdoso     cargos.cargdoso%type,
       cargvalo     cargos.cargvalo%type,
       cargfecr     cargos.cargfecr%type,
       cargnuse     cargos.cargnuse%type,
       cargpeco     cargos.cargpeco%type
    );

    TYPE tytbCargos IS TABLE OF tyrcCargos INDEX BY BINARY_INTEGER;

    TYPE tyrcMaxPericosePorConcepto IS RECORD
    (
       rcPeriodoConsumo pericose%rowtype,
       dtFechaUltLiq    feullico.felifeul%type,
       sbTipoCobro      concepto.concticc%type
    );

    TYPE tytbMaxPericoseConcepto IS TABLE OF tyrcMaxPericosePorConcepto INDEX BY BINARY_INTEGER;

    ------------------
    -- Constantes
    ------------------
    -- Esta constante se debe modificar cada vez que se entregue el
    -- paquete con un SAO
    csbVersion          CONSTANT VARCHAR2(250) := 'OSF-2387';

    -- Nombre del programa ejecutor Generate Invoice
    csbPROGRAMA			constant varchar2(4) := 'ANDM';

    -- Maximo numero de registros Hash para Parametros o cadenas
    cnuHASH_MAX_RECORDS constant number := 100000 ;

    -- Constante de error de no Aplicaci?n para el API OS_generateInvoice
    cnuERRORNOAPLI number := 500;

    cnuNivelTrace constant number(2) := 5;
    -----------------------
    -- Variables
    -----------------------
    sbErrMsg		varchar2(2000);		-- Mensajes de Error

    grcEstadoCta factura%rowtype; -- Global de la factura generada

    -- Concepto de ajuste
    nuConcAjuste	concepto.conccodi%type;
    -- Concepto de pago
    nuConcPago		concepto.conccodi%type;
    -- Verifica si se genero la cuenta
    boCuentaGenerada	boolean;
    -- Verifica si se genero estado de cuenta
    boAccountStGenerado	boolean;
    -- Record del periodo de facturacion current
    rcPerifactCurr	perifact%rowtype;
    -- Record de la suscripcion current
    rcSuscCurr		suscripc%rowtype;
    -- Record del servicio suscrito current
    rcSeSuCurr		servsusc%rowtype;
    -- Numero del estado de cuenta current
    nuEstadoCuenta	factura.factcodi%type;
    -- Numero de la cuenta de cobro current
    nuCuenta		cuencobr.cucocodi%type;
    -- Numero del Diferido Creado
    nuDiferido   diferido.difecodi%type;
    -- Numero de la Nota Creada
    nuNota   notas.notanume%type;
    -- Fecha de generacion de las cuentas
    dtFechaGene		 date;
    -- Programa
    sbApplication    varchar2 (10);
    -- Fecha contable del periodo contable current
    dtFechaContable	 date;

    dtFechaCurrent	 date;
    sbTerminal		 factura.factterm%type ;

    -- Saldo pendiente de la factura
    nuSaldoFac	pkbcfactura.styfactspfa;

    -- Valores facturados cuenta por servicio
    nuVlrFactCta        cuencobr.cucovafa%type;
    nuVlrIvaFactCta     cuencobr.cucoimfa%type;

    -- Valores facturados de la factura
    nuVlrFactFac        pkbcfactura.styfactvafa;
    nuVlrIvaFactFac     pkbcfactura.styfactivfa;

    gnuCouponPayment pagos.pagocupo%type;    -- Cupon de Pago

    -- Variables de valores de cartera actualizados despues de realizar
    -- una actualizacion
    nuCart_ValorCta	    cuencobr.cucovato%type;	-- Valor cuenta
    nuCart_AbonoCta	    cuencobr.cucovaab%type;	-- Abonos cuenta
    nuCart_SaldoCta	    cuencobr.cucosacu%type;	-- Saldo cuenta

    -- Tipo de documento
    gnuTipoDocumento    ge_document_type.document_type_id%type;

     nugNumServ servsusc.sesunuse%type; -- Numero servicio
      dtgProceso     diferido.difefein%type; -- Fecha proceso
       nugPorcMora plandife.pldiprmo%type;

  nugTasaInte diferido.difetain%type; -- Codigo Tasa Interes
  cnuBadOverChargePercent constant number(6) := 120782;


  sbgUser     varchar2(50); -- Nombre usuario
  sbgTerminal varchar2(50); -- Terminal
  gnuPersonId ge_person.person_id%type; -- Id de la persona
  nuIdxDife number; -- Indice de tabla de diferidos

 
  tbgExtraPayments mo_tytbextrapayments;
  tbExtraPayment cc_bcfinancing.tytbExtraPayment;
  nugSubscription suscripc.susccodi%type;

  nugFinanCode diferido.difecofi%type;

  nugMetodo      diferido.difemeca%type; -- Metodo Cuota
  nugPlan        diferido.difepldi%type; -- Plan del Diferido
  nugFactor        diferido.difefagr%type; -- Factor Gradiente
  nugSpread      diferido.difespre%type; -- valor del Spread
  nugPorcInteres diferido.difeinte%type; -- Interes Efectivo
  nugPorIntNominal diferido.difeinte%type; -- Interes Nominal
  nugNumCuotaExt cuotextr.cuexnume%type; -- Numero de Cuota extras
  nuIdxExtr number; -- Indice de tabla Cuotras Extras
  nugVlrFinIva diferido.difevatd%type;

   -- Acumuladores de cuotas extras por numero de cuota
  type tytbAcumExtraPay IS table of number index BY binary_integer;
  tbgAcumExtraPay tytbAcumExtraPay;

  nugVlrFinTotal diferido.difevatd%type; -- Valor total financiacion aplicado el porcentaje a financiar
  nugTotCuotaExt cuotextr.cuexvalo%type; -- Total de Cuota extras
  nugAcumCuota   number; -- Acumulador Cuota
  sbTipoDiferido varchar2(1) := 'D'; -- OJO Crear parametro o utilizar
  nucauspasodif cargos.cargcaca%type := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('CODI_CAUS_PASO_DIFE');

  sbPath            varchar2(500);
  sbFile            varchar2(500);
  dtfechaproceso    date;
  sbContrato        varchar2(50) := null; --
  sbProducto        varchar2(50) := null; --
  sbServicio        varchar2(50) := null; --
  sbConcepto        varchar2(50) := null; --
  sbCausal          varchar2(50) := null; --
  sbPlanFi          varchar2(50) := null; --
  sbValor           varchar2(50) := null; --
  sbNucu            varchar2(50) := null; --
  sbObse            varchar2(50) := null; --
  nuLinea           number := 0;
  sbLineLog        varchar2(1000) :=null;
--********************************************************************************************

PROCEDURE ldcandm IS
   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ldcandm
  Descripcion    : Procedimiento llamado por el PB
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

  sbSISTDIRE ge_boInstanceControl.stysbValue;
  sbFileManagementr  PKG_GESTIONARCHIVOS.STYARCHIVO;
  
  csbMetodo VARCHAR2(100) := csbSP_NAME||'ldcandm';

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


  sbSISTDIRE := ge_boInstanceControl.fsbGetFieldValue('SISTEMA', 'SISTDIRE');



  if (sbSISTDIRE is null) then
    pkg_error.SetErrorMessage(pkg_error.CNUGENERIC_MESSAGE,
								'El Nombre de Achivo no debe ser nulo');
  end if;


  sbPath := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('RUTA_ARCH_ND_MASIVAS'); -- '/smartfiles/cartera';
  sbFile :=  sbSISTDIRE;

  -- valida que exista el archivo
  begin
    sbFileManagementr := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF(sbPath, sbFile, 'r');
  exception
    when others then
      PKG_GESTIONARCHIVOS.prcCerrarArchivo_SMF(sbFileManagementr);
      pkg_error.SetErrorMessage(pkg_error.CNUGENERIC_MESSAGE,
                    'Error ... Archivo no Existe o no se pudo abrir ');
  end;



  ReadTextFile;

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


END ldcandm;

--********************************************************************************************
PROCEDURE ReadTextFile IS

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ReadTextFile
  Descripcion    : Procedimiento que recorre el archivo plano y genera la nota y demas datos
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

        cnuZERO                constant number        := pkBillConst.CERO;
        cnuONE                 constant number        := LD_BOConstans.cnuonenumber;


    sbFileGl varchar2(100);
    sbExt    varchar2(10);
    sbOnline varchar2(5000);

    /* Variables para conexion*/

    sbFileManagement  PKG_GESTIONARCHIVOS.STYARCHIVO;

    nuCodigo          number;
    nuestcorte        servsusc.sesuesco%type;
    nunucumiplan        plandife.pldicumi%type;
    dtfecmaxplan      plandife.pldifefi%type;
    nunucumaplan       plandife.pldicuma%type;

    cnuend_of_file constant number := 1;

	nuerror       number;
	sbmessage     varchar2(2000);

   /*Variables de archivo de log*/

	sbLog            varchar2(500); -- Log de errores
	sbTimeProc       varchar2(500);

	sbTipArch         varchar2(50);
	onuSusc           varchar2(50);
	nuErrorCode      NUMBER;
	sbErrorMessage   VARCHAR2(4000);



        nuMonth          number;

        ------------

        sbLineFile        varchar2(1000);
        vnuexito        number := 0;
        vnunoexito      number := 0;
        sbAsunto        varchar2(2000);
        vsbmessage      varchar2(2000);
        vsbSendEmail    ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
        vsbrecEmail     ld_parameter.value_chain%TYPE; --Direccion de email que recibe



        nuContador  number:= 1;
        nuIndex     number;
      
        nuMontoMax  number := GE_BOFinancialProfile.fnuMaxAmountByUser(4,PKG_SESSION.GETUSERID);
		
		sbEstCorte varchar2(200) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('EST_CORTE_NO_VALI_DIFE');
		

       cursor cuContrato (inusesu pr_product.product_id%type) is
         select sesususc, sesuserv
           from servsusc
          where sesunuse=inusesu;

      cursor cuValEstCorte is
       select sesuesco
         from servsusc
       where sesunuse = nuServsusc
         and sesuesco in (
						   select distinct REGEXP_SUBSTR(sbEstCorte, '[^,]+', 1, level) AS PRODUCTO
							from dual
							connect by regexp_substr(sbEstCorte, '[^,]+', 1, level) is not null
						 );


     cursor cuValPlanFina is
      select nvl(pldicumi,-1), nvl(pldicuma,-1), pldifefi
        from plandife
       where pldicodi = nuPlanFina;


		csbMetodo VARCHAR2(100) := csbSP_NAME||'ReadTextFile';


    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


          dtfechaproceso := sysdate;


          begin
              sbFileManagement := PKG_GESTIONARCHIVOS.ftAbrirArchivo_SMF(sbPath, sbFile, 'r');
            exception
              when others then
                sbLineLog := '     Error ... No se pudo abrir archivo ' ||
                             sbPath || ' ' || sbFile || ' ' || chr(13) || sqlerrm;
                pro_grabalog_ldcandm;
                GOTO FinProceso;
            end;

            nuLinea := 0;

            -- ciclo de lectura de lineas del archivo
            loop
              sbLineLog := NULL;
              nuLinea := nuLinea + 1;

  				BEGIN
					
					sbOnline := PKG_GESTIONARCHIVOS.fsbObtenerLinea_SMF(sbFileManagement);
				
				EXCEPTION WHEN NO_DATA_FOUND THEN
					EXIT;
				END;

              -- Inicializa variables extraidas del archivo
              sbProducto  := null;
              sbContrato  := null;
              sbServicio  := null;
              sbConcepto  := null;
              sbCausal    := null;
              sbValor     := null;
              sbNucu      := null;
              sbPlanFi    := null;
              sbObse      := null;

              /* Obtiene Tipo de Archivo*/
              sbTipArch := substr(sbOnline,
                                   1,
                                   instr(sbOnline, '|', 1, 1) - 1);
              /* Obtiene Producto */
              sbProducto := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 1) + 1,
                                   (instr(sbOnline, '|', 1, 2)) -
                                   (instr(sbOnline, '|', 1, 1) + 1));

              /* Obtiene Concepto */
              sbConcepto := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 2) + 1,
                                   (instr(sbOnline, '|', 1, 3)) -
                                   (instr(sbOnline, '|', 1, 2) + 1));
              /* Obtiene Causal*/
              sbCausal := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 3) + 1,
                                   (instr(sbOnline, '|', 1, 4)) -
                                   (instr(sbOnline, '|', 1, 3) + 1));

              /* Obtiene Valor*/
               sbValor := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 4) + 1,
                                   (instr(sbOnline, '|', 1, 5)) -
                                   (instr(sbOnline, '|', 1, 4) + 1));


              /* Obtiene Numero de Cuotas */
              sbNucu := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 5) + 1,
                                 (instr(sbOnline, '|', 1, 6)) -
                                 (instr(sbOnline, '|', 1, 5) + 1));

               /* Obtiene Plan de Financiacion */
              sbPlanFi := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 6) + 1,
                                 (instr(sbOnline, '|', 1, 7)) -
                                 (instr(sbOnline, '|', 1, 6) + 1));


              /* Obtiene Observacion */
              sbObse := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 7) + 1,
                                 (instr(sbOnline, '|', 1, 8)) -
                                 (instr(sbOnline, '|', 1, 7) + 1));





      ----------------- validaciones  ----------------------

          if sbTipArch is null  or sbTipArch != 'NDMAF' then
             sbLineLog :=  'Linea no es del tipo NDMAF' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          if sbProducto is null  or not fboGetIsNumber(sbProducto) then
             sbLineLog := 'Producto Nulo o No Numerico' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;


           if sbConcepto is null  or not fboGetIsNumber(sbConcepto) then
             sbLineLog := 'Concepto Nulo o No Numerico' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          if sbCausal is null  or not fboGetIsNumber(sbCausal) then
             sbLineLog := 'Causal Nula o No Numerica' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          if sbValor is null  or not fboGetIsNumber(sbValor) then
             sbLineLog := 'Valor Nulo o No Numerico' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          if sbPlanFi is null  or not fboGetIsNumber(sbPlanFi) then
             sbLineLog := 'Plan de Financiacion Nulo o No Numerico' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          if sbNucu is null  or not fboGetIsNumber(sbNucu) then
             sbLineLog := 'Numero de Cuotas Nula o No Numerica' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          if trim(sbObse) is null then
             sbLineLog := 'Observacion Nula' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;



         -- asigna a las variables de paquete
	        nuServsusc      :=  To_number(sbProducto);
          nuConcepto      :=  To_number(sbConcepto);
          nuCausal        :=  To_number(sbCausal);
          nuValor         :=  To_number(sbValor);
          nuPlanFina      :=  To_number(sbPlanFi);
          nuCuentas       :=  To_number(sbNucu);
          sbObserv        :=  trim(sbObse);

          -- halla el contrato y tipo de servicio
         open cuContrato (nuServsusc);
         fetch cuContrato into nuSuscripcion, nuServicio;
         if cuContrato%notfound then
            nuSuscripcion := -2;
            nuServicio := -2;
         end if;
         close cuContrato;

          -- valida que el contrato, producto y tipo producto existan y que
          -- el producto pertenezca al contrato y el servicio corresponda al producto
          if ValContProdServ (nvl(nuSuscripcion,-2), nuServsusc, nvl(nuServicio,-2)) != 0 then
             sbLineLog := 'Contrato, Producto o Servicio No Existen o No Corresponden' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          -- valida que el concepto exista
          if ValConcepto (nuConcepto) != 0 then
             sbLineLog := 'Concepto no Existe' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          -- valida que la causal exista
          if ValCausal (nuCausal) != 0 then
             sbLineLog := 'Causal no Existe' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          -- valida que el valor sea mayor a cero
          if nuValor <= 0 then
             sbLineLog := 'Valor debe ser mayor a cero' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          -- valida que el Plan de Financiacion exista
          if ValPlanFina (nuPlanFina) != 0 then
             sbLineLog := 'Plan de Financiacion no Existe' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          -- valida que el numero de cuotas sea mayor a cero
          if nuCuentas <= 0 then
             sbLineLog := 'Numero de Cuotas debe ser mayor a cero' || chr(13);
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          -- valida que el estado de corte del producto sea valido para generar diferidos
           open cuValEstCorte;
           fetch cuValEstCorte into nuestcorte;
           if cuValEstCorte%found then
              sbLineLog := 'Estado de Corte ' || nuestcorte || ' del Producto no valido para crear diferidos' || chr(13);
              pro_grabalog_ldcandm;
             close cuValEstCorte;
             GOTO nextLine;
           else
             close cuValEstCorte;
           end if;


           -- valida que el plan de financiacion este vigente y que el numero de cuotas
           -- no exceda el maximo para el plan
           open cuValPlanFina;
           fetch cuValPlanFina into nunucumiplan, nunucumaplan, dtfecmaxplan;
           if cuValPlanFina%notfound then
             nunucumaplan := -1;
             nunucumiplan := -1;
           end if;
           close cuValPlanFina;

           if dtfecmaxplan < sysdate then
             sbLineLog := 'Plan de FInanciacion no esta vigente' || chr(13);
              pro_grabalog_ldcandm;
             GOTO nextLine;
           end if;

           if nuCuentas > nunucumaplan or nuCuentas < nunucumiplan then
             sbLineLog := 'Numero de Cuotas ' || nuCuentas ||
                          ' no esta en el rango configurado para el Plan (' ||
                          nunucumiplan || '-' || nunucumaplan  || chr(13);
              pro_grabalog_ldcandm;
             GOTO nextLine;
           end if;


          if nuValor > nuMontoMax then
             sbLineLog := 'Monto Maximo del perfil del Usuario ' || user || ' es ' || nuMontoMax;
             pro_grabalog_ldcandm;
             GOTO nextLine;
          end if;

          Generate (nuErrorCode,sbErrorMessage);

          if nuErrorCode != 0 then
             sbLineLog := nuErrorCode || ' - ' || sbErrorMessage;
             pro_grabalog_ldcandm;
             rollback;
          else
             commit;
          end if;


          <<nextLine>>
          null;
        end loop;
        <<FinProceso>>
        PKG_GESTIONARCHIVOS.prcCerrarArchivo_SMF(sbFileManagement);
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
    when pkg_error.controlled_error then
		rollback;
		pkg_error.getError(nuError, sbmessage);
		pkg_traza.trace(csbMetodo||' '||sbmessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		raise pkg_error.controlled_error;
    when others then
		rollback;
		pkg_error.setError;
		pkg_error.getError(nuError, sbmessage);
		pkg_traza.trace(csbMetodo||' '||sbmessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		raise pkg_error.controlled_error;
END ReadTextFile;

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
(
	onuErrorCode       out	number,
	osbErrorMessage    out	varchar2
)
IS

 nures number;
 sbError varchar2(2000);
 onuSaldoFac  cargos.cargvalo%type;
 
 csbMetodo VARCHAR2(100) := csbSP_NAME||'Generate';


    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */

    /*
        Procedure	:	ClearMemory
    	Descripcion	:	Limpia memoria cache
                        Clear Memory
    */

    PROCEDURE ClearMemory IS
	
		csbMetodo1 VARCHAR2(100) := csbMetodo||'.ClearMemory';


    BEGIN

		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

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

		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    END ClearMemory;

    /* -------------------------------------------------------------- */

    /*
        Procedure	:	Initialize
        Descripcion	:	Inicializa variables del package
                        Initialize
    */

    PROCEDURE Initialize IS
	
	csbMetodo1 VARCHAR2(100) := csbMetodo||'.Initialize';


    BEGIN

		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        -- Fija la Aplicacion en una variable global del paquete
    	sbApplication := csbPROGRAMA;
    	pkg_error.setapplication (sbApplication);

    	-- Fecha de Generacion de la Cuenta
    	dtFechaGene := sysdate ;

    	dtFechaCurrent := sysdate ;
    	sbTerminal := pkGeneralServices.fsbGetTerminal ;

        -- Asigna el Cupon de Pago
      -----  gnuCouponPayment := inuCouponPayment;

    	-- Fecha Contable
    	dtFechaContable := LDC_BOCONSGENERALES.FDTGETSYSDATE ;

    	-- Clase de Documento que entra como parametro
    	gnuTipoDocumento := 70; -- tipo de documento de Notas Debito

        -- Inicializa C?digos de Documentos
        nuEstadoCuenta := NULL;
        nuCuenta := NULL;

        -- Inicializa Saldo Pendiente de la Factura
        nuSaldoFac := NULL;

        -- Valores Facturados en la Cuenta de Cobro
    	nuVlrFactCta     := 0 ;
    	nuVlrIvaFactCta  := 0 ;

    	-- Valores facturados en el Estado de Cuenta
    	nuVlrFactFac     := 0 ;
    	nuVlrIvaFactFac  := 0 ;

    	-- Inicializa tabla de memoria de parametros
    	pkBillFuncParameters.InitMemTable ;

    	-- Habilita manejo de cache para parametros
    	pkGrlParamExtendedMgr.SetCacheOn ;

        -- Inicializa parametros de salida
    	 nuSaldoFac := NULL;

        -- Por defecto no se ha generado Estado de Cuenta ni Cuenta de Cobro

        boAccountStGenerado := FALSE;
        boCuentaGenerada := FALSE;

    	-- Inicializa variables de Error
    	pkErrors.GetErrorVar
    	    (
    		onuErrorCode,
    		osbErrorMessage,
    		pkConstante.INITIALIZE
    	    );

        -- Obtiene el record de la suscripcion
	    rcSuscCurr := pktblSuscripc.frcGetRecord (nuSuscripcion);

    	-- Obtiene record de periodo de facturacion current
    	rcPeriFactCurr := pkBillingPeriodMgr.frcGetAccCurrentPeriod
			    (
				rcSuscCurr.susccicl
			    );

		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    END Initialize;

    /* ***************************************************************** */

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

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
    onuSaldoFac  := nuSaldoFac;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    when pkg_error.controlled_error then
        rollback to savepoint svGenerate;
		pkg_error.getError(onuErrorCode, osbErrorMessage);
		pkg_traza.trace(csbMetodo||' '||osbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE pkg_error.controlled_error;
    when others then
        rollback to savepoint svGenerate;
		pkg_error.setError;
		pkg_error.getError(onuErrorCode, osbErrorMessage);
		pkg_traza.trace(csbMetodo||' '||osbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
END Generate;

--********************************************************************************************


PROCEDURE GenProcess

IS

   csbMetodo VARCHAR2(100) := csbSP_NAME||'GenProcess';
   nuError NUMBER;
   sbError VARCHAR2(4000);

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Inicializa las tablas de memoria en el actualiza cartera,
    -- destruye el cache
    pkUpdAccoReceiv.ClearMemTables;

    -- Por defecto, no se ha generado estado de cuenta
    boAccountStGenerado := FALSE;

    -- Elimina tabla de hash para que sea borrada por cada suscripcion
    pkExtendedHash.SetInitVar (TRUE);

    -- Procesa los servicios suscritos
    ProcessSubsServices;

    -- Aqui se realiza la numeracion fiscal
	if ( boAccountStGenerado ) then
        AsignaNumeracionFiscal;
    END if;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
EXCEPTION
	WHEN pkg_error.controlled_error THEN
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE pkg_error.controlled_error;

    when others then
		pkg_error.setError;
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;

END GenProcess;


--*****************************************************************************************
/*Modificacion Caso 200-1775
18/04/2018 - Daniel Valiente - Se aplica la nota a los cargos CR cuya causal sea 50
*/
PROCEDURE ProcessSubsServices is


nuConcIva concepto.conccodi%type;
nuPorcIva ta_rangvitc.ravtporc%type;
nuError NUMBER;
sbError VARCHAR2(4000);


-- cursor para validar si al concepto se le debe cobrar Iva
cursor cuIva is
 SELECT b.cotcconc, ravtporc --into nuCodTarifa
   FROM ta_tariconc a, ta_conftaco b , ta_vigetaco d, ta_rangvitc e
  WHERE b.cotcconc in (select coblconc
                         from concbali
                        where coblcoba = nuconcepto)
    AND a.tacocotc = b.cotccons
    and d.vitccons = e.ravtvitc
    AND d.vitctaco = a.tacocons
    and sysdate between vitcfein and vitcfefi
    and rownum = 1
    and cotcserv = 7014;

causal_genmas varchar(255) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('CAUSAL_GEMAS'); --Caso 200-1775

csbMetodo VARCHAR2(100) := csbSP_NAME||'ProcessSubsServices';


BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Busca informacion del servicio suscrito
    rcSeSuCurr := pktblServsusc.frcGetRecord (nuServsusc) ;

    nuDepa := nvl( pkBCSubscription.fnuGetContractState( rcSuscCurr.susccodi ), pkConstante.NULLNUM );
    nuLoca := nvl( pkBCSubscription.fnuGetContractTown( rcSuscCurr.susccodi ), pkConstante.NULLNUM );

    -- inicializa el codigo de la financiacion
    nuCodFinanc := 0;

  	-- Genera Estado de cuenta y Cuenta
        	if ( not (boAccountStGenerado)) then
        	    GenerateAccountStatus;
        	end if;

        	-- Genera cuenta si no se ha generado antes
        	if ( not (boCuentaGenerada)) then
        	   GenerateAccount;
        	end if;

   -- Agrega cargo CR
    	AddCharge
	    (nuConcepto,
       'CR', -- sbSignCanc,
        '-', -- docsoporte  DF-1234567
    		nucauspasodif, -- Causal para el Cargo CR;
        nuValor,
        0, -- CARGCODO ;
        PKBILLCONST.POST_FACTURACION --CA 200-1625 --pkBillConst.AUTOMATICO  -- TIPOPROC
        );

       -- Se crea la Nota DB
        GenerateBillingNote;

    -- Procesa los cargos del servicio suscrito
    ProcessCharges; 

    -- Verifica si se genero nueva cuenta

    if (boCuentaGenerada) then
    --{
    	-- Actualiza cartera
    	UpdateAccoRec ;

    	-- Procesa la cuenta generada
    	ProcessGeneratedAcco ;
    --}
    end if;

    -- Genera Diferido
    GenerateDeferred('ND-' || nuNota);

    -- Actualiza el cargdoso del cargo credito con el numero del diferido
    update cargos
       set cargdoso = 'FD-' || nuDiferido
     where cargcuco=nuCuenta
       and cargconc=nuconcepto
       and cargsign='CR';

    -- Caso 200-1775
    -- Se valida las cuasales a las cuales se le aplicara la nota
    if causal_genmas is not null then
      update cargos
       set cargcodo = nuNota
     where cargcuco=nuCuenta
       and cargconc=nuconcepto
       and cargsign='CR'
       and cargcaca in (
					   select distinct REGEXP_SUBSTR(causal_genmas, '[^,]+', 1, level) AS PRODUCTO
						from dual
						connect by regexp_substr(causal_genmas, '[^,]+', 1, level) is not null
						);
    end if;


  ----------------------------------------------------------------------------
  -- si el concepto genera Iva se crea el cargo nota y diferido para el Iva
  open cuIva;
  fetch cuIva into nuConcIva, nuPorcIva;
  if cuIva%notfound then
    nuConcIva := 0;
    nuPorcIva := 0;
  end if;
  close cuIva;

  if nvl(nuPorcIva,0) != 0 then
    nuConcepto := nuConcIva;
    nuValor := round(nuValor * nuPorcIva/100);
    -- Agrega cargo CR
     	AddCharge
	    (nuConcepto,
       'CR', -- sbSignCanc,
        '-', -- docsoporte  DF-1234567
    		nucauspasodif, -- Causal para el Cargo CR;
        nuValor,
        0, -- CARGCODO ;
        PKBILLCONST.POST_FACTURACION --CA 200-1625 -- pkBillConst.AUTOMATICO  -- TIPOPROC
        );

       -- Se crea la Nota DB
        GenerateBillingNote;

    -- Procesa los cargos del servicio suscrito
    ProcessCharges; 

    -- Verifica si se genero nueva cuenta

    if (boCuentaGenerada) then
    --{
    	-- Actualiza cartera
    	UpdateAccoRec ;

    	-- Procesa la cuenta generada
    	ProcessGeneratedAcco ;
    --}
    end if;

    -- Genera Diferido
    GenerateDeferred('ND-' || nuNota);

    -- Actualiza el cargdoso del cargo credito con el numero del diferido
    update cargos
       set cargdoso = 'FD-' || nuDiferido
     where cargcuco=nuCuenta
       and cargconc=nuconcepto
       and cargsign='CR';

    -- Caso 200-1775
    -- Se valida las cuasales a las cuales se le aplicara la nota
    if causal_genmas is not null then
      update cargos
       set cargcodo = nuNota
     where cargcuco=nuCuenta
       and cargconc=nuconcepto
       and cargsign='CR'
       and cargcaca in (
   					   select distinct REGEXP_SUBSTR(causal_genmas, '[^,]+', 1, level) AS PRODUCTO
						from dual
						connect by regexp_substr(causal_genmas, '[^,]+', 1, level) is not null
						);
    end if;

     --CA 200-1625 Actualiza el cargdoso del cargo debito con el IMPUESTO
     update cargos
        set cargdoso = 'IMPUESTO'
      where cargcuco = nuCuenta
        and cargconc = nuconcepto
        and cargsign = 'DB';

   end if;
 ----------------------------------------------------------------------------------------
 
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;

		when others then
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;

END ProcessSubsServices;

--********************************************************************************************


PROCEDURE AddCharge

	(  inuConcepto	in	cargos.cargconc%type,
       isbSigno	  in	cargos.cargsign%type,
       isbDocSop  in  cargos.cargdoso%type,
	   inuCausal	in	cargos.cargcaca%type,
       inuVlrCargo in cargos.cargvalo%type,
       inuConsDocu in  cargos.cargcodo%type,
       isbTipoProc	in	cargos.cargtipr%type
  )


	IS
	
		csbMetodo VARCHAR2(100) := csbSP_NAME||'AddCharge';
				
		nuError NUMBER;
		sbError VARCHAR2(4000);

	
    BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	-- Adiciona el Cargo
	GenerateCharge
	    (
       inuConcepto,
	   isbSigno,
       isbDocSop,
       inuCausal,
       inuVlrCargo,
       inuConsDocu,
       isbTipoProc
	    );

	-- Actualiza cartera
	pkUpdAccoReceiv.UpdAccoRec
	    (
		pkBillConst.cnuSUMA_CARGO,
		nuCuenta,
		rcSuscCurr.susccodi,
		rcSeSuCurr.sesunuse,
		inuConcepto,
		isbSigno,
		abs(inuVlrCargo),
		pkBillConst.cnuNO_UPDATE_DB
	    );

	UpdateAccoRec ;

	-- Actualiza el acumulado de los valores facturados

	if (isbSigno = pkBillConst.DEBITO) then

	    -- Cargo debito
	    nuVlrFactCta    := nuVlrFactCta + abs(inuVlrCargo) ;
	    nuVlrFactFac    := nuVlrFactFac + abs(inuVlrCargo) ;

	else
	    -- Cargo credito
	    nuVlrFactCta    := nuVlrFactCta - abs(inuVlrCargo) ;
	    nuVlrFactFac    := nuVlrFactFac - abs(inuVlrCargo) ;
	end if;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;

    	when others then
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END AddCharge;


--********************************************************************************************

PROCEDURE GenerateCharge
   (   inuConcepto	in	cargos.cargconc%type,
       isbSigno	  in	cargos.cargsign%type,
       isbDocSop  in  cargos.cargdoso%type,
	   inuCausal	in	cargos.cargcaca%type,
       inuVlrCargo in cargos.cargvalo%type,
       inuConsDocu in  cargos.cargcodo%type,
       isbTipoProc	in	cargos.cargtipr%type
	)
  IS

    -- Record del cargo
    rcCargo	cargos%rowtype ;

	csbMetodo VARCHAR2(100) := csbSP_NAME||'GenerateCharge';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    ------------------------------------------------------------------------
    -- Procedimientos Encapsulados
    ------------------------------------------------------------------------

    PROCEDURE FillRecord IS

    	rcCargoNull	cargos%rowtype;
		
		csbMetodo1 VARCHAR2(100) := csbMetodo||'.FillRecord';
		nuError1 NUMBER;
		sbError1 VARCHAR2(4000);


    BEGIN
	
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    rcCargo := rcCargoNull ;

	rcCargo.cargcuco := nuCuenta;
	rcCargo.cargnuse := rcSeSuCurr.sesunuse ;
	rcCargo.cargpefa := rcPerifactCurr.pefacodi ;
	rcCargo.cargconc := inuConcepto ;
	rcCargo.cargcaca := inuCausal;
	rcCargo.cargsign := isbSigno ;
	rcCargo.cargvalo := inuVlrCargo ;
	rcCargo.cargdoso := isbDocSop; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
	rcCargo.cargtipr := isbTipoProc; -- pkBillConst.AUTOMATICO;
	rcCargo.cargfecr := dtFechaCurrent ;
	rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
	rcCargo.cargunid := null ;
	rcCargo.cargcoll := null ;
	rcCargo.cargprog := nuPrograma; -- 2014 = AJUSTES DE FACTURACION 
	rcCargo.cargusua := sa_bosystem.getSystemUserID ;

	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError1, sbError1);
			pkg_traza.trace(csbMetodo1||' '||sbError1);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError1, sbError1);
			pkg_traza.trace(csbMetodo1||' '||sbError1);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END FillRecord ;

    ------------------------------------------------------------------------
	

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Prepara record del Cargo
    FillRecord ;

    -- Adiciona el Cargo
    pktblCargos.InsRecord (rcCargo);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END GenerateCharge;

--********************************************************************************************

PROCEDURE ProcessCharges

    IS
    -- Tabla de cargos a liquidar
    tbCargos                tytbCargos;
    rcCargos                tyrcCargos;
    tbMaxPericoseConcepto   tytbMaxPericoseConcepto;

    nuIdxCargos  number;

    -- Registro del servicio
    rcServicio      servicio%rowtype;

    -- Fecha de retiro del producto
    dtFechRetProd   servsusc.sesufere%type;

	csbMetodo VARCHAR2(100) := csbSP_NAME||'ProcessCharges';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    -- Definicion del cursor para la seleccion de todos los cargos de
    -- la cuenta generada
    CURSOR cuAllCargos (inuNumServ	servsusc.sesunuse%type)
    IS
    SELECT --+ index (cargos ix_carg_nuse_cuco_conc) -- pkGenerateInvoice.ProcessCharges
           rowid, cargconc, cargcaca, cargsign,
	   cargdoso, cargvalo, cargfecr,cargnuse, cargpeco
    FROM   cargos
    WHERE  cargcuco+0 = nuCuenta
    AND    cargnuse = inuNumServ;

    -- Indice arreglos de cargos procesados
    nuIdx	number;

    -----------------------------------------------------------------------
    -- PROCEDIMIENTOS ENCAPSULADOS
    -----------------------------------------------------------------------
    PROCEDURE CleanChargeArrays IS
	
	csbMetodo1 VARCHAR2(100) := csbMetodo||'.CleanChargeArrays';

	
    BEGIN
	
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	tbCargfact.DELETE;
	tbCargcuco.DELETE;
	tbCargfeco.DELETE;
	tbCargdate.DELETE;
	tbCargtipr.DELETE;
	tbRowid.DELETE;
	tbCargos.DELETE;
	tbMaxPericoseConcepto.DELETE;

	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    --}
    END CleanChargeArrays;

    -- Procedimiento para inicialiar datos del proceso.
    PROCEDURE Initialize IS
	
	csbMetodo1 VARCHAR2(100) := csbMetodo||'.Initialize';

	
    BEGIN
	
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        -- Obtiene el tipo de producto que se est? liquidando para
        -- realizar obtenci?n del periodo de consumo de acuerdo
        -- al tipo de cobro (anticipado o vencido)
        rcServicio := pktblservicio.frcGetRecord(rcSeSuCurr.sesuserv);

		-- Se obtiene fecha de retiro del producto
		dtFechRetProd := pkg_bcproducto.fdtfecharetiro( rcSeSuCurr.sesunuse );
		
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    END Initialize;



    PROCEDURE CalcularFechaUltLiqConcepto
    (
       inuConcepto concepto.conccodi%type,
       inuCargPeco cargos.cargpeco%type
    )
    IS
        -- Fecha ?ltima liquidaci?n
        dtFechaUltLiq   feullico.felifeul%type  := null;

        -- Tipo de cobro generado por el concepto
        sbTipoCobro     concepto.concticc%type;

        -- Datos del proceso
        nuPeriodoConsumoActual pericose.pecscons%type;

        rcPeriodoConsumoActual pericose%rowtype;

        rcPeriodoConsumoCargo  pericose%rowtype;

		csbMetodo1 VARCHAR2(100) := csbMetodo||'.ProcessLDCCPC';
		
		nuError1 NUMBER;
		sbError1 VARCHAR2(4000);


    BEGIN
	
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


        if tbMaxPericoseConcepto.EXISTS(inuConcepto) then
           -- Si el periodo de consumo del cargo es nulo, se respeta el
           -- que se exite en la colecci?n.
           if inuCargPeco IS null then
             return;
           END if;

           sbTipoCobro := tbMaxPericoseConcepto(inuConcepto).sbTipoCobro;
           rcPeriodoConsumoActual := tbMaxPericoseConcepto(inuConcepto).rcPeriodoConsumo;
        else
            -- Se obtiene el tipo de cobro del concepto
        	sbTipoCobro := pktblConcepto.fsbObtTipoCobro( inuConcepto );

            -- Obtiene el periodo de consumo current
        	pkBCPericose.GetCacheConsPerByBillPer
    		(
    		    rcSeSuCurr.sesucico,
    		    rcPerifactCurr.pefacodi,
    		    nuPeriodoConsumoActual,
    		    rcservicio.servtico, -- Tipo Cobro del Servicio (Anticipado/Vencido)
                sbTipoCobro          -- Tipo Cobro del Concepto (Consumo/Abono)
    		);

            -- Se obtiene el registro del periodo de consumo
    		rcPeriodoConsumoActual := pktblPericose.frcGetRecord (nuPeriodoConsumoActual);
        END if;

        -- Si periodo de consumo del cargo no es nulo, se debe comparar contra el
        -- actual. Debe quedar seteado como periodo actual el mas viejo.
        if inuCargPeco IS not null then
           rcPeriodoConsumoCargo := pktblPericose.frcGetRecord (inuCargPeco);

           -- Evaluar que perido de consumo es mayor, si el actual o del de cargo
           -- Se debe actualizar feullico con el mayor.
           -- Se evalua el tipo de cobro del concepto
           IF sbTipoCobro = 'C' THEN
                -- Concepto de tipo Consumo
                -- Si la fecha de consumo final del periodo del cargo es mayor a la
                -- del periodo actual, se cambia el periodo de consumo actual por
                -- el del cargo.
        		IF (rcPeriodoConsumoCargo.pecsfecf > rcPeriodoConsumoActual.pecsfecf)THEN
                    rcPeriodoConsumoActual := rcPeriodoConsumoCargo;
                END if;
           ELSE
                -- Concepto de tipo Consumo
                -- Si la fecha de cargo b?sico final del periodo del cargo es mayor a la
                -- del periodo actual, se cambia el periodo de consumo actual por
                -- el del cargo.
        		IF (rcPeriodoConsumoCargo.pecsfeaf > rcPeriodoConsumoActual.pecsfeaf)THEN
                    rcPeriodoConsumoActual := rcPeriodoConsumoCargo;
                END if;
           end if;
        END if;

        -- Se actualiza o inserta los datos a la colecci?n en memoria.
        tbMaxPericoseConcepto(inuConcepto).rcPeriodoConsumo := rcPeriodoConsumoActual;
        tbMaxPericoseConcepto(inuConcepto).sbTipoCobro := sbTipoCobro;

        -- Se debe verificar la fecha final del periodo actual, con la fecha
        -- de retiro del producto. Si la fecha de retiro es menor, se debe
        -- actualizar feullico con esta.

        -- Se evalua el tipo de cobro del concepto
        IF sbTipoCobro = 'C' THEN
            -- Concepto de tipo Consumo
            -- Si el producto se retiro en el periodo se establece esta
            -- fecha como la fecha de ?ltima liquidaci?n
    		IF ( dtFechRetProd < rcPeriodoConsumoActual.pecsfecf )THEN
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := dtFechRetProd;
            ELSE
                -- de lo contrario se establece la fecha final del periodo
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := rcPeriodoConsumoActual.pecsfecf;
            end if;
    	ELSE
            -- Concepto de tipo Abono
    		-- Si el producto se retiro en el periodo se establece esta fecha
    		-- como la fecha de ?ltima liquidaci?n
    		IF dtFechRetProd < rcPeriodoConsumoActual.pecsfeaf THEN
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := dtFechRetProd;
            ELSE
                -- de lo contrario se establece la fecha final del periodo
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := rcPeriodoConsumoActual.pecsfeaf;
            end if;
        end if;
		
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


        EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError1, sbError1);
			pkg_traza.trace(csbMetodo1||' '||sbError1);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError1, sbError1);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END CalcularFechaUltLiqConcepto;


    PROCEDURE ActFechaUltFactConceptos
    IS
        nuConcepto concepto.conccodi%type;
        -- Registro Fecha ultima liquidacion
        rcFeullico      feullico%rowtype;
		csbMetodo1 		VARCHAR2(100) := csbMetodo||'.ActFechaUltFactConceptos';
		nuError1 NUMBER;
		sbError1 VARCHAR2(4000);


    BEGIN
        pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


        nuConcepto :=  tbMaxPericoseConcepto.first;

        loop
            EXIT WHEN ( nuConcepto IS NULL );

            pkg_traza.trace('[Concepto] = '|| nuConcepto ||
            ' - [Fecha Ult Fact] = '|| tbMaxPericoseConcepto(nuConcepto).dtFechaUltLiq);

            -- Arma registro fecha ultima Facturacion
            rcFeullico.felisesu := rcSeSuCurr.sesunuse;
            rcFeullico.feliconc := nuConcepto;
            rcFeullico.felifeul := tbMaxPericoseConcepto(nuConcepto).dtFechaUltLiq;

            -- Evalua si existe registro de fecha de ?ltima liquidaci?n
            if ( pktblFeullico.fblExist(rcSeSuCurr.sesunuse, nuConcepto) ) THEN
                -- Se actualiza registro
                pktblFeullico.UpRecord( rcFeullico );
            else
                -- Se inserta registro por ser la primera vez que se actualiza
                -- fecha de ?ltima liquidaci?n
                pktblFeullico.InsRecord( rcFeullico );
            end if;

            nuConcepto := tbMaxPericoseConcepto.NEXT(nuConcepto);
        END loop;
		
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

		
    END ActFechaUltFactConceptos;
    -----------------------------------------------------------------------
BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


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
        pkg_traza.trace('Procesando todos los cargos asociados al producto: '||
        rcSeSuCurr.sesunuse);
        OPEN cuAllCargos(rcSeSuCurr.sesunuse);
        FETCH cuAllCargos bulk collect INTO tbCargos;
        CLOSE cuAllCargos;

    if(tbCargos.count > 0)then
        -- Valida que el producto pertenezca al contrato
        ValSubsNServ(rcSuscCurr.susccodi,rcSeSuCurr.sesunuse);
    END if;

    pkg_traza.trace('Periodo de facturacion actual: '|| rcPerifactCurr.pefacodi);


    -- Recorrer tabla de cargos.
    nuIdxCargos :=  tbCargos.first;

    loop
       EXIT WHEN ( nuIdxCargos IS NULL );
            rcCargos := tbCargos(nuIdxCargos);

            pkg_traza.trace('Procesando cargo: [Concepto]='|| rcCargos.cargconc ||
            ' - [Valor] = '|| rcCargos.cargvalo);


        	-- Actualiza Cartera
        	pkUpdAccoReceiv.UpdAccoRec
    	    (
        		pkBillConst.cnuSUMA_CARGO,
        		nuCuenta,
        	    PKG_BCPRODUCTO.FNUCONTRATO(rcCargos.cargnuse),--	rcCargos.cargsusc,
        		rcCargos.cargnuse,
        		rcCargos.cargconc,
        		rcCargos.cargsign,
        		rcCargos.cargvalo,
        		pkBillConst.cnuNO_UPDATE_DB
    	    );


        	-- Almacena informacion del cargo procesado
        	tbCargfact (nuIdx) := nuEstadoCuenta;
        	tbCargcuco (nuIdx) := nuCuenta;
        	tbCargfeco (nuIdx) := dtFechaContable;
        	tbCargtipr (nuIdx) := PKBILLCONST.POST_FACTURACION; --CA 200-1625 pkBillConst.AUTOMATICO;

            /*Se asigna la fecha de generaci?n de la factura a la
            fecha de creaci?n del cargo*/
            pkg_traza.trace('rcCargos.cargfecr'||rcCargos.cargfecr);
            pkg_traza.trace('grcEstadoCta.factfege '||grcEstadoCta.factfege);

            IF (rcCargos.cargfecr > grcEstadoCta.factfege) THEN

                tbCargdate (nuIdx) := grcEstadoCta.factfege;

                pkg_traza.trace('Actualiz? fecha con la fecha de generaci?n de factura '||grcEstadoCta.factfege);

            else
                tbCargdate (nuIdx) := rcCargos.cargfecr;

            END IF;

            tbRowid    (nuIdx) := rcCargos.sbrowid;

        	nuIdx := nuIdx + 1;

        	CalcularFechaUltLiqConcepto
            (
               rcCargos.cargconc,
               rcCargos.cargpeco
            );

            nuIdxCargos := tbCargos.NEXT(nuIdxCargos);
    END loop;

    -- Actualiza los Cargos
    if (nuIdx > 1) then
    	-- Actualiza el Cargo current
    	UpdateCharges;

    	-- Actualiza fecha de ultima facturaci?n del concepto.
    	ActFechaUltFactConceptos;
    end if;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			IF (cuAllCargos%isOpen) THEN
			   CLOSE cuAllCargos;
			END IF;
            RAISE pkg_error.controlled_error;

		WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			IF (cuAllCargos%isOpen) THEN
			   CLOSE cuAllCargos;
			END IF;
			RAISE pkg_error.controlled_error;
END ProcessCharges;


--********************************************************************************************


PROCEDURE UpdateAccoRec IS

	csbMetodo VARCHAR2(100) := csbSP_NAME||'UpdateAccoRec';
	nuError NUMBER;
	sbError VARCHAR2(4000);

BEGIN
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Actualiza la cartera
    pkUpdAccoReceiv.UpdateData ;

    -- Obtiene valores de la cuenta de cobro
    pkUpdAccoReceiv.GetAccountData
	(
	    nuCuenta,
	    nuCart_ValorCta,
	    nuCart_AbonoCta,
	    nuCart_SaldoCta
	);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END UpdateAccoRec;

--********************************************************************************************

PROCEDURE ProcessGeneratedAcco IS

    sbSignoAjuste	cargos.cargsign%type;	-- Signo del ajuste
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ProcessGeneratedAcco';
	nuError NUMBER;
	sbError VARCHAR2(4000);


BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


    -- Genera Ajuste de la cuenta
    AdjustAccount ;

    -- Genera posible saldo a favor
    pkAccountMgr.GenPositiveBal
	(
	    nuCuenta
	) ;

    -- Aplica saldo a favor
    pkAccountMgr.ApplyPositiveBalServ
	(
	    rcSeSuCurr.sesunuse,
	    nuCuenta,
	    pkBillConst.POST_FACTURACION,--pkBillConst.MANUAL,
	    dtFechaGene
	) ;

    -- Actualiza acumulados de facturacion por cuenta
    UpdAccoBillValues ;

    -- Obtiene saldo pendiente de la factura
    nuSaldoFac := pkBCAccountStatus.fnuGetBalance(nuEstadoCuenta);


	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ProcessGeneratedAcco;

--********************************************************************************************
PROCEDURE AsignaNumeracionFiscal


    IS

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        -- Tipo de comprobante
        nuTipoComprobante   tipocomp.ticocodi%type;
		
		csbMetodo VARCHAR2(100) := csbSP_NAME||'AsignaNumeracionFiscal';
		nuError NUMBER;
		sbError VARCHAR2(4000);

    BEGIN

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


     	-- Se asigna el tipo de documento
      	grcEstadoCta.factcons := gnuTipoDocumento;

        -- Se obtiene el n?mero fiscal
        pkConsecutiveMgr.GetFiscalNumber
        (
            pkConsecutiveMgr.gcsbTOKENFACTURA,
            grcEstadoCta.factcodi            ,
            null                             ,
            grcEstadoCta.factcons            ,
            rcSuscCurr.suscclie              ,
            rcSuscCurr.suscsist              ,
            grcEstadoCta.factnufi            ,
            grcEstadoCta.factpref            ,
            grcEstadoCta.factconf            ,
            nuTipoComprobante
        );

        -- Se actualiza la factura
        pktblFactura.UpFiscalNumber
        (
        	grcEstadoCta.factcodi,
        	grcEstadoCta.factnufi,
        	grcEstadoCta.factcons,
            grcEstadoCta.factconf,
            grcEstadoCta.factpref
        );

        -- Se limpia el registro global de factura
        grcEstadoCta := null;

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;

    END AsignaNumeracionFiscal;
--********************************************************************************************


--********************************************************************************************


FUNCTION ValInputData
          (osbError out varchar2) return number IS
		  
		  
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValInputData';
	nuError NUMBER;
	sbError VARCHAR2(4000);
		  
BEGIN
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Valida la suscripcion
    ValSubscriber (nuSuscripcion);

    -- Valida el servicio suscrito
    ValSubsService (nuServsusc);

    -- Valida que el producto pertenezca al contrato
    ValSubsNServ(nuSuscripcion,nuServsusc);

    -- Valida la fecha de generacion
    ValGenerationDate(dtFechaGene);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    return (1);


EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ValInputData;

--********************************************************************************************

PROCEDURE ValSubsService
    (
	inuServsusc	in	servsusc.sesunuse%type
    )
    IS

	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValSubsService';
	nuError NUMBER;
	sbError VARCHAR2(4000);

    ----------------------------------------------------------------------------
    -- VerifyProdProcessSecurity -- Valida estados del corte Producto
    ----------------------------------------------------------------------------
    PROCEDURE VerifyProdProcessSecurity
    (
        inuSesu    servsusc.sesunuse%type
    )
    IS
        sbProc   	procrest.prreproc%type;
		csbMetodo1 	VARCHAR2(100) := csbMetodo||'.VerifyProdProcessSecurity';
		nuError1 NUMBER;
		sbError1 VARCHAR2(4000);


    BEGIN

	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        sbProc := pkErrors.fsbGetApplication;

        -- Se valida si el producto tiene restricci?n de pago por corte
        pkBOProcessSecurity.ValidateProductSecurity (
                                                           inuSesu,
                                                           sbProc
                                                       );
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError1, sbError1);
			pkg_traza.trace(csbMetodo1||' '||sbError1);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError1, sbError1);
			pkg_traza.trace(csbMetodo1||' '||sbError1);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END VerifyProdProcessSecurity;
	


BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Realiza la validacion basica del servicio suscrito
    pkServNumberMgr.ValBasicData (inuServsusc);

    VerifyProdProcessSecurity (inuServsusc);

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ValSubsService;
--********************************************************************************************

PROCEDURE ValSubscriber
    (
	inuSuscripcion	in	suscripc.susccodi%type
    )
    IS
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValSubscriber';
	nuError NUMBER;
	sbError VARCHAR2(4000);

BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Realiza la validacion basica de la suscripcion
    pkSubscriberMgr.ValBasicData (inuSuscripcion);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ValSubscriber;


--********************************************************************************************

PROCEDURE ValSupportDoc
    (
	isbDocumento	in	cargos.cargdoso%type
    )
    IS

   -- Error en el documento soporte
    cnuERROR_DOCSOP	constant number := 11517;
	sbMensaje varchar2(200);
	
	nuError NUMBER;
	sbError VARCHAR2(4000);

	
	cursor cuMensaje is
	SELECT mensdesc 
	From mensaje 
	WHERE menscodi = cnuERROR_DOCSOP
	and mensdivi = pkConstante.csbDIVISION 
	and mensmodu = pkConstante.csbMOD_BIL;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValSupportDoc';


BEGIN
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    if ( isbDocumento is null ) then
	
		IF cuMensaje%ISOPEN THEN
		   CLOSE cuMensaje;
		END IF;
		
		OPEN cuMensaje;
		FETCH cuMensaje into sbMensaje;
		CLOSE cuMensaje;
		
		pkg_error.SetErrorMessage(pkg_error.cnugeneric_message,sbMensaje);
		
    end if;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ValSupportDoc;

--********************************************************************************************
PROCEDURE ValSubsNServ
    (
	inuSubscription in suscripc.susccodi%type,
	inuServNum      in servsusc.sesunuse%type
    )
    IS

	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValSubsNServ';
	nuError NUMBER;
	sbError VARCHAR2(4000);


BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    pkServNumberMgr.ValSubscription(inuSubscription,inuServNum);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ValSubsNServ;
--********************************************************************************************

FUNCTION ValContProdServ
    (
	inuSubscription in suscripc.susccodi%type,
	inuServNum      in servsusc.sesunuse%type,
    inuserv         in servsusc.sesuserv%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);

csbMetodo VARCHAR2(100) := csbSP_NAME||'ValContProdServ';
nuError NUMBER;
sbError VARCHAR2(4000);


cursor cuservsusc is
 select 'x'
   from servsusc
  where sesususc = inuSubscription
    and sesunuse = inuServNum
    and sesuserv = inuserv;

BEGIN

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


 open cuservsusc;
 fetch cuservsusc into sbExiste;
 if cuservsusc%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuservsusc;

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 return (nures);

EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			return -1;
END ValContProdServ;


--********************************************************************************************

FUNCTION ValConcepto
    (
	inuConcepto concepto.conccodi%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);
csbMetodo VARCHAR2(100) := csbSP_NAME||'ValConcepto';
nuError NUMBER;
sbError VARCHAR2(4000);


cursor cuConcepto is
 select 'x'
   from concepto
  where conccodi = inuConcepto;

BEGIN

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

 open cuConcepto;
 fetch cuConcepto into sbExiste;
 if cuConcepto%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuConcepto;

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 return (nures);

EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			return -1;
END ValConcepto;

--********************************************************************************************

FUNCTION ValCausal
     (
	inuCausal causcarg.cacacodi%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);
csbMetodo VARCHAR2(100) := csbSP_NAME||'ValCausal';
nuError NUMBER;
sbError VARCHAR2(4000);


cursor cuCausal is
 select 'x'
   from causcarg
  where cacacodi = inuCausal;

BEGIN
pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

 open cuCausal;
 fetch cuCausal into sbExiste;
 if cuCausal%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuCausal;

 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 return (nures);

EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			return -1;
END ValCausal;

--********************************************************************************************

FUNCTION ValPlanFina
     (
	inuPlan plandife.PLDICODI%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);

csbMetodo VARCHAR2(100) := csbSP_NAME||'ValPlanFina';
nuError NUMBER;
sbError VARCHAR2(4000);

cursor cuPlan is
 select 'x'
   from plandife
  where PLDICODI = inuPlan;

BEGIN

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

 open cuPlan;
 fetch cuPlan into sbExiste;
 if cuPlan%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuPlan;

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 return (nures);

EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			return -1;
END ValPlanFina;
--********************************************************************************************

FUNCTION fboGetIsNumber
    (
	isbValor varchar2
    ) return boolean is

blResult boolean := TRUE;
nuRes    number;
csbMetodo VARCHAR2(100) := csbSP_NAME||'fboGetIsNumber';
nuError NUMBER;
sbError VARCHAR2(4000);


BEGIN

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

 begin
   nuRes := to_number(isbValor);
 exception when others then
   blResult := FALSE;
 end;

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 return (blResult);

EXCEPTION
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			return (FALSE);
END fboGetIsNumber;


--********************************************************************************************



PROCEDURE ValGenerationDate
    (
	idtFechaGene	in	date
    )
    IS

	-- Fecha fuera de rango de fechas de movimientos del periodo de
	-- facturacion current
    cnuDATE_OUT_OF_RANGE	constant number := 10116;
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValGenerationDate';
	
	nuError NUMBER;
	sbError VARCHAR2(4000);

	
	cursor cuMensaje is
	SELECT mensdesc 
	From mensaje 
	WHERE menscodi = cnuDATE_OUT_OF_RANGE
	and mensdivi = pkConstante.csbDIVISION 
	and mensmodu = pkConstante.csbMOD_BIL;

	sbMensaje varchar2(200);


BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    pkGeneralServices.ValDateY2K ( idtFechaGene );

    -- Valida que la fecha de generacion de cuentas se encuentre entre las
    -- fechas de movimientos del periodo
    if ( trunc(idtFechaGene) < trunc(rcPerifactCurr.pefafimo) or
	 trunc(idtFechaGene) > trunc(rcPerifactCurr.pefaffmo) )
    then
	
	    IF cuMensaje%ISOPEN THEN
		   CLOSE cuMensaje;
		END IF;
		
		OPEN cuMensaje;
		FETCH cuMensaje into sbMensaje;
		CLOSE cuMensaje;

		pkg_error.SetErrorMessage(pkg_error.cnugeneric_message,sbMensaje);
		
	end if;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END ValGenerationDate;



--********************************************************************************************


PROCEDURE GenerateAccount IS

	csbMetodo VARCHAR2(100) := csbSP_NAME||'GenerateAccount';
	nuError NUMBER;
	sbError VARCHAR2(4000);


BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Define cuenta para el servicio suscrito
    nuCuenta := fnuGetAccountNumber ;

    AddAccount ;

    -- Se pudo generar la cuenta
    boCuentaGenerada := TRUE;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END GenerateAccount;


--********************************************************************************************

PROCEDURE GenerateAccountStatus IS

	csbMetodo VARCHAR2(100) := csbSP_NAME||'GenerateAccountStatus';
	nuError NUMBER;
	sbError VARCHAR2(4000);

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Define estado de cuenta para la suscripcion
    nuEstadoCuenta := fnuGetAccountStNumber ;

    -- Adiciona el registro del nuevo estado de cuenta
    AddAccountStatus ;

    -- Genero estado de cuenta
    boAccountStGenerado := TRUE;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END GenerateAccountStatus;

--********************************************************************************************

PROCEDURE UpdateCharges IS

    -- Colecciones temporales para almacenar la informacion de los cargos que se
    -- estan actualizando
    tbCargnuse          pktblCargos.tyCargnuse;
    tbCargconc          pktblCargos.tyCargconc;
    tbCargvalo          pktblCargos.tyCargvalo;
    tbCargvabl          pktblCargos.tyCargvabl;
    tbCargsign          pktblCargos.tyCargsign;
    tbCargcaca          pktblCargos.tyCargcaca;
    tbCargdoso          pktblCargos.tyCargdoso;
    tbCargfecr          pktblCargos.tyCargfecr;

    tbCargnuseNull      pktblCargos.tyCargnuse;
    tbCargconcNull      pktblCargos.tyCargconc;
    tbCargvaloNull      pktblCargos.tyCargvalo;
    tbCargvablNull      pktblCargos.tyCargvabl;
    tbCargsignNull      pktblCargos.tyCargsign;
    tbCargcacaNull      pktblCargos.tyCargcaca;
    tbCargdosoNull      pktblCargos.tyCargdoso;
    tbCargfecrNull      pktblCargos.tyCargfecr;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'UpdateCharges';

	nuError NUMBER;
	sbError VARCHAR2(4000);


    PROCEDURE ClearArrays IS

	csbMetodo1 VARCHAR2(100) := csbMetodo||'.ClearArrays';

    BEGIN
		
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        tbCargnuse := tbCargnuseNull;
        tbCargconc := tbCargconcNull;
        tbCargvalo := tbCargvaloNull;
        tbCargvabl := tbCargvablNull;
        tbCargcaca  := tbCargcacaNull;
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

		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END ClearArrays ;

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Limpia colecciones temporales
    ClearArrays ;

    -- Realiza la actualizacion del cargo
    FORALL nuIndex in tbCargfact.FIRST .. tbCargfact.LAST
    UPDATE cargos
    SET  --cargfact = tbCargfact (nuIndex),
	   cargcuco = tbCargcuco (nuIndex),
	   cargfecr = tbCargdate (nuIndex),
	   --cargfeco = tbCargfeco (nuIndex),
	   cargtipr = tbCargtipr (nuIndex)
    WHERE  rowid    = tbRowid    (nuIndex)
    RETURNING cargnuse, cargconc, cargvalo, cargvabl, cargsign, cargcaca, cargdoso, cargfecr
         BULK COLLECT INTO tbcargnuse, tbCargconc, tbCargvalo, tbcargvabl, tbCargsign, tbCargcaca, tbCargdoso, tbcargfecr;

    -- Acumula valores facturados

    for nuIdx in tbCargvalo.FIRST .. tbCargvalo.LAST loop
    --{
        -- Evalua si se trata de una cuota de capital de diferido o
        -- una cuota extra para no acumularla como valor facturado
        -- Se evalua ademas que la causa de cargo de los cargos no sea la obtenida
        -- del parametro de causa de cargo por traslado de diferido.
        if ( substr( tbCargdoso( nuIdx ), 1, 3 ) = pkBillConst.csbTOKEN_DIFERIDO or
             substr( tbCargdoso( nuIdx ), 1, 3 ) = pkBillConst.csbTOKEN_CUOTA_EXTRA or
             FA_BOChargeCauses.fboIsDefTransChCause(tbCargcaca( nuIdx ))
        )
        then
            goto PROXIMO ;
        end if;

        -- Acumula valores facturados
        if (tbCargsign (nuIdx) = pkBillConst.DEBITO) then
        --{
            -- Se acumula el valor facturado de la cuenta de cobro y la factura
            nuVlrFactCta := nuVlrFactCta + tbCargvalo( nuIdx );
            nuVlrFactFac := nuVlrFactFac + tbCargvalo( nuIdx );

            -- Se obtiene la informacion del concepto para determinar si se trata
            -- de un concepto de impuesto
            if ( pkConceptMgr.fblIsTaxesConcept( tbCargconc( nuIdx ) ) ) then
            --{
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta + tbCargvalo( nuIdx );

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac + tbCargvalo( nuIdx );
            --}
            else
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta + FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac + FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));
            end if;
        else
            -- Se acumula el valor facturado de la cuenta de cobro y la factura
            nuVlrFactCta := nuVlrFactCta - tbCargvalo( nuIdx );
            nuVlrFactFac := nuVlrFactFac - tbCargvalo( nuIdx );

            -- Se obtiene la informacion del concepto para determinar si se trata
            -- de un concepto de impuesto
            if ( pkConceptMgr.fblIsTaxesConcept( tbCargconc( nuIdx ) ) ) then
            --{
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta - tbCargvalo( nuIdx );

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac - tbCargvalo( nuIdx );
            else
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta - FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac - FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));
            --}
            end if;
        --}
        end if;

        << PROXIMO >>
        null ;
    --}
    end loop ;

    -- Limpia colecciones temporales
    ClearArrays ;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END UpdateCharges;


--********************************************************************************************

PROCEDURE AdjustAccount IS

    nuValorCta		cuencobr.cucovato%type;	-- Valor total cuenta
    nuVlrAjustes	number;			-- Suma ajustes previos Cta
    sbSignoAjuste	cargos.cargsign%type;	-- Signo ajuste
    nuVlrAjuste		cargos.cargvalo%type;	-- Valor ajuste
    sbSignCanc		cargos.cargsign%type;	-- Signo de cancelacion ajuste

    -- Evaluacion si se deben o no ajustar las cuentas de acuerdo a la
    -- configuracion realizada en los parametros de facturacion
    boAjustarCuentas	boolean;
    -- Factor de ajuste de cuenta
    nuFactorAjusteCta	timoempr.tmemfaaj%type;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'AdjustAccount';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    -----------------------------------------------------------------------
    -- Procedimientos Encapsulados
    -----------------------------------------------------------------------
    -- --------------------------------------------------------------------
    -- 	Evalua si el valor necesita o no ajuste
    -- --------------------------------------------------------------------
    FUNCTION fblNeedAdjust
    (
        inuValorCta	in	cuencobr.cucovato%type
    )
    RETURN boolean IS

        nuValor		cuencobr.cucovato%type;	-- Valor absoluto cuenta
        nuVlrAAjustar	cuencobr.cucovato%type;	-- Valor a ajustar
		csbMetodo1 VARCHAR2(100) := csbMetodo||'.fblNeedAdjust';
		nuError NUMBER;
		sbError VARCHAR2(4000);


    BEGIN
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        nuValor := inuValorCta;

        -- Valida el valor de la cuenta

        if ( nuValor = 0.00 or nuValor is null ) then
        	return (FALSE);
        end if;

        -- Obtiene residuo del valor de la cuenta vs el factor de ajuste
        nuVlrAAjustar := mod (abs (nuValor), nuFactorAjusteCta);

        -- En caso de que no haya valor desajustado, retorna

        if ( nuVlrAAjustar = 0.00 ) then
        	return (FALSE);
        end if;
		
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        return (TRUE);

	EXCEPTION
			WHEN pkg_error.controlled_error THEN
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo1||' '||sbError);
				pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
				RAISE pkg_error.controlled_error;
			WHEN OTHERS THEN
				pkg_error.setError;
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo1||' '||sbError);
				pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
				RAISE pkg_error.controlled_error;
		END fblNeedAdjust;
    -- --------------------------------------------------------------------
    --  Adiciona cargo de ajuste
    -- --------------------------------------------------------------------
    PROCEDURE AddCharge
	(
	    inuVlrCargo	in	cargos.cargvalo%type,
	    isbSigno	in	cargos.cargsign%type,
	    isbDocSop	in	cargos.cargdoso%type
	)
	IS
	
	csbMetodo1 VARCHAR2(100) := csbMetodo||'.AddCharge';
	nuError NUMBER;
	sbError VARCHAR2(4000);

	
    BEGIN
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	-- Adiciona el Cargo
	GenerateCharge
	    (
			nuConcAjuste,
			isbSigno,
			isbDocSop,
			FA_BOChargeCauses.fnuGenericChCause(pkConstante.NULLNUM), -- causal original en pkGenInvoice
			abs(inuVlrCargo),
			0, -- consdocu (cargcodo)
			PKBILLCONST.POST_FACTURACION --CA 200-1625 --pkBillConst.AUTOMATICO -- tipoproc
	    );

	-- Actualiza cartera
	pkUpdAccoReceiv.UpdAccoRec
	    (
		pkBillConst.cnuSUMA_CARGO,
		nuCuenta,
		rcSuscCurr.susccodi,
		rcSeSuCurr.sesunuse,
		nuConcAjuste,
		isbSigno,
		abs(inuVlrCargo),
		pkBillConst.cnuNO_UPDATE_DB
	    );

	UpdateAccoRec ;

	-- Actualiza el acumulado de los valores facturados

	if (isbSigno = pkBillConst.DEBITO) then
	--{

	    -- Cargo debito
	    nuVlrFactCta    := nuVlrFactCta + abs(inuVlrCargo) ;
	    nuVlrFactFac    := nuVlrFactFac + abs(inuVlrCargo) ;

	--}
	else
	--{
	    -- Cargo credito
	    nuVlrFactCta    := nuVlrFactCta - abs(inuVlrCargo) ;
	    nuVlrFactFac    := nuVlrFactFac - abs(inuVlrCargo) ;
	--}
	end if;

    pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
			WHEN pkg_error.controlled_error THEN
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo1||' '||sbError);
				pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
				RAISE pkg_error.controlled_error;
			WHEN OTHERS THEN
				pkg_error.setError;
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo1||' '||sbError);
				pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
				RAISE pkg_error.controlled_error;
		END AddCharge;

    ------------------------------------------------------------------------

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Obtiene validacion ajuste a la cuenta
    FA_BOPoliticaRedondeo.ObtienePoliticaAjuste (
                                                    rcSeSuCurr.sesususc,
                                                    boAjustarCuentas,
                                                    nuFactorAjusteCta
                                                );

    -- Evalua si se debe realizar ajuste, de acuerdo a los parametros

    if (not boAjustarCuentas) then
    	return;
    end if;

    -- Obtiene el valor de la cuenta actualizado
    nuValorCta := nuCart_ValorCta ;

    -- Evalua si necesita ajuste

    if (not fblNeedAdjust (nuValorCta)) then
    	return;
    end if;

    -- Obtiene el valor de los ajustes realizados a la cuenta
    nuVlrAjustes := fnuGetAdjustValue ;

    -- Evalua si debe cancelar ajustes previos

    if (nuVlrAjustes != 0.00) then
    --{
    	-- Obtiene signo de cancelacion de cargo ajuste
    	sbSignCanc := pkChargeMgr.fsbGetCancelSign (nuVlrAjustes);

    	-- Crea cargo de cancelacion
    	AddCharge
	    (
    		nuVlrAjustes,
    		sbSignCanc,
    		pkBillConst.csbDOC_CANC_AJUSTE
	    );
    --}
    end if;

    -- Obtiene el valor de la cuenta actualizado
    nuValorCta := nuCart_ValorCta ;

    -- Calcula el valor y signo del nuevo ajuste
    CalcAdjustValue
	(
        nuFactorAjusteCta,
	    nuValorCta,
	    nuVlrAjuste,
	    sbSignoAjuste
	);

    -- Evalua si se debe adicionar cargo

    if ( nuVlrAjuste = 0.00 ) then
    	return;
    end if;

    -- Crea cargo con el nuevo ajuste
    AddCharge
	(
	    nuVlrAjuste,
	    sbSignoAjuste,
	    pkBillConst.csbDOC_AJUSTE
	);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END AdjustAccount;


--********************************************************************************************

FUNCTION fnuGetAccountNumber RETURN number IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- Numero de cuenta
    nuCta		cuencobr.cucocodi%type;
	csbMetodo VARCHAR2(100) := csbSP_NAME||'fnuGetAccountNumber';
	nuError NUMBER;
	sbError VARCHAR2(4000);


BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Obtiene el numero de la cuenta del consecutivo
    pkAccountMgr.GetNewAccountNum (nuCta);

    -- Cerramos el bloque autonomo
    pkgeneralservices.CommitTransaction;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    return (nuCta);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END fnuGetAccountNumber;


--********************************************************************************************

FUNCTION fnuGetAccountStNumber RETURN number IS

    PRAGMA AUTONOMOUS_TRANSACTION;
    nuEstadoCta	factura.factcodi%type;	-- Numero estado de cuenta
	csbMetodo VARCHAR2(100) := csbSP_NAME||'fnuGetAccountStNumber';
	nuError NUMBER;
	sbError VARCHAR2(4000);


BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Obtiene el numero del estado de cuenta del consecutivo
    pkAccountStatusMgr.GetNewAccoStatusNum (nuEstadoCta);

    -- Cerramos el bloque autonomo
    pkgeneralservices.CommitTransaction;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    return (nuEstadoCta);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END fnuGetAccountStNumber;


--********************************************************************************************

PROCEDURE AddAccount IS

    rcCuenta	cuencobr%rowtype;	-- Record de cuenta de cobro

	csbMetodo VARCHAR2(100) := csbSP_NAME||'AddAccount';
    
   	nuError NUMBER;
	sbError VARCHAR2(4000);


    ----------------------------------------------------------------------
    -- METODOS ENCAPSULADOS
    ----------------------------------------------------------------------

    PROCEDURE FillRecord IS

    	rcCuenCobrNull	cuencobr%rowtype;	-- Record Nulo Cuenta
		csbMetodo1 VARCHAR2(100) := csbMetodo||'.FillRecord';
		nuError NUMBER;
		sbError VARCHAR2(4000);

		
    BEGIN
	
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	rcCuenta := rcCuenCobrNull;

	-- Se prepara el registro de la Cuenta de Cobro
	-- Ya se tiene current la cuenta de cobro
	rcCuenta.cucocodi := nuCuenta;
	rcCuenta.cucogrim := 99 ;
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
 	rcCuenta.cucofeve := pkSubsDateLineMgr.fdtGetDateLine
				(
				    rcSeSuCurr.sesususc,
				    rcPerifactCurr.pefaano,
				    rcPerifactCurr.pefames,
				    rcPerifactCurr.pefafepa
				);

    -- Se obtiene la direcci?n de instalaci?n del producto
	rcCuenta.cucodiin := PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION(rcSeSuCurr.sesunuse);
	rcCuenta.cucosist := rcSeSuCurr.sesusist;

    pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END FillRecord;

    ----------------------------------------------------------------------

BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Se prepara el registro de la Cuenta de Cobro
    FillRecord ;

    -- Se adiciona el registro a la tabla Cuencobr
    pktblCuencobr.InsRecord (rcCuenta);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END AddAccount;


--********************************************************************************************

PROCEDURE AddAccountStatus IS

    rcEstadoCta	factura%rowtype := NULL;	-- Record de Estado de cuenta
	csbMetodo VARCHAR2(100) := csbSP_NAME||'AddAccountStatus';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    ----------------------------------------------------------------------
    -- METODOS ENCAPSULADOS
    ----------------------------------------------------------------------

    PROCEDURE FillNewRecord IS

    	rcEstadoCtaNull	factura%rowtype := NULL; -- Record Nulo Estado Cuenta
		csbMetodo1 VARCHAR2(100) := csbMetodo||'.FillNewRecord';
		nuError NUMBER;
		sbError VARCHAR2(4000);


    BEGIN

		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

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
        -- Se obtiene la direcci?n de cobro
        rcEstadoCta.factdico := rcSuscCurr.susciddi;

    	rcEstadoCta.factprog := nuPrograma;

        -- La numeracion fiscal pasa a ser asignada despues de aceptar
        -- y ser creada la factura y todo su proceso
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


	EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END FillNewRecord;

    ----------------------------------------------------------------------

BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Se prepara el registro del Estado de cuenta
    FillNewRecord ;

    -- guarda informacion de la factura generada
    grcEstadoCta := rcEstadoCta;

    -- Se adiciona el registro a la tabla Factura
    pktblFactura.InsRecord (rcEstadoCta);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END AddAccountStatus;


--********************************************************************************************
FUNCTION fnuGetAdjustValue RETURN number IS

    nuVlrAjustes	number;			-- Valor de los ajustes

	-- Documento de soporte para ajuste de cuenta
    csbAJUSTE           constant varchar2(15) := 'AJUSTE';

	-- Documento de soporte para cancelacion de ajuste de cuenta
    csbCANCAJUSTE       constant varchar2(15) := 'CANC.AJUSTE';
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'fnuGetAdjustValue';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    -- Cursor para sumar los ajuste de la cuenta
    CURSOR cuAjuste (nuCuenta	cargos.cargcuco%type,
		             nuConcepto	cargos.cargconc%type)
    IS
    SELECT nvl (sum (decode (upper (cargsign), pkBillConst.DEBITO,
					       cargvalo,
					       pkBillConst.CREDITO,
					       -cargvalo, 0 ) ), 0 )
    FROM   cargos
    WHERE  cargcuco = nuCuenta
    AND    cargconc = nuConcepto
    AND    cargdoso || '' in (csbAJUSTE, csbCANCAJUSTE);

BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Obtiene el valor de los ajustes de la cuenta
    open cuAjuste (nuCuenta, nuConcAjuste);

    fetch cuAjuste into nuVlrAjustes;
    close cuAjuste;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    return (nuVlrAjustes);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END fnuGetAdjustValue;


--********************************************************************************************

PROCEDURE CalcAdjustValue
    (
    inuFactor   in  timoempr.tmemfaaj%type,
    inuValorCta	in	cuencobr.cucovato%type,
	onuValorAjuste	out	cargos.cargvalo%type,
	osbSignoAjuste	out	cargos.cargsign%type
    )
    IS

    nuValor		cuencobr.cucovato%type;	-- Valor absoluto cuenta
    nuVlrAAjustar	number;			-- Valor que se va a ajustar
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'CalcAdjustValue';
	nuError NUMBER;
	sbError VARCHAR2(4000);

BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    onuValorAjuste := pkBillConst.CERO;
    osbSignoAjuste := null;
    nuValor        := inuValorCta;

    -- Valida el valor de la cuenta

    if ( nuValor = 0.00 or nuValor is null ) then
    	return;
    end if;

    -- Evalua si el valor de la cuenta es negativo

    if ( nuValor < 0.00 ) then
    	nuValor := abs (nuValor);
    end if;

    -- Obtiene residuo del valor de la cuenta vs el factor de ajuste
    nuVlrAAjustar := mod (nuValor, inuFactor);

    -- En caso de que no haya valor desajustado, retorna

    if ( nuVlrAAjustar = 0.00 ) then
    	return;
    end if;

    -- Evalua si el ajuste es por encima o por debajo, comparando contra
    -- la mitad del factor de ajuste

    if ( (inuFactor - nuVlrAAjustar) > (inuFactor / 2) ) then
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

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END CalcAdjustValue;


--********************************************************************************************

PROCEDURE UpdAccoBillValues IS

csbMetodo VARCHAR2(100) := csbSP_NAME||'UpdAccoBillValues';
nuError NUMBER;
sbError VARCHAR2(4000);

BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    pktblCuencobr.UpBilledValues
        (
            nuCuenta,
            nuVlrFactCta,
            nuVlrIvaFactCta
        );

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END UpdAccoBillValues;


--********************************************************************************************
PROCEDURE GetOverChargePercent(inuPlandife         in plandife.pldicodi%type,
                                   onuPercenOverCharge out number) IS
								   
	csbMetodo VARCHAR2(100) := csbSP_NAME||'GetOverChargePercent';
	nuError NUMBER;
	sbError VARCHAR2(4000);

	
    BEGIN

	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      onuPercenOverCharge := pktblPlandife.fnuPercOverCharge(inuPlandife,
                                                             pkConstante.NOCACHE);
      onuPercenOverCharge := nvl(onuPercenOverCharge, 0);

      if onuPercenOverCharge not between 0 AND 100 then
        -- El porcentaje de mora configurado en el plan de financiacion (%s1) no es correcto
        pkg_error.SetErrorMessage(cnuBadOverChargePercent, inuPlandife);
      END if;
	  
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	  
	EXCEPTION
			WHEN pkg_error.controlled_error THEN
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo||' '||sbError);
				pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
				RAISE pkg_error.controlled_error;
			WHEN OTHERS THEN
				pkg_error.setError;
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo||' '||sbError);
				pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
				RAISE pkg_error.controlled_error;
		END;
--*******************************************************************************************
PROCEDURE ValInterestConcept(inuConc in concepto.conccodi%type) IS

	csbMetodo VARCHAR2(100) := csbSP_NAME||'ValInterestConcept';
	nuError NUMBER;
	sbError VARCHAR2(4000);


  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    -- Valida si el codigo del concepto es nulo

    pkConceptMgr.ValidateNull(inuConc);

    -- Valida si el concepto existe en BD

    pktblConcepto.AccKey(inuConc);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
  END ValInterestConcept;

--*******************************************************************************************
PROCEDURE GetExtraPayTotal(inuExtraPayNumber in number,
                             onuExtraPayValue  out number) IS
    nuIndex number;
	csbMetodo VARCHAR2(100) := csbSP_NAME||'GetExtraPayTotal';
	nuError NUMBER;
	sbError VARCHAR2(4000);


  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

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

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


  EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
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

	csbMetodo VARCHAR2(100) := csbSP_NAME||'FillAditionalInstalments';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    PROCEDURE LoadInstalments IS

      nuIndex    number;
      nuVlrCuota cuotextr.cuexvalo%type;
      rcCuotExtr cuotextr%rowtype;

      rcExtraPayments mo_tyobExtraPayments;

      nuQuotaNumber number;

      nuTotCuotaNumber number;

      nuSigno number;

      nuAcumCuotExtr cuotextr.cuexvalo%type;
	  
	  csbMetodo1 VARCHAR2(100) := csbMetodo||'.LoadInstalments';
	  nuError NUMBER;
	  sbError VARCHAR2(4000);


    BEGIN
	
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

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
        pkg_traza.Trace('No hay cuotas extras a distribuir para el producto ' ||
                       to_char(nugNumServ));
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
            pkg_traza.trace('Ajuste de la cuota extra #' || nuQuotaNumber);
            nuVlrCuota := rcCuotExtr.cuexvalo +
                          (nuTotCuotaNumber - nuAcumCuotExtr);
            pkg_traza.trace('Valor Cuota extra=' || rcCuotExtr.cuexvalo ||
                           '+ (' || nuTotCuotaNumber || '-' ||
                           nuAcumCuotExtr || ') =>' || nuVlrCuota);
            rcCuotExtr.cuexvalo := nuVlrCuota;
          end if;
        END if;

        pkg_traza.Trace('Numero cuota extra -> [' || to_char(nuQuotaNumber) || ']',
                       cnuNivelTrace + 4);
        pkg_traza.Trace('Valor cuota extra  -> [' ||
                       to_char(rcCuotExtr.cuexvalo) || ']');

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

    pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END LoadInstalments;

    /* -------------------------------------------------------------- */

  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    /* Limpia memoria de Cuotas Extras */
    pkAditionalPaymentMgr.ClearMemory;

    /* Si el diferido es de IVA, no se procesa */
    if (ichIVA = pkConstante.SI) then
      return;
    end if;

    /* Calcula el valor de cada cuota extra para el diferido de manera
    proporcional */
    LoadInstalments;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
  END FillAditionalInstalments;


--*******************************************************************************************
PROCEDURE GenerateBillingNote IS


nunotanume  notas.notanume%type;
csbMetodo VARCHAR2(100) := csbSP_NAME||'GenerateBillingNote';
nuError NUMBER;
sbError VARCHAR2(4000);

--Tipos de datos usados en el registro de las notas
rcNota       pkg_bcnotasrecord.tyrcNota;
tbCargos     pkg_bcnotasrecord.tytbCargos;

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	FA_BOBillingNotes.SetUpdateDataBaseFlag;
	pkg_error.setapplication(cc_boconstants.csbCUSTOMERCARE);

		--Informacíon de la nota
	rcNota.sbPrograma := 'CUSTOMER';  
	rcNota.nuProducto := nuServsusc;
	rcNota.nuCuencobr := nuCuenta;
	rcNota.nuNotacons := nunotacons; 
	rcNota.dtNotafeco := LDC_BOCONSGENERALES.FDTGETSYSDATE; 
	rcNota.sbNotaobse := sbObserv;
	rcNota.sbNotaToken:= pkBillConst.csbTOKEN_NOTA_DEBITO;

	--Información detalle de la nota
	tbCargos(1).nuProducto  := nuServsusc;
	tbCargos(1).nuContrato  := nuSuscripcion;
	tbCargos(1).nuCuencobr  := nuCuenta;
	tbCargos(1).nuConcepto  := nuConcepto;
	tbCargos(1).NuCausaCargo:= nuCausal; 
	tbCargos(1).nuValor     := nuValor;
	tbCargos(1).nuValorBase := null;
	tbCargos(1).sbSigno     := pkBillConst.DEBITO;
	tbCargos(1).sbAjustaCuenta := constants_per.CSBSI; 
	tbCargos(1).sbCargdoso  := pkBillConst.csbTOKEN_NOTA_DEBITO ||  nuCuenta;
	tbCargos(1).sbBalancePostivo := constants_per.CSBNO;
	tbCargos(1).boApruebaBal := FALSE;

	--Crea la nota con su detalle.          
	api_registranotaydetalle(ircNota           => rcNota,
							 itbCargos         => tbCargos,
							 onuNote           => nunotanume,--nota creada
							 onuCodigoError    => nuError,
							 osbMensajeError   => sbError
							);

	IF nuError = 0 THEN
		COMMIT;
	END IF;

  -- Se asigna numero de nota a variable de paquete
	nuNota := nunotanume;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END GenerateBillingNote;
--****************************************************************************************


 PROCEDURE GenerateDeferred (isbdifedoso diferido.difenudo%type) IS


    rcPlanDife    plandife%rowtype;

      nuDifeCofi           diferido.difecofi%type;
      nuQuotaMethod        plandife.pldimccd%type;
      nuTaincodi           plandife.plditain%type;
      nuInteRate           plandife.pldipoin%type;
      boSpread             boolean;
      nuPorcNomi      diferido.difeinte%type; -- Interes Nominal de Financ
	  nuPorcInte      diferido.difeinte%type; -- Interes de Financiacion
      nuSpread        diferido.difespre%type; -- Valor del Spread
      sbDocumento          cargos.cargdoso%type;
      nuFunctionaryId     funciona.funccodi%type;

      nuConcInteres   diferido.difecoin%type;
      /*sbProgram                 procesos.proccodi%type;*/
      SBFUNCIONA  funciona.funccodi%type;
	  
	csbMetodo VARCHAR2(100) := csbSP_NAME||'GenerateDeferred';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */


    FUNCTION fsbGetFuncionaDataBase RETURN funciona.funccodi%type IS

      sbUserDataBase funciona.funcusba%type;
      rcFunciona     funciona%rowtype;
	  csbMetodo1 VARCHAR2(100) := csbMetodo||'.fsbGetFuncionaDataBase';
		nuError NUMBER;
		sbError VARCHAR2(4000);


    BEGIN

	  pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      --Obtiene usuario de base de datos
      sbUserDataBase := pkgeneralservices.fsbGetUserName;

      --Obtiene record del funcionario asociado al usuario de la base de datos
      rcFunciona := pkbcfunciona.frcFunciona(sbUserDataBase);

      pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


      return rcFunciona.funccodi;

	EXCEPTION
			WHEN pkg_error.controlled_error THEN
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo1||' '||sbError);
				pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
				RAISE pkg_error.controlled_error;
			WHEN OTHERS THEN
				pkg_error.setError;
				pkg_error.getError(nuError, sbError);
				pkg_traza.trace(csbMetodo1||' '||sbError);
				pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
				RAISE pkg_error.controlled_error;
		END fsbGetFuncionaDataBase;
 ------------------------------------

BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

  --  Obtiene la informacion del plan de financiacion
    rcPlanDife := pktblPlandife.frcGetRecord(nuPlanFina);


   -- Se asigna el consecutivo de financiacion
     if nuCodFinanc = 0 then
        pkDeferredMgr.nuGetNextFincCode(nuDifeCofi);
        nuCodFinanc := nuDifeCofi;
     end if;


 -- Obtiene tasa de interes
    pkDeferredPlanMgr.ValPlanConfig(rcPlandife.pldicodi,
                                      sysdate, 
                                      nuQuotaMethod,
                                      nuTaincodi,
                                      nuInteRate,
                                      boSpread);



    nugPlan := nuPlanFina;

    if (nugMetodo is null) then
      -- Asigna metodo de calculo del Plan de financiacion
     nugMetodo := pktblplandife.fnugetpaymentmethod(nugPlan);
    end if;


    if (nugMetodo is null) then
      -- Asigna metodo de calculo por default
      nugMetodo := pktblParaFact.fnuGetPaymentMethod(pkConstante.SISTEMA);
    end if;



   -- Configura manejo de porcentaje de interes y el spread
    pkDeferredMgr.ValInterestSpread(nugMetodo,
                                    nugPorcInteres,
                                    nugSpread,
                                    nugPorIntNominal);

    -- Valida el Factor Gradiente

    pkDeferredMgr.ValGradiantFactor(nugPlan,
                                    nugMetodo,
                                    nvl(nugPorcInteres,0) + nvl(nugSpread,0),
                                    nuCuentas,
                                    nugFactor);


      dtgProceso := sysdate;
      nugSubscription := nuSuscripcion;

      -- Obtiene el Porcentaje de Recargo por Mora del plan
      GetOverChargePercent(nuPlanFina, nugPorcMora);

      --Obtiene el funcionario asociado al usuario de la base de datos
      sbFunciona := fsbGetFuncionaDataBase;




    nugNumServ     := nuServsusc;


    nugFinanCode := nuCodFinanc;

     -- Valida si el plan existe en BD

    nugTasaInte := pktblPlandife.fnuGetInterestRateCod(nuPlanFina);

    nuPorcNomi := pkBillConst.CERO;
          nuPorcInte := pkBillConst.CERO;
          nuSpread   := pkBillConst.CERO;

      nuConcInteres := pktblConcepto.fnuGetInterestConc(nuConcepto);

    -- Obtiene usuario y terminal
      sbgUser         := pkGeneralServices.fsbGetUserName;
      sbgTerminal     := pkGeneralServices.fsbGetTerminal;
      gnuPersonId     := PKG_BOPERSONAL.FNUGETPERSONAID;
      nuFunctionaryId := sbFunciona;

    -- Crea diferido para el ultimo concepto de financiacion procesado
    CreateDeferred(nuCodFinanc, -- Cod.Financiacion
                   nuSuscripcion,
                   nuConcepto, -- Concepto
                   nuValor, -- Valor
                   nuCuentas, -- Cuotas
                   isbdifedoso, -- sbDocumento, -- Doc -------------cual se va a poner
                   csbPROGRAMA, -- Programa
                   pkBillConst.CERO, -- nugPorIntNominal, -- inuPorIntNominal Lo obtiene valinputdata
                   pkConstante.NO, -- ichIVA --
                   nvl(nuInteRate/*nugPorcInteres*/,0), -- inuPorcInteres -- porcentaje de interes
                   nuTaincodi, -- inuTasaInte
                   nvl(nugSpread,0), -- inuSpread
                   nuConcInteres, -- inuConcInteres Lo obtiene a partir del concepto Origen
                   nuFunctionaryId,
                   'N', -- sbIsInterestConcept,
                   FALSE, -- blLastRecord,
                   pkConstante.NO); -- isbSimulate);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
END GenerateDeferred;
--****************************************************************************************

PROCEDURE CreateDeferred(inuFinanceCode        in diferido.difecofi%type,
                           inuSubscriptionId     in diferido.difesusc%type,
                           inuConc               in concepto.conccodi%type,
                           inuValor              in diferido.difevatd%type,
                           inuNumCuotas          in diferido.difenucu%type,
                           isbDocumento          in diferido.difenudo%type,
                           isbPrograma           in diferido.difeprog%type,
                           inuPorIntNominal      in diferido.difeinte%type,
                           ichIVA                in varchar2 default csbNO,
                           inuPorcInteres        in diferido.difeinte%type default NULL,
                           inuTasaInte           in diferido.difepldi%type default NULL,
                           inuSpread             in diferido.difespre%type default NULL,
                           inuConcInteres        in diferido.difecoin%type default NULL,
                           isbFunciona           in funciona.funccodi%type default NULL,
                           isbSrcConceptInterest in varchar2 default csbNO,
                           iblLastRecord         in boolean default FALSE,
                           isbSimulate           in varchar2 default pkConstante.SI --  Simular? (S|N)
                           ) IS

    nuFincCode         number; --codigo de financiacion.
    nuValorDife        diferido.difevatd%type; -- Valor diferido
    nuValorCuota       diferido.difevacu%type; -- Valor de la cuota
    nuConcInteres      concepto.conccodi%type; -- Concepto de Interes
    sbSignoDife        diferido.difesign%type; -- Signo diferido
    nuSgOper           number(1); -- Signo operacion acumulativa
    nuLocPorcInteres   diferido.difeinte%type; -- Porcentaje de interes
    nuLocPorIntNominal diferido.difeinte%type; -- Porcentaje Nominal
    nuLocTasaInte      diferido.difepldi%type; -- Codigo Tasa Interes
    nuLocSpread        diferido.difespre%type; -- Valor del Spread
    nuVlr              number;

    nuNumCuotas  diferido.difevacu%type; -- Numero de cuotas
    blAjuste     boolean;
    nuFactAjuste timoempr.tmemfaaj%type;

	csbMetodo VARCHAR2(100) := csbSP_NAME||'CreateDeferred';
	nuError NUMBER;
	sbError VARCHAR2(4000);


    /* -------------------------------------------------------------- */

    /*
    Procedure : FillDefMemTab
    Descripcion : Llena la Tabla de memoria de Diferidos
              Fill Deferred Memory Table
      */
    PROCEDURE FillDefMemTab IS
       rcDiferido diferido%rowtype; -- Record tabla diferido
      /*rcDeferred     mo_tyobdeferred;
      nuDeferredCode diferido.difecodi%type;*/
      nuSigno        number;
	  csbMetodo1 VARCHAR2(100) := csbMetodo||'.FillDefMemTab';
	  nuError NUMBER;
	  sbError VARCHAR2(4000);


    BEGIN
	
	  pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      pkg_traza.trace('Armando registro para diferido ' || nuIdxDife);
	  
      -- Arma record diferido
      rcDiferido.difecodi := nuIdxDife;
      rcDiferido.difesusc := nugSubscription;
      rcDiferido.difeconc := inuConc;
      rcDiferido.difevatd := nuValorDife;
      rcDiferido.difevacu := nuValorCuota;
      rcDiferido.difecupa :=  pkBillConst.CERO;
      rcDiferido.difenucu := nuNumCuotas;
      rcDiferido.difesape := nuValorDife;
      rcDiferido.difenudo := isbDocumento;
      rcDiferido.difeinte := nuLocPorcInteres;
      rcDiferido.difeinac := pkBillConst.CERO;
      rcDiferido.difeusua := sbgUser;
      rcDiferido.difeterm := sbgTerminal;
      rcDiferido.difesign := sbSignoDife;
      rcDiferido.difenuse := nugNumServ;
      rcDiferido.difemeca := nugMetodo;
      rcDiferido.difecoin := nuConcInteres;
      rcDiferido.difeprog := isbPrograma;
      rcDiferido.difepldi := nugPlan;
      rcDiferido.difetain := nuLocTasaInte;
      rcDiferido.difespre := nuLocSpread;
      rcDiferido.difefumo := dtgProceso;
      rcDiferido.difefein := dtgProceso;
      rcDiferido.difefagr := nugFactor;
      rcDiferido.difecofi := nuFincCode;
      rcDiferido.difelure := null;
      rcDiferido.difefunc := isbFunciona;
      rcDiferido.difetire := sbTipoDiferido;

      -- Adiciona diferido
      pktblDiferido.InsRecord(rcDiferido);

	  pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END FillDefMemTab;

    /* -------------------------------------------------------------- */
    /*
    Procedure : FillTransDefMemTab
    Descripcion : Llena la Tabla de memoria de Mvmto. Diferido
              Fill Transaction Deferred Memory Table
      */
    PROCEDURE FillTransDefMemTab IS
      /* Tipo de producto asociado al producto */
      nuProductType servicio.servcodi%type;

      /* Causa de cargo para el movimiento */
      nuChargeCause causcarg.cacacodi%type;

      rcMoviDife movidife%rowtype;
	  
	  csbMetodo1 VARCHAR2(100) := csbMetodo||'.FillTransDefMemTab';
	  nuError NUMBER;
	  sbError VARCHAR2(4000);

	  
    BEGIN

	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      /* Se obtiene el tipo de producto */
      nuProductType := PKG_BCPRODUCTO.FNUTIPOPRODUCTO(nugNumServ);

      /* Se obtiene causa de cargo para paso a diferido (43) */
      nuChargeCause := FA_BOChargeCauses.fnuDeferredChCause(nuProductType);

       -- Arma record de movimiento de diferido
      pkg_traza.trace('Armando registro de movimiento para el diferido ' ||
                     nuIdxDife);
      rcMoviDife.modidife := nuIdxDife;
      rcMoviDife.modisusc := inuSubscriptionId;
      rcMoviDife.modisign := sbSignoDife;
      rcMoviDife.modifeca := dtgProceso;
      rcMoviDife.modicuap := pkBillConst.CERO;
      rcMoviDife.modivacu := nuValorDife;
      rcMoviDife.modidoso := isbDocumento;
      rcMoviDife.modicaca := nuChargeCause;
      rcMoviDife.modifech := dtgProceso;
      rcMoviDife.modiusua := sbgUser;
      rcMoviDife.moditerm := sbgTerminal;
      rcMoviDife.modiprog := isbPrograma;
      rcMoviDife.modinuse := nugNumServ;
      rcMoviDife.modidiin := pkBillConst.CERO;
      rcMoviDife.modipoin := pkBillConst.CERO;
      rcMoviDife.modivain := pkBillConst.CERO;

      -- Adiciona movimiento diferido
      pktblMoviDife.InsRecord(rcMoviDife);

    pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo1||' '||sbError);
			pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END FillTransDefMemTab;

    /* -------------------------------------------------------------- */

  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    pkg_traza.Trace('(', cnuNivelTrace);

    pkg_traza.Trace('inuFinanceCode        = ' || inuFinanceCode);
    pkg_traza.Trace('inuConc               = ' || inuConc);
    pkg_traza.Trace('inuValor              = ' || inuValor);
    pkg_traza.Trace('isbDocumento          = ' || isbDocumento);
    pkg_traza.Trace('isbPrograma           = ' || isbPrograma);
    pkg_traza.Trace('inuPorIntNominal      = ' || inuPorIntNominal);
    pkg_traza.Trace('ichIVA                = ' || ichIVA);
    pkg_traza.Trace('inuPorcInteres        = ' || inuPorcInteres);
    pkg_traza.Trace('inuTasaInte           = ' || inuTasaInte);
    pkg_traza.Trace('inuSpread             = ' || inuSpread);
    pkg_traza.Trace('inuConcInteres        = ' || inuConcInteres);
    pkg_traza.Trace('isbFunciona           = ' || isbFunciona);
    pkg_traza.Trace('isbSrcConceptInterest = ' || isbSrcConceptInterest);

    if (iblLastRecord) then
      pkg_traza.Trace('iblLastRecord         = TRUE');
    else
      pkg_traza.Trace('iblLastRecord         = FALSE');
    end if;

    pkg_traza.Trace('isbSimulate           = ' || isbSimulate);

    pkg_traza.Trace(')');

     -- Obtiene proximo numero de diferido
      pkDeferredMgr.GetNewDefNumber(nuIdxDife);

      -- asigna el numero de diferido a variable de paquete
      nuDiferido := nuIdxDife;

    nuFincCode := inuFinanceCode;

    --Si el codigo de financiacion es null, se obtiene uno nuevo
    if (nvl(nuFincCode, pkBillConst.CERO) = pkBillConst.CERO) then
      pkDeferredMgr.nuGetNextFincCode(nuFincCode);
    end if;

    nugFinanCode := nuFincCode;
    ----------------------------------------------------------

    -- Averigua si se trata de un concepto de Interes
    if (nvl(isbSrcConceptInterest, csbNO) = csbYES) then
      --{
      pkg_traza.Trace('Se detecto concepto de interes, el interes para el diferido sera CERO');
      nuLocPorcInteres   := pkBillConst.CERO;
      nuLocTasaInte      := nugTasaInte;
      nuLocSpread        := pkBillConst.CERO;
      nuLocPorIntNominal := pkBillConst.CERO;
      --}
    else
      --{
      nuLocPorcInteres   := nvl(inuPorcInteres, nugPorcInteres);
      nuLocTasaInte      := nvl(inuTasaInte, nugTasaInte);
      nuLocSpread        := nvl(inuSpread, nugSpread);
      nuLocPorIntNominal := inuPorIntNominal;
      --}
    end if;

    -- Valor a diferir
    nuValorDife := abs(inuValor);

    -- Evalua si no hay valor a diferir
    if (nuValorDife = pkBillConst.CERO) then
      --{
      pkg_traza.Trace('Valor del diferido CERO, no sera creado');

      -- Como no crea diferido, actualiza la referencia de los cargos
      -- para que sea manejado mas adelante
    --  CC_BCFinancing.DeleteDeferredReference(nuIdxDife);
    

      return;
      --}
    end if;

    -- Establecer signo con el que se debe generar el diferido
    sbSignoDife := pkDeferredMgr.fsbGetDefSign(inuValor);

    -- Obtiene concepto de interes asociado al concepto
    -- solo si el parametro de concepto de interes es nulo
    if (inuConcInteres is NULL) then
      nuConcInteres := pktblConcepto.fnuGetInterestConc(inuConc);
    else
      nuConcInteres := inuConcInteres;
    end if;

    -- Valida el concepto de Interes
    ValInterestConcept(nuConcInteres);

    -- Determina el porcentaje de Interes de acuerdo al codigo del
    -- Concepto de Interes configurado
    if (nuConcInteres = pkBillConst.NULOSAT) then
      --{
      nuLocPorcInteres   := pkBillConst.CERO;
      nuLocTasaInte      := nugTasaInte;
      nuLocSpread        := pkBillConst.CERO;
      nuLocPorIntNominal := pkBillConst.CERO;
      --}
    end if;

    -- Adiciona cuotas extras a los diferidos que no corresponden
    -- a conceptos IVA
    FillAditionalInstalments(nuValorDife,
                             sbSignoDife,
                             ichIVA,
                             iblLastRecord);

    -- Se modifica DIFENUCU para valores menores al Valor Ajuste
    nuNumCuotas := inuNumCuotas;
    FA_BOPoliticaRedondeo.ObtienePoliticaAjuste(inuSubscriptionId,
                                                blAjuste,
                                                nuFactAjuste);

    if (nuValorDife <= nuFactAjuste) then
      nuNumCuotas  := 1;
      nuValorCuota := nuValorDife;
    end if;

    -- Calcula el valor de la cuota
    pkDeferredMgr.CalcPeriodPayment(nuValorDife,
                                    nuNumCuotas,
                                    nuLocPorIntNominal,
                                    nuLocPorcInteres,
                                    nuLocSpread,
                                    nugMetodo,
                                    nugFactor,
                                    nuValorCuota);

    pkg_traza.Trace('nuLocPorcInteres: ' || nuLocPorcInteres);
    pkg_traza.Trace('nuLocSpread: ' || nuLocSpread);
    pkg_traza.Trace('nugMetodo: ' || nugMetodo);
    pkg_traza.Trace('nugFactor: ' || nugFactor);
    pkg_traza.Trace('nuValorCuota: ' || nuValorCuota);
    pkg_traza.Trace('Diferido: ' || nuValorDife);

    -- Valida el valor de la cuota con respecto a los intereses de la
    -- primera cuota
    pkg_traza.Trace('Validando cuota < intereses primera cuota...');
    nuVlr := nuValorDife;

    pkg_traza.Trace('? Cuota < Primer Interes ? => ? ' || nuValorCuota ||
                   ' < ' || to_char(nuVlr * nuLocPorIntNominal /
                                    pkBillConst.CIENPORCIEN) || ' ?');
    pkDeferredMgr.ValPayment(nugMetodo,
                             nuLocPorIntNominal,
                             nuValorCuota,
                             nuVlr);

    /* Se aplica la politica de redondeo sobre el valor de la cuota */
    FA_BOPoliticaRedondeo.AplicaPolitica(nugNumServ, nuValorCuota);

    /*Se incluye esta modificacion para tener en cuenta los valores de
    cuotas que despues del redondeo son cero para que queden en una cuota */
    if (nuValorCuota = 0) then

      nuNumCuotas  := 1;
      nuValorCuota := nuValorDife;

    end if;

    -- Adiciona diferido a tabla en memoria
    FillDefMemTab;

    -- Actualiza acumuladores
    nuSgOper := pkBillConst.cnuSUMA_CARGO;

    -- Evalua si el signo del diferido es credito
    if (sbSignoDife = pkBillConst.CREDITO) then
      nuSgOper := pkBillConst.cnuRESTA_CARGO;
    end if;

    -- Acumula valor de la cuota
    nugAcumCuota := nugAcumCuota + (nuValorCuota * nuSgOper);

    -- Adiciona movimiento de diferido a tabla en memoria
    FillTransDefMemTab;


    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_error.getError(nuError, sbError);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;

  END CreateDeferred;
--****************************************************************************************
procedure pro_grabalog_ldcandm is
PRAGMA AUTONOMOUS_TRANSACTION;

csbMetodo VARCHAR2(100) := csbSP_NAME||'pro_grabalog_ldcandm';

begin

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


  insert into LDC_LOG_ERR_LDCANDM
    (fecha,
     archivo,
     linea,
     producto,
     concepto,
     causal,
     valor,
     nrocuotas,
     planfina,
     observacion,
     error)
  values
    (dtfechaproceso,
     sbFile,
     nuLinea,
     sbProducto,
     sbConcepto,
     sbCausal,
     sbValor,
     sbNucu,
     sbPlanFi,
     sbObse,
     sbLineLog);
   commit;
   
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

   
end pro_grabalog_ldcandm;
--****************************************************************************************
END LDC_PKGENAJUSMASI;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGENAJUSMASI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGENAJUSMASI', 'ADM_PERSON');
END;
/