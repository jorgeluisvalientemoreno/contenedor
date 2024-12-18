CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_consult_codes
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
  )
  IS
		SELECT LD_consult_codes.*,LD_consult_codes.rowid
		FROM LD_consult_codes
		WHERE
			CONSULT_CODES_Id = inuCONSULT_CODES_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_consult_codes.*,LD_consult_codes.rowid
		FROM LD_consult_codes
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_consult_codes  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_consult_codes is table of styLD_consult_codes index by binary_integer;
	type tyrfRecords is ref cursor return styLD_consult_codes;

	/* Tipos referenciando al registro */
	type tytbConsult_Codes_Id is table of LD_consult_codes.Consult_Codes_Id%type index by binary_integer;
	type tytbDescription is table of LD_consult_codes.Description%type index by binary_integer;
	type tytbValid_For_Sale is table of LD_consult_codes.Valid_For_Sale%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_consult_codes is record
	(

		Consult_Codes_Id   tytbConsult_Codes_Id,
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	);

	PROCEDURE getRecord
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		orcRecord out nocopy styLD_consult_codes
	);

	FUNCTION frcGetRcData
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN styLD_consult_codes;

	FUNCTION frcGetRcData
	RETURN styLD_consult_codes;

	FUNCTION frcGetRecord
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN styLD_consult_codes;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_consult_codes
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_consult_codes in styLD_consult_codes
	);

 	  PROCEDURE insRecord
	(
		ircLD_consult_codes in styLD_consult_codes,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_consult_codes in out nocopy tytbLD_consult_codes
	);

	PROCEDURE delRecord
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_consult_codes in out nocopy tytbLD_consult_codes,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_consult_codes in styLD_consult_codes,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_consult_codes in out nocopy tytbLD_consult_codes,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuCONSULT_CODES_Id   in LD_consult_codes.CONSULT_CODES_Id%type,
				isbDescription$  in LD_consult_codes.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValid_For_Sale
		(
				inuCONSULT_CODES_Id   in LD_consult_codes.CONSULT_CODES_Id%type,
				isbValid_For_Sale$  in LD_consult_codes.Valid_For_Sale%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetConsult_Codes_Id
    	(
    	    inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_consult_codes.Consult_Codes_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_consult_codes.Description%type;

    	FUNCTION fsbGetValid_For_Sale
    	(
    	    inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_consult_codes.Valid_For_Sale%type;


	PROCEDURE LockByPk
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		orcLD_consult_codes  out styLD_consult_codes
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_consult_codes  out styLD_consult_codes
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_consult_codes;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_consult_codes
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO157446';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CONSULT_CODES';
	  cnuGeEntityId constant varchar2(30) := 8406; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	IS
		SELECT LD_consult_codes.*,LD_consult_codes.rowid
		FROM LD_consult_codes
		WHERE  CONSULT_CODES_Id = inuCONSULT_CODES_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_consult_codes.*,LD_consult_codes.rowid
		FROM LD_consult_codes
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_consult_codes is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_consult_codes;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_consult_codes default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSULT_CODES_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		orcLD_consult_codes  out styLD_consult_codes
	)
	IS
		rcError styLD_consult_codes;
	BEGIN
		rcError.CONSULT_CODES_Id := inuCONSULT_CODES_Id;

		Open cuLockRcByPk
		(
			inuCONSULT_CODES_Id
		);

		fetch cuLockRcByPk into orcLD_consult_codes;
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
		orcLD_consult_codes  out styLD_consult_codes
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_consult_codes;
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
		itbLD_consult_codes  in out nocopy tytbLD_consult_codes
	)
	IS
	BEGIN
			rcRecOfTab.Consult_Codes_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Valid_For_Sale.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_consult_codes  in out nocopy tytbLD_consult_codes,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_consult_codes);
		for n in itbLD_consult_codes.first .. itbLD_consult_codes.last loop
			rcRecOfTab.Consult_Codes_Id(n) := itbLD_consult_codes(n).Consult_Codes_Id;
			rcRecOfTab.Description(n) := itbLD_consult_codes(n).Description;
			rcRecOfTab.Valid_For_Sale(n) := itbLD_consult_codes(n).Valid_For_Sale;
			rcRecOfTab.row_id(n) := itbLD_consult_codes(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSULT_CODES_Id
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSULT_CODES_Id = rcData.CONSULT_CODES_Id
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSULT_CODES_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	IS
		rcError styLD_consult_codes;
	BEGIN		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;

		Load
		(
			inuCONSULT_CODES_Id
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSULT_CODES_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		orcRecord out nocopy styLD_consult_codes
	)
	IS
		rcError styLD_consult_codes;
	BEGIN		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;

		Load
		(
			inuCONSULT_CODES_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN styLD_consult_codes
	IS
		rcError styLD_consult_codes;
	BEGIN
		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;

		Load
		(
			inuCONSULT_CODES_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type
	)
	RETURN styLD_consult_codes
	IS
		rcError styLD_consult_codes;
	BEGIN
		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSULT_CODES_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSULT_CODES_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_consult_codes
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_consult_codes
	)
	IS
		rfLD_consult_codes tyrfLD_consult_codes;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_consult_codes.Consult_Codes_Id,
		            LD_consult_codes.Description,
		            LD_consult_codes.Valid_For_Sale,
		            LD_consult_codes.rowid
                FROM LD_consult_codes';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_consult_codes for sbFullQuery;
		fetch rfLD_consult_codes bulk collect INTO otbResult;
		close rfLD_consult_codes;
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
		            LD_consult_codes.Consult_Codes_Id,
		            LD_consult_codes.Description,
		            LD_consult_codes.Valid_For_Sale,
		            LD_consult_codes.rowid
                FROM LD_consult_codes';
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
		ircLD_consult_codes in styLD_consult_codes
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_consult_codes,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_consult_codes in styLD_consult_codes,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_consult_codes.CONSULT_CODES_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSULT_CODES_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_consult_codes
		(
			Consult_Codes_Id,
			Description,
			Valid_For_Sale
		)
		values
		(
			ircLD_consult_codes.Consult_Codes_Id,
			ircLD_consult_codes.Description,
			ircLD_consult_codes.Valid_For_Sale
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_consult_codes));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_consult_codes in out nocopy tytbLD_consult_codes
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_consult_codes, blUseRowID);
		forall n in iotbLD_consult_codes.first..iotbLD_consult_codes.last
			insert into LD_consult_codes
			(
			Consult_Codes_Id,
			Description,
			Valid_For_Sale
		)
		values
		(
			rcRecOfTab.Consult_Codes_Id(n),
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_consult_codes;
	BEGIN
		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;

		if inuLock=1 then
			LockByPk
			(
				inuCONSULT_CODES_Id,
				rcData
			);
		end if;

		delete
		from LD_consult_codes
		where
       		CONSULT_CODES_Id=inuCONSULT_CODES_Id;
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
		rcError  styLD_consult_codes;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_consult_codes
		where
			rowid = iriRowID
		returning
   CONSULT_CODES_Id
		into
			rcError.CONSULT_CODES_Id;

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
		iotbLD_consult_codes in out nocopy tytbLD_consult_codes,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_consult_codes;
	BEGIN
		FillRecordOfTables(iotbLD_consult_codes, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last
				delete
				from LD_consult_codes
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last loop
					LockByPk
					(
							rcRecOfTab.CONSULT_CODES_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last
				delete
				from LD_consult_codes
				where
		         	CONSULT_CODES_Id = rcRecOfTab.CONSULT_CODES_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_consult_codes in styLD_consult_codes,
		inuLock	  in number default 0
	)
	IS
		nuCONSULT_CODES_Id LD_consult_codes.CONSULT_CODES_Id%type;

	BEGIN
		if ircLD_consult_codes.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_consult_codes.rowid,rcData);
			end if;
			update LD_consult_codes
			set

        Description = ircLD_consult_codes.Description,
        Valid_For_Sale = ircLD_consult_codes.Valid_For_Sale
			where
				rowid = ircLD_consult_codes.rowid
			returning
    CONSULT_CODES_Id
			into
				nuCONSULT_CODES_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_consult_codes.CONSULT_CODES_Id,
					rcData
				);
			end if;

			update LD_consult_codes
			set
        Description = ircLD_consult_codes.Description,
        Valid_For_Sale = ircLD_consult_codes.Valid_For_Sale
			where
	         	CONSULT_CODES_Id = ircLD_consult_codes.CONSULT_CODES_Id
			returning
    CONSULT_CODES_Id
			into
				nuCONSULT_CODES_Id;
		end if;

		if
			nuCONSULT_CODES_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_consult_codes));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_consult_codes in out nocopy tytbLD_consult_codes,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_consult_codes;
  BEGIN
    FillRecordOfTables(iotbLD_consult_codes,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last
        update LD_consult_codes
        set

            Description = rcRecOfTab.Description(n),
            Valid_For_Sale = rcRecOfTab.Valid_For_Sale(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last loop
          LockByPk
          (
              rcRecOfTab.CONSULT_CODES_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_consult_codes.first .. iotbLD_consult_codes.last
        update LD_consult_codes
        set
					Description = rcRecOfTab.Description(n),
					Valid_For_Sale = rcRecOfTab.Valid_For_Sale(n)
          where
          CONSULT_CODES_Id = rcRecOfTab.CONSULT_CODES_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		isbDescription$ in LD_consult_codes.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_consult_codes;
	BEGIN
		rcError.CONSULT_CODES_Id := inuCONSULT_CODES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSULT_CODES_Id,
				rcData
			);
		end if;

		update LD_consult_codes
		set
			Description = isbDescription$
		where
			CONSULT_CODES_Id = inuCONSULT_CODES_Id;

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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		isbValid_For_Sale$ in LD_consult_codes.Valid_For_Sale%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_consult_codes;
	BEGIN
		rcError.CONSULT_CODES_Id := inuCONSULT_CODES_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONSULT_CODES_Id,
				rcData
			);
		end if;

		update LD_consult_codes
		set
			Valid_For_Sale = isbValid_For_Sale$
		where
			CONSULT_CODES_Id = inuCONSULT_CODES_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Valid_For_Sale:= isbValid_For_Sale$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetConsult_Codes_Id
	(
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_consult_codes.Consult_Codes_Id%type
	IS
		rcError styLD_consult_codes;
	BEGIN

		rcError.CONSULT_CODES_Id := inuCONSULT_CODES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSULT_CODES_Id
			 )
		then
			 return(rcData.Consult_Codes_Id);
		end if;
		Load
		(
			inuCONSULT_CODES_Id
		);
		return(rcData.Consult_Codes_Id);
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_consult_codes.Description%type
	IS
		rcError styLD_consult_codes;
	BEGIN

		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSULT_CODES_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuCONSULT_CODES_Id
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
		inuCONSULT_CODES_Id in LD_consult_codes.CONSULT_CODES_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_consult_codes.Valid_For_Sale%type
	IS
		rcError styLD_consult_codes;
	BEGIN

		rcError.CONSULT_CODES_Id:=inuCONSULT_CODES_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONSULT_CODES_Id
			 )
		then
			 return(rcData.Valid_For_Sale);
		end if;
		Load
		(
			inuCONSULT_CODES_Id
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
end DALD_consult_codes;
/
PROMPT Otorgando permisos de ejecucion a DALD_CONSULT_CODES
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_CONSULT_CODES', 'ADM_PERSON');
END;
/
