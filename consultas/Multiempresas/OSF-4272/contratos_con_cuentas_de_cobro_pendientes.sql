--contratos_con_cuentas_de_cobro_pendientes
with cuentas_agrupadas as (
  select br.cuconuse,
         count(distinct br.cucocodi) as cant_cuentas_cobro,
         nvl(sum(br.cucosacu) - sum(nvl(br.cucovare, 0)) - sum(nvl(br.cucovrap, 0)), 0) as saldo_pendiente
    from cuencobr br
    join cargos c on c.cargcuco = br.cucocodi
   where br.cucosacu > 0
   group by br.cuconuse
)
select pr.product_type_id as "Tipo Producto",
       s.sesususc        as "Contrato",
       s.sesunuse        as "Producto",
       s.sesuesfn        as "Estado_finan",
       s.sesuesco || ' -' || initcap(substr(e.escodesc, 1, 19)) as "Estado de corte",
       s.sesucicl        as "Ciclo",
       ca.cant_cuentas_cobro as "Cant_cuentas_cobro",
       ca.saldo_pendiente as "Saldo_Pendiente"
  from servsusc s
  inner join pr_product pr on s.sesunuse = pr.product_id
  left join estacort e on e.escocodi = s.sesuesco
  inner join cuentas_agrupadas ca on ca.cuconuse = s.sesunuse
 where 1 = 1
   and  pr.product_type_id = 7014
   and  ca.saldo_pendiente > 0
   and ca.cant_cuentas_cobro > 1
  AND ca.cant_cuentas_cobro < 4 
   and s.sesucicl = 115
  and rownum <= 20;

;

