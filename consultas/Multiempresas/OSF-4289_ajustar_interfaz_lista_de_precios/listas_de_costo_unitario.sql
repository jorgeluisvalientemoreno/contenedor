--listas_de_costo_genericas
select *
from ge_list_unitary_cost lc
where lc.contractor_id is null
 and  lc.contract_id is null
 and  lc.operating_unit_id is null  
 and  lc.geograp_location_id is null
order by lc.validity_final_date desc;

--= 4594
 --and dlc.items_id in (100010575, 100010648)

--update ge_list_unitary_cost lc2 set lc2.validity_start_date = '01/07/2025' where lc2.list_unitary_cost_id = 4474
