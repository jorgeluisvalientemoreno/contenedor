CREATE OR REPLACE PACKAGE adm_person.dald_catalog
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inucatalog_Id in LD_catalog.catalog_Id%type
  )
  IS
		SELECT LD_catalog.*,LD_catalog.rowid
		FROM LD_catalog
		WHERE
			catalog_Id = inucatalog_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_catalog.*,LD_catalog.rowid
		FROM LD_catalog
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_catalog  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_catalog is table of styLD_catalog index by binary_integer;
	type tyrfRecords is ref cursor return styLD_catalog;

	/* Tipos referenciando al registro */
	type tytbCatalog_Id is table of LD_catalog.Catalog_Id%type index by binary_integer;
	type tytbSale_Contractor_Id is table of LD_catalog.Sale_Contractor_Id%type index by binary_integer;
	type tytbSupplier_Id is table of LD_catalog.Supplier_Id%type index by binary_integer;
	type tytbLine_Id is table of LD_catalog.Line_Id%type index by binary_integer;
	type tytbSubline_Id is table of LD_catalog.Subline_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_catalog.Article_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_catalog is record
	(

		Catalog_Id   tytbCatalog_Id,
		Sale_Contractor_Id   tytbSale_Contractor_Id,
		Supplier_Id   tytbSupplier_Id,
		Line_Id   tytbLine_Id,
		Subline_Id   tytbSubline_Id,
		Article_Id   tytbArticle_Id,
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
		inucatalog_Id in LD_catalog.catalog_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inucatalog_Id in LD_catalog.catalog_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inucatalog_Id in LD_catalog.catalog_Id%type
	);

	PROCEDURE getRecord
	(
		inucatalog_Id in LD_catalog.catalog_Id%type,
		orcRecord out nocopy styLD_catalog
	);

	FUNCTION frcGetRcData
	(
		inucatalog_Id in LD_catalog.catalog_Id%type
	)
	RETURN styLD_catalog;

	FUNCTION frcGetRcData
	RETURN styLD_catalog;

	FUNCTION frcGetRecord
	(
		inucatalog_Id in LD_catalog.catalog_Id%type
	)
	RETURN styLD_catalog;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_catalog
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_catalog in styLD_catalog
	);

 	  PROCEDURE insRecord
	(
		ircLD_catalog in styLD_catalog,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_catalog in out nocopy tytbLD_catalog
	);

	PROCEDURE delRecord
	(
		inucatalog_Id in LD_catalog.catalog_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_catalog in out nocopy tytbLD_catalog,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_catalog in styLD_catalog,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_catalog in out nocopy tytbLD_catalog,
		inuLock in number default 1
	);

		PROCEDURE updSale_Contractor_Id
		(
				inucatalog_Id   in LD_catalog.catalog_Id%type,
				inuSale_Contractor_Id$  in LD_catalog.Sale_Contractor_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inucatalog_Id   in LD_catalog.catalog_Id%type,
				inuSupplier_Id$  in LD_catalog.Supplier_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLine_Id
		(
				inucatalog_Id   in LD_catalog.catalog_Id%type,
				inuLine_Id$  in LD_catalog.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubline_Id
		(
				inucatalog_Id   in LD_catalog.catalog_Id%type,
				inuSubline_Id$  in LD_catalog.Subline_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updArticle_Id
		(
				inucatalog_Id   in LD_catalog.catalog_Id%type,
				inuArticle_Id$  in LD_catalog.Article_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetCatalog_Id
    	(
    	    inucatalog_Id in LD_catalog.catalog_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_catalog.Catalog_Id%type;

    	FUNCTION fnuGetSale_Contractor_Id
    	(
    	    inucatalog_Id in LD_catalog.catalog_Id%type,
		      inuRaiseError in number default 1
      )
      RETURN LD_catalog.Sale_Contractor_Id%type;

      FUNCTION fnuGetSupplier_Id
      (
          inucatalog_Id in LD_catalog.catalog_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_catalog.Supplier_Id%type;

      FUNCTION fnuGetLine_Id
      (
          inucatalog_Id in LD_catalog.catalog_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_catalog.Line_Id%type;

      FUNCTION fnuGetSubline_Id
      (
          inucatalog_Id in LD_catalog.catalog_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_catalog.Subline_Id%type;

      FUNCTION fnuGetArticle_Id
      (
          inucatalog_Id in LD_catalog.catalog_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_catalog.Article_Id%type;


  PROCEDURE LockByPk
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    orcLD_catalog  out styLD_catalog
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_catalog  out styLD_catalog
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_catalog;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_catalog
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CATALOG';
    cnuGeEntityId constant varchar2(30) := 8381; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  IS
    SELECT LD_catalog.*,LD_catalog.rowid
    FROM LD_catalog
    WHERE  catalog_Id = inucatalog_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_catalog.*,LD_catalog.rowid
    FROM LD_catalog
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_catalog is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_catalog;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_catalog default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.catalog_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    orcLD_catalog  out styLD_catalog
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id := inucatalog_Id;

    Open cuLockRcByPk
    (
      inucatalog_Id
    );

    fetch cuLockRcByPk into orcLD_catalog;
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
    orcLD_catalog  out styLD_catalog
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_catalog;
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
    itbLD_catalog  in out nocopy tytbLD_catalog
  )
  IS
  BEGIN
      rcRecOfTab.Catalog_Id.delete;
      rcRecOfTab.Sale_Contractor_Id.delete;
      rcRecOfTab.Supplier_Id.delete;
      rcRecOfTab.Line_Id.delete;
      rcRecOfTab.Subline_Id.delete;
      rcRecOfTab.Article_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_catalog  in out nocopy tytbLD_catalog,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_catalog);
    for n in itbLD_catalog.first .. itbLD_catalog.last loop
      rcRecOfTab.Catalog_Id(n) := itbLD_catalog(n).Catalog_Id;
      rcRecOfTab.Sale_Contractor_Id(n) := itbLD_catalog(n).Sale_Contractor_Id;
      rcRecOfTab.Supplier_Id(n) := itbLD_catalog(n).Supplier_Id;
      rcRecOfTab.Line_Id(n) := itbLD_catalog(n).Line_Id;
      rcRecOfTab.Subline_Id(n) := itbLD_catalog(n).Subline_Id;
      rcRecOfTab.Article_Id(n) := itbLD_catalog(n).Article_Id;
      rcRecOfTab.row_id(n) := itbLD_catalog(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inucatalog_Id
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
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inucatalog_Id = rcData.catalog_Id
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
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inucatalog_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  IS
    rcError styLD_catalog;
  BEGIN    rcError.catalog_Id:=inucatalog_Id;

    Load
    (
      inucatalog_Id
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
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  IS
  BEGIN
    Load
    (
      inucatalog_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    orcRecord out nocopy styLD_catalog
  )
  IS
    rcError styLD_catalog;
  BEGIN    rcError.catalog_Id:=inucatalog_Id;

    Load
    (
      inucatalog_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  RETURN styLD_catalog
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id:=inucatalog_Id;

    Load
    (
      inucatalog_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inucatalog_Id in LD_catalog.catalog_Id%type
  )
  RETURN styLD_catalog
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id:=inucatalog_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inucatalog_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inucatalog_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_catalog
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_catalog
  )
  IS
    rfLD_catalog tyrfLD_catalog;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_catalog.Catalog_Id,
                LD_catalog.Sale_Contractor_Id,
                LD_catalog.Supplier_Id,
                LD_catalog.Line_Id,
                LD_catalog.Subline_Id,
                LD_catalog.Article_Id,
                LD_catalog.rowid
                FROM LD_catalog';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_catalog for sbFullQuery;
    fetch rfLD_catalog bulk collect INTO otbResult;
    close rfLD_catalog;
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
                LD_catalog.Catalog_Id,
                LD_catalog.Sale_Contractor_Id,
                LD_catalog.Supplier_Id,
                LD_catalog.Line_Id,
                LD_catalog.Subline_Id,
                LD_catalog.Article_Id,
                LD_catalog.rowid
                FROM LD_catalog';
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
    ircLD_catalog in styLD_catalog
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_catalog,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_catalog in styLD_catalog,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_catalog.catalog_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|catalog_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_catalog
    (
      Catalog_Id,
      Sale_Contractor_Id,
      Supplier_Id,
      Line_Id,
      Subline_Id,
      Article_Id
    )
    values
    (
      ircLD_catalog.Catalog_Id,
      ircLD_catalog.Sale_Contractor_Id,
      ircLD_catalog.Supplier_Id,
      ircLD_catalog.Line_Id,
      ircLD_catalog.Subline_Id,
      ircLD_catalog.Article_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_catalog));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_catalog in out nocopy tytbLD_catalog
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_catalog, blUseRowID);
    forall n in iotbLD_catalog.first..iotbLD_catalog.last
      insert into LD_catalog
      (
      Catalog_Id,
      Sale_Contractor_Id,
      Supplier_Id,
      Line_Id,
      Subline_Id,
      Article_Id
    )
    values
    (
      rcRecOfTab.Catalog_Id(n),
      rcRecOfTab.Sale_Contractor_Id(n),
      rcRecOfTab.Supplier_Id(n),
      rcRecOfTab.Line_Id(n),
      rcRecOfTab.Subline_Id(n),
      rcRecOfTab.Article_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id:=inucatalog_Id;

    if inuLock=1 then
      LockByPk
      (
        inucatalog_Id,
        rcData
      );
    end if;

    delete
    from LD_catalog
    where
           catalog_Id=inucatalog_Id;
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
    rcError  styLD_catalog;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_catalog
    where
      rowid = iriRowID
    returning
   catalog_Id
    into
      rcError.catalog_Id;

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
    iotbLD_catalog in out nocopy tytbLD_catalog,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_catalog;
  BEGIN
    FillRecordOfTables(iotbLD_catalog, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_catalog.first .. iotbLD_catalog.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_catalog.first .. iotbLD_catalog.last
        delete
        from LD_catalog
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_catalog.first .. iotbLD_catalog.last loop
          LockByPk
          (
              rcRecOfTab.catalog_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_catalog.first .. iotbLD_catalog.last
        delete
        from LD_catalog
        where
               catalog_Id = rcRecOfTab.catalog_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_catalog in styLD_catalog,
    inuLock    in number default 0
  )
  IS
    nucatalog_Id LD_catalog.catalog_Id%type;

  BEGIN
    if ircLD_catalog.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_catalog.rowid,rcData);
      end if;
      update LD_catalog
      set

        Sale_Contractor_Id = ircLD_catalog.Sale_Contractor_Id,
        Supplier_Id = ircLD_catalog.Supplier_Id,
        Line_Id = ircLD_catalog.Line_Id,
        Subline_Id = ircLD_catalog.Subline_Id,
        Article_Id = ircLD_catalog.Article_Id
      where
        rowid = ircLD_catalog.rowid
      returning
    catalog_Id
      into
        nucatalog_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_catalog.catalog_Id,
          rcData
        );
      end if;

      update LD_catalog
      set
        Sale_Contractor_Id = ircLD_catalog.Sale_Contractor_Id,
        Supplier_Id = ircLD_catalog.Supplier_Id,
        Line_Id = ircLD_catalog.Line_Id,
        Subline_Id = ircLD_catalog.Subline_Id,
        Article_Id = ircLD_catalog.Article_Id
      where
             catalog_Id = ircLD_catalog.catalog_Id
      returning
    catalog_Id
      into
        nucatalog_Id;
    end if;

    if
      nucatalog_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_catalog));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_catalog in out nocopy tytbLD_catalog,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_catalog;
  BEGIN
    FillRecordOfTables(iotbLD_catalog,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_catalog.first .. iotbLD_catalog.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_catalog.first .. iotbLD_catalog.last
        update LD_catalog
        set

            Sale_Contractor_Id = rcRecOfTab.Sale_Contractor_Id(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Article_Id = rcRecOfTab.Article_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_catalog.first .. iotbLD_catalog.last loop
          LockByPk
          (
              rcRecOfTab.catalog_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_catalog.first .. iotbLD_catalog.last
        update LD_catalog
        set
          Sale_Contractor_Id = rcRecOfTab.Sale_Contractor_Id(n),
          Supplier_Id = rcRecOfTab.Supplier_Id(n),
          Line_Id = rcRecOfTab.Line_Id(n),
          Subline_Id = rcRecOfTab.Subline_Id(n),
          Article_Id = rcRecOfTab.Article_Id(n)
          where
          catalog_Id = rcRecOfTab.catalog_Id(n)
;
    end if;
  END;

  PROCEDURE updSale_Contractor_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuSale_Contractor_Id$ in LD_catalog.Sale_Contractor_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id := inucatalog_Id;
    if inuLock=1 then
      LockByPk
      (
        inucatalog_Id,
        rcData
      );
    end if;

    update LD_catalog
    set
      Sale_Contractor_Id = inuSale_Contractor_Id$
    where
      catalog_Id = inucatalog_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sale_Contractor_Id:= inuSale_Contractor_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSupplier_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuSupplier_Id$ in LD_catalog.Supplier_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id := inucatalog_Id;
    if inuLock=1 then
      LockByPk
      (
        inucatalog_Id,
        rcData
      );
    end if;

    update LD_catalog
    set
      Supplier_Id = inuSupplier_Id$
    where
      catalog_Id = inucatalog_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Supplier_Id:= inuSupplier_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updLine_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuLine_Id$ in LD_catalog.Line_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id := inucatalog_Id;
    if inuLock=1 then
      LockByPk
      (
        inucatalog_Id,
        rcData
      );
    end if;

    update LD_catalog
    set
      Line_Id = inuLine_Id$
    where
      catalog_Id = inucatalog_Id;

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
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuSubline_Id$ in LD_catalog.Subline_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id := inucatalog_Id;
    if inuLock=1 then
      LockByPk
      (
        inucatalog_Id,
        rcData
      );
    end if;

    update LD_catalog
    set
      Subline_Id = inuSubline_Id$
    where
      catalog_Id = inucatalog_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subline_Id:= inuSubline_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updArticle_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuArticle_Id$ in LD_catalog.Article_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_catalog;
  BEGIN
    rcError.catalog_Id := inucatalog_Id;
    if inuLock=1 then
      LockByPk
      (
        inucatalog_Id,
        rcData
      );
    end if;

    update LD_catalog
    set
      Article_Id = inuArticle_Id$
    where
      catalog_Id = inucatalog_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Article_Id:= inuArticle_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCatalog_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_catalog.Catalog_Id%type
  IS
    rcError styLD_catalog;
  BEGIN

    rcError.catalog_Id := inucatalog_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inucatalog_Id
       )
    then
       return(rcData.Catalog_Id);
    end if;
    Load
    (
      inucatalog_Id
    );
    return(rcData.Catalog_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSale_Contractor_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_catalog.Sale_Contractor_Id%type
  IS
    rcError styLD_catalog;
  BEGIN

    rcError.catalog_Id := inucatalog_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inucatalog_Id
       )
    then
       return(rcData.Sale_Contractor_Id);
    end if;
    Load
    (
      inucatalog_Id
    );
    return(rcData.Sale_Contractor_Id);
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
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_catalog.Supplier_Id%type
  IS
    rcError styLD_catalog;
  BEGIN

    rcError.catalog_Id := inucatalog_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inucatalog_Id
       )
    then
       return(rcData.Supplier_Id);
    end if;
    Load
    (
      inucatalog_Id
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

  FUNCTION fnuGetLine_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_catalog.Line_Id%type
  IS
    rcError styLD_catalog;
  BEGIN

    rcError.catalog_Id := inucatalog_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inucatalog_Id
       )
    then
       return(rcData.Line_Id);
    end if;
    Load
    (
      inucatalog_Id
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
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_catalog.Subline_Id%type
  IS
    rcError styLD_catalog;
  BEGIN

    rcError.catalog_Id := inucatalog_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inucatalog_Id
       )
    then
       return(rcData.Subline_Id);
    end if;
    Load
    (
      inucatalog_Id
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

  FUNCTION fnuGetArticle_Id
  (
    inucatalog_Id in LD_catalog.catalog_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_catalog.Article_Id%type
  IS
    rcError styLD_catalog;
  BEGIN

    rcError.catalog_Id := inucatalog_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inucatalog_Id
       )
    then
       return(rcData.Article_Id);
    end if;
    Load
    (
      inucatalog_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_catalog;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CATALOG
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CATALOG', 'ADM_PERSON'); 
END;
/
