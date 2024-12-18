CREATE OR REPLACE PACKAGE adm_person.DALD_subsidy
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  IS
    SELECT LD_subsidy.*,LD_subsidy.rowid
    FROM LD_subsidy
    WHERE
      SUBSIDY_Id = inuSUBSIDY_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy.*,LD_subsidy.rowid
    FROM LD_subsidy
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_subsidy  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_subsidy is table of styLD_subsidy index by binary_integer;
  type tyrfRecords is ref cursor return styLD_subsidy;

  /* Tipos referenciando al registro */
  type tytbSubsidy_Id is table of LD_subsidy.Subsidy_Id%type index by binary_integer;
  type tytbDescription is table of LD_subsidy.Description%type index by binary_integer;
  type tytbDeal_Id is table of LD_subsidy.Deal_Id%type index by binary_integer;
  type tytbInitial_Date is table of LD_subsidy.Initial_Date%type index by binary_integer;
  type tytbFinal_Date is table of LD_subsidy.Final_Date%type index by binary_integer;
  type tytbStar_Collect_Date is table of LD_subsidy.Star_Collect_Date%type index by binary_integer;
  type tytbConccodi is table of LD_subsidy.Conccodi%type index by binary_integer;
  type tytbValidity_Year_Means is table of LD_subsidy.Validity_Year_Means%type index by binary_integer;
  type tytbAuthorize_Quantity is table of LD_subsidy.Authorize_Quantity%type index by binary_integer;
  type tytbAuthorize_Value is table of LD_subsidy.Authorize_Value%type index by binary_integer;
  type tytbRemainder_Status is table of LD_subsidy.Remainder_Status%type index by binary_integer;
  type tytbTotal_Deliver is table of LD_subsidy.Total_Deliver%type index by binary_integer;
  type tytbTotal_Available is table of LD_subsidy.Total_Available%type index by binary_integer;
  type tytbPromotion_Id is table of LD_subsidy.Promotion_Id%type index by binary_integer;
  type tytbOrigin_Subsidy is table of LD_subsidy.Origin_Subsidy%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_subsidy is record
  (

    Subsidy_Id   tytbSubsidy_Id,
    Description   tytbDescription,
    Deal_Id   tytbDeal_Id,
    Initial_Date   tytbInitial_Date,
    Final_Date   tytbFinal_Date,
    Star_Collect_Date   tytbStar_Collect_Date,
    Conccodi   tytbConccodi,
    Validity_Year_Means   tytbValidity_Year_Means,
    Authorize_Quantity   tytbAuthorize_Quantity,
    Authorize_Value   tytbAuthorize_Value,
    Remainder_Status   tytbRemainder_Status,
    Total_Deliver   tytbTotal_Deliver,
    Total_Available   tytbTotal_Available,
    Promotion_Id   tytbPromotion_Id,
    Origin_Subsidy   tytbOrigin_Subsidy,
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  );

  PROCEDURE getRecord
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    orcRecord out nocopy styLD_subsidy
  );

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN styLD_subsidy;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN styLD_subsidy;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_subsidy in styLD_subsidy
  );

     PROCEDURE insRecord
  (
    ircLD_subsidy in styLD_subsidy,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_subsidy in out nocopy tytbLD_subsidy
  );

  PROCEDURE delRecord
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_subsidy in out nocopy tytbLD_subsidy,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_subsidy in styLD_subsidy,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_subsidy in out nocopy tytbLD_subsidy,
    inuLock in number default 1
  );

    PROCEDURE updDescription
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        isbDescription$  in LD_subsidy.Description%type,
        inuLock    in number default 0
      );

    PROCEDURE updDeal_Id
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuDeal_Id$  in LD_subsidy.Deal_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updInitial_Date
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        idtInitial_Date$  in LD_subsidy.Initial_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updFinal_Date
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        idtFinal_Date$  in LD_subsidy.Final_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updStar_Collect_Date
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        idtStar_Collect_Date$  in LD_subsidy.Star_Collect_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updConccodi
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuConccodi$  in LD_subsidy.Conccodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updValidity_Year_Means
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuValidity_Year_Means$  in LD_subsidy.Validity_Year_Means%type,
        inuLock    in number default 0
      );

    PROCEDURE updAuthorize_Quantity
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuAuthorize_Quantity$  in LD_subsidy.Authorize_Quantity%type,
        inuLock    in number default 0
      );

    PROCEDURE updAuthorize_Value
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuAuthorize_Value$  in LD_subsidy.Authorize_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updRemainder_Status
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        isbRemainder_Status$  in LD_subsidy.Remainder_Status%type,
        inuLock    in number default 0
      );

    PROCEDURE updTotal_Deliver
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuTotal_Deliver$  in LD_subsidy.Total_Deliver%type,
        inuLock    in number default 0
      );

    PROCEDURE updTotal_Available
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuTotal_Available$  in LD_subsidy.Total_Available%type,
        inuLock    in number default 0
      );

    PROCEDURE updPromotion_Id
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuPromotion_Id$  in LD_subsidy.Promotion_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updOrigin_Subsidy
    (
        inuSUBSIDY_Id   in LD_subsidy.SUBSIDY_Id%type,
        inuOrigin_Subsidy$  in LD_subsidy.Origin_Subsidy%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetSubsidy_Id
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Subsidy_Id%type;

      FUNCTION fsbGetDescription
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Description%type;

      FUNCTION fnuGetDeal_Id
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Deal_Id%type;

      FUNCTION fdtGetInitial_Date
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Initial_Date%type;

      FUNCTION fdtGetFinal_Date
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Final_Date%type;

      FUNCTION fdtGetStar_Collect_Date
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Star_Collect_Date%type;

      FUNCTION fnuGetConccodi
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Conccodi%type;

      FUNCTION fnuGetValidity_Year_Means
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Validity_Year_Means%type;

      FUNCTION fnuGetAuthorize_Quantity
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Authorize_Quantity%type;

      FUNCTION fnuGetAuthorize_Value
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Authorize_Value%type;

      FUNCTION fsbGetRemainder_Status
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Remainder_Status%type;

      FUNCTION fnuGetTotal_Deliver
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Total_Deliver%type;

      FUNCTION fnuGetTotal_Available
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Total_Available%type;

      FUNCTION fnuGetPromotion_Id
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Promotion_Id%type;

      FUNCTION fnuGetOrigin_Subsidy
      (
          inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_subsidy.Origin_Subsidy%type;


  PROCEDURE LockByPk
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    orcLD_subsidy  out styLD_subsidy
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_subsidy  out styLD_subsidy
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );

  PROCEDURE LockByPkForUpdate
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    orcLD_subsidy  out styLD_subsidy
  );
