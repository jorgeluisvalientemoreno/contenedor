select servsusc.sesususc,
       servsusc.sesunuse ,
       servsusc.sesuserv || ' ' || servicio.servdesc  as Tipo_de_producto,
       pr_product.product_status_id || ' ' || ps_product_status.description as estado_producto
from open.servsusc 
left join open.servicio  on servicio.servcodi = servsusc.sesuserv 
left join open.pr_product  on servsusc.sesunuse = pr_product.product_id
left join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
where servsusc.sesuserv = 7053
and exists (select 1
             from open.diferido d
             where d.difenuse = servsusc.sesunuse 
             and d.difesape > 0 and d.difepldi in (110,111,113))
and exists (select 1
             from open.diferido dd
             where dd.difenuse = servsusc.sesunuse 
             and dd.difesape > 0 and dd.difepldi not in (110,111,113))
and exists ( select 1 
             from open.ld_policy 
             where ld_policy.product_id = servsusc.sesunuse 
             and ld_policy.state_policy = 1)     
and rownum<= 10;
