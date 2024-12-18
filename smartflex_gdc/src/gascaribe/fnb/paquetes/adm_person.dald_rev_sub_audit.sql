CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_rev_sub_audit
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_rev_sub_audit
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/     
    
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  IS
    SELECT LD_rev_sub_audit.*,LD_rev_sub_audit.rowid
    FROM LD_rev_sub_audit
    WHERE
      REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rev_sub_audit.*,LD_rev_sub_audit.rowid
    FROM LD_rev_sub_audit
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_rev_sub_audit  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_rev_sub_audit is table of styLD_rev_sub_audit index by binary_integer;
  type tyrfRecords is ref cursor return styLD_rev_sub_audit;

  /* Tipos referenciando al registro */
  type tytbRev_Sub_Audit_Id is table of LD_rev_sub_audit.Rev_Sub_Audit_Id%type index by binary_integer;
  type tytbAsig_Subsidy_Id is table of LD_rev_sub_audit.Asig_Subsidy_Id%type index by binary_integer;
  type tytbCausal_Id is table of LD_rev_sub_audit.Causal_Id%type index by binary_integer;
  type tytbRev_Sub_Reg_Date is table of LD_rev_sub_audit.Rev_Sub_Reg_Date%type index by binary_integer;
  type tytbRev_Con_User is table of LD_rev_sub_audit.Rev_Con_User%type index by binary_integer;
  type tytbRev_Terminal is table of LD_rev_sub_audit.Rev_Terminal%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_rev_sub_audit is record
  (

    Rev_Sub_Audit_Id   tytbRev_Sub_Audit_Id,
    Asig_Subsidy_Id   tytbAsig_Subsidy_Id,
    Causal_Id   tytbCausal_Id,
    Rev_Sub_Reg_Date   tytbRev_Sub_Reg_Date,
    Rev_Con_User   tytbRev_Con_User,
    Rev_Terminal   tytbRev_Terminal,
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
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  );

  PROCEDURE getRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    orcRecord out nocopy styLD_rev_sub_audit
  );

  FUNCTION frcGetRcData
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN styLD_rev_sub_audit;

  FUNCTION frcGetRcData
  RETURN styLD_rev_sub_audit;

  FUNCTION frcGetRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN styLD_rev_sub_audit;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rev_sub_audit
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_rev_sub_audit in styLD_rev_sub_audit
  );

     PROCEDURE insRecord
  (
    ircLD_rev_sub_audit in styLD_rev_sub_audit,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_rev_sub_audit in out nocopy tytbLD_rev_sub_audit
  );

  PROCEDURE delRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_rev_sub_audit in out nocopy tytbLD_rev_sub_audit,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_rev_sub_audit in styLD_rev_sub_audit,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_rev_sub_audit in out nocopy tytbLD_rev_sub_audit,
    inuLock in number default 1
  );

    PROCEDURE updAsig_Subsidy_Id
    (
        inuREV_SUB_AUDIT_Id   in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
        inuAsig_Subsidy_Id$  in LD_rev_sub_audit.Asig_Subsidy_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updCausal_Id
    (
        inuREV_SUB_AUDIT_Id   in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
        inuCausal_Id$  in LD_rev_sub_audit.Causal_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updRev_Sub_Reg_Date
    (
        inuREV_SUB_AUDIT_Id   in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
        idtRev_Sub_Reg_Date$  in LD_rev_sub_audit.Rev_Sub_Reg_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updRev_Con_User
    (
        inuREV_SUB_AUDIT_Id   in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
        isbRev_Con_User$  in LD_rev_sub_audit.Rev_Con_User%type,
        inuLock    in number default 0
      );

    PROCEDURE updRev_Terminal
    (
        inuREV_SUB_AUDIT_Id   in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
        isbRev_Terminal$  in LD_rev_sub_audit.Rev_Terminal%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetRev_Sub_Audit_Id
      (
          inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rev_sub_audit.Rev_Sub_Audit_Id%type;

      FUNCTION fnuGetAsig_Subsidy_Id
      (
          inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rev_sub_audit.Asig_Subsidy_Id%type;

      FUNCTION fnuGetCausal_Id
      (
          inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rev_sub_audit.Causal_Id%type;

      FUNCTION fdtGetRev_Sub_Reg_Date
      (
          inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rev_sub_audit.Rev_Sub_Reg_Date%type;

      FUNCTION fsbGetRev_Con_User
      (
          inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rev_sub_audit.Rev_Con_User%type;

      FUNCTION fsbGetRev_Terminal
      (
          inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rev_sub_audit.Rev_Terminal%type;


  PROCEDURE LockByPk
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    orcLD_rev_sub_audit  out styLD_rev_sub_audit
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_rev_sub_audit  out styLD_rev_sub_audit
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_rev_sub_audit;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_rev_sub_audit
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_REV_SUB_AUDIT';
    cnuGeEntityId constant varchar2(30) := 8187; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  IS
    SELECT LD_rev_sub_audit.*,LD_rev_sub_audit.rowid
    FROM LD_rev_sub_audit
    WHERE  REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rev_sub_audit.*,LD_rev_sub_audit.rowid
    FROM LD_rev_sub_audit
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_rev_sub_audit is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_rev_sub_audit;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_rev_sub_audit default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.REV_SUB_AUDIT_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    orcLD_rev_sub_audit  out styLD_rev_sub_audit
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;

    Open cuLockRcByPk
    (
      inuREV_SUB_AUDIT_Id
    );

    fetch cuLockRcByPk into orcLD_rev_sub_audit;
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
    orcLD_rev_sub_audit  out styLD_rev_sub_audit
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_rev_sub_audit;
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
    itbLD_rev_sub_audit  in out nocopy tytbLD_rev_sub_audit
  )
  IS
  BEGIN
      rcRecOfTab.Rev_Sub_Audit_Id.delete;
      rcRecOfTab.Asig_Subsidy_Id.delete;
      rcRecOfTab.Causal_Id.delete;
      rcRecOfTab.Rev_Sub_Reg_Date.delete;
      rcRecOfTab.Rev_Con_User.delete;
      rcRecOfTab.Rev_Terminal.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_rev_sub_audit  in out nocopy tytbLD_rev_sub_audit,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_rev_sub_audit);
    for n in itbLD_rev_sub_audit.first .. itbLD_rev_sub_audit.last loop
      rcRecOfTab.Rev_Sub_Audit_Id(n) := itbLD_rev_sub_audit(n).Rev_Sub_Audit_Id;
      rcRecOfTab.Asig_Subsidy_Id(n) := itbLD_rev_sub_audit(n).Asig_Subsidy_Id;
      rcRecOfTab.Causal_Id(n) := itbLD_rev_sub_audit(n).Causal_Id;
      rcRecOfTab.Rev_Sub_Reg_Date(n) := itbLD_rev_sub_audit(n).Rev_Sub_Reg_Date;
      rcRecOfTab.Rev_Con_User(n) := itbLD_rev_sub_audit(n).Rev_Con_User;
      rcRecOfTab.Rev_Terminal(n) := itbLD_rev_sub_audit(n).Rev_Terminal;
      rcRecOfTab.row_id(n) := itbLD_rev_sub_audit(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuREV_SUB_AUDIT_Id
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
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuREV_SUB_AUDIT_Id = rcData.REV_SUB_AUDIT_Id
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
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    Load
    (
      inuREV_SUB_AUDIT_Id
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
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    orcRecord out nocopy styLD_rev_sub_audit
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN styLD_rev_sub_audit
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type
  )
  RETURN styLD_rev_sub_audit
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_rev_sub_audit
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rev_sub_audit
  )
  IS
    rfLD_rev_sub_audit tyrfLD_rev_sub_audit;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_rev_sub_audit.Rev_Sub_Audit_Id,
                LD_rev_sub_audit.Asig_Subsidy_Id,
                LD_rev_sub_audit.Causal_Id,
                LD_rev_sub_audit.Rev_Sub_Reg_Date,
                LD_rev_sub_audit.Rev_Con_User,
                LD_rev_sub_audit.Rev_Terminal,
                LD_rev_sub_audit.rowid
                FROM LD_rev_sub_audit';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_rev_sub_audit for sbFullQuery;
    fetch rfLD_rev_sub_audit bulk collect INTO otbResult;
    close rfLD_rev_sub_audit;
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
                LD_rev_sub_audit.Rev_Sub_Audit_Id,
                LD_rev_sub_audit.Asig_Subsidy_Id,
                LD_rev_sub_audit.Causal_Id,
                LD_rev_sub_audit.Rev_Sub_Reg_Date,
                LD_rev_sub_audit.Rev_Con_User,
                LD_rev_sub_audit.Rev_Terminal,
                LD_rev_sub_audit.rowid
                FROM LD_rev_sub_audit';
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
    ircLD_rev_sub_audit in styLD_rev_sub_audit
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_rev_sub_audit,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_rev_sub_audit in styLD_rev_sub_audit,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_rev_sub_audit.REV_SUB_AUDIT_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|REV_SUB_AUDIT_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_rev_sub_audit
    (
      Rev_Sub_Audit_Id,
      Asig_Subsidy_Id,
      Causal_Id,
      Rev_Sub_Reg_Date,
      Rev_Con_User,
      Rev_Terminal
    )
    values
    (
      ircLD_rev_sub_audit.Rev_Sub_Audit_Id,
      ircLD_rev_sub_audit.Asig_Subsidy_Id,
      ircLD_rev_sub_audit.Causal_Id,
      ircLD_rev_sub_audit.Rev_Sub_Reg_Date,
      ircLD_rev_sub_audit.Rev_Con_User,
      ircLD_rev_sub_audit.Rev_Terminal
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_rev_sub_audit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_rev_sub_audit in out nocopy tytbLD_rev_sub_audit
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_rev_sub_audit, blUseRowID);
    forall n in iotbLD_rev_sub_audit.first..iotbLD_rev_sub_audit.last
      insert into LD_rev_sub_audit
      (
      Rev_Sub_Audit_Id,
      Asig_Subsidy_Id,
      Causal_Id,
      Rev_Sub_Reg_Date,
      Rev_Con_User,
      Rev_Terminal
    )
    values
    (
      rcRecOfTab.Rev_Sub_Audit_Id(n),
      rcRecOfTab.Asig_Subsidy_Id(n),
      rcRecOfTab.Causal_Id(n),
      rcRecOfTab.Rev_Sub_Reg_Date(n),
      rcRecOfTab.Rev_Con_User(n),
      rcRecOfTab.Rev_Terminal(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    if inuLock=1 then
      LockByPk
      (
        inuREV_SUB_AUDIT_Id,
        rcData
      );
    end if;

    delete
    from LD_rev_sub_audit
    where
           REV_SUB_AUDIT_Id=inuREV_SUB_AUDIT_Id;
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
    rcError  styLD_rev_sub_audit;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_rev_sub_audit
    where
      rowid = iriRowID
    returning
   REV_SUB_AUDIT_Id
    into
      rcError.REV_SUB_AUDIT_Id;

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
    iotbLD_rev_sub_audit in out nocopy tytbLD_rev_sub_audit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rev_sub_audit;
  BEGIN
    FillRecordOfTables(iotbLD_rev_sub_audit, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last
        delete
        from LD_rev_sub_audit
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last loop
          LockByPk
          (
              rcRecOfTab.REV_SUB_AUDIT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last
        delete
        from LD_rev_sub_audit
        where
               REV_SUB_AUDIT_Id = rcRecOfTab.REV_SUB_AUDIT_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_rev_sub_audit in styLD_rev_sub_audit,
    inuLock    in number default 0
  )
  IS
    nuREV_SUB_AUDIT_Id LD_rev_sub_audit.REV_SUB_AUDIT_Id%type;

  BEGIN
    if ircLD_rev_sub_audit.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_rev_sub_audit.rowid,rcData);
      end if;
      update LD_rev_sub_audit
      set

        Asig_Subsidy_Id = ircLD_rev_sub_audit.Asig_Subsidy_Id,
        Causal_Id = ircLD_rev_sub_audit.Causal_Id,
        Rev_Sub_Reg_Date = ircLD_rev_sub_audit.Rev_Sub_Reg_Date,
        Rev_Con_User = ircLD_rev_sub_audit.Rev_Con_User,
        Rev_Terminal = ircLD_rev_sub_audit.Rev_Terminal
      where
        rowid = ircLD_rev_sub_audit.rowid
      returning
    REV_SUB_AUDIT_Id
      into
        nuREV_SUB_AUDIT_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_rev_sub_audit.REV_SUB_AUDIT_Id,
          rcData
        );
      end if;

      update LD_rev_sub_audit
      set
        Asig_Subsidy_Id = ircLD_rev_sub_audit.Asig_Subsidy_Id,
        Causal_Id = ircLD_rev_sub_audit.Causal_Id,
        Rev_Sub_Reg_Date = ircLD_rev_sub_audit.Rev_Sub_Reg_Date,
        Rev_Con_User = ircLD_rev_sub_audit.Rev_Con_User,
        Rev_Terminal = ircLD_rev_sub_audit.Rev_Terminal
      where
             REV_SUB_AUDIT_Id = ircLD_rev_sub_audit.REV_SUB_AUDIT_Id
      returning
    REV_SUB_AUDIT_Id
      into
        nuREV_SUB_AUDIT_Id;
    end if;

    if
      nuREV_SUB_AUDIT_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_rev_sub_audit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_rev_sub_audit in out nocopy tytbLD_rev_sub_audit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rev_sub_audit;
  BEGIN
    FillRecordOfTables(iotbLD_rev_sub_audit,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last
        update LD_rev_sub_audit
        set

            Asig_Subsidy_Id = rcRecOfTab.Asig_Subsidy_Id(n),
            Causal_Id = rcRecOfTab.Causal_Id(n),
            Rev_Sub_Reg_Date = rcRecOfTab.Rev_Sub_Reg_Date(n),
            Rev_Con_User = rcRecOfTab.Rev_Con_User(n),
            Rev_Terminal = rcRecOfTab.Rev_Terminal(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last loop
          LockByPk
          (
              rcRecOfTab.REV_SUB_AUDIT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rev_sub_audit.first .. iotbLD_rev_sub_audit.last
        update LD_rev_sub_audit
        set
          Asig_Subsidy_Id = rcRecOfTab.Asig_Subsidy_Id(n),
          Causal_Id = rcRecOfTab.Causal_Id(n),
          Rev_Sub_Reg_Date = rcRecOfTab.Rev_Sub_Reg_Date(n),
          Rev_Con_User = rcRecOfTab.Rev_Con_User(n),
          Rev_Terminal = rcRecOfTab.Rev_Terminal(n)
          where
          REV_SUB_AUDIT_Id = rcRecOfTab.REV_SUB_AUDIT_Id(n)
;
    end if;
  END;

  PROCEDURE updAsig_Subsidy_Id
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuAsig_Subsidy_Id$ in LD_rev_sub_audit.Asig_Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREV_SUB_AUDIT_Id,
        rcData
      );
    end if;

    update LD_rev_sub_audit
    set
      Asig_Subsidy_Id = inuAsig_Subsidy_Id$
    where
      REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Asig_Subsidy_Id:= inuAsig_Subsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCausal_Id
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuCausal_Id$ in LD_rev_sub_audit.Causal_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREV_SUB_AUDIT_Id,
        rcData
      );
    end if;

    update LD_rev_sub_audit
    set
      Causal_Id = inuCausal_Id$
    where
      REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Causal_Id:= inuCausal_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRev_Sub_Reg_Date
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    idtRev_Sub_Reg_Date$ in LD_rev_sub_audit.Rev_Sub_Reg_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREV_SUB_AUDIT_Id,
        rcData
      );
    end if;

    update LD_rev_sub_audit
    set
      Rev_Sub_Reg_Date = idtRev_Sub_Reg_Date$
    where
      REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Rev_Sub_Reg_Date:= idtRev_Sub_Reg_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRev_Con_User
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    isbRev_Con_User$ in LD_rev_sub_audit.Rev_Con_User%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREV_SUB_AUDIT_Id,
        rcData
      );
    end if;

    update LD_rev_sub_audit
    set
      Rev_Con_User = isbRev_Con_User$
    where
      REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Rev_Con_User:= isbRev_Con_User$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRev_Terminal
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    isbRev_Terminal$ in LD_rev_sub_audit.Rev_Terminal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rev_sub_audit;
  BEGIN
    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREV_SUB_AUDIT_Id,
        rcData
      );
    end if;

    update LD_rev_sub_audit
    set
      Rev_Terminal = isbRev_Terminal$
    where
      REV_SUB_AUDIT_Id = inuREV_SUB_AUDIT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Rev_Terminal:= isbRev_Terminal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetRev_Sub_Audit_Id
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rev_sub_audit.Rev_Sub_Audit_Id%type
  IS
    rcError styLD_rev_sub_audit;
  BEGIN

    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData.Rev_Sub_Audit_Id);
    end if;
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(rcData.Rev_Sub_Audit_Id);
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
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rev_sub_audit.Asig_Subsidy_Id%type
  IS
    rcError styLD_rev_sub_audit;
  BEGIN

    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData.Asig_Subsidy_Id);
    end if;
    Load
    (
      inuREV_SUB_AUDIT_Id
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

  FUNCTION fnuGetCausal_Id
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rev_sub_audit.Causal_Id%type
  IS
    rcError styLD_rev_sub_audit;
  BEGIN

    rcError.REV_SUB_AUDIT_Id := inuREV_SUB_AUDIT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData.Causal_Id);
    end if;
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(rcData.Causal_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetRev_Sub_Reg_Date
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rev_sub_audit.Rev_Sub_Reg_Date%type
  IS
    rcError styLD_rev_sub_audit;
  BEGIN

    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData.Rev_Sub_Reg_Date);
    end if;
    Load
    (
         inuREV_SUB_AUDIT_Id
    );
    return(rcData.Rev_Sub_Reg_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetRev_Con_User
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rev_sub_audit.Rev_Con_User%type
  IS
    rcError styLD_rev_sub_audit;
  BEGIN

    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData.Rev_Con_User);
    end if;
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(rcData.Rev_Con_User);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetRev_Terminal
  (
    inuREV_SUB_AUDIT_Id in LD_rev_sub_audit.REV_SUB_AUDIT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rev_sub_audit.Rev_Terminal%type
  IS
    rcError styLD_rev_sub_audit;
  BEGIN

    rcError.REV_SUB_AUDIT_Id:=inuREV_SUB_AUDIT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREV_SUB_AUDIT_Id
       )
    then
       return(rcData.Rev_Terminal);
    end if;
    Load
    (
      inuREV_SUB_AUDIT_Id
    );
    return(rcData.Rev_Terminal);
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
end DALD_rev_sub_audit;
/
PROMPT Otorgando permisos de ejecucion a DALD_REV_SUB_AUDIT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_REV_SUB_AUDIT', 'ADM_PERSON');
END;
/
