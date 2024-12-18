CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_OS_REGISTERNEWCHARGE
(
    inuUnidadOperativa  in  number,
    inuItemNovedad      in  number,
    inuPersona          in  number,
    inuOrdenReferencia  in  number,
    inuValor            in  number,
    inuCantidad         in  number,
    inuTipoObservacion  in  number,
    isbObservacion      in  varchar2,
    onuErrorCode        out number,
    osbErrorMessage     out varchar2
)
AS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Proceso     : ldc_os_registernewcharge
    Descripcion : 
    Autor       : 
    Fecha       : 

    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    14/05/2024          Paola Acosta       OSF-2674: Cambio de esquema ADM_PERSON  
    **************************************************************************/
    nuIdDireccion           number;
    cnuTipoRelacionNovedad  number := 14;
BEGIN
    OS_REGISTERNEWCHARGE
    (
        inuUnidadOperativa,
        inuItemNovedad,
        inuPersona,
        inuOrdenReferencia,
        inuValor,
        inuCantidad,
        inuTipoObservacion,
        isbObservacion,
        onuErrorCode,
        osbErrorMessage
    );
    if ( onuErrorCode = 0 AND daor_order.fblexist(inuOrdenReferencia) ) then

        nuIdDireccion := daor_order.fnugetexternal_address_id(inuOrdenReferencia);

        UPDATE OR_order
        SET external_address_id = nuIdDireccion
        WHERE ORDER_id in
        (
            SELECT related_ORDER_id
            from OR_related_order
            WHERE ORDER_id = inuOrdenReferencia
              AND rela_order_type_id = cnuTipoRelacionNovedad
        );

        UPDATE OR_order_activity
        SET address_id = nuIdDireccion
        WHERE ORDER_id in
        (
            SELECT related_ORDER_id
            from OR_related_order
            WHERE ORDER_id = inuOrdenReferencia
              AND rela_order_type_id = cnuTipoRelacionNovedad
       );

    END if;

EXCEPTION
	when ex.CONTROLLED_ERROR then
		Errors.getError(onuErrorCode, osbErrorMessage);
	when others then
		Errors.setError;
		Errors.getError(onuErrorCode, osbErrorMessage);

END LDC_OS_REGISTERNEWCHARGE;
/
PROMPT Otorgando permisos de ejecucion a LDC_OS_REGISTERNEWCHARGE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_OS_REGISTERNEWCHARGE', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_OS_REGISTERNEWCHARGE para reportes
GRANT EXECUTE ON adm_person.LDC_OS_REGISTERNEWCHARGE TO rexereportes;
/