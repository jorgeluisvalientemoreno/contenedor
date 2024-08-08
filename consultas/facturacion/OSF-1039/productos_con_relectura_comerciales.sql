select s.sesunuse "Producto",
       s.sesuesco || ' -' ||  initcap (c.escodesc) "Estado_corte",
       s.sesucicl "Ciclo",
  case when s.sesucate = 1 then 'Residencial'
       when s.sesucate = 2 then 'Comercial' 
       when s.sesucate = 3 then 'Industrial' end as "Categoria", 
       s.sesusuca "Subcategoria",
       o.order_id "Orden", 
       o.task_type_id  || ' -' || initcap(t.description)  "Tipo_trabajo",
   case when  o.order_status_id = 5 then 'Asignada'
        when  o.order_status_id = 8 then 'Legalizada'
        when  o.order_status_id = 11 then 'Bloqueada'
        when  o.order_status_id = 12 then 'Anulada'
        when  o.order_status_id = 0 then 'Registrada'
        when  o.order_status_id = 7 then 'Ejecutada' end as "Estado",
        o.created_date "Fecha_creacion",
       (select max(pc2.pecscons)
       from open.pericose pc2 
       where pc.pecscico= pc2.pecscico
       and pc2.pecscons < pc.pecscons 
       and pc2.pecsfecf < pc.pecsfeci 
       and pc2.pecsfeci = (select max(pc3.pecsfeci)
       from open.pericose pc3 where pc2.pecscico= pc3.pecscico
        and pc3.pecscons < pc.pecscons and pc3.pecsfecf < pc.pecsfeci ))"Periodo_cons_ant",
        l.leempecs "Periodo_cons_act",
        l.leempefa "Periodo_fact", 
        l.leemlean "Lect_ant",
        l.leemfela "Fecha_lect_ant",
        l.leemleto "Lect_act",
        l.leemfele "Fecha_lect_act",
case when  (select sum (hcppcopr)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco = (select LDC_PKFAAC.fnuGetPericoseAnt(l.leempefa) from dual) ) > 0 then 'si_cpp' 
    when   (select sum (hcppcopr )
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  (select LDC_PKFAAC.fnuGetPericoseAnt(l.leempefa) from dual )  ) = 0 then 'No_cpp' end as cons_pp,  
       o.legalization_date "Fecha_legalizacion"
from open.or_order o
inner join open.or_task_type t  on t.task_type_id =o.task_type_id
left join open.or_order_activity a1 on o.order_id = a1.order_id 
left join open.servsusc s on s.sesunuse = a1.product_id 
left join open.lectelme l on l.leemdocu = a1.order_activity_id 
left join open.pericose pc on  pc.pecscico = s.sesucicl and l.leempecs = pc.pecscons
left join open.estacort c on c.escocodi = s.sesuesco
where s.sesucate = 2 
and o.task_type_id = 10043
and  o.order_status_id in (0,5)
and s.sesuesco <> 2
and l.leemleto is not null 
