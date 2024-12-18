CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_DATOVAL_TITRCAUS BEFORE INSERT
/********************************************************************************************************
 Autor       : John Jairo Jimenez Marimon
 Fecha       : 2021-11-10
 caso        : CA-884
 Descripcion : CA-884 - Trigger para campos de auditoria

 HISTORIA DE MODIFICACIONES
 FECHA        AUTOR   DESCRIPCION
**********************************************************************************************************/
  ON ldc_datoval_titrcaus FOR EACH ROW
BEGIN
  :new.usuario := user;
  :new.fecha   := sysdate;
EXCEPTION
 WHEN OTHERS THEN
  raise_application_error(-20000,'Error en el trigger : TRG_LDC_DATVAL_TITRCAUS. Error : '||SQLERRM);
END;
/
