CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AUD_LDC_TIPOCON_ADMIN
/******************************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-09-02
    Descripcion : trigger que registra informacion en la tabla ldc_tipocon_admin_audi siempre que se modifique un registro en la tabla ldc_tipocon_administrativo

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
********************************************************************************************************************************************************************/
 AFTER INSERT OR UPDATE OR DELETE ON ldc_tipocon_administrativo FOR EACH ROW
DECLARE
  sboper    ldc_tipocon_admin_audi.operacion%TYPE;
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
 INSERT INTO ldc_tipocon_admin_audi(
                                    id_tipocontrato,descripcion,actividad,item_pago,es_contrato_vehi
                                   ,unidad_operativa,valor_principal,valor_adicional
                                   ,fecha_creacion,usuario,operacion
                                   )
                            VALUES(
                                   decode(sboper,'D',:old.id_tipocontrato,:new.id_tipocontrato)
                                  ,decode(sboper,'D',:old.descripcion,:new.descripcion)
                                  ,decode(sboper,'D',:old.actividad,:new.actividad)
                                  ,decode(sboper,'D',:old.item_pago,:new.item_pago)
                                  ,decode(sboper,'D',:old.es_contrato_vehi,:new.es_contrato_vehi)
                                  ,decode(sboper,'D',:old.unidad_operativa,:new.unidad_operativa)
                                  ,decode(sboper,'D',:old.valor_principal,:new.valor_principal)
                                  ,decode(sboper,'D',:old.valor_adicional,:new.valor_adicional)
                                  ,SYSDATE
                                  ,USER
                                  ,sboper
                                  );
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('trg_aud_ldc_tipocon_admin '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END TRG_AUD_LDC_TIPOCON_ADMIN;
/
