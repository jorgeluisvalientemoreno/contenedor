-- TRANSITO SALIENTE
SELECT * FROM
(SELECT
    ge_items.items_id,
    ge_items.description description,
    ge_items.measure_unit_id,
    or_ope_uni_item_bala.balance,
    sum(or_uni_item_bala_mov.amount) TRANSITO_REAL,
    --or_uni_item_bala_mov.operating_unit_id,
    or_uni_item_bala_mov.target_oper_unit_id,
    or_ope_uni_item_bala.transit_OUT
FROM  or_uni_item_bala_mov,
        or_ope_uni_item_bala,
        ge_items_seriado,
        ge_items
 WHERE  or_uni_item_bala_mov.items_id = ge_items.items_id
   AND  or_uni_item_bala_mov.items_id = or_ope_uni_item_bala.items_id
   --AND  or_uni_item_bala_mov.operating_unit_id = or_ope_uni_item_bala.operating_unit_id
   AND  or_uni_item_bala_mov.target_oper_unit_id = or_ope_uni_item_bala.operating_unit_id
   -- AND  or_uni_item_bala_mov.operating_unit_id = inuOperatUniId
   AND  or_uni_item_bala_mov.movement_type = 'N'
   AND  or_uni_item_bala_mov.item_moveme_caus_id
    IN  (   20,       --  6
            6,     -- 20
            --15  -- 15
        )
   AND  or_uni_item_bala_mov.support_document = ' '
   AND  or_uni_item_bala_mov.id_items_seriado = ge_items_seriado.id_items_seriado (+)


   GROUP BY         ge_items.items_id,
    ge_items.description ,
    ge_items.measure_unit_id,
    or_ope_uni_item_bala.balance,
    --or_uni_item_bala_mov.operating_unit_id,
    or_uni_item_bala_mov.target_oper_unit_id,
    or_ope_uni_item_bala.transit_OUT
    ) WHERE TRANSITO_REAL != transit_OUT