CREATE OR REPLACE PACKAGE adm_person.dald_liquidation_seller IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type) IS
		SELECT LD_liquidation_seller.*,LD_liquidation_seller.rowid
		FROM LD_liquidation_seller
		WHERE
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId(
		irirowid in varchar2) IS
		SELECT LD_liquidation_seller.*,LD_liquidation_seller.rowid
		FROM LD_liquidation_seller
		WHERE rowId = irirowid;


	/* Subtipos */
	subtype styLD_liquidation_seller  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_liquidation_seller is table of styLD_liquidation_seller index by binary_integer;
	type tyrfRecords is ref cursor return styLD_liquidation_seller;

	/* Tipos referenciando al registro */
	type tytbLiquidation_Seller_Id is table of LD_liquidation_seller.Liquidation_Seller_Id%type index by binary_integer;
	type tytbDate_Liquidation is table of LD_liquidation_seller.Date_Liquidation%type index by binary_integer;
	type tytbStatus is table of LD_liquidation_seller.Status%type index by binary_integer;
	type tytbDate_Suspension is table of LD_liquidation_seller.Date_Suspension%type index by binary_integer;
	type tytbFunder_Id is table of LD_liquidation_seller.Funder_Id%type index by binary_integer;
	type tytbLiquidated_Order_Id is table of LD_liquidation_seller.Liquidated_Order_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_liquidation_seller.Package_Id%type index by binary_integer;
	type tytbId_Contratista is table of LD_liquidation_seller.Id_Contratista%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_liquidation_seller is record(

		Liquidation_Seller_Id   tytbLiquidation_Seller_Id,
		Date_Liquidation   tytbDate_Liquidation,
		Status   tytbStatus,
		Date_Suspension   tytbDate_Suspension,
		Funder_Id   tytbFunder_Id,
		Liquidated_Order_Id   tytbLiquidated_Order_Id,
		Package_Id   tytbPackage_Id,
		Id_Contratista   tytbId_Contratista,
		row_id tytbrowid);


	 /***** Metodos Publicos ****/
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

	FUNCTION fsbGetMessageDescription return varchar2;

	PROCEDURE ClearMemory;

   FUNCTION fblExist(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type) RETURN boolean;

	 PROCEDURE AccKey(
		 inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type);

	PROCEDURE AccKeyByRowId(
		iriRowID    in rowid);

	PROCEDURE ValDuplicate(
		 inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type);

	PROCEDURE getRecord(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		orcRecord out nocopy styLD_liquidation_seller
	);

	FUNCTION frcGetRcData(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type)
	RETURN styLD_liquidation_seller;

	FUNCTION frcGetRcData
	RETURN styLD_liquidation_seller;

	FUNCTION frcGetRecord(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type)
	RETURN styLD_liquidation_seller;

	PROCEDURE getRecords(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_liquidation_seller
	);

	FUNCTION frfGetRecords(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false)
	RETURN tyRefCursor;

	PROCEDURE insRecord(
		ircLD_liquidation_seller in styLD_liquidation_seller
	);

 	  PROCEDURE insRecord(
		ircLD_liquidation_seller in styLD_liquidation_seller,
		orirowid   out varchar2);

	PROCEDURE insRecords(
		iotbLD_liquidation_seller in out nocopy tytbLD_liquidation_seller
	);

	PROCEDURE delRecord(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type, inuLock in number default 1);

	PROCEDURE delByRowID(
		iriRowID    in rowid,
		inuLock in number default 1);

	PROCEDURE delRecords
	(
		iotbLD_liquidation_seller in out nocopy tytbLD_liquidation_seller,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_liquidation_seller in styLD_liquidation_seller,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_liquidation_seller in out nocopy tytbLD_liquidation_seller,
		inuLock in number default 1
	);

		PROCEDURE updDate_Liquidation
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				idtDate_Liquidation$  in LD_liquidation_seller.Date_Liquidation%type,
				inuLock	  in number default 0);

		PROCEDURE updStatus
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				isbStatus$  in LD_liquidation_seller.Status%type,
				inuLock	  in number default 0);

		PROCEDURE updDate_Suspension
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				idtDate_Suspension$  in LD_liquidation_seller.Date_Suspension%type,
				inuLock	  in number default 0);

		PROCEDURE updFunder_Id
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				inuFunder_Id$  in LD_liquidation_seller.Funder_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updLiquidated_Order_Id
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				inuLiquidated_Order_Id$  in LD_liquidation_seller.Liquidated_Order_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updPackage_Id
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				inuPackage_Id$  in LD_liquidation_seller.Package_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updId_Contratista
		(
				inuLIQUIDATION_SELLER_Id   in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
				inuId_Contratista$  in LD_liquidation_seller.Id_Contratista%type,
				inuLock	  in number default 0);

    	FUNCTION fnuGetLiquidation_Seller_Id
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Liquidation_Seller_Id%type;

    	FUNCTION fdtGetDate_Liquidation
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Date_Liquidation%type;

    	FUNCTION fsbGetStatus
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Status%type;

    	FUNCTION fdtGetDate_Suspension
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Date_Suspension%type;

    	FUNCTION fnuGetFunder_Id
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Funder_Id%type;

    	FUNCTION fnuGetLiquidated_Order_Id
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Liquidated_Order_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Package_Id%type;

    	FUNCTION fnuGetId_Contratista
    	(
    	    inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation_seller.Id_Contratista%type;


	PROCEDURE LockByPk
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		orcLD_liquidation_seller  out styLD_liquidation_seller
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_liquidation_seller  out styLD_liquidation_seller
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_liquidation_seller;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_liquidation_seller
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_LIQUIDATION_SELLER';
	  cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_LIQUIDATION_SELLER'); -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	IS
		SELECT LD_liquidation_seller.*,LD_liquidation_seller.rowid
		FROM LD_liquidation_seller
		WHERE  LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_liquidation_seller.*,LD_liquidation_seller.rowid
		FROM LD_liquidation_seller
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_liquidation_seller is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_liquidation_seller;

	rcData cuRecord%rowtype;

   blDAO_USE_CACHE    boolean := null;

	/* Metodos privados */
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE IS
	   nuEntityId ge_entity.entity_id%TYPE;
	   BEGIN
	   SELECT ge_entity.entity_id
	   INTO   nuEntityId
	   FROM   ge_entity
	   WHERE  ge_entity.name_ = isbTName;
	   RETURN nuEntityId;
  EXCEPTION
	   WHEN ex.CONTROLLED_ERROR THEN
	        RAISE ex.CONTROLLED_ERROR;
	   WHEN OTHERS THEN
	        Errors.setError;
	        RAISE ex.CONTROLLED_ERROR;
	END;
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

	FUNCTION fsbPrimaryKey( rcI in styLD_liquidation_seller default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LIQUIDATION_SELLER_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		orcLD_liquidation_seller  out styLD_liquidation_seller
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;

		Open cuLockRcByPk
		(
			inuLIQUIDATION_SELLER_Id
		);

		fetch cuLockRcByPk into orcLD_liquidation_seller;
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
		orcLD_liquidation_seller  out styLD_liquidation_seller
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_liquidation_seller;
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
		itbLD_liquidation_seller  in out nocopy tytbLD_liquidation_seller
	)
	IS
	BEGIN
			rcRecOfTab.Liquidation_Seller_Id.delete;
			rcRecOfTab.Date_Liquidation.delete;
			rcRecOfTab.Status.delete;
			rcRecOfTab.Date_Suspension.delete;
			rcRecOfTab.Funder_Id.delete;
			rcRecOfTab.Liquidated_Order_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Id_Contratista.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_liquidation_seller  in out nocopy tytbLD_liquidation_seller,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_liquidation_seller);
		for n in itbLD_liquidation_seller.first .. itbLD_liquidation_seller.last loop
			rcRecOfTab.Liquidation_Seller_Id(n) := itbLD_liquidation_seller(n).Liquidation_Seller_Id;
			rcRecOfTab.Date_Liquidation(n) := itbLD_liquidation_seller(n).Date_Liquidation;
			rcRecOfTab.Status(n) := itbLD_liquidation_seller(n).Status;
			rcRecOfTab.Date_Suspension(n) := itbLD_liquidation_seller(n).Date_Suspension;
			rcRecOfTab.Funder_Id(n) := itbLD_liquidation_seller(n).Funder_Id;
			rcRecOfTab.Liquidated_Order_Id(n) := itbLD_liquidation_seller(n).Liquidated_Order_Id;
			rcRecOfTab.Package_Id(n) := itbLD_liquidation_seller(n).Package_Id;
			rcRecOfTab.Id_Contratista(n) := itbLD_liquidation_seller(n).Id_Contratista;
			rcRecOfTab.row_id(n) := itbLD_liquidation_seller(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLIQUIDATION_SELLER_Id
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
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLIQUIDATION_SELLER_Id = rcData.LIQUIDATION_SELLER_Id
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
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		Load
		(
			inuLIQUIDATION_SELLER_Id
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
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		orcRecord out nocopy styLD_liquidation_seller
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	RETURN styLD_liquidation_seller
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type
	)
	RETURN styLD_liquidation_seller
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_liquidation_seller
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_liquidation_seller
	)
	IS
		rfLD_liquidation_seller tyrfLD_liquidation_seller;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_liquidation_seller.*,
		            LD_liquidation_seller.rowid
                FROM LD_liquidation_seller';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_liquidation_seller for sbFullQuery;
		fetch rfLD_liquidation_seller bulk collect INTO otbResult;
		close rfLD_liquidation_seller;
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
		sbSQL  VARCHAR2 (32000) := 'select LD_liquidation_seller.*,
		            LD_liquidation_seller.rowid
                FROM LD_liquidation_seller';
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
		ircLD_liquidation_seller in styLD_liquidation_seller
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_liquidation_seller,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_liquidation_seller in styLD_liquidation_seller,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_liquidation_seller.LIQUIDATION_SELLER_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LIQUIDATION_SELLER_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_liquidation_seller
		(
			Liquidation_Seller_Id,
			Date_Liquidation,
			Status,
			Date_Suspension,
			Funder_Id,
			Liquidated_Order_Id,
			Package_Id,
			Id_Contratista
		)
		values
		(
			ircLD_liquidation_seller.Liquidation_Seller_Id,
			ircLD_liquidation_seller.Date_Liquidation,
			ircLD_liquidation_seller.Status,
			ircLD_liquidation_seller.Date_Suspension,
			ircLD_liquidation_seller.Funder_Id,
			ircLD_liquidation_seller.Liquidated_Order_Id,
			ircLD_liquidation_seller.Package_Id,
			ircLD_liquidation_seller.Id_Contratista
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_liquidation_seller));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_liquidation_seller in out nocopy tytbLD_liquidation_seller
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_liquidation_seller, blUseRowID);
		forall n in iotbLD_liquidation_seller.first..iotbLD_liquidation_seller.last
			insert into LD_liquidation_seller
			(
			Liquidation_Seller_Id,
			Date_Liquidation,
			Status,
			Date_Suspension,
			Funder_Id,
			Liquidated_Order_Id,
			Package_Id,
			Id_Contratista
		)
		values
		(
			rcRecOfTab.Liquidation_Seller_Id(n),
			rcRecOfTab.Date_Liquidation(n),
			rcRecOfTab.Status(n),
			rcRecOfTab.Date_Suspension(n),
			rcRecOfTab.Funder_Id(n),
			rcRecOfTab.Liquidated_Order_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Id_Contratista(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		delete
		from LD_liquidation_seller
		where
       		LIQUIDATION_SELLER_Id=inuLIQUIDATION_SELLER_Id;
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
		rcError  styLD_liquidation_seller;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_liquidation_seller
		where
			rowid = iriRowID
		returning
   LIQUIDATION_SELLER_Id
		into
			rcError.LIQUIDATION_SELLER_Id;

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
		iotbLD_liquidation_seller in out nocopy tytbLD_liquidation_seller,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_liquidation_seller;
	BEGIN
		FillRecordOfTables(iotbLD_liquidation_seller, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last
				delete
				from LD_liquidation_seller
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last loop
					LockByPk
					(
							rcRecOfTab.LIQUIDATION_SELLER_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last
				delete
				from LD_liquidation_seller
				where
		         	LIQUIDATION_SELLER_Id = rcRecOfTab.LIQUIDATION_SELLER_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_liquidation_seller in styLD_liquidation_seller,
		inuLock	  in number default 0
	)
	IS
		nuLIQUIDATION_SELLER_Id LD_liquidation_seller.LIQUIDATION_SELLER_Id%type;

	BEGIN
		if ircLD_liquidation_seller.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_liquidation_seller.rowid,rcData);
			end if;
			update LD_liquidation_seller
			set

        Date_Liquidation = ircLD_liquidation_seller.Date_Liquidation,
        Status = ircLD_liquidation_seller.Status,
        Date_Suspension = ircLD_liquidation_seller.Date_Suspension,
        Funder_Id = ircLD_liquidation_seller.Funder_Id,
        Liquidated_Order_Id = ircLD_liquidation_seller.Liquidated_Order_Id,
        Package_Id = ircLD_liquidation_seller.Package_Id,
        Id_Contratista = ircLD_liquidation_seller.Id_Contratista
			where
				rowid = ircLD_liquidation_seller.rowid
			returning
    LIQUIDATION_SELLER_Id
			into
				nuLIQUIDATION_SELLER_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_liquidation_seller.LIQUIDATION_SELLER_Id,
					rcData
				);
			end if;

			update LD_liquidation_seller
			set
        Date_Liquidation = ircLD_liquidation_seller.Date_Liquidation,
        Status = ircLD_liquidation_seller.Status,
        Date_Suspension = ircLD_liquidation_seller.Date_Suspension,
        Funder_Id = ircLD_liquidation_seller.Funder_Id,
        Liquidated_Order_Id = ircLD_liquidation_seller.Liquidated_Order_Id,
        Package_Id = ircLD_liquidation_seller.Package_Id,
        Id_Contratista = ircLD_liquidation_seller.Id_Contratista
			where
	         	LIQUIDATION_SELLER_Id = ircLD_liquidation_seller.LIQUIDATION_SELLER_Id
			returning
    LIQUIDATION_SELLER_Id
			into
				nuLIQUIDATION_SELLER_Id;
		end if;

		if
			nuLIQUIDATION_SELLER_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_liquidation_seller));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_liquidation_seller in out nocopy tytbLD_liquidation_seller,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_liquidation_seller;
  BEGIN
    FillRecordOfTables(iotbLD_liquidation_seller,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last
        update LD_liquidation_seller
        set

            Date_Liquidation = rcRecOfTab.Date_Liquidation(n),
            Status = rcRecOfTab.Status(n),
            Date_Suspension = rcRecOfTab.Date_Suspension(n),
            Funder_Id = rcRecOfTab.Funder_Id(n),
            Liquidated_Order_Id = rcRecOfTab.Liquidated_Order_Id(n),
            Package_Id = rcRecOfTab.Package_Id(n),
            Id_Contratista = rcRecOfTab.Id_Contratista(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last loop
          LockByPk
          (
              rcRecOfTab.LIQUIDATION_SELLER_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_liquidation_seller.first .. iotbLD_liquidation_seller.last
        update LD_liquidation_seller
        set
					Date_Liquidation = rcRecOfTab.Date_Liquidation(n),
					Status = rcRecOfTab.Status(n),
					Date_Suspension = rcRecOfTab.Date_Suspension(n),
					Funder_Id = rcRecOfTab.Funder_Id(n),
					Liquidated_Order_Id = rcRecOfTab.Liquidated_Order_Id(n),
					Package_Id = rcRecOfTab.Package_Id(n),
					Id_Contratista = rcRecOfTab.Id_Contratista(n)
          where
          LIQUIDATION_SELLER_Id = rcRecOfTab.LIQUIDATION_SELLER_Id(n)
;
    end if;
  END;

	PROCEDURE updDate_Liquidation
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		idtDate_Liquidation$ in LD_liquidation_seller.Date_Liquidation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Date_Liquidation = idtDate_Liquidation$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Date_Liquidation:= idtDate_Liquidation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updStatus
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		isbStatus$ in LD_liquidation_seller.Status%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Status = isbStatus$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Status:= isbStatus$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDate_Suspension
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		idtDate_Suspension$ in LD_liquidation_seller.Date_Suspension%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Date_Suspension = idtDate_Suspension$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Date_Suspension:= idtDate_Suspension$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFunder_Id
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuFunder_Id$ in LD_liquidation_seller.Funder_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Funder_Id = inuFunder_Id$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Funder_Id:= inuFunder_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLiquidated_Order_Id
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuLiquidated_Order_Id$ in LD_liquidation_seller.Liquidated_Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Liquidated_Order_Id = inuLiquidated_Order_Id$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Liquidated_Order_Id:= inuLiquidated_Order_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPackage_Id
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuPackage_Id$ in LD_liquidation_seller.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Package_Id = inuPackage_Id$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updId_Contratista
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuId_Contratista$ in LD_liquidation_seller.Id_Contratista%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation_seller;
	BEGIN
		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuLIQUIDATION_SELLER_Id,
				rcData
			);
		end if;

		update LD_liquidation_seller
		set
			Id_Contratista = inuId_Contratista$
		where
			LIQUIDATION_SELLER_Id = inuLIQUIDATION_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Id_Contratista:= inuId_Contratista$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetLiquidation_Seller_Id
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Liquidation_Seller_Id%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Liquidation_Seller_Id);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Liquidation_Seller_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetDate_Liquidation
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Date_Liquidation%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Date_Liquidation);
		end if;
		Load
		(
		 		inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Date_Liquidation);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetStatus
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Status%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Status);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Status);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetDate_Suspension
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Date_Suspension%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id:=inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Date_Suspension);
		end if;
		Load
		(
		 		inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Date_Suspension);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFunder_Id
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Funder_Id%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Funder_Id);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Funder_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLiquidated_Order_Id
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Liquidated_Order_Id%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Liquidated_Order_Id);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Liquidated_Order_Id);
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
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Package_Id%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
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

	FUNCTION fnuGetId_Contratista
	(
		inuLIQUIDATION_SELLER_Id in LD_liquidation_seller.LIQUIDATION_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation_seller.Id_Contratista%type
	IS
		rcError styLD_liquidation_seller;
	BEGIN

		rcError.LIQUIDATION_SELLER_Id := inuLIQUIDATION_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuLIQUIDATION_SELLER_Id
			 )
		then
			 return(rcData.Id_Contratista);
		end if;
		Load
		(
			inuLIQUIDATION_SELLER_Id
		);
		return(rcData.Id_Contratista);
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
end DALD_liquidation_seller;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_LIQUIDATION_SELLER
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_LIQUIDATION_SELLER', 'ADM_PERSON'); 
END;
/  
