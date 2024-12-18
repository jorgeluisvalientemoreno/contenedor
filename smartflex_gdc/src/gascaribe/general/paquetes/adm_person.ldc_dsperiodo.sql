CREATE OR REPLACE PACKAGE adm_person.ldc_dsperiodo
IS
  /*****************************************************************
    Propiedad intelectual de Gases del Caribe (c).

    Unidad         : LDC_DSPeriodo
    Descripcion    : Paquete data services
    Autor          : Ricardo Calixto
    Fecha          : 22/08/208

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    26/06/2024        Adrianavg         OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/
	PROCEDURE prGetPerCons (
		inuCiclo	in number,
		inuAno		in number,
		inuMes		in number,
		odtfecini   out date,
		odtfecfin   out date
    );
END LDC_DSPeriodo;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_DSPeriodo
IS
  /*****************************************************************
    Propiedad intelectual de Gases del Caribe (c).

    Unidad         : LDC_DSPeriodo
    Descripcion    : Paquete data services
    Autor          : Ricardo Calixto
    Fecha          : 22/08/208

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
	CURSOR cuPeriodo (	inuCiclo	in number,
						inuAno		in number,
						inuMes		in number) IS
	SELECT pc.pecsfeci, pc.pecsfecf
	FROM   open.perifact pf, open.pericose pc
	WHERE  pf.pefacicl = pc.pecscico
	AND    pc.pecsfecf between pf.pefafimo AND pf.pefaffmo
	AND    pf.pefacicl = inuCiclo
	AND    pf.pefaano = inuAno
	AND    pefames = inuMes;

    -- Define subtipos y tipos
	subtype styPeriodo is cuPeriodo%rowtype;
	type tytbPeriodo is table of styPeriodo index by varchar2(100);

	-- Define tablas
	tbPeriodo tytbPeriodo;

	-- Constantes
    csbVersion   CONSTANT varchar2(10) := '1.0';

    FUNCTION fsbVersion  RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END;

	FUNCTION fsbGetHash
    (
		inuCiclo	in number,
		inuAno		in number,
		inuMes		in number
    )
	return varchar2
    IS
		-- Variables
		nuCiclo		number;
		sbIndex		varchar(100);

    BEGIN
	--{
		-- Fija variables por defecto
		nuCiclo 	:= inuCiclo;

		-- Si el ciclo es menor a 0
		IF (nuCiclo = -1) THEN
		--{
			-- Se fija en 99999
			nuCiclo := 99999;
		--}
		END IF;

		-- Calcula el index
		sbIndex :=  lpad(to_char(nuCiclo),4,'0') ||
					lpad(to_char(inuAno),4,'0') ||
					lpad(to_char(inuMes),4,'0');

		return sbIndex;
	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END fsbGetHash;

    PROCEDURE loadData
    (
		inuCiclo	in number,
		inuAno		in number,
		inuMes		in number,
		isbIndex	in varchar2
    )
    IS
		-- Variable
		rctbPeriodo	styPeriodo;
    BEGIN
	--{
		--	Abre CURSOR
		OPEN cuPeriodo(inuCiclo, inuAno, inuMes);

		--	Recupera registros
		FETCH cuPeriodo INTO rctbPeriodo;

		--	Cierra cursor
		CLOSE cuPeriodo;

		-- Guarda cache
		tbPeriodo(isbIndex) := rctbPeriodo;

	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END loadData;

	PROCEDURE prGetPerCons (
		inuCiclo	in number,
		inuAno		in number,
		inuMes		in number,
		odtFecini 	out date,
		odtFecfin 	out date
	)
    IS
		-- Variables
		sbIndex			varchar(100);
    BEGIN
	--{
		-- Calcula hash
		sbIndex := fsbGetHash(inuCiclo, inuAno, inuMes);

		-- Valida si ya existe en cache
		IF (NOT tbPeriodo.exists(sbIndex)) THEN
		--{
			-- Carga datos
			loadData(inuCiclo, inuAno, inuMes, sbIndex);
		--}
		END IF;

		-- Obtiene las fechas
		odtFecini := tbPeriodo(sbIndex).pecsfeci;
		odtFecfin := tbPeriodo(sbIndex).pecsfecf;

	EXCEPTION
		WHEN others THEN
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	--}
    END prGetPerCons;

END LDC_DSPERIODO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_DSPERIODO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DSPERIODO', 'ADM_PERSON'); 
END;
/

