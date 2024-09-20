select initcap(ge.subscriber_name) Nombre,
        ge.identification identificacion,
        ge.ident_type_id  || '-  ' || initcap(ty.description ) Tipo_id,
        initcap(ab.address_parsed) Direccion,
        ab.geograp_location_id || '-  ' || initcap(geo.display_description) Localidad,
        sesususc,
        sesunuse,
        cucofact,
        factfege,
        cargcuco,
        cargconc || '-  ' || initcap(c.concdesc) concepto,
        cargvalo,
        cargcaca,
        cargsign,
        cargdoso,
        cargfecr,
        cargtipr
from open.cargos  ca
left join open.concepto c on cargconc = conccodi 
left join open.servsusc s on sesunuse = cargnuse 
left join open.cuencobr br on cucocodi = cargcuco
left join open.factura f on cucofact = factcodi 
left join open.suscripc sc on sc.susccodi = s.sesususc 
left join open.ge_subscriber ge on ge.subscriber_id  =  sc.suscclie
left join open.pr_product pr on pr.product_id = sesunuse 
left join open.ab_address ab on pr.address_id  = ab.address_id
left join open.ge_geogra_location geo on geo.geograp_location_id = ab.geograp_location_id
left join open.ge_identifica_type ty on ty.ident_type_id = ge.ident_type_id
where br.cucofact= 2132345253 and cargdoso like '%PP%'
order by cargconc , cargfecr 
