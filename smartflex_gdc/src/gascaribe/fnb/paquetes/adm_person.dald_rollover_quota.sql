CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_rollover_quota
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
  )
  IS
		SELECT LD_rollover_quota.*,LD_rollover_quota.rowid
		FROM LD_rollover_quota
		WHERE
			Rollover_Quota_Id = inuRollover_Quota_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_rollover_quota.*,LD_rollover_quota.rowid
		FROM LD_rollover_quota
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_rollover_quota  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_rollover_quota is table of styLD_rollover_quota index by binary_integer;
	type tyrfRecords is ref cursor return styLD_rollover_quota;

	/* Tipos referenciando al registro */
	type tytbRollover_Quota_Id is table of LD_rollover_quota.Rollover_Quota_Id%type index by binary_integer;
	type tytbProduct_Type_Id is table of LD_rollover_quota.Product_Type_Id%type index by binary_integer;
	type tytbCategory_Id is table of LD_rollover_quota.Category_Id%type index by binary_integer;
	type tytbSubcategory_Id is table of LD_rollover_quota.Subcategory_Id%type index by binary_integer;
	type tytbGeograp_Location_Id is table of LD_rollover_quota.Geograp_Location_Id%type index by binary_integer;
	type tytbQuota_Option is table of LD_rollover_quota.Quota_Option%type index by binary_integer;
	type tytbValue is table of LD_rollover_quota.Value%type index by binary_integer;
	type tytbActive is table of LD_rollover_quota.Active%type index by binary_integer;
	type tytbQuotas_Number is table of LD_rollover_quota.Quotas_Number%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_rollover_quota is record
	(

		Rollover_Quota_Id   tytbRollover_Quota_Id,
		Product_Type_Id   tytbProduct_Type_Id,
		Category_Id   tytbCategory_Id,
		Subcategory_Id   tytbSubcategory_Id,
		Geograp_Location_Id   tytbGeograp_Location_Id,
		Quota_Option   tytbQuota_Option,
		Value   tytbValue,
		Active   tytbActive,
		Quotas_Number   tytbQuotas_Number,
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	);

	PROCEDURE getRecord
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		orcRecord out nocopy styLD_rollover_quota
	);

	FUNCTION frcGetRcData
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN styLD_rollover_quota;

	FUNCTION frcGetRcData
	RETURN styLD_rollover_quota;

	FUNCTION frcGetRecord
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN styLD_rollover_quota;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_rollover_quota
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_rollover_quota in styLD_rollover_quota
	);

 	  PROCEDURE insRecord
	(
		ircLD_rollover_quota in styLD_rollover_quota,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_rollover_quota in out nocopy tytbLD_rollover_quota
	);

	PROCEDURE delRecord
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_rollover_quota in out nocopy tytbLD_rollover_quota,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_rollover_quota in styLD_rollover_quota,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_rollover_quota in out nocopy tytbLD_rollover_quota,
		inuLock in number default 1
	);

		PROCEDURE updProduct_Type_Id
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				inuProduct_Type_Id$  in LD_rollover_quota.Product_Type_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCategory_Id
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				inuCategory_Id$  in LD_rollover_quota.Category_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubcategory_Id
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				inuSubcategory_Id$  in LD_rollover_quota.Subcategory_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGeograp_Location_Id
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				inuGeograp_Location_Id$  in LD_rollover_quota.Geograp_Location_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Option
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				isbQuota_Option$  in LD_rollover_quota.Quota_Option%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValue
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				inuValue$  in LD_rollover_quota.Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updActive
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				isbActive$  in LD_rollover_quota.Active%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuotas_Number
		(
				inuRollover_Quota_Id   in LD_rollover_quota.Rollover_Quota_Id%type,
				inuQuotas_Number$  in LD_rollover_quota.Quotas_Number%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetRollover_Quota_Id
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Rollover_Quota_Id%type;

    	FUNCTION fnuGetProduct_Type_Id
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Product_Type_Id%type;

    	FUNCTION fnuGetCategory_Id
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Category_Id%type;

    	FUNCTION fnuGetSubcategory_Id
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Subcategory_Id%type;

    	FUNCTION fnuGetGeograp_Location_Id
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Geograp_Location_Id%type;

    	FUNCTION fsbGetQuota_Option
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Quota_Option%type;

    	FUNCTION fnuGetValue
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Value%type;

    	FUNCTION fsbGetActive
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Active%type;

    	FUNCTION fnuGetQuotas_Number
    	(
    	    inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_rollover_quota.Quotas_Number%type;


	PROCEDURE LockByPk
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		orcLD_rollover_quota  out styLD_rollover_quota
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_rollover_quota  out styLD_rollover_quota
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_rollover_quota;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_rollover_quota
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_ROLLOVER_QUOTA';
	  cnuGeEntityId constant varchar2(30) := 8695; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	IS
		SELECT LD_rollover_quota.*,LD_rollover_quota.rowid
		FROM LD_rollover_quota
		WHERE  Rollover_Quota_Id = inuRollover_Quota_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_rollover_quota.*,LD_rollover_quota.rowid
		FROM LD_rollover_quota
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_rollover_quota is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_rollover_quota;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_rollover_quota default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Rollover_Quota_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		orcLD_rollover_quota  out styLD_rollover_quota
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		Open cuLockRcByPk
		(
			inuRollover_Quota_Id
		);

		fetch cuLockRcByPk into orcLD_rollover_quota;
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
		orcLD_rollover_quota  out styLD_rollover_quota
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_rollover_quota;
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
		itbLD_rollover_quota  in out nocopy tytbLD_rollover_quota
	)
	IS
	BEGIN
			rcRecOfTab.Rollover_Quota_Id.delete;
			rcRecOfTab.Product_Type_Id.delete;
			rcRecOfTab.Category_Id.delete;
			rcRecOfTab.Subcategory_Id.delete;
			rcRecOfTab.Geograp_Location_Id.delete;
			rcRecOfTab.Quota_Option.delete;
			rcRecOfTab.Value.delete;
			rcRecOfTab.Active.delete;
			rcRecOfTab.Quotas_Number.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_rollover_quota  in out nocopy tytbLD_rollover_quota,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_rollover_quota);
		for n in itbLD_rollover_quota.first .. itbLD_rollover_quota.last loop
			rcRecOfTab.Rollover_Quota_Id(n) := itbLD_rollover_quota(n).Rollover_Quota_Id;
			rcRecOfTab.Product_Type_Id(n) := itbLD_rollover_quota(n).Product_Type_Id;
			rcRecOfTab.Category_Id(n) := itbLD_rollover_quota(n).Category_Id;
			rcRecOfTab.Subcategory_Id(n) := itbLD_rollover_quota(n).Subcategory_Id;
			rcRecOfTab.Geograp_Location_Id(n) := itbLD_rollover_quota(n).Geograp_Location_Id;
			rcRecOfTab.Quota_Option(n) := itbLD_rollover_quota(n).Quota_Option;
			rcRecOfTab.Value(n) := itbLD_rollover_quota(n).Value;
			rcRecOfTab.Active(n) := itbLD_rollover_quota(n).Active;
			rcRecOfTab.Quotas_Number(n) := itbLD_rollover_quota(n).Quotas_Number;
			rcRecOfTab.row_id(n) := itbLD_rollover_quota(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRollover_Quota_Id
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRollover_Quota_Id = rcData.Rollover_Quota_Id
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRollover_Quota_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;

		Load
		(
			inuRollover_Quota_Id
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuRollover_Quota_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		orcRecord out nocopy styLD_rollover_quota
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;

		Load
		(
			inuRollover_Quota_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN styLD_rollover_quota
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;

		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type
	)
	RETURN styLD_rollover_quota
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRollover_Quota_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_rollover_quota
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_rollover_quota
	)
	IS
		rfLD_rollover_quota tyrfLD_rollover_quota;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_rollover_quota.Rollover_Quota_Id,
		            LD_rollover_quota.Product_Type_Id,
		            LD_rollover_quota.Category_Id,
		            LD_rollover_quota.Subcategory_Id,
		            LD_rollover_quota.Geograp_Location_Id,
		            LD_rollover_quota.Quota_Option,
		            LD_rollover_quota.Value,
		            LD_rollover_quota.Active,
		            LD_rollover_quota.Quotas_Number,
		            LD_rollover_quota.rowid
                FROM LD_rollover_quota';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_rollover_quota for sbFullQuery;
		fetch rfLD_rollover_quota bulk collect INTO otbResult;
		close rfLD_rollover_quota;
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
		            LD_rollover_quota.Rollover_Quota_Id,
		            LD_rollover_quota.Product_Type_Id,
		            LD_rollover_quota.Category_Id,
		            LD_rollover_quota.Subcategory_Id,
		            LD_rollover_quota.Geograp_Location_Id,
		            LD_rollover_quota.Quota_Option,
		            LD_rollover_quota.Value,
		            LD_rollover_quota.Active,
		            LD_rollover_quota.Quotas_Number,
		            LD_rollover_quota.rowid
                FROM LD_rollover_quota';
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
		ircLD_rollover_quota in styLD_rollover_quota
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_rollover_quota,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_rollover_quota in styLD_rollover_quota,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_rollover_quota.Rollover_Quota_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Rollover_Quota_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_rollover_quota
		(
			Rollover_Quota_Id,
			Product_Type_Id,
			Category_Id,
			Subcategory_Id,
			Geograp_Location_Id,
			Quota_Option,
			Value,
			Active,
			Quotas_Number
		)
		values
		(
			ircLD_rollover_quota.Rollover_Quota_Id,
			ircLD_rollover_quota.Product_Type_Id,
			ircLD_rollover_quota.Category_Id,
			ircLD_rollover_quota.Subcategory_Id,
			ircLD_rollover_quota.Geograp_Location_Id,
			ircLD_rollover_quota.Quota_Option,
			ircLD_rollover_quota.Value,
			ircLD_rollover_quota.Active,
			ircLD_rollover_quota.Quotas_Number
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_rollover_quota));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_rollover_quota in out nocopy tytbLD_rollover_quota
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_rollover_quota, blUseRowID);
		forall n in iotbLD_rollover_quota.first..iotbLD_rollover_quota.last
			insert into LD_rollover_quota
			(
			Rollover_Quota_Id,
			Product_Type_Id,
			Category_Id,
			Subcategory_Id,
			Geograp_Location_Id,
			Quota_Option,
			Value,
			Active,
			Quotas_Number
		)
		values
		(
			rcRecOfTab.Rollover_Quota_Id(n),
			rcRecOfTab.Product_Type_Id(n),
			rcRecOfTab.Category_Id(n),
			rcRecOfTab.Subcategory_Id(n),
			rcRecOfTab.Geograp_Location_Id(n),
			rcRecOfTab.Quota_Option(n),
			rcRecOfTab.Value(n),
			rcRecOfTab.Active(n),
			rcRecOfTab.Quotas_Number(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;

		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		delete
		from LD_rollover_quota
		where
       		Rollover_Quota_Id=inuRollover_Quota_Id;
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
		rcError  styLD_rollover_quota;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_rollover_quota
		where
			rowid = iriRowID
		returning
   Rollover_Quota_Id
		into
			rcError.Rollover_Quota_Id;

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
		iotbLD_rollover_quota in out nocopy tytbLD_rollover_quota,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_rollover_quota;
	BEGIN
		FillRecordOfTables(iotbLD_rollover_quota, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last
				delete
				from LD_rollover_quota
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last loop
					LockByPk
					(
							rcRecOfTab.Rollover_Quota_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last
				delete
				from LD_rollover_quota
				where
		         	Rollover_Quota_Id = rcRecOfTab.Rollover_Quota_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_rollover_quota in styLD_rollover_quota,
		inuLock	  in number default 0
	)
	IS
		nuRollover_Quota_Id LD_rollover_quota.Rollover_Quota_Id%type;

	BEGIN
		if ircLD_rollover_quota.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_rollover_quota.rowid,rcData);
			end if;
			update LD_rollover_quota
			set

        Product_Type_Id = ircLD_rollover_quota.Product_Type_Id,
        Category_Id = ircLD_rollover_quota.Category_Id,
        Subcategory_Id = ircLD_rollover_quota.Subcategory_Id,
        Geograp_Location_Id = ircLD_rollover_quota.Geograp_Location_Id,
        Quota_Option = ircLD_rollover_quota.Quota_Option,
        Value = ircLD_rollover_quota.Value,
        Active = ircLD_rollover_quota.Active,
        Quotas_Number = ircLD_rollover_quota.Quotas_Number
			where
				rowid = ircLD_rollover_quota.rowid
			returning
    Rollover_Quota_Id
			into
				nuRollover_Quota_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_rollover_quota.Rollover_Quota_Id,
					rcData
				);
			end if;

			update LD_rollover_quota
			set
        Product_Type_Id = ircLD_rollover_quota.Product_Type_Id,
        Category_Id = ircLD_rollover_quota.Category_Id,
        Subcategory_Id = ircLD_rollover_quota.Subcategory_Id,
        Geograp_Location_Id = ircLD_rollover_quota.Geograp_Location_Id,
        Quota_Option = ircLD_rollover_quota.Quota_Option,
        Value = ircLD_rollover_quota.Value,
        Active = ircLD_rollover_quota.Active,
        Quotas_Number = ircLD_rollover_quota.Quotas_Number
			where
	         	Rollover_Quota_Id = ircLD_rollover_quota.Rollover_Quota_Id
			returning
    Rollover_Quota_Id
			into
				nuRollover_Quota_Id;
		end if;

		if
			nuRollover_Quota_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_rollover_quota));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_rollover_quota in out nocopy tytbLD_rollover_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rollover_quota;
  BEGIN
    FillRecordOfTables(iotbLD_rollover_quota,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last
        update LD_rollover_quota
        set

            Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
            Category_Id = rcRecOfTab.Category_Id(n),
            Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Quota_Option = rcRecOfTab.Quota_Option(n),
            Value = rcRecOfTab.Value(n),
            Active = rcRecOfTab.Active(n),
            Quotas_Number = rcRecOfTab.Quotas_Number(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last loop
          LockByPk
          (
              rcRecOfTab.Rollover_Quota_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rollover_quota.first .. iotbLD_rollover_quota.last
        update LD_rollover_quota
        set
					Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Quota_Option = rcRecOfTab.Quota_Option(n),
					Value = rcRecOfTab.Value(n),
					Active = rcRecOfTab.Active(n),
					Quotas_Number = rcRecOfTab.Quotas_Number(n)
          where
          Rollover_Quota_Id = rcRecOfTab.Rollover_Quota_Id(n)
;
    end if;
  END;

	PROCEDURE updProduct_Type_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuProduct_Type_Id$ in LD_rollover_quota.Product_Type_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Product_Type_Id = inuProduct_Type_Id$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Product_Type_Id:= inuProduct_Type_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCategory_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuCategory_Id$ in LD_rollover_quota.Category_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Category_Id = inuCategory_Id$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Category_Id:= inuCategory_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubcategory_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuSubcategory_Id$ in LD_rollover_quota.Subcategory_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Subcategory_Id = inuSubcategory_Id$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subcategory_Id:= inuSubcategory_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updGeograp_Location_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuGeograp_Location_Id$ in LD_rollover_quota.Geograp_Location_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Option
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		isbQuota_Option$ in LD_rollover_quota.Quota_Option%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Quota_Option = isbQuota_Option$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Option:= isbQuota_Option$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuValue$ in LD_rollover_quota.Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Value = inuValue$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value:= inuValue$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updActive
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		isbActive$ in LD_rollover_quota.Active%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Active = isbActive$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Active:= isbActive$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuotas_Number
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuQuotas_Number$ in LD_rollover_quota.Quotas_Number%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_rollover_quota;
	BEGIN
		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRollover_Quota_Id,
				rcData
			);
		end if;

		update LD_rollover_quota
		set
			Quotas_Number = inuQuotas_Number$
		where
			Rollover_Quota_Id = inuRollover_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quotas_Number:= inuQuotas_Number$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetRollover_Quota_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Rollover_Quota_Id%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Rollover_Quota_Id);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Rollover_Quota_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetProduct_Type_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Product_Type_Id%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Product_Type_Id);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Product_Type_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCategory_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Category_Id%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Category_Id);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Category_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubcategory_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Subcategory_Id%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Subcategory_Id);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Subcategory_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetGeograp_Location_Id
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Geograp_Location_Id%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Geograp_Location_Id);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Geograp_Location_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetQuota_Option
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Quota_Option%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Quota_Option);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Quota_Option);
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Value%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Value);
		end if;
		Load
		(
			inuRollover_Quota_Id
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

	FUNCTION fsbGetActive
	(
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Active%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id:=inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Active);
		end if;
		Load
		(
			inuRollover_Quota_Id
		);
		return(rcData.Active);
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
		inuRollover_Quota_Id in LD_rollover_quota.Rollover_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_rollover_quota.Quotas_Number%type
	IS
		rcError styLD_rollover_quota;
	BEGIN

		rcError.Rollover_Quota_Id := inuRollover_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRollover_Quota_Id
			 )
		then
			 return(rcData.Quotas_Number);
		end if;
		Load
		(
			inuRollover_Quota_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_rollover_quota;
/
PROMPT Otorgando permisos de ejecucion a DALD_ROLLOVER_QUOTA
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_ROLLOVER_QUOTA', 'ADM_PERSON');
END;
/