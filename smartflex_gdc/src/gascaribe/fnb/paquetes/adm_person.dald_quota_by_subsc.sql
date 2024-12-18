CREATE OR REPLACE PACKAGE adm_person.DALD_quota_by_subsc
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
  )
  IS
		SELECT LD_quota_by_subsc.*,LD_quota_by_subsc.rowid
		FROM LD_quota_by_subsc
		WHERE
			Quota_By_Subsc_Id = inuQuota_By_Subsc_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_by_subsc.*,LD_quota_by_subsc.rowid
		FROM LD_quota_by_subsc
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_quota_by_subsc  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_quota_by_subsc is table of styLD_quota_by_subsc index by binary_integer;
	type tyrfRecords is ref cursor return styLD_quota_by_subsc;

	/* Tipos referenciando al registro */
	type tytbQuota_By_Subsc_Id is table of LD_quota_by_subsc.Quota_By_Subsc_Id%type index by binary_integer;
	type tytbSubscription_Id is table of LD_quota_by_subsc.Subscription_Id%type index by binary_integer;
	type tytbQuota_Value is table of LD_quota_by_subsc.Quota_Value%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_quota_by_subsc is record
	(

		Quota_By_Subsc_Id   tytbQuota_By_Subsc_Id,
		Subscription_Id   tytbSubscription_Id,
		Quota_Value   tytbQuota_Value,
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
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	);

	PROCEDURE getRecord
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		orcRecord out nocopy styLD_quota_by_subsc
	);

	FUNCTION frcGetRcData
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN styLD_quota_by_subsc;

	FUNCTION frcGetRcData
	RETURN styLD_quota_by_subsc;

	FUNCTION frcGetRecord
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN styLD_quota_by_subsc;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_by_subsc
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_quota_by_subsc in styLD_quota_by_subsc
	);

 	  PROCEDURE insRecord
	(
		ircLD_quota_by_subsc in styLD_quota_by_subsc,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_quota_by_subsc in out nocopy tytbLD_quota_by_subsc
	);

	PROCEDURE delRecord
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_quota_by_subsc in out nocopy tytbLD_quota_by_subsc,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_quota_by_subsc in styLD_quota_by_subsc,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_quota_by_subsc in out nocopy tytbLD_quota_by_subsc,
		inuLock in number default 1
	);

		PROCEDURE updSubscription_Id
		(
				inuQuota_By_Subsc_Id   in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
				inuSubscription_Id$  in LD_quota_by_subsc.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Value
		(
				inuQuota_By_Subsc_Id   in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
				inuQuota_Value$  in LD_quota_by_subsc.Quota_Value%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetQuota_By_Subsc_Id
    	(
    	    inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_by_subsc.Quota_By_Subsc_Id%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_by_subsc.Subscription_Id%type;

    	FUNCTION fnuGetQuota_Value
    	(
    	    inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_quota_by_subsc.Quota_Value%type;


	PROCEDURE LockByPk
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		orcLD_quota_by_subsc  out styLD_quota_by_subsc
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_quota_by_subsc  out styLD_quota_by_subsc
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_quota_by_subsc;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_quota_by_subsc
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_QUOTA_BY_SUBSC';
	  cnuGeEntityId constant varchar2(30) := 8663; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	IS
		SELECT LD_quota_by_subsc.*,LD_quota_by_subsc.rowid
		FROM LD_quota_by_subsc
		WHERE  Quota_By_Subsc_Id = inuQuota_By_Subsc_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_quota_by_subsc.*,LD_quota_by_subsc.rowid
		FROM LD_quota_by_subsc
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_quota_by_subsc is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_quota_by_subsc;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_quota_by_subsc default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Quota_By_Subsc_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		orcLD_quota_by_subsc  out styLD_quota_by_subsc
	)
	IS
		rcError styLD_quota_by_subsc;
	BEGIN
		rcError.Quota_By_Subsc_Id := inuQuota_By_Subsc_Id;

		Open cuLockRcByPk
		(
			inuQuota_By_Subsc_Id
		);

		fetch cuLockRcByPk into orcLD_quota_by_subsc;
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
		orcLD_quota_by_subsc  out styLD_quota_by_subsc
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_quota_by_subsc;
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
		itbLD_quota_by_subsc  in out nocopy tytbLD_quota_by_subsc
	)
	IS
	BEGIN
			rcRecOfTab.Quota_By_Subsc_Id.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Quota_Value.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_quota_by_subsc  in out nocopy tytbLD_quota_by_subsc,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_quota_by_subsc);
		for n in itbLD_quota_by_subsc.first .. itbLD_quota_by_subsc.last loop
			rcRecOfTab.Quota_By_Subsc_Id(n) := itbLD_quota_by_subsc(n).Quota_By_Subsc_Id;
			rcRecOfTab.Subscription_Id(n) := itbLD_quota_by_subsc(n).Subscription_Id;
			rcRecOfTab.Quota_Value(n) := itbLD_quota_by_subsc(n).Quota_Value;
			rcRecOfTab.row_id(n) := itbLD_quota_by_subsc(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuQuota_By_Subsc_Id
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
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuQuota_By_Subsc_Id = rcData.Quota_By_Subsc_Id
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
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuQuota_By_Subsc_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	IS
		rcError styLD_quota_by_subsc;
	BEGIN		rcError.Quota_By_Subsc_Id:=inuQuota_By_Subsc_Id;

		Load
		(
			inuQuota_By_Subsc_Id
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
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuQuota_By_Subsc_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		orcRecord out nocopy styLD_quota_by_subsc
	)
	IS
		rcError styLD_quota_by_subsc;
	BEGIN		rcError.Quota_By_Subsc_Id:=inuQuota_By_Subsc_Id;

		Load
		(
			inuQuota_By_Subsc_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN styLD_quota_by_subsc
	IS
		rcError styLD_quota_by_subsc;
	BEGIN
		rcError.Quota_By_Subsc_Id:=inuQuota_By_Subsc_Id;

		Load
		(
			inuQuota_By_Subsc_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type
	)
	RETURN styLD_quota_by_subsc
	IS
		rcError styLD_quota_by_subsc;
	BEGIN
		rcError.Quota_By_Subsc_Id:=inuQuota_By_Subsc_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuQuota_By_Subsc_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuQuota_By_Subsc_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_quota_by_subsc
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_quota_by_subsc
	)
	IS
		rfLD_quota_by_subsc tyrfLD_quota_by_subsc;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_quota_by_subsc.Quota_By_Subsc_Id,
		            LD_quota_by_subsc.Subscription_Id,
		            LD_quota_by_subsc.Quota_Value,
		            LD_quota_by_subsc.rowid
                FROM LD_quota_by_subsc';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_quota_by_subsc for sbFullQuery;
		fetch rfLD_quota_by_subsc bulk collect INTO otbResult;
		close rfLD_quota_by_subsc;
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
		            LD_quota_by_subsc.Quota_By_Subsc_Id,
		            LD_quota_by_subsc.Subscription_Id,
		            LD_quota_by_subsc.Quota_Value,
		            LD_quota_by_subsc.rowid
                FROM LD_quota_by_subsc';
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
		ircLD_quota_by_subsc in styLD_quota_by_subsc
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_quota_by_subsc,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_quota_by_subsc in styLD_quota_by_subsc,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_quota_by_subsc.Quota_By_Subsc_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Quota_By_Subsc_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_quota_by_subsc
		(
			Quota_By_Subsc_Id,
			Subscription_Id,
			Quota_Value
		)
		values
		(
			ircLD_quota_by_subsc.Quota_By_Subsc_Id,
			ircLD_quota_by_subsc.Subscription_Id,
			ircLD_quota_by_subsc.Quota_Value
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_quota_by_subsc));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_quota_by_subsc in out nocopy tytbLD_quota_by_subsc
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_quota_by_subsc, blUseRowID);
		forall n in iotbLD_quota_by_subsc.first..iotbLD_quota_by_subsc.last
			insert into LD_quota_by_subsc
			(
			Quota_By_Subsc_Id,
			Subscription_Id,
			Quota_Value
		)
		values
		(
			rcRecOfTab.Quota_By_Subsc_Id(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Quota_Value(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_quota_by_subsc;
	BEGIN
		rcError.Quota_By_Subsc_Id:=inuQuota_By_Subsc_Id;

		if inuLock=1 then
			LockByPk
			(
				inuQuota_By_Subsc_Id,
				rcData
			);
		end if;

		delete
		from LD_quota_by_subsc
		where
       		Quota_By_Subsc_Id=inuQuota_By_Subsc_Id;
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
		rcError  styLD_quota_by_subsc;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_quota_by_subsc
		where
			rowid = iriRowID
		returning
   Quota_By_Subsc_Id
		into
			rcError.Quota_By_Subsc_Id;

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
		iotbLD_quota_by_subsc in out nocopy tytbLD_quota_by_subsc,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_quota_by_subsc;
	BEGIN
		FillRecordOfTables(iotbLD_quota_by_subsc, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last
				delete
				from LD_quota_by_subsc
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last loop
					LockByPk
					(
							rcRecOfTab.Quota_By_Subsc_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last
				delete
				from LD_quota_by_subsc
				where
		         	Quota_By_Subsc_Id = rcRecOfTab.Quota_By_Subsc_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_quota_by_subsc in styLD_quota_by_subsc,
		inuLock	  in number default 0
	)
	IS
		nuQuota_By_Subsc_Id LD_quota_by_subsc.Quota_By_Subsc_Id%type;

	BEGIN
		if ircLD_quota_by_subsc.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_quota_by_subsc.rowid,rcData);
			end if;
			update LD_quota_by_subsc
			set

        Subscription_Id = ircLD_quota_by_subsc.Subscription_Id,
        Quota_Value = ircLD_quota_by_subsc.Quota_Value
			where
				rowid = ircLD_quota_by_subsc.rowid
			returning
    Quota_By_Subsc_Id
			into
				nuQuota_By_Subsc_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_quota_by_subsc.Quota_By_Subsc_Id,
					rcData
				);
			end if;

			update LD_quota_by_subsc
			set
        Subscription_Id = ircLD_quota_by_subsc.Subscription_Id,
        Quota_Value = ircLD_quota_by_subsc.Quota_Value
			where
	         	Quota_By_Subsc_Id = ircLD_quota_by_subsc.Quota_By_Subsc_Id
			returning
    Quota_By_Subsc_Id
			into
				nuQuota_By_Subsc_Id;
		end if;

		if
			nuQuota_By_Subsc_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_quota_by_subsc));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_quota_by_subsc in out nocopy tytbLD_quota_by_subsc,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_quota_by_subsc;
  BEGIN
    FillRecordOfTables(iotbLD_quota_by_subsc,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last
        update LD_quota_by_subsc
        set

            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Quota_Value = rcRecOfTab.Quota_Value(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last loop
          LockByPk
          (
              rcRecOfTab.Quota_By_Subsc_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_quota_by_subsc.first .. iotbLD_quota_by_subsc.last
        update LD_quota_by_subsc
        set
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Quota_Value = rcRecOfTab.Quota_Value(n)
          where
          Quota_By_Subsc_Id = rcRecOfTab.Quota_By_Subsc_Id(n)
;
    end if;
  END;

	PROCEDURE updSubscription_Id
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuSubscription_Id$ in LD_quota_by_subsc.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_by_subsc;
	BEGIN
		rcError.Quota_By_Subsc_Id := inuQuota_By_Subsc_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_By_Subsc_Id,
				rcData
			);
		end if;

		update LD_quota_by_subsc
		set
			Subscription_Id = inuSubscription_Id$
		where
			Quota_By_Subsc_Id = inuQuota_By_Subsc_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Value
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuQuota_Value$ in LD_quota_by_subsc.Quota_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_quota_by_subsc;
	BEGIN
		rcError.Quota_By_Subsc_Id := inuQuota_By_Subsc_Id;
		if inuLock=1 then
			LockByPk
			(
				inuQuota_By_Subsc_Id,
				rcData
			);
		end if;

		update LD_quota_by_subsc
		set
			Quota_Value = inuQuota_Value$
		where
			Quota_By_Subsc_Id = inuQuota_By_Subsc_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Value:= inuQuota_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetQuota_By_Subsc_Id
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_by_subsc.Quota_By_Subsc_Id%type
	IS
		rcError styLD_quota_by_subsc;
	BEGIN

		rcError.Quota_By_Subsc_Id := inuQuota_By_Subsc_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_By_Subsc_Id
			 )
		then
			 return(rcData.Quota_By_Subsc_Id);
		end if;
		Load
		(
			inuQuota_By_Subsc_Id
		);
		return(rcData.Quota_By_Subsc_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubscription_Id
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_by_subsc.Subscription_Id%type
	IS
		rcError styLD_quota_by_subsc;
	BEGIN

		rcError.Quota_By_Subsc_Id := inuQuota_By_Subsc_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_By_Subsc_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuQuota_By_Subsc_Id
		);
		return(rcData.Subscription_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Value
	(
		inuQuota_By_Subsc_Id in LD_quota_by_subsc.Quota_By_Subsc_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_quota_by_subsc.Quota_Value%type
	IS
		rcError styLD_quota_by_subsc;
	BEGIN

		rcError.Quota_By_Subsc_Id := inuQuota_By_Subsc_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuQuota_By_Subsc_Id
			 )
		then
			 return(rcData.Quota_Value);
		end if;
		Load
		(
			inuQuota_By_Subsc_Id
		);
		return(rcData.Quota_Value);
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
end DALD_quota_by_subsc;
/

PROMPT Otorgando permisos de ejecucion a DALD_QUOTA_BY_SUBSC
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_QUOTA_BY_SUBSC', 'ADM_PERSON');
END;
/