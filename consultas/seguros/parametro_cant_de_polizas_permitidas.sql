select p.parameter_id,
       p.numeric_value,
       p.value_chain,
       p.description
from open.ld_parameter  p
where upper(p.parameter_id) like upper('%COD_CANT_POLY_EXEQ%')