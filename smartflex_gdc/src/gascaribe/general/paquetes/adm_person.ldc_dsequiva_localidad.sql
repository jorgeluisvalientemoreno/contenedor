CREATE OR REPLACE PACKAGE adm_person.LDC_DSEquiva_Localidad
IS
    /***********************************************************
    Propiedad intelectual de Gases del Caribe.

    Departamento    :   PETI
    Descripción     :   Cuerpo Data Services LDC_Equiva_Localidad
    Autor           :   rcalixto - Optima
    Fecha           :   lunes, Ago. 13, '2018 a las 08:56:42 AM GMT-05:00

    Métodos
    Nombre :
    Parámetros                Descripción
    ============	===================

    Historia de Modificaciones
    Fecha                Autor             Modificación
    =========           =========          ====================
    25/06/2024          PAcosta            OSF-2878: Cambio de esquema ADM_PERSON 
    ************************************************************/

	FUNCTION fsbGetCodDane
    (
		inuGeograp_location_id	in	number
    )
	return varchar2;
END LDC_DSEquiva_Localidad;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_DSEquiva_Localidad
IS
--{
    /***********************************************************
    Propiedad intelectual de Gases del Caribe.

    Departamento    :   PETI
    Descripción     :   Cuerpo Data Services LDC_Equiva_Localidad
    Autor           :   rcalixto - Optima
    Fecha           :   lunes, Ago. 13, '2018 a las 08:56:42 AM GMT-05:00

    Métodos
    Nombre :
    Parámetros                Descripción
    ============	===================

    Historia de Modificaciones
    Fecha                Autor             Modificación
    =========   ========= ====================
    ************************************************************/

	-- Constantes
    csbVersion   CONSTANT varchar2(10) := '1.0';

	-- Cursores
	CURSOR cuEquiva_localidad (inuGeograp_location_id in ldc_equiva_localidad.geograp_location_id%type) IS
	SELECT /*+ INDEX (ldc_equiva_localidad, pk_ldc_equiva_localidad) */
			*
	FROM   open.ldc_equiva_localidad
	WHERE  geograp_location_id = inuGeograp_location_id;

	-- Definicion de Subtipos y tipos
	subtype styEquiva_localidad is cuEquiva_localidad%rowtype;
	type tytbEquiva_localidad is table of styEquiva_localidad index by binary_integer;

	-- Definicion tablas
	tbEquiva_localidad tytbEquiva_localidad;

    FUNCTION fsbVersion  RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END;

    PROCEDURE loadRecord
    (
		inuGeograp_location_id		in	number
    )
    IS
		rctbEquiva_localidad	styEquiva_localidad;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuEquiva_localidad(inuGeograp_location_id);

		--	Recupera registros
		FETCH cuEquiva_localidad INTO rctbEquiva_localidad;

		--	Cierra cursor
		CLOSE cuEquiva_localidad;

		tbEquiva_localidad(inuGeograp_location_id) := rctbEquiva_localidad;

	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fsbGetCodDane
    (
		inuGeograp_location_id		in	number
    )
	return varchar2
    IS
		-- Variables
		sbCodDane	varchar2(2000) := '0';

    BEGIN
	--{
		IF (inuGeograp_location_id IS NULL) THEN
		--{
			return sbCodDane;
		--}
		END IF;

		IF (NOT tbEquiva_localidad.exists(inuGeograp_location_id)) THEN
		--{
			loadRecord(inuGeograp_location_id);
		--}
		END IF;

		sbCodDane:= tbEquiva_localidad(inuGeograp_location_id).DEPARTAMENTO ||
					tbEquiva_localidad(inuGeograp_location_id).MUNICIPIO    ||
					tbEquiva_localidad(inuGeograp_location_id).POBLACION;

		return sbCodDane;

	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END;
--}
END LDC_DSEquiva_Localidad;
/

PROMPT Otorgando permisos de ejecucion a LDC_DSEQUIVA_LOCALIDAD
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_DSEQUIVA_LOCALIDAD', 'ADM_PERSON');
END;
/