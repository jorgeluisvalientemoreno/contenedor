CREATE OR REPLACE PACKAGE adm_person.LDC_dsCc_commercial_plan
IS
    /***********************************************************
    	Name     :   Data Services for Entity cc_commercial_plan
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date            Author      Change
    	=========       =========   ====================
        25/06/2024      PAcosta     OSF-2878: Cambio de esquema ADM_PERSON
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetDescription
    (
		inuCommercial_plan_id		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsCc_commercial_plan
IS
    /***********************************************************
    	Name     :   Data Services for Entity cc_commercial_plan
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cucc_commercial_plan (inuCommercial_plan_id in cc_commercial_plan.commercial_plan_id%type) IS
	SELECT /*+ INDEX (cc_commercial_plan, pk_cc_commercial_plan) */
			*
	FROM   cc_commercial_plan
	WHERE  commercial_plan_id = inuCommercial_plan_id;

	subtype stycc_commercial_plan is cucc_commercial_plan%rowtype;
	type tytbcc_commercial_plan is table of stycc_commercial_plan index by binary_integer;

	tbcc_commercial_plan tytbcc_commercial_plan;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadcc_commercial_plan
    (
		inuCommercial_plan_id		in	number
    )
    IS
		rctbcc_commercial_plan	stycc_commercial_plan;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cucc_commercial_plan(inuCommercial_plan_id);

		--	Recupera registros
		FETCH cucc_commercial_plan INTO rctbcc_commercial_plan;

		--	Cierra cursor
		CLOSE cucc_commercial_plan;

		tbcc_commercial_plan(inuCommercial_plan_id) := rctbcc_commercial_plan;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadcc_commercial_plan;

	FUNCTION fsbGetDescription
    (
		inuCommercial_plan_id		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuCommercial_plan_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbcc_commercial_plan.exists(inuCommercial_plan_id)) THEN
		--{
			loadcc_commercial_plan(inuCommercial_plan_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuCommercial_plan_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbcc_commercial_plan(inuCommercial_plan_id).description;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

END LDC_DSCC_COMMERCIAL_PLAN;
/
PROMPT Otorgando permisos de ejecucion a LDC_DSCC_COMMERCIAL_PLAN
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_DSCC_COMMERCIAL_PLAN', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_DSCC_COMMERCIAL_PLAN para reportes
GRANT EXECUTE ON adm_person.LDC_DSCC_COMMERCIAL_PLAN TO rexereportes;
/
