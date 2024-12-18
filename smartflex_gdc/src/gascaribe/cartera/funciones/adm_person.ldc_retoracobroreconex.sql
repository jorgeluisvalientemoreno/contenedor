CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RETORACOBRORECONEX" (nupnuse NUMBER,dtpfecha DATE,dtpfechafin DATE) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-07-23
  Descripcion : Obtiene lo cobrado por reconexion de recuperacion de castigo

  Parametros Entrada
   nupproduct codigo de producto
   dtpfecha fecha de negociación

  Valor de Retorno
   lo cobrado por reconexión si aplica

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 CURSOR cucargosreconex(nucnuse NUMBER,dtcfecha DATE,dtcfechafin DATE) IS
  SELECT c.cargvalo valor,to_number(trim(substr(cargdoso,4))) paquete
    FROM cargos c
   WHERE c.cargconc IN(159,169)
     AND c.cargfecr BETWEEN dtcfecha AND dtcfechafin
     AND c.cargnuse = nucnuse
     AND c.cargdoso LIKE 'PP-%'
   ORDER BY cargfecr;
 nuconta NUMBER DEFAULT 0;
 nuvalor cargos.cargvalo%TYPE DEFAULT 0;
BEGIN
 FOR i IN cucargosreconex(nupnuse,dtpfecha,dtpfechafin) LOOP
  SELECT COUNT(1) INTO nuconta
    FROM mo_packages m
   WHERE m.package_id = i.paquete
     AND m.package_type_id = 300;
      IF nuconta > 0 THEN
         nuvalor := i.valor;
      END IF;
  EXIT;
 END LOOP;
 RETURN nuvalor;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORACOBRORECONEX', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORACOBRORECONEX TO REXEOPEN;
/
