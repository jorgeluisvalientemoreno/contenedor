CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PREMISE_WARRANTY
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	IS
		SELECT LDC_PREMISE_WARRANTY.*,LDC_PREMISE_WARRANTY.rowid
		FROM LDC_PREMISE_WARRANTY
		WHERE
		    PREMISE_WARR_ID = inuPREMISE_WARR_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PREMISE_WARRANTY.*,LDC_PREMISE_WARRANTY.rowid
		FROM LDC_PREMISE_WARRANTY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PREMISE_WARRANTY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PREMISE_WARRANTY is table of styLDC_PREMISE_WARRANTY index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PREMISE_WARRANTY;

	/* Tipos referenciando al registro */
	type tytbPREMISE_WARR_ID is table of LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type index by binary_integer;
	type tytbITEM_ID is table of LDC_PREMISE_WARRANTY.ITEM_ID%type index by binary_integer;
	type tytbELEMENT_ID is table of LDC_PREMISE_WARRANTY.ELEMENT_ID%type index by binary_integer;
	type tytbELEMENT_CODE is table of LDC_PREMISE_WARRANTY.ELEMENT_CODE%type index by binary_integer;
	type tytbPREMISE_ID is table of LDC_PREMISE_WARRANTY.PREMISE_ID%type index by binary_integer;
	type tytbORDER_ID is table of LDC_PREMISE_WARRANTY.ORDER_ID%type index by binary_integer;
	type tytbFINAL_WARRANTY_DATE is table of LDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE%type index by binary_integer;
	type tytbIS_ACTIVE is table of LDC_PREMISE_WARRANTY.IS_ACTIVE%type index by binary_integer;
	type tytbITEM_SERIED_ID is table of LDC_PREMISE_WARRANTY.ITEM_SERIED_ID%type index by binary_integer;
	type tytbSERIE is table of LDC_PREMISE_WARRANTY.SERIE%type index by binary_integer;
	type tytbPRODUCT_ID is table of LDC_PREMISE_WARRANTY.PRODUCT_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PREMISE_WARRANTY is record
	(
		PREMISE_WARR_ID   tytbPREMISE_WARR_ID,
		ITEM_ID   tytbITEM_ID,
		ELEMENT_ID   tytbELEMENT_ID,
		ELEMENT_CODE   tytbELEMENT_CODE,
		PREMISE_ID   tytbPREMISE_ID,
		ORDER_ID   tytbORDER_ID,
		FINAL_WARRANTY_DATE   tytbFINAL_WARRANTY_DATE,
		IS_ACTIVE   tytbIS_ACTIVE,
		ITEM_SERIED_ID   tytbITEM_SERIED_ID,
		SERIE   tytbSERIE,
		PRODUCT_ID   tytbPRODUCT_ID,
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	);

	PROCEDURE getRecord
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		orcRecord out nocopy styLDC_PREMISE_WARRANTY
	);

	FUNCTION frcGetRcData
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN styLDC_PREMISE_WARRANTY;

	FUNCTION frcGetRcData
	RETURN styLDC_PREMISE_WARRANTY;

	FUNCTION frcGetRecord
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN styLDC_PREMISE_WARRANTY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PREMISE_WARRANTY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PREMISE_WARRANTY in styLDC_PREMISE_WARRANTY
	);

	PROCEDURE insRecord
	(
		ircLDC_PREMISE_WARRANTY in styLDC_PREMISE_WARRANTY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PREMISE_WARRANTY in out nocopy tytbLDC_PREMISE_WARRANTY
	);

	PROCEDURE delRecord
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PREMISE_WARRANTY in out nocopy tytbLDC_PREMISE_WARRANTY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PREMISE_WARRANTY in styLDC_PREMISE_WARRANTY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PREMISE_WARRANTY in out nocopy tytbLDC_PREMISE_WARRANTY,
		inuLock in number default 1
	);

	PROCEDURE updITEM_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuITEM_ID$ in LDC_PREMISE_WARRANTY.ITEM_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updELEMENT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuELEMENT_ID$ in LDC_PREMISE_WARRANTY.ELEMENT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updELEMENT_CODE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		isbELEMENT_CODE$ in LDC_PREMISE_WARRANTY.ELEMENT_CODE%type,
		inuLock in number default 0
	);

	PROCEDURE updPREMISE_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuPREMISE_ID$ in LDC_PREMISE_WARRANTY.PREMISE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuORDER_ID$ in LDC_PREMISE_WARRANTY.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAL_WARRANTY_DATE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		idtFINAL_WARRANTY_DATE$ in LDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_ACTIVE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		isbIS_ACTIVE$ in LDC_PREMISE_WARRANTY.IS_ACTIVE%type,
		inuLock in number default 0
	);

	PROCEDURE updITEM_SERIED_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuITEM_SERIED_ID$ in LDC_PREMISE_WARRANTY.ITEM_SERIED_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSERIE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		isbSERIE$ in LDC_PREMISE_WARRANTY.SERIE%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuPRODUCT_ID$ in LDC_PREMISE_WARRANTY.PRODUCT_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPREMISE_WARR_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type;

	FUNCTION fnuGetITEM_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ITEM_ID%type;

	FUNCTION fnuGetELEMENT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ELEMENT_ID%type;

	FUNCTION fsbGetELEMENT_CODE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ELEMENT_CODE%type;

	FUNCTION fnuGetPREMISE_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.PREMISE_ID%type;

	FUNCTION fnuGetORDER_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ORDER_ID%type;

	FUNCTION fdtGetFINAL_WARRANTY_DATE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE%type;

	FUNCTION fsbGetIS_ACTIVE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.IS_ACTIVE%type;

	FUNCTION fnuGetITEM_SERIED_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ITEM_SERIED_ID%type;

	FUNCTION fsbGetSERIE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.SERIE%type;

	FUNCTION fnuGetPRODUCT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.PRODUCT_ID%type;


	PROCEDURE LockByPk
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		orcLDC_PREMISE_WARRANTY  out styLDC_PREMISE_WARRANTY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PREMISE_WARRANTY  out styLDC_PREMISE_WARRANTY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PREMISE_WARRANTY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PREMISE_WARRANTY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PREMISE_WARRANTY';
	 cnuGeEntityId constant varchar2(30) := 8823; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	IS
		SELECT LDC_PREMISE_WARRANTY.*,LDC_PREMISE_WARRANTY.rowid
		FROM LDC_PREMISE_WARRANTY
		WHERE  PREMISE_WARR_ID = inuPREMISE_WARR_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PREMISE_WARRANTY.*,LDC_PREMISE_WARRANTY.rowid
		FROM LDC_PREMISE_WARRANTY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PREMISE_WARRANTY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PREMISE_WARRANTY;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PREMISE_WARRANTY default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PREMISE_WARR_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		orcLDC_PREMISE_WARRANTY  out styLDC_PREMISE_WARRANTY
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

		Open cuLockRcByPk
		(
			inuPREMISE_WARR_ID
		);

		fetch cuLockRcByPk into orcLDC_PREMISE_WARRANTY;
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
		orcLDC_PREMISE_WARRANTY  out styLDC_PREMISE_WARRANTY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PREMISE_WARRANTY;
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
		itbLDC_PREMISE_WARRANTY  in out nocopy tytbLDC_PREMISE_WARRANTY
	)
	IS
	BEGIN
			rcRecOfTab.PREMISE_WARR_ID.delete;
			rcRecOfTab.ITEM_ID.delete;
			rcRecOfTab.ELEMENT_ID.delete;
			rcRecOfTab.ELEMENT_CODE.delete;
			rcRecOfTab.PREMISE_ID.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.FINAL_WARRANTY_DATE.delete;
			rcRecOfTab.IS_ACTIVE.delete;
			rcRecOfTab.ITEM_SERIED_ID.delete;
			rcRecOfTab.SERIE.delete;
			rcRecOfTab.PRODUCT_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PREMISE_WARRANTY  in out nocopy tytbLDC_PREMISE_WARRANTY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PREMISE_WARRANTY);

		for n in itbLDC_PREMISE_WARRANTY.first .. itbLDC_PREMISE_WARRANTY.last loop
			rcRecOfTab.PREMISE_WARR_ID(n) := itbLDC_PREMISE_WARRANTY(n).PREMISE_WARR_ID;
			rcRecOfTab.ITEM_ID(n) := itbLDC_PREMISE_WARRANTY(n).ITEM_ID;
			rcRecOfTab.ELEMENT_ID(n) := itbLDC_PREMISE_WARRANTY(n).ELEMENT_ID;
			rcRecOfTab.ELEMENT_CODE(n) := itbLDC_PREMISE_WARRANTY(n).ELEMENT_CODE;
			rcRecOfTab.PREMISE_ID(n) := itbLDC_PREMISE_WARRANTY(n).PREMISE_ID;
			rcRecOfTab.ORDER_ID(n) := itbLDC_PREMISE_WARRANTY(n).ORDER_ID;
			rcRecOfTab.FINAL_WARRANTY_DATE(n) := itbLDC_PREMISE_WARRANTY(n).FINAL_WARRANTY_DATE;
			rcRecOfTab.IS_ACTIVE(n) := itbLDC_PREMISE_WARRANTY(n).IS_ACTIVE;
			rcRecOfTab.ITEM_SERIED_ID(n) := itbLDC_PREMISE_WARRANTY(n).ITEM_SERIED_ID;
			rcRecOfTab.SERIE(n) := itbLDC_PREMISE_WARRANTY(n).SERIE;
			rcRecOfTab.PRODUCT_ID(n) := itbLDC_PREMISE_WARRANTY(n).PRODUCT_ID;
			rcRecOfTab.row_id(n) := itbLDC_PREMISE_WARRANTY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPREMISE_WARR_ID
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPREMISE_WARR_ID = rcData.PREMISE_WARR_ID
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPREMISE_WARR_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN		rcError.PREMISE_WARR_ID:=inuPREMISE_WARR_ID;

		Load
		(
			inuPREMISE_WARR_ID
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPREMISE_WARR_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		orcRecord out nocopy styLDC_PREMISE_WARRANTY
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN		rcError.PREMISE_WARR_ID:=inuPREMISE_WARR_ID;

		Load
		(
			inuPREMISE_WARR_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN styLDC_PREMISE_WARRANTY
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID:=inuPREMISE_WARR_ID;

		Load
		(
			inuPREMISE_WARR_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	)
	RETURN styLDC_PREMISE_WARRANTY
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID:=inuPREMISE_WARR_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPREMISE_WARR_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPREMISE_WARR_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PREMISE_WARRANTY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PREMISE_WARRANTY
	)
	IS
		rfLDC_PREMISE_WARRANTY tyrfLDC_PREMISE_WARRANTY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PREMISE_WARRANTY.*, LDC_PREMISE_WARRANTY.rowid FROM LDC_PREMISE_WARRANTY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PREMISE_WARRANTY for sbFullQuery;

		fetch rfLDC_PREMISE_WARRANTY bulk collect INTO otbResult;

		close rfLDC_PREMISE_WARRANTY;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PREMISE_WARRANTY.*, LDC_PREMISE_WARRANTY.rowid FROM LDC_PREMISE_WARRANTY';
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
		ircLDC_PREMISE_WARRANTY in styLDC_PREMISE_WARRANTY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PREMISE_WARRANTY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PREMISE_WARRANTY in styLDC_PREMISE_WARRANTY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PREMISE_WARRANTY.PREMISE_WARR_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PREMISE_WARR_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_PREMISE_WARRANTY
		(
			PREMISE_WARR_ID,
			ITEM_ID,
			ELEMENT_ID,
			ELEMENT_CODE,
			PREMISE_ID,
			ORDER_ID,
			FINAL_WARRANTY_DATE,
			IS_ACTIVE,
			ITEM_SERIED_ID,
			SERIE,
			PRODUCT_ID
		)
		values
		(
			ircLDC_PREMISE_WARRANTY.PREMISE_WARR_ID,
			ircLDC_PREMISE_WARRANTY.ITEM_ID,
			ircLDC_PREMISE_WARRANTY.ELEMENT_ID,
			ircLDC_PREMISE_WARRANTY.ELEMENT_CODE,
			ircLDC_PREMISE_WARRANTY.PREMISE_ID,
			ircLDC_PREMISE_WARRANTY.ORDER_ID,
			ircLDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE,
			ircLDC_PREMISE_WARRANTY.IS_ACTIVE,
			ircLDC_PREMISE_WARRANTY.ITEM_SERIED_ID,
			ircLDC_PREMISE_WARRANTY.SERIE,
			ircLDC_PREMISE_WARRANTY.PRODUCT_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PREMISE_WARRANTY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PREMISE_WARRANTY in out nocopy tytbLDC_PREMISE_WARRANTY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PREMISE_WARRANTY,blUseRowID);
		forall n in iotbLDC_PREMISE_WARRANTY.first..iotbLDC_PREMISE_WARRANTY.last
			insert into LDC_PREMISE_WARRANTY
			(
				PREMISE_WARR_ID,
				ITEM_ID,
				ELEMENT_ID,
				ELEMENT_CODE,
				PREMISE_ID,
				ORDER_ID,
				FINAL_WARRANTY_DATE,
				IS_ACTIVE,
				ITEM_SERIED_ID,
				SERIE,
				PRODUCT_ID
			)
			values
			(
				rcRecOfTab.PREMISE_WARR_ID(n),
				rcRecOfTab.ITEM_ID(n),
				rcRecOfTab.ELEMENT_ID(n),
				rcRecOfTab.ELEMENT_CODE(n),
				rcRecOfTab.PREMISE_ID(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.FINAL_WARRANTY_DATE(n),
				rcRecOfTab.IS_ACTIVE(n),
				rcRecOfTab.ITEM_SERIED_ID(n),
				rcRecOfTab.SERIE(n),
				rcRecOfTab.PRODUCT_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;


		delete
		from LDC_PREMISE_WARRANTY
		where
       		PREMISE_WARR_ID=inuPREMISE_WARR_ID;
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
		rcError  styLDC_PREMISE_WARRANTY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PREMISE_WARRANTY
		where
			rowid = iriRowID
		returning
			PREMISE_WARR_ID
		into
			rcError.PREMISE_WARR_ID;
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
		iotbLDC_PREMISE_WARRANTY in out nocopy tytbLDC_PREMISE_WARRANTY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PREMISE_WARRANTY;
	BEGIN
		FillRecordOfTables(iotbLDC_PREMISE_WARRANTY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last
				delete
				from LDC_PREMISE_WARRANTY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last loop
					LockByPk
					(
						rcRecOfTab.PREMISE_WARR_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last
				delete
				from LDC_PREMISE_WARRANTY
				where
		         	PREMISE_WARR_ID = rcRecOfTab.PREMISE_WARR_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PREMISE_WARRANTY in styLDC_PREMISE_WARRANTY,
		inuLock in number default 0
	)
	IS
		nuPREMISE_WARR_ID	LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type;
	BEGIN
		if ircLDC_PREMISE_WARRANTY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PREMISE_WARRANTY.rowid,rcData);
			end if;
			update LDC_PREMISE_WARRANTY
			set
				ITEM_ID = ircLDC_PREMISE_WARRANTY.ITEM_ID,
				ELEMENT_ID = ircLDC_PREMISE_WARRANTY.ELEMENT_ID,
				ELEMENT_CODE = ircLDC_PREMISE_WARRANTY.ELEMENT_CODE,
				PREMISE_ID = ircLDC_PREMISE_WARRANTY.PREMISE_ID,
				ORDER_ID = ircLDC_PREMISE_WARRANTY.ORDER_ID,
				FINAL_WARRANTY_DATE = ircLDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE,
				IS_ACTIVE = ircLDC_PREMISE_WARRANTY.IS_ACTIVE,
				ITEM_SERIED_ID = ircLDC_PREMISE_WARRANTY.ITEM_SERIED_ID,
				SERIE = ircLDC_PREMISE_WARRANTY.SERIE,
				PRODUCT_ID = ircLDC_PREMISE_WARRANTY.PRODUCT_ID
			where
				rowid = ircLDC_PREMISE_WARRANTY.rowid
			returning
				PREMISE_WARR_ID
			into
				nuPREMISE_WARR_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PREMISE_WARRANTY.PREMISE_WARR_ID,
					rcData
				);
			end if;

			update LDC_PREMISE_WARRANTY
			set
				ITEM_ID = ircLDC_PREMISE_WARRANTY.ITEM_ID,
				ELEMENT_ID = ircLDC_PREMISE_WARRANTY.ELEMENT_ID,
				ELEMENT_CODE = ircLDC_PREMISE_WARRANTY.ELEMENT_CODE,
				PREMISE_ID = ircLDC_PREMISE_WARRANTY.PREMISE_ID,
				ORDER_ID = ircLDC_PREMISE_WARRANTY.ORDER_ID,
				FINAL_WARRANTY_DATE = ircLDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE,
				IS_ACTIVE = ircLDC_PREMISE_WARRANTY.IS_ACTIVE,
				ITEM_SERIED_ID = ircLDC_PREMISE_WARRANTY.ITEM_SERIED_ID,
				SERIE = ircLDC_PREMISE_WARRANTY.SERIE,
				PRODUCT_ID = ircLDC_PREMISE_WARRANTY.PRODUCT_ID
			where
				PREMISE_WARR_ID = ircLDC_PREMISE_WARRANTY.PREMISE_WARR_ID
			returning
				PREMISE_WARR_ID
			into
				nuPREMISE_WARR_ID;
		end if;
		if
			nuPREMISE_WARR_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PREMISE_WARRANTY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PREMISE_WARRANTY in out nocopy tytbLDC_PREMISE_WARRANTY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PREMISE_WARRANTY;
	BEGIN
		FillRecordOfTables(iotbLDC_PREMISE_WARRANTY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last
				update LDC_PREMISE_WARRANTY
				set
					ITEM_ID = rcRecOfTab.ITEM_ID(n),
					ELEMENT_ID = rcRecOfTab.ELEMENT_ID(n),
					ELEMENT_CODE = rcRecOfTab.ELEMENT_CODE(n),
					PREMISE_ID = rcRecOfTab.PREMISE_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					FINAL_WARRANTY_DATE = rcRecOfTab.FINAL_WARRANTY_DATE(n),
					IS_ACTIVE = rcRecOfTab.IS_ACTIVE(n),
					ITEM_SERIED_ID = rcRecOfTab.ITEM_SERIED_ID(n),
					SERIE = rcRecOfTab.SERIE(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last loop
					LockByPk
					(
						rcRecOfTab.PREMISE_WARR_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PREMISE_WARRANTY.first .. iotbLDC_PREMISE_WARRANTY.last
				update LDC_PREMISE_WARRANTY
				SET
					ITEM_ID = rcRecOfTab.ITEM_ID(n),
					ELEMENT_ID = rcRecOfTab.ELEMENT_ID(n),
					ELEMENT_CODE = rcRecOfTab.ELEMENT_CODE(n),
					PREMISE_ID = rcRecOfTab.PREMISE_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					FINAL_WARRANTY_DATE = rcRecOfTab.FINAL_WARRANTY_DATE(n),
					IS_ACTIVE = rcRecOfTab.IS_ACTIVE(n),
					ITEM_SERIED_ID = rcRecOfTab.ITEM_SERIED_ID(n),
					SERIE = rcRecOfTab.SERIE(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n)
				where
					PREMISE_WARR_ID = rcRecOfTab.PREMISE_WARR_ID(n)
;
		end if;
	END;
	PROCEDURE updITEM_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuITEM_ID$ in LDC_PREMISE_WARRANTY.ITEM_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			ITEM_ID = inuITEM_ID$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_ID:= inuITEM_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updELEMENT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuELEMENT_ID$ in LDC_PREMISE_WARRANTY.ELEMENT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			ELEMENT_ID = inuELEMENT_ID$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ELEMENT_ID:= inuELEMENT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updELEMENT_CODE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		isbELEMENT_CODE$ in LDC_PREMISE_WARRANTY.ELEMENT_CODE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			ELEMENT_CODE = isbELEMENT_CODE$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ELEMENT_CODE:= isbELEMENT_CODE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPREMISE_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuPREMISE_ID$ in LDC_PREMISE_WARRANTY.PREMISE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			PREMISE_ID = inuPREMISE_ID$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PREMISE_ID:= inuPREMISE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuORDER_ID$ in LDC_PREMISE_WARRANTY.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			ORDER_ID = inuORDER_ID$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAL_WARRANTY_DATE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		idtFINAL_WARRANTY_DATE$ in LDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			FINAL_WARRANTY_DATE = idtFINAL_WARRANTY_DATE$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAL_WARRANTY_DATE:= idtFINAL_WARRANTY_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_ACTIVE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		isbIS_ACTIVE$ in LDC_PREMISE_WARRANTY.IS_ACTIVE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			IS_ACTIVE = isbIS_ACTIVE$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_ACTIVE:= isbIS_ACTIVE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEM_SERIED_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuITEM_SERIED_ID$ in LDC_PREMISE_WARRANTY.ITEM_SERIED_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			ITEM_SERIED_ID = inuITEM_SERIED_ID$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_SERIED_ID:= inuITEM_SERIED_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSERIE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		isbSERIE$ in LDC_PREMISE_WARRANTY.SERIE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			SERIE = isbSERIE$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SERIE:= isbSERIE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuPRODUCT_ID$ in LDC_PREMISE_WARRANTY.PRODUCT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN
		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPREMISE_WARR_ID,
				rcData
			);
		end if;

		update LDC_PREMISE_WARRANTY
		set
			PRODUCT_ID = inuPRODUCT_ID$
		where
			PREMISE_WARR_ID = inuPREMISE_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_ID:= inuPRODUCT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPREMISE_WARR_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.PREMISE_WARR_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.PREMISE_WARR_ID);
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ITEM_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.ITEM_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
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
	FUNCTION fnuGetELEMENT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ELEMENT_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.ELEMENT_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.ELEMENT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetELEMENT_CODE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ELEMENT_CODE%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.ELEMENT_CODE);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.ELEMENT_CODE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPREMISE_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.PREMISE_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.PREMISE_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.PREMISE_ID);
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ORDER_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
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
	FUNCTION fdtGetFINAL_WARRANTY_DATE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.FINAL_WARRANTY_DATE%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.FINAL_WARRANTY_DATE);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.FINAL_WARRANTY_DATE);
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
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.IS_ACTIVE%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.IS_ACTIVE);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
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
	FUNCTION fnuGetITEM_SERIED_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.ITEM_SERIED_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.ITEM_SERIED_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.ITEM_SERIED_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSERIE
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.SERIE%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.SERIE);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.SERIE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRODUCT_ID
	(
		inuPREMISE_WARR_ID in LDC_PREMISE_WARRANTY.PREMISE_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PREMISE_WARRANTY.PRODUCT_ID%type
	IS
		rcError styLDC_PREMISE_WARRANTY;
	BEGIN

		rcError.PREMISE_WARR_ID := inuPREMISE_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPREMISE_WARR_ID
			 )
		then
			 return(rcData.PRODUCT_ID);
		end if;
		Load
		(
		 		inuPREMISE_WARR_ID
		);
		return(rcData.PRODUCT_ID);
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
end DALDC_PREMISE_WARRANTY;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PREMISE_WARRANTY
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PREMISE_WARRANTY', 'ADM_PERSON');
END;
/