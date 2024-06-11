select s.tipo_solicitud,s.tipo_tramite, r.idrespu, r.description, r.aten_inme,r.impu_clie,r.tipo_respuesta, tr.descripcion, r.time_out,t.tipo_trabajo, tt.description, t.causal_legalizacion, c.description,
t.grupo_causal, gc.descripcion, t.causal_sspd, cs.descripcion_causal
from ldc_sui_tipsol s
inner join ldc_sui_respuesta r on r.tipo_solicitud = s.tipo_solicitud
inner join ldc_sui_titrcale t on t.respuesta = r.idrespu
inner join ldc_sui_tipres tr on tr.codigo = r.tipo_respuesta
left join or_task_type tt on tt.task_type_id = t.tipo_trabajo
left join ge_causal c on c.causal_id = t.causal_legalizacion
left join ldc_sui_grupcaus gc on gc.codigo = t.grupo_causal
left join ldc_sui_causspd cs on cs.cod_causal_sspd = t.causal_sspd