CREATE OR REPLACE PACKAGE LDC_PKFAPC is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PKFAPC
    Descripcion    : Paquete donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    17/07/2019        horbath           caso 200-2461. Se crea funcion FNCVALIDATARIFANUSE para determinar tarifa que deberia ser aplicada a los conceptos 17 y 31
    24/11/2020        horbath           CA291 - Se modifican todas las auditorias (ver documento de entrega)
    23/04/2024        jpinedc           OSF-2580 - Se cambia ldc_sendemail por pkg_Correo
    =========         =========         ====================*/


    nuprodu   conssesu.cosssesu%type;
    nupefa    perifact.pefacodi%type;
    nupecs    pericose.pecscons%type;
    numecc    conssesu.cossmecc%type;
    nucavc    conssesu.cosscavc%type;
    nuconsu   number;
    nucant    number := 0;
    nuperiant1 conssesu.cosspefa%type;
    nuperiant2 conssesu.cosspefa%type;
    nuperiant3 conssesu.cosspefa%type;
    dtfefiant1 conssesu.cossfere%type;
    dtfefiant2 conssesu.cossfere%type;
    dtfefiant3 conssesu.cossfere%type;

    nucantrecu conssesu.cossnvec%type;
    nuconsrecu conssesu.cosscoca%type;
    nuconsrean conssesu.cosscoca%type;

   TYPE rcCons IS RECORD(
    consumo  conssesu.cosscoca%type,
    cosscavc conssesu.cosscavc%type,
    cossmecc conssesu.cossmecc%type,
    consant1 conssesu.cosscoca%type,
    consant2 conssesu.cosscoca%type,
    consant3 conssesu.cosscoca%type);


  TYPE tbcons IS TABLE OF rccons INDEX BY BINARY_INTEGER;

  tcons tbcons;
  nuIdx BINARY_INTEGER;

  cursor cuConsumos (nupefa perifact.pefacodi%type) is
   select cosssesu, cossfere, cossmecc, cosscoca, cosscavc, c.cosspecs, c.cossflli, c.cossfufa
     from open.conssesu c
    where cosspefa=nupefa
   order by cosssesu, cossfere;


  cursor cuperifact (nucicl perifact.pefacicl%type, nuano perifact.pefaano%type, numes perifact.pefames%type) is
   select pf.pefacodi, pc.pecscons
     from open.perifact pf
   left outer join open.pericose pc on (pf.pefacicl = pc.pecscico and pc.pecsfecf between pf.pefafimo and pf.pefaffmo)
   where pf.pefacicl = nucicl
     and pf.pefaano = nuano
     and pf.pefames = numes;

  cursor cuCavc (nusesu conssesu.cosssesu%type, nupefa perifact.pefacodi%type, dtfere conssesu.cossfere%type) is
   select cosscavc
     from open.conssesu c
    where cosssesu = nusesu
      and cosspefa = nupefa
      and cossfere = dtfere
      and cossmecc = 1;


   cursor cuMecc (nusesu conssesu.cosssesu%type, nupefa perifact.pefacodi%type, dtfere conssesu.cossfere%type) is
   select cossmecc
     from open.conssesu c
    where cosssesu = nusesu
      and cosspefa = nupefa
      and cossfere = dtfere
      and cossmecc != 4;


   cursor cuPeriAnte (nuperi perifact.pefacodi%type, nucicl perifact.pefacicl%type) is
    select pefacodi, pefaffmo
      from open.perifact
     where pefacicl=nucicl
       and pefacodi<nuperi
   order by pefacodi desc;


   cursor cuConsAnte (nupefa perifact.pefacodi%type, dtfefin date) is
    select cosssesu, sum(decode(cossmecc,4,cosscoca,0)) consumo
     from open.conssesu c
    where cosspefa=nupefa
      and cossfere < dtfefin
  group by cosssesu;



function fnuGetDatosConsumo (inuprod conssesu.cosssesu%type,
                             sbDato varchar2) return number;

function FNCVALIDATARIFANUSE(pvalor_tarifa number,fechainicialperiodo date, fechafinalperiodo date,pfechatarifa date, pcate number,
psuca number,pmerele number,pmetros number,pconc number) return number;

function fdtdevuelvefecha(dti date, dtf date) return date ;

procedure proGeneraAuditorias (inuano perifact.pefaano%type,
                               inumes perifact.pefaano%type,
                               inucicl perifact.pefaano%type,
                               isbEmail  VARCHAR2);

 PROCEDURE PRGENEAUDPOSTXPROD( inuano IN  perifact.pefaano%type,
                               inumes IN  perifact.pefaano%type,
                               inuCiclo  IN NUMBER,
                               inuproducto IN NUMBER,
                               onuValida out number);
  /*******************************************************************************
     Metodo:       PRGENEAUDPOSTXPROD
     Descripcion:  Proceso que valida si hubo problema de auditorias posteriores
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion
       inuano         a?o
       inuMes         mes
       inuCiclo       ciclo
       inuproducto   PRODUCTO

     Salida             Descripcion
      onuValida       decuelve si el producto tiene auditoria posteriores
     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 function fnuGetPericoseAnt   (inupefa perifact.pefacodi%type) return number;

function fnuGetTarifa   (inupeco       in pericose.pecscons%type,
                         inuconc       in cargos.cargconc%type,
                         inucate       in servsusc.sesucate%type,
                         inusuca       in servsusc.sesusuca%type,
                         inumere       in fa_locamere.lomrmeco%type,
                         inuunid       in cargos.cargunid%type) return varchar2;

 function fnuGetUltConsValido   (inuprod conssesu.cosssesu%type,
                                inupefa perifact.pefacodi%type) return number;

function fnuGetRegla2020   (inuprod conssesu.cosssesu%type,
                           inupefa perifact.pefacodi%type) return varchar2;

function fnuGetCambMedidor   (inuprod conssesu.cosssesu%type,
                              inupefa perifact.pefacodi%type) return varchar2 ;

function fnuGetSuspxAcom   (inuprod conssesu.cosssesu%type,
                            sbSuspACO  ld_parameter.value_chain%type) return varchar2 ;

function fnuHallaPromedio   (inuprod conssesu.cosssesu%type,
                             inupefa perifact.pefacodi%type,
                             inucate servsusc.sesucate%type,
                             inusuca servsusc.sesusuca%type,
                             inuano  perifact.pefaano%type,
                             inumes  perifact.pefames%type) return number ;

  PROCEDURE prGeneraArchiExcel( inuano IN NUMBER,
                                inumes IN NUMBER,
                                inuCiclo IN NUMBER,
                                inuProducto IN NUMBER) ;
   /*******************************************************************************
     Metodo:       prGeneraArchiExcel
     Descripcion:  Proceso que genera archivo de excel
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion
       inuano         a?o
       inuMes         mes
       inuCiclo       ciclo
       inuproducto   PRODUCTO

     Salida             Descripcion

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/
end LDC_PKFAPC;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKFAPC is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PKFAPC
    Descripcion    : Paquete donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
	17/07/2019        horbath           caso 200-2461. Se crea funcion FNCVALIDATARIFANUSE para determinar tarifa que deberia ser aplicada a los conceptos 17 y 31
  24/11/2020        horbath           CA291 - Se modifican todas las auditorias (ver documento de entrega)
    =========         =========         ====================*/

-----------------------------------------------------------------------
function fnuGetPericoseAnt   (inupefa perifact.pefacodi%type) return number is
 /*******************************************************************************
     Metodo:       fnuGetPericoseAnt
     Descripcion:  Funcion que halla el periodo d econsumo anterior
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada        Descripcion
      inupefa:     Codigo periodo de Facturacion

     Salida         Descripcion
      nupecsante    Periodo de consumo anterior

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 nupecsante pericose.pecscons%type;

cursor cuPericose is
select p2.pecscons
  from perifact p1, pericose p2
 where p2.pecsfecf between p1.pefafimo and p1.pefaffmo
   and p2.pecscico = p1.pefacicl
   and p1.pefacodi = pkbillingperiodmgr.fnugetperiodprevious(inupefa);

begin
  open cuPericose;
  fetch cuPericose into nupecsante;
  if cuPericose%notfound then
    nupecsante := -1;
  end if;
  close cuPericose;

 return nupecsante;
exception when others then
  return (-1);
end fnuGetPericoseAnt;

-----------------------------------------------------------------------
function fnuGetTarifa   (inupeco       in pericose.pecscons%type,
                         inuconc       in cargos.cargconc%type,
                         inucate       in servsusc.sesucate%type,
                         inusuca       in servsusc.sesusuca%type,
                         inumere       in fa_locamere.lomrmeco%type,
                         inuunid       in cargos.cargunid%type) return varchar2 is

/*******************************************************************************
     Metodo:       fnuGetTarifa
     Descripcion:  Funcion que devuelve la tarifa que debe aplicarse segun el concepto categoria estrato mercado y unidades dadas.
                   Devuelve ademas otros datos que se requieren para la auditoria de Tarifas incorrectas (devuelve cadena concatenada)

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada        Descripcion
      inupeco:     Codigo periodo de consumo
      inuconc      concepto (17 o 31)
      inucate      categoria
      inusuca      subcategoria
      inumere      mercado relevante
      inuunid      unidades facturadas

     Salida         Descripcion
      OSBTARIFA    Concatena descripcion d ela tarifa, codigo de la tarifa, fecha inicial vigencia, fecha final de vigencia,
                   rango en qu cayeron los mt3 y valor de la tarifa (para consumo multiplica el valor por los mt3)

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/



 dtfeini date;
 dtfefin date;
 idtfecr date;
 nuvalortarifa cargos.cargvalo%type := 0;
 nudiasmesactu number;
 nudiasmesante number;

 osbdesctari   varchar2 (200);
 onutaco       ta_vigetaco.vitctaco%type;
 odtfein       date;
 odtfefi       date;
 osbrango      varchar2 (200);

 OSBTARIFA VARCHAR2(500)  := NULL;


cursor cuPericose is
select p2.pecsfeci, p2.pecsfecf
  from pericose p2
 where p2.pecscons = inupeco;

 cursor cutarifa17 (dtfecha date) is
 SELECT d.vitccons || ' - ' || a.tacodesc, d.vitctaco, d.vitcfein, d.vitcfefi, e.ravtliin || ' - '  || e.ravtlisu Rango,  vitcvalo
   FROM open.ta_tariconc a
   left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
   left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
   left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
   left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
   left outer join open.concepto f  on (f.conccodi = b.cotcconc)
  WHERE cotcconc = 17
    and a.tacocr02 = inucate
    and a.tacocr01 = inusuca
    and a.tacocr03 = inumere
    and dtfecha between d.vitcfein and d.vitcfefi;

 cursor cutarifa31 (dtfecha date) is
  SELECT  d.vitccons || '-' || tacodesc, d.vitctaco, d.vitcfein, d.vitcfefi, e.ravtliin || ' - '  || e.ravtlisu Rango, ravtvalo
   FROM open.ta_tariconc a
    left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
    left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
    left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
    left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
    left outer join open.concepto f  on (f.conccodi = b.cotcconc)
  WHERE cotcconc = 31
    and a.tacocr02 = inucate
    and a.tacocr01 = inusuca
    and a.tacocr03 = inumere
    and inuunid between ravtliin and ravtlisu
    and dtfecha between d.vitcfein and d.vitcfefi;


begin
  open cuPericose;
  fetch cuPericose into dtfeini, dtfefin;
  if cuPericose%notfound then
    dtfeini := null;
  end if;
  close cuPericose;

  nudiasmesactu := dtfefin - TRUNC(dtfefin,'MM');
  nudiasmesante := LAST_DAY(TRUNC(dtfeini)) - dtfeini;

  if nudiasmesactu >= nudiasmesante then
    idtfecr := dtfefin;
  else
     idtfecr := dtfeini;
  end if;

  if inuconc = 17 then
    open cutarifa17 (idtfecr);
    fetch cutarifa17 into osbdesctari , onutaco, odtfein, odtfefi, osbrango,  nuvalortarifa;
    if cutarifa17%notfound then
      nuvalortarifa := 0;
    end if;
    close cutarifa17;

  elsif inuconc = 31 then
    open cutarifa31 (idtfecr);
    fetch cutarifa31 into osbdesctari, onutaco, odtfein, odtfefi, osbrango,  nuvalortarifa;
    if cutarifa31%notfound then
      nuvalortarifa := 0;
    else
      nuvalortarifa := round(nuvalortarifa * inuunid);
    end if;
    close cutarifa31;
  else
    nuvalortarifa := 0;
  end if;

  OSBTARIFA := osbdesctari || '|' || onutaco|| '|' || TO_CHAR(odtfein,'DD/MM/YYYY')|| '|' || TO_CHAR(odtfefi,'DD/MM/YYYY')|| '|' || osbrango|| '|' ||  nuvalortarifa;

  return OSBTARIFA;

exception when others then
  OSBTARIFA := NULL|| '|' || NULL|| '|' || NULL|| '|' || NULL|| '|' || NULL|| '|' ||  NULL;
  return OSBTARIFA;
end fnuGetTarifa;

-----------------------------------------------------------------------
function fnuGetUltConsValido   (inuprod conssesu.cosssesu%type,
                                inupefa perifact.pefacodi%type) return number is

/*******************************************************************************
     Metodo:       fnuGetUltConsValido
     Descripcion:  Funcion que devuelve el ultimo consumo valido de un producto

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa      Codigo periodo de facturacion

     Salida         Descripcion
      nuConsumo    Ultimo consumo valido

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 nuConsumo conssesu.cosscoca%type;

cursor cuConsumos is
select cosscoca
  from conssesu c2
 where c2.cosssesu = inuprod
   and c2.cosspefa < inupefa
   and c2.cossmecc = 1
   and c2.cossfere = (select max(c.cossfere)
                     from open.conssesu c
                    where c.cosssesu=c2.cosssesu
                      and c.cosspefa=c2.cosspefa
                      and c.cossmecc !=4)
order by cossfere desc;

begin
  open cuConsumos;
  fetch cuConsumos into nuConsumo;
  if cuConsumos%notfound then
    nuConsumo := -1;
  end if;
  close cuConsumos;

 return nuConsumo;
exception when others then
  return (-1);
end fnuGetUltConsValido;
-----------------------------------------------------------------------
function fnuGetRegla2020   (inuprod conssesu.cosssesu%type,
                           inupefa perifact.pefacodi%type) return varchar2 is

/*******************************************************************************
     Metodo:       fnuGetRegla2020
     Descripcion:  Funcion que devuelve si el producto entro a la regla 2020 en el periodo dado

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa      Codigo periodo de facturacion

     Salida         Descripcion
      sbCons2020    S - entro a la regla 2020
                    N - No entro

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 sbCons2020 varchar2(1);

cursor cuCons2020 is
select 'S'
  from conssesu
 where cosssesu=inuprod
   and cosspefa=inupefa
   and cossmecc=1
   and cosscavc=2020;

begin
  open cuCons2020;
  fetch cuCons2020 into sbCons2020;
  if cuCons2020%notfound then
    sbCons2020 := 'N';
  end if;
  close cuCons2020;

 return NVL(sbCons2020,'N');
exception when others then
  return ('N');
end fnuGetRegla2020;

-----------------------------------------------------------------------
function fnuGetCambMedidor   (inuprod conssesu.cosssesu%type,
                              inupefa perifact.pefacodi%type) return varchar2 is

/*******************************************************************************
     Metodo:       fnuGetCambMedidor
     Descripcion:  Funcion que devuelve si el producto tuvo cambio de medidor en el periodo dado

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa      Codigo periodo de facturacion

     Salida         Descripcion
      sbCambMed    S - Hubo cambio de medidor
                   N - No hubo cambio de medidor

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 sbCambMed varchar2(1);

cursor cuCambMed is
select 'S'
  from lectelme
 where leemsesu=inuprod
   and leempefa=inupefa
   and leemclec='I';


begin
  open cuCambMed;
  fetch cuCambMed into sbCambMed;
  if cuCambMed%notfound then
    sbCambMed := 'N';
  end if;
  close cuCambMed;

 return NVL(sbCambMed,'N');
exception when others then
  return ('N');
end fnuGetCambMedidor;

-----------------------------------------------------------------------
function fnuGetSuspxAcom   (inuprod conssesu.cosssesu%type,
                            sbSuspACO  ld_parameter.value_chain%type) return varchar2 is

/*******************************************************************************
     Metodo:       fnuGetSuspxAcom
     Descripcion:  Funcion que devuelve si el producto esta suspendido por acometida o no

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      sbSuspACO    Actividades de suspension de acometida

     Salida         Descripcion
      sbSuspendAcom    S - Esta suspendido por acometida
                       N - No esta suspendido por acometida

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 sbSuspendAcom varchar2(1) := 'N';
 nuprodstat     PR_PRODUCT.PRODUCT_STATUS_ID%TYPE;
 nususpordacti  PR_PRODUCT.SUSPEN_ORD_ACT_ID%TYPE;
 nuactividad_id OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;

cursor cuSuspAcom is
 select p.product_status_id, p.suspen_ord_act_id
   from pr_product p
  where p.product_id = inuprod;

cursor cuActividad (nuactividad or_order_activity.order_activity_id%type) is
select a.activity_id
  from or_order_activity a
 where a.order_activity_id = nuactividad
   and a.product_id = inuprod;


begin
  open cuSuspAcom;
  fetch cuSuspAcom into nuprodstat, nususpordacti;
  if cuSuspAcom%notfound then
    nuprodstat := -1;
  end if;
  close cuSuspAcom;

  if nuprodstat = 2 then
    open cuActividad (nususpordacti);
    fetch cuActividad into nuactividad_id;
    if cuActividad%notfound then
      nuactividad_id := -1;
    end if;
    close cuActividad;

    if nuactividad_id > 0 then
      if instr(sbSuspACO, nuactividad_id) > 0 then
        sbSuspendAcom := 'S';
      end if;
    end if;
  end if;

 return sbSuspendAcom;

exception when others then
  return ('N');
end fnuGetSuspxAcom;

-----------------------------------------------------------------------
function fnuHallaPromedio   (inuprod conssesu.cosssesu%type,
                             inupefa perifact.pefacodi%type,
                             inucate servsusc.sesucate%type,
                             inusuca servsusc.sesusuca%type,
                             inuano  perifact.pefaano%type,
                             inumes  perifact.pefames%type) return number is

/*******************************************************************************
     Metodo:       fnuHallaPromedio
     Descripcion:  Funcion que devuelve si el consumo promedio del producto

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa      Periodo de facturacion
      inucate      Categoria
      inusuca      subcategoria
      inuano       AA?o
      inumes       Mes

      Salida       Descripcion
      nuPromedio   Devuelve el consumo promedio individual y si no lo tiene el consumo promedio de la subcategoria

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 nuPromedio number := -1;

cursor cuPromIndi is
 select h.hcppcopr
   from hicoprpm h
  where h.hcppsesu = inuprod
    and h.hcpppeco = fnuGetPericoseAnt(inupefa);

cursor cuPromSuca is
 select c.cpscprdi
   from coprsuca c
  where c.cpsccate = inucate
    and c.cpscsuca = inusuca
    and c.cpscubge = DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(inuprod)
    and c.cpscanco = decode(inumes,1,inuano-1,inuano)
    and c.cpscmeco = decode(inumes,1,12,inumes-1);

begin
  open cuPromIndi;
  fetch cuPromIndi into nuPromedio;
  if cuPromIndi%notfound then
    nuPromedio := -1;
  end if;
  close cuPromIndi;

  if nvl(nuPromedio,-1) = -1 then
    open cuPromSuca;
    fetch cuPromSuca into nuPromedio;
    if cuPromSuca%notfound then
      nuPromedio := -1;
    else
      nuPromedio := nuPromedio * 30; -- prom mensual
    end if;
    close cuPromSuca;
  end if;

  return nuPromedio;

exception when others then
  return (-1);
end fnuHallaPromedio;


-----------------------------------------------------------------------
function fnuGetDatosConsumo (inuprod conssesu.cosssesu%type,
                             sbDato varchar2) return number is
  nuResul number := -1;

begin
   if tcons.EXISTS(inuprod) then
     if sbDato = 'CONSACTU' then
       nuResul := tcons(inuprod).consumo;
     elsif sbDato = 'CONSANT1' then
       nuResul := tcons(inuprod).consant1;

     elsif sbDato = 'CONSANT2' then
       nuResul := tcons(inuprod).consant2;

     elsif sbDato = 'CONSANT3' then
       nuResul := tcons(inuprod).consant3;

     elsif sbDato = 'COSSMECC' then
       nuResul := tcons(inuprod).cossmecc;

     elsif sbDato = 'COSSCAVC' then
       nuResul := tcons(inuprod).cosscavc;

     else
       nuResul := -1;
     end if;
   end if;


   return nuResul;
 exception
    when others then
   return -1;
end;

----------------------------------------------------------
function FNCVALIDATARIFANUSE(pvalor_tarifa number, fechainicialperiodo date, fechafinalperiodo date,pfechatarifa date, pcate number,psuca number,pmerele number,pmetros number,pconc number) return number is
nuvlrtarifa number;
dias_1 number;
dias_2 number;
nuvlrtarifamesanterior number;
nuvlrtarifamesactual NUMBER;
MES_1 NUMBER;
MES_2 NUMBER;
begin
dias_2:=to_number(to_char(to_date(fechafinalperiodo,'dd')));
dias_1:=to_number(to_char(last_day(fechainicialperiodo),'dd'))-to_number(to_char(to_date(fechainicialperiodo,'dd')))+1;
MES_1:=to_number(to_char(last_day(fechainicialperiodo),'MM'));
MES_2:=to_number(to_char(last_day(fechaFINALperiodo),'MM'));
if (dias_2<>dias_1 and MES_1<>MES_2) or (mes_1=MES_2) then
   if pconc=31 then
      select valor_tarifa* pmetros
	         into nuvlrtarifa
			 from (SELECT a.tacocr03 codi_merc_Relev, meredesc MercadoRelevante, a.tacocr02 Categoria,  a.tacocr01 Subcategoria, tacodesc,
                          case when cotcconc = 17 then 1 else
                               case when cotcconc = 31 then 2 else 20
                               end
                          end ordconcepto,
                          cotcconc || ' - ' || concdesc concepto,
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 20 then '01' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 50000 then '02' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 99999999 then '80' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravtliin = 21 and ravtlisu = 50000 then '03' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
              case when cotcconc = 31 and ravtliin = 50001 and ravtlisu = 90000 then '04' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                case when cotcconc = 31 and ravtliin = 90001 and ravtlisu = 180000 then '05' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                  case when cotcconc = 31 and ravtliin = 180001 and ravtlisu = 280000 then '06' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                    case when cotcconc = 31 and ravtliin = 280001 and ravtlisu = 1400000 then '07' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                      case when cotcconc = 31 and ravtliin = 1400001 and ravtlisu = 99999999 then '08' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
                        else '99' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') end end end end end end end end end ordrango,
       ravtliin || ' - '  || ravtlisu rango,
      --decode(nvl(ravtvalo,0),0,vitcvalo,ravtvalo) ravtvalo,
        case when nvl(ravtvalo,0) != 0 then ravtvalo else
        case when nvl(vitcvalo,0) != 0 then vitcvalo else
          case when nvl(ravtporc,0) != 0 then ravtporc else vitcporc end end end valor_tarifa, --ravtvalo,
     /* ravtporc,*/
      cotcconc, tacocotc v1, tacocons v2,  vitccons v3, ravtcons v4
      FROM open.ta_tariconc a
