select  l.leemsesu "Producto",
         e.emsscoem  "Medidor" ,
         l.leempefa "Periodo_fact",
         l.leempecs "Periodo_cons",
         ss.sesuesco  "Estado_corte",
         ss.sesuesfn  "Estado_Finan",
         l.leemlean "Lectura_anterior",
         l.leemfela  "Fecha_lect_ant",
         l.leemleto  "Lectura_actual",
         l.leemfele "Fecha_lect_act",
         l.leemoble || '- ' || initcap(ol.obledesc)  "Onl",
   Case when l.leemclec = 'F' then 'Facturacion'
        when l.leemclec = 'R' then 'Retiro'
        when l.leemclec = 'I' then 'Instalacion'
        when l.leemclec = 'T' then 'Trabajo' end as "Causal_lect",
          l.leemdocu  "Documento",
          a.activity_id  || '- ' || initcap(i.description)  "Actividad",
          ss.sesucicl  "Ciclo"
from open.lectelme  l
inner join open.elmesesu  e on e.emsssesu  = l.leemsesu and l.leemelme = e.emsselme
inner join or_order_activity a on a.Order_Activity_Id = l.leemdocu
inner join ge_items i on i.items_id = a.activity_id
inner join servsusc ss on ss.sesunuse = l.leemsesu
left join open.obselect ol on l.leemoble = ol.oblecodi
where  leemsesu =6588877
order by  leemfele desc
