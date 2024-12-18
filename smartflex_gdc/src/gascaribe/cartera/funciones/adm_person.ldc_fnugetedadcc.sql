CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETEDADCC" (nucriterio number,
                                             nunuse pr_product.product_id%type) return number is


cursor cuCuentas is
 SELECT COUNT(1)
   FROM open.cuencobr
  WHERE cucosacu >= 1
    AND cuconuse = nunuse;


cursor cuEdadMora is
  SELECT open.ldc_edad_mes(trunc(SYSDATE) - trunc(factfege))
   FROM open.cuencobr, open.factura
  WHERE cucofact = factcodi
    AND cucocodi = (select min(cucocodi)
                      from open.cuencobr
                     where cuconuse=nunuse
                       and cucosacu>0);

cursor cuEdadDeuda is
  SELECT open.ldc_edad_mes(trunc(SYSDATE) - trunc(cucofeve))
    FROM open.cuencobr
  WHERE cucocodi = (select min(cucocodi)
                      from open.cuencobr
                     where cuconuse=nunuse
                       and cucosacu>0);

nuvalor number;

begin
 if nucriterio = 1 then
   open cuCuentas;
   fetch cuCuentas into nuvalor;
   if cuCuentas%notfound then
     nuvalor := 0;
   end if;
   close cuCuentas;
 elsif nucriterio = 2 then
   open cuEdadDeuda;
   fetch cuEdadDeuda into nuvalor;
   if cuEdadDeuda%notfound then
     nuvalor := 0;
   end if;
   close cuEdadDeuda;
 else
   open cuEdadMora;
   fetch cuEdadMora into nuvalor;
   if cuEdadMora%notfound then
     nuvalor := 0;
   end if;
   close cuEdadMora;
 end if;

return (nvl(nuvalor,0));

exception when others then
 return 0;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETEDADCC', 'ADM_PERSON');
END;
/