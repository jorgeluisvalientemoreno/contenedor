select sesususc,
       sesunuse,
       sesuserv || ' ' || servdesc tipo_producto,
       sesucicl,
       sesuesco || ' ' || escodesc estado_corte
from open.servsusc
left join servicio on servcodi = sesuserv
left join estacort on sesuesco = escocodi 
where sesususc = 48101390
and sesuesco not  in (92,95) 
