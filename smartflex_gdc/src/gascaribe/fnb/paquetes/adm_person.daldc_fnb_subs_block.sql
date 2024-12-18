CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_FNB_SUBS_BLOCK
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    04/05/2024              PAcosta         OSF-2776: Cambio de esquema ADM_PERSON                              
    ****************************************************************/
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	IS
		SELECT LDC_FNB_SUBS_BLOCK.*,LDC_FNB_SUBS_BLOCK.rowid
		FROM LDC_FNB_SUBS_BLOCK
		WHERE
		    USER_BLOCK_ID = inuUSER_BLOCK_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_FNB_SUBS_BLOCK.*,LDC_FNB_SUBS_BLOCK.rowid
		FROM LDC_FNB_SUBS_BLOCK
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_FNB_SUBS_BLOCK  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_FNB_SUBS_BLOCK is table of styLDC_FNB_SUBS_BLOCK index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_FNB_SUBS_BLOCK;

	/* Tipos referenciando al registro */
	type tytbUSER_BLOCK_ID is table of LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbOBSERVATION is table of LDC_FNB_SUBS_BLOCK.OBSERVATION%type index by binary_integer;
	type tytbBLOCK is table of LDC_FNB_SUBS_BLOCK.BLOCK%type index by binary_integer;
	type tytbIDENTIFICATION is table of LDC_FNB_SUBS_BLOCK.IDENTIFICATION%type index by binary_integer;
	type tytbIDENT_TYPE_ID is table of LDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_FNB_SUBS_BLOCK is record
	(
		USER_BLOCK_ID   tytbUSER_BLOCK_ID,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		OBSERVATION   tytbOBSERVATION,
		BLOCK   tytbBLOCK,
		IDENTIFICATION   tytbIDENTIFICATION,
		IDENT_TYPE_ID   tytbIDENT_TYPE_ID,
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
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	);

	PROCEDURE getRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		orcRecord out nocopy styLDC_FNB_SUBS_BLOCK
	);

	FUNCTION frcGetRcData
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN styLDC_FNB_SUBS_BLOCK;

	FUNCTION frcGetRcData
	RETURN styLDC_FNB_SUBS_BLOCK;

	FUNCTION frcGetRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN styLDC_FNB_SUBS_BLOCK;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FNB_SUBS_BLOCK
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_FNB_SUBS_BLOCK in styLDC_FNB_SUBS_BLOCK
	);

	PROCEDURE insRecord
	(
		ircLDC_FNB_SUBS_BLOCK in styLDC_FNB_SUBS_BLOCK,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_FNB_SUBS_BLOCK in out nocopy tytbLDC_FNB_SUBS_BLOCK
	);

	PROCEDURE delRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_FNB_SUBS_BLOCK in out nocopy tytbLDC_FNB_SUBS_BLOCK,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_FNB_SUBS_BLOCK in styLDC_FNB_SUBS_BLOCK,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_FNB_SUBS_BLOCK in out nocopy tytbLDC_FNB_SUBS_BLOCK,
		inuLock in number default 1
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		isbOBSERVATION$ in LDC_FNB_SUBS_BLOCK.OBSERVATION%type,
		inuLock in number default 0
	);

	PROCEDURE updBLOCK
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		isbBLOCK$ in LDC_FNB_SUBS_BLOCK.BLOCK%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENTIFICATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		isbIDENTIFICATION$ in LDC_FNB_SUBS_BLOCK.IDENTIFICATION%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENT_TYPE_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuIDENT_TYPE_ID$ in LDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetUSER_BLOCK_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID%type;

	FUNCTION fsbGetOBSERVATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.OBSERVATION%type;

	FUNCTION fsbGetBLOCK
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.BLOCK%type;

	FUNCTION fsbGetIDENTIFICATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.IDENTIFICATION%type;

	FUNCTION fnuGetIDENT_TYPE_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID%type;


	PROCEDURE LockByPk
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		orcLDC_FNB_SUBS_BLOCK  out styLDC_FNB_SUBS_BLOCK
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_FNB_SUBS_BLOCK  out styLDC_FNB_SUBS_BLOCK
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_FNB_SUBS_BLOCK;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_FNB_SUBS_BLOCK
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_FNB_SUBS_BLOCK';
	 cnuGeEntityId constant varchar2(30) := 2397; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	IS
		SELECT LDC_FNB_SUBS_BLOCK.*,LDC_FNB_SUBS_BLOCK.rowid
		FROM LDC_FNB_SUBS_BLOCK
		WHERE  USER_BLOCK_ID = inuUSER_BLOCK_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_FNB_SUBS_BLOCK.*,LDC_FNB_SUBS_BLOCK.rowid
		FROM LDC_FNB_SUBS_BLOCK
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_FNB_SUBS_BLOCK is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_FNB_SUBS_BLOCK;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_FNB_SUBS_BLOCK default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.USER_BLOCK_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		orcLDC_FNB_SUBS_BLOCK  out styLDC_FNB_SUBS_BLOCK
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

		Open cuLockRcByPk
		(
			inuUSER_BLOCK_ID
		);

		fetch cuLockRcByPk into orcLDC_FNB_SUBS_BLOCK;
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
		orcLDC_FNB_SUBS_BLOCK  out styLDC_FNB_SUBS_BLOCK
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_FNB_SUBS_BLOCK;
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
		itbLDC_FNB_SUBS_BLOCK  in out nocopy tytbLDC_FNB_SUBS_BLOCK
	)
	IS
	BEGIN
			rcRecOfTab.USER_BLOCK_ID.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.OBSERVATION.delete;
			rcRecOfTab.BLOCK.delete;
			rcRecOfTab.IDENTIFICATION.delete;
			rcRecOfTab.IDENT_TYPE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_FNB_SUBS_BLOCK  in out nocopy tytbLDC_FNB_SUBS_BLOCK,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_FNB_SUBS_BLOCK);

		for n in itbLDC_FNB_SUBS_BLOCK.first .. itbLDC_FNB_SUBS_BLOCK.last loop
			rcRecOfTab.USER_BLOCK_ID(n) := itbLDC_FNB_SUBS_BLOCK(n).USER_BLOCK_ID;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLDC_FNB_SUBS_BLOCK(n).SUBSCRIPTION_ID;
			rcRecOfTab.OBSERVATION(n) := itbLDC_FNB_SUBS_BLOCK(n).OBSERVATION;
			rcRecOfTab.BLOCK(n) := itbLDC_FNB_SUBS_BLOCK(n).BLOCK;
			rcRecOfTab.IDENTIFICATION(n) := itbLDC_FNB_SUBS_BLOCK(n).IDENTIFICATION;
			rcRecOfTab.IDENT_TYPE_ID(n) := itbLDC_FNB_SUBS_BLOCK(n).IDENT_TYPE_ID;
			rcRecOfTab.row_id(n) := itbLDC_FNB_SUBS_BLOCK(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuUSER_BLOCK_ID
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
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuUSER_BLOCK_ID = rcData.USER_BLOCK_ID
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
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuUSER_BLOCK_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN		rcError.USER_BLOCK_ID:=inuUSER_BLOCK_ID;

		Load
		(
			inuUSER_BLOCK_ID
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
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuUSER_BLOCK_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		orcRecord out nocopy styLDC_FNB_SUBS_BLOCK
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN		rcError.USER_BLOCK_ID:=inuUSER_BLOCK_ID;

		Load
		(
			inuUSER_BLOCK_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN styLDC_FNB_SUBS_BLOCK
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID:=inuUSER_BLOCK_ID;

		Load
		(
			inuUSER_BLOCK_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	)
	RETURN styLDC_FNB_SUBS_BLOCK
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID:=inuUSER_BLOCK_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuUSER_BLOCK_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuUSER_BLOCK_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_FNB_SUBS_BLOCK
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FNB_SUBS_BLOCK
	)
	IS
		rfLDC_FNB_SUBS_BLOCK tyrfLDC_FNB_SUBS_BLOCK;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_FNB_SUBS_BLOCK.*, LDC_FNB_SUBS_BLOCK.rowid FROM LDC_FNB_SUBS_BLOCK';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_FNB_SUBS_BLOCK for sbFullQuery;

		fetch rfLDC_FNB_SUBS_BLOCK bulk collect INTO otbResult;

		close rfLDC_FNB_SUBS_BLOCK;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_FNB_SUBS_BLOCK.*, LDC_FNB_SUBS_BLOCK.rowid FROM LDC_FNB_SUBS_BLOCK';
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
		ircLDC_FNB_SUBS_BLOCK in styLDC_FNB_SUBS_BLOCK
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_FNB_SUBS_BLOCK,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_FNB_SUBS_BLOCK in styLDC_FNB_SUBS_BLOCK,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_FNB_SUBS_BLOCK.USER_BLOCK_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|USER_BLOCK_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_FNB_SUBS_BLOCK
		(
			USER_BLOCK_ID,
			SUBSCRIPTION_ID,
			OBSERVATION,
			BLOCK,
			IDENTIFICATION,
			IDENT_TYPE_ID
		)
		values
		(
			ircLDC_FNB_SUBS_BLOCK.USER_BLOCK_ID,
			ircLDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID,
			ircLDC_FNB_SUBS_BLOCK.OBSERVATION,
			ircLDC_FNB_SUBS_BLOCK.BLOCK,
			ircLDC_FNB_SUBS_BLOCK.IDENTIFICATION,
			ircLDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_FNB_SUBS_BLOCK));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_FNB_SUBS_BLOCK in out nocopy tytbLDC_FNB_SUBS_BLOCK
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_SUBS_BLOCK,blUseRowID);
		forall n in iotbLDC_FNB_SUBS_BLOCK.first..iotbLDC_FNB_SUBS_BLOCK.last
			insert into LDC_FNB_SUBS_BLOCK
			(
				USER_BLOCK_ID,
				SUBSCRIPTION_ID,
				OBSERVATION,
				BLOCK,
				IDENTIFICATION,
				IDENT_TYPE_ID
			)
			values
			(
				rcRecOfTab.USER_BLOCK_ID(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.OBSERVATION(n),
				rcRecOfTab.BLOCK(n),
				rcRecOfTab.IDENTIFICATION(n),
				rcRecOfTab.IDENT_TYPE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

		if inuLock=1 then
			LockByPk
			(
				inuUSER_BLOCK_ID,
				rcData
			);
		end if;


		delete
		from LDC_FNB_SUBS_BLOCK
		where
       		USER_BLOCK_ID=inuUSER_BLOCK_ID;
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
		rcError  styLDC_FNB_SUBS_BLOCK;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_FNB_SUBS_BLOCK
		where
			rowid = iriRowID
		returning
			USER_BLOCK_ID
		into
			rcError.USER_BLOCK_ID;
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
		iotbLDC_FNB_SUBS_BLOCK in out nocopy tytbLDC_FNB_SUBS_BLOCK,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FNB_SUBS_BLOCK;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_SUBS_BLOCK, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last
				delete
				from LDC_FNB_SUBS_BLOCK
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last loop
					LockByPk
					(
						rcRecOfTab.USER_BLOCK_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last
				delete
				from LDC_FNB_SUBS_BLOCK
				where
		         	USER_BLOCK_ID = rcRecOfTab.USER_BLOCK_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_FNB_SUBS_BLOCK in styLDC_FNB_SUBS_BLOCK,
		inuLock in number default 0
	)
	IS
		nuUSER_BLOCK_ID	LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type;
	BEGIN
		if ircLDC_FNB_SUBS_BLOCK.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_FNB_SUBS_BLOCK.rowid,rcData);
			end if;
			update LDC_FNB_SUBS_BLOCK
			set
				SUBSCRIPTION_ID = ircLDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID,
				OBSERVATION = ircLDC_FNB_SUBS_BLOCK.OBSERVATION,
				BLOCK = ircLDC_FNB_SUBS_BLOCK.BLOCK,
				IDENTIFICATION = ircLDC_FNB_SUBS_BLOCK.IDENTIFICATION,
				IDENT_TYPE_ID = ircLDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID
			where
				rowid = ircLDC_FNB_SUBS_BLOCK.rowid
			returning
				USER_BLOCK_ID
			into
				nuUSER_BLOCK_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_FNB_SUBS_BLOCK.USER_BLOCK_ID,
					rcData
				);
			end if;

			update LDC_FNB_SUBS_BLOCK
			set
				SUBSCRIPTION_ID = ircLDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID,
				OBSERVATION = ircLDC_FNB_SUBS_BLOCK.OBSERVATION,
				BLOCK = ircLDC_FNB_SUBS_BLOCK.BLOCK,
				IDENTIFICATION = ircLDC_FNB_SUBS_BLOCK.IDENTIFICATION,
				IDENT_TYPE_ID = ircLDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID
			where
				USER_BLOCK_ID = ircLDC_FNB_SUBS_BLOCK.USER_BLOCK_ID
			returning
				USER_BLOCK_ID
			into
				nuUSER_BLOCK_ID;
		end if;
		if
			nuUSER_BLOCK_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_FNB_SUBS_BLOCK));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_FNB_SUBS_BLOCK in out nocopy tytbLDC_FNB_SUBS_BLOCK,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FNB_SUBS_BLOCK;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_SUBS_BLOCK,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last
				update LDC_FNB_SUBS_BLOCK
				set
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					OBSERVATION = rcRecOfTab.OBSERVATION(n),
					BLOCK = rcRecOfTab.BLOCK(n),
					IDENTIFICATION = rcRecOfTab.IDENTIFICATION(n),
					IDENT_TYPE_ID = rcRecOfTab.IDENT_TYPE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last loop
					LockByPk
					(
						rcRecOfTab.USER_BLOCK_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_SUBS_BLOCK.first .. iotbLDC_FNB_SUBS_BLOCK.last
				update LDC_FNB_SUBS_BLOCK
				SET
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					OBSERVATION = rcRecOfTab.OBSERVATION(n),
					BLOCK = rcRecOfTab.BLOCK(n),
					IDENTIFICATION = rcRecOfTab.IDENTIFICATION(n),
					IDENT_TYPE_ID = rcRecOfTab.IDENT_TYPE_ID(n)
				where
					USER_BLOCK_ID = rcRecOfTab.USER_BLOCK_ID(n)
;
		end if;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;
		if inuLock=1 then
			LockByPk
			(
				inuUSER_BLOCK_ID,
				rcData
			);
		end if;

		update LDC_FNB_SUBS_BLOCK
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			USER_BLOCK_ID = inuUSER_BLOCK_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		isbOBSERVATION$ in LDC_FNB_SUBS_BLOCK.OBSERVATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;
		if inuLock=1 then
			LockByPk
			(
				inuUSER_BLOCK_ID,
				rcData
			);
		end if;

		update LDC_FNB_SUBS_BLOCK
		set
			OBSERVATION = isbOBSERVATION$
		where
			USER_BLOCK_ID = inuUSER_BLOCK_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVATION:= isbOBSERVATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBLOCK
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		isbBLOCK$ in LDC_FNB_SUBS_BLOCK.BLOCK%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;
		if inuLock=1 then
			LockByPk
			(
				inuUSER_BLOCK_ID,
				rcData
			);
		end if;

		update LDC_FNB_SUBS_BLOCK
		set
			BLOCK = isbBLOCK$
		where
			USER_BLOCK_ID = inuUSER_BLOCK_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BLOCK:= isbBLOCK$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENTIFICATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		isbIDENTIFICATION$ in LDC_FNB_SUBS_BLOCK.IDENTIFICATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;
		if inuLock=1 then
			LockByPk
			(
				inuUSER_BLOCK_ID,
				rcData
			);
		end if;

		update LDC_FNB_SUBS_BLOCK
		set
			IDENTIFICATION = isbIDENTIFICATION$
		where
			USER_BLOCK_ID = inuUSER_BLOCK_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENTIFICATION:= isbIDENTIFICATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENT_TYPE_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuIDENT_TYPE_ID$ in LDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN
		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;
		if inuLock=1 then
			LockByPk
			(
				inuUSER_BLOCK_ID,
				rcData
			);
		end if;

		update LDC_FNB_SUBS_BLOCK
		set
			IDENT_TYPE_ID = inuIDENT_TYPE_ID$
		where
			USER_BLOCK_ID = inuUSER_BLOCK_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENT_TYPE_ID:= inuIDENT_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetUSER_BLOCK_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN

		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuUSER_BLOCK_ID
			 )
		then
			 return(rcData.USER_BLOCK_ID);
		end if;
		Load
		(
		 		inuUSER_BLOCK_ID
		);
		return(rcData.USER_BLOCK_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.SUBSCRIPTION_ID%type
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN

		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuUSER_BLOCK_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuUSER_BLOCK_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOBSERVATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.OBSERVATION%type
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN

		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuUSER_BLOCK_ID
			 )
		then
			 return(rcData.OBSERVATION);
		end if;
		Load
		(
		 		inuUSER_BLOCK_ID
		);
		return(rcData.OBSERVATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBLOCK
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.BLOCK%type
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN

		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuUSER_BLOCK_ID
			 )
		then
			 return(rcData.BLOCK);
		end if;
		Load
		(
		 		inuUSER_BLOCK_ID
		);
		return(rcData.BLOCK);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIDENTIFICATION
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.IDENTIFICATION%type
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN

		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuUSER_BLOCK_ID
			 )
		then
			 return(rcData.IDENTIFICATION);
		end if;
		Load
		(
		 		inuUSER_BLOCK_ID
		);
		return(rcData.IDENTIFICATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDENT_TYPE_ID
	(
		inuUSER_BLOCK_ID in LDC_FNB_SUBS_BLOCK.USER_BLOCK_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_SUBS_BLOCK.IDENT_TYPE_ID%type
	IS
		rcError styLDC_FNB_SUBS_BLOCK;
	BEGIN

		rcError.USER_BLOCK_ID := inuUSER_BLOCK_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuUSER_BLOCK_ID
			 )
		then
			 return(rcData.IDENT_TYPE_ID);
		end if;
		Load
		(
		 		inuUSER_BLOCK_ID
		);
		return(rcData.IDENT_TYPE_ID);
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
end DALDC_FNB_SUBS_BLOCK;
/
PROMPT Otorgando permisos de ejecucion a DALDC_FNB_SUBS_BLOCK
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_FNB_SUBS_BLOCK', 'ADM_PERSON');
END;
/