--ldc_item_uo_lr_fk  (ldc_const_unoprl) unidad operativas para LDCCUAI
--SELECT l.* FROM open.ldc_const_unoprl@osfpl l;
SELECT l.*
  FROM open.ldc_const_unoprl@osfpl l
 where (SELECT count(1)
          FROM open.ldc_const_unoprl l1
         where l1.unidad_operativa = l.unidad_operativa) = 0;

--ldc_item_uo_lr_fk  (ldc_const_unoprl) unidad operativas para LDCCUAI
select oou.*
  from open.or_operating_unit@osfpl oou
 where oou.operating_unit_id in
       (SELECT l.unidad_operativa FROM open.ldc_const_unoprl@osfpl l)
   and (SELECT count(1)
          FROM open.ldc_const_unoprl l1
         where l1.unidad_operativa = oou.operating_unit_id) = 0
   and (select count(1)
          from open.or_operating_unit oou1
         where oou1.operating_unit_id = oou.operating_unit_id) = 0;

--validar unidad operativa
SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr@osfpl l
 WHERE /*l.unidad_operativa = nuunidop
   AND l.actividad = rfcuorderitems.actividad
   AND */
 l.item in (select pltt0.items_id
              from open.or_task_types_items@osfpl pltt0
             where pltt0.task_type_id in
                   (select plt.task_type_id
                      from open.ct_tasktype_contype@osfpl plt
                     where plt.contract_type_id =
                           (select distinct tc.id_tipo_contrato
                              from open.ge_contrato@osfpl tc
                             where --tc.id_contrato = 9961
                             tc.id_contratista = 1
                          and id_tipo_contrato = 1)))
-- and (select count(1) from open.ge_items gi where gi.items_id = l.item) = 0
 and (SELECT count(1)
    FROM open.or_operating_unit l1
   WHERE l1.operating_unit_id = l.unidad_operativa) = 0;

--validar actividad
--Validamos la configuracion (Unidad - Actividad - Item) en la la forma LDCCUAI (Desactivar el TRIGGER)
SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr@osfpl l
 WHERE /*l.unidad_operativa = nuunidop
   AND l.actividad = rfcuorderitems.actividad
   AND */
 l.item in (select pltt0.items_id
              from open.or_task_types_items@osfpl pltt0
             where pltt0.task_type_id in
                   (select plt.task_type_id
                      from open.ct_tasktype_contype@osfpl plt
                     where plt.contract_type_id =
                           (select distinct tc.id_tipo_contrato
                              from open.ge_contrato@osfpl tc
                             where --tc.id_contrato = 9961
                             tc.id_contratista = 1
                          and id_tipo_contrato = 1)))
-- and (select count(1) from open.ge_items gi where gi.items_id = l.item) = 0
 and (SELECT count(1) FROM open.ge_items l1 WHERE l1.items_id = l.actividad) = 0;

--validar items
--Validamos la configuracion (Unidad - Actividad - Item) en la la forma LDCCUAI (Desactivar el TRIGGER)
SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr@osfpl l
 WHERE /*l.unidad_operativa = nuunidop
   AND l.actividad = rfcuorderitems.actividad
   AND */
 l.item in (select pltt0.items_id
              from open.or_task_types_items@osfpl pltt0
             where pltt0.task_type_id in
                   (select plt.task_type_id
                      from open.ct_tasktype_contype@osfpl plt
                     where plt.contract_type_id =
                           (select distinct tc.id_tipo_contrato
                              from open.ge_contrato@osfpl tc
                             where --tc.id_contrato = 9961
                             tc.id_contratista = 1
                          and id_tipo_contrato = 1)))
-- and (select count(1) from open.ge_items gi where gi.items_id = l.item) = 0
 and (SELECT count(1) FROM open.ge_items l1 WHERE l1.items_id = l.item) = 0;

select b.*
  from open.ldc_const_unoprl@osfpl b
 where (select count(1)
          from open.ldc_const_unoprl a
         where a.unidad_operativa = b.unidad_operativa) = 0;

--Validamos la configuracion (Unidad - Actividad - Item) en la la forma LDCCUAI (Desactivar el TRIGGER)
SELECT l.* --distinct l.item ||',' --
  FROM open.ldc_item_uo_lr@osfpl l
 WHERE /*l.unidad_operativa = nuunidop
   AND l.actividad = rfcuorderitems.actividad
   AND */
 l.item in (select pltt0.items_id
              from open.or_task_types_items@osfpl pltt0
             where pltt0.task_type_id in
                   (select plt.task_type_id
                      from open.ct_tasktype_contype@osfpl plt
                     where plt.contract_type_id =
                           (select distinct tc.id_tipo_contrato
                              from open.ge_contrato@osfpl tc
                             where --tc.id_contrato = 9961
                             tc.id_contratista = 1
                          and id_tipo_contrato = 1)))
-- and (select count(1) from open.ge_items gi where gi.items_id = l.item) = 0
 and (SELECT count(1)
    FROM open.ldc_item_uo_lr l1
   WHERE l1.unidad_operativa || '-' || l1.actividad || '-' || l1.item =
         l.unidad_operativa || '-' || l.actividad || '-' || l.item) = 0;

