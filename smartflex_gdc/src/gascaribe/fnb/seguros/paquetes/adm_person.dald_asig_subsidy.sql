CREATE OR REPLACE PACKAGE adm_person.DALD_asig_subsidy
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  IS
    SELECT LD_asig_subsidy.*,LD_asig_subsidy.rowid
    FROM LD_asig_subsidy
    WHERE
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_asig_subsidy.*,LD_asig_subsidy.rowid
    FROM LD_asig_subsidy
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_asig_subsidy  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_asig_subsidy is table of styLD_asig_subsidy index by binary_integer;
  type tyrfRecords is ref cursor return styLD_asig_subsidy;

  /* Tipos referenciando al registro */
  type tytbAsig_Subsidy_Id is table of LD_asig_subsidy.Asig_Subsidy_Id%type index by binary_integer;
  type tytbSusccodi is table of LD_asig_subsidy.Susccodi%type index by binary_integer;
  type tytbSubsidy_Id is table of LD_asig_subsidy.Subsidy_Id%type index by binary_integer;
  type tytbPromotion_Id is table of LD_asig_subsidy.Promotion_Id%type index by binary_integer;
  type tytbSubsidy_Value is table of LD_asig_subsidy.Subsidy_Value%type index by binary_integer;
  type tytbOrder_Id is table of LD_asig_subsidy.Order_Id%type index by binary_integer;
  type tytbDelivery_Doc is table of LD_asig_subsidy.Delivery_Doc%type index by binary_integer;
  type tytbState_Subsidy is table of LD_asig_subsidy.State_Subsidy%type index by binary_integer;
  type tytbType_Subsidy is table of LD_asig_subsidy.Type_Subsidy%type index by binary_integer;
  type tytbPackage_Id is table of LD_asig_subsidy.Package_Id%type index by binary_integer;
  type tytbInsert_Date is table of LD_asig_subsidy.Insert_Date%type index by binary_integer;
  type tytbReceivable_Date is table of LD_asig_subsidy.Receivable_Date%type index by binary_integer;
  type tytbCollect_Date is table of LD_asig_subsidy.Collect_Date%type index by binary_integer;
  type tytbPay_Date is table of LD_asig_subsidy.Pay_Date%type index by binary_integer;
  type tytbRecord_Collect is table of LD_asig_subsidy.Record_Collect%type index by binary_integer;
  type tytbUbication_Id is table of LD_asig_subsidy.Ubication_Id%type index by binary_integer;
  type tytbPay_Entity is table of LD_asig_subsidy.Pay_Entity%type index by binary_integer;
  type tytbTransfer_Number is table of LD_asig_subsidy.Transfer_Number%type index by binary_integer;
  type tytbPay_Place is table of LD_asig_subsidy.Pay_Place%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_asig_subsidy is record
  (

    Asig_Subsidy_Id   tytbAsig_Subsidy_Id,
    Susccodi   tytbSusccodi,
    Subsidy_Id   tytbSubsidy_Id,
    Promotion_Id   tytbPromotion_Id,
    Subsidy_Value   tytbSubsidy_Value,
    Order_Id   tytbOrder_Id,
    Delivery_Doc   tytbDelivery_Doc,
    State_Subsidy   tytbState_Subsidy,
    Type_Subsidy   tytbType_Subsidy,
    Package_Id   tytbPackage_Id,
    Insert_Date   tytbInsert_Date,
    Receivable_Date   tytbReceivable_Date,
    Collect_Date   tytbCollect_Date,
    Pay_Date   tytbPay_Date,
    Record_Collect   tytbRecord_Collect,
    Ubication_Id   tytbUbication_Id,
    Pay_Entity   tytbPay_Entity,
    Transfer_Number   tytbTransfer_Number,
    Pay_Place   tytbPay_Place,
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  );

  PROCEDURE getRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    orcRecord out nocopy styLD_asig_subsidy
  );

  FUNCTION frcGetRcData
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN styLD_asig_subsidy;

  FUNCTION frcGetRcData
  RETURN styLD_asig_subsidy;

  FUNCTION frcGetRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN styLD_asig_subsidy;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_asig_subsidy
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_asig_subsidy in styLD_asig_subsidy
  );

     PROCEDURE insRecord
  (
    ircLD_asig_subsidy in styLD_asig_subsidy,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_asig_subsidy in out nocopy tytbLD_asig_subsidy
  );

  PROCEDURE delRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_asig_subsidy in out nocopy tytbLD_asig_subsidy,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_asig_subsidy in styLD_asig_subsidy,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_asig_subsidy in out nocopy tytbLD_asig_subsidy,
    inuLock in number default 1
  );

    PROCEDURE updSusccodi
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuSusccodi$  in LD_asig_subsidy.Susccodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Id
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuSubsidy_Id$  in LD_asig_subsidy.Subsidy_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updPromotion_Id
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuPromotion_Id$  in LD_asig_subsidy.Promotion_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Value
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuSubsidy_Value$  in LD_asig_subsidy.Subsidy_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updOrder_Id
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuOrder_Id$  in LD_asig_subsidy.Order_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updDelivery_Doc
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        isbDelivery_Doc$  in LD_asig_subsidy.Delivery_Doc%type,
        inuLock    in number default 0
      );

    PROCEDURE updState_Subsidy
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuState_Subsidy$  in LD_asig_subsidy.State_Subsidy%type,
        inuLock    in number default 0
      );

    PROCEDURE updType_Subsidy
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        isbType_Subsidy$  in LD_asig_subsidy.Type_Subsidy%type,
        inuLock    in number default 0
      );

    PROCEDURE updPackage_Id
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuPackage_Id$  in LD_asig_subsidy.Package_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updInsert_Date
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        idtInsert_Date$  in LD_asig_subsidy.Insert_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updReceivable_Date
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        idtReceivable_Date$  in LD_asig_subsidy.Receivable_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updCollect_Date
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        idtCollect_Date$  in LD_asig_subsidy.Collect_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updPay_Date
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        idtPay_Date$  in LD_asig_subsidy.Pay_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updRecord_Collect
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuRecord_Collect$  in LD_asig_subsidy.Record_Collect%type,
        inuLock    in number default 0
      );

    PROCEDURE updUbication_Id
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuUbication_Id$  in LD_asig_subsidy.Ubication_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updPay_Entity
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuPay_Entity$  in LD_asig_subsidy.Pay_Entity%type,
        inuLock    in number default 0
      );

    PROCEDURE updTransfer_Number
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        inuTransfer_Number$  in LD_asig_subsidy.Transfer_Number%type,
        inuLock    in number default 0
      );

    PROCEDURE updPay_Place
    (
        inuASIG_SUBSIDY_Id   in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
        isbPay_Place$  in LD_asig_subsidy.Pay_Place%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetAsig_Subsidy_Id
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Asig_Subsidy_Id%type;

      FUNCTION fnuGetSusccodi
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Susccodi%type;

      FUNCTION fnuGetSubsidy_Id
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Subsidy_Id%type;

      FUNCTION fnuGetPromotion_Id
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Promotion_Id%type;

      FUNCTION fnuGetSubsidy_Value
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Subsidy_Value%type;

      FUNCTION fnuGetOrder_Id
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Order_Id%type;

      FUNCTION fsbGetDelivery_Doc
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Delivery_Doc%type;

      FUNCTION fnuGetState_Subsidy
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.State_Subsidy%type;

      FUNCTION fsbGetType_Subsidy
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Type_Subsidy%type;

      FUNCTION fnuGetPackage_Id
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Package_Id%type;

      FUNCTION fdtGetInsert_Date
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Insert_Date%type;

      FUNCTION fdtGetReceivable_Date
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Receivable_Date%type;

      FUNCTION fdtGetCollect_Date
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Collect_Date%type;

      FUNCTION fdtGetPay_Date
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Pay_Date%type;

      FUNCTION fnuGetRecord_Collect
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Record_Collect%type;

      FUNCTION fnuGetUbication_Id
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Ubication_Id%type;

      FUNCTION fnuGetPay_Entity
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Pay_Entity%type;

      FUNCTION fnuGetTransfer_Number
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Transfer_Number%type;

      FUNCTION fsbGetPay_Place
      (
          inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_asig_subsidy.Pay_Place%type;


  PROCEDURE LockByPk
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    orcLD_asig_subsidy  out styLD_asig_subsidy
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_asig_subsidy  out styLD_asig_subsidy
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_asig_subsidy;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_asig_subsidy
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_ASIG_SUBSIDY';
    cnuGeEntityId constant varchar2(30) := 8136; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  IS
    SELECT LD_asig_subsidy.*,LD_asig_subsidy.rowid
    FROM LD_asig_subsidy
    WHERE  ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_asig_subsidy.*,LD_asig_subsidy.rowid
    FROM LD_asig_subsidy
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_asig_subsidy is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_asig_subsidy;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_asig_subsidy default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.ASIG_SUBSIDY_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    orcLD_asig_subsidy  out styLD_asig_subsidy
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    Open cuLockRcByPk
    (
      inuASIG_SUBSIDY_Id
    );

    fetch cuLockRcByPk into orcLD_asig_subsidy;
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
    orcLD_asig_subsidy  out styLD_asig_subsidy
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_asig_subsidy;
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
    itbLD_asig_subsidy  in out nocopy tytbLD_asig_subsidy
  )
  IS
  BEGIN
      rcRecOfTab.Asig_Subsidy_Id.delete;
      rcRecOfTab.Susccodi.delete;
      rcRecOfTab.Subsidy_Id.delete;
      rcRecOfTab.Promotion_Id.delete;
      rcRecOfTab.Subsidy_Value.delete;
      rcRecOfTab.Order_Id.delete;
      rcRecOfTab.Delivery_Doc.delete;
      rcRecOfTab.State_Subsidy.delete;
      rcRecOfTab.Type_Subsidy.delete;
      rcRecOfTab.Package_Id.delete;
      rcRecOfTab.Insert_Date.delete;
      rcRecOfTab.Receivable_Date.delete;
      rcRecOfTab.Collect_Date.delete;
      rcRecOfTab.Pay_Date.delete;
      rcRecOfTab.Record_Collect.delete;
      rcRecOfTab.Ubication_Id.delete;
      rcRecOfTab.Pay_Entity.delete;
      rcRecOfTab.Transfer_Number.delete;
      rcRecOfTab.Pay_Place.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_asig_subsidy  in out nocopy tytbLD_asig_subsidy,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_asig_subsidy);
    for n in itbLD_asig_subsidy.first .. itbLD_asig_subsidy.last loop
      rcRecOfTab.Asig_Subsidy_Id(n) := itbLD_asig_subsidy(n).Asig_Subsidy_Id;
      rcRecOfTab.Susccodi(n) := itbLD_asig_subsidy(n).Susccodi;
      rcRecOfTab.Subsidy_Id(n) := itbLD_asig_subsidy(n).Subsidy_Id;
      rcRecOfTab.Promotion_Id(n) := itbLD_asig_subsidy(n).Promotion_Id;
      rcRecOfTab.Subsidy_Value(n) := itbLD_asig_subsidy(n).Subsidy_Value;
      rcRecOfTab.Order_Id(n) := itbLD_asig_subsidy(n).Order_Id;
      rcRecOfTab.Delivery_Doc(n) := itbLD_asig_subsidy(n).Delivery_Doc;
      rcRecOfTab.State_Subsidy(n) := itbLD_asig_subsidy(n).State_Subsidy;
      rcRecOfTab.Type_Subsidy(n) := itbLD_asig_subsidy(n).Type_Subsidy;
      rcRecOfTab.Package_Id(n) := itbLD_asig_subsidy(n).Package_Id;
      rcRecOfTab.Insert_Date(n) := itbLD_asig_subsidy(n).Insert_Date;
      rcRecOfTab.Receivable_Date(n) := itbLD_asig_subsidy(n).Receivable_Date;
      rcRecOfTab.Collect_Date(n) := itbLD_asig_subsidy(n).Collect_Date;
      rcRecOfTab.Pay_Date(n) := itbLD_asig_subsidy(n).Pay_Date;
      rcRecOfTab.Record_Collect(n) := itbLD_asig_subsidy(n).Record_Collect;
      rcRecOfTab.Ubication_Id(n) := itbLD_asig_subsidy(n).Ubication_Id;
      rcRecOfTab.Pay_Entity(n) := itbLD_asig_subsidy(n).Pay_Entity;
      rcRecOfTab.Transfer_Number(n) := itbLD_asig_subsidy(n).Transfer_Number;
      rcRecOfTab.Pay_Place(n) := itbLD_asig_subsidy(n).Pay_Place;
      rcRecOfTab.row_id(n) := itbLD_asig_subsidy(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuASIG_SUBSIDY_Id
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuASIG_SUBSIDY_Id = rcData.ASIG_SUBSIDY_Id
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    Load
    (
      inuASIG_SUBSIDY_Id
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    orcRecord out nocopy styLD_asig_subsidy
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    Load
    (
      inuASIG_SUBSIDY_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN styLD_asig_subsidy
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type
  )
  RETURN styLD_asig_subsidy
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuASIG_SUBSIDY_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_asig_subsidy
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_asig_subsidy
  )
  IS
    rfLD_asig_subsidy tyrfLD_asig_subsidy;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_asig_subsidy.Asig_Subsidy_Id,
                LD_asig_subsidy.Susccodi,
                LD_asig_subsidy.Subsidy_Id,
                LD_asig_subsidy.Promotion_Id,
                LD_asig_subsidy.Subsidy_Value,
                LD_asig_subsidy.Order_Id,
                LD_asig_subsidy.Delivery_Doc,
                LD_asig_subsidy.State_Subsidy,
                LD_asig_subsidy.Type_Subsidy,
                LD_asig_subsidy.Package_Id,
                LD_asig_subsidy.Insert_Date,
                LD_asig_subsidy.Receivable_Date,
                LD_asig_subsidy.Collect_Date,
                LD_asig_subsidy.Pay_Date,
                LD_asig_subsidy.Record_Collect,
                LD_asig_subsidy.Ubication_Id,
                LD_asig_subsidy.Pay_Entity,
                LD_asig_subsidy.Transfer_Number,
                LD_asig_subsidy.Pay_Place,
                LD_asig_subsidy.rowid
                FROM LD_asig_subsidy';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_asig_subsidy for sbFullQuery;
    fetch rfLD_asig_subsidy bulk collect INTO otbResult;
    close rfLD_asig_subsidy;
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
                LD_asig_subsidy.Asig_Subsidy_Id,
                LD_asig_subsidy.Susccodi,
                LD_asig_subsidy.Subsidy_Id,
                LD_asig_subsidy.Promotion_Id,
                LD_asig_subsidy.Subsidy_Value,
                LD_asig_subsidy.Order_Id,
                LD_asig_subsidy.Delivery_Doc,
                LD_asig_subsidy.State_Subsidy,
                LD_asig_subsidy.Type_Subsidy,
                LD_asig_subsidy.Package_Id,
                LD_asig_subsidy.Insert_Date,
                LD_asig_subsidy.Receivable_Date,
                LD_asig_subsidy.Collect_Date,
                LD_asig_subsidy.Pay_Date,
                LD_asig_subsidy.Record_Collect,
                LD_asig_subsidy.Ubication_Id,
                LD_asig_subsidy.Pay_Entity,
                LD_asig_subsidy.Transfer_Number,
                LD_asig_subsidy.Pay_Place,
                LD_asig_subsidy.rowid
                FROM LD_asig_subsidy';
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
    ircLD_asig_subsidy in styLD_asig_subsidy
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_asig_subsidy,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_asig_subsidy in styLD_asig_subsidy,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_asig_subsidy.ASIG_SUBSIDY_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|ASIG_SUBSIDY_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_asig_subsidy
    (
      Asig_Subsidy_Id,
      Susccodi,
      Subsidy_Id,
      Promotion_Id,
      Subsidy_Value,
      Order_Id,
      Delivery_Doc,
      State_Subsidy,
      Type_Subsidy,
      Package_Id,
      Insert_Date,
      Receivable_Date,
      Collect_Date,
      Pay_Date,
      Record_Collect,
      Ubication_Id,
      Pay_Entity,
      Transfer_Number,
      Pay_Place
    )
    values
    (
      ircLD_asig_subsidy.Asig_Subsidy_Id,
      ircLD_asig_subsidy.Susccodi,
      ircLD_asig_subsidy.Subsidy_Id,
      ircLD_asig_subsidy.Promotion_Id,
      ircLD_asig_subsidy.Subsidy_Value,
      ircLD_asig_subsidy.Order_Id,
      ircLD_asig_subsidy.Delivery_Doc,
      ircLD_asig_subsidy.State_Subsidy,
      ircLD_asig_subsidy.Type_Subsidy,
      ircLD_asig_subsidy.Package_Id,
      ircLD_asig_subsidy.Insert_Date,
      ircLD_asig_subsidy.Receivable_Date,
      ircLD_asig_subsidy.Collect_Date,
      ircLD_asig_subsidy.Pay_Date,
      ircLD_asig_subsidy.Record_Collect,
      ircLD_asig_subsidy.Ubication_Id,
      ircLD_asig_subsidy.Pay_Entity,
      ircLD_asig_subsidy.Transfer_Number,
      ircLD_asig_subsidy.Pay_Place
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_asig_subsidy));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_asig_subsidy in out nocopy tytbLD_asig_subsidy
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_asig_subsidy, blUseRowID);
    forall n in iotbLD_asig_subsidy.first..iotbLD_asig_subsidy.last
      insert into LD_asig_subsidy
      (
      Asig_Subsidy_Id,
      Susccodi,
      Subsidy_Id,
      Promotion_Id,
      Subsidy_Value,
      Order_Id,
      Delivery_Doc,
      State_Subsidy,
      Type_Subsidy,
      Package_Id,
      Insert_Date,
      Receivable_Date,
      Collect_Date,
      Pay_Date,
      Record_Collect,
      Ubication_Id,
      Pay_Entity,
      Transfer_Number,
      Pay_Place
    )
    values
    (
      rcRecOfTab.Asig_Subsidy_Id(n),
      rcRecOfTab.Susccodi(n),
      rcRecOfTab.Subsidy_Id(n),
      rcRecOfTab.Promotion_Id(n),
      rcRecOfTab.Subsidy_Value(n),
      rcRecOfTab.Order_Id(n),
      rcRecOfTab.Delivery_Doc(n),
      rcRecOfTab.State_Subsidy(n),
      rcRecOfTab.Type_Subsidy(n),
      rcRecOfTab.Package_Id(n),
      rcRecOfTab.Insert_Date(n),
      rcRecOfTab.Receivable_Date(n),
      rcRecOfTab.Collect_Date(n),
      rcRecOfTab.Pay_Date(n),
      rcRecOfTab.Record_Collect(n),
      rcRecOfTab.Ubication_Id(n),
      rcRecOfTab.Pay_Entity(n),
      rcRecOfTab.Transfer_Number(n),
      rcRecOfTab.Pay_Place(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    delete
    from LD_asig_subsidy
    where
           ASIG_SUBSIDY_Id=inuASIG_SUBSIDY_Id;
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
    rcError  styLD_asig_subsidy;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_asig_subsidy
    where
      rowid = iriRowID
    returning
   ASIG_SUBSIDY_Id
    into
      rcError.ASIG_SUBSIDY_Id;

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
    iotbLD_asig_subsidy in out nocopy tytbLD_asig_subsidy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_asig_subsidy;
  BEGIN
    FillRecordOfTables(iotbLD_asig_subsidy, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last
        delete
        from LD_asig_subsidy
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last loop
          LockByPk
          (
              rcRecOfTab.ASIG_SUBSIDY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last
        delete
        from LD_asig_subsidy
        where
               ASIG_SUBSIDY_Id = rcRecOfTab.ASIG_SUBSIDY_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_asig_subsidy in styLD_asig_subsidy,
    inuLock    in number default 0
  )
  IS
    nuASIG_SUBSIDY_Id LD_asig_subsidy.ASIG_SUBSIDY_Id%type;

  BEGIN
    if ircLD_asig_subsidy.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_asig_subsidy.rowid,rcData);
      end if;
      update LD_asig_subsidy
      set

        Susccodi = ircLD_asig_subsidy.Susccodi,
        Subsidy_Id = ircLD_asig_subsidy.Subsidy_Id,
        Promotion_Id = ircLD_asig_subsidy.Promotion_Id,
        Subsidy_Value = ircLD_asig_subsidy.Subsidy_Value,
        Order_Id = ircLD_asig_subsidy.Order_Id,
        Delivery_Doc = ircLD_asig_subsidy.Delivery_Doc,
        State_Subsidy = ircLD_asig_subsidy.State_Subsidy,
        Type_Subsidy = ircLD_asig_subsidy.Type_Subsidy,
        Package_Id = ircLD_asig_subsidy.Package_Id,
        Insert_Date = ircLD_asig_subsidy.Insert_Date,
        Receivable_Date = ircLD_asig_subsidy.Receivable_Date,
        Collect_Date = ircLD_asig_subsidy.Collect_Date,
        Pay_Date = ircLD_asig_subsidy.Pay_Date,
        Record_Collect = ircLD_asig_subsidy.Record_Collect,
        Ubication_Id = ircLD_asig_subsidy.Ubication_Id,
        Pay_Entity = ircLD_asig_subsidy.Pay_Entity,
        Transfer_Number = ircLD_asig_subsidy.Transfer_Number,
        Pay_Place = ircLD_asig_subsidy.Pay_Place
      where
        rowid = ircLD_asig_subsidy.rowid
      returning
    ASIG_SUBSIDY_Id
      into
        nuASIG_SUBSIDY_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_asig_subsidy.ASIG_SUBSIDY_Id,
          rcData
        );
      end if;

      update LD_asig_subsidy
      set
        Susccodi = ircLD_asig_subsidy.Susccodi,
        Subsidy_Id = ircLD_asig_subsidy.Subsidy_Id,
        Promotion_Id = ircLD_asig_subsidy.Promotion_Id,
        Subsidy_Value = ircLD_asig_subsidy.Subsidy_Value,
        Order_Id = ircLD_asig_subsidy.Order_Id,
        Delivery_Doc = ircLD_asig_subsidy.Delivery_Doc,
        State_Subsidy = ircLD_asig_subsidy.State_Subsidy,
        Type_Subsidy = ircLD_asig_subsidy.Type_Subsidy,
        Package_Id = ircLD_asig_subsidy.Package_Id,
        Insert_Date = ircLD_asig_subsidy.Insert_Date,
        Receivable_Date = ircLD_asig_subsidy.Receivable_Date,
        Collect_Date = ircLD_asig_subsidy.Collect_Date,
        Pay_Date = ircLD_asig_subsidy.Pay_Date,
        Record_Collect = ircLD_asig_subsidy.Record_Collect,
        Ubication_Id = ircLD_asig_subsidy.Ubication_Id,
        Pay_Entity = ircLD_asig_subsidy.Pay_Entity,
        Transfer_Number = ircLD_asig_subsidy.Transfer_Number,
        Pay_Place = ircLD_asig_subsidy.Pay_Place
      where
             ASIG_SUBSIDY_Id = ircLD_asig_subsidy.ASIG_SUBSIDY_Id
      returning
    ASIG_SUBSIDY_Id
      into
        nuASIG_SUBSIDY_Id;
    end if;

    if
      nuASIG_SUBSIDY_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_asig_subsidy));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_asig_subsidy in out nocopy tytbLD_asig_subsidy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_asig_subsidy;
  BEGIN
    FillRecordOfTables(iotbLD_asig_subsidy,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last
        update LD_asig_subsidy
        set

            Susccodi = rcRecOfTab.Susccodi(n),
            Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
            Promotion_Id = rcRecOfTab.Promotion_Id(n),
            Subsidy_Value = rcRecOfTab.Subsidy_Value(n),
            Order_Id = rcRecOfTab.Order_Id(n),
            Delivery_Doc = rcRecOfTab.Delivery_Doc(n),
            State_Subsidy = rcRecOfTab.State_Subsidy(n),
            Type_Subsidy = rcRecOfTab.Type_Subsidy(n),
            Package_Id = rcRecOfTab.Package_Id(n),
            Insert_Date = rcRecOfTab.Insert_Date(n),
            Receivable_Date = rcRecOfTab.Receivable_Date(n),
            Collect_Date = rcRecOfTab.Collect_Date(n),
            Pay_Date = rcRecOfTab.Pay_Date(n),
            Record_Collect = rcRecOfTab.Record_Collect(n),
            Ubication_Id = rcRecOfTab.Ubication_Id(n),
            Pay_Entity = rcRecOfTab.Pay_Entity(n),
            Transfer_Number = rcRecOfTab.Transfer_Number(n),
            Pay_Place = rcRecOfTab.Pay_Place(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last loop
          LockByPk
          (
              rcRecOfTab.ASIG_SUBSIDY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_asig_subsidy.first .. iotbLD_asig_subsidy.last
        update LD_asig_subsidy
        set
          Susccodi = rcRecOfTab.Susccodi(n),
          Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
          Promotion_Id = rcRecOfTab.Promotion_Id(n),
          Subsidy_Value = rcRecOfTab.Subsidy_Value(n),
          Order_Id = rcRecOfTab.Order_Id(n),
          Delivery_Doc = rcRecOfTab.Delivery_Doc(n),
          State_Subsidy = rcRecOfTab.State_Subsidy(n),
          Type_Subsidy = rcRecOfTab.Type_Subsidy(n),
          Package_Id = rcRecOfTab.Package_Id(n),
          Insert_Date = rcRecOfTab.Insert_Date(n),
          Receivable_Date = rcRecOfTab.Receivable_Date(n),
          Collect_Date = rcRecOfTab.Collect_Date(n),
          Pay_Date = rcRecOfTab.Pay_Date(n),
          Record_Collect = rcRecOfTab.Record_Collect(n),
          Ubication_Id = rcRecOfTab.Ubication_Id(n),
          Pay_Entity = rcRecOfTab.Pay_Entity(n),
          Transfer_Number = rcRecOfTab.Transfer_Number(n),
          Pay_Place = rcRecOfTab.Pay_Place(n)
          where
          ASIG_SUBSIDY_Id = rcRecOfTab.ASIG_SUBSIDY_Id(n)
;
    end if;
  END;

  PROCEDURE updSusccodi
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuSusccodi$ in LD_asig_subsidy.Susccodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Susccodi = inuSusccodi$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Susccodi:= inuSusccodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuSubsidy_Id$ in LD_asig_subsidy.Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Subsidy_Id = inuSubsidy_Id$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Id:= inuSubsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPromotion_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuPromotion_Id$ in LD_asig_subsidy.Promotion_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Promotion_Id = inuPromotion_Id$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Promotion_Id:= inuPromotion_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Value
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuSubsidy_Value$ in LD_asig_subsidy.Subsidy_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Subsidy_Value = inuSubsidy_Value$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Value:= inuSubsidy_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updOrder_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuOrder_Id$ in LD_asig_subsidy.Order_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Order_Id = inuOrder_Id$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    isbDelivery_Doc$ in LD_asig_subsidy.Delivery_Doc%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Delivery_Doc = isbDelivery_Doc$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Delivery_Doc:= isbDelivery_Doc$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updState_Subsidy
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuState_Subsidy$ in LD_asig_subsidy.State_Subsidy%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      State_Subsidy = inuState_Subsidy$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.State_Subsidy:= inuState_Subsidy$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updType_Subsidy
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    isbType_Subsidy$ in LD_asig_subsidy.Type_Subsidy%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Type_Subsidy = isbType_Subsidy$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Type_Subsidy:= isbType_Subsidy$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPackage_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuPackage_Id$ in LD_asig_subsidy.Package_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Package_Id = inuPackage_Id$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Id:= inuPackage_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInsert_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    idtInsert_Date$ in LD_asig_subsidy.Insert_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Insert_Date = idtInsert_Date$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Insert_Date:= idtInsert_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updReceivable_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    idtReceivable_Date$ in LD_asig_subsidy.Receivable_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Receivable_Date = idtReceivable_Date$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Receivable_Date:= idtReceivable_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCollect_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    idtCollect_Date$ in LD_asig_subsidy.Collect_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Collect_Date = idtCollect_Date$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Collect_Date:= idtCollect_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPay_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    idtPay_Date$ in LD_asig_subsidy.Pay_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Pay_Date = idtPay_Date$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Pay_Date:= idtPay_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord_Collect
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRecord_Collect$ in LD_asig_subsidy.Record_Collect%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Record_Collect = inuRecord_Collect$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Record_Collect:= inuRecord_Collect$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updUbication_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuUbication_Id$ in LD_asig_subsidy.Ubication_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Ubication_Id = inuUbication_Id$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ubication_Id:= inuUbication_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPay_Entity
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuPay_Entity$ in LD_asig_subsidy.Pay_Entity%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Pay_Entity = inuPay_Entity$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Pay_Entity:= inuPay_Entity$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTransfer_Number
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuTransfer_Number$ in LD_asig_subsidy.Transfer_Number%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Transfer_Number = inuTransfer_Number$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Transfer_Number:= inuTransfer_Number$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPay_Place
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    isbPay_Place$ in LD_asig_subsidy.Pay_Place%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_asig_subsidy;
  BEGIN
    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuASIG_SUBSIDY_Id,
        rcData
      );
    end if;

    update LD_asig_subsidy
    set
      Pay_Place = isbPay_Place$
    where
      ASIG_SUBSIDY_Id = inuASIG_SUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Pay_Place:= isbPay_Place$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetAsig_Subsidy_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Asig_Subsidy_Id%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Asig_Subsidy_Id);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Asig_Subsidy_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSusccodi
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Susccodi%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Susccodi);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Susccodi);
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Subsidy_Id%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Subsidy_Id);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
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

  FUNCTION fnuGetPromotion_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Promotion_Id%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Promotion_Id);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Promotion_Id);
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Subsidy_Value%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Subsidy_Value);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
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

  FUNCTION fnuGetOrder_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Order_Id%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Order_Id);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Delivery_Doc%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Delivery_Doc);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
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

  FUNCTION fnuGetState_Subsidy
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.State_Subsidy%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.State_Subsidy);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.State_Subsidy);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetType_Subsidy
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Type_Subsidy%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Type_Subsidy);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Type_Subsidy);
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
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Package_Id%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Package_Id);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
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

  FUNCTION fdtGetInsert_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Insert_Date%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Insert_Date);
    end if;
    Load
    (
         inuASIG_SUBSIDY_Id
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

  FUNCTION fdtGetReceivable_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Receivable_Date%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Receivable_Date);
    end if;
    Load
    (
         inuASIG_SUBSIDY_Id
    );
    return(rcData.Receivable_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetCollect_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Collect_Date%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Collect_Date);
    end if;
    Load
    (
         inuASIG_SUBSIDY_Id
    );
    return(rcData.Collect_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetPay_Date
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Pay_Date%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Pay_Date);
    end if;
    Load
    (
         inuASIG_SUBSIDY_Id
    );
    return(rcData.Pay_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetRecord_Collect
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Record_Collect%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Record_Collect);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Record_Collect);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetUbication_Id
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Ubication_Id%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Ubication_Id);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Ubication_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetPay_Entity
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Pay_Entity%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Pay_Entity);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Pay_Entity);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTransfer_Number
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Transfer_Number%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id := inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Transfer_Number);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Transfer_Number);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetPay_Place
  (
    inuASIG_SUBSIDY_Id in LD_asig_subsidy.ASIG_SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_asig_subsidy.Pay_Place%type
  IS
    rcError styLD_asig_subsidy;
  BEGIN

    rcError.ASIG_SUBSIDY_Id:=inuASIG_SUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuASIG_SUBSIDY_Id
       )
    then
       return(rcData.Pay_Place);
    end if;
    Load
    (
      inuASIG_SUBSIDY_Id
    );
    return(rcData.Pay_Place);
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
end DALD_asig_subsidy;
/
PROMPT Otorgando permisos de ejecucion a DALD_ASIG_SUBSIDY
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_ASIG_SUBSIDY', 'ADM_PERSON');
END;
/