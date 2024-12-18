CREATE OR REPLACE PACKAGE adm_person.LDC_dsEstacort
IS
    /***********************************************************
    	Name     :   Data Services for Entity Estacort
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date                Author             Change
    	=========           =========          ====================
        25/06/2024          PAcosta            OSF-2878: Cambio de esquema ADM_PERSON 
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetDescription
    (
		inuEscocodi		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsEstacort
IS
    /***********************************************************
    	Name     :   Data Services for Entity Estacort
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuestacort (inuEscocodi in estacort.escocodi%type) IS
	SELECT /*+ INDEX (estacort, pk_estacort) */
			*
	FROM   estacort
	WHERE  escocodi = inuEscocodi;

    -- Variables
	subtype styestacort is cuestacort%rowtype;
	type tytbestacort is table of styestacort index by binary_integer;

	tbestacort tytbestacort;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadEstacort
    (
		inuEscocodi		in	number
    )
    IS
		rctbestacort	styestacort;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuestacort(inuEscocodi);

		--	Recupera registros
		FETCH cuestacort INTO rctbestacort;

		--	Cierra cursor
		CLOSE cuestacort;

		tbestacort(inuEscocodi) := rctbestacort;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadEstacort;

	FUNCTION fsbGetDescription
    (
		inuEscocodi		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuEscocodi IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbestacort.exists(inuEscocodi)) THEN
		--{
			loadestacort(inuEscocodi);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuEscocodi || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbestacort(inuEscocodi).escodesc;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;
END LDC_DSESTACORT;
/
PROMPT Otorgando permisos de ejecucion a LDC_DSESTACORT
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_DSESTACORT', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_DSESTACORT para reportes
GRANT EXECUTE ON adm_person.LDC_DSESTACORT TO rexereportes;
/
