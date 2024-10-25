select aa.ESTATE_NUMBER,
       ap.category_ categoria_perdio,
       ap.subcategory_ subcategoria_perdio,
       aa.geograp_location_id || ' - ' || ggl_localidad.description Localidad,
       ggl_localidad.geo_loca_father_id || ' - ' ||
       ggl_Departamento.description Departamento
  from OPEN.AB_ADDRESS aa
  left join open.AB_PREMISE ap
    on ap.premise_id = aa.estate_number
  left join open.ge_geogra_location ggl_localidad
    on ggl_localidad.geograp_location_id = aa.geograp_location_id
  left join open.ge_geogra_location ggl_departamento
    on ggl_departamento.geograp_location_id =
       ggl_localidad.geo_loca_father_id
 where aa.address_id = (select sc.susciddi
                          from OPEN.SUSCRIPC sc
                         where sc.susccodi = 67560488);
