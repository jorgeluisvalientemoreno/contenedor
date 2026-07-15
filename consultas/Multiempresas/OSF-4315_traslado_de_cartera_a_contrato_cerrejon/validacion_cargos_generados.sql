--validacion_cargos_generados
select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesucate "Categoria" , 
       sesusuca "Subcategoria" ,
       cargconc "Concepto",
       concdesc "Desc_Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       cargtipr  "Tipo",
       sesucicl "ciclo",
       cargvalo "Valor",cargcodo "Consecutivo",
       cargdoso "Documento soporte",
       to_number(substr(cargdoso, 4, 20)) Documento_soporte,
       cargcuco,
       cargprog,
       cargfecr "Fecha cargos"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where cargnuse in (1121666)
and cargconc in (739, 1086, 203, 603, 1026)
and  trunc(cargfecr)  >= '22/08/2025'
and not regexp_like(cargdoso, '116704791|116704792|116704667|116696961')
order by cargfecr desc ;

select * from cuencobr where cucocodi = 3087286353;
 

select *
from factura  f
where f.factcodi in (2153989837)

 -- not in  ('DF-116704667', 'DF-116696961', 'ID-116696960', 'ID-116696961')


 --and  cargcuco = -1
-- and cargdoso like '%116704667%'
/*
select *
from cargos
where cargnuse = 1000650
and cargdoso  like '%116696960%'
 or  cargdoso  like '%116696961%'
order by cargfecr desc*/

 /*and cargdoso  like '%116696960%'
 or  cargdoso  like '%116696961%'*/
 
 
--and cargfecr >= '14/02/2025' 
--and cargdoso  in  ('DF-116704761', 'DF-116704760')
