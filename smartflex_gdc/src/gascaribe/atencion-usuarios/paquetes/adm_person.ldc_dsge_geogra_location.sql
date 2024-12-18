CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSGE_GEOGRA_LOCATION
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_geogra_location
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetDisplayDescription
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;

	FUNCTION fsbGetDescription
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;

	FUNCTION fnuGetFather_id
    (
		inuGeograp_location_id	in	number
    )
	return number;

	FUNCTION fsbGetFather_DisplayDesc
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;

	FUNCTION fsbGetFather_Description
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;

END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSGE_GEOGRA_LOCATION
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_geogra_location
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuGeograp_location (inuGeograp_location_id in ge_geogra_location.geograp_location_id%type) IS
	SELECT /*+ INDEX (ge_geogra_location, pk_ge_geogra_location) */
			*
	FROM   ge_geogra_location
	WHERE  geograp_location_id = inuGeograp_location_id;

	CURSOR cuFatherGeograp_location (inuGeograp_location_id in ge_geogra_location.geograp_location_id%type) IS
	SELECT father.*
	FROM   ge_geogra_location child, ge_geogra_location father
	WHERE  father.geograp_location_id = child.geo_loca_father_id
	AND    child.geograp_location_id = inuGeograp_location_id;

    -- Variables
	subtype styGeograp_location is cuGeograp_location%rowtype;
	type tytbGeograp_location is table of styGeograp_location index by binary_integer;

	tbGeograp_location			tytbGeograp_location;
	tbFatherGeograp_location	tytbGeograp_location;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadGeograp_location
    (
		inuGeograp_location_id		in	number
    )
    IS
		rctbGeograp_location	styGeograp_location;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuGeograp_location(inuGeograp_location_id);

		--	Recupera registros
		FETCH cuGeograp_location INTO rctbGeograp_location;

		--	Cierra cursor
		CLOSE cuGeograp_location;

		tbGeograp_location(inuGeograp_location_id) := rctbGeograp_location;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadGeograp_location;

	FUNCTION fsbGetDisplayDescription
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuGeograp_location_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbGeograp_location.exists(inuGeograp_location_id)) THEN
		--{
			loadGeograp_location(inuGeograp_location_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuGeograp_location_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbGeograp_location(inuGeograp_location_id).display_description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDisplayDescription;

    PROCEDURE loadFatherGeograp_location
    (
		inuGeograp_location_id		in	number
    )
    IS
		rctbGeograp_location	styGeograp_location;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuFatherGeograp_location(inuGeograp_location_id);

		--	Recupera registros
		FETCH cuFatherGeograp_location INTO rctbGeograp_location;

		--	Cierra cursor
		CLOSE cuFatherGeograp_location;

		tbFatherGeograp_location(inuGeograp_location_id) := rctbGeograp_location;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadFatherGeograp_location;

	FUNCTION fnuGetFather_id
    (
		inuGeograp_location_id	in	number
    )
	return number
    IS
		-- Variables
		nuGeo_loca_father_id	number(15) := 0;

    BEGIN
	--{
		IF (inuGeograp_location_id IS NULL) THEN
		--{
			return nuGeo_loca_father_id;
		--}
		END IF;

		IF (NOT tbFatherGeograp_location.exists(inuGeograp_location_id)) THEN
		--{
			loadFatherGeograp_location(inuGeograp_location_id);
		--}
		END IF;

		nuGeo_loca_father_id := tbFatherGeograp_location(inuGeograp_location_id).geograp_location_id;

		return nuGeo_loca_father_id;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fnuGetFather_id;

	FUNCTION fsbGetFather_DisplayDesc
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuGeograp_location_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbFatherGeograp_location.exists(inuGeograp_location_id)) THEN
		--{
			loadFatherGeograp_location(inuGeograp_location_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuGeograp_location_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbFatherGeograp_location(inuGeograp_location_id).display_description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetFather_DisplayDesc;

	FUNCTION fsbGetFather_Description
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuGeograp_location_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbFatherGeograp_location.exists(inuGeograp_location_id)) THEN
		--{
			loadFatherGeograp_location(inuGeograp_location_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuGeograp_location_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbFatherGeograp_location(inuGeograp_location_id).description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetFather_Description;

	FUNCTION fsbGetDescription
    (
		inuGeograp_location_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuGeograp_location_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbGeograp_location.exists(inuGeograp_location_id)) THEN
		--{
			loadGeograp_location(inuGeograp_location_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuGeograp_location_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbGeograp_location(inuGeograp_location_id).description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSGE_GEOGRA_LOCATION', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSGE_GEOGRA_LOCATION TO REXEREPORTES;
/