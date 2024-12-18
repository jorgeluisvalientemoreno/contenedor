CREATE OR REPLACE PACKAGE adm_person.daldc_condit_commerc_segm
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	IS
		SELECT LDC_CONDIT_COMMERC_SEGM.*,LDC_CONDIT_COMMERC_SEGM.rowid
		FROM LDC_CONDIT_COMMERC_SEGM
		WHERE
		    COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CONDIT_COMMERC_SEGM.*,LDC_CONDIT_COMMERC_SEGM.rowid
		FROM LDC_CONDIT_COMMERC_SEGM
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CONDIT_COMMERC_SEGM  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CONDIT_COMMERC_SEGM is table of styLDC_CONDIT_COMMERC_SEGM index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CONDIT_COMMERC_SEGM;

	/* Tipos referenciando al registro */
	type tytbCOND_COMMER_SEGM_ID is table of LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type index by binary_integer;
	type tytbACRONYM is table of LDC_CONDIT_COMMERC_SEGM.ACRONYM%type index by binary_integer;
	type tytbDESCRIPTION is table of LDC_CONDIT_COMMERC_SEGM.DESCRIPTION%type index by binary_integer;
	type tytbACTIVE is table of LDC_CONDIT_COMMERC_SEGM.ACTIVE%type index by binary_integer;
	type tytbTIME is table of LDC_CONDIT_COMMERC_SEGM.TIME%type index by binary_integer;
	type tytbPARAMETER is table of LDC_CONDIT_COMMERC_SEGM.PARAMETER%type index by binary_integer;
	type tytbORDER_EXE is table of LDC_CONDIT_COMMERC_SEGM.ORDER_EXE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CONDIT_COMMERC_SEGM is record
	(
		COND_COMMER_SEGM_ID   tytbCOND_COMMER_SEGM_ID,
		ACRONYM   tytbACRONYM,
		DESCRIPTION   tytbDESCRIPTION,
		ACTIVE   tytbACTIVE,
		TIME   tytbTIME,
		PARAMETER   tytbPARAMETER,
		ORDER_EXE   tytbORDER_EXE,
		row_id tytbrowid
	);


	/***** Metodos Publicos ****/

    FUNCTION fsbVersion
    RETURN varchar2;

	FUNCTION fsbGetMessageDescription
	return varchar2;

	PROCEDURE ClearMemory;

	FUNCTION fblExist
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	);

	PROCEDURE getRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		orcRecord out nocopy styLDC_CONDIT_COMMERC_SEGM
	);

	FUNCTION frcGetRcData
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN styLDC_CONDIT_COMMERC_SEGM;

	FUNCTION frcGetRcData
	RETURN styLDC_CONDIT_COMMERC_SEGM;

	FUNCTION frcGetRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN styLDC_CONDIT_COMMERC_SEGM;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONDIT_COMMERC_SEGM
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CONDIT_COMMERC_SEGM in styLDC_CONDIT_COMMERC_SEGM
	);

	PROCEDURE insRecord
	(
		ircLDC_CONDIT_COMMERC_SEGM in styLDC_CONDIT_COMMERC_SEGM,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CONDIT_COMMERC_SEGM in out nocopy tytbLDC_CONDIT_COMMERC_SEGM
	);

	PROCEDURE delRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CONDIT_COMMERC_SEGM in out nocopy tytbLDC_CONDIT_COMMERC_SEGM,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CONDIT_COMMERC_SEGM in styLDC_CONDIT_COMMERC_SEGM,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CONDIT_COMMERC_SEGM in out nocopy tytbLDC_CONDIT_COMMERC_SEGM,
		inuLock in number default 1
	);

	PROCEDURE updACRONYM
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbACRONYM$ in LDC_CONDIT_COMMERC_SEGM.ACRONYM%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbDESCRIPTION$ in LDC_CONDIT_COMMERC_SEGM.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbACTIVE$ in LDC_CONDIT_COMMERC_SEGM.ACTIVE%type,
		inuLock in number default 0
	);

	PROCEDURE updTIME
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbTIME$ in LDC_CONDIT_COMMERC_SEGM.TIME%type,
		inuLock in number default 0
	);

	PROCEDURE updPARAMETER
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbPARAMETER$ in LDC_CONDIT_COMMERC_SEGM.PARAMETER%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_EXE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuORDER_EXE$ in LDC_CONDIT_COMMERC_SEGM.ORDER_EXE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOND_COMMER_SEGM_ID
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type;

	FUNCTION fsbGetACRONYM
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.ACRONYM%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.DESCRIPTION%type;

	FUNCTION fsbGetACTIVE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.ACTIVE%type;

	FUNCTION fsbGetTIME
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.TIME%type;

	FUNCTION fsbGetPARAMETER
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.PARAMETER%type;

	FUNCTION fnuGetORDER_EXE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.ORDER_EXE%type;


	PROCEDURE LockByPk
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		orcLDC_CONDIT_COMMERC_SEGM  out styLDC_CONDIT_COMMERC_SEGM
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONDIT_COMMERC_SEGM  out styLDC_CONDIT_COMMERC_SEGM
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CONDIT_COMMERC_SEGM;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CONDIT_COMMERC_SEGM
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CONDIT_COMMERC_SEGM';
	 cnuGeEntityId constant varchar2(30) := 1126; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	IS
		SELECT LDC_CONDIT_COMMERC_SEGM.*,LDC_CONDIT_COMMERC_SEGM.rowid
		FROM LDC_CONDIT_COMMERC_SEGM
		WHERE  COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CONDIT_COMMERC_SEGM.*,LDC_CONDIT_COMMERC_SEGM.rowid
		FROM LDC_CONDIT_COMMERC_SEGM
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CONDIT_COMMERC_SEGM is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CONDIT_COMMERC_SEGM;

	rcData cuRecord%rowtype;

    blDAO_USE_CACHE    boolean := null;


	/* Metodos privados */
	FUNCTION fsbGetMessageDescription
	return varchar2
	is
	      sbTableDescription varchar2(32000);
	BEGIN
	    if (cnuGeEntityId > 0 and dage_entity.fblExist (cnuGeEntityId))  then
	          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
	    else
	          sbTableDescription:= csbTABLEPARAMETER;
	    end if;

		return sbTableDescription ;
	END;

	PROCEDURE GetDAO_USE_CACHE
	IS
	BEGIN
	    if ( blDAO_USE_CACHE is null ) then
	        blDAO_USE_CACHE :=  ge_boparameter.fsbget('DAO_USE_CACHE') = 'Y';
	    end if;
	END;
	FUNCTION fsbPrimaryKey( rcI in styLDC_CONDIT_COMMERC_SEGM default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.COND_COMMER_SEGM_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		orcLDC_CONDIT_COMMERC_SEGM  out styLDC_CONDIT_COMMERC_SEGM
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

		Open cuLockRcByPk
		(
			inuCOND_COMMER_SEGM_ID
		);

		fetch cuLockRcByPk into orcLDC_CONDIT_COMMERC_SEGM;
		if cuLockRcByPk%notfound  then
			close cuLockRcByPk;
			raise no_data_found;
		end if;
		close cuLockRcByPk ;
	EXCEPTION
		when no_data_found then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
		when ex.RESOURCE_BUSY THEN
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			errors.setError(cnuAPPTABLEBUSSY,fsbPrimaryKey(rcError)||'|'|| fsbGetMessageDescription );
			raise ex.controlled_error;
		when others then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			raise;
	END;
	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONDIT_COMMERC_SEGM  out styLDC_CONDIT_COMMERC_SEGM
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CONDIT_COMMERC_SEGM;
		if cuLockRcbyRowId%notfound  then
			close cuLockRcbyRowId;
			raise no_data_found;
		end if;
		close cuLockRcbyRowId;
	EXCEPTION
		when no_data_found then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
			raise ex.CONTROLLED_ERROR;
		when ex.RESOURCE_BUSY THEN
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			errors.setError(cnuAPPTABLEBUSSY,'rowid=['||irirowid||']|'||fsbGetMessageDescription );
			raise ex.controlled_error;
		when others then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			raise;
	END;
	PROCEDURE DelRecordOfTables
	(
		itbLDC_CONDIT_COMMERC_SEGM  in out nocopy tytbLDC_CONDIT_COMMERC_SEGM
	)
	IS
	BEGIN
			rcRecOfTab.COND_COMMER_SEGM_ID.delete;
			rcRecOfTab.ACRONYM.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.ACTIVE.delete;
			rcRecOfTab.TIME.delete;
			rcRecOfTab.PARAMETER.delete;
			rcRecOfTab.ORDER_EXE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CONDIT_COMMERC_SEGM  in out nocopy tytbLDC_CONDIT_COMMERC_SEGM,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CONDIT_COMMERC_SEGM);

		for n in itbLDC_CONDIT_COMMERC_SEGM.first .. itbLDC_CONDIT_COMMERC_SEGM.last loop
			rcRecOfTab.COND_COMMER_SEGM_ID(n) := itbLDC_CONDIT_COMMERC_SEGM(n).COND_COMMER_SEGM_ID;
			rcRecOfTab.ACRONYM(n) := itbLDC_CONDIT_COMMERC_SEGM(n).ACRONYM;
			rcRecOfTab.DESCRIPTION(n) := itbLDC_CONDIT_COMMERC_SEGM(n).DESCRIPTION;
			rcRecOfTab.ACTIVE(n) := itbLDC_CONDIT_COMMERC_SEGM(n).ACTIVE;
			rcRecOfTab.TIME(n) := itbLDC_CONDIT_COMMERC_SEGM(n).TIME;
			rcRecOfTab.PARAMETER(n) := itbLDC_CONDIT_COMMERC_SEGM(n).PARAMETER;
			rcRecOfTab.ORDER_EXE(n) := itbLDC_CONDIT_COMMERC_SEGM(n).ORDER_EXE;
			rcRecOfTab.row_id(n) := itbLDC_CONDIT_COMMERC_SEGM(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCOND_COMMER_SEGM_ID
		);

		fetch cuRecord into rcData;
		if cuRecord%notfound  then
			close cuRecord;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecord;
	END;
	PROCEDURE LoadByRowId
	(
		irirowid in varchar2
	)
	IS
		rcRecordNull cuRecordByRowId%rowtype;
	BEGIN
		if cuRecordByRowId%isopen then
			close cuRecordByRowId;
		end if;
		open cuRecordByRowId
		(
			irirowid
		);

		fetch cuRecordByRowId into rcData;
		if cuRecordByRowId%notfound  then
			close cuRecordByRowId;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecordByRowId;
	END;
	FUNCTION fblAlreadyLoaded
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCOND_COMMER_SEGM_ID = rcData.COND_COMMER_SEGM_ID
		   ) then
			return ( true );
		end if;
		return (false);
	END;

	/***** Fin metodos privados *****/

	/***** Metodos publicos ******/
    FUNCTION fsbVersion
    RETURN varchar2
	IS
	BEGIN
		return csbVersion;
	END;
	PROCEDURE ClearMemory
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		rcData := rcRecordNull;
	END;
	FUNCTION fblExist
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCOND_COMMER_SEGM_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN		rcError.COND_COMMER_SEGM_ID:=inuCOND_COMMER_SEGM_ID;

		Load
		(
			inuCOND_COMMER_SEGM_ID
		);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	)
	IS
	BEGIN
		LoadByRowId
		(
			iriRowID
		);
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE ValDuplicate
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCOND_COMMER_SEGM_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		orcRecord out nocopy styLDC_CONDIT_COMMERC_SEGM
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN		rcError.COND_COMMER_SEGM_ID:=inuCOND_COMMER_SEGM_ID;

		Load
		(
			inuCOND_COMMER_SEGM_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN styLDC_CONDIT_COMMERC_SEGM
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID:=inuCOND_COMMER_SEGM_ID;

		Load
		(
			inuCOND_COMMER_SEGM_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	)
	RETURN styLDC_CONDIT_COMMERC_SEGM
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID:=inuCOND_COMMER_SEGM_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCOND_COMMER_SEGM_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CONDIT_COMMERC_SEGM
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONDIT_COMMERC_SEGM
	)
	IS
		rfLDC_CONDIT_COMMERC_SEGM tyrfLDC_CONDIT_COMMERC_SEGM;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CONDIT_COMMERC_SEGM.*, LDC_CONDIT_COMMERC_SEGM.rowid FROM LDC_CONDIT_COMMERC_SEGM';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CONDIT_COMMERC_SEGM for sbFullQuery;

		fetch rfLDC_CONDIT_COMMERC_SEGM bulk collect INTO otbResult;

		close rfLDC_CONDIT_COMMERC_SEGM;
		if otbResult.count = 0  then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor
	IS
		rfQuery tyRefCursor;
		sbSQL VARCHAR2 (32000) := 'select LDC_CONDIT_COMMERC_SEGM.*, LDC_CONDIT_COMMERC_SEGM.rowid FROM LDC_CONDIT_COMMERC_SEGM';
	BEGIN
		if isbCriteria is not null then
			sbSQL := sbSQL||' where '||isbCriteria;
		end if;
		if iblLock then
			sbSQL := sbSQL||' for update nowait';
		end if;
		open rfQuery for sbSQL;
		return(rfQuery);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONDIT_COMMERC_SEGM in styLDC_CONDIT_COMMERC_SEGM
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CONDIT_COMMERC_SEGM,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONDIT_COMMERC_SEGM in styLDC_CONDIT_COMMERC_SEGM,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COND_COMMER_SEGM_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CONDIT_COMMERC_SEGM
		(
			COND_COMMER_SEGM_ID,
			ACRONYM,
			DESCRIPTION,
			ACTIVE,
			TIME,
			PARAMETER,
			ORDER_EXE
		)
		values
		(
			ircLDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID,
			ircLDC_CONDIT_COMMERC_SEGM.ACRONYM,
			ircLDC_CONDIT_COMMERC_SEGM.DESCRIPTION,
			ircLDC_CONDIT_COMMERC_SEGM.ACTIVE,
			ircLDC_CONDIT_COMMERC_SEGM.TIME,
			ircLDC_CONDIT_COMMERC_SEGM.PARAMETER,
			ircLDC_CONDIT_COMMERC_SEGM.ORDER_EXE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CONDIT_COMMERC_SEGM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CONDIT_COMMERC_SEGM in out nocopy tytbLDC_CONDIT_COMMERC_SEGM
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CONDIT_COMMERC_SEGM,blUseRowID);
		forall n in iotbLDC_CONDIT_COMMERC_SEGM.first..iotbLDC_CONDIT_COMMERC_SEGM.last
			insert into LDC_CONDIT_COMMERC_SEGM
			(
				COND_COMMER_SEGM_ID,
				ACRONYM,
				DESCRIPTION,
				ACTIVE,
				TIME,
				PARAMETER,
				ORDER_EXE
			)
			values
			(
				rcRecOfTab.COND_COMMER_SEGM_ID(n),
				rcRecOfTab.ACRONYM(n),
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.ACTIVE(n),
				rcRecOfTab.TIME(n),
				rcRecOfTab.PARAMETER(n),
				rcRecOfTab.ORDER_EXE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;


		delete
		from LDC_CONDIT_COMMERC_SEGM
		where
       		COND_COMMER_SEGM_ID=inuCOND_COMMER_SEGM_ID;
            if sql%notfound then
                raise no_data_found;
            end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
         raise ex.CONTROLLED_ERROR;
		when ex.RECORD_HAVE_CHILDREN then
			Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CONDIT_COMMERC_SEGM
		where
			rowid = iriRowID
		returning
			COND_COMMER_SEGM_ID
		into
			rcError.COND_COMMER_SEGM_ID;
            if sql%notfound then
			 raise no_data_found;
		    end if;
            if rcData.rowID=iriRowID then
			 rcData := rcRecordNull;
		    end if;
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
		when ex.RECORD_HAVE_CHILDREN then
            Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecords
	(
		iotbLDC_CONDIT_COMMERC_SEGM in out nocopy tytbLDC_CONDIT_COMMERC_SEGM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		FillRecordOfTables(iotbLDC_CONDIT_COMMERC_SEGM, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last
				delete
				from LDC_CONDIT_COMMERC_SEGM
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last loop
					LockByPk
					(
						rcRecOfTab.COND_COMMER_SEGM_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last
				delete
				from LDC_CONDIT_COMMERC_SEGM
				where
		         	COND_COMMER_SEGM_ID = rcRecOfTab.COND_COMMER_SEGM_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CONDIT_COMMERC_SEGM in styLDC_CONDIT_COMMERC_SEGM,
		inuLock in number default 0
	)
	IS
		nuCOND_COMMER_SEGM_ID	LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type;
	BEGIN
		if ircLDC_CONDIT_COMMERC_SEGM.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CONDIT_COMMERC_SEGM.rowid,rcData);
			end if;
			update LDC_CONDIT_COMMERC_SEGM
			set
				ACRONYM = ircLDC_CONDIT_COMMERC_SEGM.ACRONYM,
				DESCRIPTION = ircLDC_CONDIT_COMMERC_SEGM.DESCRIPTION,
				ACTIVE = ircLDC_CONDIT_COMMERC_SEGM.ACTIVE,
				TIME = ircLDC_CONDIT_COMMERC_SEGM.TIME,
				PARAMETER = ircLDC_CONDIT_COMMERC_SEGM.PARAMETER,
				ORDER_EXE = ircLDC_CONDIT_COMMERC_SEGM.ORDER_EXE
			where
				rowid = ircLDC_CONDIT_COMMERC_SEGM.rowid
			returning
				COND_COMMER_SEGM_ID
			into
				nuCOND_COMMER_SEGM_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID,
					rcData
				);
			end if;

			update LDC_CONDIT_COMMERC_SEGM
			set
				ACRONYM = ircLDC_CONDIT_COMMERC_SEGM.ACRONYM,
				DESCRIPTION = ircLDC_CONDIT_COMMERC_SEGM.DESCRIPTION,
				ACTIVE = ircLDC_CONDIT_COMMERC_SEGM.ACTIVE,
				TIME = ircLDC_CONDIT_COMMERC_SEGM.TIME,
				PARAMETER = ircLDC_CONDIT_COMMERC_SEGM.PARAMETER,
				ORDER_EXE = ircLDC_CONDIT_COMMERC_SEGM.ORDER_EXE
			where
				COND_COMMER_SEGM_ID = ircLDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID
			returning
				COND_COMMER_SEGM_ID
			into
				nuCOND_COMMER_SEGM_ID;
		end if;
		if
			nuCOND_COMMER_SEGM_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CONDIT_COMMERC_SEGM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CONDIT_COMMERC_SEGM in out nocopy tytbLDC_CONDIT_COMMERC_SEGM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		FillRecordOfTables(iotbLDC_CONDIT_COMMERC_SEGM,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last
				update LDC_CONDIT_COMMERC_SEGM
				set
					ACRONYM = rcRecOfTab.ACRONYM(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ACTIVE = rcRecOfTab.ACTIVE(n),
					TIME = rcRecOfTab.TIME(n),
					PARAMETER = rcRecOfTab.PARAMETER(n),
					ORDER_EXE = rcRecOfTab.ORDER_EXE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last loop
					LockByPk
					(
						rcRecOfTab.COND_COMMER_SEGM_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDIT_COMMERC_SEGM.first .. iotbLDC_CONDIT_COMMERC_SEGM.last
				update LDC_CONDIT_COMMERC_SEGM
				SET
					ACRONYM = rcRecOfTab.ACRONYM(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ACTIVE = rcRecOfTab.ACTIVE(n),
					TIME = rcRecOfTab.TIME(n),
					PARAMETER = rcRecOfTab.PARAMETER(n),
					ORDER_EXE = rcRecOfTab.ORDER_EXE(n)
				where
					COND_COMMER_SEGM_ID = rcRecOfTab.COND_COMMER_SEGM_ID(n)
;
		end if;
	END;
	PROCEDURE updACRONYM
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbACRONYM$ in LDC_CONDIT_COMMERC_SEGM.ACRONYM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;

		update LDC_CONDIT_COMMERC_SEGM
		set
			ACRONYM = isbACRONYM$
		where
			COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACRONYM:= isbACRONYM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbDESCRIPTION$ in LDC_CONDIT_COMMERC_SEGM.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;

		update LDC_CONDIT_COMMERC_SEGM
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbACTIVE$ in LDC_CONDIT_COMMERC_SEGM.ACTIVE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;

		update LDC_CONDIT_COMMERC_SEGM
		set
			ACTIVE = isbACTIVE$
		where
			COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVE:= isbACTIVE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIME
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbTIME$ in LDC_CONDIT_COMMERC_SEGM.TIME%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;

		update LDC_CONDIT_COMMERC_SEGM
		set
			TIME = isbTIME$
		where
			COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIME:= isbTIME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPARAMETER
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		isbPARAMETER$ in LDC_CONDIT_COMMERC_SEGM.PARAMETER%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;

		update LDC_CONDIT_COMMERC_SEGM
		set
			PARAMETER = isbPARAMETER$
		where
			COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PARAMETER:= isbPARAMETER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_EXE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuORDER_EXE$ in LDC_CONDIT_COMMERC_SEGM.ORDER_EXE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN
		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOND_COMMER_SEGM_ID,
				rcData
			);
		end if;

		update LDC_CONDIT_COMMERC_SEGM
		set
			ORDER_EXE = inuORDER_EXE$
		where
			COND_COMMER_SEGM_ID = inuCOND_COMMER_SEGM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_EXE:= inuORDER_EXE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOND_COMMER_SEGM_ID
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.COND_COMMER_SEGM_ID);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.COND_COMMER_SEGM_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetACRONYM
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.ACRONYM%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.ACRONYM);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.ACRONYM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.DESCRIPTION%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.DESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetACTIVE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.ACTIVE%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.ACTIVE);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.ACTIVE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTIME
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.TIME%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.TIME);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.TIME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPARAMETER
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.PARAMETER%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.PARAMETER);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.PARAMETER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_EXE
	(
		inuCOND_COMMER_SEGM_ID in LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDIT_COMMERC_SEGM.ORDER_EXE%type
	IS
		rcError styLDC_CONDIT_COMMERC_SEGM;
	BEGIN

		rcError.COND_COMMER_SEGM_ID := inuCOND_COMMER_SEGM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOND_COMMER_SEGM_ID
			 )
		then
			 return(rcData.ORDER_EXE);
		end if;
		Load
		(
		 		inuCOND_COMMER_SEGM_ID
		);
		return(rcData.ORDER_EXE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_CONDIT_COMMERC_SEGM;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CONDIT_COMMERC_SEGM
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CONDIT_COMMERC_SEGM', 'ADM_PERSON'); 
END;
/
