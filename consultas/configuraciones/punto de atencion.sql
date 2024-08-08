select mask, p.name_, PERSON_ID, P.E_MAIL, p.organizat_area_id
from open.sa_user u, open.ge_person  p
where mask LIKE upper('%diasal%')
  and u.user_id=p.user_id;
  
  SELECT *
  FROM OPEN.CC_ORGA_AREA_SELLER s, OPEN.GE_ORGANIZAT_AREA a
  WHERE PERSON_ID IN (42795)
   and s.organizat_area_id=a.organizat_area_id;
  
select *
from open.or_ope_uni_rece_type re
where re.operating_unit_id=45;

select up.operating_unit_id,
       open.daor_operating_unit.fsbgetname(up.operating_unit_id, null),
       p.person_id,
       p.name_
from open.or_oper_unit_persons up, open.ge_person p
where up.person_id=p.person_id
  and p.person_id=42795
  and operating_unit_id in (1939, 3666)
;



select *
from GE_ORGA_AREA_ADD_DATA d
where d.organizat_area_id=64
for update

select *
from LDC_REP_AREA_TI_PA_CA
;
