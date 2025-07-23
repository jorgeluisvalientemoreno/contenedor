/*******************************************************************************
    Método:         titr_requiere_contrato.sql
    Descripción:    Tipo de trabajo para validación de contrato en cambio de ciclo 
    Autor:          jcatuche
    Fecha:          16/12/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    16/12/2024      jcatuche            OSF-3758: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'TITR_REQUIERE_CONTRATO' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        '12134,12130,10539' as VALOR_CADENA,
        'Tipos de Trabajo que requieren contrato' as DESCRIPCION,
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
        B.CODIGO, B.VALOR_NUMERICO, B.VALOR_FECHA, B.VALOR_CADENA, B.DESCRIPCION, B.PROCESO, pkg_session.getUser,pkg_session.fsbgetTerminal, SYSDATE
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