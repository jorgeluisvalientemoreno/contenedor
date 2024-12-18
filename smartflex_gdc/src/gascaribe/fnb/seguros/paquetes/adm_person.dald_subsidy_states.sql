CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_subsidy_states
is
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  IS
    SELECT LD_subsidy_states.*,LD_subsidy_states.rowid
    FROM LD_subsidy_states
    WHERE
      SUBSIDY_STATES_Id = inuSUBSIDY_STATES_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy_states.*,LD_subsidy_states.rowid
    FROM LD_subsidy_states
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_subsidy_states  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_subsidy_states is table of styLD_subsidy_states index by binary_integer;
  type tyrfRecords is ref cursor return styLD_subsidy_states;

  /* Tipos referenciando al registro */
  type tytbSubsidy_States_Id is table of LD_subsidy_states.Subsidy_States_Id%type index by binary_integer;
  type tytbDescription is table of LD_subsidy_states.Description%type index by binary_integer;
  type tytbActivate is table of LD_subsidy_states.Activate%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_subsidy_states is record
  (

    Subsidy_States_Id   tytbSubsidy_States_Id,
    Description   tytbDescription,
    Activate   tytbActivate,
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
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  );

  PROCEDURE getRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    orcRecord out nocopy styLD_subsidy_states
  );

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN styLD_subsidy_states;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy_states;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN styLD_subsidy_states;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy_states
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_subsidy_states in styLD_subsidy_states
  );

     PROCEDURE insRecord
  (
    ircLD_subsidy_states in styLD_subsidy_states,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_subsidy_states in out nocopy tytbLD_subsidy_states
  );

  PROCEDURE delRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_subsidy_states in out nocopy tytbLD_subsidy_states,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_subsidy_states in styLD_subsidy_states,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_subsidy_states in out nocopy tytbLD_subsidy_states,
    inuLock in number default 1
  );

    PROCEDURE updDescription
    (
        inuSUBSIDY_STATES_Id   in LD_subsidy_states.SUBSIDY_STATES_Id%type,
        isbDescription$  in LD_subsidy_states.Description%type,
        inuLock    in number default 0
      );

    PROCEDURE updActivate
    (
        inuSUBSIDY_STATES_Id   in LD_subsidy_states.SUBSIDY_STATES_Id%type,
        isbActivate$  in LD_subsidy_states.Activate%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetSubsidy_States_Id
      (
          inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_states.Subsidy_States_Id%type;

      FUNCTION fsbGetDescription
      (
          inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_states.Description%type;

      FUNCTION fsbGetActivate
      (
          inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_states.Activate%type;


  PROCEDURE LockByPk
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    orcLD_subsidy_states  out styLD_subsidy_states
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_subsidy_states  out styLD_subsidy_states
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_subsidy_states;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_subsidy_states
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUBSIDY_STATES';
    cnuGeEntityId constant varchar2(30) := 8638; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  IS
    SELECT LD_subsidy_states.*,LD_subsidy_states.rowid
    FROM LD_subsidy_states
    WHERE  SUBSIDY_STATES_Id = inuSUBSIDY_STATES_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy_states.*,LD_subsidy_states.rowid
    FROM LD_subsidy_states
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_subsidy_states is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_subsidy_states;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_subsidy_states default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUBSIDY_STATES_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    orcLD_subsidy_states  out styLD_subsidy_states
  )
  IS
    rcError styLD_subsidy_states;
  BEGIN
    rcError.SUBSIDY_STATES_Id := inuSUBSIDY_STATES_Id;

    Open cuLockRcByPk
    (
      inuSUBSIDY_STATES_Id
    );

    fetch cuLockRcByPk into orcLD_subsidy_states;
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
    orcLD_subsidy_states  out styLD_subsidy_states
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_subsidy_states;
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
    itbLD_subsidy_states  in out nocopy tytbLD_subsidy_states
  )
  IS
  BEGIN
      rcRecOfTab.Subsidy_States_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.Activate.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_subsidy_states  in out nocopy tytbLD_subsidy_states,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_subsidy_states);
    for n in itbLD_subsidy_states.first .. itbLD_subsidy_states.last loop
      rcRecOfTab.Subsidy_States_Id(n) := itbLD_subsidy_states(n).Subsidy_States_Id;
      rcRecOfTab.Description(n) := itbLD_subsidy_states(n).Description;
      rcRecOfTab.Activate(n) := itbLD_subsidy_states(n).Activate;
      rcRecOfTab.row_id(n) := itbLD_subsidy_states(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUBSIDY_STATES_Id
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
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUBSIDY_STATES_Id = rcData.SUBSIDY_STATES_Id
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
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_STATES_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  IS
    rcError styLD_subsidy_states;
  BEGIN    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;

    Load
    (
      inuSUBSIDY_STATES_Id
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
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_STATES_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    orcRecord out nocopy styLD_subsidy_states
  )
  IS
    rcError styLD_subsidy_states;
  BEGIN    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;

    Load
    (
      inuSUBSIDY_STATES_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN styLD_subsidy_states
  IS
    rcError styLD_subsidy_states;
  BEGIN
    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;

    Load
    (
      inuSUBSIDY_STATES_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type
  )
  RETURN styLD_subsidy_states
  IS
    rcError styLD_subsidy_states;
  BEGIN
    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_STATES_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUBSIDY_STATES_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy_states
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy_states
  )
  IS
    rfLD_subsidy_states tyrfLD_subsidy_states;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_subsidy_states.Subsidy_States_Id,
                LD_subsidy_states.Description,
                LD_subsidy_states.Activate,
                LD_subsidy_states.rowid
                FROM LD_subsidy_states';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_subsidy_states for sbFullQuery;
    fetch rfLD_subsidy_states bulk collect INTO otbResult;
    close rfLD_subsidy_states;
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
                LD_subsidy_states.Subsidy_States_Id,
                LD_subsidy_states.Description,
                LD_subsidy_states.Activate,
                LD_subsidy_states.rowid
                FROM LD_subsidy_states';
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
    ircLD_subsidy_states in styLD_subsidy_states
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_subsidy_states,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_subsidy_states in styLD_subsidy_states,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_subsidy_states.SUBSIDY_STATES_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUBSIDY_STATES_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_subsidy_states
    (
      Subsidy_States_Id,
      Description,
      Activate
    )
    values
    (
      ircLD_subsidy_states.Subsidy_States_Id,
      ircLD_subsidy_states.Description,
      ircLD_subsidy_states.Activate
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_subsidy_states));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_subsidy_states in out nocopy tytbLD_subsidy_states
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_states, blUseRowID);
    forall n in iotbLD_subsidy_states.first..iotbLD_subsidy_states.last
      insert into LD_subsidy_states
      (
      Subsidy_States_Id,
      Description,
      Activate
    )
    values
    (
      rcRecOfTab.Subsidy_States_Id(n),
      rcRecOfTab.Description(n),
      rcRecOfTab.Activate(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_subsidy_states;
  BEGIN
    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_STATES_Id,
        rcData
      );
    end if;

    delete
    from LD_subsidy_states
    where
           SUBSIDY_STATES_Id=inuSUBSIDY_STATES_Id;
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
    rcError  styLD_subsidy_states;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_subsidy_states
    where
      rowid = iriRowID
    returning
   SUBSIDY_STATES_Id
    into
      rcError.SUBSIDY_STATES_Id;

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
    iotbLD_subsidy_states in out nocopy tytbLD_subsidy_states,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy_states;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_states, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last
        delete
        from LD_subsidy_states
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_STATES_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last
        delete
        from LD_subsidy_states
        where
               SUBSIDY_STATES_Id = rcRecOfTab.SUBSIDY_STATES_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_subsidy_states in styLD_subsidy_states,
    inuLock    in number default 0
  )
  IS
    nuSUBSIDY_STATES_Id LD_subsidy_states.SUBSIDY_STATES_Id%type;

  BEGIN
    if ircLD_subsidy_states.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_subsidy_states.rowid,rcData);
      end if;
      update LD_subsidy_states
      set

        Description = ircLD_subsidy_states.Description,
        Activate = ircLD_subsidy_states.Activate
      where
        rowid = ircLD_subsidy_states.rowid
      returning
    SUBSIDY_STATES_Id
      into
        nuSUBSIDY_STATES_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_subsidy_states.SUBSIDY_STATES_Id,
          rcData
        );
      end if;

      update LD_subsidy_states
      set
        Description = ircLD_subsidy_states.Description,
        Activate = ircLD_subsidy_states.Activate
      where
             SUBSIDY_STATES_Id = ircLD_subsidy_states.SUBSIDY_STATES_Id
      returning
    SUBSIDY_STATES_Id
      into
        nuSUBSIDY_STATES_Id;
    end if;

    if
      nuSUBSIDY_STATES_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_subsidy_states));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_subsidy_states in out nocopy tytbLD_subsidy_states,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy_states;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_states,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last
        update LD_subsidy_states
        set

            Description = rcRecOfTab.Description(n),
            Activate = rcRecOfTab.Activate(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_STATES_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_states.first .. iotbLD_subsidy_states.last
        update LD_subsidy_states
        set
          Description = rcRecOfTab.Description(n),
          Activate = rcRecOfTab.Activate(n)
          where
          SUBSIDY_STATES_Id = rcRecOfTab.SUBSIDY_STATES_Id(n)
;
    end if;
  END;

  PROCEDURE updDescription
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    isbDescription$ in LD_subsidy_states.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_states;
  BEGIN
    rcError.SUBSIDY_STATES_Id := inuSUBSIDY_STATES_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_STATES_Id,
        rcData
      );
    end if;

    update LD_subsidy_states
    set
      Description = isbDescription$
    where
      SUBSIDY_STATES_Id = inuSUBSIDY_STATES_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updActivate
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    isbActivate$ in LD_subsidy_states.Activate%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_states;
  BEGIN
    rcError.SUBSIDY_STATES_Id := inuSUBSIDY_STATES_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_STATES_Id,
        rcData
      );
    end if;

    update LD_subsidy_states
    set
      Activate = isbActivate$
    where
      SUBSIDY_STATES_Id = inuSUBSIDY_STATES_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Activate:= isbActivate$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSubsidy_States_Id
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_states.Subsidy_States_Id%type
  IS
    rcError styLD_subsidy_states;
  BEGIN

    rcError.SUBSIDY_STATES_Id := inuSUBSIDY_STATES_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_STATES_Id
       )
    then
       return(rcData.Subsidy_States_Id);
    end if;
    Load
    (
      inuSUBSIDY_STATES_Id
    );
    return(rcData.Subsidy_States_Id);
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
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_states.Description%type
  IS
    rcError styLD_subsidy_states;
  BEGIN

    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_STATES_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuSUBSIDY_STATES_Id
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

  FUNCTION fsbGetActivate
  (
    inuSUBSIDY_STATES_Id in LD_subsidy_states.SUBSIDY_STATES_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_states.Activate%type
  IS
    rcError styLD_subsidy_states;
  BEGIN

    rcError.SUBSIDY_STATES_Id:=inuSUBSIDY_STATES_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_STATES_Id
       )
    then
       return(rcData.Activate);
    end if;
    Load
    (
      inuSUBSIDY_STATES_Id
    );
    return(rcData.Activate);
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
end DALD_subsidy_states;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUBSIDY_STATES
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUBSIDY_STATES', 'ADM_PERSON');
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre DALD_SUBSIDY_STATES
GRANT EXECUTE ON ADM_PERSON.DALD_SUBSIDY_STATES TO REXEREPORTES;
/