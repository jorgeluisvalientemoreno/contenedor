CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AUD_LDC_AUDI_VEHICULOS
/**************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-09-02
    Descripcion : trigger que registra informacion en la tabla ldc_audi_vehiculos siempre que se modifique un registro en la tabla ldc_liqvehiuno

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
***************************************************************************************************************************************************/
 AFTER INSERT OR UPDATE OR DELETE ON ldc_liqvehiuno FOR EACH ROW
DECLARE
  sboper    ldc_audi_vehiculos.operacion%TYPE;
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
 INSERT INTO ldc_audi_vehiculos(
                                departamento
                               ,localidad
                               ,unidad_operativa
                               ,placa_vehiculo
                               ,fecha
                               ,usuario
                               ,operacion
                               )
      VALUES(
             DECODE(sboper,'D',:old.departamento,:new.departamento)
            ,DECODE(sboper,'D',:old.localidad,:new.localidad)
            ,DECODE(sboper,'D',:old.unidad_operativa,:new.unidad_operativa)
            ,DECODE(sboper,'D',:old.placa_vehiculo,:new.placa_vehiculo)
            ,SYSDATE
            ,USER
            ,sboper
            );
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('trg_aud_ldc_audi_vehiculos '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END TRG_AUD_LDC_AUDI_VEHICULOS;
/
