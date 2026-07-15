select difesusc,difenuse,sesuserv,difeconc, t.concdesc,t.conccore,difevatd ,difesape, difeinte,difesign,difeprog,difenucu,difecupa,c.cargpefa   
from servsusc s
inner join diferido on sesunuse = difenuse 
inner join cargos c on c.cargnuse = s.sesunuse
inner join concepto  t on  difeconc = t.conccodi
where difesape > 0 
and difefein > to_date('01/01/2020')
and (select count (1)
     from diferido dd
     where  s.sesunuse = dd.difenuse
     and dd.difesape > 0 and dd.difeprog = 'GCNED') >0
and (select count (1)
     from pr_product p
     where  s.sesunuse = p.product_id
     and p.product_type_id = 7014 ) >0
and  c.cargvalo > 0
and  c.cargcaca in (15)
and c.cargconc in ( 196,167)
--and difeprog not in ('GCNED')
and cargpefa= 99413
and sesususc = 48252391
-- and sesuserv = 7014 ;
