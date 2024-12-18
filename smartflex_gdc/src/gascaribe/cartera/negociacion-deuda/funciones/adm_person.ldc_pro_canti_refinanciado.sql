CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PRO_CANTI_REFINANCIADO" (
                                                      inunuse open.pr_product.product_id%TYPE
                                                     ,nuparano NUMBER
                                                     ,nuparmes NUMBER
                                                     ) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimón
  Fecha       : 2015-05-14
  Descripcion : Funcion que determina cantidad de refinanciaciones de un producto.

  Parametros Entrada
    inunuse Producto
    ano  año en la que se desea saber si estaba refinanciado o no
    mes  mes en el que se desea saber si estaba refinanciado o no

  Valor de salida
    sbesta  1 - Esta refinanciado
            2 - No esta refinanciado
            -1  Error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION


***************************************************************************/
CURSOR cudiferido IS
 SELECT  difecofi
        ,nvl(SUM(difesape),0) difesape
        ,difefein
   FROM open.diferido
  WHERE difenuse = inunuse
    AND difeprog = 'GCNED'
    AND difesape >= 1
 GROUP BY difecofi,difefein;

CURSOR cudiferido2 IS
   SELECT  difecofi,nvl(SUM(difesape),0) difesape,difefein,difefumo
     FROM open.diferido
    WHERE difenuse = inunuse
      AND difeprog = 'GCNED'
   GROUP BY difecofi,difefein,difefumo
 HAVING nvl(SUM(difesape),0) = 0;

idtfecha DATE;
nuconta NUMBER DEFAULT 0;
BEGIN
   nuconta := 0;
-- Obtenemos la fecha final de cierre
 BEGIN
  SELECT c.cicofech INTO idtfecha
    FROM open.ldc_ciercome c
   WHERE c.cicoano = nuparano
     AND c.cicomes = nuparmes;
 EXCEPTION
  WHEN no_data_found THEN
   RETURN -1;
 END;
 -- Refinanciaciones con saldo
  FOR i IN cudiferido LOOP
   IF i.difecofi IS NOT NULL AND i.difesape >= 0 AND i.difefein < idtfecha THEN
      nuconta := nuconta + 1;
    END IF;
  END LOOP;
 -- Refinanciaciones sin saldo
  FOR i IN cudiferido2 LOOP
   IF i.difecofi IS NOT NULL AND i.difesape = 0 AND i.difefein < idtfecha AND i.difefumo > idtfecha THEN
      nuconta := nuconta + 1;
    END IF;
  END LOOP;
  RETURN (nuconta);
EXCEPTION WHEN OTHERS THEN
  RETURN -1;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRO_CANTI_REFINANCIADO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_PRO_CANTI_REFINANCIADO TO REPORTES;
/
