--contratos_con_cuentas_de_cobro_pendientes
select sesususc "Contrato",
       sesunuse "Producto",
       pr.product_type_id "Tipo Producto",
       sesucate "Categoria",
       sesuesfn  "Estado_finan",
       sesucicl  "Ciclo",
       count(distinct(cc.cucocodi)) "Cant_cuentas_cobro",
       sum(cucosacu) "Saldo_Pendiente"
 from cuencobr cc
  inner join servsusc s  on s.sesunuse = cc.cuconuse
  inner join pr_product pr on s.sesunuse = pr.product_id
 where sesucate  in (6,7,8,9,10,14)
  and cc.cucosacu > 0
  and  cc.cucofeve >= '01/01/2024'
  and   rownum <= 50
  and  sesucicl = 2401
group by pr.product_type_id,
       sesususc,
       sesunuse,
       sesucate,
       sesuesfn,
       sesucicl
order by sesususc



 -- and  sesucicl = 2401
 -- and   sesususc = 1999601  1999601
 --and   sesususc = 1999601
