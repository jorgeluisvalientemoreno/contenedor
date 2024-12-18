CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PRO_ESTA_REFINANCIADO" (
                                                      inunuse open.pr_product.product_id%TYPE
                                                     ,nuparano NUMBER
                                                     ,nuparmes NUMBER
                                                     ) RETURN NUMBER IS
/**************************************************************************
  Autor       : Francisco Castro
  Fecha       : 2015-05-14
  Descripcion : Funcion que determina si un producto esta o no refinanciado a una fecha especificada

  Parametros Entrada
    inunuse Producto
    idtfecha Fecha en la que se desea saber si estaba refinanciado o no

  Valor de salida
    sbesta  1 - Esta refinanciado
            2 - No esta refinanciado
            -1  Error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION


***************************************************************************/

sbsalir VARCHAR2(1);
sbesta NUMBER;
CURSOR cudiferido IS
 SELECT difecodi, difenuse, difeprog, difesape, difefein, difefumo, difenucu, difecupa
   FROM open.diferido
  WHERE difenuse = inunuse
    AND difeprog = 'GCNED';
   -- and difecodi = 4965301;
rg cudiferido%ROWTYPE;
idtfecha DATE;
BEGIN
  sbsalir := 'N';
  sbesta := 2;
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
  open cudiferido;
  while sbsalir = 'N' loop
    fetch cudiferido into rg;
    if rg.difecodi is null or cudiferido%notfound then
       sbsalir := 'S';
       sbesta := 2;
    elsif rg.difesape > 0 and rg.difefein < idtfecha then
       sbsalir := 'S';
       sbesta := 1;
    elsif rg.difesape = 0 and rg.difefein < idtfecha and rg.difefumo > idtfecha then
       sbsalir := 'S';
       sbesta := 1;
    end if;
  end loop;
  close cudiferido;
  return (sbesta);
exception when others then
  return -1;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRO_ESTA_REFINANCIADO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_PRO_ESTA_REFINANCIADO TO REXEREPORTES;
/
