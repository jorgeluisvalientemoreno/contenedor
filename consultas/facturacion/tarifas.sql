select *
from open.servsusc
where sesunuse=6627601;
select *
from open.pr_product
where product_id=6627601;
select *
from open.cargos
where cargnuse=6627601
  and cargconc=31
  and cargpeco in (25532,25534 )
  --and cargunid in (632,300)
  ;
  
select *
from open.perifact
--where pefacodi in (25532,25535);
where pefacicl=7924
order by 1;

select *
from open.pericose
where pecscico=7924
order by 1;

SELECT  *
FROM    open.ta_conftaco
WHERE   ta_conftaco.cotcconc in (31);
SELECT *
FROM open.ta_confcrta, open.ta_deficrbt
WHERE decbcons = coctdecb
  and coctdect=2
ORDER BY coctprio;

SELECT  *
FROM    open.ta_tariconc
WHERE   ta_tariconc.tacocotc IN (
                                SELECT  ta_conftaco.cotccons
                                FROM    open.ta_conftaco
                                WHERE   ta_conftaco.cotcconc in (31)
                                )
                                and tacocons=5578
and tacocr01=2
and tacocr02=1
and tacocr03=258
order by tacocr01, tacocr02, tacocr03;

--and vitcfefi<=
SELECT  *
FROM    open.ta_vigetaco
WHERE   ta_vigetaco.vitctaco IN (
                                    SELECT  tacocons
                                    FROM    open.ta_tariconc
                                    WHERE   ta_tariconc.tacocotc IN (
                                                                   SELECT  ta_conftaco.cotccons
                                                                    FROM    open.ta_conftaco
                                                                     WHERE   ta_conftaco.cotcconc in (31)
                                                                    )
                                   -- and tacocr01=2
                                  --  and tacocr02=1
                                  --  and tacocr03=258
                          )
                          
and vitccons in (16182, 16764);
--17/12/2014 4:48:42 p. m.
--19/01/2015 3:13:22 p. m.
--Tarifas por rangos
SELECT  *
FROM    open.ta_rangvitc
WHERE   ta_rangvitc.ravtvitc IN (/*16759,17359*/16182)
--where ravtcons in (/*19604, 18806, 19604,*/ 16182)
order by ravtvitc;
