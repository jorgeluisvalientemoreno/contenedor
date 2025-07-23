SELECT pp.subscription_id contrato,
       pp.product_id producto,
       emss.emsselme Serial,
       emss.emsscoem Medidor,
       emss.emssfein Fecha_Instalacion,
       emss.emssfere Fecha_Retira,
       lt.leemfele Fecha_lectura_Actual,
       lt.leemleto Lectura_Actual,
       lt.leemfela Fecha_lectura_Anterior,
       lt.leemlean Lectur_Anterio,
       lt.leemoble Observacion_Lectura,
       decode(lt.leemclec,
              'I',
              'I - Instalacion',
              'R',
              'R - Retiro',
              'F',
              'F - Facturacion',
              'T - Trabajo') Causal_Lectura
  FROM open.pr_product pp
 inner JOIN open.elmesesu emss
    ON emss.emsssesu = pp.product_id
  left join open.lectelme lt
    on lt.leemelme = emss.emsselme
 where
--emss.emsssesu = 52774400
 pp.subscription_id = 17123961
 order by lt.leemfele desc
