CREATE OR REPLACE PACKAGE adm_person.dald_return_item_detail
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	IS
		SELECT LD_RETURN_ITEM_DETAIL.*,LD_RETURN_ITEM_DETAIL.rowid
		FROM LD_RETURN_ITEM_DETAIL
		WHERE
		    RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_RETURN_ITEM_DETAIL.*,LD_RETURN_ITEM_DETAIL.rowid
		FROM LD_RETURN_ITEM_DETAIL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_RETURN_ITEM_DETAIL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_RETURN_ITEM_DETAIL is table of styLD_RETURN_ITEM_DETAIL index by binary_integer;
	type tyrfRecords is ref cursor return styLD_RETURN_ITEM_DETAIL;

	/* Tipos referenciando al registro */
	type tytbACTIVITY_DELIVERY_ID is table of LD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID%type index by binary_integer;
	type tytbORDER_ACTIVITY_ID is table of LD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID%type index by binary_integer;
	type tytbRETURN_ITEM_DETAIL_ID is table of LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type index by binary_integer;
	type tytbRETURN_ITEM_ID is table of LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type index by binary_integer;
	type tytbORDER_ID is table of LD_RETURN_ITEM_DETAIL.ORDER_ID%type index by binary_integer;
	type tytbARTICLE_ID is table of LD_RETURN_ITEM_DETAIL.ARTICLE_ID%type index by binary_integer;
	type tytbCAUSAL_ID is table of LD_RETURN_ITEM_DETAIL.CAUSAL_ID%type index by binary_integer;
	type tytbAMOUNT is table of LD_RETURN_ITEM_DETAIL.AMOUNT%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_RETURN_ITEM_DETAIL is record
	(
		ACTIVITY_DELIVERY_ID   tytbACTIVITY_DELIVERY_ID,
		ORDER_ACTIVITY_ID   tytbORDER_ACTIVITY_ID,
		RETURN_ITEM_DETAIL_ID   tytbRETURN_ITEM_DETAIL_ID,
		RETURN_ITEM_ID   tytbRETURN_ITEM_ID,
		ORDER_ID   tytbORDER_ID,
		ARTICLE_ID   tytbARTICLE_ID,
		CAUSAL_ID   tytbCAUSAL_ID,
		AMOUNT   tytbAMOUNT,
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
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	);

	PROCEDURE getRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		orcRecord out nocopy styLD_RETURN_ITEM_DETAIL
	);

	FUNCTION frcGetRcData
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN styLD_RETURN_ITEM_DETAIL;

	FUNCTION frcGetRcData
	RETURN styLD_RETURN_ITEM_DETAIL;

	FUNCTION frcGetRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN styLD_RETURN_ITEM_DETAIL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_RETURN_ITEM_DETAIL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_RETURN_ITEM_DETAIL in styLD_RETURN_ITEM_DETAIL
	);

	PROCEDURE insRecord
	(
		ircLD_RETURN_ITEM_DETAIL in styLD_RETURN_ITEM_DETAIL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_RETURN_ITEM_DETAIL in out nocopy tytbLD_RETURN_ITEM_DETAIL
	);


PROCEDURE delRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_RETURN_ITEM_DETAIL in out nocopy tytbLD_RETURN_ITEM_DETAIL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_RETURN_ITEM_DETAIL in styLD_RETURN_ITEM_DETAIL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_RETURN_ITEM_DETAIL in out nocopy tytbLD_RETURN_ITEM_DETAIL,
		inuLock in number default 1
	);

	PROCEDURE updACTIVITY_DELIVERY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuACTIVITY_DELIVERY_ID$ in LD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ACTIVITY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuORDER_ACTIVITY_ID$ in LD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updRETURN_ITEM_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRETURN_ITEM_ID$ in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuORDER_ID$ in LD_RETURN_ITEM_DETAIL.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updARTICLE_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuARTICLE_ID$ in LD_RETURN_ITEM_DETAIL.ARTICLE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuCAUSAL_ID$ in LD_RETURN_ITEM_DETAIL.CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updAMOUNT
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuAMOUNT$ in LD_RETURN_ITEM_DETAIL.AMOUNT%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetACTIVITY_DELIVERY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID%type;

	FUNCTION fnuGetORDER_ACTIVITY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID%type;

	FUNCTION fnuGetRETURN_ITEM_DETAIL_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type;

	FUNCTION fnuGetRETURN_ITEM_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type;

	FUNCTION fnuGetORDER_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ORDER_ID%type;

	FUNCTION fnuGetARTICLE_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ARTICLE_ID%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.CAUSAL_ID%type;

	FUNCTION fnuGetAMOUNT
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.AMOUNT%type;


	PROCEDURE LockByPk
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		orcLD_RETURN_ITEM_DETAIL  out styLD_RETURN_ITEM_DETAIL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_RETURN_ITEM_DETAIL  out styLD_RETURN_ITEM_DETAIL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache  in  boolean
	);
