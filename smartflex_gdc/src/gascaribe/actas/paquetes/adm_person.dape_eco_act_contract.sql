CREATE OR REPLACE PACKAGE ADM_PERSON.DAPE_eco_act_contract
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/ 
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	IS
		SELECT PE_eco_act_contract.*,PE_eco_act_contract.rowid
		FROM PE_eco_act_contract
		WHERE
		    Eco_Act_Contract_Id = inuEco_Act_Contract_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT PE_eco_act_contract.*,PE_eco_act_contract.rowid
		FROM PE_eco_act_contract
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styPE_eco_act_contract  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbPE_eco_act_contract is table of styPE_eco_act_contract index by binary_integer;
	type tyrfRecords is ref cursor return styPE_eco_act_contract;

	/* Tipos referenciando al registro */
	type tytbEconomic_Activity_Id is table of PE_eco_act_contract.Economic_Activity_Id%type index by binary_integer;
	type tytbSubscription_Id is table of PE_eco_act_contract.Subscription_Id%type index by binary_integer;
	type tytbEco_Act_Contract_Id is table of PE_eco_act_contract.Eco_Act_Contract_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcPE_eco_act_contract is record
	(
		Economic_Activity_Id   tytbEconomic_Activity_Id,
		Subscription_Id   tytbSubscription_Id,
		Eco_Act_Contract_Id   tytbEco_Act_Contract_Id,
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
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	);

	PROCEDURE getRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		orcRecord out nocopy styPE_eco_act_contract
	);

	FUNCTION frcGetRcData
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN styPE_eco_act_contract;

	FUNCTION frcGetRcData
	RETURN styPE_eco_act_contract;

	FUNCTION frcGetRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN styPE_eco_act_contract;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbPE_eco_act_contract
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircPE_eco_act_contract in styPE_eco_act_contract
	);

	PROCEDURE insRecord
	(
		ircPE_eco_act_contract in styPE_eco_act_contract,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbPE_eco_act_contract in out nocopy tytbPE_eco_act_contract
	);

	PROCEDURE delRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbPE_eco_act_contract in out nocopy tytbPE_eco_act_contract,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircPE_eco_act_contract in styPE_eco_act_contract,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbPE_eco_act_contract in out nocopy tytbPE_eco_act_contract,
		inuLock in number default 1
	);

	PROCEDURE updEconomic_Activity_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuEconomic_Activity_Id$ in PE_eco_act_contract.Economic_Activity_Id%type,
		inuLock in number default 0
	);

	PROCEDURE updSubscription_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuSubscription_Id$ in PE_eco_act_contract.Subscription_Id%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetEconomic_Activity_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_eco_act_contract.Economic_Activity_Id%type;

	FUNCTION fnuGetSubscription_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_eco_act_contract.Subscription_Id%type;

	FUNCTION fnuGetEco_Act_Contract_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_eco_act_contract.Eco_Act_Contract_Id%type;


	PROCEDURE LockByPk
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		orcPE_eco_act_contract  out styPE_eco_act_contract
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcPE_eco_act_contract  out styPE_eco_act_contract
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DAPE_eco_act_contract;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DAPE_eco_act_contract
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO295858';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'PE_ECO_ACT_CONTRACT';
	 cnuGeEntityId constant varchar2(30) := 2981; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	IS
		SELECT PE_eco_act_contract.*,PE_eco_act_contract.rowid
		FROM PE_eco_act_contract
		WHERE  Eco_Act_Contract_Id = inuEco_Act_Contract_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT PE_eco_act_contract.*,PE_eco_act_contract.rowid
		FROM PE_eco_act_contract
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfPE_eco_act_contract is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcPE_eco_act_contract;

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
	FUNCTION fsbPrimaryKey( rcI in styPE_eco_act_contract default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Eco_Act_Contract_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		orcPE_eco_act_contract  out styPE_eco_act_contract
	)
	IS
		rcError styPE_eco_act_contract;
	BEGIN
		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;

		Open cuLockRcByPk
		(
			inuEco_Act_Contract_Id
		);

		fetch cuLockRcByPk into orcPE_eco_act_contract;
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
		orcPE_eco_act_contract  out styPE_eco_act_contract
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcPE_eco_act_contract;
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
		itbPE_eco_act_contract  in out nocopy tytbPE_eco_act_contract
	)
	IS
	BEGIN
			rcRecOfTab.Economic_Activity_Id.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Eco_Act_Contract_Id.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbPE_eco_act_contract  in out nocopy tytbPE_eco_act_contract,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbPE_eco_act_contract);

		for n in itbPE_eco_act_contract.first .. itbPE_eco_act_contract.last loop
			rcRecOfTab.Economic_Activity_Id(n) := itbPE_eco_act_contract(n).Economic_Activity_Id;
			rcRecOfTab.Subscription_Id(n) := itbPE_eco_act_contract(n).Subscription_Id;
			rcRecOfTab.Eco_Act_Contract_Id(n) := itbPE_eco_act_contract(n).Eco_Act_Contract_Id;
			rcRecOfTab.row_id(n) := itbPE_eco_act_contract(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuEco_Act_Contract_Id
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
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuEco_Act_Contract_Id = rcData.Eco_Act_Contract_Id
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
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuEco_Act_Contract_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	IS
		rcError styPE_eco_act_contract;
	BEGIN		rcError.Eco_Act_Contract_Id:=inuEco_Act_Contract_Id;

		Load
		(
			inuEco_Act_Contract_Id
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
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuEco_Act_Contract_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		orcRecord out nocopy styPE_eco_act_contract
	)
	IS
		rcError styPE_eco_act_contract;
	BEGIN		rcError.Eco_Act_Contract_Id:=inuEco_Act_Contract_Id;

		Load
		(
			inuEco_Act_Contract_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN styPE_eco_act_contract
	IS
		rcError styPE_eco_act_contract;
	BEGIN
		rcError.Eco_Act_Contract_Id:=inuEco_Act_Contract_Id;

		Load
		(
			inuEco_Act_Contract_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type
	)
	RETURN styPE_eco_act_contract
	IS
		rcError styPE_eco_act_contract;
	BEGIN
		rcError.Eco_Act_Contract_Id:=inuEco_Act_Contract_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuEco_Act_Contract_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuEco_Act_Contract_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styPE_eco_act_contract
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbPE_eco_act_contract
	)
	IS
		rfPE_eco_act_contract tyrfPE_eco_act_contract;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT PE_eco_act_contract.*, PE_eco_act_contract.rowid FROM PE_eco_act_contract';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfPE_eco_act_contract for sbFullQuery;

		fetch rfPE_eco_act_contract bulk collect INTO otbResult;

		close rfPE_eco_act_contract;
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
		sbSQL VARCHAR2 (32000) := 'select PE_eco_act_contract.*, PE_eco_act_contract.rowid FROM PE_eco_act_contract';
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
		ircPE_eco_act_contract in styPE_eco_act_contract
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircPE_eco_act_contract,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircPE_eco_act_contract in styPE_eco_act_contract,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircPE_eco_act_contract.Eco_Act_Contract_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Eco_Act_Contract_Id');
			raise ex.controlled_error;
		end if;

		insert into PE_eco_act_contract
		(
			Economic_Activity_Id,
			Subscription_Id,
			Eco_Act_Contract_Id
		)
		values
		(
			ircPE_eco_act_contract.Economic_Activity_Id,
			ircPE_eco_act_contract.Subscription_Id,
			ircPE_eco_act_contract.Eco_Act_Contract_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircPE_eco_act_contract));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbPE_eco_act_contract in out nocopy tytbPE_eco_act_contract
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbPE_eco_act_contract,blUseRowID);
		forall n in iotbPE_eco_act_contract.first..iotbPE_eco_act_contract.last
			insert into PE_eco_act_contract
			(
				Economic_Activity_Id,
				Subscription_Id,
				Eco_Act_Contract_Id
			)
			values
			(
				rcRecOfTab.Economic_Activity_Id(n),
				rcRecOfTab.Subscription_Id(n),
				rcRecOfTab.Eco_Act_Contract_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styPE_eco_act_contract;
	BEGIN
		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;

		if inuLock=1 then
			LockByPk
			(
				inuEco_Act_Contract_Id,
				rcData
			);
		end if;


		delete
		from PE_eco_act_contract
		where
       		Eco_Act_Contract_Id=inuEco_Act_Contract_Id;
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
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styPE_eco_act_contract;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from PE_eco_act_contract
		where
			rowid = iriRowID
		returning
			Eco_Act_Contract_Id
		into
			rcError.Eco_Act_Contract_Id;
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
		iotbPE_eco_act_contract in out nocopy tytbPE_eco_act_contract,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styPE_eco_act_contract;
	BEGIN
		FillRecordOfTables(iotbPE_eco_act_contract, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last
				delete
				from PE_eco_act_contract
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last loop
					LockByPk
					(
						rcRecOfTab.Eco_Act_Contract_Id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last
				delete
				from PE_eco_act_contract
				where
		         	Eco_Act_Contract_Id = rcRecOfTab.Eco_Act_Contract_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircPE_eco_act_contract in styPE_eco_act_contract,
		inuLock in number default 0
	)
	IS
		nuEco_Act_Contract_Id	PE_eco_act_contract.Eco_Act_Contract_Id%type;
	BEGIN
		if ircPE_eco_act_contract.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircPE_eco_act_contract.rowid,rcData);
			end if;
			update PE_eco_act_contract
			set
				Economic_Activity_Id = ircPE_eco_act_contract.Economic_Activity_Id,
				Subscription_Id = ircPE_eco_act_contract.Subscription_Id
			where
				rowid = ircPE_eco_act_contract.rowid
			returning
				Eco_Act_Contract_Id
			into
				nuEco_Act_Contract_Id;
		else
			if inuLock=1 then
				LockByPk
				(
					ircPE_eco_act_contract.Eco_Act_Contract_Id,
					rcData
				);
			end if;

			update PE_eco_act_contract
			set
				Economic_Activity_Id = ircPE_eco_act_contract.Economic_Activity_Id,
				Subscription_Id = ircPE_eco_act_contract.Subscription_Id
			where
				Eco_Act_Contract_Id = ircPE_eco_act_contract.Eco_Act_Contract_Id
			returning
				Eco_Act_Contract_Id
			into
				nuEco_Act_Contract_Id;
		end if;
		if
			nuEco_Act_Contract_Id is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircPE_eco_act_contract));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbPE_eco_act_contract in out nocopy tytbPE_eco_act_contract,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styPE_eco_act_contract;
	BEGIN
		FillRecordOfTables(iotbPE_eco_act_contract,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last
				update PE_eco_act_contract
				set
					Economic_Activity_Id = rcRecOfTab.Economic_Activity_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last loop
					LockByPk
					(
						rcRecOfTab.Eco_Act_Contract_Id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_eco_act_contract.first .. iotbPE_eco_act_contract.last
				update PE_eco_act_contract
				SET
					Economic_Activity_Id = rcRecOfTab.Economic_Activity_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n)
				where
					Eco_Act_Contract_Id = rcRecOfTab.Eco_Act_Contract_Id(n)
;
		end if;
	END;
	PROCEDURE updEconomic_Activity_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuEconomic_Activity_Id$ in PE_eco_act_contract.Economic_Activity_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styPE_eco_act_contract;
	BEGIN
		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEco_Act_Contract_Id,
				rcData
			);
		end if;

		update PE_eco_act_contract
		set
			Economic_Activity_Id = inuEconomic_Activity_Id$
		where
			Eco_Act_Contract_Id = inuEco_Act_Contract_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Economic_Activity_Id:= inuEconomic_Activity_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSubscription_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuSubscription_Id$ in PE_eco_act_contract.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styPE_eco_act_contract;
	BEGIN
		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEco_Act_Contract_Id,
				rcData
			);
		end if;

		update PE_eco_act_contract
		set
			Subscription_Id = inuSubscription_Id$
		where
			Eco_Act_Contract_Id = inuEco_Act_Contract_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetEconomic_Activity_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_eco_act_contract.Economic_Activity_Id%type
	IS
		rcError styPE_eco_act_contract;
	BEGIN

		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEco_Act_Contract_Id
			 )
		then
			 return(rcData.Economic_Activity_Id);
		end if;
		Load
		(
		 		inuEco_Act_Contract_Id
		);
		return(rcData.Economic_Activity_Id);
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
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_eco_act_contract.Subscription_Id%type
	IS
		rcError styPE_eco_act_contract;
	BEGIN

		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEco_Act_Contract_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
		 		inuEco_Act_Contract_Id
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
	FUNCTION fnuGetEco_Act_Contract_Id
	(
		inuEco_Act_Contract_Id in PE_eco_act_contract.Eco_Act_Contract_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_eco_act_contract.Eco_Act_Contract_Id%type
	IS
		rcError styPE_eco_act_contract;
	BEGIN

		rcError.Eco_Act_Contract_Id := inuEco_Act_Contract_Id;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEco_Act_Contract_Id
			 )
		then
			 return(rcData.Eco_Act_Contract_Id);
		end if;
		Load
		(
		 		inuEco_Act_Contract_Id
		);
		return(rcData.Eco_Act_Contract_Id);
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
end DAPE_eco_act_contract;
/
PROMPT Otorgando permisos de ejecucion a DAPE_ECO_ACT_CONTRACT
BEGIN
    pkg_utilidades.praplicarpermisos('DAPE_ECO_ACT_CONTRACT', 'ADM_PERSON');
END;
/