CREATE OR REPLACE PACKAGE adm_person.dald_equivalence_line
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
  )
  IS
		SELECT LD_equivalence_line.*,LD_equivalence_line.rowid
		FROM LD_equivalence_line
		WHERE
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_equivalence_line.*,LD_equivalence_line.rowid
		FROM LD_equivalence_line
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_equivalence_line  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_equivalence_line is table of styLD_equivalence_line index by binary_integer;
	type tyrfRecords is ref cursor return styLD_equivalence_line;

	/* Tipos referenciando al registro */
	type tytbEquivalence_Line_Id is table of LD_equivalence_line.Equivalence_Line_Id%type index by binary_integer;
	type tytbSubline_Exito is table of LD_equivalence_line.Subline_Exito%type index by binary_integer;
	type tytbDesc_Subline_Exito is table of LD_equivalence_line.Desc_Subline_Exito%type index by binary_integer;
	type tytbCategori_Exito is table of LD_equivalence_line.Categori_Exito%type index by binary_integer;
	type tytbDesc_Categ_Exito is table of LD_equivalence_line.Desc_Categ_Exito%type index by binary_integer;
	type tytbSubcateg_Exito is table of LD_equivalence_line.Subcateg_Exito%type index by binary_integer;
	type tytbDesc_Subcateg_Exito is table of LD_equivalence_line.Desc_Subcateg_Exito%type index by binary_integer;
	type tytbSegment is table of LD_equivalence_line.Segment%type index by binary_integer;
	type tytbDescription_Segment is table of LD_equivalence_line.Description_Segment%type index by binary_integer;
	type tytbLine_Id is table of LD_equivalence_line.Line_Id%type index by binary_integer;
	type tytbSubline_Id is table of LD_equivalence_line.Subline_Id%type index by binary_integer;
	type tytbConccodi is table of LD_equivalence_line.Conccodi%type index by binary_integer;
	type tytbServcodi is table of LD_equivalence_line.Servcodi%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_equivalence_line is record
	(

		Equivalence_Line_Id   tytbEquivalence_Line_Id,
		Subline_Exito   tytbSubline_Exito,
		Desc_Subline_Exito   tytbDesc_Subline_Exito,
		Categori_Exito   tytbCategori_Exito,
		Desc_Categ_Exito   tytbDesc_Categ_Exito,
		Subcateg_Exito   tytbSubcateg_Exito,
		Desc_Subcateg_Exito   tytbDesc_Subcateg_Exito,
		Segment   tytbSegment,
		Description_Segment   tytbDescription_Segment,
		Line_Id   tytbLine_Id,
		Subline_Id   tytbSubline_Id,
		Conccodi   tytbConccodi,
		Servcodi   tytbServcodi,
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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	);

	PROCEDURE getRecord
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		orcRecord out nocopy styLD_equivalence_line
	);

	FUNCTION frcGetRcData
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN styLD_equivalence_line;

	FUNCTION frcGetRcData
	RETURN styLD_equivalence_line;

	FUNCTION frcGetRecord
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN styLD_equivalence_line;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_equivalence_line
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_equivalence_line in styLD_equivalence_line
	);

 	  PROCEDURE insRecord
	(
		ircLD_equivalence_line in styLD_equivalence_line,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_equivalence_line in out nocopy tytbLD_equivalence_line
	);

	PROCEDURE delRecord
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_equivalence_line in out nocopy tytbLD_equivalence_line,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_equivalence_line in styLD_equivalence_line,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_equivalence_line in out nocopy tytbLD_equivalence_line,
		inuLock in number default 1
	);

		PROCEDURE updSubline_Exito
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuSubline_Exito$  in LD_equivalence_line.Subline_Exito%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDesc_Subline_Exito
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				isbDesc_Subline_Exito$  in LD_equivalence_line.Desc_Subline_Exito%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCategori_Exito
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuCategori_Exito$  in LD_equivalence_line.Categori_Exito%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDesc_Categ_Exito
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				isbDesc_Categ_Exito$  in LD_equivalence_line.Desc_Categ_Exito%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubcateg_Exito
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuSubcateg_Exito$  in LD_equivalence_line.Subcateg_Exito%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDesc_Subcateg_Exito
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				isbDesc_Subcateg_Exito$  in LD_equivalence_line.Desc_Subcateg_Exito%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSegment
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuSegment$  in LD_equivalence_line.Segment%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDescription_Segment
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				isbDescription_Segment$  in LD_equivalence_line.Description_Segment%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLine_Id
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuLine_Id$  in LD_equivalence_line.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubline_Id
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuSubline_Id$  in LD_equivalence_line.Subline_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updConccodi
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuConccodi$  in LD_equivalence_line.Conccodi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updServcodi
		(
				inuEQUIVALENCE_LINE_Id   in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
				inuServcodi$  in LD_equivalence_line.Servcodi%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetEquivalence_Line_Id
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Equivalence_Line_Id%type;

    	FUNCTION fnuGetSubline_Exito
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Subline_Exito%type;

    	FUNCTION fsbGetDesc_Subline_Exito
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Desc_Subline_Exito%type;

    	FUNCTION fnuGetCategori_Exito
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Categori_Exito%type;

    	FUNCTION fsbGetDesc_Categ_Exito
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Desc_Categ_Exito%type;

    	FUNCTION fnuGetSubcateg_Exito
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Subcateg_Exito%type;

    	FUNCTION fsbGetDesc_Subcateg_Exito
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Desc_Subcateg_Exito%type;

    	FUNCTION fnuGetSegment
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Segment%type;

    	FUNCTION fsbGetDescription_Segment
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Description_Segment%type;

    	FUNCTION fnuGetLine_Id
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Line_Id%type;

    	FUNCTION fnuGetSubline_Id
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Subline_Id%type;

    	FUNCTION fnuGetConccodi
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Conccodi%type;

    	FUNCTION fnuGetServcodi
    	(
    	    inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_equivalence_line.Servcodi%type;


	PROCEDURE LockByPk
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		orcLD_equivalence_line  out styLD_equivalence_line
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_equivalence_line  out styLD_equivalence_line
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_equivalence_line;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_equivalence_line
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_EQUIVALENCE_LINE';
	  cnuGeEntityId constant varchar2(30) := 8284; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	IS
		SELECT LD_equivalence_line.*,LD_equivalence_line.rowid
		FROM LD_equivalence_line
		WHERE  EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_equivalence_line.*,LD_equivalence_line.rowid
		FROM LD_equivalence_line
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_equivalence_line is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_equivalence_line;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_equivalence_line default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.EQUIVALENCE_LINE_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		orcLD_equivalence_line  out styLD_equivalence_line
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		Open cuLockRcByPk
		(
			inuEQUIVALENCE_LINE_Id
		);

		fetch cuLockRcByPk into orcLD_equivalence_line;
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
		orcLD_equivalence_line  out styLD_equivalence_line
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_equivalence_line;
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
		itbLD_equivalence_line  in out nocopy tytbLD_equivalence_line
	)
	IS
	BEGIN
			rcRecOfTab.Equivalence_Line_Id.delete;
			rcRecOfTab.Subline_Exito.delete;
			rcRecOfTab.Desc_Subline_Exito.delete;
			rcRecOfTab.Categori_Exito.delete;
			rcRecOfTab.Desc_Categ_Exito.delete;
			rcRecOfTab.Subcateg_Exito.delete;
			rcRecOfTab.Desc_Subcateg_Exito.delete;
			rcRecOfTab.Segment.delete;
			rcRecOfTab.Description_Segment.delete;
			rcRecOfTab.Line_Id.delete;
			rcRecOfTab.Subline_Id.delete;
			rcRecOfTab.Conccodi.delete;
			rcRecOfTab.Servcodi.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_equivalence_line  in out nocopy tytbLD_equivalence_line,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_equivalence_line);
		for n in itbLD_equivalence_line.first .. itbLD_equivalence_line.last loop
			rcRecOfTab.Equivalence_Line_Id(n) := itbLD_equivalence_line(n).Equivalence_Line_Id;
			rcRecOfTab.Subline_Exito(n) := itbLD_equivalence_line(n).Subline_Exito;
			rcRecOfTab.Desc_Subline_Exito(n) := itbLD_equivalence_line(n).Desc_Subline_Exito;
			rcRecOfTab.Categori_Exito(n) := itbLD_equivalence_line(n).Categori_Exito;
			rcRecOfTab.Desc_Categ_Exito(n) := itbLD_equivalence_line(n).Desc_Categ_Exito;
			rcRecOfTab.Subcateg_Exito(n) := itbLD_equivalence_line(n).Subcateg_Exito;
			rcRecOfTab.Desc_Subcateg_Exito(n) := itbLD_equivalence_line(n).Desc_Subcateg_Exito;
			rcRecOfTab.Segment(n) := itbLD_equivalence_line(n).Segment;
			rcRecOfTab.Description_Segment(n) := itbLD_equivalence_line(n).Description_Segment;
			rcRecOfTab.Line_Id(n) := itbLD_equivalence_line(n).Line_Id;
			rcRecOfTab.Subline_Id(n) := itbLD_equivalence_line(n).Subline_Id;
			rcRecOfTab.Conccodi(n) := itbLD_equivalence_line(n).Conccodi;
			rcRecOfTab.Servcodi(n) := itbLD_equivalence_line(n).Servcodi;
			rcRecOfTab.row_id(n) := itbLD_equivalence_line(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuEQUIVALENCE_LINE_Id
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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuEQUIVALENCE_LINE_Id = rcData.EQUIVALENCE_LINE_Id
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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		Load
		(
			inuEQUIVALENCE_LINE_Id
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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		orcRecord out nocopy styLD_equivalence_line
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN styLD_equivalence_line
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type
	)
	RETURN styLD_equivalence_line
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_equivalence_line
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_equivalence_line
	)
	IS
		rfLD_equivalence_line tyrfLD_equivalence_line;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_equivalence_line.Equivalence_Line_Id,
		            LD_equivalence_line.Subline_Exito,
		            LD_equivalence_line.Desc_Subline_Exito,
		            LD_equivalence_line.Categori_Exito,
		            LD_equivalence_line.Desc_Categ_Exito,
		            LD_equivalence_line.Subcateg_Exito,
		            LD_equivalence_line.Desc_Subcateg_Exito,
		            LD_equivalence_line.Segment,
		            LD_equivalence_line.Description_Segment,
		            LD_equivalence_line.Line_Id,
		            LD_equivalence_line.Subline_Id,
		            LD_equivalence_line.Conccodi,
		            LD_equivalence_line.Servcodi,
		            LD_equivalence_line.rowid
                FROM LD_equivalence_line';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_equivalence_line for sbFullQuery;
		fetch rfLD_equivalence_line bulk collect INTO otbResult;
		close rfLD_equivalence_line;
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
		            LD_equivalence_line.Equivalence_Line_Id,
		            LD_equivalence_line.Subline_Exito,
		            LD_equivalence_line.Desc_Subline_Exito,
		            LD_equivalence_line.Categori_Exito,
		            LD_equivalence_line.Desc_Categ_Exito,
		            LD_equivalence_line.Subcateg_Exito,
		            LD_equivalence_line.Desc_Subcateg_Exito,
		            LD_equivalence_line.Segment,
		            LD_equivalence_line.Description_Segment,
		            LD_equivalence_line.Line_Id,
		            LD_equivalence_line.Subline_Id,
		            LD_equivalence_line.Conccodi,
		            LD_equivalence_line.Servcodi,
		            LD_equivalence_line.rowid
                FROM LD_equivalence_line';
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
		ircLD_equivalence_line in styLD_equivalence_line
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_equivalence_line,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_equivalence_line in styLD_equivalence_line,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_equivalence_line.EQUIVALENCE_LINE_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|EQUIVALENCE_LINE_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_equivalence_line
		(
			Equivalence_Line_Id,
			Subline_Exito,
			Desc_Subline_Exito,
			Categori_Exito,
			Desc_Categ_Exito,
			Subcateg_Exito,
			Desc_Subcateg_Exito,
			Segment,
			Description_Segment,
			Line_Id,
			Subline_Id,
			Conccodi,
			Servcodi
		)
		values
		(
			ircLD_equivalence_line.Equivalence_Line_Id,
			ircLD_equivalence_line.Subline_Exito,
			ircLD_equivalence_line.Desc_Subline_Exito,
			ircLD_equivalence_line.Categori_Exito,
			ircLD_equivalence_line.Desc_Categ_Exito,
			ircLD_equivalence_line.Subcateg_Exito,
			ircLD_equivalence_line.Desc_Subcateg_Exito,
			ircLD_equivalence_line.Segment,
			ircLD_equivalence_line.Description_Segment,
			ircLD_equivalence_line.Line_Id,
			ircLD_equivalence_line.Subline_Id,
			ircLD_equivalence_line.Conccodi,
			ircLD_equivalence_line.Servcodi
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_equivalence_line));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_equivalence_line in out nocopy tytbLD_equivalence_line
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_equivalence_line, blUseRowID);
		forall n in iotbLD_equivalence_line.first..iotbLD_equivalence_line.last
			insert into LD_equivalence_line
			(
			Equivalence_Line_Id,
			Subline_Exito,
			Desc_Subline_Exito,
			Categori_Exito,
			Desc_Categ_Exito,
			Subcateg_Exito,
			Desc_Subcateg_Exito,
			Segment,
			Description_Segment,
			Line_Id,
			Subline_Id,
			Conccodi,
			Servcodi
		)
		values
		(
			rcRecOfTab.Equivalence_Line_Id(n),
			rcRecOfTab.Subline_Exito(n),
			rcRecOfTab.Desc_Subline_Exito(n),
			rcRecOfTab.Categori_Exito(n),
			rcRecOfTab.Desc_Categ_Exito(n),
			rcRecOfTab.Subcateg_Exito(n),
			rcRecOfTab.Desc_Subcateg_Exito(n),
			rcRecOfTab.Segment(n),
			rcRecOfTab.Description_Segment(n),
			rcRecOfTab.Line_Id(n),
			rcRecOfTab.Subline_Id(n),
			rcRecOfTab.Conccodi(n),
			rcRecOfTab.Servcodi(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		delete
		from LD_equivalence_line
		where
       		EQUIVALENCE_LINE_Id=inuEQUIVALENCE_LINE_Id;
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
		rcError  styLD_equivalence_line;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_equivalence_line
		where
			rowid = iriRowID
		returning
   EQUIVALENCE_LINE_Id
		into
			rcError.EQUIVALENCE_LINE_Id;

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
		iotbLD_equivalence_line in out nocopy tytbLD_equivalence_line,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_equivalence_line;
	BEGIN
		FillRecordOfTables(iotbLD_equivalence_line, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last
				delete
				from LD_equivalence_line
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last loop
					LockByPk
					(
							rcRecOfTab.EQUIVALENCE_LINE_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last
				delete
				from LD_equivalence_line
				where
		         	EQUIVALENCE_LINE_Id = rcRecOfTab.EQUIVALENCE_LINE_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_equivalence_line in styLD_equivalence_line,
		inuLock	  in number default 0
	)
	IS
		nuEQUIVALENCE_LINE_Id LD_equivalence_line.EQUIVALENCE_LINE_Id%type;

	BEGIN
		if ircLD_equivalence_line.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_equivalence_line.rowid,rcData);
			end if;
			update LD_equivalence_line
			set

        Subline_Exito = ircLD_equivalence_line.Subline_Exito,
        Desc_Subline_Exito = ircLD_equivalence_line.Desc_Subline_Exito,
        Categori_Exito = ircLD_equivalence_line.Categori_Exito,
        Desc_Categ_Exito = ircLD_equivalence_line.Desc_Categ_Exito,
        Subcateg_Exito = ircLD_equivalence_line.Subcateg_Exito,
        Desc_Subcateg_Exito = ircLD_equivalence_line.Desc_Subcateg_Exito,
        Segment = ircLD_equivalence_line.Segment,
        Description_Segment = ircLD_equivalence_line.Description_Segment,
        Line_Id = ircLD_equivalence_line.Line_Id,
        Subline_Id = ircLD_equivalence_line.Subline_Id,
        Conccodi = ircLD_equivalence_line.Conccodi,
        Servcodi = ircLD_equivalence_line.Servcodi
			where
				rowid = ircLD_equivalence_line.rowid
			returning
    EQUIVALENCE_LINE_Id
			into
				nuEQUIVALENCE_LINE_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_equivalence_line.EQUIVALENCE_LINE_Id,
					rcData
				);
			end if;

			update LD_equivalence_line
			set
        Subline_Exito = ircLD_equivalence_line.Subline_Exito,
        Desc_Subline_Exito = ircLD_equivalence_line.Desc_Subline_Exito,
        Categori_Exito = ircLD_equivalence_line.Categori_Exito,
        Desc_Categ_Exito = ircLD_equivalence_line.Desc_Categ_Exito,
        Subcateg_Exito = ircLD_equivalence_line.Subcateg_Exito,
        Desc_Subcateg_Exito = ircLD_equivalence_line.Desc_Subcateg_Exito,
        Segment = ircLD_equivalence_line.Segment,
        Description_Segment = ircLD_equivalence_line.Description_Segment,
        Line_Id = ircLD_equivalence_line.Line_Id,
        Subline_Id = ircLD_equivalence_line.Subline_Id,
        Conccodi = ircLD_equivalence_line.Conccodi,
        Servcodi = ircLD_equivalence_line.Servcodi
			where
	         	EQUIVALENCE_LINE_Id = ircLD_equivalence_line.EQUIVALENCE_LINE_Id
			returning
    EQUIVALENCE_LINE_Id
			into
				nuEQUIVALENCE_LINE_Id;
		end if;

		if
			nuEQUIVALENCE_LINE_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_equivalence_line));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_equivalence_line in out nocopy tytbLD_equivalence_line,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_equivalence_line;
  BEGIN
    FillRecordOfTables(iotbLD_equivalence_line,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last
        update LD_equivalence_line
        set

            Subline_Exito = rcRecOfTab.Subline_Exito(n),
            Desc_Subline_Exito = rcRecOfTab.Desc_Subline_Exito(n),
            Categori_Exito = rcRecOfTab.Categori_Exito(n),
            Desc_Categ_Exito = rcRecOfTab.Desc_Categ_Exito(n),
            Subcateg_Exito = rcRecOfTab.Subcateg_Exito(n),
            Desc_Subcateg_Exito = rcRecOfTab.Desc_Subcateg_Exito(n),
            Segment = rcRecOfTab.Segment(n),
            Description_Segment = rcRecOfTab.Description_Segment(n),
            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Conccodi = rcRecOfTab.Conccodi(n),
            Servcodi = rcRecOfTab.Servcodi(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last loop
          LockByPk
          (
              rcRecOfTab.EQUIVALENCE_LINE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_equivalence_line.first .. iotbLD_equivalence_line.last
        update LD_equivalence_line
        set
					Subline_Exito = rcRecOfTab.Subline_Exito(n),
					Desc_Subline_Exito = rcRecOfTab.Desc_Subline_Exito(n),
					Categori_Exito = rcRecOfTab.Categori_Exito(n),
					Desc_Categ_Exito = rcRecOfTab.Desc_Categ_Exito(n),
					Subcateg_Exito = rcRecOfTab.Subcateg_Exito(n),
					Desc_Subcateg_Exito = rcRecOfTab.Desc_Subcateg_Exito(n),
					Segment = rcRecOfTab.Segment(n),
					Description_Segment = rcRecOfTab.Description_Segment(n),
					Line_Id = rcRecOfTab.Line_Id(n),
					Subline_Id = rcRecOfTab.Subline_Id(n),
					Conccodi = rcRecOfTab.Conccodi(n),
					Servcodi = rcRecOfTab.Servcodi(n)
          where
          EQUIVALENCE_LINE_Id = rcRecOfTab.EQUIVALENCE_LINE_Id(n)
;
    end if;
  END;

	PROCEDURE updSubline_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuSubline_Exito$ in LD_equivalence_line.Subline_Exito%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Subline_Exito = inuSubline_Exito$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subline_Exito:= inuSubline_Exito$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDesc_Subline_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		isbDesc_Subline_Exito$ in LD_equivalence_line.Desc_Subline_Exito%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Desc_Subline_Exito = isbDesc_Subline_Exito$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Desc_Subline_Exito:= isbDesc_Subline_Exito$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCategori_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuCategori_Exito$ in LD_equivalence_line.Categori_Exito%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Categori_Exito = inuCategori_Exito$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Categori_Exito:= inuCategori_Exito$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDesc_Categ_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		isbDesc_Categ_Exito$ in LD_equivalence_line.Desc_Categ_Exito%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Desc_Categ_Exito = isbDesc_Categ_Exito$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Desc_Categ_Exito:= isbDesc_Categ_Exito$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubcateg_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuSubcateg_Exito$ in LD_equivalence_line.Subcateg_Exito%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Subcateg_Exito = inuSubcateg_Exito$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subcateg_Exito:= inuSubcateg_Exito$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDesc_Subcateg_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		isbDesc_Subcateg_Exito$ in LD_equivalence_line.Desc_Subcateg_Exito%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Desc_Subcateg_Exito = isbDesc_Subcateg_Exito$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Desc_Subcateg_Exito:= isbDesc_Subcateg_Exito$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSegment
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuSegment$ in LD_equivalence_line.Segment%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Segment = inuSegment$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Segment:= inuSegment$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDescription_Segment
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		isbDescription_Segment$ in LD_equivalence_line.Description_Segment%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Description_Segment = isbDescription_Segment$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description_Segment:= isbDescription_Segment$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLine_Id
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuLine_Id$ in LD_equivalence_line.Line_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Line_Id = inuLine_Id$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuSubline_Id$ in LD_equivalence_line.Subline_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Subline_Id = inuSubline_Id$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subline_Id:= inuSubline_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updConccodi
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuConccodi$ in LD_equivalence_line.Conccodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Conccodi = inuConccodi$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Conccodi:= inuConccodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updServcodi
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuServcodi$ in LD_equivalence_line.Servcodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_equivalence_line;
	BEGIN
		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuEQUIVALENCE_LINE_Id,
				rcData
			);
		end if;

		update LD_equivalence_line
		set
			Servcodi = inuServcodi$
		where
			EQUIVALENCE_LINE_Id = inuEQUIVALENCE_LINE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Servcodi:= inuServcodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetEquivalence_Line_Id
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Equivalence_Line_Id%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Equivalence_Line_Id);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Equivalence_Line_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubline_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Subline_Exito%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Subline_Exito);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Subline_Exito);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDesc_Subline_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Desc_Subline_Exito%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Desc_Subline_Exito);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Desc_Subline_Exito);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCategori_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Categori_Exito%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Categori_Exito);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Categori_Exito);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDesc_Categ_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Desc_Categ_Exito%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Desc_Categ_Exito);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Desc_Categ_Exito);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubcateg_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Subcateg_Exito%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Subcateg_Exito);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Subcateg_Exito);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDesc_Subcateg_Exito
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Desc_Subcateg_Exito%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Desc_Subcateg_Exito);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Desc_Subcateg_Exito);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSegment
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Segment%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Segment);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Segment);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDescription_Segment
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Description_Segment%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id:=inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Description_Segment);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Description_Segment);
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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Line_Id%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Line_Id);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
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
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Subline_Id%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Subline_Id);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
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

	FUNCTION fnuGetConccodi
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Conccodi%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Conccodi);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
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

	FUNCTION fnuGetServcodi
	(
		inuEQUIVALENCE_LINE_Id in LD_equivalence_line.EQUIVALENCE_LINE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_equivalence_line.Servcodi%type
	IS
		rcError styLD_equivalence_line;
	BEGIN

		rcError.EQUIVALENCE_LINE_Id := inuEQUIVALENCE_LINE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuEQUIVALENCE_LINE_Id
			 )
		then
			 return(rcData.Servcodi);
		end if;
		Load
		(
			inuEQUIVALENCE_LINE_Id
		);
		return(rcData.Servcodi);
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
end DALD_equivalence_line;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_EQUIVALENCE_LINE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_EQUIVALENCE_LINE', 'ADM_PERSON'); 
END;
/