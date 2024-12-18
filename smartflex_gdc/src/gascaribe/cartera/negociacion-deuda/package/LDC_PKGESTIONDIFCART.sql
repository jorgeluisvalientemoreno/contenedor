create or replace PACKAGE LDC_PKGESTIONDIFCART  IS
 /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

         PAQUETE : LDC_PKGESTIONDIFCART
         AUTOR   : LUIS JAVIER LOPEZ / HORBATH
         FECHA   : 2021-09-29
         DESCRIPCION : Paquete de gestión de cartera plan especial



    Historia de Modificaciones

    Fecha       Autor       Descripcion.
    29/09/2021  LJLB        Creacion del paquete
    23/08/2024  jcatuche    OSF-2974: Se ajustan los métodos
                                [PRGENEDESCADIFE]
                                [prInsertaPlanCartera]
                                
                            Se elimina el método prInicializaError. El llamado se hara con el método del paquete pkg_error
                            A nivel general se estandariza traza y gestión de errores
    07/10/2024  jcatuche    OSF-3396: Se ajusta el método
                                [PRGENEDESCADIFE]
************************************************************************/

   -- tabla de cargos
    TYPE rcCargos IS RECORD
    (
        nuCuenta       cargos.cargcuco%type,
        nuProducto     cargos.cargnuse%type,
        nuContrato     servsusc.sesususc%type,
        nufactura      cuencobr.cucofact%type,
        nuPeriodo      NUMBER,
        nuPericose     NUMBER,
        nuConcepto     cargos.cargconc%type,
        nuvalor        cargos.cargvalo%type,
        sbSigno        cargos.cargsign%type,
        nucausal       cargos.cargcaca%type,
        nuprograma     cargos.cargprog%type,
        nuPlanDife     plandife.PLDICODI%type,
        nuSolicitud    NUMBER
     );

	TYPE tbCargos IS TABLE OF rcCargos INDEX BY VARCHAR2(20);
	vtbCargos tbCargos;
	  
	sbIndicarg  VARCHAR2(20);
   
    -- tabla de planes
    TYPE rcPlandife IS RECORD
    (
        pldicumi       number(4),
        pldicuma       number(4),
        pldifefi       date,
        pldipegr       number(15),
        diaspegr       number(5),
        nuTaincodi     number,
        InteRate       number,
        nugMetodo      number,
        nugPorcInteres number,
        nugSpread      number,
        nugFactor      number,
        nugTasaInte    number
    );

    TYPE tbPlandife IS TABLE OF rcPlandife INDEX BY binary_integer;
    tPlandife tbPlandife;
    nuIndPlanDife binary_integer;
  
    csbYes             constant varchar2(1) := 'Y';
    csbNo              constant varchar2(1) := 'N';
  
    -- tabla de conceptos
    TYPE rcConcepto IS RECORD
    (
        conccore       number(5),
        conccoin       number(5)
    );

    TYPE tbConcepto IS TABLE OF rcConcepto INDEX BY binary_integer;
    tConcepto tbConcepto;
    nuIndConcepto binary_integer;
  
    PROCEDURE JOBPRREACCARTPLCAES;
    /**************************************************************************
    Proceso     : JOBPRREACCARTPLCAES
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que recativa cartera de plan especial

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prGeneraDescuento( inuDifecodi IN NUMBER,
                              inuConcepto IN NUMBER,
                              inuContrato IN NUMBER, 
                              inuProducto IN NUMBER, 
                              inuValorAplica IN NUMBER,
                              onuError OUT NUMBER,
                              osberror OUT VARCHAR2);
    /**************************************************************************
    Proceso     : prGeneraDescuento
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que genera descuento de diferido

    Parametros Entrada
     inuDifecodi   codigo del diferido
     inuConcepto   codigo del concepto
     inuContrato   codigo del contrato
     inuProducto   codigo del producto
     inuValorAplica  valor aplicar
     
    Parametros de salida
    onuError   codigo de error
    osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION  
    ***************************************************************************/
    PROCEDURE PRGENEDESCADIFE;
    /**************************************************************************
    Proceso     : PRGENEDESCADIFE
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que descuento de diferido

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

END LDC_PKGESTIONDIFCART;

/

create or replace PACKAGE body  LDC_PKGESTIONDIFCART  IS
    csbPROGRAMA  constant varchar2(20) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PROGGENDIFEPLES', NULL);
    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de función    
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;
    
    nuporctasames number; -- tasa mensual de interes de usura

    nuCuotasmax NUMBER;
    nuIdReporte         reportes.reponume%type;


    CURSOR cugetuserId is
    select user_id
    from sa_user
    where mask = user;

    nugUsuario sa_user.user_id%type;

    nugNumServ servsusc.sesunuse%type; -- Numero servicio
    nugPorcMora plandife.pldiprmo%type;
    nugSubscription suscripc.susccodi%type;
    nugMetodo number;
    nugPorcInteres number;
    nugSpread number;
    nugFactor number;
    nugTasaInte number;
    nugFunctionaryId     funciona.funccodi%type;

    gnuPersonId ge_person.person_id%type; -- Id de la persona
    -- Numero del Diferido Creado
    nuDiferido   diferido.difecodi%type;
    -- Numero de la Nota Creada
    nuNota   notas.notanume%type;
    sbgUser     varchar2(50); -- Nombre usuario
    sbgTerminal varchar2(50); -- Terminal
    dtgProceso     diferido.difefein%type; -- Fecha proceso
    nugPlan        plandife.pldicodi%type;
    sbTipoDiferido varchar2(1) := 'D'; -- OJO Crear parametro o utilizar
    nugAcumCuota   number; -- Acumulador Cuota
    nuCodFinanc      diferido.difecofi%type;
    nugChargeCause   number;
 

    /**************************************************************************
    Proceso     : prInsertaPlanCartera
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que inserta registro en ldc_soliprplcaes

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA           AUTOR       DESCRIPCION
    29/09/2021      LJLB        Creación
    23/08/2024      jcatuche    OSF-2974: Se realiza inserción con método inserta de PKG_LDC_SOLIPRPLCAES
    ***************************************************************************/
    PROCEDURE prInsertaPlanCartera(inuSolicitud IN NUMBER) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaPlanCartera';
    BEGIN 
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        PKG_LDC_SOLIPRPLCAES.prInsertaRegistro(inuSolicitud,'T');
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaPlanCartera;

 
 FUNCTION fnuCrReportHeader(isbaplicacion IN VARCHAR2, isbObservacion IN VARCHAR2)
    return number
    IS
      PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRecord Reportes%rowtype;
    BEGIN
    --{
        -- Fill record
        rcRecord.REPOAPLI := isbaplicacion;
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := ut_session.getTerminal;
        rcRecord.REPODESC := isbObservacion ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
        COMMIT;
        
        return rcRecord.Reponume;
    --}
    END;
    
 PROCEDURE crReportDetail(
        inuIdReporte    in repoinco.reinrepo%type,
        inuProduct      in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type,
        nuConsecutivo  IN NUMBER
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        -- Variables
        rcRepoinco repoinco%rowtype;
    BEGIN
    --{
      -- DBMS_OUTPUT.PUT_LINE(inuIdReporte||' nuConsecutivo '||nuConsecutivo||' isbError '||isbError);
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuProduct;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := nuConsecutivo;

        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);
        COMMIT;
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            RAISE pkg_Error.Controlled_Error;
    --}
    END;
 
 PROCEDURE prValiPlanDife( inuPlan IN NUMBER,                          
                             onuerror OUT NUMBER,
                             osberror OUT VARCHAR2						   
                             ) IS
  /**************************************************************************
  Proceso     : prValiPlanDife
  Autor       : LUIS JAVIER LOPEZ / HORBATH
  Fecha       : 2021-09-29
  Descripcion : proceso que valida plan diferido

  Parametros Entrada
    inuPlan  codigo del plan de diferido
  Parametros de salida
    onuerror  codigo de error
    osberror  mensaje de error
    
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/
 
	nunucumiplan   plandife.pldicumi%type;
	nunucumaplan   plandife.pldicuma%type;
	dtfecmaxplan   plandife.pldifefi%type;

	nuTaincodi           plandife.plditain%type;
	nuInteRate           plandife.pldipoin%type;
	boSpread             boolean;
	nuPorcNomi      diferido.difeinte%type; -- Interes Nominal de Financ
	nuPorcInte      diferido.difeinte%type; -- Interes de Financiacion
	nuSpread        diferido.difespre%type; -- Valor del Sp
	nugMetodo      diferido.difemeca%type; -- Metodo Cuota
	nugPlan        diferido.difepldi%type; -- Plan del Diferido
	nugFactor        diferido.difefagr%type; -- Factor Gradiente
	nugSpread      diferido.difespre%type; -- valor del Spread
	nugPorcInteres diferido.difeinte%type; -- Interes Efectivo
	nugPorIntNominal diferido.difeinte%type; -- Interes Nominal
	nugTasaInte diferido.difetain%type; -- Codigo Tasa Interes
  nuQuotaMethod        plandife.pldimccd%type;
  nucodpergracia    cc_grace_period.grace_period_id%type;
  nuDiasGracia      cc_grace_period.max_grace_days%type;
	
  cursor cuValPlanFina is
   select nvl(pldicumi,-1), nvl(pldicuma,-1), pldifefi, pldipegr,
   (select gp.max_grace_days
    from cc_grace_period gp
   where gp.grace_period_id = pldipegr) nuDiasGracia
	from plandife
   where pldicodi = inuPlan;
   
 BEGIN
   --inicializa error
    pkg_error.prInicializaError(onuError,osberror );
    
      --  dbms_output.put_line('inicio prValiPlanDife');
     open cuValPlanFina;
     fetch cuValPlanFina into nunucumiplan, nunucumaplan, dtfecmaxplan, nucodpergracia, nuDiasGracia;
     if cuValPlanFina%notfound then
        nunucumaplan := -1;
        nunucumiplan := -1;      
     end if;
     close cuValPlanFina;

     if nunucumaplan = -1 then
        onuError := -1;
        osberror := 'Plan de Financiacion ' || inuPlan || ' no existe';
        return;
     end if;

     if dtfecmaxplan < sysdate then
        onuError := -1;
        osberror := 'Plan de Financiacion ' ||inuPlan || ' no esta vigente';
        return;
     end if;

    -- Obtiene tasa de interes
    pkDeferredPlanMgr.ValPlanConfig(inuPlan,
                                    sysdate,
                                    nuQuotaMethod, --
                                    nuTaincodi,
                                    nuInteRate,
                                    boSpread); --

    if (nugMetodo is null) then
      -- Asigna metodo de calculo del Plan de financiacion
       nugMetodo := pktblplandife.fnugetpaymentmethod(inuPlan);
      -- DBMS_OUTPUT.PUT_LINE('METODO '||nugMetodo);
    end if;

   if (nugMetodo is null) then
      -- Asigna metodo de calculo por default
      nugMetodo := pktblParaFact.fnuGetPaymentMethod(pkConstante.SISTEMA);
     --  DBMS_OUTPUT.PUT_LINE('METODO '||nugMetodo);
    end if;

   -- Configura manejo de porcentaje de interes y el spread
    pkDeferredMgr.ValInterestSpread(nugMetodo,
                                    nugPorcInteres,
                                    nugSpread,
                                    nugPorIntNominal); --

    -- Valida el Factor Gradiente
    pkDeferredMgr.ValGradiantFactor(inuPlan,
                                    nugMetodo,
                                    nvl(nugPorcInteres,0) + nvl(nugSpread,0),
                                    nunucumaplan, -- nuCuotas,
                                    nugFactor);

    -- Obtiene el Porcentaje de Recargo por Mora del plan
    -- GetOverChargePercent(rg.planfina, nugPorcMora);

    nugTasaInte := pktblPlandife.fnuGetInterestRateCod(inuPlan);

    -- Guarda en tabla en memoria
     if not tPlandife.exists(inuPlan) then
       -- DBMS_OUTPUT.PUT_LINE('nucodpergracia '||nucodpergracia);
       -- DBMS_OUTPUT.PUT_LINE('nuDiasGracia '||nuDiasGracia);
        
        tPlandife(inuPlan).pldicumi := nunucumiplan;
        tPlandife(inuPlan).pldicuma := nunucumaplan;
        tPlandife(inuPlan).pldifefi := dtfecmaxplan;
        tPlandife(inuPlan).pldipegr := nucodpergracia;
        tPlandife(inuPlan).diaspegr := nuDiasGracia;
        tPlandife(inuPlan).nuTaincodi := nuTaincodi;
        tPlandife(inuPlan).InteRate := nuInteRate;
        tPlandife(inuPlan).nugMetodo := nugMetodo;
        tPlandife(inuPlan).nugPorcInteres := nugPorcInteres;
        tPlandife(inuPlan).nugSpread := nugSpread;
        tPlandife(inuPlan).nugFactor := nugFactor;
        tPlandife(inuPlan).nugTasaInte := nugTasaInte;
        nuCuotasmax := nunucumaplan;
     end if;
    --dbms_output.put_line('fin prValiPlanDife');
EXCEPTION
   when pkg_Error.Controlled_Error then
	   pkg_error.getError(onuError, osberror);
    when others then
        pkg_Error.setError;
        pkg_error.getError(onuError, osberror);
 END prValiPlanDife;
 PROCEDURE  prCargaConceptos (onuError out number ,
                              osberror out varchar2) is
 /**************************************************************************
  Proceso     : prCargaConceptos
  Autor       : LUIS JAVIER LOPEZ / HORBATH
  Fecha       : 2021-09-29
  Descripcion : proceso que carga conceptos 
  
  Parametros Entrada
  
  Parametros de salida
   onuError codigo de error 
   osberror  mensaje de error
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/

 cursor cuConceptos is
  select conccodi conce, conccore,conccoin
    from concepto
   where conccodi > 0;

  begin
    --inicializa error
    pkg_error.prInicializaError(onuError,osberror );
    
   for rg in cuConceptos loop
      if not tConcepto.exists(rg.conce) then
        tConcepto(rg.conce).conccore := rg.conccore;
        tConcepto(rg.conce).conccoin := rg.conccoin;
      end if;
   end loop;

exception
  when others then
    pkg_Error.setError;
    pkg_error.getError(onuError,osberror);  
 end prCargaConceptos;
 
  FUNCTION fsbGetFuncionaDataBase RETURN funciona.funccodi%type IS

      sbUserDataBase funciona.funcusba%type;
      rcFunciona     funciona%rowtype;

    BEGIN
      --{    
      --Obtiene usuario de base de datos
      sbUserDataBase := pkgeneralservices.fsbGetUserName;

      --Obtiene record del funcionario asociado al usuario de la base de datos
      rcFunciona := pkbcfunciona.frcFunciona(sbUserDataBase);

      return rcFunciona.funccodi;

  EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or
         pkg_Error.Controlled_Error then
         raise;

    when OTHERS then
      pkg_Error.setError;
      raise pkg_Error.Controlled_Error;
        --}
  END fsbGetFuncionaDataBase;

  PROCEDURE  prInsertaDiferido (inuFinanceCode        in diferido.difecofi%type,
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
                               isbSimulate           in varchar2 default pkConstante.SI, --  Simular? (S|N)
                               onuError              out number,
                               osberror              out varchar2) IS
    /**************************************************************************
      Proceso     : prInsertaDiferido
      Autor       : LUIS JAVIER LOPEZ / HORBATH
      Fecha       : 2021-09-29
      Descripcion : proceso que inserta diferidos
      
      Parametros Entrada
       
      Parametros de salida
       onuError codigo de error 
       osberror  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/

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

    nuIdxDife number; -- Indice de tabla de diferidos
    cnuNivelTrace constant number(2) := 5;

    nuNumCuotas  diferido.difevacu%type; -- Numero de cuotas
    blAjuste     boolean;
    nuFactAjuste timoempr.tmemfaaj%type;

   
    PROCEDURE prllenaTabMemDife IS
       rcDiferido diferido%rowtype; -- Record tabla diferido
      nuSigno        number;

    BEGIN
     
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
      rcDiferido.difecofi := inuFinanceCode;
      rcDiferido.difelure := null;
      rcDiferido.difefunc := isbFunciona;
      rcDiferido.difetire := sbTipoDiferido;
      


      -- Adiciona diferido
      pktblDiferido.InsRecord(rcDiferido);

    EXCEPTION
      when OTHERS then
        pkg_Error.setError;
        raise pkg_Error.Controlled_Error;
        --}
    END prllenaTabMemDife;

   
    PROCEDURE prllenaTabMemMoviDife IS
     
      rcMoviDife movidife%rowtype;
    BEGIN
     
      rcMoviDife.modidife := nuIdxDife;
      rcMoviDife.modisusc := inuSubscriptionId;
      rcMoviDife.modisign := sbSignoDife;
      rcMoviDife.modifeca := dtgProceso;
      rcMoviDife.modicuap := pkBillConst.CERO;
      rcMoviDife.modivacu := nuValorDife;
      rcMoviDife.modidoso := isbDocumento;
      rcMoviDife.modicaca := nugChargeCause;
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

    EXCEPTION

      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or
           pkg_Error.Controlled_Error then
           raise;

      when OTHERS then
        pkg_Error.setError;
        raise pkg_Error.Controlled_Error;
        --}
    END prllenaTabMemMoviDife;

  BEGIN
   --inicializa error
    pkg_error.prInicializaError(onuError,osberror );
 -- Obtiene proximo numero de diferido
    pkDeferredMgr.GetNewDefNumber(nuIdxDife);

 -- asigna el numero de diferido a variable de paquete
    nuDiferido := nuIdxDife;

    -- Averigua si se trata de un concepto de Interes
    if (nvl(isbSrcConceptInterest, csbNO) = csbYES) then
      --{
      pkg_traza.trace('Se detecto concepto de interes, el interes para el diferido sera CERO',
                     10);
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
      pkg_traza.trace('Valor del diferido CERO, no sera creado',
                     10);
      onuError := -1;
      osberror := 'Error en prInsertaDiferido: ' || ' Valor del diferido CERO, no sera creado';
      return;
      --}
    end if;

    -- Establecer signo con el que se debe generar el diferido
    sbSignoDife := pkDeferredMgr.fsbGetDefSign(inuValor);

    -- Obtiene concepto de interes asociado al concepto
    -- solo si el parametro de concepto de interes es nulo
      nuConcInteres := inuConcInteres;

    -- Valida el concepto de Interes
   ----------------------------- ValInterestConcept(nuConcInteres);

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
                                    
 

    -- Valida el valor de la cuota con respecto a los intereses de la
    -- primera cuota
    nuVlr := nuValorDife;

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
    prllenaTabMemDife;

    -- Actualiza acumuladores
    nuSgOper := pkBillConst.cnuSUMA_CARGO;

    -- Evalua si el signo del diferido es credito
    if (sbSignoDife = pkBillConst.CREDITO) then
      nuSgOper := pkBillConst.cnuRESTA_CARGO;
    end if;

    -- Acumula valor de la cuota
    nugAcumCuota := nugAcumCuota + (nuValorCuota * nuSgOper);

    -- Adiciona movimiento de diferido a tabla en memoria
    prllenaTabMemMoviDife;


  EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or pkg_Error.Controlled_Error then     
        pkg_error.getError(onuError,osberror);

    when OTHERS then
       pkg_Error.setError;
        pkg_error.getError(onuError,osberror);
       
  END prInsertaDiferido;


 PROCEDURE  prCreaDiferidos (inucontrato in number,
                              inuproducto in number,
                              inuconcepto in number,
                              inuplanfina in number,
                              inuvalor in number,
                              inucuotas in number,
                              isbdoso   in varchar2,
                              inuDifeCofi in number,
                              onuError  out number,
                              osberror out varchar2) is
  /**************************************************************************
  Proceso     : prCreaDiferidos
  Autor       : LUIS JAVIER LOPEZ / HORBATH
  Fecha       : 2021-09-29
  Descripcion : proceso que crea diferidos
  
  Parametros Entrada
   inucontrato   codigo del contrato
   inuproducto   codigo del producto
   inuconcepto   codigo del concepto
   inuplanfina   plan de financiacion
   inuvalor      valor
   inucuotas    cuotas
   isbdoso      documento
   inuDifeCofi  codigo de financiacion
   
  Parametros de salida
   onuError codigo de error 
   osberror  mensaje de error
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/

  sbUserDataBase funciona.funcusba%type;
  rcFunciona     funciona%rowtype;
  nuConcInteres   number;
 nuPrograma       cargos.cargprog%type := dald_parameter.fnugetnumeric_value('LDC_PROGDIPLES',NULL);
  nuTaincodi      number;
  nuInteRate      number;
  nuconadife  diferido.difeconc%type;
  nuDiasGrac      number;
  nucodpergr      number;
  nuGrace_peri_defe_id  cc_grace_peri_defe.grace_peri_defe_id%type;
  nucuotas number;
begin

  --inicializa error
  pkg_error.prInicializaError(onuError,osberror );

  nugNumServ      := inuproducto;
  nugSubscription := inucontrato;
  nugPlan         := inuplanfina;

  if tConcepto.exists(inuconcepto) then
     nuconadife := tConcepto(inuconcepto).conccore;
  else
     nuconadife := -1;
  end if;

  if nvl(nuconadife,-1) = -1 then
      nuconadife := inuconcepto;
      
  end if;

  if tConcepto.exists(nuconadife) then
    nuConcInteres := tConcepto(nuconadife).conccoin;
  end if;

   if tPlandife.exists(inuplanfina) then
     nucodpergr := tPlandife(inuplanfina).pldipegr;
      nuDiasGrac := tPlandife(inuplanfina).diaspegr;
      nuTaincodi := tPlandife(inuplanfina).nuTaincodi;
      nuInteRate := tPlandife(inuplanfina).InteRate;
      nugMetodo := tPlandife(inuplanfina).nugMetodo; --
      nugPorcInteres := tPlandife(inuplanfina).nugPorcInteres; --
      nugSpread := tPlandife(inuplanfina).nugSpread;
      nugFactor := tPlandife(inuplanfina).nugFactor;
      nugTasaInte := tPlandife(inuplanfina).nugTasaInte;
      nucuotas := tPlandife(inuplanfina).pldicuma;
      
   end if;

  nuCodFinanc := inuDifeCofi;
  --DBMS_OUTPUT.PUT_LINE(csbPROGRAMA);
  --crea diferido
  prInsertaDiferido(inuDifeCofi, -- Cod.Financiacion
                   inucontrato,
                   nuconadife, /*nuConcepto*/ -- Concepto
                   inuvalor, -- Valor
                   nucuotas, -- Cuotas
                   isbdoso, -- sbDocumento, -- Doc -------------cual se va a poner
                   csbPROGRAMA, -- Programa
                   nvl(nuporctasames,pkBillConst.CERO), -- nugPorIntNominal, -- inuPorIntNominal Lo obtiene valinputdata
                   pkConstante.NO, -- ichIVA --
                   nvl(nuInteRate/*nugPorcInteres*/,0), -- inuPorcInteres -- porcentaje de interes
                   nuTaincodi, -- inuTasaInte
                   nvl(nugSpread,0), -- inuSpread
                   nuConcInteres, -- inuConcInteres Lo obtiene a partir del concepto Origen
                   nugFunctionaryId,
                   'N', -- sbIsInterestConcept,
                   FALSE, -- blLastRecord,
                   pkConstante.NO,
                   onuError,
                   osberror ); -- isbSimulate);

    
    if onuError = 0 then
       -- si plan tiene dias de gracias inserta en la tabla cc_grace_peri_defe
       if nvl(nuDiasGrac,-1) > 0 then
          nuGrace_peri_defe_id := SEQ_CC_GRACE_PERI_D_185489.NEXTVAL;
          insert into cc_grace_peri_defe
                  (GRACE_PERI_DEFE_ID,
                  GRACE_PERIOD_ID,
                  DEFERRED_ID,
                  INITIAL_DATE,
                  END_DATE,
                  PROGRAM,
                  PERSON_ID)
           values (nuGrace_peri_defe_id,
                   nucodpergr,
                   nuDiferido,
                   sysdate,
                   trunc(sysdate) + nuDiasGrac,
                   nuPrograma,
                   gnuPersonId);
       end if;
    end if;
    
    if onuError <> 0 then
      return;
    end if;


