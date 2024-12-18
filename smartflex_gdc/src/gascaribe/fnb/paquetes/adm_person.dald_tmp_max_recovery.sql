CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_tmp_max_recovery
is
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  IS
    SELECT LD_tmp_max_recovery.*,LD_tmp_max_recovery.rowid
    FROM LD_tmp_max_recovery
    WHERE
      TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_tmp_max_recovery.*,LD_tmp_max_recovery.rowid
    FROM LD_tmp_max_recovery
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_tmp_max_recovery  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_tmp_max_recovery is table of styLD_tmp_max_recovery index by binary_integer;
  type tyrfRecords is ref cursor return styLD_tmp_max_recovery;

  /* Tipos referenciando al registro */
  type tytbTmp_Max_Recovery_Id is table of LD_tmp_max_recovery.Tmp_Max_Recovery_Id%type index by binary_integer;
  type tytbUbication_Id is table of LD_tmp_max_recovery.Ubication_Id%type index by binary_integer;
  type tytbYear is table of LD_tmp_max_recovery.Year%type index by binary_integer;
  type tytbMonth is table of LD_tmp_max_recovery.Month%type index by binary_integer;
  type tytbRecovery_Value is table of LD_tmp_max_recovery.Recovery_Value%type index by binary_integer;
  type tytbTotal_Sub_Recovery is table of LD_tmp_max_recovery.Total_Sub_Recovery%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_tmp_max_recovery is record
  (

    Tmp_Max_Recovery_Id   tytbTmp_Max_Recovery_Id,
    Ubication_Id   tytbUbication_Id,
    Year   tytbYear,
    Month   tytbMonth,
    Recovery_Value   tytbRecovery_Value,
    Total_Sub_Recovery   tytbTotal_Sub_Recovery,
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
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  );

  PROCEDURE getRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    orcRecord out nocopy styLD_tmp_max_recovery
  );

  FUNCTION frcGetRcData
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN styLD_tmp_max_recovery;

  FUNCTION frcGetRcData
  RETURN styLD_tmp_max_recovery;

  FUNCTION frcGetRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN styLD_tmp_max_recovery;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_tmp_max_recovery
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_tmp_max_recovery in styLD_tmp_max_recovery
  );

     PROCEDURE insRecord
  (
    ircLD_tmp_max_recovery in styLD_tmp_max_recovery,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_tmp_max_recovery in out nocopy tytbLD_tmp_max_recovery
  );

  PROCEDURE delRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_tmp_max_recovery in out nocopy tytbLD_tmp_max_recovery,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_tmp_max_recovery in styLD_tmp_max_recovery,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_tmp_max_recovery in out nocopy tytbLD_tmp_max_recovery,
    inuLock in number default 1
  );

    PROCEDURE updUbication_Id
    (
        inuTMP_MAX_RECOVERY_Id   in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
        inuUbication_Id$  in LD_tmp_max_recovery.Ubication_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updYear
    (
        inuTMP_MAX_RECOVERY_Id   in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
        inuYear$  in LD_tmp_max_recovery.Year%type,
        inuLock    in number default 0
      );

    PROCEDURE updMonth
    (
        inuTMP_MAX_RECOVERY_Id   in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
        inuMonth$  in LD_tmp_max_recovery.Month%type,
        inuLock    in number default 0
      );

    PROCEDURE updRecovery_Value
    (
        inuTMP_MAX_RECOVERY_Id   in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
        inuRecovery_Value$  in LD_tmp_max_recovery.Recovery_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updTotal_Sub_Recovery
    (
        inuTMP_MAX_RECOVERY_Id   in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
        inuTotal_Sub_Recovery$  in LD_tmp_max_recovery.Total_Sub_Recovery%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetTmp_Max_Recovery_Id
      (
          inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_tmp_max_recovery.Tmp_Max_Recovery_Id%type;

      FUNCTION fnuGetUbication_Id
      (
          inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_tmp_max_recovery.Ubication_Id%type;

      FUNCTION fnuGetYear
      (
          inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_tmp_max_recovery.Year%type;

      FUNCTION fnuGetMonth
      (
          inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_tmp_max_recovery.Month%type;

      FUNCTION fnuGetRecovery_Value
      (
          inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_tmp_max_recovery.Recovery_Value%type;

      FUNCTION fnuGetTotal_Sub_Recovery
      (
          inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_tmp_max_recovery.Total_Sub_Recovery%type;


  PROCEDURE LockByPk
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    orcLD_tmp_max_recovery  out styLD_tmp_max_recovery
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_tmp_max_recovery  out styLD_tmp_max_recovery
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_tmp_max_recovery;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_tmp_max_recovery
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_TMP_MAX_RECOVERY';
    cnuGeEntityId constant varchar2(30) := 1; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  IS
    SELECT LD_tmp_max_recovery.*,LD_tmp_max_recovery.rowid
    FROM LD_tmp_max_recovery
    WHERE  TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_tmp_max_recovery.*,LD_tmp_max_recovery.rowid
    FROM LD_tmp_max_recovery
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_tmp_max_recovery is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_tmp_max_recovery;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_tmp_max_recovery default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.TMP_MAX_RECOVERY_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    orcLD_tmp_max_recovery  out styLD_tmp_max_recovery
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    Open cuLockRcByPk
    (
      inuTMP_MAX_RECOVERY_Id
    );

    fetch cuLockRcByPk into orcLD_tmp_max_recovery;
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
    orcLD_tmp_max_recovery  out styLD_tmp_max_recovery
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_tmp_max_recovery;
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
    itbLD_tmp_max_recovery  in out nocopy tytbLD_tmp_max_recovery
  )
  IS
  BEGIN
      rcRecOfTab.Tmp_Max_Recovery_Id.delete;
      rcRecOfTab.Ubication_Id.delete;
      rcRecOfTab.Year.delete;
      rcRecOfTab.Month.delete;
      rcRecOfTab.Recovery_Value.delete;
      rcRecOfTab.Total_Sub_Recovery.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_tmp_max_recovery  in out nocopy tytbLD_tmp_max_recovery,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_tmp_max_recovery);
    for n in itbLD_tmp_max_recovery.first .. itbLD_tmp_max_recovery.last loop
      rcRecOfTab.Tmp_Max_Recovery_Id(n) := itbLD_tmp_max_recovery(n).Tmp_Max_Recovery_Id;
      rcRecOfTab.Ubication_Id(n) := itbLD_tmp_max_recovery(n).Ubication_Id;
      rcRecOfTab.Year(n) := itbLD_tmp_max_recovery(n).Year;
      rcRecOfTab.Month(n) := itbLD_tmp_max_recovery(n).Month;
      rcRecOfTab.Recovery_Value(n) := itbLD_tmp_max_recovery(n).Recovery_Value;
      rcRecOfTab.Total_Sub_Recovery(n) := itbLD_tmp_max_recovery(n).Total_Sub_Recovery;
      rcRecOfTab.row_id(n) := itbLD_tmp_max_recovery(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuTMP_MAX_RECOVERY_Id
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
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuTMP_MAX_RECOVERY_Id = rcData.TMP_MAX_RECOVERY_Id
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
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN    rcError.TMP_MAX_RECOVERY_Id:=inuTMP_MAX_RECOVERY_Id;

    Load
    (
      inuTMP_MAX_RECOVERY_Id
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
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    orcRecord out nocopy styLD_tmp_max_recovery
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN    rcError.TMP_MAX_RECOVERY_Id:=inuTMP_MAX_RECOVERY_Id;

    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN styLD_tmp_max_recovery
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id:=inuTMP_MAX_RECOVERY_Id;

    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type
  )
  RETURN styLD_tmp_max_recovery
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id:=inuTMP_MAX_RECOVERY_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_tmp_max_recovery
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_tmp_max_recovery
  )
  IS
    rfLD_tmp_max_recovery tyrfLD_tmp_max_recovery;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_tmp_max_recovery.Tmp_Max_Recovery_Id,
                LD_tmp_max_recovery.Ubication_Id,
                LD_tmp_max_recovery.Year,
                LD_tmp_max_recovery.Month,
                LD_tmp_max_recovery.Recovery_Value,
                LD_tmp_max_recovery.Total_Sub_Recovery,
                LD_tmp_max_recovery.rowid
                FROM LD_tmp_max_recovery';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_tmp_max_recovery for sbFullQuery;
    fetch rfLD_tmp_max_recovery bulk collect INTO otbResult;
    close rfLD_tmp_max_recovery;
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
                LD_tmp_max_recovery.Tmp_Max_Recovery_Id,
                LD_tmp_max_recovery.Ubication_Id,
                LD_tmp_max_recovery.Year,
                LD_tmp_max_recovery.Month,
                LD_tmp_max_recovery.Recovery_Value,
                LD_tmp_max_recovery.Total_Sub_Recovery,
                LD_tmp_max_recovery.rowid
                FROM LD_tmp_max_recovery';
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
    ircLD_tmp_max_recovery in styLD_tmp_max_recovery
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_tmp_max_recovery,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_tmp_max_recovery in styLD_tmp_max_recovery,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_tmp_max_recovery.TMP_MAX_RECOVERY_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|TMP_MAX_RECOVERY_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_tmp_max_recovery
    (
      Tmp_Max_Recovery_Id,
      Ubication_Id,
      Year,
      Month,
      Recovery_Value,
      Total_Sub_Recovery
    )
    values
    (
      ircLD_tmp_max_recovery.Tmp_Max_Recovery_Id,
      ircLD_tmp_max_recovery.Ubication_Id,
      ircLD_tmp_max_recovery.Year,
      ircLD_tmp_max_recovery.Month,
      ircLD_tmp_max_recovery.Recovery_Value,
      ircLD_tmp_max_recovery.Total_Sub_Recovery
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_tmp_max_recovery));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_tmp_max_recovery in out nocopy tytbLD_tmp_max_recovery
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_tmp_max_recovery, blUseRowID);
    forall n in iotbLD_tmp_max_recovery.first..iotbLD_tmp_max_recovery.last
      insert into LD_tmp_max_recovery
      (
      Tmp_Max_Recovery_Id,
      Ubication_Id,
      Year,
      Month,
      Recovery_Value,
      Total_Sub_Recovery
    )
    values
    (
      rcRecOfTab.Tmp_Max_Recovery_Id(n),
      rcRecOfTab.Ubication_Id(n),
      rcRecOfTab.Year(n),
      rcRecOfTab.Month(n),
      rcRecOfTab.Recovery_Value(n),
      rcRecOfTab.Total_Sub_Recovery(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id:=inuTMP_MAX_RECOVERY_Id;

    if inuLock=1 then
      LockByPk
      (
        inuTMP_MAX_RECOVERY_Id,
        rcData
      );
    end if;

    delete
    from LD_tmp_max_recovery
    where
           TMP_MAX_RECOVERY_Id=inuTMP_MAX_RECOVERY_Id;
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
    rcError  styLD_tmp_max_recovery;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_tmp_max_recovery
    where
      rowid = iriRowID
    returning
   TMP_MAX_RECOVERY_Id
    into
      rcError.TMP_MAX_RECOVERY_Id;

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
    iotbLD_tmp_max_recovery in out nocopy tytbLD_tmp_max_recovery,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_tmp_max_recovery;
  BEGIN
    FillRecordOfTables(iotbLD_tmp_max_recovery, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last
        delete
        from LD_tmp_max_recovery
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last loop
          LockByPk
          (
              rcRecOfTab.TMP_MAX_RECOVERY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last
        delete
        from LD_tmp_max_recovery
        where
               TMP_MAX_RECOVERY_Id = rcRecOfTab.TMP_MAX_RECOVERY_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_tmp_max_recovery in styLD_tmp_max_recovery,
    inuLock    in number default 0
  )
  IS
    nuTMP_MAX_RECOVERY_Id LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type;

  BEGIN
    if ircLD_tmp_max_recovery.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_tmp_max_recovery.rowid,rcData);
      end if;
      update LD_tmp_max_recovery
      set

        Ubication_Id = ircLD_tmp_max_recovery.Ubication_Id,
        Year = ircLD_tmp_max_recovery.Year,
        Month = ircLD_tmp_max_recovery.Month,
        Recovery_Value = ircLD_tmp_max_recovery.Recovery_Value,
        Total_Sub_Recovery = ircLD_tmp_max_recovery.Total_Sub_Recovery
      where
        rowid = ircLD_tmp_max_recovery.rowid
      returning
    TMP_MAX_RECOVERY_Id
      into
        nuTMP_MAX_RECOVERY_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_tmp_max_recovery.TMP_MAX_RECOVERY_Id,
          rcData
        );
      end if;

      update LD_tmp_max_recovery
      set
        Ubication_Id = ircLD_tmp_max_recovery.Ubication_Id,
        Year = ircLD_tmp_max_recovery.Year,
        Month = ircLD_tmp_max_recovery.Month,
        Recovery_Value = ircLD_tmp_max_recovery.Recovery_Value,
        Total_Sub_Recovery = ircLD_tmp_max_recovery.Total_Sub_Recovery
      where
             TMP_MAX_RECOVERY_Id = ircLD_tmp_max_recovery.TMP_MAX_RECOVERY_Id
      returning
    TMP_MAX_RECOVERY_Id
      into
        nuTMP_MAX_RECOVERY_Id;
    end if;

    if
      nuTMP_MAX_RECOVERY_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_tmp_max_recovery));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_tmp_max_recovery in out nocopy tytbLD_tmp_max_recovery,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_tmp_max_recovery;
  BEGIN
    FillRecordOfTables(iotbLD_tmp_max_recovery,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last
        update LD_tmp_max_recovery
        set

            Ubication_Id = rcRecOfTab.Ubication_Id(n),
            Year = rcRecOfTab.Year(n),
            Month = rcRecOfTab.Month(n),
            Recovery_Value = rcRecOfTab.Recovery_Value(n),
            Total_Sub_Recovery = rcRecOfTab.Total_Sub_Recovery(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last loop
          LockByPk
          (
              rcRecOfTab.TMP_MAX_RECOVERY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_tmp_max_recovery.first .. iotbLD_tmp_max_recovery.last
        update LD_tmp_max_recovery
        set
          Ubication_Id = rcRecOfTab.Ubication_Id(n),
          Year = rcRecOfTab.Year(n),
          Month = rcRecOfTab.Month(n),
          Recovery_Value = rcRecOfTab.Recovery_Value(n),
          Total_Sub_Recovery = rcRecOfTab.Total_Sub_Recovery(n)
          where
          TMP_MAX_RECOVERY_Id = rcRecOfTab.TMP_MAX_RECOVERY_Id(n)
;
    end if;
  END;

  PROCEDURE updUbication_Id
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuUbication_Id$ in LD_tmp_max_recovery.Ubication_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTMP_MAX_RECOVERY_Id,
        rcData
      );
    end if;

    update LD_tmp_max_recovery
    set
      Ubication_Id = inuUbication_Id$
    where
      TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ubication_Id:= inuUbication_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updYear
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuYear$ in LD_tmp_max_recovery.Year%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTMP_MAX_RECOVERY_Id,
        rcData
      );
    end if;

    update LD_tmp_max_recovery
    set
      Year = inuYear$
    where
      TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Year:= inuYear$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updMonth
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuMonth$ in LD_tmp_max_recovery.Month%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTMP_MAX_RECOVERY_Id,
        rcData
      );
    end if;

    update LD_tmp_max_recovery
    set
      Month = inuMonth$
    where
      TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Month:= inuMonth$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecovery_Value
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRecovery_Value$ in LD_tmp_max_recovery.Recovery_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTMP_MAX_RECOVERY_Id,
        rcData
      );
    end if;

    update LD_tmp_max_recovery
    set
      Recovery_Value = inuRecovery_Value$
    where
      TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Recovery_Value:= inuRecovery_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTotal_Sub_Recovery
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuTotal_Sub_Recovery$ in LD_tmp_max_recovery.Total_Sub_Recovery%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN
    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTMP_MAX_RECOVERY_Id,
        rcData
      );
    end if;

    update LD_tmp_max_recovery
    set
      Total_Sub_Recovery = inuTotal_Sub_Recovery$
    where
      TMP_MAX_RECOVERY_Id = inuTMP_MAX_RECOVERY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Total_Sub_Recovery:= inuTotal_Sub_Recovery$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetTmp_Max_Recovery_Id
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_tmp_max_recovery.Tmp_Max_Recovery_Id%type
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN

    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData.Tmp_Max_Recovery_Id);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData.Tmp_Max_Recovery_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetUbication_Id
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_tmp_max_recovery.Ubication_Id%type
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN

    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData.Ubication_Id);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData.Ubication_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetYear
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_tmp_max_recovery.Year%type
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN

    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData.Year);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData.Year);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetMonth
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_tmp_max_recovery.Month%type
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN

    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData.Month);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData.Month);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetRecovery_Value
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_tmp_max_recovery.Recovery_Value%type
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN

    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData.Recovery_Value);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData.Recovery_Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTotal_Sub_Recovery
  (
    inuTMP_MAX_RECOVERY_Id in LD_tmp_max_recovery.TMP_MAX_RECOVERY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_tmp_max_recovery.Total_Sub_Recovery%type
  IS
    rcError styLD_tmp_max_recovery;
  BEGIN

    rcError.TMP_MAX_RECOVERY_Id := inuTMP_MAX_RECOVERY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTMP_MAX_RECOVERY_Id
       )
    then
       return(rcData.Total_Sub_Recovery);
    end if;
    Load
    (
      inuTMP_MAX_RECOVERY_Id
    );
    return(rcData.Total_Sub_Recovery);
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
end DALD_tmp_max_recovery;
/
PROMPT Otorgando permisos de ejecucion a DALD_TMP_MAX_RECOVERY
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_TMP_MAX_RECOVERY', 'ADM_PERSON');
END;
/
