-- PROVISION COSTOS
SELECT tipo, product_id, acta, titr, (select tt.description from open.or_task_type tt where tt.task_type_id = titr) Desc_Titr,
       concept, Total, Total_iva, clctclco Clasificador, clcodesc, contratista, nombre, fec_lega,
       localidad, orden, actividad,
       (select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clctclco) Cuenta,
       (select lc.cuctdesc from open.ldci_cuentacontable lc 
         where lc.cuctcodi = (select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clctclco)) Nom_Cuenta,       
       (select cc.ccbgceco from open.ldci_cecoubigetra cc where cc.ccbgloca = localidad and cc.ccbgtitr = titr) CECO,
       (select cc.ccbgorin from open.ldci_cecoubigetra cc where cc.ccbgloca = localidad and cc.ccbgtitr = titr) O_I
from (       
select tipo, product_id, acta, titr, concept, sum(decode(Nombre, null, 0, total)) Total, 
       sum(decode(Nombre, null, 0, total_iva)) Total_iva, clctclco, icc.clcodesc, contratista, nombre, fec_lega, 
       (select oa.activity_id from open.or_order_activity oa 
         where oa.order_id = orden 
           and oa.order_activity_id = (select min(ot.order_activity_id) from open.or_order_activity ot
                                        where ot.order_id = orden)) actividad,
       orden, open.LDC_BOORDENES.FNUGETIDLOCALIDAD(orden) Localidad, factura, fecha
  from (
        select tipo, product_id, acta, factura, fecha, orden, titr, concept, sum(total) total, 
               sum(total_iva) total_iva, contratista, nombre, fec_lega, clctclco
        from (
          SELECT 'ACTA_S_F' TIPO, oa.product_id, a.id_acta acta, null  factura, null  fecha, 
                 a.id_orden orden, decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) titr, ot.concept,
                 sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total, 
                 sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                 co.id_contratista contratista, ta.nombre_contratista nombre,
                 trunc(ro.legalization_date) fec_lega, tt.clctclco
          FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.mo_packages m, open.ge_acta ac, open.or_order ro,
               open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
          where (ac.extern_pay_date is null or ac.extern_pay_date > '30-09-2015 23:59:59') 
           and ac.id_acta   = a.id_acta
           and a.id_orden   = oa.order_id
           and oa.package_id = m.package_id(+)
           and a.valor_total != 0
           and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
           and oa.order_id = ro.order_id
           and ro.legalization_date <= '30-09-2015 23:59:59'
           and oa.task_type_id = ro.task_type_id
           and tt.clctclco not in (311,246,303,252,253)
           and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = ot.task_type_id
           and ac.id_contrato = co.id_contrato
           and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
          Group by 'ACTA_S_F', oa.product_id, a.id_acta, ac.extern_invoice_num, a.id_orden, 
                   decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id), ot.concept, co.id_contratista, 
                 ta.nombre_contratista, trunc(ro.legalization_date), tt.clctclco, trunc(ac.extern_pay_date)
          Union  -- Ajustes de ordenes de meses anteriores
          SELECT 'ACTA_S_F' TIPO, oa.product_id, a.id_acta acta, null factura, null  fecha, 
                 a.id_orden orden, decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) titr, ot.concept,
                 sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total, 
                 sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                 co.id_contratista contratista, ta.nombre_contratista nombre,
                 trunc(ro.legalization_date) fec_lega, tt.clctclco
          FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.mo_packages m, open.ge_acta ac, open.or_order ro,
               open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
          where (ac.extern_pay_date is null or ac.extern_pay_date > '30-09-2015 23:59:59') 
           and ac.id_acta   = a.id_acta
           and a.id_orden   = oa.order_id
           and oa.package_id = m.package_id(+)
           and a.valor_total != 0
           and oa.task_type_id =  10336 -- Tipo de Trabajo Ajustes
           and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
           and oa.order_id = ro.order_id
           and ro.legalization_date <= '30-09-2015 23:59:59' 
           and oa.task_type_id = ro.task_type_id
           and tt.clctclco not in (311,246,303,252,253)
           and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = ot.task_type_id
           and ac.id_contrato = co.id_contrato
           and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
          Group by 'ACTA_S_F', oa.product_id, a.id_acta, ac.extern_invoice_num, a.id_orden, 
                   decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id), ot.concept, co.id_contratista, 
                 ta.nombre_contratista, trunc(ro.legalization_date), tt.clctclco, trunc(ac.extern_pay_date)
        )
        Group by tipo, product_id, acta, factura, fecha, orden, titr, concept, contratista, nombre, fec_lega, clctclco
        UNION
        select tipo, product_id, acta, factura, fecha, orden, titr, concept, sum(total) total, sum(total_iva) total_iva,
               contratista, nombre, fec_lega, clctclco
        from (
        SELECT 'SIN_ACTA' TIPO, oa.product_id, null acta, null factura, null fecha, oa.order_id orden, 
               decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) titr, ot.concept,
               sum(decode(it.items_id, 4001293, 0, value)) Total, 
               sum(decode(it.items_id, 4001293, value)) Total_IVA,
               decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista, 
               (select co.nombre_contratista from OPEN.GE_CONTRATISTA co 
                 where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre, 
               trunc(r.legalization_date) fec_lega, tt.clctclco
          FROM open.or_order_activity oa, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
               open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
         where r.legalization_date <= '30-09-2015 23:59:59'
           and r.order_status_id = 8
           AND r.is_pending_liq  = 'Y' 
           and r.order_id = oa.order_id
           and r.task_type_id = oa.task_type_id
           and oa.package_id = m.package_id(+)
           and oa.order_id = oi.order_id
           and value != 0
           and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
           and tt.clctclco not in (311,246,303,252,253)
           and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
           and oa.task_type_id = ot.task_type_id      
           and oi.items_id    = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
           and r.operating_unit_id = ut.operating_unit_id
        Group by 'SIN_ACTA', oa.product_id, null, null, null, oa.order_id, decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id),
                 ot.concept, trunc(r.legalization_date), tt.clctclco, ut.contractor_id, ut.operating_unit_id
        )
        Group by tipo, product_id, acta, factura, fecha, orden, titr, concept, contratista, nombre, fec_lega, clctclco
            
       ),  open.ic_clascont icc
 where clctclco = icc.clcocodi
group by tipo, product_id,acta,orden, titr, concept, clctclco,icc.clcodesc, contratista, nombre, fec_lega, factura, fecha
)
where total != 0
