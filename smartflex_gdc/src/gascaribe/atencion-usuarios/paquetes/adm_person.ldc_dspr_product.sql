CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSPR_PRODUCT
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity Pr_product
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

    FUNCTION fnuGetProduct_status_id
    (
		inuProduct_id   in	number
    )
	return number;

    FUNCTION fsbDescProduct_status
    (
		inuProduct_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2;

    FUNCTION fnuGetCommercial_Plan
    (
		inuProduct_id   in	number
    )
	return number;

    FUNCTION fsbDescCommercial_Plan
    (
		inuProduct_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2;
--}
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSPR_PRODUCT
IS
    /***********************************************************
    	Name     :   Data Services for Entity Pr_product
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

    -- Cursores
	CURSOR cuPr_product (inuProduct_id in  Pr_product.product_id%type) IS
	SELECT /*+ INDEX (Pr_product, pk_Mo_package) */
			*
	FROM   Pr_product
	WHERE  product_id = inuProduct_id;

    -- Variables
	subtype styPr_product is cuPr_product%rowtype;
	type tytbPr_product is table of styPr_product index by binary_integer;

	tbPr_product tytbPr_product;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadPr_product
    (
		inuProduct_id		in	number
    )
    IS
		rctbPr_product  styPr_product;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuPr_product(inuProduct_id);

		--	Recupera registros
		FETCH cuPr_product INTO rctbPr_product;

		--	Cierra cursor
		CLOSE cuPr_product;

		tbPr_product(inuProduct_id) := rctbPr_product;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadPr_product;

    FUNCTION fnuGetProduct_status_id
    (
		inuProduct_id   in	number
    )
	return number
    IS
		-- Variables
		nuProduct_status_id   Pr_product.product_status_id%type;

    BEGIN
	--{
		IF (inuProduct_id IS NULL) THEN
		--{
			return nuProduct_status_id;
		--}
		END IF;

		IF (NOT tbPr_product.exists(inuProduct_id)) THEN
		--{
            -- Carga Pr_product
			loadPr_product(inuProduct_id);
		--}
		END IF;

		-- Obtiene el product_status_id
		nuProduct_status_id := tbPr_product(inuProduct_id).product_status_id;

		return nuProduct_status_id;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbDescProduct_status
    (
		inuProduct_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescProduct_status  ps_product_status.description%type := '';
		nuProduct_status_id   pr_product.product_status_id%type;

    BEGIN
	--{
		IF (inuProduct_id IS NULL) THEN
		--{
			return sbDescProduct_status;
		--}
		END IF;

		IF (NOT tbPr_product.exists(inuProduct_id)) THEN
		--{
            -- Carga Pr_product
			loadPr_product(inuProduct_id);
		--}
		END IF;

		-- Obtiene el Product_status_id
		nuProduct_status_id := tbPr_product(inuProduct_id).product_status_id;

		-- Obtiene descripcion de product_status_id
        sbDescProduct_status := LDC_dsPs_product_status.fsbGetDescription(nuProduct_status_id,
                                                                          inuConcatId);

		return sbDescProduct_status;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fnuGetCommercial_Plan
    (
		inuProduct_id   in	number
    )
	return number
    IS
		-- Variables
		nuCommercial_plan_id  Pr_product.commercial_plan_id%type;

    BEGIN
	--{
		IF (inuProduct_id IS NULL) THEN
		--{
			return nuCommercial_plan_id;
		--}
		END IF;

		IF (NOT tbPr_product.exists(inuProduct_id)) THEN
		--{
            -- Carga Pr_product
			loadPr_product(inuProduct_id);
		--}
		END IF;

		-- Obtiene el commercial_plan_id
		nuCommercial_plan_id := tbPr_product(inuProduct_id).commercial_plan_id;

		return nuCommercial_plan_id;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbDescCommercial_Plan
    (
		inuProduct_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbCommercial_plan_id  cc_commercial_plan.description%type := '';
		nuCommercial_plan_id  pr_product.commercial_plan_id%type;

    BEGIN
	--{
		IF (inuProduct_id IS NULL) THEN
		--{
			return sbCommercial_plan_id;
		--}
		END IF;

		IF (NOT tbPr_product.exists(inuProduct_id)) THEN
		--{
            -- Carga Pr_product
			loadPr_product(inuProduct_id);
		--}
		END IF;

		-- Obtiene el commercial_plan_id
		nuCommercial_plan_id := tbPr_product(inuProduct_id).commercial_plan_id;

		-- Obtiene descripcion de commercial_plan_id
        sbCommercial_plan_id := LDC_dsCc_commercial_plan.fsbGetDescription(nuCommercial_plan_id,
                                                                           inuConcatId);

		return sbCommercial_plan_id;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSPR_PRODUCT', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSPR_PRODUCT TO REXEREPORTES;
/