--alter session set current_schema=open;
select l.leemsesu,
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
  inner join or_order_activity a on a.Order_Activity_Id = l.leemdocu
  inner join ge_items i on i.items_id = a.activity_id
  inner join servsusc ss on ss.sesunuse = l.leemsesu
  left join obselect ol on ol.oblecodi = l.leemoble
 where  l.leemsesu in (6500507)
 order by l.leemfele desc;
