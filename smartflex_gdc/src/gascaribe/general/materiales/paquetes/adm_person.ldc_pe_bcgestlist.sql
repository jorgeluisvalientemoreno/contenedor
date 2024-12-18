CREATE OR REPLACE PACKAGE adm_person.LDC_PE_BCGESTLIST
IS
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 26-07-2021
	Ticket: 709
	Descripcion: 	Paquete que contiene los metodos y funciones para acceso a datos de la solucion para
					gestion de actualizacion de costo y precio de las listas por tipo de incremento

	Historia de modificaciones
	Fecha		Autor			Descripcion
	26-07-2021	horbath			Creacion de paquete BC

	******************************************************************************************/
    -----------------------------
    -- Constantes publicas
    -----------------------------
    -----------------------------
    -- Cursores Publicos
    -----------------------------
    --Obtiene las unidades operativas del contratista por contrato
    CURSOR cuOuByCont
    (
        inuIdCont   IN  ge_contrato.id_contrato%TYPE
    )
    IS
        SELECT a.rowid, a.operating_unit_id
        FROM or_operating_unit a, ge_contrato b /*+ ldc_pe_bcgestlist.cuOuByCont*/
        WHERE a.contractor_id = b.id_contratista
        AND b.id_contrato = inuIdCont;

    --Obtiene las unidades operativas del contrato
    CURSOR cuOuByContTi
    (
        inuIdCont   IN  ge_contrato.id_contrato%TYPE
    )
    IS
        SELECT a.operating_unit_id
        FROM ldc_uo_bytipoinc a /*+ ldc_pe_bcgestlist.cuOuByContTi*/
        WHERE a.id_contrato = inuIdCont;

    --Tipos de incremento por contrato de una unidad operativa diferentes de un contrato ingresado
    CURSOR cuTincByOu
    (
        inuIdCont   IN  ge_contrato.id_contrato%TYPE,
        inuOperUnit IN  or_operating_unit.operating_unit_id%TYPE
    )
    IS
        SELECT a.id_contrato, a.increment_type
        FROM ldc_tipoinc_bycon a, ldc_uo_bytipoinc b
        WHERE a.id_contrato = b.id_contrato
        AND b.operating_unit_id = inuOperUnit
        AND b.id_contrato <> inuIdCont;

    --Retorna la cantidad de contratos con diferente tipo de incremento de una unidad compartida
    CURSOR cuCountDifTin
    (
        inuIdCont   IN  ge_contrato.id_contrato%TYPE,
        inuOperUnit IN  or_operating_unit.operating_unit_id%TYPE,
        isbTipoInc  IN  ldc_tipoinc_bycon.increment_type%TYPE
    )
    IS
        SELECT COUNT(*)
        FROM ldc_tipoinc_bycon a, ldc_uo_bytipoinc b
        WHERE a.id_contrato = b.id_contrato
        AND b.operating_unit_id = inuOperUnit
        AND b.id_contrato <> inuIdCont
        AND a.increment_type <> isbTipoInc;

    -----------------------------
    -- Tipos y Variables Publicas
    -----------------------------
    TYPE ttyrcOuByCont  IS TABLE OF cuOuByCont%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE ttyrcOuByConTi IS TABLE OF cuOuByContTi%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE ttyrcTincbyOu  IS TABLE OF cuTincByOu%ROWTYPE INDEX BY BINARY_INTEGER;
    -----------------------------
    -- Metodos
    -----------------------------
    --Retorna la ultima version del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR;

    --Obtiene una coleccion de las unidades operativas del contratista de un contrato
    PROCEDURE pGetOuByCont
    (
        inuIdContrato   IN  ge_contrato.id_contrato%TYPE,
        otbOuByCont     OUT NOCOPY ldc_pe_bcgestlist.ttyrcOuByCont
    );

    --Obtiene una coleccion de las unidades operativas del contrato
    PROCEDURE pGetOuByConTi
    (
        inuIdContrato   IN  ge_contrato.id_contrato%TYPE,
        otbOuByConTi    OUT NOCOPY ldc_pe_bcgestlist.ttyrcOuByConTi
    );

    --Obtiene una coleccion de tipos de incremento por contrato de una unidad operativa compartida
    PROCEDURE pGetTIncByOu
    (
        inuIdContrato       IN  ge_contrato.id_contrato%TYPE,
        inuOperatingUnit    IN  or_operating_unit.operating_unit_id%TYPE,
        otbTincByUo         OUT NOCOPY ttyrcTincbyOu
    );

