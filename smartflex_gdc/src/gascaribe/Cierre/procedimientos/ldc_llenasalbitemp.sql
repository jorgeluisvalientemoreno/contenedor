CREATE OR REPLACE PROCEDURE ldc_llenasalbitemp(
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-22
  Descripcion : Generamos información de los inventario de items en bodega

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
                                              nupano IN NUMBER,
                                              nupmes IN NUMBER,
                                              sbmensa OUT VARCHAR2,
                                              error  OUT NUMBER
                                             ) IS
CURSOR cu_or_ope_uni_item_bala IS
 SELECT items_id
       ,operating_unit_id
       ,quota
       ,balance
       ,total_costs
       ,occacional_quota
       ,transit_in
       ,transit_out
  FROM or_ope_uni_item_bala;
nucontareg NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
BEGIN
sbmensa := NULL;
error := 0;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 DELETE ldc_osf_salbitemp l WHERE l.nuano = nupano AND l.numes = nupmes;
 COMMIT;
  FOR i IN cu_or_ope_uni_item_bala LOOP
   INSERT INTO ldc_osf_salbitemp(
                                  nuano
                                 ,numes
                                 ,items_id
                                 ,operating_unit_id
                                 ,quota
                                 ,balance
                                 ,total_costs
                                 ,occacional_quota
                                 ,transit_in
                                 ,transit_out
                                )
                          VALUES(
                                  nupano
                                 ,nupmes
                                 ,i.items_id
                                 ,i.operating_unit_id
                                 ,i.quota
                                 ,i.balance
                                 ,i.total_costs
                                 ,i.occacional_quota
                                 ,i.transit_in
                                 ,i.transit_out
                                 );
       nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
  END LOOP;
  COMMIT;
  nucantiregtot := nucantiregtot + nucantiregcom;
  sbmensa := 'Proceso terminó Ok : se procesarón '||nucantiregtot||' registros.';
  error := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenasalbitemp  : '||' MENSAJE : '||SQLERRM;
  error := -1;
END;
/
