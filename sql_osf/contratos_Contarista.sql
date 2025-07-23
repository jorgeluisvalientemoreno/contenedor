select * --id_contrato, descripcion,id_contratista,  valor_anticipo, anticipo_amortizado
  from open.ge_contrato
 where id_contratista = (select oou.contractor_id from open.or_operating_unit oou where oou.operating_unit_id =4209)
   and status = 'AB';
--where id_contrato in (81,83);
--select seq_ct_tasktype_con_143315.nextval from dual --5612,
SELECT t.*,rowid FROM OPEN.CT_TASKTYPE_CONTYPE t WHERE t.contract_type_id in(18,890) -- TASK_TYPE_ID = 11359;--11412
select contractor_id
  from open.or_operating_unit
 where operating_unit_id = 1940;
select *
  from OPEN.ct_conpla_con_type c, open.ge_contrato co
 WHERE (CONTRACT_TYPE_ID = co.id_tipo_contrato or
       co.id_contrato = c.contract_id)
   and id_contrato = 3941;
select * from open.ge_contrato where id_contrato = 6901;
SELECT * FROM OPEN.ldc_antic_contr WHERE IDCONTRATO = 1441;
--11390
--OPEN.CT_PROCESS_LOG
--CT_CONDITIONS_BY_PLAN
select *
  from open.CT_CONDITIONS_BY_PLAN pc, open.ct_conditions s
 where pc.conditions_plan_id = 324
   and pc.conditions_id = s.conditions_id
   and s.conditions_id = 579;
select *
  from open.CT_CONDITIONS_BY_PLAN pc, open.ct_simple_condition s
 where pc.conditions_plan_id = 324
   and pc.items_id = s.items_id;
select * from open.ldc_tasktype_contype_hist where tipo_trabajo = 12587;
select id_contrato,
       co.status,
       co.descripcion,
       id_tipo_contrato,
       co.fecha_inicial,
       co.fecha_final,
       (select c.fecha_maxasig
          from open.ldc_contfema c
         where c.id_contrato = co.id_contrato) fecha_max_asig,
       id_contratista,
       co.valor_asignado,
       co.valor_liquidado,
       co.valor_no_liquidado,
       co.valor_total_contrato,
       co.valor_total_pagado,
       co.valor_total_contrato - nvl(co.valor_asignado, 0) -
       nvl(co.valor_no_liquidado, 0) - nvl(co.valor_liquidado, 0) cupo
  from open.ge_contrato co
--where id_contrato=6861 
 where id_contratista in
       (select contractor_id
          from open.or_operating_unit
         where operating_unit_id = 4118)
   and status = 'AB'
   and exists
 (select null
          from open.ct_tasktype_contype c
         where c.contract_id = co.id_contrato
           and task_type_id = 10734
        union
        select null
          from open.ct_tasktype_contype c, open.ge_contrato co2
         where c.contract_type_id = co2.id_tipo_contrato
           and co2.id_contrato = co.id_contrato
           and task_type_id = 10734
           and not exists
         (select null
                  from open.ct_tasktype_contype c2
                 where c2.contract_id = co2.id_contrato));
select * from open.ge_contrato where id_contrato in (3941, 4061, 4861);
select *
  from OPEN.ct_conpla_con_type c
 where c.contract_id in (3941, 4061, 4861);
select * from OPEN.CT_CONDITIONS_BY_PLAN WHERE CONDITIONS_PLAN_ID = 324;
select *
  from OPEN.CT_SIMPLE_CONDITION C, OPEN.GE_ITEMS I
 WHERE C.ITEMS_ID IN (100002360, 100002359, 100002361)
   AND C.ITEMS_ID = I.ITEMS_ID;
