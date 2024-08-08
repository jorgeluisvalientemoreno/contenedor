-- Validaci�n tipos de suspensi�n activas
select ps.suspension_type_id "Tipo_Susp",
       ps.active             "Activa",
       count (a.saresesu)
from ldc_susp_autoreco_sj  a
inner join servsusc ss on ss.sesunuse = a.saresesu
inner join pr_product p on p.product_id = ss.sesunuse
inner join pr_prod_suspension ps on p.product_id = ps.product_id
where a.sareproc = 7
inner join pr_prod_suspension ps on p.product_id = ps.product_id
where a.sareproc = 7
and ps.active = 'Y'
group by ps.suspension_type_id, ps.active
order by ps.suspension_type_id asc
