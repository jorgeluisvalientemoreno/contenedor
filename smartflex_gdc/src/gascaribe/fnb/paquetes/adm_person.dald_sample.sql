CREATE OR REPLACE PACKAGE ADM_PERSON.dald_sample
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
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	IS
		SELECT LD_SAMPLE.*,LD_SAMPLE.rowid
		FROM LD_SAMPLE
		WHERE
		    SAMPLE_ID = inuSAMPLE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_SAMPLE.*,LD_SAMPLE.rowid
		FROM LD_SAMPLE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_SAMPLE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_SAMPLE is table of styLD_SAMPLE index by binary_integer;
	type tyrfRecords is ref cursor return styLD_SAMPLE;

	/* Tipos referenciando al registro */
	type tytbGENERATION_DATE is table of LD_SAMPLE.GENERATION_DATE%type index by binary_integer;
	type tytbTYPE_SECTOR is table of LD_SAMPLE.TYPE_SECTOR%type index by binary_integer;
	type tytbTYPE_PRODUCT_ID is table of LD_SAMPLE.TYPE_PRODUCT_ID%type index by binary_integer;
	type tytbUSER_ID is table of LD_SAMPLE.USER_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LD_SAMPLE.REGISTER_DATE%type index by binary_integer;
	type tytbCREDIT_BUREAU_ID is table of LD_SAMPLE.CREDIT_BUREAU_ID%type index by binary_integer;
	type tytbFLAG is table of LD_SAMPLE.FLAG%type index by binary_integer;
	type tytbSAMPLE_ID is table of LD_SAMPLE.SAMPLE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_SAMPLE is record
	(
		GENERATION_DATE   tytbGENERATION_DATE,
		TYPE_SECTOR   tytbTYPE_SECTOR,
		TYPE_PRODUCT_ID   tytbTYPE_PRODUCT_ID,
		USER_ID   tytbUSER_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
		CREDIT_BUREAU_ID   tytbCREDIT_BUREAU_ID,
		FLAG   tytbFLAG,
		SAMPLE_ID   tytbSAMPLE_ID,
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
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	);

	PROCEDURE getRecord
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		orcRecord out nocopy styLD_SAMPLE
	);

	FUNCTION frcGetRcData
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE;

	FUNCTION frcGetRecord
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_SAMPLE in styLD_SAMPLE
	);

	PROCEDURE insRecord
	(
		ircLD_SAMPLE in styLD_SAMPLE,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_SAMPLE in out nocopy tytbLD_SAMPLE
	);

	PROCEDURE delRecord
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_SAMPLE in out nocopy tytbLD_SAMPLE,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_SAMPLE in styLD_SAMPLE,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_SAMPLE in out nocopy tytbLD_SAMPLE,
		inuLock in number default 1
	);

	PROCEDURE updGENERATION_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		idtGENERATION_DATE$ in LD_SAMPLE.GENERATION_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_SECTOR
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		isbTYPE_SECTOR$ in LD_SAMPLE.TYPE_SECTOR%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_PRODUCT_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuTYPE_PRODUCT_ID$ in LD_SAMPLE.TYPE_PRODUCT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuUSER_ID$ in LD_SAMPLE.USER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		idtREGISTER_DATE$ in LD_SAMPLE.REGISTER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updCREDIT_BUREAU_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuCREDIT_BUREAU_ID$ in LD_SAMPLE.CREDIT_BUREAU_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFLAG
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		isbFLAG$ in LD_SAMPLE.FLAG%type,
		inuLock in number default 0
	);

	FUNCTION fdtGetGENERATION_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.GENERATION_DATE%type;

	FUNCTION fsbGetTYPE_SECTOR
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.TYPE_SECTOR%type;

	FUNCTION fnuGetTYPE_PRODUCT_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.TYPE_PRODUCT_ID%type;

	FUNCTION fnuGetUSER_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.USER_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.REGISTER_DATE%type;

	FUNCTION fnuGetCREDIT_BUREAU_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.CREDIT_BUREAU_ID%type;

	FUNCTION fsbGetFLAG
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.FLAG%type;

	FUNCTION fnuGetSAMPLE_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.SAMPLE_ID%type;


	PROCEDURE LockByPk
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		orcLD_SAMPLE  out styLD_SAMPLE
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_SAMPLE  out styLD_SAMPLE
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_SAMPLE;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.dald_sample
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SAMPLE';
	 cnuGeEntityId constant varchar2(30) := 8280; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	IS
		SELECT LD_SAMPLE.*,LD_SAMPLE.rowid
		FROM LD_SAMPLE
		WHERE  SAMPLE_ID = inuSAMPLE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_SAMPLE.*,LD_SAMPLE.rowid
		FROM LD_SAMPLE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_SAMPLE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_SAMPLE;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_SAMPLE default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SAMPLE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		orcLD_SAMPLE  out styLD_SAMPLE
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;

		Open cuLockRcByPk
		(
			inuSAMPLE_ID
		);

		fetch cuLockRcByPk into orcLD_SAMPLE;
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
		orcLD_SAMPLE  out styLD_SAMPLE
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_SAMPLE;
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
		itbLD_SAMPLE  in out nocopy tytbLD_SAMPLE
	)
	IS
	BEGIN
			rcRecOfTab.GENERATION_DATE.delete;
			rcRecOfTab.TYPE_SECTOR.delete;
			rcRecOfTab.TYPE_PRODUCT_ID.delete;
			rcRecOfTab.USER_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.CREDIT_BUREAU_ID.delete;
			rcRecOfTab.FLAG.delete;
			rcRecOfTab.SAMPLE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_SAMPLE  in out nocopy tytbLD_SAMPLE,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_SAMPLE);

		for n in itbLD_SAMPLE.first .. itbLD_SAMPLE.last loop
			rcRecOfTab.GENERATION_DATE(n) := itbLD_SAMPLE(n).GENERATION_DATE;
			rcRecOfTab.TYPE_SECTOR(n) := itbLD_SAMPLE(n).TYPE_SECTOR;
			rcRecOfTab.TYPE_PRODUCT_ID(n) := itbLD_SAMPLE(n).TYPE_PRODUCT_ID;
			rcRecOfTab.USER_ID(n) := itbLD_SAMPLE(n).USER_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLD_SAMPLE(n).REGISTER_DATE;
			rcRecOfTab.CREDIT_BUREAU_ID(n) := itbLD_SAMPLE(n).CREDIT_BUREAU_ID;
			rcRecOfTab.FLAG(n) := itbLD_SAMPLE(n).FLAG;
			rcRecOfTab.SAMPLE_ID(n) := itbLD_SAMPLE(n).SAMPLE_ID;
			rcRecOfTab.row_id(n) := itbLD_SAMPLE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSAMPLE_ID
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
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSAMPLE_ID = rcData.SAMPLE_ID
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
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSAMPLE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN		rcError.SAMPLE_ID:=inuSAMPLE_ID;

		Load
		(
			inuSAMPLE_ID
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
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuSAMPLE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		orcRecord out nocopy styLD_SAMPLE
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN		rcError.SAMPLE_ID:=inuSAMPLE_ID;

		Load
		(
			inuSAMPLE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID:=inuSAMPLE_ID;

		Load
		(
			inuSAMPLE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID:=inuSAMPLE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSAMPLE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSAMPLE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE
	)
	IS
		rfLD_SAMPLE tyrfLD_SAMPLE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_SAMPLE.*, LD_SAMPLE.rowid FROM LD_SAMPLE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_SAMPLE for sbFullQuery;

		fetch rfLD_SAMPLE bulk collect INTO otbResult;

		close rfLD_SAMPLE;
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
		sbSQL VARCHAR2 (32000) := 'select LD_SAMPLE.*, LD_SAMPLE.rowid FROM LD_SAMPLE';
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
		ircLD_SAMPLE in styLD_SAMPLE
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_SAMPLE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_SAMPLE in styLD_SAMPLE,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_SAMPLE.SAMPLE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SAMPLE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_SAMPLE
		(
			GENERATION_DATE,
			TYPE_SECTOR,
			TYPE_PRODUCT_ID,
			USER_ID,
			REGISTER_DATE,
			CREDIT_BUREAU_ID,
			FLAG,
			SAMPLE_ID
		)
		values
		(
			ircLD_SAMPLE.GENERATION_DATE,
			ircLD_SAMPLE.TYPE_SECTOR,
			ircLD_SAMPLE.TYPE_PRODUCT_ID,
			ircLD_SAMPLE.USER_ID,
			ircLD_SAMPLE.REGISTER_DATE,
			ircLD_SAMPLE.CREDIT_BUREAU_ID,
			ircLD_SAMPLE.FLAG,
			ircLD_SAMPLE.SAMPLE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_SAMPLE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_SAMPLE in out nocopy tytbLD_SAMPLE
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE,blUseRowID);
		forall n in iotbLD_SAMPLE.first..iotbLD_SAMPLE.last
			insert into LD_SAMPLE
			(
				GENERATION_DATE,
				TYPE_SECTOR,
				TYPE_PRODUCT_ID,
				USER_ID,
				REGISTER_DATE,
				CREDIT_BUREAU_ID,
				FLAG,
				SAMPLE_ID
			)
			values
			(
				rcRecOfTab.GENERATION_DATE(n),
				rcRecOfTab.TYPE_SECTOR(n),
				rcRecOfTab.TYPE_PRODUCT_ID(n),
				rcRecOfTab.USER_ID(n),
				rcRecOfTab.REGISTER_DATE(n),
				rcRecOfTab.CREDIT_BUREAU_ID(n),
				rcRecOfTab.FLAG(n),
				rcRecOfTab.SAMPLE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;


		delete
		from LD_SAMPLE
		where
       		SAMPLE_ID=inuSAMPLE_ID;
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
		rcError  styLD_SAMPLE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_SAMPLE
		where
			rowid = iriRowID
		returning
			GENERATION_DATE
		into
			rcError.GENERATION_DATE;
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
		iotbLD_SAMPLE in out nocopy tytbLD_SAMPLE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last
				delete
				from LD_SAMPLE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last loop
					LockByPk
					(
						rcRecOfTab.SAMPLE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last
				delete
				from LD_SAMPLE
				where
		         	SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_SAMPLE in styLD_SAMPLE,
		inuLock in number default 0
	)
	IS
		nuSAMPLE_ID	LD_SAMPLE.SAMPLE_ID%type;
	BEGIN
		if ircLD_SAMPLE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_SAMPLE.rowid,rcData);
			end if;
			update LD_SAMPLE
			set
				GENERATION_DATE = ircLD_SAMPLE.GENERATION_DATE,
				TYPE_SECTOR = ircLD_SAMPLE.TYPE_SECTOR,
				TYPE_PRODUCT_ID = ircLD_SAMPLE.TYPE_PRODUCT_ID,
				USER_ID = ircLD_SAMPLE.USER_ID,
				REGISTER_DATE = ircLD_SAMPLE.REGISTER_DATE,
				CREDIT_BUREAU_ID = ircLD_SAMPLE.CREDIT_BUREAU_ID,
				FLAG = ircLD_SAMPLE.FLAG
			where
				rowid = ircLD_SAMPLE.rowid
			returning
				SAMPLE_ID
			into
				nuSAMPLE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_SAMPLE.SAMPLE_ID,
					rcData
				);
			end if;

			update LD_SAMPLE
			set
				GENERATION_DATE = ircLD_SAMPLE.GENERATION_DATE,
				TYPE_SECTOR = ircLD_SAMPLE.TYPE_SECTOR,
				TYPE_PRODUCT_ID = ircLD_SAMPLE.TYPE_PRODUCT_ID,
				USER_ID = ircLD_SAMPLE.USER_ID,
				REGISTER_DATE = ircLD_SAMPLE.REGISTER_DATE,
				CREDIT_BUREAU_ID = ircLD_SAMPLE.CREDIT_BUREAU_ID,
				FLAG = ircLD_SAMPLE.FLAG
			where
				SAMPLE_ID = ircLD_SAMPLE.SAMPLE_ID
			returning
				SAMPLE_ID
			into
				nuSAMPLE_ID;
		end if;
		if
			nuSAMPLE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_SAMPLE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_SAMPLE in out nocopy tytbLD_SAMPLE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last
				update LD_SAMPLE
				set
					GENERATION_DATE = rcRecOfTab.GENERATION_DATE(n),
					TYPE_SECTOR = rcRecOfTab.TYPE_SECTOR(n),
					TYPE_PRODUCT_ID = rcRecOfTab.TYPE_PRODUCT_ID(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					CREDIT_BUREAU_ID = rcRecOfTab.CREDIT_BUREAU_ID(n),
					FLAG = rcRecOfTab.FLAG(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last loop
					LockByPk
					(
						rcRecOfTab.SAMPLE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE.first .. iotbLD_SAMPLE.last
				update LD_SAMPLE
				SET
					GENERATION_DATE = rcRecOfTab.GENERATION_DATE(n),
					TYPE_SECTOR = rcRecOfTab.TYPE_SECTOR(n),
					TYPE_PRODUCT_ID = rcRecOfTab.TYPE_PRODUCT_ID(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					CREDIT_BUREAU_ID = rcRecOfTab.CREDIT_BUREAU_ID(n),
					FLAG = rcRecOfTab.FLAG(n)
				where
					SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n)
;
		end if;
	END;
	PROCEDURE updGENERATION_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		idtGENERATION_DATE$ in LD_SAMPLE.GENERATION_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			GENERATION_DATE = idtGENERATION_DATE$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GENERATION_DATE:= idtGENERATION_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_SECTOR
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		isbTYPE_SECTOR$ in LD_SAMPLE.TYPE_SECTOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			TYPE_SECTOR = isbTYPE_SECTOR$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_SECTOR:= isbTYPE_SECTOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_PRODUCT_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuTYPE_PRODUCT_ID$ in LD_SAMPLE.TYPE_PRODUCT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			TYPE_PRODUCT_ID = inuTYPE_PRODUCT_ID$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_PRODUCT_ID:= inuTYPE_PRODUCT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuUSER_ID$ in LD_SAMPLE.USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			USER_ID = inuUSER_ID$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_ID:= inuUSER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		idtREGISTER_DATE$ in LD_SAMPLE.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCREDIT_BUREAU_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuCREDIT_BUREAU_ID$ in LD_SAMPLE.CREDIT_BUREAU_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			CREDIT_BUREAU_ID = inuCREDIT_BUREAU_ID$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREDIT_BUREAU_ID:= inuCREDIT_BUREAU_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFLAG
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		isbFLAG$ in LD_SAMPLE.FLAG%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE;
	BEGIN
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE
		set
			FLAG = isbFLAG$
		where
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAG:= isbFLAG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fdtGetGENERATION_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.GENERATION_DATE%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.GENERATION_DATE);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.GENERATION_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTYPE_SECTOR
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.TYPE_SECTOR%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_SECTOR);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_SECTOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_PRODUCT_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.TYPE_PRODUCT_ID%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_PRODUCT_ID);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_PRODUCT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUSER_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.USER_ID%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.USER_ID);
		end if;
		Load
		(
		 		inuSAMPLE_ID
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
	FUNCTION fdtGetREGISTER_DATE
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.REGISTER_DATE%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.REGISTER_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCREDIT_BUREAU_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.CREDIT_BUREAU_ID%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CREDIT_BUREAU_ID);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.CREDIT_BUREAU_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFLAG
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.FLAG%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.FLAG);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.FLAG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSAMPLE_ID
	(
		inuSAMPLE_ID in LD_SAMPLE.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE.SAMPLE_ID%type
	IS
		rcError styLD_SAMPLE;
	BEGIN

		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SAMPLE_ID);
		end if;
		Load
		(
		 		inuSAMPLE_ID
		);
		return(rcData.SAMPLE_ID);
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
end DALD_SAMPLE;
/
PROMPT Otorgando permisos de ejecucion a DALD_SAMPLE
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SAMPLE', 'ADM_PERSON');
END;
/