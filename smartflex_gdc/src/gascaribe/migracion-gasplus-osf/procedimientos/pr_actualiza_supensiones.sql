CREATE OR REPLACE PROCEDURE PR_ACTUALIZA_SUPENSIONES AS

-- 12167 -> 4000068  -> SUSPENSION POR NO REVISION PERIODICA
-- 12455 -> 4000356  -> SUSPENSIÿN DE ACOMETIDA POR NO REVISION PERIODICA
-- 12168 -> 4000069  -> SUSPENSION POR NO REPARACIÿN
-- 12456 -> 4000357  -> SUSPENSIÿN DE ACOMETIDA POR NO REPARACIÿN
-- 12169 -> 4000070  -> SUSPENSION POR NO PERMITIR CERTIFICACIÿN DE TRABAJOS DE REPARACIÿN
-- 12526 -> 4000813  -> SUSPENSIÿN DESDE CENTRO DE MEDICIÿN POR MORA
-- 12528 -> 4000815  -> SUSPENSIÿN DESDE ACOMETIDA POR MORA

-- 10122 -> 4294392  -> SUSPENSIÿN NO EFECTUADA POR CONSUMO CERO


/*
SUSPENSION_TYPE_ID
2   -> Falta de Pago (12526,12528)
5   -> Voluntaria Bidireccional
11  -> Administrativa (BI)
101 -> No Permitió Revisar
102 -> No Permitió Reparar
103 -> No Permitió Certificar
*/

    CURSOR cuProductos
    IS
        SELECT p.product_id, p.subscription_id, pr.suspension_type_id
        FROM PR_PRODUCT p, pr_prod_suspension pr
        WHERE p.product_id = pr.product_id
        AND p.product_status_id = 2;

    CURSOR cuOrderActivity2(nuSubs number)
    IS
        SELECT orda.order_activity_id
        FROM OR_order ord, OR_order_activity orda
        WHERE ord.order_id = orda.order_id
        AND orda.subscription_id = nuSubs
        AND orda.task_type_id in (12526,12528)
        AND ord.legalization_date = (SELECT max(o.legalization_date)
                    FROM OR_order_activity oa, OR_order o
                    WHERE o.order_id = oa.order_id
                    AND oa.subscription_id = nuSubs
                    AND oa.task_type_id in (12526,12528));

    rgOrderActivity2   cuOrderActivity2%rowtype;

    CURSOR cuOrderActivity101(nuSubs number)
    IS
        SELECT orda.order_activity_id
        FROM OR_order ord, OR_order_activity orda
        WHERE ord.order_id = orda.order_id
        AND orda.subscription_id = nuSubs
        AND orda.task_type_id in (12167,12455)
        AND ord.legalization_date = (SELECT max(o.legalization_date)
                    FROM OR_order_activity oa, OR_order o
                    WHERE o.order_id = oa.order_id
                    AND oa.subscription_id = nuSubs
                    AND oa.task_type_id in (12167,12455));

    rgOrderActivity101   cuOrderActivity101%rowtype;

    CURSOR cuOrderActivity102(nuSubs number)
    IS
        SELECT orda.order_activity_id
        FROM OR_order ord, OR_order_activity orda
        WHERE ord.order_id = orda.order_id
        AND orda.subscription_id = nuSubs
        AND orda.task_type_id in (12168,12456)
        AND ord.legalization_date = (SELECT max(o.legalization_date)
                    FROM OR_order_activity oa, OR_order o
                    WHERE o.order_id = oa.order_id
                    AND oa.subscription_id = nuSubs
                    AND oa.task_type_id in (12168,12456));

    rgOrderActivity102   cuOrderActivity102%rowtype;

    CURSOR cuOrderActivity103(nuSubs number)
    IS
        SELECT orda.order_activity_id
        FROM OR_order ord, OR_order_activity orda
        WHERE ord.order_id = orda.order_id
        AND orda.subscription_id = nuSubs
        AND orda.task_type_id in (12169,12457,12168)
        AND ord.legalization_date = (SELECT max(o.legalization_date)
                    FROM OR_order_activity oa, OR_order o
                    WHERE o.order_id = oa.order_id
                    AND oa.subscription_id = nuSubs
                    AND oa.task_type_id in (12169,12457,12168));

    rgOrderActivity103   cuOrderActivity103%rowtype;

    /*CURSOR cuOrderActivity5(nuSubs number)
    IS
        SELECT orda.order_activity_id
        FROM OR_order ord, OR_order_activity orda
        WHERE ord.order_id = orda.order_id
        AND orda.subscription_id = nuSubs
        AND orda.task_type_id in (12523,12524)
        AND ord.legalization_date = (SELECT max(o.legalization_date)
                    FROM OR_order_activity oa, OR_order o
                    WHERE o.order_id = oa.order_id
                    AND oa.subscription_id = nuSubs
                    AND oa.task_type_id in (12523,12524)
                    GROUP BY oa.order_activity_id);

    rgOrderActivity5   cuOrderActivity5%rowtype;*/

    nuLogError number;



