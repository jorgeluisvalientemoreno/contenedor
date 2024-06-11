select pr.product_type_id "Tipo Producto",
       sesususc "Contrato",
       sesunuse "Producto",
       sesucicl,
       sesuesfn  "Estado_finan",
       s.sesuesco || ' -' || initcap(substr(e.escodesc,1,19)) "Estado de corte",
       (select count(distinct(br.cucocodi))
          from cuencobr br,
          cargos c
         where br.cuconuse = sesunuse
         and   br.cucocodi = c.cargcuco
         and cucosacu > 0 )"Cant_cuentas_cobro" ,
       (select nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0)
          from cuencobr br
         where br.cuconuse = sesunuse) "Saldo_Pendiente"
from servsusc s
inner join pr_product pr on s.sesunuse = pr.product_id
left join estacort e on e.escocodi= s.sesuesco
where pr.product_type_id = 7055
and  s.sesuesco = 1
and pr.product_type_id not in (3,6121)
and rownum <= 50
