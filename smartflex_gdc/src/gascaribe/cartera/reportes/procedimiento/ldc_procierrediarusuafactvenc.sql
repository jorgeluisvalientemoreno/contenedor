
CREATE OR REPLACE PROCEDURE OPEN.ldc_procierrediarusuafactvenc IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-12-11
  Descripcion : Cartera diaria, usuarios con mas de 4 cuentas con saldo

  Parametros Entrada
  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 CURSOR cufactvenci IS
  SELECT ic.caccfege dia
      ,ic.caccubg2 departamento
      ,ic.caccubg3 localidad
      ,ic.cacccicl ciclo
      ,ic.caccserv tipo_producto
      ,ic.cacccate categoria
      ,ic.caccsuca subcategoria
      ,ic.caccnuse producto
      ,count(distinct(ic.cacccuco)) cantidad
      ,round(nvl(sum(ic.caccsape),0),0) saldo_vencido
      ,(SELECT round(nvl(sum(ic2.caccsape),0),0)
          FROM open.ic_cartcoco ic2
         WHERE ic2.caccnaca = 'F'
           AND ic2.caccnuse = ic.caccnuse
           AND ic2.caccfege = ic.caccfege) saldo_diferido
  FROM open.ic_cartcoco ic
 WHERE ic.caccnaca = 'N'
   AND ic.caccfege = TRUNC(SYSDATE)-1
 GROUP BY ic.caccfege
         ,ic.caccubg2
         ,ic.caccubg3
         ,ic.cacccicl
         ,ic.caccserv
         ,ic.cacccate
         ,ic.caccsuca
         ,ic.caccnuse
 HAVING count(distinct(ic.cacccuco)) >= dald_parameter.fnuGetNumeric_Value('NRO_CTAS_REP_CART_DIA');
 sbmensa VARCHAR2(1000);
 dtfeve  DATE;
 nuedad  ldc_osf_sesucier.edad%TYPE;
BEGIN
 DELETE open.ldc_cartdiaria cd WHERE cd.dia = TRUNC(SYSDATE)-1;
 COMMIT;
 FOR i IN cufactvenci LOOP
  dtfeve := ldc_calculaedadmoraprod(i.producto);
  IF dtfeve = to_date('01/01/1800','dd/mm/yyyy') THEN
   nuedad := -2;
  ELSIF dtfeve = to_date('01/01/1900','dd/mm/yyyy') THEN
   nuedad := -1;
  ELSE
   nuedad := ldc_edad_mes(TO_NUMBER(TRUNC(SYSDATE-1)-TRUNC(dtfeve)));
  END IF;
  INSERT INTO ldc_cartdiaria
      (
        dia
       ,tipo_producto
       ,departamento
       ,localidad
       ,ciclo
       ,categoria
       ,subcategoria
       ,producto
       ,sesusape
       ,deuda_diferida_no_corriente
       ,nro_ctas_con_saldo
       ,edad_mora
       )
    VALUES
      (
       i.dia
      ,i.tipo_producto
      ,i.departamento
      ,i.localidad
      ,i.ciclo
      ,i.categoria
      ,i.subcategoria
      ,i.producto
      ,i.saldo_vencido
      ,i.saldo_diferido
      ,i.cantidad
      ,nuedad
      );
  COMMIT;
 END LOOP;
 EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_procierrediarusuafactvenc '||' '||sqlerrm;
END;
/

