CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_sub_remain_deliv IS
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord(
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type) IS
    SELECT LD_sub_remain_deliv.*,LD_sub_remain_deliv.rowid
    FROM LD_sub_remain_deliv
    WHERE
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId(
    irirowid in varchar2) IS
    SELECT LD_sub_remain_deliv.*,LD_sub_remain_deliv.rowid
    FROM LD_sub_remain_deliv
    WHERE rowId = irirowid;


  /* Subtipos */
  subtype styLD_sub_remain_deliv  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_sub_remain_deliv is table of styLD_sub_remain_deliv index by binary_integer;
  type tyrfRecords is ref cursor return styLD_sub_remain_deliv;

  /* Tipos referenciando al registro */
  type tytbSub_Remain_Deliv_Id is table of LD_sub_remain_deliv.Sub_Remain_Deliv_Id%type index by binary_integer;
  type tytbSubsidy_Id is table of LD_sub_remain_deliv.Subsidy_Id%type index by binary_integer;
  type tytbSusccodi is table of LD_sub_remain_deliv.Susccodi%type index by binary_integer;
  type tytbSesunuse is table of LD_sub_remain_deliv.Sesunuse%type index by binary_integer;
  type tytbDelivery_Total is table of LD_sub_remain_deliv.Delivery_Total%type index by binary_integer;
  type tytbState_Delivery is table of LD_sub_remain_deliv.State_Delivery%type index by binary_integer;
  type tytbUser_Id is table of LD_sub_remain_deliv.User_Id%type index by binary_integer;
  type tytbTerminal is table of LD_sub_remain_deliv.Terminal%type index by binary_integer;
  type tytbUbication_Id is table of LD_sub_remain_deliv.Ubication_Id%type index by binary_integer;
  type tytbSesion is table of LD_sub_remain_deliv.Sesion%type index by binary_integer;
  type tytbAsig_Value is table of LD_sub_remain_deliv.Asig_Value%type index by binary_integer;
  type tytbAsig_Subsidy_Id is table of LD_sub_remain_deliv.Asig_Subsidy_Id%type index by binary_integer;
  type tytbRemain_Value is table of LD_sub_remain_deliv.Remain_Value%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_sub_remain_deliv is record(

    Sub_Remain_Deliv_Id   tytbSub_Remain_Deliv_Id,
    Subsidy_Id   tytbSubsidy_Id,
    Susccodi   tytbSusccodi,
    Sesunuse   tytbSesunuse,
    Delivery_Total   tytbDelivery_Total,
    State_Delivery   tytbState_Delivery,
    User_Id   tytbUser_Id,
    Terminal   tytbTerminal,
    Ubication_Id   tytbUbication_Id,
    Sesion   tytbSesion,
    Asig_Value   tytbAsig_Value,
    Asig_Subsidy_Id   tytbAsig_Subsidy_Id,
    Remain_Value   tytbRemain_Value,
    row_id tytbrowid);


   /***** Metodos Publicos ****/
  /*Obtener el ID de la tabla en Ge_Entity*/
  FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
     RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

  FUNCTION fsbGetMessageDescription return varchar2;

  PROCEDURE ClearMemory;

   FUNCTION fblExist(
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type) RETURN boolean;

   PROCEDURE AccKey(
     inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type);

  PROCEDURE AccKeyByRowId(
    iriRowID    in rowid);

  PROCEDURE ValDuplicate(
     inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type);

  PROCEDURE getRecord(
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    orcRecord out nocopy styLD_sub_remain_deliv
  );

  FUNCTION frcGetRcData(
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type)
  RETURN styLD_sub_remain_deliv;

  FUNCTION frcGetRcData
  RETURN styLD_sub_remain_deliv;

  FUNCTION frcGetRecord(
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type)
  RETURN styLD_sub_remain_deliv;

  PROCEDURE getRecords(
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sub_remain_deliv
  );

  FUNCTION frfGetRecords(
    isbCriteria in varchar2 default null,
    iblLock in boolean default false)
  RETURN tyRefCursor;

  PROCEDURE insRecord(
    ircLD_sub_remain_deliv in styLD_sub_remain_deliv
  );

     PROCEDURE insRecord(
    ircLD_sub_remain_deliv in styLD_sub_remain_deliv,
    orirowid   out varchar2);

  PROCEDURE insRecords(
    iotbLD_sub_remain_deliv in out nocopy tytbLD_sub_remain_deliv
  );

  PROCEDURE delRecord(
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type, inuLock in number default 1);

  PROCEDURE delByRowID(
    iriRowID    in rowid,
    inuLock in number default 1);

  PROCEDURE delRecords
  (
    iotbLD_sub_remain_deliv in out nocopy tytbLD_sub_remain_deliv,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_sub_remain_deliv in styLD_sub_remain_deliv,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_sub_remain_deliv in out nocopy tytbLD_sub_remain_deliv,
    inuLock in number default 1
  );

    PROCEDURE updSubsidy_Id
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuSubsidy_Id$  in LD_sub_remain_deliv.Subsidy_Id%type,
        inuLock    in number default 0);

    PROCEDURE updSusccodi
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuSusccodi$  in LD_sub_remain_deliv.Susccodi%type,
        inuLock    in number default 0);

    PROCEDURE updSesunuse
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuSesunuse$  in LD_sub_remain_deliv.Sesunuse%type,
        inuLock    in number default 0);

    PROCEDURE updDelivery_Total
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuDelivery_Total$  in LD_sub_remain_deliv.Delivery_Total%type,
        inuLock    in number default 0);

    PROCEDURE updState_Delivery
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        isbState_Delivery$  in LD_sub_remain_deliv.State_Delivery%type,
        inuLock    in number default 0);

    PROCEDURE updUser_Id
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        isbUser_Id$  in LD_sub_remain_deliv.User_Id%type,
        inuLock    in number default 0);

    PROCEDURE updTerminal
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        isbTerminal$  in LD_sub_remain_deliv.Terminal%type,
        inuLock    in number default 0);

    PROCEDURE updUbication_Id
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuUbication_Id$  in LD_sub_remain_deliv.Ubication_Id%type,
        inuLock    in number default 0);

    PROCEDURE updSesion
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuSesion$  in LD_sub_remain_deliv.Sesion%type,
        inuLock    in number default 0);

    PROCEDURE updAsig_Value
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuAsig_Value$  in LD_sub_remain_deliv.Asig_Value%type,
        inuLock    in number default 0);

    PROCEDURE updAsig_Subsidy_Id
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuAsig_Subsidy_Id$  in LD_sub_remain_deliv.Asig_Subsidy_Id%type,
        inuLock    in number default 0);

    PROCEDURE updRemain_Value
    (
        inuSUB_REMAIN_DELIV_Id   in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
        inuRemain_Value$  in LD_sub_remain_deliv.Remain_Value%type,
        inuLock    in number default 0);

      FUNCTION fnuGetSub_Remain_Deliv_Id
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Sub_Remain_Deliv_Id%type;

      FUNCTION fnuGetSubsidy_Id
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Subsidy_Id%type;

      FUNCTION fnuGetSusccodi
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Susccodi%type;

      FUNCTION fnuGetSesunuse
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Sesunuse%type;

      FUNCTION fnuGetDelivery_Total
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Delivery_Total%type;

      FUNCTION fsbGetState_Delivery
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.State_Delivery%type;

      FUNCTION fsbGetUser_Id
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.User_Id%type;

      FUNCTION fsbGetTerminal
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Terminal%type;

      FUNCTION fnuGetUbication_Id
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Ubication_Id%type;

      FUNCTION fnuGetSesion
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Sesion%type;

      FUNCTION fnuGetAsig_Value
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Asig_Value%type;

      FUNCTION fnuGetAsig_Subsidy_Id
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Asig_Subsidy_Id%type;

      FUNCTION fnuGetRemain_Value
      (
          inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sub_remain_deliv.Remain_Value%type;


  PROCEDURE LockByPk
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    orcLD_sub_remain_deliv  out styLD_sub_remain_deliv
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_sub_remain_deliv  out styLD_sub_remain_deliv
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_sub_remain_deliv;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_sub_remain_deliv
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUB_REMAIN_DELIV';
    cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_SUB_REMAIN_DELIV'); -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  IS
    SELECT LD_sub_remain_deliv.*,LD_sub_remain_deliv.rowid
    FROM LD_sub_remain_deliv
    WHERE  SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sub_remain_deliv.*,LD_sub_remain_deliv.rowid
    FROM LD_sub_remain_deliv
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_sub_remain_deliv is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_sub_remain_deliv;

  rcData cuRecord%rowtype;

   blDAO_USE_CACHE    boolean := null;

  /* Metodos privados */
  /*Obtener el ID de la tabla en Ge_Entity*/
  FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
     RETURN ge_entity.entity_id%TYPE IS
     nuEntityId ge_entity.entity_id%TYPE;
     BEGIN
     SELECT ge_entity.entity_id
     INTO   nuEntityId
     FROM   ge_entity
     WHERE  ge_entity.name_ = isbTName;
     RETURN nuEntityId;
  EXCEPTION
     WHEN ex.CONTROLLED_ERROR THEN
          RAISE ex.CONTROLLED_ERROR;
     WHEN OTHERS THEN
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
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

  FUNCTION fsbPrimaryKey( rcI in styLD_sub_remain_deliv default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUB_REMAIN_DELIV_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    orcLD_sub_remain_deliv  out styLD_sub_remain_deliv
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    Open cuLockRcByPk
    (
      inuSUB_REMAIN_DELIV_Id
    );

    fetch cuLockRcByPk into orcLD_sub_remain_deliv;
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
    orcLD_sub_remain_deliv  out styLD_sub_remain_deliv
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_sub_remain_deliv;
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
    itbLD_sub_remain_deliv  in out nocopy tytbLD_sub_remain_deliv
  )
  IS
  BEGIN
      rcRecOfTab.Sub_Remain_Deliv_Id.delete;
      rcRecOfTab.Subsidy_Id.delete;
      rcRecOfTab.Susccodi.delete;
      rcRecOfTab.Sesunuse.delete;
      rcRecOfTab.Delivery_Total.delete;
      rcRecOfTab.State_Delivery.delete;
      rcRecOfTab.User_Id.delete;
      rcRecOfTab.Terminal.delete;
      rcRecOfTab.Ubication_Id.delete;
      rcRecOfTab.Sesion.delete;
      rcRecOfTab.Asig_Value.delete;
      rcRecOfTab.Asig_Subsidy_Id.delete;
      rcRecOfTab.Remain_Value.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_sub_remain_deliv  in out nocopy tytbLD_sub_remain_deliv,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_sub_remain_deliv);
    for n in itbLD_sub_remain_deliv.first .. itbLD_sub_remain_deliv.last loop
      rcRecOfTab.Sub_Remain_Deliv_Id(n) := itbLD_sub_remain_deliv(n).Sub_Remain_Deliv_Id;
      rcRecOfTab.Subsidy_Id(n) := itbLD_sub_remain_deliv(n).Subsidy_Id;
      rcRecOfTab.Susccodi(n) := itbLD_sub_remain_deliv(n).Susccodi;
      rcRecOfTab.Sesunuse(n) := itbLD_sub_remain_deliv(n).Sesunuse;
      rcRecOfTab.Delivery_Total(n) := itbLD_sub_remain_deliv(n).Delivery_Total;
      rcRecOfTab.State_Delivery(n) := itbLD_sub_remain_deliv(n).State_Delivery;
      rcRecOfTab.User_Id(n) := itbLD_sub_remain_deliv(n).User_Id;
      rcRecOfTab.Terminal(n) := itbLD_sub_remain_deliv(n).Terminal;
      rcRecOfTab.Ubication_Id(n) := itbLD_sub_remain_deliv(n).Ubication_Id;
      rcRecOfTab.Sesion(n) := itbLD_sub_remain_deliv(n).Sesion;
      rcRecOfTab.Asig_Value(n) := itbLD_sub_remain_deliv(n).Asig_Value;
      rcRecOfTab.Asig_Subsidy_Id(n) := itbLD_sub_remain_deliv(n).Asig_Subsidy_Id;
      rcRecOfTab.Remain_Value(n) := itbLD_sub_remain_deliv(n).Remain_Value;
      rcRecOfTab.row_id(n) := itbLD_sub_remain_deliv(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUB_REMAIN_DELIV_Id
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
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUB_REMAIN_DELIV_Id = rcData.SUB_REMAIN_DELIV_Id
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
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    Load
    (
      inuSUB_REMAIN_DELIV_Id
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
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    orcRecord out nocopy styLD_sub_remain_deliv
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  RETURN styLD_sub_remain_deliv
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type
  )
  RETURN styLD_sub_remain_deliv
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_sub_remain_deliv
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sub_remain_deliv
  )
  IS
    rfLD_sub_remain_deliv tyrfLD_sub_remain_deliv;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT LD_sub_remain_deliv.*,
                LD_sub_remain_deliv.rowid
                FROM LD_sub_remain_deliv';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_sub_remain_deliv for sbFullQuery;
    fetch rfLD_sub_remain_deliv bulk collect INTO otbResult;
    close rfLD_sub_remain_deliv;
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
    sbSQL  VARCHAR2 (32000) := 'select LD_sub_remain_deliv.*,
                LD_sub_remain_deliv.rowid
                FROM LD_sub_remain_deliv';
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
    ircLD_sub_remain_deliv in styLD_sub_remain_deliv
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_sub_remain_deliv,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_sub_remain_deliv in styLD_sub_remain_deliv,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_sub_remain_deliv.SUB_REMAIN_DELIV_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUB_REMAIN_DELIV_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_sub_remain_deliv
    (
      Sub_Remain_Deliv_Id,
      Subsidy_Id,
      Susccodi,
      Sesunuse,
      Delivery_Total,
      State_Delivery,
      User_Id,
      Terminal,
      Ubication_Id,
      Sesion,
      Asig_Value,
      Asig_Subsidy_Id,
      Remain_Value
    )
    values
    (
      ircLD_sub_remain_deliv.Sub_Remain_Deliv_Id,
      ircLD_sub_remain_deliv.Subsidy_Id,
      ircLD_sub_remain_deliv.Susccodi,
      ircLD_sub_remain_deliv.Sesunuse,
      ircLD_sub_remain_deliv.Delivery_Total,
      ircLD_sub_remain_deliv.State_Delivery,
      ircLD_sub_remain_deliv.User_Id,
      ircLD_sub_remain_deliv.Terminal,
      ircLD_sub_remain_deliv.Ubication_Id,
      ircLD_sub_remain_deliv.Sesion,
      ircLD_sub_remain_deliv.Asig_Value,
      ircLD_sub_remain_deliv.Asig_Subsidy_Id,
      ircLD_sub_remain_deliv.Remain_Value
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_sub_remain_deliv));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_sub_remain_deliv in out nocopy tytbLD_sub_remain_deliv
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_sub_remain_deliv, blUseRowID);
    forall n in iotbLD_sub_remain_deliv.first..iotbLD_sub_remain_deliv.last
      insert into LD_sub_remain_deliv
      (
      Sub_Remain_Deliv_Id,
      Subsidy_Id,
      Susccodi,
      Sesunuse,
      Delivery_Total,
      State_Delivery,
      User_Id,
      Terminal,
      Ubication_Id,
      Sesion,
      Asig_Value,
      Asig_Subsidy_Id,
      Remain_Value
    )
    values
    (
      rcRecOfTab.Sub_Remain_Deliv_Id(n),
      rcRecOfTab.Subsidy_Id(n),
      rcRecOfTab.Susccodi(n),
      rcRecOfTab.Sesunuse(n),
      rcRecOfTab.Delivery_Total(n),
      rcRecOfTab.State_Delivery(n),
      rcRecOfTab.User_Id(n),
      rcRecOfTab.Terminal(n),
      rcRecOfTab.Ubication_Id(n),
      rcRecOfTab.Sesion(n),
      rcRecOfTab.Asig_Value(n),
      rcRecOfTab.Asig_Subsidy_Id(n),
      rcRecOfTab.Remain_Value(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    delete
    from LD_sub_remain_deliv
    where
           SUB_REMAIN_DELIV_Id=inuSUB_REMAIN_DELIV_Id;
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
    rcError  styLD_sub_remain_deliv;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_sub_remain_deliv
    where
      rowid = iriRowID
    returning
   SUB_REMAIN_DELIV_Id
    into
      rcError.SUB_REMAIN_DELIV_Id;

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
    iotbLD_sub_remain_deliv in out nocopy tytbLD_sub_remain_deliv,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sub_remain_deliv;
  BEGIN
    FillRecordOfTables(iotbLD_sub_remain_deliv, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last
        delete
        from LD_sub_remain_deliv
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last loop
          LockByPk
          (
              rcRecOfTab.SUB_REMAIN_DELIV_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last
        delete
        from LD_sub_remain_deliv
        where
               SUB_REMAIN_DELIV_Id = rcRecOfTab.SUB_REMAIN_DELIV_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_sub_remain_deliv in styLD_sub_remain_deliv,
    inuLock    in number default 0
  )
  IS
    nuSUB_REMAIN_DELIV_Id LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type;

  BEGIN
    if ircLD_sub_remain_deliv.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_sub_remain_deliv.rowid,rcData);
      end if;
      update LD_sub_remain_deliv
      set

        Subsidy_Id = ircLD_sub_remain_deliv.Subsidy_Id,
        Susccodi = ircLD_sub_remain_deliv.Susccodi,
        Sesunuse = ircLD_sub_remain_deliv.Sesunuse,
        Delivery_Total = ircLD_sub_remain_deliv.Delivery_Total,
        State_Delivery = ircLD_sub_remain_deliv.State_Delivery,
        User_Id = ircLD_sub_remain_deliv.User_Id,
        Terminal = ircLD_sub_remain_deliv.Terminal,
        Ubication_Id = ircLD_sub_remain_deliv.Ubication_Id,
        Sesion = ircLD_sub_remain_deliv.Sesion,
        Asig_Value = ircLD_sub_remain_deliv.Asig_Value,
        Asig_Subsidy_Id = ircLD_sub_remain_deliv.Asig_Subsidy_Id,
        Remain_Value = ircLD_sub_remain_deliv.Remain_Value
      where
        rowid = ircLD_sub_remain_deliv.rowid
      returning
    SUB_REMAIN_DELIV_Id
      into
        nuSUB_REMAIN_DELIV_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_sub_remain_deliv.SUB_REMAIN_DELIV_Id,
          rcData
        );
      end if;

      update LD_sub_remain_deliv
      set
        Subsidy_Id = ircLD_sub_remain_deliv.Subsidy_Id,
        Susccodi = ircLD_sub_remain_deliv.Susccodi,
        Sesunuse = ircLD_sub_remain_deliv.Sesunuse,
        Delivery_Total = ircLD_sub_remain_deliv.Delivery_Total,
        State_Delivery = ircLD_sub_remain_deliv.State_Delivery,
        User_Id = ircLD_sub_remain_deliv.User_Id,
        Terminal = ircLD_sub_remain_deliv.Terminal,
        Ubication_Id = ircLD_sub_remain_deliv.Ubication_Id,
        Sesion = ircLD_sub_remain_deliv.Sesion,
        Asig_Value = ircLD_sub_remain_deliv.Asig_Value,
        Asig_Subsidy_Id = ircLD_sub_remain_deliv.Asig_Subsidy_Id,
        Remain_Value = ircLD_sub_remain_deliv.Remain_Value
      where
             SUB_REMAIN_DELIV_Id = ircLD_sub_remain_deliv.SUB_REMAIN_DELIV_Id
      returning
    SUB_REMAIN_DELIV_Id
      into
        nuSUB_REMAIN_DELIV_Id;
    end if;

    if
      nuSUB_REMAIN_DELIV_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_sub_remain_deliv));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_sub_remain_deliv in out nocopy tytbLD_sub_remain_deliv,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sub_remain_deliv;
  BEGIN
    FillRecordOfTables(iotbLD_sub_remain_deliv,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last
        update LD_sub_remain_deliv
        set

            Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
            Susccodi = rcRecOfTab.Susccodi(n),
            Sesunuse = rcRecOfTab.Sesunuse(n),
            Delivery_Total = rcRecOfTab.Delivery_Total(n),
            State_Delivery = rcRecOfTab.State_Delivery(n),
            User_Id = rcRecOfTab.User_Id(n),
            Terminal = rcRecOfTab.Terminal(n),
            Ubication_Id = rcRecOfTab.Ubication_Id(n),
            Sesion = rcRecOfTab.Sesion(n),
            Asig_Value = rcRecOfTab.Asig_Value(n),
            Asig_Subsidy_Id = rcRecOfTab.Asig_Subsidy_Id(n),
            Remain_Value = rcRecOfTab.Remain_Value(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last loop
          LockByPk
          (
              rcRecOfTab.SUB_REMAIN_DELIV_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sub_remain_deliv.first .. iotbLD_sub_remain_deliv.last
        update LD_sub_remain_deliv
        set
          Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
          Susccodi = rcRecOfTab.Susccodi(n),
          Sesunuse = rcRecOfTab.Sesunuse(n),
          Delivery_Total = rcRecOfTab.Delivery_Total(n),
          State_Delivery = rcRecOfTab.State_Delivery(n),
          User_Id = rcRecOfTab.User_Id(n),
          Terminal = rcRecOfTab.Terminal(n),
          Ubication_Id = rcRecOfTab.Ubication_Id(n),
          Sesion = rcRecOfTab.Sesion(n),
          Asig_Value = rcRecOfTab.Asig_Value(n),
          Asig_Subsidy_Id = rcRecOfTab.Asig_Subsidy_Id(n),
          Remain_Value = rcRecOfTab.Remain_Value(n)
          where
          SUB_REMAIN_DELIV_Id = rcRecOfTab.SUB_REMAIN_DELIV_Id(n)
;
    end if;
  END;

  PROCEDURE updSubsidy_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuSubsidy_Id$ in LD_sub_remain_deliv.Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Subsidy_Id = inuSubsidy_Id$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Id:= inuSubsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSusccodi
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuSusccodi$ in LD_sub_remain_deliv.Susccodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Susccodi = inuSusccodi$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Susccodi:= inuSusccodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSesunuse
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuSesunuse$ in LD_sub_remain_deliv.Sesunuse%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Sesunuse = inuSesunuse$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sesunuse:= inuSesunuse$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDelivery_Total
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuDelivery_Total$ in LD_sub_remain_deliv.Delivery_Total%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Delivery_Total = inuDelivery_Total$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Delivery_Total:= inuDelivery_Total$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updState_Delivery
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    isbState_Delivery$ in LD_sub_remain_deliv.State_Delivery%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      State_Delivery = isbState_Delivery$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.State_Delivery:= isbState_Delivery$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updUser_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    isbUser_Id$ in LD_sub_remain_deliv.User_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      User_Id = isbUser_Id$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.User_Id:= isbUser_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTerminal
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    isbTerminal$ in LD_sub_remain_deliv.Terminal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Terminal = isbTerminal$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Terminal:= isbTerminal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updUbication_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuUbication_Id$ in LD_sub_remain_deliv.Ubication_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Ubication_Id = inuUbication_Id$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ubication_Id:= inuUbication_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSesion
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuSesion$ in LD_sub_remain_deliv.Sesion%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Sesion = inuSesion$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sesion:= inuSesion$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAsig_Value
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuAsig_Value$ in LD_sub_remain_deliv.Asig_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Asig_Value = inuAsig_Value$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Asig_Value:= inuAsig_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAsig_Subsidy_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuAsig_Subsidy_Id$ in LD_sub_remain_deliv.Asig_Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Asig_Subsidy_Id = inuAsig_Subsidy_Id$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Asig_Subsidy_Id:= inuAsig_Subsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRemain_Value
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRemain_Value$ in LD_sub_remain_deliv.Remain_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN
    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUB_REMAIN_DELIV_Id,
        rcData
      );
    end if;

    update LD_sub_remain_deliv
    set
      Remain_Value = inuRemain_Value$
    where
      SUB_REMAIN_DELIV_Id = inuSUB_REMAIN_DELIV_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Remain_Value:= inuRemain_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSub_Remain_Deliv_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Sub_Remain_Deliv_Id%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Sub_Remain_Deliv_Id);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData.Sub_Remain_Deliv_Id);
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
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Subsidy_Id%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Subsidy_Id);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fnuGetSusccodi
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Susccodi%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Susccodi);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fnuGetSesunuse
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Sesunuse%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Sesunuse);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData.Sesunuse);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetDelivery_Total
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Delivery_Total%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Delivery_Total);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData.Delivery_Total);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetState_Delivery
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.State_Delivery%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.State_Delivery);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData.State_Delivery);
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
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.User_Id%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.User_Id);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fsbGetTerminal
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Terminal%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id:=inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Terminal);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fnuGetUbication_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Ubication_Id%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Ubication_Id);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fnuGetSesion
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Sesion%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Sesion);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fnuGetAsig_Value
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Asig_Value%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Asig_Value);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData.Asig_Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAsig_Subsidy_Id
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Asig_Subsidy_Id%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Asig_Subsidy_Id);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
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

  FUNCTION fnuGetRemain_Value
  (
    inuSUB_REMAIN_DELIV_Id in LD_sub_remain_deliv.SUB_REMAIN_DELIV_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sub_remain_deliv.Remain_Value%type
  IS
    rcError styLD_sub_remain_deliv;
  BEGIN

    rcError.SUB_REMAIN_DELIV_Id := inuSUB_REMAIN_DELIV_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUB_REMAIN_DELIV_Id
       )
    then
       return(rcData.Remain_Value);
    end if;
    Load
    (
      inuSUB_REMAIN_DELIV_Id
    );
    return(rcData.Remain_Value);
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
end DALD_sub_remain_deliv;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUB_REMAIN_DELIV
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUB_REMAIN_DELIV', 'ADM_PERSON');
END;
/
