CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_EQUI_PACKTYPE_SSPD
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	IS
		SELECT LDC_EQUI_PACKTYPE_SSPD.*,LDC_EQUI_PACKTYPE_SSPD.rowid
		FROM LDC_EQUI_PACKTYPE_SSPD
		WHERE
		    EQUI_PACKTYPE_SSPD_ID = inuEQUI_PACKTYPE_SSPD_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_EQUI_PACKTYPE_SSPD.*,LDC_EQUI_PACKTYPE_SSPD.rowid
		FROM LDC_EQUI_PACKTYPE_SSPD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_EQUI_PACKTYPE_SSPD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_EQUI_PACKTYPE_SSPD is table of styLDC_EQUI_PACKTYPE_SSPD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_EQUI_PACKTYPE_SSPD;

	/* Tipos referenciando al registro */
	type tytbEQUI_PACKTYPE_SSPD_ID is table of LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type index by binary_integer;
	type tytbCAUSAL_SSPD_ID is table of LDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_EQUI_PACKTYPE_SSPD is record
	(
		EQUI_PACKTYPE_SSPD_ID   tytbEQUI_PACKTYPE_SSPD_ID,
		CAUSAL_SSPD_ID   tytbCAUSAL_SSPD_ID,
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
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	);

	PROCEDURE getRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		orcRecord out nocopy styLDC_EQUI_PACKTYPE_SSPD
	);

	FUNCTION frcGetRcData
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN styLDC_EQUI_PACKTYPE_SSPD;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUI_PACKTYPE_SSPD;

	FUNCTION frcGetRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN styLDC_EQUI_PACKTYPE_SSPD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUI_PACKTYPE_SSPD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_EQUI_PACKTYPE_SSPD in styLDC_EQUI_PACKTYPE_SSPD
	);

	PROCEDURE insRecord
	(
		ircLDC_EQUI_PACKTYPE_SSPD in styLDC_EQUI_PACKTYPE_SSPD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_EQUI_PACKTYPE_SSPD in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD
	);

	PROCEDURE delRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_EQUI_PACKTYPE_SSPD in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_EQUI_PACKTYPE_SSPD in styLDC_EQUI_PACKTYPE_SSPD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_EQUI_PACKTYPE_SSPD in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updCAUSAL_SSPD_ID
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuCAUSAL_SSPD_ID$ in LDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetEQUI_PACKTYPE_SSPD_ID
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type;

	FUNCTION fnuGetCAUSAL_SSPD_ID
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID%type;


	PROCEDURE LockByPk
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		orcLDC_EQUI_PACKTYPE_SSPD  out styLDC_EQUI_PACKTYPE_SSPD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_EQUI_PACKTYPE_SSPD  out styLDC_EQUI_PACKTYPE_SSPD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_EQUI_PACKTYPE_SSPD;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_EQUI_PACKTYPE_SSPD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_EQUI_PACKTYPE_SSPD';
	 cnuGeEntityId constant varchar2(30) := 8859; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	IS
		SELECT LDC_EQUI_PACKTYPE_SSPD.*,LDC_EQUI_PACKTYPE_SSPD.rowid
		FROM LDC_EQUI_PACKTYPE_SSPD
		WHERE  EQUI_PACKTYPE_SSPD_ID = inuEQUI_PACKTYPE_SSPD_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_EQUI_PACKTYPE_SSPD.*,LDC_EQUI_PACKTYPE_SSPD.rowid
		FROM LDC_EQUI_PACKTYPE_SSPD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_EQUI_PACKTYPE_SSPD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_EQUI_PACKTYPE_SSPD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_EQUI_PACKTYPE_SSPD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.EQUI_PACKTYPE_SSPD_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		orcLDC_EQUI_PACKTYPE_SSPD  out styLDC_EQUI_PACKTYPE_SSPD
	)
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		rcError.EQUI_PACKTYPE_SSPD_ID := inuEQUI_PACKTYPE_SSPD_ID;

		Open cuLockRcByPk
		(
			inuEQUI_PACKTYPE_SSPD_ID
		);

		fetch cuLockRcByPk into orcLDC_EQUI_PACKTYPE_SSPD;
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
		orcLDC_EQUI_PACKTYPE_SSPD  out styLDC_EQUI_PACKTYPE_SSPD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_EQUI_PACKTYPE_SSPD;
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
		itbLDC_EQUI_PACKTYPE_SSPD  in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD
	)
	IS
	BEGIN
			rcRecOfTab.EQUI_PACKTYPE_SSPD_ID.delete;
			rcRecOfTab.CAUSAL_SSPD_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_EQUI_PACKTYPE_SSPD  in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_EQUI_PACKTYPE_SSPD);

		for n in itbLDC_EQUI_PACKTYPE_SSPD.first .. itbLDC_EQUI_PACKTYPE_SSPD.last loop
			rcRecOfTab.EQUI_PACKTYPE_SSPD_ID(n) := itbLDC_EQUI_PACKTYPE_SSPD(n).EQUI_PACKTYPE_SSPD_ID;
			rcRecOfTab.CAUSAL_SSPD_ID(n) := itbLDC_EQUI_PACKTYPE_SSPD(n).CAUSAL_SSPD_ID;
			rcRecOfTab.row_id(n) := itbLDC_EQUI_PACKTYPE_SSPD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuEQUI_PACKTYPE_SSPD_ID
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
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuEQUI_PACKTYPE_SSPD_ID = rcData.EQUI_PACKTYPE_SSPD_ID
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
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuEQUI_PACKTYPE_SSPD_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN		rcError.EQUI_PACKTYPE_SSPD_ID:=inuEQUI_PACKTYPE_SSPD_ID;

		Load
		(
			inuEQUI_PACKTYPE_SSPD_ID
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
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuEQUI_PACKTYPE_SSPD_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		orcRecord out nocopy styLDC_EQUI_PACKTYPE_SSPD
	)
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN		rcError.EQUI_PACKTYPE_SSPD_ID:=inuEQUI_PACKTYPE_SSPD_ID;

		Load
		(
			inuEQUI_PACKTYPE_SSPD_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN styLDC_EQUI_PACKTYPE_SSPD
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		rcError.EQUI_PACKTYPE_SSPD_ID:=inuEQUI_PACKTYPE_SSPD_ID;

		Load
		(
			inuEQUI_PACKTYPE_SSPD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	)
	RETURN styLDC_EQUI_PACKTYPE_SSPD
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		rcError.EQUI_PACKTYPE_SSPD_ID:=inuEQUI_PACKTYPE_SSPD_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuEQUI_PACKTYPE_SSPD_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuEQUI_PACKTYPE_SSPD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUI_PACKTYPE_SSPD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUI_PACKTYPE_SSPD
	)
	IS
		rfLDC_EQUI_PACKTYPE_SSPD tyrfLDC_EQUI_PACKTYPE_SSPD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_EQUI_PACKTYPE_SSPD.*, LDC_EQUI_PACKTYPE_SSPD.rowid FROM LDC_EQUI_PACKTYPE_SSPD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_EQUI_PACKTYPE_SSPD for sbFullQuery;

		fetch rfLDC_EQUI_PACKTYPE_SSPD bulk collect INTO otbResult;

		close rfLDC_EQUI_PACKTYPE_SSPD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_EQUI_PACKTYPE_SSPD.*, LDC_EQUI_PACKTYPE_SSPD.rowid FROM LDC_EQUI_PACKTYPE_SSPD';
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
		ircLDC_EQUI_PACKTYPE_SSPD in styLDC_EQUI_PACKTYPE_SSPD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_EQUI_PACKTYPE_SSPD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_EQUI_PACKTYPE_SSPD in styLDC_EQUI_PACKTYPE_SSPD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|EQUI_PACKTYPE_SSPD_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_EQUI_PACKTYPE_SSPD
		(
			EQUI_PACKTYPE_SSPD_ID,
			CAUSAL_SSPD_ID
		)
		values
		(
			ircLDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID,
			ircLDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_EQUI_PACKTYPE_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_EQUI_PACKTYPE_SSPD in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUI_PACKTYPE_SSPD,blUseRowID);
		forall n in iotbLDC_EQUI_PACKTYPE_SSPD.first..iotbLDC_EQUI_PACKTYPE_SSPD.last
			insert into LDC_EQUI_PACKTYPE_SSPD
			(
				EQUI_PACKTYPE_SSPD_ID,
				CAUSAL_SSPD_ID
			)
			values
			(
				rcRecOfTab.EQUI_PACKTYPE_SSPD_ID(n),
				rcRecOfTab.CAUSAL_SSPD_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		rcError.EQUI_PACKTYPE_SSPD_ID := inuEQUI_PACKTYPE_SSPD_ID;

		if inuLock=1 then
			LockByPk
			(
				inuEQUI_PACKTYPE_SSPD_ID,
				rcData
			);
		end if;


		delete
		from LDC_EQUI_PACKTYPE_SSPD
		where
       		EQUI_PACKTYPE_SSPD_ID=inuEQUI_PACKTYPE_SSPD_ID;
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
		rcError  styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_EQUI_PACKTYPE_SSPD
		where
			rowid = iriRowID
		returning
			EQUI_PACKTYPE_SSPD_ID
		into
			rcError.EQUI_PACKTYPE_SSPD_ID;
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
		iotbLDC_EQUI_PACKTYPE_SSPD in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUI_PACKTYPE_SSPD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last
				delete
				from LDC_EQUI_PACKTYPE_SSPD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.EQUI_PACKTYPE_SSPD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last
				delete
				from LDC_EQUI_PACKTYPE_SSPD
				where
		         	EQUI_PACKTYPE_SSPD_ID = rcRecOfTab.EQUI_PACKTYPE_SSPD_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_EQUI_PACKTYPE_SSPD in styLDC_EQUI_PACKTYPE_SSPD,
		inuLock in number default 0
	)
	IS
		nuEQUI_PACKTYPE_SSPD_ID	LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type;
	BEGIN
		if ircLDC_EQUI_PACKTYPE_SSPD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_EQUI_PACKTYPE_SSPD.rowid,rcData);
			end if;
			update LDC_EQUI_PACKTYPE_SSPD
			set
				CAUSAL_SSPD_ID = ircLDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID
			where
				rowid = ircLDC_EQUI_PACKTYPE_SSPD.rowid
			returning
				EQUI_PACKTYPE_SSPD_ID
			into
				nuEQUI_PACKTYPE_SSPD_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID,
					rcData
				);
			end if;

			update LDC_EQUI_PACKTYPE_SSPD
			set
				CAUSAL_SSPD_ID = ircLDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID
			where
				EQUI_PACKTYPE_SSPD_ID = ircLDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID
			returning
				EQUI_PACKTYPE_SSPD_ID
			into
				nuEQUI_PACKTYPE_SSPD_ID;
		end if;
		if
			nuEQUI_PACKTYPE_SSPD_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_EQUI_PACKTYPE_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_EQUI_PACKTYPE_SSPD in out nocopy tytbLDC_EQUI_PACKTYPE_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUI_PACKTYPE_SSPD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last
				update LDC_EQUI_PACKTYPE_SSPD
				set
					CAUSAL_SSPD_ID = rcRecOfTab.CAUSAL_SSPD_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.EQUI_PACKTYPE_SSPD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_PACKTYPE_SSPD.first .. iotbLDC_EQUI_PACKTYPE_SSPD.last
				update LDC_EQUI_PACKTYPE_SSPD
				SET
					CAUSAL_SSPD_ID = rcRecOfTab.CAUSAL_SSPD_ID(n)
				where
					EQUI_PACKTYPE_SSPD_ID = rcRecOfTab.EQUI_PACKTYPE_SSPD_ID(n)
