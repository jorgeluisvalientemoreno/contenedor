DECLARE

    sbRequestXML1     constants_per.tipo_xml_sol%TYPE;
    nuMotiveId        mo_motive.motive_id%TYPE;
    nuPackageId       mo_packages.package_id%TYPE;
    osbErrorMessage   VARCHAR2 (4000);
    onuErrorCode      NUMBER;
BEGIN
    sbRequestXML1 :=   pkg_xml_soli_aten_cliente.getSolitudActualizaDatosPredio
    (
        67596918,--inuContratoId        IN NUMBER,
        1,--inuMedioRecepcionId  IN mo_packages.reception_type_id%TYPE,
        3290591,--inuContactoId        IN NUMBER,
        4992353,--inuDireccion         IN ab_address.address_id%TYPE,
        'PRUEBA',--isbComentario        IN mo_packages.comment_%TYPE,
        3,--inuRelaSoliPredio    IN NUMBER,
        4992353,--inuDirecInstalacion  IN ab_address.address_id%TYPE,
        4992353,--inuDirecEntregaFact  IN ab_address.address_id%TYPE,
        null,---inuDirecInstaSoli    IN ab_address.address_id%TYPE,
        null,--inuDirecEntFacSoli   IN ab_address.address_id%TYPE,
        2,--inuSubcategoria      IN NUMBER,
        471,--inuResolucion        IN NUMBER,
        'Y',--isbDocumentacion     IN VARCHAR2,
        null--inuRespuesta         IN NUMBER
    );

  pkg_traza.trace ('sbRequestXML1' || sbRequestXML1, pkg_traza.cnuNivelTrzDef);

    api_registerRequestByXml  (sbRequestXML1,
                               nuPackageId,
                               nuMotiveId,
                               onuErrorCode,
                               osbErrorMessage);
                               
    DBMS_OUTPUT.PUT_LINE('sbRequestXML1 '||sbRequestXML1);
    DBMS_OUTPUT.PUT_LINE('nuPackageId '||nuPackageId);
    DBMS_OUTPUT.PUT_LINE('nuMotiveId '||nuMotiveId);


    IF onuErrorCode <> 0
    THEN

    DBMS_OUTPUT.PUT_LINE('onuErrorCode '||onuErrorCode);
    DBMS_OUTPUT.PUT_LINE('osbErrorMessage '||osbErrorMessage);
    ELSE
        COMMIT;
    END IF;
END;
