select p.parameter_id,
       p.numeric_value,
       p.value_chain,
       p.description
from open.ld_parameter  p
where p.parameter_id in ('PAR_CAUSUSPENSEG', 'ACTIVIDAD_GEN_SUSPXSEGURXACO', 'PAR_CAUSUSPENSEGACO', 'LDC_TIPOSUSPRECSEG','ACTI_YA_SUSP_CM', 'ACTI_YA_SUSP_AC')
