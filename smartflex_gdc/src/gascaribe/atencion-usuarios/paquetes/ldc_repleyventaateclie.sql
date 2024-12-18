CREATE OR REPLACE PACKAGE ldc_repleyventaateclie
IS
    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

    Package  : LDC_RepLeyVentaAteClie
    Descripción  : RESOLUCION 20061300002305 DE 2006
    ANEXO A, B

    Autor  : Carlos Andre Dominguez Naranjo
    Fecha  : 19-09-2013

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
    19-09-2013    cdominguez        Creacion
    -----------  -------------------    -------------------------------------
    11/06/2024    jpinedc               OSF-2604: * Se usa pkg_Correo.
                                        * Se usa pkg_gestionArchivos en lugar de ge_boFileManager
                                        * Ajustes por estándares
    02/12/2014    llarrarte.Cambio5625  Se modifica el procedimiento Formato_I_Itansuca
                                        para que permita generar el reporte tanto para ASNE como ASE
    18-03-2014    Arquitecsoft/mmoreno  En los procedimientos Formato_I_ItansucaDet
                                        y Formato_I_Itansuca:
                                        - Se ajusta el reporte para que solo tenga
                                        en cuenta para las variables 1 y 2 Se genera para
                                        solo para los tipos de paquete (100030),
                                        - Se ajusta el reporte para que solo tenga
                                        en cuenta para la variable 4 se genere solo
                                        para los tipos de paquete (100030,545).
    ******************************************************************/

    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --c<mnemonicoTipoDato>NOMBRECONSTANTEN            TIPODATO := VALOR;

    --------------------------------------------
    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --<mnemonicoTipoDato>NOMBREVARIABLEN             TIPODATO;

    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------
    FUNCTION FSBVERSION
    RETURN VARCHAR2;

    PROCEDURE Formato_A_Reclamaciones;
    PROCEDURE Formato_B_Peticiones;
    PROCEDURE Formato_I_Itansuca;
    PROCEDURE Aprobacion;
    PROCEDURE Formato_I_ItansucaDet;

    --<<
    -- Aranda: 93381
    -- mmoreno
    -- valida la existencia de una orden legalizada por causal 3020
    -->>
    FUNCTION LDC_fnuValidaCausaOrden(inupackage_id mo_packages.package_id%TYPE)
    RETURN NUMBER;

END LDC_RepLeyVentaAteClie;
/