exception 
  when pkg_Error.Controlled_Error then
     pkg_Error.setError;
	   pkg_error.getError(onuError, osberror);
  when others then
    pkg_Error.setError;
    pkg_error.getError(onuError,osberror);
  
end prCreaDiferidos;

 PROCEDURE prGeneraCuenta(inuProducto IN NUMBER, 
                            inuFactura   IN NUMBER,
                            onuCuenta  OUT NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
  /**************************************************************************
  Proceso     : prGeneraCuenta
  Autor       : LUIS JAVIER LOPEZ / HORBATH
  Fecha       : 2021-09-29
  Descripcion : Genera nueva cuenta

  Parametros Entrada
     inuProducto  codigo del producto
     inuFactura  codigo de la factura
     
  Parametros de salida
    onuCuenta cuenta de cobro
    onuError  codigo de error
    osbError  mensaje de error
    
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/
     rcProducto       servsusc%ROWTYPE;
	 
	 nuCliente      suscripc.suscclie%type; -- se almacena cliente
	nuSistema      NUMBER;
	nuTipoComp     factura.factcons%type;
	nufiscal       FACTURA.factnufi%TYPE;
	nuTipoComprobante NUMBER;

	sbPrefijo       FACTURA.factpref%TYPE;
	nuConsFisca     FACTURA.factconf%TYPE;

	-- se codigo del sistema
	CURSOR cuGetSistema IS
	SELECT SISTCODI
	FROM sistema;

	--se consulta tipo de comprobante de la factura
	CURSOR cuTipoComp IS
	SELECT factcons, suscclie
	FROM factura, suscripc
	WHERE factcodi = inuFactura
   and susccodi = factsusc;
		
 BEGIN
    pkg_error.prInicializaError(onuError,osberror );
     -- Se obtiene el consecutivo de la cuenta de cobro
    pkAccountMgr.GetNewAccountNum(onuCuenta);
  
    -- Se obtienen el record del producto
    rcProducto := pktblservsusc.frcgetrecord(inuProducto);
  
    -- Crea una nueva cuenta de cobro
    pkAccountMgr.AddNewRecord(inuFactura, onuCuenta, rcProducto);
    
    --procesa numeracion fiscal
    --se actualiza numero fiscal
    OPEN cuGetSistema;
    FETCH cuGetSistema INTO nuSistema;
    CLOSE cuGetSistema;
  
    OPEN cuTipoComp;
    FETCH cuTipoComp INTO nuTipoComp, nuCliente;
    CLOSE cuTipoComp;
  
    pkConsecutiveMgr.GetFiscalNumber(pkConsecutiveMgr.gcsbTOKENFACTURA,
                     inuFactura,
                     null,
                     nuTipoComp,
                     nuCliente,
                     nuSistema,
                     nufiscal,
                     sbPrefijo,
                     nuConsFisca,
                     nuTipoComprobante);
    -- Se actualiza la factura
    pktblFactura.UpFiscalNumber(inuFactura,
                                nufiscal,
                                nuTipoComp,
                                nuConsFisca,
                                sbPrefijo);

	--pkAccountStatusMgr.ProcesoNumeracionFiscal;
 EXCEPTION
   when pkg_Error.Controlled_Error then
         pkg_error.getError(onuError, osbError);
    when others then
        pkg_Error.setError;
        pkg_error.getError(onuError, osbError);
 END prGeneraCuenta;
                        

 PROCEDURE prGenerafactura( inuContrato IN NUMBER,                            
                            onuFactura OUT NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
 /**************************************************************************
  Proceso     : prGenerafactura
  Autor       : LUIS JAVIER LOPEZ / HORBATH
  Fecha       : 2021-09-29
  Descripcion : Genera nueva factura

  Parametros Entrada
     inuProducto  codigo del producto
     inuContrato  codigo del contrato
     
  Parametros de salida
    onuCuenta cuenta de cobro
    onuFactura  factura
    onuError  codigo de error
    osbError  mensaje de error
    
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/                           
   rcContrato       suscripc%ROWTYPE;

 BEGIN
    --pkErrors.SetApplication(csbPROGRAMA);
    
     -- Se obtiene numero de factura
    pkAccountStatusMgr.GetNewAccoStatusNum(onuFactura);
  
    --Se obtiene el record del contrato
    rcContrato := pktblSuscripc.frcGetRecord(inuContrato);
  
    -- Se crea la nueva factura
    pkAccountStatusMgr.AddNewRecord(onuFactura,
                                    2016/*pkGeneralServices.fnuIDProceso*/,
                                    rcContrato,
                                    GE_BOconstants.fnuGetDocTypeCons);
  
  
     
 EXCEPTION
   when pkg_Error.Controlled_Error then
         pkg_error.getError(onuError, osbError);
    when others then
        pkg_Error.setError;
        pkg_error.getError(onuError, osbError);
 END prGenerafactura;
 
 function  fnuActuSaldoCC  ( inucuenta    in cuencobr.cucocodi%type,
                           inuvlrnotas  in number,
                           onuError out number,
                          osbMsgError out varchar2 ) return varchar2 is

