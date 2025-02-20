--productos_no_reparables
select *
  from ldc_marcaprodrepa  dr 
   where dr.producto_id in (50322859);
   
   
select max(dr.marca_id)+1
 from ldc_marcaprodrepa  dr */
