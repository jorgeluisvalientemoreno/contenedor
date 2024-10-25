--Tipo de trabajo
select ott.*, rowid
  from open.or_task_type ott
 where ott.task_type_id in (10444);
--tipo trabajo x causal
select ottc1.*, rowid
  from open.or_task_type_causal ottc1
 where ottc1.task_type_id in (10444);
--Tipo trabajo x Items
select pltt0.*, rowid
  from open.or_task_types_items pltt0
 where pltt0.task_type_id in (10444);
--Tipos de trbajo x Grupo Dato Adicional
select a.*, rowid
  from open.or_tasktype_add_data a
 where a.task_type_id = 10444;
--tipo de trabajo por tipo de contrato
select ctc.*, rowid
  from open.ct_tasktype_contype ctc
 where ctc.task_type_id in (10444);
--Configuraci?n de cantidad maximas y minimas de items por tipos de trabajo
select l.*, rowid
  from open.LDC_CMMITEMSXTT l
 where l.task_type_id in (10444);
