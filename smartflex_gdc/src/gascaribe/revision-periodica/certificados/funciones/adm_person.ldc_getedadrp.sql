CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_GETEDADRP" 
(
    inuProduct_id  LDC_PLAZOS_CERT.id_producto%type
)
RETURN NUMBER
IS

    nuMesesRevision number := dald_parameter.fnuGetNumeric_Value('LDC_MESES_VALIDEZ_CERT');
    nuEdadProd      number; --(4);  Aranda 7303

    CURSOR cuEdad(producto_id LDC_PLAZOS_CERT.id_producto%type,nuMesesCert number)
    IS
        select nuMesesCert - months_between(trunc(to_date(plazo_maximo),'MONTH'),trunc(sysdate,'MONTH'))
        from LDC_PLAZOS_CERT
        where id_producto = producto_id;
BEGIN

    OPEN cuEdad(inuProduct_id,nuMesesRevision);
    FETCH cuEdad INTO nuEdadProd;
    CLOSE cuEdad;

    IF nuEdadProd IS NOT NULL THEN
        RETURN nuEdadProd;
    ELSE
        RETURN null;
    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END ldc_getEdadRP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GETEDADRP', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_GETEDADRP TO REXEREPORTES;
/