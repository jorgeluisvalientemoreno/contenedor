CREATE OR REPLACE TRIGGER ADM_PERSON.trg_aiuor_order_activity 
AFTER INSERT OR UPDATE OF ORDER_ID ON OR_ORDER_ACTIVITY
/**********************************************************************************************************************
    Historia de Modificaciones
    Fecha           Autor       Caso        Descripcion
    07/02/2022      JJJM        CA-873      Bloquear la orden se suspension administrativa por XML
                                            para asignacion
    21/10/2024      jpinec      OSF-3450    Se migra a ADM_PERSON
**********************************************************************************************************************/
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
WHEN (old.order_id IS NULL AND new.order_id IS NOT NULL)
DECLARE
 inusolicitud         mo_packages.package_id%TYPE;
 rgldc_ordentramiterp ldc_ordentramiterp%ROWTYPE;
 sw                   VARCHAR2(1);
 osberrormessage      ge_error_log.description%TYPE;
 nuerror              NUMBER(2);
BEGIN
 IF (GE_BOEmergencyOrders.fblIsEmergencyAct(:new.activity_id)) THEN
      GE_BOEmergencyOrders.RegisterEmergency
      (
       :new.order_id
      );
 END IF;
 -- Inicio JJJM CA-873
 nuerror := -1;
 IF (fblAplicaEntregaxCaso('0000873')) THEN
  sw := '1';
  -- Si la orden es supension administrativa, consultamos si la solicitud es 100156
  nuerror := -2;
  IF :new.task_type_id = 10450 THEN
   BEGIN
    SELECT m.package_id INTO inusolicitud
      FROM mo_packages m
     WHERE m.package_id      = :new.package_id
       AND m.package_type_id = 100156;
   EXCEPTION
    WHEN no_data_found THEN
     inusolicitud := NULL;
   END;
   nuerror := -3;
  END IF;
  -- Validamos si encontr? solicitud
  nuerror := -4;
  IF inusolicitud IS NOT NULL THEN
   -- Consultamos datos tramite revision periodica
   BEGIN
    SELECT z.* INTO rgldc_ordentramiterp
      FROM ldc_ordentramiterp z
     WHERE z.solicitud = inusolicitud
       AND rownum = 1;
   EXCEPTION
    WHEN no_data_found THEN
     sw := '0';
     rgldc_ordentramiterp.unidadopera := NULL;
   END;
   nuerror := -5;
   -- Si encontr? registro, bloqueamos asignacion de la orden
   IF sw = '1' THEN
    -- Insertamos la solicitud a bloquear asignacion
    INSERT INTO ldc_bloq_lega_solicitud(
                                         package_id_orig
                                        ,package_id_gene
                                       )
                                VALUES(
                                       NULL
                                      ,inusolicitud
                                      );
    nuerror := -6;
    -- Insertamos orden a bloquear asignacion
    INSERT INTO ldc_ordeasigproc(
                                 oraporpa
                                ,orapsoge
                                ,oraopele
                                ,oraounid
                                ,oraocale
                                ,oraoitem
                                ,oraoproc
                                )
                         VALUES(
                                :new.order_id
                               ,rgldc_ordentramiterp.solicitud
                               ,NULL
                               ,rgldc_ordentramiterp.unidadopera
                               ,rgldc_ordentramiterp.causal
                               ,NULL
                               ,'ASIGAUTRP'
                               );
    nuerror := -7;
   END IF;
  END IF;
  nuerror := -8;
 END IF;
 -- Fin JJJM CA-873
EXCEPTION
 WHEN OTHERS THEN
  osberrormessage := 'Linea : '||nuerror||' '||SQLERRM;
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osberrormessage);
  ut_trace.trace('trg_aiuor_order_activity '||' '||SQLERRM, 11);
END trg_aiuor_order_activity;
/
