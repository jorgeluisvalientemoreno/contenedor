CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_INVOICE_FNB_SALES
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
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	IS
		SELECT LDC_INVOICE_FNB_SALES.*,LDC_INVOICE_FNB_SALES.rowid
		FROM LDC_INVOICE_FNB_SALES
		WHERE
		    CONSECUTIVE = inuCONSECUTIVE;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_INVOICE_FNB_SALES.*,LDC_INVOICE_FNB_SALES.rowid
		FROM LDC_INVOICE_FNB_SALES
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_INVOICE_FNB_SALES  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_INVOICE_FNB_SALES is table of styLDC_INVOICE_FNB_SALES index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_INVOICE_FNB_SALES;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVE is table of LDC_INVOICE_FNB_SALES.CONSECUTIVE%type index by binary_integer;
	type tytbINVOICE is table of LDC_INVOICE_FNB_SALES.INVOICE%type index by binary_integer;
	type tytbORDER_ID is table of LDC_INVOICE_FNB_SALES.ORDER_ID%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_INVOICE_FNB_SALES.PACKAGE_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LDC_INVOICE_FNB_SALES.REGISTER_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_INVOICE_FNB_SALES is record
	(
		CONSECUTIVE   tytbCONSECUTIVE,
		INVOICE   tytbINVOICE,
		ORDER_ID   tytbORDER_ID,
		PACKAGE_ID   tytbPACKAGE_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
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
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		orcRecord out nocopy styLDC_INVOICE_FNB_SALES
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN styLDC_INVOICE_FNB_SALES;

	FUNCTION frcGetRcData
	RETURN styLDC_INVOICE_FNB_SALES;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN styLDC_INVOICE_FNB_SALES;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_INVOICE_FNB_SALES
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_INVOICE_FNB_SALES in styLDC_INVOICE_FNB_SALES
	);

	PROCEDURE insRecord
	(
		ircLDC_INVOICE_FNB_SALES in styLDC_INVOICE_FNB_SALES,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_INVOICE_FNB_SALES in out nocopy tytbLDC_INVOICE_FNB_SALES
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_INVOICE_FNB_SALES in out nocopy tytbLDC_INVOICE_FNB_SALES,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_INVOICE_FNB_SALES in styLDC_INVOICE_FNB_SALES,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_INVOICE_FNB_SALES in out nocopy tytbLDC_INVOICE_FNB_SALES,
		inuLock in number default 1
	);

	PROCEDURE updINVOICE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		isbINVOICE$ in LDC_INVOICE_FNB_SALES.INVOICE%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuORDER_ID$ in LDC_INVOICE_FNB_SALES.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuPACKAGE_ID$ in LDC_INVOICE_FNB_SALES.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		idtREGISTER_DATE$ in LDC_INVOICE_FNB_SALES.REGISTER_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.CONSECUTIVE%type;

	FUNCTION fsbGetINVOICE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.INVOICE%type;

	FUNCTION fnuGetORDER_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.ORDER_ID%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.PACKAGE_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.REGISTER_DATE%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		orcLDC_INVOICE_FNB_SALES  out styLDC_INVOICE_FNB_SALES
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_INVOICE_FNB_SALES  out styLDC_INVOICE_FNB_SALES
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_INVOICE_FNB_SALES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_INVOICE_FNB_SALES
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_INVOICE_FNB_SALES';
	 cnuGeEntityId constant varchar2(30) := 2115; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	IS
		SELECT LDC_INVOICE_FNB_SALES.*,LDC_INVOICE_FNB_SALES.rowid
		FROM LDC_INVOICE_FNB_SALES
		WHERE  CONSECUTIVE = inuCONSECUTIVE
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_INVOICE_FNB_SALES.*,LDC_INVOICE_FNB_SALES.rowid
		FROM LDC_INVOICE_FNB_SALES
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_INVOICE_FNB_SALES is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_INVOICE_FNB_SALES;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_INVOICE_FNB_SALES default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVE);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		orcLDC_INVOICE_FNB_SALES  out styLDC_INVOICE_FNB_SALES
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;

		Open cuLockRcByPk
		(
			inuCONSECUTIVE
		);

		fetch cuLockRcByPk into orcLDC_INVOICE_FNB_SALES;
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
		orcLDC_INVOICE_FNB_SALES  out styLDC_INVOICE_FNB_SALES
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_INVOICE_FNB_SALES;
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
		itbLDC_INVOICE_FNB_SALES  in out nocopy tytbLDC_INVOICE_FNB_SALES
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVE.delete;
			rcRecOfTab.INVOICE.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_INVOICE_FNB_SALES  in out nocopy tytbLDC_INVOICE_FNB_SALES,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_INVOICE_FNB_SALES);

		for n in itbLDC_INVOICE_FNB_SALES.first .. itbLDC_INVOICE_FNB_SALES.last loop
			rcRecOfTab.CONSECUTIVE(n) := itbLDC_INVOICE_FNB_SALES(n).CONSECUTIVE;
			rcRecOfTab.INVOICE(n) := itbLDC_INVOICE_FNB_SALES(n).INVOICE;
			rcRecOfTab.ORDER_ID(n) := itbLDC_INVOICE_FNB_SALES(n).ORDER_ID;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_INVOICE_FNB_SALES(n).PACKAGE_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLDC_INVOICE_FNB_SALES(n).REGISTER_DATE;
			rcRecOfTab.row_id(n) := itbLDC_INVOICE_FNB_SALES(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVE
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
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVE = rcData.CONSECUTIVE
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
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVE
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
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
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVE
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		orcRecord out nocopy styLDC_INVOICE_FNB_SALES
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN styLDC_INVOICE_FNB_SALES
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	)
	RETURN styLDC_INVOICE_FNB_SALES
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE:=inuCONSECUTIVE;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVE
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_INVOICE_FNB_SALES
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_INVOICE_FNB_SALES
	)
	IS
		rfLDC_INVOICE_FNB_SALES tyrfLDC_INVOICE_FNB_SALES;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_INVOICE_FNB_SALES.*, LDC_INVOICE_FNB_SALES.rowid FROM LDC_INVOICE_FNB_SALES';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_INVOICE_FNB_SALES for sbFullQuery;

		fetch rfLDC_INVOICE_FNB_SALES bulk collect INTO otbResult;

		close rfLDC_INVOICE_FNB_SALES;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_INVOICE_FNB_SALES.*, LDC_INVOICE_FNB_SALES.rowid FROM LDC_INVOICE_FNB_SALES';
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
		ircLDC_INVOICE_FNB_SALES in styLDC_INVOICE_FNB_SALES
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_INVOICE_FNB_SALES,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_INVOICE_FNB_SALES in styLDC_INVOICE_FNB_SALES,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_INVOICE_FNB_SALES.CONSECUTIVE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVE');
			raise ex.controlled_error;
		end if;

		insert into LDC_INVOICE_FNB_SALES
		(
			CONSECUTIVE,
			INVOICE,
			ORDER_ID,
			PACKAGE_ID,
			REGISTER_DATE
		)
		values
		(
			ircLDC_INVOICE_FNB_SALES.CONSECUTIVE,
			ircLDC_INVOICE_FNB_SALES.INVOICE,
			ircLDC_INVOICE_FNB_SALES.ORDER_ID,
			ircLDC_INVOICE_FNB_SALES.PACKAGE_ID,
			ircLDC_INVOICE_FNB_SALES.REGISTER_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_INVOICE_FNB_SALES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_INVOICE_FNB_SALES in out nocopy tytbLDC_INVOICE_FNB_SALES
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_INVOICE_FNB_SALES,blUseRowID);
		forall n in iotbLDC_INVOICE_FNB_SALES.first..iotbLDC_INVOICE_FNB_SALES.last
			insert into LDC_INVOICE_FNB_SALES
			(
				CONSECUTIVE,
				INVOICE,
				ORDER_ID,
				PACKAGE_ID,
				REGISTER_DATE
			)
			values
			(
				rcRecOfTab.CONSECUTIVE(n),
				rcRecOfTab.INVOICE(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.REGISTER_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;


		delete
		from LDC_INVOICE_FNB_SALES
		where
       		CONSECUTIVE=inuCONSECUTIVE;
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
		rcError  styLDC_INVOICE_FNB_SALES;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_INVOICE_FNB_SALES
		where
			rowid = iriRowID
		returning
			CONSECUTIVE
		into
			rcError.CONSECUTIVE;
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
		iotbLDC_INVOICE_FNB_SALES in out nocopy tytbLDC_INVOICE_FNB_SALES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_INVOICE_FNB_SALES;
	BEGIN
		FillRecordOfTables(iotbLDC_INVOICE_FNB_SALES, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last
				delete
				from LDC_INVOICE_FNB_SALES
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last
				delete
				from LDC_INVOICE_FNB_SALES
				where
		         	CONSECUTIVE = rcRecOfTab.CONSECUTIVE(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_INVOICE_FNB_SALES in styLDC_INVOICE_FNB_SALES,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVE	LDC_INVOICE_FNB_SALES.CONSECUTIVE%type;
	BEGIN
		if ircLDC_INVOICE_FNB_SALES.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_INVOICE_FNB_SALES.rowid,rcData);
			end if;
			update LDC_INVOICE_FNB_SALES
			set
				INVOICE = ircLDC_INVOICE_FNB_SALES.INVOICE,
				ORDER_ID = ircLDC_INVOICE_FNB_SALES.ORDER_ID,
				PACKAGE_ID = ircLDC_INVOICE_FNB_SALES.PACKAGE_ID,
				REGISTER_DATE = ircLDC_INVOICE_FNB_SALES.REGISTER_DATE
			where
				rowid = ircLDC_INVOICE_FNB_SALES.rowid
			returning
				CONSECUTIVE
			into
				nuCONSECUTIVE;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_INVOICE_FNB_SALES.CONSECUTIVE,
					rcData
				);
			end if;

			update LDC_INVOICE_FNB_SALES
			set
				INVOICE = ircLDC_INVOICE_FNB_SALES.INVOICE,
				ORDER_ID = ircLDC_INVOICE_FNB_SALES.ORDER_ID,
				PACKAGE_ID = ircLDC_INVOICE_FNB_SALES.PACKAGE_ID,
				REGISTER_DATE = ircLDC_INVOICE_FNB_SALES.REGISTER_DATE
			where
				CONSECUTIVE = ircLDC_INVOICE_FNB_SALES.CONSECUTIVE
			returning
				CONSECUTIVE
			into
				nuCONSECUTIVE;
		end if;
		if
			nuCONSECUTIVE is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_INVOICE_FNB_SALES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_INVOICE_FNB_SALES in out nocopy tytbLDC_INVOICE_FNB_SALES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_INVOICE_FNB_SALES;
	BEGIN
		FillRecordOfTables(iotbLDC_INVOICE_FNB_SALES,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last
				update LDC_INVOICE_FNB_SALES
				set
					INVOICE = rcRecOfTab.INVOICE(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INVOICE_FNB_SALES.first .. iotbLDC_INVOICE_FNB_SALES.last
				update LDC_INVOICE_FNB_SALES
				SET
					INVOICE = rcRecOfTab.INVOICE(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n)
				where
					CONSECUTIVE = rcRecOfTab.CONSECUTIVE(n)
;
		end if;
	END;
	PROCEDURE updINVOICE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		isbINVOICE$ in LDC_INVOICE_FNB_SALES.INVOICE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INVOICE_FNB_SALES
		set
			INVOICE = isbINVOICE$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INVOICE:= isbINVOICE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuORDER_ID$ in LDC_INVOICE_FNB_SALES.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INVOICE_FNB_SALES
		set
			ORDER_ID = inuORDER_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuPACKAGE_ID$ in LDC_INVOICE_FNB_SALES.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INVOICE_FNB_SALES
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		idtREGISTER_DATE$ in LDC_INVOICE_FNB_SALES.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INVOICE_FNB_SALES
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.CONSECUTIVE%type
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.CONSECUTIVE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.CONSECUTIVE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetINVOICE
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.INVOICE%type
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.INVOICE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.INVOICE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.ORDER_ID%type
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.ORDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.PACKAGE_ID%type
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.PACKAGE_ID);
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
		inuCONSECUTIVE in LDC_INVOICE_FNB_SALES.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INVOICE_FNB_SALES.REGISTER_DATE%type
	IS
		rcError styLDC_INVOICE_FNB_SALES;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_INVOICE_FNB_SALES;
/
PROMPT Otorgando permisos de ejecucion a DALDC_INVOICE_FNB_SALES
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_INVOICE_FNB_SALES', 'ADM_PERSON');
END;
/