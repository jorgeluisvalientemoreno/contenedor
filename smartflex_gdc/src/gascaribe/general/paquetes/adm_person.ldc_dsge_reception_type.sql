CREATE OR REPLACE PACKAGE adm_person.LDC_dsGe_reception_type
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_reception_type
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
        25/06/2024  PAcosta   OSF-2878: Cambio de esquema ADM_PERSON
    ************************************************************/

	FUNCTION fsbVersion
	RETURN VARCHAR2;

	FUNCTION fsbGetDescription
    (
		inuReception_type_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_dsGe_reception_type
IS
    /***********************************************************
    	Name     :   Data Services for Entity Ge_reception_type
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/
    -- Cursores
	CURSOR cuge_reception_type (inuReception_type_id in ge_reception_type.reception_type_id%type) IS
	SELECT /*+ INDEX (ge_reception_type, pk_ge_reception_type) */
			*
	FROM   ge_reception_type
	WHERE  reception_type_id = inuReception_type_id;

    -- Variables
	subtype styge_reception_type is cuge_reception_type%rowtype;
	type tytbge_reception_type is table of styge_reception_type index by binary_integer;

	tbge_reception_type tytbge_reception_type;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadge_reception_type
    (
		inuReception_type_id		in	number
    )
    IS
		rctbge_reception_type	styge_reception_type;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuge_reception_type(inuReception_type_id);

		--	Recupera registros
		FETCH cuge_reception_type INTO rctbge_reception_type;

		--	Cierra cursor
		CLOSE cuge_reception_type;

		tbge_reception_type(inuReception_type_id) := rctbge_reception_type;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadge_reception_type;

	FUNCTION fsbGetDescription
    (
		inuReception_type_id	in	number,
		inuConcatId				in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription	varchar2(2000) := '';

    BEGIN
	--{
		IF (inuReception_type_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbge_reception_type.exists(inuReception_type_id)) THEN
		--{
			loadge_reception_type(inuReception_type_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
			sbDescription := inuReception_type_id || ' - ' ;
		--}
		END IF;

		sbDescription := sbDescription || tbge_reception_type(inuReception_type_id).description;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

END LDC_DSGE_RECEPTION_TYPE;
/
PROMPT Otorgando permisos de ejecucion a LDC_DSGE_RECEPTION_TYPE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_DSGE_RECEPTION_TYPE', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_DSGE_RECEPTION_TYPE para reportes
GRANT EXECUTE ON adm_person.LDC_DSGE_RECEPTION_TYPE TO rexereportes;
/