select pr_prod_suspension.product_id  "Producto", 
       pr_prod_suspension.suspension_type_id ||'- '|| ge_suspension_type.description "Tipo de suspension", 
       pr_prod_suspension.register_date  "Fecha de registro", pr_prod_suspension.inactive_date  "Fecha inactividad", 
       pr_prod_suspension.active  "Activo" 
from open.pr_prod_suspension
inner join open.ge_suspension_type on ge_suspension_type.suspension_type_id = pr_prod_suspension.suspension_type_id
where pr_prod_suspension.product_id = 50032741
order by pr_prod_suspension.aplication_date desc;