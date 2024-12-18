CREATE OR REPLACE PACKAGE adm_person.daldc_construction_service
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	IS
		SELECT LDC_CONSTRUCTION_SERVICE.*,LDC_CONSTRUCTION_SERVICE.rowid
		FROM LDC_CONSTRUCTION_SERVICE
		WHERE
		    CONSTRUCTION_SERVICE_ID = inuCONSTRUCTION_SERVICE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CONSTRUCTION_SERVICE.*,LDC_CONSTRUCTION_SERVICE.rowid
		FROM LDC_CONSTRUCTION_SERVICE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CONSTRUCTION_SERVICE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CONSTRUCTION_SERVICE is table of styLDC_CONSTRUCTION_SERVICE index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CONSTRUCTION_SERVICE;

	/* Tipos referenciando al registro */
	type tytbTYPE_ is table of LDC_CONSTRUCTION_SERVICE.TYPE_%type index by binary_integer;
	type tytbITEMS_ID is table of LDC_CONSTRUCTION_SERVICE.ITEMS_ID%type index by binary_integer;
	type tytbACTIVITY_ID is table of LDC_CONSTRUCTION_SERVICE.ACTIVITY_ID%type index by binary_integer;
	type tytbCLAS_CONTABLE is table of LDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE%type index by binary_integer;
	type tytbCONSTRUCTION_SERVICE_ID is table of LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CONSTRUCTION_SERVICE is record
	(
		TYPE_   tytbTYPE_,
		ITEMS_ID   tytbITEMS_ID,
		ACTIVITY_ID   tytbACTIVITY_ID,
		CLAS_CONTABLE   tytbCLAS_CONTABLE,
		CONSTRUCTION_SERVICE_ID   tytbCONSTRUCTION_SERVICE_ID,
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
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	);

	PROCEDURE getRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		orcRecord out nocopy styLDC_CONSTRUCTION_SERVICE
	);

	FUNCTION frcGetRcData
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN styLDC_CONSTRUCTION_SERVICE;

	FUNCTION frcGetRcData
	RETURN styLDC_CONSTRUCTION_SERVICE;

	FUNCTION frcGetRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN styLDC_CONSTRUCTION_SERVICE;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONSTRUCTION_SERVICE
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CONSTRUCTION_SERVICE in styLDC_CONSTRUCTION_SERVICE
	);

	PROCEDURE insRecord
	(
		ircLDC_CONSTRUCTION_SERVICE in styLDC_CONSTRUCTION_SERVICE,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CONSTRUCTION_SERVICE in out nocopy tytbLDC_CONSTRUCTION_SERVICE
	);

	PROCEDURE delRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CONSTRUCTION_SERVICE in out nocopy tytbLDC_CONSTRUCTION_SERVICE,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CONSTRUCTION_SERVICE in styLDC_CONSTRUCTION_SERVICE,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CONSTRUCTION_SERVICE in out nocopy tytbLDC_CONSTRUCTION_SERVICE,
		inuLock in number default 1
	);

	PROCEDURE updTYPE_
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		isbTYPE_$ in LDC_CONSTRUCTION_SERVICE.TYPE_%type,
		inuLock in number default 0
	);

	PROCEDURE updITEMS_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuITEMS_ID$ in LDC_CONSTRUCTION_SERVICE.ITEMS_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVITY_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuACTIVITY_ID$ in LDC_CONSTRUCTION_SERVICE.ACTIVITY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCLAS_CONTABLE
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuCLAS_CONTABLE$ in LDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetTYPE_
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.TYPE_%type;

	FUNCTION fnuGetITEMS_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.ITEMS_ID%type;

	FUNCTION fnuGetACTIVITY_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.ACTIVITY_ID%type;

	FUNCTION fnuGetCLAS_CONTABLE
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE%type;

	FUNCTION fnuGetCONSTRUCTION_SERVICE_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type;


	PROCEDURE LockByPk
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		orcLDC_CONSTRUCTION_SERVICE  out styLDC_CONSTRUCTION_SERVICE
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONSTRUCTION_SERVICE  out styLDC_CONSTRUCTION_SERVICE
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CONSTRUCTION_SERVICE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CONSTRUCTION_SERVICE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CONSTRUCTION_SERVICE';
	 cnuGeEntityId constant varchar2(30) := 8232; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	IS
		SELECT LDC_CONSTRUCTION_SERVICE.*,LDC_CONSTRUCTION_SERVICE.rowid
		FROM LDC_CONSTRUCTION_SERVICE
		WHERE  CONSTRUCTION_SERVICE_ID = inuCONSTRUCTION_SERVICE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CONSTRUCTION_SERVICE.*,LDC_CONSTRUCTION_SERVICE.rowid
		FROM LDC_CONSTRUCTION_SERVICE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CONSTRUCTION_SERVICE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CONSTRUCTION_SERVICE;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CONSTRUCTION_SERVICE default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSTRUCTION_SERVICE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		orcLDC_CONSTRUCTION_SERVICE  out styLDC_CONSTRUCTION_SERVICE
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

		Open cuLockRcByPk
		(
			inuCONSTRUCTION_SERVICE_ID
		);

		fetch cuLockRcByPk into orcLDC_CONSTRUCTION_SERVICE;
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
		orcLDC_CONSTRUCTION_SERVICE  out styLDC_CONSTRUCTION_SERVICE
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CONSTRUCTION_SERVICE;
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
		itbLDC_CONSTRUCTION_SERVICE  in out nocopy tytbLDC_CONSTRUCTION_SERVICE
	)
	IS
	BEGIN
			rcRecOfTab.TYPE_.delete;
			rcRecOfTab.ITEMS_ID.delete;
			rcRecOfTab.ACTIVITY_ID.delete;
			rcRecOfTab.CLAS_CONTABLE.delete;
			rcRecOfTab.CONSTRUCTION_SERVICE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CONSTRUCTION_SERVICE  in out nocopy tytbLDC_CONSTRUCTION_SERVICE,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CONSTRUCTION_SERVICE);

		for n in itbLDC_CONSTRUCTION_SERVICE.first .. itbLDC_CONSTRUCTION_SERVICE.last loop
			rcRecOfTab.TYPE_(n) := itbLDC_CONSTRUCTION_SERVICE(n).TYPE_;
			rcRecOfTab.ITEMS_ID(n) := itbLDC_CONSTRUCTION_SERVICE(n).ITEMS_ID;
			rcRecOfTab.ACTIVITY_ID(n) := itbLDC_CONSTRUCTION_SERVICE(n).ACTIVITY_ID;
			rcRecOfTab.CLAS_CONTABLE(n) := itbLDC_CONSTRUCTION_SERVICE(n).CLAS_CONTABLE;
			rcRecOfTab.CONSTRUCTION_SERVICE_ID(n) := itbLDC_CONSTRUCTION_SERVICE(n).CONSTRUCTION_SERVICE_ID;
			rcRecOfTab.row_id(n) := itbLDC_CONSTRUCTION_SERVICE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSTRUCTION_SERVICE_ID
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
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSTRUCTION_SERVICE_ID = rcData.CONSTRUCTION_SERVICE_ID
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
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSTRUCTION_SERVICE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN		rcError.CONSTRUCTION_SERVICE_ID:=inuCONSTRUCTION_SERVICE_ID;

		Load
		(
			inuCONSTRUCTION_SERVICE_ID
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
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSTRUCTION_SERVICE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		orcRecord out nocopy styLDC_CONSTRUCTION_SERVICE
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN		rcError.CONSTRUCTION_SERVICE_ID:=inuCONSTRUCTION_SERVICE_ID;

		Load
		(
			inuCONSTRUCTION_SERVICE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN styLDC_CONSTRUCTION_SERVICE
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID:=inuCONSTRUCTION_SERVICE_ID;

		Load
		(
			inuCONSTRUCTION_SERVICE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	)
	RETURN styLDC_CONSTRUCTION_SERVICE
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID:=inuCONSTRUCTION_SERVICE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSTRUCTION_SERVICE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSTRUCTION_SERVICE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CONSTRUCTION_SERVICE
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONSTRUCTION_SERVICE
	)
	IS
		rfLDC_CONSTRUCTION_SERVICE tyrfLDC_CONSTRUCTION_SERVICE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CONSTRUCTION_SERVICE.*, LDC_CONSTRUCTION_SERVICE.rowid FROM LDC_CONSTRUCTION_SERVICE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CONSTRUCTION_SERVICE for sbFullQuery;

		fetch rfLDC_CONSTRUCTION_SERVICE bulk collect INTO otbResult;

		close rfLDC_CONSTRUCTION_SERVICE;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CONSTRUCTION_SERVICE.*, LDC_CONSTRUCTION_SERVICE.rowid FROM LDC_CONSTRUCTION_SERVICE';
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
		ircLDC_CONSTRUCTION_SERVICE in styLDC_CONSTRUCTION_SERVICE
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CONSTRUCTION_SERVICE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONSTRUCTION_SERVICE in styLDC_CONSTRUCTION_SERVICE,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSTRUCTION_SERVICE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CONSTRUCTION_SERVICE
		(
			TYPE_,
			ITEMS_ID,
			ACTIVITY_ID,
			CLAS_CONTABLE,
			CONSTRUCTION_SERVICE_ID
		)
		values
		(
			ircLDC_CONSTRUCTION_SERVICE.TYPE_,
			ircLDC_CONSTRUCTION_SERVICE.ITEMS_ID,
			ircLDC_CONSTRUCTION_SERVICE.ACTIVITY_ID,
			ircLDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE,
			ircLDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CONSTRUCTION_SERVICE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CONSTRUCTION_SERVICE in out nocopy tytbLDC_CONSTRUCTION_SERVICE
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CONSTRUCTION_SERVICE,blUseRowID);
		forall n in iotbLDC_CONSTRUCTION_SERVICE.first..iotbLDC_CONSTRUCTION_SERVICE.last
			insert into LDC_CONSTRUCTION_SERVICE
			(
				TYPE_,
				ITEMS_ID,
				ACTIVITY_ID,
				CLAS_CONTABLE,
				CONSTRUCTION_SERVICE_ID
			)
			values
			(
				rcRecOfTab.TYPE_(n),
				rcRecOfTab.ITEMS_ID(n),
				rcRecOfTab.ACTIVITY_ID(n),
				rcRecOfTab.CLAS_CONTABLE(n),
				rcRecOfTab.CONSTRUCTION_SERVICE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCONSTRUCTION_SERVICE_ID,
				rcData
			);
		end if;


		delete
		from LDC_CONSTRUCTION_SERVICE
		where
       		CONSTRUCTION_SERVICE_ID=inuCONSTRUCTION_SERVICE_ID;
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
		rcError  styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CONSTRUCTION_SERVICE
		where
			rowid = iriRowID
		returning
			TYPE_
		into
			rcError.TYPE_;
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
		iotbLDC_CONSTRUCTION_SERVICE in out nocopy tytbLDC_CONSTRUCTION_SERVICE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		FillRecordOfTables(iotbLDC_CONSTRUCTION_SERVICE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last
				delete
				from LDC_CONSTRUCTION_SERVICE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last loop
					LockByPk
					(
						rcRecOfTab.CONSTRUCTION_SERVICE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last
				delete
				from LDC_CONSTRUCTION_SERVICE
				where
		         	CONSTRUCTION_SERVICE_ID = rcRecOfTab.CONSTRUCTION_SERVICE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CONSTRUCTION_SERVICE in styLDC_CONSTRUCTION_SERVICE,
		inuLock in number default 0
	)
	IS
		nuCONSTRUCTION_SERVICE_ID	LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type;
	BEGIN
		if ircLDC_CONSTRUCTION_SERVICE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CONSTRUCTION_SERVICE.rowid,rcData);
			end if;
			update LDC_CONSTRUCTION_SERVICE
			set
				TYPE_ = ircLDC_CONSTRUCTION_SERVICE.TYPE_,
				ITEMS_ID = ircLDC_CONSTRUCTION_SERVICE.ITEMS_ID,
				ACTIVITY_ID = ircLDC_CONSTRUCTION_SERVICE.ACTIVITY_ID,
				CLAS_CONTABLE = ircLDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE
			where
				rowid = ircLDC_CONSTRUCTION_SERVICE.rowid
			returning
				CONSTRUCTION_SERVICE_ID
			into
				nuCONSTRUCTION_SERVICE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID,
					rcData
				);
			end if;

			update LDC_CONSTRUCTION_SERVICE
			set
				TYPE_ = ircLDC_CONSTRUCTION_SERVICE.TYPE_,
				ITEMS_ID = ircLDC_CONSTRUCTION_SERVICE.ITEMS_ID,
				ACTIVITY_ID = ircLDC_CONSTRUCTION_SERVICE.ACTIVITY_ID,
				CLAS_CONTABLE = ircLDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE
			where
				CONSTRUCTION_SERVICE_ID = ircLDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID
			returning
				CONSTRUCTION_SERVICE_ID
			into
				nuCONSTRUCTION_SERVICE_ID;
		end if;
		if
			nuCONSTRUCTION_SERVICE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CONSTRUCTION_SERVICE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CONSTRUCTION_SERVICE in out nocopy tytbLDC_CONSTRUCTION_SERVICE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		FillRecordOfTables(iotbLDC_CONSTRUCTION_SERVICE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last
				update LDC_CONSTRUCTION_SERVICE
				set
					TYPE_ = rcRecOfTab.TYPE_(n),
					ITEMS_ID = rcRecOfTab.ITEMS_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					CLAS_CONTABLE = rcRecOfTab.CLAS_CONTABLE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last loop
					LockByPk
					(
						rcRecOfTab.CONSTRUCTION_SERVICE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSTRUCTION_SERVICE.first .. iotbLDC_CONSTRUCTION_SERVICE.last
				update LDC_CONSTRUCTION_SERVICE
				SET
					TYPE_ = rcRecOfTab.TYPE_(n),
					ITEMS_ID = rcRecOfTab.ITEMS_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					CLAS_CONTABLE = rcRecOfTab.CLAS_CONTABLE(n)
				where
					CONSTRUCTION_SERVICE_ID = rcRecOfTab.CONSTRUCTION_SERVICE_ID(n)
;
		end if;
	END;
	PROCEDURE updTYPE_
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		isbTYPE_$ in LDC_CONSTRUCTION_SERVICE.TYPE_%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONSTRUCTION_SERVICE_ID,
				rcData
			);
		end if;

		update LDC_CONSTRUCTION_SERVICE
		set
			TYPE_ = isbTYPE_$
		where
			CONSTRUCTION_SERVICE_ID = inuCONSTRUCTION_SERVICE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_:= isbTYPE_$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEMS_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuITEMS_ID$ in LDC_CONSTRUCTION_SERVICE.ITEMS_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONSTRUCTION_SERVICE_ID,
				rcData
			);
		end if;

		update LDC_CONSTRUCTION_SERVICE
		set
			ITEMS_ID = inuITEMS_ID$
		where
			CONSTRUCTION_SERVICE_ID = inuCONSTRUCTION_SERVICE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEMS_ID:= inuITEMS_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVITY_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuACTIVITY_ID$ in LDC_CONSTRUCTION_SERVICE.ACTIVITY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONSTRUCTION_SERVICE_ID,
				rcData
			);
		end if;

		update LDC_CONSTRUCTION_SERVICE
		set
			ACTIVITY_ID = inuACTIVITY_ID$
		where
			CONSTRUCTION_SERVICE_ID = inuCONSTRUCTION_SERVICE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVITY_ID:= inuACTIVITY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLAS_CONTABLE
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuCLAS_CONTABLE$ in LDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN
		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONSTRUCTION_SERVICE_ID,
				rcData
			);
		end if;

		update LDC_CONSTRUCTION_SERVICE
		set
			CLAS_CONTABLE = inuCLAS_CONTABLE$
		where
			CONSTRUCTION_SERVICE_ID = inuCONSTRUCTION_SERVICE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLAS_CONTABLE:= inuCLAS_CONTABLE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetTYPE_
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.TYPE_%type
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN

		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSTRUCTION_SERVICE_ID
			 )
		then
			 return(rcData.TYPE_);
		end if;
		Load
		(
		 		inuCONSTRUCTION_SERVICE_ID
		);
		return(rcData.TYPE_);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITEMS_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.ITEMS_ID%type
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN

		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSTRUCTION_SERVICE_ID
			 )
		then
			 return(rcData.ITEMS_ID);
		end if;
		Load
		(
		 		inuCONSTRUCTION_SERVICE_ID
		);
		return(rcData.ITEMS_ID);
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
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.ACTIVITY_ID%type
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN

		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSTRUCTION_SERVICE_ID
			 )
		then
			 return(rcData.ACTIVITY_ID);
		end if;
		Load
		(
		 		inuCONSTRUCTION_SERVICE_ID
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
	FUNCTION fnuGetCLAS_CONTABLE
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.CLAS_CONTABLE%type
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN

		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSTRUCTION_SERVICE_ID
			 )
		then
			 return(rcData.CLAS_CONTABLE);
		end if;
		Load
		(
		 		inuCONSTRUCTION_SERVICE_ID
		);
		return(rcData.CLAS_CONTABLE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONSTRUCTION_SERVICE_ID
	(
		inuCONSTRUCTION_SERVICE_ID in LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSTRUCTION_SERVICE.CONSTRUCTION_SERVICE_ID%type
	IS
		rcError styLDC_CONSTRUCTION_SERVICE;
	BEGIN

		rcError.CONSTRUCTION_SERVICE_ID := inuCONSTRUCTION_SERVICE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSTRUCTION_SERVICE_ID
			 )
		then
			 return(rcData.CONSTRUCTION_SERVICE_ID);
		end if;
		Load
		(
		 		inuCONSTRUCTION_SERVICE_ID
		);
		return(rcData.CONSTRUCTION_SERVICE_ID);
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
end DALDC_CONSTRUCTION_SERVICE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CONSTRUCTION_SERVICE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CONSTRUCTION_SERVICE', 'ADM_PERSON'); 
END;
/

