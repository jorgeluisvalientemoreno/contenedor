CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_log_file_fnb
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
  )
  IS
		SELECT LD_log_file_fnb.*,LD_log_file_fnb.rowid
		FROM LD_log_file_fnb
		WHERE
			LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_log_file_fnb.*,LD_log_file_fnb.rowid
		FROM LD_log_file_fnb
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_log_file_fnb  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_log_file_fnb is table of styLD_log_file_fnb index by binary_integer;
	type tyrfRecords is ref cursor return styLD_log_file_fnb;

	/* Tipos referenciando al registro */
	type tytbLog_File_Fnb_Id is table of LD_log_file_fnb.Log_File_Fnb_Id%type index by binary_integer;
	type tytbFile_Name is table of LD_log_file_fnb.File_Name%type index by binary_integer;
	type tytbCreation_Date is table of LD_log_file_fnb.Creation_Date%type index by binary_integer;
	type tytbNumber_Orders_Lega is table of LD_log_file_fnb.Number_Orders_Lega%type index by binary_integer;
	type tytbNumber_Order_Not_Lega is table of LD_log_file_fnb.Number_Order_Not_Lega%type index by binary_integer;
	type tytbSupplier_Id is table of LD_log_file_fnb.Supplier_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_log_file_fnb is record
	(

		Log_File_Fnb_Id   tytbLog_File_Fnb_Id,
		File_Name   tytbFile_Name,
		Creation_Date   tytbCreation_Date,
		Number_Orders_Lega   tytbNumber_Orders_Lega,
		Number_Order_Not_Lega   tytbNumber_Order_Not_Lega,
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	);

	PROCEDURE getRecord
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		orcRecord out nocopy styLD_log_file_fnb
	);

	FUNCTION frcGetRcData
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN styLD_log_file_fnb;

	FUNCTION frcGetRcData
	RETURN styLD_log_file_fnb;

	FUNCTION frcGetRecord
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN styLD_log_file_fnb;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_log_file_fnb
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_log_file_fnb in styLD_log_file_fnb
	);

 	  PROCEDURE insRecord
	(
		ircLD_log_file_fnb in styLD_log_file_fnb,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_log_file_fnb in out nocopy tytbLD_log_file_fnb
	);

	PROCEDURE delRecord
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_log_file_fnb in out nocopy tytbLD_log_file_fnb,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_log_file_fnb in styLD_log_file_fnb,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_log_file_fnb in out nocopy tytbLD_log_file_fnb,
		inuLock in number default 1
	);

		PROCEDURE updFile_Name
		(
				inuLOG_FILE_FNB_Id   in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
				isbFile_Name$  in LD_log_file_fnb.File_Name%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCreation_Date
		(
				inuLOG_FILE_FNB_Id   in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
				idtCreation_Date$  in LD_log_file_fnb.Creation_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updNumber_Orders_Lega
		(
				inuLOG_FILE_FNB_Id   in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
				inuNumber_Orders_Lega$  in LD_log_file_fnb.Number_Orders_Lega%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updNumber_Order_Not_Lega
		(
				inuLOG_FILE_FNB_Id   in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
				inuNumber_Order_Not_Lega$  in LD_log_file_fnb.Number_Order_Not_Lega%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuLOG_FILE_FNB_Id   in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
				inuSupplier_Id$  in LD_log_file_fnb.Supplier_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetLog_File_Fnb_Id
    	(
    	    inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_log_file_fnb.Log_File_Fnb_Id%type;

    	FUNCTION fsbGetFile_Name
    	(
    	    inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_log_file_fnb.File_Name%type;

    	FUNCTION fdtGetCreation_Date
    	(
    	    inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_log_file_fnb.Creation_Date%type;

    	FUNCTION fnuGetNumber_Orders_Lega
    	(
    	    inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_log_file_fnb.Number_Orders_Lega%type;

    	FUNCTION fnuGetNumber_Order_Not_Lega
    	(
    	    inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_log_file_fnb.Number_Order_Not_Lega%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_log_file_fnb.Supplier_Id%type;


	PROCEDURE LockByPk
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		orcLD_log_file_fnb  out styLD_log_file_fnb
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_log_file_fnb  out styLD_log_file_fnb
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_log_file_fnb;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_log_file_fnb
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_LOG_FILE_FNB';
	  cnuGeEntityId constant varchar2(30) := 8189; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	IS
		SELECT LD_log_file_fnb.*,LD_log_file_fnb.rowid
		FROM LD_log_file_fnb
		WHERE  LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_log_file_fnb.*,LD_log_file_fnb.rowid
		FROM LD_log_file_fnb
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_log_file_fnb is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_log_file_fnb;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_log_file_fnb default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LOG_FILE_FNB_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		orcLD_log_file_fnb  out styLD_log_file_fnb
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;

		Open cuLockRcByPk
		(
			inuLOG_FILE_FNB_Id
		);

		fetch cuLockRcByPk into orcLD_log_file_fnb;
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
		orcLD_log_file_fnb  out styLD_log_file_fnb
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_log_file_fnb;
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
		itbLD_log_file_fnb  in out nocopy tytbLD_log_file_fnb
	)
	IS
	BEGIN
			rcRecOfTab.Log_File_Fnb_Id.delete;
			rcRecOfTab.File_Name.delete;
			rcRecOfTab.Creation_Date.delete;
			rcRecOfTab.Number_Orders_Lega.delete;
			rcRecOfTab.Number_Order_Not_Lega.delete;
			rcRecOfTab.Supplier_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_log_file_fnb  in out nocopy tytbLD_log_file_fnb,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_log_file_fnb);
		for n in itbLD_log_file_fnb.first .. itbLD_log_file_fnb.last loop
			rcRecOfTab.Log_File_Fnb_Id(n) := itbLD_log_file_fnb(n).Log_File_Fnb_Id;
			rcRecOfTab.File_Name(n) := itbLD_log_file_fnb(n).File_Name;
			rcRecOfTab.Creation_Date(n) := itbLD_log_file_fnb(n).Creation_Date;
			rcRecOfTab.Number_Orders_Lega(n) := itbLD_log_file_fnb(n).Number_Orders_Lega;
			rcRecOfTab.Number_Order_Not_Lega(n) := itbLD_log_file_fnb(n).Number_Order_Not_Lega;
			rcRecOfTab.Supplier_Id(n) := itbLD_log_file_fnb(n).Supplier_Id;
			rcRecOfTab.row_id(n) := itbLD_log_file_fnb(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLOG_FILE_FNB_Id
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLOG_FILE_FNB_Id = rcData.LOG_FILE_FNB_Id
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;

		Load
		(
			inuLOG_FILE_FNB_Id
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		orcRecord out nocopy styLD_log_file_fnb
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;

		Load
		(
			inuLOG_FILE_FNB_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN styLD_log_file_fnb
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;

		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type
	)
	RETURN styLD_log_file_fnb
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_log_file_fnb
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_log_file_fnb
	)
	IS
		rfLD_log_file_fnb tyrfLD_log_file_fnb;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_log_file_fnb.Log_File_Fnb_Id,
		            LD_log_file_fnb.File_Name,
		            LD_log_file_fnb.Creation_Date,
		            LD_log_file_fnb.Number_Orders_Lega,
		            LD_log_file_fnb.Number_Order_Not_Lega,
		            LD_log_file_fnb.Supplier_Id,
		            LD_log_file_fnb.rowid
                FROM LD_log_file_fnb';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_log_file_fnb for sbFullQuery;
		fetch rfLD_log_file_fnb bulk collect INTO otbResult;
		close rfLD_log_file_fnb;
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
		            LD_log_file_fnb.Log_File_Fnb_Id,
		            LD_log_file_fnb.File_Name,
		            LD_log_file_fnb.Creation_Date,
		            LD_log_file_fnb.Number_Orders_Lega,
		            LD_log_file_fnb.Number_Order_Not_Lega,
		            LD_log_file_fnb.Supplier_Id,
		            LD_log_file_fnb.rowid
                FROM LD_log_file_fnb';
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
		ircLD_log_file_fnb in styLD_log_file_fnb
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_log_file_fnb,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_log_file_fnb in styLD_log_file_fnb,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_log_file_fnb.LOG_FILE_FNB_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LOG_FILE_FNB_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_log_file_fnb
		(
			Log_File_Fnb_Id,
			File_Name,
			Creation_Date,
			Number_Orders_Lega,
			Number_Order_Not_Lega,
			Supplier_Id
		)
		values
		(
			ircLD_log_file_fnb.Log_File_Fnb_Id,
			ircLD_log_file_fnb.File_Name,
			ircLD_log_file_fnb.Creation_Date,
			ircLD_log_file_fnb.Number_Orders_Lega,
			ircLD_log_file_fnb.Number_Order_Not_Lega,
			ircLD_log_file_fnb.Supplier_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_log_file_fnb));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_log_file_fnb in out nocopy tytbLD_log_file_fnb
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_log_file_fnb, blUseRowID);
		forall n in iotbLD_log_file_fnb.first..iotbLD_log_file_fnb.last
			insert into LD_log_file_fnb
			(
			Log_File_Fnb_Id,
			File_Name,
			Creation_Date,
			Number_Orders_Lega,
			Number_Order_Not_Lega,
			Supplier_Id
		)
		values
		(
			rcRecOfTab.Log_File_Fnb_Id(n),
			rcRecOfTab.File_Name(n),
			rcRecOfTab.Creation_Date(n),
			rcRecOfTab.Number_Orders_Lega(n),
			rcRecOfTab.Number_Order_Not_Lega(n),
			rcRecOfTab.Supplier_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;

		if inuLock=1 then
			LockByPk
			(
				inuLOG_FILE_FNB_Id,
				rcData
			);
		end if;

		delete
		from LD_log_file_fnb
		where
       		LOG_FILE_FNB_Id=inuLOG_FILE_FNB_Id;
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
		rcError  styLD_log_file_fnb;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_log_file_fnb
		where
			rowid = iriRowID
		returning
   LOG_FILE_FNB_Id
		into
			rcError.LOG_FILE_FNB_Id;

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
		iotbLD_log_file_fnb in out nocopy tytbLD_log_file_fnb,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_log_file_fnb;
	BEGIN
		FillRecordOfTables(iotbLD_log_file_fnb, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last
				delete
				from LD_log_file_fnb
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last loop
					LockByPk
					(
							rcRecOfTab.LOG_FILE_FNB_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last
				delete
				from LD_log_file_fnb
				where
		         	LOG_FILE_FNB_Id = rcRecOfTab.LOG_FILE_FNB_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_log_file_fnb in styLD_log_file_fnb,
		inuLock	  in number default 0
	)
	IS
		nuLOG_FILE_FNB_Id LD_log_file_fnb.LOG_FILE_FNB_Id%type;

	BEGIN
		if ircLD_log_file_fnb.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_log_file_fnb.rowid,rcData);
			end if;
			update LD_log_file_fnb
			set

        File_Name = ircLD_log_file_fnb.File_Name,
        Creation_Date = ircLD_log_file_fnb.Creation_Date,
        Number_Orders_Lega = ircLD_log_file_fnb.Number_Orders_Lega,
        Number_Order_Not_Lega = ircLD_log_file_fnb.Number_Order_Not_Lega,
        Supplier_Id = ircLD_log_file_fnb.Supplier_Id
			where
				rowid = ircLD_log_file_fnb.rowid
			returning
    LOG_FILE_FNB_Id
			into
				nuLOG_FILE_FNB_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_log_file_fnb.LOG_FILE_FNB_Id,
					rcData
				);
			end if;

			update LD_log_file_fnb
			set
        File_Name = ircLD_log_file_fnb.File_Name,
        Creation_Date = ircLD_log_file_fnb.Creation_Date,
        Number_Orders_Lega = ircLD_log_file_fnb.Number_Orders_Lega,
        Number_Order_Not_Lega = ircLD_log_file_fnb.Number_Order_Not_Lega,
        Supplier_Id = ircLD_log_file_fnb.Supplier_Id
			where
	         	LOG_FILE_FNB_Id = ircLD_log_file_fnb.LOG_FILE_FNB_Id
			returning
    LOG_FILE_FNB_Id
			into
				nuLOG_FILE_FNB_Id;
		end if;

		if
			nuLOG_FILE_FNB_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_log_file_fnb));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_log_file_fnb in out nocopy tytbLD_log_file_fnb,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_log_file_fnb;
  BEGIN
    FillRecordOfTables(iotbLD_log_file_fnb,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last
        update LD_log_file_fnb
        set

            File_Name = rcRecOfTab.File_Name(n),
            Creation_Date = rcRecOfTab.Creation_Date(n),
            Number_Orders_Lega = rcRecOfTab.Number_Orders_Lega(n),
            Number_Order_Not_Lega = rcRecOfTab.Number_Order_Not_Lega(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last loop
          LockByPk
          (
              rcRecOfTab.LOG_FILE_FNB_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_log_file_fnb.first .. iotbLD_log_file_fnb.last
        update LD_log_file_fnb
        set
					File_Name = rcRecOfTab.File_Name(n),
					Creation_Date = rcRecOfTab.Creation_Date(n),
					Number_Orders_Lega = rcRecOfTab.Number_Orders_Lega(n),
					Number_Order_Not_Lega = rcRecOfTab.Number_Order_Not_Lega(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
          LOG_FILE_FNB_Id = rcRecOfTab.LOG_FILE_FNB_Id(n)
;
    end if;
  END;

	PROCEDURE updFile_Name
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		isbFile_Name$ in LD_log_file_fnb.File_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLOG_FILE_FNB_Id,
				rcData
			);
		end if;

		update LD_log_file_fnb
		set
			File_Name = isbFile_Name$
		where
			LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.File_Name:= isbFile_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCreation_Date
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		idtCreation_Date$ in LD_log_file_fnb.Creation_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLOG_FILE_FNB_Id,
				rcData
			);
		end if;

		update LD_log_file_fnb
		set
			Creation_Date = idtCreation_Date$
		where
			LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Creation_Date:= idtCreation_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updNumber_Orders_Lega
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuNumber_Orders_Lega$ in LD_log_file_fnb.Number_Orders_Lega%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLOG_FILE_FNB_Id,
				rcData
			);
		end if;

		update LD_log_file_fnb
		set
			Number_Orders_Lega = inuNumber_Orders_Lega$
		where
			LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Number_Orders_Lega:= inuNumber_Orders_Lega$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updNumber_Order_Not_Lega
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuNumber_Order_Not_Lega$ in LD_log_file_fnb.Number_Order_Not_Lega%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLOG_FILE_FNB_Id,
				rcData
			);
		end if;

		update LD_log_file_fnb
		set
			Number_Order_Not_Lega = inuNumber_Order_Not_Lega$
		where
			LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Number_Order_Not_Lega:= inuNumber_Order_Not_Lega$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuSupplier_Id$ in LD_log_file_fnb.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_log_file_fnb;
	BEGIN
		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLOG_FILE_FNB_Id,
				rcData
			);
		end if;

		update LD_log_file_fnb
		set
			Supplier_Id = inuSupplier_Id$
		where
			LOG_FILE_FNB_Id = inuLOG_FILE_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetLog_File_Fnb_Id
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_log_file_fnb.Log_File_Fnb_Id%type
	IS
		rcError styLD_log_file_fnb;
	BEGIN

		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData.Log_File_Fnb_Id);
		end if;
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(rcData.Log_File_Fnb_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetFile_Name
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_log_file_fnb.File_Name%type
	IS
		rcError styLD_log_file_fnb;
	BEGIN

		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData.File_Name);
		end if;
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(rcData.File_Name);
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_log_file_fnb.Creation_Date%type
	IS
		rcError styLD_log_file_fnb;
	BEGIN

		rcError.LOG_FILE_FNB_Id:=inuLOG_FILE_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData.Creation_Date);
		end if;
		Load
		(
		 		inuLOG_FILE_FNB_Id
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

	FUNCTION fnuGetNumber_Orders_Lega
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_log_file_fnb.Number_Orders_Lega%type
	IS
		rcError styLD_log_file_fnb;
	BEGIN

		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData.Number_Orders_Lega);
		end if;
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(rcData.Number_Orders_Lega);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetNumber_Order_Not_Lega
	(
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_log_file_fnb.Number_Order_Not_Lega%type
	IS
		rcError styLD_log_file_fnb;
	BEGIN

		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData.Number_Order_Not_Lega);
		end if;
		Load
		(
			inuLOG_FILE_FNB_Id
		);
		return(rcData.Number_Order_Not_Lega);
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
		inuLOG_FILE_FNB_Id in LD_log_file_fnb.LOG_FILE_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_log_file_fnb.Supplier_Id%type
	IS
		rcError styLD_log_file_fnb;
	BEGIN

		rcError.LOG_FILE_FNB_Id := inuLOG_FILE_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLOG_FILE_FNB_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuLOG_FILE_FNB_Id
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
end DALD_log_file_fnb;
/
PROMPT Otorgando permisos de ejecucion a DALD_LOG_FILE_FNB
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_LOG_FILE_FNB', 'ADM_PERSON');
END;
/