sbValido    varchar2(1);

sbInd       varchar2(12);
nucons      number(1) := 1;
nusaldocc   number :=0;
nuvalorabo  number :=0;

cursor cuCuenta is

  select sum(decode(cargsign,'CR',-cargvalo,'DB',cargvalo)) cucovato,
         sum(decode(cargsign,'PA',cargvalo, 'AS', cargvalo,'AP',-cargvalo)) cucovaab
    from OPEN.cargos
   where cargcuco= inucuenta
     and cargsign in ('DB','CR','PA','AS','AP');


BEGIN
 open cucuenta;
 fetch cucuenta into nusaldocc, nuvalorabo;
 if cucuenta%notfound then
    nusaldocc := 0;
    nuvalorabo := 0;
 end if;
 close cucuenta;

 if nvl(nusaldocc,0) - nvl(nuvalorabo,0) >= 0 then
   -- DBMS_OUTPUT.PUT_LINE('ingreso  inucuenta'||inucuenta||' saldo '||nusaldocc);
    update cuencobr
       set cucovato = nvl(nusaldocc,0)
     where cucocodi = inucuenta;
     sbValido := 'S';
 else
    sbValido := 'N';    
    osbMsgError := 'Valor total de las notas (' || inuvlrnotas || ') mayor al saldo conque quedaria la cuenta ('|| nusaldocc || ')';
 end if;

 return sbValido;

exception when others then
    pkg_Error.setError;
    pkg_error.getError(onuError,osbMsgError);
    osbMsgError := 'Error en fnuActuSaldoCC: '|| osbMsgError||sqlerrm;
    return ('N');
end fnuActuSaldoCC;
 

 PROCEDURE  prgeneraNotas  ( onuError OUT NUMBER, 
                            osberror out varchar2) is
 /**************************************************************************
  Proceso     : prgeneraNotas
  Autor       : LUIS JAVIER LOPEZ / HORBATH
  Fecha       : 2021-09-29
  Descripcion : proceso que genera notas y cargos
  
  Parametros Entrada 
   
  Parametros de salida
   onuError codigo de error 
   osberror  mensaje de error
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/	
  nucont number := 0;

	nunotanume  notas.notanume%type;
  nunotanumedb notas.notanume%type;
	nunota      notas.notanume%type;
	sbsigdocsop varchar2(3) := 'FD';
	sbsignota   varchar2(3) := 'CR';

	gnuTipoDocumento    ge_document_type.document_type_id%type := 71;
  gnuTipoDocumentoDb    ge_document_type.document_type_id%type := 70;
	sbErrMsg varchar2(2000) := null;
	sbMsgDife varchar2(2000) := null;
  nuPrograma       cargos.cargprog%type := dald_parameter.fnugetnumeric_value('LDC_PROGDIPLES',NULL);
	nusumanotas number :=0;

	rcCargoNull   cargos%rowtype;
	regNotas     NOTAS%ROWTYPE;
	rcCargo      cargos%rowtype ;
  rcCargoDb    cargos%rowtype ;
	nuErrDife    number;
	nuCuentaAnte number := -1;
	nuProductoAnte number := -1;
	nuPlanCrDfAnte number := -1;
	nuDifeCofi     diferido.difecofi%type;
	sbHayError    varchar2(1) := 'N';
	nuContratoAnte number := -1;
  nucauCarg    NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSCARGREAC', NULL);	
      
	cursor cuCuenta (inucuco cuencobr.cuconuse%type) is
	 select cucosacu
	   from cuencobr
	  where cucocodi=inucuco;
    
   
   sbSignoApli   VARCHAR2(40);
   nuValoraju NUMBER;
    SBFUNCIONA  funciona.funccodi%type;
	--nucauCarg    NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSCARGREAC', NULL);

BEGIN
  --inicializa error
  pkg_error.prInicializaError(onuError,osberror );
  
 -- DBMS_OUTPUT.PUT_line('prgeneraNotas INICIO ');
   pkg_traza.trace('prgeneraNotas INICIO ',10);
   -- Obtiene usuario y terminal
  sbgUser         := pkGeneralServices.fsbGetUserName;
  sbgTerminal     := pkGeneralServices.fsbGetTerminal;
  gnuPersonId     := GE_BOPersonal.fnuGetPersonId;
  dtgProceso      := sysdate;
  nugChargeCause  := 51;

   --Obtiene el funcionario asociado al usuario de la base de datos
   sbFunciona := fsbGetFuncionaDataBase;
   nugFunctionaryId := sbFunciona;
   
   open cugetuserId;
   fetch cugetuserId into nugUsuario;
   close cugetuserId;
   
  prCargaConceptos (onuError,
                    osberror) ;
  
  IF onuError <> 0 THEN
     RETURN;
  END IF;
 sbIndicarg  :=  vtbCargos.first;
 
 --DBMS_OUTPUT.PUT_line('cantidad a procesar '||vtbCargos.count||' sbIndicarg '||sbIndicarg);
 loop
   exit when (sbIndicarg IS null);
      if nuCuentaAnte != vtbCargos(sbIndicarg).nucuenta then        
         if nuCuentaAnte != -1 and nusumanotas > 0 then       
            -- DBMS_OUTPUT.PUT_LINE(' nuProductoAnte'||nuProductoAnte);
               -- Genera ajuste sobre la cuenta de cobro              
            if  fnuActuSaldoCC( nucuentaante, nusumanotas, onuError,osberror)= 'N' then
             --  DBMS_OUTPUT.PUT_LINE(' fnuActuSaldoCC error '||nuCuentaAnte||' nusumanotas '||nusumanotas||' osberror '||osberror);
              sbHayError := 'S';
              ----nusumanotas := 0;
              rollback;
              exit;
            
            end if;
             
         end if;
         PKBILLINGNOTEMGR.GETNEWNOTENUMBER(nunotanume);
         regNotas.NOTANUME := nunotanume ;
         regNotas.NOTASUSC := vtbCargos(sbIndicarg).nuContrato ;
         regNotas.NOTAFACT := vtbCargos(sbIndicarg).nufactura ;
         regNotas.NOTATINO := 'C' ;
         regNotas.NOTAFECO := SYSDATE ;
         regNotas.NOTAFECR := SYSDATE ;
         regNotas.NOTAPROG := nuPrograma ;
         regNotas.NOTAUSUA := 1/*nugUsuario*/ ;
         regNotas.NOTATERM := sbgTerminal;
         regNotas.NOTACONS := 71;
         regNotas.NOTANUFI := NULL;
         regNotas.NOTAPREF := NULL;
         regNotas.NOTACONF := NULL;
         regNotas.NOTAIDPR := NULL;
         regNotas.NOTACOAE := NULL;
         regNotas.NOTAFEEC := NULL;
         regNotas.NOTAOBSE := 'GENERACION DE NOTA POR REACTIVACION DE DEUDA PLAN DE CARTERA ESPECIAL' ;
         regNotas.NOTADOCU := NULL ;
         regNotas.NOTADOSO := 'NC-' || nunotanume ;
         PKTBLNOTAS.INSRECORD(regNotas);
         
         PKBILLINGNOTEMGR.GETNEWNOTENUMBER(nunotanumedb);
         regNotas.NOTANUME := nunotanumedb ;
         regNotas.NOTASUSC := vtbCargos(sbIndicarg).nuContrato ;
         regNotas.NOTAFACT := vtbCargos(sbIndicarg).nufactura ;
         regNotas.NOTATINO := 'D' ;
         regNotas.NOTAFECO := SYSDATE ;
         regNotas.NOTAFECR := SYSDATE ;
         regNotas.NOTAPROG := nuPrograma ;
         regNotas.NOTAUSUA := 1 ;
         regNotas.NOTATERM := sbgTerminal;
         regNotas.NOTACONS := 70;
         regNotas.NOTANUFI := NULL;
         regNotas.NOTAPREF := NULL;
         regNotas.NOTACONF := NULL;
         regNotas.NOTAIDPR := NULL;
         regNotas.NOTACOAE := NULL;
         regNotas.NOTAFEEC := NULL;
         regNotas.NOTAOBSE := 'GENERACION DE NOTA POR REACTIVACION DE DEUDA PLAN DE CARTERA ESPECIAL' ;
         regNotas.NOTADOCU := NULL ;
         regNotas.NOTADOSO := 'ND-' || nunotanumedb ;
         PKTBLNOTAS.INSRECORD(regNotas);
    
        nuCuentaAnte := vtbCargos(sbIndicarg).nucuenta;
        nusumanotas := 0;
         prInsertaPlanCartera(vtbCargos(sbIndicarg).nuSolicitud); 
   end if;

   if sbHayError = 'N' then
   
     rcCargoDb := rcCargoNull ;
     rcCargoDb.cargcuco := vtbCargos(sbIndicarg).nuCuenta;
     rcCargoDb.cargnuse := vtbCargos(sbIndicarg).nuProducto ;
     rcCargoDb.cargpefa := vtbCargos(sbIndicarg).nuperiodo;
     rcCargoDb.cargconc := vtbCargos(sbIndicarg).nuConcepto ;
     rcCargoDb.cargcaca := nucauCarg/*vtbCargos(sbIndicarg).nucausal*/;
     rcCargoDb.cargsign := 'DB' ; -- CR
     rcCargoDb.cargvalo := vtbCargos(sbIndicarg).nuvalor ;
     rcCargoDb.cargtipr := 'P'/* pkBillConst.AUTOMATICO*/;
     rcCargoDb.cargfecr := SYSDATE ;
     rcCargoDb.cargcodo := nunotanumedb; --  DEBE SER  numero de la nota
     rcCargoDb.cargunid := 0 ;
     rcCargoDb.cargcoll := null ;
     rcCargoDb.cargpeco := vtbCargos(sbIndicarg).nuPericose; -- nuPeriCons ;
     rcCargoDb.cargprog := nuPrograma; --
     rcCargoDb.cargusua := 1;
     
     
     rcCargo := rcCargoNull ;
     rcCargo.cargcuco := vtbCargos(sbIndicarg).nuCuenta;
     rcCargo.cargnuse := vtbCargos(sbIndicarg).nuProducto ;
     rcCargo.cargpefa := vtbCargos(sbIndicarg).nuperiodo;
     rcCargo.cargconc := vtbCargos(sbIndicarg).nuConcepto ;
     rcCargo.cargcaca := vtbCargos(sbIndicarg).nucausal;
     rcCargo.cargsign := vtbCargos(sbIndicarg).sbSigno ; -- CR
     rcCargo.cargvalo := vtbCargos(sbIndicarg).nuvalor ;
     rcCargo.cargtipr := 'P'/* pkBillConst.AUTOMATICO*/;
     rcCargo.cargfecr := SYSDATE ;
     rcCargo.cargcodo := nunotanume; --  DEBE SER  numero de la nota
     rcCargo.cargunid := 0 ;
     rcCargo.cargcoll := null ;
     rcCargo.cargpeco := vtbCargos(sbIndicarg).nuPericose; -- nuPeriCons ;
     rcCargo.cargprog := nuPrograma; --
     rcCargo.cargusua := 1;
     
    

     nusumanotas := nusumanotas + vtbCargos(sbIndicarg).nuvalor;

     if nuProductoAnte != vtbCargos(sbIndicarg).nuProducto   then
    -- Se asigna el consecutivo de financiacion
        pkDeferredMgr.nuGetNextFincCode(nuDifeCofi);
        nuProductoAnte := vtbCargos(sbIndicarg).nuProducto;
       
     end if;
     -- crea el diferido
      prCreaDiferidos (vtbCargos(sbIndicarg).nucontrato,
                       vtbCargos(sbIndicarg).nuproducto,
                       vtbCargos(sbIndicarg).nuconcepto,
                       vtbCargos(sbIndicarg).nuPlanDife,
                       vtbCargos(sbIndicarg).nuvalor,
                       nuCuotasmax,
                       'ND-'||nunotanume,
                       nuDifeCofi,
                       onuError,
                       osberror);

     if osberror is not null then
        return;
     else
        rcCargo.cargdoso := 'FD-' || nuDiferido;
        rcCargoDb.cargdoso := 'FD-' || nuDiferido;
        -- Adiciona el Cargo
        pktblCargos.InsRecord (rcCargo);
        
       /* DBMS_OUTPUT.PUT_LINE(' ajusta la cuenta cr'||vtbCargos(sbIndicarg).nuCuenta);
         -- Ajusta la Cuenta
         PKUPDACCORECEIV.UPDACCOREC
          (
              PKBILLCONST.CNUSUMA_CARGO,
              vtbCargos(sbIndicarg).nuCuenta,
              vtbCargos(sbIndicarg).nucontrato,
              vtbCargos(sbIndicarg).nuProducto,             
              vtbCargos(sbIndicarg).nuconcepto,
              vtbCargos(sbIndicarg).sbSigno,
              vtbCargos(sbIndicarg).nuvalor,
              pkBillConst.cnuUPDATE_DB
          );*/
         -- Adiciona el Cargo DB
        pktblCargos.InsRecord (rcCargoDb);
        
       /*  DBMS_OUTPUT.PUT_LINE(' ajusta la cuenta db '||nuCuentaAnte);
        -- Ajusta la Cuenta
         PKUPDACCORECEIV.UPDACCOREC
          (
              PKBILLCONST.CNUSUMA_CARGO,
              nuCuentaAnte,
              vtbCargos(sbIndicarg).nucontrato,
              vtbCargos(sbIndicarg).nuProducto,              
              vtbCargos(sbIndicarg).nuconcepto,
              'DB',
              vtbCargos(sbIndicarg).nuvalor,
              pkBillConst.cnuUPDATE_DB
          );*/
         
     end if;


   end if;

   sbIndicarg := vtbCargos.next(sbIndicarg);
   nucont := nucont + 1;
 end loop;

  if nusumanotas > 0 AND onuError = 0  then
  --  DBMS_OUTPUT.PUT_LINE(' fnuActuSaldoCC '||nuCuentaAnte||' nusumanotas '||nusumanotas);
   if fnuActuSaldoCC( nucuentaante, nusumanotas, onuError,osberror) = 'N' then
      return;
     --commit;
   
   end if;
 end if;
   pkg_traza.trace('prgeneraNotas FIN ',10);

 exception
  when others then
    pkg_Error.setError;
    pkg_error.getError(onuError,osberror);
     pkg_traza.trace('prgeneraNotas FIN ERROR '||osberror,10);
