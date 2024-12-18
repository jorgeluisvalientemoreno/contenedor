CREATE OR REPLACE PACKAGE adm_person.dald_launch
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
  )
  IS
		SELECT LD_launch.*,LD_launch.rowid
		FROM LD_launch
		WHERE
			LAUNCH_Id = inuLAUNCH_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_launch.*,LD_launch.rowid
		FROM LD_launch
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_launch  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_launch is table of styLD_launch index by binary_integer;
	type tyrfRecords is ref cursor return styLD_launch;

	/* Tipos referenciando al registro */
	type tytbLaunch_Id is table of LD_launch.Launch_Id%type index by binary_integer;
	type tytbProduct_Line_Id is table of LD_launch.Product_Line_Id%type index by binary_integer;
	type tytbCutting_State_Id is table of LD_launch.Cutting_State_Id%type index by binary_integer;
	type tytbProduct_State is table of LD_launch.Product_State%type index by binary_integer;
	type tytbCategory_Id is table of LD_launch.Category_Id%type index by binary_integer;
	type tytbSubcategory_Id is table of LD_launch.Subcategory_Id%type index by binary_integer;
	type tytbGeograp_Location_Id is table of LD_launch.Geograp_Location_Id%type index by binary_integer;
	type tytbPolicy_Type_Id is table of LD_launch.Policy_Type_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_launch is record
	(

		Launch_Id   tytbLaunch_Id,
		Product_Line_Id   tytbProduct_Line_Id,
		Cutting_State_Id   tytbCutting_State_Id,
		Product_State   tytbProduct_State,
		Category_Id   tytbCategory_Id,
		Subcategory_Id   tytbSubcategory_Id,
		Geograp_Location_Id   tytbGeograp_Location_Id,
		Policy_Type_Id   tytbPolicy_Type_Id,
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
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	);

	PROCEDURE getRecord
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		orcRecord out nocopy styLD_launch
	);

	FUNCTION frcGetRcData
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN styLD_launch;

	FUNCTION frcGetRcData
	RETURN styLD_launch;

	FUNCTION frcGetRecord
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN styLD_launch;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_launch
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_launch in styLD_launch
	);

 	  PROCEDURE insRecord
	(
		ircLD_launch in styLD_launch,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_launch in out nocopy tytbLD_launch
	);

	PROCEDURE delRecord
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_launch in out nocopy tytbLD_launch,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_launch in styLD_launch,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_launch in out nocopy tytbLD_launch,
		inuLock in number default 1
	);

		PROCEDURE updProduct_Line_Id
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuProduct_Line_Id$  in LD_launch.Product_Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCutting_State_Id
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuCutting_State_Id$  in LD_launch.Cutting_State_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updProduct_State
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuProduct_State$  in LD_launch.Product_State%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCategory_Id
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuCategory_Id$  in LD_launch.Category_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubcategory_Id
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuSubcategory_Id$  in LD_launch.Subcategory_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGeograp_Location_Id
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuGeograp_Location_Id$  in LD_launch.Geograp_Location_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPolicy_Type_Id
		(
				inuLAUNCH_Id   in LD_launch.LAUNCH_Id%type,
				inuPolicy_Type_Id$  in LD_launch.Policy_Type_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetLaunch_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Launch_Id%type;

    	FUNCTION fnuGetProduct_Line_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Product_Line_Id%type;

    	FUNCTION fnuGetCutting_State_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Cutting_State_Id%type;

    	FUNCTION fnuGetProduct_State
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Product_State%type;

    	FUNCTION fnuGetCategory_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Category_Id%type;

    	FUNCTION fnuGetSubcategory_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Subcategory_Id%type;

    	FUNCTION fnuGetGeograp_Location_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Geograp_Location_Id%type;

    	FUNCTION fnuGetPolicy_Type_Id
    	(
    	    inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_launch.Policy_Type_Id%type;


	PROCEDURE LockByPk
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		orcLD_launch  out styLD_launch
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_launch  out styLD_launch
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_launch;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_launch
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO147879';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_LAUNCH';
	  cnuGeEntityId constant varchar2(30) := 8361; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	IS
		SELECT LD_launch.*,LD_launch.rowid
		FROM LD_launch
		WHERE  LAUNCH_Id = inuLAUNCH_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_launch.*,LD_launch.rowid
		FROM LD_launch
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_launch is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_launch;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_launch default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LAUNCH_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		orcLD_launch  out styLD_launch
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;

		Open cuLockRcByPk
		(
			inuLAUNCH_Id
		);

		fetch cuLockRcByPk into orcLD_launch;
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
		orcLD_launch  out styLD_launch
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_launch;
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
		itbLD_launch  in out nocopy tytbLD_launch
	)
	IS
	BEGIN
			rcRecOfTab.Launch_Id.delete;
			rcRecOfTab.Product_Line_Id.delete;
			rcRecOfTab.Cutting_State_Id.delete;
			rcRecOfTab.Product_State.delete;
			rcRecOfTab.Category_Id.delete;
			rcRecOfTab.Subcategory_Id.delete;
			rcRecOfTab.Geograp_Location_Id.delete;
			rcRecOfTab.Policy_Type_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_launch  in out nocopy tytbLD_launch,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_launch);
		for n in itbLD_launch.first .. itbLD_launch.last loop
			rcRecOfTab.Launch_Id(n) := itbLD_launch(n).Launch_Id;
			rcRecOfTab.Product_Line_Id(n) := itbLD_launch(n).Product_Line_Id;
			rcRecOfTab.Cutting_State_Id(n) := itbLD_launch(n).Cutting_State_Id;
			rcRecOfTab.Product_State(n) := itbLD_launch(n).Product_State;
			rcRecOfTab.Category_Id(n) := itbLD_launch(n).Category_Id;
			rcRecOfTab.Subcategory_Id(n) := itbLD_launch(n).Subcategory_Id;
			rcRecOfTab.Geograp_Location_Id(n) := itbLD_launch(n).Geograp_Location_Id;
			rcRecOfTab.Policy_Type_Id(n) := itbLD_launch(n).Policy_Type_Id;
			rcRecOfTab.row_id(n) := itbLD_launch(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLAUNCH_Id
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
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLAUNCH_Id = rcData.LAUNCH_Id
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
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLAUNCH_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	IS
		rcError styLD_launch;
	BEGIN		rcError.LAUNCH_Id:=inuLAUNCH_Id;

		Load
		(
			inuLAUNCH_Id
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
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuLAUNCH_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		orcRecord out nocopy styLD_launch
	)
	IS
		rcError styLD_launch;
	BEGIN		rcError.LAUNCH_Id:=inuLAUNCH_Id;

		Load
		(
			inuLAUNCH_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN styLD_launch
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id:=inuLAUNCH_Id;

		Load
		(
			inuLAUNCH_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type
	)
	RETURN styLD_launch
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id:=inuLAUNCH_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLAUNCH_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_launch
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_launch
	)
	IS
		rfLD_launch tyrfLD_launch;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_launch.Launch_Id,
		            LD_launch.Product_Line_Id,
		            LD_launch.Cutting_State_Id,
		            LD_launch.Product_State,
		            LD_launch.Category_Id,
		            LD_launch.Subcategory_Id,
		            LD_launch.Geograp_Location_Id,
		            LD_launch.Policy_Type_Id,
		            LD_launch.rowid
                FROM LD_launch';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_launch for sbFullQuery;
		fetch rfLD_launch bulk collect INTO otbResult;
		close rfLD_launch;

	EXCEPTION
		when others then
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
		            LD_launch.Launch_Id,
		            LD_launch.Product_Line_Id,
		            LD_launch.Cutting_State_Id,
		            LD_launch.Product_State,
		            LD_launch.Category_Id,
		            LD_launch.Subcategory_Id,
		            LD_launch.Geograp_Location_Id,
		            LD_launch.Policy_Type_Id,
		            LD_launch.rowid
                FROM LD_launch';
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
		ircLD_launch in styLD_launch
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_launch,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_launch in styLD_launch,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_launch.LAUNCH_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LAUNCH_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_launch
		(
			Launch_Id,
			Product_Line_Id,
			Cutting_State_Id,
			Product_State,
			Category_Id,
			Subcategory_Id,
			Geograp_Location_Id,
			Policy_Type_Id
		)
		values
		(
			ircLD_launch.Launch_Id,
			ircLD_launch.Product_Line_Id,
			ircLD_launch.Cutting_State_Id,
			ircLD_launch.Product_State,
			ircLD_launch.Category_Id,
			ircLD_launch.Subcategory_Id,
			ircLD_launch.Geograp_Location_Id,
			ircLD_launch.Policy_Type_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_launch));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_launch in out nocopy tytbLD_launch
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_launch, blUseRowID);
		forall n in iotbLD_launch.first..iotbLD_launch.last
			insert into LD_launch
			(
			Launch_Id,
			Product_Line_Id,
			Cutting_State_Id,
			Product_State,
			Category_Id,
			Subcategory_Id,
			Geograp_Location_Id,
			Policy_Type_Id
		)
		values
		(
			rcRecOfTab.Launch_Id(n),
			rcRecOfTab.Product_Line_Id(n),
			rcRecOfTab.Cutting_State_Id(n),
			rcRecOfTab.Product_State(n),
			rcRecOfTab.Category_Id(n),
			rcRecOfTab.Subcategory_Id(n),
			rcRecOfTab.Geograp_Location_Id(n),
			rcRecOfTab.Policy_Type_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id:=inuLAUNCH_Id;

		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		delete
		from LD_launch
		where
       		LAUNCH_Id=inuLAUNCH_Id;
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
		rcError  styLD_launch;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_launch
		where
			rowid = iriRowID
		returning
   LAUNCH_Id
		into
			rcError.LAUNCH_Id;

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
		iotbLD_launch in out nocopy tytbLD_launch,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_launch;
	BEGIN
		FillRecordOfTables(iotbLD_launch, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_launch.first .. iotbLD_launch.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_launch.first .. iotbLD_launch.last
				delete
				from LD_launch
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_launch.first .. iotbLD_launch.last loop
					LockByPk
					(
							rcRecOfTab.LAUNCH_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_launch.first .. iotbLD_launch.last
				delete
				from LD_launch
				where
		         	LAUNCH_Id = rcRecOfTab.LAUNCH_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_launch in styLD_launch,
		inuLock	  in number default 0
	)
	IS
		nuLAUNCH_Id LD_launch.LAUNCH_Id%type;

	BEGIN
		if ircLD_launch.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_launch.rowid,rcData);
			end if;
			update LD_launch
			set

        Product_Line_Id = ircLD_launch.Product_Line_Id,
        Cutting_State_Id = ircLD_launch.Cutting_State_Id,
        Product_State = ircLD_launch.Product_State,
        Category_Id = ircLD_launch.Category_Id,
        Subcategory_Id = ircLD_launch.Subcategory_Id,
        Geograp_Location_Id = ircLD_launch.Geograp_Location_Id,
        Policy_Type_Id = ircLD_launch.Policy_Type_Id
			where
				rowid = ircLD_launch.rowid
			returning
    LAUNCH_Id
			into
				nuLAUNCH_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_launch.LAUNCH_Id,
					rcData
				);
			end if;

			update LD_launch
			set
        Product_Line_Id = ircLD_launch.Product_Line_Id,
        Cutting_State_Id = ircLD_launch.Cutting_State_Id,
        Product_State = ircLD_launch.Product_State,
        Category_Id = ircLD_launch.Category_Id,
        Subcategory_Id = ircLD_launch.Subcategory_Id,
        Geograp_Location_Id = ircLD_launch.Geograp_Location_Id,
        Policy_Type_Id = ircLD_launch.Policy_Type_Id
			where
	         	LAUNCH_Id = ircLD_launch.LAUNCH_Id
			returning
    LAUNCH_Id
			into
				nuLAUNCH_Id;
		end if;

		if
			nuLAUNCH_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_launch));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_launch in out nocopy tytbLD_launch,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_launch;
  BEGIN
    FillRecordOfTables(iotbLD_launch,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_launch.first .. iotbLD_launch.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_launch.first .. iotbLD_launch.last
        update LD_launch
        set

            Product_Line_Id = rcRecOfTab.Product_Line_Id(n),
            Cutting_State_Id = rcRecOfTab.Cutting_State_Id(n),
            Product_State = rcRecOfTab.Product_State(n),
            Category_Id = rcRecOfTab.Category_Id(n),
            Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Policy_Type_Id = rcRecOfTab.Policy_Type_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_launch.first .. iotbLD_launch.last loop
          LockByPk
          (
              rcRecOfTab.LAUNCH_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_launch.first .. iotbLD_launch.last
        update LD_launch
        set
					Product_Line_Id = rcRecOfTab.Product_Line_Id(n),
					Cutting_State_Id = rcRecOfTab.Cutting_State_Id(n),
					Product_State = rcRecOfTab.Product_State(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Policy_Type_Id = rcRecOfTab.Policy_Type_Id(n)
          where
          LAUNCH_Id = rcRecOfTab.LAUNCH_Id(n)
;
    end if;
  END;

	PROCEDURE updProduct_Line_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuProduct_Line_Id$ in LD_launch.Product_Line_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Product_Line_Id = inuProduct_Line_Id$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Product_Line_Id:= inuProduct_Line_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCutting_State_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuCutting_State_Id$ in LD_launch.Cutting_State_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Cutting_State_Id = inuCutting_State_Id$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Cutting_State_Id:= inuCutting_State_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updProduct_State
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuProduct_State$ in LD_launch.Product_State%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Product_State = inuProduct_State$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Product_State:= inuProduct_State$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCategory_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuCategory_Id$ in LD_launch.Category_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Category_Id = inuCategory_Id$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Category_Id:= inuCategory_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubcategory_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuSubcategory_Id$ in LD_launch.Subcategory_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Subcategory_Id = inuSubcategory_Id$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subcategory_Id:= inuSubcategory_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updGeograp_Location_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuGeograp_Location_Id$ in LD_launch.Geograp_Location_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPolicy_Type_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuPolicy_Type_Id$ in LD_launch.Policy_Type_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_launch;
	BEGIN
		rcError.LAUNCH_Id := inuLAUNCH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLAUNCH_Id,
				rcData
			);
		end if;

		update LD_launch
		set
			Policy_Type_Id = inuPolicy_Type_Id$
		where
			LAUNCH_Id = inuLAUNCH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Policy_Type_Id:= inuPolicy_Type_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetLaunch_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Launch_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Launch_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Launch_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetProduct_Line_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Product_Line_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Product_Line_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
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

	FUNCTION fnuGetCutting_State_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Cutting_State_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Cutting_State_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Cutting_State_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetProduct_State
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Product_State%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Product_State);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Product_State);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCategory_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Category_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Category_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Category_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubcategory_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Subcategory_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Subcategory_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Subcategory_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetGeograp_Location_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Geograp_Location_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Geograp_Location_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Geograp_Location_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPolicy_Type_Id
	(
		inuLAUNCH_Id in LD_launch.LAUNCH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_launch.Policy_Type_Id%type
	IS
		rcError styLD_launch;
	BEGIN

		rcError.LAUNCH_Id := inuLAUNCH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLAUNCH_Id
			 )
		then
			 return(rcData.Policy_Type_Id);
		end if;
		Load
		(
			inuLAUNCH_Id
		);
		return(rcData.Policy_Type_Id);
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
end DALD_launch;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_LAUNCH
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_LAUNCH', 'ADM_PERSON'); 
END;
/