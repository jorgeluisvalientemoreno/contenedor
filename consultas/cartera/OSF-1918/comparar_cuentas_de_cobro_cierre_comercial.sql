--comparar_cuentas_de_cobro_cierre_comercial
select sesususc,
       sesunuse,
       sum(cucosacu) "Saldo_Pendiente_cuenta_cobro",
       (select sum(cc.sesusape) 
        from ldc_osf_sesucier  cc
        where cc.producto = sesunuse and cc.nuano = 2024 and cc.numes = 8) "Saldo_Pendiente_cierre",
       (sum(cucovare) +  sum(cucovrap)) "Valor_Reclamo_cuenta_cobro",
       (select sum(cc1.valor_reclamo) 
        from ldc_osf_sesucier  cc1
        where cc1.producto = sesunuse and cc1.nuano = 2024 and cc1.numes = 8) "Valor_Reclamo_cierre"       
from cuencobr br
inner join servsusc s on br.cuconuse = sesunuse
where  sesunuse in (1058785,1061866,1062663,1147674)
group by sesususc, sesunuse
