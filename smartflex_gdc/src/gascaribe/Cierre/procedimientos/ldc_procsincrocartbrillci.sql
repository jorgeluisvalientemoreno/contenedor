CREATE OR REPLACE PROCEDURE ldc_procsincrocartbrillci(nupano  IN NUMBER,
                                                      nupmes  IN NUMBER,
                                                      sbmensa OUT VARCHAR2,
                                                      error   OUT NUMBER) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-1-08
  Descripcion : Generamos información sincronizacion cuentas brilla vs gas a cierre

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
nuconta   NUMBER(8) DEFAULT 0;
nuvalored ld_parameter.numeric_value%TYPE;
CURSOR cur_sincrobrillgas IS
 SELECT '1.Cartera total gas > '||to_char(nuvalored)||' dias.' concepto
      ,x.tipo_producto producto
      ,x.departamento
      ,x.localidad
      ,NVL(SUM(x.sesusape+x.deuda_no_corriente),0) total_cartera
  FROM open.ldc_osf_sesucier x
 WHERE x.nuano = nupano
   AND x.numes = nupmes
   AND x.area_servicio = x.area_servicio
   AND x.tipo_producto = 7014
   AND x.edad >= nuvalored
   AND x.contrato IN(
                    SELECT distinct(contrato)
                      FROM open.ldc_osf_sesucier
                     WHERE nuano = nupano
                       AND numes = nupmes
                       AND area_servicio = area_servicio
                       AND tipo_producto IN(7055,7056)
                       AND edad >= nuvalored
                       AND contrato = x.contrato)
 GROUP BY x.tipo_producto
         ,x.departamento
         ,x.localidad
UNION ALL
 SELECT '2.Cartera total brilla > '||to_char(nuvalored)||' dias.' concepto
       ,tipo_producto producto
       ,departamento departamento
       ,localidad localidad
       ,NVL(SUM(t.total_cartera),0) total_cartera
   FROM total_cart_mes t
  WHERE nuano = nupano
    AND numes = nupmes
    AND tipo_producto IN(7055,7056)
    AND t.edad >= nuvalored
 GROUP BY tipo_producto,departamento,localidad,edad
UNION ALL
 SELECT '3.Total usuarios brilla en cartera > '||to_char(nuvalored)||' dias.'
       ,tipo_producto
       ,departamento
       ,localidad
       ,NVL(SUM(t.cantidad_clientes),0) total_cartera
   FROM total_cart_mes t
  WHERE nuano = nupano
    AND numes = nupmes
    AND tipo_producto IN(7055,7056)
    AND t.edad >= nuvalored
 GROUP BY tipo_producto,departamento,localidad,edad
UNION ALL
SELECT '4.Total usuarios gas en cartera > '||to_char(nuvalored)||' dias.'
      ,x.tipo_producto producto
      ,x.departamento
      ,x.localidad
      ,COUNT(contrato) cantidad_usuarios
  FROM open.ldc_osf_sesucier x
 WHERE x.nuano = nupano
   AND x.numes = nupmes
   AND x.area_servicio = x.area_servicio
   AND x.tipo_producto = 7014
   AND x.edad >= nuvalored
   AND x.contrato IN(
                    SELECT distinct(contrato)
                      FROM open.ldc_osf_sesucier
                     WHERE nuano = nupano
                       AND numes = nupmes
                       AND area_servicio = area_servicio
                       AND tipo_producto IN(7055,7056)
                       AND edad >= nuvalored
                       AND contrato = x.contrato)
 GROUP BY x.tipo_producto
         ,x.departamento
         ,x.localidad
UNION ALL
SELECT '5.Total usuarios brilla en cartera > '||to_char(nuvalored)||' dias sin GAS.'
      ,tipo_producto producto
      ,departamento departamento
      ,localidad localidad
      ,COUNT(producto) total_usu_bril_sin_gas
  FROM open.ldc_osf_sesucier s
 WHERE s.nuano = nupano
   AND s.numes = nupmes
   AND s.tipo_producto IN(7055,7056)
   AND s.edad >= nuvalored
   AND 0 = (SELECT COUNT(1)
              FROM open.ldc_osf_sesucier i
             WHERE i.nuano = nupano
               AND i.numes = nupmes
               AND i.tipo_producto = 7014
               AND i.contrato = s.contrato)
 GROUP BY tipo_producto
         ,departamento
         ,localidad
         ,edad
UNION ALL
 SELECT '8.Cartera total brilla'
       ,tipo_producto
       ,departamento
       ,localidad
       ,NVL(SUM(t.total_cartera),0) total_cartera
   FROM total_cart_mes t
  WHERE nuano = nupano
    AND numes = nupmes
    AND tipo_producto IN(7055,7056)
 GROUP BY tipo_producto,departamento,localidad,edad;
BEGIN
 DELETE open.ldc_osf_sin_ctas_bril y WHERE y.nuano = nupano AND y.numes = nupmes;
 COMMIT;
 nuvalored := dald_parameter.fnuGetNumeric_Value('PARAM_EDAD_SINC_BRIL_GAS',NULL);
 nuconta := 0;
 FOR i IN cur_sincrobrillgas LOOP
  INSERT INTO open.ldc_osf_sin_ctas_bril(
                                         nuano
                                        ,numes
                                        ,indica
                                        ,valor
                                        ,departamento
                                        ,localidad
                                        ,tipo_producto
                                        ,edad
                                        )
                                  VALUES(
                                         nupano
                                        ,nupmes
                                        ,i.concepto
                                        ,i.total_cartera
                                        ,i.departamento
                                        ,i.localidad
                                        ,i.producto
                                        ,nuvalored
                                       );
  nuconta := nuconta + 1;
 END LOOP;
COMMIT;
 sbmensa := 'Proceso terminó Ok. Se procesarón : '||to_char(nuconta)||' registros.';
 error := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_procsincrocartbrillci error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  error := -1;
END;
/
