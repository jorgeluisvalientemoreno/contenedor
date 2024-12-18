CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_RETROACTIVE
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_RETROACTIVE
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	IS
		SELECT LDC_RETROACTIVE.*,LDC_RETROACTIVE.rowid
		FROM LDC_RETROACTIVE
		WHERE
		    RETROACTIVE_ID = inuRETROACTIVE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_RETROACTIVE.*,LDC_RETROACTIVE.rowid
		FROM LDC_RETROACTIVE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_RETROACTIVE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_RETROACTIVE is table of styLDC_RETROACTIVE index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_RETROACTIVE;

	/* Tipos referenciando al registro */
	type tytbRETROACTIVE_ID is table of LDC_RETROACTIVE.RETROACTIVE_ID%type index by binary_integer;
	type tytbINITIAL_DATE is table of LDC_RETROACTIVE.INITIAL_DATE%type index by binary_integer;
	type tytbFINAL_DATE is table of LDC_RETROACTIVE.FINAL_DATE%type index by binary_integer;
	type tytbUSER_ID is table of LDC_RETROACTIVE.USER_ID%type index by binary_integer;
	type tytbTERMINAL is table of LDC_RETROACTIVE.TERMINAL%type index by binary_integer;
	type tytbEXECUTE_DATE is table of LDC_RETROACTIVE.EXECUTE_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_RETROACTIVE is record
	(
		RETROACTIVE_ID   tytbRETROACTIVE_ID,
		INITIAL_DATE   tytbINITIAL_DATE,
		FINAL_DATE   tytbFINAL_DATE,
		USER_ID   tytbUSER_ID,
		TERMINAL   tytbTERMINAL,
		EXECUTE_DATE   tytbEXECUTE_DATE,
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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	);

	PROCEDURE getRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		orcRecord out nocopy styLDC_RETROACTIVE
	);

	FUNCTION frcGetRcData
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN styLDC_RETROACTIVE;

	FUNCTION frcGetRcData
	RETURN styLDC_RETROACTIVE;

	FUNCTION frcGetRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN styLDC_RETROACTIVE;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_RETROACTIVE
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_RETROACTIVE in styLDC_RETROACTIVE
	);

	PROCEDURE insRecord
	(
		ircLDC_RETROACTIVE in styLDC_RETROACTIVE,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_RETROACTIVE in out nocopy tytbLDC_RETROACTIVE
	);

	PROCEDURE delRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_RETROACTIVE in out nocopy tytbLDC_RETROACTIVE,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_RETROACTIVE in styLDC_RETROACTIVE,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_RETROACTIVE in out nocopy tytbLDC_RETROACTIVE,
		inuLock in number default 1
	);

	PROCEDURE updINITIAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		idtINITIAL_DATE$ in LDC_RETROACTIVE.INITIAL_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		idtFINAL_DATE$ in LDC_RETROACTIVE.FINAL_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_ID
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		isbUSER_ID$ in LDC_RETROACTIVE.USER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		isbTERMINAL$ in LDC_RETROACTIVE.TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updEXECUTE_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		idtEXECUTE_DATE$ in LDC_RETROACTIVE.EXECUTE_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetRETROACTIVE_ID
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.RETROACTIVE_ID%type;

	FUNCTION fdtGetINITIAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.INITIAL_DATE%type;

	FUNCTION fdtGetFINAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.FINAL_DATE%type;

	FUNCTION fsbGetUSER_ID
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.USER_ID%type;

	FUNCTION fsbGetTERMINAL
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.TERMINAL%type;

	FUNCTION fdtGetEXECUTE_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.EXECUTE_DATE%type;


	PROCEDURE LockByPk
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		orcLDC_RETROACTIVE  out styLDC_RETROACTIVE
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_RETROACTIVE  out styLDC_RETROACTIVE
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_RETROACTIVE;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_RETROACTIVE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_RETROACTIVE';
	 cnuGeEntityId constant varchar2(30) := 8526; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	IS
		SELECT LDC_RETROACTIVE.*,LDC_RETROACTIVE.rowid
		FROM LDC_RETROACTIVE
		WHERE  RETROACTIVE_ID = inuRETROACTIVE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_RETROACTIVE.*,LDC_RETROACTIVE.rowid
		FROM LDC_RETROACTIVE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_RETROACTIVE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_RETROACTIVE;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_RETROACTIVE default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RETROACTIVE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		orcLDC_RETROACTIVE  out styLDC_RETROACTIVE
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

		Open cuLockRcByPk
		(
			inuRETROACTIVE_ID
		);

		fetch cuLockRcByPk into orcLDC_RETROACTIVE;
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
		orcLDC_RETROACTIVE  out styLDC_RETROACTIVE
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_RETROACTIVE;
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
		itbLDC_RETROACTIVE  in out nocopy tytbLDC_RETROACTIVE
	)
	IS
	BEGIN
			rcRecOfTab.RETROACTIVE_ID.delete;
			rcRecOfTab.INITIAL_DATE.delete;
			rcRecOfTab.FINAL_DATE.delete;
			rcRecOfTab.USER_ID.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.EXECUTE_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_RETROACTIVE  in out nocopy tytbLDC_RETROACTIVE,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_RETROACTIVE);

		for n in itbLDC_RETROACTIVE.first .. itbLDC_RETROACTIVE.last loop
			rcRecOfTab.RETROACTIVE_ID(n) := itbLDC_RETROACTIVE(n).RETROACTIVE_ID;
			rcRecOfTab.INITIAL_DATE(n) := itbLDC_RETROACTIVE(n).INITIAL_DATE;
			rcRecOfTab.FINAL_DATE(n) := itbLDC_RETROACTIVE(n).FINAL_DATE;
			rcRecOfTab.USER_ID(n) := itbLDC_RETROACTIVE(n).USER_ID;
			rcRecOfTab.TERMINAL(n) := itbLDC_RETROACTIVE(n).TERMINAL;
			rcRecOfTab.EXECUTE_DATE(n) := itbLDC_RETROACTIVE(n).EXECUTE_DATE;
			rcRecOfTab.row_id(n) := itbLDC_RETROACTIVE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRETROACTIVE_ID
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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRETROACTIVE_ID = rcData.RETROACTIVE_ID
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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRETROACTIVE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN		rcError.RETROACTIVE_ID:=inuRETROACTIVE_ID;

		Load
		(
			inuRETROACTIVE_ID
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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuRETROACTIVE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		orcRecord out nocopy styLDC_RETROACTIVE
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN		rcError.RETROACTIVE_ID:=inuRETROACTIVE_ID;

		Load
		(
			inuRETROACTIVE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN styLDC_RETROACTIVE
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID:=inuRETROACTIVE_ID;

		Load
		(
			inuRETROACTIVE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type
	)
	RETURN styLDC_RETROACTIVE
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID:=inuRETROACTIVE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuRETROACTIVE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRETROACTIVE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_RETROACTIVE
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_RETROACTIVE
	)
	IS
		rfLDC_RETROACTIVE tyrfLDC_RETROACTIVE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_RETROACTIVE.*, LDC_RETROACTIVE.rowid FROM LDC_RETROACTIVE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_RETROACTIVE for sbFullQuery;

		fetch rfLDC_RETROACTIVE bulk collect INTO otbResult;

		close rfLDC_RETROACTIVE;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_RETROACTIVE.*, LDC_RETROACTIVE.rowid FROM LDC_RETROACTIVE';
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
		ircLDC_RETROACTIVE in styLDC_RETROACTIVE
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_RETROACTIVE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_RETROACTIVE in styLDC_RETROACTIVE,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_RETROACTIVE.RETROACTIVE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RETROACTIVE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_RETROACTIVE
		(
			RETROACTIVE_ID,
			INITIAL_DATE,
			FINAL_DATE,
			USER_ID,
			TERMINAL,
			EXECUTE_DATE
		)
		values
		(
			ircLDC_RETROACTIVE.RETROACTIVE_ID,
			ircLDC_RETROACTIVE.INITIAL_DATE,
			ircLDC_RETROACTIVE.FINAL_DATE,
			ircLDC_RETROACTIVE.USER_ID,
			ircLDC_RETROACTIVE.TERMINAL,
			ircLDC_RETROACTIVE.EXECUTE_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_RETROACTIVE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_RETROACTIVE in out nocopy tytbLDC_RETROACTIVE
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_RETROACTIVE,blUseRowID);
		forall n in iotbLDC_RETROACTIVE.first..iotbLDC_RETROACTIVE.last
			insert into LDC_RETROACTIVE
			(
				RETROACTIVE_ID,
				INITIAL_DATE,
				FINAL_DATE,
				USER_ID,
				TERMINAL,
				EXECUTE_DATE
			)
			values
			(
				rcRecOfTab.RETROACTIVE_ID(n),
				rcRecOfTab.INITIAL_DATE(n),
				rcRecOfTab.FINAL_DATE(n),
				rcRecOfTab.USER_ID(n),
				rcRecOfTab.TERMINAL(n),
				rcRecOfTab.EXECUTE_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuRETROACTIVE_ID,
				rcData
			);
		end if;


		delete
		from LDC_RETROACTIVE
		where
       		RETROACTIVE_ID=inuRETROACTIVE_ID;
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
		rcError  styLDC_RETROACTIVE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_RETROACTIVE
		where
			rowid = iriRowID
		returning
			RETROACTIVE_ID
		into
			rcError.RETROACTIVE_ID;
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
		iotbLDC_RETROACTIVE in out nocopy tytbLDC_RETROACTIVE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_RETROACTIVE;
	BEGIN
		FillRecordOfTables(iotbLDC_RETROACTIVE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last
				delete
				from LDC_RETROACTIVE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last loop
					LockByPk
					(
						rcRecOfTab.RETROACTIVE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last
				delete
				from LDC_RETROACTIVE
				where
		         	RETROACTIVE_ID = rcRecOfTab.RETROACTIVE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_RETROACTIVE in styLDC_RETROACTIVE,
		inuLock in number default 0
	)
	IS
		nuRETROACTIVE_ID	LDC_RETROACTIVE.RETROACTIVE_ID%type;
	BEGIN
		if ircLDC_RETROACTIVE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_RETROACTIVE.rowid,rcData);
			end if;
			update LDC_RETROACTIVE
			set
				INITIAL_DATE = ircLDC_RETROACTIVE.INITIAL_DATE,
				FINAL_DATE = ircLDC_RETROACTIVE.FINAL_DATE,
				USER_ID = ircLDC_RETROACTIVE.USER_ID,
				TERMINAL = ircLDC_RETROACTIVE.TERMINAL,
				EXECUTE_DATE = ircLDC_RETROACTIVE.EXECUTE_DATE
			where
				rowid = ircLDC_RETROACTIVE.rowid
			returning
				RETROACTIVE_ID
			into
				nuRETROACTIVE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_RETROACTIVE.RETROACTIVE_ID,
					rcData
				);
			end if;

			update LDC_RETROACTIVE
			set
				INITIAL_DATE = ircLDC_RETROACTIVE.INITIAL_DATE,
				FINAL_DATE = ircLDC_RETROACTIVE.FINAL_DATE,
				USER_ID = ircLDC_RETROACTIVE.USER_ID,
				TERMINAL = ircLDC_RETROACTIVE.TERMINAL,
				EXECUTE_DATE = ircLDC_RETROACTIVE.EXECUTE_DATE
			where
				RETROACTIVE_ID = ircLDC_RETROACTIVE.RETROACTIVE_ID
			returning
				RETROACTIVE_ID
			into
				nuRETROACTIVE_ID;
		end if;
		if
			nuRETROACTIVE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_RETROACTIVE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_RETROACTIVE in out nocopy tytbLDC_RETROACTIVE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_RETROACTIVE;
	BEGIN
		FillRecordOfTables(iotbLDC_RETROACTIVE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last
				update LDC_RETROACTIVE
				set
					INITIAL_DATE = rcRecOfTab.INITIAL_DATE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					EXECUTE_DATE = rcRecOfTab.EXECUTE_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last loop
					LockByPk
					(
						rcRecOfTab.RETROACTIVE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RETROACTIVE.first .. iotbLDC_RETROACTIVE.last
				update LDC_RETROACTIVE
				SET
					INITIAL_DATE = rcRecOfTab.INITIAL_DATE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					EXECUTE_DATE = rcRecOfTab.EXECUTE_DATE(n)
				where
					RETROACTIVE_ID = rcRecOfTab.RETROACTIVE_ID(n)
;
		end if;
	END;
	PROCEDURE updINITIAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		idtINITIAL_DATE$ in LDC_RETROACTIVE.INITIAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETROACTIVE_ID,
				rcData
			);
		end if;

		update LDC_RETROACTIVE
		set
			INITIAL_DATE = idtINITIAL_DATE$
		where
			RETROACTIVE_ID = inuRETROACTIVE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INITIAL_DATE:= idtINITIAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		idtFINAL_DATE$ in LDC_RETROACTIVE.FINAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETROACTIVE_ID,
				rcData
			);
		end if;

		update LDC_RETROACTIVE
		set
			FINAL_DATE = idtFINAL_DATE$
		where
			RETROACTIVE_ID = inuRETROACTIVE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAL_DATE:= idtFINAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_ID
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		isbUSER_ID$ in LDC_RETROACTIVE.USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETROACTIVE_ID,
				rcData
			);
		end if;

		update LDC_RETROACTIVE
		set
			USER_ID = isbUSER_ID$
		where
			RETROACTIVE_ID = inuRETROACTIVE_ID;

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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		isbTERMINAL$ in LDC_RETROACTIVE.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETROACTIVE_ID,
				rcData
			);
		end if;

		update LDC_RETROACTIVE
		set
			TERMINAL = isbTERMINAL$
		where
			RETROACTIVE_ID = inuRETROACTIVE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEXECUTE_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		idtEXECUTE_DATE$ in LDC_RETROACTIVE.EXECUTE_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN
		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETROACTIVE_ID,
				rcData
			);
		end if;

		update LDC_RETROACTIVE
		set
			EXECUTE_DATE = idtEXECUTE_DATE$
		where
			RETROACTIVE_ID = inuRETROACTIVE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXECUTE_DATE:= idtEXECUTE_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetRETROACTIVE_ID
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.RETROACTIVE_ID%type
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN

		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETROACTIVE_ID
			 )
		then
			 return(rcData.RETROACTIVE_ID);
		end if;
		Load
		(
		 		inuRETROACTIVE_ID
		);
		return(rcData.RETROACTIVE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetINITIAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.INITIAL_DATE%type
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN

		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETROACTIVE_ID
			 )
		then
			 return(rcData.INITIAL_DATE);
		end if;
		Load
		(
		 		inuRETROACTIVE_ID
		);
		return(rcData.INITIAL_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFINAL_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.FINAL_DATE%type
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN

		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETROACTIVE_ID
			 )
		then
			 return(rcData.FINAL_DATE);
		end if;
		Load
		(
		 		inuRETROACTIVE_ID
		);
		return(rcData.FINAL_DATE);
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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.USER_ID%type
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN

		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETROACTIVE_ID
			 )
		then
			 return(rcData.USER_ID);
		end if;
		Load
		(
		 		inuRETROACTIVE_ID
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
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.TERMINAL%type
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN

		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETROACTIVE_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuRETROACTIVE_ID
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
	FUNCTION fdtGetEXECUTE_DATE
	(
		inuRETROACTIVE_ID in LDC_RETROACTIVE.RETROACTIVE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RETROACTIVE.EXECUTE_DATE%type
	IS
		rcError styLDC_RETROACTIVE;
	BEGIN

		rcError.RETROACTIVE_ID := inuRETROACTIVE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETROACTIVE_ID
			 )
		then
			 return(rcData.EXECUTE_DATE);
		end if;
		Load
		(
		 		inuRETROACTIVE_ID
		);
		return(rcData.EXECUTE_DATE);
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
end DALDC_RETROACTIVE;
/
PROMPT Otorgando permisos de ejecucion a DALDC_RETROACTIVE
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_RETROACTIVE', 'ADM_PERSON');
END;
/