CREATE OR REPLACE PACKAGE adm_person.DALD_SUPPLI_SETTINGS
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
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	IS
		SELECT LD_SUPPLI_SETTINGS.*,LD_SUPPLI_SETTINGS.rowid
		FROM LD_SUPPLI_SETTINGS
		WHERE
		    SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_SUPPLI_SETTINGS.*,LD_SUPPLI_SETTINGS.rowid
		FROM LD_SUPPLI_SETTINGS
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_SUPPLI_SETTINGS  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_SUPPLI_SETTINGS is table of styLD_SUPPLI_SETTINGS index by binary_integer;
	type tyrfRecords is ref cursor return styLD_SUPPLI_SETTINGS;

	/* Tipos referenciando al registro */
	type tytbVIEW_ITEM_CARDIF is table of LD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF%type index by binary_integer;
	type tytbSUPPLI_SETTINGS_ID is table of LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type index by binary_integer;
	type tytbSUPPLIER_ID is table of LD_SUPPLI_SETTINGS.SUPPLIER_ID%type index by binary_integer;
	type tytbTYPE_PROMISS_NOTE is table of LD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE%type index by binary_integer;
	type tytbSEL_SALES_CHANNEL is table of LD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL%type index by binary_integer;
	type tytbDEFAULT_CHAN_SALE is table of LD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE%type index by binary_integer;
	type tytbLEG_DELIV_ORDE_AUTO is table of LD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO%type index by binary_integer;
	type tytbDELIV_IN_POINT is table of LD_SUPPLI_SETTINGS.DELIV_IN_POINT%type index by binary_integer;
	type tytbMIN_FOR_DELIVERY is table of LD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY%type index by binary_integer;
	type tytbPOST_LEG_PROCESS is table of LD_SUPPLI_SETTINGS.POST_LEG_PROCESS%type index by binary_integer;
	type tytbEXE_RULE_POST_SALE is table of LD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE%type index by binary_integer;
	type tytbLEG_PROCESS_ORDERS is table of LD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS%type index by binary_integer;
	type tytbCONNECT_INFO is table of LD_SUPPLI_SETTINGS.CONNECT_INFO%type index by binary_integer;
	type tytbSALE_NAME_REPORT is table of LD_SUPPLI_SETTINGS.SALE_NAME_REPORT%type index by binary_integer;
	type tytbREQUI_APPROV_ANNULM is table of LD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM%type index by binary_integer;
	type tytbREQUI_APPROV_RETURN is table of LD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN%type index by binary_integer;
	type tytbALLOW_TRANSF_QUOTA is table of LD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA%type index by binary_integer;
	type tytbDEBTOR_REQUIRED is table of LD_SUPPLI_SETTINGS.DEBTOR_REQUIRED%type index by binary_integer;
	type tytbDEBTOR_PRODUCT_GAS is table of LD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS%type index by binary_integer;
	type tytbEXTERN_BRANCH_EQ is table of LD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ%type index by binary_integer;
	type tytbEDIT_DELIV_IN_POINT is table of LD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_SUPPLI_SETTINGS is record
	(
		VIEW_ITEM_CARDIF   tytbVIEW_ITEM_CARDIF,
		SUPPLI_SETTINGS_ID   tytbSUPPLI_SETTINGS_ID,
		SUPPLIER_ID   tytbSUPPLIER_ID,
		TYPE_PROMISS_NOTE   tytbTYPE_PROMISS_NOTE,
		SEL_SALES_CHANNEL   tytbSEL_SALES_CHANNEL,
		DEFAULT_CHAN_SALE   tytbDEFAULT_CHAN_SALE,
		LEG_DELIV_ORDE_AUTO   tytbLEG_DELIV_ORDE_AUTO,
		DELIV_IN_POINT   tytbDELIV_IN_POINT,
		MIN_FOR_DELIVERY   tytbMIN_FOR_DELIVERY,
		POST_LEG_PROCESS   tytbPOST_LEG_PROCESS,
		EXE_RULE_POST_SALE   tytbEXE_RULE_POST_SALE,
		LEG_PROCESS_ORDERS   tytbLEG_PROCESS_ORDERS,
		CONNECT_INFO   tytbCONNECT_INFO,
		SALE_NAME_REPORT   tytbSALE_NAME_REPORT,
		REQUI_APPROV_ANNULM   tytbREQUI_APPROV_ANNULM,
		REQUI_APPROV_RETURN   tytbREQUI_APPROV_RETURN,
		ALLOW_TRANSF_QUOTA   tytbALLOW_TRANSF_QUOTA,
		DEBTOR_REQUIRED   tytbDEBTOR_REQUIRED,
		DEBTOR_PRODUCT_GAS   tytbDEBTOR_PRODUCT_GAS,
		EXTERN_BRANCH_EQ   tytbEXTERN_BRANCH_EQ,
		EDIT_DELIV_IN_POINT   tytbEDIT_DELIV_IN_POINT,
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
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	);

	PROCEDURE getRecord
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		orcRecord out nocopy styLD_SUPPLI_SETTINGS
	);

	FUNCTION frcGetRcData
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN styLD_SUPPLI_SETTINGS;

	FUNCTION frcGetRcData
	RETURN styLD_SUPPLI_SETTINGS;

	FUNCTION frcGetRecord
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN styLD_SUPPLI_SETTINGS;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SUPPLI_SETTINGS
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_SUPPLI_SETTINGS in styLD_SUPPLI_SETTINGS
	);

	PROCEDURE insRecord
	(
		ircLD_SUPPLI_SETTINGS in styLD_SUPPLI_SETTINGS,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_SUPPLI_SETTINGS in out nocopy tytbLD_SUPPLI_SETTINGS
	);

	PROCEDURE delRecord
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_SUPPLI_SETTINGS in out nocopy tytbLD_SUPPLI_SETTINGS,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_SUPPLI_SETTINGS in styLD_SUPPLI_SETTINGS,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_SUPPLI_SETTINGS in out nocopy tytbLD_SUPPLI_SETTINGS,
		inuLock in number default 1
	);

	PROCEDURE updVIEW_ITEM_CARDIF
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbVIEW_ITEM_CARDIF$ in LD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF%type,
		inuLock in number default 0
	);

	PROCEDURE updSUPPLIER_ID
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuSUPPLIER_ID$ in LD_SUPPLI_SETTINGS.SUPPLIER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_PROMISS_NOTE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbTYPE_PROMISS_NOTE$ in LD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE%type,
		inuLock in number default 0
	);

	PROCEDURE updSEL_SALES_CHANNEL
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbSEL_SALES_CHANNEL$ in LD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL%type,
		inuLock in number default 0
	);

	PROCEDURE updDEFAULT_CHAN_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuDEFAULT_CHAN_SALE$ in LD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE%type,
		inuLock in number default 0
	);

	PROCEDURE updLEG_DELIV_ORDE_AUTO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbLEG_DELIV_ORDE_AUTO$ in LD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO%type,
		inuLock in number default 0
	);

	PROCEDURE updDELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbDELIV_IN_POINT$ in LD_SUPPLI_SETTINGS.DELIV_IN_POINT%type,
		inuLock in number default 0
	);

	PROCEDURE updMIN_FOR_DELIVERY
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuMIN_FOR_DELIVERY$ in LD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY%type,
		inuLock in number default 0
	);

	PROCEDURE updPOST_LEG_PROCESS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbPOST_LEG_PROCESS$ in LD_SUPPLI_SETTINGS.POST_LEG_PROCESS%type,
		inuLock in number default 0
	);

	PROCEDURE updEXE_RULE_POST_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbEXE_RULE_POST_SALE$ in LD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE%type,
		inuLock in number default 0
	);

	PROCEDURE updLEG_PROCESS_ORDERS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbLEG_PROCESS_ORDERS$ in LD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS%type,
		inuLock in number default 0
	);

	PROCEDURE updCONNECT_INFO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbCONNECT_INFO$ in LD_SUPPLI_SETTINGS.CONNECT_INFO%type,
		inuLock in number default 0
	);

	PROCEDURE updSALE_NAME_REPORT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbSALE_NAME_REPORT$ in LD_SUPPLI_SETTINGS.SALE_NAME_REPORT%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUI_APPROV_ANNULM
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbREQUI_APPROV_ANNULM$ in LD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUI_APPROV_RETURN
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbREQUI_APPROV_RETURN$ in LD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN%type,
		inuLock in number default 0
	);

	PROCEDURE updALLOW_TRANSF_QUOTA
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbALLOW_TRANSF_QUOTA$ in LD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA%type,
		inuLock in number default 0
	);

	PROCEDURE updDEBTOR_REQUIRED
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbDEBTOR_REQUIRED$ in LD_SUPPLI_SETTINGS.DEBTOR_REQUIRED%type,
		inuLock in number default 0
	);

	PROCEDURE updDEBTOR_PRODUCT_GAS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbDEBTOR_PRODUCT_GAS$ in LD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS%type,
		inuLock in number default 0
	);

	PROCEDURE updEXTERN_BRANCH_EQ
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbEXTERN_BRANCH_EQ$ in LD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ%type,
		inuLock in number default 0
	);

	PROCEDURE updEDIT_DELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbEDIT_DELIV_IN_POINT$ in LD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetVIEW_ITEM_CARDIF
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF%type;

	FUNCTION fnuGetSUPPLI_SETTINGS_ID
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type;

	FUNCTION fnuGetSUPPLIER_ID
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SUPPLIER_ID%type;

	FUNCTION fsbGetTYPE_PROMISS_NOTE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE%type;

	FUNCTION fsbGetSEL_SALES_CHANNEL
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL%type;

	FUNCTION fnuGetDEFAULT_CHAN_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE%type;

	FUNCTION fsbGetLEG_DELIV_ORDE_AUTO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO%type;

	FUNCTION fsbGetDELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DELIV_IN_POINT%type;

	FUNCTION fnuGetMIN_FOR_DELIVERY
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY%type;

	FUNCTION fsbGetPOST_LEG_PROCESS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.POST_LEG_PROCESS%type;

	FUNCTION fsbGetEXE_RULE_POST_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE%type;

	FUNCTION fsbGetLEG_PROCESS_ORDERS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS%type;

	FUNCTION fsbGetCONNECT_INFO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.CONNECT_INFO%type;

	FUNCTION fsbGetSALE_NAME_REPORT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SALE_NAME_REPORT%type;

	FUNCTION fsbGetREQUI_APPROV_ANNULM
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM%type;

	FUNCTION fsbGetREQUI_APPROV_RETURN
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN%type;

	FUNCTION fsbGetALLOW_TRANSF_QUOTA
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA%type;

	FUNCTION fsbGetDEBTOR_REQUIRED
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DEBTOR_REQUIRED%type;

	FUNCTION fsbGetDEBTOR_PRODUCT_GAS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS%type;

	FUNCTION fsbGetEXTERN_BRANCH_EQ
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ%type;

	FUNCTION fsbGetEDIT_DELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT%type;


	PROCEDURE LockByPk
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		orcLD_SUPPLI_SETTINGS  out styLD_SUPPLI_SETTINGS
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_SUPPLI_SETTINGS  out styLD_SUPPLI_SETTINGS
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_SUPPLI_SETTINGS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_SUPPLI_SETTINGS
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUPPLI_SETTINGS';
	 cnuGeEntityId constant varchar2(30) := 7993; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	IS
		SELECT LD_SUPPLI_SETTINGS.*,LD_SUPPLI_SETTINGS.rowid
		FROM LD_SUPPLI_SETTINGS
		WHERE  SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_SUPPLI_SETTINGS.*,LD_SUPPLI_SETTINGS.rowid
		FROM LD_SUPPLI_SETTINGS
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_SUPPLI_SETTINGS is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_SUPPLI_SETTINGS;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_SUPPLI_SETTINGS default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUPPLI_SETTINGS_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		orcLD_SUPPLI_SETTINGS  out styLD_SUPPLI_SETTINGS
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

		Open cuLockRcByPk
		(
			inuSUPPLI_SETTINGS_ID
		);

		fetch cuLockRcByPk into orcLD_SUPPLI_SETTINGS;
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
		orcLD_SUPPLI_SETTINGS  out styLD_SUPPLI_SETTINGS
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_SUPPLI_SETTINGS;
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
		itbLD_SUPPLI_SETTINGS  in out nocopy tytbLD_SUPPLI_SETTINGS
	)
	IS
	BEGIN
			rcRecOfTab.VIEW_ITEM_CARDIF.delete;
			rcRecOfTab.SUPPLI_SETTINGS_ID.delete;
			rcRecOfTab.SUPPLIER_ID.delete;
			rcRecOfTab.TYPE_PROMISS_NOTE.delete;
			rcRecOfTab.SEL_SALES_CHANNEL.delete;
			rcRecOfTab.DEFAULT_CHAN_SALE.delete;
			rcRecOfTab.LEG_DELIV_ORDE_AUTO.delete;
			rcRecOfTab.DELIV_IN_POINT.delete;
			rcRecOfTab.MIN_FOR_DELIVERY.delete;
			rcRecOfTab.POST_LEG_PROCESS.delete;
			rcRecOfTab.EXE_RULE_POST_SALE.delete;
			rcRecOfTab.LEG_PROCESS_ORDERS.delete;
			rcRecOfTab.CONNECT_INFO.delete;
			rcRecOfTab.SALE_NAME_REPORT.delete;
			rcRecOfTab.REQUI_APPROV_ANNULM.delete;
			rcRecOfTab.REQUI_APPROV_RETURN.delete;
			rcRecOfTab.ALLOW_TRANSF_QUOTA.delete;
			rcRecOfTab.DEBTOR_REQUIRED.delete;
			rcRecOfTab.DEBTOR_PRODUCT_GAS.delete;
			rcRecOfTab.EXTERN_BRANCH_EQ.delete;
			rcRecOfTab.EDIT_DELIV_IN_POINT.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_SUPPLI_SETTINGS  in out nocopy tytbLD_SUPPLI_SETTINGS,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_SUPPLI_SETTINGS);

		for n in itbLD_SUPPLI_SETTINGS.first .. itbLD_SUPPLI_SETTINGS.last loop
			rcRecOfTab.VIEW_ITEM_CARDIF(n) := itbLD_SUPPLI_SETTINGS(n).VIEW_ITEM_CARDIF;
			rcRecOfTab.SUPPLI_SETTINGS_ID(n) := itbLD_SUPPLI_SETTINGS(n).SUPPLI_SETTINGS_ID;
			rcRecOfTab.SUPPLIER_ID(n) := itbLD_SUPPLI_SETTINGS(n).SUPPLIER_ID;
			rcRecOfTab.TYPE_PROMISS_NOTE(n) := itbLD_SUPPLI_SETTINGS(n).TYPE_PROMISS_NOTE;
			rcRecOfTab.SEL_SALES_CHANNEL(n) := itbLD_SUPPLI_SETTINGS(n).SEL_SALES_CHANNEL;
			rcRecOfTab.DEFAULT_CHAN_SALE(n) := itbLD_SUPPLI_SETTINGS(n).DEFAULT_CHAN_SALE;
			rcRecOfTab.LEG_DELIV_ORDE_AUTO(n) := itbLD_SUPPLI_SETTINGS(n).LEG_DELIV_ORDE_AUTO;
			rcRecOfTab.DELIV_IN_POINT(n) := itbLD_SUPPLI_SETTINGS(n).DELIV_IN_POINT;
			rcRecOfTab.MIN_FOR_DELIVERY(n) := itbLD_SUPPLI_SETTINGS(n).MIN_FOR_DELIVERY;
			rcRecOfTab.POST_LEG_PROCESS(n) := itbLD_SUPPLI_SETTINGS(n).POST_LEG_PROCESS;
			rcRecOfTab.EXE_RULE_POST_SALE(n) := itbLD_SUPPLI_SETTINGS(n).EXE_RULE_POST_SALE;
			rcRecOfTab.LEG_PROCESS_ORDERS(n) := itbLD_SUPPLI_SETTINGS(n).LEG_PROCESS_ORDERS;
			rcRecOfTab.CONNECT_INFO(n) := itbLD_SUPPLI_SETTINGS(n).CONNECT_INFO;
			rcRecOfTab.SALE_NAME_REPORT(n) := itbLD_SUPPLI_SETTINGS(n).SALE_NAME_REPORT;
			rcRecOfTab.REQUI_APPROV_ANNULM(n) := itbLD_SUPPLI_SETTINGS(n).REQUI_APPROV_ANNULM;
			rcRecOfTab.REQUI_APPROV_RETURN(n) := itbLD_SUPPLI_SETTINGS(n).REQUI_APPROV_RETURN;
			rcRecOfTab.ALLOW_TRANSF_QUOTA(n) := itbLD_SUPPLI_SETTINGS(n).ALLOW_TRANSF_QUOTA;
			rcRecOfTab.DEBTOR_REQUIRED(n) := itbLD_SUPPLI_SETTINGS(n).DEBTOR_REQUIRED;
			rcRecOfTab.DEBTOR_PRODUCT_GAS(n) := itbLD_SUPPLI_SETTINGS(n).DEBTOR_PRODUCT_GAS;
			rcRecOfTab.EXTERN_BRANCH_EQ(n) := itbLD_SUPPLI_SETTINGS(n).EXTERN_BRANCH_EQ;
			rcRecOfTab.EDIT_DELIV_IN_POINT(n) := itbLD_SUPPLI_SETTINGS(n).EDIT_DELIV_IN_POINT;
			rcRecOfTab.row_id(n) := itbLD_SUPPLI_SETTINGS(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSUPPLI_SETTINGS_ID
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
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSUPPLI_SETTINGS_ID = rcData.SUPPLI_SETTINGS_ID
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
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSUPPLI_SETTINGS_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN		rcError.SUPPLI_SETTINGS_ID:=inuSUPPLI_SETTINGS_ID;

		Load
		(
			inuSUPPLI_SETTINGS_ID
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
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuSUPPLI_SETTINGS_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		orcRecord out nocopy styLD_SUPPLI_SETTINGS
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN		rcError.SUPPLI_SETTINGS_ID:=inuSUPPLI_SETTINGS_ID;

		Load
		(
			inuSUPPLI_SETTINGS_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN styLD_SUPPLI_SETTINGS
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID:=inuSUPPLI_SETTINGS_ID;

		Load
		(
			inuSUPPLI_SETTINGS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	)
	RETURN styLD_SUPPLI_SETTINGS
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID:=inuSUPPLI_SETTINGS_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSUPPLI_SETTINGS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_SUPPLI_SETTINGS
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SUPPLI_SETTINGS
	)
	IS
		rfLD_SUPPLI_SETTINGS tyrfLD_SUPPLI_SETTINGS;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_SUPPLI_SETTINGS.*, LD_SUPPLI_SETTINGS.rowid FROM LD_SUPPLI_SETTINGS';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_SUPPLI_SETTINGS for sbFullQuery;

		fetch rfLD_SUPPLI_SETTINGS bulk collect INTO otbResult;

		close rfLD_SUPPLI_SETTINGS;
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
		sbSQL VARCHAR2 (32000) := 'select LD_SUPPLI_SETTINGS.*, LD_SUPPLI_SETTINGS.rowid FROM LD_SUPPLI_SETTINGS';
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
		ircLD_SUPPLI_SETTINGS in styLD_SUPPLI_SETTINGS
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_SUPPLI_SETTINGS,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_SUPPLI_SETTINGS in styLD_SUPPLI_SETTINGS,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SUPPLI_SETTINGS_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_SUPPLI_SETTINGS
		(
			VIEW_ITEM_CARDIF,
			SUPPLI_SETTINGS_ID,
			SUPPLIER_ID,
			TYPE_PROMISS_NOTE,
			SEL_SALES_CHANNEL,
			DEFAULT_CHAN_SALE,
			LEG_DELIV_ORDE_AUTO,
			DELIV_IN_POINT,
			MIN_FOR_DELIVERY,
			POST_LEG_PROCESS,
			EXE_RULE_POST_SALE,
			LEG_PROCESS_ORDERS,
			CONNECT_INFO,
			SALE_NAME_REPORT,
			REQUI_APPROV_ANNULM,
			REQUI_APPROV_RETURN,
			ALLOW_TRANSF_QUOTA,
			DEBTOR_REQUIRED,
			DEBTOR_PRODUCT_GAS,
			EXTERN_BRANCH_EQ,
			EDIT_DELIV_IN_POINT
		)
		values
		(
			ircLD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF,
			ircLD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID,
			ircLD_SUPPLI_SETTINGS.SUPPLIER_ID,
			ircLD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE,
			ircLD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL,
			ircLD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE,
			ircLD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO,
			ircLD_SUPPLI_SETTINGS.DELIV_IN_POINT,
			ircLD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY,
			ircLD_SUPPLI_SETTINGS.POST_LEG_PROCESS,
			ircLD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE,
			ircLD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS,
			ircLD_SUPPLI_SETTINGS.CONNECT_INFO,
			ircLD_SUPPLI_SETTINGS.SALE_NAME_REPORT,
			ircLD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM,
			ircLD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN,
			ircLD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA,
			ircLD_SUPPLI_SETTINGS.DEBTOR_REQUIRED,
			ircLD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS,
			ircLD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ,
			ircLD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_SUPPLI_SETTINGS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_SUPPLI_SETTINGS in out nocopy tytbLD_SUPPLI_SETTINGS
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_SUPPLI_SETTINGS,blUseRowID);
		forall n in iotbLD_SUPPLI_SETTINGS.first..iotbLD_SUPPLI_SETTINGS.last
			insert into LD_SUPPLI_SETTINGS
			(
				VIEW_ITEM_CARDIF,
				SUPPLI_SETTINGS_ID,
				SUPPLIER_ID,
				TYPE_PROMISS_NOTE,
				SEL_SALES_CHANNEL,
				DEFAULT_CHAN_SALE,
				LEG_DELIV_ORDE_AUTO,
				DELIV_IN_POINT,
				MIN_FOR_DELIVERY,
				POST_LEG_PROCESS,
				EXE_RULE_POST_SALE,
				LEG_PROCESS_ORDERS,
				CONNECT_INFO,
				SALE_NAME_REPORT,
				REQUI_APPROV_ANNULM,
				REQUI_APPROV_RETURN,
				ALLOW_TRANSF_QUOTA,
				DEBTOR_REQUIRED,
				DEBTOR_PRODUCT_GAS,
				EXTERN_BRANCH_EQ,
				EDIT_DELIV_IN_POINT
			)
			values
			(
				rcRecOfTab.VIEW_ITEM_CARDIF(n),
				rcRecOfTab.SUPPLI_SETTINGS_ID(n),
				rcRecOfTab.SUPPLIER_ID(n),
				rcRecOfTab.TYPE_PROMISS_NOTE(n),
				rcRecOfTab.SEL_SALES_CHANNEL(n),
				rcRecOfTab.DEFAULT_CHAN_SALE(n),
				rcRecOfTab.LEG_DELIV_ORDE_AUTO(n),
				rcRecOfTab.DELIV_IN_POINT(n),
				rcRecOfTab.MIN_FOR_DELIVERY(n),
				rcRecOfTab.POST_LEG_PROCESS(n),
				rcRecOfTab.EXE_RULE_POST_SALE(n),
				rcRecOfTab.LEG_PROCESS_ORDERS(n),
				rcRecOfTab.CONNECT_INFO(n),
				rcRecOfTab.SALE_NAME_REPORT(n),
				rcRecOfTab.REQUI_APPROV_ANNULM(n),
				rcRecOfTab.REQUI_APPROV_RETURN(n),
				rcRecOfTab.ALLOW_TRANSF_QUOTA(n),
				rcRecOfTab.DEBTOR_REQUIRED(n),
				rcRecOfTab.DEBTOR_PRODUCT_GAS(n),
				rcRecOfTab.EXTERN_BRANCH_EQ(n),
				rcRecOfTab.EDIT_DELIV_IN_POINT(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;


		delete
		from LD_SUPPLI_SETTINGS
		where
       		SUPPLI_SETTINGS_ID=inuSUPPLI_SETTINGS_ID;
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
		rcError  styLD_SUPPLI_SETTINGS;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_SUPPLI_SETTINGS
		where
			rowid = iriRowID
		returning
			VIEW_ITEM_CARDIF
		into
			rcError.VIEW_ITEM_CARDIF;
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
		iotbLD_SUPPLI_SETTINGS in out nocopy tytbLD_SUPPLI_SETTINGS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SUPPLI_SETTINGS;
	BEGIN
		FillRecordOfTables(iotbLD_SUPPLI_SETTINGS, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last
				delete
				from LD_SUPPLI_SETTINGS
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last loop
					LockByPk
					(
						rcRecOfTab.SUPPLI_SETTINGS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last
				delete
				from LD_SUPPLI_SETTINGS
				where
		         	SUPPLI_SETTINGS_ID = rcRecOfTab.SUPPLI_SETTINGS_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_SUPPLI_SETTINGS in styLD_SUPPLI_SETTINGS,
		inuLock in number default 0
	)
	IS
		nuSUPPLI_SETTINGS_ID	LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type;
	BEGIN
		if ircLD_SUPPLI_SETTINGS.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_SUPPLI_SETTINGS.rowid,rcData);
			end if;
			update LD_SUPPLI_SETTINGS
			set
				VIEW_ITEM_CARDIF = ircLD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF,
				SUPPLIER_ID = ircLD_SUPPLI_SETTINGS.SUPPLIER_ID,
				TYPE_PROMISS_NOTE = ircLD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE,
				SEL_SALES_CHANNEL = ircLD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL,
				DEFAULT_CHAN_SALE = ircLD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE,
				LEG_DELIV_ORDE_AUTO = ircLD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO,
				DELIV_IN_POINT = ircLD_SUPPLI_SETTINGS.DELIV_IN_POINT,
				MIN_FOR_DELIVERY = ircLD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY,
				POST_LEG_PROCESS = ircLD_SUPPLI_SETTINGS.POST_LEG_PROCESS,
				EXE_RULE_POST_SALE = ircLD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE,
				LEG_PROCESS_ORDERS = ircLD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS,
				CONNECT_INFO = ircLD_SUPPLI_SETTINGS.CONNECT_INFO,
				SALE_NAME_REPORT = ircLD_SUPPLI_SETTINGS.SALE_NAME_REPORT,
				REQUI_APPROV_ANNULM = ircLD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM,
				REQUI_APPROV_RETURN = ircLD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN,
				ALLOW_TRANSF_QUOTA = ircLD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA,
				DEBTOR_REQUIRED = ircLD_SUPPLI_SETTINGS.DEBTOR_REQUIRED,
				DEBTOR_PRODUCT_GAS = ircLD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS,
				EXTERN_BRANCH_EQ = ircLD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ,
				EDIT_DELIV_IN_POINT = ircLD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT
			where
				rowid = ircLD_SUPPLI_SETTINGS.rowid
			returning
				SUPPLI_SETTINGS_ID
			into
				nuSUPPLI_SETTINGS_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID,
					rcData
				);
			end if;

			update LD_SUPPLI_SETTINGS
			set
				VIEW_ITEM_CARDIF = ircLD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF,
				SUPPLIER_ID = ircLD_SUPPLI_SETTINGS.SUPPLIER_ID,
				TYPE_PROMISS_NOTE = ircLD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE,
				SEL_SALES_CHANNEL = ircLD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL,
				DEFAULT_CHAN_SALE = ircLD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE,
				LEG_DELIV_ORDE_AUTO = ircLD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO,
				DELIV_IN_POINT = ircLD_SUPPLI_SETTINGS.DELIV_IN_POINT,
				MIN_FOR_DELIVERY = ircLD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY,
				POST_LEG_PROCESS = ircLD_SUPPLI_SETTINGS.POST_LEG_PROCESS,
				EXE_RULE_POST_SALE = ircLD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE,
				LEG_PROCESS_ORDERS = ircLD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS,
				CONNECT_INFO = ircLD_SUPPLI_SETTINGS.CONNECT_INFO,
				SALE_NAME_REPORT = ircLD_SUPPLI_SETTINGS.SALE_NAME_REPORT,
				REQUI_APPROV_ANNULM = ircLD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM,
				REQUI_APPROV_RETURN = ircLD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN,
				ALLOW_TRANSF_QUOTA = ircLD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA,
				DEBTOR_REQUIRED = ircLD_SUPPLI_SETTINGS.DEBTOR_REQUIRED,
				DEBTOR_PRODUCT_GAS = ircLD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS,
				EXTERN_BRANCH_EQ = ircLD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ,
				EDIT_DELIV_IN_POINT = ircLD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT
			where
				SUPPLI_SETTINGS_ID = ircLD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID
			returning
				SUPPLI_SETTINGS_ID
			into
				nuSUPPLI_SETTINGS_ID;
		end if;
		if
			nuSUPPLI_SETTINGS_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_SUPPLI_SETTINGS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_SUPPLI_SETTINGS in out nocopy tytbLD_SUPPLI_SETTINGS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SUPPLI_SETTINGS;
	BEGIN
		FillRecordOfTables(iotbLD_SUPPLI_SETTINGS,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last
				update LD_SUPPLI_SETTINGS
				set
					VIEW_ITEM_CARDIF = rcRecOfTab.VIEW_ITEM_CARDIF(n),
					SUPPLIER_ID = rcRecOfTab.SUPPLIER_ID(n),
					TYPE_PROMISS_NOTE = rcRecOfTab.TYPE_PROMISS_NOTE(n),
					SEL_SALES_CHANNEL = rcRecOfTab.SEL_SALES_CHANNEL(n),
					DEFAULT_CHAN_SALE = rcRecOfTab.DEFAULT_CHAN_SALE(n),
					LEG_DELIV_ORDE_AUTO = rcRecOfTab.LEG_DELIV_ORDE_AUTO(n),
					DELIV_IN_POINT = rcRecOfTab.DELIV_IN_POINT(n),
					MIN_FOR_DELIVERY = rcRecOfTab.MIN_FOR_DELIVERY(n),
					POST_LEG_PROCESS = rcRecOfTab.POST_LEG_PROCESS(n),
					EXE_RULE_POST_SALE = rcRecOfTab.EXE_RULE_POST_SALE(n),
					LEG_PROCESS_ORDERS = rcRecOfTab.LEG_PROCESS_ORDERS(n),
					CONNECT_INFO = rcRecOfTab.CONNECT_INFO(n),
					SALE_NAME_REPORT = rcRecOfTab.SALE_NAME_REPORT(n),
					REQUI_APPROV_ANNULM = rcRecOfTab.REQUI_APPROV_ANNULM(n),
					REQUI_APPROV_RETURN = rcRecOfTab.REQUI_APPROV_RETURN(n),
					ALLOW_TRANSF_QUOTA = rcRecOfTab.ALLOW_TRANSF_QUOTA(n),
					DEBTOR_REQUIRED = rcRecOfTab.DEBTOR_REQUIRED(n),
					DEBTOR_PRODUCT_GAS = rcRecOfTab.DEBTOR_PRODUCT_GAS(n),
					EXTERN_BRANCH_EQ = rcRecOfTab.EXTERN_BRANCH_EQ(n),
					EDIT_DELIV_IN_POINT = rcRecOfTab.EDIT_DELIV_IN_POINT(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last loop
					LockByPk
					(
						rcRecOfTab.SUPPLI_SETTINGS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SUPPLI_SETTINGS.first .. iotbLD_SUPPLI_SETTINGS.last
				update LD_SUPPLI_SETTINGS
				SET
					VIEW_ITEM_CARDIF = rcRecOfTab.VIEW_ITEM_CARDIF(n),
					SUPPLIER_ID = rcRecOfTab.SUPPLIER_ID(n),
					TYPE_PROMISS_NOTE = rcRecOfTab.TYPE_PROMISS_NOTE(n),
					SEL_SALES_CHANNEL = rcRecOfTab.SEL_SALES_CHANNEL(n),
					DEFAULT_CHAN_SALE = rcRecOfTab.DEFAULT_CHAN_SALE(n),
					LEG_DELIV_ORDE_AUTO = rcRecOfTab.LEG_DELIV_ORDE_AUTO(n),
					DELIV_IN_POINT = rcRecOfTab.DELIV_IN_POINT(n),
					MIN_FOR_DELIVERY = rcRecOfTab.MIN_FOR_DELIVERY(n),
					POST_LEG_PROCESS = rcRecOfTab.POST_LEG_PROCESS(n),
					EXE_RULE_POST_SALE = rcRecOfTab.EXE_RULE_POST_SALE(n),
					LEG_PROCESS_ORDERS = rcRecOfTab.LEG_PROCESS_ORDERS(n),
					CONNECT_INFO = rcRecOfTab.CONNECT_INFO(n),
					SALE_NAME_REPORT = rcRecOfTab.SALE_NAME_REPORT(n),
					REQUI_APPROV_ANNULM = rcRecOfTab.REQUI_APPROV_ANNULM(n),
					REQUI_APPROV_RETURN = rcRecOfTab.REQUI_APPROV_RETURN(n),
					ALLOW_TRANSF_QUOTA = rcRecOfTab.ALLOW_TRANSF_QUOTA(n),
					DEBTOR_REQUIRED = rcRecOfTab.DEBTOR_REQUIRED(n),
					DEBTOR_PRODUCT_GAS = rcRecOfTab.DEBTOR_PRODUCT_GAS(n),
					EXTERN_BRANCH_EQ = rcRecOfTab.EXTERN_BRANCH_EQ(n),
					EDIT_DELIV_IN_POINT = rcRecOfTab.EDIT_DELIV_IN_POINT(n)
				where
					SUPPLI_SETTINGS_ID = rcRecOfTab.SUPPLI_SETTINGS_ID(n)
;
		end if;
	END;
	PROCEDURE updVIEW_ITEM_CARDIF
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbVIEW_ITEM_CARDIF$ in LD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			VIEW_ITEM_CARDIF = isbVIEW_ITEM_CARDIF$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VIEW_ITEM_CARDIF:= isbVIEW_ITEM_CARDIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUPPLIER_ID
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuSUPPLIER_ID$ in LD_SUPPLI_SETTINGS.SUPPLIER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			SUPPLIER_ID = inuSUPPLIER_ID$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUPPLIER_ID:= inuSUPPLIER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_PROMISS_NOTE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbTYPE_PROMISS_NOTE$ in LD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			TYPE_PROMISS_NOTE = isbTYPE_PROMISS_NOTE$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_PROMISS_NOTE:= isbTYPE_PROMISS_NOTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSEL_SALES_CHANNEL
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbSEL_SALES_CHANNEL$ in LD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			SEL_SALES_CHANNEL = isbSEL_SALES_CHANNEL$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SEL_SALES_CHANNEL:= isbSEL_SALES_CHANNEL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEFAULT_CHAN_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuDEFAULT_CHAN_SALE$ in LD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			DEFAULT_CHAN_SALE = inuDEFAULT_CHAN_SALE$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEFAULT_CHAN_SALE:= inuDEFAULT_CHAN_SALE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLEG_DELIV_ORDE_AUTO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbLEG_DELIV_ORDE_AUTO$ in LD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			LEG_DELIV_ORDE_AUTO = isbLEG_DELIV_ORDE_AUTO$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LEG_DELIV_ORDE_AUTO:= isbLEG_DELIV_ORDE_AUTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbDELIV_IN_POINT$ in LD_SUPPLI_SETTINGS.DELIV_IN_POINT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			DELIV_IN_POINT = isbDELIV_IN_POINT$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DELIV_IN_POINT:= isbDELIV_IN_POINT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMIN_FOR_DELIVERY
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuMIN_FOR_DELIVERY$ in LD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			MIN_FOR_DELIVERY = inuMIN_FOR_DELIVERY$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MIN_FOR_DELIVERY:= inuMIN_FOR_DELIVERY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOST_LEG_PROCESS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbPOST_LEG_PROCESS$ in LD_SUPPLI_SETTINGS.POST_LEG_PROCESS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			POST_LEG_PROCESS = isbPOST_LEG_PROCESS$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POST_LEG_PROCESS:= isbPOST_LEG_PROCESS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEXE_RULE_POST_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbEXE_RULE_POST_SALE$ in LD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			EXE_RULE_POST_SALE = isbEXE_RULE_POST_SALE$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXE_RULE_POST_SALE:= isbEXE_RULE_POST_SALE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLEG_PROCESS_ORDERS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbLEG_PROCESS_ORDERS$ in LD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			LEG_PROCESS_ORDERS = isbLEG_PROCESS_ORDERS$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LEG_PROCESS_ORDERS:= isbLEG_PROCESS_ORDERS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONNECT_INFO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbCONNECT_INFO$ in LD_SUPPLI_SETTINGS.CONNECT_INFO%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			CONNECT_INFO = isbCONNECT_INFO$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONNECT_INFO:= isbCONNECT_INFO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSALE_NAME_REPORT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbSALE_NAME_REPORT$ in LD_SUPPLI_SETTINGS.SALE_NAME_REPORT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			SALE_NAME_REPORT = isbSALE_NAME_REPORT$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SALE_NAME_REPORT:= isbSALE_NAME_REPORT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUI_APPROV_ANNULM
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbREQUI_APPROV_ANNULM$ in LD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			REQUI_APPROV_ANNULM = isbREQUI_APPROV_ANNULM$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUI_APPROV_ANNULM:= isbREQUI_APPROV_ANNULM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUI_APPROV_RETURN
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbREQUI_APPROV_RETURN$ in LD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			REQUI_APPROV_RETURN = isbREQUI_APPROV_RETURN$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUI_APPROV_RETURN:= isbREQUI_APPROV_RETURN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updALLOW_TRANSF_QUOTA
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbALLOW_TRANSF_QUOTA$ in LD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			ALLOW_TRANSF_QUOTA = isbALLOW_TRANSF_QUOTA$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ALLOW_TRANSF_QUOTA:= isbALLOW_TRANSF_QUOTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEBTOR_REQUIRED
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbDEBTOR_REQUIRED$ in LD_SUPPLI_SETTINGS.DEBTOR_REQUIRED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			DEBTOR_REQUIRED = isbDEBTOR_REQUIRED$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEBTOR_REQUIRED:= isbDEBTOR_REQUIRED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEBTOR_PRODUCT_GAS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbDEBTOR_PRODUCT_GAS$ in LD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			DEBTOR_PRODUCT_GAS = isbDEBTOR_PRODUCT_GAS$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEBTOR_PRODUCT_GAS:= isbDEBTOR_PRODUCT_GAS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEXTERN_BRANCH_EQ
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbEXTERN_BRANCH_EQ$ in LD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			EXTERN_BRANCH_EQ = isbEXTERN_BRANCH_EQ$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXTERN_BRANCH_EQ:= isbEXTERN_BRANCH_EQ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEDIT_DELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		isbEDIT_DELIV_IN_POINT$ in LD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN
		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSUPPLI_SETTINGS_ID,
				rcData
			);
		end if;

		update LD_SUPPLI_SETTINGS
		set
			EDIT_DELIV_IN_POINT = isbEDIT_DELIV_IN_POINT$
		where
			SUPPLI_SETTINGS_ID = inuSUPPLI_SETTINGS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EDIT_DELIV_IN_POINT:= isbEDIT_DELIV_IN_POINT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetVIEW_ITEM_CARDIF
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.VIEW_ITEM_CARDIF%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.VIEW_ITEM_CARDIF);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.VIEW_ITEM_CARDIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUPPLI_SETTINGS_ID
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.SUPPLI_SETTINGS_ID);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.SUPPLI_SETTINGS_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUPPLIER_ID
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SUPPLIER_ID%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.SUPPLIER_ID);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.SUPPLIER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTYPE_PROMISS_NOTE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.TYPE_PROMISS_NOTE%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.TYPE_PROMISS_NOTE);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.TYPE_PROMISS_NOTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSEL_SALES_CHANNEL
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SEL_SALES_CHANNEL%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.SEL_SALES_CHANNEL);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.SEL_SALES_CHANNEL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEFAULT_CHAN_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DEFAULT_CHAN_SALE%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.DEFAULT_CHAN_SALE);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.DEFAULT_CHAN_SALE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLEG_DELIV_ORDE_AUTO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.LEG_DELIV_ORDE_AUTO%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.LEG_DELIV_ORDE_AUTO);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.LEG_DELIV_ORDE_AUTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DELIV_IN_POINT%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.DELIV_IN_POINT);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.DELIV_IN_POINT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMIN_FOR_DELIVERY
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.MIN_FOR_DELIVERY%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.MIN_FOR_DELIVERY);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.MIN_FOR_DELIVERY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPOST_LEG_PROCESS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.POST_LEG_PROCESS%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.POST_LEG_PROCESS);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.POST_LEG_PROCESS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEXE_RULE_POST_SALE
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.EXE_RULE_POST_SALE%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.EXE_RULE_POST_SALE);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.EXE_RULE_POST_SALE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLEG_PROCESS_ORDERS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.LEG_PROCESS_ORDERS%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.LEG_PROCESS_ORDERS);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.LEG_PROCESS_ORDERS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCONNECT_INFO
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.CONNECT_INFO%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.CONNECT_INFO);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.CONNECT_INFO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSALE_NAME_REPORT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.SALE_NAME_REPORT%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.SALE_NAME_REPORT);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.SALE_NAME_REPORT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREQUI_APPROV_ANNULM
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.REQUI_APPROV_ANNULM%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.REQUI_APPROV_ANNULM);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.REQUI_APPROV_ANNULM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREQUI_APPROV_RETURN
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.REQUI_APPROV_RETURN%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.REQUI_APPROV_RETURN);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.REQUI_APPROV_RETURN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetALLOW_TRANSF_QUOTA
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.ALLOW_TRANSF_QUOTA%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.ALLOW_TRANSF_QUOTA);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.ALLOW_TRANSF_QUOTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEBTOR_REQUIRED
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DEBTOR_REQUIRED%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.DEBTOR_REQUIRED);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.DEBTOR_REQUIRED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEBTOR_PRODUCT_GAS
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.DEBTOR_PRODUCT_GAS%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.DEBTOR_PRODUCT_GAS);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.DEBTOR_PRODUCT_GAS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEXTERN_BRANCH_EQ
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.EXTERN_BRANCH_EQ%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.EXTERN_BRANCH_EQ);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.EXTERN_BRANCH_EQ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEDIT_DELIV_IN_POINT
	(
		inuSUPPLI_SETTINGS_ID in LD_SUPPLI_SETTINGS.SUPPLI_SETTINGS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SUPPLI_SETTINGS.EDIT_DELIV_IN_POINT%type
	IS
		rcError styLD_SUPPLI_SETTINGS;
	BEGIN

		rcError.SUPPLI_SETTINGS_ID := inuSUPPLI_SETTINGS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUPPLI_SETTINGS_ID
			 )
		then
			 return(rcData.EDIT_DELIV_IN_POINT);
		end if;
		Load
		(
		 		inuSUPPLI_SETTINGS_ID
		);
		return(rcData.EDIT_DELIV_IN_POINT);
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
end DALD_SUPPLI_SETTINGS;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUPPLI_SETTINGS
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUPPLI_SETTINGS', 'ADM_PERSON');
END;
/