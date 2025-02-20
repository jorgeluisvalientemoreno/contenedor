select  distinct
         cicldesc||' | '||a.sesucicl ciclo,
        ops.description||' | '||e.operating_sector_id sector_operativo
from    servsusc a, pr_product b, ab_address c, ge_geogra_location d,
        ab_segments e, ciclo cl, or_operating_sector ops
where   a.sesunuse = b.product_id
and     c.address_id = b.address_id
and     d.geograp_location_id = c.geograp_location_id
and     e.segments_id = c.segment_id
and     a.sesucicl = cl.ciclcodi
and     ops.operating_sector_id = e.operating_sector_id
and     a.sesucicl in (/*1801,1901,*/5502/*,89414,1850,2050,2401,2402,5550,9050*/)
--and     d.geograp_location_id in (/*161,176,182\*,187*\,8478*/187)
and     e.operating_sector_id in (644, 737, 766, 8406)
;
