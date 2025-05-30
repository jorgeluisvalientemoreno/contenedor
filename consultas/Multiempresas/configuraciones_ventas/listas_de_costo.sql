--items_x_listas_de_costo
select li.items_id,
       i.description,
       li.list_unitary_cost_id,
       l.description,
       l.operating_unit_id,
       i.item_classif_id,
       li.price,
       li.sales_value,
       l.validity_start_date,
       l.validity_final_date
  from open.ge_unit_cost_ite_lis li,
       open.ge_list_unitary_cost l,
       open.ge_items             i
 where li.list_unitary_cost_id = l.list_unitary_cost_id
   and li.items_id = i.items_id
   and l.validity_final_date > sysdate
  and l.operating_unit_id in (4859)
 order by l.validity_final_date desc

--listas_de_costo
Select *
From OPEN.GE_LIST_UNITARY_COST  l
where l.list_unitary_cost_id in (4439)
order by l.list_unitary_cost_id desc









l.list_unitary_cost_id in (1608)

Select *
From OPEN.GE_LIST_UNITARY_COST  l
where l.validity_final_date > '22/11/2021'
and   l.geograp_location_id is not null

Select *
From OPEN.GE_LIST_UNITARY_COST  l
where l.list_unitary_cost_id in (3341)


Select *
From open.ldci_intelistpr  i
where i.fecha_registro >= '26/01/2020':

Select *
From open.ldci_intdetlistprec  l,
     open.ldci_intelistpr  i
where l.codigo_interfaz = i.codigo
and  l.codigo_interfaz = 17




