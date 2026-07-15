-- validaciones_nueva_lista_genérica
SELECT 
    dlc.items_id,
    i.description AS descripcion_item,
    i.item_classif_id AS clasificacion_item,
    dlc.list_unitary_cost_id,
    dlp.codigo_interfaz,
    dlp.costo_items AS precio_interfaz,
    ROUND(dlp.costo_items * 1.19, 2) AS costo_con_iva,
    dlc.price AS precio_lista_4474,
    ref4471.price AS precio_lista_4471,

    -- SOLO si el ítem está homologado se muestra el precio con 6% adicional
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM ldc_homoitmaitac hi 
            WHERE hi.item_material = dlc.items_id OR (hi.item_actividad = dlc.items_id)
              AND hi.empresa = 'GDCA'
        ) THEN
            CASE 
                WHEN i.item_classif_id = 51 THEN
                    ROUND((SELECT precio_mat.price
                           FROM ge_unit_cost_ite_lis precio_mat
                           WHERE precio_mat.list_unitary_cost_id = 4474
                             AND precio_mat.items_id = (
                                 SELECT hi2.item_material 
                                 FROM ldc_homoitmaitac hi2
                                 WHERE hi2.item_actividad = dlc.items_id
                                   AND hi2.empresa = 'GDCA'
                                   AND ROWNUM = 1
                             )
                    ) * 1.06, 2)
                ELSE ROUND(dlc.price * 1.06, 2)
            END
        ELSE NULL
    END AS precio_con_6pct_admin,

    -- Estado de homologación
    CASE 
        WHEN EXISTS (
            SELECT 1 
              FROM ldc_homoitmaitac hi 
             WHERE (hi.item_material = dlc.items_id OR hi.item_actividad = dlc.items_id)
               AND hi.empresa = 'GDCA'
        )
        THEN 'HOMOLOGADO'
        ELSE 'NO HOMOLOGADO'
    END AS estado_homologacion,

    -- Validación final
    CASE 
        WHEN i.item_classif_id = 51
             AND EXISTS (
                 SELECT 1 
                   FROM ldc_homoitmaitac hi 
                  WHERE hi.item_actividad = dlc.items_id 
                   AND hi.empresa = 'GDCA'
                    AND EXISTS (
                        SELECT 1 
                          FROM ldci_intdetlistprec d
                         WHERE d.codigo_interfaz in (64)
                           AND d.codigo_item = TO_CHAR(hi.item_material)
                    )
             )
        THEN
            CASE 
                WHEN dlc.price = ROUND(
                        (SELECT precio_mat.price
                           FROM ge_unit_cost_ite_lis precio_mat
                          WHERE precio_mat.list_unitary_cost_id = 4474
                            AND precio_mat.items_id = (
                                SELECT hi2.item_material 
                                  FROM ldc_homoitmaitac hi2
                                 WHERE hi2.item_actividad = dlc.items_id
                                   AND hi2.empresa = 'GDCA'
                                   AND ROWNUM = 1
                            )
                        ) * (1 + pkg_bcld_parameter.fnuobtienevalornumerico('PORC_ADMIN_ITEM_MATERIAL') / 100), 2
                     ) 
                THEN 'CORRECTO'
                ELSE 'VALIDAR'
            END

        WHEN dlp.costo_items IS NOT NULL
        THEN
            CASE 
                WHEN ROUND(dlp.costo_items * 1.19, 2) = dlc.price 
                THEN 'CORRECTO'
                ELSE 'VALIDAR'
            END

        WHEN dlp.costo_items IS NULL AND ref4471.price IS NOT NULL
        THEN
            CASE 
                WHEN ref4471.price = dlc.price 
                THEN 'CORRECTO'
                ELSE 'VALIDAR'
            END

        ELSE 'VALIDAR'
    END AS validacion,

    dlc.sales_value,
    dlc.price * 1.25 AS sales_value_cauculado,

    -- Validar redondeando SOLO para comparar
    CASE 
        WHEN ROUND(dlc.sales_value, 0) = ROUND(dlc.price * 1.25, 0)
        THEN 'CORRECTO'
        ELSE 'VALIDAR'
    END AS validar_valor_usuario

FROM ge_unit_cost_ite_lis dlc
LEFT JOIN ge_items i ON i.items_id = dlc.items_id
LEFT JOIN ldci_intdetlistprec dlp ON dlp.codigo_interfaz in (64) AND dlp.codigo_item = TO_CHAR(dlc.items_id)
LEFT JOIN ge_unit_cost_ite_lis ref4471 ON ref4471.items_id = dlc.items_id AND ref4471.list_unitary_cost_id = 4471
LEFT JOIN ldc_homoitmaitac hi7  ON (hi7.item_material = dlc.items_id OR hi7.item_actividad = dlc.items_id)
WHERE dlc.list_unitary_cost_id = 4474
ORDER BY validacion DESC, dlc.items_id;


--and   i.item_classif_id not in (51)
--AND hi7.empresa = 'GDCA'

--AND hi7.empresa = 'GDCA'
--AND   i.item_classif_id  in (51)
--AND dlc.items_id in (10000126,100010655,100007894)               


--and dlp.costo_items is not null
