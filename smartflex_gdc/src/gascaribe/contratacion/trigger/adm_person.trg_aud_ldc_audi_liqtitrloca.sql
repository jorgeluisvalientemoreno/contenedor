CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AUD_LDC_AUDI_LIQTITRLOCA
/********************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-09-02
    Descripcion : trigger que registra informacion en la tabla ldc_audi_liqtitrloca siempre que se modifique un registro en la tabla ldc_liqtitrloca

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*********************************************************************************************************************************************************/
 AFTER INSERT OR UPDATE OR DELETE ON ldc_liqtitrloca FOR EACH ROW
DECLARE
  sboper    ldc_audi_liqtitrloca.operacion%TYPE;
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
 INSERT INTO ldc_audi_liqtitrloca(
                                   tipo_cont_adm
                                  ,actividad_pago
                                  ,item_pago
                                  ,departamento
                                  ,localidad
                                  ,porcentaje_fijo
                                  ,fecha
                                  ,usuario
                                  ,operacion
                                  )
      VALUES(
             DECODE(sboper,'D',:old.tipo_contrato_adm ,:new.tipo_contrato_adm)
            ,DECODE(sboper,'D',:old.actividad_pago ,:new.actividad_pago)
            ,DECODE(sboper,'D',:old.item_pago ,:new.item_pago)
            ,DECODE(sboper,'D',:old.departamento,:new.departamento)
            ,DECODE(sboper,'D',:old.localidad,:new.localidad)
            ,DECODE(sboper,'D',:old.porcentaje_fijo,:new.porcentaje_fijo)
            ,SYSDATE
            ,USER
            ,sboper
            );
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('trg_aud_ldc_audi_liqtitrloca '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END trg_aud_ldc_audi_liqtitrloca;
/
