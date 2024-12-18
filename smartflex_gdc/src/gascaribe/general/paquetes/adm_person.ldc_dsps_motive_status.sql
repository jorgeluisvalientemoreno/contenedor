CREATE OR REPLACE PACKAGE adm_person.ldc_dsps_motive_status
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ps_motive_status
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

	FUNCTION fsbGetDescription
    (
		inuMotive_status_id   in	number,
		inuConcatId		      in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsPs_motive_status
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ps_motive_status
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuPS_motive_status (inuMotive_status_id in ps_motive_status.motive_status_id%type) IS
	SELECT /*+ INDEX (ps_motive_status, pk_ps_motive_status) */
			*
	FROM  ps_motive_status
	WHERE motive_status_id = inuMotive_status_id;

    -- Variables
	subtype styps_motive_status is cups_motive_status%rowtype;
	type tytbps_motive_status is table of styps_motive_status index by binary_integer;

	tbps_motive_status tytbps_motive_status;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadPs_motive_status
    (
		inuMotive_status_id		in	number
    )
    IS
		rctbps_motive_status	styps_motive_status;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cups_motive_status(inuMotive_status_id);

		--	Recupera registros
		FETCH cups_motive_status INTO rctbps_motive_status;

		--	Cierra cursor
		CLOSE cups_motive_status;

		tbps_motive_status(inuMotive_status_id) := rctbps_motive_status;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadPs_motive_status;

	FUNCTION fsbGetDescription
    (
		inuMotive_status_id		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuMotive_status_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbps_motive_status.exists(inuMotive_status_id)) THEN
		--{
			loadPs_motive_status(inuMotive_status_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuMotive_status_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbps_motive_status(inuMotive_status_id).description;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

END LDC_DSPS_MOTIVE_STATUS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_DSPS_MOTIVE_STATUS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSPS_MOTIVE_STATUS', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_DSPS_MOTIVE_STATUS
GRANT EXECUTE ON ADM_PERSON.LDC_DSPS_MOTIVE_STATUS TO REXEREPORTES;
/