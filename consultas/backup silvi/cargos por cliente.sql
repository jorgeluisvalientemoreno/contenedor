select subs_last_name || ' ' || subscriber_name   as cliente ,sesususc,(select cucofact from cuencobr where cucocodi =cargcuco) factura,cargpefa,
          sesusuca|| ' ' || sucadesc  subcategoria , sesucate || ' ' ||catedesc   categoria,sesuplfa ||' ' || plsudesc plan  ,cargnuse  ,
          cargconc || '  ' || concdesc as concepto,cargcaca, cargsign || ' ' || signdesc signo  , cargunid , cargvalo, cargdoso, cargfecr  
from cargos c
left  join servsusc on cargnuse = sesunuse
left join subcateg on sucacate = sesucate and sucacodi = sesusuca
left join categori on catecodi = sesucate 
left join concepto on cargconc =  conccodi
left join plansusc on sesuplfa = plsucodi 
left join pr_product pr on sesunuse = product_id and cargnuse = product_id 
left join suscripc s on susccodi = sesususc 
left join ge_subscriber ge  on subscriber_id = suscclie 
left join signo on signcodi = cargsign 
where cargpefa in (101412,101414) 
and cargconc in (31) 
and cargdoso like '%CO%PR%'
UNION
select subs_last_name || ' ' || subscriber_name   as cliente ,sesususc,(select cucofact from cuencobr where cucocodi =cargcuco) factura,cargpefa,
          sesusuca|| ' ' || sucadesc  subcategoria , sesucate || ' ' ||catedesc   categoria,sesuplfa ||' ' || plsudesc plan  ,cargnuse  ,
          cargconc || '  ' || concdesc as concepto,cargcaca, cargsign || ' ' || signdesc signo  , cargunid , cargvalo, cargdoso, cargfecr  
from cargos c
left  join servsusc on cargnuse = sesunuse
left join subcateg on sucacate = sesucate and sucacodi = sesusuca
left join categori on catecodi = sesucate 
left join concepto on cargconc =  conccodi
left join plansusc on sesuplfa = plsucodi 
left join pr_product pr on sesunuse = product_id and cargnuse = product_id 
left join suscripc s on susccodi = sesususc 
left join ge_subscriber ge  on subscriber_id = suscclie 
left join signo on signcodi = cargsign 
where cargpefa in (101412,101414) 
and cargconc in (31) 
and cargdoso like '%CO%'
and (select count ( distinct (cargdoso)) from cargos c2
           where c2.cargnuse = c.cargnuse 
           and c2.cargdoso like '%CO%PR%')  > 0
and abs(( select sum (cc.cargvalo) 
      from cargos cc
      where cc.cargnuse = c.cargnuse 
      and cc.cargpefa = c.cargpefa 
      and cc.cargconc = 31
      and cc.cargsign = 'DB'
      and CC.cargdoso like '%CO%' ) - ( select sum (ccc.cargvalo) 
                                  from cargos ccc
                                  where ccc.cargnuse = c.cargnuse 
                                  and ccc.cargpefa = c.cargpefa 
                                  and ccc.cargconc = 31
                                  and ccc.cargsign = 'CR' )) > 3000

                                



