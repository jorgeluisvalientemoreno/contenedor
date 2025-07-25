BEGIN

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'PR_BOPRODUCT.FNUGETPRODBYSUSCANDTYPE' as SERVICIO_ORIGEN,
      'Obtiene Producto por contrato y Tipo de producto' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_BOGESTION_PRODUCTO.FNUOBTPRODUCTOPORCONTRATOYTIPO' as SERVICIO_DESTINO,
      'Obtiene Producto por contrato y Tipo de producto' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'PR_BOCREATIONPRODUCT.REGISTER' as SERVICIO_ORIGEN,
      'Regista producto' as DESCRIPCION_ORIGEN,
      'PERSONALIZACIONES' as ESQUEMA_DESTINO,
      'PKG_BSGESTION_PRODUCTO.PRCREGISTRAPRODUCTOYCOMPONENTE' as SERVICIO_DESTINO,
      'Registra producto y componente' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;


    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'PR_BOCREATIONCOMPONENT.REGISTER' as SERVICIO_ORIGEN,
      'Registra componente' as DESCRIPCION_ORIGEN,
      'PERSONALIZACIONES' as ESQUEMA_DESTINO,
      'PKG_BSGESTION_PRODUCTO.PRCREGISTRAPRODUCTOYCOMPONENTE' as SERVICIO_DESTINO,
      'Registra producto y componente' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
      A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN,
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAPR_PRODUCT.FRCGETRECORD' as SERVICIO_ORIGEN,
      'Obtiene el registro completo de producto' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_PRODUCTO.FRCOBTIENEREGISTRO' as SERVICIO_DESTINO,
      NULL as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
      A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN,
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAPS_PROD_MOTIVE_COMP.GETRECORDS' as SERVICIO_ORIGEN,
      'Obtiene tabla pl de PS_PROD_MOTIVE_COMP' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_PS_PROD_MOTIVE_COMP.PRCOBTIENEREGISTROS' as SERVICIO_DESTINO,
      NULL as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
      A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN,
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'PS_BOPRODUCTMOTIVE.FNUGETPRODMOTIVEBYTAGNAME' as SERVICIO_ORIGEN,
      'Obtiene el Motivo por tag_name' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_BOGESTIONESTRUCTURA_PROD.FNUOBTIENEMOTIVOPORNOMBRETAG' as SERVICIO_DESTINO,
      NULL as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
      A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN,
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;
    
    COMMIT;

END;
/