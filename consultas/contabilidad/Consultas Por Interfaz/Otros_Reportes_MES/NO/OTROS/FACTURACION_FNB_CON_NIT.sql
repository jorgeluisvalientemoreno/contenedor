select cebe, (select f.cebedesc from open.ldci_centrobenef f where f.cebecodi = cebe) des_beneficio,
       clcocodi, clcodesc, cargsign, 
       nit, (select n.bannnomb from open.ldci_banconit n where n.bannnnit = nit and rownum = 1) nom_proveedor,
       sum(valor) valor
  from (
        select clcocodi, clcodesc, cargsign, open.ldci_pkinterfazsap.fnuDatosVentaBrillaRO(substr(cargdoso,4)) Nit,
               sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor,
               (select l.celocebe from open.ldci_centbenelocal l 
                 where l.celoloca in (SELECT  unique b.geograp_location_id
                                        FROM open.pr_product a, open.ab_address b
                                       WHERE a.address_id = b.address_id
                                         and a.product_id = c.cargnuse)) CEBE
        from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, open.CAUSCARG csc,    
             open.procesos, open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
        where c.cargcaca = csc.cacacodi    
          and c.CARGCONC = CO.CONCCODI    
          and c.cargnuse = ss.sesunuse    
          AND factcodi = CUCOfact    
          AND CARGCUCO = CUCOCODI    
          and clcocodi(+) = concclco 
          and concclco in (2)
          and cargpefa = pefacodi    
          and FACTFEGE BETWEEN to_date('01/08/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                           and to_date('31/08/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
          and cargprog = proccons    
          and cargtipr = 'A'    
          and cargsign NOT IN ('PA','AP','SA') 
          and cargcaca IN (19)
        group by clcocodi, clcodesc, CARGSIGN, cargdoso,cargnuse
       )
group by cebe, clcocodi, clcodesc, cargsign, nit
