--Direccion de contratos anulados
select a.address_id,
       a.geograp_location_id,
       a.address,
       p.category_id,
       p.subcategory_id 
from open.ab_address a
left join open.pr_product p on a.address_Id = p.address_id
where p.subscription_id in (66589566)

67257756 186561262 52401141

--productos creados 
select *
from mo_packages D
INNER JOIN MO_MOTIVE S ON S.package_id = D.package_id
inner join ab_address a on d.address_id = a.address_id 
where a.address_id in (1176563)
and d.package_type_id = 271
and d.motive_status_id = 13 52401144 186561277

--contratos anulados
select sesususc,
       sesunuse,
       sesusafa 
from open.servsusc s
where sesususc in (67257759)    

--diferidos 
select difecodi,
       difesusc,
       difenuse,
       difeconc,
       difevatd,
       difesape,
       difenucu,
       difecupa,
       difesign,
       difefein,
       difefumo      
from open.diferido
where difesusc = 66589566

select *
from pagos 
where pagosusc = 67257733

--productos hijos 
select sesususc, sesunuse,sesusafa 
from servsusc s
where sesususc in (67257737)

select *
from cargos 
where cargnuse = 52401097
and cargsign = 'AS'


--contratos padres 
select sesususc,sesunuse,sesusafa  
from servsusc s
where sesususc in (select contpadre  
                   from LDC_CONTANVE
                   where contanul  in (67130547,67130568,67130577,67130598,67130610))
