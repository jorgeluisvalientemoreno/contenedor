CREATE OR REPLACE PACKAGE adm_person.dald_hist_item_wo_or
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
  )
  IS
		SELECT LD_hist_item_wo_or.*,LD_hist_item_wo_or.rowid
		FROM LD_hist_item_wo_or
		WHERE
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_hist_item_wo_or.*,LD_hist_item_wo_or.rowid
		FROM LD_hist_item_wo_or
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_hist_item_wo_or  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_hist_item_wo_or is table of styLD_hist_item_wo_or index by binary_integer;
	type tyrfRecords is ref cursor return styLD_hist_item_wo_or;

	/* Tipos referenciando al registro */
	type tytbHist_Item_Wo_Or_Id is table of LD_hist_item_wo_or.Hist_Item_Wo_Or_Id%type index by binary_integer;
	type tytbItem_Work_Order_Id is table of LD_hist_item_wo_or.Item_Work_Order_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_hist_item_wo_or.Article_Id%type index by binary_integer;
	type tytbOrder_Activity_Id is table of LD_hist_item_wo_or.Order_Activity_Id%type index by binary_integer;
	type tytbLast_Amount is table of LD_hist_item_wo_or.Last_Amount%type index by binary_integer;
	type tytbCurrent_Amount is table of LD_hist_item_wo_or.Current_Amount%type index by binary_integer;
	type tytbValue is table of LD_hist_item_wo_or.Value%type index by binary_integer;
	type tytbLast_Iva is table of LD_hist_item_wo_or.Last_Iva%type index by binary_integer;
	type tytbCurrent_Iva is table of LD_hist_item_wo_or.Current_Iva%type index by binary_integer;
	type tytbCredit_Fees is table of LD_hist_item_wo_or.Credit_Fees%type index by binary_integer;
	type tytbInstall_Required is table of LD_hist_item_wo_or.Install_Required%type index by binary_integer;
	type tytbSupplier_Id is table of LD_hist_item_wo_or.Supplier_Id%type index by binary_integer;
	type tytbOrder_Id is table of LD_hist_item_wo_or.Order_Id%type index by binary_integer;
	type tytbRegister_Date is table of LD_hist_item_wo_or.Register_Date%type index by binary_integer;
	type tytbCon_User is table of LD_hist_item_wo_or.Con_User%type index by binary_integer;
	type tytbTerminal is table of LD_hist_item_wo_or.Terminal%type index by binary_integer;
	type tytbIp_Address is table of LD_hist_item_wo_or.Ip_Address%type index by binary_integer;
	type tytbMac_Addrees is table of LD_hist_item_wo_or.Mac_Addrees%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_hist_item_wo_or is record
	(

		Hist_Item_Wo_Or_Id   tytbHist_Item_Wo_Or_Id,
		Item_Work_Order_Id   tytbItem_Work_Order_Id,
		Article_Id   tytbArticle_Id,
		Order_Activity_Id   tytbOrder_Activity_Id,
		Last_Amount   tytbLast_Amount,
		Current_Amount   tytbCurrent_Amount,
		Value   tytbValue,
		Last_Iva   tytbLast_Iva,
		Current_Iva   tytbCurrent_Iva,
		Credit_Fees   tytbCredit_Fees,
		Install_Required   tytbInstall_Required,
		Supplier_Id   tytbSupplier_Id,
		Order_Id   tytbOrder_Id,
		Register_Date   tytbRegister_Date,
		Con_User   tytbCon_User,
		Terminal   tytbTerminal,
		Ip_Address   tytbIp_Address,
		Mac_Addrees   tytbMac_Addrees,
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
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	);

	PROCEDURE getRecord
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		orcRecord out nocopy styLD_hist_item_wo_or
	);

	FUNCTION frcGetRcData
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN styLD_hist_item_wo_or;

	FUNCTION frcGetRcData
	RETURN styLD_hist_item_wo_or;

	FUNCTION frcGetRecord
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN styLD_hist_item_wo_or;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_hist_item_wo_or
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_hist_item_wo_or in styLD_hist_item_wo_or
	);

 	  PROCEDURE insRecord
	(
		ircLD_hist_item_wo_or in styLD_hist_item_wo_or,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_hist_item_wo_or in out nocopy tytbLD_hist_item_wo_or
	);

	PROCEDURE delRecord
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_hist_item_wo_or in out nocopy tytbLD_hist_item_wo_or,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_hist_item_wo_or in styLD_hist_item_wo_or,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_hist_item_wo_or in out nocopy tytbLD_hist_item_wo_or,
		inuLock in number default 1
	);

		PROCEDURE updItem_Work_Order_Id
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuItem_Work_Order_Id$  in LD_hist_item_wo_or.Item_Work_Order_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updArticle_Id
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuArticle_Id$  in LD_hist_item_wo_or.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updOrder_Activity_Id
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuOrder_Activity_Id$  in LD_hist_item_wo_or.Order_Activity_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLast_Amount
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuLast_Amount$  in LD_hist_item_wo_or.Last_Amount%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCurrent_Amount
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuCurrent_Amount$  in LD_hist_item_wo_or.Current_Amount%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValue
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuValue$  in LD_hist_item_wo_or.Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLast_Iva
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuLast_Iva$  in LD_hist_item_wo_or.Last_Iva%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCurrent_Iva
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuCurrent_Iva$  in LD_hist_item_wo_or.Current_Iva%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCredit_Fees
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuCredit_Fees$  in LD_hist_item_wo_or.Credit_Fees%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInstall_Required
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				isbInstall_Required$  in LD_hist_item_wo_or.Install_Required%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuSupplier_Id$  in LD_hist_item_wo_or.Supplier_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updOrder_Id
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				inuOrder_Id$  in LD_hist_item_wo_or.Order_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRegister_Date
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				idtRegister_Date$  in LD_hist_item_wo_or.Register_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCon_User
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				isbCon_User$  in LD_hist_item_wo_or.Con_User%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updTerminal
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				isbTerminal$  in LD_hist_item_wo_or.Terminal%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updIp_Address
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				isbIp_Address$  in LD_hist_item_wo_or.Ip_Address%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updMac_Addrees
		(
				inuHIST_ITEM_WO_OR_Id   in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
				isbMac_Addrees$  in LD_hist_item_wo_or.Mac_Addrees%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetHist_Item_Wo_Or_Id
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Hist_Item_Wo_Or_Id%type;

    	FUNCTION fnuGetItem_Work_Order_Id
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Item_Work_Order_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Article_Id%type;

    	FUNCTION fnuGetOrder_Activity_Id
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Order_Activity_Id%type;

    	FUNCTION fnuGetLast_Amount
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Last_Amount%type;

    	FUNCTION fnuGetCurrent_Amount
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Current_Amount%type;

    	FUNCTION fnuGetValue
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Value%type;

    	FUNCTION fnuGetLast_Iva
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Last_Iva%type;

    	FUNCTION fnuGetCurrent_Iva
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Current_Iva%type;

    	FUNCTION fnuGetCredit_Fees
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Credit_Fees%type;

    	FUNCTION fsbGetInstall_Required
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Install_Required%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Supplier_Id%type;

    	FUNCTION fnuGetOrder_Id
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Order_Id%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Register_Date%type;

    	FUNCTION fsbGetCon_User
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Con_User%type;

    	FUNCTION fsbGetTerminal
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Terminal%type;

    	FUNCTION fsbGetIp_Address
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Ip_Address%type;

    	FUNCTION fsbGetMac_Addrees
    	(
    	    inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_hist_item_wo_or.Mac_Addrees%type;


	PROCEDURE LockByPk
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		orcLD_hist_item_wo_or  out styLD_hist_item_wo_or
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_hist_item_wo_or  out styLD_hist_item_wo_or
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_hist_item_wo_or;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_hist_item_wo_or
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_HIST_ITEM_WO_OR';
	  cnuGeEntityId constant varchar2(30) := 8358; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	IS
		SELECT LD_hist_item_wo_or.*,LD_hist_item_wo_or.rowid
		FROM LD_hist_item_wo_or
		WHERE  HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_hist_item_wo_or.*,LD_hist_item_wo_or.rowid
		FROM LD_hist_item_wo_or
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_hist_item_wo_or is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_hist_item_wo_or;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_hist_item_wo_or default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.HIST_ITEM_WO_OR_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		orcLD_hist_item_wo_or  out styLD_hist_item_wo_or
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		Open cuLockRcByPk
		(
			inuHIST_ITEM_WO_OR_Id
		);

		fetch cuLockRcByPk into orcLD_hist_item_wo_or;
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
		orcLD_hist_item_wo_or  out styLD_hist_item_wo_or
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_hist_item_wo_or;
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
		itbLD_hist_item_wo_or  in out nocopy tytbLD_hist_item_wo_or
	)
	IS
	BEGIN
			rcRecOfTab.Hist_Item_Wo_Or_Id.delete;
			rcRecOfTab.Item_Work_Order_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Order_Activity_Id.delete;
			rcRecOfTab.Last_Amount.delete;
			rcRecOfTab.Current_Amount.delete;
			rcRecOfTab.Value.delete;
			rcRecOfTab.Last_Iva.delete;
			rcRecOfTab.Current_Iva.delete;
			rcRecOfTab.Credit_Fees.delete;
			rcRecOfTab.Install_Required.delete;
			rcRecOfTab.Supplier_Id.delete;
			rcRecOfTab.Order_Id.delete;
			rcRecOfTab.Register_Date.delete;
			rcRecOfTab.Con_User.delete;
			rcRecOfTab.Terminal.delete;
			rcRecOfTab.Ip_Address.delete;
			rcRecOfTab.Mac_Addrees.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_hist_item_wo_or  in out nocopy tytbLD_hist_item_wo_or,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_hist_item_wo_or);
		for n in itbLD_hist_item_wo_or.first .. itbLD_hist_item_wo_or.last loop
			rcRecOfTab.Hist_Item_Wo_Or_Id(n) := itbLD_hist_item_wo_or(n).Hist_Item_Wo_Or_Id;
			rcRecOfTab.Item_Work_Order_Id(n) := itbLD_hist_item_wo_or(n).Item_Work_Order_Id;
			rcRecOfTab.Article_Id(n) := itbLD_hist_item_wo_or(n).Article_Id;
			rcRecOfTab.Order_Activity_Id(n) := itbLD_hist_item_wo_or(n).Order_Activity_Id;
			rcRecOfTab.Last_Amount(n) := itbLD_hist_item_wo_or(n).Last_Amount;
			rcRecOfTab.Current_Amount(n) := itbLD_hist_item_wo_or(n).Current_Amount;
			rcRecOfTab.Value(n) := itbLD_hist_item_wo_or(n).Value;
			rcRecOfTab.Last_Iva(n) := itbLD_hist_item_wo_or(n).Last_Iva;
			rcRecOfTab.Current_Iva(n) := itbLD_hist_item_wo_or(n).Current_Iva;
			rcRecOfTab.Credit_Fees(n) := itbLD_hist_item_wo_or(n).Credit_Fees;
			rcRecOfTab.Install_Required(n) := itbLD_hist_item_wo_or(n).Install_Required;
			rcRecOfTab.Supplier_Id(n) := itbLD_hist_item_wo_or(n).Supplier_Id;
			rcRecOfTab.Order_Id(n) := itbLD_hist_item_wo_or(n).Order_Id;
			rcRecOfTab.Register_Date(n) := itbLD_hist_item_wo_or(n).Register_Date;
			rcRecOfTab.Con_User(n) := itbLD_hist_item_wo_or(n).Con_User;
			rcRecOfTab.Terminal(n) := itbLD_hist_item_wo_or(n).Terminal;
			rcRecOfTab.Ip_Address(n) := itbLD_hist_item_wo_or(n).Ip_Address;
			rcRecOfTab.Mac_Addrees(n) := itbLD_hist_item_wo_or(n).Mac_Addrees;
			rcRecOfTab.row_id(n) := itbLD_hist_item_wo_or(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuHIST_ITEM_WO_OR_Id
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
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuHIST_ITEM_WO_OR_Id = rcData.HIST_ITEM_WO_OR_Id
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
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		Load
		(
			inuHIST_ITEM_WO_OR_Id
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
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		orcRecord out nocopy styLD_hist_item_wo_or
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN styLD_hist_item_wo_or
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type
	)
	RETURN styLD_hist_item_wo_or
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_hist_item_wo_or
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_hist_item_wo_or
	)
	IS
		rfLD_hist_item_wo_or tyrfLD_hist_item_wo_or;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_hist_item_wo_or.Hist_Item_Wo_Or_Id,
		            LD_hist_item_wo_or.Item_Work_Order_Id,
		            LD_hist_item_wo_or.Article_Id,
		            LD_hist_item_wo_or.Order_Activity_Id,
		            LD_hist_item_wo_or.Last_Amount,
		            LD_hist_item_wo_or.Current_Amount,
		            LD_hist_item_wo_or.Value,
		            LD_hist_item_wo_or.Last_Iva,
		            LD_hist_item_wo_or.Current_Iva,
		            LD_hist_item_wo_or.Credit_Fees,
		            LD_hist_item_wo_or.Install_Required,
		            LD_hist_item_wo_or.Supplier_Id,
		            LD_hist_item_wo_or.Order_Id,
		            LD_hist_item_wo_or.Register_Date,
		            LD_hist_item_wo_or.Con_User,
		            LD_hist_item_wo_or.Terminal,
		            LD_hist_item_wo_or.Ip_Address,
		            LD_hist_item_wo_or.Mac_Addrees,
		            LD_hist_item_wo_or.rowid
                FROM LD_hist_item_wo_or';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_hist_item_wo_or for sbFullQuery;
		fetch rfLD_hist_item_wo_or bulk collect INTO otbResult;
		close rfLD_hist_item_wo_or;

	EXCEPTION
		when others then
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
		sbSQL  VARCHAR2 (32000) := 'select
		            LD_hist_item_wo_or.Hist_Item_Wo_Or_Id,
		            LD_hist_item_wo_or.Item_Work_Order_Id,
		            LD_hist_item_wo_or.Article_Id,
		            LD_hist_item_wo_or.Order_Activity_Id,
		            LD_hist_item_wo_or.Last_Amount,
		            LD_hist_item_wo_or.Current_Amount,
		            LD_hist_item_wo_or.Value,
		            LD_hist_item_wo_or.Last_Iva,
		            LD_hist_item_wo_or.Current_Iva,
		            LD_hist_item_wo_or.Credit_Fees,
		            LD_hist_item_wo_or.Install_Required,
		            LD_hist_item_wo_or.Supplier_Id,
		            LD_hist_item_wo_or.Order_Id,
		            LD_hist_item_wo_or.Register_Date,
		            LD_hist_item_wo_or.Con_User,
		            LD_hist_item_wo_or.Terminal,
		            LD_hist_item_wo_or.Ip_Address,
		            LD_hist_item_wo_or.Mac_Addrees,
		            LD_hist_item_wo_or.rowid
                FROM LD_hist_item_wo_or';
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
		ircLD_hist_item_wo_or in styLD_hist_item_wo_or
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_hist_item_wo_or,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_hist_item_wo_or in styLD_hist_item_wo_or,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_hist_item_wo_or.HIST_ITEM_WO_OR_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|HIST_ITEM_WO_OR_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_hist_item_wo_or
		(
			Hist_Item_Wo_Or_Id,
			Item_Work_Order_Id,
			Article_Id,
			Order_Activity_Id,
			Last_Amount,
			Current_Amount,
			Value,
			Last_Iva,
			Current_Iva,
			Credit_Fees,
			Install_Required,
			Supplier_Id,
			Order_Id,
			Register_Date,
			Con_User,
			Terminal,
			Ip_Address,
			Mac_Addrees
		)
		values
		(
			ircLD_hist_item_wo_or.Hist_Item_Wo_Or_Id,
			ircLD_hist_item_wo_or.Item_Work_Order_Id,
			ircLD_hist_item_wo_or.Article_Id,
			ircLD_hist_item_wo_or.Order_Activity_Id,
			ircLD_hist_item_wo_or.Last_Amount,
			ircLD_hist_item_wo_or.Current_Amount,
			ircLD_hist_item_wo_or.Value,
			ircLD_hist_item_wo_or.Last_Iva,
			ircLD_hist_item_wo_or.Current_Iva,
			ircLD_hist_item_wo_or.Credit_Fees,
			ircLD_hist_item_wo_or.Install_Required,
			ircLD_hist_item_wo_or.Supplier_Id,
			ircLD_hist_item_wo_or.Order_Id,
			ircLD_hist_item_wo_or.Register_Date,
			ircLD_hist_item_wo_or.Con_User,
			ircLD_hist_item_wo_or.Terminal,
			ircLD_hist_item_wo_or.Ip_Address,
			ircLD_hist_item_wo_or.Mac_Addrees
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_hist_item_wo_or));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_hist_item_wo_or in out nocopy tytbLD_hist_item_wo_or
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_hist_item_wo_or, blUseRowID);
		forall n in iotbLD_hist_item_wo_or.first..iotbLD_hist_item_wo_or.last
			insert into LD_hist_item_wo_or
			(
			Hist_Item_Wo_Or_Id,
			Item_Work_Order_Id,
			Article_Id,
			Order_Activity_Id,
			Last_Amount,
			Current_Amount,
			Value,
			Last_Iva,
			Current_Iva,
			Credit_Fees,
			Install_Required,
			Supplier_Id,
			Order_Id,
			Register_Date,
			Con_User,
			Terminal,
			Ip_Address,
			Mac_Addrees
		)
		values
		(
			rcRecOfTab.Hist_Item_Wo_Or_Id(n),
			rcRecOfTab.Item_Work_Order_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Order_Activity_Id(n),
			rcRecOfTab.Last_Amount(n),
			rcRecOfTab.Current_Amount(n),
			rcRecOfTab.Value(n),
			rcRecOfTab.Last_Iva(n),
			rcRecOfTab.Current_Iva(n),
			rcRecOfTab.Credit_Fees(n),
			rcRecOfTab.Install_Required(n),
			rcRecOfTab.Supplier_Id(n),
			rcRecOfTab.Order_Id(n),
			rcRecOfTab.Register_Date(n),
			rcRecOfTab.Con_User(n),
			rcRecOfTab.Terminal(n),
			rcRecOfTab.Ip_Address(n),
			rcRecOfTab.Mac_Addrees(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		delete
		from LD_hist_item_wo_or
		where
       		HIST_ITEM_WO_OR_Id=inuHIST_ITEM_WO_OR_Id;
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
		iriRowID   in rowid,
		inuLock    in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLD_hist_item_wo_or;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_hist_item_wo_or
		where
			rowid = iriRowID
		returning
   HIST_ITEM_WO_OR_Id
		into
			rcError.HIST_ITEM_WO_OR_Id;

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
		iotbLD_hist_item_wo_or in out nocopy tytbLD_hist_item_wo_or,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_hist_item_wo_or;
	BEGIN
		FillRecordOfTables(iotbLD_hist_item_wo_or, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last
				delete
				from LD_hist_item_wo_or
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last loop
					LockByPk
					(
							rcRecOfTab.HIST_ITEM_WO_OR_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last
				delete
				from LD_hist_item_wo_or
				where
		         	HIST_ITEM_WO_OR_Id = rcRecOfTab.HIST_ITEM_WO_OR_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_hist_item_wo_or in styLD_hist_item_wo_or,
		inuLock	  in number default 0
	)
	IS
		nuHIST_ITEM_WO_OR_Id LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type;

	BEGIN
		if ircLD_hist_item_wo_or.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_hist_item_wo_or.rowid,rcData);
			end if;
			update LD_hist_item_wo_or
			set

        Item_Work_Order_Id = ircLD_hist_item_wo_or.Item_Work_Order_Id,
        Article_Id = ircLD_hist_item_wo_or.Article_Id,
        Order_Activity_Id = ircLD_hist_item_wo_or.Order_Activity_Id,
        Last_Amount = ircLD_hist_item_wo_or.Last_Amount,
        Current_Amount = ircLD_hist_item_wo_or.Current_Amount,
        Value = ircLD_hist_item_wo_or.Value,
        Last_Iva = ircLD_hist_item_wo_or.Last_Iva,
        Current_Iva = ircLD_hist_item_wo_or.Current_Iva,
        Credit_Fees = ircLD_hist_item_wo_or.Credit_Fees,
        Install_Required = ircLD_hist_item_wo_or.Install_Required,
        Supplier_Id = ircLD_hist_item_wo_or.Supplier_Id,
        Order_Id = ircLD_hist_item_wo_or.Order_Id,
        Register_Date = ircLD_hist_item_wo_or.Register_Date,
        Con_User = ircLD_hist_item_wo_or.Con_User,
        Terminal = ircLD_hist_item_wo_or.Terminal,
        Ip_Address = ircLD_hist_item_wo_or.Ip_Address,
        Mac_Addrees = ircLD_hist_item_wo_or.Mac_Addrees
			where
				rowid = ircLD_hist_item_wo_or.rowid
			returning
    HIST_ITEM_WO_OR_Id
			into
				nuHIST_ITEM_WO_OR_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_hist_item_wo_or.HIST_ITEM_WO_OR_Id,
					rcData
				);
			end if;

			update LD_hist_item_wo_or
			set
        Item_Work_Order_Id = ircLD_hist_item_wo_or.Item_Work_Order_Id,
        Article_Id = ircLD_hist_item_wo_or.Article_Id,
        Order_Activity_Id = ircLD_hist_item_wo_or.Order_Activity_Id,
        Last_Amount = ircLD_hist_item_wo_or.Last_Amount,
        Current_Amount = ircLD_hist_item_wo_or.Current_Amount,
        Value = ircLD_hist_item_wo_or.Value,
        Last_Iva = ircLD_hist_item_wo_or.Last_Iva,
        Current_Iva = ircLD_hist_item_wo_or.Current_Iva,
        Credit_Fees = ircLD_hist_item_wo_or.Credit_Fees,
        Install_Required = ircLD_hist_item_wo_or.Install_Required,
        Supplier_Id = ircLD_hist_item_wo_or.Supplier_Id,
        Order_Id = ircLD_hist_item_wo_or.Order_Id,
        Register_Date = ircLD_hist_item_wo_or.Register_Date,
        Con_User = ircLD_hist_item_wo_or.Con_User,
        Terminal = ircLD_hist_item_wo_or.Terminal,
        Ip_Address = ircLD_hist_item_wo_or.Ip_Address,
        Mac_Addrees = ircLD_hist_item_wo_or.Mac_Addrees
			where
	         	HIST_ITEM_WO_OR_Id = ircLD_hist_item_wo_or.HIST_ITEM_WO_OR_Id
			returning
    HIST_ITEM_WO_OR_Id
			into
				nuHIST_ITEM_WO_OR_Id;
		end if;

		if
			nuHIST_ITEM_WO_OR_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_hist_item_wo_or));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_hist_item_wo_or in out nocopy tytbLD_hist_item_wo_or,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_hist_item_wo_or;
  BEGIN
    FillRecordOfTables(iotbLD_hist_item_wo_or,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last
        update LD_hist_item_wo_or
        set

            Item_Work_Order_Id = rcRecOfTab.Item_Work_Order_Id(n),
            Article_Id = rcRecOfTab.Article_Id(n),
            Order_Activity_Id = rcRecOfTab.Order_Activity_Id(n),
            Last_Amount = rcRecOfTab.Last_Amount(n),
            Current_Amount = rcRecOfTab.Current_Amount(n),
            Value = rcRecOfTab.Value(n),
            Last_Iva = rcRecOfTab.Last_Iva(n),
            Current_Iva = rcRecOfTab.Current_Iva(n),
            Credit_Fees = rcRecOfTab.Credit_Fees(n),
            Install_Required = rcRecOfTab.Install_Required(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Order_Id = rcRecOfTab.Order_Id(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Con_User = rcRecOfTab.Con_User(n),
            Terminal = rcRecOfTab.Terminal(n),
            Ip_Address = rcRecOfTab.Ip_Address(n),
            Mac_Addrees = rcRecOfTab.Mac_Addrees(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last loop
          LockByPk
          (
              rcRecOfTab.HIST_ITEM_WO_OR_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_hist_item_wo_or.first .. iotbLD_hist_item_wo_or.last
        update LD_hist_item_wo_or
        set
					Item_Work_Order_Id = rcRecOfTab.Item_Work_Order_Id(n),
					Article_Id = rcRecOfTab.Article_Id(n),
					Order_Activity_Id = rcRecOfTab.Order_Activity_Id(n),
					Last_Amount = rcRecOfTab.Last_Amount(n),
					Current_Amount = rcRecOfTab.Current_Amount(n),
					Value = rcRecOfTab.Value(n),
					Last_Iva = rcRecOfTab.Last_Iva(n),
					Current_Iva = rcRecOfTab.Current_Iva(n),
					Credit_Fees = rcRecOfTab.Credit_Fees(n),
					Install_Required = rcRecOfTab.Install_Required(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n),
					Order_Id = rcRecOfTab.Order_Id(n),
					Register_Date = rcRecOfTab.Register_Date(n),
					Con_User = rcRecOfTab.Con_User(n),
					Terminal = rcRecOfTab.Terminal(n),
					Ip_Address = rcRecOfTab.Ip_Address(n),
					Mac_Addrees = rcRecOfTab.Mac_Addrees(n)
          where
          HIST_ITEM_WO_OR_Id = rcRecOfTab.HIST_ITEM_WO_OR_Id(n)
;
    end if;
  END;

	PROCEDURE updItem_Work_Order_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuItem_Work_Order_Id$ in LD_hist_item_wo_or.Item_Work_Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Item_Work_Order_Id = inuItem_Work_Order_Id$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Item_Work_Order_Id:= inuItem_Work_Order_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updArticle_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuArticle_Id$ in LD_hist_item_wo_or.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Article_Id = inuArticle_Id$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Article_Id:= inuArticle_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updOrder_Activity_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuOrder_Activity_Id$ in LD_hist_item_wo_or.Order_Activity_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Order_Activity_Id = inuOrder_Activity_Id$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Activity_Id:= inuOrder_Activity_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLast_Amount
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuLast_Amount$ in LD_hist_item_wo_or.Last_Amount%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Last_Amount = inuLast_Amount$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Last_Amount:= inuLast_Amount$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCurrent_Amount
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuCurrent_Amount$ in LD_hist_item_wo_or.Current_Amount%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Current_Amount = inuCurrent_Amount$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Current_Amount:= inuCurrent_Amount$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuValue$ in LD_hist_item_wo_or.Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Value = inuValue$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value:= inuValue$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLast_Iva
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuLast_Iva$ in LD_hist_item_wo_or.Last_Iva%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Last_Iva = inuLast_Iva$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Last_Iva:= inuLast_Iva$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCurrent_Iva
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuCurrent_Iva$ in LD_hist_item_wo_or.Current_Iva%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Current_Iva = inuCurrent_Iva$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Current_Iva:= inuCurrent_Iva$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCredit_Fees
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuCredit_Fees$ in LD_hist_item_wo_or.Credit_Fees%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Credit_Fees = inuCredit_Fees$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Credit_Fees:= inuCredit_Fees$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInstall_Required
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		isbInstall_Required$ in LD_hist_item_wo_or.Install_Required%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Install_Required = isbInstall_Required$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Install_Required:= isbInstall_Required$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuSupplier_Id$ in LD_hist_item_wo_or.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Supplier_Id = inuSupplier_Id$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updOrder_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuOrder_Id$ in LD_hist_item_wo_or.Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Order_Id = inuOrder_Id$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Id:= inuOrder_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		idtRegister_Date$ in LD_hist_item_wo_or.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Register_Date = idtRegister_Date$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCon_User
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		isbCon_User$ in LD_hist_item_wo_or.Con_User%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Con_User = isbCon_User$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Con_User:= isbCon_User$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTerminal
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		isbTerminal$ in LD_hist_item_wo_or.Terminal%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Terminal = isbTerminal$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Terminal:= isbTerminal$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updIp_Address
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		isbIp_Address$ in LD_hist_item_wo_or.Ip_Address%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Ip_Address = isbIp_Address$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Ip_Address:= isbIp_Address$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updMac_Addrees
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		isbMac_Addrees$ in LD_hist_item_wo_or.Mac_Addrees%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN
		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;
		if inuLock=1 then
			LockByPk
			(
				inuHIST_ITEM_WO_OR_Id,
				rcData
			);
		end if;

		update LD_hist_item_wo_or
		set
			Mac_Addrees = isbMac_Addrees$
		where
			HIST_ITEM_WO_OR_Id = inuHIST_ITEM_WO_OR_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Mac_Addrees:= isbMac_Addrees$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetHist_Item_Wo_Or_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Hist_Item_Wo_Or_Id%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Hist_Item_Wo_Or_Id);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Hist_Item_Wo_Or_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetItem_Work_Order_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Item_Work_Order_Id%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Item_Work_Order_Id);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Item_Work_Order_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetArticle_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Article_Id%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Article_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOrder_Activity_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Order_Activity_Id%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Order_Activity_Id);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Order_Activity_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLast_Amount
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Last_Amount%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Last_Amount);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Last_Amount);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCurrent_Amount
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Current_Amount%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Current_Amount);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Current_Amount);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetValue
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Value%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Value);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Value);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLast_Iva
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Last_Iva%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Last_Iva);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Last_Iva);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCurrent_Iva
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Current_Iva%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Current_Iva);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Current_Iva);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCredit_Fees
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Credit_Fees%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Credit_Fees);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Credit_Fees);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetInstall_Required
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Install_Required%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Install_Required);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Install_Required);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSupplier_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Supplier_Id%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Supplier_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOrder_Id
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Order_Id%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id := inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Order_Id);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Order_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetRegister_Date
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Register_Date%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Register_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetCon_User
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Con_User%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Con_User);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Con_User);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetTerminal
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Terminal%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Terminal);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Terminal);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetIp_Address
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Ip_Address%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Ip_Address);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Ip_Address);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetMac_Addrees
	(
		inuHIST_ITEM_WO_OR_Id in LD_hist_item_wo_or.HIST_ITEM_WO_OR_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_hist_item_wo_or.Mac_Addrees%type
	IS
		rcError styLD_hist_item_wo_or;
	BEGIN

		rcError.HIST_ITEM_WO_OR_Id:=inuHIST_ITEM_WO_OR_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuHIST_ITEM_WO_OR_Id
			 )
		then
			 return(rcData.Mac_Addrees);
		end if;
		Load
		(
			inuHIST_ITEM_WO_OR_Id
		);
		return(rcData.Mac_Addrees);
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
end DALD_hist_item_wo_or;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_HIST_ITEM_WO_OR
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_HIST_ITEM_WO_OR', 'ADM_PERSON'); 
END;
/
