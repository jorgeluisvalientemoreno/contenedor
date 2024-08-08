select p.parameter_id,p.data_type , p.value, p.description,p.allow_update 
from open.ge_parameter   p
where p.description like upper('%AIU%') ;