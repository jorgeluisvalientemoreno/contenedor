CREATE OR REPLACE PACKAGE adm_person.DALD_QUOTA_TRANSFER
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
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	IS
		SELECT LD_QUOTA_TRANSFER.*,LD_QUOTA_TRANSFER.rowid
		FROM LD_QUOTA_TRANSFER
		WHERE
		    QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_QUOTA_TRANSFER.*,LD_QUOTA_TRANSFER.rowid
		FROM LD_QUOTA_TRANSFER
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_QUOTA_TRANSFER  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_QUOTA_TRANSFER is table of styLD_QUOTA_TRANSFER index by binary_integer;
	type tyrfRecords is ref cursor return styLD_QUOTA_TRANSFER;

	/* Tipos referenciando al registro */
	type tytbPACKAGE_ID is table of LD_QUOTA_TRANSFER.PACKAGE_ID%type index by binary_integer;
	type tytbQUOTA_TRANSFER_ID is table of LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type index by binary_integer;
	type tytbDESTINY_SUBSCRIP_ID is table of LD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID%type index by binary_integer;
	type tytbORIGIN_SUBSCRIP_ID is table of LD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID%type index by binary_integer;
	type tytbORDER_ID is table of LD_QUOTA_TRANSFER.ORDER_ID%type index by binary_integer;
	type tytbTRANSFER_DATE is table of LD_QUOTA_TRANSFER.TRANSFER_DATE%type index by binary_integer;
	type tytbTRASNFER_VALUE is table of LD_QUOTA_TRANSFER.TRASNFER_VALUE%type index by binary_integer;
	type tytbFINAL_DATE is table of LD_QUOTA_TRANSFER.FINAL_DATE%type index by binary_integer;
	type tytbAPPROVED is table of LD_QUOTA_TRANSFER.APPROVED%type index by binary_integer;
	type tytbREQUEST_USER is table of LD_QUOTA_TRANSFER.REQUEST_USER%type index by binary_integer;
	type tytbREVIEW_USER is table of LD_QUOTA_TRANSFER.REVIEW_USER%type index by binary_integer;
	type tytbAPPROVED_USER is table of LD_QUOTA_TRANSFER.APPROVED_USER%type index by binary_integer;
	type tytbREJECT_USER is table of LD_QUOTA_TRANSFER.REJECT_USER%type index by binary_integer;
	type tytbREQUEST_DATE is table of LD_QUOTA_TRANSFER.REQUEST_DATE%type index by binary_integer;
	type tytbREVIEW_DATE is table of LD_QUOTA_TRANSFER.REVIEW_DATE%type index by binary_integer;
	type tytbAPPROVED_DATE is table of LD_QUOTA_TRANSFER.APPROVED_DATE%type index by binary_integer;
	type tytbREJECT_DATE is table of LD_QUOTA_TRANSFER.REJECT_DATE%type index by binary_integer;
	type tytbSTATUS is table of LD_QUOTA_TRANSFER.STATUS%type index by binary_integer;
	type tytbREQUEST_OBSERVATION is table of LD_QUOTA_TRANSFER.REQUEST_OBSERVATION%type index by binary_integer;
	type tytbREVIEW_OBSERVATION is table of LD_QUOTA_TRANSFER.REVIEW_OBSERVATION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_QUOTA_TRANSFER is record
	(
		PACKAGE_ID   tytbPACKAGE_ID,
		QUOTA_TRANSFER_ID   tytbQUOTA_TRANSFER_ID,
		DESTINY_SUBSCRIP_ID   tytbDESTINY_SUBSCRIP_ID,
		ORIGIN_SUBSCRIP_ID   tytbORIGIN_SUBSCRIP_ID,
		ORDER_ID   tytbORDER_ID,
		TRANSFER_DATE   tytbTRANSFER_DATE,
		TRASNFER_VALUE   tytbTRASNFER_VALUE,
		FINAL_DATE   tytbFINAL_DATE,
		APPROVED   tytbAPPROVED,
		REQUEST_USER   tytbREQUEST_USER,
		REVIEW_USER   tytbREVIEW_USER,
		APPROVED_USER   tytbAPPROVED_USER,
		REJECT_USER   tytbREJECT_USER,
		REQUEST_DATE   tytbREQUEST_DATE,
		REVIEW_DATE   tytbREVIEW_DATE,
		APPROVED_DATE   tytbAPPROVED_DATE,
		REJECT_DATE   tytbREJECT_DATE,
		STATUS   tytbSTATUS,
		REQUEST_OBSERVATION   tytbREQUEST_OBSERVATION,
		REVIEW_OBSERVATION   tytbREVIEW_OBSERVATION,
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
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	);

	PROCEDURE getRecord
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		orcRecord out nocopy styLD_QUOTA_TRANSFER
	);

	FUNCTION frcGetRcData
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN styLD_QUOTA_TRANSFER;

	FUNCTION frcGetRcData
	RETURN styLD_QUOTA_TRANSFER;

	FUNCTION frcGetRecord
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN styLD_QUOTA_TRANSFER;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_QUOTA_TRANSFER
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_QUOTA_TRANSFER in styLD_QUOTA_TRANSFER
	);

	PROCEDURE insRecord
	(
		ircLD_QUOTA_TRANSFER in styLD_QUOTA_TRANSFER,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_QUOTA_TRANSFER in out nocopy tytbLD_QUOTA_TRANSFER
	);

	PROCEDURE delRecord
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_QUOTA_TRANSFER in out nocopy tytbLD_QUOTA_TRANSFER,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_QUOTA_TRANSFER in styLD_QUOTA_TRANSFER,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_QUOTA_TRANSFER in out nocopy tytbLD_QUOTA_TRANSFER,
		inuLock in number default 1
	);

	PROCEDURE updPACKAGE_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuPACKAGE_ID$ in LD_QUOTA_TRANSFER.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDESTINY_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuDESTINY_SUBSCRIP_ID$ in LD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updORIGIN_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuORIGIN_SUBSCRIP_ID$ in LD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuORDER_ID$ in LD_QUOTA_TRANSFER.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTRANSFER_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtTRANSFER_DATE$ in LD_QUOTA_TRANSFER.TRANSFER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updTRASNFER_VALUE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuTRASNFER_VALUE$ in LD_QUOTA_TRANSFER.TRASNFER_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAL_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtFINAL_DATE$ in LD_QUOTA_TRANSFER.FINAL_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updAPPROVED
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		isbAPPROVED$ in LD_QUOTA_TRANSFER.APPROVED%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUEST_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuREQUEST_USER$ in LD_QUOTA_TRANSFER.REQUEST_USER%type,
		inuLock in number default 0
	);

	PROCEDURE updREVIEW_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuREVIEW_USER$ in LD_QUOTA_TRANSFER.REVIEW_USER%type,
		inuLock in number default 0
	);

	PROCEDURE updAPPROVED_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuAPPROVED_USER$ in LD_QUOTA_TRANSFER.APPROVED_USER%type,
		inuLock in number default 0
	);

	PROCEDURE updREJECT_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuREJECT_USER$ in LD_QUOTA_TRANSFER.REJECT_USER%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUEST_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtREQUEST_DATE$ in LD_QUOTA_TRANSFER.REQUEST_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updREVIEW_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtREVIEW_DATE$ in LD_QUOTA_TRANSFER.REVIEW_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updAPPROVED_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtAPPROVED_DATE$ in LD_QUOTA_TRANSFER.APPROVED_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updREJECT_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtREJECT_DATE$ in LD_QUOTA_TRANSFER.REJECT_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATUS
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuSTATUS$ in LD_QUOTA_TRANSFER.STATUS%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUEST_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		isbREQUEST_OBSERVATION$ in LD_QUOTA_TRANSFER.REQUEST_OBSERVATION%type,
		inuLock in number default 0
	);

	PROCEDURE updREVIEW_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		isbREVIEW_OBSERVATION$ in LD_QUOTA_TRANSFER.REVIEW_OBSERVATION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPACKAGE_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.PACKAGE_ID%type;

	FUNCTION fnuGetQUOTA_TRANSFER_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type;

	FUNCTION fnuGetDESTINY_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID%type;

	FUNCTION fnuGetORIGIN_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID%type;

	FUNCTION fnuGetORDER_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.ORDER_ID%type;

	FUNCTION fdtGetTRANSFER_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.TRANSFER_DATE%type;

	FUNCTION fnuGetTRASNFER_VALUE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.TRASNFER_VALUE%type;

	FUNCTION fdtGetFINAL_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.FINAL_DATE%type;

	FUNCTION fsbGetAPPROVED
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.APPROVED%type;

	FUNCTION fnuGetREQUEST_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REQUEST_USER%type;

	FUNCTION fnuGetREVIEW_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REVIEW_USER%type;

	FUNCTION fnuGetAPPROVED_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.APPROVED_USER%type;

	FUNCTION fnuGetREJECT_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REJECT_USER%type;

	FUNCTION fdtGetREQUEST_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REQUEST_DATE%type;

	FUNCTION fdtGetREVIEW_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REVIEW_DATE%type;

	FUNCTION fdtGetAPPROVED_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.APPROVED_DATE%type;

	FUNCTION fdtGetREJECT_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REJECT_DATE%type;

	FUNCTION fnuGetSTATUS
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.STATUS%type;

	FUNCTION fsbGetREQUEST_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REQUEST_OBSERVATION%type;

	FUNCTION fsbGetREVIEW_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REVIEW_OBSERVATION%type;


	PROCEDURE LockByPk
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		orcLD_QUOTA_TRANSFER  out styLD_QUOTA_TRANSFER
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_QUOTA_TRANSFER  out styLD_QUOTA_TRANSFER
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_QUOTA_TRANSFER;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_QUOTA_TRANSFER
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO203070';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_QUOTA_TRANSFER';
	 cnuGeEntityId constant varchar2(30) := 7221; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	IS
		SELECT LD_QUOTA_TRANSFER.*,LD_QUOTA_TRANSFER.rowid
		FROM LD_QUOTA_TRANSFER
		WHERE  QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_QUOTA_TRANSFER.*,LD_QUOTA_TRANSFER.rowid
		FROM LD_QUOTA_TRANSFER
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_QUOTA_TRANSFER is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_QUOTA_TRANSFER;

	rcData cuRecord%rowtype;

    blDAO_USE_CACHE    boolean := null;


	/* Metodos privados */
	FUNCTION fsbGetMessageDescription
	return varchar2
	is
	    sbTableDescription varchar2(32000);

        CURSOR cuTableId
        IS  SELECT  display_name
            FROM    ge_entity
            WHERE   name_ = csbTABLEPARAMETER;
	BEGIN
	    /*if (cnuGeEntityId > 0 and dage_entity.fblExist (cnuGeEntityId))  then
	          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
	    else
	          sbTableDescription:= csbTABLEPARAMETER;
	    end if;*/
	    open cuTableId;
	    fetch cuTableId INTO sbTableDescription;
	    close cuTableId;

        if ( sbTableDescription IS null ) then
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
	FUNCTION fsbPrimaryKey( rcI in styLD_QUOTA_TRANSFER default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.QUOTA_TRANSFER_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		orcLD_QUOTA_TRANSFER  out styLD_QUOTA_TRANSFER
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

		Open cuLockRcByPk
		(
			inuQUOTA_TRANSFER_ID
		);

		fetch cuLockRcByPk into orcLD_QUOTA_TRANSFER;
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
		orcLD_QUOTA_TRANSFER  out styLD_QUOTA_TRANSFER
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_QUOTA_TRANSFER;
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
		itbLD_QUOTA_TRANSFER  in out nocopy tytbLD_QUOTA_TRANSFER
	)
	IS
	BEGIN
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.QUOTA_TRANSFER_ID.delete;
			rcRecOfTab.DESTINY_SUBSCRIP_ID.delete;
			rcRecOfTab.ORIGIN_SUBSCRIP_ID.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.TRANSFER_DATE.delete;
			rcRecOfTab.TRASNFER_VALUE.delete;
			rcRecOfTab.FINAL_DATE.delete;
			rcRecOfTab.APPROVED.delete;
			rcRecOfTab.REQUEST_USER.delete;
			rcRecOfTab.REVIEW_USER.delete;
			rcRecOfTab.APPROVED_USER.delete;
			rcRecOfTab.REJECT_USER.delete;
			rcRecOfTab.REQUEST_DATE.delete;
			rcRecOfTab.REVIEW_DATE.delete;
			rcRecOfTab.APPROVED_DATE.delete;
			rcRecOfTab.REJECT_DATE.delete;
			rcRecOfTab.STATUS.delete;
			rcRecOfTab.REQUEST_OBSERVATION.delete;
			rcRecOfTab.REVIEW_OBSERVATION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_QUOTA_TRANSFER  in out nocopy tytbLD_QUOTA_TRANSFER,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_QUOTA_TRANSFER);

		for n in itbLD_QUOTA_TRANSFER.first .. itbLD_QUOTA_TRANSFER.last loop
			rcRecOfTab.PACKAGE_ID(n) := itbLD_QUOTA_TRANSFER(n).PACKAGE_ID;
			rcRecOfTab.QUOTA_TRANSFER_ID(n) := itbLD_QUOTA_TRANSFER(n).QUOTA_TRANSFER_ID;
			rcRecOfTab.DESTINY_SUBSCRIP_ID(n) := itbLD_QUOTA_TRANSFER(n).DESTINY_SUBSCRIP_ID;
			rcRecOfTab.ORIGIN_SUBSCRIP_ID(n) := itbLD_QUOTA_TRANSFER(n).ORIGIN_SUBSCRIP_ID;
			rcRecOfTab.ORDER_ID(n) := itbLD_QUOTA_TRANSFER(n).ORDER_ID;
			rcRecOfTab.TRANSFER_DATE(n) := itbLD_QUOTA_TRANSFER(n).TRANSFER_DATE;
			rcRecOfTab.TRASNFER_VALUE(n) := itbLD_QUOTA_TRANSFER(n).TRASNFER_VALUE;
			rcRecOfTab.FINAL_DATE(n) := itbLD_QUOTA_TRANSFER(n).FINAL_DATE;
			rcRecOfTab.APPROVED(n) := itbLD_QUOTA_TRANSFER(n).APPROVED;
			rcRecOfTab.REQUEST_USER(n) := itbLD_QUOTA_TRANSFER(n).REQUEST_USER;
			rcRecOfTab.REVIEW_USER(n) := itbLD_QUOTA_TRANSFER(n).REVIEW_USER;
			rcRecOfTab.APPROVED_USER(n) := itbLD_QUOTA_TRANSFER(n).APPROVED_USER;
			rcRecOfTab.REJECT_USER(n) := itbLD_QUOTA_TRANSFER(n).REJECT_USER;
			rcRecOfTab.REQUEST_DATE(n) := itbLD_QUOTA_TRANSFER(n).REQUEST_DATE;
			rcRecOfTab.REVIEW_DATE(n) := itbLD_QUOTA_TRANSFER(n).REVIEW_DATE;
			rcRecOfTab.APPROVED_DATE(n) := itbLD_QUOTA_TRANSFER(n).APPROVED_DATE;
			rcRecOfTab.REJECT_DATE(n) := itbLD_QUOTA_TRANSFER(n).REJECT_DATE;
			rcRecOfTab.STATUS(n) := itbLD_QUOTA_TRANSFER(n).STATUS;
			rcRecOfTab.REQUEST_OBSERVATION(n) := itbLD_QUOTA_TRANSFER(n).REQUEST_OBSERVATION;
			rcRecOfTab.REVIEW_OBSERVATION(n) := itbLD_QUOTA_TRANSFER(n).REVIEW_OBSERVATION;
			rcRecOfTab.row_id(n) := itbLD_QUOTA_TRANSFER(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuQUOTA_TRANSFER_ID
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
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuQUOTA_TRANSFER_ID = rcData.QUOTA_TRANSFER_ID
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
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuQUOTA_TRANSFER_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN		rcError.QUOTA_TRANSFER_ID:=inuQUOTA_TRANSFER_ID;

		Load
		(
			inuQUOTA_TRANSFER_ID
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
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuQUOTA_TRANSFER_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		orcRecord out nocopy styLD_QUOTA_TRANSFER
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN		rcError.QUOTA_TRANSFER_ID:=inuQUOTA_TRANSFER_ID;

		Load
		(
			inuQUOTA_TRANSFER_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN styLD_QUOTA_TRANSFER
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID:=inuQUOTA_TRANSFER_ID;

		Load
		(
			inuQUOTA_TRANSFER_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	)
	RETURN styLD_QUOTA_TRANSFER
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID:=inuQUOTA_TRANSFER_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuQUOTA_TRANSFER_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_QUOTA_TRANSFER
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_QUOTA_TRANSFER
	)
	IS
		rfLD_QUOTA_TRANSFER tyrfLD_QUOTA_TRANSFER;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_QUOTA_TRANSFER.*, LD_QUOTA_TRANSFER.rowid FROM LD_QUOTA_TRANSFER';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_QUOTA_TRANSFER for sbFullQuery;

		fetch rfLD_QUOTA_TRANSFER bulk collect INTO otbResult;

		close rfLD_QUOTA_TRANSFER;
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
		sbSQL VARCHAR2 (32000) := 'select LD_QUOTA_TRANSFER.*, LD_QUOTA_TRANSFER.rowid FROM LD_QUOTA_TRANSFER';
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
		ircLD_QUOTA_TRANSFER in styLD_QUOTA_TRANSFER
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_QUOTA_TRANSFER,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_QUOTA_TRANSFER in styLD_QUOTA_TRANSFER,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|QUOTA_TRANSFER_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_QUOTA_TRANSFER
		(
			PACKAGE_ID,
			QUOTA_TRANSFER_ID,
			DESTINY_SUBSCRIP_ID,
			ORIGIN_SUBSCRIP_ID,
			ORDER_ID,
			TRANSFER_DATE,
			TRASNFER_VALUE,
			FINAL_DATE,
			APPROVED,
			REQUEST_USER,
			REVIEW_USER,
			APPROVED_USER,
			REJECT_USER,
			REQUEST_DATE,
			REVIEW_DATE,
			APPROVED_DATE,
			REJECT_DATE,
			STATUS,
			REQUEST_OBSERVATION,
			REVIEW_OBSERVATION
		)
		values
		(
			ircLD_QUOTA_TRANSFER.PACKAGE_ID,
			ircLD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID,
			ircLD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID,
			ircLD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID,
			ircLD_QUOTA_TRANSFER.ORDER_ID,
			ircLD_QUOTA_TRANSFER.TRANSFER_DATE,
			ircLD_QUOTA_TRANSFER.TRASNFER_VALUE,
			ircLD_QUOTA_TRANSFER.FINAL_DATE,
			ircLD_QUOTA_TRANSFER.APPROVED,
			ircLD_QUOTA_TRANSFER.REQUEST_USER,
			ircLD_QUOTA_TRANSFER.REVIEW_USER,
			ircLD_QUOTA_TRANSFER.APPROVED_USER,
			ircLD_QUOTA_TRANSFER.REJECT_USER,
			ircLD_QUOTA_TRANSFER.REQUEST_DATE,
			ircLD_QUOTA_TRANSFER.REVIEW_DATE,
			ircLD_QUOTA_TRANSFER.APPROVED_DATE,
			ircLD_QUOTA_TRANSFER.REJECT_DATE,
			ircLD_QUOTA_TRANSFER.STATUS,
			ircLD_QUOTA_TRANSFER.REQUEST_OBSERVATION,
			ircLD_QUOTA_TRANSFER.REVIEW_OBSERVATION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_QUOTA_TRANSFER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_QUOTA_TRANSFER in out nocopy tytbLD_QUOTA_TRANSFER
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_QUOTA_TRANSFER,blUseRowID);
		forall n in iotbLD_QUOTA_TRANSFER.first..iotbLD_QUOTA_TRANSFER.last
			insert into LD_QUOTA_TRANSFER
			(
				PACKAGE_ID,
				QUOTA_TRANSFER_ID,
				DESTINY_SUBSCRIP_ID,
				ORIGIN_SUBSCRIP_ID,
				ORDER_ID,
				TRANSFER_DATE,
				TRASNFER_VALUE,
				FINAL_DATE,
				APPROVED,
				REQUEST_USER,
				REVIEW_USER,
				APPROVED_USER,
				REJECT_USER,
				REQUEST_DATE,
				REVIEW_DATE,
				APPROVED_DATE,
				REJECT_DATE,
				STATUS,
				REQUEST_OBSERVATION,
				REVIEW_OBSERVATION
			)
			values
			(
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.QUOTA_TRANSFER_ID(n),
				rcRecOfTab.DESTINY_SUBSCRIP_ID(n),
				rcRecOfTab.ORIGIN_SUBSCRIP_ID(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.TRANSFER_DATE(n),
				rcRecOfTab.TRASNFER_VALUE(n),
				rcRecOfTab.FINAL_DATE(n),
				rcRecOfTab.APPROVED(n),
				rcRecOfTab.REQUEST_USER(n),
				rcRecOfTab.REVIEW_USER(n),
				rcRecOfTab.APPROVED_USER(n),
				rcRecOfTab.REJECT_USER(n),
				rcRecOfTab.REQUEST_DATE(n),
				rcRecOfTab.REVIEW_DATE(n),
				rcRecOfTab.APPROVED_DATE(n),
				rcRecOfTab.REJECT_DATE(n),
				rcRecOfTab.STATUS(n),
				rcRecOfTab.REQUEST_OBSERVATION(n),
				rcRecOfTab.REVIEW_OBSERVATION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;


		delete
		from LD_QUOTA_TRANSFER
		where
       		QUOTA_TRANSFER_ID=inuQUOTA_TRANSFER_ID;
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
		rcError  styLD_QUOTA_TRANSFER;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_QUOTA_TRANSFER
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
		iotbLD_QUOTA_TRANSFER in out nocopy tytbLD_QUOTA_TRANSFER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_QUOTA_TRANSFER;
	BEGIN
		FillRecordOfTables(iotbLD_QUOTA_TRANSFER, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last
				delete
				from LD_QUOTA_TRANSFER
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last loop
					LockByPk
					(
						rcRecOfTab.QUOTA_TRANSFER_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last
				delete
				from LD_QUOTA_TRANSFER
				where
		         	QUOTA_TRANSFER_ID = rcRecOfTab.QUOTA_TRANSFER_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_QUOTA_TRANSFER in styLD_QUOTA_TRANSFER,
		inuLock in number default 0
	)
	IS
		nuQUOTA_TRANSFER_ID	LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type;
	BEGIN
		if ircLD_QUOTA_TRANSFER.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_QUOTA_TRANSFER.rowid,rcData);
			end if;
			update LD_QUOTA_TRANSFER
			set
				PACKAGE_ID = ircLD_QUOTA_TRANSFER.PACKAGE_ID,
				DESTINY_SUBSCRIP_ID = ircLD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID,
				ORIGIN_SUBSCRIP_ID = ircLD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID,
				ORDER_ID = ircLD_QUOTA_TRANSFER.ORDER_ID,
				TRANSFER_DATE = ircLD_QUOTA_TRANSFER.TRANSFER_DATE,
				TRASNFER_VALUE = ircLD_QUOTA_TRANSFER.TRASNFER_VALUE,
				FINAL_DATE = ircLD_QUOTA_TRANSFER.FINAL_DATE,
				APPROVED = ircLD_QUOTA_TRANSFER.APPROVED,
				REQUEST_USER = ircLD_QUOTA_TRANSFER.REQUEST_USER,
				REVIEW_USER = ircLD_QUOTA_TRANSFER.REVIEW_USER,
				APPROVED_USER = ircLD_QUOTA_TRANSFER.APPROVED_USER,
				REJECT_USER = ircLD_QUOTA_TRANSFER.REJECT_USER,
				REQUEST_DATE = ircLD_QUOTA_TRANSFER.REQUEST_DATE,
				REVIEW_DATE = ircLD_QUOTA_TRANSFER.REVIEW_DATE,
				APPROVED_DATE = ircLD_QUOTA_TRANSFER.APPROVED_DATE,
				REJECT_DATE = ircLD_QUOTA_TRANSFER.REJECT_DATE,
				STATUS = ircLD_QUOTA_TRANSFER.STATUS,
				REQUEST_OBSERVATION = ircLD_QUOTA_TRANSFER.REQUEST_OBSERVATION,
				REVIEW_OBSERVATION = ircLD_QUOTA_TRANSFER.REVIEW_OBSERVATION
			where
				rowid = ircLD_QUOTA_TRANSFER.rowid
			returning
				QUOTA_TRANSFER_ID
			into
				nuQUOTA_TRANSFER_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID,
					rcData
				);
			end if;

			update LD_QUOTA_TRANSFER
			set
				PACKAGE_ID = ircLD_QUOTA_TRANSFER.PACKAGE_ID,
				DESTINY_SUBSCRIP_ID = ircLD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID,
				ORIGIN_SUBSCRIP_ID = ircLD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID,
				ORDER_ID = ircLD_QUOTA_TRANSFER.ORDER_ID,
				TRANSFER_DATE = ircLD_QUOTA_TRANSFER.TRANSFER_DATE,
				TRASNFER_VALUE = ircLD_QUOTA_TRANSFER.TRASNFER_VALUE,
				FINAL_DATE = ircLD_QUOTA_TRANSFER.FINAL_DATE,
				APPROVED = ircLD_QUOTA_TRANSFER.APPROVED,
				REQUEST_USER = ircLD_QUOTA_TRANSFER.REQUEST_USER,
				REVIEW_USER = ircLD_QUOTA_TRANSFER.REVIEW_USER,
				APPROVED_USER = ircLD_QUOTA_TRANSFER.APPROVED_USER,
				REJECT_USER = ircLD_QUOTA_TRANSFER.REJECT_USER,
				REQUEST_DATE = ircLD_QUOTA_TRANSFER.REQUEST_DATE,
				REVIEW_DATE = ircLD_QUOTA_TRANSFER.REVIEW_DATE,
				APPROVED_DATE = ircLD_QUOTA_TRANSFER.APPROVED_DATE,
				REJECT_DATE = ircLD_QUOTA_TRANSFER.REJECT_DATE,
				STATUS = ircLD_QUOTA_TRANSFER.STATUS,
				REQUEST_OBSERVATION = ircLD_QUOTA_TRANSFER.REQUEST_OBSERVATION,
				REVIEW_OBSERVATION = ircLD_QUOTA_TRANSFER.REVIEW_OBSERVATION
			where
				QUOTA_TRANSFER_ID = ircLD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID
			returning
				QUOTA_TRANSFER_ID
			into
				nuQUOTA_TRANSFER_ID;
		end if;
		if
			nuQUOTA_TRANSFER_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_QUOTA_TRANSFER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_QUOTA_TRANSFER in out nocopy tytbLD_QUOTA_TRANSFER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_QUOTA_TRANSFER;
	BEGIN
		FillRecordOfTables(iotbLD_QUOTA_TRANSFER,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last
				update LD_QUOTA_TRANSFER
				set
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					DESTINY_SUBSCRIP_ID = rcRecOfTab.DESTINY_SUBSCRIP_ID(n),
					ORIGIN_SUBSCRIP_ID = rcRecOfTab.ORIGIN_SUBSCRIP_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					TRANSFER_DATE = rcRecOfTab.TRANSFER_DATE(n),
					TRASNFER_VALUE = rcRecOfTab.TRASNFER_VALUE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n),
					APPROVED = rcRecOfTab.APPROVED(n),
					REQUEST_USER = rcRecOfTab.REQUEST_USER(n),
					REVIEW_USER = rcRecOfTab.REVIEW_USER(n),
					APPROVED_USER = rcRecOfTab.APPROVED_USER(n),
					REJECT_USER = rcRecOfTab.REJECT_USER(n),
					REQUEST_DATE = rcRecOfTab.REQUEST_DATE(n),
					REVIEW_DATE = rcRecOfTab.REVIEW_DATE(n),
					APPROVED_DATE = rcRecOfTab.APPROVED_DATE(n),
					REJECT_DATE = rcRecOfTab.REJECT_DATE(n),
					STATUS = rcRecOfTab.STATUS(n),
					REQUEST_OBSERVATION = rcRecOfTab.REQUEST_OBSERVATION(n),
					REVIEW_OBSERVATION = rcRecOfTab.REVIEW_OBSERVATION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last loop
					LockByPk
					(
						rcRecOfTab.QUOTA_TRANSFER_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_QUOTA_TRANSFER.first .. iotbLD_QUOTA_TRANSFER.last
				update LD_QUOTA_TRANSFER
				SET
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					DESTINY_SUBSCRIP_ID = rcRecOfTab.DESTINY_SUBSCRIP_ID(n),
					ORIGIN_SUBSCRIP_ID = rcRecOfTab.ORIGIN_SUBSCRIP_ID(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					TRANSFER_DATE = rcRecOfTab.TRANSFER_DATE(n),
					TRASNFER_VALUE = rcRecOfTab.TRASNFER_VALUE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n),
					APPROVED = rcRecOfTab.APPROVED(n),
					REQUEST_USER = rcRecOfTab.REQUEST_USER(n),
					REVIEW_USER = rcRecOfTab.REVIEW_USER(n),
					APPROVED_USER = rcRecOfTab.APPROVED_USER(n),
					REJECT_USER = rcRecOfTab.REJECT_USER(n),
					REQUEST_DATE = rcRecOfTab.REQUEST_DATE(n),
					REVIEW_DATE = rcRecOfTab.REVIEW_DATE(n),
					APPROVED_DATE = rcRecOfTab.APPROVED_DATE(n),
					REJECT_DATE = rcRecOfTab.REJECT_DATE(n),
					STATUS = rcRecOfTab.STATUS(n),
					REQUEST_OBSERVATION = rcRecOfTab.REQUEST_OBSERVATION(n),
					REVIEW_OBSERVATION = rcRecOfTab.REVIEW_OBSERVATION(n)
				where
					QUOTA_TRANSFER_ID = rcRecOfTab.QUOTA_TRANSFER_ID(n)
;
		end if;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuPACKAGE_ID$ in LD_QUOTA_TRANSFER.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESTINY_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuDESTINY_SUBSCRIP_ID$ in LD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			DESTINY_SUBSCRIP_ID = inuDESTINY_SUBSCRIP_ID$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESTINY_SUBSCRIP_ID:= inuDESTINY_SUBSCRIP_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORIGIN_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuORIGIN_SUBSCRIP_ID$ in LD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			ORIGIN_SUBSCRIP_ID = inuORIGIN_SUBSCRIP_ID$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORIGIN_SUBSCRIP_ID:= inuORIGIN_SUBSCRIP_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuORDER_ID$ in LD_QUOTA_TRANSFER.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			ORDER_ID = inuORDER_ID$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTRANSFER_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtTRANSFER_DATE$ in LD_QUOTA_TRANSFER.TRANSFER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			TRANSFER_DATE = idtTRANSFER_DATE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TRANSFER_DATE:= idtTRANSFER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTRASNFER_VALUE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuTRASNFER_VALUE$ in LD_QUOTA_TRANSFER.TRASNFER_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			TRASNFER_VALUE = inuTRASNFER_VALUE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TRASNFER_VALUE:= inuTRASNFER_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAL_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtFINAL_DATE$ in LD_QUOTA_TRANSFER.FINAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			FINAL_DATE = idtFINAL_DATE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAL_DATE:= idtFINAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPPROVED
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		isbAPPROVED$ in LD_QUOTA_TRANSFER.APPROVED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			APPROVED = isbAPPROVED$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APPROVED:= isbAPPROVED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUEST_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuREQUEST_USER$ in LD_QUOTA_TRANSFER.REQUEST_USER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REQUEST_USER = inuREQUEST_USER$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUEST_USER:= inuREQUEST_USER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVIEW_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuREVIEW_USER$ in LD_QUOTA_TRANSFER.REVIEW_USER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REVIEW_USER = inuREVIEW_USER$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVIEW_USER:= inuREVIEW_USER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPPROVED_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuAPPROVED_USER$ in LD_QUOTA_TRANSFER.APPROVED_USER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			APPROVED_USER = inuAPPROVED_USER$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APPROVED_USER:= inuAPPROVED_USER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREJECT_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuREJECT_USER$ in LD_QUOTA_TRANSFER.REJECT_USER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REJECT_USER = inuREJECT_USER$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REJECT_USER:= inuREJECT_USER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUEST_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtREQUEST_DATE$ in LD_QUOTA_TRANSFER.REQUEST_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REQUEST_DATE = idtREQUEST_DATE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUEST_DATE:= idtREQUEST_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVIEW_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtREVIEW_DATE$ in LD_QUOTA_TRANSFER.REVIEW_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REVIEW_DATE = idtREVIEW_DATE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVIEW_DATE:= idtREVIEW_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPPROVED_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtAPPROVED_DATE$ in LD_QUOTA_TRANSFER.APPROVED_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			APPROVED_DATE = idtAPPROVED_DATE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APPROVED_DATE:= idtAPPROVED_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREJECT_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		idtREJECT_DATE$ in LD_QUOTA_TRANSFER.REJECT_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REJECT_DATE = idtREJECT_DATE$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REJECT_DATE:= idtREJECT_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATUS
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuSTATUS$ in LD_QUOTA_TRANSFER.STATUS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			STATUS = inuSTATUS$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATUS:= inuSTATUS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUEST_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		isbREQUEST_OBSERVATION$ in LD_QUOTA_TRANSFER.REQUEST_OBSERVATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REQUEST_OBSERVATION = isbREQUEST_OBSERVATION$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUEST_OBSERVATION:= isbREQUEST_OBSERVATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVIEW_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		isbREVIEW_OBSERVATION$ in LD_QUOTA_TRANSFER.REVIEW_OBSERVATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN
		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_TRANSFER_ID,
				rcData
			);
		end if;

		update LD_QUOTA_TRANSFER
		set
			REVIEW_OBSERVATION = isbREVIEW_OBSERVATION$
		where
			QUOTA_TRANSFER_ID = inuQUOTA_TRANSFER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVIEW_OBSERVATION:= isbREVIEW_OBSERVATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.PACKAGE_ID%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
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
	FUNCTION fnuGetQUOTA_TRANSFER_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.QUOTA_TRANSFER_ID);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.QUOTA_TRANSFER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDESTINY_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.DESTINY_SUBSCRIP_ID%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.DESTINY_SUBSCRIP_ID);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.DESTINY_SUBSCRIP_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORIGIN_SUBSCRIP_ID
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.ORIGIN_SUBSCRIP_ID%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.ORIGIN_SUBSCRIP_ID);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.ORIGIN_SUBSCRIP_ID);
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
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.ORDER_ID%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
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
	FUNCTION fdtGetTRANSFER_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.TRANSFER_DATE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.TRANSFER_DATE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.TRANSFER_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTRASNFER_VALUE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.TRASNFER_VALUE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.TRASNFER_VALUE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.TRASNFER_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFINAL_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.FINAL_DATE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.FINAL_DATE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.FINAL_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetAPPROVED
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.APPROVED%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.APPROVED);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.APPROVED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREQUEST_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REQUEST_USER%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REQUEST_USER);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REQUEST_USER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREVIEW_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REVIEW_USER%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REVIEW_USER);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REVIEW_USER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetAPPROVED_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.APPROVED_USER%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.APPROVED_USER);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.APPROVED_USER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREJECT_USER
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REJECT_USER%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REJECT_USER);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REJECT_USER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREQUEST_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REQUEST_DATE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REQUEST_DATE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REQUEST_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREVIEW_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REVIEW_DATE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REVIEW_DATE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REVIEW_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetAPPROVED_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.APPROVED_DATE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.APPROVED_DATE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.APPROVED_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREJECT_DATE
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REJECT_DATE%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REJECT_DATE);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REJECT_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSTATUS
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.STATUS%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.STATUS);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.STATUS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREQUEST_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REQUEST_OBSERVATION%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REQUEST_OBSERVATION);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REQUEST_OBSERVATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREVIEW_OBSERVATION
	(
		inuQUOTA_TRANSFER_ID in LD_QUOTA_TRANSFER.QUOTA_TRANSFER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_QUOTA_TRANSFER.REVIEW_OBSERVATION%type
	IS
		rcError styLD_QUOTA_TRANSFER;
	BEGIN

		rcError.QUOTA_TRANSFER_ID := inuQUOTA_TRANSFER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_TRANSFER_ID
			 )
		then
			 return(rcData.REVIEW_OBSERVATION);
		end if;
		Load
		(
		 		inuQUOTA_TRANSFER_ID
		);
		return(rcData.REVIEW_OBSERVATION);
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
end DALD_QUOTA_TRANSFER;
/
PROMPT Otorgando permisos de ejecucion a DALD_QUOTA_TRANSFER
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_QUOTA_TRANSFER', 'ADM_PERSON');
END;
/