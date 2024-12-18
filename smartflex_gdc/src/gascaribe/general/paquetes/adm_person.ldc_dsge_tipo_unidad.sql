CREATE OR REPLACE PACKAGE adm_person.LDC_dsGe_tipo_unidad
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_tipo_unidad
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
        25/06/2024  PAcosta   OSF-2878: Cambio de esquema ADM_PERSON
    ************************************************************/

	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetDescription
    (
		inuId_Tipo_unidad     in	number,
		inuConcatId           in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsGe_tipo_unidad
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_tipo_unidad
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuge_tipo_unidad (inuId_Tipo_unidad in ge_tipo_unidad.Id_Tipo_unidad%type) IS
	SELECT /*+ INDEX (ge_tipo_unidad, pk_ge_tipo_unidad) */
			*
	FROM   ge_tipo_unidad
	WHERE  Id_Tipo_unidad = inuId_Tipo_unidad;

	subtype styge_tipo_unidad is cuge_tipo_unidad%rowtype;
	type tytbge_tipo_unidad is table of styge_tipo_unidad index by binary_integer;

	tbge_tipo_unidad tytbge_tipo_unidad;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadge_tipo_unidad
    (
		inuId_Tipo_unidad		in	number
    )
    IS
		rctbge_tipo_unidad	styge_tipo_unidad;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuge_tipo_unidad(inuId_Tipo_unidad);

		--	Recupera registros
		FETCH cuge_tipo_unidad INTO rctbge_tipo_unidad;

		--	Cierra cursor
		CLOSE cuge_tipo_unidad;

		tbge_tipo_unidad(inuId_Tipo_unidad) := rctbge_tipo_unidad;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadge_tipo_unidad;

	FUNCTION fsbGetDescription
    (
		inuId_Tipo_unidad		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuId_Tipo_unidad IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbge_tipo_unidad.exists(inuId_Tipo_unidad)) THEN
		--{
            -- Obtiene tipo de unidad
			loadGE_tipo_unidad(inuId_Tipo_unidad);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuId_Tipo_unidad || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbge_tipo_unidad(inuId_Tipo_unidad).descripcion;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

END LDC_DSGE_TIPO_UNIDAD;
/
PROMPT Otorgando permisos de ejecucion a LDC_DSGE_TIPO_UNIDAD
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_DSGE_TIPO_UNIDAD', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_DSGE_TIPO_UNIDAD para reportes
GRANT EXECUTE ON adm_person.LDC_DSGE_TIPO_UNIDAD TO rexereportes;
/