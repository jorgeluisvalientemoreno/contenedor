CREATE OR REPLACE PACKAGE adm_person.dald_aditional_fnb_info
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	IS
		SELECT LD_ADITIONAL_FNB_INFO.*,LD_ADITIONAL_FNB_INFO.rowid
		FROM LD_ADITIONAL_FNB_INFO
		WHERE
		    NON_BA_FI_REQU_ID = inuNON_BA_FI_REQU_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_ADITIONAL_FNB_INFO.*,LD_ADITIONAL_FNB_INFO.rowid
		FROM LD_ADITIONAL_FNB_INFO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_ADITIONAL_FNB_INFO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_ADITIONAL_FNB_INFO is table of styLD_ADITIONAL_FNB_INFO index by binary_integer;
	type tyrfRecords is ref cursor return styLD_ADITIONAL_FNB_INFO;

	/* Tipos referenciando al registro */
	type tytbNON_BA_FI_REQU_ID is table of LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type index by binary_integer;
	type tytbCOSIGNER_SUBSCRIBER_ID is table of LD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID%type index by binary_integer;
	type tytbAPROX_MONTH_INSURANCE is table of LD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_ADITIONAL_FNB_INFO is record
	(
		NON_BA_FI_REQU_ID   tytbNON_BA_FI_REQU_ID,
		COSIGNER_SUBSCRIBER_ID   tytbCOSIGNER_SUBSCRIBER_ID,
		APROX_MONTH_INSURANCE   tytbAPROX_MONTH_INSURANCE,
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
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	);

	PROCEDURE getRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		orcRecord out nocopy styLD_ADITIONAL_FNB_INFO
	);

	FUNCTION frcGetRcData
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN styLD_ADITIONAL_FNB_INFO;

	FUNCTION frcGetRcData
	RETURN styLD_ADITIONAL_FNB_INFO;

	FUNCTION frcGetRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN styLD_ADITIONAL_FNB_INFO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_ADITIONAL_FNB_INFO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_ADITIONAL_FNB_INFO in styLD_ADITIONAL_FNB_INFO
	);

	PROCEDURE insRecord
	(
		ircLD_ADITIONAL_FNB_INFO in styLD_ADITIONAL_FNB_INFO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_ADITIONAL_FNB_INFO in out nocopy tytbLD_ADITIONAL_FNB_INFO
	);

	PROCEDURE delRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_ADITIONAL_FNB_INFO in out nocopy tytbLD_ADITIONAL_FNB_INFO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_ADITIONAL_FNB_INFO in styLD_ADITIONAL_FNB_INFO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_ADITIONAL_FNB_INFO in out nocopy tytbLD_ADITIONAL_FNB_INFO,
		inuLock in number default 1
	);

	PROCEDURE updCOSIGNER_SUBSCRIBER_ID
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuCOSIGNER_SUBSCRIBER_ID$ in LD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updAPROX_MONTH_INSURANCE
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuAPROX_MONTH_INSURANCE$ in LD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetNON_BA_FI_REQU_ID
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type;

	FUNCTION fnuGetCOSIGNER_SUBSCRIBER_ID
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID%type;

	FUNCTION fnuGetAPROX_MONTH_INSURANCE
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE%type;


	PROCEDURE LockByPk
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		orcLD_ADITIONAL_FNB_INFO  out styLD_ADITIONAL_FNB_INFO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_ADITIONAL_FNB_INFO  out styLD_ADITIONAL_FNB_INFO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_ADITIONAL_FNB_INFO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_ADITIONAL_FNB_INFO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO227806';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_ADITIONAL_FNB_INFO';
	 cnuGeEntityId constant varchar2(30) := 2489; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	IS
		SELECT LD_ADITIONAL_FNB_INFO.*,LD_ADITIONAL_FNB_INFO.rowid
		FROM LD_ADITIONAL_FNB_INFO
		WHERE  NON_BA_FI_REQU_ID = inuNON_BA_FI_REQU_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_ADITIONAL_FNB_INFO.*,LD_ADITIONAL_FNB_INFO.rowid
		FROM LD_ADITIONAL_FNB_INFO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_ADITIONAL_FNB_INFO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_ADITIONAL_FNB_INFO;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_ADITIONAL_FNB_INFO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NON_BA_FI_REQU_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		orcLD_ADITIONAL_FNB_INFO  out styLD_ADITIONAL_FNB_INFO
	)
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN
		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;

		Open cuLockRcByPk
		(
			inuNON_BA_FI_REQU_ID
		);

		fetch cuLockRcByPk into orcLD_ADITIONAL_FNB_INFO;
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
		orcLD_ADITIONAL_FNB_INFO  out styLD_ADITIONAL_FNB_INFO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_ADITIONAL_FNB_INFO;
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
		itbLD_ADITIONAL_FNB_INFO  in out nocopy tytbLD_ADITIONAL_FNB_INFO
	)
	IS
	BEGIN
			rcRecOfTab.NON_BA_FI_REQU_ID.delete;
			rcRecOfTab.COSIGNER_SUBSCRIBER_ID.delete;
			rcRecOfTab.APROX_MONTH_INSURANCE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_ADITIONAL_FNB_INFO  in out nocopy tytbLD_ADITIONAL_FNB_INFO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_ADITIONAL_FNB_INFO);

		for n in itbLD_ADITIONAL_FNB_INFO.first .. itbLD_ADITIONAL_FNB_INFO.last loop
			rcRecOfTab.NON_BA_FI_REQU_ID(n) := itbLD_ADITIONAL_FNB_INFO(n).NON_BA_FI_REQU_ID;
			rcRecOfTab.COSIGNER_SUBSCRIBER_ID(n) := itbLD_ADITIONAL_FNB_INFO(n).COSIGNER_SUBSCRIBER_ID;
			rcRecOfTab.APROX_MONTH_INSURANCE(n) := itbLD_ADITIONAL_FNB_INFO(n).APROX_MONTH_INSURANCE;
			rcRecOfTab.row_id(n) := itbLD_ADITIONAL_FNB_INFO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNON_BA_FI_REQU_ID
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
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNON_BA_FI_REQU_ID = rcData.NON_BA_FI_REQU_ID
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
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNON_BA_FI_REQU_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN		rcError.NON_BA_FI_REQU_ID:=inuNON_BA_FI_REQU_ID;

		Load
		(
			inuNON_BA_FI_REQU_ID
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
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuNON_BA_FI_REQU_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		orcRecord out nocopy styLD_ADITIONAL_FNB_INFO
	)
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN		rcError.NON_BA_FI_REQU_ID:=inuNON_BA_FI_REQU_ID;

		Load
		(
			inuNON_BA_FI_REQU_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN styLD_ADITIONAL_FNB_INFO
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN
		rcError.NON_BA_FI_REQU_ID:=inuNON_BA_FI_REQU_ID;

		Load
		(
			inuNON_BA_FI_REQU_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	)
	RETURN styLD_ADITIONAL_FNB_INFO
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN
		rcError.NON_BA_FI_REQU_ID:=inuNON_BA_FI_REQU_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuNON_BA_FI_REQU_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_ADITIONAL_FNB_INFO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_ADITIONAL_FNB_INFO
	)
	IS
		rfLD_ADITIONAL_FNB_INFO tyrfLD_ADITIONAL_FNB_INFO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_ADITIONAL_FNB_INFO.*, LD_ADITIONAL_FNB_INFO.rowid FROM LD_ADITIONAL_FNB_INFO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_ADITIONAL_FNB_INFO for sbFullQuery;

		fetch rfLD_ADITIONAL_FNB_INFO bulk collect INTO otbResult;

		close rfLD_ADITIONAL_FNB_INFO;
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
		sbSQL VARCHAR2 (32000) := 'select LD_ADITIONAL_FNB_INFO.*, LD_ADITIONAL_FNB_INFO.rowid FROM LD_ADITIONAL_FNB_INFO';
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
		ircLD_ADITIONAL_FNB_INFO in styLD_ADITIONAL_FNB_INFO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_ADITIONAL_FNB_INFO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_ADITIONAL_FNB_INFO in styLD_ADITIONAL_FNB_INFO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NON_BA_FI_REQU_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_ADITIONAL_FNB_INFO
		(
			NON_BA_FI_REQU_ID,
			COSIGNER_SUBSCRIBER_ID,
			APROX_MONTH_INSURANCE
		)
		values
		(
			ircLD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID,
			ircLD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID,
			ircLD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_ADITIONAL_FNB_INFO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_ADITIONAL_FNB_INFO in out nocopy tytbLD_ADITIONAL_FNB_INFO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_ADITIONAL_FNB_INFO,blUseRowID);
		forall n in iotbLD_ADITIONAL_FNB_INFO.first..iotbLD_ADITIONAL_FNB_INFO.last
			insert into LD_ADITIONAL_FNB_INFO
			(
				NON_BA_FI_REQU_ID,
				COSIGNER_SUBSCRIBER_ID,
				APROX_MONTH_INSURANCE
			)
			values
			(
				rcRecOfTab.NON_BA_FI_REQU_ID(n),
				rcRecOfTab.COSIGNER_SUBSCRIBER_ID(n),
				rcRecOfTab.APROX_MONTH_INSURANCE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN
		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;

		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_ID,
				rcData
			);
		end if;


		delete
		from LD_ADITIONAL_FNB_INFO
		where
       		NON_BA_FI_REQU_ID=inuNON_BA_FI_REQU_ID;
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
		rcError  styLD_ADITIONAL_FNB_INFO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_ADITIONAL_FNB_INFO
		where
			rowid = iriRowID
		returning
			NON_BA_FI_REQU_ID
		into
			rcError.NON_BA_FI_REQU_ID;
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
		iotbLD_ADITIONAL_FNB_INFO in out nocopy tytbLD_ADITIONAL_FNB_INFO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_ADITIONAL_FNB_INFO;
	BEGIN
		FillRecordOfTables(iotbLD_ADITIONAL_FNB_INFO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last
				delete
				from LD_ADITIONAL_FNB_INFO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last loop
					LockByPk
					(
						rcRecOfTab.NON_BA_FI_REQU_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last
				delete
				from LD_ADITIONAL_FNB_INFO
				where
		         	NON_BA_FI_REQU_ID = rcRecOfTab.NON_BA_FI_REQU_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_ADITIONAL_FNB_INFO in styLD_ADITIONAL_FNB_INFO,
		inuLock in number default 0
	)
	IS
		nuNON_BA_FI_REQU_ID	LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type;
	BEGIN
		if ircLD_ADITIONAL_FNB_INFO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_ADITIONAL_FNB_INFO.rowid,rcData);
			end if;
			update LD_ADITIONAL_FNB_INFO
			set
				COSIGNER_SUBSCRIBER_ID = ircLD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID,
				APROX_MONTH_INSURANCE = ircLD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE
			where
				rowid = ircLD_ADITIONAL_FNB_INFO.rowid
			returning
				NON_BA_FI_REQU_ID
			into
				nuNON_BA_FI_REQU_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID,
					rcData
				);
			end if;

			update LD_ADITIONAL_FNB_INFO
			set
				COSIGNER_SUBSCRIBER_ID = ircLD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID,
				APROX_MONTH_INSURANCE = ircLD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE
			where
				NON_BA_FI_REQU_ID = ircLD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID
			returning
				NON_BA_FI_REQU_ID
			into
				nuNON_BA_FI_REQU_ID;
		end if;
		if
			nuNON_BA_FI_REQU_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_ADITIONAL_FNB_INFO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_ADITIONAL_FNB_INFO in out nocopy tytbLD_ADITIONAL_FNB_INFO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_ADITIONAL_FNB_INFO;
	BEGIN
		FillRecordOfTables(iotbLD_ADITIONAL_FNB_INFO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last
				update LD_ADITIONAL_FNB_INFO
				set
					COSIGNER_SUBSCRIBER_ID = rcRecOfTab.COSIGNER_SUBSCRIBER_ID(n),
					APROX_MONTH_INSURANCE = rcRecOfTab.APROX_MONTH_INSURANCE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last loop
					LockByPk
					(
						rcRecOfTab.NON_BA_FI_REQU_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_ADITIONAL_FNB_INFO.first .. iotbLD_ADITIONAL_FNB_INFO.last
				update LD_ADITIONAL_FNB_INFO
				SET
					COSIGNER_SUBSCRIBER_ID = rcRecOfTab.COSIGNER_SUBSCRIBER_ID(n),
					APROX_MONTH_INSURANCE = rcRecOfTab.APROX_MONTH_INSURANCE(n)
				where
					NON_BA_FI_REQU_ID = rcRecOfTab.NON_BA_FI_REQU_ID(n)
;
		end if;
	END;
	PROCEDURE updCOSIGNER_SUBSCRIBER_ID
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuCOSIGNER_SUBSCRIBER_ID$ in LD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN
		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_ID,
				rcData
			);
		end if;

		update LD_ADITIONAL_FNB_INFO
		set
			COSIGNER_SUBSCRIBER_ID = inuCOSIGNER_SUBSCRIBER_ID$
		where
			NON_BA_FI_REQU_ID = inuNON_BA_FI_REQU_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSIGNER_SUBSCRIBER_ID:= inuCOSIGNER_SUBSCRIBER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPROX_MONTH_INSURANCE
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuAPROX_MONTH_INSURANCE$ in LD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN
		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_ID,
				rcData
			);
		end if;

		update LD_ADITIONAL_FNB_INFO
		set
			APROX_MONTH_INSURANCE = inuAPROX_MONTH_INSURANCE$
		where
			NON_BA_FI_REQU_ID = inuNON_BA_FI_REQU_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APROX_MONTH_INSURANCE:= inuAPROX_MONTH_INSURANCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetNON_BA_FI_REQU_ID
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN

		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BA_FI_REQU_ID
			 )
		then
			 return(rcData.NON_BA_FI_REQU_ID);
		end if;
		Load
		(
		 		inuNON_BA_FI_REQU_ID
		);
		return(rcData.NON_BA_FI_REQU_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOSIGNER_SUBSCRIBER_ID
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_ADITIONAL_FNB_INFO.COSIGNER_SUBSCRIBER_ID%type
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN

		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BA_FI_REQU_ID
			 )
		then
			 return(rcData.COSIGNER_SUBSCRIBER_ID);
		end if;
		Load
		(
		 		inuNON_BA_FI_REQU_ID
		);
		return(rcData.COSIGNER_SUBSCRIBER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetAPROX_MONTH_INSURANCE
	(
		inuNON_BA_FI_REQU_ID in LD_ADITIONAL_FNB_INFO.NON_BA_FI_REQU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_ADITIONAL_FNB_INFO.APROX_MONTH_INSURANCE%type
	IS
		rcError styLD_ADITIONAL_FNB_INFO;
	BEGIN

		rcError.NON_BA_FI_REQU_ID := inuNON_BA_FI_REQU_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BA_FI_REQU_ID
			 )
		then
			 return(rcData.APROX_MONTH_INSURANCE);
		end if;
		Load
		(
		 		inuNON_BA_FI_REQU_ID
		);
		return(rcData.APROX_MONTH_INSURANCE);
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
end DALD_ADITIONAL_FNB_INFO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_ADITIONAL_FNB_INFO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_ADITIONAL_FNB_INFO', 'ADM_PERSON'); 
END;
/  
