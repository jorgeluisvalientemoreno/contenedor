select p.parameter_id,p.data_type ,
       p.value, p.description,p.allow_update 
from open.ge_parameter   p
where p.parameter_id like upper('%CM_VARS_AVG_MAX_DAYS%')