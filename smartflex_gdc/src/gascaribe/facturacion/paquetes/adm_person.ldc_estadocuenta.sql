CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_ESTADOCUENTA is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCCREG_B
    Descripcion    : Paquete donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

TYPE rcConc IS RECORD(
    cargsusc number,
    cargnuse NUMBER,
    cargcuco NUMBER,
    cargconc NUMBER,
    cargvalo NUMBER,
    cargescc varchar2(1),
    cargvapa NUMBER,
    cargapsa NUMBER,
    cargnota NUMBER,
    cargsafa NUMBER,
    cargsald NUMBER);

  TYPE tbconc IS TABLE OF rcconc INDEX BY varchar2(14);
  tconc tbconc;
  sbindice varchar2(14);
---
 TYPE rcConcRes IS RECORD(
    cargsusc number,
    cargnuse NUMBER,
    cargconc NUMBER,
    cargvalo NUMBER,
    cargvrve NUMBER,
    cargvrnv NUMBER,
    cargvapa NUMBER,
    cargapsa NUMBER,
    cargdife number);

  TYPE tbconcres IS TABLE OF rcconcres INDEX BY varchar2(24);
  tconcres tbconcres;
  nuindice varchar2(24);
---
 nusaldocc number := 0;
 sbcadena varchar2(4000) := null;
 sbError varchar2(1000) := '-1;-1;-1;-1;-1;-1;-1;-1;';

 nusesion number;

 gnususc servsusc.sesususc%type;
 gnunuse servsusc.sesunuse%type;
 gnucuco cuencobr.cucocodi%type;

 cursor cucargos is
  select cargnuse,cargcuco,cargconc,
         case when cucofeve < sysdate then 'V' else 'N' end estadocc,
         sum(decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo)) cargvalo
    from cargos, cuencobr, servsusc
   where cargcuco=cucocodi
     and sesunuse=cuconuse
     and sesususc = gnususc
     and cuconuse = decode(gnunuse,-1,cuconuse,gnunuse)
     and cucocodi = decode(gnucuco,-1,cucocodi,gnucuco)
     and cucosacu > 0
     and cargconc not in (9,145,123)
   group by cargnuse,cargcuco,cargconc,cucofeve
   order by cargnuse,cargcuco,cargconc;




 cursor cucargosres is
  select sesususc, sesunuse, cargconc, 0 cargvalo
    from cargos, cuencobr, servsusc
   where cargcuco=cucocodi
     and sesunuse=cuconuse
     and sesususc = gnususc
     and cuconuse = decode(gnunuse,-1,cuconuse,gnunuse)
     and cucocodi = decode(gnucuco,-1,cucocodi,gnucuco)
     and cucosacu > 0
     and cargconc not in (9,145,123)
   group by sesususc, sesunuse, cargconc
   order by sesususc, sesunuse, cargconc;



  cursor cucuentas is
  select distinct(cucocodi) cucocodi
    from cuencobr, servsusc
   where sesunuse=cuconuse
     and sesususc = gnususc
     and cuconuse = decode(gnunuse,-1,cuconuse,gnunuse)
     and cucocodi = decode(gnucuco , -1, cucocodi, gnucuco)
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

------------------------------

nuconc number;
nuapsa number;
nusald number;
nuvapa number;

function fnu_ldc_EstCtaCCconAS (inususc servsusc.sesususc%type,
                                                 inunuse servsusc.sesunuse%type,
                                                 inucuco cuencobr.cucocodi%type) return number;

procedure prGenEdoCtaConAS (isbResumen in varchar2) ;

function fnuCuentaconAS (inucuenta number) return varchar2;

procedure prRecorreLista (sbtexto in varchar);

function fnugetsaldocc (inucuenta number) return number;

function fsbdescconc (inuconce number) return varchar;

procedure prAplicaAs (inucuenta number,  inusaldo number, inucargoas number);

end LDC_ESTADOCUENTA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_ESTADOCUENTA is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_ESTADOCUENTA
    Descripcion    : Paquete que genera Estado de Cuenta a la fecha de un Contrato/Producto/Cuenta de cobro
    Autor          : F.Castro
    Fecha          : 06/08/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
*/




---------------------------------------------------------------------------------------------------------
function fnu_ldc_EstCtaCCconAS (inususc servsusc.sesususc%type,
                                                 inunuse servsusc.sesunuse%type,
                                                 inucuco cuencobr.cucocodi%type) return number is
 PRAGMA AUTONOMOUS_TRANSACTION;
/***************************************************************************
  Funcion: fnu_ldc_EstCtaCCconAS

  Descripcion:    Para hallar cuentas que hayan tenido cargos AS. Obtiene el saldo a la fecha por Cuenta y Concepto de un Contrato/Producto
                  (Cuando la cadena devuelta tiene menos de 4000 caracteres se puede usar
                  la funcion fnu_ldc_EstCtaCCobro.
                  Esta funcion es para cuando la cadena tiene mas de 4000 caracteres (el orm
                  devuelve un solo registro con los campos -1).

  Autor: F.Castro
  Fecha: Agosto 6 de 2018

  Parametros
  inususc       Contrato
  inusesu      Producto o -1 para todos los productos
  inucuco      Cuenta o -1 para todas las cuentas con saldo del producto

  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================


  ***************************************************************************/


