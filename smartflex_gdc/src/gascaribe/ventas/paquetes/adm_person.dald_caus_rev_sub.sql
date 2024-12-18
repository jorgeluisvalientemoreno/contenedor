CREATE OR REPLACE PACKAGE adm_person.dald_caus_rev_sub
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
  )
  IS
		SELECT LD_caus_rev_sub.*,LD_caus_rev_sub.rowid
		FROM LD_caus_rev_sub
		WHERE
			CAUS_REV_SUB_Id = inuCAUS_REV_SUB_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_caus_rev_sub.*,LD_caus_rev_sub.rowid
		FROM LD_caus_rev_sub
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_caus_rev_sub  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_caus_rev_sub is table of styLD_caus_rev_sub index by binary_integer;
	type tyrfRecords is ref cursor return styLD_caus_rev_sub;

	/* Tipos referenciando al registro */
	type tytbCaus_Rev_Sub_Id is table of LD_caus_rev_sub.Caus_Rev_Sub_Id%type index by binary_integer;
	type tytbDescription is table of LD_caus_rev_sub.Description%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_caus_rev_sub is record
	(

		Caus_Rev_Sub_Id   tytbCaus_Rev_Sub_Id,
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
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	);

	PROCEDURE getRecord
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		orcRecord out nocopy styLD_caus_rev_sub
	);

	FUNCTION frcGetRcData
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN styLD_caus_rev_sub;

	FUNCTION frcGetRcData
	RETURN styLD_caus_rev_sub;

	FUNCTION frcGetRecord
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN styLD_caus_rev_sub;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_caus_rev_sub
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_caus_rev_sub in styLD_caus_rev_sub
	);

 	  PROCEDURE insRecord
	(
		ircLD_caus_rev_sub in styLD_caus_rev_sub,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_caus_rev_sub in out nocopy tytbLD_caus_rev_sub
	);

	PROCEDURE delRecord
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_caus_rev_sub in out nocopy tytbLD_caus_rev_sub,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_caus_rev_sub in styLD_caus_rev_sub,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_caus_rev_sub in out nocopy tytbLD_caus_rev_sub,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuCAUS_REV_SUB_Id   in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
				isbDescription$  in LD_caus_rev_sub.Description%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetCaus_Rev_Sub_Id
    	(
    	    inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_caus_rev_sub.Caus_Rev_Sub_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_caus_rev_sub.Description%type;


	PROCEDURE LockByPk
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		orcLD_caus_rev_sub  out styLD_caus_rev_sub
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_caus_rev_sub  out styLD_caus_rev_sub
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_caus_rev_sub;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_caus_rev_sub
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CAUS_REV_SUB';
	  cnuGeEntityId constant varchar2(30) := 8397; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	IS
		SELECT LD_caus_rev_sub.*,LD_caus_rev_sub.rowid
		FROM LD_caus_rev_sub
		WHERE  CAUS_REV_SUB_Id = inuCAUS_REV_SUB_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_caus_rev_sub.*,LD_caus_rev_sub.rowid
		FROM LD_caus_rev_sub
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_caus_rev_sub is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_caus_rev_sub;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_caus_rev_sub default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CAUS_REV_SUB_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		orcLD_caus_rev_sub  out styLD_caus_rev_sub
	)
	IS
		rcError styLD_caus_rev_sub;
	BEGIN
		rcError.CAUS_REV_SUB_Id := inuCAUS_REV_SUB_Id;

		Open cuLockRcByPk
		(
			inuCAUS_REV_SUB_Id
		);

		fetch cuLockRcByPk into orcLD_caus_rev_sub;
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
		orcLD_caus_rev_sub  out styLD_caus_rev_sub
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_caus_rev_sub;
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
		itbLD_caus_rev_sub  in out nocopy tytbLD_caus_rev_sub
	)
	IS
	BEGIN
			rcRecOfTab.Caus_Rev_Sub_Id.delete;
			rcRecOfTab.Description.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_caus_rev_sub  in out nocopy tytbLD_caus_rev_sub,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_caus_rev_sub);
		for n in itbLD_caus_rev_sub.first .. itbLD_caus_rev_sub.last loop
			rcRecOfTab.Caus_Rev_Sub_Id(n) := itbLD_caus_rev_sub(n).Caus_Rev_Sub_Id;
			rcRecOfTab.Description(n) := itbLD_caus_rev_sub(n).Description;
			rcRecOfTab.row_id(n) := itbLD_caus_rev_sub(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCAUS_REV_SUB_Id
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
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCAUS_REV_SUB_Id = rcData.CAUS_REV_SUB_Id
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
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCAUS_REV_SUB_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	IS
		rcError styLD_caus_rev_sub;
	BEGIN		rcError.CAUS_REV_SUB_Id:=inuCAUS_REV_SUB_Id;

		Load
		(
			inuCAUS_REV_SUB_Id
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
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuCAUS_REV_SUB_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		orcRecord out nocopy styLD_caus_rev_sub
	)
	IS
		rcError styLD_caus_rev_sub;
	BEGIN		rcError.CAUS_REV_SUB_Id:=inuCAUS_REV_SUB_Id;

		Load
		(
			inuCAUS_REV_SUB_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN styLD_caus_rev_sub
	IS
		rcError styLD_caus_rev_sub;
	BEGIN
		rcError.CAUS_REV_SUB_Id:=inuCAUS_REV_SUB_Id;

		Load
		(
			inuCAUS_REV_SUB_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type
	)
	RETURN styLD_caus_rev_sub
	IS
		rcError styLD_caus_rev_sub;
	BEGIN
		rcError.CAUS_REV_SUB_Id:=inuCAUS_REV_SUB_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUS_REV_SUB_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCAUS_REV_SUB_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_caus_rev_sub
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_caus_rev_sub
	)
	IS
		rfLD_caus_rev_sub tyrfLD_caus_rev_sub;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_caus_rev_sub.Caus_Rev_Sub_Id,
		            LD_caus_rev_sub.Description,
		            LD_caus_rev_sub.rowid
                FROM LD_caus_rev_sub';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_caus_rev_sub for sbFullQuery;
		fetch rfLD_caus_rev_sub bulk collect INTO otbResult;
		close rfLD_caus_rev_sub;
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
		            LD_caus_rev_sub.Caus_Rev_Sub_Id,
		            LD_caus_rev_sub.Description,
		            LD_caus_rev_sub.rowid
                FROM LD_caus_rev_sub';
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
		ircLD_caus_rev_sub in styLD_caus_rev_sub
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_caus_rev_sub,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_caus_rev_sub in styLD_caus_rev_sub,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_caus_rev_sub.CAUS_REV_SUB_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CAUS_REV_SUB_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_caus_rev_sub
		(
			Caus_Rev_Sub_Id,
			Description
		)
		values
		(
			ircLD_caus_rev_sub.Caus_Rev_Sub_Id,
			ircLD_caus_rev_sub.Description
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_caus_rev_sub));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_caus_rev_sub in out nocopy tytbLD_caus_rev_sub
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_caus_rev_sub, blUseRowID);
		forall n in iotbLD_caus_rev_sub.first..iotbLD_caus_rev_sub.last
			insert into LD_caus_rev_sub
			(
			Caus_Rev_Sub_Id,
			Description
		)
		values
		(
			rcRecOfTab.Caus_Rev_Sub_Id(n),
			rcRecOfTab.Description(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_caus_rev_sub;
	BEGIN
		rcError.CAUS_REV_SUB_Id:=inuCAUS_REV_SUB_Id;

		if inuLock=1 then
			LockByPk
			(
				inuCAUS_REV_SUB_Id,
				rcData
			);
		end if;

		delete
		from LD_caus_rev_sub
		where
       		CAUS_REV_SUB_Id=inuCAUS_REV_SUB_Id;
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
		rcError  styLD_caus_rev_sub;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_caus_rev_sub
		where
			rowid = iriRowID
		returning
   CAUS_REV_SUB_Id
		into
			rcError.CAUS_REV_SUB_Id;

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
		iotbLD_caus_rev_sub in out nocopy tytbLD_caus_rev_sub,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_caus_rev_sub;
	BEGIN
		FillRecordOfTables(iotbLD_caus_rev_sub, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last
				delete
				from LD_caus_rev_sub
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last loop
					LockByPk
					(
							rcRecOfTab.CAUS_REV_SUB_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last
				delete
				from LD_caus_rev_sub
				where
		         	CAUS_REV_SUB_Id = rcRecOfTab.CAUS_REV_SUB_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_caus_rev_sub in styLD_caus_rev_sub,
		inuLock	  in number default 0
	)
	IS
		nuCAUS_REV_SUB_Id LD_caus_rev_sub.CAUS_REV_SUB_Id%type;

	BEGIN
		if ircLD_caus_rev_sub.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_caus_rev_sub.rowid,rcData);
			end if;
			update LD_caus_rev_sub
			set

        Description = ircLD_caus_rev_sub.Description
			where
				rowid = ircLD_caus_rev_sub.rowid
			returning
    CAUS_REV_SUB_Id
			into
				nuCAUS_REV_SUB_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_caus_rev_sub.CAUS_REV_SUB_Id,
					rcData
				);
			end if;

			update LD_caus_rev_sub
			set
        Description = ircLD_caus_rev_sub.Description
			where
	         	CAUS_REV_SUB_Id = ircLD_caus_rev_sub.CAUS_REV_SUB_Id
			returning
    CAUS_REV_SUB_Id
			into
				nuCAUS_REV_SUB_Id;
		end if;

		if
			nuCAUS_REV_SUB_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_caus_rev_sub));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_caus_rev_sub in out nocopy tytbLD_caus_rev_sub,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_caus_rev_sub;
  BEGIN
    FillRecordOfTables(iotbLD_caus_rev_sub,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last
        update LD_caus_rev_sub
        set

            Description = rcRecOfTab.Description(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last loop
          LockByPk
          (
              rcRecOfTab.CAUS_REV_SUB_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_caus_rev_sub.first .. iotbLD_caus_rev_sub.last
        update LD_caus_rev_sub
        set
					Description = rcRecOfTab.Description(n)
          where
          CAUS_REV_SUB_Id = rcRecOfTab.CAUS_REV_SUB_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		isbDescription$ in LD_caus_rev_sub.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_caus_rev_sub;
	BEGIN
		rcError.CAUS_REV_SUB_Id := inuCAUS_REV_SUB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCAUS_REV_SUB_Id,
				rcData
			);
		end if;

		update LD_caus_rev_sub
		set
			Description = isbDescription$
		where
			CAUS_REV_SUB_Id = inuCAUS_REV_SUB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetCaus_Rev_Sub_Id
	(
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_caus_rev_sub.Caus_Rev_Sub_Id%type
	IS
		rcError styLD_caus_rev_sub;
	BEGIN

		rcError.CAUS_REV_SUB_Id := inuCAUS_REV_SUB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCAUS_REV_SUB_Id
			 )
		then
			 return(rcData.Caus_Rev_Sub_Id);
		end if;
		Load
		(
			inuCAUS_REV_SUB_Id
		);
		return(rcData.Caus_Rev_Sub_Id);
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
		inuCAUS_REV_SUB_Id in LD_caus_rev_sub.CAUS_REV_SUB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_caus_rev_sub.Description%type
	IS
		rcError styLD_caus_rev_sub;
	BEGIN

		rcError.CAUS_REV_SUB_Id:=inuCAUS_REV_SUB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCAUS_REV_SUB_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuCAUS_REV_SUB_Id
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
end DALD_caus_rev_sub;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CAUS_REV_SUB
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CAUS_REV_SUB', 'ADM_PERSON'); 
END;
/
