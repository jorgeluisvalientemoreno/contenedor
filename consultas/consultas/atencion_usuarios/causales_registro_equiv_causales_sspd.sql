select c.causal_registro, tc.description, c.tipo_solicitud, ts.description, c.grupo_causal, gc.descripcion, c.causal_sspd, cs.descripcion_causal
from ldc_sui_caus_equ c
inner join ldc_sui_grupcaus gc on gc.codigo = c.grupo_causal
left join ldc_sui_causspd cs on cs.cod_causal_sspd = c.causal_sspd
inner join ps_package_type ts on ts.package_type_id = c.tipo_solicitud
inner join cc_causal tc on tc.causal_id = c.causal_registro