CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_subsidy_concept
is
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  IS
    SELECT LD_subsidy_concept.*,LD_subsidy_concept.rowid
    FROM LD_subsidy_concept
    WHERE
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy_concept.*,LD_subsidy_concept.rowid
    FROM LD_subsidy_concept
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_subsidy_concept  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_subsidy_concept is table of styLD_subsidy_concept index by binary_integer;
  type tyrfRecords is ref cursor return styLD_subsidy_concept;

  /* Tipos referenciando al registro */
  type tytbSubsidy_Concept_Id is table of LD_subsidy_concept.Subsidy_Concept_Id%type index by binary_integer;
  type tytbPackage_Id is table of LD_subsidy_concept.Package_Id%type index by binary_integer;
  type tytbConccodi is table of LD_subsidy_concept.Conccodi%type index by binary_integer;
  type tytbSubsidy_Value is table of LD_subsidy_concept.Subsidy_Value%type index by binary_integer;
  type tytbUser_Id is table of LD_subsidy_concept.User_Id%type index by binary_integer;
  type tytbSesion is table of LD_subsidy_concept.Sesion%type index by binary_integer;
  type tytbTerminal is table of LD_subsidy_concept.Terminal%type index by binary_integer;
  type tytbSubsidy_Id is table of LD_subsidy_concept.Subsidy_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_subsidy_concept is record
  (

    Subsidy_Concept_Id   tytbSubsidy_Concept_Id,
    Package_Id   tytbPackage_Id,
    Conccodi   tytbConccodi,
    Subsidy_Value   tytbSubsidy_Value,
    User_Id   tytbUser_Id,
    Sesion   tytbSesion,
    Terminal   tytbTerminal,
    Subsidy_Id   tytbSubsidy_Id,
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
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  );

  PROCEDURE getRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    orcRecord out nocopy styLD_subsidy_concept
  );

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN styLD_subsidy_concept;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy_concept;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN styLD_subsidy_concept;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy_concept
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_subsidy_concept in styLD_subsidy_concept
  );

     PROCEDURE insRecord
  (
    ircLD_subsidy_concept in styLD_subsidy_concept,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_subsidy_concept in out nocopy tytbLD_subsidy_concept
  );

  PROCEDURE delRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_subsidy_concept in out nocopy tytbLD_subsidy_concept,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_subsidy_concept in styLD_subsidy_concept,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_subsidy_concept in out nocopy tytbLD_subsidy_concept,
    inuLock in number default 1
  );

    PROCEDURE updPackage_Id
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        inuPackage_Id$  in LD_subsidy_concept.Package_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updConccodi
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        inuConccodi$  in LD_subsidy_concept.Conccodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Value
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        inuSubsidy_Value$  in LD_subsidy_concept.Subsidy_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updUser_Id
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        isbUser_Id$  in LD_subsidy_concept.User_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSesion
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        inuSesion$  in LD_subsidy_concept.Sesion%type,
        inuLock    in number default 0
      );

    PROCEDURE updTerminal
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        isbTerminal$  in LD_subsidy_concept.Terminal%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Id
    (
        inuSUBSIDY_CONCEPT_Id   in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
        inuSubsidy_Id$  in LD_subsidy_concept.Subsidy_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetSubsidy_Concept_Id
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Subsidy_Concept_Id%type;

      FUNCTION fnuGetPackage_Id
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Package_Id%type;

      FUNCTION fnuGetConccodi
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Conccodi%type;

      FUNCTION fnuGetSubsidy_Value
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Subsidy_Value%type;

      FUNCTION fsbGetUser_Id
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.User_Id%type;

      FUNCTION fnuGetSesion
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Sesion%type;

      FUNCTION fsbGetTerminal
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Terminal%type;

      FUNCTION fnuGetSubsidy_Id
      (
          inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy_concept.Subsidy_Id%type;


  PROCEDURE LockByPk
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    orcLD_subsidy_concept  out styLD_subsidy_concept
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_subsidy_concept  out styLD_subsidy_concept
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_subsidy_concept;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_subsidy_concept
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUBSIDY_CONCEPT';
    cnuGeEntityId constant varchar2(30) := 8173; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  IS
    SELECT LD_subsidy_concept.*,LD_subsidy_concept.rowid
    FROM LD_subsidy_concept
    WHERE  SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy_concept.*,LD_subsidy_concept.rowid
    FROM LD_subsidy_concept
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_subsidy_concept is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_subsidy_concept;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_subsidy_concept default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUBSIDY_CONCEPT_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    orcLD_subsidy_concept  out styLD_subsidy_concept
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    Open cuLockRcByPk
    (
      inuSUBSIDY_CONCEPT_Id
    );

    fetch cuLockRcByPk into orcLD_subsidy_concept;
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
    orcLD_subsidy_concept  out styLD_subsidy_concept
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_subsidy_concept;
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
    itbLD_subsidy_concept  in out nocopy tytbLD_subsidy_concept
  )
  IS
  BEGIN
      rcRecOfTab.Subsidy_Concept_Id.delete;
      rcRecOfTab.Package_Id.delete;
      rcRecOfTab.Conccodi.delete;
      rcRecOfTab.Subsidy_Value.delete;
      rcRecOfTab.User_Id.delete;
      rcRecOfTab.Sesion.delete;
      rcRecOfTab.Terminal.delete;
      rcRecOfTab.Subsidy_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_subsidy_concept  in out nocopy tytbLD_subsidy_concept,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_subsidy_concept);
    for n in itbLD_subsidy_concept.first .. itbLD_subsidy_concept.last loop
      rcRecOfTab.Subsidy_Concept_Id(n) := itbLD_subsidy_concept(n).Subsidy_Concept_Id;
      rcRecOfTab.Package_Id(n) := itbLD_subsidy_concept(n).Package_Id;
      rcRecOfTab.Conccodi(n) := itbLD_subsidy_concept(n).Conccodi;
      rcRecOfTab.Subsidy_Value(n) := itbLD_subsidy_concept(n).Subsidy_Value;
      rcRecOfTab.User_Id(n) := itbLD_subsidy_concept(n).User_Id;
      rcRecOfTab.Sesion(n) := itbLD_subsidy_concept(n).Sesion;
      rcRecOfTab.Terminal(n) := itbLD_subsidy_concept(n).Terminal;
      rcRecOfTab.Subsidy_Id(n) := itbLD_subsidy_concept(n).Subsidy_Id;
      rcRecOfTab.row_id(n) := itbLD_subsidy_concept(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUBSIDY_CONCEPT_Id
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
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUBSIDY_CONCEPT_Id = rcData.SUBSIDY_CONCEPT_Id
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
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;

    Load
    (
      inuSUBSIDY_CONCEPT_Id
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
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    orcRecord out nocopy styLD_subsidy_concept
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;

    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN styLD_subsidy_concept
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;

    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type
  )
  RETURN styLD_subsidy_concept
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy_concept
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy_concept
  )
  IS
    rfLD_subsidy_concept tyrfLD_subsidy_concept;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_subsidy_concept.Subsidy_Concept_Id,
                LD_subsidy_concept.Package_Id,
                LD_subsidy_concept.Conccodi,
                LD_subsidy_concept.Subsidy_Value,
                LD_subsidy_concept.User_Id,
                LD_subsidy_concept.Sesion,
                LD_subsidy_concept.Terminal,
                LD_subsidy_concept.Subsidy_Id,
                LD_subsidy_concept.rowid
                FROM LD_subsidy_concept';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_subsidy_concept for sbFullQuery;
    fetch rfLD_subsidy_concept bulk collect INTO otbResult;
    close rfLD_subsidy_concept;
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
                LD_subsidy_concept.Subsidy_Concept_Id,
                LD_subsidy_concept.Package_Id,
                LD_subsidy_concept.Conccodi,
                LD_subsidy_concept.Subsidy_Value,
                LD_subsidy_concept.User_Id,
                LD_subsidy_concept.Sesion,
                LD_subsidy_concept.Terminal,
                LD_subsidy_concept.Subsidy_Id,
                LD_subsidy_concept.rowid
                FROM LD_subsidy_concept';
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
    ircLD_subsidy_concept in styLD_subsidy_concept
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_subsidy_concept,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_subsidy_concept in styLD_subsidy_concept,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_subsidy_concept.SUBSIDY_CONCEPT_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUBSIDY_CONCEPT_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_subsidy_concept
    (
      Subsidy_Concept_Id,
      Package_Id,
      Conccodi,
      Subsidy_Value,
      User_Id,
      Sesion,
      Terminal,
      Subsidy_Id
    )
    values
    (
      ircLD_subsidy_concept.Subsidy_Concept_Id,
      ircLD_subsidy_concept.Package_Id,
      ircLD_subsidy_concept.Conccodi,
      ircLD_subsidy_concept.Subsidy_Value,
      ircLD_subsidy_concept.User_Id,
      ircLD_subsidy_concept.Sesion,
      ircLD_subsidy_concept.Terminal,
      ircLD_subsidy_concept.Subsidy_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_subsidy_concept));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_subsidy_concept in out nocopy tytbLD_subsidy_concept
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_concept, blUseRowID);
    forall n in iotbLD_subsidy_concept.first..iotbLD_subsidy_concept.last
      insert into LD_subsidy_concept
      (
      Subsidy_Concept_Id,
      Package_Id,
      Conccodi,
      Subsidy_Value,
      User_Id,
      Sesion,
      Terminal,
      Subsidy_Id
    )
    values
    (
      rcRecOfTab.Subsidy_Concept_Id(n),
      rcRecOfTab.Package_Id(n),
      rcRecOfTab.Conccodi(n),
      rcRecOfTab.Subsidy_Value(n),
      rcRecOfTab.User_Id(n),
      rcRecOfTab.Sesion(n),
      rcRecOfTab.Terminal(n),
      rcRecOfTab.Subsidy_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    delete
    from LD_subsidy_concept
    where
           SUBSIDY_CONCEPT_Id=inuSUBSIDY_CONCEPT_Id;
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
    rcError  styLD_subsidy_concept;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_subsidy_concept
    where
      rowid = iriRowID
    returning
   SUBSIDY_CONCEPT_Id
    into
      rcError.SUBSIDY_CONCEPT_Id;

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
    iotbLD_subsidy_concept in out nocopy tytbLD_subsidy_concept,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy_concept;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_concept, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last
        delete
        from LD_subsidy_concept
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_CONCEPT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last
        delete
        from LD_subsidy_concept
        where
               SUBSIDY_CONCEPT_Id = rcRecOfTab.SUBSIDY_CONCEPT_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_subsidy_concept in styLD_subsidy_concept,
    inuLock    in number default 0
  )
  IS
    nuSUBSIDY_CONCEPT_Id LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type;

  BEGIN
    if ircLD_subsidy_concept.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_subsidy_concept.rowid,rcData);
      end if;
      update LD_subsidy_concept
      set

        Package_Id = ircLD_subsidy_concept.Package_Id,
        Conccodi = ircLD_subsidy_concept.Conccodi,
        Subsidy_Value = ircLD_subsidy_concept.Subsidy_Value,
        User_Id = ircLD_subsidy_concept.User_Id,
        Sesion = ircLD_subsidy_concept.Sesion,
        Terminal = ircLD_subsidy_concept.Terminal,
        Subsidy_Id = ircLD_subsidy_concept.Subsidy_Id
      where
        rowid = ircLD_subsidy_concept.rowid
      returning
    SUBSIDY_CONCEPT_Id
      into
        nuSUBSIDY_CONCEPT_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_subsidy_concept.SUBSIDY_CONCEPT_Id,
          rcData
        );
      end if;

      update LD_subsidy_concept
      set
        Package_Id = ircLD_subsidy_concept.Package_Id,
        Conccodi = ircLD_subsidy_concept.Conccodi,
        Subsidy_Value = ircLD_subsidy_concept.Subsidy_Value,
        User_Id = ircLD_subsidy_concept.User_Id,
        Sesion = ircLD_subsidy_concept.Sesion,
        Terminal = ircLD_subsidy_concept.Terminal,
        Subsidy_Id = ircLD_subsidy_concept.Subsidy_Id
      where
             SUBSIDY_CONCEPT_Id = ircLD_subsidy_concept.SUBSIDY_CONCEPT_Id
      returning
    SUBSIDY_CONCEPT_Id
      into
        nuSUBSIDY_CONCEPT_Id;
    end if;

    if
      nuSUBSIDY_CONCEPT_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_subsidy_concept));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_subsidy_concept in out nocopy tytbLD_subsidy_concept,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy_concept;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy_concept,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last
        update LD_subsidy_concept
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Conccodi = rcRecOfTab.Conccodi(n),
            Subsidy_Value = rcRecOfTab.Subsidy_Value(n),
            User_Id = rcRecOfTab.User_Id(n),
            Sesion = rcRecOfTab.Sesion(n),
            Terminal = rcRecOfTab.Terminal(n),
            Subsidy_Id = rcRecOfTab.Subsidy_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_CONCEPT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy_concept.first .. iotbLD_subsidy_concept.last
        update LD_subsidy_concept
        set
          Package_Id = rcRecOfTab.Package_Id(n),
          Conccodi = rcRecOfTab.Conccodi(n),
          Subsidy_Value = rcRecOfTab.Subsidy_Value(n),
          User_Id = rcRecOfTab.User_Id(n),
          Sesion = rcRecOfTab.Sesion(n),
          Terminal = rcRecOfTab.Terminal(n),
          Subsidy_Id = rcRecOfTab.Subsidy_Id(n)
          where
          SUBSIDY_CONCEPT_Id = rcRecOfTab.SUBSIDY_CONCEPT_Id(n)
