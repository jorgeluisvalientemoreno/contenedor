SELECT distinct u.operating_unit_id,
                u.name,
                u.contractor_id,
                l.list_unitary_cost_id
  FROM open.or_operating_unit u
 inner join open.or_ope_uni_task_type ut
    on ut.operating_unit_id = u.operating_unit_id
 inner join open.or_task_type t
--on t.task_type_id in (12150, 12149)
and ut.task_type_id = t.task_type_id
 inner join open.ge_list_unitary_cost l
    on l.operating_unit_id = u.operating_unit_id
   and sysdate between l.validity_start_date and l.validity_final_date
 WHERE 1 = 1
   and u.oper_unit_status_id in (1, 3)
   and PKG_BCCONTRATOCONTRATISTA.fsbContratoVigentexTipTra(t.task_type_id,
                                                           u.contractor_id) = 'S';

select *
  from open.GE_UNIT_COST_ITE_LIS, OPEN.GE_LIST_UNITARY_COST
 where GE_UNIT_COST_ITE_LIS.ITEMS_ID = 4000360
   and GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID =
       open.GE_UNIT_COST_ITE_LIS.list_unitary_cost_id
   and GE_LIST_UNITARY_COST.OPERATING_UNIT_ID is null
   and '28/05/2024' between GE_LIST_UNITARY_COST.validity_start_date and
       GE_LIST_UNITARY_COST.validity_final_date
   and GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID in
       (5, 6, 157, 163, 192, 201);
