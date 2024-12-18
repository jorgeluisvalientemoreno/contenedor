CREATE OR REPLACE PACKAGE adm_person.dald_bine_cencosud
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	IS
		SELECT LD_BINE_CENCOSUD.*,LD_BINE_CENCOSUD.rowid
		FROM LD_BINE_CENCOSUD
		WHERE
		    SEQUENCE_ID = inuSEQUENCE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_BINE_CENCOSUD.*,LD_BINE_CENCOSUD.rowid
		FROM LD_BINE_CENCOSUD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_BINE_CENCOSUD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_BINE_CENCOSUD is table of styLD_BINE_CENCOSUD index by binary_integer;
	type tyrfRecords is ref cursor return styLD_BINE_CENCOSUD;

	/* Tipos referenciando al registro */
	type tytbSEQUENCE_ID is table of LD_BINE_CENCOSUD.SEQUENCE_ID%type index by binary_integer;
	type tytbPACKAGE_ID is table of LD_BINE_CENCOSUD.PACKAGE_ID%type index by binary_integer;
	type tytbPAGARE_ID is table of LD_BINE_CENCOSUD.PAGARE_ID%type index by binary_integer;
	type tytbBINE_CENCOSUD_ID is table of LD_BINE_CENCOSUD.BINE_CENCOSUD_ID%type index by binary_integer;
	type tytbSERVCODI is table of LD_BINE_CENCOSUD.SERVCODI%type index by binary_integer;
	type tytbID_CONTRATISTA is table of LD_BINE_CENCOSUD.ID_CONTRATISTA%type index by binary_integer;
	type tytbBINE_STATUS is table of LD_BINE_CENCOSUD.BINE_STATUS%type index by binary_integer;
	type tytbSALE_VALUE_FINANC is table of LD_BINE_CENCOSUD.SALE_VALUE_FINANC%type index by binary_integer;
	type tytbCREATION_DATE_APRV is table of LD_BINE_CENCOSUD.CREATION_DATE_APRV%type index by binary_integer;
	type tytbBIN_DATE_REPORTED is table of LD_BINE_CENCOSUD.BIN_DATE_REPORTED%type index by binary_integer;
	type tytbBIN_FILE_NAME is table of LD_BINE_CENCOSUD.BIN_FILE_NAME%type index by binary_integer;
	type tytbTERMINAL is table of LD_BINE_CENCOSUD.TERMINAL%type index by binary_integer;
	type tytbPROGRAM is table of LD_BINE_CENCOSUD.PROGRAM%type index by binary_integer;
	type tytbLEGALIZATION_DATE is table of LD_BINE_CENCOSUD.LEGALIZATION_DATE%type index by binary_integer;
	type tytbUSER_NAME is table of LD_BINE_CENCOSUD.USER_NAME%type index by binary_integer;
	type tytbORDER_ID is table of LD_BINE_CENCOSUD.ORDER_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_BINE_CENCOSUD is record
	(
		SEQUENCE_ID   tytbSEQUENCE_ID,
		PACKAGE_ID   tytbPACKAGE_ID,
		PAGARE_ID   tytbPAGARE_ID,
		BINE_CENCOSUD_ID   tytbBINE_CENCOSUD_ID,
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	);

	PROCEDURE getRecord
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		orcRecord out nocopy styLD_BINE_CENCOSUD
	);

	FUNCTION frcGetRcData
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	RETURN styLD_BINE_CENCOSUD;

	FUNCTION frcGetRcData
	RETURN styLD_BINE_CENCOSUD;

	FUNCTION frcGetRecord
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	RETURN styLD_BINE_CENCOSUD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_BINE_CENCOSUD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_BINE_CENCOSUD in styLD_BINE_CENCOSUD
	);

	PROCEDURE insRecord
	(
		ircLD_BINE_CENCOSUD in styLD_BINE_CENCOSUD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_BINE_CENCOSUD in out nocopy tytbLD_BINE_CENCOSUD
	);

	PROCEDURE delRecord
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_BINE_CENCOSUD in out nocopy tytbLD_BINE_CENCOSUD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_BINE_CENCOSUD in styLD_BINE_CENCOSUD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_BINE_CENCOSUD in out nocopy tytbLD_BINE_CENCOSUD,
		inuLock in number default 1
	);

	PROCEDURE updPACKAGE_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuPACKAGE_ID$ in LD_BINE_CENCOSUD.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPAGARE_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuPAGARE_ID$ in LD_BINE_CENCOSUD.PAGARE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBINE_CENCOSUD_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbBINE_CENCOSUD_ID$ in LD_BINE_CENCOSUD.BINE_CENCOSUD_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSERVCODI
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuSERVCODI$ in LD_BINE_CENCOSUD.SERVCODI%type,
		inuLock in number default 0
	);

	PROCEDURE updID_CONTRATISTA
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuID_CONTRATISTA$ in LD_BINE_CENCOSUD.ID_CONTRATISTA%type,
		inuLock in number default 0
	);

	PROCEDURE updBINE_STATUS
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbBINE_STATUS$ in LD_BINE_CENCOSUD.BINE_STATUS%type,
		inuLock in number default 0
	);

	PROCEDURE updSALE_VALUE_FINANC
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuSALE_VALUE_FINANC$ in LD_BINE_CENCOSUD.SALE_VALUE_FINANC%type,
		inuLock in number default 0
	);

	PROCEDURE updCREATION_DATE_APRV
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		idtCREATION_DATE_APRV$ in LD_BINE_CENCOSUD.CREATION_DATE_APRV%type,
		inuLock in number default 0
	);

	PROCEDURE updBIN_DATE_REPORTED
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		idtBIN_DATE_REPORTED$ in LD_BINE_CENCOSUD.BIN_DATE_REPORTED%type,
		inuLock in number default 0
	);

	PROCEDURE updBIN_FILE_NAME
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbBIN_FILE_NAME$ in LD_BINE_CENCOSUD.BIN_FILE_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbTERMINAL$ in LD_BINE_CENCOSUD.TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updPROGRAM
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbPROGRAM$ in LD_BINE_CENCOSUD.PROGRAM%type,
		inuLock in number default 0
	);

	PROCEDURE updLEGALIZATION_DATE
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		idtLEGALIZATION_DATE$ in LD_BINE_CENCOSUD.LEGALIZATION_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_NAME
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbUSER_NAME$ in LD_BINE_CENCOSUD.USER_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuORDER_ID$ in LD_BINE_CENCOSUD.ORDER_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetSEQUENCE_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.SEQUENCE_ID%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.PACKAGE_ID%type;

	FUNCTION fnuGetPAGARE_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.PAGARE_ID%type;

	FUNCTION fsbGetBINE_CENCOSUD_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BINE_CENCOSUD_ID%type;

	FUNCTION fnuGetSERVCODI
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.SERVCODI%type;

	FUNCTION fnuGetID_CONTRATISTA
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.ID_CONTRATISTA%type;

	FUNCTION fsbGetBINE_STATUS
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BINE_STATUS%type;

	FUNCTION fnuGetSALE_VALUE_FINANC
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.SALE_VALUE_FINANC%type;

	FUNCTION fdtGetCREATION_DATE_APRV
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.CREATION_DATE_APRV%type;

	FUNCTION fdtGetBIN_DATE_REPORTED
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BIN_DATE_REPORTED%type;

	FUNCTION fsbGetBIN_FILE_NAME
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BIN_FILE_NAME%type;

	FUNCTION fsbGetTERMINAL
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.TERMINAL%type;

	FUNCTION fsbGetPROGRAM
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.PROGRAM%type;

	FUNCTION fdtGetLEGALIZATION_DATE
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.LEGALIZATION_DATE%type;

	FUNCTION fsbGetUSER_NAME
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.USER_NAME%type;

	FUNCTION fnuGetORDER_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.ORDER_ID%type;


	PROCEDURE LockByPk
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		orcLD_BINE_CENCOSUD  out styLD_BINE_CENCOSUD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_BINE_CENCOSUD  out styLD_BINE_CENCOSUD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_BINE_CENCOSUD;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_BINE_CENCOSUD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_BINE_CENCOSUD';
	 cnuGeEntityId constant varchar2(30) := 3953; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	IS
		SELECT LD_BINE_CENCOSUD.*,LD_BINE_CENCOSUD.rowid
		FROM LD_BINE_CENCOSUD
		WHERE  SEQUENCE_ID = inuSEQUENCE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_BINE_CENCOSUD.*,LD_BINE_CENCOSUD.rowid
		FROM LD_BINE_CENCOSUD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_BINE_CENCOSUD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_BINE_CENCOSUD;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_BINE_CENCOSUD default rcData )
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		orcLD_BINE_CENCOSUD  out styLD_BINE_CENCOSUD
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

		Open cuLockRcByPk
		(
			inuSEQUENCE_ID
		);

		fetch cuLockRcByPk into orcLD_BINE_CENCOSUD;
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
		orcLD_BINE_CENCOSUD  out styLD_BINE_CENCOSUD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_BINE_CENCOSUD;
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
		itbLD_BINE_CENCOSUD  in out nocopy tytbLD_BINE_CENCOSUD
	)
	IS
	BEGIN
			rcRecOfTab.SEQUENCE_ID.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.PAGARE_ID.delete;
			rcRecOfTab.BINE_CENCOSUD_ID.delete;
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
		itbLD_BINE_CENCOSUD  in out nocopy tytbLD_BINE_CENCOSUD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_BINE_CENCOSUD);

		for n in itbLD_BINE_CENCOSUD.first .. itbLD_BINE_CENCOSUD.last loop
			rcRecOfTab.SEQUENCE_ID(n) := itbLD_BINE_CENCOSUD(n).SEQUENCE_ID;
			rcRecOfTab.PACKAGE_ID(n) := itbLD_BINE_CENCOSUD(n).PACKAGE_ID;
			rcRecOfTab.PAGARE_ID(n) := itbLD_BINE_CENCOSUD(n).PAGARE_ID;
			rcRecOfTab.BINE_CENCOSUD_ID(n) := itbLD_BINE_CENCOSUD(n).BINE_CENCOSUD_ID;
			rcRecOfTab.SERVCODI(n) := itbLD_BINE_CENCOSUD(n).SERVCODI;
			rcRecOfTab.ID_CONTRATISTA(n) := itbLD_BINE_CENCOSUD(n).ID_CONTRATISTA;
			rcRecOfTab.BINE_STATUS(n) := itbLD_BINE_CENCOSUD(n).BINE_STATUS;
			rcRecOfTab.SALE_VALUE_FINANC(n) := itbLD_BINE_CENCOSUD(n).SALE_VALUE_FINANC;
			rcRecOfTab.CREATION_DATE_APRV(n) := itbLD_BINE_CENCOSUD(n).CREATION_DATE_APRV;
			rcRecOfTab.BIN_DATE_REPORTED(n) := itbLD_BINE_CENCOSUD(n).BIN_DATE_REPORTED;
			rcRecOfTab.BIN_FILE_NAME(n) := itbLD_BINE_CENCOSUD(n).BIN_FILE_NAME;
			rcRecOfTab.TERMINAL(n) := itbLD_BINE_CENCOSUD(n).TERMINAL;
			rcRecOfTab.PROGRAM(n) := itbLD_BINE_CENCOSUD(n).PROGRAM;
			rcRecOfTab.LEGALIZATION_DATE(n) := itbLD_BINE_CENCOSUD(n).LEGALIZATION_DATE;
			rcRecOfTab.USER_NAME(n) := itbLD_BINE_CENCOSUD(n).USER_NAME;
			rcRecOfTab.ORDER_ID(n) := itbLD_BINE_CENCOSUD(n).ORDER_ID;
			rcRecOfTab.row_id(n) := itbLD_BINE_CENCOSUD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		orcRecord out nocopy styLD_BINE_CENCOSUD
	)
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	RETURN styLD_BINE_CENCOSUD
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type
	)
	RETURN styLD_BINE_CENCOSUD
	IS
		rcError styLD_BINE_CENCOSUD;
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
	RETURN styLD_BINE_CENCOSUD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_BINE_CENCOSUD
	)
	IS
		rfLD_BINE_CENCOSUD tyrfLD_BINE_CENCOSUD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_BINE_CENCOSUD.*, LD_BINE_CENCOSUD.rowid FROM LD_BINE_CENCOSUD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_BINE_CENCOSUD for sbFullQuery;

		fetch rfLD_BINE_CENCOSUD bulk collect INTO otbResult;

		close rfLD_BINE_CENCOSUD;
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
		sbSQL VARCHAR2 (32000) := 'select LD_BINE_CENCOSUD.*, LD_BINE_CENCOSUD.rowid FROM LD_BINE_CENCOSUD';
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
		ircLD_BINE_CENCOSUD in styLD_BINE_CENCOSUD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_BINE_CENCOSUD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_BINE_CENCOSUD in styLD_BINE_CENCOSUD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_BINE_CENCOSUD.SEQUENCE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SEQUENCE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_BINE_CENCOSUD
		(
			SEQUENCE_ID,
			PACKAGE_ID,
			PAGARE_ID,
			BINE_CENCOSUD_ID,
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
			ircLD_BINE_CENCOSUD.SEQUENCE_ID,
			ircLD_BINE_CENCOSUD.PACKAGE_ID,
			ircLD_BINE_CENCOSUD.PAGARE_ID,
			ircLD_BINE_CENCOSUD.BINE_CENCOSUD_ID,
			ircLD_BINE_CENCOSUD.SERVCODI,
			ircLD_BINE_CENCOSUD.ID_CONTRATISTA,
			ircLD_BINE_CENCOSUD.BINE_STATUS,
			ircLD_BINE_CENCOSUD.SALE_VALUE_FINANC,
			ircLD_BINE_CENCOSUD.CREATION_DATE_APRV,
			ircLD_BINE_CENCOSUD.BIN_DATE_REPORTED,
			ircLD_BINE_CENCOSUD.BIN_FILE_NAME,
			ircLD_BINE_CENCOSUD.TERMINAL,
			ircLD_BINE_CENCOSUD.PROGRAM,
			ircLD_BINE_CENCOSUD.LEGALIZATION_DATE,
			ircLD_BINE_CENCOSUD.USER_NAME,
			ircLD_BINE_CENCOSUD.ORDER_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_BINE_CENCOSUD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_BINE_CENCOSUD in out nocopy tytbLD_BINE_CENCOSUD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_BINE_CENCOSUD,blUseRowID);
		forall n in iotbLD_BINE_CENCOSUD.first..iotbLD_BINE_CENCOSUD.last
			insert into LD_BINE_CENCOSUD
			(
				SEQUENCE_ID,
				PACKAGE_ID,
				PAGARE_ID,
				BINE_CENCOSUD_ID,
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
				rcRecOfTab.BINE_CENCOSUD_ID(n),
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_BINE_CENCOSUD;
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
		from LD_BINE_CENCOSUD
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
		rcError  styLD_BINE_CENCOSUD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_BINE_CENCOSUD
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
		iotbLD_BINE_CENCOSUD in out nocopy tytbLD_BINE_CENCOSUD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_BINE_CENCOSUD;
	BEGIN
		FillRecordOfTables(iotbLD_BINE_CENCOSUD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last
				delete
				from LD_BINE_CENCOSUD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last loop
					LockByPk
					(
						rcRecOfTab.SEQUENCE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last
				delete
				from LD_BINE_CENCOSUD
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
		ircLD_BINE_CENCOSUD in styLD_BINE_CENCOSUD,
		inuLock in number default 0
	)
	IS
		nuSEQUENCE_ID	LD_BINE_CENCOSUD.SEQUENCE_ID%type;
	BEGIN
		if ircLD_BINE_CENCOSUD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_BINE_CENCOSUD.rowid,rcData);
			end if;
			update LD_BINE_CENCOSUD
			set
				PACKAGE_ID = ircLD_BINE_CENCOSUD.PACKAGE_ID,
				PAGARE_ID = ircLD_BINE_CENCOSUD.PAGARE_ID,
				BINE_CENCOSUD_ID = ircLD_BINE_CENCOSUD.BINE_CENCOSUD_ID,
				SERVCODI = ircLD_BINE_CENCOSUD.SERVCODI,
				ID_CONTRATISTA = ircLD_BINE_CENCOSUD.ID_CONTRATISTA,
				BINE_STATUS = ircLD_BINE_CENCOSUD.BINE_STATUS,
				SALE_VALUE_FINANC = ircLD_BINE_CENCOSUD.SALE_VALUE_FINANC,
				CREATION_DATE_APRV = ircLD_BINE_CENCOSUD.CREATION_DATE_APRV,
				BIN_DATE_REPORTED = ircLD_BINE_CENCOSUD.BIN_DATE_REPORTED,
				BIN_FILE_NAME = ircLD_BINE_CENCOSUD.BIN_FILE_NAME,
				TERMINAL = ircLD_BINE_CENCOSUD.TERMINAL,
				PROGRAM = ircLD_BINE_CENCOSUD.PROGRAM,
				LEGALIZATION_DATE = ircLD_BINE_CENCOSUD.LEGALIZATION_DATE,
				USER_NAME = ircLD_BINE_CENCOSUD.USER_NAME,
				ORDER_ID = ircLD_BINE_CENCOSUD.ORDER_ID
			where
				rowid = ircLD_BINE_CENCOSUD.rowid
			returning
				SEQUENCE_ID
			into
				nuSEQUENCE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_BINE_CENCOSUD.SEQUENCE_ID,
					rcData
				);
			end if;

			update LD_BINE_CENCOSUD
			set
				PACKAGE_ID = ircLD_BINE_CENCOSUD.PACKAGE_ID,
				PAGARE_ID = ircLD_BINE_CENCOSUD.PAGARE_ID,
				BINE_CENCOSUD_ID = ircLD_BINE_CENCOSUD.BINE_CENCOSUD_ID,
				SERVCODI = ircLD_BINE_CENCOSUD.SERVCODI,
				ID_CONTRATISTA = ircLD_BINE_CENCOSUD.ID_CONTRATISTA,
				BINE_STATUS = ircLD_BINE_CENCOSUD.BINE_STATUS,
				SALE_VALUE_FINANC = ircLD_BINE_CENCOSUD.SALE_VALUE_FINANC,
				CREATION_DATE_APRV = ircLD_BINE_CENCOSUD.CREATION_DATE_APRV,
				BIN_DATE_REPORTED = ircLD_BINE_CENCOSUD.BIN_DATE_REPORTED,
				BIN_FILE_NAME = ircLD_BINE_CENCOSUD.BIN_FILE_NAME,
				TERMINAL = ircLD_BINE_CENCOSUD.TERMINAL,
				PROGRAM = ircLD_BINE_CENCOSUD.PROGRAM,
				LEGALIZATION_DATE = ircLD_BINE_CENCOSUD.LEGALIZATION_DATE,
				USER_NAME = ircLD_BINE_CENCOSUD.USER_NAME,
				ORDER_ID = ircLD_BINE_CENCOSUD.ORDER_ID
			where
				SEQUENCE_ID = ircLD_BINE_CENCOSUD.SEQUENCE_ID
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_BINE_CENCOSUD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_BINE_CENCOSUD in out nocopy tytbLD_BINE_CENCOSUD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_BINE_CENCOSUD;
	BEGIN
		FillRecordOfTables(iotbLD_BINE_CENCOSUD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last
				update LD_BINE_CENCOSUD
				set
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PAGARE_ID = rcRecOfTab.PAGARE_ID(n),
					BINE_CENCOSUD_ID = rcRecOfTab.BINE_CENCOSUD_ID(n),
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
				for n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last loop
					LockByPk
					(
						rcRecOfTab.SEQUENCE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_BINE_CENCOSUD.first .. iotbLD_BINE_CENCOSUD.last
				update LD_BINE_CENCOSUD
				SET
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PAGARE_ID = rcRecOfTab.PAGARE_ID(n),
					BINE_CENCOSUD_ID = rcRecOfTab.BINE_CENCOSUD_ID(n),
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuPACKAGE_ID$ in LD_BINE_CENCOSUD.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuPAGARE_ID$ in LD_BINE_CENCOSUD.PAGARE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
	PROCEDURE updBINE_CENCOSUD_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbBINE_CENCOSUD_ID$ in LD_BINE_CENCOSUD.BINE_CENCOSUD_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
		set
			BINE_CENCOSUD_ID = isbBINE_CENCOSUD_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BINE_CENCOSUD_ID:= isbBINE_CENCOSUD_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSERVCODI
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuSERVCODI$ in LD_BINE_CENCOSUD.SERVCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuID_CONTRATISTA$ in LD_BINE_CENCOSUD.ID_CONTRATISTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbBINE_STATUS$ in LD_BINE_CENCOSUD.BINE_STATUS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuSALE_VALUE_FINANC$ in LD_BINE_CENCOSUD.SALE_VALUE_FINANC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		idtCREATION_DATE_APRV$ in LD_BINE_CENCOSUD.CREATION_DATE_APRV%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		idtBIN_DATE_REPORTED$ in LD_BINE_CENCOSUD.BIN_DATE_REPORTED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbBIN_FILE_NAME$ in LD_BINE_CENCOSUD.BIN_FILE_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbTERMINAL$ in LD_BINE_CENCOSUD.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbPROGRAM$ in LD_BINE_CENCOSUD.PROGRAM%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		idtLEGALIZATION_DATE$ in LD_BINE_CENCOSUD.LEGALIZATION_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		isbUSER_NAME$ in LD_BINE_CENCOSUD.USER_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuORDER_ID$ in LD_BINE_CENCOSUD.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_BINE_CENCOSUD
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.SEQUENCE_ID%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.PACKAGE_ID%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.PAGARE_ID%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
	FUNCTION fsbGetBINE_CENCOSUD_ID
	(
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BINE_CENCOSUD_ID%type
	IS
		rcError styLD_BINE_CENCOSUD;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.BINE_CENCOSUD_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.BINE_CENCOSUD_ID);
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.SERVCODI%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.ID_CONTRATISTA%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BINE_STATUS%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.SALE_VALUE_FINANC%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.CREATION_DATE_APRV%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BIN_DATE_REPORTED%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.BIN_FILE_NAME%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.TERMINAL%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.PROGRAM%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.LEGALIZATION_DATE%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.USER_NAME%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
		inuSEQUENCE_ID in LD_BINE_CENCOSUD.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_BINE_CENCOSUD.ORDER_ID%type
	IS
		rcError styLD_BINE_CENCOSUD;
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
end DALD_BINE_CENCOSUD;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_BINE_CENCOSUD
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_BINE_CENCOSUD', 'ADM_PERSON'); 
END;
/  
