SELECT e.name, c.composition_id, b.config_id, b.tag_name
FROM gi_composition b,  
gi_frame c,  
sa_executable d,  
sa_executable e,  
gi_config f  
WHERE b.tag_name = d.name  
AND b.entity_type_id = 1258  
AND b.composition_id = c.composition_id  
AND b.config_id = f.config_id  
AND e.executable_id = f.external_root_id  
AND e.name='CNCRM';




SELECT *
FROM GI_COMPOSITION
WHERE CONFIG_ID=8800
  and tag_name like '%SUBS%';


select *
FROM OPEN.GI_COMPOSITION_ADITI AD
WHERE AD.COMPOSITION_ID IN (1065449,1065450,1065518,1065541,1065607,1065650);

SELECT *
FROM OPEN.GI_FRAME F
WHERE F.COMPOSITION_ID IN (1065449,1065450,1065518,1065541,1065607,1065650);

select *
from OPEN.GI_CONFIG_COMP ci
where ci.composition_id in (1065449,1065450,1065518,1065541,1065607,1065650);

SELECT *
FROM GI_COMPOSITION
WHERE TAG_NAME='SUBSIDY'
