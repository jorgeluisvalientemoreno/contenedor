select c.* , pr.product_status_id Estado_Producto , sesucate Categoria
from personalizaciones.coslprom c 
inner join pr_product pr on producto = pr.product_id 
inner join servsusc s on sesususc = contrato and sesunuse = producto
where fecha >= '01/02/2024'

;
select * from personalizaciones.coslprom c where fecha >= '01/02/2024'
