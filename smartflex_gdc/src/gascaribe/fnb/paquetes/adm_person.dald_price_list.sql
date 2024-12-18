CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_price_list
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
  )
  IS
		SELECT LD_price_list.*,LD_price_list.rowid
		FROM LD_price_list
		WHERE
			PRICE_LIST_Id = inuPRICE_LIST_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_price_list.*,LD_price_list.rowid
		FROM LD_price_list
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_price_list  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_price_list is table of styLD_price_list index by binary_integer;
	type tyrfRecords is ref cursor return styLD_price_list;

	/* Tipos referenciando al registro */
	type tytbPrice_List_Id is table of LD_price_list.Price_List_Id%type index by binary_integer;
	type tytbDescription is table of LD_price_list.Description%type index by binary_integer;
	type tytbSupplier_Id is table of LD_price_list.Supplier_Id%type index by binary_integer;
	type tytbCreation_Date is table of LD_price_list.Creation_Date%type index by binary_integer;
	type tytbInitial_Date is table of LD_price_list.Initial_Date%type index by binary_integer;
	type tytbFinal_Date is table of LD_price_list.Final_Date%type index by binary_integer;
	type tytbApproved is table of LD_price_list.Approved%type index by binary_integer;
	type tytbLast_Date_Approved is table of LD_price_list.Last_Date_Approved%type index by binary_integer;
	type tytbVersion is table of LD_price_list.Version%type index by binary_integer;
	type tytbCondition_Approved is table of LD_price_list.Condition_Approved%type index by binary_integer;
	type tytbAmount_Printouts is table of LD_price_list.Amount_Printouts%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_price_list is record
	(

		Price_List_Id   tytbPrice_List_Id,
		Description   tytbDescription,
		Supplier_Id   tytbSupplier_Id,
		Creation_Date   tytbCreation_Date,
		Initial_Date   tytbInitial_Date,
		Final_Date   tytbFinal_Date,
		Approved   tytbApproved,
		Last_Date_Approved   tytbLast_Date_Approved,
		Version   tytbVersion,
		Condition_Approved   tytbCondition_Approved,
		Amount_Printouts   tytbAmount_Printouts,
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
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	);

	PROCEDURE getRecord
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		orcRecord out nocopy styLD_price_list
	);

	FUNCTION frcGetRcData
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN styLD_price_list;

	FUNCTION frcGetRcData
	RETURN styLD_price_list;

	FUNCTION frcGetRecord
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN styLD_price_list;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_price_list
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_price_list in styLD_price_list
	);

 	  PROCEDURE insRecord
	(
		ircLD_price_list in styLD_price_list,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_price_list in out nocopy tytbLD_price_list
	);

	PROCEDURE delRecord
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_price_list in out nocopy tytbLD_price_list,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_price_list in styLD_price_list,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_price_list in out nocopy tytbLD_price_list,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				isbDescription$  in LD_price_list.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				inuSupplier_Id$  in LD_price_list.Supplier_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCreation_Date
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				idtCreation_Date$  in LD_price_list.Creation_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInitial_Date
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				idtInitial_Date$  in LD_price_list.Initial_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinal_Date
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				idtFinal_Date$  in LD_price_list.Final_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproved
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				isbApproved$  in LD_price_list.Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLast_Date_Approved
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				idtLast_Date_Approved$  in LD_price_list.Last_Date_Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updVersion
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				inuVersion$  in LD_price_list.Version%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCondition_Approved
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				isbCondition_Approved$  in LD_price_list.Condition_Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updAmount_Printouts
		(
				inuPRICE_LIST_Id   in LD_price_list.PRICE_LIST_Id%type,
				inuAmount_Printouts$  in LD_price_list.Amount_Printouts%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPrice_List_Id
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Price_List_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Description%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Supplier_Id%type;

    	FUNCTION fdtGetCreation_Date
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Creation_Date%type;

    	FUNCTION fdtGetInitial_Date
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Initial_Date%type;

    	FUNCTION fdtGetFinal_Date
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Final_Date%type;

    	FUNCTION fsbGetApproved
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Approved%type;

    	FUNCTION fdtGetLast_Date_Approved
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Last_Date_Approved%type;

    	FUNCTION fnuGetVersion
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Version%type;

    	FUNCTION fsbGetCondition_Approved
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Condition_Approved%type;

    	FUNCTION fnuGetAmount_Printouts
    	(
    	    inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list.Amount_Printouts%type;


	PROCEDURE LockByPk
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		orcLD_price_list  out styLD_price_list
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_price_list  out styLD_price_list
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_price_list;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_price_list
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PRICE_LIST';
	  cnuGeEntityId constant varchar2(30) := 8379; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	IS
		SELECT LD_price_list.*,LD_price_list.rowid
		FROM LD_price_list
		WHERE  PRICE_LIST_Id = inuPRICE_LIST_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_price_list.*,LD_price_list.rowid
		FROM LD_price_list
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_price_list is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_price_list;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_price_list default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PRICE_LIST_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		orcLD_price_list  out styLD_price_list
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;

		Open cuLockRcByPk
		(
			inuPRICE_LIST_Id
		);

		fetch cuLockRcByPk into orcLD_price_list;
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
		orcLD_price_list  out styLD_price_list
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_price_list;
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
		itbLD_price_list  in out nocopy tytbLD_price_list
	)
	IS
	BEGIN
			rcRecOfTab.Price_List_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Supplier_Id.delete;
			rcRecOfTab.Creation_Date.delete;
			rcRecOfTab.Initial_Date.delete;
			rcRecOfTab.Final_Date.delete;
			rcRecOfTab.Approved.delete;
			rcRecOfTab.Last_Date_Approved.delete;
			rcRecOfTab.Version.delete;
			rcRecOfTab.Condition_Approved.delete;
			rcRecOfTab.Amount_Printouts.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_price_list  in out nocopy tytbLD_price_list,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_price_list);
		for n in itbLD_price_list.first .. itbLD_price_list.last loop
			rcRecOfTab.Price_List_Id(n) := itbLD_price_list(n).Price_List_Id;
			rcRecOfTab.Description(n) := itbLD_price_list(n).Description;
			rcRecOfTab.Supplier_Id(n) := itbLD_price_list(n).Supplier_Id;
			rcRecOfTab.Creation_Date(n) := itbLD_price_list(n).Creation_Date;
			rcRecOfTab.Initial_Date(n) := itbLD_price_list(n).Initial_Date;
			rcRecOfTab.Final_Date(n) := itbLD_price_list(n).Final_Date;
			rcRecOfTab.Approved(n) := itbLD_price_list(n).Approved;
			rcRecOfTab.Last_Date_Approved(n) := itbLD_price_list(n).Last_Date_Approved;
			rcRecOfTab.Version(n) := itbLD_price_list(n).Version;
			rcRecOfTab.Condition_Approved(n) := itbLD_price_list(n).Condition_Approved;
			rcRecOfTab.Amount_Printouts(n) := itbLD_price_list(n).Amount_Printouts;
			rcRecOfTab.row_id(n) := itbLD_price_list(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPRICE_LIST_Id
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
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPRICE_LIST_Id = rcData.PRICE_LIST_Id
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
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPRICE_LIST_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	IS
		rcError styLD_price_list;
	BEGIN		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		Load
		(
			inuPRICE_LIST_Id
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
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPRICE_LIST_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		orcRecord out nocopy styLD_price_list
	)
	IS
		rcError styLD_price_list;
	BEGIN		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		Load
		(
			inuPRICE_LIST_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN styLD_price_list
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type
	)
	RETURN styLD_price_list
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_price_list
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_price_list
	)
	IS
		rfLD_price_list tyrfLD_price_list;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_price_list.Price_List_Id,
		            LD_price_list.Description,
		            LD_price_list.Supplier_Id,
		            LD_price_list.Creation_Date,
		            LD_price_list.Initial_Date,
		            LD_price_list.Final_Date,
		            LD_price_list.Approved,
		            LD_price_list.Last_Date_Approved,
		            LD_price_list.Version,
		            LD_price_list.Condition_Approved,
		            LD_price_list.Amount_Printouts,
		            LD_price_list.rowid
                FROM LD_price_list';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_price_list for sbFullQuery;
		fetch rfLD_price_list bulk collect INTO otbResult;
		close rfLD_price_list;
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
		            LD_price_list.Price_List_Id,
		            LD_price_list.Description,
		            LD_price_list.Supplier_Id,
		            LD_price_list.Creation_Date,
		            LD_price_list.Initial_Date,
		            LD_price_list.Final_Date,
		            LD_price_list.Approved,
		            LD_price_list.Last_Date_Approved,
		            LD_price_list.Version,
		            LD_price_list.Condition_Approved,
		            LD_price_list.Amount_Printouts,
		            LD_price_list.rowid
                FROM LD_price_list';
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
		ircLD_price_list in styLD_price_list
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_price_list,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_price_list in styLD_price_list,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_price_list.PRICE_LIST_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PRICE_LIST_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_price_list
		(
			Price_List_Id,
			Description,
			Supplier_Id,
			Creation_Date,
			Initial_Date,
			Final_Date,
			Approved,
			Last_Date_Approved,
			Version,
			Condition_Approved,
			Amount_Printouts
		)
		values
		(
			ircLD_price_list.Price_List_Id,
			ircLD_price_list.Description,
			ircLD_price_list.Supplier_Id,
			ircLD_price_list.Creation_Date,
			ircLD_price_list.Initial_Date,
			ircLD_price_list.Final_Date,
			ircLD_price_list.Approved,
			ircLD_price_list.Last_Date_Approved,
			ircLD_price_list.Version,
			ircLD_price_list.Condition_Approved,
			ircLD_price_list.Amount_Printouts
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_price_list));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_price_list in out nocopy tytbLD_price_list
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_price_list, blUseRowID);
		forall n in iotbLD_price_list.first..iotbLD_price_list.last
			insert into LD_price_list
			(
			Price_List_Id,
			Description,
			Supplier_Id,
			Creation_Date,
			Initial_Date,
			Final_Date,
			Approved,
			Last_Date_Approved,
			Version,
			Condition_Approved,
			Amount_Printouts
		)
		values
		(
			rcRecOfTab.Price_List_Id(n),
			rcRecOfTab.Description(n),
			rcRecOfTab.Supplier_Id(n),
			rcRecOfTab.Creation_Date(n),
			rcRecOfTab.Initial_Date(n),
			rcRecOfTab.Final_Date(n),
			rcRecOfTab.Approved(n),
			rcRecOfTab.Last_Date_Approved(n),
			rcRecOfTab.Version(n),
			rcRecOfTab.Condition_Approved(n),
			rcRecOfTab.Amount_Printouts(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		delete
		from LD_price_list
		where
       		PRICE_LIST_Id=inuPRICE_LIST_Id;
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
		rcError  styLD_price_list;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_price_list
		where
			rowid = iriRowID
		returning
   PRICE_LIST_Id
		into
			rcError.PRICE_LIST_Id;

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
		iotbLD_price_list in out nocopy tytbLD_price_list,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_price_list;
	BEGIN
		FillRecordOfTables(iotbLD_price_list, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_price_list.first .. iotbLD_price_list.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_price_list.first .. iotbLD_price_list.last
				delete
				from LD_price_list
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_price_list.first .. iotbLD_price_list.last loop
					LockByPk
					(
							rcRecOfTab.PRICE_LIST_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_price_list.first .. iotbLD_price_list.last
				delete
				from LD_price_list
				where
		         	PRICE_LIST_Id = rcRecOfTab.PRICE_LIST_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_price_list in styLD_price_list,
		inuLock	  in number default 0
	)
	IS
		nuPRICE_LIST_Id LD_price_list.PRICE_LIST_Id%type;

	BEGIN
		if ircLD_price_list.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_price_list.rowid,rcData);
			end if;
			update LD_price_list
			set

        Description = ircLD_price_list.Description,
        Supplier_Id = ircLD_price_list.Supplier_Id,
        Creation_Date = ircLD_price_list.Creation_Date,
        Initial_Date = ircLD_price_list.Initial_Date,
        Final_Date = ircLD_price_list.Final_Date,
        Approved = ircLD_price_list.Approved,
        Last_Date_Approved = ircLD_price_list.Last_Date_Approved,
        Version = ircLD_price_list.Version,
        Condition_Approved = ircLD_price_list.Condition_Approved,
        Amount_Printouts = ircLD_price_list.Amount_Printouts
			where
				rowid = ircLD_price_list.rowid
			returning
    PRICE_LIST_Id
			into
				nuPRICE_LIST_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_price_list.PRICE_LIST_Id,
					rcData
				);
			end if;

			update LD_price_list
			set
        Description = ircLD_price_list.Description,
        Supplier_Id = ircLD_price_list.Supplier_Id,
        Creation_Date = ircLD_price_list.Creation_Date,
        Initial_Date = ircLD_price_list.Initial_Date,
        Final_Date = ircLD_price_list.Final_Date,
        Approved = ircLD_price_list.Approved,
        Last_Date_Approved = ircLD_price_list.Last_Date_Approved,
        Version = ircLD_price_list.Version,
        Condition_Approved = ircLD_price_list.Condition_Approved,
        Amount_Printouts = ircLD_price_list.Amount_Printouts
			where
	         	PRICE_LIST_Id = ircLD_price_list.PRICE_LIST_Id
			returning
    PRICE_LIST_Id
			into
				nuPRICE_LIST_Id;
		end if;

		if
			nuPRICE_LIST_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_price_list));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_price_list in out nocopy tytbLD_price_list,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_price_list;
  BEGIN
    FillRecordOfTables(iotbLD_price_list,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_price_list.first .. iotbLD_price_list.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_price_list.first .. iotbLD_price_list.last
        update LD_price_list
        set

            Description = rcRecOfTab.Description(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Creation_Date = rcRecOfTab.Creation_Date(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Approved = rcRecOfTab.Approved(n),
            Last_Date_Approved = rcRecOfTab.Last_Date_Approved(n),
            Version = rcRecOfTab.Version(n),
            Condition_Approved = rcRecOfTab.Condition_Approved(n),
            Amount_Printouts = rcRecOfTab.Amount_Printouts(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_price_list.first .. iotbLD_price_list.last loop
          LockByPk
          (
              rcRecOfTab.PRICE_LIST_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_price_list.first .. iotbLD_price_list.last
        update LD_price_list
        set
					Description = rcRecOfTab.Description(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n),
					Creation_Date = rcRecOfTab.Creation_Date(n),
					Initial_Date = rcRecOfTab.Initial_Date(n),
					Final_Date = rcRecOfTab.Final_Date(n),
					Approved = rcRecOfTab.Approved(n),
					Last_Date_Approved = rcRecOfTab.Last_Date_Approved(n),
					Version = rcRecOfTab.Version(n),
					Condition_Approved = rcRecOfTab.Condition_Approved(n),
					Amount_Printouts = rcRecOfTab.Amount_Printouts(n)
          where
          PRICE_LIST_Id = rcRecOfTab.PRICE_LIST_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		isbDescription$ in LD_price_list.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Description = isbDescription$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuSupplier_Id$ in LD_price_list.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Supplier_Id = inuSupplier_Id$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCreation_Date
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		idtCreation_Date$ in LD_price_list.Creation_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Creation_Date = idtCreation_Date$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Creation_Date:= idtCreation_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInitial_Date
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		idtInitial_Date$ in LD_price_list.Initial_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Initial_Date = idtInitial_Date$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Initial_Date:= idtInitial_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFinal_Date
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		idtFinal_Date$ in LD_price_list.Final_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Final_Date = idtFinal_Date$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Final_Date:= idtFinal_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApproved
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		isbApproved$ in LD_price_list.Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Approved = isbApproved$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Approved:= isbApproved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLast_Date_Approved
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		idtLast_Date_Approved$ in LD_price_list.Last_Date_Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Last_Date_Approved = idtLast_Date_Approved$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Last_Date_Approved:= idtLast_Date_Approved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updVersion
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuVersion$ in LD_price_list.Version%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Version = inuVersion$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Version:= inuVersion$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCondition_Approved
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		isbCondition_Approved$ in LD_price_list.Condition_Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Condition_Approved = isbCondition_Approved$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Condition_Approved:= isbCondition_Approved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updAmount_Printouts
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuAmount_Printouts$ in LD_price_list.Amount_Printouts%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list;
	BEGIN
		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_Id,
				rcData
			);
		end if;

		update LD_price_list
		set
			Amount_Printouts = inuAmount_Printouts$
		where
			PRICE_LIST_Id = inuPRICE_LIST_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Amount_Printouts:= inuAmount_Printouts$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPrice_List_Id
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Price_List_Id%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Price_List_Id);
		end if;
		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData.Price_List_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDescription
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Description%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData.Description);
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
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Supplier_Id%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuPRICE_LIST_Id
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

	FUNCTION fdtGetCreation_Date
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Creation_Date%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Creation_Date);
		end if;
		Load
		(
		 		inuPRICE_LIST_Id
		);
		return(rcData.Creation_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetInitial_Date
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Initial_Date%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Initial_Date);
		end if;
		Load
		(
		 		inuPRICE_LIST_Id
		);
		return(rcData.Initial_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetFinal_Date
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Final_Date%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Final_Date);
		end if;
		Load
		(
		 		inuPRICE_LIST_Id
		);
		return(rcData.Final_Date);
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
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Approved%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Approved);
		end if;
		Load
		(
			inuPRICE_LIST_Id
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

	FUNCTION fdtGetLast_Date_Approved
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Last_Date_Approved%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Last_Date_Approved);
		end if;
		Load
		(
		 		inuPRICE_LIST_Id
		);
		return(rcData.Last_Date_Approved);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetVersion
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Version%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Version);
		end if;
		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData.Version);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetCondition_Approved
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Condition_Approved%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id:=inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Condition_Approved);
		end if;
		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData.Condition_Approved);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetAmount_Printouts
	(
		inuPRICE_LIST_Id in LD_price_list.PRICE_LIST_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list.Amount_Printouts%type
	IS
		rcError styLD_price_list;
	BEGIN

		rcError.PRICE_LIST_Id := inuPRICE_LIST_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_Id
			 )
		then
			 return(rcData.Amount_Printouts);
		end if;
		Load
		(
			inuPRICE_LIST_Id
		);
		return(rcData.Amount_Printouts);
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
end DALD_price_list;
/
PROMPT Otorgando permisos de ejecucion a DALD_PRICE_LIST
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_PRICE_LIST', 'ADM_PERSON');
END;
/