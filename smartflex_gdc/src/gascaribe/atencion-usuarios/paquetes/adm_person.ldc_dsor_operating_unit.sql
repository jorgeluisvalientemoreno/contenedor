CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSOR_OPERATING_UNIT
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity Or_operating_unit
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetName
    (
		inuOr_operating_unit	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;
	FUNCTION fnuGetUnit_type_id
    (
		inuOr_operating_unit	in	number
    )
	return number;

	FUNCTION fsbGetDescTipo_Unidad
    (
        inuOr_operating_unit	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;
--}
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSOR_OPERATING_UNIT
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity Or_operating_unit
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

    -- Cursores
	CURSOR cuor_operating_unit (inuOr_operating_unit in or_operating_unit.operating_unit_id%type) IS
	SELECT /*+ INDEX (or_operating_unit, pk_or_operating_unit) */
			*
	FROM   or_operating_unit
	WHERE  operating_unit_id = inuOr_operating_unit;

	subtype styor_operating_unit is cuor_operating_unit%rowtype;
	type tytbor_operating_unit is table of styor_operating_unit index by binary_integer;

	tbor_operating_unit tytbor_operating_unit;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadOR_operating_unit
    (
		inuOr_operating_unit		in	number
    )
    IS
		rctbor_operating_unit	styor_operating_unit;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuor_operating_unit(inuOr_operating_unit);

		--	Recupera registros
		FETCH cuor_operating_unit INTO rctbor_operating_unit;

		--	Cierra cursor
		CLOSE cuor_operating_unit;

		tbor_operating_unit(inuOr_operating_unit) := rctbor_operating_unit;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loador_operating_unit;

	FUNCTION fsbGetName
    (
		inuOr_operating_unit	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuOr_operating_unit IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbor_operating_unit.exists(inuOr_operating_unit)) THEN
		--{
			loadOR_operating_unit(inuOr_operating_unit);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuOr_operating_unit || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbor_operating_unit(inuOr_operating_unit).name;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetName;

	FUNCTION fnuGetUnit_type_id
    (
		inuOr_operating_unit	in	number
    )
	return number
    IS
		-- Variables
		nuUnit_type_id    or_operating_unit.unit_type_id%type;

    BEGIN
	--{
		IF (inuOr_operating_unit IS NULL) THEN
		--{
			return nuUnit_type_id;
		--}
		END IF;

		IF (NOT tbor_operating_unit.exists(inuOr_operating_unit)) THEN
		--{
            -- Obtiene OR_operating_unit
			loadOR_operating_unit(inuOr_operating_unit);
		--}
		END IF;

        -- Obtiene unit_type_id
        nuUnit_type_id := tbOr_operating_unit(inuOr_operating_unit).unit_type_id;

		return nuUnit_type_id;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fnuGetUnit_type_id;

	FUNCTION fsbGetDescTipo_Unidad
    (
        inuOr_operating_unit	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
        nuUnit_type_id      or_operating_unit.unit_type_id%type;
        sbDescTipo_Unidad   varchar2(2000);

    BEGIN
	--{
		IF (inuOr_operating_unit IS NULL) THEN
		--{
			return nuUnit_type_id;
		--}
		END IF;

		IF (NOT tbOr_operating_unit.exists(inuOr_operating_unit)) THEN
		--{
            -- Obtiene OR_operating_unit
			loadOR_operating_unit(inuOr_operating_unit);
		--}
		END IF;

		-- Obtiene el unit_type_id
		nuUnit_type_id := tbOr_operating_unit(inuOr_operating_unit).unit_type_id;

		-- Obtiene descripcion Tipo Unidad
        sbDescTipo_Unidad := LDC_dsGe_tipo_unidad.fsbGetDescription(nuUnit_type_id,
                                                                    inuConcatId);

		return sbDescTipo_Unidad;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescTipo_Unidad;
--}
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSOR_OPERATING_UNIT', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSOR_OPERATING_UNIT TO REXEREPORTES;
/