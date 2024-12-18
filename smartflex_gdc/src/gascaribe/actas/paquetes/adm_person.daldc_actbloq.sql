CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ACTBLOQ
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_ACTBLOQ
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
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	IS
		SELECT LDC_ACTBLOQ.*,LDC_ACTBLOQ.rowid
		FROM LDC_ACTBLOQ
		WHERE
		    BLOQUEOD_ID = inuBLOQUEOD_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ACTBLOQ.*,LDC_ACTBLOQ.rowid
		FROM LDC_ACTBLOQ
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ACTBLOQ  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ACTBLOQ is table of styLDC_ACTBLOQ index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ACTBLOQ;

	/* Tipos referenciando al registro */
	type tytbBLOQUEOD_ID is table of LDC_ACTBLOQ.BLOQUEOD_ID%type index by binary_integer;
	type tytbIDMAESTRO is table of LDC_ACTBLOQ.IDMAESTRO%type index by binary_integer;
	type tytbTASK_TYPE_ID is table of LDC_ACTBLOQ.TASK_TYPE_ID%type index by binary_integer;
	type tytbACTIVITY_ID is table of LDC_ACTBLOQ.ACTIVITY_ID%type index by binary_integer;
	type tytbFECHAREG is table of LDC_ACTBLOQ.FECHAREG%type index by binary_integer;
	type tytbUSUARIO is table of LDC_ACTBLOQ.USUARIO%type index by binary_integer;
	type tytbTERMINAL is table of LDC_ACTBLOQ.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ACTBLOQ is record
	(
		BLOQUEOD_ID   tytbBLOQUEOD_ID,
		IDMAESTRO   tytbIDMAESTRO,
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		ACTIVITY_ID   tytbACTIVITY_ID,
		FECHAREG   tytbFECHAREG,
		USUARIO   tytbUSUARIO,
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
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	);

	PROCEDURE getRecord
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		orcRecord out nocopy styLDC_ACTBLOQ
	);

	FUNCTION frcGetRcData
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN styLDC_ACTBLOQ;

	FUNCTION frcGetRcData
	RETURN styLDC_ACTBLOQ;

	FUNCTION frcGetRecord
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN styLDC_ACTBLOQ;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ACTBLOQ
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ACTBLOQ in styLDC_ACTBLOQ
	);

	PROCEDURE insRecord
	(
		ircLDC_ACTBLOQ in styLDC_ACTBLOQ,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ACTBLOQ in out nocopy tytbLDC_ACTBLOQ
	);

	PROCEDURE delRecord
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ACTBLOQ in out nocopy tytbLDC_ACTBLOQ,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ACTBLOQ in styLDC_ACTBLOQ,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ACTBLOQ in out nocopy tytbLDC_ACTBLOQ,
		inuLock in number default 1
	);

	PROCEDURE updIDMAESTRO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuIDMAESTRO$ in LDC_ACTBLOQ.IDMAESTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updTASK_TYPE_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuTASK_TYPE_ID$ in LDC_ACTBLOQ.TASK_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVITY_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuACTIVITY_ID$ in LDC_ACTBLOQ.ACTIVITY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHAREG
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		idtFECHAREG$ in LDC_ACTBLOQ.FECHAREG%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		isbUSUARIO$ in LDC_ACTBLOQ.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		isbTERMINAL$ in LDC_ACTBLOQ.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetBLOQUEOD_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.BLOQUEOD_ID%type;

	FUNCTION fnuGetIDMAESTRO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.IDMAESTRO%type;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.TASK_TYPE_ID%type;

	FUNCTION fnuGetACTIVITY_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.ACTIVITY_ID%type;

	FUNCTION fdtGetFECHAREG
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.FECHAREG%type;

	FUNCTION fsbGetUSUARIO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.USUARIO%type;

	FUNCTION fsbGetTERMINAL
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		orcLDC_ACTBLOQ  out styLDC_ACTBLOQ
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ACTBLOQ  out styLDC_ACTBLOQ
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ACTBLOQ;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ACTBLOQ
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ACTBLOQ';
	 cnuGeEntityId constant varchar2(30) := 2852; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	IS
		SELECT LDC_ACTBLOQ.*,LDC_ACTBLOQ.rowid
		FROM LDC_ACTBLOQ
		WHERE  BLOQUEOD_ID = inuBLOQUEOD_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ACTBLOQ.*,LDC_ACTBLOQ.rowid
		FROM LDC_ACTBLOQ
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ACTBLOQ is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ACTBLOQ;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ACTBLOQ default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BLOQUEOD_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		orcLDC_ACTBLOQ  out styLDC_ACTBLOQ
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

		Open cuLockRcByPk
		(
			inuBLOQUEOD_ID
		);

		fetch cuLockRcByPk into orcLDC_ACTBLOQ;
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
		orcLDC_ACTBLOQ  out styLDC_ACTBLOQ
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ACTBLOQ;
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
		itbLDC_ACTBLOQ  in out nocopy tytbLDC_ACTBLOQ
	)
	IS
	BEGIN
			rcRecOfTab.BLOQUEOD_ID.delete;
			rcRecOfTab.IDMAESTRO.delete;
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.ACTIVITY_ID.delete;
			rcRecOfTab.FECHAREG.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ACTBLOQ  in out nocopy tytbLDC_ACTBLOQ,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ACTBLOQ);

		for n in itbLDC_ACTBLOQ.first .. itbLDC_ACTBLOQ.last loop
			rcRecOfTab.BLOQUEOD_ID(n) := itbLDC_ACTBLOQ(n).BLOQUEOD_ID;
			rcRecOfTab.IDMAESTRO(n) := itbLDC_ACTBLOQ(n).IDMAESTRO;
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_ACTBLOQ(n).TASK_TYPE_ID;
			rcRecOfTab.ACTIVITY_ID(n) := itbLDC_ACTBLOQ(n).ACTIVITY_ID;
			rcRecOfTab.FECHAREG(n) := itbLDC_ACTBLOQ(n).FECHAREG;
			rcRecOfTab.USUARIO(n) := itbLDC_ACTBLOQ(n).USUARIO;
			rcRecOfTab.TERMINAL(n) := itbLDC_ACTBLOQ(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_ACTBLOQ(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBLOQUEOD_ID
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
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBLOQUEOD_ID = rcData.BLOQUEOD_ID
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
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBLOQUEOD_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN		rcError.BLOQUEOD_ID:=inuBLOQUEOD_ID;

		Load
		(
			inuBLOQUEOD_ID
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
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuBLOQUEOD_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		orcRecord out nocopy styLDC_ACTBLOQ
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN		rcError.BLOQUEOD_ID:=inuBLOQUEOD_ID;

		Load
		(
			inuBLOQUEOD_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN styLDC_ACTBLOQ
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID:=inuBLOQUEOD_ID;

		Load
		(
			inuBLOQUEOD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type
	)
	RETURN styLDC_ACTBLOQ
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID:=inuBLOQUEOD_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuBLOQUEOD_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBLOQUEOD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ACTBLOQ
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ACTBLOQ
	)
	IS
		rfLDC_ACTBLOQ tyrfLDC_ACTBLOQ;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ACTBLOQ.*, LDC_ACTBLOQ.rowid FROM LDC_ACTBLOQ';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ACTBLOQ for sbFullQuery;

		fetch rfLDC_ACTBLOQ bulk collect INTO otbResult;

		close rfLDC_ACTBLOQ;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ACTBLOQ.*, LDC_ACTBLOQ.rowid FROM LDC_ACTBLOQ';
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
		ircLDC_ACTBLOQ in styLDC_ACTBLOQ
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ACTBLOQ,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ACTBLOQ in styLDC_ACTBLOQ,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ACTBLOQ.BLOQUEOD_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BLOQUEOD_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ACTBLOQ
		(
			BLOQUEOD_ID,
			IDMAESTRO,
			TASK_TYPE_ID,
			ACTIVITY_ID,
			FECHAREG,
			USUARIO,
			TERMINAL
		)
		values
		(
			ircLDC_ACTBLOQ.BLOQUEOD_ID,
			ircLDC_ACTBLOQ.IDMAESTRO,
			ircLDC_ACTBLOQ.TASK_TYPE_ID,
			ircLDC_ACTBLOQ.ACTIVITY_ID,
			ircLDC_ACTBLOQ.FECHAREG,
			ircLDC_ACTBLOQ.USUARIO,
			ircLDC_ACTBLOQ.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ACTBLOQ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ACTBLOQ in out nocopy tytbLDC_ACTBLOQ
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTBLOQ,blUseRowID);
		forall n in iotbLDC_ACTBLOQ.first..iotbLDC_ACTBLOQ.last
			insert into LDC_ACTBLOQ
			(
				BLOQUEOD_ID,
				IDMAESTRO,
				TASK_TYPE_ID,
				ACTIVITY_ID,
				FECHAREG,
				USUARIO,
				TERMINAL
			)
			values
			(
				rcRecOfTab.BLOQUEOD_ID(n),
				rcRecOfTab.IDMAESTRO(n),
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.ACTIVITY_ID(n),
				rcRecOfTab.FECHAREG(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;


		delete
		from LDC_ACTBLOQ
		where
       		BLOQUEOD_ID=inuBLOQUEOD_ID;
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
		rcError  styLDC_ACTBLOQ;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ACTBLOQ
		where
			rowid = iriRowID
		returning
			BLOQUEOD_ID
		into
			rcError.BLOQUEOD_ID;
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
		iotbLDC_ACTBLOQ in out nocopy tytbLDC_ACTBLOQ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ACTBLOQ;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTBLOQ, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last
				delete
				from LDC_ACTBLOQ
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last loop
					LockByPk
					(
						rcRecOfTab.BLOQUEOD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last
				delete
				from LDC_ACTBLOQ
				where
		         	BLOQUEOD_ID = rcRecOfTab.BLOQUEOD_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ACTBLOQ in styLDC_ACTBLOQ,
		inuLock in number default 0
	)
	IS
		nuBLOQUEOD_ID	LDC_ACTBLOQ.BLOQUEOD_ID%type;
	BEGIN
		if ircLDC_ACTBLOQ.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ACTBLOQ.rowid,rcData);
			end if;
			update LDC_ACTBLOQ
			set
				IDMAESTRO = ircLDC_ACTBLOQ.IDMAESTRO,
				TASK_TYPE_ID = ircLDC_ACTBLOQ.TASK_TYPE_ID,
				ACTIVITY_ID = ircLDC_ACTBLOQ.ACTIVITY_ID,
				FECHAREG = ircLDC_ACTBLOQ.FECHAREG,
				USUARIO = ircLDC_ACTBLOQ.USUARIO,
				TERMINAL = ircLDC_ACTBLOQ.TERMINAL
			where
				rowid = ircLDC_ACTBLOQ.rowid
			returning
				BLOQUEOD_ID
			into
				nuBLOQUEOD_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ACTBLOQ.BLOQUEOD_ID,
					rcData
				);
			end if;

			update LDC_ACTBLOQ
			set
				IDMAESTRO = ircLDC_ACTBLOQ.IDMAESTRO,
				TASK_TYPE_ID = ircLDC_ACTBLOQ.TASK_TYPE_ID,
				ACTIVITY_ID = ircLDC_ACTBLOQ.ACTIVITY_ID,
				FECHAREG = ircLDC_ACTBLOQ.FECHAREG,
				USUARIO = ircLDC_ACTBLOQ.USUARIO,
				TERMINAL = ircLDC_ACTBLOQ.TERMINAL
			where
				BLOQUEOD_ID = ircLDC_ACTBLOQ.BLOQUEOD_ID
			returning
				BLOQUEOD_ID
			into
				nuBLOQUEOD_ID;
		end if;
		if
			nuBLOQUEOD_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ACTBLOQ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ACTBLOQ in out nocopy tytbLDC_ACTBLOQ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ACTBLOQ;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTBLOQ,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last
				update LDC_ACTBLOQ
				set
					IDMAESTRO = rcRecOfTab.IDMAESTRO(n),
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					FECHAREG = rcRecOfTab.FECHAREG(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last loop
					LockByPk
					(
						rcRecOfTab.BLOQUEOD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTBLOQ.first .. iotbLDC_ACTBLOQ.last
				update LDC_ACTBLOQ
				SET
					IDMAESTRO = rcRecOfTab.IDMAESTRO(n),
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					FECHAREG = rcRecOfTab.FECHAREG(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					BLOQUEOD_ID = rcRecOfTab.BLOQUEOD_ID(n)
;
		end if;
	END;
	PROCEDURE updIDMAESTRO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuIDMAESTRO$ in LDC_ACTBLOQ.IDMAESTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;

		update LDC_ACTBLOQ
		set
			IDMAESTRO = inuIDMAESTRO$
		where
			BLOQUEOD_ID = inuBLOQUEOD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDMAESTRO:= inuIDMAESTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTASK_TYPE_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuTASK_TYPE_ID$ in LDC_ACTBLOQ.TASK_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;

		update LDC_ACTBLOQ
		set
			TASK_TYPE_ID = inuTASK_TYPE_ID$
		where
			BLOQUEOD_ID = inuBLOQUEOD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TASK_TYPE_ID:= inuTASK_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVITY_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuACTIVITY_ID$ in LDC_ACTBLOQ.ACTIVITY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;

		update LDC_ACTBLOQ
		set
			ACTIVITY_ID = inuACTIVITY_ID$
		where
			BLOQUEOD_ID = inuBLOQUEOD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVITY_ID:= inuACTIVITY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHAREG
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		idtFECHAREG$ in LDC_ACTBLOQ.FECHAREG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;

		update LDC_ACTBLOQ
		set
			FECHAREG = idtFECHAREG$
		where
			BLOQUEOD_ID = inuBLOQUEOD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHAREG:= idtFECHAREG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		isbUSUARIO$ in LDC_ACTBLOQ.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;

		update LDC_ACTBLOQ
		set
			USUARIO = isbUSUARIO$
		where
			BLOQUEOD_ID = inuBLOQUEOD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		isbTERMINAL$ in LDC_ACTBLOQ.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN
		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOD_ID,
				rcData
			);
		end if;

		update LDC_ACTBLOQ
		set
			TERMINAL = isbTERMINAL$
		where
			BLOQUEOD_ID = inuBLOQUEOD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetBLOQUEOD_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.BLOQUEOD_ID%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.BLOQUEOD_ID);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
		);
		return(rcData.BLOQUEOD_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDMAESTRO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.IDMAESTRO%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.IDMAESTRO);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
		);
		return(rcData.IDMAESTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.TASK_TYPE_ID%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
		);
		return(rcData.TASK_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetACTIVITY_ID
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.ACTIVITY_ID%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.ACTIVITY_ID);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
		);
		return(rcData.ACTIVITY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHAREG
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.FECHAREG%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.FECHAREG);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
		);
		return(rcData.FECHAREG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO
	(
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.USUARIO%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
		);
		return(rcData.USUARIO);
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
		inuBLOQUEOD_ID in LDC_ACTBLOQ.BLOQUEOD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTBLOQ.TERMINAL%type
	IS
		rcError styLDC_ACTBLOQ;
	BEGIN

		rcError.BLOQUEOD_ID := inuBLOQUEOD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOD_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuBLOQUEOD_ID
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
end DALDC_ACTBLOQ;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ACTBLOQ
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ACTBLOQ', 'ADM_PERSON');
END;
/
