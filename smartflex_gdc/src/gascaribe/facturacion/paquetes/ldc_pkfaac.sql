CREATE OR REPLACE PACKAGE LDC_PKFAAC is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PKFAAC
    Descripcion    : Paquete donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    24/11/2020        horbath           CA291 - Se modifican todas las auditorias (ver documento de entrega)
    23/14/2024        jpinedc           OSF-2580 - Se reemplaza en proGeneraAuditorias
                                        ldc_sendemail por pkg_Correo
    15/07/2024        jsoto             OSF-2846 Se pone en comentario el llamado a LDC_BCCREG_B.pro_grabalog para poder borrar LDC_BCCREG_B
    =========         =========         ====================*/
    

    nuprodu   conssesu.cosssesu%type;
    nupefa    perifact.pefacodi%type;
    nupecs    pericose.pecscons%type;
    nupercons pericose.pecscons%type;
    dtfein    pericose.pecsfeci%type;
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
    consant3 conssesu.cosscoca%type,
    nucarecu conssesu.cossnvec%type,
    consrean conssesu.cosscoca%type,
    consrecu conssesu.cosscoca%type);


  TYPE tbcons IS TABLE OF rccons INDEX BY BINARY_INTEGER;

  tcons tbcons;
  nuIdx BINARY_INTEGER;

  cursor cuConsumos (nupefa perifact.pefacodi%type) is
   select c.cosssesu, c.cossfere, c.cossmecc, c.cosscoca, c.cosscavc, c.cosspecs, c.cossflli, c.cossfufa
     from open.conssesu c
    where c.cosspefa=nupefa
   order by cosssesu, cossfere;

  cursor cuperifact (nucicl perifact.pefacicl%type, nuano perifact.pefaano%type, numes perifact.pefames%type) is
   select pf.pefacodi, pc.pecscons, pc.pecsfeci
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

 cursor cuConsRecu (nupefa perifact.pefacodi%type, nupeco pericose.pecscons%type, dtfein date) is
   select c.cosssesu, c.cossfere, c.cossmecc, c.cosscoca, c.cosscavc, c.cosspefa, c.cosspecs,  c.cossflli, c.cossfufa
  from open.conssesu c
 where (c.cosssesu,c.cosspefa) in
(select distinct c2.cosssesu, c2.cosspefa
     from open.conssesu c2
    where c2.cosspecs<nupeco
      and c2.cossmecc=5
      and c2.cossfere>=dtfein
      and c2.cosssesu in (select distinct c3.cosssesu
                         from conssesu c3
                        where c3.cosspefa=nupefa))
order by cosssesu, cosspefa, cossfere;



function fnuGetDatosConsumo (inuprod conssesu.cosssesu%type,
                             sbDato varchar2) return number;

procedure proGeneraAuditorias (inuano perifact.pefaano%type,
                               inumes perifact.pefaano%type,
                               inucicl perifact.pefaano%type,
                               isbEmail  VARCHAR2);


 FUNCTION FRCGETPERIODOPREV  RETURN constants.tyrefcursor;
 /*******************************************************************************
     Metodo:       FRCGETPERIODOPREV
     Descripcion:  funcion que devuelve valor en N de los periodos con auditoria previas
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion

     Salida             Descripcion

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/
    PROCEDURE  PRPROCEPERIODOPREV(isbperiodo        In Varchar2,
                                  inucurrent   In Number,
                                  inutotal     In Number,
                                  onuerrorcode Out ge_error_log.message_id%Type,
                                  osberrormess Out ge_error_log.description%Type);
     /*******************************************************************************
     Metodo:       PRPROCEPERIODOPREV
     Descripcion:  proceso que apruebas periodos de auditoria previas
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion
       isbperiodo    periodo
       inucurrent    registro actual
       inutotal      total

     Salida             Descripcion
       onuerrorcode     codigo de error
       osberrormess     mensaje de error
     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

 function fnuGetPericoseAnt   (inupefa perifact.pefacodi%type) return number;

 function fnuGetPerifactAnt   (inucicl perifact.pefacicl%type,
                              inuano  perifact.pefaano%type,
                              inumes  perifact.pefames%type,
                              inuperiodos number) return number;

 function fnuGetUltConsValido   (inuprod conssesu.cosssesu%type,
                                inupefa perifact.pefacodi%type) return number;

function fnuGetRegla2020   (inuprod conssesu.cosssesu%type,
                           inupefa perifact.pefacodi%type) return varchar2;

function fnuPerisinFact   (inuprod conssesu.cosssesu%type,
                           inupefa1 perifact.pefacodi%type,
                           inupefa2 perifact.pefacodi%type,
                           inuperiodos number) return number;

function fnuGetCambMedidor   (inuprod conssesu.cosssesu%type,
                              inupefa perifact.pefacodi%type) return varchar2 ;

function fnuHallaPromedio   (inuprod conssesu.cosssesu%type,
                             inupefa perifact.pefacodi%type,
                             inucate servsusc.sesucate%type,
                             inusuca servsusc.sesusuca%type,
                             inuano  perifact.pefaano%type,
                             inumes  perifact.pefames%type) return number ;

function fsbPerisinFact   (inuprod conssesu.cosssesu%type,
                           inupefa1 perifact.pefacodi%type,
                           inupefa2 perifact.pefacodi%type,
                           inuperiodos number) return varchar2 ;

/*******************************************************************************
     Metodo:       fsbPerisinFact
     Descripcion:  Funcion que devuelve el numero de peiodos d econsumo anteriores al actual sin facturarse

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa1     Periodo de facturacion actual para buscar 5 meses hacia atras
      inupefa1     Periodo de facturacion de 5 meses atras para buscar de ahi hacia atras
      inuperiodos  Numero de periodos que debe tener consecutivamente sin facturarse oara salir en la auditoria


      Salida       Descripcion
      nuPerisinFact  Numero de periodos pendiemntes de facturarse

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/
 FUNCTION fnuGetReporteEncabezado(isbNombreApli IN VARCHAR2, isbObservacion IN VARCHAR2)
    return number;

   PROCEDURE prReporteDetalle(
        inuIdReporte    in repoinco.reinrepo%type,
        inuOrden       in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type,
		inuConsecutivo  in number
    );

end LDC_PKFAAC;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKFAAC is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PKFAAC
    Descripcion    : Paquete donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    24/11/2020        horbath           CA291 - Se modifican todas las auditorias (ver documento de entrega)
    =========         =========         ====================*/
   nuConsecutivo NUMBER;
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
 FUNCTION fnuGetReporteEncabezado(isbNombreApli IN VARCHAR2, isbObservacion IN VARCHAR2)
    return number
    IS
      PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRecord Reportes%rowtype;
    BEGIN
    --{
        -- Fill record
        rcRecord.REPOAPLI := isbNombreApli;
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := ut_session.getTerminal;
        rcRecord.REPODESC := isbObservacion;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
         COMMIT;
        return rcRecord.Reponume;
    --}
    END;

    PROCEDURE prReporteDetalle(
        inuIdReporte    in repoinco.reinrepo%type,
        inuOrden       in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type,
		inuConsecutivo  in number
    )
    IS
       PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRepoinco repoinco%rowtype;
    BEGIN
    --{
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuOrden;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := inuConsecutivo;

        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);

        COMMIT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;
