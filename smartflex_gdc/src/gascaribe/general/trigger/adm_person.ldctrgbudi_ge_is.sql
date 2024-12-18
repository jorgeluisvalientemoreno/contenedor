CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGBUDI_GE_IS
  BEFORE UPDATE OR DELETE OR INSERT ON GE_ITEMS_SERIADO
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
/*  Propiedad intelectual de Gases de Occidente
      Trigger     :   LDCTRGBUDI_GE_IS
      Descripción :   Trigger para almacenar los materiales
                      de la tabla "GE_ITEMS_SERIADO"
            separados en bodegas de Activos fijos e Inventarios.
      Autor       :   Juan C. Ramírez C. (Optima Consulting)
      Fecha       :   27-OCT-2014

      Historial de modificaciones
      Fecha             IDEntrega
      22-OCT-2014       jcramirez 
      21-OCT-2024       jpinedc     OSF-3450: Se miga a ADM_PERSON  
  */
DECLARE
  --Constantes
  csbTiBoAc CONSTANT LDC_TT_TB.warehouse_type%TYPE := 'A'; --Tipo de bodega Activos
  csbTiBoIn CONSTANT LDC_TT_TB.warehouse_type%TYPE := 'I'; --Tipo de bodega Inventarios

  --Variables
  nuErrCode  GE_ERROR_LOG.error_log_id%TYPE;
  sbErrMsg   GE_ERROR_LOG.description%TYPE;
  nuOrderId  OR_ORDER.order_id%TYPE;
  rcLdcTtTb  LDC_TT_TB%ROWTYPE;
  nuRegAfect NUMBER; --Número de registros afectado

  --cursor para validar la Recepción de Materiales de una compra
  --de materiales que viene del proveedor Logístico (SAP) la cual
  --Aplica en OR_OPE_UNI_ITEM_BALA y en GE_ITEMS_SERIADO
  cursor cuexistencia is
    select mmitnudo                              Numero_del_Documento,
           operating_unit_id                     Unidad_Operativa,
           destino_oper_uni_id                   Provedor_Logistico,
           document_type_id                      Tipo_de_Documento,
           ge_items_documento.id_items_documento Codigo_Documento
      from ldci_intemmit, ge_items_documento, GE_ITEMS_REQUEST
     where mmitnudo = to_char(GE_ITEMS_REQUEST.id_items_documento)
       and document_type_id in (102) -- Orden de Compra
       and GE_ITEMS_REQUEST.ID_ITEMS_DOCUMENTO =
           ge_items_documento.id_items_documento
       and GE_ITEMS_REQUEST.ITEMS_ID = :NEW.items_id
       and operating_unit_id = :NEW.operating_unit_id
       AND ge_items_documento.fecha =
           (select max(ge_items_documento.fecha)
              from ldci_intemmit, ge_items_documento, GE_ITEMS_REQUEST
             where mmitnudo = to_char(GE_ITEMS_REQUEST.id_items_documento)
               and document_type_id in (102) -- Orden de Compra
               and GE_ITEMS_REQUEST.ID_ITEMS_DOCUMENTO =
                   ge_items_documento.id_items_documento
               and GE_ITEMS_REQUEST.ITEMS_ID = :NEW.items_id
               and operating_unit_id = :NEW.operating_unit_id)
     group by mmitnudo,
              operating_unit_id,
              destino_oper_uni_id,
              document_type_id,
              ge_items_documento.id_items_documento;

  tempcuexistencia cuexistencia%rowtype;

  --cursor para determinar el proveedor logistico si es ACTIVO o INVENTARIO
  cursor curACTIVOINVENTARIO(nudestino_oper_uni_id ge_items_documento.destino_oper_uni_id%type) is
    select instr((select casevalo
                   from LDCI_CARASEWE
                  where casecodi = 'LST_CENTROS_SOL_ACT'
                       --and casedese = 'WS_TRASLADO_MATERIALES'),
                    and casedese = 'WS_RESERVA_MATERIALES'),
                 nudestino_oper_uni_id) LST_CENTROS_SOL_ACT,
           instr((select casevalo
                   from LDCI_CARASEWE
                  where casecodi = 'LST_CENTROS_SOL_INV'
                       --and casedese = 'WS_TRASLADO_MATERIALES'),
                    and casedese = 'WS_RESERVA_MATERIALES'),
                 nudestino_oper_uni_id) LST_CENTROS_SOL_INV
      from dual;

  tempcurACTIVOINVENTARIO curACTIVOINVENTARIO%rowtype;

  CURSOR cuTipoBodega(inuItemId  ge_items.items_id%TYPE,
                      inuOrderId or_order.order_id%TYPE) IS
    SELECT DISTINCT ltt.*
      FROM ge_items i,
           --GE_ITEMS_SERIADO gis,
           or_order       o,
           or_order_items oi,
           ldc_tt_tb      ltt
     WHERE i.items_id = :NEW.ITEMS_ID ---gis.items_id
       AND oi.items_id = i.items_id
       AND o.order_id = oi.order_id
       AND ltt.task_type_id = o.task_type_id
          --AND gis.items_id = inuItemId
       AND o.order_id = inuOrderId;

  --valida si existe el resgitro en activo
  cursor cuexiteldc_act_is is
    select *
      from ldc_act_is lAS
     where lAS.items_id = :new.items_id
       and lAS.operating_unit_id = :new.operating_unit_id;

  tempcuexiteldc_act_is cuexiteldc_act_is%rowtype;

  --valida si existe el resgitro en inventario
  cursor cuexiteldc_inv_is is
    select *
      from ldc_inv_is lIS
     where lIS.items_id = :new.items_id
       and lIS.operating_unit_id = :new.operating_unit_id;

  tempcuexiteldc_inv_is cuexiteldc_inv_is%rowtype;

