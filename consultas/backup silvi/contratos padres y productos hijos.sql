select contpadre,
       direprhi,
       fechregi,
       fechulmo,
       terminal,
       estado,
       s.package_id,
       s.package_type_id,
       s.motive_status_id,
       subscription_id,
       product_id             
from open.ldc_conttsfa f
left join mo_packages s on f.direprhi = s.address_id
left join mo_motive m on m.package_id = s.package_id
left join  servsusc  s on sesunuse = m.product_id
where estado in ('S')
and s.package_type_id = 271
and s.motive_status_id = 13
order by fechulmo desc ;

select *
from ldc_conttsfa f
where estado in 'N'

/*left join ab_address a on address_id = f.direprhi
left join pr_product pr on pr.address_id = f.direprhi*/

select *
from ldc_info_predio;

--ANILLADO
select *
from AB_INFO_PREMISE
where  premise_id = 1542181;
--for update

--CONSULTA PARA ENCONTRAR LAS PRIMARY KEYS DE ALGUNAS COLUMNAS DE UNA TABLA CON LLAVES FORÁNEAS
select * from all_constraints
where constraint_name = 'FK_AB_INFO_PRE_AB_PREMISE02';
