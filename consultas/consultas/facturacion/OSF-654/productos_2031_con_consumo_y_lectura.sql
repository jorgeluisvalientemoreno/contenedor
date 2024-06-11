select sesususc          contrato,
       sesunuse          producto,
       sesuesco ||'- ' || escodesc         estado_corte,
       pr.product_status_id || ' - ' || ps.description  estado_producto,
       sesuserv          tipo_serv,
       sesufein          fecha_instal,
       sesucate ||' ' ||  c.catedesc         categoria,
       sesusuca || ' ' ||   su.sucadesc       subcategoria,
       a.geograp_location_id  localidad,
       sesucicl          ciclo, 
       l.leempecs       Periodo_cons,
       p.pecsfeci, 
       p.pecsfecf,
       (select extract(month from p.pecsfecf) from dual) as Mes_cons,
       oo.order_id        orden , 
       oo.task_type_id  tipo_trab,
       oo.order_status_id  status,
       oo.created_date 
from open.servsusc s
left join open.pr_product pr on s.sesunuse = pr.product_id and s.sesususc = pr.subscription_id 
left join open.ab_address a on  pr.address_id = a.address_id 
left join estacort on escocodi = sesuesco
left join ps_product_status ps on ps.product_status_id = pr.product_status_id
left join categori c on c.catecodi = s.sesucate 
left join subcateg su on   su.sucacate = s.sesucate  and s.sesusuca =  su.sucacodi 
left join or_order_activity r on r.subscription_id = sesususc and r.product_id = sesunuse
left join or_order oo on oo.order_id = r.order_id and oo.external_address_id  = a.address_id 
left join lectelme l on r.order_activity_id = l.leemdocu 
left join pericose p on p.pecscons = l.leempecs and sesucicl = p.pecscico
where sysdate - sesufein < 180
and sesuserv = 7014
and sesucate = 1 
and  oo.task_type_id in (12617)
and  oo.order_status_id in (0,5)
and  exists ( select null 
            from open.ldc_coprsuca co 
            where co.cpscubge = a.geograp_location_id 
            and co.cpsccate = s.sesucate 
            and co.cpscsuca = s.sesusuca
            and co.cpscanco = (select extract(year from p.pecsfecf) from dual)
            and co.cpscmeco = (select extract(month from P.pecsfecf) from dual ) ) 
and exists ( select null 
            from open.conssesu c 
            where c.cosssesu = s.sesunuse 
            and cosscoca > 0 ) 
and exists ( select null
            from open.lectelme l 
            where leemsesu = sesunuse 
            and leemclec = 'F')    
and exists ( select null
             from open.or_order o 
            left join open.or_order_activity a on o.order_id = a.order_id 
            where a.subscription_id = sesususc 
            and a.product_id = sesunuse 
            and o.task_type_id = 12617 
            and o.order_status_id in (0,5))
and not exists ( select null
                from hicoprpm h
                where h.hcppsesu = sesunuse 
                and h.hcpppeco= l.leempecs 
                and hcpppeco =  p.pecscons ) 
order by sesufein desc 
           
            