CREATE OR REPLACE PACKAGE adm_person.dald_document_type
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
  )
  IS
		SELECT LD_document_type.*,LD_document_type.rowid
		FROM LD_document_type
		WHERE
			DOCUMENT_TYPE_Id = inuDOCUMENT_TYPE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_document_type.*,LD_document_type.rowid
		FROM LD_document_type
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_document_type  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_document_type is table of styLD_document_type index by binary_integer;
	type tyrfRecords is ref cursor return styLD_document_type;

	/* Tipos referenciando al registro */
	type tytbDocument_Type_Id is table of LD_document_type.Document_Type_Id%type index by binary_integer;
	type tytbDoc_Type_Datacred is table of LD_document_type.Doc_Type_Datacred%type index by binary_integer;
	type tytbIdent_Type_Id is table of LD_document_type.Ident_Type_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_document_type is record
	(

		Document_Type_Id   tytbDocument_Type_Id,
		Doc_Type_Datacred   tytbDoc_Type_Datacred,
		Ident_Type_Id   tytbIdent_Type_Id,
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
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	);

	PROCEDURE getRecord
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		orcRecord out nocopy styLD_document_type
	);

	FUNCTION frcGetRcData
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN styLD_document_type;

	FUNCTION frcGetRcData
	RETURN styLD_document_type;

	FUNCTION frcGetRecord
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN styLD_document_type;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_document_type
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_document_type in styLD_document_type
	);

 	  PROCEDURE insRecord
	(
		ircLD_document_type in styLD_document_type,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_document_type in out nocopy tytbLD_document_type
	);

	PROCEDURE delRecord
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_document_type in out nocopy tytbLD_document_type,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_document_type in styLD_document_type,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_document_type in out nocopy tytbLD_document_type,
		inuLock in number default 1
	);

		PROCEDURE updDoc_Type_Datacred
		(
				inuDOCUMENT_TYPE_Id   in LD_document_type.DOCUMENT_TYPE_Id%type,
				inuDoc_Type_Datacred$  in LD_document_type.Doc_Type_Datacred%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updIdent_Type_Id
		(
				inuDOCUMENT_TYPE_Id   in LD_document_type.DOCUMENT_TYPE_Id%type,
				inuIdent_Type_Id$  in LD_document_type.Ident_Type_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetDocument_Type_Id
    	(
    	    inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_document_type.Document_Type_Id%type;

    	FUNCTION fnuGetDoc_Type_Datacred
    	(
    	    inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_document_type.Doc_Type_Datacred%type;

    	FUNCTION fnuGetIdent_Type_Id
    	(
    	    inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_document_type.Ident_Type_Id%type;


	PROCEDURE LockByPk
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		orcLD_document_type  out styLD_document_type
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_document_type  out styLD_document_type
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_document_type;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_document_type
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO157446';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DOCUMENT_TYPE';
	  cnuGeEntityId constant varchar2(30) := 8407; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	IS
		SELECT LD_document_type.*,LD_document_type.rowid
		FROM LD_document_type
		WHERE  DOCUMENT_TYPE_Id = inuDOCUMENT_TYPE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_document_type.*,LD_document_type.rowid
		FROM LD_document_type
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_document_type is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_document_type;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_document_type default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.DOCUMENT_TYPE_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		orcLD_document_type  out styLD_document_type
	)
	IS
		rcError styLD_document_type;
	BEGIN
		rcError.DOCUMENT_TYPE_Id := inuDOCUMENT_TYPE_Id;

		Open cuLockRcByPk
		(
			inuDOCUMENT_TYPE_Id
		);

		fetch cuLockRcByPk into orcLD_document_type;
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
		orcLD_document_type  out styLD_document_type
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_document_type;
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
		itbLD_document_type  in out nocopy tytbLD_document_type
	)
	IS
	BEGIN
			rcRecOfTab.Document_Type_Id.delete;
			rcRecOfTab.Doc_Type_Datacred.delete;
			rcRecOfTab.Ident_Type_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_document_type  in out nocopy tytbLD_document_type,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_document_type);
		for n in itbLD_document_type.first .. itbLD_document_type.last loop
			rcRecOfTab.Document_Type_Id(n) := itbLD_document_type(n).Document_Type_Id;
			rcRecOfTab.Doc_Type_Datacred(n) := itbLD_document_type(n).Doc_Type_Datacred;
			rcRecOfTab.Ident_Type_Id(n) := itbLD_document_type(n).Ident_Type_Id;
			rcRecOfTab.row_id(n) := itbLD_document_type(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuDOCUMENT_TYPE_Id
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
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuDOCUMENT_TYPE_Id = rcData.DOCUMENT_TYPE_Id
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
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	IS
		rcError styLD_document_type;
	BEGIN		rcError.DOCUMENT_TYPE_Id:=inuDOCUMENT_TYPE_Id;

		Load
		(
			inuDOCUMENT_TYPE_Id
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
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		orcRecord out nocopy styLD_document_type
	)
	IS
		rcError styLD_document_type;
	BEGIN		rcError.DOCUMENT_TYPE_Id:=inuDOCUMENT_TYPE_Id;

		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN styLD_document_type
	IS
		rcError styLD_document_type;
	BEGIN
		rcError.DOCUMENT_TYPE_Id:=inuDOCUMENT_TYPE_Id;

		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type
	)
	RETURN styLD_document_type
	IS
		rcError styLD_document_type;
	BEGIN
		rcError.DOCUMENT_TYPE_Id:=inuDOCUMENT_TYPE_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDOCUMENT_TYPE_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_document_type
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_document_type
	)
	IS
		rfLD_document_type tyrfLD_document_type;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_document_type.Document_Type_Id,
		            LD_document_type.Doc_Type_Datacred,
		            LD_document_type.Ident_Type_Id,
		            LD_document_type.rowid
                FROM LD_document_type';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_document_type for sbFullQuery;
		fetch rfLD_document_type bulk collect INTO otbResult;
		close rfLD_document_type;
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
		            LD_document_type.Document_Type_Id,
		            LD_document_type.Doc_Type_Datacred,
		            LD_document_type.Ident_Type_Id,
		            LD_document_type.rowid
                FROM LD_document_type';
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
		ircLD_document_type in styLD_document_type
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_document_type,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_document_type in styLD_document_type,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_document_type.DOCUMENT_TYPE_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|DOCUMENT_TYPE_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_document_type
		(
			Document_Type_Id,
			Doc_Type_Datacred,
			Ident_Type_Id
		)
		values
		(
			ircLD_document_type.Document_Type_Id,
			ircLD_document_type.Doc_Type_Datacred,
			ircLD_document_type.Ident_Type_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_document_type));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_document_type in out nocopy tytbLD_document_type
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_document_type, blUseRowID);
		forall n in iotbLD_document_type.first..iotbLD_document_type.last
			insert into LD_document_type
			(
			Document_Type_Id,
			Doc_Type_Datacred,
			Ident_Type_Id
		)
		values
		(
			rcRecOfTab.Document_Type_Id(n),
			rcRecOfTab.Doc_Type_Datacred(n),
			rcRecOfTab.Ident_Type_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_document_type;
	BEGIN
		rcError.DOCUMENT_TYPE_Id:=inuDOCUMENT_TYPE_Id;

		if inuLock=1 then
			LockByPk
			(
				inuDOCUMENT_TYPE_Id,
				rcData
			);
		end if;

		delete
		from LD_document_type
		where
       		DOCUMENT_TYPE_Id=inuDOCUMENT_TYPE_Id;
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
		rcError  styLD_document_type;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_document_type
		where
			rowid = iriRowID
		returning
   DOCUMENT_TYPE_Id
		into
			rcError.DOCUMENT_TYPE_Id;

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
		iotbLD_document_type in out nocopy tytbLD_document_type,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_document_type;
	BEGIN
		FillRecordOfTables(iotbLD_document_type, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_document_type.first .. iotbLD_document_type.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_document_type.first .. iotbLD_document_type.last
				delete
				from LD_document_type
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_document_type.first .. iotbLD_document_type.last loop
					LockByPk
					(
							rcRecOfTab.DOCUMENT_TYPE_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_document_type.first .. iotbLD_document_type.last
				delete
				from LD_document_type
				where
		         	DOCUMENT_TYPE_Id = rcRecOfTab.DOCUMENT_TYPE_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_document_type in styLD_document_type,
		inuLock	  in number default 0
	)
	IS
		nuDOCUMENT_TYPE_Id LD_document_type.DOCUMENT_TYPE_Id%type;

	BEGIN
		if ircLD_document_type.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_document_type.rowid,rcData);
			end if;
			update LD_document_type
			set

        Doc_Type_Datacred = ircLD_document_type.Doc_Type_Datacred,
        Ident_Type_Id = ircLD_document_type.Ident_Type_Id
			where
				rowid = ircLD_document_type.rowid
			returning
    DOCUMENT_TYPE_Id
			into
				nuDOCUMENT_TYPE_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_document_type.DOCUMENT_TYPE_Id,
					rcData
				);
			end if;

			update LD_document_type
			set
        Doc_Type_Datacred = ircLD_document_type.Doc_Type_Datacred,
        Ident_Type_Id = ircLD_document_type.Ident_Type_Id
			where
	         	DOCUMENT_TYPE_Id = ircLD_document_type.DOCUMENT_TYPE_Id
			returning
    DOCUMENT_TYPE_Id
			into
				nuDOCUMENT_TYPE_Id;
		end if;

		if
			nuDOCUMENT_TYPE_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_document_type));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_document_type in out nocopy tytbLD_document_type,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_document_type;
  BEGIN
    FillRecordOfTables(iotbLD_document_type,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_document_type.first .. iotbLD_document_type.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_document_type.first .. iotbLD_document_type.last
        update LD_document_type
        set

            Doc_Type_Datacred = rcRecOfTab.Doc_Type_Datacred(n),
            Ident_Type_Id = rcRecOfTab.Ident_Type_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_document_type.first .. iotbLD_document_type.last loop
          LockByPk
          (
              rcRecOfTab.DOCUMENT_TYPE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_document_type.first .. iotbLD_document_type.last
        update LD_document_type
        set
					Doc_Type_Datacred = rcRecOfTab.Doc_Type_Datacred(n),
					Ident_Type_Id = rcRecOfTab.Ident_Type_Id(n)
          where
          DOCUMENT_TYPE_Id = rcRecOfTab.DOCUMENT_TYPE_Id(n)
;
    end if;
  END;

	PROCEDURE updDoc_Type_Datacred
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuDoc_Type_Datacred$ in LD_document_type.Doc_Type_Datacred%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_document_type;
	BEGIN
		rcError.DOCUMENT_TYPE_Id := inuDOCUMENT_TYPE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDOCUMENT_TYPE_Id,
				rcData
			);
		end if;

		update LD_document_type
		set
			Doc_Type_Datacred = inuDoc_Type_Datacred$
		where
			DOCUMENT_TYPE_Id = inuDOCUMENT_TYPE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Doc_Type_Datacred:= inuDoc_Type_Datacred$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updIdent_Type_Id
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuIdent_Type_Id$ in LD_document_type.Ident_Type_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_document_type;
	BEGIN
		rcError.DOCUMENT_TYPE_Id := inuDOCUMENT_TYPE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDOCUMENT_TYPE_Id,
				rcData
			);
		end if;

		update LD_document_type
		set
			Ident_Type_Id = inuIdent_Type_Id$
		where
			DOCUMENT_TYPE_Id = inuDOCUMENT_TYPE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Ident_Type_Id:= inuIdent_Type_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetDocument_Type_Id
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_document_type.Document_Type_Id%type
	IS
		rcError styLD_document_type;
	BEGIN

		rcError.DOCUMENT_TYPE_Id := inuDOCUMENT_TYPE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDOCUMENT_TYPE_Id
			 )
		then
			 return(rcData.Document_Type_Id);
		end if;
		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		return(rcData.Document_Type_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetDoc_Type_Datacred
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_document_type.Doc_Type_Datacred%type
	IS
		rcError styLD_document_type;
	BEGIN

		rcError.DOCUMENT_TYPE_Id := inuDOCUMENT_TYPE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDOCUMENT_TYPE_Id
			 )
		then
			 return(rcData.Doc_Type_Datacred);
		end if;
		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		return(rcData.Doc_Type_Datacred);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetIdent_Type_Id
	(
		inuDOCUMENT_TYPE_Id in LD_document_type.DOCUMENT_TYPE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_document_type.Ident_Type_Id%type
	IS
		rcError styLD_document_type;
	BEGIN

		rcError.DOCUMENT_TYPE_Id := inuDOCUMENT_TYPE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDOCUMENT_TYPE_Id
			 )
		then
			 return(rcData.Ident_Type_Id);
		end if;
		Load
		(
			inuDOCUMENT_TYPE_Id
		);
		return(rcData.Ident_Type_Id);
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
end DALD_document_type;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_DOCUMENT_TYPE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_DOCUMENT_TYPE', 'ADM_PERSON'); 
END;
/