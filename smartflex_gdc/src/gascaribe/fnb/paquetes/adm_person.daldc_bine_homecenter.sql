CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_BINE_HOMECENTER
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	IS
		SELECT LDC_BINE_HOMECENTER.*,LDC_BINE_HOMECENTER.rowid
		FROM LDC_BINE_HOMECENTER
		WHERE
		    SEQUENCE_ID = inuSEQUENCE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_BINE_HOMECENTER.*,LDC_BINE_HOMECENTER.rowid
		FROM LDC_BINE_HOMECENTER
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_BINE_HOMECENTER  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_BINE_HOMECENTER is table of styLDC_BINE_HOMECENTER index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_BINE_HOMECENTER;

	/* Tipos referenciando al registro */
	type tytbSEQUENCE_ID is table of LDC_BINE_HOMECENTER.SEQUENCE_ID%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_BINE_HOMECENTER.PACKAGE_ID%type index by binary_integer;
	type tytbPAGARE_ID is table of LDC_BINE_HOMECENTER.PAGARE_ID%type index by binary_integer;
	type tytbBINE_HOMECENTER_ID is table of LDC_BINE_HOMECENTER.BINE_HOMECENTER_ID%type index by binary_integer;
	type tytbSERVCODI is table of LDC_BINE_HOMECENTER.SERVCODI%type index by binary_integer;
	type tytbID_CONTRATISTA is table of LDC_BINE_HOMECENTER.ID_CONTRATISTA%type index by binary_integer;
	type tytbBINE_STATUS is table of LDC_BINE_HOMECENTER.BINE_STATUS%type index by binary_integer;
	type tytbSALE_VALUE_FINANC is table of LDC_BINE_HOMECENTER.SALE_VALUE_FINANC%type index by binary_integer;
	type tytbCREATION_DATE_APRV is table of LDC_BINE_HOMECENTER.CREATION_DATE_APRV%type index by binary_integer;
	type tytbBIN_DATE_REPORTED is table of LDC_BINE_HOMECENTER.BIN_DATE_REPORTED%type index by binary_integer;
	type tytbBIN_FILE_NAME is table of LDC_BINE_HOMECENTER.BIN_FILE_NAME%type index by binary_integer;
	type tytbTERMINAL is table of LDC_BINE_HOMECENTER.TERMINAL%type index by binary_integer;
	type tytbPROGRAM is table of LDC_BINE_HOMECENTER.PROGRAM%type index by binary_integer;
	type tytbLEGALIZATION_DATE is table of LDC_BINE_HOMECENTER.LEGALIZATION_DATE%type index by binary_integer;
	type tytbUSER_NAME is table of LDC_BINE_HOMECENTER.USER_NAME%type index by binary_integer;
	type tytbORDER_ID is table of LDC_BINE_HOMECENTER.ORDER_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_BINE_HOMECENTER is record
	(
		SEQUENCE_ID   tytbSEQUENCE_ID,
		PACKAGE_ID   tytbPACKAGE_ID,
		PAGARE_ID   tytbPAGARE_ID,
		BINE_HOMECENTER_ID   tytbBINE_HOMECENTER_ID,
		SERVCODI   tytbSERVCODI,
		ID_CONTRATISTA   tytbID_CONTRATISTA,
		BINE_STATUS   tytbBINE_STATUS,
		SALE_VALUE_FINANC   tytbSALE_VALUE_FINANC,
		CREATION_DATE_APRV   tytbCREATION_DATE_APRV,
		BIN_DATE_REPORTED   tytbBIN_DATE_REPORTED,
		BIN_FILE_NAME   tytbBIN_FILE_NAME,
		TERMINAL   tytbTERMINAL,
		PROGRAM   tytbPROGRAM,
		LEGALIZATION_DATE   tytbLEGALIZATION_DATE,
		USER_NAME   tytbUSER_NAME,
		ORDER_ID   tytbORDER_ID,
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	);

	PROCEDURE getRecord
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		orcRecord out nocopy styLDC_BINE_HOMECENTER
	);

	FUNCTION frcGetRcData
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN styLDC_BINE_HOMECENTER;

	FUNCTION frcGetRcData
	RETURN styLDC_BINE_HOMECENTER;

	FUNCTION frcGetRecord
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN styLDC_BINE_HOMECENTER;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_BINE_HOMECENTER
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_BINE_HOMECENTER in styLDC_BINE_HOMECENTER
	);

	PROCEDURE insRecord
	(
		ircLDC_BINE_HOMECENTER in styLDC_BINE_HOMECENTER,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_BINE_HOMECENTER in out nocopy tytbLDC_BINE_HOMECENTER
	);

	PROCEDURE delRecord
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_BINE_HOMECENTER in out nocopy tytbLDC_BINE_HOMECENTER,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_BINE_HOMECENTER in styLDC_BINE_HOMECENTER,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_BINE_HOMECENTER in out nocopy tytbLDC_BINE_HOMECENTER,
		inuLock in number default 1
	);

	PROCEDURE updPACKAGE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuPACKAGE_ID$ in LDC_BINE_HOMECENTER.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPAGARE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuPAGARE_ID$ in LDC_BINE_HOMECENTER.PAGARE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBINE_HOMECENTER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbBINE_HOMECENTER_ID$ in LDC_BINE_HOMECENTER.BINE_HOMECENTER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSERVCODI
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuSERVCODI$ in LDC_BINE_HOMECENTER.SERVCODI%type,
		inuLock in number default 0
	);

	PROCEDURE updID_CONTRATISTA
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuID_CONTRATISTA$ in LDC_BINE_HOMECENTER.ID_CONTRATISTA%type,
		inuLock in number default 0
	);

	PROCEDURE updBINE_STATUS
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbBINE_STATUS$ in LDC_BINE_HOMECENTER.BINE_STATUS%type,
		inuLock in number default 0
	);

	PROCEDURE updSALE_VALUE_FINANC
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuSALE_VALUE_FINANC$ in LDC_BINE_HOMECENTER.SALE_VALUE_FINANC%type,
		inuLock in number default 0
	);

	PROCEDURE updCREATION_DATE_APRV
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		idtCREATION_DATE_APRV$ in LDC_BINE_HOMECENTER.CREATION_DATE_APRV%type,
		inuLock in number default 0
	);

	PROCEDURE updBIN_DATE_REPORTED
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		idtBIN_DATE_REPORTED$ in LDC_BINE_HOMECENTER.BIN_DATE_REPORTED%type,
		inuLock in number default 0
	);

	PROCEDURE updBIN_FILE_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbBIN_FILE_NAME$ in LDC_BINE_HOMECENTER.BIN_FILE_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbTERMINAL$ in LDC_BINE_HOMECENTER.TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updPROGRAM
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbPROGRAM$ in LDC_BINE_HOMECENTER.PROGRAM%type,
		inuLock in number default 0
	);

	PROCEDURE updLEGALIZATION_DATE
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		idtLEGALIZATION_DATE$ in LDC_BINE_HOMECENTER.LEGALIZATION_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbUSER_NAME$ in LDC_BINE_HOMECENTER.USER_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuORDER_ID$ in LDC_BINE_HOMECENTER.ORDER_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetSEQUENCE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.SEQUENCE_ID%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.PACKAGE_ID%type;

	FUNCTION fnuGetPAGARE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.PAGARE_ID%type;

	FUNCTION fsbGetBINE_HOMECENTER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BINE_HOMECENTER_ID%type;

	FUNCTION fnuGetSERVCODI
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.SERVCODI%type;

	FUNCTION fnuGetID_CONTRATISTA
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.ID_CONTRATISTA%type;

	FUNCTION fsbGetBINE_STATUS
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BINE_STATUS%type;

	FUNCTION fnuGetSALE_VALUE_FINANC
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.SALE_VALUE_FINANC%type;

	FUNCTION fdtGetCREATION_DATE_APRV
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.CREATION_DATE_APRV%type;

	FUNCTION fdtGetBIN_DATE_REPORTED
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BIN_DATE_REPORTED%type;

	FUNCTION fsbGetBIN_FILE_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BIN_FILE_NAME%type;

	FUNCTION fsbGetTERMINAL
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.TERMINAL%type;

	FUNCTION fsbGetPROGRAM
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.PROGRAM%type;

	FUNCTION fdtGetLEGALIZATION_DATE
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.LEGALIZATION_DATE%type;

	FUNCTION fsbGetUSER_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.USER_NAME%type;

	FUNCTION fnuGetORDER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.ORDER_ID%type;


	PROCEDURE LockByPk
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		orcLDC_BINE_HOMECENTER  out styLDC_BINE_HOMECENTER
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_BINE_HOMECENTER  out styLDC_BINE_HOMECENTER
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_BINE_HOMECENTER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_BINE_HOMECENTER
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_BINE_HOMECENTER';
	 cnuGeEntityId constant varchar2(30) := 5345; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	IS
		SELECT LDC_BINE_HOMECENTER.*,LDC_BINE_HOMECENTER.rowid
		FROM LDC_BINE_HOMECENTER
		WHERE  SEQUENCE_ID = inuSEQUENCE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_BINE_HOMECENTER.*,LDC_BINE_HOMECENTER.rowid
		FROM LDC_BINE_HOMECENTER
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_BINE_HOMECENTER is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_BINE_HOMECENTER;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_BINE_HOMECENTER default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SEQUENCE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		orcLDC_BINE_HOMECENTER  out styLDC_BINE_HOMECENTER
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

		Open cuLockRcByPk
		(
			inuSEQUENCE_ID
		);

		fetch cuLockRcByPk into orcLDC_BINE_HOMECENTER;
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
		orcLDC_BINE_HOMECENTER  out styLDC_BINE_HOMECENTER
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_BINE_HOMECENTER;
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
		itbLDC_BINE_HOMECENTER  in out nocopy tytbLDC_BINE_HOMECENTER
	)
	IS
	BEGIN
			rcRecOfTab.SEQUENCE_ID.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.PAGARE_ID.delete;
			rcRecOfTab.BINE_HOMECENTER_ID.delete;
			rcRecOfTab.SERVCODI.delete;
			rcRecOfTab.ID_CONTRATISTA.delete;
			rcRecOfTab.BINE_STATUS.delete;
			rcRecOfTab.SALE_VALUE_FINANC.delete;
			rcRecOfTab.CREATION_DATE_APRV.delete;
			rcRecOfTab.BIN_DATE_REPORTED.delete;
			rcRecOfTab.BIN_FILE_NAME.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.PROGRAM.delete;
			rcRecOfTab.LEGALIZATION_DATE.delete;
			rcRecOfTab.USER_NAME.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_BINE_HOMECENTER  in out nocopy tytbLDC_BINE_HOMECENTER,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_BINE_HOMECENTER);

		for n in itbLDC_BINE_HOMECENTER.first .. itbLDC_BINE_HOMECENTER.last loop
			rcRecOfTab.SEQUENCE_ID(n) := itbLDC_BINE_HOMECENTER(n).SEQUENCE_ID;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_BINE_HOMECENTER(n).PACKAGE_ID;
			rcRecOfTab.PAGARE_ID(n) := itbLDC_BINE_HOMECENTER(n).PAGARE_ID;
			rcRecOfTab.BINE_HOMECENTER_ID(n) := itbLDC_BINE_HOMECENTER(n).BINE_HOMECENTER_ID;
			rcRecOfTab.SERVCODI(n) := itbLDC_BINE_HOMECENTER(n).SERVCODI;
			rcRecOfTab.ID_CONTRATISTA(n) := itbLDC_BINE_HOMECENTER(n).ID_CONTRATISTA;
			rcRecOfTab.BINE_STATUS(n) := itbLDC_BINE_HOMECENTER(n).BINE_STATUS;
			rcRecOfTab.SALE_VALUE_FINANC(n) := itbLDC_BINE_HOMECENTER(n).SALE_VALUE_FINANC;
			rcRecOfTab.CREATION_DATE_APRV(n) := itbLDC_BINE_HOMECENTER(n).CREATION_DATE_APRV;
			rcRecOfTab.BIN_DATE_REPORTED(n) := itbLDC_BINE_HOMECENTER(n).BIN_DATE_REPORTED;
			rcRecOfTab.BIN_FILE_NAME(n) := itbLDC_BINE_HOMECENTER(n).BIN_FILE_NAME;
			rcRecOfTab.TERMINAL(n) := itbLDC_BINE_HOMECENTER(n).TERMINAL;
			rcRecOfTab.PROGRAM(n) := itbLDC_BINE_HOMECENTER(n).PROGRAM;
			rcRecOfTab.LEGALIZATION_DATE(n) := itbLDC_BINE_HOMECENTER(n).LEGALIZATION_DATE;
			rcRecOfTab.USER_NAME(n) := itbLDC_BINE_HOMECENTER(n).USER_NAME;
			rcRecOfTab.ORDER_ID(n) := itbLDC_BINE_HOMECENTER(n).ORDER_ID;
			rcRecOfTab.row_id(n) := itbLDC_BINE_HOMECENTER(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSEQUENCE_ID
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSEQUENCE_ID = rcData.SEQUENCE_ID
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSEQUENCE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;

		Load
		(
			inuSEQUENCE_ID
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuSEQUENCE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		orcRecord out nocopy styLDC_BINE_HOMECENTER
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;

		Load
		(
			inuSEQUENCE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN styLDC_BINE_HOMECENTER
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;

		Load
		(
			inuSEQUENCE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	)
	RETURN styLDC_BINE_HOMECENTER
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSEQUENCE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSEQUENCE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_BINE_HOMECENTER
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_BINE_HOMECENTER
	)
	IS
		rfLDC_BINE_HOMECENTER tyrfLDC_BINE_HOMECENTER;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_BINE_HOMECENTER.*, LDC_BINE_HOMECENTER.rowid FROM LDC_BINE_HOMECENTER';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_BINE_HOMECENTER for sbFullQuery;

		fetch rfLDC_BINE_HOMECENTER bulk collect INTO otbResult;

		close rfLDC_BINE_HOMECENTER;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_BINE_HOMECENTER.*, LDC_BINE_HOMECENTER.rowid FROM LDC_BINE_HOMECENTER';
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
		ircLDC_BINE_HOMECENTER in styLDC_BINE_HOMECENTER
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_BINE_HOMECENTER,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_BINE_HOMECENTER in styLDC_BINE_HOMECENTER,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_BINE_HOMECENTER.SEQUENCE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SEQUENCE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_BINE_HOMECENTER
		(
			SEQUENCE_ID,
			PACKAGE_ID,
			PAGARE_ID,
			BINE_HOMECENTER_ID,
			SERVCODI,
			ID_CONTRATISTA,
			BINE_STATUS,
			SALE_VALUE_FINANC,
			CREATION_DATE_APRV,
			BIN_DATE_REPORTED,
			BIN_FILE_NAME,
			TERMINAL,
			PROGRAM,
			LEGALIZATION_DATE,
			USER_NAME,
			ORDER_ID
		)
		values
		(
			ircLDC_BINE_HOMECENTER.SEQUENCE_ID,
			ircLDC_BINE_HOMECENTER.PACKAGE_ID,
			ircLDC_BINE_HOMECENTER.PAGARE_ID,
			ircLDC_BINE_HOMECENTER.BINE_HOMECENTER_ID,
			ircLDC_BINE_HOMECENTER.SERVCODI,
			ircLDC_BINE_HOMECENTER.ID_CONTRATISTA,
			ircLDC_BINE_HOMECENTER.BINE_STATUS,
			ircLDC_BINE_HOMECENTER.SALE_VALUE_FINANC,
			ircLDC_BINE_HOMECENTER.CREATION_DATE_APRV,
			ircLDC_BINE_HOMECENTER.BIN_DATE_REPORTED,
			ircLDC_BINE_HOMECENTER.BIN_FILE_NAME,
			ircLDC_BINE_HOMECENTER.TERMINAL,
			ircLDC_BINE_HOMECENTER.PROGRAM,
			ircLDC_BINE_HOMECENTER.LEGALIZATION_DATE,
			ircLDC_BINE_HOMECENTER.USER_NAME,
			ircLDC_BINE_HOMECENTER.ORDER_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_BINE_HOMECENTER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_BINE_HOMECENTER in out nocopy tytbLDC_BINE_HOMECENTER
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_BINE_HOMECENTER,blUseRowID);
		forall n in iotbLDC_BINE_HOMECENTER.first..iotbLDC_BINE_HOMECENTER.last
			insert into LDC_BINE_HOMECENTER
			(
				SEQUENCE_ID,
				PACKAGE_ID,
				PAGARE_ID,
				BINE_HOMECENTER_ID,
				SERVCODI,
				ID_CONTRATISTA,
				BINE_STATUS,
				SALE_VALUE_FINANC,
				CREATION_DATE_APRV,
				BIN_DATE_REPORTED,
				BIN_FILE_NAME,
				TERMINAL,
				PROGRAM,
				LEGALIZATION_DATE,
				USER_NAME,
				ORDER_ID
			)
			values
			(
				rcRecOfTab.SEQUENCE_ID(n),
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.PAGARE_ID(n),
				rcRecOfTab.BINE_HOMECENTER_ID(n),
				rcRecOfTab.SERVCODI(n),
				rcRecOfTab.ID_CONTRATISTA(n),
				rcRecOfTab.BINE_STATUS(n),
				rcRecOfTab.SALE_VALUE_FINANC(n),
				rcRecOfTab.CREATION_DATE_APRV(n),
				rcRecOfTab.BIN_DATE_REPORTED(n),
				rcRecOfTab.BIN_FILE_NAME(n),
				rcRecOfTab.TERMINAL(n),
				rcRecOfTab.PROGRAM(n),
				rcRecOfTab.LEGALIZATION_DATE(n),
				rcRecOfTab.USER_NAME(n),
				rcRecOfTab.ORDER_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;


		delete
		from LDC_BINE_HOMECENTER
		where
       		SEQUENCE_ID=inuSEQUENCE_ID;
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
		rcError  styLDC_BINE_HOMECENTER;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_BINE_HOMECENTER
		where
			rowid = iriRowID
		returning
			SEQUENCE_ID
		into
			rcError.SEQUENCE_ID;
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
		iotbLDC_BINE_HOMECENTER in out nocopy tytbLDC_BINE_HOMECENTER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_BINE_HOMECENTER;
	BEGIN
		FillRecordOfTables(iotbLDC_BINE_HOMECENTER, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last
				delete
				from LDC_BINE_HOMECENTER
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last loop
					LockByPk
					(
						rcRecOfTab.SEQUENCE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last
				delete
				from LDC_BINE_HOMECENTER
				where
		         	SEQUENCE_ID = rcRecOfTab.SEQUENCE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_BINE_HOMECENTER in styLDC_BINE_HOMECENTER,
		inuLock in number default 0
	)
	IS
		nuSEQUENCE_ID	LDC_BINE_HOMECENTER.SEQUENCE_ID%type;
	BEGIN
		if ircLDC_BINE_HOMECENTER.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_BINE_HOMECENTER.rowid,rcData);
			end if;
			update LDC_BINE_HOMECENTER
			set
				PACKAGE_ID = ircLDC_BINE_HOMECENTER.PACKAGE_ID,
				PAGARE_ID = ircLDC_BINE_HOMECENTER.PAGARE_ID,
				BINE_HOMECENTER_ID = ircLDC_BINE_HOMECENTER.BINE_HOMECENTER_ID,
				SERVCODI = ircLDC_BINE_HOMECENTER.SERVCODI,
				ID_CONTRATISTA = ircLDC_BINE_HOMECENTER.ID_CONTRATISTA,
				BINE_STATUS = ircLDC_BINE_HOMECENTER.BINE_STATUS,
				SALE_VALUE_FINANC = ircLDC_BINE_HOMECENTER.SALE_VALUE_FINANC,
				CREATION_DATE_APRV = ircLDC_BINE_HOMECENTER.CREATION_DATE_APRV,
				BIN_DATE_REPORTED = ircLDC_BINE_HOMECENTER.BIN_DATE_REPORTED,
				BIN_FILE_NAME = ircLDC_BINE_HOMECENTER.BIN_FILE_NAME,
				TERMINAL = ircLDC_BINE_HOMECENTER.TERMINAL,
				PROGRAM = ircLDC_BINE_HOMECENTER.PROGRAM,
				LEGALIZATION_DATE = ircLDC_BINE_HOMECENTER.LEGALIZATION_DATE,
				USER_NAME = ircLDC_BINE_HOMECENTER.USER_NAME,
				ORDER_ID = ircLDC_BINE_HOMECENTER.ORDER_ID
			where
				rowid = ircLDC_BINE_HOMECENTER.rowid
			returning
				SEQUENCE_ID
			into
				nuSEQUENCE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_BINE_HOMECENTER.SEQUENCE_ID,
					rcData
				);
			end if;

			update LDC_BINE_HOMECENTER
			set
				PACKAGE_ID = ircLDC_BINE_HOMECENTER.PACKAGE_ID,
				PAGARE_ID = ircLDC_BINE_HOMECENTER.PAGARE_ID,
				BINE_HOMECENTER_ID = ircLDC_BINE_HOMECENTER.BINE_HOMECENTER_ID,
				SERVCODI = ircLDC_BINE_HOMECENTER.SERVCODI,
				ID_CONTRATISTA = ircLDC_BINE_HOMECENTER.ID_CONTRATISTA,
				BINE_STATUS = ircLDC_BINE_HOMECENTER.BINE_STATUS,
				SALE_VALUE_FINANC = ircLDC_BINE_HOMECENTER.SALE_VALUE_FINANC,
				CREATION_DATE_APRV = ircLDC_BINE_HOMECENTER.CREATION_DATE_APRV,
				BIN_DATE_REPORTED = ircLDC_BINE_HOMECENTER.BIN_DATE_REPORTED,
				BIN_FILE_NAME = ircLDC_BINE_HOMECENTER.BIN_FILE_NAME,
				TERMINAL = ircLDC_BINE_HOMECENTER.TERMINAL,
				PROGRAM = ircLDC_BINE_HOMECENTER.PROGRAM,
				LEGALIZATION_DATE = ircLDC_BINE_HOMECENTER.LEGALIZATION_DATE,
				USER_NAME = ircLDC_BINE_HOMECENTER.USER_NAME,
				ORDER_ID = ircLDC_BINE_HOMECENTER.ORDER_ID
			where
				SEQUENCE_ID = ircLDC_BINE_HOMECENTER.SEQUENCE_ID
			returning
				SEQUENCE_ID
			into
				nuSEQUENCE_ID;
		end if;
		if
			nuSEQUENCE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_BINE_HOMECENTER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_BINE_HOMECENTER in out nocopy tytbLDC_BINE_HOMECENTER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_BINE_HOMECENTER;
	BEGIN
		FillRecordOfTables(iotbLDC_BINE_HOMECENTER,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last
				update LDC_BINE_HOMECENTER
				set
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PAGARE_ID = rcRecOfTab.PAGARE_ID(n),
					BINE_HOMECENTER_ID = rcRecOfTab.BINE_HOMECENTER_ID(n),
					SERVCODI = rcRecOfTab.SERVCODI(n),
					ID_CONTRATISTA = rcRecOfTab.ID_CONTRATISTA(n),
					BINE_STATUS = rcRecOfTab.BINE_STATUS(n),
					SALE_VALUE_FINANC = rcRecOfTab.SALE_VALUE_FINANC(n),
					CREATION_DATE_APRV = rcRecOfTab.CREATION_DATE_APRV(n),
					BIN_DATE_REPORTED = rcRecOfTab.BIN_DATE_REPORTED(n),
					BIN_FILE_NAME = rcRecOfTab.BIN_FILE_NAME(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					PROGRAM = rcRecOfTab.PROGRAM(n),
					LEGALIZATION_DATE = rcRecOfTab.LEGALIZATION_DATE(n),
					USER_NAME = rcRecOfTab.USER_NAME(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last loop
					LockByPk
					(
						rcRecOfTab.SEQUENCE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BINE_HOMECENTER.first .. iotbLDC_BINE_HOMECENTER.last
				update LDC_BINE_HOMECENTER
				SET
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PAGARE_ID = rcRecOfTab.PAGARE_ID(n),
					BINE_HOMECENTER_ID = rcRecOfTab.BINE_HOMECENTER_ID(n),
					SERVCODI = rcRecOfTab.SERVCODI(n),
					ID_CONTRATISTA = rcRecOfTab.ID_CONTRATISTA(n),
					BINE_STATUS = rcRecOfTab.BINE_STATUS(n),
					SALE_VALUE_FINANC = rcRecOfTab.SALE_VALUE_FINANC(n),
					CREATION_DATE_APRV = rcRecOfTab.CREATION_DATE_APRV(n),
					BIN_DATE_REPORTED = rcRecOfTab.BIN_DATE_REPORTED(n),
					BIN_FILE_NAME = rcRecOfTab.BIN_FILE_NAME(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					PROGRAM = rcRecOfTab.PROGRAM(n),
					LEGALIZATION_DATE = rcRecOfTab.LEGALIZATION_DATE(n),
					USER_NAME = rcRecOfTab.USER_NAME(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n)
				where
					SEQUENCE_ID = rcRecOfTab.SEQUENCE_ID(n)
;
		end if;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuPACKAGE_ID$ in LDC_BINE_HOMECENTER.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAGARE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuPAGARE_ID$ in LDC_BINE_HOMECENTER.PAGARE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			PAGARE_ID = inuPAGARE_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAGARE_ID:= inuPAGARE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBINE_HOMECENTER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbBINE_HOMECENTER_ID$ in LDC_BINE_HOMECENTER.BINE_HOMECENTER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			BINE_HOMECENTER_ID = isbBINE_HOMECENTER_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BINE_HOMECENTER_ID:= isbBINE_HOMECENTER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSERVCODI
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuSERVCODI$ in LDC_BINE_HOMECENTER.SERVCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			SERVCODI = inuSERVCODI$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SERVCODI:= inuSERVCODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_CONTRATISTA
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuID_CONTRATISTA$ in LDC_BINE_HOMECENTER.ID_CONTRATISTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			ID_CONTRATISTA = inuID_CONTRATISTA$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_CONTRATISTA:= inuID_CONTRATISTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBINE_STATUS
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbBINE_STATUS$ in LDC_BINE_HOMECENTER.BINE_STATUS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			BINE_STATUS = isbBINE_STATUS$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BINE_STATUS:= isbBINE_STATUS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSALE_VALUE_FINANC
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuSALE_VALUE_FINANC$ in LDC_BINE_HOMECENTER.SALE_VALUE_FINANC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			SALE_VALUE_FINANC = inuSALE_VALUE_FINANC$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SALE_VALUE_FINANC:= inuSALE_VALUE_FINANC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCREATION_DATE_APRV
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		idtCREATION_DATE_APRV$ in LDC_BINE_HOMECENTER.CREATION_DATE_APRV%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			CREATION_DATE_APRV = idtCREATION_DATE_APRV$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREATION_DATE_APRV:= idtCREATION_DATE_APRV$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBIN_DATE_REPORTED
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		idtBIN_DATE_REPORTED$ in LDC_BINE_HOMECENTER.BIN_DATE_REPORTED%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			BIN_DATE_REPORTED = idtBIN_DATE_REPORTED$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BIN_DATE_REPORTED:= idtBIN_DATE_REPORTED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBIN_FILE_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbBIN_FILE_NAME$ in LDC_BINE_HOMECENTER.BIN_FILE_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			BIN_FILE_NAME = isbBIN_FILE_NAME$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BIN_FILE_NAME:= isbBIN_FILE_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbTERMINAL$ in LDC_BINE_HOMECENTER.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			TERMINAL = isbTERMINAL$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROGRAM
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbPROGRAM$ in LDC_BINE_HOMECENTER.PROGRAM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			PROGRAM = isbPROGRAM$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROGRAM:= isbPROGRAM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLEGALIZATION_DATE
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		idtLEGALIZATION_DATE$ in LDC_BINE_HOMECENTER.LEGALIZATION_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			LEGALIZATION_DATE = idtLEGALIZATION_DATE$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LEGALIZATION_DATE:= idtLEGALIZATION_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		isbUSER_NAME$ in LDC_BINE_HOMECENTER.USER_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			USER_NAME = isbUSER_NAME$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_NAME:= isbUSER_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuORDER_ID$ in LDC_BINE_HOMECENTER.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LDC_BINE_HOMECENTER
		set
			ORDER_ID = inuORDER_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetSEQUENCE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.SEQUENCE_ID%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.SEQUENCE_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.SEQUENCE_ID);
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.PACKAGE_ID%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
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
	FUNCTION fnuGetPAGARE_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.PAGARE_ID%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.PAGARE_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.PAGARE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBINE_HOMECENTER_ID
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BINE_HOMECENTER_ID%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.BINE_HOMECENTER_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.BINE_HOMECENTER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSERVCODI
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.SERVCODI%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.SERVCODI);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.SERVCODI);
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.ID_CONTRATISTA%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.ID_CONTRATISTA);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
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
	FUNCTION fsbGetBINE_STATUS
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BINE_STATUS%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.BINE_STATUS);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.BINE_STATUS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSALE_VALUE_FINANC
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.SALE_VALUE_FINANC%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.SALE_VALUE_FINANC);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.SALE_VALUE_FINANC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetCREATION_DATE_APRV
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.CREATION_DATE_APRV%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.CREATION_DATE_APRV);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.CREATION_DATE_APRV);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetBIN_DATE_REPORTED
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BIN_DATE_REPORTED%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.BIN_DATE_REPORTED);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.BIN_DATE_REPORTED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBIN_FILE_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.BIN_FILE_NAME%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.BIN_FILE_NAME);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.BIN_FILE_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.TERMINAL%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.TERMINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPROGRAM
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.PROGRAM%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.PROGRAM);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.PROGRAM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetLEGALIZATION_DATE
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.LEGALIZATION_DATE%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.LEGALIZATION_DATE);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.LEGALIZATION_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_NAME
	(
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.USER_NAME%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.USER_NAME);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.USER_NAME);
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
		inuSEQUENCE_ID in LDC_BINE_HOMECENTER.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BINE_HOMECENTER.ORDER_ID%type
	IS
		rcError styLDC_BINE_HOMECENTER;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_BINE_HOMECENTER;
/
PROMPT Otorgando permisos de ejecucion a DALDC_BINE_HOMECENTER
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_BINE_HOMECENTER', 'ADM_PERSON');
END;
/