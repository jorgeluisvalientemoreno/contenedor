CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSGE_ITEMS
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_Items
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetdescription
    (
		inuItems_id	in	number,
		inuConcatId			in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSGE_ITEMS
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_Items
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

    -- Cursores
	CURSOR cuGe_Items (inuItems_id in Ge_Items.items_id%type) IS
	SELECT /*+ INDEX (Ge_Items, pk_Ge_Items) */
			*
	FROM   Ge_Items
	WHERE  items_id = inuItems_id;

    -- Variables
	subtype styGe_Items is cuGe_Items%rowtype;
	type tytbGe_Items is table of styGe_Items index by binary_integer;

	tbGe_Items tytbGe_Items;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadGe_Items
    (
		inuItems_id		in	number
    )
    IS
		rctbGe_Items	styGe_Items;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuGe_Items(inuItems_id);

		--	Recupera registros
		FETCH cuGe_Items INTO rctbGe_Items;

		--	Cierra cursor
		CLOSE cuGe_Items;

		tbGe_Items(inuItems_id) := rctbGe_Items;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadGe_Items;

	FUNCTION fsbGetdescription
    (
		inuItems_id	in	number,
		inuConcatId			in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuItems_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbGe_Items.exists(inuItems_id)) THEN
		--{
			loadGe_Items(inuItems_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuItems_id || '-';
		--}
		END IF;

		sbDescription := sbDescription || tbGe_Items(inuItems_id).description;

		return sbDescription;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetdescription;

END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSGE_ITEMS', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSGE_ITEMS TO REXEREPORTES;
/