CREATE OR REPLACE package      adm_person.ldc_pkgenotadife IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    15/07/2024              PAcosta         OSF-2885: Cambio de esquema ADM_PERSON  
                                            Retiro marcacion esquema .open objetos de lógica
    ****************************************************************/                                       
 
 nuparano number := to_char(sysdate, 'YYYY');
 nuparmes number := to_char(sysdate, 'MM');
-- tabla de planes
  TYPE rcPlandife IS RECORD(
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
     nugTasaInte    number);

  TYPE tbPlandife IS TABLE OF rcPlandife INDEX BY binary_integer;
  tPlandife tbPlandife;
  nuIndPlanDife binary_integer;

  -- tabla de conceptos
  TYPE rcConcepto IS RECORD(
     conccore       number(5),
     conccoin       number(5)
     );

  TYPE tbConcepto IS TABLE OF rcConcepto INDEX BY binary_integer;
  tConcepto tbConcepto;
  nuIndConcepto binary_integer;

  -- tabla de notas
  TYPE rcNotas IS RECORD(
     contrato       number(8),
     consecut       number(4),
     sesion         number(12),
     fecha          date,
     producto       number(10),
     cuenta         number(10),
     concepto       number(4),
     causal         number (3),
     valor          number (13,2),
     signo          varchar2(2),
     diferir        varchar2(2),
     planfina       number(4),
     cuotas         number(3),
     factura        number(12),
     menserror      varchar2(1000),
     ctasconsaldo   number(4), ---
     pefacodi       number(6),
     pecscons       number(6),
     saldoconc      number (13,2),
     saldocuen      number (13,2),
	 conssubs       VARCHAR2(1));

  TYPE tbNotas IS TABLE OF rcNotas INDEX BY varchar2(12);
  tNotas tbNotas;
  sbIndNotas varchar2(12);

  -- tabla de contratos a no procesar
  TYPE rcContExcl IS RECORD(
     contrato       number(8));

  TYPE tbContExcl IS TABLE OF rcContExcl INDEX BY varchar2(8);
  tContExcl tbContExcl;
  sbIndCont varchar2(8);


  ------
  csbYes             constant varchar2(1) := 'Y';
  csbNo              constant varchar2(1) := 'N';
  nusesion           number;

  procedure fnuPrincipal (inusesion in number, onuCodError out number, osbMsgError out varchar2);

  function fnuCargaPlanes (osbMsgError out varchar2) return number;

  function fnuCargaConceptos (osbMsgError out varchar2) return number;

  function fnuCargaTablaNotas (osbMsgError out varchar2) return number;

  function  fnuGeneBillingNote (osbMsgError out varchar2) return number;

  function fnuCreaDiferidos (inucontrato in number,
                          inuproducto in number,
                          inuconcepto in number,
                          inuplanfina in number,
                          inuvalor in number,
                          inucuotas in number,
                          isbdoso   in varchar2,
                          inuDifeCofi in number,
                          osbMsgError out varchar2) return number;

  function CreateDeferred(inuFinanceCode        in diferido.difecofi%type,
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
                           osbMsgError out varchar2) return number;

    function  fnuActualizaCC (osbMsgError out varchar2) return number;

    function  fnuInsertLog (osbMsgError out varchar2) return number ;

    FUNCTION fsbGetFuncionaDataBase RETURN funciona.funccodi%type;

    function  fnuActuSaldoCC  (inucontrato  in servsusc.sesususc%type,
                           inucuenta    in cuencobr.cucocodi%type,
                           inuvlrnotas  in number) return varchar2;

    procedure prActEstaprog (isbmensaje in varchar2);

END ldc_pkgenotadife;
/
CREATE OR REPLACE package BODY      adm_person.ldc_pkgenotadife IS

 csbPROGRAMA      constant varchar2(4) := 'ANDM';
 nuPrograma       cargos.cargprog%type := 2014; -- programa de ajustes
 nuporctasames number; -- tasa mensual de interes de usura

 nugNumServ servsusc.sesunuse%type; -- Numero servicio
 nugPorcMora plandife.pldiprmo%type;
 nugSubscription suscripc.susccodi%type;
 nugMetodo number;
 nugPorcInteres number;
 nugSpread number;
 nugFactor number;
 nugTasaInte number;
 nugFunctionaryId     funciona.funccodi%type;
 nugUsuario number;
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

procedure fnuPrincipal (inusesion in number, onuCodError out number, osbMsgError out varchar2) is

  SBFUNCIONA  funciona.funccodi%type;
  onuError number := 0;

