CREATE OR REPLACE PACKAGE adm_person.dald_exec_meth
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_exec_meth
Descripcion	 : Paquete para la gestión de la entidad LD_exec_meth (ejecución de proceso BATCH)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
04/06/2024             Adrianavg           OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  IS
    SELECT LD_exec_meth.*,LD_exec_meth.rowid
    FROM LD_exec_meth
    WHERE
      Exec_Meth_Id = inuExec_Meth_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_exec_meth.*,LD_exec_meth.rowid
    FROM LD_exec_meth
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_exec_meth  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_exec_meth is table of styLD_exec_meth index by binary_integer;
  type tyrfRecords is ref cursor return styLD_exec_meth;

  /* Tipos referenciando al registro */
  type tytbExec_Meth_Id is table of LD_exec_meth.Exec_Meth_Id%type index by binary_integer;
  type tytbMeth_Id is table of LD_exec_meth.Meth_Id%type index by binary_integer;
  type tytbExecute_Date is table of LD_exec_meth.Execute_Date%type index by binary_integer;
  type tytbState is table of LD_exec_meth.State%type index by binary_integer;
  type tytbDescription is table of LD_exec_meth.Description%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_exec_meth is record
  (

    Exec_Meth_Id   tytbExec_Meth_Id,
    Meth_Id   tytbMeth_Id,
    Execute_Date   tytbExecute_Date,
    State   tytbState,
    Description   tytbDescription,
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
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  );

  PROCEDURE getRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    orcRecord out nocopy styLD_exec_meth
  );

  FUNCTION frcGetRcData
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN styLD_exec_meth;

  FUNCTION frcGetRcData
  RETURN styLD_exec_meth;

  FUNCTION frcGetRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN styLD_exec_meth;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_exec_meth
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_exec_meth in styLD_exec_meth
  );

     PROCEDURE insRecord
  (
    ircLD_exec_meth in styLD_exec_meth,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_exec_meth in out nocopy tytbLD_exec_meth
  );

  PROCEDURE delRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_exec_meth in out nocopy tytbLD_exec_meth,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_exec_meth in styLD_exec_meth,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_exec_meth in out nocopy tytbLD_exec_meth,
    inuLock in number default 1
  );

    PROCEDURE updMeth_Id
    (
        inuExec_Meth_Id   in LD_exec_meth.Exec_Meth_Id%type,
        inuMeth_Id$  in LD_exec_meth.Meth_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updExecute_Date
    (
        inuExec_Meth_Id   in LD_exec_meth.Exec_Meth_Id%type,
        idtExecute_Date$  in LD_exec_meth.Execute_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updState
    (
        inuExec_Meth_Id   in LD_exec_meth.Exec_Meth_Id%type,
        isbState$  in LD_exec_meth.State%type,
        inuLock    in number default 0
      );

    PROCEDURE updDescription
    (
        inuExec_Meth_Id   in LD_exec_meth.Exec_Meth_Id%type,
        isbDescription$  in LD_exec_meth.Description%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetExec_Meth_Id
      (
          inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_exec_meth.Exec_Meth_Id%type;

      FUNCTION fnuGetMeth_Id
      (
          inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_exec_meth.Meth_Id%type;

      FUNCTION fdtGetExecute_Date
      (
          inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_exec_meth.Execute_Date%type;

      FUNCTION fsbGetState
      (
          inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_exec_meth.State%type;

      FUNCTION fsbGetDescription
      (
          inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_exec_meth.Description%type;


  PROCEDURE LockByPk
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    orcLD_exec_meth  out styLD_exec_meth
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_exec_meth  out styLD_exec_meth
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_exec_meth;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_exec_meth
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_EXEC_METH';
    cnuGeEntityId constant varchar2(30) := 8472; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  IS
    SELECT LD_exec_meth.*,LD_exec_meth.rowid
    FROM LD_exec_meth
    WHERE  Exec_Meth_Id = inuExec_Meth_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_exec_meth.*,LD_exec_meth.rowid
    FROM LD_exec_meth
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_exec_meth is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_exec_meth;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_exec_meth default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Exec_Meth_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    orcLD_exec_meth  out styLD_exec_meth
  )
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id := inuExec_Meth_Id;

    Open cuLockRcByPk
    (
      inuExec_Meth_Id
    );

    fetch cuLockRcByPk into orcLD_exec_meth;
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
    orcLD_exec_meth  out styLD_exec_meth
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_exec_meth;
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
    itbLD_exec_meth  in out nocopy tytbLD_exec_meth
  )
  IS
  BEGIN
      rcRecOfTab.Exec_Meth_Id.delete;
      rcRecOfTab.Meth_Id.delete;
      rcRecOfTab.Execute_Date.delete;
      rcRecOfTab.State.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_exec_meth  in out nocopy tytbLD_exec_meth,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_exec_meth);
    for n in itbLD_exec_meth.first .. itbLD_exec_meth.last loop
      rcRecOfTab.Exec_Meth_Id(n) := itbLD_exec_meth(n).Exec_Meth_Id;
      rcRecOfTab.Meth_Id(n) := itbLD_exec_meth(n).Meth_Id;
      rcRecOfTab.Execute_Date(n) := itbLD_exec_meth(n).Execute_Date;
      rcRecOfTab.State(n) := itbLD_exec_meth(n).State;
      rcRecOfTab.Description(n) := itbLD_exec_meth(n).Description;
      rcRecOfTab.row_id(n) := itbLD_exec_meth(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuExec_Meth_Id
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
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuExec_Meth_Id = rcData.Exec_Meth_Id
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
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuExec_Meth_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  IS
    rcError styLD_exec_meth;
  BEGIN    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    Load
    (
      inuExec_Meth_Id
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
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuExec_Meth_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    orcRecord out nocopy styLD_exec_meth
  )
  IS
    rcError styLD_exec_meth;
  BEGIN    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    Load
    (
      inuExec_Meth_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN styLD_exec_meth
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    Load
    (
      inuExec_Meth_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type
  )
  RETURN styLD_exec_meth
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id:=inuExec_Meth_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuExec_Meth_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuExec_Meth_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_exec_meth
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_exec_meth
  )
  IS
    rfLD_exec_meth tyrfLD_exec_meth;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_exec_meth.Exec_Meth_Id,
                LD_exec_meth.Meth_Id,
                LD_exec_meth.Execute_Date,
                LD_exec_meth.State,
                LD_exec_meth.Description,
                LD_exec_meth.rowid
                FROM LD_exec_meth';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_exec_meth for sbFullQuery;
    fetch rfLD_exec_meth bulk collect INTO otbResult;
    close rfLD_exec_meth;
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
                LD_exec_meth.Exec_Meth_Id,
                LD_exec_meth.Meth_Id,
                LD_exec_meth.Execute_Date,
                LD_exec_meth.State,
                LD_exec_meth.Description,
                LD_exec_meth.rowid
                FROM LD_exec_meth';
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
    ircLD_exec_meth in styLD_exec_meth
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_exec_meth,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_exec_meth in styLD_exec_meth,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_exec_meth.Exec_Meth_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Exec_Meth_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_exec_meth
    (
      Exec_Meth_Id,
      Meth_Id,
      Execute_Date,
      State,
      Description
    )
    values
    (
      ircLD_exec_meth.Exec_Meth_Id,
      ircLD_exec_meth.Meth_Id,
      ircLD_exec_meth.Execute_Date,
      ircLD_exec_meth.State,
      ircLD_exec_meth.Description
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_exec_meth));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_exec_meth in out nocopy tytbLD_exec_meth
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_exec_meth, blUseRowID);
    forall n in iotbLD_exec_meth.first..iotbLD_exec_meth.last
      insert into LD_exec_meth
      (
      Exec_Meth_Id,
      Meth_Id,
      Execute_Date,
      State,
      Description
    )
    values
    (
      rcRecOfTab.Exec_Meth_Id(n),
      rcRecOfTab.Meth_Id(n),
      rcRecOfTab.Execute_Date(n),
      rcRecOfTab.State(n),
      rcRecOfTab.Description(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    if inuLock=1 then
      LockByPk
      (
        inuExec_Meth_Id,
        rcData
      );
    end if;

    delete
    from LD_exec_meth
    where
           Exec_Meth_Id=inuExec_Meth_Id;
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
    rcError  styLD_exec_meth;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_exec_meth
    where
      rowid = iriRowID
    returning
   Exec_Meth_Id
    into
      rcError.Exec_Meth_Id;

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
    iotbLD_exec_meth in out nocopy tytbLD_exec_meth,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_exec_meth;
  BEGIN
    FillRecordOfTables(iotbLD_exec_meth, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last
        delete
        from LD_exec_meth
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last loop
          LockByPk
          (
              rcRecOfTab.Exec_Meth_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last
        delete
        from LD_exec_meth
        where
               Exec_Meth_Id = rcRecOfTab.Exec_Meth_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_exec_meth in styLD_exec_meth,
    inuLock    in number default 0
  )
  IS
    nuExec_Meth_Id LD_exec_meth.Exec_Meth_Id%type;

  BEGIN
    if ircLD_exec_meth.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_exec_meth.rowid,rcData);
      end if;
      update LD_exec_meth
      set

        Meth_Id = ircLD_exec_meth.Meth_Id,
        Execute_Date = ircLD_exec_meth.Execute_Date,
        State = ircLD_exec_meth.State,
        Description = ircLD_exec_meth.Description
      where
        rowid = ircLD_exec_meth.rowid
      returning
    Exec_Meth_Id
      into
        nuExec_Meth_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_exec_meth.Exec_Meth_Id,
          rcData
        );
      end if;

      update LD_exec_meth
      set
        Meth_Id = ircLD_exec_meth.Meth_Id,
        Execute_Date = ircLD_exec_meth.Execute_Date,
        State = ircLD_exec_meth.State,
        Description = ircLD_exec_meth.Description
      where
             Exec_Meth_Id = ircLD_exec_meth.Exec_Meth_Id
      returning
    Exec_Meth_Id
      into
        nuExec_Meth_Id;
    end if;

    if
      nuExec_Meth_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_exec_meth));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_exec_meth in out nocopy tytbLD_exec_meth,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_exec_meth;
  BEGIN
    FillRecordOfTables(iotbLD_exec_meth,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last
        update LD_exec_meth
        set

            Meth_Id = rcRecOfTab.Meth_Id(n),
            Execute_Date = rcRecOfTab.Execute_Date(n),
            State = rcRecOfTab.State(n),
            Description = rcRecOfTab.Description(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last loop
          LockByPk
          (
              rcRecOfTab.Exec_Meth_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_exec_meth.first .. iotbLD_exec_meth.last
        update LD_exec_meth
        set
          Meth_Id = rcRecOfTab.Meth_Id(n),
          Execute_Date = rcRecOfTab.Execute_Date(n),
          State = rcRecOfTab.State(n),
          Description = rcRecOfTab.Description(n)
          where
          Exec_Meth_Id = rcRecOfTab.Exec_Meth_Id(n)
;
    end if;
  END;

  PROCEDURE updMeth_Id
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuMeth_Id$ in LD_exec_meth.Meth_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id := inuExec_Meth_Id;
    if inuLock=1 then
      LockByPk
      (
        inuExec_Meth_Id,
        rcData
      );
    end if;

    update LD_exec_meth
    set
      Meth_Id = inuMeth_Id$
    where
      Exec_Meth_Id = inuExec_Meth_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Meth_Id:= inuMeth_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updExecute_Date
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    idtExecute_Date$ in LD_exec_meth.Execute_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id := inuExec_Meth_Id;
    if inuLock=1 then
      LockByPk
      (
        inuExec_Meth_Id,
        rcData
      );
    end if;

    update LD_exec_meth
    set
      Execute_Date = idtExecute_Date$
    where
      Exec_Meth_Id = inuExec_Meth_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Execute_Date:= idtExecute_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updState
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    isbState$ in LD_exec_meth.State%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id := inuExec_Meth_Id;
    if inuLock=1 then
      LockByPk
      (
        inuExec_Meth_Id,
        rcData
      );
    end if;

    update LD_exec_meth
    set
      State = isbState$
    where
      Exec_Meth_Id = inuExec_Meth_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.State:= isbState$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDescription
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    isbDescription$ in LD_exec_meth.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_exec_meth;
  BEGIN
    rcError.Exec_Meth_Id := inuExec_Meth_Id;
    if inuLock=1 then
      LockByPk
      (
        inuExec_Meth_Id,
        rcData
      );
    end if;

    update LD_exec_meth
    set
      Description = isbDescription$
    where
      Exec_Meth_Id = inuExec_Meth_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetExec_Meth_Id
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_exec_meth.Exec_Meth_Id%type
  IS
    rcError styLD_exec_meth;
  BEGIN

    rcError.Exec_Meth_Id := inuExec_Meth_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuExec_Meth_Id
       )
    then
       return(rcData.Exec_Meth_Id);
    end if;
    Load
    (
      inuExec_Meth_Id
    );
    return(rcData.Exec_Meth_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetMeth_Id
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_exec_meth.Meth_Id%type
  IS
    rcError styLD_exec_meth;
  BEGIN

    rcError.Exec_Meth_Id := inuExec_Meth_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuExec_Meth_Id
       )
    then
       return(rcData.Meth_Id);
    end if;
    Load
    (
      inuExec_Meth_Id
    );
    return(rcData.Meth_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetExecute_Date
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_exec_meth.Execute_Date%type
  IS
    rcError styLD_exec_meth;
  BEGIN

    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuExec_Meth_Id
       )
    then
       return(rcData.Execute_Date);
    end if;
    Load
    (
         inuExec_Meth_Id
    );
    return(rcData.Execute_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetState
  (
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_exec_meth.State%type
  IS
    rcError styLD_exec_meth;
  BEGIN

    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuExec_Meth_Id
       )
    then
       return(rcData.State);
    end if;
    Load
    (
      inuExec_Meth_Id
    );
    return(rcData.State);
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
    inuExec_Meth_Id in LD_exec_meth.Exec_Meth_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_exec_meth.Description%type
  IS
    rcError styLD_exec_meth;
  BEGIN

    rcError.Exec_Meth_Id:=inuExec_Meth_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuExec_Meth_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuExec_Meth_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_exec_meth;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_EXEC_METH
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_EXEC_METH', 'ADM_PERSON'); 
END;
/  
