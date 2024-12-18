CREATE OR REPLACE PACKAGE adm_person.dald_return_item IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type) IS
		SELECT LD_return_item.*,LD_return_item.rowid
		FROM LD_return_item
		WHERE
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId(
		irirowid in varchar2) IS
		SELECT LD_return_item.*,LD_return_item.rowid
		FROM LD_return_item
		WHERE rowId = irirowid;


	/* Subtipos */
	subtype styLD_return_item  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_return_item is table of styLD_return_item index by binary_integer;
	type tyrfRecords is ref cursor return styLD_return_item;

	/* Tipos referenciando al registro */
	type tytbReturn_Item_Id is table of LD_return_item.Return_Item_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_return_item.Package_Id%type index by binary_integer;
	type tytbPackage_Sale is table of LD_return_item.Package_Sale%type index by binary_integer;
	type tytbOrder_Delivery is table of LD_return_item.Order_Delivery%type index by binary_integer;
	type tytbOrder_Anu_Dev is table of LD_return_item.Order_Anu_Dev%type index by binary_integer;
	type tytbTransaction_Type is table of LD_return_item.Transaction_Type%type index by binary_integer;
	type tytbOrigin_Anu_Dev is table of LD_return_item.Origin_Anu_Dev%type index by binary_integer;
	type tytbMov_User_Portf is table of LD_return_item.Mov_User_Portf%type index by binary_integer;
	type tytbPayment_To_Seller is table of LD_return_item.Payment_To_Seller%type index by binary_integer;
	type tytbRegister_Date is table of LD_return_item.Register_Date%type index by binary_integer;
	type tytbApproved is table of LD_return_item.Approved%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_return_item is record(

		Return_Item_Id   tytbReturn_Item_Id,
		Package_Id   tytbPackage_Id,
		Package_Sale   tytbPackage_Sale,
		Order_Delivery   tytbOrder_Delivery,
		Order_Anu_Dev   tytbOrder_Anu_Dev,
		Transaction_Type   tytbTransaction_Type,
		Origin_Anu_Dev   tytbOrigin_Anu_Dev,
		Mov_User_Portf   tytbMov_User_Portf,
		Payment_To_Seller   tytbPayment_To_Seller,
		Register_Date   tytbRegister_Date,
		Approved   tytbApproved,
		row_id tytbrowid);


	 /***** Metodos Publicos ****/
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

	FUNCTION fsbGetMessageDescription return varchar2;

	PROCEDURE ClearMemory;

   FUNCTION fblExist(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type) RETURN boolean;

	 PROCEDURE AccKey(
		 inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type);

	PROCEDURE AccKeyByRowId(
		iriRowID    in rowid);

	PROCEDURE ValDuplicate(
		 inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type);

	PROCEDURE getRecord(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		orcRecord out nocopy styLD_return_item
	);

	FUNCTION frcGetRcData(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type)
	RETURN styLD_return_item;

	FUNCTION frcGetRcData
	RETURN styLD_return_item;

	FUNCTION frcGetRecord(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type)
	RETURN styLD_return_item;

	PROCEDURE getRecords(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_return_item
	);

	FUNCTION frfGetRecords(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false)
	RETURN tyRefCursor;

	PROCEDURE insRecord(
		ircLD_return_item in styLD_return_item
	);

 	  PROCEDURE insRecord(
		ircLD_return_item in styLD_return_item,
		orirowid   out varchar2);

	PROCEDURE insRecords(
		iotbLD_return_item in out nocopy tytbLD_return_item
	);

	PROCEDURE delRecord(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type, inuLock in number default 1);

	PROCEDURE delByRowID(
		iriRowID    in rowid,
		inuLock in number default 1);

	PROCEDURE delRecords
	(
		iotbLD_return_item in out nocopy tytbLD_return_item,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_return_item in styLD_return_item,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_return_item in out nocopy tytbLD_return_item,
		inuLock in number default 1
	);

		PROCEDURE updPackage_Id
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				inuPackage_Id$  in LD_return_item.Package_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updPackage_Sale
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				inuPackage_Sale$  in LD_return_item.Package_Sale%type,
				inuLock	  in number default 0);

		PROCEDURE updOrder_Delivery
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				inuOrder_Delivery$  in LD_return_item.Order_Delivery%type,
				inuLock	  in number default 0);

		PROCEDURE updOrder_Anu_Dev
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				inuOrder_Anu_Dev$  in LD_return_item.Order_Anu_Dev%type,
				inuLock	  in number default 0);

		PROCEDURE updTransaction_Type
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				isbTransaction_Type$  in LD_return_item.Transaction_Type%type,
				inuLock	  in number default 0);

		PROCEDURE updOrigin_Anu_Dev
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				inuOrigin_Anu_Dev$  in LD_return_item.Origin_Anu_Dev%type,
				inuLock	  in number default 0);

		PROCEDURE updMov_User_Portf
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				isbMov_User_Portf$  in LD_return_item.Mov_User_Portf%type,
				inuLock	  in number default 0);

		PROCEDURE updPayment_To_Seller
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				isbPayment_To_Seller$  in LD_return_item.Payment_To_Seller%type,
				inuLock	  in number default 0);

		PROCEDURE updRegister_Date
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				idtRegister_Date$  in LD_return_item.Register_Date%type,
				inuLock	  in number default 0);

		PROCEDURE updApproved
		(
				inuRETURN_ITEM_Id   in LD_return_item.RETURN_ITEM_Id%type,
				isbApproved$  in LD_return_item.Approved%type,
				inuLock	  in number default 0);

    	FUNCTION fnuGetReturn_Item_Id
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Return_Item_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Package_Id%type;

    	FUNCTION fnuGetPackage_Sale
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Package_Sale%type;

    	FUNCTION fnuGetOrder_Delivery
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Order_Delivery%type;

    	FUNCTION fnuGetOrder_Anu_Dev
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Order_Anu_Dev%type;

    	FUNCTION fsbGetTransaction_Type
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Transaction_Type%type;

    	FUNCTION fnuGetOrigin_Anu_Dev
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Origin_Anu_Dev%type;

    	FUNCTION fsbGetMov_User_Portf
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Mov_User_Portf%type;

    	FUNCTION fsbGetPayment_To_Seller
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Payment_To_Seller%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Register_Date%type;

    	FUNCTION fsbGetApproved
    	(
    	    inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_return_item.Approved%type;


	PROCEDURE LockByPk
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		orcLD_return_item  out styLD_return_item
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_return_item  out styLD_return_item
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_return_item;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_return_item
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_RETURN_ITEM';
	  cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_RETURN_ITEM'); -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	IS
		SELECT LD_return_item.*,LD_return_item.rowid
		FROM LD_return_item
		WHERE  RETURN_ITEM_Id = inuRETURN_ITEM_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_return_item.*,LD_return_item.rowid
		FROM LD_return_item
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_return_item is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_return_item;

	rcData cuRecord%rowtype;

   blDAO_USE_CACHE    boolean := null;

	/* Metodos privados */
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE IS
	   nuEntityId ge_entity.entity_id%TYPE;
	   BEGIN
	   SELECT ge_entity.entity_id
	   INTO   nuEntityId
	   FROM   ge_entity
	   WHERE  ge_entity.name_ = isbTName;
	   RETURN nuEntityId;
  EXCEPTION
	   WHEN ex.CONTROLLED_ERROR THEN
	        RAISE ex.CONTROLLED_ERROR;
	   WHEN OTHERS THEN
	        Errors.setError;
	        RAISE ex.CONTROLLED_ERROR;
	END;
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

	FUNCTION fsbPrimaryKey( rcI in styLD_return_item default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RETURN_ITEM_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		orcLD_return_item  out styLD_return_item
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		Open cuLockRcByPk
		(
			inuRETURN_ITEM_Id
		);

		fetch cuLockRcByPk into orcLD_return_item;
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
		orcLD_return_item  out styLD_return_item
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_return_item;
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
		itbLD_return_item  in out nocopy tytbLD_return_item
	)
	IS
	BEGIN
			rcRecOfTab.Return_Item_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Package_Sale.delete;
			rcRecOfTab.Order_Delivery.delete;
			rcRecOfTab.Order_Anu_Dev.delete;
			rcRecOfTab.Transaction_Type.delete;
			rcRecOfTab.Origin_Anu_Dev.delete;
			rcRecOfTab.Mov_User_Portf.delete;
			rcRecOfTab.Payment_To_Seller.delete;
			rcRecOfTab.Register_Date.delete;
			rcRecOfTab.Approved.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_return_item  in out nocopy tytbLD_return_item,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_return_item);
		for n in itbLD_return_item.first .. itbLD_return_item.last loop
			rcRecOfTab.Return_Item_Id(n) := itbLD_return_item(n).Return_Item_Id;
			rcRecOfTab.Package_Id(n) := itbLD_return_item(n).Package_Id;
			rcRecOfTab.Package_Sale(n) := itbLD_return_item(n).Package_Sale;
			rcRecOfTab.Order_Delivery(n) := itbLD_return_item(n).Order_Delivery;
			rcRecOfTab.Order_Anu_Dev(n) := itbLD_return_item(n).Order_Anu_Dev;
			rcRecOfTab.Transaction_Type(n) := itbLD_return_item(n).Transaction_Type;
			rcRecOfTab.Origin_Anu_Dev(n) := itbLD_return_item(n).Origin_Anu_Dev;
			rcRecOfTab.Mov_User_Portf(n) := itbLD_return_item(n).Mov_User_Portf;
			rcRecOfTab.Payment_To_Seller(n) := itbLD_return_item(n).Payment_To_Seller;
			rcRecOfTab.Register_Date(n) := itbLD_return_item(n).Register_Date;
			rcRecOfTab.Approved(n) := itbLD_return_item(n).Approved;
			rcRecOfTab.row_id(n) := itbLD_return_item(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRETURN_ITEM_Id
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
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRETURN_ITEM_Id = rcData.RETURN_ITEM_Id
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
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	IS
		rcError styLD_return_item;
	BEGIN		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		Load
		(
			inuRETURN_ITEM_Id
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
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuRETURN_ITEM_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		orcRecord out nocopy styLD_return_item
	)
	IS
		rcError styLD_return_item;
	BEGIN		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		Load
		(
			inuRETURN_ITEM_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	RETURN styLD_return_item
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type
	)
	RETURN styLD_return_item
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_return_item
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_return_item
	)
	IS
		rfLD_return_item tyrfLD_return_item;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_return_item.*,
		            LD_return_item.rowid
                FROM LD_return_item';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_return_item for sbFullQuery;
		fetch rfLD_return_item bulk collect INTO otbResult;
		close rfLD_return_item;
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
		sbSQL  VARCHAR2 (32000) := 'select LD_return_item.*,
		            LD_return_item.rowid
                FROM LD_return_item';
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
		ircLD_return_item in styLD_return_item
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_return_item,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_return_item in styLD_return_item,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_return_item.RETURN_ITEM_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RETURN_ITEM_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_return_item
		(
			Return_Item_Id,
			Package_Id,
			Package_Sale,
			Order_Delivery,
			Order_Anu_Dev,
			Transaction_Type,
			Origin_Anu_Dev,
			Mov_User_Portf,
			Payment_To_Seller,
			Register_Date,
			Approved
		)
		values
		(
			ircLD_return_item.Return_Item_Id,
			ircLD_return_item.Package_Id,
			ircLD_return_item.Package_Sale,
			ircLD_return_item.Order_Delivery,
			ircLD_return_item.Order_Anu_Dev,
			ircLD_return_item.Transaction_Type,
			ircLD_return_item.Origin_Anu_Dev,
			ircLD_return_item.Mov_User_Portf,
			ircLD_return_item.Payment_To_Seller,
			ircLD_return_item.Register_Date,
			ircLD_return_item.Approved
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_return_item));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_return_item in out nocopy tytbLD_return_item
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_return_item, blUseRowID);
		forall n in iotbLD_return_item.first..iotbLD_return_item.last
			insert into LD_return_item
			(
			Return_Item_Id,
			Package_Id,
			Package_Sale,
			Order_Delivery,
			Order_Anu_Dev,
			Transaction_Type,
			Origin_Anu_Dev,
			Mov_User_Portf,
			Payment_To_Seller,
			Register_Date,
			Approved
		)
		values
		(
			rcRecOfTab.Return_Item_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Package_Sale(n),
			rcRecOfTab.Order_Delivery(n),
			rcRecOfTab.Order_Anu_Dev(n),
			rcRecOfTab.Transaction_Type(n),
			rcRecOfTab.Origin_Anu_Dev(n),
			rcRecOfTab.Mov_User_Portf(n),
			rcRecOfTab.Payment_To_Seller(n),
			rcRecOfTab.Register_Date(n),
			rcRecOfTab.Approved(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		delete
		from LD_return_item
		where
       		RETURN_ITEM_Id=inuRETURN_ITEM_Id;
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
		rcError  styLD_return_item;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_return_item
		where
			rowid = iriRowID
		returning
   RETURN_ITEM_Id
		into
			rcError.RETURN_ITEM_Id;

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
		iotbLD_return_item in out nocopy tytbLD_return_item,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_return_item;
	BEGIN
		FillRecordOfTables(iotbLD_return_item, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_return_item.first .. iotbLD_return_item.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_return_item.first .. iotbLD_return_item.last
				delete
				from LD_return_item
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_return_item.first .. iotbLD_return_item.last loop
					LockByPk
					(
							rcRecOfTab.RETURN_ITEM_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_return_item.first .. iotbLD_return_item.last
				delete
				from LD_return_item
				where
		         	RETURN_ITEM_Id = rcRecOfTab.RETURN_ITEM_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_return_item in styLD_return_item,
		inuLock	  in number default 0
	)
	IS
		nuRETURN_ITEM_Id LD_return_item.RETURN_ITEM_Id%type;

	BEGIN
		if ircLD_return_item.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_return_item.rowid,rcData);
			end if;
			update LD_return_item
			set

        Package_Id = ircLD_return_item.Package_Id,
        Package_Sale = ircLD_return_item.Package_Sale,
        Order_Delivery = ircLD_return_item.Order_Delivery,
        Order_Anu_Dev = ircLD_return_item.Order_Anu_Dev,
        Transaction_Type = ircLD_return_item.Transaction_Type,
        Origin_Anu_Dev = ircLD_return_item.Origin_Anu_Dev,
        Mov_User_Portf = ircLD_return_item.Mov_User_Portf,
        Payment_To_Seller = ircLD_return_item.Payment_To_Seller,
        Register_Date = ircLD_return_item.Register_Date,
        Approved = ircLD_return_item.Approved
			where
				rowid = ircLD_return_item.rowid
			returning
    RETURN_ITEM_Id
			into
				nuRETURN_ITEM_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_return_item.RETURN_ITEM_Id,
					rcData
				);
			end if;

			update LD_return_item
			set
        Package_Id = ircLD_return_item.Package_Id,
        Package_Sale = ircLD_return_item.Package_Sale,
        Order_Delivery = ircLD_return_item.Order_Delivery,
        Order_Anu_Dev = ircLD_return_item.Order_Anu_Dev,
        Transaction_Type = ircLD_return_item.Transaction_Type,
        Origin_Anu_Dev = ircLD_return_item.Origin_Anu_Dev,
        Mov_User_Portf = ircLD_return_item.Mov_User_Portf,
        Payment_To_Seller = ircLD_return_item.Payment_To_Seller,
        Register_Date = ircLD_return_item.Register_Date,
        Approved = ircLD_return_item.Approved
			where
	         	RETURN_ITEM_Id = ircLD_return_item.RETURN_ITEM_Id
			returning
    RETURN_ITEM_Id
			into
				nuRETURN_ITEM_Id;
		end if;

		if
			nuRETURN_ITEM_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_return_item));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_return_item in out nocopy tytbLD_return_item,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_return_item;
  BEGIN
    FillRecordOfTables(iotbLD_return_item,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_return_item.first .. iotbLD_return_item.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_return_item.first .. iotbLD_return_item.last
        update LD_return_item
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Package_Sale = rcRecOfTab.Package_Sale(n),
            Order_Delivery = rcRecOfTab.Order_Delivery(n),
            Order_Anu_Dev = rcRecOfTab.Order_Anu_Dev(n),
            Transaction_Type = rcRecOfTab.Transaction_Type(n),
            Origin_Anu_Dev = rcRecOfTab.Origin_Anu_Dev(n),
            Mov_User_Portf = rcRecOfTab.Mov_User_Portf(n),
            Payment_To_Seller = rcRecOfTab.Payment_To_Seller(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Approved = rcRecOfTab.Approved(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_return_item.first .. iotbLD_return_item.last loop
          LockByPk
          (
              rcRecOfTab.RETURN_ITEM_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_return_item.first .. iotbLD_return_item.last
        update LD_return_item
        set
					Package_Id = rcRecOfTab.Package_Id(n),
					Package_Sale = rcRecOfTab.Package_Sale(n),
					Order_Delivery = rcRecOfTab.Order_Delivery(n),
					Order_Anu_Dev = rcRecOfTab.Order_Anu_Dev(n),
					Transaction_Type = rcRecOfTab.Transaction_Type(n),
					Origin_Anu_Dev = rcRecOfTab.Origin_Anu_Dev(n),
					Mov_User_Portf = rcRecOfTab.Mov_User_Portf(n),
					Payment_To_Seller = rcRecOfTab.Payment_To_Seller(n),
					Register_Date = rcRecOfTab.Register_Date(n),
					Approved = rcRecOfTab.Approved(n)
          where
          RETURN_ITEM_Id = rcRecOfTab.RETURN_ITEM_Id(n)
;
    end if;
  END;

	PROCEDURE updPackage_Id
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuPackage_Id$ in LD_return_item.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Package_Id = inuPackage_Id$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPackage_Sale
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuPackage_Sale$ in LD_return_item.Package_Sale%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Package_Sale = inuPackage_Sale$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Sale:= inuPackage_Sale$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updOrder_Delivery
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuOrder_Delivery$ in LD_return_item.Order_Delivery%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Order_Delivery = inuOrder_Delivery$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Delivery:= inuOrder_Delivery$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updOrder_Anu_Dev
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuOrder_Anu_Dev$ in LD_return_item.Order_Anu_Dev%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Order_Anu_Dev = inuOrder_Anu_Dev$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Anu_Dev:= inuOrder_Anu_Dev$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTransaction_Type
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		isbTransaction_Type$ in LD_return_item.Transaction_Type%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Transaction_Type = isbTransaction_Type$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Transaction_Type:= isbTransaction_Type$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updOrigin_Anu_Dev
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuOrigin_Anu_Dev$ in LD_return_item.Origin_Anu_Dev%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Origin_Anu_Dev = inuOrigin_Anu_Dev$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Origin_Anu_Dev:= inuOrigin_Anu_Dev$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updMov_User_Portf
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		isbMov_User_Portf$ in LD_return_item.Mov_User_Portf%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Mov_User_Portf = isbMov_User_Portf$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Mov_User_Portf:= isbMov_User_Portf$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPayment_To_Seller
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		isbPayment_To_Seller$ in LD_return_item.Payment_To_Seller%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Payment_To_Seller = isbPayment_To_Seller$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Payment_To_Seller:= isbPayment_To_Seller$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		idtRegister_Date$ in LD_return_item.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Register_Date = idtRegister_Date$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApproved
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		isbApproved$ in LD_return_item.Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_return_item;
	BEGIN
		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRETURN_ITEM_Id,
				rcData
			);
		end if;

		update LD_return_item
		set
			Approved = isbApproved$
		where
			RETURN_ITEM_Id = inuRETURN_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Approved:= isbApproved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetReturn_Item_Id
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Return_Item_Id%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Return_Item_Id);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Return_Item_Id);
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
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Package_Id%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
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

	FUNCTION fnuGetPackage_Sale
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Package_Sale%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Package_Sale);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Package_Sale);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOrder_Delivery
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Order_Delivery%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Order_Delivery);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Order_Delivery);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOrder_Anu_Dev
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Order_Anu_Dev%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Order_Anu_Dev);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Order_Anu_Dev);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetTransaction_Type
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Transaction_Type%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Transaction_Type);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Transaction_Type);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOrigin_Anu_Dev
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Origin_Anu_Dev%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id := inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Origin_Anu_Dev);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Origin_Anu_Dev);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetMov_User_Portf
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Mov_User_Portf%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Mov_User_Portf);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Mov_User_Portf);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetPayment_To_Seller
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Payment_To_Seller%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Payment_To_Seller);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
		);
		return(rcData.Payment_To_Seller);
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
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Register_Date%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuRETURN_ITEM_Id
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

	FUNCTION fsbGetApproved
	(
		inuRETURN_ITEM_Id in LD_return_item.RETURN_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_return_item.Approved%type
	IS
		rcError styLD_return_item;
	BEGIN

		rcError.RETURN_ITEM_Id:=inuRETURN_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRETURN_ITEM_Id
			 )
		then
			 return(rcData.Approved);
		end if;
		Load
		(
			inuRETURN_ITEM_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_return_item;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_RETURN_ITEM
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_RETURN_ITEM', 'ADM_PERSON'); 
END;
/ 
