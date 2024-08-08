 select sesususc "Contrato" , sesunuse "Producto" , sesuserv "Tipo_producto" ,
 sesucate || ' - ' || Initcap(su.sucadesc) "Categoria"   ,sesusuca "Subcategoria", sesuesco "Estado de corte",coecfact "Facturable?", sesuesfn "Estado financiero",susccemf , susccemd, susccoem
from servsusc
left join categori on sesucate = catecodi
left join subcateg su on sucacate = sesucate and su.sucacodi= sesusuca
left join confesco on sesuesco = coeccodi and coecserv =sesuserv
left join suscripc on susccodi=sesususc 
where  coecfact='S' and sesucate in (3) and sesuserv <> 6121  ;

