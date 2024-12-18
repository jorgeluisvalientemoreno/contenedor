CREATE OR REPLACE PACKAGE adm_person.ldc_dsps_package_type
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_reception_type
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
        26/06/2024  Adrianavg OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

    PROCEDURE loadPs_package_type
    (
		isbTag_name		in	varchar2
    );

	PROCEDURE loadPackage_type_id
    (
		inuPackage_type_id		in	number
    );

	FUNCTION fsbGetDescription
    (
		isbTag_name		in	varchar2,
		inuConcatId		in	number default 0
    )
	return varchar2;

	FUNCTION fsbGetDescription
    (
		inuPackage_type_id	in	number,
		inuConcatId			in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsPs_package_type
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_reception_type
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuPs_package_type (isbTag_name in ps_package_type.tag_name%type) IS
	SELECT /* + INDEX (PS_PACKAGE_TYPE, UK_PS_PACKAGE_TYPE_01) */
			*
	FROM   PS_PACKAGE_TYPE
	WHERE  tag_name = isbTag_name;

	subtype styPs_package_type is cuPs_package_type%rowtype;
	type tytbPs_package_type is table of styPs_package_type index by varchar2(100);
	tbPs_package_type tytbPs_package_type;

	CURSOR cuPackage_type_id (inuPackage_type_id in ps_package_type.package_type_id%type) IS
	SELECT /* + INDEX (PS_PACKAGE_TYPE, PK_PS_PACKAGE_TYPE) */
			*
	FROM   PS_PACKAGE_TYPE
	WHERE  package_type_id = inuPackage_type_id;

	subtype styPackage_type_id is cuPackage_type_id%rowtype;
	type tytbPackage_type_id is table of styPackage_type_id index by binary_integer;
	tbPackage_type_id tytbPackage_type_id;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadPs_package_type
    (
		isbTag_name		in	varchar2
    )
    IS
		rctbPs_package_type	styPs_package_type;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuPs_package_type(isbTag_name);

		--	Recupera registros
		FETCH cuPs_package_type INTO rctbPs_package_type;

		--	Cierra cursor
		CLOSE cuPs_package_type;

		tbPs_package_type(isbTag_name) := rctbPs_package_type;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadPs_package_type;

	FUNCTION fsbGetDescription
    (
		isbTag_name		in	varchar2,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (isbTag_name IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbPs_package_type.exists(isbTag_name)) THEN
		--{
			loadPs_package_type(isbTag_name);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := tbPs_package_type(isbTag_name).package_type_id || '-';
		--}
		END IF;

		sbDescription :=  sbDescription || tbPs_package_type(isbTag_name).description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

	PROCEDURE loadPackage_type_id
    (
		inuPackage_type_id		in	number
    )
    IS
		rctbPs_package_type	styPackage_type_id;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuPackage_type_id(inuPackage_type_id);

		--	Recupera registros
		FETCH cuPackage_type_id INTO rctbPs_package_type;

		--	Cierra cursor
		CLOSE cuPackage_type_id;

		tbPackage_type_id(inuPackage_type_id) := rctbPs_package_type;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadPackage_type_id;

	FUNCTION fsbGetDescription
    (
		inuPackage_type_id	in	number,
		inuConcatId			in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuPackage_type_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbPackage_type_id.exists(inuPackage_type_id)) THEN
		--{
			loadPackage_type_id(inuPackage_type_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := tbPackage_type_id(inuPackage_type_id).package_type_id || '-';
		--}
		END IF;

		sbDescription :=  sbDescription || tbPackage_type_id(inuPackage_type_id).description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;
END LDC_DSPS_PACKAGE_TYPE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_DSPS_PACKAGE_TYPE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSPS_PACKAGE_TYPE', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_DSPS_PACKAGE_TYPE
GRANT EXECUTE ON ADM_PERSON.LDC_DSPS_PACKAGE_TYPE TO REXEREPORTES;
/
