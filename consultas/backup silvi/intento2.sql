select sesunuse , sesususc 
from servsusc s
where sesunuse in (select cargnuse 
                   from cargos
                   where cargcuco <> -1 
                   and cargvalo > 0 
                   and cargpefa in (99180,99576,99972,99004,99400,99331,99727,100123,99191,99587,99983,
                   99168,99564,99960,99158,99554,99950,99017,99413,99250,99646,99259,99655,99367,99763,
                   99375,99771,99073,99469,99074,99470,99296,99692,99106,99502,99108,99504,99113,99509,
                   99142,99538,99226,99622,99192,99588,99984,99109,99505,99051,99447,99336,99732,99254,
                   99650,99111,99507,99198,99594,99372,99768,99292,99688,99264,99660,99229,99625,99349,
                   99745,99378,99774)
                   and (select count(distinct(d.difecofi))
                   from open.diferido d
                   where  d.difenuse = cargnuse
                   and d.difeprog != 'GCNED'
                   and d.difesape > 0)  > 0
                   and (select count(distinct(d.difecofi))
                   from open.diferido d
                   where  d.difenuse = cargnuse
                   and d.difeprog = 'GCNED'
                   and d.difesape > 0)  > 0   
                   and (select count(distinct(d.difecofi))
                   from open.diferido d
                   where  d.difenuse = cargnuse
                   and d.difesape > 0
                   and difeconc in (193) ) >1)
and  sesuserv in (7014,7055)