CREATE OR REPLACE PACKAGE BODY ldc_repleyventaateclie
IS
    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

    Package  : LDC_RepLeyVentaAteClie
    Descripción  : RESOLUCION 20061300002305 DE 2006
    ANEXO A, B

    Autor  : Carlos Andres Dominguez Naranjo
    Fecha  : 19-09-2013

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
    -----------  -------------------    -------------------------------------
    19-09-2013    cdominguez        Creacion
    15-11-2013    cdominguez    modificacion de formato A,B. ajuste de
                                tipo de respuesta.
    20-11-2013    cdominguez    Se adiciona parametro de entrada PATH
    03-12-2013    cdominguez    Se adiciona el uso del parametro LD_MEDIOS_RECEPCION_INTERNO
                                para NO seleccionar los medios internos
    11-12-2013    cdominguez    Se valida el id de suscriptor en caso de ser nulo, se reporta
                                N, se modifica carga de causal, se elimina mo_packages_asso
    18-03-2014    Arquitecsoft/mmoreno  En los procedimientos Formato_I_ItansucaDet
                                        y Formato_I_Itansuca:
                                        - Se ajusta el reporte para que solo tenga
                                        en cuenta para las variables 1 y 2 Se genera para
                                        solo para los tipos de paquete (100030),
                                        - Se ajusta el reporte para que solo tenga
                                        en cuenta para la variable 4 se genere solo
                                        para los tipos de paquete (100030,545).
    ******************************************************************/
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION      CONSTANT VARCHAR2(10) := 'REPLEY_V15';
    cnuLimite       CONSTANT number := 1000;
    sbLineFeed      VARCHAR2(10) := chr(10);
    cnuMAXLENGTH    CONSTANT number := 32000;

    sbLineOK        VARCHAR2(32767) := null;
    sbAuxLineOK     VARCHAR2(32767) := null;
    gsbAuxLine      VARCHAR2(32767) := null;
    sbPath          VARCHAR2(250);
    csbDEFAULT_PATH  constant varchar2(4) := '/tmp';
    sbFile          VARCHAR2(250);

    cnuNULL_ATTRIBUTE constant number := 2126;
    nuTiempoMaxAtencion number(2) := 15;

    nuErrorCode    number;

    sbAsunto varchar2(2000);
    sbMensaje varchar2(2000);

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------
    csbSeparador    VARCHAR2(2) := ',';

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------
    --<mnemonicoTipoDato>NOMBREVARIABLE1             TIPODATO;

    CURSOR cuDetalleReporte (inuATECLIREPO_ID LDC_DETAREPOATECLI.ateclirepo_id%type)
     IS
     SELECT LDC_DETAREPOATECLI.*,LDC_DETAREPOATECLI.rowid
     FROM LDC_DETAREPOATECLI
     WHERE ATECLIREPO_ID = inuATECLIREPO_ID
     AND FLAG_REPORTA = 'S';

    CURSOR cuValidaRepo ( nuAno number, nuMes number, sbTipoFormato varchar2) IS
        SELECT LDC_ATECLIREPO.*,LDC_ATECLIREPO.rowid
        FROM LDC_ATECLIREPO
        WHERE TIPO_REPORTE = sbTipoFormato
      AND ANO_REPORTE =    nuAno
      AND MES_REPORTE =    nuMes;

    rcLDC_ATECLIREPO     DALDC_ATECLIREPO.styLDC_ATECLIREPO;
    rcLDC_DETAREPOATECLI DALDC_DETAREPOATECLI.styLDC_DETAREPOATECLI;

    CURSOR cuAmpliacion (nuPACKAGE_id mo_packages.package_id%TYPE,daFechaFinRep DATE) IS
        SELECT sum(numb_days_to_affect)
        FROM MO_ADDI_REQUEST_DATES a, mo_request_date_types b
        WHERE a.request_date_typ_id = b.request_date_typ_id
        AND a.request_date_typ_id in (2,3,4,5,6,7)
        AND request_id = nuPACKAGE_id
        AND new_date <= daFechaFinRep;

    CURSOR cuDanoMasivo (nupackage_id_asso mo_packages_asso.package_id_asso%type) IS
        SELECT a.*
        FROM mo_packages_asso a, mo_packages b
        WHERE a.PACKAGE_id = nupackage_id_asso
        and a.package_id_asso = b.package_id
        AND b.package_type_id =57;

    rcDanoMasivo cuDanoMasivo%rowtype;

    CURSOR cuQuejRclAso (nupackage_id_asso mo_packages_asso.package_id_asso%type) IS
        SELECT b.*,c.causal_id,c.answer_id
        FROM mo_packages_asso a, mo_packages b,mo_motive c
        WHERE a.PACKAGE_id = nupackage_id_asso
        and a.package_id_asso = b.package_id
        AND b.PACKAGE_id = c.PACKAGE_id
     UNION
     SELECT b.*,c.causal_id,c.answer_id
        FROM mo_packages_asso a, mo_packages b,mo_motive c
        WHERE a.PACKAGE_id = nupackage_id_asso
        and a.package_id_asso = b.cust_care_reques_num
        AND b.PACKAGE_id = c.PACKAGE_id
        AND b.PACKAGE_id <> a.PACKAGE_id;

    rccuQuejRclAso  cuQuejRclAso%ROWTYPE;

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

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

    PROCEDURE Initialize IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Initialize';
    BEGIN
        gsbAuxLine := NULL;
        sbPath := csbDEFAULT_PATH;
    END Initialize;

    FUNCTION GetIdReporte return number is
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetIdReporte';
        nuIdReporte number;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        nuIdReporte := sqLDC_ATECLIREPO.nextval;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        RETURN nuIdReporte;
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END GetIdReporte;

    FUNCTION GetIdDetalleReporte return number is
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetIdDetalleReporte';    
        nuIdReporte number;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        nuIdReporte := sqLDC_DETAREPOATECLI.nextval;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);              
        return nuIdReporte;
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END GetIdDetalleReporte;

    FUNCTION GetIdConfigReporte return number is
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetIdConfigReporte';
        nuIdReporte number;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        nuIdReporte := sqCONFIG_EQUIVA_SSPD.nextval;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        return nuIdReporte;
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END GetIdConfigReporte;

    PROCEDURE CreaReporte
        (ircLDC_ATECLIREPO in DALDC_ATECLIREPO.styLDC_ATECLIREPO) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CreaReporte'; 
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        DALDC_ATECLIREPO.insRecord(ircLDC_ATECLIREPO);
        commit;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END CreaReporte;

    PROCEDURE CreaDetalleReporte
        (ircLDC_DETAREPOATECLI in out DALDC_DETAREPOATECLI.styLDC_DETAREPOATECLI) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CreaDetalleReporte';        
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        ircLDC_DETAREPOATECLI.FLAG_REPORTA := 'S';
        daLDC_DETAREPOATECLI.insRecord(ircLDC_DETAREPOATECLI);
        commit;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END CreaDetalleReporte;

    PROCEDURE UpdateReporte
        ( inuATECLIREPO_ID in LDC_ATECLIREPO.ateclirepo_id%type, isbAprobado varchar2) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'UpdateReporte';        
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
        DALDC_ATECLIREPO.updAPROBADO(inuATECLIREPO_ID,isbAprobado,0);
        DALDC_ATECLIREPO.updFECHA_APROBACION(inuATECLIREPO_ID,sysdate);
        commit;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END UpdateReporte;


    PROCEDURE GuardaConfiguracion
        ( inuATECLIREPO_ID in LDC_ATECLIREPO.ateclirepo_id%type) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GuardaConfiguracion';     
        PRAGMA AUTONOMOUS_TRANSACTION;
        CURSOR cuLDC_EQUIVALENCIA_SSPD IS
            SELECT * FROM LDC_EQUIVALENCIA_SSPD
            WHERE activo = 'S';
        rcLDC_CONFIG_EQUIVA_SSPD DALDC_CONFIG_EQUIVA_SSPD.styLDC_CONFIG_EQUIVA_SSPD;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        for rcEquiva in cuLDC_EQUIVALENCIA_SSPD loop
            rcLDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID := GetIdConfigReporte;
            rcLDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID := inuATECLIREPO_ID;
            rcLDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD := rcEquiva.TIPO_SOLICITUD;
            rcLDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF := rcEquiva.RESP_SOL_OSF;
            rcLDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA := rcEquiva.TIPO_RESPUESTA;
            rcLDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD := rcEquiva.CAUSAL_EQUIV_SSPD;
            rcLDC_CONFIG_EQUIVA_SSPD.DESCRIPCION := DALDC_CAUSAL_SSPD.fsbGetDESCRIPTION(rcEquiva.CAUSAL_EQUIV_SSPD);
            rcLDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA := rcEquiva.APLICA_ITANSUCA;
            rcLDC_CONFIG_EQUIVA_SSPD.FORMATO := rcEquiva.FORMATO;

            DALDC_CONFIG_EQUIVA_SSPD.insRecord(rcLDC_CONFIG_EQUIVA_SSPD);
        END loop;

        commit;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END GuardaConfiguracion;


    PROCEDURE impresion (vFile IN OUT pkg_gestionArchivos.styArchivo, sbLine varchar2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'impresion';
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        -- Reporta datos correctos en archivo de salida
        if ( length( gsbAuxLine || sbLine || sbLineFeed) < 32700 ) then
            if sbLine IS not null then
               gsbAuxLine := gsbAuxLine || sbLine || sbLineFeed ;
            END if;
        ELSE
            -- Escribe en disco
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile, SubStr(gsbAuxLine,0,length( gsbAuxLine)-1), TRUE);
            -- Conserva la ultima iteracion
            gsbAuxLine := NULL;
            gsbAuxLine := gsbAuxLine || sbLine || sbLineFeed ;
        END if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END impresion;

    PROCEDURE validate (dtFechaIni date, dtFechaFin date) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'validate';    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        if dtFechaIni > dtFechaFin then
            pkg_Error.setErrorMessage( isbMsgErrr => 'La fecha final debe ser mayor a la fecha inicial');
        END if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END validate;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ReGeneraReporteA
    Descripcion :  Reporte formato A

    Autor       :  Carlos Andres Dominguez Naranjo
    Fecha       :  DD-MM-YYYY
    Parametros  :  Ninguno

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    DD-MM-YYYY   Autor<SAONNNN>     Descripcion de la modificacion
    ***************************************************************/

    PROCEDURE ReGeneraReporteA
        (nuReporte LDC_DETAREPOATECLI.ateclirepo_id%type,
         nuAno number,
         nuMes number,
         sbMail varchar2,
         sbAprobado varchar2 default null)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ReGeneraReporteA'; 
        vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
        sbLineaDeta varchar2(2000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        sbFile := sbAprobado||'Formato_A_Reclamaciones_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';
        pkg_Traza.Trace('archivo creado '||sbFile,10);

        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                  sbPath,
                                  sbFile,
                                  'W');
        sbLineaDeta := 'CODIGO DANE,SERVICIO,RADICADO RECIBIDO,FECHA RECLAMACION,'||
        'TIPO DE TRAMITE,DETALLE DE LA CAUSAL ,NUMERO DE CUENTA ,NUMERO IDENTIFICADOR DE FACTURA,'||
        'TIPO RESPUESTA ,FECHA RESPUESTA , RADICADO RESPUESTA,FECHA DE NOTIFICACION,'||
        'TIPO DE NOTIFICACION,FECHA TRASLADO A SSPD';--||sbLineFeed;
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := null;

        for rcDetalleReporte in cuDetalleReporte (nuReporte) loop
        sbLineaDeta :=  rcDetalleReporte.CODIGO_DANE   ||csbSeparador||
                        rcDetalleReporte.SERVICIO   ||csbSeparador||
                        rcDetalleReporte.RADICADO_ING   ||csbSeparador||
                        rcDetalleReporte.FECHA_REGISTRO   ||csbSeparador||
                        rcDetalleReporte.TIPO_TRAMITE   ||csbSeparador||
                        rcDetalleReporte.CAUSAL   ||csbSeparador||
                        rcDetalleReporte.NUMERO_IDENTIFICACION   ||csbSeparador||
                        rcDetalleReporte.NUMERO_FACTURA   ||csbSeparador||
                        rcDetalleReporte.TIPO_RESPUESTA   ||csbSeparador||
                        rcDetalleReporte.FECHA_RESPUESTA   ||csbSeparador||
                        rcDetalleReporte.RADICADO_RES   ||csbSeparador||
                        rcDetalleReporte.FECHA_NOTIFICACION   ||csbSeparador||
                        rcDetalleReporte.TIPO_NOTIFICACION   ||csbSeparador||
                        rcDetalleReporte.FECHA_TRASLADO;
            impresion (vFile,sbLineaDeta);

        END loop;
        -- Verifica si existen datos correctos sin bajar a disco
        if ( gsbAuxLine IS NOT NULL ) then
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        --pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sysdate);
        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );

        sbAsunto := 'FORMATO A - '||sbFile;
        sbMensaje := 'Reporte FORMATO A - Reclamaciones '||nuAno||'  '||nuMes;

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbMail,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );    

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END ReGeneraReporteA;

    PROCEDURE ReGeneraReporteB
        (nuReporte LDC_DETAREPOATECLI.ateclirepo_id%type,
         nuAno number,
         nuMes number,
         sbMail varchar2,
         sbAprobado varchar2 default null)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ReGeneraReporteB';
        vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
        sbLineaDeta varchar2(2000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        sbFile := sbAprobado||'Formato_B_Peticiones_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';

        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                  sbPath,
                                  sbFile,
                                  'W');
        sbLineaDeta := 'CODIGO DANE,SERVICIO,RADICADO RECIBIDO,FECHA PETICION,CLASE DE PETICION,'||
        'NUMERO DE CUENTA ,TIPO RESPUESTA ,FECHA RESPUESTA , RADICADO RESPUESTA,FECHA DE EJECUCION';--||sbLineFeed;
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := null;

        FOR rcDetalleReporte in cuDetalleReporte (nuReporte) loop
            sbLineaDeta :=  rcDetalleReporte.CODIGO_DANE   ||csbSeparador||
                        rcDetalleReporte.SERVICIO         ||csbSeparador||
                        rcDetalleReporte.RADICADO_ING         ||csbSeparador||
                        rcDetalleReporte.FECHA_REGISTRO   ||csbSeparador||
                        rcDetalleReporte.CAUSAL   ||csbSeparador||
                        rcDetalleReporte.NUMERO_IDENTIFICACION       ||csbSeparador||
                        rcDetalleReporte.TIPO_RESPUESTA   ||csbSeparador||
                        rcDetalleReporte.FECHA_RESPUESTA   ||csbSeparador||
                        rcDetalleReporte.RADICADO_RES ||csbSeparador||
                        rcDetalleReporte.FECHA_TRASLADO
                        ;
            impresion (vFile,sbLineaDeta);
        END LOOP;
        -- Verifica si existen datos correctos sin bajar a disco
        IF ( gsbAuxLine IS NOT NULL ) THEN
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        --pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sysdate);
        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );

        sbAsunto := 'FORMATO B - '||sbFile;
        sbMensaje := 'Reporte FORMATO B - Peticiones '||nuAno||'  '||nuMes;

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbMail,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );    

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END ReGeneraReporteB;

    PROCEDURE ReGeneraReporteI
        (nuReporte LDC_DETAREPOATECLI.ateclirepo_id%type,
         nuAno number,
         nuMes number,
         sbMail varchar2,
         sbAprobado varchar2 default null)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ReGeneraReporteI';
        vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
        sbLineaDeta varchar2(2000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        sbFile := sbAprobado||'Formato_Itansuca_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';

        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                  sbPath,
                                  sbFile,
                                  'W');
        sbLineaDeta := 'TIPO,CANTIDAD,AREA,PORCENTAJE';
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := null;

        for rcDetalleReporte in cuDetalleReporte (nuReporte) loop
                sbLineaDeta := rcDetalleReporte.RADICADO_ING         ||csbSeparador||
                            rcDetalleReporte.CAUSAL   ||csbSeparador||
                            rcDetalleReporte.NUMERO_IDENTIFICACION       ||csbSeparador||
                            rcDetalleReporte.RADICADO_RES ||csbSeparador;

                impresion (vFile,sbLineaDeta);
        END loop;
        -- Verifica si existen datos correctos sin bajar a disco
        if ( gsbAuxLine IS NOT NULL ) then
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        --pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sysdate);
        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );

        sbAsunto := 'ITANSUCA - '||sbFile;
        sbMensaje := 'Reporte ITANSUCA '||nuAno||'  '||nuMes;
                           
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbMail,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );               
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END ReGeneraReporteI;

    FUNCTION ObtieneTipoRespuesta (nusubscription_id mo_motive.subscription_id%type,
                                    dtFechaIni date,
                                    dtFechaFin date) return number
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ObtieneTipoRespuesta';            
        nuDiasHabiles   number;
        nuAmpliacion    number;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        --        debe ser 9 0 10
        nuDiasHabiles := ldc_boutilities.FnuDiasHabiles(dtFechaFin,dtFechaIni);
        open cuAmpliacion (nusubscription_id,dtFechaFin);
        fetch cuAmpliacion INTO nuAmpliacion;
        close cuAmpliacion;

        if  nvl(nuDiasHabiles,0) <= ( nvl(nuAmpliacion,0) + nuTiempoMaxAtencion ) then
            RETURN DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(9);
        else
            return DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(10);
        END if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        return null;
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END ObtieneTipoRespuesta;


    FUNCTION ObtieneTipoRespuestaFB (nusubscription_id mo_motive.subscription_id%type,
                                    dtFechaIni date,
                                    dtFechaFin date) return number
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ObtieneTipoRespuestaFB';  
        nuDiasHabiles   number;
        nuAmpliacion    number;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        --        debe ser 5 0 6
        nuDiasHabiles := ldc_boutilities.FnuDiasHabiles(dtFechaFin,dtFechaIni);
        open cuAmpliacion (nusubscription_id,dtFechaFin);
        fetch cuAmpliacion INTO nuAmpliacion;
        close cuAmpliacion;

        if  nvl(nuDiasHabiles,0) <= ( nvl(nuAmpliacion,0) + nuTiempoMaxAtencion ) then
            RETURN DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(16);
        else
            return DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(17);
        END if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        return null;
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END ObtieneTipoRespuestaFB;


    FUNCTION ValidaTipoProducto ( nuPackageId mo_packages.package_id%type) return number
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ValidaTipoProducto';  
            
        CURSOR cuSolicitud (nuPackageId mo_packages.package_id%type ) IS
            SELECT a.package_id, a.MOTIVE_STATUS_ID, a.package_type_id,
                   a.SUBSCRIBER_ID, a.ATTENTION_DATE, a.MANAGEMENT_AREA_ID,
                   b.MOTIVE_ID, b.PRODUCT_ID, b.PRODUCT_TYPE_ID, b.SUBSCRIPTION_ID
            FROM mo_packages a,
            mo_motive b
            WHERE a.package_id = b.package_id
            AND a.package_id = nuPackageId;

        --Cursor agregado x Ing.Francisco Romero 26/05/2015 Ludycom-Redi
        --Para determinar si tiene producto por CARGTRAM o por PAGONOAB
        CURSOR cuExiste (nuMotivo mo_motive.motive_id%type) IS
            SELECT
            (SELECT COUNT(R.CATRCONS)
            FROM CARGTRAM R WHERE R.CATRMOTI = nuMotivo) CRG,
            (SELECT COUNT(T.PANACONS)
            FROM PAGONOAB T WHERE T.PANAMOTI = nuMotivo) PGO
            FROM DUAL;

        --Cursor agregado x Ing.Francisco Romero 26/05/2015 Ludycom-Redi
        --Si existe en CARGTRAM verifico si los productos tienen permitido reclamos determinado por el parametro COD_SERV en LDPAR
        CURSOR cuTieneProducto1 (nuMotivo1 mo_motive.motive_id%type) IS
            SELECT COUNT(R.CATRCONS) N_REGISTROS
            FROM CARGTRAM R, SERVSUSC S
            WHERE R.CATRMOTI = nuMotivo1
            AND S.SESUNUSE = R.CATRNUSE
            AND S.SESUSERV IN (SELECT TP.SERVCODI
                                 FROM SERVICIO TP
                                WHERE ','||pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_SERV')||',' LIKE '%,'||TP.SERVCODI||',%');

        --Cursor agregado x Ing.Francisco Romero 26/05/2015 Ludycom-Redi
        --Pero Si existe en PAGONOAB verifico si los productos tienen permitido reclamos determinado por el parametro COD_SERV en LDPAR
        CURSOR cuTieneProducto2 (nuMotivo2 mo_motive.motive_id%type) IS
            SELECT COUNT(T.PANACONS) N_REGISTROS
            FROM PAGONOAB T, CUENCOBR C, SERVSUSC S
            WHERE T.PANAMOTI = nuMotivo2
            AND T.PANACUCO = C.CUCOCODI
            AND C.CUCONUSE = S.SESUNUSE
            AND S.SESUSERV IN (SELECT TP.SERVCODI
                                 FROM SERVICIO TP
                                WHERE ','||pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_SERV')||',' LIKE '%,'||TP.SERVCODI||',%');

        nuRetorno number;
        sbParametro varchar2(2000);

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        sbParametro := pkg_BCLD_Parameter.fsbObtieneValorCadena('PTOVTA_EXCLUIDO');

        --pkg_Traza.Trace('Valor:'||sbParametro);
        nuRetorno := 1;   -- [0] No reporta -  [1] Reporta (default)
        for rcSolicitud in cuSolicitud (nuPackageId) loop

            --Esta condicion sirve para evaluar si una solicitud puede ser excluida porque su area asociada hace parte
            --del parametro PTOVTA_EXCLUIDO
            if instr(rcSolicitud.management_area_id,sbParametro) > 0 then
                pkg_Traza.Trace('Pertence a FNB: ' ||nuPackageId);
                nuRetorno := 0;
            END if;

            if rcSolicitud.package_type_id in (545) then -- RECLAMO
                nuRetorno := 0;
                
                 --Comento el anterior codigo y forma de evaluar el tipo paquete 545 y agrego el siguiente codigo
                 --Por Ing.Francisco Romero 26/05/2015 Ludycom-Redi
                 --Verifico si el motivo de la solicitud tiene registros en CARGTRAM o PAGONOAB dependiendo donde haya insertado
                 for rcExiste in cuExiste (rcSolicitud.Motive_Id) loop
                   IF rcExiste.Crg > 0 THEN
                     --Si existe en CARGTRAM verifico si los productos tienen permitido reclamos determinado por el parametro COD_SERV en LDPAR
                     for rcProd1 in cuTieneProducto1 (rcSolicitud.Motive_Id) loop
                       nuRetorno := rcProd1.n_Registros;
                     END loop;
                   ELSIF rcExiste.Pgo > 0 THEN
                     --Pero Si existe en PAGONOAB verifico si los productos tienen permitido reclamos determinado por el parametro COD_SERV en LDPAR
                     for rcProd2 in cuTieneProducto2 (rcSolicitud.Motive_Id) loop
                       nuRetorno := rcProd2.n_Registros;
                     END loop;
                   END IF;

                   IF nuRetorno > 1 THEN
                     nuRetorno := 1;
                   END IF;
                 END loop;
            END if;

        END loop;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        return nuRetorno;

    END ValidaTipoProducto;

    FUNCTION ObtenerTipoProducto ( nuPackageId mo_packages.package_id%type) return VARCHAR
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ObtenerTipoProducto';  
            
        CURSOR cuSolicitud (nuPackageId mo_packages.package_id%type ) IS
            SELECT a.package_id, a.MOTIVE_STATUS_ID, a.package_type_id,
                   a.SUBSCRIBER_ID, a.ATTENTION_DATE, a.MANAGEMENT_AREA_ID,
                   b.MOTIVE_ID, b.PRODUCT_ID, b.PRODUCT_TYPE_ID
            FROM mo_packages a,
            mo_motive b
            WHERE a.package_id = b.package_id
            AND a.package_id = nuPackageId;

        nuServicio servicio.servcodi%type;
        sbRetorno VARCHAR2(60);
        tbCargTram pkBCCargtram .TYTBCARGTRAM;
        nuIndex number;

        sbParametro varchar2(2000);
        nuServiGAS  number;

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        sbParametro := pkg_BCLD_Parameter.fsbObtieneValorCadena('PTOVTA_EXCLUIDO');
        nuServiGAS  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_SERV_GAS');

        for rcSolicitud in cuSolicitud (nuPackageId) loop

            if instr(rcSolicitud.management_area_id,sbParametro) > 0 then
                --pkg_Traza.Trace('Pertence a FNB: ' ||nuPackageId);
                sbRetorno := 'FNB';
            END if;

            if rcSolicitud.package_type_id in (545) then -- RECLAMO
                --Busca el reclamo generado
                pkBCCargtram .GETCARGTRAMBYMOTIVE(rcSolicitud.MOTIVE_ID,tbCargTram);
                nuIndex := tbCargTram.first;
                 loop
                     exit when nuIndex IS null;
                     --pkg_Traza.Trace('Producto: '||tbCargTram(nuIndex).CATRNUSE);
                     nuServicio := pkg_BCProducto.fnuTipoProducto(tbCargTram(nuIndex).CATRNUSE);
                     if nuServicio in ( nuServiGAS ) then
                        sbRetorno := 'GAS';
                     END if;
                     nuIndex := tbCargTram.next(nuIndex);
                 END loop;
            END if;

        END loop;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        return sbRetorno;

    END ObtenerTipoProducto;

    FUNCTION GetFechaAdicional
    (
        nuSolicitud mo_addi_request_dates.request_id%type,
        nuTipo mo_addi_request_dates.request_date_typ_id%TYPE,
        daFechaFinRep  DATE
    )
    return MO_ADDI_REQUEST_DATES%rowtype IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GetFechaAdicional';  
            
        CURSOR cuFechaAdicionales IS
            SELECT * FROM MO_ADDI_REQUEST_DATES
            WHERE request_id = nuSolicitud
            AND request_date_typ_id = nuTipo
            AND  new_date <= daFechaFinRep;
        rcDatos MO_ADDI_REQUEST_DATES%rowtype;
    begin
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        rcDatos := null;
        open cuFechaAdicionales;
        fetch cuFechaAdicionales INTO rcDatos;
        close cuFechaAdicionales;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        return rcDatos;
    EXCEPTION
        when others then
        rcDatos := null;
        return rcDatos;
    END GetFechaAdicional;


    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

        Package  : LDC_RepLeyVentaAteClie
        Descripción  : RESOLUCION 20061300002305 DE 2006
        ANEXO A

        Autor  : Carlos Andres Dominguez Naranjo
        Fecha  : 19-09-2013

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
        -----------  -------------------    -------------------------------------
        19-09-2013    cdominguez        Creacion

    ******************************************************************/
    PROCEDURE Formato_A_Reclamaciones IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Formato_A_Reclamaciones';  
            
      vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
      sbLineaDeta varchar2(2000);
      nuIndex     number;
      salida      number := 0;
      dtFechaIni  date;
      dtFechaFin  date;
      nuAno       number;
      nuMes       number;
      dtFechaResp date;
      nuError     number;
      sbError     varchar2(2000);
      sbDato      varchar2(250);
      nreg        number;
      tpor        varchar2(250);
      nres        number;
      nuAtExpe    varchar2(1);
      sbTpoRta    varchar2(250);
      sbMdiRpc    varchar2(250);
      dtFchaAt    date;
      nuPkg       number;
      sbCausal    varchar2(250);
      nucont2     NUMBER(10) DEFAULT 0;
      nucont3     NUMBER(10) DEFAULT 0;

      /* Valores definidos en la ejecucion LDRSUIA*/
      sbINSISTENTLY_COUNTER ge_boInstanceControl.stysbValue; -- Año
      sbNUMBER_OF_PROD      ge_boInstanceControl.stysbValue; -- Mes
      sbPATH_IN             ge_boInstanceControl.stysbValue; --Path
      sbE_MAIL              ge_boInstanceControl.stysbValue; -- E-Mail

      rcLDC_EQUIVA_LOCALIDAD  DALDC_EQUIVA_LOCALIDAD.styLDC_EQUIVA_LOCALIDAD;
      rcLDC_EQUIVALENCIA_SSPD DALDC_EQUIVALENCIA_SSPD.styLDC_EQUIVALENCIA_SSPD;
      rcLDC_Causal_SSPD       DALDC_Causal_SSPD.styLDC_CAUSAL_SSPD;
      rcLDC_EQUI_CAUSAL_SSPD  DALDC_EQUI_CAUSAL_SSPD.styLDC_EQUI_CAUSAL_SSPD;
      rctt_damage             DATT_damage.STYTT_DAMAGE;

      rcInteraccion      DAMO_Packages.styMO_PACKAGES;
      rcInteraccionQRecl DAMO_Packages.styMO_PACKAGES;
      numotive_status_id mo_packages.motive_status_id%type;
      blExiste           boolean;
      nuProcesa          number;
      nusession   NUMBER;
      sbuser      VARCHAR2(30);

      tbTabla ut_string.TYTB_STRING;

      --Cursor que recoge toda la poblacion de solicitudes a evaluar y procesar
      --Se le agrego una cuarta condicion (d) para traer las atendidas posterior al periodo que se hayan registrado
      --en el periodo evaluado actual o anterior "atendidas futuras" y dependiendo lo que traiga el parametro AT_EXTRAPERI
      --con 'S' se reportan como atendidas (GDC Y EFG) o con 'N' se reportan como pendientes (GDO Y STG).
      --Adicional con el segundo select Union All se recoge la poblaciones de atendidas o pendientes por notificacion
      --Por Ing.Francisco Romero Ludycom-Redi 26-05-2015
      CURSOR cuReclamaciones(dtFechaIni date, dtFechaFin date, dtano number, dtmes number) IS
        SELECT a.package_id,
               a.request_date,
               A.PACKAGE_type_id,
               b.causal_id,
               b.subscription_id,
               b.answer_id,
               MESSAG_DELIVERY_DATE,
               a.attention_date,
               u.GEOGRAP_LOCATION_ID,
               a.CUST_CARE_REQUES_NUM,
               a.motive_status_id,
               a.reception_type_id,
               (SELECT SC.TIPO_SOLICITUD FROM LDC_REP_AREA_TI_PA_CA SC WHERE SC.PACKAGE_TYPE_ID = a.package_type_id AND ROWNUM = 1) Tpo_Sol,
               (SELECT TR.ANSWER_TYPE_ID FROM CC_ANSWER_TYPE TR, CC_ANSWER RP WHERE TR.ANSWER_TYPE_ID = RP.ANSWER_TYPE_ID AND RP.ANSWER_ID = B.ANSWER_ID AND ROWNUM = 1) Tpo_Rsta,
               identification,
               b.annul_date,
               daps_package_type.fsbgetdescription(a.package_type_id) Nombre_Solicitud,
               TO_CHAR(a.sale_channel_id)||' - '||dage_organizat_area.fsbgetname_(a.sale_channel_id) punto_atencion,
               (SELECT DECODE(ld.medio_uso,'I','Interna','E','Externa','M','Mixta')
                  FROM ldc_rep_area_ti_pa_ca ld
                 WHERE ld.package_type_id = a.package_id
                   AND ROWNUM = 1) medio_uso,
                   REPLACE(REPLACE(a.comment_,CHR(13),' '),CHR(10),' ') obssoli
          FROM mo_packages        a,
               mo_motive          b,
               ge_subscriber,
               ab_address,
               ge_geogra_location u
         WHERE A.PACKAGE_id = b.PACKAGE_id
           AND ge_subscriber.address_id = ab_address.address_id
           AND ab_address.geograp_location_id = u.geograp_location_id
           AND a.subscriber_id = ge_subscriber.subscriber_id
           AND a.motive_status_id in (13, 14, 32, 36) --Deben tenerse en cuenta las anuladas porque pueden haberse presentado en el periodo anterior cuando aun no estaba anulada y tambien en proceso anulacion para mostrarlas como pendiente de respuesta
           AND A.package_type_id IN
               (
                    SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('FORMATO_A_RECLAMACION'),'[^,]+', 1,LEVEL))
                    FROM dual
                    CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('FORMATO_A_RECLAMACION'), '[^,]+', 1, LEVEL) IS NOT NULL
                ) --545, 100030, 308, 59, 50, 52
           AND a.reception_type_id NOT IN
               (
                    SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_MEDIOS_RECEPCION_INTERNO'),'[^,]+', 1,LEVEL))
                    FROM dual
                    CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_MEDIOS_RECEPCION_INTERNO'), '[^,]+', 1, LEVEL) IS NOT NULL
                ) --10,11,12,13,14,16,17,18
           AND ((a.request_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss') AND a.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) -- a
               OR (a.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss') AND a.attention_date IS NULL) --b
               OR (a.attention_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss') AND
                   a.attention_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) --c
               OR (a.attention_date > to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss') AND a.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) --d
               )
        UNION
        SELECT a.package_id,
               a.request_date,
               A.PACKAGE_type_id,
               b.causal_id,
               b.subscription_id,
               b.answer_id,
               MESSAG_DELIVERY_DATE,
               a.attention_date,
               u.GEOGRAP_LOCATION_ID,
               a.CUST_CARE_REQUES_NUM,
               a.motive_status_id,
               a.reception_type_id,
               (SELECT SC.TIPO_SOLICITUD FROM LDC_REP_AREA_TI_PA_CA SC WHERE SC.PACKAGE_TYPE_ID = a.package_type_id AND ROWNUM = 1) Tpo_Sol,
               (SELECT TR.ANSWER_TYPE_ID FROM CC_ANSWER_TYPE TR, CC_ANSWER RP WHERE TR.ANSWER_TYPE_ID = RP.ANSWER_TYPE_ID AND RP.ANSWER_ID = B.ANSWER_ID AND ROWNUM = 1) Tpo_Rsta,
               identification,
               b.annul_date,
               daps_package_type.fsbgetdescription(a.package_type_id) Nombre_Solicitud,
               TO_CHAR(a.sale_channel_id)||' - '||dage_organizat_area.fsbgetname_(a.sale_channel_id) punto_atencion,
               (SELECT DECODE(ld.medio_uso,'I','Interna','E','Externa','M','Mixta')
                  FROM ldc_rep_area_ti_pa_ca ld
                 WHERE ld.package_type_id = a.package_id
                   AND ROWNUM = 1) medio_uso,
               REPLACE(REPLACE(a.comment_,CHR(13),' '),CHR(10),' ') obssoli
        FROM LDC_ATECLIREPO R,
             LDC_DETAREPOATECLI D,
             mo_packages        a,
             mo_motive          b,
             ge_subscriber,
             ab_address,
             ge_geogra_location u
        WHERE R.TIPO_REPORTE = 'A'
        AND R.ANO_REPORTE||R.MES_REPORTE = DECODE(dtmes,1,(dtano-1)||12,dtano||(dtmes-1))
        AND D.ATECLIREPO_ID = R.ATECLIREPO_ID
        AND ((D.TIPO_RESPUESTA NOT IN ('9','10') AND D.TIPO_NOTIFICACION = 'N') OR (D.TIPO_RESPUESTA IN ('9','10')) OR (D.NOTIFICADO = 0))
        AND D.PACKAGE_ID = A.PACKAGE_ID
        AND A.PACKAGE_id = b.PACKAGE_id
        AND ge_subscriber.address_id = ab_address.address_id
        AND ab_address.geograp_location_id = u.geograp_location_id
        AND a.subscriber_id = ge_subscriber.subscriber_id
        ORDER BY request_date;
      /*
      La informacion de reclamaciones corresponde a:
      a) Reclamaciones recibidas durante el periodo de reporte;
      b) Reclamaciones por resolver de periodos anteriores;
      c) Reclamaciones resueltas en el periodo de reporte
      */

      --Ordenes de respuesta
      CURSOR cuOrdenesResp(nuPACKAGE_id mo_packages.package_id%type, cunuAtExpe varchar2, cudtFechaFin date) IS
        SELECT a.*
          FROM OR_order a, OR_order_activity b
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND b.task_type_id IN
               (                
                SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_RESP_SSPD'),'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_RESP_SSPD'), '[^,]+', 1, LEVEL) IS NOT NULL                
                )
           AND legalization_date <= DECODE(cunuAtExpe,'S',to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'),cudtFechaFin); --12579, 10343, 100033

      --Ordenes de traslado
      CURSOR cuOrdenesTraSSPD(nuPACKAGE_id mo_packages.package_id%type, cunuAtExpe varchar2, cudtFechaFin date) IS
        SELECT a.execution_final_date
          FROM OR_order a, OR_order_activity b
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND b.task_type_id IN
               (                  
                SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_TRALADA_SSPD'),'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_TRALADA_SSPD'), '[^,]+', 1, LEVEL) IS NOT NULL                                
                )
           AND legalization_date <= DECODE(cunuAtExpe,'S',to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'),cudtFechaFin); --10372

      --Cursor para determinar la orden que atendio la solicitud principal
      --Por Ing.Francisco Romero Ludycom-Redi 26-05-2015
      CURSOR cuOrdenesSol(nuPACKAGE_id mo_packages.package_id%type) IS
        SELECT MAX(a.execution_final_date) execution_final_date
          FROM OR_order a, OR_order_activity b, Mo_Packages p
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND a.order_status_id = 8
           AND b.instance_id is not null
           AND p.package_id = b.package_id
           AND a.Legalization_Date <= p.attention_date;

    -- jjjm Cursor para obtener el tipo de unidad operativa de la orden que atendio la solicitud
       CURSOR cutipounidoper(nuPACKAGE_id mo_packages.package_id%type) IS
        SELECT a.order_id,TO_CHAR(u.unit_type_id)||' - '||(SELECT tu.descripcion  FROM ge_tipo_unidad tu WHERE tu.id_tipo_unidad = u.unit_type_id) desc_tu
          FROM OR_order a, OR_order_activity b, Mo_Packages p,OR_OPERATING_UNIT U
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND a.order_status_id = 8
           AND b.instance_id is not null
           AND p.package_id = b.package_id
           AND a.operating_unit_id = u.operating_unit_id
           AND a.Legalization_Date <= p.attention_date
           and a.execution_final_date = (
                                        SELECT MAX(a.execution_final_date) execution_final_date
                                              FROM OR_order a1, OR_order_activity b1, Mo_Packages p1
                                             WHERE a1.order_id = b1.order_id
                                               AND b1.PACKAGE_id = b.package_id
                                               AND a1.order_status_id = 8
                                               AND b1.instance_id is not null
                                               AND p1.package_id = b1.package_id
                                               AND a1.Legalization_Date <= p1.attention_date)
     AND ROWNUM = 1;

      --Cursor para determinar si la solicitud existe reportada en periodo anterior
      --Por Ing.Francisco Romero Ludycom-Redi 26-05-2015
      CURSOR cuVigenciasAnt(nuano number, numes number, nuradic mo_packages.package_id%type) IS
        SELECT D.TIPO_RESPUESTA
        FROM LDC_ATECLIREPO R, LDC_DETAREPOATECLI D
        WHERE R.TIPO_REPORTE = 'A'
        AND R.ANO_REPORTE||R.MES_REPORTE = DECODE(numes,1,(nuano-1)||12,nuano||(numes-1))
        AND D.ATECLIREPO_ID = R.ATECLIREPO_ID
        AND D.PACKAGE_ID = nuradic
        AND ROWNUM = 1;

      --Cursor para determinar cuantas solicitudes de reclamo hay dada una interaccion
      --Por Ing.Francisco Romero Ludycom-Redi 27-05-2015
      CURSOR cuReclamosSol(nuPACKAGE_id mo_packages.Cust_Care_Reques_Num%type) IS
        SELECT COUNT(P.PACKAGE_ID) N_SOL
        FROM MO_PACKAGES P
        WHERE P.CUST_CARE_REQUES_NUM =  nuPACKAGE_id
        AND P.PACKAGE_TYPE_ID = 545;

      rccuOrdenesResp     cuOrdenesResp%rowtype;
      rccuOrdenesRespQRcl cuOrdenesResp%rowtype;
      rccuOrdenesTraSSPD  cuOrdenesTraSSPD%ROWTYPE;
      rccuOrdenesSol      cuOrdenesSol%rowtype;
      rccutipounidoper    cutipounidoper%rowtype;

      rcFechaAdicionales MO_ADDI_REQUEST_DATES%rowtype;
      nulongi            NUMBER;
      sbsaliobsr         mo_packages.comment_%TYPE;
      sbvarobse          mo_packages.comment_%TYPE;
      nupakgsoliproc     mo_packages.package_id%TYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

      Initialize;

      sbINSISTENTLY_COUNTER := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                     'INSISTENTLY_COUNTER');
      sbNUMBER_OF_PROD      := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                     'NUMBER_OF_PROD');
      sbPATH_IN             := ge_boInstanceControl.fsbGetFieldValue('GE_DIRECTORY',
                                                                     'PATH');
      sbE_MAIL              := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER',
                                                                     'E_MAIL');

      if (sbINSISTENTLY_COUNTER is null) then
        pkg_Error.SetErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE, isbMsgErrr => 'Año de generacion');
      end if;

      if (sbNUMBER_OF_PROD is null) then
        pkg_Error.SetErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE, isbMsgErrr => 'Mes de generacion');
      end if;

      if (sbPATH_IN is null) then
        pkg_Error.SetErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE, isbMsgErrr => 'Ruta Del Directorio');
      end if;

      if (sbE_MAIL is null) then
        pkg_Error.SetErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE, isbMsgErrr => 'Correo de entrega');
      end if;
    SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
     ldc_proinsertaestaprog(sbINSISTENTLY_COUNTER,sbNUMBER_OF_PROD,'FORMATO_A_RECLAMACIONES','En ejecución..',nusession,sbuser);

      nucont2 := 0;
      nucont3 := 0;

      --20-10-2015, Ing.Francisco Romero, Ludycom-Redi
      --Verifico si en una vigencia posterior se ejecuto este proceso, en tal caso se aborta:
      BEGIN
        SELECT L.PACKAGE_ID INTO nuPkg
        FROM LDC_DETAREPOATECLI L, LDC_ATECLIREPO A
        WHERE A.ATECLIREPO_ID = L.ATECLIREPO_ID
        AND A.TIPO_REPORTE = 'A'
        AND A.ANO_REPORTE||A.MES_REPORTE = DECODE(TO_NUMBER(sbNUMBER_OF_PROD),12,(TO_NUMBER(sbINSISTENTLY_COUNTER)+1)||1,TO_NUMBER(sbINSISTENTLY_COUNTER)||(TO_NUMBER(sbNUMBER_OF_PROD)+1))
        AND ROWNUM = 1;
      EXCEPTION
        WHEN OTHERS THEN
          nuPkg := NULL;
      END;

      IF nuPkg IS NOT NULL THEN        
        pkg_Error.SetErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE, isbMsgErrr => '[Periodo Restringuido. Existe una vigencia posterior procesada]');
      END IF;

      sbPath := pkg_BCDirectorios.fsbGetRuta(sbPATH_IN);
      nuAno  := to_number(sbINSISTENTLY_COUNTER);

      if nuAno < 1950 OR nuAno > 2150 then
        pkg_Error.SetErrorMessage(inuCodeError => 114646, isbMsgErrr => 'Año de generacion');
      END if;

      dtFechaIni := to_date('01-' || sbNUMBER_OF_PROD || '-' ||
                            sbINSISTENTLY_COUNTER || ' 00:00:00');
      dtFechaFin := to_date(to_char(last_day(to_date(dtFechaIni)), 'DD') ||
                            to_char(to_date(dtFechaIni), 'MM') || '-' ||
                            to_char(to_date(dtFechaIni), 'YYYY') || '23:59:59');

      VALIDATE(dtFechaIni, dtFechaFin);

      nuAno := to_char(dtFechaIni, 'YYYY');
      nuMes := to_char(dtFechaIni, 'MM');

      rcLDC_ATECLIREPO := null;
      open cuValidaRepo(nuAno, nuMes, 'A');
      fetch cuValidaRepo
        INTO rcLDC_ATECLIREPO;
      close cuValidaRepo;

      if rcLDC_ATECLIREPO.ATECLIREPO_ID IS not null then
        if rcLDC_ATECLIREPO.APROBADO = 'S' then
          -- Debe generar reporte del historico
          ldc_proactualizaestaprog(nusession,'Regenera desde BD con ID: ' ||to_char(rcLDC_ATECLIREPO.ATECLIREPO_ID),'FORMATO_A_RECLAMACIONES','Termino ');
          pkg_Traza.Trace('Regenera desde BD con ID: ' ||
                         rcLDC_ATECLIREPO.ATECLIREPO_ID,
                         10);
          ReGeneraReporteA(rcLDC_ATECLIREPO.ATECLIREPO_ID,
                           nuAno,
                           nuMes,
                           sbE_MAIL);
          return;
        else
          -- obtiene id reporte
          rcLDC_DETAREPOATECLI.ATECLIREPO_ID := rcLDC_ATECLIREPO.ATECLIREPO_ID;
          -- borra detalle reporte
          begin
            pkg_Traza.Trace('borra detalle con id ' ||
                           rcLDC_DETAREPOATECLI.ATECLIREPO_ID,
                           10);
            DELETE LDC_DETAREPOATECLI
             WHERE ATECLIREPO_ID = rcLDC_DETAREPOATECLI.ATECLIREPO_ID;
            commit;
          EXCEPTION
            when others then
              null;
          END;
        END if;
      else
        rcLDC_ATECLIREPO.ATECLIREPO_ID     := GetIdReporte;
        rcLDC_DETAREPOATECLI.ATECLIREPO_ID := rcLDC_ATECLIREPO.ATECLIREPO_ID;
        rcLDC_ATECLIREPO.TIPO_REPORTE      := 'A';
        rcLDC_ATECLIREPO.ANO_REPORTE       := nuAno;
        rcLDC_ATECLIREPO.MES_REPORTE       := nuMes;
        rcLDC_ATECLIREPO.FECHA_APROBACION  := NULL;
        rcLDC_ATECLIREPO.APROBADO          := 'N';

        -- Crea Encabezado de reporte
        CreaReporte(rcLDC_ATECLIREPO);

      END if;

      DELETE anexoa aa WHERE aa.anex = 'A';
      COMMIT;

      -- Debe generar reporte

      sbFile := 'Formato_A_Reclamaciones_' || nuAno || '_' || nuMes || '_' ||
                To_Char(SYSDATE, 'YYYY_MM_DD_HH_MI_SS') || '.csv';

      vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                sbPath,
                                sbFile,
                                'W');
      sbLineaDeta := 'CODIGO DANE,SERVICIO,RADICADO RECIBIDO,FECHA RECLAMACION,' ||
                     'TIPO DE TRAMITE,DETALLE DE LA CAUSAL ,NUMERO DE CUENTA ,NUMERO IDENTIFICADOR DE FACTURA,' ||
                     'TIPO RESPUESTA ,FECHA RESPUESTA , RADICADO RESPUESTA,FECHA DE NOTIFICACION,' ||
                     'TIPO DE NOTIFICACION,FECHA TRASLADO A SSPD,' ||
                     'TIPO_SOLICITUD,ESTADO_SOLICITUD,MEDIO_RECEPCION,CAUSAL_ID,RESPUESTA_AT,TIPO_RESPUESTA_OSF,FECHA_ATENCION_SOL,DESC_MEDIO_RECEP,CAUSAL_LEGAL,' ||
                     'NOMBRE_SOLICITUD,PUNTO_ATENCION,MEDIO_USO,TIPO_UNIDAD_OPERATIVA,OBSERVACION'; --||sbLineFeed;
      pkg_gestionArchivos.prcEscribirLinea_SMF(vFile, sbLineaDeta);

      sbLineaDeta := null;

      nuAtExpe := pkg_BCLD_Parameter.fsbObtieneValorCadena('AT_EXTRAPERI');

      for rcPQR in cuReclamaciones(dtFechaIni, dtFechaFin, nuAno, nuMes) loop
      nupakgsoliproc := rcPQR.Package_Id;
        --20-10-2015, Ing.Francisco Romero, Ludycom-Redi
        --Verifico si es de vigencia anterior y con error, si lo es entonces se exluye del reporte:
        tpor := 'N';
        FOR rcVigAnt IN cuVigenciasAnt(nuAno,nuMes,rcPQR.package_id) LOOP
          tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
        END LOOP;
        --Si viene en cero es porque es de vigencia anterior con error, por lo tanto se excluye
        IF tpor = '0' THEN
          pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
          goto NO_REPORTA;
        END IF;

        --27-05-2015, Ing.Francisco Romero, Ludycom-Redi
        --Con esta variable voy a controlar que cuando se presenten varias solicitudes del tipo 545 asociadas
        --a una misma interaccion el campo radicado recibido se iria con el numero de la interaccion para el
        --resto de solicitudes el campo radicado se iria con el numero de solicitud:
        nres := 0;
        FOR rcRecSol in cuReclamosSol(rcPQR.Cust_Care_Reques_Num) LOOP
          nres := NVL(rcRecSol.n_Sol,0);
        END LOOP;
        IF nres > 1 THEN
          nres := 1;
        ELSE
          nres := 0;
        END IF;

        IF nres = 0 THEN
           rcLDC_DETAREPOATECLI.RADICADO_ING := rcPQR.package_id;
        ELSE
           rcLDC_DETAREPOATECLI.RADICADO_ING := rcPQR.Cust_Care_Reques_Num;
        END IF;

        --Obtener tipo de producto, esto se hace para los reclamos (tipo paquete 545) en los cuales no se quiera
        --reportar solicitudes de algunos productos en caso contrario asocie todos los productos al parametro COD_SERV
        --y tambien esta funcion evita reportar aquellas que pertenescan a un area inluida en el parametro PTOVTA_EXCLUIDO
        nuProcesa := ValidaTipoProducto(rcPQR.package_id);

        IF nuProcesa = 0 THEN
          -- No debe reportar
          pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
          GOTO NO_REPORTA;
        END IF;

        --obtiene registro de la interaccion
        rcInteraccion := damo_packages.frcgetrecord(rcPQR.CUST_CARE_REQUES_NUM); --obtiene interaccion

        --<<
        -- mmoreno
        -- Aranda: 93381
        -- Se valida que la atencion tenga una orden legalizada por causal 3230
        -->>
        IF rcPQR.Motive_Status_Id = 14 THEN
           IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' THEN
              nuProcesa := LDC_fnuValidaCausaOrden(rcInteraccion.package_id);
           ELSE
              nuProcesa := LDC_fnuValidaCausaOrden(rcPQR.package_id);
           END IF;
        ELSE
           --Si esta en estado registrada debera continuar con su transito normal hasta ser reportada como pendiente de respuesta 9
           nuProcesa := 0;
        END IF;

        --26-05-2015, Ing.Francisco Romero, Ludycom-Redi
        --Aqui se evalua si la solicitud esta anulada para darle el mismo tratamiento de aquellas por causal 3230
        IF nuProcesa <> 1 THEN
          IF rcPQR.Motive_Status_Id = 32 THEN
            nuProcesa := 1;
          END IF;
        END IF;

        --26-05-2015, Ing.Francisco Romero, Ludycom-Redi
        --Si la variable nuProcesa lleva 1 es porque la solicitud tiene causal 3230 o esta anulada:
        --Ojo en estado de anulacion 36 debe presentarse como pendiente de respuesta
        if (nuProcesa = 1) and (rcPQR.Motive_Status_Id <> 36) then
          nreg := 0;
          tpor := 'N';

          --Si el estado es anulado tomo la fecha de anulacion del motivo
          IF rcPQR.Motive_Status_Id = 32 THEN
            dtFchaAt := rcPQR.Annul_Date;
          ELSE
            dtFchaAt := rcPQR.attention_date;
          END IF;

          --Con parametro AT_EXTRAPERI en S para el manejo Gascaribe-Efigas ya que ellos incluyen "atendidas futuras"
          --y la solicitud sea registrado y atendida dentro de ese periodo a reportar y maneje la causal 3230 no se
          --reporta al igual que las anuladas:
          IF (nuAtExpe = 'S')
            AND (rcPQR.request_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (rcPQR.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (dtFchaAt <= to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN

              -- No debe reportar siempre y cuando no exista reportada en periodo anterior
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;

          ELSIF(nuAtExpe = 'S')
               AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
               AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
               AND (dtFchaAt <= to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN
            --Por este camino se tienen en cuenta registradas en periodos anterior y atendidas en este periodo pero
            --con causal 3230 tambien se revisa si se reporto en periodo anterior, si se reporto toca reportarla en
            --el actual sino no se reporta, aplica tambien para anuladas
            -- Verificar si existe reportada en periodo anterior
            for rcVigAnt in cuVigenciasAnt(nuAno,nuMes,rcPQR.package_id) loop
              tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
            END loop;

            IF tpor IN ('9','10') THEN
              --Si entro aqui es porque toca reportarla con tipo respuesta 3, fecha respuesta y notificacion con la
              --el dato de la fecha de anulacion que viene siendo la misma attention_date y tipo notificacion en 1
              --estas asignaciones se hacen mas abajo en el codigo
              nreg := 1;
            ELSE
              nreg := 0;
            END IF;

            IF nreg = 0 THEN
              -- No debe reportar siempre y cuando no exista reportada en periodo anterior
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;
            END IF;

          ELSIF (nuAtExpe = 'S')
               AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
               AND (dtFchaAt < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
               AND (rcPQR.Motive_Status_Id = 32) THEN
               -- No debe reportar por ser registrada y anulada en periodos anteriores
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;
          END IF;
          --Con parametro AT_EXTRAPERI en N para el manejo GDO-Surtigas ya que ellos NO incluyen "atendidas futuras"
          --y la solicitud sea registrado y atendida dentro de ese periodo a reportar y maneje la causal 3230 no se
          --reporta siempre y cuando no tenga un reporte en el periodo anterior:
          IF (nuAtExpe <> 'S')
            AND (rcPQR.request_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (rcPQR.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (dtFchaAt <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN

              -- No debe reportar siempre y cuando no exista reportada en periodo anterior
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;

          ELSIF(nuAtExpe <> 'S')
            AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
            AND (dtFchaAt <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN
            --Por este camino se tienen en cuenta registradas en periodos anterior y atendidas en este periodo pero
            --con causal 3230 tambien se revisa si se reporto en periodo anterior, si se reporto toca reportarla en
            --el actual sino no se reporta
            -- Verificar si existe reportada en periodo anterior
            for rcVigAnt in cuVigenciasAnt(nuAno,nuMes,rcPQR.package_id) loop
              tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
            END loop;

            IF tpor <> 'N' THEN
              nreg := 1;
              --Si entro aqui es porque toca reportarla con tipo respuesta 3, fecha respuesta y notificacion con la
              --el dato de la fecha de anulacion que viene siendo la misma attention_date y tipo notificacion en 1
              --estas asignaciones se hacen mas abajo en el codigo
            ELSE
              nreg := 0;
            END IF;

            IF nreg = 0 THEN
              -- No debe reportar siempre y cuando no exista reportada en periodo anterior
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;
            END IF;

          ELSIF (nuAtExpe <> 'S')
               AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
               AND (dtFchaAt < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
               AND (rcPQR.Motive_Status_Id = 32) THEN
               -- No debe reportar por ser registrada y anulada en periodos anteriores
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;
          END IF;
        END if;

        --26-05-2015, Por Ing.Francisco Romero, Ludycom - Redi
        --Aqui controlamos que una "atendida futura" bajo el esquema AT_EXTRAPERI = 'S' (GDC - EFG) que se haya
        --presentado como atendida en el periodo anterior no vuelva a presentarse como atendida nuevamente.
        IF (nuAtExpe = 'S') AND (nuProcesa <> 1) THEN
          tpor := 'N';
          nreg := 0;
          -- 26/05/2015 - ing. Francisco Romero - Ludycom(Proyecto Peti)
          -- Verificar si existe reportada en periodos anteriores como NO pendiente de respuesta
          for rcVigAnt in cuVigenciasAnt(nuAno,nuMes,rcPQR.package_id) loop
            tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
          END loop;

          IF (tpor IN ('9','10')) OR (tpor = 'N') THEN
            nreg := 1;
            --Si entro aqui es porque toca seguir reportandola por lo tanto no se excluye y que siga el proceso normal
          ELSE
            nreg := 0;
          END IF;

          if nreg = 0 then
            -- No debe reportar porque ya se un periodo anterior se reporto con tipo respuesta diferente a 9 o 10
            pkg_Traza.Trace('No debe procesarlo, Se reporto en Periodo Anterior con Tipo Respuesta diferente a 9 o 10: ' || rcPQR.package_id);
            goto NO_REPORTA;
          END if;

        END IF;

        rccuOrdenesResp := NULL;

        --Obtener Ordenes de Respuesta
        open cuOrdenesResp(rcInteraccion.package_id, nuAtExpe, dtFechaFin);
        fetch cuOrdenesResp
          INTO rccuOrdenesResp;
        close cuOrdenesResp;


        --Obtener la orden que atendio la solicitud principal. 16/04/2015 Ing Francisco Romero - Ludycom(Proyecto peti)
        rccuOrdenesSol := NULL;
        open cuOrdenesSol(rcPQR.Package_Id);
        fetch cuOrdenesSol
          INTO rccuOrdenesSol;
        close cuOrdenesSol;

        -- Obtenemos el tipo de unidad de trabajo
         rccutipounidoper := NULL;
        open cutipounidoper(rcPQR.Package_Id);
        fetch cutipounidoper
          INTO rccutipounidoper;
        close cutipounidoper;

        rcLDC_DETAREPOATECLI.DETAREPOATECLI_ID := GetIdDetalleReporte;
        pkg_Traza.Trace('Detalle Id Usado: ' ||
                       rcLDC_DETAREPOATECLI.DETAREPOATECLI_ID,
                       10);
        pkg_Traza.Trace('Reporte Id Usado: ' ||
                       rcLDC_DETAREPOATECLI.ATECLIREPO_ID,
                       10);

        blExiste := FALSE;

        --Aqui se arma el codigo de dane tomado de la tbla LDC_EQUIVA_LOCALIDAD dada la localidad, esta tabla
        --se alimenta atraves de la opcion de smartflex LDCDANE
        if DALDC_EQUIVA_LOCALIDAD.fblExist(rcPQR.GEOGRAP_LOCATION_ID) then
          rcLDC_EQUIVA_LOCALIDAD := DALDC_EQUIVA_LOCALIDAD.frcGetRecord(rcPQR.GEOGRAP_LOCATION_ID);
          blExiste               := TRUE;
        END if;

        --Si encontro el codigo dane en la instruccion anterior entonces se muestra sino ERROR
        if blExiste then
          rcLDC_DETAREPOATECLI.CODIGO_DANE := rcLDC_EQUIVA_LOCALIDAD.departamento ||
                                              rcLDC_EQUIVA_LOCALIDAD.municipio ||
                                              rcLDC_EQUIVA_LOCALIDAD.poblacion;
        else
          rcLDC_DETAREPOATECLI.CODIGO_DANE := 'ERROR';
        END if;

        rcLDC_DETAREPOATECLI.Servicio     := '5';

        rcLDC_DETAREPOATECLI.FECHA_REGISTRO := to_char(rcPQR.request_date,
                                                       'DD-MM-YYYY');

        /*
        1 Peticion o queja (100030,545,308,59)
        2 Recurso de Reposicion (50)
        3 Recurso de Reposicion y Subsidiario de Apelacion (52)
        */
        if rcPQR.package_type_id in (100030, 545, 308, 59) then
          rcLDC_DETAREPOATECLI.TIPO_TRAMITE := 1;
        elsif rcPQR.package_type_id in (50) then
          rcLDC_DETAREPOATECLI.TIPO_TRAMITE := 2;
        elsif rcPQR.package_type_id in (52) then
          rcLDC_DETAREPOATECLI.TIPO_TRAMITE := 3;
        else
          rcLDC_DETAREPOATECLI.TIPO_TRAMITE := NULL;
        END if;

        /*
        Detalle se obtiene de la tabla que define la resolucion, se obtiene deacuerdo al tipo de causal
        */
        --<<
        -- mmoreno
        -- Se inicializa con valor Error para el caso que la variable no se cargue
        -->>
        rcLDC_DETAREPOATECLI.CAUSAL         := 'ERROR';
        rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := NULL;

        ------------MANEJO DEL DETALLE DE LA CAUSAL---------------
        /* 50, 52 Se debe siempre realizar para estos tipos de paquete la configuracion en LDC_EQUI_CAUSAL_SSPD*/
        IF (rcPQR.package_type_id = 50) OR (rcPQR.package_type_id = 52) then

          --Obtener Quejo o Reclamo asosiado
          OPEN cuQuejRclAso(rcPQR.package_id);
          FETCH cuQuejRclAso
            INTO rccuQuejRclAso;
          CLOSE cuQuejRclAso;

          --obtiene registro de la interaccion
          rcInteraccionQRecl := damo_packages.frcgetrecord(rccuQuejRclAso.CUST_CARE_REQUES_NUM); --obtiene interaccion

          IF ( (rccuQuejRclAso.causal_id IS NULL) OR (rccuQuejRclAso.PACKAGE_type_id NOT IN ('545','100030')) ) THEN
            rcLDC_DETAREPOATECLI.CAUSAL := '39';
          ELSE

            --Obtiene causal de la queja o reclamo asosiado
            if DALDC_EQUI_CAUSAL_SSPD.fblExist(rccuQuejRclAso.PACKAGE_type_id,
                                               rccuQuejRclAso.causal_id) then
              rcLDC_EQUI_CAUSAL_SSPD := DALDC_EQUI_CAUSAL_SSPD.frcGetRecord(rccuQuejRclAso.PACKAGE_type_id,
                                                                            rccuQuejRclAso.causal_id);
              ---
              rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID);
              rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;

              --revisar ordenes de Respuesta de a quejo o reclamo asosiado
              rccuOrdenesRespQRcl := NULL;

              --Obtener Ordenes de Respuesta
              OPEN cuOrdenesResp(rcInteraccionQRecl.package_id, nuAtExpe, dtFechaFin);
              FETCH cuOrdenesResp
                INTO rccuOrdenesRespQRcl;
              CLOSE cuOrdenesResp;

              IF (rccuOrdenesRespQRcl.order_id IS NULL OR
                 rccuOrdenesRespQRcl.legalization_date IS NULL) THEN
                if DALDC_EQUI_CAUSAL_SSPD.fblExist(rccuQuejRclAso.PACKAGE_type_id,
                                                   rccuQuejRclAso.causal_id) then
                  rcLDC_EQUI_CAUSAL_SSPD := DALDC_EQUI_CAUSAL_SSPD.frcGetRecord(rccuQuejRclAso.PACKAGE_type_id,
                                                                                rccuQuejRclAso.causal_id);
                  ---
                  rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID);
                  rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;

                END if;
              ELSE
                if DALDC_EQUIVALENCIA_SSPD.fblExist(rccuQuejRclAso.PACKAGE_type_id,
                                                    rccuQuejRclAso.answer_id) then
                  rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rccuQuejRclAso.PACKAGE_type_id,
                                                                                  rccuQuejRclAso.answer_id);
                  ---
                  rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD);
                  rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;

                END if;
              END if;

              --Sino encontro causal configurada en la tabla de equivalencias coloco 33
              IF (rcLDC_DETAREPOATECLI.CAUSAL IS NULL) OR (rcLDC_DETAREPOATECLI.CAUSAL = '') THEN
                rcLDC_DETAREPOATECLI.CAUSAL := '39';
              END IF;

            END IF;

          END IF;

        ELSE
          -- Para otros tipos de paquete se debe buscar dependiendo del estado.

          -- estado Registrado se debe buscar con causal
          IF (rccuOrdenesResp.order_id IS NULL OR
             rccuOrdenesResp.legalization_date IS NULL) THEN
            IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' then
              -- Escrito
              IF DALDC_EQUI_CAUSAL_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                 rcPQR.causal_id) then
                rcLDC_EQUI_CAUSAL_SSPD := DALDC_EQUI_CAUSAL_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                              rcPQR.causal_id);
                ---
                rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID);
                rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;

              END IF;
            ELSE
              ---Para los medio Verbales

              IF pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 14 then
                -- estado

                rcFechaAdicionales := NULL;
                IF nuAtExpe = 'S' THEN
                  rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                          15,
                                                          to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 15
                ELSE
                  rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                          15,
                                                          dtFechaFin); -- tipo 15
                END IF;


                if DALDC_EQUIVALENCIA_SSPD.fblExist(rcPQR.PACKAGE_type_id,rcPQR.answer_id) AND  rcFechaAdicionales.request_id IS not null then
                  rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                                  rcPQR.answer_id);
                  ---
                  rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD);
                  rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;

                ELSE

                  IF  DALDC_EQUI_CAUSAL_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                 rcPQR.causal_id) then
                    rcLDC_EQUI_CAUSAL_SSPD := DALDC_EQUI_CAUSAL_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                                  rcPQR.causal_id);
                    ---
                    rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID);
                    rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;
                 END IF;
                END if;
              ELSE
                --<<
                --
                -->>
                IF DALDC_EQUI_CAUSAL_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                   rcPQR.causal_id) then
                  rcLDC_EQUI_CAUSAL_SSPD      := DALDC_EQUI_CAUSAL_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                                     rcPQR.causal_id);
                  rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID);
                  rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;
                END IF;

              END IF;
            END IF; --Validacion medio recepcion
          ELSE
            if DALDC_EQUIVALENCIA_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                rcPQR.answer_id) then
              rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                              rcPQR.answer_id);
              ---
              rcLDC_Causal_SSPD           := daldc_causal_sspd.frcGetRecord(rcLDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD);
              rcLDC_DETAREPOATECLI.CAUSAL := rcLDC_Causal_SSPD.CAUSAL_ID;
            END if;

          END if;

        END if;
        ------------CIERRA MANEJO DETALLE DE LA CAUSAL---------------

        ------------NUEVO MANEJO DEL TIPO DE RESPUESTA--------------------------------
        ------------------------------------------------------------------------------
        -- 28/05/2015 - Ing.Francisco Romero - Ludycom-Redi
        -- Medio escrito:
        IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' THEN
          IF rcPQR.Motive_Status_Id = 14 THEN
            IF (rccuOrdenesResp.order_id IS NULL OR
                rccuOrdenesResp.legalization_date IS NULL) THEN
                rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
                rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
                rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
                rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
                rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
                rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
            ELSE
                IF DALDC_EQUIVALENCIA_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                    rcPQR.answer_id) then
                  rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                                  rcPQR.answer_id);
                  rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(rcLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA);

                END IF;
            END IF;
          ELSE
            rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          END IF;
        ELSE
          -- Medio verbal:
          IF rcPQR.Motive_Status_Id = 14 THEN
            IF DALDC_EQUIVALENCIA_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                rcPQR.answer_id) then
              rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                              rcPQR.answer_id);
              rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(rcLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA);

            END IF;
          ELSE
            rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          END IF;
        END IF;

        --28/05/2015 - Agregado por Ing.Francisco Romero Romero, Ludycom-Redi
        --Si Tipo respuesta es nula aun entonces se marca en cero Para avisarle al usuario que hay un error
        --en la solicitud rcPQR.answer_id en nulo ya que este se requiere para ir a las equivalencias o simplemente
        --no hay equivalencia parametrizada en LDCGAS, tambien puede ser por error de smartflex al no actualizar
        --correctamente los estados de las solicitudes o interacciones
        IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA IS NULL THEN
          rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 0;
        END IF;
        ------------------------------------------------------------------------------


        ------------inicia calculo de fecha de respuesta---------------
        rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := NULL;

        --Validacion del fecha de respuesta
        IF dage_reception_type.fblexist(rcInteraccion.reception_type_id) THEN
          IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' then
            -- Escrito
            IF (rccuOrdenesResp.order_id IS NOT NULL AND
               rccuOrdenesResp.legalization_date IS NOT NULL) then
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := to_char(rccuOrdenesResp.Execution_Final_Date,--legalization_date,
                                                              'DD-MM-YYYY');
            ELSE
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            END IF;
          ELSE
            -- Verbal
            IF pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14 then

              --Incluido por Ing.Francisco Romero, 16/04/2015, Ludycom(proyecto peti)
              IF (rccuOrdenesSol.Execution_Final_Date IS NOT NULL) then
                rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := to_char(rccuOrdenesSol.Execution_Final_Date,
                                                                'DD-MM-YYYY');
              ELSE
                rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := to_char(rcPQR.Attention_Date,'DD-MM-YYYY');
              END IF;

            END IF;
          END IF; --Validacion de medio escrito
          --END IF;
        END IF;

        /*
        --Sevalida que la fecha de respuesta no este  NULL
        */
        IF (rcLDC_DETAREPOATECLI.FECHA_RESPUESTA IS NULL) THEN
          -->>
          --Se valida que el tipo de respuesta sea 9 o 10, en el caso de
          --que la interacion este en estado registrado tambien se debe
          --agregar la fecha de respuesta con N
          -->>
          IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA IN (9, 10) THEN
            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
          ELSE
            IF (pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 13) THEN
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            ELSE
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := NULL;
            END IF;
          END IF;
        END IF;
        ------------cierra calculo de fecha de respuesta---------------

        if rcPQR.subscription_id IS null then
          rcLDC_DETAREPOATECLI.NUMERO_FACTURA   := 'N';
        else
          rcLDC_DETAREPOATECLI.NUMERO_FACTURA   := NVL(CC_BOClaimInstanceData.fnuGetClaimedBill(rcPQR.package_id),CC_BOCLAIMINSTANCEDATA_PNA.FNUGETCLAIMEDBILL(rcPQR.package_id));
          if rcLDC_DETAREPOATECLI.NUMERO_FACTURA IS null then
            rcLDC_DETAREPOATECLI.NUMERO_FACTURA := 'N';
          END if;
        END if;

        if rcPQR.subscription_id IS null then
            rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION := rcPQR.Identification;
        else
            rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION := rcPQR.subscription_id;
        END if;

        ------------cierra calculo de radicado de respuesta---------------
        IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' then
          -- Escrito
          IF (rccuOrdenesResp.order_id IS NOT NULL AND
             rccuOrdenesResp.legalization_date IS NOT NULL) THEN

            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES       := 'N';
            IF nuAtExpe = 'S' THEN
              rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                      15,
                                                      to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 15
            ELSE
              rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                      15,
                                                      dtFechaFin); -- tipo 15
            END IF;
            rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;

            if rcFechaAdicionales.request_id IS not null then
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rcFechaAdicionales.NEW_DATE,
                                                                 'DD-MM-YYYY');

            END if;
          ELSE
            if rcLDC_DETAREPOATECLI.TIPO_RESPUESTA in (9, 10) OR
               pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 13 THEN
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            else
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            END if;
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
          END IF;
        ELSE
          ---Para medios Verbales
          IF (pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14) THEN


            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES       := 'N';
            rcFechaAdicionales                      := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                                         15,
                                                                         dtFechaFin); -- tipo 15
            if rcFechaAdicionales.request_id IS not null then
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rcFechaAdicionales.NEW_DATE,
                                                                 'DD-MM-YYYY');
              rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
            END if;

            --Incluido por Ing.Francisco Romero, 16/04/2015, Ludycom(proyecto peti)
            IF (rccuOrdenesSol.Execution_Final_Date IS NOT NULL) then
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rccuOrdenesSol.Execution_Final_Date,
                                                              'DD-MM-YYYY');
              rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
            ELSE
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rcPQR.Attention_Date,'DD-MM-YYYY');
              rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
            END IF;

          ELSE
            if rcLDC_DETAREPOATECLI.TIPO_RESPUESTA in (9, 10) OR
               pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 13 THEN
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            else
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            END if;
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
          END IF;
        END IF;

        rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';

        if pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 14 AND rcLDC_DETAREPOATECLI.TIPO_RESPUESTA NOT  in (9, 10) then
          -- estado

          rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'ERROR'; -- defecto

          --28/05/2015, Modificado por: ING.FRANCISCO ROMERO ROMERO, Ludycom-Redi
          --Se modifica que para cada tipo se valida el parametro AT_EXTRAPERI para determinar si con S busca la fecha adicional
          --hasta el dia de hoy sysdate por el contrario hasta el limite del periodo normal

          -- Siempre tendra tipo 11 para notificacion personal
          IF nuAtExpe = 'S' THEN
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    11,
                                                    to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 11
          ELSE
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    11,
                                                    dtFechaFin); -- tipo 11
          END IF;
          if rcFechaAdicionales.request_id IS not null then
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 1;
          END if;

          -- Puede tener tipo 13 en caso de tener es tipo 2
          IF nuAtExpe = 'S' THEN
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    13,
                                                    to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 11
          ELSE
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    13,
                                                    dtFechaFin);
          END IF;
          if rcFechaAdicionales.request_id IS not null then
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 2;
          END if;

          -- Puede tener tipo 14 en caso de tener es tipo 2
          IF nuAtExpe = 'S' THEN
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    14,
                                                    to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 11
          ELSE
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    14,
                                                    dtFechaFin);
          END IF;
          if rcFechaAdicionales.request_id IS not null then
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 2; -- Por solicitud de Zandra Prada
          END if;

          -- Puede tener tipo 16 en caso de tener es tipo 2
          IF nuAtExpe = 'S' THEN
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    16,
                                                    to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 11
          ELSE
            rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                    16,
                                                    dtFechaFin);
          END IF;
          if rcFechaAdicionales.request_id IS not null then
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 1; -- Por solicitud de Zandra Prada
          END if;

          -- Puede tener tipo 15 en caso de tener es tipo 2
          IF (rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION = 'N') OR (rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION = 'ERROR') THEN
            IF nuAtExpe = 'S' THEN
              rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                      15,
                                                      to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 11
            ELSE
              rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                      15,
                                                      dtFechaFin);
            END IF;
            if rcFechaAdicionales.request_id IS not null then
              rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 1; -- Por solicitud de Zandra Prada
            END if;
          END IF;

        END if;

        --------------------------------------------------------------------------------------------------
        --21/10/2015, Modificado por: ING.FRANCISCO ROMERO ROMERO, Ludycom-Redi
        IF (dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) <> 'Y') THEN
          IF (pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14) THEN
            IF (rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION <> 'N') AND (rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION IS NOT NULL) THEN
               rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 1;
            ELSE
               rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
            END IF;
          END IF;
        END IF;
        --------------------------------------------------------------------------------------------------

        --------------------------------------------------------------------------------------------------
        --26/05/2015, Modificado por: ING.FRANCISCO ROMERO ROMERO, Ludycom-Redi
        IF nuAtExpe <> 'S' THEN
          --Si el estado es anulado tomo la fecha de anulacion del motivo
          IF rcPQR.Motive_Status_Id = 32 THEN
            dtFchaAt := rcPQR.Annul_Date;
          ELSE
            dtFchaAt := rcPQR.attention_date;
          END IF;

          --Aqui simplemente toda la poblacion de atendidas extraperiodos hacia adelante se muestran pendiente
          --para que en el mes siguiente(s) se procesen como atendidas, solo aplica para (GDO-STG)
          IF (dtFchaAt > to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss') AND rcPQR.Request_Date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN
              rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
              rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
              rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          END IF;
        END IF;
        --------------------------------------------------------------------------------------------------
        --26/05/2015, Modificado por: ING.FRANCISCO ROMERO ROMERO, Ludycom-Redi
        --Si ambas variables vienen en 1 es porque tienen causal 3230 o estan anuladas y toca reportarlas con
        --estas asignaciones:
        IF (nuProcesa = 1) AND (nreg = 1) AND (rcPQR.Motive_Status_Id <> 36) THEN
          rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 3;
          rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := TO_CHAR(rcPQR.Attention_Date,'DD-MM-YYYY');
          rcLDC_DETAREPOATECLI.RADICADO_RES := rcPQR.CUST_CARE_REQUES_NUM;
          rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := TO_CHAR(rcPQR.Attention_Date,'DD-MM-YYYY');
          rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 1;
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END IF;
        --------------------------------------------------------------------------------------------------
        --Modificado por: ING.FRANCISCO ROMERO ROMERO 26/05/2015, Ludycom-Redi
        --Si esta en estado de anulacion se debe presentar como pendiente de respuesta:
        IF (rcPQR.Motive_Status_Id = 36) THEN
          rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
          rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
          rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
          rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
          rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END IF;
        --------------------------------------------------------------------------------------------------
        --Modificado por: ING.FRANCISCO ROMERO ROMERO 28/05/2015, Ludycom-Redi
        --Si el tipo de respuesta viene en 9 estos campos van en N
        IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA = 9 THEN
          rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
          rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
          rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
          rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END IF;
        --------------------------------------------------------------------------------------------------
        BEGIN
          SELECT TR.DESCRIPTION INTO sbTpoRta
          FROM CC_ANSWER_TYPE TR
          WHERE TR.ANSWER_TYPE_ID = rcPQR.Tpo_Rsta;
        EXCEPTION
          WHEN OTHERS THEN
            sbTpoRta := NULL;
        END;
        --------------------------------------------------------------------------------------------------
        BEGIN
          SELECT MR.DESCRIPTION INTO sbMdiRpc
          FROM GE_RECEPTION_TYPE MR
          WHERE MR.RECEPTION_TYPE_ID = rcPQR.Reception_Type_Id;
        EXCEPTION
          WHEN OTHERS THEN
            sbMdiRpc := NULL;
        END;
        --------------------------------------------------------------------------------------------------
        IF (dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) <> 'Y') THEN
          IF (pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14) THEN
            BEGIN
              SELECT c.causal_id||' - '||c.description INTO sbCausal
                FROM OR_order a, OR_order_activity b, GE_Causal c
               WHERE a.order_id = b.order_id
                 AND b.PACKAGE_id = rcPQR.Package_Id
                 AND a.order_status_id = 8
                 AND b.instance_id is not null
                 AND c.causal_id = a.causal_id
                 AND a.Legalization_Date = rccuOrdenesSol.Execution_Final_Date;
            EXCEPTION
              WHEN OTHERS THEN
                sbCausal := NULL;
            END;
          END IF;
        END IF;
        --------------------------------------------------------------------------------------------------
        --Modificado por: ING.FRANCISCO ROMERO ROMERO 29/05/2015, Ludycom-Redi
        --Campos adicionales pedidos en el FANA
        rcLDC_DETAREPOATECLI.TIPO_SOLICITUD := rcPQR.Tpo_Sol;
        rcLDC_DETAREPOATECLI.ESTADO_SOLICITUD := rcPQR.Motive_Status_Id;
        rcLDC_DETAREPOATECLI.MEDIO_RECEPCION := rcPQR.Reception_Type_Id;
        rcLDC_DETAREPOATECLI.CAUSAL_ID := rcPQR.Package_Type_Id;
        rcLDC_DETAREPOATECLI.RESPUESTA_AT := rcPQR.Answer_Id;
        rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_OSF := NULL;
        rcLDC_DETAREPOATECLI.CAUSAL_LEGA_OT := NULL;
        rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL := sbTpoRta;
        rcLDC_DETAREPOATECLI.FECHA_SOLICITUD := TO_CHAR(rcPQR.Attention_Date,'DD-MM-YYYY');
        rcLDC_DETAREPOATECLI.PACKAGE_ID := rcPQR.package_id;

        --<<
        --Fecha de tralado a la SSPD
        --04-08-2015 Ing.Francisco Romero - Ludycom S.A. : Se adiciona validacion que el tipo de respuesta sea CONFIRMA
        --                                                 rcPQR.Tpo_Rsta = 35
        -->>
        IF ((rcPQR.package_type_id in (52)) AND (rcPQR.Tpo_Rsta = 35)) THEN

          --<
          --Se obtiene la fecha de registro de la SSPD
          -->>
          OPEN cuOrdenesTraSSPD(rcInteraccion.package_id, nuAtExpe, dtFechaFin);
          FETCH cuOrdenesTraSSPD
            INTO rccuOrdenesTraSSPD;
          IF (cuOrdenesTraSSPD%NOTFOUND) THEN
            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          ELSE
            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := to_char(rccuOrdenesTraSSPD.Execution_Final_Date,
                                                           'DD-MM-YYYY');
          END IF;
          CLOSE cuOrdenesTraSSPD;

          --Modificado por: ING.FRANCISCO ROMERO ROMERO 14/10/2015, Ludycom-Redi
          --Valido fecha de traslado en N se marca como SIN FECHA DE TRASLADO llenando el campo interno NOTIFICADO = 0
          IF (rcLDC_DETAREPOATECLI.FECHA_TRASLADO = 'N') THEN
            rcLDC_DETAREPOATECLI.NOTIFICADO := 0;
          END IF;

          --rcLDC_DETAREPOATECLI.FECHA_TRASLADO := to_char(rcInteraccion.attention_date,'DD-MM-YYYY'); -- OJO
          --            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := to_char(rccuOrdenesTraSSPD.register_date,'DD-MM-YYYY');
        ELSE
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END if;

       -- nulongi := length(TRIM(rcPQR.Obssoli));
        sbsaliobsr := null;
        
        sbsaliobsr := substr(REPLACE(rcPQR.Obssoli,',',' '),1,500);
        INSERT INTO anexoa VALUES(
                                  rcLDC_DETAREPOATECLI.CODIGO_DANE
                                 ,rcLDC_DETAREPOATECLI.Servicio
                                 ,rcLDC_DETAREPOATECLI.RADICADO_ING
                                 ,rcLDC_DETAREPOATECLI.FECHA_REGISTRO
                                 ,rcLDC_DETAREPOATECLI.TIPO_TRAMITE
                                 ,rcLDC_DETAREPOATECLI.CAUSAL
                                 ,rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION
                                 ,rcLDC_DETAREPOATECLI.NUMERO_FACTURA
                                 ,rcLDC_DETAREPOATECLI.TIPO_RESPUESTA
                                 ,rcLDC_DETAREPOATECLI.FECHA_RESPUESTA
                                 ,rcLDC_DETAREPOATECLI.RADICADO_RES
                                 ,rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION
                                 ,rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION
                                 ,rcLDC_DETAREPOATECLI.FECHA_TRASLADO
                                 ,rcLDC_DETAREPOATECLI.TIPO_SOLICITUD
                                 ,rcLDC_DETAREPOATECLI.ESTADO_SOLICITUD
                                 ,rcLDC_DETAREPOATECLI.MEDIO_RECEPCION
                                 ,rcLDC_DETAREPOATECLI.CAUSAL_ID
                                 ,rcLDC_DETAREPOATECLI.RESPUESTA_AT
                                 ,rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL
                                 ,rcLDC_DETAREPOATECLI.FECHA_SOLICITUD
                                 ,sbMdiRpc
                                 ,sbCausal
                                 ,rcPQR.Nombre_Solicitud
                                 ,rcPQR.Punto_Atencion
                                 ,rcPQR.Medio_Uso
                                 ,rccutipounidoper.desc_tu
                                 ,sbsaliobsr
                                 ,'A'
                               );

        nucont2 := nucont2 + 1;

        if nucont2 = 100 then
          commit;
          nucont3 := nucont3 + nucont2;
          nucont2 := 0;
        end if;

        sbLineaDeta := rcLDC_DETAREPOATECLI.CODIGO_DANE || csbSeparador ||
                       rcLDC_DETAREPOATECLI.Servicio || csbSeparador ||
                       rcLDC_DETAREPOATECLI.RADICADO_ING || csbSeparador ||
                       rcLDC_DETAREPOATECLI.FECHA_REGISTRO || csbSeparador ||
                       rcLDC_DETAREPOATECLI.TIPO_TRAMITE || csbSeparador ||
                       rcLDC_DETAREPOATECLI.CAUSAL || csbSeparador ||
                       rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION ||
                       csbSeparador || rcLDC_DETAREPOATECLI.NUMERO_FACTURA ||
                       csbSeparador || rcLDC_DETAREPOATECLI.TIPO_RESPUESTA ||
                       csbSeparador || rcLDC_DETAREPOATECLI.FECHA_RESPUESTA ||
                       csbSeparador || rcLDC_DETAREPOATECLI.RADICADO_RES ||
                       csbSeparador || rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION ||
                       csbSeparador || rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION ||
                       csbSeparador || rcLDC_DETAREPOATECLI.FECHA_TRASLADO ||
                       csbSeparador || rcLDC_DETAREPOATECLI.TIPO_SOLICITUD ||
                       csbSeparador || rcLDC_DETAREPOATECLI.ESTADO_SOLICITUD ||
                       csbSeparador || rcLDC_DETAREPOATECLI.MEDIO_RECEPCION ||
                       csbSeparador || rcLDC_DETAREPOATECLI.CAUSAL_ID ||
                       csbSeparador || rcLDC_DETAREPOATECLI.RESPUESTA_AT ||
                       csbSeparador || rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL ||
                       csbSeparador || rcLDC_DETAREPOATECLI.FECHA_SOLICITUD ||
                       csbSeparador || sbMdiRpc ||
                       csbSeparador || sbCausal ||
                       csbSeparador || rcPQR.Nombre_Solicitud ||
                       csbSeparador || rcPQR.Punto_Atencion   ||
                       csbSeparador || rcPQR.Medio_Uso        ||
                       csbSeparador || rccutipounidoper.desc_tu ||
                       csbSeparador || sbsaliobsr;


        impresion(vFile, sbLineaDeta);

        CreaDetalleReporte(rcLDC_DETAREPOATECLI);

        <<NO_REPORTA>>
        null;
      END loop;

      -- Verifica si existen datos correctos sin bajar a disco
      if (gsbAuxLine IS NOT NULL) then
        --{
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile, gsbAuxLine);
        gsbAuxLine := null;
        --}
      END if;

      --pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,s0ysdate);
      -- Cierra archivo de impresion
      pkg_gestionArchivos.prcCerrarArchivo_SMF(vFile);

      sbAsunto  := 'FORMATO A - ' || sbFile;
      sbMensaje := 'Reporte FORMATO A - Reclamaciones ' || nuAno || '  ' ||
                   nuMes;

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbE_MAIL,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );

        if nucont2 < 100 then
            nucont3 := nucont3 + nucont2;
        end if;
        commit;
        ldc_proactualizaestaprog(nusession,'Proceso terminó Ok. Se procesarón : '||to_char(nucont3)||' registros.','FORMATO_A_RECLAMACIONES','Termino ');

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
       ldc_proactualizaestaprog(nusession,SQLERRM||' SOLI : '||TO_CHAR(nupakgsoliproc),'FORMATO_A_RECLAMACIONES','Termino ');
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
       ldc_proactualizaestaprog(nusession,SQLERRM||' SOLI : '||TO_CHAR(nupakgsoliproc),'FORMATO_A_RECLAMACIONES','Termino ');
        pkg_Error.setError;
        raise pkg_Error.CONTROLLED_ERROR;
    END Formato_A_Reclamaciones;

    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

        Package  : LDC_RepLeyVentaAteClie
        Descripcion  : RESOLUCION 20061300002305 DE 2006
        ANEXO  B

        Autor  : Carlos Andres Dominguez Naranjo
        Fecha  : 19-09-2013

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
        -----------  -------------------    -------------------------------------
        19-09-2013    cdominguez        Creacion

    ******************************************************************/
    PROCEDURE Formato_B_Peticiones IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Formato_B_Peticiones';  
        vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
        sbLineaDeta varchar2(2000);
        nuIndex number;
        salida number := 0;
        dtFechaIni date;
        dtFechaFin date;
        nuAno number;
        nuMes number;
        nuTrimestre number;
        nuDiasHabiles number;
        nuAmpliacion number;
        nreg        number;
        tpor        varchar2(250);
        nres        number;
        nuAtExpe    varchar2(1);
        sbTpoRta    varchar2(250);
        sbMdiRpc    varchar2(250);
        dtFchaAt    date;
        nuPkg       number;
        sbCausal    varchar2(250);
        nucont2     NUMBER(10) DEFAULT 0;
        nucont3     NUMBER(10) DEFAULT 0;
        nusession   NUMBER;
        sbuser      VARCHAR2(30);

        /* Valores definidos en la ejecucion LDRSUIB*/
        sbINSISTENTLY_COUNTER ge_boInstanceControl.stysbValue; -- Año
        sbNUMBER_OF_PROD ge_boInstanceControl.stysbValue;      -- Mes
        sbPATH_IN ge_boInstanceControl.stysbValue; --Path
        sbE_MAIL ge_boInstanceControl.stysbValue; -- E-Mail

        rcLDC_EQUIVA_LOCALIDAD DALDC_EQUIVA_LOCALIDAD.styLDC_EQUIVA_LOCALIDAD;
        rcLDC_EQUIVALENCIA_SSPD DALDC_EQUIVALENCIA_SSPD.styLDC_EQUIVALENCIA_SSPD;
        rcLDC_Causal_SSPD DALDC_Causal_SSPD.styLDC_CAUSAL_SSPD;
        rcLDC_EQUI_CAUSAL_SSPD  DALDC_EQUI_CAUSAL_SSPD.styLDC_EQUI_CAUSAL_SSPD;
        rcLDC_EQUI_PACKTYPE_SSPD DALDC_EQUI_PACKTYPE_SSPD.styLDC_EQUI_PACKTYPE_SSPD;

        rcInteraccion  DAMO_Packages.styMO_PACKAGES;
        numotive_status_id mo_packages.motive_status_id%type;
        blExiste boolean;
        nuProcesa NUMBER;

        --Cursor que recoge toda la poblacion de solicitudes a evaluar y procesar
        --Se le agrego una cuarta condicion (d) para traer las atendidas posterior al periodo que se hayan registrado
        --en el periodo evaluado actual o anterior "atendidas futuras" y dependiendo lo que traiga el parametro AT_EXTRAPERI
        --con 'S' se reportan como atendidas (GDC Y EFG) o con 'N' se reportan como pendientes (GDO Y STG).
        --Adicional con el segundo select Union All se recoge la poblaciones de atendidas o pendientes por notificacion
        --Por Ing.Francisco Romero Ludycom-Redi 26-05-2015
        CURSOR cuPeticiones (dtFechaIni date, dtFechaFin date, dtano number, dtmes number) IS

            SELECT  UNIQUE a.package_id,
                    a.request_date,
                    A.PACKAGE_type_id,
                    b.causal_id,
                    b.subscription_id,
                    b.answer_id,
                    MESSAG_DELIVERY_DATE,
                    a.attention_date,
                    u.GEOGRAP_LOCATION_ID,
                    a.CUST_CARE_REQUES_NUM,
                    a.motive_status_id,
                    ge_subscriber.identification,
                    a.reception_type_id,
                    (SELECT SC.TIPO_SOLICITUD FROM LDC_REP_AREA_TI_PA_CA SC WHERE SC.PACKAGE_TYPE_ID = a.package_type_id AND ROWNUM = 1) Tpo_Sol,
                    (SELECT TR.ANSWER_TYPE_ID FROM CC_ANSWER_TYPE TR, CC_ANSWER RP WHERE TR.ANSWER_TYPE_ID = RP.ANSWER_TYPE_ID AND RP.ANSWER_ID = B.ANSWER_ID AND ROWNUM = 1) Tpo_Rsta,
                    b.annul_date,
                    daps_package_type.fsbgetdescription(a.package_type_id) Nombre_Solicitud,
               to_char(a.sale_channel_id)||' - '||dage_organizat_area.fsbgetname_(a.sale_channel_id) punto_atencion,
               (SELECT DECODE(ld.medio_uso,'I','Interna','E','Externa','M','Mixta')
                  FROM ldc_rep_area_ti_pa_ca ld
                 WHERE ld.package_type_id = a.package_id
                   AND ROWNUM = 1) medio_uso,
                   REPLACE(REPLACE(a.comment_,CHR(13),' '),CHR(10),' ') obssoli
            FROM
                mo_packages a,
                mo_motive b,
                ge_subscriber,
                ab_address,
                ge_geogra_location u
            WHERE A.PACKAGE_id = b.PACKAGE_id
            AND ge_subscriber.address_id = ab_address.address_id
            AND ab_address.geograp_location_id = u.geograp_location_id
            AND a.subscriber_id = ge_subscriber.subscriber_id
            AND a.motive_status_id in (13, 14, 32, 36) --Deben tenerse en cuenta las anuladas porque pueden haberse presentado en el periodo anterior cuando aun no estaba anulada y tambien en proceso anulacion para mostrarlas como pendiente de respuesta
            AND A.package_type_id IN
            (                         
                SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('FORMATO_B_PETICION'),'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('FORMATO_B_PETICION'), '[^,]+', 1, LEVEL) IS NOT NULL                        
            ) --323,271,100229,100240
            AND a.reception_type_id NOT IN
            ( 
                SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_MEDIOS_RECEPCION_INTERNO'),'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_MEDIOS_RECEPCION_INTERNO'), '[^,]+', 1, LEVEL) IS NOT NULL                                                                        
            ) --10,11,12,13,14,16,17,18
            AND ((a.request_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss') AND a.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) -- a
               OR (a.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss') AND a.attention_date IS NULL) --b
               OR (a.attention_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss') AND
                   a.attention_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) --c
               OR (a.attention_date > to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss') AND a.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) --d
                )
            UNION
            SELECT UNIQUE a.package_id,
                   a.request_date,
                   A.PACKAGE_type_id,
                   b.causal_id,
                   b.subscription_id,
                   b.answer_id,
                   MESSAG_DELIVERY_DATE,
                   a.attention_date,
                   u.GEOGRAP_LOCATION_ID,
                   a.CUST_CARE_REQUES_NUM,
                   a.motive_status_id,
                   ge_subscriber.identification,
                   a.reception_type_id,
                   (SELECT SC.TIPO_SOLICITUD FROM LDC_REP_AREA_TI_PA_CA SC WHERE SC.PACKAGE_TYPE_ID = a.package_type_id AND ROWNUM = 1) Tpo_Sol,
                   (SELECT TR.ANSWER_TYPE_ID FROM CC_ANSWER_TYPE TR, CC_ANSWER RP WHERE TR.ANSWER_TYPE_ID = RP.ANSWER_TYPE_ID AND RP.ANSWER_ID = B.ANSWER_ID AND ROWNUM = 1) Tpo_Rsta,
                   b.annul_date,
                   daps_package_type.fsbgetdescription(a.package_type_id) Nombre_Solicitud,
               to_char(a.sale_channel_id)||' - '||dage_organizat_area.fsbgetname_(a.sale_channel_id) punto_atencion,
               (SELECT DECODE(ld.medio_uso,'I','Interna','E','Externa','M','Mixta')
                  FROM ldc_rep_area_ti_pa_ca ld
                 WHERE ld.package_type_id = a.package_id
                   AND ROWNUM = 1) medio_uso,
               REPLACE(REPLACE(a.comment_,CHR(13),' '),CHR(10),' ') obssoli
            FROM LDC_ATECLIREPO R,
                 LDC_DETAREPOATECLI D,
                 mo_packages        a,
                 mo_motive          b,
                 ge_subscriber,
                 ab_address,
                 ge_geogra_location u
            WHERE R.TIPO_REPORTE = 'B'
            AND R.ANO_REPORTE||R.MES_REPORTE = DECODE(dtmes,3,(dtano-1)||12,6,dtano||3,9,dtano||6,12,dtano||9)
            AND D.ATECLIREPO_ID = R.ATECLIREPO_ID
            AND D.TIPO_RESPUESTA IN ('5','6')
            AND D.PACKAGE_ID = A.PACKAGE_ID
            AND A.PACKAGE_id = b.PACKAGE_id
            AND ge_subscriber.address_id = ab_address.address_id
            AND ab_address.geograp_location_id = u.geograp_location_id
            AND a.subscriber_id = ge_subscriber.subscriber_id
            ORDER BY request_date;
    /*
    La informacion de reclamaciones corresponde a:
    a) Reclamaciones recibidas durante el periodo de reporte;
    b) Reclamaciones por resolver de periodos anteriores;
    c) Reclamaciones resueltas en el periodo de reporte
    */


              --<<
              -- mmoreno
              -->>
     --Ordenes de respuesta
      CURSOR cuOrdenesResp(nuPACKAGE_id mo_packages.package_id%type) IS
        SELECT a.*
          FROM OR_order a, OR_order_activity b
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND b.task_type_id IN
               (
                SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_RESP_SSPD'),'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_RESP_SSPD'), '[^,]+', 1, LEVEL) IS NOT NULL
                )
           AND legalization_date <= DECODE(pkg_BCLD_Parameter.fsbObtieneValorCadena('AT_EXTRAPERI'),'S',to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'),dtFechaFin); --12579, 100033
      --Ordenes de traslado
      CURSOR cuOrdenesTraSSPD(nuPACKAGE_id mo_packages.package_id%type) IS
        SELECT b.*
          FROM OR_order a, OR_order_activity b
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND b.task_type_id IN
            (
                SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_TRALADA_SSPD'),'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('TASKTYPE_TRALADA_SSPD'), '[^,]+', 1, LEVEL) IS NOT NULL
            )
           AND legalization_date <= DECODE(pkg_BCLD_Parameter.fsbObtieneValorCadena('AT_EXTRAPERI'),'S',to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'),dtFechaFin); --10372

      --Cursor para determinar la orden que atendio la solicitud principal
      --Por Ing.Francisco Romero Ludycom-Redi 26-05-2015
      CURSOR cuOrdenesSol(nuPACKAGE_id mo_packages.package_id%type) IS
        SELECT MAX(a.execution_final_date) execution_final_date
          FROM OR_order a, OR_order_activity b, Mo_Packages p
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND a.order_status_id = 8
           AND b.instance_id is not null
           AND p.package_id = b.package_id
           AND a.Legalization_Date <= p.attention_date;

    -- jjjm Cursor para obtener el tipo de unidad operativa de la orden que atendio la solicitud
       CURSOR cutipounidoper(nuPACKAGE_id mo_packages.package_id%type) IS
        SELECT a.order_id,to_char(u.unit_type_id)||' - '||(SELECT tu.descripcion  FROM ge_tipo_unidad tu WHERE tu.id_tipo_unidad = u.unit_type_id) desc_tu
          FROM OR_order a, OR_order_activity b, Mo_Packages p,OR_OPERATING_UNIT U
         WHERE a.order_id = b.order_id
           AND b.PACKAGE_id = nuPACKAGE_id
           AND a.order_status_id = 8
           AND b.instance_id is not null
           AND p.package_id = b.package_id
           AND a.operating_unit_id = u.operating_unit_id
           AND a.Legalization_Date <= p.attention_date
           and a.execution_final_date = (
                                        SELECT MAX(a.execution_final_date) execution_final_date
                                              FROM OR_order a1, OR_order_activity b1, Mo_Packages p1
                                             WHERE a1.order_id = b1.order_id
                                               AND b1.PACKAGE_id = b.package_id
                                               AND a1.order_status_id = 8
                                               AND b1.instance_id is not null
                                               AND p1.package_id = b1.package_id
                                               AND a1.Legalization_Date <= p1.attention_date)
     AND ROWNUM = 1;

      --Cursor para determinar si la solicitud existe reportada en periodo anterior
      --Por Ing.Francisco Romero Ludycom-Redi 26-05-2015
      CURSOR cuVigenciasAnt(nuano number, numes number, nuradic mo_packages.package_id%type) IS
        SELECT D.TIPO_RESPUESTA
        FROM LDC_ATECLIREPO R, LDC_DETAREPOATECLI D
        WHERE R.TIPO_REPORTE = 'B'
        AND R.ANO_REPORTE||R.MES_REPORTE = DECODE(numes,3,(nuano-1)||12,6,nuano||3,9,nuano||6,12,nuano||9)
        AND D.ATECLIREPO_ID = R.ATECLIREPO_ID
        AND D.PACKAGE_ID = nuradic
        AND ROWNUM = 1;

       rccuOrdenesTraSSPD  cuOrdenesTraSSPD%ROWTYPE;
       rccuOrdenesResp     cuOrdenesResp%rowtype;
       rcFechaAdicionales MO_ADDI_REQUEST_DATES%rowtype;
       rccuOrdenesSol      cuOrdenesSol%rowtype;
      rccutipounidoper    cutipounidoper%rowtype;
      sbsaliobsr         mo_packages.comment_%TYPE;
      sbvarobse          mo_packages.comment_%TYPE;
      nupakgsoliproc     mo_packages.package_id%TYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        Initialize;

        sbINSISTENTLY_COUNTER := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'INSISTENTLY_COUNTER');
        sbNUMBER_OF_PROD := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'NUMBER_OF_PROD');
        sbPATH_IN := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
        sbE_MAIL := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');

        if (sbINSISTENTLY_COUNTER is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Año de generacion');
        end if;

        if (sbNUMBER_OF_PROD is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Trimestre de generacion');
        end if;

        if (sbPATH_IN is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Ruta Del Directorio');
        end if;

        if (sbE_MAIL is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Correo de entrega');
        end if;

        SELECT USERENV('SESSIONID'),USER INTO nusession,sbuser FROM dual;
        ldc_proinsertaestaprog(sbINSISTENTLY_COUNTER,sbNUMBER_OF_PROD,'FORMATO_B_PETICIONES','En ejecución..',nusession,sbuser);

       nucont2 := 0;
       nucont3 := 0;
        --20-10-2015, Ing.Francisco Romero, Ludycom-Redi
        --Verifico si en una vigencia posterior se ejecuto este proceso, en tal caso se aborta:
        BEGIN
          SELECT L.PACKAGE_ID INTO nuPkg
          FROM LDC_DETAREPOATECLI L, LDC_ATECLIREPO A
          WHERE A.ATECLIREPO_ID = L.ATECLIREPO_ID
          AND A.TIPO_REPORTE = 'B'
          AND A.ANO_REPORTE||A.MES_REPORTE = DECODE(TO_NUMBER(sbNUMBER_OF_PROD),12,(TO_NUMBER(sbINSISTENTLY_COUNTER)+1)||3,3,TO_NUMBER(sbINSISTENTLY_COUNTER)||6,6,TO_NUMBER(sbINSISTENTLY_COUNTER)||9,9,TO_NUMBER(sbINSISTENTLY_COUNTER)||12)
          AND ROWNUM = 1;
        EXCEPTION
          WHEN OTHERS THEN
            nuPkg := NULL;
        END;

        IF nuPkg IS NOT NULL THEN
          pkg_Error.SetErrorMessage(inuCodeError => cnuNULL_ATTRIBUTE, isbMsgErrr => '[Periodo Restringuido. Existe una vigencia posterior procesada]');
        END IF;

        sbPath := pkg_BCDirectorios.fsbGetRuta(sbPATH_IN);
        nuTrimestre := to_number(sbNUMBER_OF_PROD);
        nuAno := to_number(sbINSISTENTLY_COUNTER);

        if nuAno < 1950 OR nuAno > 2150 then
          pkg_Error.SetErrorMessage(inuCodeError => 114646, isbMsgErrr =>  'Año de generacion');
        END if;

        case    -- Valida trimestre
            when nuTrimestre = 1 then
                dtFechaIni := to_date('01-01-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                dtFechaFin := to_date(
                                  to_char(last_day(to_date('01-03-'||sbINSISTENTLY_COUNTER)),'DD')||
                                  to_char(to_date('01-03-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                  to_char(to_date('01-03-'||sbINSISTENTLY_COUNTER),'YYYY')
                              ||'23:59:59');
            when nuTrimestre = 2 then
                dtFechaIni := to_date('01-04-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                dtFechaFin := to_date(
                                  to_char(last_day(to_date('01-06-'||sbINSISTENTLY_COUNTER)),'DD')||
                                  to_char(to_date('01-06-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                  to_char(to_date('01-06-'||sbINSISTENTLY_COUNTER),'YYYY')
                              ||'23:59:59');
            when nuTrimestre = 3 then
                dtFechaIni := to_date('01-07-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                dtFechaFin := to_date(
                                  to_char(last_day(to_date('01-09-'||sbINSISTENTLY_COUNTER)),'DD')||
                                  to_char(to_date('01-09-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                  to_char(to_date('01-09-'||sbINSISTENTLY_COUNTER),'YYYY')
                              ||'23:59:59');
            when nuTrimestre = 4 then
                dtFechaIni := to_date('01-10-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                dtFechaFin := to_date(
                                  to_char(last_day(to_date('01-12-'||sbINSISTENTLY_COUNTER)),'DD')||
                                  to_char(to_date('01-12-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                  to_char(to_date('01-12-'||sbINSISTENTLY_COUNTER),'YYYY')
                              ||'23:59:59');
        END case;

        validate(dtFechaIni, dtFechaFin);

        nuAno := to_char(dtFechaIni,'YYYY');
        nuMes := to_char(dtFechaFin,'MM');

        rcLDC_ATECLIREPO := null;
        open cuValidaRepo (nuAno, nuMes, 'B');
        fetch cuValidaRepo INTO rcLDC_ATECLIREPO;
        close cuValidaRepo;

        if rcLDC_ATECLIREPO.ATECLIREPO_ID IS not null then
            if rcLDC_ATECLIREPO.APROBADO = 'S' then
                -- Debe generar reporte del historico
                ldc_proactualizaestaprog(nusession,'Regenera desde BD con ID: ' ||to_char(rcLDC_ATECLIREPO.ATECLIREPO_ID),'FORMATO_B_PETICIONES','Termino ');
                pkg_Traza.Trace('Regenera desde BD con ID: '||rcLDC_ATECLIREPO.ATECLIREPO_ID,10);
                ReGeneraReporteB(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL);
                return;
            else
                -- obtiene id reporte
                rcLDC_DETAREPOATECLI.ATECLIREPO_ID := rcLDC_ATECLIREPO.ATECLIREPO_ID;
                -- borra detalle reporte
                begin
                pkg_Traza.Trace('borra detalle con id '||rcLDC_DETAREPOATECLI.ATECLIREPO_ID,10);
                    DELETE LDC_DETAREPOATECLI
                    WHERE ATECLIREPO_ID = rcLDC_DETAREPOATECLI.ATECLIREPO_ID;
                    commit;
                EXCEPTION when others then
                    null;
                END;
            END if;
        else
            rcLDC_ATECLIREPO.ATECLIREPO_ID := GetIdReporte;
            rcLDC_DETAREPOATECLI.ATECLIREPO_ID := rcLDC_ATECLIREPO.ATECLIREPO_ID;
            rcLDC_ATECLIREPO.TIPO_REPORTE := 'B';
            rcLDC_ATECLIREPO.ANO_REPORTE := nuAno;
            rcLDC_ATECLIREPO.MES_REPORTE := nuMes;
            rcLDC_ATECLIREPO.FECHA_APROBACION := NULL;
            rcLDC_ATECLIREPO.APROBADO := 'N';

            -- Crea Encabezado de reporte
            CreaReporte(rcLDC_ATECLIREPO);

        END if;

        DELETE anexoa bb WHERE bb.anex = 'B';
        COMMIT;

        sbFile := 'Formato_B_Peticiones_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';

        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                  sbPath,
                                  sbFile,
                                  'W');
        sbLineaDeta := 'CODIGO DANE,SERVICIO,RADICADO RECIBIDO,FECHA PETICION,CLASE DE PETICION,'||
        'NUMERO DE CUENTA ,TIPO RESPUESTA ,FECHA RESPUESTA , RADICADO RESPUESTA,FECHA DE EJECUCION,'||
        'TIPO_SOLICITUD,ESTADO_SOLICITUD,MEDIO_RECEPCION,CAUSAL_ID,RESPUESTA_AT,TIPO_RESPUESTA_OSF,FECHA_ATENCION_SOL,DESC_MEDIO_RECEP,CAUSAL_LEGAL,'||
        'NOMBRE_SOLICITUD,PUNTO_ATENCION,MEDIO_USO,TIPO_UNIDAD_OPERATIVA,OBSERVACION';

        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := null;

        nuAtExpe := pkg_BCLD_Parameter.fsbObtieneValorCadena('AT_EXTRAPERI');

        for rcPQR in cuPeticiones (dtFechaIni, dtFechaFin , nuAno, nuMes) loop
         nupakgsoliproc := rcPQR.Package_Id;
            --20-10-2015, Ing.Francisco Romero, Ludycom-Redi
            --Verifico si es de vigencia anterior y con error, si lo es entonces se exluye del reporte:
            tpor := 'N';
            FOR rcVigAnt IN cuVigenciasAnt(nuAno,nuMes,rcPQR.package_id) LOOP
              tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
            END LOOP;
            --Si viene en cero es porque es de vigencia anterior con error, por lo tanto se excluye
            IF tpor = '0' THEN
              pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
              goto NO_REPORTA;
            END IF;

            rcLDC_DETAREPOATECLI.RADICADO_ING   := rcPQR.package_id;

            --obtiene registro de la interaccion
            rcInteraccion := damo_packages.frcgetrecord(rcPQR.CUST_CARE_REQUES_NUM); --obtiene interaccion

            --<<
            -- mmoreno
            -- Aranda: 93381
            -- Se valida que la atencion tenga una orden legalizada por causal 3230
            -->>
            IF rcPQR.Motive_Status_Id = 14 THEN
               IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' THEN
                  nuProcesa := LDC_fnuValidaCausaOrden(rcInteraccion.package_id);
               ELSE
                  nuProcesa := LDC_fnuValidaCausaOrden(rcPQR.package_id);
               END IF;
            ELSE
               --Si esta en estado registrada debera continuar con su transito normal hasta ser reportada como pendiente de respuesta 9
               nuProcesa := 0;
            END IF;

            --26-05-2015, Ing.Francisco Romero, Ludycom-Redi
            --Aqui se evalua si la solicitud esta anulada para darle el mismo tratamiento de aquellas por causal 3230
            IF nuProcesa <> 1 THEN
              IF rcPQR.Motive_Status_Id = 32 THEN
                nuProcesa := 1;
              END IF;
            END IF;

            --26-05-2015, Ing.Francisco Romero, Ludycom-Redi
            --Si la variable nuProcesa lleva 1 es porque la solicitud tiene causal 3230 o esta anulada:
            --Ojo en estado de anulacion 36 debe presentarse como pendiente de respuesta
            if (nuProcesa = 1) and (rcPQR.Motive_Status_Id <> 36) then
              nreg := 0;
              tpor := 'N';

              --Si el estado es anulado tomo la fecha de anulacion del motivo
              IF rcPQR.Motive_Status_Id = 32 THEN
                dtFchaAt := rcPQR.Annul_Date;
              ELSE
                dtFchaAt := rcPQR.attention_date;
              END IF;

              --Con parametro AT_EXTRAPERI en S para el manejo Gascaribe-Efigas ya que ellos incluyen "atendidas futuras"
              --y la solicitud sea registrado y atendida dentro de ese periodo a reportar y maneje la causal 3230 no se
              --reporta al igual que las anuladas:
              IF (nuAtExpe = 'S')
                AND (rcPQR.request_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                AND (rcPQR.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                AND (dtFchaAt <= to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN

                  -- No debe reportar siempre y cuando no exista reportada en periodo anterior
                  pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
                  goto NO_REPORTA;

              ELSIF(nuAtExpe = 'S')
                   AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                   AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                   AND (dtFchaAt <= to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN
                --Por este camino se tienen en cuenta registradas en periodos anterior y atendidas en este periodo pero
                --con causal 3230 tambien se revisa si se reporto en periodo anterior, si se reporto toca reportarla en
                --el actual sino no se reporta, igual para anuladas
                -- Verificar si existe reportada en periodo anterior
                for rcVigAnt in cuVigenciasAnt(nuAno,nuMes,rcPQR.Package_Id) loop
                  tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
                END loop;

                IF tpor IN ('5','6') THEN
                  --Si entro aqui es porque toca reportarla con tipo respuesta 3, fecha respuesta y notificacion con la
                  --el dato de la fecha de anulacion que viene siendo la misma attention_date y tipo notificacion en 1
                  --estas asignaciones se hacen mas abajo en el codigo
                  nreg := 1;
                ELSE
                  nreg := 0;
                END IF;

                IF nreg = 0 THEN
                  -- No debe reportar siempre y cuando no exista reportada en periodo anterior
                  pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
                  goto NO_REPORTA;
                END IF;

              ELSIF (nuAtExpe = 'S')
                   AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                   AND (dtFchaAt < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                   AND (rcPQR.Motive_Status_Id = 32) THEN
                   -- No debe reportar por ser registrada y anulada en periodos anteriores
                  pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
                  goto NO_REPORTA;

              END IF;
              --Con parametro AT_EXTRAPERI en N para el manejo GDO-Surtigas ya que ellos NO incluyen "atendidas futuras"
              --y la solicitud sea registrado y atendida dentro de ese periodo a reportar y maneje la causal 3230 no se
              --reporta siempre y cuando no tenga un reporte en el periodo anterior:
              IF (nuAtExpe <> 'S')
                AND (rcPQR.request_date >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                AND (rcPQR.request_date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                AND (dtFchaAt <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN

                  -- No debe reportar siempre y cuando no exista reportada en periodo anterior
                  pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
                  goto NO_REPORTA;

              ELSIF(nuAtExpe <> 'S')
                 AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                 AND (dtFchaAt >= to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                 AND (dtFchaAt <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN
                --Por este camino se tienen en cuenta registradas en periodos anterior y atendidas en este periodo pero
                --con causal 3230 tambien se revisa si se reporto en periodo anterior, si se reporto toca reportarla en
                --el actual sino no se reporta
                -- Verificar si existe reportada en periodo anterior
                for rcVigAnt in cuVigenciasAnt(nuAno,nuMes,rcPQR.Package_Id) loop
                  tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
                END loop;

                IF tpor <> 'N' THEN
                  nreg := 1;
                  --Si entro aqui es porque toca reportarla con tipo respuesta 3, fecha respuesta y notificacion con la
                  --el dato de la fecha de anulacion que viene siendo la misma attention_date y tipo notificacion en 1
                  --estas asignaciones se hacen mas abajo en el codigo
                ELSE
                  nreg := 0;
                END IF;

                IF nreg = 0 THEN
                  -- No debe reportar siempre y cuando no exista reportada en periodo anterior
                  pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
                  goto NO_REPORTA;
                END IF;

              ELSIF (nuAtExpe <> 'S')
                 AND (rcPQR.request_date < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                 AND (dtFchaAt < to_date(to_char(dtFechaIni,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss'))
                 AND (rcPQR.Motive_Status_Id = 32) THEN
                 -- No debe reportar por ser registrada y anulada en periodos anteriores
                pkg_Traza.Trace('No debe procesarlo: ' || rcPQR.package_id);
                goto NO_REPORTA;

              END IF;
            END if;

            --26-05-2015, Por Ing.Francisco Romero, Ludycom - Redi
            --Aqui controlamos que una "atendida futura" bajo el esquema AT_EXTRAPERI = 'S' (GDC - EFG) que se haya
            --presentado como atendida en el periodo anterior no vuelva a presentarse como atendida nuevamente.
            IF (nuAtExpe = 'S') AND (nuProcesa <> 1) THEN
              tpor := 'N';
              nreg := 0;
              -- 26/05/2015 - ing. Francisco Romero - Ludycom(Proyecto Peti)
              -- Verificar si existe reportada en periodos anteriores como NO pendiente de respuesta
              for rcVigAnt in cuVigenciasAnt(nuAno,nuMes,rcPQR.Package_Id) loop
                tpor := NVL(rcVigAnt.Tipo_Respuesta,'N');
              END loop;

              IF (tpor IN ('5','6')) OR (tpor = 'N') THEN
                nreg := 1;
                --Si entro aqui es porque toca seguir reportandola por lo tanto no se excluye y que siga el proceso normal
              ELSE
                nreg := 0;
              END IF;

              if nreg = 0 then
                -- No debe reportar porque ya se un periodo anterior se reporto con tipo respuesta diferente a 5 o 6
                pkg_Traza.Trace('No debe procesarlo, Se reporto en Periodo Anterior con Tipo Respuesta diferente a 5 o 6: ' || rcPQR.package_id);
                goto NO_REPORTA;
              END if;

            END IF;

            rccuOrdenesResp := NULL;

            --Obtener Ordenes de Respuesta
            open cuOrdenesResp(rcInteraccion.package_id);
            fetch cuOrdenesResp
              INTO rccuOrdenesResp;
            close cuOrdenesResp;

            --Obtener Ordenes de la solicitud principal. 16/04/2015 Ing Francisco Romero - Ludycom(Proyecto peti)
            rccuOrdenesSol := NULL;
            open cuOrdenesSol(rcPQR.Package_Id);
            fetch cuOrdenesSol
              INTO rccuOrdenesSol;
            close cuOrdenesSol;

            -- Obtenemos el tipo de unidad de trabajo
             rccutipounidoper := NULL;
            open cutipounidoper(rcPQR.Package_Id);
            fetch cutipounidoper
              INTO rccutipounidoper;
            close cutipounidoper;


            rcLDC_DETAREPOATECLI.DETAREPOATECLI_ID := GetIdDetalleReporte;
            pkg_Traza.Trace('Detalle Id Usado: '||rcLDC_DETAREPOATECLI.DETAREPOATECLI_ID,10);
            pkg_Traza.Trace('Reporte Id Usado: '||rcLDC_DETAREPOATECLI.ATECLIREPO_ID,10);

            --Aqui se arma el codigo de dane tomado de la tbla LDC_EQUIVA_LOCALIDAD dada la localidad, esta tabla
            --se alimenta atraves de la opcion de smartflex LDCDANE
            if DALDC_EQUIVA_LOCALIDAD.fblExist(rcPQR.GEOGRAP_LOCATION_ID) then
                rcLDC_EQUIVA_LOCALIDAD := DALDC_EQUIVA_LOCALIDAD.frcGetRecord(rcPQR.GEOGRAP_LOCATION_ID);
                blExiste := TRUE;
            else
                blExiste := FALSE;
            END if;
            --Si encontro el codigo dane en la instruccion anterior entonces se muestra sino ERROR
            if blExiste then
                rcLDC_DETAREPOATECLI.CODIGO_DANE   := rcLDC_EQUIVA_LOCALIDAD.departamento||
                                        rcLDC_EQUIVA_LOCALIDAD.municipio||
                                        rcLDC_EQUIVA_LOCALIDAD.poblacion;

            else
                rcLDC_DETAREPOATECLI.CODIGO_DANE := 'ERROR';
            END if;

            rcLDC_DETAREPOATECLI.SERVICIO   := '5';

            rcLDC_DETAREPOATECLI.FECHA_REGISTRO := to_char(rcPQR.request_date,'DD-MM-YYYY');

            /*
            Detalle se obtiene de la tabla que define la resolucion, se obtiene deacuerdo al tipo de causal
            */
            rcLDC_DETAREPOATECLI.CAUSAL := 'ERROR';
            rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := NULL;

            if DALDC_EQUI_PACKTYPE_SSPD.fblExist(rcPQR.PACKAGE_type_id) then
                rcLDC_EQUI_PACKTYPE_SSPD := DALDC_EQUI_PACKTYPE_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id);
                rcLDC_DETAREPOATECLI.CAUSAL := DALDC_CAUSAL_SSPD.fnuGetCAUSAL_ID(rcLDC_EQUI_PACKTYPE_SSPD.CAUSAL_SSPD_ID);
            END if;


        ------------NUEVO MANEJO DEL TIPO DE RESPUESTA--------------------------------
        ------------------------------------------------------------------------------
        -- 28/05/2015 - Ing.Francisco Romero - Ludycom-Redi
        -- Medio escrito:
        IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' THEN
          IF rcPQR.Motive_Status_Id = 14 THEN
            IF (rccuOrdenesResp.order_id IS NULL OR
                rccuOrdenesResp.legalization_date IS NULL) THEN
                rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
                rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
                rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
                rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
                rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
                rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
            ELSE
                IF DALDC_EQUIVALENCIA_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                    rcPQR.answer_id) then
                  rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                                  rcPQR.answer_id);
                  rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(rcLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA);

                END IF;
            END IF;
          ELSE
            rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          END IF;
        ELSE
          -- Medio verbal:
          IF rcPQR.Motive_Status_Id = 14 THEN
            IF DALDC_EQUIVALENCIA_SSPD.fblExist(rcPQR.PACKAGE_type_id,
                                                rcPQR.answer_id) then
              rcLDC_EQUIVALENCIA_SSPD := DALDC_EQUIVALENCIA_SSPD.frcGetRecord(rcPQR.PACKAGE_type_id,
                                                                              rcPQR.answer_id);
              rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := DALDC_TIPO_RESPUESTA.fnuGetSSPD_RESPUESTA(rcLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA);

            END IF;
          ELSE
            rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 9;
            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.TIPO_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          END IF;
        END IF;

        --28/05/2015 - Agregado por Ing.Francisco Romero Romero, Ludycom-Redi
        --Si Tipo respuesta es nula aun entonces se marca en cero Para avisarle al usuario que hay un error
        --en la solicitud rcPQR.answer_id en nulo ya que este se requiere para ir a las equivalencias o simplemente
        --no hay equivalencia parametrizada en LDCGAS, tambien puede ser por error de smartflex al no actualizar
        --correctamente los estados de las solicitudes o interacciones
        IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA IS NULL THEN
          rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 0;
        END IF;
        ------------------------------------------------------------------------------

        ------------inicia calculo de fecha de respuesta---------------
        rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := NULL;

        --Validacion del fecha de respuesta
        IF dage_reception_type.fblexist(rcInteraccion.reception_type_id) THEN
          --<<
          --Las solicitudes escritas validan su fecha desde as orden de trabajo de
          -- de generacion de documento de respuesta. las verbales deben tomar la fecha de atencion
          --de la interaccion o el tipo fecha 15(FECHA DE SURTIDA NOTIFICACION)
          -->>
          IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' then
            -- Escrito
            IF (rccuOrdenesResp.order_id IS NOT NULL AND
               rccuOrdenesResp.legalization_date IS NOT NULL) then
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := to_char(rccuOrdenesResp.Execution_Final_Date,--legalization_date,
                                                              'DD-MM-YYYY');
            ELSE
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            END IF;
          ELSE
            -- Verbal
            IF pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14 then
              --Incluido por Ing.Francisco Romero, 16/04/2015, Ludycom(proyecto peti)
              IF (rccuOrdenesSol.Execution_Final_Date IS NOT NULL) then
                rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := to_char(rccuOrdenesSol.Execution_Final_Date,
                                                                'DD-MM-YYYY');
              ELSE
                rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := to_char(rcPQR.Attention_Date,'DD-MM-YYYY');
              END IF;

            END IF;
          END IF; --Validacion de medio escrito
          --END IF;
        END IF;

        /*
        --Sevalida que la fecha de respuesta no este  NULL
        */
        IF (rcLDC_DETAREPOATECLI.FECHA_RESPUESTA IS NULL) THEN
          -->>
          --Se valida que el tipo de respuesta sea 5 o 6, en el caso de
          --que la interacion este en estado registrado tambien se debe
          --agregar la fecha de respuesta con N
          -->>
          IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA IN (5, 6) THEN
            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
          ELSE
            IF (pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 13) THEN
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
            ELSE
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := NULL;
            END IF;
          END IF;
        END IF;
        ------------cierra calculo de fecha de respuesta---------------


        IF rcPQR.subscription_id IS null THEN
            rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION := rcPQR.Identification;
        ELSE
            rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION := rcPQR.subscription_id;
        END IF;

        ------------inicia calculo de radicado de respuesta---------------
        IF dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) = 'Y' then
          -- Escrito
          IF (rccuOrdenesResp.order_id IS NOT NULL AND
             rccuOrdenesResp.legalization_date IS NOT NULL) THEN

            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES       := 'N';
            IF nuAtExpe = 'S' THEN
              rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                      15,
                                                      to_date(to_char(SYSDATE,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')); -- tipo 15
            ELSE
              rcFechaAdicionales := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                      15,
                                                      dtFechaFin); -- tipo 15
            END IF;
            rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;

            if rcFechaAdicionales.request_id IS not null then
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rcFechaAdicionales.NEW_DATE,
                                                                 'DD-MM-YYYY');

            END if;
            --rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
          ELSE
            if rcLDC_DETAREPOATECLI.TIPO_RESPUESTA in (5, 6) OR
               pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 13 THEN
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            else
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            END if;
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
          END IF;
        ELSE
          ---Para medios Verbales
          IF (pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14) THEN


            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
            rcLDC_DETAREPOATECLI.RADICADO_RES       := 'N';
            rcFechaAdicionales                      := GetFechaAdicional(rcPQR.CUST_CARE_REQUES_NUM,
                                                                         15,
                                                                         dtFechaFin); -- tipo 15
            if rcFechaAdicionales.request_id IS not null then
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rcFechaAdicionales.NEW_DATE,
                                                                 'DD-MM-YYYY');
              rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
            END if;

            --Incluido por Ing.Francisco Romero, 16/04/2015, Ludycom(proyecto peti)
            IF (rccuOrdenesSol.Execution_Final_Date IS NOT NULL) then
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rccuOrdenesSol.Execution_Final_Date,
                                                              'DD-MM-YYYY');
              rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
            ELSE
              rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := to_char(rcPQR.Attention_Date,'DD-MM-YYYY');
              rcLDC_DETAREPOATECLI.RADICADO_RES       := rcPQR.CUST_CARE_REQUES_NUM;
            END IF;

          ELSE
            if rcLDC_DETAREPOATECLI.TIPO_RESPUESTA in (5, 6) OR
               pkg_BCSolicitudes.fnuGetEstado(rcInteraccion.package_id) = 13 THEN
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            else
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
            END if;
            rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION := 'N';
          END IF;
        END IF;
        ------------cierra  calculo de radicado de respuesta---------------
        
        --<<
        --Fecha de tralado a la SSPD
        -->>
        rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA = 2 THEN
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := rcLDC_DETAREPOATECLI.FECHA_RESPUESTA;
        END IF;

        rcLDC_DETAREPOATECLI.FECHA_TRASLADO := rcLDC_DETAREPOATECLI.FECHA_NOTIFICACION;

        --------------------------------------------------------------------------------------------------
        --26/05/2015, Modificado por: ING.FRANCISCO ROMERO ROMERO, Ludycom-Redi
        IF nuAtExpe <> 'S' THEN
          --Si el estado es anulado tomo la fecha de anulacion del motivo
          IF rcPQR.Motive_Status_Id = 32 THEN
            dtFchaAt := rcPQR.Annul_Date;
          ELSE
            dtFchaAt := rcPQR.attention_date;
          END IF;

          --Aqui simplemente toda la poblacion de atendidas extraperiodos hacia adelante se muestran pendiente
          --para que en el mes siguiente(s) se procesen como atendidas, solo aplica para (GDO-STG)
          IF (dtFchaAt > to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss') AND rcPQR.Request_Date <= to_date(to_char(dtFechaFin,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')) THEN
              rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 5;
              rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
              rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
              rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
          END IF;
        END IF;
        --------------------------------------------------------------------------------------------------
        --26/05/2015, Modificado por: ING.FRANCISCO ROMERO ROMERO, Ludycom-Redi
        --Si ambas variables vienen en 1 es porque tienen causal 3230 o estan anuladas y toca reportarlas con
        --estas asignaciones:
        IF (nuProcesa = 1) AND (nreg = 1) AND (rcPQR.Motive_Status_Id <> 36) THEN
          rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 1;
          rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := TO_CHAR(rcPQR.Attention_Date,'DD-MM-YYYY');
          rcLDC_DETAREPOATECLI.RADICADO_RES := rcPQR.CUST_CARE_REQUES_NUM;
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END IF;
        --------------------------------------------------------------------------------------------------
        --Modificado por: ING.FRANCISCO ROMERO ROMERO 26/05/2015, Ludycom-Redi
        --Si esta en estado de anulacion se debe presentar como pendiente de respuesta:
        IF (rcPQR.Motive_Status_Id = 36) THEN
          rcLDC_DETAREPOATECLI.TIPO_RESPUESTA := 5;
          rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
          rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END IF;
        --------------------------------------------------------------------------------------------------
        --Modificado por: ING.FRANCISCO ROMERO ROMERO 28/05/2015, Ludycom-Redi
        --Si el tipo de respuesta viene en 5 estos campos van en N
        IF rcLDC_DETAREPOATECLI.TIPO_RESPUESTA = 5 THEN
          rcLDC_DETAREPOATECLI.FECHA_RESPUESTA := 'N';
          rcLDC_DETAREPOATECLI.RADICADO_RES := 'N';
          rcLDC_DETAREPOATECLI.FECHA_TRASLADO := 'N';
        END IF;
        --------------------------------------------------------------------------------------------------
        BEGIN
          SELECT TR.DESCRIPTION INTO sbTpoRta
          FROM CC_ANSWER_TYPE TR
          WHERE TR.ANSWER_TYPE_ID = rcPQR.Tpo_Rsta;
        EXCEPTION
          WHEN OTHERS THEN
            sbTpoRta := NULL;
        END;
        --------------------------------------------------------------------------------------------------
        BEGIN
          SELECT MR.DESCRIPTION INTO sbMdiRpc
          FROM GE_RECEPTION_TYPE MR
          WHERE MR.RECEPTION_TYPE_ID = rcPQR.Reception_Type_Id;
        EXCEPTION
          WHEN OTHERS THEN
            sbMdiRpc := NULL;
        END;
        --------------------------------------------------------------------------------------------------
        IF (dage_reception_type.fsbgetis_write(rcInteraccion.reception_type_id) <> 'Y') THEN
          IF (pkg_BCSolicitudes.fnuGetEstado(rcPQR.package_id) = 14) THEN
            BEGIN
              SELECT c.causal_id||' - '||c.description INTO sbCausal
                FROM OR_order a, OR_order_activity b, GE_Causal c
               WHERE a.order_id = b.order_id
                 AND b.PACKAGE_id = rcPQR.Package_Id
                 AND a.order_status_id = 8
                 AND b.instance_id is not null
                 AND c.causal_id = a.causal_id
                 AND a.Legalization_Date = rccuOrdenesSol.Execution_Final_Date;
            EXCEPTION
              WHEN OTHERS THEN
                sbCausal := NULL;
            END;
          END IF;
        END IF;
        --------------------------------------------------------------------------------------------------
        --Modificado por: ING.FRANCISCO ROMERO ROMERO 29/05/2015, Ludycom-Redi
        --Campos adicionales pedidos en el FANA
        rcLDC_DETAREPOATECLI.TIPO_SOLICITUD := rcPQR.Tpo_Sol;
        rcLDC_DETAREPOATECLI.ESTADO_SOLICITUD := rcPQR.Motive_Status_Id;
        rcLDC_DETAREPOATECLI.MEDIO_RECEPCION := rcPQR.Reception_Type_Id;
        rcLDC_DETAREPOATECLI.CAUSAL_ID := rcPQR.Package_Type_Id;
        rcLDC_DETAREPOATECLI.RESPUESTA_AT := rcPQR.Answer_Id;
        rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_OSF := NULL;
        rcLDC_DETAREPOATECLI.CAUSAL_LEGA_OT := NULL;
        rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL := sbTpoRta;
        rcLDC_DETAREPOATECLI.FECHA_SOLICITUD := TO_CHAR(rcPQR.Attention_Date,'DD-MM-YYYY');
        rcLDC_DETAREPOATECLI.PACKAGE_ID := rcPQR.Package_Id;
        --------------------------------------------------------------------------------------------------
    --ANEXO B
         sbsaliobsr := substr(REPLACE(rcPQR.Obssoli,',',' '),1,500);
          INSERT INTO anexoa VALUES(
                                  rcLDC_DETAREPOATECLI.CODIGO_DANE
                                 ,rcLDC_DETAREPOATECLI.Servicio
                                 ,rcLDC_DETAREPOATECLI.RADICADO_ING
                                 ,rcLDC_DETAREPOATECLI.FECHA_REGISTRO
                                 ,NULL
                                 ,rcLDC_DETAREPOATECLI.CAUSAL
                                 ,rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION
                                 ,NULL
                                 ,rcLDC_DETAREPOATECLI.TIPO_RESPUESTA
                                 ,rcLDC_DETAREPOATECLI.FECHA_RESPUESTA
                                 ,rcLDC_DETAREPOATECLI.RADICADO_RES
                                 ,NULL
                                 ,NULL
                                 ,rcLDC_DETAREPOATECLI.FECHA_TRASLADO
                                 ,rcLDC_DETAREPOATECLI.TIPO_SOLICITUD
                                 ,rcLDC_DETAREPOATECLI.ESTADO_SOLICITUD
                                 ,rcLDC_DETAREPOATECLI.MEDIO_RECEPCION
                                 ,rcLDC_DETAREPOATECLI.CAUSAL_ID
                                 ,rcLDC_DETAREPOATECLI.RESPUESTA_AT
                                 ,rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL
                                 ,rcLDC_DETAREPOATECLI.FECHA_SOLICITUD
                                 ,sbMdiRpc
                                 ,sbCausal
                                 ,rcPQR.Nombre_Solicitud
                                 ,rcPQR.Punto_Atencion
                                 ,rcPQR.Medio_Uso
                                 ,rccutipounidoper.desc_tu
                                 ,sbsaliobsr
                                 ,'B'
                               );

           nucont2 := nucont2 + 1;

        if nucont2 = 100 then
          commit;
          nucont3 := nucont3 + nucont2;
          nucont2 := 0;
        end if;

            sbLineaDeta :=  rcLDC_DETAREPOATECLI.CODIGO_DANE   ||csbSeparador||
                            rcLDC_DETAREPOATECLI.SERVICIO         ||csbSeparador||
                            rcLDC_DETAREPOATECLI.RADICADO_ING         ||csbSeparador||
                            rcLDC_DETAREPOATECLI.FECHA_REGISTRO   ||csbSeparador||
                            rcLDC_DETAREPOATECLI.CAUSAL   ||csbSeparador||
                            rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION       ||csbSeparador||
                            rcLDC_DETAREPOATECLI.TIPO_RESPUESTA   ||csbSeparador||
                            rcLDC_DETAREPOATECLI.FECHA_RESPUESTA   ||csbSeparador||
                            rcLDC_DETAREPOATECLI.RADICADO_RES ||csbSeparador||
                            rcLDC_DETAREPOATECLI.FECHA_TRASLADO ||
                            csbSeparador || rcLDC_DETAREPOATECLI.TIPO_SOLICITUD ||
                            csbSeparador || rcLDC_DETAREPOATECLI.ESTADO_SOLICITUD ||
                            csbSeparador || rcLDC_DETAREPOATECLI.MEDIO_RECEPCION ||
                            csbSeparador || rcLDC_DETAREPOATECLI.CAUSAL_ID ||
                            csbSeparador || rcLDC_DETAREPOATECLI.RESPUESTA_AT ||
                            csbSeparador || rcLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL ||
                            csbSeparador || rcLDC_DETAREPOATECLI.FECHA_SOLICITUD ||
                            csbSeparador || sbMdiRpc ||
                            csbSeparador || sbCausal ||
                            csbSeparador || rcPQR.Nombre_Solicitud ||
                            csbSeparador || rcPQR.Punto_Atencion   ||
                            csbSeparador || rcPQR.Medio_Uso        ||
                            csbSeparador || rccutipounidoper.desc_tu ||
                            csbSeparador || sbsaliobsr;

            impresion (vFile,sbLineaDeta);

            CreaDetalleReporte(rcLDC_DETAREPOATECLI);



        <<NO_REPORTA>>
        null;
        END loop;

        -- Verifica si existen datos correctos sin bajar a disco
        if ( gsbAuxLine IS NOT NULL ) then
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        --pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sysdate);
        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );


        sbAsunto := 'FORMATO B - '||sbFile;
        sbMensaje := 'Reporte FORMATO B - Peticiones '||nuAno||'  '||nuMes;

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbE_MAIL,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );

        if nucont2 < 100 then
            nucont3 := nucont3 + nucont2;
        end if;
        commit;
        ldc_proactualizaestaprog(nusession,'Proceso terminó Ok. Se procesarón : '||to_char(nucont3)||' registros.','FORMATO_B_PETICIONES','Termino ');

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
          ldc_proactualizaestaprog(nusession,SQLERRM||' SOLI : '||TO_CHAR(nupakgsoliproc),'FORMATO_B_PETICIONES','Termino ');
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
          ldc_proactualizaestaprog(nusession,SQLERRM||' SOLI : '||TO_CHAR(nupakgsoliproc),'FORMATO_B_PETICIONES','Termino ');
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END Formato_B_Peticiones; -- Reporte de ley Formato_A_Reclamaciones

    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

        Package  : LDC_RepLeyVentaAteClie
        Descripcion  : RESOLUCION 20061300002305 DE 2006
        I - TANSUCA

        Autor  : Carlos Andres Dominguez Naranjo
        Fecha  : 11-10-2013

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
        -----------  -------------------    -------------------------------------
        11-10-2013    cdominguez        Creacion
        18-03-2014    Arquitecsoft/mmoreno  - Se ajusta el reporte para que solo tenga
                                            en cuenta para las variables 1 y 2 Se genera para
                                            solo para los tipos de paquete (100030),
                                            - Se ajusta el reporte para que solo tenga
                                            en cuenta para la variable 4 se genere solo
                                            para los tipos de paquete (100030,545).
        02/12/2014    llarrarte.Cambio5625  Se modifica el procedimiento Formato_I_Itansuca
                                            para que permita generar el reporte tanto para ASNE como ASE
    ******************************************************************/
    PROCEDURE Formato_I_Itansuca IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Formato_I_Itansuca';
        
        vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
        sbLineaDeta varchar2(2000);
        nuIndex number;
        salida number := 0;
        dtFechaIni date;
        dtFechaFin date;
        nuAno number;
        nuMes number;
        nuTotalItansuca number;

        /* Valores definidos en la ejecucion LDRSUIA*/
        sbINSISTENTLY_COUNTER ge_boInstanceControl.stysbValue; -- Año
        sbNUMBER_OF_PROD ge_boInstanceControl.stysbValue;      -- Mes
        sbPATH_IN ge_boInstanceControl.stysbValue; --Path
        sbE_MAIL ge_boInstanceControl.stysbValue; -- E-Mail
        sbAREA ge_boInstanceControl.stysbValue; --  Area

        nuReclaxServ number;
        nuTieProReclaServ number;
        nuReclaFact number;
        nuUsuReclaFact number;

        --Reclamos por servicio
        --a favor del suscriptor
        CURSOR cuReclaxServ (nuMes number , nuAno number , sbArea varchar2) IS
            SELECT count(1)
            FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
            WHERE c.mes_reporte = nuMes
            AND c.ano_reporte = nuAno
            AND c.tipo_reporte = 'A'
            AND a.ateclirepo_id = c.ateclirepo_id
            AND b.package_id = a.radicado_ing
            AND tipo_respuesta in ( 1, 2 )
            AND causal not in (12)
            --<<
            -- Fecha: 18-03-2014
            -- Aranda:
            -- Autor: mmoreno
            -- Desc: Se modifica la condicion para que solo tenga en cuenta el tipo de
            -- paquete 100030 - Registro de quejas
            -->>
                AND b.package_type_id IN (100030
                                          )
            AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                FROM ldc_equiva_localidad
                                WHERE SERVICIOEXCLU=sbArea
                              );

        --Tiempo promedio de solucion
        --de reclamos por servicio
        CURSOR cuTieProReclaServ (nuMes number , nuAno number, sbArea varchar2) IS
        SELECT Round(Sum(tiempo_ate)/Count(1),2)
        FROM
        (
        SELECT  b.package_id,
                          (CASE  WHEN round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    = 0 then 1
                    else  round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    end )
                tiempo_ate
                FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
                WHERE c.mes_reporte = nuMes
                AND c.ano_reporte = nuAno
                AND c.tipo_reporte = 'A'
                AND a.ateclirepo_id = c.ateclirepo_id
                AND b.package_id = a.radicado_ing
                AND tipo_respuesta in ( 1, 2 )
                AND causal not in (12)
                AND b.package_type_id IN 
                (
                    SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_PAQUETES_QUEJAS'),'[^,]+', 1,LEVEL))
                    FROM dual
                    CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_PAQUETES_QUEJAS'), '[^,]+', 1, LEVEL) IS NOT NULL
                )
                AND flag_reporta = 'S'
                AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                    FROM ldc_equiva_localidad
                                  WHERE SERVICIOEXCLU=sbArea
                                )

        );


        --Reclamos por facturacion a favor del suscriptor
        CURSOR cuReclaFact (nuMes number , nuAno number, sbArea varchar2) IS
            SELECT count(1)
            FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
            WHERE c.mes_reporte = nuMes
            AND c.ano_reporte = nuAno
            AND c.tipo_reporte = 'A'
            AND a.ateclirepo_id = c.ateclirepo_id
            AND b.package_id = a.radicado_ing
            AND tipo_respuesta in ( 1, 2 )
            AND b.package_type_id in( 545 )
            AND flag_reporta = 'S'
            AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                FROM ldc_equiva_localidad
                                WHERE SERVICIOEXCLU=sbArea
                              );

        --Numero de usuarios con reclamos por facturacion
        --y por servicio
        CURSOR cuUsuReclaFact (nuMes number , nuAno number, sbArea varchar2) IS
            SELECT count(1) FROM
            (SELECT b.*
            FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
            WHERE c.mes_reporte = nuMes
              AND c.ano_reporte = nuAno
              AND c.tipo_reporte = 'A'
              AND a.ateclirepo_id = c.ateclirepo_id
              AND b.package_id = a.radicado_ing
              AND tipo_respuesta in ( 10 )
              --<<
              -- Fecha: 18-03-2014
              -- Aranda:
              -- Autor: mmoreno
              -- Desc: Se adiciona la condicion para que solo tenga en cuenta los tipos de
              -- respuesta 1 y 2
              -- de igual manera se modifica la condicion para que tenga en cuenta el tipo de
              -- paquete 100030 - Registro de quejas
              -->>
              AND b.package_type_id in(545,100030)
              AND flag_reporta = 'S'
              AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                     FROM ldc_equiva_localidad
                                    WHERE SERVICIOEXCLU=sbArea
                                  )
            );

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        Initialize;

        sbINSISTENTLY_COUNTER := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'INSISTENTLY_COUNTER');
        sbNUMBER_OF_PROD := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'NUMBER_OF_PROD');
        sbPATH_IN := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
        sbE_MAIL := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');
        sbAREA :=  ge_boInstanceControl.fsbGetFieldValue ('LDC_EQUIVA_LOCALIDAD', 'SERVICIOEXCLU');

        if (sbINSISTENTLY_COUNTER is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Año de generacion');
        end if;

        if (sbAREA is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Area');
        end if;

        if (sbNUMBER_OF_PROD is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Mes de generacion');
        end if;

        if (sbPATH_IN is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Ruta Del Directorio');
        end if;

        if (sbE_MAIL is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Correo de entrega');
        end if;

        sbPath := pkg_BCDirectorios.fsbGetRuta(sbPATH_IN);
        nuAno := to_number(sbINSISTENTLY_COUNTER);

        if nuAno < 1950 OR nuAno > 2150 then
            pkg_Error.setErrorMessage (114646, 'Año de generacion');
        END if;

        dtFechaIni := to_date('01-'||sbNUMBER_OF_PROD||'-'||sbINSISTENTLY_COUNTER||' 00:00:00');
        dtFechaFin := to_date(to_char(last_day(to_date(dtFechaIni)),'DD')||to_char(to_date(dtFechaIni),'MM')||'-'||to_char(to_date(dtFechaIni),'YYYY')||'23:59:59');

        validate(dtFechaIni, dtFechaFin);

        nuAno := to_char(dtFechaIni,'YYYY');
        nuMes := to_char(dtFechaIni,'MM');

        rcLDC_ATECLIREPO := null;
        open cuValidaRepo (nuAno, nuMes, 'I');
        fetch cuValidaRepo INTO rcLDC_ATECLIREPO;
        close cuValidaRepo;

        if rcLDC_ATECLIREPO.ATECLIREPO_ID IS not null then
            if rcLDC_ATECLIREPO.APROBADO = 'S' then
                -- Debe generar reporte del historico
                pkg_Traza.Trace('Regenera desde BD con ID: '||rcLDC_ATECLIREPO.ATECLIREPO_ID,10);
                ReGeneraReporteI(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL);
                return;
            else
                -- obtiene id reporte
                rcLDC_DETAREPOATECLI.ATECLIREPO_ID := rcLDC_ATECLIREPO.ATECLIREPO_ID;
                -- borra detalle reporte
                begin
                pkg_Traza.Trace('borra detalle con id '||rcLDC_DETAREPOATECLI.ATECLIREPO_ID,10);
                    DELETE LDC_DETAREPOATECLI
                    WHERE ATECLIREPO_ID = rcLDC_DETAREPOATECLI.ATECLIREPO_ID;
                    commit;
                EXCEPTION when others then
                    null;
                END;
            END if;
        else
            rcLDC_ATECLIREPO.ATECLIREPO_ID := GetIdReporte;
            rcLDC_DETAREPOATECLI.ATECLIREPO_ID := rcLDC_ATECLIREPO.ATECLIREPO_ID;
            rcLDC_ATECLIREPO.TIPO_REPORTE := 'I';
            rcLDC_ATECLIREPO.ANO_REPORTE := nuAno;
            rcLDC_ATECLIREPO.MES_REPORTE := nuMes;
            rcLDC_ATECLIREPO.FECHA_APROBACION := NULL;
            rcLDC_ATECLIREPO.APROBADO := 'N';

            -- Crea Encabezado de reporte
            CreaReporte(rcLDC_ATECLIREPO);

        END if;

        sbFile := 'Formato_Itansuca_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';

        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                  sbPath,
                                  sbFile,
                                  'W');
        sbLineaDeta := 'RECLAMOS X SERVICIO,TIEMPO PROMEDIO,RECLAMOS X FACTURACION,NO USUARIOS CON RECLAMO';--||sbLineFeed;

        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := null;
        nuTotalItansuca :=0;

        open cuReclaxServ(nuMes, nuAno, sbAREA);
        fetch cuReclaxServ INTO nuReclaxServ;
        close cuReclaxServ;

        open cuTieProReclaServ(nuMes, nuAno,sbAREA);
        fetch cuTieProReclaServ INTO nuTieProReclaServ;
        close cuTieProReclaServ;

        open cuReclaFact(nuMes, nuAno, sbAREA);
        fetch cuReclaFact INTO nuReclaFact;
        close cuReclaFact;

        open cuUsuReclaFact(nuMes, nuAno, sbAREA);
        fetch cuUsuReclaFact INTO nuUsuReclaFact;
        close cuUsuReclaFact;


        IF nuTieProReclaServ > 0 then
            --nuTotalItansuca := nuTieProReclaServ/nuReclaxServ;
            nuTotalItansuca := nuTieProReclaServ;
        END if;

        rcLDC_DETAREPOATECLI.DETAREPOATECLI_ID := GetIdDetalleReporte;
        rcLDC_DETAREPOATECLI.RADICADO_ING := nuReclaxServ;
        rcLDC_DETAREPOATECLI.CAUSAL := nuReclaFact;
        rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION := nuUsuReclaFact;
        rcLDC_DETAREPOATECLI.RADICADO_RES := nuTotalItansuca;


        sbLineaDeta := rcLDC_DETAREPOATECLI.RADICADO_ING         ||csbSeparador||
                    rcLDC_DETAREPOATECLI.RADICADO_RES ||csbSeparador||
                    rcLDC_DETAREPOATECLI.CAUSAL ||csbSeparador||
                    rcLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION;

        impresion (vFile,sbLineaDeta);

        CreaDetalleReporte(rcLDC_DETAREPOATECLI);

        -- Verifica si existen datos correctos sin bajar a disco
        if ( gsbAuxLine IS NOT NULL ) then
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        --pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sysdate);
        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );

        sbAsunto := 'ITANSUCA - '||sbFile;
        sbMensaje := 'Reporte ITANSUCA '||nuAno||'  '||nuMes;

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbE_MAIL,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );

           --<<
           --
           --
           LDC_RepLeyVentaAteClie.Formato_I_ItansucaDet;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END Formato_I_Itansuca; -- Reporte de ley Formato_I_Itansuca

    PROCEDURE Aprobacion IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Aprobacion';
        
        sbINSISTENTLY_COUNTER ge_boInstanceControl.stysbValue;
        sbNUMBER_OF_PROD ge_boInstanceControl.stysbValue;
        sbCLIENT_PRIVACY_FLAG ge_boInstanceControl.stysbValue;
        sbPATH_IN ge_boInstanceControl.stysbValue; --Path
        sbE_MAIL ge_boInstanceControl.stysbValue; -- E-Mail

        dtFechaIni date;
        dtFechaFin date;
        nuAno number;
        nuMes number;
        nuTrimestre number;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        Initialize;

        sbINSISTENTLY_COUNTER := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'INSISTENTLY_COUNTER');
        sbNUMBER_OF_PROD := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'NUMBER_OF_PROD');
        sbCLIENT_PRIVACY_FLAG := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'CLIENT_PRIVACY_FLAG');
        sbPATH_IN := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
        sbE_MAIL := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbINSISTENTLY_COUNTER is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Año de generacion');
        end if;

        if (sbNUMBER_OF_PROD is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Periodo de generacion');
        end if;

        if (sbCLIENT_PRIVACY_FLAG is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Tipo de reporte');
        end if;

        if (sbPATH_IN is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Ruta Del Directorio');
        end if;

        if (sbE_MAIL is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Correo de entrega');
        end if;

        sbPath := pkg_BCDirectorios.fsbGetRuta(sbPATH_IN);
        dtFechaIni := to_date('01-'||sbNUMBER_OF_PROD||'-'||sbINSISTENTLY_COUNTER||' 00:00:00');
        dtFechaFin := to_date(to_char(last_day(to_date(dtFechaIni)),'DD')||to_char(to_date(dtFechaIni),'MM')||'-'||to_char(to_date(dtFechaIni),'YYYY')||'23:59:59');

        validate(dtFechaIni, dtFechaFin);

        nuAno := to_char(dtFechaIni,'YYYY');
        nuMes := to_char(dtFechaIni,'MM');

        if nuAno < 1950 OR nuAno > 2150 then
            pkg_Error.setErrorMessage (114646, 'Año de generacion');
        END if;

        if sbCLIENT_PRIVACY_FLAG = 'B' then
            nuTrimestre := to_number(sbNUMBER_OF_PROD);

            case nuTrimestre  -- Valida trimestre
                when  1 then
                    dtFechaIni := to_date('01-01-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                    dtFechaFin := to_date(
                                      to_char(last_day(to_date('01-03-'||sbINSISTENTLY_COUNTER)),'DD')||
                                      to_char(to_date('01-03-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                      to_char(to_date('01-03-'||sbINSISTENTLY_COUNTER),'YYYY')
                                  ||'23:59:59');
                when 2 then
                    dtFechaIni := to_date('01-04-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                    dtFechaFin := to_date(
                                      to_char(last_day(to_date('01-06-'||sbINSISTENTLY_COUNTER)),'DD')||
                                      to_char(to_date('01-06-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                      to_char(to_date('01-06-'||sbINSISTENTLY_COUNTER),'YYYY')
                                  ||'23:59:59');
                when 3 then
                    dtFechaIni := to_date('01-07-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                    dtFechaFin := to_date(
                                      to_char(last_day(to_date('01-09-'||sbINSISTENTLY_COUNTER)),'DD')||
                                      to_char(to_date('01-09-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                      to_char(to_date('01-09-'||sbINSISTENTLY_COUNTER),'YYYY')
                                  ||'23:59:59');
                when 4 then
                    dtFechaIni := to_date('01-10-'||sbINSISTENTLY_COUNTER||' 00:00:00');
                    dtFechaFin := to_date(
                                      to_char(last_day(to_date('01-12-'||sbINSISTENTLY_COUNTER)),'DD')||
                                      to_char(to_date('01-12-'||sbINSISTENTLY_COUNTER),'MM')||'-'||
                                      to_char(to_date('01-12-'||sbINSISTENTLY_COUNTER),'YYYY')
                                  ||'23:59:59');
                else
                    pkg_Traza.Trace('No se puede generar reporte para el trimestre  '||nuTrimestre,10);
                    pkg_Error.setErrorMessage(isbMsgErrr => 'No se encontraron registros para el proceso.');                     
           END case;
        END if;

        rcLDC_ATECLIREPO := null;
        open cuValidaRepo (nuAno, nuMes, sbCLIENT_PRIVACY_FLAG);
        fetch cuValidaRepo INTO rcLDC_ATECLIREPO;
        close cuValidaRepo;

        pkg_Traza.Trace('Fecha de proceso inicial, final  '||dtFechaIni||'  '||dtFechaFin,10);

        if rcLDC_ATECLIREPO.ATECLIREPO_ID IS not null then
            if rcLDC_ATECLIREPO.APROBADO = 'S' then
                -- Debe generar reporte del historico
                pkg_Traza.Trace('Regenera desde BD con ID: '||rcLDC_ATECLIREPO.ATECLIREPO_ID||' '||sbCLIENT_PRIVACY_FLAG||'  '||nuAno||'  '||nuMes,10);
                if sbCLIENT_PRIVACY_FLAG = 'A' then
                    ReGeneraReporteA(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL,'Aprobado_');
                END if;
                if sbCLIENT_PRIVACY_FLAG = 'B' then
                    ReGeneraReporteB(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL,'Aprobado_');
                END if;
                if sbCLIENT_PRIVACY_FLAG = 'I' then
                    ReGeneraReporteI(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL,'Aprobado_');
                END if;
            else
                pkg_Traza.Trace('El reporte no esta aprobado '||rcLDC_ATECLIREPO.ATECLIREPO_ID,10);
                -- Actualiza reporte aprobado y genera archivo
                UpdateReporte(rcLDC_ATECLIREPO.ATECLIREPO_ID,'S');

                if sbCLIENT_PRIVACY_FLAG = 'A' then
                    ReGeneraReporteA(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL,'Aprobado_');
                END if;
                if sbCLIENT_PRIVACY_FLAG = 'B' then
                    ReGeneraReporteB(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL,'Aprobado_');
                END if;
                if sbCLIENT_PRIVACY_FLAG = 'I' then
                    ReGeneraReporteI(rcLDC_ATECLIREPO.ATECLIREPO_ID,nuAno, nuMes,sbE_MAIL,'Aprobado_');
                END if;

                GuardaConfiguracion(rcLDC_ATECLIREPO.ATECLIREPO_ID);

            END if;
        else
            pkg_Traza.Trace('No se encontraron registros para el proceso',10);
            pkg_Error.setErrorMessage(isbMsgErrr => 'No se encontraron registros para el proceso');
        END if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END Aprobacion; -- Aprobacion de Reporte de ley

    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

        Package  : LDC_RepLeyVentaAteClie
        Descripcion  : RESOLUCION 20061300002305 DE 2006
        I - TANSUCA

        Autor  : Carlos Andres Dominguez Naranjo
        Fecha  : 11-10-2013

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
        -----------  -------------------    -------------------------------------
        11-10-2013    cdominguez            Creacion
        18-03-2014    Arquitecsoft/mmoreno  - Se ajusta el reporte para que solo tenga
                                            en cuenta para las variables 1 y 2 Se genera para
                                            solo para los tipos de paquete (100030),
                                            - Se ajusta el reporte para que solo tenga
                                            en cuenta para la variable 4 se genere solo
                                            para los tipos de paquete (100030,545).
    ******************************************************************/
    PROCEDURE Formato_I_ItansucaDet IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'Formato_I_ItansucaDet';
        
        vFile       pkg_gestionArchivos.styArchivo; -- Archivo de salida
        sbLineaDeta varchar2(2000);
        nuIndex number;
        salida number := 0;
        dtFechaIni date;
        dtFechaFin date;
        nuAno number;
        nuMes number;
        nuTotalItansuca number;

        /* Valores definidos en la ejecucion LDRSUIA*/
        sbINSISTENTLY_COUNTER ge_boInstanceControl.stysbValue; -- Año
        sbNUMBER_OF_PROD ge_boInstanceControl.stysbValue;      -- Mes
        sbPATH_IN ge_boInstanceControl.stysbValue; --Path
        sbE_MAIL ge_boInstanceControl.stysbValue; -- E-Mail
        sbAREA ge_boInstanceControl.stysbValue; --  Area

        nuReclaxServ number;
        nuTieProReclaServ number;
        nuReclaFact number;
        nuUsuReclaFact number;

        --<<
        --Datos detallados del reporte
        --ITANSUCA
        -->>
        CURSOR cuDatosRepItensuca (nuMes number , nuAno number , sbArea varchar2) IS
            SELECT a.codigo_dane,
                   SubStr(a.codigo_dane,0,3) DEPA,
                   SubStr(a.codigo_dane,4,3) LOCA,
                   SubStr(a.codigo_dane,7,3) POBL,
                   b.package_id PAQUETE,
                   package_type_id TIPO_PAQUETE,
                   b.request_date FECHA_REGISTRO,
                   b.ATTENTION_DATE FECHA_ATENCION,
              (CASE  WHEN round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    = 0 then 1
                    else  round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    end )   dias_habiles_Solicitud,
                 'X'  VARIABLE_1,
                 'X'  VARIABLE_2,
                 ''   VARIABLE_3,
                 ''   VARIABLE_4
            FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
            WHERE c.mes_reporte = nuMes
            AND c.ano_reporte = nuAno
            AND c.tipo_reporte = 'A'
            AND a.ateclirepo_id = c.ateclirepo_id
            AND b.package_id = a.radicado_ing
            AND tipo_respuesta in ( 1, 2 )
            AND causal not in (12)
            --<<
            -- Fecha: 18-03-2014
            -- Aranda: 94489
            -- Autor: mmoreno
            -- Desc: Se modifica la condicion para que solo tenga en cuenta el tipo de
            -- paquete 100030 - Registro de quejas
            -->>
                AND b.package_type_id IN (100030
                                          )
            AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                FROM ldc_equiva_localidad
                                WHERE SERVICIOEXCLU=sbArea
                              )

            UNION
            SELECT a.codigo_dane,
                   SubStr(a.codigo_dane,0,3) DEPA,
                   SubStr(a.codigo_dane,4,3) LOCA,
                   SubStr(a.codigo_dane,7,3) POBL,
                   b.package_id PAQUETE,
                   package_type_id TIPO_PAQUETE,
                   b.request_date FECHA_REGISTRO,
                   b.ATTENTION_DATE FECHA_ATENCION,
              (CASE  WHEN round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    = 0 then 1
                    else  round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    end )   dias_habiles_Solicitud,
                 ''  VARIABLE_1,
                 ''  VARIABLE_2,
                 'X' VARIABLE_3,
                 ''  VARIABLE_4
            FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
            WHERE c.mes_reporte = nuMes
            AND c.ano_reporte = nuAno
            AND c.tipo_reporte = 'A'
            AND a.ateclirepo_id = c.ateclirepo_id
            AND b.package_id = a.radicado_ing
            AND tipo_respuesta in ( 1, 2 )
            AND b.package_type_id in( 545 )
            AND flag_reporta = 'S'
            AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                FROM ldc_equiva_localidad
                                WHERE SERVICIOEXCLU=sbArea
                              )

            UNION
             SELECT a.codigo_dane,
                   SubStr(a.codigo_dane,0,3) DEPA,
                   SubStr(a.codigo_dane,4,3) LOCA,
                   SubStr(a.codigo_dane,7,3) POBL,
                   b.package_id PAQUETE,

                   package_type_id TIPO_PAQUETE,
                   b.request_date FECHA_REGISTRO,
                   b.ATTENTION_DATE FECHA_ATENCION,
              (CASE  WHEN round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    = 0 then 1
                    else  round( (decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate) - b.request_date) -
                                    (select count(1) from ge_calendar gc
                                                where gc.date_ between b.request_date and decode(b.MOTIVE_STATUS_ID,14,b.ATTENTION_DATE,sysdate)
                                                and gc.laboral = 'N')    )
                    end )   dias_habiles_Solicitud,
                 ''  VARIABLE_1,
                 ''  VARIABLE_2,
                 '' VARIABLE_3,
                 'X'  VARIABLE_4
            FROM LDC_DETAREPOATECLI a, mo_packages b, LDC_ATECLIREPO c
            WHERE c.mes_reporte = nuMes
              AND c.ano_reporte = nuAno
              AND c.tipo_reporte = 'A'
              AND a.ateclirepo_id = c.ateclirepo_id
              AND b.package_id = a.radicado_ing
              AND tipo_respuesta in ( 10 )
              --<<
              -- Fecha: 18-03-2014
              -- Aranda: 94489
              -- Autor: mmoreno
              -- Desc: Se adiciona la condicion para que solo tenga en cuenta los tipos de
              -- respuesta 1 y 2
              -- de igual manera se modifica la condicion para que tenga en cuenta el tipo de
              -- paquete 100030 - Registro de quejas
              -->>
              AND b.package_type_id in(545,100030)
              AND  causal not in (12)
              AND flag_reporta = 'S'
              AND codigo_dane  IN (SELECT departamento||municipio||poblacion
                                  FROM ldc_equiva_localidad
                                 WHERE SERVICIOEXCLU=sbArea
                               );

           nuDias     NUMBER;
           nuCantidad NUMBER;
           nuPromDias NUMBER;
           sbTipoProducto VARCHAR2(60);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        Initialize;

        sbINSISTENTLY_COUNTER := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'INSISTENTLY_COUNTER');
        sbNUMBER_OF_PROD := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'NUMBER_OF_PROD');
        sbPATH_IN := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
        sbE_MAIL := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');
        sbAREA :=  ge_boInstanceControl.fsbGetFieldValue ('LDC_EQUIVA_LOCALIDAD', 'SERVICIOEXCLU');

        IF (sbINSISTENTLY_COUNTER is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Año de generacion');
        END IF;

        IF (sbNUMBER_OF_PROD is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Mes de generacion');
        END IF;

        if (sbPATH_IN is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Ruta Del Directorio');
        end if;

        if (sbE_MAIL is null) then
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Correo de entrega');
        end if;

        sbPath := pkg_BCDirectorios.fsbGetRuta(sbPATH_IN);
        nuAno := to_number(sbINSISTENTLY_COUNTER);

        if nuAno < 1950 OR nuAno > 2150 then
            pkg_Error.setErrorMessage (114646, 'Año de generacion');
        END if;

        dtFechaIni := to_date('01-'||sbNUMBER_OF_PROD||'-'||sbINSISTENTLY_COUNTER||' 00:00:00');
        dtFechaFin := to_date(to_char(last_day(to_date(dtFechaIni)),'DD')||to_char(to_date(dtFechaIni),'MM')||'-'||to_char(to_date(dtFechaIni),'YYYY')||'23:59:59');

        validate(dtFechaIni, dtFechaFin);

        nuAno := to_char(dtFechaIni,'YYYY');
        nuMes := to_char(dtFechaIni,'MM');

        sbFile := 'Formato_Detallado_Itansuca_'||nuAno||'_'||nuMes||'_'||To_Char(SYSDATE,'YYYY_MM_DD_HH_MI_SS')||'.csv';

        vFile := pkg_gestionArchivos.ftAbrirArchivo_SMF(
                                  sbPath,
                                  sbFile,
                                  'W');

        impresion(vFile,sbLineaDeta);

        sbLineaDeta := 'VARIABLE 1: Reclamos por servicio a favor del suscriptor';
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := 'VARIABLE 2: Tiempo promedio de solucion de reclamos por servicio [dias Habiles]';
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := 'VARIABLE 3: Reclamos por facturacion a favor del suscriptor';
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := 'VARIABLE 4: Numero de usuarios con reclamos por facturacion y por servicio';
        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);


        sbLineaDeta := 'DEPARTAMENTO'||csbSeparador||'LOCALIDAD'||csbSeparador||'POBLACION'||csbSeparador||
                       'SOLICITUD'||csbSeparador||'TIPO_SOLICITUD'||csbSeparador||'FECHA_REGISTRO'||csbSeparador||
                       'FECHA_ATENCION'||csbSeparador||'DIAS_HABILES_SOLICITUD'||csbSeparador||'TIPO_PRODUCTO'||csbSeparador||
                       'VARIABLE1'||csbSeparador||'VARIABLE2'||csbSeparador||'VARIABLE3'||csbSeparador||
                       'VARIABLE4';--||sbLineFeed;

        pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,sbLineaDeta);

        sbLineaDeta := null;
        nuTotalItansuca :=0;

        nuDias     :=0;
        nuCantidad :=0;
        nuPromDias :=0;

        FOR rtcuDatosRepItensuca IN cuDatosRepItensuca(nuMes, nuAno, sbArea) LOOP

            --<<
            --Obtener  tipo Producto
            -->>
            sbTipoProducto:= ObtenerTipoProducto(rtcuDatosRepItensuca.PAQUETE);

            -->>
            --Datos detallados
            -->>
          sbLineaDeta :=  rtcuDatosRepItensuca.DEPA||csbSeparador||
                      rtcuDatosRepItensuca.LOCA||csbSeparador||
                      rtcuDatosRepItensuca.POBL||csbSeparador||
                      rtcuDatosRepItensuca.PAQUETE||csbSeparador||
                      rtcuDatosRepItensuca.TIPO_PAQUETE||csbSeparador||
                      rtcuDatosRepItensuca.FECHA_REGISTRO||csbSeparador||
                      rtcuDatosRepItensuca.FECHA_ATENCION||csbSeparador||
                      rtcuDatosRepItensuca.DIAS_HABILES_SOLICITUD||csbSeparador||
                      sbTipoProducto||csbSeparador||
                      rtcuDatosRepItensuca.VARIABLE_1||csbSeparador||
                      rtcuDatosRepItensuca.VARIABLE_2||csbSeparador||
                      rtcuDatosRepItensuca.VARIABLE_3||csbSeparador||
                      rtcuDatosRepItensuca.VARIABLE_4;

          --Valida que el calculo solo sea para la variable 1
          IF(rtcuDatosRepItensuca.VARIABLE_1 = 'X')THEN
            --<<
            --Se suma los dias habiles para la variable  1
            -->>
            nuDias :=  nuDias + rtcuDatosRepItensuca.DIAS_HABILES_SOLICITUD;

            --<<
            --Se suma la cantidad de dias
            -->>
            nuCantidad := nuCantidad + 1;

          END IF;

          impresion(vFile,sbLineaDeta);

        END LOOP;

        IF(nuCantidad = 0)THEN
           nuCantidad := 1;
        END IF;
        --<<
        --Impresion de los totales de promedio de ITANSUCA
        -->>
        nuPromDias := Nvl(nuDias,1)/Nvl(nuCantidad,1);


        sbLineaDeta := ''||csbSeparador||
                      ''||csbSeparador||
                      ''||csbSeparador||
                      'Total Dias: '||csbSeparador||
                      nuDias||csbSeparador||
                      ' Total Cantidad: '||csbSeparador||
                      nuCantidad||csbSeparador||
                      ' Promedio: '||csbSeparador||
                      nuPromDias;

        impresion(vFile,sbLineaDeta);

        -- Verifica si existen datos correctos sin bajar a disco
        if ( gsbAuxLine IS NOT NULL ) then
        --{
            pkg_gestionArchivos.prcEscribirLinea_SMF(vFile,gsbAuxLine);
            gsbAuxLine  := null;
        --}
        END if;

        -- Cierra archivo de impresion
        pkg_gestionArchivos.prcCerrarArchivo_SMF( vFile );

        sbAsunto := 'Detallado de ITANSUCA - '||sbFile;
        sbMensaje := 'Reporte Detallado ITANSUCA '||nuAno||'  '||nuMes;

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbE_MAIL,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbPath || '/' || sbFile
        );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    EXCEPTION
          WHEN pkg_Error.CONTROLLED_ERROR THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
          WHEN OTHERS THEN
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END Formato_I_ItansucaDet; -- Reporte de ley Formato_I_ItansucaDet


    FUNCTION LDC_fnuValidaCausaOrden(inupackage_id mo_packages.package_id%TYPE) RETURN NUMBER
    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

    Package  : LDC_fnuValidaCausaOrden
    Descripcion  : Valida la existencia de una orden legalizada por la causas 3230

    Autor  : Arquitecsoft/mmoreno
    Fecha  : 11-03-2014

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
    -----------  -------------------    -------------------------------------
    03-08-2015   Ing.Francisco.Romero   Se garantiza que la causal que se esta evaluando sea sobre la orden
                                      que atiende la solicitud. Ludycom S.A.
                                      Que el campo instance_id no sea nulo y que la fecha legalizacion sea la max.

    ******************************************************************/

    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'LDC_fnuValidaCausaOrden';

        --<<
        -- Variables del proceso
        -->>
        nuExiste  NUMBER; -- Variable de retorno, 1: La orden existe 0 de modo contrario
        --<<
        -- Cursores del proceso
        -->>
        CURSOR cuValOrden IS
        SELECT Count(1)
        FROM or_order,
          or_order_activity
        WHERE or_order.order_id = or_order_activity.order_id
        AND or_order.order_status_id = 8
        AND or_order_activity.instance_id is not null
        AND or_order.Legalization_Date = (SELECT MAX(o.legalization_date)
                                          FROM or_order o,
                                               or_order_activity oa
                                         WHERE o.order_id = oa.order_id
                                           AND o.order_status_id = 8
                                           AND oa.instance_id IS NOT NULL
                                           AND oa.package_id = inupackage_id
                                           AND o.causal_id IN 
                                           (                                             
                                            SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('CAUSAL_LEGA_ERR_GC'),'[^,]+', 1,LEVEL))
                                            FROM dual
                                            CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('CAUSAL_LEGA_ERR_GC'), '[^,]+', 1, LEVEL) IS NOT NULL
                                          )
                                          )
        AND causal_id IN 
        ( 
            SELECT to_number(regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('CAUSAL_LEGA_ERR_GC'),'[^,]+', 1,LEVEL))
            FROM dual
            CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('CAUSAL_LEGA_ERR_GC'), '[^,]+', 1, LEVEL) IS NOT NULL
        )
        AND package_id = inupackage_id;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        --<<
        -- Obtiene la cantidad de ordenes legalizadas por causa 3230 del motivo ingresado
        -->>
        OPEN cuValOrden;
        FETCH cuValOrden INTO nuExiste;
        CLOSE cuValOrden;

        --<<
        -- Valida si la orden existe
        -->>
        IF nuExiste <> 0 THEN
          nuExiste := 1;
        END IF;
 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        RETURN nuExiste;
    END LDC_fnuValidaCausaOrden;

END LDC_RepLeyVentaAteClie;
/

