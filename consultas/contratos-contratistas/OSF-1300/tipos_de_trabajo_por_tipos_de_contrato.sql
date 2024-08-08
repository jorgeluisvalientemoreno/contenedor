select tc.contract_type_id  "Tipo de contrato",
       tc.task_type_id  "Tipo de trabajo", 
       tt.description,
       tc.contract_id  "Contrato",
       case when tc.flag_type = 'C' then 'Contrato'
            when tc.flag_type = 'T' then 'Tipo de Contrato' end  "Nivel" 
from  open.ct_tasktype_contype tc
inner join or_task_type  tt on tt.task_type_id = tc.task_type_id
left join ge_contrato  c on c.id_contrato = tc.contract_id
where   tc.task_type_id = 12155