END DALD_subsidy;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_subsidy
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUBSIDY';
    cnuGeEntityId constant varchar2(30) := 8124; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  IS
    SELECT LD_subsidy.*,LD_subsidy.rowid
    FROM LD_subsidy
    WHERE  SUBSIDY_Id = inuSUBSIDY_Id
    FOR UPDATE NOWAIT;

  CURSOR cuLockRcByPkForUpdate
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  IS
    SELECT LD_subsidy.*,LD_subsidy.rowid
    FROM LD_subsidy
    WHERE  SUBSIDY_Id = inuSUBSIDY_Id
    FOR UPDATE;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_subsidy.*,LD_subsidy.rowid
    FROM LD_subsidy
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_subsidy is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_subsidy;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_subsidy default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUBSIDY_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    orcLD_subsidy  out styLD_subsidy
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    Open cuLockRcByPk
    (
      inuSUBSIDY_Id
    );

    fetch cuLockRcByPk into orcLD_subsidy;
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

  PROCEDURE LockByPkForUpdate
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    orcLD_subsidy  out styLD_subsidy
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    Open cuLockRcByPkForUpdate
    (
      inuSUBSIDY_Id
    );

    fetch cuLockRcByPkForUpdate into orcLD_subsidy;
    if cuLockRcByPkForUpdate%notfound  then
      close cuLockRcByPkForUpdate;
      raise no_data_found;
    end if;
    close cuLockRcByPkForUpdate ;
  EXCEPTION
    when no_data_found then
      if cuLockRcByPkForUpdate%isopen then
        close cuLockRcByPkForUpdate;
      end if;
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
    when ex.RESOURCE_BUSY THEN
      if cuLockRcByPkForUpdate%isopen then
        close cuLockRcByPkForUpdate;
      end if;
      errors.setError(cnuAPPTABLEBUSSY,fsbPrimaryKey(rcError)||'|'|| fsbGetMessageDescription );
      raise ex.controlled_error;
    when others then
      if cuLockRcByPkForUpdate%isopen then
        close cuLockRcByPkForUpdate;
      end if;
      raise;
  END;

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_subsidy  out styLD_subsidy
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_subsidy;
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
    itbLD_subsidy  in out nocopy tytbLD_subsidy
  )
  IS
  BEGIN
      rcRecOfTab.Subsidy_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.Deal_Id.delete;
      rcRecOfTab.Initial_Date.delete;
      rcRecOfTab.Final_Date.delete;
      rcRecOfTab.Star_Collect_Date.delete;
      rcRecOfTab.Conccodi.delete;
      rcRecOfTab.Validity_Year_Means.delete;
      rcRecOfTab.Authorize_Quantity.delete;
      rcRecOfTab.Authorize_Value.delete;
      rcRecOfTab.Remainder_Status.delete;
      rcRecOfTab.Total_Deliver.delete;
      rcRecOfTab.Total_Available.delete;
      rcRecOfTab.Promotion_Id.delete;
      rcRecOfTab.Origin_Subsidy.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_subsidy  in out nocopy tytbLD_subsidy,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_subsidy);
    for n in itbLD_subsidy.first .. itbLD_subsidy.last loop
      rcRecOfTab.Subsidy_Id(n) := itbLD_subsidy(n).Subsidy_Id;
      rcRecOfTab.Description(n) := itbLD_subsidy(n).Description;
      rcRecOfTab.Deal_Id(n) := itbLD_subsidy(n).Deal_Id;
      rcRecOfTab.Initial_Date(n) := itbLD_subsidy(n).Initial_Date;
      rcRecOfTab.Final_Date(n) := itbLD_subsidy(n).Final_Date;
      rcRecOfTab.Star_Collect_Date(n) := itbLD_subsidy(n).Star_Collect_Date;
      rcRecOfTab.Conccodi(n) := itbLD_subsidy(n).Conccodi;
      rcRecOfTab.Validity_Year_Means(n) := itbLD_subsidy(n).Validity_Year_Means;
      rcRecOfTab.Authorize_Quantity(n) := itbLD_subsidy(n).Authorize_Quantity;
      rcRecOfTab.Authorize_Value(n) := itbLD_subsidy(n).Authorize_Value;
      rcRecOfTab.Remainder_Status(n) := itbLD_subsidy(n).Remainder_Status;
      rcRecOfTab.Total_Deliver(n) := itbLD_subsidy(n).Total_Deliver;
      rcRecOfTab.Total_Available(n) := itbLD_subsidy(n).Total_Available;
      rcRecOfTab.Promotion_Id(n) := itbLD_subsidy(n).Promotion_Id;
      rcRecOfTab.Origin_Subsidy(n) := itbLD_subsidy(n).Origin_Subsidy;
      rcRecOfTab.row_id(n) := itbLD_subsidy(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUBSIDY_Id
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUBSIDY_Id = rcData.SUBSIDY_Id
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  IS
    rcError styLD_subsidy;
  BEGIN    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    Load
    (
      inuSUBSIDY_Id
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUBSIDY_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    orcRecord out nocopy styLD_subsidy
  )
  IS
    rcError styLD_subsidy;
  BEGIN    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    Load
    (
      inuSUBSIDY_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN styLD_subsidy
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type
  )
  RETURN styLD_subsidy
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_subsidy
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subsidy
  )
  IS
    rfLD_subsidy tyrfLD_subsidy;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_subsidy.Subsidy_Id,
                LD_subsidy.Description,
                LD_subsidy.Deal_Id,
                LD_subsidy.Initial_Date,
                LD_subsidy.Final_Date,
                LD_subsidy.Star_Collect_Date,
                LD_subsidy.Conccodi,
                LD_subsidy.Validity_Year_Means,
                LD_subsidy.Authorize_Quantity,
                LD_subsidy.Authorize_Value,
                LD_subsidy.Remainder_Status,
                LD_subsidy.Total_Deliver,
                LD_subsidy.Total_Available,
                LD_subsidy.Promotion_Id,
                LD_subsidy.Origin_Subsidy,
                LD_subsidy.rowid
                FROM LD_subsidy';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_subsidy for sbFullQuery;
    fetch rfLD_subsidy bulk collect INTO otbResult;
    close rfLD_subsidy;
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
                LD_subsidy.Subsidy_Id,
                LD_subsidy.Description,
                LD_subsidy.Deal_Id,
                LD_subsidy.Initial_Date,
                LD_subsidy.Final_Date,
                LD_subsidy.Star_Collect_Date,
                LD_subsidy.Conccodi,
                LD_subsidy.Validity_Year_Means,
                LD_subsidy.Authorize_Quantity,
                LD_subsidy.Authorize_Value,
                LD_subsidy.Remainder_Status,
                LD_subsidy.Total_Deliver,
                LD_subsidy.Total_Available,
                LD_subsidy.Promotion_Id,
                LD_subsidy.Origin_Subsidy,
                LD_subsidy.rowid
                FROM LD_subsidy';
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
    ircLD_subsidy in styLD_subsidy
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_subsidy,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_subsidy in styLD_subsidy,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_subsidy.SUBSIDY_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUBSIDY_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_subsidy
    (
      Subsidy_Id,
      Description,
      Deal_Id,
      Initial_Date,
      Final_Date,
      Star_Collect_Date,
      Conccodi,
      Validity_Year_Means,
      Authorize_Quantity,
      Authorize_Value,
      Remainder_Status,
      Total_Deliver,
      Total_Available,
      Promotion_Id,
      Origin_Subsidy
    )
    values
    (
      ircLD_subsidy.Subsidy_Id,
      ircLD_subsidy.Description,
      ircLD_subsidy.Deal_Id,
      ircLD_subsidy.Initial_Date,
      ircLD_subsidy.Final_Date,
      ircLD_subsidy.Star_Collect_Date,
      ircLD_subsidy.Conccodi,
      ircLD_subsidy.Validity_Year_Means,
      ircLD_subsidy.Authorize_Quantity,
      ircLD_subsidy.Authorize_Value,
      ircLD_subsidy.Remainder_Status,
      ircLD_subsidy.Total_Deliver,
      ircLD_subsidy.Total_Available,
      ircLD_subsidy.Promotion_Id,
      ircLD_subsidy.Origin_Subsidy
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_subsidy));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_subsidy in out nocopy tytbLD_subsidy
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy, blUseRowID);
    forall n in iotbLD_subsidy.first..iotbLD_subsidy.last
      insert into LD_subsidy
      (
      Subsidy_Id,
      Description,
      Deal_Id,
      Initial_Date,
      Final_Date,
      Star_Collect_Date,
      Conccodi,
      Validity_Year_Means,
      Authorize_Quantity,
      Authorize_Value,
      Remainder_Status,
      Total_Deliver,
      Total_Available,
      Promotion_Id,
      Origin_Subsidy
    )
    values
    (
      rcRecOfTab.Subsidy_Id(n),
      rcRecOfTab.Description(n),
      rcRecOfTab.Deal_Id(n),
      rcRecOfTab.Initial_Date(n),
      rcRecOfTab.Final_Date(n),
      rcRecOfTab.Star_Collect_Date(n),
      rcRecOfTab.Conccodi(n),
      rcRecOfTab.Validity_Year_Means(n),
      rcRecOfTab.Authorize_Quantity(n),
      rcRecOfTab.Authorize_Value(n),
      rcRecOfTab.Remainder_Status(n),
      rcRecOfTab.Total_Deliver(n),
      rcRecOfTab.Total_Available(n),
      rcRecOfTab.Promotion_Id(n),
      rcRecOfTab.Origin_Subsidy(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    delete
    from LD_subsidy
    where
           SUBSIDY_Id=inuSUBSIDY_Id;
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
    rcError  styLD_subsidy;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_subsidy
    where
      rowid = iriRowID
    returning
   SUBSIDY_Id
    into
      rcError.SUBSIDY_Id;

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
    iotbLD_subsidy in out nocopy tytbLD_subsidy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_subsidy.first .. iotbLD_subsidy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy.first .. iotbLD_subsidy.last
        delete
        from LD_subsidy
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy.first .. iotbLD_subsidy.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy.first .. iotbLD_subsidy.last
        delete
        from LD_subsidy
        where
               SUBSIDY_Id = rcRecOfTab.SUBSIDY_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_subsidy in styLD_subsidy,
    inuLock    in number default 0
  )
  IS
    nuSUBSIDY_Id LD_subsidy.SUBSIDY_Id%type;

  BEGIN
    if ircLD_subsidy.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_subsidy.rowid,rcData);
      end if;
      update LD_subsidy
      set

        Description = ircLD_subsidy.Description,
        Deal_Id = ircLD_subsidy.Deal_Id,
        Initial_Date = ircLD_subsidy.Initial_Date,
        Final_Date = ircLD_subsidy.Final_Date,
        Star_Collect_Date = ircLD_subsidy.Star_Collect_Date,
        Conccodi = ircLD_subsidy.Conccodi,
        Validity_Year_Means = ircLD_subsidy.Validity_Year_Means,
        Authorize_Quantity = ircLD_subsidy.Authorize_Quantity,
        Authorize_Value = ircLD_subsidy.Authorize_Value,
        Remainder_Status = ircLD_subsidy.Remainder_Status,
        Total_Deliver = ircLD_subsidy.Total_Deliver,
        Total_Available = ircLD_subsidy.Total_Available,
        Promotion_Id = ircLD_subsidy.Promotion_Id,
        Origin_Subsidy = ircLD_subsidy.Origin_Subsidy
      where
        rowid = ircLD_subsidy.rowid
      returning
    SUBSIDY_Id
      into
        nuSUBSIDY_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_subsidy.SUBSIDY_Id,
          rcData
        );
      end if;

      update LD_subsidy
      set
        Description = ircLD_subsidy.Description,
        Deal_Id = ircLD_subsidy.Deal_Id,
        Initial_Date = ircLD_subsidy.Initial_Date,
        Final_Date = ircLD_subsidy.Final_Date,
        Star_Collect_Date = ircLD_subsidy.Star_Collect_Date,
        Conccodi = ircLD_subsidy.Conccodi,
        Validity_Year_Means = ircLD_subsidy.Validity_Year_Means,
        Authorize_Quantity = ircLD_subsidy.Authorize_Quantity,
        Authorize_Value = ircLD_subsidy.Authorize_Value,
        Remainder_Status = ircLD_subsidy.Remainder_Status,
        Total_Deliver = ircLD_subsidy.Total_Deliver,
        Total_Available = ircLD_subsidy.Total_Available,
        Promotion_Id = ircLD_subsidy.Promotion_Id,
        Origin_Subsidy = ircLD_subsidy.Origin_Subsidy
      where
             SUBSIDY_Id = ircLD_subsidy.SUBSIDY_Id
      returning
    SUBSIDY_Id
      into
        nuSUBSIDY_Id;
    end if;

    if
      nuSUBSIDY_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_subsidy));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_subsidy in out nocopy tytbLD_subsidy,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subsidy;
  BEGIN
    FillRecordOfTables(iotbLD_subsidy,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_subsidy.first .. iotbLD_subsidy.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy.first .. iotbLD_subsidy.last
        update LD_subsidy
        set

            Description = rcRecOfTab.Description(n),
            Deal_Id = rcRecOfTab.Deal_Id(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Star_Collect_Date = rcRecOfTab.Star_Collect_Date(n),
            Conccodi = rcRecOfTab.Conccodi(n),
            Validity_Year_Means = rcRecOfTab.Validity_Year_Means(n),
            Authorize_Quantity = rcRecOfTab.Authorize_Quantity(n),
            Authorize_Value = rcRecOfTab.Authorize_Value(n),
            Remainder_Status = rcRecOfTab.Remainder_Status(n),
            Total_Deliver = rcRecOfTab.Total_Deliver(n),
            Total_Available = rcRecOfTab.Total_Available(n),
            Promotion_Id = rcRecOfTab.Promotion_Id(n),
            Origin_Subsidy = rcRecOfTab.Origin_Subsidy(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subsidy.first .. iotbLD_subsidy.last loop
          LockByPk
          (
              rcRecOfTab.SUBSIDY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subsidy.first .. iotbLD_subsidy.last
        update LD_subsidy
        set
          Description = rcRecOfTab.Description(n),
          Deal_Id = rcRecOfTab.Deal_Id(n),
          Initial_Date = rcRecOfTab.Initial_Date(n),
          Final_Date = rcRecOfTab.Final_Date(n),
          Star_Collect_Date = rcRecOfTab.Star_Collect_Date(n),
          Conccodi = rcRecOfTab.Conccodi(n),
          Validity_Year_Means = rcRecOfTab.Validity_Year_Means(n),
          Authorize_Quantity = rcRecOfTab.Authorize_Quantity(n),
          Authorize_Value = rcRecOfTab.Authorize_Value(n),
          Remainder_Status = rcRecOfTab.Remainder_Status(n),
          Total_Deliver = rcRecOfTab.Total_Deliver(n),
          Total_Available = rcRecOfTab.Total_Available(n),
          Promotion_Id = rcRecOfTab.Promotion_Id(n),
          Origin_Subsidy = rcRecOfTab.Origin_Subsidy(n)
          where
          SUBSIDY_Id = rcRecOfTab.SUBSIDY_Id(n)
;
    end if;
  END;

  PROCEDURE updDescription
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    isbDescription$ in LD_subsidy.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Description = isbDescription$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDeal_Id
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuDeal_Id$ in LD_subsidy.Deal_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Deal_Id = inuDeal_Id$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Deal_Id:= inuDeal_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInitial_Date
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    idtInitial_Date$ in LD_subsidy.Initial_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Initial_Date = idtInitial_Date$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    idtFinal_Date$ in LD_subsidy.Final_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Final_Date = idtFinal_Date$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Final_Date:= idtFinal_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updStar_Collect_Date
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    idtStar_Collect_Date$ in LD_subsidy.Star_Collect_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Star_Collect_Date = idtStar_Collect_Date$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Star_Collect_Date:= idtStar_Collect_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updConccodi
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuConccodi$ in LD_subsidy.Conccodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Conccodi = inuConccodi$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Conccodi:= inuConccodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updValidity_Year_Means
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuValidity_Year_Means$ in LD_subsidy.Validity_Year_Means%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Validity_Year_Means = inuValidity_Year_Means$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Validity_Year_Means:= inuValidity_Year_Means$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAuthorize_Quantity
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuAuthorize_Quantity$ in LD_subsidy.Authorize_Quantity%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Authorize_Quantity = inuAuthorize_Quantity$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Authorize_Quantity:= inuAuthorize_Quantity$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAuthorize_Value
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuAuthorize_Value$ in LD_subsidy.Authorize_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Authorize_Value = inuAuthorize_Value$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Authorize_Value:= inuAuthorize_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRemainder_Status
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    isbRemainder_Status$ in LD_subsidy.Remainder_Status%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Remainder_Status = isbRemainder_Status$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Remainder_Status:= isbRemainder_Status$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTotal_Deliver
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuTotal_Deliver$ in LD_subsidy.Total_Deliver%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Total_Deliver = inuTotal_Deliver$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Total_Deliver:= inuTotal_Deliver$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTotal_Available
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuTotal_Available$ in LD_subsidy.Total_Available%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Total_Available = inuTotal_Available$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Total_Available:= inuTotal_Available$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPromotion_Id
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuPromotion_Id$ in LD_subsidy.Promotion_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Promotion_Id = inuPromotion_Id$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Promotion_Id:= inuPromotion_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updOrigin_Subsidy
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuOrigin_Subsidy$ in LD_subsidy.Origin_Subsidy%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subsidy;
  BEGIN
    rcError.SUBSIDY_Id := inuSUBSIDY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBSIDY_Id,
        rcData
      );
    end if;

    update LD_subsidy
    set
      Origin_Subsidy = inuOrigin_Subsidy$
    where
      SUBSIDY_Id = inuSUBSIDY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Origin_Subsidy:= inuOrigin_Subsidy$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSubsidy_Id
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Subsidy_Id%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Subsidy_Id);
    end if;
    Load
    (
      inuSUBSIDY_Id
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

  FUNCTION fsbGetDescription
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Description%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuSUBSIDY_Id
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

  FUNCTION fnuGetDeal_Id
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Deal_Id%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Deal_Id);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Deal_Id);
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Initial_Date%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_Id
       )
    then
       return(rcData.Initial_Date);
    end if;
    Load
    (
         inuSUBSIDY_Id
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Final_Date%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_Id
       )
    then
       return(rcData.Final_Date);
    end if;
    Load
    (
         inuSUBSIDY_Id
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

  FUNCTION fdtGetStar_Collect_Date
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Star_Collect_Date%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBSIDY_Id
       )
    then
       return(rcData.Star_Collect_Date);
    end if;
    Load
    (
         inuSUBSIDY_Id
    );
    return(rcData.Star_Collect_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetConccodi
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Conccodi%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Conccodi);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Conccodi);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetValidity_Year_Means
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Validity_Year_Means%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Validity_Year_Means);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Validity_Year_Means);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAuthorize_Quantity
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Authorize_Quantity%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Authorize_Quantity);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Authorize_Quantity);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAuthorize_Value
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Authorize_Value%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Authorize_Value);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Authorize_Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetRemainder_Status
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Remainder_Status%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id:=inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Remainder_Status);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Remainder_Status);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTotal_Deliver
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Total_Deliver%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Total_Deliver);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Total_Deliver);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTotal_Available
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Total_Available%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Total_Available);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Total_Available);
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
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Promotion_Id%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Promotion_Id);
    end if;
    Load
    (
      inuSUBSIDY_Id
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

  FUNCTION fnuGetOrigin_Subsidy
  (
    inuSUBSIDY_Id in LD_subsidy.SUBSIDY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subsidy.Origin_Subsidy%type
  IS
    rcError styLD_subsidy;
  BEGIN

    rcError.SUBSIDY_Id := inuSUBSIDY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBSIDY_Id
       )
    then
       return(rcData.Origin_Subsidy);
    end if;
    Load
    (
      inuSUBSIDY_Id
    );
    return(rcData.Origin_Subsidy);
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
end DALD_subsidy;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUBSIDY
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUBSIDY', 'ADM_PERSON');
END;
/