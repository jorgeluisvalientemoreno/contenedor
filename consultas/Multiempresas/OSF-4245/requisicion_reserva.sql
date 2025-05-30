select docu.id_items_documento,
       docu.document_type_id,
       docu.fecha,
       docu.estado,
       docu.operating_unit_id,
       docu.destino_oper_uni_id,
       up.name,
       docu.comentario,
       docu.delivery_date,
       requ.items_request_id,
       requ.id_items_documento,
       requ.items_id,
       i.description,
       requ.request_amount,
       requ.unitary_cost,
       requ.confirmed_amount,
       requ.rejected_amount,
       requ.accepted_amount,
       requ.confirmed_cost
 from open.ge_items_documento docu
left outer join open.ge_items_request requ on docu.id_items_documento = requ.id_items_documento
left outer join ge_items i  on  i.items_id = requ.items_id
left outer join or_operating_unit  up  on up.operating_unit_id = docu.destino_oper_uni_id
 where 1 = 1
 and docu.id_items_documento = 1500778
 --and docu.estado = 'R'
 order by  docu.id_items_documento desc
 
 --and docu.operating_unit_id = 4642
 --and i.item_classif_id = 3
 
--1500812 reserva herramienta GDCA
--1500814 reserva herramienta GDGU
