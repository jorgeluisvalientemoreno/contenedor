CREATE OR REPLACE PACKAGE adm_person.dald_effective_state
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
  )
  IS
		SELECT LD_effective_state.*,LD_effective_state.rowid
		FROM LD_effective_state
		WHERE
			EFFECTIVE_STATE_Id = inuEFFECTIVE_STATE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_effective_state.*,LD_effective_state.rowid
		FROM LD_effective_state
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_effective_state  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_effective_state is table of styLD_effective_state index by binary_integer;
	type tyrfRecords is ref cursor return styLD_effective_state;

	/* Tipos referenciando al registro */
	type tytbEffective_State_Id is table of LD_effective_state.Effective_State_Id%type index by binary_integer;
	type tytbDescription is table of LD_effective_state.Description%type index by binary_integer;
	type tytbValid_For_Sale is table of LD_effective_state.Valid_For_Sale%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_effective_state is record
	(

		Effective_State_Id   tytbEffective_State_Id,
		Description   tytbDescription,
		Valid_For_Sale   tytbValid_For_Sale,
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
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	);

	PROCEDURE getRecord
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		orcRecord out nocopy styLD_effective_state
	);

	FUNCTION frcGetRcData
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN styLD_effective_state;

	FUNCTION frcGetRcData
	RETURN styLD_effective_state;

	FUNCTION frcGetRecord
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN styLD_effective_state;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_effective_state
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_effective_state in styLD_effective_state
	);

 	  PROCEDURE insRecord
	(
		ircLD_effective_state in styLD_effective_state,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_effective_state in out nocopy tytbLD_effective_state
	);

	PROCEDURE delRecord
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_effective_state in out nocopy tytbLD_effective_state,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_effective_state in styLD_effective_state,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_effective_state in out nocopy tytbLD_effective_state,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuEFFECTIVE_STATE_Id   in LD_effective_state.EFFECTIVE_STATE_Id%type,
				isbDescription$  in LD_effective_state.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValid_For_Sale
		(
				inuEFFECTIVE_STATE_Id   in LD_effective_state.EFFECTIVE_STATE_Id%type,
				isbValid_For_Sale$  in LD_effective_state.Valid_For_Sale%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fsbGetEffective_State_Id
    	(
    	    inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_effective_state.Effective_State_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_effective_state.Description%type;

    	FUNCTION fsbGetValid_For_Sale
    	(
    	    inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_effective_state.Valid_For_Sale%type;


	PROCEDURE LockByPk
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		orcLD_effective_state  out styLD_effective_state
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_effective_state  out styLD_effective_state
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_effective_state;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_effective_state
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO157446';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_EFFECTIVE_STATE';
	  cnuGeEntityId constant varchar2(30) := 8409; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	IS
		SELECT LD_effective_state.*,LD_effective_state.rowid
		FROM LD_effective_state
		WHERE  EFFECTIVE_STATE_Id = inuEFFECTIVE_STATE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_effective_state.*,LD_effective_state.rowid
		FROM LD_effective_state
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_effective_state is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_effective_state;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_effective_state default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.EFFECTIVE_STATE_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		orcLD_effective_state  out styLD_effective_state
	)
	IS
		rcError styLD_effective_state;
	BEGIN
		rcError.EFFECTIVE_STATE_Id := inuEFFECTIVE_STATE_Id;

		Open cuLockRcByPk
		(
			inuEFFECTIVE_STATE_Id
		);

		fetch cuLockRcByPk into orcLD_effective_state;
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
		orcLD_effective_state  out styLD_effective_state
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_effective_state;
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
		itbLD_effective_state  in out nocopy tytbLD_effective_state
	)
	IS
	BEGIN
			rcRecOfTab.Effective_State_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Valid_For_Sale.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_effective_state  in out nocopy tytbLD_effective_state,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_effective_state);
		for n in itbLD_effective_state.first .. itbLD_effective_state.last loop
			rcRecOfTab.Effective_State_Id(n) := itbLD_effective_state(n).Effective_State_Id;
			rcRecOfTab.Description(n) := itbLD_effective_state(n).Description;
			rcRecOfTab.Valid_For_Sale(n) := itbLD_effective_state(n).Valid_For_Sale;
			rcRecOfTab.row_id(n) := itbLD_effective_state(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuEFFECTIVE_STATE_Id
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
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuEFFECTIVE_STATE_Id = rcData.EFFECTIVE_STATE_Id
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
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	IS
		rcError styLD_effective_state;
	BEGIN		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		Load
		(
			inuEFFECTIVE_STATE_Id
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
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		orcRecord out nocopy styLD_effective_state
	)
	IS
		rcError styLD_effective_state;
	BEGIN		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN styLD_effective_state
	IS
		rcError styLD_effective_state;
	BEGIN
		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type
	)
	RETURN styLD_effective_state
	IS
		rcError styLD_effective_state;
	BEGIN
		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEFFECTIVE_STATE_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_effective_state
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_effective_state
	)
	IS
		rfLD_effective_state tyrfLD_effective_state;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_effective_state.Effective_State_Id,
		            LD_effective_state.Description,
		            LD_effective_state.Valid_For_Sale,
		            LD_effective_state.rowid
                FROM LD_effective_state';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_effective_state for sbFullQuery;
		fetch rfLD_effective_state bulk collect INTO otbResult;
		close rfLD_effective_state;
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
		            LD_effective_state.Effective_State_Id,
		            LD_effective_state.Description,
		            LD_effective_state.Valid_For_Sale,
		            LD_effective_state.rowid
                FROM LD_effective_state';
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
		ircLD_effective_state in styLD_effective_state
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_effective_state,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_effective_state in styLD_effective_state,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_effective_state.EFFECTIVE_STATE_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|EFFECTIVE_STATE_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_effective_state
		(
			Effective_State_Id,
			Description,
			Valid_For_Sale
		)
		values
		(
			ircLD_effective_state.Effective_State_Id,
			ircLD_effective_state.Description,
			ircLD_effective_state.Valid_For_Sale
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_effective_state));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_effective_state in out nocopy tytbLD_effective_state
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_effective_state, blUseRowID);
		forall n in iotbLD_effective_state.first..iotbLD_effective_state.last
			insert into LD_effective_state
			(
			Effective_State_Id,
			Description,
			Valid_For_Sale
		)
		values
		(
			rcRecOfTab.Effective_State_Id(n),
			rcRecOfTab.Description(n),
			rcRecOfTab.Valid_For_Sale(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_effective_state;
	BEGIN
		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		if inuLock=1 then
			LockByPk
			(
				inuEFFECTIVE_STATE_Id,
				rcData
			);
		end if;

		delete
		from LD_effective_state
		where
       		EFFECTIVE_STATE_Id=inuEFFECTIVE_STATE_Id;
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
		rcError  styLD_effective_state;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_effective_state
		where
			rowid = iriRowID
		returning
   EFFECTIVE_STATE_Id
		into
			rcError.EFFECTIVE_STATE_Id;

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
		iotbLD_effective_state in out nocopy tytbLD_effective_state,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_effective_state;
	BEGIN
		FillRecordOfTables(iotbLD_effective_state, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_effective_state.first .. iotbLD_effective_state.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_effective_state.first .. iotbLD_effective_state.last
				delete
				from LD_effective_state
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_effective_state.first .. iotbLD_effective_state.last loop
					LockByPk
					(
							rcRecOfTab.EFFECTIVE_STATE_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_effective_state.first .. iotbLD_effective_state.last
				delete
				from LD_effective_state
				where
		         	EFFECTIVE_STATE_Id = rcRecOfTab.EFFECTIVE_STATE_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_effective_state in styLD_effective_state,
		inuLock	  in number default 0
	)
	IS
		nuEFFECTIVE_STATE_Id LD_effective_state.EFFECTIVE_STATE_Id%type;

	BEGIN
		if ircLD_effective_state.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_effective_state.rowid,rcData);
			end if;
			update LD_effective_state
			set

        Description = ircLD_effective_state.Description,
        Valid_For_Sale = ircLD_effective_state.Valid_For_Sale
			where
				rowid = ircLD_effective_state.rowid
			returning
    EFFECTIVE_STATE_Id
			into
				nuEFFECTIVE_STATE_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_effective_state.EFFECTIVE_STATE_Id,
					rcData
				);
			end if;

			update LD_effective_state
			set
        Description = ircLD_effective_state.Description,
        Valid_For_Sale = ircLD_effective_state.Valid_For_Sale
			where
	         	EFFECTIVE_STATE_Id = ircLD_effective_state.EFFECTIVE_STATE_Id
			returning
    EFFECTIVE_STATE_Id
			into
				nuEFFECTIVE_STATE_Id;
		end if;

		if
			nuEFFECTIVE_STATE_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_effective_state));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_effective_state in out nocopy tytbLD_effective_state,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_effective_state;
  BEGIN
    FillRecordOfTables(iotbLD_effective_state,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_effective_state.first .. iotbLD_effective_state.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_effective_state.first .. iotbLD_effective_state.last
        update LD_effective_state
        set

            Description = rcRecOfTab.Description(n),
            Valid_For_Sale = rcRecOfTab.Valid_For_Sale(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_effective_state.first .. iotbLD_effective_state.last loop
          LockByPk
          (
              rcRecOfTab.EFFECTIVE_STATE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_effective_state.first .. iotbLD_effective_state.last
        update LD_effective_state
        set
					Description = rcRecOfTab.Description(n),
					Valid_For_Sale = rcRecOfTab.Valid_For_Sale(n)
          where
          EFFECTIVE_STATE_Id = rcRecOfTab.EFFECTIVE_STATE_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		isbDescription$ in LD_effective_state.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_effective_state;
	BEGIN
		rcError.EFFECTIVE_STATE_Id := inuEFFECTIVE_STATE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEFFECTIVE_STATE_Id,
				rcData
			);
		end if;

		update LD_effective_state
		set
			Description = isbDescription$
		where
			EFFECTIVE_STATE_Id = inuEFFECTIVE_STATE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValid_For_Sale
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		isbValid_For_Sale$ in LD_effective_state.Valid_For_Sale%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_effective_state;
	BEGIN
		rcError.EFFECTIVE_STATE_Id := inuEFFECTIVE_STATE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEFFECTIVE_STATE_Id,
				rcData
			);
		end if;

		update LD_effective_state
		set
			Valid_For_Sale = isbValid_For_Sale$
		where
			EFFECTIVE_STATE_Id = inuEFFECTIVE_STATE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Valid_For_Sale:= isbValid_For_Sale$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fsbGetEffective_State_Id
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_effective_state.Effective_State_Id%type
	IS
		rcError styLD_effective_state;
	BEGIN

		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEFFECTIVE_STATE_Id
			 )
		then
			 return(rcData.Effective_State_Id);
		end if;
		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		return(rcData.Effective_State_Id);
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
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_effective_state.Description%type
	IS
		rcError styLD_effective_state;
	BEGIN

		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEFFECTIVE_STATE_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuEFFECTIVE_STATE_Id
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

	FUNCTION fsbGetValid_For_Sale
	(
		inuEFFECTIVE_STATE_Id in LD_effective_state.EFFECTIVE_STATE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_effective_state.Valid_For_Sale%type
	IS
		rcError styLD_effective_state;
	BEGIN

		rcError.EFFECTIVE_STATE_Id:=inuEFFECTIVE_STATE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEFFECTIVE_STATE_Id
			 )
		then
			 return(rcData.Valid_For_Sale);
		end if;
		Load
		(
			inuEFFECTIVE_STATE_Id
		);
		return(rcData.Valid_For_Sale);
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
end DALD_effective_state;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_EFFECTIVE_STATE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_EFFECTIVE_STATE', 'ADM_PERSON'); 
END;
/  
