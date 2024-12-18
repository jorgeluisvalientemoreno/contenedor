CREATE OR REPLACE PACKAGE adm_person.DALD_suppli_modifica_date
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_SUPPLI_MODIFICA_DATE
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
		inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  IS
		SELECT LD_suppli_modifica_date.*,LD_suppli_modifica_date.rowid
		FROM LD_suppli_modifica_date
		WHERE
			SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_suppli_modifica_date.*,LD_suppli_modifica_date.rowid
		FROM LD_suppli_modifica_date
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_suppli_modifica_date  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_suppli_modifica_date is table of styLD_suppli_modifica_date index by binary_integer;
	type tyrfRecords is ref cursor return styLD_suppli_modifica_date;

	/* Tipos referenciando al registro */
	type tytbSuppli_Modifica_Date_Id is table of LD_suppli_modifica_date.Suppli_Modifica_Date_Id%type index by binary_integer;
	type tytbSupplier_Id is table of LD_suppli_modifica_date.Supplier_Id%type index by binary_integer;
	type tytbInitial_Date is table of LD_suppli_modifica_date.Initial_Date%type index by binary_integer;
	type tytbFinal_Date is table of LD_suppli_modifica_date.Final_Date%type index by binary_integer;
	type tytbInitial_Hour is table of LD_suppli_modifica_date.Initial_Hour%type index by binary_integer;
	type tytbFinal_Hour is table of LD_suppli_modifica_date.Final_Hour%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_suppli_modifica_date is record
	(

		Suppli_Modifica_Date_Id   tytbSuppli_Modifica_Date_Id,
		Supplier_Id   tytbSupplier_Id,
		Initial_Date   tytbInitial_Date,
		Final_Date   tytbFinal_Date,
		Initial_Hour   tytbInitial_Hour,
		Final_Hour   tytbFinal_Hour,
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
		inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
	);

	PROCEDURE getRecord
	(
		inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
		orcRecord out nocopy styLD_suppli_modifica_date
	);

	FUNCTION frcGetRcData
	(
		inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
	)
	RETURN styLD_suppli_modifica_date;

	FUNCTION frcGetRcData
	RETURN styLD_suppli_modifica_date;

	FUNCTION frcGetRecord
	(
		inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
	)
	RETURN styLD_suppli_modifica_date;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_suppli_modifica_date
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_suppli_modifica_date in styLD_suppli_modifica_date
	);

 	  PROCEDURE insRecord
	(
		ircLD_suppli_modifica_date in styLD_suppli_modifica_date,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_suppli_modifica_date in out nocopy tytbLD_suppli_modifica_date
	);

	PROCEDURE delRecord
	(
		inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_suppli_modifica_date in out nocopy tytbLD_suppli_modifica_date,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_suppli_modifica_date in styLD_suppli_modifica_date,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_suppli_modifica_date in out nocopy tytbLD_suppli_modifica_date,
		inuLock in number default 1
	);

		PROCEDURE updSupplier_Id
		(
				inuSUPPLI_MODIFICA_DATE_Id   in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
				inuSupplier_Id$  in LD_suppli_modifica_date.Supplier_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInitial_Date
		(
				inuSUPPLI_MODIFICA_DATE_Id   in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
				idtInitial_Date$  in LD_suppli_modifica_date.Initial_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinal_Date
		(
				inuSUPPLI_MODIFICA_DATE_Id   in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
				idtFinal_Date$  in LD_suppli_modifica_date.Final_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInitial_Hour
		(
				inuSUPPLI_MODIFICA_DATE_Id   in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
				isbInitial_Hour$  in LD_suppli_modifica_date.Initial_Hour%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinal_Hour
		(
				inuSUPPLI_MODIFICA_DATE_Id   in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
				isbFinal_Hour$  in LD_suppli_modifica_date.Final_Hour%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetSuppli_Modifica_Date_Id
    	(
    	    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_suppli_modifica_date.Suppli_Modifica_Date_Id%type;

      FUNCTION fnuGetSupplier_Id
      (
          inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_suppli_modifica_date.Supplier_Id%type;

      FUNCTION fdtGetInitial_Date
      (
          inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_suppli_modifica_date.Initial_Date%type;

      FUNCTION fdtGetFinal_Date
      (
          inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_suppli_modifica_date.Final_Date%type;

      FUNCTION fsbGetInitial_Hour
      (
          inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_suppli_modifica_date.Initial_Hour%type;

      FUNCTION fsbGetFinal_Hour
      (
          inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_suppli_modifica_date.Final_Hour%type;


  PROCEDURE LockByPk
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    orcLD_suppli_modifica_date  out styLD_suppli_modifica_date
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_suppli_modifica_date  out styLD_suppli_modifica_date
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_suppli_modifica_date;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_suppli_modifica_date
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUPPLI_MODIFICA_DATE';
    cnuGeEntityId constant varchar2(30) := 8530; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  IS
    SELECT LD_suppli_modifica_date.*,LD_suppli_modifica_date.rowid
    FROM LD_suppli_modifica_date
    WHERE  SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_suppli_modifica_date.*,LD_suppli_modifica_date.rowid
    FROM LD_suppli_modifica_date
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_suppli_modifica_date is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_suppli_modifica_date;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_suppli_modifica_date default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUPPLI_MODIFICA_DATE_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    orcLD_suppli_modifica_date  out styLD_suppli_modifica_date
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;

    Open cuLockRcByPk
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );

    fetch cuLockRcByPk into orcLD_suppli_modifica_date;
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
    orcLD_suppli_modifica_date  out styLD_suppli_modifica_date
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_suppli_modifica_date;
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
    itbLD_suppli_modifica_date  in out nocopy tytbLD_suppli_modifica_date
  )
  IS
  BEGIN
      rcRecOfTab.Suppli_Modifica_Date_Id.delete;
      rcRecOfTab.Supplier_Id.delete;
      rcRecOfTab.Initial_Date.delete;
      rcRecOfTab.Final_Date.delete;
      rcRecOfTab.Initial_Hour.delete;
      rcRecOfTab.Final_Hour.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_suppli_modifica_date  in out nocopy tytbLD_suppli_modifica_date,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_suppli_modifica_date);
    for n in itbLD_suppli_modifica_date.first .. itbLD_suppli_modifica_date.last loop
      rcRecOfTab.Suppli_Modifica_Date_Id(n) := itbLD_suppli_modifica_date(n).Suppli_Modifica_Date_Id;
      rcRecOfTab.Supplier_Id(n) := itbLD_suppli_modifica_date(n).Supplier_Id;
      rcRecOfTab.Initial_Date(n) := itbLD_suppli_modifica_date(n).Initial_Date;
      rcRecOfTab.Final_Date(n) := itbLD_suppli_modifica_date(n).Final_Date;
      rcRecOfTab.Initial_Hour(n) := itbLD_suppli_modifica_date(n).Initial_Hour;
      rcRecOfTab.Final_Hour(n) := itbLD_suppli_modifica_date(n).Final_Hour;
      rcRecOfTab.row_id(n) := itbLD_suppli_modifica_date(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUPPLI_MODIFICA_DATE_Id
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
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUPPLI_MODIFICA_DATE_Id = rcData.SUPPLI_MODIFICA_DATE_Id
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
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
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
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    orcRecord out nocopy styLD_suppli_modifica_date
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  RETURN styLD_suppli_modifica_date
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type
  )
  RETURN styLD_suppli_modifica_date
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_suppli_modifica_date
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_suppli_modifica_date
  )
  IS
    rfLD_suppli_modifica_date tyrfLD_suppli_modifica_date;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_suppli_modifica_date.Suppli_Modifica_Date_Id,
                LD_suppli_modifica_date.Supplier_Id,
                LD_suppli_modifica_date.Initial_Date,
                LD_suppli_modifica_date.Final_Date,
                LD_suppli_modifica_date.Initial_Hour,
                LD_suppli_modifica_date.Final_Hour,
                LD_suppli_modifica_date.rowid
                FROM LD_suppli_modifica_date';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_suppli_modifica_date for sbFullQuery;
    fetch rfLD_suppli_modifica_date bulk collect INTO otbResult;
    close rfLD_suppli_modifica_date;
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
                LD_suppli_modifica_date.Suppli_Modifica_Date_Id,
                LD_suppli_modifica_date.Supplier_Id,
                LD_suppli_modifica_date.Initial_Date,
                LD_suppli_modifica_date.Final_Date,
                LD_suppli_modifica_date.Initial_Hour,
                LD_suppli_modifica_date.Final_Hour,
                LD_suppli_modifica_date.rowid
                FROM LD_suppli_modifica_date';
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
    ircLD_suppli_modifica_date in styLD_suppli_modifica_date
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_suppli_modifica_date,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_suppli_modifica_date in styLD_suppli_modifica_date,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUPPLI_MODIFICA_DATE_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_suppli_modifica_date
    (
      Suppli_Modifica_Date_Id,
      Supplier_Id,
      Initial_Date,
      Final_Date,
      Initial_Hour,
      Final_Hour
    )
    values
    (
      ircLD_suppli_modifica_date.Suppli_Modifica_Date_Id,
      ircLD_suppli_modifica_date.Supplier_Id,
      ircLD_suppli_modifica_date.Initial_Date,
      ircLD_suppli_modifica_date.Final_Date,
      ircLD_suppli_modifica_date.Initial_Hour,
      ircLD_suppli_modifica_date.Final_Hour
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_suppli_modifica_date));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_suppli_modifica_date in out nocopy tytbLD_suppli_modifica_date
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_suppli_modifica_date, blUseRowID);
    forall n in iotbLD_suppli_modifica_date.first..iotbLD_suppli_modifica_date.last
      insert into LD_suppli_modifica_date
      (
      Suppli_Modifica_Date_Id,
      Supplier_Id,
      Initial_Date,
      Final_Date,
      Initial_Hour,
      Final_Hour
    )
    values
    (
      rcRecOfTab.Suppli_Modifica_Date_Id(n),
      rcRecOfTab.Supplier_Id(n),
      rcRecOfTab.Initial_Date(n),
      rcRecOfTab.Final_Date(n),
      rcRecOfTab.Initial_Hour(n),
      rcRecOfTab.Final_Hour(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUPPLI_MODIFICA_DATE_Id,
        rcData
      );
    end if;

    delete
    from LD_suppli_modifica_date
    where
           SUPPLI_MODIFICA_DATE_Id=inuSUPPLI_MODIFICA_DATE_Id;
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
    rcError  styLD_suppli_modifica_date;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_suppli_modifica_date
    where
      rowid = iriRowID
    returning
   SUPPLI_MODIFICA_DATE_Id
    into
      rcError.SUPPLI_MODIFICA_DATE_Id;

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
    iotbLD_suppli_modifica_date in out nocopy tytbLD_suppli_modifica_date,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_suppli_modifica_date;
  BEGIN
    FillRecordOfTables(iotbLD_suppli_modifica_date, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last
        delete
        from LD_suppli_modifica_date
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last loop
          LockByPk
          (
              rcRecOfTab.SUPPLI_MODIFICA_DATE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last
        delete
        from LD_suppli_modifica_date
        where
               SUPPLI_MODIFICA_DATE_Id = rcRecOfTab.SUPPLI_MODIFICA_DATE_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_suppli_modifica_date in styLD_suppli_modifica_date,
    inuLock    in number default 0
  )
  IS
    nuSUPPLI_MODIFICA_DATE_Id LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type;

  BEGIN
    if ircLD_suppli_modifica_date.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_suppli_modifica_date.rowid,rcData);
      end if;
      update LD_suppli_modifica_date
      set

        Supplier_Id = ircLD_suppli_modifica_date.Supplier_Id,
        Initial_Date = ircLD_suppli_modifica_date.Initial_Date,
        Final_Date = ircLD_suppli_modifica_date.Final_Date,
        Initial_Hour = ircLD_suppli_modifica_date.Initial_Hour,
        Final_Hour = ircLD_suppli_modifica_date.Final_Hour
      where
        rowid = ircLD_suppli_modifica_date.rowid
      returning
    SUPPLI_MODIFICA_DATE_Id
      into
        nuSUPPLI_MODIFICA_DATE_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id,
          rcData
        );
      end if;

      update LD_suppli_modifica_date
      set
        Supplier_Id = ircLD_suppli_modifica_date.Supplier_Id,
        Initial_Date = ircLD_suppli_modifica_date.Initial_Date,
        Final_Date = ircLD_suppli_modifica_date.Final_Date,
        Initial_Hour = ircLD_suppli_modifica_date.Initial_Hour,
        Final_Hour = ircLD_suppli_modifica_date.Final_Hour
      where
             SUPPLI_MODIFICA_DATE_Id = ircLD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id
      returning
    SUPPLI_MODIFICA_DATE_Id
      into
        nuSUPPLI_MODIFICA_DATE_Id;
    end if;

    if
      nuSUPPLI_MODIFICA_DATE_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_suppli_modifica_date));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_suppli_modifica_date in out nocopy tytbLD_suppli_modifica_date,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_suppli_modifica_date;
  BEGIN
    FillRecordOfTables(iotbLD_suppli_modifica_date,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last
        update LD_suppli_modifica_date
        set

            Supplier_Id = rcRecOfTab.Supplier_Id(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Initial_Hour = rcRecOfTab.Initial_Hour(n),
            Final_Hour = rcRecOfTab.Final_Hour(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last loop
          LockByPk
          (
              rcRecOfTab.SUPPLI_MODIFICA_DATE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_suppli_modifica_date.first .. iotbLD_suppli_modifica_date.last
        update LD_suppli_modifica_date
        set
          Supplier_Id = rcRecOfTab.Supplier_Id(n),
          Initial_Date = rcRecOfTab.Initial_Date(n),
          Final_Date = rcRecOfTab.Final_Date(n),
          Initial_Hour = rcRecOfTab.Initial_Hour(n),
          Final_Hour = rcRecOfTab.Final_Hour(n)
          where
          SUPPLI_MODIFICA_DATE_Id = rcRecOfTab.SUPPLI_MODIFICA_DATE_Id(n)
;
    end if;
  END;

  PROCEDURE updSupplier_Id
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuSupplier_Id$ in LD_suppli_modifica_date.Supplier_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUPPLI_MODIFICA_DATE_Id,
        rcData
      );
    end if;

    update LD_suppli_modifica_date
    set
      Supplier_Id = inuSupplier_Id$
    where
      SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Supplier_Id:= inuSupplier_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInitial_Date
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    idtInitial_Date$ in LD_suppli_modifica_date.Initial_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUPPLI_MODIFICA_DATE_Id,
        rcData
      );
    end if;

    update LD_suppli_modifica_date
    set
      Initial_Date = idtInitial_Date$
    where
      SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id;

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
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    idtFinal_Date$ in LD_suppli_modifica_date.Final_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUPPLI_MODIFICA_DATE_Id,
        rcData
      );
    end if;

    update LD_suppli_modifica_date
    set
      Final_Date = idtFinal_Date$
    where
      SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Final_Date:= idtFinal_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInitial_Hour
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    isbInitial_Hour$ in LD_suppli_modifica_date.Initial_Hour%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUPPLI_MODIFICA_DATE_Id,
        rcData
      );
    end if;

    update LD_suppli_modifica_date
    set
      Initial_Hour = isbInitial_Hour$
    where
      SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Initial_Hour:= isbInitial_Hour$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updFinal_Hour
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    isbFinal_Hour$ in LD_suppli_modifica_date.Final_Hour%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN
    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUPPLI_MODIFICA_DATE_Id,
        rcData
      );
    end if;

    update LD_suppli_modifica_date
    set
      Final_Hour = isbFinal_Hour$
    where
      SUPPLI_MODIFICA_DATE_Id = inuSUPPLI_MODIFICA_DATE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Final_Hour:= isbFinal_Hour$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSuppli_Modifica_Date_Id
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_suppli_modifica_date.Suppli_Modifica_Date_Id%type
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN

    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData.Suppli_Modifica_Date_Id);
    end if;
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    return(rcData.Suppli_Modifica_Date_Id);
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
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_suppli_modifica_date.Supplier_Id%type
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN

    rcError.SUPPLI_MODIFICA_DATE_Id := inuSUPPLI_MODIFICA_DATE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData.Supplier_Id);
    end if;
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
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

  FUNCTION fdtGetInitial_Date
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_suppli_modifica_date.Initial_Date%type
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN

    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData.Initial_Date);
    end if;
    Load
    (
         inuSUPPLI_MODIFICA_DATE_Id
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
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_suppli_modifica_date.Final_Date%type
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN

    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData.Final_Date);
    end if;
    Load
    (
         inuSUPPLI_MODIFICA_DATE_Id
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

  FUNCTION fsbGetInitial_Hour
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_suppli_modifica_date.Initial_Hour%type
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN

    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData.Initial_Hour);
    end if;
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    return(rcData.Initial_Hour);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetFinal_Hour
  (
    inuSUPPLI_MODIFICA_DATE_Id in LD_suppli_modifica_date.SUPPLI_MODIFICA_DATE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_suppli_modifica_date.Final_Hour%type
  IS
    rcError styLD_suppli_modifica_date;
  BEGIN

    rcError.SUPPLI_MODIFICA_DATE_Id:=inuSUPPLI_MODIFICA_DATE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUPPLI_MODIFICA_DATE_Id
       )
    then
       return(rcData.Final_Hour);
    end if;
    Load
    (
      inuSUPPLI_MODIFICA_DATE_Id
    );
    return(rcData.Final_Hour);
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
end DALD_suppli_modifica_date;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUPPLI_MODIFICA_DATE
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUPPLI_MODIFICA_DATE', 'ADM_PERSON');
END;
/