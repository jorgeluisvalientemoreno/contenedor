CREATE OR REPLACE PACKAGE adm_person.DALD_zon_assig_valid
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_ZON_ASSIG_VALID
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
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
  )
  IS
		SELECT LD_zon_assig_valid.*,LD_zon_assig_valid.rowid
		FROM LD_zon_assig_valid
		WHERE
			ZON_ASSIG_VALID_Id = inuZON_ASSIG_VALID_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_zon_assig_valid.*,LD_zon_assig_valid.rowid
		FROM LD_zon_assig_valid
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_zon_assig_valid  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_zon_assig_valid is table of styLD_zon_assig_valid index by binary_integer;
	type tyrfRecords is ref cursor return styLD_zon_assig_valid;

	/* Tipos referenciando al registro */
	type tytbZon_Assig_Valid_Id is table of LD_zon_assig_valid.Zon_Assig_Valid_Id%type index by binary_integer;
	type tytbOperating_Unit_Id is table of LD_zon_assig_valid.Operating_Unit_Id%type index by binary_integer;
	type tytbSubscription_Id is table of LD_zon_assig_valid.Subscription_Id%type index by binary_integer;
	type tytbDate_Of_Visit is table of LD_zon_assig_valid.Date_Of_Visit%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_zon_assig_valid is record
	(

		Zon_Assig_Valid_Id   tytbZon_Assig_Valid_Id,
		Operating_Unit_Id   tytbOperating_Unit_Id,
		Subscription_Id   tytbSubscription_Id,
		Date_Of_Visit   tytbDate_Of_Visit,
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
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	);

	PROCEDURE getRecord
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		orcRecord out nocopy styLD_zon_assig_valid
	);

	FUNCTION frcGetRcData
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN styLD_zon_assig_valid;

	FUNCTION frcGetRcData
	RETURN styLD_zon_assig_valid;

	FUNCTION frcGetRecord
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN styLD_zon_assig_valid;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_zon_assig_valid
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_zon_assig_valid in styLD_zon_assig_valid
	);

 	  PROCEDURE insRecord
	(
		ircLD_zon_assig_valid in styLD_zon_assig_valid,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_zon_assig_valid in out nocopy tytbLD_zon_assig_valid
	);

	PROCEDURE delRecord
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_zon_assig_valid in out nocopy tytbLD_zon_assig_valid,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_zon_assig_valid in styLD_zon_assig_valid,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_zon_assig_valid in out nocopy tytbLD_zon_assig_valid,
		inuLock in number default 1
	);

		PROCEDURE updOperating_Unit_Id
		(
				inuZON_ASSIG_VALID_Id   in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
				inuOperating_Unit_Id$  in LD_zon_assig_valid.Operating_Unit_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubscription_Id
		(
				inuZON_ASSIG_VALID_Id   in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
				inuSubscription_Id$  in LD_zon_assig_valid.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDate_Of_Visit
		(
				inuZON_ASSIG_VALID_Id   in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
				idtDate_Of_Visit$  in LD_zon_assig_valid.Date_Of_Visit%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetZon_Assig_Valid_Id
    	(
    	    inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_zon_assig_valid.Zon_Assig_Valid_Id%type;

    	FUNCTION fnuGetOperating_Unit_Id
    	(
    	    inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_zon_assig_valid.Operating_Unit_Id%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_zon_assig_valid.Subscription_Id%type;

    	FUNCTION fdtGetDate_Of_Visit
    	(
    	    inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_zon_assig_valid.Date_Of_Visit%type;


	PROCEDURE LockByPk
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		orcLD_zon_assig_valid  out styLD_zon_assig_valid
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_zon_assig_valid  out styLD_zon_assig_valid
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_zon_assig_valid;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_zon_assig_valid
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_ZON_ASSIG_VALID';
	  cnuGeEntityId constant varchar2(30) := 8483; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	IS
		SELECT LD_zon_assig_valid.*,LD_zon_assig_valid.rowid
		FROM LD_zon_assig_valid
		WHERE  ZON_ASSIG_VALID_Id = inuZON_ASSIG_VALID_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_zon_assig_valid.*,LD_zon_assig_valid.rowid
		FROM LD_zon_assig_valid
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_zon_assig_valid is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_zon_assig_valid;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_zon_assig_valid default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ZON_ASSIG_VALID_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		orcLD_zon_assig_valid  out styLD_zon_assig_valid
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;

		Open cuLockRcByPk
		(
			inuZON_ASSIG_VALID_Id
		);

		fetch cuLockRcByPk into orcLD_zon_assig_valid;
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
		orcLD_zon_assig_valid  out styLD_zon_assig_valid
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_zon_assig_valid;
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
		itbLD_zon_assig_valid  in out nocopy tytbLD_zon_assig_valid
	)
	IS
	BEGIN
			rcRecOfTab.Zon_Assig_Valid_Id.delete;
			rcRecOfTab.Operating_Unit_Id.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Date_Of_Visit.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_zon_assig_valid  in out nocopy tytbLD_zon_assig_valid,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_zon_assig_valid);
		for n in itbLD_zon_assig_valid.first .. itbLD_zon_assig_valid.last loop
			rcRecOfTab.Zon_Assig_Valid_Id(n) := itbLD_zon_assig_valid(n).Zon_Assig_Valid_Id;
			rcRecOfTab.Operating_Unit_Id(n) := itbLD_zon_assig_valid(n).Operating_Unit_Id;
			rcRecOfTab.Subscription_Id(n) := itbLD_zon_assig_valid(n).Subscription_Id;
			rcRecOfTab.Date_Of_Visit(n) := itbLD_zon_assig_valid(n).Date_Of_Visit;
			rcRecOfTab.row_id(n) := itbLD_zon_assig_valid(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuZON_ASSIG_VALID_Id
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
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuZON_ASSIG_VALID_Id = rcData.ZON_ASSIG_VALID_Id
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
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN		rcError.ZON_ASSIG_VALID_Id:=inuZON_ASSIG_VALID_Id;

		Load
		(
			inuZON_ASSIG_VALID_Id
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
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		orcRecord out nocopy styLD_zon_assig_valid
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN		rcError.ZON_ASSIG_VALID_Id:=inuZON_ASSIG_VALID_Id;

		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN styLD_zon_assig_valid
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id:=inuZON_ASSIG_VALID_Id;

		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type
	)
	RETURN styLD_zon_assig_valid
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id:=inuZON_ASSIG_VALID_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuZON_ASSIG_VALID_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_zon_assig_valid
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_zon_assig_valid
	)
	IS
		rfLD_zon_assig_valid tyrfLD_zon_assig_valid;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_zon_assig_valid.Zon_Assig_Valid_Id,
		            LD_zon_assig_valid.Operating_Unit_Id,
		            LD_zon_assig_valid.Subscription_Id,
		            LD_zon_assig_valid.Date_Of_Visit,
		            LD_zon_assig_valid.rowid
                FROM LD_zon_assig_valid';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_zon_assig_valid for sbFullQuery;
		fetch rfLD_zon_assig_valid bulk collect INTO otbResult;
		close rfLD_zon_assig_valid;
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
		            LD_zon_assig_valid.Zon_Assig_Valid_Id,
		            LD_zon_assig_valid.Operating_Unit_Id,
		            LD_zon_assig_valid.Subscription_Id,
		            LD_zon_assig_valid.Date_Of_Visit,
		            LD_zon_assig_valid.rowid
                FROM LD_zon_assig_valid';
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
		ircLD_zon_assig_valid in styLD_zon_assig_valid
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_zon_assig_valid,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_zon_assig_valid in styLD_zon_assig_valid,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_zon_assig_valid.ZON_ASSIG_VALID_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ZON_ASSIG_VALID_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_zon_assig_valid
		(
			Zon_Assig_Valid_Id,
			Operating_Unit_Id,
			Subscription_Id,
			Date_Of_Visit
		)
		values
		(
			ircLD_zon_assig_valid.Zon_Assig_Valid_Id,
			ircLD_zon_assig_valid.Operating_Unit_Id,
			ircLD_zon_assig_valid.Subscription_Id,
			ircLD_zon_assig_valid.Date_Of_Visit
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_zon_assig_valid));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_zon_assig_valid in out nocopy tytbLD_zon_assig_valid
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_zon_assig_valid, blUseRowID);
		forall n in iotbLD_zon_assig_valid.first..iotbLD_zon_assig_valid.last
			insert into LD_zon_assig_valid
			(
			Zon_Assig_Valid_Id,
			Operating_Unit_Id,
			Subscription_Id,
			Date_Of_Visit
		)
		values
		(
			rcRecOfTab.Zon_Assig_Valid_Id(n),
			rcRecOfTab.Operating_Unit_Id(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Date_Of_Visit(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id:=inuZON_ASSIG_VALID_Id;

		if inuLock=1 then
			LockByPk
			(
				inuZON_ASSIG_VALID_Id,
				rcData
			);
		end if;

		delete
		from LD_zon_assig_valid
		where
       		ZON_ASSIG_VALID_Id=inuZON_ASSIG_VALID_Id;
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
		rcError  styLD_zon_assig_valid;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_zon_assig_valid
		where
			rowid = iriRowID
		returning
   ZON_ASSIG_VALID_Id
		into
			rcError.ZON_ASSIG_VALID_Id;

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
		iotbLD_zon_assig_valid in out nocopy tytbLD_zon_assig_valid,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_zon_assig_valid;
	BEGIN
		FillRecordOfTables(iotbLD_zon_assig_valid, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last
				delete
				from LD_zon_assig_valid
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last loop
					LockByPk
					(
							rcRecOfTab.ZON_ASSIG_VALID_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last
				delete
				from LD_zon_assig_valid
				where
		         	ZON_ASSIG_VALID_Id = rcRecOfTab.ZON_ASSIG_VALID_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_zon_assig_valid in styLD_zon_assig_valid,
		inuLock	  in number default 0
	)
	IS
		nuZON_ASSIG_VALID_Id LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type;

	BEGIN
		if ircLD_zon_assig_valid.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_zon_assig_valid.rowid,rcData);
			end if;
			update LD_zon_assig_valid
			set

        Operating_Unit_Id = ircLD_zon_assig_valid.Operating_Unit_Id,
        Subscription_Id = ircLD_zon_assig_valid.Subscription_Id,
        Date_Of_Visit = ircLD_zon_assig_valid.Date_Of_Visit
			where
				rowid = ircLD_zon_assig_valid.rowid
			returning
    ZON_ASSIG_VALID_Id
			into
				nuZON_ASSIG_VALID_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_zon_assig_valid.ZON_ASSIG_VALID_Id,
					rcData
				);
			end if;

			update LD_zon_assig_valid
			set
        Operating_Unit_Id = ircLD_zon_assig_valid.Operating_Unit_Id,
        Subscription_Id = ircLD_zon_assig_valid.Subscription_Id,
        Date_Of_Visit = ircLD_zon_assig_valid.Date_Of_Visit
			where
	         	ZON_ASSIG_VALID_Id = ircLD_zon_assig_valid.ZON_ASSIG_VALID_Id
			returning
    ZON_ASSIG_VALID_Id
			into
				nuZON_ASSIG_VALID_Id;
		end if;

		if
			nuZON_ASSIG_VALID_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_zon_assig_valid));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_zon_assig_valid in out nocopy tytbLD_zon_assig_valid,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_zon_assig_valid;
  BEGIN
    FillRecordOfTables(iotbLD_zon_assig_valid,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last
        update LD_zon_assig_valid
        set

            Operating_Unit_Id = rcRecOfTab.Operating_Unit_Id(n),
            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Date_Of_Visit = rcRecOfTab.Date_Of_Visit(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last loop
          LockByPk
          (
              rcRecOfTab.ZON_ASSIG_VALID_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_zon_assig_valid.first .. iotbLD_zon_assig_valid.last
        update LD_zon_assig_valid
        set
					Operating_Unit_Id = rcRecOfTab.Operating_Unit_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Date_Of_Visit = rcRecOfTab.Date_Of_Visit(n)
          where
          ZON_ASSIG_VALID_Id = rcRecOfTab.ZON_ASSIG_VALID_Id(n)
;
    end if;
  END;

	PROCEDURE updOperating_Unit_Id
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuOperating_Unit_Id$ in LD_zon_assig_valid.Operating_Unit_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;
		if inuLock=1 then
			LockByPk
			(
				inuZON_ASSIG_VALID_Id,
				rcData
			);
		end if;

		update LD_zon_assig_valid
		set
			Operating_Unit_Id = inuOperating_Unit_Id$
		where
			ZON_ASSIG_VALID_Id = inuZON_ASSIG_VALID_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Operating_Unit_Id:= inuOperating_Unit_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubscription_Id
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuSubscription_Id$ in LD_zon_assig_valid.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;
		if inuLock=1 then
			LockByPk
			(
				inuZON_ASSIG_VALID_Id,
				rcData
			);
		end if;

		update LD_zon_assig_valid
		set
			Subscription_Id = inuSubscription_Id$
		where
			ZON_ASSIG_VALID_Id = inuZON_ASSIG_VALID_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDate_Of_Visit
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		idtDate_Of_Visit$ in LD_zon_assig_valid.Date_Of_Visit%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_zon_assig_valid;
	BEGIN
		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;
		if inuLock=1 then
			LockByPk
			(
				inuZON_ASSIG_VALID_Id,
				rcData
			);
		end if;

		update LD_zon_assig_valid
		set
			Date_Of_Visit = idtDate_Of_Visit$
		where
			ZON_ASSIG_VALID_Id = inuZON_ASSIG_VALID_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Date_Of_Visit:= idtDate_Of_Visit$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetZon_Assig_Valid_Id
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_zon_assig_valid.Zon_Assig_Valid_Id%type
	IS
		rcError styLD_zon_assig_valid;
	BEGIN

		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuZON_ASSIG_VALID_Id
			 )
		then
			 return(rcData.Zon_Assig_Valid_Id);
		end if;
		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		return(rcData.Zon_Assig_Valid_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOperating_Unit_Id
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_zon_assig_valid.Operating_Unit_Id%type
	IS
		rcError styLD_zon_assig_valid;
	BEGIN

		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuZON_ASSIG_VALID_Id
			 )
		then
			 return(rcData.Operating_Unit_Id);
		end if;
		Load
		(
			inuZON_ASSIG_VALID_Id
		);
		return(rcData.Operating_Unit_Id);
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
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_zon_assig_valid.Subscription_Id%type
	IS
		rcError styLD_zon_assig_valid;
	BEGIN

		rcError.ZON_ASSIG_VALID_Id := inuZON_ASSIG_VALID_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuZON_ASSIG_VALID_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuZON_ASSIG_VALID_Id
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

	FUNCTION fdtGetDate_Of_Visit
	(
		inuZON_ASSIG_VALID_Id in LD_zon_assig_valid.ZON_ASSIG_VALID_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_zon_assig_valid.Date_Of_Visit%type
	IS
		rcError styLD_zon_assig_valid;
	BEGIN

		rcError.ZON_ASSIG_VALID_Id:=inuZON_ASSIG_VALID_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuZON_ASSIG_VALID_Id
			 )
		then
			 return(rcData.Date_Of_Visit);
		end if;
		Load
		(
		 		inuZON_ASSIG_VALID_Id
		);
		return(rcData.Date_Of_Visit);
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
end DALD_zon_assig_valid;
/
PROMPT Otorgando permisos de ejecucion a DALD_ZON_ASSIG_VALID
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_ZON_ASSIG_VALID', 'ADM_PERSON');
END;
/