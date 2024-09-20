-- ACTAS CONTABILIZADAS
select id_Acta, Nit, Nombre,
       (select distinct m.package_type_id||' - '||ps.description 
          from open.or_order_activity a, open.mo_packages m, OPEN.PS_PACKAGE_TYPE ps
         where a.order_id = id_orden and a.package_id = m.package_id and m.package_type_id = ps.package_type_id) package_type,
       open.LDC_BOORDENES.FNUGETIDLOCALIDAD(ID_orden) Localidad, id_orden,
       (select distinct ot.task_type_id||' - '||ot.description from open.or_task_type ot
         where ot.task_type_id in tipotrab) Desc_Task_Type,
       sum(d.valor_total) Total, cuenta,
       (select cc.ccbgceco from open.ldci_cecoubigetra cc 
        where cc.ccbgloca = open.LDC_BOORDENES.FNUGETIDLOCALIDAD(ID_orden) and cc.ccbgtitr = tipotrab) CECO,
       (select cc.ccbgorin from open.ldci_cecoubigetra cc
         where cc.ccbgloca = open.LDC_BOORDENES.FNUGETIDLOCALIDAD(ID_orden) and cc.ccbgtitr = tipotrab) O_I
  from open.ge_detalle_acta d, open.ge_items g, open.or_order od,
       (select distinct to_number(SUBSTR(txtposcn, 6, 5)) acta, clavref1 Nit, clavref3 Nombre, tipotrab, clasecta cuenta
          from open.ldci_incoliqu
         where iclinudo in (select codocont from OPEN.LDCI_ACTACONT t, open.ge_acta a
                             where a.extern_invoice_num is not null
                               and a.extern_pay_date >= '&Fecha_Inicial'
                               and a.extern_pay_date <  '&Fecha_Final 23:59:59'
                               and a.id_acta = t.idacta
                               and t.actcontabiliza = 'S')
          and clasecta like '7%') u
 where d.id_acta = u.acta
   and od.order_id = d.id_orden
   and od.task_type_id = tipotrab
   and d.valor_total != 0
   and d.id_items = g.items_id
   and g.item_classif_id != 23
group by id_Acta, Nit, Nombre, id_orden, cuenta, tipotrab--, ordenint, centroco
