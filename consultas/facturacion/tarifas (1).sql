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
ORDER BY coctrio;
SELECT P.CATEGORY_ID, (SELECT CATEDESC FROM OPEN.CATEGORI WHERE CATECODI=P.CATEGORY_ID)
FROM OPEN.MO_MOTIVE M, OPEN.PR_PRODUCT P
WHERE M.PACKAGE_ID=54158096
  AND M.PRODUCT_ID=P.PRODUCT_ID;
  
SELECT *
FROM OPEN.TA_CONFTACO CO, OPEN.TA_DEFICRTA DE
WHERE COTCCONC=159
  AND DE.DECTCONS=CO.COTCDECT;
SELECT *
FROM OPEN.TA_DEFICRTA
;
SELECT *
FROM OPEN.TA_CONFCRTA
WHERE COCTDECB=7;
SELECT *
FROM OPEN.TA_DEFICRBT DE, OPEN.TA_CONFCRTA CO, OPEN.TA_DEFICRTA DA
WHERE CO.COCTDECB=DE.DECBCONS
  AND CO.COCTDECT=DA.DECTCONS
  AND DECTCONS=2;
  
SELECT *
FROM OPEN.FA_LOCAMERE
WHERE LOMRLOID=39;
SELECT *
FROM OPEN.LD_REL_MAR_GEO_LOC
WHERE GEOGRAP_LOCATION_ID=39;



   select *
  from open.TA_RANGVITC rv, open.TA_VIGETACO ta, open.TA_TARICONC tc, open.ta_conftaco tct
  where rv.ravtvitc=ta.VITCCONS
    and ta.vitctaco=tc.tacocons
    and tc.tacocotc=tct.cotccons
    and cotcconc=31
    and vitcfein>='01/05/2017'
    and ravtlisu<=20
    and tacocr02=1
    and tacocr01=2
    AND TACOCR03=1;
    and ravtcons in (21617,
22517,
22127);
    select *
    from open.RANGLIQU
    where ralisesu=10713
    and ralifecr>='01/06/2017'
    and ralifecr<'05/07/2017';
    
  SELECT *
  FROM OPEN.TA_DEFICRTA;

select *
from OPEN.TA_PROYTARI PR, OPEN.TA_TARICOPR TARIFA_CONC_PROY, OPEN.TA_VIGETACP VI, OPEN.TA_RANGVITP RAN
WHERE PR.PRTACONS=TARIFA_CONC_PROY.TACPPRTA
  AND TARIFA_CONC_PROY.TACPTACC=VI.VITPTACP
  AND RAN.RAVPVITP=VITPCONS
  
  --AND  tacocr02=1
  --and tacocr01=2
  --AND TACOCR03=1
;

select *
from OPEN.TA_PROYTARI PR, OPEN.TA_TARICOPR TARIFA_CONC_PROY, OPEN.TA_VIGETACP VI, OPEN.TA_RANGVITP RAN, OPEN.TA_CONFTACO TCT, OPEN.TA_DEFICRTA DEF,
	 open.TA_TARICONC TC, open.TA_VIGETACO ta, open.TA_RANGVITC rv
WHERE PR.PRTACONS=TARIFA_CONC_PROY.TACPPRTA
  AND TARIFA_CONC_PROY.TACPCONS=VI.VITPTACP
  AND RAN.RAVPVITP=VITPCONS
  AND TCT.COTCCONS=TARIFA_CONC_PROY.TACPCOTC
  AND TCT.COTCDECT=DEF.DECTCONS
  AND TC.TACOCOTC=TCT.COTCCONS
  and ta.vitctaco=tc.tacocons
  AND rv.ravtvitc=ta.VITCCONS
  AND cotcconc=31
 and tacocr02=TACPCR02
  and tacocr01=TACPCR01
  AND TACOCR03=TACPCR03
  AND NVL(TACOCR04,-1)=NVL(TACPCR04,-1)
  AND NVL(TACOCR05,-1)=NVL(TACPCR05,-1)
  AND NVL(TACOCR06,-1)=NVL(TACPCR06,-1)
  AND NVL(TACOCR07,-1)=NVL(TACPCR07,-1)
  AND NVL(TACOCR08,-1)=NVL(TACPCR08,-1)
  AND NVL(TACOCR09,-1)=NVL(TACPCR09,-1)
 -- AND ravtlisu<=20
  and vitcfein=VITPFEIN
  AND VITCFEFI=VITPFEFI
  AND VITCCONS IN (21617,22127);
SELECT *
FROM DBA_TAB_COMMENTS
WHERE TABLE_NAME IN ('TA_VIGETACP');
SELECT  *
FROM    open.ta_tariconc
WHERE   ta_tariconc.tacocotc IN (
                                SELECT  * --ta_conftaco.cotccons
                                FROM    open.ta_conftaco
                                WHERE   ta_conftaco.cotcconc in (159)
                                AND COTCCONS=685
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



-- error tarifas ventas
  select * from open.TA_INDETABU
    where intainde like '547-%';