begin
  nusesion := inusesion;


   -- Obtiene usuario y terminal
  sbgUser         := pkGeneralServices.fsbGetUserName;
  sbgTerminal     := pkGeneralServices.fsbGetTerminal;
  gnuPersonId     := GE_BOPersonal.fnuGetPersonId;
  dtgProceso      := sysdate;
  nugChargeCause  := 51;

   --Obtiene el funcionario asociado al usuario de la base de datos
   sbFunciona := fsbGetFuncionaDataBase;
   nugFunctionaryId := sbFunciona;


  tPlandife.delete;
  tConcepto.delete;
  tNotas.delete;
  tContExcl.delete;

  onuError := fnuCargaPlanes(osbMsgError);
  if onuError = 0 then
    onuError := fnuCargaConceptos (osbMsgError);
    if onuError = 0 then
      onuError := fnuCargaTablaNotas (osbMsgError);
      if onuError = 0 then
        onuError := fnuGeneBillingNote (osbMsgError);
        /*if onuError = 0 then
          onuError := fnuActualizaCC (osbMsgError);*/
          if onuError = 0 then
            onuError := fnuInsertLog (osbMsgError);
          end if;
        /*end if;*/
      end if;
    end if;
  end if;

  if onuError = 0 then
     osbMsgError := 'Termino Proceso';
  end if;
  tPlandife.delete;
  tConcepto.delete;
  tNotas.delete;
  tContExcl.delete;


exception when others then
  ERRORS.SETERROR;
  ERRORS.geterror(onuCodError,osbMsgError);
  osbMsgError := 'Error en fnuPrincipal: '|| osbMsgError;
end fnuPrincipal;
-------------------------------------
function fnuCargaPlanes (osbMsgError out varchar2) return number is

  onuError number := 0;
   nunucumiplan      plandife.pldicumi%type;
   dtfecmaxplan      plandife.pldifefi%type;
   nunucumaplan      plandife.pldicuma%type;
   nucodpergracia    cc_grace_period.grace_period_id%type;
   nuDiasGracia      cc_grace_period.max_grace_days%type;
    nuQuotaMethod        plandife.pldimccd%type;
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
  nuDias cc_grace_period.max_grace_days%type;

  cursor cuPlanes is
    select distinct t.planfina
      from ldc_notas_masivas t
     where t.sesion = nusesion
	  AND T.CONTRATO NOT IN ( SELECT t1.CONTRATO
	                          FROM ldc_notas_masivas t1
							  WHERE t1.sesion = nusesion
							   AND t1.planfina IS NULL ); -- 492770555;



  cursor cuValPlanFina (nuPlanDife plandife.pldicodi%type) is
      select nvl(pldicumi,-1), nvl(pldicuma,-1), pldifefi, pldipegr,
             decode(pldipegr,null,-1,(select gp.max_grace_days
                                        from cc_grace_period gp
                                       where gp.grace_period_id = pldipegr)) nuDiasGracia
        from plandife
       where pldicodi = nuPlanDife;

   cursor cuPlanesParam (inuplan plandife.pldicodi%type) is
   select distinct plficoco plan, feincodi fecha
     from LDC_CONFIG_CONTINGENC t
    where plficoco is not null and feincodi is not null
      and t.plficoco = inuplan
  union
   select distinct plficont plan , feincodo fecha
     from LDC_CONFIG_CONTINGENC t
    where plficont is not null and feincodo is not null
      and t.plficoco = inuplan;

begin
  --dbms_output.disable;
   ldc_proinsertaestaprog(nuparano,nuparmes,'FNUCARGAPLANES','En ejecucion',nusesion,USER);
  for rg in cuPlanes loop
     open cuValPlanFina (rg.planfina);
     fetch cuValPlanFina into nunucumiplan, nunucumaplan, dtfecmaxplan, nucodpergracia, nuDiasGracia;
     if cuValPlanFina%notfound then
        nunucumaplan := -1;
        nunucumiplan := -1;
        nucodpergracia := -1;
        nuDiasGracia := -1;
     end if;
     close cuValPlanFina;

     if nunucumaplan = -1 then
        onuError := -1;
        osbMsgError := 'Plan de Financiacion ' || rg.planfina || ' no existe';
        exit;
     end if;

     if dtfecmaxplan < sysdate then
        onuError := -1;
        osbMsgError := 'Plan de Financiacion ' || rg.planfina || ' no esta vigente';
        exit;
     end if;

    -- Obtiene tasa de interes
    pkDeferredPlanMgr.ValPlanConfig(rg.planfina,
                                    sysdate,
                                    nuQuotaMethod, --
                                    nuTaincodi,
                                    nuInteRate,
                                    boSpread); --

    if (nugMetodo is null) then
      -- Asigna metodo de calculo del Plan de financiacion
       nugMetodo := pktblplandife.fnugetpaymentmethod(rg.planfina);
    end if;

   if (nugMetodo is null) then
      -- Asigna metodo de calculo por default
      nugMetodo := pktblParaFact.fnuGetPaymentMethod(pkConstante.SISTEMA);
    end if;

   -- Configura manejo de porcentaje de interes y el spread
    pkDeferredMgr.ValInterestSpread(nugMetodo,
                                    nugPorcInteres,
                                    nugSpread,
                                    nugPorIntNominal); --

    -- Valida el Factor Gradiente
    pkDeferredMgr.ValGradiantFactor(rg.planfina,
                                    nugMetodo,
                                    nvl(nugPorcInteres,0) + nvl(nugSpread,0),
                                    nunucumaplan, -- nuCuotas,
                                    nugFactor);

    -- Obtiene el Porcentaje de Recargo por Mora del plan
    -- GetOverChargePercent(rg.planfina, nugPorcMora);

    nugTasaInte := pktblPlandife.fnuGetInterestRateCod(rg.planfina);

    -- Halla fecha final de periodos de gracia
    for rg2 in cuPlanesParam (rg.planfina) loop
       nuDias := to_Date(rg2.fecha,'dd/mm/yyyy') - trunc(sysdate);
       if nuDias > 0 then
         nuDiasGracia := nuDias;
       end if;
    end loop;

    -- Guarda en tabla en memoria
     if not tPlandife.exists(rg.planfina) then
        tPlandife(rg.planfina).pldicumi := nunucumiplan;
        tPlandife(rg.planfina).pldicuma := nunucumaplan;
        tPlandife(rg.planfina).pldifefi := dtfecmaxplan;
        tPlandife(rg.planfina).pldipegr := nucodpergracia;
        tPlandife(rg.planfina).diaspegr := nuDiasGracia;
        tPlandife(rg.planfina).nuTaincodi := nuTaincodi;
        tPlandife(rg.planfina).InteRate := nuInteRate;
        tPlandife(rg.planfina).nugMetodo := nugMetodo;
        tPlandife(rg.planfina).nugPorcInteres := nugPorcInteres;
        tPlandife(rg.planfina).nugSpread := nugSpread;
        tPlandife(rg.planfina).nugFactor := nugFactor;
        tPlandife(rg.planfina).nugTasaInte := nugTasaInte;
     end if;
   end loop;
   ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUCARGAPLANES','ok');
   return onuError;

