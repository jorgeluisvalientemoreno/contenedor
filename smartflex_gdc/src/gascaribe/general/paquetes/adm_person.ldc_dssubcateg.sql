CREATE OR REPLACE PACKAGE adm_person.ldc_dssubcateg
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity Subcateg
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

	FUNCTION fsbGetSucadesc
    (
		inuSucacate in number,
		inuSucacodi in number,
		inuConcatId in number default 0
    )
	return varchar2;
--}
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsSubcateg
IS
    /***********************************************************
    	Name     :   Data Services for Entity Subcateg
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuSubcateg (inuSucacate in subcateg.sucacate%type,
                       inuSucacodi in subcateg.sucacodi%type) IS
	SELECT /*+ INDEX (subcateg, pk_subcateg) */
			*
	FROM   subcateg
	WHERE  sucacate = inuSucacate
	AND    sucacodi = inuSucacodi;

    -- Variables
	subtype stySubcateg is cuSubcateg%rowtype;
	type tytbSubcateg is table of stysubcateg index by binary_integer;

	tbSubcateg tytbSubcateg;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

	FUNCTION fnuGetHash
    (
		inuSucacate in number,
		inuSucacodi in number
    )
	return number;

    PROCEDURE loadSubcateg
    (
		inuSucacate in number,
		inuSucacodi in number
    )
    IS
		rctbSubcateg	stysubcateg;
		nuIndex			number;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuSubcateg(inuSucacate, inuSucacodi);

		--	Recupera registros
		FETCH cuSubcateg INTO rctbSubcateg;

		--	Cierra cursor
		CLOSE cuSubcateg;

		-- Obtiene hash
		nuIndex := fnuGetHash(inuSucacate, inuSucacodi);

		tbSubcateg(nuIndex) := rctbSubcateg;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadSubcateg;

	FUNCTION fsbGetSucadesc
    (
		inuSucacate in number,
		inuSucacodi in number,
		inuConcatId in number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';
		nuIndex			number;

    BEGIN
	--{
		IF (inuSucacodi IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		-- Calcula hash
		nuIndex := fnuGetHash(inuSucacate, inuSucacodi);

		-- Evalua si existe registro en la tabla
		IF (NOT tbsubcateg.exists(nuIndex)) THEN
		--{
			loadSubcateg(inuSucacate, inuSucacodi);
		--}
		END IF;

		-- Evalua si debe concatenar el codigo
		IF (inuConcatId = 1) THEN
		--{
			sbDescription := to_char(inuSucacate) || '-' || to_char(inuSucacodi) || '-' ;
		--}
		END IF;

		-- Concatena descripcion
		sbDescription := sbDescription || tbsubcateg(nuIndex).sucadesc;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetSucadesc;

	FUNCTION fnuGetHash
    (
		inuSucacate in number,
		inuSucacodi in number
    )
	return number
    IS
		-- Variables
		nuIndex	number;
		nuSucacate number;
		nuSucacodi number;

    BEGIN
	--{
		nuSucacate := inuSucacate;
		nuSucacodi := inuSucacodi;

		-- Si la categoria es -1 se asigna 9999
		IF (nuSucacate = -1) THEN nuSucacate := 999; END IF;

		-- Si la subcategoria es -1 se asigna 999
		IF (nuSucacodi = -1) THEN nuSucacodi := 999; END IF;

		-- Calcula el index
		nuIndex := to_number(CONCAT(lpad(nuSucacate,3,'0'),lpad(nuSucacodi,3,'0')));

		return nuIndex;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fnuGetHash;
END LDC_DSSUBCATEG;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_DSSUBCATEG
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSSUBCATEG', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_DSSUBCATEG
GRANT EXECUTE ON ADM_PERSON.LDC_DSSUBCATEG TO REXEREPORTES;
/
