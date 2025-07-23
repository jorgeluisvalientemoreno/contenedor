SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
 ge_unit_cost_ite_lis.list_unitary_cost_id,
 ge_unit_cost_ite_lis.price,
 ge_unit_cost_ite_lis.sales_value,
 ge_list_unitary_cost.validity_start_date,
 ge_list_unitary_cost.validity_final_date
  FROM ge_list_unitary_cost, ge_unit_cost_ite_lis
 WHERE 1 = 1
   --and ge_list_unitary_cost.operating_unit_id = &inuUnidadOper
   AND ge_list_unitary_cost.list_unitary_cost_id =
       ge_unit_cost_ite_lis.list_unitary_cost_id
   AND trunc(sysdate) BETWEEN ge_list_unitary_cost.validity_start_date AND
       ge_list_unitary_cost.validity_final_date
   AND ge_unit_cost_ite_lis.items_id in (4295150, 4295273);

SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
 ge_unit_cost_ite_lis.list_unitary_cost_id,
 ge_unit_cost_ite_lis.price,
 ge_unit_cost_ite_lis.sales_value,
 ge_list_unitary_cost.validity_start_date,
 ge_list_unitary_cost.validity_final_date
  FROM ge_list_unitary_cost, ge_unit_cost_ite_lis
 WHERE ge_list_unitary_cost.contractor_id = &inuContratista
   AND ge_list_unitary_cost.list_unitary_cost_id =
       ge_unit_cost_ite_lis.list_unitary_cost_id
   AND trunc(sysdate) BETWEEN ge_list_unitary_cost.validity_start_date AND
       ge_list_unitary_cost.validity_final_date
   AND ge_unit_cost_ite_lis.items_id = &inuIdItem;

SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
 ge_unit_cost_ite_lis.list_unitary_cost_id,
 ge_unit_cost_ite_lis.price,
 ge_unit_cost_ite_lis.sales_value,
 ge_list_unitary_cost.validity_start_date,
 ge_list_unitary_cost.validity_final_date
  FROM ge_list_unitary_cost, ge_unit_cost_ite_lis
 WHERE ge_list_unitary_cost.contract_id = &inuContract
   AND ge_list_unitary_cost.list_unitary_cost_id =
       ge_unit_cost_ite_lis.list_unitary_cost_id
   AND trunc(sysdate) BETWEEN ge_list_unitary_cost.validity_start_date AND
       ge_list_unitary_cost.validity_final_date
   AND ge_unit_cost_ite_lis.items_id = &inuIdItem;

SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
 ge_unit_cost_ite_lis.list_unitary_cost_id,
 ge_unit_cost_ite_lis.price,
 ge_unit_cost_ite_lis.sales_value,
 ge_list_unitary_cost.validity_start_date,
 ge_list_unitary_cost.validity_final_date
  FROM ge_list_unitary_cost, ge_unit_cost_ite_lis
 WHERE ge_list_unitary_cost.geograp_location_id = &inuGeoLocationId
   AND ge_list_unitary_cost.list_unitary_cost_id =
       ge_unit_cost_ite_lis.list_unitary_cost_id
   AND trunc(sysdate) BETWEEN ge_list_unitary_cost.validity_start_date AND
       ge_list_unitary_cost.validity_final_date
   AND ge_unit_cost_ite_lis.items_id = &inuIdItem;

SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
 ge_unit_cost_ite_lis.items_id,
 ge_unit_cost_ite_lis.list_unitary_cost_id,
 ge_unit_cost_ite_lis.price,
 ge_unit_cost_ite_lis.sales_value,
 ge_list_unitary_cost.validity_start_date,
 ge_list_unitary_cost.validity_final_date
  FROM ge_list_unitary_cost, ge_unit_cost_ite_lis
 WHERE 1 = 1
      --and ge_list_unitary_cost.contract_id IS NULL
      --AND ge_list_unitary_cost.contractor_id IS NULL
      --AND ge_list_unitary_cost.operating_unit_id IS NULL
      --AND ge_list_unitary_cost.geograp_location_id IS NULL
   AND ge_list_unitary_cost.list_unitary_cost_id =
       ge_unit_cost_ite_lis.list_unitary_cost_id
      /*
      AND trunc(sysdate) BETWEEN
      ge_list_unitary_cost.validity_start_date AND
      ge_list_unitary_cost.validity_final_date
      --*/
   AND ge_unit_cost_ite_lis.items_id = &inuIdItem;
