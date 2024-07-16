select ge.subscriber_name , ge.identification,ge.ident_type_id, ge.address , geograp_location_id
from ge_subscriber ge
left join open.ab_address on ge.address = ab_address.address
left join ge_identifica_type i on i.ident_type_id  = ge.ident_type_id
where subscriber_name like '%CONSTRUCTORA%' and geograp_location_id in (55,5)