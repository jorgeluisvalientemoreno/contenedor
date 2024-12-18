CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNURETDEPALOCACLIENTE" (inusubscriber_id OPEN.GE_SUBSCRIBER.subscriber_id%TYPE,ivaRet VARCHAR2)
/*****************************************************************
Propiedad intelectual de GDO.

Unidad         : LDC_fnuRetDepaLocaCliente
Descripción    : retorna el departamento o locadidad de GE_SUBSCRIBER a partir de la direccion.
Autor          : Arquitecsoft/Millerlandy Moreno T.
Fecha          : 04-09-2013

Parametros             Descripcion
============        ===================
inusubscriber_id    Codigo del cliente sobre el que se va a consultar el departamento o localidad
ivaRet              Indica que dato se desea consultar: D - Departamento
                                                        L - Localidad

Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
******************************************************************/
RETURN NUMBER  IS
  --<<
  -- Variables del proceso
  -->>
  nuRetorno NUMBER;
  --<<
  -- Cursor que obtiene el departamento de un GE_SUBSCRIBER
  -->>
  CURSOR CuDepartamento IS
  SELECT Decode(address_id,NULL,-1,OPEN.dage_geogra_location.fnugetgeo_loca_father_id(OPEN.daab_address.fnugetgeograp_location_id(address_id)))
    FROM OPEN.ge_subscriber ge_subscriber
   WHERE subscriber_id = inusubscriber_id;
  --<<
  -- Cursor que obtiene la localidad de un GE_SUBSCRIBER
  -->>
  CURSOR CuLocalidad IS
  SELECT Decode(address_id,NULL,-1,OPEN.daab_address.fnugetgeograp_location_id(address_id))
    FROM OPEN.ge_subscriber ge_subscriber
   WHERE subscriber_id = inusubscriber_id;
BEGIN
  --<<
  -- Evalua si requiere obtener localidad o departamento
  -->>
  -- Departamento
  IF ivaRet = 'D' THEN
    --<<
    -- Obtiene el departamento
    -->>
     OPEN CuDepartamento;
    FETCH CuDepartamento INTO nuRetorno;
      IF CuDepartamento%NOTFOUND THEN
         nuRetorno := -1;
      END IF;
    CLOSE CuDepartamento;
  END IF;
  -- Localidad
  IF ivaRet = 'L' THEN
    --<<
    -- Obtiene el departamento
    -->>
     OPEN CuLocalidad;
    FETCH CuLocalidad INTO nuRetorno;
      IF CuLocalidad%NOTFOUND THEN
         nuRetorno := -1;
      END IF;
    CLOSE CuLocalidad;
  END IF;

  RETURN nuRetorno;
END LDC_fnuRetDepaLocaCliente;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNURETDEPALOCACLIENTE', 'ADM_PERSON');
END;
/