CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSSERVSUSC
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity Servsusc
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
	FUNCTION fsbVersion
	RETURN VARCHAR2;

    FUNCTION fnuGetSesuesco
    (
		inuSesunuse   in	number
    )
	return number;

	FUNCTION fsbGetEscoDesc
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return varchar2;

	FUNCTION fnuGetSesucate
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return number;

	FUNCTION fsbGetCateDesc
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return varchar2;

	FUNCTION fnuGetSesuSuca
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return number;

	FUNCTION fsbGetSucaDesc
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return varchar2;

	FUNCTION fnuGetSesuCicl
    (
		inuSesunuse   in	number
    )
	return number;

	FUNCTION fdtGetSesuFein
    (
		inuSesunuse   in	number
    )
	return date;
--}
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSSERVSUSC
IS
    /***********************************************************
    	Name     :   Data Services for Entity Servsusc
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

    -- Cursores
	CURSOR cuServsusc (inuSesunuse in Servsusc.sesunuse%type) IS
	SELECT /*+ INDEX (Servsusc, pk_Servsusc) */
			*
	FROM   Servsusc
	WHERE  sesunuse = inuSesunuse;

    -- Variables
	subtype styServsusc is cuServsusc%rowtype;
	type tytbServsusc is table of styServsusc index by binary_integer;

	tbServsusc tytbServsusc;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadServsusc
    (
		inuSesunuse		in	number
    )
    IS
		rctbServsusc  styServsusc;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuServsusc(inuSesunuse);

		--	Recupera registros
		FETCH cuServsusc INTO rctbServsusc;

		--	Cierra cursor
		CLOSE cuServsusc;

		tbServsusc(inuSesunuse) := rctbServsusc;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END loadServsusc;

	FUNCTION fnuGetSesuesco
    (
		inuSesunuse   in	number
    )
	return number
    IS
		-- Variables
		nuSesuesco    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return nuSesuesco;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuSesuesco := tbServsusc(inuSesunuse).sesuesco;

		return nuSesuesco;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fsbGetEscoDesc
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbEscoDesc    varchar2(2000) := '';
		nuSesuesco    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return sbEscoDesc;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuSesuesco := tbServsusc(inuSesunuse).sesuesco;

		-- Obtiene descripcion de estado de corte
        sbEscoDesc := LDC_dsEstacort.fsbGetDescription(nuSesuesco, inuConcatId);

		return sbEscoDesc;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fnuGetSesucate
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return number
    IS
		-- Variables
		nuSesucate    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return nuSesucate;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuSesucate := tbServsusc(inuSesunuse).sesucate;

		return nuSesucate;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fsbGetCateDesc
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbCateDesc    varchar2(2000) := '';
		nuSesucate    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return sbCateDesc;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesucate
		nuSesucate := tbServsusc(inuSesunuse).sesucate;

		-- Obtiene descripcion de la categoria
        sbCateDesc := LDC_dsEstacort.fsbGetDescription(nuSesucate, inuConcatId);

		return sbCateDesc;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fnuGetSesuSuca
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return number
    IS
		-- Variables
		nuSesusuca    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return nuSesusuca;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuSesusuca := tbServsusc(inuSesunuse).sesusuca;

		return nuSesusuca;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fsbGetSucaDesc
    (
		inuSesunuse   in	number,
		inuConcatId   in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbSucaDesc    varchar2(2000) := '';
		nuSesucate    number;
		nuSesusuca    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return sbSucaDesc;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesucate
		nuSesucate := tbServsusc(inuSesunuse).sesucate;
		nuSesusuca := tbServsusc(inuSesunuse).sesusuca;

		-- Obtiene descripcion de la categoria
        sbSucaDesc := LDC_dsSubcateg.fsbGetSucadesc( nuSesucate,
                                                        nuSesusuca,
                                                        inuConcatId);

		return sbSucaDesc;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fnuGetSesuCicl
    (
		inuSesunuse   in	number
    )
	return number
    IS
		-- Variables
		nuSesucicl    number;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return nuSesucicl;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuSesucicl := tbServsusc(inuSesunuse).sesucicl;

		return nuSesucicl;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;

	FUNCTION fdtGetSesuFein
    (
		inuSesunuse   in	number
    )
	return date
    IS
		-- Variables
		nuSesufein    servsusc.sesufein%type;

    BEGIN
	--{
		IF (inuSesunuse IS NULL) THEN
		--{
			return nuSesufein;
		--}
		END IF;

		IF (NOT tbServsusc.exists(inuSesunuse)) THEN
		--{
            -- Carga servsusc
			loadServsusc(inuSesunuse);
		--}
		END IF;

		-- Obtiene el sesuesco
		nuSesufein := tbServsusc(inuSesunuse).sesufein;

		return nuSesufein;
    EXCEPTION
        WHEN others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	--}
    END;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSSERVSUSC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSSERVSUSC TO REXEREPORTES;
/