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

select l.list_unitary_cost_id, l.description
  from open.ge_list_unitary_cost l
 where l.contract_id is null
   and l.operating_unit_id is null
   and l.contractor_id is null
   and l.geograp_location_id is null
   and description like '%MATERIALES%'
   and sysdate between l.validity_start_date and l.validity_final_date
