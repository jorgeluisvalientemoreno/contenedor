create or replace PACKAGE LDC_PKACTCOPRSUCA IS
/**************************************************************************
    Autor       : HB
    Fecha       : 2020-10-27
    Descripcion : PAQUETE PARA ACTUALIZAR LOS PROMEDIOS DE SUBCATEGORIAS (CA-413)

    Parametros Entrada

    Valor de salida

	HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   	DESCRIPCION
	05/08/2022	CGONZALEZ	OSF-480: Se ajusta el servicio <fnGuardConsProm>
    19/05/2023   LJLB       OSF-1094 se ajusta procedo practuliza
    15/05/2024	 JSOTO		OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo

***************************************************************************/

-- tabla de notas
  TYPE rcCons  IS RECORD(
     ano        number(4),
     mes        number(2),
     cate       number(2),
     suca       number(2),
     loca       number(6),
     cantpro    number(7),
     consdia    number (13,2),
     consmes    number (13,2),
     isactual   VARCHAR2(2));

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

PROCEDURE prActualiza (idtfecha date) ;

FUNCTION fnGuardConsProm  (osbMsgError out varchar2) return number;

END LDC_PKACTCOPRSUCA;
/
create or replace PACKAGE BODY LDC_PKACTCOPRSUCA IS

