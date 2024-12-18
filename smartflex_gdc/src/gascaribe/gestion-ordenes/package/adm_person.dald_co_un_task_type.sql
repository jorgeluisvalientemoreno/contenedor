CREATE OR REPLACE PACKAGE adm_person.dald_co_un_task_type
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_co_un_task_type
Descripcion	 : Paquete para la gestión de la entidad LD_co_un_task_type (Unidades Constructivas - Tipo de trabajo)

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
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  IS
    SELECT LD_co_un_task_type.*,LD_co_un_task_type.rowid
    FROM LD_co_un_task_type
    WHERE
      Co_Un_Task_Type_Id = inuCo_Un_Task_Type_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_co_un_task_type.*,LD_co_un_task_type.rowid
    FROM LD_co_un_task_type
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_co_un_task_type  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_co_un_task_type is table of styLD_co_un_task_type index by binary_integer;
  type tyrfRecords is ref cursor return styLD_co_un_task_type;

  /* Tipos referenciando al registro */
  type tytbCo_Un_Task_Type_Id is table of LD_co_un_task_type.Co_Un_Task_Type_Id%type index by binary_integer;
  type tytbConstruct_Unit_Id is table of LD_co_un_task_type.Construct_Unit_Id%type index by binary_integer;
  type tytbTask_Type_Id is table of LD_co_un_task_type.Task_Type_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_co_un_task_type is record
  (

    Co_Un_Task_Type_Id   tytbCo_Un_Task_Type_Id,
    Construct_Unit_Id   tytbConstruct_Unit_Id,
    Task_Type_Id   tytbTask_Type_Id,
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
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  );

  PROCEDURE getRecord
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    orcRecord out nocopy styLD_co_un_task_type
  );

  FUNCTION frcGetRcData
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN styLD_co_un_task_type;

  FUNCTION frcGetRcData
  RETURN styLD_co_un_task_type;

  FUNCTION frcGetRecord
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN styLD_co_un_task_type;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_co_un_task_type
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_co_un_task_type in styLD_co_un_task_type
  );

     PROCEDURE insRecord
  (
    ircLD_co_un_task_type in styLD_co_un_task_type,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_co_un_task_type in out nocopy tytbLD_co_un_task_type
  );

  PROCEDURE delRecord
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_co_un_task_type in out nocopy tytbLD_co_un_task_type,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_co_un_task_type in styLD_co_un_task_type,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_co_un_task_type in out nocopy tytbLD_co_un_task_type,
    inuLock in number default 1
  );

    PROCEDURE updConstruct_Unit_Id
    (
        inuCo_Un_Task_Type_Id   in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
        inuConstruct_Unit_Id$  in LD_co_un_task_type.Construct_Unit_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updTask_Type_Id
    (
        inuCo_Un_Task_Type_Id   in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
        inuTask_Type_Id$  in LD_co_un_task_type.Task_Type_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCo_Un_Task_Type_Id
      (
          inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_co_un_task_type.Co_Un_Task_Type_Id%type;

      FUNCTION fnuGetConstruct_Unit_Id
      (
          inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_co_un_task_type.Construct_Unit_Id%type;

      FUNCTION fnuGetTask_Type_Id
      (
          inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_co_un_task_type.Task_Type_Id%type;


  PROCEDURE LockByPk
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    orcLD_co_un_task_type  out styLD_co_un_task_type
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_co_un_task_type  out styLD_co_un_task_type
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_co_un_task_type;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_co_un_task_type
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CO_UN_TASK_TYPE';
    cnuGeEntityId constant varchar2(30) := 8334; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  IS
    SELECT LD_co_un_task_type.*,LD_co_un_task_type.rowid
    FROM LD_co_un_task_type
    WHERE  Co_Un_Task_Type_Id = inuCo_Un_Task_Type_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_co_un_task_type.*,LD_co_un_task_type.rowid
    FROM LD_co_un_task_type
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_co_un_task_type is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_co_un_task_type;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_co_un_task_type default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Co_Un_Task_Type_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    orcLD_co_un_task_type  out styLD_co_un_task_type
  )
  IS
    rcError styLD_co_un_task_type;
  BEGIN
    rcError.Co_Un_Task_Type_Id := inuCo_Un_Task_Type_Id;

    Open cuLockRcByPk
    (
      inuCo_Un_Task_Type_Id
    );

    fetch cuLockRcByPk into orcLD_co_un_task_type;
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
    orcLD_co_un_task_type  out styLD_co_un_task_type
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_co_un_task_type;
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
    itbLD_co_un_task_type  in out nocopy tytbLD_co_un_task_type
  )
  IS
  BEGIN
      rcRecOfTab.Co_Un_Task_Type_Id.delete;
      rcRecOfTab.Construct_Unit_Id.delete;
      rcRecOfTab.Task_Type_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_co_un_task_type  in out nocopy tytbLD_co_un_task_type,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_co_un_task_type);
    for n in itbLD_co_un_task_type.first .. itbLD_co_un_task_type.last loop
      rcRecOfTab.Co_Un_Task_Type_Id(n) := itbLD_co_un_task_type(n).Co_Un_Task_Type_Id;
      rcRecOfTab.Construct_Unit_Id(n) := itbLD_co_un_task_type(n).Construct_Unit_Id;
      rcRecOfTab.Task_Type_Id(n) := itbLD_co_un_task_type(n).Task_Type_Id;
      rcRecOfTab.row_id(n) := itbLD_co_un_task_type(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCo_Un_Task_Type_Id
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
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCo_Un_Task_Type_Id = rcData.Co_Un_Task_Type_Id
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
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCo_Un_Task_Type_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  IS
    rcError styLD_co_un_task_type;
  BEGIN    rcError.Co_Un_Task_Type_Id:=inuCo_Un_Task_Type_Id;

    Load
    (
      inuCo_Un_Task_Type_Id
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
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCo_Un_Task_Type_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    orcRecord out nocopy styLD_co_un_task_type
  )
  IS
    rcError styLD_co_un_task_type;
  BEGIN    rcError.Co_Un_Task_Type_Id:=inuCo_Un_Task_Type_Id;

    Load
    (
      inuCo_Un_Task_Type_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN styLD_co_un_task_type
  IS
    rcError styLD_co_un_task_type;
  BEGIN
    rcError.Co_Un_Task_Type_Id:=inuCo_Un_Task_Type_Id;

    Load
    (
      inuCo_Un_Task_Type_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type
  )
  RETURN styLD_co_un_task_type
  IS
    rcError styLD_co_un_task_type;
  BEGIN
    rcError.Co_Un_Task_Type_Id:=inuCo_Un_Task_Type_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCo_Un_Task_Type_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCo_Un_Task_Type_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_co_un_task_type
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_co_un_task_type
  )
  IS
    rfLD_co_un_task_type tyrfLD_co_un_task_type;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_co_un_task_type.Co_Un_Task_Type_Id,
                LD_co_un_task_type.Construct_Unit_Id,
                LD_co_un_task_type.Task_Type_Id,
                LD_co_un_task_type.rowid
                FROM LD_co_un_task_type';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_co_un_task_type for sbFullQuery;
    fetch rfLD_co_un_task_type bulk collect INTO otbResult;
    close rfLD_co_un_task_type;
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
                LD_co_un_task_type.Co_Un_Task_Type_Id,
                LD_co_un_task_type.Construct_Unit_Id,
                LD_co_un_task_type.Task_Type_Id,
                LD_co_un_task_type.rowid
                FROM LD_co_un_task_type';
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
    ircLD_co_un_task_type in styLD_co_un_task_type
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_co_un_task_type,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_co_un_task_type in styLD_co_un_task_type,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_co_un_task_type.Co_Un_Task_Type_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Co_Un_Task_Type_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_co_un_task_type
    (
      Co_Un_Task_Type_Id,
      Construct_Unit_Id,
      Task_Type_Id
    )
    values
    (
      ircLD_co_un_task_type.Co_Un_Task_Type_Id,
      ircLD_co_un_task_type.Construct_Unit_Id,
      ircLD_co_un_task_type.Task_Type_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_co_un_task_type));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_co_un_task_type in out nocopy tytbLD_co_un_task_type
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_co_un_task_type, blUseRowID);
    forall n in iotbLD_co_un_task_type.first..iotbLD_co_un_task_type.last
      insert into LD_co_un_task_type
      (
      Co_Un_Task_Type_Id,
      Construct_Unit_Id,
      Task_Type_Id
    )
    values
    (
      rcRecOfTab.Co_Un_Task_Type_Id(n),
      rcRecOfTab.Construct_Unit_Id(n),
      rcRecOfTab.Task_Type_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_co_un_task_type;
  BEGIN
    rcError.Co_Un_Task_Type_Id:=inuCo_Un_Task_Type_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCo_Un_Task_Type_Id,
        rcData
      );
    end if;

    delete
    from LD_co_un_task_type
    where
           Co_Un_Task_Type_Id=inuCo_Un_Task_Type_Id;
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
    rcError  styLD_co_un_task_type;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_co_un_task_type
    where
      rowid = iriRowID
    returning
   Co_Un_Task_Type_Id
    into
      rcError.Co_Un_Task_Type_Id;

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
    iotbLD_co_un_task_type in out nocopy tytbLD_co_un_task_type,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_co_un_task_type;
  BEGIN
    FillRecordOfTables(iotbLD_co_un_task_type, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last
        delete
        from LD_co_un_task_type
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last loop
          LockByPk
          (
              rcRecOfTab.Co_Un_Task_Type_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last
        delete
        from LD_co_un_task_type
        where
               Co_Un_Task_Type_Id = rcRecOfTab.Co_Un_Task_Type_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_co_un_task_type in styLD_co_un_task_type,
    inuLock    in number default 0
  )
  IS
    nuCo_Un_Task_Type_Id LD_co_un_task_type.Co_Un_Task_Type_Id%type;

  BEGIN
    if ircLD_co_un_task_type.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_co_un_task_type.rowid,rcData);
      end if;
      update LD_co_un_task_type
      set

        Construct_Unit_Id = ircLD_co_un_task_type.Construct_Unit_Id,
        Task_Type_Id = ircLD_co_un_task_type.Task_Type_Id
      where
        rowid = ircLD_co_un_task_type.rowid
      returning
    Co_Un_Task_Type_Id
      into
        nuCo_Un_Task_Type_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_co_un_task_type.Co_Un_Task_Type_Id,
          rcData
        );
      end if;

      update LD_co_un_task_type
      set
        Construct_Unit_Id = ircLD_co_un_task_type.Construct_Unit_Id,
        Task_Type_Id = ircLD_co_un_task_type.Task_Type_Id
      where
             Co_Un_Task_Type_Id = ircLD_co_un_task_type.Co_Un_Task_Type_Id
      returning
    Co_Un_Task_Type_Id
      into
        nuCo_Un_Task_Type_Id;
    end if;

    if
      nuCo_Un_Task_Type_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_co_un_task_type));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_co_un_task_type in out nocopy tytbLD_co_un_task_type,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_co_un_task_type;
  BEGIN
    FillRecordOfTables(iotbLD_co_un_task_type,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last
        update LD_co_un_task_type
        set

            Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
            Task_Type_Id = rcRecOfTab.Task_Type_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last loop
          LockByPk
          (
              rcRecOfTab.Co_Un_Task_Type_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_co_un_task_type.first .. iotbLD_co_un_task_type.last
        update LD_co_un_task_type
        set
          Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
          Task_Type_Id = rcRecOfTab.Task_Type_Id(n)
          where
          Co_Un_Task_Type_Id = rcRecOfTab.Co_Un_Task_Type_Id(n)
;
    end if;
  END;

  PROCEDURE updConstruct_Unit_Id
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuConstruct_Unit_Id$ in LD_co_un_task_type.Construct_Unit_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_co_un_task_type;
  BEGIN
    rcError.Co_Un_Task_Type_Id := inuCo_Un_Task_Type_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCo_Un_Task_Type_Id,
        rcData
      );
    end if;

    update LD_co_un_task_type
    set
      Construct_Unit_Id = inuConstruct_Unit_Id$
    where
      Co_Un_Task_Type_Id = inuCo_Un_Task_Type_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Construct_Unit_Id:= inuConstruct_Unit_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTask_Type_Id
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuTask_Type_Id$ in LD_co_un_task_type.Task_Type_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_co_un_task_type;
  BEGIN
    rcError.Co_Un_Task_Type_Id := inuCo_Un_Task_Type_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCo_Un_Task_Type_Id,
        rcData
      );
    end if;

    update LD_co_un_task_type
    set
      Task_Type_Id = inuTask_Type_Id$
    where
      Co_Un_Task_Type_Id = inuCo_Un_Task_Type_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Task_Type_Id:= inuTask_Type_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCo_Un_Task_Type_Id
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_co_un_task_type.Co_Un_Task_Type_Id%type
  IS
    rcError styLD_co_un_task_type;
  BEGIN

    rcError.Co_Un_Task_Type_Id := inuCo_Un_Task_Type_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCo_Un_Task_Type_Id
       )
    then
       return(rcData.Co_Un_Task_Type_Id);
    end if;
    Load
    (
      inuCo_Un_Task_Type_Id
    );
    return(rcData.Co_Un_Task_Type_Id);
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
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_co_un_task_type.Construct_Unit_Id%type
  IS
    rcError styLD_co_un_task_type;
  BEGIN

    rcError.Co_Un_Task_Type_Id := inuCo_Un_Task_Type_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCo_Un_Task_Type_Id
       )
    then
       return(rcData.Construct_Unit_Id);
    end if;
    Load
    (
      inuCo_Un_Task_Type_Id
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

  FUNCTION fnuGetTask_Type_Id
  (
    inuCo_Un_Task_Type_Id in LD_co_un_task_type.Co_Un_Task_Type_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_co_un_task_type.Task_Type_Id%type
  IS
    rcError styLD_co_un_task_type;
  BEGIN

    rcError.Co_Un_Task_Type_Id := inuCo_Un_Task_Type_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCo_Un_Task_Type_Id
       )
    then
       return(rcData.Task_Type_Id);
    end if;
    Load
    (
      inuCo_Un_Task_Type_Id
    );
    return(rcData.Task_Type_Id);
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
end DALD_co_un_task_type;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CO_UN_TASK_TYPE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CO_UN_TASK_TYPE', 'ADM_PERSON'); 
END;
/