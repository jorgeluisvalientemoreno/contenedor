-- Validacion tipos de suspension activas_autoreconectados
select ps.suspension_type_id "Tipo_Susp",
       ps.active             "Activa",
       count (a.saresesu)
from ldc_susp_autoreco_rp_pl  a
inner join servsusc ss on ss.sesunuse = a.saresesu
inner join pr_product p on p.product_id = ss.sesunuse
inner join pr_prod_suspension ps on p.product_id = ps.product_id
where a.sareproc = 7
and ps.active = 'Y'
group by ps.suspension_type_id, ps.active
order by ps.suspension_type_id asc;


-- Validacion tipos de suspension activas_persecucion
select ps.suspension_type_id "Tipo_Susp",
       ps.active             "Activa",
       count(1)     
from ldc_susp_persecucion_pl  a
inner join servsusc ss on ss.sesunuse = a.susp_persec_producto
inner join pr_product p on p.product_id = ss.sesunuse
left join pr_prod_suspension ps on p.product_id = ps.product_id and  ps.active = 'Y' 
group by ps.suspension_type_id,
       ps.active
order by ps.suspension_type_id asc;

--identificar_total_sin_duplicados
select count(1) from ldc_susp_persecucion_pl;

--identificar_productos_duplicados
select a.susp_persec_producto,
       count(1)     
from ldc_susp_persecucion_pl  a
inner join servsusc ss on ss.sesunuse = a.susp_persec_producto
inner join pr_product p on p.product_id = ss.sesunuse
left join pr_prod_suspension ps on p.product_id = ps.product_id and  ps.active = 'Y' 
group by a.susp_persec_producto
having count(1)>1;
