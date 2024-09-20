select id_Acta,
       --d.descripcion_items,
       Nit, Nombre,
       (select distinct m.package_type_id||' - '||ps.description from open.or_order_activity a, open.mo_packages m, OPEN.PS_PACKAGE_TYPE ps
         where a.order_id = id_orden and a.package_id = m.package_id and m.package_type_id = ps.package_type_id) package_type,
       id_orden,
/*       (select distinct ot.task_type_id||' - '||ot.description from open.or_task_type ot
         where ot.task_type_id in (select a.task_type_id from open.or_order a
                                    where a.order_id = id_orden)) Desc_Task_Type,*/
       (select distinct ot.task_type_id||' - '||ot.description from open.or_task_type ot
         where ot.task_type_id in tipotrab) Desc_Task_Type,
       sum(d.valor_total) Total,
       cuenta
  from open.ge_detalle_acta d, open.ge_items g, open.or_order od,
       (select distinct to_number(SUBSTR(txtposcn, 6, 5)) acta, clavref1 Nit, clavref3 Nombre, tipotrab, clasecta cuenta
                       from open.ldci_incoliqu--, open.ic_clascott t, open.ic_clascont c
                      where iclinudo in (select codocont from OPEN.LDCI_ACTACONT t, open.ge_acta a
                                          where a.extern_invoice_num is not null
                                            and a.extern_pay_date >= '01-09-2015'
                                            and a.extern_pay_date <  '01-10-2015'
                                            and a.id_acta = t.idacta
                                            and t.actcontabiliza = 'S'
                                            /*and a.id_acta = 11179*/)
                        --and tipotrab = t.clcttitr and t.clctclco = c.clcocodi
                        and clasecta like '7%') u
 where d.id_acta = u.acta
   and od.order_id = d.id_orden
   and od.task_type_id = tipotrab
   and d.valor_total != 0
   and d.id_items = g.items_id
   and g.item_classif_id != 23
group by id_Acta,Nit, Nombre,id_orden, cuenta, tipotrab
