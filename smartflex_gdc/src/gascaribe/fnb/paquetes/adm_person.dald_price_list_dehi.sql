CREATE OR REPLACE PACKAGE adm_person.DALD_price_list_dehi
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_price_list_dehi
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/       
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
  )
  IS
		SELECT LD_price_list_dehi.*,LD_price_list_dehi.rowid
		FROM LD_price_list_dehi
		WHERE
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_price_list_dehi.*,LD_price_list_dehi.rowid
		FROM LD_price_list_dehi
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_price_list_dehi  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_price_list_dehi is table of styLD_price_list_dehi index by binary_integer;
	type tyrfRecords is ref cursor return styLD_price_list_dehi;

	/* Tipos referenciando al registro */
	type tytbPrice_List_Dehi_Id is table of LD_price_list_dehi.Price_List_Dehi_Id%type index by binary_integer;
	type tytbPrice_List_Id is table of LD_price_list_dehi.Price_List_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_price_list_dehi.Article_Id%type index by binary_integer;
	type tytbPrice is table of LD_price_list_dehi.Price%type index by binary_integer;
	type tytbPrice_Aproved is table of LD_price_list_dehi.Price_Aproved%type index by binary_integer;
	type tytbSale_Chanel_Id is table of LD_price_list_dehi.Sale_Chanel_Id%type index by binary_integer;
	type tytbGeograp_Location_Id is table of LD_price_list_dehi.Geograp_Location_Id%type index by binary_integer;
	type tytbVersion is table of LD_price_list_dehi.Version%type index by binary_integer;
	type tytbRegister_Date is table of LD_price_list_dehi.Register_Date%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_price_list_dehi is record
	(

		Price_List_Dehi_Id   tytbPrice_List_Dehi_Id,
		Price_List_Id   tytbPrice_List_Id,
		Article_Id   tytbArticle_Id,
		Price   tytbPrice,
		Price_Aproved   tytbPrice_Aproved,
		Sale_Chanel_Id   tytbSale_Chanel_Id,
		Geograp_Location_Id   tytbGeograp_Location_Id,
		Version   tytbVersion,
		Register_Date   tytbRegister_Date,
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
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	);

	PROCEDURE getRecord
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		orcRecord out nocopy styLD_price_list_dehi
	);

	FUNCTION frcGetRcData
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN styLD_price_list_dehi;

	FUNCTION frcGetRcData
	RETURN styLD_price_list_dehi;

	FUNCTION frcGetRecord
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN styLD_price_list_dehi;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_price_list_dehi
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_price_list_dehi in styLD_price_list_dehi
	);

 	  PROCEDURE insRecord
	(
		ircLD_price_list_dehi in styLD_price_list_dehi,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_price_list_dehi in out nocopy tytbLD_price_list_dehi
	);

	PROCEDURE delRecord
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_price_list_dehi in out nocopy tytbLD_price_list_dehi,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_price_list_dehi in styLD_price_list_dehi,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_price_list_dehi in out nocopy tytbLD_price_list_dehi,
		inuLock in number default 1
	);

		PROCEDURE updPrice_List_Id
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuPrice_List_Id$  in LD_price_list_dehi.Price_List_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updArticle_Id
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuArticle_Id$  in LD_price_list_dehi.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrice
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuPrice$  in LD_price_list_dehi.Price%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrice_Aproved
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuPrice_Aproved$  in LD_price_list_dehi.Price_Aproved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSale_Chanel_Id
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuSale_Chanel_Id$  in LD_price_list_dehi.Sale_Chanel_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGeograp_Location_Id
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuGeograp_Location_Id$  in LD_price_list_dehi.Geograp_Location_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updVersion
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				inuVersion$  in LD_price_list_dehi.Version%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRegister_Date
		(
				inuPRICE_LIST_DEHI_Id   in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
				idtRegister_Date$  in LD_price_list_dehi.Register_Date%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPrice_List_Dehi_Id
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Price_List_Dehi_Id%type;

    	FUNCTION fnuGetPrice_List_Id
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Price_List_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Article_Id%type;

    	FUNCTION fnuGetPrice
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Price%type;

    	FUNCTION fnuGetPrice_Aproved
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Price_Aproved%type;

    	FUNCTION fnuGetSale_Chanel_Id
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Sale_Chanel_Id%type;

    	FUNCTION fnuGetGeograp_Location_Id
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Geograp_Location_Id%type;

    	FUNCTION fnuGetVersion
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Version%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_price_list_dehi.Register_Date%type;


	PROCEDURE LockByPk
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		orcLD_price_list_dehi  out styLD_price_list_dehi
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_price_list_dehi  out styLD_price_list_dehi
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_price_list_dehi;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_price_list_dehi
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PRICE_LIST_DEHI';
	  cnuGeEntityId constant varchar2(30) := 7681; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	IS
		SELECT LD_price_list_dehi.*,LD_price_list_dehi.rowid
		FROM LD_price_list_dehi
		WHERE  PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_price_list_dehi.*,LD_price_list_dehi.rowid
		FROM LD_price_list_dehi
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_price_list_dehi is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_price_list_dehi;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_price_list_dehi default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PRICE_LIST_DEHI_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		orcLD_price_list_dehi  out styLD_price_list_dehi
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		Open cuLockRcByPk
		(
			inuPRICE_LIST_DEHI_Id
		);

		fetch cuLockRcByPk into orcLD_price_list_dehi;
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
		orcLD_price_list_dehi  out styLD_price_list_dehi
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_price_list_dehi;
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
		itbLD_price_list_dehi  in out nocopy tytbLD_price_list_dehi
	)
	IS
	BEGIN
			rcRecOfTab.Price_List_Dehi_Id.delete;
			rcRecOfTab.Price_List_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Price.delete;
			rcRecOfTab.Price_Aproved.delete;
			rcRecOfTab.Sale_Chanel_Id.delete;
			rcRecOfTab.Geograp_Location_Id.delete;
			rcRecOfTab.Version.delete;
			rcRecOfTab.Register_Date.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_price_list_dehi  in out nocopy tytbLD_price_list_dehi,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_price_list_dehi);
		for n in itbLD_price_list_dehi.first .. itbLD_price_list_dehi.last loop
			rcRecOfTab.Price_List_Dehi_Id(n) := itbLD_price_list_dehi(n).Price_List_Dehi_Id;
			rcRecOfTab.Price_List_Id(n) := itbLD_price_list_dehi(n).Price_List_Id;
			rcRecOfTab.Article_Id(n) := itbLD_price_list_dehi(n).Article_Id;
			rcRecOfTab.Price(n) := itbLD_price_list_dehi(n).Price;
			rcRecOfTab.Price_Aproved(n) := itbLD_price_list_dehi(n).Price_Aproved;
			rcRecOfTab.Sale_Chanel_Id(n) := itbLD_price_list_dehi(n).Sale_Chanel_Id;
			rcRecOfTab.Geograp_Location_Id(n) := itbLD_price_list_dehi(n).Geograp_Location_Id;
			rcRecOfTab.Version(n) := itbLD_price_list_dehi(n).Version;
			rcRecOfTab.Register_Date(n) := itbLD_price_list_dehi(n).Register_Date;
			rcRecOfTab.row_id(n) := itbLD_price_list_dehi(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPRICE_LIST_DEHI_Id
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
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPRICE_LIST_DEHI_Id = rcData.PRICE_LIST_DEHI_Id
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
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN		rcError.PRICE_LIST_DEHI_Id:=inuPRICE_LIST_DEHI_Id;

		Load
		(
			inuPRICE_LIST_DEHI_Id
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
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		orcRecord out nocopy styLD_price_list_dehi
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN		rcError.PRICE_LIST_DEHI_Id:=inuPRICE_LIST_DEHI_Id;

		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN styLD_price_list_dehi
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id:=inuPRICE_LIST_DEHI_Id;

		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type
	)
	RETURN styLD_price_list_dehi
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id:=inuPRICE_LIST_DEHI_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_price_list_dehi
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_price_list_dehi
	)
	IS
		rfLD_price_list_dehi tyrfLD_price_list_dehi;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_price_list_dehi.Price_List_Dehi_Id,
		            LD_price_list_dehi.Price_List_Id,
		            LD_price_list_dehi.Article_Id,
		            LD_price_list_dehi.Price,
		            LD_price_list_dehi.Price_Aproved,
		            LD_price_list_dehi.Sale_Chanel_Id,
		            LD_price_list_dehi.Geograp_Location_Id,
		            LD_price_list_dehi.Version,
		            LD_price_list_dehi.Register_Date,
		            LD_price_list_dehi.rowid
                FROM LD_price_list_dehi';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_price_list_dehi for sbFullQuery;
		fetch rfLD_price_list_dehi bulk collect INTO otbResult;
		close rfLD_price_list_dehi;

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
		            LD_price_list_dehi.Price_List_Dehi_Id,
		            LD_price_list_dehi.Price_List_Id,
		            LD_price_list_dehi.Article_Id,
		            LD_price_list_dehi.Price,
		            LD_price_list_dehi.Price_Aproved,
		            LD_price_list_dehi.Sale_Chanel_Id,
		            LD_price_list_dehi.Geograp_Location_Id,
		            LD_price_list_dehi.Version,
		            LD_price_list_dehi.Register_Date,
		            LD_price_list_dehi.rowid
                FROM LD_price_list_dehi';
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
		ircLD_price_list_dehi in styLD_price_list_dehi
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_price_list_dehi,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_price_list_dehi in styLD_price_list_dehi,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_price_list_dehi.PRICE_LIST_DEHI_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PRICE_LIST_DEHI_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_price_list_dehi
		(
			Price_List_Dehi_Id,
			Price_List_Id,
			Article_Id,
			Price,
			Price_Aproved,
			Sale_Chanel_Id,
			Geograp_Location_Id,
			Version,
			Register_Date
		)
		values
		(
			ircLD_price_list_dehi.Price_List_Dehi_Id,
			ircLD_price_list_dehi.Price_List_Id,
			ircLD_price_list_dehi.Article_Id,
			ircLD_price_list_dehi.Price,
			ircLD_price_list_dehi.Price_Aproved,
			ircLD_price_list_dehi.Sale_Chanel_Id,
			ircLD_price_list_dehi.Geograp_Location_Id,
			ircLD_price_list_dehi.Version,
			ircLD_price_list_dehi.Register_Date
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_price_list_dehi));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_price_list_dehi in out nocopy tytbLD_price_list_dehi
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_price_list_dehi, blUseRowID);
		forall n in iotbLD_price_list_dehi.first..iotbLD_price_list_dehi.last
			insert into LD_price_list_dehi
			(
			Price_List_Dehi_Id,
			Price_List_Id,
			Article_Id,
			Price,
			Price_Aproved,
			Sale_Chanel_Id,
			Geograp_Location_Id,
			Version,
			Register_Date
		)
		values
		(
			rcRecOfTab.Price_List_Dehi_Id(n),
			rcRecOfTab.Price_List_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Price(n),
			rcRecOfTab.Price_Aproved(n),
			rcRecOfTab.Sale_Chanel_Id(n),
			rcRecOfTab.Geograp_Location_Id(n),
			rcRecOfTab.Version(n),
			rcRecOfTab.Register_Date(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id:=inuPRICE_LIST_DEHI_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		delete
		from LD_price_list_dehi
		where
       		PRICE_LIST_DEHI_Id=inuPRICE_LIST_DEHI_Id;
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
		rcError  styLD_price_list_dehi;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_price_list_dehi
		where
			rowid = iriRowID
		returning
   PRICE_LIST_DEHI_Id
		into
			rcError.PRICE_LIST_DEHI_Id;

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
		iotbLD_price_list_dehi in out nocopy tytbLD_price_list_dehi,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_price_list_dehi;
	BEGIN
		FillRecordOfTables(iotbLD_price_list_dehi, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last
				delete
				from LD_price_list_dehi
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last loop
					LockByPk
					(
							rcRecOfTab.PRICE_LIST_DEHI_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last
				delete
				from LD_price_list_dehi
				where
		         	PRICE_LIST_DEHI_Id = rcRecOfTab.PRICE_LIST_DEHI_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_price_list_dehi in styLD_price_list_dehi,
		inuLock	  in number default 0
	)
	IS
		nuPRICE_LIST_DEHI_Id LD_price_list_dehi.PRICE_LIST_DEHI_Id%type;

	BEGIN
		if ircLD_price_list_dehi.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_price_list_dehi.rowid,rcData);
			end if;
			update LD_price_list_dehi
			set

        Price_List_Id = ircLD_price_list_dehi.Price_List_Id,
        Article_Id = ircLD_price_list_dehi.Article_Id,
        Price = ircLD_price_list_dehi.Price,
        Price_Aproved = ircLD_price_list_dehi.Price_Aproved,
        Sale_Chanel_Id = ircLD_price_list_dehi.Sale_Chanel_Id,
        Geograp_Location_Id = ircLD_price_list_dehi.Geograp_Location_Id,
        Version = ircLD_price_list_dehi.Version,
        Register_Date = ircLD_price_list_dehi.Register_Date
			where
				rowid = ircLD_price_list_dehi.rowid
			returning
    PRICE_LIST_DEHI_Id
			into
				nuPRICE_LIST_DEHI_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_price_list_dehi.PRICE_LIST_DEHI_Id,
					rcData
				);
			end if;

			update LD_price_list_dehi
			set
        Price_List_Id = ircLD_price_list_dehi.Price_List_Id,
        Article_Id = ircLD_price_list_dehi.Article_Id,
        Price = ircLD_price_list_dehi.Price,
        Price_Aproved = ircLD_price_list_dehi.Price_Aproved,
        Sale_Chanel_Id = ircLD_price_list_dehi.Sale_Chanel_Id,
        Geograp_Location_Id = ircLD_price_list_dehi.Geograp_Location_Id,
        Version = ircLD_price_list_dehi.Version,
        Register_Date = ircLD_price_list_dehi.Register_Date
			where
	         	PRICE_LIST_DEHI_Id = ircLD_price_list_dehi.PRICE_LIST_DEHI_Id
			returning
    PRICE_LIST_DEHI_Id
			into
				nuPRICE_LIST_DEHI_Id;
		end if;

		if
			nuPRICE_LIST_DEHI_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_price_list_dehi));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_price_list_dehi in out nocopy tytbLD_price_list_dehi,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_price_list_dehi;
  BEGIN
    FillRecordOfTables(iotbLD_price_list_dehi,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last
        update LD_price_list_dehi
        set

            Price_List_Id = rcRecOfTab.Price_List_Id(n),
            Article_Id = rcRecOfTab.Article_Id(n),
            Price = rcRecOfTab.Price(n),
            Price_Aproved = rcRecOfTab.Price_Aproved(n),
            Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Version = rcRecOfTab.Version(n),
            Register_Date = rcRecOfTab.Register_Date(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last loop
          LockByPk
          (
              rcRecOfTab.PRICE_LIST_DEHI_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_price_list_dehi.first .. iotbLD_price_list_dehi.last
        update LD_price_list_dehi
        set
					Price_List_Id = rcRecOfTab.Price_List_Id(n),
					Article_Id = rcRecOfTab.Article_Id(n),
					Price = rcRecOfTab.Price(n),
					Price_Aproved = rcRecOfTab.Price_Aproved(n),
					Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Version = rcRecOfTab.Version(n),
					Register_Date = rcRecOfTab.Register_Date(n)
          where
          PRICE_LIST_DEHI_Id = rcRecOfTab.PRICE_LIST_DEHI_Id(n)
;
    end if;
  END;

	PROCEDURE updPrice_List_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuPrice_List_Id$ in LD_price_list_dehi.Price_List_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Price_List_Id = inuPrice_List_Id$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Price_List_Id:= inuPrice_List_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updArticle_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuArticle_Id$ in LD_price_list_dehi.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Article_Id = inuArticle_Id$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Article_Id:= inuArticle_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPrice
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuPrice$ in LD_price_list_dehi.Price%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Price = inuPrice$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Price:= inuPrice$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPrice_Aproved
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuPrice_Aproved$ in LD_price_list_dehi.Price_Aproved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Price_Aproved = inuPrice_Aproved$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Price_Aproved:= inuPrice_Aproved$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSale_Chanel_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuSale_Chanel_Id$ in LD_price_list_dehi.Sale_Chanel_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Sale_Chanel_Id = inuSale_Chanel_Id$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Sale_Chanel_Id:= inuSale_Chanel_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updGeograp_Location_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuGeograp_Location_Id$ in LD_price_list_dehi.Geograp_Location_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updVersion
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuVersion$ in LD_price_list_dehi.Version%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Version = inuVersion$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Version:= inuVersion$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		idtRegister_Date$ in LD_price_list_dehi.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_dehi;
	BEGIN
		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DEHI_Id,
				rcData
			);
		end if;

		update LD_price_list_dehi
		set
			Register_Date = idtRegister_Date$
		where
			PRICE_LIST_DEHI_Id = inuPRICE_LIST_DEHI_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPrice_List_Dehi_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Price_List_Dehi_Id%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Price_List_Dehi_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Price_List_Dehi_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPrice_List_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Price_List_Id%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Price_List_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Price_List_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetArticle_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Article_Id%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Article_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPrice
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Price%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Price);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Price);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPrice_Aproved
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Price_Aproved%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Price_Aproved);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Price_Aproved);
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
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Sale_Chanel_Id%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Sale_Chanel_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
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

	FUNCTION fnuGetGeograp_Location_Id
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Geograp_Location_Id%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Geograp_Location_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
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

	FUNCTION fnuGetVersion
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Version%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id := inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Version);
		end if;
		Load
		(
			inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Version);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetRegister_Date
	(
		inuPRICE_LIST_DEHI_Id in LD_price_list_dehi.PRICE_LIST_DEHI_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_dehi.Register_Date%type
	IS
		rcError styLD_price_list_dehi;
	BEGIN

		rcError.PRICE_LIST_DEHI_Id:=inuPRICE_LIST_DEHI_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_DEHI_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuPRICE_LIST_DEHI_Id
		);
		return(rcData.Register_Date);
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
end DALD_price_list_dehi;
/
PROMPT Otorgando permisos de ejecucion a DALD_price_list_dehi
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_price_list_dehi', 'ADM_PERSON');
END;
/
