CREATE OR REPLACE PACKAGE adm_person.dald_product_line
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
  )
  IS
		SELECT LD_product_line.*,LD_product_line.rowid
		FROM LD_product_line
		WHERE
			Product_Line_Id = inuProduct_Line_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_product_line.*,LD_product_line.rowid
		FROM LD_product_line
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_product_line  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_product_line is table of styLD_product_line index by binary_integer;
	type tyrfRecords is ref cursor return styLD_product_line;

	/* Tipos referenciando al registro */
	type tytbProduct_Line_Id is table of LD_product_line.Product_Line_Id%type index by binary_integer;
	type tytbDescription is table of LD_product_line.Description%type index by binary_integer;
	type tytbConcept_Id is table of LD_product_line.Concept_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_product_line is record
	(

		Product_Line_Id   tytbProduct_Line_Id,
		Description   tytbDescription,
		Concept_Id   tytbConcept_Id,
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
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	);

	PROCEDURE getRecord
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		orcRecord out nocopy styLD_product_line
	);

	FUNCTION frcGetRcData
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN styLD_product_line;

	FUNCTION frcGetRcData
	RETURN styLD_product_line;

	FUNCTION frcGetRecord
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN styLD_product_line;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_product_line
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_product_line in styLD_product_line
	);

 	  PROCEDURE insRecord
	(
		ircLD_product_line in styLD_product_line,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_product_line in out nocopy tytbLD_product_line
	);

	PROCEDURE delRecord
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_product_line in out nocopy tytbLD_product_line,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_product_line in styLD_product_line,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_product_line in out nocopy tytbLD_product_line,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuProduct_Line_Id   in LD_product_line.Product_Line_Id%type,
				isbDescription$  in LD_product_line.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updConcept_Id
		(
				inuProduct_Line_Id   in LD_product_line.Product_Line_Id%type,
				inuConcept_Id$  in LD_product_line.Concept_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetProduct_Line_Id
    	(
    	    inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_product_line.Product_Line_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_product_line.Description%type;

    	FUNCTION fnuGetConcept_Id
    	(
    	    inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_product_line.Concept_Id%type;


	PROCEDURE LockByPk
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		orcLD_product_line  out styLD_product_line
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_product_line  out styLD_product_line
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_product_line;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_product_line
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO147879';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PRODUCT_LINE';
	  cnuGeEntityId constant varchar2(30) := 1; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	IS
		SELECT LD_product_line.*,LD_product_line.rowid
		FROM LD_product_line
		WHERE  Product_Line_Id = inuProduct_Line_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_product_line.*,LD_product_line.rowid
		FROM LD_product_line
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_product_line is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_product_line;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_product_line default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Product_Line_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		orcLD_product_line  out styLD_product_line
	)
	IS
		rcError styLD_product_line;
	BEGIN
		rcError.Product_Line_Id := inuProduct_Line_Id;

		Open cuLockRcByPk
		(
			inuProduct_Line_Id
		);

		fetch cuLockRcByPk into orcLD_product_line;
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
		orcLD_product_line  out styLD_product_line
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_product_line;
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
		itbLD_product_line  in out nocopy tytbLD_product_line
	)
	IS
	BEGIN
			rcRecOfTab.Product_Line_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Concept_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_product_line  in out nocopy tytbLD_product_line,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_product_line);
		for n in itbLD_product_line.first .. itbLD_product_line.last loop
			rcRecOfTab.Product_Line_Id(n) := itbLD_product_line(n).Product_Line_Id;
			rcRecOfTab.Description(n) := itbLD_product_line(n).Description;
			rcRecOfTab.Concept_Id(n) := itbLD_product_line(n).Concept_Id;
			rcRecOfTab.row_id(n) := itbLD_product_line(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuProduct_Line_Id
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
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuProduct_Line_Id = rcData.Product_Line_Id
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
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuProduct_Line_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	IS
		rcError styLD_product_line;
	BEGIN		rcError.Product_Line_Id:=inuProduct_Line_Id;

		Load
		(
			inuProduct_Line_Id
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
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuProduct_Line_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		orcRecord out nocopy styLD_product_line
	)
	IS
		rcError styLD_product_line;
	BEGIN		rcError.Product_Line_Id:=inuProduct_Line_Id;

		Load
		(
			inuProduct_Line_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN styLD_product_line
	IS
		rcError styLD_product_line;
	BEGIN
		rcError.Product_Line_Id:=inuProduct_Line_Id;

		Load
		(
			inuProduct_Line_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type
	)
	RETURN styLD_product_line
	IS
		rcError styLD_product_line;
	BEGIN
		rcError.Product_Line_Id:=inuProduct_Line_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuProduct_Line_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuProduct_Line_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_product_line
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_product_line
	)
	IS
		rfLD_product_line tyrfLD_product_line;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_product_line.Product_Line_Id,
		            LD_product_line.Description,
		            LD_product_line.Concept_Id,
		            LD_product_line.rowid
                FROM LD_product_line';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_product_line for sbFullQuery;
		fetch rfLD_product_line bulk collect INTO otbResult;
		close rfLD_product_line;
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
		            LD_product_line.Product_Line_Id,
		            LD_product_line.Description,
		            LD_product_line.Concept_Id,
		            LD_product_line.rowid
                FROM LD_product_line';
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
		ircLD_product_line in styLD_product_line
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_product_line,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_product_line in styLD_product_line,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_product_line.Product_Line_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Product_Line_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_product_line
		(
			Product_Line_Id,
			Description,
			Concept_Id
		)
		values
		(
			ircLD_product_line.Product_Line_Id,
			ircLD_product_line.Description,
			ircLD_product_line.Concept_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_product_line));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_product_line in out nocopy tytbLD_product_line
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_product_line, blUseRowID);
		forall n in iotbLD_product_line.first..iotbLD_product_line.last
			insert into LD_product_line
			(
			Product_Line_Id,
			Description,
			Concept_Id
		)
		values
		(
			rcRecOfTab.Product_Line_Id(n),
			rcRecOfTab.Description(n),
			rcRecOfTab.Concept_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_product_line;
	BEGIN
		rcError.Product_Line_Id:=inuProduct_Line_Id;

		if inuLock=1 then
			LockByPk
			(
				inuProduct_Line_Id,
				rcData
			);
		end if;

		delete
		from LD_product_line
		where
       		Product_Line_Id=inuProduct_Line_Id;
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
		rcError  styLD_product_line;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_product_line
		where
			rowid = iriRowID
		returning
   Product_Line_Id
		into
			rcError.Product_Line_Id;

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
		iotbLD_product_line in out nocopy tytbLD_product_line,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_product_line;
	BEGIN
		FillRecordOfTables(iotbLD_product_line, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_product_line.first .. iotbLD_product_line.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_product_line.first .. iotbLD_product_line.last
				delete
				from LD_product_line
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_product_line.first .. iotbLD_product_line.last loop
					LockByPk
					(
							rcRecOfTab.Product_Line_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_product_line.first .. iotbLD_product_line.last
				delete
				from LD_product_line
				where
		         	Product_Line_Id = rcRecOfTab.Product_Line_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_product_line in styLD_product_line,
		inuLock	  in number default 0
	)
	IS
		nuProduct_Line_Id LD_product_line.Product_Line_Id%type;

	BEGIN
		if ircLD_product_line.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_product_line.rowid,rcData);
			end if;
			update LD_product_line
			set

        Description = ircLD_product_line.Description,
        Concept_Id = ircLD_product_line.Concept_Id
			where
				rowid = ircLD_product_line.rowid
			returning
    Product_Line_Id
			into
				nuProduct_Line_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_product_line.Product_Line_Id,
					rcData
				);
			end if;

			update LD_product_line
			set
        Description = ircLD_product_line.Description,
        Concept_Id = ircLD_product_line.Concept_Id
			where
	         	Product_Line_Id = ircLD_product_line.Product_Line_Id
			returning
    Product_Line_Id
			into
				nuProduct_Line_Id;
		end if;

		if
			nuProduct_Line_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_product_line));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_product_line in out nocopy tytbLD_product_line,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_product_line;
  BEGIN
    FillRecordOfTables(iotbLD_product_line,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_product_line.first .. iotbLD_product_line.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_product_line.first .. iotbLD_product_line.last
        update LD_product_line
        set

            Description = rcRecOfTab.Description(n),
            Concept_Id = rcRecOfTab.Concept_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_product_line.first .. iotbLD_product_line.last loop
          LockByPk
          (
              rcRecOfTab.Product_Line_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_product_line.first .. iotbLD_product_line.last
        update LD_product_line
        set
					Description = rcRecOfTab.Description(n),
					Concept_Id = rcRecOfTab.Concept_Id(n)
          where
          Product_Line_Id = rcRecOfTab.Product_Line_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		isbDescription$ in LD_product_line.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_product_line;
	BEGIN
		rcError.Product_Line_Id := inuProduct_Line_Id;
		if inuLock=1 then
			LockByPk
			(
				inuProduct_Line_Id,
				rcData
			);
		end if;

		update LD_product_line
		set
			Description = isbDescription$
		where
			Product_Line_Id = inuProduct_Line_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updConcept_Id
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		inuConcept_Id$ in LD_product_line.Concept_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_product_line;
	BEGIN
		rcError.Product_Line_Id := inuProduct_Line_Id;
		if inuLock=1 then
			LockByPk
			(
				inuProduct_Line_Id,
				rcData
			);
		end if;

		update LD_product_line
		set
			Concept_Id = inuConcept_Id$
		where
			Product_Line_Id = inuProduct_Line_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Concept_Id:= inuConcept_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetProduct_Line_Id
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_product_line.Product_Line_Id%type
	IS
		rcError styLD_product_line;
	BEGIN

		rcError.Product_Line_Id := inuProduct_Line_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuProduct_Line_Id
			 )
		then
			 return(rcData.Product_Line_Id);
		end if;
		Load
		(
			inuProduct_Line_Id
		);
		return(rcData.Product_Line_Id);
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
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_product_line.Description%type
	IS
		rcError styLD_product_line;
	BEGIN

		rcError.Product_Line_Id:=inuProduct_Line_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuProduct_Line_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuProduct_Line_Id
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

	FUNCTION fnuGetConcept_Id
	(
		inuProduct_Line_Id in LD_product_line.Product_Line_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_product_line.Concept_Id%type
	IS
		rcError styLD_product_line;
	BEGIN

		rcError.Product_Line_Id := inuProduct_Line_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuProduct_Line_Id
			 )
		then
			 return(rcData.Concept_Id);
		end if;
		Load
		(
			inuProduct_Line_Id
		);
		return(rcData.Concept_Id);
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
end DALD_product_line;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_PRODUCT_LINE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_PRODUCT_LINE', 'ADM_PERSON'); 
END;
/ 

