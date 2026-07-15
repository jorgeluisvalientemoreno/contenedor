select  product_id "Producto" ,
 status "Estado" , product_type_id "Tipo de producto" ,
  geograp_location_id "Localidad", address_id "Direccion",
   register_date "Fecha_registro", order_id "Orden", initcap(comment_) "Comentario"
 from fm_possible_ntl
 where product_id= 51596020
