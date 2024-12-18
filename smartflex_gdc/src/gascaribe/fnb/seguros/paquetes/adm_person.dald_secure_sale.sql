CREATE OR REPLACE PACKAGE adm_person.DALD_SECURE_SALE
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	IS
		SELECT LD_SECURE_SALE.*,LD_SECURE_SALE.rowid
		FROM LD_SECURE_SALE
		WHERE
		    SECURE_SALE_ID = inuSECURE_SALE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_SECURE_SALE.*,LD_SECURE_SALE.rowid
		FROM LD_SECURE_SALE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_SECURE_SALE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_SECURE_SALE is table of styLD_SECURE_SALE index by binary_integer;
	type tyrfRecords is ref cursor return styLD_SECURE_SALE;

	/* Tipos referenciando al registro */
	type tytbCOLLECTIVE_NUMBER is table of LD_SECURE_SALE.COLLECTIVE_NUMBER%type index by binary_integer;
	type tytbCAUSAL_ID is table of LD_SECURE_SALE.CAUSAL_ID%type index by binary_integer;
	type tytbSECURE_SALE_ID is table of LD_SECURE_SALE.SECURE_SALE_ID%type index by binary_integer;
	type tytbID_CONTRATISTA is table of LD_SECURE_SALE.ID_CONTRATISTA%type index by binary_integer;
	type tytbPRODUCT_LINE_ID is table of LD_SECURE_SALE.PRODUCT_LINE_ID%type index by binary_integer;
	type tytbBORN_DATE is table of LD_SECURE_SALE.BORN_DATE%type index by binary_integer;
	type tytbPOLICY_TYPE_ID is table of LD_SECURE_SALE.POLICY_TYPE_ID%type index by binary_integer;
	type tytbPOLICY_NUMBER is table of LD_SECURE_SALE.POLICY_NUMBER%type index by binary_integer;
	type tytbPOLICY_VALUE is table of LD_SECURE_SALE.POLICY_VALUE%type index by binary_integer;
	type tytbIDENTIFICATION_ID is table of LD_SECURE_SALE.IDENTIFICATION_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_SECURE_SALE is record
	(
		COLLECTIVE_NUMBER   tytbCOLLECTIVE_NUMBER,
		CAUSAL_ID   tytbCAUSAL_ID,
		SECURE_SALE_ID   tytbSECURE_SALE_ID,
		ID_CONTRATISTA   tytbID_CONTRATISTA,
		PRODUCT_LINE_ID   tytbPRODUCT_LINE_ID,
		BORN_DATE   tytbBORN_DATE,
		POLICY_TYPE_ID   tytbPOLICY_TYPE_ID,
		POLICY_NUMBER   tytbPOLICY_NUMBER,
		POLICY_VALUE   tytbPOLICY_VALUE,
		IDENTIFICATION_ID   tytbIDENTIFICATION_ID,
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
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	);

	PROCEDURE getRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		orcRecord out nocopy styLD_SECURE_SALE
	);

	FUNCTION frcGetRcData
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN styLD_SECURE_SALE;

	FUNCTION frcGetRcData
	RETURN styLD_SECURE_SALE;

	FUNCTION frcGetRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN styLD_SECURE_SALE;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SECURE_SALE
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_SECURE_SALE in styLD_SECURE_SALE
	);

	PROCEDURE insRecord
	(
		ircLD_SECURE_SALE in styLD_SECURE_SALE,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_SECURE_SALE in out nocopy tytbLD_SECURE_SALE
	);

	PROCEDURE delRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_SECURE_SALE in out nocopy tytbLD_SECURE_SALE,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_SECURE_SALE in styLD_SECURE_SALE,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_SECURE_SALE in out nocopy tytbLD_SECURE_SALE,
		inuLock in number default 1
	);

	PROCEDURE updCOLLECTIVE_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuCOLLECTIVE_NUMBER$ in LD_SECURE_SALE.COLLECTIVE_NUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		isbCAUSAL_ID$ in LD_SECURE_SALE.CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updID_CONTRATISTA
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuID_CONTRATISTA$ in LD_SECURE_SALE.ID_CONTRATISTA%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_LINE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPRODUCT_LINE_ID$ in LD_SECURE_SALE.PRODUCT_LINE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBORN_DATE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		idtBORN_DATE$ in LD_SECURE_SALE.BORN_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_TYPE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPOLICY_TYPE_ID$ in LD_SECURE_SALE.POLICY_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPOLICY_NUMBER$ in LD_SECURE_SALE.POLICY_NUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_VALUE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPOLICY_VALUE$ in LD_SECURE_SALE.POLICY_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENTIFICATION_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuIDENTIFICATION_ID$ in LD_SECURE_SALE.IDENTIFICATION_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOLLECTIVE_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.COLLECTIVE_NUMBER%type;

	FUNCTION fsbGetCAUSAL_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.CAUSAL_ID%type;

	FUNCTION fnuGetSECURE_SALE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.SECURE_SALE_ID%type;

	FUNCTION fnuGetID_CONTRATISTA
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.ID_CONTRATISTA%type;

	FUNCTION fnuGetPRODUCT_LINE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.PRODUCT_LINE_ID%type;

	FUNCTION fdtGetBORN_DATE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.BORN_DATE%type;

	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.POLICY_TYPE_ID%type;

	FUNCTION fnuGetPOLICY_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.POLICY_NUMBER%type;

	FUNCTION fnuGetPOLICY_VALUE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.POLICY_VALUE%type;

	FUNCTION fnuGetIDENTIFICATION_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.IDENTIFICATION_ID%type;


	PROCEDURE LockByPk
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		orcLD_SECURE_SALE  out styLD_SECURE_SALE
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_SECURE_SALE  out styLD_SECURE_SALE
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_SECURE_SALE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_SECURE_SALE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SECURE_SALE';
	 cnuGeEntityId constant varchar2(30) := 8006; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	IS
		SELECT LD_SECURE_SALE.*,LD_SECURE_SALE.rowid
		FROM LD_SECURE_SALE
		WHERE  SECURE_SALE_ID = inuSECURE_SALE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_SECURE_SALE.*,LD_SECURE_SALE.rowid
		FROM LD_SECURE_SALE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_SECURE_SALE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_SECURE_SALE;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_SECURE_SALE default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SECURE_SALE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		orcLD_SECURE_SALE  out styLD_SECURE_SALE
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

		Open cuLockRcByPk
		(
			inuSECURE_SALE_ID
		);

		fetch cuLockRcByPk into orcLD_SECURE_SALE;
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
		orcLD_SECURE_SALE  out styLD_SECURE_SALE
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_SECURE_SALE;
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
		itbLD_SECURE_SALE  in out nocopy tytbLD_SECURE_SALE
	)
	IS
	BEGIN
			rcRecOfTab.COLLECTIVE_NUMBER.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.SECURE_SALE_ID.delete;
			rcRecOfTab.ID_CONTRATISTA.delete;
			rcRecOfTab.PRODUCT_LINE_ID.delete;
			rcRecOfTab.BORN_DATE.delete;
			rcRecOfTab.POLICY_TYPE_ID.delete;
			rcRecOfTab.POLICY_NUMBER.delete;
			rcRecOfTab.POLICY_VALUE.delete;
			rcRecOfTab.IDENTIFICATION_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_SECURE_SALE  in out nocopy tytbLD_SECURE_SALE,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_SECURE_SALE);

		for n in itbLD_SECURE_SALE.first .. itbLD_SECURE_SALE.last loop
			rcRecOfTab.COLLECTIVE_NUMBER(n) := itbLD_SECURE_SALE(n).COLLECTIVE_NUMBER;
			rcRecOfTab.CAUSAL_ID(n) := itbLD_SECURE_SALE(n).CAUSAL_ID;
			rcRecOfTab.SECURE_SALE_ID(n) := itbLD_SECURE_SALE(n).SECURE_SALE_ID;
			rcRecOfTab.ID_CONTRATISTA(n) := itbLD_SECURE_SALE(n).ID_CONTRATISTA;
			rcRecOfTab.PRODUCT_LINE_ID(n) := itbLD_SECURE_SALE(n).PRODUCT_LINE_ID;
			rcRecOfTab.BORN_DATE(n) := itbLD_SECURE_SALE(n).BORN_DATE;
			rcRecOfTab.POLICY_TYPE_ID(n) := itbLD_SECURE_SALE(n).POLICY_TYPE_ID;
			rcRecOfTab.POLICY_NUMBER(n) := itbLD_SECURE_SALE(n).POLICY_NUMBER;
			rcRecOfTab.POLICY_VALUE(n) := itbLD_SECURE_SALE(n).POLICY_VALUE;
			rcRecOfTab.IDENTIFICATION_ID(n) := itbLD_SECURE_SALE(n).IDENTIFICATION_ID;
			rcRecOfTab.row_id(n) := itbLD_SECURE_SALE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSECURE_SALE_ID
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
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSECURE_SALE_ID = rcData.SECURE_SALE_ID
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
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSECURE_SALE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN		rcError.SECURE_SALE_ID:=inuSECURE_SALE_ID;

		Load
		(
			inuSECURE_SALE_ID
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
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuSECURE_SALE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		orcRecord out nocopy styLD_SECURE_SALE
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN		rcError.SECURE_SALE_ID:=inuSECURE_SALE_ID;

		Load
		(
			inuSECURE_SALE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN styLD_SECURE_SALE
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID:=inuSECURE_SALE_ID;

		Load
		(
			inuSECURE_SALE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type
	)
	RETURN styLD_SECURE_SALE
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID:=inuSECURE_SALE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSECURE_SALE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSECURE_SALE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_SECURE_SALE
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SECURE_SALE
	)
	IS
		rfLD_SECURE_SALE tyrfLD_SECURE_SALE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_SECURE_SALE.*, LD_SECURE_SALE.rowid FROM LD_SECURE_SALE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_SECURE_SALE for sbFullQuery;

		fetch rfLD_SECURE_SALE bulk collect INTO otbResult;

		close rfLD_SECURE_SALE;
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
		sbSQL VARCHAR2 (32000) := 'select LD_SECURE_SALE.*, LD_SECURE_SALE.rowid FROM LD_SECURE_SALE';
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
		ircLD_SECURE_SALE in styLD_SECURE_SALE
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_SECURE_SALE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_SECURE_SALE in styLD_SECURE_SALE,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_SECURE_SALE.SECURE_SALE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SECURE_SALE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_SECURE_SALE
		(
			COLLECTIVE_NUMBER,
			CAUSAL_ID,
			SECURE_SALE_ID,
			ID_CONTRATISTA,
			PRODUCT_LINE_ID,
			BORN_DATE,
			POLICY_TYPE_ID,
			POLICY_NUMBER,
			POLICY_VALUE,
			IDENTIFICATION_ID
		)
		values
		(
			ircLD_SECURE_SALE.COLLECTIVE_NUMBER,
			ircLD_SECURE_SALE.CAUSAL_ID,
			ircLD_SECURE_SALE.SECURE_SALE_ID,
			ircLD_SECURE_SALE.ID_CONTRATISTA,
			ircLD_SECURE_SALE.PRODUCT_LINE_ID,
			ircLD_SECURE_SALE.BORN_DATE,
			ircLD_SECURE_SALE.POLICY_TYPE_ID,
			ircLD_SECURE_SALE.POLICY_NUMBER,
			ircLD_SECURE_SALE.POLICY_VALUE,
			ircLD_SECURE_SALE.IDENTIFICATION_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_SECURE_SALE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_SECURE_SALE in out nocopy tytbLD_SECURE_SALE
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_SECURE_SALE,blUseRowID);
		forall n in iotbLD_SECURE_SALE.first..iotbLD_SECURE_SALE.last
			insert into LD_SECURE_SALE
			(
				COLLECTIVE_NUMBER,
				CAUSAL_ID,
				SECURE_SALE_ID,
				ID_CONTRATISTA,
				PRODUCT_LINE_ID,
				BORN_DATE,
				POLICY_TYPE_ID,
				POLICY_NUMBER,
				POLICY_VALUE,
				IDENTIFICATION_ID
			)
			values
			(
				rcRecOfTab.COLLECTIVE_NUMBER(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.SECURE_SALE_ID(n),
				rcRecOfTab.ID_CONTRATISTA(n),
				rcRecOfTab.PRODUCT_LINE_ID(n),
				rcRecOfTab.BORN_DATE(n),
				rcRecOfTab.POLICY_TYPE_ID(n),
				rcRecOfTab.POLICY_NUMBER(n),
				rcRecOfTab.POLICY_VALUE(n),
				rcRecOfTab.IDENTIFICATION_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;


		delete
		from LD_SECURE_SALE
		where
       		SECURE_SALE_ID=inuSECURE_SALE_ID;
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
		rcError  styLD_SECURE_SALE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_SECURE_SALE
		where
			rowid = iriRowID
		returning
			COLLECTIVE_NUMBER
		into
			rcError.COLLECTIVE_NUMBER;
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
		iotbLD_SECURE_SALE in out nocopy tytbLD_SECURE_SALE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SECURE_SALE;
	BEGIN
		FillRecordOfTables(iotbLD_SECURE_SALE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last
				delete
				from LD_SECURE_SALE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last loop
					LockByPk
					(
						rcRecOfTab.SECURE_SALE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last
				delete
				from LD_SECURE_SALE
				where
		         	SECURE_SALE_ID = rcRecOfTab.SECURE_SALE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_SECURE_SALE in styLD_SECURE_SALE,
		inuLock in number default 0
	)
	IS
		nuSECURE_SALE_ID	LD_SECURE_SALE.SECURE_SALE_ID%type;
	BEGIN
		if ircLD_SECURE_SALE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_SECURE_SALE.rowid,rcData);
			end if;
			update LD_SECURE_SALE
			set
				COLLECTIVE_NUMBER = ircLD_SECURE_SALE.COLLECTIVE_NUMBER,
				CAUSAL_ID = ircLD_SECURE_SALE.CAUSAL_ID,
				ID_CONTRATISTA = ircLD_SECURE_SALE.ID_CONTRATISTA,
				PRODUCT_LINE_ID = ircLD_SECURE_SALE.PRODUCT_LINE_ID,
				BORN_DATE = ircLD_SECURE_SALE.BORN_DATE,
				POLICY_TYPE_ID = ircLD_SECURE_SALE.POLICY_TYPE_ID,
				POLICY_NUMBER = ircLD_SECURE_SALE.POLICY_NUMBER,
				POLICY_VALUE = ircLD_SECURE_SALE.POLICY_VALUE,
				IDENTIFICATION_ID = ircLD_SECURE_SALE.IDENTIFICATION_ID
			where
				rowid = ircLD_SECURE_SALE.rowid
			returning
				SECURE_SALE_ID
			into
				nuSECURE_SALE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_SECURE_SALE.SECURE_SALE_ID,
					rcData
				);
			end if;

			update LD_SECURE_SALE
			set
				COLLECTIVE_NUMBER = ircLD_SECURE_SALE.COLLECTIVE_NUMBER,
				CAUSAL_ID = ircLD_SECURE_SALE.CAUSAL_ID,
				ID_CONTRATISTA = ircLD_SECURE_SALE.ID_CONTRATISTA,
				PRODUCT_LINE_ID = ircLD_SECURE_SALE.PRODUCT_LINE_ID,
				BORN_DATE = ircLD_SECURE_SALE.BORN_DATE,
				POLICY_TYPE_ID = ircLD_SECURE_SALE.POLICY_TYPE_ID,
				POLICY_NUMBER = ircLD_SECURE_SALE.POLICY_NUMBER,
				POLICY_VALUE = ircLD_SECURE_SALE.POLICY_VALUE,
				IDENTIFICATION_ID = ircLD_SECURE_SALE.IDENTIFICATION_ID
			where
				SECURE_SALE_ID = ircLD_SECURE_SALE.SECURE_SALE_ID
			returning
				SECURE_SALE_ID
			into
				nuSECURE_SALE_ID;
		end if;
		if
			nuSECURE_SALE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_SECURE_SALE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_SECURE_SALE in out nocopy tytbLD_SECURE_SALE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SECURE_SALE;
	BEGIN
		FillRecordOfTables(iotbLD_SECURE_SALE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last
				update LD_SECURE_SALE
				set
					COLLECTIVE_NUMBER = rcRecOfTab.COLLECTIVE_NUMBER(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					ID_CONTRATISTA = rcRecOfTab.ID_CONTRATISTA(n),
					PRODUCT_LINE_ID = rcRecOfTab.PRODUCT_LINE_ID(n),
					BORN_DATE = rcRecOfTab.BORN_DATE(n),
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n),
					POLICY_NUMBER = rcRecOfTab.POLICY_NUMBER(n),
					POLICY_VALUE = rcRecOfTab.POLICY_VALUE(n),
					IDENTIFICATION_ID = rcRecOfTab.IDENTIFICATION_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last loop
					LockByPk
					(
						rcRecOfTab.SECURE_SALE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SECURE_SALE.first .. iotbLD_SECURE_SALE.last
				update LD_SECURE_SALE
				SET
					COLLECTIVE_NUMBER = rcRecOfTab.COLLECTIVE_NUMBER(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					ID_CONTRATISTA = rcRecOfTab.ID_CONTRATISTA(n),
					PRODUCT_LINE_ID = rcRecOfTab.PRODUCT_LINE_ID(n),
					BORN_DATE = rcRecOfTab.BORN_DATE(n),
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n),
					POLICY_NUMBER = rcRecOfTab.POLICY_NUMBER(n),
					POLICY_VALUE = rcRecOfTab.POLICY_VALUE(n),
					IDENTIFICATION_ID = rcRecOfTab.IDENTIFICATION_ID(n)
				where
					SECURE_SALE_ID = rcRecOfTab.SECURE_SALE_ID(n)
;
		end if;
	END;
	PROCEDURE updCOLLECTIVE_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuCOLLECTIVE_NUMBER$ in LD_SECURE_SALE.COLLECTIVE_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			COLLECTIVE_NUMBER = inuCOLLECTIVE_NUMBER$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COLLECTIVE_NUMBER:= inuCOLLECTIVE_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		isbCAUSAL_ID$ in LD_SECURE_SALE.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			CAUSAL_ID = isbCAUSAL_ID$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= isbCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_CONTRATISTA
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuID_CONTRATISTA$ in LD_SECURE_SALE.ID_CONTRATISTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			ID_CONTRATISTA = inuID_CONTRATISTA$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_CONTRATISTA:= inuID_CONTRATISTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_LINE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPRODUCT_LINE_ID$ in LD_SECURE_SALE.PRODUCT_LINE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			PRODUCT_LINE_ID = inuPRODUCT_LINE_ID$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_LINE_ID:= inuPRODUCT_LINE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBORN_DATE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		idtBORN_DATE$ in LD_SECURE_SALE.BORN_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			BORN_DATE = idtBORN_DATE$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BORN_DATE:= idtBORN_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_TYPE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPOLICY_TYPE_ID$ in LD_SECURE_SALE.POLICY_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_TYPE_ID:= inuPOLICY_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPOLICY_NUMBER$ in LD_SECURE_SALE.POLICY_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			POLICY_NUMBER = inuPOLICY_NUMBER$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_NUMBER:= inuPOLICY_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_VALUE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuPOLICY_VALUE$ in LD_SECURE_SALE.POLICY_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			POLICY_VALUE = inuPOLICY_VALUE$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_VALUE:= inuPOLICY_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENTIFICATION_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuIDENTIFICATION_ID$ in LD_SECURE_SALE.IDENTIFICATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SECURE_SALE;
	BEGIN
		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSECURE_SALE_ID,
				rcData
			);
		end if;

		update LD_SECURE_SALE
		set
			IDENTIFICATION_ID = inuIDENTIFICATION_ID$
		where
			SECURE_SALE_ID = inuSECURE_SALE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENTIFICATION_ID:= inuIDENTIFICATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOLLECTIVE_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.COLLECTIVE_NUMBER%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.COLLECTIVE_NUMBER);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.COLLECTIVE_NUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCAUSAL_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.CAUSAL_ID%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.CAUSAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSECURE_SALE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.SECURE_SALE_ID%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.SECURE_SALE_ID);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.SECURE_SALE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_CONTRATISTA
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.ID_CONTRATISTA%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.ID_CONTRATISTA);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.ID_CONTRATISTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRODUCT_LINE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.PRODUCT_LINE_ID%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.PRODUCT_LINE_ID);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.PRODUCT_LINE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetBORN_DATE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.BORN_DATE%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.BORN_DATE);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.BORN_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.POLICY_TYPE_ID%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.POLICY_TYPE_ID);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.POLICY_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_NUMBER
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.POLICY_NUMBER%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.POLICY_NUMBER);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.POLICY_NUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_VALUE
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.POLICY_VALUE%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.POLICY_VALUE);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.POLICY_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDENTIFICATION_ID
	(
		inuSECURE_SALE_ID in LD_SECURE_SALE.SECURE_SALE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SECURE_SALE.IDENTIFICATION_ID%type
	IS
		rcError styLD_SECURE_SALE;
	BEGIN

		rcError.SECURE_SALE_ID := inuSECURE_SALE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSECURE_SALE_ID
			 )
		then
			 return(rcData.IDENTIFICATION_ID);
		end if;
		Load
		(
		 		inuSECURE_SALE_ID
		);
		return(rcData.IDENTIFICATION_ID);
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
end DALD_SECURE_SALE;
/
PROMPT Otorgando permisos de ejecucion a DALD_SECURE_SALE
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SECURE_SALE', 'ADM_PERSON');
END;
/