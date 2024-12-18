CREATE OR REPLACE PACKAGE adm_person.dald_extra_quota
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  IS
    SELECT LD_extra_quota.*,LD_extra_quota.rowid
    FROM LD_extra_quota
    WHERE
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_extra_quota.*,LD_extra_quota.rowid
    FROM LD_extra_quota
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_extra_quota  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_extra_quota is table of styLD_extra_quota index by binary_integer;
  type tyrfRecords is ref cursor return styLD_extra_quota;

  /* Tipos referenciando al registro */
  type tytbExtra_Quota_Id is table of LD_extra_quota.Extra_Quota_Id%type index by binary_integer;
  type tytbSupplier_Id is table of LD_extra_quota.Supplier_Id%type index by binary_integer;
  type tytbCategory_Id is table of LD_extra_quota.Category_Id%type index by binary_integer;
  type tytbSubcategory_Id is table of LD_extra_quota.Subcategory_Id%type index by binary_integer;
  type tytbGeograp_Location_Id is table of LD_extra_quota.Geograp_Location_Id%type index by binary_integer;
  type tytbSale_Chanel_Id is table of LD_extra_quota.Sale_Chanel_Id%type index by binary_integer;
  type tytbQuota_Option is table of LD_extra_quota.Quota_Option%type index by binary_integer;
  type tytbValue is table of LD_extra_quota.Value%type index by binary_integer;
  type tytbLine_Id is table of LD_extra_quota.Line_Id%type index by binary_integer;
  type tytbSubline_Id is table of LD_extra_quota.Subline_Id%type index by binary_integer;
  type tytbInitial_Date is table of LD_extra_quota.Initial_Date%type index by binary_integer;
  type tytbFinal_Date is table of LD_extra_quota.Final_Date%type index by binary_integer;
  type tytbObservation is table of LD_extra_quota.Observation%type index by binary_integer;
  type tytbDocument is table of LD_extra_quota.Document%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_extra_quota is record
  (

    Extra_Quota_Id   tytbExtra_Quota_Id,
    Supplier_Id   tytbSupplier_Id,
    Category_Id   tytbCategory_Id,
    Subcategory_Id   tytbSubcategory_Id,
    Geograp_Location_Id   tytbGeograp_Location_Id,
    Sale_Chanel_Id   tytbSale_Chanel_Id,
    Quota_Option   tytbQuota_Option,
    Value   tytbValue,
    Line_Id   tytbLine_Id,
    Subline_Id   tytbSubline_Id,
    Initial_Date   tytbInitial_Date,
    Final_Date   tytbFinal_Date,
    Observation   tytbObservation,
    Document   tytbDocument,
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
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  );

  PROCEDURE getRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    orcRecord out nocopy styLD_extra_quota
  );

  FUNCTION frcGetRcData
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN styLD_extra_quota;

  FUNCTION frcGetRcData
  RETURN styLD_extra_quota;

  FUNCTION frcGetRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN styLD_extra_quota;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_extra_quota
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_extra_quota in styLD_extra_quota
  );

     PROCEDURE insRecord
  (
    ircLD_extra_quota in styLD_extra_quota,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_extra_quota in out nocopy tytbLD_extra_quota
  );

  PROCEDURE delRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_extra_quota in out nocopy tytbLD_extra_quota,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_extra_quota in styLD_extra_quota,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_extra_quota in out nocopy tytbLD_extra_quota,
    inuLock in number default 1
  );

    PROCEDURE updSupplier_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuSupplier_Id$  in LD_extra_quota.Supplier_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updCategory_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuCategory_Id$  in LD_extra_quota.Category_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubcategory_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuSubcategory_Id$  in LD_extra_quota.Subcategory_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updGeograp_Location_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuGeograp_Location_Id$  in LD_extra_quota.Geograp_Location_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSale_Chanel_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuSale_Chanel_Id$  in LD_extra_quota.Sale_Chanel_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updQuota_Option
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        isbQuota_Option$  in LD_extra_quota.Quota_Option%type,
        inuLock    in number default 0
      );

    PROCEDURE updValue
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuValue$  in LD_extra_quota.Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updLine_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuLine_Id$  in LD_extra_quota.Line_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubline_Id
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        inuSubline_Id$  in LD_extra_quota.Subline_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updInitial_Date
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        idtInitial_Date$  in LD_extra_quota.Initial_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updFinal_Date
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        idtFinal_Date$  in LD_extra_quota.Final_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updObservation
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        isbObservation$  in LD_extra_quota.Observation%type,
        inuLock    in number default 0
      );

    PROCEDURE updDocument
    (
        inuEXTRA_QUOTA_Id   in LD_extra_quota.EXTRA_QUOTA_Id%type,
        iblDocument$  in LD_extra_quota.Document%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetExtra_Quota_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Extra_Quota_Id%type;

      FUNCTION fnuGetSupplier_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Supplier_Id%type;

      FUNCTION fnuGetCategory_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Category_Id%type;

      FUNCTION fnuGetSubcategory_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Subcategory_Id%type;

      FUNCTION fnuGetGeograp_Location_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Geograp_Location_Id%type;

      FUNCTION fnuGetSale_Chanel_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Sale_Chanel_Id%type;

      FUNCTION fsbGetQuota_Option
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Quota_Option%type;

      FUNCTION fnuGetValue
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Value%type;

      FUNCTION fnuGetLine_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Line_Id%type;

      FUNCTION fnuGetSubline_Id
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Subline_Id%type;

      FUNCTION fdtGetInitial_Date
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Initial_Date%type;

      FUNCTION fdtGetFinal_Date
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Final_Date%type;

      FUNCTION fsbGetObservation
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Observation%type;

      FUNCTION fblGetDocument
      (
          inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_extra_quota.Document%type;


  PROCEDURE LockByPk
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    orcLD_extra_quota  out styLD_extra_quota
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_extra_quota  out styLD_extra_quota
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_extra_quota;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_extra_quota
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_EXTRA_QUOTA';
    cnuGeEntityId constant varchar2(30) := 7359; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  IS
    SELECT LD_extra_quota.*,LD_extra_quota.rowid
    FROM LD_extra_quota
    WHERE  EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_extra_quota.*,LD_extra_quota.rowid
    FROM LD_extra_quota
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_extra_quota is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_extra_quota;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_extra_quota default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.EXTRA_QUOTA_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    orcLD_extra_quota  out styLD_extra_quota
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    Open cuLockRcByPk
    (
      inuEXTRA_QUOTA_Id
    );

    fetch cuLockRcByPk into orcLD_extra_quota;
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
    orcLD_extra_quota  out styLD_extra_quota
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_extra_quota;
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
    itbLD_extra_quota  in out nocopy tytbLD_extra_quota
  )
  IS
  BEGIN
      rcRecOfTab.Extra_Quota_Id.delete;
      rcRecOfTab.Supplier_Id.delete;
      rcRecOfTab.Category_Id.delete;
      rcRecOfTab.Subcategory_Id.delete;
      rcRecOfTab.Geograp_Location_Id.delete;
      rcRecOfTab.Sale_Chanel_Id.delete;
      rcRecOfTab.Quota_Option.delete;
      rcRecOfTab.Value.delete;
      rcRecOfTab.Line_Id.delete;
      rcRecOfTab.Subline_Id.delete;
      rcRecOfTab.Initial_Date.delete;
      rcRecOfTab.Final_Date.delete;
      rcRecOfTab.Observation.delete;
      rcRecOfTab.Document.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_extra_quota  in out nocopy tytbLD_extra_quota,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_extra_quota);
    for n in itbLD_extra_quota.first .. itbLD_extra_quota.last loop
      rcRecOfTab.Extra_Quota_Id(n) := itbLD_extra_quota(n).Extra_Quota_Id;
      rcRecOfTab.Supplier_Id(n) := itbLD_extra_quota(n).Supplier_Id;
      rcRecOfTab.Category_Id(n) := itbLD_extra_quota(n).Category_Id;
      rcRecOfTab.Subcategory_Id(n) := itbLD_extra_quota(n).Subcategory_Id;
      rcRecOfTab.Geograp_Location_Id(n) := itbLD_extra_quota(n).Geograp_Location_Id;
      rcRecOfTab.Sale_Chanel_Id(n) := itbLD_extra_quota(n).Sale_Chanel_Id;
      rcRecOfTab.Quota_Option(n) := itbLD_extra_quota(n).Quota_Option;
      rcRecOfTab.Value(n) := itbLD_extra_quota(n).Value;
      rcRecOfTab.Line_Id(n) := itbLD_extra_quota(n).Line_Id;
      rcRecOfTab.Subline_Id(n) := itbLD_extra_quota(n).Subline_Id;
      rcRecOfTab.Initial_Date(n) := itbLD_extra_quota(n).Initial_Date;
      rcRecOfTab.Final_Date(n) := itbLD_extra_quota(n).Final_Date;
      rcRecOfTab.Observation(n) := itbLD_extra_quota(n).Observation;
      rcRecOfTab.Document(n) := itbLD_extra_quota(n).Document;
      rcRecOfTab.row_id(n) := itbLD_extra_quota(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuEXTRA_QUOTA_Id
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
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuEXTRA_QUOTA_Id = rcData.EXTRA_QUOTA_Id
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
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  IS
    rcError styLD_extra_quota;
  BEGIN    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    Load
    (
      inuEXTRA_QUOTA_Id
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
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    orcRecord out nocopy styLD_extra_quota
  )
  IS
    rcError styLD_extra_quota;
  BEGIN    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    Load
    (
      inuEXTRA_QUOTA_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN styLD_extra_quota
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type
  )
  RETURN styLD_extra_quota
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuEXTRA_QUOTA_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_extra_quota
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_extra_quota
  )
  IS
    rfLD_extra_quota tyrfLD_extra_quota;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_extra_quota.Extra_Quota_Id,
                LD_extra_quota.Supplier_Id,
                LD_extra_quota.Category_Id,
                LD_extra_quota.Subcategory_Id,
                LD_extra_quota.Geograp_Location_Id,
                LD_extra_quota.Sale_Chanel_Id,
                LD_extra_quota.Quota_Option,
                LD_extra_quota.Value,
                LD_extra_quota.Line_Id,
                LD_extra_quota.Subline_Id,
                LD_extra_quota.Initial_Date,
                LD_extra_quota.Final_Date,
                LD_extra_quota.Observation,
                LD_extra_quota.Document,
                LD_extra_quota.rowid
                FROM LD_extra_quota';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_extra_quota for sbFullQuery;
    fetch rfLD_extra_quota bulk collect INTO otbResult;
    close rfLD_extra_quota;
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
                LD_extra_quota.Extra_Quota_Id,
                LD_extra_quota.Supplier_Id,
                LD_extra_quota.Category_Id,
                LD_extra_quota.Subcategory_Id,
                LD_extra_quota.Geograp_Location_Id,
                LD_extra_quota.Sale_Chanel_Id,
                LD_extra_quota.Quota_Option,
                LD_extra_quota.Value,
                LD_extra_quota.Line_Id,
                LD_extra_quota.Subline_Id,
                LD_extra_quota.Initial_Date,
                LD_extra_quota.Final_Date,
                LD_extra_quota.Observation,
                LD_extra_quota.Document,
                LD_extra_quota.rowid
                FROM LD_extra_quota';
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
    ircLD_extra_quota in styLD_extra_quota
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_extra_quota,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_extra_quota in styLD_extra_quota,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_extra_quota.EXTRA_QUOTA_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|EXTRA_QUOTA_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_extra_quota
    (
      Extra_Quota_Id,
      Supplier_Id,
      Category_Id,
      Subcategory_Id,
      Geograp_Location_Id,
      Sale_Chanel_Id,
      Quota_Option,
      Value,
      Line_Id,
      Subline_Id,
      Initial_Date,
      Final_Date,
      Observation,
      Document
    )
    values
    (
      ircLD_extra_quota.Extra_Quota_Id,
      ircLD_extra_quota.Supplier_Id,
      ircLD_extra_quota.Category_Id,
      ircLD_extra_quota.Subcategory_Id,
      ircLD_extra_quota.Geograp_Location_Id,
      ircLD_extra_quota.Sale_Chanel_Id,
      ircLD_extra_quota.Quota_Option,
      ircLD_extra_quota.Value,
      ircLD_extra_quota.Line_Id,
      ircLD_extra_quota.Subline_Id,
      ircLD_extra_quota.Initial_Date,
      ircLD_extra_quota.Final_Date,
      ircLD_extra_quota.Observation,
      ircLD_extra_quota.Document
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_extra_quota));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_extra_quota in out nocopy tytbLD_extra_quota
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_extra_quota, blUseRowID);
    forall n in iotbLD_extra_quota.first..iotbLD_extra_quota.last
      insert into LD_extra_quota
      (
      Extra_Quota_Id,
      Supplier_Id,
      Category_Id,
      Subcategory_Id,
      Geograp_Location_Id,
      Sale_Chanel_Id,
      Quota_Option,
      Value,
      Line_Id,
      Subline_Id,
      Initial_Date,
      Final_Date,
      Observation,
      Document
    )
    values
    (
      rcRecOfTab.Extra_Quota_Id(n),
      rcRecOfTab.Supplier_Id(n),
      rcRecOfTab.Category_Id(n),
      rcRecOfTab.Subcategory_Id(n),
      rcRecOfTab.Geograp_Location_Id(n),
      rcRecOfTab.Sale_Chanel_Id(n),
      rcRecOfTab.Quota_Option(n),
      rcRecOfTab.Value(n),
      rcRecOfTab.Line_Id(n),
      rcRecOfTab.Subline_Id(n),
      rcRecOfTab.Initial_Date(n),
      rcRecOfTab.Final_Date(n),
      rcRecOfTab.Observation(n),
      rcRecOfTab.Document(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    delete
    from LD_extra_quota
    where
           EXTRA_QUOTA_Id=inuEXTRA_QUOTA_Id;
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
    rcError  styLD_extra_quota;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_extra_quota
    where
      rowid = iriRowID
    returning
   EXTRA_QUOTA_Id
    into
      rcError.EXTRA_QUOTA_Id;

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
    iotbLD_extra_quota in out nocopy tytbLD_extra_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_extra_quota;
  BEGIN
    FillRecordOfTables(iotbLD_extra_quota, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last
        delete
        from LD_extra_quota
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last loop
          LockByPk
          (
              rcRecOfTab.EXTRA_QUOTA_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last
        delete
        from LD_extra_quota
        where
               EXTRA_QUOTA_Id = rcRecOfTab.EXTRA_QUOTA_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_extra_quota in styLD_extra_quota,
    inuLock    in number default 0
  )
  IS
    nuEXTRA_QUOTA_Id LD_extra_quota.EXTRA_QUOTA_Id%type;

  BEGIN
    if ircLD_extra_quota.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_extra_quota.rowid,rcData);
      end if;
      update LD_extra_quota
      set

        Supplier_Id = ircLD_extra_quota.Supplier_Id,
        Category_Id = ircLD_extra_quota.Category_Id,
        Subcategory_Id = ircLD_extra_quota.Subcategory_Id,
        Geograp_Location_Id = ircLD_extra_quota.Geograp_Location_Id,
        Sale_Chanel_Id = ircLD_extra_quota.Sale_Chanel_Id,
        Quota_Option = ircLD_extra_quota.Quota_Option,
        Value = ircLD_extra_quota.Value,
        Line_Id = ircLD_extra_quota.Line_Id,
        Subline_Id = ircLD_extra_quota.Subline_Id,
        Initial_Date = ircLD_extra_quota.Initial_Date,
        Final_Date = ircLD_extra_quota.Final_Date,
        Observation = ircLD_extra_quota.Observation,
        Document = ircLD_extra_quota.Document
      where
        rowid = ircLD_extra_quota.rowid
      returning
    EXTRA_QUOTA_Id
      into
        nuEXTRA_QUOTA_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_extra_quota.EXTRA_QUOTA_Id,
          rcData
        );
      end if;

      update LD_extra_quota
      set
        Supplier_Id = ircLD_extra_quota.Supplier_Id,
        Category_Id = ircLD_extra_quota.Category_Id,
        Subcategory_Id = ircLD_extra_quota.Subcategory_Id,
        Geograp_Location_Id = ircLD_extra_quota.Geograp_Location_Id,
        Sale_Chanel_Id = ircLD_extra_quota.Sale_Chanel_Id,
        Quota_Option = ircLD_extra_quota.Quota_Option,
        Value = ircLD_extra_quota.Value,
        Line_Id = ircLD_extra_quota.Line_Id,
        Subline_Id = ircLD_extra_quota.Subline_Id,
        Initial_Date = ircLD_extra_quota.Initial_Date,
        Final_Date = ircLD_extra_quota.Final_Date,
        Observation = ircLD_extra_quota.Observation,
        Document = ircLD_extra_quota.Document
      where
             EXTRA_QUOTA_Id = ircLD_extra_quota.EXTRA_QUOTA_Id
      returning
    EXTRA_QUOTA_Id
      into
        nuEXTRA_QUOTA_Id;
    end if;

    if
      nuEXTRA_QUOTA_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_extra_quota));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_extra_quota in out nocopy tytbLD_extra_quota,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_extra_quota;
  BEGIN
    FillRecordOfTables(iotbLD_extra_quota,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last
        update LD_extra_quota
        set

            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Category_Id = rcRecOfTab.Category_Id(n),
            Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
            Quota_Option = rcRecOfTab.Quota_Option(n),
            Value = rcRecOfTab.Value(n),
            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Observation = rcRecOfTab.Observation(n),
            Document = rcRecOfTab.Document(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last loop
          LockByPk
          (
              rcRecOfTab.EXTRA_QUOTA_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_extra_quota.first .. iotbLD_extra_quota.last
        update LD_extra_quota
        set
          Supplier_Id = rcRecOfTab.Supplier_Id(n),
          Category_Id = rcRecOfTab.Category_Id(n),
          Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
          Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
          Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
          Quota_Option = rcRecOfTab.Quota_Option(n),
          Value = rcRecOfTab.Value(n),
          Line_Id = rcRecOfTab.Line_Id(n),
          Subline_Id = rcRecOfTab.Subline_Id(n),
          Initial_Date = rcRecOfTab.Initial_Date(n),
          Final_Date = rcRecOfTab.Final_Date(n),
          Observation = rcRecOfTab.Observation(n),
          Document = rcRecOfTab.Document(n)
          where
          EXTRA_QUOTA_Id = rcRecOfTab.EXTRA_QUOTA_Id(n)
;
    end if;
  END;

  PROCEDURE updSupplier_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuSupplier_Id$ in LD_extra_quota.Supplier_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Supplier_Id = inuSupplier_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Supplier_Id:= inuSupplier_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCategory_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuCategory_Id$ in LD_extra_quota.Category_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Category_Id = inuCategory_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Category_Id:= inuCategory_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubcategory_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuSubcategory_Id$ in LD_extra_quota.Subcategory_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Subcategory_Id = inuSubcategory_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subcategory_Id:= inuSubcategory_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updGeograp_Location_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuGeograp_Location_Id$ in LD_extra_quota.Geograp_Location_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Geograp_Location_Id = inuGeograp_Location_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSale_Chanel_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuSale_Chanel_Id$ in LD_extra_quota.Sale_Chanel_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Sale_Chanel_Id = inuSale_Chanel_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sale_Chanel_Id:= inuSale_Chanel_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updQuota_Option
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    isbQuota_Option$ in LD_extra_quota.Quota_Option%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Quota_Option = isbQuota_Option$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Quota_Option:= isbQuota_Option$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updValue
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuValue$ in LD_extra_quota.Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Value = inuValue$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Value:= inuValue$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updLine_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuLine_Id$ in LD_extra_quota.Line_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Line_Id = inuLine_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Line_Id:= inuLine_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubline_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuSubline_Id$ in LD_extra_quota.Subline_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Subline_Id = inuSubline_Id$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subline_Id:= inuSubline_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInitial_Date
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    idtInitial_Date$ in LD_extra_quota.Initial_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Initial_Date = idtInitial_Date$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Initial_Date:= idtInitial_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updFinal_Date
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    idtFinal_Date$ in LD_extra_quota.Final_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Final_Date = idtFinal_Date$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Final_Date:= idtFinal_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updObservation
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    isbObservation$ in LD_extra_quota.Observation%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Observation = isbObservation$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Observation:= isbObservation$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDocument
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    iblDocument$ in LD_extra_quota.Document%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_extra_quota;
  BEGIN
    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;
    if inuLock=1 then
      LockByPk
      (
        inuEXTRA_QUOTA_Id,
        rcData
      );
    end if;

    update LD_extra_quota
    set
      Document = iblDocument$
    where
      EXTRA_QUOTA_Id = inuEXTRA_QUOTA_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Document:= iblDocument$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetExtra_Quota_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Extra_Quota_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Extra_Quota_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Extra_Quota_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSupplier_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Supplier_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Supplier_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Supplier_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetCategory_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Category_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Category_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Category_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSubcategory_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Subcategory_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Subcategory_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Subcategory_Id);
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
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Geograp_Location_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Geograp_Location_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
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

  FUNCTION fnuGetSale_Chanel_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Sale_Chanel_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Sale_Chanel_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Sale_Chanel_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetQuota_Option
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Quota_Option%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Quota_Option);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Quota_Option);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetValue
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Value%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Value);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetLine_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Line_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Line_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Line_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSubline_Id
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Subline_Id%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id := inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Subline_Id);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Subline_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetInitial_Date
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Initial_Date%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Initial_Date);
    end if;
    Load
    (
         inuEXTRA_QUOTA_Id
    );
    return(rcData.Initial_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetFinal_Date
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Final_Date%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Final_Date);
    end if;
    Load
    (
         inuEXTRA_QUOTA_Id
    );
    return(rcData.Final_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetObservation
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Observation%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Observation);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Observation);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fblGetDocument
  (
    inuEXTRA_QUOTA_Id in LD_extra_quota.EXTRA_QUOTA_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_extra_quota.Document%type
  IS
    rcError styLD_extra_quota;
  BEGIN

    rcError.EXTRA_QUOTA_Id:=inuEXTRA_QUOTA_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuEXTRA_QUOTA_Id
       )
    then
       return(rcData.Document);
    end if;
    Load
    (
      inuEXTRA_QUOTA_Id
    );
    return(rcData.Document);
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
end DALD_extra_quota;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_EXTRA_QUOTA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_EXTRA_QUOTA', 'ADM_PERSON'); 
END;
/  
