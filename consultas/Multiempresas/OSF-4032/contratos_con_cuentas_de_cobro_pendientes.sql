--contratos_con_cuentas_de_cobro_pendientes
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
       (select nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0)
          from cuencobr br
         where br.cuconuse = sesunuse) "Saldo_Pendiente"
from servsusc s
inner join pr_product pr on s.sesunuse = pr.product_id
left join estacort e on e.escocodi= s.sesuesco 
where  1 = 1
 and (select nvl((sum(cucosacu) - sum(cucovare) - sum(cucovrap)), 0)
          from cuencobr br
         where br.cuconuse = sesunuse) > 0

and      (select count(distinct(br.cucocodi)) 
          from cuencobr br,
          cargos c
         where br.cuconuse = sesunuse
         and   br.cucocodi = c.cargcuco
         and cucosacu > 0 ) > 1
         
and      s.sesususc not in (1000102, 1000806,1000164,476,889,1000002,1000030,1000101,1000209,1000131,1000168,1000169,1000272,1000449,1000315)
and      pr.product_type_id = 7014
and      rownum <= 50

;

----and     c.cargconc in (130, 167)
