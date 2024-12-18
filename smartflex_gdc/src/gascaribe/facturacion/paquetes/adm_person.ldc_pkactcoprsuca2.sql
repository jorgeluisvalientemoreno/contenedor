CREATE OR REPLACE package adm_person.ldc_pkactcoprsuca2 IS
/**************************************************************************
    Autor       : HB
    Fecha       : 2020-10-27
    Descripcion : PAQUETE PARA ACTUALIZAR LOS PROMEDIOS DE SUBCATEGORIAS (CA-413)

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR         DESCRIPCION
     18/06/2024   Adrianavg     OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
***************************************************************************/

-- tabla de notas
  TYPE rcCons  IS RECORD(
     ano        number(4),
     mes        number(2),
     cate       number(2),
     suca       number(2),
     loca       number(6),
     cantpro    number(7),
     consdia    number (15,3),
     consmes    number (15,3));

  TYPE tbCons IS TABLE OF rcCons INDEX BY varchar2(16);
  tCons tbCons;
  sbInd  varchar2(16);


function  fnuFechaLectAct (inusesu              in servsusc.sesunuse%type,
                           inupefa               in perifact.pefacodi%type) return date;

function  fnuFechaLectAnt (inusesu              in servsusc.sesunuse%type,
                           inupefa               in perifact.pefacodi%type) return date;

function  fnuLocaCateSuca (inusesu in  servsusc.sesunuse%type,
                           onucate out servsusc.sesucate%type,
                           onusuca out servsusc.sesusuca%type) return number;

PROCEDURE prProceso;

PROCEDURE prActualiza /*(idtfecha date) */;

FUNCTION fnGuardConsProm  (osbMsgError out varchar2) return number;

END LDC_PKACTCOPRSUCA2;
/
CREATE OR REPLACE package BODY adm_person.LDC_PKACTCOPRSUCA2 IS

/**************************************************************************
    Autor       : HB
    Fecha       : 2020-10-27
    Descripcion : PAQUETE PARA ACTUALIZAR LOS PROMEDIOS DE SUBCATEGORIAS (CA-413)

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
***************************************************************************/

-------------------------------------------------------------------------------------
function  fnuFechaLectAct (inusesu              in servsusc.sesunuse%type,
                           inupefa               in perifact.pefacodi%type) return date is

dtfechlect date;

cursor cuLecturaProd is
select e.leemfele
  from lectelme e
 where leemsesu = inusesu
   and leempefa= inupefa
   and e.leemclec in ('I','F')
   and NVL(LEEMOBLE,-1) IN (-1,76)
ORDER BY LEEMOBLE DESC;

cursor cuLecturaPeri is
select p2.pecsfecf
  from perifact p1, pericose p2
 where p2.pecsfecf between p1.pefafimo and p1.pefaffmo
   and p1.pefacicl = p2.pecscico
   and p1.pefacodi = inupefa;



BEGIN
   open cuLecturaProd;
   fetch cuLecturaProd into dtfechlect;
   if cuLecturaProd%notfound then
     dtfechlect := null;
   end if;
   close cuLecturaProd;

   if dtfechlect is null then
     open cuLecturaPeri;
     fetch cuLecturaPeri into dtfechlect;
     if cuLecturaPeri%notfound then
       dtfechlect := null;
     end if;
     close cuLecturaPeri;
   end if;

  if  dtfechlect is null then
     dtfechlect := sysdate - 31;
  end if;

  return dtfechlect;

exception when others then
  return sysdate - 31;
end fnuFechaLectAct;
-------------------------------------------------------------------------------------
function  fnuFechaLectAnt (inusesu              in servsusc.sesunuse%type,
                           inupefa               in perifact.pefacodi%type) return date is

dtfechlect date;
nuperi perifact.pefacodi%type;

cursor cuPeriAnte is
select max(p1.pefacodi)
  from perifact p1
 where p1.pefacicl = (select p2.pefacicl
                        from perifact p2
                       where p2.pefacodi=inupefa)
   and p1.pefacodi < inupefa;