exception when others then
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuCargaPlanes: '|| osbMsgError;
  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUCARGAPLANES','ERROR');
  RETURN -1;
end fnuCargaPlanes;
--------------------------------------------------------
function fnuCargaConceptos (osbMsgError out varchar2) return number is

  onuError number := 0;

 cursor cuConceptos is
  select conccodi conce, conccore,conccoin
    from concepto
   where conccodi > 0;

  begin
     ldc_proinsertaestaprog(nuparano,nuparmes,'FNUCARGACONCEPTOS','En ejecucion',nusesion,USER);
   for rg in cuConceptos loop
      if not tConcepto.exists(rg.conce) then
        tConcepto(rg.conce).conccore := rg.conccore;
        tConcepto(rg.conce).conccoin := rg.conccoin;
      end if;
   end loop;
ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUCARGACONCEPTOS','ok');
   return onuError;

exception when others then
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuCargaConceptos: '|| osbMsgError;
  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUCARGACONCEPTOS','ERROR');
   return -1;
end fnuCargaConceptos;
------------------------------------------------------------------------------------
function fnuCargaTablaNotas (osbMsgError out varchar2) return number is

  onuError number := 0;
  nupecscons pericose.pecscons%type;
  nuestcorte number;
  nucumin number;
  nucumax number;
  nuconce2 number;
  nusaldoconc number := 0;
  nusaldocc  number := 0;
  nusumanotas number := 0;
  nuconsec number := 0;
  nucontratoante number := -1;
  nucuentaante number := -1;

  cursor cuTablaNotas is
   select sesucicl,sesuesco,
         (select pefacodi from perifact where pefacicl=sesucicl and pefaactu='S') pefacodi,
         (select pefaFIMO from perifact where pefacicl=sesucicl and pefaactu='S') pefafimo,
         (select pefaFFMO from perifact where pefacicl=sesucicl and pefaactu='S') pefaffmo,
         t.*
     from ldc_notas_masivas t, servsusc
    where t.sesion = nusesion -- 492758805
     AND T.MENSERROR is null
     and t.producto = sesunuse
    -- and t.contrato in (48041617,48042194,    48010413, 48041817)
    order by SESION, CONTRATO, PRODUCTO, CUENTA, t.planfina;

  cursor cuPericose (nupecs pericose.pecscons%type) is
   select pc.pecscons
     from perifact pf, pericose pc
    where pc.pecsfecf between pefafimo and pefaffmo
     and pc.pecscico = pefacicl
     and pefacodi=nupecs
     and rownum=1;

  cursor cuValEstCorte (nusesu servsusc.sesunuse%type) is
    select sesuesco
      from servsusc
     where sesunuse = nusesu
       and sesuesco not in (SELECT column_value
                          FROM TABLE (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('EST_CORTE_NO_VALI_DIFE'),',')));

   cursor cuCargos (inucuco cuencobr.cuconuse%type,
                    inuconc cargos.cargconc%type,
                    inuconc2 cargos.cargconc%type,
					inuPlan NUMBER) is
    select sum(decode(cargsign,'CR',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,cargvalo)) cargvalo
      from cargos
     where cargcuco = inucuco
     --  and cargcaca != 62
	   /*and ((cargcaca = 15 and inuconc in (31,17) and inuPlan <> 111)
        or (cargcaca not in (15,62) and inuconc in (31,17) and inuPlan = 111))*/
       and cargconc in (inuconc,inuconc2);

   cursor cuCuenta (inucuco cuencobr.cuconuse%type) is
     select cucosacu
      from cuencobr
     where cucocodi=inucuco;

