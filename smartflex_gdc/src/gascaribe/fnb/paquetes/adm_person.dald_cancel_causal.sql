CREATE OR REPLACE PACKAGE adm_person.dald_cancel_causal
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  IS
    SELECT LD_cancel_causal.*,LD_cancel_causal.rowid
    FROM LD_cancel_causal
    WHERE
      CANCEL_CAUSAL_Id = inuCANCEL_CAUSAL_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_cancel_causal.*,LD_cancel_causal.rowid
    FROM LD_cancel_causal
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_cancel_causal  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_cancel_causal is table of styLD_cancel_causal index by binary_integer;
  type tyrfRecords is ref cursor return styLD_cancel_causal;

  /* Tipos referenciando al registro */
  type tytbCancel_Causal_Id is table of LD_cancel_causal.Cancel_Causal_Id%type index by binary_integer;
  type tytbDescription is table of LD_cancel_causal.Description%type index by binary_integer;
  type tytbLiquidation_Type_Id is table of LD_cancel_causal.Liquidation_Type_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_cancel_causal is record
  (

    Cancel_Causal_Id   tytbCancel_Causal_Id,
    Description   tytbDescription,
    Liquidation_Type_Id   tytbLiquidation_Type_Id,
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
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  );

  PROCEDURE getRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    orcRecord out nocopy styLD_cancel_causal
  );

  FUNCTION frcGetRcData
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN styLD_cancel_causal;

  FUNCTION frcGetRcData
  RETURN styLD_cancel_causal;

  FUNCTION frcGetRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN styLD_cancel_causal;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_cancel_causal
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_cancel_causal in styLD_cancel_causal
  );

     PROCEDURE insRecord
  (
    ircLD_cancel_causal in styLD_cancel_causal,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_cancel_causal in out nocopy tytbLD_cancel_causal
  );

  PROCEDURE delRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_cancel_causal in out nocopy tytbLD_cancel_causal,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_cancel_causal in styLD_cancel_causal,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_cancel_causal in out nocopy tytbLD_cancel_causal,
    inuLock in number default 1
  );

    PROCEDURE updDescription
    (
        inuCANCEL_CAUSAL_Id   in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
        isbDescription$  in LD_cancel_causal.Description%type,
        inuLock    in number default 0
      );

    PROCEDURE updLiquidation_Type_Id
    (
        inuCANCEL_CAUSAL_Id   in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
        inuLiquidation_Type_Id$  in LD_cancel_causal.Liquidation_Type_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCancel_Causal_Id
      (
          inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cancel_causal.Cancel_Causal_Id%type;

      FUNCTION fsbGetDescription
      (
          inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cancel_causal.Description%type;

      FUNCTION fnuGetLiquidation_Type_Id
      (
          inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cancel_causal.Liquidation_Type_Id%type;


  PROCEDURE LockByPk
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    orcLD_cancel_causal  out styLD_cancel_causal
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_cancel_causal  out styLD_cancel_causal
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_cancel_causal;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_cancel_causal
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO147879';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CANCEL_CAUSAL';
    cnuGeEntityId constant varchar2(30) := 8148; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  IS
    SELECT LD_cancel_causal.*,LD_cancel_causal.rowid
    FROM LD_cancel_causal
    WHERE  CANCEL_CAUSAL_Id = inuCANCEL_CAUSAL_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_cancel_causal.*,LD_cancel_causal.rowid
    FROM LD_cancel_causal
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_cancel_causal is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_cancel_causal;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_cancel_causal default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.CANCEL_CAUSAL_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    orcLD_cancel_causal  out styLD_cancel_causal
  )
  IS
    rcError styLD_cancel_causal;
  BEGIN
    rcError.CANCEL_CAUSAL_Id := inuCANCEL_CAUSAL_Id;

    Open cuLockRcByPk
    (
      inuCANCEL_CAUSAL_Id
    );

    fetch cuLockRcByPk into orcLD_cancel_causal;
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
    orcLD_cancel_causal  out styLD_cancel_causal
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_cancel_causal;
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
    itbLD_cancel_causal  in out nocopy tytbLD_cancel_causal
  )
  IS
  BEGIN
      rcRecOfTab.Cancel_Causal_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.Liquidation_Type_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_cancel_causal  in out nocopy tytbLD_cancel_causal,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_cancel_causal);
    for n in itbLD_cancel_causal.first .. itbLD_cancel_causal.last loop
      rcRecOfTab.Cancel_Causal_Id(n) := itbLD_cancel_causal(n).Cancel_Causal_Id;
      rcRecOfTab.Description(n) := itbLD_cancel_causal(n).Description;
      rcRecOfTab.Liquidation_Type_Id(n) := itbLD_cancel_causal(n).Liquidation_Type_Id;
      rcRecOfTab.row_id(n) := itbLD_cancel_causal(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCANCEL_CAUSAL_Id
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
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCANCEL_CAUSAL_Id = rcData.CANCEL_CAUSAL_Id
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
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  IS
    rcError styLD_cancel_causal;
  BEGIN    rcError.CANCEL_CAUSAL_Id:=inuCANCEL_CAUSAL_Id;

    Load
    (
      inuCANCEL_CAUSAL_Id
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
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    orcRecord out nocopy styLD_cancel_causal
  )
  IS
    rcError styLD_cancel_causal;
  BEGIN    rcError.CANCEL_CAUSAL_Id:=inuCANCEL_CAUSAL_Id;

    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN styLD_cancel_causal
  IS
    rcError styLD_cancel_causal;
  BEGIN
    rcError.CANCEL_CAUSAL_Id:=inuCANCEL_CAUSAL_Id;

    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type
  )
  RETURN styLD_cancel_causal
  IS
    rcError styLD_cancel_causal;
  BEGIN
    rcError.CANCEL_CAUSAL_Id:=inuCANCEL_CAUSAL_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCANCEL_CAUSAL_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_cancel_causal
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_cancel_causal
  )
  IS
    rfLD_cancel_causal tyrfLD_cancel_causal;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_cancel_causal.Cancel_Causal_Id,
                LD_cancel_causal.Description,
                LD_cancel_causal.Liquidation_Type_Id,
                LD_cancel_causal.rowid
                FROM LD_cancel_causal';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_cancel_causal for sbFullQuery;
    fetch rfLD_cancel_causal bulk collect INTO otbResult;
    close rfLD_cancel_causal;
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
                LD_cancel_causal.Cancel_Causal_Id,
                LD_cancel_causal.Description,
                LD_cancel_causal.Liquidation_Type_Id,
                LD_cancel_causal.rowid
                FROM LD_cancel_causal';
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
    ircLD_cancel_causal in styLD_cancel_causal
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_cancel_causal,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_cancel_causal in styLD_cancel_causal,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_cancel_causal.CANCEL_CAUSAL_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|CANCEL_CAUSAL_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_cancel_causal
    (
      Cancel_Causal_Id,
      Description,
      Liquidation_Type_Id
    )
    values
    (
      ircLD_cancel_causal.Cancel_Causal_Id,
      ircLD_cancel_causal.Description,
      ircLD_cancel_causal.Liquidation_Type_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_cancel_causal));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_cancel_causal in out nocopy tytbLD_cancel_causal
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_cancel_causal, blUseRowID);
    forall n in iotbLD_cancel_causal.first..iotbLD_cancel_causal.last
      insert into LD_cancel_causal
      (
      Cancel_Causal_Id,
      Description,
      Liquidation_Type_Id
    )
    values
    (
      rcRecOfTab.Cancel_Causal_Id(n),
      rcRecOfTab.Description(n),
      rcRecOfTab.Liquidation_Type_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_cancel_causal;
  BEGIN
    rcError.CANCEL_CAUSAL_Id:=inuCANCEL_CAUSAL_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCANCEL_CAUSAL_Id,
        rcData
      );
    end if;

    delete
    from LD_cancel_causal
    where
           CANCEL_CAUSAL_Id=inuCANCEL_CAUSAL_Id;
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
    rcError  styLD_cancel_causal;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_cancel_causal
    where
      rowid = iriRowID
    returning
   CANCEL_CAUSAL_Id
    into
      rcError.CANCEL_CAUSAL_Id;

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
    iotbLD_cancel_causal in out nocopy tytbLD_cancel_causal,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_cancel_causal;
  BEGIN
    FillRecordOfTables(iotbLD_cancel_causal, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last
        delete
        from LD_cancel_causal
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last loop
          LockByPk
          (
              rcRecOfTab.CANCEL_CAUSAL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last
        delete
        from LD_cancel_causal
        where
               CANCEL_CAUSAL_Id = rcRecOfTab.CANCEL_CAUSAL_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_cancel_causal in styLD_cancel_causal,
    inuLock    in number default 0
  )
  IS
    nuCANCEL_CAUSAL_Id LD_cancel_causal.CANCEL_CAUSAL_Id%type;

  BEGIN
    if ircLD_cancel_causal.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_cancel_causal.rowid,rcData);
      end if;
      update LD_cancel_causal
      set

        Description = ircLD_cancel_causal.Description,
        Liquidation_Type_Id = ircLD_cancel_causal.Liquidation_Type_Id
      where
        rowid = ircLD_cancel_causal.rowid
      returning
    CANCEL_CAUSAL_Id
      into
        nuCANCEL_CAUSAL_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_cancel_causal.CANCEL_CAUSAL_Id,
          rcData
        );
      end if;

      update LD_cancel_causal
      set
        Description = ircLD_cancel_causal.Description,
        Liquidation_Type_Id = ircLD_cancel_causal.Liquidation_Type_Id
      where
             CANCEL_CAUSAL_Id = ircLD_cancel_causal.CANCEL_CAUSAL_Id
      returning
    CANCEL_CAUSAL_Id
      into
        nuCANCEL_CAUSAL_Id;
    end if;

    if
      nuCANCEL_CAUSAL_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_cancel_causal));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_cancel_causal in out nocopy tytbLD_cancel_causal,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_cancel_causal;
  BEGIN
    FillRecordOfTables(iotbLD_cancel_causal,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last
        update LD_cancel_causal
        set

            Description = rcRecOfTab.Description(n),
            Liquidation_Type_Id = rcRecOfTab.Liquidation_Type_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last loop
          LockByPk
          (
              rcRecOfTab.CANCEL_CAUSAL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cancel_causal.first .. iotbLD_cancel_causal.last
        update LD_cancel_causal
        set
          Description = rcRecOfTab.Description(n),
          Liquidation_Type_Id = rcRecOfTab.Liquidation_Type_Id(n)
          where
          CANCEL_CAUSAL_Id = rcRecOfTab.CANCEL_CAUSAL_Id(n)
;
    end if;
  END;

  PROCEDURE updDescription
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    isbDescription$ in LD_cancel_causal.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cancel_causal;
  BEGIN
    rcError.CANCEL_CAUSAL_Id := inuCANCEL_CAUSAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCANCEL_CAUSAL_Id,
        rcData
      );
    end if;

    update LD_cancel_causal
    set
      Description = isbDescription$
    where
      CANCEL_CAUSAL_Id = inuCANCEL_CAUSAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updLiquidation_Type_Id
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    inuLiquidation_Type_Id$ in LD_cancel_causal.Liquidation_Type_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cancel_causal;
  BEGIN
    rcError.CANCEL_CAUSAL_Id := inuCANCEL_CAUSAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCANCEL_CAUSAL_Id,
        rcData
      );
    end if;

    update LD_cancel_causal
    set
      Liquidation_Type_Id = inuLiquidation_Type_Id$
    where
      CANCEL_CAUSAL_Id = inuCANCEL_CAUSAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Liquidation_Type_Id:= inuLiquidation_Type_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCancel_Causal_Id
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cancel_causal.Cancel_Causal_Id%type
  IS
    rcError styLD_cancel_causal;
  BEGIN

    rcError.CANCEL_CAUSAL_Id := inuCANCEL_CAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCANCEL_CAUSAL_Id
       )
    then
       return(rcData.Cancel_Causal_Id);
    end if;
    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    return(rcData.Cancel_Causal_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetDescription
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cancel_causal.Description%type
  IS
    rcError styLD_cancel_causal;
  BEGIN

    rcError.CANCEL_CAUSAL_Id:=inuCANCEL_CAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCANCEL_CAUSAL_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    return(rcData.Description);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetLiquidation_Type_Id
  (
    inuCANCEL_CAUSAL_Id in LD_cancel_causal.CANCEL_CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cancel_causal.Liquidation_Type_Id%type
  IS
    rcError styLD_cancel_causal;
  BEGIN

    rcError.CANCEL_CAUSAL_Id := inuCANCEL_CAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCANCEL_CAUSAL_Id
       )
    then
       return(rcData.Liquidation_Type_Id);
    end if;
    Load
    (
      inuCANCEL_CAUSAL_Id
    );
    return(rcData.Liquidation_Type_Id);
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
end DALD_cancel_causal;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CANCEL_CAUSAL
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CANCEL_CAUSAL', 'ADM_PERSON'); 
END;
/  
