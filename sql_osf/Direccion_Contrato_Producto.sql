select s.susccodi contrato,
       pp.product_id Producto,
       pp.address_id || ' - ' || aaDirecion_prodcuto.Address Direccion_Producto,
       s.susciddi || ' - ' || aaDirecion_Contrato.Address Direccion_Contrato,
       aaDirecion_prodcuto.Geograp_Location_Id Localidad
  from open.pr_product pp
 inner join OPEN.SUSCRIPC s
    on s.susccodi = pp.subscription_id
 inner join OPEN.ab_address aaDirecion_prodcuto
    on aaDirecion_prodcuto.Address_Id = pp.address_id
 inner join OPEN.ab_address aaDirecion_Contrato
    on aaDirecion_Contrato.Address_Id = s.susciddi
  --  where pp.subscription_id = 67744214