end prgeneraNotas;
 
    PROCEDURE JOBPRREACCARTPLCAES IS
    /**************************************************************************
    Proceso     : JOBPRREACCARTPLCAES
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que recativa cartera de plan especial

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA      AUTOR              DESCRIPCION
    23/02/2022 cgonzalez horbath  2022020540 Se adiciona anulacion de solicitudes
                                que se encuentren abiertas para el dia del cierre de mes
    ***************************************************************************/
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'JOBPRREACCARTPLCAES';

        nuDias number :=  DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUMDIAVALNEGO', NULL);
        nucauCarg    NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSCARGREAC', NULL);
        sbCausalDescu  VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CAUSCARGDESC', NULL);
     
     
        --se consulta cuentas con saldo
        CURSOR cugetSolicitudes IS
        SELECT s.PACKAGE_ID, COPCDEST plancart, COPCORIG planorig, M.SUBSCRIPTION_ID contrato
        FROM OPEN.mo_packages s, open.GC_DEBT_NEGOTIATION F, open.LDC_CONFPLCAES, open.mo_motive m
        WHERE  M.PACKAGE_ID = S.PACKAGE_ID
         AND S.PACKAGE_TYPE_ID = 328
        AND s.motive_status_id = 14 
        AND s.request_date >= TRUNC(SYSDATE) - nuDias  
        AND s.package_id =  F.package_id  
        AND f.PAYM_AGREEM_PLAN_ID = COPCORIG
        AND NOT EXISTS ( SELECT 1
                         FROM open.LDC_SOLIPRPLCAES 
                         WHERE solicitud = s.PACKAGE_ID
                          AND estado in ('T','F'))
        order by M.SUBSCRIPTION_ID  
        /* SELECT s.PACKAGE_ID, COPCDEST plancart, COPCORIG planorig, SUBSCRIPTION_ID contrato
        FROM OPEN.mo_packages s, open.CC_FINANCING_REQUEST f, LDC_CONFPLCAES
        WHERE motive_status_id = 14 
        AND request_date >= TRUNC(SYSDATE) - nuDias  
        -- AND s.package_id in (127192542, 127192187, 127192910, 127218982)
        AND s.package_id =  F.package_id  
        AND FINANCING_PLAN_ID = COPCORIG
        AND NOT EXISTS ( SELECT 1
                         FROM LDC_SOLIPRPLCAES 
                         WHERE solicitud = s.PACKAGE_ID
                          AND estado = 'T')
        order by SUBSCRIPTION_ID*/;
        
        TYPE tbSolicitudes IS TABLE OF cugetSolicitudes%rowtype ;
        vtbSolicitudes  tbSolicitudes;

        --se consultan saldo de conceptos
        CURSOR cuSaldoPorConcepto( inuSolicitud IN NUMBER, inuplan NUMBER ) IS
        select C.CARGNUSE sesunuse, 
           sesucicl,
           sesususc,
           C.CARGCONC concepto, 
          -- abs(sum(DECODE(C.CARGSIGN, 'DB', C.CARGVALO, -C.CARGVALO))) valor,
           sum(cargvalo) valor
        from notas, cargos c, cuencobr, servsusc
        where NOTAOBSE = 'NG-'||inuSolicitud
         and cucofact = notafact
         and cargcuco = cucocodi
         and cargcodo = notanume 
         AND cargnuse = sesunuse
         AND CARGCACA in (SELECT to_number(regexp_substr(sbCausalDescu,'[^,]+', 1, LEVEL)) AS causal
                           FROM dual
                           CONNECT BY regexp_substr(sbCausalDescu, '[^,]+', 1, LEVEL) IS NOT NULL)
        and CARGCONC IN  (select CDPFconc
                         from OPEN.CODEPLFI
                         where CDPFPLDI = inuplan)
        AND CARGSIGN = 'CR'
        group by C.CARGNUSE, C.CARGCONC,  sesucicl, sesususc
        order by sesususc, CARGNUSE;
            
        --2022020540 - Obtener solicitudes en estado registrado
        CURSOR cuSolicitudesRegistradas IS
            SELECT  s.package_id
            FROM    open.mo_packages s, open.gc_debt_negotiation f, open.ldc_confplcaes
            WHERE   s.package_type_id = 328
            AND     s.motive_status_id in (-2,13,36,47,48,49)
            AND     s.request_date >= trunc(sysdate) - nuDias  
            AND     s.package_id = f.package_id  
            AND     f.paym_agreem_plan_id = copcorig;
            
        TYPE tytbSolicitudesRegistradas IS TABLE OF cuSolicitudesRegistradas%rowtype INDEX BY BINARY_INTEGER;
        tbSolicitudesRegistradas  tytbSolicitudesRegistradas;

        CURSOR cuFechaCierre(inuAno in number, inuMes in number) IS
            SELECT  cicofech
            FROM    ldc_ciercome
            WHERE   cicoano = inuAno
            AND     cicomes = inuMes;

        dtFechaCierre date;

        nuIdx BINARY_INTEGER;
          
        nuSaldoCuen NUMBER := 0;
        nusaldoConc  NUMBER := 0;

        nuPeriodo perifact.pefacodi%TYPE;
        dtFechIni perifact.pefaFIMO%type;
        dtFechFin perifact.pefaFFMO%type;
        nuciclo   NUMBER := -1;
        nuPerioCons NUMBER;
      
        CURSOR cuPeriofact IS
        select pefacodi, pefaFIMO, pefaFFMO
        from perifact 
        where pefacicl= nuciclo 
          and pefaactu='S';
          
        cursor cuPericose  is
        select pc.pecscons
        from  pericose pc
        where pc.pecsfecf between dtFechIni and dtFechFin
        and pc.pecscico = nuciclo;


        nuImpues NUMBER; 
         nuconsec number := 0;
        onuerror NUMBER;
        osberror varchar2(4000);
        nuproductoante NUMBER := -1;
        nuContratoante NUMBER := -1;
        nuCuenta NUMBER;
        nuFactura Number;
        nuProducto NUMBER;
        nuparano   NUMBER;
        nuparmes   NUMBER;
        nutsess    NUMBER;
        sbparuser  VARCHAR2(4000);
        nuConsecutivo NUMBER := 0;
        nuPrograma       cargos.cargprog%type := dald_parameter.fnugetnumeric_value('LDC_PROGDIPLES',NULL);
        nuCodigoPlan NUMBER;		--codigo de financiacion
        nusolicitud number;
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        vtbCargos.delete;
        tPlandife.delete;
        tConcepto.delete;
 
        -- Consultamos datos para inicializar el proceso
        SELECT to_number(to_char(SYSDATE,'YYYY'))
         ,to_number(to_char(SYSDATE,'MM'))
         ,userenv('SESSIONID')
         ,USER INTO nuparano,nuparmes,nutsess,sbparuser
        FROM dual;

        -- Inicializamos el proceso
        ldc_proinsertaestaprog(nuparano,nuparmes,'JOBPRREACCARTPLCAES','En ejecucion',nutsess,sbparuser); 
        --se adiciona reporte 
        nuIdReporte :=  fnuCrReportHeader('LOGDIPLCES', 'INCONSISTENCIAS EN EL PROCESO DE REACTIVACION CARTERA PLAN ESPECIAL');   

        pkErrors.SetApplication(csbPROGRAMA);
        --Se cargan conceptos 
        --OPEN cugetSolicitudes;
        --LOOP
         -- FETCH cugetSolicitudes  BULK COLLECT INTO vtbSolicitudes limit 100;            
           -- FOR idx IN 1..vtbSolicitudes.COUNT LOOP		              
        FOR regInt IN   cugetSolicitudes LOOP      
            --  DBMS_OUTPUT.PUT_LINE('porcesando soli '||vtbSolicitudes(idx).PACKAGE_ID ||' vtbSolicitudes(idx).contrato '||vtbSolicitudes(idx).contrato);
            FOR reg IN cuSaldoPorConcepto(regInt.PACKAGE_ID, regInt.planorig) LOOP  
                   nuconsec := nuconsec+ 1;
                   onuerror := 0;
                   osberror := null;            
                   --  DBMS_OUTPUT.PUT_LINE(' nuconsec'||nuconsec);
                  IF nuciclo <> reg.sesucicl THEN
                     nuciclo := reg.sesucicl;
                     nuPeriodo := NULL;
                     dtFechIni := NULL;
                     dtFechFin := NULL;
                       
                     IF cuPeriofact%isopen THEN
                        CLOSE cuPeriofact;
                     END IF;
                   
                     IF cuPericose%isopen THEN
                        CLOSE cuPericose;
                     END IF;
                        
                     OPEN cuPeriofact;
                     FETCH cuPeriofact INTO nuPeriodo, dtFechIni, dtFechFin;
                     IF cuPeriofact%NOTFOUND THEN
                        CLOSE cuPeriofact;
                        onuerror := -1;
                        osberror := 'Producto ['||reg.sesunuse||'] no tiene periodo de facturacion vigente';
                        nuConsecutivo := nuConsecutivo +1;                   
                        crReportDetail(nuIdReporte,reg.sesunuse,osberror, 'S', nuConsecutivo);
                         ROLLBACK;
                         exit;
                     END IF;
                     CLOSE cuPeriofact;
                     
                     IF dtFechFin < SYSDATE THEN
                         onuerror := -1;
                        osberror := 'Producto ['||reg.sesunuse||'] tiene periodo de facturacion activo pero no vigente';
                        nuConsecutivo := nuConsecutivo +1;                   
                        crReportDetail(nuIdReporte,reg.sesunuse,osberror, 'S', nuConsecutivo);
                         ROLLBACK;
                          exit;
                     END IF;
                        
                     OPEN cuPericose;
                     FETCH cuPericose INTO nuPerioCons;
                     IF cuPericose%NOTFOUND THEN
                        CLOSE cuPericose;
                         onuerror := -1;
                        osberror := 'Producto ['||reg.sesunuse||'] no tiene periodo de consumo vigente';
                         nuConsecutivo := nuConsecutivo +1;                   
                         crReportDetail(nuIdReporte,reg.sesunuse,osberror, 'S', nuConsecutivo);
                          ROLLBACK;
                       exit;
                     END IF;
                     CLOSE cuPericose;
                     
                  END IF;
                  IF nuContratoante <> regInt.contrato THEN                             
                       --DBMS_OUTPUT.PUT_LINE(' nuContratoante ' || nuContratoante||' nuCodigoPlan '||nuCodigoPlan);  
                       nuFactura := null; 
                      IF nuContratoante <> -1 AND vtbCargos.COUNT > 0 THEN                      
                         --se generan notas y diferidos
                          prgeneraNotas(onuerror,osberror);                        
                          IF onuerror <> 0 THEN
                             nuConsecutivo := nuConsecutivo +1;
                             osberror := substr(osberror,1,1999);
                             crReportDetail(nuIdReporte,nuContratoante,osberror, 'S', nuConsecutivo);  
                             -- DBMS_OUTPUT.PUT_LINE(' error nusolicitud' || nusolicitud);
                             vtbCargos.delete;
                             ROLLBACK;
                              nuconsec := 0;
                             CONTINUE;
                          ELSE    
                           --DBMS_OUTPUT.PUT_LINE(' proceso nusolicitud' || nusolicitud);
                           -- prInsertaPlanCartera(nusolicitud);        
                            COMMIT;	
                            vtbCargos.delete;
                            nuconsec := 0;
                          END IF;   
                        
                      END IF;	 
                     prGenerafactura( regInt.contrato ,
                                      nuFactura,
                                      onuerror,
                                      osberror) ;
                                      
                     IF onuerror <> 0 THEN
                        nuConsecutivo := nuConsecutivo +1;
                        osberror := substr(osberror,1,1999);
                        crReportDetail(nuIdReporte,regInt.contrato ,osberror, 'S', nuConsecutivo);
                        ROLLBACK;
                        exit;
                     END IF;
                     nuContratoante :=regInt.contrato ;                
                  END IF;
                  
                  IF nuproductoante <> reg.sesunuse THEN      
                      nuCodigoPlan  := regInt.plancart;    
                      nuproductoante := reg.sesunuse;                   
                       nusolicitud := regInt.PACKAGE_ID;      
                       --validar plan de diferido
                       prValiPlanDife( nuCodigoPlan,                          
                                         onuerror,
                                         osberror );  
                       IF onuerror =  0 THEN                     
                           prGeneracuenta( nuproductoante,
                                           nuFactura,
                                           nuCuenta,
                                           onuerror,
                                           osberror) ;
                                    
                           IF onuerror <> 0 THEN
                              nuConsecutivo := nuConsecutivo +1;
                              osberror := substr(osberror,1,1999);
                              crReportDetail(nuIdReporte,nuproductoante,osberror, 'S', nuConsecutivo);
                              ROLLBACK;
                              EXIT;
                          END IF;
                       else
                             nuConsecutivo := nuConsecutivo +1;
                             osberror := substr(osberror,1,1999);
                             crReportDetail(nuIdReporte,nuContratoante,osberror, 'S', nuConsecutivo);  
                             vtbCargos.delete; 
                             ROLLBACK;
                             EXIT;  
                        END IF;
                       -- DBMS_OUTPUT.PUT_LINE(' nuproductoante '||nuproductoante ||' nuCodigoPlan '||nuCodigoPlan);
                                  
                  END IF;
                  sbIndicarg := lpad(reg.sesususc,8,'0') || lpad(nuconsec,4,'0');
                  nusaldoConc := reg.valor;
                 
                 vtbCargos(sbIndicarg).nuCuenta    :=  nuCuenta; 
                 vtbCargos(sbIndicarg).nuProducto  :=  reg.sesunuse;
                 vtbCargos(sbIndicarg).nuContrato  :=  reg.sesususc;
                 vtbCargos(sbIndicarg).nufactura   :=  nuFactura;
                 vtbCargos(sbIndicarg).nuPeriodo   :=  nuPeriodo;
                 vtbCargos(sbIndicarg).nuPericose  :=  nuPerioCons;
                 vtbCargos(sbIndicarg).nuConcepto  :=  reg.concepto;
                 vtbCargos(sbIndicarg).nuvalor     :=  reg.valor;
                 vtbCargos(sbIndicarg).sbSigno     :=  'CR';
                 vtbCargos(sbIndicarg).nucausal    :=  50/*nucauCarg*/;
                 vtbCargos(sbIndicarg).nuprograma  := nuprograma;	  
                 vtbCargos(sbIndicarg).nuPlanDife  := nuCodigoPlan;	  
                 vtbCargos(sbIndicarg).nuSolicitud  := nusolicitud;	  
                 
                  -- DBMS_OUTPUT.PUT_LINE('nuFactura '||nuFactura||' nuCuenta '||nuCuenta||' concepto '||reg.concepto||' valor '||reg.valor);
            END LOOP;
        END LOOP;
        -- EXIT WHEN cugetSolicitudes%NOTFOUND;
        --END LOOP;
        --CLOSE cugetSolicitudes; 
       
        IF nuContratoante <> -1 AND vtbCargos.COUNT > 0 THEN                                    
           --validar plan de diferido
          /* prValiPlanDife( nuCodigoPlan,                          
                             onuerror,
                             osberror );
           IF onuerror =  0 THEN   */
              --se generan notas y diferidos
              prgeneraNotas(onuerror,osberror);                        
              IF onuerror <> 0 THEN
                 nuConsecutivo := nuConsecutivo +1;
                 osberror := substr(osberror,1,1999);
                 crReportDetail(nuIdReporte,nuproductoante,osberror, 'S', nuConsecutivo);  
                  vtbCargos.delete;
                 ROLLBACK;
              ELSE                   				 
                --prInsertaPlanCartera(nusolicitud);    
               -- DBMS_OUTPUT.PUT_LINE(' proceso nusolicitud '||nusolicitud);
               COMMIT;	
                vtbCargos.delete;
              END IF;
          /*ELSE
             nuConsecutivo := nuConsecutivo +1;
             osberror := substr(osberror,1,1999);
             crReportDetail(nuIdReporte,nuContratoante,osberror, 'S', nuConsecutivo); 
             ROLLBACK;
          END IF;*/
        END IF;
  
        OPEN cuFechaCierre(TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM'));
        FETCH cuFechaCierre into dtFechaCierre;
        CLOSE cuFechaCierre;

        --Si la fecha actual es igual al dia del cierre del mes se ejecuta la anulacion de solicitudes
        IF (TRUNC(dtFechaCierre) = TRUNC(SYSDATE)) THEN
        OPEN cuSolicitudesRegistradas;
        FETCH cuSolicitudesRegistradas BULK COLLECT INTO tbSolicitudesRegistradas;
        CLOSE cuSolicitudesRegistradas;

        nuIdx := tbSolicitudesRegistradas.FIRST;

        LOOP
            EXIT WHEN nuIdx IS NULL;
            
            MO_BOANNULMENT.PACKAGEINTTRANSITION(tbSolicitudesRegistradas(nuIdx).package_id, 174);
            
            nuIdx := tbSolicitudesRegistradas.NEXT(nuIdx);
        END LOOP;
        END IF;
        
        ldc_proactualizaestaprog(nutsess,osberror,'JOBPRREACCARTPLCAES','Ok');
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
        
    EXCEPTION
        when pkg_Error.Controlled_Error then
            pkg_error.getError(onuerror, osberror);
            nuConsecutivo := nuConsecutivo +1;
            osberror := substr(osberror,1,1999);
            crReportDetail(nuIdReporte,nuproductoante,osberror, 'S', nuConsecutivo);
            ldc_proactualizaestaprog(nutsess,osberror,'JOBPRREACCARTPLCAES','ERROR');
            ROLLBACK;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        when others then
            pkg_Error.setError;
            pkg_error.getError(onuerror, osberror);
            nuConsecutivo := nuConsecutivo +1;
            osberror := substr(osberror,1,1999);
            crReportDetail(nuIdReporte,nuproductoante,osberror, 'S', nuConsecutivo);
            ldc_proactualizaestaprog(nutsess,osberror,'JOBPRREACCARTPLCAES','ERROR');
            ROLLBACK;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
    END JOBPRREACCARTPLCAES;   
 
    PROCEDURE prGeneraDescuento( inuDifecodi IN NUMBER,
                              inuConcepto IN NUMBER,
                              inuContrato IN NUMBER, 
                              inuProducto IN NUMBER, 
                              inuValorAplica IN NUMBER,
                              onuError OUT NUMBER,
                              osberror OUT VARCHAR2) IS
    /**************************************************************************
    Proceso     : prGeneraDescuento
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que genera descuento de diferido

    Parametros Entrada
     inuDifecodi   codigo del diferido
     inuConcepto   codigo del concepto
     inuContrato   codigo del contrato
     inuProducto   codigo del producto
     inuValorAplica  valor aplicar
     
    Parametros de salida
    onuError   codigo de error
    osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR        DESCRIPCION
    24/06/2023   diana.montes OSF-1117: Se modifica para inicializar el programa FINAN 
                            antes de realizar el ajuste de cuenta que es el programa 
                            que se tiene en el parametro LDC_CODPROGNODE. 
    15/06/2022   LJLB         CA OSF-356 se adiciona proceso para generar saldo a favor
    ***************************************************************************/
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prGeneraDescuento';
        nuCuenta NUMBER;
        nuFactura NUMBER;
        gnuCausaNota NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSGNCR', NULL);
        inuConsDocu NUMBER;
        nuProgNota NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CODPROGNODE', NULL); --Codigo del programa para generar nota de descuento 
        rcCargoNull   cargos%rowtype;
        rcCargo   cargos%rowtype;
        regNotas     NOTAS%ROWTYPE;
        nuperiodo NUMBER;
        sbSignoAplicado VARCHAR2(2);
        nuAjusteAplicado NUMBER;
 
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        pkg_error.prInicializaError(onuError,osberror );
        
        --se setea el proceso 
        pkg_error.SetApplication('GCNED');
        --se realiza traslado
        CC_BODEFTOCURTRANSFER.GLOBALINITIALIZE;
        CC_BODefToCurTransfer.AddDeferToCollect(inuDifecodi);

        CC_BODEFTOCURTRANSFER.TRANSFERDEBT( inupayment      => inuValorAplica,
                                           idtinsolv       => SYSDATE,
                                           iblabono        => TRUE,
                                           isbprograma     => 'FTDU',
                                           onuerrorcode    => onuError,
                                           osberrormessage => osberror);
        IF onuError <> 0 THEN
         --  DBMS_OUTPUT.PUT_LINE(osberror);
           RETURN;
        END IF;
    
        --Se consulta cuenta de cobro generada
        SELECT MAX(cucocodi) INTO nuCuenta
        FROM cargos c, cuencobr cc, diferido d
        WHERE c.cargcuco = cc.cucocodi
        AND c.cargdoso = 'DF-' || d.difecodi
        AND d.difecodi = inuDifecodi
        AND trunc(c.cargfecr) = trunc(sysdate);

        nuFactura := pktblcuencobr.fnugetcucofact(nuCuenta,0);
        nuperiodo := PKTBLFACTURA.FNUGETFACTPEFA(nuFactura, null);

       --si el valor de la nota es mayor a cero se crea
        PKBILLINGNOTEMGR.GETNEWNOTENUMBER(inuConsDocu);
        PKBILLINGNOTEMGR.SETNOTENUMBERCREATED(inuConsDocu);
        pkg_traza.trace( 'CONSECUTIVO DE LA NOTA '||inuConsDocu||' CONTRATO '||inuContrato , 10 );
         regNotas.NOTANUME := inuConsDocu ;
        regNotas.NOTASUSC := inuContrato ;
        regNotas.NOTAFACT := nuFactura ;
        regNotas.NOTATINO := 'C' ;
        regNotas.NOTAFECO := SYSDATE ;
        regNotas.NOTAFECR := SYSDATE ;
        regNotas.NOTAPROG := nuProgNota ;
        regNotas.NOTAUSUA := 1 ;
        regNotas.NOTATERM := NVL(userenv('TERMINAL'),'DESCO');
        regNotas.NOTACONS := 71;
        regNotas.NOTANUFI := NULL;
        regNotas.NOTAPREF := NULL;
        regNotas.NOTACONF := NULL;
        regNotas.NOTAIDPR := NULL;
        regNotas.NOTACOAE := NULL;
        regNotas.NOTAFEEC := NULL;
        regNotas.NOTAOBSE := 'GENERACION DE NOTA POR DESCUENTO A DIFERIDO '||inuDifecodi ;
        regNotas.NOTADOCU := NULL ;
        regNotas.NOTADOSO := 'NC-' || inuConsDocu ;

        PKTBLNOTAS.INSRECORD(regNotas);
        
        rcCargo := rcCargoNull ;

        rcCargo.cargcuco := nuCuenta;
        rcCargo.cargnuse := inuProducto ;
        rcCargo.cargpefa := nuperiodo ;
        rcCargo.cargconc := inuConcepto ;
        rcCargo.cargcaca := gnuCausaNota;
        rcCargo.cargsign := 'CR' ;
        rcCargo.cargvalo := inuValorAplica ;
        rcCargo.cargdoso := 'NC-'||inuConsDocu; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
        rcCargo.cargtipr :=  'P';
        rcCargo.cargfecr := SYSDATE ;
        rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
        rcCargo.cargunid := 0 ;
        rcCargo.cargcoll := null ;
        --rcCargo.cargpeco := nuPeriCons ;
        rcCargo.cargprog := nuProgNota; --
        rcCargo.cargusua := 1;
    
        -- Adiciona el Cargo
        pktblCargos.InsRecord (rcCargo);
        pkg_traza.trace( 'TERMINO DE CREAR CARGO ', 10 );
       
       --se setea el programa que esta en el parametro
        pkErrors.SetApplication('FINAN');
        -- Ajusta la Cuenta
        PKUPDACCORECEIV.UPDACCOREC
          (
              PKBILLCONST.CNUSUMA_CARGO,
              nuCuenta,
              inuContrato,
              inuProducto,              
              inuConcepto,
              'CR',
              inuValorAplica,
              pkBillConst.cnuUPDATE_DB
          );
        pkAccountMgr.GenPositiveBal( nuCuenta, inuConcepto);
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
   
    EXCEPTION
        when pkg_Error.Controlled_Error then
            pkg_error.getError(onuerror, osberror);  
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);     
        when others then
            pkg_Error.setError;
            pkg_error.getError(onuerror, osberror);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
        
    END prGeneraDescuento; 
 
    PROCEDURE PRGENEDESCADIFE IS
    /**************************************************************************
    Proceso     : PRGENEDESCADIFE
    Autor       : LUIS JAVIER LOPEZ / HORBATH
    Fecha       : 2021-09-29
    Descripcion : proceso que descuento de diferido

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR          DESCRIPCION
    24/06/2023   diana.montes   OSF-1117: Se modifica el cursor cuGetContratos para que ingrese 
                                las busquedas por PK y tenga en cuenta unos nuevos index 
                                creados en la entidad ldc_descapli. 
    23/08/2024   jcatuche       OSF-2974: Se cambia la tabla de log de ejecución del job de ldc_os_estaproc a la tabla estaproc
                                Se agrega inicialización variable nuDescuAplic cada que procese un contrato
                                Se agrega procedimiento para cierre de cursores prCierraCursores
                                Se agrega procedimiento para finalización de solicitudes que ya no tienen planes de descuento con saldo
                                Se agrega procedimiento para cargar los contratos a procesar en tablas PL
                                Se agrega procedimiento para procesar los contratos cargados conservando la lógica actual de validación             
                                Se agrega control para generación de descuentos con el parámetro GENERA_CARGOS_DESCADIFE         
    07/10/2024  jcatuche        OSF-3396: Se agrega constante cdtSuspenJob para controlar validación de pagos anteriores a la suspensión del Job
                                Se elimina validación de cuentas con saldo pendienten en el curso principal cuGetContratos y se controlan 
                                en el procesamiento para registrar descuento cero cuando excedan las cuentas con saldo máximo para descontar
                                Se agrega llamado a nuevo parmámetro CUENTAS_SALDO_DESCADIFE para controlar las cuentas con saldo del producto analizado
    ***************************************************************************/
        csbMT_NAME      CONSTANT VARCHAR2(100) := csbSP_NAME||'PRGENEDESCADIFE';
        cnuLimite       CONSTANT NUMBER  := 1000;
        cdtSuspenJob    CONSTANT DATE := to_date('16/07/2024 23:49:16','DD/MM/YYYY HH24:MI:SS'); --Fecha suspensión Job
        
        sbproceso       VARCHAR2(100);


        nuCuotPrpa          NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CUOADPRPA'); --Cuotas a descontar por pronto pago
        nuCuotPffe          NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CUOADPPFF'); --Cuotas a Descontar por pago fuera de fecha
        nuCuotPdpv          NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_PORCDEPAVE'); --Porcentaje de descuento por pago vencido
        nuCuotVeaE          NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CUENAEVA'); -- Cuentas vencidas a evaluar
        
        sbAplicaDescFact    VARCHAR2(400) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_GENDESCFACT'); 
        sbGenDescadife      VARCHAR2(100) := PKG_PARAMETROS.fsbGetValorCadena('GENERA_CARGOS_DESCADIFE');
        nuCtaSaldoGenDesc   NUMBER := PKG_PARAMETROS.fnuGetValorNumerico('CUENTAS_SALDO_DESCADIFE');

        nuFacturaactual NUMBER;
        nuperiodo       NUMBER;
        dtFechaLimPago  DATE;
        dtFechaPago     DATE;
        nuValorPago     NUMBER;
        nuCantCuenSaldo  NUMBER;
        nuDifedesc      NUMBER;
        nuSaldoDife         NUMBER;
        nuDescuAplic     NUMBER := 0;
        nuSaldoDesc      NUMBER;
        nuCuentaCobr    NUMBER;
        nuFactura       NUMBER;
        nuPagoBrilla   NUMBER;
        nuDescuento   NUMBER;
        nuConsecutivo NUMBER := 0;
        nuExito NUMBER := 0;
        nuDescTotal NUMBER;
        nuSoliGas NUMBER;
        nuCantCuentas NUMBER;
        nurowcount    number;    
       

       
        cursor cuGetContratos is
        WITH solicitudes AS
        ( 
            SELECT /*+ index(s IDXCON_SOLIPRPLCAES) */ SOLICITUD,
            SUBSCRIPTION_ID contrato,
            M.PRODUCT_ID producto,
            m.product_type_id tipo_prod
            FROM  LDC_SOLIPRPLCAES s,MO_MOTIVE M     
            WHERE M.PACKAGE_ID = s.SOLICITUD
            AND s.ESTADO = 'T'
        )    
        SELECT 
        SOLICITUD, CONTRATO, PRODUCTO, TIPO_PROD, n.QUOTA_VALUE, DIFEcofi, DIFEPLDI plan_origen
        FROM solicitudes,CC_FINANCING_REQUEST n,diferido d
        WHERE n.package_id = SOLICITUD
        AND N.FINANCING_ID = d.difecofi
        and n.SUBSCRIPTION_ID=CONTRATO
        AND d.difesusc =contrato        
        AND d.difenuse = producto
        and exists 
        ( 
            SELECT /*+ index ( c IX_CARGOS010)*/
            'x'
            FROM CARGOS c
            WHERE cargnuse = PRODUCTO  
            AND cargcaca +0 = 51
            AND not exists (select 1 from ldc_descapli where cuenta = cargcuco)
            and cargdoso IN 
            ( 
                select /*+ index ( d1 IX_DIFERIDO02 ) */ 
                'DF-'||difecodi
                from diferido d1
                where d1.DIFECOFI = d.difecofi
            )
        )
        ;
        
        
        type tyrcSolicitud is record
        (   
            solicitud       ldc_soliprplcaes.solicitud%type,
            producto        servsusc.sesunuse%type,
            valor_fina      cc_financing_request.quota_value%type,
            financiacion    diferido.difecofi%type,
            plan_origen     diferido.difepldi%type
        );
        
        type tytbSolicitud is table of tyrcSolicitud index by varchar2(15);
         
        type tyrcServicio is record
        (   
            tipo_prod   servsusc.sesuserv%type,
            tbSolicitud tytbSolicitud
        );
        
        type tytbServicio is table of tyrcServicio index by varchar2(4);
        
        type tyrcContrato is record
        (
            contrato    suscripc.susccodi%type,
            cantfina    number,
            tbServicio  tytbServicio
        ); 
        
        type tytbContratos is table of tyrcContrato index by varchar2(8);    
        vtbContrato tytbContratos;
        
        type tytbdatos is table of cuGetContratos%rowtype index by binary_integer;
        tbData tytbdatos;
        
        sbhashC     varchar2(8);
        sbhashT     varchar2(4);
        sbhashS     varchar2(15);
        nuhashC     number := 8;    
        nuhashT     number := 4;
        nuhashS     number := 15;
        nucontador  number;
        nuTotalreg  number;
        nuUltDife   number;
    
        rcSolicitud tyrcSolicitud;
        rcServicio  tyrcServicio;
        rcContrato  tyrcContrato;

        CURSOR cugetPago(inuproducto IN NUMBER, inuFinanciacion IN NUMBER, inusolicitud IN NUMBER) IS
        SELECT /*+ index ( c  IX_CARG_CUCO_CONC )*/ cargcodo cupon, TRUNC(cargfecr), SUM(cargvalo) valor_pago
        FROM cargos c
        WHERE NOT EXISTS (select 1 from ldc_descapli where CUPON = cargcodo AND SOLICITUD = inusolicitud)
        AND cargcuco in (
                        SELECT CARGCUCO
                        FROM CARGOS
                        WHERE cargnuse = inuproducto                     
                         AND cargcaca = 51
                         AND not exists (select 1 from ldc_descapli where cuenta = cargcuco)
                         and cargdoso IN ( select 'DF-'||difecodi
                                          from diferido d1
                                          where d1.difecoFi = inuFinanciacion))
        AND cargsign = 'PA'
        and cargconc = 145
        and cargfecr > cdtSuspenJob
        group by cargcodo,TRUNC(cargfecr)
        ORDER BY TRUNC(cargfecr) desc;

        regPagos  cugetPago%rowtype;
        regPagosnull  cugetPago%rowtype;

        CURSOR cuGetCantCuentaxContrato(inuCupon IN NUMBER, inuContrato IN NUMBER, idfFecha IN DATE) IS
        SELECT COUNT( distinct cucofact) 
        FROM cargos, cuencobr, servsusc
        WHERE cargcodo = inuCupon
        AND cargsign = 'PA'
        AND cargcuco = cucocodi
        AND sesunuse = cargnuse
        AND sesususc = inuContrato
        AND trunc(cucofeve) < trunc(idfFecha);

        CURSOR cuGetCuentaxProducto(inuCupon IN NUMBER, inuProducto IN NUMBER) IS
        SELECT cargcuco, cucofact
        FROM cargos, cuencobr
        WHERE cargcodo = inuCupon
        AND cargsign = 'PA'
        AND cargcuco = cucocodi
        AND cargnuse = inuProducto
        ORDER BY cucofeve desc;

        CURSOR cugetFechaPago(inuContrato NUMBER, inuCupon NUMBER) IS
        SELECT pagofepa, PAGOVAPA
        FROM pagos
        WHERE pagosusc = inuContrato
        AND pagocupo = inuCupon;


        CURSOR cuGetUltFactura(inuContrato NUMBER) IS
        SELECT factcodi, factpefa, pefafepa
        FROM factura, perifact
        WHERE factsusc = inuContrato
        AND factprog = 6
        AND pefacodi = factpefa
        ORDER BY factfege DESC;

        CURSOR cuGetCanCuenSaldo(inuproducto IN NUMBER) IS
        SELECT COUNT(1)
        FROM cuencobr
        WHERE cuconuse =inuproducto
        AND nvl(cucosacu, 0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0) > 0;

        CURSOR cuGetDiferidoDesc(inuproducto IN NUMBER, inuPlan IN NUMBER) IS
        SELECT DIFECODI, DIFESAPE, difeconc
        FROM DIFERIDO, LDC_COPRDECO, LDC_CONFPLCAES
        WHERE DIFENUSE = inuproducto 
        AND DIFECONC = CODCCONC(+)
        AND DIFEPLDI = COPCDEST 
        AND DIFEPROG = csbPROGRAMA
        AND COPCORIG = inuPlan
        AND DIFESAPE > 0
        ORDER BY CODCPRIOR;

        CURSOR cuGetDiferidoDescGas(inucontrato IN NUMBER, inuPlan IN NUMBER) IS
        SELECT DIFECODI, DIFESAPE, difeconc
        FROM DIFERIDO, LDC_COPRDECO, LDC_CONFPLCAES, servsusc
        WHERE DIFENUSE = sesunuse 
        AND sesususc = inucontrato
        AND sesuserv = 7014
        AND DIFECONC = CODCCONC(+)
        AND DIFEPLDI = COPCDEST 
        AND DIFEPROG = csbPROGRAMA
        AND COPCORIG = inuPlan
        AND DIFESAPE > 0
        ORDER BY CODCPRIOR;

        CURSOR cuGetValorPagoBrilla(inucontrato IN NUMBER, inuPlan IN NUMBER, inuCupon IN NUMBER) IS
        SELECT  nvl(SUM(cargvalo),0) valor_pago
        FROM cargos, servsusc
        WHERE cargnuse = sesunuse
         AND sesususc = inucontrato
         AND cargcodo = inuCupon
         AND sesuserv = 7055
         AND cargsign = 'PA'
         AND EXISTS ( SELECT 1
                      FROM DIFERIDO,  LDC_CONFPLCAES
                      WHERE DIFENUSE = SESUNUSE 
                        AND DIFEPLDI = COPCDEST 
                        AND DIFEPROG = csbPROGRAMA
                        AND COPCORIG = DECODE(inuPlan,-1,COPCORIG, inuPlan)
                        AND DIFESAPE > 0);

        CURSOR cugetdescaplicado(inuSolicitud IN NUMBER, inuCupon IN NUMBER) IS
        SELECT *
        FROM LDC_DESCAPLI
        WHERE SOLICITUD = inuSolicitud AND CUPON = inuCupon;

        regDescaplicado cugetdescaplicado%rowtype;
        
        cursor cufinalizar is
        with solicitudes as
        (
            select /*+ index  ( s IDXCON_SOLIPRPLCAES ) use_nl ( s m )
            index ( m IDX_MO_MOTIVE_02 )*/
            solicitud,r.record_date,s.fecha_registro,estado,financing_plan_id,
            (
                select count(*)
                from ldc_confplcaes,diferido
                where copcorig = financing_plan_id
                and difenuse = m.product_id
                and difepldi = copcdest
                and difesape > 0
                and difefein between r.record_date and s.fecha_registro
            ) cantidad
            from LDC_SOLIPRPLCAES s,mo_motive m,CC_FINANCING_REQUEST r
            where s.estado = 'T'
            and m.package_id = solicitud
            and r.package_id = m.package_id
        )
        select * 
        from solicitudes
        where cantidad = 0;
        
        type tytbfinalizar is table of cufinalizar%rowtype index by binary_integer;
        tbfinalizar   tytbfinalizar;
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbMT_NAME||'.prCierraCursores';
        BEGIN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
            
            IF cuGetContratos%ISOPEN THEN
                CLOSE cuGetContratos;
            END IF;
            
            IF cuGetCanCuenSaldo%ISOPEN THEN
                CLOSE cuGetCanCuenSaldo;
            END IF;

            IF cugetPago%ISOPEN THEN
                CLOSE cugetPago;
            END IF;

            IF cuGetUltFactura%ISOPEN THEN
                CLOSE cuGetUltFactura;
            END IF;

            IF cugetFechaPago%ISOPEN THEN
                CLOSE cugetFechaPago;
            END IF;

            IF cuGetCuentaxProducto%ISOPEN THEN
                CLOSE cuGetCuentaxProducto;
            END IF;

            IF cuGetValorPagoBrilla%ISOPEN THEN
                CLOSE cuGetValorPagoBrilla;
            END IF;  
            
            IF cugetdescaplicado%ISOPEN THEN
                CLOSE cugetdescaplicado;
            END IF; 
            
            IF cufinalizar%ISOPEN THEN
                CLOSE cufinalizar;
            END IF; 
               
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        END prCierraCursores;
        
        PROCEDURE prFinalizaSol
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbMT_NAME||'.prFinalizaSol';
        BEGIN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
            
            -- Inicializamos el proceso
            sbproceso := 'FINDESCADIFE_'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
            pkg_estaproc.prInsertaEstaproc(sbproceso,0);
            nucontador := 0;
            nuTotalreg := 0;
            
            open cufinalizar;
            loop
                tbfinalizar.delete;
                fetch cufinalizar bulk collect into tbfinalizar limit cnulimite;
                --Finaliza solicitudes
                forall i in tbfinalizar.first..tbfinalizar.last
                    update LDC_SOLIPRPLCAES
                    set estado = 'F'
                    where solicitud = tbfinalizar(i).solicitud
                    and estado = tbfinalizar(i).estado;
                nuRowcount := sql%rowcount;  
                nucontador := nucontador + nuRowcount;
                nuTotalreg := nucontador;
                commit;
                exit when tbfinalizar.count < cnulimite;
            end loop;
            close cufinalizar;   
            
            pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
            pkg_estaproc.prActualizaEstaproc(sbproceso);            
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);            
        EXCEPTION
            when pkg_Error.Controlled_Error then
                ROLLBACK;
                pkg_error.getError(nuerror,sberror);
                pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
                pkg_estaproc.prActualizaEstaproc(sbproceso,'ERROR',sberror);
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Erc);
            when others then
                ROLLBACK;
                pkg_Error.setError;
                pkg_error.getError(nuerror, sberror);
                pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
                pkg_estaproc.prActualizaEstaproc(sbproceso,'ERROR',sberror);
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Err);
        END prFinalizaSol;
        
        PROCEDURE prCargaContratos
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbMT_NAME||'.prCargaContratos';
        BEGIN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
            
            -- Inicializamos el proceso
            sbproceso := 'PRGENEDESCADIFE_'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
            pkg_estaproc.prInsertaEstaproc(sbproceso,0);
            nucontador := 0;
            nuTotalreg := 0;
            
            --Cargar registros a procesar
            open cuGetContratos;
            loop
                tbData.delete;
                fetch cuGetContratos bulk collect into tbData limit cnulimite;
                exit when tbData.count = 0;
                for i in tbData.first..tbData.last loop
                    sbhashC := lpad(tbData(i).contrato, nuhashC,'0');
                    sbhashT := lpad(tbData(i).tipo_prod,nuhashT,'0');
                    sbhashS := lpad(tbData(i).solicitud,nuhashS,'0');
                    
                    if vtbContrato.exists(sbhashC) then
                        if vtbContrato(sbhashC).tbServicio.exists(sbhashT) then
                            if not vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud.exists(sbhashS) then
                                vtbContrato(sbhashC).cantfina                                               := vtbContrato(sbhashC).cantfina + 1;
                                vtbContrato(sbhashC).tbServicio(sbhashT).tipo_prod                          := tbData(i).tipo_prod;
                                vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).solicitud     := tbData(i).solicitud;
                                vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).producto      := tbData(i).producto;
                                vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).valor_fina    := tbData(i).quota_value;
                                vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).financiacion  := tbData(i).difecofi;
                                vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).plan_origen   := tbData(i).plan_origen;
                                
                                nuTotalreg := nuTotalreg + 1;
                            end if;
                        else
                            vtbContrato(sbhashC).cantfina                                               := vtbContrato(sbhashC).cantfina + 1;
                            vtbContrato(sbhashC).tbServicio(sbhashT).tipo_prod                          := tbData(i).tipo_prod;
                            vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).solicitud     := tbData(i).solicitud;
                            vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).producto      := tbData(i).producto;
                            vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).valor_fina    := tbData(i).quota_value;
                            vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).financiacion  := tbData(i).difecofi;
                            vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).plan_origen   := tbData(i).plan_origen;
                            
                            nuTotalreg := nuTotalreg + 1;
                        end if;
                    else
                        vtbContrato(sbhashC).contrato                                               := tbData(i).contrato;
                        vtbContrato(sbhashC).cantfina                                               := 1;
                        vtbContrato(sbhashC).tbServicio(sbhashT).tipo_prod                          := tbData(i).tipo_prod;
                        vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).solicitud     := tbData(i).solicitud;
                        vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).producto      := tbData(i).producto;
                        vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).valor_fina    := tbData(i).quota_value;
                        vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).financiacion  := tbData(i).difecofi;
                        vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS).plan_origen   := tbData(i).plan_origen;
                        
                        nuTotalreg := nuTotalreg + 1;
                    end if;
                end loop;
                exit when tbData.count < cnulimite;
            end loop;
            close cuGetContratos;
                
            pkg_estaproc.prActualizaAvance(sbproceso,'Población cargada',nucontador,nuTotalreg);
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);            
        EXCEPTION
            when pkg_Error.Controlled_Error then
                pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Erc);
                raise pkg_Error.Controlled_Error;
            when others then
                pkg_error.seterror;
                pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Err);
                raise pkg_Error.Controlled_Error;
        END prCargaContratos;
        
        PROCEDURE prProcesaContratos
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbMT_NAME||'.prProcesaContratos';
        BEGIN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
            
            --se adiciona reporte 
            IF sbGenDescadife = 'S' then
                nuIdReporte :=  fnuCrReportHeader('LOGDESDIF', 'INCONSISTENCIAS EN EL PROCESO DE DESCUENTO DE DIFERIDO DE CARTERA PLAN ESPECIAL'); 
            END IF;
            
            pkg_traza.trace('Fecha de restricción de pagos '||cdtSuspenJob,cnuNivelTraza);
            
            --recorrido de registros a procesar
            sbhashC := vtbContrato.first;
            if sbhashC is not null then
                loop
                    rcContrato  := vtbContrato(sbhashC);
                    nuDescuAplic := 0;  --Se inicializa variable de descuento por cada contrato.
                    nuSoliGas := null;
                    sbhashT := vtbContrato(sbhashC).tbServicio.first;
                    loop
                        rcServicio  := vtbContrato(sbhashC).tbServicio(sbhashT);
                        sbhashS := vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud.first;
                        loop
                            rcSolicitud := vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud(sbhashS);
                            --Contador de solicitudes procesadas
                            nucontador := nucontador + 1;
                            if mod(nucontador,cnuLimite) = 0 then
                                pkg_estaproc.prActualizaAvance(sbproceso,'Procesando',nucontador,nuTotalreg);
                            end if;
                            
                            --se inician valores por defectos
                            regPagos := regPagosnull;
                            nuExito := 0;
                            nuDescTotal  := 0;
                            nuFacturaactual := NULL;
                            nuperiodo := NULL;
                            dtFechaLimPago := NULL;
                            dtFechaPago := NULL;
                            nuValorPago := NULL;
                            nuCuentaCobr := NULL;
                            nuFactura := NULL;
                            nuPagoBrilla := 0;
                            nuCantCuentas := 0;
                            
                            --se valida último pago realizado
                            OPEN cugetPago(rcSolicitud.producto, rcSolicitud.financiacion, rcSolicitud.solicitud);
                            FETCH cugetPago INTO  regPagos; 
                            IF cugetPago%NOTFOUND THEN
                                CLOSE cugetPago;
                                sbhashS := vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud.next(sbhashS);
                                exit when sbhashS is null;
                                CONTINUE;
                            END IF;
                            CLOSE cugetPago;
                            
                            pkg_traza.trace('CUPON: '||regPagos.cupon||', VALOR_PAGO: '||regPagos.VALOR_PAGO||', PRODUCTO: '||rcSolicitud.producto, cnuNivelTraza);
                            
                            --se obtiene valor del pago
                            OPEN cugetFechaPago(rcContrato.contrato, regPagos.cupon);
                            FETCH cugetFechaPago INTO dtFechaPago,  nuValorPago;
                            CLOSE cugetFechaPago;     
                            
                            --se valida cantidad de cuentas vencidas
                            OPEN cuGetCantCuentaxContrato(regPagos.cupon, rcContrato.contrato, dtFechaPago);
                            FETCH cuGetCantCuentaxContrato INTO nuCantCuentas;
                            CLOSE cuGetCantCuentaxContrato; 
                            
                            IF nuCantCuentas >= nvl(nuCuotVeaE,2) THEN
                                sbhashS := vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud.next(sbhashS);
                                exit when sbhashS is null;
                                CONTINUE;
                            END IF;
                            
                            --se obtiene cuenta  y factura más reciente pagada con el cupón para el producto
                            OPEN cuGetCuentaxProducto(regPagos.cupon, rcSolicitud.producto );
                            FETCH cuGetCuentaxProducto INTO nuCuentaCobr, nuFactura;
                            CLOSE cuGetCuentaxProducto;

                            --se consulta cuentas con saldo
                            OPEN cuGetCanCuenSaldo(rcSolicitud.producto);
                            FETCH cuGetCanCuenSaldo INTO  nuCantCuenSaldo;
                            CLOSE cuGetCanCuenSaldo;
                            
                            pkg_traza.trace('nuCantCuenSaldo '||nuCantCuenSaldo, cnuNivelTraza);
                            pkg_traza.trace('nuCtaSaldoGenDesc '||nuCtaSaldoGenDesc, cnuNivelTraza); 
                            
                            IF nuCantCuenSaldo > nvl(nuCtaSaldoGenDesc,1) THEN
                                PKG_LDC_DESCAPLI.prInsertaRegistro
                                (
                                    inucuenta => nuCuentaCobr,
                                    inufactura => nuFactura,
                                    inudiferido => -1,
                                    inusolicitud => rcSolicitud.solicitud,
                                    inuvalor_descuento => 0,
                                    inuvalor_pago => nuValorPago,
                                    inucupon => regPagos.cupon
                                );
                                COMMIT;
                                    
                                sbhashS := vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud.next(sbhashS);
                                exit when sbhashS is null;
                                CONTINUE;
                            END IF;

                            --se obtiene última factura 
                            OPEN cuGetUltFactura(rcContrato.contrato);
                            FETCH cuGetUltFactura INTO  nuFacturaactual,  nuperiodo,  dtFechaLimPago;
                            CLOSE cuGetUltFactura;  
                            
                            --se consulta pago de brilla
                            IF rcContrato.cantfina > 1 THEN
                                IF rcServicio.tipo_prod = 7014 THEN
                                    OPEN cuGetValorPagoBrilla(rcContrato.contrato, -1, regPagos.cupon);
                                    FETCH cuGetValorPagoBrilla INTO nuPagoBrilla;
                                    CLOSE cuGetValorPagoBrilla;

                                ELSE
                                    OPEN cuGetValorPagoBrilla(rcContrato.contrato, rcSolicitud.plan_origen, regPagos.cupon);
                                    FETCH cuGetValorPagoBrilla INTO nuPagoBrilla;
                                    CLOSE cuGetValorPagoBrilla;
                                END IF;
                            END IF;
                            
                            -- valida si el usuario pago antes de la fecha limite de la ultima factura emitida
                            IF nuCantCuenSaldo = 0 AND nuCantCuentas = 0 AND dtFechaPago < dtFechaLimPago THEN  
                                IF rcContrato.cantfina = 1 THEN              
                                    nuDescuAplic := nuValorPago * nuCuotPrpa;                
                                ELSE
                                    IF rcServicio.tipo_prod = 7014 THEN                   
                                        nuDescuAplic := (nuValorPago - nuPagoBrilla) * nuCuotPrpa;                   
                                    ELSE
                                        nuDescuAplic := NVL(nuDescuAplic,0) + nuPagoBrilla * nuCuotPrpa;
                                    END IF;
                                END IF;
                              
                                IF sbAplicaDescFact <> 'S' THEN
                                    nuDescuAplic := rcSolicitud.valor_fina * nuCuotPrpa;
                                END IF;
                              
                            ELSIF  nuCantCuenSaldo = 0 AND nuCantCuentas < nvl(nuCuotVeaE,2)  AND dtFechaPago >= dtFechaLimPago THEN --se valida si el usuario pago posterior a la fecha limite
                             
                                IF rcContrato.cantfina = 1 THEN
                                    nuDescuAplic := nuValorPago * nuCuotPffe;
                                ELSE     
                                    IF rcServicio.tipo_prod = 7014 THEN
                                        nuDescuAplic := (nuValorPago - nuPagoBrilla) * nuCuotPffe;
                                    ELSE
                                        nuDescuAplic :=  NVL(nuDescuAplic,0) + nuPagoBrilla * nuCuotPffe;
                                    END IF;                  
                                END IF;
                              
                                IF sbAplicaDescFact <> 'S' THEN
                                    nuDescuAplic := rcSolicitud.valor_fina * nuCuotPffe;
                                END IF;
                              
                            ELSIF nuCantCuenSaldo <= nvl(nuCtaSaldoGenDesc,1) AND dtFechaPago < dtFechaLimPago THEN --se valida si el usuario pago antes a la fecha limite con cuenta con saldo
                          
                                IF rcContrato.cantfina = 1 THEN
                                    nuDescuAplic := ROUND(nuValorPago * (nuCuotPdpv / 100) ,0 );
                                ELSE
                                    IF rcServicio.tipo_prod = 7014 THEN
                                        nuDescuAplic := ROUND((nuValorPago - nuPagoBrilla) * (nuCuotPdpv / 100) ,0 );
                                    ELSE
                                        nuDescuAplic := ROUND((NVL(nuDescuAplic,0)  + nuPagoBrilla * (nuCuotPdpv / 100)) ,0 );
                                    END IF;
                                END IF;
                          
                                IF sbAplicaDescFact <> 'S' THEN
                                    nuDescuAplic := ROUND(  rcSolicitud.valor_fina *  (nuCuotPdpv / 100) , 0);
                                END IF;
                          
                            END IF;
                            
                            pkg_traza.trace('nuDescuAplic '||nuDescuAplic,cnuNivelTraza);
                            
                            IF nuDescuAplic > 0 THEN
                                pkg_traza.trace('rcServicio.tipo_prod '||rcServicio.tipo_prod ||', rcSolicitud.plan_origen '||rcSolicitud.plan_origen,cnuNivelTraza);
                                
                                IF  rcServicio.tipo_prod = 7014 THEN
                                    nuSoliGas := rcSolicitud.solicitud;
                                END IF;
                                --se recorren diferidos de descuento con saldo
                                nuUltDife := null;
                                FOR reg IN cuGetDiferidoDesc(rcSolicitud.producto, rcSolicitud.plan_origen) LOOP              
                                 
                                    pkg_traza.trace('cursor cuGetDiferidoDesc recorre los diferidos REG.DIFESAPE '||REG.DIFESAPE,cnuNivelTraza);

                                    nuExito := 1;
                                    IF nuDescuAplic = 0 THEN
                                        EXIT;
                                    END IF;
                                 
                                 
                                    IF nuDescuAplic >= REG.DIFESAPE THEN
                                        nuDescuento := REG.DIFESAPE;
                                        nuDescuAplic := nuDescuAplic - nuDescuento;
                                    ELSE
                                        nuDescuento := nuDescuAplic;
                                        nuDescuAplic := 0;
                                    END IF;

                                    IF sbGenDescadife = 'S' then
                                        prGeneraDescuento
                                        ( 
                                            reg.DIFECODI,
                                            reg.difeconc,
                                            rcContrato.contrato, 
                                            rcSolicitud.producto, 
                                            nuDescuento,
                                            nuError,
                                            sberror
                                        );
                                        
                                        IF nuError <> 0 THEN
                                            nuConsecutivo := nuConsecutivo +1;                   
                                            crReportDetail(nuIdReporte,rcSolicitud.producto,sberror, 'S', nuConsecutivo);
                                            ROLLBACK;
                                            nuExito := 0;
                                            EXIT;
                                        END IF;
                                    END IF;
                                    
                                    nuUltDife := reg.difecodi;
                                    
                                    nuDescTotal := nuDescTotal + nuDescuento; 
                                
                                END LOOP;
                               
                                IF nuExito = 1 THEN
                                    
                                    PKG_LDC_DESCAPLI.prInsertaRegistro
                                    (
                                        inucuenta => nuCuentaCobr,
                                        inufactura => nuFactura,
                                        inudiferido => nuUltDife,
                                        inusolicitud => rcSolicitud.solicitud,
                                        inuvalor_descuento => nuDescTotal,
                                        inuvalor_pago => nuValorPago,
                                        inucupon => regPagos.cupon
                                    );
                                    COMMIT;
                                END IF;
                            END IF;
                            
                            --si termino brilla con saldo a descontar se realiza descuento a gas
                            IF rcContrato.cantfina > 1 AND rcServicio.tipo_prod = 7055 AND nuDescuAplic > 0 THEN
                                nuExito := 0;
                                nuDescTotal := 0;
                                
                                if nuSoliGas is null then 
                                    nuSoliGas := rcSolicitud.solicitud;
                                end if;
                                
                                regDescaplicado := null;
                                OPEN cugetdescaplicado(nuSoliGas, regPagos.cupon);
                                FETCH cugetdescaplicado INTO regDescaplicado;
                                CLOSE cugetdescaplicado;
                               
                                --se recorren diferidos de descuento con saldo
                                nuUltDife := null;
                                FOR reg IN cuGetDiferidoDescGas(rcContrato.contrato, rcSolicitud.plan_origen) LOOP              
                                    
                                    IF nuExito = 0 then
                                        --Solo se borra el registro cuando hay diferidos a descontar
                                        PKG_LDC_DESCAPLI.prBorraRegistro(nuSoliGas,regPagos.cupon);  
                                    END IF;
                                    
                                    nuExito := 1;
                                   
                                    IF nuDescuAplic = 0 THEN
                                        EXIT;
                                    END IF;
                                   
                                    IF nuDescuAplic >= REG.DIFESAPE THEN
                                        nuDescuento := REG.DIFESAPE;
                                        nuDescuAplic := nuDescuAplic - nuDescuento;
                                    ELSE
                                        nuDescuento := nuDescuAplic;
                                        nuDescuAplic := 0;
                                    END IF;
                                   
                                    IF sbGenDescadife = 'S' then
                                        prGeneraDescuento
                                        ( 
                                            reg.DIFECODI,
                                            reg.difeconc,
                                            rcContrato.contrato, 
                                            rcSolicitud.producto, 
                                            nuDescuento,
                                            nuError,
                                            sberror
                                        );
                                        
                                        IF nuError <> 0 THEN
                                            nuConsecutivo := nuConsecutivo +1;                   
                                            crReportDetail(nuIdReporte,rcSolicitud.producto,sberror, 'S', nuConsecutivo);
                                            ROLLBACK;
                                            nuExito := 0;
                                            EXIT;
                                        END IF;
                                    END IF;
                                    
                                    nuUltDife := reg.difecodi;
                                    
                                    nuDescTotal := nuDescTotal + nuDescuento; 
                                    
                                END LOOP;
                                
                                IF nuExito = 1 THEN
                                    PKG_LDC_DESCAPLI.prInsertaRegistro
                                    (
                                        inucuenta => nvl(regDescaplicado.CUENTA,nuCuentaCobr),
                                        inufactura => nvl(regDescaplicado.FACTURA,nuFactura),
                                        inudiferido => nuUltDife,
                                        inusolicitud => nvl(regDescaplicado.SOLICITUD,rcSolicitud.solicitud),
                                        inuvalor_descuento => nvl(regDescaplicado.VALOR_DESCUENTO,0) + nuDescTotal,
                                        inuvalor_pago => nvl(regDescaplicado.VALOR_PAGO,nuValorPago),
                                        inucupon => regPagos.cupon
                                    );
                                    COMMIT;
                                END IF;
                            END IF;
                            
                            sbhashS := vtbContrato(sbhashC).tbServicio(sbhashT).tbSolicitud.next(sbhashS);
                            exit when sbhashS is null;
                        end loop;
                        sbhashT := vtbContrato(sbhashC).tbServicio.next(sbhashT);
                        exit when sbhashT is null;
                    end loop;
                    sbhashC := vtbContrato.next(sbhashC);
                    exit when sbhashC is null;
                    vtbContrato.delete(vtbContrato.prior(sbhashC));
                end loop;
            end if;
                
            pkg_estaproc.prActualizaAvance(sbproceso,'Población procesada',nucontador,nuTotalreg);
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);            
        EXCEPTION
            when pkg_Error.Controlled_Error then
                pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Erc);
                raise pkg_Error.Controlled_Error;
            when others then
                pkg_error.seterror;
                pkg_estaproc.prActualizaAvance(sbproceso,' ',nucontador,nuTotalreg);
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Err);
                raise pkg_Error.Controlled_Error;
        END prProcesaContratos;

   
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        sbGenDescadife := NVL(sbGenDescadife,'N');
        
        --se cierran cursores si estan abiertos
        prCierraCursores; 
        
        -- Finaliza solicitudes ya descontadas
        prFinalizaSol;
        
        --Carga contratos a procesar
        prCargaContratos;
        
        --Procesa contratos
        prProcesaContratos;
        
        pkg_estaproc.prActualizaEstaproc(sbproceso);
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
        
    EXCEPTION
        when pkg_Error.Controlled_Error then
            ROLLBACK;
            pkg_error.getError(nuerror,sberror);
            pkg_estaproc.prActualizaEstaproc(sbproceso,'ERROR',sberror);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        when others then
            ROLLBACK;
            pkg_Error.setError;
            pkg_error.getError(nuerror, sberror);
            pkg_estaproc.prActualizaEstaproc(sbproceso,'ERROR',sberror);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
    END PRGENEDESCADIFE;

END LDC_PKGESTIONDIFCART;

/