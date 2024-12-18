create or replace function adm_person.fnu_ldc_getsaldconc_orm (inusesu cuencobr.cuconuse%type,
                                                    inucuco cuencobr.cucocodi%type,
                                                    inuconc cargos.cargconc%type) return varchar2 is

/***************************************************************************
  Funcion: ldc_getsaldxconc

  Descripcion:    Obtiene el saldo a la fecha de un concepto en particular de una cuenta o de todas
                  las cuentas de un producto

  Autor: F.Castro
  Fecha: Abril 19 de 2018

  Parametros
  inusesu      Producto
  inucuco      -1 para todas las cuentas con saldo del producto,
               numero de cuenta: para buscar los conceptos con saldo de una cuenta
  inuconc      -1 para que devuelva cadena con concepto, descripcion y saldo a la fecha
                  de todos los conceptos con saldo a la fecha actual
               codigo de concepto:  para que devuelva cadena solo con el saldo a la fecha del concepto dado


  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  28/01/2019     F.Castro        Se modifica cursor cucargosres para que incluya los conceptos de diferidos
                                 que tienen saldo y que el concepto no tienen saldo en corriente (200-2385)
  02/01/2024	cgonzalez		OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/

 TYPE rcConc IS RECORD(
    cargcuco NUMBER,
    cargconc NUMBER,
    cargvalo NUMBER,
    cargescc varchar2(1));

  TYPE tbconc IS TABLE OF rcconc INDEX BY varchar2(14);
  tconc tbconc;
  sbindice varchar2(14);

  TYPE rcConcRes IS RECORD(
    cargconc NUMBER,
    cargvrve NUMBER,
    cargvrnv NUMBER,
    difesape NUMBER);

  TYPE tbconcres IS TABLE OF rcconcres INDEX BY pls_integer;
  tconcres tbconcres;
  nuindice pls_integer;


 nusaldocc number := 0;
 sbcadena varchar2(2000) := null;


 cursor cucargos is
  select cargcuco,cargconc,
         case when cucofeve < sysdate then 'V' else 'N' end estadocc,
         sum(decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo)) cargvalo
    from cargos, cuencobr
   where cargcuco=cucocodi
     and cuconuse = inusesu
     and cucocodi = decode(inucuco , -1, cucocodi, inucuco)
     and cucosacu > 0
     and cargconc not in (9,145,123)
   group by cargcuco,cargconc,cucofeve
   order by cargcuco,cargconc;

   cursor cucargosres is
  select cargconc,
         /*sum(decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo))*/ 0 cargvalo
    from cargos, cuencobr
   where cargcuco=cucocodi
     and cuconuse = inusesu
     and cucocodi = decode(inucuco , -1, cucocodi, inucuco)
     and cucosacu > 0
     and cargconc not in (9,145,123)
   group by cargconc
 UNION
 (select distinct(difeconc) cargconc, 0 cargvalo
   from diferido
  where difenuse=inusesu
    and difesape!=0)
 ORDER BY cargconc;

  cursor cucuentas is
  select distinct(cucocodi) cucocodi
    from cuencobr
   where cuconuse = inusesu
     and cucocodi = decode(inucuco , -1, cucocodi, inucuco)
     and cucosacu > 0
   order by cucocodi;

 cursor cupagos (nucuco number) is
  select cargcuco, cucofeve, cargsign, cargfecr, cargvalo, cargcodo
    from cargos, cuencobr
   where cargcuco=cucocodi
     and cucocodi = nucuco
     and cargsign in ('PA','AS')
   order by cargfecr;

 cursor curesureca (nucupon number, cdtfeve date) is
   select r.rereconc, r.rerevalo
     from resureca r
    where r.rerecupo = nucupon
      and r.rerefeve = cdtfeve;

-------------------------------------------------------
function fnugetsaldocc (inucuenta number) return number is

  sbIndex varchar2(14);
  nusaldo number := 0;

begin
  sbIndex :=  tconc.first;
  loop exit when (sbIndex IS null);
     if tconc(sbIndex).cargcuco = lpad(inucuenta, 10, '0') then
       nusaldo := nusaldo + tconc(sbIndex).cargvalo;
     end if;
     sbIndex := tconc.next(sbIndex);
  end loop;
  return (nusaldo);
end;
-------------------------------------------------------
function fnugetsaldife (inuconc number) return number is

nusaldife number :=0;

cursor cudife is
 select sum(difesape)
   from diferido
  where difenuse=inusesu
    and difesape>0
    and difeconc = inuconc;

begin
  open cudife;
  fetch cudife into nusaldife;
  if cudife%notfound then
    nusaldife := 0;
  end if;
  close cudife;

  return (nvl(nusaldife,0));
