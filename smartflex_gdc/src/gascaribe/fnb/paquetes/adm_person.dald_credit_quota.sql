CREATE OR REPLACE PACKAGE adm_person.dald_credit_quota
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  IS
    SELECT LD_credit_quota.*,LD_credit_quota.rowid
    FROM LD_credit_quota
    WHERE
      Credit_Quota_Id = inuCredit_Quota_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_credit_quota.*,LD_credit_quota.rowid
    FROM LD_credit_quota
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_credit_quota  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_credit_quota is table of styLD_credit_quota index by binary_integer;
  type tyrfRecords is ref cursor return styLD_credit_quota;

  /* Tipos referenciando al registro */
  type tytbCredit_Quota_Id is table of LD_credit_quota.Credit_Quota_Id%type index by binary_integer;
  type tytbCategory_Id is table of LD_credit_quota.Category_Id%type index by binary_integer;
  type tytbSubcategory_Id is table of LD_credit_quota.Subcategory_Id%type index by binary_integer;
  type tytbGeographic_Location_Id is table of LD_credit_quota.Geographic_Location_Id%type index by binary_integer;
  type tytbQuota_Value is table of LD_credit_quota.Quota_Value%type index by binary_integer;
  type tytbPriority is table of LD_credit_quota.Priority%type index by binary_integer;
  type tytbSimulation is table of LD_credit_quota.Simulation%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_credit_quota is record
  (

    Credit_Quota_Id   tytbCredit_Quota_Id,
    Category_Id   tytbCategory_Id,
    Subcategory_Id   tytbSubcategory_Id,
    Geographic_Location_Id   tytbGeographic_Location_Id,
    Quota_Value   tytbQuota_Value,
    Priority   tytbPriority,
    Simulation   tytbSimulation,
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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  );

  PROCEDURE getRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    orcRecord out nocopy styLD_credit_quota
  );

  FUNCTION frcGetRcData
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN styLD_credit_quota;

  FUNCTION frcGetRcData
  RETURN styLD_credit_quota;

  FUNCTION frcGetRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN styLD_credit_quota;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_credit_quota
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_credit_quota in styLD_credit_quota
  );

     PROCEDURE insRecord
  (
    ircLD_credit_quota in styLD_credit_quota,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_credit_quota in out nocopy tytbLD_credit_quota
  );

  PROCEDURE delRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_credit_quota in out nocopy tytbLD_credit_quota,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_credit_quota in styLD_credit_quota,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_credit_quota in out nocopy tytbLD_credit_quota,
    inuLock in number default 1
  );

    PROCEDURE updCategory_Id
    (
        inuCredit_Quota_Id   in LD_credit_quota.Credit_Quota_Id%type,
        inuCategory_Id$  in LD_credit_quota.Category_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubcategory_Id
    (
        inuCredit_Quota_Id   in LD_credit_quota.Credit_Quota_Id%type,
        inuSubcategory_Id$  in LD_credit_quota.Subcategory_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updGeographic_Location_Id
    (
        inuCredit_Quota_Id   in LD_credit_quota.Credit_Quota_Id%type,
        inuGeographic_Location_Id$  in LD_credit_quota.Geographic_Location_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updQuota_Value
    (
        inuCredit_Quota_Id   in LD_credit_quota.Credit_Quota_Id%type,
        inuQuota_Value$  in LD_credit_quota.Quota_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updPriority
    (
        inuCredit_Quota_Id   in LD_credit_quota.Credit_Quota_Id%type,
        inuPriority$  in LD_credit_quota.Priority%type,
        inuLock    in number default 0
      );

    PROCEDURE updSimulation
    (
        inuCredit_Quota_Id   in LD_credit_quota.Credit_Quota_Id%type,
        isbSimulation$  in LD_credit_quota.Simulation%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCredit_Quota_Id
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Credit_Quota_Id%type;

      FUNCTION fnuGetCategory_Id
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Category_Id%type;

      FUNCTION fnuGetSubcategory_Id
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Subcategory_Id%type;

      FUNCTION fnuGetGeographic_Location_Id
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Geographic_Location_Id%type;

      FUNCTION fnuGetQuota_Value
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Quota_Value%type;

      FUNCTION fnuGetPriority
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Priority%type;

      FUNCTION fsbGetSimulation
      (
          inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_credit_quota.Simulation%type;


  PROCEDURE LockByPk
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    orcLD_credit_quota  out styLD_credit_quota
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_credit_quota  out styLD_credit_quota
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_credit_quota;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_credit_quota
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CREDIT_QUOTA';
    cnuGeEntityId constant varchar2(30) := 8324; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  IS
    SELECT LD_credit_quota.*,LD_credit_quota.rowid
    FROM LD_credit_quota
    WHERE  Credit_Quota_Id = inuCredit_Quota_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_credit_quota.*,LD_credit_quota.rowid
    FROM LD_credit_quota
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_credit_quota is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_credit_quota;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_credit_quota default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Credit_Quota_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    orcLD_credit_quota  out styLD_credit_quota
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    Open cuLockRcByPk
    (
      inuCredit_Quota_Id
    );

    fetch cuLockRcByPk into orcLD_credit_quota;
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
    orcLD_credit_quota  out styLD_credit_quota
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_credit_quota;
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
    itbLD_credit_quota  in out nocopy tytbLD_credit_quota
  )
  IS
  BEGIN
      rcRecOfTab.Credit_Quota_Id.delete;
      rcRecOfTab.Category_Id.delete;
      rcRecOfTab.Subcategory_Id.delete;
      rcRecOfTab.Geographic_Location_Id.delete;
      rcRecOfTab.Quota_Value.delete;
      rcRecOfTab.Priority.delete;
      rcRecOfTab.Simulation.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_credit_quota  in out nocopy tytbLD_credit_quota,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_credit_quota);
    for n in itbLD_credit_quota.first .. itbLD_credit_quota.last loop
      rcRecOfTab.Credit_Quota_Id(n) := itbLD_credit_quota(n).Credit_Quota_Id;
      rcRecOfTab.Category_Id(n) := itbLD_credit_quota(n).Category_Id;
      rcRecOfTab.Subcategory_Id(n) := itbLD_credit_quota(n).Subcategory_Id;
      rcRecOfTab.Geographic_Location_Id(n) := itbLD_credit_quota(n).Geographic_Location_Id;
      rcRecOfTab.Quota_Value(n) := itbLD_credit_quota(n).Quota_Value;
      rcRecOfTab.Priority(n) := itbLD_credit_quota(n).Priority;
      rcRecOfTab.Simulation(n) := itbLD_credit_quota(n).Simulation;
      rcRecOfTab.row_id(n) := itbLD_credit_quota(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCredit_Quota_Id
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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCredit_Quota_Id = rcData.Credit_Quota_Id
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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCredit_Quota_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  IS
    rcError styLD_credit_quota;
  BEGIN    rcError.Credit_Quota_Id:=inuCredit_Quota_Id;

    Load
    (
      inuCredit_Quota_Id
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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCredit_Quota_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    orcRecord out nocopy styLD_credit_quota
  )
  IS
    rcError styLD_credit_quota;
  BEGIN    rcError.Credit_Quota_Id:=inuCredit_Quota_Id;

    Load
    (
      inuCredit_Quota_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN styLD_credit_quota
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id:=inuCredit_Quota_Id;

    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type
  )
  RETURN styLD_credit_quota
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id:=inuCredit_Quota_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCredit_Quota_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_credit_quota
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_credit_quota
  )
  IS
    rfLD_credit_quota tyrfLD_credit_quota;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_credit_quota.Credit_Quota_Id,
                LD_credit_quota.Category_Id,
                LD_credit_quota.Subcategory_Id,
                LD_credit_quota.Geographic_Location_Id,
                LD_credit_quota.Quota_Value,
                LD_credit_quota.Priority,
                LD_credit_quota.Simulation,
                LD_credit_quota.rowid
                FROM LD_credit_quota';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_credit_quota for sbFullQuery;
    fetch rfLD_credit_quota bulk collect INTO otbResult;
    close rfLD_credit_quota;
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
                LD_credit_quota.Credit_Quota_Id,
                LD_credit_quota.Category_Id,
                LD_credit_quota.Subcategory_Id,
                LD_credit_quota.Geographic_Location_Id,
                LD_credit_quota.Quota_Value,
                LD_credit_quota.Priority,
                LD_credit_quota.Simulation,
                LD_credit_quota.rowid
                FROM LD_credit_quota';
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
    ircLD_credit_quota in styLD_credit_quota
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_credit_quota,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_credit_quota in styLD_credit_quota,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_credit_quota.Credit_Quota_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Credit_Quota_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_credit_quota
    (
      Credit_Quota_Id,
      Category_Id,
      Subcategory_Id,
      Geographic_Location_Id,
      Quota_Value,
      Priority,
      Simulation
    )
    values
    (
      ircLD_credit_quota.Credit_Quota_Id,
      ircLD_credit_quota.Category_Id,
      ircLD_credit_quota.Subcategory_Id,
      ircLD_credit_quota.Geographic_Location_Id,
      ircLD_credit_quota.Quota_Value,
      ircLD_credit_quota.Priority,
      ircLD_credit_quota.Simulation
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_credit_quota));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_credit_quota in out nocopy tytbLD_credit_quota
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_credit_quota, blUseRowID);
    forall n in iotbLD_credit_quota.first..iotbLD_credit_quota.last
      insert into LD_credit_quota
      (
      Credit_Quota_Id,
      Category_Id,
      Subcategory_Id,
      Geographic_Location_Id,
      Quota_Value,
      Priority,
      Simulation
    )
    values
    (
      rcRecOfTab.Credit_Quota_Id(n),
      rcRecOfTab.Category_Id(n),
      rcRecOfTab.Subcategory_Id(n),
      rcRecOfTab.Geographic_Location_Id(n),
      rcRecOfTab.Quota_Value(n),
      rcRecOfTab.Priority(n),
      rcRecOfTab.Simulation(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id:=inuCredit_Quota_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    delete
    from LD_credit_quota
    where
           Credit_Quota_Id=inuCredit_Quota_Id;
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
    rcError  styLD_credit_quota;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_credit_quota
    where
      rowid = iriRowID
    returning
   Credit_Quota_Id
    into
      rcError.Credit_Quota_Id;

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
    iotbLD_credit_quota in out nocopy tytbLD_credit_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_credit_quota;
  BEGIN
    FillRecordOfTables(iotbLD_credit_quota, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last
        delete
        from LD_credit_quota
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last loop
          LockByPk
          (
              rcRecOfTab.Credit_Quota_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last
        delete
        from LD_credit_quota
        where
               Credit_Quota_Id = rcRecOfTab.Credit_Quota_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_credit_quota in styLD_credit_quota,
    inuLock    in number default 0
  )
  IS
    nuCredit_Quota_Id LD_credit_quota.Credit_Quota_Id%type;

  BEGIN
    if ircLD_credit_quota.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_credit_quota.rowid,rcData);
      end if;
      update LD_credit_quota
      set

        Category_Id = ircLD_credit_quota.Category_Id,
        Subcategory_Id = ircLD_credit_quota.Subcategory_Id,
        Geographic_Location_Id = ircLD_credit_quota.Geographic_Location_Id,
        Quota_Value = ircLD_credit_quota.Quota_Value,
        Priority = ircLD_credit_quota.Priority,
        Simulation = ircLD_credit_quota.Simulation
      where
        rowid = ircLD_credit_quota.rowid
      returning
    Credit_Quota_Id
      into
        nuCredit_Quota_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_credit_quota.Credit_Quota_Id,
          rcData
        );
      end if;

      update LD_credit_quota
      set
        Category_Id = ircLD_credit_quota.Category_Id,
        Subcategory_Id = ircLD_credit_quota.Subcategory_Id,
        Geographic_Location_Id = ircLD_credit_quota.Geographic_Location_Id,
        Quota_Value = ircLD_credit_quota.Quota_Value,
        Priority = ircLD_credit_quota.Priority,
        Simulation = ircLD_credit_quota.Simulation
      where
             Credit_Quota_Id = ircLD_credit_quota.Credit_Quota_Id
      returning
    Credit_Quota_Id
      into
        nuCredit_Quota_Id;
    end if;

    if
      nuCredit_Quota_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_credit_quota));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_credit_quota in out nocopy tytbLD_credit_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_credit_quota;
  BEGIN
    FillRecordOfTables(iotbLD_credit_quota,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last
        update LD_credit_quota
        set

            Category_Id = rcRecOfTab.Category_Id(n),
            Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
            Geographic_Location_Id = rcRecOfTab.Geographic_Location_Id(n),
            Quota_Value = rcRecOfTab.Quota_Value(n),
            Priority = rcRecOfTab.Priority(n),
            Simulation = rcRecOfTab.Simulation(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last loop
          LockByPk
          (
              rcRecOfTab.Credit_Quota_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_credit_quota.first .. iotbLD_credit_quota.last
        update LD_credit_quota
        set
          Category_Id = rcRecOfTab.Category_Id(n),
          Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
          Geographic_Location_Id = rcRecOfTab.Geographic_Location_Id(n),
          Quota_Value = rcRecOfTab.Quota_Value(n),
          Priority = rcRecOfTab.Priority(n),
          Simulation = rcRecOfTab.Simulation(n)
          where
          Credit_Quota_Id = rcRecOfTab.Credit_Quota_Id(n)
;
    end if;
  END;

  PROCEDURE updCategory_Id
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuCategory_Id$ in LD_credit_quota.Category_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    update LD_credit_quota
    set
      Category_Id = inuCategory_Id$
    where
      Credit_Quota_Id = inuCredit_Quota_Id;

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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuSubcategory_Id$ in LD_credit_quota.Subcategory_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    update LD_credit_quota
    set
      Subcategory_Id = inuSubcategory_Id$
    where
      Credit_Quota_Id = inuCredit_Quota_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subcategory_Id:= inuSubcategory_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updGeographic_Location_Id
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuGeographic_Location_Id$ in LD_credit_quota.Geographic_Location_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    update LD_credit_quota
    set
      Geographic_Location_Id = inuGeographic_Location_Id$
    where
      Credit_Quota_Id = inuCredit_Quota_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Geographic_Location_Id:= inuGeographic_Location_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updQuota_Value
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuQuota_Value$ in LD_credit_quota.Quota_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    update LD_credit_quota
    set
      Quota_Value = inuQuota_Value$
    where
      Credit_Quota_Id = inuCredit_Quota_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Quota_Value:= inuQuota_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPriority
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuPriority$ in LD_credit_quota.Priority%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    update LD_credit_quota
    set
      Priority = inuPriority$
    where
      Credit_Quota_Id = inuCredit_Quota_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Priority:= inuPriority$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSimulation
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    isbSimulation$ in LD_credit_quota.Simulation%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_credit_quota;
  BEGIN
    rcError.Credit_Quota_Id := inuCredit_Quota_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCredit_Quota_Id,
        rcData
      );
    end if;

    update LD_credit_quota
    set
      Simulation = isbSimulation$
    where
      Credit_Quota_Id = inuCredit_Quota_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Simulation:= isbSimulation$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCredit_Quota_Id
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Credit_Quota_Id%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Credit_Quota_Id);
    end if;
    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData.Credit_Quota_Id);
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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Category_Id%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Category_Id);
    end if;
    Load
    (
      inuCredit_Quota_Id
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
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Subcategory_Id%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Subcategory_Id);
    end if;
    Load
    (
      inuCredit_Quota_Id
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

  FUNCTION fnuGetGeographic_Location_Id
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Geographic_Location_Id%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Geographic_Location_Id);
    end if;
    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData.Geographic_Location_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetQuota_Value
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Quota_Value%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Quota_Value);
    end if;
    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData.Quota_Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetPriority
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Priority%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id := inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Priority);
    end if;
    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData.Priority);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetSimulation
  (
    inuCredit_Quota_Id in LD_credit_quota.Credit_Quota_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_credit_quota.Simulation%type
  IS
    rcError styLD_credit_quota;
  BEGIN

    rcError.Credit_Quota_Id:=inuCredit_Quota_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCredit_Quota_Id
       )
    then
       return(rcData.Simulation);
    end if;
    Load
    (
      inuCredit_Quota_Id
    );
    return(rcData.Simulation);
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
end DALD_credit_quota;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CREDIT_QUOTA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CREDIT_QUOTA', 'ADM_PERSON'); 
END;
/  
