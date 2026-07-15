--items_seriados
SELECT DISTINCT s.id_items_seriado,
       s.items_id,
       ss.seriestr,
       s.serie,
       s.id_items_estado_inv,
       e.descripcion,
       s.operating_unit_id,
       s.costo,
       s.fecha_ingreso
  FROM open.ge_items_seriado s
  INNER JOIN ge_items_estado_inv e ON s.id_items_estado_inv = e.id_items_estado_inv
  INNER JOIN ldci_seridmit ss ON ss.serinume = s.serie
 WHERE 1 = 1
 --and   s.operating_unit_id = 4642
and   s.items_id = 10004070
--AND s.id_items_estado_inv = 1
and ss.seriestr in (123102147150201,
123102541150201,
123102520150201,
123102539150201,
123102474150201
);

