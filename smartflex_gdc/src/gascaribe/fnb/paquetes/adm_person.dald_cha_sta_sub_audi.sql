CREATE OR REPLACE PACKAGE adm_person.dald_cha_sta_sub_audi
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  IS
    SELECT LD_cha_sta_sub_audi.*,LD_cha_sta_sub_audi.rowid
    FROM LD_cha_sta_sub_audi
    WHERE
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_cha_sta_sub_audi.*,LD_cha_sta_sub_audi.rowid
    FROM LD_cha_sta_sub_audi
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_cha_sta_sub_audi  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_cha_sta_sub_audi is table of styLD_cha_sta_sub_audi index by binary_integer;
  type tyrfRecords is ref cursor return styLD_cha_sta_sub_audi;

  /* Tipos referenciando al registro */
  type tytbCha_Sta_Sub_Audi_Id is table of LD_cha_sta_sub_audi.Cha_Sta_Sub_Audi_Id%type index by binary_integer;
  type tytbAsig_Subsidy_Id is table of LD_cha_sta_sub_audi.Asig_Subsidy_Id%type index by binary_integer;
  type tytbLast_State is table of LD_cha_sta_sub_audi.Last_State%type index by binary_integer;
  type tytbNew_State is table of LD_cha_sta_sub_audi.New_State%type index by binary_integer;
  type tytbRegister_Date is table of LD_cha_sta_sub_audi.Register_Date%type index by binary_integer;
  type tytbCon_User is table of LD_cha_sta_sub_audi.Con_User%type index by binary_integer;
  type tytbTerminal is table of LD_cha_sta_sub_audi.Terminal%type index by binary_integer;
  type tytbPay_Entity is table of LD_cha_sta_sub_audi.Pay_Entity%type index by binary_integer;
  type tytbPay_Place is table of LD_cha_sta_sub_audi.Pay_Place%type index by binary_integer;
  type tytbTransfer_Number is table of LD_cha_sta_sub_audi.Transfer_Number%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_cha_sta_sub_audi is record
  (

    Cha_Sta_Sub_Audi_Id   tytbCha_Sta_Sub_Audi_Id,
    Asig_Subsidy_Id   tytbAsig_Subsidy_Id,
    Last_State   tytbLast_State,
    New_State   tytbNew_State,
    Register_Date   tytbRegister_Date,
    Con_User   tytbCon_User,
    Terminal   tytbTerminal,
    Pay_Entity   tytbPay_Entity,
    Pay_Place   tytbPay_Place,
    Transfer_Number   tytbTransfer_Number,
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
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  );

  PROCEDURE getRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    orcRecord out nocopy styLD_cha_sta_sub_audi
  );

  FUNCTION frcGetRcData
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN styLD_cha_sta_sub_audi;

  FUNCTION frcGetRcData
  RETURN styLD_cha_sta_sub_audi;

  FUNCTION frcGetRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN styLD_cha_sta_sub_audi;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_cha_sta_sub_audi
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_cha_sta_sub_audi in styLD_cha_sta_sub_audi
  );

     PROCEDURE insRecord
  (
    ircLD_cha_sta_sub_audi in styLD_cha_sta_sub_audi,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_cha_sta_sub_audi in out nocopy tytbLD_cha_sta_sub_audi
  );

  PROCEDURE delRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_cha_sta_sub_audi in out nocopy tytbLD_cha_sta_sub_audi,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_cha_sta_sub_audi in styLD_cha_sta_sub_audi,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_cha_sta_sub_audi in out nocopy tytbLD_cha_sta_sub_audi,
    inuLock in number default 1
  );

    PROCEDURE updAsig_Subsidy_Id
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        inuAsig_Subsidy_Id$  in LD_cha_sta_sub_audi.Asig_Subsidy_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updLast_State
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        inuLast_State$  in LD_cha_sta_sub_audi.Last_State%type,
        inuLock    in number default 0
      );

    PROCEDURE updNew_State
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        inuNew_State$  in LD_cha_sta_sub_audi.New_State%type,
        inuLock    in number default 0
      );

    PROCEDURE updRegister_Date
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        idtRegister_Date$  in LD_cha_sta_sub_audi.Register_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updCon_User
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        isbCon_User$  in LD_cha_sta_sub_audi.Con_User%type,
        inuLock    in number default 0
      );

    PROCEDURE updTerminal
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        isbTerminal$  in LD_cha_sta_sub_audi.Terminal%type,
        inuLock    in number default 0
      );

    PROCEDURE updPay_Entity
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        inuPay_Entity$  in LD_cha_sta_sub_audi.Pay_Entity%type,
        inuLock    in number default 0
      );

    PROCEDURE updPay_Place
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        isbPay_Place$  in LD_cha_sta_sub_audi.Pay_Place%type,
        inuLock    in number default 0
      );

    PROCEDURE updTransfer_Number
    (
        inuCHA_STA_SUB_AUDI_Id   in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
        inuTransfer_Number$  in LD_cha_sta_sub_audi.Transfer_Number%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCha_Sta_Sub_Audi_Id
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Cha_Sta_Sub_Audi_Id%type;

      FUNCTION fnuGetAsig_Subsidy_Id
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Asig_Subsidy_Id%type;

      FUNCTION fnuGetLast_State
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Last_State%type;

      FUNCTION fnuGetNew_State
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.New_State%type;

      FUNCTION fdtGetRegister_Date
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Register_Date%type;

      FUNCTION fsbGetCon_User
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Con_User%type;

      FUNCTION fsbGetTerminal
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Terminal%type;

      FUNCTION fnuGetPay_Entity
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Pay_Entity%type;

      FUNCTION fsbGetPay_Place
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Pay_Place%type;

      FUNCTION fnuGetTransfer_Number
      (
          inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_cha_sta_sub_audi.Transfer_Number%type;


  PROCEDURE LockByPk
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    orcLD_cha_sta_sub_audi  out styLD_cha_sta_sub_audi
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_cha_sta_sub_audi  out styLD_cha_sta_sub_audi
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_cha_sta_sub_audi;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_cha_sta_sub_audi
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CHA_STA_SUB_AUDI';
    cnuGeEntityId constant varchar2(30) := 8218; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  IS
    SELECT LD_cha_sta_sub_audi.*,LD_cha_sta_sub_audi.rowid
    FROM LD_cha_sta_sub_audi
    WHERE  CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_cha_sta_sub_audi.*,LD_cha_sta_sub_audi.rowid
    FROM LD_cha_sta_sub_audi
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_cha_sta_sub_audi is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_cha_sta_sub_audi;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_cha_sta_sub_audi default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.CHA_STA_SUB_AUDI_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    orcLD_cha_sta_sub_audi  out styLD_cha_sta_sub_audi
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    Open cuLockRcByPk
    (
      inuCHA_STA_SUB_AUDI_Id
    );

    fetch cuLockRcByPk into orcLD_cha_sta_sub_audi;
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
    orcLD_cha_sta_sub_audi  out styLD_cha_sta_sub_audi
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_cha_sta_sub_audi;
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
    itbLD_cha_sta_sub_audi  in out nocopy tytbLD_cha_sta_sub_audi
  )
  IS
  BEGIN
      rcRecOfTab.Cha_Sta_Sub_Audi_Id.delete;
      rcRecOfTab.Asig_Subsidy_Id.delete;
      rcRecOfTab.Last_State.delete;
      rcRecOfTab.New_State.delete;
      rcRecOfTab.Register_Date.delete;
      rcRecOfTab.Con_User.delete;
      rcRecOfTab.Terminal.delete;
      rcRecOfTab.Pay_Entity.delete;
      rcRecOfTab.Pay_Place.delete;
      rcRecOfTab.Transfer_Number.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_cha_sta_sub_audi  in out nocopy tytbLD_cha_sta_sub_audi,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_cha_sta_sub_audi);
    for n in itbLD_cha_sta_sub_audi.first .. itbLD_cha_sta_sub_audi.last loop
      rcRecOfTab.Cha_Sta_Sub_Audi_Id(n) := itbLD_cha_sta_sub_audi(n).Cha_Sta_Sub_Audi_Id;
      rcRecOfTab.Asig_Subsidy_Id(n) := itbLD_cha_sta_sub_audi(n).Asig_Subsidy_Id;
      rcRecOfTab.Last_State(n) := itbLD_cha_sta_sub_audi(n).Last_State;
      rcRecOfTab.New_State(n) := itbLD_cha_sta_sub_audi(n).New_State;
      rcRecOfTab.Register_Date(n) := itbLD_cha_sta_sub_audi(n).Register_Date;
      rcRecOfTab.Con_User(n) := itbLD_cha_sta_sub_audi(n).Con_User;
      rcRecOfTab.Terminal(n) := itbLD_cha_sta_sub_audi(n).Terminal;
      rcRecOfTab.Pay_Entity(n) := itbLD_cha_sta_sub_audi(n).Pay_Entity;
      rcRecOfTab.Pay_Place(n) := itbLD_cha_sta_sub_audi(n).Pay_Place;
      rcRecOfTab.Transfer_Number(n) := itbLD_cha_sta_sub_audi(n).Transfer_Number;
      rcRecOfTab.row_id(n) := itbLD_cha_sta_sub_audi(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCHA_STA_SUB_AUDI_Id
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
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCHA_STA_SUB_AUDI_Id = rcData.CHA_STA_SUB_AUDI_Id
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
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    Load
    (
      inuCHA_STA_SUB_AUDI_Id
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
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    orcRecord out nocopy styLD_cha_sta_sub_audi
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN styLD_cha_sta_sub_audi
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type
  )
  RETURN styLD_cha_sta_sub_audi
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_cha_sta_sub_audi
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_cha_sta_sub_audi
  )
  IS
    rfLD_cha_sta_sub_audi tyrfLD_cha_sta_sub_audi;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_cha_sta_sub_audi.Cha_Sta_Sub_Audi_Id,
                LD_cha_sta_sub_audi.Asig_Subsidy_Id,
                LD_cha_sta_sub_audi.Last_State,
                LD_cha_sta_sub_audi.New_State,
                LD_cha_sta_sub_audi.Register_Date,
                LD_cha_sta_sub_audi.Con_User,
                LD_cha_sta_sub_audi.Terminal,
                LD_cha_sta_sub_audi.Pay_Entity,
                LD_cha_sta_sub_audi.Pay_Place,
                LD_cha_sta_sub_audi.Transfer_Number,
                LD_cha_sta_sub_audi.rowid
                FROM LD_cha_sta_sub_audi';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_cha_sta_sub_audi for sbFullQuery;
    fetch rfLD_cha_sta_sub_audi bulk collect INTO otbResult;
    close rfLD_cha_sta_sub_audi;
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
                LD_cha_sta_sub_audi.Cha_Sta_Sub_Audi_Id,
                LD_cha_sta_sub_audi.Asig_Subsidy_Id,
                LD_cha_sta_sub_audi.Last_State,
                LD_cha_sta_sub_audi.New_State,
                LD_cha_sta_sub_audi.Register_Date,
                LD_cha_sta_sub_audi.Con_User,
                LD_cha_sta_sub_audi.Terminal,
                LD_cha_sta_sub_audi.Pay_Entity,
                LD_cha_sta_sub_audi.Pay_Place,
                LD_cha_sta_sub_audi.Transfer_Number,
                LD_cha_sta_sub_audi.rowid
                FROM LD_cha_sta_sub_audi';
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
    ircLD_cha_sta_sub_audi in styLD_cha_sta_sub_audi
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_cha_sta_sub_audi,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_cha_sta_sub_audi in styLD_cha_sta_sub_audi,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|CHA_STA_SUB_AUDI_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_cha_sta_sub_audi
    (
      Cha_Sta_Sub_Audi_Id,
      Asig_Subsidy_Id,
      Last_State,
      New_State,
      Register_Date,
      Con_User,
      Terminal,
      Pay_Entity,
      Pay_Place,
      Transfer_Number
    )
    values
    (
      ircLD_cha_sta_sub_audi.Cha_Sta_Sub_Audi_Id,
      ircLD_cha_sta_sub_audi.Asig_Subsidy_Id,
      ircLD_cha_sta_sub_audi.Last_State,
      ircLD_cha_sta_sub_audi.New_State,
      ircLD_cha_sta_sub_audi.Register_Date,
      ircLD_cha_sta_sub_audi.Con_User,
      ircLD_cha_sta_sub_audi.Terminal,
      ircLD_cha_sta_sub_audi.Pay_Entity,
      ircLD_cha_sta_sub_audi.Pay_Place,
      ircLD_cha_sta_sub_audi.Transfer_Number
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_cha_sta_sub_audi));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_cha_sta_sub_audi in out nocopy tytbLD_cha_sta_sub_audi
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_cha_sta_sub_audi, blUseRowID);
    forall n in iotbLD_cha_sta_sub_audi.first..iotbLD_cha_sta_sub_audi.last
      insert into LD_cha_sta_sub_audi
      (
      Cha_Sta_Sub_Audi_Id,
      Asig_Subsidy_Id,
      Last_State,
      New_State,
      Register_Date,
      Con_User,
      Terminal,
      Pay_Entity,
      Pay_Place,
      Transfer_Number
    )
    values
    (
      rcRecOfTab.Cha_Sta_Sub_Audi_Id(n),
      rcRecOfTab.Asig_Subsidy_Id(n),
      rcRecOfTab.Last_State(n),
      rcRecOfTab.New_State(n),
      rcRecOfTab.Register_Date(n),
      rcRecOfTab.Con_User(n),
      rcRecOfTab.Terminal(n),
      rcRecOfTab.Pay_Entity(n),
      rcRecOfTab.Pay_Place(n),
      rcRecOfTab.Transfer_Number(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    delete
    from LD_cha_sta_sub_audi
    where
           CHA_STA_SUB_AUDI_Id=inuCHA_STA_SUB_AUDI_Id;
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
    rcError  styLD_cha_sta_sub_audi;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_cha_sta_sub_audi
    where
      rowid = iriRowID
    returning
   CHA_STA_SUB_AUDI_Id
    into
      rcError.CHA_STA_SUB_AUDI_Id;

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
    iotbLD_cha_sta_sub_audi in out nocopy tytbLD_cha_sta_sub_audi,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_cha_sta_sub_audi;
  BEGIN
    FillRecordOfTables(iotbLD_cha_sta_sub_audi, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last
        delete
        from LD_cha_sta_sub_audi
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last loop
          LockByPk
          (
              rcRecOfTab.CHA_STA_SUB_AUDI_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last
        delete
        from LD_cha_sta_sub_audi
        where
               CHA_STA_SUB_AUDI_Id = rcRecOfTab.CHA_STA_SUB_AUDI_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_cha_sta_sub_audi in styLD_cha_sta_sub_audi,
    inuLock    in number default 0
  )
  IS
    nuCHA_STA_SUB_AUDI_Id LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type;

  BEGIN
    if ircLD_cha_sta_sub_audi.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_cha_sta_sub_audi.rowid,rcData);
      end if;
      update LD_cha_sta_sub_audi
      set

        Asig_Subsidy_Id = ircLD_cha_sta_sub_audi.Asig_Subsidy_Id,
        Last_State = ircLD_cha_sta_sub_audi.Last_State,
        New_State = ircLD_cha_sta_sub_audi.New_State,
        Register_Date = ircLD_cha_sta_sub_audi.Register_Date,
        Con_User = ircLD_cha_sta_sub_audi.Con_User,
        Terminal = ircLD_cha_sta_sub_audi.Terminal,
        Pay_Entity = ircLD_cha_sta_sub_audi.Pay_Entity,
        Pay_Place = ircLD_cha_sta_sub_audi.Pay_Place,
        Transfer_Number = ircLD_cha_sta_sub_audi.Transfer_Number
      where
        rowid = ircLD_cha_sta_sub_audi.rowid
      returning
    CHA_STA_SUB_AUDI_Id
      into
        nuCHA_STA_SUB_AUDI_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id,
          rcData
        );
      end if;

      update LD_cha_sta_sub_audi
      set
        Asig_Subsidy_Id = ircLD_cha_sta_sub_audi.Asig_Subsidy_Id,
        Last_State = ircLD_cha_sta_sub_audi.Last_State,
        New_State = ircLD_cha_sta_sub_audi.New_State,
        Register_Date = ircLD_cha_sta_sub_audi.Register_Date,
        Con_User = ircLD_cha_sta_sub_audi.Con_User,
        Terminal = ircLD_cha_sta_sub_audi.Terminal,
        Pay_Entity = ircLD_cha_sta_sub_audi.Pay_Entity,
        Pay_Place = ircLD_cha_sta_sub_audi.Pay_Place,
        Transfer_Number = ircLD_cha_sta_sub_audi.Transfer_Number
      where
             CHA_STA_SUB_AUDI_Id = ircLD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id
      returning
    CHA_STA_SUB_AUDI_Id
      into
        nuCHA_STA_SUB_AUDI_Id;
    end if;

    if
      nuCHA_STA_SUB_AUDI_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_cha_sta_sub_audi));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_cha_sta_sub_audi in out nocopy tytbLD_cha_sta_sub_audi,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_cha_sta_sub_audi;
  BEGIN
    FillRecordOfTables(iotbLD_cha_sta_sub_audi,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last
        update LD_cha_sta_sub_audi
        set

            Asig_Subsidy_Id = rcRecOfTab.Asig_Subsidy_Id(n),
            Last_State = rcRecOfTab.Last_State(n),
            New_State = rcRecOfTab.New_State(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Con_User = rcRecOfTab.Con_User(n),
            Terminal = rcRecOfTab.Terminal(n),
            Pay_Entity = rcRecOfTab.Pay_Entity(n),
            Pay_Place = rcRecOfTab.Pay_Place(n),
            Transfer_Number = rcRecOfTab.Transfer_Number(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last loop
          LockByPk
          (
              rcRecOfTab.CHA_STA_SUB_AUDI_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_cha_sta_sub_audi.first .. iotbLD_cha_sta_sub_audi.last
        update LD_cha_sta_sub_audi
        set
          Asig_Subsidy_Id = rcRecOfTab.Asig_Subsidy_Id(n),
          Last_State = rcRecOfTab.Last_State(n),
          New_State = rcRecOfTab.New_State(n),
          Register_Date = rcRecOfTab.Register_Date(n),
          Con_User = rcRecOfTab.Con_User(n),
          Terminal = rcRecOfTab.Terminal(n),
          Pay_Entity = rcRecOfTab.Pay_Entity(n),
          Pay_Place = rcRecOfTab.Pay_Place(n),
          Transfer_Number = rcRecOfTab.Transfer_Number(n)
          where
          CHA_STA_SUB_AUDI_Id = rcRecOfTab.CHA_STA_SUB_AUDI_Id(n)
;
    end if;
  END;

  PROCEDURE updAsig_Subsidy_Id
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuAsig_Subsidy_Id$ in LD_cha_sta_sub_audi.Asig_Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Asig_Subsidy_Id = inuAsig_Subsidy_Id$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Asig_Subsidy_Id:= inuAsig_Subsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updLast_State
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuLast_State$ in LD_cha_sta_sub_audi.Last_State%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Last_State = inuLast_State$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Last_State:= inuLast_State$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updNew_State
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuNew_State$ in LD_cha_sta_sub_audi.New_State%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      New_State = inuNew_State$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.New_State:= inuNew_State$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRegister_Date
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    idtRegister_Date$ in LD_cha_sta_sub_audi.Register_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Register_Date = idtRegister_Date$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Register_Date:= idtRegister_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCon_User
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    isbCon_User$ in LD_cha_sta_sub_audi.Con_User%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Con_User = isbCon_User$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Con_User:= isbCon_User$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTerminal
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    isbTerminal$ in LD_cha_sta_sub_audi.Terminal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Terminal = isbTerminal$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Terminal:= isbTerminal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPay_Entity
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuPay_Entity$ in LD_cha_sta_sub_audi.Pay_Entity%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Pay_Entity = inuPay_Entity$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Pay_Entity:= inuPay_Entity$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPay_Place
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    isbPay_Place$ in LD_cha_sta_sub_audi.Pay_Place%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Pay_Place = isbPay_Place$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Pay_Place:= isbPay_Place$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTransfer_Number
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuTransfer_Number$ in LD_cha_sta_sub_audi.Transfer_Number%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN
    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCHA_STA_SUB_AUDI_Id,
        rcData
      );
    end if;

    update LD_cha_sta_sub_audi
    set
      Transfer_Number = inuTransfer_Number$
    where
      CHA_STA_SUB_AUDI_Id = inuCHA_STA_SUB_AUDI_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Transfer_Number:= inuTransfer_Number$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCha_Sta_Sub_Audi_Id
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Cha_Sta_Sub_Audi_Id%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Cha_Sta_Sub_Audi_Id);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData.Cha_Sta_Sub_Audi_Id);
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
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Asig_Subsidy_Id%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Asig_Subsidy_Id);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
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

  FUNCTION fnuGetLast_State
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Last_State%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Last_State);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData.Last_State);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetNew_State
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.New_State%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.New_State);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData.New_State);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetRegister_Date
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Register_Date%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Register_Date);
    end if;
    Load
    (
         inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData.Register_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetCon_User
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Con_User%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Con_User);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
    );
    return(rcData.Con_User);
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
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Terminal%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Terminal);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
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

  FUNCTION fnuGetPay_Entity
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Pay_Entity%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Pay_Entity);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
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

  FUNCTION fsbGetPay_Place
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Pay_Place%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id:=inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Pay_Place);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
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

  FUNCTION fnuGetTransfer_Number
  (
    inuCHA_STA_SUB_AUDI_Id in LD_cha_sta_sub_audi.CHA_STA_SUB_AUDI_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_cha_sta_sub_audi.Transfer_Number%type
  IS
    rcError styLD_cha_sta_sub_audi;
  BEGIN

    rcError.CHA_STA_SUB_AUDI_Id := inuCHA_STA_SUB_AUDI_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCHA_STA_SUB_AUDI_Id
       )
    then
       return(rcData.Transfer_Number);
    end if;
    Load
    (
      inuCHA_STA_SUB_AUDI_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_cha_sta_sub_audi;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CHA_STA_SUB_AUDI
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CHA_STA_SUB_AUDI', 'ADM_PERSON'); 
END;
/ 
