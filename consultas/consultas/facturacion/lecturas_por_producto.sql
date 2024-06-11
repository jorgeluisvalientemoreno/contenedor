select lectelme.leemsesu Producto,
       lectelme.leempefa Periodo_fact,
       lectelme.leempecs Periodo_cons,
       lectelme.leemoble ||' ' || obselect.obledesc Obs_No_Lect,
       lectelme.leemlean Lectura_ant,
       lectelme.leemfela Fecha_Ant,
       lectelme.leemleto Lect_tomada,
       lectelme.leemfele Fecha_Lectura,
       lectelme.leemclec causal_lect
from open.lectelme
left join open.obselect on leemoble = obselect.oblecodi
order by lectelme.leemfele desc