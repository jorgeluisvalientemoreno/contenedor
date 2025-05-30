CREATE OR REPLACE PACKAGE adm_person.dald_mar_exp_budget
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_mar_exp_budget
Descripcion	 : Paquete para la gestión de la entidad LD_mar_exp_budget (Presupuesto de Gastos de comercialización)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
11/06/2024             Adrianavg          OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  IS
    SELECT LD_mar_exp_budget.*,LD_mar_exp_budget.rowid
    FROM LD_mar_exp_budget
    WHERE
      Mar_Exp_Budget_Id = inuMar_Exp_Budget_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_mar_exp_budget.*,LD_mar_exp_budget.rowid
    FROM LD_mar_exp_budget
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_mar_exp_budget  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_mar_exp_budget is table of styLD_mar_exp_budget index by binary_integer;
  type tyrfRecords is ref cursor return styLD_mar_exp_budget;

  /* Tipos referenciando al registro */
  type tytbMar_Exp_Budget_Id is table of LD_mar_exp_budget.Mar_Exp_Budget_Id%type index by binary_integer;
  type tytbRel_Mark_Budget_Id is table of LD_mar_exp_budget.Rel_Mark_Budget_Id%type index by binary_integer;
  type tytbContable_Account is table of LD_mar_exp_budget.Contable_Account%type index by binary_integer;
  type tytbBudget_Value is table of LD_mar_exp_budget.Budget_Value%type index by binary_integer;
  type tytbValue_Executed is table of LD_mar_exp_budget.Value_Executed%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_mar_exp_budget is record
  (

    Mar_Exp_Budget_Id   tytbMar_Exp_Budget_Id,
    Rel_Mark_Budget_Id   tytbRel_Mark_Budget_Id,
    Contable_Account   tytbContable_Account,
    Budget_Value   tytbBudget_Value,
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
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  );

  PROCEDURE getRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    orcRecord out nocopy styLD_mar_exp_budget
  );

  FUNCTION frcGetRcData
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN styLD_mar_exp_budget;

  FUNCTION frcGetRcData
  RETURN styLD_mar_exp_budget;

  FUNCTION frcGetRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN styLD_mar_exp_budget;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_mar_exp_budget
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_mar_exp_budget in styLD_mar_exp_budget
  );

     PROCEDURE insRecord
  (
    ircLD_mar_exp_budget in styLD_mar_exp_budget,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_mar_exp_budget in out nocopy tytbLD_mar_exp_budget
  );

  PROCEDURE delRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_mar_exp_budget in out nocopy tytbLD_mar_exp_budget,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_mar_exp_budget in styLD_mar_exp_budget,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_mar_exp_budget in out nocopy tytbLD_mar_exp_budget,
    inuLock in number default 1
  );

    PROCEDURE updRel_Mark_Budget_Id
    (
        inuMar_Exp_Budget_Id   in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
        inuRel_Mark_Budget_Id$  in LD_mar_exp_budget.Rel_Mark_Budget_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updContable_Account
    (
        inuMar_Exp_Budget_Id   in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
        inuContable_Account$  in LD_mar_exp_budget.Contable_Account%type,
        inuLock    in number default 0
      );

    PROCEDURE updBudget_Value
    (
        inuMar_Exp_Budget_Id   in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
        inuBudget_Value$  in LD_mar_exp_budget.Budget_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updValue_Executed
    (
        inuMar_Exp_Budget_Id   in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
        inuValue_Executed$  in LD_mar_exp_budget.Value_Executed%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetMar_Exp_Budget_Id
      (
          inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_mar_exp_budget.Mar_Exp_Budget_Id%type;

      FUNCTION fnuGetRel_Mark_Budget_Id
      (
          inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_mar_exp_budget.Rel_Mark_Budget_Id%type;

      FUNCTION fnuGetContable_Account
      (
          inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_mar_exp_budget.Contable_Account%type;

      FUNCTION fnuGetBudget_Value
      (
          inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_mar_exp_budget.Budget_Value%type;

      FUNCTION fnuGetValue_Executed
      (
          inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_mar_exp_budget.Value_Executed%type;


  PROCEDURE LockByPk
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    orcLD_mar_exp_budget  out styLD_mar_exp_budget
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_mar_exp_budget  out styLD_mar_exp_budget
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_mar_exp_budget;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_mar_exp_budget
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_MAR_EXP_BUDGET';
    cnuGeEntityId constant varchar2(30) := 8351; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  IS
    SELECT LD_mar_exp_budget.*,LD_mar_exp_budget.rowid
    FROM LD_mar_exp_budget
    WHERE  Mar_Exp_Budget_Id = inuMar_Exp_Budget_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_mar_exp_budget.*,LD_mar_exp_budget.rowid
    FROM LD_mar_exp_budget
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_mar_exp_budget is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_mar_exp_budget;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_mar_exp_budget default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Mar_Exp_Budget_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    orcLD_mar_exp_budget  out styLD_mar_exp_budget
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;

    Open cuLockRcByPk
    (
      inuMar_Exp_Budget_Id
    );

    fetch cuLockRcByPk into orcLD_mar_exp_budget;
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
    orcLD_mar_exp_budget  out styLD_mar_exp_budget
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_mar_exp_budget;
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
    itbLD_mar_exp_budget  in out nocopy tytbLD_mar_exp_budget
  )
  IS
  BEGIN
      rcRecOfTab.Mar_Exp_Budget_Id.delete;
      rcRecOfTab.Rel_Mark_Budget_Id.delete;
      rcRecOfTab.Contable_Account.delete;
      rcRecOfTab.Budget_Value.delete;
      rcRecOfTab.Value_Executed.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_mar_exp_budget  in out nocopy tytbLD_mar_exp_budget,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_mar_exp_budget);
    for n in itbLD_mar_exp_budget.first .. itbLD_mar_exp_budget.last loop
      rcRecOfTab.Mar_Exp_Budget_Id(n) := itbLD_mar_exp_budget(n).Mar_Exp_Budget_Id;
      rcRecOfTab.Rel_Mark_Budget_Id(n) := itbLD_mar_exp_budget(n).Rel_Mark_Budget_Id;
      rcRecOfTab.Contable_Account(n) := itbLD_mar_exp_budget(n).Contable_Account;
      rcRecOfTab.Budget_Value(n) := itbLD_mar_exp_budget(n).Budget_Value;
      rcRecOfTab.Value_Executed(n) := itbLD_mar_exp_budget(n).Value_Executed;
      rcRecOfTab.row_id(n) := itbLD_mar_exp_budget(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuMar_Exp_Budget_Id
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
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuMar_Exp_Budget_Id = rcData.Mar_Exp_Budget_Id
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
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuMar_Exp_Budget_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN    rcError.Mar_Exp_Budget_Id:=inuMar_Exp_Budget_Id;

    Load
    (
      inuMar_Exp_Budget_Id
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
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuMar_Exp_Budget_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    orcRecord out nocopy styLD_mar_exp_budget
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN    rcError.Mar_Exp_Budget_Id:=inuMar_Exp_Budget_Id;

    Load
    (
      inuMar_Exp_Budget_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN styLD_mar_exp_budget
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id:=inuMar_Exp_Budget_Id;

    Load
    (
      inuMar_Exp_Budget_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  )
  RETURN styLD_mar_exp_budget
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id:=inuMar_Exp_Budget_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuMar_Exp_Budget_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuMar_Exp_Budget_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_mar_exp_budget
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_mar_exp_budget
  )
  IS
    rfLD_mar_exp_budget tyrfLD_mar_exp_budget;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_mar_exp_budget.Mar_Exp_Budget_Id,
                LD_mar_exp_budget.Rel_Mark_Budget_Id,
                LD_mar_exp_budget.Contable_Account,
                LD_mar_exp_budget.Budget_Value,
                LD_mar_exp_budget.Value_Executed,
                LD_mar_exp_budget.rowid
                FROM LD_mar_exp_budget';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_mar_exp_budget for sbFullQuery;
    fetch rfLD_mar_exp_budget bulk collect INTO otbResult;
    close rfLD_mar_exp_budget;
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
                LD_mar_exp_budget.Mar_Exp_Budget_Id,
                LD_mar_exp_budget.Rel_Mark_Budget_Id,
                LD_mar_exp_budget.Contable_Account,
                LD_mar_exp_budget.Budget_Value,
                LD_mar_exp_budget.Value_Executed,
                LD_mar_exp_budget.rowid
                FROM LD_mar_exp_budget';
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
    ircLD_mar_exp_budget in styLD_mar_exp_budget
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_mar_exp_budget,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_mar_exp_budget in styLD_mar_exp_budget,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_mar_exp_budget.Mar_Exp_Budget_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Mar_Exp_Budget_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_mar_exp_budget
    (
      Mar_Exp_Budget_Id,
      Rel_Mark_Budget_Id,
      Contable_Account,
      Budget_Value,
      Value_Executed
    )
    values
    (
      ircLD_mar_exp_budget.Mar_Exp_Budget_Id,
      ircLD_mar_exp_budget.Rel_Mark_Budget_Id,
      ircLD_mar_exp_budget.Contable_Account,
      ircLD_mar_exp_budget.Budget_Value,
      ircLD_mar_exp_budget.Value_Executed
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_mar_exp_budget));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_mar_exp_budget in out nocopy tytbLD_mar_exp_budget
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_mar_exp_budget, blUseRowID);
    forall n in iotbLD_mar_exp_budget.first..iotbLD_mar_exp_budget.last
      insert into LD_mar_exp_budget
      (
      Mar_Exp_Budget_Id,
      Rel_Mark_Budget_Id,
      Contable_Account,
      Budget_Value,
      Value_Executed
    )
    values
    (
      rcRecOfTab.Mar_Exp_Budget_Id(n),
      rcRecOfTab.Rel_Mark_Budget_Id(n),
      rcRecOfTab.Contable_Account(n),
      rcRecOfTab.Budget_Value(n),
      rcRecOfTab.Value_Executed(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id:=inuMar_Exp_Budget_Id;

    if inuLock=1 then
      LockByPk
      (
        inuMar_Exp_Budget_Id,
        rcData
      );
    end if;

    delete
    from LD_mar_exp_budget
    where
           Mar_Exp_Budget_Id=inuMar_Exp_Budget_Id;
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
    rcError  styLD_mar_exp_budget;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_mar_exp_budget
    where
      rowid = iriRowID
    returning
   Mar_Exp_Budget_Id
    into
      rcError.Mar_Exp_Budget_Id;

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
    iotbLD_mar_exp_budget in out nocopy tytbLD_mar_exp_budget,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_mar_exp_budget;
  BEGIN
    FillRecordOfTables(iotbLD_mar_exp_budget, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last
        delete
        from LD_mar_exp_budget
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last loop
          LockByPk
          (
              rcRecOfTab.Mar_Exp_Budget_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last
        delete
        from LD_mar_exp_budget
        where
               Mar_Exp_Budget_Id = rcRecOfTab.Mar_Exp_Budget_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_mar_exp_budget in styLD_mar_exp_budget,
    inuLock    in number default 0
  )
  IS
    nuMar_Exp_Budget_Id LD_mar_exp_budget.Mar_Exp_Budget_Id%type;

  BEGIN
    if ircLD_mar_exp_budget.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_mar_exp_budget.rowid,rcData);
      end if;
      update LD_mar_exp_budget
      set

        Rel_Mark_Budget_Id = ircLD_mar_exp_budget.Rel_Mark_Budget_Id,
        Contable_Account = ircLD_mar_exp_budget.Contable_Account,
        Budget_Value = ircLD_mar_exp_budget.Budget_Value,
        Value_Executed = ircLD_mar_exp_budget.Value_Executed
      where
        rowid = ircLD_mar_exp_budget.rowid
      returning
    Mar_Exp_Budget_Id
      into
        nuMar_Exp_Budget_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_mar_exp_budget.Mar_Exp_Budget_Id,
          rcData
        );
      end if;

      update LD_mar_exp_budget
      set
        Rel_Mark_Budget_Id = ircLD_mar_exp_budget.Rel_Mark_Budget_Id,
        Contable_Account = ircLD_mar_exp_budget.Contable_Account,
        Budget_Value = ircLD_mar_exp_budget.Budget_Value,
        Value_Executed = ircLD_mar_exp_budget.Value_Executed
      where
             Mar_Exp_Budget_Id = ircLD_mar_exp_budget.Mar_Exp_Budget_Id
      returning
    Mar_Exp_Budget_Id
      into
        nuMar_Exp_Budget_Id;
    end if;

    if
      nuMar_Exp_Budget_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_mar_exp_budget));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_mar_exp_budget in out nocopy tytbLD_mar_exp_budget,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_mar_exp_budget;
  BEGIN
    FillRecordOfTables(iotbLD_mar_exp_budget,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last
        update LD_mar_exp_budget
        set

            Rel_Mark_Budget_Id = rcRecOfTab.Rel_Mark_Budget_Id(n),
            Contable_Account = rcRecOfTab.Contable_Account(n),
            Budget_Value = rcRecOfTab.Budget_Value(n),
            Value_Executed = rcRecOfTab.Value_Executed(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last loop
          LockByPk
          (
              rcRecOfTab.Mar_Exp_Budget_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_mar_exp_budget.first .. iotbLD_mar_exp_budget.last
        update LD_mar_exp_budget
        set
          Rel_Mark_Budget_Id = rcRecOfTab.Rel_Mark_Budget_Id(n),
          Contable_Account = rcRecOfTab.Contable_Account(n),
          Budget_Value = rcRecOfTab.Budget_Value(n),
          Value_Executed = rcRecOfTab.Value_Executed(n)
          where
          Mar_Exp_Budget_Id = rcRecOfTab.Mar_Exp_Budget_Id(n)
;
    end if;
  END;

  PROCEDURE updRel_Mark_Budget_Id
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuRel_Mark_Budget_Id$ in LD_mar_exp_budget.Rel_Mark_Budget_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuMar_Exp_Budget_Id,
        rcData
      );
    end if;

    update LD_mar_exp_budget
    set
      Rel_Mark_Budget_Id = inuRel_Mark_Budget_Id$
    where
      Mar_Exp_Budget_Id = inuMar_Exp_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Rel_Mark_Budget_Id:= inuRel_Mark_Budget_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updContable_Account
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuContable_Account$ in LD_mar_exp_budget.Contable_Account%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuMar_Exp_Budget_Id,
        rcData
      );
    end if;

    update LD_mar_exp_budget
    set
      Contable_Account = inuContable_Account$
    where
      Mar_Exp_Budget_Id = inuMar_Exp_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Contable_Account:= inuContable_Account$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updBudget_Value
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuBudget_Value$ in LD_mar_exp_budget.Budget_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuMar_Exp_Budget_Id,
        rcData
      );
    end if;

    update LD_mar_exp_budget
    set
      Budget_Value = inuBudget_Value$
    where
      Mar_Exp_Budget_Id = inuMar_Exp_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Budget_Value:= inuBudget_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updValue_Executed
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuValue_Executed$ in LD_mar_exp_budget.Value_Executed%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_mar_exp_budget;
  BEGIN
    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuMar_Exp_Budget_Id,
        rcData
      );
    end if;

    update LD_mar_exp_budget
    set
      Value_Executed = inuValue_Executed$
    where
      Mar_Exp_Budget_Id = inuMar_Exp_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Value_Executed:= inuValue_Executed$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetMar_Exp_Budget_Id
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_mar_exp_budget.Mar_Exp_Budget_Id%type
  IS
    rcError styLD_mar_exp_budget;
  BEGIN

    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuMar_Exp_Budget_Id
       )
    then
       return(rcData.Mar_Exp_Budget_Id);
    end if;
    Load
    (
      inuMar_Exp_Budget_Id
    );
    return(rcData.Mar_Exp_Budget_Id);
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
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_mar_exp_budget.Rel_Mark_Budget_Id%type
  IS
    rcError styLD_mar_exp_budget;
  BEGIN

    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuMar_Exp_Budget_Id
       )
    then
       return(rcData.Rel_Mark_Budget_Id);
    end if;
    Load
    (
      inuMar_Exp_Budget_Id
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

  FUNCTION fnuGetContable_Account
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_mar_exp_budget.Contable_Account%type
  IS
    rcError styLD_mar_exp_budget;
  BEGIN

    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuMar_Exp_Budget_Id
       )
    then
       return(rcData.Contable_Account);
    end if;
    Load
    (
      inuMar_Exp_Budget_Id
    );
    return(rcData.Contable_Account);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetBudget_Value
  (
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_mar_exp_budget.Budget_Value%type
  IS
    rcError styLD_mar_exp_budget;
  BEGIN

    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuMar_Exp_Budget_Id
       )
    then
       return(rcData.Budget_Value);
    end if;
    Load
    (
      inuMar_Exp_Budget_Id
    );
    return(rcData.Budget_Value);
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
    inuMar_Exp_Budget_Id in LD_mar_exp_budget.Mar_Exp_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_mar_exp_budget.Value_Executed%type
  IS
    rcError styLD_mar_exp_budget;
  BEGIN

    rcError.Mar_Exp_Budget_Id := inuMar_Exp_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuMar_Exp_Budget_Id
       )
    then
       return(rcData.Value_Executed);
    end if;
    Load
    (
      inuMar_Exp_Budget_Id
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
end DALD_mar_exp_budget;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_MAR_EXP_BUDGET
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_MAR_EXP_BUDGET', 'ADM_PERSON'); 
END;
/