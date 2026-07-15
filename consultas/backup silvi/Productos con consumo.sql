--busqueda de contrato con varios productos y consumo
  Select s.sesususc,   c.cargnuse, pp.product_type_id,s.sesuesfn ,  se.servdesc,  c.cargconc,
         t.concdesc,c.cargvalo, c.cargcaca, ca.cacadesc,
         c.cargsign, c.cargcuco,c.cargpefa,c.cargunid, c.cargfecr, s.sesuesco, s.sesucate, c.cargcaca
    From cargos  c, servsusc  s,concepto  t, causcarg ca, pr_product pp, servicio se 
    Where c.cargnuse = s.sesunuse
    and   c.cargconc = t.conccodi
    and   c.cargcaca = ca.cacacodi
    and   s.sesunuse = pp.product_id
    and   pp.product_type_id = se.servcodi
    and   pp.product_type_id in (7055, 7014)
    and   c.cargpefa = 99413
    and   c.cargvalo > 0
  --  and  c.cargcaca in( 15)
   -- and c.cargconc in (31) 
    and s.sesususc in (  48252472) 
     order by c.cargfecr desc


--48252461,48252509
-- 48252507, 48252509, 48252767, 48252497, 48252515, 48252866
