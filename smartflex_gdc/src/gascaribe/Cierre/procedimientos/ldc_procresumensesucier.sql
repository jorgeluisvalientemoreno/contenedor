CREATE OR REPLACE PROCEDURE ldc_procresumensesucier(nupano IN NUMBER,
                                                    nupmes IN NUMBER,
                                                   sbmensa OUT VARCHAR2,
                                                   error  OUT NUMBER) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-12-30
  Descripcion : Generamos información de la cartera resumida a cierre

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
14/01/2016      JJJM    Agregamos el campo nro de cuentas con saldo
***************************************************************************/
nuconta NUMBER(8) DEFAULT 0;
BEGIN
  DELETE total_cart_mes WHERE nuano =  nupano AND numes = nupmes;
  COMMIT;
nuconta := 0;
  INSERT INTO total_cart_mes(
SELECT
       s.nuano
      ,s.numes
      ,s.tipo_producto
      ,s.departamento
      ,s.localidad
      ,s.ciclo
      ,s.categoria
      ,s.subcategoria
      ,s.estado_tecnico
      ,s.estado_financiero
      ,s.estado_corte
      ,decode(s.edad,-1,-1,0,0,30,30,60,60,90,90,120,120,150,150,180,180,210,210,240,240,270,270,300,300,330,330,360,360,361) edad
      ,decode(s.edad_deuda,-1,-1,0,0,30,30,60,60,90,90,120,120,150,150,180,180,210,210,240,240,270,270,300,300,330,330,360,360,361) edad_deuda
      ,SUM(s.deuda_corriente_no_vencida) no_vencida
      ,SUM(s.deuda_corriente_vencida) vencida
      ,SUM(s.deuda_no_corriente) deuda_diferida
      ,SUM(sesusape+s.deuda_no_corriente) total_cartera
      ,COUNT(s.producto) cantidad_clientes
      ,s.nro_ctas_con_saldo
  FROM open.ldc_osf_sesucier s
 WHERE s.nuano = nupano
   AND s.numes = nupmes
   AND s.area_servicio = s.area_servicio
 GROUP BY s.nuano
      ,s.numes
      ,s.tipo_producto
      ,s.departamento
      ,s.localidad
      ,s.ciclo
      ,s.categoria
      ,s.subcategoria
      ,s.estado_tecnico
      ,s.estado_financiero
      ,s.estado_corte
      ,decode(s.edad,-1,-1,0,0,30,30,60,60,90,90,120,120,150,150,180,180,210,210,240,240,270,270,300,300,330,330,360,360,361)
      ,decode(s.edad_deuda,-1,-1,0,0,30,30,60,60,90,90,120,120,150,150,180,180,210,210,240,240,270,270,300,300,330,330,360,360,361)
      ,s.nro_ctas_con_saldo);
COMMIT;
SELECT COUNT(1) INTO nuconta
  FROM total_cart_mes x
 WHERE x.nuano = nupano
   AND x.numes = nupmes;
   sbmensa := 'Proceso terminó Ok. Se procesarón : '||to_char(nuconta)||' registros.';
   error := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_procresumensesucier error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  error := -1;
END;
/
