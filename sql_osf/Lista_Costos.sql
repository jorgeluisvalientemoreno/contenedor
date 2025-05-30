---Lista de costo
select * from open.GE_LIST_UNITARY_COST pl3;

--Lista de costos
select pltt.*, rowid
  from open.or_task_type pltt
 where pltt.task_type_id in
       (select pltt0.task_type_id
          from open.or_task_types_items pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype plt
                 where plt.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato tc
                         where tc.id_contrato = 8341)));

--lista de costos 
select pl1.*
  from open.GE_UNIT_COST_ITE_LIS pl1,
       open.GE_ITEMS             pl2,
       open.GE_LIST_UNITARY_COST pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in (4295270)
--and pl1.list_unitary_cost_id = 4026
--and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
--and pl3.validity_start_date >= '01/01/2023'
;

select *
  from open.GE_LIST_UNITARY_COST pl1
-- where pl1.list_unitary_cost_id in (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042)
;

--Lista de costos x items x contratista
select distinct pl1.* --, (pl1.items_id || '-' || pl1.list_unitary_cost_id)
  from open.GE_UNIT_COST_ITE_LIS pl1,
       open.GE_ITEMS             pl2,
       open.GE_LIST_UNITARY_COST pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in
       (select TT0.ITEMS_ID
          from open.or_task_types_items tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype t
                 where t.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato t
                                 where t.id_contratista in (25, 2791)))));
