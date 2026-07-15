--cotizacion
select * from open.ldc_cotizacion_comercial  co  where  co.id_cot_comercial = 9729 order by co.id_cot_comercial desc ; 


--detalle cotizacion
select * from open.ldc_items_cotizacion_com  cm, open.ge_items i 
where  cm.id_item=i.items_id and cm.id_cot_comercial = 9729 order by fecha_registro desc ;
