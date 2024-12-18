CREATE OR REPLACE PACKAGE adm_person.LDC_PKCOTICOMERCONS IS
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : LDC_PKCOTICOMERCONS
  DESCRIPCION    : PAQUETE PARA AGRUPAR LOS SERVICIOS
                   DE LOS DATOS ADICIONALES PARA LAS COTIZACIONES
                   COMERCIALES / CONSTRUCTORAS
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  09/07/2024    PAcosta                 OSF-2889: Cambio de esquema ADM_PERSON 
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                 inuContratista   IN ldc_coticomercial_adic.contratista%TYPE,
                                 inuOperatingUnit IN ldc_coticomercial_adic.unidad_operativa%TYPE,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2);

  PROCEDURE proRegistraComercialItem(inuPackageId    IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                     inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                     inuIditem       IN ldc_itemscoticomer_adic.id_item%TYPE,
                                     isbClassItem    IN ldc_itemscoticomer_adic.class_item%TYPE,
                                     onuErrorCode    OUT NUMBER,
                                     osbErrorMessage OUT VARCHAR2);

  PROCEDURE proActualizaComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                  inuContratista   IN ldc_coticomercial_adic.contratista%TYPE,
                                  inuOperatingUnit IN ldc_coticomercial_adic.unidad_operativa%TYPE,
                                  onuErrorCode     OUT NUMBER,
                                  osbErrorMessage  OUT VARCHAR2);

  PROCEDURE proActualizaComercialItem(inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                      inuIditem       IN ldc_itemscoticomer_adic.id_item%TYPE,
                                      isbClassItem    IN ldc_itemscoticomer_adic.class_item%TYPE,
                                      isbOperacion    IN VARCHAR2,
                                      onuErrorCode    OUT NUMBER,
                                      osbErrorMessage OUT VARCHAR2);

  PROCEDURE proCargaComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                              onuContratista   OUT ldc_coticomercial_adic.contratista%TYPE,
                              onuOperatingUnit OUT ldc_coticomercial_adic.unidad_operativa%TYPE,
                              onuErrorCode     OUT NUMBER,
                              osbErrorMessage  OUT VARCHAR2);

  PROCEDURE proRegistraConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                    inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                    inuContratista   IN ldc_coticonstructora_adic.contratista%TYPE,
                                    inuOperatingUnit IN ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                    onuErrorCode     OUT NUMBER,
                                    osbErrorMessage  OUT VARCHAR2);

  PROCEDURE proRegistraConstructoraItem(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                        inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                        inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                        isbTipoItem     IN ldc_itemscoticonstru_adic.tipo_item%TYPE,
                                        inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                        isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                        onuErrorCode    OUT NUMBER,
                                        osbErrorMessage OUT VARCHAR2);

  PROCEDURE proActualizaConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                     inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                     inuContratista   IN ldc_coticonstructora_adic.contratista%TYPE,
                                     inuOperatingUnit IN ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                     onuErrorCode     OUT NUMBER,
                                     osbErrorMessage  OUT VARCHAR2);

  PROCEDURE proActualizaConstructoraItem(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                         inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                         inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                         isbTipoItem     IN ldc_itemscoticonstru_adic.tipo_item%TYPE,
                                         inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                         isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                         isbOperacion    IN VARCHAR2,
                                         onuErrorCode    OUT NUMBER,
                                         osbErrorMessage OUT VARCHAR2);

  PROCEDURE proCargaConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                 inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                 onuContratista   OUT ldc_coticonstructora_adic.contratista%TYPE,
                                 onuOperatingUnit OUT ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2);

  PROCEDURE proRegistraItemValFijos(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                    inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                    inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                    inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                    isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2);

  PROCEDURE proActualizaItemValFijos(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                     inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                     inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                     inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                     isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                     isbOperacion    IN VARCHAR2,
                                     onuErrorCode    OUT NUMBER,
                                     osbErrorMessage OUT VARCHAR2);

  PROCEDURE proRegistraItemMetraje(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                   inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                   inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                   isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2);

  PROCEDURE proActualizaItemMetraje(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                    inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                    inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                    isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                    isbOperacion    IN VARCHAR2,
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2);

