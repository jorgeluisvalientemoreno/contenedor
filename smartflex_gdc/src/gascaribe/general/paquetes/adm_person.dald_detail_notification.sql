CREATE OR REPLACE PACKAGE adm_person.dald_detail_notification
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	IS
		SELECT LD_DETAIL_NOTIFICATION.*,LD_DETAIL_NOTIFICATION.rowid
		FROM LD_DETAIL_NOTIFICATION
		WHERE
		    NOTIFICATION_ID = inuNOTIFICATION_ID
		    and DETAIL_ID = inuDETAIL_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_DETAIL_NOTIFICATION.*,LD_DETAIL_NOTIFICATION.rowid
		FROM LD_DETAIL_NOTIFICATION
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_DETAIL_NOTIFICATION  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_DETAIL_NOTIFICATION is table of styLD_DETAIL_NOTIFICATION index by binary_integer;
	type tyrfRecords is ref cursor return styLD_DETAIL_NOTIFICATION;

	/* Tipos referenciando al registro */
	type tytbDETAIL_ID is table of LD_DETAIL_NOTIFICATION.DETAIL_ID%type index by binary_integer;
	type tytbDOCUMENT_TYPE is table of LD_DETAIL_NOTIFICATION.DOCUMENT_TYPE%type index by binary_integer;
	type tytbSCORE is table of LD_DETAIL_NOTIFICATION.SCORE%type index by binary_integer;
	type tytbUSER_ID is table of LD_DETAIL_NOTIFICATION.USER_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LD_DETAIL_NOTIFICATION.REGISTER_DATE%type index by binary_integer;
	type tytbNOTIFICATION_ID is table of LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type index by binary_integer;
	type tytbDOCUMENT_NUMBER is table of LD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER%type index by binary_integer;
	type tytbNOTIFICATION_TYPE is table of LD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE%type index by binary_integer;
	type tytbSTATE is table of LD_DETAIL_NOTIFICATION.STATE%type index by binary_integer;
	type tytbPRODUCT_ID is table of LD_DETAIL_NOTIFICATION.PRODUCT_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_DETAIL_NOTIFICATION is record
	(
		DETAIL_ID   tytbDETAIL_ID,
		DOCUMENT_TYPE   tytbDOCUMENT_TYPE,
		SCORE   tytbSCORE,
		USER_ID   tytbUSER_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
		NOTIFICATION_ID   tytbNOTIFICATION_ID,
		DOCUMENT_NUMBER   tytbDOCUMENT_NUMBER,
		NOTIFICATION_TYPE   tytbNOTIFICATION_TYPE,
		STATE   tytbSTATE,
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
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	);

	PROCEDURE getRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		orcRecord out nocopy styLD_DETAIL_NOTIFICATION
	);

	FUNCTION frcGetRcData
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN styLD_DETAIL_NOTIFICATION;

	FUNCTION frcGetRcData
	RETURN styLD_DETAIL_NOTIFICATION;

	FUNCTION frcGetRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN styLD_DETAIL_NOTIFICATION;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_DETAIL_NOTIFICATION
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_DETAIL_NOTIFICATION in styLD_DETAIL_NOTIFICATION
	);

	PROCEDURE insRecord
	(
		ircLD_DETAIL_NOTIFICATION in styLD_DETAIL_NOTIFICATION,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_DETAIL_NOTIFICATION in out nocopy tytbLD_DETAIL_NOTIFICATION
	);

	PROCEDURE delRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_DETAIL_NOTIFICATION in out nocopy tytbLD_DETAIL_NOTIFICATION,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_DETAIL_NOTIFICATION in styLD_DETAIL_NOTIFICATION,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_DETAIL_NOTIFICATION in out nocopy tytbLD_DETAIL_NOTIFICATION,
		inuLock in number default 1
	);

	PROCEDURE updDOCUMENT_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuDOCUMENT_TYPE$ in LD_DETAIL_NOTIFICATION.DOCUMENT_TYPE%type,
		inuLock in number default 0
	);

	PROCEDURE updSCORE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbSCORE$ in LD_DETAIL_NOTIFICATION.SCORE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuUSER_ID$ in LD_DETAIL_NOTIFICATION.USER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		idtREGISTER_DATE$ in LD_DETAIL_NOTIFICATION.REGISTER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updDOCUMENT_NUMBER
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbDOCUMENT_NUMBER$ in LD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updNOTIFICATION_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbNOTIFICATION_TYPE$ in LD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbSTATE$ in LD_DETAIL_NOTIFICATION.STATE%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuPRODUCT_ID$ in LD_DETAIL_NOTIFICATION.PRODUCT_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetDETAIL_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.DETAIL_ID%type;

	FUNCTION fnuGetDOCUMENT_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.DOCUMENT_TYPE%type;

	FUNCTION fsbGetSCORE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.SCORE%type;

	FUNCTION fnuGetUSER_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.USER_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.REGISTER_DATE%type;

	FUNCTION fnuGetNOTIFICATION_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type;

	FUNCTION fsbGetDOCUMENT_NUMBER
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER%type;

	FUNCTION fsbGetNOTIFICATION_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE%type;

	FUNCTION fsbGetSTATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.STATE%type;

	FUNCTION fnuGetPRODUCT_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.PRODUCT_ID%type;


	PROCEDURE LockByPk
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		orcLD_DETAIL_NOTIFICATION  out styLD_DETAIL_NOTIFICATION
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_DETAIL_NOTIFICATION  out styLD_DETAIL_NOTIFICATION
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_DETAIL_NOTIFICATION;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_DETAIL_NOTIFICATION
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DETAIL_NOTIFICATION';
	 cnuGeEntityId constant varchar2(30) := 8476; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	IS
		SELECT LD_DETAIL_NOTIFICATION.*,LD_DETAIL_NOTIFICATION.rowid
		FROM LD_DETAIL_NOTIFICATION
		WHERE  NOTIFICATION_ID = inuNOTIFICATION_ID
			and DETAIL_ID = inuDETAIL_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_DETAIL_NOTIFICATION.*,LD_DETAIL_NOTIFICATION.rowid
		FROM LD_DETAIL_NOTIFICATION
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_DETAIL_NOTIFICATION is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_DETAIL_NOTIFICATION;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_DETAIL_NOTIFICATION default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NOTIFICATION_ID);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.DETAIL_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		orcLD_DETAIL_NOTIFICATION  out styLD_DETAIL_NOTIFICATION
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

		Open cuLockRcByPk
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
		);

		fetch cuLockRcByPk into orcLD_DETAIL_NOTIFICATION;
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
		orcLD_DETAIL_NOTIFICATION  out styLD_DETAIL_NOTIFICATION
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_DETAIL_NOTIFICATION;
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
		itbLD_DETAIL_NOTIFICATION  in out nocopy tytbLD_DETAIL_NOTIFICATION
	)
	IS
	BEGIN
			rcRecOfTab.DETAIL_ID.delete;
			rcRecOfTab.DOCUMENT_TYPE.delete;
			rcRecOfTab.SCORE.delete;
			rcRecOfTab.USER_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.NOTIFICATION_ID.delete;
			rcRecOfTab.DOCUMENT_NUMBER.delete;
			rcRecOfTab.NOTIFICATION_TYPE.delete;
			rcRecOfTab.STATE.delete;
			rcRecOfTab.PRODUCT_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_DETAIL_NOTIFICATION  in out nocopy tytbLD_DETAIL_NOTIFICATION,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_DETAIL_NOTIFICATION);

		for n in itbLD_DETAIL_NOTIFICATION.first .. itbLD_DETAIL_NOTIFICATION.last loop
			rcRecOfTab.DETAIL_ID(n) := itbLD_DETAIL_NOTIFICATION(n).DETAIL_ID;
			rcRecOfTab.DOCUMENT_TYPE(n) := itbLD_DETAIL_NOTIFICATION(n).DOCUMENT_TYPE;
			rcRecOfTab.SCORE(n) := itbLD_DETAIL_NOTIFICATION(n).SCORE;
			rcRecOfTab.USER_ID(n) := itbLD_DETAIL_NOTIFICATION(n).USER_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLD_DETAIL_NOTIFICATION(n).REGISTER_DATE;
			rcRecOfTab.NOTIFICATION_ID(n) := itbLD_DETAIL_NOTIFICATION(n).NOTIFICATION_ID;
			rcRecOfTab.DOCUMENT_NUMBER(n) := itbLD_DETAIL_NOTIFICATION(n).DOCUMENT_NUMBER;
			rcRecOfTab.NOTIFICATION_TYPE(n) := itbLD_DETAIL_NOTIFICATION(n).NOTIFICATION_TYPE;
			rcRecOfTab.STATE(n) := itbLD_DETAIL_NOTIFICATION(n).STATE;
			rcRecOfTab.PRODUCT_ID(n) := itbLD_DETAIL_NOTIFICATION(n).PRODUCT_ID;
			rcRecOfTab.row_id(n) := itbLD_DETAIL_NOTIFICATION(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
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
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNOTIFICATION_ID = rcData.NOTIFICATION_ID AND
			inuDETAIL_ID = rcData.DETAIL_ID
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
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;		rcError.DETAIL_ID:=inuDETAIL_ID;

		Load
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
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
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		orcRecord out nocopy styLD_DETAIL_NOTIFICATION
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;		rcError.DETAIL_ID:=inuDETAIL_ID;

		Load
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN styLD_DETAIL_NOTIFICATION
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;
		rcError.DETAIL_ID:=inuDETAIL_ID;

		Load
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	)
	RETURN styLD_DETAIL_NOTIFICATION
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;
		rcError.DETAIL_ID:=inuDETAIL_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuNOTIFICATION_ID,
			inuDETAIL_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNOTIFICATION_ID,
			inuDETAIL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_DETAIL_NOTIFICATION
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_DETAIL_NOTIFICATION
	)
	IS
		rfLD_DETAIL_NOTIFICATION tyrfLD_DETAIL_NOTIFICATION;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_DETAIL_NOTIFICATION.*, LD_DETAIL_NOTIFICATION.rowid FROM LD_DETAIL_NOTIFICATION';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_DETAIL_NOTIFICATION for sbFullQuery;

		fetch rfLD_DETAIL_NOTIFICATION bulk collect INTO otbResult;

		close rfLD_DETAIL_NOTIFICATION;
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
		sbSQL VARCHAR2 (32000) := 'select LD_DETAIL_NOTIFICATION.*, LD_DETAIL_NOTIFICATION.rowid FROM LD_DETAIL_NOTIFICATION';
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
		ircLD_DETAIL_NOTIFICATION in styLD_DETAIL_NOTIFICATION
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_DETAIL_NOTIFICATION,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_DETAIL_NOTIFICATION in styLD_DETAIL_NOTIFICATION,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_DETAIL_NOTIFICATION.NOTIFICATION_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NOTIFICATION_ID');
			raise ex.controlled_error;
		end if;
		if ircLD_DETAIL_NOTIFICATION.DETAIL_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|DETAIL_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_DETAIL_NOTIFICATION
		(
			DETAIL_ID,
			DOCUMENT_TYPE,
			SCORE,
			USER_ID,
			REGISTER_DATE,
			NOTIFICATION_ID,
			DOCUMENT_NUMBER,
			NOTIFICATION_TYPE,
			STATE,
			PRODUCT_ID
		)
		values
		(
			ircLD_DETAIL_NOTIFICATION.DETAIL_ID,
			ircLD_DETAIL_NOTIFICATION.DOCUMENT_TYPE,
			ircLD_DETAIL_NOTIFICATION.SCORE,
			ircLD_DETAIL_NOTIFICATION.USER_ID,
			ircLD_DETAIL_NOTIFICATION.REGISTER_DATE,
			ircLD_DETAIL_NOTIFICATION.NOTIFICATION_ID,
			ircLD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER,
			ircLD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE,
			ircLD_DETAIL_NOTIFICATION.STATE,
			ircLD_DETAIL_NOTIFICATION.PRODUCT_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_DETAIL_NOTIFICATION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_DETAIL_NOTIFICATION in out nocopy tytbLD_DETAIL_NOTIFICATION
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_DETAIL_NOTIFICATION,blUseRowID);
		forall n in iotbLD_DETAIL_NOTIFICATION.first..iotbLD_DETAIL_NOTIFICATION.last
			insert into LD_DETAIL_NOTIFICATION
			(
				DETAIL_ID,
				DOCUMENT_TYPE,
				SCORE,
				USER_ID,
				REGISTER_DATE,
				NOTIFICATION_ID,
				DOCUMENT_NUMBER,
				NOTIFICATION_TYPE,
				STATE,
				PRODUCT_ID
			)
			values
			(
				rcRecOfTab.DETAIL_ID(n),
				rcRecOfTab.DOCUMENT_TYPE(n),
				rcRecOfTab.SCORE(n),
				rcRecOfTab.USER_ID(n),
				rcRecOfTab.REGISTER_DATE(n),
				rcRecOfTab.NOTIFICATION_ID(n),
				rcRecOfTab.DOCUMENT_NUMBER(n),
				rcRecOfTab.NOTIFICATION_TYPE(n),
				rcRecOfTab.STATE(n),
				rcRecOfTab.PRODUCT_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;


		delete
		from LD_DETAIL_NOTIFICATION
		where
       		NOTIFICATION_ID=inuNOTIFICATION_ID and
       		DETAIL_ID=inuDETAIL_ID;
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
		rcError  styLD_DETAIL_NOTIFICATION;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_DETAIL_NOTIFICATION
		where
			rowid = iriRowID
		returning
			DETAIL_ID,
			DOCUMENT_TYPE
		into
			rcError.DETAIL_ID,
			rcError.DOCUMENT_TYPE;
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
		iotbLD_DETAIL_NOTIFICATION in out nocopy tytbLD_DETAIL_NOTIFICATION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_DETAIL_NOTIFICATION;
	BEGIN
		FillRecordOfTables(iotbLD_DETAIL_NOTIFICATION, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last
				delete
				from LD_DETAIL_NOTIFICATION
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last loop
					LockByPk
					(
						rcRecOfTab.NOTIFICATION_ID(n),
						rcRecOfTab.DETAIL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last
				delete
				from LD_DETAIL_NOTIFICATION
				where
		         	NOTIFICATION_ID = rcRecOfTab.NOTIFICATION_ID(n) and
		         	DETAIL_ID = rcRecOfTab.DETAIL_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_DETAIL_NOTIFICATION in styLD_DETAIL_NOTIFICATION,
		inuLock in number default 0
	)
	IS
		nuNOTIFICATION_ID	LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type;
		nuDETAIL_ID	LD_DETAIL_NOTIFICATION.DETAIL_ID%type;
	BEGIN
		if ircLD_DETAIL_NOTIFICATION.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_DETAIL_NOTIFICATION.rowid,rcData);
			end if;
			update LD_DETAIL_NOTIFICATION
			set
				DOCUMENT_TYPE = ircLD_DETAIL_NOTIFICATION.DOCUMENT_TYPE,
				SCORE = ircLD_DETAIL_NOTIFICATION.SCORE,
				USER_ID = ircLD_DETAIL_NOTIFICATION.USER_ID,
				REGISTER_DATE = ircLD_DETAIL_NOTIFICATION.REGISTER_DATE,
				DOCUMENT_NUMBER = ircLD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER,
				NOTIFICATION_TYPE = ircLD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE,
				STATE = ircLD_DETAIL_NOTIFICATION.STATE,
				PRODUCT_ID = ircLD_DETAIL_NOTIFICATION.PRODUCT_ID
			where
				rowid = ircLD_DETAIL_NOTIFICATION.rowid
			returning
				NOTIFICATION_ID,
				DETAIL_ID
			into
				nuNOTIFICATION_ID,
				nuDETAIL_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_DETAIL_NOTIFICATION.NOTIFICATION_ID,
					ircLD_DETAIL_NOTIFICATION.DETAIL_ID,
					rcData
				);
			end if;

			update LD_DETAIL_NOTIFICATION
			set
				DOCUMENT_TYPE = ircLD_DETAIL_NOTIFICATION.DOCUMENT_TYPE,
				SCORE = ircLD_DETAIL_NOTIFICATION.SCORE,
				USER_ID = ircLD_DETAIL_NOTIFICATION.USER_ID,
				REGISTER_DATE = ircLD_DETAIL_NOTIFICATION.REGISTER_DATE,
				DOCUMENT_NUMBER = ircLD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER,
				NOTIFICATION_TYPE = ircLD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE,
				STATE = ircLD_DETAIL_NOTIFICATION.STATE,
				PRODUCT_ID = ircLD_DETAIL_NOTIFICATION.PRODUCT_ID
			where
				NOTIFICATION_ID = ircLD_DETAIL_NOTIFICATION.NOTIFICATION_ID and
				DETAIL_ID = ircLD_DETAIL_NOTIFICATION.DETAIL_ID
			returning
				NOTIFICATION_ID,
				DETAIL_ID
			into
				nuNOTIFICATION_ID,
				nuDETAIL_ID;
		end if;
		if
			nuNOTIFICATION_ID is NULL OR
			nuDETAIL_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_DETAIL_NOTIFICATION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_DETAIL_NOTIFICATION in out nocopy tytbLD_DETAIL_NOTIFICATION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_DETAIL_NOTIFICATION;
	BEGIN
		FillRecordOfTables(iotbLD_DETAIL_NOTIFICATION,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last
				update LD_DETAIL_NOTIFICATION
				set
					DOCUMENT_TYPE = rcRecOfTab.DOCUMENT_TYPE(n),
					SCORE = rcRecOfTab.SCORE(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					DOCUMENT_NUMBER = rcRecOfTab.DOCUMENT_NUMBER(n),
					NOTIFICATION_TYPE = rcRecOfTab.NOTIFICATION_TYPE(n),
					STATE = rcRecOfTab.STATE(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last loop
					LockByPk
					(
						rcRecOfTab.NOTIFICATION_ID(n),
						rcRecOfTab.DETAIL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETAIL_NOTIFICATION.first .. iotbLD_DETAIL_NOTIFICATION.last
				update LD_DETAIL_NOTIFICATION
				SET
					DOCUMENT_TYPE = rcRecOfTab.DOCUMENT_TYPE(n),
					SCORE = rcRecOfTab.SCORE(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					DOCUMENT_NUMBER = rcRecOfTab.DOCUMENT_NUMBER(n),
					NOTIFICATION_TYPE = rcRecOfTab.NOTIFICATION_TYPE(n),
					STATE = rcRecOfTab.STATE(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n)
				where
					NOTIFICATION_ID = rcRecOfTab.NOTIFICATION_ID(n) and
					DETAIL_ID = rcRecOfTab.DETAIL_ID(n)
;
		end if;
	END;
	PROCEDURE updDOCUMENT_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuDOCUMENT_TYPE$ in LD_DETAIL_NOTIFICATION.DOCUMENT_TYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			DOCUMENT_TYPE = inuDOCUMENT_TYPE$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DOCUMENT_TYPE:= inuDOCUMENT_TYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSCORE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbSCORE$ in LD_DETAIL_NOTIFICATION.SCORE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			SCORE = isbSCORE$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SCORE:= isbSCORE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuUSER_ID$ in LD_DETAIL_NOTIFICATION.USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			USER_ID = inuUSER_ID$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_ID:= inuUSER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		idtREGISTER_DATE$ in LD_DETAIL_NOTIFICATION.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDOCUMENT_NUMBER
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbDOCUMENT_NUMBER$ in LD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			DOCUMENT_NUMBER = isbDOCUMENT_NUMBER$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DOCUMENT_NUMBER:= isbDOCUMENT_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNOTIFICATION_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbNOTIFICATION_TYPE$ in LD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			NOTIFICATION_TYPE = isbNOTIFICATION_TYPE$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NOTIFICATION_TYPE:= isbNOTIFICATION_TYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		isbSTATE$ in LD_DETAIL_NOTIFICATION.STATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			STATE = isbSTATE$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE:= isbSTATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuPRODUCT_ID$ in LD_DETAIL_NOTIFICATION.PRODUCT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				inuDETAIL_ID,
				rcData
			);
		end if;

		update LD_DETAIL_NOTIFICATION
		set
			PRODUCT_ID = inuPRODUCT_ID$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID and
			DETAIL_ID = inuDETAIL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_ID:= inuPRODUCT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetDETAIL_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.DETAIL_ID%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.DETAIL_ID);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.DETAIL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDOCUMENT_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.DOCUMENT_TYPE%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.DOCUMENT_TYPE);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.DOCUMENT_TYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSCORE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.SCORE%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.SCORE);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.SCORE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUSER_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.USER_ID%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.USER_ID);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.USER_ID);
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
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.REGISTER_DATE%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
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
	FUNCTION fnuGetNOTIFICATION_ID
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.NOTIFICATION_ID);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.NOTIFICATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDOCUMENT_NUMBER
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.DOCUMENT_NUMBER%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.DOCUMENT_NUMBER);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.DOCUMENT_NUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNOTIFICATION_TYPE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.NOTIFICATION_TYPE%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.NOTIFICATION_TYPE);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.NOTIFICATION_TYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSTATE
	(
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.STATE%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.STATE);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
		);
		return(rcData.STATE);
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
		inuNOTIFICATION_ID in LD_DETAIL_NOTIFICATION.NOTIFICATION_ID%type,
		inuDETAIL_ID in LD_DETAIL_NOTIFICATION.DETAIL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETAIL_NOTIFICATION.PRODUCT_ID%type
	IS
		rcError styLD_DETAIL_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		rcError.DETAIL_ID := inuDETAIL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
			 )
		then
			 return(rcData.PRODUCT_ID);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID,
		 		inuDETAIL_ID
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
end DALD_DETAIL_NOTIFICATION;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_DETAIL_NOTIFICATION
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_DETAIL_NOTIFICATION', 'ADM_PERSON'); 
END;
/