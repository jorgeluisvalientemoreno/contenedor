select a.subscription_id contrato,
       a.product_id producto,
       a.product_type_id Tipo_Producto,
       aa.address_id || ' - ' || aa.address Direccion_Prodcuto,
       a.provisional_end_date Fecha_instalacion,
       a.provisional_beg_date Fecha_retiro
  from open.pr_product a, open.ab_address aa
 where a.address_id = aa.address_id
      --and a.product_id = 52517937
   and a.address_id = 4277070
   and a.product_type_id = 7014;
--------------------
select a.susccodi contrato,
       aa.address_id || ' - ' || aa.address Direccion_Cobro
  from OPEN.SUSCRIPC a, open.ab_address aa
 where a.susciddi = aa.address_id
   and a.susccodi in (67270177,67344303);
