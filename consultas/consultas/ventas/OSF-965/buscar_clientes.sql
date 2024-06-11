select *
from ge_subscriber ge
left join open.ab_address a on a.address_id= ge.address_id
where a.geograp_location_id = 23
and UPPER(subscriber_name) LIKE '%CONSTRUCTORA%'
