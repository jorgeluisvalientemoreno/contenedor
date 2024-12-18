CREATE OR REPLACE PROCEDURE      ldc_llena_recaudo_mes_sucu(nuano NUMBER,numes NUMBER,nerror OUT NUMBER,merror OUT VARCHAR2) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-29
  Descripcion : Generamos informacion de lo recaudado y cantidad de cupones por localidad y
                sucursal recaudadora
  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   26/02/2020   LJLB    CA 331 se optimiza consulta de pagos
***************************************************************************/
 CURSOR cu_recaudos_mes(dtcfein DATE,dtcfefi DATE) IS
 /* SELECT s.subabanc banco
        ,s.subacodi sucursal
        ,trunc(p.pagofegr) fecha_registro
        ,(SELECT de.geo_loca_father_id FROM open.ge_geogra_location de WHERE de.geograp_location_id = a.geograp_location_id) departamento
        ,a.geograp_location_id localidad
        ,COUNT(1) cantidad_cupones
        ,nvl(SUM(pagovapa),0) valor_recaudado
      FROM pagos p,sucubanc s,ab_address a
     WHERE trunc(p.pagofegr)BETWEEN dtcfein AND dtcfefi
       AND p.pagobanc = s.subabanc
       AND p.pagosuba = s.subacodi
       AND s.subaadid = a.address_id
  GROUP BY s.subabanc,s.subacodi,trunc(p.pagofegr),a.geograp_location_id*/

  WITH pagoreg AS
  (
    SELECT /*+ index(p ix_pagos11) */ p.pagobanc banco
          ,p.pagosuba sucursal
          ,trunc(p.pagofegr) fecha_registro
          ,nvl(pagovapa,0) valor_recaudado
    FROM OPEN.pagos p
    WHERE trunc(p.pagofegr) BETWEEN dtcfein AND dtcfefi
    AND p.pagocupo = p.pagocupo
  ), recabanco AS (
        SELECT
              banco,
              sucursal,
              fecha_registro,
              valor_recaudado,
              ( SELECT d.geograp_location_id
                FROM OPEN.ab_address d WHERE d.address_id = s.subaadid) localidad
          FROM pagoreg p, OPEN.sucubanc s
          WHERE s.subabanc = p.banco
          AND s.subacodi = p.sucursal )
    SELECT nuano,
    numes,
    nuano*100+numes periodo,
    (SELECT de.geo_loca_father_id FROM OPEN.ge_geogra_location de WHERE de.geograp_location_id = localidad) departamento,
      localidad,
      banco,
      sucursal,
      nvl(sum(nvl(valor_recaudado,0)),0) valor_recaudado,
      count(1) cantidad_cupones,
      fecha_registro,
      0 valor_asegurado,
      0 num_reg,
      0 porc_aseg
  FROM recabanco
  GROUP BY banco, sucursal, fecha_registro, localidad ;

  --INICIO 331
  TYPE tabpagos IS TABLE OF cu_recaudos_mes%ROWTYPE INDEX BY PLS_INTEGER;
   vtapagos tabpagos;

  --FIN CA 331

  dtfechaini  DATE;
dtfechafin  DATE;
sbmensa     VARCHAR2(1000);
nuok        NUMBER(2);
nucontareg NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
BEGIN
  nerror := 0;
  merror := NULL;
  nucantiregcom := 0;
  nucantiregtot := 0;
  nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 ldc_cier_prorecupaperiodocont(nuano,numes,dtfechaini,dtfechafin,sbmensa,nuok);
 DELETE ldc_osf_cier_reca l WHERE l.ano = nuano AND l.mes = numes;
 /*FOR i IN cu_recaudos_mes(dtfechaini,dtfechafin) LOOP
   INSERT INTO ldc_osf_cier_reca
                                (
                                 ano, mes, cod_depa ,cod_loca, banco,
                                 sucursal,valor_recaudado,periodo,cantidad_cupones,fecha_pago
                                 ,valor_asegurado,num_reg)
                           VALUES
                                 (
                                  nuano, numes, i.departamento, i.localidad,
                                  i.banco, i.sucursal,i.valor_recaudado,nuano*100+numes,
                                  i.cantidad_cupones,i.fecha_registro,0,0
                                 );
   nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
 END LOOP;*/--TICKET 331 LJLB--se cambia proceso de insert de pagos
  OPEN cu_recaudos_mes(dtfechaini,dtfechafin);
  LOOP
    FETCH cu_recaudos_mes BULK COLLECT INTO vtapagos LIMIT nucontareg;
    FORALL indx IN 1 .. vtapagos.count
      INSERT INTO ldc_osf_cier_reca VALUES vtapagos(indx);
      COMMIT;
      nucantiregtot := nucantiregtot + nucontareg;
    EXIT WHEN cu_recaudos_mes%notfound;
  END LOOP;
  CLOSE cu_recaudos_mes;
 COMMIT;
 --nucantiregtot := nucantiregtot + nucantiregcom;
 nerror := 0;
 merror := 'Proceso termino Ok : se procesaron '||nucantiregtot||' registros.';
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  nerror:=-1;
  merror:='Error en ldc_llena_recaudo_mes_sucu: '||sqlerrm;
END;
/