----------------------------------------------------------------------
function fnuGetPerifactAnt   (inucicl perifact.pefacicl%type,
                              inuano  perifact.pefaano%type,
                              inumes  perifact.pefames%type,
                              inuperiodos number) return number is
 /*******************************************************************************
     Metodo:       fnuGetPerifactAnt
     Descripcion:  Funcion que halla el periodo de consumo a partir del cual va a revisar si hubo sonsi,os sin facturar
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada        Descripcion
      inucicl:     Ciclo
      inuano       A?o
      inumes       Mes
      inuperiodos  numero de periodos antes del actual para buscar el codigo de perifact y a partir de este codigo el programa busque
                   la cantidad de periodos con consumos sin facturar

     Salida         Descripcion
      nupefacodi    Periodo de facturacion para que se busque de ahi hacia atras la cantidad de periodos con consumos sin facturar

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

nucont     number := 0;
nupefacodi perifact.pefacodi%type;

cursor cuperifact is
select *
  from perifact p1
 where p1.pefacicl = inucicl
   and p1.pefacodi < (select p.pefacodi
                        from perifact p
                       where p.pefacicl=inucicl
                         and p.pefaano=inuano
                         and p.pefames=inumes)
 order by p1.pefacodi desc;

begin
  for rg in cuperifact loop
    nucont := nucont + 1;
    nupefacodi := rg.pefacodi;
    if nucont = inuperiodos then
      exit;
    end if;
  end loop;

  if nucont < inuperiodos then
    nupefacodi := 999;
  end if;


 return nupefacodi;

exception when others then
  return (999);
end fnuGetPerifactAnt;


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
function fsbPerisinFact   (inuprod conssesu.cosssesu%type,
                           inupefa1 perifact.pefacodi%type,
                           inupefa2 perifact.pefacodi%type,
                           inuperiodos number) return varchar2 is

/*******************************************************************************
     Metodo:       fsbPerisinFact
     Descripcion:  Funcion que devuelve el numero de peiodos d econsumo anteriores al actual sin facturarse

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa1     Periodo de facturacion actual para buscar 5 meses hacia atras
      inupefa1     Periodo de facturacion de 5 meses atras para buscar de ahi hacia atras
      inuperiodos  Numero de periodos que debe tener consecutivamente sin facturarse oara salir en la auditoria


      Salida       Descripcion
      nuPerisinFact  Numero de periodos pendiemntes de facturarse

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/


 nusesu servsusc.sesunuse%type;
 nuPerisinFact number;
 sbFechasPerio VARCHAR2(4000);


cursor cuPerisinFact1 is
 SELECT COSSSESU,COUNT(1)
   FROM
    (select COSSSESU,COSSPEFA,SUM(COSSCOCA) CONSUMO
       from conssesu
      where cosssesu = inuprod
        and cosspefa < inupefa1
        and cossmecc = 4
        and cossflli = 'N'
    GROUP BY COSSSESU,COSSPEFA)
 WHERE CONSUMO > 0
 GROUP BY COSSSESU
 HAVING COUNT(1) > inuperiodos;

 cursor cuPerisinFact2 is
 SELECT COSSSESU,COUNT(1)
   FROM
    (select COSSSESU,COSSPEFA,SUM(COSSCOCA) CONSUMO
       from conssesu
      where cosssesu = inuprod
        and cosspefa < inupefa2
        and cossmecc = 4
        and cossflli = 'N'
    GROUP BY COSSSESU,COSSPEFA)
 WHERE CONSUMO > 0
 GROUP BY COSSSESU
 HAVING COUNT(1) > 0;

 CURSOR CUGETFECHASPERIO IS
 SELECT min_periodo||' al '||max_perio periodo
  from (SELECT  min(pefaano||TRIM(to_char(pefames, '09'))) min_periodo, max(pefaano||TRIM(to_char(pefames, '09'))) max_perio
   FROM
	( select COSSSESU,COSSPEFA,SUM(COSSCOCA) CONSUMO
	  from conssesu
	  where cosssesu = inuprod
		and cosspefa < inupefa1
		and cossmecc = 4
		and cossflli = 'N'
	   GROUP BY COSSSESU,COSSPEFA) C, perifact p1
	where pefacodi = COSSPEFA
		AND CONSUMO > 0);


begin
  open cuPerisinFact1;
  fetch cuPerisinFact1  into nusesu, nuPerisinFact;
  if cuPerisinFact1%notfound then
    nuPerisinFact := 0;
  end if;
  close cuPerisinFact1;

  if nvl(nuPerisinFact,0) > inuperiodos then
     nuPerisinFact := nvl(nuPerisinFact,0);

  else
    open cuPerisinFact2;
    fetch cuPerisinFact2  into nusesu, nuPerisinFact;
    if cuPerisinFact2%notfound then
      nuPerisinFact := 0;
    end if;
    close cuPerisinFact2;

    if nvl(nuPerisinFact,0) > 0 then
      nuPerisinFact := nvl(nuPerisinFact,0);

    end if;
  end if;
  if nvl(nuPerisinFact,0) > 0 then
	  open CUGETFECHASPERIO;
	  fetch CUGETFECHASPERIO into sbFechasPerio;
	  close CUGETFECHASPERIO;
  else
      sbFechasPerio := 'Sin periodos';
  end if;

  return sbFechasPerio;

exception when others then
  return ('');
end fsbPerisinFact;

-----------------------------------------------------------------------
function fnuPerisinFact   (inuprod conssesu.cosssesu%type,
                           inupefa1 perifact.pefacodi%type,
                           inupefa2 perifact.pefacodi%type,
                           inuperiodos number) return number is

/*******************************************************************************
     Metodo:       fnuPerisinFact
     Descripcion:  Funcion que devuelve el numero de peiodos d econsumo anteriores al actual sin facturarse

     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:       291

     Entrada       Descripcion
      inuprod:     Producto
      inupefa1     Periodo de facturacion actual para buscar 5 meses hacia atras
      inupefa1     Periodo de facturacion de 5 meses atras para buscar de ahi hacia atras
      inuperiodos  Numero de periodos que debe tener consecutivamente sin facturarse oara salir en la auditoria


      Salida       Descripcion
      nuPerisinFact  Numero de periodos pendiemntes de facturarse

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/


 nusesu servsusc.sesunuse%type;
 nuPerisinFact number;

cursor cuPerisinFact1 is
 SELECT COSSSESU,COUNT(1)
   FROM
    (select COSSSESU,COSSPEFA,SUM(COSSCOCA) CONSUMO
       from conssesu
      where cosssesu = inuprod
        and cosspefa < inupefa1
        and cossmecc = 4
        and cossflli = 'N'
    GROUP BY COSSSESU,COSSPEFA)
 WHERE CONSUMO > 0
 GROUP BY COSSSESU
 HAVING COUNT(1) > inuperiodos;

 cursor cuPerisinFact2 is
 SELECT COSSSESU,COUNT(1)
   FROM
    (select COSSSESU,COSSPEFA,SUM(COSSCOCA) CONSUMO
       from conssesu
      where cosssesu = inuprod
        and cosspefa < inupefa2
        and cossmecc = 4
        and cossflli = 'N'
    GROUP BY COSSSESU,COSSPEFA)
 WHERE CONSUMO > 0
 GROUP BY COSSSESU
 HAVING COUNT(1) > 0;

begin
  open cuPerisinFact1;
  fetch cuPerisinFact1  into nusesu, nuPerisinFact;
  if cuPerisinFact1%notfound then
    nuPerisinFact := 0;
  end if;
  close cuPerisinFact1;

  if nvl(nuPerisinFact,0) > inuperiodos then
     nuPerisinFact := nvl(nuPerisinFact,0);
  else
    open cuPerisinFact2;
    fetch cuPerisinFact2  into nusesu, nuPerisinFact;
    if cuPerisinFact2%notfound then
      nuPerisinFact := 0;
    end if;
    close cuPerisinFact2;

    if nvl(nuPerisinFact,0) > 0 then
      nuPerisinFact := nvl(nuPerisinFact,0);
    end if;
  end if;

  return nuPerisinFact;

exception when others then
  return (0);
end fnuPerisinFact;

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
      inuano       A?o
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
    and c.cpscubge = DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(inuprod, null)
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

     elsif sbDato = 'CONSRECU' then
       nuResul := tcons(inuprod).consrecu;

     elsif sbDato = 'NRPERECU' then
       nuResul := tcons(inuprod).nucarecu;

     elsif sbDato = 'CONSREAN' then
       nuResul := tcons(inuprod).consrean;

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

procedure proGeneraAuditorias (inuano perifact.pefaano%type,
                               inumes perifact.pefaano%type,
                               inucicl perifact.pefaano%type,
                               isbEmail  VARCHAR2) is

/*
    Historia de Modificaciones
    Fecha             Autor             Modificacion
     24/11/2020        horbath         CA291 - Se modifican todas las auditorias (ver documento de entrega)
*/

    sbMensError    VARCHAR2(4000);  --Ticket 200-1892  ELAL -- se almacena error generado

    nuAno          NUMBER := inuano;
    nuMes          NUMBER := inumes;
    nuCiclo        NUMBER := inucicl;
    sbEmail        VARCHAR2(2000) := isbEmail ;

    nuconsprom number;
    nuconsulti number;
    NUPORCENT number;
    sbmenslogcr VARCHAR2(2000);

    nuconsudifelect number := 0;
    nuconsuestimado number := 0;
    nuconsucorregid number := 0;
    nuconsurecupera number := 0;

    nuPorcPromResi     ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PORC_CONS_RECU_RESI_LDCPKFAAC', NULL); --ca291
    nuPorcPromCome     ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PORC_CONS_RECU_COME_LDCPKFAAC', NULL); --ca291
    nuNumeConsProm     ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('NUME_CONS_RECU_LDCPKFAAC', NULL); --ca291
    nuConsMaxResi      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PRECARGOS_CONS_RESIDENCIAL', NULL); --ca291
    nuConsMaxCome      ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PRECARGOS_CONS_COMERCIAL', NULL); -- ca291
    nuMesesSinFact     ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('MESES_CONS_PEND_SIN_FAC', NULL); -- ca291

    nuPerifactAnte     number := 0;


    --Ticket 200-1892  ELAL -- se consulta verificacion presion
   CURSOR cuVeriPres IS
    SELECT sesunuse PRODUCTO,
       DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(PR.ADDRESS_ID, null)) DEPARTAMENTO,
       DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(PR.ADDRESS_ID, null) LOCALIDAD,
       sesucate CATEGORIA,
       ciclcodi CICLO,
       pefacodi PERIODO,
       sesuesco || ' - ' || decode(sesuesco,  null,  null, open.pktblestacort.fsbgetdescription(sesuesco)) ESTADO_CORTE,
       pefaano ANO,
       pefames MES,
       vvfcvalo PRESION_actual,
       (SELECT vava.vvfcvalo
          FROM open.cm_vavafaco vava, open.perifact pefa
         WHERE vava.vvfcfeiv between pefa.pefafimo AND pefa.pefaffmo
           AND pefa.pefames = decode(p.pefames, 1, 12, p.pefames - 1)
           AND pefa.pefaano = decode(p.pefames, 1, p.pefaano - 1, p.pefaano)
           AND pefa.pefacicl = sesucicl
           AND vava.vvfcsesu = s.sesunuse
           AND vava.vvfcfeiv =
               (SELECT max(va2.vvfcfeiv)
                  FROM open.cm_vavafaco va2, open.perifact pefa2
                 WHERE va2.vvfcfeiv between pefa2.pefafimo AND pefa2.pefaffmo
                   AND pefa2.pefames =
                       decode(p.pefames, 1, 12, p.pefames - 1)
                   AND pefa2.pefaano =
                       decode(p.pefames, 1, p.pefaano - 1, p.pefaano)
                   AND pefa2.pefacicl = pefa.pefacicl
                   AND va2.vvfcsesu = vava.vvfcsesu)
           and rownum < 2) presion_ant,

       (SELECT fccofaco
          FROM open.conssesu, open.cm_facocoss
         WHERE cosssesu = sesunuse
           AND cosspefa = pefacodi
           AND cossmecc = 1
           AND cossfcco = fccocons
           AND rownum = 1) FACTOR_CORRECCION_actual,

       (SELECT fccofaco
          FROM open.conssesu, open.cm_facocoss
         WHERE cosssesu = sesunuse
           AND cosspefa =
               open.pkbillingperiodmgr.fnugetperiodprevious(pefacodi)
           AND cossmecc = 1
           AND cossfcco = fccocons
           AND rownum = 1) FACTOR_CORRECCION_anterior,
        sesusuca SUBCATEGORIA,
        'No tiene presion definida propia' OBSERVACION
  FROM open.servsusc s
 INNER JOIN PR_PRODUCT PR ON (PR.PRODUCT_ID = SESUNUSE)
 INNER JOIN open.ciclo  ON (sesucicl = ciclcodi)
 INNER JOIN open.perifact p ON (ciclcodi = pefacicl)
