CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_ASIGDIRCONTRUCTORAS IS

    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  LDC_ASIGDIRCONTRUCTORAS
    Descripcion :
    Autor       : Alexandra Gordillo
    Fecha       : 22-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    22-05-2015          agordillo          Creacion.
    10-07-2015          Llozada            Se modifica el proceso <<processAssigAddress>>
    27-05-2024          jpinedc            OSF-2603: Se reemplaza LDC_ManagementEmailFNB.PROENVIARCHIVO
                                            por pkg_Correo.prcEnviaCorreo
    17-10-2024          PAcosta            OSF-3440: Implementar Gestión de Archivos
                                           Se actualizan los siguientes métodos: 
                                            frfgetDirecciones
                                            getLocalidad
                                            getDirPadre
                                            getBarrio
                                            processAssigAddress
    **************************************************************************/

    SBMENSAJEEMAIL  VARCHAR2(4000) := 'Adjunto esta el Log de Errores que se genera '||
                                      'despues de asignar masivamente las direcciones a la Solicitud: ';
    SBERRRORES      VARCHAR2(4000);

    SBFINMAIL       VARCHAR2(200) := 'Enviado desde SMARTFLEX [ASIMADI], por favor no responder a este mensaje. <br> '||
                                      ' **No se utilizan tildes ni caracteres especiales por compatibilidad';

    FUNCTION frfgetDirecciones RETURN CONSTANTS_PER.TYREFCURSOR;

    ----------------------------------------------------------------------------
    -- Variables para el Archivo
    ----------------------------------------------------------------------------
    ufArchivo               pkg_gestionArchivos.styArchivo;
    sbFileName              varchar2(200) := 'LOG_ASIMADI_'||to_char(sysdate,'DDMMYYYY_HH24MISS')||'.txt';
    sbLinea                 varchar(32000);
    sbHead                  varchar(32000);
    sbPath                  ge_boInstanceControl.stysbValue;
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Variables para el Correo
    ----------------------------------------------------------------------------
    sbE_MAIL                ge_boInstanceControl.stysbValue; -- E-Mail
    sbRemitente             varchar2(2000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    sbAsunto                varchar2(2000) := 'LDC - Log De Errores Asignacion Masiva de Direcciones';
    sbMensaje               varchar2(2000);
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Variables para el error
    ----------------------------------------------------------------------------
    nuErrorCode             number;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  processOrdenesMant
    Descripcion :
    Autor       : llozada
    Fecha       : 22-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-05-2014          llozada              Creaci?n.
    **************************************************************************/
    PROCEDURE processAssigAddress (inuAddressId     IN  ab_address.address_id%type,
                              inuRegistro   IN  number,
                              inuTotal      IN  number,
                              onuErrorCode  OUT number,
                              osbErrorMess  OUT varchar2);

    /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento:  getSectorOperativo
    Descripcion :   Permite carga la localidad dinamicamente de acuerdo
                    el criterio del departamento
    Autor       :   Llozada
    Fecha       :   23-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    23-05-2014          llozada              Creacion.
    ***************************************************************************/
    PROCEDURE getLocalidad(id in number, description in varchar2, rfQuery OUT CONSTANTS_PER.TYREFCURSOR);

    /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento:  getSectorOperativo
    Descripcion :   Permite cargar la direcci?n dinamicamente de acuerdo
                    el criterio de la localidad y departamento
    Autor       :   Llozada
    Fecha       :   23-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    23-05-2014          llozada              Creacion.
    ***************************************************************************/
    PROCEDURE getDirPadre(id in number, description in varchar2, rfQuery OUT CONSTANTS_PER.TYREFCURSOR);

    /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento:  getSectorOperativo
    Descripcion :   Permite cargar el barrio dinamicamente de acuerdo
                    el criterio de la localidad
    Autor       :   Llozada
    Fecha       :   23-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    23-05-2014          llozada              Creacion.
    ***************************************************************************/
    PROCEDURE getBarrio(id in number, description in varchar2, rfQuery OUT CONSTANTS_PER.TYREFCURSOR);

END LDC_ASIGDIRCONTRUCTORAS;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_ASIGDIRCONTRUCTORAS IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  LDC_ASIGDIRCONTRUCTORAS
    Descripcion :
    Autor       : Alexandra Gordillo
    Fecha       : 22-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    17-10-2024          PAcosta            OSF-3440: Implementar Gestión de Archivos
                                            Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                            Cambio DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID por PKG_BCDIRECCIONES.FNUGETLOCALIDAD
                                            Cambio DAAB_ADDRESS.FSBGETADDRESS_PARSED por PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA
                                            Cambio DAMO_PACKAGES.FNUGETMOTIVE_STATUS_ID por PKG_BCSOLICITUDES.FNUGETESTADO
                                            Cambio DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID por PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD
    10-07-2015          Llozada            Se modifica el proceso <<processAssigAddress>>
    22-05-2015          agordillo              Creacion.
    **************************************************************************/


    FUNCTION frfgetDirecciones
    RETURN CONSTANTS_PER.TYREFCURSOR IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'frfgetDirecciones';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    
        ocuCursor        CONSTANTS_PER.TYREFCURSOR;
        sbSql            varchar2(4000);
        sbDepartamento   ge_boInstanceControl.stysbValue;
        sbLocalidad      ge_boInstanceControl.stysbValue;
        sbBarrio         ge_boInstanceControl.stysbValue;
        sbMultifamiliar  ge_boInstanceControl.stysbValue;
        sbDirPadre       ge_boInstanceControl.stysbValue;
        sbSolicitud      ge_boInstanceControl.stysbValue;
        sbEmail          ge_boInstanceControl.stysbValue;

        sbSqlBarrio      varchar2(100);
        sbSqlDirPadre    varchar2(100);
        nuTypePack       mo_packages.package_type_id%type;
        nuStatePack      mo_packages.motive_status_id%type;
        nuSolicitud      mo_packages.package_id%type;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        sbDepartamento  := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');
        sbLocalidad     := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'GEOGRAP_LOCATION_ID');
        sbBarrio        := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'NEIGHBORTHOOD_ID');
        sbMultifamiliar := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'ZIP_CODE_ID');
        sbDirPadre      := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'ADDRESS');
        sbSolicitud     := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'PACKAGE_ID');
        sbEmail         := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');

        nuSolicitud     := to_number(sbSolicitud);
        -- Tipo de Pack
        nuTypePack := PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD(nuSolicitud);
        -- Estado del Paquete
        nuStatePack := PKG_BCSOLICITUDES.FNUGETESTADO(nuSolicitud);

        IF (nuTypePack != 323) then
            pkg_error.setErrorMessage( isbMsgErrr => 'El tipo de solicitud no es Venta a Constructoras');

        elsif(nuTypePack = 323 and nuStatePack != 13) then
            pkg_error.setErrorMessage( isbMsgErrr => 'El estado '||nuStatePack||' de la solicitud, no es valido para la asignacion de direcciones');
        end if;

        IF NOT ut_mail.fblValidateMail(sbEmail) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'Debe ingresar un Email valido.');
        END IF;

        -- SQL Dinamico para Barrio
        IF (sbBarrio is not null) then
            sbSqlBarrio := 'and  DIR.neighborthood_id='||sbBarrio;
        ELSE
            sbSqlBarrio:='';
        END IF;

        -- SQL Dinamico para Direccion Padre
        IF (sbDirPadre is not null) then
            IF PKG_BCDIRECCIONES.FNUGETLOCALIDAD(sbDirPadre) = sbLocalidad THEN
                sbSqlDirPadre := ' and  DIR.father_address_id='||sbDirPadre;
            else
                pkg_error.setErrorMessage( isbMsgErrr => 'La localidad de la direccion Padre No coincide con la Localidad seleccionada'||
                                                       ' en el criterio de busqueda por ubicacion geografica.');
            end if;
        ELSE
            sbSqlDirPadre:='';
        END IF;

        sbSql := 'select DIR.address_id cod_direccion, DIR.address_parsed direccion, PRE.premise_id predio,
                     IPRE.multivivienda cod_multifamiliar,
                     ABPRE.is_ring flag_anillo, date_ring fecha_anillo, ABPRE.is_internal flag_interna,
                     DEP.description departamento, LOC.description localidad, BAR.description Barrio,
                     SEG.operating_sector_id sector_operativo,
                     decode(DIR.father_address_id,null,'' '',PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA(DIR.father_address_id))  dir_padre
               from ab_address DIR,ge_geogra_location LOC, ge_geogra_location DEP, ge_geogra_location BAR,
                    AB_PREMISE PRE, ab_segments SEG, ldc_info_predio IPRE,ab_info_premise ABPRE
                where DIR.geograp_location_id='||sbLocalidad||
              ' and    DIR.geograp_location_id=LOC.geograp_location_id '||sbSqlBarrio||sbSqlDirPadre||
              ' and    LOC.geo_loca_father_id=DEP.geograp_location_id
                and    DEP.geograp_location_id='||sbDepartamento||
              ' and    DIR.neighborthood_id = BAR.geograp_location_id
                and not exists
                    (select ''X'' from pr_product p
                    where p.address_id= DIR.address_id
                    and product_type_id=7014
                    and PRODUCT_STATUS_ID in (1,2,15,20))
                and    DIR.estate_number = PRE.premise_id
                and    PRE.premise_id= IPRE.premise_id
                and    DIR.segment_id=SEG.segments_id
                and    IPRE.multivivienda='||sbMultifamiliar||
            ' and    ABPRE.premise_id=PRE.premise_id';

        pkg_Traza.Trace('Consulta Direcciones '||sbSql,8);

        open ocuCursor for sbSql;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

        RETURN ocuCursor;

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
    END frfgetDirecciones;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  processAssigAddress
    Descripcion :
    Autor       : llozada
    Fecha       : 22-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    17-10-2024          PAcosta            OSF-3440: Implementar Gestión de Archivos
                                            Cambio DAGE_DIRECTORY.FSBGETPATH por PKG_BCDIRECTORIOS.FSBGETRUTA
                                            Cambio OS_ADDREQUESTADDRESS por API_ADDREQUESTADDRESS
    10-07-2015          Llozada            Se cambia el log de errores por un archivo plano
                                           para que sea adjuntado en el correo.
    22-05-2014          llozada            Creaci?n.
    **************************************************************************/
    PROCEDURE processAssigAddress (inuAddressId     IN  ab_address.address_id%type,
                              inuRegistro   IN  number,
                              inuTotal      IN  number,
                              onuErrorCode  OUT number,
                              osbErrorMess  OUT varchar2) AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'processAssigAddress';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 

        sbSolicitud             ge_boInstanceControl.stysbValue;
        sbCorreo                ge_boInstanceControl.stysbValue;
        nuDirectory             ge_directory.directory_id%type;

        nuErrorCode             NUMBER;
        sbErrorMessage          VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        sbSolicitud     := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'PACKAGE_ID');
        sbCorreo        := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'E_MAIL');
        
        pkg_traza.trace('sbSolicitud|' || sbSolicitud , csbNivelTraza );
        pkg_traza.trace('sbCorreo|' || sbCorreo , csbNivelTraza );

        nuDirectory     := pkg_BCLD_Parameter.fnuObtieneValorNumerico('XML_DIR');
        sbPath          := PKG_BCDIRECTORIOS.FSBGETRUTA(nuDirectory);

        IF inuRegistro = 1 THEN
            ufArchivo       := pkg_gestionArchivos.ftAbrirArchivo_SMF(sbPath, sbFileName,'A');
            pkg_gestionArchivos.prcEscribirLinea_SMF( ufArchivo, 'Log de errores ASIMADI:');
        END IF;

        API_ADDREQUESTADDRESS(sbSolicitud,inuAddressId,nuErrorCode,sbErrorMessage) ;

        BEGIN
            IF nuErrorCode != 0 THEN
                SBERRRORES := 'Cod. Error: '||nuErrorCode||', Error: '||sbErrorMessage; /*' <br>';*/
                pkg_gestionArchivos.prcEscribirLinea_SMF( ufArchivo, SBERRRORES);
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                    sbMensajeEmail := sbMensajeEmail||sbSolicitud;

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => sbCorreo,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensajeEmail,
                        isbArchivos         => sbPath || '/' || sbFileName
                    );

        END;

        if inuRegistro = inuTotal then

            sbMensajeEmail := sbMensajeEmail||sbSolicitud;
            
            pkg_gestionArchivos.prcCerrarArchivo_SMF(ufArchivo);

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbCorreo,
                isbAsunto           => sbAsunto,
                isbMensaje          => sbMensajeEmail,
                isbArchivos         => sbPath || '/' || sbFileName
            );

        end if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

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
    end processAssigAddress;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento:  getSectorOperativo
    Descripcion :   Permite carga la localidad dinamicamente de acuerdo
                    el criterio del departamento
    Autor       :   Llozada
    Fecha       :   23-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    17-10-2024          PAcosta            OSF-3440: Implementar Gestión de Archivos
                                            Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                            Cambio GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE por PRC_OBTIENEVALORINSTANCIA
    23-05-2014          llozada            Creacion.
    ***************************************************************************/

    PROCEDURE getLocalidad(id in number, description in varchar2, rfQuery OUT CONSTANTS_PER.TYREFCURSOR) AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'getLocalidad';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    
        sbSql           varchar2(2000) := '';
        sbInstance      Ge_BOInstanceControl.stysbName;
        nuUbicacion     ge_geogra_location.geograp_location_id%type;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        ge_boinstancecontrol.getcurrentinstance(sbInstance);
        PRC_OBTIENEVALORINSTANCIA(sbInstance,Null,'GE_GEOGRA_LOCATION','GEOGRAP_LOCATION_ID',nuUbicacion);

        IF (nuUbicacion is null) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'Por Favor Seleccione un Departamento');
        END IF;

        sbSql := 'select GEOGRAP_LOCATION_ID id, DESCRIPTION description
              from GE_GEOGRA_LOCATION
              where geog_loca_area_type = 3
              and geo_loca_father_id = '||nuUbicacion;

        OPEN rfQuery FOR sbSql;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

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
    END getLocalidad;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento:  getSectorOperativo
    Descripcion :   Permite cargar el barrio dinamicamente de acuerdo
                    el criterio de la localidad
    Autor       :   Llozada
    Fecha       :   23-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    17-10-2024          PAcosta            OSF-3440: Implementar Gestión de Archivos
                                            Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                            Cambio GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE por PRC_OBTIENEVALORINSTANCIA
    23-05-2014          llozada            Creacion.
    ***************************************************************************/
    PROCEDURE getBarrio(id in number, description in varchar2, rfQuery OUT CONSTANTS_PER.TYREFCURSOR) AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'getBarrio';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
           
        sbSql           varchar2(2000) := '';
        sbInstance      Ge_BOInstanceControl.stysbName;
        nuBarrio        ge_geogra_location.geograp_location_id%type;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        ge_boinstancecontrol.getcurrentinstance(sbInstance);
        PRC_OBTIENEVALORINSTANCIA(sbInstance,Null,'AB_ADDRESS','GEOGRAP_LOCATION_ID',nuBarrio);

        IF (nuBarrio is null) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'Por Favor Seleccione una Localidad');
        END IF;

        sbSql := 'select GEOGRAP_LOCATION_ID id, DESCRIPTION description
                 from GE_GEOGRA_LOCATION
                 where geog_loca_area_type = 5
                 and geo_loca_father_id = '||nuBarrio;

        OPEN rfQuery FOR sbSql;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

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
    END getBarrio;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento:  getSectorOperativo
    Descripcion :   Permite cargar la direcci?n dinamicamente de acuerdo
                    el criterio de la localidad y departamento
    Autor       :   Llozada
    Fecha       :   23-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    17-10-2024          PAcosta            OSF-3440: Implementar Gestión de Archivos
                                            Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                            Cambio DAAB_ADDRESS.FSBGETADDRESS_PARSED por PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA
                                            Cambio GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE por PRC_OBTIENEVALORINSTANCIA
    23-05-2014          llozada            Creacion.
    ***************************************************************************/
    PROCEDURE getDirPadre(id in number, description in varchar2, rfQuery OUT CONSTANTS_PER.TYREFCURSOR) AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'getDirPadre';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        sbSql           varchar2(2000) := '';
        sbInstance      Ge_BOInstanceControl.stysbName;
        nuUbicacion     ge_geogra_location.geograp_location_id%type;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        ge_boinstancecontrol.getcurrentinstance(sbInstance);
        PRC_OBTIENEVALORINSTANCIA(sbInstance,Null,'AB_ADDRESS','GEOGRAP_LOCATION_ID',nuUbicacion);

        IF (nuUbicacion is null) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'Por Favor Seleccione la Localidad ');
        END IF;

        sbSql := 'select a.address_id id,
                  PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA(a.address_id) description
                  from ab_address a
                  where a.father_address_id is null
                  and a.GEOGRAP_LOCATION_ID = '||nuUbicacion;

        OPEN rfQuery FOR sbSql;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         

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
    END getDirPadre;

END LDC_ASIGDIRCONTRUCTORAS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ASIGDIRCONTRUCTORAS', 'ADM_PERSON');
END;
/