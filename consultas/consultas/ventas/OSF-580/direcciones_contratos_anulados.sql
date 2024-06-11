select a.address_id,
       a.geograp_location_id,
       a.address,
       p.category_id,
       p.subcategory_id 
from open.ab_address a
left join open.pr_product p on a.address_Id = p.address_id
where p.subscription_id in (66589566)