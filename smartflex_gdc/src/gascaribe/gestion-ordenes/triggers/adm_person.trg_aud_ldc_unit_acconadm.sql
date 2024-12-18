CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AUD_LDC_UNIT_ACCONADM
/*******************************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-09-02
    Descripcion : trigger que registra informacion en la tabla ldc_audi_unit_act_conadm siempre que se modifique un registro en la tabla ldc_unitoper_tipotra_conamd

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
********************************************************************************************************************************************************************/
 AFTER INSERT OR UPDATE OR DELETE ON ldc_unitoper_tipotra_conamd FOR EACH ROW
DECLARE
  sboper    ldc_audi_unit_act_conadm.operacion%TYPE;
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
 ELSE
  sboper := '-';
 END IF;
 INSERT INTO ldc_audi_unit_act_conadm(
                                      tipo_contrato_admin
                                     ,unidad_trabajo_comodin
                                     ,actividad_contadm
                                     ,actividad_pago
                                     ,item_pago
                                     ,departamento
                                     ,localidad
                                     ,fecha
                                     ,usuario
                                     ,operacion
                                     )
                              VALUES(
                                     decode(sboper,'D',:old.tipo_contrato_admin,:new.tipo_contrato_admin)
                                    ,decode(sboper,'D',:old.unidad_trabajo_comodin,:new.unidad_trabajo_comodin)
                                    ,decode(sboper,'D',:old.actividad_contadm,:new.actividad_contadm)
                                    ,decode(sboper,'D',:old.actividad_pago,:new.actividad_pago)
                                    ,decode(sboper,'D',:old.item_pago,:new.item_pago)
                                    ,decode(sboper,'D',:old.departamento,:new.departamento)
                                    ,decode(sboper,'D',:old.localidad,:new.localidad)
                                    ,SYSDATE
                                    ,USER
                                    ,sboper
                                    );
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('trg_aud_ldc_unit_acconadm '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END TRG_AUD_LDC_UNIT_ACCONADM;
/
