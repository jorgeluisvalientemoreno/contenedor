CREATE OR REPLACE TRIGGER ADM_PERSON.trg_Bala_Mov_val_del_ser
/********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-03-22
    Descripcion : Validamos que no se permita las devoluciones, si el serial no existe en la tabla
                 ldci_seridmit

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR       DESCRIPCION
    21/10/2024  jpinedc     OSF-3450: Se migra a ADM_PERSON
*********************************************************************************************************/
    AFTER INSERT ON Or_Uni_Item_Bala_Mov
REFERENCING old AS old new AS new for each row
DECLARE
 nucontaprovlog  NUMBER(5);
 nucontaitemser  NUMBER(5);
 nudocumentodevo NUMBER(5);
 nucontaserial   NUMBER(5);
 sbserialdev     ge_items_seriado.serie%TYPE;
BEGIN
 -- Consultamos si es proveedor logistico
 SELECT COUNT(1) INTO nucontaprovlog
   FROM or_operating_unit c
  WHERE c.operating_unit_id = :new.target_oper_unit_id
    AND c.oper_unit_classif_id = 11;

 -- Consultamos si el item es seriado
 SELECT COUNT(1) INTO nucontaitemser
   FROM ge_items i
  WHERE i.items_id = :new.items_id
    AND i.item_classif_id = 21;

 -- Consultamos si es un documento de devolucion
 SELECT COUNT(1) INTO nudocumentodevo
   FROM ge_items_documento d
  WHERE d.id_items_documento = :new.id_items_documento
    AND d.document_type_id   = 105;

 -- Validamos que sea una devolucion y que hayan items seriados
 IF nucontaprovlog >= 1 AND nucontaitemser >= 1 AND nudocumentodevo >= 1 THEN
    SELECT COUNT(1) INTO nucontaserial
      FROM ge_items_seriado k,ldci_seridmit s
     WHERE k.id_items_seriado = :new.id_items_seriado
       AND k.serie            = s.serinume;
     IF nucontaserial = 0 THEN
      BEGIN
       SELECT k.serie INTO sbserialdev
         FROM ge_items_seriado k
        WHERE k.id_items_seriado = :new.id_items_seriado;
      EXCEPTION
       WHEN no_data_found THEN
        sbserialdev := 'NO-EXISTE';
      END;
      IF TRIM(sbserialdev) <> 'NO-EXISTE' THEN
        errors.seterror(2741,'El items seriado con nro : '||sbserialdev||' no fue despachado desde SAP, no es posible registrar la devolución');
        Raise ex.controlled_error;
      ELSIF TRIM(sbserialdev) = 'NO-EXISTE' THEN
        errors.seterror(2741,'El items seriado con nro : '||to_char(:new.id_items_seriado)||' no tiene serie asociada, VALIDAR INFORMACION');
        Raise ex.controlled_error;
      END IF;
     END IF;
 END IF;
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;
/
