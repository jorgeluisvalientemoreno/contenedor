select m.subscription_id "Contrato",
       m.product_id "Producto",
       p.package_id "Solicitud",
       p.request_date "Fecha_Creacion_Solicitud",
       p.motive_status_id || ' -' || initcap(ps.description) "Estado_solicitud",
       p.package_type_id || ' -' ||initcap(ts.description ) "Tipo_solicitud",
       m.motive_id "Motivo",
       m.motive_status_id "Status"
from mo_packages p
left join mo_motive m on p.package_id = m.package_id
left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
left join ps_motive_status ps on ps.motive_status_id = p.motive_status_id
where subscription_id in (66569358)
and p.package_type_id = 100347;

select count ( distinct (p.package_id))
from mo_packages p
left join mo_motive m on p.package_id = m.package_id
left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
left join PS_MOTIVE_STATUS ps on ps.motive_status_id = p.motive_status_id
left join servsusc on sesunuse = m.product_id
where  p.package_type_id = 100347
and sesucicl = 3840
and p.request_date  > '05/05/2023';