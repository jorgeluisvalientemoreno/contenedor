select l.list_unitary_cost_id, l.description
  from open.ge_list_unitary_cost l
 where l.contract_id is null
   and l.operating_unit_id is null
   and l.contractor_id is null
   and l.geograp_location_id is null
   and description like '%MATERIALES%'
   and sysdate between l.validity_start_date and l.validity_final_date;

select GE_UNIT_COST_ITE_LIS.items_id || ' - ' || gi.description "Item",
       GE_UNIT_COST_ITE_LIS.list_unitary_cost_id || ' - ' ||
       GE_LIST_UNITARY_COST.DESCRIPTION "Lista Costo",
       OPEN.GE_LIST_UNITARY_COST.VALIDITY_START_DATE "Fecha Inicio Vigencia",
       OPEN.GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE "Fecha Inicio Vigencia",
       GE_UNIT_COST_ITE_LIS.last_update_date "Ultima Fecha Actualizacion",
       GE_UNIT_COST_ITE_LIS.price "Precio",
       GE_UNIT_COST_ITE_LIS.sales_value "Valor Venta",
       GE_UNIT_COST_ITE_LIS.user_id || ' - ' ||
       (select gp.name_
          from OPEN.ge_person gp
         where gp.user_id in
               (select su.user_id
                  from OPEN.SA_USER su
                 where su.mask = GE_UNIT_COST_ITE_LIS.user_id)) "Usuario",
       GE_UNIT_COST_ITE_LIS.terminal "Terminal"
  from open.GE_UNIT_COST_ITE_LIS,
       OPEN.GE_LIST_UNITARY_COST,
       open.ge_items gi
 where GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID =
       open.GE_UNIT_COST_ITE_LIS.list_unitary_cost_id
   and GE_LIST_UNITARY_COST.geograp_location_id is null
   and GE_LIST_UNITARY_COST.contract_id is null
   and GE_LIST_UNITARY_COST.contractor_id is null
   and GE_LIST_UNITARY_COST.operating_unit_id is null
   and upper(GE_LIST_UNITARY_COST.DESCRIPTION) like '%MATERIA%'
   and trunc(sysdate) between GE_LIST_UNITARY_COST.VALIDITY_START_DATE and
       GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE
   and gi.items_id = GE_UNIT_COST_ITE_LIS.items_id
 order by GE_UNIT_COST_ITE_LIS.items_id
