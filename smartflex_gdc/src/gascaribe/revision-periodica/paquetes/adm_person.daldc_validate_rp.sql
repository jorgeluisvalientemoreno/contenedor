CREATE OR REPLACE PACKAGE adm_person.daldc_validate_rp
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	IS
		SELECT LDC_VALIDATE_RP.*,LDC_VALIDATE_RP.rowid
		FROM LDC_VALIDATE_RP
		WHERE
		    VALIDATE_RP_ID = inuVALIDATE_RP_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VALIDATE_RP.*,LDC_VALIDATE_RP.rowid
		FROM LDC_VALIDATE_RP
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VALIDATE_RP  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VALIDATE_RP is table of styLDC_VALIDATE_RP index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VALIDATE_RP;

	/* Tipos referenciando al registro */
	type tytbVALIDATE_RP_ID is table of LDC_VALIDATE_RP.VALIDATE_RP_ID%type index by binary_integer;
	type tytbCAUSAL_ID is table of LDC_VALIDATE_RP.CAUSAL_ID%type index by binary_integer;
	type tytbDEFECT is table of LDC_VALIDATE_RP.DEFECT%type index by binary_integer;
	type tytbCRITICAL_DEFECT is table of LDC_VALIDATE_RP.CRITICAL_DEFECT%type index by binary_integer;
	type tytbGAS_APPLIANCE is table of LDC_VALIDATE_RP.GAS_APPLIANCE%type index by binary_integer;
	type tytbRESULT_RP is table of LDC_VALIDATE_RP.RESULT_RP%type index by binary_integer;
	type tytbITEM_ID is table of LDC_VALIDATE_RP.ITEM_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VALIDATE_RP is record
	(
		VALIDATE_RP_ID   tytbVALIDATE_RP_ID,
		CAUSAL_ID   tytbCAUSAL_ID,
		DEFECT   tytbDEFECT,
		CRITICAL_DEFECT   tytbCRITICAL_DEFECT,
		GAS_APPLIANCE   tytbGAS_APPLIANCE,
		RESULT_RP   tytbRESULT_RP,
		ITEM_ID   tytbITEM_ID,
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
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	);

	PROCEDURE getRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		orcRecord out nocopy styLDC_VALIDATE_RP
	);

	FUNCTION frcGetRcData
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN styLDC_VALIDATE_RP;

	FUNCTION frcGetRcData
	RETURN styLDC_VALIDATE_RP;

	FUNCTION frcGetRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN styLDC_VALIDATE_RP;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VALIDATE_RP
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VALIDATE_RP in styLDC_VALIDATE_RP
	);

	PROCEDURE insRecord
	(
		ircLDC_VALIDATE_RP in styLDC_VALIDATE_RP,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VALIDATE_RP in out nocopy tytbLDC_VALIDATE_RP
	);

	PROCEDURE delRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VALIDATE_RP in out nocopy tytbLDC_VALIDATE_RP,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VALIDATE_RP in styLDC_VALIDATE_RP,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VALIDATE_RP in out nocopy tytbLDC_VALIDATE_RP,
		inuLock in number default 1
	);

	PROCEDURE updCAUSAL_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuCAUSAL_ID$ in LDC_VALIDATE_RP.CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbDEFECT$ in LDC_VALIDATE_RP.DEFECT%type,
		inuLock in number default 0
	);

	PROCEDURE updCRITICAL_DEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbCRITICAL_DEFECT$ in LDC_VALIDATE_RP.CRITICAL_DEFECT%type,
		inuLock in number default 0
	);

	PROCEDURE updGAS_APPLIANCE
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbGAS_APPLIANCE$ in LDC_VALIDATE_RP.GAS_APPLIANCE%type,
		inuLock in number default 0
	);

	PROCEDURE updRESULT_RP
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbRESULT_RP$ in LDC_VALIDATE_RP.RESULT_RP%type,
		inuLock in number default 0
	);

	PROCEDURE updITEM_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuITEM_ID$ in LDC_VALIDATE_RP.ITEM_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetVALIDATE_RP_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.VALIDATE_RP_ID%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.CAUSAL_ID%type;

	FUNCTION fsbGetDEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.DEFECT%type;

	FUNCTION fsbGetCRITICAL_DEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.CRITICAL_DEFECT%type;

	FUNCTION fsbGetGAS_APPLIANCE
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.GAS_APPLIANCE%type;

	FUNCTION fsbGetRESULT_RP
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.RESULT_RP%type;

	FUNCTION fnuGetITEM_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.ITEM_ID%type;


	PROCEDURE LockByPk
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		orcLDC_VALIDATE_RP  out styLDC_VALIDATE_RP
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VALIDATE_RP  out styLDC_VALIDATE_RP
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VALIDATE_RP;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_VALIDATE_RP
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VALIDATE_RP';
	 cnuGeEntityId constant varchar2(30) := 8791; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	IS
		SELECT LDC_VALIDATE_RP.*,LDC_VALIDATE_RP.rowid
		FROM LDC_VALIDATE_RP
		WHERE  VALIDATE_RP_ID = inuVALIDATE_RP_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VALIDATE_RP.*,LDC_VALIDATE_RP.rowid
		FROM LDC_VALIDATE_RP
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VALIDATE_RP is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VALIDATE_RP;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VALIDATE_RP default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.VALIDATE_RP_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		orcLDC_VALIDATE_RP  out styLDC_VALIDATE_RP
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

		Open cuLockRcByPk
		(
			inuVALIDATE_RP_ID
		);

		fetch cuLockRcByPk into orcLDC_VALIDATE_RP;
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
		orcLDC_VALIDATE_RP  out styLDC_VALIDATE_RP
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VALIDATE_RP;
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
		itbLDC_VALIDATE_RP  in out nocopy tytbLDC_VALIDATE_RP
	)
	IS
	BEGIN
			rcRecOfTab.VALIDATE_RP_ID.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.DEFECT.delete;
			rcRecOfTab.CRITICAL_DEFECT.delete;
			rcRecOfTab.GAS_APPLIANCE.delete;
			rcRecOfTab.RESULT_RP.delete;
			rcRecOfTab.ITEM_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VALIDATE_RP  in out nocopy tytbLDC_VALIDATE_RP,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VALIDATE_RP);

		for n in itbLDC_VALIDATE_RP.first .. itbLDC_VALIDATE_RP.last loop
			rcRecOfTab.VALIDATE_RP_ID(n) := itbLDC_VALIDATE_RP(n).VALIDATE_RP_ID;
			rcRecOfTab.CAUSAL_ID(n) := itbLDC_VALIDATE_RP(n).CAUSAL_ID;
			rcRecOfTab.DEFECT(n) := itbLDC_VALIDATE_RP(n).DEFECT;
			rcRecOfTab.CRITICAL_DEFECT(n) := itbLDC_VALIDATE_RP(n).CRITICAL_DEFECT;
			rcRecOfTab.GAS_APPLIANCE(n) := itbLDC_VALIDATE_RP(n).GAS_APPLIANCE;
			rcRecOfTab.RESULT_RP(n) := itbLDC_VALIDATE_RP(n).RESULT_RP;
			rcRecOfTab.ITEM_ID(n) := itbLDC_VALIDATE_RP(n).ITEM_ID;
			rcRecOfTab.row_id(n) := itbLDC_VALIDATE_RP(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuVALIDATE_RP_ID
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
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuVALIDATE_RP_ID = rcData.VALIDATE_RP_ID
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
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuVALIDATE_RP_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN		rcError.VALIDATE_RP_ID:=inuVALIDATE_RP_ID;

		Load
		(
			inuVALIDATE_RP_ID
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
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuVALIDATE_RP_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		orcRecord out nocopy styLDC_VALIDATE_RP
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN		rcError.VALIDATE_RP_ID:=inuVALIDATE_RP_ID;

		Load
		(
			inuVALIDATE_RP_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN styLDC_VALIDATE_RP
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID:=inuVALIDATE_RP_ID;

		Load
		(
			inuVALIDATE_RP_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	)
	RETURN styLDC_VALIDATE_RP
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID:=inuVALIDATE_RP_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuVALIDATE_RP_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuVALIDATE_RP_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VALIDATE_RP
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VALIDATE_RP
	)
	IS
		rfLDC_VALIDATE_RP tyrfLDC_VALIDATE_RP;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VALIDATE_RP.*, LDC_VALIDATE_RP.rowid FROM LDC_VALIDATE_RP';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VALIDATE_RP for sbFullQuery;

		fetch rfLDC_VALIDATE_RP bulk collect INTO otbResult;

		close rfLDC_VALIDATE_RP;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VALIDATE_RP.*, LDC_VALIDATE_RP.rowid FROM LDC_VALIDATE_RP';
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
		ircLDC_VALIDATE_RP in styLDC_VALIDATE_RP
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VALIDATE_RP,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VALIDATE_RP in styLDC_VALIDATE_RP,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VALIDATE_RP.VALIDATE_RP_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|VALIDATE_RP_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_VALIDATE_RP
		(
			VALIDATE_RP_ID,
			CAUSAL_ID,
			DEFECT,
			CRITICAL_DEFECT,
			GAS_APPLIANCE,
			RESULT_RP,
			ITEM_ID
		)
		values
		(
			ircLDC_VALIDATE_RP.VALIDATE_RP_ID,
			ircLDC_VALIDATE_RP.CAUSAL_ID,
			ircLDC_VALIDATE_RP.DEFECT,
			ircLDC_VALIDATE_RP.CRITICAL_DEFECT,
			ircLDC_VALIDATE_RP.GAS_APPLIANCE,
			ircLDC_VALIDATE_RP.RESULT_RP,
			ircLDC_VALIDATE_RP.ITEM_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VALIDATE_RP));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VALIDATE_RP in out nocopy tytbLDC_VALIDATE_RP
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VALIDATE_RP,blUseRowID);
		forall n in iotbLDC_VALIDATE_RP.first..iotbLDC_VALIDATE_RP.last
			insert into LDC_VALIDATE_RP
			(
				VALIDATE_RP_ID,
				CAUSAL_ID,
				DEFECT,
				CRITICAL_DEFECT,
				GAS_APPLIANCE,
				RESULT_RP,
				ITEM_ID
			)
			values
			(
				rcRecOfTab.VALIDATE_RP_ID(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.DEFECT(n),
				rcRecOfTab.CRITICAL_DEFECT(n),
				rcRecOfTab.GAS_APPLIANCE(n),
				rcRecOfTab.RESULT_RP(n),
				rcRecOfTab.ITEM_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;


		delete
		from LDC_VALIDATE_RP
		where
       		VALIDATE_RP_ID=inuVALIDATE_RP_ID;
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
		rcError  styLDC_VALIDATE_RP;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VALIDATE_RP
		where
			rowid = iriRowID
		returning
			VALIDATE_RP_ID
		into
			rcError.VALIDATE_RP_ID;
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
		iotbLDC_VALIDATE_RP in out nocopy tytbLDC_VALIDATE_RP,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VALIDATE_RP;
	BEGIN
		FillRecordOfTables(iotbLDC_VALIDATE_RP, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last
				delete
				from LDC_VALIDATE_RP
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last loop
					LockByPk
					(
						rcRecOfTab.VALIDATE_RP_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last
				delete
				from LDC_VALIDATE_RP
				where
		         	VALIDATE_RP_ID = rcRecOfTab.VALIDATE_RP_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VALIDATE_RP in styLDC_VALIDATE_RP,
		inuLock in number default 0
	)
	IS
		nuVALIDATE_RP_ID	LDC_VALIDATE_RP.VALIDATE_RP_ID%type;
	BEGIN
		if ircLDC_VALIDATE_RP.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VALIDATE_RP.rowid,rcData);
			end if;
			update LDC_VALIDATE_RP
			set
				CAUSAL_ID = ircLDC_VALIDATE_RP.CAUSAL_ID,
				DEFECT = ircLDC_VALIDATE_RP.DEFECT,
				CRITICAL_DEFECT = ircLDC_VALIDATE_RP.CRITICAL_DEFECT,
				GAS_APPLIANCE = ircLDC_VALIDATE_RP.GAS_APPLIANCE,
				RESULT_RP = ircLDC_VALIDATE_RP.RESULT_RP,
				ITEM_ID = ircLDC_VALIDATE_RP.ITEM_ID
			where
				rowid = ircLDC_VALIDATE_RP.rowid
			returning
				VALIDATE_RP_ID
			into
				nuVALIDATE_RP_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VALIDATE_RP.VALIDATE_RP_ID,
					rcData
				);
			end if;

			update LDC_VALIDATE_RP
			set
				CAUSAL_ID = ircLDC_VALIDATE_RP.CAUSAL_ID,
				DEFECT = ircLDC_VALIDATE_RP.DEFECT,
				CRITICAL_DEFECT = ircLDC_VALIDATE_RP.CRITICAL_DEFECT,
				GAS_APPLIANCE = ircLDC_VALIDATE_RP.GAS_APPLIANCE,
				RESULT_RP = ircLDC_VALIDATE_RP.RESULT_RP,
				ITEM_ID = ircLDC_VALIDATE_RP.ITEM_ID
			where
				VALIDATE_RP_ID = ircLDC_VALIDATE_RP.VALIDATE_RP_ID
			returning
				VALIDATE_RP_ID
			into
				nuVALIDATE_RP_ID;
		end if;
		if
			nuVALIDATE_RP_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VALIDATE_RP));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VALIDATE_RP in out nocopy tytbLDC_VALIDATE_RP,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VALIDATE_RP;
	BEGIN
		FillRecordOfTables(iotbLDC_VALIDATE_RP,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last
				update LDC_VALIDATE_RP
				set
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					DEFECT = rcRecOfTab.DEFECT(n),
					CRITICAL_DEFECT = rcRecOfTab.CRITICAL_DEFECT(n),
					GAS_APPLIANCE = rcRecOfTab.GAS_APPLIANCE(n),
					RESULT_RP = rcRecOfTab.RESULT_RP(n),
					ITEM_ID = rcRecOfTab.ITEM_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last loop
					LockByPk
					(
						rcRecOfTab.VALIDATE_RP_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDATE_RP.first .. iotbLDC_VALIDATE_RP.last
				update LDC_VALIDATE_RP
				SET
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					DEFECT = rcRecOfTab.DEFECT(n),
					CRITICAL_DEFECT = rcRecOfTab.CRITICAL_DEFECT(n),
					GAS_APPLIANCE = rcRecOfTab.GAS_APPLIANCE(n),
					RESULT_RP = rcRecOfTab.RESULT_RP(n),
					ITEM_ID = rcRecOfTab.ITEM_ID(n)
				where
					VALIDATE_RP_ID = rcRecOfTab.VALIDATE_RP_ID(n)
;
		end if;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuCAUSAL_ID$ in LDC_VALIDATE_RP.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;

		update LDC_VALIDATE_RP
		set
			CAUSAL_ID = inuCAUSAL_ID$
		where
			VALIDATE_RP_ID = inuVALIDATE_RP_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbDEFECT$ in LDC_VALIDATE_RP.DEFECT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;

		update LDC_VALIDATE_RP
		set
			DEFECT = isbDEFECT$
		where
			VALIDATE_RP_ID = inuVALIDATE_RP_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEFECT:= isbDEFECT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCRITICAL_DEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbCRITICAL_DEFECT$ in LDC_VALIDATE_RP.CRITICAL_DEFECT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;

		update LDC_VALIDATE_RP
		set
			CRITICAL_DEFECT = isbCRITICAL_DEFECT$
		where
			VALIDATE_RP_ID = inuVALIDATE_RP_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CRITICAL_DEFECT:= isbCRITICAL_DEFECT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGAS_APPLIANCE
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbGAS_APPLIANCE$ in LDC_VALIDATE_RP.GAS_APPLIANCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;

		update LDC_VALIDATE_RP
		set
			GAS_APPLIANCE = isbGAS_APPLIANCE$
		where
			VALIDATE_RP_ID = inuVALIDATE_RP_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GAS_APPLIANCE:= isbGAS_APPLIANCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESULT_RP
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		isbRESULT_RP$ in LDC_VALIDATE_RP.RESULT_RP%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;

		update LDC_VALIDATE_RP
		set
			RESULT_RP = isbRESULT_RP$
		where
			VALIDATE_RP_ID = inuVALIDATE_RP_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESULT_RP:= isbRESULT_RP$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEM_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuITEM_ID$ in LDC_VALIDATE_RP.ITEM_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN
		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDATE_RP_ID,
				rcData
			);
		end if;

		update LDC_VALIDATE_RP
		set
			ITEM_ID = inuITEM_ID$
		where
			VALIDATE_RP_ID = inuVALIDATE_RP_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_ID:= inuITEM_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetVALIDATE_RP_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.VALIDATE_RP_ID%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.VALIDATE_RP_ID);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.VALIDATE_RP_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.CAUSAL_ID%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.CAUSAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.DEFECT%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.DEFECT);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.DEFECT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCRITICAL_DEFECT
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.CRITICAL_DEFECT%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.CRITICAL_DEFECT);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.CRITICAL_DEFECT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetGAS_APPLIANCE
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.GAS_APPLIANCE%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.GAS_APPLIANCE);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.GAS_APPLIANCE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESULT_RP
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.RESULT_RP%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.RESULT_RP);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.RESULT_RP);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITEM_ID
	(
		inuVALIDATE_RP_ID in LDC_VALIDATE_RP.VALIDATE_RP_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDATE_RP.ITEM_ID%type
	IS
		rcError styLDC_VALIDATE_RP;
	BEGIN

		rcError.VALIDATE_RP_ID := inuVALIDATE_RP_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDATE_RP_ID
			 )
		then
			 return(rcData.ITEM_ID);
		end if;
		Load
		(
		 		inuVALIDATE_RP_ID
		);
		return(rcData.ITEM_ID);
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
end DALDC_VALIDATE_RP;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_VALIDATE_RP
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_VALIDATE_RP', 'ADM_PERSON'); 
END;
/
