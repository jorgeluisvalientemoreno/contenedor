CREATE OR REPLACE PACKAGE adm_person.DALD_order_cons_unit
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_mar_exp_budget
    Descripcion	 : Paquete para la gestión de la entidad LD_order_cons_unit (OTs. de Unidades Constructivas inconsistentes)
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
    31/05/2024             PAcosta            OSF-2767: Cambio de esquema ADM_PERSON  
    ****************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  IS
    SELECT LD_order_cons_unit.*,LD_order_cons_unit.rowid
    FROM LD_order_cons_unit
    WHERE
      Order_Cons_Unit_Id = inuOrder_Cons_Unit_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_order_cons_unit.*,LD_order_cons_unit.rowid
    FROM LD_order_cons_unit
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_order_cons_unit  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_order_cons_unit is table of styLD_order_cons_unit index by binary_integer;
  type tyrfRecords is ref cursor return styLD_order_cons_unit;

  /* Tipos referenciando al registro */
  type tytbOrder_Cons_Unit_Id is table of LD_order_cons_unit.Order_Cons_Unit_Id%type index by binary_integer;
  type tytbGeograp_Location_Id is table of LD_order_cons_unit.Geograp_Location_Id%type index by binary_integer;
  type tytbOrder_Id is table of LD_order_cons_unit.Order_Id%type index by binary_integer;
  type tytbOrder_Date is table of LD_order_cons_unit.Order_Date%type index by binary_integer;
  type tytbError_Of_Order is table of LD_order_cons_unit.Error_Of_Order%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_order_cons_unit is record
  (

    Order_Cons_Unit_Id   tytbOrder_Cons_Unit_Id,
    Geograp_Location_Id   tytbGeograp_Location_Id,
    Order_Id   tytbOrder_Id,
    Order_Date   tytbOrder_Date,
    Error_Of_Order   tytbError_Of_Order,
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
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  );

  PROCEDURE getRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    orcRecord out nocopy styLD_order_cons_unit
  );

  FUNCTION frcGetRcData
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN styLD_order_cons_unit;

  FUNCTION frcGetRcData
  RETURN styLD_order_cons_unit;

  FUNCTION frcGetRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN styLD_order_cons_unit;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_order_cons_unit
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_order_cons_unit in styLD_order_cons_unit
  );

     PROCEDURE insRecord
  (
    ircLD_order_cons_unit in styLD_order_cons_unit,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_order_cons_unit in out nocopy tytbLD_order_cons_unit
  );

  PROCEDURE delRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_order_cons_unit in out nocopy tytbLD_order_cons_unit,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_order_cons_unit in styLD_order_cons_unit,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_order_cons_unit in out nocopy tytbLD_order_cons_unit,
    inuLock in number default 1
  );

    PROCEDURE updGeograp_Location_Id
    (
        inuOrder_Cons_Unit_Id   in LD_order_cons_unit.Order_Cons_Unit_Id%type,
        inuGeograp_Location_Id$  in LD_order_cons_unit.Geograp_Location_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updOrder_Id
    (
        inuOrder_Cons_Unit_Id   in LD_order_cons_unit.Order_Cons_Unit_Id%type,
        inuOrder_Id$  in LD_order_cons_unit.Order_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updOrder_Date
    (
        inuOrder_Cons_Unit_Id   in LD_order_cons_unit.Order_Cons_Unit_Id%type,
        idtOrder_Date$  in LD_order_cons_unit.Order_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updError_Of_Order
    (
        inuOrder_Cons_Unit_Id   in LD_order_cons_unit.Order_Cons_Unit_Id%type,
        isbError_Of_Order$  in LD_order_cons_unit.Error_Of_Order%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetOrder_Cons_Unit_Id
      (
          inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_order_cons_unit.Order_Cons_Unit_Id%type;

      FUNCTION fnuGetGeograp_Location_Id
      (
          inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_order_cons_unit.Geograp_Location_Id%type;

      FUNCTION fnuGetOrder_Id
      (
          inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_order_cons_unit.Order_Id%type;

      FUNCTION fdtGetOrder_Date
      (
          inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_order_cons_unit.Order_Date%type;

      FUNCTION fsbGetError_Of_Order
      (
          inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_order_cons_unit.Error_Of_Order%type;


  PROCEDURE LockByPk
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    orcLD_order_cons_unit  out styLD_order_cons_unit
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_order_cons_unit  out styLD_order_cons_unit
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_order_cons_unit;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_order_cons_unit
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_ORDER_CONS_UNIT';
    cnuGeEntityId constant varchar2(30) := 8352; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  IS
    SELECT LD_order_cons_unit.*,LD_order_cons_unit.rowid
    FROM LD_order_cons_unit
    WHERE  Order_Cons_Unit_Id = inuOrder_Cons_Unit_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_order_cons_unit.*,LD_order_cons_unit.rowid
    FROM LD_order_cons_unit
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_order_cons_unit is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_order_cons_unit;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_order_cons_unit default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Order_Cons_Unit_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    orcLD_order_cons_unit  out styLD_order_cons_unit
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;

    Open cuLockRcByPk
    (
      inuOrder_Cons_Unit_Id
    );

    fetch cuLockRcByPk into orcLD_order_cons_unit;
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
    orcLD_order_cons_unit  out styLD_order_cons_unit
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_order_cons_unit;
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
    itbLD_order_cons_unit  in out nocopy tytbLD_order_cons_unit
  )
  IS
  BEGIN
      rcRecOfTab.Order_Cons_Unit_Id.delete;
      rcRecOfTab.Geograp_Location_Id.delete;
      rcRecOfTab.Order_Id.delete;
      rcRecOfTab.Order_Date.delete;
      rcRecOfTab.Error_Of_Order.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_order_cons_unit  in out nocopy tytbLD_order_cons_unit,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_order_cons_unit);
    for n in itbLD_order_cons_unit.first .. itbLD_order_cons_unit.last loop
      rcRecOfTab.Order_Cons_Unit_Id(n) := itbLD_order_cons_unit(n).Order_Cons_Unit_Id;
      rcRecOfTab.Geograp_Location_Id(n) := itbLD_order_cons_unit(n).Geograp_Location_Id;
      rcRecOfTab.Order_Id(n) := itbLD_order_cons_unit(n).Order_Id;
      rcRecOfTab.Order_Date(n) := itbLD_order_cons_unit(n).Order_Date;
      rcRecOfTab.Error_Of_Order(n) := itbLD_order_cons_unit(n).Error_Of_Order;
      rcRecOfTab.row_id(n) := itbLD_order_cons_unit(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuOrder_Cons_Unit_Id
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
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuOrder_Cons_Unit_Id = rcData.Order_Cons_Unit_Id
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
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;

    Load
    (
      inuOrder_Cons_Unit_Id
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
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    orcRecord out nocopy styLD_order_cons_unit
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;

    Load
    (
      inuOrder_Cons_Unit_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN styLD_order_cons_unit
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;

    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type
  )
  RETURN styLD_order_cons_unit
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuOrder_Cons_Unit_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_order_cons_unit
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_order_cons_unit
  )
  IS
    rfLD_order_cons_unit tyrfLD_order_cons_unit;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_order_cons_unit.Order_Cons_Unit_Id,
                LD_order_cons_unit.Geograp_Location_Id,
                LD_order_cons_unit.Order_Id,
                LD_order_cons_unit.Order_Date,
                LD_order_cons_unit.Error_Of_Order,
                LD_order_cons_unit.rowid
                FROM LD_order_cons_unit';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_order_cons_unit for sbFullQuery;
    fetch rfLD_order_cons_unit bulk collect INTO otbResult;
    close rfLD_order_cons_unit;
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
                LD_order_cons_unit.Order_Cons_Unit_Id,
                LD_order_cons_unit.Geograp_Location_Id,
                LD_order_cons_unit.Order_Id,
                LD_order_cons_unit.Order_Date,
                LD_order_cons_unit.Error_Of_Order,
                LD_order_cons_unit.rowid
                FROM LD_order_cons_unit';
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
    ircLD_order_cons_unit in styLD_order_cons_unit
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_order_cons_unit,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_order_cons_unit in styLD_order_cons_unit,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_order_cons_unit.Order_Cons_Unit_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Order_Cons_Unit_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_order_cons_unit
    (
      Order_Cons_Unit_Id,
      Geograp_Location_Id,
      Order_Id,
      Order_Date,
      Error_Of_Order
    )
    values
    (
      ircLD_order_cons_unit.Order_Cons_Unit_Id,
      ircLD_order_cons_unit.Geograp_Location_Id,
      ircLD_order_cons_unit.Order_Id,
      ircLD_order_cons_unit.Order_Date,
      ircLD_order_cons_unit.Error_Of_Order
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_order_cons_unit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_order_cons_unit in out nocopy tytbLD_order_cons_unit
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_order_cons_unit, blUseRowID);
    forall n in iotbLD_order_cons_unit.first..iotbLD_order_cons_unit.last
      insert into LD_order_cons_unit
      (
      Order_Cons_Unit_Id,
      Geograp_Location_Id,
      Order_Id,
      Order_Date,
      Error_Of_Order
    )
    values
    (
      rcRecOfTab.Order_Cons_Unit_Id(n),
      rcRecOfTab.Geograp_Location_Id(n),
      rcRecOfTab.Order_Id(n),
      rcRecOfTab.Order_Date(n),
      rcRecOfTab.Error_Of_Order(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;

    if inuLock=1 then
      LockByPk
      (
        inuOrder_Cons_Unit_Id,
        rcData
      );
    end if;

    delete
    from LD_order_cons_unit
    where
           Order_Cons_Unit_Id=inuOrder_Cons_Unit_Id;
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
    rcError  styLD_order_cons_unit;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_order_cons_unit
    where
      rowid = iriRowID
    returning
   Order_Cons_Unit_Id
    into
      rcError.Order_Cons_Unit_Id;

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
    iotbLD_order_cons_unit in out nocopy tytbLD_order_cons_unit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_order_cons_unit;
  BEGIN
    FillRecordOfTables(iotbLD_order_cons_unit, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last
        delete
        from LD_order_cons_unit
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last loop
          LockByPk
          (
              rcRecOfTab.Order_Cons_Unit_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last
        delete
        from LD_order_cons_unit
        where
               Order_Cons_Unit_Id = rcRecOfTab.Order_Cons_Unit_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_order_cons_unit in styLD_order_cons_unit,
    inuLock    in number default 0
  )
  IS
    nuOrder_Cons_Unit_Id LD_order_cons_unit.Order_Cons_Unit_Id%type;

  BEGIN
    if ircLD_order_cons_unit.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_order_cons_unit.rowid,rcData);
      end if;
      update LD_order_cons_unit
      set

        Geograp_Location_Id = ircLD_order_cons_unit.Geograp_Location_Id,
        Order_Id = ircLD_order_cons_unit.Order_Id,
        Order_Date = ircLD_order_cons_unit.Order_Date,
        Error_Of_Order = ircLD_order_cons_unit.Error_Of_Order
      where
        rowid = ircLD_order_cons_unit.rowid
      returning
    Order_Cons_Unit_Id
      into
        nuOrder_Cons_Unit_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_order_cons_unit.Order_Cons_Unit_Id,
          rcData
        );
      end if;

      update LD_order_cons_unit
      set
        Geograp_Location_Id = ircLD_order_cons_unit.Geograp_Location_Id,
        Order_Id = ircLD_order_cons_unit.Order_Id,
        Order_Date = ircLD_order_cons_unit.Order_Date,
        Error_Of_Order = ircLD_order_cons_unit.Error_Of_Order
      where
             Order_Cons_Unit_Id = ircLD_order_cons_unit.Order_Cons_Unit_Id
      returning
    Order_Cons_Unit_Id
      into
        nuOrder_Cons_Unit_Id;
    end if;

    if
      nuOrder_Cons_Unit_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_order_cons_unit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_order_cons_unit in out nocopy tytbLD_order_cons_unit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_order_cons_unit;
  BEGIN
    FillRecordOfTables(iotbLD_order_cons_unit,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last
        update LD_order_cons_unit
        set

            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Order_Id = rcRecOfTab.Order_Id(n),
            Order_Date = rcRecOfTab.Order_Date(n),
            Error_Of_Order = rcRecOfTab.Error_Of_Order(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last loop
          LockByPk
          (
              rcRecOfTab.Order_Cons_Unit_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_order_cons_unit.first .. iotbLD_order_cons_unit.last
        update LD_order_cons_unit
        set
          Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
          Order_Id = rcRecOfTab.Order_Id(n),
          Order_Date = rcRecOfTab.Order_Date(n),
          Error_Of_Order = rcRecOfTab.Error_Of_Order(n)
          where
          Order_Cons_Unit_Id = rcRecOfTab.Order_Cons_Unit_Id(n)
;
    end if;
  END;

  PROCEDURE updGeograp_Location_Id
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuGeograp_Location_Id$ in LD_order_cons_unit.Geograp_Location_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuOrder_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_order_cons_unit
    set
      Geograp_Location_Id = inuGeograp_Location_Id$
    where
      Order_Cons_Unit_Id = inuOrder_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updOrder_Id
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuOrder_Id$ in LD_order_cons_unit.Order_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuOrder_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_order_cons_unit
    set
      Order_Id = inuOrder_Id$
    where
      Order_Cons_Unit_Id = inuOrder_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Order_Id:= inuOrder_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updOrder_Date
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    idtOrder_Date$ in LD_order_cons_unit.Order_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuOrder_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_order_cons_unit
    set
      Order_Date = idtOrder_Date$
    where
      Order_Cons_Unit_Id = inuOrder_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Order_Date:= idtOrder_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updError_Of_Order
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    isbError_Of_Order$ in LD_order_cons_unit.Error_Of_Order%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_order_cons_unit;
  BEGIN
    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuOrder_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_order_cons_unit
    set
      Error_Of_Order = isbError_Of_Order$
    where
      Order_Cons_Unit_Id = inuOrder_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Error_Of_Order:= isbError_Of_Order$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetOrder_Cons_Unit_Id
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_order_cons_unit.Order_Cons_Unit_Id%type
  IS
    rcError styLD_order_cons_unit;
  BEGIN

    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuOrder_Cons_Unit_Id
       )
    then
       return(rcData.Order_Cons_Unit_Id);
    end if;
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(rcData.Order_Cons_Unit_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetGeograp_Location_Id
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_order_cons_unit.Geograp_Location_Id%type
  IS
    rcError styLD_order_cons_unit;
  BEGIN

    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuOrder_Cons_Unit_Id
       )
    then
       return(rcData.Geograp_Location_Id);
    end if;
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(rcData.Geograp_Location_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetOrder_Id
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_order_cons_unit.Order_Id%type
  IS
    rcError styLD_order_cons_unit;
  BEGIN

    rcError.Order_Cons_Unit_Id := inuOrder_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuOrder_Cons_Unit_Id
       )
    then
       return(rcData.Order_Id);
    end if;
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(rcData.Order_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetOrder_Date
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_order_cons_unit.Order_Date%type
  IS
    rcError styLD_order_cons_unit;
  BEGIN

    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuOrder_Cons_Unit_Id
       )
    then
       return(rcData.Order_Date);
    end if;
    Load
    (
         inuOrder_Cons_Unit_Id
    );
    return(rcData.Order_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetError_Of_Order
  (
    inuOrder_Cons_Unit_Id in LD_order_cons_unit.Order_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_order_cons_unit.Error_Of_Order%type
  IS
    rcError styLD_order_cons_unit;
  BEGIN

    rcError.Order_Cons_Unit_Id:=inuOrder_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuOrder_Cons_Unit_Id
       )
    then
       return(rcData.Error_Of_Order);
    end if;
    Load
    (
      inuOrder_Cons_Unit_Id
    );
    return(rcData.Error_Of_Order);
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
end DALD_order_cons_unit;
/
PROMPT Otorgando permisos de ejecucion a DALD_ORDER_CONS_UNIT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_ORDER_CONS_UNIT', 'ADM_PERSON');
END;
/
