CREATE OR REPLACE PACKAGE adm_person.dald_quota_assign_policy
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
  )
  IS
		SELECT LD_quota_assign_policy.*,LD_quota_assign_policy.rowid
		FROM LD_quota_assign_policy
		WHERE
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_assign_policy.*,LD_quota_assign_policy.rowid
		FROM LD_quota_assign_policy
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_quota_assign_policy  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_quota_assign_policy is table of styLD_quota_assign_policy index by binary_integer;
	type tyrfRecords is ref cursor return styLD_quota_assign_policy;

	/* Tipos referenciando al registro */
	type tytbQuota_Assign_Policy_Id is table of LD_quota_assign_policy.Quota_Assign_Policy_Id%type index by binary_integer;
	type tytbDescription is table of LD_quota_assign_policy.Description%type index by binary_integer;
	type tytbAssign_Rule_Id is table of LD_quota_assign_policy.Assign_Rule_Id%type index by binary_integer;
	type tytbObservation is table of LD_quota_assign_policy.Observation%type index by binary_integer;
	type tytbSimulation is table of LD_quota_assign_policy.Simulation%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_quota_assign_policy is record
	(

		Quota_Assign_Policy_Id   tytbQuota_Assign_Policy_Id,
		Description   tytbDescription,
		Assign_Rule_Id   tytbAssign_Rule_Id,
		Observation   tytbObservation,
		Simulation   tytbSimulation,
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
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	);

	PROCEDURE getRecord
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		orcRecord out nocopy styLD_quota_assign_policy
	);

	FUNCTION frcGetRcData
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN styLD_quota_assign_policy;

	FUNCTION frcGetRcData
	RETURN styLD_quota_assign_policy;

	FUNCTION frcGetRecord
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN styLD_quota_assign_policy;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_assign_policy
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_quota_assign_policy in styLD_quota_assign_policy
	);

 	  PROCEDURE insRecord
	(
		ircLD_quota_assign_policy in styLD_quota_assign_policy,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_quota_assign_policy in out nocopy tytbLD_quota_assign_policy
	);

	PROCEDURE delRecord
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_quota_assign_policy in out nocopy tytbLD_quota_assign_policy,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_quota_assign_policy in styLD_quota_assign_policy,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_quota_assign_policy in out nocopy tytbLD_quota_assign_policy,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuQuota_Assign_Policy_Id   in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
				isbDescription$  in LD_quota_assign_policy.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updAssign_Rule_Id
		(
				inuQuota_Assign_Policy_Id   in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
				inuAssign_Rule_Id$  in LD_quota_assign_policy.Assign_Rule_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updObservation
		(
				inuQuota_Assign_Policy_Id   in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
				isbObservation$  in LD_quota_assign_policy.Observation%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSimulation
		(
				inuQuota_Assign_Policy_Id   in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
				isbSimulation$  in LD_quota_assign_policy.Simulation%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetQuota_Assign_Policy_Id
    	(
    	    inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_assign_policy.Quota_Assign_Policy_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_assign_policy.Description%type;

    	FUNCTION fnuGetAssign_Rule_Id
    	(
    	    inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_assign_policy.Assign_Rule_Id%type;

    	FUNCTION fsbGetObservation
    	(
    	    inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_assign_policy.Observation%type;

    	FUNCTION fsbGetSimulation
    	(
    	    inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_assign_policy.Simulation%type;


	PROCEDURE LockByPk
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		orcLD_quota_assign_policy  out styLD_quota_assign_policy
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_quota_assign_policy  out styLD_quota_assign_policy
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_quota_assign_policy;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_quota_assign_policy
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_QUOTA_ASSIGN_POLICY';
	  cnuGeEntityId constant varchar2(30) := 8468; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	IS
		SELECT LD_quota_assign_policy.*,LD_quota_assign_policy.rowid
		FROM LD_quota_assign_policy
		WHERE  Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_assign_policy.*,LD_quota_assign_policy.rowid
		FROM LD_quota_assign_policy
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_quota_assign_policy is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_quota_assign_policy;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_quota_assign_policy default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Quota_Assign_Policy_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		orcLD_quota_assign_policy  out styLD_quota_assign_policy
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;

		Open cuLockRcByPk
		(
			inuQuota_Assign_Policy_Id
		);

		fetch cuLockRcByPk into orcLD_quota_assign_policy;
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
		orcLD_quota_assign_policy  out styLD_quota_assign_policy
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_quota_assign_policy;
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
		itbLD_quota_assign_policy  in out nocopy tytbLD_quota_assign_policy
	)
	IS
	BEGIN
			rcRecOfTab.Quota_Assign_Policy_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Assign_Rule_Id.delete;
			rcRecOfTab.Observation.delete;
			rcRecOfTab.Simulation.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_quota_assign_policy  in out nocopy tytbLD_quota_assign_policy,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_quota_assign_policy);
		for n in itbLD_quota_assign_policy.first .. itbLD_quota_assign_policy.last loop
			rcRecOfTab.Quota_Assign_Policy_Id(n) := itbLD_quota_assign_policy(n).Quota_Assign_Policy_Id;
			rcRecOfTab.Description(n) := itbLD_quota_assign_policy(n).Description;
			rcRecOfTab.Assign_Rule_Id(n) := itbLD_quota_assign_policy(n).Assign_Rule_Id;
			rcRecOfTab.Observation(n) := itbLD_quota_assign_policy(n).Observation;
			rcRecOfTab.Simulation(n) := itbLD_quota_assign_policy(n).Simulation;
			rcRecOfTab.row_id(n) := itbLD_quota_assign_policy(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuQuota_Assign_Policy_Id
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
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuQuota_Assign_Policy_Id = rcData.Quota_Assign_Policy_Id
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
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuQuota_Assign_Policy_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		Load
		(
			inuQuota_Assign_Policy_Id
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
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuQuota_Assign_Policy_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		orcRecord out nocopy styLD_quota_assign_policy
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		Load
		(
			inuQuota_Assign_Policy_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN styLD_quota_assign_policy
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		Load
		(
			inuQuota_Assign_Policy_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	)
	RETURN styLD_quota_assign_policy
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQuota_Assign_Policy_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuQuota_Assign_Policy_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_quota_assign_policy
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_assign_policy
	)
	IS
		rfLD_quota_assign_policy tyrfLD_quota_assign_policy;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_quota_assign_policy.Quota_Assign_Policy_Id,
		            LD_quota_assign_policy.Description,
		            LD_quota_assign_policy.Assign_Rule_Id,
		            LD_quota_assign_policy.Observation,
		            LD_quota_assign_policy.Simulation,
		            LD_quota_assign_policy.rowid
                FROM LD_quota_assign_policy';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_quota_assign_policy for sbFullQuery;
		fetch rfLD_quota_assign_policy bulk collect INTO otbResult;
		close rfLD_quota_assign_policy;
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
		            LD_quota_assign_policy.Quota_Assign_Policy_Id,
		            LD_quota_assign_policy.Description,
		            LD_quota_assign_policy.Assign_Rule_Id,
		            LD_quota_assign_policy.Observation,
		            LD_quota_assign_policy.Simulation,
		            LD_quota_assign_policy.rowid
                FROM LD_quota_assign_policy';
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
		ircLD_quota_assign_policy in styLD_quota_assign_policy
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_quota_assign_policy,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_quota_assign_policy in styLD_quota_assign_policy,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_quota_assign_policy.Quota_Assign_Policy_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Quota_Assign_Policy_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_quota_assign_policy
		(
			Quota_Assign_Policy_Id,
			Description,
			Assign_Rule_Id,
			Observation,
			Simulation
		)
		values
		(
			ircLD_quota_assign_policy.Quota_Assign_Policy_Id,
			ircLD_quota_assign_policy.Description,
			ircLD_quota_assign_policy.Assign_Rule_Id,
			ircLD_quota_assign_policy.Observation,
			ircLD_quota_assign_policy.Simulation
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_quota_assign_policy));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_quota_assign_policy in out nocopy tytbLD_quota_assign_policy
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_quota_assign_policy, blUseRowID);
		forall n in iotbLD_quota_assign_policy.first..iotbLD_quota_assign_policy.last
			insert into LD_quota_assign_policy
			(
			Quota_Assign_Policy_Id,
			Description,
			Assign_Rule_Id,
			Observation,
			Simulation
		)
		values
		(
			rcRecOfTab.Quota_Assign_Policy_Id(n),
			rcRecOfTab.Description(n),
			rcRecOfTab.Assign_Rule_Id(n),
			rcRecOfTab.Observation(n),
			rcRecOfTab.Simulation(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		if inuLock=1 then
			LockByPk
			(
				inuQuota_Assign_Policy_Id,
				rcData
			);
		end if;

		delete
		from LD_quota_assign_policy
		where
       		Quota_Assign_Policy_Id=inuQuota_Assign_Policy_Id;
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
		rcError  styLD_quota_assign_policy;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_quota_assign_policy
		where
			rowid = iriRowID
		returning
   Quota_Assign_Policy_Id
		into
			rcError.Quota_Assign_Policy_Id;

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
		iotbLD_quota_assign_policy in out nocopy tytbLD_quota_assign_policy,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_quota_assign_policy;
	BEGIN
		FillRecordOfTables(iotbLD_quota_assign_policy, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last
				delete
				from LD_quota_assign_policy
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last loop
					LockByPk
					(
							rcRecOfTab.Quota_Assign_Policy_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last
				delete
				from LD_quota_assign_policy
				where
		         	Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_quota_assign_policy in styLD_quota_assign_policy,
		inuLock	  in number default 0
	)
	IS
		nuQuota_Assign_Policy_Id LD_quota_assign_policy.Quota_Assign_Policy_Id%type;

	BEGIN
		if ircLD_quota_assign_policy.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_quota_assign_policy.rowid,rcData);
			end if;
			update LD_quota_assign_policy
			set

        Description = ircLD_quota_assign_policy.Description,
        Assign_Rule_Id = ircLD_quota_assign_policy.Assign_Rule_Id,
        Observation = ircLD_quota_assign_policy.Observation,
        Simulation = ircLD_quota_assign_policy.Simulation
			where
				rowid = ircLD_quota_assign_policy.rowid
			returning
    Quota_Assign_Policy_Id
			into
				nuQuota_Assign_Policy_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_quota_assign_policy.Quota_Assign_Policy_Id,
					rcData
				);
			end if;

			update LD_quota_assign_policy
			set
        Description = ircLD_quota_assign_policy.Description,
        Assign_Rule_Id = ircLD_quota_assign_policy.Assign_Rule_Id,
        Observation = ircLD_quota_assign_policy.Observation,
        Simulation = ircLD_quota_assign_policy.Simulation
			where
	         	Quota_Assign_Policy_Id = ircLD_quota_assign_policy.Quota_Assign_Policy_Id
			returning
    Quota_Assign_Policy_Id
			into
				nuQuota_Assign_Policy_Id;
		end if;

		if
			nuQuota_Assign_Policy_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_quota_assign_policy));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_quota_assign_policy in out nocopy tytbLD_quota_assign_policy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_quota_assign_policy;
  BEGIN
    FillRecordOfTables(iotbLD_quota_assign_policy,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last
        update LD_quota_assign_policy
        set

            Description = rcRecOfTab.Description(n),
            Assign_Rule_Id = rcRecOfTab.Assign_Rule_Id(n),
            Observation = rcRecOfTab.Observation(n),
            Simulation = rcRecOfTab.Simulation(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last loop
          LockByPk
          (
              rcRecOfTab.Quota_Assign_Policy_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_assign_policy.first .. iotbLD_quota_assign_policy.last
        update LD_quota_assign_policy
        set
					Description = rcRecOfTab.Description(n),
					Assign_Rule_Id = rcRecOfTab.Assign_Rule_Id(n),
					Observation = rcRecOfTab.Observation(n),
					Simulation = rcRecOfTab.Simulation(n)
          where
          Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		isbDescription$ in LD_quota_assign_policy.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Assign_Policy_Id,
				rcData
			);
		end if;

		update LD_quota_assign_policy
		set
			Description = isbDescription$
		where
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updAssign_Rule_Id
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuAssign_Rule_Id$ in LD_quota_assign_policy.Assign_Rule_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Assign_Policy_Id,
				rcData
			);
		end if;

		update LD_quota_assign_policy
		set
			Assign_Rule_Id = inuAssign_Rule_Id$
		where
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Assign_Rule_Id:= inuAssign_Rule_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updObservation
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		isbObservation$ in LD_quota_assign_policy.Observation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Assign_Policy_Id,
				rcData
			);
		end if;

		update LD_quota_assign_policy
		set
			Observation = isbObservation$
		where
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Observation:= isbObservation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSimulation
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		isbSimulation$ in LD_quota_assign_policy.Simulation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_assign_policy;
	BEGIN
		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Assign_Policy_Id,
				rcData
			);
		end if;

		update LD_quota_assign_policy
		set
			Simulation = isbSimulation$
		where
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Simulation:= isbSimulation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetQuota_Assign_Policy_Id
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_assign_policy.Quota_Assign_Policy_Id%type
	IS
		rcError styLD_quota_assign_policy;
	BEGIN

		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Assign_Policy_Id
			 )
		then
			 return(rcData.Quota_Assign_Policy_Id);
		end if;
		Load
		(
			inuQuota_Assign_Policy_Id
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

	FUNCTION fsbGetDescription
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_assign_policy.Description%type
	IS
		rcError styLD_quota_assign_policy;
	BEGIN

		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Assign_Policy_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuQuota_Assign_Policy_Id
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

	FUNCTION fnuGetAssign_Rule_Id
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_assign_policy.Assign_Rule_Id%type
	IS
		rcError styLD_quota_assign_policy;
	BEGIN

		rcError.Quota_Assign_Policy_Id := inuQuota_Assign_Policy_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Assign_Policy_Id
			 )
		then
			 return(rcData.Assign_Rule_Id);
		end if;
		Load
		(
			inuQuota_Assign_Policy_Id
		);
		return(rcData.Assign_Rule_Id);
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
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_assign_policy.Observation%type
	IS
		rcError styLD_quota_assign_policy;
	BEGIN

		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Assign_Policy_Id
			 )
		then
			 return(rcData.Observation);
		end if;
		Load
		(
			inuQuota_Assign_Policy_Id
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

	FUNCTION fsbGetSimulation
	(
		inuQuota_Assign_Policy_Id in LD_quota_assign_policy.Quota_Assign_Policy_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_assign_policy.Simulation%type
	IS
		rcError styLD_quota_assign_policy;
	BEGIN

		rcError.Quota_Assign_Policy_Id:=inuQuota_Assign_Policy_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Assign_Policy_Id
			 )
		then
			 return(rcData.Simulation);
		end if;
		Load
		(
			inuQuota_Assign_Policy_Id
		);
		return(rcData.Simulation);
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
end DALD_quota_assign_policy;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_QUOTA_ASSIGN_POLICY
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_QUOTA_ASSIGN_POLICY', 'ADM_PERSON'); 
END;
/ 
