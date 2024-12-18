CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_relevant_market
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_relevant_market
    Descripcion	 : Paquete para la gestión de la entidad LD_relevant_market (Mercado Relevante)
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
    31/05/2024             PAcosta            OSF-2767: Cambio de esquema ADM_PERSON  
    ****************************************************************/

	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
  )
  IS
		SELECT LD_relevant_market.*,LD_relevant_market.rowid
		FROM LD_relevant_market
		WHERE
			Relevant_Market_Id = inuRelevant_Market_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_relevant_market.*,LD_relevant_market.rowid
		FROM LD_relevant_market
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_relevant_market  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_relevant_market is table of styLD_relevant_market index by binary_integer;
	type tyrfRecords is ref cursor return styLD_relevant_market;

	/* Tipos referenciando al registro */
	type tytbRelevant_Market_Id is table of LD_relevant_market.Relevant_Market_Id%type index by binary_integer;
	type tytbRelevant_Market is table of LD_relevant_market.Relevant_Market%type index by binary_integer;
	type tytbDescription is table of LD_relevant_market.Description%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_relevant_market is record
	(

		Relevant_Market_Id   tytbRelevant_Market_Id,
		Relevant_Market   tytbRelevant_Market,
		Description   tytbDescription,
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
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	);

	PROCEDURE getRecord
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		orcRecord out nocopy styLD_relevant_market
	);

	FUNCTION frcGetRcData
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN styLD_relevant_market;

	FUNCTION frcGetRcData
	RETURN styLD_relevant_market;

	FUNCTION frcGetRecord
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN styLD_relevant_market;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_relevant_market
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_relevant_market in styLD_relevant_market
	);

 	  PROCEDURE insRecord
	(
		ircLD_relevant_market in styLD_relevant_market,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_relevant_market in out nocopy tytbLD_relevant_market
	);

	PROCEDURE delRecord
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_relevant_market in out nocopy tytbLD_relevant_market,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_relevant_market in styLD_relevant_market,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_relevant_market in out nocopy tytbLD_relevant_market,
		inuLock in number default 1
	);

		PROCEDURE updRelevant_Market
		(
				inuRelevant_Market_Id   in LD_relevant_market.Relevant_Market_Id%type,
				isbRelevant_Market$  in LD_relevant_market.Relevant_Market%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDescription
		(
				inuRelevant_Market_Id   in LD_relevant_market.Relevant_Market_Id%type,
				isbDescription$  in LD_relevant_market.Description%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetRelevant_Market_Id
    	(
    	    inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_relevant_market.Relevant_Market_Id%type;

    	FUNCTION fsbGetRelevant_Market
    	(
    	    inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_relevant_market.Relevant_Market%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_relevant_market.Description%type;


	PROCEDURE LockByPk
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		orcLD_relevant_market  out styLD_relevant_market
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_relevant_market  out styLD_relevant_market
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_relevant_market;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_relevant_market
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_RELEVANT_MARKET';
	  cnuGeEntityId constant varchar2(30) := 8337; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	IS
		SELECT LD_relevant_market.*,LD_relevant_market.rowid
		FROM LD_relevant_market
		WHERE  Relevant_Market_Id = inuRelevant_Market_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_relevant_market.*,LD_relevant_market.rowid
		FROM LD_relevant_market
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_relevant_market is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_relevant_market;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_relevant_market default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Relevant_Market_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		orcLD_relevant_market  out styLD_relevant_market
	)
	IS
		rcError styLD_relevant_market;
	BEGIN
		rcError.Relevant_Market_Id := inuRelevant_Market_Id;

		Open cuLockRcByPk
		(
			inuRelevant_Market_Id
		);

		fetch cuLockRcByPk into orcLD_relevant_market;
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
		orcLD_relevant_market  out styLD_relevant_market
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_relevant_market;
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
		itbLD_relevant_market  in out nocopy tytbLD_relevant_market
	)
	IS
	BEGIN
			rcRecOfTab.Relevant_Market_Id.delete;
			rcRecOfTab.Relevant_Market.delete;
			rcRecOfTab.Description.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_relevant_market  in out nocopy tytbLD_relevant_market,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_relevant_market);
		for n in itbLD_relevant_market.first .. itbLD_relevant_market.last loop
			rcRecOfTab.Relevant_Market_Id(n) := itbLD_relevant_market(n).Relevant_Market_Id;
			rcRecOfTab.Relevant_Market(n) := itbLD_relevant_market(n).Relevant_Market;
			rcRecOfTab.Description(n) := itbLD_relevant_market(n).Description;
			rcRecOfTab.row_id(n) := itbLD_relevant_market(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRelevant_Market_Id
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
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRelevant_Market_Id = rcData.Relevant_Market_Id
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
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRelevant_Market_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	IS
		rcError styLD_relevant_market;
	BEGIN		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;

		Load
		(
			inuRelevant_Market_Id
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
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuRelevant_Market_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		orcRecord out nocopy styLD_relevant_market
	)
	IS
		rcError styLD_relevant_market;
	BEGIN		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;

		Load
		(
			inuRelevant_Market_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN styLD_relevant_market
	IS
		rcError styLD_relevant_market;
	BEGIN
		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;

		Load
		(
			inuRelevant_Market_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type
	)
	RETURN styLD_relevant_market
	IS
		rcError styLD_relevant_market;
	BEGIN
		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRelevant_Market_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRelevant_Market_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_relevant_market
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_relevant_market
	)
	IS
		rfLD_relevant_market tyrfLD_relevant_market;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_relevant_market.Relevant_Market_Id,
		            LD_relevant_market.Relevant_Market,
		            LD_relevant_market.Description,
		            LD_relevant_market.rowid
                FROM LD_relevant_market';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_relevant_market for sbFullQuery;
		fetch rfLD_relevant_market bulk collect INTO otbResult;
		close rfLD_relevant_market;
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
		            LD_relevant_market.Relevant_Market_Id,
		            LD_relevant_market.Relevant_Market,
		            LD_relevant_market.Description,
		            LD_relevant_market.rowid
                FROM LD_relevant_market';
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
		ircLD_relevant_market in styLD_relevant_market
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_relevant_market,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_relevant_market in styLD_relevant_market,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_relevant_market.Relevant_Market_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Relevant_Market_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_relevant_market
		(
			Relevant_Market_Id,
			Relevant_Market,
			Description
		)
		values
		(
			ircLD_relevant_market.Relevant_Market_Id,
			ircLD_relevant_market.Relevant_Market,
			ircLD_relevant_market.Description
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_relevant_market));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_relevant_market in out nocopy tytbLD_relevant_market
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_relevant_market, blUseRowID);
		forall n in iotbLD_relevant_market.first..iotbLD_relevant_market.last
			insert into LD_relevant_market
			(
			Relevant_Market_Id,
			Relevant_Market,
			Description
		)
		values
		(
			rcRecOfTab.Relevant_Market_Id(n),
			rcRecOfTab.Relevant_Market(n),
			rcRecOfTab.Description(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_relevant_market;
	BEGIN
		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;

		if inuLock=1 then
			LockByPk
			(
				inuRelevant_Market_Id,
				rcData
			);
		end if;

		delete
		from LD_relevant_market
		where
       		Relevant_Market_Id=inuRelevant_Market_Id;
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
		rcError  styLD_relevant_market;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_relevant_market
		where
			rowid = iriRowID
		returning
   Relevant_Market_Id
		into
			rcError.Relevant_Market_Id;

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
		iotbLD_relevant_market in out nocopy tytbLD_relevant_market,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_relevant_market;
	BEGIN
		FillRecordOfTables(iotbLD_relevant_market, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last
				delete
				from LD_relevant_market
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last loop
					LockByPk
					(
							rcRecOfTab.Relevant_Market_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last
				delete
				from LD_relevant_market
				where
		         	Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_relevant_market in styLD_relevant_market,
		inuLock	  in number default 0
	)
	IS
		nuRelevant_Market_Id LD_relevant_market.Relevant_Market_Id%type;

	BEGIN
		if ircLD_relevant_market.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_relevant_market.rowid,rcData);
			end if;
			update LD_relevant_market
			set

        Relevant_Market = ircLD_relevant_market.Relevant_Market,
        Description = ircLD_relevant_market.Description
			where
				rowid = ircLD_relevant_market.rowid
			returning
    Relevant_Market_Id
			into
				nuRelevant_Market_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_relevant_market.Relevant_Market_Id,
					rcData
				);
			end if;

			update LD_relevant_market
			set
        Relevant_Market = ircLD_relevant_market.Relevant_Market,
        Description = ircLD_relevant_market.Description
			where
	         	Relevant_Market_Id = ircLD_relevant_market.Relevant_Market_Id
			returning
    Relevant_Market_Id
			into
				nuRelevant_Market_Id;
		end if;

		if
			nuRelevant_Market_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_relevant_market));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_relevant_market in out nocopy tytbLD_relevant_market,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_relevant_market;
  BEGIN
    FillRecordOfTables(iotbLD_relevant_market,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last
        update LD_relevant_market
        set

            Relevant_Market = rcRecOfTab.Relevant_Market(n),
            Description = rcRecOfTab.Description(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last loop
          LockByPk
          (
              rcRecOfTab.Relevant_Market_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_relevant_market.first .. iotbLD_relevant_market.last
        update LD_relevant_market
        set
					Relevant_Market = rcRecOfTab.Relevant_Market(n),
					Description = rcRecOfTab.Description(n)
          where
          Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n)
;
    end if;
  END;

	PROCEDURE updRelevant_Market
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		isbRelevant_Market$ in LD_relevant_market.Relevant_Market%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_relevant_market;
	BEGIN
		rcError.Relevant_Market_Id := inuRelevant_Market_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRelevant_Market_Id,
				rcData
			);
		end if;

		update LD_relevant_market
		set
			Relevant_Market = isbRelevant_Market$
		where
			Relevant_Market_Id = inuRelevant_Market_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Relevant_Market:= isbRelevant_Market$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDescription
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		isbDescription$ in LD_relevant_market.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_relevant_market;
	BEGIN
		rcError.Relevant_Market_Id := inuRelevant_Market_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRelevant_Market_Id,
				rcData
			);
		end if;

		update LD_relevant_market
		set
			Description = isbDescription$
		where
			Relevant_Market_Id = inuRelevant_Market_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetRelevant_Market_Id
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_relevant_market.Relevant_Market_Id%type
	IS
		rcError styLD_relevant_market;
	BEGIN

		rcError.Relevant_Market_Id := inuRelevant_Market_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRelevant_Market_Id
			 )
		then
			 return(rcData.Relevant_Market_Id);
		end if;
		Load
		(
			inuRelevant_Market_Id
		);
		return(rcData.Relevant_Market_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetRelevant_Market
	(
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_relevant_market.Relevant_Market%type
	IS
		rcError styLD_relevant_market;
	BEGIN

		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRelevant_Market_Id
			 )
		then
			 return(rcData.Relevant_Market);
		end if;
		Load
		(
			inuRelevant_Market_Id
		);
		return(rcData.Relevant_Market);
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
		inuRelevant_Market_Id in LD_relevant_market.Relevant_Market_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_relevant_market.Description%type
	IS
		rcError styLD_relevant_market;
	BEGIN

		rcError.Relevant_Market_Id:=inuRelevant_Market_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRelevant_Market_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuRelevant_Market_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_relevant_market;
/
PROMPT Otorgando permisos de ejecucion a DALD_RELEVANT_MARKET
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_RELEVANT_MARKET', 'ADM_PERSON');
END;
/
