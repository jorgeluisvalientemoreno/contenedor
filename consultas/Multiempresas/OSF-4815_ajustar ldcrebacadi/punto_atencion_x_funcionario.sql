--punto_atencion_x_funcionario
select p.person_id,
       p.name_,cc.orga_area_seller_id,
       aor.name_,
       cc.organizat_area_id,
       cc.is_current
from ge_person  p
left outer join cc_orga_area_seller  cc  on p.person_id = cc.person_id
left outer join ge_organizat_area  aor  on aor.organizat_area_id = cc.organizat_area_id
where p.person_id in (38963);
