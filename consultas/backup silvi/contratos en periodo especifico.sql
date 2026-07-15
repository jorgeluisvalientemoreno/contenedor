select susc contrato,
       (Select l.nombres || ' ' || l.apellido 
          from open.ldc_osf_Sesucier l 
         where l.nuano=:a?o_1 and l.numes=:mes_1 
           and l.contrato=susc 
           and l.tipo_producto=7014) nombre
from (
select contrato susc from (
select l.nuano, l.numes,
       l.contrato,
       sum(case when l.estado_tecnico not in (3,  4, 7, 15, 16, 20,22,24) then 1 else 0 end) usuarios,
       sum(1) suscriptores
from open.ldc_osf_sesucier l
where l.nuano  = :a?o_1
  and l.numes = :mes_1
  and l.ciclo=:ciclo
  and l.tipo_producto = 7014
  and l.estado_tecnico not in (3, 16, 22 , 24)
  and l.estado_financiero != 'C'
--  and l.departamento in {?departamento}
group by l.nuano, l.numes, l.contrato)
where usuarios > 0
minus
select contrato susc from (
select l.nuano, l.numes,
       l.contrato,
       sum(case when l.estado_tecnico not in (3,  4, 7, 15, 16, 20,22,24) then 1 else 0 end) usuarios,
       sum(1) suscriptores
from open.ldc_osf_sesucier l
where l.nuano  = :a?o_2
  and l.numes = :mes_2
  and l.ciclo=:ciclo
  and l.tipo_producto = 7014
  and l.estado_tecnico not in (3, 16, 22 , 24)
  and l.estado_financiero != 'C'
--  and l.departamento in {?departamento}
group by l.nuano, l.numes, l.contrato)
where usuarios > 0
)
