--cambiar_localidad_direccion

alter trigger PERSONALIZACIONES.trgbidurAB_ADDRESS disable ; 

update ab_address a
set geograp_location_id=9134,
    a.neighborthood_id=9107,
    a.shape.sdo_point.x= -72.445432 ,
    a.shape.sdo_point.y= 11.772369
where address_id in (763498, 768798) ;

commit ; 
                      
alter trigger PERSONALIZACIONES.trgbidurAB_ADDRESS enable ; 


