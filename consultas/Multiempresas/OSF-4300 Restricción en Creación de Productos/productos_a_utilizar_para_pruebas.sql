select susccodi , product_id, product_type_id  , s.susciddi , aa.address_parsed "direccion_cobro"  , pr.address_id , a.address_parsed "direccion_instalacion" 
from suscripc s
inner join pr_product pr  on subscription_id = susccodi 
left join ab_address a on pr.address_id = a.address_id
left join ab_address aa on s.susciddi = aa.address_id
where susccodi = 1000519 
group by susccodi ,product_id,product_type_id, s.susciddi , aa.address_parsed, pr.address_id , a.address_parsed;