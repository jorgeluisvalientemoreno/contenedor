CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RETORNAAREASERVICIO" (nudepartamento NUMBER,nulocalidad NUMBER,nucategoria NUMBER) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-01-25
  Descripcion : Area de servicio por gasera

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 sbdatabase VARCHAR2(1000);
 sbcebe     ldci_centrobenef.cebecodi%TYPE;
 sbarserv   ldci_segmento.segmcodi%TYPE;
BEGIN
 SELECT sys_context('userenv','db_name') INTO sbdatabase FROM dual;
  -- Area de servicio para Gases de Occidente
 IF upper(TRIM(sbdatabase)) = upper(TRIM(dald_parameter.fsbGetValue_Chain('INSTANCIA_BASE_DATOS_GDO',NULL))) THEN
  -- Obtenemos el centro de beneficio
  BEGIN
   sbcebe := ldci_pkinterfazsap.fvaGetCebeNew(nulocalidad,nucategoria);
  EXCEPTION
   WHEN OTHERS THEN
    sbcebe := '-1';
  END;
  -- Obtenemos el segmento
   sbarserv := NULL;
   BEGIN
    SELECT cb.cebesegm INTO sbarserv
      FROM ldci_centrobenef cb
     WHERE cb.cebecodi = sbcebe;
   EXCEPTION
    WHEN OTHERS THEN
     sbarserv := '-1';
   END;
 -- Obtenemos valor area de servicio con el valor del segmento
  IF trim(sbarserv) =  'GDOC01200' THEN
    RETURN dald_parameter.fnuGetNumeric_Value('COD_ASE',NULL);
  ELSE
    RETURN dald_parameter.fnuGetNumeric_Value('COD_ASNE',NULL);
  END IF;
 -- Area dse servicio para EFIGAS
 ELSIF upper(trim(sbdatabase)) = upper(TRIM(dald_parameter.fsbGetValue_Chain('INSTANCIA_BASE_DATOS_EFIGAS',NULL))) THEN
  -- Obtenemos valor area de servicio con el valor del departamento
  IF nudepartamento = dald_parameter.fnuGetNumeric_Value('CODIGO_DPTO_CALDAS',NULL) THEN
    RETURN dald_parameter.fnuGetNumeric_Value('AREA_SERVICIO_DPTO_CALDAS',NULL);
  ELSIF nudepartamento = dald_parameter.fnuGetNumeric_Value('CODIGO_DPTO_QUINDIO',NULL) THEN
    RETURN dald_parameter.fnuGetNumeric_Value('AREA_SERVICIO_DPTO_QUINDIO',NULL);
  ELSE
    RETURN dald_parameter.fnuGetNumeric_Value('AREA_SERVICIO_DPTO_RISARALDA',NULL);
  END IF;
 ELSIF upper(trim(sbdatabase)) = upper(TRIM(dald_parameter.fsbGetValue_Chain('INSTANCIA_BASE_DATOS_SURTIGAS',NULL))) THEN
  RETURN dald_parameter.fnuGetNumeric_Value('AREA_SERVICIO_SURTIGAS',NULL);
 ELSIF upper(trim(sbdatabase)) = upper(TRIM(dald_parameter.fsbGetValue_Chain('INSTANCIA_BASE_DATOS_GDC',NULL))) THEN
  RETURN dald_parameter.fnuGetNumeric_Value('AREA_SERVICIO_GDC',NULL);
 ELSE
   RETURN 1555;
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  RETURN -1;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORNAAREASERVICIO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORNAAREASERVICIO TO REXEREPORTES;
/
