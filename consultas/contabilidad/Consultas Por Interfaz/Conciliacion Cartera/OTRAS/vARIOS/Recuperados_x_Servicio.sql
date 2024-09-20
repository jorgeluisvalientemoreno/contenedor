-- Recuperados por Servicio
select sesuserv, sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) Total 
  from open.cargos c, open.servsusc s
 where cargnuse = sesunuse
   and cargcaca = 58
   and cargfecr > '08-02-2015' and cargfecr < '01-03-2015'
group by sesuserv
