CREATE OR REPLACE PACKAGE adm_person.dald_policy_type
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	IS
		SELECT LD_POLICY_TYPE.*,LD_POLICY_TYPE.rowid
		FROM LD_POLICY_TYPE
		WHERE
		    POLICY_TYPE_ID = inuPOLICY_TYPE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_POLICY_TYPE.*,LD_POLICY_TYPE.rowid
		FROM LD_POLICY_TYPE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_POLICY_TYPE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_POLICY_TYPE is table of styLD_POLICY_TYPE index by binary_integer;
	type tyrfRecords is ref cursor return styLD_POLICY_TYPE;

	/* Tipos referenciando al registro */
	type tytbIS_EXQ is table of LD_POLICY_TYPE.IS_EXQ%type index by binary_integer;
	type tytbPOLICY_TYPE_ID is table of LD_POLICY_TYPE.POLICY_TYPE_ID%type index by binary_integer;
	type tytbDESCRIPTION is table of LD_POLICY_TYPE.DESCRIPTION%type index by binary_integer;
	type tytbCATEGORY_ID is table of LD_POLICY_TYPE.CATEGORY_ID%type index by binary_integer;
	type tytbSUBCATEGORY_ID is table of LD_POLICY_TYPE.SUBCATEGORY_ID%type index by binary_integer;
	type tytbCHANNEL is table of LD_POLICY_TYPE.CHANNEL%type index by binary_integer;
	type tytbCONTRATIST_CODE is table of LD_POLICY_TYPE.CONTRATIST_CODE%type index by binary_integer;
	type tytbAMMOUNT_CEDULA is table of LD_POLICY_TYPE.AMMOUNT_CEDULA%type index by binary_integer;
	type tytbCONTRATISTA_ID is table of LD_POLICY_TYPE.CONTRATISTA_ID%type index by binary_integer;
	type tytbPRODUCT_LINE_ID is table of LD_POLICY_TYPE.PRODUCT_LINE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_POLICY_TYPE is record
	(
		IS_EXQ   tytbIS_EXQ,
		POLICY_TYPE_ID   tytbPOLICY_TYPE_ID,
		DESCRIPTION   tytbDESCRIPTION,
		CATEGORY_ID   tytbCATEGORY_ID,
		SUBCATEGORY_ID   tytbSUBCATEGORY_ID,
		CHANNEL   tytbCHANNEL,
		CONTRATIST_CODE   tytbCONTRATIST_CODE,
		AMMOUNT_CEDULA   tytbAMMOUNT_CEDULA,
		CONTRATISTA_ID   tytbCONTRATISTA_ID,
		PRODUCT_LINE_ID   tytbPRODUCT_LINE_ID,
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
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	);

	PROCEDURE getRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		orcRecord out nocopy styLD_POLICY_TYPE
	);

	FUNCTION frcGetRcData
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN styLD_POLICY_TYPE;

	FUNCTION frcGetRcData
	RETURN styLD_POLICY_TYPE;

	FUNCTION frcGetRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN styLD_POLICY_TYPE;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_POLICY_TYPE
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_POLICY_TYPE in styLD_POLICY_TYPE
	);

	PROCEDURE insRecord
	(
		ircLD_POLICY_TYPE in styLD_POLICY_TYPE,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_POLICY_TYPE in out nocopy tytbLD_POLICY_TYPE
	);

	PROCEDURE delRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_POLICY_TYPE in out nocopy tytbLD_POLICY_TYPE,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_POLICY_TYPE in styLD_POLICY_TYPE,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_POLICY_TYPE in out nocopy tytbLD_POLICY_TYPE,
		inuLock in number default 1
	);

	PROCEDURE updIS_EXQ
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		isbIS_EXQ$ in LD_POLICY_TYPE.IS_EXQ%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		isbDESCRIPTION$ in LD_POLICY_TYPE.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuCATEGORY_ID$ in LD_POLICY_TYPE.CATEGORY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuSUBCATEGORY_ID$ in LD_POLICY_TYPE.SUBCATEGORY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCHANNEL
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuCHANNEL$ in LD_POLICY_TYPE.CHANNEL%type,
		inuLock in number default 0
	);

	PROCEDURE updCONTRATIST_CODE
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		isbCONTRATIST_CODE$ in LD_POLICY_TYPE.CONTRATIST_CODE%type,
		inuLock in number default 0
	);

	PROCEDURE updAMMOUNT_CEDULA
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuAMMOUNT_CEDULA$ in LD_POLICY_TYPE.AMMOUNT_CEDULA%type,
		inuLock in number default 0
	);

	PROCEDURE updCONTRATISTA_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuCONTRATISTA_ID$ in LD_POLICY_TYPE.CONTRATISTA_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_LINE_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuPRODUCT_LINE_ID$ in LD_POLICY_TYPE.PRODUCT_LINE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetIS_EXQ
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.IS_EXQ%type;

	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.POLICY_TYPE_ID%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.DESCRIPTION%type;

	FUNCTION fnuGetCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CATEGORY_ID%type;

	FUNCTION fnuGetSUBCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.SUBCATEGORY_ID%type;

	FUNCTION fnuGetCHANNEL
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CHANNEL%type;

	FUNCTION fsbGetCONTRATIST_CODE
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CONTRATIST_CODE%type;

	FUNCTION fnuGetAMMOUNT_CEDULA
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.AMMOUNT_CEDULA%type;

	FUNCTION fnuGetCONTRATISTA_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CONTRATISTA_ID%type;

	FUNCTION fnuGetPRODUCT_LINE_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.PRODUCT_LINE_ID%type;


	PROCEDURE LockByPk
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		orcLD_POLICY_TYPE  out styLD_POLICY_TYPE
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_POLICY_TYPE  out styLD_POLICY_TYPE
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_POLICY_TYPE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_POLICY_TYPE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_POLICY_TYPE';
	 cnuGeEntityId constant varchar2(30) := 8002; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	IS
		SELECT LD_POLICY_TYPE.*,LD_POLICY_TYPE.rowid
		FROM LD_POLICY_TYPE
		WHERE  POLICY_TYPE_ID = inuPOLICY_TYPE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_POLICY_TYPE.*,LD_POLICY_TYPE.rowid
		FROM LD_POLICY_TYPE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_POLICY_TYPE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_POLICY_TYPE;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_POLICY_TYPE default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.POLICY_TYPE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		orcLD_POLICY_TYPE  out styLD_POLICY_TYPE
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

		Open cuLockRcByPk
		(
			inuPOLICY_TYPE_ID
		);

		fetch cuLockRcByPk into orcLD_POLICY_TYPE;
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
		orcLD_POLICY_TYPE  out styLD_POLICY_TYPE
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_POLICY_TYPE;
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
		itbLD_POLICY_TYPE  in out nocopy tytbLD_POLICY_TYPE
	)
	IS
	BEGIN
			rcRecOfTab.IS_EXQ.delete;
			rcRecOfTab.POLICY_TYPE_ID.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.CATEGORY_ID.delete;
			rcRecOfTab.SUBCATEGORY_ID.delete;
			rcRecOfTab.CHANNEL.delete;
			rcRecOfTab.CONTRATIST_CODE.delete;
			rcRecOfTab.AMMOUNT_CEDULA.delete;
			rcRecOfTab.CONTRATISTA_ID.delete;
			rcRecOfTab.PRODUCT_LINE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_POLICY_TYPE  in out nocopy tytbLD_POLICY_TYPE,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_POLICY_TYPE);

		for n in itbLD_POLICY_TYPE.first .. itbLD_POLICY_TYPE.last loop
			rcRecOfTab.IS_EXQ(n) := itbLD_POLICY_TYPE(n).IS_EXQ;
			rcRecOfTab.POLICY_TYPE_ID(n) := itbLD_POLICY_TYPE(n).POLICY_TYPE_ID;
			rcRecOfTab.DESCRIPTION(n) := itbLD_POLICY_TYPE(n).DESCRIPTION;
			rcRecOfTab.CATEGORY_ID(n) := itbLD_POLICY_TYPE(n).CATEGORY_ID;
			rcRecOfTab.SUBCATEGORY_ID(n) := itbLD_POLICY_TYPE(n).SUBCATEGORY_ID;
			rcRecOfTab.CHANNEL(n) := itbLD_POLICY_TYPE(n).CHANNEL;
			rcRecOfTab.CONTRATIST_CODE(n) := itbLD_POLICY_TYPE(n).CONTRATIST_CODE;
			rcRecOfTab.AMMOUNT_CEDULA(n) := itbLD_POLICY_TYPE(n).AMMOUNT_CEDULA;
			rcRecOfTab.CONTRATISTA_ID(n) := itbLD_POLICY_TYPE(n).CONTRATISTA_ID;
			rcRecOfTab.PRODUCT_LINE_ID(n) := itbLD_POLICY_TYPE(n).PRODUCT_LINE_ID;
			rcRecOfTab.row_id(n) := itbLD_POLICY_TYPE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPOLICY_TYPE_ID
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
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPOLICY_TYPE_ID = rcData.POLICY_TYPE_ID
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
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPOLICY_TYPE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN		rcError.POLICY_TYPE_ID:=inuPOLICY_TYPE_ID;

		Load
		(
			inuPOLICY_TYPE_ID
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
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPOLICY_TYPE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		orcRecord out nocopy styLD_POLICY_TYPE
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN		rcError.POLICY_TYPE_ID:=inuPOLICY_TYPE_ID;

		Load
		(
			inuPOLICY_TYPE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN styLD_POLICY_TYPE
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID:=inuPOLICY_TYPE_ID;

		Load
		(
			inuPOLICY_TYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type
	)
	RETURN styLD_POLICY_TYPE
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID:=inuPOLICY_TYPE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPOLICY_TYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_POLICY_TYPE
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_POLICY_TYPE
	)
	IS
		rfLD_POLICY_TYPE tyrfLD_POLICY_TYPE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_POLICY_TYPE.*, LD_POLICY_TYPE.rowid FROM LD_POLICY_TYPE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_POLICY_TYPE for sbFullQuery;

		fetch rfLD_POLICY_TYPE bulk collect INTO otbResult;

		close rfLD_POLICY_TYPE;
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
		sbSQL VARCHAR2 (32000) := 'select LD_POLICY_TYPE.*, LD_POLICY_TYPE.rowid FROM LD_POLICY_TYPE';
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
		ircLD_POLICY_TYPE in styLD_POLICY_TYPE
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_POLICY_TYPE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_POLICY_TYPE in styLD_POLICY_TYPE,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_POLICY_TYPE.POLICY_TYPE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|POLICY_TYPE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_POLICY_TYPE
		(
			IS_EXQ,
			POLICY_TYPE_ID,
			DESCRIPTION,
			CATEGORY_ID,
			SUBCATEGORY_ID,
			CHANNEL,
			CONTRATIST_CODE,
			AMMOUNT_CEDULA,
			CONTRATISTA_ID,
			PRODUCT_LINE_ID
		)
		values
		(
			ircLD_POLICY_TYPE.IS_EXQ,
			ircLD_POLICY_TYPE.POLICY_TYPE_ID,
			ircLD_POLICY_TYPE.DESCRIPTION,
			ircLD_POLICY_TYPE.CATEGORY_ID,
			ircLD_POLICY_TYPE.SUBCATEGORY_ID,
			ircLD_POLICY_TYPE.CHANNEL,
			ircLD_POLICY_TYPE.CONTRATIST_CODE,
			ircLD_POLICY_TYPE.AMMOUNT_CEDULA,
			ircLD_POLICY_TYPE.CONTRATISTA_ID,
			ircLD_POLICY_TYPE.PRODUCT_LINE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_POLICY_TYPE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_POLICY_TYPE in out nocopy tytbLD_POLICY_TYPE
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_POLICY_TYPE,blUseRowID);
		forall n in iotbLD_POLICY_TYPE.first..iotbLD_POLICY_TYPE.last
			insert into LD_POLICY_TYPE
			(
				IS_EXQ,
				POLICY_TYPE_ID,
				DESCRIPTION,
				CATEGORY_ID,
				SUBCATEGORY_ID,
				CHANNEL,
				CONTRATIST_CODE,
				AMMOUNT_CEDULA,
				CONTRATISTA_ID,
				PRODUCT_LINE_ID
			)
			values
			(
				rcRecOfTab.IS_EXQ(n),
				rcRecOfTab.POLICY_TYPE_ID(n),
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.CATEGORY_ID(n),
				rcRecOfTab.SUBCATEGORY_ID(n),
				rcRecOfTab.CHANNEL(n),
				rcRecOfTab.CONTRATIST_CODE(n),
				rcRecOfTab.AMMOUNT_CEDULA(n),
				rcRecOfTab.CONTRATISTA_ID(n),
				rcRecOfTab.PRODUCT_LINE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;


		delete
		from LD_POLICY_TYPE
		where
       		POLICY_TYPE_ID=inuPOLICY_TYPE_ID;
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
		rcError  styLD_POLICY_TYPE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_POLICY_TYPE
		where
			rowid = iriRowID
		returning
			IS_EXQ
		into
			rcError.IS_EXQ;
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
		iotbLD_POLICY_TYPE in out nocopy tytbLD_POLICY_TYPE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_POLICY_TYPE;
	BEGIN
		FillRecordOfTables(iotbLD_POLICY_TYPE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last
				delete
				from LD_POLICY_TYPE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last loop
					LockByPk
					(
						rcRecOfTab.POLICY_TYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last
				delete
				from LD_POLICY_TYPE
				where
		         	POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_POLICY_TYPE in styLD_POLICY_TYPE,
		inuLock in number default 0
	)
	IS
		nuPOLICY_TYPE_ID	LD_POLICY_TYPE.POLICY_TYPE_ID%type;
	BEGIN
		if ircLD_POLICY_TYPE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_POLICY_TYPE.rowid,rcData);
			end if;
			update LD_POLICY_TYPE
			set
				IS_EXQ = ircLD_POLICY_TYPE.IS_EXQ,
				DESCRIPTION = ircLD_POLICY_TYPE.DESCRIPTION,
				CATEGORY_ID = ircLD_POLICY_TYPE.CATEGORY_ID,
				SUBCATEGORY_ID = ircLD_POLICY_TYPE.SUBCATEGORY_ID,
				CHANNEL = ircLD_POLICY_TYPE.CHANNEL,
				CONTRATIST_CODE = ircLD_POLICY_TYPE.CONTRATIST_CODE,
				AMMOUNT_CEDULA = ircLD_POLICY_TYPE.AMMOUNT_CEDULA,
				CONTRATISTA_ID = ircLD_POLICY_TYPE.CONTRATISTA_ID,
				PRODUCT_LINE_ID = ircLD_POLICY_TYPE.PRODUCT_LINE_ID
			where
				rowid = ircLD_POLICY_TYPE.rowid
			returning
				POLICY_TYPE_ID
			into
				nuPOLICY_TYPE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_POLICY_TYPE.POLICY_TYPE_ID,
					rcData
				);
			end if;

			update LD_POLICY_TYPE
			set
				IS_EXQ = ircLD_POLICY_TYPE.IS_EXQ,
				DESCRIPTION = ircLD_POLICY_TYPE.DESCRIPTION,
				CATEGORY_ID = ircLD_POLICY_TYPE.CATEGORY_ID,
				SUBCATEGORY_ID = ircLD_POLICY_TYPE.SUBCATEGORY_ID,
				CHANNEL = ircLD_POLICY_TYPE.CHANNEL,
				CONTRATIST_CODE = ircLD_POLICY_TYPE.CONTRATIST_CODE,
				AMMOUNT_CEDULA = ircLD_POLICY_TYPE.AMMOUNT_CEDULA,
				CONTRATISTA_ID = ircLD_POLICY_TYPE.CONTRATISTA_ID,
				PRODUCT_LINE_ID = ircLD_POLICY_TYPE.PRODUCT_LINE_ID
			where
				POLICY_TYPE_ID = ircLD_POLICY_TYPE.POLICY_TYPE_ID
			returning
				POLICY_TYPE_ID
			into
				nuPOLICY_TYPE_ID;
		end if;
		if
			nuPOLICY_TYPE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_POLICY_TYPE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_POLICY_TYPE in out nocopy tytbLD_POLICY_TYPE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_POLICY_TYPE;
	BEGIN
		FillRecordOfTables(iotbLD_POLICY_TYPE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last
				update LD_POLICY_TYPE
				set
					IS_EXQ = rcRecOfTab.IS_EXQ(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					CATEGORY_ID = rcRecOfTab.CATEGORY_ID(n),
					SUBCATEGORY_ID = rcRecOfTab.SUBCATEGORY_ID(n),
					CHANNEL = rcRecOfTab.CHANNEL(n),
					CONTRATIST_CODE = rcRecOfTab.CONTRATIST_CODE(n),
					AMMOUNT_CEDULA = rcRecOfTab.AMMOUNT_CEDULA(n),
					CONTRATISTA_ID = rcRecOfTab.CONTRATISTA_ID(n),
					PRODUCT_LINE_ID = rcRecOfTab.PRODUCT_LINE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last loop
					LockByPk
					(
						rcRecOfTab.POLICY_TYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY_TYPE.first .. iotbLD_POLICY_TYPE.last
				update LD_POLICY_TYPE
				SET
					IS_EXQ = rcRecOfTab.IS_EXQ(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					CATEGORY_ID = rcRecOfTab.CATEGORY_ID(n),
					SUBCATEGORY_ID = rcRecOfTab.SUBCATEGORY_ID(n),
					CHANNEL = rcRecOfTab.CHANNEL(n),
					CONTRATIST_CODE = rcRecOfTab.CONTRATIST_CODE(n),
					AMMOUNT_CEDULA = rcRecOfTab.AMMOUNT_CEDULA(n),
					CONTRATISTA_ID = rcRecOfTab.CONTRATISTA_ID(n),
					PRODUCT_LINE_ID = rcRecOfTab.PRODUCT_LINE_ID(n)
				where
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n)
;
		end if;
	END;
	PROCEDURE updIS_EXQ
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		isbIS_EXQ$ in LD_POLICY_TYPE.IS_EXQ%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			IS_EXQ = isbIS_EXQ$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_EXQ:= isbIS_EXQ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		isbDESCRIPTION$ in LD_POLICY_TYPE.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuCATEGORY_ID$ in LD_POLICY_TYPE.CATEGORY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			CATEGORY_ID = inuCATEGORY_ID$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CATEGORY_ID:= inuCATEGORY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuSUBCATEGORY_ID$ in LD_POLICY_TYPE.SUBCATEGORY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			SUBCATEGORY_ID = inuSUBCATEGORY_ID$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBCATEGORY_ID:= inuSUBCATEGORY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCHANNEL
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuCHANNEL$ in LD_POLICY_TYPE.CHANNEL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			CHANNEL = inuCHANNEL$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CHANNEL:= inuCHANNEL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONTRATIST_CODE
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		isbCONTRATIST_CODE$ in LD_POLICY_TYPE.CONTRATIST_CODE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			CONTRATIST_CODE = isbCONTRATIST_CODE$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONTRATIST_CODE:= isbCONTRATIST_CODE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAMMOUNT_CEDULA
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuAMMOUNT_CEDULA$ in LD_POLICY_TYPE.AMMOUNT_CEDULA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			AMMOUNT_CEDULA = inuAMMOUNT_CEDULA$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.AMMOUNT_CEDULA:= inuAMMOUNT_CEDULA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONTRATISTA_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuCONTRATISTA_ID$ in LD_POLICY_TYPE.CONTRATISTA_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			CONTRATISTA_ID = inuCONTRATISTA_ID$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONTRATISTA_ID:= inuCONTRATISTA_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_LINE_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuPRODUCT_LINE_ID$ in LD_POLICY_TYPE.PRODUCT_LINE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN
		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_POLICY_TYPE
		set
			PRODUCT_LINE_ID = inuPRODUCT_LINE_ID$
		where
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_LINE_ID:= inuPRODUCT_LINE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetIS_EXQ
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.IS_EXQ%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.IS_EXQ);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.IS_EXQ);
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
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.POLICY_TYPE_ID%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.POLICY_TYPE_ID);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
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
	FUNCTION fsbGetDESCRIPTION
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.DESCRIPTION%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.DESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CATEGORY_ID%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.CATEGORY_ID);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.CATEGORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBCATEGORY_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.SUBCATEGORY_ID%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.SUBCATEGORY_ID);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.SUBCATEGORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCHANNEL
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CHANNEL%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.CHANNEL);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.CHANNEL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCONTRATIST_CODE
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CONTRATIST_CODE%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.CONTRATIST_CODE);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.CONTRATIST_CODE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetAMMOUNT_CEDULA
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.AMMOUNT_CEDULA%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.AMMOUNT_CEDULA);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.AMMOUNT_CEDULA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONTRATISTA_ID
	(
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.CONTRATISTA_ID%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.CONTRATISTA_ID);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
		);
		return(rcData.CONTRATISTA_ID);
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
		inuPOLICY_TYPE_ID in LD_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY_TYPE.PRODUCT_LINE_ID%type
	IS
		rcError styLD_POLICY_TYPE;
	BEGIN

		rcError.POLICY_TYPE_ID := inuPOLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_TYPE_ID
			 )
		then
			 return(rcData.PRODUCT_LINE_ID);
		end if;
		Load
		(
		 		inuPOLICY_TYPE_ID
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALD_POLICY_TYPE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_POLICY_TYPE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_POLICY_TYPE', 'ADM_PERSON'); 
END;
/ 
