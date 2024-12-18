CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCCOMPONENTES IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		pkg_bcordenes
		Autor       :   Jhon Eduar Erazo
		Fecha       :   29-02-2024
		Descripcion :   Paquete con los metodos para manejo de información sobre los componentes
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	29/02/2022	OSF-2374	Creación
	*******************************************************************************/
	
	--CURSORES
	CURSOR cuRecord( inuComponenteId IN pr_component.component_id%TYPE) IS
	SELECT PR.*,PR.rowid
	FROM pr_component PR
	WHERE PR.component_id = inuComponenteId;

    --TIPOS/SUBTIPOS
   SUBTYPE sbtComponente 	IS CURECORD%ROWTYPE;
   TYPE tytbsbtComponente 	IS TABLE OF sbtComponente INDEX BY BINARY_INTEGER;
   TYPE tytbcomponent_id 	IS TABLE OF pr_component.component_id%TYPE INDEX BY BINARY_INTEGER;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
									
END PKG_BCCOMPONENTES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCCOMPONENTES IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2374';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 29-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-02-2024" Inc="OSF-2374" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

END PKG_BCCOMPONENTES;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCCOMPONENTES
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCCOMPONENTES', 'ADM_PERSON');
END;
/