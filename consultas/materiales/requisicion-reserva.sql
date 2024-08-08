select docu.*, 
       requ.*
 from open.ge_items_documento docu
inner join open.ge_items_request requ on docu.id_items_documento = requ.id_items_documento
 where docu.id_items_documento = &documento