begin
   tconc.delete;
   nusesion := 0;
   gnususc := inususc;
   gnunuse := inunuse;
   gnucuco := inucuco;

  select USERENV('sessionid') into nusesion from dual;
  delete from LDC_EDOCTA where sesion = nusesion;
  commit;

  -- prRecorrelista('Iniciando');

   prGenEdoCtaConAS('N');

  sbIndice :=  tconc.first;
    loop exit when (sbIndice IS null);
       if tconc(sbIndice).cargconc != 123 then
           insert into LDC_EDOCTA (sesion, contrato, producto, cuenta, concepto, valorini,
                                   valornotas, valorabo, valoraps, valorsafa, valorfin, fechaeje )
                                  values (nusesion,
                                          tconc(sbindice).cargsusc,
                                          tconc(sbindice).cargnuse,
                                          tconc(sbIndice).cargcuco,
                                          tconc(sbIndice).cargconc,
                                          tconc(sbIndice).cargvalo,
                                          tconc(sbIndice).cargnota,
                                          tconc(sbIndice).cargvapa,
                                          tconc(sbIndice).cargapsa,
                                          tconc(sbIndice).cargsafa,
                                          tconc(sbIndice).cargsald,
                                          SYSDATE);
       end if;

            sbIndice := tconc.next(sbIndice);
    end loop;
    COMMIT;

  tconc.delete;
 return nusesion;

exception when others then
 --dbms_output.put_line(DBMS_UTILITY.format_error_backtrace||' Codigo Error: '||SQLCODE);
 return -1;
end fnu_ldc_EstCtaCCconAS;

-------------------------------------------------------------------------------------
procedure prGenEdoCtaConAS (isbResumen in varchar2) is

   sbIndex2 varchar2(14);

cursor cucargosCtAs is
  select factcodi,factfege,cargnuse,cargcuco,cargconc,cargcodo,cucofeve,cargsign, cargfecr,
         case when cucofeve < sysdate then 'V' else 'N' end estadocc,
         decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
    from cargos, cuencobr, servsusc, factura
   where cargcuco=cucocodi
     and sesunuse=cuconuse
     and factcodi=cucofact
     and sesususc = gnususc
     and cuconuse = decode(gnunuse,-1,cuconuse,gnunuse)
     and cucocodi = decode(gnucuco,-1,cucocodi,gnucuco)
    ---------- and fnuCuentaconAS(cargcuco) = 'S'
 --  and cargconc != 123 -- 9 AS   123 SA   145  PA
   and factfege > '01-02-2015'
  --   and cargconc not in (9,145,123)
   order by cargnuse,cargcuco,cargfecr;




begin

  -- carga saldos de conceptos por cuenta
   for rg in cucargosCtAs loop
     sbindice := lpad(rg.cargcuco, 10, '0') || lpad(rg.cargconc, 4, '0');
     if not tconc.EXISTS(sbindice) THEN
        tconc(sbindice).cargsusc := gnususc;
        tconc(sbindice).cargnuse := rg.cargnuse;
        tconc(sbindice).cargcuco := rg.cargcuco;
        tconc(sbindice).cargconc := rg.cargconc;
        tconc(sbindice).cargescc := rg.estadocc;
        tconc(sbindice).cargvalo := 0;
        tconc(sbindice).cargvapa := 0;
        tconc(sbindice).cargapsa := 0;
        tconc(sbindice).cargnota := 0;
        tconc(sbindice).cargsafa := 0;
        tconc(sbindice).cargsald := 0;
        --   prRecorreLista ('Insert');
     end if;

     if rg.cargsign in ('DB','CR'/*,'SA'*/) and rg.cargfecr <= (rg.factfege + 0.00025) then -- CARGOS DE LA FACT
        tconc(sbindice).cargvalo := tconc(sbindice).cargvalo + rg.cargvalo;
        tconc(sbindice).cargsald := tconc(sbindice).cargsald + rg.cargvalo;
        --   prRecorreLista ('Insert');
     elsif rg.cargsign in ('DB','CR'/*,'SA'*/) and rg.cargfecr > (rg.factfege + 0.00025) then  -- NOTAS
        tconc(sbindice).cargnota := tconc(sbindice).cargnota + rg.cargvalo;
        tconc(sbindice).cargsald := tconc(sbindice).cargsald + rg.cargvalo;
     elsif rg.cargsign = 'PA' then
        -- prRecorreLista ('Antes de Pago' );
        for rg3 in curesureca(rg.cargcodo, rg.cucofeve) loop
          sbindice := lpad(rg.cargcuco, 10, '0') || lpad(rg3.rereconc, 4, '0');
          if tconc.EXISTS(sbindice) THEN
             tconc(sbindice).cargvapa := tconc(sbindice).cargvapa + rg3.rerevalo;
             tconc(sbindice).cargsald := tconc(sbindice).cargsald - rg3.rerevalo;
             nuconc := rg3.rereconc;
             nuvapa := tconc(sbindice).cargvapa;
             nusald := tconc(sbindice).cargsald;
          end if;
        end loop;
    --     prRecorreLista ('Despues de Pago');
       elsif rg.cargsign = 'AS' then
      --   prRecorreLista ('Antes de AS' );
         nusaldocc := fnugetsaldocc(rg.cargcuco);
         if nusaldocc > 0 then
           prAplicaAs(rg.cargcuco, nusaldocc, rg.cargvalo);
         end if;
      --   prRecorreLista ('Despues de AS');
      elsif rg.cargsign = 'SA'  then  -- GENERACION DE SALDO A FAVOR
        tconc(sbindice).cargsafa := tconc(sbindice).cargsafa + rg.cargvalo;
        tconc(sbindice).cargsald := tconc(sbindice).cargsald + rg.cargvalo;
    end if;
  end loop;