left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
left outer join open.concepto f on (f.conccodi = b.cotcconc)
/*left outer join open.ta_taricopr g on (b.cotccons = g.tacpcotc)
left outer join OPEN.TA_PROYTARI f on (g.tacpprta = f.prtacons)*/
WHERE cotcconc in  (17,31) --18,20,31,37,144,196,200,204,741)
/*and merecodi=1 and a.tacocr02 = 1 and a.tacocr01 = 3*/
 --and to_Date('28/'||lpad(,2,'0')||'/'||lpad(,4,'0'),'dd/mm/yyyy') between d.vitcfein and d.vitcfefi
 --  and to_Date('28/'||lpad(5,2,'0')||'/'||lpad(2015,4,'0'),'dd/mm/yyyy')  between d.vitcfein and d.vitcfefi
 and pfechatarifa between d.vitcfein and d.vitcfefi
 and pmetros between ravtliin and ravtlisu
union all
select a.tacpcr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacpcr02 Categoria,
       a.tacpcr01 Subcategoria,
       a.tacpdesc,
       case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else 20
            /* case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end */
		  end
	   end ordconcepto,
 b1.cotcconc || ' - ' || concdesc concepto,
      /* b.prtaserv,
       d.vitpfein, d.vitpfefi,
       d.vitpvalo,d.vitpporc,*/
       case when cotcconc = 31 and ravpliin = 0 and ravplisu = 20 then '01' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
        case when cotcconc = 31 and ravpliin = 0 and ravplisu = 50000 then '02' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
          case when cotcconc = 31 and ravpliin = 0 and ravplisu = 99999999 then '80' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravpliin = 21 and ravplisu = 50000 then '03' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
              case when cotcconc = 31 and ravpliin = 50001 and ravplisu = 90000 then '04' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                case when cotcconc = 31 and ravpliin = 90001 and ravplisu = 180000 then '05' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                  case when cotcconc = 31 and ravpliin = 180001 and ravplisu = 280000 then '06' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                    case when cotcconc = 31 and ravpliin = 280001 and ravplisu = 1400000 then '07' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                      case when cotcconc = 31 and ravpliin = 1400001 and ravplisu = 99999999 then '08' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0')
                        else '99' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') end end end end end end end end end ordrango,
       ravpliin || ' - '  || ravplisu rango,
       case when nvl(ravpvalo,0) != 0 then ravpvalo else
        case when nvl(vitpvalo,0) != 0 then vitpvalo else
           case when nvl(ravpporc,0) != 0 then ravpporc else vitpporc end end end VALOR_TARIFA, --ravpvalo,
      -- ravpporc,
       cotcconc,  tacpcotc V1, tacpcons V2,  vitpcons V3, ravpcons V4
FROM open.TA_TARICOPR a,
     open.TA_PROYTARI b,
     open.fa_mercrele c,
     open.ta_vigetacp d,
     open.TA_RANGVITP e,
     open.ta_conftaco b1,
     open.concepto f
where a.tacpprta = b.prtacons --
  and a.tacpcr03 = c.merecodi
  and d.vitptacp = a.tacpcons
  and e.ravpvitp = d.vitpcons
  and a.tacpcotc = b1.cotccons
  and f.conccodi = b1.cotcconc
  and cotcconc in (17,31) -- 18,20,31,37,144,196,200,204,741)
  -- and to_Date('28/'||lpad(,2,'0')||'/'||lpad(,4,'0'),'dd/mm/yyyy')  between d.vitpfein and d.vitpfefi
  --  and to_Date('28/'||lpad(5,2,'0')||'/'||lpad(2015,4,'0'),'dd/mm/yyyy')  between d.vitpfein and d.vitpfefi
  and pfechatarifa between d.vitpfein and d.vitpfefi
  and b.prtaesta in (1,2)
  and d.vitptipo = 'B'
  and pmetros between ravpliin and ravplisu
ORDER BY codi_merc_Relev, Categoria, Subcategoria
)
where categoria=pcate
and subcategoria=psuca
and codi_merc_Relev=pmerele
and cotcconc=pconc;
end if;



    if pconc=17 then


select valor_tarifa  into  nuvlrtarifa from (
SELECT cotcconc,a.tacocr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacocr02 Categoria,
       a.tacocr01 Subcategoria,
       tacodesc,
 case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else
           case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end end end ordconcepto,

       cotcconc || ' - ' || concdesc concepto,
      /* cotcserv,
       vitcfein, vitcfefi,
       vitcvalo, vitcporc,*/

  case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 20 then '01' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
    else
        case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 50000 then '02' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 99999999 then '80' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravtliin = 21 and ravtlisu = 50000 then '03' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
              case when cotcconc = 31 and ravtliin = 50001 and ravtlisu = 90000 then '04' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                case when cotcconc = 31 and ravtliin = 90001 and ravtlisu = 180000 then '05' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                  case when cotcconc = 31 and ravtliin = 180001 and ravtlisu = 280000 then '06' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                    case when cotcconc = 31 and ravtliin = 280001 and ravtlisu = 1400000 then '07' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                      case when cotcconc = 31 and ravtliin = 1400001 and ravtlisu = 99999999 then '08' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
                        else '99' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') end end end end end end end end end ordrango,

       ravtliin || ' - '  || ravtlisu rango,

      --decode(nvl(ravtvalo,0),0,vitcvalo,ravtvalo) ravtvalo,
        case when nvl(ravtvalo,0) != 0 then ravtvalo else
        case when nvl(vitcvalo,0) != 0 then vitcvalo else
          case when nvl(ravtporc,0) != 0 then ravtporc else vitcporc end end end valor_tarifa, --ravtvalo,

     /* ravtporc,*/
      tacocotc, tacocons,  vitccons, ravtcons
      FROM open.ta_tariconc a
left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
left outer join open.concepto f on (f.conccodi = b.cotcconc)
/*left outer join open.ta_taricopr g on (b.cotccons = g.tacpcotc)
left outer join OPEN.TA_PROYTARI f on (g.tacpprta = f.prtacons)*/
WHERE cotcconc in  (17,18,20,31,37,144,196,200,204,741)
/*and merecodi=1 and a.tacocr02 = 1 and a.tacocr01 = 3*/
and pfechatarifa between d.vitcfein and d.vitcfefi
union all
select cotcconc,a.tacpcr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacpcr02 Categoria,
       a.tacpcr01 Subcategoria,
       a.tacpdesc,
       case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else
           case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end end end ordconcepto,
 b1.cotcconc || ' - ' || concdesc concepto,
      /* b.prtaserv,
       d.vitpfein, d.vitpfefi,
       d.vitpvalo,d.vitpporc,*/
       case when cotcconc = 31 and ravpliin = 0 and ravplisu = 20 then '01' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
        case when cotcconc = 31 and ravpliin = 0 and ravplisu = 50000 then '02' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
          case when cotcconc = 31 and ravpliin = 0 and ravplisu = 99999999 then '80' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravpliin = 21 and ravplisu = 50000 then '03' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
              case when cotcconc = 31 and ravpliin = 50001 and ravplisu = 90000 then '04' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                case when cotcconc = 31 and ravpliin = 90001 and ravplisu = 180000 then '05' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                  case when cotcconc = 31 and ravpliin = 180001 and ravplisu = 280000 then '06' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                    case when cotcconc = 31 and ravpliin = 280001 and ravplisu = 1400000 then '07' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                      case when cotcconc = 31 and ravpliin = 1400001 and ravplisu = 99999999 then '08' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0')
                        else '99' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') end end end end end end end end end ordrango,
       ravpliin || ' - '  || ravplisu rango,
       case when nvl(ravpvalo,0) != 0 then ravpvalo else
        case when nvl(vitpvalo,0) != 0 then vitpvalo else
           case when nvl(ravpporc,0) != 0 then ravpporc else vitpporc end end end valor_tarifa, --ravpvalo,
      -- ravpporc,
       tacpcotc, tacpcons,  vitpcons, ravpcons
FROM open.TA_TARICOPR a,
     open.TA_PROYTARI b,
     open.fa_mercrele c,
     open.ta_vigetacp d,
     open.TA_RANGVITP e,
     open.ta_conftaco b1,
     open.concepto f
where a.tacpprta = b.prtacons --
  and a.tacpcr03 = c.merecodi
  and d.vitptacp = a.tacpcons
  and e.ravpvitp = d.vitpcons
  and a.tacpcotc = b1.cotccons
  and f.conccodi = b1.cotcconc
  and cotcconc in (17,18,20,31,37,144,196,200,204,741)
  and pfechatarifa  between d.vitpfein and d.vitpfefi
  and b.prtaesta in (1,2)
  and d.vitptipo = 'B'
ORDER BY codi_merc_Relev, Categoria, Subcategoria                           )
where categoria=pcate
and subcategoria=psuca
and codi_merc_Relev=pmerele
and cotcconc=pconc;
end if;

else

   /* dias iguales en los segmentos de mes diferentes 15 dias del mes calendario anterior y 15 dias calendario del mes actual*/

   if pconc=31 then
      /* calcula tarifa mes anterior */
      select valor_tarifa* pmetros
	         into nuvlrtarifamesanterior
			 from (SELECT a.tacocr03 codi_merc_Relev, meredesc MercadoRelevante, a.tacocr02 Categoria,  a.tacocr01 Subcategoria, tacodesc,
                          case when cotcconc = 17 then 1 else
                               case when cotcconc = 31 then 2 else 20
                               end
                          end ordconcepto,
                          cotcconc || ' - ' || concdesc concepto,
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 20 then '01' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 50000 then '02' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 99999999 then '80' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravtliin = 21 and ravtlisu = 50000 then '03' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
              case when cotcconc = 31 and ravtliin = 50001 and ravtlisu = 90000 then '04' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                case when cotcconc = 31 and ravtliin = 90001 and ravtlisu = 180000 then '05' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                  case when cotcconc = 31 and ravtliin = 180001 and ravtlisu = 280000 then '06' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                    case when cotcconc = 31 and ravtliin = 280001 and ravtlisu = 1400000 then '07' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                      case when cotcconc = 31 and ravtliin = 1400001 and ravtlisu = 99999999 then '08' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
                        else '99' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') end end end end end end end end end ordrango,
       ravtliin || ' - '  || ravtlisu rango,
      --decode(nvl(ravtvalo,0),0,vitcvalo,ravtvalo) ravtvalo,
        case when nvl(ravtvalo,0) != 0 then ravtvalo else
        case when nvl(vitcvalo,0) != 0 then vitcvalo else
          case when nvl(ravtporc,0) != 0 then ravtporc else vitcporc end end end valor_tarifa, --ravtvalo,
     /* ravtporc,*/
      cotcconc, tacocotc v1, tacocons v2,  vitccons v3, ravtcons v4
      FROM open.ta_tariconc a
left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
left outer join open.concepto f on (f.conccodi = b.cotcconc)
/*left outer join open.ta_taricopr g on (b.cotccons = g.tacpcotc)
left outer join OPEN.TA_PROYTARI f on (g.tacpprta = f.prtacons)*/
WHERE cotcconc in  (17,31) --18,20,31,37,144,196,200,204,741)
/*and merecodi=1 and a.tacocr02 = 1 and a.tacocr01 = 3*/
 --and to_Date('28/'||lpad(,2,'0')||'/'||lpad(,4,'0'),'dd/mm/yyyy') between d.vitcfein and d.vitcfefi
 --  and to_Date('28/'||lpad(5,2,'0')||'/'||lpad(2015,4,'0'),'dd/mm/yyyy')  between d.vitcfein and d.vitcfefi
 and fechainicialperiodo between d.vitcfein and d.vitcfefi
 and pmetros between ravtliin and ravtlisu