;
    end if;
  END;

  PROCEDURE updPackage_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuPackage_Id$ in LD_subsidy_concept.Package_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      Package_Id = inuPackage_Id$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Id:= inuPackage_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updConccodi
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuConccodi$ in LD_subsidy_concept.Conccodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      Conccodi = inuConccodi$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Conccodi:= inuConccodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Value
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuSubsidy_Value$ in LD_subsidy_concept.Subsidy_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      Subsidy_Value = inuSubsidy_Value$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Value:= inuSubsidy_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updUser_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    isbUser_Id$ in LD_subsidy_concept.User_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      User_Id = isbUser_Id$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.User_Id:= isbUser_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSesion
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuSesion$ in LD_subsidy_concept.Sesion%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      Sesion = inuSesion$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sesion:= inuSesion$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTerminal
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    isbTerminal$ in LD_subsidy_concept.Terminal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      Terminal = isbTerminal$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Terminal:= isbTerminal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuSubsidy_Id$ in LD_subsidy_concept.Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy_concept;
  BEGIN
    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_CONCEPT_Id,
        rcData
      );
    end if;

    update LD_subsidy_concept
    set
      Subsidy_Id = inuSubsidy_Id$
    where
      SUBSIDY_CONCEPT_Id = inuSUBSIDY_CONCEPT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Id:= inuSubsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSubsidy_Concept_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Subsidy_Concept_Id%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Subsidy_Concept_Id);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData.Subsidy_Concept_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetPackage_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Package_Id%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Package_Id);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
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

  FUNCTION fnuGetConccodi
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Conccodi%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Conccodi);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
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

  FUNCTION fnuGetSubsidy_Value
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Subsidy_Value%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Subsidy_Value);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
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

  FUNCTION fsbGetUser_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.User_Id%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.User_Id);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData.User_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSesion
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Sesion%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Sesion);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData.Sesion);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetTerminal
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Terminal%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id:=inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Terminal);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData.Terminal);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSubsidy_Id
  (
    inuSUBSIDY_CONCEPT_Id in LD_subsidy_concept.SUBSIDY_CONCEPT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy_concept.Subsidy_Id%type
  IS
    rcError styLD_subsidy_concept;
  BEGIN

    rcError.SUBSIDY_CONCEPT_Id := inuSUBSIDY_CONCEPT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_CONCEPT_Id
       )
    then
       return(rcData.Subsidy_Id);
    end if;
    Load
    (
      inuSUBSIDY_CONCEPT_Id
    );
    return(rcData.Subsidy_Id);
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
end DALD_subsidy_concept;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUBSIDY_CONCEPT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUBSIDY_CONCEPT', 'ADM_PERSON');
END;
/
