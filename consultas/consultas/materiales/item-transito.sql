select  /*+ leading(or_uni_item_bala_mov)
           index(or_uni_item_bala_mov idx_or_uni_item_bala_mov01)
           index(ge_items_seriado pk_ge_items_seriado)
           index(ge_items pk_ge_items)
           index(ge_items_documento pk_ge_items_documento)*/
        or_uni_item_bala_mov.id_items_documento,
        move_date move_date,
        ge_items.items_id||' - '||ge_items.description description,
        ge_items.code code,
        or_uni_item_bala_mov.amount,
        or_uni_item_bala_mov.total_value,
        ge_items_seriado.serie,
        or_uni_item_bala_mov.target_oper_unit_id operating_unit_id, (select name from open.or_operating_unit u where u.operating_unit_id=or_uni_item_bala_mov.target_oper_unit_id) nombre,
        or_uni_item_bala_mov.user_id,
        or_uni_item_bala_mov.operating_unit_id target_oper_unit_id, (select name from open.or_operating_unit u where u.operating_unit_id=or_uni_item_bala_mov.operating_unit_id) nombre,
        ge_items.item_classif_id
  from  open.or_uni_item_bala_mov,
        open.or_ope_uni_item_bala,
        open.ge_items_seriado,
        open.ge_items,
        open.ge_items_documento
 where  or_uni_item_bala_mov.items_id = ge_items.items_id
   and  or_uni_item_bala_mov.items_id = or_ope_uni_item_bala.items_id
   and  or_uni_item_bala_mov.operating_unit_id = or_ope_uni_item_bala.operating_unit_id
   and  or_uni_item_bala_mov.movement_type = 'n' 
   and  or_uni_item_bala_mov.id_items_documento = ge_items_documento.id_items_documento
   and  or_uni_item_bala_mov.support_document = ' '
   and  or_uni_item_bala_mov.id_items_seriado = ge_items_seriado.id_items_seriado (+)
   --dsaltarin 05/12/2018 se agrega esta condición debido a que se identifico con laboratorio y se encuentran movimienots 
   --que no deberian salir, se escalo el tema a open bajo el sao 464787 y la respuesta es que solo se deben tener en cuenta los movimientos con estas causales
   and  or_uni_item_bala_mov.item_moveme_caus_id in (--15, --ge_boitemsconstants.cnucausalentfactcompra
                                                     6,  --ge_boitemsconstants.cnucausaltranslate,
                                                     20) --ge_boitemsconstants.cnumovcausetrans)
