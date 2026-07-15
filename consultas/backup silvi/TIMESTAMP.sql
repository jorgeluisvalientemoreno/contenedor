--select * from servsusc where sesucicl = 4146;
--select * from ciclo c where c.ciclcodi= 4152;


select * from personalizaciones.detalle_envio_fact_digital as of timestamp
to_timestamp ( '15/01/2024 10:00:00' , 'YYYY-MM-DD H24:MI:SS')
 where periodo_facturacion = 107547
;


SELECT *
FROM SUSCRIPC AS OF TIMESTAMP to_timestamp('15/01/2024 14:00:00', 'DD/MM/YYYY HH24:MI:SS')
WHERE susccodi = 66868172;
