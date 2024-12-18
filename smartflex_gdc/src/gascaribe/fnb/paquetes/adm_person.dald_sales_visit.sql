CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_sales_visit
is  
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_sales_visit
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
    inupackage_id in LD_sales_visit.package_id %type
  )
  IS
    SELECT LD_sales_visit.*,LD_sales_visit.rowid
    FROM LD_sales_visit
    WHERE
      package_id = inupackage_id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sales_visit.*,LD_sales_visit.rowid
    FROM LD_sales_visit
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_sales_visit  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_sales_visit is table of styLD_sales_visit index by binary_integer;
  type tyrfRecords is ref cursor return styLD_sales_visit;

  /* Tipos referenciando al registro */
  type tytbPackage_Id is table of LD_sales_visit.Package_Id%type index by binary_integer;
  type tytbAddress_Id is table of LD_sales_visit.Address_Id%type index by binary_integer;
  type tytbVisit_Type_Id is table of LD_sales_visit.Visit_Type_Id%type index by binary_integer;
  type tytbVisit_Address_Id is table of LD_sales_visit.Visit_Address_Id%type index by binary_integer;
  type tytbShopkeeper_Id is table of LD_sales_visit.Shopkeeper_Id%type index by binary_integer;
  type tytbVisit_Sale_Cru_Id is table of LD_sales_visit.Visit_Sale_Cru_Id%type index by binary_integer;
  type tytbItem_Id is table of LD_sales_visit.Item_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_sales_visit is record
  (

    Package_Id   tytbPackage_Id,
    Address_Id   tytbAddress_Id,
    Visit_Type_Id   tytbVisit_Type_Id,
    Visit_Address_Id   tytbVisit_Address_Id,
    Shopkeeper_Id   tytbShopkeeper_Id,
    Visit_Sale_Cru_Id   tytbVisit_Sale_Cru_Id,
    Item_Id   tytbItem_Id,
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
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inupackage_id in LD_sales_visit.package_id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inupackage_id in LD_sales_visit.package_id%type
  );

  PROCEDURE getRecord
  (
    inupackage_id in LD_sales_visit.package_id%type,
    orcRecord out nocopy styLD_sales_visit
  );

  FUNCTION frcGetRcData
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN styLD_sales_visit;

  FUNCTION frcGetRcData
  RETURN styLD_sales_visit;

  FUNCTION frcGetRecord
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN styLD_sales_visit;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sales_visit
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_sales_visit in styLD_sales_visit
  );

     PROCEDURE insRecord
  (
    ircLD_sales_visit in styLD_sales_visit,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_sales_visit in out nocopy tytbLD_sales_visit
  );

  PROCEDURE delRecord
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_sales_visit in out nocopy tytbLD_sales_visit,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_sales_visit in styLD_sales_visit,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_sales_visit in out nocopy tytbLD_sales_visit,
    inuLock in number default 1
  );

    PROCEDURE updPackage_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuPackage_Id$  in LD_sales_visit.Package_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updAddress_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuAddress_Id$  in LD_sales_visit.Address_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updVisit_Type_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuVisit_Type_Id$  in LD_sales_visit.Visit_Type_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updVisit_Address_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuVisit_Address_Id$  in LD_sales_visit.Visit_Address_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updShopkeeper_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuShopkeeper_Id$  in LD_sales_visit.Shopkeeper_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updVisit_Sale_Cru_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuVisit_Sale_Cru_Id$  in LD_sales_visit.Visit_Sale_Cru_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updItem_Id
    (
        inupackage_id   in LD_sales_visit.package_id%type,
        inuItem_Id$  in LD_sales_visit.Item_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetPackage_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Package_Id%type;

      FUNCTION fnuGetAddress_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Address_Id%type;

      FUNCTION fnuGetVisit_Type_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Visit_Type_Id%type;

      FUNCTION fnuGetVisit_Address_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Visit_Address_Id%type;

      FUNCTION fnuGetShopkeeper_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Shopkeeper_Id%type;

      FUNCTION fnuGetVisit_Sale_Cru_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Visit_Sale_Cru_Id%type;

      FUNCTION fnuGetItem_Id
      (
          inupackage_id in LD_sales_visit.package_id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_visit.Item_Id%type;


  PROCEDURE LockByPk
  (
    inupackage_id in LD_sales_visit.package_id%type,
    orcLD_sales_visit  out styLD_sales_visit
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_sales_visit  out styLD_sales_visit
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_sales_visit;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_sales_visit
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO159429';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SALES_VISIT';
    cnuGeEntityId constant varchar2(30) := 8501; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  IS
    SELECT LD_sales_visit.*,LD_sales_visit.rowid
    FROM LD_sales_visit
    WHERE  package_id = inupackage_id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sales_visit.*,LD_sales_visit.rowid
    FROM LD_sales_visit
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_sales_visit is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_sales_visit;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_sales_visit default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.package_id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inupackage_id in LD_sales_visit.package_id%type,
    orcLD_sales_visit  out styLD_sales_visit
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;

    Open cuLockRcByPk
    (
      inupackage_id
    );

    fetch cuLockRcByPk into orcLD_sales_visit;
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
    orcLD_sales_visit  out styLD_sales_visit
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_sales_visit;
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
    itbLD_sales_visit  in out nocopy tytbLD_sales_visit
  )
  IS
  BEGIN
      rcRecOfTab.Package_Id.delete;
      rcRecOfTab.Address_Id.delete;
      rcRecOfTab.Visit_Type_Id.delete;
      rcRecOfTab.Visit_Address_Id.delete;
      rcRecOfTab.Shopkeeper_Id.delete;
      rcRecOfTab.Visit_Sale_Cru_Id.delete;
      rcRecOfTab.Item_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_sales_visit  in out nocopy tytbLD_sales_visit,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_sales_visit);
    for n in itbLD_sales_visit.first .. itbLD_sales_visit.last loop
      rcRecOfTab.Package_Id(n) := itbLD_sales_visit(n).Package_Id;
      rcRecOfTab.Address_Id(n) := itbLD_sales_visit(n).Address_Id;
      rcRecOfTab.Visit_Type_Id(n) := itbLD_sales_visit(n).Visit_Type_Id;
      rcRecOfTab.Visit_Address_Id(n) := itbLD_sales_visit(n).Visit_Address_Id;
      rcRecOfTab.Shopkeeper_Id(n) := itbLD_sales_visit(n).Shopkeeper_Id;
      rcRecOfTab.Visit_Sale_Cru_Id(n) := itbLD_sales_visit(n).Visit_Sale_Cru_Id;
      rcRecOfTab.Item_Id(n) := itbLD_sales_visit(n).Item_Id;
      rcRecOfTab.row_id(n) := itbLD_sales_visit(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inupackage_id
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
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inupackage_id = rcData.package_id
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
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inupackage_id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  IS
    rcError styLD_sales_visit;
  BEGIN    rcError.package_id:=inupackage_id;

    Load
    (
      inupackage_id
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
    inupackage_id in LD_sales_visit.package_id%type
  )
  IS
  BEGIN
    Load
    (
      inupackage_id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inupackage_id in LD_sales_visit.package_id%type,
    orcRecord out nocopy styLD_sales_visit
  )
  IS
    rcError styLD_sales_visit;
  BEGIN    rcError.package_id:=inupackage_id;

    Load
    (
      inupackage_id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN styLD_sales_visit
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id:=inupackage_id;

    Load
    (
      inupackage_id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inupackage_id in LD_sales_visit.package_id%type
  )
  RETURN styLD_sales_visit
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id:=inupackage_id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inupackage_id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_sales_visit
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sales_visit
  )
  IS
    rfLD_sales_visit tyrfLD_sales_visit;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_sales_visit.Package_Id,
                LD_sales_visit.Address_Id,
                LD_sales_visit.Visit_Type_Id,
                LD_sales_visit.Visit_Address_Id,
                LD_sales_visit.Shopkeeper_Id,
                LD_sales_visit.Visit_Sale_Cru_Id,
                LD_sales_visit.Item_Id,
                LD_sales_visit.rowid
                FROM LD_sales_visit';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_sales_visit for sbFullQuery;
    fetch rfLD_sales_visit bulk collect INTO otbResult;
    close rfLD_sales_visit;
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
                LD_sales_visit.Package_Id,
                LD_sales_visit.Address_Id,
                LD_sales_visit.Visit_Type_Id,
                LD_sales_visit.Visit_Address_Id,
                LD_sales_visit.Shopkeeper_Id,
                LD_sales_visit.Visit_Sale_Cru_Id,
                LD_sales_visit.Item_Id,
                LD_sales_visit.rowid
                FROM LD_sales_visit';
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
    ircLD_sales_visit in styLD_sales_visit
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_sales_visit,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_sales_visit in styLD_sales_visit,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_sales_visit.package_id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|package_id');
      raise ex.controlled_error;
    end if;
    insert into LD_sales_visit
    (
      Package_Id,
      Address_Id,
      Visit_Type_Id,
      Visit_Address_Id,
      Shopkeeper_Id,
      Visit_Sale_Cru_Id,
      Item_Id
    )
    values
    (
      ircLD_sales_visit.Package_Id,
      ircLD_sales_visit.Address_Id,
      ircLD_sales_visit.Visit_Type_Id,
      ircLD_sales_visit.Visit_Address_Id,
      ircLD_sales_visit.Shopkeeper_Id,
      ircLD_sales_visit.Visit_Sale_Cru_Id,
      ircLD_sales_visit.Item_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_sales_visit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_sales_visit in out nocopy tytbLD_sales_visit
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_sales_visit, blUseRowID);
    forall n in iotbLD_sales_visit.first..iotbLD_sales_visit.last
      insert into LD_sales_visit
      (
      Package_Id,
      Address_Id,
      Visit_Type_Id,
      Visit_Address_Id,
      Shopkeeper_Id,
      Visit_Sale_Cru_Id,
      Item_Id
    )
    values
    (
      rcRecOfTab.Package_Id(n),
      rcRecOfTab.Address_Id(n),
      rcRecOfTab.Visit_Type_Id(n),
      rcRecOfTab.Visit_Address_Id(n),
      rcRecOfTab.Shopkeeper_Id(n),
      rcRecOfTab.Visit_Sale_Cru_Id(n),
      rcRecOfTab.Item_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id:=inupackage_id;

    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    delete
    from LD_sales_visit
    where
           package_id=inupackage_id;
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
    rcError  styLD_sales_visit;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_sales_visit
    where
      rowid = iriRowID
    returning
   package_id
    into
      rcError.package_id;

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
    iotbLD_sales_visit in out nocopy tytbLD_sales_visit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sales_visit;
  BEGIN
    FillRecordOfTables(iotbLD_sales_visit, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last
        delete
        from LD_sales_visit
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last loop
          LockByPk
          (
              rcRecOfTab.package_id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last
        delete
        from LD_sales_visit
        where
               package_id = rcRecOfTab.package_id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_sales_visit in styLD_sales_visit,
    inuLock    in number default 0
  )
  IS
    nupackage_id LD_sales_visit.package_id%type;

  BEGIN
    if ircLD_sales_visit.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_sales_visit.rowid,rcData);
      end if;
      update LD_sales_visit
      set

        Package_Id = ircLD_sales_visit.Package_Id,
        Address_Id = ircLD_sales_visit.Address_Id,
        Visit_Type_Id = ircLD_sales_visit.Visit_Type_Id,
        Visit_Address_Id = ircLD_sales_visit.Visit_Address_Id,
        Shopkeeper_Id = ircLD_sales_visit.Shopkeeper_Id,
        Visit_Sale_Cru_Id = ircLD_sales_visit.Visit_Sale_Cru_Id,
        Item_Id = ircLD_sales_visit.Item_Id
      where
        rowid = ircLD_sales_visit.rowid
      returning
    package_id
      into
        nupackage_id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_sales_visit.package_id,
          rcData
        );
      end if;

      update LD_sales_visit
      set
        Package_Id = ircLD_sales_visit.Package_Id,
        Address_Id = ircLD_sales_visit.Address_Id,
        Visit_Type_Id = ircLD_sales_visit.Visit_Type_Id,
        Visit_Address_Id = ircLD_sales_visit.Visit_Address_Id,
        Shopkeeper_Id = ircLD_sales_visit.Shopkeeper_Id,
        Visit_Sale_Cru_Id = ircLD_sales_visit.Visit_Sale_Cru_Id,
        Item_Id = ircLD_sales_visit.Item_Id
      where
             package_id = ircLD_sales_visit.package_id
      returning
    package_id
      into
        nupackage_id;
    end if;

    if
      nupackage_id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_sales_visit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_sales_visit in out nocopy tytbLD_sales_visit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sales_visit;
  BEGIN
    FillRecordOfTables(iotbLD_sales_visit,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last
        update LD_sales_visit
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Address_Id = rcRecOfTab.Address_Id(n),
            Visit_Type_Id = rcRecOfTab.Visit_Type_Id(n),
            Visit_Address_Id = rcRecOfTab.Visit_Address_Id(n),
            Shopkeeper_Id = rcRecOfTab.Shopkeeper_Id(n),
            Visit_Sale_Cru_Id = rcRecOfTab.Visit_Sale_Cru_Id(n),
            Item_Id = rcRecOfTab.Item_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last loop
          LockByPk
          (
              rcRecOfTab.package_id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_visit.first .. iotbLD_sales_visit.last
        update LD_sales_visit
        set
          Package_Id = rcRecOfTab.Package_Id(n),
          Address_Id = rcRecOfTab.Address_Id(n),
          Visit_Type_Id = rcRecOfTab.Visit_Type_Id(n),
          Visit_Address_Id = rcRecOfTab.Visit_Address_Id(n),
          Shopkeeper_Id = rcRecOfTab.Shopkeeper_Id(n),
          Visit_Sale_Cru_Id = rcRecOfTab.Visit_Sale_Cru_Id(n),
          Item_Id = rcRecOfTab.Item_Id(n)
          where
          package_id = rcRecOfTab.package_id(n)
;
    end if;
  END;

  PROCEDURE updPackage_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuPackage_Id$ in LD_sales_visit.Package_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Package_Id = inuPackage_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Id:= inuPackage_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAddress_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuAddress_Id$ in LD_sales_visit.Address_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Address_Id = inuAddress_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Address_Id:= inuAddress_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updVisit_Type_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuVisit_Type_Id$ in LD_sales_visit.Visit_Type_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Visit_Type_Id = inuVisit_Type_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Visit_Type_Id:= inuVisit_Type_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updVisit_Address_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuVisit_Address_Id$ in LD_sales_visit.Visit_Address_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Visit_Address_Id = inuVisit_Address_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Visit_Address_Id:= inuVisit_Address_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updShopkeeper_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuShopkeeper_Id$ in LD_sales_visit.Shopkeeper_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Shopkeeper_Id = inuShopkeeper_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Shopkeeper_Id:= inuShopkeeper_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updVisit_Sale_Cru_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuVisit_Sale_Cru_Id$ in LD_sales_visit.Visit_Sale_Cru_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Visit_Sale_Cru_Id = inuVisit_Sale_Cru_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Visit_Sale_Cru_Id:= inuVisit_Sale_Cru_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updItem_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuItem_Id$ in LD_sales_visit.Item_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_visit;
  BEGIN
    rcError.package_id := inupackage_id;
    if inuLock=1 then
      LockByPk
      (
        inupackage_id,
        rcData
      );
    end if;

    update LD_sales_visit
    set
      Item_Id = inuItem_Id$
    where
      package_id = inupackage_id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Item_Id:= inuItem_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetPackage_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Package_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Package_Id);
    end if;
    Load
    (
      inupackage_id
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

  FUNCTION fnuGetAddress_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Address_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Address_Id);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData.Address_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetVisit_Type_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Visit_Type_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Visit_Type_Id);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData.Visit_Type_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetVisit_Address_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Visit_Address_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Visit_Address_Id);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData.Visit_Address_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetShopkeeper_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Shopkeeper_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Shopkeeper_Id);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData.Shopkeeper_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetVisit_Sale_Cru_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Visit_Sale_Cru_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Visit_Sale_Cru_Id);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData.Visit_Sale_Cru_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetItem_Id
  (
    inupackage_id in LD_sales_visit.package_id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_visit.Item_Id%type
  IS
    rcError styLD_sales_visit;
  BEGIN

    rcError.package_id := inupackage_id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inupackage_id
       )
    then
       return(rcData.Item_Id);
    end if;
    Load
    (
      inupackage_id
    );
    return(rcData.Item_Id);
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
end DALD_sales_visit;
/
PROMPT Otorgando permisos de ejecucion a DALD_SALES_VISIT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SALES_VISIT', 'ADM_PERSON');
END;
/
