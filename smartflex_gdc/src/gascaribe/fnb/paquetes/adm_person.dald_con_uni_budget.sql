CREATE OR REPLACE PACKAGE adm_person.dald_con_uni_budget
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_con_uni_budget
Descripcion	 : Paquete para la gestión de la entidad LD_con_uni_budget (Presupuesto - Unidades Constructivas)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
04/06/2024             Adrianavg         OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
****************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  IS
    SELECT LD_con_uni_budget.*,LD_con_uni_budget.rowid
    FROM LD_con_uni_budget
    WHERE
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_con_uni_budget.*,LD_con_uni_budget.rowid
    FROM LD_con_uni_budget
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_con_uni_budget  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_con_uni_budget is table of styLD_con_uni_budget index by binary_integer;
  type tyrfRecords is ref cursor return styLD_con_uni_budget;

  /* Tipos referenciando al registro */
  type tytbCon_Uni_Budget_Id is table of LD_con_uni_budget.Con_Uni_Budget_Id%type index by binary_integer;
  type tytbRel_Mark_Budget_Id is table of LD_con_uni_budget.Rel_Mark_Budget_Id%type index by binary_integer;
  type tytbConstruct_Unit_Id is table of LD_con_uni_budget.Construct_Unit_Id%type index by binary_integer;
  type tytbAmount is table of LD_con_uni_budget.Amount%type index by binary_integer;
  type tytbValue_Budget_Cop is table of LD_con_uni_budget.Value_Budget_Cop%type index by binary_integer;
  type tytbAmount_Executed is table of LD_con_uni_budget.Amount_Executed%type index by binary_integer;
  type tytbValue_Executed is table of LD_con_uni_budget.Value_Executed%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_con_uni_budget is record
  (

    Con_Uni_Budget_Id   tytbCon_Uni_Budget_Id,
    Rel_Mark_Budget_Id   tytbRel_Mark_Budget_Id,
    Construct_Unit_Id   tytbConstruct_Unit_Id,
    Amount   tytbAmount,
    Value_Budget_Cop   tytbValue_Budget_Cop,
    Amount_Executed   tytbAmount_Executed,
    Value_Executed   tytbValue_Executed,
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
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  );

  PROCEDURE getRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    orcRecord out nocopy styLD_con_uni_budget
  );

  FUNCTION frcGetRcData
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN styLD_con_uni_budget;

  FUNCTION frcGetRcData
  RETURN styLD_con_uni_budget;

  FUNCTION frcGetRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN styLD_con_uni_budget;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_con_uni_budget
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_con_uni_budget in styLD_con_uni_budget
  );

     PROCEDURE insRecord
  (
    ircLD_con_uni_budget in styLD_con_uni_budget,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_con_uni_budget in out nocopy tytbLD_con_uni_budget
  );

  PROCEDURE delRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_con_uni_budget in out nocopy tytbLD_con_uni_budget,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_con_uni_budget in styLD_con_uni_budget,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_con_uni_budget in out nocopy tytbLD_con_uni_budget,
    inuLock in number default 1
  );

    PROCEDURE updRel_Mark_Budget_Id
    (
        inuCon_Uni_Budget_Id   in LD_con_uni_budget.Con_Uni_Budget_Id%type,
        inuRel_Mark_Budget_Id$  in LD_con_uni_budget.Rel_Mark_Budget_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updConstruct_Unit_Id
    (
        inuCon_Uni_Budget_Id   in LD_con_uni_budget.Con_Uni_Budget_Id%type,
        inuConstruct_Unit_Id$  in LD_con_uni_budget.Construct_Unit_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updAmount
    (
        inuCon_Uni_Budget_Id   in LD_con_uni_budget.Con_Uni_Budget_Id%type,
        inuAmount$  in LD_con_uni_budget.Amount%type,
        inuLock    in number default 0
      );

    PROCEDURE updValue_Budget_Cop
    (
        inuCon_Uni_Budget_Id   in LD_con_uni_budget.Con_Uni_Budget_Id%type,
        inuValue_Budget_Cop$  in LD_con_uni_budget.Value_Budget_Cop%type,
        inuLock    in number default 0
      );

    PROCEDURE updAmount_Executed
    (
        inuCon_Uni_Budget_Id   in LD_con_uni_budget.Con_Uni_Budget_Id%type,
        inuAmount_Executed$  in LD_con_uni_budget.Amount_Executed%type,
        inuLock    in number default 0
      );

    PROCEDURE updValue_Executed
    (
        inuCon_Uni_Budget_Id   in LD_con_uni_budget.Con_Uni_Budget_Id%type,
        inuValue_Executed$  in LD_con_uni_budget.Value_Executed%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCon_Uni_Budget_Id
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Con_Uni_Budget_Id%type;

      FUNCTION fnuGetRel_Mark_Budget_Id
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Rel_Mark_Budget_Id%type;

      FUNCTION fnuGetConstruct_Unit_Id
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Construct_Unit_Id%type;

      FUNCTION fnuGetAmount
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Amount%type;

      FUNCTION fnuGetValue_Budget_Cop
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Value_Budget_Cop%type;

      FUNCTION fnuGetAmount_Executed
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Amount_Executed%type;

      FUNCTION fnuGetValue_Executed
      (
          inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_con_uni_budget.Value_Executed%type;


  PROCEDURE LockByPk
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    orcLD_con_uni_budget  out styLD_con_uni_budget
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_con_uni_budget  out styLD_con_uni_budget
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_con_uni_budget;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_con_uni_budget
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CON_UNI_BUDGET';
    cnuGeEntityId constant varchar2(30) := 8344; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  IS
    SELECT LD_con_uni_budget.*,LD_con_uni_budget.rowid
    FROM LD_con_uni_budget
    WHERE  Con_Uni_Budget_Id = inuCon_Uni_Budget_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_con_uni_budget.*,LD_con_uni_budget.rowid
    FROM LD_con_uni_budget
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_con_uni_budget is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_con_uni_budget;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_con_uni_budget default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Con_Uni_Budget_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    orcLD_con_uni_budget  out styLD_con_uni_budget
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    Open cuLockRcByPk
    (
      inuCon_Uni_Budget_Id
    );

    fetch cuLockRcByPk into orcLD_con_uni_budget;
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
    orcLD_con_uni_budget  out styLD_con_uni_budget
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_con_uni_budget;
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
    itbLD_con_uni_budget  in out nocopy tytbLD_con_uni_budget
  )
  IS
  BEGIN
      rcRecOfTab.Con_Uni_Budget_Id.delete;
      rcRecOfTab.Rel_Mark_Budget_Id.delete;
      rcRecOfTab.Construct_Unit_Id.delete;
      rcRecOfTab.Amount.delete;
      rcRecOfTab.Value_Budget_Cop.delete;
      rcRecOfTab.Amount_Executed.delete;
      rcRecOfTab.Value_Executed.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_con_uni_budget  in out nocopy tytbLD_con_uni_budget,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_con_uni_budget);
    for n in itbLD_con_uni_budget.first .. itbLD_con_uni_budget.last loop
      rcRecOfTab.Con_Uni_Budget_Id(n) := itbLD_con_uni_budget(n).Con_Uni_Budget_Id;
      rcRecOfTab.Rel_Mark_Budget_Id(n) := itbLD_con_uni_budget(n).Rel_Mark_Budget_Id;
      rcRecOfTab.Construct_Unit_Id(n) := itbLD_con_uni_budget(n).Construct_Unit_Id;
      rcRecOfTab.Amount(n) := itbLD_con_uni_budget(n).Amount;
      rcRecOfTab.Value_Budget_Cop(n) := itbLD_con_uni_budget(n).Value_Budget_Cop;
      rcRecOfTab.Amount_Executed(n) := itbLD_con_uni_budget(n).Amount_Executed;
      rcRecOfTab.Value_Executed(n) := itbLD_con_uni_budget(n).Value_Executed;
      rcRecOfTab.row_id(n) := itbLD_con_uni_budget(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCon_Uni_Budget_Id
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
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCon_Uni_Budget_Id = rcData.Con_Uni_Budget_Id
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
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN    rcError.Con_Uni_Budget_Id:=inuCon_Uni_Budget_Id;

    Load
    (
      inuCon_Uni_Budget_Id
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
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCon_Uni_Budget_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    orcRecord out nocopy styLD_con_uni_budget
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN    rcError.Con_Uni_Budget_Id:=inuCon_Uni_Budget_Id;

    Load
    (
      inuCon_Uni_Budget_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN styLD_con_uni_budget
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id:=inuCon_Uni_Budget_Id;

    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type
  )
  RETURN styLD_con_uni_budget
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id:=inuCon_Uni_Budget_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCon_Uni_Budget_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_con_uni_budget
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_con_uni_budget
  )
  IS
    rfLD_con_uni_budget tyrfLD_con_uni_budget;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_con_uni_budget.Con_Uni_Budget_Id,
                LD_con_uni_budget.Rel_Mark_Budget_Id,
                LD_con_uni_budget.Construct_Unit_Id,
                LD_con_uni_budget.Amount,
                LD_con_uni_budget.Value_Budget_Cop,
                LD_con_uni_budget.Amount_Executed,
                LD_con_uni_budget.Value_Executed,
                LD_con_uni_budget.rowid
                FROM LD_con_uni_budget';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_con_uni_budget for sbFullQuery;
    fetch rfLD_con_uni_budget bulk collect INTO otbResult;
    close rfLD_con_uni_budget;
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
                LD_con_uni_budget.Con_Uni_Budget_Id,
                LD_con_uni_budget.Rel_Mark_Budget_Id,
                LD_con_uni_budget.Construct_Unit_Id,
                LD_con_uni_budget.Amount,
                LD_con_uni_budget.Value_Budget_Cop,
                LD_con_uni_budget.Amount_Executed,
                LD_con_uni_budget.Value_Executed,
                LD_con_uni_budget.rowid
                FROM LD_con_uni_budget';
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
    ircLD_con_uni_budget in styLD_con_uni_budget
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_con_uni_budget,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_con_uni_budget in styLD_con_uni_budget,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_con_uni_budget.Con_Uni_Budget_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Con_Uni_Budget_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_con_uni_budget
    (
      Con_Uni_Budget_Id,
      Rel_Mark_Budget_Id,
      Construct_Unit_Id,
      Amount,
      Value_Budget_Cop,
      Amount_Executed,
      Value_Executed
    )
    values
    (
      ircLD_con_uni_budget.Con_Uni_Budget_Id,
      ircLD_con_uni_budget.Rel_Mark_Budget_Id,
      ircLD_con_uni_budget.Construct_Unit_Id,
      ircLD_con_uni_budget.Amount,
      ircLD_con_uni_budget.Value_Budget_Cop,
      ircLD_con_uni_budget.Amount_Executed,
      ircLD_con_uni_budget.Value_Executed
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_con_uni_budget));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_con_uni_budget in out nocopy tytbLD_con_uni_budget
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_con_uni_budget, blUseRowID);
    forall n in iotbLD_con_uni_budget.first..iotbLD_con_uni_budget.last
      insert into LD_con_uni_budget
      (
      Con_Uni_Budget_Id,
      Rel_Mark_Budget_Id,
      Construct_Unit_Id,
      Amount,
      Value_Budget_Cop,
      Amount_Executed,
      Value_Executed
    )
    values
    (
      rcRecOfTab.Con_Uni_Budget_Id(n),
      rcRecOfTab.Rel_Mark_Budget_Id(n),
      rcRecOfTab.Construct_Unit_Id(n),
      rcRecOfTab.Amount(n),
      rcRecOfTab.Value_Budget_Cop(n),
      rcRecOfTab.Amount_Executed(n),
      rcRecOfTab.Value_Executed(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id:=inuCon_Uni_Budget_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    delete
    from LD_con_uni_budget
    where
           Con_Uni_Budget_Id=inuCon_Uni_Budget_Id;
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
    rcError  styLD_con_uni_budget;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_con_uni_budget
    where
      rowid = iriRowID
    returning
   Con_Uni_Budget_Id
    into
      rcError.Con_Uni_Budget_Id;

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
    iotbLD_con_uni_budget in out nocopy tytbLD_con_uni_budget,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_con_uni_budget;
  BEGIN
    FillRecordOfTables(iotbLD_con_uni_budget, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last
        delete
        from LD_con_uni_budget
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last loop
          LockByPk
          (
              rcRecOfTab.Con_Uni_Budget_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last
        delete
        from LD_con_uni_budget
        where
               Con_Uni_Budget_Id = rcRecOfTab.Con_Uni_Budget_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_con_uni_budget in styLD_con_uni_budget,
    inuLock    in number default 0
  )
  IS
    nuCon_Uni_Budget_Id LD_con_uni_budget.Con_Uni_Budget_Id%type;

  BEGIN
    if ircLD_con_uni_budget.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_con_uni_budget.rowid,rcData);
      end if;
      update LD_con_uni_budget
      set

        Rel_Mark_Budget_Id = ircLD_con_uni_budget.Rel_Mark_Budget_Id,
        Construct_Unit_Id = ircLD_con_uni_budget.Construct_Unit_Id,
        Amount = ircLD_con_uni_budget.Amount,
        Value_Budget_Cop = ircLD_con_uni_budget.Value_Budget_Cop,
        Amount_Executed = ircLD_con_uni_budget.Amount_Executed,
        Value_Executed = ircLD_con_uni_budget.Value_Executed
      where
        rowid = ircLD_con_uni_budget.rowid
      returning
    Con_Uni_Budget_Id
      into
        nuCon_Uni_Budget_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_con_uni_budget.Con_Uni_Budget_Id,
          rcData
        );
      end if;

      update LD_con_uni_budget
      set
        Rel_Mark_Budget_Id = ircLD_con_uni_budget.Rel_Mark_Budget_Id,
        Construct_Unit_Id = ircLD_con_uni_budget.Construct_Unit_Id,
        Amount = ircLD_con_uni_budget.Amount,
        Value_Budget_Cop = ircLD_con_uni_budget.Value_Budget_Cop,
        Amount_Executed = ircLD_con_uni_budget.Amount_Executed,
        Value_Executed = ircLD_con_uni_budget.Value_Executed
      where
             Con_Uni_Budget_Id = ircLD_con_uni_budget.Con_Uni_Budget_Id
      returning
    Con_Uni_Budget_Id
      into
        nuCon_Uni_Budget_Id;
    end if;

    if
      nuCon_Uni_Budget_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_con_uni_budget));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_con_uni_budget in out nocopy tytbLD_con_uni_budget,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_con_uni_budget;
  BEGIN
    FillRecordOfTables(iotbLD_con_uni_budget,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last
        update LD_con_uni_budget
        set

            Rel_Mark_Budget_Id = rcRecOfTab.Rel_Mark_Budget_Id(n),
            Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
            Amount = rcRecOfTab.Amount(n),
            Value_Budget_Cop = rcRecOfTab.Value_Budget_Cop(n),
            Amount_Executed = rcRecOfTab.Amount_Executed(n),
            Value_Executed = rcRecOfTab.Value_Executed(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last loop
          LockByPk
          (
              rcRecOfTab.Con_Uni_Budget_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_con_uni_budget.first .. iotbLD_con_uni_budget.last
        update LD_con_uni_budget
        set
          Rel_Mark_Budget_Id = rcRecOfTab.Rel_Mark_Budget_Id(n),
          Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
          Amount = rcRecOfTab.Amount(n),
          Value_Budget_Cop = rcRecOfTab.Value_Budget_Cop(n),
          Amount_Executed = rcRecOfTab.Amount_Executed(n),
          Value_Executed = rcRecOfTab.Value_Executed(n)
          where
          Con_Uni_Budget_Id = rcRecOfTab.Con_Uni_Budget_Id(n)
;
    end if;
  END;

  PROCEDURE updRel_Mark_Budget_Id
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRel_Mark_Budget_Id$ in LD_con_uni_budget.Rel_Mark_Budget_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    update LD_con_uni_budget
    set
      Rel_Mark_Budget_Id = inuRel_Mark_Budget_Id$
    where
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Rel_Mark_Budget_Id:= inuRel_Mark_Budget_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updConstruct_Unit_Id
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuConstruct_Unit_Id$ in LD_con_uni_budget.Construct_Unit_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    update LD_con_uni_budget
    set
      Construct_Unit_Id = inuConstruct_Unit_Id$
    where
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Construct_Unit_Id:= inuConstruct_Unit_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAmount
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuAmount$ in LD_con_uni_budget.Amount%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    update LD_con_uni_budget
    set
      Amount = inuAmount$
    where
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Amount:= inuAmount$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updValue_Budget_Cop
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuValue_Budget_Cop$ in LD_con_uni_budget.Value_Budget_Cop%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    update LD_con_uni_budget
    set
      Value_Budget_Cop = inuValue_Budget_Cop$
    where
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Value_Budget_Cop:= inuValue_Budget_Cop$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAmount_Executed
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuAmount_Executed$ in LD_con_uni_budget.Amount_Executed%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    update LD_con_uni_budget
    set
      Amount_Executed = inuAmount_Executed$
    where
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Amount_Executed:= inuAmount_Executed$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updValue_Executed
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuValue_Executed$ in LD_con_uni_budget.Value_Executed%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_con_uni_budget;
  BEGIN
    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCon_Uni_Budget_Id,
        rcData
      );
    end if;

    update LD_con_uni_budget
    set
      Value_Executed = inuValue_Executed$
    where
      Con_Uni_Budget_Id = inuCon_Uni_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Value_Executed:= inuValue_Executed$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCon_Uni_Budget_Id
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Con_Uni_Budget_Id%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Con_Uni_Budget_Id);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData.Con_Uni_Budget_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetRel_Mark_Budget_Id
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Rel_Mark_Budget_Id%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Rel_Mark_Budget_Id);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData.Rel_Mark_Budget_Id);
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
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Construct_Unit_Id%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Construct_Unit_Id);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
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

  FUNCTION fnuGetAmount
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Amount%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Amount);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData.Amount);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetValue_Budget_Cop
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Value_Budget_Cop%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Value_Budget_Cop);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData.Value_Budget_Cop);
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
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Amount_Executed%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Amount_Executed);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
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

  FUNCTION fnuGetValue_Executed
  (
    inuCon_Uni_Budget_Id in LD_con_uni_budget.Con_Uni_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_con_uni_budget.Value_Executed%type
  IS
    rcError styLD_con_uni_budget;
  BEGIN

    rcError.Con_Uni_Budget_Id := inuCon_Uni_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCon_Uni_Budget_Id
       )
    then
       return(rcData.Value_Executed);
    end if;
    Load
    (
      inuCon_Uni_Budget_Id
    );
    return(rcData.Value_Executed);
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
end DALD_con_uni_budget;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CON_UNI_BUDGET
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CON_UNI_BUDGET', 'ADM_PERSON'); 
END;
/
