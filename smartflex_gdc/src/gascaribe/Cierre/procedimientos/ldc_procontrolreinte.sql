CREATE OR REPLACE PROCEDURE ldc_procontrolreinte(nuano NUMBER,numes NUMBER,nerror OUT NUMBER,merror OUT VARCHAR2) IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_procontrolreinte

  Descripción  : control reintegro

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 20-06-2013

  Historia de Modificaciones
  **************************************************************/
 CURSOR cucontrolrein(nutipo NUMBER,dtcufefi DATE) IS
  SELECT *
    FROM(
        SELECT co.concvato valor_conciliacion
              ,(
                SELECT NVL(SUM(dt.tbdsvads),0)
                  FROM open.trbadosr dt
                      ,open.tranbanc tb
                 WHERE dt.tbdsdosr  = ds.dosrcodi
                   AND tb.trbafetr <= dtcufefi
                   AND dt.tbdstrba = tb.trbacodi
                ) valor_aplicado_consignacion
              ,ds.dosrcodi documento_soporte
              ,co.conccons conciliacion
              ,ba.bancnit nit_entidad
              ,lo.geo_loca_father_id departamento
              ,lo.geograp_location_id localidad
              ,ba.banccodi banco
          FROM open.concilia co
              ,open.docusore ds
              ,open.banco ba
              ,open.ge_contratista gc
              ,open.ge_subscriber cl
              ,open.ab_address di
              ,open.ge_geogra_location lo
         WHERE co.concflpr            = 'S'
           AND ba.banctier            = 2
           AND ds.dosrtdsr            = nutipo
           AND co.concfere           <= dtcufefi
           AND co.conccons            = ds.dosrconc
           AND co.concbanc            = ba.banccodi
           AND ba.banccont            = gc.id_contratista
           AND gc.subscriber_id       = cl.subscriber_id
           AND cl.address_id          = di.address_id
           AND di.geograp_location_id = lo.geograp_location_id
      )
   WHERE valor_conciliacion <> valor_aplicado_consignacion;

CURSOR coconsign(nro_doso NUMBER) is
 SELECT *
   FROM trbadosr t
  WHERE t.tbdsdosr = nro_doso;

nudore                     docusore.dosrtdsr%TYPE;
sw                         NUMBER(1) DEFAULT 0;
nucontareg                 NUMBER(15) DEFAULT 0;
nucantiregcom              NUMBER(15) DEFAULT 0;
nucantiregtot              NUMBER(15) DEFAULT 0;
dtvarfechfin               ldc_ciercome.cicofech%TYPE;
no_existe_periodo_contable EXCEPTION;
BEGIN
nerror        := 0;
merror        := NULL;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg    := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
nudore        := dald_parameter.fnuGetNumeric_Value('DOC_SOPORTE_RECAUDO',null);
DELETE ldc_osf_cier_part_conci l WHERE l.ano = nuano AND l.mes = numes;
 BEGIN
  SELECT lc.cicofech INTO dtvarfechfin
    FROM open.ldc_ciercome lc
   WHERE lc.cicoano = nuano
     AND lc.cicomes = numes;
 EXCEPTION
  WHEN no_data_found THEN
   RAISE no_existe_periodo_contable;
 END;
 dtvarfechfin := to_date(to_char(dtvarfechfin,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
 FOR i IN cucontrolrein(nudore,dtvarfechfin) LOOP
  sw := 0;
  FOR j IN coconsign(i.documento_soporte) LOOP
    INSERT INTO ldc_osf_cier_part_conci
                                      (
                                        ano
                                       ,mes
                                       ,departamento
                                       ,localidad
                                       ,nit_entidad
                                       ,conciliacion
                                       ,valor_conciliacion
                                       ,documento_soporte
                                       ,nro_consignacion
                                       ,valor_aplicado_doso_tranban
                                       ,fecha_aplicacion_doso_tranban
                                       ,cod_banco
                                       )
                                VALUES
                                      (
                                        nuano
                                       ,numes
                                       ,i.departamento
                                       ,i.localidad
                                       ,i.nit_entidad
                                       ,i.conciliacion
                                       ,i.valor_conciliacion
                                       ,i.documento_soporte
                                       ,j.tbdstrba
                                       ,j.tbdsvads
                                       ,j.tbdsfere
                                       ,i.banco
                                       );
   sw := 1;
  END LOOP;
   IF sw = 0 THEN
    INSERT INTO ldc_osf_cier_part_conci
                                      (
                                        ano
                                       ,mes
                                       ,departamento
                                       ,localidad
                                       ,nit_entidad
                                       ,conciliacion
                                       ,valor_conciliacion
                                       ,documento_soporte
                                       ,cod_banco
                                       )
                                VALUES
                                      (
                                        nuano
                                       ,numes
                                       ,i.departamento
                                       ,i.localidad
                                       ,i.nit_entidad
                                       ,i.conciliacion
                                       ,i.valor_conciliacion
                                       ,i.documento_soporte
                                       ,i.banco
                                       );
   END IF;
   nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
 END LOOP;
 COMMIT;
 nucantiregtot := nucantiregtot + nucantiregcom;
 nerror:=0;
 merror:='Proceso terminó Ok : se procesarón '||nucantiregtot||' registros.';
EXCEPTION
 WHEN no_existe_periodo_contable THEN
  ROLLBACK;
  nerror := -1;
  merror := 'Error en ldc_procontrolreinte: No existe el periodo contable : '||to_char(nuano)||' - '||to_char(numes);
 WHEN OTHERS THEN
  ROLLBACK;
  nerror:=-1;
  merror:='Error en ldc_procontrolreinte: '||sqlerrm;
END;
/
