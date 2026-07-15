
select contractor_id ,operating_unit_id
from OPEN.OR_OPERATING_UNIT
where operating_unit_id =  2948 ; 

select *
from OPEN.Ge_Contratista c
where id_contratista = 2670 ;  

select *
from open.ge_contrato 
where id_contratista = 2670   and id_tipo_contrato  in ( 2,932,1530)
order by fecha_final desc  for update  ; 

select c.tasktype_contype_id,
       tc.id_tipo_contrato,
       tc.descripcion,
       c.contract_type_id,
       c.task_type_id,
       t.description,
       c.contract_id,
       c.flag_type
  from open.ct_tasktype_contype c,
       open.GE_TIPO_CONTRATO    tc,
       open.or_task_type        t
 where c.contract_type_id = tc.id_tipo_contrato
   and c.task_type_id = t.task_type_id
  and c.task_type_id in (12152); 
  
  select * from ge_contrato where id_contratista = 3541 ; 
