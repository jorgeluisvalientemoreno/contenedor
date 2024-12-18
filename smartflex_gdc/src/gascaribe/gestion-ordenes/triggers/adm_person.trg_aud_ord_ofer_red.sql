CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AUD_ORD_OFER_RED
 AFTER INSERT OR UPDATE OR DELETE ON ldc_ordenes_ofertados_redes FOR EACH ROW

    /**************************************************************************
     Metodo:       trg_aud_ord_ofer_red

     Historia de Modificaciones
     Autor:         Olsoftware
     Fecha:         18/03/2020					Modificacion: se agrego el campo presupuesto de obra en la tabla de log ldc_audi_ord_ofer_redes
   ***************************************************************************/
DECLARE
  sboper    ldc_audi_ord_ofer_redes.oper%TYPE;
  nuconacta ge_acta.id_acta%TYPE;
  sbestado  ge_acta.estado%TYPE;
  sbmensaje VARCHAR2(500);
  eerror    EXCEPTION;
BEGIN
 sboper := NULL;
 IF inserting THEN
  sboper := 'I';
 ELSIF updating THEN
  sboper := 'U';
 ELSIF deleting THEN
  sboper := 'D';
 BEGIN
  SELECT ac.id_acta,ac.estado INTO nuconacta,sbestado
    FROM open.ct_order_certifica oc,open.ge_acta ac
   WHERE oc.order_id       = :old.orden_nieta
     AND oc.certificate_id = ac.id_acta;
 EXCEPTION
  WHEN no_data_found THEN
   nuconacta := NULL;
   sbestado  := '-';
 END;
  IF TRIM(sbestado) = 'C' THEN
   sbmensaje := 'No es posible borrar el registro de la orden nieta : '||:old.orden_nieta||' debido a que se encuentra en el acta : '||to_char(nuconacta)||' y esta se ya esta cerrada.';
   RAISE eerror;
  ELSIF TRIM(sbestado) = 'A' THEN
   sbmensaje := 'No es posible borrar el registro de la orden nieta : '||:old.orden_nieta||' debido a que se encuentra en el acta : '||to_char(nuconacta)||'. Debe primero reversar el acta antes de eliminar el registro.';
   RAISE eerror;
  END IF;
 ELSE
  sboper := '-';
 END IF;

 INSERT INTO ldc_audi_ord_ofer_redes
      VALUES(
             decode(sboper,'D',:old.orden_padre,:new.orden_padre),decode(sboper,'D',:old.orden_hija,:new.orden_hija),decode(sboper,'D',:old.orden_nieta,:new.orden_nieta)
            ,decode(sboper,'D',:old.metro_lineal,:new.metro_lineal),SYSDATE,USER,NULL,sboper,decode(sboper,'D',:old.PRESUPUESTO_OBRA,:new.PRESUPUESTO_OBRA)
            );

EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('ldc_trg_ord_des_oder_redes '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END trg_aud_ord_ofer_red;
/
