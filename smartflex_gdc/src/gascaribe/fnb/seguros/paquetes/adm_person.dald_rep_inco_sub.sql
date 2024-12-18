CREATE OR REPLACE PACKAGE adm_person.DALD_rep_inco_sub
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_REP_INCO_SUB
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/   
    
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  IS
    SELECT LD_rep_inco_sub.*,LD_rep_inco_sub.rowid
    FROM LD_rep_inco_sub
    WHERE
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rep_inco_sub.*,LD_rep_inco_sub.rowid
    FROM LD_rep_inco_sub
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_rep_inco_sub  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_rep_inco_sub is table of styLD_rep_inco_sub index by binary_integer;
  type tyrfRecords is ref cursor return styLD_rep_inco_sub;

  /* Tipos referenciando al registro */
  type tytbRep_Inco_Sub_Id is table of LD_rep_inco_sub.Rep_Inco_Sub_Id%type index by binary_integer;
  type tytbInconsistency is table of LD_rep_inco_sub.Inconsistency%type index by binary_integer;
  type tytbInco_Date is table of LD_rep_inco_sub.Inco_Date%type index by binary_integer;
  type tytbSubsidy_Id is table of LD_rep_inco_sub.Subsidy_Id%type index by binary_integer;
  type tytbSusccodi is table of LD_rep_inco_sub.Susccodi%type index by binary_integer;
  type tytbSesion is table of LD_rep_inco_sub.Sesion%type index by binary_integer;
  type tytbTerminal is table of LD_rep_inco_sub.Terminal%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_rep_inco_sub is record
  (

    Rep_Inco_Sub_Id   tytbRep_Inco_Sub_Id,
    Inconsistency   tytbInconsistency,
    Inco_Date   tytbInco_Date,
    Subsidy_Id   tytbSubsidy_Id,
    Susccodi   tytbSusccodi,
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  );

  PROCEDURE getRecord
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    orcRecord out nocopy styLD_rep_inco_sub
  );

  FUNCTION frcGetRcData
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN styLD_rep_inco_sub;

  FUNCTION frcGetRcData
  RETURN styLD_rep_inco_sub;

  FUNCTION frcGetRecord
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN styLD_rep_inco_sub;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rep_inco_sub
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_rep_inco_sub in styLD_rep_inco_sub
  );

     PROCEDURE insRecord
  (
    ircLD_rep_inco_sub in styLD_rep_inco_sub,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_rep_inco_sub in out nocopy tytbLD_rep_inco_sub
  );

  PROCEDURE delRecord
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_rep_inco_sub in out nocopy tytbLD_rep_inco_sub,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_rep_inco_sub in styLD_rep_inco_sub,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_rep_inco_sub in out nocopy tytbLD_rep_inco_sub,
    inuLock in number default 1
  );

    PROCEDURE updInconsistency
    (
        inuREP_INCO_SUB_Id   in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
        isbInconsistency$  in LD_rep_inco_sub.Inconsistency%type,
        inuLock    in number default 0
      );

    PROCEDURE updInco_Date
    (
        inuREP_INCO_SUB_Id   in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
        idtInco_Date$  in LD_rep_inco_sub.Inco_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updSubsidy_Id
    (
        inuREP_INCO_SUB_Id   in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
        inuSubsidy_Id$  in LD_rep_inco_sub.Subsidy_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSusccodi
    (
        inuREP_INCO_SUB_Id   in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
        inuSusccodi$  in LD_rep_inco_sub.Susccodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updSesion
    (
        inuREP_INCO_SUB_Id   in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
        inuSesion$  in LD_rep_inco_sub.Sesion%type,
        inuLock    in number default 0
      );

    PROCEDURE updTerminal
    (
        inuREP_INCO_SUB_Id   in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
        isbTerminal$  in LD_rep_inco_sub.Terminal%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetRep_Inco_Sub_Id
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Rep_Inco_Sub_Id%type;

      FUNCTION fsbGetInconsistency
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Inconsistency%type;

      FUNCTION fdtGetInco_Date
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Inco_Date%type;

      FUNCTION fnuGetSubsidy_Id
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Subsidy_Id%type;

      FUNCTION fnuGetSusccodi
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Susccodi%type;

      FUNCTION fnuGetSesion
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Sesion%type;

      FUNCTION fsbGetTerminal
      (
          inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rep_inco_sub.Terminal%type;


  PROCEDURE LockByPk
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    orcLD_rep_inco_sub  out styLD_rep_inco_sub
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_rep_inco_sub  out styLD_rep_inco_sub
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_rep_inco_sub;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_rep_inco_sub
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_REP_INCO_SUB';
    cnuGeEntityId constant varchar2(30) := 8393; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  IS
    SELECT LD_rep_inco_sub.*,LD_rep_inco_sub.rowid
    FROM LD_rep_inco_sub
    WHERE  REP_INCO_SUB_Id = inuREP_INCO_SUB_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rep_inco_sub.*,LD_rep_inco_sub.rowid
    FROM LD_rep_inco_sub
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_rep_inco_sub is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_rep_inco_sub;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_rep_inco_sub default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.REP_INCO_SUB_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    orcLD_rep_inco_sub  out styLD_rep_inco_sub
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;

    Open cuLockRcByPk
    (
      inuREP_INCO_SUB_Id
    );

    fetch cuLockRcByPk into orcLD_rep_inco_sub;
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
    orcLD_rep_inco_sub  out styLD_rep_inco_sub
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_rep_inco_sub;
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
    itbLD_rep_inco_sub  in out nocopy tytbLD_rep_inco_sub
  )
  IS
  BEGIN
      rcRecOfTab.Rep_Inco_Sub_Id.delete;
      rcRecOfTab.Inconsistency.delete;
      rcRecOfTab.Inco_Date.delete;
      rcRecOfTab.Subsidy_Id.delete;
      rcRecOfTab.Susccodi.delete;
      rcRecOfTab.Sesion.delete;
      rcRecOfTab.Terminal.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_rep_inco_sub  in out nocopy tytbLD_rep_inco_sub,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_rep_inco_sub);
    for n in itbLD_rep_inco_sub.first .. itbLD_rep_inco_sub.last loop
      rcRecOfTab.Rep_Inco_Sub_Id(n) := itbLD_rep_inco_sub(n).Rep_Inco_Sub_Id;
      rcRecOfTab.Inconsistency(n) := itbLD_rep_inco_sub(n).Inconsistency;
      rcRecOfTab.Inco_Date(n) := itbLD_rep_inco_sub(n).Inco_Date;
      rcRecOfTab.Subsidy_Id(n) := itbLD_rep_inco_sub(n).Subsidy_Id;
      rcRecOfTab.Susccodi(n) := itbLD_rep_inco_sub(n).Susccodi;
      rcRecOfTab.Sesion(n) := itbLD_rep_inco_sub(n).Sesion;
      rcRecOfTab.Terminal(n) := itbLD_rep_inco_sub(n).Terminal;
      rcRecOfTab.row_id(n) := itbLD_rep_inco_sub(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuREP_INCO_SUB_Id
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuREP_INCO_SUB_Id = rcData.REP_INCO_SUB_Id
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuREP_INCO_SUB_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    Load
    (
      inuREP_INCO_SUB_Id
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuREP_INCO_SUB_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    orcRecord out nocopy styLD_rep_inco_sub
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    Load
    (
      inuREP_INCO_SUB_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN styLD_rep_inco_sub
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    Load
    (
      inuREP_INCO_SUB_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type
  )
  RETURN styLD_rep_inco_sub
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuREP_INCO_SUB_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_rep_inco_sub
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rep_inco_sub
  )
  IS
    rfLD_rep_inco_sub tyrfLD_rep_inco_sub;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_rep_inco_sub.Rep_Inco_Sub_Id,
                LD_rep_inco_sub.Inconsistency,
                LD_rep_inco_sub.Inco_Date,
                LD_rep_inco_sub.Subsidy_Id,
                LD_rep_inco_sub.Susccodi,
                LD_rep_inco_sub.Sesion,
                LD_rep_inco_sub.Terminal,
                LD_rep_inco_sub.rowid
                FROM LD_rep_inco_sub';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_rep_inco_sub for sbFullQuery;
    fetch rfLD_rep_inco_sub bulk collect INTO otbResult;
    close rfLD_rep_inco_sub;
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
                LD_rep_inco_sub.Rep_Inco_Sub_Id,
                LD_rep_inco_sub.Inconsistency,
                LD_rep_inco_sub.Inco_Date,
                LD_rep_inco_sub.Subsidy_Id,
                LD_rep_inco_sub.Susccodi,
                LD_rep_inco_sub.Sesion,
                LD_rep_inco_sub.Terminal,
                LD_rep_inco_sub.rowid
                FROM LD_rep_inco_sub';
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
    ircLD_rep_inco_sub in styLD_rep_inco_sub
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_rep_inco_sub,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_rep_inco_sub in styLD_rep_inco_sub,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_rep_inco_sub.REP_INCO_SUB_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|REP_INCO_SUB_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_rep_inco_sub
    (
      Rep_Inco_Sub_Id,
      Inconsistency,
      Inco_Date,
      Subsidy_Id,
      Susccodi,
      Sesion,
      Terminal
    )
    values
    (
      ircLD_rep_inco_sub.Rep_Inco_Sub_Id,
      ircLD_rep_inco_sub.Inconsistency,
      ircLD_rep_inco_sub.Inco_Date,
      ircLD_rep_inco_sub.Subsidy_Id,
      ircLD_rep_inco_sub.Susccodi,
      ircLD_rep_inco_sub.Sesion,
      ircLD_rep_inco_sub.Terminal
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_rep_inco_sub));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_rep_inco_sub in out nocopy tytbLD_rep_inco_sub
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_rep_inco_sub, blUseRowID);
    forall n in iotbLD_rep_inco_sub.first..iotbLD_rep_inco_sub.last
      insert into LD_rep_inco_sub
      (
      Rep_Inco_Sub_Id,
      Inconsistency,
      Inco_Date,
      Subsidy_Id,
      Susccodi,
      Sesion,
      Terminal
    )
    values
    (
      rcRecOfTab.Rep_Inco_Sub_Id(n),
      rcRecOfTab.Inconsistency(n),
      rcRecOfTab.Inco_Date(n),
      rcRecOfTab.Subsidy_Id(n),
      rcRecOfTab.Susccodi(n),
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    delete
    from LD_rep_inco_sub
    where
           REP_INCO_SUB_Id=inuREP_INCO_SUB_Id;
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
    rcError  styLD_rep_inco_sub;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_rep_inco_sub
    where
      rowid = iriRowID
    returning
   REP_INCO_SUB_Id
    into
      rcError.REP_INCO_SUB_Id;

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
    iotbLD_rep_inco_sub in out nocopy tytbLD_rep_inco_sub,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rep_inco_sub;
  BEGIN
    FillRecordOfTables(iotbLD_rep_inco_sub, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last
        delete
        from LD_rep_inco_sub
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last loop
          LockByPk
          (
              rcRecOfTab.REP_INCO_SUB_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last
        delete
        from LD_rep_inco_sub
        where
               REP_INCO_SUB_Id = rcRecOfTab.REP_INCO_SUB_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_rep_inco_sub in styLD_rep_inco_sub,
    inuLock    in number default 0
  )
  IS
    nuREP_INCO_SUB_Id LD_rep_inco_sub.REP_INCO_SUB_Id%type;

  BEGIN
    if ircLD_rep_inco_sub.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_rep_inco_sub.rowid,rcData);
      end if;
      update LD_rep_inco_sub
      set

        Inconsistency = ircLD_rep_inco_sub.Inconsistency,
        Inco_Date = ircLD_rep_inco_sub.Inco_Date,
        Subsidy_Id = ircLD_rep_inco_sub.Subsidy_Id,
        Susccodi = ircLD_rep_inco_sub.Susccodi,
        Sesion = ircLD_rep_inco_sub.Sesion,
        Terminal = ircLD_rep_inco_sub.Terminal
      where
        rowid = ircLD_rep_inco_sub.rowid
      returning
    REP_INCO_SUB_Id
      into
        nuREP_INCO_SUB_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_rep_inco_sub.REP_INCO_SUB_Id,
          rcData
        );
      end if;

      update LD_rep_inco_sub
      set
        Inconsistency = ircLD_rep_inco_sub.Inconsistency,
        Inco_Date = ircLD_rep_inco_sub.Inco_Date,
        Subsidy_Id = ircLD_rep_inco_sub.Subsidy_Id,
        Susccodi = ircLD_rep_inco_sub.Susccodi,
        Sesion = ircLD_rep_inco_sub.Sesion,
        Terminal = ircLD_rep_inco_sub.Terminal
      where
             REP_INCO_SUB_Id = ircLD_rep_inco_sub.REP_INCO_SUB_Id
      returning
    REP_INCO_SUB_Id
      into
        nuREP_INCO_SUB_Id;
    end if;

    if
      nuREP_INCO_SUB_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_rep_inco_sub));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_rep_inco_sub in out nocopy tytbLD_rep_inco_sub,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rep_inco_sub;
  BEGIN
    FillRecordOfTables(iotbLD_rep_inco_sub,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last
        update LD_rep_inco_sub
        set

            Inconsistency = rcRecOfTab.Inconsistency(n),
            Inco_Date = rcRecOfTab.Inco_Date(n),
            Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
            Susccodi = rcRecOfTab.Susccodi(n),
            Sesion = rcRecOfTab.Sesion(n),
            Terminal = rcRecOfTab.Terminal(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last loop
          LockByPk
          (
              rcRecOfTab.REP_INCO_SUB_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rep_inco_sub.first .. iotbLD_rep_inco_sub.last
        update LD_rep_inco_sub
        set
          Inconsistency = rcRecOfTab.Inconsistency(n),
          Inco_Date = rcRecOfTab.Inco_Date(n),
          Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
          Susccodi = rcRecOfTab.Susccodi(n),
          Sesion = rcRecOfTab.Sesion(n),
          Terminal = rcRecOfTab.Terminal(n)
          where
          REP_INCO_SUB_Id = rcRecOfTab.REP_INCO_SUB_Id(n)
;
    end if;
  END;

  PROCEDURE updInconsistency
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    isbInconsistency$ in LD_rep_inco_sub.Inconsistency%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    update LD_rep_inco_sub
    set
      Inconsistency = isbInconsistency$
    where
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Inconsistency:= isbInconsistency$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInco_Date
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    idtInco_Date$ in LD_rep_inco_sub.Inco_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    update LD_rep_inco_sub
    set
      Inco_Date = idtInco_Date$
    where
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Inco_Date:= idtInco_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubsidy_Id
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuSubsidy_Id$ in LD_rep_inco_sub.Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    update LD_rep_inco_sub
    set
      Subsidy_Id = inuSubsidy_Id$
    where
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;

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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuSusccodi$ in LD_rep_inco_sub.Susccodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    update LD_rep_inco_sub
    set
      Susccodi = inuSusccodi$
    where
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Susccodi:= inuSusccodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSesion
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuSesion$ in LD_rep_inco_sub.Sesion%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    update LD_rep_inco_sub
    set
      Sesion = inuSesion$
    where
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;

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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    isbTerminal$ in LD_rep_inco_sub.Terminal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rep_inco_sub;
  BEGIN
    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;
    if inuLock=1 then
      LockByPk
      (
        inuREP_INCO_SUB_Id,
        rcData
      );
    end if;

    update LD_rep_inco_sub
    set
      Terminal = isbTerminal$
    where
      REP_INCO_SUB_Id = inuREP_INCO_SUB_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Terminal:= isbTerminal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetRep_Inco_Sub_Id
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Rep_Inco_Sub_Id%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Rep_Inco_Sub_Id);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
    );
    return(rcData.Rep_Inco_Sub_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetInconsistency
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Inconsistency%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Inconsistency);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
    );
    return(rcData.Inconsistency);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetInco_Date
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Inco_Date%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Inco_Date);
    end if;
    Load
    (
         inuREP_INCO_SUB_Id
    );
    return(rcData.Inco_Date);
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Subsidy_Id%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Subsidy_Id);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Susccodi%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Susccodi);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
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

  FUNCTION fnuGetSesion
  (
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Sesion%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id := inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Sesion);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
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
    inuREP_INCO_SUB_Id in LD_rep_inco_sub.REP_INCO_SUB_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rep_inco_sub.Terminal%type
  IS
    rcError styLD_rep_inco_sub;
  BEGIN

    rcError.REP_INCO_SUB_Id:=inuREP_INCO_SUB_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuREP_INCO_SUB_Id
       )
    then
       return(rcData.Terminal);
    end if;
    Load
    (
      inuREP_INCO_SUB_Id
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
end DALD_rep_inco_sub;
/
PROMPT Otorgando permisos de ejecucion a DALD_REP_INCO_SUB
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_REP_INCO_SUB', 'ADM_PERSON');
END;
/