END LDC_PKCOTICOMERCONS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKCOTICOMERCONS IS

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : LDC_PKCOTICOMERCONS
  DESCRIPCION    : PAQUETE PARA AGRUPAR LOS SERVICIOS
                   DE LOS DATOS ADICIONALES PARA LAS COTIZACIONES
                   COMERCIALES / CONSTRUCTORAS
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/

  ---------------------
  --Variables Generales
  ---------------------
  csbOperacionBorrar     CONSTANT VARCHAR2(2) := 'D';
  csbOperacionActualizar CONSTANT VARCHAR2(2) := 'U';

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proRegistraComercial
  DESCRIPCION    : Servicio que registra datos adicionales
                   de la cotizacion comercial
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                 inuContratista   IN ldc_coticomercial_adic.contratista%TYPE,
                                 inuOperatingUnit IN ldc_coticomercial_adic.unidad_operativa%TYPE,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2) AS
  BEGIN

    --Se guardan datos adicionales de la cotizacion.
    INSERT INTO ldc_coticomercial_adic
      (id_cot_comercial, contratista, unidad_operativa)
    VALUES
      (inuPackageId, inuContratista, inuOperatingUnit);

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraComercial;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proRegistraComercialItem
  DESCRIPCION    : Servicio para registrar datos adicionales a los items
                   de una cotizacion comercial
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraComercialItem(inuPackageId    IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                     inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                     inuIditem       IN ldc_itemscoticomer_adic.id_item%TYPE,
                                     isbClassItem    IN ldc_itemscoticomer_adic.class_item%TYPE,
                                     onuErrorCode    OUT NUMBER,
                                     osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    --Se guardan datos adicionales a los items de la cotizacion.
    INSERT INTO ldc_itemscoticomer_adic
      (consecutivo, id_cot_comercial, id_item, class_item)
    VALUES
      (seq_ldc_items_cotizacion_com.currval,
       inuPackageId,
       inuIditem,
       UPPER(isbClassItem));

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraComercialItem;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proActualizaComercial
  DESCRIPCION    : Servicio para actualizar datos adicionales
                   de una cotizacion comercial
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proActualizaComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                                  inuContratista   IN ldc_coticomercial_adic.contratista%TYPE,
                                  inuOperatingUnit IN ldc_coticomercial_adic.unidad_operativa%TYPE,
                                  onuErrorCode     OUT NUMBER,
                                  osbErrorMessage  OUT VARCHAR2) AS
  BEGIN

    --Se Actualizan datos adicionales de la cotizacion.
    UPDATE ldc_coticomercial_adic
       SET contratista         = inuContratista,
           unidad_operativa    = inuOperatingUnit,
           fecha_actualizacion = sysdate
     WHERE id_cot_comercial = inuPackageId;

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaComercial;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proActualizaComercialItem
  DESCRIPCION    : Servicio para adicionar datos adcionales de los items
                   de una cotizacion comercial
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proActualizaComercialItem(inuConsecutivo  IN ldc_itemscoticomer_adic.consecutivo%TYPE,
                                      inuIditem       IN ldc_itemscoticomer_adic.id_item%TYPE,
                                      isbClassItem    IN ldc_itemscoticomer_adic.class_item%TYPE,
                                      isbOperacion    IN VARCHAR2, --Operacion
                                      onuErrorCode    OUT NUMBER,
                                      osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    IF (isbOperacion = csbOperacionActualizar) THEN

      --Se Actualizan datos adicionales al item
      UPDATE ldc_itemscoticomer_adic
         SET id_item             = inuIditem,
             class_item          = isbClassItem,
             fecha_actualizacion = sysdate
       WHERE consecutivo = inuConsecutivo;

    ELSIF (isbOperacion = csbOperacionBorrar) THEN

      --Se borran datos adicionales al item
      DELETE FROM ldc_itemscoticomer_adic
       WHERE consecutivo = inuConsecutivo;

    END IF;

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaComercialItem;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proCargaComercial
  DESCRIPCION    : servicio que carga los datos adicionales de una
                   cotizacion comercial
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proCargaComercial(inuPackageId     IN ldc_coticomercial_adic.id_cot_comercial%TYPE,
                              onuContratista   OUT ldc_coticomercial_adic.contratista%TYPE,
                              onuOperatingUnit OUT ldc_coticomercial_adic.unidad_operativa%TYPE,
                              onuErrorCode     OUT NUMBER,
                              osbErrorMessage  OUT VARCHAR2) AS
  BEGIN

    --Se obtiene datos de la cotizacion
    BEGIN
      SELECT contratista, unidad_operativa
        INTO onuContratista, onuOperatingUnit
        FROM ldc_coticomercial_adic
       WHERE id_cot_comercial = inuPackageId;
      onuErrorCode    := 0;
      osbErrorMessage := 'OK';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        onuContratista   := 0;
        onuOperatingUnit := 0;
        onuErrorCode     := -1;
        osbErrorMessage  := 'NO POSEE INFORMACION';
    END;

  EXCEPTION
    WHEN OTHERS THEN
      onuContratista   := 0;
      onuOperatingUnit := 0;
      onuErrorCode     := -1;
      osbErrorMessage  := UPPER('Error registrando datos adicionales: ' ||
                                SQLERRM);
      RETURN;
  END proCargaComercial;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proRegistraConstructora
  DESCRIPCION    : Servicio que registra datos adicionales de una cotizacion
                   de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                    inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                    inuContratista   IN ldc_coticonstructora_adic.contratista%TYPE,
                                    inuOperatingUnit IN ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                    onuErrorCode     OUT NUMBER,
                                    osbErrorMessage  OUT VARCHAR2) AS
  BEGIN

    --Se guardan datos adicionales de la cotizacion constructora.
    INSERT INTO ldc_coticonstructora_adic
      (id_cotizacion, id_proyecto, contratista, unidad_operativa)
    VALUES
      (inuPackageId, inuProyecto, inuContratista, inuOperatingUnit);

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraConstructora;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proRegistraConstructoraItem
  DESCRIPCION    : Registra items fijos de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraConstructoraItem(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                        inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                        inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                        isbTipoItem     IN ldc_itemscoticonstru_adic.tipo_item%TYPE,
                                        inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                        isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                        onuErrorCode    OUT NUMBER,
                                        osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    --Se guardan datos adicionales.
    INSERT INTO ldc_itemscoticonstru_adic
      (id_cotizacion,
       id_proyecto,
       id_item,
       tipo_item,
       tipo_trab,
       class_item)
    VALUES
      (inuPackageId,
       inuProyecto,
       inuIditem,
       UPPER(isbTipoItem),
       inuTipoTrab,
       UPPER(isbClassItem));

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraConstructoraItem;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proActualizaConstructora
  DESCRIPCION    : actualiza datos adicionales de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proActualizaConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                     inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                     inuContratista   IN ldc_coticonstructora_adic.contratista%TYPE,
                                     inuOperatingUnit IN ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                     onuErrorCode     OUT NUMBER,
                                     osbErrorMessage  OUT VARCHAR2) AS
  BEGIN

    --Se Actualizan datos adicionales.
    UPDATE ldc_coticonstructora_adic
       SET contratista         = inuContratista,
           unidad_operativa    = inuOperatingUnit,
           fecha_actualizacion = sysdate
     WHERE id_cotizacion = inuPackageId
       AND id_proyecto = inuProyecto;

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaConstructora;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proActualizaConstructoraItem
  DESCRIPCION    : actualiza item fijos de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proActualizaConstructoraItem(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                         inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                         inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                         isbTipoItem     IN ldc_itemscoticonstru_adic.tipo_item%TYPE,
                                         inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                         isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                         isbOperacion    IN VARCHAR2, --Operacion
                                         onuErrorCode    OUT NUMBER,
                                         osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    IF (isbOperacion = csbOperacionActualizar) THEN

      --Se Actualizan datos adicionales.
      UPDATE ldc_itemscoticonstru_adic
         SET id_item             = inuIditem,
             class_item          = isbClassItem,
             fecha_actualizacion = sysdate
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto
         AND id_item = inuIditem
         AND tipo_item = isbTipoItem
         AND tipo_trab = inuTipoTrab;

    ELSIF (isbOperacion = csbOperacionBorrar) THEN

      --Se borran datos adicionales al item
      DELETE FROM ldc_itemscoticonstru_adic
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto
         AND id_item = inuIditem
         AND tipo_item = isbTipoItem
         AND tipo_trab = inuTipoTrab;

    END IF;

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaConstructoraItem;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proCargaConstructora
  DESCRIPCION    : carga informacion adicional de la cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proCargaConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                 inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                 onuContratista   OUT ldc_coticonstructora_adic.contratista%TYPE,
                                 onuOperatingUnit OUT ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2) AS
  BEGIN

    --Se obtiene datos de la cotizacion
    BEGIN
      SELECT contratista, unidad_operativa
        INTO onuContratista, onuOperatingUnit
        FROM ldc_coticonstructora_adic
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto;
      onuErrorCode    := 0;
      osbErrorMessage := 'OK';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        onuContratista   := 0;
        onuOperatingUnit := 0;
        onuErrorCode     := -1;
        osbErrorMessage  := 'NO POSEE INFORMACION';
    END;

  EXCEPTION
    WHEN OTHERS THEN
      onuContratista   := 0;
      onuOperatingUnit := 0;
      onuErrorCode     := -1;
      osbErrorMessage  := UPPER('Error registrando datos adicionales: ' ||
                                SQLERRM);
      RETURN;
  END proCargaConstructora;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proRegistraItemValFijos
  DESCRIPCION    : registra datos adiconales de los items con valores fijos
                   de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraItemValFijos(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                    inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                    inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                    inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                    isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    --Se guardan datos adicionales.
    INSERT INTO ldc_itemscotivalfijos_adic
      (id_cotizacion, id_proyecto, id_item, tipo_trab, class_item)
    VALUES
      (inuPackageId,
       inuProyecto,
       inuIditem,
       inuTipoTrab,
       UPPER(isbClassItem));

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraItemValFijos;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proActualizaItemValFijos
  DESCRIPCION    : actualiza datos adiconales de los items con valores fijos
                   de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proActualizaItemValFijos(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                     inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                     inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                     inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                     isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                     isbOperacion    IN VARCHAR2, --Operacion
                                     onuErrorCode    OUT NUMBER,
                                     osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    IF (isbOperacion = csbOperacionActualizar) THEN

      --Se Actualizan datos adicionales.
      UPDATE ldc_itemscotivalfijos_adic
         SET id_item             = inuIditem,
             class_item          = isbClassItem,
             fecha_actualizacion = sysdate
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto
         AND id_item = inuIditem
         AND tipo_trab = inuTipoTrab;

    ELSIF (isbOperacion = csbOperacionBorrar) THEN

      --Se borran datos adicionales al item
      DELETE FROM ldc_itemscotivalfijos_adic
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto
         AND id_item = inuIditem
         AND tipo_trab = inuTipoTrab;

    END IF;

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaItemValFijos;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proRegistraItemMetraje
  DESCRIPCION    : registra datos adiconales de los items x metraje
                   de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proRegistraItemMetraje(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                   inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                   inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                   isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    --Se guardan datos adicionales.
    INSERT INTO ldc_itemscotimetraje_adic
      (id_cotizacion, id_proyecto, id_item, class_item)
    VALUES
      (inuPackageId, inuProyecto, inuIditem, UPPER(isbClassItem));

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraItemMetraje;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).

  UNIDAD         : proActualizaItemMetraje
  DESCRIPCION    : actualiza datos adiconales de los items x metraje
                   de una cotizacion de constructoras
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 15/07/2018
  REQ            : 200-1640

  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  15/07/2018    Sebastian Tapias        REQ.2001640 Creacion
  ******************************************************************/
  PROCEDURE proActualizaItemMetraje(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                    inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                    inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                    isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                    isbOperacion    IN VARCHAR2, --Operacion
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2) AS
  BEGIN

    IF (isbOperacion = csbOperacionActualizar) THEN

      --Se Actualizan datos adicionales.
      UPDATE ldc_itemscotimetraje_adic
         SET id_item             = inuIditem,
             class_item          = isbClassItem,
             fecha_actualizacion = sysdate
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto
         AND id_item = inuIditem;

    ELSIF (isbOperacion = csbOperacionBorrar) THEN

      --Se borran datos adicionales al item
      DELETE FROM ldc_itemscotimetraje_adic
       WHERE id_cotizacion = inuPackageId
         AND id_proyecto = inuProyecto
         AND id_item = inuIditem;

    END IF;

    onuErrorCode    := 0;
    osbErrorMessage := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaItemMetraje;

END LDC_PKCOTICOMERCONS;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKCOTICOMERCONS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKCOTICOMERCONS', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_PKCOTICOMERCONS para reportes
GRANT EXECUTE ON adm_person.LDC_PKCOTICOMERCONS TO rexereportes;
/