--LEFT OUTER JOIN open.cm_vavafaco ON (vvfcsesu = sesunuse AND vvfcfeiv between pefafimo AND pefaffmo)
  LEFT OUTER JOIN open.cm_vavafaco ON (vvfcsesu = sesunuse AND pefafimo between vvfcfeiv AND vvfcfefv)
 WHERE ((sesucate = 2 AND sesusuca = 2) or (sesucate = 3 and sesusuca = 1))
   AND pefaano = nuAno --2013
   AND pefames = nuMes--3
   AND ciclcodi = nuCiclo
   AND SESUSERV = 7014
   -- AND     SESUESCO IN (1, ...)
   AND SESUCICL NOT IN (SELECT PECSCICO FROM OPEN.LDC_CM_LECTESP_CICL)
   AND vvfcvalo IS NULL

UNION

select S.sesunuse PRODUCTO,
       DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(PR.ADDRESS_ID,null), null) DEPARTAMENTO,
       DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(PR.ADDRESS_ID, null) LOCALIDAD,
       sesucate CATEGORIA,
       ciclcodi CICLO,
       P.pefacodi PERIODO,
       sesuesco || ' - ' || decode(sesuesco, null, null, open.pktblestacort.fsbgetdescription(sesuesco)) ESTADO_CORTE,
       pefaano ANO,
       pefames MES,
       LS.PRESFIN PRESION_actual,
       (SELECT LPA.PRESFIN
          FROM open.LDC_CM_LECTESP_CRIT LPA
         WHERE LPA.SESUNUSE = S.SESUNUSE
           AND LPA.PEFACODI =
               open.pkbillingperiodmgr.fnugetperiodprevious(P.pefacodi)) presion_ant,

       (SELECT fccofaco
          FROM open.conssesu, open.cm_facocoss
         WHERE cosssesu = S.sesunuse
           AND cosspefa = P.pefacodi
           AND cossmecc = 1
           AND cossfcco = fccocons
           AND rownum = 1) FACTOR_CORRECCION_actual,

       (SELECT fccofaco
          FROM open.conssesu, open.cm_facocoss
         WHERE cosssesu = S.sesunuse
           AND cosspefa =
               open.pkbillingperiodmgr.fnugetperiodprevious(P.pefacodi)
           AND cossmecc = 1
           AND cossfcco = fccocons
           AND rownum = 1) FACTOR_CORRECCION_anterior,
           sesusuca SUBCATEGORIA,
        'No tiene presion definida propia' OBSERVACION
--FROM OPEN.LDC_CM_LECTESP ls, OPEN.SERVSUSC s, OPEN.CICLO c, open.perifact p
  FROM open.servsusc s
 INNER JOIN PR_PRODUCT PR ON (PR.PRODUCT_ID = SESUNUSE)
 INNER JOIN open.ciclo ON (sesucicl = ciclcodi)
 INNER JOIN open.perifact p ON (ciclcodi = pefacicl)
  LEFT OUTER JOIN open.LDC_CM_LECTESP_CRIT LS ON (ls.sesunuse = S.sesunuse AND p.PEFACODI = ls.PEFACODI)

 WHERE ((sesucate = 2 AND sesusuca = 2) or (sesucate = 3 and sesusuca = 1))
   AND pefaano =  nuAno --2013
   AND pefames = nuMes--3
   AND ciclcodi = nuCiclo
   AND SESUSERV = 7014
      -- AND     SESUESCO IN (1, ...)
   AND SESUCICL IN (SELECT PECSCICO FROM OPEN.LDC_CM_LECTESP_CICL)
   AND LS.PRESFIN IS NULL;


    TYPE tbVeriPres IS TABLE OF cuVeriPres%ROWTYPE  ;
    v_tbVeriPres tbVeriPres;

