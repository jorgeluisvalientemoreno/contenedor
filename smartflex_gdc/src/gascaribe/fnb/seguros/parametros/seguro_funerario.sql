BEGIN
    MERGE INTO OPEN.PARAMETROS A USING
    (SELECT
    'SEGURO_FUNERARIO' as CODIGO,
    'Lineas de producto de seguros funerarios y exequiales (LD_PRODUCT_LINE)' as DESCRIPCION,
    NULL as VALOR_NUMERICO,
    '91,131,311' as VALOR_CADENA,
    NULL as VALOR_FECHA,
    21 as PROCESO, 
    'A' as ESTADO,
    'N' as OBLIGATORIO,
    SYSDATE as FECHA_CREACION,
    SYSDATE as FECHA_ACTUALIZACION,
    'OPEN' as USUARIO,
    'NO TERMINAL' as TERMINAL
    FROM DUAL) B
    ON (A.CODIGO = B.CODIGO)
    WHEN NOT MATCHED THEN 
    INSERT (
    CODIGO, DESCRIPCION, VALOR_NUMERICO, VALOR_CADENA, VALOR_FECHA, 
    PROCESO, ESTADO, OBLIGATORIO, FECHA_CREACION, FECHA_ACTUALIZACION, 
    USUARIO, TERMINAL)
    VALUES (
    B.CODIGO, B.DESCRIPCION, B.VALOR_NUMERICO, B.VALOR_CADENA, B.VALOR_FECHA, 
    B.PROCESO, B.ESTADO, B.OBLIGATORIO, B.FECHA_CREACION, B.FECHA_ACTUALIZACION, 
    B.USUARIO, B.TERMINAL)
    WHEN MATCHED THEN
    UPDATE SET 
    A.DESCRIPCION = B.DESCRIPCION,
    A.VALOR_NUMERICO = B.VALOR_NUMERICO,
    A.VALOR_CADENA = B.VALOR_CADENA,
    A.VALOR_FECHA = B.VALOR_FECHA,
    A.PROCESO = B.PROCESO,
    A.ESTADO = B.ESTADO,
    A.OBLIGATORIO = B.OBLIGATORIO,
    A.FECHA_CREACION = B.FECHA_CREACION,
    A.FECHA_ACTUALIZACION = B.FECHA_ACTUALIZACION,
    A.USUARIO = B.USUARIO,
    A.TERMINAL = B.TERMINAL;

    COMMIT;
END;
/