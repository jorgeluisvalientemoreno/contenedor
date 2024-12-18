CREATE OR REPLACE PACKAGE adm_person.dald_non_ban_fi_item
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
  )
  IS
		SELECT LD_non_ban_fi_item.*,LD_non_ban_fi_item.rowid
		FROM LD_non_ban_fi_item
		WHERE
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_non_ban_fi_item.*,LD_non_ban_fi_item.rowid
		FROM LD_non_ban_fi_item
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_non_ban_fi_item  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_non_ban_fi_item is table of styLD_non_ban_fi_item index by binary_integer;
	type tyrfRecords is ref cursor return styLD_non_ban_fi_item;

	/* Tipos referenciando al registro */
	type tytbNon_Ban_Fi_Item_Id is table of LD_non_ban_fi_item.Non_Ban_Fi_Item_Id%type index by binary_integer;
	type tytbNon_Ba_Fi_Requ_Id is table of LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_non_ban_fi_item.Article_Id%type index by binary_integer;
	type tytbUnit_Value is table of LD_non_ban_fi_item.Unit_Value%type index by binary_integer;
	type tytbAmount is table of LD_non_ban_fi_item.Amount%type index by binary_integer;
	type tytbQuotas_Number is table of LD_non_ban_fi_item.Quotas_Number%type index by binary_integer;
	type tytbFirst_Payment_Date is table of LD_non_ban_fi_item.First_Payment_Date%type index by binary_integer;
	type tytbFinan_Plan_Id is table of LD_non_ban_fi_item.Finan_Plan_Id%type index by binary_integer;
	type tytbVat is table of LD_non_ban_fi_item.Vat%type index by binary_integer;
	type tytbSupplier_Id is table of LD_non_ban_fi_item.Supplier_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_non_ban_fi_item is record
	(

		Non_Ban_Fi_Item_Id   tytbNon_Ban_Fi_Item_Id,
		Non_Ba_Fi_Requ_Id   tytbNon_Ba_Fi_Requ_Id,
		Article_Id   tytbArticle_Id,
		Unit_Value   tytbUnit_Value,
		Amount   tytbAmount,
		Quotas_Number   tytbQuotas_Number,
		First_Payment_Date   tytbFirst_Payment_Date,
		Finan_Plan_Id   tytbFinan_Plan_Id,
		Vat   tytbVat,
		Supplier_Id   tytbSupplier_Id,
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	);

	PROCEDURE getRecord
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		orcRecord out nocopy styLD_non_ban_fi_item
	);

	FUNCTION frcGetRcData
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN styLD_non_ban_fi_item;

	FUNCTION frcGetRcData
	RETURN styLD_non_ban_fi_item;

	FUNCTION frcGetRecord
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN styLD_non_ban_fi_item;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_non_ban_fi_item
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_non_ban_fi_item in styLD_non_ban_fi_item
	);

 	  PROCEDURE insRecord
	(
		ircLD_non_ban_fi_item in styLD_non_ban_fi_item,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_non_ban_fi_item in out nocopy tytbLD_non_ban_fi_item
	);

	PROCEDURE delRecord
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_non_ban_fi_item in out nocopy tytbLD_non_ban_fi_item,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_non_ban_fi_item in styLD_non_ban_fi_item,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_non_ban_fi_item in out nocopy tytbLD_non_ban_fi_item,
		inuLock in number default 1
	);

		PROCEDURE updNon_Ba_Fi_Requ_Id
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuNon_Ba_Fi_Requ_Id$  in LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updArticle_Id
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuArticle_Id$  in LD_non_ban_fi_item.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUnit_Value
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuUnit_Value$  in LD_non_ban_fi_item.Unit_Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updAmount
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuAmount$  in LD_non_ban_fi_item.Amount%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuotas_Number
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuQuotas_Number$  in LD_non_ban_fi_item.Quotas_Number%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFirst_Payment_Date
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				idtFirst_Payment_Date$  in LD_non_ban_fi_item.First_Payment_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinan_Plan_Id
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuFinan_Plan_Id$  in LD_non_ban_fi_item.Finan_Plan_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updVat
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuVat$  in LD_non_ban_fi_item.Vat%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuNON_BAN_FI_ITEM_Id   in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
				inuSupplier_Id$  in LD_non_ban_fi_item.Supplier_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetNon_Ban_Fi_Item_Id
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Non_Ban_Fi_Item_Id%type;

    	FUNCTION fnuGetNon_Ba_Fi_Requ_Id
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Article_Id%type;

    	FUNCTION fnuGetUnit_Value
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Unit_Value%type;

    	FUNCTION fnuGetAmount
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Amount%type;

    	FUNCTION fnuGetQuotas_Number
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Quotas_Number%type;

    	FUNCTION fdtGetFirst_Payment_Date
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.First_Payment_Date%type;

    	FUNCTION fnuGetFinan_Plan_Id
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Finan_Plan_Id%type;

    	FUNCTION fnuGetVat
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Vat%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ban_fi_item.Supplier_Id%type;


	PROCEDURE LockByPk
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		orcLD_non_ban_fi_item  out styLD_non_ban_fi_item
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_non_ban_fi_item  out styLD_non_ban_fi_item
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_non_ban_fi_item;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_non_ban_fi_item
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_NON_BAN_FI_ITEM';
	  cnuGeEntityId constant varchar2(30) := 8792; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	IS
		SELECT LD_non_ban_fi_item.*,LD_non_ban_fi_item.rowid
		FROM LD_non_ban_fi_item
		WHERE  NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_non_ban_fi_item.*,LD_non_ban_fi_item.rowid
		FROM LD_non_ban_fi_item
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_non_ban_fi_item is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_non_ban_fi_item;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_non_ban_fi_item default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NON_BAN_FI_ITEM_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		orcLD_non_ban_fi_item  out styLD_non_ban_fi_item
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		Open cuLockRcByPk
		(
			inuNON_BAN_FI_ITEM_Id
		);

		fetch cuLockRcByPk into orcLD_non_ban_fi_item;
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
		orcLD_non_ban_fi_item  out styLD_non_ban_fi_item
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_non_ban_fi_item;
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
		itbLD_non_ban_fi_item  in out nocopy tytbLD_non_ban_fi_item
	)
	IS
	BEGIN
			rcRecOfTab.Non_Ban_Fi_Item_Id.delete;
			rcRecOfTab.Non_Ba_Fi_Requ_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Unit_Value.delete;
			rcRecOfTab.Amount.delete;
			rcRecOfTab.Quotas_Number.delete;
			rcRecOfTab.First_Payment_Date.delete;
			rcRecOfTab.Finan_Plan_Id.delete;
			rcRecOfTab.Vat.delete;
			rcRecOfTab.Supplier_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_non_ban_fi_item  in out nocopy tytbLD_non_ban_fi_item,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_non_ban_fi_item);
		for n in itbLD_non_ban_fi_item.first .. itbLD_non_ban_fi_item.last loop
			rcRecOfTab.Non_Ban_Fi_Item_Id(n) := itbLD_non_ban_fi_item(n).Non_Ban_Fi_Item_Id;
			rcRecOfTab.Non_Ba_Fi_Requ_Id(n) := itbLD_non_ban_fi_item(n).Non_Ba_Fi_Requ_Id;
			rcRecOfTab.Article_Id(n) := itbLD_non_ban_fi_item(n).Article_Id;
			rcRecOfTab.Unit_Value(n) := itbLD_non_ban_fi_item(n).Unit_Value;
			rcRecOfTab.Amount(n) := itbLD_non_ban_fi_item(n).Amount;
			rcRecOfTab.Quotas_Number(n) := itbLD_non_ban_fi_item(n).Quotas_Number;
			rcRecOfTab.First_Payment_Date(n) := itbLD_non_ban_fi_item(n).First_Payment_Date;
			rcRecOfTab.Finan_Plan_Id(n) := itbLD_non_ban_fi_item(n).Finan_Plan_Id;
			rcRecOfTab.Vat(n) := itbLD_non_ban_fi_item(n).Vat;
			rcRecOfTab.Supplier_Id(n) := itbLD_non_ban_fi_item(n).Supplier_Id;
			rcRecOfTab.row_id(n) := itbLD_non_ban_fi_item(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNON_BAN_FI_ITEM_Id
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNON_BAN_FI_ITEM_Id = rcData.NON_BAN_FI_ITEM_Id
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN		rcError.NON_BAN_FI_ITEM_Id:=inuNON_BAN_FI_ITEM_Id;

		Load
		(
			inuNON_BAN_FI_ITEM_Id
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		orcRecord out nocopy styLD_non_ban_fi_item
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN		rcError.NON_BAN_FI_ITEM_Id:=inuNON_BAN_FI_ITEM_Id;

		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN styLD_non_ban_fi_item
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id:=inuNON_BAN_FI_ITEM_Id;

		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type
	)
	RETURN styLD_non_ban_fi_item
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id:=inuNON_BAN_FI_ITEM_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_non_ban_fi_item
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_non_ban_fi_item
	)
	IS
		rfLD_non_ban_fi_item tyrfLD_non_ban_fi_item;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_non_ban_fi_item.Non_Ban_Fi_Item_Id,
		            LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id,
		            LD_non_ban_fi_item.Article_Id,
		            LD_non_ban_fi_item.Unit_Value,
		            LD_non_ban_fi_item.Amount,
		            LD_non_ban_fi_item.Quotas_Number,
		            LD_non_ban_fi_item.First_Payment_Date,
		            LD_non_ban_fi_item.Finan_Plan_Id,
		            LD_non_ban_fi_item.Vat,
		            LD_non_ban_fi_item.Supplier_Id,
		            LD_non_ban_fi_item.rowid
                FROM LD_non_ban_fi_item';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_non_ban_fi_item for sbFullQuery;
		fetch rfLD_non_ban_fi_item bulk collect INTO otbResult;
		close rfLD_non_ban_fi_item;
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
		            LD_non_ban_fi_item.Non_Ban_Fi_Item_Id,
		            LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id,
		            LD_non_ban_fi_item.Article_Id,
		            LD_non_ban_fi_item.Unit_Value,
		            LD_non_ban_fi_item.Amount,
		            LD_non_ban_fi_item.Quotas_Number,
		            LD_non_ban_fi_item.First_Payment_Date,
		            LD_non_ban_fi_item.Finan_Plan_Id,
		            LD_non_ban_fi_item.Vat,
		            LD_non_ban_fi_item.Supplier_Id,
		            LD_non_ban_fi_item.rowid
                FROM LD_non_ban_fi_item';
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
		ircLD_non_ban_fi_item in styLD_non_ban_fi_item
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_non_ban_fi_item,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_non_ban_fi_item in styLD_non_ban_fi_item,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_non_ban_fi_item.NON_BAN_FI_ITEM_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NON_BAN_FI_ITEM_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_non_ban_fi_item
		(
			Non_Ban_Fi_Item_Id,
			Non_Ba_Fi_Requ_Id,
			Article_Id,
			Unit_Value,
			Amount,
			Quotas_Number,
			First_Payment_Date,
			Finan_Plan_Id,
			Vat,
			Supplier_Id
		)
		values
		(
			ircLD_non_ban_fi_item.Non_Ban_Fi_Item_Id,
			ircLD_non_ban_fi_item.Non_Ba_Fi_Requ_Id,
			ircLD_non_ban_fi_item.Article_Id,
			ircLD_non_ban_fi_item.Unit_Value,
			ircLD_non_ban_fi_item.Amount,
			ircLD_non_ban_fi_item.Quotas_Number,
			ircLD_non_ban_fi_item.First_Payment_Date,
			ircLD_non_ban_fi_item.Finan_Plan_Id,
			ircLD_non_ban_fi_item.Vat,
			ircLD_non_ban_fi_item.Supplier_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_non_ban_fi_item));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_non_ban_fi_item in out nocopy tytbLD_non_ban_fi_item
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_non_ban_fi_item, blUseRowID);
		forall n in iotbLD_non_ban_fi_item.first..iotbLD_non_ban_fi_item.last
			insert into LD_non_ban_fi_item
			(
			Non_Ban_Fi_Item_Id,
			Non_Ba_Fi_Requ_Id,
			Article_Id,
			Unit_Value,
			Amount,
			Quotas_Number,
			First_Payment_Date,
			Finan_Plan_Id,
			Vat,
			Supplier_Id
		)
		values
		(
			rcRecOfTab.Non_Ban_Fi_Item_Id(n),
			rcRecOfTab.Non_Ba_Fi_Requ_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Unit_Value(n),
			rcRecOfTab.Amount(n),
			rcRecOfTab.Quotas_Number(n),
			rcRecOfTab.First_Payment_Date(n),
			rcRecOfTab.Finan_Plan_Id(n),
			rcRecOfTab.Vat(n),
			rcRecOfTab.Supplier_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id:=inuNON_BAN_FI_ITEM_Id;

		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		delete
		from LD_non_ban_fi_item
		where
       		NON_BAN_FI_ITEM_Id=inuNON_BAN_FI_ITEM_Id;
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
		rcError  styLD_non_ban_fi_item;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_non_ban_fi_item
		where
			rowid = iriRowID
		returning
   NON_BAN_FI_ITEM_Id
		into
			rcError.NON_BAN_FI_ITEM_Id;

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
		iotbLD_non_ban_fi_item in out nocopy tytbLD_non_ban_fi_item,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_non_ban_fi_item;
	BEGIN
		FillRecordOfTables(iotbLD_non_ban_fi_item, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last
				delete
				from LD_non_ban_fi_item
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last loop
					LockByPk
					(
							rcRecOfTab.NON_BAN_FI_ITEM_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last
				delete
				from LD_non_ban_fi_item
				where
		         	NON_BAN_FI_ITEM_Id = rcRecOfTab.NON_BAN_FI_ITEM_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_non_ban_fi_item in styLD_non_ban_fi_item,
		inuLock	  in number default 0
	)
	IS
		nuNON_BAN_FI_ITEM_Id LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type;

	BEGIN
		if ircLD_non_ban_fi_item.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_non_ban_fi_item.rowid,rcData);
			end if;
			update LD_non_ban_fi_item
			set

        Non_Ba_Fi_Requ_Id = ircLD_non_ban_fi_item.Non_Ba_Fi_Requ_Id,
        Article_Id = ircLD_non_ban_fi_item.Article_Id,
        Unit_Value = ircLD_non_ban_fi_item.Unit_Value,
        Amount = ircLD_non_ban_fi_item.Amount,
        Quotas_Number = ircLD_non_ban_fi_item.Quotas_Number,
        First_Payment_Date = ircLD_non_ban_fi_item.First_Payment_Date,
        Finan_Plan_Id = ircLD_non_ban_fi_item.Finan_Plan_Id,
        Vat = ircLD_non_ban_fi_item.Vat,
        Supplier_Id = ircLD_non_ban_fi_item.Supplier_Id
			where
				rowid = ircLD_non_ban_fi_item.rowid
			returning
    NON_BAN_FI_ITEM_Id
			into
				nuNON_BAN_FI_ITEM_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_non_ban_fi_item.NON_BAN_FI_ITEM_Id,
					rcData
				);
			end if;

			update LD_non_ban_fi_item
			set
        Non_Ba_Fi_Requ_Id = ircLD_non_ban_fi_item.Non_Ba_Fi_Requ_Id,
        Article_Id = ircLD_non_ban_fi_item.Article_Id,
        Unit_Value = ircLD_non_ban_fi_item.Unit_Value,
        Amount = ircLD_non_ban_fi_item.Amount,
        Quotas_Number = ircLD_non_ban_fi_item.Quotas_Number,
        First_Payment_Date = ircLD_non_ban_fi_item.First_Payment_Date,
        Finan_Plan_Id = ircLD_non_ban_fi_item.Finan_Plan_Id,
        Vat = ircLD_non_ban_fi_item.Vat,
        Supplier_Id = ircLD_non_ban_fi_item.Supplier_Id
			where
	         	NON_BAN_FI_ITEM_Id = ircLD_non_ban_fi_item.NON_BAN_FI_ITEM_Id
			returning
    NON_BAN_FI_ITEM_Id
			into
				nuNON_BAN_FI_ITEM_Id;
		end if;

		if
			nuNON_BAN_FI_ITEM_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_non_ban_fi_item));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_non_ban_fi_item in out nocopy tytbLD_non_ban_fi_item,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_non_ban_fi_item;
  BEGIN
    FillRecordOfTables(iotbLD_non_ban_fi_item,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last
        update LD_non_ban_fi_item
        set

            Non_Ba_Fi_Requ_Id = rcRecOfTab.Non_Ba_Fi_Requ_Id(n),
            Article_Id = rcRecOfTab.Article_Id(n),
            Unit_Value = rcRecOfTab.Unit_Value(n),
            Amount = rcRecOfTab.Amount(n),
            Quotas_Number = rcRecOfTab.Quotas_Number(n),
            First_Payment_Date = rcRecOfTab.First_Payment_Date(n),
            Finan_Plan_Id = rcRecOfTab.Finan_Plan_Id(n),
            Vat = rcRecOfTab.Vat(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last loop
          LockByPk
          (
              rcRecOfTab.NON_BAN_FI_ITEM_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_non_ban_fi_item.first .. iotbLD_non_ban_fi_item.last
        update LD_non_ban_fi_item
        set
					Non_Ba_Fi_Requ_Id = rcRecOfTab.Non_Ba_Fi_Requ_Id(n),
					Article_Id = rcRecOfTab.Article_Id(n),
					Unit_Value = rcRecOfTab.Unit_Value(n),
					Amount = rcRecOfTab.Amount(n),
					Quotas_Number = rcRecOfTab.Quotas_Number(n),
					First_Payment_Date = rcRecOfTab.First_Payment_Date(n),
					Finan_Plan_Id = rcRecOfTab.Finan_Plan_Id(n),
					Vat = rcRecOfTab.Vat(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
          NON_BAN_FI_ITEM_Id = rcRecOfTab.NON_BAN_FI_ITEM_Id(n)
;
    end if;
  END;

	PROCEDURE updNon_Ba_Fi_Requ_Id
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuNon_Ba_Fi_Requ_Id$ in LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Non_Ba_Fi_Requ_Id = inuNon_Ba_Fi_Requ_Id$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Non_Ba_Fi_Requ_Id:= inuNon_Ba_Fi_Requ_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updArticle_Id
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuArticle_Id$ in LD_non_ban_fi_item.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Article_Id = inuArticle_Id$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Article_Id:= inuArticle_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUnit_Value
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuUnit_Value$ in LD_non_ban_fi_item.Unit_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Unit_Value = inuUnit_Value$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Unit_Value:= inuUnit_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updAmount
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuAmount$ in LD_non_ban_fi_item.Amount%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Amount = inuAmount$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Amount:= inuAmount$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuotas_Number
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuQuotas_Number$ in LD_non_ban_fi_item.Quotas_Number%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Quotas_Number = inuQuotas_Number$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quotas_Number:= inuQuotas_Number$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFirst_Payment_Date
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		idtFirst_Payment_Date$ in LD_non_ban_fi_item.First_Payment_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			First_Payment_Date = idtFirst_Payment_Date$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.First_Payment_Date:= idtFirst_Payment_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFinan_Plan_Id
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuFinan_Plan_Id$ in LD_non_ban_fi_item.Finan_Plan_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Finan_Plan_Id = inuFinan_Plan_Id$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Finan_Plan_Id:= inuFinan_Plan_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updVat
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuVat$ in LD_non_ban_fi_item.Vat%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Vat = inuVat$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Vat:= inuVat$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuSupplier_Id$ in LD_non_ban_fi_item.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN
		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BAN_FI_ITEM_Id,
				rcData
			);
		end if;

		update LD_non_ban_fi_item
		set
			Supplier_Id = inuSupplier_Id$
		where
			NON_BAN_FI_ITEM_Id = inuNON_BAN_FI_ITEM_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetNon_Ban_Fi_Item_Id
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Non_Ban_Fi_Item_Id%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Non_Ban_Fi_Item_Id);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData.Non_Ban_Fi_Item_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetNon_Ba_Fi_Requ_Id
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Non_Ba_Fi_Requ_Id%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Non_Ba_Fi_Requ_Id);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData.Non_Ba_Fi_Requ_Id);
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Article_Id%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
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

	FUNCTION fnuGetUnit_Value
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Unit_Value%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Unit_Value);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData.Unit_Value);
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Amount%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Amount);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
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

	FUNCTION fnuGetQuotas_Number
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Quotas_Number%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Quotas_Number);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData.Quotas_Number);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetFirst_Payment_Date
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.First_Payment_Date%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id:=inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.First_Payment_Date);
		end if;
		Load
		(
		 		inuNON_BAN_FI_ITEM_Id
		);
		return(rcData.First_Payment_Date);
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Finan_Plan_Id%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Finan_Plan_Id);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
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

	FUNCTION fnuGetVat
	(
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Vat%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Vat);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
		);
		return(rcData.Vat);
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
		inuNON_BAN_FI_ITEM_Id in LD_non_ban_fi_item.NON_BAN_FI_ITEM_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ban_fi_item.Supplier_Id%type
	IS
		rcError styLD_non_ban_fi_item;
	BEGIN

		rcError.NON_BAN_FI_ITEM_Id := inuNON_BAN_FI_ITEM_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BAN_FI_ITEM_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuNON_BAN_FI_ITEM_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_non_ban_fi_item;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_NON_BAN_FI_ITEM
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_NON_BAN_FI_ITEM', 'ADM_PERSON'); 
END;
/  