begin
 -- prActEstaprog('Creando tabla de notas en memoria');
  ldc_proinsertaestaprog(nuparano,nuparmes,'FNUCARGATABLANOTAS','En ejecucion',nusesion,USER);
  for rg in cuTablaNotas loop

     /*if nucuentaante = -1 then
       nucuentaante := rg.cuenta;
     end if;

     if nucuentaante != rg.cuenta then
       open cucuenta(nucuentaante);
       fetch cucuenta into nusaldocc;
       if cucuenta%notfound then
          nusaldocc := 0;
       end if;
       close cucuenta;
       if nvl(nusumanotas,0) > nvl(nusaldocc,0) then
          if not tContExcl.exists(nucontratoante) then
             tContExcl(nucontratoante).contrato := nucontratoante;
          end if;
          tNotas(sbIndNotas).menserror := 'Valor total de las notas (' || nusumanotas || ') mayor al saldo de la cuenta ('|| nusaldocc || ')';
        end if;
       nusumanotas := 0;
       nucuentaante := rg.cuenta;
     end if;*/

     if nucontratoante != rg.contrato then
       nuconsec := 1;
       nucontratoante := rg.contrato;
     else
       nuconsec := nuconsec + 1;
     end if;


     open cuPericose (rg.pefacodi);
     fetch cuPericose into nupecscons;
     if cuPericose%notfound then
        nupecscons := -1;
     end if;
     close cuPericose;

     open cuValEstCorte (rg.producto);
     fetch cuValEstCorte into nuestcorte;
     if cuValEstCorte%notfound then
        nuestcorte := -1;
     end if;
     close cuValEstCorte;

     if tPlandife.exists(rg.planfina) then
        nucumin := tPlandife(rg.planfina).pldicumi;
        nucumax := tPlandife(rg.planfina).pldicuma;
     else
        nucumin := -1;
        nucumax := -1;
     end if;


     if rg.concepto = 31 then
        nuconce2 := 196;
     else
       nuconce2 := rg.concepto;
     end if;

     open cuCargos(rg.cuenta, rg.concepto, nuconce2, RG.PLANFINA  );
     fetch cuCargos into nusaldoconc;
     if cuCargos%notfound then
        nusaldoconc  := 0;
     end if;
     close cuCargos;

     sbIndNotas := lpad(rg.contrato,8,'0') || lpad(nuconsec,4,'0');
     if not tNotas.exists(sbIndNotas) then
        tNotas(sbIndNotas).contrato := rg.contrato;
        tNotas(sbIndNotas).consecut := nuconsec;
        tNotas(sbIndNotas).sesion := rg.sesion;
        tNotas(sbIndNotas).fecha := rg.fecha;
        tNotas(sbIndNotas).producto := rg.producto;
        tNotas(sbIndNotas).cuenta := rg.cuenta;
        tNotas(sbIndNotas).concepto := rg.concepto;
        tNotas(sbIndNotas).causal := rg.causal;
        tNotas(sbIndNotas).valor := rg.valor;
        tNotas(sbIndNotas).signo := rg.signo;
        tNotas(sbIndNotas).diferir := rg.diferir;
        tNotas(sbIndNotas).planfina := rg.planfina;
        tNotas(sbIndNotas).cuotas := rg.cuotas;
        tNotas(sbIndNotas).factura := rg.factura;
        tNotas(sbIndNotas).ctasconsaldo := rg.ctasconsaldo;

        tNotas(sbIndNotas).pefacodi := rg.pefacodi;
        tNotas(sbIndNotas).pecscons := nupecscons;

        tNotas(sbIndNotas).saldoconc := nusaldoconc;
        tNotas(sbIndNotas).saldocuen := null;
        tNotas(sbIndNotas).conssubs := RG.conssubs;
        nusumanotas := nusumanotas + rg.valor;

        if rg.pefacodi is null or nupecscons = -1 or
           sysdate not between rg.pefafimo and rg.pefaffmo then
           tNotas(sbIndNotas).menserror := 'Ciclo no tiene periodo activo o la fecha actual no esta dentro del periodo activo';
        elsif nuestcorte = -1 then
           tNotas(sbIndNotas).menserror := 'Estado de Corte no Valido para Diferidos';
        elsif rg.cuotas not between nucumin and nucumax then
           tNotas(sbIndNotas).menserror := 'Nro de Cuotas no esta dentro del rango minimo y maximo del plan';
        elsif nusaldoconc < rg.valor then
           tNotas(sbIndNotas).menserror := 'Valor a diferir mayor que saldo del concepto ('|| nusaldoconc || ')';
        else
           tNotas(sbIndNotas).menserror := null;
        end if;

        if tNotas(sbIndNotas).menserror is not null then
           if not tContExcl.exists(rg.contrato) then
             tContExcl(rg.contrato).contrato := rg.contrato;
           end if;
        end if;


     end if;
   end loop;

   -- valida ultima cuenta
   /*if nvl(nusumanotas,0) > nvl(nusaldocc,0) then
      if not tContExcl.exists(nucontratoante) then
         tContExcl(nucontratoante).contrato := nucontratoante;
      end if;
      tNotas(sbIndNotas).menserror := 'Valor total de las notas (' || nusumanotas || ') mayor al saldo de la cuenta ('|| nusaldocc || ')';
   end if;*/

  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUCARGATABLANOTAS','ok');
   return onuError;