END DALD_RETURN_ITEM_DETAIL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_RETURN_ITEM_DETAIL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;

  cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO8234';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) :=  'LD_RETURN_ITEM_DETAIL';
	 cnuGeEntityId constant varchar2(30) := 8234; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	IS
		SELECT LD_RETURN_ITEM_DETAIL.*,LD_RETURN_ITEM_DETAIL.rowid
		FROM LD_RETURN_ITEM_DETAIL
		WHERE  RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_RETURN_ITEM_DETAIL.*,LD_RETURN_ITEM_DETAIL.rowid
		FROM LD_RETURN_ITEM_DETAIL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_RETURN_ITEM_DETAIL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_RETURN_ITEM_DETAIL;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_RETURN_ITEM_DETAIL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RETURN_ITEM_DETAIL_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		orcLD_RETURN_ITEM_DETAIL  out styLD_RETURN_ITEM_DETAIL
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

		Open cuLockRcByPk
		(
			inuRETURN_ITEM_DETAIL_ID
		);

		fetch cuLockRcByPk into orcLD_RETURN_ITEM_DETAIL;
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
		orcLD_RETURN_ITEM_DETAIL  out styLD_RETURN_ITEM_DETAIL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_RETURN_ITEM_DETAIL;
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
		itbLD_RETURN_ITEM_DETAIL  in out nocopy tytbLD_RETURN_ITEM_DETAIL
	)
	IS

	BEGIN
			rcRecOfTab.ACTIVITY_DELIVERY_ID.delete;
			rcRecOfTab.ORDER_ACTIVITY_ID.delete;
			rcRecOfTab.RETURN_ITEM_DETAIL_ID.delete;
			rcRecOfTab.RETURN_ITEM_ID.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.ARTICLE_ID.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.AMOUNT.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_RETURN_ITEM_DETAIL  in out nocopy tytbLD_RETURN_ITEM_DETAIL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_RETURN_ITEM_DETAIL);

		for n in itbLD_RETURN_ITEM_DETAIL.first .. itbLD_RETURN_ITEM_DETAIL.last loop
			rcRecOfTab.ACTIVITY_DELIVERY_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).ACTIVITY_DELIVERY_ID;
			rcRecOfTab.ORDER_ACTIVITY_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).ORDER_ACTIVITY_ID;
			rcRecOfTab.RETURN_ITEM_DETAIL_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).RETURN_ITEM_DETAIL_ID;
			rcRecOfTab.RETURN_ITEM_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).RETURN_ITEM_ID;
			rcRecOfTab.ORDER_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).ORDER_ID;
			rcRecOfTab.ARTICLE_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).ARTICLE_ID;
			rcRecOfTab.CAUSAL_ID(n) := itbLD_RETURN_ITEM_DETAIL(n).CAUSAL_ID;
			rcRecOfTab.AMOUNT(n) := itbLD_RETURN_ITEM_DETAIL(n).AMOUNT;
			rcRecOfTab.row_id(n) := itbLD_RETURN_ITEM_DETAIL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRETURN_ITEM_DETAIL_ID
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
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRETURN_ITEM_DETAIL_ID = rcData.RETURN_ITEM_DETAIL_ID
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
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRETURN_ITEM_DETAIL_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN		rcError.RETURN_ITEM_DETAIL_ID:=inuRETURN_ITEM_DETAIL_ID;

		Load
		(
			inuRETURN_ITEM_DETAIL_ID
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
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuRETURN_ITEM_DETAIL_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		orcRecord out nocopy styLD_RETURN_ITEM_DETAIL
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN		rcError.RETURN_ITEM_DETAIL_ID:=inuRETURN_ITEM_DETAIL_ID;

		Load
		(
			inuRETURN_ITEM_DETAIL_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN styLD_RETURN_ITEM_DETAIL
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID:=inuRETURN_ITEM_DETAIL_ID;

		Load
		(
			inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	)
	RETURN styLD_RETURN_ITEM_DETAIL
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID:=inuRETURN_ITEM_DETAIL_ID;

      -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_RETURN_ITEM_DETAIL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_RETURN_ITEM_DETAIL
	)
	IS
		rfLD_RETURN_ITEM_DETAIL tyrfLD_RETURN_ITEM_DETAIL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_RETURN_ITEM_DETAIL.*, LD_RETURN_ITEM_DETAIL.rowid FROM LD_RETURN_ITEM_DETAIL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_RETURN_ITEM_DETAIL for sbFullQuery;

		fetch rfLD_RETURN_ITEM_DETAIL bulk collect INTO otbResult;

		close rfLD_RETURN_ITEM_DETAIL;
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
		sbSQL VARCHAR2 (32000) := 'select LD_RETURN_ITEM_DETAIL.*, LD_RETURN_ITEM_DETAIL.rowid FROM LD_RETURN_ITEM_DETAIL';
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
		ircLD_RETURN_ITEM_DETAIL in styLD_RETURN_ITEM_DETAIL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_RETURN_ITEM_DETAIL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_RETURN_ITEM_DETAIL in styLD_RETURN_ITEM_DETAIL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,fsbGetMessageDescription||'|RETURN_ITEM_DETAIL_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_RETURN_ITEM_DETAIL
		(
			ACTIVITY_DELIVERY_ID,
			ORDER_ACTIVITY_ID,
			RETURN_ITEM_DETAIL_ID,
			RETURN_ITEM_ID,
			ORDER_ID,
			ARTICLE_ID,
			CAUSAL_ID,
			AMOUNT
		)
		values
		(
			ircLD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID,
			ircLD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID,
			ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID,
			ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID,
			ircLD_RETURN_ITEM_DETAIL.ORDER_ID,
			ircLD_RETURN_ITEM_DETAIL.ARTICLE_ID,
			ircLD_RETURN_ITEM_DETAIL.CAUSAL_ID,
			ircLD_RETURN_ITEM_DETAIL.AMOUNT
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_RETURN_ITEM_DETAIL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_RETURN_ITEM_DETAIL in out nocopy tytbLD_RETURN_ITEM_DETAIL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_RETURN_ITEM_DETAIL,blUseRowID);
		forall n in iotbLD_RETURN_ITEM_DETAIL.first..iotbLD_RETURN_ITEM_DETAIL.last
			insert into LD_RETURN_ITEM_DETAIL
			(
				ACTIVITY_DELIVERY_ID,
				ORDER_ACTIVITY_ID,
				RETURN_ITEM_DETAIL_ID,
				RETURN_ITEM_ID,
				ORDER_ID,
				ARTICLE_ID,
				CAUSAL_ID,
				AMOUNT
			)
			values(
				rcRecOfTab.ACTIVITY_DELIVERY_ID(n),
				rcRecOfTab.ORDER_ACTIVITY_ID(n),
				rcRecOfTab.RETURN_ITEM_DETAIL_ID(n),
				rcRecOfTab.RETURN_ITEM_ID(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.ARTICLE_ID(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.AMOUNT(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
        end if;


      delete
		from LD_RETURN_ITEM_DETAIL
		where RETURN_ITEM_DETAIL_ID=inuRETURN_ITEM_DETAIL_ID;
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
		rcError  styLD_RETURN_ITEM_DETAIL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_RETURN_ITEM_DETAIL
		where
			rowid = iriRowID
		returning
			ACTIVITY_DELIVERY_ID
		into
			rcError.ACTIVITY_DELIVERY_ID;
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
		iotbLD_RETURN_ITEM_DETAIL in out nocopy tytbLD_RETURN_ITEM_DETAIL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_RETURN_ITEM_DETAIL;
	BEGIN
		FillRecordOfTables(iotbLD_RETURN_ITEM_DETAIL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
            	for n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last
				delete
				from LD_RETURN_ITEM_DETAIL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last loop
					LockByPk
					(
						rcRecOfTab.RETURN_ITEM_DETAIL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last
				delete
				from LD_RETURN_ITEM_DETAIL
				where
		         	RETURN_ITEM_DETAIL_ID = rcRecOfTab.RETURN_ITEM_DETAIL_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_RETURN_ITEM_DETAIL in styLD_RETURN_ITEM_DETAIL,
		inuLock in number default 0
	)
	IS
		nuRETURN_ITEM_DETAIL_ID	LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type;
	BEGIN
		if ircLD_RETURN_ITEM_DETAIL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_RETURN_ITEM_DETAIL.rowid,rcData);
			end if;
			update LD_RETURN_ITEM_DETAIL
			set
				ACTIVITY_DELIVERY_ID = ircLD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID,
				ORDER_ACTIVITY_ID = ircLD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID,
				RETURN_ITEM_ID = ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID,
				ORDER_ID = ircLD_RETURN_ITEM_DETAIL.ORDER_ID,
				ARTICLE_ID = ircLD_RETURN_ITEM_DETAIL.ARTICLE_ID,
				CAUSAL_ID = ircLD_RETURN_ITEM_DETAIL.CAUSAL_ID,
				AMOUNT = ircLD_RETURN_ITEM_DETAIL.AMOUNT
			where
				rowid = ircLD_RETURN_ITEM_DETAIL.rowid
			returning
				RETURN_ITEM_DETAIL_ID
			into
				nuRETURN_ITEM_DETAIL_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID,
					rcData
				);
			end if;

			update LD_RETURN_ITEM_DETAIL
			set
				ACTIVITY_DELIVERY_ID = ircLD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID,
				ORDER_ACTIVITY_ID = ircLD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID,
				RETURN_ITEM_ID = ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID,
				ORDER_ID = ircLD_RETURN_ITEM_DETAIL.ORDER_ID,
				ARTICLE_ID = ircLD_RETURN_ITEM_DETAIL.ARTICLE_ID,
				CAUSAL_ID = ircLD_RETURN_ITEM_DETAIL.CAUSAL_ID,
				AMOUNT = ircLD_RETURN_ITEM_DETAIL.AMOUNT
			where
				RETURN_ITEM_DETAIL_ID = ircLD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID
			returning
				RETURN_ITEM_DETAIL_ID
			into
				nuRETURN_ITEM_DETAIL_ID;
		end if;
		if
			nuRETURN_ITEM_DETAIL_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_RETURN_ITEM_DETAIL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_RETURN_ITEM_DETAIL in out nocopy tytbLD_RETURN_ITEM_DETAIL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_RETURN_ITEM_DETAIL;
	BEGIN
		FillRecordOfTables(iotbLD_RETURN_ITEM_DETAIL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last
				update LD_RETURN_ITEM_DETAIL set
					ACTIVITY_DELIVERY_ID = rcRecOfTab.ACTIVITY_DELIVERY_ID(n),
					ORDER_ACTIVITY_ID = rcRecOfTab.ORDER_ACTIVITY_ID(n),
					RETURN_ITEM_ID = rcRecOfTab.RETURN_ITEM_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					ARTICLE_ID = rcRecOfTab.ARTICLE_ID(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					AMOUNT = rcRecOfTab.AMOUNT(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last loop

					LockByPk
					(
						rcRecOfTab.RETURN_ITEM_DETAIL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RETURN_ITEM_DETAIL.first .. iotbLD_RETURN_ITEM_DETAIL.last
				update LD_RETURN_ITEM_DETAIL
				SET
					ACTIVITY_DELIVERY_ID = rcRecOfTab.ACTIVITY_DELIVERY_ID(n),
					ORDER_ACTIVITY_ID = rcRecOfTab.ORDER_ACTIVITY_ID(n),
					RETURN_ITEM_ID = rcRecOfTab.RETURN_ITEM_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					ARTICLE_ID = rcRecOfTab.ARTICLE_ID(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					AMOUNT = rcRecOfTab.AMOUNT(n)
				where
					RETURN_ITEM_DETAIL_ID = rcRecOfTab.RETURN_ITEM_DETAIL_ID(n);
		end if;
	END;
	PROCEDURE updACTIVITY_DELIVERY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuACTIVITY_DELIVERY_ID$ in LD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
        if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			ACTIVITY_DELIVERY_ID = inuACTIVITY_DELIVERY_ID$
		where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVITY_DELIVERY_ID:= inuACTIVITY_DELIVERY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ACTIVITY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuORDER_ACTIVITY_ID$ in LD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID%type,
		inuLock in number default 0
	)

IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			ORDER_ACTIVITY_ID = inuORDER_ACTIVITY_ID$
		where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ACTIVITY_ID:= inuORDER_ACTIVITY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRETURN_ITEM_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRETURN_ITEM_ID$ in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			RETURN_ITEM_ID = inuRETURN_ITEM_ID$
		where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RETURN_ITEM_ID:= inuRETURN_ITEM_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuORDER_ID$ in LD_RETURN_ITEM_DETAIL.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			ORDER_ID = inuORDER_ID$
		where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
            raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updARTICLE_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuARTICLE_ID$ in LD_RETURN_ITEM_DETAIL.ARTICLE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			ARTICLE_ID = inuARTICLE_ID$
		where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ARTICLE_ID:= inuARTICLE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuCAUSAL_ID$ in LD_RETURN_ITEM_DETAIL.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			CAUSAL_ID = inuCAUSAL_ID$

	where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAMOUNT
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuAMOUNT$ in LD_RETURN_ITEM_DETAIL.AMOUNT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN
		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_DETAIL_ID,
				rcData
			);
		end if;

		update LD_RETURN_ITEM_DETAIL
		set
			AMOUNT = inuAMOUNT$
		where
			RETURN_ITEM_DETAIL_ID = inuRETURN_ITEM_DETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.AMOUNT:= inuAMOUNT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetACTIVITY_DELIVERY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ACTIVITY_DELIVERY_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.ACTIVITY_DELIVERY_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData.ACTIVITY_DELIVERY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ACTIVITY_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ORDER_ACTIVITY_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

      -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.ORDER_ACTIVITY_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData.ORDER_ACTIVITY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRETURN_ITEM_DETAIL_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.RETURN_ITEM_DETAIL_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData.RETURN_ITEM_DETAIL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRETURN_ITEM_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (

		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.RETURN_ITEM_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData.RETURN_ITEM_ID);
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
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ORDER_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
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
	FUNCTION fnuGetARTICLE_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.ARTICLE_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.ARTICLE_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData.ARTICLE_ID);
    EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_ID
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.CAUSAL_ID%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
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
	FUNCTION fnuGetAMOUNT
	(
		inuRETURN_ITEM_DETAIL_ID in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RETURN_ITEM_DETAIL.AMOUNT%type
	IS
		rcError styLD_RETURN_ITEM_DETAIL;
	BEGIN

		rcError.RETURN_ITEM_DETAIL_ID := inuRETURN_ITEM_DETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_DETAIL_ID
			 )
		then
			 return(rcData.AMOUNT);
		end if;
        Load
		(
		 		inuRETURN_ITEM_DETAIL_ID
		);
		return(rcData.AMOUNT);
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
end DALD_RETURN_ITEM_DETAIL;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_RETURN_ITEM_DETAIL
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_RETURN_ITEM_DETAIL', 'ADM_PERSON'); 
END;
/ 
