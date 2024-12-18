CREATE OR REPLACE PACKAGE adm_person.dald_subsidy_detail
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  IS
    SELECT LD_subsidy_detail.*,LD_subsidy_detail.rowid
    FROM LD_subsidy_detail
    WHERE
      SUBSIDY_DETAIL_Id = inuSUBSIDY_DETAIL_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy_detail.*,LD_subsidy_detail.rowid
    FROM LD_subsidy_detail
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_subsidy_detail  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_subsidy_detail is table of styLD_subsidy_detail index by binary_integer;
  type tyrfRecords is ref cursor return styLD_subsidy_detail;

  /* Tipos referenciando al registro */
  type tytbSubsidy_Detail_Id is table of LD_subsidy_detail.Subsidy_Detail_Id%type index by binary_integer;
  type tytbConccodi is table of LD_subsidy_detail.Conccodi%type index by binary_integer;
  type tytbSubsidy_Percentage is table of LD_subsidy_detail.Subsidy_Percentage%type index by binary_integer;
  type tytbSubsidy_Value is table of LD_subsidy_detail.Subsidy_Value%type index by binary_integer;
  type tytbUbication_Id is table of LD_subsidy_detail.Ubication_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_subsidy_detail is record
  (

    Subsidy_Detail_Id   tytbSubsidy_Detail_Id,
    Conccodi   tytbConccodi,
    Subsidy_Percentage   tytbSubsidy_Percentage,
    Subsidy_Value   tytbSubsidy_Value,
    Ubication_Id   tytbUbication_Id,
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
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  );

  PROCEDURE getRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    orcRecord out nocopy styLD_subsidy_detail
  );

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN styLD_subsidy_detail;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy_detail;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN styLD_subsidy_detail;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy_detail
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_subsidy_detail in styLD_subsidy_detail
  );

     PROCEDURE insRecord
  (
    ircLD_subsidy_detail in styLD_subsidy_detail,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_subsidy_detail in out nocopy tytbLD_subsidy_detail
  );

  PROCEDURE delRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_subsidy_detail in out nocopy tytbLD_subsidy_detail,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_subsidy_detail in styLD_subsidy_detail,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_subsidy_detail in out nocopy tytbLD_subsidy_detail,
    inuLock in number default 1
  );

    PROCEDURE updConccodi
    (
        inuSUBSIDY_DETAIL_Id   in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
        inuConccodi$  in LD_subsidy_detail.Conccodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Percentage
    (
        inuSUBSIDY_DETAIL_Id   in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
        inuSubsidy_Percentage$  in LD_subsidy_detail.Subsidy_Percentage%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Value
    (
        inuSUBSIDY_DETAIL_Id   in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
        inuSubsidy_Value$  in LD_subsidy_detail.Subsidy_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updUbication_Id
    (
        inuSUBSIDY_DETAIL_Id   in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
        inuUbication_Id$  in LD_subsidy_detail.Ubication_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetSubsidy_Detail_Id
      (
          inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_detail.Subsidy_Detail_Id%type;

      FUNCTION fnuGetConccodi
      (
          inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_detail.Conccodi%type;

      FUNCTION fnuGetSubsidy_Percentage
      (
          inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_detail.Subsidy_Percentage%type;

      FUNCTION fnuGetSubsidy_Value
      (
          inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_detail.Subsidy_Value%type;

      FUNCTION fnuGetUbication_Id
      (
          inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_detail.Ubication_Id%type;


  PROCEDURE LockByPk
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    orcLD_subsidy_detail  out styLD_subsidy_detail
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_subsidy_detail  out styLD_subsidy_detail
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_subsidy_detail;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_subsidy_detail
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUBSIDY_DETAIL';
    cnuGeEntityId constant varchar2(30) := 8688; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  IS
    SELECT LD_subsidy_detail.*,LD_subsidy_detail.rowid
    FROM LD_subsidy_detail
    WHERE  SUBSIDY_DETAIL_Id = inuSUBSIDY_DETAIL_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy_detail.*,LD_subsidy_detail.rowid
    FROM LD_subsidy_detail
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_subsidy_detail is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_subsidy_detail;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_subsidy_detail default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUBSIDY_DETAIL_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    orcLD_subsidy_detail  out styLD_subsidy_detail
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;

    Open cuLockRcByPk
    (
      inuSUBSIDY_DETAIL_Id
    );

    fetch cuLockRcByPk into orcLD_subsidy_detail;
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
    orcLD_subsidy_detail  out styLD_subsidy_detail
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_subsidy_detail;
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
    itbLD_subsidy_detail  in out nocopy tytbLD_subsidy_detail
  )
  IS
  BEGIN
      rcRecOfTab.Subsidy_Detail_Id.delete;
      rcRecOfTab.Conccodi.delete;
      rcRecOfTab.Subsidy_Percentage.delete;
      rcRecOfTab.Subsidy_Value.delete;
      rcRecOfTab.Ubication_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_subsidy_detail  in out nocopy tytbLD_subsidy_detail,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_subsidy_detail);
    for n in itbLD_subsidy_detail.first .. itbLD_subsidy_detail.last loop
      rcRecOfTab.Subsidy_Detail_Id(n) := itbLD_subsidy_detail(n).Subsidy_Detail_Id;
      rcRecOfTab.Conccodi(n) := itbLD_subsidy_detail(n).Conccodi;
      rcRecOfTab.Subsidy_Percentage(n) := itbLD_subsidy_detail(n).Subsidy_Percentage;
      rcRecOfTab.Subsidy_Value(n) := itbLD_subsidy_detail(n).Subsidy_Value;
      rcRecOfTab.Ubication_Id(n) := itbLD_subsidy_detail(n).Ubication_Id;
      rcRecOfTab.row_id(n) := itbLD_subsidy_detail(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUBSIDY_DETAIL_Id
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
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUBSIDY_DETAIL_Id = rcData.SUBSIDY_DETAIL_Id
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
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN    rcError.SUBSIDY_DETAIL_Id:=inuSUBSIDY_DETAIL_Id;

    Load
    (
      inuSUBSIDY_DETAIL_Id
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
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    orcRecord out nocopy styLD_subsidy_detail
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN    rcError.SUBSIDY_DETAIL_Id:=inuSUBSIDY_DETAIL_Id;

    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN styLD_subsidy_detail
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id:=inuSUBSIDY_DETAIL_Id;

    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type
  )
  RETURN styLD_subsidy_detail
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id:=inuSUBSIDY_DETAIL_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_DETAIL_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy_detail
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy_detail
  )
  IS
    rfLD_subsidy_detail tyrfLD_subsidy_detail;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_subsidy_detail.Subsidy_Detail_Id,
                LD_subsidy_detail.Conccodi,
                LD_subsidy_detail.Subsidy_Percentage,
                LD_subsidy_detail.Subsidy_Value,
                LD_subsidy_detail.Ubication_Id,
                LD_subsidy_detail.rowid
                FROM LD_subsidy_detail';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_subsidy_detail for sbFullQuery;
    fetch rfLD_subsidy_detail bulk collect INTO otbResult;
    close rfLD_subsidy_detail;
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
                LD_subsidy_detail.Subsidy_Detail_Id,
                LD_subsidy_detail.Conccodi,
                LD_subsidy_detail.Subsidy_Percentage,
                LD_subsidy_detail.Subsidy_Value,
                LD_subsidy_detail.Ubication_Id,
                LD_subsidy_detail.rowid
                FROM LD_subsidy_detail';
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
    ircLD_subsidy_detail in styLD_subsidy_detail
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_subsidy_detail,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_subsidy_detail in styLD_subsidy_detail,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_subsidy_detail.SUBSIDY_DETAIL_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUBSIDY_DETAIL_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_subsidy_detail
    (
      Subsidy_Detail_Id,
      Conccodi,
      Subsidy_Percentage,
      Subsidy_Value,
      Ubication_Id
    )
    values
    (
      ircLD_subsidy_detail.Subsidy_Detail_Id,
      ircLD_subsidy_detail.Conccodi,
      ircLD_subsidy_detail.Subsidy_Percentage,
      ircLD_subsidy_detail.Subsidy_Value,
      ircLD_subsidy_detail.Ubication_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_subsidy_detail));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_subsidy_detail in out nocopy tytbLD_subsidy_detail
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_detail, blUseRowID);
    forall n in iotbLD_subsidy_detail.first..iotbLD_subsidy_detail.last
      insert into LD_subsidy_detail
      (
      Subsidy_Detail_Id,
      Conccodi,
      Subsidy_Percentage,
      Subsidy_Value,
      Ubication_Id
    )
    values
    (
      rcRecOfTab.Subsidy_Detail_Id(n),
      rcRecOfTab.Conccodi(n),
      rcRecOfTab.Subsidy_Percentage(n),
      rcRecOfTab.Subsidy_Value(n),
      rcRecOfTab.Ubication_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id:=inuSUBSIDY_DETAIL_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_DETAIL_Id,
        rcData
      );
    end if;

    delete
    from LD_subsidy_detail
    where
           SUBSIDY_DETAIL_Id=inuSUBSIDY_DETAIL_Id;
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
    rcError  styLD_subsidy_detail;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_subsidy_detail
    where
      rowid = iriRowID
    returning
   SUBSIDY_DETAIL_Id
    into
      rcError.SUBSIDY_DETAIL_Id;

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
    iotbLD_subsidy_detail in out nocopy tytbLD_subsidy_detail,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy_detail;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_detail, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last
        delete
        from LD_subsidy_detail
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_DETAIL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last
        delete
        from LD_subsidy_detail
        where
               SUBSIDY_DETAIL_Id = rcRecOfTab.SUBSIDY_DETAIL_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_subsidy_detail in styLD_subsidy_detail,
    inuLock    in number default 0
  )
  IS
    nuSUBSIDY_DETAIL_Id LD_subsidy_detail.SUBSIDY_DETAIL_Id%type;

  BEGIN
    if ircLD_subsidy_detail.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_subsidy_detail.rowid,rcData);
      end if;
      update LD_subsidy_detail
      set

        Conccodi = ircLD_subsidy_detail.Conccodi,
        Subsidy_Percentage = ircLD_subsidy_detail.Subsidy_Percentage,
        Subsidy_Value = ircLD_subsidy_detail.Subsidy_Value,
        Ubication_Id = ircLD_subsidy_detail.Ubication_Id
      where
        rowid = ircLD_subsidy_detail.rowid
      returning
    SUBSIDY_DETAIL_Id
      into
        nuSUBSIDY_DETAIL_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_subsidy_detail.SUBSIDY_DETAIL_Id,
          rcData
        );
      end if;

      update LD_subsidy_detail
      set
        Conccodi = ircLD_subsidy_detail.Conccodi,
        Subsidy_Percentage = ircLD_subsidy_detail.Subsidy_Percentage,
        Subsidy_Value = ircLD_subsidy_detail.Subsidy_Value,
        Ubication_Id = ircLD_subsidy_detail.Ubication_Id
      where
             SUBSIDY_DETAIL_Id = ircLD_subsidy_detail.SUBSIDY_DETAIL_Id
      returning
    SUBSIDY_DETAIL_Id
      into
        nuSUBSIDY_DETAIL_Id;
    end if;

    if
      nuSUBSIDY_DETAIL_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_subsidy_detail));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_subsidy_detail in out nocopy tytbLD_subsidy_detail,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy_detail;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_detail,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last
        update LD_subsidy_detail
        set

            Conccodi = rcRecOfTab.Conccodi(n),
            Subsidy_Percentage = rcRecOfTab.Subsidy_Percentage(n),
            Subsidy_Value = rcRecOfTab.Subsidy_Value(n),
            Ubication_Id = rcRecOfTab.Ubication_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_DETAIL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_detail.first .. iotbLD_subsidy_detail.last
        update LD_subsidy_detail
        set
          Conccodi = rcRecOfTab.Conccodi(n),
          Subsidy_Percentage = rcRecOfTab.Subsidy_Percentage(n),
          Subsidy_Value = rcRecOfTab.Subsidy_Value(n),
          Ubication_Id = rcRecOfTab.Ubication_Id(n)
          where
          SUBSIDY_DETAIL_Id = rcRecOfTab.SUBSIDY_DETAIL_Id(n)