exception when others then
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuCargaPlanes: '|| osbMsgError;
  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUCARGATABLANOTAS','ERROR');
  RETURN -1;
end fnuCargaTablaNotas;
-------------------------------------------------------------------------------------
function  fnuGeneBillingNote (osbMsgError out varchar2) return number is
nucont number := 0;
onuError number := 0;
nunotanume  notas.notanume%type;
nunota      notas.notanume%type;
sbsigdocsop varchar2(3) := 'FD';
sbsignota   varchar2(3) := 'CR';
sbObserv varchar2(500) := 'PRUEBA';
gnuTipoDocumento    ge_document_type.document_type_id%type := 71;
sbErrMsg varchar2(2000) := null;
sbMsgDife varchar2(2000) := null;

nusumanotas number :=0;

rcCargoNull   cargos%rowtype;
regNotas     NOTAS%ROWTYPE;
nuPrograma   number := dald_parameter.fnugetnumeric_value('LDC_PRGCPRPA',null);--se almacena programa que genera el cargo
nuProgNota   number := dald_parameter.fnugetnumeric_value('LDC_PRGNPRPA',null);--se almacena programa que genera el cargo
rcCargo      cargos%rowtype ;
nuErrDife    number;
nuCuentaAnte number := -1;
nuProductoAnte number := -1;
nuPlanCrDfAnte number := -1;
nuDifeCofi     diferido.difecofi%type;
sbHayError    varchar2(1) := 'N';
nuContratoAnte number := -1;

cursor cuCuenta (inucuco cuencobr.cuconuse%type) is
 select cucosacu
   from cuencobr
  where cucocodi=inucuco;

BEGIN
 --prActEstaprog('Generando Notas y Diferidos');
  ldc_proinsertaestaprog(nuparano,nuparmes,'FNUGENEBILLINGNOTE','En ejecucion',nusesion,USER);

 sbIndNotas :=  tNotas.first;
 loop exit when (sbIndNotas IS null);
   if not tContExcl.exists(tNotas(sbIndNotas).contrato) then
     if nuCuentaAnte != tNotas(sbIndNotas).cuenta then
        if nuCuentaAnte != -1 and nusumanotas > 0 then
          if fnuActuSaldoCC(nucontratoante, nucuentaante, nusumanotas) = 'N' then
            sbHayError := 'S';
            ----nusumanotas := 0;
            rollback;
          end if;
        end if;

        if nuContratoAnte != tNotas(sbIndNotas).contrato or sbHayError = 'S' then
          if nuContratoAnte != -1 and nusumanotas > 0 then
            if sbHayError = 'S' then
              rollback;
            else
              commit;
            end if;
          end if;

          if nuContratoAnte != tNotas(sbIndNotas).contrato then
            nuContratoAnte := tNotas(sbIndNotas).contrato;
            sbHayError := 'N';
          end if;
       end if;

    if sbHayError = 'N' then
     PKBILLINGNOTEMGR.GETNEWNOTENUMBER(nunotanume);
     regNotas.NOTANUME := nunotanume ;
     regNotas.NOTASUSC := tNotas(sbIndNotas).contrato ;
     regNotas.NOTAFACT := tNotas(sbIndNotas).factura ;
     regNotas.NOTATINO := 'C' ;
     regNotas.NOTAFECO := SYSDATE ;
     regNotas.NOTAFECR := SYSDATE ;
     regNotas.NOTAPROG := nuProgNota ;
     regNotas.NOTAUSUA := 1 ;
     regNotas.NOTATERM := sbgTerminal;
     regNotas.NOTACONS := 71;
     regNotas.NOTANUFI := NULL;
     regNotas.NOTAPREF := NULL;
     regNotas.NOTACONF := NULL;
     regNotas.NOTAIDPR := NULL;
     regNotas.NOTACOAE := NULL;
     regNotas.NOTAFEEC := NULL;
     regNotas.NOTAOBSE := 'GENERACION DE NOTA POR CONTIGENCIA' ;
     regNotas.NOTADOCU := NULL ;
     regNotas.NOTADOSO := 'NC-' || nunotanume ;
     PKTBLNOTAS.INSRECORD(regNotas);
    end if;
     nuCuentaAnte := tNotas(sbIndNotas).cuenta;
     nusumanotas := 0;
   end if;

   if sbHayError = 'N' then
     rcCargo := rcCargoNull ;

     rcCargo.cargcuco := tNotas(sbIndNotas).cuenta;
     rcCargo.cargnuse := tNotas(sbIndNotas).producto ;
     rcCargo.cargpefa := tNotas(sbIndNotas).pefacodi;
     rcCargo.cargconc := tNotas(sbIndNotas).concepto ;
     rcCargo.cargcaca := tNotas(sbIndNotas).causal;
     rcCargo.cargsign := tNotas(sbIndNotas).signo ; -- CR
     rcCargo.cargvalo := tNotas(sbIndNotas).valor ;
     /*rcCargo.cargdoso := 'NC-'||nunotanume;*/ -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
     rcCargo.cargtipr := 'P'/* pkBillConst.AUTOMATICO*/;
     rcCargo.cargfecr := SYSDATE ;
     rcCargo.cargcodo := nunotanume; --  DEBE SER  numero de la nota
     rcCargo.cargunid := 0 ;
     rcCargo.cargcoll := null ;
     rcCargo.cargpeco := tNotas(sbIndNotas).pecscons; -- nuPeriCons ;
     rcCargo.cargprog := nuPrograma; --
     rcCargo.cargusua := 1;

     nusumanotas := nusumanotas + tNotas(sbIndNotas).valor;

     if nuProductoAnte != tNotas(sbIndNotas).producto or nuPlanCrDfAnte != tNotas(sbIndNotas).planfina   then
    -- Se asigna el consecutivo de financiacion
        pkDeferredMgr.nuGetNextFincCode(nuDifeCofi);
        nuProductoAnte := tNotas(sbIndNotas).producto;
        nuPlanCrDfAnte := tNotas(sbIndNotas).planfina;
     end if;

     -- crea el diferido
     nuErrDife := fnuCreaDiferidos (tNotas(sbIndNotas).contrato,
                                 tNotas(sbIndNotas).producto,
                                 tNotas(sbIndNotas).concepto,
                                 tNotas(sbIndNotas).planfina,
                                 tNotas(sbIndNotas).valor,
                                 tNotas(sbIndNotas).cuotas,
                                 'ND-'||nunotanume,
                                 nuDifeCofi,
                                 sbMsgDife);

     if sbMsgDife is not null then
        tNotas(sbIndNotas).menserror := 'Error creando Diferido: ' || sbMsgDife;
        sbHayError := 'S';
        nusumanotas := 0;
        rollback;
        if not tContExcl.exists(tNotas(sbIndNotas).contrato) then
          tContExcl(tNotas(sbIndNotas).contrato).contrato := tNotas(sbIndNotas).contrato;
        end if;

     else
        rcCargo.cargdoso := 'FD-' || nuDiferido;
        -- Adiciona el Cargo
        pktblCargos.InsRecord (rcCargo);
      /*  commit;*/
     end if;

    end if;

   end if;


   sbIndNotas := tNotas.next(sbIndNotas);
   nucont := nucont + 1;
 end loop;

 if nusumanotas > 0 then
   if fnuActuSaldoCC(nucontratoante, nucuentaante, nusumanotas) = 'N' then
     rollback;
   else
     commit;
   end if;
 end if;

 ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUGENEBILLINGNOTE','OK');
 return onuError;

