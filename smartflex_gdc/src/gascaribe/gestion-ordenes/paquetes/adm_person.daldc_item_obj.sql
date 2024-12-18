CREATE OR REPLACE PACKAGE adm_person.DALDC_ITEM_OBJ
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     :  DALDC_ITEM_OBJ
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
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	IS
		SELECT LDC_ITEM_OBJ.*,LDC_ITEM_OBJ.rowid
		FROM LDC_ITEM_OBJ
		WHERE
		    ITEM_OBJ_ID = inuITEM_OBJ_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ITEM_OBJ.*,LDC_ITEM_OBJ.rowid
		FROM LDC_ITEM_OBJ
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ITEM_OBJ  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ITEM_OBJ is table of styLDC_ITEM_OBJ index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ITEM_OBJ;

	/* Tipos referenciando al registro */
	type tytbITEM_OBJ_ID is table of LDC_ITEM_OBJ.ITEM_OBJ_ID%type index by binary_integer;
	type tytbITEM_ID is table of LDC_ITEM_OBJ.ITEM_ID%type index by binary_integer;
	type tytbOBJECT_ID is table of LDC_ITEM_OBJ.OBJECT_ID%type index by binary_integer;
	type tytbIS_ACTIVE is table of LDC_ITEM_OBJ.IS_ACTIVE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ITEM_OBJ is record
	(
		ITEM_OBJ_ID   tytbITEM_OBJ_ID,
		ITEM_ID   tytbITEM_ID,
		OBJECT_ID   tytbOBJECT_ID,
		IS_ACTIVE   tytbIS_ACTIVE,
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
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	);

	PROCEDURE getRecord
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		orcRecord out nocopy styLDC_ITEM_OBJ
	);

	FUNCTION frcGetRcData
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN styLDC_ITEM_OBJ;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEM_OBJ;

	FUNCTION frcGetRecord
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN styLDC_ITEM_OBJ;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEM_OBJ
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ITEM_OBJ in styLDC_ITEM_OBJ
	);

	PROCEDURE insRecord
	(
		ircLDC_ITEM_OBJ in styLDC_ITEM_OBJ,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ITEM_OBJ in out nocopy tytbLDC_ITEM_OBJ
	);

	PROCEDURE delRecord
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ITEM_OBJ in out nocopy tytbLDC_ITEM_OBJ,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ITEM_OBJ in styLDC_ITEM_OBJ,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ITEM_OBJ in out nocopy tytbLDC_ITEM_OBJ,
		inuLock in number default 1
	);

	PROCEDURE updITEM_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuITEM_ID$ in LDC_ITEM_OBJ.ITEM_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updOBJECT_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuOBJECT_ID$ in LDC_ITEM_OBJ.OBJECT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_ACTIVE
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		isbIS_ACTIVE$ in LDC_ITEM_OBJ.IS_ACTIVE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetITEM_OBJ_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.ITEM_OBJ_ID%type;

	FUNCTION fnuGetITEM_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.ITEM_ID%type;

	FUNCTION fnuGetOBJECT_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.OBJECT_ID%type;

	FUNCTION fsbGetIS_ACTIVE
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.IS_ACTIVE%type;


	PROCEDURE LockByPk
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		orcLDC_ITEM_OBJ  out styLDC_ITEM_OBJ
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEM_OBJ  out styLDC_ITEM_OBJ
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ITEM_OBJ;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_ITEM_OBJ
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ITEM_OBJ';
	 cnuGeEntityId constant varchar2(30) := 8176; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	IS
		SELECT LDC_ITEM_OBJ.*,LDC_ITEM_OBJ.rowid
		FROM LDC_ITEM_OBJ
		WHERE  ITEM_OBJ_ID = inuITEM_OBJ_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ITEM_OBJ.*,LDC_ITEM_OBJ.rowid
		FROM LDC_ITEM_OBJ
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ITEM_OBJ is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ITEM_OBJ;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ITEM_OBJ default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ITEM_OBJ_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		orcLDC_ITEM_OBJ  out styLDC_ITEM_OBJ
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;

		Open cuLockRcByPk
		(
			inuITEM_OBJ_ID
		);

		fetch cuLockRcByPk into orcLDC_ITEM_OBJ;
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
		orcLDC_ITEM_OBJ  out styLDC_ITEM_OBJ
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ITEM_OBJ;
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
		itbLDC_ITEM_OBJ  in out nocopy tytbLDC_ITEM_OBJ
	)
	IS
	BEGIN
			rcRecOfTab.ITEM_OBJ_ID.delete;
			rcRecOfTab.ITEM_ID.delete;
			rcRecOfTab.OBJECT_ID.delete;
			rcRecOfTab.IS_ACTIVE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ITEM_OBJ  in out nocopy tytbLDC_ITEM_OBJ,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ITEM_OBJ);

		for n in itbLDC_ITEM_OBJ.first .. itbLDC_ITEM_OBJ.last loop
			rcRecOfTab.ITEM_OBJ_ID(n) := itbLDC_ITEM_OBJ(n).ITEM_OBJ_ID;
			rcRecOfTab.ITEM_ID(n) := itbLDC_ITEM_OBJ(n).ITEM_ID;
			rcRecOfTab.OBJECT_ID(n) := itbLDC_ITEM_OBJ(n).OBJECT_ID;
			rcRecOfTab.IS_ACTIVE(n) := itbLDC_ITEM_OBJ(n).IS_ACTIVE;
			rcRecOfTab.row_id(n) := itbLDC_ITEM_OBJ(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuITEM_OBJ_ID
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
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuITEM_OBJ_ID = rcData.ITEM_OBJ_ID
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
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuITEM_OBJ_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN		rcError.ITEM_OBJ_ID:=inuITEM_OBJ_ID;

		Load
		(
			inuITEM_OBJ_ID
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
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuITEM_OBJ_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		orcRecord out nocopy styLDC_ITEM_OBJ
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN		rcError.ITEM_OBJ_ID:=inuITEM_OBJ_ID;

		Load
		(
			inuITEM_OBJ_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN styLDC_ITEM_OBJ
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID:=inuITEM_OBJ_ID;

		Load
		(
			inuITEM_OBJ_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	)
	RETURN styLDC_ITEM_OBJ
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID:=inuITEM_OBJ_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuITEM_OBJ_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuITEM_OBJ_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEM_OBJ
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEM_OBJ
	)
	IS
		rfLDC_ITEM_OBJ tyrfLDC_ITEM_OBJ;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ITEM_OBJ.*, LDC_ITEM_OBJ.rowid FROM LDC_ITEM_OBJ';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ITEM_OBJ for sbFullQuery;

		fetch rfLDC_ITEM_OBJ bulk collect INTO otbResult;

		close rfLDC_ITEM_OBJ;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ITEM_OBJ.*, LDC_ITEM_OBJ.rowid FROM LDC_ITEM_OBJ';
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
		ircLDC_ITEM_OBJ in styLDC_ITEM_OBJ
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ITEM_OBJ,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEM_OBJ in styLDC_ITEM_OBJ,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ITEM_OBJ.ITEM_OBJ_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ITEM_OBJ_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ITEM_OBJ
		(
			ITEM_OBJ_ID,
			ITEM_ID,
			OBJECT_ID,
			IS_ACTIVE
		)
		values
		(
			ircLDC_ITEM_OBJ.ITEM_OBJ_ID,
			ircLDC_ITEM_OBJ.ITEM_ID,
			ircLDC_ITEM_OBJ.OBJECT_ID,
			ircLDC_ITEM_OBJ.IS_ACTIVE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ITEM_OBJ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ITEM_OBJ in out nocopy tytbLDC_ITEM_OBJ
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEM_OBJ,blUseRowID);
		forall n in iotbLDC_ITEM_OBJ.first..iotbLDC_ITEM_OBJ.last
			insert into LDC_ITEM_OBJ
			(
				ITEM_OBJ_ID,
				ITEM_ID,
				OBJECT_ID,
				IS_ACTIVE
			)
			values
			(
				rcRecOfTab.ITEM_OBJ_ID(n),
				rcRecOfTab.ITEM_ID(n),
				rcRecOfTab.OBJECT_ID(n),
				rcRecOfTab.IS_ACTIVE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;

		if inuLock=1 then
			LockByPk
			(
				inuITEM_OBJ_ID,
				rcData
			);
		end if;


		delete
		from LDC_ITEM_OBJ
		where
       		ITEM_OBJ_ID=inuITEM_OBJ_ID;
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
		rcError  styLDC_ITEM_OBJ;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ITEM_OBJ
		where
			rowid = iriRowID
		returning
			ITEM_OBJ_ID
		into
			rcError.ITEM_OBJ_ID;
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
		iotbLDC_ITEM_OBJ in out nocopy tytbLDC_ITEM_OBJ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEM_OBJ;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEM_OBJ, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last
				delete
				from LDC_ITEM_OBJ
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last loop
					LockByPk
					(
						rcRecOfTab.ITEM_OBJ_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last
				delete
				from LDC_ITEM_OBJ
				where
		         	ITEM_OBJ_ID = rcRecOfTab.ITEM_OBJ_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ITEM_OBJ in styLDC_ITEM_OBJ,
		inuLock in number default 0
	)
	IS
		nuITEM_OBJ_ID	LDC_ITEM_OBJ.ITEM_OBJ_ID%type;
	BEGIN
		if ircLDC_ITEM_OBJ.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ITEM_OBJ.rowid,rcData);
			end if;
			update LDC_ITEM_OBJ
			set
				ITEM_ID = ircLDC_ITEM_OBJ.ITEM_ID,
				OBJECT_ID = ircLDC_ITEM_OBJ.OBJECT_ID,
				IS_ACTIVE = ircLDC_ITEM_OBJ.IS_ACTIVE
			where
				rowid = ircLDC_ITEM_OBJ.rowid
			returning
				ITEM_OBJ_ID
			into
				nuITEM_OBJ_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ITEM_OBJ.ITEM_OBJ_ID,
					rcData
				);
			end if;

			update LDC_ITEM_OBJ
			set
				ITEM_ID = ircLDC_ITEM_OBJ.ITEM_ID,
				OBJECT_ID = ircLDC_ITEM_OBJ.OBJECT_ID,
				IS_ACTIVE = ircLDC_ITEM_OBJ.IS_ACTIVE
			where
				ITEM_OBJ_ID = ircLDC_ITEM_OBJ.ITEM_OBJ_ID
			returning
				ITEM_OBJ_ID
			into
				nuITEM_OBJ_ID;
		end if;
		if
			nuITEM_OBJ_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ITEM_OBJ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ITEM_OBJ in out nocopy tytbLDC_ITEM_OBJ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEM_OBJ;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEM_OBJ,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last
				update LDC_ITEM_OBJ
				set
					ITEM_ID = rcRecOfTab.ITEM_ID(n),
					OBJECT_ID = rcRecOfTab.OBJECT_ID(n),
					IS_ACTIVE = rcRecOfTab.IS_ACTIVE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last loop
					LockByPk
					(
						rcRecOfTab.ITEM_OBJ_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEM_OBJ.first .. iotbLDC_ITEM_OBJ.last
				update LDC_ITEM_OBJ
				SET
					ITEM_ID = rcRecOfTab.ITEM_ID(n),
					OBJECT_ID = rcRecOfTab.OBJECT_ID(n),
					IS_ACTIVE = rcRecOfTab.IS_ACTIVE(n)
				where
					ITEM_OBJ_ID = rcRecOfTab.ITEM_OBJ_ID(n)
;
		end if;
	END;
	PROCEDURE updITEM_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuITEM_ID$ in LDC_ITEM_OBJ.ITEM_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_OBJ_ID,
				rcData
			);
		end if;

		update LDC_ITEM_OBJ
		set
			ITEM_ID = inuITEM_ID$
		where
			ITEM_OBJ_ID = inuITEM_OBJ_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_ID:= inuITEM_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBJECT_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuOBJECT_ID$ in LDC_ITEM_OBJ.OBJECT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_OBJ_ID,
				rcData
			);
		end if;

		update LDC_ITEM_OBJ
		set
			OBJECT_ID = inuOBJECT_ID$
		where
			ITEM_OBJ_ID = inuITEM_OBJ_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBJECT_ID:= inuOBJECT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_ACTIVE
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		isbIS_ACTIVE$ in LDC_ITEM_OBJ.IS_ACTIVE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN
		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_OBJ_ID,
				rcData
			);
		end if;

		update LDC_ITEM_OBJ
		set
			IS_ACTIVE = isbIS_ACTIVE$
		where
			ITEM_OBJ_ID = inuITEM_OBJ_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_ACTIVE:= isbIS_ACTIVE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetITEM_OBJ_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.ITEM_OBJ_ID%type
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN

		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEM_OBJ_ID
			 )
		then
			 return(rcData.ITEM_OBJ_ID);
		end if;
		Load
		(
		 		inuITEM_OBJ_ID
		);
		return(rcData.ITEM_OBJ_ID);
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
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.ITEM_ID%type
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN

		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEM_OBJ_ID
			 )
		then
			 return(rcData.ITEM_ID);
		end if;
		Load
		(
		 		inuITEM_OBJ_ID
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
	FUNCTION fnuGetOBJECT_ID
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.OBJECT_ID%type
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN

		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEM_OBJ_ID
			 )
		then
			 return(rcData.OBJECT_ID);
		end if;
		Load
		(
		 		inuITEM_OBJ_ID
		);
		return(rcData.OBJECT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_ACTIVE
	(
		inuITEM_OBJ_ID in LDC_ITEM_OBJ.ITEM_OBJ_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEM_OBJ.IS_ACTIVE%type
	IS
		rcError styLDC_ITEM_OBJ;
	BEGIN

		rcError.ITEM_OBJ_ID := inuITEM_OBJ_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEM_OBJ_ID
			 )
		then
			 return(rcData.IS_ACTIVE);
		end if;
		Load
		(
		 		inuITEM_OBJ_ID
		);
		return(rcData.IS_ACTIVE);
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
end DALDC_ITEM_OBJ;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ITEM_OBJ
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ITEM_OBJ', 'ADM_PERSON');
END;
/