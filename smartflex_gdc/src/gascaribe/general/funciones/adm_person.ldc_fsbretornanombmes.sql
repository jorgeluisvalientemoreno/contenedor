CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBRETORNANOMBMES" (numes NUMBER) RETURN VARCHAR2 IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-22
  Descripcion : Retorna nombre del mes

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 sbnombremes VARCHAR2(20);
BEGIN
  IF numes = 1 THEN
    sbnombremes := 'Enero';
 ELSIF   numes = 2 THEN
    sbnombremes := 'Febrero';
 ELSIF   numes = 3 THEN
    sbnombremes := 'Marzo';
 ELSIF   numes = 4 THEN
    sbnombremes := 'Abril';
 ELSIF   numes = 5 THEN
    sbnombremes := 'Mayo';
 ELSIF   numes = 6 THEN
    sbnombremes := 'Junio';
 ELSIF   numes = 7 THEN
    sbnombremes := 'Julio';
 ELSIF   numes = 8 THEN
    sbnombremes := 'Agosto';
 ELSIF   numes = 9 THEN
    sbnombremes := 'Septiembre';
 ELSIF   numes = 10 THEN
    sbnombremes := 'Octubre';
 ELSIF   numes = 11 THEN
    sbnombremes := 'Noviembre';
 ELSIF   numes = 12 THEN
    sbnombremes := 'Diciembre';
 ELSE
    sbnombremes := NULL;
 END IF;
 RETURN TRIM(sbnombremes);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBRETORNANOMBMES', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FSBRETORNANOMBMES TO REXEREPORTES;
/
