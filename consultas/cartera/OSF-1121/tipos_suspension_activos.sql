select pr.product_id "Producto", suspension_type_id "Tipo suspension",register_date "Fecha registro" ,aplication_date "Fecha aplicacion" ,inactive_date "Fecha Inactiva"  ,active "Flag" 
from pr_prod_suspension pr
where pr.product_id= 1000403
and  pr.active = 'Y';
