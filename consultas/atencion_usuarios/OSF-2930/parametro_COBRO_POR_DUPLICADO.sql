select p.parameter_id,
       p.numeric_value,
       p.value_chain,
       p.description
from ld_parameter  p
where p.parameter_id = 'COBRO_POR_DUPLICADO'

