select c.*
  from open.or_operating_unit a, ge_contratista b, ge_contrato c
 where a.operating_unit_id = 2218
   and a.contractor_id = b.id_contratista
   and b.id_contratista = c.id_contratista
   and c.status = 'AB'
   and c.fecha_inicial > '01/01/2022';
--   order by c.fecha_inicial desc
--   union 
select c.*, rowid
  from ge_contrato c
 where c.status = 'AB'
   and c.fecha_inicial > '01/01/2022'
   and c.id_contrato = 9001
