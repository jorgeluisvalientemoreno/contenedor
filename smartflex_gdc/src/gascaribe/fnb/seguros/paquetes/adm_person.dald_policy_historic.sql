CREATE OR REPLACE PACKAGE adm_person.dald_policy_historic
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
  )
  IS
		SELECT LD_policy_historic.*,LD_policy_historic.rowid
		FROM LD_policy_historic
		WHERE
			Policy_Historic_Id = inuPolicy_Historic_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_policy_historic.*,LD_policy_historic.rowid
		FROM LD_policy_historic
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_policy_historic  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_policy_historic is table of styLD_policy_historic index by binary_integer;
	type tyrfRecords is ref cursor return styLD_policy_historic;

	/* Tipos referenciando al registro */
	type tytbPolicy_Historic_Id is table of LD_policy_historic.Policy_Historic_Id%type index by binary_integer;
	type tytbQuota_Historic_Id is table of LD_policy_historic.Quota_Historic_Id%type index by binary_integer;
	type tytbQuota_Assign_Policy_Id is table of LD_policy_historic.Quota_Assign_Policy_Id%type index by binary_integer;
	type tytbResult is table of LD_policy_historic.Result%type index by binary_integer;
	type tytbObservation is table of LD_policy_historic.Observation%type index by binary_integer;
	type tytbBreach_Date is table of LD_policy_historic.Breach_Date%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_policy_historic is record
	(

		Policy_Historic_Id   tytbPolicy_Historic_Id,
		Quota_Historic_Id   tytbQuota_Historic_Id,
		Quota_Assign_Policy_Id   tytbQuota_Assign_Policy_Id,
		Result   tytbResult,
		Observation   tytbObservation,
		Breach_Date   tytbBreach_Date,
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
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	);

	PROCEDURE getRecord
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		orcRecord out nocopy styLD_policy_historic
	);

	FUNCTION frcGetRcData
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN styLD_policy_historic;

	FUNCTION frcGetRcData
	RETURN styLD_policy_historic;

	FUNCTION frcGetRecord
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN styLD_policy_historic;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_policy_historic
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_policy_historic in styLD_policy_historic
	);

 	  PROCEDURE insRecord
	(
		ircLD_policy_historic in styLD_policy_historic,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_policy_historic in out nocopy tytbLD_policy_historic
	);

	PROCEDURE delRecord
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_policy_historic in out nocopy tytbLD_policy_historic,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_policy_historic in styLD_policy_historic,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_policy_historic in out nocopy tytbLD_policy_historic,
		inuLock in number default 1
	);

		PROCEDURE updQuota_Historic_Id
		(
				inuPolicy_Historic_Id   in LD_policy_historic.Policy_Historic_Id%type,
				inuQuota_Historic_Id$  in LD_policy_historic.Quota_Historic_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Assign_Policy_Id
		(
				inuPolicy_Historic_Id   in LD_policy_historic.Policy_Historic_Id%type,
				inuQuota_Assign_Policy_Id$  in LD_policy_historic.Quota_Assign_Policy_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updResult
		(
				inuPolicy_Historic_Id   in LD_policy_historic.Policy_Historic_Id%type,
				isbResult$  in LD_policy_historic.Result%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updObservation
		(
				inuPolicy_Historic_Id   in LD_policy_historic.Policy_Historic_Id%type,
				isbObservation$  in LD_policy_historic.Observation%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updBreach_Date
		(
				inuPolicy_Historic_Id   in LD_policy_historic.Policy_Historic_Id%type,
				idtBreach_Date$  in LD_policy_historic.Breach_Date%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPolicy_Historic_Id
    	(
    	    inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_historic.Policy_Historic_Id%type;

    	FUNCTION fnuGetQuota_Historic_Id
    	(
    	    inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_historic.Quota_Historic_Id%type;

    	FUNCTION fnuGetQuota_Assign_Policy_Id
    	(
    	    inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_historic.Quota_Assign_Policy_Id%type;

    	FUNCTION fsbGetResult
    	(
    	    inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_historic.Result%type;

    	FUNCTION fsbGetObservation
    	(
    	    inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_historic.Observation%type;

    	FUNCTION fdtGetBreach_Date
    	(
    	    inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_policy_historic.Breach_Date%type;


	PROCEDURE LockByPk
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		orcLD_policy_historic  out styLD_policy_historic
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_policy_historic  out styLD_policy_historic
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_policy_historic;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_policy_historic
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_POLICY_HISTORIC';
	  cnuGeEntityId constant varchar2(30) := 7683; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	IS
		SELECT LD_policy_historic.*,LD_policy_historic.rowid
		FROM LD_policy_historic
		WHERE  Policy_Historic_Id = inuPolicy_Historic_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_policy_historic.*,LD_policy_historic.rowid
		FROM LD_policy_historic
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_policy_historic is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_policy_historic;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_policy_historic default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Policy_Historic_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		orcLD_policy_historic  out styLD_policy_historic
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;

		Open cuLockRcByPk
		(
			inuPolicy_Historic_Id
		);

		fetch cuLockRcByPk into orcLD_policy_historic;
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
		orcLD_policy_historic  out styLD_policy_historic
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_policy_historic;
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
		itbLD_policy_historic  in out nocopy tytbLD_policy_historic
	)
	IS
	BEGIN
			rcRecOfTab.Policy_Historic_Id.delete;
			rcRecOfTab.Quota_Historic_Id.delete;
			rcRecOfTab.Quota_Assign_Policy_Id.delete;
			rcRecOfTab.Result.delete;
			rcRecOfTab.Observation.delete;
			rcRecOfTab.Breach_Date.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_policy_historic  in out nocopy tytbLD_policy_historic,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_policy_historic);
		for n in itbLD_policy_historic.first .. itbLD_policy_historic.last loop
			rcRecOfTab.Policy_Historic_Id(n) := itbLD_policy_historic(n).Policy_Historic_Id;
			rcRecOfTab.Quota_Historic_Id(n) := itbLD_policy_historic(n).Quota_Historic_Id;
			rcRecOfTab.Quota_Assign_Policy_Id(n) := itbLD_policy_historic(n).Quota_Assign_Policy_Id;
			rcRecOfTab.Result(n) := itbLD_policy_historic(n).Result;
			rcRecOfTab.Observation(n) := itbLD_policy_historic(n).Observation;
			rcRecOfTab.Breach_Date(n) := itbLD_policy_historic(n).Breach_Date;
			rcRecOfTab.row_id(n) := itbLD_policy_historic(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPolicy_Historic_Id
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
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPolicy_Historic_Id = rcData.Policy_Historic_Id
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
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPolicy_Historic_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	IS
		rcError styLD_policy_historic;
	BEGIN		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		Load
		(
			inuPolicy_Historic_Id
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
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPolicy_Historic_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		orcRecord out nocopy styLD_policy_historic
	)
	IS
		rcError styLD_policy_historic;
	BEGIN		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		Load
		(
			inuPolicy_Historic_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN styLD_policy_historic
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		Load
		(
			inuPolicy_Historic_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type
	)
	RETURN styLD_policy_historic
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPolicy_Historic_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPolicy_Historic_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_policy_historic
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_policy_historic
	)
	IS
		rfLD_policy_historic tyrfLD_policy_historic;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_policy_historic.*,
		            LD_policy_historic.rowid
                FROM LD_policy_historic';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_policy_historic for sbFullQuery;
		fetch rfLD_policy_historic bulk collect INTO otbResult;
		close rfLD_policy_historic;
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
		            LD_policy_historic.*,
		            LD_policy_historic.rowid
                FROM LD_policy_historic';
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
		ircLD_policy_historic in styLD_policy_historic
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_policy_historic,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_policy_historic in styLD_policy_historic,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_policy_historic.Policy_Historic_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Policy_Historic_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_policy_historic
		(
			Policy_Historic_Id,
			Quota_Historic_Id,
			Quota_Assign_Policy_Id,
			Result,
			Observation,
			Breach_Date
		)
		values
		(
			ircLD_policy_historic.Policy_Historic_Id,
			ircLD_policy_historic.Quota_Historic_Id,
			ircLD_policy_historic.Quota_Assign_Policy_Id,
			ircLD_policy_historic.Result,
			ircLD_policy_historic.Observation,
			ircLD_policy_historic.Breach_Date
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_policy_historic));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_policy_historic in out nocopy tytbLD_policy_historic
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_policy_historic, blUseRowID);
		forall n in iotbLD_policy_historic.first..iotbLD_policy_historic.last
			insert into LD_policy_historic
			(
			Policy_Historic_Id,
			Quota_Historic_Id,
			Quota_Assign_Policy_Id,
			Result,
			Observation,
			Breach_Date
		)
		values
		(
			rcRecOfTab.Policy_Historic_Id(n),
			rcRecOfTab.Quota_Historic_Id(n),
			rcRecOfTab.Quota_Assign_Policy_Id(n),
			rcRecOfTab.Result(n),
			rcRecOfTab.Observation(n),
			rcRecOfTab.Breach_Date(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Historic_Id,
				rcData
			);
		end if;

		delete
		from LD_policy_historic
		where
       		Policy_Historic_Id=inuPolicy_Historic_Id;
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
		rcError  styLD_policy_historic;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_policy_historic
		where
			rowid = iriRowID
		returning
   Policy_Historic_Id
		into
			rcError.Policy_Historic_Id;

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
		iotbLD_policy_historic in out nocopy tytbLD_policy_historic,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_policy_historic;
	BEGIN
		FillRecordOfTables(iotbLD_policy_historic, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last
				delete
				from LD_policy_historic
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last loop
					LockByPk
					(
							rcRecOfTab.Policy_Historic_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last
				delete
				from LD_policy_historic
				where
		         	Policy_Historic_Id = rcRecOfTab.Policy_Historic_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_policy_historic in styLD_policy_historic,
		inuLock	  in number default 0
	)
	IS
		nuPolicy_Historic_Id LD_policy_historic.Policy_Historic_Id%type;

	BEGIN
		if ircLD_policy_historic.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_policy_historic.rowid,rcData);
			end if;
			update LD_policy_historic
			set

        Quota_Historic_Id = ircLD_policy_historic.Quota_Historic_Id,
        Quota_Assign_Policy_Id = ircLD_policy_historic.Quota_Assign_Policy_Id,
        Result = ircLD_policy_historic.Result,
        Observation = ircLD_policy_historic.Observation,
        Breach_Date = ircLD_policy_historic.Breach_Date
			where
				rowid = ircLD_policy_historic.rowid
			returning
    Policy_Historic_Id
			into
				nuPolicy_Historic_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_policy_historic.Policy_Historic_Id,
					rcData
				);
			end if;

			update LD_policy_historic
			set
        Quota_Historic_Id = ircLD_policy_historic.Quota_Historic_Id,
        Quota_Assign_Policy_Id = ircLD_policy_historic.Quota_Assign_Policy_Id,
        Result = ircLD_policy_historic.Result,
        Observation = ircLD_policy_historic.Observation,
        Breach_Date = ircLD_policy_historic.Breach_Date
			where
	         	Policy_Historic_Id = ircLD_policy_historic.Policy_Historic_Id
			returning
    Policy_Historic_Id
			into
				nuPolicy_Historic_Id;
		end if;

		if
			nuPolicy_Historic_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_policy_historic));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_policy_historic in out nocopy tytbLD_policy_historic,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_policy_historic;
  BEGIN
    FillRecordOfTables(iotbLD_policy_historic,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last
        update LD_policy_historic
        set

            Quota_Historic_Id = rcRecOfTab.Quota_Historic_Id(n),
            Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n),
            Result = rcRecOfTab.Result(n),
            Observation = rcRecOfTab.Observation(n),
            Breach_Date = rcRecOfTab.Breach_Date(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last loop
          LockByPk
          (
              rcRecOfTab.Policy_Historic_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_policy_historic.first .. iotbLD_policy_historic.last
        update LD_policy_historic
        set
					Quota_Historic_Id = rcRecOfTab.Quota_Historic_Id(n),
					Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n),
					Result = rcRecOfTab.Result(n),
					Observation = rcRecOfTab.Observation(n),
					Breach_Date = rcRecOfTab.Breach_Date(n)
          where
          Policy_Historic_Id = rcRecOfTab.Policy_Historic_Id(n)
;
    end if;
  END;

	PROCEDURE updQuota_Historic_Id
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuQuota_Historic_Id$ in LD_policy_historic.Quota_Historic_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Historic_Id,
				rcData
			);
		end if;

		update LD_policy_historic
		set
			Quota_Historic_Id = inuQuota_Historic_Id$
		where
			Policy_Historic_Id = inuPolicy_Historic_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Historic_Id:= inuQuota_Historic_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Assign_Policy_Id
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuQuota_Assign_Policy_Id$ in LD_policy_historic.Quota_Assign_Policy_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Historic_Id,
				rcData
			);
		end if;

		update LD_policy_historic
		set
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id$
		where
			Policy_Historic_Id = inuPolicy_Historic_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Assign_Policy_Id:= inuQuota_Assign_Policy_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updResult
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		isbResult$ in LD_policy_historic.Result%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Historic_Id,
				rcData
			);
		end if;

		update LD_policy_historic
		set
			Result = isbResult$
		where
			Policy_Historic_Id = inuPolicy_Historic_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Result:= isbResult$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updObservation
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		isbObservation$ in LD_policy_historic.Observation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Historic_Id,
				rcData
			);
		end if;

		update LD_policy_historic
		set
			Observation = isbObservation$
		where
			Policy_Historic_Id = inuPolicy_Historic_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Observation:= isbObservation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBreach_Date
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		idtBreach_Date$ in LD_policy_historic.Breach_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_historic;
	BEGIN
		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Historic_Id,
				rcData
			);
		end if;

		update LD_policy_historic
		set
			Breach_Date = idtBreach_Date$
		where
			Policy_Historic_Id = inuPolicy_Historic_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Breach_Date:= idtBreach_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPolicy_Historic_Id
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_historic.Policy_Historic_Id%type
	IS
		rcError styLD_policy_historic;
	BEGIN

		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Historic_Id
			 )
		then
			 return(rcData.Policy_Historic_Id);
		end if;
		Load
		(
			inuPolicy_Historic_Id
		);
		return(rcData.Policy_Historic_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Historic_Id
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_historic.Quota_Historic_Id%type
	IS
		rcError styLD_policy_historic;
	BEGIN

		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Historic_Id
			 )
		then
			 return(rcData.Quota_Historic_Id);
		end if;
		Load
		(
			inuPolicy_Historic_Id
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

	FUNCTION fnuGetQuota_Assign_Policy_Id
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_historic.Quota_Assign_Policy_Id%type
	IS
		rcError styLD_policy_historic;
	BEGIN

		rcError.Policy_Historic_Id := inuPolicy_Historic_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Historic_Id
			 )
		then
			 return(rcData.Quota_Assign_Policy_Id);
		end if;
		Load
		(
			inuPolicy_Historic_Id
		);
		return(rcData.Quota_Assign_Policy_Id);
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
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_historic.Result%type
	IS
		rcError styLD_policy_historic;
	BEGIN

		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Historic_Id
			 )
		then
			 return(rcData.Result);
		end if;
		Load
		(
			inuPolicy_Historic_Id
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

	FUNCTION fsbGetObservation
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_historic.Observation%type
	IS
		rcError styLD_policy_historic;
	BEGIN

		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Historic_Id
			 )
		then
			 return(rcData.Observation);
		end if;
		Load
		(
			inuPolicy_Historic_Id
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

	FUNCTION fdtGetBreach_Date
	(
		inuPolicy_Historic_Id in LD_policy_historic.Policy_Historic_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_historic.Breach_Date%type
	IS
		rcError styLD_policy_historic;
	BEGIN

		rcError.Policy_Historic_Id:=inuPolicy_Historic_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPolicy_Historic_Id
			 )
		then
			 return(rcData.Breach_Date);
		end if;
		Load
		(
		 		inuPolicy_Historic_Id
		);
		return(rcData.Breach_Date);
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
end DALD_policy_historic;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_POLICY_HISTORIC
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_POLICY_HISTORIC', 'ADM_PERSON'); 
END;
/  
