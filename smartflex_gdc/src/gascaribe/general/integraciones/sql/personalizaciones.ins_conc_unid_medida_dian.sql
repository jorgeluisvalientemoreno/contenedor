MERGE INTO personalizaciones.conc_unid_medida_dian A 
USING
    (SELECT
        983                as CONCEPTO_ID,
        'KWH'              as UNIDAD_MEDIDA,
        'Kilovatios Hora'  as DESCRIPCION
     FROM DUAL) B
ON (A.CONCEPTO_ID = B.CONCEPTO_ID)
WHEN NOT MATCHED THEN 
    INSERT (CONCEPTO_ID, UNIDAD_MEDIDA, DESCRIPCION)
    VALUES (983,         'KWH',         'Kilovatios Hora')
WHEN MATCHED THEN
    UPDATE SET 
      A.UNIDAD_MEDIDA = B.UNIDAD_MEDIDA,
      A.DESCRIPCION   = B.DESCRIPCION
/
COMMIT
/
