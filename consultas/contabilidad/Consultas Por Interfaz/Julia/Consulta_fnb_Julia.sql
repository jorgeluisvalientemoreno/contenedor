-- Ventas mes JULIA
select * from 
(
Select 'PAGOS' Tipo, contrato, sol_venta, ot_entrega, fecha, difecodi, valor_item, val_diferido, Sal_diferido,
       Cuotas_dif, Cuotas_Pen_Dif, Usuario_Dif, Programa_Dif, Ult_mov_dif,
       valor_cont, valor_sol, ot_pago, Tipo_Trabajo, Acta, fra,
       decode(fra, null, valor_sol, -valor_sol) Pagado, 
       (select sb.identification ||' - '|| ge.nombre_contratista  
          from open.or_order o, open.OR_OPERATING_UNIT ou, open.ge_contratista ge, open.GE_SUBSCRIBER sb
         where o.order_id = ot_entrega
           and o.operating_unit_id = ou.operating_unit_id
           and ou.contractor_id = ge.id_contratista
           and ge.subscriber_id = sb.subscriber_id) Proveedor,
       Sol_Causal_46, 
       (select ooa.motive_status_id || ' - ' || pms.description from open.mo_packages ooa, OPEN.PS_MOTIVE_STATUS pms
         where ooa.package_id = Sol_Causal_46 and ooa.motive_status_id = pms.motive_status_id) Est_sol,
       Articulo, Des_artic, linea, (select ll.description from open.ld_line ll where ll.line_id = linea) desc_linea
  from (
select contrato, sol_venta, ot_entrega, fecha, valor_cont, valor_sol, ot_pago, tipo_trabajo, difecodi, valor_item, val_diferido,
       Sal_diferido, Cuotas_dif, Cuotas_Pen_Dif, Programa_Dif, Ult_mov_dif, Acta,
       (select fu.funcnomb from open.funciona fu where fu.funccodi = Usuario_Dif) Usuario_Dif, 
       (case when acta is not null then
         (select ac.extern_invoice_num from open.ge_Acta ac
           where ac.id_acta = acta 
             and ac.extern_pay_date <= '31-10-2016 23:59:59')
         end) Fra, Sol_Causal_46, 
       Articulo, (select la.description from open.LD_ARTICLE la where la.article_id = articulo) Des_artic,
       (select tt.line_id from OPEN.LD_SUBLINE tt
         where tt.subline_id in (select tla.subline_id from open.LD_ARTICLE tla where tla.article_id = articulo)) linea           
 from (
select contrato, sol_venta, ot_entrega, fecha, valor_sol, ot_pago, difecodi, valor_item, val_diferido, 
       (select oat.task_type_id || ' - ' || ott.description from open.or_order_activity oat, open.or_task_type ott 
         where oat.order_id = ot_pago and oat.task_type_id = ott.task_type_id) Tipo_Trabajo,
       Sal_diferido, Cuotas_dif, Cuotas_Pen_Dif, Usuario_Dif, Programa_Dif, trunc(Ult_mov_dif) Ult_mov_dif, 
       (select distinct cargvalo from open.cargos c
         where cargdoso = 'PP-'||sol_venta and cargvalo = val_diferido) valor_cont,
       (case when ot_pago is not null then
         (select distinct ac.id_acta from open.ge_detalle_Acta ac where ac.id_orden = ot_pago)
         end) Acta,
      (SELECT max(package_id) FROM open.ld_return_item lri WHERE lri.package_sale = sol_venta and lri.approved = 'Y') Sol_Causal_46,
      ot_venta, 
      (select oi.article_id
         from open.ld_item_work_order oi
        where oi.order_id = ot_venta and rownum = 1) Articulo
from (         
select a.subscription_id contrato, a.package_id sol_venta, a.order_id ot_entrega, trunc(o.legalization_date) fecha,
       ot_pago, iwo.difecodi,
       (iwo.value + nvl(iwo.iva,0)) Valor_item, dif.difevatd Val_diferido, dif.difesape Sal_diferido, 
       dif.difenucu Cuotas_dif, (dif.difenucu - dif.difecupa) Cuotas_Pen_Dif, dif.difefunc Usuario_Dif, 
       dif.difeprog Programa_Dif, 
       dif.difefumo Ult_mov_dif,
       (select ac1.order_id from open.or_order_activity ac1
         where ac1.package_id   = a.package_id
           and ac1.task_type_id = 12590
           and ac1.order_activity_id = uu.origin_activity_id) ot_venta,
       (select sum(i.unit_value + i.vat) from OPEN.ld_non_ban_fi_item i
         WHERE NON_BA_FI_REQU_ID = a.package_id and i.article_id = iwo.article_id) valor_sol -- Tomar de otro lado..
  From open.or_order_activity a, open.or_order o, open.ld_item_work_order iwo, open.diferido dif,
       (select aa.order_id ot_pago, aa.package_id, aa.motive_id, aa.origin_activity_id
          from open.or_order_activity aa, open.or_order ot
         where aa.task_type_id = 10144
           and aa.register_date >= '09/02/2015 00:00:00'     
           and aa.order_id     = ot.order_id
           and ot.causal_id in (select gc.causal_id from open.ge_causal gc 
                                 where gc.causal_id = ot.causal_id 
                                   and gc.class_causal_id = 1)) uu 
 Where o.legalization_date >= '09-02-2015' and o.legalization_date <= '31-10-2016 23:59:59'
   and o.order_status_id   =  8 
   and o.causal_id in (select gc.causal_id from open.ge_causal gc where gc.causal_id = o.causal_id and gc.class_causal_id = 1)   
   and a.order_id          =  o.order_id 
   and a.task_type_id      =  12590
   and a.order_id          =  iwo.order_id
   and uu.package_id       =  a.package_id
   and uu.motive_id        =  a.motive_id
   and iwo.difecodi(+)     =  dif.difecodi
   and uu.origin_activity_id = a.order_activity_id
Group by a.subscription_id, a.package_id, a.order_id, trunc(o.legalization_date), a.motive_id, ot_pago, iwo.difecodi, value, 
         iva, article_id, dif.difevatd, dif.difesape, dif.difenucu, dif.difefunc, dif.difeprog, dif.difecupa, dif.difefumo,
         uu.origin_activity_id
) --where ot_pago in (23982628, 23982634)
) 
) --where fra is null
-- -----------------
UNION ALL
-- -----------------
-- Consulta Anulaciones al Proveedor
select 'OTROS' Tipo, subscription_id, sol_venta, null id_order, register_date fecha_ot_pago,
       0 difecodi, 0 valor_item, valor_pago, 0 Sal_diferido, 0 Cuotas_dif, 0 Cuotas_Pen_Dif, null Usuario_Dif, 
       null Programa_Dif, null Ult_mov_dif,
       valor_pago, 0 valor_sol, orden, Tipo_Trabajo, Acta, fra, valor_pago, contratista, 0 Sol_Causal_46, 
       null Est_Ot, 
       Articulo, Des_artic, linea, (select ll.description from open.ld_line ll where ll.line_id = linea) desc_linea
  from (
select register_date, subscription_id, id_order, valor_pago, orden, acta, 
       (select act.extern_invoice_num from open.ge_Acta act 
         where act.id_acta = acta 
           and act.extern_pay_date <= '31-10-2016 23:59:59') fra,
       estado,
       (select oat.task_type_id || ' - ' || ott.description from open.or_order_activity oat, open.or_task_type ott 
         where oat.order_id = orden and oat.task_type_id = ott.task_type_id) Tipo_Trabajo,
       contabilizada, contratista, Solicitud, sol_venta, 
       Articulo, (select la.description from open.LD_ARTICLE la where la.article_id = articulo) Des_artic, 
       (select tt.line_id from OPEN.LD_SUBLINE tt
         where tt.subline_id in (select tla.subline_id from open.LD_ARTICLE tla where tla.article_id = articulo)) linea 
  from (         
select register_date, subscription_id, id_order, 
       (case when valor_pago is null then
          (select sum(i.value) from open.or_order_items i where i.order_id = id_order) 
         Else
           valor_pago
           end) valor_pago,
       orden, acta, (select ga.estado from open.ge_acta ga where ga.id_acta = acta) estado,
       contabilizada, contratista, Solicitud,
       (SELECT i.package_sale FROM open.ld_return_item i where i.package_id = Solicitud and rownum = 1) sol_venta,
       (select lnb.article_id from OPEN.ld_non_ban_fi_item lnb
         WHERE NON_BA_FI_REQU_ID in (SELECT i.package_sale FROM open.ld_return_item i where i.package_id = Solicitud)
           and (lnb.unit_value + lnb.vat) = -valor_pago and rownum = 1) Articulo
  from (
          select 
                 (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = ss.susciddi) LOCA, 
                 trunc(register_date) register_date, oac.subscription_id, oac.order_id id_order, 
                 (select sum(a.valor_total)  from open.ge_detalle_acta a, open.ge_acta gaa
                   where a.id_acta = gaa.id_acta
                     and a.id_items in (4294434, 4295320, 4295321)
                     and a.id_orden = oac.order_id) /*oi.value*/ valor_pago,
                 oac.order_id orden, 
                 (select a.id_acta from open.ge_detalle_acta a, open.ge_acta gaa
                   where a.id_acta = gaa.id_acta
                     and id_orden = oac.order_id) acta,
                 (select lt.actcontabiliza from open.ldci_actacont lt
                   where idacta = (select a.id_acta from open.ge_detalle_acta a, open.ge_acta gaa
                                    where a.id_acta = gaa.id_acta
                                      and gaa.extern_pay_date <= '31-10-2016 23:59:59'
                                      and id_orden = oac.order_id)) contabilizada,
                 (select distinct sb.identification ||' - '|| ct.nombre_contratista Nombre
                    from open.or_order o, open.or_operating_unit u, OPEN.GE_CONTRATISTA ct, open.ge_subscriber sb
                   where o.order_id = oac.order_id
                     and o.operating_unit_id = u.operating_unit_id
                     and ct.id_contratista = u.contractor_id
                     and ct.subscriber_id = sb.subscriber_id) contratista,                   
                 (select att.package_id from open.or_order_activity att where att.order_id = oac.order_id and rownum = 1) Solicitud
            from open.or_order_activity oac, open.suscripc ss, OPEN.or_order oo--, open.or_order_items oi
           where oac.task_type_id in (10140, 10220, 10398)
             and register_date Between '09/02/2015 00:00:00'
                                   AND '31-10-2016 23:59:59'
             and oac.subscription_id = ss.susccodi(+)
             and oac.order_id = oo.order_id
             and oo.order_status_id = 8
             and oo.causal_id in (select gc.causal_id from open.ge_causal gc where gc.causal_id = oo.causal_id and gc.class_causal_id = 1) 
       )
       )
       )
)
