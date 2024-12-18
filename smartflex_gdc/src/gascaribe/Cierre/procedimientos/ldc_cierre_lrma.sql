CREATE OR REPLACE PROCEDURE ldc_cierre_lrma(nuano NUMBER, numes NUMBER,nerror OUT NUMBER,merror OUT VARCHAR2) IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_cierre_lrma

  Descripción  : Muestra los recaudos mas alto el cual es parametrizable en la base de datos. Ej: Que muestre los 4 recaudos mas alto de X Contratista

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 19-06-2013

  Historia de Modificaciones
  **************************************************************/
 CURSOR cusucur(nucano NUMBER,nucmes NUMBER) IS
  SELECT DISTINCT t.cod_depa,t.cod_loca,t.banco,t.sucursal
    FROM open.ldc_osf_cier_reca t
   WHERE t.ano = nucano
     AND t.mes = nucmes;

 CURSOR curecamasalto(nuccano NUMBER,nuccmes NUMBER,nuccdepa NUMBER,nuccloca NUMBER,nubanc NUMBER,nusucu NUMBER,nucregi NUMBER) IS
  SELECT fecha_pago,valor_recaudado
  FROM(
        SELECT fecha_pago,valor_recaudado
          FROM open.ldc_osf_cier_reca t
         WHERE t.ano = nuccano
           AND t.mes = nuccmes
           AND t.cod_depa = nuccdepa
           AND t.cod_loca = nuccloca
           AND t.banco = nubanc
           AND t.sucursal = nusucu
      ORDER BY valor_recaudado DESC)
 WHERE ROWNUM <= nucregi;
-- dtfechaini DATE;
-- dtfechafin DATE;
-- sbmensa    VARCHAR2(1000);
-- nuok       NUMBER(2);
 nuregi     NUMBER(3);
 nuporc     NUMBER(3);
 nuconta    NUMBER DEFAULT 0;
nucontareg NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
BEGIN
nerror := 0;
merror := NULL;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
nuregi := dald_parameter.fnuGetNumeric_Value('COD_NUM_REG_RECA',null);
nuporc := dald_parameter.fnuGetNumeric_Value('COD_PORC_ASEG',null);
 FOR i IN cusucur(nuano,numes) LOOP
   nuconta := 0;
  FOR j IN curecamasalto(nuano,numes,i.cod_depa,i.cod_loca,i.banco,i.sucursal,nuregi) LOOP
   nuconta := nuconta + 1;
    UPDATE open.ldc_osf_cier_reca k
       SET  valor_asegurado = j.valor_recaudado*(nuporc/100)
           ,num_reg = nuconta
           ,k.porc_aseg = (nuporc/100)
     WHERE k.ano = nuano
       AND k.mes = numes
       AND k.cod_depa = i.cod_depa
       AND k.cod_loca = i.cod_loca
       AND k.banco = i.banco
       AND k.sucursal = i.sucursal
       AND k.fecha_pago = j.fecha_pago;
   nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
  END LOOP;
 END LOOP;
 COMMIT;
 nucantiregtot := nucantiregtot + nucantiregcom;
 nerror := 0;
merror := 'Proceso terminó Ok : se procesarón '||nucantiregtot||' registros.';
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  nerror:=-1;
  merror:='Error en ldc_cierre_lrma: '||sqlerrm;
END;
/
