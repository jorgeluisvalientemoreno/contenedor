CREATE OR REPLACE PACKAGE adm_person.ldc_dsps_product_status
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ps_product_status
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
		inuProduct_status_id  in	number,
		inuConcatId           in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsPs_product_status
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ps_product_status
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cups_product_status (inuProduct_status_id in ps_product_status.product_status_id%type) IS
	SELECT /*+ INDEX (ps_product_status, pk_ps_product_status) */
			*
	FROM   ps_product_status
	WHERE  product_status_id = inuProduct_status_id;

    -- Variables
	subtype styps_product_status is cups_product_status%rowtype;
	type tytbps_product_status is table of styps_product_status index by binary_integer;

	tbps_product_status tytbps_product_status;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadProduct_status
    (
		inuProduct_status_id		in	number
    )
    IS
		rctbps_product_status	styps_product_status;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cups_product_status(inuProduct_status_id);

		--	Recupera registros
		FETCH cups_product_status INTO rctbps_product_status;

		--	Cierra cursor
		CLOSE cups_product_status;

		tbps_product_status(inuProduct_status_id) := rctbps_product_status;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadProduct_status;

	FUNCTION fsbGetDescription
    (
		inuProduct_status_id  in	number,
		inuConcatId		      in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuProduct_status_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbps_product_status.exists(inuProduct_status_id)) THEN
		--{
			loadProduct_status(inuProduct_status_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuProduct_status_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbps_product_status(inuProduct_status_id).description;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

END LDC_DSPS_PRODUCT_STATUS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_DSPS_PRODUCT_STATUS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSPS_PRODUCT_STATUS', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_DSPS_PRODUCT_STATUS
GRANT EXECUTE ON ADM_PERSON.LDC_DSPS_PRODUCT_STATUS TO REXEREPORTES;
/
