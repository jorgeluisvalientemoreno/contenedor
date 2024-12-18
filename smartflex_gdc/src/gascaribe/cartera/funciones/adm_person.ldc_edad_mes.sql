CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_EDAD_MES" (/*nunuse NUMBER,sbtipo VARCHAR2*/nuedaddias NUMBER) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-07-10
  Descripcion : Obtiene rango edad del del producto(M-edad mora ó D- edad deuda)

  Parametros Entrada
    nuedaddias nro dias mora
     NUSESUNUSE Codigo del servicio suscrito
     sbtipo M-si se quiere recuperar la edad de la mora ó
            D-si se quiere recuperar la edad de la deuda

  Valor de Retorno
    nuedaddias edad del producto en rango

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
-- nuedaddias NUMBER(5);
BEGIN
/* IF sbtipo = 'M' THEN
  nuedaddias := ldc_calculaedadmoraprod(nunuse);
 END IF;
 IF sbtipo = 'D' THEN
  nuedaddias := gc_bodebtmanagement.fnugetdebtagebyprod(nunuse);
 END IF;*/
 IF nuedaddias <= 0 THEN
 -- Retorna edad presente mes
    RETURN 0;
 ELSIF nuedaddias <= 30 THEN
 -- Retorna edad 30 días
  RETURN 30;
 ELSIF nuedaddias <= 60 THEN
  -- Retorna edad 60 días
  RETURN 60;
 ELSIF nuedaddias <= 90 THEN
  -- Retorna edad 90 días
  RETURN 90;
 ELSIF nuedaddias <= 120 THEN
  -- Retorna edad 120 días
  RETURN 120;
 ELSIF nuedaddias <= 150 THEN
  -- Retorna edad 150 días
  RETURN 150;
 ELSIF nuedaddias <= 180 THEN
  -- Retorna edad 180 días
  RETURN 180;
 ELSIF nuedaddias <= 210 THEN
   -- Retorna edad 210 días
  RETURN 210;
 ELSIF nuedaddias <= 240 THEN
  -- Retorna edad 240 días
  RETURN 240;
 ELSIF nuedaddias <= 270 THEN
   -- Retorna edad 270 días
  RETURN 270;
 ELSIF nuedaddias <= 300 THEN
  -- Retorna edad 300 días
  RETURN 300;
 ELSIF nuedaddias <= 330 THEN
  -- Retorna edad 330 días
  RETURN 330;
 ELSIF nuedaddias <= 360 THEN
  -- Retorna edad 360 días
  RETURN 360;
 ELSE
  -- Retorna mayor a 360 días
  RETURN 361;
 END IF;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_EDAD_MES', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_EDAD_MES TO REXEREPORTES;
/