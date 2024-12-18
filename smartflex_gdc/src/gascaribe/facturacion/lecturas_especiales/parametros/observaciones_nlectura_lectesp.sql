/*******************************************************************************
    Método:         observaciones_nlectura_lectesp.sql
    Descripción:    Parámetro para observaciones de no lectucta a validar para clientes especiales
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          18/09/2023

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    18/09/2023      jcatuchemvm         OSF-1440: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'OBSERVACIONES_NLECTURA_LECTESP' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        '79' as VALOR_CADENA,
        'Observaciones de no lectura a validar para clientes especiales OSF-1440' as DESCRIPCION,
        16 as PROCESO
        FROM DUAL
    ) B
    ON (A.CODIGO = B.CODIGO)
    WHEN NOT MATCHED THEN 
    INSERT 
    (
        CODIGO, VALOR_NUMERICO, VALOR_FECHA, VALOR_CADENA, DESCRIPCION, PROCESO, USUARIO, TERMINAL, FECHA_CREACION
    )
    VALUES 
    (
        B.CODIGO, B.VALOR_NUMERICO, B.VALOR_FECHA, B.VALOR_CADENA, B.DESCRIPCION, B.PROCESO, USER,USERENV('TERMINAL'), SYSDATE
    )
    WHEN MATCHED THEN
    UPDATE SET 
        A.VALOR_NUMERICO        = B.VALOR_NUMERICO,
        A.VALOR_FECHA           = B.VALOR_FECHA,
        A.VALOR_CADENA          = B.VALOR_CADENA,
        A.DESCRIPCION           = B.DESCRIPCION,
        A.PROCESO               = B.PROCESO,
        A.FECHA_ACTUALIZACION   = SYSDATE
    ;
    
    COMMIT;
    
END;
/