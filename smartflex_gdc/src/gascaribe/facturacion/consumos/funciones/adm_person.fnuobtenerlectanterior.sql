CREATE OR REPLACE FUNCTION "ADM_PERSON"."FNUOBTENERLECTANTERIOR" ( nuProducto servsusc.sesunuse%TYPE) RETURN  NUMBER IS
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2015-09-04
    Descripcion : Funcion que obtiene lectura anterior del producto

    Parametros Entrada
      nuproducto  Producto

    Valor de salida
     lectura actual

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 nuLecturaAnterior           lectelme.leemlean%TYPE; -- se almacena la lectura anterior

 --Cursor que obtiene la lectura  anterior
 CURSOR culecturas IS
 SELECT lectura_anterior
  FROM(
       SELECT lm.leemlean lectura_anterior
         FROM OPEN.lectelme lm
        WHERE lm.leemsesu = nuProducto
        ORDER BY lm.leemfele DESC
        )
    WHERE ROWNUM <= 1;

BEGIN
  -- Recuperamos la lectura actual y anterior del producto
  OPEN culecturas;
  FETCH culecturas INTO nuLecturaAnterior;
  IF culecturas%NOTFOUND THEN
    nuLecturaAnterior := 0;
  END IF;
  CLOSE culecturas;

  RETURN nuLecturaAnterior;
EXCEPTION
  WHEN OTHERS THEN
     RETURN -1;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUOBTENERLECTANTERIOR', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.FNUOBTENERLECTANTERIOR TO REXEREPORTES;
/