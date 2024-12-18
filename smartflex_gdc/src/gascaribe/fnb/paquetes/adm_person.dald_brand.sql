CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_brand
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
		inuBRAND_Id in LD_brand.BRAND_Id%type
  )
  IS
		SELECT LD_brand.*,LD_brand.rowid
		FROM LD_brand
		WHERE
			BRAND_Id = inuBRAND_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_brand.*,LD_brand.rowid
		FROM LD_brand
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_brand  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_brand is table of styLD_brand index by binary_integer;
	type tyrfRecords is ref cursor return styLD_brand;

	/* Tipos referenciando al registro */
	type tytbBrand_Id is table of LD_brand.Brand_Id%type index by binary_integer;
	type tytbDescription is table of LD_brand.Description%type index by binary_integer;
	type tytbApproved is table of LD_brand.Approved%type index by binary_integer;
	type tytbCondition_Approved is table of LD_brand.Condition_Approved%type index by binary_integer;
	type tytbPerson_Id is table of LD_brand.Person_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_brand is record
	(

		Brand_Id   tytbBrand_Id,
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
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuBRAND_Id in LD_brand.BRAND_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuBRAND_Id in LD_brand.BRAND_Id%type
	);

	PROCEDURE getRecord
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		orcRecord out nocopy styLD_brand
	);

	FUNCTION frcGetRcData
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN styLD_brand;

	FUNCTION frcGetRcData
	RETURN styLD_brand;

	FUNCTION frcGetRecord
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN styLD_brand;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_brand
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_brand in styLD_brand
	);

 	  PROCEDURE insRecord
	(
		ircLD_brand in styLD_brand,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_brand in out nocopy tytbLD_brand
	);

	PROCEDURE delRecord
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_brand in out nocopy tytbLD_brand,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_brand in styLD_brand,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_brand in out nocopy tytbLD_brand,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuBRAND_Id   in LD_brand.BRAND_Id%type,
				isbDescription$  in LD_brand.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproved
		(
				inuBRAND_Id   in LD_brand.BRAND_Id%type,
				isbApproved$  in LD_brand.Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCondition_Approved
		(
				inuBRAND_Id   in LD_brand.BRAND_Id%type,
				isbCondition_Approved$  in LD_brand.Condition_Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPerson_Id
		(
				inuBRAND_Id   in LD_brand.BRAND_Id%type,
				inuPerson_Id$  in LD_brand.Person_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetBrand_Id
    	(
    	    inuBRAND_Id in LD_brand.BRAND_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_brand.Brand_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuBRAND_Id in LD_brand.BRAND_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_brand.Description%type;

    	FUNCTION fsbGetApproved
    	(
    	    inuBRAND_Id in LD_brand.BRAND_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_brand.Approved%type;

    	FUNCTION fsbGetCondition_Approved
    	(
    	    inuBRAND_Id in LD_brand.BRAND_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_brand.Condition_Approved%type;

    	FUNCTION fnuGetPerson_Id
    	(
    	    inuBRAND_Id in LD_brand.BRAND_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_brand.Person_Id%type;


	PROCEDURE LockByPk
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		orcLD_brand  out styLD_brand
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_brand  out styLD_brand
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_brand;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_brand
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_BRAND';
	  cnuGeEntityId constant varchar2(30) := 8371; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	IS
		SELECT LD_brand.*,LD_brand.rowid
		FROM LD_brand
		WHERE  BRAND_Id = inuBRAND_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_brand.*,LD_brand.rowid
		FROM LD_brand
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_brand is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_brand;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_brand default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BRAND_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		orcLD_brand  out styLD_brand
	)
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id := inuBRAND_Id;

		Open cuLockRcByPk
		(
			inuBRAND_Id
		);

		fetch cuLockRcByPk into orcLD_brand;
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
		orcLD_brand  out styLD_brand
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_brand;
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
		itbLD_brand  in out nocopy tytbLD_brand
	)
	IS
	BEGIN
			rcRecOfTab.Brand_Id.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Approved.delete;
			rcRecOfTab.Condition_Approved.delete;
			rcRecOfTab.Person_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_brand  in out nocopy tytbLD_brand,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_brand);
		for n in itbLD_brand.first .. itbLD_brand.last loop
			rcRecOfTab.Brand_Id(n) := itbLD_brand(n).Brand_Id;
			rcRecOfTab.Description(n) := itbLD_brand(n).Description;
			rcRecOfTab.Approved(n) := itbLD_brand(n).Approved;
			rcRecOfTab.Condition_Approved(n) := itbLD_brand(n).Condition_Approved;
			rcRecOfTab.Person_Id(n) := itbLD_brand(n).Person_Id;
			rcRecOfTab.row_id(n) := itbLD_brand(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBRAND_Id
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
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBRAND_Id = rcData.BRAND_Id
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
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBRAND_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	IS
		rcError styLD_brand;
	BEGIN		rcError.BRAND_Id:=inuBRAND_Id;

		Load
		(
			inuBRAND_Id
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
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuBRAND_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		orcRecord out nocopy styLD_brand
	)
	IS
		rcError styLD_brand;
	BEGIN		rcError.BRAND_Id:=inuBRAND_Id;

		Load
		(
			inuBRAND_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN styLD_brand
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id:=inuBRAND_Id;

		Load
		(
			inuBRAND_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type
	)
	RETURN styLD_brand
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id:=inuBRAND_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBRAND_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBRAND_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_brand
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_brand
	)
	IS
		rfLD_brand tyrfLD_brand;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_brand.Brand_Id,
		            LD_brand.Description,
		            LD_brand.Approved,
		            LD_brand.Condition_Approved,
		            LD_brand.Person_Id,
		            LD_brand.rowid
                FROM LD_brand';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_brand for sbFullQuery;
		fetch rfLD_brand bulk collect INTO otbResult;
		close rfLD_brand;
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
		            LD_brand.Brand_Id,
		            LD_brand.Description,
		            LD_brand.Approved,
		            LD_brand.Condition_Approved,
		            LD_brand.Person_Id,
		            LD_brand.rowid
                FROM LD_brand';
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
		ircLD_brand in styLD_brand
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_brand,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_brand in styLD_brand,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_brand.BRAND_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BRAND_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_brand
		(
			Brand_Id,
			Description,
			Approved,
			Condition_Approved,
			Person_Id
		)
		values
		(
			ircLD_brand.Brand_Id,
			ircLD_brand.Description,
			ircLD_brand.Approved,
			ircLD_brand.Condition_Approved,
			ircLD_brand.Person_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_brand));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_brand in out nocopy tytbLD_brand
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_brand, blUseRowID);
		forall n in iotbLD_brand.first..iotbLD_brand.last
			insert into LD_brand
			(
			Brand_Id,
			Description,
			Approved,
			Condition_Approved,
			Person_Id
		)
		values
		(
			rcRecOfTab.Brand_Id(n),
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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id:=inuBRAND_Id;

		if inuLock=1 then
			LockByPk
			(
				inuBRAND_Id,
				rcData
			);
		end if;

		delete
		from LD_brand
		where
       		BRAND_Id=inuBRAND_Id;
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
		rcError  styLD_brand;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_brand
		where
			rowid = iriRowID
		returning
   BRAND_Id
		into
			rcError.BRAND_Id;

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
		iotbLD_brand in out nocopy tytbLD_brand,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_brand;
	BEGIN
		FillRecordOfTables(iotbLD_brand, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_brand.first .. iotbLD_brand.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_brand.first .. iotbLD_brand.last
				delete
				from LD_brand
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_brand.first .. iotbLD_brand.last loop
					LockByPk
					(
							rcRecOfTab.BRAND_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_brand.first .. iotbLD_brand.last
				delete
				from LD_brand
				where
		         	BRAND_Id = rcRecOfTab.BRAND_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_brand in styLD_brand,
		inuLock	  in number default 0
	)
	IS
		nuBRAND_Id LD_brand.BRAND_Id%type;

	BEGIN
		if ircLD_brand.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_brand.rowid,rcData);
			end if;
			update LD_brand
			set

        Description = ircLD_brand.Description,
        Approved = ircLD_brand.Approved,
        Condition_Approved = ircLD_brand.Condition_Approved,
        Person_Id = ircLD_brand.Person_Id
			where
				rowid = ircLD_brand.rowid
			returning
    BRAND_Id
			into
				nuBRAND_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_brand.BRAND_Id,
					rcData
				);
			end if;

			update LD_brand
			set
        Description = ircLD_brand.Description,
        Approved = ircLD_brand.Approved,
        Condition_Approved = ircLD_brand.Condition_Approved,
        Person_Id = ircLD_brand.Person_Id
			where
	         	BRAND_Id = ircLD_brand.BRAND_Id
			returning
    BRAND_Id
			into
				nuBRAND_Id;
		end if;

		if
			nuBRAND_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_brand));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_brand in out nocopy tytbLD_brand,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_brand;
  BEGIN
    FillRecordOfTables(iotbLD_brand,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_brand.first .. iotbLD_brand.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_brand.first .. iotbLD_brand.last
        update LD_brand
        set

            Description = rcRecOfTab.Description(n),
            Approved = rcRecOfTab.Approved(n),
            Condition_Approved = rcRecOfTab.Condition_Approved(n),
            Person_Id = rcRecOfTab.Person_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_brand.first .. iotbLD_brand.last loop
          LockByPk
          (
              rcRecOfTab.BRAND_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_brand.first .. iotbLD_brand.last
        update LD_brand
        set
					Description = rcRecOfTab.Description(n),
					Approved = rcRecOfTab.Approved(n),
					Condition_Approved = rcRecOfTab.Condition_Approved(n),
					Person_Id = rcRecOfTab.Person_Id(n)
          where
          BRAND_Id = rcRecOfTab.BRAND_Id(n)
;
    end if;
  END;

	PROCEDURE updDescription
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		isbDescription$ in LD_brand.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id := inuBRAND_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBRAND_Id,
				rcData
			);
		end if;

		update LD_brand
		set
			Description = isbDescription$
		where
			BRAND_Id = inuBRAND_Id;

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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		isbApproved$ in LD_brand.Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id := inuBRAND_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBRAND_Id,
				rcData
			);
		end if;

		update LD_brand
		set
			Approved = isbApproved$
		where
			BRAND_Id = inuBRAND_Id;

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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		isbCondition_Approved$ in LD_brand.Condition_Approved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id := inuBRAND_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBRAND_Id,
				rcData
			);
		end if;

		update LD_brand
		set
			Condition_Approved = isbCondition_Approved$
		where
			BRAND_Id = inuBRAND_Id;

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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuPerson_Id$ in LD_brand.Person_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_brand;
	BEGIN
		rcError.BRAND_Id := inuBRAND_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBRAND_Id,
				rcData
			);
		end if;

		update LD_brand
		set
			Person_Id = inuPerson_Id$
		where
			BRAND_Id = inuBRAND_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Person_Id:= inuPerson_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetBrand_Id
	(
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_brand.Brand_Id%type
	IS
		rcError styLD_brand;
	BEGIN

		rcError.BRAND_Id := inuBRAND_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBRAND_Id
			 )
		then
			 return(rcData.Brand_Id);
		end if;
		Load
		(
			inuBRAND_Id
		);
		return(rcData.Brand_Id);
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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_brand.Description%type
	IS
		rcError styLD_brand;
	BEGIN

		rcError.BRAND_Id:=inuBRAND_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBRAND_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuBRAND_Id
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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_brand.Approved%type
	IS
		rcError styLD_brand;
	BEGIN

		rcError.BRAND_Id:=inuBRAND_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBRAND_Id
			 )
		then
			 return(rcData.Approved);
		end if;
		Load
		(
			inuBRAND_Id
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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_brand.Condition_Approved%type
	IS
		rcError styLD_brand;
	BEGIN

		rcError.BRAND_Id:=inuBRAND_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBRAND_Id
			 )
		then
			 return(rcData.Condition_Approved);
		end if;
		Load
		(
			inuBRAND_Id
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
		inuBRAND_Id in LD_brand.BRAND_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_brand.Person_Id%type
	IS
		rcError styLD_brand;
	BEGIN

		rcError.BRAND_Id := inuBRAND_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBRAND_Id
			 )
		then
			 return(rcData.Person_Id);
		end if;
		Load
		(
			inuBRAND_Id
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
end DALD_brand;
/
PROMPT Otorgando permisos de ejecucion a DALD_BRAND
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_BRAND', 'ADM_PERSON');
END;
/