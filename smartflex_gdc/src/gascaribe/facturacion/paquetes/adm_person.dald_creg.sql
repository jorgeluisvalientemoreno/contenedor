CREATE OR REPLACE PACKAGE adm_person.dald_creg
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_greg
Descripcion	 : Paquete para la gestión de la entidad LD_greg (Entidad para la Generación de archivo excel para la Greg)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
04/06/2024             Adrianavg          OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  IS
    SELECT LD_creg.*,LD_creg.rowid
    FROM LD_creg
    WHERE
      Creg_Id = inuCreg_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_creg.*,LD_creg.rowid
    FROM LD_creg
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_creg  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_creg is table of styLD_creg index by binary_integer;
  type tyrfRecords is ref cursor return styLD_creg;

  /* Tipos referenciando al registro */
  type tytbCreg_Id is table of LD_creg.Creg_Id%type index by binary_integer;
  type tytbYear is table of LD_creg.Year%type index by binary_integer;
  type tytbMonth is table of LD_creg.Month%type index by binary_integer;
  type tytbRelevant_Market_Id is table of LD_creg.Relevant_Market_Id%type index by binary_integer;
  type tytbDesc_Relevant_Market is table of LD_creg.Desc_Relevant_Market%type index by binary_integer;
  type tytbConstruct_Unit_Id is table of LD_creg.Construct_Unit_Id%type index by binary_integer;
  type tytbDesc_Construct_Unit is table of LD_creg.Desc_Construct_Unit%type index by binary_integer;
  type tytbAmount_Executed is table of LD_creg.Amount_Executed%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_creg is record
  (

    Creg_Id   tytbCreg_Id,
    Year   tytbYear,
    Month   tytbMonth,
    Relevant_Market_Id   tytbRelevant_Market_Id,
    Desc_Relevant_Market   tytbDesc_Relevant_Market,
    Construct_Unit_Id   tytbConstruct_Unit_Id,
    Desc_Construct_Unit   tytbDesc_Construct_Unit,
    Amount_Executed   tytbAmount_Executed,
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
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCreg_Id in LD_creg.Creg_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCreg_Id in LD_creg.Creg_Id%type
  );

  PROCEDURE getRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    orcRecord out nocopy styLD_creg
  );

  FUNCTION frcGetRcData
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN styLD_creg;

  FUNCTION frcGetRcData
  RETURN styLD_creg;

  FUNCTION frcGetRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN styLD_creg;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_creg
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_creg in styLD_creg
  );

     PROCEDURE insRecord
  (
    ircLD_creg in styLD_creg,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_creg in out nocopy tytbLD_creg
  );

  PROCEDURE delRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_creg in out nocopy tytbLD_creg,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_creg in styLD_creg,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_creg in out nocopy tytbLD_creg,
    inuLock in number default 1
  );

    PROCEDURE updYear
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        inuYear$  in LD_creg.Year%type,
        inuLock    in number default 0
      );

    PROCEDURE updMonth
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        inuMonth$  in LD_creg.Month%type,
        inuLock    in number default 0
      );

    PROCEDURE updRelevant_Market_Id
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        inuRelevant_Market_Id$  in LD_creg.Relevant_Market_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updDesc_Relevant_Market
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        isbDesc_Relevant_Market$  in LD_creg.Desc_Relevant_Market%type,
        inuLock    in number default 0
      );

    PROCEDURE updConstruct_Unit_Id
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        inuConstruct_Unit_Id$  in LD_creg.Construct_Unit_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updDesc_Construct_Unit
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        isbDesc_Construct_Unit$  in LD_creg.Desc_Construct_Unit%type,
        inuLock    in number default 0
      );

    PROCEDURE updAmount_Executed
    (
        inuCreg_Id   in LD_creg.Creg_Id%type,
        inuAmount_Executed$  in LD_creg.Amount_Executed%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCreg_Id
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Creg_Id%type;

      FUNCTION fnuGetYear
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Year%type;

      FUNCTION fnuGetMonth
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Month%type;

      FUNCTION fnuGetRelevant_Market_Id
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Relevant_Market_Id%type;

      FUNCTION fsbGetDesc_Relevant_Market
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Desc_Relevant_Market%type;

      FUNCTION fnuGetConstruct_Unit_Id
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Construct_Unit_Id%type;

      FUNCTION fsbGetDesc_Construct_Unit
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Desc_Construct_Unit%type;

      FUNCTION fnuGetAmount_Executed
      (
          inuCreg_Id in LD_creg.Creg_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg.Amount_Executed%type;


  PROCEDURE LockByPk
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    orcLD_creg  out styLD_creg
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_creg  out styLD_creg
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_creg;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_creg
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CREG';
    cnuGeEntityId constant varchar2(30) := 8350; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  IS
    SELECT LD_creg.*,LD_creg.rowid
    FROM LD_creg
    WHERE  Creg_Id = inuCreg_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_creg.*,LD_creg.rowid
    FROM LD_creg
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_creg is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_creg;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_creg default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Creg_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    orcLD_creg  out styLD_creg
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;

    Open cuLockRcByPk
    (
      inuCreg_Id
    );

    fetch cuLockRcByPk into orcLD_creg;
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
    orcLD_creg  out styLD_creg
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_creg;
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
    itbLD_creg  in out nocopy tytbLD_creg
  )
  IS
  BEGIN
      rcRecOfTab.Creg_Id.delete;
      rcRecOfTab.Year.delete;
      rcRecOfTab.Month.delete;
      rcRecOfTab.Relevant_Market_Id.delete;
      rcRecOfTab.Desc_Relevant_Market.delete;
      rcRecOfTab.Construct_Unit_Id.delete;
      rcRecOfTab.Desc_Construct_Unit.delete;
      rcRecOfTab.Amount_Executed.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_creg  in out nocopy tytbLD_creg,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_creg);
    for n in itbLD_creg.first .. itbLD_creg.last loop
      rcRecOfTab.Creg_Id(n) := itbLD_creg(n).Creg_Id;
      rcRecOfTab.Year(n) := itbLD_creg(n).Year;
      rcRecOfTab.Month(n) := itbLD_creg(n).Month;
      rcRecOfTab.Relevant_Market_Id(n) := itbLD_creg(n).Relevant_Market_Id;
      rcRecOfTab.Desc_Relevant_Market(n) := itbLD_creg(n).Desc_Relevant_Market;
      rcRecOfTab.Construct_Unit_Id(n) := itbLD_creg(n).Construct_Unit_Id;
      rcRecOfTab.Desc_Construct_Unit(n) := itbLD_creg(n).Desc_Construct_Unit;
      rcRecOfTab.Amount_Executed(n) := itbLD_creg(n).Amount_Executed;
      rcRecOfTab.row_id(n) := itbLD_creg(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCreg_Id
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
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCreg_Id = rcData.Creg_Id
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
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCreg_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  IS
    rcError styLD_creg;
  BEGIN    rcError.Creg_Id:=inuCreg_Id;

    Load
    (
      inuCreg_Id
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
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCreg_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    orcRecord out nocopy styLD_creg
  )
  IS
    rcError styLD_creg;
  BEGIN    rcError.Creg_Id:=inuCreg_Id;

    Load
    (
      inuCreg_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN styLD_creg
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id:=inuCreg_Id;

    Load
    (
      inuCreg_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCreg_Id in LD_creg.Creg_Id%type
  )
  RETURN styLD_creg
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id:=inuCreg_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCreg_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_creg
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_creg
  )
  IS
    rfLD_creg tyrfLD_creg;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_creg.Creg_Id,
                LD_creg.Year,
                LD_creg.Month,
                LD_creg.Relevant_Market_Id,
                LD_creg.Desc_Relevant_Market,
                LD_creg.Construct_Unit_Id,
                LD_creg.Desc_Construct_Unit,
                LD_creg.Amount_Executed,
                LD_creg.rowid
                FROM LD_creg';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_creg for sbFullQuery;
    fetch rfLD_creg bulk collect INTO otbResult;
    close rfLD_creg;
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
                LD_creg.Creg_Id,
                LD_creg.Year,
                LD_creg.Month,
                LD_creg.Relevant_Market_Id,
                LD_creg.Desc_Relevant_Market,
                LD_creg.Construct_Unit_Id,
                LD_creg.Desc_Construct_Unit,
                LD_creg.Amount_Executed,
                LD_creg.rowid
                FROM LD_creg';
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
    ircLD_creg in styLD_creg
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_creg,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_creg in styLD_creg,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_creg.Creg_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Creg_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_creg
    (
      Creg_Id,
      Year,
      Month,
      Relevant_Market_Id,
      Desc_Relevant_Market,
      Construct_Unit_Id,
      Desc_Construct_Unit,
      Amount_Executed
    )
    values
    (
      ircLD_creg.Creg_Id,
      ircLD_creg.Year,
      ircLD_creg.Month,
      ircLD_creg.Relevant_Market_Id,
      ircLD_creg.Desc_Relevant_Market,
      ircLD_creg.Construct_Unit_Id,
      ircLD_creg.Desc_Construct_Unit,
      ircLD_creg.Amount_Executed
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_creg));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_creg in out nocopy tytbLD_creg
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_creg, blUseRowID);
    forall n in iotbLD_creg.first..iotbLD_creg.last
      insert into LD_creg
      (
      Creg_Id,
      Year,
      Month,
      Relevant_Market_Id,
      Desc_Relevant_Market,
      Construct_Unit_Id,
      Desc_Construct_Unit,
      Amount_Executed
    )
    values
    (
      rcRecOfTab.Creg_Id(n),
      rcRecOfTab.Year(n),
      rcRecOfTab.Month(n),
      rcRecOfTab.Relevant_Market_Id(n),
      rcRecOfTab.Desc_Relevant_Market(n),
      rcRecOfTab.Construct_Unit_Id(n),
      rcRecOfTab.Desc_Construct_Unit(n),
      rcRecOfTab.Amount_Executed(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id:=inuCreg_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    delete
    from LD_creg
    where
           Creg_Id=inuCreg_Id;
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
    rcError  styLD_creg;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_creg
    where
      rowid = iriRowID
    returning
   Creg_Id
    into
      rcError.Creg_Id;

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
    iotbLD_creg in out nocopy tytbLD_creg,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_creg;
  BEGIN
    FillRecordOfTables(iotbLD_creg, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_creg.first .. iotbLD_creg.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg.first .. iotbLD_creg.last
        delete
        from LD_creg
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_creg.first .. iotbLD_creg.last loop
          LockByPk
          (
              rcRecOfTab.Creg_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg.first .. iotbLD_creg.last
        delete
        from LD_creg
        where
               Creg_Id = rcRecOfTab.Creg_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_creg in styLD_creg,
    inuLock    in number default 0
  )
  IS
    nuCreg_Id LD_creg.Creg_Id%type;

  BEGIN
    if ircLD_creg.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_creg.rowid,rcData);
      end if;
      update LD_creg
      set

        Year = ircLD_creg.Year,
        Month = ircLD_creg.Month,
        Relevant_Market_Id = ircLD_creg.Relevant_Market_Id,
        Desc_Relevant_Market = ircLD_creg.Desc_Relevant_Market,
        Construct_Unit_Id = ircLD_creg.Construct_Unit_Id,
        Desc_Construct_Unit = ircLD_creg.Desc_Construct_Unit,
        Amount_Executed = ircLD_creg.Amount_Executed
      where
        rowid = ircLD_creg.rowid
      returning
    Creg_Id
      into
        nuCreg_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_creg.Creg_Id,
          rcData
        );
      end if;

      update LD_creg
      set
        Year = ircLD_creg.Year,
        Month = ircLD_creg.Month,
        Relevant_Market_Id = ircLD_creg.Relevant_Market_Id,
        Desc_Relevant_Market = ircLD_creg.Desc_Relevant_Market,
        Construct_Unit_Id = ircLD_creg.Construct_Unit_Id,
        Desc_Construct_Unit = ircLD_creg.Desc_Construct_Unit,
        Amount_Executed = ircLD_creg.Amount_Executed
      where
             Creg_Id = ircLD_creg.Creg_Id
      returning
    Creg_Id
      into
        nuCreg_Id;
    end if;

    if
      nuCreg_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_creg));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_creg in out nocopy tytbLD_creg,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_creg;
  BEGIN
    FillRecordOfTables(iotbLD_creg,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_creg.first .. iotbLD_creg.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg.first .. iotbLD_creg.last
        update LD_creg
        set

            Year = rcRecOfTab.Year(n),
            Month = rcRecOfTab.Month(n),
            Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n),
            Desc_Relevant_Market = rcRecOfTab.Desc_Relevant_Market(n),
            Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
            Desc_Construct_Unit = rcRecOfTab.Desc_Construct_Unit(n),
            Amount_Executed = rcRecOfTab.Amount_Executed(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_creg.first .. iotbLD_creg.last loop
          LockByPk
          (
              rcRecOfTab.Creg_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg.first .. iotbLD_creg.last
        update LD_creg
        set
          Year = rcRecOfTab.Year(n),
          Month = rcRecOfTab.Month(n),
          Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n),
          Desc_Relevant_Market = rcRecOfTab.Desc_Relevant_Market(n),
          Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
          Desc_Construct_Unit = rcRecOfTab.Desc_Construct_Unit(n),
          Amount_Executed = rcRecOfTab.Amount_Executed(n)
          where
          Creg_Id = rcRecOfTab.Creg_Id(n)
;
    end if;
  END;

  PROCEDURE updYear
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuYear$ in LD_creg.Year%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Year = inuYear$
    where
      Creg_Id = inuCreg_Id;

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
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuMonth$ in LD_creg.Month%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Month = inuMonth$
    where
      Creg_Id = inuCreg_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Month:= inuMonth$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRelevant_Market_Id
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRelevant_Market_Id$ in LD_creg.Relevant_Market_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Relevant_Market_Id = inuRelevant_Market_Id$
    where
      Creg_Id = inuCreg_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Relevant_Market_Id:= inuRelevant_Market_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDesc_Relevant_Market
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    isbDesc_Relevant_Market$ in LD_creg.Desc_Relevant_Market%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Desc_Relevant_Market = isbDesc_Relevant_Market$
    where
      Creg_Id = inuCreg_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Desc_Relevant_Market:= isbDesc_Relevant_Market$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updConstruct_Unit_Id
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuConstruct_Unit_Id$ in LD_creg.Construct_Unit_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Construct_Unit_Id = inuConstruct_Unit_Id$
    where
      Creg_Id = inuCreg_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Construct_Unit_Id:= inuConstruct_Unit_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDesc_Construct_Unit
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    isbDesc_Construct_Unit$ in LD_creg.Desc_Construct_Unit%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Desc_Construct_Unit = isbDesc_Construct_Unit$
    where
      Creg_Id = inuCreg_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Desc_Construct_Unit:= isbDesc_Construct_Unit$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAmount_Executed
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuAmount_Executed$ in LD_creg.Amount_Executed%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg;
  BEGIN
    rcError.Creg_Id := inuCreg_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Id,
        rcData
      );
    end if;

    update LD_creg
    set
      Amount_Executed = inuAmount_Executed$
    where
      Creg_Id = inuCreg_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Amount_Executed:= inuAmount_Executed$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCreg_Id
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Creg_Id%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id := inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Creg_Id);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData.Creg_Id);
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
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Year%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id := inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Year);
    end if;
    Load
    (
      inuCreg_Id
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
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Month%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id := inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Month);
    end if;
    Load
    (
      inuCreg_Id
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

  FUNCTION fnuGetRelevant_Market_Id
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Relevant_Market_Id%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id := inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Relevant_Market_Id);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData.Relevant_Market_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetDesc_Relevant_Market
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Desc_Relevant_Market%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id:=inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Desc_Relevant_Market);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData.Desc_Relevant_Market);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetConstruct_Unit_Id
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Construct_Unit_Id%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id := inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Construct_Unit_Id);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData.Construct_Unit_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetDesc_Construct_Unit
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Desc_Construct_Unit%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id:=inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Desc_Construct_Unit);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData.Desc_Construct_Unit);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAmount_Executed
  (
    inuCreg_Id in LD_creg.Creg_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg.Amount_Executed%type
  IS
    rcError styLD_creg;
  BEGIN

    rcError.Creg_Id := inuCreg_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Id
       )
    then
       return(rcData.Amount_Executed);
    end if;
    Load
    (
      inuCreg_Id
    );
    return(rcData.Amount_Executed);
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
end DALD_creg;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CREG
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CREG', 'ADM_PERSON'); 
END;
/  
