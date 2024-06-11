select h.hcetnuse          producto,
       h.hcetsusc          contrato,
       h.hcetserv          servicio,
       p.product_status_id estado_producto,
       h.hcetepac          estado_prod_actual,
       h.hcetepan          estado_prod_anterior,
       s.sesuesfn          estado_financiero,
       h.hcetefac          estado_financiro_actual,
       h.hcetefan          estado_financiro_anterior,
       h.hcetfech          fecha_cambio,
       h.hcetusua          usuario,
       h.hcetterm          terminal,
       h.hcetprog          programa,
       p.suspen_ord_act_id actividad_suspension,
       h.hcetacac          actividad_suspension_actual,
       h.hcetacan          actividad_suspension_anterior,
       a.order_activity_id a.activity_id actividad_Suspension
  from open.HICAESPR h
 inner join open.pr_product  p on p.product_id = h.hcetnuse
 inner join open.servsusc  s on s.sesunuse = h.hcetnuse
 left  join open.or_order_Activity a on a.order_activity_id = p.suspen_ord_act_id
 where h.hcetnuse = 51911150