BEGIN

    PKLOG_MIGRACION.prInsLogMigra (333,333,1,'FIX_PRODCUTOS_SUSPENDIDOS',0,0,'INICIA PROCESO','INICIA',nuLogError);

    FOR rgProdcut IN cuProductos LOOP

        if rgProdcut.suspension_type_id = 2 then

            rgOrderActivity2.order_activity_id := null;

            open cuOrderActivity2(rgProdcut.subscription_id);
            fetch cuOrderActivity2 INTO rgOrderActivity2;
            close cuOrderActivity2;

            UPDATE pr_product
                SET suspen_ord_act_id = rgOrderActivity2.order_activity_id
                WHERE product_id = rgProdcut.product_id;
            commit;

        elsif rgProdcut.suspension_type_id = 101 then

            rgOrderActivity101.order_activity_id := null;

            open cuOrderActivity101(rgProdcut.subscription_id);
            fetch cuOrderActivity101 INTO rgOrderActivity101;
            close cuOrderActivity101;

            UPDATE pr_product
                SET suspen_ord_act_id = rgOrderActivity101.order_activity_id
                WHERE product_id = rgProdcut.product_id;
            commit;

        elsif rgProdcut.suspension_type_id = 102 then

             rgOrderActivity102.order_activity_id := null;

            open cuOrderActivity102(rgProdcut.subscription_id);
            fetch cuOrderActivity102 INTO rgOrderActivity102;
            close cuOrderActivity102;

            UPDATE pr_product
                SET suspen_ord_act_id = rgOrderActivity102.order_activity_id
                WHERE product_id = rgProdcut.product_id;
            commit;

        elsif rgProdcut.suspension_type_id = 103 then

             rgOrderActivity103.order_activity_id := null;

            open cuOrderActivity103(rgProdcut.subscription_id);
            fetch cuOrderActivity103 INTO rgOrderActivity103;
            close cuOrderActivity103;

            UPDATE pr_product
                SET suspen_ord_act_id = rgOrderActivity103.order_activity_id
                WHERE product_id = rgProdcut.product_id;
            commit;

        elsif rgProdcut.suspension_type_id = 11 then

            -- rgOrderActivity103.order_activity_id := null;

            UPDATE pr_product
                SET suspen_ord_act_id = null
                WHERE product_id = rgProdcut.product_id;
            commit;

        elsif rgProdcut.suspension_type_id = 5 then

            --rgOrderActivity5.order_activity_id := null;

            UPDATE pr_product
                SET suspen_ord_act_id = null
                WHERE product_id = rgProdcut.product_id;
            commit;

        END if;

    END LOOP; -- Fin for cuProductos

    PKLOG_MIGRACION.prInsLogMigra (333,333,3,'FIX_PRODCUTOS_SUSPENDIDOS',0,0,'TERMINA PROCESO','FIN',nuLogError);

END PR_ACTUALIZA_SUPENSIONES;
/
