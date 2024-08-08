/*
Para el producto 52359077 se realizaron los siguientes  cambios de estados:

Orden 242028317  legalizada el 20 de enero de 2023   05:04:52 pm    
realizo cambio de estado de corte de 96 – inactivo a 1 – Conexión

Después se atiende la solicitud el 19 de abril de 2023  05:03:32  
la cual realiza cambio de estado de corte de  2- Orden de suspensión a 1 – Conexión,  
al tener una orden de suspensión en proceso si se cambia el estado 
ya no es posible legalizar la orden debido a que el sistema valida que el estado sea  2- orden de suspensión parcial.
*/
select a.*, rowid from open.pr_product a where a.product_id = 52359077;  --PR_PRODUCT.FNUGETPRODUCT_STATUS_ID
select a.*, rowid from open.servsusc a where a.sesunuse = 52359077; 
select a.*, rowid from open.pr_prod_suspension a where a.product_id = 52359077;
select a.*, rowid from open.ldc_marca_producto a where a.id_producto = 52359077;
select ooa.*,rowid from open.Or_Order_Activity ooa where ooa.product_id = 52359077;
select a.*,rowid from open.hicaesco a where a.hcecnuse = 52359077 order by a.hcecfech desc;
