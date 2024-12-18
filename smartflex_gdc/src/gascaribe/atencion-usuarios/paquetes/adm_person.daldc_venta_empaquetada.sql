CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_VENTA_EMPAQUETADA
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
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	IS
		SELECT LDC_VENTA_EMPAQUETADA.*,LDC_VENTA_EMPAQUETADA.rowid
		FROM LDC_VENTA_EMPAQUETADA
		WHERE
		    PACKAGE_ID = inuPACKAGE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VENTA_EMPAQUETADA.*,LDC_VENTA_EMPAQUETADA.rowid
		FROM LDC_VENTA_EMPAQUETADA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VENTA_EMPAQUETADA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VENTA_EMPAQUETADA is table of styLDC_VENTA_EMPAQUETADA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VENTA_EMPAQUETADA;

	/* Tipos referenciando al registro */
	type tytbPACKAGE_ID is table of LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type index by binary_integer;
	type tytbPACKAGE_TYPE_ID is table of LDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID%type index by binary_integer;
	type tytbGAS_APPLIANC_SALE is table of LDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbPACKAGE_FNB_ID is table of LDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID%type index by binary_integer;
	type tytbFLAG_GAS_FNB_SALE is table of LDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE%type index by binary_integer;
	type tytbREGISTER_DATE is table of LDC_VENTA_EMPAQUETADA.REGISTER_DATE%type index by binary_integer;
	type tytbREGIST_FNB_DATE is table of LDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VENTA_EMPAQUETADA is record
	(
		PACKAGE_ID   tytbPACKAGE_ID,
		PACKAGE_TYPE_ID   tytbPACKAGE_TYPE_ID,
		GAS_APPLIANC_SALE   tytbGAS_APPLIANC_SALE,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		PACKAGE_FNB_ID   tytbPACKAGE_FNB_ID,
		FLAG_GAS_FNB_SALE   tytbFLAG_GAS_FNB_SALE,
		REGISTER_DATE   tytbREGISTER_DATE,
		REGIST_FNB_DATE   tytbREGIST_FNB_DATE,
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
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	);

	PROCEDURE getRecord
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		orcRecord out nocopy styLDC_VENTA_EMPAQUETADA
	);

	FUNCTION frcGetRcData
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN styLDC_VENTA_EMPAQUETADA;

	FUNCTION frcGetRcData
	RETURN styLDC_VENTA_EMPAQUETADA;

	FUNCTION frcGetRecord
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN styLDC_VENTA_EMPAQUETADA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VENTA_EMPAQUETADA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VENTA_EMPAQUETADA in styLDC_VENTA_EMPAQUETADA
	);

	PROCEDURE insRecord
	(
		ircLDC_VENTA_EMPAQUETADA in styLDC_VENTA_EMPAQUETADA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VENTA_EMPAQUETADA in out nocopy tytbLDC_VENTA_EMPAQUETADA
	);

	PROCEDURE delRecord
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VENTA_EMPAQUETADA in out nocopy tytbLDC_VENTA_EMPAQUETADA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VENTA_EMPAQUETADA in styLDC_VENTA_EMPAQUETADA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VENTA_EMPAQUETADA in out nocopy tytbLDC_VENTA_EMPAQUETADA,
		inuLock in number default 1
	);

	PROCEDURE updPACKAGE_TYPE_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuPACKAGE_TYPE_ID$ in LDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updGAS_APPLIANC_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		isbGAS_APPLIANC_SALE$ in LDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_FNB_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuPACKAGE_FNB_ID$ in LDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFLAG_GAS_FNB_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		isbFLAG_GAS_FNB_SALE$ in LDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		idtREGISTER_DATE$ in LDC_VENTA_EMPAQUETADA.REGISTER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updREGIST_FNB_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		idtREGIST_FNB_DATE$ in LDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPACKAGE_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type;

	FUNCTION fnuGetPACKAGE_TYPE_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID%type;

	FUNCTION fsbGetGAS_APPLIANC_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetPACKAGE_FNB_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID%type;

	FUNCTION fsbGetFLAG_GAS_FNB_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.REGISTER_DATE%type;

	FUNCTION fdtGetREGIST_FNB_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE%type;


	PROCEDURE LockByPk
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		orcLDC_VENTA_EMPAQUETADA  out styLDC_VENTA_EMPAQUETADA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VENTA_EMPAQUETADA  out styLDC_VENTA_EMPAQUETADA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VENTA_EMPAQUETADA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_VENTA_EMPAQUETADA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VENTA_EMPAQUETADA';
	 cnuGeEntityId constant varchar2(30) := 1686; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	IS
		SELECT LDC_VENTA_EMPAQUETADA.*,LDC_VENTA_EMPAQUETADA.rowid
		FROM LDC_VENTA_EMPAQUETADA
		WHERE  PACKAGE_ID = inuPACKAGE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VENTA_EMPAQUETADA.*,LDC_VENTA_EMPAQUETADA.rowid
		FROM LDC_VENTA_EMPAQUETADA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VENTA_EMPAQUETADA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VENTA_EMPAQUETADA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VENTA_EMPAQUETADA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PACKAGE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		orcLDC_VENTA_EMPAQUETADA  out styLDC_VENTA_EMPAQUETADA
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;

		Open cuLockRcByPk
		(
			inuPACKAGE_ID
		);

		fetch cuLockRcByPk into orcLDC_VENTA_EMPAQUETADA;
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
		orcLDC_VENTA_EMPAQUETADA  out styLDC_VENTA_EMPAQUETADA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VENTA_EMPAQUETADA;
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
		itbLDC_VENTA_EMPAQUETADA  in out nocopy tytbLDC_VENTA_EMPAQUETADA
	)
	IS
	BEGIN
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.PACKAGE_TYPE_ID.delete;
			rcRecOfTab.GAS_APPLIANC_SALE.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.PACKAGE_FNB_ID.delete;
			rcRecOfTab.FLAG_GAS_FNB_SALE.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.REGIST_FNB_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VENTA_EMPAQUETADA  in out nocopy tytbLDC_VENTA_EMPAQUETADA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VENTA_EMPAQUETADA);

		for n in itbLDC_VENTA_EMPAQUETADA.first .. itbLDC_VENTA_EMPAQUETADA.last loop
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_VENTA_EMPAQUETADA(n).PACKAGE_ID;
			rcRecOfTab.PACKAGE_TYPE_ID(n) := itbLDC_VENTA_EMPAQUETADA(n).PACKAGE_TYPE_ID;
			rcRecOfTab.GAS_APPLIANC_SALE(n) := itbLDC_VENTA_EMPAQUETADA(n).GAS_APPLIANC_SALE;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLDC_VENTA_EMPAQUETADA(n).SUBSCRIPTION_ID;
			rcRecOfTab.PACKAGE_FNB_ID(n) := itbLDC_VENTA_EMPAQUETADA(n).PACKAGE_FNB_ID;
			rcRecOfTab.FLAG_GAS_FNB_SALE(n) := itbLDC_VENTA_EMPAQUETADA(n).FLAG_GAS_FNB_SALE;
			rcRecOfTab.REGISTER_DATE(n) := itbLDC_VENTA_EMPAQUETADA(n).REGISTER_DATE;
			rcRecOfTab.REGIST_FNB_DATE(n) := itbLDC_VENTA_EMPAQUETADA(n).REGIST_FNB_DATE;
			rcRecOfTab.row_id(n) := itbLDC_VENTA_EMPAQUETADA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPACKAGE_ID
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
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPACKAGE_ID = rcData.PACKAGE_ID
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
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPACKAGE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN		rcError.PACKAGE_ID:=inuPACKAGE_ID;

		Load
		(
			inuPACKAGE_ID
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
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPACKAGE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		orcRecord out nocopy styLDC_VENTA_EMPAQUETADA
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN		rcError.PACKAGE_ID:=inuPACKAGE_ID;

		Load
		(
			inuPACKAGE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN styLDC_VENTA_EMPAQUETADA
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID:=inuPACKAGE_ID;

		Load
		(
			inuPACKAGE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	)
	RETURN styLDC_VENTA_EMPAQUETADA
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID:=inuPACKAGE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPACKAGE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPACKAGE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VENTA_EMPAQUETADA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VENTA_EMPAQUETADA
	)
	IS
		rfLDC_VENTA_EMPAQUETADA tyrfLDC_VENTA_EMPAQUETADA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VENTA_EMPAQUETADA.*, LDC_VENTA_EMPAQUETADA.rowid FROM LDC_VENTA_EMPAQUETADA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VENTA_EMPAQUETADA for sbFullQuery;

		fetch rfLDC_VENTA_EMPAQUETADA bulk collect INTO otbResult;

		close rfLDC_VENTA_EMPAQUETADA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VENTA_EMPAQUETADA.*, LDC_VENTA_EMPAQUETADA.rowid FROM LDC_VENTA_EMPAQUETADA';
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
		ircLDC_VENTA_EMPAQUETADA in styLDC_VENTA_EMPAQUETADA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VENTA_EMPAQUETADA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VENTA_EMPAQUETADA in styLDC_VENTA_EMPAQUETADA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VENTA_EMPAQUETADA.PACKAGE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PACKAGE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_VENTA_EMPAQUETADA
		(
			PACKAGE_ID,
			PACKAGE_TYPE_ID,
			GAS_APPLIANC_SALE,
			SUBSCRIPTION_ID,
			PACKAGE_FNB_ID,
			FLAG_GAS_FNB_SALE,
			REGISTER_DATE,
			REGIST_FNB_DATE
		)
		values
		(
			ircLDC_VENTA_EMPAQUETADA.PACKAGE_ID,
			ircLDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID,
			ircLDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE,
			ircLDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID,
			ircLDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID,
			ircLDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE,
			ircLDC_VENTA_EMPAQUETADA.REGISTER_DATE,
			ircLDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VENTA_EMPAQUETADA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VENTA_EMPAQUETADA in out nocopy tytbLDC_VENTA_EMPAQUETADA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VENTA_EMPAQUETADA,blUseRowID);
		forall n in iotbLDC_VENTA_EMPAQUETADA.first..iotbLDC_VENTA_EMPAQUETADA.last
			insert into LDC_VENTA_EMPAQUETADA
			(
				PACKAGE_ID,
				PACKAGE_TYPE_ID,
				GAS_APPLIANC_SALE,
				SUBSCRIPTION_ID,
				PACKAGE_FNB_ID,
				FLAG_GAS_FNB_SALE,
				REGISTER_DATE,
				REGIST_FNB_DATE
			)
			values
			(
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.PACKAGE_TYPE_ID(n),
				rcRecOfTab.GAS_APPLIANC_SALE(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.PACKAGE_FNB_ID(n),
				rcRecOfTab.FLAG_GAS_FNB_SALE(n),
				rcRecOfTab.REGISTER_DATE(n),
				rcRecOfTab.REGIST_FNB_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;


		delete
		from LDC_VENTA_EMPAQUETADA
		where
       		PACKAGE_ID=inuPACKAGE_ID;
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
		rcError  styLDC_VENTA_EMPAQUETADA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VENTA_EMPAQUETADA
		where
			rowid = iriRowID
		returning
			PACKAGE_ID
		into
			rcError.PACKAGE_ID;
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
		iotbLDC_VENTA_EMPAQUETADA in out nocopy tytbLDC_VENTA_EMPAQUETADA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VENTA_EMPAQUETADA;
	BEGIN
		FillRecordOfTables(iotbLDC_VENTA_EMPAQUETADA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last
				delete
				from LDC_VENTA_EMPAQUETADA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last loop
					LockByPk
					(
						rcRecOfTab.PACKAGE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last
				delete
				from LDC_VENTA_EMPAQUETADA
				where
		         	PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VENTA_EMPAQUETADA in styLDC_VENTA_EMPAQUETADA,
		inuLock in number default 0
	)
	IS
		nuPACKAGE_ID	LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type;
	BEGIN
		if ircLDC_VENTA_EMPAQUETADA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VENTA_EMPAQUETADA.rowid,rcData);
			end if;
			update LDC_VENTA_EMPAQUETADA
			set
				PACKAGE_TYPE_ID = ircLDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID,
				GAS_APPLIANC_SALE = ircLDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE,
				SUBSCRIPTION_ID = ircLDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID,
				PACKAGE_FNB_ID = ircLDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID,
				FLAG_GAS_FNB_SALE = ircLDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE,
				REGISTER_DATE = ircLDC_VENTA_EMPAQUETADA.REGISTER_DATE,
				REGIST_FNB_DATE = ircLDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE
			where
				rowid = ircLDC_VENTA_EMPAQUETADA.rowid
			returning
				PACKAGE_ID
			into
				nuPACKAGE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VENTA_EMPAQUETADA.PACKAGE_ID,
					rcData
				);
			end if;

			update LDC_VENTA_EMPAQUETADA
			set
				PACKAGE_TYPE_ID = ircLDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID,
				GAS_APPLIANC_SALE = ircLDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE,
				SUBSCRIPTION_ID = ircLDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID,
				PACKAGE_FNB_ID = ircLDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID,
				FLAG_GAS_FNB_SALE = ircLDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE,
				REGISTER_DATE = ircLDC_VENTA_EMPAQUETADA.REGISTER_DATE,
				REGIST_FNB_DATE = ircLDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE
			where
				PACKAGE_ID = ircLDC_VENTA_EMPAQUETADA.PACKAGE_ID
			returning
				PACKAGE_ID
			into
				nuPACKAGE_ID;
		end if;
		if
			nuPACKAGE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VENTA_EMPAQUETADA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VENTA_EMPAQUETADA in out nocopy tytbLDC_VENTA_EMPAQUETADA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VENTA_EMPAQUETADA;
	BEGIN
		FillRecordOfTables(iotbLDC_VENTA_EMPAQUETADA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last
				update LDC_VENTA_EMPAQUETADA
				set
					PACKAGE_TYPE_ID = rcRecOfTab.PACKAGE_TYPE_ID(n),
					GAS_APPLIANC_SALE = rcRecOfTab.GAS_APPLIANC_SALE(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					PACKAGE_FNB_ID = rcRecOfTab.PACKAGE_FNB_ID(n),
					FLAG_GAS_FNB_SALE = rcRecOfTab.FLAG_GAS_FNB_SALE(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					REGIST_FNB_DATE = rcRecOfTab.REGIST_FNB_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last loop
					LockByPk
					(
						rcRecOfTab.PACKAGE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_EMPAQUETADA.first .. iotbLDC_VENTA_EMPAQUETADA.last
				update LDC_VENTA_EMPAQUETADA
				SET
					PACKAGE_TYPE_ID = rcRecOfTab.PACKAGE_TYPE_ID(n),
					GAS_APPLIANC_SALE = rcRecOfTab.GAS_APPLIANC_SALE(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					PACKAGE_FNB_ID = rcRecOfTab.PACKAGE_FNB_ID(n),
					FLAG_GAS_FNB_SALE = rcRecOfTab.FLAG_GAS_FNB_SALE(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					REGIST_FNB_DATE = rcRecOfTab.REGIST_FNB_DATE(n)
				where
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n)
;
		end if;
	END;
	PROCEDURE updPACKAGE_TYPE_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuPACKAGE_TYPE_ID$ in LDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			PACKAGE_TYPE_ID = inuPACKAGE_TYPE_ID$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_TYPE_ID:= inuPACKAGE_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGAS_APPLIANC_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		isbGAS_APPLIANC_SALE$ in LDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			GAS_APPLIANC_SALE = isbGAS_APPLIANC_SALE$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GAS_APPLIANC_SALE:= isbGAS_APPLIANC_SALE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_FNB_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuPACKAGE_FNB_ID$ in LDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			PACKAGE_FNB_ID = inuPACKAGE_FNB_ID$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_FNB_ID:= inuPACKAGE_FNB_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFLAG_GAS_FNB_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		isbFLAG_GAS_FNB_SALE$ in LDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			FLAG_GAS_FNB_SALE = isbFLAG_GAS_FNB_SALE$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAG_GAS_FNB_SALE:= isbFLAG_GAS_FNB_SALE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		idtREGISTER_DATE$ in LDC_VENTA_EMPAQUETADA.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGIST_FNB_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		idtREGIST_FNB_DATE$ in LDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_VENTA_EMPAQUETADA
		set
			REGIST_FNB_DATE = idtREGIST_FNB_DATE$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGIST_FNB_DATE:= idtREGIST_FNB_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuPACKAGE_ID
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
	FUNCTION fnuGetPACKAGE_TYPE_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.PACKAGE_TYPE_ID%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.PACKAGE_TYPE_ID);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.PACKAGE_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetGAS_APPLIANC_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.GAS_APPLIANC_SALE%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.GAS_APPLIANC_SALE);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.GAS_APPLIANC_SALE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.SUBSCRIPTION_ID%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_FNB_ID
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.PACKAGE_FNB_ID%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.PACKAGE_FNB_ID);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.PACKAGE_FNB_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFLAG_GAS_FNB_SALE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.FLAG_GAS_FNB_SALE%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.FLAG_GAS_FNB_SALE);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.FLAG_GAS_FNB_SALE);
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
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.REGISTER_DATE%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuPACKAGE_ID
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
	FUNCTION fdtGetREGIST_FNB_DATE
	(
		inuPACKAGE_ID in LDC_VENTA_EMPAQUETADA.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_EMPAQUETADA.REGIST_FNB_DATE%type
	IS
		rcError styLDC_VENTA_EMPAQUETADA;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.REGIST_FNB_DATE);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.REGIST_FNB_DATE);
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
end DALDC_VENTA_EMPAQUETADA;
/
PROMPT Otorgando permisos de ejecucion a DALDC_VENTA_EMPAQUETADA
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_VENTA_EMPAQUETADA', 'ADM_PERSON');
END;
/