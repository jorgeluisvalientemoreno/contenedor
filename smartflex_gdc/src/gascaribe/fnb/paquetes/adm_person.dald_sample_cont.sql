CREATE OR REPLACE PACKAGE ADM_PERSON.dald_sample_cont
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : dald_sample_cont
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/  
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	IS
		SELECT LD_SAMPLE_CONT.*,LD_SAMPLE_CONT.rowid
		FROM LD_SAMPLE_CONT
		WHERE
		    ID_SAMPLE_CONT = inuID_SAMPLE_CONT;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_SAMPLE_CONT.*,LD_SAMPLE_CONT.rowid
		FROM LD_SAMPLE_CONT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_SAMPLE_CONT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_SAMPLE_CONT is table of styLD_SAMPLE_CONT index by binary_integer;
	type tyrfRecords is ref cursor return styLD_SAMPLE_CONT;

	/* Tipos referenciando al registro */
	type tytbID_SAMPLE_CONT is table of LD_SAMPLE_CONT.ID_SAMPLE_CONT%type index by binary_integer;
	type tytbSAMPLE_ID is table of LD_SAMPLE_CONT.SAMPLE_ID%type index by binary_integer;
	type tytbINITIAL_RECORD_IDENTIFIER is table of LD_SAMPLE_CONT.INITIAL_RECORD_IDENTIFIER%type index by binary_integer;
	type tytbCODE_OF_SUBSCRIBER is table of LD_SAMPLE_CONT.CODE_OF_SUBSCRIBER%type index by binary_integer;
	type tytbTYPE_ACCOUNT is table of LD_SAMPLE_CONT.TYPE_ACCOUNT%type index by binary_integer;
	type tytbSTATEMENT_DATE is table of LD_SAMPLE_CONT.STATEMENT_DATE%type index by binary_integer;
	type tytbENLARGEMENT_GOALS is table of LD_SAMPLE_CONT.ENLARGEMENT_GOALS%type index by binary_integer;
	type tytbINDICATOR_VALUES_IN_MIL is table of LD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL%type index by binary_integer;
	type tytbTYPE_OF_DELIVERY is table of LD_SAMPLE_CONT.TYPE_OF_DELIVERY%type index by binary_integer;
	type tytbSTAR_REPORT_DATE is table of LD_SAMPLE_CONT.STAR_REPORT_DATE%type index by binary_integer;
	type tytbEND_REPORT_DAT is table of LD_SAMPLE_CONT.END_REPORT_DAT%type index by binary_integer;
	type tytbINDICATOR_FROM is table of LD_SAMPLE_CONT.INDICATOR_FROM%type index by binary_integer;
	type tytbFILLER is table of LD_SAMPLE_CONT.FILLER%type index by binary_integer;
	type tytbTYPE_OF_RECORD is table of LD_SAMPLE_CONT.TYPE_OF_RECORD%type index by binary_integer;
	type tytbCODE_PACKAGE is table of LD_SAMPLE_CONT.CODE_PACKAGE%type index by binary_integer;
	type tytbENTITY_TYPE is table of LD_SAMPLE_CONT.ENTITY_TYPE%type index by binary_integer;
	type tytbENTITY_CODE is table of LD_SAMPLE_CONT.ENTITY_CODE%type index by binary_integer;
	type tytbRESERVED is table of LD_SAMPLE_CONT.RESERVED%type index by binary_integer;
	type tytbTYPE_REPORT is table of LD_SAMPLE_CONT.TYPE_REPORT%type index by binary_integer;
	type tytbCREDIT_BUREAU is table of LD_SAMPLE_CONT.CREDIT_BUREAU%type index by binary_integer;
	type tytbSECTOR_TYPE is table of LD_SAMPLE_CONT.SECTOR_TYPE%type index by binary_integer;
	type tytbPRODUCT_TYPE_ID is table of LD_SAMPLE_CONT.PRODUCT_TYPE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_SAMPLE_CONT is record
	(
		ID_SAMPLE_CONT   tytbID_SAMPLE_CONT,
		SAMPLE_ID   tytbSAMPLE_ID,
		INITIAL_RECORD_IDENTIFIER   tytbINITIAL_RECORD_IDENTIFIER,
		CODE_OF_SUBSCRIBER   tytbCODE_OF_SUBSCRIBER,
		TYPE_ACCOUNT   tytbTYPE_ACCOUNT,
		STATEMENT_DATE   tytbSTATEMENT_DATE,
		ENLARGEMENT_GOALS   tytbENLARGEMENT_GOALS,
		INDICATOR_VALUES_IN_MIL   tytbINDICATOR_VALUES_IN_MIL,
		TYPE_OF_DELIVERY   tytbTYPE_OF_DELIVERY,
		STAR_REPORT_DATE   tytbSTAR_REPORT_DATE,
		END_REPORT_DAT   tytbEND_REPORT_DAT,
		INDICATOR_FROM   tytbINDICATOR_FROM,
		FILLER   tytbFILLER,
		TYPE_OF_RECORD   tytbTYPE_OF_RECORD,
		CODE_PACKAGE   tytbCODE_PACKAGE,
		ENTITY_TYPE   tytbENTITY_TYPE,
		ENTITY_CODE   tytbENTITY_CODE,
		RESERVED   tytbRESERVED,
		TYPE_REPORT   tytbTYPE_REPORT,
		CREDIT_BUREAU   tytbCREDIT_BUREAU,
		SECTOR_TYPE   tytbSECTOR_TYPE,
		PRODUCT_TYPE_ID   tytbPRODUCT_TYPE_ID,
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
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	);

	PROCEDURE getRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		orcRecord out nocopy styLD_SAMPLE_CONT
	);

	FUNCTION frcGetRcData
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN styLD_SAMPLE_CONT;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE_CONT;

	FUNCTION frcGetRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN styLD_SAMPLE_CONT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE_CONT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_SAMPLE_CONT in styLD_SAMPLE_CONT
	);

	PROCEDURE insRecord
	(
		ircLD_SAMPLE_CONT in styLD_SAMPLE_CONT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_SAMPLE_CONT in out nocopy tytbLD_SAMPLE_CONT
	);

	PROCEDURE delRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_SAMPLE_CONT in out nocopy tytbLD_SAMPLE_CONT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_SAMPLE_CONT in styLD_SAMPLE_CONT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_SAMPLE_CONT in out nocopy tytbLD_SAMPLE_CONT,
		inuLock in number default 1
	);

	PROCEDURE updSAMPLE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuSAMPLE_ID$ in LD_SAMPLE_CONT.SAMPLE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updINITIAL_RECORD_IDENTIFIER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbINITIAL_RECORD_IDENTIFIER$ in LD_SAMPLE_CONT.INITIAL_RECORD_IDENTIFIER%type,
		inuLock in number default 0
	);

	PROCEDURE updCODE_OF_SUBSCRIBER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuCODE_OF_SUBSCRIBER$ in LD_SAMPLE_CONT.CODE_OF_SUBSCRIBER%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_ACCOUNT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuTYPE_ACCOUNT$ in LD_SAMPLE_CONT.TYPE_ACCOUNT%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATEMENT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		idtSTATEMENT_DATE$ in LD_SAMPLE_CONT.STATEMENT_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updENLARGEMENT_GOALS
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbENLARGEMENT_GOALS$ in LD_SAMPLE_CONT.ENLARGEMENT_GOALS%type,
		inuLock in number default 0
	);

	PROCEDURE updINDICATOR_VALUES_IN_MIL
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbINDICATOR_VALUES_IN_MIL$ in LD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_OF_DELIVERY
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbTYPE_OF_DELIVERY$ in LD_SAMPLE_CONT.TYPE_OF_DELIVERY%type,
		inuLock in number default 0
	);

	PROCEDURE updSTAR_REPORT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		idtSTAR_REPORT_DATE$ in LD_SAMPLE_CONT.STAR_REPORT_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updEND_REPORT_DAT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		idtEND_REPORT_DAT$ in LD_SAMPLE_CONT.END_REPORT_DAT%type,
		inuLock in number default 0
	);

	PROCEDURE updINDICATOR_FROM
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbINDICATOR_FROM$ in LD_SAMPLE_CONT.INDICATOR_FROM%type,
		inuLock in number default 0
	);

	PROCEDURE updFILLER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbFILLER$ in LD_SAMPLE_CONT.FILLER%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_OF_RECORD
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuTYPE_OF_RECORD$ in LD_SAMPLE_CONT.TYPE_OF_RECORD%type,
		inuLock in number default 0
	);

	PROCEDURE updCODE_PACKAGE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbCODE_PACKAGE$ in LD_SAMPLE_CONT.CODE_PACKAGE%type,
		inuLock in number default 0
	);

	PROCEDURE updENTITY_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuENTITY_TYPE$ in LD_SAMPLE_CONT.ENTITY_TYPE%type,
		inuLock in number default 0
	);

	PROCEDURE updENTITY_CODE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuENTITY_CODE$ in LD_SAMPLE_CONT.ENTITY_CODE%type,
		inuLock in number default 0
	);

	PROCEDURE updRESERVED
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbRESERVED$ in LD_SAMPLE_CONT.RESERVED%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_REPORT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuTYPE_REPORT$ in LD_SAMPLE_CONT.TYPE_REPORT%type,
		inuLock in number default 0
	);

	PROCEDURE updCREDIT_BUREAU
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuCREDIT_BUREAU$ in LD_SAMPLE_CONT.CREDIT_BUREAU%type,
		inuLock in number default 0
	);

	PROCEDURE updSECTOR_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbSECTOR_TYPE$ in LD_SAMPLE_CONT.SECTOR_TYPE%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_TYPE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbPRODUCT_TYPE_ID$ in LD_SAMPLE_CONT.PRODUCT_TYPE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_SAMPLE_CONT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ID_SAMPLE_CONT%type;

	FUNCTION fnuGetSAMPLE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.SAMPLE_ID%type;

	FUNCTION fnuGetCODE_OF_SUBSCRIBER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.CODE_OF_SUBSCRIBER%type;

	FUNCTION fnuGetTYPE_ACCOUNT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_ACCOUNT%type;

	FUNCTION fdtGetSTATEMENT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.STATEMENT_DATE%type;

	FUNCTION fsbGetENLARGEMENT_GOALS
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ENLARGEMENT_GOALS%type;

	FUNCTION fsbGetINDICATOR_VALUES_IN_MIL
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL%type;

	FUNCTION fsbGetTYPE_OF_DELIVERY
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_OF_DELIVERY%type;

	FUNCTION fdtGetSTAR_REPORT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.STAR_REPORT_DATE%type;

	FUNCTION fdtGetEND_REPORT_DAT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.END_REPORT_DAT%type;

	FUNCTION fsbGetINDICATOR_FROM
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.INDICATOR_FROM%type;

	FUNCTION fsbGetFILLER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.FILLER%type;

	FUNCTION fnuGetTYPE_OF_RECORD
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_OF_RECORD%type;

	FUNCTION fsbGetCODE_PACKAGE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.CODE_PACKAGE%type;

	FUNCTION fnuGetENTITY_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ENTITY_TYPE%type;

	FUNCTION fnuGetENTITY_CODE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ENTITY_CODE%type;

	FUNCTION fsbGetRESERVED
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.RESERVED%type;

	FUNCTION fnuGetTYPE_REPORT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_REPORT%type;

	FUNCTION fnuGetCREDIT_BUREAU
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.CREDIT_BUREAU%type;

	FUNCTION fsbGetSECTOR_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.SECTOR_TYPE%type;

	FUNCTION fsbGetPRODUCT_TYPE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.PRODUCT_TYPE_ID%type;


	PROCEDURE LockByPk
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		orcLD_SAMPLE_CONT  out styLD_SAMPLE_CONT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_SAMPLE_CONT  out styLD_SAMPLE_CONT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_SAMPLE_CONT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.dald_sample_cont
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SAMPLE_CONT';
	 cnuGeEntityId constant varchar2(30) := 8285; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	IS
		SELECT LD_SAMPLE_CONT.*,LD_SAMPLE_CONT.rowid
		FROM LD_SAMPLE_CONT
		WHERE  ID_SAMPLE_CONT = inuID_SAMPLE_CONT
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_SAMPLE_CONT.*,LD_SAMPLE_CONT.rowid
		FROM LD_SAMPLE_CONT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_SAMPLE_CONT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_SAMPLE_CONT;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_SAMPLE_CONT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_SAMPLE_CONT);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		orcLD_SAMPLE_CONT  out styLD_SAMPLE_CONT
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

		Open cuLockRcByPk
		(
			inuID_SAMPLE_CONT
		);

		fetch cuLockRcByPk into orcLD_SAMPLE_CONT;
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
		orcLD_SAMPLE_CONT  out styLD_SAMPLE_CONT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_SAMPLE_CONT;
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
		itbLD_SAMPLE_CONT  in out nocopy tytbLD_SAMPLE_CONT
	)
	IS
	BEGIN
			rcRecOfTab.ID_SAMPLE_CONT.delete;
			rcRecOfTab.SAMPLE_ID.delete;
			rcRecOfTab.INITIAL_RECORD_IDENTIFIER.delete;
			rcRecOfTab.CODE_OF_SUBSCRIBER.delete;
			rcRecOfTab.TYPE_ACCOUNT.delete;
			rcRecOfTab.STATEMENT_DATE.delete;
			rcRecOfTab.ENLARGEMENT_GOALS.delete;
			rcRecOfTab.INDICATOR_VALUES_IN_MIL.delete;
			rcRecOfTab.TYPE_OF_DELIVERY.delete;
			rcRecOfTab.STAR_REPORT_DATE.delete;
			rcRecOfTab.END_REPORT_DAT.delete;
			rcRecOfTab.INDICATOR_FROM.delete;
			rcRecOfTab.FILLER.delete;
			rcRecOfTab.TYPE_OF_RECORD.delete;
			rcRecOfTab.CODE_PACKAGE.delete;
			rcRecOfTab.ENTITY_TYPE.delete;
			rcRecOfTab.ENTITY_CODE.delete;
			rcRecOfTab.RESERVED.delete;
			rcRecOfTab.TYPE_REPORT.delete;
			rcRecOfTab.CREDIT_BUREAU.delete;
			rcRecOfTab.SECTOR_TYPE.delete;
			rcRecOfTab.PRODUCT_TYPE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_SAMPLE_CONT  in out nocopy tytbLD_SAMPLE_CONT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_SAMPLE_CONT);

		for n in itbLD_SAMPLE_CONT.first .. itbLD_SAMPLE_CONT.last loop
			rcRecOfTab.ID_SAMPLE_CONT(n) := itbLD_SAMPLE_CONT(n).ID_SAMPLE_CONT;
			rcRecOfTab.SAMPLE_ID(n) := itbLD_SAMPLE_CONT(n).SAMPLE_ID;
			rcRecOfTab.INITIAL_RECORD_IDENTIFIER(n) := itbLD_SAMPLE_CONT(n).INITIAL_RECORD_IDENTIFIER;
			rcRecOfTab.CODE_OF_SUBSCRIBER(n) := itbLD_SAMPLE_CONT(n).CODE_OF_SUBSCRIBER;
			rcRecOfTab.TYPE_ACCOUNT(n) := itbLD_SAMPLE_CONT(n).TYPE_ACCOUNT;
			rcRecOfTab.STATEMENT_DATE(n) := itbLD_SAMPLE_CONT(n).STATEMENT_DATE;
			rcRecOfTab.ENLARGEMENT_GOALS(n) := itbLD_SAMPLE_CONT(n).ENLARGEMENT_GOALS;
			rcRecOfTab.INDICATOR_VALUES_IN_MIL(n) := itbLD_SAMPLE_CONT(n).INDICATOR_VALUES_IN_MIL;
			rcRecOfTab.TYPE_OF_DELIVERY(n) := itbLD_SAMPLE_CONT(n).TYPE_OF_DELIVERY;
			rcRecOfTab.STAR_REPORT_DATE(n) := itbLD_SAMPLE_CONT(n).STAR_REPORT_DATE;
			rcRecOfTab.END_REPORT_DAT(n) := itbLD_SAMPLE_CONT(n).END_REPORT_DAT;
			rcRecOfTab.INDICATOR_FROM(n) := itbLD_SAMPLE_CONT(n).INDICATOR_FROM;
			rcRecOfTab.FILLER(n) := itbLD_SAMPLE_CONT(n).FILLER;
			rcRecOfTab.TYPE_OF_RECORD(n) := itbLD_SAMPLE_CONT(n).TYPE_OF_RECORD;
			rcRecOfTab.CODE_PACKAGE(n) := itbLD_SAMPLE_CONT(n).CODE_PACKAGE;
			rcRecOfTab.ENTITY_TYPE(n) := itbLD_SAMPLE_CONT(n).ENTITY_TYPE;
			rcRecOfTab.ENTITY_CODE(n) := itbLD_SAMPLE_CONT(n).ENTITY_CODE;
			rcRecOfTab.RESERVED(n) := itbLD_SAMPLE_CONT(n).RESERVED;
			rcRecOfTab.TYPE_REPORT(n) := itbLD_SAMPLE_CONT(n).TYPE_REPORT;
			rcRecOfTab.CREDIT_BUREAU(n) := itbLD_SAMPLE_CONT(n).CREDIT_BUREAU;
			rcRecOfTab.SECTOR_TYPE(n) := itbLD_SAMPLE_CONT(n).SECTOR_TYPE;
			rcRecOfTab.PRODUCT_TYPE_ID(n) := itbLD_SAMPLE_CONT(n).PRODUCT_TYPE_ID;
			rcRecOfTab.row_id(n) := itbLD_SAMPLE_CONT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_SAMPLE_CONT
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
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_SAMPLE_CONT = rcData.ID_SAMPLE_CONT
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
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_SAMPLE_CONT
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN		rcError.ID_SAMPLE_CONT:=inuID_SAMPLE_CONT;

		Load
		(
			inuID_SAMPLE_CONT
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
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	IS
	BEGIN
		Load
		(
			inuID_SAMPLE_CONT
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		orcRecord out nocopy styLD_SAMPLE_CONT
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN		rcError.ID_SAMPLE_CONT:=inuID_SAMPLE_CONT;

		Load
		(
			inuID_SAMPLE_CONT
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN styLD_SAMPLE_CONT
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT:=inuID_SAMPLE_CONT;

		Load
		(
			inuID_SAMPLE_CONT
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	)
	RETURN styLD_SAMPLE_CONT
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT:=inuID_SAMPLE_CONT;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_SAMPLE_CONT
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_SAMPLE_CONT
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE_CONT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE_CONT
	)
	IS
		rfLD_SAMPLE_CONT tyrfLD_SAMPLE_CONT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_SAMPLE_CONT.*, LD_SAMPLE_CONT.rowid FROM LD_SAMPLE_CONT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_SAMPLE_CONT for sbFullQuery;

		fetch rfLD_SAMPLE_CONT bulk collect INTO otbResult;

		close rfLD_SAMPLE_CONT;
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
		sbSQL VARCHAR2 (32000) := 'select LD_SAMPLE_CONT.*, LD_SAMPLE_CONT.rowid FROM LD_SAMPLE_CONT';
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
		ircLD_SAMPLE_CONT in styLD_SAMPLE_CONT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_SAMPLE_CONT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_SAMPLE_CONT in styLD_SAMPLE_CONT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_SAMPLE_CONT.ID_SAMPLE_CONT is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_SAMPLE_CONT');
			raise ex.controlled_error;
		end if;

		insert into LD_SAMPLE_CONT
		(
			ID_SAMPLE_CONT,
			SAMPLE_ID,
			INITIAL_RECORD_IDENTIFIER,
			CODE_OF_SUBSCRIBER,
			TYPE_ACCOUNT,
			STATEMENT_DATE,
			ENLARGEMENT_GOALS,
			INDICATOR_VALUES_IN_MIL,
			TYPE_OF_DELIVERY,
			STAR_REPORT_DATE,
			END_REPORT_DAT,
			INDICATOR_FROM,
			FILLER,
			TYPE_OF_RECORD,
			CODE_PACKAGE,
			ENTITY_TYPE,
			ENTITY_CODE,
			RESERVED,
			TYPE_REPORT,
			CREDIT_BUREAU,
			SECTOR_TYPE,
			PRODUCT_TYPE_ID
		)
		values
		(
			ircLD_SAMPLE_CONT.ID_SAMPLE_CONT,
			ircLD_SAMPLE_CONT.SAMPLE_ID,
			ircLD_SAMPLE_CONT.INITIAL_RECORD_IDENTIFIER,
			ircLD_SAMPLE_CONT.CODE_OF_SUBSCRIBER,
			ircLD_SAMPLE_CONT.TYPE_ACCOUNT,
			ircLD_SAMPLE_CONT.STATEMENT_DATE,
			ircLD_SAMPLE_CONT.ENLARGEMENT_GOALS,
			ircLD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL,
			ircLD_SAMPLE_CONT.TYPE_OF_DELIVERY,
			ircLD_SAMPLE_CONT.STAR_REPORT_DATE,
			ircLD_SAMPLE_CONT.END_REPORT_DAT,
			ircLD_SAMPLE_CONT.INDICATOR_FROM,
			ircLD_SAMPLE_CONT.FILLER,
			ircLD_SAMPLE_CONT.TYPE_OF_RECORD,
			ircLD_SAMPLE_CONT.CODE_PACKAGE,
			ircLD_SAMPLE_CONT.ENTITY_TYPE,
			ircLD_SAMPLE_CONT.ENTITY_CODE,
			ircLD_SAMPLE_CONT.RESERVED,
			ircLD_SAMPLE_CONT.TYPE_REPORT,
			ircLD_SAMPLE_CONT.CREDIT_BUREAU,
			ircLD_SAMPLE_CONT.SECTOR_TYPE,
			ircLD_SAMPLE_CONT.PRODUCT_TYPE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_SAMPLE_CONT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_SAMPLE_CONT in out nocopy tytbLD_SAMPLE_CONT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_CONT,blUseRowID);
		forall n in iotbLD_SAMPLE_CONT.first..iotbLD_SAMPLE_CONT.last
			insert into LD_SAMPLE_CONT
			(
				ID_SAMPLE_CONT,
				SAMPLE_ID,
				INITIAL_RECORD_IDENTIFIER,
				CODE_OF_SUBSCRIBER,
				TYPE_ACCOUNT,
				STATEMENT_DATE,
				ENLARGEMENT_GOALS,
				INDICATOR_VALUES_IN_MIL,
				TYPE_OF_DELIVERY,
				STAR_REPORT_DATE,
				END_REPORT_DAT,
				INDICATOR_FROM,
				FILLER,
				TYPE_OF_RECORD,
				CODE_PACKAGE,
				ENTITY_TYPE,
				ENTITY_CODE,
				RESERVED,
				TYPE_REPORT,
				CREDIT_BUREAU,
				SECTOR_TYPE,
				PRODUCT_TYPE_ID
			)
			values
			(
				rcRecOfTab.ID_SAMPLE_CONT(n),
				rcRecOfTab.SAMPLE_ID(n),
				rcRecOfTab.INITIAL_RECORD_IDENTIFIER(n),
				rcRecOfTab.CODE_OF_SUBSCRIBER(n),
				rcRecOfTab.TYPE_ACCOUNT(n),
				rcRecOfTab.STATEMENT_DATE(n),
				rcRecOfTab.ENLARGEMENT_GOALS(n),
				rcRecOfTab.INDICATOR_VALUES_IN_MIL(n),
				rcRecOfTab.TYPE_OF_DELIVERY(n),
				rcRecOfTab.STAR_REPORT_DATE(n),
				rcRecOfTab.END_REPORT_DAT(n),
				rcRecOfTab.INDICATOR_FROM(n),
				rcRecOfTab.FILLER(n),
				rcRecOfTab.TYPE_OF_RECORD(n),
				rcRecOfTab.CODE_PACKAGE(n),
				rcRecOfTab.ENTITY_TYPE(n),
				rcRecOfTab.ENTITY_CODE(n),
				rcRecOfTab.RESERVED(n),
				rcRecOfTab.TYPE_REPORT(n),
				rcRecOfTab.CREDIT_BUREAU(n),
				rcRecOfTab.SECTOR_TYPE(n),
				rcRecOfTab.PRODUCT_TYPE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;


		delete
		from LD_SAMPLE_CONT
		where
       		ID_SAMPLE_CONT=inuID_SAMPLE_CONT;
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
		rcError  styLD_SAMPLE_CONT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_SAMPLE_CONT
		where
			rowid = iriRowID
		returning
			ID_SAMPLE_CONT
		into
			rcError.ID_SAMPLE_CONT;
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
		iotbLD_SAMPLE_CONT in out nocopy tytbLD_SAMPLE_CONT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE_CONT;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_CONT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last
				delete
				from LD_SAMPLE_CONT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last loop
					LockByPk
					(
						rcRecOfTab.ID_SAMPLE_CONT(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last
				delete
				from LD_SAMPLE_CONT
				where
		         	ID_SAMPLE_CONT = rcRecOfTab.ID_SAMPLE_CONT(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_SAMPLE_CONT in styLD_SAMPLE_CONT,
		inuLock in number default 0
	)
	IS
		nuID_SAMPLE_CONT	LD_SAMPLE_CONT.ID_SAMPLE_CONT%type;
	BEGIN
		if ircLD_SAMPLE_CONT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_SAMPLE_CONT.rowid,rcData);
			end if;
			update LD_SAMPLE_CONT
			set
				SAMPLE_ID = ircLD_SAMPLE_CONT.SAMPLE_ID,
				INITIAL_RECORD_IDENTIFIER = ircLD_SAMPLE_CONT.INITIAL_RECORD_IDENTIFIER,
				CODE_OF_SUBSCRIBER = ircLD_SAMPLE_CONT.CODE_OF_SUBSCRIBER,
				TYPE_ACCOUNT = ircLD_SAMPLE_CONT.TYPE_ACCOUNT,
				STATEMENT_DATE = ircLD_SAMPLE_CONT.STATEMENT_DATE,
				ENLARGEMENT_GOALS = ircLD_SAMPLE_CONT.ENLARGEMENT_GOALS,
				INDICATOR_VALUES_IN_MIL = ircLD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL,
				TYPE_OF_DELIVERY = ircLD_SAMPLE_CONT.TYPE_OF_DELIVERY,
				STAR_REPORT_DATE = ircLD_SAMPLE_CONT.STAR_REPORT_DATE,
				END_REPORT_DAT = ircLD_SAMPLE_CONT.END_REPORT_DAT,
				INDICATOR_FROM = ircLD_SAMPLE_CONT.INDICATOR_FROM,
				FILLER = ircLD_SAMPLE_CONT.FILLER,
				TYPE_OF_RECORD = ircLD_SAMPLE_CONT.TYPE_OF_RECORD,
				CODE_PACKAGE = ircLD_SAMPLE_CONT.CODE_PACKAGE,
				ENTITY_TYPE = ircLD_SAMPLE_CONT.ENTITY_TYPE,
				ENTITY_CODE = ircLD_SAMPLE_CONT.ENTITY_CODE,
				RESERVED = ircLD_SAMPLE_CONT.RESERVED,
				TYPE_REPORT = ircLD_SAMPLE_CONT.TYPE_REPORT,
				CREDIT_BUREAU = ircLD_SAMPLE_CONT.CREDIT_BUREAU,
				SECTOR_TYPE = ircLD_SAMPLE_CONT.SECTOR_TYPE,
				PRODUCT_TYPE_ID = ircLD_SAMPLE_CONT.PRODUCT_TYPE_ID
			where
				rowid = ircLD_SAMPLE_CONT.rowid
			returning
				ID_SAMPLE_CONT
			into
				nuID_SAMPLE_CONT;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_SAMPLE_CONT.ID_SAMPLE_CONT,
					rcData
				);
			end if;

			update LD_SAMPLE_CONT
			set
				SAMPLE_ID = ircLD_SAMPLE_CONT.SAMPLE_ID,
				INITIAL_RECORD_IDENTIFIER = ircLD_SAMPLE_CONT.INITIAL_RECORD_IDENTIFIER,
				CODE_OF_SUBSCRIBER = ircLD_SAMPLE_CONT.CODE_OF_SUBSCRIBER,
				TYPE_ACCOUNT = ircLD_SAMPLE_CONT.TYPE_ACCOUNT,
				STATEMENT_DATE = ircLD_SAMPLE_CONT.STATEMENT_DATE,
				ENLARGEMENT_GOALS = ircLD_SAMPLE_CONT.ENLARGEMENT_GOALS,
				INDICATOR_VALUES_IN_MIL = ircLD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL,
				TYPE_OF_DELIVERY = ircLD_SAMPLE_CONT.TYPE_OF_DELIVERY,
				STAR_REPORT_DATE = ircLD_SAMPLE_CONT.STAR_REPORT_DATE,
				END_REPORT_DAT = ircLD_SAMPLE_CONT.END_REPORT_DAT,
				INDICATOR_FROM = ircLD_SAMPLE_CONT.INDICATOR_FROM,
				FILLER = ircLD_SAMPLE_CONT.FILLER,
				TYPE_OF_RECORD = ircLD_SAMPLE_CONT.TYPE_OF_RECORD,
				CODE_PACKAGE = ircLD_SAMPLE_CONT.CODE_PACKAGE,
				ENTITY_TYPE = ircLD_SAMPLE_CONT.ENTITY_TYPE,
				ENTITY_CODE = ircLD_SAMPLE_CONT.ENTITY_CODE,
				RESERVED = ircLD_SAMPLE_CONT.RESERVED,
				TYPE_REPORT = ircLD_SAMPLE_CONT.TYPE_REPORT,
				CREDIT_BUREAU = ircLD_SAMPLE_CONT.CREDIT_BUREAU,
				SECTOR_TYPE = ircLD_SAMPLE_CONT.SECTOR_TYPE,
				PRODUCT_TYPE_ID = ircLD_SAMPLE_CONT.PRODUCT_TYPE_ID
			where
				ID_SAMPLE_CONT = ircLD_SAMPLE_CONT.ID_SAMPLE_CONT
			returning
				ID_SAMPLE_CONT
			into
				nuID_SAMPLE_CONT;
		end if;
		if
			nuID_SAMPLE_CONT is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_SAMPLE_CONT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_SAMPLE_CONT in out nocopy tytbLD_SAMPLE_CONT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE_CONT;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_CONT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last
				update LD_SAMPLE_CONT
				set
					SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n),
					INITIAL_RECORD_IDENTIFIER = rcRecOfTab.INITIAL_RECORD_IDENTIFIER(n),
					CODE_OF_SUBSCRIBER = rcRecOfTab.CODE_OF_SUBSCRIBER(n),
					TYPE_ACCOUNT = rcRecOfTab.TYPE_ACCOUNT(n),
					STATEMENT_DATE = rcRecOfTab.STATEMENT_DATE(n),
					ENLARGEMENT_GOALS = rcRecOfTab.ENLARGEMENT_GOALS(n),
					INDICATOR_VALUES_IN_MIL = rcRecOfTab.INDICATOR_VALUES_IN_MIL(n),
					TYPE_OF_DELIVERY = rcRecOfTab.TYPE_OF_DELIVERY(n),
					STAR_REPORT_DATE = rcRecOfTab.STAR_REPORT_DATE(n),
					END_REPORT_DAT = rcRecOfTab.END_REPORT_DAT(n),
					INDICATOR_FROM = rcRecOfTab.INDICATOR_FROM(n),
					FILLER = rcRecOfTab.FILLER(n),
					TYPE_OF_RECORD = rcRecOfTab.TYPE_OF_RECORD(n),
					CODE_PACKAGE = rcRecOfTab.CODE_PACKAGE(n),
					ENTITY_TYPE = rcRecOfTab.ENTITY_TYPE(n),
					ENTITY_CODE = rcRecOfTab.ENTITY_CODE(n),
					RESERVED = rcRecOfTab.RESERVED(n),
					TYPE_REPORT = rcRecOfTab.TYPE_REPORT(n),
					CREDIT_BUREAU = rcRecOfTab.CREDIT_BUREAU(n),
					SECTOR_TYPE = rcRecOfTab.SECTOR_TYPE(n),
					PRODUCT_TYPE_ID = rcRecOfTab.PRODUCT_TYPE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last loop
					LockByPk
					(
						rcRecOfTab.ID_SAMPLE_CONT(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_CONT.first .. iotbLD_SAMPLE_CONT.last
				update LD_SAMPLE_CONT
				SET
					SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n),
					INITIAL_RECORD_IDENTIFIER = rcRecOfTab.INITIAL_RECORD_IDENTIFIER(n),
					CODE_OF_SUBSCRIBER = rcRecOfTab.CODE_OF_SUBSCRIBER(n),
					TYPE_ACCOUNT = rcRecOfTab.TYPE_ACCOUNT(n),
					STATEMENT_DATE = rcRecOfTab.STATEMENT_DATE(n),
					ENLARGEMENT_GOALS = rcRecOfTab.ENLARGEMENT_GOALS(n),
					INDICATOR_VALUES_IN_MIL = rcRecOfTab.INDICATOR_VALUES_IN_MIL(n),
					TYPE_OF_DELIVERY = rcRecOfTab.TYPE_OF_DELIVERY(n),
					STAR_REPORT_DATE = rcRecOfTab.STAR_REPORT_DATE(n),
					END_REPORT_DAT = rcRecOfTab.END_REPORT_DAT(n),
					INDICATOR_FROM = rcRecOfTab.INDICATOR_FROM(n),
					FILLER = rcRecOfTab.FILLER(n),
					TYPE_OF_RECORD = rcRecOfTab.TYPE_OF_RECORD(n),
					CODE_PACKAGE = rcRecOfTab.CODE_PACKAGE(n),
					ENTITY_TYPE = rcRecOfTab.ENTITY_TYPE(n),
					ENTITY_CODE = rcRecOfTab.ENTITY_CODE(n),
					RESERVED = rcRecOfTab.RESERVED(n),
					TYPE_REPORT = rcRecOfTab.TYPE_REPORT(n),
					CREDIT_BUREAU = rcRecOfTab.CREDIT_BUREAU(n),
					SECTOR_TYPE = rcRecOfTab.SECTOR_TYPE(n),
					PRODUCT_TYPE_ID = rcRecOfTab.PRODUCT_TYPE_ID(n)
				where
					ID_SAMPLE_CONT = rcRecOfTab.ID_SAMPLE_CONT(n)
;
		end if;
	END;
	PROCEDURE updSAMPLE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuSAMPLE_ID$ in LD_SAMPLE_CONT.SAMPLE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			SAMPLE_ID = inuSAMPLE_ID$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SAMPLE_ID:= inuSAMPLE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINITIAL_RECORD_IDENTIFIER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbINITIAL_RECORD_IDENTIFIER$ in LD_SAMPLE_CONT.INITIAL_RECORD_IDENTIFIER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			INITIAL_RECORD_IDENTIFIER = isbINITIAL_RECORD_IDENTIFIER$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INITIAL_RECORD_IDENTIFIER:= isbINITIAL_RECORD_IDENTIFIER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCODE_OF_SUBSCRIBER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuCODE_OF_SUBSCRIBER$ in LD_SAMPLE_CONT.CODE_OF_SUBSCRIBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			CODE_OF_SUBSCRIBER = inuCODE_OF_SUBSCRIBER$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CODE_OF_SUBSCRIBER:= inuCODE_OF_SUBSCRIBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_ACCOUNT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuTYPE_ACCOUNT$ in LD_SAMPLE_CONT.TYPE_ACCOUNT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			TYPE_ACCOUNT = inuTYPE_ACCOUNT$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_ACCOUNT:= inuTYPE_ACCOUNT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATEMENT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		idtSTATEMENT_DATE$ in LD_SAMPLE_CONT.STATEMENT_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			STATEMENT_DATE = idtSTATEMENT_DATE$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATEMENT_DATE:= idtSTATEMENT_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updENLARGEMENT_GOALS
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbENLARGEMENT_GOALS$ in LD_SAMPLE_CONT.ENLARGEMENT_GOALS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			ENLARGEMENT_GOALS = isbENLARGEMENT_GOALS$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ENLARGEMENT_GOALS:= isbENLARGEMENT_GOALS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINDICATOR_VALUES_IN_MIL
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbINDICATOR_VALUES_IN_MIL$ in LD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			INDICATOR_VALUES_IN_MIL = isbINDICATOR_VALUES_IN_MIL$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INDICATOR_VALUES_IN_MIL:= isbINDICATOR_VALUES_IN_MIL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_OF_DELIVERY
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbTYPE_OF_DELIVERY$ in LD_SAMPLE_CONT.TYPE_OF_DELIVERY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			TYPE_OF_DELIVERY = isbTYPE_OF_DELIVERY$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_OF_DELIVERY:= isbTYPE_OF_DELIVERY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTAR_REPORT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		idtSTAR_REPORT_DATE$ in LD_SAMPLE_CONT.STAR_REPORT_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			STAR_REPORT_DATE = idtSTAR_REPORT_DATE$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STAR_REPORT_DATE:= idtSTAR_REPORT_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEND_REPORT_DAT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		idtEND_REPORT_DAT$ in LD_SAMPLE_CONT.END_REPORT_DAT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			END_REPORT_DAT = idtEND_REPORT_DAT$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.END_REPORT_DAT:= idtEND_REPORT_DAT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINDICATOR_FROM
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbINDICATOR_FROM$ in LD_SAMPLE_CONT.INDICATOR_FROM%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			INDICATOR_FROM = isbINDICATOR_FROM$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INDICATOR_FROM:= isbINDICATOR_FROM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFILLER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbFILLER$ in LD_SAMPLE_CONT.FILLER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			FILLER = isbFILLER$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FILLER:= isbFILLER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_OF_RECORD
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuTYPE_OF_RECORD$ in LD_SAMPLE_CONT.TYPE_OF_RECORD%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			TYPE_OF_RECORD = inuTYPE_OF_RECORD$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_OF_RECORD:= inuTYPE_OF_RECORD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCODE_PACKAGE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbCODE_PACKAGE$ in LD_SAMPLE_CONT.CODE_PACKAGE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			CODE_PACKAGE = isbCODE_PACKAGE$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CODE_PACKAGE:= isbCODE_PACKAGE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updENTITY_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuENTITY_TYPE$ in LD_SAMPLE_CONT.ENTITY_TYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			ENTITY_TYPE = inuENTITY_TYPE$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ENTITY_TYPE:= inuENTITY_TYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updENTITY_CODE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuENTITY_CODE$ in LD_SAMPLE_CONT.ENTITY_CODE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			ENTITY_CODE = inuENTITY_CODE$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ENTITY_CODE:= inuENTITY_CODE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESERVED
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbRESERVED$ in LD_SAMPLE_CONT.RESERVED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			RESERVED = isbRESERVED$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESERVED:= isbRESERVED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_REPORT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuTYPE_REPORT$ in LD_SAMPLE_CONT.TYPE_REPORT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			TYPE_REPORT = inuTYPE_REPORT$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_REPORT:= inuTYPE_REPORT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCREDIT_BUREAU
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuCREDIT_BUREAU$ in LD_SAMPLE_CONT.CREDIT_BUREAU%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			CREDIT_BUREAU = inuCREDIT_BUREAU$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREDIT_BUREAU:= inuCREDIT_BUREAU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSECTOR_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbSECTOR_TYPE$ in LD_SAMPLE_CONT.SECTOR_TYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			SECTOR_TYPE = isbSECTOR_TYPE$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SECTOR_TYPE:= isbSECTOR_TYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_TYPE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		isbPRODUCT_TYPE_ID$ in LD_SAMPLE_CONT.PRODUCT_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN
		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;
		if inuLock=1 then
			LockByPk
			(
				inuID_SAMPLE_CONT,
				rcData
			);
		end if;

		update LD_SAMPLE_CONT
		set
			PRODUCT_TYPE_ID = isbPRODUCT_TYPE_ID$
		where
			ID_SAMPLE_CONT = inuID_SAMPLE_CONT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_TYPE_ID:= isbPRODUCT_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_SAMPLE_CONT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ID_SAMPLE_CONT%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.ID_SAMPLE_CONT);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.ID_SAMPLE_CONT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSAMPLE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.SAMPLE_ID%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.SAMPLE_ID);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.SAMPLE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCODE_OF_SUBSCRIBER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.CODE_OF_SUBSCRIBER%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.CODE_OF_SUBSCRIBER);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.CODE_OF_SUBSCRIBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_ACCOUNT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_ACCOUNT%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.TYPE_ACCOUNT);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.TYPE_ACCOUNT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetSTATEMENT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.STATEMENT_DATE%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.STATEMENT_DATE);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.STATEMENT_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetENLARGEMENT_GOALS
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ENLARGEMENT_GOALS%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.ENLARGEMENT_GOALS);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.ENLARGEMENT_GOALS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetINDICATOR_VALUES_IN_MIL
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.INDICATOR_VALUES_IN_MIL%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.INDICATOR_VALUES_IN_MIL);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.INDICATOR_VALUES_IN_MIL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTYPE_OF_DELIVERY
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_OF_DELIVERY%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.TYPE_OF_DELIVERY);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.TYPE_OF_DELIVERY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetSTAR_REPORT_DATE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.STAR_REPORT_DATE%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.STAR_REPORT_DATE);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.STAR_REPORT_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetEND_REPORT_DAT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.END_REPORT_DAT%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.END_REPORT_DAT);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.END_REPORT_DAT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetINDICATOR_FROM
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.INDICATOR_FROM%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.INDICATOR_FROM);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.INDICATOR_FROM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFILLER
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.FILLER%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.FILLER);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.FILLER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_OF_RECORD
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_OF_RECORD%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.TYPE_OF_RECORD);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.TYPE_OF_RECORD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCODE_PACKAGE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.CODE_PACKAGE%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.CODE_PACKAGE);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.CODE_PACKAGE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetENTITY_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ENTITY_TYPE%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.ENTITY_TYPE);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.ENTITY_TYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetENTITY_CODE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.ENTITY_CODE%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.ENTITY_CODE);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.ENTITY_CODE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESERVED
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.RESERVED%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.RESERVED);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.RESERVED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_REPORT
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.TYPE_REPORT%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.TYPE_REPORT);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.TYPE_REPORT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCREDIT_BUREAU
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.CREDIT_BUREAU%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.CREDIT_BUREAU);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.CREDIT_BUREAU);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSECTOR_TYPE
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.SECTOR_TYPE%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.SECTOR_TYPE);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.SECTOR_TYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPRODUCT_TYPE_ID
	(
		inuID_SAMPLE_CONT in LD_SAMPLE_CONT.ID_SAMPLE_CONT%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_CONT.PRODUCT_TYPE_ID%type
	IS
		rcError styLD_SAMPLE_CONT;
	BEGIN

		rcError.ID_SAMPLE_CONT := inuID_SAMPLE_CONT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SAMPLE_CONT
			 )
		then
			 return(rcData.PRODUCT_TYPE_ID);
		end if;
		Load
		(
		 		inuID_SAMPLE_CONT
		);
		return(rcData.PRODUCT_TYPE_ID);
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
end DALD_SAMPLE_CONT;
/
PROMPT Otorgando permisos de ejecucion a DALD_SAMPLE_CONT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SAMPLE_CONT', 'ADM_PERSON');
END;
/
