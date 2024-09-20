-- Consulta Reintegro en una fecha
select *
  from open.trbadosr t, open.tranbanc d
 where trbafere >= '31-07-2015' and trbafere < '01-08-2015'
   and tbdstrba  = d.trbacodi;
--   and d.dosrtdsr = 1; 
select * from open.docusore where dosrfere >= '31-07-2015' and dosrfere < '01-08-2015';
-- Consulta Reintegro en una fecha
select entidad, sum(valor)
  from open.banco c, 
      (select tbdstrba, (select d.trbabare from open.tranbanc d where d.trbacodi = tbdstrba) ENtidad,
              sum(tbdsvads) valor
         from open.trbadosr t
        where t.tbdsfere >= '06-08-2015' and tbdsfere < '07-08-2015' group by tbdstrba) u
  where entidad = c.banccodi and banctier = 2        
group by entidad