;
    end if;
  END;

  PROCEDURE updConccodi
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuConccodi$ in LD_subsidy_detail.Conccodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_DETAIL_Id,
        rcData
      );
    end if;

    update LD_subsidy_detail
    set
      Conccodi = inuConccodi$
    where
      SUBSIDY_DETAIL_Id = inuSUBSIDY_DETAIL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Conccodi:= inuConccodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Percentage
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuSubsidy_Percentage$ in LD_subsidy_detail.Subsidy_Percentage%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_DETAIL_Id,
        rcData
      );
    end if;

    update LD_subsidy_detail
    set
      Subsidy_Percentage = inuSubsidy_Percentage$
    where
      SUBSIDY_DETAIL_Id = inuSUBSIDY_DETAIL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Percentage:= inuSubsidy_Percentage$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Value
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuSubsidy_Value$ in LD_subsidy_detail.Subsidy_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_DETAIL_Id,
        rcData
      );
    end if;

    update LD_subsidy_detail
    set
      Subsidy_Value = inuSubsidy_Value$
    where
      SUBSIDY_DETAIL_Id = inuSUBSIDY_DETAIL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Value:= inuSubsidy_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updUbication_Id
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuUbication_Id$ in LD_subsidy_detail.Ubication_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_detail;
  BEGIN
    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_DETAIL_Id,
        rcData
      );
    end if;

    update LD_subsidy_detail
    set
      Ubication_Id = inuUbication_Id$
    where
      SUBSIDY_DETAIL_Id = inuSUBSIDY_DETAIL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ubication_Id:= inuUbication_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSubsidy_Detail_Id
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_detail.Subsidy_Detail_Id%type
  IS
    rcError styLD_subsidy_detail;
  BEGIN

    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_DETAIL_Id
       )
    then
       return(rcData.Subsidy_Detail_Id);
    end if;
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(rcData.Subsidy_Detail_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetConccodi
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_detail.Conccodi%type
  IS
    rcError styLD_subsidy_detail;
  BEGIN

    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_DETAIL_Id
       )
    then
       return(rcData.Conccodi);
    end if;
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(rcData.Conccodi);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSubsidy_Percentage
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_detail.Subsidy_Percentage%type
  IS
    rcError styLD_subsidy_detail;
  BEGIN

    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_DETAIL_Id
       )
    then
       return(rcData.Subsidy_Percentage);
    end if;
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(rcData.Subsidy_Percentage);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSubsidy_Value
  (
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_detail.Subsidy_Value%type
  IS
    rcError styLD_subsidy_detail;
  BEGIN

    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_DETAIL_Id
       )
    then
       return(rcData.Subsidy_Value);
    end if;
    Load
    (
      inuSUBSIDY_DETAIL_Id
    );
    return(rcData.Subsidy_Value);
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
    inuSUBSIDY_DETAIL_Id in LD_subsidy_detail.SUBSIDY_DETAIL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_detail.Ubication_Id%type
  IS
    rcError styLD_subsidy_detail;
  BEGIN

    rcError.SUBSIDY_DETAIL_Id := inuSUBSIDY_DETAIL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_DETAIL_Id
       )
    then
       return(rcData.Ubication_Id);
    end if;
    Load
    (
      inuSUBSIDY_DETAIL_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_subsidy_detail;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_SUBSIDY_DETAIL
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_SUBSIDY_DETAIL', 'ADM_PERSON'); 
END;
/ 

