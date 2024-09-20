-- INGRESO DE CONEXIONES
select Product_id, (select s.subscriber_name|| ' ' || s.subs_last_name
                      from open.servsusc c, open.ge_subscriber s, open.suscripc p
                     where Product_id = c.sesunuse
                       and c.sesususc = p.susccodi
                       and p.suscclie = s.subscriber_id) Nom_Producto,
       (select ss.sesucate from open.servsusc ss where ss.sesunuse = product_id) Cate,
       tipo, acta, factura, fecha, contratista, nombre, 
       Titr, (select tt.description from open.or_task_type tt where tt.task_type_id = titr) Desc_Titr,
       clctclco, clcodesc, 
       actividad, (select gt.description from open.ge_items gt where gt.items_id = actividad) Des_actividad,
       concept, (select cc.concdesc from open.concepto cc where cc.conccodi = concept) Desc_conc,
       sum(Total) Costo, sum(Ing_otro) Ing_otro, sum(Ing_Int_Mig) Ing_Int_Mig, sum(Ing_CxC_Mig) Ing_CxC_Mig, sum(Ing_RP_Mig) Ing_RP_Mig, 
       sum(ING_INT_OSF) ING_INT_OSF, sum(ING_CXC_OSF) ING_CXC_OSF, sum(ING_RP_OSF) ING_RP_OSF, 
       sum(ING_INT_CON) ING_INT_CON, sum(ING_CXC_CON) ING_CXC_CON, sum(ING_RP_CON) ING_RP_CON
  from (
select tipo, product_id, acta, titr, actividad, total, concept, estado, contratista, nombre, 
       clctclco, clcodesc, factura, fecha,
       (case when concept is not null and
                  (concept not in (19,30,291,674) or titr not in (10495,12149,12151,10622,10624,12150,12152,12153)) then
             (select sum(cargvalo) from open.cargos
              where cargnuse = product_id and cargconc = concept --and cargcaca in (41,53) and cargsign = 'DB' -- ING_INT_OSF
                and cargfecr >= '01-07-2015' and cargfecr < '01-08-2015') end) Ing_Otro,
       (case when estado is not null then -- Ingreso Interna Migrado
             (case when concept in (30,291) or titr in (10495,12149,12151/*,10606*/) then 
               (select sum(invmvain) from open.ldci_ingrevemi i
                 where i.invmsesu = product_id and i.invmconc = 30) end) 
         else
             (case when concept is null and titr in (10622, 10624) and fec_lega between '01-07-2015' and '31-07-2015' then 
               (select sum(invmvain) from open.ldci_ingrevemi i
                 where i.invmsesu = product_id and i.invmconc = 30) end)  end) Ing_Int_Mig, -- Ing_Int_Mig
       (case when estado is not null then -- Ingreso CxC Migrado
            (case when concept = 19 OR tipo = 'ANTES' then 
               (select sum(invmvain) from open.ldci_ingrevemi i
                 where i.invmsesu = product_id and i.invmconc = 19) end) end) Ing_CxC_Mig, -- Ing_CxC_Mig
       (case when estado is not null then -- Ingreso Rev. Prev. Migrado
            (case when concept = 19 OR tipo = 'ANTES'  then 
              (select sum(invmvain) from open.ldci_ingrevemi i
                where i.invmsesu = product_id and i.invmconc = 674) end) end ) Ing_RP_Mig, -- Ing_RP_Mig
       (case when estado = 'CONECTADO' then -- Interna OSF
          (case when concept in (30) then
            (select sum(cargvalo) from open.cargos
              where cargnuse = product_id and cargconc in (30) and cargcaca in (41,53) and cargsign = 'DB' -- ING_INT_OSF
                and cargfecr >= '01-07-2015' and cargfecr < '01-08-2015' and cargdoso like 'PP%') end) end) ING_INT_OSF,
       (case when estado = 'CONECTADO' then -- CXC OSF
          (case when concept in (19) then
            (select sum(cargvalo) from open.cargos
              where cargnuse = product_id and cargconc in (19) and cargcaca in (41,53) and cargsign = 'DB' -- ING_CXC_OSF
                and cargfecr >= '01-07-2015' and cargfecr < '01-08-2015' and cargdoso like 'PP%') end) end) ING_CXC_OSF, 
       (case when estado = 'CONECTADO' then  -- CERTIFICACION OSF
          (case when concept in (19) then       
            (select sum(cargvalo) from open.cargos
              where cargnuse = product_id and cargconc in (674) and cargcaca in (41,53) and cargsign = 'DB' -- ING_RP_OSF
                and cargfecr >= '01-07-2015' and cargfecr < '01-08-2015' and cargdoso like 'PP%') end) end) ING_RP_OSF, 
       -- Interna Osf CONSTRUCTORA
       (case when /*estado is not null and*/ titr in (10622, 10624) then -- CXC OSF
          --(case when concept in (30,291) then       
           (select vr_unitario 
              from (select u.product_id, sum(cargvalo / (select count(*) from open.or_order_activity
                                                          where package_id = substr(c.cargdoso,4,8)
                                                            and task_type_id in (12150/*12149,12151*/))) Vr_Unitario
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
                               AND OR_order.legalization_date >= '01-07-2015'
                               AND OR_order.legalization_date <  '01-08-2015' -- Orden de apoyo
                               AND OR_order_activity.Status = 'F') u
                    where substr(cargdoso, 1, 2) = 'PP'
                      and substr(cargdoso, 4, 8) = u.package_id
                      and cargconc = o.conccodi
                      and cargconc in (30,291) group by u.product_id) y
           where y.product_id = x.product_id)/* end)*/ end) ING_INT_CON, -- ING_INT_CON
       -- Ingresos CxC CONSTRUCTORAS
       (case when estado is not null then -- CXC OSF
          (case when concept in (19) then
           (select sum(Valor)
              from (select product_id, (cargvalo/ventas) Valor
                      from (select cargconc, cargvalo, package_id, u.product_id, 
                                   (select count(*) from open.or_order_activity
                                     where or_order_activity.package_id = u.package_id
                                       and task_type_id in (12150, 12152, 12153)) VENTAS
                              from open.cargos, 
                                   (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, aa.product_id
                                      from open.or_order_activity aa, open.mo_packages m
                                     where aa.product_id in (SELECT distinct hcecnuse
                                                               FROM open.hicaesco h
                                                              WHERE hcececan = 96
                                                                AND hcececac = 1
                                                                AND hcecserv = 7014
                                                                AND hcecfech >= '01-07-2015' and hcecfech < '01-08-2015')
                                       and aa.package_id = m.package_id 
                                       and m.package_type_id in (323, 100229)) u
                             where cargdoso in 'PP-'||package_id
                               and cargconc in (19)
                               and cargcaca in (41,53)
                           )
                   ) y
             where y.product_id = x.product_id) end) end) ING_CXC_CON, -- ING_CXC_CON
       -- Ingresos RP CONSTRUCTORAS
       (case when estado is not null then -- CXC OSF
          (case when concept in (19) then
           (select sum(Valor)
              from (select product_id, (cargvalo/ventas) Valor
                      from (select cargconc, cargvalo, package_id, u.product_id, 
                                   (select count(*) from open.or_order_activity
                                     where or_order_activity.package_id = u.package_id
                                       and task_type_id in (12150, 12152, 12153)) VENTAS
                              from open.cargos, 
                                   (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, aa.product_id
                                      from open.or_order_activity aa, open.mo_packages m
                                     where aa.product_id in (SELECT distinct hcecnuse
                                                               FROM open.hicaesco h
                                                              WHERE hcececan = 96
                                                                AND hcececac = 1
                                                                AND hcecserv = 7014
                                                                AND hcecfech >= '01-07-2015' and hcecfech < '01-08-2015')
                                       and aa.package_id = m.package_id and m.package_type_id in (323, 100229)) u
                             where cargdoso in 'PP-'||package_id
                               and cargconc in (674)
                               and cargcaca in (41,53)
                           )
                   ) y
             where y.product_id = x.product_id) end) end) ING_RP_CON -- ING_RP_CON

from ( 
      select tipo, product_id, acta, orden, titr, concept, total, clctclco, icc.clcodesc, contratista, nombre, fec_lega,
             (select oa.activity_id from open.or_order_activity oa 
               where oa.order_id = orden 
                 and oa.order_activity_id = (select min(ot.order_activity_id) from open.or_order_activity ot
                                              where ot.order_id = orden)) actividad,             
             (select 'CONECTADO' from open.hicaesco h 
               where h.hcecfech >= '01-07-2015' and h.hcecfech < '01-08-2015' and h.hcecserv = 7014
                 and h.hcecnuse = product_id and h.hcececan = 96 and h.hcececac = 1) Estado, factura, fecha
        from (
              Select  tipo, product_id, acta, factura, fecha, null orden, titr, concept, sum(total) total, contratista, nombre, 
                      fec_lega, clctclco
              from  (
                SELECT 'ACTA_F' TIPO, oa.product_id, a.id_acta acta, ac.extern_invoice_num factura, trunc(ac.extern_pay_date) fecha, 
                       a.id_orden orden, oa.task_type_id titr, 
                       ot.concept, sum(a.valor_total) Total, co.id_contratista contratista, ta.nombre_contratista nombre,
                       trunc(ro.legalization_date) fec_lega, tt.clctclco
                FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.mo_packages m, open.ge_acta ac, open.or_order ro,
                     open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
                where ac.extern_pay_date >= '01-07-2015'
                 and ac.extern_pay_date <   '01-08-2015'
                 and ac.extern_invoice_num is not null
                 and ac.id_acta   = a.id_acta
                 and a.id_orden   = oa.order_id
                 and oa.package_id = m.package_id(+)
                 and a.valor_total != 0
                 and oa.task_type_id = tt.clcttitr
                 and oa.order_id = ro.order_id
                 and oa.task_type_id = ro.task_type_id
                 and tt.clctclco not in (311,246,303)
                 and oa.task_type_id = ot.task_type_id
                 and ac.id_contrato = co.id_contrato
                 and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
                 and (it.item_classif_id != 23 or it.items_id = 4001293)
                Group by 'ACTA_F', oa.product_id, a.id_acta, ac.extern_invoice_num, a.id_orden, oa.task_type_id, ot.concept, co.id_contratista, 
                       ta.nombre_contratista, trunc(ro.legalization_date), tt.clctclco, trunc(ac.extern_pay_date)
              )
              Group by tipo, product_id, acta, factura, fecha, null, titr, concept, contratista, nombre, fec_lega, clctclco
              UNION
              select tipo, product_id, acta, factura, fecha, null orden, titr, concept, sum(total) total, contratista, nombre, 
                     fec_lega, clctclco
              from (
                SELECT 'ACTA_N' TIPO, oa.product_id, null /*a.id_acta*/ acta, null /*ac.extern_invoice_num*/ factura, 
                       /*trunc(ac.extern_pay_date)*/null  fecha, 
                       a.id_orden orden, oa.task_type_id titr, ot.concept, 
                       sum(a.valor_total) Total, co.id_contratista contratista, ta.nombre_contratista nombre,
                       trunc(ro.legalization_date) fec_lega, tt.clctclco
                FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.mo_packages m, open.ge_acta ac, open.or_order ro,
                     open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
                where (ac.extern_pay_date is null or ac.extern_pay_date > '31-07-2015 23:59:59') 
                 and ac.id_acta   = a.id_acta
                 and a.id_orden   = oa.order_id
                 and oa.package_id = m.package_id(+)
                 and a.valor_total != 0
                 and oa.task_type_id = tt.clcttitr
                 and oa.order_id = ro.order_id
                 and oa.task_type_id = ro.task_type_id
                 and tt.clctclco not in (311,246,303)
                 and oa.task_type_id = ot.task_type_id
                 and ac.id_contrato = co.id_contrato
                 and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
                 and (it.item_classif_id != 23 or it.items_id = 4001293)
                Group by 'ACTA_N', oa.product_id, a.id_acta, ac.extern_invoice_num, a.id_orden, oa.task_type_id, ot.concept, co.id_contratista, 
                       ta.nombre_contratista, trunc(ro.legalization_date), tt.clctclco, trunc(ac.extern_pay_date)
              )
              Group by tipo, product_id, acta, factura, fecha, null, titr, concept, contratista, nombre, fec_lega, clctclco
              UNION
              select tipo, product_id, acta, factura, fecha, null orden, titr, concept, sum(total) total, contratista, nombre, 
                     fec_lega, clctclco
              from (
              SELECT 'ACTA_S' TIPO, oa.product_id, null acta, null factura, null fecha, oa.order_id orden, oa.task_type_id titr, ot.concept, 
                     sum(value) Total, decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista, 
                     (select co.nombre_contratista from OPEN.GE_CONTRATISTA co 
                       where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre, 
                     trunc(r.legalization_date) fec_lega, tt.clctclco
                FROM open.or_order_activity oa, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
                     open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
               where r.legalization_date < '01-08-2015'
                 and r.order_status_id = 8
                 and r.order_id = oa.order_id
                 and r.task_type_id = oa.task_type_id
                 and oa.package_id = m.package_id(+)
                 and oa.order_id = oi.order_id
                 and value != 0
                 and oa.task_type_id = tt.clcttitr
                 and tt.clctclco not in (311,246,303)
                 and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
                 and oa.task_type_id = ot.task_type_id      
                 and oi.items_id    = it.items_id 
                 and (it.item_classif_id != 23 or it.items_id = 4001293)   
                 and r.operating_unit_id = ut.operating_unit_id
              Group by 'ACTA_S', oa.product_id, null, null, null, oa.order_id, oa.task_type_id, ot.concept,  
                       trunc(r.legalization_date), tt.clctclco, ut.contractor_id, ut.operating_unit_id
              )
              Group by tipo, product_id, acta, factura, fecha, null, titr, concept, contratista, nombre, fec_lega, clctclco
              UNION  -- COSTOS REPORTADOS MESES ANTERIORES 
              select distinct 'ANTES' tipo, h.hcecnuse product_id, null acta, NULL FACTURA, NULL FECHA, null orden, 
                     12149 titr, 0 concept, 0 Total, null contratista,  null nombre, null fec_lega, null
               from open.hicaesco h 
              where h.hcecfech >= '01-07-2015' and h.hcecfech < '01-08-2015' and h.hcecserv = 7014
                and h.hcececan = 96 and h.hcececac = 1
                and h.hcecnuse not in  
                        (select product_id
                           from (
                                SELECT distinct o.product_id
                                  FROM OPEN.ge_detalle_acta a, open.or_order_activity o, open.mo_packages m, 
                                       open.ge_acta ac, open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta
                                 where ac.extern_pay_date >= '01-07-2015'
                                   and ac.extern_pay_date <  '01-08-2015'
                                   and ac.extern_invoice_num is not null
                                   and ac.id_acta   = a.id_acta
                                   and a.id_orden   = o.order_id
                                   and o.package_id = m.package_id(+)
                                   and a.valor_total != 0
                                   and o.task_type_id = tt.clcttitr
                                   and tt.clctclco not in (311,246,303)
                                   and o.task_type_id = ot.task_type_id
                                UNION
                                SELECT distinct o.product_id
                                  FROM open.or_order_activity o, open.mo_packages m, open.or_order_items oi, 
                                       open.or_order r, open.ic_clascott tt, open.or_task_type ot
                                 where r.legalization_date < '01-08-2015'
                                   and r.order_status_id = 8
                                   and r.order_id = o.order_id
                                   and o.package_id = m.package_id(+)
                                   and o.order_id = oi.order_id
                                   and value != 0
                                   and o.task_type_id = tt.clcttitr
                                   and tt.clctclco not in (311,246,303)  
                                   and o.order_id in (select a.id_orden from OPEN.ge_detalle_Acta a, open.ge_acta ac
                                                       where a.id_orden = o.order_id and a.id_acta = ac.id_acta 
                                                         and (ac.extern_pay_date is null or ac.extern_pay_date > '31-07-2015 23:59:59'))
                                   and o.task_type_id = ot.task_type_id
                                UNION
                                SELECT distinct o.product_id
                                  FROM open.or_order_activity o, open.mo_packages m, open.or_order_items oi, 
                                       open.or_order r, open.ic_clascott tt, open.or_task_type ot
                                 where r.legalization_date < '01-08-2015'
                                   and r.order_status_id = 8
                                   and r.order_id = o.order_id
                                   and o.package_id = m.package_id(+)
                                   and o.order_id = oi.order_id
                                   and value != 0
                                   and o.task_type_id = tt.clcttitr
                                   and tt.clctclco not in (311,246,303)   
                                   and o.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = o.order_id)
                                   and o.task_type_id = ot.task_type_id
                               ) x
                         where x.product_id = h.hcecnuse)
             
             ),  open.ic_clascont icc
       where clctclco = icc.clcocodi
     ) x 
     )
--  where /*(tipo like '%ACTA%' OR (tipo = 'ANTES' and ing_int_mig != 0))
--    and product_id is  not null */
--        product_id = sesunuse
group by Product_id, tipo, acta, factura, fecha, contratista, nombre, Titr, clctclco, clcodesc, actividad, concept