end;
-------------------------------------------------------
function fsbdescconc (inuconce number) return varchar is

  sbdesc concepto.concdesc%type;

  cursor cuconcepto is
  select concdesc
    from concepto
   where conccodi = inuconce;

begin
  open cuconcepto;
  fetch cuconcepto into sbdesc;
  if cuconcepto%notfound then
    sbdesc := null;
  end if;
  close cuconcepto;
  return (sbdesc);
end;
-------------------------------------------------------

procedure prAplicaAs (inucuenta number,  inusaldo number, inucargoas number) is

  sbIndex varchar2(14);
  nuvlrapli number := 0;

begin
  sbIndex :=  tconc.first;
  loop exit when (sbIndex IS null);
     if tconc(sbIndex).cargcuco = lpad(inucuenta, 10, '0') then
       nuvlrapli := inucargoas * (tconc(sbIndex).cargvalo * 100 / inusaldo) / 100;
       tconc(sbIndex).cargvalo :=  tconc(sbIndex).cargvalo - nuvlrapli;
     end if;
     sbIndex := tconc.next(sbIndex);
  end loop;
end;
-------------------------------------------------------

begin
  tconc.delete;
  tconcres.delete;
  -- carga saldos de conceptos por cuenta
  for rg in cucargos loop
    sbindice := lpad(rg.cargcuco, 10, '0') || lpad(rg.cargconc, 4, '0');
    tconc(sbindice).cargcuco := rg.cargcuco;
    tconc(sbindice).cargconc := rg.cargconc;
    tconc(sbindice).cargescc := rg.estadocc;
    tconc(sbindice).cargvalo := rg.cargvalo;
  end loop;

  for rg in cucargosres loop
    nuindice := rg.cargconc;
    tconcres(nuindice).cargconc := rg.cargconc;
    tconcres(nuindice).cargvrve := 0;
    tconcres(nuindice).cargvrnv := 0;
    tconcres(nuindice).difesape := fnugetsaldife(rg.cargconc);
  end loop;

  for rg in cucuentas loop
    for rg2 in cuPagos(rg.cucocodi) loop
      if rg2.cargsign = 'PA' then
        for rg3 in curesureca(rg2.cargcodo, rg2.cucofeve) loop
          sbindice := lpad(rg2.cargcuco, 10, '0') || lpad(rg3.rereconc, 4, '0');
          if tconc.EXISTS(sbindice) THEN
             tconc(sbindice).cargvalo := tconc(sbindice).cargvalo - rg3.rerevalo;
          end if;
        end loop;
     else -- cargsign AS
       nusaldocc := fnugetsaldocc(rg2.cargcuco);
       prAplicaAs(rg2.cargcuco, nusaldocc, rg2.cargvalo);
     end if;
   end loop;
  end loop;

 -- arma salida para cuando es cc -conce - valor

  -- resume conceptos
  sbIndice :=  tconc.first;
  loop exit when (sbIndice IS null);
      nuindice := tconc(sbIndice).cargconc;
      if tconcres.EXISTS(nuindice) THEN
        if tconc(sbindice).cargescc = 'V' then
          tconcres(nuindice).cargvrve :=  tconcres(nuindice).cargvrve + tconc(sbIndice).cargvalo;
        else
          tconcres(nuindice).cargvrnv :=  tconcres(nuindice).cargvrnv + tconc(sbIndice).cargvalo;
        end if;
      end if;
      sbIndice := tconc.next(sbIndice);
  end loop;

  -- arma salida para cuando es conce - valor
  if inuconc = -1 then -- todos los conceptos
    nuIndice :=  tconcres.first;
    loop exit when (nuIndice IS null);
       sbcadena := sbcadena || tconcres(nuIndice).cargconc || ';' ||
                   fsbdescconc(tconcres(nuIndice).cargconc) || ';' ||
                   tconcres(nuIndice).cargvrve || ';' ||
                   tconcres(nuIndice).cargvrnv || ';' ||
                   tconcres(nuIndice).difesape || '|';
       nuIndice := tconcres.next(nuIndice);
    end loop;
  else -- vencido de un concepto en particular
    nuindice := inuconc;
    if tconcres.EXISTS(nuindice) THEN
      sbcadena := tconcres(nuIndice).cargvrve + tconcres(nuIndice).cargvrnv;
    else
      sbcadena := 0;
    end if;
  end if;

  tconc.delete;
  tconcres.delete;

 return sbcadena;

exception when others then
  null;
end fnu_ldc_getsaldconc_orm;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNU_LDC_GETSALDCONC_ORM', 'ADM_PERSON');
END;
/