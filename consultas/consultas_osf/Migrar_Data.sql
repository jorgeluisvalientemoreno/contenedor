--Despues de crear contrato, ejecutamos CTAACN - Acta de apertura de contrato
--tipo de trabajo por tipo de contrato
select ctc.*, rowid
  from open.ct_tasktype_contype ctc
 where ctc.task_type_id in (11345);
--Concepto
select a.*, rowid from open.concepto a where a.conccodi = 1007;
--Tipo de trabajo
select ott.*, rowid
  from open.or_task_type ott
 where ott.task_type_id in (11345);
---Items  - Actividad
select gi.*, rowid
  from open.ge_items gi
 where gi.items_id in (100010368, 100010375);
---Causal
select a.*, rowid from OPEN.GE_CAUSAL a where a.causal_id in (3857, 9694);
--Tipo trabajo - Causal 
select a.*, rowid
  from OPEN.OR_TASK_TYPE_CAUSAL a
 where a.task_type_id in (11345);
--Tipo trabajo - Actividad
select otti.*, rowid
  from open.or_task_types_items otti
 where otti.task_type_id in (11368) -- and otti.items_id in (100010374, 100010373)
;
--items para actividad e orden
select a.*, rowid from OPEN.OR_ACTIVIDAD a where a.id_actividad =100010373; 
--Actividad - Rol
select oar.*, rowid
  from open.or_actividades_rol oar
 where oar.id_actividad in
       (select otti.items_id
          from open.or_task_types_items otti
         where otti.task_type_id in (11345));
--ITEMS PERMITIDOS LEGALIZAR LAS UNIDADES OPERATIVAS QUE APLICAN PARA NUEVO ESQUEMA DE LIQUIDACION
SELECT l.*, ROWID --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr l
 where l.actividad in (select otti.items_id
                         from open.or_task_types_items otti
                        where otti.task_type_id in (11345))
   AND l.item in (select otti.items_id
                    from open.or_task_types_items otti
                   where otti.task_type_id in (11345));
--Maximos y minimos tt e items
select l.*, rowid
  from open.LDC_CMMITEMSXTT l
 where (l.activity_id in (100010374, 100010373, 10011231) or
       l.items_id in (100010374, 100010373, 10011231))
   AND l.task_type_id in (11345)
 order by l.itemsxtt_id desc;
--Configuraci?n de cantidad m?ximas y m?nimas de ?tems por tipos de trabajo
select l.* from open.LDC_CMMITEMSXTT l where l.task_type_id in (11345);
---Lista de costo
select a.*, rowid
  from open.GE_LIST_UNITARY_COST a
 where a.list_unitary_cost_id = 1;
---Lista de cosro - Item 
select b.*, rowid
  from open.GE_UNIT_COST_ITE_LIS b
 where b.items_id in (100010373,
                      --10011231
                      100010374)
/*(select otti.items_id
 from open.or_task_types_items otti
where otti.task_type_id in (11345))*/
 order by b.last_update_date;
--unidad operativa
select oou.*, rowid
  from open.or_operating_unit oou
 where oou.operating_unit_id in (4685);
--ROLES POR UNIDAD DE TRABAJO
select a.*, rowid
  from open.OR_ROL_UNIDAD_TRAB a
 where a.id_unidad_operativa in (4685);
--ROLES POR UNIDAD DE TRABAJO
select c.*, rowid from open.OR_ROL_UNIDAD_TRAB c where c.id_rol = 8290;
--Funcional - Unidad Operativa
select a.*, rowid
  from OPEN.OR_OPER_UNIT_PERSONS a
 where a.operating_unit_id = 4685;
