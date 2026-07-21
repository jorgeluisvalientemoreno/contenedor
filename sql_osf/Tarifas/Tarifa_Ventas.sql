--TARIFAS VENTAS
select cotcconc,
       cotcserv,
       cotcvige,
       tacocr01 PLAN_COME,
       tacocr02,
       tacocr03,
       vitctaco,
       vitccons,
       vitcfein,
       vitcfefi,
       vitcvalo,
       vitcporc
  from ta_conftaco t
  left join ta_tariconc ta
    on cotccons = tacocotc
  left join open.ta_vigetaco
    on tacocons = vitctaco
  left join open.concepto c
    on cotcconc = c.conccodi
 where cotcconc in (287, 137)
   and cotcserv = 7014
   and cotcvige = 'S'
   and vitcfefi >= '01/05/2024' --and cotcdect= 122 and vitcfefi >='01/10/2023' and tacocr01=4-- and  TACOCR02= 2 and TACOCR03= 1
;
