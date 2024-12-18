CREATE OR REPLACE PROCEDURE ldc_proccartconccierre_db(nupano NUMBER,nupmes NUMBER,sbmensa OUT VARCHAR2,nuerror OUT NUMBER) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-01-21
  Descripcion : Generamos informacion de la cartera resumida por concepto,edad y tipo de producto

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR         DESCRIPCION
06/12/2017    josh Brito     Se agrupa la Subcategoria del producto  CASO 200-1562 y se inserta en el campo
                             Subcategoria de la tabla ldc_osf_cartconci
26/10/2020    HORBATH        CASO 469. SE OPTIMIZA PROCESO
***************************************************************************/
  CURSOR cudatoscartconc(nucano NUMBER,nucmes NUMBER,dtcicofech DATE) IS
   SELECT caccconc concepto
       ,(SELECT co.concdesc FROM open.concepto co WHERE co.conccodi = caccconc) descripcion_concepto
       ,SUM(decode(c.caccnaca,'N',c.caccsape,0)) valor_causado
       ,SUM(decode(c.caccnaca,'F',c.caccsape,0)) valor_diferido
       ,SUM(decode(c.caccnaca,'N',0,decode(caccplca,'C',c.caccsape,0))) diferido_corr
       ,SUM(decode(c.caccnaca,'N',0,decode(caccplca,'C',0,c.caccsape))) diferido_no_corr
       ,tipo_producto
       ,s.edad nuedad
       ,s.departamento departamento
       ,s.localidad localidad
       ,s.categoria categoria
       ,s.subcategoria  subcategoria
       ,s.estado_corte estado_corte
       ,nvl(COUNT(distinct(producto)),0) productos
  FROM ic_cartcoco_tmpicc c,open.ldc_osf_sesucier_tmpicc s
 WHERE c.caccnuse = s.producto
 GROUP BY caccconc
         ,tipo_producto
         ,s.edad
         ,estado_corte
         ,departamento
         ,localidad
         ,categoria
         ,subcategoria;

sbareaserv          ldci_centrobenef.cebesegm%TYPE;
sbcebe              ldci_centrobenef.cebecodi%TYPE;
nucontareg          NUMBER(15) DEFAULT 0;
nucantiregcom       NUMBER(15) DEFAULT 0;
nucantiregtot       NUMBER(15) DEFAULT 0;
dtccicofein         ldc_ciercome.cicofein%TYPE;
dtccicofech         ldc_ciercome.cicofech%TYPE;
err_fecha_per_conta EXCEPTION;
error               NUMBER(3);
X NUMBER;

CURSOR CUICCARTCOCO (IFECH DATE) IS
       SELECT CACCCONS,CACCNACA,CACCNUSE,CACCCONC,CACCSAPE,CACCFEGE,CACCPLCA FROM IC_CARTCOCO WHERE CACCFEGE=IFECH;
TYPE TIPOIC IS TABLE OF CUICCARTCOCO%ROWTYPE;

TBLIC TIPOIC := TIPOIC();
CURSOR CULDC_OSF_SESUCIER IS
       SELECT TIPO_PRODUCTO,NUANO,NUMES,PRODUCTO,DEPARTAMENTO,LOCALIDAD,ESTADO_TECNICO,ESTADO_CORTE,
              CATEGORIA,SUBCATEGORIA,EDAD FROM LDC_OSF_SESUCIER WHERE NUANO=NUPANO AND NUMES=NUPMES;

TYPE TIPOLD IS TABLE OF CULDC_OSF_SESUCIER%rowTYPE;

TBLLD TIPOLD := TIPOLD();