cursor cuLecturaProd (nupefacodi perifact.pefacodi%type) is
select e.leemfele
  from lectelme e
 where leemsesu = inusesu
   and leempefa= nupefacodi
   and e.leemclec in ('I','F')
   and NVL(LEEMOBLE,-1) IN (-1,76)
ORDER BY LEEMOBLE DESC;

cursor cuLecturaPeri (nupefacodi perifact.pefacodi%type) is
select p2.pecsfecf
  from perifact p1, pericose p2
 where p2.pecsfecf between p1.pefafimo and p1.pefaffmo
   and p1.pefacicl = p2.pecscico
   and p1.pefacodi = nupefacodi;




BEGIN
   open cuPeriAnte;
   fetch cuPeriAnte into nuperi;
   if cuPeriAnte%notfound then
     nuperi := null;
   end if;
   close cuPeriAnte;

   if nuperi is not null then
     open cuLecturaProd (nuperi);
     fetch cuLecturaProd into dtfechlect;
     if cuLecturaProd%notfound then
       dtfechlect := null;
     end if;
     close cuLecturaProd;

     if dtfechlect is null then
       open cuLecturaPeri (nuperi);
       fetch cuLecturaPeri into dtfechlect;
       if cuLecturaPeri%notfound then
         dtfechlect := null;
       end if;
       close cuLecturaPeri;
     end if;

    if  dtfechlect is null then
       dtfechlect := sysdate - 61;
    end if;
  else
    dtfechlect := sysdate - 61;
  end if;

  return dtfechlect;

exception when others then
 return sysdate - 61;
end fnuFechaLectAnt;
-------------------------------------------------------------------------------------
function  fnuLocaCateSuca (inusesu in  servsusc.sesunuse%type,
                           onucate out servsusc.sesucate%type,
                           onusuca out servsusc.sesusuca%type) return number is

nuloca ge_geogra_location.geograp_location_id%type;

cursor cuDatosProd is
select p.category_id, p.subcategory_id, g.geograp_location_id
  from pr_product p, ab_Address d, ge_geogra_location g
 where p.product_id = inusesu
   and p.address_id=d.address_id
   and d.geograp_location_id =g.geograp_location_id;


BEGIN
   open cuDatosProd;
   fetch cuDatosProd into onucate, onusuca, nuloca;
   if cuDatosProd%notfound then
     onucate:=null;
     onusuca:=null;
     nuloca:=null;
   end if;
   close cuDatosProd;

  return nuloca;

exception when others then
  return null;
end fnuLocaCateSuca;

-------------------------------------------------------------------------------------
PROCEDURE prProceso  is
dtfecha date;
begin
  select trunc(sysdate-1) into dtfecha from dual;
  prActualiza /*(dtfecha)*/;
end  prProceso;


-------------------------------------------------------------------------------------

PROCEDURE prActualiza /*(idtfecha date)*/  is

dtfeleante date;
dtfeleactu date;
onuError number := 0;
osbMsgError varchar2(2000) := NULL;

cursor cuPeriodos is
select distinct pj.prejcope, pefacicl, pefaano, pefames
  from open.procejec pj, open.perifact pf
 where pj.prejcope = pefacodi
   and pj.prejprog = 'FGCC'
   and prejfech >= to_Date('02/11/2020','dd/mm/yyyy')
   and prejfech <  to_Date('28/02/2021','dd/mm/yyyy') + 1
 order by prejcope;


CURSOR cuConsumos (nupefa perifact.pefacodi%type) IS
select cosssesu, sum(nvl(cosscoca,0)) cosscoca
  from conssesu
 where cosspefa=nupefa
 --  and cosssesu=1047456
   and cossflli='S'
group by cosssesu;