------ajuste consumo promedio ----------------------------------------------------------------------------
    CURSOR cuAjusteCons IS
    SELECT PRODUCTO,  pefacicl, cosspecs, LECTURA_ANTERIOR, FECHA_LECTURA,  ESTADO_CORTE,  LECTURA_ACTUAL, CONSUMO_ACTUAL,
           CONS_ANTERIOR, CONSUMO_PROMEDIO, CONSUMO_RECUPERADO, NRO_CONS_PROM, METODO_CONSUMO, CONS_RECU_ANT, pefaano, pefames
     FROM (
      SELECT /*+ INDEX(s IX_SERVSUSC18) */ s.sesunuse PRODUCTO,
        pefacicl,
        cosspecs, SESUCATE,
            lectelme.leemlean LECTURA_ANTERIOR,
            lectelme.leemfele FECHA_LECTURA,
            open.pktblestacort.fsbgetdescription(sesuesco) ESTADO_CORTE,
            lectelme.leemleto LECTURA_ACTUAL,
            consumo.cosscoca CONSUMO_ACTUAL,

            fnuGetDatosConsumo(sesunuse,'CONSANT1')  CONS_ANTERIOR,

            fnuHallaPromedio (sesunuse, pefacodi, sesucate, sesusuca, pefaano, pefames) CONSUMO_PROMEDIO,

            fnuGetDatosConsumo(sesunuse,'CONSRECU') CONSUMO_RECUPERADO,

            --consumo.cossnvec NRO_CONS_PROM
            fnuGetDatosConsumo(sesunuse,'NRPERECU') NRO_CONS_PROM,

            cossmecc METODO_CONSUMO,

            fnuGetDatosConsumo(sesunuse,'CONSREAN') CONS_RECU_ANT,

              pefaano,
              pefames
    FROM    open.servsusc s,/* open.suscripc, open.ciclo,*/ open.perifact, open.lectelme,
            open.conssesu consumo
    WHERE   sesucicl = pefacicl
        AND sesuserv = 7014
        AND sesunuse = leemsesu
        AND     pefaano = nuAno
        AND     pefames = nuMes
        AND     pefacicl = nuCiclo
        AND     pefacodi = leempefa
        AND     cosssesu = sesunuse
        AND     cosspefa = pefacodi
        AND     cossmecc = 1
        AND     cossfere = (select max(co.cossfere) FROM open.conssesu co WHERE co.cosssesu = sesunuse AND co.cosspefa = pefacodi)
        AND     leemclec = 'F')
      /*  WHERE CONS_RECU_ANT < 0 OR CONS_RECU_ANT > OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CANTCONS_VAL', NULL);*/
    WHERE (NRO_CONS_PROM > nuNumeConsProm)
       OR (NRO_CONS_PROM * CONSUMO_PROMEDIO * 100 / ( case when nvl(CONSUMO_RECUPERADO,0) =  0 then 100 else CONSUMO_RECUPERADO end ) > DECODE(SESUCATE,1,nuPorcPromResi,nuPorcPromCome));



    TYPE tbAjusteCons IS TABLE OF cuAjusteCons%ROWTYPE  ;
    v_tbAjusteCons tbAjusteCons;


