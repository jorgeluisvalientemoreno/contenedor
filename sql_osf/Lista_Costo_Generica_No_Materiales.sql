SELECT distinct u.operating_unit_id,
                u.name,
                u.contractor_id,
                l.list_unitary_cost_id
  FROM open.or_operating_unit u
 inner join open.or_ope_uni_task_type ut
    on ut.operating_unit_id = u.operating_unit_id
 inner join open.or_task_type t
    on t.task_type_id in (12150, 12149)
   and ut.task_type_id = t.task_type_id
 inner join open.ge_list_unitary_cost l
    on l.operating_unit_id = u.operating_unit_id
   and sysdate between l.validity_start_date and l.validity_final_date
 WHERE u.oper_unit_status_id in (1, 3)
   and PKG_BCCONTRATOCONTRATISTA.fsbContratoVigentexTipTra(t.task_type_id,
                                                           u.contractor_id) = 'S';

SELECT distinct u.operating_unit_id,
                u.name,
                u.contractor_id,
                l.list_unitary_cost_id
  FROM open.or_operating_unit u
 inner join open.or_ope_uni_task_type ut
    on ut.operating_unit_id = u.operating_unit_id
 inner join open.or_task_type t
    on t.task_type_id in (12162)
   and ut.task_type_id = t.task_type_id
 inner join open.ge_list_unitary_cost l
    on l.operating_unit_id = u.operating_unit_id
   and sysdate between l.validity_start_date and l.validity_final_date
 WHERE u.oper_unit_status_id in (1, 3)
   and PKG_BCCONTRATOCONTRATISTA.fsbContratoVigentexTipTra(t.task_type_id,
                                                           u.contractor_id) = 'S';

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
   and upper(GE_LIST_UNITARY_COST.DESCRIPTION) not like '%MATERIA%'
   and trunc(sysdate) between GE_LIST_UNITARY_COST.VALIDITY_START_DATE and
       GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE
   and gi.items_id = GE_UNIT_COST_ITE_LIS.items_id
 order by GE_UNIT_COST_ITE_LIS.items_id
