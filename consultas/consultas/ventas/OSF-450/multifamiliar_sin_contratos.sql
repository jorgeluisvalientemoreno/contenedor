select *
from (
select gis.multivivienda, count(1)
from gispeti.ldc_info_predio gis
inner join open.ab_address ab on ab.estate_number = gis.premise_id
inner join open.ab_premise prem on prem.premise_id = gis.premise_id
inner join open.ab_segments seg on seg.segments_id = ab.segment_id
group by gis.multivivienda
having count(1) = 6) w
where not exists (
select 1
from gispeti.ldc_info_predio gis2
inner join open.ab_address ab on ab.estate_number = gis2.premise_id
inner join open.pr_product pr on pr.address_id = ab.address_id and pr.product_type_id = 7014 
and pr.product_status_id in (1, 10, 15, 17, 2, 5, 8)
where gis2.multivivienda = w.multivivienda );