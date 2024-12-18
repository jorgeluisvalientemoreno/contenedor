CREATE OR REPLACE PACKAGE adm_person.dald_conse_historic_sales
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
  )
  IS
		SELECT LD_conse_historic_sales.*,LD_conse_historic_sales.rowid
		FROM LD_conse_historic_sales
		WHERE
			CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_conse_historic_sales.*,LD_conse_historic_sales.rowid
		FROM LD_conse_historic_sales
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_conse_historic_sales  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_conse_historic_sales is table of styLD_conse_historic_sales index by binary_integer;
	type tyrfRecords is ref cursor return styLD_conse_historic_sales;

	/* Tipos referenciando al registro */
	type tytbConse_Historic_Sales_Id is table of LD_conse_historic_sales.Conse_Historic_Sales_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_conse_historic_sales.Package_Id%type index by binary_integer;
	type tytbCurrent_Consecutive is table of LD_conse_historic_sales.Current_Consecutive%type index by binary_integer;
	type tytbNew_Consecutive is table of LD_conse_historic_sales.New_Consecutive%type index by binary_integer;
	type tytbRecord_Date is table of LD_conse_historic_sales.Record_Date%type index by binary_integer;
	type tytbPackage_Id_ is table of LD_conse_historic_sales.Package_Id_%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_conse_historic_sales is record
	(

		Conse_Historic_Sales_Id   tytbConse_Historic_Sales_Id,
		Package_Id   tytbPackage_Id,
		Current_Consecutive   tytbCurrent_Consecutive,
		New_Consecutive   tytbNew_Consecutive,
		Record_Date   tytbRecord_Date,
		Package_Id_   tytbPackage_Id_,
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
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	);

	PROCEDURE getRecord
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		orcRecord out nocopy styLD_conse_historic_sales
	);

	FUNCTION frcGetRcData
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN styLD_conse_historic_sales;

	FUNCTION frcGetRcData
	RETURN styLD_conse_historic_sales;

	FUNCTION frcGetRecord
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN styLD_conse_historic_sales;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_conse_historic_sales
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_conse_historic_sales in styLD_conse_historic_sales
	);

 	  PROCEDURE insRecord
	(
		ircLD_conse_historic_sales in styLD_conse_historic_sales,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_conse_historic_sales in out nocopy tytbLD_conse_historic_sales
	);

	PROCEDURE delRecord
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_conse_historic_sales in out nocopy tytbLD_conse_historic_sales,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_conse_historic_sales in styLD_conse_historic_sales,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_conse_historic_sales in out nocopy tytbLD_conse_historic_sales,
		inuLock in number default 1
	);

		PROCEDURE updPackage_Id
		(
				inuCONSE_HISTORIC_SALES_Id   in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
				inuPackage_Id$  in LD_conse_historic_sales.Package_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCurrent_Consecutive
		(
				inuCONSE_HISTORIC_SALES_Id   in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
				isbCurrent_Consecutive$  in LD_conse_historic_sales.Current_Consecutive%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updNew_Consecutive
		(
				inuCONSE_HISTORIC_SALES_Id   in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
				isbNew_Consecutive$  in LD_conse_historic_sales.New_Consecutive%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRecord_Date
		(
				inuCONSE_HISTORIC_SALES_Id   in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
				idtRecord_Date$  in LD_conse_historic_sales.Record_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPackage_Id_
		(
				inuCONSE_HISTORIC_SALES_Id   in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
				inuPackage_Id_$  in LD_conse_historic_sales.Package_Id_%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetConse_Historic_Sales_Id
    	(
    	    inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_conse_historic_sales.Conse_Historic_Sales_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_conse_historic_sales.Package_Id%type;

    	FUNCTION fsbGetCurrent_Consecutive
    	(
    	    inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_conse_historic_sales.Current_Consecutive%type;

    	FUNCTION fsbGetNew_Consecutive
    	(
    	    inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_conse_historic_sales.New_Consecutive%type;

    	FUNCTION fdtGetRecord_Date
    	(
    	    inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_conse_historic_sales.Record_Date%type;

    	FUNCTION fnuGetPackage_Id_
    	(
    	    inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_conse_historic_sales.Package_Id_%type;


	PROCEDURE LockByPk
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		orcLD_conse_historic_sales  out styLD_conse_historic_sales
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_conse_historic_sales  out styLD_conse_historic_sales
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_conse_historic_sales;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_conse_historic_sales
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CONSE_HISTORIC_SALES';
	  cnuGeEntityId constant varchar2(30) := 8221; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	IS
		SELECT LD_conse_historic_sales.*,LD_conse_historic_sales.rowid
		FROM LD_conse_historic_sales
		WHERE  CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_conse_historic_sales.*,LD_conse_historic_sales.rowid
		FROM LD_conse_historic_sales
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_conse_historic_sales is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_conse_historic_sales;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_conse_historic_sales default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSE_HISTORIC_SALES_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		orcLD_conse_historic_sales  out styLD_conse_historic_sales
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;

		Open cuLockRcByPk
		(
			inuCONSE_HISTORIC_SALES_Id
		);

		fetch cuLockRcByPk into orcLD_conse_historic_sales;
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
		orcLD_conse_historic_sales  out styLD_conse_historic_sales
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_conse_historic_sales;
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
		itbLD_conse_historic_sales  in out nocopy tytbLD_conse_historic_sales
	)
	IS
	BEGIN
			rcRecOfTab.Conse_Historic_Sales_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Current_Consecutive.delete;
			rcRecOfTab.New_Consecutive.delete;
			rcRecOfTab.Record_Date.delete;
			rcRecOfTab.Package_Id_.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_conse_historic_sales  in out nocopy tytbLD_conse_historic_sales,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_conse_historic_sales);
		for n in itbLD_conse_historic_sales.first .. itbLD_conse_historic_sales.last loop
			rcRecOfTab.Conse_Historic_Sales_Id(n) := itbLD_conse_historic_sales(n).Conse_Historic_Sales_Id;
			rcRecOfTab.Package_Id(n) := itbLD_conse_historic_sales(n).Package_Id;
			rcRecOfTab.Current_Consecutive(n) := itbLD_conse_historic_sales(n).Current_Consecutive;
			rcRecOfTab.New_Consecutive(n) := itbLD_conse_historic_sales(n).New_Consecutive;
			rcRecOfTab.Record_Date(n) := itbLD_conse_historic_sales(n).Record_Date;
			rcRecOfTab.Package_Id_(n) := itbLD_conse_historic_sales(n).Package_Id_;
			rcRecOfTab.row_id(n) := itbLD_conse_historic_sales(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSE_HISTORIC_SALES_Id
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
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSE_HISTORIC_SALES_Id = rcData.CONSE_HISTORIC_SALES_Id
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
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		Load
		(
			inuCONSE_HISTORIC_SALES_Id
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
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		orcRecord out nocopy styLD_conse_historic_sales
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN styLD_conse_historic_sales
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type
	)
	RETURN styLD_conse_historic_sales
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_conse_historic_sales
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_conse_historic_sales
	)
	IS
		rfLD_conse_historic_sales tyrfLD_conse_historic_sales;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_conse_historic_sales.Conse_Historic_Sales_Id,
		            LD_conse_historic_sales.Package_Id,
		            LD_conse_historic_sales.Current_Consecutive,
		            LD_conse_historic_sales.New_Consecutive,
		            LD_conse_historic_sales.Record_Date,
		            LD_conse_historic_sales.Package_Id_,
		            LD_conse_historic_sales.rowid
                FROM LD_conse_historic_sales';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_conse_historic_sales for sbFullQuery;
		fetch rfLD_conse_historic_sales bulk collect INTO otbResult;
		close rfLD_conse_historic_sales;
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
		            LD_conse_historic_sales.Conse_Historic_Sales_Id,
		            LD_conse_historic_sales.Package_Id,
		            LD_conse_historic_sales.Current_Consecutive,
		            LD_conse_historic_sales.New_Consecutive,
		            LD_conse_historic_sales.Record_Date,
		            LD_conse_historic_sales.Package_Id_,
		            LD_conse_historic_sales.rowid
                FROM LD_conse_historic_sales';
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
		ircLD_conse_historic_sales in styLD_conse_historic_sales
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_conse_historic_sales,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_conse_historic_sales in styLD_conse_historic_sales,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_conse_historic_sales.CONSE_HISTORIC_SALES_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSE_HISTORIC_SALES_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_conse_historic_sales
		(
			Conse_Historic_Sales_Id,
			Package_Id,
			Current_Consecutive,
			New_Consecutive,
			Record_Date,
			Package_Id_
		)
		values
		(
			ircLD_conse_historic_sales.Conse_Historic_Sales_Id,
			ircLD_conse_historic_sales.Package_Id,
			ircLD_conse_historic_sales.Current_Consecutive,
			ircLD_conse_historic_sales.New_Consecutive,
			ircLD_conse_historic_sales.Record_Date,
			ircLD_conse_historic_sales.Package_Id_
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_conse_historic_sales));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_conse_historic_sales in out nocopy tytbLD_conse_historic_sales
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_conse_historic_sales, blUseRowID);
		forall n in iotbLD_conse_historic_sales.first..iotbLD_conse_historic_sales.last
			insert into LD_conse_historic_sales
			(
			Conse_Historic_Sales_Id,
			Package_Id,
			Current_Consecutive,
			New_Consecutive,
			Record_Date,
			Package_Id_
		)
		values
		(
			rcRecOfTab.Conse_Historic_Sales_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Current_Consecutive(n),
			rcRecOfTab.New_Consecutive(n),
			rcRecOfTab.Record_Date(n),
			rcRecOfTab.Package_Id_(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		if inuLock=1 then
			LockByPk
			(
				inuCONSE_HISTORIC_SALES_Id,
				rcData
			);
		end if;

		delete
		from LD_conse_historic_sales
		where
       		CONSE_HISTORIC_SALES_Id=inuCONSE_HISTORIC_SALES_Id;
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
		rcError  styLD_conse_historic_sales;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_conse_historic_sales
		where
			rowid = iriRowID
		returning
   CONSE_HISTORIC_SALES_Id
		into
			rcError.CONSE_HISTORIC_SALES_Id;

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
		iotbLD_conse_historic_sales in out nocopy tytbLD_conse_historic_sales,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_conse_historic_sales;
	BEGIN
		FillRecordOfTables(iotbLD_conse_historic_sales, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last
				delete
				from LD_conse_historic_sales
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last loop
					LockByPk
					(
							rcRecOfTab.CONSE_HISTORIC_SALES_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last
				delete
				from LD_conse_historic_sales
				where
		         	CONSE_HISTORIC_SALES_Id = rcRecOfTab.CONSE_HISTORIC_SALES_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_conse_historic_sales in styLD_conse_historic_sales,
		inuLock	  in number default 0
	)
	IS
		nuCONSE_HISTORIC_SALES_Id LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type;

	BEGIN
		if ircLD_conse_historic_sales.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_conse_historic_sales.rowid,rcData);
			end if;
			update LD_conse_historic_sales
			set

        Package_Id = ircLD_conse_historic_sales.Package_Id,
        Current_Consecutive = ircLD_conse_historic_sales.Current_Consecutive,
        New_Consecutive = ircLD_conse_historic_sales.New_Consecutive,
        Record_Date = ircLD_conse_historic_sales.Record_Date,
        Package_Id_ = ircLD_conse_historic_sales.Package_Id_
			where
				rowid = ircLD_conse_historic_sales.rowid
			returning
    CONSE_HISTORIC_SALES_Id
			into
				nuCONSE_HISTORIC_SALES_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_conse_historic_sales.CONSE_HISTORIC_SALES_Id,
					rcData
				);
			end if;

			update LD_conse_historic_sales
			set
        Package_Id = ircLD_conse_historic_sales.Package_Id,
        Current_Consecutive = ircLD_conse_historic_sales.Current_Consecutive,
        New_Consecutive = ircLD_conse_historic_sales.New_Consecutive,
        Record_Date = ircLD_conse_historic_sales.Record_Date,
        Package_Id_ = ircLD_conse_historic_sales.Package_Id_
			where
	         	CONSE_HISTORIC_SALES_Id = ircLD_conse_historic_sales.CONSE_HISTORIC_SALES_Id
			returning
    CONSE_HISTORIC_SALES_Id
			into
				nuCONSE_HISTORIC_SALES_Id;
		end if;

		if
			nuCONSE_HISTORIC_SALES_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_conse_historic_sales));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_conse_historic_sales in out nocopy tytbLD_conse_historic_sales,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_conse_historic_sales;
  BEGIN
    FillRecordOfTables(iotbLD_conse_historic_sales,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last
        update LD_conse_historic_sales
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Current_Consecutive = rcRecOfTab.Current_Consecutive(n),
            New_Consecutive = rcRecOfTab.New_Consecutive(n),
            Record_Date = rcRecOfTab.Record_Date(n),
            Package_Id_ = rcRecOfTab.Package_Id_(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last loop
          LockByPk
          (
              rcRecOfTab.CONSE_HISTORIC_SALES_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_conse_historic_sales.first .. iotbLD_conse_historic_sales.last
        update LD_conse_historic_sales
        set
					Package_Id = rcRecOfTab.Package_Id(n),
					Current_Consecutive = rcRecOfTab.Current_Consecutive(n),
					New_Consecutive = rcRecOfTab.New_Consecutive(n),
					Record_Date = rcRecOfTab.Record_Date(n),
					Package_Id_ = rcRecOfTab.Package_Id_(n)
          where
          CONSE_HISTORIC_SALES_Id = rcRecOfTab.CONSE_HISTORIC_SALES_Id(n)
;
    end if;
  END;

	PROCEDURE updPackage_Id
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuPackage_Id$ in LD_conse_historic_sales.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSE_HISTORIC_SALES_Id,
				rcData
			);
		end if;

		update LD_conse_historic_sales
		set
			Package_Id = inuPackage_Id$
		where
			CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCurrent_Consecutive
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		isbCurrent_Consecutive$ in LD_conse_historic_sales.Current_Consecutive%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSE_HISTORIC_SALES_Id,
				rcData
			);
		end if;

		update LD_conse_historic_sales
		set
			Current_Consecutive = isbCurrent_Consecutive$
		where
			CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Current_Consecutive:= isbCurrent_Consecutive$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updNew_Consecutive
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		isbNew_Consecutive$ in LD_conse_historic_sales.New_Consecutive%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSE_HISTORIC_SALES_Id,
				rcData
			);
		end if;

		update LD_conse_historic_sales
		set
			New_Consecutive = isbNew_Consecutive$
		where
			CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.New_Consecutive:= isbNew_Consecutive$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord_Date
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		idtRecord_Date$ in LD_conse_historic_sales.Record_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSE_HISTORIC_SALES_Id,
				rcData
			);
		end if;

		update LD_conse_historic_sales
		set
			Record_Date = idtRecord_Date$
		where
			CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Record_Date:= idtRecord_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPackage_Id_
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuPackage_Id_$ in LD_conse_historic_sales.Package_Id_%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_conse_historic_sales;
	BEGIN
		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSE_HISTORIC_SALES_Id,
				rcData
			);
		end if;

		update LD_conse_historic_sales
		set
			Package_Id_ = inuPackage_Id_$
		where
			CONSE_HISTORIC_SALES_Id = inuCONSE_HISTORIC_SALES_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id_:= inuPackage_Id_$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetConse_Historic_Sales_Id
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_conse_historic_sales.Conse_Historic_Sales_Id%type
	IS
		rcError styLD_conse_historic_sales;
	BEGIN

		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData.Conse_Historic_Sales_Id);
		end if;
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData.Conse_Historic_Sales_Id);
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
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_conse_historic_sales.Package_Id%type
	IS
		rcError styLD_conse_historic_sales;
	BEGIN

		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
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

	FUNCTION fsbGetCurrent_Consecutive
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_conse_historic_sales.Current_Consecutive%type
	IS
		rcError styLD_conse_historic_sales;
	BEGIN

		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData.Current_Consecutive);
		end if;
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData.Current_Consecutive);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetNew_Consecutive
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_conse_historic_sales.New_Consecutive%type
	IS
		rcError styLD_conse_historic_sales;
	BEGIN

		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData.New_Consecutive);
		end if;
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData.New_Consecutive);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetRecord_Date
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_conse_historic_sales.Record_Date%type
	IS
		rcError styLD_conse_historic_sales;
	BEGIN

		rcError.CONSE_HISTORIC_SALES_Id:=inuCONSE_HISTORIC_SALES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData.Record_Date);
		end if;
		Load
		(
		 		inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData.Record_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPackage_Id_
	(
		inuCONSE_HISTORIC_SALES_Id in LD_conse_historic_sales.CONSE_HISTORIC_SALES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_conse_historic_sales.Package_Id_%type
	IS
		rcError styLD_conse_historic_sales;
	BEGIN

		rcError.CONSE_HISTORIC_SALES_Id := inuCONSE_HISTORIC_SALES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSE_HISTORIC_SALES_Id
			 )
		then
			 return(rcData.Package_Id_);
		end if;
		Load
		(
			inuCONSE_HISTORIC_SALES_Id
		);
		return(rcData.Package_Id_);
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
end DALD_conse_historic_sales;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CONSE_HISTORIC_SALES
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CONSE_HISTORIC_SALES', 'ADM_PERSON'); 
END;
/  
