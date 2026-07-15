select name, last_name, type_of_identification ,
       identification , date_of_birth , id_expedition_date
from client_details


select *
from products
inner join client_details on products.id = client_id

select contract_id , client_id, name, last_name,body, location
from client_details
left join addresses on client_details.id = addresses.client_detail_id
left  join products on products.id = client_id
