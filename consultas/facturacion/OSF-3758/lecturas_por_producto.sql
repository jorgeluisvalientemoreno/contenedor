select l.leemsesu,
       ss.sesuesco,
       ss.sesuesfn,
       m.emsscoem,
       ss.sesucicl,
       l.leempefa,
       l.leempecs,
       l.leemlean,
       l.leemfela,
       l.leemleto,
       l.leemfele,
       l.leemoble,
       ol.obledesc,
       l.leemflco,
       l.leemdocu,
       a.activity_id,
       i.description       
  from lectelme l
  inner join elmesesu m on m.emsselme = l.leemelme
  inner join or_order_activity a on a.Order_Activity_Id = l.leemdocu
  inner join ge_items i on i.items_id = a.activity_id
  inner join servsusc ss on ss.sesunuse = l.leemsesu
  left join obselect ol on ol.oblecodi = l.leemoble
 where  l.leemsesu in (2018012)
 order by l.leemfele desc;
