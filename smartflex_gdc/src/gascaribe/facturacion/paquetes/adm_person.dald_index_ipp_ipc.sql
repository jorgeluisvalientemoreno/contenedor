CREATE OR REPLACE PACKAGE adm_person.dald_index_ipp_ipc
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_index_ipp_ipc
Descripcion	 : Paquete para la gestión de la entidad LD_index_ipp_ipc (Indices de precios ipp - ipc)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
11/06/2024            Adrianavg           OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  IS
    SELECT LD_index_ipp_ipc.*,LD_index_ipp_ipc.rowid
    FROM LD_index_ipp_ipc
    WHERE
      Index_Ipp_Ipc_Id = inuIndex_Ipp_Ipc_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_index_ipp_ipc.*,LD_index_ipp_ipc.rowid
    FROM LD_index_ipp_ipc
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_index_ipp_ipc  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_index_ipp_ipc is table of styLD_index_ipp_ipc index by binary_integer;
  type tyrfRecords is ref cursor return styLD_index_ipp_ipc;

  /* Tipos referenciando al registro */
  type tytbIndex_Ipp_Ipc_Id is table of LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type index by binary_integer;
  type tytbYear is table of LD_index_ipp_ipc.Year%type index by binary_integer;
  type tytbMonth is table of LD_index_ipp_ipc.Month%type index by binary_integer;
  type tytbIpp is table of LD_index_ipp_ipc.Ipp%type index by binary_integer;
  type tytbIpc is table of LD_index_ipp_ipc.Ipc%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_index_ipp_ipc is record
  (

    Index_Ipp_Ipc_Id   tytbIndex_Ipp_Ipc_Id,
    Year   tytbYear,
    Month   tytbMonth,
    Ipp   tytbIpp,
    Ipc   tytbIpc,
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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  );

  PROCEDURE getRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    orcRecord out nocopy styLD_index_ipp_ipc
  );

  FUNCTION frcGetRcData
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN styLD_index_ipp_ipc;

  FUNCTION frcGetRcData
  RETURN styLD_index_ipp_ipc;

  FUNCTION frcGetRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN styLD_index_ipp_ipc;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_index_ipp_ipc
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_index_ipp_ipc in styLD_index_ipp_ipc
  );

     PROCEDURE insRecord
  (
    ircLD_index_ipp_ipc in styLD_index_ipp_ipc,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_index_ipp_ipc in out nocopy tytbLD_index_ipp_ipc
  );

  PROCEDURE delRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_index_ipp_ipc in out nocopy tytbLD_index_ipp_ipc,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_index_ipp_ipc in styLD_index_ipp_ipc,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_index_ipp_ipc in out nocopy tytbLD_index_ipp_ipc,
    inuLock in number default 1
  );

    PROCEDURE updYear
    (
        inuIndex_Ipp_Ipc_Id   in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
        inuYear$  in LD_index_ipp_ipc.Year%type,
        inuLock    in number default 0
      );

    PROCEDURE updMonth
    (
        inuIndex_Ipp_Ipc_Id   in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
        inuMonth$  in LD_index_ipp_ipc.Month%type,
        inuLock    in number default 0
      );

    PROCEDURE updIpp
    (
        inuIndex_Ipp_Ipc_Id   in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
        inuIpp$  in LD_index_ipp_ipc.Ipp%type,
        inuLock    in number default 0
      );

    PROCEDURE updIpc
    (
        inuIndex_Ipp_Ipc_Id   in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
        inuIpc$  in LD_index_ipp_ipc.Ipc%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetIndex_Ipp_Ipc_Id
      (
          inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type;

      FUNCTION fnuGetYear
      (
          inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_index_ipp_ipc.Year%type;

      FUNCTION fnuGetMonth
      (
          inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_index_ipp_ipc.Month%type;

      FUNCTION fnuGetIpp
      (
          inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_index_ipp_ipc.Ipp%type;

      FUNCTION fnuGetIpc
      (
          inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_index_ipp_ipc.Ipc%type;


  PROCEDURE LockByPk
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    orcLD_index_ipp_ipc  out styLD_index_ipp_ipc
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_index_ipp_ipc  out styLD_index_ipp_ipc
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_index_ipp_ipc;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_index_ipp_ipc
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_INDEX_IPP_IPC';
    cnuGeEntityId constant varchar2(30) := 8339; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  IS
    SELECT LD_index_ipp_ipc.*,LD_index_ipp_ipc.rowid
    FROM LD_index_ipp_ipc
    WHERE  Index_Ipp_Ipc_Id = inuIndex_Ipp_Ipc_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_index_ipp_ipc.*,LD_index_ipp_ipc.rowid
    FROM LD_index_ipp_ipc
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_index_ipp_ipc is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_index_ipp_ipc;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_index_ipp_ipc default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Index_Ipp_Ipc_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    orcLD_index_ipp_ipc  out styLD_index_ipp_ipc
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;

    Open cuLockRcByPk
    (
      inuIndex_Ipp_Ipc_Id
    );

    fetch cuLockRcByPk into orcLD_index_ipp_ipc;
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
    orcLD_index_ipp_ipc  out styLD_index_ipp_ipc
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_index_ipp_ipc;
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
    itbLD_index_ipp_ipc  in out nocopy tytbLD_index_ipp_ipc
  )
  IS
  BEGIN
      rcRecOfTab.Index_Ipp_Ipc_Id.delete;
      rcRecOfTab.Year.delete;
      rcRecOfTab.Month.delete;
      rcRecOfTab.Ipp.delete;
      rcRecOfTab.Ipc.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_index_ipp_ipc  in out nocopy tytbLD_index_ipp_ipc,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_index_ipp_ipc);
    for n in itbLD_index_ipp_ipc.first .. itbLD_index_ipp_ipc.last loop
      rcRecOfTab.Index_Ipp_Ipc_Id(n) := itbLD_index_ipp_ipc(n).Index_Ipp_Ipc_Id;
      rcRecOfTab.Year(n) := itbLD_index_ipp_ipc(n).Year;
      rcRecOfTab.Month(n) := itbLD_index_ipp_ipc(n).Month;
      rcRecOfTab.Ipp(n) := itbLD_index_ipp_ipc(n).Ipp;
      rcRecOfTab.Ipc(n) := itbLD_index_ipp_ipc(n).Ipc;
      rcRecOfTab.row_id(n) := itbLD_index_ipp_ipc(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuIndex_Ipp_Ipc_Id
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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuIndex_Ipp_Ipc_Id = rcData.Index_Ipp_Ipc_Id
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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN    rcError.Index_Ipp_Ipc_Id:=inuIndex_Ipp_Ipc_Id;

    Load
    (
      inuIndex_Ipp_Ipc_Id
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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    orcRecord out nocopy styLD_index_ipp_ipc
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN    rcError.Index_Ipp_Ipc_Id:=inuIndex_Ipp_Ipc_Id;

    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN styLD_index_ipp_ipc
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id:=inuIndex_Ipp_Ipc_Id;

    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  )
  RETURN styLD_index_ipp_ipc
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id:=inuIndex_Ipp_Ipc_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuIndex_Ipp_Ipc_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_index_ipp_ipc
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_index_ipp_ipc
  )
  IS
    rfLD_index_ipp_ipc tyrfLD_index_ipp_ipc;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_index_ipp_ipc.Index_Ipp_Ipc_Id,
                LD_index_ipp_ipc.Year,
                LD_index_ipp_ipc.Month,
                LD_index_ipp_ipc.Ipp,
                LD_index_ipp_ipc.Ipc,
                LD_index_ipp_ipc.rowid
                FROM LD_index_ipp_ipc';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_index_ipp_ipc for sbFullQuery;
    fetch rfLD_index_ipp_ipc bulk collect INTO otbResult;
    close rfLD_index_ipp_ipc;
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
                LD_index_ipp_ipc.Index_Ipp_Ipc_Id,
                LD_index_ipp_ipc.Year,
                LD_index_ipp_ipc.Month,
                LD_index_ipp_ipc.Ipp,
                LD_index_ipp_ipc.Ipc,
                LD_index_ipp_ipc.rowid
                FROM LD_index_ipp_ipc';
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
    ircLD_index_ipp_ipc in styLD_index_ipp_ipc
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_index_ipp_ipc,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_index_ipp_ipc in styLD_index_ipp_ipc,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_index_ipp_ipc.Index_Ipp_Ipc_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Index_Ipp_Ipc_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_index_ipp_ipc
    (
      Index_Ipp_Ipc_Id,
      Year,
      Month,
      Ipp,
      Ipc
    )
    values
    (
      ircLD_index_ipp_ipc.Index_Ipp_Ipc_Id,
      ircLD_index_ipp_ipc.Year,
      ircLD_index_ipp_ipc.Month,
      ircLD_index_ipp_ipc.Ipp,
      ircLD_index_ipp_ipc.Ipc
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_index_ipp_ipc));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_index_ipp_ipc in out nocopy tytbLD_index_ipp_ipc
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_index_ipp_ipc, blUseRowID);
    forall n in iotbLD_index_ipp_ipc.first..iotbLD_index_ipp_ipc.last
      insert into LD_index_ipp_ipc
      (
      Index_Ipp_Ipc_Id,
      Year,
      Month,
      Ipp,
      Ipc
    )
    values
    (
      rcRecOfTab.Index_Ipp_Ipc_Id(n),
      rcRecOfTab.Year(n),
      rcRecOfTab.Month(n),
      rcRecOfTab.Ipp(n),
      rcRecOfTab.Ipc(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id:=inuIndex_Ipp_Ipc_Id;

    if inuLock=1 then
      LockByPk
      (
        inuIndex_Ipp_Ipc_Id,
        rcData
      );
    end if;

    delete
    from LD_index_ipp_ipc
    where
           Index_Ipp_Ipc_Id=inuIndex_Ipp_Ipc_Id;
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
    rcError  styLD_index_ipp_ipc;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_index_ipp_ipc
    where
      rowid = iriRowID
    returning
   Index_Ipp_Ipc_Id
    into
      rcError.Index_Ipp_Ipc_Id;

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
    iotbLD_index_ipp_ipc in out nocopy tytbLD_index_ipp_ipc,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_index_ipp_ipc;
  BEGIN
    FillRecordOfTables(iotbLD_index_ipp_ipc, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last
        delete
        from LD_index_ipp_ipc
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last loop
          LockByPk
          (
              rcRecOfTab.Index_Ipp_Ipc_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last
        delete
        from LD_index_ipp_ipc
        where
               Index_Ipp_Ipc_Id = rcRecOfTab.Index_Ipp_Ipc_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_index_ipp_ipc in styLD_index_ipp_ipc,
    inuLock    in number default 0
  )
  IS
    nuIndex_Ipp_Ipc_Id LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type;

  BEGIN
    if ircLD_index_ipp_ipc.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_index_ipp_ipc.rowid,rcData);
      end if;
      update LD_index_ipp_ipc
      set

        Year = ircLD_index_ipp_ipc.Year,
        Month = ircLD_index_ipp_ipc.Month,
        Ipp = ircLD_index_ipp_ipc.Ipp,
        Ipc = ircLD_index_ipp_ipc.Ipc
      where
        rowid = ircLD_index_ipp_ipc.rowid
      returning
    Index_Ipp_Ipc_Id
      into
        nuIndex_Ipp_Ipc_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_index_ipp_ipc.Index_Ipp_Ipc_Id,
          rcData
        );
      end if;

      update LD_index_ipp_ipc
      set
        Year = ircLD_index_ipp_ipc.Year,
        Month = ircLD_index_ipp_ipc.Month,
        Ipp = ircLD_index_ipp_ipc.Ipp,
        Ipc = ircLD_index_ipp_ipc.Ipc
      where
             Index_Ipp_Ipc_Id = ircLD_index_ipp_ipc.Index_Ipp_Ipc_Id
      returning
    Index_Ipp_Ipc_Id
      into
        nuIndex_Ipp_Ipc_Id;
    end if;

    if
      nuIndex_Ipp_Ipc_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_index_ipp_ipc));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_index_ipp_ipc in out nocopy tytbLD_index_ipp_ipc,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_index_ipp_ipc;
  BEGIN
    FillRecordOfTables(iotbLD_index_ipp_ipc,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last
        update LD_index_ipp_ipc
        set

            Year = rcRecOfTab.Year(n),
            Month = rcRecOfTab.Month(n),
            Ipp = rcRecOfTab.Ipp(n),
            Ipc = rcRecOfTab.Ipc(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last loop
          LockByPk
          (
              rcRecOfTab.Index_Ipp_Ipc_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_index_ipp_ipc.first .. iotbLD_index_ipp_ipc.last
        update LD_index_ipp_ipc
        set
          Year = rcRecOfTab.Year(n),
          Month = rcRecOfTab.Month(n),
          Ipp = rcRecOfTab.Ipp(n),
          Ipc = rcRecOfTab.Ipc(n)
          where
          Index_Ipp_Ipc_Id = rcRecOfTab.Index_Ipp_Ipc_Id(n)
;
    end if;
  END;

  PROCEDURE updYear
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuYear$ in LD_index_ipp_ipc.Year%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;
    if inuLock=1 then
      LockByPk
      (
        inuIndex_Ipp_Ipc_Id,
        rcData
      );
    end if;

    update LD_index_ipp_ipc
    set
      Year = inuYear$
    where
      Index_Ipp_Ipc_Id = inuIndex_Ipp_Ipc_Id;

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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuMonth$ in LD_index_ipp_ipc.Month%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;
    if inuLock=1 then
      LockByPk
      (
        inuIndex_Ipp_Ipc_Id,
        rcData
      );
    end if;

    update LD_index_ipp_ipc
    set
      Month = inuMonth$
    where
      Index_Ipp_Ipc_Id = inuIndex_Ipp_Ipc_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Month:= inuMonth$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updIpp
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuIpp$ in LD_index_ipp_ipc.Ipp%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;
    if inuLock=1 then
      LockByPk
      (
        inuIndex_Ipp_Ipc_Id,
        rcData
      );
    end if;

    update LD_index_ipp_ipc
    set
      Ipp = inuIpp$
    where
      Index_Ipp_Ipc_Id = inuIndex_Ipp_Ipc_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ipp:= inuIpp$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updIpc
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuIpc$ in LD_index_ipp_ipc.Ipc%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN
    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;
    if inuLock=1 then
      LockByPk
      (
        inuIndex_Ipp_Ipc_Id,
        rcData
      );
    end if;

    update LD_index_ipp_ipc
    set
      Ipc = inuIpc$
    where
      Index_Ipp_Ipc_Id = inuIndex_Ipp_Ipc_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ipc:= inuIpc$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetIndex_Ipp_Ipc_Id
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN

    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuIndex_Ipp_Ipc_Id
       )
    then
       return(rcData.Index_Ipp_Ipc_Id);
    end if;
    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    return(rcData.Index_Ipp_Ipc_Id);
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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_index_ipp_ipc.Year%type
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN

    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuIndex_Ipp_Ipc_Id
       )
    then
       return(rcData.Year);
    end if;
    Load
    (
      inuIndex_Ipp_Ipc_Id
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
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_index_ipp_ipc.Month%type
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN

    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuIndex_Ipp_Ipc_Id
       )
    then
       return(rcData.Month);
    end if;
    Load
    (
      inuIndex_Ipp_Ipc_Id
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

  FUNCTION fnuGetIpp
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_index_ipp_ipc.Ipp%type
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN

    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuIndex_Ipp_Ipc_Id
       )
    then
       return(rcData.Ipp);
    end if;
    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    return(rcData.Ipp);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetIpc
  (
    inuIndex_Ipp_Ipc_Id in LD_index_ipp_ipc.Index_Ipp_Ipc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_index_ipp_ipc.Ipc%type
  IS
    rcError styLD_index_ipp_ipc;
  BEGIN

    rcError.Index_Ipp_Ipc_Id := inuIndex_Ipp_Ipc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuIndex_Ipp_Ipc_Id
       )
    then
       return(rcData.Ipc);
    end if;
    Load
    (
      inuIndex_Ipp_Ipc_Id
    );
    return(rcData.Ipc);
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
end DALD_index_ipp_ipc;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_INDEX_IPP_IPC
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_INDEX_IPP_IPC', 'ADM_PERSON'); 
END;
/
