select concclco, sum(valor), cebe, signo
  from (
          select /*cargconc,*/ o.concclco, cargsign signo, sum(cargvalo) Valor,
                 (select l.celocebe 
                    from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                   where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                                 where address_id = susciddi)
                    and t.geo_loca_father_id = l.celodpto 
                    and t.geograp_location_id = celoloca) CEBE
            from open.cargos c, open.servsusc s, open.suscripc p, open.concepto o
           where cargnuse = sesunuse
             and sesususc = susccodi
             and sesuserv = 6121
             and cargfecr >= '01-06-2015'
             and cargfecr <= '30-06-2015 23:59:59'
             and cargdoso like 'PP%'
             and /*cargconc in (19,30,291,674) and*/ cargconc = conccodi and concclco in (4,19,400)
          group by /*cargconc,*/o.concclco,  susciddi, cargsign
       )
group by concclco, cebe, signo
