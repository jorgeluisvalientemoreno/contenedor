CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSMO_PACKAGES
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity Mo_packages
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

    FUNCTION fnuGetPackage_type_id
    (
		inuPackage_id   in	number
    )
	return number;

    FUNCTION fsbDescPackage_type
    (
		inuPackage_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2;

    FUNCTION fsbGetRequest_Date
    (
		inuPackage_id     in	number
    )
	return date;

    FUNCTION fsbGetAttention_date
    (
		inuPackage_id     in	number
    )
	return date;

    FUNCTION fnuGetMotive_status_id
    (
		inuPackage_id   in	number
    )
	return number;

    FUNCTION fsbDescMotive_status
    (
		inuPackage_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2;

    FUNCTION fsbDescReception_Type
    (
		inuPackage_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2;
--}
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSMO_PACKAGES
IS
    /***********************************************************
    	Name     :   Data Services for Entity Mo_packages
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

    -- Cursores
	CURSOR cuMo_packages (inuPackage_id in  mo_packages.package_id%type) IS
	SELECT /*+ INDEX (mo_packages, pk_Mo_package) */
			*
	FROM   Mo_packages
	WHERE  package_id = inuPackage_id;

    -- Variables
	subtype styMo_packages is cuMo_packages%rowtype;
	type tytbMo_packages is table of styMo_packages index by binary_integer;

	tbMo_packages tytbMo_packages;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadMo_packages
    (
		inuPackage_id		in	number
    )
    IS
		rctbMo_packages  styMo_packages;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuMo_packages(inuPackage_id);

		--	Recupera registros
		FETCH cuMo_packages INTO rctbMo_packages;

		--	Cierra cursor
		CLOSE cuMo_packages;

		tbMo_packages(inuPackage_id) := rctbMo_packages;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadMo_packages;

    FUNCTION fnuGetPackage_type_id
    (
		inuPackage_id   in	number
    )
	return number
    IS
		-- Variables
		nuPackage_type_id     Mo_packages.package_type_id%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return nuPackage_type_id;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuPackage_type_id := tbMo_packages(inuPackage_id).package_type_id;

		return nuPackage_type_id;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbDescPackage_type
    (
		inuPackage_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescPackage_type    ps_package_type.description%type := '';
		nuPackage_type_id     Mo_packages.package_type_id%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return sbDescPackage_type;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene el package_type_id
		nuPackage_type_id := tbMo_packages(inuPackage_id).package_type_id;

		-- Obtiene descripcion de package type
        sbDescPackage_type :=LDC_dsPs_package_type.fsbGetDescription(nuPackage_type_id,
                                                              inuConcatId);

		return sbDescPackage_type;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbGetRequest_Date
    (
		inuPackage_id     in	number
    )
	return date
    IS
		-- Variables
		dtRequest_date        Mo_packages.request_date%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return dtRequest_date;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene request_date
		dtRequest_date := tbMo_packages(inuPackage_id).request_date;

		return dtRequest_date;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbGetAttention_date
    (
		inuPackage_id     in	number
    )
	return date
    IS
		-- Variables
		dtAttention_date        Mo_packages.attention_date%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return dtAttention_date;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene request_date
		dtAttention_date := tbMo_packages(inuPackage_id).attention_date;

		return dtAttention_date;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fnuGetMotive_status_id
    (
		inuPackage_id   in	number
    )
	return number
    IS
		-- Variables
		nuMotive_status_id     Mo_packages.motive_status_id%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return nuMotive_status_id;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene el Motive_status_id
		nuMotive_status_id := tbMo_packages(inuPackage_id).motive_status_id;

		return nuMotive_status_id;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbDescMotive_status
    (
		inuPackage_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescMotive_status   ps_motive_status.description%type := '';
		nuMotive_status_id    Mo_packages.motive_status_id%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return sbDescMotive_status;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene el motive_status_id
		nuMotive_status_id := tbMo_packages(inuPackage_id).motive_status_id;

		-- Obtiene descripcion Motive_status
        sbDescMotive_status :=LDC_dsPs_motive_status.fsbGetDescription(nuMotive_status_id,
                                                                       inuConcatId);

		return sbDescMotive_status;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

    FUNCTION fsbDescReception_Type
    (
		inuPackage_id     in	number,
		inuConcatId       in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescReception_Type  ge_reception_type.description%type := '';
		nuReception_Type_id   Mo_packages.reception_type_id%type;

    BEGIN
	--{
		IF (inuPackage_id IS NULL) THEN
		--{
			return sbDescReception_Type;
		--}
		END IF;

		IF (NOT tbMo_packages.exists(inuPackage_id)) THEN
		--{
            -- Carga Mo_packages
			loadMo_packages(inuPackage_id);
		--}
		END IF;

		-- Obtiene el nuReception_Type_id
		nuReception_Type_id := tbMo_packages(inuPackage_id).reception_type_id;

		-- Obtiene descripcion Motive_status
        sbDescReception_Type :=LDC_dsGe_reception_type.fsbGetDescription(nuReception_Type_id,
                                                                         inuConcatId);

		return sbDescReception_Type;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSMO_PACKAGES', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSMO_PACKAGES TO REXEREPORTES;
/