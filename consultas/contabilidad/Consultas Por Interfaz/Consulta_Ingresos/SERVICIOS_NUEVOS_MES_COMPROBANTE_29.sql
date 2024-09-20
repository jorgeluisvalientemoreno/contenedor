select cargconc, sum(cargvalo) from open.cargos
 where cargnuse in (select hcecnuse from open.hicaesco
                     where hcececan =  96
                       and hcececac =  1
                       and hcecfech >= '01-06-2015'
                       and hcecfech <  '01-07-2015'
                       and hcecserv =  7014)
and cargconc in (19,30,674) and cargcaca = 53 and cargsign = 'DB'
group by cargconc
