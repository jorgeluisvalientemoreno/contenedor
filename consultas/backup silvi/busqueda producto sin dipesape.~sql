--busqueda de contrato con varios productos y subsidios
Select s.sesususc,   c.cargnuse, pp.product_type_id, se.servdesc,  c.cargconc,
 t.concdesc,t.conccore,conccoin,c.cargvalo, c.cargcaca, ca.cacadesc, c.cargsign, c.cargcuco,c.cargpefa,    
 c.cargunid, c.cargfecr, s.sesuesco, s.sesuesfn 
From cargos  c,
     servsusc  s,
     concepto  t,
     causcarg ca,
     pr_product pp,
     servicio se 
Where c.cargnuse = s.sesunuse
And   c.cargconc = t.conccodi
and   c.cargcaca = ca.cacacodi
and   s.sesunuse = pp.product_id
and   pp.product_type_id = se.servcodi
and   pp.product_type_id in (7055)
/*and   c.cargpefa = 99413*/
and   c.cargvalo > 0
and not  exists
(Select null
from diferido d
inner join pr_product p on p.product_id = d.difenuse
Where c.cargnuse = d.difenuse
and  p.product_type_id = 7014 and d.difesape > 0) 
and not  exists
(Select null
from diferido dd
Where c.cargnuse = dd.difenuse
and   dd.difesape > 0 and dd.difeprog = 'GCNED' ) 
and not exists ( select null
 from ldc_osf_sesucier l
 where l.producto = c.cargnuse  and l.nuano =2022 
 and  l.numes= 4
 AND l.edad_deuda > 90 )
order by c.cargfecr desc


/*and not exists ( select null
 from ldc_osf_sesucier l
 where l.producto = c.cargnuse  and l.nuano =2022 
 and  l.numes= 4
 AND l.edad_deuda > 90 )*/
/* and   s.sesususc = 17173410*/
/*and not exists
(select null 
from cargos ca
where ca.cargcuco = c.cargcuco
and ca.cargconc in ( 196,167) )*/
select * 
from cargos c
where c.cargconc in ( 196,167)



