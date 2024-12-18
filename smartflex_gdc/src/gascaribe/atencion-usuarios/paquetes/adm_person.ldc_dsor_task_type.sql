CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_DSOR_TASK_TYPE
IS
--{
    /***********************************************************
    	Name     :   Data Services for Entity or_task_type
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
		inuTask_type_id		in	number,
		inuConcatId		in	number default 0
    )
	return varchar2;

	FUNCTION fnuGetTask_type_classif
    (
		inuTask_type_id	in	number
    )
	return number;
--}
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_DSOR_TASK_TYPE
IS
    /***********************************************************
    	Name     :   Data Services for Entity or_task_type
    	Author   :   rcalixto - Automatic persistence level generator
    	Date     :   Tuesday  , 01 de January   de 2019

    	Methods

    	History of changes
    	Date        Author    Change
    	=========   ========= ====================
    ************************************************************/

    -- Cursores
	CURSOR cuor_task_type (inuTask_type_id in or_task_type.task_type_id%type) IS
	SELECT /*+ INDEX (or_task_type, pk_or_task_type) */
			*
	FROM  or_task_type
	WHERE task_type_id = inuTask_type_id;

    -- Variables
	subtype styor_task_type is cuor_task_type%rowtype;
	type tytbor_task_type is table of styor_task_type index by binary_integer;

	tbor_task_type tytbor_task_type;

	-- Constantes
	csbVERSION        CONSTANT VARCHAR2(3) := '1.0';

	FUNCTION fsbVersion
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN csbVERSION;
	END;

    PROCEDURE loadTask_type
    (
		inuTask_type_id		in	number
    )
    IS
		rctbor_task_type	styor_task_type;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuor_task_type(inuTask_type_id);

		--	Recupera registros
		FETCH cuor_task_type INTO rctbor_task_type;

		--	Cierra cursor
		CLOSE cuor_task_type;

		tbor_task_type(inuTask_type_id) := rctbor_task_type;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadTask_type;

	FUNCTION fsbGetDescription
    (
		inuTask_type_id	in	number,
		inuConcatId		in	number default 0
    )
	return varchar2
    IS
		-- Variables
		sbDescription         varchar2(2000) := '';


    BEGIN
	--{
		IF (inuTask_type_id IS NULL) THEN
		--{
			return sbDescription;
		--}
		END IF;

		IF (NOT tbor_task_type.exists(inuTask_type_id)) THEN
		--{
            -- Cargar Task type
			loadTask_type(inuTask_type_id);
		--}
		END IF;

		IF (inuConcatId = 1) THEN
		--{
            -- Construye task type
			sbDescription := inuTask_type_id || '-' ;
		--}
		END IF;

		-- Construye task type
		sbDescription := sbDescription || tbor_task_type(inuTask_type_id).description;

		return sbDescription;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetDescription;

	FUNCTION fnuGetTask_type_classif
    (
		inuTask_type_id	in	number
    )
	return number
    IS
		-- Variables
        nuTask_type_classif   or_task_type.task_type_classif%type;

    BEGIN
	--{
		IF (inuTask_type_id IS NULL) THEN
		--{
			return nuTask_type_classif;
		--}
		END IF;

		IF (NOT tbor_task_type.exists(inuTask_type_id)) THEN
		--{
            -- Cargar Task type
			loadTask_type(inuTask_type_id);
		--}
		END IF;

		-- Construye Task_type_classif
		nuTask_type_classif:=tbor_task_type(inuTask_type_id).task_type_classif;

		return nuTask_type_classif;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fnuGetTask_type_classif;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSOR_TASK_TYPE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_DSOR_TASK_TYPE TO REXEREPORTES;
/