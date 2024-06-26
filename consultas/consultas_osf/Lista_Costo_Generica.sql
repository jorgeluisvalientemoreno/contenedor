select distinct GE_UNIT_COST_ITE_LIS.*
  from open.GE_UNIT_COST_ITE_LIS,
       OPEN.GE_LIST_UNITARY_COST,
       open.ge_items gi
 where GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID =
       open.GE_UNIT_COST_ITE_LIS.list_unitary_cost_id
   and GE_LIST_UNITARY_COST.geograp_location_id is null
   and GE_LIST_UNITARY_COST.contract_id is null
   and GE_LIST_UNITARY_COST.contractor_id is null
   and GE_LIST_UNITARY_COST.operating_unit_id is null
   and gi.items_id = GE_UNIT_COST_ITE_LIS.items_id
   and gi.description like 'MATERIA%'
   and open.GE_UNIT_COST_ITE_LIS.list_unitary_cost_id = 4235
 order by open.GE_LIST_UNITARY_COST.validity_start_date desc
