select ct_tasktype_contype.contract_type_id  "Tipo de contrato por tipo trab",
       ct_tasktype_contype.task_type_id  "Tipo de trabajo", 
       ct_tasktype_contype.contract_id  "Contrato",
       ge_contrato.id_tipo_contrato  "Tipo de contrato por contrato", 
       ge_contrato.fecha_final  "Fecha final",
       case when ge_contrato.fecha_final >= sysdate then 'Si'
            when ge_contrato.fecha_final < sysdate then 'No' end  "Contrato vigente",
       case when ge_contrato.status = 'RG' then 'Registrado' when ge_contrato.status = 'AB' then 'Abierto'
            when ge_contrato.status = 'SU' then 'Suspendido' when ge_contrato.status = 'AN' then 'Anulado'
            when ge_contrato.status = 'CE' then 'Cerrado' end  "Estado",
       case when ct_tasktype_contype.flag_type = 'C' then 'Contrato'
            when ct_tasktype_contype.flag_type = 'T' then 'Tipo de Contrato' end  "Nivel" 
from  open.ct_tasktype_contype 
left join open.ge_contrato on ge_contrato.id_contrato = ct_tasktype_contype.contract_id
where ct_tasktype_contype.task_type_id = 10723
and ge_contrato.status = 'AB'
and ge_contrato.fecha_final < sysdate;
