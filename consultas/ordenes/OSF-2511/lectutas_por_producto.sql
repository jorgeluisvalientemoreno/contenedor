select l.leemsesu, ss.sesuesco, ss.sesuesfn, m.emsscoem, l.leemlean, l.leemfela, l.leemleto, l.leemfele, l.leemoble, (Select ol.obledesc from 
     obselect ol where l.leemoble = ol.oblecodi) OBSERVACION_LECTURA, l.leemflco, l.leemdocu, a.activity_id, i.description, ss.sesucicl
from lectelme l,
     elmesesu  m,
     or_order_activity  a,
     ge_items  i,
     servsusc  ss
where l.leemelme = m.emsselme
And   l.leemdocu = a.Order_Activity_Id
And   a.activity_id = i.items_id
and   l.leemsesu = ss.sesunuse
And  l.leemsesu in (1067100)
order by l.leemfele desc;


