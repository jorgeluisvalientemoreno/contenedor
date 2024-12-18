CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_simulated_quota
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
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
  )
  IS
		SELECT LD_simulated_quota.*,LD_simulated_quota.rowid
		FROM LD_simulated_quota
		WHERE
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_simulated_quota.*,LD_simulated_quota.rowid
		FROM LD_simulated_quota
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_simulated_quota  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_simulated_quota is table of styLD_simulated_quota index by binary_integer;
	type tyrfRecords is ref cursor return styLD_simulated_quota;

	/* Tipos referenciando al registro */
	type tytbSimulated_Quota_Id is table of LD_simulated_quota.Simulated_Quota_Id%type index by binary_integer;
	type tytbSubscription is table of LD_simulated_quota.Subscription%type index by binary_integer;
	type tytbDepartment is table of LD_simulated_quota.Department%type index by binary_integer;
	type tytbLocation is table of LD_simulated_quota.Location%type index by binary_integer;
	type tytbBarrio is table of LD_simulated_quota.Barrio%type index by binary_integer;
	type tytbType_Housing is table of LD_simulated_quota.Type_Housing%type index by binary_integer;
	type tytbCategory is table of LD_simulated_quota.Category%type index by binary_integer;
	type tytbSubcategory is table of LD_simulated_quota.Subcategory%type index by binary_integer;
	type tytbCurrent_Quota is table of LD_simulated_quota.Current_Quota%type index by binary_integer;
	type tytbQuota_Assigned is table of LD_simulated_quota.Quota_Assigned%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_simulated_quota is record
	(

		Simulated_Quota_Id   tytbSimulated_Quota_Id,
		Subscription   tytbSubscription,
		Department   tytbDepartment,
		Location   tytbLocation,
		Barrio   tytbBarrio,
		Type_Housing   tytbType_Housing,
		Category   tytbCategory,
		Subcategory   tytbSubcategory,
		Current_Quota   tytbCurrent_Quota,
		Quota_Assigned   tytbQuota_Assigned,
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
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	);

	PROCEDURE getRecord
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		orcRecord out nocopy styLD_simulated_quota
	);

	FUNCTION frcGetRcData
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN styLD_simulated_quota;

	FUNCTION frcGetRcData
	RETURN styLD_simulated_quota;

	FUNCTION frcGetRecord
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN styLD_simulated_quota;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_simulated_quota
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_simulated_quota in styLD_simulated_quota
	);

 	  PROCEDURE insRecord
	(
		ircLD_simulated_quota in styLD_simulated_quota,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_simulated_quota in out nocopy tytbLD_simulated_quota
	);

	PROCEDURE delRecord
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_simulated_quota in out nocopy tytbLD_simulated_quota,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_simulated_quota in styLD_simulated_quota,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_simulated_quota in out nocopy tytbLD_simulated_quota,
		inuLock in number default 1
	);

		PROCEDURE updSubscription
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbSubscription$  in LD_simulated_quota.Subscription%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDepartment
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbDepartment$  in LD_simulated_quota.Department%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLocation
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbLocation$  in LD_simulated_quota.Location%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updBarrio
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbBarrio$  in LD_simulated_quota.Barrio%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updType_Housing
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbType_Housing$  in LD_simulated_quota.Type_Housing%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCategory
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbCategory$  in LD_simulated_quota.Category%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubcategory
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				isbSubcategory$  in LD_simulated_quota.Subcategory%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCurrent_Quota
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				inuCurrent_Quota$  in LD_simulated_quota.Current_Quota%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Assigned
		(
				inuSIMULATED_QUOTA_Id   in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
				inuQuota_Assigned$  in LD_simulated_quota.Quota_Assigned%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetSimulated_Quota_Id
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Simulated_Quota_Id%type;

    	FUNCTION fsbGetSubscription
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Subscription%type;

    	FUNCTION fsbGetDepartment
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Department%type;

    	FUNCTION fsbGetLocation
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Location%type;

    	FUNCTION fsbGetBarrio
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Barrio%type;

    	FUNCTION fsbGetType_Housing
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Type_Housing%type;

    	FUNCTION fsbGetCategory
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Category%type;

    	FUNCTION fsbGetSubcategory
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Subcategory%type;

    	FUNCTION fnuGetCurrent_Quota
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Current_Quota%type;

    	FUNCTION fnuGetQuota_Assigned
    	(
    	    inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_simulated_quota.Quota_Assigned%type;


	PROCEDURE LockByPk
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		orcLD_simulated_quota  out styLD_simulated_quota
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_simulated_quota  out styLD_simulated_quota
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_simulated_quota;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_simulated_quota
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SIMULATED_QUOTA';
	  cnuGeEntityId constant varchar2(30) := 8220; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	IS
		SELECT LD_simulated_quota.*,LD_simulated_quota.rowid
		FROM LD_simulated_quota
		WHERE  SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_simulated_quota.*,LD_simulated_quota.rowid
		FROM LD_simulated_quota
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_simulated_quota is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_simulated_quota;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_simulated_quota default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SIMULATED_QUOTA_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		orcLD_simulated_quota  out styLD_simulated_quota
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;

		Open cuLockRcByPk
		(
			inuSIMULATED_QUOTA_Id
		);

		fetch cuLockRcByPk into orcLD_simulated_quota;
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
		orcLD_simulated_quota  out styLD_simulated_quota
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_simulated_quota;
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
		itbLD_simulated_quota  in out nocopy tytbLD_simulated_quota
	)
	IS
	BEGIN
			rcRecOfTab.Simulated_Quota_Id.delete;
			rcRecOfTab.Subscription.delete;
			rcRecOfTab.Department.delete;
			rcRecOfTab.Location.delete;
			rcRecOfTab.Barrio.delete;
			rcRecOfTab.Type_Housing.delete;
			rcRecOfTab.Category.delete;
			rcRecOfTab.Subcategory.delete;
			rcRecOfTab.Current_Quota.delete;
			rcRecOfTab.Quota_Assigned.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_simulated_quota  in out nocopy tytbLD_simulated_quota,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_simulated_quota);
		for n in itbLD_simulated_quota.first .. itbLD_simulated_quota.last loop
			rcRecOfTab.Simulated_Quota_Id(n) := itbLD_simulated_quota(n).Simulated_Quota_Id;
			rcRecOfTab.Subscription(n) := itbLD_simulated_quota(n).Subscription;
			rcRecOfTab.Department(n) := itbLD_simulated_quota(n).Department;
			rcRecOfTab.Location(n) := itbLD_simulated_quota(n).Location;
			rcRecOfTab.Barrio(n) := itbLD_simulated_quota(n).Barrio;
			rcRecOfTab.Type_Housing(n) := itbLD_simulated_quota(n).Type_Housing;
			rcRecOfTab.Category(n) := itbLD_simulated_quota(n).Category;
			rcRecOfTab.Subcategory(n) := itbLD_simulated_quota(n).Subcategory;
			rcRecOfTab.Current_Quota(n) := itbLD_simulated_quota(n).Current_Quota;
			rcRecOfTab.Quota_Assigned(n) := itbLD_simulated_quota(n).Quota_Assigned;
			rcRecOfTab.row_id(n) := itbLD_simulated_quota(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSIMULATED_QUOTA_Id
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
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSIMULATED_QUOTA_Id = rcData.SIMULATED_QUOTA_Id
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
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		Load
		(
			inuSIMULATED_QUOTA_Id
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
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		orcRecord out nocopy styLD_simulated_quota
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN styLD_simulated_quota
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type
	)
	RETURN styLD_simulated_quota
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_simulated_quota
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_simulated_quota
	)
	IS
		rfLD_simulated_quota tyrfLD_simulated_quota;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_simulated_quota.Simulated_Quota_Id,
		            LD_simulated_quota.Subscription,
		            LD_simulated_quota.Department,
		            LD_simulated_quota.Location,
		            LD_simulated_quota.Barrio,
		            LD_simulated_quota.Type_Housing,
		            LD_simulated_quota.Category,
		            LD_simulated_quota.Subcategory,
		            LD_simulated_quota.Current_Quota,
		            LD_simulated_quota.Quota_Assigned,
		            LD_simulated_quota.rowid
                FROM LD_simulated_quota';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_simulated_quota for sbFullQuery;
		fetch rfLD_simulated_quota bulk collect INTO otbResult;
		close rfLD_simulated_quota;
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
		            LD_simulated_quota.Simulated_Quota_Id,
		            LD_simulated_quota.Subscription,
		            LD_simulated_quota.Department,
		            LD_simulated_quota.Location,
		            LD_simulated_quota.Barrio,
		            LD_simulated_quota.Type_Housing,
		            LD_simulated_quota.Category,
		            LD_simulated_quota.Subcategory,
		            LD_simulated_quota.Current_Quota,
		            LD_simulated_quota.Quota_Assigned,
		            LD_simulated_quota.rowid
                FROM LD_simulated_quota';
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
		ircLD_simulated_quota in styLD_simulated_quota
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_simulated_quota,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_simulated_quota in styLD_simulated_quota,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_simulated_quota.SIMULATED_QUOTA_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SIMULATED_QUOTA_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_simulated_quota
		(
			Simulated_Quota_Id,
			Subscription,
			Department,
			Location,
			Barrio,
			Type_Housing,
			Category,
			Subcategory,
			Current_Quota,
			Quota_Assigned
		)
		values
		(
			ircLD_simulated_quota.Simulated_Quota_Id,
			ircLD_simulated_quota.Subscription,
			ircLD_simulated_quota.Department,
			ircLD_simulated_quota.Location,
			ircLD_simulated_quota.Barrio,
			ircLD_simulated_quota.Type_Housing,
			ircLD_simulated_quota.Category,
			ircLD_simulated_quota.Subcategory,
			ircLD_simulated_quota.Current_Quota,
			ircLD_simulated_quota.Quota_Assigned
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_simulated_quota));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_simulated_quota in out nocopy tytbLD_simulated_quota
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_simulated_quota, blUseRowID);
		forall n in iotbLD_simulated_quota.first..iotbLD_simulated_quota.last
			insert into LD_simulated_quota
			(
			Simulated_Quota_Id,
			Subscription,
			Department,
			Location,
			Barrio,
			Type_Housing,
			Category,
			Subcategory,
			Current_Quota,
			Quota_Assigned
		)
		values
		(
			rcRecOfTab.Simulated_Quota_Id(n),
			rcRecOfTab.Subscription(n),
			rcRecOfTab.Department(n),
			rcRecOfTab.Location(n),
			rcRecOfTab.Barrio(n),
			rcRecOfTab.Type_Housing(n),
			rcRecOfTab.Category(n),
			rcRecOfTab.Subcategory(n),
			rcRecOfTab.Current_Quota(n),
			rcRecOfTab.Quota_Assigned(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		delete
		from LD_simulated_quota
		where
       		SIMULATED_QUOTA_Id=inuSIMULATED_QUOTA_Id;
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
		rcError  styLD_simulated_quota;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_simulated_quota
		where
			rowid = iriRowID
		returning
   SIMULATED_QUOTA_Id
		into
			rcError.SIMULATED_QUOTA_Id;

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
		iotbLD_simulated_quota in out nocopy tytbLD_simulated_quota,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_simulated_quota;
	BEGIN
		FillRecordOfTables(iotbLD_simulated_quota, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last
				delete
				from LD_simulated_quota
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last loop
					LockByPk
					(
							rcRecOfTab.SIMULATED_QUOTA_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last
				delete
				from LD_simulated_quota
				where
		         	SIMULATED_QUOTA_Id = rcRecOfTab.SIMULATED_QUOTA_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_simulated_quota in styLD_simulated_quota,
		inuLock	  in number default 0
	)
	IS
		nuSIMULATED_QUOTA_Id LD_simulated_quota.SIMULATED_QUOTA_Id%type;

	BEGIN
		if ircLD_simulated_quota.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_simulated_quota.rowid,rcData);
			end if;
			update LD_simulated_quota
			set

        Subscription = ircLD_simulated_quota.Subscription,
        Department = ircLD_simulated_quota.Department,
        Location = ircLD_simulated_quota.Location,
        Barrio = ircLD_simulated_quota.Barrio,
        Type_Housing = ircLD_simulated_quota.Type_Housing,
        Category = ircLD_simulated_quota.Category,
        Subcategory = ircLD_simulated_quota.Subcategory,
        Current_Quota = ircLD_simulated_quota.Current_Quota,
        Quota_Assigned = ircLD_simulated_quota.Quota_Assigned
			where
				rowid = ircLD_simulated_quota.rowid
			returning
    SIMULATED_QUOTA_Id
			into
				nuSIMULATED_QUOTA_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_simulated_quota.SIMULATED_QUOTA_Id,
					rcData
				);
			end if;

			update LD_simulated_quota
			set
        Subscription = ircLD_simulated_quota.Subscription,
        Department = ircLD_simulated_quota.Department,
        Location = ircLD_simulated_quota.Location,
        Barrio = ircLD_simulated_quota.Barrio,
        Type_Housing = ircLD_simulated_quota.Type_Housing,
        Category = ircLD_simulated_quota.Category,
        Subcategory = ircLD_simulated_quota.Subcategory,
        Current_Quota = ircLD_simulated_quota.Current_Quota,
        Quota_Assigned = ircLD_simulated_quota.Quota_Assigned
			where
	         	SIMULATED_QUOTA_Id = ircLD_simulated_quota.SIMULATED_QUOTA_Id
			returning
    SIMULATED_QUOTA_Id
			into
				nuSIMULATED_QUOTA_Id;
		end if;

		if
			nuSIMULATED_QUOTA_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_simulated_quota));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_simulated_quota in out nocopy tytbLD_simulated_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_simulated_quota;
  BEGIN
    FillRecordOfTables(iotbLD_simulated_quota,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last
        update LD_simulated_quota
        set

            Subscription = rcRecOfTab.Subscription(n),
            Department = rcRecOfTab.Department(n),
            Location = rcRecOfTab.Location(n),
            Barrio = rcRecOfTab.Barrio(n),
            Type_Housing = rcRecOfTab.Type_Housing(n),
            Category = rcRecOfTab.Category(n),
            Subcategory = rcRecOfTab.Subcategory(n),
            Current_Quota = rcRecOfTab.Current_Quota(n),
            Quota_Assigned = rcRecOfTab.Quota_Assigned(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last loop
          LockByPk
          (
              rcRecOfTab.SIMULATED_QUOTA_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_simulated_quota.first .. iotbLD_simulated_quota.last
        update LD_simulated_quota
        set
					Subscription = rcRecOfTab.Subscription(n),
					Department = rcRecOfTab.Department(n),
					Location = rcRecOfTab.Location(n),
					Barrio = rcRecOfTab.Barrio(n),
					Type_Housing = rcRecOfTab.Type_Housing(n),
					Category = rcRecOfTab.Category(n),
					Subcategory = rcRecOfTab.Subcategory(n),
					Current_Quota = rcRecOfTab.Current_Quota(n),
					Quota_Assigned = rcRecOfTab.Quota_Assigned(n)
          where
          SIMULATED_QUOTA_Id = rcRecOfTab.SIMULATED_QUOTA_Id(n)
;
    end if;
  END;

	PROCEDURE updSubscription
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbSubscription$ in LD_simulated_quota.Subscription%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Subscription = isbSubscription$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription:= isbSubscription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDepartment
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbDepartment$ in LD_simulated_quota.Department%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Department = isbDepartment$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Department:= isbDepartment$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLocation
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbLocation$ in LD_simulated_quota.Location%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Location = isbLocation$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Location:= isbLocation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBarrio
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbBarrio$ in LD_simulated_quota.Barrio%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Barrio = isbBarrio$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Barrio:= isbBarrio$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updType_Housing
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbType_Housing$ in LD_simulated_quota.Type_Housing%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Type_Housing = isbType_Housing$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Type_Housing:= isbType_Housing$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCategory
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbCategory$ in LD_simulated_quota.Category%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Category = isbCategory$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Category:= isbCategory$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubcategory
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		isbSubcategory$ in LD_simulated_quota.Subcategory%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Subcategory = isbSubcategory$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subcategory:= isbSubcategory$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCurrent_Quota
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuCurrent_Quota$ in LD_simulated_quota.Current_Quota%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Current_Quota = inuCurrent_Quota$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Current_Quota:= inuCurrent_Quota$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Assigned
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuQuota_Assigned$ in LD_simulated_quota.Quota_Assigned%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_simulated_quota;
	BEGIN
		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSIMULATED_QUOTA_Id,
				rcData
			);
		end if;

		update LD_simulated_quota
		set
			Quota_Assigned = inuQuota_Assigned$
		where
			SIMULATED_QUOTA_Id = inuSIMULATED_QUOTA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Assigned:= inuQuota_Assigned$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetSimulated_Quota_Id
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Simulated_Quota_Id%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Simulated_Quota_Id);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Simulated_Quota_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetSubscription
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Subscription%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Subscription);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Subscription);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDepartment
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Department%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Department);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Department);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetLocation
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Location%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Location);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Location);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetBarrio
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Barrio%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Barrio);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Barrio);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetType_Housing
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Type_Housing%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Type_Housing);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Type_Housing);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetCategory
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Category%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Category);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Category);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetSubcategory
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Subcategory%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id:=inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Subcategory);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Subcategory);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCurrent_Quota
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Current_Quota%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Current_Quota);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Current_Quota);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Assigned
	(
		inuSIMULATED_QUOTA_Id in LD_simulated_quota.SIMULATED_QUOTA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_simulated_quota.Quota_Assigned%type
	IS
		rcError styLD_simulated_quota;
	BEGIN

		rcError.SIMULATED_QUOTA_Id := inuSIMULATED_QUOTA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSIMULATED_QUOTA_Id
			 )
		then
			 return(rcData.Quota_Assigned);
		end if;
		Load
		(
			inuSIMULATED_QUOTA_Id
		);
		return(rcData.Quota_Assigned);
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
end DALD_simulated_quota;
/
PROMPT Otorgando permisos de ejecucion a DALD_SIMULATED_QUOTA
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SIMULATED_QUOTA', 'ADM_PERSON');
END;
/