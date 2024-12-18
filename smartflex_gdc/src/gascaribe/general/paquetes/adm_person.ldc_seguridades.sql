create or replace PACKAGE adm_person.LDC_Seguridades
IS
    /*****************************************************************
    Propiedad intelectual de Gases de Occidente. (c).

    Package	: LDC_Seguridades
    Descripción	: Paquete para manejo de temas de seguridad

    Autor	: Carlos Andrés Dominguez N
    Fecha	: 29-MAY-2013

    Historia de Modificaciones

    29-MAY-2013    <carlos.dominguez>.SAONNNNN        Creación
    12-ABR-2024    <lubin.pineda>.OSF-2379            Uso de pkg_gestionArchivos e
                                                      implementación de últimos
                                                      estandares de programación
    15-ABR-2024    <lubin.pineda>.OSF-2379            Ajustes validación Técnica
    26/06/2024     PAcosta                            OSF-2878: Cambio de esquema ADM_PERSON
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --c<mnemonicoTipoDato>NOMBRECONSTANTE1            TIPODATO := VALOR;
    --------------------------------------------
    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --<mnemonicoTipoDato>NOMBREVARIABLEN             TIPODATO;

    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------
    PROCEDURE ProcessRoleExecutable;

    FUNCTION FSBVERSION RETURN VARCHAR2;

END LDC_Seguridades;
/
create or replace PACKAGE BODY adm_person.LDC_Seguridades
IS
    /*****************************************************************
    Propiedad intelectual de Gases de Occidente. (c).

    Package	: LDC_Seguridades
    Descripción	: Paquete para manejo de temas de seguridad

    Autor	: Carlos Andrés Dominguez N
    Fecha	: 29-MAY-2013

    Historia de Modificaciones

    29-MAY-2013    <carlos.dominguez>.SAONNNNN        Creación
    -----------  -------------------    -------------------------------------

    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION                  CONSTANT VARCHAR2(100) := 'OSF-2379';

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------

    nuErrorCode        NUMBER;
    sbErrorMessage     VARCHAR2(4000);
    errormesg          VARCHAR2(4000);

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT || '.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    /*****************************************************************
    Propiedad intelectual de Gases de Occidente. (c).

    Package	: ProcessRoleExecutable
    Descripción	: Ejecuta la asignación de ejecutables a un rol

    Autor	: Carlos Andrés Dominguez N
    Fecha	: 29-MAY-2013

    Historia de Modificaciones

    29-MAY-2013    <carlos.dominguez>.SAONNNNN        Creación
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    PROCEDURE ProcessRoleExecutable
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ProcessRoleExecutable';

        sbIDPATH        ge_boInstanceControl.stysbValue;
        sbARCHIVO       ge_boInstanceControl.stysbValue;
        sbSEPARADOR     ge_boInstanceControl.stysbValue;

        vFile           pkg_gestionArchivos.styArchivo;
        eFile           pkg_gestionArchivos.styArchivo;
        sbLine          varchar2(32000);
        nuLinesRead     number := GE_BOConstants.cnuNULLNUM;
        tbString        ut_string.TyTb_String;
        nuCodeExe       sa_executable.executable_id%type;
        nuRoleId        sa_role.role_id%type;
        sbPATH          ge_directory.path%type;
        rcsa_role_executables   dasa_role_executables.STYSA_ROLE_EXECUTABLES;

        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN
        -- Valores Enviados desde el PB
        sbIDPATH :=     ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
        sbARCHIVO :=    ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DESCRIPTION');
        sbSEPARADOR :=  ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'ALIAS');

        ------------------------------------------------
        -- User code
        ------------------------------------------------
        pkg_Error.Initialize;
        pkg_Traza.Trace('Inicia LDC_Seguridades.ProcessRoleExecutable['||sbIDPATH||']['||sbARCHIVO||']['||sbSEPARADOR||']',15);

        if sbSEPARADOR IS NULL then
            sbSEPARADOR := ';';
        END if;

        sbPATH := pkg_BCDirectorios.fsbgetRuta(sbIDPATH);

        -- Verifica si el archivo existe en una ruta especifica
        pkg_gestionArchivos.prcValidaExisteArchivo_SMF (sbPATH,sbARCHIVO);

        -- Abre archivo a procesar
        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF
        (
            sbPATH,
            sbARCHIVO,
            'r'
        );

        -- Abre archivo de Log
        eFile := pkg_gestionArchivos.ftAbrirArchivo_SMF
        (
            sbPATH,
            sbARCHIVO||'.log',
            'w'
        );

        -- Se leen las lineas lineas del archivo
        loop
            BEGIN
                sbLine := pkg_gestionArchivos.fsbObtenerLinea_SMF(vFile );
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        EXIT;
            END;

            BEGIN

                -- Se aumentan los contadores locales y globales
                nuLinesRead := nuLinesRead + 1;
                nuRoleId :=0;
                nuCodeExe := 0;
                tbString.delete;

                -- Elimina caracteres especiales que pueden llegar en la linea
                sbLine := replace(replace(sbLine,chr(13),''),chr(10),'');

                ut_string.ExtString(sbLine,sbSEPARADOR,tbString);

                --Se obtiene codigo del ejecutable
                nuRoleId := SA_BORole.GetRoleIdbyName(tbString(1));
                nuCodeExe := GE_BOCATALOG.FNUGETIDFROMCATALOG(tbString(2),'EXECUTABLE');

                if (nuRoleId IS NOT NULL AND nuCodeExe IS NOT NULL) then
                    rcsa_role_executables.role_id := nuRoleId;
                    rcsa_role_executables.executable_id := nuCodeExe;

                    --SE INSERTA EJECUTABLE POR ROLE
                    dasa_role_executables.insrecord(rcsa_role_executables);
                    pkg_gestionArchivos.prcEscribirLinea_SMF(eFile,'Creado Role,Ejecutable ->'||nuRoleId||'|'||nuCodeExe);
                END if;

            EXCEPTION
                when pkg_Error.CONTROLLED_ERROR then
                    pkg_Error.getError(nuErrorCode, sbErrorMessage) ;
                    errormesg:= 'Linea('||nuLinesRead||') '||sbLine||' Error: '||nuErrorCode||' - '||sbErrorMessage;
                    pkg_gestionArchivos.prcEscribirLinea_SMF(eFile,errormesg);
                when others then
                    pkg_Error.setError;
                    pkg_Error.getError(nuErrorCode, sbErrorMessage) ;
                    errormesg:= 'Linea('||nuLinesRead||') '||sbLine||' Error: '||nuErrorCode||' - '||sbErrorMessage;
                    pkg_gestionArchivos.prcEscribirLinea_SMF(eFile,errormesg);
            END;

        END LOOP;

        commit;

        pkg_gestionArchivos.prcCerrarArchivo_SMF( eFile );
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );

        pkg_Traza.Trace('Finaliza LDC_Seguridades.ProcessRoleExecutable',15);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END ProcessRoleExecutable;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FSBVERSION
    Descripcion :  Obtiene la version del paquete

    Autor       :  <Nombre del desarrollador que creo el procedimiento>
    Fecha       :  DD-MM-YYYY
    Parametros  :  Ninguno

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    DD-MM-YYYY   Autor<SAONNNN>     Descripcion de la modificacion
    ***************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

END LDC_Seguridades;
/
PROMPT Otorgando permisos de ejecucion a LDC_SEGURIDADES
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_SEGURIDADES', 'ADM_PERSON');
END;
/