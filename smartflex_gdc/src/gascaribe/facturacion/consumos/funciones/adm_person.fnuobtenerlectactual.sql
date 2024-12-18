CREATE OR REPLACE FUNCTION "ADM_PERSON"."FNUOBTENERLECTACTUAL" ( nuProducto servsusc.sesunuse%TYPE) RETURN  NUMBER IS
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2015-09-04
    Descripcion : Funcion que obtiene lectura actual del producto

    Parametros Entrada
      nuproducto  Producto

    Valor de salida
     lectura actual

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 nuLecturaActual             lectelme.leemleto%TYPE; -- se almacena la lectura actual

 --Cursor que obtiene la lectura actual
 CURSOR culecturas  IS
 SELECT lectura_actual
  FROM(
       SELECT lm.leemleto lectura_actual
            ,lm.leemlean lectura_anterior
         FROM OPEN.lectelme lm
        WHERE lm.leemsesu = nuProducto
        ORDER BY lm.leemfele DESC
        )
    WHERE ROWNUM <= 1;

BEGIN
  -- Recuperamos la lectura actual y anterior del producto
  OPEN culecturas;
  FETCH culecturas INTO nuLecturaActual;
  IF culecturas%NOTFOUND THEN
    nuLecturaActual := 0;
  END IF;
  CLOSE culecturas;

  RETURN nuLecturaActual;

EXCEPTION
  WHEN OTHERS THEN
     RETURN -1;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUOBTENERLECTACTUAL', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.FNUOBTENERLECTACTUAL TO REXEREPORTES;
/