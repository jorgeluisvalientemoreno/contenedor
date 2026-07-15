WITH used_numbers AS (
    SELECT CAST(SUBSTRING(dian_number FROM 5) AS INTEGER) AS number
    FROM "facturacion-electronica".electronic_invoices
    WHERE dian_number LIKE 'SETT%' AND company = 'GDG'
    and  TYPE='1'
),
unused_numbers AS (
    SELECT generate_series(1, 5000000) AS number
    EXCEPT
    SELECT number FROM used_numbers
),
grouped AS (
    SELECT
        number,
        number - ROW_NUMBER() OVER (ORDER BY number) AS grp
    FROM unused_numbers
),
intervals AS (
    SELECT
        MIN(number) AS range_start,
        MAX(number) AS range_end,
        COUNT(*) AS count_in_range
    FROM grouped
    GROUP BY grp
)
SELECT *
FROM intervals
WHERE count_in_range > 1000
ORDER BY range_start;