union all
select a.tacpcr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacpcr02 Categoria,
       a.tacpcr01 Subcategoria,
       a.tacpdesc,
       case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else 20
            /* case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end */
		  end
	   end ordconcepto,
 b1.cotcconc || ' - ' || concdesc concepto,
      /* b.prtaserv,
       d.vitpfein, d.vitpfefi,
       d.vitpvalo,d.vitpporc,*/
       case when cotcconc = 31 and ravpliin = 0 and ravplisu = 20 then '01' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
        case when cotcconc = 31 and ravpliin = 0 and ravplisu = 50000 then '02' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
          case when cotcconc = 31 and ravpliin = 0 and ravplisu = 99999999 then '80' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravpliin = 21 and ravplisu = 50000 then '03' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
              case when cotcconc = 31 and ravpliin = 50001 and ravplisu = 90000 then '04' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                case when cotcconc = 31 and ravpliin = 90001 and ravplisu = 180000 then '05' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                  case when cotcconc = 31 and ravpliin = 180001 and ravplisu = 280000 then '06' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                    case when cotcconc = 31 and ravpliin = 280001 and ravplisu = 1400000 then '07' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                      case when cotcconc = 31 and ravpliin = 1400001 and ravplisu = 99999999 then '08' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0')
                        else '99' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') end end end end end end end end end ordrango,
       ravpliin || ' - '  || ravplisu rango,
       case when nvl(ravpvalo,0) != 0 then ravpvalo else
        case when nvl(vitpvalo,0) != 0 then vitpvalo else
           case when nvl(ravpporc,0) != 0 then ravpporc else vitpporc end end end VALOR_TARIFA, --ravpvalo,
      -- ravpporc,
       cotcconc,  tacpcotc V1, tacpcons V2,  vitpcons V3, ravpcons V4
FROM open.TA_TARICOPR a,
     open.TA_PROYTARI b,
     open.fa_mercrele c,
     open.ta_vigetacp d,
     open.TA_RANGVITP e,
     open.ta_conftaco b1,
     open.concepto f
where a.tacpprta = b.prtacons --
  and a.tacpcr03 = c.merecodi
  and d.vitptacp = a.tacpcons
  and e.ravpvitp = d.vitpcons
  and a.tacpcotc = b1.cotccons
  and f.conccodi = b1.cotcconc
  and cotcconc in (17,31) -- 18,20,31,37,144,196,200,204,741)
  -- and to_Date('28/'||lpad(,2,'0')||'/'||lpad(,4,'0'),'dd/mm/yyyy')  between d.vitpfein and d.vitpfefi
  --  and to_Date('28/'||lpad(5,2,'0')||'/'||lpad(2015,4,'0'),'dd/mm/yyyy')  between d.vitpfein and d.vitpfefi
  and fechainicialperiodo between d.vitpfein and d.vitpfefi
  and b.prtaesta in (1,2)
  and d.vitptipo = 'B'
  and pmetros between ravpliin and ravplisu
ORDER BY codi_merc_Relev, Categoria, Subcategoria
)
where categoria=pcate
and subcategoria=psuca
and codi_merc_Relev=pmerele
and cotcconc=pconc;

    /* calcula tarifa mes actual */
select valor_tarifa* pmetros
	         into nuvlrtarifamesactual
			 from (SELECT a.tacocr03 codi_merc_Relev, meredesc MercadoRelevante, a.tacocr02 Categoria,  a.tacocr01 Subcategoria, tacodesc,
                          case when cotcconc = 17 then 1 else
                               case when cotcconc = 31 then 2 else 20
                               end
                          end ordconcepto,
                          cotcconc || ' - ' || concdesc concepto,
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 20 then '01' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 50000 then '02' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 99999999 then '80' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravtliin = 21 and ravtlisu = 50000 then '03' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
              case when cotcconc = 31 and ravtliin = 50001 and ravtlisu = 90000 then '04' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                case when cotcconc = 31 and ravtliin = 90001 and ravtlisu = 180000 then '05' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                  case when cotcconc = 31 and ravtliin = 180001 and ravtlisu = 280000 then '06' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                    case when cotcconc = 31 and ravtliin = 280001 and ravtlisu = 1400000 then '07' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                      case when cotcconc = 31 and ravtliin = 1400001 and ravtlisu = 99999999 then '08' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
                        else '99' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') end end end end end end end end end ordrango,
       ravtliin || ' - '  || ravtlisu rango,
      --decode(nvl(ravtvalo,0),0,vitcvalo,ravtvalo) ravtvalo,
        case when nvl(ravtvalo,0) != 0 then ravtvalo else
        case when nvl(vitcvalo,0) != 0 then vitcvalo else
          case when nvl(ravtporc,0) != 0 then ravtporc else vitcporc end end end valor_tarifa, --ravtvalo,
     /* ravtporc,*/
      cotcconc, tacocotc v1, tacocons v2,  vitccons v3, ravtcons v4
      FROM open.ta_tariconc a
left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
left outer join open.concepto f on (f.conccodi = b.cotcconc)
/*left outer join open.ta_taricopr g on (b.cotccons = g.tacpcotc)
left outer join OPEN.TA_PROYTARI f on (g.tacpprta = f.prtacons)*/
WHERE cotcconc in  (17,31) --18,20,31,37,144,196,200,204,741)
/*and merecodi=1 and a.tacocr02 = 1 and a.tacocr01 = 3*/
 --and to_Date('28/'||lpad(,2,'0')||'/'||lpad(,4,'0'),'dd/mm/yyyy') between d.vitcfein and d.vitcfefi
 --  and to_Date('28/'||lpad(5,2,'0')||'/'||lpad(2015,4,'0'),'dd/mm/yyyy')  between d.vitcfein and d.vitcfefi
 and fechafinalperiodo between d.vitcfein and d.vitcfefi
 and pmetros between ravtliin and ravtlisu
union all
select a.tacpcr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacpcr02 Categoria,
       a.tacpcr01 Subcategoria,
       a.tacpdesc,
       case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else 20
		  end
	   end ordconcepto,
 b1.cotcconc || ' - ' || concdesc concepto,
      /* b.prtaserv,
       d.vitpfein, d.vitpfefi,
       d.vitpvalo,d.vitpporc,*/
       case when cotcconc = 31 and ravpliin = 0 and ravplisu = 20 then '01' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
        case when cotcconc = 31 and ravpliin = 0 and ravplisu = 50000 then '02' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
          case when cotcconc = 31 and ravpliin = 0 and ravplisu = 99999999 then '80' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravpliin = 21 and ravplisu = 50000 then '03' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
              case when cotcconc = 31 and ravpliin = 50001 and ravplisu = 90000 then '04' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                case when cotcconc = 31 and ravpliin = 90001 and ravplisu = 180000 then '05' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                  case when cotcconc = 31 and ravpliin = 180001 and ravplisu = 280000 then '06' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                    case when cotcconc = 31 and ravpliin = 280001 and ravplisu = 1400000 then '07' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                      case when cotcconc = 31 and ravpliin = 1400001 and ravplisu = 99999999 then '08' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0')
                        else '99' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') end end end end end end end end end ordrango,
       ravpliin || ' - '  || ravplisu rango,
       case when nvl(ravpvalo,0) != 0 then ravpvalo else
        case when nvl(vitpvalo,0) != 0 then vitpvalo else
           case when nvl(ravpporc,0) != 0 then ravpporc else vitpporc end end end VALOR_TARIFA, --ravpvalo,
      -- ravpporc,
       cotcconc,  tacpcotc V1, tacpcons V2,  vitpcons V3, ravpcons V4
FROM open.TA_TARICOPR a,
     open.TA_PROYTARI b,
     open.fa_mercrele c,
     open.ta_vigetacp d,
     open.TA_RANGVITP e,
     open.ta_conftaco b1,
     open.concepto f
where a.tacpprta = b.prtacons --
  and a.tacpcr03 = c.merecodi
  and d.vitptacp = a.tacpcons
  and e.ravpvitp = d.vitpcons
  and a.tacpcotc = b1.cotccons
  and f.conccodi = b1.cotcconc
  and cotcconc in (17,31) -- 18,20,31,37,144,196,200,204,741)
  -- and to_Date('28/'||lpad(,2,'0')||'/'||lpad(,4,'0'),'dd/mm/yyyy')  between d.vitpfein and d.vitpfefi
  --  and to_Date('28/'||lpad(5,2,'0')||'/'||lpad(2015,4,'0'),'dd/mm/yyyy')  between d.vitpfein and d.vitpfefi
  and fechafinalperiodo between d.vitpfein and d.vitpfefi
  and b.prtaesta in (1,2)
  and d.vitptipo = 'B'
  and pmetros between ravpliin and ravplisu
ORDER BY codi_merc_Relev, Categoria, Subcategoria
)
where categoria=pcate
and subcategoria=psuca
and codi_merc_Relev=pmerele
and cotcconc=pconc;

if pvalor_tarifa=nuvlrtarifamesactual or pvalor_tarifa=nuvlrtarifamesanterior then
   nuvlrtarifa:=pvalor_tarifa;
else
   nuvlrtarifa:=nuvlrtarifamesactual;
end if;


end if;


if pconc=17 then


select valor_tarifa  into  nuvlrtarifamesanterior from (
SELECT cotcconc,a.tacocr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacocr02 Categoria,
       a.tacocr01 Subcategoria,
       tacodesc,
 case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else
           case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end end end ordconcepto,

       cotcconc || ' - ' || concdesc concepto,
      /* cotcserv,
       vitcfein, vitcfefi,
       vitcvalo, vitcporc,*/

  case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 20 then '01' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
    else
        case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 50000 then '02' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 99999999 then '80' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravtliin = 21 and ravtlisu = 50000 then '03' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
              case when cotcconc = 31 and ravtliin = 50001 and ravtlisu = 90000 then '04' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                case when cotcconc = 31 and ravtliin = 90001 and ravtlisu = 180000 then '05' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                  case when cotcconc = 31 and ravtliin = 180001 and ravtlisu = 280000 then '06' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                    case when cotcconc = 31 and ravtliin = 280001 and ravtlisu = 1400000 then '07' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                      case when cotcconc = 31 and ravtliin = 1400001 and ravtlisu = 99999999 then '08' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
                        else '99' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') end end end end end end end end end ordrango,

       ravtliin || ' - '  || ravtlisu rango,

      --decode(nvl(ravtvalo,0),0,vitcvalo,ravtvalo) ravtvalo,
        case when nvl(ravtvalo,0) != 0 then ravtvalo else
        case when nvl(vitcvalo,0) != 0 then vitcvalo else
          case when nvl(ravtporc,0) != 0 then ravtporc else vitcporc end end end valor_tarifa, --ravtvalo,

     /* ravtporc,*/
      tacocotc, tacocons,  vitccons, ravtcons
      FROM open.ta_tariconc a
left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
left outer join open.concepto f on (f.conccodi = b.cotcconc)
/*left outer join open.ta_taricopr g on (b.cotccons = g.tacpcotc)
left outer join OPEN.TA_PROYTARI f on (g.tacpprta = f.prtacons)*/
WHERE cotcconc in  (17,18,20,31,37,144,196,200,204,741)
/*and merecodi=1 and a.tacocr02 = 1 and a.tacocr01 = 3*/
and fechainicialperiodo between d.vitcfein and d.vitcfefi
union all
select cotcconc,a.tacpcr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacpcr02 Categoria,
       a.tacpcr01 Subcategoria,
       a.tacpdesc,
       case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else
           case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end end end ordconcepto,
 b1.cotcconc || ' - ' || concdesc concepto,
      /* b.prtaserv,
       d.vitpfein, d.vitpfefi,
       d.vitpvalo,d.vitpporc,*/
       case when cotcconc = 31 and ravpliin = 0 and ravplisu = 20 then '01' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
        case when cotcconc = 31 and ravpliin = 0 and ravplisu = 50000 then '02' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
          case when cotcconc = 31 and ravpliin = 0 and ravplisu = 99999999 then '80' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravpliin = 21 and ravplisu = 50000 then '03' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
              case when cotcconc = 31 and ravpliin = 50001 and ravplisu = 90000 then '04' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                case when cotcconc = 31 and ravpliin = 90001 and ravplisu = 180000 then '05' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                  case when cotcconc = 31 and ravpliin = 180001 and ravplisu = 280000 then '06' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                    case when cotcconc = 31 and ravpliin = 280001 and ravplisu = 1400000 then '07' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                      case when cotcconc = 31 and ravpliin = 1400001 and ravplisu = 99999999 then '08' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0')
                        else '99' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') end end end end end end end end end ordrango,
       ravpliin || ' - '  || ravplisu rango,
       case when nvl(ravpvalo,0) != 0 then ravpvalo else
        case when nvl(vitpvalo,0) != 0 then vitpvalo else
           case when nvl(ravpporc,0) != 0 then ravpporc else vitpporc end end end valor_tarifa, --ravpvalo,
      -- ravpporc,
       tacpcotc, tacpcons,  vitpcons, ravpcons
FROM open.TA_TARICOPR a,
     open.TA_PROYTARI b,
     open.fa_mercrele c,
     open.ta_vigetacp d,
     open.TA_RANGVITP e,
     open.ta_conftaco b1,
     open.concepto f
where a.tacpprta = b.prtacons --
  and a.tacpcr03 = c.merecodi
  and d.vitptacp = a.tacpcons
  and e.ravpvitp = d.vitpcons
  and a.tacpcotc = b1.cotccons
  and f.conccodi = b1.cotcconc
  and cotcconc in (17,18,20,31,37,144,196,200,204,741)
  and fechainicialperiodo  between d.vitpfein and d.vitpfefi
  and b.prtaesta in (1,2)
  and d.vitptipo = 'B'
ORDER BY codi_merc_Relev, Categoria, Subcategoria                           )
where categoria=pcate
and subcategoria=psuca
and codi_merc_Relev=pmerele
and cotcconc=pconc;


select valor_tarifa  into  nuvlrtarifamesactual from (
SELECT cotcconc,a.tacocr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacocr02 Categoria,
       a.tacocr01 Subcategoria,
       tacodesc,
 case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else
           case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end end end ordconcepto,

       cotcconc || ' - ' || concdesc concepto,
      /* cotcserv,
       vitcfein, vitcfefi,
       vitcvalo, vitcporc,*/

  case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 20 then '01' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
    else
        case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 50000 then '02' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
          case when cotcconc = 31 and ravtliin = 0 and ravtlisu = 99999999 then '80' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravtliin = 21 and ravtlisu = 50000 then '03' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
              case when cotcconc = 31 and ravtliin = 50001 and ravtlisu = 90000 then '04' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                case when cotcconc = 31 and ravtliin = 90001 and ravtlisu = 180000 then '05' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                  case when cotcconc = 31 and ravtliin = 180001 and ravtlisu = 280000 then '06' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                    case when cotcconc = 31 and ravtliin = 280001 and ravtlisu = 1400000 then '07' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') else
                      case when cotcconc = 31 and ravtliin = 1400001 and ravtlisu = 99999999 then '08' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0')
                        else '99' || lpad(ravtliin ,8,'0')  || '-'  || lpad(ravtlisu  ,8,'0') end end end end end end end end end ordrango,

       ravtliin || ' - '  || ravtlisu rango,

      --decode(nvl(ravtvalo,0),0,vitcvalo,ravtvalo) ravtvalo,
        case when nvl(ravtvalo,0) != 0 then ravtvalo else
        case when nvl(vitcvalo,0) != 0 then vitcvalo else
          case when nvl(ravtporc,0) != 0 then ravtporc else vitcporc end end end valor_tarifa, --ravtvalo,

     /* ravtporc,*/
      tacocotc, tacocons,  vitccons, ravtcons
      FROM open.ta_tariconc a
left outer join open.ta_conftaco b on (a.tacocotc = b.cotccons)
left outer join open.fa_mercrele c on (a.tacocr03 = c.merecodi)
left outer join open.ta_vigetaco d on (d.vitctaco = a.tacocons)
left outer join open.ta_rangvitc e on (e.ravtvitc = d.vitccons)
left outer join open.concepto f on (f.conccodi = b.cotcconc)
/*left outer join open.ta_taricopr g on (b.cotccons = g.tacpcotc)
left outer join OPEN.TA_PROYTARI f on (g.tacpprta = f.prtacons)*/
WHERE cotcconc in  (17,18,20,31,37,144,196,200,204,741)
/*and merecodi=1 and a.tacocr02 = 1 and a.tacocr01 = 3*/
and fechafinalperiodo between d.vitcfein and d.vitcfefi
union all
select cotcconc,a.tacpcr03 codi_merc_Relev, meredesc MercadoRelevante,
       a.tacpcr02 Categoria,
       a.tacpcr01 Subcategoria,
       a.tacpdesc,
       case when cotcconc = 17 then 1 else
         case when cotcconc = 31 then 2 else
           case when cotcconc = 37 then 3 else
             case when cotcconc = 196 then 4 else
               case when cotcconc = 200 then 5 else
                 case when cotcconc = 204 then 6 else
                   case when cotcconc = 20 then 7 else
                     case when cotcconc = 18 then 8 else
                       case when cotcconc = 741 then 9 else
                         case when cotcconc = 144 then 10 else 20 end end end end end end end end end end ordconcepto,
 b1.cotcconc || ' - ' || concdesc concepto,
      /* b.prtaserv,
       d.vitpfein, d.vitpfefi,
       d.vitpvalo,d.vitpporc,*/
       case when cotcconc = 31 and ravpliin = 0 and ravplisu = 20 then '01' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
        case when cotcconc = 31 and ravpliin = 0 and ravplisu = 50000 then '02' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
          case when cotcconc = 31 and ravpliin = 0 and ravplisu = 99999999 then '80' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else  -- para que salga de ultimo
            case when cotcconc = 31 and ravpliin = 21 and ravplisu = 50000 then '03' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
              case when cotcconc = 31 and ravpliin = 50001 and ravplisu = 90000 then '04' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                case when cotcconc = 31 and ravpliin = 90001 and ravplisu = 180000 then '05' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                  case when cotcconc = 31 and ravpliin = 180001 and ravplisu = 280000 then '06' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                    case when cotcconc = 31 and ravpliin = 280001 and ravplisu = 1400000 then '07' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') else
                      case when cotcconc = 31 and ravpliin = 1400001 and ravplisu = 99999999 then '08' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0')
                        else '99' || lpad(ravpliin ,8,'0')  || '-'  || lpad(ravplisu  ,8,'0') end end end end end end end end end ordrango,
       ravpliin || ' - '  || ravplisu rango,
       case when nvl(ravpvalo,0) != 0 then ravpvalo else
        case when nvl(vitpvalo,0) != 0 then vitpvalo else
           case when nvl(ravpporc,0) != 0 then ravpporc else vitpporc end end end valor_tarifa, --ravpvalo,
      -- ravpporc,
       tacpcotc, tacpcons,  vitpcons, ravpcons
FROM open.TA_TARICOPR a,
     open.TA_PROYTARI b,
     open.fa_mercrele c,
     open.ta_vigetacp d,
     open.TA_RANGVITP e,
     open.ta_conftaco b1,
     open.concepto f
where a.tacpprta = b.prtacons --
  and a.tacpcr03 = c.merecodi
  and d.vitptacp = a.tacpcons
  and e.ravpvitp = d.vitpcons
  and a.tacpcotc = b1.cotccons
  and f.conccodi = b1.cotcconc
  and cotcconc in (17,18,20,31,37,144,196,200,204,741)
  and fechafinalperiodo  between d.vitpfein and d.vitpfefi
  and b.prtaesta in (1,2)
  and d.vitptipo = 'B'
ORDER BY codi_merc_Relev, Categoria, Subcategoria                           )
where categoria=pcate
and subcategoria=psuca
and codi_merc_Relev=pmerele
and cotcconc=pconc;


