CREATE OR REPLACE PACKAGE adm_person.DALD_quota_historic
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
  )
  IS
		SELECT LD_quota_historic.*,LD_quota_historic.rowid
		FROM LD_quota_historic
		WHERE
			QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_historic.*,LD_quota_historic.rowid
		FROM LD_quota_historic
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_quota_historic  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_quota_historic is table of styLD_quota_historic index by binary_integer;
	type tyrfRecords is ref cursor return styLD_quota_historic;

	/* Tipos referenciando al registro */
	type tytbQuota_Historic_Id is table of LD_quota_historic.Quota_Historic_Id%type index by binary_integer;
	type tytbAssigned_Quote is table of LD_quota_historic.Assigned_Quote%type index by binary_integer;
	type tytbRegister_Date is table of LD_quota_historic.Register_Date%type index by binary_integer;
	type tytbResult is table of LD_quota_historic.Result%type index by binary_integer;
	type tytbSubscription_Id is table of LD_quota_historic.Subscription_Id%type index by binary_integer;
	type tytbObservation is table of LD_quota_historic.Observation%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_quota_historic is record
	(

		Quota_Historic_Id   tytbQuota_Historic_Id,
		Assigned_Quote   tytbAssigned_Quote,
		Register_Date   tytbRegister_Date,
		Result   tytbResult,
		Subscription_Id   tytbSubscription_Id,
		Observation   tytbObservation,
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
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	);

	PROCEDURE getRecord
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		orcRecord out nocopy styLD_quota_historic
	);

	FUNCTION frcGetRcData
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN styLD_quota_historic;

	FUNCTION frcGetRcData
	RETURN styLD_quota_historic;

	FUNCTION frcGetRecord
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN styLD_quota_historic;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_historic
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_quota_historic in styLD_quota_historic
	);

 	  PROCEDURE insRecord
	(
		ircLD_quota_historic in styLD_quota_historic,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_quota_historic in out nocopy tytbLD_quota_historic
	);

	PROCEDURE delRecord
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_quota_historic in out nocopy tytbLD_quota_historic,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_quota_historic in styLD_quota_historic,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_quota_historic in out nocopy tytbLD_quota_historic,
		inuLock in number default 1
	);

		PROCEDURE updAssigned_Quote
		(
				inuQUOTA_HISTORIC_Id   in LD_quota_historic.QUOTA_HISTORIC_Id%type,
				inuAssigned_Quote$  in LD_quota_historic.Assigned_Quote%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRegister_Date
		(
				inuQUOTA_HISTORIC_Id   in LD_quota_historic.QUOTA_HISTORIC_Id%type,
				idtRegister_Date$  in LD_quota_historic.Register_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updResult
		(
				inuQUOTA_HISTORIC_Id   in LD_quota_historic.QUOTA_HISTORIC_Id%type,
				isbResult$  in LD_quota_historic.Result%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubscription_Id
		(
				inuQUOTA_HISTORIC_Id   in LD_quota_historic.QUOTA_HISTORIC_Id%type,
				inuSubscription_Id$  in LD_quota_historic.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updObservation
		(
				inuQUOTA_HISTORIC_Id   in LD_quota_historic.QUOTA_HISTORIC_Id%type,
				isbObservation$  in LD_quota_historic.Observation%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetQuota_Historic_Id
    	(
    	    inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_historic.Quota_Historic_Id%type;

    	FUNCTION fnuGetAssigned_Quote
    	(
    	    inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_historic.Assigned_Quote%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_quota_historic.Register_Date%type;

    	FUNCTION fsbGetResult
    	(
    	    inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_historic.Result%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_historic.Subscription_Id%type;

    	FUNCTION fsbGetObservation
    	(
    	    inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_historic.Observation%type;


	PROCEDURE LockByPk
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		orcLD_quota_historic  out styLD_quota_historic
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_quota_historic  out styLD_quota_historic
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_quota_historic;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_quota_historic
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_QUOTA_HISTORIC';
	  cnuGeEntityId constant varchar2(30) := 8666; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	IS
		SELECT LD_quota_historic.*,LD_quota_historic.rowid
		FROM LD_quota_historic
		WHERE  QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_historic.*,LD_quota_historic.rowid
		FROM LD_quota_historic
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_quota_historic is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_quota_historic;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_quota_historic default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.QUOTA_HISTORIC_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		orcLD_quota_historic  out styLD_quota_historic
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;

		Open cuLockRcByPk
		(
			inuQUOTA_HISTORIC_Id
		);

		fetch cuLockRcByPk into orcLD_quota_historic;
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
		orcLD_quota_historic  out styLD_quota_historic
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_quota_historic;
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
		itbLD_quota_historic  in out nocopy tytbLD_quota_historic
	)
	IS
	BEGIN
			rcRecOfTab.Quota_Historic_Id.delete;
			rcRecOfTab.Assigned_Quote.delete;
			rcRecOfTab.Register_Date.delete;
			rcRecOfTab.Result.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Observation.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_quota_historic  in out nocopy tytbLD_quota_historic,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_quota_historic);
		for n in itbLD_quota_historic.first .. itbLD_quota_historic.last loop
			rcRecOfTab.Quota_Historic_Id(n) := itbLD_quota_historic(n).Quota_Historic_Id;
			rcRecOfTab.Assigned_Quote(n) := itbLD_quota_historic(n).Assigned_Quote;
			rcRecOfTab.Register_Date(n) := itbLD_quota_historic(n).Register_Date;
			rcRecOfTab.Result(n) := itbLD_quota_historic(n).Result;
			rcRecOfTab.Subscription_Id(n) := itbLD_quota_historic(n).Subscription_Id;
			rcRecOfTab.Observation(n) := itbLD_quota_historic(n).Observation;
			rcRecOfTab.row_id(n) := itbLD_quota_historic(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuQUOTA_HISTORIC_Id
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
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuQUOTA_HISTORIC_Id = rcData.QUOTA_HISTORIC_Id
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
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	IS
		rcError styLD_quota_historic;
	BEGIN		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		Load
		(
			inuQUOTA_HISTORIC_Id
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
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		orcRecord out nocopy styLD_quota_historic
	)
	IS
		rcError styLD_quota_historic;
	BEGIN		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN styLD_quota_historic
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type
	)
	RETURN styLD_quota_historic
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_quota_historic
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_historic
	)
	IS
		rfLD_quota_historic tyrfLD_quota_historic;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_quota_historic.*,
		            LD_quota_historic.rowid
                FROM LD_quota_historic';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_quota_historic for sbFullQuery;
		fetch rfLD_quota_historic bulk collect INTO otbResult;
		close rfLD_quota_historic;
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
		            LD_quota_historic.*,
		            LD_quota_historic.rowid
                FROM LD_quota_historic';
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
		ircLD_quota_historic in styLD_quota_historic
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_quota_historic,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_quota_historic in styLD_quota_historic,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_quota_historic.QUOTA_HISTORIC_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|QUOTA_HISTORIC_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_quota_historic
		(
			Quota_Historic_Id,
			Assigned_Quote,
			Register_Date,
			Result,
			Subscription_Id,
			Observation
		)
		values
		(
			ircLD_quota_historic.Quota_Historic_Id,
			ircLD_quota_historic.Assigned_Quote,
			ircLD_quota_historic.Register_Date,
			ircLD_quota_historic.Result,
			ircLD_quota_historic.Subscription_Id,
			ircLD_quota_historic.Observation
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_quota_historic));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_quota_historic in out nocopy tytbLD_quota_historic
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_quota_historic, blUseRowID);
		forall n in iotbLD_quota_historic.first..iotbLD_quota_historic.last
			insert into LD_quota_historic
			(
			Quota_Historic_Id,
			Assigned_Quote,
			Register_Date,
			Result,
			Subscription_Id,
			Observation
		)
		values
		(
			rcRecOfTab.Quota_Historic_Id(n),
			rcRecOfTab.Assigned_Quote(n),
			rcRecOfTab.Register_Date(n),
			rcRecOfTab.Result(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Observation(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_HISTORIC_Id,
				rcData
			);
		end if;

		delete
		from LD_quota_historic
		where
       		QUOTA_HISTORIC_Id=inuQUOTA_HISTORIC_Id;
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
		rcError  styLD_quota_historic;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_quota_historic
		where
			rowid = iriRowID
		returning
   QUOTA_HISTORIC_Id
		into
			rcError.QUOTA_HISTORIC_Id;

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
		iotbLD_quota_historic in out nocopy tytbLD_quota_historic,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_quota_historic;
	BEGIN
		FillRecordOfTables(iotbLD_quota_historic, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last
				delete
				from LD_quota_historic
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last loop
					LockByPk
					(
							rcRecOfTab.QUOTA_HISTORIC_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last
				delete
				from LD_quota_historic
				where
		         	QUOTA_HISTORIC_Id = rcRecOfTab.QUOTA_HISTORIC_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_quota_historic in styLD_quota_historic,
		inuLock	  in number default 0
	)
	IS
		nuQUOTA_HISTORIC_Id LD_quota_historic.QUOTA_HISTORIC_Id%type;

	BEGIN
		if ircLD_quota_historic.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_quota_historic.rowid,rcData);
			end if;
			update LD_quota_historic
			set

        Assigned_Quote = ircLD_quota_historic.Assigned_Quote,
        Register_Date = ircLD_quota_historic.Register_Date,
        Result = ircLD_quota_historic.Result,
        Subscription_Id = ircLD_quota_historic.Subscription_Id,
        Observation = ircLD_quota_historic.Observation
			where
				rowid = ircLD_quota_historic.rowid
			returning
    QUOTA_HISTORIC_Id
			into
				nuQUOTA_HISTORIC_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_quota_historic.QUOTA_HISTORIC_Id,
					rcData
				);
			end if;

			update LD_quota_historic
			set
        Assigned_Quote = ircLD_quota_historic.Assigned_Quote,
        Register_Date = ircLD_quota_historic.Register_Date,
        Result = ircLD_quota_historic.Result,
        Subscription_Id = ircLD_quota_historic.Subscription_Id,
        Observation = ircLD_quota_historic.Observation
			where
	         	QUOTA_HISTORIC_Id = ircLD_quota_historic.QUOTA_HISTORIC_Id
			returning
    QUOTA_HISTORIC_Id
			into
				nuQUOTA_HISTORIC_Id;
		end if;

		if
			nuQUOTA_HISTORIC_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_quota_historic));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_quota_historic in out nocopy tytbLD_quota_historic,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_quota_historic;
  BEGIN
    FillRecordOfTables(iotbLD_quota_historic,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last
        update LD_quota_historic
        set

            Assigned_Quote = rcRecOfTab.Assigned_Quote(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Result = rcRecOfTab.Result(n),
            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Observation = rcRecOfTab.Observation(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last loop
          LockByPk
          (
              rcRecOfTab.QUOTA_HISTORIC_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_historic.first .. iotbLD_quota_historic.last
        update LD_quota_historic
        set
					Assigned_Quote = rcRecOfTab.Assigned_Quote(n),
					Register_Date = rcRecOfTab.Register_Date(n),
					Result = rcRecOfTab.Result(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Observation = rcRecOfTab.Observation(n)
          where
          QUOTA_HISTORIC_Id = rcRecOfTab.QUOTA_HISTORIC_Id(n)
;
    end if;
  END;

	PROCEDURE updAssigned_Quote
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuAssigned_Quote$ in LD_quota_historic.Assigned_Quote%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_HISTORIC_Id,
				rcData
			);
		end if;

		update LD_quota_historic
		set
			Assigned_Quote = inuAssigned_Quote$
		where
			QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Assigned_Quote:= inuAssigned_Quote$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		idtRegister_Date$ in LD_quota_historic.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_HISTORIC_Id,
				rcData
			);
		end if;

		update LD_quota_historic
		set
			Register_Date = idtRegister_Date$
		where
			QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updResult
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		isbResult$ in LD_quota_historic.Result%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_HISTORIC_Id,
				rcData
			);
		end if;

		update LD_quota_historic
		set
			Result = isbResult$
		where
			QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Result:= isbResult$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubscription_Id
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuSubscription_Id$ in LD_quota_historic.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_HISTORIC_Id,
				rcData
			);
		end if;

		update LD_quota_historic
		set
			Subscription_Id = inuSubscription_Id$
		where
			QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updObservation
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		isbObservation$ in LD_quota_historic.Observation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_historic;
	BEGIN
		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQUOTA_HISTORIC_Id,
				rcData
			);
		end if;

		update LD_quota_historic
		set
			Observation = isbObservation$
		where
			QUOTA_HISTORIC_Id = inuQUOTA_HISTORIC_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Observation:= isbObservation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetQuota_Historic_Id
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_historic.Quota_Historic_Id%type
	IS
		rcError styLD_quota_historic;
	BEGIN

		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData.Quota_Historic_Id);
		end if;
		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		return(rcData.Quota_Historic_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetAssigned_Quote
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_historic.Assigned_Quote%type
	IS
		rcError styLD_quota_historic;
	BEGIN

		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData.Assigned_Quote);
		end if;
		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		return(rcData.Assigned_Quote);
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
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_historic.Register_Date%type
	IS
		rcError styLD_quota_historic;
	BEGIN

		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuQUOTA_HISTORIC_Id
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

	FUNCTION fsbGetResult
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_historic.Result%type
	IS
		rcError styLD_quota_historic;
	BEGIN

		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData.Result);
		end if;
		Load
		(
			inuQUOTA_HISTORIC_Id
		);
		return(rcData.Result);
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
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_historic.Subscription_Id%type
	IS
		rcError styLD_quota_historic;
	BEGIN

		rcError.QUOTA_HISTORIC_Id := inuQUOTA_HISTORIC_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuQUOTA_HISTORIC_Id
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

	FUNCTION fsbGetObservation
	(
		inuQUOTA_HISTORIC_Id in LD_quota_historic.QUOTA_HISTORIC_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_historic.Observation%type
	IS
		rcError styLD_quota_historic;
	BEGIN

		rcError.QUOTA_HISTORIC_Id:=inuQUOTA_HISTORIC_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQUOTA_HISTORIC_Id
			 )
		then
			 return(rcData.Observation);
		end if;
		Load
		(
			inuQUOTA_HISTORIC_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_quota_historic;
/

PROMPT Otorgando permisos de ejecucion a DALD_QUOTA_HISTORIC
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_QUOTA_HISTORIC', 'ADM_PERSON');
END;
/