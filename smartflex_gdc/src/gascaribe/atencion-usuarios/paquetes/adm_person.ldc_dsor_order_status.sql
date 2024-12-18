CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSOR_ORDER_STATUS
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
	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetDescription
    (
		inuOrder_status_id		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSOR_ORDER_STATUS
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
	CURSOR cuOR_ORDER_STATUS (inuOrder_status_id in OR_ORDER_STATUS.order_status_id%type) IS
	SELECT /*+ INDEX (OR_ORDER_STATUS, pk_OR_ORDER_STATUS) */
			*
	FROM  OR_ORDER_STATUS
	WHERE order_status_id = inuOrder_status_id;

    -- Variables
	subtype styOR_ORDER_STATUS is cuOr_order_status%rowtype;
	type tytbOR_ORDER_STATUS is table of styOR_ORDER_STATUS index by binary_integer;

	tbOR_ORDER_STATUS tytbOR_ORDER_STATUS;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadOrder_Status
    (
		inuOrder_status_id		in	number
    )
    IS
		rctbOR_ORDER_STATUS	styOR_ORDER_STATUS;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuOr_order_status(inuOrder_status_id);

		--	Recupera registros
		FETCH cuOr_order_status INTO rctbOR_ORDER_STATUS;

		--	Cierra cursor
		CLOSE cuOr_order_status;

		tbOR_ORDER_STATUS(inuOrder_status_id) := rctbOR_ORDER_STATUS;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadOrder_Status;

	FUNCTION fsbGetDescription
    (
		inuOrder_status_id		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuOrder_status_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbOR_ORDER_STATUS.exists(inuOrder_status_id)) THEN
		--{
			loadOrder_Status(inuOrder_status_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuOrder_status_id || '-' ;
		--}
		END IF;

		sbDescription := sbDescription || tbOR_ORDER_STATUS(inuOrder_status_id).description;

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
    pkg_utilidades.prAplicarPermisos('LDC_DSOR_ORDER_STATUS', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSOR_ORDER_STATUS TO REXEREPORTES;
/