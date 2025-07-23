alter trigger PERSONALIZACIONES.trgbidurAB_ADDRESS disable ; 

update ab_address a
set geograp_location_id=9104,
    a.neighborthood_id=9107,
    a.shape.sdo_point.x= -72.445432 ,
    a.shape.sdo_point.y= 11.772369
where address_id = 254947 ;

update ab_segments a
set ciclcodi=9015,
    cicocodi=9015,
    operating_sector_id=9106,
    a.neighborhood_id=9107,
    geograp_location_id=9104
where segments_id in (select segment_id 
                      from ab_address
                      where address_id  in (254947));

commit ; 
                      
alter trigger PERSONALIZACIONES.trgbidurAB_ADDRESS enable ; 