--Maximos y minimos tt e items 
select max(l.itemsxtt_id) from LDC_CMMITEMSXTT l;
select l.*, rowid
  from open.LDC_CMMITEMSXTT@osfpl l
 where l.task_type_id in
       (select tt0.task_type_id
          from open.OR_TASK_TYPE tt0
         where tt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id =
                       (select distinct tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where --tc.id_contrato = 9961
                         tc.id_contratista = 1
                      and id_tipo_contrato = 1)))
   and (select count(1)
          from open.LDC_CMMITEMSXTT l1
         where l1.task_type_id = l.task_type_id) = 0;
select l.*, rowid from open.LDC_CMMITEMSXTT l where l.task_type_id = 11318;
--select SEQLDC_CMMITEMSXTT.nextval from dual

--Lista de costos
select pltt.*, rowid
  from open.or_task_type@osfpl pltt
 where pltt.task_type_id in
       (select pltt0.task_type_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id =
                       (select distinct tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where --tc.id_contrato = 9961
                         tc.id_contratista = 1
                      and id_tipo_contrato = 1))
           and (select count(1)
                  from open.or_task_type tt
                 where tt.task_type_id = pltt0.task_type_id) = 0);

--lista de costos 
select distinct pl3.*
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1,
       open.GE_ITEMS@osfpl             pl2,
       open.GE_LIST_UNITARY_COST@osfpl pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in
       (select TT0.ITEMS_ID
          from open.or_task_types_items@osfpl tt0
         where tt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id =
                       (select distinct tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where --tc.id_contrato = 9961
                         tc.id_contratista = 1
                      and id_tipo_contrato = 1)))
   and pl1.Last_Update_Date >= '01/01/2023'
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.Last_Update_Date >= '01/01/2023'
           and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
               (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0;

--lista entre pl y qh
select *
  from open.GE_LIST_UNITARY_COST@osfpl pl1
 where pl1.list_unitary_cost_id = 4026
   and (select count(1)
          from open.GE_LIST_UNITARY_COST qh1
         where qh1.list_unitary_cost_id = pl1.list_unitary_cost_id) = 0;

--Lista de costos x items
select distinct pl1.* --, (pl1.items_id || '-' || pl1.list_unitary_cost_id)
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1,
       open.GE_ITEMS@osfpl             pl2,
       open.GE_LIST_UNITARY_COST@osfpl pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in
       (select TT0.ITEMS_ID
          from open.or_task_types_items@osfpl tt0
         where tt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id =
                       (select distinct tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where --tc.id_contrato = 9961
                         tc.id_contratista = 1
                      and id_tipo_contrato = 1)))
   and pl1.Last_Update_Date >= '01/01/2023'
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.Last_Update_Date >= '01/01/2023'
           and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
               (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0;
/*and (select count(1)
 from open.GE_UNIT_COST_ITE_LIS qh1,
      open.GE_ITEMS             qh2,
      open.GE_LIST_UNITARY_COST qh3
where qh2.ITEMS_ID = qh1.ITEMS_ID
  and qh3.LIST_UNITARY_COST_ID = qh1.LIST_UNITARY_COST_ID
  and qh1.ITEMS_ID in
      (select TT0.ITEMS_ID
         from open.or_task_types_items@osfpl tt0
        where tt0.task_type_id in
              (select t.task_type_id
                 from open.ct_tasktype_contype@osfpl t
                where t.contract_type_id =
                      (select tc.id_tipo_contrato
                         from open.ge_contrato@osfpl tc
                        where tc.id_contrato = 9961)))
  and qh1.Last_Update_Date >= '01/01/2023'
  and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
      (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0*/
;
--and qh1.list_unitary_cost_id = pl1.list_unitary_cost_id) = 0;

select plt.*
  from open.GE_UNIT_COST_ITE_LIS@osfpl plt
 where plt.last_update_date >= '31/05/2023'
   and plt.items_id in
       (select pltt0.items_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id = 910))
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS t
         where t.last_update_date >= '31/05/2023'
           and t.items_id in
               (select pltt0.items_id
                  from open.or_task_types_items pltt0
                 where pltt0.task_type_id in
                       (select plt.task_type_id
                          from open.ct_tasktype_contype plt
                         where plt.contract_type_id = 910))
           and (t.items_id || '-' || t.list_unitary_cost_id) =
               (plt.items_id || '-' || plt.list_unitary_cost_id)) = 0;

--ROLES POR UNIDAD DE TRABAJO
select *
  from open.OR_ROL_UNIDAD_TRAB@osfpl a
 where a.id_unidad_operativa in (4442) --(4416, 4417, 4418, 4419, 4420, 4421)
   and (select count(1)
          from open.OR_ROL_UNIDAD_TRAB b
         where b.id_unidad_operativa || '-' || b.id_rol =
               a.id_unidad_operativa || '-' || a.id_rol) = 0;