END LDC_PE_BCGESTLIST;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PE_BCGESTLIST
IS
    -----------------------------
    -- Constantes Privadas
    -----------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete
    csbVersion  CONSTANT VARCHAR2(100) := 'OSF-2884';

    -- Para el control de traza:
    csbSP_NAME  CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbPUSH     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbPOP      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbPOP_ERC  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbPOP_ERR  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbLDC      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BC.
    cnuLEVELPUSHPOP             CONSTANT NUMBER := 1;
    cnuLEVEL                    CONSTANT NUMBER := 7;

    -----------------------------
    -- Tipos y Variables Privadas
    -----------------------------
    -----------------------------
    -- Cursores Privados
    -----------------------------
    -----------------------------
    -- Metodos
    -----------------------------
    --Retorna la ultima version del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad> pGetOuByCont </Unidad>
        <Autor> horbath </Autor>
        <Fecha> 27-07-2021 </Fecha>
        <Descripcion>
            Retorna una coleccion con las unidades operativas del contratista
            asociado al contrato ingresado.
        </Descripcion>
        <Parametros>
            <param nombre="inuIdContrato" tipo="ge_contrato.id_contrato%TYPE" Direccion="IN" default="NO APLICA">
				Numero de contrato
			</param>
            <param nombre="otbOuByCont" tipo="NOCOPY ttyrcOuByCont" Direccion="OUT" default="NO APLICA">
				Coleccion de unidades operativas
			</param>
        </Parametros>
        <Historial>
            <Modificacion Autor="horbath" Fecha="27-07-2021" Inc="CA709" Empresa="GDC">
                Creacion
            </Modificacion>
        </Historial>
    **************************************************************************/
    PROCEDURE pGetOuByCont
    (
        inuIdContrato   IN  ge_contrato.id_contrato%TYPE,
        otbOuByCont     OUT NOCOPY ldc_pe_bcgestlist.ttyrcOuByCont
    )
    IS
        sbMethodName    VARCHAR2(50) := 'pGetOuByCont';
        tbData_Empty    ldc_pe_bcgestlist.ttyrcOuByCont;
    BEGIN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

            --otbOuByCont := tbData_Empty;

            IF (cuOuByCont%ISOPEN) THEN
                CLOSE cuOuByCont;
            END IF;

            OPEN cuOuByCont(inuIdContrato);
            FETCH cuOuByCont BULK COLLECT INTO otbOuByCont;
            CLOSE cuOuByCont;

        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERC||sbMethodName,cnuLEVEL);
            Errors.pop;
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.setError;
            ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERR||sbMethodName,cnuLEVEL);
            Errors.pop;
            RAISE ex.CONTROLLED_ERROR;
    END pGetOuByCont; /*</Procedure>*/

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad> pGetOuByConTi </Unidad>
        <Autor> horbath </Autor>
        <Fecha> 27-07-2021 </Fecha>
        <Descripcion>
            Retorna una coleccion con las unidades operativas asociadas al contrato
            por tipo de contrato.
        </Descripcion>
        <Parametros>
            <param nombre="inuIdContrato" tipo="ge_contrato.id_contrato%TYPE" Direccion="IN" default="NO APLICA">
				Numero de contrato
			</param>
            <param nombre="otbOuByConti" tipo="NOCOPY ttyrcOuByConti" Direccion="OUT" default="NO APLICA">
				Coleccion de unidades operativas
			</param>
        </Parametros>
        <Historial>
            <Modificacion Autor="horbath" Fecha="27-07-2021" Inc="CA709" Empresa="GDC">
                Creacion
            </Modificacion>
        </Historial>
    **************************************************************************/
    PROCEDURE pGetOuByConTi
    (
        inuIdContrato   IN  ge_contrato.id_contrato%TYPE,
        otbOuByConTi     OUT NOCOPY ldc_pe_bcgestlist.ttyrcOuByConTi
    )
    IS
        sbMethodName    VARCHAR2(50) := 'pGetOuByConTi';
        tbData_Empty    ldc_pe_bcgestlist.ttyrcOuByConTi;
    BEGIN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

            otbOuByConTi := tbData_Empty;

            IF (cuOuByContTi%ISOPEN) THEN
                CLOSE cuOuByContTi;
            END IF;

            OPEN cuOuByContTi(inuIdContrato);
            FETCH cuOuByContTi BULK COLLECT INTO otbOuByConTi;
            CLOSE cuOuByContTi;

        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERC||sbMethodName,cnuLEVEL);
            Errors.pop;
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.setError;
            ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERR||sbMethodName,cnuLEVEL);
            Errors.pop;
            RAISE ex.CONTROLLED_ERROR;
    END pGetOuByConTi; /*</Procedure>*/

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad> pGetTIncByOu </Unidad>
        <Autor> horbath </Autor>
        <Fecha> 27-07-2021 </Fecha>
        <Descripcion>
            Retorna una coleccion de los tipos de incremento y contratos a los que
            pertenece la unidad operativa ingresada
        </Descripcion>
        <Parametros>
            <param nombre="inuIdContrato" tipo="NUMBER" Direccion="IN" default="NO APLICA">
				Numero de contrato
			</param>
            <param nombre="inuOperatingUnit" tipo="or_operating_unit.operating_unit_id%TYPE" Direccion="IN" default="NO APLICA">
				Numero de unidad operativa
			</param>
            <param nombre="otbTincByUo" tipo="NOCOPY ttyrcTincbyOu" Direccion="OUT" default="NO APLICA">
				Coleccion contratos y tipos de incremento
			</param>
        </Parametros>
        <Historial>
            <Modificacion Autor="horbath" Fecha="27-07-2021" Inc="CA709" Empresa="GDC">
                Creacion
            </Modificacion>
        </Historial>
    **************************************************************************/
    PROCEDURE pGetTIncByOu
    (
        inuIdContrato       IN  ge_contrato.id_contrato%TYPE,
        inuOperatingUnit    IN  or_operating_unit.operating_unit_id%TYPE,
        otbTincByUo         OUT NOCOPY ttyrcTincbyOu
    )
    IS
        sbMethodName    VARCHAR2(50) := 'pGetTIncByOu';
        tbData_Empty    ttyrcTincbyOu;
    BEGIN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

            otbTincByUo := tbData_Empty;

            IF (cuTincByOu%ISOPEN) THEN
                CLOSE cuTincByOu;
            END IF;

            OPEN cuTincByOu(inuIdContrato,inuOperatingUnit);
            FETCH cuTincByOu BULK COLLECT INTO otbTincByUo;
            CLOSE cuTincByOu;

        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERC||sbMethodName,cnuLEVEL);
            Errors.pop;
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.setError;
            ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERR||sbMethodName,cnuLEVEL);
            Errors.pop;
            RAISE ex.CONTROLLED_ERROR;
    END pGetTIncByOu; /*</Procedure>*/


END LDC_PE_BCGESTLIST;
/
Prompt Otorgando permisos sobre ADM_PERSON.LDC_PE_BCGESTLIST
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_PE_BCGESTLIST'), 'ADM_PERSON');
END;
/