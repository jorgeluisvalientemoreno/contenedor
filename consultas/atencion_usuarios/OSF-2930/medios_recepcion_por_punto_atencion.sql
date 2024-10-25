-- medios_recepcion_por_punto_atencion
select r.operating_unit_id,
       aor.name_,
       r.reception_type_id,
       mr.description
from or_ope_uni_rece_type  r
inner join ge_reception_type  mr  on  mr.reception_type_id = r.reception_type_id
inner join ge_organizat_area  aor  on aor.organizat_area_id = r.operating_unit_id
where r.operating_unit_id = 64;


Select *
from ge_person  p
where p.name_ like '%KIOSKO%'
