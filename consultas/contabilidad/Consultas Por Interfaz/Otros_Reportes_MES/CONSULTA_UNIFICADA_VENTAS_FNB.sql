-- CONSULTA UNIFICADA VENTAS FNB
select --cebe, (select f.cebedesc from open.ldci_centrobenef f where f.cebecodi = cebe) des_beneficio,
       clcocodi, clcodesc, cargsign, 
       nit, (select n.bannnomb from open.ldci_banconit n where n.bannnnit = nit and rownum = 1) nom_proveedor,
       sum(valor) valor
  from (
        select clcocodi, clcodesc, cargsign, 
               CASE WHEN CARGCONC = 832 THEN
                    '9002004353'
                 ELSE
                    open.ldci_pkinterfazsap.fnuDatosVentaBrillaRO(substr(cargdoso,4,8)) 
               END Nit,
               sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
/*               (select l.celocebe from open.ldci_centbenelocal l 
                 where l.celoloca in (SELECT  unique b.geograp_location_id
                                        FROM open.pr_product a, open.ab_address b
                                       WHERE a.address_id = b.address_id
                                         and a.product_id = c.cargnuse)) CEBE*/
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
          and FACTFEGE BETWEEN to_date('01/08/2018 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                           and to_date('31/08/2018 23:59:59','dd/mm/yyyy hh24:mi:ss')    
          and cargprog = proccons    
          and cargtipr = 'A'    
          and cargsign NOT IN ('PA','AP','SA') 
          and cargcaca IN (19)
        group by clcocodi, clcodesc, CARGSIGN, cargdoso, cargnuse, cargconc
       )
group by /*cebe,*/ clcocodi, clcodesc, cargsign, nit
--
UNION
-- NOTAS FNB PROVEEDOR
select --cebe, (select f.cebedesc from open.ldci_centrobenef f where f.cebecodi = cebe) des_beneficio,
       clcocodi, clcodesc, cargsign, 
       nit, (select n.bannnomb from open.ldci_banconit n where n.bannnnit = nit and rownum = 1) nom_proveedor,
       sum(valor) valor
  from (
          select clcocodi, clcodesc, cargsign, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor,
/*                 (select l.celocebe from open.ldci_centbenelocal l 
                  where l.celoloca in (SELECT  unique b.geograp_location_id
                                         FROM open.pr_product a, open.ab_address b
                                        WHERE a.address_id = b.address_id
                                          and a.product_id = c.cargnuse)) CEBE,
               (select (select co.nombre_contratista from OPEN.GE_CONTRATISTA co 
                           where co.id_contratista =  ut.contractor_id) nombre                          
                  from open.or_order_Activity a, open.or_order o, OPEN.OR_OPERATING_UNIT ut
                 where a.package_id   = substr(cargdoso,4,8)
                   and a.task_type_id = 10143
                   and a.order_id = o.order_id
                   and rownum = 1
                   and o.operating_unit_id = ut.operating_unit_id) Proveedor,*/
                CASE WHEN CARGCONC = 832 THEN
                    '9002004353'
                  ELSE
                    open.ldci_pkinterfazsap.fnuDatosVentaBrillaRO(substr(cargdoso,4,8)) 
                END Nit
           from open.cargos c,open.SERVSUSC ss, open.CONCEPTO CO, open.CAUSCARG csc, 
		            open.procesos, open.ic_clascont, open.perifact, OPEN.SERVICIO
          where c.cargcaca = csc.cacacodi
            and c.cargnuse = ss.sesunuse
            and c.CARGCONC = CO.CONCCODI
            and c.cargfecr between to_date('01/08/2018 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                               and to_date('31/08/2018 23:59:59','dd/mm/yyyy hh24:mi:ss')
            and cargprog = proccons
            and clcocodi(+) = concclco
            and cargpefa = pefacodi
            and ss.sesuserv = servcodi
            AND CARGCUCO > 0
            and cargtipr = 'P'
            and cargsign NOT IN ('PA','AP')
            AND substr(cargdoso,1,2) NOT IN ('PA','AP')
            and concclco = 2
            and cargcaca = 19
          group by  clcocodi, clcodesc, cargsign, cargnuse, substr(cargdoso,4,8), CARGCONC
       )
group by /*cebe,*/ clcocodi, clcodesc, cargsign, /*proveedor,*/ nit
