CREATE OR REPLACE PACKAGE adm_person.DALD_quota_block
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
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
  )
  IS
		SELECT LD_quota_block.*,LD_quota_block.rowid
		FROM LD_quota_block
		WHERE
			Quota_Block_Id = inuQuota_Block_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_block.*,LD_quota_block.rowid
		FROM LD_quota_block
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_quota_block  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_quota_block is table of styLD_quota_block index by binary_integer;
	type tyrfRecords is ref cursor return styLD_quota_block;

	/* Tipos referenciando al registro */
	type tytbQuota_Block_Id is table of LD_quota_block.Quota_Block_Id%type index by binary_integer;
	type tytbBlock is table of LD_quota_block.Block%type index by binary_integer;
	type tytbSubscription_Id is table of LD_quota_block.Subscription_Id%type index by binary_integer;
	type tytbCausal_Id is table of LD_quota_block.Causal_Id%type index by binary_integer;
	type tytbRegister_Date is table of LD_quota_block.Register_Date%type index by binary_integer;
	type tytbObservation is table of LD_quota_block.Observation%type index by binary_integer;
	type tytbUsername is table of LD_quota_block.Username%type index by binary_integer;
	type tytbTerminal is table of LD_quota_block.Terminal%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_quota_block is record
	(

		Quota_Block_Id   tytbQuota_Block_Id,
		Block   tytbBlock,
		Subscription_Id   tytbSubscription_Id,
		Causal_Id   tytbCausal_Id,
		Register_Date   tytbRegister_Date,
		Observation   tytbObservation,
		Username   tytbUsername,
		Terminal   tytbTerminal,
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
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	);

	PROCEDURE getRecord
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		orcRecord out nocopy styLD_quota_block
	);

	FUNCTION frcGetRcData
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN styLD_quota_block;

	FUNCTION frcGetRcData
	RETURN styLD_quota_block;

	FUNCTION frcGetRecord
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN styLD_quota_block;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_block
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_quota_block in styLD_quota_block
	);

 	  PROCEDURE insRecord
	(
		ircLD_quota_block in styLD_quota_block,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_quota_block in out nocopy tytbLD_quota_block
	);

	PROCEDURE delRecord
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_quota_block in out nocopy tytbLD_quota_block,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_quota_block in styLD_quota_block,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_quota_block in out nocopy tytbLD_quota_block,
		inuLock in number default 1
	);

		PROCEDURE updBlock
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				isbBlock$  in LD_quota_block.Block%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubscription_Id
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				inuSubscription_Id$  in LD_quota_block.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCausal_Id
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				inuCausal_Id$  in LD_quota_block.Causal_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRegister_Date
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				idtRegister_Date$  in LD_quota_block.Register_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updObservation
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				isbObservation$  in LD_quota_block.Observation%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUsername
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				isbUsername$  in LD_quota_block.Username%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updTerminal
		(
				inuQuota_Block_Id   in LD_quota_block.Quota_Block_Id%type,
				isbTerminal$  in LD_quota_block.Terminal%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetQuota_Block_Id
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Quota_Block_Id%type;

    	FUNCTION fsbGetBlock
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Block%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Subscription_Id%type;

    	FUNCTION fnuGetCausal_Id
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Causal_Id%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Register_Date%type;

    	FUNCTION fsbGetObservation
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Observation%type;

    	FUNCTION fsbGetUsername
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Username%type;

    	FUNCTION fsbGetTerminal
    	(
    	    inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_block.Terminal%type;


	PROCEDURE LockByPk
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		orcLD_quota_block  out styLD_quota_block
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_quota_block  out styLD_quota_block
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_quota_block;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_quota_block
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_QUOTA_BLOCK';
	  cnuGeEntityId constant varchar2(30) := 8659; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	IS
		SELECT LD_quota_block.*,LD_quota_block.rowid
		FROM LD_quota_block
		WHERE  Quota_Block_Id = inuQuota_Block_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_block.*,LD_quota_block.rowid
		FROM LD_quota_block
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_quota_block is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_quota_block;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_quota_block default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Quota_Block_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		orcLD_quota_block  out styLD_quota_block
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;

		Open cuLockRcByPk
		(
			inuQuota_Block_Id
		);

		fetch cuLockRcByPk into orcLD_quota_block;
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
		orcLD_quota_block  out styLD_quota_block
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_quota_block;
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
		itbLD_quota_block  in out nocopy tytbLD_quota_block
	)
	IS
	BEGIN
			rcRecOfTab.Quota_Block_Id.delete;
			rcRecOfTab.Block.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Causal_Id.delete;
			rcRecOfTab.Register_Date.delete;
			rcRecOfTab.Observation.delete;
			rcRecOfTab.Username.delete;
			rcRecOfTab.Terminal.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_quota_block  in out nocopy tytbLD_quota_block,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_quota_block);
		for n in itbLD_quota_block.first .. itbLD_quota_block.last loop
			rcRecOfTab.Quota_Block_Id(n) := itbLD_quota_block(n).Quota_Block_Id;
			rcRecOfTab.Block(n) := itbLD_quota_block(n).Block;
			rcRecOfTab.Subscription_Id(n) := itbLD_quota_block(n).Subscription_Id;
			rcRecOfTab.Causal_Id(n) := itbLD_quota_block(n).Causal_Id;
			rcRecOfTab.Register_Date(n) := itbLD_quota_block(n).Register_Date;
			rcRecOfTab.Observation(n) := itbLD_quota_block(n).Observation;
			rcRecOfTab.Username(n) := itbLD_quota_block(n).Username;
			rcRecOfTab.Terminal(n) := itbLD_quota_block(n).Terminal;
			rcRecOfTab.row_id(n) := itbLD_quota_block(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuQuota_Block_Id
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
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuQuota_Block_Id = rcData.Quota_Block_Id
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
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuQuota_Block_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	IS
		rcError styLD_quota_block;
	BEGIN		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		Load
		(
			inuQuota_Block_Id
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
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuQuota_Block_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		orcRecord out nocopy styLD_quota_block
	)
	IS
		rcError styLD_quota_block;
	BEGIN		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		Load
		(
			inuQuota_Block_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN styLD_quota_block
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		Load
		(
			inuQuota_Block_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type
	)
	RETURN styLD_quota_block
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id:=inuQuota_Block_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQuota_Block_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuQuota_Block_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_quota_block
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_block
	)
	IS
		rfLD_quota_block tyrfLD_quota_block;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_quota_block.Quota_Block_Id,
		            LD_quota_block.Block,
		            LD_quota_block.Subscription_Id,
		            LD_quota_block.Causal_Id,
		            LD_quota_block.Register_Date,
		            LD_quota_block.Observation,
		            LD_quota_block.Username,
		            LD_quota_block.Terminal,
		            LD_quota_block.rowid
                FROM LD_quota_block';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_quota_block for sbFullQuery;
		fetch rfLD_quota_block bulk collect INTO otbResult;
		close rfLD_quota_block;
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
		            LD_quota_block.Quota_Block_Id,
		            LD_quota_block.Block,
		            LD_quota_block.Subscription_Id,
		            LD_quota_block.Causal_Id,
		            LD_quota_block.Register_Date,
		            LD_quota_block.Observation,
		            LD_quota_block.Username,
		            LD_quota_block.Terminal,
		            LD_quota_block.rowid
                FROM LD_quota_block';
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
		ircLD_quota_block in styLD_quota_block
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_quota_block,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_quota_block in styLD_quota_block,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_quota_block.Quota_Block_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Quota_Block_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_quota_block
		(
			Quota_Block_Id,
			Block,
			Subscription_Id,
			Causal_Id,
			Register_Date,
			Observation,
			Username,
			Terminal
		)
		values
		(
			ircLD_quota_block.Quota_Block_Id,
			ircLD_quota_block.Block,
			ircLD_quota_block.Subscription_Id,
			ircLD_quota_block.Causal_Id,
			ircLD_quota_block.Register_Date,
			ircLD_quota_block.Observation,
			ircLD_quota_block.Username,
			ircLD_quota_block.Terminal
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_quota_block));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_quota_block in out nocopy tytbLD_quota_block
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_quota_block, blUseRowID);
		forall n in iotbLD_quota_block.first..iotbLD_quota_block.last
			insert into LD_quota_block
			(
			Quota_Block_Id,
			Block,
			Subscription_Id,
			Causal_Id,
			Register_Date,
			Observation,
			Username,
			Terminal
		)
		values
		(
			rcRecOfTab.Quota_Block_Id(n),
			rcRecOfTab.Block(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Causal_Id(n),
			rcRecOfTab.Register_Date(n),
			rcRecOfTab.Observation(n),
			rcRecOfTab.Username(n),
			rcRecOfTab.Terminal(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		delete
		from LD_quota_block
		where
       		Quota_Block_Id=inuQuota_Block_Id;
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
		rcError  styLD_quota_block;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_quota_block
		where
			rowid = iriRowID
		returning
   Quota_Block_Id
		into
			rcError.Quota_Block_Id;

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
		iotbLD_quota_block in out nocopy tytbLD_quota_block,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_quota_block;
	BEGIN
		FillRecordOfTables(iotbLD_quota_block, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_quota_block.first .. iotbLD_quota_block.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_block.first .. iotbLD_quota_block.last
				delete
				from LD_quota_block
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_quota_block.first .. iotbLD_quota_block.last loop
					LockByPk
					(
							rcRecOfTab.Quota_Block_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_block.first .. iotbLD_quota_block.last
				delete
				from LD_quota_block
				where
		         	Quota_Block_Id = rcRecOfTab.Quota_Block_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_quota_block in styLD_quota_block,
		inuLock	  in number default 0
	)
	IS
		nuQuota_Block_Id LD_quota_block.Quota_Block_Id%type;

	BEGIN
		if ircLD_quota_block.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_quota_block.rowid,rcData);
			end if;
			update LD_quota_block
			set

        Block = ircLD_quota_block.Block,
        Subscription_Id = ircLD_quota_block.Subscription_Id,
        Causal_Id = ircLD_quota_block.Causal_Id,
        Register_Date = ircLD_quota_block.Register_Date,
        Observation = ircLD_quota_block.Observation,
        Username = ircLD_quota_block.Username,
        Terminal = ircLD_quota_block.Terminal
			where
				rowid = ircLD_quota_block.rowid
			returning
    Quota_Block_Id
			into
				nuQuota_Block_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_quota_block.Quota_Block_Id,
					rcData
				);
			end if;

			update LD_quota_block
			set
        Block = ircLD_quota_block.Block,
        Subscription_Id = ircLD_quota_block.Subscription_Id,
        Causal_Id = ircLD_quota_block.Causal_Id,
        Register_Date = ircLD_quota_block.Register_Date,
        Observation = ircLD_quota_block.Observation,
        Username = ircLD_quota_block.Username,
        Terminal = ircLD_quota_block.Terminal
			where
	         	Quota_Block_Id = ircLD_quota_block.Quota_Block_Id
			returning
    Quota_Block_Id
			into
				nuQuota_Block_Id;
		end if;

		if
			nuQuota_Block_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_quota_block));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_quota_block in out nocopy tytbLD_quota_block,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_quota_block;
  BEGIN
    FillRecordOfTables(iotbLD_quota_block,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_quota_block.first .. iotbLD_quota_block.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_block.first .. iotbLD_quota_block.last
        update LD_quota_block
        set

            Block = rcRecOfTab.Block(n),
            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Causal_Id = rcRecOfTab.Causal_Id(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Observation = rcRecOfTab.Observation(n),
            Username = rcRecOfTab.Username(n),
            Terminal = rcRecOfTab.Terminal(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_quota_block.first .. iotbLD_quota_block.last loop
          LockByPk
          (
              rcRecOfTab.Quota_Block_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_block.first .. iotbLD_quota_block.last
        update LD_quota_block
        set
					Block = rcRecOfTab.Block(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Causal_Id = rcRecOfTab.Causal_Id(n),
					Register_Date = rcRecOfTab.Register_Date(n),
					Observation = rcRecOfTab.Observation(n),
					Username = rcRecOfTab.Username(n),
					Terminal = rcRecOfTab.Terminal(n)
          where
          Quota_Block_Id = rcRecOfTab.Quota_Block_Id(n)
;
    end if;
  END;

	PROCEDURE updBlock
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		isbBlock$ in LD_quota_block.Block%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Block = isbBlock$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Block:= isbBlock$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubscription_Id
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuSubscription_Id$ in LD_quota_block.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Subscription_Id = inuSubscription_Id$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCausal_Id
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuCausal_Id$ in LD_quota_block.Causal_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Causal_Id = inuCausal_Id$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Causal_Id:= inuCausal_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		idtRegister_Date$ in LD_quota_block.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Register_Date = idtRegister_Date$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updObservation
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		isbObservation$ in LD_quota_block.Observation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Observation = isbObservation$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Observation:= isbObservation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUsername
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		isbUsername$ in LD_quota_block.Username%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Username = isbUsername$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Username:= isbUsername$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTerminal
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		isbTerminal$ in LD_quota_block.Terminal%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_block;
	BEGIN
		rcError.Quota_Block_Id := inuQuota_Block_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_Block_Id,
				rcData
			);
		end if;

		update LD_quota_block
		set
			Terminal = isbTerminal$
		where
			Quota_Block_Id = inuQuota_Block_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Terminal:= isbTerminal$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetQuota_Block_Id
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Quota_Block_Id%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id := inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Quota_Block_Id);
		end if;
		Load
		(
			inuQuota_Block_Id
		);
		return(rcData.Quota_Block_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetBlock
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Block%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Block);
		end if;
		Load
		(
			inuQuota_Block_Id
		);
		return(rcData.Block);
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
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Subscription_Id%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id := inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuQuota_Block_Id
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

	FUNCTION fnuGetCausal_Id
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Causal_Id%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id := inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Causal_Id);
		end if;
		Load
		(
			inuQuota_Block_Id
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

	FUNCTION fdtGetRegister_Date
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Register_Date%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQuota_Block_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuQuota_Block_Id
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

	FUNCTION fsbGetObservation
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Observation%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Observation);
		end if;
		Load
		(
			inuQuota_Block_Id
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

	FUNCTION fsbGetUsername
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Username%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Username);
		end if;
		Load
		(
			inuQuota_Block_Id
		);
		return(rcData.Username);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetTerminal
	(
		inuQuota_Block_Id in LD_quota_block.Quota_Block_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_block.Terminal%type
	IS
		rcError styLD_quota_block;
	BEGIN

		rcError.Quota_Block_Id:=inuQuota_Block_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_Block_Id
			 )
		then
			 return(rcData.Terminal);
		end if;
		Load
		(
			inuQuota_Block_Id
		);
		return(rcData.Terminal);
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
end DALD_quota_block;
/

PROMPT Otorgando permisos de ejecucion a DALD_QUOTA_BLOCK
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_QUOTA_BLOCK', 'ADM_PERSON');
END;
/