CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ACTCALLCENTER
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	IS
		SELECT LDC_ACTCALLCENTER.*,LDC_ACTCALLCENTER.rowid
		FROM LDC_ACTCALLCENTER
		WHERE
		    ACTCC_ID = inuACTCC_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ACTCALLCENTER.*,LDC_ACTCALLCENTER.rowid
		FROM LDC_ACTCALLCENTER
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ACTCALLCENTER  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ACTCALLCENTER is table of styLDC_ACTCALLCENTER index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ACTCALLCENTER;

	/* Tipos referenciando al registro */
	type tytbACTCC_ID is table of LDC_ACTCALLCENTER.ACTCC_ID%type index by binary_integer;
	type tytbTIPOINFO_ID is table of LDC_ACTCALLCENTER.TIPOINFO_ID%type index by binary_integer;
	type tytbFECHAREG is table of LDC_ACTCALLCENTER.FECHAREG%type index by binary_integer;
	type tytbOBSERVACION is table of LDC_ACTCALLCENTER.OBSERVACION%type index by binary_integer;
	type tytbPERSON_ID is table of LDC_ACTCALLCENTER.PERSON_ID%type index by binary_integer;
	type tytbTERMINAL is table of LDC_ACTCALLCENTER.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ACTCALLCENTER is record
	(
		ACTCC_ID   tytbACTCC_ID,
		TIPOINFO_ID   tytbTIPOINFO_ID,
		FECHAREG   tytbFECHAREG,
		OBSERVACION   tytbOBSERVACION,
		PERSON_ID   tytbPERSON_ID,
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	);

	PROCEDURE getRecord
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		orcRecord out nocopy styLDC_ACTCALLCENTER
	);

	FUNCTION frcGetRcData
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN styLDC_ACTCALLCENTER;

	FUNCTION frcGetRcData
	RETURN styLDC_ACTCALLCENTER;

	FUNCTION frcGetRecord
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN styLDC_ACTCALLCENTER;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ACTCALLCENTER
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ACTCALLCENTER in styLDC_ACTCALLCENTER
	);

	PROCEDURE insRecord
	(
		ircLDC_ACTCALLCENTER in styLDC_ACTCALLCENTER,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ACTCALLCENTER in out nocopy tytbLDC_ACTCALLCENTER
	);

	PROCEDURE delRecord
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ACTCALLCENTER in out nocopy tytbLDC_ACTCALLCENTER,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ACTCALLCENTER in styLDC_ACTCALLCENTER,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ACTCALLCENTER in out nocopy tytbLDC_ACTCALLCENTER,
		inuLock in number default 1
	);

	PROCEDURE updTIPOINFO_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuTIPOINFO_ID$ in LDC_ACTCALLCENTER.TIPOINFO_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHAREG
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		idtFECHAREG$ in LDC_ACTCALLCENTER.FECHAREG%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVACION
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		isbOBSERVACION$ in LDC_ACTCALLCENTER.OBSERVACION%type,
		inuLock in number default 0
	);

	PROCEDURE updPERSON_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuPERSON_ID$ in LDC_ACTCALLCENTER.PERSON_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		isbTERMINAL$ in LDC_ACTCALLCENTER.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetACTCC_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.ACTCC_ID%type;

	FUNCTION fnuGetTIPOINFO_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.TIPOINFO_ID%type;

	FUNCTION fdtGetFECHAREG
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.FECHAREG%type;

	FUNCTION fsbGetOBSERVACION
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.OBSERVACION%type;

	FUNCTION fnuGetPERSON_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.PERSON_ID%type;

	FUNCTION fsbGetTERMINAL
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		orcLDC_ACTCALLCENTER  out styLDC_ACTCALLCENTER
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ACTCALLCENTER  out styLDC_ACTCALLCENTER
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ACTCALLCENTER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ACTCALLCENTER
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ACTCALLCENTER';
	 cnuGeEntityId constant varchar2(30) := 2947; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	IS
		SELECT LDC_ACTCALLCENTER.*,LDC_ACTCALLCENTER.rowid
		FROM LDC_ACTCALLCENTER
		WHERE  ACTCC_ID = inuACTCC_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ACTCALLCENTER.*,LDC_ACTCALLCENTER.rowid
		FROM LDC_ACTCALLCENTER
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ACTCALLCENTER is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ACTCALLCENTER;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ACTCALLCENTER default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ACTCC_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		orcLDC_ACTCALLCENTER  out styLDC_ACTCALLCENTER
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;

		Open cuLockRcByPk
		(
			inuACTCC_ID
		);

		fetch cuLockRcByPk into orcLDC_ACTCALLCENTER;
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
		orcLDC_ACTCALLCENTER  out styLDC_ACTCALLCENTER
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ACTCALLCENTER;
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
		itbLDC_ACTCALLCENTER  in out nocopy tytbLDC_ACTCALLCENTER
	)
	IS
	BEGIN
			rcRecOfTab.ACTCC_ID.delete;
			rcRecOfTab.TIPOINFO_ID.delete;
			rcRecOfTab.FECHAREG.delete;
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.PERSON_ID.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ACTCALLCENTER  in out nocopy tytbLDC_ACTCALLCENTER,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ACTCALLCENTER);

		for n in itbLDC_ACTCALLCENTER.first .. itbLDC_ACTCALLCENTER.last loop
			rcRecOfTab.ACTCC_ID(n) := itbLDC_ACTCALLCENTER(n).ACTCC_ID;
			rcRecOfTab.TIPOINFO_ID(n) := itbLDC_ACTCALLCENTER(n).TIPOINFO_ID;
			rcRecOfTab.FECHAREG(n) := itbLDC_ACTCALLCENTER(n).FECHAREG;
			rcRecOfTab.OBSERVACION(n) := itbLDC_ACTCALLCENTER(n).OBSERVACION;
			rcRecOfTab.PERSON_ID(n) := itbLDC_ACTCALLCENTER(n).PERSON_ID;
			rcRecOfTab.TERMINAL(n) := itbLDC_ACTCALLCENTER(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_ACTCALLCENTER(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuACTCC_ID
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuACTCC_ID = rcData.ACTCC_ID
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuACTCC_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN		rcError.ACTCC_ID:=inuACTCC_ID;

		Load
		(
			inuACTCC_ID
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuACTCC_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		orcRecord out nocopy styLDC_ACTCALLCENTER
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN		rcError.ACTCC_ID:=inuACTCC_ID;

		Load
		(
			inuACTCC_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN styLDC_ACTCALLCENTER
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID:=inuACTCC_ID;

		Load
		(
			inuACTCC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type
	)
	RETURN styLDC_ACTCALLCENTER
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID:=inuACTCC_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuACTCC_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuACTCC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ACTCALLCENTER
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ACTCALLCENTER
	)
	IS
		rfLDC_ACTCALLCENTER tyrfLDC_ACTCALLCENTER;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ACTCALLCENTER.*, LDC_ACTCALLCENTER.rowid FROM LDC_ACTCALLCENTER';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ACTCALLCENTER for sbFullQuery;

		fetch rfLDC_ACTCALLCENTER bulk collect INTO otbResult;

		close rfLDC_ACTCALLCENTER;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ACTCALLCENTER.*, LDC_ACTCALLCENTER.rowid FROM LDC_ACTCALLCENTER';
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
		ircLDC_ACTCALLCENTER in styLDC_ACTCALLCENTER
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ACTCALLCENTER,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ACTCALLCENTER in styLDC_ACTCALLCENTER,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ACTCALLCENTER.ACTCC_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ACTCC_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ACTCALLCENTER
		(
			ACTCC_ID,
			TIPOINFO_ID,
			FECHAREG,
			OBSERVACION,
			PERSON_ID,
			TERMINAL
		)
		values
		(
			ircLDC_ACTCALLCENTER.ACTCC_ID,
			ircLDC_ACTCALLCENTER.TIPOINFO_ID,
			ircLDC_ACTCALLCENTER.FECHAREG,
			ircLDC_ACTCALLCENTER.OBSERVACION,
			ircLDC_ACTCALLCENTER.PERSON_ID,
			ircLDC_ACTCALLCENTER.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ACTCALLCENTER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ACTCALLCENTER in out nocopy tytbLDC_ACTCALLCENTER
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTCALLCENTER,blUseRowID);
		forall n in iotbLDC_ACTCALLCENTER.first..iotbLDC_ACTCALLCENTER.last
			insert into LDC_ACTCALLCENTER
			(
				ACTCC_ID,
				TIPOINFO_ID,
				FECHAREG,
				OBSERVACION,
				PERSON_ID,
				TERMINAL
			)
			values
			(
				rcRecOfTab.ACTCC_ID(n),
				rcRecOfTab.TIPOINFO_ID(n),
				rcRecOfTab.FECHAREG(n),
				rcRecOfTab.OBSERVACION(n),
				rcRecOfTab.PERSON_ID(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;

		if inuLock=1 then
			LockByPk
			(
				inuACTCC_ID,
				rcData
			);
		end if;


		delete
		from LDC_ACTCALLCENTER
		where
       		ACTCC_ID=inuACTCC_ID;
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
		rcError  styLDC_ACTCALLCENTER;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ACTCALLCENTER
		where
			rowid = iriRowID
		returning
			ACTCC_ID
		into
			rcError.ACTCC_ID;
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
		iotbLDC_ACTCALLCENTER in out nocopy tytbLDC_ACTCALLCENTER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ACTCALLCENTER;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTCALLCENTER, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last
				delete
				from LDC_ACTCALLCENTER
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last loop
					LockByPk
					(
						rcRecOfTab.ACTCC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last
				delete
				from LDC_ACTCALLCENTER
				where
		         	ACTCC_ID = rcRecOfTab.ACTCC_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ACTCALLCENTER in styLDC_ACTCALLCENTER,
		inuLock in number default 0
	)
	IS
		nuACTCC_ID	LDC_ACTCALLCENTER.ACTCC_ID%type;
	BEGIN
		if ircLDC_ACTCALLCENTER.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ACTCALLCENTER.rowid,rcData);
			end if;
			update LDC_ACTCALLCENTER
			set
				TIPOINFO_ID = ircLDC_ACTCALLCENTER.TIPOINFO_ID,
				FECHAREG = ircLDC_ACTCALLCENTER.FECHAREG,
				OBSERVACION = ircLDC_ACTCALLCENTER.OBSERVACION,
				PERSON_ID = ircLDC_ACTCALLCENTER.PERSON_ID,
				TERMINAL = ircLDC_ACTCALLCENTER.TERMINAL
			where
				rowid = ircLDC_ACTCALLCENTER.rowid
			returning
				ACTCC_ID
			into
				nuACTCC_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ACTCALLCENTER.ACTCC_ID,
					rcData
				);
			end if;

			update LDC_ACTCALLCENTER
			set
				TIPOINFO_ID = ircLDC_ACTCALLCENTER.TIPOINFO_ID,
				FECHAREG = ircLDC_ACTCALLCENTER.FECHAREG,
				OBSERVACION = ircLDC_ACTCALLCENTER.OBSERVACION,
				PERSON_ID = ircLDC_ACTCALLCENTER.PERSON_ID,
				TERMINAL = ircLDC_ACTCALLCENTER.TERMINAL
			where
				ACTCC_ID = ircLDC_ACTCALLCENTER.ACTCC_ID
			returning
				ACTCC_ID
			into
				nuACTCC_ID;
		end if;
		if
			nuACTCC_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ACTCALLCENTER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ACTCALLCENTER in out nocopy tytbLDC_ACTCALLCENTER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ACTCALLCENTER;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTCALLCENTER,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last
				update LDC_ACTCALLCENTER
				set
					TIPOINFO_ID = rcRecOfTab.TIPOINFO_ID(n),
					FECHAREG = rcRecOfTab.FECHAREG(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					PERSON_ID = rcRecOfTab.PERSON_ID(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last loop
					LockByPk
					(
						rcRecOfTab.ACTCC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTCALLCENTER.first .. iotbLDC_ACTCALLCENTER.last
				update LDC_ACTCALLCENTER
				SET
					TIPOINFO_ID = rcRecOfTab.TIPOINFO_ID(n),
					FECHAREG = rcRecOfTab.FECHAREG(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					PERSON_ID = rcRecOfTab.PERSON_ID(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					ACTCC_ID = rcRecOfTab.ACTCC_ID(n)
;
		end if;
	END;
	PROCEDURE updTIPOINFO_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuTIPOINFO_ID$ in LDC_ACTCALLCENTER.TIPOINFO_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuACTCC_ID,
				rcData
			);
		end if;

		update LDC_ACTCALLCENTER
		set
			TIPOINFO_ID = inuTIPOINFO_ID$
		where
			ACTCC_ID = inuACTCC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPOINFO_ID:= inuTIPOINFO_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHAREG
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		idtFECHAREG$ in LDC_ACTCALLCENTER.FECHAREG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuACTCC_ID,
				rcData
			);
		end if;

		update LDC_ACTCALLCENTER
		set
			FECHAREG = idtFECHAREG$
		where
			ACTCC_ID = inuACTCC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHAREG:= idtFECHAREG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVACION
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		isbOBSERVACION$ in LDC_ACTCALLCENTER.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuACTCC_ID,
				rcData
			);
		end if;

		update LDC_ACTCALLCENTER
		set
			OBSERVACION = isbOBSERVACION$
		where
			ACTCC_ID = inuACTCC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERSON_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuPERSON_ID$ in LDC_ACTCALLCENTER.PERSON_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuACTCC_ID,
				rcData
			);
		end if;

		update LDC_ACTCALLCENTER
		set
			PERSON_ID = inuPERSON_ID$
		where
			ACTCC_ID = inuACTCC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERSON_ID:= inuPERSON_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		isbTERMINAL$ in LDC_ACTCALLCENTER.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN
		rcError.ACTCC_ID := inuACTCC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuACTCC_ID,
				rcData
			);
		end if;

		update LDC_ACTCALLCENTER
		set
			TERMINAL = isbTERMINAL$
		where
			ACTCC_ID = inuACTCC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetACTCC_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.ACTCC_ID%type
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN

		rcError.ACTCC_ID := inuACTCC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuACTCC_ID
			 )
		then
			 return(rcData.ACTCC_ID);
		end if;
		Load
		(
		 		inuACTCC_ID
		);
		return(rcData.ACTCC_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPOINFO_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.TIPOINFO_ID%type
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN

		rcError.ACTCC_ID := inuACTCC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuACTCC_ID
			 )
		then
			 return(rcData.TIPOINFO_ID);
		end if;
		Load
		(
		 		inuACTCC_ID
		);
		return(rcData.TIPOINFO_ID);
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.FECHAREG%type
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN

		rcError.ACTCC_ID := inuACTCC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuACTCC_ID
			 )
		then
			 return(rcData.FECHAREG);
		end if;
		Load
		(
		 		inuACTCC_ID
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
	FUNCTION fsbGetOBSERVACION
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.OBSERVACION%type
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN

		rcError.ACTCC_ID := inuACTCC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuACTCC_ID
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuACTCC_ID
		);
		return(rcData.OBSERVACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERSON_ID
	(
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.PERSON_ID%type
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN

		rcError.ACTCC_ID := inuACTCC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuACTCC_ID
			 )
		then
			 return(rcData.PERSON_ID);
		end if;
		Load
		(
		 		inuACTCC_ID
		);
		return(rcData.PERSON_ID);
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
		inuACTCC_ID in LDC_ACTCALLCENTER.ACTCC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTCALLCENTER.TERMINAL%type
	IS
		rcError styLDC_ACTCALLCENTER;
	BEGIN

		rcError.ACTCC_ID := inuACTCC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuACTCC_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuACTCC_ID
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
end DALDC_ACTCALLCENTER;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ACTCALLCENTER
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ACTCALLCENTER', 'ADM_PERSON');
END;
/