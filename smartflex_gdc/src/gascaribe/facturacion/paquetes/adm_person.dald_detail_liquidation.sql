CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_detail_liquidation
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
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
  )
  IS
		SELECT LD_detail_liquidation.*,LD_detail_liquidation.rowid
		FROM LD_detail_liquidation
		WHERE
			detail_liquidation_Id = inudetail_liquidation_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_detail_liquidation.*,LD_detail_liquidation.rowid
		FROM LD_detail_liquidation
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_detail_liquidation  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_detail_liquidation is table of styLD_detail_liquidation index by binary_integer;
	type tyrfRecords is ref cursor return styLD_detail_liquidation;

	/* Tipos referenciando al registro */
	type tytbDetail_Liquidation_Id is table of LD_detail_liquidation.Detail_Liquidation_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_detail_liquidation.Package_Id%type index by binary_integer;
	type tytbFinancing_Code_Id is table of LD_detail_liquidation.Financing_Code_Id%type index by binary_integer;
	type tytbPending_Balance is table of LD_detail_liquidation.Pending_Balance%type index by binary_integer;
	type tytbConcept_Id is table of LD_detail_liquidation.Concept_Id%type index by binary_integer;
	type tytbTotal_Value is table of LD_detail_liquidation.Total_Value%type index by binary_integer;
	type tytbFinancing_Interest is table of LD_detail_liquidation.Financing_Interest%type index by binary_integer;
	type tytbCurrent_Value is table of LD_detail_liquidation.Current_Value%type index by binary_integer;
	type tytbSecure_Value is table of LD_detail_liquidation.Secure_Value%type index by binary_integer;
	type tytbState is table of LD_detail_liquidation.State%type index by binary_integer;
	type tytbLiquidation_Id is table of LD_detail_liquidation.Liquidation_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_detail_liquidation is record
	(

		Detail_Liquidation_Id   tytbDetail_Liquidation_Id,
		Package_Id   tytbPackage_Id,
		Financing_Code_Id   tytbFinancing_Code_Id,
		Pending_Balance   tytbPending_Balance,
		Concept_Id   tytbConcept_Id,
		Total_Value   tytbTotal_Value,
		Financing_Interest   tytbFinancing_Interest,
		Current_Value   tytbCurrent_Value,
		Secure_Value   tytbSecure_Value,
		State   tytbState,
		Liquidation_Id   tytbLiquidation_Id,
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
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	);

	PROCEDURE getRecord
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		orcRecord out nocopy styLD_detail_liquidation
	);

	FUNCTION frcGetRcData
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN styLD_detail_liquidation;

	FUNCTION frcGetRcData
	RETURN styLD_detail_liquidation;

	FUNCTION frcGetRecord
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN styLD_detail_liquidation;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_detail_liquidation
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_detail_liquidation in styLD_detail_liquidation
	);

 	  PROCEDURE insRecord
	(
		ircLD_detail_liquidation in styLD_detail_liquidation,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_detail_liquidation in out nocopy tytbLD_detail_liquidation
	);

	PROCEDURE delRecord
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_detail_liquidation in out nocopy tytbLD_detail_liquidation,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_detail_liquidation in styLD_detail_liquidation,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_detail_liquidation in out nocopy tytbLD_detail_liquidation,
		inuLock in number default 1
	);

		PROCEDURE updPackage_Id
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuPackage_Id$  in LD_detail_liquidation.Package_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinancing_Code_Id
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuFinancing_Code_Id$  in LD_detail_liquidation.Financing_Code_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPending_Balance
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuPending_Balance$  in LD_detail_liquidation.Pending_Balance%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updConcept_Id
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuConcept_Id$  in LD_detail_liquidation.Concept_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updTotal_Value
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuTotal_Value$  in LD_detail_liquidation.Total_Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinancing_Interest
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuFinancing_Interest$  in LD_detail_liquidation.Financing_Interest%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCurrent_Value
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuCurrent_Value$  in LD_detail_liquidation.Current_Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSecure_Value
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuSecure_Value$  in LD_detail_liquidation.Secure_Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updState
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				isbState$  in LD_detail_liquidation.State%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLiquidation_Id
		(
				inudetail_liquidation_Id   in LD_detail_liquidation.detail_liquidation_Id%type,
				inuLiquidation_Id$  in LD_detail_liquidation.Liquidation_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetDetail_Liquidation_Id
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Detail_Liquidation_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Package_Id%type;

    	FUNCTION fnuGetFinancing_Code_Id
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Financing_Code_Id%type;

    	FUNCTION fnuGetPending_Balance
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Pending_Balance%type;

    	FUNCTION fnuGetConcept_Id
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Concept_Id%type;

    	FUNCTION fnuGetTotal_Value
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Total_Value%type;

    	FUNCTION fnuGetFinancing_Interest
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Financing_Interest%type;

    	FUNCTION fnuGetCurrent_Value
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Current_Value%type;

    	FUNCTION fnuGetSecure_Value
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Secure_Value%type;

    	FUNCTION fsbGetState
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.State%type;

    	FUNCTION fnuGetLiquidation_Id
    	(
    	    inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liquidation.Liquidation_Id%type;


	PROCEDURE LockByPk
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		orcLD_detail_liquidation  out styLD_detail_liquidation
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_detail_liquidation  out styLD_detail_liquidation
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_detail_liquidation;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_detail_liquidation
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO159764';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DETAIL_LIQUIDATION';
	  cnuGeEntityId constant varchar2(30) := 8168; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	IS
		SELECT LD_detail_liquidation.*,LD_detail_liquidation.rowid
		FROM LD_detail_liquidation
		WHERE  detail_liquidation_Id = inudetail_liquidation_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_detail_liquidation.*,LD_detail_liquidation.rowid
		FROM LD_detail_liquidation
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_detail_liquidation is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_detail_liquidation;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_detail_liquidation default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.detail_liquidation_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		orcLD_detail_liquidation  out styLD_detail_liquidation
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		Open cuLockRcByPk
		(
			inudetail_liquidation_Id
		);

		fetch cuLockRcByPk into orcLD_detail_liquidation;
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
		orcLD_detail_liquidation  out styLD_detail_liquidation
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_detail_liquidation;
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
		itbLD_detail_liquidation  in out nocopy tytbLD_detail_liquidation
	)
	IS
	BEGIN
			rcRecOfTab.Detail_Liquidation_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Financing_Code_Id.delete;
			rcRecOfTab.Pending_Balance.delete;
			rcRecOfTab.Concept_Id.delete;
			rcRecOfTab.Total_Value.delete;
			rcRecOfTab.Financing_Interest.delete;
			rcRecOfTab.Current_Value.delete;
			rcRecOfTab.Secure_Value.delete;
			rcRecOfTab.State.delete;
			rcRecOfTab.Liquidation_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_detail_liquidation  in out nocopy tytbLD_detail_liquidation,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_detail_liquidation);
		for n in itbLD_detail_liquidation.first .. itbLD_detail_liquidation.last loop
			rcRecOfTab.Detail_Liquidation_Id(n) := itbLD_detail_liquidation(n).Detail_Liquidation_Id;
			rcRecOfTab.Package_Id(n) := itbLD_detail_liquidation(n).Package_Id;
			rcRecOfTab.Financing_Code_Id(n) := itbLD_detail_liquidation(n).Financing_Code_Id;
			rcRecOfTab.Pending_Balance(n) := itbLD_detail_liquidation(n).Pending_Balance;
			rcRecOfTab.Concept_Id(n) := itbLD_detail_liquidation(n).Concept_Id;
			rcRecOfTab.Total_Value(n) := itbLD_detail_liquidation(n).Total_Value;
			rcRecOfTab.Financing_Interest(n) := itbLD_detail_liquidation(n).Financing_Interest;
			rcRecOfTab.Current_Value(n) := itbLD_detail_liquidation(n).Current_Value;
			rcRecOfTab.Secure_Value(n) := itbLD_detail_liquidation(n).Secure_Value;
			rcRecOfTab.State(n) := itbLD_detail_liquidation(n).State;
			rcRecOfTab.Liquidation_Id(n) := itbLD_detail_liquidation(n).Liquidation_Id;
			rcRecOfTab.row_id(n) := itbLD_detail_liquidation(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inudetail_liquidation_Id
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
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inudetail_liquidation_Id = rcData.detail_liquidation_Id
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
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inudetail_liquidation_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN		rcError.detail_liquidation_Id:=inudetail_liquidation_Id;

		Load
		(
			inudetail_liquidation_Id
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
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	IS
	BEGIN
		Load
		(
			inudetail_liquidation_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		orcRecord out nocopy styLD_detail_liquidation
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN		rcError.detail_liquidation_Id:=inudetail_liquidation_Id;

		Load
		(
			inudetail_liquidation_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN styLD_detail_liquidation
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id:=inudetail_liquidation_Id;

		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type
	)
	RETURN styLD_detail_liquidation
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id:=inudetail_liquidation_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inudetail_liquidation_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_detail_liquidation
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_detail_liquidation
	)
	IS
		rfLD_detail_liquidation tyrfLD_detail_liquidation;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_detail_liquidation.Detail_Liquidation_Id,
		            LD_detail_liquidation.Package_Id,
		            LD_detail_liquidation.Financing_Code_Id,
		            LD_detail_liquidation.Pending_Balance,
		            LD_detail_liquidation.Concept_Id,
		            LD_detail_liquidation.Total_Value,
		            LD_detail_liquidation.Financing_Interest,
		            LD_detail_liquidation.Current_Value,
		            LD_detail_liquidation.Secure_Value,
		            LD_detail_liquidation.State,
		            LD_detail_liquidation.Liquidation_Id,
		            LD_detail_liquidation.rowid
                FROM LD_detail_liquidation';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_detail_liquidation for sbFullQuery;
		fetch rfLD_detail_liquidation bulk collect INTO otbResult;
		close rfLD_detail_liquidation;
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
		            LD_detail_liquidation.Detail_Liquidation_Id,
		            LD_detail_liquidation.Package_Id,
		            LD_detail_liquidation.Financing_Code_Id,
		            LD_detail_liquidation.Pending_Balance,
		            LD_detail_liquidation.Concept_Id,
		            LD_detail_liquidation.Total_Value,
		            LD_detail_liquidation.Financing_Interest,
		            LD_detail_liquidation.Current_Value,
		            LD_detail_liquidation.Secure_Value,
		            LD_detail_liquidation.State,
		            LD_detail_liquidation.Liquidation_Id,
		            LD_detail_liquidation.rowid
                FROM LD_detail_liquidation';
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
		ircLD_detail_liquidation in styLD_detail_liquidation
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_detail_liquidation,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_detail_liquidation in styLD_detail_liquidation,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_detail_liquidation.detail_liquidation_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|detail_liquidation_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_detail_liquidation
		(
			Detail_Liquidation_Id,
			Package_Id,
			Financing_Code_Id,
			Pending_Balance,
			Concept_Id,
			Total_Value,
			Financing_Interest,
			Current_Value,
			Secure_Value,
			State,
			Liquidation_Id
		)
		values
		(
			ircLD_detail_liquidation.Detail_Liquidation_Id,
			ircLD_detail_liquidation.Package_Id,
			ircLD_detail_liquidation.Financing_Code_Id,
			ircLD_detail_liquidation.Pending_Balance,
			ircLD_detail_liquidation.Concept_Id,
			ircLD_detail_liquidation.Total_Value,
			ircLD_detail_liquidation.Financing_Interest,
			ircLD_detail_liquidation.Current_Value,
			ircLD_detail_liquidation.Secure_Value,
			ircLD_detail_liquidation.State,
			ircLD_detail_liquidation.Liquidation_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_detail_liquidation));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_detail_liquidation in out nocopy tytbLD_detail_liquidation
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_detail_liquidation, blUseRowID);
		forall n in iotbLD_detail_liquidation.first..iotbLD_detail_liquidation.last
			insert into LD_detail_liquidation
			(
			Detail_Liquidation_Id,
			Package_Id,
			Financing_Code_Id,
			Pending_Balance,
			Concept_Id,
			Total_Value,
			Financing_Interest,
			Current_Value,
			Secure_Value,
			State,
			Liquidation_Id
		)
		values
		(
			rcRecOfTab.Detail_Liquidation_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Financing_Code_Id(n),
			rcRecOfTab.Pending_Balance(n),
			rcRecOfTab.Concept_Id(n),
			rcRecOfTab.Total_Value(n),
			rcRecOfTab.Financing_Interest(n),
			rcRecOfTab.Current_Value(n),
			rcRecOfTab.Secure_Value(n),
			rcRecOfTab.State(n),
			rcRecOfTab.Liquidation_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id:=inudetail_liquidation_Id;

		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		delete
		from LD_detail_liquidation
		where
       		detail_liquidation_Id=inudetail_liquidation_Id;
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
		rcError  styLD_detail_liquidation;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_detail_liquidation
		where
			rowid = iriRowID
		returning
   detail_liquidation_Id
		into
			rcError.detail_liquidation_Id;

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
		iotbLD_detail_liquidation in out nocopy tytbLD_detail_liquidation,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_detail_liquidation;
	BEGIN
		FillRecordOfTables(iotbLD_detail_liquidation, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last
				delete
				from LD_detail_liquidation
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last loop
					LockByPk
					(
							rcRecOfTab.detail_liquidation_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last
				delete
				from LD_detail_liquidation
				where
		         	detail_liquidation_Id = rcRecOfTab.detail_liquidation_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_detail_liquidation in styLD_detail_liquidation,
		inuLock	  in number default 0
	)
	IS
		nudetail_liquidation_Id LD_detail_liquidation.detail_liquidation_Id%type;

	BEGIN
		if ircLD_detail_liquidation.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_detail_liquidation.rowid,rcData);
			end if;
			update LD_detail_liquidation
			set

        Package_Id = ircLD_detail_liquidation.Package_Id,
        Financing_Code_Id = ircLD_detail_liquidation.Financing_Code_Id,
        Pending_Balance = ircLD_detail_liquidation.Pending_Balance,
        Concept_Id = ircLD_detail_liquidation.Concept_Id,
        Total_Value = ircLD_detail_liquidation.Total_Value,
        Financing_Interest = ircLD_detail_liquidation.Financing_Interest,
        Current_Value = ircLD_detail_liquidation.Current_Value,
        Secure_Value = ircLD_detail_liquidation.Secure_Value,
        State = ircLD_detail_liquidation.State,
        Liquidation_Id = ircLD_detail_liquidation.Liquidation_Id
			where
				rowid = ircLD_detail_liquidation.rowid
			returning
    detail_liquidation_Id
			into
				nudetail_liquidation_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_detail_liquidation.detail_liquidation_Id,
					rcData
				);
			end if;

			update LD_detail_liquidation
			set
        Package_Id = ircLD_detail_liquidation.Package_Id,
        Financing_Code_Id = ircLD_detail_liquidation.Financing_Code_Id,
        Pending_Balance = ircLD_detail_liquidation.Pending_Balance,
        Concept_Id = ircLD_detail_liquidation.Concept_Id,
        Total_Value = ircLD_detail_liquidation.Total_Value,
        Financing_Interest = ircLD_detail_liquidation.Financing_Interest,
        Current_Value = ircLD_detail_liquidation.Current_Value,
        Secure_Value = ircLD_detail_liquidation.Secure_Value,
        State = ircLD_detail_liquidation.State,
        Liquidation_Id = ircLD_detail_liquidation.Liquidation_Id
			where
	         	detail_liquidation_Id = ircLD_detail_liquidation.detail_liquidation_Id
			returning
    detail_liquidation_Id
			into
				nudetail_liquidation_Id;
		end if;

		if
			nudetail_liquidation_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_detail_liquidation));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_detail_liquidation in out nocopy tytbLD_detail_liquidation,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_detail_liquidation;
  BEGIN
    FillRecordOfTables(iotbLD_detail_liquidation,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last
        update LD_detail_liquidation
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Financing_Code_Id = rcRecOfTab.Financing_Code_Id(n),
            Pending_Balance = rcRecOfTab.Pending_Balance(n),
            Concept_Id = rcRecOfTab.Concept_Id(n),
            Total_Value = rcRecOfTab.Total_Value(n),
            Financing_Interest = rcRecOfTab.Financing_Interest(n),
            Current_Value = rcRecOfTab.Current_Value(n),
            Secure_Value = rcRecOfTab.Secure_Value(n),
            State = rcRecOfTab.State(n),
            Liquidation_Id = rcRecOfTab.Liquidation_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last loop
          LockByPk
          (
              rcRecOfTab.detail_liquidation_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_detail_liquidation.first .. iotbLD_detail_liquidation.last
        update LD_detail_liquidation
        set
					Package_Id = rcRecOfTab.Package_Id(n),
					Financing_Code_Id = rcRecOfTab.Financing_Code_Id(n),
					Pending_Balance = rcRecOfTab.Pending_Balance(n),
					Concept_Id = rcRecOfTab.Concept_Id(n),
					Total_Value = rcRecOfTab.Total_Value(n),
					Financing_Interest = rcRecOfTab.Financing_Interest(n),
					Current_Value = rcRecOfTab.Current_Value(n),
					Secure_Value = rcRecOfTab.Secure_Value(n),
					State = rcRecOfTab.State(n),
					Liquidation_Id = rcRecOfTab.Liquidation_Id(n)
          where
          detail_liquidation_Id = rcRecOfTab.detail_liquidation_Id(n)
;
    end if;
  END;

	PROCEDURE updPackage_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuPackage_Id$ in LD_detail_liquidation.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Package_Id = inuPackage_Id$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFinancing_Code_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuFinancing_Code_Id$ in LD_detail_liquidation.Financing_Code_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Financing_Code_Id = inuFinancing_Code_Id$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Financing_Code_Id:= inuFinancing_Code_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPending_Balance
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuPending_Balance$ in LD_detail_liquidation.Pending_Balance%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Pending_Balance = inuPending_Balance$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Pending_Balance:= inuPending_Balance$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updConcept_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuConcept_Id$ in LD_detail_liquidation.Concept_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Concept_Id = inuConcept_Id$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Concept_Id:= inuConcept_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTotal_Value
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuTotal_Value$ in LD_detail_liquidation.Total_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Total_Value = inuTotal_Value$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Total_Value:= inuTotal_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFinancing_Interest
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuFinancing_Interest$ in LD_detail_liquidation.Financing_Interest%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Financing_Interest = inuFinancing_Interest$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Financing_Interest:= inuFinancing_Interest$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCurrent_Value
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuCurrent_Value$ in LD_detail_liquidation.Current_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Current_Value = inuCurrent_Value$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Current_Value:= inuCurrent_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSecure_Value
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuSecure_Value$ in LD_detail_liquidation.Secure_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Secure_Value = inuSecure_Value$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Secure_Value:= inuSecure_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updState
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		isbState$ in LD_detail_liquidation.State%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			State = isbState$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.State:= isbState$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLiquidation_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuLiquidation_Id$ in LD_detail_liquidation.Liquidation_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liquidation;
	BEGIN
		rcError.detail_liquidation_Id := inudetail_liquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inudetail_liquidation_Id,
				rcData
			);
		end if;

		update LD_detail_liquidation
		set
			Liquidation_Id = inuLiquidation_Id$
		where
			detail_liquidation_Id = inudetail_liquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Liquidation_Id:= inuLiquidation_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetDetail_Liquidation_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Detail_Liquidation_Id%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Detail_Liquidation_Id);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Detail_Liquidation_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPackage_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Package_Id%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Package_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFinancing_Code_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Financing_Code_Id%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Financing_Code_Id);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Financing_Code_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPending_Balance
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Pending_Balance%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Pending_Balance);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Pending_Balance);
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
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Concept_Id%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Concept_Id);
		end if;
		Load
		(
			inudetail_liquidation_Id
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

	FUNCTION fnuGetTotal_Value
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Total_Value%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Total_Value);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Total_Value);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFinancing_Interest
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Financing_Interest%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Financing_Interest);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Financing_Interest);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCurrent_Value
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Current_Value%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Current_Value);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Current_Value);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSecure_Value
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Secure_Value%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Secure_Value);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Secure_Value);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetState
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.State%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id:=inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.State);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.State);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLiquidation_Id
	(
		inudetail_liquidation_Id in LD_detail_liquidation.detail_liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liquidation.Liquidation_Id%type
	IS
		rcError styLD_detail_liquidation;
	BEGIN

		rcError.detail_liquidation_Id := inudetail_liquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inudetail_liquidation_Id
			 )
		then
			 return(rcData.Liquidation_Id);
		end if;
		Load
		(
			inudetail_liquidation_Id
		);
		return(rcData.Liquidation_Id);
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
end DALD_detail_liquidation;
/
PROMPT Otorgando permisos de ejecucion a DALD_DETAIL_LIQUIDATION
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_DETAIL_LIQUIDATION', 'ADM_PERSON');
END;
/