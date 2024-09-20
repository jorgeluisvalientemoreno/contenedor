-- COSTO ACTA CON FACTURA
select y.product_id, g.id_acta, trunc(a.fecha_creacion) fecha_creacion, y.task_type_id, tr.description, sum(g.valor_total) TOTAL,
      (select trunc(max(hcecfech))/*'CONECTADO'*/ FROM OPEN.hicaesco h
        where y.product_id = h.hcecnuse 
          and hcececan = 96
          and hcececac = 1
          and hcecserv = 7014
          /*and hcecfech >= '01-05-2015' and hcecfech < '01-06-2015'*/) CONECTADO,
      (select i.invmvain from open.Ldci_Ingrevemi i, open.hicaesco h
        where i.invmsesu = y.product_id and i.invmconc = 30 and y.task_type_id = 12149
          and i.invmsesu = h.hcecnuse 
          and hcececan = 96
          and hcececac = 1
          and hcecserv = 7014
          and hcecfech >= '01-06-2015' and hcecfech < '01-07-2015') Interna,
      (select i.invmvain from open.Ldci_Ingrevemi i, open.hicaesco h
        where i.invmsesu = y.product_id and i.invmconc = 19 and y.task_type_id = 12150
          and i.invmsesu = h.hcecnuse 
          and hcececan = 96
          and hcececac = 1
          and hcecserv = 7014
          and hcecfech >= '01-06-2015' and hcecfech < '01-07-2015') CxC         
  from open.ge_detalle_acta g, open.ge_items i, open.or_order_activity y, open.mo_packages p, open.or_task_type tr,
       open.ge_acta a
 where a.extern_pay_date >= '01-06-2015' 
   and a.extern_pay_date <  '01-07-2015'
   and g.id_acta = a.id_acta
   and g.id_items = i.items_id
   and i.item_classif_id != 23
   and g.id_orden = y.order_id
   and y.package_id = p.package_id
   and p.package_type_id in (271, 323, 100271, 100229)
   and y.task_type_id = tr.task_type_id
   and y.task_type_id not in (10336, 10044)
Group by y.product_id, g.id_acta, y.task_type_id, tr.description, trunc(a.fecha_creacion)
