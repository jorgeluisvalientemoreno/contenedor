BEGIN
    MERGE INTO proceso_negocio a
    USING (
              SELECT
                  21        AS "CODIGO",
                  'SEGUROS' AS "DESCRIPCION"
              FROM
                  dual
          )
    b ON ( a.codigo = b.codigo )
    WHEN NOT MATCHED THEN
    INSERT (
        codigo,
        descripcion )
    VALUES
        ( b.codigo,
          b.descripcion )
    WHEN MATCHED THEN UPDATE
    SET a.descripcion = b.descripcion;

    COMMIT;
END;
/