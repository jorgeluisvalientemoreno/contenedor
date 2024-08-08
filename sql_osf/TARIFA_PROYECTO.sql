--TARIFAS VENTAS
--EStado Proyecto
select * from open.TA_ESTAPROY;

--Concepto
select c.* from open.concepto c where c.conccodi in (985);

--Servicio tipo 3
--Proyecto Tarifa
select tpt.*
  from open.TA_PROYTARI tpt
 where tpt.prtaserv = 3
   and tpt.prtaesta in (1, 2, 3);

--Tarifa con un concepto asociado al proyecto de tarifa
select *
  from open.TA_TARICOPR tcp
 where tcp.tacpprta in (select tpt.prtacons
                          from open.TA_PROYTARI tpt
                         where tpt.prtaserv = 3
                           and tpt.prtaesta in (1, 2, 3))
   and tcp.tacptacc in
       (select tt.tacocons
          from open.ta_tariconc tt
         where tt.tacocotc in (select tc.cotccons
                                 from open.ta_conftaco tc
                                where cotcconc in (985)
                                  and cotcserv = 3
                                  and cotcvige = 'S'));
--Vigencia de tarifa
select w.*, rowid
  from ta_conftaco w
 where w.cotcserv = 3
   and w.cotcconc = 985;
select t.*, rowid
  from open.TA_VIGETACO t
 where t.vitctaco in
       (select tcp.tacptacc
          from open.TA_TARICOPR tcp
         where tcp.tacpprta in
               (select tpt.prtacons
                  from open.TA_PROYTARI tpt
                 where tpt.prtaserv = 3
                   and tpt.prtaesta in (1, 2, 3))
           and tcp.tacptacc in
               (select tt.tacocons
                  from open.ta_tariconc tt
                 where tt.tacocotc in (select tc.cotccons
                                         from open.ta_conftaco tc
                                        where cotcconc in (985)
                                          and cotcserv = 3
                                          and cotcvige = 'S')));
select t.*, rowid
  from open.TA_VIGETACP t
 where t.vitptacp in
       (select tcp.tacpcons
          from open.TA_TARICOPR tcp
         where tcp.tacpprta in (select tpt.prtacons
                                  from open.TA_PROYTARI tpt
                                 where tpt.prtaserv = 3)
           and tcp.tacptacc in
               (select tt.tacocons
                  from open.ta_tariconc tt
                 where tt.tacocotc in (select tc.cotccons
                                         from open.ta_conftaco tc
                                        where cotcconc in (985)
                                          and cotcserv = 3
                                          and cotcvige = 'S')));

--Rando de tarifa
select tcvt.*, rowid
  from TA_RANGVITP tcvt
 where tcvt.ravpvitp in
       (select t.vitpcons
          from open.TA_VIGETACP t
         where t.vitptacp in
               (select tcp.tacpcons
                  from open.TA_TARICOPR tcp
                 where tcp.tacpprta in
                       (select tpt.prtacons
                          from open.TA_PROYTARI tpt
                         where tpt.prtaserv = 3)
                   and tcp.tacptacc in
                       (select tt.tacocons
                          from open.ta_tariconc tt
                         where tt.tacocotc in
                               (select tc.cotccons
                                  from open.ta_conftaco tc
                                 where cotcconc in (985)
                                   and cotcserv = 3
                                   and cotcvige = 'S'))));

--Servicio tipo 7014
--Proyecto Tarifa
select tpt.*
  from open.TA_PROYTARI tpt
 where tpt.prtaserv = 7014
   and tpt.prtaesta in (1, 2, 3);

--Tarifa con un concepto asociado al proyecto de tarifa
select *
  from open.TA_TARICOPR tcp
 where tcp.tacpprta in (select tpt.prtacons
                          from open.TA_PROYTARI tpt
                         where tpt.prtaserv = 7014
                           and tpt.prtaesta in (1, 2, 3))
   and tcp.tacptacc in
       (select tt.tacocons
          from open.ta_tariconc tt
         where tt.tacocotc in (select tc.cotccons
                                 from open.ta_conftaco tc
                                where cotcconc in (985)
                                  and cotcserv = 7014
                                  and cotcvige = 'S'));

