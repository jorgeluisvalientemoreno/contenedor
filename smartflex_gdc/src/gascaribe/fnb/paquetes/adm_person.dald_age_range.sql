CREATE OR REPLACE PACKAGE adm_person.dald_age_range
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
  )
  IS
		SELECT LD_age_range.*,LD_age_range.rowid
		FROM LD_age_range
		WHERE
			AGE_RANGE_Id = inuAGE_RANGE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_age_range.*,LD_age_range.rowid
		FROM LD_age_range
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_age_range  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_age_range is table of styLD_age_range index by binary_integer;
	type tyrfRecords is ref cursor return styLD_age_range;

	/* Tipos referenciando al registro */
	type tytbAge_Range_Id is table of LD_age_range.Age_Range_Id%type index by binary_integer;
	type tytbDescription is table of LD_age_range.Description%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_age_range is record
	(

		Age_Range_Id   tytbAge_Range_Id,
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
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	);

	PROCEDURE getRecord
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		orcRecord out nocopy styLD_age_range
	);

	FUNCTION frcGetRcData
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN styLD_age_range;

	FUNCTION frcGetRcData
	RETURN styLD_age_range;

	FUNCTION frcGetRecord
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN styLD_age_range;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_age_range
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_age_range in styLD_age_range
	);

 	  PROCEDURE insRecord
	(
		ircLD_age_range in styLD_age_range,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_age_range in out nocopy tytbLD_age_range
	);

	PROCEDURE delRecord
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_age_range in out nocopy tytbLD_age_range,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_age_range in styLD_age_range,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_age_range in out nocopy tytbLD_age_range,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuAGE_RANGE_Id   in LD_age_range.AGE_RANGE_Id%type,
				isbDescription$  in LD_age_range.Description%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetAge_Range_Id
    	(
    	    inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_age_range.Age_Range_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_age_range.Description%type;


	PROCEDURE LockByPk
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		orcLD_age_range  out styLD_age_range
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_age_range  out styLD_age_range
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_age_range;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_age_range
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO157446';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_AGE_RANGE';
	  cnuGeEntityId constant varchar2(30) := 8410; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	IS
		SELECT LD_age_range.*,LD_age_range.rowid
		FROM LD_age_range
		WHERE  AGE_RANGE_Id = inuAGE_RANGE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_age_range.*,LD_age_range.rowid
		FROM LD_age_range
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_age_range is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_age_range;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_age_range default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.AGE_RANGE_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		orcLD_age_range  out styLD_age_range
	)
	IS
		rcError styLD_age_range;
	BEGIN
		rcError.AGE_RANGE_Id := inuAGE_RANGE_Id;

		Open cuLockRcByPk
		(
			inuAGE_RANGE_Id
		);

		fetch cuLockRcByPk into orcLD_age_range;
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
		orcLD_age_range  out styLD_age_range
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_age_range;
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
		itbLD_age_range  in out nocopy tytbLD_age_range
	)
	IS
	BEGIN
			rcRecOfTab.Age_Range_Id.delete;
			rcRecOfTab.Description.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_age_range  in out nocopy tytbLD_age_range,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_age_range);
		for n in itbLD_age_range.first .. itbLD_age_range.last loop
			rcRecOfTab.Age_Range_Id(n) := itbLD_age_range(n).Age_Range_Id;
			rcRecOfTab.Description(n) := itbLD_age_range(n).Description;
			rcRecOfTab.row_id(n) := itbLD_age_range(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuAGE_RANGE_Id
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
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuAGE_RANGE_Id = rcData.AGE_RANGE_Id
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
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuAGE_RANGE_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	IS
		rcError styLD_age_range;
	BEGIN		rcError.AGE_RANGE_Id:=inuAGE_RANGE_Id;

		Load
		(
			inuAGE_RANGE_Id
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
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuAGE_RANGE_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		orcRecord out nocopy styLD_age_range
	)
	IS
		rcError styLD_age_range;
	BEGIN		rcError.AGE_RANGE_Id:=inuAGE_RANGE_Id;

		Load
		(
			inuAGE_RANGE_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN styLD_age_range
	IS
		rcError styLD_age_range;
	BEGIN
		rcError.AGE_RANGE_Id:=inuAGE_RANGE_Id;

		Load
		(
			inuAGE_RANGE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type
	)
	RETURN styLD_age_range
	IS
		rcError styLD_age_range;
	BEGIN
		rcError.AGE_RANGE_Id:=inuAGE_RANGE_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuAGE_RANGE_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuAGE_RANGE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_age_range
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_age_range
	)
	IS
		rfLD_age_range tyrfLD_age_range;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_age_range.Age_Range_Id,
		            LD_age_range.Description,
		            LD_age_range.rowid
                FROM LD_age_range';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_age_range for sbFullQuery;
		fetch rfLD_age_range bulk collect INTO otbResult;
		close rfLD_age_range;
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
		            LD_age_range.Age_Range_Id,
		            LD_age_range.Description,
		            LD_age_range.rowid
                FROM LD_age_range';
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
		ircLD_age_range in styLD_age_range
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_age_range,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_age_range in styLD_age_range,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_age_range.AGE_RANGE_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|AGE_RANGE_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_age_range
		(
			Age_Range_Id,
			Description
		)
		values
		(
			ircLD_age_range.Age_Range_Id,
			ircLD_age_range.Description
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_age_range));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_age_range in out nocopy tytbLD_age_range
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_age_range, blUseRowID);
		forall n in iotbLD_age_range.first..iotbLD_age_range.last
			insert into LD_age_range
			(
			Age_Range_Id,
			Description
		)
		values
		(
			rcRecOfTab.Age_Range_Id(n),
			rcRecOfTab.Description(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_age_range;
	BEGIN
		rcError.AGE_RANGE_Id:=inuAGE_RANGE_Id;

		if inuLock=1 then
			LockByPk
			(
				inuAGE_RANGE_Id,
				rcData
			);
		end if;

		delete
		from LD_age_range
		where
       		AGE_RANGE_Id=inuAGE_RANGE_Id;
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
		rcError  styLD_age_range;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_age_range
		where
			rowid = iriRowID
		returning
   AGE_RANGE_Id
		into
			rcError.AGE_RANGE_Id;

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
		iotbLD_age_range in out nocopy tytbLD_age_range,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_age_range;
	BEGIN
		FillRecordOfTables(iotbLD_age_range, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_age_range.first .. iotbLD_age_range.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_age_range.first .. iotbLD_age_range.last
				delete
				from LD_age_range
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_age_range.first .. iotbLD_age_range.last loop
					LockByPk
					(
							rcRecOfTab.AGE_RANGE_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_age_range.first .. iotbLD_age_range.last
				delete
				from LD_age_range
				where
		         	AGE_RANGE_Id = rcRecOfTab.AGE_RANGE_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_age_range in styLD_age_range,
		inuLock	  in number default 0
	)
	IS
		nuAGE_RANGE_Id LD_age_range.AGE_RANGE_Id%type;

	BEGIN
		if ircLD_age_range.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_age_range.rowid,rcData);
			end if;
			update LD_age_range
			set

        Description = ircLD_age_range.Description
			where
				rowid = ircLD_age_range.rowid
			returning
    AGE_RANGE_Id
			into
				nuAGE_RANGE_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_age_range.AGE_RANGE_Id,
					rcData
				);
			end if;

			update LD_age_range
			set
        Description = ircLD_age_range.Description
			where
	         	AGE_RANGE_Id = ircLD_age_range.AGE_RANGE_Id
			returning
    AGE_RANGE_Id
			into
				nuAGE_RANGE_Id;
		end if;

		if
			nuAGE_RANGE_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_age_range));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_age_range in out nocopy tytbLD_age_range,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_age_range;
  BEGIN
    FillRecordOfTables(iotbLD_age_range,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_age_range.first .. iotbLD_age_range.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_age_range.first .. iotbLD_age_range.last
        update LD_age_range
        set

            Description = rcRecOfTab.Description(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_age_range.first .. iotbLD_age_range.last loop
          LockByPk
          (
              rcRecOfTab.AGE_RANGE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_age_range.first .. iotbLD_age_range.last
        update LD_age_range
        set
					Description = rcRecOfTab.Description(n)
          where
          AGE_RANGE_Id = rcRecOfTab.AGE_RANGE_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		isbDescription$ in LD_age_range.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_age_range;
	BEGIN
		rcError.AGE_RANGE_Id := inuAGE_RANGE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuAGE_RANGE_Id,
				rcData
			);
		end if;

		update LD_age_range
		set
			Description = isbDescription$
		where
			AGE_RANGE_Id = inuAGE_RANGE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetAge_Range_Id
	(
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_age_range.Age_Range_Id%type
	IS
		rcError styLD_age_range;
	BEGIN

		rcError.AGE_RANGE_Id := inuAGE_RANGE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAGE_RANGE_Id
			 )
		then
			 return(rcData.Age_Range_Id);
		end if;
		Load
		(
			inuAGE_RANGE_Id
		);
		return(rcData.Age_Range_Id);
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
		inuAGE_RANGE_Id in LD_age_range.AGE_RANGE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_age_range.Description%type
	IS
		rcError styLD_age_range;
	BEGIN

		rcError.AGE_RANGE_Id:=inuAGE_RANGE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuAGE_RANGE_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuAGE_RANGE_Id
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
end DALD_age_range;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_AGE_RANGE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_AGE_RANGE', 'ADM_PERSON'); 
END;
/