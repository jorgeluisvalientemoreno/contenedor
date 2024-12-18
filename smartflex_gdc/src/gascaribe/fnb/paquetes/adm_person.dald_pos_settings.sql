CREATE OR REPLACE PACKAGE adm_person.dald_pos_settings
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
  )
  IS
		SELECT LD_pos_settings.*,LD_pos_settings.rowid
		FROM LD_pos_settings
		WHERE
			POS_SETTINGS_Id = inuPOS_SETTINGS_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_pos_settings.*,LD_pos_settings.rowid
		FROM LD_pos_settings
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_pos_settings  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_pos_settings is table of styLD_pos_settings index by binary_integer;
	type tyrfRecords is ref cursor return styLD_pos_settings;

	/* Tipos referenciando al registro */
	type tytbPos_Settings_Id is table of LD_pos_settings.Pos_Settings_Id%type index by binary_integer;
	type tytbSupplier_Id is table of LD_pos_settings.Supplier_Id%type index by binary_integer;
	type tytbPos_Id is table of LD_pos_settings.Pos_Id%type index by binary_integer;
	type tytbEquivalence is table of LD_pos_settings.Equivalence%type index by binary_integer;
	type tytbDefault_Operating_Unit is table of LD_pos_settings.Default_Operating_Unit%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_pos_settings is record
	(

		Pos_Settings_Id   tytbPos_Settings_Id,
		Supplier_Id   tytbSupplier_Id,
		Pos_Id   tytbPos_Id,
		Equivalence   tytbEquivalence,
		Default_Operating_Unit   tytbDefault_Operating_Unit,
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
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	);

	PROCEDURE getRecord
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		orcRecord out nocopy styLD_pos_settings
	);

	FUNCTION frcGetRcData
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN styLD_pos_settings;

	FUNCTION frcGetRcData
	RETURN styLD_pos_settings;

	FUNCTION frcGetRecord
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN styLD_pos_settings;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_pos_settings
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_pos_settings in styLD_pos_settings
	);

 	  PROCEDURE insRecord
	(
		ircLD_pos_settings in styLD_pos_settings,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_pos_settings in out nocopy tytbLD_pos_settings
	);

	PROCEDURE delRecord
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_pos_settings in out nocopy tytbLD_pos_settings,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_pos_settings in styLD_pos_settings,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_pos_settings in out nocopy tytbLD_pos_settings,
		inuLock in number default 1
	);

		PROCEDURE updSupplier_Id
		(
				inuPOS_SETTINGS_Id   in LD_pos_settings.POS_SETTINGS_Id%type,
				inuSupplier_Id$  in LD_pos_settings.Supplier_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPos_Id
		(
				inuPOS_SETTINGS_Id   in LD_pos_settings.POS_SETTINGS_Id%type,
				inuPos_Id$  in LD_pos_settings.Pos_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updEquivalence
		(
				inuPOS_SETTINGS_Id   in LD_pos_settings.POS_SETTINGS_Id%type,
				isbEquivalence$  in LD_pos_settings.Equivalence%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDefault_Operating_Unit
		(
				inuPOS_SETTINGS_Id   in LD_pos_settings.POS_SETTINGS_Id%type,
				inuDefault_Operating_Unit$  in LD_pos_settings.Default_Operating_Unit%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPos_Settings_Id
    	(
    	    inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_pos_settings.Pos_Settings_Id%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_pos_settings.Supplier_Id%type;

    	FUNCTION fnuGetPos_Id
    	(
    	    inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_pos_settings.Pos_Id%type;

    	FUNCTION fsbGetEquivalence
    	(
    	    inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_pos_settings.Equivalence%type;

    	FUNCTION fnuGetDefault_Operating_Unit
    	(
    	    inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_pos_settings.Default_Operating_Unit%type;


	PROCEDURE LockByPk
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		orcLD_pos_settings  out styLD_pos_settings
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_pos_settings  out styLD_pos_settings
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_pos_settings;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_pos_settings
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_POS_SETTINGS';
	  cnuGeEntityId constant varchar2(30) := 8692; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	IS
		SELECT LD_pos_settings.*,LD_pos_settings.rowid
		FROM LD_pos_settings
		WHERE  POS_SETTINGS_Id = inuPOS_SETTINGS_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_pos_settings.*,LD_pos_settings.rowid
		FROM LD_pos_settings
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_pos_settings is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_pos_settings;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_pos_settings default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.POS_SETTINGS_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		orcLD_pos_settings  out styLD_pos_settings
	)
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;

		Open cuLockRcByPk
		(
			inuPOS_SETTINGS_Id
		);

		fetch cuLockRcByPk into orcLD_pos_settings;
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
		orcLD_pos_settings  out styLD_pos_settings
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_pos_settings;
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
		itbLD_pos_settings  in out nocopy tytbLD_pos_settings
	)
	IS
	BEGIN
			rcRecOfTab.Pos_Settings_Id.delete;
			rcRecOfTab.Supplier_Id.delete;
			rcRecOfTab.Pos_Id.delete;
			rcRecOfTab.Equivalence.delete;
			rcRecOfTab.Default_Operating_Unit.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_pos_settings  in out nocopy tytbLD_pos_settings,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_pos_settings);
		for n in itbLD_pos_settings.first .. itbLD_pos_settings.last loop
			rcRecOfTab.Pos_Settings_Id(n) := itbLD_pos_settings(n).Pos_Settings_Id;
			rcRecOfTab.Supplier_Id(n) := itbLD_pos_settings(n).Supplier_Id;
			rcRecOfTab.Pos_Id(n) := itbLD_pos_settings(n).Pos_Id;
			rcRecOfTab.Equivalence(n) := itbLD_pos_settings(n).Equivalence;
			rcRecOfTab.Default_Operating_Unit(n) := itbLD_pos_settings(n).Default_Operating_Unit;
			rcRecOfTab.row_id(n) := itbLD_pos_settings(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPOS_SETTINGS_Id
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
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPOS_SETTINGS_Id = rcData.POS_SETTINGS_Id
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
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	IS
		rcError styLD_pos_settings;
	BEGIN		rcError.POS_SETTINGS_Id:=inuPOS_SETTINGS_Id;

		Load
		(
			inuPOS_SETTINGS_Id
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
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPOS_SETTINGS_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		orcRecord out nocopy styLD_pos_settings
	)
	IS
		rcError styLD_pos_settings;
	BEGIN		rcError.POS_SETTINGS_Id:=inuPOS_SETTINGS_Id;

		Load
		(
			inuPOS_SETTINGS_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN styLD_pos_settings
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id:=inuPOS_SETTINGS_Id;

		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type
	)
	RETURN styLD_pos_settings
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id:=inuPOS_SETTINGS_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOS_SETTINGS_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_pos_settings
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_pos_settings
	)
	IS
		rfLD_pos_settings tyrfLD_pos_settings;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_pos_settings.Pos_Settings_Id,
		            LD_pos_settings.Supplier_Id,
		            LD_pos_settings.Pos_Id,
		            LD_pos_settings.Equivalence,
		            LD_pos_settings.Default_Operating_Unit,
		            LD_pos_settings.rowid
                FROM LD_pos_settings';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_pos_settings for sbFullQuery;
		fetch rfLD_pos_settings bulk collect INTO otbResult;
		close rfLD_pos_settings;
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
		            LD_pos_settings.Pos_Settings_Id,
		            LD_pos_settings.Supplier_Id,
		            LD_pos_settings.Pos_Id,
		            LD_pos_settings.Equivalence,
		            LD_pos_settings.Default_Operating_Unit,
		            LD_pos_settings.rowid
                FROM LD_pos_settings';
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
		ircLD_pos_settings in styLD_pos_settings
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_pos_settings,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_pos_settings in styLD_pos_settings,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_pos_settings.POS_SETTINGS_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|POS_SETTINGS_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_pos_settings
		(
			Pos_Settings_Id,
			Supplier_Id,
			Pos_Id,
			Equivalence,
			Default_Operating_Unit
		)
		values
		(
			ircLD_pos_settings.Pos_Settings_Id,
			ircLD_pos_settings.Supplier_Id,
			ircLD_pos_settings.Pos_Id,
			ircLD_pos_settings.Equivalence,
			ircLD_pos_settings.Default_Operating_Unit
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_pos_settings));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_pos_settings in out nocopy tytbLD_pos_settings
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_pos_settings, blUseRowID);
		forall n in iotbLD_pos_settings.first..iotbLD_pos_settings.last
			insert into LD_pos_settings
			(
			Pos_Settings_Id,
			Supplier_Id,
			Pos_Id,
			Equivalence,
			Default_Operating_Unit
		)
		values
		(
			rcRecOfTab.Pos_Settings_Id(n),
			rcRecOfTab.Supplier_Id(n),
			rcRecOfTab.Pos_Id(n),
			rcRecOfTab.Equivalence(n),
			rcRecOfTab.Default_Operating_Unit(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id:=inuPOS_SETTINGS_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPOS_SETTINGS_Id,
				rcData
			);
		end if;

		delete
		from LD_pos_settings
		where
       		POS_SETTINGS_Id=inuPOS_SETTINGS_Id;
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
		rcError  styLD_pos_settings;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_pos_settings
		where
			rowid = iriRowID
		returning
   POS_SETTINGS_Id
		into
			rcError.POS_SETTINGS_Id;

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
		iotbLD_pos_settings in out nocopy tytbLD_pos_settings,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_pos_settings;
	BEGIN
		FillRecordOfTables(iotbLD_pos_settings, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last
				delete
				from LD_pos_settings
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last loop
					LockByPk
					(
							rcRecOfTab.POS_SETTINGS_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last
				delete
				from LD_pos_settings
				where
		         	POS_SETTINGS_Id = rcRecOfTab.POS_SETTINGS_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_pos_settings in styLD_pos_settings,
		inuLock	  in number default 0
	)
	IS
		nuPOS_SETTINGS_Id LD_pos_settings.POS_SETTINGS_Id%type;

	BEGIN
		if ircLD_pos_settings.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_pos_settings.rowid,rcData);
			end if;
			update LD_pos_settings
			set

        Supplier_Id = ircLD_pos_settings.Supplier_Id,
        Pos_Id = ircLD_pos_settings.Pos_Id,
        Equivalence = ircLD_pos_settings.Equivalence,
        Default_Operating_Unit = ircLD_pos_settings.Default_Operating_Unit
			where
				rowid = ircLD_pos_settings.rowid
			returning
    POS_SETTINGS_Id
			into
				nuPOS_SETTINGS_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_pos_settings.POS_SETTINGS_Id,
					rcData
				);
			end if;

			update LD_pos_settings
			set
        Supplier_Id = ircLD_pos_settings.Supplier_Id,
        Pos_Id = ircLD_pos_settings.Pos_Id,
        Equivalence = ircLD_pos_settings.Equivalence,
        Default_Operating_Unit = ircLD_pos_settings.Default_Operating_Unit
			where
	         	POS_SETTINGS_Id = ircLD_pos_settings.POS_SETTINGS_Id
			returning
    POS_SETTINGS_Id
			into
				nuPOS_SETTINGS_Id;
		end if;

		if
			nuPOS_SETTINGS_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_pos_settings));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_pos_settings in out nocopy tytbLD_pos_settings,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_pos_settings;
  BEGIN
    FillRecordOfTables(iotbLD_pos_settings,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last
        update LD_pos_settings
        set

            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Pos_Id = rcRecOfTab.Pos_Id(n),
            Equivalence = rcRecOfTab.Equivalence(n),
            Default_Operating_Unit = rcRecOfTab.Default_Operating_Unit(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last loop
          LockByPk
          (
              rcRecOfTab.POS_SETTINGS_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_pos_settings.first .. iotbLD_pos_settings.last
        update LD_pos_settings
        set
					Supplier_Id = rcRecOfTab.Supplier_Id(n),
					Pos_Id = rcRecOfTab.Pos_Id(n),
					Equivalence = rcRecOfTab.Equivalence(n),
					Default_Operating_Unit = rcRecOfTab.Default_Operating_Unit(n)
          where
          POS_SETTINGS_Id = rcRecOfTab.POS_SETTINGS_Id(n)
;
    end if;
  END;

	PROCEDURE updSupplier_Id
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuSupplier_Id$ in LD_pos_settings.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOS_SETTINGS_Id,
				rcData
			);
		end if;

		update LD_pos_settings
		set
			Supplier_Id = inuSupplier_Id$
		where
			POS_SETTINGS_Id = inuPOS_SETTINGS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPos_Id
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuPos_Id$ in LD_pos_settings.Pos_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOS_SETTINGS_Id,
				rcData
			);
		end if;

		update LD_pos_settings
		set
			Pos_Id = inuPos_Id$
		where
			POS_SETTINGS_Id = inuPOS_SETTINGS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Pos_Id:= inuPos_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updEquivalence
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		isbEquivalence$ in LD_pos_settings.Equivalence%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOS_SETTINGS_Id,
				rcData
			);
		end if;

		update LD_pos_settings
		set
			Equivalence = isbEquivalence$
		where
			POS_SETTINGS_Id = inuPOS_SETTINGS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Equivalence:= isbEquivalence$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDefault_Operating_Unit
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuDefault_Operating_Unit$ in LD_pos_settings.Default_Operating_Unit%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_pos_settings;
	BEGIN
		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOS_SETTINGS_Id,
				rcData
			);
		end if;

		update LD_pos_settings
		set
			Default_Operating_Unit = inuDefault_Operating_Unit$
		where
			POS_SETTINGS_Id = inuPOS_SETTINGS_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Default_Operating_Unit:= inuDefault_Operating_Unit$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPos_Settings_Id
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_pos_settings.Pos_Settings_Id%type
	IS
		rcError styLD_pos_settings;
	BEGIN

		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOS_SETTINGS_Id
			 )
		then
			 return(rcData.Pos_Settings_Id);
		end if;
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData.Pos_Settings_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSupplier_Id
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_pos_settings.Supplier_Id%type
	IS
		rcError styLD_pos_settings;
	BEGIN

		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOS_SETTINGS_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData.Supplier_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPos_Id
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_pos_settings.Pos_Id%type
	IS
		rcError styLD_pos_settings;
	BEGIN

		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOS_SETTINGS_Id
			 )
		then
			 return(rcData.Pos_Id);
		end if;
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData.Pos_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetEquivalence
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_pos_settings.Equivalence%type
	IS
		rcError styLD_pos_settings;
	BEGIN

		rcError.POS_SETTINGS_Id:=inuPOS_SETTINGS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOS_SETTINGS_Id
			 )
		then
			 return(rcData.Equivalence);
		end if;
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData.Equivalence);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetDefault_Operating_Unit
	(
		inuPOS_SETTINGS_Id in LD_pos_settings.POS_SETTINGS_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_pos_settings.Default_Operating_Unit%type
	IS
		rcError styLD_pos_settings;
	BEGIN

		rcError.POS_SETTINGS_Id := inuPOS_SETTINGS_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOS_SETTINGS_Id
			 )
		then
			 return(rcData.Default_Operating_Unit);
		end if;
		Load
		(
			inuPOS_SETTINGS_Id
		);
		return(rcData.Default_Operating_Unit);
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
end DALD_pos_settings;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_POS_SETTINGS
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_POS_SETTINGS', 'ADM_PERSON'); 
END;
/ 

