--productos_con_cuentas_de_cobro_pendientes
select sesususc "Contrato",
       sesunuse "Producto",
       pr.product_type_id "Tipo Producto",
       sesuesfn  "Estado_finan",
       sesucicl  "Ciclo",
       count(distinct(cc.cucocodi)) "Cant_cuentas_cobro",
       sum(cucosacu) "Saldo_Pendiente"
 from cuencobr cc
  inner join servsusc s  on s.sesunuse = cc.cuconuse
  inner join pr_product pr on s.sesunuse = pr.product_id
 where cc.cucosacu > 0
  and  cc.cucofeve >= '01/01/2024'
  and  sesucicl = 2401
  and   rownum <= 50
group by pr.product_type_id,
       sesususc,
       sesunuse,
       sesuesfn,
       sesucicl
order by sesususc
