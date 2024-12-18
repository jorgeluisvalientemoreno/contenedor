CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_sinester_claims IS
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type) IS
		SELECT LD_sinester_claims.*,LD_sinester_claims.rowid
		FROM LD_sinester_claims
		WHERE
			SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId(
		irirowid in varchar2) IS
		SELECT LD_sinester_claims.*,LD_sinester_claims.rowid
		FROM LD_sinester_claims
		WHERE rowId = irirowid;


	/* Subtipos */
	subtype styLD_sinester_claims  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_sinester_claims is table of styLD_sinester_claims index by binary_integer;
	type tyrfRecords is ref cursor return styLD_sinester_claims;

	/* Tipos referenciando al registro */
	type tytbPackage_Id is table of LD_sinester_claims.Package_Id%type index by binary_integer;
	type tytbCausal_Id is table of LD_sinester_claims.Causal_Id%type index by binary_integer;
	type tytbClaims_Date is table of LD_sinester_claims.Claims_Date%type index by binary_integer;
	type tytbSinester_Claims_Id is table of LD_sinester_claims.Sinester_Claims_Id%type index by binary_integer;
	type tytbInsured_Name is table of LD_sinester_claims.Insured_Name%type index by binary_integer;
	type tytbInsured_Id is table of LD_sinester_claims.Insured_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_sinester_claims is record(

		Package_Id   tytbPackage_Id,
		Causal_Id   tytbCausal_Id,
		Claims_Date   tytbClaims_Date,
		Sinester_Claims_Id   tytbSinester_Claims_Id,
		Insured_Name   tytbInsured_Name,
		Insured_Id   tytbInsured_Id,
		row_id tytbrowid);


	 /***** Metodos Publicos ****/
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

	FUNCTION fsbGetMessageDescription return varchar2;

	PROCEDURE ClearMemory;

   FUNCTION fblExist(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type) RETURN boolean;

	 PROCEDURE AccKey(
		 inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type);

	PROCEDURE AccKeyByRowId(
		iriRowID    in rowid);

	PROCEDURE ValDuplicate(
		 inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type);

	PROCEDURE getRecord(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		orcRecord out nocopy styLD_sinester_claims
	);

	FUNCTION frcGetRcData(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type)
	RETURN styLD_sinester_claims;

	FUNCTION frcGetRcData
	RETURN styLD_sinester_claims;

	FUNCTION frcGetRecord(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type)
	RETURN styLD_sinester_claims;

	PROCEDURE getRecords(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_sinester_claims
	);

	FUNCTION frfGetRecords(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false)
	RETURN tyRefCursor;

	PROCEDURE insRecord(
		ircLD_sinester_claims in styLD_sinester_claims
	);

 	  PROCEDURE insRecord(
		ircLD_sinester_claims in styLD_sinester_claims,
		orirowid   out varchar2);

	PROCEDURE insRecords(
		iotbLD_sinester_claims in out nocopy tytbLD_sinester_claims
	);

	PROCEDURE delRecord(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type, inuLock in number default 1);

	PROCEDURE delByRowID(
		iriRowID    in rowid,
		inuLock in number default 1);

	PROCEDURE delRecords
	(
		iotbLD_sinester_claims in out nocopy tytbLD_sinester_claims,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_sinester_claims in styLD_sinester_claims,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_sinester_claims in out nocopy tytbLD_sinester_claims,
		inuLock in number default 1
	);

		PROCEDURE updPackage_Id
		(
				inuSINESTER_CLAIMS_Id   in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
				inuPackage_Id$  in LD_sinester_claims.Package_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updCausal_Id
		(
				inuSINESTER_CLAIMS_Id   in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
				inuCausal_Id$  in LD_sinester_claims.Causal_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updClaims_Date
		(
				inuSINESTER_CLAIMS_Id   in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
				idtClaims_Date$  in LD_sinester_claims.Claims_Date%type,
				inuLock	  in number default 0);

		PROCEDURE updInsured_Name
		(
				inuSINESTER_CLAIMS_Id   in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
				isbInsured_Name$  in LD_sinester_claims.Insured_Name%type,
				inuLock	  in number default 0);

		PROCEDURE updInsured_Id
		(
				inuSINESTER_CLAIMS_Id   in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
				isbInsured_Id$  in LD_sinester_claims.Insured_Id%type,
				inuLock	  in number default 0);

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_sinester_claims.Package_Id%type;

    	FUNCTION fnuGetCausal_Id
    	(
    	    inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_sinester_claims.Causal_Id%type;

    	FUNCTION fdtGetClaims_Date
    	(
    	    inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_sinester_claims.Claims_Date%type;

    	FUNCTION fnuGetSinester_Claims_Id
    	(
    	    inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_sinester_claims.Sinester_Claims_Id%type;

    	FUNCTION fsbGetInsured_Name
    	(
    	    inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_sinester_claims.Insured_Name%type;

    	FUNCTION fsbGetInsured_Id
    	(
    	    inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_sinester_claims.Insured_Id%type;


	PROCEDURE LockByPk
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		orcLD_sinester_claims  out styLD_sinester_claims
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_sinester_claims  out styLD_sinester_claims
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_sinester_claims;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_sinester_claims
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO159764';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SINESTER_CLAIMS';
	  cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_SINESTER_CLAIMS'); -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	IS
		SELECT LD_sinester_claims.*,LD_sinester_claims.rowid
		FROM LD_sinester_claims
		WHERE  SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_sinester_claims.*,LD_sinester_claims.rowid
		FROM LD_sinester_claims
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_sinester_claims is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_sinester_claims;

	rcData cuRecord%rowtype;

   blDAO_USE_CACHE    boolean := null;

	/* Metodos privados */
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE IS
	   nuEntityId ge_entity.entity_id%TYPE;
	   BEGIN
	   SELECT ge_entity.entity_id
	   INTO   nuEntityId
	   FROM   ge_entity
	   WHERE  ge_entity.name_ = isbTName;
	   RETURN nuEntityId;
  EXCEPTION
	   WHEN ex.CONTROLLED_ERROR THEN
	        RAISE ex.CONTROLLED_ERROR;
	   WHEN OTHERS THEN
	        Errors.setError;
	        RAISE ex.CONTROLLED_ERROR;
	END;
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

	FUNCTION fsbPrimaryKey( rcI in styLD_sinester_claims default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SINESTER_CLAIMS_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		orcLD_sinester_claims  out styLD_sinester_claims
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;

		Open cuLockRcByPk
		(
			inuSINESTER_CLAIMS_Id
		);

		fetch cuLockRcByPk into orcLD_sinester_claims;
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
		orcLD_sinester_claims  out styLD_sinester_claims
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_sinester_claims;
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
		itbLD_sinester_claims  in out nocopy tytbLD_sinester_claims
	)
	IS
	BEGIN
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Causal_Id.delete;
			rcRecOfTab.Claims_Date.delete;
			rcRecOfTab.Sinester_Claims_Id.delete;
			rcRecOfTab.Insured_Name.delete;
			rcRecOfTab.Insured_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_sinester_claims  in out nocopy tytbLD_sinester_claims,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_sinester_claims);
		for n in itbLD_sinester_claims.first .. itbLD_sinester_claims.last loop
			rcRecOfTab.Package_Id(n) := itbLD_sinester_claims(n).Package_Id;
			rcRecOfTab.Causal_Id(n) := itbLD_sinester_claims(n).Causal_Id;
			rcRecOfTab.Claims_Date(n) := itbLD_sinester_claims(n).Claims_Date;
			rcRecOfTab.Sinester_Claims_Id(n) := itbLD_sinester_claims(n).Sinester_Claims_Id;
			rcRecOfTab.Insured_Name(n) := itbLD_sinester_claims(n).Insured_Name;
			rcRecOfTab.Insured_Id(n) := itbLD_sinester_claims(n).Insured_Id;
			rcRecOfTab.row_id(n) := itbLD_sinester_claims(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSINESTER_CLAIMS_Id
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
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSINESTER_CLAIMS_Id = rcData.SINESTER_CLAIMS_Id
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
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		Load
		(
			inuSINESTER_CLAIMS_Id
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
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		orcRecord out nocopy styLD_sinester_claims
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	RETURN styLD_sinester_claims
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type
	)
	RETURN styLD_sinester_claims
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_sinester_claims
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_sinester_claims
	)
	IS
		rfLD_sinester_claims tyrfLD_sinester_claims;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_sinester_claims.*,
		            LD_sinester_claims.rowid
                FROM LD_sinester_claims';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_sinester_claims for sbFullQuery;
		fetch rfLD_sinester_claims bulk collect INTO otbResult;
		close rfLD_sinester_claims;
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
		sbSQL  VARCHAR2 (32000) := 'select LD_sinester_claims.*,
		            LD_sinester_claims.rowid
                FROM LD_sinester_claims';
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
		ircLD_sinester_claims in styLD_sinester_claims
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_sinester_claims,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_sinester_claims in styLD_sinester_claims,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_sinester_claims.SINESTER_CLAIMS_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SINESTER_CLAIMS_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_sinester_claims
		(
			Package_Id,
			Causal_Id,
			Claims_Date,
			Sinester_Claims_Id,
			Insured_Name,
			Insured_Id
		)
		values
		(
			ircLD_sinester_claims.Package_Id,
			ircLD_sinester_claims.Causal_Id,
			ircLD_sinester_claims.Claims_Date,
			ircLD_sinester_claims.Sinester_Claims_Id,
			ircLD_sinester_claims.Insured_Name,
			ircLD_sinester_claims.Insured_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_sinester_claims));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_sinester_claims in out nocopy tytbLD_sinester_claims
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_sinester_claims, blUseRowID);
		forall n in iotbLD_sinester_claims.first..iotbLD_sinester_claims.last
			insert into LD_sinester_claims
			(
			Package_Id,
			Causal_Id,
			Claims_Date,
			Sinester_Claims_Id,
			Insured_Name,
			Insured_Id
		)
		values
		(
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Causal_Id(n),
			rcRecOfTab.Claims_Date(n),
			rcRecOfTab.Sinester_Claims_Id(n),
			rcRecOfTab.Insured_Name(n),
			rcRecOfTab.Insured_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		if inuLock=1 then
			LockByPk
			(
				inuSINESTER_CLAIMS_Id,
				rcData
			);
		end if;

		delete
		from LD_sinester_claims
		where
       		SINESTER_CLAIMS_Id=inuSINESTER_CLAIMS_Id;
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
		rcError  styLD_sinester_claims;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_sinester_claims
		where
			rowid = iriRowID
		returning
   SINESTER_CLAIMS_Id
		into
			rcError.SINESTER_CLAIMS_Id;

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
		iotbLD_sinester_claims in out nocopy tytbLD_sinester_claims,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_sinester_claims;
	BEGIN
		FillRecordOfTables(iotbLD_sinester_claims, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last
				delete
				from LD_sinester_claims
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last loop
					LockByPk
					(
							rcRecOfTab.SINESTER_CLAIMS_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last
				delete
				from LD_sinester_claims
				where
		         	SINESTER_CLAIMS_Id = rcRecOfTab.SINESTER_CLAIMS_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_sinester_claims in styLD_sinester_claims,
		inuLock	  in number default 0
	)
	IS
		nuSINESTER_CLAIMS_Id LD_sinester_claims.SINESTER_CLAIMS_Id%type;

	BEGIN
		if ircLD_sinester_claims.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_sinester_claims.rowid,rcData);
			end if;
			update LD_sinester_claims
			set

        Package_Id = ircLD_sinester_claims.Package_Id,
        Causal_Id = ircLD_sinester_claims.Causal_Id,
        Claims_Date = ircLD_sinester_claims.Claims_Date,
        Insured_Name = ircLD_sinester_claims.Insured_Name,
        Insured_Id = ircLD_sinester_claims.Insured_Id
			where
				rowid = ircLD_sinester_claims.rowid
			returning
    SINESTER_CLAIMS_Id
			into
				nuSINESTER_CLAIMS_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_sinester_claims.SINESTER_CLAIMS_Id,
					rcData
				);
			end if;

			update LD_sinester_claims
			set
        Package_Id = ircLD_sinester_claims.Package_Id,
        Causal_Id = ircLD_sinester_claims.Causal_Id,
        Claims_Date = ircLD_sinester_claims.Claims_Date,
        Insured_Name = ircLD_sinester_claims.Insured_Name,
        Insured_Id = ircLD_sinester_claims.Insured_Id
			where
	         	SINESTER_CLAIMS_Id = ircLD_sinester_claims.SINESTER_CLAIMS_Id
			returning
    SINESTER_CLAIMS_Id
			into
				nuSINESTER_CLAIMS_Id;
		end if;

		if
			nuSINESTER_CLAIMS_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_sinester_claims));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_sinester_claims in out nocopy tytbLD_sinester_claims,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sinester_claims;
  BEGIN
    FillRecordOfTables(iotbLD_sinester_claims,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last
        update LD_sinester_claims
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Causal_Id = rcRecOfTab.Causal_Id(n),
            Claims_Date = rcRecOfTab.Claims_Date(n),
            Insured_Name = rcRecOfTab.Insured_Name(n),
            Insured_Id = rcRecOfTab.Insured_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last loop
          LockByPk
          (
              rcRecOfTab.SINESTER_CLAIMS_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sinester_claims.first .. iotbLD_sinester_claims.last
        update LD_sinester_claims
        set
					Package_Id = rcRecOfTab.Package_Id(n),
					Causal_Id = rcRecOfTab.Causal_Id(n),
					Claims_Date = rcRecOfTab.Claims_Date(n),
					Insured_Name = rcRecOfTab.Insured_Name(n),
					Insured_Id = rcRecOfTab.Insured_Id(n)
          where
          SINESTER_CLAIMS_Id = rcRecOfTab.SINESTER_CLAIMS_Id(n)
;
    end if;
  END;

	PROCEDURE updPackage_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuPackage_Id$ in LD_sinester_claims.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSINESTER_CLAIMS_Id,
				rcData
			);
		end if;

		update LD_sinester_claims
		set
			Package_Id = inuPackage_Id$
		where
			SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCausal_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuCausal_Id$ in LD_sinester_claims.Causal_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSINESTER_CLAIMS_Id,
				rcData
			);
		end if;

		update LD_sinester_claims
		set
			Causal_Id = inuCausal_Id$
		where
			SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Causal_Id:= inuCausal_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updClaims_Date
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		idtClaims_Date$ in LD_sinester_claims.Claims_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSINESTER_CLAIMS_Id,
				rcData
			);
		end if;

		update LD_sinester_claims
		set
			Claims_Date = idtClaims_Date$
		where
			SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Claims_Date:= idtClaims_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInsured_Name
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		isbInsured_Name$ in LD_sinester_claims.Insured_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSINESTER_CLAIMS_Id,
				rcData
			);
		end if;

		update LD_sinester_claims
		set
			Insured_Name = isbInsured_Name$
		where
			SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Insured_Name:= isbInsured_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInsured_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		isbInsured_Id$ in LD_sinester_claims.Insured_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_sinester_claims;
	BEGIN
		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSINESTER_CLAIMS_Id,
				rcData
			);
		end if;

		update LD_sinester_claims
		set
			Insured_Id = isbInsured_Id$
		where
			SINESTER_CLAIMS_Id = inuSINESTER_CLAIMS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Insured_Id:= isbInsured_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPackage_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_sinester_claims.Package_Id%type
	IS
		rcError styLD_sinester_claims;
	BEGIN

		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuSINESTER_CLAIMS_Id
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

	FUNCTION fnuGetCausal_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_sinester_claims.Causal_Id%type
	IS
		rcError styLD_sinester_claims;
	BEGIN

		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData.Causal_Id);
		end if;
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(rcData.Causal_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetClaims_Date
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_sinester_claims.Claims_Date%type
	IS
		rcError styLD_sinester_claims;
	BEGIN

		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData.Claims_Date);
		end if;
		Load
		(
		 		inuSINESTER_CLAIMS_Id
		);
		return(rcData.Claims_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSinester_Claims_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_sinester_claims.Sinester_Claims_Id%type
	IS
		rcError styLD_sinester_claims;
	BEGIN

		rcError.SINESTER_CLAIMS_Id := inuSINESTER_CLAIMS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData.Sinester_Claims_Id);
		end if;
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(rcData.Sinester_Claims_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetInsured_Name
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_sinester_claims.Insured_Name%type
	IS
		rcError styLD_sinester_claims;
	BEGIN

		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData.Insured_Name);
		end if;
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(rcData.Insured_Name);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetInsured_Id
	(
		inuSINESTER_CLAIMS_Id in LD_sinester_claims.SINESTER_CLAIMS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_sinester_claims.Insured_Id%type
	IS
		rcError styLD_sinester_claims;
	BEGIN

		rcError.SINESTER_CLAIMS_Id:=inuSINESTER_CLAIMS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSINESTER_CLAIMS_Id
			 )
		then
			 return(rcData.Insured_Id);
		end if;
		Load
		(
			inuSINESTER_CLAIMS_Id
		);
		return(rcData.Insured_Id);
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
end DALD_sinester_claims;
/
PROMPT Otorgando permisos de ejecucion a DALD_SINESTER_CLAIMS
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SINESTER_CLAIMS', 'ADM_PERSON');
END;
/