cnuLimite       CONSTANT number := 100;
NUINDEX NUMBER;
BEGIN

 error := -1;
 sbmensa := NULL;
 nuerror := 0;

 DELETE ldc_osf_cartconci l WHERE l.nuano = nupano AND l.numes = nupmes;

 COMMIT;
 error := -2;
 nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 nucantiregcom := 0;
 nucantiregtot := 0;
 -- Obtenemos la fecha de cierre
 ldc_cier_prorecupaperiodocont(nupano,nupmes,dtccicofein,dtccicofech,nuerror,sbmensa);
  error := -3;
 -- Recoremos los concepto
  error := -4;
  EXECUTE IMMEDIATE 'truncate table ldc_osf_sesucier_tmpicc';
  EXECUTE IMMEDIATE 'truncate table ic_cartcoco_tmpicc';
   OPEN CUICCARTCOCO(TRUNC(dtccicofech));
   LOOP
       FETCH CUICCARTCOCO
       BULK COLLECT INTO TBLIC
       LIMIT CNULIMITE;

       EXIT WHEN (CUICCARTCOCO%NOTFOUND IS NULL) OR (tblIC.first IS null);
       NUINDEX :=TBLIC.FIRST;
       IF TBLIC.COUNT > 0 THEN
          FORALL INDICE IN TBLIC.FIRST..TBLIC.LAST
                INSERT /*+ APPEND*/ INTO ic_cartcoco_tmpicc VALUES tbLIC(indice);
       END IF;
       TBLIC.DELETE;
   END LOOP;
   CLOSE CUICCARTCOCO;
   OPEN CULDC_OSF_SESUCIER;
   LOOP
       FETCH CULDC_OSF_SESUCIER
       BULK COLLECT INTO TBLLD
       LIMIT CNULIMITE;
       EXIT WHEN (CULDC_OSF_SESUCIER%NOTFOUND IS NULL) OR (tblLD.first IS null);
       NUINDEX:= TBLLD.FIRST;
       IF TBLLD.COUNT > 0 THEN
          FORALL INDICE IN TBLLD.FIRST..TBLLD.LAST
              INSERT /*+ APPEND*/ INTO LDC_OSF_SESUCIER_tmpicc VALUES tbLLD(indice);
       END IF;
       TBLLD.DELETE;
   END LOOP;
   CLOSE CULDC_OSF_SESUCIER;
   X:=0;
   FOR i IN cudatoscartconc(nupano,nupmes,trunc(dtccicofech)) LOOP
    IF X=0 THEN
       X:=1;
    END IF;
    IF i.nuedad IS NULL THEN
       i.nuedad := -20;
    END IF;
     -- Obtenemos el centro de beneficio de la localidad y la categoria
      error := -5;
    BEGIN
     sbcebe := open.ldci_pkinterfazsap.fvaGetCebeNew(i.localidad,i.categoria);
    EXCEPTION
     WHEN OTHERS THEN
      sbcebe := '-1';
    END;
    -- Obtenemos el area de servicio
     error := -6;
    BEGIN
     SELECT cb.cebesegm INTO sbareaserv
       FROM ldci_centrobenef cb
      WHERE cb.cebecodi = sbcebe;
    EXCEPTION
     WHEN OTHERS THEN
      sbareaserv := '-1';
    END;
    -- Guardamos el registro
     error := -7;
    INSERT INTO ldc_osf_cartconci
                                (
                                 nuano
                                ,numes
                                ,concepto
                                ,descripcion_concepto
                                ,tipo_producto
                                ,nuedad
                                ,valor_causado
                                ,valor_diferido
                                ,diferido_corriente
                                ,diferido_no_corriente
                                ,area_servicio
                                ,centro_beneficio
                                ,estado_corte
                                ,departamento
                                ,localidad
                                ,cant_contratos
                                ,categoria
                                ,subcategoria
                               )
                         VALUES
                               (
                                nupano
                               ,nupmes
                               ,i.concepto
                               ,i.descripcion_concepto
                               ,i.tipo_producto
                               ,i.nuedad
                               ,NVL(i.valor_causado,0)
                               ,NVL(i.valor_diferido,0)
                               ,NVL(i.diferido_corr,0)
                               ,NVL(i.diferido_no_corr,0)
                               ,NVL(sbareaserv,'-1')
                               ,NVL(sbcebe,'-1')
                               ,NVL(i.estado_corte,-1)
                               ,NVL(i.departamento,-1)
                               ,NVL(i.localidad,-1)
                               ,NVL(i.productos,0)
                               ,i.categoria
                               ,i.subcategoria----CASO 200-1562
                               );
    error := -8;
       nucantiregcom := nucantiregcom + 1;
    IF nucantiregcom >= nucontareg THEN
       nucantiregtot := nucantiregtot + nucantiregcom;
       nucantiregcom := 0;
    END IF;
   END LOOP;
  error := -9;
  nucantiregtot := nucantiregtot + nucantiregcom;
  COMMIT;
  sbmensa := 'Proceso termino Ok : se procesaron '||to_char(nucantiregtot)||' registros.';
  nuerror := 0;
  error := -10;
EXCEPTION
 WHEN err_fecha_per_conta THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_proccartconccierre_db lineas error '||error||' recuperando fecha periodo contable. '||sbmensa;
  nuerror := -1;
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_proccartconccierre_db lineas error '||error||' '||sqlerrm;
  nuerror := -1;
END;
/
