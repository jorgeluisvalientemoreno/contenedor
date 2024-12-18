CREATE OR REPLACE PACKAGE adm_person.dald_credit_bureau
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	IS
		SELECT LD_CREDIT_BUREAU.*,LD_CREDIT_BUREAU.rowid
		FROM LD_CREDIT_BUREAU
		WHERE
		    CREDIT_BUREAU_ID = inuCREDIT_BUREAU_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_CREDIT_BUREAU.*,LD_CREDIT_BUREAU.rowid
		FROM LD_CREDIT_BUREAU
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_CREDIT_BUREAU  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_CREDIT_BUREAU is table of styLD_CREDIT_BUREAU index by binary_integer;
	type tyrfRecords is ref cursor return styLD_CREDIT_BUREAU;

	/* Tipos referenciando al registro */
	type tytbCREDIT_BUREAU_ID is table of LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type index by binary_integer;
	type tytbCREDIT_BUREAU_DESC is table of LD_CREDIT_BUREAU.CREDIT_BUREAU_DESC%type index by binary_integer;
	type tytbAPROVE_SAMPLE is table of LD_CREDIT_BUREAU.APROVE_SAMPLE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_CREDIT_BUREAU is record
	(
		CREDIT_BUREAU_ID   tytbCREDIT_BUREAU_ID,
		CREDIT_BUREAU_DESC   tytbCREDIT_BUREAU_DESC,
		APROVE_SAMPLE   tytbAPROVE_SAMPLE,
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
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	);

	PROCEDURE getRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		orcRecord out nocopy styLD_CREDIT_BUREAU
	);

	FUNCTION frcGetRcData
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN styLD_CREDIT_BUREAU;

	FUNCTION frcGetRcData
	RETURN styLD_CREDIT_BUREAU;

	FUNCTION frcGetRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN styLD_CREDIT_BUREAU;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_CREDIT_BUREAU
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_CREDIT_BUREAU in styLD_CREDIT_BUREAU
	);

	PROCEDURE insRecord
	(
		ircLD_CREDIT_BUREAU in styLD_CREDIT_BUREAU,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_CREDIT_BUREAU in out nocopy tytbLD_CREDIT_BUREAU
	);

	PROCEDURE delRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_CREDIT_BUREAU in out nocopy tytbLD_CREDIT_BUREAU,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_CREDIT_BUREAU in styLD_CREDIT_BUREAU,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_CREDIT_BUREAU in out nocopy tytbLD_CREDIT_BUREAU,
		inuLock in number default 1
	);

	PROCEDURE updCREDIT_BUREAU_DESC
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		isbCREDIT_BUREAU_DESC$ in LD_CREDIT_BUREAU.CREDIT_BUREAU_DESC%type,
		inuLock in number default 0
	);

	PROCEDURE updAPROVE_SAMPLE
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		isbAPROVE_SAMPLE$ in LD_CREDIT_BUREAU.APROVE_SAMPLE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCREDIT_BUREAU_ID
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type;

	FUNCTION fsbGetCREDIT_BUREAU_DESC
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CREDIT_BUREAU.CREDIT_BUREAU_DESC%type;

	FUNCTION fsbGetAPROVE_SAMPLE
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CREDIT_BUREAU.APROVE_SAMPLE%type;


	PROCEDURE LockByPk
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		orcLD_CREDIT_BUREAU  out styLD_CREDIT_BUREAU
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_CREDIT_BUREAU  out styLD_CREDIT_BUREAU
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_CREDIT_BUREAU;
/
CREATE OR REPLACE PACKAGE BODY adm_person.dald_credit_bureau
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CREDIT_BUREAU';
	 cnuGeEntityId constant varchar2(30) := 8277; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	IS
		SELECT LD_CREDIT_BUREAU.*,LD_CREDIT_BUREAU.rowid
		FROM LD_CREDIT_BUREAU
		WHERE  CREDIT_BUREAU_ID = inuCREDIT_BUREAU_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_CREDIT_BUREAU.*,LD_CREDIT_BUREAU.rowid
		FROM LD_CREDIT_BUREAU
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_CREDIT_BUREAU is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_CREDIT_BUREAU;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_CREDIT_BUREAU default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CREDIT_BUREAU_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		orcLD_CREDIT_BUREAU  out styLD_CREDIT_BUREAU
	)
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN
		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;

		Open cuLockRcByPk
		(
			inuCREDIT_BUREAU_ID
		);

		fetch cuLockRcByPk into orcLD_CREDIT_BUREAU;
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
		orcLD_CREDIT_BUREAU  out styLD_CREDIT_BUREAU
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_CREDIT_BUREAU;
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
		itbLD_CREDIT_BUREAU  in out nocopy tytbLD_CREDIT_BUREAU
	)
	IS
	BEGIN
			rcRecOfTab.CREDIT_BUREAU_ID.delete;
			rcRecOfTab.CREDIT_BUREAU_DESC.delete;
			rcRecOfTab.APROVE_SAMPLE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_CREDIT_BUREAU  in out nocopy tytbLD_CREDIT_BUREAU,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_CREDIT_BUREAU);

		for n in itbLD_CREDIT_BUREAU.first .. itbLD_CREDIT_BUREAU.last loop
			rcRecOfTab.CREDIT_BUREAU_ID(n) := itbLD_CREDIT_BUREAU(n).CREDIT_BUREAU_ID;
			rcRecOfTab.CREDIT_BUREAU_DESC(n) := itbLD_CREDIT_BUREAU(n).CREDIT_BUREAU_DESC;
			rcRecOfTab.APROVE_SAMPLE(n) := itbLD_CREDIT_BUREAU(n).APROVE_SAMPLE;
			rcRecOfTab.row_id(n) := itbLD_CREDIT_BUREAU(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCREDIT_BUREAU_ID
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
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCREDIT_BUREAU_ID = rcData.CREDIT_BUREAU_ID
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
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCREDIT_BUREAU_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN		rcError.CREDIT_BUREAU_ID:=inuCREDIT_BUREAU_ID;

		Load
		(
			inuCREDIT_BUREAU_ID
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
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCREDIT_BUREAU_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		orcRecord out nocopy styLD_CREDIT_BUREAU
	)
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN		rcError.CREDIT_BUREAU_ID:=inuCREDIT_BUREAU_ID;

		Load
		(
			inuCREDIT_BUREAU_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN styLD_CREDIT_BUREAU
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN
		rcError.CREDIT_BUREAU_ID:=inuCREDIT_BUREAU_ID;

		Load
		(
			inuCREDIT_BUREAU_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	)
	RETURN styLD_CREDIT_BUREAU
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN
		rcError.CREDIT_BUREAU_ID:=inuCREDIT_BUREAU_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCREDIT_BUREAU_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCREDIT_BUREAU_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_CREDIT_BUREAU
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_CREDIT_BUREAU
	)
	IS
		rfLD_CREDIT_BUREAU tyrfLD_CREDIT_BUREAU;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_CREDIT_BUREAU.*, LD_CREDIT_BUREAU.rowid FROM LD_CREDIT_BUREAU';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_CREDIT_BUREAU for sbFullQuery;

		fetch rfLD_CREDIT_BUREAU bulk collect INTO otbResult;

		close rfLD_CREDIT_BUREAU;
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
		sbSQL VARCHAR2 (32000) := 'select LD_CREDIT_BUREAU.*, LD_CREDIT_BUREAU.rowid FROM LD_CREDIT_BUREAU';
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
		ircLD_CREDIT_BUREAU in styLD_CREDIT_BUREAU
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_CREDIT_BUREAU,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_CREDIT_BUREAU in styLD_CREDIT_BUREAU,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_CREDIT_BUREAU.CREDIT_BUREAU_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CREDIT_BUREAU_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_CREDIT_BUREAU
		(
			CREDIT_BUREAU_ID,
			CREDIT_BUREAU_DESC,
			APROVE_SAMPLE
		)
		values
		(
			ircLD_CREDIT_BUREAU.CREDIT_BUREAU_ID,
			ircLD_CREDIT_BUREAU.CREDIT_BUREAU_DESC,
			ircLD_CREDIT_BUREAU.APROVE_SAMPLE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_CREDIT_BUREAU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_CREDIT_BUREAU in out nocopy tytbLD_CREDIT_BUREAU
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_CREDIT_BUREAU,blUseRowID);
		forall n in iotbLD_CREDIT_BUREAU.first..iotbLD_CREDIT_BUREAU.last
			insert into LD_CREDIT_BUREAU
			(
				CREDIT_BUREAU_ID,
				CREDIT_BUREAU_DESC,
				APROVE_SAMPLE
			)
			values
			(
				rcRecOfTab.CREDIT_BUREAU_ID(n),
				rcRecOfTab.CREDIT_BUREAU_DESC(n),
				rcRecOfTab.APROVE_SAMPLE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN
		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCREDIT_BUREAU_ID,
				rcData
			);
		end if;


		delete
		from LD_CREDIT_BUREAU
		where
       		CREDIT_BUREAU_ID=inuCREDIT_BUREAU_ID;
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
		rcError  styLD_CREDIT_BUREAU;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_CREDIT_BUREAU
		where
			rowid = iriRowID
		returning
			CREDIT_BUREAU_ID
		into
			rcError.CREDIT_BUREAU_ID;
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
		iotbLD_CREDIT_BUREAU in out nocopy tytbLD_CREDIT_BUREAU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_CREDIT_BUREAU;
	BEGIN
		FillRecordOfTables(iotbLD_CREDIT_BUREAU, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last
				delete
				from LD_CREDIT_BUREAU
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last loop
					LockByPk
					(
						rcRecOfTab.CREDIT_BUREAU_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last
				delete
				from LD_CREDIT_BUREAU
				where
		         	CREDIT_BUREAU_ID = rcRecOfTab.CREDIT_BUREAU_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_CREDIT_BUREAU in styLD_CREDIT_BUREAU,
		inuLock in number default 0
	)
	IS
		nuCREDIT_BUREAU_ID	LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type;
	BEGIN
		if ircLD_CREDIT_BUREAU.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_CREDIT_BUREAU.rowid,rcData);
			end if;
			update LD_CREDIT_BUREAU
			set
				CREDIT_BUREAU_DESC = ircLD_CREDIT_BUREAU.CREDIT_BUREAU_DESC,
				APROVE_SAMPLE = ircLD_CREDIT_BUREAU.APROVE_SAMPLE
			where
				rowid = ircLD_CREDIT_BUREAU.rowid
			returning
				CREDIT_BUREAU_ID
			into
				nuCREDIT_BUREAU_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_CREDIT_BUREAU.CREDIT_BUREAU_ID,
					rcData
				);
			end if;

			update LD_CREDIT_BUREAU
			set
				CREDIT_BUREAU_DESC = ircLD_CREDIT_BUREAU.CREDIT_BUREAU_DESC,
				APROVE_SAMPLE = ircLD_CREDIT_BUREAU.APROVE_SAMPLE
			where
				CREDIT_BUREAU_ID = ircLD_CREDIT_BUREAU.CREDIT_BUREAU_ID
			returning
				CREDIT_BUREAU_ID
			into
				nuCREDIT_BUREAU_ID;
		end if;
		if
			nuCREDIT_BUREAU_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_CREDIT_BUREAU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_CREDIT_BUREAU in out nocopy tytbLD_CREDIT_BUREAU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_CREDIT_BUREAU;
	BEGIN
		FillRecordOfTables(iotbLD_CREDIT_BUREAU,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last
				update LD_CREDIT_BUREAU
				set
					CREDIT_BUREAU_DESC = rcRecOfTab.CREDIT_BUREAU_DESC(n),
					APROVE_SAMPLE = rcRecOfTab.APROVE_SAMPLE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last loop
					LockByPk
					(
						rcRecOfTab.CREDIT_BUREAU_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CREDIT_BUREAU.first .. iotbLD_CREDIT_BUREAU.last
				update LD_CREDIT_BUREAU
				SET
					CREDIT_BUREAU_DESC = rcRecOfTab.CREDIT_BUREAU_DESC(n),
					APROVE_SAMPLE = rcRecOfTab.APROVE_SAMPLE(n)
				where
					CREDIT_BUREAU_ID = rcRecOfTab.CREDIT_BUREAU_ID(n)
;
		end if;
	END;
	PROCEDURE updCREDIT_BUREAU_DESC
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		isbCREDIT_BUREAU_DESC$ in LD_CREDIT_BUREAU.CREDIT_BUREAU_DESC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN
		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCREDIT_BUREAU_ID,
				rcData
			);
		end if;

		update LD_CREDIT_BUREAU
		set
			CREDIT_BUREAU_DESC = isbCREDIT_BUREAU_DESC$
		where
			CREDIT_BUREAU_ID = inuCREDIT_BUREAU_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREDIT_BUREAU_DESC:= isbCREDIT_BUREAU_DESC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPROVE_SAMPLE
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		isbAPROVE_SAMPLE$ in LD_CREDIT_BUREAU.APROVE_SAMPLE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN
		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCREDIT_BUREAU_ID,
				rcData
			);
		end if;

		update LD_CREDIT_BUREAU
		set
			APROVE_SAMPLE = isbAPROVE_SAMPLE$
		where
			CREDIT_BUREAU_ID = inuCREDIT_BUREAU_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APROVE_SAMPLE:= isbAPROVE_SAMPLE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCREDIT_BUREAU_ID
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN

		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCREDIT_BUREAU_ID
			 )
		then
			 return(rcData.CREDIT_BUREAU_ID);
		end if;
		Load
		(
		 		inuCREDIT_BUREAU_ID
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
	FUNCTION fsbGetCREDIT_BUREAU_DESC
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CREDIT_BUREAU.CREDIT_BUREAU_DESC%type
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN

		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCREDIT_BUREAU_ID
			 )
		then
			 return(rcData.CREDIT_BUREAU_DESC);
		end if;
		Load
		(
		 		inuCREDIT_BUREAU_ID
		);
		return(rcData.CREDIT_BUREAU_DESC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetAPROVE_SAMPLE
	(
		inuCREDIT_BUREAU_ID in LD_CREDIT_BUREAU.CREDIT_BUREAU_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CREDIT_BUREAU.APROVE_SAMPLE%type
	IS
		rcError styLD_CREDIT_BUREAU;
	BEGIN

		rcError.CREDIT_BUREAU_ID := inuCREDIT_BUREAU_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCREDIT_BUREAU_ID
			 )
		then
			 return(rcData.APROVE_SAMPLE);
		end if;
		Load
		(
		 		inuCREDIT_BUREAU_ID
		);
		return(rcData.APROVE_SAMPLE);
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
end DALD_CREDIT_BUREAU;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CREDIT_BUREAU
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CREDIT_BUREAU', 'ADM_PERSON'); 
END;
/  