exception when others then
  rollback;
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuGeneBillingNote: '|| osbMsgError;
   ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUGENEBILLINGNOTE','ERROR');
  return (-1);
end fnuGeneBillingNote;
-------------------------------------------------------------------------------------
function fnuCreaDiferidos (inucontrato in number,
                          inuproducto in number,
                          inuconcepto in number,
                          inuplanfina in number,
                          inuvalor in number,
                          inucuotas in number,
                          isbdoso   in varchar2,
                          inuDifeCofi in number,
                          osbMsgError out varchar2) return number is

  onuError number := 0;
  sbUserDataBase funciona.funcusba%type;
  rcFunciona     funciona%rowtype;
  nuConcInteres   number;
  nuDiasGrac      number;
  nucodpergr      number;
  nuTaincodi      number;
  nuInteRate      number;
  nuconadife  diferido.difeconc%type;
  nuGrace_peri_defe_id  cc_grace_peri_defe.grace_peri_defe_id%type;

begin

  onuError := 0;
  osbMsgError := null;

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
   end if;

  nuCodFinanc := inuDifeCofi;

  onuError := CreateDeferred(inuDifeCofi, -- Cod.Financiacion
                   inucontrato,
                   nuconadife, /*nuConcepto*/ -- Concepto
                   inuvalor, -- Valor
                   inucuotas, -- Cuotas
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
                   osbMsgError ); -- isbSimulate);

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
       --dbms_output.put_line(nuDiferido);


   return onuError;

exception when others then
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuCargaPlanes: '|| osbMsgError;
end fnuCreaDiferidos;

