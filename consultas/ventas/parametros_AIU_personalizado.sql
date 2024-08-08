select p.parameter_id,p.numeric_value,p.value_chain, p.description 
from open.ld_parameter  p
where p.parameter_id in ('PAR_VAL_AIU','PORCENTAJE_AIU_COM','MET_LIQU_COT_COMERCIAL' )