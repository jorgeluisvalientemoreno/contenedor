CREATE OR REPLACE PACKAGE adm_person.dald_line
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuLINE_Id in LD_line.LINE_Id%type
  )
  IS
		SELECT LD_line.*,LD_line.rowid
		FROM LD_line
		WHERE
			LINE_Id = inuLINE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_line.*,LD_line.rowid
		FROM LD_line
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_line  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_line is table of styLD_line index by binary_integer;
	type tyrfRecords is ref cursor return styLD_line;

	/* Tipos referenciando al registro */
	type tytbLine_Id is table of LD_line.Line_Id%type index by binary_integer;
	type tytbDescription is table of LD_line.Description%type index by binary_integer;
	type tytbApproved is table of LD_line.Approved%type index by binary_integer;
	type tytbCondition_Approved is table of LD_line.Condition_Approved%type index by binary_integer;
	type tytbPerson_Id is table of LD_line.Person_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_line is record
	(

		Line_Id   tytbLine_Id,
		Description   tytbDescription,
		Approved   tytbApproved,
		Condition_Approved   tytbCondition_Approved,
		Person_Id   tytbPerson_Id,
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
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuLINE_Id in LD_line.LINE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuLINE_Id in LD_line.LINE_Id%type
	);

	PROCEDURE getRecord
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		orcRecord out nocopy styLD_line
	);

	FUNCTION frcGetRcData
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN styLD_line;

	FUNCTION frcGetRcData
	RETURN styLD_line;

	FUNCTION frcGetRecord
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN styLD_line;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_line
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_line in styLD_line
	);

 	  PROCEDURE insRecord
	(
		ircLD_line in styLD_line,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_line in out nocopy tytbLD_line
	);

	PROCEDURE delRecord
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_line in out nocopy tytbLD_line,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_line in styLD_line,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_line in out nocopy tytbLD_line,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuLINE_Id   in LD_line.LINE_Id%type,
				isbDescription$  in LD_line.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproved
		(
				inuLINE_Id   in LD_line.LINE_Id%type,
				isbApproved$  in LD_line.Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCondition_Approved
		(
				inuLINE_Id   in LD_line.LINE_Id%type,
				isbCondition_Approved$  in LD_line.Condition_Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPerson_Id
		(
				inuLINE_Id   in LD_line.LINE_Id%type,
				inuPerson_Id$  in LD_line.Person_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetLine_Id
    	(
    	    inuLINE_Id in LD_line.LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_line.Line_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuLINE_Id in LD_line.LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_line.Description%type;

    	FUNCTION fsbGetApproved
    	(
    	    inuLINE_Id in LD_line.LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_line.Approved%type;

    	FUNCTION fsbGetCondition_Approved
    	(
    	    inuLINE_Id in LD_line.LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_line.Condition_Approved%type;

    	FUNCTION fnuGetPerson_Id
    	(
    	    inuLINE_Id in LD_line.LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_line.Person_Id%type;


	PROCEDURE LockByPk
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		orcLD_line  out styLD_line
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_line  out styLD_line
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_line;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_line
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_LINE';
	  cnuGeEntityId constant varchar2(30) := 8366; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	IS
		SELECT LD_line.*,LD_line.rowid
		FROM LD_line
		WHERE  LINE_Id = inuLINE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_line.*,LD_line.rowid
		FROM LD_line
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_line is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_line;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_line default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LINE_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		orcLD_line  out styLD_line
	)
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id := inuLINE_Id;

		Open cuLockRcByPk
		(
			inuLINE_Id
		);

		fetch cuLockRcByPk into orcLD_line;
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
		orcLD_line  out styLD_line
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_line;
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
		itbLD_line  in out nocopy tytbLD_line
	)
	IS
	BEGIN
			rcRecOfTab.Line_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Approved.delete;
			rcRecOfTab.Condition_Approved.delete;
			rcRecOfTab.Person_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_line  in out nocopy tytbLD_line,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_line);
		for n in itbLD_line.first .. itbLD_line.last loop
			rcRecOfTab.Line_Id(n) := itbLD_line(n).Line_Id;
			rcRecOfTab.Description(n) := itbLD_line(n).Description;
			rcRecOfTab.Approved(n) := itbLD_line(n).Approved;
			rcRecOfTab.Condition_Approved(n) := itbLD_line(n).Condition_Approved;
			rcRecOfTab.Person_Id(n) := itbLD_line(n).Person_Id;
			rcRecOfTab.row_id(n) := itbLD_line(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLINE_Id
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
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLINE_Id = rcData.LINE_Id
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
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLINE_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	IS
		rcError styLD_line;
	BEGIN		rcError.LINE_Id:=inuLINE_Id;

		Load
		(
			inuLINE_Id
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
		inuLINE_Id in LD_line.LINE_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuLINE_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		orcRecord out nocopy styLD_line
	)
	IS
		rcError styLD_line;
	BEGIN		rcError.LINE_Id:=inuLINE_Id;

		Load
		(
			inuLINE_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN styLD_line
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id:=inuLINE_Id;

		Load
		(
			inuLINE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuLINE_Id in LD_line.LINE_Id%type
	)
	RETURN styLD_line
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id:=inuLINE_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLINE_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLINE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_line
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_line
	)
	IS
		rfLD_line tyrfLD_line;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_line.Line_Id,
		            LD_line.Description,
		            LD_line.Approved,
		            LD_line.Condition_Approved,
		            LD_line.Person_Id,
		            LD_line.rowid
                FROM LD_line';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_line for sbFullQuery;
		fetch rfLD_line bulk collect INTO otbResult;
		close rfLD_line;
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
		            LD_line.Line_Id,
		            LD_line.Description,
		            LD_line.Approved,
		            LD_line.Condition_Approved,
		            LD_line.Person_Id,
		            LD_line.rowid
                FROM LD_line';
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
		ircLD_line in styLD_line
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_line,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_line in styLD_line,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_line.LINE_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LINE_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_line
		(
			Line_Id,
			Description,
			Approved,
			Condition_Approved,
			Person_Id
		)
		values
		(
			ircLD_line.Line_Id,
			ircLD_line.Description,
			ircLD_line.Approved,
			ircLD_line.Condition_Approved,
			ircLD_line.Person_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_line));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_line in out nocopy tytbLD_line
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_line, blUseRowID);
		forall n in iotbLD_line.first..iotbLD_line.last
			insert into LD_line
			(
			Line_Id,
			Description,
			Approved,
			Condition_Approved,
			Person_Id
		)
		values
		(
			rcRecOfTab.Line_Id(n),
			rcRecOfTab.Description(n),
			rcRecOfTab.Approved(n),
			rcRecOfTab.Condition_Approved(n),
			rcRecOfTab.Person_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id:=inuLINE_Id;

		if inuLock=1 then
			LockByPk
			(
				inuLINE_Id,
				rcData
			);
		end if;

		delete
		from LD_line
		where
       		LINE_Id=inuLINE_Id;
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
		rcError  styLD_line;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_line
		where
			rowid = iriRowID
		returning
   LINE_Id
		into
			rcError.LINE_Id;

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
		iotbLD_line in out nocopy tytbLD_line,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_line;
	BEGIN
		FillRecordOfTables(iotbLD_line, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_line.first .. iotbLD_line.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_line.first .. iotbLD_line.last
				delete
				from LD_line
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_line.first .. iotbLD_line.last loop
					LockByPk
					(
							rcRecOfTab.LINE_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_line.first .. iotbLD_line.last
				delete
				from LD_line
				where
		         	LINE_Id = rcRecOfTab.LINE_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_line in styLD_line,
		inuLock	  in number default 0
	)
	IS
		nuLINE_Id LD_line.LINE_Id%type;

	BEGIN
		if ircLD_line.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_line.rowid,rcData);
			end if;
			update LD_line
			set

        Description = ircLD_line.Description,
        Approved = ircLD_line.Approved,
        Condition_Approved = ircLD_line.Condition_Approved,
        Person_Id = ircLD_line.Person_Id
			where
				rowid = ircLD_line.rowid
			returning
    LINE_Id
			into
				nuLINE_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_line.LINE_Id,
					rcData
				);
			end if;

			update LD_line
			set
        Description = ircLD_line.Description,
        Approved = ircLD_line.Approved,
        Condition_Approved = ircLD_line.Condition_Approved,
        Person_Id = ircLD_line.Person_Id
			where
	         	LINE_Id = ircLD_line.LINE_Id
			returning
    LINE_Id
			into
				nuLINE_Id;
		end if;

		if
			nuLINE_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_line));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_line in out nocopy tytbLD_line,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_line;
  BEGIN
    FillRecordOfTables(iotbLD_line,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_line.first .. iotbLD_line.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_line.first .. iotbLD_line.last
        update LD_line
        set

            Description = rcRecOfTab.Description(n),
            Approved = rcRecOfTab.Approved(n),
            Condition_Approved = rcRecOfTab.Condition_Approved(n),
            Person_Id = rcRecOfTab.Person_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_line.first .. iotbLD_line.last loop
          LockByPk
          (
              rcRecOfTab.LINE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_line.first .. iotbLD_line.last
        update LD_line
        set
					Description = rcRecOfTab.Description(n),
					Approved = rcRecOfTab.Approved(n),
					Condition_Approved = rcRecOfTab.Condition_Approved(n),
					Person_Id = rcRecOfTab.Person_Id(n)
          where
          LINE_Id = rcRecOfTab.LINE_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		isbDescription$ in LD_line.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id := inuLINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLINE_Id,
				rcData
			);
		end if;

		update LD_line
		set
			Description = isbDescription$
		where
			LINE_Id = inuLINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApproved
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		isbApproved$ in LD_line.Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id := inuLINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLINE_Id,
				rcData
			);
		end if;

		update LD_line
		set
			Approved = isbApproved$
		where
			LINE_Id = inuLINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Approved:= isbApproved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCondition_Approved
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		isbCondition_Approved$ in LD_line.Condition_Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id := inuLINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLINE_Id,
				rcData
			);
		end if;

		update LD_line
		set
			Condition_Approved = isbCondition_Approved$
		where
			LINE_Id = inuLINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Condition_Approved:= isbCondition_Approved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPerson_Id
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuPerson_Id$ in LD_line.Person_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_line;
	BEGIN
		rcError.LINE_Id := inuLINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLINE_Id,
				rcData
			);
		end if;

		update LD_line
		set
			Person_Id = inuPerson_Id$
		where
			LINE_Id = inuLINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Person_Id:= inuPerson_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetLine_Id
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_line.Line_Id%type
	IS
		rcError styLD_line;
	BEGIN

		rcError.LINE_Id := inuLINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLINE_Id
			 )
		then
			 return(rcData.Line_Id);
		end if;
		Load
		(
			inuLINE_Id
		);
		return(rcData.Line_Id);
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
		inuLINE_Id in LD_line.LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_line.Description%type
	IS
		rcError styLD_line;
	BEGIN

		rcError.LINE_Id:=inuLINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLINE_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuLINE_Id
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

	FUNCTION fsbGetApproved
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_line.Approved%type
	IS
		rcError styLD_line;
	BEGIN

		rcError.LINE_Id:=inuLINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLINE_Id
			 )
		then
			 return(rcData.Approved);
		end if;
		Load
		(
			inuLINE_Id
		);
		return(rcData.Approved);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetCondition_Approved
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_line.Condition_Approved%type
	IS
		rcError styLD_line;
	BEGIN

		rcError.LINE_Id:=inuLINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLINE_Id
			 )
		then
			 return(rcData.Condition_Approved);
		end if;
		Load
		(
			inuLINE_Id
		);
		return(rcData.Condition_Approved);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPerson_Id
	(
		inuLINE_Id in LD_line.LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_line.Person_Id%type
	IS
		rcError styLD_line;
	BEGIN

		rcError.LINE_Id := inuLINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLINE_Id
			 )
		then
			 return(rcData.Person_Id);
		end if;
		Load
		(
			inuLINE_Id
		);
		return(rcData.Person_Id);
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
end DALD_line;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_LINE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_LINE', 'ADM_PERSON'); 
END;
/