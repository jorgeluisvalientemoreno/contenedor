CREATE OR REPLACE PACKAGE adm_person.DALD_renewall_securp
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_REP_INCO_SUB
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
  )
  IS
		SELECT LD_renewall_securp.*,LD_renewall_securp.rowid
		FROM LD_renewall_securp
		WHERE
			Renewall_Securp_Id = inuRenewall_Securp_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_renewall_securp.*,LD_renewall_securp.rowid
		FROM LD_renewall_securp
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_renewall_securp  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_renewall_securp is table of styLD_renewall_securp index by binary_integer;
	type tyrfRecords is ref cursor return styLD_renewall_securp;

	/* Tipos referenciando al registro */
	type tytbRenewall_Securp_Id is table of LD_renewall_securp.Renewall_Securp_Id%type index by binary_integer;
	type tytbPolicy_Id is table of LD_renewall_securp.Policy_Id%type index by binary_integer;
	type tytbContract_Id is table of LD_renewall_securp.Contract_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_renewall_securp is record
	(

		Renewall_Securp_Id   tytbRenewall_Securp_Id,
		Policy_Id   tytbPolicy_Id,
		Contract_Id   tytbContract_Id,
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
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	);

	PROCEDURE getRecord
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		orcRecord out nocopy styLD_renewall_securp
	);

	FUNCTION frcGetRcData
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN styLD_renewall_securp;

	FUNCTION frcGetRcData
	RETURN styLD_renewall_securp;

	FUNCTION frcGetRecord
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN styLD_renewall_securp;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_renewall_securp
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_renewall_securp in styLD_renewall_securp
	);

 	  PROCEDURE insRecord
	(
		ircLD_renewall_securp in styLD_renewall_securp,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_renewall_securp in out nocopy tytbLD_renewall_securp
	);

	PROCEDURE delRecord
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_renewall_securp in out nocopy tytbLD_renewall_securp,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_renewall_securp in styLD_renewall_securp,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_renewall_securp in out nocopy tytbLD_renewall_securp,
		inuLock in number default 1
	);

		PROCEDURE updPolicy_Id
		(
				inuRenewall_Securp_Id   in LD_renewall_securp.Renewall_Securp_Id%type,
				inuPolicy_Id$  in LD_renewall_securp.Policy_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updContract_Id
		(
				inuRenewall_Securp_Id   in LD_renewall_securp.Renewall_Securp_Id%type,
				inuContract_Id$  in LD_renewall_securp.Contract_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetRenewall_Securp_Id
    	(
    	    inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_renewall_securp.Renewall_Securp_Id%type;

    	FUNCTION fnuGetPolicy_Id
    	(
    	    inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_renewall_securp.Policy_Id%type;

    	FUNCTION fnuGetContract_Id
    	(
    	    inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_renewall_securp.Contract_Id%type;


	PROCEDURE LockByPk
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		orcLD_renewall_securp  out styLD_renewall_securp
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_renewall_securp  out styLD_renewall_securp
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_renewall_securp;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_renewall_securp
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO147879';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_RENEWALL_SECURP';
	  cnuGeEntityId constant varchar2(30) := 1; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	IS
		SELECT LD_renewall_securp.*,LD_renewall_securp.rowid
		FROM LD_renewall_securp
		WHERE  Renewall_Securp_Id = inuRenewall_Securp_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_renewall_securp.*,LD_renewall_securp.rowid
		FROM LD_renewall_securp
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_renewall_securp is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_renewall_securp;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_renewall_securp default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Renewall_Securp_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		orcLD_renewall_securp  out styLD_renewall_securp
	)
	IS
		rcError styLD_renewall_securp;
	BEGIN
		rcError.Renewall_Securp_Id := inuRenewall_Securp_Id;

		Open cuLockRcByPk
		(
			inuRenewall_Securp_Id
		);

		fetch cuLockRcByPk into orcLD_renewall_securp;
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
		orcLD_renewall_securp  out styLD_renewall_securp
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_renewall_securp;
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
		itbLD_renewall_securp  in out nocopy tytbLD_renewall_securp
	)
	IS
	BEGIN
			rcRecOfTab.Renewall_Securp_Id.delete;
			rcRecOfTab.Policy_Id.delete;
			rcRecOfTab.Contract_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_renewall_securp  in out nocopy tytbLD_renewall_securp,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_renewall_securp);
		for n in itbLD_renewall_securp.first .. itbLD_renewall_securp.last loop
			rcRecOfTab.Renewall_Securp_Id(n) := itbLD_renewall_securp(n).Renewall_Securp_Id;
			rcRecOfTab.Policy_Id(n) := itbLD_renewall_securp(n).Policy_Id;
			rcRecOfTab.Contract_Id(n) := itbLD_renewall_securp(n).Contract_Id;
			rcRecOfTab.row_id(n) := itbLD_renewall_securp(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRenewall_Securp_Id
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
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRenewall_Securp_Id = rcData.Renewall_Securp_Id
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
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRenewall_Securp_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	IS
		rcError styLD_renewall_securp;
	BEGIN		rcError.Renewall_Securp_Id:=inuRenewall_Securp_Id;

		Load
		(
			inuRenewall_Securp_Id
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
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuRenewall_Securp_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		orcRecord out nocopy styLD_renewall_securp
	)
	IS
		rcError styLD_renewall_securp;
	BEGIN		rcError.Renewall_Securp_Id:=inuRenewall_Securp_Id;

		Load
		(
			inuRenewall_Securp_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN styLD_renewall_securp
	IS
		rcError styLD_renewall_securp;
	BEGIN
		rcError.Renewall_Securp_Id:=inuRenewall_Securp_Id;

		Load
		(
			inuRenewall_Securp_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type
	)
	RETURN styLD_renewall_securp
	IS
		rcError styLD_renewall_securp;
	BEGIN
		rcError.Renewall_Securp_Id:=inuRenewall_Securp_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRenewall_Securp_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRenewall_Securp_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_renewall_securp
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_renewall_securp
	)
	IS
		rfLD_renewall_securp tyrfLD_renewall_securp;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_renewall_securp.Renewall_Securp_Id,
		            LD_renewall_securp.Policy_Id,
		            LD_renewall_securp.Contract_Id,
		            LD_renewall_securp.rowid
                FROM LD_renewall_securp';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_renewall_securp for sbFullQuery;
		fetch rfLD_renewall_securp bulk collect INTO otbResult;
		close rfLD_renewall_securp;
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
		            LD_renewall_securp.Renewall_Securp_Id,
		            LD_renewall_securp.Policy_Id,
		            LD_renewall_securp.Contract_Id,
		            LD_renewall_securp.rowid
                FROM LD_renewall_securp';
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
		ircLD_renewall_securp in styLD_renewall_securp
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_renewall_securp,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_renewall_securp in styLD_renewall_securp,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_renewall_securp.Renewall_Securp_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Renewall_Securp_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_renewall_securp
		(
			Renewall_Securp_Id,
			Policy_Id,
			Contract_Id
		)
		values
		(
			ircLD_renewall_securp.Renewall_Securp_Id,
			ircLD_renewall_securp.Policy_Id,
			ircLD_renewall_securp.Contract_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_renewall_securp));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_renewall_securp in out nocopy tytbLD_renewall_securp
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_renewall_securp, blUseRowID);
		forall n in iotbLD_renewall_securp.first..iotbLD_renewall_securp.last
			insert into LD_renewall_securp
			(
			Renewall_Securp_Id,
			Policy_Id,
			Contract_Id
		)
		values
		(
			rcRecOfTab.Renewall_Securp_Id(n),
			rcRecOfTab.Policy_Id(n),
			rcRecOfTab.Contract_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_renewall_securp;
	BEGIN
		rcError.Renewall_Securp_Id:=inuRenewall_Securp_Id;

		if inuLock=1 then
			LockByPk
			(
				inuRenewall_Securp_Id,
				rcData
			);
		end if;

		delete
		from LD_renewall_securp
		where
       		Renewall_Securp_Id=inuRenewall_Securp_Id;
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
		rcError  styLD_renewall_securp;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_renewall_securp
		where
			rowid = iriRowID
		returning
   Renewall_Securp_Id
		into
			rcError.Renewall_Securp_Id;

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
		iotbLD_renewall_securp in out nocopy tytbLD_renewall_securp,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_renewall_securp;
	BEGIN
		FillRecordOfTables(iotbLD_renewall_securp, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last
				delete
				from LD_renewall_securp
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last loop
					LockByPk
					(
							rcRecOfTab.Renewall_Securp_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last
				delete
				from LD_renewall_securp
				where
		         	Renewall_Securp_Id = rcRecOfTab.Renewall_Securp_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_renewall_securp in styLD_renewall_securp,
		inuLock	  in number default 0
	)
	IS
		nuRenewall_Securp_Id LD_renewall_securp.Renewall_Securp_Id%type;

	BEGIN
		if ircLD_renewall_securp.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_renewall_securp.rowid,rcData);
			end if;
			update LD_renewall_securp
			set

        Policy_Id = ircLD_renewall_securp.Policy_Id,
        Contract_Id = ircLD_renewall_securp.Contract_Id
			where
				rowid = ircLD_renewall_securp.rowid
			returning
    Renewall_Securp_Id
			into
				nuRenewall_Securp_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_renewall_securp.Renewall_Securp_Id,
					rcData
				);
			end if;

			update LD_renewall_securp
			set
        Policy_Id = ircLD_renewall_securp.Policy_Id,
        Contract_Id = ircLD_renewall_securp.Contract_Id
			where
	         	Renewall_Securp_Id = ircLD_renewall_securp.Renewall_Securp_Id
			returning
    Renewall_Securp_Id
			into
				nuRenewall_Securp_Id;
		end if;

		if
			nuRenewall_Securp_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_renewall_securp));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_renewall_securp in out nocopy tytbLD_renewall_securp,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_renewall_securp;
  BEGIN
    FillRecordOfTables(iotbLD_renewall_securp,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last
        update LD_renewall_securp
        set

            Policy_Id = rcRecOfTab.Policy_Id(n),
            Contract_Id = rcRecOfTab.Contract_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last loop
          LockByPk
          (
              rcRecOfTab.Renewall_Securp_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_renewall_securp.first .. iotbLD_renewall_securp.last
        update LD_renewall_securp
        set
					Policy_Id = rcRecOfTab.Policy_Id(n),
					Contract_Id = rcRecOfTab.Contract_Id(n)
          where
          Renewall_Securp_Id = rcRecOfTab.Renewall_Securp_Id(n)
;
    end if;
  END;

	PROCEDURE updPolicy_Id
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuPolicy_Id$ in LD_renewall_securp.Policy_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_renewall_securp;
	BEGIN
		rcError.Renewall_Securp_Id := inuRenewall_Securp_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRenewall_Securp_Id,
				rcData
			);
		end if;

		update LD_renewall_securp
		set
			Policy_Id = inuPolicy_Id$
		where
			Renewall_Securp_Id = inuRenewall_Securp_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Policy_Id:= inuPolicy_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updContract_Id
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuContract_Id$ in LD_renewall_securp.Contract_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_renewall_securp;
	BEGIN
		rcError.Renewall_Securp_Id := inuRenewall_Securp_Id;
		if inuLock=1 then
			LockByPk
			(
				inuRenewall_Securp_Id,
				rcData
			);
		end if;

		update LD_renewall_securp
		set
			Contract_Id = inuContract_Id$
		where
			Renewall_Securp_Id = inuRenewall_Securp_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Contract_Id:= inuContract_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetRenewall_Securp_Id
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_renewall_securp.Renewall_Securp_Id%type
	IS
		rcError styLD_renewall_securp;
	BEGIN

		rcError.Renewall_Securp_Id := inuRenewall_Securp_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRenewall_Securp_Id
			 )
		then
			 return(rcData.Renewall_Securp_Id);
		end if;
		Load
		(
			inuRenewall_Securp_Id
		);
		return(rcData.Renewall_Securp_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPolicy_Id
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_renewall_securp.Policy_Id%type
	IS
		rcError styLD_renewall_securp;
	BEGIN

		rcError.Renewall_Securp_Id := inuRenewall_Securp_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRenewall_Securp_Id
			 )
		then
			 return(rcData.Policy_Id);
		end if;
		Load
		(
			inuRenewall_Securp_Id
		);
		return(rcData.Policy_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetContract_Id
	(
		inuRenewall_Securp_Id in LD_renewall_securp.Renewall_Securp_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_renewall_securp.Contract_Id%type
	IS
		rcError styLD_renewall_securp;
	BEGIN

		rcError.Renewall_Securp_Id := inuRenewall_Securp_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuRenewall_Securp_Id
			 )
		then
			 return(rcData.Contract_Id);
		end if;
		Load
		(
			inuRenewall_Securp_Id
		);
		return(rcData.Contract_Id);
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
end DALD_renewall_securp;
/
PROMPT Otorgando permisos de ejecucion a DALD_RENEWALL_SECURP
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_RENEWALL_SECURP', 'ADM_PERSON');
END;
/