CREATE OR REPLACE PACKAGE pktblIc_Detlisim
is
    ---------------
    -- VARIABLES
    ---------------
    -- Cursor para accesar Ic_Detlisim
    cursor cuIc_Detlisim
    (
		inuDelicons in Ic_Detlisim.Delicons%type
    )
    is
        SELECT *
        FROM Ic_Detlisim
        WHERE  Delicons = inuDelicons;


	-- Define colecciones de cada columna de la tabla
	type tyDelicons is table of Ic_Detlisim.Delicons%type index by binary_integer;
	type tyDelinuse is table of Ic_Detlisim.Delinuse%type index by binary_integer;
	type tyDelifeco is table of Ic_Detlisim.Delifeco%type index by binary_integer;
	type tyDelidimo is table of Ic_Detlisim.Delidimo%type index by binary_integer;
	type tyDelipudm is table of Ic_Detlisim.Delipudm%type index by binary_integer;
	type tyDelimxam is table of Ic_Detlisim.Delimxam%type index by binary_integer;
	type tyDelipmam is table of Ic_Detlisim.Delipmam%type index by binary_integer;
	type tyDelimxsm is table of Ic_Detlisim.Delimxsm%type index by binary_integer;
	type tyDelipmsm is table of Ic_Detlisim.Delipmsm%type index by binary_integer;
	type tyDeliprsm is table of Ic_Detlisim.Deliprsm%type index by binary_integer;
	type tyDelippsm is table of Ic_Detlisim.Delippsm%type index by binary_integer;
	type tyDeliprtm is table of Ic_Detlisim.Deliprtm%type index by binary_integer;
	type tyDelipptm is table of Ic_Detlisim.Delipptm%type index by binary_integer;
	type tyDelimoca is table of Ic_Detlisim.Delimoca%type index by binary_integer;
	type tyDelipmca is table of Ic_Detlisim.Delipmca%type index by binary_integer;
	type tyDelicuap is table of Ic_Detlisim.Delicuap%type index by binary_integer;
	type tyDelipcap is table of Ic_Detlisim.Delipcap%type index by binary_integer;
	type tyDelicumx is table of Ic_Detlisim.Delicumx%type index by binary_integer;
	type tyDelipcmx is table of Ic_Detlisim.Delipcmx%type index by binary_integer;
	type tyDelicuuf is table of Ic_Detlisim.Delicuuf%type index by binary_integer;
	type tyDelipcuf is table of Ic_Detlisim.Delipcuf%type index by binary_integer;
	type tyDeliinte is table of Ic_Detlisim.Deliinte%type index by binary_integer;
	type tyDelifact is table of Ic_Detlisim.Delifact%type index by binary_integer;
	type tyDelipecu is table of Ic_Detlisim.Delipecu%type index by binary_integer;
	type tyDeliprcu is table of Ic_Detlisim.Deliprcu%type index by binary_integer;
	type tyDeliprin is table of Ic_Detlisim.Deliprin%type index by binary_integer;
    -- nuevos campos TEAM 571  JLizardocastro
    type tyDelimoua is table of Ic_Detlisim.Delimoua%type index by binary_integer;
	type tyDelimous is table of Ic_Detlisim.Delimous%type index by binary_integer;
	type tyDelimoss is table of Ic_Detlisim.Delimoss%type index by binary_integer;
	type tyDelimout is table of Ic_Detlisim.Delimout%type index by binary_integer;
	type tydelipout is table of Ic_Detlisim.delipout%type index by binary_integer;


    type tytbIc_Detlisim is record
	(
        Delicons tyDelicons,
        Delinuse tyDelinuse,
        Delifeco tyDelifeco,
        Delidimo tyDelidimo,
        Delipudm tyDelipudm,
        Delimxam tyDelimxam,
        Delipmam tyDelipmam,
        Delimxsm tyDelimxsm,
        Delipmsm tyDelipmsm,
        Deliprsm tyDeliprsm,
        Delippsm tyDelippsm,
        Deliprtm tyDeliprtm,
        Delipptm tyDelipptm,
        Delimoca tyDelimoca,
        Delipmca tyDelipmca,
        Delicuap tyDelicuap,
        Delipcap tyDelipcap,
        Delicumx tyDelicumx,
        Delipcmx tyDelipcmx,
        Delicuuf tyDelicuuf,
        Delipcuf tyDelipcuf,
        Deliinte tyDeliinte,
        Delifact tyDelifact,
        Delipecu tyDelipecu,
        Deliprcu tyDeliprcu,
        Deliprin tyDeliprin,
        Delimoua tyDelimoua,
        Delimous tyDelimous,
        Delimoss tyDelimoss,
        Delimout tyDelimout,
        delipout tydelipout
	);


    ---------------
    -- METHODS
    ---------------

    FUNCTION fsbVersion
    RETURN varchar2;

	function fsbGetMessageDescription
	(
		inuMenscodi	IN number
	)
	return varchar2;

	PROCEDURE insRecord
	(
		ircRecord in Ic_Detlisim%rowtype
	);

	PROCEDURE InsRecords
	(
		irctbRecord in out nocopy tytbIc_Detlisim
	);

	PROCEDURE InsForEachColumn
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelinuse in Ic_Detlisim.Delinuse%type,
		idtDelifeco in Ic_Detlisim.Delifeco%type,
		inuDelidimo in Ic_Detlisim.Delidimo%type,
		inuDelipudm in Ic_Detlisim.Delipudm%type,
		inuDelimxam in Ic_Detlisim.Delimxam%type,
		inuDelipmam in Ic_Detlisim.Delipmam%type,
		inuDelimxsm in Ic_Detlisim.Delimxsm%type,
		inuDelipmsm in Ic_Detlisim.Delipmsm%type,
		inuDeliprsm in Ic_Detlisim.Deliprsm%type,
		inuDelippsm in Ic_Detlisim.Delippsm%type,
		inuDeliprtm in Ic_Detlisim.Deliprtm%type,
		inuDelipptm in Ic_Detlisim.Delipptm%type,
		inuDelimoca in Ic_Detlisim.Delimoca%type,
		inuDelipmca in Ic_Detlisim.Delipmca%type,
		inuDelicuap in Ic_Detlisim.Delicuap%type,
		inuDelipcap in Ic_Detlisim.Delipcap%type,
		inuDelicumx in Ic_Detlisim.Delicumx%type,
		inuDelipcmx in Ic_Detlisim.Delipcmx%type,
		inuDelicuuf in Ic_Detlisim.Delicuuf%type,
		inuDelipcuf in Ic_Detlisim.Delipcuf%type,
		inuDeliinte in Ic_Detlisim.Deliinte%type,
		inuDelifact in Ic_Detlisim.Delifact%type,
		inuDelipecu in Ic_Detlisim.Delipecu%type,
		inuDeliprcu in Ic_Detlisim.Deliprcu%type,
		inuDeliprin in Ic_Detlisim.Deliprin%type,
		inuDelimoua in Ic_Detlisim.Delimoua%type,
		inuDelimous in Ic_Detlisim.Delimous%type,
		inuDelimoss in Ic_Detlisim.Delimoss%type,
		inuDelimout in Ic_Detlisim.Delimout%type,
		inudelipout in Ic_Detlisim.delipout%type
	);

	PROCEDURE InsForEachColumnBulk
	(
		inuDelicons in out nocopy tyDelicons,
		inuDelinuse in out nocopy tyDelinuse,
		idtDelifeco in out nocopy tyDelifeco,
		inuDelidimo in out nocopy tyDelidimo,
		inuDelipudm in out nocopy tyDelipudm,
		inuDelimxam in out nocopy tyDelimxam,
		inuDelipmam in out nocopy tyDelipmam,
		inuDelimxsm in out nocopy tyDelimxsm,
		inuDelipmsm in out nocopy tyDelipmsm,
		inuDeliprsm in out nocopy tyDeliprsm,
		inuDelippsm in out nocopy tyDelippsm,
		inuDeliprtm in out nocopy tyDeliprtm,
		inuDelipptm in out nocopy tyDelipptm,
		inuDelimoca in out nocopy tyDelimoca,
		inuDelipmca in out nocopy tyDelipmca,
		inuDelicuap in out nocopy tyDelicuap,
		inuDelipcap in out nocopy tyDelipcap,
		inuDelicumx in out nocopy tyDelicumx,
		inuDelipcmx in out nocopy tyDelipcmx,
		inuDelicuuf in out nocopy tyDelicuuf,
		inuDelipcuf in out nocopy tyDelipcuf,
		inuDeliinte in out nocopy tyDeliinte,
		inuDelifact in out nocopy tyDelifact,
		inuDelipecu in out nocopy tyDelipecu,
		inuDeliprcu in out nocopy tyDeliprcu,
		inuDeliprin in out nocopy tyDeliprin,
		inuDelimoua in out nocopy tyDelimoua,
		inuDelimous in out nocopy tyDelimous,
		inuDelimoss in out nocopy tyDelimoss,
		inuDelimout in out nocopy tyDelimout,
		inudelipout in out nocopy tydelipout
	);

	PROCEDURE ClearMemory;

	PROCEDURE DelRecord
	(
		inuDelicons in Ic_Detlisim.Delicons%type
	);

	PROCEDURE UpRecord
	(
		ircRecord in Ic_Detlisim%rowtype
	);

	PROCEDURE DelRecords
	(
		inuDelicons in out nocopy tyDelicons
	);

	FUNCTION fblExist
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN boolean;

	FUNCTION frcGetRecord
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim%rowtype;

	PROCEDURE AccKey
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	);

	PROCEDURE ValidateDupValues
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	);

	PROCEDURE UpdDelinuse
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelinuse$ in Ic_Detlisim.Delinuse%type
	);

	PROCEDURE UpdDelifeco
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		idtDelifeco$ in Ic_Detlisim.Delifeco%type
	);

	PROCEDURE UpdDelidimo
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelidimo$ in Ic_Detlisim.Delidimo%type
	);

	PROCEDURE UpdDelipudm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipudm$ in Ic_Detlisim.Delipudm%type
	);

	PROCEDURE UpdDelimxam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelimxam$ in Ic_Detlisim.Delimxam%type
	);

	PROCEDURE UpdDelipmam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipmam$ in Ic_Detlisim.Delipmam%type
	);

	PROCEDURE UpdDelimxsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelimxsm$ in Ic_Detlisim.Delimxsm%type
	);

	PROCEDURE UpdDelipmsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipmsm$ in Ic_Detlisim.Delipmsm%type
	);

	PROCEDURE UpdDeliprsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprsm$ in Ic_Detlisim.Deliprsm%type
	);

	PROCEDURE UpdDelippsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelippsm$ in Ic_Detlisim.Delippsm%type
	);

	PROCEDURE UpdDeliprtm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprtm$ in Ic_Detlisim.Deliprtm%type
	);

	PROCEDURE UpdDelipptm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipptm$ in Ic_Detlisim.Delipptm%type
	);

	PROCEDURE UpdDelimoca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelimoca$ in Ic_Detlisim.Delimoca%type
	);

	PROCEDURE UpdDelipmca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipmca$ in Ic_Detlisim.Delipmca%type
	);

	PROCEDURE UpdDelicuap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelicuap$ in Ic_Detlisim.Delicuap%type
	);

	PROCEDURE UpdDelipcap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipcap$ in Ic_Detlisim.Delipcap%type
	);

	PROCEDURE UpdDelicumx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelicumx$ in Ic_Detlisim.Delicumx%type
	);

	PROCEDURE UpdDelipcmx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipcmx$ in Ic_Detlisim.Delipcmx%type
	);

	PROCEDURE UpdDelicuuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelicuuf$ in Ic_Detlisim.Delicuuf%type
	);

	PROCEDURE UpdDelipcuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipcuf$ in Ic_Detlisim.Delipcuf%type
	);

	PROCEDURE UpdDeliinte
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliinte$ in Ic_Detlisim.Deliinte%type
	);

	PROCEDURE UpdDelifact
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelifact$ in Ic_Detlisim.Delifact%type
	);

	PROCEDURE UpdDelipecu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipecu$ in Ic_Detlisim.Delipecu%type
	);

	PROCEDURE UpdDeliprcu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprcu$ in Ic_Detlisim.Deliprcu%type
	);

	PROCEDURE UpdDeliprin
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprin$ in Ic_Detlisim.Deliprin%type
	);

	function fnuGetDelicons
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicons%type;

	function fnuGetDelinuse
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delinuse%type;

	function fdtGetDelifeco
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delifeco%type;

	function fnuGetDelidimo
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delidimo%type;

	function fnuGetDelipudm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipudm%type;

	function fnuGetDelimxam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delimxam%type;

	function fnuGetDelipmam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipmam%type;

	function fnuGetDelimxsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delimxsm%type;

	function fnuGetDelipmsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipmsm%type;

	function fnuGetDeliprsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprsm%type;

	function fnuGetDelippsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delippsm%type;

	function fnuGetDeliprtm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprtm%type;

	function fnuGetDelipptm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipptm%type;

	function fnuGetDelimoca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delimoca%type;

	function fnuGetDelipmca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipmca%type;

	function fnuGetDelicuap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicuap%type;

	function fnuGetDelipcap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipcap%type;

	function fnuGetDelicumx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicumx%type;

	function fnuGetDelipcmx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipcmx%type;

	function fnuGetDelicuuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicuuf%type;

	function fnuGetDelipcuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipcuf%type;

	function fnuGetDeliinte
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliinte%type;

	function fnuGetDelifact
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delifact%type;

	function fnuGetDelipecu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipecu%type;

	function fnuGetDeliprcu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprcu%type;

	function fnuGetDeliprin
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprin%type;

