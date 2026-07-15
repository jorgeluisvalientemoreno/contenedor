select * 
from or_oper_unit_persons p , or_operating_unit o , GE_TIPO_UNIDAD g 
where o.operating_unit_id = p.operating_unit_id and g.ID_TIPO_UNIDAD= o.UNIT_TYPE_ID
and p.operating_unit_id in (4584 , 4860)

;

select * from or_oper_unit_classif
