select  lectelme.leemsesu "Producto",
         servsusc.sesucate "Categoria",
         servsusc.sesuesfn "Estado finan",
         sesuesco "Estado de corte",
         elmesesu.emsscoem  "Medidor" ,
         lectelme.leempefa "Periodo_fact",
         lectelme.leempecs "Periodo_cons",
         lectelme.leemlean "Lectura_anterior",
         lectelme.leemfela  "Fecha_lect_ant",
         lectelme.leemleto  "Lectura_actual",
         lectelme.leemfele "Fecha_lect_act",
         lectelme.leemoble || '- ' || initcap(obledesc)  "Onl",
   Case when lectelme.leemclec = 'F' then 'Facturacion'
        when lectelme.leemclec = 'R' then 'Retiro' 
        when lectelme.leemclec = 'I' then 'Instalacion'
        when lectelme.leemclec = 'T' then 'Trabajo' end as "Causal_lect",
          lectelme.leemdocu 
from open.lectelme 
left join open.obselect on lectelme.leemoble = obselect.oblecodi 
left join open.elmesesu on elmesesu.emsssesu  = lectelme.leemsesu and lectelme.leemelme = elmesesu.emsselme 
left join open.servsusc on  lectelme.leemsesu = servsusc.sesunuse 
where  leemsesu = 1042728 
order by  leemfele desc

--update lectelme set leemoble = 38 where  leemsesu = 52285789 and leemclec = 'F' and leempecs in (107136) 
--update servsusc set sesuesfn = 'C' where sesunuse = 52285789
--update servsusc set sesuesco =5 where sesunuse = 52285789
--update lectelme set  lectelme.leemleto = NULL  where  leemsesu = 52285789 and leemclec = 'F' and leempecs in (107136) 
