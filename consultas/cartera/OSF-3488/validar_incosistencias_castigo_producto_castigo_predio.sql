--validar_incosistencias_castigo_producto_castigo_predio
WITH productos_inconsistentes AS (
    SELECT 
        p.product_id,
        p.subscription_id,
        ip.premise_id,
        p.product_type_id,
        p.product_status_id,
        s.sesucicl,
        s.sesuesco,
        ec.escodesc,
        s.sesuesfn,
        ip.predio_castigado,
        ad.address_id,
        ad.address,
        ip.multivivienda,
        gl.geo_loca_father_id,
        gl.display_description
    FROM open.pr_product p
    JOIN open.servsusc s ON s.sesunuse = p.product_id
    JOIN open.ab_address ad ON ad.address_id = p.address_id
    JOIN open.ab_premise ap ON ap.premise_id = ad.estate_number
    JOIN open.ldc_info_predio ip ON ip.premise_id = ap.premise_id
    JOIN open.estacort ec ON ec.escocodi = s.sesuesco
    JOIN open.ge_geogra_location gl ON gl.geograp_location_id = ad.geograp_location_id
    WHERE
        -- Condiciones inconsistentes
        (s.sesuesfn = 'C' AND ip.predio_castigado = 'N')
        OR
        (s.sesuesfn <> 'C' AND ip.predio_castigado = 'S')
),
dir_prod_validos AS (
    SELECT DISTINCT ad2.address_id
    FROM open.pr_product p2
    JOIN open.ab_address ad2 ON ad2.address_id = p2.address_id
    JOIN open.ab_premise ap2 ON ap2.premise_id = ad2.estate_number
    JOIN open.ldc_info_predio ip2 ON ip2.premise_id = ap2.premise_id
    JOIN open.servsusc s2 ON s2.sesunuse = p2.product_id
    WHERE 
        (s2.sesuesfn = 'C' AND ip2.predio_castigado = 'S')
        OR
        (s2.sesuesfn <> 'C' AND ip2.predio_castigado = 'N')
)
SELECT 
    pi.product_id AS producto,
    pi.subscription_id AS contrato,
    pi.premise_id,
    pi.product_type_id AS tipo_producto,
    pi.product_status_id AS estado_producto,
    pi.sesucicl AS ciclo,
    pi.sesuesco || ' - ' || pi.escodesc AS estado_corte,
    pi.sesuesfn AS estado_financiero,
    pi.predio_castigado,
    pi.address_id,
    pi.address AS direccion,
    pi.multivivienda AS multifamiliar,
    pi.geo_loca_father_id || ' - ' || pi.display_description AS departamento
FROM productos_inconsistentes pi
WHERE pi.address_id NOT IN (
    SELECT address_id FROM dir_prod_validos
)
