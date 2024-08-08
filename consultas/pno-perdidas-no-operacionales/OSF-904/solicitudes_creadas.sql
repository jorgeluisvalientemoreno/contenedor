select  s.sesunuse      "Producto",
       p.package_type_id ||' -'|| initcap (ts.description)     "Tipo_Solicitud",
       p.package_id         "Solicitud",
       p.motive_status_id   "Estado_Solicitud",
       p.request_date      "Fecha_Creacion_Solicitud"
  from open.mo_packages p
  left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
  left join open.mo_motive m on m.package_id = p.package_id 
  left join open.servsusc s on m.product_id = s.sesunuse
  where  s.sesunuse in (1000026)
and  p.request_date  > '13/07/2023'
