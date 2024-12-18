CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_fnb_sale_fi_con
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
  )
  IS
		SELECT LD_fnb_sale_fi_con.*,LD_fnb_sale_fi_con.rowid
		FROM LD_fnb_sale_fi_con
		WHERE
			FNB_SALE_FI_CON_Id = inuFNB_SALE_FI_CON_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_fnb_sale_fi_con.*,LD_fnb_sale_fi_con.rowid
		FROM LD_fnb_sale_fi_con
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_fnb_sale_fi_con  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_fnb_sale_fi_con is table of styLD_fnb_sale_fi_con index by binary_integer;
	type tyrfRecords is ref cursor return styLD_fnb_sale_fi_con;

	/* Tipos referenciando al registro */
	type tytbFnb_Sale_Fi_Con_Id is table of LD_fnb_sale_fi_con.Fnb_Sale_Fi_Con_Id%type index by binary_integer;
	type tytbCreation_Date is table of LD_fnb_sale_fi_con.Creation_Date%type index by binary_integer;
	type tytbFile_Consecuti_Day is table of LD_fnb_sale_fi_con.File_Consecuti_Day%type index by binary_integer;
	type tytbService_Id is table of LD_fnb_sale_fi_con.Service_Id%type index by binary_integer;
	type tytbSupplier_Id is table of LD_fnb_sale_fi_con.Supplier_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_fnb_sale_fi_con is record
	(

		Fnb_Sale_Fi_Con_Id   tytbFnb_Sale_Fi_Con_Id,
		Creation_Date   tytbCreation_Date,
		File_Consecuti_Day   tytbFile_Consecuti_Day,
		Service_Id   tytbService_Id,
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	);

	PROCEDURE getRecord
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		orcRecord out nocopy styLD_fnb_sale_fi_con
	);

	FUNCTION frcGetRcData
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN styLD_fnb_sale_fi_con;

	FUNCTION frcGetRcData
	RETURN styLD_fnb_sale_fi_con;

	FUNCTION frcGetRecord
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN styLD_fnb_sale_fi_con;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_fnb_sale_fi_con
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_fnb_sale_fi_con in styLD_fnb_sale_fi_con
	);

 	  PROCEDURE insRecord
	(
		ircLD_fnb_sale_fi_con in styLD_fnb_sale_fi_con,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_fnb_sale_fi_con in out nocopy tytbLD_fnb_sale_fi_con
	);

	PROCEDURE delRecord
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_fnb_sale_fi_con in out nocopy tytbLD_fnb_sale_fi_con,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_fnb_sale_fi_con in styLD_fnb_sale_fi_con,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_fnb_sale_fi_con in out nocopy tytbLD_fnb_sale_fi_con,
		inuLock in number default 1
	);

		PROCEDURE updCreation_Date
		(
				inuFNB_SALE_FI_CON_Id   in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
				idtCreation_Date$  in LD_fnb_sale_fi_con.Creation_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFile_Consecuti_Day
		(
				inuFNB_SALE_FI_CON_Id   in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
				inuFile_Consecuti_Day$  in LD_fnb_sale_fi_con.File_Consecuti_Day%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updService_Id
		(
				inuFNB_SALE_FI_CON_Id   in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
				inuService_Id$  in LD_fnb_sale_fi_con.Service_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuFNB_SALE_FI_CON_Id   in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
				inuSupplier_Id$  in LD_fnb_sale_fi_con.Supplier_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetFnb_Sale_Fi_Con_Id
    	(
    	    inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_fnb_sale_fi_con.Fnb_Sale_Fi_Con_Id%type;

    	FUNCTION fdtGetCreation_Date
    	(
    	    inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_fnb_sale_fi_con.Creation_Date%type;

    	FUNCTION fnuGetFile_Consecuti_Day
    	(
    	    inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_fnb_sale_fi_con.File_Consecuti_Day%type;

    	FUNCTION fnuGetService_Id
    	(
    	    inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_fnb_sale_fi_con.Service_Id%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_fnb_sale_fi_con.Supplier_Id%type;


	PROCEDURE LockByPk
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		orcLD_fnb_sale_fi_con  out styLD_fnb_sale_fi_con
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_fnb_sale_fi_con  out styLD_fnb_sale_fi_con
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_fnb_sale_fi_con;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_fnb_sale_fi_con
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_FNB_SALE_FI_CON';
	  cnuGeEntityId constant varchar2(30) := 8691; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	IS
		SELECT LD_fnb_sale_fi_con.*,LD_fnb_sale_fi_con.rowid
		FROM LD_fnb_sale_fi_con
		WHERE  FNB_SALE_FI_CON_Id = inuFNB_SALE_FI_CON_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_fnb_sale_fi_con.*,LD_fnb_sale_fi_con.rowid
		FROM LD_fnb_sale_fi_con
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_fnb_sale_fi_con is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_fnb_sale_fi_con;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_fnb_sale_fi_con default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.FNB_SALE_FI_CON_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		orcLD_fnb_sale_fi_con  out styLD_fnb_sale_fi_con
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;

		Open cuLockRcByPk
		(
			inuFNB_SALE_FI_CON_Id
		);

		fetch cuLockRcByPk into orcLD_fnb_sale_fi_con;
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
		orcLD_fnb_sale_fi_con  out styLD_fnb_sale_fi_con
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_fnb_sale_fi_con;
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
		itbLD_fnb_sale_fi_con  in out nocopy tytbLD_fnb_sale_fi_con
	)
	IS
	BEGIN
			rcRecOfTab.Fnb_Sale_Fi_Con_Id.delete;
			rcRecOfTab.Creation_Date.delete;
			rcRecOfTab.File_Consecuti_Day.delete;
			rcRecOfTab.Service_Id.delete;
			rcRecOfTab.Supplier_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_fnb_sale_fi_con  in out nocopy tytbLD_fnb_sale_fi_con,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_fnb_sale_fi_con);
		for n in itbLD_fnb_sale_fi_con.first .. itbLD_fnb_sale_fi_con.last loop
			rcRecOfTab.Fnb_Sale_Fi_Con_Id(n) := itbLD_fnb_sale_fi_con(n).Fnb_Sale_Fi_Con_Id;
			rcRecOfTab.Creation_Date(n) := itbLD_fnb_sale_fi_con(n).Creation_Date;
			rcRecOfTab.File_Consecuti_Day(n) := itbLD_fnb_sale_fi_con(n).File_Consecuti_Day;
			rcRecOfTab.Service_Id(n) := itbLD_fnb_sale_fi_con(n).Service_Id;
			rcRecOfTab.Supplier_Id(n) := itbLD_fnb_sale_fi_con(n).Supplier_Id;
			rcRecOfTab.row_id(n) := itbLD_fnb_sale_fi_con(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuFNB_SALE_FI_CON_Id
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuFNB_SALE_FI_CON_Id = rcData.FNB_SALE_FI_CON_Id
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN		rcError.FNB_SALE_FI_CON_Id:=inuFNB_SALE_FI_CON_Id;

		Load
		(
			inuFNB_SALE_FI_CON_Id
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		orcRecord out nocopy styLD_fnb_sale_fi_con
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN		rcError.FNB_SALE_FI_CON_Id:=inuFNB_SALE_FI_CON_Id;

		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN styLD_fnb_sale_fi_con
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id:=inuFNB_SALE_FI_CON_Id;

		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type
	)
	RETURN styLD_fnb_sale_fi_con
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id:=inuFNB_SALE_FI_CON_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFNB_SALE_FI_CON_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_fnb_sale_fi_con
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_fnb_sale_fi_con
	)
	IS
		rfLD_fnb_sale_fi_con tyrfLD_fnb_sale_fi_con;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_fnb_sale_fi_con.Fnb_Sale_Fi_Con_Id,
		            LD_fnb_sale_fi_con.Creation_Date,
		            LD_fnb_sale_fi_con.File_Consecuti_Day,
		            LD_fnb_sale_fi_con.Service_Id,
		            LD_fnb_sale_fi_con.Supplier_Id,
		            LD_fnb_sale_fi_con.rowid
                FROM LD_fnb_sale_fi_con';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_fnb_sale_fi_con for sbFullQuery;
		fetch rfLD_fnb_sale_fi_con bulk collect INTO otbResult;
		close rfLD_fnb_sale_fi_con;
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
		            LD_fnb_sale_fi_con.Fnb_Sale_Fi_Con_Id,
		            LD_fnb_sale_fi_con.Creation_Date,
		            LD_fnb_sale_fi_con.File_Consecuti_Day,
		            LD_fnb_sale_fi_con.Service_Id,
		            LD_fnb_sale_fi_con.Supplier_Id,
		            LD_fnb_sale_fi_con.rowid
                FROM LD_fnb_sale_fi_con';
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
		ircLD_fnb_sale_fi_con in styLD_fnb_sale_fi_con
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_fnb_sale_fi_con,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_fnb_sale_fi_con in styLD_fnb_sale_fi_con,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|FNB_SALE_FI_CON_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_fnb_sale_fi_con
		(
			Fnb_Sale_Fi_Con_Id,
			Creation_Date,
			File_Consecuti_Day,
			Service_Id,
			Supplier_Id
		)
		values
		(
			ircLD_fnb_sale_fi_con.Fnb_Sale_Fi_Con_Id,
			ircLD_fnb_sale_fi_con.Creation_Date,
			ircLD_fnb_sale_fi_con.File_Consecuti_Day,
			ircLD_fnb_sale_fi_con.Service_Id,
			ircLD_fnb_sale_fi_con.Supplier_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_fnb_sale_fi_con));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_fnb_sale_fi_con in out nocopy tytbLD_fnb_sale_fi_con
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_fnb_sale_fi_con, blUseRowID);
		forall n in iotbLD_fnb_sale_fi_con.first..iotbLD_fnb_sale_fi_con.last
			insert into LD_fnb_sale_fi_con
			(
			Fnb_Sale_Fi_Con_Id,
			Creation_Date,
			File_Consecuti_Day,
			Service_Id,
			Supplier_Id
		)
		values
		(
			rcRecOfTab.Fnb_Sale_Fi_Con_Id(n),
			rcRecOfTab.Creation_Date(n),
			rcRecOfTab.File_Consecuti_Day(n),
			rcRecOfTab.Service_Id(n),
			rcRecOfTab.Supplier_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id:=inuFNB_SALE_FI_CON_Id;

		if inuLock=1 then
			LockByPk
			(
				inuFNB_SALE_FI_CON_Id,
				rcData
			);
		end if;

		delete
		from LD_fnb_sale_fi_con
		where
       		FNB_SALE_FI_CON_Id=inuFNB_SALE_FI_CON_Id;
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
		rcError  styLD_fnb_sale_fi_con;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_fnb_sale_fi_con
		where
			rowid = iriRowID
		returning
   FNB_SALE_FI_CON_Id
		into
			rcError.FNB_SALE_FI_CON_Id;

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
		iotbLD_fnb_sale_fi_con in out nocopy tytbLD_fnb_sale_fi_con,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_fnb_sale_fi_con;
	BEGIN
		FillRecordOfTables(iotbLD_fnb_sale_fi_con, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last
				delete
				from LD_fnb_sale_fi_con
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last loop
					LockByPk
					(
							rcRecOfTab.FNB_SALE_FI_CON_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last
				delete
				from LD_fnb_sale_fi_con
				where
		         	FNB_SALE_FI_CON_Id = rcRecOfTab.FNB_SALE_FI_CON_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_fnb_sale_fi_con in styLD_fnb_sale_fi_con,
		inuLock	  in number default 0
	)
	IS
		nuFNB_SALE_FI_CON_Id LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type;

	BEGIN
		if ircLD_fnb_sale_fi_con.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_fnb_sale_fi_con.rowid,rcData);
			end if;
			update LD_fnb_sale_fi_con
			set

        Creation_Date = ircLD_fnb_sale_fi_con.Creation_Date,
        File_Consecuti_Day = ircLD_fnb_sale_fi_con.File_Consecuti_Day,
        Service_Id = ircLD_fnb_sale_fi_con.Service_Id,
        Supplier_Id = ircLD_fnb_sale_fi_con.Supplier_Id
			where
				rowid = ircLD_fnb_sale_fi_con.rowid
			returning
    FNB_SALE_FI_CON_Id
			into
				nuFNB_SALE_FI_CON_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id,
					rcData
				);
			end if;

			update LD_fnb_sale_fi_con
			set
        Creation_Date = ircLD_fnb_sale_fi_con.Creation_Date,
        File_Consecuti_Day = ircLD_fnb_sale_fi_con.File_Consecuti_Day,
        Service_Id = ircLD_fnb_sale_fi_con.Service_Id,
        Supplier_Id = ircLD_fnb_sale_fi_con.Supplier_Id
			where
	         	FNB_SALE_FI_CON_Id = ircLD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id
			returning
    FNB_SALE_FI_CON_Id
			into
				nuFNB_SALE_FI_CON_Id;
		end if;

		if
			nuFNB_SALE_FI_CON_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_fnb_sale_fi_con));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_fnb_sale_fi_con in out nocopy tytbLD_fnb_sale_fi_con,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_fnb_sale_fi_con;
  BEGIN
    FillRecordOfTables(iotbLD_fnb_sale_fi_con,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last
        update LD_fnb_sale_fi_con
        set

            Creation_Date = rcRecOfTab.Creation_Date(n),
            File_Consecuti_Day = rcRecOfTab.File_Consecuti_Day(n),
            Service_Id = rcRecOfTab.Service_Id(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last loop
          LockByPk
          (
              rcRecOfTab.FNB_SALE_FI_CON_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_fnb_sale_fi_con.first .. iotbLD_fnb_sale_fi_con.last
        update LD_fnb_sale_fi_con
        set
					Creation_Date = rcRecOfTab.Creation_Date(n),
					File_Consecuti_Day = rcRecOfTab.File_Consecuti_Day(n),
					Service_Id = rcRecOfTab.Service_Id(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
          FNB_SALE_FI_CON_Id = rcRecOfTab.FNB_SALE_FI_CON_Id(n)
;
    end if;
  END;

	PROCEDURE updCreation_Date
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		idtCreation_Date$ in LD_fnb_sale_fi_con.Creation_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFNB_SALE_FI_CON_Id,
				rcData
			);
		end if;

		update LD_fnb_sale_fi_con
		set
			Creation_Date = idtCreation_Date$
		where
			FNB_SALE_FI_CON_Id = inuFNB_SALE_FI_CON_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Creation_Date:= idtCreation_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFile_Consecuti_Day
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuFile_Consecuti_Day$ in LD_fnb_sale_fi_con.File_Consecuti_Day%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFNB_SALE_FI_CON_Id,
				rcData
			);
		end if;

		update LD_fnb_sale_fi_con
		set
			File_Consecuti_Day = inuFile_Consecuti_Day$
		where
			FNB_SALE_FI_CON_Id = inuFNB_SALE_FI_CON_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.File_Consecuti_Day:= inuFile_Consecuti_Day$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updService_Id
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuService_Id$ in LD_fnb_sale_fi_con.Service_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFNB_SALE_FI_CON_Id,
				rcData
			);
		end if;

		update LD_fnb_sale_fi_con
		set
			Service_Id = inuService_Id$
		where
			FNB_SALE_FI_CON_Id = inuFNB_SALE_FI_CON_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Service_Id:= inuService_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuSupplier_Id$ in LD_fnb_sale_fi_con.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN
		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFNB_SALE_FI_CON_Id,
				rcData
			);
		end if;

		update LD_fnb_sale_fi_con
		set
			Supplier_Id = inuSupplier_Id$
		where
			FNB_SALE_FI_CON_Id = inuFNB_SALE_FI_CON_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetFnb_Sale_Fi_Con_Id
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_fnb_sale_fi_con.Fnb_Sale_Fi_Con_Id%type
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN

		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFNB_SALE_FI_CON_Id
			 )
		then
			 return(rcData.Fnb_Sale_Fi_Con_Id);
		end if;
		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		return(rcData.Fnb_Sale_Fi_Con_Id);
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_fnb_sale_fi_con.Creation_Date%type
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN

		rcError.FNB_SALE_FI_CON_Id:=inuFNB_SALE_FI_CON_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFNB_SALE_FI_CON_Id
			 )
		then
			 return(rcData.Creation_Date);
		end if;
		Load
		(
		 		inuFNB_SALE_FI_CON_Id
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

	FUNCTION fnuGetFile_Consecuti_Day
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_fnb_sale_fi_con.File_Consecuti_Day%type
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN

		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFNB_SALE_FI_CON_Id
			 )
		then
			 return(rcData.File_Consecuti_Day);
		end if;
		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		return(rcData.File_Consecuti_Day);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetService_Id
	(
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_fnb_sale_fi_con.Service_Id%type
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN

		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFNB_SALE_FI_CON_Id
			 )
		then
			 return(rcData.Service_Id);
		end if;
		Load
		(
			inuFNB_SALE_FI_CON_Id
		);
		return(rcData.Service_Id);
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
		inuFNB_SALE_FI_CON_Id in LD_fnb_sale_fi_con.FNB_SALE_FI_CON_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_fnb_sale_fi_con.Supplier_Id%type
	IS
		rcError styLD_fnb_sale_fi_con;
	BEGIN

		rcError.FNB_SALE_FI_CON_Id := inuFNB_SALE_FI_CON_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFNB_SALE_FI_CON_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuFNB_SALE_FI_CON_Id
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
end DALD_fnb_sale_fi_con;
/
PROMPT Otorgando permisos de ejecucion a DALD_FNB_SALE_FI_CON
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_FNB_SALE_FI_CON', 'ADM_PERSON');
END;
/