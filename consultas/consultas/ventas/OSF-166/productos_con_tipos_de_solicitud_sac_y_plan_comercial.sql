select pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       s.sesucicl  Ciclo, 
       pr.product_type_id  Tipo_Producto, 
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento, 
       pr.commercial_plan_id  Plan_Comercial, 
       min(p.request_date) Fecha_Registro_Solicitud
from open.mo_packages  p
inner join open.mo_motive  m on p.package_id = m.package_id
inner join open.pr_product  pr on m.product_id = pr.product_id
inner join open.ab_address di on di.address_id=p.address_id
inner join open.ge_geogra_location  gl on gl.geograp_location_id = di.geograp_location_id
inner join open.servsusc  s on s.sesunuse = pr.product_id
where p.package_type_id in (100323,100366)
and p.motive_status_id in (14)
and pr.commercial_plan_id in (48,54)
and s.sesucate = 1
and p.request_date BETWEEN '01/02/2022' and '28/02/2022 23:59:59'
and p.user_id in ('PAOGUE','AMAMAN','LIZSAE','CINPIC','ANTARI')
and gl.geo_loca_father_id in (2,3,4)
and not exists(select null 
from open.ldc_comm_aut_cont  n
inner join open.mo_packages  p2 on p2.package_id = n.package_id
inner join open.mo_motive  m2 on m2.package_id = n.package_id
inner join open.pr_product  pr2 on m2.product_id = pr2.product_id
where pr2.product_id = pr.product_id)
and exists(select null
from open.ciclo c
left join open.pericose pc on pc.pecscico=c.ciclcodi and sysdate between pc.pecsfeci and pc.pecsfecf
left join open.perifact pf on pf.pefacicl=c.ciclcodi and sysdate between pf.pefafimo and pf.pefaffmo
where pf.pefaactu = 'S')
group by  pr.subscription_id, pr.product_id, s.sesucicl, pr.product_type_id, gl.geo_loca_father_id || '-  ' || gl.display_description, 
pr.commercial_plan_id
order by min(p.request_date) desc