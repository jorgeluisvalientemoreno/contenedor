CREATE OR REPLACE PACKAGE adm_person.dald_demand_budget
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_demand_budget
Descripcion	 : Paquete para la gestión de la entidad LD_demand_budget (Presupuesto Demanda de Gas)

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
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  IS
    SELECT LD_demand_budget.*,LD_demand_budget.rowid
    FROM LD_demand_budget
    WHERE
      Demand_Budget_Id = inuDemand_Budget_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_demand_budget.*,LD_demand_budget.rowid
    FROM LD_demand_budget
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_demand_budget  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_demand_budget is table of styLD_demand_budget index by binary_integer;
  type tyrfRecords is ref cursor return styLD_demand_budget;

  /* Tipos referenciando al registro */
  type tytbDemand_Budget_Id is table of LD_demand_budget.Demand_Budget_Id%type index by binary_integer;
  type tytbRel_Mark_Budget_Id is table of LD_demand_budget.Rel_Mark_Budget_Id%type index by binary_integer;
  type tytbCatecodi is table of LD_demand_budget.Catecodi%type index by binary_integer;
  type tytbSucacodi is table of LD_demand_budget.Sucacodi%type index by binary_integer;
  type tytbBudget_Amount is table of LD_demand_budget.Budget_Amount%type index by binary_integer;
  type tytbExecuted_Amount is table of LD_demand_budget.Executed_Amount%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_demand_budget is record
  (

    Demand_Budget_Id   tytbDemand_Budget_Id,
    Rel_Mark_Budget_Id   tytbRel_Mark_Budget_Id,
    Catecodi   tytbCatecodi,
    Sucacodi   tytbSucacodi,
    Budget_Amount   tytbBudget_Amount,
    Executed_Amount   tytbExecuted_Amount,
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
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  );

  PROCEDURE getRecord
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    orcRecord out nocopy styLD_demand_budget
  );

  FUNCTION frcGetRcData
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN styLD_demand_budget;

  FUNCTION frcGetRcData
  RETURN styLD_demand_budget;

  FUNCTION frcGetRecord
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN styLD_demand_budget;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_demand_budget
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_demand_budget in styLD_demand_budget
  );

     PROCEDURE insRecord
  (
    ircLD_demand_budget in styLD_demand_budget,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_demand_budget in out nocopy tytbLD_demand_budget
  );

  PROCEDURE delRecord
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_demand_budget in out nocopy tytbLD_demand_budget,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_demand_budget in styLD_demand_budget,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_demand_budget in out nocopy tytbLD_demand_budget,
    inuLock in number default 1
  );

    PROCEDURE updRel_Mark_Budget_Id
    (
        inuDemand_Budget_Id   in LD_demand_budget.Demand_Budget_Id%type,
        inuRel_Mark_Budget_Id$  in LD_demand_budget.Rel_Mark_Budget_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updCatecodi
    (
        inuDemand_Budget_Id   in LD_demand_budget.Demand_Budget_Id%type,
        inuCatecodi$  in LD_demand_budget.Catecodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updSucacodi
    (
        inuDemand_Budget_Id   in LD_demand_budget.Demand_Budget_Id%type,
        inuSucacodi$  in LD_demand_budget.Sucacodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updBudget_Amount
    (
        inuDemand_Budget_Id   in LD_demand_budget.Demand_Budget_Id%type,
        inuBudget_Amount$  in LD_demand_budget.Budget_Amount%type,
        inuLock    in number default 0
      );

    PROCEDURE updExecuted_Amount
    (
        inuDemand_Budget_Id   in LD_demand_budget.Demand_Budget_Id%type,
        inuExecuted_Amount$  in LD_demand_budget.Executed_Amount%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetDemand_Budget_Id
      (
          inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_demand_budget.Demand_Budget_Id%type;

      FUNCTION fnuGetRel_Mark_Budget_Id
      (
          inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_demand_budget.Rel_Mark_Budget_Id%type;

      FUNCTION fnuGetCatecodi
      (
          inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_demand_budget.Catecodi%type;

      FUNCTION fnuGetSucacodi
      (
          inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_demand_budget.Sucacodi%type;

      FUNCTION fnuGetBudget_Amount
      (
          inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_demand_budget.Budget_Amount%type;

      FUNCTION fnuGetExecuted_Amount
      (
          inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_demand_budget.Executed_Amount%type;


  PROCEDURE LockByPk
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    orcLD_demand_budget  out styLD_demand_budget
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_demand_budget  out styLD_demand_budget
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_demand_budget;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_demand_budget
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DEMAND_BUDGET';
    cnuGeEntityId constant varchar2(30) := 8346; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  IS
    SELECT LD_demand_budget.*,LD_demand_budget.rowid
    FROM LD_demand_budget
    WHERE  Demand_Budget_Id = inuDemand_Budget_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_demand_budget.*,LD_demand_budget.rowid
    FROM LD_demand_budget
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_demand_budget is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_demand_budget;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_demand_budget default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Demand_Budget_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    orcLD_demand_budget  out styLD_demand_budget
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    Open cuLockRcByPk
    (
      inuDemand_Budget_Id
    );

    fetch cuLockRcByPk into orcLD_demand_budget;
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
    orcLD_demand_budget  out styLD_demand_budget
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_demand_budget;
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
    itbLD_demand_budget  in out nocopy tytbLD_demand_budget
  )
  IS
  BEGIN
      rcRecOfTab.Demand_Budget_Id.delete;
      rcRecOfTab.Rel_Mark_Budget_Id.delete;
      rcRecOfTab.Catecodi.delete;
      rcRecOfTab.Sucacodi.delete;
      rcRecOfTab.Budget_Amount.delete;
      rcRecOfTab.Executed_Amount.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_demand_budget  in out nocopy tytbLD_demand_budget,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_demand_budget);
    for n in itbLD_demand_budget.first .. itbLD_demand_budget.last loop
      rcRecOfTab.Demand_Budget_Id(n) := itbLD_demand_budget(n).Demand_Budget_Id;
      rcRecOfTab.Rel_Mark_Budget_Id(n) := itbLD_demand_budget(n).Rel_Mark_Budget_Id;
      rcRecOfTab.Catecodi(n) := itbLD_demand_budget(n).Catecodi;
      rcRecOfTab.Sucacodi(n) := itbLD_demand_budget(n).Sucacodi;
      rcRecOfTab.Budget_Amount(n) := itbLD_demand_budget(n).Budget_Amount;
      rcRecOfTab.Executed_Amount(n) := itbLD_demand_budget(n).Executed_Amount;
      rcRecOfTab.row_id(n) := itbLD_demand_budget(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuDemand_Budget_Id
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
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuDemand_Budget_Id = rcData.Demand_Budget_Id
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
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuDemand_Budget_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  IS
    rcError styLD_demand_budget;
  BEGIN    rcError.Demand_Budget_Id:=inuDemand_Budget_Id;

    Load
    (
      inuDemand_Budget_Id
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
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuDemand_Budget_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    orcRecord out nocopy styLD_demand_budget
  )
  IS
    rcError styLD_demand_budget;
  BEGIN    rcError.Demand_Budget_Id:=inuDemand_Budget_Id;

    Load
    (
      inuDemand_Budget_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN styLD_demand_budget
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id:=inuDemand_Budget_Id;

    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type
  )
  RETURN styLD_demand_budget
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id:=inuDemand_Budget_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuDemand_Budget_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_demand_budget
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_demand_budget
  )
  IS
    rfLD_demand_budget tyrfLD_demand_budget;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_demand_budget.Demand_Budget_Id,
                LD_demand_budget.Rel_Mark_Budget_Id,
                LD_demand_budget.Catecodi,
                LD_demand_budget.Sucacodi,
                LD_demand_budget.Budget_Amount,
                LD_demand_budget.Executed_Amount,
                LD_demand_budget.rowid
                FROM LD_demand_budget';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_demand_budget for sbFullQuery;
    fetch rfLD_demand_budget bulk collect INTO otbResult;
    close rfLD_demand_budget;
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
                LD_demand_budget.Demand_Budget_Id,
                LD_demand_budget.Rel_Mark_Budget_Id,
                LD_demand_budget.Catecodi,
                LD_demand_budget.Sucacodi,
                LD_demand_budget.Budget_Amount,
                LD_demand_budget.Executed_Amount,
                LD_demand_budget.rowid
                FROM LD_demand_budget';
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
    ircLD_demand_budget in styLD_demand_budget
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_demand_budget,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_demand_budget in styLD_demand_budget,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_demand_budget.Demand_Budget_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Demand_Budget_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_demand_budget
    (
      Demand_Budget_Id,
      Rel_Mark_Budget_Id,
      Catecodi,
      Sucacodi,
      Budget_Amount,
      Executed_Amount
    )
    values
    (
      ircLD_demand_budget.Demand_Budget_Id,
      ircLD_demand_budget.Rel_Mark_Budget_Id,
      ircLD_demand_budget.Catecodi,
      ircLD_demand_budget.Sucacodi,
      ircLD_demand_budget.Budget_Amount,
      ircLD_demand_budget.Executed_Amount
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_demand_budget));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_demand_budget in out nocopy tytbLD_demand_budget
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_demand_budget, blUseRowID);
    forall n in iotbLD_demand_budget.first..iotbLD_demand_budget.last
      insert into LD_demand_budget
      (
      Demand_Budget_Id,
      Rel_Mark_Budget_Id,
      Catecodi,
      Sucacodi,
      Budget_Amount,
      Executed_Amount
    )
    values
    (
      rcRecOfTab.Demand_Budget_Id(n),
      rcRecOfTab.Rel_Mark_Budget_Id(n),
      rcRecOfTab.Catecodi(n),
      rcRecOfTab.Sucacodi(n),
      rcRecOfTab.Budget_Amount(n),
      rcRecOfTab.Executed_Amount(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id:=inuDemand_Budget_Id;

    if inuLock=1 then
      LockByPk
      (
        inuDemand_Budget_Id,
        rcData
      );
    end if;

    delete
    from LD_demand_budget
    where
           Demand_Budget_Id=inuDemand_Budget_Id;
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
    rcError  styLD_demand_budget;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_demand_budget
    where
      rowid = iriRowID
    returning
   Demand_Budget_Id
    into
      rcError.Demand_Budget_Id;

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
    iotbLD_demand_budget in out nocopy tytbLD_demand_budget,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_demand_budget;
  BEGIN
    FillRecordOfTables(iotbLD_demand_budget, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last
        delete
        from LD_demand_budget
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last loop
          LockByPk
          (
              rcRecOfTab.Demand_Budget_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last
        delete
        from LD_demand_budget
        where
               Demand_Budget_Id = rcRecOfTab.Demand_Budget_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_demand_budget in styLD_demand_budget,
    inuLock    in number default 0
  )
  IS
    nuDemand_Budget_Id LD_demand_budget.Demand_Budget_Id%type;

  BEGIN
    if ircLD_demand_budget.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_demand_budget.rowid,rcData);
      end if;
      update LD_demand_budget
      set

        Rel_Mark_Budget_Id = ircLD_demand_budget.Rel_Mark_Budget_Id,
        Catecodi = ircLD_demand_budget.Catecodi,
        Sucacodi = ircLD_demand_budget.Sucacodi,
        Budget_Amount = ircLD_demand_budget.Budget_Amount,
        Executed_Amount = ircLD_demand_budget.Executed_Amount
      where
        rowid = ircLD_demand_budget.rowid
      returning
    Demand_Budget_Id
      into
        nuDemand_Budget_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_demand_budget.Demand_Budget_Id,
          rcData
        );
      end if;

      update LD_demand_budget
      set
        Rel_Mark_Budget_Id = ircLD_demand_budget.Rel_Mark_Budget_Id,
        Catecodi = ircLD_demand_budget.Catecodi,
        Sucacodi = ircLD_demand_budget.Sucacodi,
        Budget_Amount = ircLD_demand_budget.Budget_Amount,
        Executed_Amount = ircLD_demand_budget.Executed_Amount
      where
             Demand_Budget_Id = ircLD_demand_budget.Demand_Budget_Id
      returning
    Demand_Budget_Id
      into
        nuDemand_Budget_Id;
    end if;

    if
      nuDemand_Budget_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_demand_budget));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_demand_budget in out nocopy tytbLD_demand_budget,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_demand_budget;
  BEGIN
    FillRecordOfTables(iotbLD_demand_budget,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last
        update LD_demand_budget
        set

            Rel_Mark_Budget_Id = rcRecOfTab.Rel_Mark_Budget_Id(n),
            Catecodi = rcRecOfTab.Catecodi(n),
            Sucacodi = rcRecOfTab.Sucacodi(n),
            Budget_Amount = rcRecOfTab.Budget_Amount(n),
            Executed_Amount = rcRecOfTab.Executed_Amount(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last loop
          LockByPk
          (
              rcRecOfTab.Demand_Budget_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_demand_budget.first .. iotbLD_demand_budget.last
        update LD_demand_budget
        set
          Rel_Mark_Budget_Id = rcRecOfTab.Rel_Mark_Budget_Id(n),
          Catecodi = rcRecOfTab.Catecodi(n),
          Sucacodi = rcRecOfTab.Sucacodi(n),
          Budget_Amount = rcRecOfTab.Budget_Amount(n),
          Executed_Amount = rcRecOfTab.Executed_Amount(n)
          where
          Demand_Budget_Id = rcRecOfTab.Demand_Budget_Id(n)
;
    end if;
  END;

  PROCEDURE updRel_Mark_Budget_Id
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRel_Mark_Budget_Id$ in LD_demand_budget.Rel_Mark_Budget_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id := inuDemand_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDemand_Budget_Id,
        rcData
      );
    end if;

    update LD_demand_budget
    set
      Rel_Mark_Budget_Id = inuRel_Mark_Budget_Id$
    where
      Demand_Budget_Id = inuDemand_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Rel_Mark_Budget_Id:= inuRel_Mark_Budget_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCatecodi
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuCatecodi$ in LD_demand_budget.Catecodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id := inuDemand_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDemand_Budget_Id,
        rcData
      );
    end if;

    update LD_demand_budget
    set
      Catecodi = inuCatecodi$
    where
      Demand_Budget_Id = inuDemand_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Catecodi:= inuCatecodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSucacodi
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuSucacodi$ in LD_demand_budget.Sucacodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id := inuDemand_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDemand_Budget_Id,
        rcData
      );
    end if;

    update LD_demand_budget
    set
      Sucacodi = inuSucacodi$
    where
      Demand_Budget_Id = inuDemand_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sucacodi:= inuSucacodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updBudget_Amount
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuBudget_Amount$ in LD_demand_budget.Budget_Amount%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id := inuDemand_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDemand_Budget_Id,
        rcData
      );
    end if;

    update LD_demand_budget
    set
      Budget_Amount = inuBudget_Amount$
    where
      Demand_Budget_Id = inuDemand_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Budget_Amount:= inuBudget_Amount$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updExecuted_Amount
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuExecuted_Amount$ in LD_demand_budget.Executed_Amount%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_demand_budget;
  BEGIN
    rcError.Demand_Budget_Id := inuDemand_Budget_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDemand_Budget_Id,
        rcData
      );
    end if;

    update LD_demand_budget
    set
      Executed_Amount = inuExecuted_Amount$
    where
      Demand_Budget_Id = inuDemand_Budget_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Executed_Amount:= inuExecuted_Amount$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetDemand_Budget_Id
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_demand_budget.Demand_Budget_Id%type
  IS
    rcError styLD_demand_budget;
  BEGIN

    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDemand_Budget_Id
       )
    then
       return(rcData.Demand_Budget_Id);
    end if;
    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData.Demand_Budget_Id);
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
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_demand_budget.Rel_Mark_Budget_Id%type
  IS
    rcError styLD_demand_budget;
  BEGIN

    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDemand_Budget_Id
       )
    then
       return(rcData.Rel_Mark_Budget_Id);
    end if;
    Load
    (
      inuDemand_Budget_Id
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

  FUNCTION fnuGetCatecodi
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_demand_budget.Catecodi%type
  IS
    rcError styLD_demand_budget;
  BEGIN

    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDemand_Budget_Id
       )
    then
       return(rcData.Catecodi);
    end if;
    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData.Catecodi);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSucacodi
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_demand_budget.Sucacodi%type
  IS
    rcError styLD_demand_budget;
  BEGIN

    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDemand_Budget_Id
       )
    then
       return(rcData.Sucacodi);
    end if;
    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData.Sucacodi);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetBudget_Amount
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_demand_budget.Budget_Amount%type
  IS
    rcError styLD_demand_budget;
  BEGIN

    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDemand_Budget_Id
       )
    then
       return(rcData.Budget_Amount);
    end if;
    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData.Budget_Amount);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetExecuted_Amount
  (
    inuDemand_Budget_Id in LD_demand_budget.Demand_Budget_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_demand_budget.Executed_Amount%type
  IS
    rcError styLD_demand_budget;
  BEGIN

    rcError.Demand_Budget_Id := inuDemand_Budget_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDemand_Budget_Id
       )
    then
       return(rcData.Executed_Amount);
    end if;
    Load
    (
      inuDemand_Budget_Id
    );
    return(rcData.Executed_Amount);
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
end DALD_demand_budget;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_DEMAND_BUDGET
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_DEMAND_BUDGET', 'ADM_PERSON'); 
END;
/  
