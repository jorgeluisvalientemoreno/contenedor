CREATE OR REPLACE TRIGGER adm_person.TRG_BI_LDC_PROTECCION_DATOS
/************************************************************************************************************
  Autor       :  dslatarin
  Fecha       : 27-02-2034
  Proceso     : TRG_BI_LDC_PROTECCION_DATOS
  Ticket      : OSF-912
  Descripcion : Trigger para obtener el valor del campo proteccion_datos_id

  Historia de Modificaciones
  Fecha               Autor                             Modificacion
  =========           =========                     ====================
  17/10/2024    	  jpinedc 						OSF-3383: Se migra a ADM_PERSON
 *************************************************************************************************************/
 BEFORE INSERT ON LDC_PROTECCION_DATOS
 REFERENCING NEW AS New OLD AS Old
  FOR EACH ROW
DECLARE
 nmid NUMBER;
BEGIN
 SELECT seq_ldc_proteccion_datos.NEXTVAL INTO nmid FROM DUAL;
 :NEW.PROTECCION_DATOS_ID := nmid;
EXCEPTION
 WHEN OTHERS THEN
  ERRORS.SETERROR;
  RAISE EX.CONTROLLED_ERROR;
END;
/