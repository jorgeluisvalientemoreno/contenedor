    SELECT
        *
    FROM
    (
        SELECT
            a.product_id,
            a.prod_suspension_id,
            a.register_date register_date_pr,
            a.aplication_date aplication_date_pr,
            a.inactive_date inactive_date_pr,
            a.active active_pr,
            c.package_id,
            b.motive_id motive_id_m,
            b.register_date register_date_m,
            b.aplication_date aplication_date_m,
            b.ending_date ending_date_m
        FROM pr_prod_suspension a, mo_suspension b, mo_motive c, mo_packages d
        WHERE 
        --AND   a.product_id = 532
        a.aplication_date IS not null
        AND   a.active = 'N'
        AND   a.inactive_date IS null
        AND   a.suspension_type_id = 5
        AND   a.register_date = b.register_date
        AND   b.suspension_type_id = 5
        AND   b.motive_id = c.motive_id
        AND   a.product_id = c.product_id
        AND   c.package_id = d.package_id
        AND   d.package_type_id = 100209
        ORDER BY a.product_id, a.register_date
    )