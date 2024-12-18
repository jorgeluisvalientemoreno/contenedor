/*******************************************************************************
    Método:         actividad_lectespgele.sql
    Descripción:    Parámetro para validar actividad de ordenes de lectura de ciclos especiales y telemedidos
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          19/02/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    19/02/2024      jcatuchemvm         OSF-350: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'ACTIVIDAD_LECTESPGELE' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        '100009163,102008' as VALOR_CADENA,
        'Actividades para validar tipos de trabajo de lecturas ciclos especiales en LECTESPGELE' as DESCRIPCION,
        4 as PROCESO
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