select cargos.* , concepto.concdesc,concepto.concdefa, ldc_concgrvf.grupcodi grupo_visualizacion, diferido.* 
from open.cargos 
inner join open.diferido on diferido.difenuse = cargos.cargnuse
inner join open.concepto  on  diferido.difeconc  = concepto.conccodi
left join open.ldc_concgrvf on ldc_concgrvf.cogrcodi = cargos.cargconc
where diferido.difecodi = substr(cargos.cargdoso, 4, 20)
and cargos.cargcaca = 51
and cargos.cargcuco in ( select cuencobr.cucocodi from open.cuencobr where cuencobr.cucofact = 2097714163)
and cargos.cargvalo > 0
and diferido.difesape > 0
and cargos.cargpefa in (99445)
and cargos.cargconc in ( select ldc_concgrvf.cogrcodi  from open.ldc_concgrvf  where  ldc_concgrvf.grupcodi = 13 ) 
order by cargos.cargfecr desc;
