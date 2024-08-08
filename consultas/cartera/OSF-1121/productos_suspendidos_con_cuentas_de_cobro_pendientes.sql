select sesususc "Contrato",
       sesunuse "Producto",
       sesuesfn  "Estado_finan",
       s.sesuesco || ' -' || initcap(substr(e.escodesc,1,19)) "Estado de corte",
       pr.product_status_id || ' -' || initcap(p.description) "Estado_Prod",
       ps.suspension_type_id || ' -' || initcap(ge.description) "Tipo_Susp",
       pr.suspen_ord_act_id || ' -' || initcap (i.description) "Actividad Susp",   
       (select count(distinct(br.cucocodi)) 
          from cuencobr br
         where br.cuconuse = sesunuse
         and cucosacu > 0 )"Cant_cuentas_cobro" ,
       (select nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0)
          from cuencobr br
         where br.cuconuse = sesunuse) "Saldo_Pendiente"
from servsusc s
inner join pr_prod_suspension ps on s.sesunuse = ps.product_id 
inner join pr_product pr on s.sesunuse = pr.product_id 
left join or_order_activity  a on a.order_activity_id = pr.suspen_ord_act_id
left join ge_items  i on i.items_id = a.activity_id
left join ge_suspension_type ge on ge.suspension_type_id = ps.suspension_type_id
left join ps_product_status p on  pr.product_status_id= p.product_status_id
left join estacort e on e.escocodi= s.sesuesco 
where s.sesuesco = 3 
and  ps.active = 'Y'
and   ps.suspension_type_id in (2)
;

