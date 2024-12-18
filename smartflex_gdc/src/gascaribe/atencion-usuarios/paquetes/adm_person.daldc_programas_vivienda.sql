CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PROGRAMAS_VIVIENDA
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     :  DALDC_PROGRAMAS_VIVIENDA
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
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	IS
		SELECT LDC_PROGRAMAS_VIVIENDA.*,LDC_PROGRAMAS_VIVIENDA.rowid
		FROM LDC_PROGRAMAS_VIVIENDA
		WHERE
		    PROG_VIV_ID = inuPROG_VIV_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PROGRAMAS_VIVIENDA.*,LDC_PROGRAMAS_VIVIENDA.rowid
		FROM LDC_PROGRAMAS_VIVIENDA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PROGRAMAS_VIVIENDA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PROGRAMAS_VIVIENDA is table of styLDC_PROGRAMAS_VIVIENDA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PROGRAMAS_VIVIENDA;

	/* Tipos referenciando al registro */
	type tytbPROG_VIV_ID is table of LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_PROGRAMAS_VIVIENDA.DESCRIPCION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PROGRAMAS_VIVIENDA is record
	(
		PROG_VIV_ID   tytbPROG_VIV_ID,
		DESCRIPCION   tytbDESCRIPCION,
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
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	);

	PROCEDURE getRecord
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		orcRecord out nocopy styLDC_PROGRAMAS_VIVIENDA
	);

	FUNCTION frcGetRcData
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN styLDC_PROGRAMAS_VIVIENDA;

	FUNCTION frcGetRcData
	RETURN styLDC_PROGRAMAS_VIVIENDA;

	FUNCTION frcGetRecord
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN styLDC_PROGRAMAS_VIVIENDA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROGRAMAS_VIVIENDA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PROGRAMAS_VIVIENDA in styLDC_PROGRAMAS_VIVIENDA
	);

	PROCEDURE insRecord
	(
		ircLDC_PROGRAMAS_VIVIENDA in styLDC_PROGRAMAS_VIVIENDA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PROGRAMAS_VIVIENDA in out nocopy tytbLDC_PROGRAMAS_VIVIENDA
	);

	PROCEDURE delRecord
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PROGRAMAS_VIVIENDA in out nocopy tytbLDC_PROGRAMAS_VIVIENDA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PROGRAMAS_VIVIENDA in styLDC_PROGRAMAS_VIVIENDA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PROGRAMAS_VIVIENDA in out nocopy tytbLDC_PROGRAMAS_VIVIENDA,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		isbDESCRIPCION$ in LDC_PROGRAMAS_VIVIENDA.DESCRIPCION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPROG_VIV_ID
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROGRAMAS_VIVIENDA.DESCRIPCION%type;


	PROCEDURE LockByPk
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		orcLDC_PROGRAMAS_VIVIENDA  out styLDC_PROGRAMAS_VIVIENDA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PROGRAMAS_VIVIENDA  out styLDC_PROGRAMAS_VIVIENDA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PROGRAMAS_VIVIENDA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PROGRAMAS_VIVIENDA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PROGRAMAS_VIVIENDA';
	 cnuGeEntityId constant varchar2(30) := 4228; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	IS
		SELECT LDC_PROGRAMAS_VIVIENDA.*,LDC_PROGRAMAS_VIVIENDA.rowid
		FROM LDC_PROGRAMAS_VIVIENDA
		WHERE  PROG_VIV_ID = inuPROG_VIV_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PROGRAMAS_VIVIENDA.*,LDC_PROGRAMAS_VIVIENDA.rowid
		FROM LDC_PROGRAMAS_VIVIENDA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PROGRAMAS_VIVIENDA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PROGRAMAS_VIVIENDA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PROGRAMAS_VIVIENDA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PROG_VIV_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		orcLDC_PROGRAMAS_VIVIENDA  out styLDC_PROGRAMAS_VIVIENDA
	)
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		rcError.PROG_VIV_ID := inuPROG_VIV_ID;

		Open cuLockRcByPk
		(
			inuPROG_VIV_ID
		);

		fetch cuLockRcByPk into orcLDC_PROGRAMAS_VIVIENDA;
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
		orcLDC_PROGRAMAS_VIVIENDA  out styLDC_PROGRAMAS_VIVIENDA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PROGRAMAS_VIVIENDA;
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
		itbLDC_PROGRAMAS_VIVIENDA  in out nocopy tytbLDC_PROGRAMAS_VIVIENDA
	)
	IS
	BEGIN
			rcRecOfTab.PROG_VIV_ID.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PROGRAMAS_VIVIENDA  in out nocopy tytbLDC_PROGRAMAS_VIVIENDA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PROGRAMAS_VIVIENDA);

		for n in itbLDC_PROGRAMAS_VIVIENDA.first .. itbLDC_PROGRAMAS_VIVIENDA.last loop
			rcRecOfTab.PROG_VIV_ID(n) := itbLDC_PROGRAMAS_VIVIENDA(n).PROG_VIV_ID;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_PROGRAMAS_VIVIENDA(n).DESCRIPCION;
			rcRecOfTab.row_id(n) := itbLDC_PROGRAMAS_VIVIENDA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPROG_VIV_ID
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
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPROG_VIV_ID = rcData.PROG_VIV_ID
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
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPROG_VIV_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN		rcError.PROG_VIV_ID:=inuPROG_VIV_ID;

		Load
		(
			inuPROG_VIV_ID
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
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPROG_VIV_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		orcRecord out nocopy styLDC_PROGRAMAS_VIVIENDA
	)
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN		rcError.PROG_VIV_ID:=inuPROG_VIV_ID;

		Load
		(
			inuPROG_VIV_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN styLDC_PROGRAMAS_VIVIENDA
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		rcError.PROG_VIV_ID:=inuPROG_VIV_ID;

		Load
		(
			inuPROG_VIV_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	)
	RETURN styLDC_PROGRAMAS_VIVIENDA
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		rcError.PROG_VIV_ID:=inuPROG_VIV_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPROG_VIV_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPROG_VIV_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PROGRAMAS_VIVIENDA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROGRAMAS_VIVIENDA
	)
	IS
		rfLDC_PROGRAMAS_VIVIENDA tyrfLDC_PROGRAMAS_VIVIENDA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PROGRAMAS_VIVIENDA.*, LDC_PROGRAMAS_VIVIENDA.rowid FROM LDC_PROGRAMAS_VIVIENDA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PROGRAMAS_VIVIENDA for sbFullQuery;

		fetch rfLDC_PROGRAMAS_VIVIENDA bulk collect INTO otbResult;

		close rfLDC_PROGRAMAS_VIVIENDA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PROGRAMAS_VIVIENDA.*, LDC_PROGRAMAS_VIVIENDA.rowid FROM LDC_PROGRAMAS_VIVIENDA';
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
		ircLDC_PROGRAMAS_VIVIENDA in styLDC_PROGRAMAS_VIVIENDA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PROGRAMAS_VIVIENDA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PROGRAMAS_VIVIENDA in styLDC_PROGRAMAS_VIVIENDA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PROG_VIV_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_PROGRAMAS_VIVIENDA
		(
			PROG_VIV_ID,
			DESCRIPCION
		)
		values
		(
			ircLDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID,
			ircLDC_PROGRAMAS_VIVIENDA.DESCRIPCION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PROGRAMAS_VIVIENDA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PROGRAMAS_VIVIENDA in out nocopy tytbLDC_PROGRAMAS_VIVIENDA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PROGRAMAS_VIVIENDA,blUseRowID);
		forall n in iotbLDC_PROGRAMAS_VIVIENDA.first..iotbLDC_PROGRAMAS_VIVIENDA.last
			insert into LDC_PROGRAMAS_VIVIENDA
			(
				PROG_VIV_ID,
				DESCRIPCION
			)
			values
			(
				rcRecOfTab.PROG_VIV_ID(n),
				rcRecOfTab.DESCRIPCION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		rcError.PROG_VIV_ID := inuPROG_VIV_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPROG_VIV_ID,
				rcData
			);
		end if;


		delete
		from LDC_PROGRAMAS_VIVIENDA
		where
       		PROG_VIV_ID=inuPROG_VIV_ID;
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
		rcError  styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PROGRAMAS_VIVIENDA
		where
			rowid = iriRowID
		returning
			PROG_VIV_ID
		into
			rcError.PROG_VIV_ID;
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
		iotbLDC_PROGRAMAS_VIVIENDA in out nocopy tytbLDC_PROGRAMAS_VIVIENDA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		FillRecordOfTables(iotbLDC_PROGRAMAS_VIVIENDA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last
				delete
				from LDC_PROGRAMAS_VIVIENDA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last loop
					LockByPk
					(
						rcRecOfTab.PROG_VIV_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last
				delete
				from LDC_PROGRAMAS_VIVIENDA
				where
		         	PROG_VIV_ID = rcRecOfTab.PROG_VIV_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PROGRAMAS_VIVIENDA in styLDC_PROGRAMAS_VIVIENDA,
		inuLock in number default 0
	)
	IS
		nuPROG_VIV_ID	LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type;
	BEGIN
		if ircLDC_PROGRAMAS_VIVIENDA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PROGRAMAS_VIVIENDA.rowid,rcData);
			end if;
			update LDC_PROGRAMAS_VIVIENDA
			set
				DESCRIPCION = ircLDC_PROGRAMAS_VIVIENDA.DESCRIPCION
			where
				rowid = ircLDC_PROGRAMAS_VIVIENDA.rowid
			returning
				PROG_VIV_ID
			into
				nuPROG_VIV_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID,
					rcData
				);
			end if;

			update LDC_PROGRAMAS_VIVIENDA
			set
				DESCRIPCION = ircLDC_PROGRAMAS_VIVIENDA.DESCRIPCION
			where
				PROG_VIV_ID = ircLDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID
			returning
				PROG_VIV_ID
			into
				nuPROG_VIV_ID;
		end if;
		if
			nuPROG_VIV_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PROGRAMAS_VIVIENDA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PROGRAMAS_VIVIENDA in out nocopy tytbLDC_PROGRAMAS_VIVIENDA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		FillRecordOfTables(iotbLDC_PROGRAMAS_VIVIENDA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last
				update LDC_PROGRAMAS_VIVIENDA
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last loop
					LockByPk
					(
						rcRecOfTab.PROG_VIV_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROGRAMAS_VIVIENDA.first .. iotbLDC_PROGRAMAS_VIVIENDA.last
				update LDC_PROGRAMAS_VIVIENDA
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n)
				where
					PROG_VIV_ID = rcRecOfTab.PROG_VIV_ID(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		isbDESCRIPCION$ in LDC_PROGRAMAS_VIVIENDA.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN
		rcError.PROG_VIV_ID := inuPROG_VIV_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROG_VIV_ID,
				rcData
			);
		end if;

		update LDC_PROGRAMAS_VIVIENDA
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			PROG_VIV_ID = inuPROG_VIV_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPROG_VIV_ID
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN

		rcError.PROG_VIV_ID := inuPROG_VIV_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROG_VIV_ID
			 )
		then
			 return(rcData.PROG_VIV_ID);
		end if;
		Load
		(
		 		inuPROG_VIV_ID
		);
		return(rcData.PROG_VIV_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPCION
	(
		inuPROG_VIV_ID in LDC_PROGRAMAS_VIVIENDA.PROG_VIV_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROGRAMAS_VIVIENDA.DESCRIPCION%type
	IS
		rcError styLDC_PROGRAMAS_VIVIENDA;
	BEGIN

		rcError.PROG_VIV_ID := inuPROG_VIV_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROG_VIV_ID
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuPROG_VIV_ID
		);
		return(rcData.DESCRIPCION);
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
end DALDC_PROGRAMAS_VIVIENDA;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PROGRAMAS_VIVIENDA
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PROGRAMAS_VIVIENDA', 'ADM_PERSON');
END;
/