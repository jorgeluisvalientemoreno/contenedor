with fact as(
select /*+ index(fa IX_FACTURA06) */  factcodi
from open.factura fa
where fa.factsusc in (select distinct sesususc from open.ldc_ordenes_costo_ingreso co, open.servsusc where nuano=2018 and numes=10 and product_id is not null and sesunuse=product_id)
  and fa.factfege>='01/10/2018'),
cuentas as
(
select /*+ index(cuencobr IDXCUCO_RELA) */   cucocodi 
from open.cuencobr
inner join fact on fact.factcodi=cucofact)
select /*+ index(cargos IX_CARGOS02) */ cargnuse, cargconc, cargdoso, cargcodo,sum(cargvalo) valor 
from open.cargos
inner join cuentas on cuentas.cucocodi=cargcuco
where cargsign='DB'
  and cargtipr='A'
  and cargcaca in (41, 53)
  and cargconc not in (19,30,291,674)
group by cargnuse, cargconc, cargdoso, cargcodo  