---------------------------------------
function CreateDeferred(inuFinanceCode        in diferido.difecofi%type,
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
                           osbMsgError out varchar2) return number IS

    onuError           number := 0;
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

    BEGIN
      --{
    ut_trace.trace('Armando registro para diferido ' ||
                     nuIdxDife,
                     cnuNivelTrace);
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


      UT_Trace.Trace('Fin CC_BOFinancing.CommitFinanc.AddDeferred',
                     cnuNivelTrace + 1);

      /*if (sbSignoDife = pkBillConst.DEBITO) then
        nuSigno := pkBillConst.cnuSUMA_CARGO;
      elsif (sbSignoDife = pkBillConst.CREDITO) then
        nuSigno := pkBillConst.cnuRESTA_CARGO;
      end if;

      -- Actualiza acumulador total de la financiacion
      UT_Trace.Trace('Acumulando valor de diferido ' ||
                     to_char(nuSigno * nuValorDife),
                     cnuniveltrace + 1);
      nugAcumFinancing := nugAcumFinancing + nuSigno * nuValorDife;
      UT_Trace.Trace('Nuevo acumulado = ' || nugAcumFinancing,
                     cnuNivelTrace + 1);*/



    EXCEPTION

     /* when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or
           ex.CONTROLLED_ERROR then
        raise;*/

      when OTHERS then
      --   PK_FC_GRABALOG.pro_fc_grabalog('DIFERIDO CREAR','ERROR: ' || SQLERRM);
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
        --}
    END FillDefMemTab;

    /* -------------------------------------------------------------- */
    /*
    Procedure : FillTransDefMemTab
    Descripcion : Llena la Tabla de memoria de Mvmto. Diferido
              Fill Transaction Deferred Memory Table
      */
    PROCEDURE FillTransDefMemTab IS
      /* Tipo de producto asociado al producto */
     /* nuProductType servicio.servcodi%type;

      \* Causa de cargo para el movimiento *\
      nuChargeCause causcarg.cacacodi%type;*/

      rcMoviDife movidife%rowtype;
    BEGIN
      --{


      /* Se obtiene el tipo de producto */
     /* nuProductType := pktblServsusc.fnuGetService(nugNumServ);

      \* Se obtiene causa de cargo para paso a diferido (43) *\
      nuChargeCause := FA_BOChargeCauses.fnuDeferredChCause(nuProductType);*/

       -- Arma record de movimiento de diferido
      ut_trace.trace('Armando registro de movimiento para el diferido ' ||
                     nuIdxDife,
                     cnuNivelTrace);
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

    ut_trace.trace('FIN: cc_boFinancing.CommitFinanc.AddTransDef',
                     cnuNivelTrace + 1);

    EXCEPTION

      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or
           ex.CONTROLLED_ERROR then
        raise;

      when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
        --}
    END FillTransDefMemTab;
 /* -------------------------------------------------------------- */

  BEGIN

 -- Obtiene proximo numero de diferido
      pkDeferredMgr.GetNewDefNumber(nuIdxDife);

 -- asigna el numero de diferido a variable de paquete
    nuDiferido := nuIdxDife;

    -- Averigua si se trata de un concepto de Interes
    if (nvl(isbSrcConceptInterest, csbNO) = csbYES) then
      --{
      UT_Trace.Trace('Se detecto concepto de interes, el interes para el diferido sera CERO',
                     cnuNiveltrace + 1);
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
      UT_Trace.Trace('Valor del diferido CERO, no sera creado',
                     cnuNivelTrace + 1);
      osbMsgError := 'Error en CreateDeferred: ' || ' Valor del diferido CERO, no sera creado';
      return (-1);
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

    -- Adiciona cuotas extras a los diferidos que no corresponden
    -- a conceptos IVA
   /* FillAditionalInstalments(nuValorDife,
                             sbSignoDife,
                             ichIVA,
                             iblLastRecord);*/

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

    UT_Trace.Trace('? Cuota < Primer Interes ? => ? ' || nuValorCuota ||
                   ' < ' || to_char(nuVlr * nuLocPorIntNominal /
                                    pkBillConst.CIENPORCIEN) || ' ?',
                   cnuNivelTrace + 1);

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

     return onuError;

  EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or ex.CONTROLLED_ERROR then
       ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en CreateDeferred: '|| osbMsgError;
  return (-1);

    when OTHERS then
       ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en CreateDeferred: '|| osbMsgError;
  return (-1);
  END CreateDeferred;

  ----------------------------
 FUNCTION fsbGetFuncionaDataBase RETURN funciona.funccodi%type IS

      sbUserDataBase funciona.funcusba%type;
      rcFunciona     funciona%rowtype;

    BEGIN
      --{
      /*UT_Trace.Trace('CC_BOFinancing.FinancingDebt.fsbGetFuncionaDataBase',
                     cnuNivelTrace);*/

      --Obtiene usuario de base de datos
      sbUserDataBase := pkgeneralservices.fsbGetUserName;

      --Obtiene record del funcionario asociado al usuario de la base de datos
      rcFunciona := pkbcfunciona.frcFunciona(sbUserDataBase);

      return rcFunciona.funccodi;

    EXCEPTION

      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or
           ex.CONTROLLED_ERROR then
        raise;

      when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
        --}
    END fsbGetFuncionaDataBase;

 -------------------------------------------------------------------------------------
function  fnuActualizaCC (osbMsgError out varchar2) return number is
nucont number := 0;
onuError number := 0;

cursor cuCuentas is
select cuenta,
       contrato,
       (select sum(decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,cargvalo))
          from cargos
         where cargcuco=cuenta
           and cargsign != 'PA') saldocc
from (
select distinct cuenta, contrato
  from ldc_notas_masivas t
where t.sesion = nusesion);
 /*and t.contrato IN (48041617,48042194,    48010413, 48041817) );*/


BEGIN
 --prActEstaprog('Actualizando Cuentas');
 ldc_proinsertaestaprog(nuparano,nuparmes,'FNUACTUALIZACC','En ejecucion',nusesion,USER);
 for rg in cuCuentas loop
   if not tContExcl.exists(rg.contrato) then
     update cuencobr
        set cucovato = nvl(rg.saldocc,0)
      where cucocodi = rg.cuenta;
    nucont := nucont + 1;

    if nvl(rg.saldocc,0) < 0 then
      sbIndNotas := lpad(rg.contrato,8,'0') || '0001';
      if tNotas.exists(sbIndNotas) then
        tNotas(sbIndNotas).menserror := 'CC CON SALDO NEGATIVO .' || tNotas(sbIndNotas).menserror;
      end if;
    end if;

    if mod(nucont,1000) = 0 then
       commit;
    end if;
   end if;
 end loop;
 commit;
 ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUACTUALIZACC','ok');
 return onuError;

