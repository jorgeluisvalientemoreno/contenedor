-- PROVISION CONTRIBUCION
select cebe, cate, suca, caca, conc, conc_desc, clacon, des_clas, m3, sum(total) TOTAL,
       sum(CONSUMO) CONSUMO, sum(CARGO_FIJO) CARGO_FIJO, ciclo
  from
(
select l.celocebe CEBE, sesucate CATE, sesusuca SUCA, cargcaca CACA, cargconc CONC, o.concdesc CONC_DESC, 
       o.concclco CLACON, (select t.clcodesc from open.ic_clascont t where t.clcocodi = o.concclco) DES_CLAS,
      cargnuse, sum(cargunid) M3, 
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) TOTAL,
       (select sum(cargvalo) from open.cargos g where g.cargnuse = c.cargnuse and g.cargpefa = pefacodi and cargconc = 31
        group by g.cargnuse, g.cargpefa) CONSUMO,
       (select sum(cargvalo) from open.cargos g where g.cargnuse = c.cargnuse and g.cargpefa = pefacodi and cargconc = 17
        group by g.cargnuse, g.cargpefa) CARGO_FIJO,        
       pefacicl CICLO, cargtipr TIPO
  from open.cargos c, open.perifact p, open.concepto o, open.servsusc s, open.ldci_centbenelocal l
where p.pefaano = 2015 
   and p.pefames = 7              -- Mes del de donde se toma la informacion para provisionar.
   and pefaffmo >= '01-08-2015'   -- Fecha desde donde terminan los ciclos a provisionar.
   and cargpefa = pefacodi
   and cargconc = conccodi
   and concclco in (8)
   and cargcaca in (1,3,4,15,16,51,53,54,57,60)
   and cargsign NOT IN ('PA','AP')       
   and cargnuse = sesunuse
   and sesuserv in (7014, 6121, 7055)
   and sesucate in (1,2,3)
   and l.celoloca = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS 
                      where address_id = (select susciddi from OPEN.SUSCRIPC where susccodi = sesususc))
group by l.celocebe, sesucate, sesusuca, cargcaca, cargconc, o.concdesc, o.concclco, cargsign, pefacicl, cargtipr, cargnuse,pefacodi
)
group by cebe, cate, suca, caca, conc, conc_desc, clacon, des_clas, m3, ciclo
