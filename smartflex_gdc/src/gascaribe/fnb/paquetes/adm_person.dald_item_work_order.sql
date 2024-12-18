CREATE OR REPLACE PACKAGE adm_person.DALD_item_work_order
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
  )
  IS
		SELECT LD_item_work_order.*,LD_item_work_order.rowid
		FROM LD_item_work_order
		WHERE
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_item_work_order.*,LD_item_work_order.rowid
		FROM LD_item_work_order
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_item_work_order  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_item_work_order is table of styLD_item_work_order index by binary_integer;
	type tyrfRecords is ref cursor return styLD_item_work_order;

	/* Tipos referenciando al registro */
	type tytbItem_Work_Order_Id is table of LD_item_work_order.Item_Work_Order_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_item_work_order.Article_Id%type index by binary_integer;
	type tytbOrder_Activity_Id is table of LD_item_work_order.Order_Activity_Id%type index by binary_integer;
	type tytbAmount is table of LD_item_work_order.Amount%type index by binary_integer;
	type tytbValue is table of LD_item_work_order.Value%type index by binary_integer;
	type tytbIva is table of LD_item_work_order.Iva%type index by binary_integer;
	type tytbCredit_Fees is table of LD_item_work_order.Credit_Fees%type index by binary_integer;
	type tytbInstall_Required is table of LD_item_work_order.Install_Required%type index by binary_integer;
	type tytbSupplier_Id is table of LD_item_work_order.Supplier_Id%type index by binary_integer;
	type tytbOrder_Id is table of LD_item_work_order.Order_Id%type index by binary_integer;
	type tytbDifecodi is table of LD_item_work_order.Difecodi%type index by binary_integer;
	type tytbState is table of LD_item_work_order.State%type index by binary_integer;
	type tytbFinan_Plan_Id is table of LD_item_work_order.Finan_Plan_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_item_work_order is record
	(

		Item_Work_Order_Id   tytbItem_Work_Order_Id,
		Article_Id   tytbArticle_Id,
		Order_Activity_Id   tytbOrder_Activity_Id,
		Amount   tytbAmount,
		Value   tytbValue,
		Iva   tytbIva,
		Credit_Fees   tytbCredit_Fees,
		Install_Required   tytbInstall_Required,
		Supplier_Id   tytbSupplier_Id,
		Order_Id   tytbOrder_Id,
		Difecodi   tytbDifecodi,
		State   tytbState,
		Finan_Plan_Id   tytbFinan_Plan_Id,
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	);

	PROCEDURE getRecord
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		orcRecord out nocopy styLD_item_work_order
	);

	FUNCTION frcGetRcData
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN styLD_item_work_order;

	FUNCTION frcGetRcData
	RETURN styLD_item_work_order;

	FUNCTION frcGetRecord
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN styLD_item_work_order;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_item_work_order
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_item_work_order in styLD_item_work_order
	);

 	  PROCEDURE insRecord
	(
		ircLD_item_work_order in styLD_item_work_order,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_item_work_order in out nocopy tytbLD_item_work_order
	);

	PROCEDURE delRecord
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_item_work_order in out nocopy tytbLD_item_work_order,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_item_work_order in styLD_item_work_order,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_item_work_order in out nocopy tytbLD_item_work_order,
		inuLock in number default 1
	);

		PROCEDURE updArticle_Id
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuArticle_Id$  in LD_item_work_order.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updOrder_Activity_Id
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuOrder_Activity_Id$  in LD_item_work_order.Order_Activity_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updAmount
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuAmount$  in LD_item_work_order.Amount%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValue
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuValue$  in LD_item_work_order.Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updIva
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuIva$  in LD_item_work_order.Iva%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCredit_Fees
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuCredit_Fees$  in LD_item_work_order.Credit_Fees%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInstall_Required
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				isbInstall_Required$  in LD_item_work_order.Install_Required%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuSupplier_Id$  in LD_item_work_order.Supplier_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updOrder_Id
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuOrder_Id$  in LD_item_work_order.Order_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDifecodi
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuDifecodi$  in LD_item_work_order.Difecodi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updState
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				isbState$  in LD_item_work_order.State%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinan_Plan_Id
		(
				inuITEM_WORK_ORDER_Id   in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
				inuFinan_Plan_Id$  in LD_item_work_order.Finan_Plan_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetItem_Work_Order_Id
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Item_Work_Order_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Article_Id%type;

    	FUNCTION fnuGetOrder_Activity_Id
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Order_Activity_Id%type;

    	FUNCTION fnuGetAmount
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Amount%type;

    	FUNCTION fnuGetValue
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Value%type;

    	FUNCTION fnuGetIva
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Iva%type;

    	FUNCTION fnuGetCredit_Fees
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Credit_Fees%type;

    	FUNCTION fsbGetInstall_Required
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Install_Required%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Supplier_Id%type;

    	FUNCTION fnuGetOrder_Id
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Order_Id%type;

    	FUNCTION fnuGetDifecodi
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Difecodi%type;

    	FUNCTION fsbGetState
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.State%type;

    	FUNCTION fnuGetFinan_Plan_Id
    	(
    	    inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_item_work_order.Finan_Plan_Id%type;


	PROCEDURE LockByPk
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		orcLD_item_work_order  out styLD_item_work_order
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_item_work_order  out styLD_item_work_order
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_item_work_order;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_item_work_order
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_ITEM_WORK_ORDER';
	  cnuGeEntityId constant varchar2(30) := 8648; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	IS
		SELECT LD_item_work_order.*,LD_item_work_order.rowid
		FROM LD_item_work_order
		WHERE  ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_item_work_order.*,LD_item_work_order.rowid
		FROM LD_item_work_order
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_item_work_order is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_item_work_order;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_item_work_order default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ITEM_WORK_ORDER_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		orcLD_item_work_order  out styLD_item_work_order
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		Open cuLockRcByPk
		(
			inuITEM_WORK_ORDER_Id
		);

		fetch cuLockRcByPk into orcLD_item_work_order;
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
		orcLD_item_work_order  out styLD_item_work_order
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_item_work_order;
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
		itbLD_item_work_order  in out nocopy tytbLD_item_work_order
	)
	IS
	BEGIN
			rcRecOfTab.Item_Work_Order_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Order_Activity_Id.delete;
			rcRecOfTab.Amount.delete;
			rcRecOfTab.Value.delete;
			rcRecOfTab.Iva.delete;
			rcRecOfTab.Credit_Fees.delete;
			rcRecOfTab.Install_Required.delete;
			rcRecOfTab.Supplier_Id.delete;
			rcRecOfTab.Order_Id.delete;
			rcRecOfTab.Difecodi.delete;
			rcRecOfTab.State.delete;
			rcRecOfTab.Finan_Plan_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_item_work_order  in out nocopy tytbLD_item_work_order,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_item_work_order);
		for n in itbLD_item_work_order.first .. itbLD_item_work_order.last loop
			rcRecOfTab.Item_Work_Order_Id(n) := itbLD_item_work_order(n).Item_Work_Order_Id;
			rcRecOfTab.Article_Id(n) := itbLD_item_work_order(n).Article_Id;
			rcRecOfTab.Order_Activity_Id(n) := itbLD_item_work_order(n).Order_Activity_Id;
			rcRecOfTab.Amount(n) := itbLD_item_work_order(n).Amount;
			rcRecOfTab.Value(n) := itbLD_item_work_order(n).Value;
			rcRecOfTab.Iva(n) := itbLD_item_work_order(n).Iva;
			rcRecOfTab.Credit_Fees(n) := itbLD_item_work_order(n).Credit_Fees;
			rcRecOfTab.Install_Required(n) := itbLD_item_work_order(n).Install_Required;
			rcRecOfTab.Supplier_Id(n) := itbLD_item_work_order(n).Supplier_Id;
			rcRecOfTab.Order_Id(n) := itbLD_item_work_order(n).Order_Id;
			rcRecOfTab.Difecodi(n) := itbLD_item_work_order(n).Difecodi;
			rcRecOfTab.State(n) := itbLD_item_work_order(n).State;
			rcRecOfTab.Finan_Plan_Id(n) := itbLD_item_work_order(n).Finan_Plan_Id;
			rcRecOfTab.row_id(n) := itbLD_item_work_order(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuITEM_WORK_ORDER_Id = rcData.ITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	IS
		rcError styLD_item_work_order;
	BEGIN		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;

		Load
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		orcRecord out nocopy styLD_item_work_order
	)
	IS
		rcError styLD_item_work_order;
	BEGIN		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;

		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN styLD_item_work_order
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;

		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type
	)
	RETURN styLD_item_work_order
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_item_work_order
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_item_work_order
	)
	IS
		rfLD_item_work_order tyrfLD_item_work_order;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_item_work_order.Item_Work_Order_Id,
		            LD_item_work_order.Article_Id,
		            LD_item_work_order.Order_Activity_Id,
		            LD_item_work_order.Amount,
		            LD_item_work_order.Value,
		            LD_item_work_order.Iva,
		            LD_item_work_order.Credit_Fees,
		            LD_item_work_order.Install_Required,
		            LD_item_work_order.Supplier_Id,
		            LD_item_work_order.Order_Id,
		            LD_item_work_order.Difecodi,
		            LD_item_work_order.State,
		            LD_item_work_order.Finan_Plan_Id,
		            LD_item_work_order.rowid
                FROM LD_item_work_order';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_item_work_order for sbFullQuery;
		fetch rfLD_item_work_order bulk collect INTO otbResult;
		close rfLD_item_work_order;
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
		sbSQL  VARCHAR2 (32000) := 'select
		            LD_item_work_order.Item_Work_Order_Id,
		            LD_item_work_order.Article_Id,
		            LD_item_work_order.Order_Activity_Id,
		            LD_item_work_order.Amount,
		            LD_item_work_order.Value,
		            LD_item_work_order.Iva,
		            LD_item_work_order.Credit_Fees,
		            LD_item_work_order.Install_Required,
		            LD_item_work_order.Supplier_Id,
		            LD_item_work_order.Order_Id,
		            LD_item_work_order.Difecodi,
		            LD_item_work_order.State,
		            LD_item_work_order.Finan_Plan_Id,
		            LD_item_work_order.rowid
                FROM LD_item_work_order';
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
		ircLD_item_work_order in styLD_item_work_order
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_item_work_order,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_item_work_order in styLD_item_work_order,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_item_work_order.ITEM_WORK_ORDER_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ITEM_WORK_ORDER_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_item_work_order
		(
			Item_Work_Order_Id,
			Article_Id,
			Order_Activity_Id,
			Amount,
			Value,
			Iva,
			Credit_Fees,
			Install_Required,
			Supplier_Id,
			Order_Id,
			Difecodi,
			State,
			Finan_Plan_Id
		)
		values
		(
			ircLD_item_work_order.Item_Work_Order_Id,
			ircLD_item_work_order.Article_Id,
			ircLD_item_work_order.Order_Activity_Id,
			ircLD_item_work_order.Amount,
			ircLD_item_work_order.Value,
			ircLD_item_work_order.Iva,
			ircLD_item_work_order.Credit_Fees,
			ircLD_item_work_order.Install_Required,
			ircLD_item_work_order.Supplier_Id,
			ircLD_item_work_order.Order_Id,
			ircLD_item_work_order.Difecodi,
			ircLD_item_work_order.State,
			ircLD_item_work_order.Finan_Plan_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_item_work_order));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_item_work_order in out nocopy tytbLD_item_work_order
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_item_work_order, blUseRowID);
		forall n in iotbLD_item_work_order.first..iotbLD_item_work_order.last
			insert into LD_item_work_order
			(
			Item_Work_Order_Id,
			Article_Id,
			Order_Activity_Id,
			Amount,
			Value,
			Iva,
			Credit_Fees,
			Install_Required,
			Supplier_Id,
			Order_Id,
			Difecodi,
			State,
			Finan_Plan_Id
		)
		values
		(
			rcRecOfTab.Item_Work_Order_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Order_Activity_Id(n),
			rcRecOfTab.Amount(n),
			rcRecOfTab.Value(n),
			rcRecOfTab.Iva(n),
			rcRecOfTab.Credit_Fees(n),
			rcRecOfTab.Install_Required(n),
			rcRecOfTab.Supplier_Id(n),
			rcRecOfTab.Order_Id(n),
			rcRecOfTab.Difecodi(n),
			rcRecOfTab.State(n),
			rcRecOfTab.Finan_Plan_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;

		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		delete
		from LD_item_work_order
		where
       		ITEM_WORK_ORDER_Id=inuITEM_WORK_ORDER_Id;
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
		rcError  styLD_item_work_order;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_item_work_order
		where
			rowid = iriRowID
		returning
   ITEM_WORK_ORDER_Id
		into
			rcError.ITEM_WORK_ORDER_Id;

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
		iotbLD_item_work_order in out nocopy tytbLD_item_work_order,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_item_work_order;
	BEGIN
		FillRecordOfTables(iotbLD_item_work_order, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last
				delete
				from LD_item_work_order
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last loop
					LockByPk
					(
							rcRecOfTab.ITEM_WORK_ORDER_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last
				delete
				from LD_item_work_order
				where
		         	ITEM_WORK_ORDER_Id = rcRecOfTab.ITEM_WORK_ORDER_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_item_work_order in styLD_item_work_order,
		inuLock	  in number default 0
	)
	IS
		nuITEM_WORK_ORDER_Id LD_item_work_order.ITEM_WORK_ORDER_Id%type;

	BEGIN
		if ircLD_item_work_order.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_item_work_order.rowid,rcData);
			end if;
			update LD_item_work_order
			set

        Article_Id = ircLD_item_work_order.Article_Id,
        Order_Activity_Id = ircLD_item_work_order.Order_Activity_Id,
        Amount = ircLD_item_work_order.Amount,
        Value = ircLD_item_work_order.Value,
        Iva = ircLD_item_work_order.Iva,
        Credit_Fees = ircLD_item_work_order.Credit_Fees,
        Install_Required = ircLD_item_work_order.Install_Required,
        Supplier_Id = ircLD_item_work_order.Supplier_Id,
        Order_Id = ircLD_item_work_order.Order_Id,
        Difecodi = ircLD_item_work_order.Difecodi,
        State = ircLD_item_work_order.State,
        Finan_Plan_Id = ircLD_item_work_order.Finan_Plan_Id
			where
				rowid = ircLD_item_work_order.rowid
			returning
    ITEM_WORK_ORDER_Id
			into
				nuITEM_WORK_ORDER_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_item_work_order.ITEM_WORK_ORDER_Id,
					rcData
				);
			end if;

			update LD_item_work_order
			set
        Article_Id = ircLD_item_work_order.Article_Id,
        Order_Activity_Id = ircLD_item_work_order.Order_Activity_Id,
        Amount = ircLD_item_work_order.Amount,
        Value = ircLD_item_work_order.Value,
        Iva = ircLD_item_work_order.Iva,
        Credit_Fees = ircLD_item_work_order.Credit_Fees,
        Install_Required = ircLD_item_work_order.Install_Required,
        Supplier_Id = ircLD_item_work_order.Supplier_Id,
        Order_Id = ircLD_item_work_order.Order_Id,
        Difecodi = ircLD_item_work_order.Difecodi,
        State = ircLD_item_work_order.State,
        Finan_Plan_Id = ircLD_item_work_order.Finan_Plan_Id
			where
	         	ITEM_WORK_ORDER_Id = ircLD_item_work_order.ITEM_WORK_ORDER_Id
			returning
    ITEM_WORK_ORDER_Id
			into
				nuITEM_WORK_ORDER_Id;
		end if;

		if
			nuITEM_WORK_ORDER_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_item_work_order));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_item_work_order in out nocopy tytbLD_item_work_order,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_item_work_order;
  BEGIN
    FillRecordOfTables(iotbLD_item_work_order,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last
        update LD_item_work_order
        set

            Article_Id = rcRecOfTab.Article_Id(n),
            Order_Activity_Id = rcRecOfTab.Order_Activity_Id(n),
            Amount = rcRecOfTab.Amount(n),
            Value = rcRecOfTab.Value(n),
            Iva = rcRecOfTab.Iva(n),
            Credit_Fees = rcRecOfTab.Credit_Fees(n),
            Install_Required = rcRecOfTab.Install_Required(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Order_Id = rcRecOfTab.Order_Id(n),
            Difecodi = rcRecOfTab.Difecodi(n),
            State = rcRecOfTab.State(n),
            Finan_Plan_Id = rcRecOfTab.Finan_Plan_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last loop
          LockByPk
          (
              rcRecOfTab.ITEM_WORK_ORDER_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_item_work_order.first .. iotbLD_item_work_order.last
        update LD_item_work_order
        set
					Article_Id = rcRecOfTab.Article_Id(n),
					Order_Activity_Id = rcRecOfTab.Order_Activity_Id(n),
					Amount = rcRecOfTab.Amount(n),
					Value = rcRecOfTab.Value(n),
					Iva = rcRecOfTab.Iva(n),
					Credit_Fees = rcRecOfTab.Credit_Fees(n),
					Install_Required = rcRecOfTab.Install_Required(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n),
					Order_Id = rcRecOfTab.Order_Id(n),
					Difecodi = rcRecOfTab.Difecodi(n),
					State = rcRecOfTab.State(n),
					Finan_Plan_Id = rcRecOfTab.Finan_Plan_Id(n)
          where
          ITEM_WORK_ORDER_Id = rcRecOfTab.ITEM_WORK_ORDER_Id(n)
;
    end if;
  END;

	PROCEDURE updArticle_Id
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuArticle_Id$ in LD_item_work_order.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Article_Id = inuArticle_Id$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuOrder_Activity_Id$ in LD_item_work_order.Order_Activity_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Order_Activity_Id = inuOrder_Activity_Id$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Activity_Id:= inuOrder_Activity_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updAmount
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuAmount$ in LD_item_work_order.Amount%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Amount = inuAmount$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Amount:= inuAmount$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuValue$ in LD_item_work_order.Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Value = inuValue$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value:= inuValue$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updIva
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuIva$ in LD_item_work_order.Iva%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Iva = inuIva$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Iva:= inuIva$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCredit_Fees
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuCredit_Fees$ in LD_item_work_order.Credit_Fees%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Credit_Fees = inuCredit_Fees$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		isbInstall_Required$ in LD_item_work_order.Install_Required%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Install_Required = isbInstall_Required$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuSupplier_Id$ in LD_item_work_order.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Supplier_Id = inuSupplier_Id$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuOrder_Id$ in LD_item_work_order.Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Order_Id = inuOrder_Id$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Id:= inuOrder_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDifecodi
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuDifecodi$ in LD_item_work_order.Difecodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Difecodi = inuDifecodi$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Difecodi:= inuDifecodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updState
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		isbState$ in LD_item_work_order.State%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			State = isbState$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.State:= isbState$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFinan_Plan_Id
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuFinan_Plan_Id$ in LD_item_work_order.Finan_Plan_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_item_work_order;
	BEGIN
		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuITEM_WORK_ORDER_Id,
				rcData
			);
		end if;

		update LD_item_work_order
		set
			Finan_Plan_Id = inuFinan_Plan_Id$
		where
			ITEM_WORK_ORDER_Id = inuITEM_WORK_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Finan_Plan_Id:= inuFinan_Plan_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetItem_Work_Order_Id
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Item_Work_Order_Id%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Item_Work_Order_Id);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Article_Id%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Order_Activity_Id%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Order_Activity_Id);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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

	FUNCTION fnuGetAmount
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Amount%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Amount);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData.Amount);
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Value%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Value);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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

	FUNCTION fnuGetIva
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Iva%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Iva);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData.Iva);
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Credit_Fees%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Credit_Fees);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Install_Required%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Install_Required);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Supplier_Id%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Order_Id%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Order_Id);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
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

	FUNCTION fnuGetDifecodi
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Difecodi%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Difecodi);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData.Difecodi);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetState
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.State%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id:=inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.State);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData.State);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFinan_Plan_Id
	(
		inuITEM_WORK_ORDER_Id in LD_item_work_order.ITEM_WORK_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_item_work_order.Finan_Plan_Id%type
	IS
		rcError styLD_item_work_order;
	BEGIN

		rcError.ITEM_WORK_ORDER_Id := inuITEM_WORK_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuITEM_WORK_ORDER_Id
			 )
		then
			 return(rcData.Finan_Plan_Id);
		end if;
		Load
		(
			inuITEM_WORK_ORDER_Id
		);
		return(rcData.Finan_Plan_Id);
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
end DALD_item_work_order;
/
PROMPT Otorgando permisos de ejecucion a DALD_ITEM_WORK_ORDER
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_ITEM_WORK_ORDER', 'ADM_PERSON');
END;
/