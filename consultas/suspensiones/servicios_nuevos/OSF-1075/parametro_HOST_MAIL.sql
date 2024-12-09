 select p.parameter_id,
       p.description,
       p.value,
       p.val_function,
       p.module_id,
       p.data_type,
       p.allow_update
from ge_parameter  p
where p.parameter_id = 'HOST_MAIL'
