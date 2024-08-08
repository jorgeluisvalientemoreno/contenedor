--validacion_spool_cartas
select open.ldc_pkgOSFFacture.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(ss.sesunuse)) tipo_noti,
su.subscriber_name || ' - ' || su.subs_last_name  nombre_cliente, di.address  direccion_cobro, ss.sesususc  contrato, lo.description  localidad, ss.sesunuse  producto, tn.merpmens, 
pc.plazo_maximo, pc.plazo_min_suspension, m.emsscoem  medidor, ss.sesucate  uso,  ss.sesusuca  estrato
from suscripc  s
inner join servsusc ss on ss.sesususc = susccodi
inner join ge_subscriber  su  on su.subscriber_id = s.suscclie
inner join ab_address  di  on di.address_id = susciddi
inner join ge_geogra_location  lo  on lo.geograp_location_id = di.geograp_location_id
inner join  elmesesu m  on m.emsssesu = ss.sesunuse
left join ldc_plazos_cert  pc  on pc.id_producto = ss.sesunuse
left join ldc_confimensrp tn  on tn.merptino = open.ldc_pkgOSFFacture.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(ss.sesunuse))
where ss.sesunuse in (51893246,1703225,51893231,50766112,50605810,1154399,1107022,51893220,51893224,51893231,51893238,51893246)
