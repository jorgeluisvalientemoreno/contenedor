-- Provision Intereses y Recargos x Mora
select l.celocebe, sesucate, sesusuca, cargcaca, cargconc, o.concdesc, o.concclco, i.clcodesc, cargsign, sum(cargunid) M3,
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor, pefacicl, cargtipr
  from open.cargos c, open.perifact p, open.concepto o, open.servsusc s, open.ldci_centbenelocal l, open.ic_clascont i
where p.pefaano = 2015 
   and p.pefames = 7              -- Mes del de donde se toma la informacion para provisionar.
   and pefaffmo >= '01-08-2015'   -- Fecha desde donde terminan los ciclos a provisionar.
   and cargpefa = pefacodi
   and cargconc = conccodi
   and concclco in (46,56,58,59,86,99,100,101,102,103)
   and (cargcaca in (1,3,4,15,16,53,54,57,60) OR (cargcaca = 51 and cargdoso like 'ID%'))
   and cargsign NOT IN ('PA','AP')       
   and cargnuse = sesunuse
   and sesuserv in (7014, 6121, 7055) and o.concclco = i.clcocodi
   and l.celoloca = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS 
                      where address_id = (select susciddi from OPEN.SUSCRIPC where susccodi = sesususc))
group by l.celocebe, sesucate, sesusuca, cargcaca, cargconc, o.concdesc, o.concclco, i.clcodesc, cargsign, pefacicl, cargtipr;
