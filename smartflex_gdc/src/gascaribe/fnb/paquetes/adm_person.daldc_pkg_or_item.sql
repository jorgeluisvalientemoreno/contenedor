CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PKG_OR_ITEM
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	IS
		SELECT LDC_PKG_OR_ITEM.*,LDC_PKG_OR_ITEM.rowid
		FROM LDC_PKG_OR_ITEM
		WHERE
		    LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PKG_OR_ITEM.*,LDC_PKG_OR_ITEM.rowid
		FROM LDC_PKG_OR_ITEM
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PKG_OR_ITEM  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PKG_OR_ITEM is table of styLDC_PKG_OR_ITEM index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PKG_OR_ITEM;

	/* Tipos referenciando al registro */
	type tytbLDC_PKG_OR_ITEM_ID is table of LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type index by binary_integer;
	type tytbORDER_ITEM_ID is table of LDC_PKG_OR_ITEM.ORDER_ITEM_ID%type index by binary_integer;
	type tytbORDER_ID is table of LDC_PKG_OR_ITEM.ORDER_ID%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_PKG_OR_ITEM.PACKAGE_ID%type index by binary_integer;
	type tytbOBSERVACION is table of LDC_PKG_OR_ITEM.OBSERVACION%type index by binary_integer;
	type tytbFECHA is table of LDC_PKG_OR_ITEM.FECHA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PKG_OR_ITEM is record
	(
		LDC_PKG_OR_ITEM_ID   tytbLDC_PKG_OR_ITEM_ID,
		ORDER_ITEM_ID   tytbORDER_ITEM_ID,
		ORDER_ID   tytbORDER_ID,
		PACKAGE_ID   tytbPACKAGE_ID,
		OBSERVACION   tytbOBSERVACION,
		FECHA   tytbFECHA,
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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	);

	PROCEDURE getRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		orcRecord out nocopy styLDC_PKG_OR_ITEM
	);

	FUNCTION frcGetRcData
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN styLDC_PKG_OR_ITEM;

	FUNCTION frcGetRcData
	RETURN styLDC_PKG_OR_ITEM;

	FUNCTION frcGetRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN styLDC_PKG_OR_ITEM;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PKG_OR_ITEM
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PKG_OR_ITEM in styLDC_PKG_OR_ITEM
	);

	PROCEDURE insRecord
	(
		ircLDC_PKG_OR_ITEM in styLDC_PKG_OR_ITEM,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PKG_OR_ITEM in out nocopy tytbLDC_PKG_OR_ITEM
	);

	PROCEDURE delRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PKG_OR_ITEM in out nocopy tytbLDC_PKG_OR_ITEM,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PKG_OR_ITEM in styLDC_PKG_OR_ITEM,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PKG_OR_ITEM in out nocopy tytbLDC_PKG_OR_ITEM,
		inuLock in number default 1
	);

	PROCEDURE updORDER_ITEM_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuORDER_ITEM_ID$ in LDC_PKG_OR_ITEM.ORDER_ITEM_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuORDER_ID$ in LDC_PKG_OR_ITEM.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuPACKAGE_ID$ in LDC_PKG_OR_ITEM.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVACION
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		isbOBSERVACION$ in LDC_PKG_OR_ITEM.OBSERVACION%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		idtFECHA$ in LDC_PKG_OR_ITEM.FECHA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetLDC_PKG_OR_ITEM_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type;

	FUNCTION fnuGetORDER_ITEM_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.ORDER_ITEM_ID%type;

	FUNCTION fnuGetORDER_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.ORDER_ID%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.PACKAGE_ID%type;

	FUNCTION fsbGetOBSERVACION
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.OBSERVACION%type;

	FUNCTION fdtGetFECHA
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.FECHA%type;


	PROCEDURE LockByPk
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		orcLDC_PKG_OR_ITEM  out styLDC_PKG_OR_ITEM
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PKG_OR_ITEM  out styLDC_PKG_OR_ITEM
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PKG_OR_ITEM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PKG_OR_ITEM
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PKG_OR_ITEM';
	 cnuGeEntityId constant varchar2(30) := 8109; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	IS
		SELECT LDC_PKG_OR_ITEM.*,LDC_PKG_OR_ITEM.rowid
		FROM LDC_PKG_OR_ITEM
		WHERE  LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PKG_OR_ITEM.*,LDC_PKG_OR_ITEM.rowid
		FROM LDC_PKG_OR_ITEM
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PKG_OR_ITEM is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PKG_OR_ITEM;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PKG_OR_ITEM default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LDC_PKG_OR_ITEM_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		orcLDC_PKG_OR_ITEM  out styLDC_PKG_OR_ITEM
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

		Open cuLockRcByPk
		(
			inuLDC_PKG_OR_ITEM_ID
		);

		fetch cuLockRcByPk into orcLDC_PKG_OR_ITEM;
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
		orcLDC_PKG_OR_ITEM  out styLDC_PKG_OR_ITEM
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PKG_OR_ITEM;
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
		itbLDC_PKG_OR_ITEM  in out nocopy tytbLDC_PKG_OR_ITEM
	)
	IS
	BEGIN
			rcRecOfTab.LDC_PKG_OR_ITEM_ID.delete;
			rcRecOfTab.ORDER_ITEM_ID.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.FECHA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PKG_OR_ITEM  in out nocopy tytbLDC_PKG_OR_ITEM,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PKG_OR_ITEM);

		for n in itbLDC_PKG_OR_ITEM.first .. itbLDC_PKG_OR_ITEM.last loop
			rcRecOfTab.LDC_PKG_OR_ITEM_ID(n) := itbLDC_PKG_OR_ITEM(n).LDC_PKG_OR_ITEM_ID;
			rcRecOfTab.ORDER_ITEM_ID(n) := itbLDC_PKG_OR_ITEM(n).ORDER_ITEM_ID;
			rcRecOfTab.ORDER_ID(n) := itbLDC_PKG_OR_ITEM(n).ORDER_ID;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_PKG_OR_ITEM(n).PACKAGE_ID;
			rcRecOfTab.OBSERVACION(n) := itbLDC_PKG_OR_ITEM(n).OBSERVACION;
			rcRecOfTab.FECHA(n) := itbLDC_PKG_OR_ITEM(n).FECHA;
			rcRecOfTab.row_id(n) := itbLDC_PKG_OR_ITEM(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLDC_PKG_OR_ITEM_ID
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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLDC_PKG_OR_ITEM_ID = rcData.LDC_PKG_OR_ITEM_ID
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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLDC_PKG_OR_ITEM_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN		rcError.LDC_PKG_OR_ITEM_ID:=inuLDC_PKG_OR_ITEM_ID;

		Load
		(
			inuLDC_PKG_OR_ITEM_ID
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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuLDC_PKG_OR_ITEM_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		orcRecord out nocopy styLDC_PKG_OR_ITEM
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN		rcError.LDC_PKG_OR_ITEM_ID:=inuLDC_PKG_OR_ITEM_ID;

		Load
		(
			inuLDC_PKG_OR_ITEM_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN styLDC_PKG_OR_ITEM
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID:=inuLDC_PKG_OR_ITEM_ID;

		Load
		(
			inuLDC_PKG_OR_ITEM_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	)
	RETURN styLDC_PKG_OR_ITEM
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID:=inuLDC_PKG_OR_ITEM_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLDC_PKG_OR_ITEM_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PKG_OR_ITEM
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PKG_OR_ITEM
	)
	IS
		rfLDC_PKG_OR_ITEM tyrfLDC_PKG_OR_ITEM;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PKG_OR_ITEM.*, LDC_PKG_OR_ITEM.rowid FROM LDC_PKG_OR_ITEM';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PKG_OR_ITEM for sbFullQuery;

		fetch rfLDC_PKG_OR_ITEM bulk collect INTO otbResult;

		close rfLDC_PKG_OR_ITEM;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PKG_OR_ITEM.*, LDC_PKG_OR_ITEM.rowid FROM LDC_PKG_OR_ITEM';
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
		ircLDC_PKG_OR_ITEM in styLDC_PKG_OR_ITEM
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PKG_OR_ITEM,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PKG_OR_ITEM in styLDC_PKG_OR_ITEM,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LDC_PKG_OR_ITEM_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_PKG_OR_ITEM
		(
			LDC_PKG_OR_ITEM_ID,
			ORDER_ITEM_ID,
			ORDER_ID,
			PACKAGE_ID,
			OBSERVACION,
			FECHA
		)
		values
		(
			ircLDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID,
			ircLDC_PKG_OR_ITEM.ORDER_ITEM_ID,
			ircLDC_PKG_OR_ITEM.ORDER_ID,
			ircLDC_PKG_OR_ITEM.PACKAGE_ID,
			ircLDC_PKG_OR_ITEM.OBSERVACION,
			ircLDC_PKG_OR_ITEM.FECHA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PKG_OR_ITEM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PKG_OR_ITEM in out nocopy tytbLDC_PKG_OR_ITEM
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PKG_OR_ITEM,blUseRowID);
		forall n in iotbLDC_PKG_OR_ITEM.first..iotbLDC_PKG_OR_ITEM.last
			insert into LDC_PKG_OR_ITEM
			(
				LDC_PKG_OR_ITEM_ID,
				ORDER_ITEM_ID,
				ORDER_ID,
				PACKAGE_ID,
				OBSERVACION,
				FECHA
			)
			values
			(
				rcRecOfTab.LDC_PKG_OR_ITEM_ID(n),
				rcRecOfTab.ORDER_ITEM_ID(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.OBSERVACION(n),
				rcRecOfTab.FECHA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

		if inuLock=1 then
			LockByPk
			(
				inuLDC_PKG_OR_ITEM_ID,
				rcData
			);
		end if;


		delete
		from LDC_PKG_OR_ITEM
		where
       		LDC_PKG_OR_ITEM_ID=inuLDC_PKG_OR_ITEM_ID;
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
		rcError  styLDC_PKG_OR_ITEM;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PKG_OR_ITEM
		where
			rowid = iriRowID
		returning
			LDC_PKG_OR_ITEM_ID
		into
			rcError.LDC_PKG_OR_ITEM_ID;
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
		iotbLDC_PKG_OR_ITEM in out nocopy tytbLDC_PKG_OR_ITEM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PKG_OR_ITEM;
	BEGIN
		FillRecordOfTables(iotbLDC_PKG_OR_ITEM, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last
				delete
				from LDC_PKG_OR_ITEM
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last loop
					LockByPk
					(
						rcRecOfTab.LDC_PKG_OR_ITEM_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last
				delete
				from LDC_PKG_OR_ITEM
				where
		         	LDC_PKG_OR_ITEM_ID = rcRecOfTab.LDC_PKG_OR_ITEM_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PKG_OR_ITEM in styLDC_PKG_OR_ITEM,
		inuLock in number default 0
	)
	IS
		nuLDC_PKG_OR_ITEM_ID	LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type;
	BEGIN
		if ircLDC_PKG_OR_ITEM.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PKG_OR_ITEM.rowid,rcData);
			end if;
			update LDC_PKG_OR_ITEM
			set
				ORDER_ITEM_ID = ircLDC_PKG_OR_ITEM.ORDER_ITEM_ID,
				ORDER_ID = ircLDC_PKG_OR_ITEM.ORDER_ID,
				PACKAGE_ID = ircLDC_PKG_OR_ITEM.PACKAGE_ID,
				OBSERVACION = ircLDC_PKG_OR_ITEM.OBSERVACION,
				FECHA = ircLDC_PKG_OR_ITEM.FECHA
			where
				rowid = ircLDC_PKG_OR_ITEM.rowid
			returning
				LDC_PKG_OR_ITEM_ID
			into
				nuLDC_PKG_OR_ITEM_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID,
					rcData
				);
			end if;

			update LDC_PKG_OR_ITEM
			set
				ORDER_ITEM_ID = ircLDC_PKG_OR_ITEM.ORDER_ITEM_ID,
				ORDER_ID = ircLDC_PKG_OR_ITEM.ORDER_ID,
				PACKAGE_ID = ircLDC_PKG_OR_ITEM.PACKAGE_ID,
				OBSERVACION = ircLDC_PKG_OR_ITEM.OBSERVACION,
				FECHA = ircLDC_PKG_OR_ITEM.FECHA
			where
				LDC_PKG_OR_ITEM_ID = ircLDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID
			returning
				LDC_PKG_OR_ITEM_ID
			into
				nuLDC_PKG_OR_ITEM_ID;
		end if;
		if
			nuLDC_PKG_OR_ITEM_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PKG_OR_ITEM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PKG_OR_ITEM in out nocopy tytbLDC_PKG_OR_ITEM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PKG_OR_ITEM;
	BEGIN
		FillRecordOfTables(iotbLDC_PKG_OR_ITEM,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last
				update LDC_PKG_OR_ITEM
				set
					ORDER_ITEM_ID = rcRecOfTab.ORDER_ITEM_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					FECHA = rcRecOfTab.FECHA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last loop
					LockByPk
					(
						rcRecOfTab.LDC_PKG_OR_ITEM_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PKG_OR_ITEM.first .. iotbLDC_PKG_OR_ITEM.last
				update LDC_PKG_OR_ITEM
				SET
					ORDER_ITEM_ID = rcRecOfTab.ORDER_ITEM_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					FECHA = rcRecOfTab.FECHA(n)
				where
					LDC_PKG_OR_ITEM_ID = rcRecOfTab.LDC_PKG_OR_ITEM_ID(n)
;
		end if;
	END;
	PROCEDURE updORDER_ITEM_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuORDER_ITEM_ID$ in LDC_PKG_OR_ITEM.ORDER_ITEM_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_PKG_OR_ITEM_ID,
				rcData
			);
		end if;

		update LDC_PKG_OR_ITEM
		set
			ORDER_ITEM_ID = inuORDER_ITEM_ID$
		where
			LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ITEM_ID:= inuORDER_ITEM_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuORDER_ID$ in LDC_PKG_OR_ITEM.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_PKG_OR_ITEM_ID,
				rcData
			);
		end if;

		update LDC_PKG_OR_ITEM
		set
			ORDER_ID = inuORDER_ID$
		where
			LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID;

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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuPACKAGE_ID$ in LDC_PKG_OR_ITEM.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_PKG_OR_ITEM_ID,
				rcData
			);
		end if;

		update LDC_PKG_OR_ITEM
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVACION
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		isbOBSERVACION$ in LDC_PKG_OR_ITEM.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_PKG_OR_ITEM_ID,
				rcData
			);
		end if;

		update LDC_PKG_OR_ITEM
		set
			OBSERVACION = isbOBSERVACION$
		where
			LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		idtFECHA$ in LDC_PKG_OR_ITEM.FECHA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN
		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_PKG_OR_ITEM_ID,
				rcData
			);
		end if;

		update LDC_PKG_OR_ITEM
		set
			FECHA = idtFECHA$
		where
			LDC_PKG_OR_ITEM_ID = inuLDC_PKG_OR_ITEM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA:= idtFECHA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetLDC_PKG_OR_ITEM_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN

		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData.LDC_PKG_OR_ITEM_ID);
		end if;
		Load
		(
		 		inuLDC_PKG_OR_ITEM_ID
		);
		return(rcData.LDC_PKG_OR_ITEM_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ITEM_ID
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.ORDER_ITEM_ID%type
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN

		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData.ORDER_ITEM_ID);
		end if;
		Load
		(
		 		inuLDC_PKG_OR_ITEM_ID
		);
		return(rcData.ORDER_ITEM_ID);
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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.ORDER_ID%type
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN

		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuLDC_PKG_OR_ITEM_ID
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
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.PACKAGE_ID%type
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN

		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuLDC_PKG_OR_ITEM_ID
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
	FUNCTION fsbGetOBSERVACION
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.OBSERVACION%type
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN

		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuLDC_PKG_OR_ITEM_ID
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
	FUNCTION fdtGetFECHA
	(
		inuLDC_PKG_OR_ITEM_ID in LDC_PKG_OR_ITEM.LDC_PKG_OR_ITEM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PKG_OR_ITEM.FECHA%type
	IS
		rcError styLDC_PKG_OR_ITEM;
	BEGIN

		rcError.LDC_PKG_OR_ITEM_ID := inuLDC_PKG_OR_ITEM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_PKG_OR_ITEM_ID
			 )
		then
			 return(rcData.FECHA);
		end if;
		Load
		(
		 		inuLDC_PKG_OR_ITEM_ID
		);
		return(rcData.FECHA);
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
end DALDC_PKG_OR_ITEM;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PKG_OR_ITEM
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PKG_OR_ITEM', 'ADM_PERSON');
END;
/