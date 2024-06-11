select r.orden_padre,
       padre.task_type_id titr_p,
       padre.operating_unit_id uni_p,
       padre.order_status_id esta_p,
       padre.defined_contract_id contra_p,
       padre.estimated_cost cos_p,
       (select certificate_id from open.ct_order_certifica c where c.order_id=r.orden_padre) acta_padre,
       ----hija
       r.orden_hija,
       hija.task_type_id titr_h,
       hija.operating_unit_id uni_h,
       hija.order_status_id esta_h,
       hija.defined_contract_id contra_h,
       hija.estimated_cost cost_h,
       decode(r.orden_hija, null, null, r.presupuesto_obra) presu_h,
       (select certificate_id from open.ct_order_certifica c where c.order_id=r.orden_hija) acta_hija,
       ---nieta
       r.orden_nieta,
       nieta.task_type_id titr_n,
       nieta.operating_unit_id uni_n,
       nieta.order_status_id esta_n,
       nieta.defined_contract_id contra_n,
       nieta.estimated_cost cost_n,
       (select certificate_id from open.ct_order_certifica c where c.order_id=r.orden_nieta) acta_nieta
       --
      
from open.ldc_ordenes_ofertados_redes r
left join open.or_order padre on r.orden_padre=padre.order_id
left join open.or_order hija on r.orden_hija=hija.order_id
left join open.or_order nieta  on r.orden_nieta=nieta.order_id
where r.orden_padre=253804370

