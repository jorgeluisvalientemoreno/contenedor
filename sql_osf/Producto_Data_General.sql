SELECT pp.subscription_id contrato,
       pp.product_id producto,
       pp.product_type_id || ' - ' || s.servdesc Servicio,
       pp.commercial_plan_id || ' - ' || ccp.description Plan_comercial,
       s.servdimi DIAS_MINIMOS_PARA_FACTURAR, --Dias mininos para generar factura despues de crear el producto
       emss.emsselme Serial,
       emss.emsscoem Medidor,
       emss.emssfein Fecha_Instalacion,
       emss.emssfere Fecha_Retira,
       (select max(lem.leemfele)
          from open.lectelme lem
         where lem.leemsesu = pp.product_id) Fecha_ultima_lectura,
       (select lem1.leemleto
          from open.lectelme lem1
         where lem1.leemsesu = pp.product_id
           and lem1.leemfele =
               (select max(lem.leemfele)
                  from open.lectelme lem
                 where lem.leemsesu = pp.product_id)) Ultima_Lectura,
       pp.address_id || ' - ' || aa.address Direccion,
       (select ooa.order_activity_id || ' [ ACTIVIDAD: ' || gi.items_id ||
               ' - ' || gi.description || ' ]'
          from open.Or_Order_Activity ooa, open.ge_items gi
         where gi.items_id = ooa.activity_id
           and ooa.order_activity_id = pp.suspen_ord_act_id) Actividad_Suspension,
       (select ooa.order_id || ' [ TT: ' || ott.task_type_id || ' - ' ||
               ott.description || ' ]'
          from open.Or_Order_Activity ooa,
               open.or_order          oo,
               open.or_task_type      ott
         where oo.order_id = ooa.order_id
           and oo.task_type_id = ott.task_type_id
           and ooa.order_activity_id = pp.suspen_ord_act_id) Orden_Suspension
  FROM open.pr_product pp
  left join OPEN.elmesesu emss
    on emss.emsssesu = pp.product_id
   and sysdate between emss.emssfein and emss.emssfere
  left join open.servicio s
    on s.servcodi = pp.product_type_id
  left join open.cc_commercial_plan ccp
    on ccp.commercial_plan_id = pp.commercial_plan_id
  left join open.ab_address aa
    on aa.address_id = pp.address_id
 where emss.emsssesu = 51343403
--pp.subscription_id = 51546201
 order by emss.emssfein desc;