;
		end if;
	END;
	PROCEDURE updCAUSAL_SSPD_ID
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuCAUSAL_SSPD_ID$ in LDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN
		rcError.EQUI_PACKTYPE_SSPD_ID := inuEQUI_PACKTYPE_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuEQUI_PACKTYPE_SSPD_ID,
				rcData
			);
		end if;

		update LDC_EQUI_PACKTYPE_SSPD
		set
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID$
		where
			EQUI_PACKTYPE_SSPD_ID = inuEQUI_PACKTYPE_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_SSPD_ID:= inuCAUSAL_SSPD_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetEQUI_PACKTYPE_SSPD_ID
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN

		rcError.EQUI_PACKTYPE_SSPD_ID := inuEQUI_PACKTYPE_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEQUI_PACKTYPE_SSPD_ID
			 )
		then
			 return(rcData.EQUI_PACKTYPE_SSPD_ID);
		end if;
		Load
		(
		 		inuEQUI_PACKTYPE_SSPD_ID
		);
		return(rcData.EQUI_PACKTYPE_SSPD_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_SSPD_ID
	(
		inuEQUI_PACKTYPE_SSPD_ID in LDC_EQUI_PACKTYPE_SSPD.EQUI_PACKTYPE_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID%type
	IS
		rcError styLDC_EQUI_PACKTYPE_SSPD;
	BEGIN

		rcError.EQUI_PACKTYPE_SSPD_ID := inuEQUI_PACKTYPE_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEQUI_PACKTYPE_SSPD_ID
			 )
		then
			 return(rcData.CAUSAL_SSPD_ID);
		end if;
		Load
		(
		 		inuEQUI_PACKTYPE_SSPD_ID
		);
		return(rcData.CAUSAL_SSPD_ID);
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
end DALDC_EQUI_PACKTYPE_SSPD;
/
PROMPT Otorgando permisos de ejecucion a DALDC_EQUI_PACKTYPE_SSPD
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_EQUI_PACKTYPE_SSPD', 'ADM_PERSON');
END;
/