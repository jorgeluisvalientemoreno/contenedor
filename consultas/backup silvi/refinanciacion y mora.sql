  
-- consultar la refinanciaion detalle
SELECT d.difesusc,d.difenuse,l.tipo_producto,d.difeconc ,d.difevatd,d.difenucu, d.difecupa, d.difevacu, d.difesape , d.difeinte , d.difecoin,d.difeprog
 ,l.edad ,l.edad_deuda,l.deuda_corriente_vencida, l.nuano , l.numes 
FROM open.diferido d
INNER JOIN ldc_osf_sesucier l ON  l.contrato = d.difesusc
  WHERE d.difeprog != 'GCNED' 
   and l.nuano =2022 
 and  l.numes= 4
 and l.edad_deuda > 90; 

-- consultar si tiene refinanciaion
SELECT COUNT(DISTINCT(d.difecofi))
  FROM open.diferido d
  WHERE  d.difesusc = 17171804
  AND d.difeprog = 'GCNED'
  and d.difesape > 0;


--Verificar correo y impresión de factura
SELECT s.susccodi , s.suscefce, s.suscdeco 
FROM SUSCRIPC s
WHERE s.susccodi=1021255
/*for update*/

--Validar mora y edad de cartera
 select l.contrato,l.producto,l. tipo_producto,l.edad ,l.edad_deuda, 
 l.deuda_corriente_vencida , l.nuano , l.numes
 from ldc_osf_sesucier l
 where l.contrato = 17171804
 and l.numes = 5
 and l.nuano = 2022
 AND l.edad_deuda > 90 ;


--Calcular interes 
select (power( 1 + difeinte/100, 1/12) - 1)*100 as Interes_financiacion
from open.diferido
where difenuse =
  and difeconc = 603
  and difecodi = 50348732;

-- consulta tabla diferido conceptos de financiacion e interes
select  d.difesusc,d.difenuse, d.difecofi, p.product_type_id ,d.difeconc,
c.concdesc ,d.difesape,d.difecupa , d.difeinte, 
round((power( 1 + difeinte/100, 1/12) - 1)*100 ,2) as Interes_fin, (difenucu - difecupa) as cuotas_pend,
d.difevatd, d.difevacu, d.difeprog ,d.difenucu, d.difecoin , cc.cargpefa
from diferido d
inner join concepto c on d.difeconc = c.conccodi
inner join cargos cc on  cc.cargnuse =  d.difenuse
inner join pr_product p on p.product_id = d.difenuse
where d.difesusc in (66276422) 
and p.product_type_id in (7014) and d.difeinte >0 and d.difesape > 0 and cc.cargpefa= 99716
group by (d.difesusc,d.difenuse, d.difecodi, p.product_type_id ,d.difeconc,
c.concdesc ,d.difesape,d.difecupa , d.difeinte,
d.difevatd, d.difevacu, d.difeprog ,d.difenucu, d.difecoin , cc.cargpefa,d.difecofi) ;

/*and d.difeprog = 'GCNED'
and d.difesape > 0*/

--tabla diferido
select  d.difesusc,d.difenuse, d.difecodi, d.difecofi, p.product_type_id ,d.difeconc,
c.concdesc ,d.difesape,d.difecupa , d.difeinte, cc.cargdoso , 
d.difevatd, d.difevacu, d.difeprog ,d.difenucu, d.difecoin , cc.cargpefa
from diferido d
inner join concepto c on d.difeconc = c.conccodi
inner join cargos cc on  cc.cargnuse =  d.difenuse
inner join pr_product p on p.product_id = d.difenuse
where d.difesusc in (1021255) 
and p.product_type_id in (7014) and d.difeinte >0 and cc.cargpefa= 99472


select pagosusc , pagopefa ,pagopava
from pagos
where pagosusc = 67033146
order by pagopefa desc

select pagosusc , pagofepa , pagovapa 
from pagos 
where pagosusc = 67033146
order by pagofepa desc


select difesusc, difevatd , difevacu, difesape, difenucu, difeinte, product_type_id, c.concdesc , difecupa ,
 (difenucu - difecupa) as cuotas_pend
from diferido 
inner join pr_product p on p.product_id = difenuse
inner join cargos cc on  cc.cargnuse =  difenuse 
inner join concepto c on difeconc = c.conccodi
where difesusc in (66276422) 
and p.product_type_id in (7055)
and cc.cargpefa = 99716
 and difeinte >0
 and difesape >0 
 group by (difesusc, difevatd , difevacu, difesape, difenucu, difeinte, product_type_id, c.concdesc, difecupa)

select *
from cupon 
where cuponume in ( 202572024, 202572612,202508361)
