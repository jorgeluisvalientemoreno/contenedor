-- NOTAS FNB PROVEEDOR
select cebe, (select f.cebedesc from open.ldci_centrobenef f where f.cebecodi = cebe) des_beneficio,
       clcocodi, clcodesc, cargsign, 
       usuario nom_proveedor,
       sum(valor) valor
  from (
        select clcocodi, clcodesc, cargsign, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor,
               (select l.celocebe from open.ldci_centbenelocal l 
                 where l.celoloca in (SELECT  unique b.geograp_location_id
                                        FROM open.pr_product a, open.ab_address b
                                       WHERE a.address_id = b.address_id
                                         and a.product_id = c.cargnuse)) CEBE,
               (SELECT name_ FROM open.ge_person WHERE user_id = cargusua) usuario
        from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO, open.CAUSCARG csc, open.procesos, 
             open.ic_clascont, open.perifact, OPEN.SERVICIO
        where c.cargcaca = csc.cacacodi
          and c.cargnuse = ss.sesunuse
          and c.CARGCONC = CO.CONCCODI
          and c.cargfecr between to_date('01/07/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                             and to_date('31/07/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
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
        group by clcocodi, clcodesc, cargsign, cargusua, cargnuse
       )
group by cebe, clcocodi, clcodesc, cargsign, usuario
