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
       ss.sesucicl
  from open.lectelme l
  inner join open.elmesesu m on m.emsselme = l.leemelme
  inner join open.or_order_activity a on a.Order_Activity_Id = l.leemdocu
  inner join open.ge_items i on i.items_id = a.activity_id
  inner join open.servsusc ss on ss.sesunuse = l.leemsesu
  left join open.obselect ol on ol.oblecodi = l.leemoble
 where  l.leemsesu in (14513807)
 order by l.leemfele desc;