exception when others then
  rollback;
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuGeneBillingNote: '|| osbMsgError;
  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUACTUALIZACC','ERROR');
  return (-1);
end fnuActualizaCC;
-------------------------------------------------------------------------------------
function  fnuInsertLog (osbMsgError out varchar2) return number is
nucont number := 0;
onuError number := 0;
nunotanume  notas.notanume%type;
nunota      notas.notanume%type;
sbsigdocsop varchar2(3) := 'FD';
sbsignota   varchar2(3) := 'CR';
sbObserv varchar2(500) := 'PRUEBA';
gnuTipoDocumento    ge_document_type.document_type_id%type := 71;
sbErrMsg varchar2(2000) := null;
sbMsgDife varchar2(2000) := null;


BEGIN
 --prActEstaprog('Creando tabla de Log');
 ldc_proinsertaestaprog(nuparano,nuparmes,'FNUINSERTLOG','En ejecucion',nusesion,USER);
 sbIndNotas :=  tNotas.first;
 loop exit when (sbIndNotas IS null);

  if not tContExcl.exists(tNotas(sbIndNotas).contrato) then
    if tNotas(sbIndNotas).menserror is null then
      tNotas(sbIndNotas).menserror := 'Procesado';
    end if;
  else
    if tNotas(sbIndNotas).menserror is null then
      tNotas(sbIndNotas).menserror := 'No se proceso por error en una de las notas';
    end if;
  end if;

  insert into ldc_notas_masivas_log (sesion, fecha,
                                     contrato, producto, cuenta,
                                     concepto, causal, valor,
                                     signo, diferir, planfina,
                                     cuotas, menserror,
                                     ctasconsaldo, factura, CONSSUBS)

          values (tNotas(sbIndNotas).sesion, tNotas(sbIndNotas).fecha,
                 tNotas(sbIndNotas).contrato, tNotas(sbIndNotas).producto, tNotas(sbIndNotas).cuenta,
                 tNotas(sbIndNotas).concepto, tNotas(sbIndNotas).causal, tNotas(sbIndNotas).valor,
                 tNotas(sbIndNotas).signo, tNotas(sbIndNotas).diferir, tNotas(sbIndNotas).planfina,
                 tNotas(sbIndNotas).cuotas, tNotas(sbIndNotas).menserror,
                 tNotas(sbIndNotas).ctasconsaldo, tNotas(sbIndNotas).factura, tNotas(sbIndNotas).CONSSUBS);


      sbIndNotas := tNotas.next(sbIndNotas);
      nucont := nucont + 1;
      if mod(nucont,1000) = 0 then
        commit;
      end if;
 end loop;
 commit;
  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUINSERTLOG','ok');
 return onuError;

exception when others then
  rollback;
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuGeneBillingNote: '|| osbMsgError;
  ldc_proactualizaestaprog(nusesion,osbMsgError,'FNUINSERTLOG','ERROR');
  return (-1);
end fnuInsertLog;
-------------------------------------------------------------------------------------
function  fnuActuSaldoCC  (inucontrato  in servsusc.sesususc%type,
                           inucuenta    in cuencobr.cucocodi%type,
                           inuvlrnotas  in number) return varchar2 is

sbValido    varchar2(1);
onuError    number;
osbMsgError varchar2(2000);
sbInd       varchar2(12);
nucons      number(1) := 1;
nusaldocc   number :=0;
nuvalorabo  number :=0;

cursor cuCuenta is

  select sum(decode(cargsign,'CR',-cargvalo,'DB',cargvalo)) cucovato,
         sum(decode(cargsign,'PA',cargvalo, 'AS', cargvalo,'AP',-cargvalo)) cucovaab
    from cargos
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
    update cuencobr
       set cucovato = nvl(nusaldocc,0)
     where cucocodi = inucuenta;
     sbValido := 'S';
 else
    sbValido := 'N';
    if not tContExcl.exists(inucontrato) then
       tContExcl(inucontrato).contrato := inucontrato;
    end if;
    sbInd := lpad(inucontrato,8,'0') || lpad(nucons,4,'0');
    tNotas(sbInd).menserror := 'Valor total de las notas (' || inuvlrnotas || ') mayor al saldo conque quedaria la cuenta ('|| nusaldocc || ')';
 end if;

 return sbValido;

exception when others then
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en fnuSaldoValido: '|| osbMsgError;
  return ('N');
end fnuActuSaldoCC;
-------------------------------------------------------------------------------------
procedure prActEstaprog (isbmensaje in varchar2) is
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  UPDATE ldc_osf_estaproc l
    SET estado = isbmensaje
  WHERE l.sesion = nusesion
    AND l.proceso = 'PRFINADEUDPCONTI';
 COMMIT;
end;

END ldc_pkgenotadife;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGENOTADIFE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGENOTADIFE', 'ADM_PERSON');
END;
/
