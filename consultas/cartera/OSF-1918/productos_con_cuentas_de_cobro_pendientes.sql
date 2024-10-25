--productos_con_cuentas_de_cobro_pendientes
select pr.product_type_id "Tipo Producto",
       sesususc "Contrato",
       sesunuse "Producto",
       sesuesfn  "Estado_finan",
       s.sesuesco || ' -' || initcap(substr(e.escodesc,1,19)) "Estado de corte",
       (select count(distinct(br.cucocodi)) 
          from cuencobr br,
          cargos c
         where br.cuconuse = sesunuse
         and   br.cucocodi = c.cargcuco
         and cucosacu > 0 )"Cant_cuentas_cobro" ,
       (select (sum(cucosacu)))/* - sum(cucovare) - sum(cucovrap)), 0)*/
          from cuencobr br
         where br.cuconuse = sesunuse) "Saldo_Pendiente"
from servsusc s
inner join pr_product pr on s.sesunuse = pr.product_id
left join estacort e on e.escocodi= s.sesuesco 
where  sesunuse in (50557303,
50013948,
52565629,
50343029,
50958050,
8093482,
50060700,
50035747,
50466703,
50788051,
17120835)

;

----and     c.cargconc in (130, 167)
