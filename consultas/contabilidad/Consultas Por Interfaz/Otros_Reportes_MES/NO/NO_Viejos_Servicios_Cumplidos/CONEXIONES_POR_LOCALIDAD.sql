select localidad, count(*)
  from (
        select h.*, (SELECT description FROM open.ge_geogra_location 
                     WHERE geograp_location_id = (SELECT geograp_location_id FROM open.ab_address 
                                                     WHERE address_id = susciddi)) localidad, susciddi
          from open.hicaesco h, open.servsusc s, open.suscripc sc
         where h.hcecserv = 7014 and h.hcececan = 96 and h.hcececac = 1 and trunc(h.hcecfech) >= '01-01-2016'
           and trunc(h.hcecfech) < '01-02-2016'
           and s.sesunuse = h.hcecnuse
           and s.sesususc = susccodi
        order by h.hcecfech
       ) group by localidad
 where localidad = 'BARRO BLANCO'
