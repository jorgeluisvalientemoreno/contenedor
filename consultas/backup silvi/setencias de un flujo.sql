select *
from wf_instance_attrib  a
left join ge_statement s on s.statement_id=a.statement_id
where instance_id IN (-1789779771, -1777386393)
 AND a.attribute_id=458
