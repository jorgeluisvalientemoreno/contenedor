CREATE OR REPLACE PACKAGE adm_person.dald_manual_quota
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
  )
  IS
		SELECT LD_manual_quota.*,LD_manual_quota.rowid
		FROM LD_manual_quota
		WHERE
			Manual_Quota_Id = inuManual_Quota_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_manual_quota.*,LD_manual_quota.rowid
		FROM LD_manual_quota
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_manual_quota  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_manual_quota is table of styLD_manual_quota index by binary_integer;
	type tyrfRecords is ref cursor return styLD_manual_quota;

	/* Tipos referenciando al registro */
	type tytbManual_Quota_Id is table of LD_manual_quota.Manual_Quota_Id%type index by binary_integer;
	type tytbSubscription_Id is table of LD_manual_quota.Subscription_Id%type index by binary_integer;
	type tytbQuota_Value is table of LD_manual_quota.Quota_Value%type index by binary_integer;
	type tytbInitial_Date is table of LD_manual_quota.Initial_Date%type index by binary_integer;
	type tytbFinal_Date is table of LD_manual_quota.Final_Date%type index by binary_integer;
	type tytbObservation is table of LD_manual_quota.Observation%type index by binary_integer;
	type tytbPrint_In_Bill is table of LD_manual_quota.Print_In_Bill%type index by binary_integer;
	type tytbSupport_File is table of LD_manual_quota.Support_File%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_manual_quota is record
	(

		Manual_Quota_Id   tytbManual_Quota_Id,
		Subscription_Id   tytbSubscription_Id,
		Quota_Value   tytbQuota_Value,
		Initial_Date   tytbInitial_Date,
		Final_Date   tytbFinal_Date,
		Observation   tytbObservation,
		Print_In_Bill   tytbPrint_In_Bill,
		Support_File   tytbSupport_File,
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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	);

	PROCEDURE getRecord
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		orcRecord out nocopy styLD_manual_quota
	);

	FUNCTION frcGetRcData
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN styLD_manual_quota;

	FUNCTION frcGetRcData
	RETURN styLD_manual_quota;

	FUNCTION frcGetRecord
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN styLD_manual_quota;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_manual_quota
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_manual_quota in styLD_manual_quota
	);

 	  PROCEDURE insRecord
	(
		ircLD_manual_quota in styLD_manual_quota,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_manual_quota in out nocopy tytbLD_manual_quota
	);

	PROCEDURE delRecord
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_manual_quota in out nocopy tytbLD_manual_quota,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_manual_quota in styLD_manual_quota,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_manual_quota in out nocopy tytbLD_manual_quota,
		inuLock in number default 1
	);

		PROCEDURE updSubscription_Id
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				inuSubscription_Id$  in LD_manual_quota.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Value
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				inuQuota_Value$  in LD_manual_quota.Quota_Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInitial_Date
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				idtInitial_Date$  in LD_manual_quota.Initial_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinal_Date
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				idtFinal_Date$  in LD_manual_quota.Final_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updObservation
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				isbObservation$  in LD_manual_quota.Observation%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrint_In_Bill
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				isbPrint_In_Bill$  in LD_manual_quota.Print_In_Bill%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupport_File
		(
				inuManual_Quota_Id   in LD_manual_quota.Manual_Quota_Id%type,
				iblSupport_File$  in LD_manual_quota.Support_File%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetManual_Quota_Id
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Manual_Quota_Id%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Subscription_Id%type;

    	FUNCTION fnuGetQuota_Value
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Quota_Value%type;

    	FUNCTION fdtGetInitial_Date
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Initial_Date%type;

    	FUNCTION fdtGetFinal_Date
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Final_Date%type;

    	FUNCTION fsbGetObservation
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Observation%type;

    	FUNCTION fsbGetPrint_In_Bill
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Print_In_Bill%type;

    	FUNCTION fblGetSupport_File
    	(
    	    inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_manual_quota.Support_File%type;


	PROCEDURE LockByPk
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		orcLD_manual_quota  out styLD_manual_quota
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_manual_quota  out styLD_manual_quota
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_manual_quota;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_manual_quota
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_MANUAL_QUOTA';
	  cnuGeEntityId constant varchar2(30) := 7235; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	IS
		SELECT LD_manual_quota.*,LD_manual_quota.rowid
		FROM LD_manual_quota
		WHERE  Manual_Quota_Id = inuManual_Quota_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_manual_quota.*,LD_manual_quota.rowid
		FROM LD_manual_quota
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_manual_quota is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_manual_quota;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_manual_quota default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Manual_Quota_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		orcLD_manual_quota  out styLD_manual_quota
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;

		Open cuLockRcByPk
		(
			inuManual_Quota_Id
		);

		fetch cuLockRcByPk into orcLD_manual_quota;
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
		orcLD_manual_quota  out styLD_manual_quota
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_manual_quota;
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
		itbLD_manual_quota  in out nocopy tytbLD_manual_quota
	)
	IS
	BEGIN
			rcRecOfTab.Manual_Quota_Id.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Quota_Value.delete;
			rcRecOfTab.Initial_Date.delete;
			rcRecOfTab.Final_Date.delete;
			rcRecOfTab.Observation.delete;
			rcRecOfTab.Print_In_Bill.delete;
			rcRecOfTab.Support_File.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_manual_quota  in out nocopy tytbLD_manual_quota,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_manual_quota);
		for n in itbLD_manual_quota.first .. itbLD_manual_quota.last loop
			rcRecOfTab.Manual_Quota_Id(n) := itbLD_manual_quota(n).Manual_Quota_Id;
			rcRecOfTab.Subscription_Id(n) := itbLD_manual_quota(n).Subscription_Id;
			rcRecOfTab.Quota_Value(n) := itbLD_manual_quota(n).Quota_Value;
			rcRecOfTab.Initial_Date(n) := itbLD_manual_quota(n).Initial_Date;
			rcRecOfTab.Final_Date(n) := itbLD_manual_quota(n).Final_Date;
			rcRecOfTab.Observation(n) := itbLD_manual_quota(n).Observation;
			rcRecOfTab.Print_In_Bill(n) := itbLD_manual_quota(n).Print_In_Bill;
			rcRecOfTab.Support_File(n) := itbLD_manual_quota(n).Support_File;
			rcRecOfTab.row_id(n) := itbLD_manual_quota(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuManual_Quota_Id
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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuManual_Quota_Id = rcData.Manual_Quota_Id
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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuManual_Quota_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	IS
		rcError styLD_manual_quota;
	BEGIN		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		Load
		(
			inuManual_Quota_Id
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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuManual_Quota_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		orcRecord out nocopy styLD_manual_quota
	)
	IS
		rcError styLD_manual_quota;
	BEGIN		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		Load
		(
			inuManual_Quota_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN styLD_manual_quota
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		Load
		(
			inuManual_Quota_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type
	)
	RETURN styLD_manual_quota
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id:=inuManual_Quota_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuManual_Quota_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_manual_quota
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_manual_quota
	)
	IS
		rfLD_manual_quota tyrfLD_manual_quota;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_manual_quota.Manual_Quota_Id,
		            LD_manual_quota.Subscription_Id,
		            LD_manual_quota.Quota_Value,
		            LD_manual_quota.Initial_Date,
		            LD_manual_quota.Final_Date,
		            LD_manual_quota.Observation,
		            LD_manual_quota.Print_In_Bill,
		            LD_manual_quota.Support_File,
		            LD_manual_quota.rowid
                FROM LD_manual_quota';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_manual_quota for sbFullQuery;
		fetch rfLD_manual_quota bulk collect INTO otbResult;
		close rfLD_manual_quota;
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
		            LD_manual_quota.Manual_Quota_Id,
		            LD_manual_quota.Subscription_Id,
		            LD_manual_quota.Quota_Value,
		            LD_manual_quota.Initial_Date,
		            LD_manual_quota.Final_Date,
		            LD_manual_quota.Observation,
		            LD_manual_quota.Print_In_Bill,
		            LD_manual_quota.Support_File,
		            LD_manual_quota.rowid
                FROM LD_manual_quota';
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
		ircLD_manual_quota in styLD_manual_quota
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_manual_quota,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_manual_quota in styLD_manual_quota,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_manual_quota.Manual_Quota_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Manual_Quota_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_manual_quota
		(
			Manual_Quota_Id,
			Subscription_Id,
			Quota_Value,
			Initial_Date,
			Final_Date,
			Observation,
			Print_In_Bill,
			Support_File
		)
		values
		(
			ircLD_manual_quota.Manual_Quota_Id,
			ircLD_manual_quota.Subscription_Id,
			ircLD_manual_quota.Quota_Value,
			ircLD_manual_quota.Initial_Date,
			ircLD_manual_quota.Final_Date,
			ircLD_manual_quota.Observation,
			ircLD_manual_quota.Print_In_Bill,
			ircLD_manual_quota.Support_File
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_manual_quota));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_manual_quota in out nocopy tytbLD_manual_quota
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_manual_quota, blUseRowID);
		forall n in iotbLD_manual_quota.first..iotbLD_manual_quota.last
			insert into LD_manual_quota
			(
			Manual_Quota_Id,
			Subscription_Id,
			Quota_Value,
			Initial_Date,
			Final_Date,
			Observation,
			Print_In_Bill,
			Support_File
		)
		values
		(
			rcRecOfTab.Manual_Quota_Id(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Quota_Value(n),
			rcRecOfTab.Initial_Date(n),
			rcRecOfTab.Final_Date(n),
			rcRecOfTab.Observation(n),
			rcRecOfTab.Print_In_Bill(n),
			rcRecOfTab.Support_File(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		delete
		from LD_manual_quota
		where
       		Manual_Quota_Id=inuManual_Quota_Id;
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
		rcError  styLD_manual_quota;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_manual_quota
		where
			rowid = iriRowID
		returning
   Manual_Quota_Id
		into
			rcError.Manual_Quota_Id;

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
		iotbLD_manual_quota in out nocopy tytbLD_manual_quota,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_manual_quota;
	BEGIN
		FillRecordOfTables(iotbLD_manual_quota, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last
				delete
				from LD_manual_quota
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last loop
					LockByPk
					(
							rcRecOfTab.Manual_Quota_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last
				delete
				from LD_manual_quota
				where
		         	Manual_Quota_Id = rcRecOfTab.Manual_Quota_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_manual_quota in styLD_manual_quota,
		inuLock	  in number default 0
	)
	IS
		nuManual_Quota_Id LD_manual_quota.Manual_Quota_Id%type;

	BEGIN
		if ircLD_manual_quota.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_manual_quota.rowid,rcData);
			end if;
			update LD_manual_quota
			set

        Subscription_Id = ircLD_manual_quota.Subscription_Id,
        Quota_Value = ircLD_manual_quota.Quota_Value,
        Initial_Date = ircLD_manual_quota.Initial_Date,
        Final_Date = ircLD_manual_quota.Final_Date,
        Observation = ircLD_manual_quota.Observation,
        Print_In_Bill = ircLD_manual_quota.Print_In_Bill,
        Support_File = ircLD_manual_quota.Support_File
			where
				rowid = ircLD_manual_quota.rowid
			returning
    Manual_Quota_Id
			into
				nuManual_Quota_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_manual_quota.Manual_Quota_Id,
					rcData
				);
			end if;

			update LD_manual_quota
			set
        Subscription_Id = ircLD_manual_quota.Subscription_Id,
        Quota_Value = ircLD_manual_quota.Quota_Value,
        Initial_Date = ircLD_manual_quota.Initial_Date,
        Final_Date = ircLD_manual_quota.Final_Date,
        Observation = ircLD_manual_quota.Observation,
        Print_In_Bill = ircLD_manual_quota.Print_In_Bill,
        Support_File = ircLD_manual_quota.Support_File
			where
	         	Manual_Quota_Id = ircLD_manual_quota.Manual_Quota_Id
			returning
    Manual_Quota_Id
			into
				nuManual_Quota_Id;
		end if;

		if
			nuManual_Quota_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_manual_quota));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_manual_quota in out nocopy tytbLD_manual_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_manual_quota;
  BEGIN
    FillRecordOfTables(iotbLD_manual_quota,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last
        update LD_manual_quota
        set

            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Quota_Value = rcRecOfTab.Quota_Value(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Observation = rcRecOfTab.Observation(n),
            Print_In_Bill = rcRecOfTab.Print_In_Bill(n),
            Support_File = rcRecOfTab.Support_File(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last loop
          LockByPk
          (
              rcRecOfTab.Manual_Quota_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_manual_quota.first .. iotbLD_manual_quota.last
        update LD_manual_quota
        set
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Quota_Value = rcRecOfTab.Quota_Value(n),
					Initial_Date = rcRecOfTab.Initial_Date(n),
					Final_Date = rcRecOfTab.Final_Date(n),
					Observation = rcRecOfTab.Observation(n),
					Print_In_Bill = rcRecOfTab.Print_In_Bill(n),
					Support_File = rcRecOfTab.Support_File(n)
          where
          Manual_Quota_Id = rcRecOfTab.Manual_Quota_Id(n)
;
    end if;
  END;

	PROCEDURE updSubscription_Id
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuSubscription_Id$ in LD_manual_quota.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Subscription_Id = inuSubscription_Id$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Value
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuQuota_Value$ in LD_manual_quota.Quota_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Quota_Value = inuQuota_Value$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Value:= inuQuota_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInitial_Date
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		idtInitial_Date$ in LD_manual_quota.Initial_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Initial_Date = idtInitial_Date$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		idtFinal_Date$ in LD_manual_quota.Final_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Final_Date = idtFinal_Date$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Final_Date:= idtFinal_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updObservation
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		isbObservation$ in LD_manual_quota.Observation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Observation = isbObservation$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Observation:= isbObservation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPrint_In_Bill
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		isbPrint_In_Bill$ in LD_manual_quota.Print_In_Bill%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Print_In_Bill = isbPrint_In_Bill$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Print_In_Bill:= isbPrint_In_Bill$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupport_File
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		iblSupport_File$ in LD_manual_quota.Support_File%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_manual_quota;
	BEGIN
		rcError.Manual_Quota_Id := inuManual_Quota_Id;
		if inuLock=1 then
			LockByPk
			(
				inuManual_Quota_Id,
				rcData
			);
		end if;

		update LD_manual_quota
		set
			Support_File = iblSupport_File$
		where
			Manual_Quota_Id = inuManual_Quota_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Support_File:= iblSupport_File$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetManual_Quota_Id
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Manual_Quota_Id%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id := inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuManual_Quota_Id
			 )
		then
			 return(rcData.Manual_Quota_Id);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData.Manual_Quota_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubscription_Id
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Subscription_Id%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id := inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuManual_Quota_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData.Subscription_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Value
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Quota_Value%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id := inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuManual_Quota_Id
			 )
		then
			 return(rcData.Quota_Value);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData.Quota_Value);
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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Initial_Date%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuManual_Quota_Id
			 )
		then
			 return(rcData.Initial_Date);
		end if;
		Load
		(
		 		inuManual_Quota_Id
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
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Final_Date%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuManual_Quota_Id
			 )
		then
			 return(rcData.Final_Date);
		end if;
		Load
		(
		 		inuManual_Quota_Id
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

	FUNCTION fsbGetObservation
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Observation%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuManual_Quota_Id
			 )
		then
			 return(rcData.Observation);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData.Observation);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetPrint_In_Bill
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Print_In_Bill%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuManual_Quota_Id
			 )
		then
			 return(rcData.Print_In_Bill);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData.Print_In_Bill);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fblGetSupport_File
	(
		inuManual_Quota_Id in LD_manual_quota.Manual_Quota_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_manual_quota.Support_File%type
	IS
		rcError styLD_manual_quota;
	BEGIN

		rcError.Manual_Quota_Id:=inuManual_Quota_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuManual_Quota_Id
			 )
		then
			 return(rcData.Support_File);
		end if;
		Load
		(
			inuManual_Quota_Id
		);
		return(rcData.Support_File);
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
end DALD_manual_quota;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_MANUAL_QUOTA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_MANUAL_QUOTA', 'ADM_PERSON'); 
END;
/ 