END pktblIc_Detlisim;
/
CREATE OR REPLACE PACKAGE BODY pktblIc_Detlisim
IS

   -------------------------
   -- PRIVATE VARIABLES
   -------------------------
   -- Record Tabla Ic_Detlisim
   rcIc_Detlisim cuIc_Detlisim%rowtype;
   -- Record nulo de la Tabla Ic_Detlisim
   rcRecordNull Ic_Detlisim%rowtype;
   -----------------
   -- CONSTANTES
   -----------------
	csbVersion constant varchar2(20) := 'SAO180611';
	CACHE constant number := 1; -- Buscar en Cache
	-------------------------
	-- PRIVATE CONSTANTS
	-------------------------
   cnuRECORD_NO_EXISTE constant number(1) := 1; -- Reg. no esta en BD
	cnuRECORD_YA_EXISTE constant number(1) := 2; -- Reg. ya esta en BD
	cbsTable      constant varchar2(30) := 'IC_DETLISIM'; -- Nombre tabla
	cnuGeEntityId constant varchar2(30) := 2811; -- Id de Ge_entity


	-------------------------
	-- PRIVATE METHODS
	-------------------------
	function fsbGetMessageDescription
	(
		inuMenscodi	IN number
	)
	return varchar2
	is
	      sbMessage varchar2(32000);
	      sbTableDescription varchar2(32000);
	BEGIN
	    if (cnuGeEntityId > 0 and dage_entity.fblExist (cnuGeEntityId))  then
	          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
	    end if;

		sbMessage := dage_message.fsbgetdescription(inuMenscodi);
	    if sbTableDescription is null then
	          sbMessage := replace(sbMessage,'%s1',cbsTable);
	    else
	          sbMessage := replace(sbMessage,'%s1','(' ||cbsTable||' - '||sbTableDescription ||')');
	    end if;
		return sbMessage ;
	END fsbGetMessageDescription;

	function fblInMemory
	(
		inuDelicons in Ic_Detlisim.Delicons%type
	)
	RETURN boolean is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fblInMemory');
		if(
			rcIc_Detlisim.Delicons = inuDelicons
		) then
			pkErrors.Pop;
			return(TRUE);
		end if;
		pkErrors.Pop;
		return( FALSE );
	END fblInMemory;

	procedure LoadRecord
	(
		inuDelicons in Ic_Detlisim.Delicons%type
	) is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.LoadRecord');
		if cuIc_Detlisim%isopen then
			close cuIc_Detlisim;
		end if;
		-- Accesa Ic_Detlisim de la BD;
		open cuIc_Detlisim
		(
			inuDelicons
		);

		fetch cuIc_Detlisim into rcIc_Detlisim;
		if ( cuIc_Detlisim%notfound ) then
			close cuIc_Detlisim;
			pkErrors.Pop;
			rcIc_Detlisim := rcRecordNull;
			return;
		end if;
		close cuIc_Detlisim;
		pkErrors.Pop;
	END LoadRecord;

	procedure Load
	(
		inuDelicons in Ic_Detlisim.Delicons%type
	) is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.Load');
		LoadRecord
		(
			inuDelicons
		);

		-- Evalua si se encontro el registro en la Base de datos;
		if ( rcIc_Detlisim.Delicons is null ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END Load;

    FUNCTION fsbVersion
    RETURN varchar2
	IS
	BEGIN
		return csbVersion;
	END fsbVersion;

	PROCEDURE AccKey
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.AccKey');
		-- Valida si debe buscar primero en memoria Cache
		if ( inuCACHE = CACHE ) then
            if ( fblInMemory
			(
                inuDelicons
			)) then
				pkErrors.Pop;
				return;
			end if;
		end if;

		Load
		(
                inuDelicons
		);
		pkErrors.Pop;
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.Pop;
			raise LOGIN_DENIED;
	END AccKey;

	procedure ClearMemory is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.ClearMemory');
		rcIc_Detlisim := rcRecordNull;
		pkErrors.Pop;
	END ClearMemory;

	PROCEDURE DelRecord
	(
		inuDelicons in Ic_Detlisim.Delicons%type
	)	 is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.DelRecord');
		-- Elimina registro de la Tabla Ic_Detlisim
		DELETE Ic_Detlisim
		WHERE
       		Delicons=inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END DelRecord;

	PROCEDURE DelRecords
	(
		inuDelicons in out nocopy tyDelicons
	) is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.DelRecords');
		-- Elimina registro de la Tabla Ic_Detlisim
		FORALL indx in inuDelicons.first .. inuDelicons.last
		DELETE Ic_Detlisim
		WHERE
            Delicons = inuDelicons(indx);
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END DelRecords;

	PROCEDURE InsForEachColumn
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelinuse in Ic_Detlisim.Delinuse%type,
		idtDelifeco in Ic_Detlisim.Delifeco%type,
		inuDelidimo in Ic_Detlisim.Delidimo%type,
		inuDelipudm in Ic_Detlisim.Delipudm%type,
		inuDelimxam in Ic_Detlisim.Delimxam%type,
		inuDelipmam in Ic_Detlisim.Delipmam%type,
		inuDelimxsm in Ic_Detlisim.Delimxsm%type,
		inuDelipmsm in Ic_Detlisim.Delipmsm%type,
		inuDeliprsm in Ic_Detlisim.Deliprsm%type,
		inuDelippsm in Ic_Detlisim.Delippsm%type,
		inuDeliprtm in Ic_Detlisim.Deliprtm%type,
		inuDelipptm in Ic_Detlisim.Delipptm%type,
		inuDelimoca in Ic_Detlisim.Delimoca%type,
		inuDelipmca in Ic_Detlisim.Delipmca%type,
		inuDelicuap in Ic_Detlisim.Delicuap%type,
		inuDelipcap in Ic_Detlisim.Delipcap%type,
		inuDelicumx in Ic_Detlisim.Delicumx%type,
		inuDelipcmx in Ic_Detlisim.Delipcmx%type,
		inuDelicuuf in Ic_Detlisim.Delicuuf%type,
		inuDelipcuf in Ic_Detlisim.Delipcuf%type,
		inuDeliinte in Ic_Detlisim.Deliinte%type,
		inuDelifact in Ic_Detlisim.Delifact%type,
		inuDelipecu in Ic_Detlisim.Delipecu%type,
		inuDeliprcu in Ic_Detlisim.Deliprcu%type,
		inuDeliprin in Ic_Detlisim.Deliprin%type,
		inuDelimoua in Ic_Detlisim.Delimoua%type,
		inuDelimous in Ic_Detlisim.Delimous%type,
		inuDelimoss in Ic_Detlisim.Delimoss%type,
		inuDelimout in Ic_Detlisim.Delimout%type,
		inudelipout in Ic_Detlisim.delipout%type
	) is
	   rcRecord Ic_Detlisim%rowtype;
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.InsForEachColumn');
		rcRecord.Delicons := inuDelicons;
		rcRecord.Delinuse := inuDelinuse;
		rcRecord.Delifeco := idtDelifeco;
		rcRecord.Delidimo := inuDelidimo;
		rcRecord.Delipudm := inuDelipudm;
		rcRecord.Delimxam := inuDelimxam;
		rcRecord.Delipmam := inuDelipmam;
		rcRecord.Delimxsm := inuDelimxsm;
		rcRecord.Delipmsm := inuDelipmsm;
		rcRecord.Deliprsm := inuDeliprsm;
		rcRecord.Delippsm := inuDelippsm;
		rcRecord.Deliprtm := inuDeliprtm;
		rcRecord.Delipptm := inuDelipptm;
		rcRecord.Delimoca := inuDelimoca;
		rcRecord.Delipmca := inuDelipmca;
		rcRecord.Delicuap := inuDelicuap;
		rcRecord.Delipcap := inuDelipcap;
		rcRecord.Delicumx := inuDelicumx;
		rcRecord.Delipcmx := inuDelipcmx;
		rcRecord.Delicuuf := inuDelicuuf;
		rcRecord.Delipcuf := inuDelipcuf;
		rcRecord.Deliinte := inuDeliinte;
		rcRecord.Delifact := inuDelifact;
		rcRecord.Delipecu := inuDelipecu;
		rcRecord.Deliprcu := inuDeliprcu;
		rcRecord.Deliprin := inuDeliprin;
		rcRecord.Delimoua := inuDelimoua;
		rcRecord.Delimous := inuDelimous;
		rcRecord.Delimoss := inuDelimoss;
		rcRecord.Delimout := inuDelimout;
		rcRecord.delipout := inudelipout;
		InsRecord( rcRecord );
		pkErrors.Pop;
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.Pop;
			raise LOGIN_DENIED;
	END InsForEachColumn;

	PROCEDURE InsForEachColumnBulk
	(
		inuDelicons in out nocopy tyDelicons,
		inuDelinuse in out nocopy tyDelinuse,
		idtDelifeco in out nocopy tyDelifeco,
		inuDelidimo in out nocopy tyDelidimo,
		inuDelipudm in out nocopy tyDelipudm,
		inuDelimxam in out nocopy tyDelimxam,
		inuDelipmam in out nocopy tyDelipmam,
		inuDelimxsm in out nocopy tyDelimxsm,
		inuDelipmsm in out nocopy tyDelipmsm,
		inuDeliprsm in out nocopy tyDeliprsm,
		inuDelippsm in out nocopy tyDelippsm,
		inuDeliprtm in out nocopy tyDeliprtm,
		inuDelipptm in out nocopy tyDelipptm,
		inuDelimoca in out nocopy tyDelimoca,
		inuDelipmca in out nocopy tyDelipmca,
		inuDelicuap in out nocopy tyDelicuap,
		inuDelipcap in out nocopy tyDelipcap,
		inuDelicumx in out nocopy tyDelicumx,
		inuDelipcmx in out nocopy tyDelipcmx,
		inuDelicuuf in out nocopy tyDelicuuf,
		inuDelipcuf in out nocopy tyDelipcuf,
		inuDeliinte in out nocopy tyDeliinte,
		inuDelifact in out nocopy tyDelifact,
		inuDelipecu in out nocopy tyDelipecu,
		inuDeliprcu in out nocopy tyDeliprcu,
		inuDeliprin in out nocopy tyDeliprin,
		inuDelimoua in out nocopy tyDelimoua,
		inuDelimous in out nocopy tyDelimous,
		inuDelimoss in out nocopy tyDelimoss,
		inuDelimout in out nocopy tyDelimout,
		inudelipout in out nocopy tydelipout
	) is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.InsForEachColumnBulk');
		FORALL indx in inuDelicons.first .. inuDelicons.last
		INSERT INTO Ic_Detlisim
		(
			Delicons,
			Delinuse,
			Delifeco,
			Delidimo,
			Delipudm,
			Delimxam,
			Delipmam,
			Delimxsm,
			Delipmsm,
			Deliprsm,
			Delippsm,
			Deliprtm,
			Delipptm,
			Delimoca,
			Delipmca,
			Delicuap,
			Delipcap,
			Delicumx,
			Delipcmx,
			Delicuuf,
			Delipcuf,
			Deliinte,
			Delifact,
			Delipecu,
			Deliprcu,
			Deliprin,
			Delimoua,
            Delimous,
            Delimoss,
            Delimout,
            delipout
		)
		VALUES
		(
			inuDelicons(indx),
			inuDelinuse(indx),
			idtDelifeco(indx),
			inuDelidimo(indx),
			inuDelipudm(indx),
			inuDelimxam(indx),
			inuDelipmam(indx),
			inuDelimxsm(indx),
			inuDelipmsm(indx),
			inuDeliprsm(indx),
			inuDelippsm(indx),
			inuDeliprtm(indx),
			inuDelipptm(indx),
			inuDelimoca(indx),
			inuDelipmca(indx),
			inuDelicuap(indx),
			inuDelipcap(indx),
			inuDelicumx(indx),
			inuDelipcmx(indx),
			inuDelicuuf(indx),
			inuDelipcuf(indx),
			inuDeliinte(indx),
			inuDelifact(indx),
			inuDelipecu(indx),
			inuDeliprcu(indx),
			inuDeliprin(indx),
			inuDelimoua(indx),
			inuDelimous(indx),
			inuDelimoss(indx),
			inuDelimout(indx),
			inudelipout(indx)
		);
		pkErrors.Pop;
	EXCEPTION
		when DUP_VAL_ON_INDEX then
			Errors.setbsserror(cnuRECORD_YA_EXISTE,fsbGetMessageDescription(cnuRECORD_YA_EXISTE));
			pkErrors.Pop;
			raise LOGIN_DENIED;
	END InsForEachColumnBulk;

	PROCEDURE insRecord
	(
		ircRecord in Ic_Detlisim%rowtype
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.InsRecord');
		INSERT INTO Ic_Detlisim
		(
			Delicons,
			Delinuse,
			Delifeco,
			Delidimo,
			Delipudm,
			Delimxam,
			Delipmam,
			Delimxsm,
			Delipmsm,
			Deliprsm,
			Delippsm,
			Deliprtm,
			Delipptm,
			Delimoca,
			Delipmca,
			Delicuap,
			Delipcap,
			Delicumx,
			Delipcmx,
			Delicuuf,
			Delipcuf,
			Deliinte,
			Delifact,
			Delipecu,
			Deliprcu,
			Deliprin,
			Delimoua,
            Delimous,
            Delimoss,
            Delimout,
            delipout
		)
		VALUES
		(
			ircRecord.Delicons,
			ircRecord.Delinuse,
			ircRecord.Delifeco,
			ircRecord.Delidimo,
			ircRecord.Delipudm,
			ircRecord.Delimxam,
			ircRecord.Delipmam,
			ircRecord.Delimxsm,
			ircRecord.Delipmsm,
			ircRecord.Deliprsm,
			ircRecord.Delippsm,
			ircRecord.Deliprtm,
			ircRecord.Delipptm,
			ircRecord.Delimoca,
			ircRecord.Delipmca,
			ircRecord.Delicuap,
			ircRecord.Delipcap,
			ircRecord.Delicumx,
			ircRecord.Delipcmx,
			ircRecord.Delicuuf,
			ircRecord.Delipcuf,
			ircRecord.Deliinte,
			ircRecord.Delifact,
			ircRecord.Delipecu,
			ircRecord.Deliprcu,
			ircRecord.Deliprin,
			ircRecord.Delimoua,
            ircRecord.Delimous,
            ircRecord.Delimoss,
            ircRecord.Delimout,
            ircRecord.delipout
		);
		pkErrors.Pop;
	EXCEPTION
		when DUP_VAL_ON_INDEX then
			Errors.setbsserror(cnuRECORD_YA_EXISTE,fsbGetMessageDescription(cnuRECORD_YA_EXISTE));
			pkErrors.Pop;
			raise LOGIN_DENIED;
	END InsRecord;

	PROCEDURE InsRecords
	(
		irctbRecord in out nocopy tytbIc_Detlisim
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.InsRecords');
		FORALL indx in irctbRecord.Delicons.first .. irctbRecord.Delicons.last
		INSERT INTO Ic_Detlisim
		(
			Delicons,
			Delinuse,
			Delifeco,
			Delidimo,
			Delipudm,
			Delimxam,
			Delipmam,
			Delimxsm,
			Delipmsm,
			Deliprsm,
			Delippsm,
			Deliprtm,
			Delipptm,
			Delimoca,
			Delipmca,
			Delicuap,
			Delipcap,
			Delicumx,
			Delipcmx,
			Delicuuf,
			Delipcuf,
			Deliinte,
			Delifact,
			Delipecu,
			Deliprcu,
			Deliprin,
			Delimoua,
            Delimous,
            Delimoss,
            Delimout,
            delipout
		)
		VALUES
		(
			irctbRecord.Delicons(indx),
			irctbRecord.Delinuse(indx),
			irctbRecord.Delifeco(indx),
			irctbRecord.Delidimo(indx),
			irctbRecord.Delipudm(indx),
			irctbRecord.Delimxam(indx),
			irctbRecord.Delipmam(indx),
			irctbRecord.Delimxsm(indx),
			irctbRecord.Delipmsm(indx),
			irctbRecord.Deliprsm(indx),
			irctbRecord.Delippsm(indx),
			irctbRecord.Deliprtm(indx),
			irctbRecord.Delipptm(indx),
			irctbRecord.Delimoca(indx),
			irctbRecord.Delipmca(indx),
			irctbRecord.Delicuap(indx),
			irctbRecord.Delipcap(indx),
			irctbRecord.Delicumx(indx),
			irctbRecord.Delipcmx(indx),
			irctbRecord.Delicuuf(indx),
			irctbRecord.Delipcuf(indx),
			irctbRecord.Deliinte(indx),
			irctbRecord.Delifact(indx),
			irctbRecord.Delipecu(indx),
			irctbRecord.Deliprcu(indx),
			irctbRecord.Deliprin(indx),
			irctbRecord.Delimoua(indx),
			irctbRecord.Delimous(indx),
			irctbRecord.Delimoss(indx),
			irctbRecord.Delimout(indx),
			irctbRecord.delipout(indx)
		);
		pkErrors.Pop;
	EXCEPTION
		when DUP_VAL_ON_INDEX then
			Errors.setbsserror(cnuRECORD_YA_EXISTE,fsbGetMessageDescription(cnuRECORD_YA_EXISTE));
			pkErrors.Pop;
			raise LOGIN_DENIED;
	END InsRecords;

	PROCEDURE UpRecord
	(
		ircRecord in Ic_Detlisim%rowtype
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpRecord');
		update Ic_Detlisim
		SET
				Delinuse = ircRecord.Delinuse,
				Delifeco = ircRecord.Delifeco,
				Delidimo = ircRecord.Delidimo,
				Delipudm = ircRecord.Delipudm,
				Delimxam = ircRecord.Delimxam,
				Delipmam = ircRecord.Delipmam,
				Delimxsm = ircRecord.Delimxsm,
				Delipmsm = ircRecord.Delipmsm,
				Deliprsm = ircRecord.Deliprsm,
				Delippsm = ircRecord.Delippsm,
				Deliprtm = ircRecord.Deliprtm,
				Delipptm = ircRecord.Delipptm,
				Delimoca = ircRecord.Delimoca,
				Delipmca = ircRecord.Delipmca,
				Delicuap = ircRecord.Delicuap,
				Delipcap = ircRecord.Delipcap,
				Delicumx = ircRecord.Delicumx,
				Delipcmx = ircRecord.Delipcmx,
				Delicuuf = ircRecord.Delicuuf,
				Delipcuf = ircRecord.Delipcuf,
				Deliinte = ircRecord.Deliinte,
				Delifact = ircRecord.Delifact,
				Delipecu = ircRecord.Delipecu,
				Deliprcu = ircRecord.Deliprcu,
				Deliprin = ircRecord.Deliprin,
				Delimoua = ircRecord.Delimoua,
				Delimous = ircRecord.Delimous,
				Delimoss = ircRecord.Delimoss,
				Delimout = ircRecord.Delimout,
				delipout = ircRecord.delipout
		WHERE	Delicons = ircRecord.Delicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpRecord;

	PROCEDURE ValidateDupValues
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.ValidateDupValues');
		-- Valida si el registro ya existe
		if ( fblExist( inuDelicons, inuCACHE ) ) then
			Errors.setbsserror(cnuRECORD_YA_EXISTE,fsbGetMessageDescription(cnuRECORD_YA_EXISTE));
			raise LOGIN_DENIED;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.Pop;
			raise LOGIN_DENIED;
	END ValidateDupValues;

	FUNCTION fblExist
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN boolean is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fblExist');
		-- Evalua si debe Buscar en memoria cache primero
		if ( inuCACHE = CACHE ) then
			if ( fblInMemory( inuDelicons) )
			then
				pkErrors.Pop;
				return( TRUE );
			end if;
		end if;
		LoadRecord( inuDelicons);
		if ( rcIc_Detlisim.Delicons is null ) then
			pkErrors.Pop;
			return( FALSE );
		end if;
		pkErrors.Pop;
		return( TRUE );
	END fblExist;

	FUNCTION frcGetRecord
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim%rowtype
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.frcGetRecord');
		AccKey ( inuDelicons, inuCACHE);
		pkErrors.Pop;
		return ( rcIc_Detlisim );
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END frcGetRecord;

	PROCEDURE UpdDelinuse
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelinuse$ in Ic_Detlisim.Delinuse%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelinuse');
		UPDATE Ic_Detlisim
		SET
			Delinuse = inuDelinuse$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelinuse;
	PROCEDURE UpdDelifeco
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		idtDelifeco$ in Ic_Detlisim.Delifeco%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelifeco');
		UPDATE Ic_Detlisim
		SET
			Delifeco = idtDelifeco$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelifeco;
	PROCEDURE UpdDelidimo
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelidimo$ in Ic_Detlisim.Delidimo%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelidimo');
		UPDATE Ic_Detlisim
		SET
			Delidimo = inuDelidimo$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelidimo;
	PROCEDURE UpdDelipudm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipudm$ in Ic_Detlisim.Delipudm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipudm');
		UPDATE Ic_Detlisim
		SET
			Delipudm = inuDelipudm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipudm;
	PROCEDURE UpdDelimxam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelimxam$ in Ic_Detlisim.Delimxam%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelimxam');
		UPDATE Ic_Detlisim
		SET
			Delimxam = inuDelimxam$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelimxam;
	PROCEDURE UpdDelipmam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipmam$ in Ic_Detlisim.Delipmam%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipmam');
		UPDATE Ic_Detlisim
		SET
			Delipmam = inuDelipmam$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipmam;
	PROCEDURE UpdDelimxsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelimxsm$ in Ic_Detlisim.Delimxsm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelimxsm');
		UPDATE Ic_Detlisim
		SET
			Delimxsm = inuDelimxsm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelimxsm;
	PROCEDURE UpdDelipmsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipmsm$ in Ic_Detlisim.Delipmsm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipmsm');
		UPDATE Ic_Detlisim
		SET
			Delipmsm = inuDelipmsm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipmsm;
	PROCEDURE UpdDeliprsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprsm$ in Ic_Detlisim.Deliprsm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDeliprsm');
		UPDATE Ic_Detlisim
		SET
			Deliprsm = inuDeliprsm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDeliprsm;
	PROCEDURE UpdDelippsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelippsm$ in Ic_Detlisim.Delippsm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelippsm');
		UPDATE Ic_Detlisim
		SET
			Delippsm = inuDelippsm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelippsm;
	PROCEDURE UpdDeliprtm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprtm$ in Ic_Detlisim.Deliprtm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDeliprtm');
		UPDATE Ic_Detlisim
		SET
			Deliprtm = inuDeliprtm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDeliprtm;
	PROCEDURE UpdDelipptm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipptm$ in Ic_Detlisim.Delipptm%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipptm');
		UPDATE Ic_Detlisim
		SET
			Delipptm = inuDelipptm$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipptm;
	PROCEDURE UpdDelimoca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelimoca$ in Ic_Detlisim.Delimoca%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelimoca');
		UPDATE Ic_Detlisim
		SET
			Delimoca = inuDelimoca$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelimoca;
	PROCEDURE UpdDelipmca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipmca$ in Ic_Detlisim.Delipmca%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipmca');
		UPDATE Ic_Detlisim
		SET
			Delipmca = inuDelipmca$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipmca;
	PROCEDURE UpdDelicuap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelicuap$ in Ic_Detlisim.Delicuap%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelicuap');
		UPDATE Ic_Detlisim
		SET
			Delicuap = inuDelicuap$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelicuap;
	PROCEDURE UpdDelipcap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipcap$ in Ic_Detlisim.Delipcap%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipcap');
		UPDATE Ic_Detlisim
		SET
			Delipcap = inuDelipcap$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipcap;
	PROCEDURE UpdDelicumx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelicumx$ in Ic_Detlisim.Delicumx%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelicumx');
		UPDATE Ic_Detlisim
		SET
			Delicumx = inuDelicumx$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelicumx;
	PROCEDURE UpdDelipcmx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipcmx$ in Ic_Detlisim.Delipcmx%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipcmx');
		UPDATE Ic_Detlisim
		SET
			Delipcmx = inuDelipcmx$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipcmx;
	PROCEDURE UpdDelicuuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelicuuf$ in Ic_Detlisim.Delicuuf%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelicuuf');
		UPDATE Ic_Detlisim
		SET
			Delicuuf = inuDelicuuf$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelicuuf;
	PROCEDURE UpdDelipcuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipcuf$ in Ic_Detlisim.Delipcuf%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipcuf');
		UPDATE Ic_Detlisim
		SET
			Delipcuf = inuDelipcuf$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipcuf;
	PROCEDURE UpdDeliinte
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliinte$ in Ic_Detlisim.Deliinte%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDeliinte');
		UPDATE Ic_Detlisim
		SET
			Deliinte = inuDeliinte$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDeliinte;
	PROCEDURE UpdDelifact
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelifact$ in Ic_Detlisim.Delifact%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelifact');
		UPDATE Ic_Detlisim
		SET
			Delifact = inuDelifact$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelifact;
	PROCEDURE UpdDelipecu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDelipecu$ in Ic_Detlisim.Delipecu%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDelipecu');
		UPDATE Ic_Detlisim
		SET
			Delipecu = inuDelipecu$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDelipecu;
	PROCEDURE UpdDeliprcu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprcu$ in Ic_Detlisim.Deliprcu%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDeliprcu');
		UPDATE Ic_Detlisim
		SET
			Deliprcu = inuDeliprcu$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDeliprcu;
	PROCEDURE UpdDeliprin
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuDeliprin$ in Ic_Detlisim.Deliprin%type
	)
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.UpdDeliprin');
		UPDATE Ic_Detlisim
		SET
			Deliprin = inuDeliprin$
		WHERE  Delicons = inuDelicons;
		if ( sql%notfound ) then
			pkErrors.Pop;
			raise NO_DATA_FOUND;
		end if;
		pkErrors.Pop;
	EXCEPTION
		when NO_DATA_FOUND then
			Errors.setbsserror(cnuRECORD_NO_EXISTE,fsbGetMessageDescription(cnuRECORD_NO_EXISTE));
			raise LOGIN_DENIED;
	END UpdDeliprin;
	function fnuGetDelicons
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicons%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelicons');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delicons);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelicons;
	function fnuGetDelinuse
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delinuse%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelinuse');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delinuse);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelinuse;
	function fdtGetDelifeco
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delifeco%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fdtGetDelifeco');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delifeco);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fdtGetDelifeco;
	function fnuGetDelidimo
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delidimo%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelidimo');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delidimo);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelidimo;
	function fnuGetDelipudm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipudm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipudm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipudm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipudm;
	function fnuGetDelimxam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delimxam%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelimxam');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delimxam);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelimxam;
	function fnuGetDelipmam
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipmam%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipmam');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipmam);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipmam;
	function fnuGetDelimxsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delimxsm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelimxsm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delimxsm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelimxsm;
	function fnuGetDelipmsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipmsm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipmsm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipmsm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipmsm;
	function fnuGetDeliprsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprsm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDeliprsm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Deliprsm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDeliprsm;
	function fnuGetDelippsm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delippsm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelippsm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delippsm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelippsm;
	function fnuGetDeliprtm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprtm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDeliprtm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Deliprtm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDeliprtm;
	function fnuGetDelipptm
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipptm%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipptm');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipptm);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipptm;
	function fnuGetDelimoca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delimoca%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelimoca');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delimoca);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelimoca;
	function fnuGetDelipmca
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipmca%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipmca');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipmca);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipmca;
	function fnuGetDelicuap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicuap%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelicuap');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delicuap);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelicuap;
	function fnuGetDelipcap
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipcap%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipcap');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipcap);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipcap;
	function fnuGetDelicumx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicumx%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelicumx');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delicumx);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelicumx;
	function fnuGetDelipcmx
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipcmx%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipcmx');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipcmx);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipcmx;
	function fnuGetDelicuuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delicuuf%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelicuuf');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delicuuf);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelicuuf;
	function fnuGetDelipcuf
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipcuf%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipcuf');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipcuf);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipcuf;
	function fnuGetDeliinte
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliinte%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDeliinte');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Deliinte);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDeliinte;
	function fnuGetDelifact
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delifact%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelifact');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delifact);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelifact;
	function fnuGetDelipecu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Delipecu%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDelipecu');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Delipecu);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDelipecu;
	function fnuGetDeliprcu
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprcu%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDeliprcu');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Deliprcu);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDeliprcu;
	function fnuGetDeliprin
	(
		inuDelicons in Ic_Detlisim.Delicons%type,
		inuCACHE in number default 1
	)
	RETURN Ic_Detlisim.Deliprin%type
	is
	BEGIN
		pkErrors.Push('pktblIc_Detlisim.fnuGetDeliprin');
		AccKey ( inuDelicons, inuCACHE );
		pkErrors.Pop;
		return ( rcIc_Detlisim.Deliprin);
	EXCEPTION
		when LOGIN_DENIED then
			pkErrors.pop;
			raise LOGIN_DENIED;
	END fnuGetDeliprin;



end pktblIc_Detlisim;
/
GRANT EXECUTE on PKTBLIC_DETLISIM to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on PKTBLIC_DETLISIM to REXEOPEN;
GRANT EXECUTE on PKTBLIC_DETLISIM to RSELSYS;
/
