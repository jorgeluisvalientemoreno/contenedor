CREATE OR REPLACE PROCEDURE ldc_llenareportfracfrap(nuano NUMBER,numes NUMBER,nuerror OUT NUMBER,sberror OUT VARCHAR2) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-29
  Descripcion : Generamos información para el reporte FRAP y FRAC
  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 CURSOR cudatosval(nucano NUMBER,nucmes number) IS
  SELECT l.cod_depa departamento
        ,l.cod_loca localidad
        ,l.banco banco
        ,l.sucursal sucursal
        ,nvl(sum(l.valor_recaudado),0) valor_recaudado
        ,'R' as tipo
    FROM open.ldc_osf_cier_reca l
   WHERE l.ano = nucano
     AND l.mes = nucmes
GROUP BY cod_depa,cod_loca,banco,sucursal
UNION ALL
SELECT l.cod_depa departamento
        ,l.cod_loca localidad
        ,l.banco banco
        ,l.sucursal sucursal
        ,nvl(sum(l.cantidad_cupones),0) valor_recaudado
        ,'C' as tipo
    FROM open.ldc_osf_cier_reca l
   WHERE l.ano = nucano
     AND l.mes = nucmes
GROUP BY cod_depa,cod_loca,banco,sucursal;
 sbmes VARCHAR2(50);
 sbcadena VARCHAR2(6000);
BEGIN
nuerror := 0;
sberror := NULL;
 sbmes := ldc_fsbretornanombmes(numes);
 sbcadena := 'UPDATE ldc_osf_datosreccup SET '||UPPER(sbmes)||' = 0 WHERE ano = '||nuano;
 EXECUTE IMMEDIATE sbcadena;
 FOR i IN cudatosval(nuano,numes) LOOP
  BEGIN
    sbcadena := 'UPDATE ldc_osf_datosreccup SET '||UPPER(sbmes)||' = NVL('||UPPER(sbmes)||',0) + '||NVL(i.valor_recaudado,0)||' WHERE ano = '||nuano||' AND departamento = '||i.departamento||' AND localidad = '||i.localidad||' AND banco = '||i.banco||' AND sucursal = '''||i.sucursal||''' AND tipo = '''||i.tipo||'''';
    EXECUTE IMMEDIATE sbcadena;
   IF SQL%NOTFOUND THEN
     sbcadena := 'INSERT INTO ldc_osf_datosreccup(departamento,localidad,banco,sucursal,ano,tipo,'||trim(sbmes)||') VALUES('||i.departamento||','||i.localidad||','||i.banco||','''||i.sucursal||''','||nuano||','||''''||i.tipo||''''||','||NVL(i.valor_recaudado,0)||')';
   EXECUTE IMMEDIATE trim(sbcadena);
   END IF;
   COMMIT;
  END;
 END LOOP;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
   nuerror := -1;
   sberror := 'Error en ldc_llenareportfracfrap: insertando registro '||sbcadena||' '||sqlerrm;
END;
/
