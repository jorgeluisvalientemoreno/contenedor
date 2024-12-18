CREATE OR REPLACE PACKAGE adm_person.daldc_ca_operunitxrangorec
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	IS
		SELECT LDC_CA_OPERUNITXRANGOREC.*,LDC_CA_OPERUNITXRANGOREC.rowid
		FROM LDC_CA_OPERUNITXRANGOREC
		WHERE
		    IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CA_OPERUNITXRANGOREC.*,LDC_CA_OPERUNITXRANGOREC.rowid
		FROM LDC_CA_OPERUNITXRANGOREC
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CA_OPERUNITXRANGOREC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CA_OPERUNITXRANGOREC is table of styLDC_CA_OPERUNITXRANGOREC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CA_OPERUNITXRANGOREC;

	/* Tipos referenciando al registro */
	type tytbIDOPERUNITXRANGOREC is table of LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbRANGOINICIAL is table of LDC_CA_OPERUNITXRANGOREC.RANGOINICIAL%type index by binary_integer;
	type tytbRANGOFINAL is table of LDC_CA_OPERUNITXRANGOREC.RANGOFINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CA_OPERUNITXRANGOREC is record
	(
		IDOPERUNITXRANGOREC   tytbIDOPERUNITXRANGOREC,
		OPERATING_UNIT_ID   tytbOPERATING_UNIT_ID,
		RANGOINICIAL   tytbRANGOINICIAL,
		RANGOFINAL   tytbRANGOFINAL,
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
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	);

	PROCEDURE getRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		orcRecord out nocopy styLDC_CA_OPERUNITXRANGOREC
	);

	FUNCTION frcGetRcData
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN styLDC_CA_OPERUNITXRANGOREC;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_OPERUNITXRANGOREC;

	FUNCTION frcGetRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN styLDC_CA_OPERUNITXRANGOREC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_OPERUNITXRANGOREC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CA_OPERUNITXRANGOREC in styLDC_CA_OPERUNITXRANGOREC
	);

	PROCEDURE insRecord
	(
		ircLDC_CA_OPERUNITXRANGOREC in styLDC_CA_OPERUNITXRANGOREC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CA_OPERUNITXRANGOREC in out nocopy tytbLDC_CA_OPERUNITXRANGOREC
	);

	PROCEDURE delRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CA_OPERUNITXRANGOREC in out nocopy tytbLDC_CA_OPERUNITXRANGOREC,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CA_OPERUNITXRANGOREC in styLDC_CA_OPERUNITXRANGOREC,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CA_OPERUNITXRANGOREC in out nocopy tytbLDC_CA_OPERUNITXRANGOREC,
		inuLock in number default 1
	);

	PROCEDURE updOPERATING_UNIT_ID
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuOPERATING_UNIT_ID$ in LDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updRANGOINICIAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRANGOINICIAL$ in LDC_CA_OPERUNITXRANGOREC.RANGOINICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updRANGOFINAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRANGOFINAL$ in LDC_CA_OPERUNITXRANGOREC.RANGOFINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type;

	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID%type;

	FUNCTION fnuGetRANGOINICIAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.RANGOINICIAL%type;

	FUNCTION fnuGetRANGOFINAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.RANGOFINAL%type;


	PROCEDURE LockByPk
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		orcLDC_CA_OPERUNITXRANGOREC  out styLDC_CA_OPERUNITXRANGOREC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CA_OPERUNITXRANGOREC  out styLDC_CA_OPERUNITXRANGOREC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CA_OPERUNITXRANGOREC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CA_OPERUNITXRANGOREC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CA_OPERUNITXRANGOREC';
	 cnuGeEntityId constant varchar2(30) := 8266; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	IS
		SELECT LDC_CA_OPERUNITXRANGOREC.*,LDC_CA_OPERUNITXRANGOREC.rowid
		FROM LDC_CA_OPERUNITXRANGOREC
		WHERE  IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CA_OPERUNITXRANGOREC.*,LDC_CA_OPERUNITXRANGOREC.rowid
		FROM LDC_CA_OPERUNITXRANGOREC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CA_OPERUNITXRANGOREC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CA_OPERUNITXRANGOREC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CA_OPERUNITXRANGOREC default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IDOPERUNITXRANGOREC);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		orcLDC_CA_OPERUNITXRANGOREC  out styLDC_CA_OPERUNITXRANGOREC
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;

		Open cuLockRcByPk
		(
			inuIDOPERUNITXRANGOREC
		);

		fetch cuLockRcByPk into orcLDC_CA_OPERUNITXRANGOREC;
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
		orcLDC_CA_OPERUNITXRANGOREC  out styLDC_CA_OPERUNITXRANGOREC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CA_OPERUNITXRANGOREC;
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
		itbLDC_CA_OPERUNITXRANGOREC  in out nocopy tytbLDC_CA_OPERUNITXRANGOREC
	)
	IS
	BEGIN
			rcRecOfTab.IDOPERUNITXRANGOREC.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.RANGOINICIAL.delete;
			rcRecOfTab.RANGOFINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CA_OPERUNITXRANGOREC  in out nocopy tytbLDC_CA_OPERUNITXRANGOREC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CA_OPERUNITXRANGOREC);

		for n in itbLDC_CA_OPERUNITXRANGOREC.first .. itbLDC_CA_OPERUNITXRANGOREC.last loop
			rcRecOfTab.IDOPERUNITXRANGOREC(n) := itbLDC_CA_OPERUNITXRANGOREC(n).IDOPERUNITXRANGOREC;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLDC_CA_OPERUNITXRANGOREC(n).OPERATING_UNIT_ID;
			rcRecOfTab.RANGOINICIAL(n) := itbLDC_CA_OPERUNITXRANGOREC(n).RANGOINICIAL;
			rcRecOfTab.RANGOFINAL(n) := itbLDC_CA_OPERUNITXRANGOREC(n).RANGOFINAL;
			rcRecOfTab.row_id(n) := itbLDC_CA_OPERUNITXRANGOREC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIDOPERUNITXRANGOREC
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
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIDOPERUNITXRANGOREC = rcData.IDOPERUNITXRANGOREC
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
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIDOPERUNITXRANGOREC
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN		rcError.IDOPERUNITXRANGOREC:=inuIDOPERUNITXRANGOREC;

		Load
		(
			inuIDOPERUNITXRANGOREC
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
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	IS
	BEGIN
		Load
		(
			inuIDOPERUNITXRANGOREC
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		orcRecord out nocopy styLDC_CA_OPERUNITXRANGOREC
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN		rcError.IDOPERUNITXRANGOREC:=inuIDOPERUNITXRANGOREC;

		Load
		(
			inuIDOPERUNITXRANGOREC
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN styLDC_CA_OPERUNITXRANGOREC
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC:=inuIDOPERUNITXRANGOREC;

		Load
		(
			inuIDOPERUNITXRANGOREC
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	)
	RETURN styLDC_CA_OPERUNITXRANGOREC
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC:=inuIDOPERUNITXRANGOREC;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIDOPERUNITXRANGOREC
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIDOPERUNITXRANGOREC
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_OPERUNITXRANGOREC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_OPERUNITXRANGOREC
	)
	IS
		rfLDC_CA_OPERUNITXRANGOREC tyrfLDC_CA_OPERUNITXRANGOREC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CA_OPERUNITXRANGOREC.*, LDC_CA_OPERUNITXRANGOREC.rowid FROM LDC_CA_OPERUNITXRANGOREC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CA_OPERUNITXRANGOREC for sbFullQuery;

		fetch rfLDC_CA_OPERUNITXRANGOREC bulk collect INTO otbResult;

		close rfLDC_CA_OPERUNITXRANGOREC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CA_OPERUNITXRANGOREC.*, LDC_CA_OPERUNITXRANGOREC.rowid FROM LDC_CA_OPERUNITXRANGOREC';
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
		ircLDC_CA_OPERUNITXRANGOREC in styLDC_CA_OPERUNITXRANGOREC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CA_OPERUNITXRANGOREC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CA_OPERUNITXRANGOREC in styLDC_CA_OPERUNITXRANGOREC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IDOPERUNITXRANGOREC');
			raise ex.controlled_error;
		end if;

		insert into LDC_CA_OPERUNITXRANGOREC
		(
			IDOPERUNITXRANGOREC,
			OPERATING_UNIT_ID,
			RANGOINICIAL,
			RANGOFINAL
		)
		values
		(
			ircLDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC,
			ircLDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID,
			ircLDC_CA_OPERUNITXRANGOREC.RANGOINICIAL,
			ircLDC_CA_OPERUNITXRANGOREC.RANGOFINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CA_OPERUNITXRANGOREC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CA_OPERUNITXRANGOREC in out nocopy tytbLDC_CA_OPERUNITXRANGOREC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_OPERUNITXRANGOREC,blUseRowID);
		forall n in iotbLDC_CA_OPERUNITXRANGOREC.first..iotbLDC_CA_OPERUNITXRANGOREC.last
			insert into LDC_CA_OPERUNITXRANGOREC
			(
				IDOPERUNITXRANGOREC,
				OPERATING_UNIT_ID,
				RANGOINICIAL,
				RANGOFINAL
			)
			values
			(
				rcRecOfTab.IDOPERUNITXRANGOREC(n),
				rcRecOfTab.OPERATING_UNIT_ID(n),
				rcRecOfTab.RANGOINICIAL(n),
				rcRecOfTab.RANGOFINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;

		if inuLock=1 then
			LockByPk
			(
				inuIDOPERUNITXRANGOREC,
				rcData
			);
		end if;


		delete
		from LDC_CA_OPERUNITXRANGOREC
		where
       		IDOPERUNITXRANGOREC=inuIDOPERUNITXRANGOREC;
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
		rcError  styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CA_OPERUNITXRANGOREC
		where
			rowid = iriRowID
		returning
			IDOPERUNITXRANGOREC
		into
			rcError.IDOPERUNITXRANGOREC;
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
		iotbLDC_CA_OPERUNITXRANGOREC in out nocopy tytbLDC_CA_OPERUNITXRANGOREC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_OPERUNITXRANGOREC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last
				delete
				from LDC_CA_OPERUNITXRANGOREC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last loop
					LockByPk
					(
						rcRecOfTab.IDOPERUNITXRANGOREC(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last
				delete
				from LDC_CA_OPERUNITXRANGOREC
				where
		         	IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CA_OPERUNITXRANGOREC in styLDC_CA_OPERUNITXRANGOREC,
		inuLock in number default 0
	)
	IS
		nuIDOPERUNITXRANGOREC	LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type;
	BEGIN
		if ircLDC_CA_OPERUNITXRANGOREC.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CA_OPERUNITXRANGOREC.rowid,rcData);
			end if;
			update LDC_CA_OPERUNITXRANGOREC
			set
				OPERATING_UNIT_ID = ircLDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID,
				RANGOINICIAL = ircLDC_CA_OPERUNITXRANGOREC.RANGOINICIAL,
				RANGOFINAL = ircLDC_CA_OPERUNITXRANGOREC.RANGOFINAL
			where
				rowid = ircLDC_CA_OPERUNITXRANGOREC.rowid
			returning
				IDOPERUNITXRANGOREC
			into
				nuIDOPERUNITXRANGOREC;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC,
					rcData
				);
			end if;

			update LDC_CA_OPERUNITXRANGOREC
			set
				OPERATING_UNIT_ID = ircLDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID,
				RANGOINICIAL = ircLDC_CA_OPERUNITXRANGOREC.RANGOINICIAL,
				RANGOFINAL = ircLDC_CA_OPERUNITXRANGOREC.RANGOFINAL
			where
				IDOPERUNITXRANGOREC = ircLDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC
			returning
				IDOPERUNITXRANGOREC
			into
				nuIDOPERUNITXRANGOREC;
		end if;
		if
			nuIDOPERUNITXRANGOREC is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CA_OPERUNITXRANGOREC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CA_OPERUNITXRANGOREC in out nocopy tytbLDC_CA_OPERUNITXRANGOREC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_OPERUNITXRANGOREC,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last
				update LDC_CA_OPERUNITXRANGOREC
				set
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					RANGOINICIAL = rcRecOfTab.RANGOINICIAL(n),
					RANGOFINAL = rcRecOfTab.RANGOFINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last loop
					LockByPk
					(
						rcRecOfTab.IDOPERUNITXRANGOREC(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_OPERUNITXRANGOREC.first .. iotbLDC_CA_OPERUNITXRANGOREC.last
				update LDC_CA_OPERUNITXRANGOREC
				SET
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					RANGOINICIAL = rcRecOfTab.RANGOINICIAL(n),
					RANGOFINAL = rcRecOfTab.RANGOFINAL(n)
				where
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n)
;
		end if;
	END;
	PROCEDURE updOPERATING_UNIT_ID
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuOPERATING_UNIT_ID$ in LDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;
		if inuLock=1 then
			LockByPk
			(
				inuIDOPERUNITXRANGOREC,
				rcData
			);
		end if;

		update LDC_CA_OPERUNITXRANGOREC
		set
			OPERATING_UNIT_ID = inuOPERATING_UNIT_ID$
		where
			IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPERATING_UNIT_ID:= inuOPERATING_UNIT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRANGOINICIAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRANGOINICIAL$ in LDC_CA_OPERUNITXRANGOREC.RANGOINICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;
		if inuLock=1 then
			LockByPk
			(
				inuIDOPERUNITXRANGOREC,
				rcData
			);
		end if;

		update LDC_CA_OPERUNITXRANGOREC
		set
			RANGOINICIAL = inuRANGOINICIAL$
		where
			IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RANGOINICIAL:= inuRANGOINICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRANGOFINAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRANGOFINAL$ in LDC_CA_OPERUNITXRANGOREC.RANGOFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN
		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;
		if inuLock=1 then
			LockByPk
			(
				inuIDOPERUNITXRANGOREC,
				rcData
			);
		end if;

		update LDC_CA_OPERUNITXRANGOREC
		set
			RANGOFINAL = inuRANGOFINAL$
		where
			IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RANGOFINAL:= inuRANGOFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN

		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDOPERUNITXRANGOREC
			 )
		then
			 return(rcData.IDOPERUNITXRANGOREC);
		end if;
		Load
		(
		 		inuIDOPERUNITXRANGOREC
		);
		return(rcData.IDOPERUNITXRANGOREC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.OPERATING_UNIT_ID%type
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN

		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDOPERUNITXRANGOREC
			 )
		then
			 return(rcData.OPERATING_UNIT_ID);
		end if;
		Load
		(
		 		inuIDOPERUNITXRANGOREC
		);
		return(rcData.OPERATING_UNIT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRANGOINICIAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.RANGOINICIAL%type
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN

		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDOPERUNITXRANGOREC
			 )
		then
			 return(rcData.RANGOINICIAL);
		end if;
		Load
		(
		 		inuIDOPERUNITXRANGOREC
		);
		return(rcData.RANGOINICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRANGOFINAL
	(
		inuIDOPERUNITXRANGOREC in LDC_CA_OPERUNITXRANGOREC.IDOPERUNITXRANGOREC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_OPERUNITXRANGOREC.RANGOFINAL%type
	IS
		rcError styLDC_CA_OPERUNITXRANGOREC;
	BEGIN

		rcError.IDOPERUNITXRANGOREC := inuIDOPERUNITXRANGOREC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDOPERUNITXRANGOREC
			 )
		then
			 return(rcData.RANGOFINAL);
		end if;
		Load
		(
		 		inuIDOPERUNITXRANGOREC
		);
		return(rcData.RANGOFINAL);
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
end DALDC_CA_OPERUNITXRANGOREC;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CA_OPERUNITXRANGOREC
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CA_OPERUNITXRANGOREC', 'ADM_PERSON'); 
END;
/