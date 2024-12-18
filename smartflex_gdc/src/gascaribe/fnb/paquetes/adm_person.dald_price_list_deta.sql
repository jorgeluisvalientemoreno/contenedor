CREATE OR REPLACE PACKAGE adm_person.dald_price_list_deta
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
  )
  IS
		SELECT LD_price_list_deta.*,LD_price_list_deta.rowid
		FROM LD_price_list_deta
		WHERE
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_price_list_deta.*,LD_price_list_deta.rowid
		FROM LD_price_list_deta
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_price_list_deta  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_price_list_deta is table of styLD_price_list_deta index by binary_integer;
	type tyrfRecords is ref cursor return styLD_price_list_deta;

	/* Tipos referenciando al registro */
	type tytbPrice_List_Deta_Id is table of LD_price_list_deta.Price_List_Deta_Id%type index by binary_integer;
	type tytbPrice_List_Id is table of LD_price_list_deta.Price_List_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_price_list_deta.Article_Id%type index by binary_integer;
	type tytbPrice is table of LD_price_list_deta.Price%type index by binary_integer;
	type tytbPrice_Aproved is table of LD_price_list_deta.Price_Aproved%type index by binary_integer;
	type tytbSale_Chanel_Id is table of LD_price_list_deta.Sale_Chanel_Id%type index by binary_integer;
	type tytbGeograp_Location_Id is table of LD_price_list_deta.Geograp_Location_Id%type index by binary_integer;
	type tytbVersion is table of LD_price_list_deta.Version%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_price_list_deta is record
	(

		Price_List_Deta_Id   tytbPrice_List_Deta_Id,
		Price_List_Id   tytbPrice_List_Id,
		Article_Id   tytbArticle_Id,
		Price   tytbPrice,
		Price_Aproved   tytbPrice_Aproved,
		Sale_Chanel_Id   tytbSale_Chanel_Id,
		Geograp_Location_Id   tytbGeograp_Location_Id,
		Version   tytbVersion,
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	);

	PROCEDURE getRecord
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		orcRecord out nocopy styLD_price_list_deta
	);

	FUNCTION frcGetRcData
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN styLD_price_list_deta;

	FUNCTION frcGetRcData
	RETURN styLD_price_list_deta;

	FUNCTION frcGetRecord
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN styLD_price_list_deta;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_price_list_deta
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_price_list_deta in styLD_price_list_deta
	);

 	  PROCEDURE insRecord
	(
		ircLD_price_list_deta in styLD_price_list_deta,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_price_list_deta in out nocopy tytbLD_price_list_deta
	);

	PROCEDURE delRecord
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_price_list_deta in out nocopy tytbLD_price_list_deta,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_price_list_deta in styLD_price_list_deta,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_price_list_deta in out nocopy tytbLD_price_list_deta,
		inuLock in number default 1
	);

		PROCEDURE updPrice_List_Id
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuPrice_List_Id$  in LD_price_list_deta.Price_List_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updArticle_Id
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuArticle_Id$  in LD_price_list_deta.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrice
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuPrice$  in LD_price_list_deta.Price%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrice_Aproved
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuPrice_Aproved$  in LD_price_list_deta.Price_Aproved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSale_Chanel_Id
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuSale_Chanel_Id$  in LD_price_list_deta.Sale_Chanel_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGeograp_Location_Id
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuGeograp_Location_Id$  in LD_price_list_deta.Geograp_Location_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updVersion
		(
				inuPRICE_LIST_DETA_Id   in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
				inuVersion$  in LD_price_list_deta.Version%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPrice_List_Deta_Id
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Price_List_Deta_Id%type;

    	FUNCTION fnuGetPrice_List_Id
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Price_List_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Article_Id%type;

    	FUNCTION fnuGetPrice
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Price%type;

    	FUNCTION fnuGetPrice_Aproved
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Price_Aproved%type;

    	FUNCTION fnuGetSale_Chanel_Id
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Sale_Chanel_Id%type;

    	FUNCTION fnuGetGeograp_Location_Id
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Geograp_Location_Id%type;

    	FUNCTION fnuGetVersion
    	(
    	    inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_price_list_deta.Version%type;


	PROCEDURE LockByPk
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		orcLD_price_list_deta  out styLD_price_list_deta
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_price_list_deta  out styLD_price_list_deta
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_price_list_deta;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_price_list_deta
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PRICE_LIST_DETA';
	  cnuGeEntityId constant varchar2(30) := 8817; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	IS
		SELECT LD_price_list_deta.*,LD_price_list_deta.rowid
		FROM LD_price_list_deta
		WHERE  PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_price_list_deta.*,LD_price_list_deta.rowid
		FROM LD_price_list_deta
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_price_list_deta is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_price_list_deta;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_price_list_deta default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PRICE_LIST_DETA_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		orcLD_price_list_deta  out styLD_price_list_deta
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		Open cuLockRcByPk
		(
			inuPRICE_LIST_DETA_Id
		);

		fetch cuLockRcByPk into orcLD_price_list_deta;
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
		orcLD_price_list_deta  out styLD_price_list_deta
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_price_list_deta;
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
		itbLD_price_list_deta  in out nocopy tytbLD_price_list_deta
	)
	IS
	BEGIN
			rcRecOfTab.Price_List_Deta_Id.delete;
			rcRecOfTab.Price_List_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Price.delete;
			rcRecOfTab.Price_Aproved.delete;
			rcRecOfTab.Sale_Chanel_Id.delete;
			rcRecOfTab.Geograp_Location_Id.delete;
			rcRecOfTab.Version.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_price_list_deta  in out nocopy tytbLD_price_list_deta,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_price_list_deta);
		for n in itbLD_price_list_deta.first .. itbLD_price_list_deta.last loop
			rcRecOfTab.Price_List_Deta_Id(n) := itbLD_price_list_deta(n).Price_List_Deta_Id;
			rcRecOfTab.Price_List_Id(n) := itbLD_price_list_deta(n).Price_List_Id;
			rcRecOfTab.Article_Id(n) := itbLD_price_list_deta(n).Article_Id;
			rcRecOfTab.Price(n) := itbLD_price_list_deta(n).Price;
			rcRecOfTab.Price_Aproved(n) := itbLD_price_list_deta(n).Price_Aproved;
			rcRecOfTab.Sale_Chanel_Id(n) := itbLD_price_list_deta(n).Sale_Chanel_Id;
			rcRecOfTab.Geograp_Location_Id(n) := itbLD_price_list_deta(n).Geograp_Location_Id;
			rcRecOfTab.Version(n) := itbLD_price_list_deta(n).Version;
			rcRecOfTab.row_id(n) := itbLD_price_list_deta(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPRICE_LIST_DETA_Id = rcData.PRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPRICE_LIST_DETA_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN		rcError.PRICE_LIST_DETA_Id:=inuPRICE_LIST_DETA_Id;

		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPRICE_LIST_DETA_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		orcRecord out nocopy styLD_price_list_deta
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN		rcError.PRICE_LIST_DETA_Id:=inuPRICE_LIST_DETA_Id;

		Load
		(
			inuPRICE_LIST_DETA_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN styLD_price_list_deta
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id:=inuPRICE_LIST_DETA_Id;

		Load
		(
			inuPRICE_LIST_DETA_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type
	)
	RETURN styLD_price_list_deta
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id:=inuPRICE_LIST_DETA_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_price_list_deta
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_price_list_deta
	)
	IS
		rfLD_price_list_deta tyrfLD_price_list_deta;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_price_list_deta.Price_List_Deta_Id,
		            LD_price_list_deta.Price_List_Id,
		            LD_price_list_deta.Article_Id,
		            LD_price_list_deta.Price,
		            LD_price_list_deta.Price_Aproved,
		            LD_price_list_deta.Sale_Chanel_Id,
		            LD_price_list_deta.Geograp_Location_Id,
		            LD_price_list_deta.Version,
		            LD_price_list_deta.rowid
                FROM LD_price_list_deta';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_price_list_deta for sbFullQuery;
		fetch rfLD_price_list_deta bulk collect INTO otbResult;
		close rfLD_price_list_deta;
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
		            LD_price_list_deta.Price_List_Deta_Id,
		            LD_price_list_deta.Price_List_Id,
		            LD_price_list_deta.Article_Id,
		            LD_price_list_deta.Price,
		            LD_price_list_deta.Price_Aproved,
		            LD_price_list_deta.Sale_Chanel_Id,
		            LD_price_list_deta.Geograp_Location_Id,
		            LD_price_list_deta.Version,
		            LD_price_list_deta.rowid
                FROM LD_price_list_deta';
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
		ircLD_price_list_deta in styLD_price_list_deta
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_price_list_deta,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_price_list_deta in styLD_price_list_deta,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_price_list_deta.PRICE_LIST_DETA_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PRICE_LIST_DETA_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_price_list_deta
		(
			Price_List_Deta_Id,
			Price_List_Id,
			Article_Id,
			Price,
			Price_Aproved,
			Sale_Chanel_Id,
			Geograp_Location_Id,
			Version
		)
		values
		(
			ircLD_price_list_deta.Price_List_Deta_Id,
			ircLD_price_list_deta.Price_List_Id,
			ircLD_price_list_deta.Article_Id,
			ircLD_price_list_deta.Price,
			ircLD_price_list_deta.Price_Aproved,
			ircLD_price_list_deta.Sale_Chanel_Id,
			ircLD_price_list_deta.Geograp_Location_Id,
			ircLD_price_list_deta.Version
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_price_list_deta));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_price_list_deta in out nocopy tytbLD_price_list_deta
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_price_list_deta, blUseRowID);
		forall n in iotbLD_price_list_deta.first..iotbLD_price_list_deta.last
			insert into LD_price_list_deta
			(
			Price_List_Deta_Id,
			Price_List_Id,
			Article_Id,
			Price,
			Price_Aproved,
			Sale_Chanel_Id,
			Geograp_Location_Id,
			Version
		)
		values
		(
			rcRecOfTab.Price_List_Deta_Id(n),
			rcRecOfTab.Price_List_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Price(n),
			rcRecOfTab.Price_Aproved(n),
			rcRecOfTab.Sale_Chanel_Id(n),
			rcRecOfTab.Geograp_Location_Id(n),
			rcRecOfTab.Version(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id:=inuPRICE_LIST_DETA_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		delete
		from LD_price_list_deta
		where
       		PRICE_LIST_DETA_Id=inuPRICE_LIST_DETA_Id;
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
		rcError  styLD_price_list_deta;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_price_list_deta
		where
			rowid = iriRowID
		returning
   PRICE_LIST_DETA_Id
		into
			rcError.PRICE_LIST_DETA_Id;

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
		iotbLD_price_list_deta in out nocopy tytbLD_price_list_deta,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_price_list_deta;
	BEGIN
		FillRecordOfTables(iotbLD_price_list_deta, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last
				delete
				from LD_price_list_deta
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last loop
					LockByPk
					(
							rcRecOfTab.PRICE_LIST_DETA_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last
				delete
				from LD_price_list_deta
				where
		         	PRICE_LIST_DETA_Id = rcRecOfTab.PRICE_LIST_DETA_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_price_list_deta in styLD_price_list_deta,
		inuLock	  in number default 0
	)
	IS
		nuPRICE_LIST_DETA_Id LD_price_list_deta.PRICE_LIST_DETA_Id%type;

	BEGIN
		if ircLD_price_list_deta.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_price_list_deta.rowid,rcData);
			end if;
			update LD_price_list_deta
			set

        Price_List_Id = ircLD_price_list_deta.Price_List_Id,
        Article_Id = ircLD_price_list_deta.Article_Id,
        Price = ircLD_price_list_deta.Price,
        Price_Aproved = ircLD_price_list_deta.Price_Aproved,
        Sale_Chanel_Id = ircLD_price_list_deta.Sale_Chanel_Id,
        Geograp_Location_Id = ircLD_price_list_deta.Geograp_Location_Id,
        Version = ircLD_price_list_deta.Version
			where
				rowid = ircLD_price_list_deta.rowid
			returning
    PRICE_LIST_DETA_Id
			into
				nuPRICE_LIST_DETA_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_price_list_deta.PRICE_LIST_DETA_Id,
					rcData
				);
			end if;

			update LD_price_list_deta
			set
        Price_List_Id = ircLD_price_list_deta.Price_List_Id,
        Article_Id = ircLD_price_list_deta.Article_Id,
        Price = ircLD_price_list_deta.Price,
        Price_Aproved = ircLD_price_list_deta.Price_Aproved,
        Sale_Chanel_Id = ircLD_price_list_deta.Sale_Chanel_Id,
        Geograp_Location_Id = ircLD_price_list_deta.Geograp_Location_Id,
        Version = ircLD_price_list_deta.Version
			where
	         	PRICE_LIST_DETA_Id = ircLD_price_list_deta.PRICE_LIST_DETA_Id
			returning
    PRICE_LIST_DETA_Id
			into
				nuPRICE_LIST_DETA_Id;
		end if;

		if
			nuPRICE_LIST_DETA_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_price_list_deta));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_price_list_deta in out nocopy tytbLD_price_list_deta,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_price_list_deta;
  BEGIN
    FillRecordOfTables(iotbLD_price_list_deta,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last
        update LD_price_list_deta
        set

            Price_List_Id = rcRecOfTab.Price_List_Id(n),
            Article_Id = rcRecOfTab.Article_Id(n),
            Price = rcRecOfTab.Price(n),
            Price_Aproved = rcRecOfTab.Price_Aproved(n),
            Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Version = rcRecOfTab.Version(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last loop
          LockByPk
          (
              rcRecOfTab.PRICE_LIST_DETA_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_price_list_deta.first .. iotbLD_price_list_deta.last
        update LD_price_list_deta
        set
					Price_List_Id = rcRecOfTab.Price_List_Id(n),
					Article_Id = rcRecOfTab.Article_Id(n),
					Price = rcRecOfTab.Price(n),
					Price_Aproved = rcRecOfTab.Price_Aproved(n),
					Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Version = rcRecOfTab.Version(n)
          where
          PRICE_LIST_DETA_Id = rcRecOfTab.PRICE_LIST_DETA_Id(n)
;
    end if;
  END;

	PROCEDURE updPrice_List_Id
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuPrice_List_Id$ in LD_price_list_deta.Price_List_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Price_List_Id = inuPrice_List_Id$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuArticle_Id$ in LD_price_list_deta.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Article_Id = inuArticle_Id$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuPrice$ in LD_price_list_deta.Price%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Price = inuPrice$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuPrice_Aproved$ in LD_price_list_deta.Price_Aproved%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Price_Aproved = inuPrice_Aproved$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuSale_Chanel_Id$ in LD_price_list_deta.Sale_Chanel_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Sale_Chanel_Id = inuSale_Chanel_Id$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuGeograp_Location_Id$ in LD_price_list_deta.Geograp_Location_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuVersion$ in LD_price_list_deta.Version%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_price_list_deta;
	BEGIN
		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPRICE_LIST_DETA_Id,
				rcData
			);
		end if;

		update LD_price_list_deta
		set
			Version = inuVersion$
		where
			PRICE_LIST_DETA_Id = inuPRICE_LIST_DETA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Version:= inuVersion$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPrice_List_Deta_Id
	(
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Price_List_Deta_Id%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Price_List_Deta_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
		);
		return(rcData.Price_List_Deta_Id);
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Price_List_Id%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Price_List_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Article_Id%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Price%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Price);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Price_Aproved%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Price_Aproved);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Sale_Chanel_Id%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Sale_Chanel_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Geograp_Location_Id%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Geograp_Location_Id);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
		inuPRICE_LIST_DETA_Id in LD_price_list_deta.PRICE_LIST_DETA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_price_list_deta.Version%type
	IS
		rcError styLD_price_list_deta;
	BEGIN

		rcError.PRICE_LIST_DETA_Id := inuPRICE_LIST_DETA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPRICE_LIST_DETA_Id
			 )
		then
			 return(rcData.Version);
		end if;
		Load
		(
			inuPRICE_LIST_DETA_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_price_list_deta;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_PRICE_LIST_DETA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_PRICE_LIST_DETA', 'ADM_PERSON'); 
END;
/ 
