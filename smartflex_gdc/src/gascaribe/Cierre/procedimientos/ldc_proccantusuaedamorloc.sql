CREATE OR REPLACE PROCEDURE ldc_proccantusuaedamorloc(nupano NUMBER,nupmes NUMBER,sbmensa OUT VARCHAR2,nuerror OUT NUMBER) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-02-02
  Descripcion : Generamos información de Usuarios a mas 90 dias

  Parametros Entrada
    nuano A�o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
 ***************************************************************************/
 error   NUMBER(3);
 nuconta NUMBER(10) DEFAULT 0;
BEGIN
 error   := -1;
 sbmensa := NULL;
 nuerror := 0;
 -- Obtenemos periodo anterior al cierre actual
 error   := -2;
 IF nupmes = 1 THEN
   -- Insertamos registros de todo el año en curso
  FOR i IN 1..12 LOOP
   FOR j IN(SELECT f.geo_loca_father_id departamento
                  ,f.geograp_location_id localidad
              FROM open.ge_geogra_location f
             WHERE f.geog_loca_area_type = 3) LOOP
    INSERT INTO open.ldc_usuarios_loca_edad_mora VALUES(nupano,i,j.departamento,j.localidad,0,0,0,0);
   END LOOP;
  END LOOP;
  COMMIT;
 END IF;
  -- Borramos datos tabla mes cierre
 error := -3;
 DELETE open.ldc_usuarios_loca_edad_mora g WHERE g.nuano = nupano AND g.numes = nupmes;
 COMMIT;
  -- Registramos inforamcion usuario a mas de 90
 error := -4;
 INSERT INTO open.ldc_usuarios_loca_edad_mora(
                                              SELECT s.nuano
                                                    ,s.numes
                                                    ,s.departamento
                                                    ,s.localidad
                                                    ,NVL(SUM(s.sesusape),0)
                                                    ,NVL(SUM(s.sesusape+s.deuda_no_corriente),0)
                                                    ,NVL(SUM(s.deuda_no_corriente),0)
                                                    ,COUNT(DISTINCT(s.contrato))
                                                FROM open.ldc_osf_sesucier s
                                               WHERE s.edad         >= open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL)
                                                 AND s.nuano        = nupano
                                                 AND s.numes        = nupmes
                                                 AND s.area_servicio = s.area_servicio
                                               GROUP BY s.nuano,s.numes,s.departamento
                                                     ,s.localidad);
     COMMIT;
  error := -5;
 -- Contamos registros procesados
 nuconta := 0;
 SELECT COUNT(1) INTO nuconta
   FROM open.ldc_usuarios_loca_edad_mora x
  WHERE x.nuano = nupano
    AND x.numes = nupmes;
 sbmensa := 'Proceso terminó OK. Se procesarón : '||to_char(nuconta)||' registros.';
 nuerror := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_proccantusuaedamorloc lineas error '||error||' '||sqlerrm;
  nuerror := -1;
END;
/
