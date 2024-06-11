SELECT distinct operating_unit_id
                FROM
                (
                    SELECT Item,
                           description,
                           Code,
                           Cuota,
                           Cuota_Ocacional,
                           Saldo,
                           Transito_Entrante,
                           Pendiente,
                           Cuota + Cuota_Ocacional - Saldo - Transito_Entrante - Pendiente A_Solicitar,
                           Costo_Unit,
                           Seriado,
                           operating_unit_id
                    FROM
                    (
                        SELECT /*+index(or_ope_uni_item_bala IDX_OR_OPE_UNI_ITEM_BALA_01)
                                  index(ge_items PK_GE_ITEMS)
                                  index(ge_items_tipo PK_GE_ITEMS_TIPO)*/
                                  or_ope_uni_item_bala.operating_unit_id, 
                               or_ope_uni_item_bala.items_id Item,
                               ge_items.description description,
                               ge_items.code Code,
                               or_ope_uni_item_bala.quota Cuota,
                               or_ope_uni_item_bala.balance Saldo,
                               nvl(or_ope_uni_item_bala.occacional_quota,0) Cuota_Ocacional,
                               nvl(or_ope_uni_item_bala.transit_in,0) Transito_Entrante,
                               OPEN.GE_BCItemsRequest.fnuAmountRequestItem  -- Solicitudes registradas que aún no están en transito
                               (
                                 or_ope_uni_item_bala.operating_unit_id, --&inuRequestOperUnit,
                                 or_ope_uni_item_bala.items_id
                               ) Pendiente,
                               OPEN.OR_BOItemValue.fnuGetItemValue(
                                 or_ope_uni_item_bala.items_id,
                                 or_ope_uni_item_bala.operating_unit_id--&inuRequestOperUnit -- UdT solicitante
                               ) Costo_Unit,
                               nvl(ge_items_tipo.seriado,'N') seriado
                        FROM   OPEN.or_ope_uni_item_bala,
                               OPEN.ge_items,
                               OPEN.ge_items_tipo
                        WHERE  or_ope_uni_item_bala.operating_unit_id in (3117,3118,3120,3121,3122,3124, 3125, 3126,3127, 3128, 3129, 3130, 1967, 2239)
                           AND or_ope_uni_item_bala.items_id = ge_items.items_id
                           AND ge_items.id_items_tipo = ge_items_tipo.id_items_tipo(+)
                           --AND GE_ITEMS.ITEMs_ID=&ITEM
                    )
                )
                WHERE A_Solicitar > 0;
