select *
  from open.ta_conftaco t
  left join open.ta_tariconc ta
    on cotccons = tacocotc
  left join open.ta_vigetaco
    on tacocons = vitctaco
  left join open.concepto c
    on cotcconc = c.conccodi
 where cotcconc in (991)
-- and cotcserv =7014 and cotcvige = 'S' --and cotcdect= 122 and vitcfefi >='01/10/2023' and tacocr01=4-- and  TACOCR02= 2 and TACOCR03= 1
;

select v.*
  from open.TA_TARICOPR
  left join open.ta_vigetaco
    on vitctaco = tacptacc
  left join open.TA_VIGETACP v
    on TACPCONS = VITPTACP
 where vitctaco in (4130, 4131);

select * from open.ta_conftaco tc where tc.cotcconc = 991;
select * from open.ta_vigetaco tv where tv.vitctaco in (4130, 4131);
select *
  from open.TA_VIGETACP tvt
 where tvt.vitpcons in (408288, 408289, 408290, 408291);
select *
  from open.ta_conftaco t
  left join open.ta_tariconc ta
    on cotccons = tacocotc
  left join open.ta_vigetaco
    on tacocons = vitctaco
  left join open.concepto c
    on cotcconc = c.conccodi
 where cotcconc in (991)
-- and cotcserv =7014 and cotcvige = 'S' --and cotcdect= 122 and vitcfefi >='01/10/2023' and tacocr01=4-- and  TACOCR02= 2 and TACOCR03= 1
;

select * from open.ta_conftaco tc where tc.cotcconc = 991;
select * from open.ta_vigetaco tv where tv.vitctaco in (4130, 4131);
select * from open.TA_VIGETACP d order by 1 desc;

select v.*
  from open.TA_TARICOPR
  left join open.ta_vigetaco
    on vitctaco = tacptacc
  left join open.TA_VIGETACP v
    on TACPCONS = VITPTACP
 where vitctaco in (4130, 4131)
