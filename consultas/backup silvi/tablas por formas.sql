select distinct ex.executable_id, ex.name, e.name_
from open.gi_attrib_disp_data d,  open.ge_entity_attributes at, open.ge_entity e,  open.sa_executable ex
where d.executable_id=ex.executable_id
  and d.entity_attribute_id=at.entity_attribute_id
  and d.entity_id=e.entity_id
and e.name_ like upper('%conftain%')
 -- AND EX.EXECUTABLE_ID = 1345

select distinct ex.executable_id, ex.name, e.name_
from open.gi_attrib_disp_data d
 left outer join open.ge_entity_attributes at  on d.entity_attribute_id=at.entity_attribute_id
 left outer join open.ge_entity e  on d.entity_id=e.entity_id
 left outer join open.sa_executable ex  on d.executable_id=ex.executable_id
where 1=1
  --and e.name_ like upper('%CONFCOSE%')
  and ex.name like '%FTLC%'


SELECT *
FROM SA_EXECUTABLE s
WHERE NAME LIKE '%FTLC%'


 -- Formas padres es hijas
 
 Select *
 From Sa_Tab  t
 Where t.process_name ='FTLC'; 
 
  select  t.aplica_executable ||' - '||  e2.description "ejecutable padre", 
         t.process_name ||' - '|| e1.description "ejecutable hijo"
 from open.sa_tab  t
 inner join open.sa_executable  e1 on e1.name = t.process_name
 inner join open.sa_executable e2 on e2.name = t.aplica_executable 
 union all 
 select e3.name ||' - '|| e3.description "ejecutable padre" , e3.name ||' - '|| e3.description "ejecutable hijo" 
 from open.sa_executable  e3 
 where e3.executable_id != -1 
 and not exists ( select null 
                    from sa_tab t2
                    where t2.process_name= e3.name)
