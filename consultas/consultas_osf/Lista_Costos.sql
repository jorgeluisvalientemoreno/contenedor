---Lista de costo
select *
  from open.GE_LIST_UNITARY_COST@osfpl pl3
 where (select count(1)
          from open.GE_LIST_UNITARY_COST qh3
         where qh3.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0;

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
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato = 8341))
           and (select count(1)
                  from open.or_task_type tt
                 where tt.task_type_id = pltt0.task_type_id) = 0);

--lista de costos 
--mostrar resultado de cada entidad PL1, PL2 y PL3
select distinct pl1.*
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1,
       open.GE_ITEMS@osfpl             pl2,
       open.GE_LIST_UNITARY_COST@osfpl pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in
       (select TT0.ITEMS_ID
          from open.or_task_types_items@osfpl tt0
         where tt0.task_type_id in
               (select t.task_type_id
                  from open.ct_tasktype_contype@osfpl t
                 where t.contract_type_id =
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato = 8341)))
   and pl1.Last_Update_Date >= '01/01/2023'
   and pl2.items_id in (100004544,
                        100004540,
                        100004541,
                        100004542, --medidores
                        100004558,
                        100004551,
                        100004548,
                        100004556, --jaulas
                        100003135, -- tuberia
                        100004525,
                        100004524,
                        100004531,
                        100004527,
                        100004534,
                        100006936,
                        100004530,
                        100004529, --material tubería
                        100004566 -- conector flexible
                        )
      --and pl1.list_unitary_cost_id = 4026
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.Last_Update_Date >= '01/01/2023'
           and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
               (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0;

--Lista costo productivo PL
select pl1.*
  from open.GE_UNIT_COST_ITE_LIS@osfpl pl1,
       open.GE_ITEMS@osfpl             pl2,
       open.GE_LIST_UNITARY_COST@osfpl pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in (100004544,
                        100004540,
                        100004541,
                        100004542, --medidores
                        100004558,
                        100004551,
                        100004548,
                        100004556, --jaulas
                        100003135, -- tuberia
                        100004525,
                        100004524,
                        100004531,
                        100004527,
                        100004534,
                        100006936,
                        100004530,
                        100004529, --material tubería
                        100004566 -- conector flexible
                        )
      --and pl1.list_unitary_cost_id = 4026
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and pl3.validity_start_date >= '01/01/2023'
minus 
select pl1.*
  from open.GE_UNIT_COST_ITE_LIS pl1,
       open.GE_ITEMS pl2,
       open.GE_LIST_UNITARY_COST pl3
 where pl2.ITEMS_ID = pl1.ITEMS_ID
   and pl3.LIST_UNITARY_COST_ID = pl1.LIST_UNITARY_COST_ID
   and pl1.ITEMS_ID in (100004544,
                        100004540,
                        100004541,
                        100004542, --medidores
                        100004558,
                        100004551,
                        100004548,
                        100004556, --jaulas
                        100003135, -- tuberia
                        100004525,
                        100004524,
                        100004531,
                        100004527,
                        100004534,
                        100006936,
                        100004530,
                        100004529, --material tubería
                        100004566 -- conector flexible
                        )
      --and pl1.list_unitary_cost_id = 4026
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and pl3.validity_start_date >= '01/01/2023'
   ;

--lista entre pl y qh
select *
  from open.GE_LIST_UNITARY_COST@osfpl pl1
 where
--pl1.list_unitary_cost_id in (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042) and 
 (select count(1)
    from open.GE_LIST_UNITARY_COST qh1
   where qh1.list_unitary_cost_id = pl1.list_unitary_cost_id) = 0;

select pl1.LIST_UNITARY_COST_ID, pl1.CONTRATOR_ID
  from open.GE_LIST_UNITARY_COST@osfpl pl1
-- where pl1.list_unitary_cost_id in
--       (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042)
;
select pl1.LIST_UNITARY_COST_ID, pl1.CONTRATOR_ID
  from open.GE_LIST_UNITARY_COST pl1
-- where pl1.list_unitary_cost_id in
--       (4049, 4047, 4045, 1, 4050, 4051, 4048, 4046, 4042)
;

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
               (select t.task_type_id
                  from open.ct_tasktype_contype@osfpl t
                 where t.contract_type_id in
                       (select tc.id_tipo_contrato
                          from open.ge_contrato@osfpl tc
                         where tc.id_contrato in
                               (select t.id_contrato
                                  from open.ge_contrato@osfpl t
                                 where t.id_contratista in (25, 2791)))))
      --and pl1.Last_Update_Date >= '01/01/2023'
      --and (select count(1) from open.GE_LIST_UNITARY_COST a where a.list_unitary_cost_id = pl3.list_unitary_cost_id) = 0
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS qh1
         where qh1.Last_Update_Date >= '01/01/2023'
           and (qh1.items_id || '-' || qh1.list_unitary_cost_id) =
               (pl1.items_id || '-' || pl1.list_unitary_cost_id)) = 0
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
 where plt.last_update_date >= '31/12/2023'
   and plt.items_id in
       (select pltt0.items_id
          from open.or_task_types_items@osfpl pltt0
         where pltt0.task_type_id in
               (select plt.task_type_id
                  from open.ct_tasktype_contype@osfpl plt
                 where plt.contract_type_id = 18))
   and (select count(1)
          from open.GE_UNIT_COST_ITE_LIS t
         where t.last_update_date >= '31/12/2023'
           and t.items_id in
               (select pltt0.items_id
                  from open.or_task_types_items pltt0
                 where pltt0.task_type_id in
                       (select plt.task_type_id
                          from open.ct_tasktype_contype plt
                         where plt.contract_type_id = 18))
           and (t.items_id || '-' || t.list_unitary_cost_id) =
               (plt.items_id || '-' || plt.list_unitary_cost_id)) = 0;
