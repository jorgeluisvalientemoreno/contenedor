select cargconc, k.package_type_id, sum(cargvalo)
  from open.cargos c, open.mo_packages k
 where cargfecr >= '01-09-2015'
   and cargfecr <  '01-10-2015'
   and cargnuse in (SELECT distinct hcecnuse
                     FROM open.hicaesco h
                    WHERE hcececan = 96
                      AND hcececac = 1
                      AND hcecserv = 7014
                      AND hcecfech >= '01-09-2015' and hcecfech < '01-10-2015')
   and cargcaca in (53,41)
   and cargsign = 'DB'
   and cargconc in (19,30,674) and substr(cargdoso,4,8) = k.package_id
group by cargconc, k.package_type_id
