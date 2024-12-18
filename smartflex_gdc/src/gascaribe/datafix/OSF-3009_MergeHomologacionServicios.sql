/*******************************************************************************
    Método:         OSF-3009_MergeHomologacionServicios.sql
    Descripción:    Inserta registro para homologación
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          08/07/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR            DESCRIPCION
    26/07/2024      jcatuche         OSF-3009: Creación
*******************************************************************************/

BEGIN
    MERGE INTO homologacion_servicios A USING
    (
        SELECT
        'OPEN' as ESQUEMA_ORIGEN,
        'LDC_CONFIGURACIONRQ' SERVICIO_ORIGEN,
        'Validación si la entrega aplica en el ambiente de ejecución.' DESCRIPCION_ORIGEN,
        'N/A' ESQUEMA_DESTINO,
        'VER OBSERVACIÓN' SERVICIO_DESTINO,
        'VER OBSERVACIÓN' DESCRIPCION_DESTINO,
'--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el
Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:
     if dc_configuracionrq.aplicaparaXXXXX(nucaso) then
         ---hace x, y, z
     else 
         ---hace abc 
     end if;
En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es true
se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional.
Si retorna false se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.' OBSERVACION
        FROM DUAL
    ) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT 
    (
        ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
    )
    VALUES 
    (
        B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
    )
    WHEN MATCHED THEN
    UPDATE SET 
        A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
        A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
        A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
        A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
        A.OBSERVACION           = B.OBSERVACION
    ;
    
    COMMIT;
    
END;
/