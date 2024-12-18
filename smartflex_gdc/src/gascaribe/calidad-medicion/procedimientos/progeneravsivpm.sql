CREATE OR REPLACE PROCEDURE PROGENERAVSIVPM (inuProducto        IN NUMBER,
                                             inuMedidor         IN VARCHAR2,
                                             inuFechUltCamMed   IN DATE)
IS
    /**************************************************************
    Propiedad intelectual Horbath.
    Unidad      :  PROGENERAVSIVPM
    Descripcion :  Este servicio será el que se relacionará con el reporte proceso para generar una solicitud de VSI.
    Caso: 132

    Autor       :  Daniel Valiente
    Fecha       :  09/12/2020
    Parametros  :

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    17/11/2023   epenao             OSF-1761:
                                    +Cambios proyecto Organización:
                                    +Cambio uso de objeto ge_bopersonal
                                    por el personalizado: pkg_bopersonal.
                                    +Cambio tipo de la variable para almacenar 
                                    el XML por l tipo personalizado constants_per.TIPO_XML_SOL%type
                                    +Cambio de la creación manual del XML para 
                                    usar el generado en el método: pkg_xml_soli_vsi.getSolicitudVSI
                                    +Cambio del métoro OS_RegisterRequestWithXML por
                                    el personalizado API_RegisterRequestByXML  
                                    +Cambio del manejo de errores por el personalizado
                                    pkg_Error. 
                                    +Adición gestión de traza personalizada. 
                                    +Eliminación de varaibles declaradas y no usadas. 

    ***************************************************************/
    csbMetodo          VARCHAR2 (4000) := 'PROGENERAVSIVPM';
    inuIdAddress       NUMBER;
    NuContrato         NUMBER;
    onuErrorCode       NUMBER;
    sbRequestXML       constants_per.TIPO_XML_SOL%type;
    nuPackageId        NUMBER;
    nuMotiveId         NUMBER;
    sbmensa            VARCHAR2 (10000);
    inuContactId       NUMBER;
    sbObserva          VARCHAR2 (4000);
    nuPtoAtncndsol     NUMBER;
    -- se agrega variable que se encarga de guarda el valor que devuelve
    --el procedimiento para obtener el punto de atencion actual del usuario*
    actVSI             NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE ('LDCPARACTVSI', NULL);
    nuMedioRecepcion   NUMBER := dald_parameter.fnugetnumeric_value ('PARMEDIORCPVSI', NULL);
    nuPersonIdsol      NUMBER := pkg_bopersonal.fnugetpersonaid;

    CURSOR cuDatos IS
        SELECT PR.ADDRESS_ID, PR.SUBSCRIPTION_ID, s.SUSCCLIE
          FROM PR_PRODUCT PR, SUSCRIPC s
         WHERE     PR.SUBSCRIPTION_ID = S.SUSCCODI
               AND PR.PRODUCT_ID = inuProducto
               AND ROWNUM = 1;
BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    onuErrorCode := 0;

    OPEN cuDatos;

    FETCH cuDatos INTO inuIdAddress, NuContrato, inuContactId;

    CLOSE cuDatos;

    --se consulta punto de atencion con el nuevo procedimiento
    nuPtoAtncndsol := pkg_bopersonal.fnugetpuntoatencionid(nuPersonIdsol);


    IF actVSI IS NOT NULL
    THEN
        sbObserva := dald_parameter.fsbGetValue_Chain ('COMVENSERINGVPM');
        --P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101
        sbRequestXML := pkg_xml_soli_vsi.getSolicitudVSI
                                        (  inuContratoID       => null, 
                                          inuMedioRecepcionId => nuMedioRecepcion, 
                                          isbComentario       => sbObserva, 
                                          inuProductoId       => inuProducto, 
                                          inuClienteId        => inuContactId, 
                                          inuPersonaID        => nuPersonIdsol, 
                                          inuPuntoAtencionId  => nuPtoAtncndsol, 
                                          idtFechaSolicitud   => SYSDATE, 
                                          inuAddressId        => inuIdAddress, 
                                          inuTrabajosAddressId=> inuIdAddress, 
                                          inuActividadId      => actVSI
                                        );

        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);
        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   onuErrorCode,
                                   sbmensa);
        pkg_traza.trace('nuPackageId:'||nuPackageId||'-nuMotiveId:'||nuMotiveId,pkg_traza.cnuNivelTrzDef);                                   

        IF nupackageid IS NULL
        THEN
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        ELSE
            --La lógica y desarrollo se encargará de generar la solicitud VSI para el producto 
            --seleccionado en el reporte proceso. Si genera la solicitud VSI la información de los 
            --parámetros será registrada en la entidad REGMEDIVSI. Caso 132
            INSERT INTO REGMEDIVSI (CONTRATO,
                                    PRODUCTO,
                                    FECHA_REGISTRO,
                                    MEDIDOR,
                                    FECHA_ULT_CAMB_MEDI,
                                    PACKAGE_ID_VSI)
                 VALUES (NuContrato,
                         inuProducto,
                         SYSDATE,
                         inuMedidor,
                         inuFechUltCamMed,
                         nupackageid);
        END IF;
    ELSE

        pkg_Error.setErrorMessage (2741,
                                   'No existe actividad configurada, validar parametros LDCPARACTVSI');
        RAISE PKG_ERROR.CONTROLLED_ERROR;
    END IF;
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR
    THEN
        pkg_Error.GETERROR (onuErrorCode, sbmensa);
        pkg_traza.trace('onuErrorCode:'||onuErrorCode||'-onuErrorCode:'||sbmensa,pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE;
    WHEN OTHERS
    THEN
        sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
        pkg_Error.seterror;
        pkg_traza.trace('sbmensa:'||sbmensa,pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        RAISE PKG_ERROR.CONTROLLED_ERROR;
END PROGENERAVSIVPM;
/

PROMPT Asignación de permisos para el paquete PROGENERAVSIVPM
begin
  pkg_utilidades.prAplicarPermisos('PROGENERAVSIVPM', 'OPEN');
end;
/
