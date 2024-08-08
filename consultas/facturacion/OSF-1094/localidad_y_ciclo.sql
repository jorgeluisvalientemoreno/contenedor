select geograp_location_id , sesucicl  
from pr_product pr  
left join servsusc on product_id = sesunuse 
left join ab_address  a on a.address_Id = pr.address_id
where  sesucicl  = 1010
group by (geograp_location_id , sesucicl)
 