end prGenEdoCtaConAS;

-------------------------------------------------------------------------------------
function fnugetsaldocc (inucuenta number) return number is

  sbIndex varchar2(14);
  nusaldo number := 0;

begin
  sbIndex :=  tconc.first;
  loop exit when (sbIndex IS null);
     if tconc(sbIndex).cargcuco = lpad(inucuenta, 10, '0') then
       nusaldo := nusaldo + tconc(sbIndex).cargsald;
     end if;
     sbIndex := tconc.next(sbIndex);
  end loop;
  return (nusaldo);
end fnugetsaldocc;

-------------------------------------------------------------------------------------
procedure prRecorreLista (sbtexto in varchar) is

  sbIndex varchar2(14);
  nurows number := 0;

begin
  nurows := tconc.count;
  dbms_output.put_line(sbtexto || '  ' || nurows);
  sbIndex :=  tconc.first;
  loop exit when (sbIndex IS null);
     dbms_output.put_line('cuco ' || tconc(sbIndex).cargcuco || '  conc ' || tconc(sbIndex).cargconc || '  valo ' || tconc(sbIndex).cargvalo ||
                         '  vapa ' || tconc(sbIndex).cargvapa || '  apsa ' || tconc(sbIndex).cargapsa || '  sald ' || tconc(sbIndex).cargsald);
     sbIndex := tconc.next(sbIndex);
  end loop;

end prRecorreLista;
-------------------------------------------------------------------------------------
function fnuCuentaconAS (inucuenta number) return varchar2 is

sbExiste varchar2(1);

CURSOR cuCuentaConAS is
 select 'S'
  from cargos
 where cargcuco = inucuenta
   and cargsign ='AS';

begin
  open cuCuentaConAS;
  fetch cuCuentaConAS into sbExiste;
  if cuCuentaConAS%notfound then
    sbExiste := 'N';
  end if;
  close cuCuentaConAS;

  return nvl(sbExiste,'N');

exception when others then
  return ('N');
end fnuCuentaconAS;
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
end fsbdescconc;
-------------------------------------------------------

procedure prAplicaAs (inucuenta number,  inusaldo number, inucargoas number) is

  sbIndex varchar2(14);
  nuvlrapli number := 0;

begin
  --dbms_output.put_line('inucuenta ' || inucuenta || ' inusaldo  ' || inusaldo || '  inucargoas ' || inucargoas   );
  sbIndex :=  tconc.first;
  loop exit when (sbIndex IS null);
     if tconc(sbIndex).cargcuco = lpad(inucuenta, 10, '0') then
     nuconc := tconc(sbIndex).cargconc;
     nuapsa := tconc(sbIndex).cargapsa;
     nusald := tconc(sbIndex).cargsald;
 --   dbms_output.put_line(nuconc || '  ' || nusald);
       nuvlrapli := round(inucargoas * (tconc(sbIndex).cargsald * 100 / inusaldo) / 100,0);
       tconc(sbIndex).cargapsa := tconc(sbIndex).cargapsa  + (nuvlrapli*-1);
       tconc(sbIndex).cargsald :=  tconc(sbIndex).cargsald + nuvlrapli;
     end if;
     nuconc := tconc(sbIndex).cargconc;
     nuapsa := tconc(sbIndex).cargapsa;
     nusald := tconc(sbIndex).cargsald;
     sbIndex := tconc.next(sbIndex);
  end loop;
exception when others then
  NULL;
 -- dbms_output.put_line(DBMS_UTILITY.format_error_backtrace||' Codigo Error: '||SQLCODE);
end prAplicaAs;


end LDC_ESTADOCUENTA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ESTADOCUENTA', 'ADM_PERSON');
END;
/
