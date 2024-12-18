BEGIN
    --product
    UPDATE SERVSUSC SET SESUESCO = 96 WHERE SESUNUSE in (51901203);
    update pr_product p set p.product_status_id = 15 where p.product_id in (51901203);
    update pr_component cp set cp.component_status_id = 17 where cp.product_id in (51901203);

    --package
    update mo_packages set attention_date = null, motive_status_id = 13 where package_id in (119565379);
    update mo_component set attention_date = null, motive_status_id = 15 where package_id in (119565379);
    update MO_MOTIVE set attention_date = null, status_change_date = null, motive_status_id = 1 where package_id in (119565379);
    COMMIT;
 END;
/
