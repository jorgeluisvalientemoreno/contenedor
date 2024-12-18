CREATE OR REPLACE PACKAGE adm_person.ldc_pe_bogestlist
IS
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 26-07-2021
	Ticket: 709
	Descripcion: 	Paquete que contiene los metodos y funciones para la logica de negocio de la
					gestion de actualizacion de costo y precio de las listas por tipo de incremento

	Historia de modificaciones
	Fecha		Autor			Descripcion
	26-07-2021	horbath			Creacion de paquete BO
    26/06/2024  Adrianavg       OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON   
	******************************************************************************************/
    -----------------------------
    -- Constantes publicas
    -----------------------------
    -----------------------------
    -- Tipos y Variables Publicas
    -----------------------------
    -----------------------------
    -- Cursores Publicos
    -----------------------------
    -----------------------------
    -- Metodos
    -----------------------------
    --Retorna la ultima version del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR;

    --Retorna falso o verdadero para validar tipo de incremento en contratos donde se comparte la unidad
    FUNCTION fblValTipoInc
    (
        inuIdContrato       IN  NUMBER,
        inuOperatingUnit    IN  or_operating_unit.operating_unit_id%TYPE,
        isbTipoInc          IN  VARCHAR2
    )
    RETURN BOOLEAN;

    --Retorna un indicador de la existencia de configuracion de tipo de incremento por contrato
    FUNCTION fnuExistConfig
    (
        inuIdContrato       IN  NUMBER
    )
    RETURN NUMBER;

END LDC_PE_BOGESTLIST;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PE_BOGESTLIST
IS
    -----------------------------
    -- Constantes Privadas
    -----------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete
    csbVersion  CONSTANT VARCHAR2(100) := 'CA709';

    -- Para el control de traza:
    csbSP_NAME  CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbPUSH     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbPOP      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbPOP_ERC  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbPOP_ERR  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbLDC      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BO.
    cnuLEVELPUSHPOP             CONSTANT NUMBER  ( 2) := 1;
    cnuLEVEL                    CONSTANT NUMBER  ( 2) := 9;

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
        <Unidad> fblValTipoInc </Unidad>
        <Autor> horbath </Autor>
        <Fecha> 27-07-2021 </Fecha>
        <Descripcion>
            Retorna falso o verdadero para validar tipo de incremento en contratos donde se comparte la unidad
        </Descripcion>
        <Retorno Nombre="blReturn" Tipo="BOOLEAN">
            -Indica FALSE si existe mas de 1 contrato con tipo de incremento diferente al ingresado.
            -Indica TRUE si no existe ningun contrato con tipo de incremento diferente al ingresado.
        </Retorno>
        <Parametros>
            <param nombre="inuIdContrato" tipo="NUMBER" Direccion="IN" default="NA">
                Numero de contrato
            </param>
            <param nombre="inuOperatingUnit" tipo="or_operating_unit.operating_unit_id%TYPE" Direccion="IN" default="NA">
                Numero de unidad operativa
            </param>
            <param nombre="isbTipoInc" tipo="VARCHAR2" Direccion="IN" default="NA">
                Sigla del tipo de incremento I-IPC, S-SMMLV, N-NO APLICA u O-OTROS
            </param>
        </Parametros>
        <Historial>
            <Modificacion Autor="horbath" Fecha="27-07-2021" Inc="709" Empresa="GDC">
               Creacion
            </Modificacion>
        </Historial>
    **************************************************************************/
    FUNCTION fblValTipoInc
    (
        inuIdContrato       IN  NUMBER,
        inuOperatingUnit    IN  or_operating_unit.operating_unit_id%TYPE,
        isbTipoInc          IN  VARCHAR2
    )
    RETURN BOOLEAN
    IS
        sbMethodName        VARCHAR2(50) := 'fblValTipoInc';
        blReturn            BOOLEAN;
        nuCountDiff         NUMBER;
    BEGIN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

            blReturn := TRUE;
            nuCountDiff := 0;

            ut_trace.trace('Contrato Ppal: '||inuIdContrato,cnuLEVEL);
            ut_trace.trace('inuOperatingUnit: '||inuOperatingUnit,cnuLEVEL);
            ut_trace.trace('Tipo Incremento Ppal: '||isbTipoInc,cnuLEVEL);

            --Obtiene la cantidad de contratos con tipos de incremento diferentes donde se comparte la unidad operativa
            IF (ldc_pe_bcgestlist.cuCountDifTin%ISOPEN) THEN
                CLOSE ldc_pe_bcgestlist.cuCountDifTin;
            END IF;

            OPEN ldc_pe_bcgestlist.cuCountDifTin(inuIdContrato,inuOperatingUnit,isbTipoInc);
            FETCH ldc_pe_bcgestlist.cuCountDifTin INTO nuCountDiff;
            CLOSE ldc_pe_bcgestlist.cuCountDifTin;

            IF (nuCountDiff > 0) THEN
                blReturn := FALSE;
            END IF;
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);

            RETURN blReturn;
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
    END fblValTipoInc;/*</Function>*/

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad> fnuExistConfig </Unidad>
        <Autor> horbath </Autor>
        <Fecha> 27-07-2021 </Fecha>
        <Descripcion>
            Retorna un indicador numerico si existe configuracion para el contrato en
            LDC_TIPOINC_BYCON. 1 si existe o 0 si no existe.
        </Descripcion>
        <Retorno Nombre="nuReturn" Tipo="NUMBER">
            -Retorna 1 si existe configuracion para el contrato en LDC_TIPOINC_BYCON.
            -Retorna 0 si no existe configuracion para el contrato en LDC_TIPOINC_BYCON.
        </Retorno>
        <Parametros>
            <param nombre="inuIdContrato" tipo="NUMBER" Direccion="IN" default="NA">
                Numero de contrato
            </param>
        </Parametros>
        <Historial>
            <Modificacion Autor="horbath" Fecha="27-07-2021" Inc="709" Empresa="GDC">
               Creacion
            </Modificacion>
        </Historial>
    **************************************************************************/
    FUNCTION fnuExistConfig
    (
        inuIdContrato       IN  NUMBER
    )
    RETURN NUMBER
    IS
        sbMethodName    VARCHAR2(50) := 'fnuExistConfig';
        nuReturn        NUMBER;
        tbData          daldc_tipoinc_bycon.tytbldc_tipoinc_bycon;
        tbData_Empty    daldc_tipoinc_bycon.tytbldc_tipoinc_bycon;
    BEGIN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

            nuReturn := 0;
            tbData := tbData_Empty;

            daldc_tipoinc_bycon.getRecords(' WHERE ID_CONTRATO = '||inuIdContrato,tbData);

            IF (tbData.COUNT > 0) THEN
                nuReturn := 1;
            END IF;

            RETURN nuReturn;
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
    END fnuExistConfig; /*</Function>*/

END LDC_PE_BOGESTLIST;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PE_BOGESTLIST
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PE_BOGESTLIST', 'ADM_PERSON'); 
END;
/