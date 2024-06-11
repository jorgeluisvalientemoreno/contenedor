select gis.multivivienda,
       prem.category_ ,  
       prem.subcategory_ 
from gispeti.ldc_info_predio gis
inner join open.ab_address ab on ab.estate_number = gis.premise_id
inner join open.ab_premise prem on prem.premise_id = gis.premise_id
inner join open.ab_segments seg on seg.segments_id = ab.segment_id
where gis.multivivienda := (id_address)