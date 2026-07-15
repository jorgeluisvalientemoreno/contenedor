--validar_lista 
 SELECT 'GDCA' empresa,
           c.items_id codigo_item,
           (select it.description from open.ge_items it where it.items_id=c.items_id ) desc_item,
           c.price,
           c.sales_value,
           2     AS orden
              FROM open.ge_unit_cost_ite_lis c, open.ge_list_unitary_cost b
             WHERE     c.list_unitary_cost_id = &nuidlistaprecio
             AND c.items_id in (100010575, 100010648)
                   AND c.list_unitary_cost_id = b.list_unitary_cost_id
                  -- and c.items_id=100010575
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ge_items             i
                             WHERE     li.codigo_interfaz = &nucuprodlistaproc
                                   AND TO_CHAR (codigo_item) = i.code
                                   AND c.items_id in (100010575, 100010648)
                                   AND c.items_id = i.items_id)
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ge_items             i,
                                   ldc_homoitmaitac          ac
                             WHERE     li.codigo_interfaz = &nucuprodlistaproc
                                   AND TO_CHAR (li.codigo_item) = i.code
                                   AND i.items_id = ac.item_material
                                   AND c.items_id in (100010575, 100010648)
                                   AND c.items_id = ac.item_actividad)
            -- INICIA OSF-4289 UNION REGISTROS DE LA LISTA DE GDGU
      UNION ALL
            SELECT 'GDGU' empresa,
           c.items_id codigo_item,
           (select it.description from open.ge_items it where it.items_id=c.items_id) desc_item,
                   c.price,
                   c.sales_value,
                   2     AS orden
              FROM open.ge_unit_cost_ite_lis c, open.ge_list_unitary_cost b, ge_items d
             WHERE     c.list_unitary_cost_id = &nuidlistaprecio
                   AND c.list_unitary_cost_id = b.list_unitary_cost_id
           AND c.items_id = d.items_id
           AND d.item_classif_id not in 
                        (
                        SELECT to_NUMBER(regexp_substr(
                                  &sbClasItemMaterial,
                                  '[^,]+',
                                  1,
                                  LEVEL
                                 )
                                ) AS ClasItemMaterial
                        FROM dual
                        CONNECT BY regexp_substr(&sbClasItemMaterial, '[^,]+', 1, LEVEL) IS NOT NULL
                        )
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ge_items             i
                             WHERE     li.codigo_interfaz = &nucuprodlistaprocGDGU
                                   AND TO_CHAR (codigo_item) = i.code
                                   AND c.items_id in (100010575, 100010648)
                                   AND c.items_id = i.items_id)
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ge_items             i,
                                   ldc_homoitmaitac          ac
                             WHERE     li.codigo_interfaz = &nucuprodlistaprocGDGU
                                   AND TO_CHAR (li.codigo_item) = i.code
                                   AND i.items_id = ac.item_material
                                   AND c.items_id = ac.item_actividad)
                                   AND c.items_id in (100010575, 100010648)
      -- FIN OSF-4289 UNION REGISTROS DE LA LISTA DE GDGU
            ORDER BY empresa, codigo_item, orden;
