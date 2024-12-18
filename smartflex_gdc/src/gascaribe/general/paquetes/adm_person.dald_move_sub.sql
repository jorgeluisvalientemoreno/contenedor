CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_MOVE_SUB
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_MOVE_SUB
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    30/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/  
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	IS
		SELECT LD_MOVE_SUB.*,LD_MOVE_SUB.rowid
		FROM LD_MOVE_SUB
		WHERE
		    MOVE_SUB_ID = inuMOVE_SUB_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_MOVE_SUB.*,LD_MOVE_SUB.rowid
		FROM LD_MOVE_SUB
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_MOVE_SUB  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_MOVE_SUB is table of styLD_MOVE_SUB index by binary_integer;
	type tyrfRecords is ref cursor return styLD_MOVE_SUB;

	/* Tipos referenciando al registro */
	type tytbTRANSFERRED_VALUE is table of LD_MOVE_SUB.TRANSFERRED_VALUE%type index by binary_integer;
	type tytbMOVE_SUB_ID is table of LD_MOVE_SUB.MOVE_SUB_ID%type index by binary_integer;
	type tytbSUSCCODI is table of LD_MOVE_SUB.SUSCCODI%type index by binary_integer;
	type tytbSOURCE_SUB is table of LD_MOVE_SUB.SOURCE_SUB%type index by binary_integer;
	type tytbTARGET_SUB is table of LD_MOVE_SUB.TARGET_SUB%type index by binary_integer;
	type tytbMOVE_DATE is table of LD_MOVE_SUB.MOVE_DATE%type index by binary_integer;
	type tytbUSER_ID is table of LD_MOVE_SUB.USER_ID%type index by binary_integer;
	type tytbTERMINAL is table of LD_MOVE_SUB.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_MOVE_SUB is record
	(
		TRANSFERRED_VALUE   tytbTRANSFERRED_VALUE,
		MOVE_SUB_ID   tytbMOVE_SUB_ID,
		SUSCCODI   tytbSUSCCODI,
		SOURCE_SUB   tytbSOURCE_SUB,
		TARGET_SUB   tytbTARGET_SUB,
		MOVE_DATE   tytbMOVE_DATE,
		USER_ID   tytbUSER_ID,
		TERMINAL   tytbTERMINAL,
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
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	);

	PROCEDURE getRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		orcRecord out nocopy styLD_MOVE_SUB
	);

	FUNCTION frcGetRcData
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN styLD_MOVE_SUB;

	FUNCTION frcGetRcData
	RETURN styLD_MOVE_SUB;

	FUNCTION frcGetRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN styLD_MOVE_SUB;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_MOVE_SUB
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_MOVE_SUB in styLD_MOVE_SUB
	);

	PROCEDURE insRecord
	(
		ircLD_MOVE_SUB in styLD_MOVE_SUB,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_MOVE_SUB in out nocopy tytbLD_MOVE_SUB
	);

	PROCEDURE delRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_MOVE_SUB in out nocopy tytbLD_MOVE_SUB,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_MOVE_SUB in styLD_MOVE_SUB,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_MOVE_SUB in out nocopy tytbLD_MOVE_SUB,
		inuLock in number default 1
	);

	PROCEDURE updTRANSFERRED_VALUE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuTRANSFERRED_VALUE$ in LD_MOVE_SUB.TRANSFERRED_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSCCODI
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuSUSCCODI$ in LD_MOVE_SUB.SUSCCODI%type,
		inuLock in number default 0
	);

	PROCEDURE updSOURCE_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuSOURCE_SUB$ in LD_MOVE_SUB.SOURCE_SUB%type,
		inuLock in number default 0
	);

	PROCEDURE updTARGET_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuTARGET_SUB$ in LD_MOVE_SUB.TARGET_SUB%type,
		inuLock in number default 0
	);

	PROCEDURE updMOVE_DATE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		idtMOVE_DATE$ in LD_MOVE_SUB.MOVE_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_ID
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		isbUSER_ID$ in LD_MOVE_SUB.USER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		isbTERMINAL$ in LD_MOVE_SUB.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTRANSFERRED_VALUE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.TRANSFERRED_VALUE%type;

	FUNCTION fnuGetMOVE_SUB_ID
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.MOVE_SUB_ID%type;

	FUNCTION fnuGetSUSCCODI
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.SUSCCODI%type;

	FUNCTION fnuGetSOURCE_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.SOURCE_SUB%type;

	FUNCTION fnuGetTARGET_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.TARGET_SUB%type;

	FUNCTION fdtGetMOVE_DATE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.MOVE_DATE%type;

	FUNCTION fsbGetUSER_ID
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.USER_ID%type;

	FUNCTION fsbGetTERMINAL
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		orcLD_MOVE_SUB  out styLD_MOVE_SUB
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_MOVE_SUB  out styLD_MOVE_SUB
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_MOVE_SUB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_MOVE_SUB
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO227083';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_MOVE_SUB';
	 cnuGeEntityId constant varchar2(30) := 8020; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	IS
		SELECT LD_MOVE_SUB.*,LD_MOVE_SUB.rowid
		FROM LD_MOVE_SUB
		WHERE  MOVE_SUB_ID = inuMOVE_SUB_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_MOVE_SUB.*,LD_MOVE_SUB.rowid
		FROM LD_MOVE_SUB
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_MOVE_SUB is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_MOVE_SUB;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_MOVE_SUB default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.MOVE_SUB_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		orcLD_MOVE_SUB  out styLD_MOVE_SUB
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

		Open cuLockRcByPk
		(
			inuMOVE_SUB_ID
		);

		fetch cuLockRcByPk into orcLD_MOVE_SUB;
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
		orcLD_MOVE_SUB  out styLD_MOVE_SUB
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_MOVE_SUB;
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
		itbLD_MOVE_SUB  in out nocopy tytbLD_MOVE_SUB
	)
	IS
	BEGIN
			rcRecOfTab.TRANSFERRED_VALUE.delete;
			rcRecOfTab.MOVE_SUB_ID.delete;
			rcRecOfTab.SUSCCODI.delete;
			rcRecOfTab.SOURCE_SUB.delete;
			rcRecOfTab.TARGET_SUB.delete;
			rcRecOfTab.MOVE_DATE.delete;
			rcRecOfTab.USER_ID.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_MOVE_SUB  in out nocopy tytbLD_MOVE_SUB,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_MOVE_SUB);

		for n in itbLD_MOVE_SUB.first .. itbLD_MOVE_SUB.last loop
			rcRecOfTab.TRANSFERRED_VALUE(n) := itbLD_MOVE_SUB(n).TRANSFERRED_VALUE;
			rcRecOfTab.MOVE_SUB_ID(n) := itbLD_MOVE_SUB(n).MOVE_SUB_ID;
			rcRecOfTab.SUSCCODI(n) := itbLD_MOVE_SUB(n).SUSCCODI;
			rcRecOfTab.SOURCE_SUB(n) := itbLD_MOVE_SUB(n).SOURCE_SUB;
			rcRecOfTab.TARGET_SUB(n) := itbLD_MOVE_SUB(n).TARGET_SUB;
			rcRecOfTab.MOVE_DATE(n) := itbLD_MOVE_SUB(n).MOVE_DATE;
			rcRecOfTab.USER_ID(n) := itbLD_MOVE_SUB(n).USER_ID;
			rcRecOfTab.TERMINAL(n) := itbLD_MOVE_SUB(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLD_MOVE_SUB(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuMOVE_SUB_ID
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
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuMOVE_SUB_ID = rcData.MOVE_SUB_ID
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
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuMOVE_SUB_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN		rcError.MOVE_SUB_ID:=inuMOVE_SUB_ID;

		Load
		(
			inuMOVE_SUB_ID
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
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuMOVE_SUB_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		orcRecord out nocopy styLD_MOVE_SUB
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN		rcError.MOVE_SUB_ID:=inuMOVE_SUB_ID;

		Load
		(
			inuMOVE_SUB_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN styLD_MOVE_SUB
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID:=inuMOVE_SUB_ID;

		Load
		(
			inuMOVE_SUB_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type
	)
	RETURN styLD_MOVE_SUB
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID:=inuMOVE_SUB_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuMOVE_SUB_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuMOVE_SUB_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_MOVE_SUB
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_MOVE_SUB
	)
	IS
		rfLD_MOVE_SUB tyrfLD_MOVE_SUB;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_MOVE_SUB.*, LD_MOVE_SUB.rowid FROM LD_MOVE_SUB';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_MOVE_SUB for sbFullQuery;

		fetch rfLD_MOVE_SUB bulk collect INTO otbResult;

		close rfLD_MOVE_SUB;
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
		sbSQL VARCHAR2 (32000) := 'select LD_MOVE_SUB.*, LD_MOVE_SUB.rowid FROM LD_MOVE_SUB';
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
		ircLD_MOVE_SUB in styLD_MOVE_SUB
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_MOVE_SUB,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_MOVE_SUB in styLD_MOVE_SUB,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_MOVE_SUB.MOVE_SUB_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|MOVE_SUB_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_MOVE_SUB
		(
			TRANSFERRED_VALUE,
			MOVE_SUB_ID,
			SUSCCODI,
			SOURCE_SUB,
			TARGET_SUB,
			MOVE_DATE,
			USER_ID,
			TERMINAL
		)
		values
		(
			ircLD_MOVE_SUB.TRANSFERRED_VALUE,
			ircLD_MOVE_SUB.MOVE_SUB_ID,
			ircLD_MOVE_SUB.SUSCCODI,
			ircLD_MOVE_SUB.SOURCE_SUB,
			ircLD_MOVE_SUB.TARGET_SUB,
			ircLD_MOVE_SUB.MOVE_DATE,
			ircLD_MOVE_SUB.USER_ID,
			ircLD_MOVE_SUB.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_MOVE_SUB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_MOVE_SUB in out nocopy tytbLD_MOVE_SUB
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_MOVE_SUB,blUseRowID);
		forall n in iotbLD_MOVE_SUB.first..iotbLD_MOVE_SUB.last
			insert into LD_MOVE_SUB
			(
				TRANSFERRED_VALUE,
				MOVE_SUB_ID,
				SUSCCODI,
				SOURCE_SUB,
				TARGET_SUB,
				MOVE_DATE,
				USER_ID,
				TERMINAL
			)
			values
			(
				rcRecOfTab.TRANSFERRED_VALUE(n),
				rcRecOfTab.MOVE_SUB_ID(n),
				rcRecOfTab.SUSCCODI(n),
				rcRecOfTab.SOURCE_SUB(n),
				rcRecOfTab.TARGET_SUB(n),
				rcRecOfTab.MOVE_DATE(n),
				rcRecOfTab.USER_ID(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;


		delete
		from LD_MOVE_SUB
		where
       		MOVE_SUB_ID=inuMOVE_SUB_ID;
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
		rcError  styLD_MOVE_SUB;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_MOVE_SUB
		where
			rowid = iriRowID
		returning
			TRANSFERRED_VALUE
		into
			rcError.TRANSFERRED_VALUE;
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
		iotbLD_MOVE_SUB in out nocopy tytbLD_MOVE_SUB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_MOVE_SUB;
	BEGIN
		FillRecordOfTables(iotbLD_MOVE_SUB, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last
				delete
				from LD_MOVE_SUB
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last loop
					LockByPk
					(
						rcRecOfTab.MOVE_SUB_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last
				delete
				from LD_MOVE_SUB
				where
		         	MOVE_SUB_ID = rcRecOfTab.MOVE_SUB_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_MOVE_SUB in styLD_MOVE_SUB,
		inuLock in number default 0
	)
	IS
		nuMOVE_SUB_ID	LD_MOVE_SUB.MOVE_SUB_ID%type;
	BEGIN
		if ircLD_MOVE_SUB.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_MOVE_SUB.rowid,rcData);
			end if;
			update LD_MOVE_SUB
			set
				TRANSFERRED_VALUE = ircLD_MOVE_SUB.TRANSFERRED_VALUE,
				SUSCCODI = ircLD_MOVE_SUB.SUSCCODI,
				SOURCE_SUB = ircLD_MOVE_SUB.SOURCE_SUB,
				TARGET_SUB = ircLD_MOVE_SUB.TARGET_SUB,
				MOVE_DATE = ircLD_MOVE_SUB.MOVE_DATE,
				USER_ID = ircLD_MOVE_SUB.USER_ID,
				TERMINAL = ircLD_MOVE_SUB.TERMINAL
			where
				rowid = ircLD_MOVE_SUB.rowid
			returning
				MOVE_SUB_ID
			into
				nuMOVE_SUB_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_MOVE_SUB.MOVE_SUB_ID,
					rcData
				);
			end if;

			update LD_MOVE_SUB
			set
				TRANSFERRED_VALUE = ircLD_MOVE_SUB.TRANSFERRED_VALUE,
				SUSCCODI = ircLD_MOVE_SUB.SUSCCODI,
				SOURCE_SUB = ircLD_MOVE_SUB.SOURCE_SUB,
				TARGET_SUB = ircLD_MOVE_SUB.TARGET_SUB,
				MOVE_DATE = ircLD_MOVE_SUB.MOVE_DATE,
				USER_ID = ircLD_MOVE_SUB.USER_ID,
				TERMINAL = ircLD_MOVE_SUB.TERMINAL
			where
				MOVE_SUB_ID = ircLD_MOVE_SUB.MOVE_SUB_ID
			returning
				MOVE_SUB_ID
			into
				nuMOVE_SUB_ID;
		end if;
		if
			nuMOVE_SUB_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_MOVE_SUB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_MOVE_SUB in out nocopy tytbLD_MOVE_SUB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_MOVE_SUB;
	BEGIN
		FillRecordOfTables(iotbLD_MOVE_SUB,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last
				update LD_MOVE_SUB
				set
					TRANSFERRED_VALUE = rcRecOfTab.TRANSFERRED_VALUE(n),
					SUSCCODI = rcRecOfTab.SUSCCODI(n),
					SOURCE_SUB = rcRecOfTab.SOURCE_SUB(n),
					TARGET_SUB = rcRecOfTab.TARGET_SUB(n),
					MOVE_DATE = rcRecOfTab.MOVE_DATE(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last loop
					LockByPk
					(
						rcRecOfTab.MOVE_SUB_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_MOVE_SUB.first .. iotbLD_MOVE_SUB.last
				update LD_MOVE_SUB
				SET
					TRANSFERRED_VALUE = rcRecOfTab.TRANSFERRED_VALUE(n),
					SUSCCODI = rcRecOfTab.SUSCCODI(n),
					SOURCE_SUB = rcRecOfTab.SOURCE_SUB(n),
					TARGET_SUB = rcRecOfTab.TARGET_SUB(n),
					MOVE_DATE = rcRecOfTab.MOVE_DATE(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					MOVE_SUB_ID = rcRecOfTab.MOVE_SUB_ID(n)
;
		end if;
	END;
	PROCEDURE updTRANSFERRED_VALUE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuTRANSFERRED_VALUE$ in LD_MOVE_SUB.TRANSFERRED_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			TRANSFERRED_VALUE = inuTRANSFERRED_VALUE$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TRANSFERRED_VALUE:= inuTRANSFERRED_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSCCODI
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuSUSCCODI$ in LD_MOVE_SUB.SUSCCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			SUSCCODI = inuSUSCCODI$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSCCODI:= inuSUSCCODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOURCE_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuSOURCE_SUB$ in LD_MOVE_SUB.SOURCE_SUB%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			SOURCE_SUB = inuSOURCE_SUB$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOURCE_SUB:= inuSOURCE_SUB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTARGET_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuTARGET_SUB$ in LD_MOVE_SUB.TARGET_SUB%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			TARGET_SUB = inuTARGET_SUB$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TARGET_SUB:= inuTARGET_SUB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMOVE_DATE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		idtMOVE_DATE$ in LD_MOVE_SUB.MOVE_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			MOVE_DATE = idtMOVE_DATE$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MOVE_DATE:= idtMOVE_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_ID
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		isbUSER_ID$ in LD_MOVE_SUB.USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			USER_ID = isbUSER_ID$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_ID:= isbUSER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		isbTERMINAL$ in LD_MOVE_SUB.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_MOVE_SUB;
	BEGIN
		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuMOVE_SUB_ID,
				rcData
			);
		end if;

		update LD_MOVE_SUB
		set
			TERMINAL = isbTERMINAL$
		where
			MOVE_SUB_ID = inuMOVE_SUB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTRANSFERRED_VALUE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.TRANSFERRED_VALUE%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.TRANSFERRED_VALUE);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.TRANSFERRED_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMOVE_SUB_ID
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.MOVE_SUB_ID%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.MOVE_SUB_ID);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.MOVE_SUB_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSCCODI
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.SUSCCODI%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.SUSCCODI);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.SUSCCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSOURCE_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.SOURCE_SUB%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.SOURCE_SUB);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.SOURCE_SUB);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTARGET_SUB
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.TARGET_SUB%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.TARGET_SUB);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.TARGET_SUB);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetMOVE_DATE
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.MOVE_DATE%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.MOVE_DATE);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.MOVE_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_ID
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.USER_ID%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.USER_ID);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.USER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL
	(
		inuMOVE_SUB_ID in LD_MOVE_SUB.MOVE_SUB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_MOVE_SUB.TERMINAL%type
	IS
		rcError styLD_MOVE_SUB;
	BEGIN

		rcError.MOVE_SUB_ID := inuMOVE_SUB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuMOVE_SUB_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuMOVE_SUB_ID
		);
		return(rcData.TERMINAL);
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
end DALD_MOVE_SUB;
/
PROMPT Otorgando permisos de ejecucion a DALD_MOVE_SUB
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_MOVE_SUB', 'ADM_PERSON');
END;
/