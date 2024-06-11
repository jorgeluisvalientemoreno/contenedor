select or_ope_uni_task_type.operating_unit_id ||' : '|| initcap(or_operating_unit.name) "Unidad operativa", 
       or_ope_uni_task_type.task_type_id  "Tipo de trabajo",
       ge_contrato.id_contratista ||' : '|| initcap(ge_contratista.nombre_contratista)  "Contratista",
       ge_contrato.id_contrato ||' : '|| initcap(ge_contrato.descripcion)  "Contrato", 
       ge_contrato.id_tipo_contrato  "Tipo de contrato", 
       ge_contrato.id_contrato,
       ge_contrato.fecha_final  "Fecha final",
       case when ge_contrato.fecha_final >= sysdate then 'Si'
            when ge_contrato.fecha_final < sysdate then 'No' end  "Contrato vigente",
       case when ge_contrato.status = 'RG' then 'Registrado' when ge_contrato.status = 'AB' then 'Abierto'
            when ge_contrato.status = 'SU' then 'Suspendido' when ge_contrato.status = 'AN' then 'Anulado'
            when ge_contrato.status = 'CE' then 'Cerrado' end  "Estado"
from open.or_ope_uni_task_type
left join open.or_operating_unit on or_operating_unit.operating_unit_id = or_ope_uni_task_type.operating_unit_id
left join open.ge_contratista on ge_contratista.id_contratista = or_operating_unit.contractor_id 
left join open.ge_contrato on ge_contrato.id_contratista = ge_contratista.id_contratista
where or_ope_uni_task_type.task_type_id = 12155
and ge_contrato.status = 'AB'
and  ge_contrato.id_contratista = 15
and ge_contrato.id_tipo_contrato in (1530,950,910,2)
and or_operating_unit.contractor_id is not null
order by or_ope_uni_task_type.operating_unit_id desc


--and ge_contrato.fecha_final < sysdate
/*and exists (select null 
            from open.ct_tasktype_contype 
            where or_ope_uni_task_type.task_type_id = ct_tasktype_contype.task_type_id
            and ct_tasktype_contype.contract_id = ge_contrato.id_contrato)
and exists (select null 
                from open.ct_tasktype_contype 
                where or_ope_uni_task_type.task_type_id = ct_tasktype_contype.task_type_id
                and ct_tasktype_contype.contract_type_id = ge_contrato.id_tipo_contrato);*/
