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