nulocalida   ge_geogra_location.geograp_location_id%type;
nucategoria  servsusc.sesucate%type;
nusubcateg   servsusc.sesusuca%type;
numesante     number(2);
numesactu     number(2);
nuanoante     number(4);
nuanoactu     number(4);
nudicomesactu number(4);
nudicomesante number(4);
nudiascons    number(4);
nuconsmesactu number(13,2);
nuconsmesante number(13,2);
nupromdiamesante     number(15,3);
nupromdiamesactu     number(15,3);

nutsess       NUMBER;
sbparuser     VARCHAR2(30);
NUERROR       NUMBER(3);
nucantregis   number := 0;
nuparano      NUMBER(4);
nuparmes      NUMBER(2);

-- Destinatarios
sbto        Varchar2(4000) := dald_parameter.fsbgetvalue_chain('MAIL_LDC_COPRSUCA', NULL);
sbsubject   Varchar2(4000) := 'Cargue Promedios Subcategorias';
sbmsg       VARCHAR2(4000);
sbfrom      Varchar2(4000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER'); --  se coloca el emisor del correo
sbCiclos    VARCHAR2(4000);
sbmensa     VARCHAR2(4000);

BEGIN
  nuerror := 1;
  nucantregis := 0;
  tCons.delete;
 -- Se obtiene parametros
  SELECT USERENV('SESSIONID'),USER INTO nutsess,sbparuser
   FROM dual;
   nuerror := 1;
  -- Se adiciona al log de procesos
  ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PKACTCOPRSUCA','En ejecucion',nutsess,sbparuser);

  nuerror := 2;

  for rg in cuPeriodos loop
    nucantregis := nucantregis + 1;
    --sbCiclos := sbCiclos || rg.pefacicl || ' (' || rg.pefaano || ' - ' || rg .pefames || '),' || chr(13);

    nuerror := 3;
    for rg2 in cuConsumos(rg.prejcope) loop
      dtfeleante := fnuFechaLectAnt (rg2.cosssesu, rg.prejcope);
      dtfeleactu := fnuFechaLectAct (rg2.cosssesu, rg.prejcope);
      nulocalida := fnuLocaCateSuca (rg2.cosssesu, nucategoria, nusubcateg);

      nuerror := 4;

      SELECT EXTRACT(MONTH FROM dtfeleante) INTO numesante FROM dual;
      SELECT EXTRACT(YEAR FROM dtfeleante)  INTO nuanoante FROM dual;
      SELECT EXTRACT(MONTH FROM dtfeleactu) INTO numesactu FROM dual;
      SELECT EXTRACT(YEAR FROM dtfeleactu)  INTO nuanoactu FROM dual;

      nuerror := 5;

      nudiascons := trunc(dtfeleactu - dtfeleante);
      SELECT trunc(LAST_DAY(dtfeleante) - dtfeleante) into nudicomesante FROM DUAL;
      SELECT EXTRACT(DAY FROM dtfeleactu)  INTO nudicomesactu FROM dual;

      nuerror := 6;

      if nvl(nudiascons,0) = 0 then
        nuconsmesante := 0;
        nuconsmesactu := 0;
      else
        nuconsmesante := round(nudicomesante * rg2.cosscoca / nudiascons,0);
        nuconsmesactu := rg2.cosscoca - nuconsmesante;
      end if;

      if nudicomesante = 0 then
        nupromdiamesante := 0;
      else
        nupromdiamesante :=  nuconsmesante / nudicomesante;
      end if;

      if nudicomesactu = 0 then
        nupromdiamesactu := 0;
      else
        nupromdiamesactu :=  nuconsmesactu / nudicomesactu;
      end if;

      nuerror := 7;

      sbInd := nuanoante || lpad(numesante,2,'0') || lpad(nucategoria,2,'0') || lpad(nusubcateg,2,'0') || lpad(nulocalida,6,'0');
      if not tCons.exists(sbInd) then
        tCons(sbInd).ano := nuanoante;
        tCons(sbInd).mes := numesante;
        tCons(sbInd).cate := nucategoria;
        tCons(sbInd).suca := nusubcateg;
        tCons(sbInd).loca := nulocalida;
        tCons(sbInd).cantpro := 1;
        tCons(sbInd).consdia := nupromdiamesante;
        tCons(sbInd).consmes := nuconsmesante;
      else
        tCons(sbInd).cantpro := tCons(sbInd).cantpro + 1;
        tCons(sbInd).consdia := tCons(sbInd).consdia + nupromdiamesante;
        tCons(sbInd).consmes := tCons(sbInd).consmes + nuconsmesante;
      end if;

      sbInd := nuanoactu || lpad(numesactu,2,'0') || lpad(nucategoria,2,'0') || lpad(nusubcateg,2,'0') || lpad(nulocalida,6,'0');
      if not tCons.exists(sbInd) then
        tCons(sbInd).ano := nuanoactu;
        tCons(sbInd).mes := numesactu;
        tCons(sbInd).cate := nucategoria;
        tCons(sbInd).suca := nusubcateg;
        tCons(sbInd).loca := nulocalida;
        tCons(sbInd).cantpro := 1;
        tCons(sbInd).consdia := nupromdiamesactu;
        tCons(sbInd).consmes := nuconsmesactu;
      else
        tCons(sbInd).cantpro := tCons(sbInd).cantpro + 1;
        tCons(sbInd).consdia := tCons(sbInd).consdia + nupromdiamesactu;
        tCons(sbInd).consmes := tCons(sbInd).consmes + nuconsmesactu;
      end if;

     end loop;
      sbmensa       := 'Van procesados :'||to_char(nucantregis)||' Ciclos';
    ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Ok.');
  end loop;

  sbmensa       := 'Terminaron :'||to_char(nucantregis)||' Ciclos ... Va a guardar en tabla';
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Ok.');
  nuerror := 8;
  onuError := fnGuardConsProm (osbMsgError);
  nuerror := 9;
  tCons.delete;

  if onuError = 0 then
     sbmensa       := 'Proceso termino Ok. Se procesaron :'||to_char(nucantregis)||' Ciclos';
     ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Ok.');

  --se envian correos
   /*sbmensa := 'Proceso termino Ok. Se procesaron :'||to_char(nucantregis)||' Ciclos:'|| chr(13) || substr(sbCiclos,1,4000);
      LDC_Email.mail( sbfrom,
                        sbto,
                        sbsubject,
                        sbmensa);*/
  else
     sbmensa := 'Proceso termino con errores procesando los ciclos: ' || chr(13) || sbCiclos || '.' || chr(13) || osbMsgError;
     ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Error.');
      /*LDC_Email.mail( sbfrom,
                        sbto,
                        sbsubject,
                        sbmensa);*/
  end if;

EXCEPTION WHEN OTHERS THEN
 ROLLBACK;
   sbmensa := ' Error en LDC_PKACTCOPRSUCA...linea error '||to_char(nuerror) || ' ' || sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Termino con error.');
   --se envian correos si hubo error
          /*LDC_Email.mail( sbfrom,
                        sbto,
                        sbsubject,
                        sbmensa);*/
END prActualiza;
-------------------------------------------------------------------------------------
FUNCTION fnGuardConsProm  (osbMsgError out varchar2) return number is

  onuError number := 0;
  nuseq All_Sequences.LAST_NUMBER%type;
  nucant LDC_COPRSUCA.cpscprod%type;
  nuprdi LDC_COPRSUCA.cpscprdi%type;
  nucoto LDC_COPRSUCA.cpsccoto%type;
  sbmens varchar2(4000);

  cursor cuLDC_COPRSUCA (nucate servsusc.sesucate%type, nusuca servsusc.sesusuca%type,
                         nuloca ge_geogra_location.geograp_location_id%type, nuano perifact.pefaano%type,
                         numes perifact.pefames%type) is
    select *
      from LDC_COPRSUCA c
     where c.cpsccate = nucate
       and c.cpscsuca = nusuca
       and c.cpscubge = nuloca
       and c.cpscanco = nuano
       and c.cpscmeco = numes;
   rgLDC_COPRSUCA cuLDC_COPRSUCA%rowtype;

  cursor cu_COPRSUCA (nucate servsusc.sesucate%type, nusuca servsusc.sesusuca%type,
                      nuloca ge_geogra_location.geograp_location_id%type, nuano perifact.pefaano%type,
                      numes perifact.pefames%type) is
    select *
      from COPRSUCA c
     where c.cpsccate = nucate
       and c.cpscsuca = nusuca
       and c.cpscubge = nuloca
       and c.cpscanco = nuano
       and c.cpscmeco = numes;
    rg_COPRSUCA cu_COPRSUCA%rowtype;

BEGIN
   sbInd :=  tCons.first;
  loop exit when (sbInd IS null);
   if tCons(sbind).ano = 2020 and tCons(sbind).mes < 12 then
     null;
   else
    open cuLDC_COPRSUCA (tCons(sbind).cate, tCons(sbind).suca, tCons(sbind).loca, tCons(sbind).ano, tCons(sbind).mes);
    fetch cuLDC_COPRSUCA into rgLDC_COPRSUCA;
    if cuLDC_COPRSUCA%notfound then
      rgLDC_COPRSUCA.Cpsccons := -1;
    end if;
    close cuLDC_COPRSUCA;

    if rgLDC_COPRSUCA.Cpsccons = -1 then
      nuseq := LDC_SEQ_COPRSUCA.NEXTVAL;
      nucant := tCons(sbind).cantpro;
      nuprdi := tCons(sbind).consdia / nucant;
      nucoto := tCons(sbind).consmes;
      insert into LDC_COPRSUCA (cpsccons, cpsccate, cpscsuca, cpscubge,
                                cpscanco, cpscmeco, cpscprod, cpscprdi,
                                cpsccoto )
                       values  (nuseq, tCons(sbind).cate, tCons(sbind).suca, tCons(sbind).loca,
                                tCons(sbind).ano,  tCons(sbind).mes, nucant, nuprdi, nucoto);
    else
      nucant := rgLDC_COPRSUCA.cpscprod + tCons(sbind).cantpro;
      nuprdi := (rgLDC_COPRSUCA.cpscprdi + (tCons(sbind).consdia / tCons(sbind).cantpro)) / 2;
      nucoto := rgLDC_COPRSUCA.cpsccoto + tCons(sbind).consmes;
      update LDC_COPRSUCA c
         set c.cpscprod = nucant,
             c.cpscprdi = nuprdi,
             c.cpsccoto = nucoto
       where c.cpsccons = rgLDC_COPRSUCA.Cpsccons;
    end if;

    -- actualiza coprsuca
   update COPRSUCA c
         set c.cpscprod = nucant,
             c.cpscprdi = nuprdi,
             c.cpsccoto = nucoto
       where c.cpsccate = tCons(sbind).cate
         and c.cpscsuca = tCons(sbind).suca
         and c.cpscubge = tCons(sbind).loca
         and c.cpscanco = tCons(sbind).ano
         and c.cpscmeco = tCons(sbind).mes;
  end if;
  sbInd := tCons.next(sbInd);
 end loop;
 commit;
 return onuError;


EXCEPTION WHEN OTHERS THEN
  rollback;
  ERRORS.SETERROR;
  ERRORS.geterror(onuError,osbMsgError);
  osbMsgError := 'Error en prGuardConsProm: '|| osbMsgError;
  return -1;
END fnGuardConsProm;

-------------------------------------------------------------------------------------


end LDC_PKACTCOPRSUCA2;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKACTCOPRSUCA2
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKACTCOPRSUCA2', 'ADM_PERSON'); 
END;
/
