--validacion_cargos_generados
select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesucate "Categoria" , 
       sesusuca "Subcategoria" ,
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       cargtipr  "Tipo",
       sesucicl "ciclo",
       cargvalo "Valor",cargcodo "Consecutivo",
       cargdoso "Documento soporte",
       cargfecr "Fecha cargos"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where cargnuse in (13000636)
and cargfecr >= '15/08/2024' 
order by cargfecr desc 


 
--
--cambiar fechas cargos
  
/*update cargos  c  
  set c.cargfecr = '30/07/2024'  
    where c.cargnuse in (50112751,51647830,50107555,50664187,1023211,1000486,50117155,1999951,50665780,50682652,6102952) 
     and  c.cargfecr = '30/06/2024' */
