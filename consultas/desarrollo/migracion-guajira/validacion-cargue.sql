select susccodi,
       p.product_id,
       p.product_type_id,
       p.product_status_id,
       sesunuse,
       sesuserv,
       sesuesco,
       sesufeco,
       (select count(1) from open.pr_component c where c.product_id = p.product_id) cantidad_componentes,
       (select count(1) from open.pr_component c,open.pr_component_link l where c.product_id = p.product_id and l.child_component_id = c.component_id) cantidad_links,
       (select count(1) from open.elmesesu where emsssesu = p.product_id) cantidad_medidores,
       (select count(1) from open.elmesesu where emsssesu = p.product_id and emssfere>sysdate) cantidad_medidores_activos
from open.suscripc o
left join open.pr_product p on p.subscription_id=o.susccodi
left join open.servsusc s on sesususc=susccodi and sesunuse=product_id
where exists(select null from migragg.suscripc m where m.susccodi = o.susccodi)
  and exists(select null from migragg.migra_direcciones_gdg h where h.predabdr = o.susciddi)
;