------lecturas menores ------------------------------------------------------------------------------------
    CURSOR cuLectMeno IS
    SELECT PRODUCTO, CICLO, pefacodi, LECTURA_ACTUAL, FECHA_LECTURA, LECTURA_ANTERIOR, METODO_CONSUMO, CONSUMO_ACTUAL, CONSUMO_PROMEDIO,
           regla, pefaano, pefames, SESUCATE, ULTCONSU,
           case when NVL(CONSUMO_PROMEDIO,0) = 0 then 100 else CONSUMO_PROMEDIO end CONSUMO_PROMEDIO_FORMULA,
           case when NVL(ultconsu,0) = 0 then 100 else ultconsu end ULTCONSU_FORMULA
    from (

	SELECT PRODUCTO, CICLO, pefacodi, LECTURA_ACTUAL, FECHA_LECTURA, LECTURA_ANTERIOR, METODO_CONSUMO, CONSUMO_ACTUAL, CONSUMO_PROMEDIO,
           regla, pefaano, pefames, SESUCATE, ultconsu

    FROM (SELECT
                    servsusc.sesunuse PRODUCTO, SESUCATE,
            servsusc.sesucicl CICLO,
                    pefacodi,
                    lectelme.leemleto LECTURA_ACTUAL,
             lectelme.leemfele FECHA_LECTURA,
                    decode(leemoble,76,open.LDC_ReportesConsulta.fnuGetLastRead(pefacodi,sesunuse),leemlean) LECTURA_ANTERIOR,
                    conssesu.cossmecc||' - '||decode(cossmecc,null,null,open.pktblmecacons.fsbgetdescription(cossmecc)) METODO_CONSUMO,
                    conssesu.cosscoca CONSUMO_ACTUAL,
                    /*hicoprpm.hcppcopr CONSUMO_PROMEDIO*/
                  /*case
                  when leempecs is not null then
                  ( SELECT h2.hcppcopr
                  FROM   open.hicoprpm h2
                  WHERE  h2.hcpppeco = fnuObtPerConsAnte(sesunuse,leempecs)
                  AND    h2.hcppsesu = sesunuse
                  and rownum < 2)
                  else null end CONSUMO_PROMEDIO,*/
                  fnuHallaPromedio (sesunuse, pefacodi, sesucate, sesusuca, pefaano, pefames) CONSUMO_PROMEDIO,
          COSSCAVC regla,
                  pefaano,
                  pefames,
				  fnuGetUltConsValido(sesunuse, PEFACODI) ultconsu

            FROM    open.servsusc,/* open.suscripc, open.ciclo,*/ open.perifact pefa, open.lectelme,
                    open.conssesu/*, open.hicoprpm*/
            WHERE   sesucicl = pefacicl
              AND   sesuserv = 7014
              AND    sesunuse = leemsesu
              AND     pefaano = nuAno
              AND     pefames = nuMes
              AND     pefacicl = nuCiclo
              AND     pefacodi = leempefa
              AND     cosssesu = sesunuse
              AND     cosspefa = pefacodi
              AND     cossmecc = 1
              /*AND     hcppsesu = sesunuse
              AND     cosspecs = hcpppeco*/
              AND     cossfere = (select max(co.cossfere) FROM open.conssesu co WHERE co.cosssesu = sesunuse AND co.cosspefa = pefacodi)
             AND     leemclec = 'F'
            )
    WHERE   lectura_Actual < lectura_anterior
      AND   fnuGetRegla2020(PRODUCTO, PEFACODI) = 'N'
      AND   fnuGetCambMedidor(PRODUCTO, PEFACODI) = 'N')
      /*where  ( ( (CONSUMO_ACTUAL * 100 / (case when nvl(CONSUMO_PROMEDIO,0) = 0 then 100 else CONSUMO_PROMEDIO end )  ) >  DECODE(SESUCATE,1,nuPorcPromResi,nuPorcPromCome)) OR
              ((CONSUMO_ACTUAL * 100 / ( case when nvl(ultconsu,0) = 0 then 100 else ultconsu end) )  >  DECODE(SESUCATE,1,nuPorcPromResi,nuPorcPromCome)))*/ ;


    TYPE tbLectMeno IS TABLE OF cuLectMeno%ROWTYPE  ;
    v_tbLectMeno tbLectMeno;

    --SE consulta los consumos altos -------------------------------------------------------------------------------------------------
    CURSOR cuConsAltos IS
    SELECT  PRODUCTO, CICLO, LECTURA_ACTUAL, LECTURA_ANTERIOR, CATEGORIA, SUBCATEGORIA, ESTADO_FINANCIERO, CONSUMO_ANTERIOR,
            CONSUMO_PROMEDIO, CONSUMO_ACTUAL, METODO_CONSUMO, CONSUMO_ANTERIOR_2, CONSUMO_ANTERIOR_3, regla, PEFAANO, PEFAMES
    FROM
    (SELECT   sel1.PRODUCTO,
    sel1.CICLO,
    sel1.LECTURA_ACTUAL,
    sel1.LECTURA_ANTERIOR,
    sel1.CATEGORIA,
    sel1.SUBCATEGORIA,
    sel1.ESTADO_FINANCIERO,

    fnuGetDatosConsumo(PRODUCTO,'CONSANT1') CONSUMO_ANTERIOR,
    sel1.CONSUMO_PROMEDIO,
    sel1.CONSUMO_ACTUAL,
    sel1.METODO_CONSUMO,

    fnuGetDatosConsumo(PRODUCTO,'CONSANT2')  CONSUMO_ANTERIOR_2,
    fnuGetDatosConsumo(PRODUCTO,'CONSANT3')  CONSUMO_ANTERIOR_3,

   regla, PEFAANO, PEFAMES, PERIODO
    FROM
        (SELECT
                pefacodi PERIODO,
                servsusc.sesucicl CICLO,
                servsusc.sesunuse PRODUCTO,
                lectelme.leemfele FECHA_LECTURA,
                servsusc.sesucate CATEGORIA,
                servsusc.sesusuca SUBCATEGORIA,
                decode(servsusc.sesuesfn,'A','A - AL DIA',
                                         'D','D - CON DEUDA',
                                         'C','C - CASTIGADO',
                                         'M','M - MORA') ESTADO_FINANCIERO,
                lectelme.leemleto LECTURA_ACTUAL,
                lectelme.leemlean LECTURA_ANTERIOR,
                --hicoprpm.hcppcopr CONSUMO_PROMEDIO,
                /*case
                  when leempecs is not null then
                  ( SELECT hcppcopr
                  FROM   open.hicoprpm
                  WHERE  hcpppeco = fnuObtPerConsAnte(sesunuse,leempecs)
                  AND    hcppsesu = sesunuse
                  and rownum < 2)
                  else null end CONSUMO_PROMEDIO,*/
                  fnuHallaPromedio (sesunuse, pefacodi, sesucate, sesusuca, pefaano, pefames) CONSUMO_PROMEDIO,

                  fnuGetDatosConsumo(sesunuse,'CONSACTU')   consumo_actual,

                fnuGetDatosConsumo(sesunuse,'COSSMECC') metodo_consumo,
                fnuGetDatosConsumo(sesunuse,'COSSCAVC') regla,

            PEFAANO, PEFAMES, fnuGetUltConsValido(sesunuse, PEFACODI) ultconsu

      FROM    open.servsusc,/* open.suscripc, open.ciclo,*/ open.perifact, open.lectelme
      WHERE pefacicl = sesucicl
         AND sesuserv = 7014
         AND sesunuse = leemsesu
      --  AND     sesususc = susccodi
      --  AND     sesucicl = ciclcodi
          AND     pefaano = nuAno
          AND     pefames = nuMes
          AND     pefacicl =nuCiclo
          AND     pefacodi = leempefa
        --AND     hcppsesu = sesunuse
          AND     leemclec = 'F'
        --AND     leempecs = hcpppeco
        GROUP BY sesucicl,sesunuse,leemfele,sesucate,sesusuca,sesuesfn,sesuesfn,leemleto,
                 leemlean,leempecs/*hcppcopr*/,pefacodi,  PEFAANO, PEFAMES) sel1
    WHERE   CONSUMO_ACTUAL > DECODE(CATEGORIA,1,nuConsMaxResi,nuConsMaxCome)
      AND   (( (CONSUMO_ACTUAL * 100 / ( case when nvl(CONSUMO_PROMEDIO,0) = 0 then 100 else CONSUMO_PROMEDIO end) ) >  DECODE(CATEGORIA,1,nuPorcPromResi,nuPorcPromCome)) OR
              ((CONSUMO_ACTUAL * 100 / ( case when nvl(ultconsu,0) =  0 then 100 else ultconsu end ))  >  DECODE(CATEGORIA,1,nuPorcPromResi,nuPorcPromCome)) )
      AND   ( (fnuGetRegla2020(PRODUCTO, PERIODO) = 'N')  OR (fnuGetRegla2020(PRODUCTO, PERIODO) = 'S' AND fnuGetCambMedidor(PRODUCTO, PERIODO) = 'S') )
      );

    TYPE tbConsAltos IS TABLE OF cuConsAltos%ROWTYPE  ;

    v_tbConsAltos tbConsAltos;


    --se consultan los planes errados
    CURSOR cuPlanErra IS
    SELECT  servsusc.sesunuse PRODUCTO,
            servsusc.sesucicl CICLO,
            servsusc.sesuplfa PLAN,
            servsusc.sesucate CATEGORIA,
            servsusc.sesusuca SUBCATEGORIA,
           servsusc.sesufein FECHA_REGISTRO_PRODUCTO,
           nuAno,
           nuMes
    FROM    open.servsusc, open.pr_product
    WHERE   sesuserv = 7014
      AND   product_id = sesunuse
      and sesuesco not in  ( SELECT to_number(column_value)
                                    FROM TABLE(open.ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTACORTE_EXCL', NULL),',')))
      AND     sesunuse not in
        (SELECT
                servsusc.sesunuse PRODUCTO

        FROM    open.cc_commercial_plan, open.cc_commercial_segm,
                open.cc_com_seg_plan, open.cc_com_seg_fea_val, open.pr_product

        WHERE   sesunuse = pr_product.product_id
        AND     pr_product.commercial_plan_id = cc_commercial_plan.commercial_plan_id
        AND     cc_commercial_plan.commercial_plan_id = cc_com_seg_plan.commercial_plan_id
        AND     cc_com_seg_plan.commercial_segm_id = cc_commercial_segm.commercial_segm_id
        AND     cc_commercial_segm.commercial_segm_id = cc_com_seg_fea_val.commercial_segm_id
        AND     (sesusuca = nvl(cc_com_seg_fea_val.geog_subcategory_id,sesusuca)
        And sesucate = cc_com_seg_fea_val.geog_category_id)
        )
    AND sesucicl = nuCiclo;


    TYPE tbPlanErra IS TABLE OF cuPlanErra%ROWTYPE  ;

    v_tbPlanErra   tbPlanErra;

  --se consultan productos con est de corte facturable que tienen suscnupr != 0 o
  -- que estan en un ciclo diferente al de su contrato
  CURSOR cuProdNoFgca IS
    select sesunuse,nuAno,nuMes,nuCiclo,'Suscnupr del Contrato ' || sesususc || ' es ' || suscnupr Observacion
      from open.servsusc, open.suscripc
     where sesususc=susccodi
       and sesucicl = nuCiclo
       and sesuesco in (1,2,3,4,6,91,93,99)
       and suscnupr != 0
   union
     select sesunuse,nuAno,nuMes,nuCiclo, 'Ciclo del Contrato ' || sesususc || ' es ' || susccicl Observacion
       from open.servsusc, open.suscripc
      where sesususc=susccodi
      and sesucicl = nuCiclo
      and susccicl!=nuCiclo
      and sesuesco in (1,2,3,4,6,91,93,99);

    TYPE tbPrNoFgca IS TABLE OF cuProdNoFgca%ROWTYPE  ;
    v_tbPrNoFgca   tbPrNoFgca;

  --se consultan USUARIOS POR CATEGORIA (CA291)
  cursor cuUsuporCate is
    SELECT  nuAno,nuMes,nuCiclo,decode(c.coecfact,'S','FACTURABLE','NO FACTURABLE') tipo,
            SESUESCO,
            /*(SELECT ESCODESC FROM ESTACORT WHERE ESCOCODI = SESUESCO) DESC_ESTCORTE,*/
            sesucate CATEGORIA,
            sesusuca SUBCATEGORIA,
            count(sesunuse) CANTIDAD
      FROM    open.servsusc, confesco c
     WHERE   sesuserv = 7014
       and     sesuesco = c.coeccodi
       AND   sesucicl = nuCiclo
       and c.coecserv = 7014
       AND SESUESFN <> 'C'
GROUP BY coecfact,SESUESCO,sesucate,sesusuca
order by coecfact,SESUESCO,sesucate,sesusuca;

 TYPE tbUsuxCate IS TABLE OF cuUsuporCate%ROWTYPE;
 v_tbUsuxCate   tbUsuxCate;

sbTipoTrabVal VARCHAR2(4000) := OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRCAME_VALI', NULL);
 --se consultan ORDENES PENDIENTES (CA291)
  cursor cuOrdenesPend is
   SELECT inuano nuano, inumes numes, inucicl nuciclo, suscripc.susccodi CONTRATO,
        orac.task_type_id TIPO_TRABAJO,
        ord.order_status_id ESTADO_ORDEN,
        ord.operating_unit_id unidad_operativa
   FROM    open.suscripc, open.or_order_activity orac, open.or_order ord
  WHERE   orac.subscription_id = susccodi
    AND     orac.order_id = ord.order_id
    AND     ord.order_Status_id not in (8,12)
    AND     orac.task_type_id in ( SELECT to_number(column_value)
                                 FROM TABLE(open.ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRCAME_VALI', NULL),','))
                                 )
AND     susccicl = nuCiclo;

TYPE tbOrdenesPend IS TABLE OF cuOrdenesPend%ROWTYPE;
 v_tbOrdenesPend  tbOrdenesPend;

--se consultan Contratos con Consumos Pendientes por facturar (CA291)
  cursor cuContConsPend is
  SELECT  nuano, numes, nuciclo, CONTRATO, nroperiodos, sesuesco, product_status_id,periodos
  FROM
   (SELECT  nuano, numes, nuciclo, sesususc CONTRATO,
          fnuPerisinFact (sesunuse, pefacodi, nuPerifactAnte, nuMesesSinFact) nroperiodos,
		  sesuesco, product_status_id,
		  fsbPerisinFact(sesunuse, pefacodi, nuPerifactAnte, nuMesesSinFact) periodos
     from perifact, servsusc, pr_product
    where sesuserv=7014
      and sesucicl=pefacicl
      and pefacicl=nuciclo
      and pefaano=nuano
	  and product_id = sesunuse
      and pefames=numes)
  WHERE nroperiodos > 0;

 TYPE tbContConsPend IS TABLE OF cuContConsPend%ROWTYPE;
 v_tbContConsPend   tbContConsPend;

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
    sbDato     VARCHAR2(1);

    refCursor constants.tyrefcursor;
   nuIdReporte NUMBER;


  ex_dml_errors EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_dml_errors, -24381);
  nuerror NUMBER;
  sberror VARCHAR2(4000);
  nuProducto NUMBER;
  sbRemitente   ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
 BEGIN

    pkerrors.Push('LDC_PKFAAC'); --Ticket 200-1892  ELAL -- Se inicia proceso de log de error

    SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER
      INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;

    ldc_proinsertaestaprog(nuparano,nuparmes,'LDCFAAC-'|| nuCiclo,'En ejecucion',nutsess,sbparuser);

    DELETE FROM LDC_VERIPRES WHERE VEPRANO = nuAno AND VEPRMES = nuMes AND VEPRCICL = nuCiclo;
    DELETE FROM LDC_AJUSCOPR  WHERE AJCPANO = nuAno AND AJCPMES = nuMes AND AJCPCICL = nuCiclo;
    DELETE FROM LDC_LECTMENO  WHERE LEMEANO = nuAno AND LEMEMES = nuMes AND LEMECICL = nuCiclo;
    DELETE FROM LDC_CONSALTO  WHERE COALANO = nuAno AND COALMES = nuMes AND COALCICL = nuCiclo;
    DELETE FROM LDC_VAPLANERR  WHERE PLERANO = nuAno AND PLERMES = nuMes AND PLERCICL = nuCiclo;
    DELETE FROM LDC_PRNOFGCA  WHERE  ANO = nuAno AND MES = nuMes AND CICLO = nuCiclo;
    DELETE FROM LDC_CONSNOFA  WHERE  ANO = nuAno AND MES = nuMes AND CICLO = nuCiclo;
    DELETE FROM LDC_ORPECAME  WHERE  ANO = nuAno AND MES = nuMes AND CICLO = nuCiclo;
    DELETE FROM LDC_VERUSCATE  WHERE  ANO = nuAno AND MES = nuMes AND CICLO = nuCiclo;

    COMMIT;

    tcons.delete;

	 nuIdReporte := fnuGetReporteEncabezado('AUDIPREVI', 'INCONSISTENCIAS PROCESO DE AUDITORIAS PREVIAS');

    -- se halla periodo desde el cual buscar consumos sin facturar
    nuPerifactAnte := fnuGetPerifactAnt (inucicl, inuano, inumes, nuMesesSinFact);
    -- halla codigo del periodo
    open cuperifact (nuCiclo, nuano, numes);
    fetch cuperifact into nupefa, nupecs, dtfein;
    if cuperifact%notfound then
      nupefa := -1;
      nupecs := -1;
    end if;
    close cuperifact;

   -- ingresa en la tabla consumo y fechas para cada producto
    nuprodu := -1;
    numecc  := null;
    nucavc  := null;
    nuconsu := 0;

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

        tcons(nuIdx).nucarecu := null;
        tcons(nuIdx).consrean := null;
        tcons(nuIdx).consrecu := null;

        nuprodu := rg.cosssesu;
        numecc := null;
        nucavc := null;
        nuconsu := 0;
      end if;

      if rg.cossmecc = 4 then              -- AND FLLI = 'S' ?
        nuconsu := nuconsu + rg.cosscoca;
      end if;

      if rg.cossmecc = 1 then  -- SOLO PARA MECC = 1?
        nucavc := rg.cosscavc;
      end if;

      if rg.cossmecc /*!= 4*/ in (1,3) then
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
    tcons(nuIdx).nucarecu := null;
    tcons(nuIdx).consrean := null;
    tcons(nuIdx).consrecu := null;


-- halla consumos recuperados
    nuprodu := -1;
    nupercons  := -1;
    numecc := null;
    nuconsu := 0;
    nucantrecu := 0;
    nuconsrecu := 0;
    nuconsrean := 0;
  for rg in cuConsRecu (nupefa,nupecs, dtfein) loop
      if nuprodu = -1 then
         nuprodu := rg.cosssesu;
         nupercons  := rg.cosspecs;
      end if;

      if nuprodu != rg.cosssesu then
        nuIdx := nuprodu;
        tcons(nuIdx).nucarecu := nucantrecu;
        tcons(nuIdx).consrean := nuconsrean;
        tcons(nuIdx).consrecu := nuconsrecu;

        nuprodu := rg.cosssesu;
        nupercons  := rg.cosspecs;
        nuconsu := 0;
        numecc := null;
        nucantrecu := 0;
        nuconsrecu := 0;
        nuconsrean := 0;

        nuconsudifelect  := 0;
        nuconsuestimado  := 0;
        nuconsucorregid  := 0;
        nuconsurecupera  := 0;
      end if;

      if nupercons != rg.cosspecs then
         if numecc = 5 then
           nucantrecu := nucantrecu + 1;
           nuconsrecu := nuconsrecu + nuconsu;
           if nupercons = nvl(fnuObtPerConsAnte(nuprodu,nupecs),-1) then
             nuconsrean := nuconsu;
           end if;
         end if;
          nuconsu := 0;
          nupercons  := rg.cosspecs;
      end if;

      if rg.cossmecc = 4 then
        nuconsu := nuconsu + rg.cosscoca;
      else
        numecc := rg.cossmecc;
        if rg.cossmecc = 1 then
          nuconsudifelect := nuconsudifelect + rg.cosscoca;
        elsif rg.cossmecc = 2 then
          nuconsucorregid := nuconsucorregid + rg.cosscoca;
        elsif rg.cossmecc = 3 then
          nuconsuestimado := nuconsuestimado + rg.cosscoca;
        elsif rg.cossmecc = 5 then
          nuconsurecupera := nuconsurecupera + rg.cosscoca;
        end if;
      end if;

   end loop;


    -- ingresa el ultimo producto
    nuIdx := nuprodu;
    tcons(nuIdx).nucarecu := nucantrecu;
    tcons(nuIdx).consrean := nuconsrean;
    tcons(nuIdx).consrecu := nuconsrecu;

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

   /* nuIdx := tcons.first;
    dbms_output.put_line('nucant1 ' || nucant1);
    dbms_output.put_line('nucant2 ' || nucant2);
    dbms_output.put_line('nuprodu ' || nuIdx);
    dbms_output.put_line('nuconsu ' || tcons(nuIdx).consumo);
    dbms_output.put_line('cossmecc ' || tcons(nuIdx).cossmecc);
    dbms_output.put_line('cosscavc ' || tcons(nuIdx).cosscavc);
    dbms_output.put_line('consant1 ' || tcons(nuIdx).consant1);
    dbms_output.put_line('consant2 ' || tcons(nuIdx).consant2);
    dbms_output.put_line('consant3 ' || tcons(nuIdx).consant3);
    dbms_output.put_line('nucarecu ' || tcons(nuIdx).nucarecu);
    dbms_output.put_line('consrean ' || tcons(nuIdx).consrean);
    dbms_output.put_line('consrecu ' || tcons(nuIdx).consrecu);
    dbms_output.put_line('nuconsudifelect ' || nuconsudifelect);
    dbms_output.put_line('nuconsuestimado ' || nuconsuestimado);
    dbms_output.put_line('nuconsucorregid ' || nuconsucorregid);
    dbms_output.put_line('nuconsurecupera ' || nuconsurecupera);*/

   -- inicia querys de las auditorias

    sbMensError := 'proceso cuVeriPres ';
    --Ticket 200-1892  ELAL -- se procesan verificacion de presion
	begin
		OPEN cuVeriPres;
		LOOP
		  FETCH cuVeriPres BULK COLLECT INTO v_tbVeriPres LIMIT 100;
			BEGIN
			  FORALL i IN 1..v_tbVeriPres.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VERIPRES VALUES v_tbVeriPres(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
										  nuConsecutivo);
						/*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*/
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  prReporteDetalle(nuIdReporte,
						nuerror,
						 sbMensError||sberror,
						'S' ,
						nuConsecutivo);
			  END;
		  EXIT WHEN cuVeriPres%NOTFOUND;
		END LOOP;

		CLOSE cuVeriPres;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
   COMMIT;

sbMensError := 'proceso cuLectMeno ';

   /*  begin
		--Ticket 200-1892  ELAL -- se procesan lecturas menores
		OPEN cuLectMeno;
		LOOP
		  FETCH cuLectMeno BULK COLLECT INTO v_tbLectMeno LIMIT 100;
		   BEGIN
			  FORALL i IN 1..v_tbLectMeno.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_LECTMENO VALUES v_tbLectMeno(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
										  SQL%BULK_EXCEPTIONS(idx).error_index,
										  sbMensError||SQLERRM(-SQL%BULK_EXCEPTIONS(idx).ERROR_CODE),
										  'S',
										nuConsecutivo );
						\*DBMS_OUTPUT.put_line('Error: ' || i ||
						' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
						' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) );*\
				  END LOOP;
				when others then
				   errors.seterror;
				   errors.geterror(nuerror, sberror);
				   nuConsecutivo := nuConsecutivo +1;
				  prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo);
			  END;
		  EXIT WHEN cuLectMeno%NOTFOUND;
		END LOOP;

		CLOSE cuLectMeno;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;*/
   for rg In cuLectMeno loop

    if RG.CONSUMO_PROMEDIO = 0 then nuconsprom := 100; else nuconsprom := RG.CONSUMO_PROMEDIO; end if;
    if RG.ultconsu = 0 then nuconsulti := 100; else nuconsulti:= RG.ultconsu; end if;
    if RG.SESUCATE = 1 then NUPORCENT := nuPorcPromResi; else NUPORCENT:=nuPorcPromCome; end if;

    BEGIN
      if  ( ( (RG.CONSUMO_ACTUAL * 100 / nuconsprom )  >  NUPORCENT) OR ((RG.CONSUMO_ACTUAL * 100 / nuconsulti)  >  NUPORCENT) ) then
         INSERT INTO LDC_LECTMENO (lemesesu, lemecicl, lemepefa, lemeleac, lemefele, lemelean,
                                   lememeco, lemecoac, lemecopr, lemeregl, lemeano, lememes)
          values (rg.PRODUCTO, rg.CICLO, rg.PEFACODI, rg.LECTURA_ACTUAL, rg.FECHA_LECTURA, rg.LECTURA_ANTERIOR,
                 rg.METODO_CONSUMO, rg.CONSUMO_ACTUAL, rg.CONSUMO_PROMEDIO, rg.REGLA, rg.PEFAANO, rg.PEFAMES);
      end if;
    EXCEPTION WHEN OTHERS THEN
      sbmenslogcr := RG.PRODUCTO|| '  ' || 'CONSUMO_ACTUAL '  || RG.CONSUMO_ACTUAL || ' CONSUMO_PROMEDIO ' || RG.CONSUMO_PROMEDIO || ' ultconsu '  ||  RG.ultconsu
                     || ' CONSUMO_PROMEDIO_FORMULA ' || RG.CONSUMO_PROMEDIO_FORMULA || ' ultconsu_formula '  ||  RG.ultconsu_formula;
      --OSF-2846 Se pone en comentario para poder borrar LDC_BCCREG_B
      --LDC_BCCREG_B.pro_grabalog(3351,'AUDPREV',2021,2,SYSDATE,1,1,sbmenslogcr);
      errors.seterror;
      errors.geterror(nuerror, sberror);
		  nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
			nuerror,
			sbMensError||sberror, 'S', nuConsecutivo );
    END;

   end loop;
   COMMIT;


sbMensError := 'proceso cuPlanErra ';
    begin

		--Ticket 200-1892  ELAL -- se procesan planes errados
		OPEN cuPlanErra;
		LOOP
		  FETCH cuPlanErra BULK COLLECT INTO v_tbPlanErra LIMIT 100;
			BEGIN
			  FORALL i IN 1..v_tbPlanErra.COUNT SAVE EXCEPTIONS
				 INSERT INTO LDC_VAPLANERR VALUES v_tbPlanErra(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
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
				  prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuPlanErra%NOTFOUND;
		END LOOP;

		CLOSE cuPlanErra;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
    COMMIT;

sbMensError := 'proceso cuAjusteCons ';
   begin
   --Ticket 200-1892  ELAL -- se procesan ajuste de correccion de consumo
    OPEN cuAjusteCons;
    LOOP
      FETCH cuAjusteCons BULK COLLECT INTO v_tbAjusteCons LIMIT 100;
       BEGIN
         FORALL i IN 1..v_tbAjusteCons.COUNT SAVE EXCEPTIONS
            INSERT INTO LDC_AJUSCOPR VALUES v_tbAjusteCons(i);
         EXCEPTION
           WHEN ex_dml_errors THEN
              FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
                    nuConsecutivo := nuConsecutivo +1;
                    prReporteDetalle(nuIdReporte,
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
              prReporteDetalle(nuIdReporte,
                    nuerror,
                    sbMensError||sberror,
                    'S' ,
                     nuConsecutivo);
          END;
      EXIT WHEN cuAjusteCons%NOTFOUND;
    END LOOP;

    CLOSE cuAjusteCons;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
   COMMIT;

    sbMensError := 'proceso cuConsAltos ';
    begin
	--Ticket 200-1892  ELAL -- se procesan consumos altos
    OPEN cuConsAltos;
    LOOP
      FETCH cuConsAltos BULK COLLECT INTO v_tbConsAltos LIMIT 100;
        BEGIN
          FORALL i IN 1..v_tbConsAltos.COUNT SAVE EXCEPTIONS
             INSERT INTO LDC_CONSALTO VALUES v_tbConsAltos(i);
         EXCEPTION
           WHEN ex_dml_errors THEN
              FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
                    nuConsecutivo := nuConsecutivo +1;
                    prReporteDetalle(nuIdReporte,
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
              prReporteDetalle(nuIdReporte,
                    nuerror,
                    sbMensError||sberror,
                    'S',
                     nuConsecutivo );
          END;
      EXIT WHEN cuConsAltos%NOTFOUND;
    END LOOP;

    CLOSE cuConsAltos;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
   COMMIT;

   ------- Prod a los que no se le generarian cargos
    sbMensError := 'proceso ProdNOFGCA ';
	begin
		OPEN cuProdNoFgca;
		LOOP
		  FETCH cuProdNoFgca BULK COLLECT INTO v_tbPrNoFgca LIMIT 100;
			BEGIN
			  FORALL i IN 1..v_tbPrNoFgca.COUNT SAVE EXCEPTIONS
				 INSERT INTO LDC_PRNOFGCA VALUES v_tbPrNoFgca(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
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
				  prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuProdNoFgca%NOTFOUND;
		END LOOP;

		CLOSE cuProdNoFgca;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
    COMMIT;

  ------- Usuarios por Categoria
    sbMensError := 'proceso UsuxCate ';
    begin
		OPEN cuUsuporCate;
		LOOP
		  FETCH cuUsuporCate BULK COLLECT INTO v_tbUsuxCate LIMIT 100;
			 BEGIN
			  FORALL i IN 1..v_tbUsuxCate.COUNT SAVE EXCEPTIONS
				INSERT INTO LDC_VERUSCATE VALUES v_tbUsuxCate(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
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
				  prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuUsuporCate%NOTFOUND;
		END LOOP;

		CLOSE cuUsuporCate;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
    COMMIT;

    ------- Usuarios por Categoria
    sbMensError := 'proceso OrdenesPendientes';

	/*
    OPEN cuOrdenesPend;
    LOOP
      FETCH cuOrdenesPend BULK COLLECT INTO v_tbOrdenesPend LIMIT 100;
       FORALL i IN 1..v_tbOrdenesPend.COUNT
         INSERT INTO LDC_ORPECAME VALUES v_tbOrdenesPend(i);

      EXIT WHEN cuOrdenesPend%NOTFOUND;
    END LOOP;
    CLOSE cuOrdenesPend;*/
	begin
		OPEN refCursor FOR 'SELECT '||nuano||' nuano,'|| numes||' numes, '||nuciclo||' nuciclo,  suscripc.susccodi CONTRATO,
						orac.task_type_id TIPO_TRABAJO,
						ord.order_status_id ESTADO_ORDEN,
						ord.operating_unit_id unidad_operativa
				   FROM    open.suscripc, open.or_order_activity orac, open.or_order ord
				  WHERE   orac.subscription_id = susccodi
					AND     orac.order_id = ord.order_id
					AND     ord.order_Status_id not in (8,12)
					AND     orac.task_type_id in ('||sbTipoTrabVal||' )
			AND     susccicl ='|| nuCiclo;
		LOOP
		  FETCH refCursor BULK COLLECT INTO v_tbOrdenesPend LIMIT 100;
			BEGIN
			 FORALL i IN 1..v_tbOrdenesPend.COUNT SAVE EXCEPTIONS
				 INSERT INTO LDC_ORPECAME VALUES v_tbOrdenesPend(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
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
				  prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S' ,
						 nuConsecutivo);
			  END;
		  EXIT WHEN refCursor%NOTFOUND;
		END LOOP;
		close refCursor;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
    COMMIT;

    ------- Contratos con Consumos Pendientes por Facturar
    sbMensError := 'proceso ContConsPend ';
    begin
		OPEN cuContConsPend;
		LOOP
		  FETCH cuContConsPend BULK COLLECT INTO v_tbContConsPend LIMIT 100;
		   BEGIN
			 FORALL i IN 1..v_tbContConsPend.COUNT SAVE EXCEPTIONS
				 INSERT INTO LDC_CONSNOFA VALUES v_tbContConsPend(i);
			 EXCEPTION
			   WHEN ex_dml_errors THEN
				  FOR idx IN 1 .. SQL%BULK_EXCEPTIONS.count LOOP
						nuConsecutivo := nuConsecutivo +1;
						prReporteDetalle(nuIdReporte,
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
				  prReporteDetalle(nuIdReporte,
						nuerror,
						sbMensError||sberror,
						'S',
						 nuConsecutivo );
			  END;
		  EXIT WHEN cuContConsPend%NOTFOUND;
		END LOOP;

		CLOSE cuContConsPend;
	exception
	   when others then
	       rollback;
		   errors.seterror;
		   errors.geterror(nuerror, sberror);
		   nuConsecutivo := nuConsecutivo +1;
		  prReporteDetalle(nuIdReporte,
				nuerror,
				sbMensError||sberror,
				'S',
				 nuConsecutivo);
	end;
    COMMIT;

  -- envia mail
   sbMensError := null;
   begin

     -- se implementa esta modificacion para adaptar al paquete para enviar multiples correos electronicos
     ----------------------- cambio caso 65 --------------------
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
                            isbAsunto           => 'Ejecucion del Proceso LDCFAAC-'||nuCiclo,
                            isbMensaje          => 'Proceso LDCFAAC Termino con exito para el ciclo['||nuCiclo||'], ano['||nuAno||'] y mes['||nuMes||']'
                        );
                       -- DBMS_OUTPUT.PUT_LINE('Email : ' || item.column_value);
                   END IF;
                CLOSE cuValidaEmail;

             EXIT WHEN cuEmails%NOTFOUND;  ---si no encuentra mas valores dentro del cursor termina el ciclo.
           END LOOP;
     END IF;
	 
    exception when others then
      sbMensError := 'Error enviando email, pero proceso Ok';
    end;

    tcons.delete;
    pkErrors.Pop; --Ticket 200-1892  ELAL -- Se finaliza el proceso de log de error
    ldc_proactualizaestaprog(nutsess,sbMensError,'LDCFAAC-'|| nuCiclo,'Ok');


 EXCEPTION

       WHEN ex.CONTROLLED_ERROR THEN
          tcons.delete;
          sbMensError := 'Error: ' || DBMS_UTILITY.format_error_backtrace;
          ldc_proactualizaestaprog(nutsess,sbMensError,'LDCFAAC-'|| nuCiclo,'Termino con error');
          raise ;

      WHEN OTHERS THEN
          tcons.delete;
          Errors.setError;
          sbMensError := sbMensError||'Error No Controlado, '||DBMS_UTILITY.format_error_backtrace;
          Errors.SETMESSAGE(sbMensError);
          ldc_proactualizaestaprog(nutsess,sbMensError,'LDCFAAC-'|| nuCiclo,'Termino con error: ' || DBMS_UTILITY.format_error_backtrace);
          ROLLBACK;
          raise ex.CONTROLLED_ERROR;
end proGeneraAuditorias;

FUNCTION FRCGETPERIODOPREV  RETURN constants.tyrefcursor IS
 /*******************************************************************************
     Metodo:       FRCGETPERIODOPREV
     Descripcion:  funcion que devuelve valor en N de los periodos con auditoria previas
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion

     Salida             Descripcion

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
   *******************************************************************************/
   rfresult constants.tyrefcursor;
 BEGIN
    Open rfresult For SELECT pefacodi periodo,
							pefaano anio,
                            pefames mes,
                            pefacicl ||' - '||(select CICLDESC from ciclo where CICLCODI  =pefacicl  ) ciclo,
                            PEAPFERE fecha_registro
                      FROM LDC_PERIAUPR, PERIFACT
                      WHERE PEFACODI = PEAPPEFA
                       AND PEAPESTA = 'P';

    Return rfresult;
 Exception
    When ex.controlled_error THEN
      Raise;

    When Others THEN
      errors.seterror;
      Raise ex.controlled_error;
 END FRCGETPERIODOPREV;

  PROCEDURE  PRPROCEPERIODOPREV(isbperiodo        In Varchar2,
                                  inucurrent   In Number,
                                  inutotal     In Number,
                                  onuerrorcode Out ge_error_log.message_id%Type,
                                  osberrormess Out ge_error_log.description%Type) IS
     /*******************************************************************************
     Metodo:       PRPROCEPERIODOPREV
     Descripcion:  proceso que apruebas periodos de auditoria previas
     Autor:        Horbath
     Fecha:        18/11/2020
     Ticket:        461

     Entrada        Descripcion
       isbperiodo    periodo
       inucurrent    registro actual
       inutotal      total

     Salida             Descripcion
       onuerrorcode     codigo de error
       osberrormess     mensaje de error
     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/

      nuexiste NUMBER;
    BEGIN
         select count(*) into nuexiste
        from LDC_VALIDGENAUDPREVIAS
        where COD_PEFACODI = isbperiodo
            AND PROCESO = 'AUDPREV';

        if nuexiste = 0 then
            insert into LDC_VALIDGENAUDPREVIAS(cod_pefacodi, fecha_audprevia, PROCESO) VALUES (isbperiodo , SYSDATE, 'AUDPREV');
        else
            update LDC_VALIDGENAUDPREVIAS set fecha_audprevia = sysdate
              where cod_pefacodi = isbperiodo AND PROCESO = 'AUDPREV';
        end if;

        UPDATE LDC_PERIAUPR SET PEAPESTA = 'T',
                                PEAPFEAP = SYSDATE,
                                PEAPUSUA = USER,
                                PEAPTERM = USERENV('TERMINAL')
        WHERE PEAPPEFA = isbperiodo;

    Exception
      When ex.controlled_error Then
        ut_trace.trace('[CONTROLLED ERROR] LDC_PKFAAC.PRPROCEPERIODOPREV',
                     10);
      Raise;
    When Others Then
      ut_trace.trace('[OTHERS ERRROR] LDC_PKFAAC.PRPROCEPERIODOPREV', 10);
      errors.seterror;
      Raise ex.controlled_error;
  END PRPROCEPERIODOPREV;
end LDC_PKFAAC;
/

