select sesususc "Contrato" ,
 sesunuse "Producto" , sesuserv "Tipo_producto" ,
  sesuesco || ' -' || initcap (escodesc)  "Estado_corte" ,
   pr_product.product_status_id ||' -' ||initcap (ps_product_status.description)  "Estado de producto",
   pr_product.address_id "Id_direccion" , phone "Telefono"
from open.servsusc 
left join open.pr_product on pr_product.product_id = sesunuse 
left join open.estacort on sesuesco = escocodi 
left join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id 
left join open.suscripc on suscripc.susccodi= servsusc.sesususc
left join open.ge_subscriber  on ge_subscriber.subscriber_id = suscripc.suscclie
where sesuesco = 1
and sesuserv= 7014
and  not exists ( select *
                 from fm_possible_ntl  n 
                 where n.product_id = sesunuse  ) 
