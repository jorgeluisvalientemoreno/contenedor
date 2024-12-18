create or replace function adm_person.fnuGetSaldoActCucoCierre(inunuse cuencobr.cuconuse%type,
                                                    inuano  number,
                                                    inumes  number) return number is
/*****************************************************************
    Propiedad intelectual de GC (c).

    Unidad         : fnuGetSaldoActCucoCierre
    Descripcion    : Funcion que devuelve el valor de la cartera a la fecha de un producto, pero solo de las cuentas 
                     y diferidos que tenian saldo a un cierre dado.  Si el producto se recupero, es decir que a la
                     fecha quedo con 0 o 1 cuenta con saldo, devolvera cero.
    Autor          : F.Castro
    Fecha          : 03/08/2017

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha       Autor             Modificacion
    =========   =========         ====================
    02/01/2024	cgonzalez		OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
  *****************************************************************************/

nuSaldoCorr   number;
nucuentas     number;
nuSaldoDife   number;
nuSaldo       number;
dtfecha       date;
dtfec         date;

cursor cuSaldoCorr (dtfec date) is
 select count(1),sum(cucosacu)
   from cuencobr
  where cucocodi in (select distinct(cacccuco)
                       from ic_cartcoco c
                       where c.caccfege = dtfec
                        and c.caccnuse  = inunuse
                        and c.caccnaca  = 'N')
   and cucosacu>0;
   
                        
cursor cuSaldoDife is
 select deuda_no_corriente
  from open.ldc_osf_sesucier c
 where c.nuano=inuano
   and c.numes=inumes
   and c.producto=inunuse;             

begin
 dtfec := to_Date('01/'||inumes||'/'||inuano,'dd/mm/yyyy');
 dtfecha := trunc(last_day(dtfec));

 -- halla saldo corriente a la fecha
 open cuSaldoCorr(dtfecha);
 fetch cuSaldoCorr into nucuentas, nuSaldoCorr;
 if cuSaldoCorr%notfound then
   nucuentas := 0;
   nuSaldoCorr := 0;
 end if;
 close cuSaldoCorr;
 
 -- si se recupero (cuentas con saldo es 0 o 1, devuelve cero, sino devuelve saldo diferido mas corriente 
 if nvl(nucuentas,0) <= 1 then
   nuSaldo := 0;
 else
   open cuSaldoDife;
   fetch cuSaldoDife into nuSaldoDife;
   if cuSaldoDife%notfound then
     nuSaldoDife := 0;
   end if;
   close cuSaldoDife;
    
   nuSaldo := nuSaldoCorr + nuSaldoDife;
 end if;

 return (nuSaldo);

exception when others then
  return 0;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETSALDOACTCUCOCIERRE', 'ADM_PERSON');
END;
/