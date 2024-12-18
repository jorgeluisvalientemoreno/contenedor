CREATE OR REPLACE PACKAGE adm_person.dald_gender
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuGENDER_Id in LD_gender.GENDER_Id%type
  )
  IS
		SELECT LD_gender.*,LD_gender.rowid
		FROM LD_gender
		WHERE
			GENDER_Id = inuGENDER_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_gender.*,LD_gender.rowid
		FROM LD_gender
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_gender  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_gender is table of styLD_gender index by binary_integer;
	type tyrfRecords is ref cursor return styLD_gender;

	/* Tipos referenciando al registro */
	type tytbGender_Id is table of LD_gender.Gender_Id%type index by binary_integer;
	type tytbDescription is table of LD_gender.Description%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_gender is record
	(

		Gender_Id   tytbGender_Id,
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
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuGENDER_Id in LD_gender.GENDER_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuGENDER_Id in LD_gender.GENDER_Id%type
	);

	PROCEDURE getRecord
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		orcRecord out nocopy styLD_gender
	);

	FUNCTION frcGetRcData
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN styLD_gender;

	FUNCTION frcGetRcData
	RETURN styLD_gender;

	FUNCTION frcGetRecord
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN styLD_gender;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_gender
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_gender in styLD_gender
	);

 	  PROCEDURE insRecord
	(
		ircLD_gender in styLD_gender,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_gender in out nocopy tytbLD_gender
	);

	PROCEDURE delRecord
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_gender in out nocopy tytbLD_gender,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_gender in styLD_gender,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_gender in out nocopy tytbLD_gender,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuGENDER_Id   in LD_gender.GENDER_Id%type,
				isbDescription$  in LD_gender.Description%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetGender_Id
    	(
    	    inuGENDER_Id in LD_gender.GENDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_gender.Gender_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuGENDER_Id in LD_gender.GENDER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_gender.Description%type;


	PROCEDURE LockByPk
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		orcLD_gender  out styLD_gender
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_gender  out styLD_gender
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_gender;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_gender
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO157446';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_GENDER';
	  cnuGeEntityId constant varchar2(30) := 8408; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	IS
		SELECT LD_gender.*,LD_gender.rowid
		FROM LD_gender
		WHERE  GENDER_Id = inuGENDER_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_gender.*,LD_gender.rowid
		FROM LD_gender
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_gender is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_gender;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_gender default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.GENDER_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		orcLD_gender  out styLD_gender
	)
	IS
		rcError styLD_gender;
	BEGIN
		rcError.GENDER_Id := inuGENDER_Id;

		Open cuLockRcByPk
		(
			inuGENDER_Id
		);

		fetch cuLockRcByPk into orcLD_gender;
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
		orcLD_gender  out styLD_gender
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_gender;
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
		itbLD_gender  in out nocopy tytbLD_gender
	)
	IS
	BEGIN
			rcRecOfTab.Gender_Id.delete;
			rcRecOfTab.Description.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_gender  in out nocopy tytbLD_gender,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_gender);
		for n in itbLD_gender.first .. itbLD_gender.last loop
			rcRecOfTab.Gender_Id(n) := itbLD_gender(n).Gender_Id;
			rcRecOfTab.Description(n) := itbLD_gender(n).Description;
			rcRecOfTab.row_id(n) := itbLD_gender(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuGENDER_Id
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
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuGENDER_Id = rcData.GENDER_Id
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
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuGENDER_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	IS
		rcError styLD_gender;
	BEGIN		rcError.GENDER_Id:=inuGENDER_Id;

		Load
		(
			inuGENDER_Id
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
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuGENDER_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		orcRecord out nocopy styLD_gender
	)
	IS
		rcError styLD_gender;
	BEGIN		rcError.GENDER_Id:=inuGENDER_Id;

		Load
		(
			inuGENDER_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN styLD_gender
	IS
		rcError styLD_gender;
	BEGIN
		rcError.GENDER_Id:=inuGENDER_Id;

		Load
		(
			inuGENDER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type
	)
	RETURN styLD_gender
	IS
		rcError styLD_gender;
	BEGIN
		rcError.GENDER_Id:=inuGENDER_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuGENDER_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuGENDER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_gender
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_gender
	)
	IS
		rfLD_gender tyrfLD_gender;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_gender.Gender_Id,
		            LD_gender.Description,
		            LD_gender.rowid
                FROM LD_gender';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_gender for sbFullQuery;
		fetch rfLD_gender bulk collect INTO otbResult;
		close rfLD_gender;
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
		            LD_gender.Gender_Id,
		            LD_gender.Description,
		            LD_gender.rowid
                FROM LD_gender';
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
		ircLD_gender in styLD_gender
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_gender,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_gender in styLD_gender,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_gender.GENDER_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|GENDER_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_gender
		(
			Gender_Id,
			Description
		)
		values
		(
			ircLD_gender.Gender_Id,
			ircLD_gender.Description
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_gender));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_gender in out nocopy tytbLD_gender
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_gender, blUseRowID);
		forall n in iotbLD_gender.first..iotbLD_gender.last
			insert into LD_gender
			(
			Gender_Id,
			Description
		)
		values
		(
			rcRecOfTab.Gender_Id(n),
			rcRecOfTab.Description(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_gender;
	BEGIN
		rcError.GENDER_Id:=inuGENDER_Id;

		if inuLock=1 then
			LockByPk
			(
				inuGENDER_Id,
				rcData
			);
		end if;

		delete
		from LD_gender
		where
       		GENDER_Id=inuGENDER_Id;
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
		rcError  styLD_gender;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_gender
		where
			rowid = iriRowID
		returning
   GENDER_Id
		into
			rcError.GENDER_Id;

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
		iotbLD_gender in out nocopy tytbLD_gender,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_gender;
	BEGIN
		FillRecordOfTables(iotbLD_gender, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_gender.first .. iotbLD_gender.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_gender.first .. iotbLD_gender.last
				delete
				from LD_gender
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_gender.first .. iotbLD_gender.last loop
					LockByPk
					(
							rcRecOfTab.GENDER_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_gender.first .. iotbLD_gender.last
				delete
				from LD_gender
				where
		         	GENDER_Id = rcRecOfTab.GENDER_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_gender in styLD_gender,
		inuLock	  in number default 0
	)
	IS
		nuGENDER_Id LD_gender.GENDER_Id%type;

	BEGIN
		if ircLD_gender.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_gender.rowid,rcData);
			end if;
			update LD_gender
			set

        Description = ircLD_gender.Description
			where
				rowid = ircLD_gender.rowid
			returning
    GENDER_Id
			into
				nuGENDER_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_gender.GENDER_Id,
					rcData
				);
			end if;

			update LD_gender
			set
        Description = ircLD_gender.Description
			where
	         	GENDER_Id = ircLD_gender.GENDER_Id
			returning
    GENDER_Id
			into
				nuGENDER_Id;
		end if;

		if
			nuGENDER_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_gender));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_gender in out nocopy tytbLD_gender,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_gender;
  BEGIN
    FillRecordOfTables(iotbLD_gender,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_gender.first .. iotbLD_gender.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_gender.first .. iotbLD_gender.last
        update LD_gender
        set

            Description = rcRecOfTab.Description(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_gender.first .. iotbLD_gender.last loop
          LockByPk
          (
              rcRecOfTab.GENDER_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_gender.first .. iotbLD_gender.last
        update LD_gender
        set
					Description = rcRecOfTab.Description(n)
          where
          GENDER_Id = rcRecOfTab.GENDER_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		isbDescription$ in LD_gender.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_gender;
	BEGIN
		rcError.GENDER_Id := inuGENDER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuGENDER_Id,
				rcData
			);
		end if;

		update LD_gender
		set
			Description = isbDescription$
		where
			GENDER_Id = inuGENDER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetGender_Id
	(
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_gender.Gender_Id%type
	IS
		rcError styLD_gender;
	BEGIN

		rcError.GENDER_Id := inuGENDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuGENDER_Id
			 )
		then
			 return(rcData.Gender_Id);
		end if;
		Load
		(
			inuGENDER_Id
		);
		return(rcData.Gender_Id);
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
		inuGENDER_Id in LD_gender.GENDER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_gender.Description%type
	IS
		rcError styLD_gender;
	BEGIN

		rcError.GENDER_Id:=inuGENDER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuGENDER_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuGENDER_Id
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
end DALD_gender;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_GENDER
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_GENDER', 'ADM_PERSON'); 
END;
/ 
