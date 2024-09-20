-- COSTOS vs INGRESOS - DEFINITIVO
Select * from (
select Tipo, hcecnuse, sum(total) costo,
       -- Ingreso Interna Migrado
       (case when nvl(Interna, 0) = 0 then 
         (select invmvain from open.ldci_ingrevemi i where i.invmsesu = hcecnuse and i.invmconc = 30)
       ELSE
         0 End)  Ing_Int_Mig,
       -- Ingreso CxC Migrado
       (select invmvain from open.ldci_ingrevemi i where i.invmsesu = hcecnuse and i.invmconc = 19) Ing_CxC_Mig,
       --
       (select invmvain from open.ldci_ingrevemi i where i.invmsesu = hcecnuse and i.invmconc = 674) Ing_RP_Mig,
       -- Interna Osf
       (Case When nvl(Interna,0) != 0 then Interna Else
       (select vr_unitario from (
        select o.concdesc, product_id, (cargvalo / (select count(*) from open.or_order_activity
                                                     where package_id = substr(c.cargdoso,4,8)
                                                       and task_type_id = 12149)) Vr_Unitario
          from open.cargos c, open.concepto o, 
               (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id 
                  FROM open.OR_related_order, open.OR_order_activity, open.or_order, 
                       open.mo_packages, open.ge_items i
                 WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                   AND OR_related_order.related_order_id = OR_order_activity.order_id
                   AND OR_order_activity.Status = 'F'
                   AND OR_order_activity.package_id = mo_packages.package_id
                   AND OR_order_activity.task_type_id in (10622, 10624)
                   AND mo_packages.package_type_id in (323, 100229) 
                   AND OR_order.order_id = OR_related_order.related_order_id
                   AND OR_order.legalization_date >= '01-05-2015'
                   AND OR_order.legalization_date <  '01-06-2015' -- Orden de apoyo
                   AND OR_order_activity.Status = 'F') u
        where substr(cargdoso, 1, 2) = 'PP'
          and substr(cargdoso, 4, 8) = u.package_id
          and cargconc = o.conccodi
          and cargconc = 30)
       where product_id = hcecnuse)end) Int_Const,
       -- Ingresos OSF, CxC y RP
       (select sum(Valor)
          from (select product_id, sesucate, sesusuca, cargconc, concdesc, (cargvalo/ventas) Valor
                  from (select cargconc, cargvalo, package_id, u.product_id, 
                               (select count(*) from open.or_order_activity
                                where or_order_activity.package_id = u.package_id
                                 and task_type_id in (12150, 12152, 12153)) VENTAS
                          from open.cargos, 
                               (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id
                                  from open.or_order_activity a, open.mo_packages m
                                 where a.product_id in (SELECT distinct hcecnuse
                                                         FROM open.hicaesco h
                                                        WHERE hcececan = 96
                                                          AND hcececac = 1
                                                          AND hcecserv = 7014
                                                          AND hcecfech >= '01-05-2015' and hcecfech < '01-06-2015'
                                                          AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1)
                                  and a.package_id = m.package_id and m.package_type_id in (323, 100229)) u
                         where cargdoso in 'PP-'||package_id
                           and cargconc in (19, 674)
                       ), open.concepto, open.servsusc, open.suscripc
                  where sesunuse = product_id
                    and sesususc = susccodi
                    and cargconc = conccodi)
                 where product_id = hcecnuse) CXC_Const,
      (select sum(cargvalo) from open.cargos
        where cargnuse = hcecnuse and cargconc in (19) and cargcaca = 53 and cargsign = 'DB') CXC_OSF,
      (select sum(cargvalo) from open.cargos
        where cargnuse = hcecnuse and cargconc in (30) and cargcaca = 53 and cargsign = 'DB') INT_OSF,
      (select sum(cargvalo) from open.cargos
        where cargnuse = hcecnuse and cargconc in (674) and cargcaca = 53 and cargsign = 'DB') RP_OSF                
 from 
      (
        SELECT hcecnuse, id_acta acta, id_orden orden, task_type_id titr, sum(valor_total) Total, 0 INTERNA, 'SERV_CUMP' Tipo
          FROM OPEN.ge_detalle_acta a, open.or_order_activity o, open.hicaesco h, open.mo_packages m
         where hcececan =  96
           and hcececac =  1
           and hcecfech >= '01-05-2015'
           and hcecfech <  '01-06-2015'
           and hcecserv =  7014
           and hcecnuse =  o.product_id
           and o.package_id = m.package_id
           and m.package_type_id in (323, 271, 100271, 100229)
           and o.order_id = a.id_orden
        group by hcecnuse, id_acta, id_orden, task_type_id
        UNION ALL
        SELECT hcecnuse, 0 acta, o.order_id orden, task_type_id titr, sum(value) Total, 0 INTERNA, 'SERV_CUMP' Tipo
          FROM open.or_order_activity o, open.hicaesco h, open.mo_packages m, open.or_order_items i
         where hcececan =  96
           and hcececac =  1
           and hcecfech >= '01-05-2015'
           and hcecfech <  '01-06-2015'
           and hcecserv =  7014
           and hcecnuse =  o.product_id
           and o.package_id = m.package_id
           and m.package_type_id in (323, 271, 100271, 100229)
           and o.order_id = i.order_id
           and value != 0
           and o.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = o.order_id)
        group by hcecnuse, o.order_id, task_type_id
        UNION ALL
        select o.product_id, id_acta acta, id_orden orden, task_type_id titr, sum(valor_total) Total, INTERNA, 'SOLO_INTER' Tipo
          from OPEN.ge_detalle_acta a, open.or_order_activity o, open.mo_packages m,
               (-- INTERNA UNIFICADA MIG - OSF
                SELECT product_id, (case when nvl(Interna_S,0) > 0 then INTERNA_S
                                         else Interna_M end) INTERNA
                  FROM 
                       (
                        select product_id,
                               (select (cargvalo/(select count(*) from open.or_order_activity
                                                   where package_id = substr(c.cargdoso,4,8)
                                                     and task_type_id = 12150))
                                  from open.cargos c
                                 where substr(cargdoso, 1, 2) = 'PP'
                                   and substr(cargdoso, 4, 8) = package_id
                                   and cargconc = 30) Interna_S, -- INTERNA OSF
                               (SELECT sum(invmvain)
                                  from open.Ldci_Ingrevemi m
                                 where m.invmsesu = product_id
                                   AND m.invmconc in (30)
                                group by m.invmsesu) Interna_M -- INTERNA MIGRADA
                          from 
                               (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id
                                  FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages, open.ge_items i
                                 WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                                   AND OR_related_order.related_order_id = OR_order_activity.order_id
                                   AND OR_order_activity.Status = 'F'
                                   AND OR_order_activity.package_id = mo_packages.package_id
                                   AND OR_order_activity.task_type_id in (10622, 10624)
                                   AND mo_packages.package_type_id in (323, 100229, 100271) 
                                   AND OR_order.order_id = OR_related_order.related_order_id
                                   AND OR_order.legalization_date >= '01-05-2015'
                                   AND OR_order.legalization_date <  '01-06-2015' -- Orden de apoyo
                                   AND OR_order_activity.Status = 'F') u
                       )
                 ) u
         where u.product_id = o.product_id
           and o.package_id = m.package_id
           and o.order_id = a.id_orden
           and valor_total != 0
           and task_type_id in (10622, 10624)
        Group by o.product_id, id_acta, id_orden, task_type_id, Interna
    --   order by o.product_id, titr, orden
    )   
group by TIPO, hcecnuse, Interna
)