if pvalor_tarifa=nuvlrtarifamesactual or pvalor_tarifa=nuvlrtarifamesanterior then
   nuvlrtarifa:=pvalor_tarifa;
else
   nuvlrtarifa:=nuvlrtarifamesactual;
end if;


end if;





   /* termina desarrollo de dias iguales */
end if;
return(nuvlrtarifa);
exception
         when others then
		      return(-1);
end FNCVALIDATARIFANUSE;

----------------------------------------------------------

function fdtdevuelvefecha(dti date, dtf date) return date is
dtdev date;
begin
     select CASE WHEN ( (last_day(trunc(dti)) - trunc(dti))  > trunc(dtf) - to_date('01/'||to_char(dtf,'mm')||'/'||to_char(dtf,'yyyy'), 'dd/mm/yyyy')
                              AND to_number(to_char(dti, 'mm')) <>  to_number(to_char(dtf, 'mm')) ) THEN
                             dti
                   WHEN ( (last_day(trunc(dti)) - trunc(dti))  < trunc(dtf) - to_date('01/'||to_char(dtf,'mm')||'/'||to_char(dtf,'yyyy'), 'dd/mm/yyyy')
                          AND to_number(to_char(dti, 'mm')) <>  to_number(to_char(dtf, 'mm')) ) THEN
                             dtf
                   ELSE
                     dtf
                END into dtdev from dual;
     return(dtdev);
end;

----------------------------------------------------------
procedure proGeneraAuditorias (inuano perifact.pefaano%type,
                               inumes perifact.pefaano%type,
                               inucicl perifact.pefaano%type,
                               isbEmail  VARCHAR2) is
