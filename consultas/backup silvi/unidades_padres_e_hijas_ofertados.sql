--unidades_padres_e_hijas_ofertados
select f.unidad_operativa_padre, 
       u.name  desc_unidad_padre,
       u.admin_base_id,
       b1.descripcion,
       f.unidad_operativa_hija,
       u2.name  desc_unidad_hija,
       u2.admin_base_id,
        b2.descripcion
from ldc_unid_oper_hija_mod_tar   f
inner join open.or_operating_unit u  on u.operating_unit_id = f.unidad_operativa_padre
inner join open.or_operating_unit u2  on u2.operating_unit_id = f.unidad_operativa_hija
inner join ge_base_administra b1  on b1.id_base_administra = u.admin_base_id
inner join ge_base_administra b2  on b2.id_base_administra = u2.admin_base_id
where f.unidad_operativa_padre in (4205)


--3533,3534,3535,3607,4130,4205,4207,4208,4209,4210,4309,4310
