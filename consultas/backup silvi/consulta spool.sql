SELECT cucofact no_factura,cucofepa  ,cucofeve fecha_vencimiento, cucovafa valor_facturado, cuconuse producto
 FROM cuencobr l WHERE l.cucocodi =3016351746;
 
 SELECT cucofact FROM cuencobr l WHERE l.cucocodi = 3017107268;

-- cargcon debe ser 31 para tener consumo 
--cuenta de cobro
select * from cargos 
where cargnuse =1021255
and cargconc = 31 
and cargpefa= 99472
and cargvalo >0
 
 select * from cupon where cupodocu =2097140618 and cuponume = 202573367
 
 select factcodi, factsusc ,cucofepa, factpefa, factfege fecha_generacion ,cucofeve fecha_vencimiento , 
 cuponume, cucovaap , cucovato 
 from factura
 inner join cuencobr l on cucofact = factcodi
 inner join cupon c on cuposusc = factsusc
 where factsusc = 66276422 and factcodi = 2097140618 and cuponume = 202573367
 group by (  factcodi, factsusc , factpefa, factfege ,cucofeve , cuponume , cucofepa ,  cucovaap , cucovato )
 
 
select sesususc , sesunuse, sesucate categoria , sesusuca estrato , sesusafa saldo_a_favor , sesucico ciclo  ,sesufevi 
from servsusc 
where sesususc = 66276422

select *
from ldc_plazos_cert
where id_producto = 6630438

select *
from pagos 
where pagosusc =  66276422

SELECT ralicodo,ralipeco  , ralisesu , ralipefa ,ralitico , raliliir limite_inf,  ralilisr limite_sup ,raliunli Uni_Liqu  ,ralivalo ,ralifecr
FROM RANGLIQU
where ralisesu =6630438
and ralipefa in (99716 )
--and ralitico  <> -1 
order by ralifecr desc

select cosssesu , cosspefa , cosscoca consumo , cossmecc metodo_lect , cossdico  dias_consumo , cossfere fecha_consumo, cossfcco 
from conssesu
where cosssesu in (1186617)
and cossmecc in (1,3)
--and cosspefa in (  99472, 98680)
order by cossfere desc

select leempefa, leemfela, leemlean  lect_ant , leemleto lect_act , leemsesu , cossmecc  , cossfufa 
from lectelme
inner join conssesu on leemsesu = cosssesu 
where leemsesu = 6630438
and cosspefa = leempefa
/*and leempefa in (99716 )*/
order by leemfele desc
