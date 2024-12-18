CREATE OR REPLACE PROCEDURE RC_ApplyOSICoupon
(
    nuCoupon     in         cupon.cuponume%type,
    ircInforPago in         pkCollectingMgr.tyrcInforPago,
    onuErrorCode  out       ge_error_log.error_log_id%type,
    osbErrorMessage  out nocopy ge_error_log.description%type
)
/*******************************************************************************
    Propiedad intelectual de Sincecomp. (c).

    Procedure	 :  RC_ApplyOSICoupon

    Descripción :   Plug-In para la Aplicación de Pagos con Cupones de tipo
                    SE - Seguros para Gaseras.

    Autor	    :   Karem Baquero
    Fecha       :   21-06-2013

    Parametros:
        Entrada:    nuCoupon    - Número del Cupón
                    ircInfoPago - Record con informacion adicional para registro del Pago

        Salida:     onuCodiErro - Código del Error
                    osbMensErro - Mnesaje del Error

    Historia de Modificaciones
    Autor               Fecha       Descripcion    
    kbaqueroSAO210892   21/06/2013  Creación.
    jcatuche            13/08/2024  OSF-3122 Se elimina la lógica del procedimiento
*******************************************************************************/
AS
BEGIN
    NULL;
EXCEPTION
    when OTHERS then
        NULL;
END RC_ApplyOSICoupon;
/
begin
    pkg_utilidades.prAplicarPermisos('RC_APPLYOSICOUPON','OPEN');
end;
/
GRANT EXECUTE on RC_APPLYOSICOUPON to REXEOPEN;
GRANT EXECUTE on RC_APPLYOSICOUPON to RSELSYS;
/