/*
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    17/07/2019        horbath           caso 200-2461. Dentro del recorrido del cursor cuVeriTariInco se llama a la funcion FNCVALIDATARIFANUSE para validar si la tarifa
	                                      aplicada es la correcta. De no ser la correcta graba en la tabla LDC_VATAAPI.
    24/11/2020        horbath         CA291 - Se modifican todas las auditorias (ver documento de entrega)
*/

    sbMensError      VARCHAR2(4000);  --Ticket 200-1892  ELAL -- se almacena error generado

    nuAno          NUMBER := inuano;
    nuMes          NUMBER := inumes;
    nuCiclo        NUMBER := inucicl;
    sbEmail        VARCHAR2(2000) := isbEmail ;

    nuPorcPromResi      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PORC_CONS_RECU_RESI_LDCPKFAAC', NULL);
    nuPorcPromCome      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PORC_CONS_RECU_COME_LDCPKFAAC', NULL);
    nuNumeConsProm      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('NUME_CONS_RECU_LDCPKFAAC', NULL);
    nuConsMaxResi       ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('CONSUMO_ACTUAL_1', NULL);
    nuConsMaxCome       ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('CONSUMO_ACTUAL_2', NULL);

    nuVlrConsMaxResi    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_CONSU_RESI', NULL);
    nuVlrOtroMaxResi    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_OTROS_RESI', NULL);
    nuVlrConsMaxCome    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_CONSU_COME', NULL);
    nuVlrOtroMaxCome    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_OTROS_COME', NULL);

    sbParameterACO      ld_parameter.value_chain%type  := dald_parameter.fsbGetValue_Chain('PE_ACTIVIDADES_SUSPENSION_ACO',0);

    --Ticket 200-1892  ELAL -- se consulta cargos dobles
   CURSOR cuCargDobles IS
   SELECT  cargnuse PRODUCTO, -- numero del servicio
            sesucicl CICLO,
            cargconc CONCEPTO, -- concepto
            cargcaca CAUSAL, -- causa del cargo
            cargsign SIGNO, -- signo
            count(1) CANTIDAD,
            cargvalo VALOR, -- valor del cargo
            nuAno,
            nuMes
    FROM  open.cargos, open.servsusc, open.perifact
    WHERE   cargnuse = sesunuse
    AND     cargpefa = pefacodi
    AND     cargcuco = -1
    AND    sesucicl =  nuCiclo
    AND     pefaano = nuAno--*/2013
     AND     pefames = nuMes --*/10
    GROUP BY cargcuco, -- cuenta de cobro
        cargnuse, -- numero del servicio
        cargconc, -- concepto
        cargcaca, -- causa del cargo
        cargsign, -- signo
        cargpefa, -- periodo facturacion
        cargvalo, -- valor del cargo
        cargdoso, -- documento de soporte
        cargunid, -- unidades
        cargfecr, -- fecha de creacion
        cargcoll, -- consecutivo de llamadas
        cargpeco, -- periodo de consumo
        cargvabl,
        sesucicl
    HAVING   ( COUNT(1) ) > 1;

    TYPE tbCargDobles IS TABLE OF cuCargDobles%ROWTYPE  ;
    v_tbCargDobles tbCargDobles;

    --consumos altos
    CURSOR cuConsuAltos IS
    SELECT  PRODUCTO,CICLO, CATEGORIA, SUBCATEGORIA, PEFACODI, PROMEDIO,CONSUMO_ACTUAL,CONSUMO_ANTERIOR_1,CONSUMO_ANTERIOR_2, CONSUMO_ANTERIOR_3, REGLA, NUANO, NUMES
    FROM    (
        SELECT   sesunuse PRODUCTO,
                ciclcodi CICLO,
                sesucate CATEGORIA,
                sesusuca SUBCATEGORIA,
                PEFACODI,

            /*    (SELECT hicoprpm.hcppcopr
            FROM Open.hicoprpm
            WHERE hicoprpm.hcppsesu = sesunuse
              AND hicoprpm.hcpptico = 1
              AND HCPPPECO = decode(nupecs,null, null, fnuObtPerConsAnte(sesunuse,nupecs))
              and rownum < 2) PROMEDIO,*/

             fnuHallaPromedio (sesunuse, pefacodi, sesucate, sesusuca, pefaano, pefames) PROMEDIO, --CA291

             fnuGetDatosConsumo(sesunuse,'CONSACTU')  CONSUMO_ACTUAL,
             fnuGetDatosConsumo(sesunuse,'CONSANT1')  CONSUMO_ANTERIOR_1,
             fnuGetDatosConsumo(sesunuse,'CONSANT2')  CONSUMO_ANTERIOR_2,
             fnuGetDatosConsumo(sesunuse,'CONSANT3')  CONSUMO_ANTERIOR_3,
             fnuGetDatosConsumo(sesunuse,'COSSCAVC')  REGLA,
			 fnuGetUltConsValido(sesunuse, PEFACODI) ultcons

        FROM    open.servsusc, open.perifact, open.ciclo

        WHERE   sesucicl = ciclcodi
        AND     ciclcodi = pefacicl
        AND     ciclcodi = nuCiclo--*/242
        AND     pefaano = nuAno--*/2013
        AND     pefames = nuMes --*/10
    )
   /* WHERE  ((CATEGORIA = 1 AND CONSUMO_ACTUAL > open.dald_parameter.fnuGetNumeric_Value('CONSUMO_ACTUAL_1', null) ) OR
             (CATEGORIA = 2 AND CONSUMO_ACTUAL > open.dald_parameter.fnuGetNumeric_Value('CONSUMO_ACTUAL_2',  null) ));*/
      WHERE   CONSUMO_ACTUAL > DECODE(CATEGORIA,1,nuConsMaxResi,nuConsMaxCome)
       AND   ( (CONSUMO_ACTUAL * 100 / ( case when nvl(PROMEDIO,0) = 0 then 100 else  PROMEDIO end )  >  DECODE(CATEGORIA,1,nuPorcPromResi,nuPorcPromCome)) OR
              ( (CONSUMO_ACTUAL * 100 / ( case when nvl(ultcons,0) = 0 then 100 else ultcons end ) ) >  DECODE(CATEGORIA,1,nuPorcPromResi,nuPorcPromCome)) )
       AND   ( (fnuGetRegla2020(PRODUCTO, PEFACODI) = 'N')  OR (fnuGetRegla2020(PRODUCTO, PEFACODI) = 'S' AND fnuGetCambMedidor(PRODUCTO, PEFACODI) = 'S') );



    TYPE tbConsuAltos IS TABLE OF cuConsuAltos%ROWTYPE  ;
    v_tbConsuAltos tbConsuAltos;


   --valores altos cargos
    CURSOR cuAltosConsu IS
    SELECT  sesunuse PRODUCTO,
        sesucicl CICLO,
        sesuserv SERVICIO,
        cargconc CONCEPTO,
        cargsign SIGNO,
        sesucate CATEGORIA,
        sesusuca SUBCATEGORIA,
        cargdoso DOCUMENTO,
        cargvalo VALOR,
        cargcaca CAUSA_CARGO,
      -- open.pktblcauscarg.fsbgetdescription(cargcaca) DESCRIPCION_CAUSA,
        (SELECT hicoprpm.hcppcopr
            FROM Open.hicoprpm
            WHERE hicoprpm.hcppsesu = sesunuse
              AND hicoprpm.hcpptico = 1
              AND HCPPPECO = decode(cargpeco,null, null, fnuObtPerConsAnte(sesunuse,cargpeco))
              and rownum < 2) PROMEDIO,

             fnuGetDatosConsumo(sesunuse,'CONSACTU')  CONSUMO_ACTUAL,
             fnuGetDatosConsumo(sesunuse,'CONSANT1')  CONSUMO_ANTERIOR_1,
             fnuGetDatosConsumo(sesunuse,'CONSANT2')  CONSUMO_ANTERIOR_2,
             fnuGetDatosConsumo(sesunuse,'CONSANT3')  CONSUMO_ANTERIOR_3,
           PEFAANO,
           PEFAMES
    FROM    open.cargos, open.servsusc, open.perifact
    WHERE   cargnuse = sesunuse
    AND     cargpefa = pefacodi
    AND     substr(cargdoso,1,2) not in ('DF','ID')
    AND     cargvalo > decode(cargconc,31,decode(sesucate,1,nuVlrConsMaxResi,nuVlrConsMaxCome),decode(sesucate,1,nuVlrOtroMaxResi,nuVlrOtroMaxCome))
    AND     sesucicl = nuCiclo
    AND     cargcuco = -1
    AND     pefaano = nuAno
    AND     pefames = nuMes;

    TYPE tbAltosConsu IS TABLE OF cuAltosConsu%ROWTYPE  ;
    v_tbAltosConsu tbAltosConsu;

    --verificacion de subsidios
    CURSOR cuVeriSubs IS
    SELECT  sesunuse PRODUCTO, sesucicl, pefaano,pefames,c.cargvalo VALOR, sesusuca SUBCATEGORIA, c.cargconc  , 'TIENE SUBSIDIO' OBSERVACION
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc = 196 -- Subsidio
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     ((sesucate = 1 AND sesusuca in (3,4,5,6)) OR sesucate = 2)
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
    UNION
    SELECT  DISTINCT sesunuse PRODUCTO, sesucicl, pefaano,pefames, 0 VALOR, sesusuca SUBCATEGORIA, -1 cargconc, 'NO TIENE SUBSIDIO' OBSERVACION
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     c.cargconc != 196
    AND     NOT EXISTS (SELECT 'X' FROM CARGOS c2  where c2.cargcuco = c.cargcuco and c2.cargconc = 196  AND  c2.cargcaca = 15 )
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo;

    TYPE tbVeriSubs IS TABLE OF cuVeriSubs%ROWTYPE  ;
    v_tbVeriSubs tbVeriSubs;

    --verificacion cargo fijo
    CURSOR cuVericargFijo IS
    SELECT  sesunuse PRODUCTO, sesucicl, pefaano,pefames,c.cargvalo VALOR, sesusuca SUBCATEGORIA, c.cargconc,  'TIENE CARGO FIJO' observacion
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc = 17 -- Cargo Fijo
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
    UNION
    (SELECT  PRODUCTO, sesucicl, pefaano,pefames, VALOR, SUBCATEGORIA, cargconc,  observacion FROM
    (SELECT  DISTINCT sesunuse PRODUCTO, sesucicl, pefaano,pefames,0 VALOR, sesusuca SUBCATEGORIA, -1 cargconc,  'NO TIENE CARGO FIJO' observacion
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc != 17 -- Cargo Fijo
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     NOT EXISTS (SELECT 'X' FROM CARGOS c2  where c2.cargcuco = c.cargcuco and c2.cargconc = 17  AND  c2.cargcaca = 15 )
    AND     ( (sesucate = 1 AND sesusuca in (3,4,5,6)) OR (sesucate = 2) )
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo)
    WHERE  fnuGetSuspxAcom (PRODUCTO, sbParameterACO) = 'N');

    TYPE tbVericargFijo IS TABLE OF cuVericargFijo%ROWTYPE  ;
    v_tbVericargFijo tbVericargFijo;

    --verificacion contribucion
    CURSOR cuVeriContri IS
    SELECT  sesunuse PRODUCTO, sesucicl, pefaano,pefames,cargvalo VALOR, sesusuca SUBCATEGORIA, cargconc,  'TIENE CONTRIBUCION' observacion
    FROM    open.cargos, open.servsusc, open.perifact
    WHERE   sesunuse = cargnuse
    AND     cargcuco = -1
    AND     cargconc = 37 -- Contribucion
    AND     cargcaca = 15    ---  generacion masiva
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     pefacodi = cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
    UNION
    SELECT  DISTINCT sesunuse PRODUCTO, sesucicl, pefaano,pefames,0 VALOR, sesusuca SUBCATEGORIA, -1 cargconc,  'NO TIENE CONTRIBUCION' observacion
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc != 37 -- Contribucion
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     NOT EXISTS (SELECT 'X' FROM CARGOS c2  where c2.cargcuco = c.cargcuco and c2.cargconc = 37  AND  c2.cargcaca = 15 )
    AND     ( (sesucate = 1 AND sesusuca in (5,6)) OR (sesucate IN (2,3)) )
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo;

    TYPE tbVeriContri IS TABLE OF cuVeriContri%ROWTYPE  ;
    v_tbVeriContri tbVeriContri;


    --verificacion compesacion
    CURSOR cuVeriComp IS
    SELECT   sesucicl, pefaano, pefames, count(1) Cantidad
    FROM    open.cargos, open.servsusc, open.perifact
    WHERE   sesunuse = cargnuse
    AND     cargcuco = -1
    AND     cargconc = 25      -- compensacion
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     sesucicl = nuciclo               -- Parametro
    AND     pefacodi = cargpefa
    AND     pefaano = nuano            -- Parametro
    AND     pefames = numes                -- Parametro
    GROUP BY sesucicl, pefaano, pefames;

    TYPE tbVeriComp IS TABLE OF cuVeriComp%ROWTYPE  ;
    v_tbVeriComp   tbVeriComp;


    --verificacion de tarifas aplicadas incorrectas
   CURSOR cuVeriTariInco IS
    SELECT PRODUCTO, NUCICLO,  REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 1 ) Tarifa_Aplicada,  REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 2 ) tarifa_concepto,
           valor_Cargo, MT3,
           lomrmeco || ' - ' || (SELECT MR.MEREDESC FROM FA_MERCRELE MR WHERE MR.MERECODI = lomrmeco)  MERCADORELEVANTE,
           categ || ' - ' || (SELECT CT.CATEDESC FROM CATEGORI CT WHERE CT.CATECODI = CATEG) CATEGORIA,
           subcateg || ' - ' || (SELECT SB.SUCADESC FROM SUBCATEG SB WHERE SB.SUCACATE = CATEG AND SB.SUCACODI = SUBCATEG) SUBCATEGORIA,
           cargconc || ' - ' || (SELECT CONCDESC FROM CONCEPTO WHERE CONCCODI=CARGCONC) CONCEPTO,
           REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 3 ) FECHA_INICIAL, REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 4 ) FECHA_FINAL,
           REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 5 ) RANGO, to_number(REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 6 )) VALOR_TARIFA,
           valor_Cargo VALOR_LIQUI, to_number(REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 6 )) - valor_Cargo DIFERENCIA, NUANO,     NUMES
    FROM
     (select cuconuse producto, NUCICLO,
           cargvalo valor_Cargo, cargunid mt3,  lm.lomrmeco, cucocate categ, cucosuca subcateg, cargconc, NUANO,     NUMES,
           fnuGetTarifa (cargpeco, cargconc, cucocate, cucosuca, lomrmeco, cargunid) TARIFA
      from open.factura, open.cuencobr , open.cargos, open.perifact p,  open.pr_product pr, open.ab_address ad, open.fa_locamere lm
     where factcodi=cucofact
       and cucocodi=cargcuco
       and factpefa=pefacodi
       and cuconuse=pr.product_id
       and pr.address_id=ad.address_id
       and lm.lomrloid = ad.geograp_location_id
       and pefaano=NUANO
       and pefames=NUMES
       and pefacicl=NUCICLO
       and factprog=6
       and cargconc in (17,31)
       and substr(cargdoso,1,2) NOT IN ('DF','ID'));

   /*CURSOR cuVeriTariInco IS
        SELECT PRODUCTO,
           NUCICLO,
           tarifa_vigente||' - '||tarifa_desc Tarifa_Aplicada,
           tarifa_concepto,
           VALOR_CARGO,
           MT3,
           MERCADORELEVANTE,
           CATEGORIA,
           SUBCATEGORIA,
           CONCEPTO,
           FECHA_INICIAL,
           FECHA_FINAL,
           RANGO,
           VALOR_TARIFA,
           VALOR_LIQUI,
         round( ( VALOR_TARIFA - VALOR_LIQUI ),0) diferencia,
        NUANO,
        NUMES

    FROM (
        SELECT Cargnuse Producto,
               Cargvalo Valor_Cargo,
               Nvl(Cargunid,0) Mt3,
               A.Tacpcr03 ||' - '||  Meredesc Mercadorelevante,
               A.Tacpcr02||' - '||(SELECT Catedesc FROM OPEN.Categori WHERE Catecodi = A.Tacpcr02) Categoria,
               A.Tacpcr01 ||' - '||(SELECT Sucadesc FROM OPEN.Subcateg WHERE Sucacate = A.Tacpcr02 AND Sucacodi = A.Tacpcr01 )  Subcategoria,
               B1.Cotcconc || ' - ' || (SELECT Co.Concdesc FROM OPEN.Concepto Co WHERE Co.Conccodi =  B1.Cotcconc) Concepto,

               D.Vitpfein Fecha_Inicial,
               D.Vitpfefi Fecha_Final,
               Ravpliin || ' - '  || Ravplisu Rango,

			   -- se comenta por caso 200-2641, la tarifa ahora se calcula con la funcion FNCVALIDATARIFANUSE
               \* CASE WHEN Nvl(Ravpvalo,0) != 0 THEN Ravpvalo
                    ELSE
                         CASE WHEN Nvl(Vitpvalo,0) != 0 THEN Vitpvalo
                         ELSE
                            CASE WHEN Nvl(Ravpporc,0) != 0 THEN Ravpporc ELSE Vitpporc
                          END
                      END
                END *\
			   LDC_PKFAPC.FNCVALIDATARIFANUSE(ca.cargvalo, PC.PECSFEAI,PC.PECSFECF, LDC_PKFAPC.fdtdevuelvefecha(PC.PECSFEAI,PC.PECSFECF), Pr.Category_Id, Pr.Subcategory_Id, C.Merecodi, Nvl(Cargunid,0), Ca.Cargconc) Valor_Tarifa,
               Ca.Cargvalo Valor_Liqui, --caso 200-2641 cambio de alcance se modifica ralivalo por ralivaul
               D.Vitptacp  Tarifa_Vigente,
               Ca.Cargtaco Tarifa_Concepto,
               A.Tacpdesc Tarifa_Desc,
                B1.Cotcconc Cotcconc,
                A.Tacpcr02 Tacpcr02,
		        A.Tacpcr01 Tacpcr01,
                A.Tacpcr03 Tacpcr03
        FROM
		    OPEN.Ta_Conftaco B1,
            OPEN.Ta_Taricopr A,
            OPEN.Fa_Mercrele C,
            OPEN.Ta_Vigetacp D,
            OPEN.Ta_Rangvitp E,
            OPEN.Ta_Tariconc Tc,
            OPEN.Cargos Ca,
            OPEN.Rangliqu Rl,
            OPEN.Pericose Pc,
            OPEN.Perifact Pe,
            OPEN.Pr_Product Pr
        WHERE  D.Vitptipo = 'B'
          AND Ca.Cargnuse = Pr.Product_Id
          AND Ca.Cargpefa = Pe.Pefacodi
          AND Pe.Pefaano = nuano
          AND Pe.Pefames = numes
          AND Pe.Pefacicl = nuciclo
          AND Ca.Cargconc IN (31, 17)
          AND Ca.Cargpeco = Pc.Pecscons
          AND (CASE WHEN ( (last_day(trunc(PC.PECSFEAI)) - trunc(PC.PECSFEAI))  > trunc(PC.PECSFECF) - to_date('01/'||to_char(PC.PECSFECF,'mm')||'/'||to_char(PC.PECSFECF,'yyyy'), 'dd/mm/yyyy')
                              AND to_number(to_char(PC.PECSFEAI, 'mm')) <>  to_number(to_char(PC.PECSFECF, 'mm')) ) THEN
                             PC.PECSFEAI
                   WHEN ( (last_day(trunc(PC.PECSFEAI)) - trunc(PC.PECSFEAI))  < trunc(PC.PECSFECF) - to_date('01/'||to_char(PC.PECSFECF,'mm')||'/'||to_char(PC.PECSFECF,'yyyy'), 'dd/mm/yyyy')
                          AND to_number(to_char(PC.PECSFEAI, 'mm')) <>  to_number(to_char(PC.PECSFECF, 'mm')) ) THEN
                             PC.PECSFECF
                   ELSE
                     PC.PECSFECF
                END) BETWEEN D.Vitpfein AND D.Vitpfefi
          AND A.Tacpcr02= Pr.Category_Id
          AND A.Tacpcr01 = Pr.Subcategory_Id
          AND A.Tacpcr03 = ( SELECT Lomrmeco  FROM OPEN.Fa_Locamere,  OPEN.Ab_Address Dir WHERE Pr.Address_Id = Dir.Address_Id AND Lomrloid =  Dir.Geograp_Location_Id AND ROWNUM < 2)
          AND B1.Cotcconc = Ca.Cargconc
          AND A.Tacpcotc = B1.Cotccons
          AND     cargcuco = -1
          AND D.Vitptacp = A.Tacpcons
          AND E.Ravpvitp = D.Vitpcons
          AND B1.Cotccons = Tc.Tacocotc
          AND A.Tacpcr03 = C.Merecodi
          AND Tc.Tacocons = Ca.Cargtaco
          AND A.Tacptacc = Tc.Tacocons
          AND Rl.Ralisesu(+) = Ca.Cargnuse
          AND Rl.Ralipefa(+) = Ca.Cargpefa
          AND Rl.Ralipeco(+) = Ca.Cargpeco
          AND Rl.Raliconc(+) = Ca.Cargconc
    --     and  cargnuse =   50500234
         and cargunid between Rl.Raliliir and Rl.Ralilisr -- 200-2641 se tiene en cuenta para que no salga en todos los rangos
         AND E.Ravpliin = Nvl(Rl.Raliliir,E.Ravpliin)
          AND E.Ravplisu = Nvl(Rl.Ralilisr, E.Ravplisu) )
      WHERE round((Valor_Tarifa -   Valor_Liqui),0) <> 0;*/


    TYPE tbVeriTariInco IS TABLE OF cuVeriTariInco%ROWTYPE  ;
    v_tbVeriTariInco   tbVeriTariInco;


    --verificacion de facturacion de seguros
    CURSOR cuVeriFactSegu IS
    select SESUNUSE Producto, SUM (CANT), NUCICLO, NUANO, NUMES
    FROM (
        SELECT /*+ index(po IDX_LD_POLICY_03)*/SESUNUSE, COUNT(*) CANT
        FROM OPEN.LD_POLICY pz, OPEN.SERVSUSC, open.perifact, DIFERIDO
        WHERE PRODUCT_ID = SESUNUSE AND
          SESUSERV  = 7053 AND
          STATE_POLICY = 1 AND
          pefaano = NUANO AND
          pefames = NUMES AND
          PEFACICL = sesucicl AND
          sesucicl = NUCICLO AND
          pz.deferred_policy_id = difecodi AND
          nvl(difeenre,'N') = 'N' AND -- ca291 que no este en reclamo
          not EXISTS (SELECT /*+ index (p IDX_CC_GRACE_PERI_DEFE01) */ 1 FROM  open.CC_GRACE_PERI_DEFE p where DEFERRED_ID = DEFERRED_POLICY_ID and END_DATE > pefaffmo )
        group by SESUNUSE
        UNION ALL
        SELECT SESUNUSE, COUNT(*) * -1
        FROM OPEN.CARGOS , OPEN.SERVSUSC, open.perifact
        WHERE CARGNUSE =  SESUNUSE
           AND CARGCUCO = -1
          AND pefacodi = cargpefa
          AND pefaano = NUANO
          AND pefames = NUMES
          AND sesucicl = NUCICLO
          AND SESUSERV  = 7053
          AND CARGDOSO   in  (select /*+ index(po IDX_LD_POLICY_03)*/ 'DF-'||DEFERRED_POLICY_ID from OPEN.LD_POLICY p where  STATE_POLICY = 1  AND PRODUCT_ID = SESUNUSE )
        group by SESUNUSE
        )
    GROUP BY SESUNUSE
    HAVING SUM(CANT) <> 0;

    TYPE tbVeriFactSegu IS TABLE OF cuVeriFactSegu%ROWTYPE  ;
    v_tbVeriFactSegu   tbVeriFactSegu;

   --se consultan productos con cargos con cuenta -1 que no tienen suscnupr = 2
  -- o que estan en un ciclo diferente al del cargpefa
  CURSOR cuProdNoFgcc IS
    select sesunuse,nuAno,nuMes,nuCiclo,'Suscnupr del Contrato ' || sesususc || ' es ' || suscnupr Observacion
      from open.servsusc, open.suscripc
     where sesususc=susccodi
       and sesucicl = nuCiclo
       and suscnupr != 2
       and sesunuse in (select distinct cargnuse
                          from cargos
                         where cargcuco=-1
                           and cargprog=5
                           and cargpefa=nupefa)
   union
 select sesunuse,nuAno,nuMes,nuCiclo, 'Ciclo del Contrato ' || sesususc || ' es ' || susccicl Observacion
   from open.servsusc, open.suscripc
  where sesususc=susccodi
    and sesucicl = nuCiclo
    and susccicl!= nuCiclo
    and sesunuse in (select distinct cargnuse
                       from cargos
                      where cargcuco=-1
                        and cargprog=5
                        and cargpefa=nupefa)
  union
  select cargnuse,nuAno,nuMes,nuCiclo, 'Producto tiene cargos con periodo de consumo posterior al del periodo actual' Observacion
   from cargos, perifact, pericose pc
  where cargpefa=pefacodi
    and pefacicl = pecscico
    and pecsfecf between pefafimo and pefaffmo
    and pefaano=nuANo
    and pefames=nuMes
    and pefacicl=nuCiclo
    and cargcuco=-1
    /*and cargprog=5*/
    and cargpeco>pc.pecscons;

    TYPE tbPrNoFgcc IS TABLE OF cuProdNoFgcc%ROWTYPE  ;

    v_tbPrNoFgcc   tbPrNoFgcc;


     --se valida que el correo este correcto
   /* CURSOR cuValidaEmail IS
    select '1'
   from dual
   where REGEXP_LIKE(TRIM(sbEmail), '^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$');*/

    -- este cursor valida que el email este correcto en su sintaxis
    CURSOR cuValidaEmail(inuEmail varchar2) IS
        select '1'
        from dual
        where REGEXP_LIKE(TRIM(inuEmail), '^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$');

    --este cursor separa lo emails
    cursor cuEmails is
      select column_value
         from table(ldc_boutilities.splitstrings(sbEmail, '|'));


    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(50);
    nuHilos                NUMBER := 1;
    nuLogProceso           ge_log_process.log_process_id%TYPE;
    nucantidad NUMBER;
    sbDato     VARCHAR2(1);

    VALIDA_TARIFA NUMBER; -- CASO 200-2461
   nuConsecutivo NUMBER;
   nuerror NUMBER;
    sberror VARCHAR2(4000);
	ex_dml_errors EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_dml_errors, -24381);
  nuIdReporte NUMBER;
  sbRemitente   ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER' );
 BEGIN

    pkerrors.Push('LDC_PKFAPC'); --Ticket 200-1892  ELAL -- Se inicia proceso de log de error

    SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER
      INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;

    ldc_proinsertaestaprog(nuparano,nuparmes,'LDCFAPC-'|| nuCiclo,'En ejecucion',nutsess,sbparuser);

    DELETE FROM LDC_CARGDOBL WHERE CADOANO = nuAno AND CADOMES = nuMes AND CADOCICL = nuCiclo;
    DELETE FROM LDC_CONSUALTO  WHERE COALANO = nuAno AND COALMES = nuMes AND COALCICL = nuCiclo;
    DELETE FROM LDC_VALALTCA  WHERE VAALANO = nuAno AND VAALMES = nuMes AND VAALCICL = nuCiclo;
    DELETE FROM LDC_VECSUCFC  WHERE VEUCANO = nuAno AND VEUCMES = nuMes AND VEUCCICL = nuCiclo;
    DELETE FROM LDC_VERICOMP  WHERE VECOANO = nuAno AND VECOMES = nuMes AND VECOCICL = nuCiclo;
    DELETE FROM LDC_VATAAPI  WHERE VAAAANO = nuAno AND VAAAMES = nuMes AND VAAACICL = nuCiclo;
    DELETE FROM LDC_VERIFASE   WHERE VEFAANO = nuAno AND VEFAMES = nuMes AND VEFACICL = nuCiclo;
    DELETE FROM LDC_PRNOFGCC  WHERE  ANO = nuAno AND MES = nuMes AND CICLO = nuCiclo;

     COMMIT;
    sbMensError := 'Comienza proceso';

    tcons.delete;
    nuIdReporte := LDC_PKFAAC.fnuGetReporteEncabezado('AUDIPOST', 'INCONSISTENCIAS PROCESO DE AUDITORIAS POSTERIORES');
    -- halla codigo del periodo
    open cuperifact (nuCiclo, nuano, numes);
    fetch cuperifact into nupefa, nupecs;
    if cuperifact%notfound then
      nupefa := -1;
      nupecs := -1;
    end if;
   close cuperifact;

   -- ingresa en la tabla consumo y fechas para cada producto
    nuprodu := -1;
    numecc := null;
    nucavc := null;
    nuconsu := 0;
    nucantrecu := 0;
    nuconsrecu := 0;
    nuconsrean := 0;
    for rg in cuConsumos (nupefa) loop
      if nuprodu = -1 then
         nuprodu := rg.cosssesu;
      end if;

      if nuprodu != rg.cosssesu then
        nuIdx := nuprodu;
        tcons(nuIdx).consumo  := nuconsu;
        tcons(nuIdx).cossmecc := numecc;
        tcons(nuIdx).cosscavc := nucavc;
        tcons(nuIdx).consant1 := null;
        tcons(nuIdx).consant2 := null;
        tcons(nuIdx).consant3 := null;

        nuprodu := rg.cosssesu;
        numecc := null;
        nucavc := null;
        nuconsu := 0;
      end if;

      if rg.cossmecc = 4 then  -- AND FLLI = 'S' ?
        nuconsu := nuconsu + rg.cosscoca;
      end if;

      if rg.cossmecc = 1 then  -- SOLO PARA MECC = 1?
        nucavc := rg.cosscavc;
      end if;

      if rg.cossmecc  /*!= 4*/ in (1,3) then
        numecc := rg.cossmecc;
      end if;

    end loop;

    -- ingresa el ultimo producto
    nuIdx := nuprodu;
    tcons(nuIdx).consumo  := nuconsu;
    tcons(nuIdx).cossmecc := numecc;
    tcons(nuIdx).cosscavc := nucavc;
    tcons(nuIdx).consant1 := null;
    tcons(nuIdx).consant2 := null;
    tcons(nuIdx).consant3 := null;

     -- halla pericodi de los 3 periodos anteriores
     nucant := 1;
     nuperiant1 := -1;
     nuperiant2 := -1;
     nuperiant3 := -1;
     dtfefiant1 := null;
     dtfefiant2 := null;
     dtfefiant3 := null;

     for rg2 in cuPeriAnte (nupefa, nuciclo) loop
       if nucant = 1 then
         nuperiant1 := rg2.pefacodi;
         dtfefiant1 := rg2.pefaffmo;
       elsif nucant = 2 then
         nuperiant2 := rg2.pefacodi;
         dtfefiant2 := rg2.pefaffmo;
       elsif nucant = 3 then
         nuperiant3 := rg2.pefacodi;
         dtfefiant3 := rg2.pefaffmo;
       end if;

       nucant :=  nucant + 1;
       if nucant > 3 then
         exit;
       end if;

     end loop;

     -- halla consumos el periodo anterior 1 y los ingresa en la tabla
     if nuperiant1 != -1 then
       for rg in cuConsAnte (nuperiant1,dtfefiant1) loop
         nuIdx := rg.cosssesu;
         if tcons.EXISTS(nuIdx) then
           tcons(nuIdx).consant1 := rg.consumo;
         end if;
        end loop;
     end if;

     if nuperiant2 != -1 then
       for rg in cuConsAnte (nuperiant2,dtfefiant2) loop
         nuIdx := rg.cosssesu;
         if tcons.EXISTS(nuIdx) then
           tcons(nuIdx).consant2 := rg.consumo;
         end if;
       end loop;
     end if;

     if nuperiant3 != -1 then
       for rg in cuConsAnte (nuperiant3,dtfefiant3) loop
         nuIdx := rg.cosssesu;
         if tcons.EXISTS(nuIdx) then
           tcons(nuIdx).consant3 := rg.consumo;
         end if;
       end loop;
     end if;

    /*nuIdx := tcons.first;
    dbms_output.put_line('nucant1 ' || nucant1);
    dbms_output.put_line('nucant2 ' || nucant2);
    dbms_output.put_line('nuprodu ' || nuIdx);
    dbms_output.put_line('nuconsu ' || tcons(nuIdx).consumo);
    dbms_output.put_line('cossmecc ' || tcons(nuIdx).cossmecc);
    dbms_output.put_line('cosscavc ' || tcons(nuIdx).cosscavc);
    dbms_output.put_line('consant1 ' || tcons(nuIdx).consant1);
    dbms_output.put_line('consant2 ' || tcons(nuIdx).consant2);
    dbms_output.put_line('consant3 ' || tcons(nuIdx).consant3);*/

   sbMensError := 'Ejecuta cuCargDobles ';
    --Ticket 200-1892  ELAL -- se procesan cargos dobles
	begin
		OPEN cuCargDobles;
		LOOP
		  FETCH cuCargDobles BULK COLLECT INTO v_tbCargDobles LIMIT 100;
			 BEGIN
			  FORALL i IN 1..v_tbCargDobles.COUNT SAVE EXCEPTIONS
					INSERT INTO LDC_CARGDOBL VALUES v_tbCargDobles(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuCargDobles%NOTFOUND;
		END LOOP;
		CLOSE cuCargDobles;
	 exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;
    sbMensError := 'Ejecuta cuAltosConsu ';
   --Ticket 200-1892  ELAL -- se procesan altos cargos
    begin
		OPEN cuAltosConsu;
		LOOP
		  FETCH cuAltosConsu BULK COLLECT INTO v_tbAltosConsu LIMIT 100;
		   BEGIN
			  FORALL i IN 1..v_tbAltosConsu.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VALALTCA VALUES v_tbAltosConsu(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuAltosConsu%NOTFOUND;
		END LOOP;
		CLOSE cuAltosConsu;
    exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;
    sbMensError := 'Ejecuta cuVeriSubs ';
    --Ticket 200-1892  ELAL -- se procesan verificacion de subsidios
	begin
		OPEN cuVeriSubs;
		LOOP
		  FETCH cuVeriSubs BULK COLLECT INTO v_tbVeriSubs LIMIT 100;
			BEGIN
			  FORALL i IN 1..v_tbVeriSubs.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VECSUCFC VALUES v_tbVeriSubs(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuVeriSubs%NOTFOUND;
		END LOOP;
		CLOSE cuVeriSubs;
	 exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;
     sbMensError := 'Ejecuta cuVericargFijo ';
     --Ticket 200-1892  ELAL -- se procesan verificacion de cargo fijo
	 begin
		OPEN cuVericargFijo;
		LOOP
		  FETCH cuVericargFijo BULK COLLECT INTO v_tbVericargFijo LIMIT 100;
			BEGIN
			  FORALL i IN 1..v_tbVericargFijo.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VECSUCFC VALUES v_tbVericargFijo(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuVericargFijo%NOTFOUND;
		END LOOP;
		CLOSE cuVericargFijo;
	 exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;

   sbMensError := 'Ejecuta cuVeriContri ';
   begin
		 --Ticket 200-1892  ELAL -- se procesan verificacion de contribucion
		OPEN cuVeriContri;
		LOOP
		  FETCH cuVeriContri BULK COLLECT INTO v_tbVeriContri LIMIT 100;

			 BEGIN
			  FORALL i IN 1..v_tbVeriContri.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VECSUCFC VALUES v_tbVeriContri(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuVeriContri%NOTFOUND;
		END LOOP;
		CLOSE cuVeriContri;
	  exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;
    sbMensError := 'Ejecuta cuVeriComp ';
     --Ticket 200-1892  ELAL -- se procesan verificacion de compensacion
	 begin
		OPEN cuVeriComp;
		LOOP
		  FETCH cuVeriComp BULK COLLECT INTO v_tbVeriComp LIMIT 100;
			BEGIN
			  FORALL i IN 1..v_tbVeriComp.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VERICOMP VALUES v_tbVeriComp(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuVeriComp%NOTFOUND;
		END LOOP;
		CLOSE cuVeriComp;
	   exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;
    sbMensError := 'Ejecuta cuVeriTariInco ';
    --Ticket 200-1892  ELAL -- se procesan verificacion de tarifas incorrectas concepto 31, 17
	begin
		OPEN cuVeriTariInco;
		LOOP
		  FETCH cuVeriTariInco BULK COLLECT INTO v_tbVeriTariInco LIMIT 100;
			 BEGIN
			  FORALL i IN 1..v_tbVeriTariInco.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VATAAPI VALUES v_tbVeriTariInco(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuVeriTariInco%NOTFOUND;
		END LOOP;
		CLOSE cuVeriTariInco;
	exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
	commit;

   sbMensError := 'Ejecuta cuVeriFactSegu ';
    --Ticket 200-1892  ELAL -- se procesan verificacion de compensacion
	begin
		OPEN cuVeriFactSegu;
		LOOP
		  FETCH cuVeriFactSegu BULK COLLECT INTO v_tbVeriFactSegu LIMIT 100;
			 BEGIN
			   FORALL i IN 1..v_tbVeriFactSegu.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VERIFASE VALUES v_tbVeriFactSegu(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuVeriFactSegu%NOTFOUND;
		END LOOP;
		CLOSE cuVeriFactSegu;
	exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;

    COMMIT;
     sbMensError := 'Ejecuta cuConsuAltos ';
  --Ticket 200-1892  ELAL -- se procesan consumos altos
    begin
		OPEN cuConsuAltos;
		LOOP
		  FETCH cuConsuAltos BULK COLLECT INTO v_tbConsuAltos LIMIT 100;
			BEGIN
			   FORALL i IN 1..v_tbConsuAltos.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_CONSUALTO VALUES v_tbConsuAltos(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuConsuAltos%NOTFOUND;
		END LOOP;
		CLOSE cuConsuAltos;
    exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;

    COMMIT;

   ------- Prod a los que no se le generarian cuentas
    sbMensError := 'proceso ProdNOFGCC ';
	begin
		OPEN cuProdNoFgcc;
		LOOP
		  FETCH cuProdNoFgcc BULK COLLECT INTO v_tbPrNoFgcc LIMIT 100;
			 BEGIN
			   FORALL i IN 1..v_tbPrNoFgcc.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_PRNOFGCC VALUES v_tbPrNoFgcc(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						LDC_PKFAAC.prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
											nuConsecutivo );
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuProdNoFgcc%NOTFOUND;
		END LOOP;

		CLOSE cuProdNoFgcc;
	 exception
		when others then
		     rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  LDC_PKFAAC.prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo );
	 END;
  commit;

    -- envia mail
   sbMensError := null;
   begin

	-------------- cambio caso 65 -------------------
     -- se implementa esta modificacion para adaptar al paquete para enviar multiples correos electronicos
     IF sbEmail IS NOT NULL THEN
       FOR item IN cuEmails
          LOOP
                OPEN cuValidaEmail(item.column_value);
                FETCH cuValidaEmail INTO sbDato;
                   IF cuValidaEmail%FOUND THEN
                      pkg_Correo.prcEnviaCorreo
                        ( 
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => TRIM(item.column_value),
                        isbAsunto           => 'Ejecucion del Proceso LDCFAPC-'||nuCiclo,
                        isbMensaje          => 'Proceso LDCFAPC Termino con exito para el ciclo['||nuCiclo||'], ano['||nuAno||'] y mes['||nuMes||']'
                        );
                       -- DBMS_OUTPUT.PUT_LINE('Email : ' || item.column_value);
                   END IF;
                CLOSE cuValidaEmail;

             EXIT WHEN cuEmails%NOTFOUND;  ---si no encuentra mas valores dentro del cursor termina el ciclo.
           END LOOP;
     END IF;

	 ------------------ cambio caso 65 -------------

    exception when others then
      sbMensError := 'Error enviando email, pero proceso Ok';
    end;

    tcons.delete;
    pkErrors.Pop; --Ticket 200-1892  ELAL -- Se finaliza el proceso de log de error
    ldc_proactualizaestaprog(nutsess,sbMensError,'LDCFAPC-'|| nuCiclo,'Ok');


 EXCEPTION

       WHEN ex.CONTROLLED_ERROR THEN
          tcons.delete;
          sbMensError := 'Error: ' || DBMS_UTILITY.format_error_backtrace;
          ldc_proactualizaestaprog(nutsess,sbMensError,'LDCFAPC-'|| nuCiclo,'Termino con error');
          raise;

      WHEN OTHERS THEN
          tcons.delete;
          Errors.setError;
          sbMensError := sbMensError||'Error No Controlado, '||DBMS_UTILITY.format_error_backtrace;
          Errors.SETMESSAGE(sbMensError);
          ldc_proactualizaestaprog(nutsess,sbMensError,'LDCFAPC-'|| nuCiclo,'Termino con error: ' || DBMS_UTILITY.format_error_backtrace);
          ROLLBACK;
          raise ex.CONTROLLED_ERROR;
end proGeneraAuditorias;

PROCEDURE PRGENEAUDPOSTXPROD( inuano IN  perifact.pefaano%type,
                               inumes IN  perifact.pefaano%type,
                               inuCiclo  IN NUMBER,
                               inuproducto IN NUMBER,
                               onuValida out number) IS
  /*******************************************************************************
     Metodo:       PRGENEAUDPOSTXPROD
     Descripcion:  Proceso que valida si hubo problema de auditorias posteriores
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion
       inuano         a?o
       inuMes         mes
       inuCiclo       ciclo
       inuproducto   PRODUCTO

     Salida             Descripcion
      onuValida       decuelve si el producto tiene auditoria posteriores
     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

    sbMensError      VARCHAR2(4000);  --Ticket 200-1892  ELAL -- se almacena error generado

    nuAno          NUMBER := inuano;
    nuMes          NUMBER := inumes;
    nuCiclo        NUMBER := inuCiclo;
    sbEmail        VARCHAR2(2000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_EMAILNOLE',NULL) ;

    nuPorcPromResi      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PORC_CONS_RECU_RESI_LDCPKFAAC', NULL);
    nuPorcPromCome      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PORC_CONS_RECU_COME_LDCPKFAAC', NULL);
    nuNumeConsProm      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('NUME_CONS_RECU_LDCPKFAAC', NULL);
    nuConsMaxResi       ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('CONSUMO_ACTUAL_1', NULL);
    nuConsMaxCome       ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('CONSUMO_ACTUAL_2', NULL);

    nuVlrConsMaxResi    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_CONSU_RESI', NULL);
    nuVlrOtroMaxResi    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_OTROS_RESI', NULL);
    nuVlrConsMaxCome    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_CONSU_COME', NULL);
    nuVlrOtroMaxCome    ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('VALOR_MAX_OTROS_COME', NULL);

    sbParameterACO      ld_parameter.value_chain%type  := dald_parameter.fsbGetValue_Chain('PE_ACTIVIDADES_SUSPENSION_ACO',0);

    --Ticket 200-1892  ELAL -- se consulta cargos dobles
   CURSOR cuCargDobles IS
   SELECT  distinct cargnuse PRODUCTO, -- numero del servicio
            sesucicl CICLO,
            cargconc CONCEPTO, -- concepto
            cargcaca CAUSAL, -- causa del cargo
            cargsign SIGNO, -- signo
            count(1) CANTIDAD,
            cargvalo VALOR, -- valor del cargo
            nuAno,
            nuMes
    FROM  open.cargos, open.servsusc, open.perifact
    WHERE   cargnuse = sesunuse
    AND     cargpefa = pefacodi
    AND     cargcuco = -1
    AND    sesucicl =  nuCiclo
    AND     pefaano = nuAno--*/2013
     AND     pefames = nuMes --*/10
	 and cargnuse = inuproducto
    GROUP BY cargcuco, -- cuenta de cobro
        cargnuse, -- numero del servicio
        cargconc, -- concepto
        cargcaca, -- causa del cargo
        cargsign, -- signo
        cargpefa, -- periodo facturacion
        cargvalo, -- valor del cargo
        cargdoso, -- documento de soporte
        cargunid, -- unidades
        cargfecr, -- fecha de creacion
        cargcoll, -- consecutivo de llamadas
        cargpeco, -- periodo de consumo
        cargvabl,
        sesucicl
    HAVING   ( COUNT(1) ) > 1;

    TYPE tbCargDobles IS TABLE OF cuCargDobles%ROWTYPE  ;
    v_tbCargDobles tbCargDobles;

    --consumos altos
    CURSOR cuConsuAltos IS
    SELECT  PRODUCTO,CICLO, CATEGORIA, SUBCATEGORIA, PEFACODI, PROMEDIO,CONSUMO_ACTUAL,CONSUMO_ANTERIOR_1,CONSUMO_ANTERIOR_2, CONSUMO_ANTERIOR_3, REGLA, NUANO, NUMES
    FROM    (
        SELECT   sesunuse PRODUCTO,
                ciclcodi CICLO,
                sesucate CATEGORIA,
                sesusuca SUBCATEGORIA,
                PEFACODI,

             fnuHallaPromedio (sesunuse, pefacodi, sesucate, sesusuca, pefaano, pefames) PROMEDIO, --CA291

             fnuGetDatosConsumo(sesunuse,'CONSACTU')  CONSUMO_ACTUAL,
             fnuGetDatosConsumo(sesunuse,'CONSANT1')  CONSUMO_ANTERIOR_1,
             fnuGetDatosConsumo(sesunuse,'CONSANT2')  CONSUMO_ANTERIOR_2,
             fnuGetDatosConsumo(sesunuse,'CONSANT3')  CONSUMO_ANTERIOR_3,
             fnuGetDatosConsumo(sesunuse,'COSSCAVC')  REGLA

        FROM    open.servsusc, open.perifact, open.ciclo

        WHERE   sesucicl = ciclcodi
        AND     ciclcodi = pefacicl
        AND     ciclcodi = nuCiclo--*/242
        AND     pefaano = nuAno--*/2013
        AND     pefames = nuMes --*/10
		and sesunuse = inuproducto
    )
   /* WHERE  ((CATEGORIA = 1 AND CONSUMO_ACTUAL > open.dald_parameter.fnuGetNumeric_Value('CONSUMO_ACTUAL_1', null) ) OR
             (CATEGORIA = 2 AND CONSUMO_ACTUAL > open.dald_parameter.fnuGetNumeric_Value('CONSUMO_ACTUAL_2',  null) ));*/
      WHERE   CONSUMO_ACTUAL > DECODE(CATEGORIA,1,nuConsMaxResi,nuConsMaxCome)
       AND   ( (CONSUMO_ACTUAL * 100 / PROMEDIO >  DECODE(CATEGORIA,1,nuPorcPromResi,nuPorcPromCome)) OR
              (CONSUMO_ACTUAL * 100 / fnuGetUltConsValido(PRODUCTO, PEFACODI) >  DECODE(CATEGORIA,1,nuPorcPromResi,nuPorcPromCome)) )
       AND   ( (fnuGetRegla2020(PRODUCTO, PEFACODI) = 'N')  OR (fnuGetRegla2020(PRODUCTO, PEFACODI) = 'S' AND fnuGetCambMedidor(PRODUCTO, PEFACODI) = 'S') );


    TYPE tbConsuAltos IS TABLE OF cuConsuAltos%ROWTYPE  ;
    v_tbConsuAltos tbConsuAltos;


   --valores altos cargos
    CURSOR cuAltosConsu IS
    SELECT  sesunuse PRODUCTO,
        sesucicl CICLO,
        sesuserv SERVICIO,
        cargconc CONCEPTO,
        cargsign SIGNO,
        sesucate CATEGORIA,
        sesusuca SUBCATEGORIA,
        cargdoso DOCUMENTO,
        cargvalo VALOR,
        cargcaca CAUSA_CARGO,
      -- open.pktblcauscarg.fsbgetdescription(cargcaca) DESCRIPCION_CAUSA,
        (SELECT hicoprpm.hcppcopr
            FROM Open.hicoprpm
            WHERE hicoprpm.hcppsesu = sesunuse
              AND hicoprpm.hcpptico = 1
              AND HCPPPECO = decode(cargpeco,null, null, fnuObtPerConsAnte(sesunuse,cargpeco))
              and rownum < 2) PROMEDIO,

             fnuGetDatosConsumo(sesunuse,'CONSACTU')  CONSUMO_ACTUAL,
             fnuGetDatosConsumo(sesunuse,'CONSANT1')  CONSUMO_ANTERIOR_1,
             fnuGetDatosConsumo(sesunuse,'CONSANT2')  CONSUMO_ANTERIOR_2,
             fnuGetDatosConsumo(sesunuse,'CONSANT3')  CONSUMO_ANTERIOR_3,
           PEFAANO,
           PEFAMES
    FROM    open.cargos, open.servsusc, open.perifact
    WHERE   cargnuse = sesunuse
    AND     cargpefa = pefacodi
    AND     substr(cargdoso,1,2) not in ('DF','ID')
    AND     cargvalo > decode(cargconc,31,decode(sesucate,1,nuVlrConsMaxResi,nuVlrConsMaxCome),decode(sesucate,1,nuVlrOtroMaxResi,nuVlrOtroMaxCome))
    AND     sesucicl = nuCiclo
    AND     cargcuco = -1
    AND     pefaano = nuAno
    AND     pefames = nuMes
	and     cargnuse = inuproducto;

    TYPE tbAltosConsu IS TABLE OF cuAltosConsu%ROWTYPE  ;
    v_tbAltosConsu tbAltosConsu;

    --verificacion de subsidios
    CURSOR cuVeriSubs IS
    SELECT  sesunuse PRODUCTO, sesucicl, pefaano,pefames,c.cargvalo VALOR, sesusuca SUBCATEGORIA, c.cargconc  , 'TIENE SUBSIDIO' OBSERVACION
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc = 196 -- Subsidio
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     ((sesucate = 1 AND sesusuca in (3,4,5,6)) OR sesucate = 2)
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
	and c.cargnuse = inuproducto
    UNION
    SELECT  DISTINCT sesunuse PRODUCTO, sesucicl, pefaano,pefames, 0 VALOR, sesusuca SUBCATEGORIA, -1 cargconc, 'NO TIENE SUBSIDIO' OBSERVACION
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     c.cargconc != 196
    AND     NOT EXISTS (SELECT 'X' FROM CARGOS c2  where c2.cargcuco = c.cargcuco and c2.cargconc = 196  AND  c2.cargcaca = 15 )
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
	and  c.cargnuse = inuproducto;

    TYPE tbVeriSubs IS TABLE OF cuVeriSubs%ROWTYPE  ;
    v_tbVeriSubs tbVeriSubs;

    --verificacion cargo fijo
    CURSOR cuVericargFijo IS
    SELECT  sesunuse PRODUCTO, sesucicl, pefaano,pefames,c.cargvalo VALOR, sesusuca SUBCATEGORIA, c.cargconc,  'TIENE CARGO FIJO' observacion
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc = 17 -- Cargo Fijo
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
	and c.cargnuse = inuproducto
    UNION
    (SELECT  PRODUCTO, sesucicl, pefaano,pefames, VALOR, SUBCATEGORIA, cargconc,  observacion FROM
    (SELECT  DISTINCT sesunuse PRODUCTO, sesucicl, pefaano,pefames,0 VALOR, sesusuca SUBCATEGORIA, -1 cargconc,  'NO TIENE CARGO FIJO' observacion
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc != 17 -- Cargo Fijo
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     NOT EXISTS (SELECT 'X' FROM CARGOS c2  where c2.cargcuco = c.cargcuco and c2.cargconc = 17  AND  c2.cargcaca = 15 )
    AND     ( (sesucate = 1 AND sesusuca in (3,4,5,6)) OR (sesucate = 2) )
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
	and c.cargnuse = inuproducto)
    WHERE  fnuGetSuspxAcom (PRODUCTO, sbParameterACO) = 'N');

    TYPE tbVericargFijo IS TABLE OF cuVericargFijo%ROWTYPE  ;
    v_tbVericargFijo tbVericargFijo;

    --verificacion contribucion
    CURSOR cuVeriContri IS
    SELECT  sesunuse PRODUCTO, sesucicl, pefaano,pefames,cargvalo VALOR, sesusuca SUBCATEGORIA, cargconc,  'TIENE CONTRIBUCION' observacion
    FROM    open.cargos, open.servsusc, open.perifact
    WHERE   sesunuse = cargnuse
    AND     cargcuco = -1
    AND     cargconc = 37 -- Contribucion
    AND     cargcaca = 15    ---  generacion masiva
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     pefacodi = cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
	and cargnuse = inuproducto
    UNION
    SELECT  DISTINCT sesunuse PRODUCTO, sesucicl, pefaano,pefames,0 VALOR, sesusuca SUBCATEGORIA, -1 cargconc,  'NO TIENE CONTRIBUCION' observacion
    FROM    open.cargos c, open.servsusc, open.perifact
    WHERE   sesunuse = c.cargnuse
    AND     c.cargcuco = -1
    AND     c.cargconc != 37 -- Contribucion
    AND     c.cargcaca = 15    ---  generacion masiva
    AND     NOT EXISTS (SELECT 'X' FROM CARGOS c2  where c2.cargcuco = c.cargcuco and c2.cargconc = 37  AND  c2.cargcaca = 15 )
    AND     ( (sesucate = 1 AND sesusuca in (5,6)) OR (sesucate IN (2,3)) )
    AND     pefacodi = c.cargpefa
    AND     pefaano = nuano
    AND     pefames = numes
    AND     sesucicl = nuciclo
	and c.cargnuse = inuproducto;

    TYPE tbVeriContri IS TABLE OF cuVeriContri%ROWTYPE  ;
    v_tbVeriContri tbVeriContri;


    --verificacion compesacion
    CURSOR cuVeriComp IS
    SELECT   sesucicl, pefaano, pefames, count(1) Cantidad
    FROM    open.cargos, open.servsusc, open.perifact
    WHERE   sesunuse = cargnuse
    AND     cargcuco = -1
    AND     cargconc = 25      -- compensacion
    AND     (sesucate = 1 AND sesusuca in (1,2))
    AND     sesucicl = nuciclo               -- Parametro
    AND     pefacodi = cargpefa
    AND     pefaano = nuano            -- Parametro
    AND     pefames = numes                -- Parametro
	and cargnuse = inuproducto
    GROUP BY sesucicl, pefaano, pefames;

    TYPE tbVeriComp IS TABLE OF cuVeriComp%ROWTYPE  ;
    v_tbVeriComp   tbVeriComp;


    --verificacion de tarifas aplicadas incorrectas
   CURSOR cuVeriTariInco IS
    SELECT PRODUCTO, NUCICLO,  REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 1 ) Tarifa_Aplicada,  REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 2 ) tarifa_concepto,
           valor_Cargo, MT3,
           lomrmeco || ' - ' || (SELECT MR.MEREDESC FROM FA_MERCRELE MR WHERE MR.MERECODI = lomrmeco)  MERCADORELEVANTE,
           categ || ' - ' || (SELECT CT.CATEDESC FROM CATEGORI CT WHERE CT.CATECODI = CATEG) CATEGORIA,
           subcateg || ' - ' || (SELECT SB.SUCADESC FROM SUBCATEG SB WHERE SB.SUCACATE = CATEG AND SB.SUCACODI = SUBCATEG) SUBCATEGORIA,
           cargconc || ' - ' || (SELECT CONCDESC FROM CONCEPTO WHERE CONCCODI=CARGCONC) CONCEPTO,
           REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 3 ) FECHA_INICIAL, REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 4 ) FECHA_FINAL,
           REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 5 ) RANGO, to_number(REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 6 )) VALOR_TARIFA,
           valor_Cargo VALOR_LIQUI, to_number(REGEXP_SUBSTR( TARIFA, '[^|]+', 1, 6 )) - valor_Cargo DIFERENCIA, NUANO,     NUMES
    FROM
     (select cuconuse producto, NUCICLO,
           cargvalo valor_Cargo, cargunid mt3,  lm.lomrmeco, cucocate categ, cucosuca subcateg, cargconc, NUANO,     NUMES,
           fnuGetTarifa (cargpeco, cargconc, cucocate, cucosuca, lomrmeco, cargunid) TARIFA
      from open.factura, open.cuencobr , open.cargos, open.perifact p,  open.pr_product pr, open.ab_address ad, open.fa_locamere lm
     where factcodi=cucofact
       and cucocodi=cargcuco
       and factpefa=pefacodi
       and cuconuse=pr.product_id
       and pr.address_id=ad.address_id
       and lm.lomrloid = ad.geograp_location_id
       and pefaano=NUANO
       and pefames=NUMES
       and pefacicl=NUCICLO
       and factprog=6
       and cargconc in (17,31)
       and substr(cargdoso,1,2) NOT IN ('DF','ID')
	   and cargnuse = inuproducto
	   );


    TYPE tbVeriTariInco IS TABLE OF cuVeriTariInco%ROWTYPE  ;
    v_tbVeriTariInco   tbVeriTariInco;


    --verificacion de facturacion de seguros
    CURSOR cuVeriFactSegu IS
    select SESUNUSE Producto, SUM (CANT), NUCICLO, NUANO, NUMES
    FROM (
        SELECT /*+ index(po IDX_LD_POLICY_03)*/SESUNUSE, COUNT(*) CANT
        FROM OPEN.LD_POLICY pz, OPEN.SERVSUSC, open.perifact, DIFERIDO
        WHERE PRODUCT_ID = SESUNUSE AND
          SESUSERV  = 7053 AND
          STATE_POLICY = 1 AND
          pefaano = NUANO AND
          pefames = NUMES AND
          PEFACICL = sesucicl AND
          sesucicl = NUCICLO AND
          pz.deferred_policy_id = difecodi AND
          nvl(difeenre,'N') = 'N' AND -- ca291 que no este en reclamo
          not EXISTS (SELECT /*+ index (p IDX_CC_GRACE_PERI_DEFE01) */ 1 FROM  open.CC_GRACE_PERI_DEFE p where DEFERRED_ID = DEFERRED_POLICY_ID and END_DATE > pefaffmo )
          and sesunuse = inuproducto
		group by SESUNUSE
        UNION ALL
        SELECT SESUNUSE, COUNT(*) * -1
        FROM OPEN.CARGOS , OPEN.SERVSUSC, open.perifact
        WHERE CARGNUSE =  SESUNUSE
           AND CARGCUCO = -1
          AND pefacodi = cargpefa
          AND pefaano = NUANO
          AND pefames = NUMES
          AND sesucicl = NUCICLO
          AND SESUSERV  = 7053
          AND CARGDOSO   in  (select /*+ index(po IDX_LD_POLICY_03)*/ 'DF-'||DEFERRED_POLICY_ID from OPEN.LD_POLICY p where  STATE_POLICY = 1  AND PRODUCT_ID = SESUNUSE )
          and cargnuse = inuproducto
		group by SESUNUSE
        )
    GROUP BY SESUNUSE
    HAVING SUM(CANT) <> 0;

    TYPE tbVeriFactSegu IS TABLE OF cuVeriFactSegu%ROWTYPE  ;
    v_tbVeriFactSegu   tbVeriFactSegu;

   --se consultan productos con cargos con cuenta -1 que no tienen suscnupr = 2
  -- o que estan en un ciclo diferente al del cargpefa
  CURSOR cuProdNoFgcc IS
    select sesunuse,nuAno,nuMes,nuCiclo,'Suscnupr del Contrato ' || sesususc || ' es ' || suscnupr Observacion
      from open.servsusc, open.suscripc
     where sesususc=susccodi
       and sesucicl = nuCiclo
       and suscnupr != 2
       and sesunuse in (select distinct cargnuse
                          from cargos
                         where cargcuco=-1
                           and cargprog=5
                           and cargpefa=nupefa
						   and cargnuse = inuproducto)
   union
 select sesunuse,nuAno,nuMes,nuCiclo, 'Ciclo del Contrato ' || sesususc || ' es ' || susccicl Observacion
   from open.servsusc, open.suscripc
  where sesususc=susccodi
    and sesucicl = nuCiclo
    and susccicl!= nuCiclo
    and sesunuse in (select distinct cargnuse
                       from cargos
                      where cargcuco=-1
                        and cargprog=5
                        and cargpefa=nupefa
						and cargnuse = inuproducto)
  union
  select cargnuse,nuAno,nuMes,nuCiclo, 'Producto tiene cargos con periodo de consumo posterior al del periodo actual' Observacion
   from cargos, perifact, pericose pc
  where cargpefa=pefacodi
    and pefacicl = pecscico
    and pecsfecf between pefafimo and pefaffmo
    and pefaano=nuANo
    and pefames=nuMes
    and pefacicl=nuCiclo
    and cargcuco=-1
    /*and cargprog=5*/
    and cargpeco>pc.pecscons
	and cargnuse = inuproducto;

    TYPE tbPrNoFgcc IS TABLE OF cuProdNoFgcc%ROWTYPE  ;

    v_tbPrNoFgcc   tbPrNoFgcc;


    --este cursor separa lo emails
    cursor cuEmails is
      select column_value
         from table(ldc_boutilities.splitstrings(sbEmail, ','));


    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(50);
    nuHilos                NUMBER := 1;
    nuLogProceso           ge_log_process.log_process_id%TYPE;
    nucantidad NUMBER;
    sbDato     VARCHAR2(1);

    VALIDA_TARIFA NUMBER; -- CASO 200-2461

 BEGIN


    DELETE FROM LDC_CARGDOBL WHERE CADOANO = inuano AND CADOMES = inumes AND CADOCICL = inuCiclo and CADOSESU = inuproducto;
    DELETE FROM LDC_CONSUALTO  WHERE COALANO = inuano AND COALMES = inumes AND COALCICL = inuCiclo and COALSESU = inuproducto;
    DELETE FROM LDC_VALALTCA  WHERE VAALANO = inuano AND VAALMES = inumes AND VAALCICL = inuCiclo and VAALSESU = inuproducto;
    DELETE FROM LDC_VECSUCFC  WHERE VEUCANO = inuano AND VEUCMES = inumes AND VEUCCICL = inuCiclo and VEUCSESU =  inuproducto;
    --DELETE FROM LDC_VERICOMP  WHERE VECOANO = inuano AND VECOMES = inumes AND VECOCICL = inuCiclo;
    DELETE FROM LDC_VATAAPI  WHERE VAAAANO = inuano AND VAAAMES = inumes AND VAAACICL = inuCiclo and VAAASESU = inuproducto;
    DELETE FROM LDC_VERIFASE   WHERE VEFAANO = inuano AND VEFAMES = inumes AND VEFACICL = inuCiclo and VEFASESU = inuproducto ;
    DELETE FROM LDC_PRNOFGCC  WHERE  ANO = inuano AND MES = inumes AND CICLO = inuCiclo and PRODUCTO = inuproducto;

     COMMIT;
    sbMensError := 'Comienza proceso';

    tcons.delete;
	onuValida := 0;
    -- halla codigo del periodo
    open cuperifact (inuCiclo, inuano, inumes);
    fetch cuperifact into nupefa, nupecs;
    if cuperifact%notfound then
      nupefa := -1;
      nupecs := -1;
    end if;
   close cuperifact;

   -- ingresa en la tabla consumo y fechas para cada producto
    nuprodu := -1;
    numecc := null;
    nucavc := null;
    nuconsu := 0;
    nucantrecu := 0;
    nuconsrecu := 0;
    nuconsrean := 0;
    for rg in cuConsumos (nupefa) loop
      if nuprodu = -1 then
         nuprodu := rg.cosssesu;
      end if;

      if nuprodu != rg.cosssesu then
        nuIdx := nuprodu;
        tcons(nuIdx).consumo  := nuconsu;
        tcons(nuIdx).cossmecc := numecc;
        tcons(nuIdx).cosscavc := nucavc;
        tcons(nuIdx).consant1 := null;
        tcons(nuIdx).consant2 := null;
        tcons(nuIdx).consant3 := null;

        nuprodu := rg.cosssesu;
        numecc := null;
        nucavc := null;
        nuconsu := 0;
      end if;

      if rg.cossmecc = 4 then  -- AND FLLI = 'S' ?
        nuconsu := nuconsu + rg.cosscoca;
      end if;

      if rg.cossmecc = 1 then  -- SOLO PARA MECC = 1?
        nucavc := rg.cosscavc;
      end if;

      if rg.cossmecc  /*!= 4*/ in (1,3) then
        numecc := rg.cossmecc;
      end if;

    end loop;

    -- ingresa el ultimo producto
    nuIdx := nuprodu;
    tcons(nuIdx).consumo  := nuconsu;
    tcons(nuIdx).cossmecc := numecc;
    tcons(nuIdx).cosscavc := nucavc;
    tcons(nuIdx).consant1 := null;
    tcons(nuIdx).consant2 := null;
    tcons(nuIdx).consant3 := null;

     -- halla pericodi de los 3 periodos anteriores
     nucant := 1;
     nuperiant1 := -1;
     nuperiant2 := -1;
     nuperiant3 := -1;
     dtfefiant1 := null;
     dtfefiant2 := null;
     dtfefiant3 := null;

     for rg2 in cuPeriAnte (nupefa, inuCiclo) loop
       if nucant = 1 then
         nuperiant1 := rg2.pefacodi;
         dtfefiant1 := rg2.pefaffmo;
       elsif nucant = 2 then
         nuperiant2 := rg2.pefacodi;
         dtfefiant2 := rg2.pefaffmo;
       elsif nucant = 3 then
         nuperiant3 := rg2.pefacodi;
         dtfefiant3 := rg2.pefaffmo;
       end if;

       nucant :=  nucant + 1;
       if nucant > 3 then
         exit;
       end if;

     end loop;

     -- halla consumos el periodo anterior 1 y los ingresa en la tabla
     if nuperiant1 != -1 then
       for rg in cuConsAnte (nuperiant1,dtfefiant1) loop
         nuIdx := rg.cosssesu;
         if tcons.EXISTS(nuIdx) then
           tcons(nuIdx).consant1 := rg.consumo;
         end if;
        end loop;
     end if;

     if nuperiant2 != -1 then
       for rg in cuConsAnte (nuperiant2,dtfefiant2) loop
         nuIdx := rg.cosssesu;
         if tcons.EXISTS(nuIdx) then
           tcons(nuIdx).consant2 := rg.consumo;
         end if;
       end loop;
     end if;

     if nuperiant3 != -1 then
       for rg in cuConsAnte (nuperiant3,dtfefiant3) loop
         nuIdx := rg.cosssesu;
         if tcons.EXISTS(nuIdx) then
           tcons(nuIdx).consant3 := rg.consumo;
         end if;
       end loop;
     end if;


    --Ticket 200-1892  ELAL -- se procesan cargos dobles
    OPEN cuCargDobles;
    LOOP
      FETCH cuCargDobles BULK COLLECT INTO v_tbCargDobles LIMIT 100;
       FORALL i IN 1..v_tbCargDobles.COUNT
         INSERT INTO LDC_CARGDOBL VALUES v_tbCargDobles(i);
		 onuValida := 1;
      EXIT WHEN cuCargDobles%NOTFOUND;
    END LOOP;
    CLOSE cuCargDobles;
	commit;
   sbMensError := 'Ejecuta cuCargDobles';
   --Ticket 200-1892  ELAL -- se procesan altos cargos
    OPEN cuAltosConsu;
    LOOP
      FETCH cuAltosConsu BULK COLLECT INTO v_tbAltosConsu LIMIT 100;
       FORALL i IN 1..v_tbAltosConsu.COUNT
         INSERT INTO LDC_VALALTCA VALUES v_tbAltosConsu(i);
		 onuValida := 1;
      EXIT WHEN cuAltosConsu%NOTFOUND;
    END LOOP;
    CLOSE cuAltosConsu;
	commit;
sbMensError := 'Ejecuta cuAltosConsu';
    --Ticket 200-1892  ELAL -- se procesan verificacion de subsidios
    OPEN cuVeriSubs;
    LOOP
      FETCH cuVeriSubs BULK COLLECT INTO v_tbVeriSubs LIMIT 100;
       FORALL i IN 1..v_tbVeriSubs.COUNT
         INSERT INTO LDC_VECSUCFC VALUES v_tbVeriSubs(i);
		 onuValida := 1;
      EXIT WHEN cuVeriSubs%NOTFOUND;
    END LOOP;
    CLOSE cuVeriSubs;
	commit;
     sbMensError := 'Ejecuta cuVeriSubs';
     --Ticket 200-1892  ELAL -- se procesan verificacion de cargo fijo
    OPEN cuVericargFijo;
    LOOP
      FETCH cuVericargFijo BULK COLLECT INTO v_tbVericargFijo LIMIT 100;
       FORALL i IN 1..v_tbVericargFijo.COUNT
         INSERT INTO LDC_VECSUCFC VALUES v_tbVericargFijo(i);
		 onuValida := 1;
      EXIT WHEN cuVericargFijo%NOTFOUND;
    END LOOP;
    CLOSE cuVericargFijo;
	commit;
    sbMensError := 'Ejecuta cuVericargFijo';

     --Ticket 200-1892  ELAL -- se procesan verificacion de contribucion
    OPEN cuVeriContri;
    LOOP
      FETCH cuVeriContri BULK COLLECT INTO v_tbVeriContri LIMIT 100;
       FORALL i IN 1..v_tbVeriContri.COUNT
         INSERT INTO LDC_VECSUCFC VALUES v_tbVeriContri(i);
		 onuValida := 1;
      EXIT WHEN cuVeriContri%NOTFOUND;
    END LOOP;
    CLOSE cuVeriContri;
	commit;
sbMensError := 'Ejecuta cuVeriContri';
     --Ticket 200-1892  ELAL -- se procesan verificacion de compensacion
    OPEN cuVeriComp;
    LOOP
      FETCH cuVeriComp BULK COLLECT INTO v_tbVeriComp LIMIT 100;
       FORALL i IN 1..v_tbVeriComp.COUNT
         INSERT INTO LDC_VERICOMP VALUES v_tbVeriComp(i);
		 onuValida := 1;
      EXIT WHEN cuVeriComp%NOTFOUND;
    END LOOP;
    CLOSE cuVeriComp;
	commit;
sbMensError := 'Ejecuta cuVeriComp';
    --Ticket 200-1892  ELAL -- se procesan verificacion de tarifas incorrectas concepto 31, 17
    OPEN cuVeriTariInco;
    LOOP
      FETCH cuVeriTariInco BULK COLLECT INTO v_tbVeriTariInco LIMIT 100;
       FORALL i IN 1..v_tbVeriTariInco.COUNT
         INSERT INTO LDC_VATAAPI VALUES v_tbVeriTariInco(i);
		 onuValida := 1;
      EXIT WHEN cuVeriTariInco%NOTFOUND;
    END LOOP;
    CLOSE cuVeriTariInco;
	commit;

sbMensError := 'Ejecuta cuVeriTariInco';
    --Ticket 200-1892  ELAL -- se procesan verificacion de compensacion
    OPEN cuVeriFactSegu;
    LOOP
      FETCH cuVeriFactSegu BULK COLLECT INTO v_tbVeriFactSegu LIMIT 100;
       FORALL i IN 1..v_tbVeriFactSegu.COUNT
         INSERT INTO LDC_VERIFASE VALUES v_tbVeriFactSegu(i);
		 onuValida := 1;
      EXIT WHEN cuVeriFactSegu%NOTFOUND;
    END LOOP;
    CLOSE cuVeriFactSegu;
    sbMensError := 'Ejecuta cuVeriFactSegu';
  --  COMMIT;

  --Ticket 200-1892  ELAL -- se procesan consumos altos
    OPEN cuConsuAltos;
    LOOP
      FETCH cuConsuAltos BULK COLLECT INTO v_tbConsuAltos LIMIT 100;
       FORALL i IN 1..v_tbConsuAltos.COUNT
         INSERT INTO LDC_CONSUALTO VALUES v_tbConsuAltos(i);
		 onuValida := 1;
      EXIT WHEN cuConsuAltos%NOTFOUND;
    END LOOP;
    CLOSE cuConsuAltos;
    sbMensError := 'Ejecuta cuConsuAltos';
  --  COMMIT;

   ------- Prod a los que no se le generarian cuentas
    sbMensError := 'proceso ProdNOFGCC';
    OPEN cuProdNoFgcc;
    LOOP
      FETCH cuProdNoFgcc BULK COLLECT INTO v_tbPrNoFgcc LIMIT 100;
       FORALL i IN 1..v_tbPrNoFgcc.COUNT
         INSERT INTO LDC_PRNOFGCC VALUES v_tbPrNoFgcc(i);
         onuValida := 1;
      EXIT WHEN cuProdNoFgcc%NOTFOUND;
    END LOOP;

    CLOSE cuProdNoFgcc;
  commit;

    tcons.delete;
    pkErrors.Pop; --Ticket 200-1892  ELAL -- Se finaliza el proceso de log de error

    IF onuValida = 1 THEN
       prGeneraArchiExcel( inuano,
                            inumes,
                            inuCiclo,
                            inuProducto);
    END IF;

 EXCEPTION
   WHEN ex.CONTROLLED_ERROR THEN
	  tcons.delete;
	  sbMensError := 'Error: ' || DBMS_UTILITY.format_error_backtrace;
	  raise;

  WHEN OTHERS THEN
	  tcons.delete;
	  Errors.setError;
	  sbMensError := sbMensError||'Error No Controlado, '||DBMS_UTILITY.format_error_backtrace;
	  Errors.SETMESSAGE(sbMensError);
	  ROLLBACK;
	  raise ex.CONTROLLED_ERROR;
end PRGENEAUDPOSTXPROD;

PROCEDURE prGeneraArchiExcel( inuano IN NUMBER,
                              inumes IN NUMBER,
                              inuCiclo IN NUMBER,
                              inuProducto IN NUMBER) IS
 /*******************************************************************************
     Metodo:       prGeneraArchiExcel
     Descripcion:  Proceso que genera archivo de excel
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion
       inuano         a?o
       inuMes         mes
       inuCiclo       ciclo
       inuproducto   PRODUCTO

     Salida             Descripcion

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

    sbruta VARCHAR2(4000)	:= OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDCPARMRUTAPOSTERIORES',NULL);
    sbNomArch VARCHAR2(4000);
    sbNomHoja         VARCHAR2(2000);
    SBSENTENCIA       CLOB;
    sb_subject        VARCHAR2(200)  := 'Proceso de Auditorias Posteriores Terminado';
    sb_text_msg       VARCHAR2(200)   := 'Se realiza el proceso de auditorias posteriores para el producto ['||inuProducto||']';
   sbEmailNoti VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_EMAILNOLE',NULL);

    sbsentc1          CLOB;
    sbsentc2          CLOB;
    sbsentc3          CLOB;
    sbsentc4          CLOB;
    sbsentc5          CLOB;
    sbsentc6          CLOB;
    sbsentc7          CLOB;
    sbsentc8          CLOB;
    sbsentc9          CLOB;

    -- variables para el proceso de generacion de cargos --
    sentence          CLOB;

        --este cursor separa lo emails
    cursor cuEmails(sbEmail VARCHAR2, sbseparador VARCHAR2) is
    select column_value
    from table(ldc_boutilities.splitstrings(sbEmail, sbseparador));

    sbRemitente   ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER' );

BEGIN
   sbNomArch := 'Repo_Audi_Post_Producto_'||inuProducto||'_'||TO_CHAR(SYSDATE, 'DDMMYYYY_HH24MISS');
     --- Cargos Dobles: --
    sbsentc1 :=     'SELECT
                              CADOCICL CICLO,
                              CADOSESU  PRODUCTO,
                              CADOCONC CONCEPTO,
                              CADOCACA CAUSAL,
                              CADOSIGN SIGNO,
                              CADOCANT  CANTIDAD,
                              CADOVALO VALOR
                     FROM	open.LDC_CARGDOBL
                     WHERE CADOANO = '||inuano||'
                          AND CADOMES = '||inumes||'
                          AND CADOCICL = '||inuCiclo||'
                          AND CADOSESU = '||inuProducto;


    --- Consumos Altos --
      sbsentc2 :=     'SELECT
                                  COALCICL CICLO,
                                  COALSESU PRODUCTO,
                                  COALCATE CATEGORIA,
                                  COALSUCA SUBCATEGORIA,
                                  COALPEFA  PEFACODI   ,
                                  COALCATE   sesucate,
                                  nvl(COALCOPR,0) PROMEDIO,
                                  nvl(COALCOAC,0) CONSUMO_ACTUAL,
                                  nvl(COALCOAN,0)  CONSUMO_ANTERIOR_1,
                                  nvl(COALCOAS,0) CONSUMO_ANTERIOR_2,
                                  nvl(COALCOAT,0) CONSUMO_ANTERIOR_3,
                                  coalregl regla
                          FROM    open.LDC_CONSUALTO
                          WHERE   COALANO= '||inuano||'
                          AND     COALMES = '||inumes||'
                          AND     COALCICL= '||inuCiclo||'
                          and COALSESU = '||inuProducto;


     --- Valores Altos Cargos: --
      sbsentc3 :=     'SELECT
                                  VAALCICL CICLO,
                                  VAALSESU PRODUCTO,
                                  VAALSERV SERVICIO,
                                  VAALCONC CONCEPTO,
                                  VAALSIGN SIGNO,
                                  VAALCATE CATEGORIA,
                                  VAALSUCA SUBCATEGORIA,
                                  VAALDOSO DOCUMENTO,
                                  VAALVALO VALOR,
                                  VAALCACA CAUSA_CARGO,
                                  open.pktblcauscarg.fsbgetdescription(VAALCACA) DESCRIPCION_CAUSA,
                                  nvl(VAALCOPR,0)  PROMEDIO,
                                  nvl(VAALCOAC,0)  CONSUMO_ACTUAL,
                                  nvl( VAALCOAN,0)  CONSUMO_ANTERIOR_1,
                                  nvl(VAALCOAS,0) CONSUMO_ANTERIOR_2,
                                  nvl(VAALCOAT,0) CONSUMO_ANTERIOR_3
                          FROM    open.LDC_VALALTCA
                          WHERE   VAALANO= '||inuano||'
                          AND     VAALMES = '||inumes||'
                          AND     VAALCICL= '||inuCiclo||'
                          and VAALSESU = '||inuProducto;


     --- Verificacion Subsidio: --
      sbsentc4 :=     'SELECT
                              VEUCCICL  sesucicl,
                              VEUCANO  pefaano,
                              VEUCMES pefames,
                              VEUCSESU PRODUCTO,
                              VEUCVALO VALOR,
                              VEUCSUCA SUBCATEGORIA
                          FROM    open.LDC_VECSUCFC
                          WHERE   VEUCANO= '||inuano||'
                          AND     VEUCMES = '||inumes||'
                          AND     VEUCCICL= '||inuCiclo||'
                          and     VEUCSESU = '||inuProducto||'
                          AND     VECSCONC=  '||196||' -- Subsidio' ;


       --- Verificacion Cargos Fijo: --
       sbsentc5 :=     'SELECT
                                VEUCCICL  sesucicl,
                                VEUCANO  pefaano,
                                VEUCMES pefames,
                                VEUCSESU PRODUCTO,
                                VEUCVALO VALOR,
                                VEUCSUCA SUBCATEGORIA
                          FROM    open.LDC_VECSUCFC
                          WHERE    VEUCANO= '||inuano||'
                          AND     VEUCMES = '||inumes||'
                          AND     VEUCCICL= '||inuCiclo||'
                          and     VEUCSESU = '||inuProducto||'
                          AND     VECSCONC= '||17||' -- Cargo Fijo' ;


     --- Verificacion contribuccion: --
       sbsentc6 :=     '  SELECT
                                  VEUCCICL  sesucicl,
                                  VEUCANO  pefaano,
                                  VEUCMES pefames,
                                  VEUCSESU PRODUCTO,
                                  VEUCVALO VALOR,
                                  VEUCSUCA SUBCATEGORIA
                            FROM    open.LDC_VECSUCFC
                            WHERE    VEUCANO= '||inuano||'
                              AND     VEUCMES = '||inumes||'
                              AND     VEUCCICL= '||inuCiclo||'
                              and     VEUCSESU = '||inuProducto||'
                              AND     VECSCONC= '||37||' -- Contribucion' ;


       --- Verificacion contribuccion: --
      sbsentc7 :=     '  SELECT
                                   VECOCANT Cantidad,
                                   VECOCICL sesucicl,
                                   VECOMES pefames,
                                   VECOANO pefaano
                            FROM    open.LDC_VERICOMP
                            WHERE   VECOANO= '||inuano||'
                            AND     VECOMES = '||inumes||'
                            AND     VECOCICL= '||inuCiclo ;



      --- Verificacion de tarifas aplicadas incorrectamente[Consumo - Cargo Fijo]: --
      sbsentc8 :=     ' SELECT
                                  VAAASESU PRODUCTO,
                                  VAAATAAP Tarifa_Aplicada,
                                  VAAATACO tarifa_concepto,
                                  VAAAVALO VALOR_CARGO,
                                  VAAAUNID  MT3,
                                  VAAAMERE MERCADORELEVANTE,
                                  VAAACATE CATEGORIA,
                                  VAAASUCA SUBCATEGORIA,
                                  VAAACONC  CONCEPTO,
                                  VAAAFEIN  FECHA_INICIAL,
                                  VAAAFEFI   FECHA_FINAL,
                                  VAAARANG  RANGO,
                                  VAAAVATA  VALOR_TARIFA,
                                  VAAAVALI  VALOR_LIQUI,
                                  VAAADIFE  diferencia
                           FROM   open.LDC_VATAAPI
                           WHERE   VAAAANO = '||inuano||'
                           AND     VAAAMES = '||inumes||'
                           AND     VAAACICL= '||inuCiclo||'
                           and VAAASESU = '||inuProducto;


     --- Verificacion Facturacion serv. 7053:  --
     sbsentc9 :=    'select
                              VEFASESU Producto,
                              VEFACANT cant
                      FROM open.LDC_VERIFASE
                      WHERE   VEFAANO  =  '||inuano||'
                      AND     VEFAMES  = '||inumes||'
                      AND     VEFACICL = '||inuCiclo||'
                      and VEFASESU = '||inuProducto;

          ----------------------------------------------------------------------------------------
          -- Finaliza Bloque se sentencias
          ----------------------------------------------------------------------------------------

         -- se concatenan los nombres de las hojas del documento de excel
          sbNomHoja := 'Cargos Dobles'||'|'||
                       'Consumos Altos'||'|'||
                       'Valores Altos Cargos'||'|'||
                       'Verificacion Subsidio'||'|'||
                       'Verificacion Cargos Fijo'||'|'||
                       'Verificacion contribuccion'||'|'||
                       'Verificacion compensacion'||'|'||
                       'Verificacion de tarifas aplicadas incorrectamente[Consumo - Cargo Fijo]'||'|'||
                       'Verificacion Facturacion serv_7053';

          -- se concantenan las sentencias para enviarlas al procedimiento de creacion del excel
          SBSENTENCIA :=   sbsentc1||'|'||
                           sbsentc2||'|'||
                           sbsentc3||'|'||
                           sbsentc4||'|'||
                           sbsentc5||'|'||
                           sbsentc6||'|'||
                           sbsentc7||'|'||
                           sbsentc8||'|'||
                           sbsentc9;


    --- aqui se debe llamar al procedimiento que genera el archivo en excel--
        LDC_EXPORT_REPORT_EXCEL(sbruta, sbNomArch, sbNomHoja, SBSENTENCIA);

        IF sbEmailNoti IS NOT NULL THEN
           FOR item IN cuEmails(sbEmailNoti, ',')
             LOOP
                  pkg_Correo.prcEnviaCorreo
                    ( 
                    isbRemitente        => sbRemitente,
                    isbDestinatarios    => TRIM(item.column_value),
                    isbAsunto           => sb_subject,
                    isbMensaje          => sb_text_msg || chr(10)||' Nombre archivo:'|| sbNomArch ||'.xls, esta ubicado en la ruta: '||sbruta||''
                    );
             
          END LOOP;
        END IF;
exception
  when others then
     null;
END;

end LDC_PKFAPC;
/

