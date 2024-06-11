select  lectelme.leemsesu "Producto",
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
        when lectelme.leemclec = 'T' then 'Trabajo' end as "Causal_lect"
from open.lectelme
left join open.obselect on lectelme.leemoble = obselect.oblecodi 
left join open.elmesesu on elmesesu.emsssesu  = lectelme.leemsesu and lectelme.leemelme = elmesesu.emsselme 
where  leemsesu =1136143
order by  leemfele desc
