select sesususc "Contrato"  , sesunuse "Producto"  , sesuserv || ' -'  || initcap(servdesc)  "Tipo_producto"
from servsusc s1
left join servicio s on s.servcodi= sesuserv
where  exists  ( select null from servsusc s2 where s1.sesususc = s2.sesususc and  s2.sesuserv = 7057)
 order by sesususc