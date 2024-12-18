CREATE OR REPLACE PACKAGE adm_person.dald_finan_plan_fnb
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
  )
  IS
		SELECT LD_finan_plan_fnb.*,LD_finan_plan_fnb.rowid
		FROM LD_finan_plan_fnb
		WHERE
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_finan_plan_fnb.*,LD_finan_plan_fnb.rowid
		FROM LD_finan_plan_fnb
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_finan_plan_fnb  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_finan_plan_fnb is table of styLD_finan_plan_fnb index by binary_integer;
	type tyrfRecords is ref cursor return styLD_finan_plan_fnb;

	/* Tipos referenciando al registro */
	type tytbFinan_Plan_Fnb_Id is table of LD_finan_plan_fnb.Finan_Plan_Fnb_Id%type index by binary_integer;
	type tytbFinancing_Plan_Id is table of LD_finan_plan_fnb.Financing_Plan_Id%type index by binary_integer;
	type tytbLine_Id is table of LD_finan_plan_fnb.Line_Id%type index by binary_integer;
	type tytbSubline_Id is table of LD_finan_plan_fnb.Subline_Id%type index by binary_integer;
	type tytbGeograp_Location_Id is table of LD_finan_plan_fnb.Geograp_Location_Id%type index by binary_integer;
	type tytbCategory_Id is table of LD_finan_plan_fnb.Category_Id%type index by binary_integer;
	type tytbSubcategory_Id is table of LD_finan_plan_fnb.Subcategory_Id%type index by binary_integer;
	type tytbSale_Chanel_Id is table of LD_finan_plan_fnb.Sale_Chanel_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_finan_plan_fnb is record
	(

		Finan_Plan_Fnb_Id   tytbFinan_Plan_Fnb_Id,
		Financing_Plan_Id   tytbFinancing_Plan_Id,
		Line_Id   tytbLine_Id,
		Subline_Id   tytbSubline_Id,
		Geograp_Location_Id   tytbGeograp_Location_Id,
		Category_Id   tytbCategory_Id,
		Subcategory_Id   tytbSubcategory_Id,
		Sale_Chanel_Id   tytbSale_Chanel_Id,
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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	);

	PROCEDURE getRecord
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		orcRecord out nocopy styLD_finan_plan_fnb
	);

	FUNCTION frcGetRcData
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN styLD_finan_plan_fnb;

	FUNCTION frcGetRcData
	RETURN styLD_finan_plan_fnb;

	FUNCTION frcGetRecord
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN styLD_finan_plan_fnb;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_finan_plan_fnb
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_finan_plan_fnb in styLD_finan_plan_fnb
	);

 	  PROCEDURE insRecord
	(
		ircLD_finan_plan_fnb in styLD_finan_plan_fnb,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_finan_plan_fnb in out nocopy tytbLD_finan_plan_fnb
	);

	PROCEDURE delRecord
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_finan_plan_fnb in out nocopy tytbLD_finan_plan_fnb,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_finan_plan_fnb in styLD_finan_plan_fnb,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_finan_plan_fnb in out nocopy tytbLD_finan_plan_fnb,
		inuLock in number default 1
	);

		PROCEDURE updFinancing_Plan_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuFinancing_Plan_Id$  in LD_finan_plan_fnb.Financing_Plan_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLine_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuLine_Id$  in LD_finan_plan_fnb.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubline_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuSubline_Id$  in LD_finan_plan_fnb.Subline_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGeograp_Location_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuGeograp_Location_Id$  in LD_finan_plan_fnb.Geograp_Location_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCategory_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuCategory_Id$  in LD_finan_plan_fnb.Category_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubcategory_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuSubcategory_Id$  in LD_finan_plan_fnb.Subcategory_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSale_Chanel_Id
		(
				inuFINAN_PLAN_FNB_Id   in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
				inuSale_Chanel_Id$  in LD_finan_plan_fnb.Sale_Chanel_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetFinan_Plan_Fnb_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Finan_Plan_Fnb_Id%type;

    	FUNCTION fnuGetFinancing_Plan_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Financing_Plan_Id%type;

    	FUNCTION fnuGetLine_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Line_Id%type;

    	FUNCTION fnuGetSubline_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Subline_Id%type;

    	FUNCTION fnuGetGeograp_Location_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Geograp_Location_Id%type;

    	FUNCTION fnuGetCategory_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Category_Id%type;

    	FUNCTION fnuGetSubcategory_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Subcategory_Id%type;

    	FUNCTION fnuGetSale_Chanel_Id
    	(
    	    inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_finan_plan_fnb.Sale_Chanel_Id%type;


	PROCEDURE LockByPk
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		orcLD_finan_plan_fnb  out styLD_finan_plan_fnb
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_finan_plan_fnb  out styLD_finan_plan_fnb
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_finan_plan_fnb;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_finan_plan_fnb
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_FINAN_PLAN_FNB';
	  cnuGeEntityId constant varchar2(30) := 8531; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	IS
		SELECT LD_finan_plan_fnb.*,LD_finan_plan_fnb.rowid
		FROM LD_finan_plan_fnb
		WHERE  FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_finan_plan_fnb.*,LD_finan_plan_fnb.rowid
		FROM LD_finan_plan_fnb
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_finan_plan_fnb is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_finan_plan_fnb;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_finan_plan_fnb default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.FINAN_PLAN_FNB_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		orcLD_finan_plan_fnb  out styLD_finan_plan_fnb
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		Open cuLockRcByPk
		(
			inuFINAN_PLAN_FNB_Id
		);

		fetch cuLockRcByPk into orcLD_finan_plan_fnb;
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
		orcLD_finan_plan_fnb  out styLD_finan_plan_fnb
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_finan_plan_fnb;
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
		itbLD_finan_plan_fnb  in out nocopy tytbLD_finan_plan_fnb
	)
	IS
	BEGIN
			rcRecOfTab.Finan_Plan_Fnb_Id.delete;
			rcRecOfTab.Financing_Plan_Id.delete;
			rcRecOfTab.Line_Id.delete;
			rcRecOfTab.Subline_Id.delete;
			rcRecOfTab.Geograp_Location_Id.delete;
			rcRecOfTab.Category_Id.delete;
			rcRecOfTab.Subcategory_Id.delete;
			rcRecOfTab.Sale_Chanel_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_finan_plan_fnb  in out nocopy tytbLD_finan_plan_fnb,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_finan_plan_fnb);
		for n in itbLD_finan_plan_fnb.first .. itbLD_finan_plan_fnb.last loop
			rcRecOfTab.Finan_Plan_Fnb_Id(n) := itbLD_finan_plan_fnb(n).Finan_Plan_Fnb_Id;
			rcRecOfTab.Financing_Plan_Id(n) := itbLD_finan_plan_fnb(n).Financing_Plan_Id;
			rcRecOfTab.Line_Id(n) := itbLD_finan_plan_fnb(n).Line_Id;
			rcRecOfTab.Subline_Id(n) := itbLD_finan_plan_fnb(n).Subline_Id;
			rcRecOfTab.Geograp_Location_Id(n) := itbLD_finan_plan_fnb(n).Geograp_Location_Id;
			rcRecOfTab.Category_Id(n) := itbLD_finan_plan_fnb(n).Category_Id;
			rcRecOfTab.Subcategory_Id(n) := itbLD_finan_plan_fnb(n).Subcategory_Id;
			rcRecOfTab.Sale_Chanel_Id(n) := itbLD_finan_plan_fnb(n).Sale_Chanel_Id;
			rcRecOfTab.row_id(n) := itbLD_finan_plan_fnb(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuFINAN_PLAN_FNB_Id
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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuFINAN_PLAN_FNB_Id = rcData.FINAN_PLAN_FNB_Id
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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN		rcError.FINAN_PLAN_FNB_Id:=inuFINAN_PLAN_FNB_Id;

		Load
		(
			inuFINAN_PLAN_FNB_Id
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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		orcRecord out nocopy styLD_finan_plan_fnb
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN		rcError.FINAN_PLAN_FNB_Id:=inuFINAN_PLAN_FNB_Id;

		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN styLD_finan_plan_fnb
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id:=inuFINAN_PLAN_FNB_Id;

		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type
	)
	RETURN styLD_finan_plan_fnb
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id:=inuFINAN_PLAN_FNB_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_finan_plan_fnb
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_finan_plan_fnb
	)
	IS
		rfLD_finan_plan_fnb tyrfLD_finan_plan_fnb;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_finan_plan_fnb.Finan_Plan_Fnb_Id,
		            LD_finan_plan_fnb.Financing_Plan_Id,
		            LD_finan_plan_fnb.Line_Id,
		            LD_finan_plan_fnb.Subline_Id,
		            LD_finan_plan_fnb.Geograp_Location_Id,
		            LD_finan_plan_fnb.Category_Id,
		            LD_finan_plan_fnb.Subcategory_Id,
		            LD_finan_plan_fnb.Sale_Chanel_Id,
		            LD_finan_plan_fnb.rowid
                FROM LD_finan_plan_fnb';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_finan_plan_fnb for sbFullQuery;
		fetch rfLD_finan_plan_fnb bulk collect INTO otbResult;
		close rfLD_finan_plan_fnb;
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
		            LD_finan_plan_fnb.Finan_Plan_Fnb_Id,
		            LD_finan_plan_fnb.Financing_Plan_Id,
		            LD_finan_plan_fnb.Line_Id,
		            LD_finan_plan_fnb.Subline_Id,
		            LD_finan_plan_fnb.Geograp_Location_Id,
		            LD_finan_plan_fnb.Category_Id,
		            LD_finan_plan_fnb.Subcategory_Id,
		            LD_finan_plan_fnb.Sale_Chanel_Id,
		            LD_finan_plan_fnb.rowid
                FROM LD_finan_plan_fnb';
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
		ircLD_finan_plan_fnb in styLD_finan_plan_fnb
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_finan_plan_fnb,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_finan_plan_fnb in styLD_finan_plan_fnb,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_finan_plan_fnb.FINAN_PLAN_FNB_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|FINAN_PLAN_FNB_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_finan_plan_fnb
		(
			Finan_Plan_Fnb_Id,
			Financing_Plan_Id,
			Line_Id,
			Subline_Id,
			Geograp_Location_Id,
			Category_Id,
			Subcategory_Id,
			Sale_Chanel_Id
		)
		values
		(
			ircLD_finan_plan_fnb.Finan_Plan_Fnb_Id,
			ircLD_finan_plan_fnb.Financing_Plan_Id,
			ircLD_finan_plan_fnb.Line_Id,
			ircLD_finan_plan_fnb.Subline_Id,
			ircLD_finan_plan_fnb.Geograp_Location_Id,
			ircLD_finan_plan_fnb.Category_Id,
			ircLD_finan_plan_fnb.Subcategory_Id,
			ircLD_finan_plan_fnb.Sale_Chanel_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_finan_plan_fnb));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_finan_plan_fnb in out nocopy tytbLD_finan_plan_fnb
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_finan_plan_fnb, blUseRowID);
		forall n in iotbLD_finan_plan_fnb.first..iotbLD_finan_plan_fnb.last
			insert into LD_finan_plan_fnb
			(
			Finan_Plan_Fnb_Id,
			Financing_Plan_Id,
			Line_Id,
			Subline_Id,
			Geograp_Location_Id,
			Category_Id,
			Subcategory_Id,
			Sale_Chanel_Id
		)
		values
		(
			rcRecOfTab.Finan_Plan_Fnb_Id(n),
			rcRecOfTab.Financing_Plan_Id(n),
			rcRecOfTab.Line_Id(n),
			rcRecOfTab.Subline_Id(n),
			rcRecOfTab.Geograp_Location_Id(n),
			rcRecOfTab.Category_Id(n),
			rcRecOfTab.Subcategory_Id(n),
			rcRecOfTab.Sale_Chanel_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id:=inuFINAN_PLAN_FNB_Id;

		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		delete
		from LD_finan_plan_fnb
		where
       		FINAN_PLAN_FNB_Id=inuFINAN_PLAN_FNB_Id;
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
		rcError  styLD_finan_plan_fnb;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_finan_plan_fnb
		where
			rowid = iriRowID
		returning
   FINAN_PLAN_FNB_Id
		into
			rcError.FINAN_PLAN_FNB_Id;

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
		iotbLD_finan_plan_fnb in out nocopy tytbLD_finan_plan_fnb,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_finan_plan_fnb;
	BEGIN
		FillRecordOfTables(iotbLD_finan_plan_fnb, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last
				delete
				from LD_finan_plan_fnb
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last loop
					LockByPk
					(
							rcRecOfTab.FINAN_PLAN_FNB_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last
				delete
				from LD_finan_plan_fnb
				where
		         	FINAN_PLAN_FNB_Id = rcRecOfTab.FINAN_PLAN_FNB_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_finan_plan_fnb in styLD_finan_plan_fnb,
		inuLock	  in number default 0
	)
	IS
		nuFINAN_PLAN_FNB_Id LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type;

	BEGIN
		if ircLD_finan_plan_fnb.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_finan_plan_fnb.rowid,rcData);
			end if;
			update LD_finan_plan_fnb
			set

        Financing_Plan_Id = ircLD_finan_plan_fnb.Financing_Plan_Id,
        Line_Id = ircLD_finan_plan_fnb.Line_Id,
        Subline_Id = ircLD_finan_plan_fnb.Subline_Id,
        Geograp_Location_Id = ircLD_finan_plan_fnb.Geograp_Location_Id,
        Category_Id = ircLD_finan_plan_fnb.Category_Id,
        Subcategory_Id = ircLD_finan_plan_fnb.Subcategory_Id,
        Sale_Chanel_Id = ircLD_finan_plan_fnb.Sale_Chanel_Id
			where
				rowid = ircLD_finan_plan_fnb.rowid
			returning
    FINAN_PLAN_FNB_Id
			into
				nuFINAN_PLAN_FNB_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_finan_plan_fnb.FINAN_PLAN_FNB_Id,
					rcData
				);
			end if;

			update LD_finan_plan_fnb
			set
        Financing_Plan_Id = ircLD_finan_plan_fnb.Financing_Plan_Id,
        Line_Id = ircLD_finan_plan_fnb.Line_Id,
        Subline_Id = ircLD_finan_plan_fnb.Subline_Id,
        Geograp_Location_Id = ircLD_finan_plan_fnb.Geograp_Location_Id,
        Category_Id = ircLD_finan_plan_fnb.Category_Id,
        Subcategory_Id = ircLD_finan_plan_fnb.Subcategory_Id,
        Sale_Chanel_Id = ircLD_finan_plan_fnb.Sale_Chanel_Id
			where
	         	FINAN_PLAN_FNB_Id = ircLD_finan_plan_fnb.FINAN_PLAN_FNB_Id
			returning
    FINAN_PLAN_FNB_Id
			into
				nuFINAN_PLAN_FNB_Id;
		end if;

		if
			nuFINAN_PLAN_FNB_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_finan_plan_fnb));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_finan_plan_fnb in out nocopy tytbLD_finan_plan_fnb,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_finan_plan_fnb;
  BEGIN
    FillRecordOfTables(iotbLD_finan_plan_fnb,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last
        update LD_finan_plan_fnb
        set

            Financing_Plan_Id = rcRecOfTab.Financing_Plan_Id(n),
            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Category_Id = rcRecOfTab.Category_Id(n),
            Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
            Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last loop
          LockByPk
          (
              rcRecOfTab.FINAN_PLAN_FNB_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_finan_plan_fnb.first .. iotbLD_finan_plan_fnb.last
        update LD_finan_plan_fnb
        set
					Financing_Plan_Id = rcRecOfTab.Financing_Plan_Id(n),
					Line_Id = rcRecOfTab.Line_Id(n),
					Subline_Id = rcRecOfTab.Subline_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n)
          where
          FINAN_PLAN_FNB_Id = rcRecOfTab.FINAN_PLAN_FNB_Id(n)
;
    end if;
  END;

	PROCEDURE updFinancing_Plan_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuFinancing_Plan_Id$ in LD_finan_plan_fnb.Financing_Plan_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Financing_Plan_Id = inuFinancing_Plan_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Financing_Plan_Id:= inuFinancing_Plan_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLine_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuLine_Id$ in LD_finan_plan_fnb.Line_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Line_Id = inuLine_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Line_Id:= inuLine_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubline_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuSubline_Id$ in LD_finan_plan_fnb.Subline_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Subline_Id = inuSubline_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subline_Id:= inuSubline_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updGeograp_Location_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuGeograp_Location_Id$ in LD_finan_plan_fnb.Geograp_Location_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCategory_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuCategory_Id$ in LD_finan_plan_fnb.Category_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Category_Id = inuCategory_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuSubcategory_Id$ in LD_finan_plan_fnb.Subcategory_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Subcategory_Id = inuSubcategory_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subcategory_Id:= inuSubcategory_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSale_Chanel_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuSale_Chanel_Id$ in LD_finan_plan_fnb.Sale_Chanel_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN
		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;
		if inuLock=1 then
			LockByPk
			(
				inuFINAN_PLAN_FNB_Id,
				rcData
			);
		end if;

		update LD_finan_plan_fnb
		set
			Sale_Chanel_Id = inuSale_Chanel_Id$
		where
			FINAN_PLAN_FNB_Id = inuFINAN_PLAN_FNB_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Sale_Chanel_Id:= inuSale_Chanel_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetFinan_Plan_Fnb_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Finan_Plan_Fnb_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Finan_Plan_Fnb_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData.Finan_Plan_Fnb_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFinancing_Plan_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Financing_Plan_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Financing_Plan_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData.Financing_Plan_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLine_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Line_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Line_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData.Line_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubline_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Subline_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Subline_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData.Subline_Id);
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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Geograp_Location_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Geograp_Location_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
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

	FUNCTION fnuGetCategory_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Category_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Category_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
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
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Subcategory_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Subcategory_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
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

	FUNCTION fnuGetSale_Chanel_Id
	(
		inuFINAN_PLAN_FNB_Id in LD_finan_plan_fnb.FINAN_PLAN_FNB_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_finan_plan_fnb.Sale_Chanel_Id%type
	IS
		rcError styLD_finan_plan_fnb;
	BEGIN

		rcError.FINAN_PLAN_FNB_Id := inuFINAN_PLAN_FNB_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuFINAN_PLAN_FNB_Id
			 )
		then
			 return(rcData.Sale_Chanel_Id);
		end if;
		Load
		(
			inuFINAN_PLAN_FNB_Id
		);
		return(rcData.Sale_Chanel_Id);
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
end DALD_finan_plan_fnb;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_FINAN_PLAN_FNB
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_FINAN_PLAN_FNB', 'ADM_PERSON'); 
END;
/