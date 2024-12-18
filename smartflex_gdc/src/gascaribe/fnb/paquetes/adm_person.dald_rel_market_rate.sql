CREATE OR REPLACE PACKAGE adm_person.DALD_rel_market_rate
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_rel_market_rate
Descripcion	 : Paquete para la gestión de la entidad LD_rel_market_rate (Tarifa por Mercado Relevante)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor              Modificacion
====================   =========          ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON   
****************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  IS
    SELECT LD_rel_market_rate.*,LD_rel_market_rate.rowid
    FROM LD_rel_market_rate
    WHERE
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rel_market_rate.*,LD_rel_market_rate.rowid
    FROM LD_rel_market_rate
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_rel_market_rate  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_rel_market_rate is table of styLD_rel_market_rate index by binary_integer;
  type tyrfRecords is ref cursor return styLD_rel_market_rate;

  /* Tipos referenciando al registro */
  type tytbRel_Market_Rate_Id is table of LD_rel_market_rate.Rel_Market_Rate_Id%type index by binary_integer;
  type tytbRelevant_Market_Id is table of LD_rel_market_rate.Relevant_Market_Id%type index by binary_integer;
  type tytbYear is table of LD_rel_market_rate.Year%type index by binary_integer;
  type tytbMonth is table of LD_rel_market_rate.Month%type index by binary_integer;
  type tytbInitial_Rate is table of LD_rel_market_rate.Initial_Rate%type index by binary_integer;
  type tytbIpp is table of LD_rel_market_rate.Ipp%type index by binary_integer;
  type tytbIpc is table of LD_rel_market_rate.Ipc%type index by binary_integer;
  type tytbDis is table of LD_rel_market_rate.Dis%type index by binary_integer;
  type tytbCom is table of LD_rel_market_rate.Com%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_rel_market_rate is record
  (

    Rel_Market_Rate_Id   tytbRel_Market_Rate_Id,
    Relevant_Market_Id   tytbRelevant_Market_Id,
    Year   tytbYear,
    Month   tytbMonth,
    Initial_Rate   tytbInitial_Rate,
    Ipp   tytbIpp,
    Ipc   tytbIpc,
    Dis   tytbDis,
    Com   tytbCom,
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  );

  PROCEDURE getRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    orcRecord out nocopy styLD_rel_market_rate
  );

  FUNCTION frcGetRcData
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN styLD_rel_market_rate;

  FUNCTION frcGetRcData
  RETURN styLD_rel_market_rate;

  FUNCTION frcGetRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN styLD_rel_market_rate;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rel_market_rate
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_rel_market_rate in styLD_rel_market_rate
  );

     PROCEDURE insRecord
  (
    ircLD_rel_market_rate in styLD_rel_market_rate,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_rel_market_rate in out nocopy tytbLD_rel_market_rate
  );

  PROCEDURE delRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_rel_market_rate in out nocopy tytbLD_rel_market_rate,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_rel_market_rate in styLD_rel_market_rate,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_rel_market_rate in out nocopy tytbLD_rel_market_rate,
    inuLock in number default 1
  );

    PROCEDURE updRelevant_Market_Id
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuRelevant_Market_Id$  in LD_rel_market_rate.Relevant_Market_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updYear
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuYear$  in LD_rel_market_rate.Year%type,
        inuLock    in number default 0
      );

    PROCEDURE updMonth
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuMonth$  in LD_rel_market_rate.Month%type,
        inuLock    in number default 0
      );

    PROCEDURE updInitial_Rate
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        isbInitial_Rate$  in LD_rel_market_rate.Initial_Rate%type,
        inuLock    in number default 0
      );

    PROCEDURE updIpp
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuIpp$  in LD_rel_market_rate.Ipp%type,
        inuLock    in number default 0
      );

    PROCEDURE updIpc
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuIpc$  in LD_rel_market_rate.Ipc%type,
        inuLock    in number default 0
      );

    PROCEDURE updDis
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuDis$  in LD_rel_market_rate.Dis%type,
        inuLock    in number default 0
      );

    PROCEDURE updCom
    (
        inuRel_Market_Rate_Id   in LD_rel_market_rate.Rel_Market_Rate_Id%type,
        inuCom$  in LD_rel_market_rate.Com%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetRel_Market_Rate_Id
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Rel_Market_Rate_Id%type;

      FUNCTION fnuGetRelevant_Market_Id
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Relevant_Market_Id%type;

      FUNCTION fnuGetYear
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Year%type;

      FUNCTION fnuGetMonth
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Month%type;

      FUNCTION fsbGetInitial_Rate
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Initial_Rate%type;

      FUNCTION fnuGetIpp
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Ipp%type;

      FUNCTION fnuGetIpc
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Ipc%type;

      FUNCTION fnuGetDis
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Dis%type;

      FUNCTION fnuGetCom
      (
          inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_market_rate.Com%type;


  PROCEDURE LockByPk
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    orcLD_rel_market_rate  out styLD_rel_market_rate
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_rel_market_rate  out styLD_rel_market_rate
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_rel_market_rate;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_rel_market_rate
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_REL_MARKET_RATE';
    cnuGeEntityId constant varchar2(30) := 8341; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  IS
    SELECT LD_rel_market_rate.*,LD_rel_market_rate.rowid
    FROM LD_rel_market_rate
    WHERE  Rel_Market_Rate_Id = inuRel_Market_Rate_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rel_market_rate.*,LD_rel_market_rate.rowid
    FROM LD_rel_market_rate
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_rel_market_rate is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_rel_market_rate;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_rel_market_rate default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Rel_Market_Rate_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    orcLD_rel_market_rate  out styLD_rel_market_rate
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    Open cuLockRcByPk
    (
      inuRel_Market_Rate_Id
    );

    fetch cuLockRcByPk into orcLD_rel_market_rate;
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
    orcLD_rel_market_rate  out styLD_rel_market_rate
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_rel_market_rate;
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
    itbLD_rel_market_rate  in out nocopy tytbLD_rel_market_rate
  )
  IS
  BEGIN
      rcRecOfTab.Rel_Market_Rate_Id.delete;
      rcRecOfTab.Relevant_Market_Id.delete;
      rcRecOfTab.Year.delete;
      rcRecOfTab.Month.delete;
      rcRecOfTab.Initial_Rate.delete;
      rcRecOfTab.Ipp.delete;
      rcRecOfTab.Ipc.delete;
      rcRecOfTab.Dis.delete;
      rcRecOfTab.Com.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_rel_market_rate  in out nocopy tytbLD_rel_market_rate,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_rel_market_rate);
    for n in itbLD_rel_market_rate.first .. itbLD_rel_market_rate.last loop
      rcRecOfTab.Rel_Market_Rate_Id(n) := itbLD_rel_market_rate(n).Rel_Market_Rate_Id;
      rcRecOfTab.Relevant_Market_Id(n) := itbLD_rel_market_rate(n).Relevant_Market_Id;
      rcRecOfTab.Year(n) := itbLD_rel_market_rate(n).Year;
      rcRecOfTab.Month(n) := itbLD_rel_market_rate(n).Month;
      rcRecOfTab.Initial_Rate(n) := itbLD_rel_market_rate(n).Initial_Rate;
      rcRecOfTab.Ipp(n) := itbLD_rel_market_rate(n).Ipp;
      rcRecOfTab.Ipc(n) := itbLD_rel_market_rate(n).Ipc;
      rcRecOfTab.Dis(n) := itbLD_rel_market_rate(n).Dis;
      rcRecOfTab.Com(n) := itbLD_rel_market_rate(n).Com;
      rcRecOfTab.row_id(n) := itbLD_rel_market_rate(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuRel_Market_Rate_Id
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuRel_Market_Rate_Id = rcData.Rel_Market_Rate_Id
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN    rcError.Rel_Market_Rate_Id:=inuRel_Market_Rate_Id;

    Load
    (
      inuRel_Market_Rate_Id
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuRel_Market_Rate_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    orcRecord out nocopy styLD_rel_market_rate
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN    rcError.Rel_Market_Rate_Id:=inuRel_Market_Rate_Id;

    Load
    (
      inuRel_Market_Rate_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN styLD_rel_market_rate
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id:=inuRel_Market_Rate_Id;

    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type
  )
  RETURN styLD_rel_market_rate
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id:=inuRel_Market_Rate_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuRel_Market_Rate_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_rel_market_rate
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rel_market_rate
  )
  IS
    rfLD_rel_market_rate tyrfLD_rel_market_rate;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_rel_market_rate.Rel_Market_Rate_Id,
                LD_rel_market_rate.Relevant_Market_Id,
                LD_rel_market_rate.Year,
                LD_rel_market_rate.Month,
                LD_rel_market_rate.Initial_Rate,
                LD_rel_market_rate.Ipp,
                LD_rel_market_rate.Ipc,
                LD_rel_market_rate.Dis,
                LD_rel_market_rate.Com,
                LD_rel_market_rate.rowid
                FROM LD_rel_market_rate';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_rel_market_rate for sbFullQuery;
    fetch rfLD_rel_market_rate bulk collect INTO otbResult;
    close rfLD_rel_market_rate;
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
                LD_rel_market_rate.Rel_Market_Rate_Id,
                LD_rel_market_rate.Relevant_Market_Id,
                LD_rel_market_rate.Year,
                LD_rel_market_rate.Month,
                LD_rel_market_rate.Initial_Rate,
                LD_rel_market_rate.Ipp,
                LD_rel_market_rate.Ipc,
                LD_rel_market_rate.Dis,
                LD_rel_market_rate.Com,
                LD_rel_market_rate.rowid
                FROM LD_rel_market_rate';
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
    ircLD_rel_market_rate in styLD_rel_market_rate
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_rel_market_rate,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_rel_market_rate in styLD_rel_market_rate,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_rel_market_rate.Rel_Market_Rate_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Rel_Market_Rate_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_rel_market_rate
    (
      Rel_Market_Rate_Id,
      Relevant_Market_Id,
      Year,
      Month,
      Initial_Rate,
      Ipp,
      Ipc,
      Dis,
      Com
    )
    values
    (
      ircLD_rel_market_rate.Rel_Market_Rate_Id,
      ircLD_rel_market_rate.Relevant_Market_Id,
      ircLD_rel_market_rate.Year,
      ircLD_rel_market_rate.Month,
      ircLD_rel_market_rate.Initial_Rate,
      ircLD_rel_market_rate.Ipp,
      ircLD_rel_market_rate.Ipc,
      ircLD_rel_market_rate.Dis,
      ircLD_rel_market_rate.Com
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_rel_market_rate));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_rel_market_rate in out nocopy tytbLD_rel_market_rate
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_rel_market_rate, blUseRowID);
    forall n in iotbLD_rel_market_rate.first..iotbLD_rel_market_rate.last
      insert into LD_rel_market_rate
      (
      Rel_Market_Rate_Id,
      Relevant_Market_Id,
      Year,
      Month,
      Initial_Rate,
      Ipp,
      Ipc,
      Dis,
      Com
    )
    values
    (
      rcRecOfTab.Rel_Market_Rate_Id(n),
      rcRecOfTab.Relevant_Market_Id(n),
      rcRecOfTab.Year(n),
      rcRecOfTab.Month(n),
      rcRecOfTab.Initial_Rate(n),
      rcRecOfTab.Ipp(n),
      rcRecOfTab.Ipc(n),
      rcRecOfTab.Dis(n),
      rcRecOfTab.Com(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id:=inuRel_Market_Rate_Id;

    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    delete
    from LD_rel_market_rate
    where
           Rel_Market_Rate_Id=inuRel_Market_Rate_Id;
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
    rcError  styLD_rel_market_rate;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_rel_market_rate
    where
      rowid = iriRowID
    returning
   Rel_Market_Rate_Id
    into
      rcError.Rel_Market_Rate_Id;

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
    iotbLD_rel_market_rate in out nocopy tytbLD_rel_market_rate,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rel_market_rate;
  BEGIN
    FillRecordOfTables(iotbLD_rel_market_rate, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last
        delete
        from LD_rel_market_rate
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last loop
          LockByPk
          (
              rcRecOfTab.Rel_Market_Rate_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last
        delete
        from LD_rel_market_rate
        where
               Rel_Market_Rate_Id = rcRecOfTab.Rel_Market_Rate_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_rel_market_rate in styLD_rel_market_rate,
    inuLock    in number default 0
  )
  IS
    nuRel_Market_Rate_Id LD_rel_market_rate.Rel_Market_Rate_Id%type;

  BEGIN
    if ircLD_rel_market_rate.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_rel_market_rate.rowid,rcData);
      end if;
      update LD_rel_market_rate
      set

        Relevant_Market_Id = ircLD_rel_market_rate.Relevant_Market_Id,
        Year = ircLD_rel_market_rate.Year,
        Month = ircLD_rel_market_rate.Month,
        Initial_Rate = ircLD_rel_market_rate.Initial_Rate,
        Ipp = ircLD_rel_market_rate.Ipp,
        Ipc = ircLD_rel_market_rate.Ipc,
        Dis = ircLD_rel_market_rate.Dis,
        Com = ircLD_rel_market_rate.Com
      where
        rowid = ircLD_rel_market_rate.rowid
      returning
    Rel_Market_Rate_Id
      into
        nuRel_Market_Rate_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_rel_market_rate.Rel_Market_Rate_Id,
          rcData
        );
      end if;

      update LD_rel_market_rate
      set
        Relevant_Market_Id = ircLD_rel_market_rate.Relevant_Market_Id,
        Year = ircLD_rel_market_rate.Year,
        Month = ircLD_rel_market_rate.Month,
        Initial_Rate = ircLD_rel_market_rate.Initial_Rate,
        Ipp = ircLD_rel_market_rate.Ipp,
        Ipc = ircLD_rel_market_rate.Ipc,
        Dis = ircLD_rel_market_rate.Dis,
        Com = ircLD_rel_market_rate.Com
      where
             Rel_Market_Rate_Id = ircLD_rel_market_rate.Rel_Market_Rate_Id
      returning
    Rel_Market_Rate_Id
      into
        nuRel_Market_Rate_Id;
    end if;

    if
      nuRel_Market_Rate_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_rel_market_rate));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_rel_market_rate in out nocopy tytbLD_rel_market_rate,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rel_market_rate;
  BEGIN
    FillRecordOfTables(iotbLD_rel_market_rate,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last
        update LD_rel_market_rate
        set

            Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n),
            Year = rcRecOfTab.Year(n),
            Month = rcRecOfTab.Month(n),
            Initial_Rate = rcRecOfTab.Initial_Rate(n),
            Ipp = rcRecOfTab.Ipp(n),
            Ipc = rcRecOfTab.Ipc(n),
            Dis = rcRecOfTab.Dis(n),
            Com = rcRecOfTab.Com(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last loop
          LockByPk
          (
              rcRecOfTab.Rel_Market_Rate_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_market_rate.first .. iotbLD_rel_market_rate.last
        update LD_rel_market_rate
        set
          Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n),
          Year = rcRecOfTab.Year(n),
          Month = rcRecOfTab.Month(n),
          Initial_Rate = rcRecOfTab.Initial_Rate(n),
          Ipp = rcRecOfTab.Ipp(n),
          Ipc = rcRecOfTab.Ipc(n),
          Dis = rcRecOfTab.Dis(n),
          Com = rcRecOfTab.Com(n)
          where
          Rel_Market_Rate_Id = rcRecOfTab.Rel_Market_Rate_Id(n)
;
    end if;
  END;

  PROCEDURE updRelevant_Market_Id
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRelevant_Market_Id$ in LD_rel_market_rate.Relevant_Market_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Relevant_Market_Id = inuRelevant_Market_Id$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Relevant_Market_Id:= inuRelevant_Market_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updYear
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuYear$ in LD_rel_market_rate.Year%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Year = inuYear$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuMonth$ in LD_rel_market_rate.Month%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Month = inuMonth$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Month:= inuMonth$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInitial_Rate
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    isbInitial_Rate$ in LD_rel_market_rate.Initial_Rate%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Initial_Rate = isbInitial_Rate$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Initial_Rate:= isbInitial_Rate$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updIpp
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuIpp$ in LD_rel_market_rate.Ipp%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Ipp = inuIpp$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuIpc$ in LD_rel_market_rate.Ipc%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Ipc = inuIpc$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ipc:= inuIpc$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDis
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuDis$ in LD_rel_market_rate.Dis%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Dis = inuDis$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Dis:= inuDis$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCom
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuCom$ in LD_rel_market_rate.Com%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_market_rate;
  BEGIN
    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Market_Rate_Id,
        rcData
      );
    end if;

    update LD_rel_market_rate
    set
      Com = inuCom$
    where
      Rel_Market_Rate_Id = inuRel_Market_Rate_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Com:= inuCom$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetRel_Market_Rate_Id
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Rel_Market_Rate_Id%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Rel_Market_Rate_Id);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData.Rel_Market_Rate_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetRelevant_Market_Id
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Relevant_Market_Id%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Relevant_Market_Id);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData.Relevant_Market_Id);
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Year%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Year);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Month%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Month);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
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

  FUNCTION fsbGetInitial_Rate
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Initial_Rate%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id:=inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Initial_Rate);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData.Initial_Rate);
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Ipp%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Ipp);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
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
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Ipc%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Ipc);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
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

  FUNCTION fnuGetDis
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Dis%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Dis);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData.Dis);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetCom
  (
    inuRel_Market_Rate_Id in LD_rel_market_rate.Rel_Market_Rate_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_market_rate.Com%type
  IS
    rcError styLD_rel_market_rate;
  BEGIN

    rcError.Rel_Market_Rate_Id := inuRel_Market_Rate_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Market_Rate_Id
       )
    then
       return(rcData.Com);
    end if;
    Load
    (
      inuRel_Market_Rate_Id
    );
    return(rcData.Com);
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
end DALD_rel_market_rate;
/
PROMPT Otorgando permisos de ejecucion a DALD_REL_MARKET_RATE
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_REL_MARKET_RATE', 'ADM_PERSON');
END;
/