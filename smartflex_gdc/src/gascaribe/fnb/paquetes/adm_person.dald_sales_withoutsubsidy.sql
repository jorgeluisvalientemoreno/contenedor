CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_sales_withoutsubsidy
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  IS
    SELECT LD_sales_withoutsubsidy.*,LD_sales_withoutsubsidy.rowid
    FROM LD_sales_withoutsubsidy
    WHERE
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sales_withoutsubsidy.*,LD_sales_withoutsubsidy.rowid
    FROM LD_sales_withoutsubsidy
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_sales_withoutsubsidy  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_sales_withoutsubsidy is table of styLD_sales_withoutsubsidy index by binary_integer;
  type tyrfRecords is ref cursor return styLD_sales_withoutsubsidy;

  /* Tipos referenciando al registro */
  type tytbSales_Withoutsubsidy_Id is table of LD_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%type index by binary_integer;
  type tytbPackage_Id is table of LD_sales_withoutsubsidy.Package_Id%type index by binary_integer;
  type tytbOrder_Id is table of LD_sales_withoutsubsidy.Order_Id%type index by binary_integer;
  type tytbDelivery_Doc is table of LD_sales_withoutsubsidy.Delivery_Doc%type index by binary_integer;
  type tytbState is table of LD_sales_withoutsubsidy.State%type index by binary_integer;
  type tytbInsert_Date is table of LD_sales_withoutsubsidy.Insert_Date%type index by binary_integer;
  type tytbUser_Id is table of LD_sales_withoutsubsidy.User_Id%type index by binary_integer;
  type tytbSesion is table of LD_sales_withoutsubsidy.Sesion%type index by binary_integer;
  type tytbTerminal is table of LD_sales_withoutsubsidy.Terminal%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_sales_withoutsubsidy is record
  (

    Sales_Withoutsubsidy_Id   tytbSales_Withoutsubsidy_Id,
    Package_Id   tytbPackage_Id,
    Order_Id   tytbOrder_Id,
    Delivery_Doc   tytbDelivery_Doc,
    State   tytbState,
    Insert_Date   tytbInsert_Date,
    User_Id   tytbUser_Id,
    Sesion   tytbSesion,
    Terminal   tytbTerminal,
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  );

  PROCEDURE getRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    orcRecord out nocopy styLD_sales_withoutsubsidy
  );

  FUNCTION frcGetRcData
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN styLD_sales_withoutsubsidy;

  FUNCTION frcGetRcData
  RETURN styLD_sales_withoutsubsidy;

  FUNCTION frcGetRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN styLD_sales_withoutsubsidy;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sales_withoutsubsidy
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_sales_withoutsubsidy in styLD_sales_withoutsubsidy
  );

     PROCEDURE insRecord
  (
    ircLD_sales_withoutsubsidy in styLD_sales_withoutsubsidy,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_sales_withoutsubsidy in out nocopy tytbLD_sales_withoutsubsidy
  );

  PROCEDURE delRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_sales_withoutsubsidy in out nocopy tytbLD_sales_withoutsubsidy,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_sales_withoutsubsidy in styLD_sales_withoutsubsidy,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_sales_withoutsubsidy in out nocopy tytbLD_sales_withoutsubsidy,
    inuLock in number default 1
  );

    PROCEDURE updPackage_Id
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        inuPackage_Id$  in LD_sales_withoutsubsidy.Package_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updOrder_Id
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        inuOrder_Id$  in LD_sales_withoutsubsidy.Order_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updDelivery_Doc
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        isbDelivery_Doc$  in LD_sales_withoutsubsidy.Delivery_Doc%type,
        inuLock    in number default 0
      );

    PROCEDURE updState
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        isbState$  in LD_sales_withoutsubsidy.State%type,
        inuLock    in number default 0
      );

    PROCEDURE updInsert_Date
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        idtInsert_Date$  in LD_sales_withoutsubsidy.Insert_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updUser_Id
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        isbUser_Id$  in LD_sales_withoutsubsidy.User_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSesion
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        inuSesion$  in LD_sales_withoutsubsidy.Sesion%type,
        inuLock    in number default 0
      );

    PROCEDURE updTerminal
    (
        inuSALES_WITHOUTSUBSIDY_Id   in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
        isbTerminal$  in LD_sales_withoutsubsidy.Terminal%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetSales_Withoutsubsidy_Id
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%type;

      FUNCTION fnuGetPackage_Id
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Package_Id%type;

      FUNCTION fnuGetOrder_Id
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Order_Id%type;

      FUNCTION fsbGetDelivery_Doc
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Delivery_Doc%type;

      FUNCTION fsbGetState
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.State%type;

      FUNCTION fdtGetInsert_Date
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Insert_Date%type;

      FUNCTION fsbGetUser_Id
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.User_Id%type;

      FUNCTION fnuGetSesion
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Sesion%type;

      FUNCTION fsbGetTerminal
      (
          inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sales_withoutsubsidy.Terminal%type;


  PROCEDURE LockByPk
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    orcLD_sales_withoutsubsidy  out styLD_sales_withoutsubsidy
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_sales_withoutsubsidy  out styLD_sales_withoutsubsidy
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_sales_withoutsubsidy;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_sales_withoutsubsidy
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SALES_WITHOUTSUBSIDY';
    cnuGeEntityId constant varchar2(30) := 8171; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  IS
    SELECT LD_sales_withoutsubsidy.*,LD_sales_withoutsubsidy.rowid
    FROM LD_sales_withoutsubsidy
    WHERE  SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sales_withoutsubsidy.*,LD_sales_withoutsubsidy.rowid
    FROM LD_sales_withoutsubsidy
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_sales_withoutsubsidy is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_sales_withoutsubsidy;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_sales_withoutsubsidy default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SALES_WITHOUTSUBSIDY_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    orcLD_sales_withoutsubsidy  out styLD_sales_withoutsubsidy
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;

    Open cuLockRcByPk
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );

    fetch cuLockRcByPk into orcLD_sales_withoutsubsidy;
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
    orcLD_sales_withoutsubsidy  out styLD_sales_withoutsubsidy
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_sales_withoutsubsidy;
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
    itbLD_sales_withoutsubsidy  in out nocopy tytbLD_sales_withoutsubsidy
  )
  IS
  BEGIN
      rcRecOfTab.Sales_Withoutsubsidy_Id.delete;
      rcRecOfTab.Package_Id.delete;
      rcRecOfTab.Order_Id.delete;
      rcRecOfTab.Delivery_Doc.delete;
      rcRecOfTab.State.delete;
      rcRecOfTab.Insert_Date.delete;
      rcRecOfTab.User_Id.delete;
      rcRecOfTab.Sesion.delete;
      rcRecOfTab.Terminal.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_sales_withoutsubsidy  in out nocopy tytbLD_sales_withoutsubsidy,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_sales_withoutsubsidy);
    for n in itbLD_sales_withoutsubsidy.first .. itbLD_sales_withoutsubsidy.last loop
      rcRecOfTab.Sales_Withoutsubsidy_Id(n) := itbLD_sales_withoutsubsidy(n).Sales_Withoutsubsidy_Id;
      rcRecOfTab.Package_Id(n) := itbLD_sales_withoutsubsidy(n).Package_Id;
      rcRecOfTab.Order_Id(n) := itbLD_sales_withoutsubsidy(n).Order_Id;
      rcRecOfTab.Delivery_Doc(n) := itbLD_sales_withoutsubsidy(n).Delivery_Doc;
      rcRecOfTab.State(n) := itbLD_sales_withoutsubsidy(n).State;
      rcRecOfTab.Insert_Date(n) := itbLD_sales_withoutsubsidy(n).Insert_Date;
      rcRecOfTab.User_Id(n) := itbLD_sales_withoutsubsidy(n).User_Id;
      rcRecOfTab.Sesion(n) := itbLD_sales_withoutsubsidy(n).Sesion;
      rcRecOfTab.Terminal(n) := itbLD_sales_withoutsubsidy(n).Terminal;
      rcRecOfTab.row_id(n) := itbLD_sales_withoutsubsidy(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSALES_WITHOUTSUBSIDY_Id
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSALES_WITHOUTSUBSIDY_Id = rcData.SALES_WITHOUTSUBSIDY_Id
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    orcRecord out nocopy styLD_sales_withoutsubsidy
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN styLD_sales_withoutsubsidy
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type
  )
  RETURN styLD_sales_withoutsubsidy
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_sales_withoutsubsidy
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sales_withoutsubsidy
  )
  IS
    rfLD_sales_withoutsubsidy tyrfLD_sales_withoutsubsidy;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_sales_withoutsubsidy.Sales_Withoutsubsidy_Id,
                LD_sales_withoutsubsidy.Package_Id,
                LD_sales_withoutsubsidy.Order_Id,
                LD_sales_withoutsubsidy.Delivery_Doc,
                LD_sales_withoutsubsidy.State,
                LD_sales_withoutsubsidy.Insert_Date,
                LD_sales_withoutsubsidy.User_Id,
                LD_sales_withoutsubsidy.Sesion,
                LD_sales_withoutsubsidy.Terminal,
                LD_sales_withoutsubsidy.rowid
                FROM LD_sales_withoutsubsidy';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_sales_withoutsubsidy for sbFullQuery;
    fetch rfLD_sales_withoutsubsidy bulk collect INTO otbResult;
    close rfLD_sales_withoutsubsidy;
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
                LD_sales_withoutsubsidy.Sales_Withoutsubsidy_Id,
                LD_sales_withoutsubsidy.Package_Id,
                LD_sales_withoutsubsidy.Order_Id,
                LD_sales_withoutsubsidy.Delivery_Doc,
                LD_sales_withoutsubsidy.State,
                LD_sales_withoutsubsidy.Insert_Date,
                LD_sales_withoutsubsidy.User_Id,
                LD_sales_withoutsubsidy.Sesion,
                LD_sales_withoutsubsidy.Terminal,
                LD_sales_withoutsubsidy.rowid
                FROM LD_sales_withoutsubsidy';
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
    ircLD_sales_withoutsubsidy in styLD_sales_withoutsubsidy
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_sales_withoutsubsidy,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_sales_withoutsubsidy in styLD_sales_withoutsubsidy,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SALES_WITHOUTSUBSIDY_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_sales_withoutsubsidy
    (
      Sales_Withoutsubsidy_Id,
      Package_Id,
      Order_Id,
      Delivery_Doc,
      State,
      Insert_Date,
      User_Id,
      Sesion,
      Terminal
    )
    values
    (
      ircLD_sales_withoutsubsidy.Sales_Withoutsubsidy_Id,
      ircLD_sales_withoutsubsidy.Package_Id,
      ircLD_sales_withoutsubsidy.Order_Id,
      ircLD_sales_withoutsubsidy.Delivery_Doc,
      ircLD_sales_withoutsubsidy.State,
      ircLD_sales_withoutsubsidy.Insert_Date,
      ircLD_sales_withoutsubsidy.User_Id,
      ircLD_sales_withoutsubsidy.Sesion,
      ircLD_sales_withoutsubsidy.Terminal
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_sales_withoutsubsidy));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_sales_withoutsubsidy in out nocopy tytbLD_sales_withoutsubsidy
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_sales_withoutsubsidy, blUseRowID);
    forall n in iotbLD_sales_withoutsubsidy.first..iotbLD_sales_withoutsubsidy.last
      insert into LD_sales_withoutsubsidy
      (
      Sales_Withoutsubsidy_Id,
      Package_Id,
      Order_Id,
      Delivery_Doc,
      State,
      Insert_Date,
      User_Id,
      Sesion,
      Terminal
    )
    values
    (
      rcRecOfTab.Sales_Withoutsubsidy_Id(n),
      rcRecOfTab.Package_Id(n),
      rcRecOfTab.Order_Id(n),
      rcRecOfTab.Delivery_Doc(n),
      rcRecOfTab.State(n),
      rcRecOfTab.Insert_Date(n),
      rcRecOfTab.User_Id(n),
      rcRecOfTab.Sesion(n),
      rcRecOfTab.Terminal(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    delete
    from LD_sales_withoutsubsidy
    where
           SALES_WITHOUTSUBSIDY_Id=inuSALES_WITHOUTSUBSIDY_Id;
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
    rcError  styLD_sales_withoutsubsidy;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_sales_withoutsubsidy
    where
      rowid = iriRowID
    returning
   SALES_WITHOUTSUBSIDY_Id
    into
      rcError.SALES_WITHOUTSUBSIDY_Id;

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
    iotbLD_sales_withoutsubsidy in out nocopy tytbLD_sales_withoutsubsidy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sales_withoutsubsidy;
  BEGIN
    FillRecordOfTables(iotbLD_sales_withoutsubsidy, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last
        delete
        from LD_sales_withoutsubsidy
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last loop
          LockByPk
          (
              rcRecOfTab.SALES_WITHOUTSUBSIDY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last
        delete
        from LD_sales_withoutsubsidy
        where
               SALES_WITHOUTSUBSIDY_Id = rcRecOfTab.SALES_WITHOUTSUBSIDY_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_sales_withoutsubsidy in styLD_sales_withoutsubsidy,
    inuLock    in number default 0
  )
  IS
    nuSALES_WITHOUTSUBSIDY_Id LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type;

  BEGIN
    if ircLD_sales_withoutsubsidy.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_sales_withoutsubsidy.rowid,rcData);
      end if;
      update LD_sales_withoutsubsidy
      set

        Package_Id = ircLD_sales_withoutsubsidy.Package_Id,
        Order_Id = ircLD_sales_withoutsubsidy.Order_Id,
        Delivery_Doc = ircLD_sales_withoutsubsidy.Delivery_Doc,
        State = ircLD_sales_withoutsubsidy.State,
        Insert_Date = ircLD_sales_withoutsubsidy.Insert_Date,
        User_Id = ircLD_sales_withoutsubsidy.User_Id,
        Sesion = ircLD_sales_withoutsubsidy.Sesion,
        Terminal = ircLD_sales_withoutsubsidy.Terminal
      where
        rowid = ircLD_sales_withoutsubsidy.rowid
      returning
    SALES_WITHOUTSUBSIDY_Id
      into
        nuSALES_WITHOUTSUBSIDY_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id,
          rcData
        );
      end if;

      update LD_sales_withoutsubsidy
      set
        Package_Id = ircLD_sales_withoutsubsidy.Package_Id,
        Order_Id = ircLD_sales_withoutsubsidy.Order_Id,
        Delivery_Doc = ircLD_sales_withoutsubsidy.Delivery_Doc,
        State = ircLD_sales_withoutsubsidy.State,
        Insert_Date = ircLD_sales_withoutsubsidy.Insert_Date,
        User_Id = ircLD_sales_withoutsubsidy.User_Id,
        Sesion = ircLD_sales_withoutsubsidy.Sesion,
        Terminal = ircLD_sales_withoutsubsidy.Terminal
      where
             SALES_WITHOUTSUBSIDY_Id = ircLD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id
      returning
    SALES_WITHOUTSUBSIDY_Id
      into
        nuSALES_WITHOUTSUBSIDY_Id;
    end if;

    if
      nuSALES_WITHOUTSUBSIDY_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_sales_withoutsubsidy));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_sales_withoutsubsidy in out nocopy tytbLD_sales_withoutsubsidy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sales_withoutsubsidy;
  BEGIN
    FillRecordOfTables(iotbLD_sales_withoutsubsidy,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last
        update LD_sales_withoutsubsidy
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Order_Id = rcRecOfTab.Order_Id(n),
            Delivery_Doc = rcRecOfTab.Delivery_Doc(n),
            State = rcRecOfTab.State(n),
            Insert_Date = rcRecOfTab.Insert_Date(n),
            User_Id = rcRecOfTab.User_Id(n),
            Sesion = rcRecOfTab.Sesion(n),
            Terminal = rcRecOfTab.Terminal(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last loop
          LockByPk
          (
              rcRecOfTab.SALES_WITHOUTSUBSIDY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sales_withoutsubsidy.first .. iotbLD_sales_withoutsubsidy.last
        update LD_sales_withoutsubsidy
        set
          Package_Id = rcRecOfTab.Package_Id(n),
          Order_Id = rcRecOfTab.Order_Id(n),
          Delivery_Doc = rcRecOfTab.Delivery_Doc(n),
          State = rcRecOfTab.State(n),
          Insert_Date = rcRecOfTab.Insert_Date(n),
          User_Id = rcRecOfTab.User_Id(n),
          Sesion = rcRecOfTab.Sesion(n),
          Terminal = rcRecOfTab.Terminal(n)
          where
          SALES_WITHOUTSUBSIDY_Id = rcRecOfTab.SALES_WITHOUTSUBSIDY_Id(n)
;
    end if;
  END;

  PROCEDURE updPackage_Id
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuPackage_Id$ in LD_sales_withoutsubsidy.Package_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      Package_Id = inuPackage_Id$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Id:= inuPackage_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updOrder_Id
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuOrder_Id$ in LD_sales_withoutsubsidy.Order_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      Order_Id = inuOrder_Id$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Order_Id:= inuOrder_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDelivery_Doc
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    isbDelivery_Doc$ in LD_sales_withoutsubsidy.Delivery_Doc%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      Delivery_Doc = isbDelivery_Doc$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Delivery_Doc:= isbDelivery_Doc$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updState
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    isbState$ in LD_sales_withoutsubsidy.State%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      State = isbState$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.State:= isbState$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInsert_Date
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    idtInsert_Date$ in LD_sales_withoutsubsidy.Insert_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      Insert_Date = idtInsert_Date$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Insert_Date:= idtInsert_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updUser_Id
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    isbUser_Id$ in LD_sales_withoutsubsidy.User_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      User_Id = isbUser_Id$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuSesion$ in LD_sales_withoutsubsidy.Sesion%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      Sesion = inuSesion$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    isbTerminal$ in LD_sales_withoutsubsidy.Terminal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN
    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSALES_WITHOUTSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_sales_withoutsubsidy
    set
      Terminal = isbTerminal$
    where
      SALES_WITHOUTSUBSIDY_Id = inuSALES_WITHOUTSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Terminal:= isbTerminal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSales_Withoutsubsidy_Id
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Sales_Withoutsubsidy_Id%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Sales_Withoutsubsidy_Id);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    return(rcData.Sales_Withoutsubsidy_Id);
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Package_Id%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Package_Id);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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

  FUNCTION fnuGetOrder_Id
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Order_Id%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Order_Id);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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

  FUNCTION fsbGetDelivery_Doc
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Delivery_Doc%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Delivery_Doc);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
    );
    return(rcData.Delivery_Doc);
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.State%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.State);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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

  FUNCTION fdtGetInsert_Date
  (
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Insert_Date%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Insert_Date);
    end if;
    Load
    (
         inuSALES_WITHOUTSUBSIDY_Id
    );
    return(rcData.Insert_Date);
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.User_Id%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.User_Id);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Sesion%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id := inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Sesion);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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
    inuSALES_WITHOUTSUBSIDY_Id in LD_sales_withoutsubsidy.SALES_WITHOUTSUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sales_withoutsubsidy.Terminal%type
  IS
    rcError styLD_sales_withoutsubsidy;
  BEGIN

    rcError.SALES_WITHOUTSUBSIDY_Id:=inuSALES_WITHOUTSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSALES_WITHOUTSUBSIDY_Id
       )
    then
       return(rcData.Terminal);
    end if;
    Load
    (
      inuSALES_WITHOUTSUBSIDY_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_sales_withoutsubsidy;
/
PROMPT Otorgando permisos de ejecucion a DALD_SALES_WITHOUTSUBSIDY
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SALES_WITHOUTSUBSIDY', 'ADM_PERSON');
END;
/