--Vigencia de tarifa
select *
  from open.TA_VIGETACP t
 where t.vitptacp in
       (select tcp.tacpcons
          from open.TA_TARICOPR tcp
         where tcp.tacpprta in (select tpt.prtacons
                                  from open.TA_PROYTARI tpt
                                 where tpt.prtaserv = 7014 /*and tpt.prtaesta in (1,2,3)*/
                                )
           and tcp.tacptacc in
               (select tt.tacocons
                  from open.ta_tariconc tt
                 where tt.tacocotc in (select tc.cotccons
                                         from open.ta_conftaco tc
                                        where cotcconc in (985)
                                          and cotcserv = 7014
                                          and cotcvige = 'S')));

--Rando de tarifa
select *
  from TA_RANGVITP tcvt
 where tcvt.ravpvitp in
       (select t.vitpcons
          from open.TA_VIGETACP t
         where t.vitptacp in
               (select tcp.tacpcons
                  from open.TA_TARICOPR tcp
                 where tcp.tacpprta in (select tpt.prtacons
                                          from open.TA_PROYTARI tpt
                                         where tpt.prtaserv = 7014 /*and tpt.prtaesta in (1,2,3)*/
                                        )
                   and tcp.tacptacc in
                       (select tt.tacocons
                          from open.ta_tariconc tt
                         where tt.tacocotc in
                               (select tc.cotccons
                                  from open.ta_conftaco tc
                                 where cotcconc in (985)
                                   and cotcserv = 7014
                                   and cotcvige = 'S'))));

---------------------------------------------------
select *
  from open.ta_conftaco
 where cotcconc in (985)
   and cotcserv = 3
   and cotcvige = 'S';
select *
  from open.ta_tariconc tt
 where tt.tacocotc in (select tc.cotccons
                         from open.ta_conftaco tc
                        where cotcconc in (985)
                          and cotcserv = 3
                          and cotcvige = 'S');
select tvtc.*
  from open.ta_vigetaco tvtc
 where tvtc.vitctaco in
       (select tt.tacocons
          from open.ta_tariconc tt
         where tt.tacocotc in (select tc.cotccons
                                 from open.ta_conftaco tc
                                where cotcconc in (985)
                                  and cotcserv = 3
                                  and cotcvige = 'S'));
select *
  from TA_TARICOPR ttcp
 where ttcp.tacpcotc in (select tc.cotccons
                           from open.ta_conftaco tc
                          where cotcconc in (985)
                            and cotcserv = 3
                            and cotcvige = 'S');
select *
  from TA_VIGETACP p
/*where p.vitptacp in
(select ttcp.TACPCONS
   from TA_TARICOPR ttcp
  where ttcp.tacpcotc in (select tc.cotccons
                            from open.ta_conftaco tc
                           where cotcconc in (985)
                             and cotcserv = 3
                             and cotcvige = 'S'))*/
 order by 1 desc;

select * from TA_TARICOPR order by 1 desc;

--TARIFAS VENTAS
select ta.*
  from ta_conftaco t
  left join ta_tariconc ta
    on cotccons = tacocotc
  left join open.ta_vigetaco
    on tacocons = vitctaco
  left join open.concepto c
    on cotcconc = c.conccodi
 where cotcconc in (985)
   and cotcserv = 3
   and cotcvige = 'S' --and cotcdect= 122 and vitcfefi >='01/10/2023' and tacocr01=4-- and  TACOCR02= 2 and TACOCR03= 1
;
SELECT *
  FROM TA_RANGVITC
 WHERE RAVTVITC IN (40092, 15579) /*FOR UPDATE*/
;
SELECT a.*, rowid FROM Ta_Rangvitp a order by 1 desc;
-- TACOCR01 PLAN COMERCIAL
-- TACOCR02 SUBCATEGORIA
-- TACOCR03 CATEGORIA
--30 interna 19 cxc  674 cert
select * from ta_vigetaco where vitccons = 139644; -- for update
select * from ta_conftaco where cotcconc in (985); ---for update
select *
  from TA_VIGETACP p /*where trunc(p.vitpfefi) ='25/09/2023'*/
 order by 1 desc;

select * from TA_TARICOPR order by 1 desc;
select *
  from TA_RANGVITP
 where RAVPVITP in (391970, 391971)
 order by 1 desc;