BEGIN

  IF INSERTING THEN

    dbms_output.put_line('1. Inserto Item Seriado.');

    --VERIFICAR SI LA TABLA INSERTA ITEMS DE UN ORDEN LEGALIZADA. LA CUAL INDICA QUE
    --PROVIENE DE SAP
    --INSERT INTO LDC_MENSAJES VALUES ('INSERTING SAP', SYSDATE);

    --/*--Inserción de compra materiales SAP. ya que SAP inserta en la entidad sin legalizar
    --una orden ya que relaiza esto mediante la relacion de un documneto

    BEGIN
      --OBTINE EL ULTIMO DOCUMENTO CON LA FECHA DE DESPACHO MAS RECIENTE. INDICANDO
      --QUE LA SOLICITUD DE ITEMS FUE CARGADA Y SE INSERTARAN NUEVOS ITEMS PARA
      --ACTIVO O INVENTARIO. ESTO MEDIANTE EL PROVEEDOR LOGISTICO EL CUAL SE OBTIENE
      --EN ESTE CURSOR PARA SER VALIDADO Y DETERMINAR SI EL ITEM ES DEINVENTARIO O ACTIVO

      /*INSERT INTO LDC_MENSAJES
      VALUES
        (':NEW.OPERATING_UNIT_ID [' || :NEW.OPERATING_UNIT_ID ||
         '] - :NEW.ITEMS_ID [' || :NEW.ITEMS_ID || ']',
         SYSDATE);*/

      OPEN cuexistencia;
      FETCH cuexistencia
        INTO tempcuexistencia;

      dbms_output.put_line('2. Cursor cuexistencia.');

      ---
      --validar la Recepción de Materiales de una compra
      --de materiales que viene del proveedor Logístico
      IF cuexistencia%FOUND THEN
        ----
        --CURSOR PARA DETERMINAR SI EL PROVEEDOR LOGISTICO ES PARA ITEMS DE ACTIVO O INVENTARIO.
        dbms_output.put_line('3. Proveedor Logistico[' ||
                             tempcuexistencia.Provedor_Logistico || '].');
        OPEN curACTIVOINVENTARIO(tempcuexistencia.Provedor_Logistico);
        FETCH curACTIVOINVENTARIO
          INTO TEMPcurACTIVOINVENTARIO;
        CLOSE curACTIVOINVENTARIO;

        dbms_output.put_line('3. Cursor curACTIVOINVENTARIO.');

        --Inserta en entidad de Activos fijos
        --VALIDA SI EL CODIGO DEL PROVEEDOR LOGISITCO ESTABA CONFIGURADO PARA MANEJO DE ACTIVOS
        IF (TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act > 0) THEN
          dbms_output.put_line('3_1. Cursor curACTIVOINVENTARIO TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act[' ||
                               TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act || '].');

          INSERT INTO ldc_act_is
            (id_items_seriado,
             items_id,
             serie,
             estado_tecnico,
             id_items_estado_inv,
             costo,
             subsidio,
             propiedad,
             fecha_ingreso,
             fecha_salida,
             fecha_reacon,
             fecha_baja,
             fecha_garantia,
             operating_unit_id,
             numero_servicio,
             subscriber_id)
          VALUES
            (:NEW.id_items_seriado,
             :NEW.items_id,
             :NEW.serie,
             :NEW.estado_tecnico,
             :NEW.id_items_estado_inv,
             :NEW.costo,
             :NEW.subsidio,
             :NEW.propiedad,
             :NEW.fecha_ingreso,
             :NEW.fecha_salida,
             :NEW.fecha_reacon,
             :NEW.fecha_baja,
             :NEW.fecha_garantia,
             :NEW.operating_unit_id,
             :NEW.numero_servicio,
             :NEW.subscriber_id);
        END IF;

        --Inserta en entidad de Inventarios
        --VALIDA SI EL CODIGO DEL PROVEEDOR LOGISITCO ESTABA CONFIGURADO PARA MANEJO DE INVENTARIOS
        IF (TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Inv > 0) THEN
          dbms_output.put_line('3_2. Cursor curACTIVOINVENTARIO TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Inv[' ||
                               TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Inv || '].');

          INSERT INTO ldc_inv_is
            (id_items_seriado,
             items_id,
             serie,
             estado_tecnico,
             id_items_estado_inv,
             costo,
             subsidio,
             propiedad,
             fecha_ingreso,
             fecha_salida,
             fecha_reacon,
             fecha_baja,
             fecha_garantia,
             operating_unit_id,
             numero_servicio,
             subscriber_id)
          VALUES
            (:NEW.id_items_seriado,
             :NEW.items_id,
             :NEW.serie,
             :NEW.estado_tecnico,
             :NEW.id_items_estado_inv,
             :NEW.costo,
             :NEW.subsidio,
             :NEW.propiedad,
             :NEW.fecha_ingreso,
             :NEW.fecha_salida,
             :NEW.fecha_reacon,
             :NEW.fecha_baja,
             :NEW.fecha_garantia,
             :NEW.operating_unit_id,
             :NEW.numero_servicio,
             :NEW.subscriber_id);
        END IF;

      END IF;

      --COMMIT;
      CLOSE cuexistencia;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        IF (cuTipoBodega%ISOPEN) THEN
          CLOSE cuTipoBodega;
        END IF;
        nuRegAfect := 0;
        RAISE_APPLICATION_ERROR(-20994,
                                'No se encontró registro para la bodega.');
        raise;
      WHEN OTHERS THEN
        IF (cuTipoBodega%ISOPEN) THEN
          CLOSE cuTipoBodega;
        END IF;
        nuRegAfect := 0;
        RAISE_APPLICATION_ERROR(-20993,
                                'Se presentó un error registrando en bodega.');
        raise;
    END;

    --RAISE_APPLICATION_ERROR(-20995, 'No se encontró la orden instanciada.');
  END IF;

EXCEPTION
  WHEN others THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRGBUDI_GE_IS;
/
