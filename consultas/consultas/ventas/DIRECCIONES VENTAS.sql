select *
from ab_address di
where is_valid='Y'
and verified='Y'
and geograp_location_id=55
AND NOT EXISTS(SELECT NULL FROM PR_PRODUCT P WHERE P.ADDRESS_ID=DI.ADDRESS_ID)
