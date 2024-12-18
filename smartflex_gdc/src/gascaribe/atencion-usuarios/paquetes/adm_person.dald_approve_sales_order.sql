CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_approve_sales_order
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/ 
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
  )
  IS
		SELECT LD_approve_sales_order.*,LD_approve_sales_order.rowid
		FROM LD_approve_sales_order
		WHERE
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_approve_sales_order.*,LD_approve_sales_order.rowid
		FROM LD_approve_sales_order
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_approve_sales_order  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_approve_sales_order is table of styLD_approve_sales_order index by binary_integer;
	type tyrfRecords is ref cursor return styLD_approve_sales_order;

	/* Tipos referenciando al registro */
	type tytbApprove_Sales_Order_Id is table of LD_approve_sales_order.Approve_Sales_Order_Id%type index by binary_integer;
	type tytbOrder_Id is table of LD_approve_sales_order.Order_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_approve_sales_order.Package_Id%type index by binary_integer;
	type tytbCausal_Id is table of LD_approve_sales_order.Causal_Id%type index by binary_integer;
	type tytbApproved is table of LD_approve_sales_order.Approved%type index by binary_integer;
	type tytbRegister_Date is table of LD_approve_sales_order.Register_Date%type index by binary_integer;
	type tytbApproved_Date is table of LD_approve_sales_order.Approved_Date%type index by binary_integer;
	type tytbUser_Name is table of LD_approve_sales_order.User_Name%type index by binary_integer;
	type tytbTerminal is table of LD_approve_sales_order.Terminal%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_approve_sales_order is record
	(

		Approve_Sales_Order_Id   tytbApprove_Sales_Order_Id,
		Order_Id   tytbOrder_Id,
		Package_Id   tytbPackage_Id,
		Causal_Id   tytbCausal_Id,
		Approved   tytbApproved,
		Register_Date   tytbRegister_Date,
		Approved_Date   tytbApproved_Date,
		User_Name   tytbUser_Name,
		Terminal   tytbTerminal,
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	);

	PROCEDURE getRecord
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		orcRecord out nocopy styLD_approve_sales_order
	);

	FUNCTION frcGetRcData
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN styLD_approve_sales_order;

	FUNCTION frcGetRcData
	RETURN styLD_approve_sales_order;

	FUNCTION frcGetRecord
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN styLD_approve_sales_order;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_approve_sales_order
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_approve_sales_order in styLD_approve_sales_order
	);

 	  PROCEDURE insRecord
	(
		ircLD_approve_sales_order in styLD_approve_sales_order,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_approve_sales_order in out nocopy tytbLD_approve_sales_order
	);

	PROCEDURE delRecord
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_approve_sales_order in out nocopy tytbLD_approve_sales_order,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_approve_sales_order in styLD_approve_sales_order,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_approve_sales_order in out nocopy tytbLD_approve_sales_order,
		inuLock in number default 1
	);

		PROCEDURE updOrder_Id
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				inuOrder_Id$  in LD_approve_sales_order.Order_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPackage_Id
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				inuPackage_Id$  in LD_approve_sales_order.Package_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCausal_Id
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				inuCausal_Id$  in LD_approve_sales_order.Causal_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproved
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				isbApproved$  in LD_approve_sales_order.Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRegister_Date
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				idtRegister_Date$  in LD_approve_sales_order.Register_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproved_Date
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				idtApproved_Date$  in LD_approve_sales_order.Approved_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUser_Name
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				isbUser_Name$  in LD_approve_sales_order.User_Name%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updTerminal
		(
				inuAPPROVE_SALES_ORDER_Id   in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
				isbTerminal$  in LD_approve_sales_order.Terminal%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetApprove_Sales_Order_Id
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Approve_Sales_Order_Id%type;

    	FUNCTION fnuGetOrder_Id
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Order_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Package_Id%type;

    	FUNCTION fnuGetCausal_Id
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Causal_Id%type;

    	FUNCTION fsbGetApproved
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Approved%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Register_Date%type;

    	FUNCTION fdtGetApproved_Date
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Approved_Date%type;

    	FUNCTION fsbGetUser_Name
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.User_Name%type;

    	FUNCTION fsbGetTerminal
    	(
    	    inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_approve_sales_order.Terminal%type;


	PROCEDURE LockByPk
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		orcLD_approve_sales_order  out styLD_approve_sales_order
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_approve_sales_order  out styLD_approve_sales_order
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_approve_sales_order;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_approve_sales_order
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_APPROVE_SALES_ORDER';
	  cnuGeEntityId constant varchar2(30) := 8302; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	IS
		SELECT LD_approve_sales_order.*,LD_approve_sales_order.rowid
		FROM LD_approve_sales_order
		WHERE  APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_approve_sales_order.*,LD_approve_sales_order.rowid
		FROM LD_approve_sales_order
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_approve_sales_order is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_approve_sales_order;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_approve_sales_order default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.APPROVE_SALES_ORDER_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		orcLD_approve_sales_order  out styLD_approve_sales_order
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;

		Open cuLockRcByPk
		(
			inuAPPROVE_SALES_ORDER_Id
		);

		fetch cuLockRcByPk into orcLD_approve_sales_order;
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
		orcLD_approve_sales_order  out styLD_approve_sales_order
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_approve_sales_order;
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
		itbLD_approve_sales_order  in out nocopy tytbLD_approve_sales_order
	)
	IS
	BEGIN
			rcRecOfTab.Approve_Sales_Order_Id.delete;
			rcRecOfTab.Order_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Causal_Id.delete;
			rcRecOfTab.Approved.delete;
			rcRecOfTab.Register_Date.delete;
			rcRecOfTab.Approved_Date.delete;
			rcRecOfTab.User_Name.delete;
			rcRecOfTab.Terminal.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_approve_sales_order  in out nocopy tytbLD_approve_sales_order,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_approve_sales_order);
		for n in itbLD_approve_sales_order.first .. itbLD_approve_sales_order.last loop
			rcRecOfTab.Approve_Sales_Order_Id(n) := itbLD_approve_sales_order(n).Approve_Sales_Order_Id;
			rcRecOfTab.Order_Id(n) := itbLD_approve_sales_order(n).Order_Id;
			rcRecOfTab.Package_Id(n) := itbLD_approve_sales_order(n).Package_Id;
			rcRecOfTab.Causal_Id(n) := itbLD_approve_sales_order(n).Causal_Id;
			rcRecOfTab.Approved(n) := itbLD_approve_sales_order(n).Approved;
			rcRecOfTab.Register_Date(n) := itbLD_approve_sales_order(n).Register_Date;
			rcRecOfTab.Approved_Date(n) := itbLD_approve_sales_order(n).Approved_Date;
			rcRecOfTab.User_Name(n) := itbLD_approve_sales_order(n).User_Name;
			rcRecOfTab.Terminal(n) := itbLD_approve_sales_order(n).Terminal;
			rcRecOfTab.row_id(n) := itbLD_approve_sales_order(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuAPPROVE_SALES_ORDER_Id
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuAPPROVE_SALES_ORDER_Id = rcData.APPROVE_SALES_ORDER_Id
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		Load
		(
			inuAPPROVE_SALES_ORDER_Id
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		orcRecord out nocopy styLD_approve_sales_order
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN styLD_approve_sales_order
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type
	)
	RETURN styLD_approve_sales_order
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_approve_sales_order
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_approve_sales_order
	)
	IS
		rfLD_approve_sales_order tyrfLD_approve_sales_order;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_approve_sales_order.Approve_Sales_Order_Id,
		            LD_approve_sales_order.Order_Id,
		            LD_approve_sales_order.Package_Id,
		            LD_approve_sales_order.Causal_Id,
		            LD_approve_sales_order.Approved,
		            LD_approve_sales_order.Register_Date,
		            LD_approve_sales_order.Approved_Date,
		            LD_approve_sales_order.User_Name,
		            LD_approve_sales_order.Terminal,
		            LD_approve_sales_order.rowid
                FROM LD_approve_sales_order';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_approve_sales_order for sbFullQuery;
		fetch rfLD_approve_sales_order bulk collect INTO otbResult;
		close rfLD_approve_sales_order;

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
		            LD_approve_sales_order.Approve_Sales_Order_Id,
		            LD_approve_sales_order.Order_Id,
		            LD_approve_sales_order.Package_Id,
		            LD_approve_sales_order.Causal_Id,
		            LD_approve_sales_order.Approved,
		            LD_approve_sales_order.Register_Date,
		            LD_approve_sales_order.Approved_Date,
		            LD_approve_sales_order.User_Name,
		            LD_approve_sales_order.Terminal,
		            LD_approve_sales_order.rowid
                FROM LD_approve_sales_order';
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
		ircLD_approve_sales_order in styLD_approve_sales_order
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_approve_sales_order,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_approve_sales_order in styLD_approve_sales_order,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_approve_sales_order.APPROVE_SALES_ORDER_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|APPROVE_SALES_ORDER_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_approve_sales_order
		(
			Approve_Sales_Order_Id,
			Order_Id,
			Package_Id,
			Causal_Id,
			Approved,
			Register_Date,
			Approved_Date,
			User_Name,
			Terminal
		)
		values
		(
			ircLD_approve_sales_order.Approve_Sales_Order_Id,
			ircLD_approve_sales_order.Order_Id,
			ircLD_approve_sales_order.Package_Id,
			ircLD_approve_sales_order.Causal_Id,
			ircLD_approve_sales_order.Approved,
			ircLD_approve_sales_order.Register_Date,
			ircLD_approve_sales_order.Approved_Date,
			ircLD_approve_sales_order.User_Name,
			ircLD_approve_sales_order.Terminal
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_approve_sales_order));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_approve_sales_order in out nocopy tytbLD_approve_sales_order
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_approve_sales_order, blUseRowID);
		forall n in iotbLD_approve_sales_order.first..iotbLD_approve_sales_order.last
			insert into LD_approve_sales_order
			(
			Approve_Sales_Order_Id,
			Order_Id,
			Package_Id,
			Causal_Id,
			Approved,
			Register_Date,
			Approved_Date,
			User_Name,
			Terminal
		)
		values
		(
			rcRecOfTab.Approve_Sales_Order_Id(n),
			rcRecOfTab.Order_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Causal_Id(n),
			rcRecOfTab.Approved(n),
			rcRecOfTab.Register_Date(n),
			rcRecOfTab.Approved_Date(n),
			rcRecOfTab.User_Name(n),
			rcRecOfTab.Terminal(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		delete
		from LD_approve_sales_order
		where
       		APPROVE_SALES_ORDER_Id=inuAPPROVE_SALES_ORDER_Id;
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
		rcError  styLD_approve_sales_order;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_approve_sales_order
		where
			rowid = iriRowID
		returning
   APPROVE_SALES_ORDER_Id
		into
			rcError.APPROVE_SALES_ORDER_Id;

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
		iotbLD_approve_sales_order in out nocopy tytbLD_approve_sales_order,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_approve_sales_order;
	BEGIN
		FillRecordOfTables(iotbLD_approve_sales_order, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last
				delete
				from LD_approve_sales_order
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last loop
					LockByPk
					(
							rcRecOfTab.APPROVE_SALES_ORDER_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last
				delete
				from LD_approve_sales_order
				where
		         	APPROVE_SALES_ORDER_Id = rcRecOfTab.APPROVE_SALES_ORDER_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_approve_sales_order in styLD_approve_sales_order,
		inuLock	  in number default 0
	)
	IS
		nuAPPROVE_SALES_ORDER_Id LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type;

	BEGIN
		if ircLD_approve_sales_order.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_approve_sales_order.rowid,rcData);
			end if;
			update LD_approve_sales_order
			set

        Order_Id = ircLD_approve_sales_order.Order_Id,
        Package_Id = ircLD_approve_sales_order.Package_Id,
        Causal_Id = ircLD_approve_sales_order.Causal_Id,
        Approved = ircLD_approve_sales_order.Approved,
        Register_Date = ircLD_approve_sales_order.Register_Date,
        Approved_Date = ircLD_approve_sales_order.Approved_Date,
        User_Name = ircLD_approve_sales_order.User_Name,
        Terminal = ircLD_approve_sales_order.Terminal
			where
				rowid = ircLD_approve_sales_order.rowid
			returning
    APPROVE_SALES_ORDER_Id
			into
				nuAPPROVE_SALES_ORDER_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_approve_sales_order.APPROVE_SALES_ORDER_Id,
					rcData
				);
			end if;

			update LD_approve_sales_order
			set
        Order_Id = ircLD_approve_sales_order.Order_Id,
        Package_Id = ircLD_approve_sales_order.Package_Id,
        Causal_Id = ircLD_approve_sales_order.Causal_Id,
        Approved = ircLD_approve_sales_order.Approved,
        Register_Date = ircLD_approve_sales_order.Register_Date,
        Approved_Date = ircLD_approve_sales_order.Approved_Date,
        User_Name = ircLD_approve_sales_order.User_Name,
        Terminal = ircLD_approve_sales_order.Terminal
			where
	         	APPROVE_SALES_ORDER_Id = ircLD_approve_sales_order.APPROVE_SALES_ORDER_Id
			returning
    APPROVE_SALES_ORDER_Id
			into
				nuAPPROVE_SALES_ORDER_Id;
		end if;

		if
			nuAPPROVE_SALES_ORDER_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_approve_sales_order));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_approve_sales_order in out nocopy tytbLD_approve_sales_order,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_approve_sales_order;
  BEGIN
    FillRecordOfTables(iotbLD_approve_sales_order,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last
        update LD_approve_sales_order
        set

            Order_Id = rcRecOfTab.Order_Id(n),
            Package_Id = rcRecOfTab.Package_Id(n),
            Causal_Id = rcRecOfTab.Causal_Id(n),
            Approved = rcRecOfTab.Approved(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Approved_Date = rcRecOfTab.Approved_Date(n),
            User_Name = rcRecOfTab.User_Name(n),
            Terminal = rcRecOfTab.Terminal(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last loop
          LockByPk
          (
              rcRecOfTab.APPROVE_SALES_ORDER_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_approve_sales_order.first .. iotbLD_approve_sales_order.last
        update LD_approve_sales_order
        set
					Order_Id = rcRecOfTab.Order_Id(n),
					Package_Id = rcRecOfTab.Package_Id(n),
					Causal_Id = rcRecOfTab.Causal_Id(n),
					Approved = rcRecOfTab.Approved(n),
					Register_Date = rcRecOfTab.Register_Date(n),
					Approved_Date = rcRecOfTab.Approved_Date(n),
					User_Name = rcRecOfTab.User_Name(n),
					Terminal = rcRecOfTab.Terminal(n)
          where
          APPROVE_SALES_ORDER_Id = rcRecOfTab.APPROVE_SALES_ORDER_Id(n)
;
    end if;
  END;

	PROCEDURE updOrder_Id
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuOrder_Id$ in LD_approve_sales_order.Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Order_Id = inuOrder_Id$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Id:= inuOrder_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPackage_Id
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuPackage_Id$ in LD_approve_sales_order.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Package_Id = inuPackage_Id$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCausal_Id
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuCausal_Id$ in LD_approve_sales_order.Causal_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Causal_Id = inuCausal_Id$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Causal_Id:= inuCausal_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApproved
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		isbApproved$ in LD_approve_sales_order.Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Approved = isbApproved$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Approved:= isbApproved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		idtRegister_Date$ in LD_approve_sales_order.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Register_Date = idtRegister_Date$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApproved_Date
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		idtApproved_Date$ in LD_approve_sales_order.Approved_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Approved_Date = idtApproved_Date$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Approved_Date:= idtApproved_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUser_Name
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		isbUser_Name$ in LD_approve_sales_order.User_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			User_Name = isbUser_Name$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.User_Name:= isbUser_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTerminal
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		isbTerminal$ in LD_approve_sales_order.Terminal%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_approve_sales_order;
	BEGIN
		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAPPROVE_SALES_ORDER_Id,
				rcData
			);
		end if;

		update LD_approve_sales_order
		set
			Terminal = isbTerminal$
		where
			APPROVE_SALES_ORDER_Id = inuAPPROVE_SALES_ORDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Terminal:= isbTerminal$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetApprove_Sales_Order_Id
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Approve_Sales_Order_Id%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Approve_Sales_Order_Id);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData.Approve_Sales_Order_Id);
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Order_Id%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Order_Id);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
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

	FUNCTION fnuGetPackage_Id
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Package_Id%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData.Package_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCausal_Id
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Causal_Id%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id := inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Causal_Id);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData.Causal_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetApproved
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Approved%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Approved);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData.Approved);
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Register_Date%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuAPPROVE_SALES_ORDER_Id
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

	FUNCTION fdtGetApproved_Date
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Approved_Date%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Approved_Date);
		end if;
		Load
		(
		 		inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData.Approved_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetUser_Name
	(
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.User_Name%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.User_Name);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
		);
		return(rcData.User_Name);
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
		inuAPPROVE_SALES_ORDER_Id in LD_approve_sales_order.APPROVE_SALES_ORDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_approve_sales_order.Terminal%type
	IS
		rcError styLD_approve_sales_order;
	BEGIN

		rcError.APPROVE_SALES_ORDER_Id:=inuAPPROVE_SALES_ORDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAPPROVE_SALES_ORDER_Id
			 )
		then
			 return(rcData.Terminal);
		end if;
		Load
		(
			inuAPPROVE_SALES_ORDER_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_approve_sales_order;
/
PROMPT Otorgando permisos de ejecucion a DALD_APPROVE_SALES_ORDER
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_APPROVE_SALES_ORDER', 'ADM_PERSON');
END;
/