/**************************************************************************
    Autor       : HB
    Fecha       : 2020-10-27
    Descripcion : PAQUETE PARA ACTUALIZAR LOS PROMEDIOS DE SUBCATEGORIAS (CA-413)

    Parametros Entrada

    Valor de salida

	HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   	DESCRIPCION
	05/08/2022	CGONZALEZ	OSF-480: Se ajusta el servicio <fnGuardConsProm>
  08/03/2023  LJLB     OSF-954 -- se ajusta proceso prActualiza para que solo tenga en cuenta 
                       consumo por diferencia de lectura
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
  from perifact p1, perifact p2
 where p1.pefacicl =  p2.pefacicl
   and p2.pefacodi = inupefa
   and p1.PEFAFFMO < p2.PEFAFIMO;

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
  select trunc(sysdate-1) into dtfecha
  from dual;
  prActualiza (dtfecha);
end  prProceso;


-------------------------------------------------------------------------------------

PROCEDURE prActualiza (idtfecha date)  is

dtfeleante date;
dtfeleactu date;
onuError number := 0;
osbMsgError varchar2(2000) := NULL;

cursor cuPeriodos is
select pj.prejcope, pefacicl, pefaano, pefames
  from procejec pj, perifact pf
 where pj.prejcope = pefacodi
   and trunc(pj.prejfech) = idtfecha
   and pj.prejprog = 'FGCC';

CURSOR cuConsumos (nupefa perifact.pefacodi%type) IS
select cosssesu, max(COSSDICO) COSSDICO, sum(nvl(cosscoca,0)) cosscoca
  from conssesu c, servsusc
 where cosspefa=nupefa
   and cossflli='S'
   and sesunuse = cosssesu
   and sesuesfn <> 'C'
   and ( COSSCONS <> -2
         or cosscoca = 0 )
   and EXISTS ( SELECT 1 
                  FROM OPEN.conssesu CM 
                  WHERE CM.cosspefa = C.cosspefa 
                    AND CM.COSSMECC = 1
                    AND C.COSSSESU = CM.COSSSESU
                    and CM.cossfere = (select max(cossfere)
                                        from OPEN.conssesu CM1 
                                        where CM1.COSSSESU = cm.COSSSESU
                                         and CM1.cosspefa = CM.cosspefa))
group by cosssesu;



nulocalida   ge_geogra_location.geograp_location_id%type;
nucategoria  servsusc.sesucate%type;
nusubcateg   servsusc.sesusuca%type;

numesactu     number(2);

nuanoactu     number(4);
nudicomesactu number(4);

nudiascons    number(4);
nuconsmesactu number(13,2);

nupromdiamesactu     number(13,2);

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
    sbCiclos := sbCiclos || rg.pefacicl || ' (' || rg.pefaano || ' - ' || rg .pefames || '),' || chr(13);
    nuerror := 3;
    for rg2 in cuConsumos(rg.prejcope) loop
 
     nulocalida := fnuLocaCateSuca (rg2.cosssesu, nucategoria, nusubcateg);

      nuerror := 4;
      
      numesactu := rg.pefames;
      nuanoactu := rg.pefaano;
      
      nudicomesactu := nvl(rg2.COSSDICO,0);
      
      if nvl(rg2.COSSDICO,0) = 0 then        
        nuconsmesactu := 0;
      else       
        nuconsmesactu := rg2.cosscoca;
      end if;

    
      if nudicomesactu = 0 then
        nupromdiamesactu := 0;
      else
        nupromdiamesactu :=  nuconsmesactu / nudicomesactu;
      end if;

      nuerror := 7;
     
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
        tCons(sbInd).isactual := 'S';
      else
        tCons(sbInd).cantpro := tCons(sbInd).cantpro + 1;
        tCons(sbInd).consdia := tCons(sbInd).consdia + nupromdiamesactu;
        tCons(sbInd).consmes := tCons(sbInd).consmes + nuconsmesactu;
      end if;

     end loop;
  end loop;

  nuerror := 8;
  onuError := fnGuardConsProm (osbMsgError);
  nuerror := 9;
  tCons.delete;

  if onuError = 0 then
     sbmensa       := 'Proceso termino Ok. Se procesaron :'||to_char(nucantregis)||' Ciclos';
     ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Ok.');

  --se envian correos
   sbmensa := 'Proceso termino Ok. Se procesaron los ciclos: ' || chr(13) || sbCiclos;
   
   pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sbfrom,
								isbDestinatarios    => sbto,
								isbAsunto           => sbsubject,
								isbMensaje          => sbmensa
							);

   
  else
     sbmensa := 'Proceso termino con errores procesando los ciclos: ' || chr(13) || sbCiclos || '.' || chr(13) || osbMsgError;

	 pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sbfrom,
								isbDestinatarios    => sbto,
								isbAsunto           => sbsubject,
								isbMensaje          => sbmensa
							);

  end if;

EXCEPTION WHEN OTHERS THEN
 ROLLBACK;
  sbmensa := ' Error en LDC_PKACTCOPRSUCA...linea error '||to_char(nuerror) || ' ' || sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PKACTCOPRSUCA','Termino con error.');
   --se envian correos si hubo error
   
      pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sbfrom,
								isbDestinatarios    => sbto,
								isbAsunto           => sbsubject,
								isbMensaje          => sbmensa
							);

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

	CURSOR cuCOPRSUCA
	(
		nuCate 	IN servsusc.sesucate%type,
		nuSuca 	IN servsusc.sesusuca%type,
        nuLoca 	IN ge_geogra_location.geograp_location_id%type,
		nuAno 	IN perifact.pefaano%type,
		nuMes 	IN perifact.pefames%type
	) IS
		SELECT 	COUNT(1)
		FROM 	COPRSUCA c
		WHERE  	c.cpsccate = nuCate
		AND 	c.cpscsuca = nuSuca
		AND 	c.cpscubge = nuLoca
		AND 	c.cpscanco = nuAno
		AND 	c.cpscmeco = nuMes;

	nuCOPRSUCA 	NUMBER;

BEGIN
   sbInd :=  tCons.first;
  loop exit when (sbInd IS null);
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

	OPEN cuCOPRSUCA(tCons(sbind).cate, tCons(sbind).suca, tCons(sbind).loca, tCons(sbind).ano, tCons(sbind).mes);
	FETCH cuCOPRSUCA INTO nuCOPRSUCA;
	CLOSE cuCOPRSUCA;

	IF (nuCOPRSUCA = 0) THEN
		INSERT INTO COPRSUCA(CPSCCATE, CPSCSUCA, CPSCTCON, CPSCUBGE, CPSCANCO, CPSCMECO, CPSCCONS, CPSCPROD, CPSCPRDI, CPSCCOTO)
		VALUES(tCons(sbind).cate, tCons(sbind).suca, 1, tCons(sbind).loca, tCons(sbind).ano, tCons(sbind).mes, SQ_COPRSUCA_198726.NEXTVAL, nucant, nuprdi, nucoto);
	ELSE
		-- actualiza coprsuca
		UPDATE 	COPRSUCA c
		SET 	c.cpscprod = nucant,
				c.cpscprdi = nuprdi,
				c.cpsccoto = nucoto
		WHERE 	c.cpsccate = tCons(sbind).cate
		AND 	c.cpscsuca = tCons(sbind).suca
		AND 	c.cpscubge = tCons(sbind).loca
		AND 	c.cpscanco = tCons(sbind).ano
		AND 	c.cpscmeco = tCons(sbind).mes;

	END IF;



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

end LDC_PKACTCOPRSUCA;
/