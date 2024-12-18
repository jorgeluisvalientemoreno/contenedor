CREATE OR REPLACE TRIGGER ADM_PERSON.trgAF_AB_ADDRESS
AFTER INSERT ON OPEN.AB_ADDRESS

/**************************************************************
Propiedad intelectual PETI (c).

Trigger    :  trgAF_AB_ADDRESS

Descripcion    : Crea una orden cuando la dirección no existe en la tabla

Autor    : Álvaro Zapata
Fecha    : 19-11-2013

Historia de Modificaciones
Fecha          IDEntrega           Modificación
**************************************************************/


DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
    cnuUSER_NO_ALLOW    constant ge_message.message_id%type := 901343;

    inuActivity         OR_ORDER_ACTIVITY.ACTIVITY_ID%type;
    inuParsedAddressId  OR_ORDER_ACTIVITY.ADDRESS_ID%type;
    idtExecDate         date;
    isbComment          or_order_comment.order_comment%type;
    inuReferenceValue   number;
    inuOrderId          or_order.order_id%type;
    onuErrorCode        number;
    osbErrorMessage     varchar2(2000);


Cursor crDirecciones is
       SELECT ACTIVITY_ID, ADDRESS_ID, FECHA, COMENTARIO, REFERENCIA_VALUE,GEOGRAP_LOCATION_ID
       FROM  LDC_TMP_OT_GIS;

BEGIN
    ut_trace.trace('trgAF_AB_ADDRESS',1);

FOR rcCursor in crDirecciones loop

    inuactivity:=           rcCursor.ACTIVITY_ID;
    inuparsedaddressid:=    rcCursor.ADDRESS_ID;
    idtexecdate:=           rcCursor.FECHA;
    isbcomment:=            rcCursor.COMENTARIO;
    inureferencevalue:=     rcCursor.REFERENCIA_VALUE;

       -- Se crea la orden y la actividad
       os_createorderactivities (inuactivity, inuparsedaddressid, sysdate, isbcomment, inureferencevalue, inuorderid, onuerrorcode, osberrormessage);

end loop;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END trgAF_AB_ADDRESS ;
/
