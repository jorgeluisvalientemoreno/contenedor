SELECT /*+ leading(tt_damage_product)
                       use_nl(tt_damage_product mo_packages)
                       use_nl(mo_packages tt_damage) */
                   tt_damage.*
            FROM   open.tt_damage,
                   open.mo_packages
                   /* IF_BOProcessOutage.ValidateProduct SAO186582 */
            WHERE  tt_damage.package_id = mo_packages.package_id
              AND  mo_packages.motive_status_id NOT IN (14,
                                                        46)
              AND  EXISTS (SELECT /*+ INDEX(tt_damage_product IDX_TT_DAMAGE_PRODUCT_02) */
                                  * --'X'
                           FROM   open.tt_damage_product
                           WHERE /*tt_damage_product.product_id = 50031086
--                             */ tt_damage_product.package_id = mo_packages.package_id
                             AND tt_damage_product.damage_produ_status = 'A');


                             
