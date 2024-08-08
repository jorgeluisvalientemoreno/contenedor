SELECT *
FROM OPEN.GE_ENTITY
WHERE ENTITY_ID IN (6163, 3707, 6169)
FOR UPDATE
;

select *
from GE_STATEMENT_COLUMNS
where entity_id in (6163, 3707, 6169)
SELECT *
FROM OPEN.GE_ENTITY_ATTRIBUTES
WHERE ENTITY_ID IN (6163)
order by 2,1 
FOR UPDATE
  ;
  
select *
from GE_ENTITY_ADITIONAL
where entity_id IN (6169)
for update;

select *
from OPEN.GE_ENTITY_REFERENCE
where child_entity_id in (6169)
;
select *
from ge_catalog
where record_id in (6169)
for update;

select *
from SA_EXECUTABLE
where executable_id in (500000000015617, 500000000015771, 500000000010685)
FOR UPDATE;



SELECT 500000000015771 executable_id, entity_id, entity_attribute_id, secuence_
FROM OPEN.GE_ENTITY_ATTRIBUTES
WHERE ENTITY_ID IN (6163);


select *
from GI_ENTITY_DISP_DATA d
where d.entity_id in (6163/*, 3707*/)
for update;


select *
from OPEN.GI_ATTRIB_DISP_DATA
where entity_id=6163
for update;

select *
from OPEN.GI_ATTRIB_DISP_DATA
where entity_id=6163
for update
; 

