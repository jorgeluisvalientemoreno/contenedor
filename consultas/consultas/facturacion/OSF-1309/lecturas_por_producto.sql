--alter session set current_schema=open;
select l.leemsesu,
       l.leempefa,
       l.leempecs,
       ss.sesuesco,
       ss.sesuesfn,
       m.emsscoem,
       l.leemlean,
       l.leemfela,
       l.leemleto,
       l.leemfele,
       l.leemoble,
       ol.obledesc,
       l.leemflco,
       l.leemdocu,
       a.activity_id,
       i.description,
       l.leemclec,
       ss.sesucicl
  from lectelme l
 inner join elmesesu m on m.emsselme = l.leemelme
 left join or_order_activity a on a.Order_Activity_Id = l.leemdocu
 left join ge_items i on i.items_id = a.activity_id
 left join servsusc ss on ss.sesunuse = l.leemsesu
  left join obselect ol on ol.oblecodi = l.leemoble
 where l.leemsesu in (1000867)
 order by l.leemfela desc;
