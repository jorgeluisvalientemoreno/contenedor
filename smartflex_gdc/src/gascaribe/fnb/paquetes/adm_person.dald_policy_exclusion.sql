CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_policy_exclusion
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
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
  )
  IS
		SELECT LD_policy_exclusion.*,LD_policy_exclusion.rowid
		FROM LD_policy_exclusion
		WHERE
			Policy_Exclusion_Id = inuPolicy_Exclusion_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_policy_exclusion.*,LD_policy_exclusion.rowid
		FROM LD_policy_exclusion
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_policy_exclusion  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_policy_exclusion is table of styLD_policy_exclusion index by binary_integer;
	type tyrfRecords is ref cursor return styLD_policy_exclusion;

	/* Tipos referenciando al registro */
	type tytbPolicy_Exclusion_Id is table of LD_policy_exclusion.Policy_Exclusion_Id%type index by binary_integer;
	type tytbQuota_Assign_Policy_Id is table of LD_policy_exclusion.Quota_Assign_Policy_Id%type index by binary_integer;
	type tytbSubscription_Id is table of LD_policy_exclusion.Subscription_Id%type index by binary_integer;
	type tytbEntity is table of LD_policy_exclusion.Entity%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_policy_exclusion is record
	(

		Policy_Exclusion_Id   tytbPolicy_Exclusion_Id,
		Quota_Assign_Policy_Id   tytbQuota_Assign_Policy_Id,
		Subscription_Id   tytbSubscription_Id,
		Entity   tytbEntity,
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
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	);

	PROCEDURE getRecord
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		orcRecord out nocopy styLD_policy_exclusion
	);

	FUNCTION frcGetRcData
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN styLD_policy_exclusion;

	FUNCTION frcGetRcData
	RETURN styLD_policy_exclusion;

	FUNCTION frcGetRecord
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN styLD_policy_exclusion;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_policy_exclusion
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_policy_exclusion in styLD_policy_exclusion
	);

 	  PROCEDURE insRecord
	(
		ircLD_policy_exclusion in styLD_policy_exclusion,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_policy_exclusion in out nocopy tytbLD_policy_exclusion
	);

	PROCEDURE delRecord
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_policy_exclusion in out nocopy tytbLD_policy_exclusion,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_policy_exclusion in styLD_policy_exclusion,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_policy_exclusion in out nocopy tytbLD_policy_exclusion,
		inuLock in number default 1
	);

		PROCEDURE updQuota_Assign_Policy_Id
		(
				inuPolicy_Exclusion_Id   in LD_policy_exclusion.Policy_Exclusion_Id%type,
				inuQuota_Assign_Policy_Id$  in LD_policy_exclusion.Quota_Assign_Policy_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubscription_Id
		(
				inuPolicy_Exclusion_Id   in LD_policy_exclusion.Policy_Exclusion_Id%type,
				inuSubscription_Id$  in LD_policy_exclusion.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updEntity
		(
				inuPolicy_Exclusion_Id   in LD_policy_exclusion.Policy_Exclusion_Id%type,
				isbEntity$  in LD_policy_exclusion.Entity%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPolicy_Exclusion_Id
    	(
    	    inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_exclusion.Policy_Exclusion_Id%type;

    	FUNCTION fnuGetQuota_Assign_Policy_Id
    	(
    	    inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_exclusion.Quota_Assign_Policy_Id%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_exclusion.Subscription_Id%type;

    	FUNCTION fsbGetEntity
    	(
    	    inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_exclusion.Entity%type;


	PROCEDURE LockByPk
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		orcLD_policy_exclusion  out styLD_policy_exclusion
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_policy_exclusion  out styLD_policy_exclusion
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_policy_exclusion;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_policy_exclusion
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_POLICY_EXCLUSION';
	  cnuGeEntityId constant varchar2(30) := 8650; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	IS
		SELECT LD_policy_exclusion.*,LD_policy_exclusion.rowid
		FROM LD_policy_exclusion
		WHERE  Policy_Exclusion_Id = inuPolicy_Exclusion_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_policy_exclusion.*,LD_policy_exclusion.rowid
		FROM LD_policy_exclusion
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_policy_exclusion is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_policy_exclusion;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_policy_exclusion default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Policy_Exclusion_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		orcLD_policy_exclusion  out styLD_policy_exclusion
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;

		Open cuLockRcByPk
		(
			inuPolicy_Exclusion_Id
		);

		fetch cuLockRcByPk into orcLD_policy_exclusion;
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
		orcLD_policy_exclusion  out styLD_policy_exclusion
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_policy_exclusion;
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
		itbLD_policy_exclusion  in out nocopy tytbLD_policy_exclusion
	)
	IS
	BEGIN
			rcRecOfTab.Policy_Exclusion_Id.delete;
			rcRecOfTab.Quota_Assign_Policy_Id.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Entity.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_policy_exclusion  in out nocopy tytbLD_policy_exclusion,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_policy_exclusion);
		for n in itbLD_policy_exclusion.first .. itbLD_policy_exclusion.last loop
			rcRecOfTab.Policy_Exclusion_Id(n) := itbLD_policy_exclusion(n).Policy_Exclusion_Id;
			rcRecOfTab.Quota_Assign_Policy_Id(n) := itbLD_policy_exclusion(n).Quota_Assign_Policy_Id;
			rcRecOfTab.Subscription_Id(n) := itbLD_policy_exclusion(n).Subscription_Id;
			rcRecOfTab.Entity(n) := itbLD_policy_exclusion(n).Entity;
			rcRecOfTab.row_id(n) := itbLD_policy_exclusion(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPolicy_Exclusion_Id
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
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPolicy_Exclusion_Id = rcData.Policy_Exclusion_Id
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
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPolicy_Exclusion_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN		rcError.Policy_Exclusion_Id:=inuPolicy_Exclusion_Id;

		Load
		(
			inuPolicy_Exclusion_Id
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
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPolicy_Exclusion_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		orcRecord out nocopy styLD_policy_exclusion
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN		rcError.Policy_Exclusion_Id:=inuPolicy_Exclusion_Id;

		Load
		(
			inuPolicy_Exclusion_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN styLD_policy_exclusion
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id:=inuPolicy_Exclusion_Id;

		Load
		(
			inuPolicy_Exclusion_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type
	)
	RETURN styLD_policy_exclusion
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id:=inuPolicy_Exclusion_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPolicy_Exclusion_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPolicy_Exclusion_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_policy_exclusion
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_policy_exclusion
	)
	IS
		rfLD_policy_exclusion tyrfLD_policy_exclusion;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_policy_exclusion.Policy_Exclusion_Id,
		            LD_policy_exclusion.Quota_Assign_Policy_Id,
		            LD_policy_exclusion.Subscription_Id,
		            LD_policy_exclusion.Entity,
		            LD_policy_exclusion.rowid
                FROM LD_policy_exclusion';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_policy_exclusion for sbFullQuery;
		fetch rfLD_policy_exclusion bulk collect INTO otbResult;
		close rfLD_policy_exclusion;
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
		            LD_policy_exclusion.Policy_Exclusion_Id,
		            LD_policy_exclusion.Quota_Assign_Policy_Id,
		            LD_policy_exclusion.Subscription_Id,
		            LD_policy_exclusion.Entity,
		            LD_policy_exclusion.rowid
                FROM LD_policy_exclusion';
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
		ircLD_policy_exclusion in styLD_policy_exclusion
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_policy_exclusion,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_policy_exclusion in styLD_policy_exclusion,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_policy_exclusion.Policy_Exclusion_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Policy_Exclusion_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_policy_exclusion
		(
			Policy_Exclusion_Id,
			Quota_Assign_Policy_Id,
			Subscription_Id,
			Entity
		)
		values
		(
			ircLD_policy_exclusion.Policy_Exclusion_Id,
			ircLD_policy_exclusion.Quota_Assign_Policy_Id,
			ircLD_policy_exclusion.Subscription_Id,
			ircLD_policy_exclusion.Entity
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_policy_exclusion));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_policy_exclusion in out nocopy tytbLD_policy_exclusion
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_policy_exclusion, blUseRowID);
		forall n in iotbLD_policy_exclusion.first..iotbLD_policy_exclusion.last
			insert into LD_policy_exclusion
			(
			Policy_Exclusion_Id,
			Quota_Assign_Policy_Id,
			Subscription_Id,
			Entity
		)
		values
		(
			rcRecOfTab.Policy_Exclusion_Id(n),
			rcRecOfTab.Quota_Assign_Policy_Id(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Entity(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id:=inuPolicy_Exclusion_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Exclusion_Id,
				rcData
			);
		end if;

		delete
		from LD_policy_exclusion
		where
       		Policy_Exclusion_Id=inuPolicy_Exclusion_Id;
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
		rcError  styLD_policy_exclusion;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_policy_exclusion
		where
			rowid = iriRowID
		returning
   Policy_Exclusion_Id
		into
			rcError.Policy_Exclusion_Id;

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
		iotbLD_policy_exclusion in out nocopy tytbLD_policy_exclusion,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_policy_exclusion;
	BEGIN
		FillRecordOfTables(iotbLD_policy_exclusion, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last
				delete
				from LD_policy_exclusion
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last loop
					LockByPk
					(
							rcRecOfTab.Policy_Exclusion_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last
				delete
				from LD_policy_exclusion
				where
		         	Policy_Exclusion_Id = rcRecOfTab.Policy_Exclusion_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_policy_exclusion in styLD_policy_exclusion,
		inuLock	  in number default 0
	)
	IS
		nuPolicy_Exclusion_Id LD_policy_exclusion.Policy_Exclusion_Id%type;

	BEGIN
		if ircLD_policy_exclusion.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_policy_exclusion.rowid,rcData);
			end if;
			update LD_policy_exclusion
			set

        Quota_Assign_Policy_Id = ircLD_policy_exclusion.Quota_Assign_Policy_Id,
        Subscription_Id = ircLD_policy_exclusion.Subscription_Id,
        Entity = ircLD_policy_exclusion.Entity
			where
				rowid = ircLD_policy_exclusion.rowid
			returning
    Policy_Exclusion_Id
			into
				nuPolicy_Exclusion_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_policy_exclusion.Policy_Exclusion_Id,
					rcData
				);
			end if;

			update LD_policy_exclusion
			set
        Quota_Assign_Policy_Id = ircLD_policy_exclusion.Quota_Assign_Policy_Id,
        Subscription_Id = ircLD_policy_exclusion.Subscription_Id,
        Entity = ircLD_policy_exclusion.Entity
			where
	         	Policy_Exclusion_Id = ircLD_policy_exclusion.Policy_Exclusion_Id
			returning
    Policy_Exclusion_Id
			into
				nuPolicy_Exclusion_Id;
		end if;

		if
			nuPolicy_Exclusion_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_policy_exclusion));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_policy_exclusion in out nocopy tytbLD_policy_exclusion,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_policy_exclusion;
  BEGIN
    FillRecordOfTables(iotbLD_policy_exclusion,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last
        update LD_policy_exclusion
        set

            Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n),
            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Entity = rcRecOfTab.Entity(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last loop
          LockByPk
          (
              rcRecOfTab.Policy_Exclusion_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_policy_exclusion.first .. iotbLD_policy_exclusion.last
        update LD_policy_exclusion
        set
					Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Entity = rcRecOfTab.Entity(n)
          where
          Policy_Exclusion_Id = rcRecOfTab.Policy_Exclusion_Id(n)
;
    end if;
  END;

	PROCEDURE updQuota_Assign_Policy_Id
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuQuota_Assign_Policy_Id$ in LD_policy_exclusion.Quota_Assign_Policy_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Exclusion_Id,
				rcData
			);
		end if;

		update LD_policy_exclusion
		set
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id$
		where
			Policy_Exclusion_Id = inuPolicy_Exclusion_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Assign_Policy_Id:= inuQuota_Assign_Policy_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubscription_Id
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuSubscription_Id$ in LD_policy_exclusion.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Exclusion_Id,
				rcData
			);
		end if;

		update LD_policy_exclusion
		set
			Subscription_Id = inuSubscription_Id$
		where
			Policy_Exclusion_Id = inuPolicy_Exclusion_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updEntity
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		isbEntity$ in LD_policy_exclusion.Entity%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_exclusion;
	BEGIN
		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPolicy_Exclusion_Id,
				rcData
			);
		end if;

		update LD_policy_exclusion
		set
			Entity = isbEntity$
		where
			Policy_Exclusion_Id = inuPolicy_Exclusion_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Entity:= isbEntity$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPolicy_Exclusion_Id
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_exclusion.Policy_Exclusion_Id%type
	IS
		rcError styLD_policy_exclusion;
	BEGIN

		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Exclusion_Id
			 )
		then
			 return(rcData.Policy_Exclusion_Id);
		end if;
		Load
		(
			inuPolicy_Exclusion_Id
		);
		return(rcData.Policy_Exclusion_Id);
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
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_exclusion.Quota_Assign_Policy_Id%type
	IS
		rcError styLD_policy_exclusion;
	BEGIN

		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Exclusion_Id
			 )
		then
			 return(rcData.Quota_Assign_Policy_Id);
		end if;
		Load
		(
			inuPolicy_Exclusion_Id
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

	FUNCTION fnuGetSubscription_Id
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_exclusion.Subscription_Id%type
	IS
		rcError styLD_policy_exclusion;
	BEGIN

		rcError.Policy_Exclusion_Id := inuPolicy_Exclusion_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Exclusion_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuPolicy_Exclusion_Id
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

	FUNCTION fsbGetEntity
	(
		inuPolicy_Exclusion_Id in LD_policy_exclusion.Policy_Exclusion_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_exclusion.Entity%type
	IS
		rcError styLD_policy_exclusion;
	BEGIN

		rcError.Policy_Exclusion_Id:=inuPolicy_Exclusion_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPolicy_Exclusion_Id
			 )
		then
			 return(rcData.Entity);
		end if;
		Load
		(
			inuPolicy_Exclusion_Id
		);
		return(rcData.Entity);
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
end DALD_policy_exclusion;
/
PROMPT Otorgando permisos de ejecucion a DALD_POLICY_EXCLUSION
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_POLICY_EXCLUSION', 'ADM_PERSON');
END;
/