CREATE OR REPLACE PACKAGE adm_person.dald_causal
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  IS
    SELECT LD_causal.*,LD_causal.rowid
    FROM LD_causal
    WHERE
      CAUSAL_Id = inuCAUSAL_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_causal.*,LD_causal.rowid
    FROM LD_causal
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_causal  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_causal is table of styLD_causal index by binary_integer;
  type tyrfRecords is ref cursor return styLD_causal;

  /* Tipos referenciando al registro */
  type tytbCausal_Id is table of LD_causal.Causal_Id%type index by binary_integer;
  type tytbCausal_Type_Id is table of LD_causal.Causal_Type_Id%type index by binary_integer;
  type tytbAttributed_To is table of LD_causal.Attributed_To%type index by binary_integer;
  type tytbDescription is table of LD_causal.Description%type index by binary_integer;
  type tytbActive is table of LD_causal.Active%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_causal is record
  (

    Causal_Id   tytbCausal_Id,
    Causal_Type_Id   tytbCausal_Type_Id,
    Attributed_To   tytbAttributed_To,
    Description   tytbDescription,
    Active   tytbActive,
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
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  );

  PROCEDURE getRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    orcRecord out nocopy styLD_causal
  );

  FUNCTION frcGetRcData
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN styLD_causal;

  FUNCTION frcGetRcData
  RETURN styLD_causal;

  FUNCTION frcGetRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN styLD_causal;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_causal
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_causal in styLD_causal
  );

     PROCEDURE insRecord
  (
    ircLD_causal in styLD_causal,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_causal in out nocopy tytbLD_causal
  );

  PROCEDURE delRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_causal in out nocopy tytbLD_causal,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_causal in styLD_causal,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_causal in out nocopy tytbLD_causal,
    inuLock in number default 1
  );

    PROCEDURE updCausal_Type_Id
    (
        inuCAUSAL_Id   in LD_causal.CAUSAL_Id%type,
        inuCausal_Type_Id$  in LD_causal.Causal_Type_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updAttributed_To
    (
        inuCAUSAL_Id   in LD_causal.CAUSAL_Id%type,
        inuAttributed_To$  in LD_causal.Attributed_To%type,
        inuLock    in number default 0
      );

    PROCEDURE updDescription
    (
        inuCAUSAL_Id   in LD_causal.CAUSAL_Id%type,
        isbDescription$  in LD_causal.Description%type,
        inuLock    in number default 0
      );

    PROCEDURE updActive
    (
        inuCAUSAL_Id   in LD_causal.CAUSAL_Id%type,
        isbActive$  in LD_causal.Active%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCausal_Id
      (
          inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_causal.Causal_Id%type;

      FUNCTION fnuGetCausal_Type_Id
      (
          inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_causal.Causal_Type_Id%type;

      FUNCTION fnuGetAttributed_To
      (
          inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_causal.Attributed_To%type;

      FUNCTION fsbGetDescription
      (
          inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_causal.Description%type;

      FUNCTION fsbGetActive
      (
          inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_causal.Active%type;


  PROCEDURE LockByPk
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    orcLD_causal  out styLD_causal
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_causal  out styLD_causal
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_causal;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_causal
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CAUSAL';
    cnuGeEntityId constant varchar2(30) := 8644; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  IS
    SELECT LD_causal.*,LD_causal.rowid
    FROM LD_causal
    WHERE  CAUSAL_Id = inuCAUSAL_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_causal.*,LD_causal.rowid
    FROM LD_causal
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_causal is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_causal;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_causal default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.CAUSAL_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    orcLD_causal  out styLD_causal
  )
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id := inuCAUSAL_Id;

    Open cuLockRcByPk
    (
      inuCAUSAL_Id
    );

    fetch cuLockRcByPk into orcLD_causal;
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
    orcLD_causal  out styLD_causal
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_causal;
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
    itbLD_causal  in out nocopy tytbLD_causal
  )
  IS
  BEGIN
      rcRecOfTab.Causal_Id.delete;
      rcRecOfTab.Causal_Type_Id.delete;
      rcRecOfTab.Attributed_To.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.Active.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_causal  in out nocopy tytbLD_causal,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_causal);
    for n in itbLD_causal.first .. itbLD_causal.last loop
      rcRecOfTab.Causal_Id(n) := itbLD_causal(n).Causal_Id;
      rcRecOfTab.Causal_Type_Id(n) := itbLD_causal(n).Causal_Type_Id;
      rcRecOfTab.Attributed_To(n) := itbLD_causal(n).Attributed_To;
      rcRecOfTab.Description(n) := itbLD_causal(n).Description;
      rcRecOfTab.Active(n) := itbLD_causal(n).Active;
      rcRecOfTab.row_id(n) := itbLD_causal(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCAUSAL_Id
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
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCAUSAL_Id = rcData.CAUSAL_Id
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
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCAUSAL_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  IS
    rcError styLD_causal;
  BEGIN    rcError.CAUSAL_Id:=inuCAUSAL_Id;

    Load
    (
      inuCAUSAL_Id
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
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCAUSAL_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    orcRecord out nocopy styLD_causal
  )
  IS
    rcError styLD_causal;
  BEGIN    rcError.CAUSAL_Id:=inuCAUSAL_Id;

    Load
    (
      inuCAUSAL_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN styLD_causal
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id:=inuCAUSAL_Id;

    Load
    (
      inuCAUSAL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type
  )
  RETURN styLD_causal
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id:=inuCAUSAL_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCAUSAL_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCAUSAL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_causal
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_causal
  )
  IS
    rfLD_causal tyrfLD_causal;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_causal.Causal_Id,
                LD_causal.Causal_Type_Id,
                LD_causal.Attributed_To,
                LD_causal.Description,
                LD_causal.Active,
                LD_causal.rowid
                FROM LD_causal';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_causal for sbFullQuery;
    fetch rfLD_causal bulk collect INTO otbResult;
    close rfLD_causal;
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
                LD_causal.Causal_Id,
                LD_causal.Causal_Type_Id,
                LD_causal.Attributed_To,
                LD_causal.Description,
                LD_causal.Active,
                LD_causal.rowid
                FROM LD_causal';
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
    ircLD_causal in styLD_causal
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_causal,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_causal in styLD_causal,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_causal.CAUSAL_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|CAUSAL_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_causal
    (
      Causal_Id,
      Causal_Type_Id,
      Attributed_To,
      Description,
      Active
    )
    values
    (
      ircLD_causal.Causal_Id,
      ircLD_causal.Causal_Type_Id,
      ircLD_causal.Attributed_To,
      ircLD_causal.Description,
      ircLD_causal.Active
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_causal));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_causal in out nocopy tytbLD_causal
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_causal, blUseRowID);
    forall n in iotbLD_causal.first..iotbLD_causal.last
      insert into LD_causal
      (
      Causal_Id,
      Causal_Type_Id,
      Attributed_To,
      Description,
      Active
    )
    values
    (
      rcRecOfTab.Causal_Id(n),
      rcRecOfTab.Causal_Type_Id(n),
      rcRecOfTab.Attributed_To(n),
      rcRecOfTab.Description(n),
      rcRecOfTab.Active(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id:=inuCAUSAL_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCAUSAL_Id,
        rcData
      );
    end if;

    delete
    from LD_causal
    where
           CAUSAL_Id=inuCAUSAL_Id;
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
    rcError  styLD_causal;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_causal
    where
      rowid = iriRowID
    returning
   CAUSAL_Id
    into
      rcError.CAUSAL_Id;

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
    iotbLD_causal in out nocopy tytbLD_causal,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_causal;
  BEGIN
    FillRecordOfTables(iotbLD_causal, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_causal.first .. iotbLD_causal.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_causal.first .. iotbLD_causal.last
        delete
        from LD_causal
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_causal.first .. iotbLD_causal.last loop
          LockByPk
          (
              rcRecOfTab.CAUSAL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_causal.first .. iotbLD_causal.last
        delete
        from LD_causal
        where
               CAUSAL_Id = rcRecOfTab.CAUSAL_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_causal in styLD_causal,
    inuLock    in number default 0
  )
  IS
    nuCAUSAL_Id LD_causal.CAUSAL_Id%type;

  BEGIN
    if ircLD_causal.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_causal.rowid,rcData);
      end if;
      update LD_causal
      set

        Causal_Type_Id = ircLD_causal.Causal_Type_Id,
        Attributed_To = ircLD_causal.Attributed_To,
        Description = ircLD_causal.Description,
        Active = ircLD_causal.Active
      where
        rowid = ircLD_causal.rowid
      returning
    CAUSAL_Id
      into
        nuCAUSAL_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_causal.CAUSAL_Id,
          rcData
        );
      end if;

      update LD_causal
      set
        Causal_Type_Id = ircLD_causal.Causal_Type_Id,
        Attributed_To = ircLD_causal.Attributed_To,
        Description = ircLD_causal.Description,
        Active = ircLD_causal.Active
      where
             CAUSAL_Id = ircLD_causal.CAUSAL_Id
      returning
    CAUSAL_Id
      into
        nuCAUSAL_Id;
    end if;

    if
      nuCAUSAL_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_causal));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_causal in out nocopy tytbLD_causal,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_causal;
  BEGIN
    FillRecordOfTables(iotbLD_causal,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_causal.first .. iotbLD_causal.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_causal.first .. iotbLD_causal.last
        update LD_causal
        set

            Causal_Type_Id = rcRecOfTab.Causal_Type_Id(n),
            Attributed_To = rcRecOfTab.Attributed_To(n),
            Description = rcRecOfTab.Description(n),
            Active = rcRecOfTab.Active(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_causal.first .. iotbLD_causal.last loop
          LockByPk
          (
              rcRecOfTab.CAUSAL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_causal.first .. iotbLD_causal.last
        update LD_causal
        set
          Causal_Type_Id = rcRecOfTab.Causal_Type_Id(n),
          Attributed_To = rcRecOfTab.Attributed_To(n),
          Description = rcRecOfTab.Description(n),
          Active = rcRecOfTab.Active(n)
          where
          CAUSAL_Id = rcRecOfTab.CAUSAL_Id(n)
;
    end if;
  END;

  PROCEDURE updCausal_Type_Id
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuCausal_Type_Id$ in LD_causal.Causal_Type_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id := inuCAUSAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCAUSAL_Id,
        rcData
      );
    end if;

    update LD_causal
    set
      Causal_Type_Id = inuCausal_Type_Id$
    where
      CAUSAL_Id = inuCAUSAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Causal_Type_Id:= inuCausal_Type_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAttributed_To
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuAttributed_To$ in LD_causal.Attributed_To%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id := inuCAUSAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCAUSAL_Id,
        rcData
      );
    end if;

    update LD_causal
    set
      Attributed_To = inuAttributed_To$
    where
      CAUSAL_Id = inuCAUSAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Attributed_To:= inuAttributed_To$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDescription
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    isbDescription$ in LD_causal.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id := inuCAUSAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCAUSAL_Id,
        rcData
      );
    end if;

    update LD_causal
    set
      Description = isbDescription$
    where
      CAUSAL_Id = inuCAUSAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updActive
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    isbActive$ in LD_causal.Active%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_causal;
  BEGIN
    rcError.CAUSAL_Id := inuCAUSAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCAUSAL_Id,
        rcData
      );
    end if;

    update LD_causal
    set
      Active = isbActive$
    where
      CAUSAL_Id = inuCAUSAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Active:= isbActive$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCausal_Id
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_causal.Causal_Id%type
  IS
    rcError styLD_causal;
  BEGIN

    rcError.CAUSAL_Id := inuCAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCAUSAL_Id
       )
    then
       return(rcData.Causal_Id);
    end if;
    Load
    (
      inuCAUSAL_Id
    );
    return(rcData.Causal_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetCausal_Type_Id
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_causal.Causal_Type_Id%type
  IS
    rcError styLD_causal;
  BEGIN

    rcError.CAUSAL_Id := inuCAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCAUSAL_Id
       )
    then
       return(rcData.Causal_Type_Id);
    end if;
    Load
    (
      inuCAUSAL_Id
    );
    return(rcData.Causal_Type_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAttributed_To
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_causal.Attributed_To%type
  IS
    rcError styLD_causal;
  BEGIN

    rcError.CAUSAL_Id := inuCAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCAUSAL_Id
       )
    then
       return(rcData.Attributed_To);
    end if;
    Load
    (
      inuCAUSAL_Id
    );
    return(rcData.Attributed_To);
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
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_causal.Description%type
  IS
    rcError styLD_causal;
  BEGIN

    rcError.CAUSAL_Id:=inuCAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCAUSAL_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuCAUSAL_Id
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

  FUNCTION fsbGetActive
  (
    inuCAUSAL_Id in LD_causal.CAUSAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_causal.Active%type
  IS
    rcError styLD_causal;
  BEGIN

    rcError.CAUSAL_Id:=inuCAUSAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCAUSAL_Id
       )
    then
       return(rcData.Active);
    end if;
    Load
    (
      inuCAUSAL_Id
    );
    return(rcData.Active);
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
end DALD_causal;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CAUSAL
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CAUSAL', 'ADM_PERSON'); 
END;
/
