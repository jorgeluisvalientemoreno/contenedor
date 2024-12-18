CREATE OR REPLACE TRIGGER ADM_PERSON.ldctrg_mo_pack_revision
  BEFORE INSERT ON mo_packages
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual HORBART S.A.S.

  Trigger  :  ldctrg_mo_pack_sol_fnb

  Descripción  : Valida actualización del medio de recepción.

  Autor  :
  Fecha  : 21-07-2016

  Historia de Modificaciones
  21/10/2024    jpinedc     OSF-345: Se migra a ADM_PERSON
  **************************************************************/
DECLARE
 nuvartipsolrp ld_parameter.numeric_value%TYPE;
 nuconta       NUMBER(10);
BEGIN
 nuvartipsolrp := dald_parameter.fnuGetNumeric_Value('SOLICITUD_VISITA',NULL );
 IF :new.package_type_id = nuvartipsolrp THEN
  SELECT COUNT(1) INTO nuconta
    FROM open.or_order ot,open.or_order_activity oa
   WHERE ot.task_type_id = dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_VISITA_IDEN')
     AND ot.order_status_id IN(dald_parameter.fnuGetNumeric_Value('ESTADO_REGISTRADO'),dald_parameter.fnuGetNumeric_Value('ESTADO_ASIGNADO'))
     AND oa.product_id = (
                          SELECT mp.product_id
                            FROM mo_motive mp
                           WHERE mp.package_id = :new.package_id
                          )
     AND ot.order_id = oa.order_id;
   IF nuconta >= 1 THEN
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Producto ya tiene una ot de revision generada.');
   END IF;
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/
